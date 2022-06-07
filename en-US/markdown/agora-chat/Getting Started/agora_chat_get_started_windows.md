# Get Started with Agora Chat

Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows a sample code to add peer-to-peer messaging into a Windows project by using the Agora Chat SDK.

## Understand the tech

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

In order to follow the procedure in this page, you must have the following:

- A Windows device running Windows 10 or later
- Visual Studio IDE 2019 or later
- .Net Framework 4.5.2 or later, or .Net Core 5.0 or later

<div class="alert note">If your network has a firewall, make sure that you open the ports specified in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a>.</div>

## Project setup

This section shows how to prepare the development environment necessary to integrate Agora Chat into your project.

### 1. Download the Windows sample project

1. Clone the [Windows demo repository](https://github.com/AgoraIO/Agora-Chat-API-Examples) to your local device.
2. Locate the `windows-example` folder in the downloaded repository, and double-click to open the `windows-example.sln` file in **Visual Studio**.
3. In the top menu of **Visual Studio**, select **Active solution configuration** as **Debug** and **Active solution platform** as **x64**.

### 2. Integrate the Agora Chat SDK

1. Go to the [SDK download page](https://downloadsdk.easemob.com/downloads/SDK/WinSDK/agora_chat_sdk.1.0.2-beta.nupkg) to download the NuGet package to your local device.

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

<div class="alert note">
A <code>JsonConvert.Undefined</code> error occurs when Newtonsoft.Json has not been imported to your project. Follow these steps to fix this issue:
<ol>1. Right-click <b>windows-example</b>, and select <b>Manage NuGet Packages...</b> in the drop-down menu.</ol>
<ol>2. In the <b>Installed</b> tab of the <b>NuGet: windows-example</b> page, select the <b>Newtonsoft.Json</b> entry, and click <b>Uninstalled</b>.</ol>
<ol>3. In the <b>Browse</b> tab of the <b>NuGet: windows-example</b> page, search <b>Newtonsoft.Json</b>, and click <b>Install</b> to reinstall Newtonsoft.Json.</ol>
</div>

At the top lines of the `MainWindow.xaml.cs` file, add the following:

```c#
using ChatSDK;
using ChatSDK.MessageBody;
```

### 2. Initialize the SDK

In the `InitSDK` function, add the following to initialize the SDK:

```c#
// In this sample project, replace `APPKEY` with `41117440#383391`.
var options = new Options(appKey: "APPKEY");
options.UsingHttpsOnly = true;
SDKClient.Instance.InitWithOptions(options);
```

### 3. Sign up an account

At the end of the `SignUp_Click` function, add the following to add the sign-up logic:

```c#
bool result = await RegisterToAppServer(UserIdTextBox.Text, PasswordTextBox.Text);
if (result)
{
    AddLogToLogText("sign up succeed");
}
else
{
    AddLogToLogText("sign up failed");
}
```

### 4. Log in to an account

At the end of the `SignIn_Click` function, add the following to add the login logic:

```c#
// Call `LoginToAppServer` to retrieve the Agora token.
string token = await LoginToAppServer(UserIdTextBox.Text, PasswordTextBox.Text);
if (token != null)
{
    // Call `LoginWithAgoraToken` to log in to the Chat service with username and Agora token.
   SDKClient.Instance.LoginWithAgoraToken(UserIdTextBox.Text, token, handle: new CallBack(
        onSuccess: () =>
        {
            AddLogToLogText("sign in sdk succeed");
        },
        onError: (code, desc) =>
        {
            AddLogToLogText($"sign in sdk failed, code: {code}, desc: {desc}");
        }
    ));
}
else
{
    AddLogToLogText($"fetch token error");
}
```

### 5. Log out of an account

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

### 6. Send messages

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

### 7. Receive messages

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

## Run and test the project

At the top of **Visual Studio**, click the **Start** button. If the sample project runs properly, the following user interface appears:

![](https://web-cdn.agora.io/docs-files/1654504518175)

In the user interface, perform the following operations to test the project:

1. Sign up  
Fill in the username in the **user id** box and password in the **password** box, and click **Sign up** to register an account. In this example, register two accounts (`my_sender` and `my_receiver`) to enable sending and receiving messages.

2. Log in  
After signing up the accounts, fill in the username in **user id** box and password in the **password** box, and click **Sign in** to log in to the app. In this example, log in as `my_sender`.

3. Send a message  
Fill in the username of the receiver (`my_receiver`) in the **single chat id** box and type in the message ("hello world") you want to send in the **message content** box, and click **Send** to send the message.

4. Sign out  
Click **Sign out** to log out of the app.

5. Receive the message  
After signing out as `my_sender`, log in as `my_receiver` and receive the message ("hello world") sent in step 3.

You can check the log to see all the operations from this example, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1654075808753)

## Next steps

1. Generate a user token  
For demonstration purposes, Agora Chat provides an app server that enables you to quickly retrieve a token using the App Key given in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=Unity#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to the Agora Chat service. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](./generate_user_tokens).

2. Avoid blocked callbacks  
Each callback of an Agora Chat client instance is triggered from internal threads. Therefore, to avoid blocking internal threads, Agora recommends that you execute your operations in other threads when callbacks are triggered.