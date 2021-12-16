### 1. 创建房间

在 app 客户端加入互动白板房间前，你需要在 app 服务端调用互动白板服务端 RESTful API 创建一个房间。详见[创建房间（POST）](https://docs-preprod.agora.io/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）)。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

  <div class="alert info">使用 Node.js 发送 HTTP 请求前安装 <code>request</code> 模块。你可以运行 <code>npm install request</code> 安装。</div>

```javascript
var request = require("request");
var options = {
  "method": "POST",
  "url": "https://api.netless.link/v5/rooms",
  "headers": {
    "token": "你的 SDK Token",
    "Content-Type": "application/json"
  }
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

###  2. 生成 Room Token

创建房间并获取新建房间的 `uuid` 后，你需要在 app 服务端生成 Room Token 并下发给 app 客户端。当 app 客户端加入房间时，Agora 互动白板服务端会使用该 Token 对其鉴权。

你可以通过以下方式在 app 服务端生成 Room Token：

- 使用代码生成 Room Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server)。（推荐）
- 调用互动白板服务端 RESTful API 生成 Room Token，详见[生成 Room Token（POST）](/cn/whiteboard/generate_whiteboard_token#生成-room-token（post）)。

下面以调用 RESTful API 的方式为例介绍如何生成 Room Token。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

 <div class="alert info">使用 Node.js 发送 HTTP 请求前安装 <code>request</code> 模块。你可以运行 <code>npm install request</code> 安装。</div>

```javascript
var request = require('request');
var options = {
  "method": "POST",
	// 将 <房间的 UUID> 替换成你的房间 UUID
  "url": "https://api.netless.link/v5/tokens/rooms/<房间的 UUID>", 
  "headers": {
    "token": "你的 SDK Token",
    "Content-Type": "application/json"
  },
  body: JSON.stringify({"lifespan":60,"role":"admin"})
  
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

如果方法调用成功，Agora 互动白板服务端将返回生成的 Room Token。

**响应示例**
```javascript
"NETLESSROOM_YWs9XXXXXXXXXXXZWNhNjk" // Room Token
```