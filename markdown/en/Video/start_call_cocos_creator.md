---
title: Start a Video Call
platform: Cocos Creator
updatedAt: 2020-12-15 10:01:54
---
This article describes how to build a Cocos Creator project that implements a video call using the Agora Cocos Creator SDK.

## Prerequisites

- [Cocos Creator](https://docs.cocos.com/creator/manual/en/getting-started/install.html) 2.3.4 or later (the interface description in this article is based on Cocos Creator 2.4.3).

- [Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

- Operating system and IDE requirements:

  | Target Platform | Operating system version | IDE version                                                  |
  | :-------------- | :----------------------- | :----------------------------------------------------------- |
  | Android         | Android 4.1 or later     | <li>Android Studio 3.0 or later</li><li>Android SDK API 16 or later</li><li>Android NDK 17 or later</li> |
  | iOS             | iOS 8.0 or later         | Xcode 9.0 or later                                           |

- A valid [Cocos account](https://account.cocos.com/) and a [Cocos App ID](https://docs.cocos.com/creator/manual/en/cocos-service/#usage).

  <div class="alert note">If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=Cocos%20Creator">Firewall Requirements</a > to access Agora services.</div>

## Create a Cocos Creator project

Use the following steps to build a project from scratch:

1. Open Cocos Creator, and navigate to **New Project**.
2. Choose an example (**Hello World** shown here), choose a storage path, and enter a project name.
3. Click **Create**.

## Integrate the SDK

1. Open a Cocos Creator project, and click **Service** on the right to open the **Service** panel.
2. Click the ![](https://web-cdn.agora.io/docs-files/1603983326448) button following **AppID**, and click **Set Cocos AppID**.
  ![](https://web-cdn.agora.io/docs-files/1603983352672)
3. Click the drop-down box, select a game, and click **Association** to associate your project with your game.
4. On the **Service** panel, scroll down to find and click **Agora RTC**.
5. Click the ![](https://web-cdn.agora.io/docs-files/1603983397604) button following **Agora RTC**, read the prompts carefully, and click **Open Service**.
6. On the bottom of the **Agora RTC** panel, select **Video** as the SDK type, and click **Save** to integrate the Agora Cocos Creator SDK.

After integrating the Agora Cocos Creator SDK, Cocos Creator automatically adds codes in your project for obtaining device permissions, so you do not need to write these codes yourself.

Cocos Creator also uses your Cocos Creator account to automatically register an Agora account and create an Agora project. You can click **Dashboard** on the **Agora RTC** panel to visit Agora Console.

## <a name="configure"></a>Configure the Agora project

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes. The following steps show how to generate a temporary token:

1. On the [Project Management](https://dashboard.agora.io/projects) page of the Agora Console, find your project, and click the **Edit** button on the right to open the **Edit Project** page.
![](https://web-cdn.agora.io/docs-files/1606313609887)
2. In the **Security** module, click **Enable** to enable the primary certificate, and click **Delete** to delete **No certificate**.
3. In the **Features** module, click **Generate temp token** following the **Temp token for audio/video call**.
4. On the **Token** page, enter a channel name (such as **test**), and click **Generate Temp Token** to get a temporary token. You can use the Agora App ID to [initialize the Agora engine](#initialize) and the temporary token for authentication when [joining a channel](#join).

<div class="alert note"><li>Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours.</li><li>In a production environment, you need to deploy your own server for generating tokens. See <a href="https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=Cocos%20Creator">Generate a Token</a > for details.</li></div>

## Implementation

Once the project is set up, create a component script and a scene based on your requirements, and add the script into the scene node. See [Creating and using component script](https://docs.cocos.com/creator/manual/en/scripting/use-component.html).

You can use core APIs of the Agora Cocos Creator SDK in the `Script/HelloWorld.js` component script to implement a basic video call. The following figure shows the API call sequence:

![](https://web-cdn.agora.io/docs-files/1606315461579)

### <a name="initialize"></a>1. Initialize the Agora engine

Initialize the Agora engine before calling any other Agora APIs. You need to pass in the Agora App ID obtained from the [Configure the Agora project](#configure) section.

Call `init` and pass in the App ID to initialize the Agora engine.

According to your requirements, you can also listen for callback events in this step, such as when the local user joins or leaves the channel.

```typescript
cc.Class({
 
    ...
 
    onLoad: function () {
        // Initialize the Agora engine. Replace YOUR_APPID with the App ID of your Agora project.
        agora.init('YOUR_APPID');
        agora.on('joinChannelSuccess', this.onJoinChannelSuccess, this);
        agora.on('leaveChannel', this.onLeaveChannel, this);
        agora.on('userJoined', this.onUserJoined, this);
        agora.on('userOffline', this.onUserOffline, this);
    },
 
    ...
});
```

### 2. Set the local video view

To make the user see the local video before starting the interactive live streaming, you need to set the local video view before joining a channel. Use the following steps:

1. In `HelloWorld.js`, call `enableVideo` to enable the video module and `startPreview` to start the local video preview.

   ```typescript
   cc.Class({
    
       ...
    
       onLoad: function () {
    
           ...
    
           // Enable the video module.
           agora.enableVideo();
           // Start the local video preview.
           agora.startPreview();
       },
    
       ...
   });
   ```

2. In Cocos Creator, navigate to **Node Library** > **Cloud Nodes**, and add **AgoraVideoRender** to the **Scene**.

### <a name="join"></a>3. Join a channel

After setting the local video view, do the following to join a channel:

1. In Cocos Creator, add a button for joining or leaving a channel. navigate to **Node Library** > **Builtin Nodes**, and add a **Button** component to the **Scene**.

2. On the **Node Tree** panel, click **button** > **Background** > **Label**. On the **Properties** panel, find **Label** > **String**, and modify the string to **Join a channel**.

3. In `HelloWorld.js`, define a `clickButton` method to set the events when clicking the button.

   ```typescript
   cc.Class({
    
       ...
    
       // Set the events when clicking the button
       // If the user joins a channel, the joined variable is true, and the SDK calls leaveChannel when the user clicks the button.
       // If the user leaves a channel, the joined variable is false, and the SDK calls joinChannel when the user clicks the button.
       clickButton: function () {
           if (this.joined) {
               this.leaveChannel();
           } else {
               this.joinChannel();
               }
       },
    
       ...
   });
   ```

4. Call `joinChannel`, and enter a token, a channel name, and a user ID.

   ```typescript
   cc.Class({
    
       ...
    
       joinChannel: function () {
           // Join a channel
           // Replace YOUR_TOKEN with the token you generated
           // Replace CHANNEL_NAME with the channel name that you use to generate the token.
           // Enter a user ID in uid.
           agora.joinChannel('YOUR_TOKEN', 'CHANNEL_NAME', '', uid);
       },
    
       ...
   });
   ```

5. In the `onJoinChannelSuccess` callback, add the logic to judge whether the local user joins the channel to dynamically change the label of the **button** component. Note that you need to remove the original definition of the label in `HelloWorld.js` as follows:

   - In `Properties`, remove `text: 'Hello, World!'`.
   - In `onLoad`, remove `this.label.string = this.text;`.

   ```typescript
   cc.Class({
    
       ...
    
       // Occurs when a local user joins a channel.
       onJoinChannelSuccess: function (channel, uid, elapsed) {
           // After the user leaves the channel, the label of the button changes to Leave the channel.
           this.joined = true;
           this.label.string = 'Leave the channel';
       },
    
       ...
   });
   ```

6. Return to **Cocos Creator**, and click **Canvas** on the **Node Tree** panel. On the **Properties** panel, find the **HelloWorld** component script, and add the **Label** of the **button** component to the script to dynamically modify the label of the button.
   ![](https://web-cdn.agora.io/docs-files/1606314807023)
7. On the **Node Tree** panel, click **button**, find **Button** > **Check Events** on the **Properties** panel, and add a check event.

8. Add the **Canvas** to the **cc.Node** property box of the check event. In the two drop-down boxes following the **cc.Node** property box, select the scene (**HelloWorld**) and the check event (**clickButton**) in turn.

### 4. Set the remote video view

During the video call, you should be able to see all users.

Shortly after a remote user joins the channel, the SDK gets the user's user ID in the `onUserJoined` callback. You can set the remote video view as follows:

1. In `HelloWorld.js`, import the `AgoraVideoRender` cloud component to render the remote video view. In the `onUserJoined` and `onUserOffline` callbacks, add logic to judge whether Cocos Creator renders the remote video.

   ```typescript
   // Import the AgoraVideoRender cloud component.
   const AgoraVideoRender = require('AgoraVideoRender');
    
   cc.Class({
        
       ...
    
       properties: {
    
           ...
    
           // Add a remote video view.
           target: {
               default: null,
               type: cc.Prefab
           }
       },
        
       ...
    
       // Occurs when a remote user joins the channel. This callback gets the user ID of the remote user.
       onUserJoined: function (uid, elapsed) {
           if (this.remoteUid === undefined) {
               this.remoteUid = uid;
               // Add a Prefab.
               const render = cc.instantiate(this.target);
               // Set the uid of the AgoraVideoRender component to the uid of the remote user.
               render.getComponent(AgoraVideoRender).uid = this.remoteUid;
               // Add AgoraVideoRender component to the Scene
               cc.director.getScene().addChild(render, 0, `uid:${this.remoteUid}`);
               // Set the size of the remote video view.
               render.setContentSize(160, 120);
               // Set the position of the remote video view.
               render.setPosition(300, 120);
           }
       },
    
       // Occurs when a remote user leaves the channel.
       onUserOffline: function (uid, reason) {
           if (this.remoteUid === uid) {
               // When a remote user leaves the channel, set the uid to undefined.
               cc.director.getScene().getChildByName(`uid:${this.remoteUid}`).destroy();
               this.remoteUid = undefined;
           }
       },
    
       ...
   });
   ```
   
2. In Cocos Creator, click **Canvas** on the **Node Tree** panel. On the **Assets** panel, find **assets** > **cloud-component** > **AgoraVideoRender** > **AgoraVideoRender.prefab**, and add it to **HelloWorld** > **Target** of **Canvas**.
   ![](https://web-cdn.agora.io/docs-files/1606314817942)

### 5. Leaves the channel

Call the `leaveChannel` method to leave the current channel according to your scenario, for example, when the interactive streaming ends, when you need to close the app, or when your app runs in the background.

After leaving the channel, if you want to exit the app or release the memory of the Agora engine, call `release` to destroy the Agora engine.

```typescript
cc.Class({
 
    ...
 
    leaveChannel: function () {
        // Leaves the channel
        agora.leaveChannel();
        if (this.remoteUid !== undefined) {
            // Remove the remote video view.
            cc.director.getScene().getChildByName(`uid:${this.remoteUid}`).destroy();
            this.remoteUid = undefined;
        }
        // After the local user leaves the channel, the label of the button changes to Join a channel.
        this.joined = false;
        this.label.string = 'Join a channel';
        // Destroy the Agora engine.
        agora.release();
    },
     
    // Occurs when the local user leaves the channel.
    onLeaveChannel: function (stats) {}
 
    ...
});
```

## Run the project

Agora recommends running and debugging your project through a physical Android or iOS device. See [Publish to native](https://docs.cocos.com/creator/manual/en/publish/publish-native.html).

For example, to build and run an iOS project, you can do the following:

1. In Cocos Creator, click **Project** > **Build**.
2. Enter the title (such as **hello_world**), the platform, and the build path, and click **Build**.
3. Once the build is completed, click the **Open** button at the right of the **Build Path** to open the `build` folder.
4. Under the `./jsb-link/frameworks/runtime-src/proj.ios_mac` path, find and open your iOS project (such as `hello_world.xcworkspace`).
5. In Xcode, select your iOS device, and click the button to build and run your project. After the project runs successfully run the project, you can see your video.
6. If you want to experience a video call, you can also use the [Agora Web sample app](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/) to interact with your iOS device. Ensure that you enter the same App ID, channel name, and temporary token in the Agora Web sample app as in your iOS project.

When the video call starts successfully, you can see your video and the video of other users in the app.

## See also

Agora provides an open-source [Agora-Cocos-Quickstart/CocosCreator](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/CocosCreator) sample project on GitHub that implements a basic one-to-one video call. You can download the demo project as a code source reference.