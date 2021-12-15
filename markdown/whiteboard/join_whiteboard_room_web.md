---
title: 加入实时房间
platform: Web
updatedAt: 2021-03-31 09:04:45
---

本文详细介绍如何建立一个简单的项目并使用 Agora 互动白板 SDK 实现基础的白板功能。

<div class="alert note">由于浏览器的安全策略对除 127.0.0.1 以外的 HTTP 地址作了限制，Agora 互动白板 SDK 仅支持 HTTPS 协议或者 http://localhost ( http://127.0.0.1 ) ，请勿使用 HTTP 协议部署你的项目。</div>

## 前提条件

- 支持 ES6 的浏览器。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)。
- 已在 Agora 控制台[开启互动白板服务](/cn/whiteboard/enable_whiteboard?platform=Web#开启互动白板服务)并获取项目的 [App Identifer](/cn/whiteboard/enable_whiteboard?platform=Web#获取-app-identifier) 和 [SDK Token](/cn/whiteboard/enable_whiteboard?platform=Web#获取-sdk-token)。

## 创建 Web 项目

1. 创建一个文件夹作为白板应用的项目文件夹，在该文件夹下按照以下结构创建文件和目录：

```
.
├── index.html
├── scripts
│   └── index.js
```

其中，`index.html` 为白板应用的前端页面文件，`scripts` 目录下的 `index.js` 文件为实现白板功能的 JavaScript 代码。

2. 将以下代码复制到 `index.html` 文件中。

   ````
    <!DOCTYPE html>
    <html>
        <head>
            <script src="https://sdk.netless.link/white-web-sdk/2.11.5.js"></script>
            <script src="./index.js"></script>
        </head>
        <body>
            <div id="whiteboard" style="width: 100%; height: 100vh;"></div>
        </body>
    </html>

    	```
    其中的 `<div id="whiteboard">` 是互动白板的占位符。随后，你将通过 JavaScript 调用互动白板 SDK 的方法，来在这个 `<div>` 注入白板的实体。
   ````

## 获取 SDK

选择如下任意一种方法获取 Agora 互动白板 SDK：

### 方法 1. 使用 npm 获取 SDK

使用该方法需要先安装 npm，详见 [npm 快速入门](https://www.npmjs.com.cn/getting-started/installing-node/)。

1. 运行安装命令。

````
	npm install white-web-sdk
	```

2. 在项目的 Javascript 代码中引入 Agora 互动白板 SDK。
````

var WhiteWebSdk = require("white-web-sdk");

```

### 方法 2. 使用 CDN 方法获取 SDK

该方法无需下载安装包。在 `index.html` 中，将如下代码添加到 `<head>` 的下一行：

```

<head>
    <script src="https://sdk.herewhite.com/white-web-sdk/2.11.5.js"></script>
</head>
```

<div class="alert info">本文的示例使用方法二获取 SDK。</div>

## 基本流程

现在，我们已经将 Agora 互动白板 SDK 集成到项目中了。接下来我们要在 `script.js` 文件中调用 Agora 互动白板 SDK 提供的核心 API 实现基础的白板功能。

### 1. 创建房间

在 app 客户端加入互动白板房间前，你需要在 app 服务端调用互动白板服务端 RESTful API 创建一个房间。详见[创建房间（POST）](https://docs-preprod.agora.io/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）)。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

  <div class="alert info">使用 Node.js 发送 HTTP 请求前安装 <code>request</code> 模块。你可以运行 <code>npm install request</code> 安装。</div>

```javascript
var request = require("request");
var options = {
  method: "POST",
  url: "https://api.netless.link/v5/rooms",
  headers: {
    token: "你的 SDK Token",
    "Content-Type": "application/json",
  },
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

如果方法调用成功，Agora 互动白板服务端将返回新建房间的信息，其中的 `uuid` 是房间的唯一标识，app 客户端加入房间时需要传入该参数。

**响应示例**

```javascript
{
    "uuid": "4a50xxxxxx796b", // 房间的 UUID
    "name": "",
    "teamUUID": "RMmLxxxxxx15aw",
    "appUUID": "i54xxxxxx1AQ",
    "isRecord": true,
    "isBan": false,
    "createdAt": "2021-01-18T06:56:29.432Z",
    "limit": 0
}
```

### 2. 生成 Room Token

创建房间并获取新建房间的 `uuid` 后，你需要在 app 服务端生成 Room Token 并下发给 app 客户端。当 app 客户端加入房间时，Agora 互动白板服务端会使用该 Token 对其鉴权。

你可以通过以下方式在 app 服务端生成 Room Token：

- 使用代码生成 Room Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server)。（推荐）
- 调用互动白板服务端 RESTful API 生成 Room Token，详见[生成 Room Token（POST）](/cn/whiteboard/generate_whiteboard_token#生成-room-token（post）)。

下面以调用 RESTful API 的方式为例介绍如何生成 Room Token。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

 <div class="alert info">使用 Node.js 发送 HTTP 请求前安装 <code>request</code> 模块。你可以运行 <code>npm install request</code> 安装。</div>

```javascript
var request = require("request");
var options = {
  method: "POST",
  // 将 <房间的 UUID> 替换成你的房间 UUID
  url: "https://api.netless.link/v5/tokens/rooms/<房间的 UUID>",
  headers: {
    token: "你的 SDK Token",
    "Content-Type": "application/json",
  },
  body: JSON.stringify({lifespan: 60, role: "admin"}),
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

如果方法调用成功，Agora 互动白板服务端将返回生成的 Room Token。

**响应示例**

```javascript
"NETLESSROOM_YWs9XXXXXXXXXXXZWNhNjk"; // Room Token
```

### 3. 创建 WhiteWebSdk 实例

创建并初始化一个客户端 `WhiteWebSdk` 实例。初始化 `WhiteWebSdk` 时，你需要填入从 Agora 控制台获取的互动白板 App Identifier。详见[获取 App Identifier](/cn/whiteboard/enable_whiteboard?platform=iOS#获取-app-identifier)。

将以下代码复制到 `index.js` 文件中：

```
var whiteWebSdk = new WhiteWebSdk({
    // 设置 App Identifier。
    appIdentifier: "你的 App Identifier",
});
```

### 4. 加入房间

初始化 `WhiteWebSdk` 实例后，调用 `joinRoom` 加入房间。调用该方法时，需要传入以下参数：

- `uuid`: 房间 UUID，即房间的唯一标识符。详见[创建房间](/cn/whiteboard/join_whiteboard_room_web?platform=Web&versionId=5abdfbd0-8d37-11eb-aaa4-87d60bbe30e0#1-创建房间)。
- `roomToken`: 用于鉴权的 Room Token。生成该 Room Token 使用的房间 UUID 必须和上面的房间 UUID 一致。详见[生成 Room Token](/cn/whiteboard/join_whiteboard_room_web?platform=Web&versionId=b58db8d0-8fa2-11eb-9291-873e8e47bde0#2-生成-room-token)。

将以下代码复制到 `index.js` 文件中：

```
var joinRoomParams = {
    // 设置房间 UUID。
    uuid: "你的房间 UUID",
    // 设置 Room Token。
    roomToken: "你的 Room Token",
};

// 加入房间，并将白板展示到网页上。
whiteWebSdk.joinRoom(joinRoomParams).then(function(room) {
    room.bindHtmlElement(document.getElementById("whiteboard"));
}).catch(function(err) {
    console.error(err);
});
```

## 运行项目

用浏览器打开 `index.html` 文件，将看到一个空白页面。如果应用成功运行，你可以用鼠标在该页面上写写画画并看到笔迹。
