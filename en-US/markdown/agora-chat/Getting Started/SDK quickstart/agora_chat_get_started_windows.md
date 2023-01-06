# Get Started with Agora Chat

Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows a sample code to add peer-to-peer messaging into a Windows project by using the Agora Chat SDK.

## Understand the tech

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

In order to follow the procedure in this page, you must have the following:

- A valid Agora [account](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-account)
- An Agora [project](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-project) with an [App Key](https://docs.agora.io/en/agora-chat/get-started/enable#get-the-information-of-the-chat-project) that has [enabled the Chat service](https://docs.agora.io/en/agora-chat/get-started/enable) 
- A Windows device running Windows 10 or later
- Visual Studio IDE 2019 or later
- .Net Framework 4.5.2 or later

<div class="alert note">If your network has a firewall, make sure that you open the ports specified in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a>.</div>


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

This section shows how to prepare the development environment necessary to integrate Agora Chat into your project.

### 1. Download the Windows sample project

1. Clone the [Windows demo repository](https://github.com/AgoraIO/Agora-Chat-API-Examples) to your local device.
2. Locate the `windows-example` folder in the downloaded repository, and double-click to open the `windows-example.sln` file in **Visual Studio**.
3. In the top menu of **Visual Studio**, select **Active solution configuration** as **Debug** and **Active solution platform** as **x64**.

### 2. Integrate the Agora Chat SDK

1. Go to the [SDK download page](https://docs.agora.io/en/sdks?platform=windows) to download the latest version of Chat SDK for Windows to your local device.

2. In **Solution Explorer** of **Visual Studio**, right-click **windows-example**, and select **Manage NuGet Packages...** in the drop-down menu.

3. On the **NuGet: windows-example** page, select the **Gear** icon at the top right.

4. In the **Options** pop-up window, click the **+** button at the top right to add a package source. Select the new package source, specify its name in the **Name** box, set its path to the parent directory where the downloaded Nuget package resides in the **Source** box, and click **OK**.

5. Go back to the **NuGet: windows-example** page, open the **Package source** drop-down list at the top right, and select the newly-added one.

6. In the **Browse** tab of the **NuGet: windows-example** page, check the **Include prerelease** box, select the **agora_chat_sdk** item displayed below (if not, refresh the page), and click **Install**.

7. In the pop-up **Preview Changes** windows, click **OK** to proceed and complete the installation.

## Implement peer-to-peer messaging

This section shows how to use the Chat SDK to implement peer-to-peer messaging into your Windows .NET project, step-by-step.

### 1. Add namespaces

In **Solution Explorer** of **Visual Studio**, select **windows-example** > **MainWindow.xaml**, and double-click to open the `MainWindow.xaml.cs` file.
At the top lines of the `MainWindow.xaml.cs` file, add the following:

```c#
using ChatSDK;
using ChatSDK.MessageBody;
```

### 2. Initialize the SDK

In the `InitSDK` function, add the following to initialize the SDK:

```c#
// Replaces APPKEY with your App Key.
var options = new Options(appKey: "APPKEY");
options.UsingHttpsOnly = true;
SDKClient.Instance.InitWithOptions(options);
```

### 3. Log in to an account

At the end of the `SignIn_Click` function, add the following to add the login logic:

```c#
// Calls `LoginWithAgoraToken` to log in to the Chat service with username and Agora token.
SDKClient.Instance.LoginWithAgoraToken(UserIdTextBox.Text, AgoraTokenBox.Text, handle: new CallBack(
    onSuccess: () =>
    {
        AddLogToLogText("sign in sdk succeed");
    },
    onError: (code, desc) =>
    {
        AddLogToLogText($"sign in sdk failed, code: {code}, desc: {desc}");
    }
));
```

### 4. Log out of an account

At the end of the `SignOut_Click` function, add the following to add the logout logic:

```c#
SDKClient.Instance.Logout(true, handle: new CallBack(
    onSuccess: () =>
    {
        AddLogToLogText("sign out sdk succeed");
    },
    onError: (code, desc) =>
    {
        AddLogToLogText($"sign out sdk failed, code: {code}, desc: {desc}");
    }
));
```

### 5. Send messages

At the end of the `SendBtn_Click` function, add the following to add the creating and sending logics for messages:

```c#
Message msg = Message.CreateTextSendMessage(SingleChatIdTextBox.Text, MessageContentTextBox.Text);
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
    onSuccess: () =>
    {
        // The success callback uses the System.Windows.Threading.Dispatcher to invoke UI elements `SingleChatIdTextBox.Text` and `MessageContentTextBox.Text`.
        Dip.Invoke(() =>
        {
            AddLogToLogText($"send message succeed, receiver: {SingleChatIdTextBox.Text},  message: {MessageContentTextBox.Text}");
        });
    },
    onError: (code, desc) =>
    {
        AddLogToLogText($"send message failed, code: {code}, desc: {desc}");
    }
));
```

### 6. Receive messages

To add the receiving logic for messages, refer to the following steps:

1. Declare and inherit the `IChatManagerDelegate` class. The sample code is as follows:

```c#
public partial class MainWindow : Window, IChatManagerDelegate
```

2. Add the following callbacks to the `MainWindow` class:

```c#
public void OnMessagesReceived(List<Message> messages)
{
    foreach (Message msg in messages)
    {
        if (msg.Body.Type == MessageBodyType.TXT)
        {
            TextBody txtBody = msg.Body as TextBody;
            AddLogToLogText($"received text message: {txtBody.Text}, from: {msg.From}");
        }
        else if (msg.Body.Type == MessageBodyType.IMAGE)
        {
            _ = msg.Body as ImageBody;
            AddLogToLogText($"received image message, from: {msg.From}");
        }
        else if (msg.Body.Type == MessageBodyType.VIDEO)
        {
            _ = msg.Body as VideoBody;
            AddLogToLogText($"received video message, from: {msg.From}");
        }
        else if (msg.Body.Type == MessageBodyType.VOICE)
        {
            _ = msg.Body as VoiceBody;
            AddLogToLogText($"received voice message, from: {msg.From}");
        }
        else if (msg.Body.Type == MessageBodyType.LOCATION)
        {
            _ = msg.Body as LocationBody;
            AddLogToLogText($"received location message, from: {msg.From}");
        }
        else if (msg.Body.Type == MessageBodyType.FILE)
        {
            _ = msg.Body as FileBody;
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

3. In the `AddChatDelegate` function, add the following:

```c#
// Add the listener for the `MainWindow` object.
SDKClient.Instance.ChatManager.AddChatManagerDelegate(this);
```

4. In the `RemoveChatDelegate`function, add the following:

```c#
// Remove the listener when the object is released.
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(this);
```	

<a name="test"></a>

## Run and test the project

At the top of **Visual Studio**, click the **Start** button. If the sample project runs properly, the following user interface appears:

![](https://web-cdn.agora.io/docs-files/1665386577667)

In the user interface, perform the following operations to test the project:

1. Log in  
Fill in the user ID of the sender (`my_sender_windows`) in the **user id** box and agora token in the **token** box, and click **Sign in** to log in to the app.

2. Send a message  
Fill in the user ID of the receiver (`my_receiver_windows`) in the **single chat id** box and type in the message ("hello world!") to send in the **message content** box, and click **Send** to send the message.

3. Log out  
Click **Sign out** to log out of the app.

4. Receive the message  
After signing out, log in as the receiver (`my_receiver_windows`) and receive the message ("hello world!") sent in step 2.

You can check the log to see all the operations from this example, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1665386618721)


## Next steps

1. Generate a user token  
For demonstration purposes, Agora Chat uses temporary tokens generated from Agora Console for authentication in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to the Agora Chat service. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](../Develop/Authentication).

2. Avoid blocked callbacks  
Each callback of an Agora Chat client instance is triggered from internal threads. Therefore, to avoid blocking internal threads, Agora recommends that you execute your operations in other threads when callbacks are triggered.
