This page shows how to add one-to-one messaging into your app by using the Agora Chat SDK for iOS.


## Understand the tech

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~


## Prerequisites

In order to follow the procedure in this page, you must have the following:

- A valid Agora [account](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-account)
- An Agora [project](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-project) with an [App Key](https://docs.agora.io/en/agora-chat/get-started/enable#get-the-information-of-the-chat-project) that has [enabled the Chat service](https://docs.agora.io/en/agora-chat/get-started/enable) 
- Xcode. This page uses Xcode 13.0 as an example.
- A device running iOS 10 or later.


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

In this section, we prepare the development environment necessary to integrate Agora Chat into your app.

### 1. Create an iOS project

In Xcode, follow the steps to create an iOS app project.

1. Open Xcode and click **Create a new Xcode project**.

2. Select **iOS** for the platform type and **App** for the project type and click **Next**.

3. Choose **Storyboard** and **Swift** for this example, and create the project.

### 2. Integrate the Agora Chat SDK

1. Go to **File > Swift Packages > Add Package Dependencies...**, and paste the following URL:

```text
https://github.com/AgoraIO/AgoraChat_iOS.git
```

2. In **Choose Package Options**, specify the Chat SDK version you want to use.


## Implement a one-to-one chat client

### Create the UI

You need a ViewController to create the UI controls you need.
In `ViewController.swift`, replace the code with the following:

<a name="sign-in"></a>

```swift
class ViewController: UIViewController {
    // Defines UI views.
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
        // Creates UI controls.
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
        // Replaces <#Input Your UserId#> and <#Input Your Token#> with your own user ID and token generated in Agora Console.
        self.userIdField.text = <#Input Your UserId#>
        self.tokenField.text = <#Input Your Token#>
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Defines layout UI controls.
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

    // Outputs running logs.
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


### Implement the chat logic

This section shows the logic of initializing the chat SDK, creating a user, logging in to Agora Chat, and sending and receiving a one-to-one text message.

#### Import and initialize the Chat SDK

Modify the `ViewController.swift` file as follows:

```swift
import UIKit
// Imports the Agora Chat SDK.
import AgoraChat
class ViewController: UIViewController {
    ...
    func initChatSDK() {
        // Replaces <#Agora App Key#> with your own App Key.
        // Initializes the Agora Chat SDK.
        let options = AgoraChatOptions(appkey: "<#Agora App Key#>")
        options.isAutoLogin = false // Disables auto login.
        options.enableConsoleLog = true
        AgoraChatClient.shared.initializeSDK(with: options)
        // Adds the chat delegate to receive messages.
        AgoraChatClient.shared.chatManager?.add(self, delegateQueue: nil)
    }

    override func viewDidLoad() {
        ...
        // Calls the initialization function.
        initChatSDK()
    }
}
```


#### Log in with tokens

```swift
extension ViewController {

    // Logs in with the token.
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

    // Logs out.
    @objc func logoutAction() {
        AgoraChatClient.shared.logout(false) { err in
            if err == nil {
                self.printLog("logout success")
            }
        }
    }
}
```

#### Send and receive messages

```swift
extension ViewController: AgoraChatManagerDelegate  {
    // Sends a text message.
    @objc func sendAction() {
        guard let remoteUser = remoteUserIdField.text,
              let text = textField.text,
              let currentUserName = AgoraChatClient.shared.currentUsername else {
            self.printLog("Not login or remoteUser/text is empty")
            return
        }
        let msg = AgoraChatMessage(
            conversationId: remoteUser, from: currentUserName,
            to: remoteUser, body: .text(text), ext: nil
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
            case let .text(content):
                self.printLog("receive text msg,content: \(content)")
            default:
                break
            }
        }
    }
}
```


<a name="test"></a>

## Run and test the project

Use Xcode to compile and run the project on an iOS device or an simulator. If the project runs properly, the following user interface appears:

![](https://web-cdn.agora.io/docs-files/1665309003658)

<div class="alert note">You can log in to the app by either entering the required fields in the user interface as stated below, or modifying the fields in the <a href="#sign-in"><code>ViewController.swift</code></a> file.</div>

To validate the peer-to-peer messaging you have just integrated into your app using Agora Chat, perform the following operations:

1. Log in  
On your simulator or physical device, enter the user ID (`lxm`) and Agora token of the sender in the **User Id** and **Token** box respectively, and click **Login**.

2. Send a message  
Fill in the user ID of the receiver (`lxm2`) in the **Remote User Id** box, type in the message ("Hello") to send in the **Input text message** box, and click **Send**.  
![](https://web-cdn.agora.io/docs-files/1665309009543)

3. Log out  
Click **Logout** to log out of the sender account.

4. Receive the message  
After signing out, log in with the user ID and Agora token of the receiver (`lxm2`) and receive the message "Hello" sent in step 2.  
![](https://web-cdn.agora.io/docs-files/1665309015042)


## Next steps

For demonstration purposes, Agora Chat uses temporary tokens generated from Agora Console for authentication in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=Android#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. To see how to implement a server that generates and serves tokens on request, see [Generate a User Token](../Develop/Authentication).


## Other approaches to integrate the SDK

#### Method 1: Through CocoaPods

1. Install CocoaPods if you have not. For details, see [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. In the Terminal, navigate to the project root directory and run the `pod init` command to create a text file `Podfile` in the project folder.

3. Open the `Podfile` file and add the Agora Chat SDK. Remember to replace `Your project target` with the target name of your project.

   ```
   platform :ios, '11.0'

   target 'Your project target' do
       pod 'Agora_Chat_iOS'
   end
   ```

4. In the project root directory, run the following command to integrate the SDK. When the SDK is installed successfully, you can see `Pod installation complete!` in the Terminal and an `xcworkspace` file in the project folder.

   ```
   pod install
   ```

5. Open the `xcworkspace` file in Xcode.

#### Method 2: Through your local storage

1. Download the latest Agora Chat SDK and decompress it.

2. Copy `AgoraChat.framework` in the SDK package to the project folder. `AgoraChat.framework` contains arm64, armv7, and x86_64 instruction sets.

3. Open Xcode and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.

4. Click **+ > Add Other… > Add Files** to add `AgoraChat.framework` and set the **Embed** property to **Embed & Sign**. Then the project automatically links to the required system library.


## Reference

For details, see the [sample code](https://github.com/AgoraIO/Agora-Chat-API-Examples/tree/main/Chat-iOS/ChatQuickStart) for getting started with Agora Chat.