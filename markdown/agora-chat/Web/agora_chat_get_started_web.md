# Agora Chat 快速入门

即时通讯将各地人们连接在一起，实现实时通信。利用 Agora Chat SDK，你可以在任何地方的任何设备上的任何应用中嵌入实时通讯。

本文介绍如何集成 Agora 即时通讯 Web SDK，实现发送和接收单聊消息。

## 技术原理

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Windows 或 macOS 计算机，需满足以下要求：
  - Agora 即时通讯 SDK 支持的浏览器
    - Internet Explorer 9 以上版本
    - FireFox 10 以上版本
    - Chrome 54 以上版本
    - Safari 6 以上版本
  - 可连接到互联网。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/AgoraPlatform/firewall?platform=Web)以正常使用 Agora 服务。
  - 已安装 Xcode（仅适用于 macOS）

- [Node.js 和 npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

## 项目设置

在本节中，我们准备了将 Agora Chat 集成到你的 app 中所需的开发环境。

1. 若为新的 web 项目，创建名为 `agora_quickstart` 目录。在终端中打开该目录，运行 `npm init`。此时，该目录下会创建 `package.json` 文件。然后创建以下文件：  

   - `index.html`：设置 Web 应用的用户界面；
   - `index.js`：包含消息发送和接收逻辑的实现代码。

   现在，该项目目录的结构如下：

   ```text
   agora_quickstart
   ├─ index.html
   ├─ index.js
   └─ package.json
   ```

2. 通过 npm 在你的项目中集成 Agora 即时通讯 SDK。要集成该 SDK，在 `package.json` 的 `dependencies` 字段中添加 `agora-chat-sdk` 及其版本号。

   ```json
   {
    "name": "web",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1"
    },
    "dependencies": {
      "agora-chat": "latest"
    },
    "author": "",
    "license": "ISC"
   }
   ```

## 实现发送和接收单聊消息

本节介绍如何使用 Agora 即时通讯 SDK 在你的应用中实现单聊消息的发送与接收。

### 创建 UI

将以下代码复制到 `index.html` 文件中实现客户端用户界面。

<script src="./dist/bundle.js"></script> 用于访问 webpack 打包的 bundle.js 文件。webpack 的示例配置如下所示：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Agora Chat Examples</title>
    <script src="./dist/bundle.js"></script>
</head>

<body>
    <h2 class="left-align">Agora Chat Examples</h5>
        <form id="loginForm">
            <div class="col" style="min-width: 433px; max-width: 443px">
                <div class="card" style="margin-top: 0px; margin-bottom: 0px;">
                    <div class="row card-content" style="margin-bottom: 0px; margin-top: 10px;">
                        <div class="input-field">
                            <label>Username</label>
                            <input type="text" placeholder="Username" id="userID">
                        </div>
                        <div class="input-field">
                            <label>Password</label>
                            <input type="passward" placeholder="Password" id="password">
                        </div>
                        <div class="row">
                            <div>
                                <button type="button" id="register">Register</button>
                                <button type="button" id="login">Login</button>
                                <button type="button" id="logout">Logout</button>
                            </div>
                        </div>
                        <div class="input-field">
                            <label>Peer username</label>
                            <input type="text" placeholder="Peer username" id="peerId">
                        </div>
                        <div class="input-field">
                            <label>Peer Message</label>
                            <input type="text" placeholder="Peer message" id="peerMessage">
                            <button type="button" id="send_peer_message">send</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <hr>

        <div id="log"></div>
</body>

</html>
```

### 实现发送与接收消息

参考以下步骤实现发送和接收单聊消息：

1. 导入 Agora 即时通讯 SDK。将以下代码复制到 `index.js` 文件：

   ```javascript
   // Javascript
   // 为避免浏览器兼容问题，该示例利用导入命令导入 SDK，利用 webpack 打包 JavaScript 文件。
   import WebIM from 'agora-chat'
   ```

   若要使用 typescript，采用以下代码：

   ```javascript
    // Typescript
    // import WebIM, { AgoraChat } from 'agora-chat'
   ```

2. 利用 Agora 即时通讯 SDK 中提供的核心方法实现发送和接收单聊消息。复制以下代码，添加到 `index.js` 文件中的导入功能的后面。

   ```javascript
    var username, password;
    // 初始化 Web 客户端
    WebIM.conn = new WebIM.connection({
        appKey: "41117440#383391",
    });
    // 添加事件处理器
    WebIM.conn.addEventHandler("connection&message", {
        // app 与 Agora 即时通讯成功连接的回调
        onConnected: () => {
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("Connect success !");
        },
        // app 与 Agora 即时通讯断开连接的回调
        onDisconnected: () => {
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("Logout success !");
        },
        // 收到文本消息的回调
        onTextMessage: (message) => {
            console.log(message);
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("Message from: " + message.from + " Message: " + message.msg);
        },
        // Token 即将过期的回调
        onTokenWillExpire: (params) => {
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("Token is about to expire");
            refreshToken(username, password);
        },
        // Token 过期时触发的回调。
       // 你需要从你的 App Server 中获取新的 token，然后重新登录 Agora 即时通讯系统。
        onTokenExpired: (params) => {
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("The token has expired");
            refreshToken(username, password);
        },
        onError: (error) => {
            console.log("on error", error);
        },
    });
   
    // 从 App Server 获得 token
    function refreshToken(username, password) {
        postData("https://a41.chat.agora.io/app/chat/user/login", {
            userAccount: username,
            userPassword: password,
        }).then((res) => {
            let agoraToken = res.accessToken;
            WebIM.conn.renewToken(agoraToken);
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("Token has been updated");
        });
    }
    // 发送 token 请求
    function postData(url, data) {
        return fetch(url, {
            body: JSON.stringify(data),
            cache: "no-cache",
            headers: {
                "content-type": "application/json",
            },
            method: "POST",
            mode: "cors",
            redirect: "follow",
            referrer: "no-referrer",
        }).then((response) => response.json());
    }
   
    // 定义按钮的功能
    window.onload = function () {
        // 注册
        document.getElementById("register").onclick = function () {
            username = document.getElementById("userID").value.toString();
            password = document.getElementById("password").value.toString();
            // 1. 通过 token 进行用户认证
            postData("https://a41.chat.agora.io/app/chat/user/register", {
                userAccount: username,
                userPassword: password,
            })
                .then((res) => {
                    document
                        .getElementById("log")
                        .appendChild(document.createElement("div"))
                        .append(`register user ${username} success`);
                })
                .catch((res) => {
                    document
                        .getElementById("log")
                        .appendChild(document.createElement("div"))
                        .append(`${username} already exists`);
                });
        };
        // 登录 Agora 即时通讯系统
        document.getElementById("login").onclick = function () {
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("Logging in...");
            username = document.getElementById("userID").value.toString();
            password = document.getElementById("password").value.toString();
            // 1. 进行 token 认证
            postData("https://a41.chat.agora.io/app/chat/user/login", {
                userAccount: username,
                userPassword: password,
            })
                .then((res) => {
                    let agoraToken = res.accessToken;
                    let easemobUserName = res.chatUserName;
                    WebIM.conn.open({
                        user: easemobUserName,
                        agoraToken: agoraToken,
                    });
                })
                .catch((res) => {
                    document
                        .getElementById("log")
                        .appendChild(document.createElement("div"))
                        .append(`Login failed`);
                });
        };
   
        // 登出
        document.getElementById("logout").onclick = function () {
            WebIM.conn.close();
            document
                .getElementById("log")
                .appendChild(document.createElement("div"))
                .append("logout");
        };
   
        // 发送单聊消息
        document.getElementById("send_peer_message").onclick = function () {
            let peerId = document.getElementById("peerId").value.toString();
            let peerMessage = document.getElementById("peerMessage").value.toString();
            let option = {
                chatType: "singleChat", // 将会话类型设置为单聊
                type: "txt", // 设置消息类型
                to: peerId, // 设置消息接收方的用户 ID
                msg: peerMessage, // 设置消息内容
            };
            let msg = WebIM.message.create(option);
            WebIM.conn
                .send(msg)
                .then((res) => {
                    console.log("send private text success");
                    document
                        .getElementById("log")
                        .appendChild(document.createElement("div"))
                        .append("Message send to: " + peerId + " Message: " + peerMessage);
                })
                .catch(() => {
                    console.log("send private text fail");
                });
        };
    };
   ```

## 测试你的 app

本文利用 [webpack](https://webpack.js.org/) 对项目进行打包，通过 `webpack-dev-server` 命令运行项目。

参考以下步骤创建和运行项目：

1. 在 `package.json` 文件中，在 `dependencies` 字段中添加 `webpack`、`webpack-cli` 和 `webpack-dev-server`，在 `scripts` 字段中添加 `build` 和 `start:dev` 命令。

   ```json
   {
     "name": "web",
     "version": "1.0.0",
     "description": "",
     "main": "index.js",
     "scripts": {
       "test": "echo \"Error: no test specified\" && exit 1",
       "build": "webpack --config webpack.config.js",
       "start:dev": "webpack serve --open --config webpack.config.js"
     },
     "keywords": [],
     "author": "",
     "license": "ISC",
     "dependencies": {
       "agora-chat": "latest",
       "agora-rtc-sdk-ng": "^4.6.3"
     },
     "devDependencies": {
       "webpack": "^5.50.0",
       "webpack-cli": "^4.8.0",
       "webpack-dev-server": "^3.11.2"
     }
   }
   ```

2. 配置 webpack。将以下代码复制到新文件 `webpack.config.js`：

   ```javascript
   const path = require('path');
   
   module.exports = {
       entry: './index.js',
       mode: 'production',
       output: {
           filename: 'bundle.js',
           path: path.resolve(__dirname, './dist'),
       },
       devServer: {
           compress: true,
           port: 9000,
           https: true
       }
   };
   ```

   现在，项目目录的结构如下：

   ```text
    agora_quickstart
    ├─ index.html
    ├─ index.js
    ├─ package.json
    └─ webpack.config.js
   ```

3. 运行以下命令，安装依赖项：

   ```shell
   npm install
   ```

4. 运行以下命令，利用 webpack 构建和运行项目：

   ```shell
   # 使用 webpack 打包项目
   npm run build
   
   # 使用 webpack-dev-server 运行项目
   npm run start:dev
   ```

你的浏览器会自动打开以下页面：

![img](https://web-cdn.agora.io/docs-files/1637830121772)

按以下步骤验证你刚刚通过 Agora 即时通讯在你的 Web app 中集成的发送和接收单聊消息的实现： 

1. 创建账户，点击 **register**。

2. 利用你刚刚创建的账户，登录 app。

   ![img](https://web-cdn.agora.io/docs-files/1635240354287)

3. 在新窗口打开同一页面，创建新账户。确保输入的用户 ID 和密码唯一。

4. 发送单聊消息。

   ![img](https://web-cdn.agora.io/docs-files/1635240394167)

## 后续步骤

在生产环境中，最好获取 token 登录 Agora。要了解如何实现服务器按需生成和提供 token，请参阅[生成用户 Token](./generate_user_tokens)。

## 参考

除了使用 npm 将 Agora 即时通讯 SDK 集成到你项目中外，你还可以手动下载 [Agora Chat Web SDK](https://www.npmjs.com/package/agora-chat)。

1. 在 SDK 文件夹中，在 `libs` 文件夹中找到 JS 文件，将其保存到你的项目目录。

2. 在你的项目目录中打开 HTML 文件，添加以下代码查看 JS 文件。

```javascript
<script src="path to the JS file"></script>
```