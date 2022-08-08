Instant messaging connects people wherever they are and allows them to communicate with others in real time. With built-in user interfaces (UI) for the conversation list and contact list, the [Agora Chat UIKit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-web) enables you to quickly embed real-time messaging into your app without requiring extra effort on the UI.

This page shows a sample code to add peer-to-peer messaging into your app by using the Agora Chat UIKit.

## Understand the tech

The following figure shows the workflow of how clients send and receive peer-to-peer messages:

![](https://web-cdn.agora.io/docs-files/1643335864426)

1. Clients retrieve a token from your app server.
2. Client A and Client B log in to Agora Chat.
3. Client A sends a message to Client B. The message is sent to the Agora Chat server, and the server delivers the message to Client B. When Client B receives the message, the SDK triggers an event. Client B listens for the event and gets the message.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- React 16.8.0 or later.
- React DOM 16.8.0 or later.
- A Windows or macOS computer that has a browser supported by the Agora Chat SDK:
  - Internet Explorer 11 or later
  - Firefox 10 or later
  - Chrome 54 or later
  - Safari 11 or later
- A valid [Agora account](https://docs.agora.io/en/AgoraPlatform/get_appid_token?platform=AllPlatforms#create-an-agora-account).
- An Agora project that has [enabled the Chat service](./enable_agora_chat?platform=Web#enable-the-agora-chat-service).
- An [App key](./enable_agora_chat?platform=Web#get-the-information-of-the-agora-chat-project) and [a user token generated on your app server](./generate_user_tokens?platform=Web).

## Project setup

This sections introduces how to create an app and add the Chat UIKit to the project.

1. In your terminal, run the following command to create an app:

   ```shell
   # Install CLI
   npm install create-react-app
   # Create an app named my-app
   npx create-react-app my-app
   cd my-app
   ```

   Once you successfully create the app, the project structure is as follows:

   ```shell
   my-app
    ├── package.json
    ├── public                  # The static directory for Webpack
    │   ├── favicon.ico
    │   ├── index.html          # The default one-page app
    │   └── manifest.json
    ├── src
    │   ├── App.css             # The css file of the app
    │   ├── App.js              # The code of the app
    │   ├── App.test.js
    │   ├── index.css           # The layout when launching the file
    │   ├── index.js            # Launch the file
    │   ├── logo.svg
    │   └── serviceWorker.js
    └── yarn.lock
   ```

2. Run one of the following commands to add the Chat UIKit to your project.

   To add the UIKit using npm:

   ```shell
   npm install agora-chat-uikit --save
   ```

   To add the UIKit using yarn

   ```shell
   yarn add agora-chat-uikit
   ```

## Implementation

The Web Chat UIKit has two components:

- `EaseApp`, which contains the conversation list and applies to use cases where you want to quickly launch a real-time chat app.
- `EaseChat`, which contains a conversation box and applies to most chat use cases such as sending and receiving messages, displaying the message on the UI, and managing unread messages. 

This section introduces the steps you need to take to quickly implement one-to-one messaging with `EaseApp`.

1. Import `EaseApp`.

   Open `my-app/src/App.js`, and replace the code with the following:

   ```javascript
    // App.js
    import React, {Component} from 'react';
    import { EaseApp } from "agora-chat-uikit"
    import './App.scss';

    class App extends Component {
    render() {
        return (
        <div className="container">
            <EaseApp
                // The App key for your chat project
                appkey= "xxx"
                // The user ID of the current user
                username= "xxx"
                // The Agora token
                agoraToken= "xxx"
                /> 
        </div>
        );
      }
    }

    export default App;
   ```

2. Set the layout for the conversation.

   Open `my-app/src/App.js`, and replace the content with the following:

   ```javascript
    /** App.css */ 
    .container {
        height: 100%;
        width: 100%
    }
   ```

## Test your app

In your terminal, run the following command to launch the app:

```shell
npm run start
```

You can see the app launch in your browser. Before you can send a message, refer to [Add a contact](./manage_user_friend_web?platform=Web#manage-contacts) or [Join a chat group](./agora_chat_group_web?platform=Web#join-and-leave-a-chat-group) to add a contact or join a chat group.

## Next steps

This section includes more advanced features you can implement in your project.

### Applicable use cases

As a conversation component, `EaseChat` can be applied in a wide range of use cases, for example, by popping up the dialogue box for a click event, or adding callback events after the user is logged in.

```javascript
import React, { useState } from "react";
import { EaseChat } from "agora-chat-uikit";
	const addListen = (res) => {
    if(res.isLogin){
       	const WebIM = EaseChat.getSdk()
        WebIM.conn.addEventHandler('testListen',{
          onTextMessage:()=>{},
          onError:()=>{},
          ...
        })
     }
  }
	const chat = () => {
		return (
		<div>
      <EaseChat
        appkey={'xxx'}
        username={'xxx'}
        agoraToken={'xxx'}
        to={'xxx'}
				successLoginCallback={addListener}
      />
     <div/>
		)
	}
	const app = () =>{
	const [showSession, setShowSession] = useState(false);
	return(
	<div>
		{ showSession && chat()}
		<button onClick={()=>setShowSession(true)}>Launch the session</button>
		<button onClick={()=>setShowSession(false)}>Close the session</button>
	<div/>
	)
	}
```

### Customizable attributes

`EaseChat` provides the following attributes for customization. You can customize the features and layout by setting these attributes. To ensure the functionality of `EaseChat`, ensure that you set all the required parameters.

| Attribute  |Type| Required | Description                                                 |
| ---------- | ------ | ------ | ------------------------------------- |
| `appkey`     |String| Yes  | The unique identifier that the Chat service assigns to each app. The rule is `$(OrgName)#{AppName}`. |
| `username`   |String| Yes  | The user ID.                                                     |
| `agoraToken` |String| Yes  | The Agora token.      |
| `to`         |String| Yes  | In one-to-one messaging, it is the user ID of the recipient; in group chat, it is the group ID.|
| `showByselfAvatar`|Bool| No  | Whether to display the avatar of the current user.<ul><li>`true`: Yes</li><li>(Default) `false`: No</li></ul>     |
| `easeInputMenu`|String| No | The mode of the input menu.<ul><li>(Default) `all`: The complete mode.</li><li>`noAudio`: No audio.</li><li>`noEmoji`: No emoji.</li><li>`noAudioAndEmoji`: No audio or emoji.</li><li>`onlyText`: Only text.</li></ul>
|`menuList`|Array| No  |The extensions of the input box on the right panel.<br/>(Default) `menuList`: `[ {name:'Send a pic', value:'img'},{name:'Send a file', value:'file'}]`  |
|`handleMenuItem`|function({item, key}) | No | The callback event triggered by clicking on the right panel of the input box.|
|`successLoginCallback`|function(res) | No | The callback event for a successful login. |
|`failCallback`| function(err)| No | The callback event for a failed method call.  |

### Add business logic

In scenarios where you want to add your own business logic, you can use the various callback events provided by the Chat UIKit, as shown in the following steps:

1. Get the SDK instance

    ```javascript
    const WebIM = EaseChat.getSdk({ appkey: 'xxxx' })
    ```

2. Add callback events

   Call `addEventHandler` to add the callback events.

    ```javascript
    // Use nameSpace to differentiate the different business logics. You can add multiple callback events according to your needs.。
    WebIM.conn.addEventHandler('nameSpace'),{ 
        onOpend:()=>{},
        onTextMessage:()=>{}, 
        .... })
    ```

Refer to [EventHandlerType](https://docs.agora.io/en/agora-chat/API%20Reference/im_ts/v1.0.5/modules/EventHandler.html?transId=4977acf0-08eb-11ed-a46a-e58831549a58) for the complete list of callback events you can add.


## Reference

Agora Chat provides an open-source [AgoraChat](https://github.com/AgoraIO-Usecase/AgoraChat-web) sample project on GitHub that has integrated the UIKit. You can download the project to try it out or view the source code.





