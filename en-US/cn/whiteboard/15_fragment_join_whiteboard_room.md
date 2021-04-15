### 1. Create a room

Before an app client requests to join a room, you need to call the Interactive Whiteboard RESTful API on your app server to create a room. See [Create a room (POST)](https://docs-preprod.agora.io/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）).

**Request example**

Refer to the following Node.js script to send an HTTP request:

<div class="alert info">Before sending an HTTP request using Node.js, make sure that you have installed the <code>request</code> module. You can run the command line <code>npm install request</code> to install the module.</div>

```javascript
var request = require("request");
var options = {
  "method": "POST",
  "url": "https://api.netless.link/v5/rooms",
  "headers": {
    "token": "Your SDK Token",
    "Content-Type": "application/json"
  }
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

If the request is successful, Agora's server for the whiteboard service returns information about the created room, including the `uuid`, which is the unique identifier of the room. You need to pass in this parameter when an app client joins the room.

**Response example**

```javascript
{
    "uuid": "4a50xxxxxx796b", // The Room UUID
    "name": "",
    "teamUUID": "RMmLxxxxxx15aw",
    "appUUID": "i54xxxxxx1AQ",
    "isRecord": true,
    "isBan": false,
    "createdAt": "2021-01-18T06:56:29.432Z",
    "limit": 0
}
```

### 2. Generate a Room Token

After creating a room and getting the `uuid` of the room, you need to generate a Room Token on your app server and send it to the app client. When an app client joins a room, Agora's server uses the Room Token for authentication.

To generate a Room Token on your app server, you can:

- Use code. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server). (Recommended)
- Call the Interactive Whiteboard RESTful API. See [Generate a Room Token (POST)](/cn/whiteboard/generate_whiteboard_token#生成-room-token（post）).

The following examples describe how to use the Interactive Whiteboard RESTful API to generate a Room Token.

**Request example**

Refer to the following Node.js script to send an HTTP request:

<div class="alert info">Before sending an HTTP request using Node.js, make sure that you have installed the <code>request</code> module. You can run the command line <code>npm install request</code> to install the module.</div>

```javascript
var request = require('request');
var options = {
  "method": "POST",
	// Replace <Room UUID> with your Room UUID
  "url": "https://api.netless.link/v5/tokens/rooms/<Room UUID>", 
  "headers": {
    "token": "Your SDK Token",
    "Content-Type": "application/json"
  },
  body: JSON.stringify({"lifespan":60,"role":"admin"})
  
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

If the request is successful, Agora's server returns a Room Token.

**Response example**
```javascript
"NETLESSROOM_YWs9XXXXXXXXXXXZWNhNjk" // Room Token
```
