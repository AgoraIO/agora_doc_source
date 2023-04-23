# Get Started with Agora Chat

Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows a sample code to add peer-to-peer messaging into a game by using the Agora Chat SDK for Unity.

## Understand the tech

The following figure shows the workflow of how clients send and receive peer-to-peer messages.

![](https://web-cdn.agora.io/docs-files/1636443945728)

As shown in the figure, the workflow of peer-to-peer messaging is as follows:

1. Clients retrieve a token from your app server.
2. Client A and Client B log in to Agora Chat.
3. Client A sends a message to Client B.
4. The message is sent to the Agora Chat server and the server delivers the message to Client B.
5. When Client B receives the message, the SDK triggers an event. Client B listens for the event and gets the message.

## Prerequisites

In order to follow the procedure in this page, you must have the following:

- A valid Agora [account](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-account)
- An Agora [project](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-project) with an [App Key](https://docs.agora.io/en/agora-chat/get-started/enable#get-the-information-of-the-chat-project) that has [enabled the Chat service](https://docs.agora.io/en/agora-chat/get-started/enable) 
- [Unity Hub](https://unity.com/download)
- Unity Editor 2019.4.28 or later 
- Target platform:
  - iOS:
    - iOS Build Support module
    - Xcode 9.0 or later
  - macOS:
    - Xcode 9.0 or later
    - macOS 10.0 or later
  - Android:
    - Android 4.1 or later
    - Android Studio 3.0 or later
  - Windows:
    - Windows 7 or later
- A computer with Internet access  
Ensure that no firewall is blocking your network communication; otherwise, the project may fail. For details, see [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Unity).


## Token generation

This section introduces how to register a user at Agora Console and generate a temporary token.

### 1. Register a user

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


### 2. Generate a user token

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

This section shows how to prepare the development environment necessary to integrate Agora Chat into your game.

### 1. Download the Unity sample project

1. Clone the [Unity demo repository](https://github.com/AgoraIO/Agora-Chat-API-Examples) to your local device.

2. In Unity Hub, select the **Projects** tab, click the down arrow next to the **Open** button, and select **Add project from disk** from the drop-down list. In the pop-up window, select the path to the downloaded `chat_unity_quickstart` folder under `Agora-Chat-API-Examples/Chat-Unity` to add the sample project into Unity Hub.

3. In the **Projects** list, select **chat_unity_quickstart** to open the project.

<div class="alert info">
If your Unity Editor version is inconsistent with that of the sample project, do the following:
<ul><ol>1. In the <b>Editor version not installed</b> dialog box, select <b>Choose another Editor version</b>.</ol><ol>2. In the <b>Select Editor version and platform</b> dialog box, select the version of your Unity Editor, and follow the prompts to open the project.</ol></ul>
</div>

### 2. Integrate the Agora Chat SDK

1. Go to the [SDK download page](https://docs.agora.io/en/sdks?platform=unity) to download the Chat SDK, and download the latest version of the Agora Chat SDK package for Unity, and decompress it.

2. In Unity Editor, click **Assets** > **Import Package** > **Custom Package...**, and select the decompressed SDK.

3. In the **Import Unity Package** pop-up window, select all the items contained in the SDK, and click **Import**.

## Implement peer-to-peer messaging

This section shows how to use the Chat SDK to implement peer-to-peer messaging into your game, step-by-step.

### 1. Add namespaces

In Unity Editor, select the **Project** tab, select **Assets** > **Scripts**, and double-click the `TestCode.cs` file.

At the top lines of the `TestCode.cs` file, add the following:

```c#
using AgoraChat;
using AgoraChat.MessageBody;
```

### 2. Initiate the SDK

In the `InitSDK` method, add the following to initialize the SDK:

```c#
// Replaces APPKEY with your own App Key.
Options options = new Options("APPKEY");
options.UsingHttpsOnly = true;
SDKClient.Instance.InitWithOptions(options);
```

### 3. Log in to an account

At the end of the `SignInAction` method, add the following to add the login logic:

```c#
SDKClient.Instance.LoginWithAgoraToken(username: Username.text, AgoraToken.text, callback: new CallBack(
    onSuccess: () => {
        AddLogToLogText("sign in sdk succeed");
    },
    onError: (code, desc) => {
        AddLogToLogText($"sign in sdk failed, code: {code}, desc: {desc}");
    }
));
```

### 4. Send messages

At the end of the `SendMessageAction` method, add the following to add the creating and sending logics for messages:

```c#
Message msg = Message.CreateTextSendMessage(SignChatId.text, MessageContent.text);
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    AddLogToLogText($"send message succeed, receiver: {SignChatId.text},  message: {MessageContent.text}");
  },
  onError:(code, desc) => {
    AddLogToLogText($"send message failed, code: {code}, desc: {desc}");
  }         
));
```

### 5. Receive messages

To add the receiving logic for messages, refer to the following steps:

1. Declare and inherit the `IChatManagerDelegate` class. The sample code is as follows:

```c#
public class TestCode : MonoBehaviour, IChatManagerDelegate
```

2. Add the following callbacks to the `TestCode` class:

```c#
public void OnMessagesReceived(List<Message> messages)
    {
        foreach (Message msg in messages) {
            if (msg.Body.Type == MessageBodyType.TXT)
            {
                TextBody txtBody = msg.Body as TextBody;
                AddLogToLogText($"received text message: {txtBody.Text}, from: {msg.From}");
            }
            else if (msg.Body.Type == MessageBodyType.IMAGE)
            {
                ImageBody imageBody = msg.Body as ImageBody;
                AddLogToLogText($"received image message, from: {msg.From}");
            }
            else if (msg.Body.Type == MessageBodyType.VIDEO) {
                VideoBody videoBody = msg.Body as VideoBody;
                AddLogToLogText($"received video message, from: {msg.From}");
            }
            else if (msg.Body.Type == MessageBodyType.VOICE)
            {
                VoiceBody voiceBody = msg.Body as VoiceBody;
                AddLogToLogText($"received voice message, from: {msg.From}");
            }
            else if (msg.Body.Type == MessageBodyType.LOCATION)
            {
                LocationBody localBody = msg.Body as LocationBody;
                AddLogToLogText($"received location message, from: {msg.From}");
            }
            else if (msg.Body.Type == MessageBodyType.FILE)
            {
                FileBody fileBody = msg.Body as FileBody;
                AddLogToLogText($"received file message, from: {msg.From}");
            }
        }
    }
    public void OnCmdMessagesReceived(List<Message> messages)
    {
    }
    public void OnMessagesRead(List<Message> messages)
    {
    }
    public void OnMessagesDelivered(List<Message> messages)
    {
    }
    public void OnMessagesRecalled(List<Message> messages)
    {
    }
    public void OnReadAckForGroupMessageUpdated()
    {
    }
    public void OnGroupMessageRead(List<GroupReadAck> list)
    {
    }
    public void OnConversationsUpdate()
    {
    }
    public void OnConversationRead(string from, string to)
    {
    }
    public void MessageReactionDidChange(List<MessageReactionChange> list)
    {
    }
```

3. In the `AddChatDelegate` method, add the following:

```c#
// Add the listener for the `TestCode` object
SDKClient.Instance.ChatManager.AddChatManagerDelegate(this);
```

4. In the `RemoveChatDelegate` method, add the following:

```c#
// Remove the listener when the object is released
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(this);
```

### 6. Log out of the account

In the `SignOutAction` method, add the following:

```c#
SDKClient.Instance.Logout(true, callback: new CallBack(
  onSuccess: () => {
      AddLogToLogText("sign out sdk succeed");
  },
  onError: (code, desc) => {
      AddLogToLogText($"sign out sdk failed, code: {code}, desc: {desc}");
  }
));
```

<a name="test"></a>

## Run and test the project

In Unity Editor, select the **Project** tab, select **Assets** > **Scenes**, double-click the `SampleScene.cs` file, and click the **Play** icon at the top of the Unity Editor to run the project.

<div class="alert info">If you have not installed iOS Build Support, remove the <code>iOSBuildSetting.cs</code> file (Path: <code>Assets/ChatSDK/Scripts/Editor</code>) from the project folder before running the project.</div>

If the sample project runs properly, the following user interface appears:

![img](https://web-cdn.agora.io/docs-files/1665382378998)

In the user interface, perform the following operations to test the project:

1. Log in  
Fill in the user ID of the sender (`my_sender_unity`) in the **user id** box and agora token in the **token** box, and click **Sign in** to log in to the app.

2. Send a message  
Fill in the user ID of the receiver (`my_receiver_unity`) in the **single chat id** box and type in the message ("hello world!") to send in the **message content** box, and click **Send** to send the message.

3. Log out  
Click **Sign out** to log out of the app.

4. Receive the message  
After signing out, log in as the receiver (`my_receiver_unity`) and receive the message ("hello world!") sent in step 2.

You can check the log to see all the operations from this example, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1665386342781)

## Next steps

For demonstration purposes, Agora Chat uses temporary tokens generated from Agora Console for authentication in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=Unity#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](../Develop/Authentication).
