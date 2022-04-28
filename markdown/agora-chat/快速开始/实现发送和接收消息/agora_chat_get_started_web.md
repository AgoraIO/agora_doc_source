本文介绍如何通过少量代码集成 Agora 即时通讯 SDK，在你的 Web 应用中实现一对一文本消息发送和接收。

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Windows 或 macOS 计算机，需满足以下要求：

  - Agora 即时通讯 SDK 支持的浏览器。
    - Internet Explorer 9 以上版本
    - FireFox 10 以上版本
    - Chrome 54 以上版本
    - Safari 6 以上版本
  - 可连接到互联网。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/AgoraPlatform/firewall?platform=Web)以正常使用 Agora 服务。
  - 已安装 Xcode（仅适用于 macOS）

- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

## 准备开发环境

按照以下步骤准备开发环境：

### 创建 Web 项目

在本地文件夹中为你的 Web 项目新建一个目录，并命名为 `agora_quickstart`。一个 Web 客户端项目至少需包含以下文件：

- `index.html`: 用于设计 Web 应用的用户界面。
- `index.js`: 用于实现点对点消息功能的 JavaScript 的代码。
- `package.json`: 安装并管理项目依赖。你可以通过命令行进入 agora_quickstart 目录并运行 `npm init` 命令来创建 `package.json` 文件。

### 集成 Agora 即时通讯 SDK

通过 npm 将 Agora 即时通讯 SDK 集成到你的项目中。在 `package.json` 文件的 `dependencies` 字段中添加 `agora-chat` 及版本号：

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

## 实现发送和接收消息

本节介绍如何使用 Agora 即时通讯 SDK 在你的 app 中实现发送和接收一对一文本消息。

### 创建用户界面

将以下代码复制到 `index.html` 文件中，实现客户端用户界面：

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

### 实现发送和接收一对一文本消息

将以下示例代码复制到 `index.js` 文件中，实现实现创建用户、登录和登出、发送和接收一对一文本消息等逻辑。

> 本示例使用 JavaScript 引入类型声明， 如需使用 TypeScript，请将 import 命令替换为如下代码：
```ts
import WebIM, { AgoraChat } from 'agora-chat';
```

```js
// 为了避免浏览器兼容问题，本示例使用 import 命令导入 SDK。
import WebIM from "agora-chat";

var username, password;
// 初始化客户端。
WebIM.conn = new WebIM.connection({
  appKey: "41117440#383391",
});
// 添加回调函数。
WebIM.conn.addEventHandler("connection&message", {
  // 连接成功。
  onConnected: () => {
    document
      .getElementById("log")
      .appendChild(document.createElement("div"))
      .append("Connect success !");
  },
  // 连接断开。
  onDisconnected: () => {
    document
      .getElementById("log")
      .appendChild(document.createElement("div"))
      .append("Logout success !");
  },
  // 收到文本消息。
  onTextMessage: (message) => {
    console.log(message);
    document
      .getElementById("log")
      .appendChild(document.createElement("div"))
      .append("Message from: " + message.from + " Message: " + message.msg);
  },
  // Token 即将过期回调。
  onTokenWillExpire: (params) => {
    document
      .getElementById("log")
      .appendChild(document.createElement("div"))
      .append("Token is about to expire");
    refreshToken(username, password);
  },
  // Token 过期时触发该回调，你需要从应用服务器获取新的 Token 并重新登录。
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

// 从应用服务器获取 Token。
function refreshToken(username, password) {
  postData("https://a41.easemob.com/app/chat/user/login", {
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
// 发送获取 Token 请求。
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

// 定义按钮行为。
window.onload = function () {
  // 注册。
  document.getElementById("register").onclick = function () {
    username = document.getElementById("userID").value.toString();
    password = document.getElementById("password").value.toString();
    // 1. Token 鉴权。
    postData("https://a41.easemob.com/app/chat/user/register", {
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
    // 2. 使用用户名和密码注册用户。
    // WebIM.conn.registerUser({username, password})
    // document.getElementById("log").appendChild(document.createElement('div')).append("register user "+username)
  };
  // 登录。
  document.getElementById("login").onclick = function () {
    document
      .getElementById("log")
      .appendChild(document.createElement("div"))
      .append("Logging in...");
    username = document.getElementById("userID").value.toString();
    password = document.getElementById("password").value.toString();
    // 1. Token 鉴权。
    postData("https://a41.easemob.com/app/chat/user/login", {
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
    // 2. 使用用户名和密码登录。
    // WebIM.conn.open({
    //     user: username,
    //     pwd: password,
    // });
  };

  // 登出。
  document.getElementById("logout").onclick = function () {
    WebIM.conn.close();
    document
      .getElementById("log")
      .appendChild(document.createElement("div"))
      .append("logout");
  };

  // 发送一条单聊消息。
  document.getElementById("send_peer_message").onclick = function () {
    let peerId = document.getElementById("peerId").value.toString();
    let peerMessage = document.getElementById("peerMessage").value.toString();
    let option = {
      chatType: "singleChat", // 会话类型，设置为单聊。
      type: "txt", // 消息类型。
      to: peerId, // 消息接收方（用户 ID)。
      msg: peerMessage, // 消息内容。
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

本文使用 [webpack](https://webpack.js.org/) 打包项目，使用 `webpack-dev-server` 运行项目。

按照以下步骤测试你的 app：

1. 在 `package.json` 的 `dependencies` 字段中添加 `webpack`、`webpack-cli` 和 `webpack-dev-server` 字段，在 `scripts` 字段中添加 `build` 和 `start:dev`。

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

2. 在项目目录中创建一个名为 `webpack.config.js` 的文件，用于配置 webpack。将以下代码复制到文件中：

```js
const path = require("path");

module.exports = {
  entry: "./index.js",
  mode: "production",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "./dist"),
  },
  devServer: {
    compress: true,
    port: 9000,
    https: true,
  },
};
```

3. 在项目根目录运行以下命令，安装依赖项：

```shell
npm install
```

4. 运行以下命令，使用 webpack 构建并运行项目：

```shell
# 使用 webpack 打包
$ npm run build

# 使用 webpack-dev-server 运行项目
$ npm run start:dev
```

你的浏览器会自动打开以下页面：
![](https://web-cdn.agora.io/docs-files/1642511543104)

按照以下步骤发送和接收一对一文本消息：：

1. 输入用户名和密码，点击 **register** 注册，并点击 **login** 登录 Agora 即时通讯系统。
2. 在新窗口打开同一页面，输入不同的用户名和密码，注册并登录 Agora 即时通讯系统。
3. 在 **Peer username** 框中输入消息发送对象的用户名，在 **Peer Message** 框中输入消息，点击 **send** 发送消息。

## 后续步骤

文中示例仅作为演示和测试用途。在生产环境中，为保障通信安全，你需要自行部署服务器签发 Token，详见[使用 User Token 鉴权](./generate_user_tokens?platform=Web)。

## 更多信息

- 我们在 GitHub 上提供一个开源的[示例项目](https://github.com/AgoraIO/API-Examples-Web/tree/main/Demo)供你参考。

- 除上文介绍的使用 npm 获取 Agora 即时通讯 SDK 之外，你还可以通过以下方法获取 SDK：

1.  下载 [Agora 即时通讯 SDK](./downloads?platform=Web)。将 `libs` 中的 JS 文件保存到你的项目下。
2.  在 HTML 文件中，对 JS 文件进行引用。

```js
<script src="path to the JS file"></script>
```