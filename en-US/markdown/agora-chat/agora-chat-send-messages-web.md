# Get Started with Agora Chat

Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed peer-to-peer messaging in any app, on any device, anywhere.

This page shows the sample code to add peer-to-peer messaging into your app by using the Agora Chat SDK for Web.

## Understand the tech

The following figure shows the workflow of how clients send and receive peer-to-peer messages.

![](https://web-cdn.agora.io/docs-files/1636443945728)

As shown in the figure, the workflow of peer-to-peer messaging is as follows:

1. The clients retrieve a token from your app server.
2. Client A and Client B sign in to Agora Chat.
3. Client A sends a message to Client B.
4. The message is sent to the Agora Chat server and the server delivers the message to Client B.
5. When Client B receives the message, the SDK triggers an event. Client B listens for the event and gets the message.

## Prerequisites

In order to follow the procedure in this page, you must have:

- A valid Agora account. 
- A valid [Agora project](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=Web) with an AppKey.
- A token: In a test or production environment, your app client retrieves tokens from your server.
- A Windows or macOS computer (Xcode installed) that meets the following requirements:
  - Access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Web) to access Agora services.
  - A broswer supported by the Agora Chat SDK: 
    - Internet Explorer 9 or later
    - FireFox 10 or later
    - Chrome 54 or later
    - Safari 6 or later
- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

## Project setup

To create the environment necessary to add peer-to-peer messaging into your app, do the following:

1. For a new web project, create a new directory and name it  `agora_quickstart`. Navigate to this directory in terminal and run `npm init`. This creates a `package.json` file. Then, create the following files:

- `index.html`

- `index.js`

  The project directory now has the following structure:

  ```text
  agora_quickstart
  ├─ index.html
  ├─ index.js
  └─ package.json
  ```

