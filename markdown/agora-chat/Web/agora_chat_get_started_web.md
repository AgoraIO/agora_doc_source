# Agora Chat 快速入门

即时通讯将各地人们连接在一起，实现实时通信。利用 Agora Chat SDK，你可以在任何地方的任何设备上的任何应用中嵌入实时通讯。

本文介绍如何通过示例代码集成 Agora 即时通讯 SDK，在你的 Android app 中实现发送和接收单聊文本消息。

## 技术原理

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-账号)。
- 带有[开启了 Chat 服务](./enable_agora_chat)的 [App Key](./enable_agora_chat#获取即时通讯项目信息) 的 Agora [项目](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-项目)。
- Windows 或 macOS 计算机，需满足以下要求：
  - Agora 即时通讯 SDK 支持的浏览器
    - Internet Explorer 9 以上版本
    - FireFox 10 以上版本
    - Chrome 54 以上版本
    - Safari 6 以上版本
  - 可连接到互联网。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](./AgoraPlatform/firewall)以正常使用 Agora 服务。
  - 已安装 Xcode（仅适用于 macOS）

- [Node.js 和 npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

## 生成 Token

### 注册用户

参考以下步骤注册用户：

1. 在**项目管理**页面，点击你要使用的项目的**操作**一栏中的**配置**按钮。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

3. 在左侧导航栏，选择**运营管理** > **用户**，点击**创建IM用户**。

![](https://web-cdn.agora.io/docs-files/1670827634437)

![](./images/quickstart/user_mgmt.png)

4. 在**创建IM用户**对话框中，填写用户信息并点击保存，创建用户。

![](https://web-cdn.agora.io/docs-files/1670827653548)

![](./images/quickstart/create_user.png)

### 生成 Token

为了保证通信安全，Agora 推荐使用 token 对登录即时通讯 IM 的用户进行认证。

出于测试目的，Agora 控制台支持为即时通讯 IM 生成临时 Token。要生成用户令牌，请执行以下操作：

1. 在**项目管理**页面，点击你要使用的项目的**操作**一栏中的**配置**按钮。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

3. 在**应用信息**页面的**Data Center**区域，在 **Chat User Temp Token** 框中输入用户 ID，点击 **Generate** 生成一个具有用户权限的 Token。

![](https://web-cdn.agora.io/docs-files/1670827712260)

![](./images/quickstart/generate_token.png)

<div class="alert note">为了在该 Demo 中测试使用，需注册两个用户，即发送方和接收方，并且分别为其生成 Token。</div>

## 项目设置

在本节中，我们准备了将即时通讯 IM 集成到你的 app 中所需的开发环境。

1. 若为新的 web 项目，创建名为 `agora_quickstart` 目录。在终端中打开该目录，运行 `npm init`。此时，该目录下会创建 `package.json` 文件。然后创建以下文件：

   - `index.html`：设置 Web 应用的用户界面；
   - `index.js`：包含消息发送和接收逻辑的实现代码。

现在，该项目目录的结构如下：

```text
1agora_quickstart2
├─ index.html3
├─ main.js4
└─ package.json
```

2. 通过 npm 在你的项目中集成即时通讯 IM SDK。在 'package.json' 文件中添加 'agora-chat' 和 'vite'。

```json
   {
     "name": "agora_quickstart",
     "private": true,
     "version": "0.0.0",
     "type": "module",
     "scripts": {
         "dev": "vite",
         "build": "vite build",
         "preview": "vite preview"
     },
     "dependencies":{
         "agora-chat": "latest"
     },
     "devDependencies": {
         "vite": "^3.0.7"
     }
 }
 ```

## 实现发送和接收单聊消息

本节介绍如何使用即时通讯 IM SDK 在你的应用中实现单聊消息的发送与接收。

### 创建 UI

将以下代码复制到 `index.html` 文件中实现客户端用户界面。

<script type="module" src="/main.js"></script> 用于访问 main.js 文件。

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Agora Chat Examples</title>
  <script type="module" src="/main.js"></script>
  <!-- <link rel="stylesheet" href="style.css" type="text/css" /> -->
</head>

<body>
  <h2>Agora Chat Examples</h2>
  <form id="loginForm">
    <div class="input-field">
      <label>User ID</label>
      <input type="text" placeholder="User ID" id="userID">
    </div>
    <div class="input-field">
      <label>Token</label>
      <input type="text" placeholder="Token" id="token">
    </div>
    <div>
      <button type="button" id="login">Login</button>
      <button type="button" id="logout">Logout</button>
    </div>
    <div class="input-field">
      <label>Peer user ID</label>
      <input type="text" placeholder="Peer user ID" id="peerId">
    </div>
    <div class="input-field">
      <label>Peer Message</label>
      <input type="text" placeholder="Peer message" id="peerMessage">
      <button type="button" id="send_peer_message">send</button>
    </div>
  </form>
  <hr/>
  <div id="log"></div>
</body>

</html>

### 实现发送与接收消息

参考以下步骤实现发送和接收单聊消息：

1. 导入即时通讯 IM SDK。将以下代码复制到 `index.js` 文件：

```javascript
// Javascript
// 为了避免浏览器兼容性问题，该示例通过导入命令导入 SDK 和 vite 打包 JS 文件。
import AC from 'agora-chat'

你若使用 typescript，运行以下代码：

// Typescript
import AC, { AgoraChat } from 'agora-chat'
```

2. 利用即时通讯 IM SDK 中提供的核心方法实现发送和接收单聊消息。复制以下代码，添加到 `main.js` 文件中的导入功能的后面。

```javascript
// 将 <Your app key> 替换为你的 App Key。
const appKey = "<Your app key>";
// 初始化 Web 客户端
const conn = new AC.connection({
	appKey: appKey,
});
// 添加事件处理器
conn.addEventHandler("connection&message", {
	// app 与即时通讯 IM 服务器成功连接的回调
	onConnected: () => {
		document
			.getElementById("log")
			.appendChild(document.createElement("div"))
			.append("Connect success !");
	},
	// app 与即时通讯 IM 服务器断开连接的回调
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
	},
	// Token 过期时触发的回调。
	onTokenExpired: (params) => {
		document
			.getElementById("log")
			.appendChild(document.createElement("div"))
			.append("The token has expired");
	},
	onError: (error) => {
		console.log("on error", error);
	},
});

// 定义按钮的功能
window.onload = function () {
	// 登录即时通讯 IM
	document.getElementById("login").onclick = function () {
		document
			.getElementById("log")
			.appendChild(document.createElement("div"))
			.append("Logging in...");
		const userId = document.getElementById("userID").value.toString();
		const token = document.getElementById("token").value.toString();
		conn.open({
			user: userId,
			agoraToken: token,
		});
	};
	// 登出即时通讯 IM
	document.getElementById("logout").onclick = function () {
		conn.close();
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
		let msg = AC.message.create(option);
		conn
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

利用 vite 构建项目。你可以运行以下命令运行项目。

```bash
$ npm install
```

```bash
$ npm run dev
```

你的浏览器会自动打开以下页面：

![img](https://web-cdn.agora.io/docs-files/1664531249247)

按以下步骤验证你刚刚通过即时通讯 IM 在你的 Web app 中集成的发送和接收单聊消息的实现：

1. 登录即时通讯 IM。
   在 **user id** 框中输入发送方的用户 ID（`Leo`），在 **token** 框中输入 agora token，点击 **Login** 登录 app。

2. 发送消息。
   在 **single chat id** 框中填写发送方的用户 ID（`Roy`），在 **message content** 框中输入消息（"Hi, how are you doing?"），点击 **Send** 发送消息。

   ![img](https://web-cdn.agora.io/docs-files/1664531288522)

3. 登出即时通讯 IM。
  点击 **Logout** 登出 app。

4. 接收消息。
   在新窗口中打开同一页面，利用接收方的用户 ID（`Roy`）登录，接收 **Leo** 发送的消息（"Hi, how are you doing?"）。

   ![img](https://web-cdn.agora.io/docs-files/1664531311192)

## 后续步骤

出于演示目的，Agora 即时通讯服务提供一个 App Server，可使你利用本文中提供的 App Key 快速获得 token。在生产环境中，最好自行部署 token 服务器，使用自己的 [App Key](./enable_agora_chat) 生成 token，并在客户端获取 token 登录 Agora 即时通讯服务。要了解如何实现服务器按需生成和提供 token，请参阅[生成用户 Token](./generate_user_tokens)。

## 参考

除了使用 npm 将即时通讯 IM SDK 集成到你项目中外，你还可以手动下载[即时通讯 IM Web SDK](https://www.npmjs.com/package/agora-chat)：

1. 在 SDK 文件夹中，将 `libs/Agora-chat.js` 保存到你的项目目录。

2. 在你的项目目录中打开 HTML 文件，添加以下代码查看 JS 文件。

```javascript
<script src="path to the JS file"></script>
```

- 关于即时通讯 IM 的安装指南，详见[示例代码](https://github.com/AgoraIO/Agora-Chat-API-Examples/blob/main/Chat-Web/src/index.js)。
- 安装 [demo app](https://docs.agora.io/en/agora-chat/reference/downloads)。
 


