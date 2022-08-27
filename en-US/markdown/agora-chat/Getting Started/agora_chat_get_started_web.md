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

- A Windows or macOS computer that meets the following requirements:
  - A browser supported by the Agora Chat SDK: 
    - Internet Explorer 9 or later
    - FireFox 10 or later
    - Chrome 54 or later
    - Safari 6 or later
  - Access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Web) to access Agora services.
- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

## Project setup

To create the environment necessary to add peer-to-peer messaging into your app, do the following:

1. For a new web project, create a new directory and name it  `agora_quickstart`. Navigate to this directory in terminal and run `npm init`. This creates a `package.json` file. Then, create the following files:
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
   Add 'agora-chat' and 'vite'  in 'package.json' file.

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

<script type="module" src="/main.js"></script> Used to reference JS files.

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Agora Chat Examples</title>
  <script type="module" src="/main.js"></script>
  <link rel="stylesheet" href="style.css" type="text/css" />
</head>

<body>
  <h2>Agora Chat Examples</h2>
  <form id="loginForm">
    <div class="input-field">
      <label>Username</label>
      <input type="text" placeholder="Username" id="userID">
    </div>
    <div class="input-field">
      <label>Password</label>
      <input type="password" placeholder="Password" id="password">
    </div>
    <div>
      <button type="button" id="register" class="button">Register</button>
      <button type="button" id="login">Login</button>
      <button type="button" id="logout">Logout</button>
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
   // Note that to avoid browser-compatibility issues, the sample uses the import command to import the SDK and webpack to package the JS file.
   import AC from 'agora-chat'
	 ```
	 
	 If you use typescript, use the following code:
	 
	```javascript
	// Typescript
	// import AC, { AgoraChat } from 'agora-chat'
	```
	
2. Implement peer-to-peer messaging with the core methods provided by the Agora Chat SDK. Copy the following code and add them behind the import function in the `main.js` file.

	```javascript
	/** When fetching a token, your token server may differ slightly from our example backend service logic.

		To make this step easier to test, use the temporary token server "https://a41.chat.agora.io" provided by Agora in the placeholder below. When you're ready to deploy your own server, swap out your server's URL there, and update any of the POST request logic along with that.

		If you have already got an account and user token, you can ignore this section and go to the next. */
	const baseUrl = "<Developer Token Server>";
	const appKey = "<Your app key>";
	let username, password;
	// Initializes the Web client
	const conn = new AC.connection({
		appKey: "41117440#383391",
	});
	// Adds the event handler
	conn.addEventHandler("connection&message", {
		// Occurs when the app is connected to Agora Chat
		onConnected: () => {
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Connect success !");
		},
		// Occurs when the app is disconnected from Agora Chat
		onDisconnected: () => {
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Logout success !");
		},
		// Occurs when a text message is received
		onTextMessage: (message) => {
			console.log(message);
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Message from: " + message.from + " Message: " + message.msg);
		},
		// Occurs when the token is about to expire
		onTokenWillExpire: (params) => {
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Token is about to expire");
			refreshToken(username, password);
		},
		// Occurs when the token has expired. You need to get a token from your app server to log in to Agora Chat
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

	// Gets the token from the app server
	function refreshToken(username, password) {
		postData(baseUrl+"/app/chat/user/login", {
			userAccount: username,
			userPassword: password,
		}).then((res) => {
			let agoraToken = res.accessToken;
			conn.renewToken(agoraToken);
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Token has been updated");
		});
	}
	// Sends a request for token
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

	// Defines the functions of the buttons
	window.onload = function () {
		// Registration
		document.getElementById("register").onclick = function () {
			username = document.getElementById("userID").value.toString();
			password = document.getElementById("password").value.toString();
			// Uses token to authenticate the user
			postData(baseUrl+"/app/chat/user/register", {
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
		// Logs into Agora Chat
		document.getElementById("login").onclick = function () {
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("Logging in...");
			username = document.getElementById("userID").value.toString();
			password = document.getElementById("password").value.toString();
			// 1. Uses a token for authentication
			postData(baseUrl+"/app/chat/user/login", {
				userAccount: username,
				userPassword: password,
			})
				.then((res) => {
					const {accessToken, chatUserName} = res
					conn.open({
						user: chatUserName,
						agoraToken: accessToken,
					});
				})
				.catch((res) => {
					document
						.getElementById("log")
						.appendChild(document.createElement("div"))
						.append(`Login failed`);
				});
		};

		// Logs out
		document.getElementById("logout").onclick = function () {
			conn.close();
			document
				.getElementById("log")
				.appendChild(document.createElement("div"))
				.append("logout");
		};

		// Sends a peer-to-peer message
		document.getElementById("send_peer_message").onclick = function () {
			let peerId = document.getElementById("peerId").value.toString();
			let peerMessage = document.getElementById("peerMessage").value.toString();
			let option = {
				chatType: "singleChat", // Sets the chat type as single chat
				type: "txt", // Sets the message type
				to: peerId, // Sets the recipient of the meesage (userId)
				msg: peerMessage, // Sets the message content
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

##  Test your app

Use vite to build the project, you can run below command to run the project.

```bash
$ npm run dev
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

In a production context, the best practice is for your app to retrieve the token used to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](./generate_user_tokens).

## See also

In addition to integrating the Agora Chat SDK into your project through npm, you can also manually download the [Agora Chat SDK for Web](https://www.npmjs.com/package/agora-chat). 

a. In the SDK folder, find the JS file in the `libs` folder and save it to your project directory.

b. Open the HTML file in your project directory and add the following code to refer to the JS file:

```javascript
<script src="path to the JS file"></script>
```