2. Integrate the Agora Chat SDK into your project through npm. To Integrate the SDK, in  `package.json`, add `agora-chat-sdk` and its version number to the `dependencies` field:

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
      "agora-chat-sdk": "latest"
    },
    "author": "",
    "license": "ISC"
   }
   ```

## Implement peer-to-peer messaging

This section shows how to use the Agora Chat SDK to implement peer-to-peer messaging in your app step by step.

### Create the UI

Copy the following code to the `index.html` file to implement the UI. 

`<script src="./dist/bundle.js"></script>` is used to refer to the `bundle.js` file packaged by webpack. A sample webpack configuration is shown in later steps.

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

### Implement the sending and receiving of messages

To enable your app to send and receive messages between individual users, do the following:

1. Copy the following code to the `index.js` file:

   ```javascript
   // Note that to avoid browser-compatibility issues, the sample uses the import command to import the SDK and webpack to package the JS file.
   import WebIM from 'agora-chat-sdk'
   var username, password
   // Initialize client.
   WebIM.conn = new WebIM.connection({
       appKey: "41117440#383391",
   })
   // Add callback functions.
   WebIM.conn.listen({
       onOpened: function (message) {
           // This callback occurs when the user logs in to the app successfully. 
           document.getElementById("log").appendChild(document.createElement('div')).append("Connect success !")
       }, 
       onClosed: function (message) {
           // This callback occurs when the user logs out successfully.
           document.getElementById("log").appendChild(document.createElement('div')).append("Logout success !")
       }, 
       onTextMessage: function (message) {
           console.log(message)
           // Receive a text message.
           document.getElementById("log").appendChild(document.createElement('div')).append("Message from: " + message.from + " Message: " + message.data)
       }, 
       // This callback occurs when the token is to expire. 
       onTokenWillExpire: function (params) {
           document.getElementById("log").appendChild(document.createElement('div')).append("Token is about to expire")
           refreshToken(username, password)
       }, 
       // This callback occurs when the token expires. When the callback is triggered, the app client must get a new token from the app server and logs in to the app again.
       onTokenExpired: function (params) {
           document.getElementById("log").appendChild(document.createElement('div')).append("The token has expired")
           refreshToken(username, password)
       }, 
       onError: function (error) {
           console.log('on error', error)
       }
   })
   
   // Retrieve a new token.
   function refreshToken(username, password) {
       postData('https://a41.easemob.com/app/chat/user/login', { "userAccount": username, "userPassword": password })
           .then((res) => {
               let agoraToken = res.accessToken
               WebIM.conn.renewToken(agoraToken)
               document.getElementById("log").appendChild(document.createElement('div')).append("Token has been updated")
           })
   }
   
   function postData(url, data) {
       return fetch(url, {
           body: JSON.stringify(data),
           cache: 'no-cache',
           headers: {
               'content-type': 'application/json'
           },
           method: 'POST',
           mode: 'cors',
           redirect: 'follow',
           referrer: 'no-referrer',
       })
           .then(response => response.json())
   }
   
   // Button behavior
   window.onload = function () {
       // Registration.
       document.getElementById("register").onclick = function () {
           username = document.getElementById("userID").value.toString()
           password = document.getElementById("password").value.toString()
           // 1. Register with a token.
           postData('https://a41.easemob.com/app/chat/user/register', { "userAccount": username, "userPassword": password })
               .then((res) => {
                   document.getElementById("log").appendChild(document.createElement('div')).append(`register user ${username} success`)
               })
               .catch((res)=> {
                   document.getElementById("log").appendChild(document.createElement('div')).append(`${username} already exists`)
               })
           // 2. Register with a username and password.
           // WebIM.conn.registerUser({username, password})
           // document.getElementById("log").appendChild(document.createElement('div')).append("register user "+username)
       }
       // Login.
       document.getElementById("login").onclick = function () {
           document.getElementById("log").appendChild(document.createElement('div')).append("Logging in...")
           username = document.getElementById("userID").value.toString()
           password = document.getElementById("password").value.toString()
           // 1. Log in with a token.
           postData('https://a41.easemob.com/app/chat/user/login', { "userAccount": username, "userPassword": password })
               .then((res) => {
                   let agoraToken = res.accessToken
                   let easemobUserName = res.chatUserName
                   WebIM.conn.open({
                       user: easemobUserName,
                       agoraToken: agoraToken
                   });
               })
               .catch((res)=> {
                   document.getElementById("log").appendChild(document.createElement('div')).append(`Login failed`)
               })
           // 2. Log in with a username and password.
           // WebIM.conn.open({
           //     user: username,
           //     pwd: password,
           // });
       }
   
       // Logout.
       document.getElementById("logout").onclick = function () {
           WebIM.conn.close();
           document.getElementById("log").appendChild(document.createElement('div')).append("logout")
       }
   
       // Send a peer-to-peer message.
       document.getElementById("send_peer_message").onclick = function () {
           let peerId = document.getElementById("peerId").value.toString()
           let peerMessage = document.getElementById("peerMessage").value.toString()
   
           let id = WebIM.conn.getUniqueId()
           let msg = new WebIM.message('txt', id);
           msg.set({
               msg: peerMessage,
               to: peerId,
               chatType: 'singleChat',
               success: function () {
                   console.log('send private text success');
                   document.getElementById("log").appendChild(document.createElement('div')).append("Message send to: " + peerId + " Message: " + peerMessage)
               },
               fail: function (e) {
                   console.log('send private text fail');
               }
           });
           WebIM.conn.send(msg.body);
       }
   }
   ```

2. Replace "<appKey>" with the App key of your Agora project.

##  Test your app

This quickstart uses [webpack](https://webpack.js.org/) to package the project and `webpack-dev-server` to run your project.

To build and run your project, take the following steps:

1. In the `package.json` file, add `webpack`, `webpack-cli`, and `webpack-dev-server` to the `dependencies` field, and the `build` and `start:dev` commands to the `scripts` field.

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
       "agora-chat-sdk": "^4.0.1-beta4",
       "agora-rtc-sdk-ng": "^4.6.3"
     },
     "devDependencies": {
       "webpack": "^5.50.0",
       "webpack-cli": "^4.8.0",
       "webpack-dev-server": "^3.11.2"
     }
   }
   ```

2. To configure webpack, copy the following code into a new file called `webpack.config.js`:

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

   The project directory now has the following structure:

   ```text
    agora_quickstart
    ├─ index.html
    ├─ index.js
    ├─ package.json
    └─ webpack.config.js
   ```

3. To install the dependencies, run the following command:

   ```shell
   npm install
   ```

4. To build and run the project using webpack, run the following commands:

   ```shell
   # Use webpack to package the project
   npm run build
   
   # Use webpack-dev-server to run the project
   npm run start:dev
   ```

The following page opens in your browser.

![](https://web-cdn.agora.io/docs-files/1637830121772)

To validate the peer-to-peer messaging you have just integrated into your Web app using Agora Chat:

1. Create a use account and click **register**. 

2. Log in to the app with the user account you just created and send a message.

   ![](https://web-cdn.agora.io/docs-files/1635240354287)

3. Open the same page in a new window and create another user account. Ensure that the usernames you created are unique.

4. Send messages between the users.

   ![](https://web-cdn.agora.io/docs-files/1635240394167)

## Next Step

In a production context, the best practice is for your app to retrieve the token used to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Token]().

## See also

In addition to integrating the Agora Chat SDK into your project through npm, you can also manually download the [Agora Chat SDK for Web](https://download.agora.io/sdk/release/https://download.agora.io/sdk/release/Agora_Chat_SDK_for_Web_v1.0.0.zip). 

a. In the SDK folder, find the JS file in the `libs` folder and save it to your project directory.

b. Open the HTML file in your project directory and add the following code to refer to the JS file:

```JavaScript
<script src="path to the JS file"></script>
```