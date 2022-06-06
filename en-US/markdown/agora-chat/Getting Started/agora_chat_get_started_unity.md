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
- A computer that can access the Internet.  
Ensure that no firewall is blocking your network communication; otherwise, the project may fail. For details, see [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Unity).

## Project setup

This section shows how to prepare the development environment necessary to integrate Agora Chat into your game.

### 1. Download the Unity sample project

1. Clone the [Unity demo repository](https://github.com/easemob/chat_unity_demo) to your local device.

2. In Unity Hub, select the **Projects** tab, click the down arrow next to the **Open** button, and select **Add project from disk** from the drop-down list. In the pop-up window, select the path to the downloaded `chat_unity_quickstart` folder to add the sample project into Unity Hub.

3. In the **Projects** list, select **chat_unity_quickstart** to open the project.

<div class="alert info">
If your Unity Editor version is inconsistent with that of the sample project, do the following:
<ul><ol>1. In the <b>Editor version not installed</b> dialog box, select <b>Choose another Editor version</b>.</ol><ol>2. In the <b>Select Editor version and platform</b> dialog box, select the version of your Unity Editor, and follow the prompts to open the project.</ol></ul>
</div>

### 2. Integrate the Agora Chat SDK

1. Go to the [SDK download page](./downloads?platform=Unity), and download the latest version of the Agora Chat SDK package for Unity, and decompress it.

2. In Unity Editor, click **Assets** > **Import Package** > **Custom Package...**, and select the decompressed SDK.

3. In the **Import Unity Package** pop-up window, select all the items contained in the SDK, and click **Import**.

## Implement peer-to-peer messaging

This section shows how to use the Chat SDK to implement peer-to-peer messaging into your game, step-by-step.

### 1. Add namespaces

In Unity Editor, select the **Project** tab, select **Assets** > **Scripts**, and double-click the `TestCode.cs` file.

At the top lines of the `TestCode.cs` file, add the following:

```c#
using ChatSDK;
using ChatSDK.MessageBody;
```

### 2. Initiate the SDK

In the `InitSDK` method, add the following to initialize the SDK:

```c#
// In this sample project, replace `APPKEY` with `easemob-demo#easeim`.
var options = new Options(appKey: "APPKEY");
SDKClient.Instance.InitWithOptions(options);
```

### 3. Sign up an account

At the end of the `SignUpAction` method, add the following to add the sign-up logic:

```c#
SDKClient.Instance.CreateAccount(username: Username.text, Password.text, handle: new CallBack(
  onSuccess: () => {
    AddLogToLogText("sign up sdk succeed");
  },
  onError: (code, desc) => {
    AddLogToLogText($"sign up sdk failed, code: {code}, desc: {desc}");
  }
));
```

### 4. Log in to an account

At the end of the `SignInAction` method, add the following to add the login logic:

```c#
SDKClient.Instance.Login(username: Username.text, pwdOrToken: Password.text, handle: new CallBack(
  onSuccess: () => {
    AddLogToLogText("sign in sdk succeed");
  },
  onError:(code, desc) => {
    AddLogToLogText($"sign in sdk failed, code: {code}, desc: {desc}");
  }
));
```

### 5. Send messages

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

### 6. Receive messages

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

## Run and test the project

In Unity Editor, select the **Project** tab, select **Assets** > **Scenes**, double-click the `SampleScene.cs` file, and click the **Play** icon at the top of the Unity Editor to run the project.

<div class="alert info">If you have not installed iOS Build Support, remove the <code>iOSBuildSetting.cs</code> file (Path: <code>Assets/ChatSDK/Scripts/Editor</code>) from the project folder before running the project.</div>

If the sample project runs properly, the following user interface appears:

![](https://web-cdn.agora.io/docs-files/1652780330067) 

In the user interface, perform the following operations to test the project:

1. Sign up  
Fill in the username in the `user id` box and password in the `password` box, and click **Sign up** to register an account. In this example, register two accounts (`local_user` and `remote_user`) to enable sending and receiving messages.

2. Log in  
After signing up the accounts, fill in the username in the `user id` box and password in the `password` box, and click **Sign in** to log in to the app. In this example, log in as `local_user`.

3. Send a message
Fill in the username of the receiver (`remote_user`) in the `single chat id` box and type in the message ("hello world") to send in the `message content` box, and click **Send** to send the message.

4. Sign out  
Click **Sign out** to log out of the app.

5. Receive the message  
After signing out as `local_user`, log in as `remote_user` and receive the message ("hello world") sent in step 3.

You can check the log to see all the operations from this example, as shown in the following figure:
![](https://web-cdn.agora.io/docs-files/1652781638358)

## Next steps

For demonstration purposes, Agora Chat provides an app server that enables you to quickly retrieve a token using the App Key given in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=Unity#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](./generate_user_tokens).