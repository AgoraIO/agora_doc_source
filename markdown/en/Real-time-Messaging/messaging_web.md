---
title: Peer-to-peer or Channel Messaging
platform: Web
updatedAt: 2020-11-16 10:18:15
---

You can use this guide to quickly start messaging with the [Agora RTM Web SDK](https://docs.agora.io/en/Real-time-Messaging/downloads). 


## Try the demo

We provide an open-source demo project on GitHub, [Agora-RTM-Tutorial-Web](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-Web), which implements an elementary messaging system. You can try this demo out and view our source code:


## Prerequisites

A valid [Agora developer account](https://sso.agora.io/login/).


<div class="alert note">Open the ports and whitelist the domains specified in <a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your intranet has a firewall.</div> 

<a name="setup"></a>

## Set up the development environment

This section describes how to get an App ID and integrate the Agora RTM SDK for Web into your project.

### <a name="appid"></a>Get an App ID

You can skip to [Integrate the SDK into your project](#integrate) if you already have an App ID. 

<details>
	<summary><font color="#3ab7f8">Get an App ID</font></summary>
	
1. Sign up for a developer account at [Agora Console](https://dashboard.agora.io/). See [Sign in and Sign up](sign_in_and_sign_up).

2. Click ![](https://web-cdn.agora.io/docs-files/1551254998344) in the left navigation menu to enter the [**Project Management**](https://dashboard.agora.io/projects) page.

3. Click **Create**. 

![](https://web-cdn.agora.io/docs-files/1574924327108)

4.  Enter your project name and select your authentication mechanism ("App ID") in the dialog box.

![](https://web-cdn.agora.io/docs-files/1574924446798)
	
5. Click **Submit** and you can find the **App ID** of your newly created project.

![](https://web-cdn.agora.io/docs-files/1574924570426)
</details>



### <a name="integrate"></a> Integrate the SDK

#### Method 1: Through the Agora website

Download the Agora RTM Web SDK and include with a `<script>` tag, and `AgoraRTM` is registered as a global variable.

Add to the HTML file the following code and replace `/path/to/agora-rtm-sdk.min.js` with the URL of `agora-rtm-sdk.min.js`:

```html
<script src="/path/to/agora-rtm-sdk.min.js"></script>
```

> Ensure that the address specified by `src` is accessible as a URL in a web browser.

<details>
	<summary><font color="#3ab7f8">(Optional) Use the TypeScript definition file (`AgoraRTM.d.ts`) to enable IntelliSense</font></summary>

After getting the global `AgoraRTM` object using Direct `<script>` Include, you can use it in the rest of your JavaScript code, but you cannot enable IntelliSense.
To enable IntelliSense, add the following annotation at the beginning of the JavaScript and replace `path/to/AgoraRTM.d.ts` with the actual directory holding the `AgoraRTM.d.ts` file:

```JavaScript
/// <reference path="path/to/AgoraRTM.d.ts" />
```

</details>
	
#### Method 2: Through npm

This method requires npm, see Install [npm](https://www.npmjs.com/get-npm) for details.

1. Run the following command to install the SDK.
`npm i agora-rtm-sdk`
2. Add the following code to the Javascript code in your project.
`import AgoraRTM from 'agora-rtm-sdk'`

## Implement peer-to-peer and channel messaging

This section provides sample codes and considerations related to peer-to-peer messaging and channel messaging. 

### Initialize the Client

#### Create an Instance

Before logging in the Agora RTM system, call the [createInstance](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance) method to create an [RtmClient](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html) instance.

```JavaScript
import AgoraRTM from 'agora-rtm-sdk';
const client = AgoraRTM.createInstance('YourAppId'); 
```
> Only RTM instances with the same App ID can talk to each other.

#### Set a listener to the connection state change 

By listening to the [ConnectionStateChanged](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#connectionstatechange) event on [RtmClient](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html), you can be notified of connection state changes between the SDK and the Agora RTM server. 

```JavaScript
client.on('ConnectionStateChange', (newState, reason) => {
  console.log('on connection state changed to ' + newState + ' reason: ' + reason);
});
```

### Log in and log out

#### Log in the Agora RTM system

A Web application can call the messaging functionalities of the Agora RTM system only after logging in the Agora RTM system.

To log in the Agora RTM system, pass an object with the following attributes:
- `token`: You can skip it or set it as null at development stages that do not demand high security, or pass in your token generated by your app server in situations that require high security. You need to generate an RTM Token from your business server. For more information, see [Token Security](/en/Real-time-Messaging/rtm_token?platform=All%20Platforms).
- `uid`: The User ID has to be a string of less than 64 visible characters. It cannot be set as null. 

The [login](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#login) method returns a Promise. Use the `then` method of this Promise for passing in a callback. Use the `catch` method for catching and handling exceptions. 

```JavaScript
client.login({ token: '<TOKEN>', uid: '<UID>' }).then(() => {
  console.log('AgoraRTM client login success');
}).catch(err => {
  console.log('AgoraRTM client login failure', err);
});
```

> The sample code above uses the `then/catch` method for passing callbacks and catching exceptions. 
> You can also use the ES7 `async/await` method for asynchronous SDK calls and the synchronous `try/catch` method for catching exceptions.  So does the rest of the asychronous APIs of Promise. 

#### Log out the Agora RTM system

To log out the Agora RTM system, call the [logout](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#logout) method of [RtmClient](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html).

```JavaScript
client.logout()
```



### Send or receive peer-to-peer messages

You can send and receive peer-to-peer messages after logging in Agora's RTM server.

#### Send a peer-to-peer message

Call the [sendMessageToPeer](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#sendmessagetopeer) method of [RtmClient](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html) to send a peer-to-peer message. You need to do the following:

- Pass the user ID of the intended receiver.
- Pass an [RtmMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmmessage.html) object.

This method returns a Promise:

- The *resolve* state of this Promise indicates whether the intended receiver receives the message.
- The *reject* state of this Promise indicates one of the following:
     - A timeout.
     - A rejection by the server.
     - A connection failure.

```JavaScript
client.sendMessageToPeer(
{ text: 'test peer message' }, // An RtmMessage object.
'demoPeerId', // The user ID of the remote user.
).then(sendResult => {
if (sendResult.hasPeerReceived) {
/* Your code for handling the event that the remote user receives the message. */
} else {
/* Your code for handling the event that the message is received by the server but the remote user cannot be reached. */
}
}).catch(error => {
/* Your code for handling the event of a message send failure. */
});
```

#### Receive a peer-to-peer message

Set a listener to the [MessageFromPeer](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#messagefrompeer) event on [RtmClient](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html) to receive a peer-to-peer message.

```JavaScript
client.on('MessageFromPeer', ({ text }, peerId) => { // text: text of the received message; peerId: User ID of the sender.
/* Your code for handling the event of receiving a peer-to-peer message. */
});
```

### Send or receive channel messages

#### Create a channel

The following code snippet shows how to create a channel.

```JavaScript
const channel = client.createChannel('demoChannelName'); // Pass your channel ID here.
```

#### Join a channel

The following code snippet shows how to join a channel. `channel` refers to the newly-created channel instance; each channel ID corresponds to a separate channel instance. 

```JavaScript
channel.join().then(() => {
/* Your code for handling the event of a join-channel success. */
}).catch(error => {
/* Your code for handling the event of a join-channel failure. */
});
```

#### Send a channel message

You can send channel messages after joining a channel.

```JavaScript
channel.sendMessage({ text: 'test channel message' }).then(() => {
/* Your code for handling events, such as a channel message-send success. */
}).catch(error => {
/* Your code for handling events, such as a channel message-send failure. */
});
```

#### Receive a channel message

```JavaScript
channel.on('ChannelMessage', ({ text }, senderId) => { // text: text of the received channel message; senderId: user ID of the sender.
/* Your code for handling events, such as receiving a channel message. */
});
```


#### Leave the channel

```JavaScript
channel.leave();
```

