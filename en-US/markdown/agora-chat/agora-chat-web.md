# Get Started with Agora Chat

Instant messaging connects people wherever they are and allows people to communicate with others in real time. The Agora Chat SDK enables you to embed peer-to-peer messaging in any app, on any device, anywhere.

This page shows the minimum code you need to add peer-to-peer messaging into your app by using the Agora Chat SDK for Web.

## Understand the tech

The following figure shows the workflow to integrate into your app in order to add peer-to-peer messaging functionality.

![](https://web-cdn.agora.io/docs-files/1635300333362)

As shown in the figure, the workflow of peer-to-peer messaging is as follows:

1. Client A and Client B sign in to Agora Chat.
2. Client A sends a peer message to the Agora Chat server.
3. The Agora Chat server sends the message to Client B. 
4. Client B receives the peer message.

## Prerequisites

In order to follow the procedure in this page, you must have:

- A valid [Agora account](). 
- A valid [Agora project]() with an AppKey.
- A Windows or macOS computer that meets the following requirements:
  - Access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Web) to access Agora services.
  - A broswer supported by the Agora Chat SDK: 
    - Internet Explorer 9 or later
    - FireFox 10 or later
    - Chrome 54 or later
    - Safari 6 or later
- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

## Project setup

Follow the steps to create the environment necessary to add peer-to-peer messaging into your app.

1. For a new web project, **create** a new directory and name it  `Agora_quickstart`. Navigate to this directory in terminal and run `npm init`  to create a `package.json` file. Then, create the following files:

- `index.html`

- `index.js`

  The project directory now has the following structure:

  ```text
  Agora_quickstart
  ├─ index.html
  ├─ index.js
  └─ package.json
  ```

2. Integrate the Agora Chat SDK into your project through npm. You can refer to the following steps:

   a. In the `package.json` file, add `agora-chat-sdk` and its version number to the `dependencies` field:

   ```
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

   b. Import `agora-chat-sdk` module. In `index.js` file, add the following line:

   ```
   import WebIM from 'agora-chat-sdk'
   ```

## Implement peer-to-peer messaging

This section shows how to use the Agora Chat SDK to implement implement peer-to-peer messaging in your app step by step.

### Create the UI

Copy the following code to the `index.html` file to implement the UI. 

`<script src="./dist/bundle.js"></script>` is used to refer to the `bundle.js` file packaged by webpack. A sample webpack configuration is shown in later steps.

```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Agora Chat Examples</title>
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
                                <button type="button" id="register">register</button>
                                <button type="button" id="login">login</button>
                                <button type="button" id="logout">logout</button>
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
<script src="./dist/bundle.js"></script>
</html>
```

### Implement the sending and receiving of messages

Take the following steps to implement the sending and receiving of peer-to-peer messages:

1. Copy the following code to the `index.js` file.
2. Replace `"<Your app key>"` with the AppKey of your Agora project.

Note that to avoid browser-compatibility issues, the sample uses the import command to import the SDK and webpack to package the JS file. 

```
import WebIM from 'agora-chat-sdk'
const appKey = "<Your app key>"

// Initialize client
WebIM.conn = new WebIM.connection({
    appKey: appKey,
    isHttpDNS: true
})

// Add callback functions.
WebIM.conn.listen({
    onOpened: function (message) {
        document.getElementById("log").appendChild(document.createElement('div')).append("Connect success !")
    }, // This callback occurs when the connection is successfully established.
    onClosed: function (message) {
        document.getElementById("log").appendChild(document.createElement('div')).append("Logout success !")
    }, // This callback occurs when connection is closed.
    onTextMessage: function (message) {
        console.log(message)
        document.getElementById("log").appendChild(document.createElement('div')).append("Message from: " + message.from + " Message: " + message.data)
    }, // Receive messages.
})

// Button behavior
window.onload = function () {
    // Registration
    document.getElementById("register").onclick = function(){
        let username = document.getElementById("userID").value.toString()
        let password = document.getElementById("password").value.toString()
        WebIM.conn.registerUser({
            username: username,
            password: password,
            success: function () {
                document.getElementById("log").appendChild(document.createElement('div')).append("registerUser success: " + username)
            },
            error: function (error) {
                document.getElementById("log").appendChild(document.createElement('div')).append("registerUser error")
            },
        });
    }
    // Login
    document.getElementById("login").onclick = function () {
        let username = document.getElementById("userID").value.toString()
        let password = document.getElementById("password").value.toString()
        WebIM.conn.open({
            user: username,
            pwd: password,
            appKey: appKey
        });
    }

    // Logout
    document.getElementById("logout").onclick = function () {
        WebIM.conn.close();
    }

    // Send a peer-to-peer message
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

## Test your app

This quickstart uses [webpack](https://webpack.js.org/) to package the project and `webpack-dev-server` to run your project.

To test your app, take the following steps:

1. In the `package.json` file, add `webpack`, `webpack-cli`, and `webpack-dev-server` to the `dependencies` field, and the `build` and `start:dev` commands to the `scripts` field.

   ```
   {
       "name": "web",
       "version": "1.0.0",
       "description": "",
       "main": "index.js",
       "scripts": {
           "build": "webpack --config webpack.config.js",
           "start:dev": "webpack serve --open --config webpack.config.js"
       },
       "dependencies": {
           "agora-chat-sdk": "latest",
           "webpack": "^5.50.0",
           "webpack-dev-server": "^3.11.2",
           "webpack-cli": "^4.8.0"
       },
       "author": "",
       "license": "ISC"
   }
   ```

2. Create a file named `webpack.config.js` in the project directory to configure webpack. Copy the following code to the `webpack.config.js` file.

   ```
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
           port: 9000
       }
   };
   ```

   The project directory now has the following structure:

   ```text
    Agora_quickstart
    ├─ index.html
    ├─ index.js
    ├─ package.json
    └─ webpack.config.js
   ```

3. Run the following command to install dependencies:

   ```
   npm install
   ```

4. Run the following commands to build and run the project using webpack:

   ```
   # Use webpack to package the project
   npm run build
   
   # Use webpack-dev-server to run the project
   npm run start:dev
   ```

If the project runs successfully, you can see the following page.

Create a username and password and click **register**. To send a message to a specific user, click **login** to sign in to Agora Chat with the username you registered, enter the username of the receiver and the message you want to send, and click **send**. 

![](https://web-cdn.agora.io/docs-files/1635240354287)

You can open the same page in a new window and enter the username and password of the receiver to test your app.

![](https://web-cdn.agora.io/docs-files/1635240394167)

## See also

In addition to integrating the Agora Chat SDK into your project through npm, you can also manually download the [Agora Chat SDK for Web](). 

a. In the SDK folder, find the JS file in the `libs` folder, and save it to your project directory.

b. Open the HTML file in your project directory, and add the following code to refer to the JS file:

```JavaScript
<script src="path to the JS file"></script>
```