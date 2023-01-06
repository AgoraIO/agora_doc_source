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

In order to follow the procedure in this page, you must have the following:

- A valid Agora [account](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-account)
- An Agora [project](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-project) with an [App Key](https://docs.agora.io/en/agora-chat/get-started/enable#get-the-information-of-the-chat-project) that has [enabled the Chat service](https://docs.agora.io/en/agora-chat/get-started/enable) 
- A Windows or macOS computer that meets the following requirements:
  - A browser supported by the Agora Chat SDK: 
    - Internet Explorer 9 or later
    - FireFox 10 or later
    - Chrome 54 or later
    - Safari 6 or later
  - Access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Web) to access Agora services.
- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)


## Token generation

This section introduces how to register a user at Agora Console and generate a temporary token.

### Register a user

To register a user, do the following:

1. On the **Project Management** page, click **Config** for the project that you want to use.

	![](https://web-cdn.agora.io/docs-files/1664531061644)

2. On the **Edit Project** page, click **Config** next to **Chat** below **Features**.
	
	![](https://web-cdn.agora.io/docs-files/1664531091562)

3. In the left-navigation pane, select **Operation Management** > **User** and click **Create User**.

	![](https://web-cdn.agora.io/docs-files/1664531141100)

<a name="userid"></a>

4. In the **Create User** dialog box, fill in the **User ID**, **Nickname**, and **Password**, and click **Save** to create a user.

	![](https://web-cdn.agora.io/docs-files/1664531162872)


### Generate a user token

To ensure communication security, Agora recommends using tokens to authenticate users who log in to the Agora Chat system.

For testing purposes, Agora Console supports generating temporary tokens for Agora Chat. To generate a user token, do the following:

1. On the **Project Management** page, click **Config** for the project that you want to use.

	![](https://web-cdn.agora.io/docs-files/1664531061644)

2. On the **Edit Project** page, click **Config** next to **Chat** below **Features**.

	![](https://web-cdn.agora.io/docs-files/1664531091562)

3. In the **Data Center** section of the **Application Information** page, enter the [user ID](#userid) in the **Chat User Temp Token** box and click **Generate** to generate a token with user privileges.

	![](https://web-cdn.agora.io/docs-files/1664531214169)

<div class="alert note">Register a user and generate a user token for a sender and a receiver respectively for <a href="https://docs.agora.io/en/agora-chat/get-started/get-started-sdk#test">test use</a> later in this demo.</div>


## Project setup

To create the environment necessary to add peer-to-peer messaging into your app, do the following:

1. For a new web project, create a new directory and name it `agora_quickstart`. Navigate to this directory in terminal and run `npm init`. This creates a `package.json` file. Then, create the following files:
  - `index.html`, which sets the user interface of the Web app
  - `main.js`, which contains the code for implementing the messaging logic

 The project directory now has the following structure:

  ```text
  agora_quickstart
  ├─ index.html
  ├─ main.js
  └─ package.json
  ```

2. Integrate the Agora Chat SDK into your project through npm. 
   Add 'agora-chat' and 'vite' to the 'package.json' file.

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

## Implement peer-to-peer messaging

This section shows how to use the Agora Chat SDK to implement peer-to-peer messaging in your app step by step.

### Create the UI

Copy the following code to the `index.html` file to implement the UI. 

`<script type="module" src="/main.js"></script>` is used to refer to the `main.js` file.

```html
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
```

### Implement the sending and receiving of messages

To enable your app to send and receive messages between individual users, do the following:

1. Import the Agora Chat SDK. Copy the following code to the `main.js` file:

	```javascript
	// Javascript
	// Note that to avoid browser-compatibility issues, this sample uses the import command to import the SDK and the vite to package the JS file.
	import AC from 'agora-chat'
	```
	
    If you use typescript, use the following code:
	
	```typescript
	// Typescript
	import AC, { AgoraChat } from 'agora-chat'
	```
	
2. Implement peer-to-peer messaging with the core methods provided by the Agora Chat SDK. Copy the following code and add them after the import function in the `main.js` file.

	```javascript
	// Replaces <Your app key> with your app key.
	const appKey = "<Your app key>";
	// Initializes the Web client.
	const conn = new AC.connection({
		appKey: appKey,
	});
	// Adds the event handler.
	conn.addEventHandler("connection&message", {
		// Occurs when the app is connected to Agora Chat.
		onConnected: () => {
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Connect success !");
		},
		// Occurs when the app is disconnected from Agora Chat.
		onDisconnected: () => {
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Logout success !");
		},
		// Occurs when a text message is received.
		onTextMessage: (message) => {
			console.log(message);
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Message from: " + message.from + " Message: " + message.msg);
		},
		// Occurs when the token is about to expire.
		onTokenWillExpire: (params) => {
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Token is about to expire");
		},
		// Occurs when the token has expired. 
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
	
	// Defines the functions of the buttons.
	window.onload = function () {
		// Logs into Agora Chat.
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
		// Logs out.
		document.getElementById("logout").onclick = function () {
			conn.close();
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("logout");
		};
		// Sends a peer-to-peer message.
		document.getElementById("send_peer_message").onclick = function () {
			let peerId = document.getElementById("peerId").value.toString();
			let peerMessage = document.getElementById("peerMessage").value.toString();
			let option = {
				chatType: "singleChat", // Sets the chat type as single chat.
				type: "txt", // Sets the message type.
				to: peerId, // Sets the recipient of the message with user ID.
				msg: peerMessage, // Sets the message content.
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

<a name="test"></a>

##  Test your app

Use vite to build the project. You can run below commands to run the project.

```bash
$ npm install
```
```bash
$ npm run dev
```

The following page opens in your browser:

![](https://web-cdn.agora.io/docs-files/1664531249247)

To validate the peer-to-peer messaging you have just integrated into your Web app using Agora Chat:

1. Log in  
Fill in the user ID of the sender (`Leo`) in the **user id** box and agora token in the **token** box, and click **Login** to log in to the app.

2. Send a message  
Fill in the user ID of the receiver (`Roy`) in the **single chat id** box and type in the message ("Hi, how are you doing?") to send in the **message content** box, and click **Send** to send the message.  

	![](https://web-cdn.agora.io/docs-files/1664531288522)

3. Log out  
Click **Logout** to log out of the app.

4. Receive the message  
Open the same page in a new window, log in as the receiver (`Roy`) and receive the message ("Hi, how are you doing?") sent from **Leo**.

	![](https://web-cdn.agora.io/docs-files/1664531311192)


## Next steps

For demonstration purposes, Agora Chat uses temporary tokens generated from Agora Console for authentication in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=Unity#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](../Develop/Authentication).


## See also

In addition to integrating the Agora Chat SDK into your project through npm, you can also manually download the [Agora Chat SDK for Web](https://www.npmjs.com/package/agora-chat). 

a. In the SDK folder, find the JS file `Agora-chat.js` and save it to your project directory.

b. Open the HTML file in your project directory and add the following code to refer to the JS file:

```javascript
<script src="path to the JS file"></script>
```

## Reference

For details, see the [sample code](https://github.com/AgoraIO/Agora-Chat-API-Examples/blob/main/Chat-Web/src/index.js) for getting started with Agora Chat.