# 即时通讯 IM 快速入门

即时通讯将各地人们连接在一起，实现实时通信。利用即时通讯 IM SDK，你可以在任何地方的任何设备上的任何应用中嵌入实时通讯。

本文介绍如何集成即时通讯 IM SDK，在你的 iOS app 中实现发送和接收单聊文本消息。

## 技术原理

~7aac3300-785d-11ec-bcb4-b56a01c83d2e~

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-账号)。
- 带有[开启了即时通讯 IM 服务](./enable_agora_chat)的 [App Key](./enable_agora_chat#获取即时通讯项目信息) 的 Agora [项目](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-项目)。
- Xcode。本文以 Xcode 13.0 为例进行介绍。
- 一台运行 iOS 10 或以上版本的设备。

## 生成 Token

### 注册用户

参考以下步骤注册用户：

1. 在**项目管理**页面，点击你要使用的项目的**操作**一栏中的**配置**按钮。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

3. 在左侧导航栏，选择**运营管理** > **用户**，点击**创建IM用户**。

![](https://web-cdn.agora.io/docs-files/1670827634437)

![](./images/quickstart/user_mgmt.png)

4. 在**创建IM用户**对话框中，填写用户信息并点击保存，创建用户。

![](https://web-cdn.agora.io/docs-files/1670827653548)

![](./images/quickstart/create_user.png)

### 生成 Token

为了保证通信安全，Agora 推荐使用 token 对登录即时通讯 IM 的用户进行认证。

出于测试目的，Agora 控制台支持为即时通讯 IM 生成临时 Token。要生成用户令牌，请执行以下操作：

1. 在**项目管理**页面，点击你要使用的项目的**操作**一栏中的**配置**按钮。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

3. 在**应用信息**页面的**Data Center**区域，在 **Chat User Temp Token** 框中输入用户 ID，点击 **Generate** 生成一个具有用户权限的 Token。

![](https://web-cdn.agora.io/docs-files/1670827712260)

![](./images/quickstart/generate_token.png)

<div class="alert note">为了在该 Demo 中测试使用，需注册两个用户，即发送方和接收方，并且分别为其生成 Token。</div>

## 项目设置

在本节中，我们准备了将即时通讯 IM 集成到你的 app 中所需的开发环境。

### 创建 iOS 项目

在 Xcode 中，参考以下步骤创建一个 iOS 应用项目。

- 打开 Xcode，单击 **Create a new Xcode project**。
- 平台类型选择 **iOS**，项目类型选择 **App**，然后单击 **Next**。
- 在本例中设置 **Storyboard** 和 **Swift**，创建项目。

### 集成即时通讯 IM SDK

1. 选择 **File** > **Swift Packages** > **Add Package Dependencies...**，粘贴以下 URL

```text
https://github.com/AgoraIO/AgoraChat_iOS.git
```

2. 在 **Choose Package Options** 中，设置你要使用的即时通讯 IM SDK 版本。

## 实现单聊聊天客户端

### 创建 UI

你需要实现 `ViewController`，创建所需的 UI 控件。

在 `ViewController.swift` 中，用以下代码替换文件中的内容：

<a name="sign-in"></a>

```swift
class ViewController: UIViewController {
    // 定义 UI 视图
    var userIdField, tokenField, remoteUserIdField, textField: UITextField!
    var loginButton, logoutButton, sendButton: UIButton!
    var logView: UITextView!

    func createField(placeholder: String?) -> UITextField {
        let field = UITextField()
        field.layer.borderWidth = 0.5
        field.placeholder = placeholder
        return field
    }

    func createButton(title: String?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    func createLogView() -> UITextView {
        let logTextView = UITextView()
        logTextView.isEditable = false
        return logTextView
    }

    func initViews() {
        // 创建 UI 控件。
        userIdField = createField(placeholder: "User Id")
        self.view.addSubview(userIdField)
        tokenField = createField(placeholder: "Token")
        self.view.addSubview(tokenField)
        remoteUserIdField = createField(placeholder: "Remote User Id")
        self.view.addSubview(remoteUserIdField)
        textField = createField(placeholder: "Input text message")
        self.view.addSubview(textField)
        loginButton = createButton(title: "Login", action: #selector(loginAction))
        self.view.addSubview(loginButton)
        logoutButton = createButton(title: "Logout", action: #selector(logoutAction))
        self.view.addSubview(logoutButton)
        sendButton = createButton(title: "Send", action: #selector(sendAction) )
        self.view.addSubview(sendButton)
        logView = createLogView()
        self.view.addSubview(logView)
        // 将 <#Input Your UserId#> 和 <#Input Your Token#> 替换为你自己的用户 ID 和在 Agora Console 上生成的 Token。
        self.userIdField.text = <#Input Your UserId#>
        self.tokenField.text = <#Input Your Token#>
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 定义 UI 布局控件。
        let fullWidth = self.view.frame.width
        userIdField.frame = CGRect(x: 30, y: 50, width: fullWidth - 60, height: 30)
        tokenField.frame = CGRect(x: 30, y: 100, width: fullWidth - 60, height: 30)
        loginButton.frame = CGRect(x: 30, y: 150, width: 80, height: 30)
        logoutButton.frame = CGRect(x: 230, y: 150, width: 80, height: 30)
        remoteUserIdField.frame = CGRect(x: 30, y: 200, width: fullWidth - 60, height: 30)
        textField.frame = CGRect(x: 30, y: 250, width: fullWidth - 60, height: 30)
        sendButton.frame = CGRect(x: 30, y: 300, width: 80, height: 30)
        logView.frame = CGRect(x: 30, y: 350, width: fullWidth - 60, height: self.view.frame.height - 350 - 50)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    // 输出运行日志。
    func printLog(_ log: Any...) {
        DispatchQueue.main.async {
            self.logView.text.append(
                DateFormatter.localizedString(from: Date.now, dateStyle: .none, timeStyle: .medium)
                + ":  " + String(reflecting: log) + "\r\n"
            )
            self.logView.scrollRangeToVisible(NSRange(location: self.logView.text.count, length: 1))
        }
    }
}
```


### 实现聊天逻辑

本节介绍如何初始化即时通讯 IM、创建用户、登录即时通讯 IM 以及发送和接收单聊文本消息。

#### 导入和初始化即时通讯 IM SDK

对 `ViewController.swift` 文件进行如下修改：

```swift
import UIKit
// 导入即时通讯 IM SDK。
import AgoraChat
class ViewController: UIViewController {
    ...
    func initChatSDK() {
        // 将 <#Agora App Key#> 替换为自己的 App Key。
        // 初始化即时通讯 IM SDK。
        let options = AgoraChatOptions(appkey: "<#Agora App Key#>")
        options.isAutoLogin = false // 关闭自动登录。
        options.enableConsoleLog = true
        AgoraChatClient.shared.initializeSDK(with: options)
        // 添加 chat 代理用于接收消息。
        AgoraChatClient.shared.chatManager?.add(self, delegateQueue: nil)
    }

    override func viewDidLoad() {
        ...
        // 调用 chat 初始化方法。
        initChatSDK()
    }
}
```

#### 利用 Token 登录

```swift
extension ViewController {

    // 利用 Token 登录即时通讯 IM。
    @objc func loginAction() {
        guard let userId = self.userIdField.text,
              let token = self.tokenField.text else {
            self.printLog("userId or token is empty")
            return;
        }
        let err = AgoraChatClient.shared.login(withUsername: userId, agoraToken: token)
        if err == nil {
            self.printLog("login success")
        } else {
            self.printLog("login failed:\(err?.errorDescription ?? "")")
        }
    }

    // 登出。
    @objc func logoutAction() {
        AgoraChatClient.shared.logout(false) { err in
            if err == nil {
                self.printLog("logout success")
            }
        }
    }
}
```

#### 发送和接收消息

```swift
extension ViewController: AgoraChatManagerDelegate  {
    // 发送文本消息
    @objc func sendAction() {
        guard let remoteUser = remoteUserIdField.text,
              let text = textField.text,
              let currentUserName = AgoraChatClient.shared.currentUsername else {
            self.printLog("Not login or remoteUser/text is empty")
            return
        }
        let msg = AgoraChatMessage(
            conversationId: remoteUser, from: currentUserName,
            to: remoteUser, body: .text(content: text), ext: nil
        )
        AgoraChatClient.shared.chatManager?.send(msg, progress: nil) { msg, err in
            if let err = err {
                self.printLog("send msg error.\(err.errorDescription)")
            } else {
                self.printLog("send msg success")
            }
        }
    }
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
        for msg in aMessages {
            switch msg.swiftBody {
            case let .text(content: content):
                self.printLog("receive text msg,content: \(content)")
            default:
                break
            }
        }
    }
}
```

<a name="test"></a>

## 运行并测试项目

使用 Xcode 在 iOS 真机或模拟机上编译和运行项目。你可以看到以下界面：

![](https://web-cdn.agora.io/docs-files/1670828886360)

![](./images/quickstart/ios_login.png)


<div class="alert note">你可以通过在以下界面中设置所需字段或修改 <a href="#sign-in"><code>ViewController.swift</code></a> 文件中的字段登录 app。</div>

参考以下步骤对你通过即时通讯 IM 在 app 中集成的单聊功能：

1. 登录即时通讯 IM。
在模拟器或物理设备上，在 **User Id** 和 **Token** 文本框中输入发送方的用户 ID（`lxm`）和 Agora Token，然后点击 **Login**。

2. 发送消息。
在 **Remote User Id** 文本框中输入接收方的用户 ID（`lxm2`），在 **Input text message** 框中输入消息内容（"Hello"），然后点击 **Send**。

![](https://web-cdn.agora.io/docs-files/1670828910536)

![](./images/quickstart/ios_send_msg.png)

3. 登出即时通讯 IM。
点击 **Logout** 登出即时通讯 IM。

4. 接收消息。
登出后，以接收方的用户 ID（`lxm2`）接收步骤 2 中发送的 "Hello" 消息。 

![](https://web-cdn.agora.io/docs-files/1670828927801)

![](./images/quickstart/ios_receive_msg.png)


## 后续步骤

出于演示目的，即时通讯 IM 提供一个 App Server，可使你利用本文中提供的 App Key 快速获得 token。在生产环境中，最好自行部署 token 服务器，使用自己的 [App Key](./enable_agora_chat) 生成 token，并在客户端获取 token 登录即时通讯 IM。要了解如何实现服务器按需生成和提供 token，请参阅[生成用户 Token](./generate_user_tokens)。


## 集成 SDK 的其他方式

### 方法 1：通过 CocoaPods

1. 安装 CocoaPods。详见 [CocoaPods 安装指南](https://guides.cocoapods.org/using/getting-started.html#getting-started)。

2. 在 Terminal 中进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

3. 打开 Podfile 文件，添加即时通讯 IM SDK。将 `Your project target` 替换为你的项目名称。

   ```
   platform :ios, '11.0'

   target 'Your project target' do
       pod 'Agora_Chat_iOS'
   end
   ```

4. 在项目根目录，运行以下命令集成即时通讯 IM SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `workspace` 文件。

   ```
   pod install
   ```

5. 在 Xcode 中打开 `xcworkspace` 文件。

#### 方法 2：手动导入即时通讯 IM SDK

1. 下载最新版的 [即时通讯 IM iOS SDK](./downloads?platform=iOS) 并解压。

2. 将 SDK 包内的 `AgoraChat.framework` 复制到项目文件夹中。`AgoraChat.framework` 包含 arm64、armv7 和 x86_64 指令集。

3. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**。

4. 点击  **+ > Add Other… > Add Files** 添加 `AgoraChat.framework` 并将 **Embed** 属性设置为 **Embed & Sign**。添加完成后，项目会自动链接所需系统库。


## 参考

有关如何快速开始使用即时通讯 IM，详见 [示例代码](https://github.com/AgoraIO/Agora-Chat-API-Examples/tree/main/Chat-iOS/ChatQuickStart)。
