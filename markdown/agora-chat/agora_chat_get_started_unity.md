# 发送和接收一对一文本消息

本文介绍如何快速集成 Agora 即时通讯 SDK，在你的 Unity 项目中实现发送和接收单聊文本消息。

## 技术原理

下图展示在客户端发送和接收单聊文本消息的工作流程。

![](https://web-cdn.agora.io/docs-files/1652784221855)

如上图所示，发送和接收单聊消息的步骤如下：

1. 客户端向你的应用服务器请求 Token，你的应用服务器返回 Token。
2. 客户端 A 和客户端 B 使用获得的 Token 登录 Agora 即时通讯系统。
3. 客户端 A 发送消息到 Agora 即时通讯服务器。
4. Agora 即时通讯服务器将消息发送到客户端 B，客户端 B 接收消息。

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Unity Editor 2019.4.28 或以上版本
-  操作系统与编译器要求：

  | 开发平台 | 操作系统版本       | 编译器版本                    |
  | :------- | :----------------- | :---------------------------------- |
  | Android  | Android 4.1 或以上 | Android Studio 3.0 或以上           |
  | iOS      | iOS 9.0 或以上     | Xcode 9.0 或以上                    |
  | macOS    | macOS 10.0 或以上 | Xcode 9.0 或以上                    |
  | Windows  | Windows 7 或以上   | Microsoft Visual Studio 2017 或以上 |

<div class="alert note">如果你的网络环境部署了防火墙，请参考 <a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=Unity">应用企业防火墙限制</a> 以正常使用 Agora 服务。</div>

## 项目设置

本节介绍如何设置项目，将 Agora 即时通讯 Unity SDK 集成到你的项目中。

### 1. 下载并设置 Unity 示例项目

1. 克隆 [Unity 示例项目仓库](https://github.com/easemob/chat_unity_demo) 至本地。

2. 打开 Unity Hub，选择左侧 **Projects** 页签，点击 **Open** 右边的下拉菜单，选择 **Add project from disk**，然后选择仓库本地路径中的 `chat_unity_quickstart` 文件夹，将示例项目添加至 Unity Hub。

3. 在 **Projects** 列表中，点击 **chat_unity_quickstart** 打开项目。

<div class="alert info">
如果示例项目与本地 Unity Editor 版本不一致，你需要进行以下操作：
<ul><ol>1. 在弹出的 <b>Editor version not installed</b> 提示框下方，选择 <b>Choose another Editor version</b>。</ol><ol>2. 在弹出的 <b>Select Editor version and platform</b> 窗口中，选择本地安装的 Editor 版本，并根据后续提示打开项目。</ol></ul>
</div>

### 2. 集成 Agora 即时通讯 SDK

1. 前往 [SDK 下载页面](https://docs-preprod.agora.io/cn/agora-chat/downloads?platform=Unity)，下载最新版的 Agora 即时通讯 Unity SDK，然后解压。

2. 在 Unity Editor 的顶部菜单栏中，选择 **Assets** > **Import Package** > **Custom Package...**，然后选择解压的 Agora 即时通讯 SDK。

3. 在弹出的 **Import Unity Package** 窗口中，点击 **Import** 导入 SDK 包含的全部内容。

## 实现发送和接收单聊消息

本节介绍如何在你的 Unity 项目中实现发送和接收单聊消息。

### 1. 添加命名空间

在 Unity Editor 中，选择 **Project** 页签，选择 **Assets** > **Scripts**，双击打开 **TestCode.cs** 文件。

在 **TestCode.cs** 头部添加以下命名空间：

```c#
using ChatSDK;
using ChatSDK.MessageBody;
```

### 2. 初始化 SDK

在 `InitSDK` 方法中添加以下代码完成 SDK 初始化：

```c#
// 本示例中，将 `APPKEY` 替换为 `easemob-demo#easeim`
var options = new Options(appKey: "APPKEY");
SDKClient.Instance.InitWithOptions(options);
```

### 3. 注册账号

注册即时通讯系统的登录账号，在 `SignUpAction` 方法尾部添加以下代码：

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

### 4. 登录账号

使用账号登录即时通讯系统，在 `SignInAction` 方法尾部添加以下代码：

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

### 5. 发送消息

创建和发送文本消息，在 `SendMessageAction` 方法尾部添加以下代码：

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

### 6. 接收消息

接收消息需要对象继承 `IChatManagerDelegate`、实现相关的回调方法并将对象加入到监听列表中。具体步骤如下：

1. 在类声明的头部继承 `IChatManagerDelegate` 对象，示例代码如下：

```c#
public class TestCode : MonoBehaviour, IChatManagerDelegate
```

2. 在 `TestCode` 类内部添加回调方法，示例代码如下：

本项目仅用于演示消息接收回调，其他回调无需实现，保留空函数即可。

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

3. 在 `AddChatDelegate` 方法中添加以下代码：

```c#
// 将 `TestCode` 对象实例加入监听列表
SDKClient.Instance.ChatManager.AddChatManagerDelegate(this);
```

4. 在 `RemoveChatDelegate` 方法中添加以下代码：

```c#
// 在对象释放时将其在监听列表中移除
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(this);
```

## 运行和测试项目

在 Unity Editor 中，选择 **Project** 页签，选择 **Assets** > **Scenes**，双击 **SampleScene** 场景文件，然后点击 Unity Editor 上方的 Play 按钮运行场景。

<div class="alert info">如果没有安装 iOS Build Support，在运行项目前，将 `Assets/ChatSDK/Scripts/Editor` 路径下的 `iOSBuildSetting.cs` 文件移出项目文件夹。</div>

如运行成功，你可以看到以下界面：
![](https://web-cdn.agora.io/docs-files/1652780330067) 

接下来，你可以在该界面中进行下列操作：

1. 注册用户  
在 `user id` 文本框中输入用户 ID，在 `password` 文本框中输入密码，点击 **Sign up** 进行用户注册。创建两个用户 (例如 `local_user` 和 `remote_user`) 分别用于发送和接收消息。

2. 用户登录  
在 `user id` 文本框中输入用户 ID (例如 `local_user`),在 `password` 文本框中输入密码，点击 **Sign in** 登录。

3. 发送消息和接收消息
在 `single chat id` 文本框中输入消息接收方的用户 ID (例如 `remote_user`)，在 `message content` 文本框中输入要发送的文本内容 (例如 “hello world”)，点击 **Send** 发送消息。

在 `user id` 文本框中输入接收消息的用户 ID (例如 `remote_user`)，在 `password` 文本框输入密码，点击 **Sign in** 登录。登录成功后，下方会显示收到步骤 3 中发送的消息 (例如 “hello world”)。

4. 退出登录  
直接点击 **Sign out** 退出登录当前用户。

以上每一步操作均会在 log 中显示：
![](https://web-cdn.agora.io/docs-files/1652781638358)

## 更多操作

为方便演示，本文搭建的 Demo 中使用 username + password 的用户注册方式。在生产环境中，为保证通信安全，我们建议你使用 username + password + token 的方式进行用户注册。token 需要在你的服务端部署生成，并在客户端实现获取 token、token 过期后重新生成的逻辑。具体实现方式请参考 [使用 User Token 鉴权](./generate_user_tokens)。