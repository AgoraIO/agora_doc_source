本文介绍如何集成语聊 UIKit 来实现房间的创建、用户进房、退房和销毁等功能。

## 示例项目

声网提供 [API-Examples-AUIKit/iOS/VoiceChatApp](https://github.com/AgoraIO-Community/API-Examples-AUIKit/tree/dev/ios/iOS/VoiceChatApp) 示例项目供你参考本文提到的集成步骤和代码逻辑。


## 准备开发环境

### 前提条件

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 14.0 及以上。
- iOS 设备，版本 13.0 及以上。
- 有效的苹果开发者账号。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 参考[开始使用声网平台](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)创建声网开发者账号和声网项目。//TODO

### 创建项目

本节介绍如何在 Xcode 创建项目：

1. [创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

    <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 <b>Next</b>，完成后即可选择你的 Apple 账户作为开发团队。</div>

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 设置 **Minimum Deployments** 为 iOS 13。

    ![](https://web-cdn.agora.io/docs-files/1697686309702)


5. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，编辑[属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)，添加以下属性：

    | key                                    | type   | value                                                        |
    | -------------------------------------- | ------ | ------------------------------------------------------------ |
    | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如 for a live interactive streaming |

### 集成依赖

本节介绍如何集成语聊项目所需的依赖库：

1. 开始前请确保你已安装 CocoaPods，如尚未安装 CocoaPods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 下载声网提供的 [AUIVoiceRoom/iOS/AScenesKit](https://github.com/AgoraIO-Community/AUIVoiceRoom/blob/main/iOS/AScenesKit) 文件夹，并将该文件夹复制到与你的 `*.xcodeproj` 文件所在的同一级目录下。

3. 在终端里进入 `*.xcodeproj` 文件的上一级目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

5. 打开 `Podfile` 文件，修改文件为如下内容。注意 target 和 path 的填写。

    ```shell
    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '13.0'

    # target 需改为你的项目中实际的 Target 名称
    target 'AUIKitDemo' do
      use_frameworks!

      # path 需为 AScenesKit 依赖库的实际路径
      pod 'AScenesKit', :path => './AScenesKit'
    end

    post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
    ```

6. 在终端里进入 `*.xcodeproj` 文件的上一级目录，运行如下命令安装 AUIKit 依赖：

    ```shell
    pod update --verbose
    ```
    ![](https://web-cdn.agora.io/docs-files/1697696810206)
    ![](https://web-cdn.agora.io/docs-files/1697696820778)
    ![](https://web-cdn.agora.io/docs-files/1697696829568)

    安装成功后，与 `*.xcodeproj` 文件所在的同一级目录下会出现一个 `*.xcworkspace` 文件。打开该文件即可体验安装了 AScenesKit 和 AUIKit 等依赖的项目。

    ![](https://web-cdn.agora.io/docs-files/1697696837811)


## 实现语聊房

`VoiceChatUIKit` 基于声网 RTC、RTM 引擎、AUIKit 等模块封装，帮助你轻松管理语聊房。

你可以使用 `VoiceChatUIKit` 类中的 API 实现语聊房间的创建、用户进房、退房和销毁等功能。

### 1. 初始化 VoiceChatUIKit

本节展示初始化 `VoiceChatUIKit` 的代码逻辑：

1. 在 `AppDelegate.swift` 文件里导入依赖库：

    ```swift
    import AUIKitCore
    import AScenesKit
    ```

2. 在 `AppDelegate` 类中调用 `VoiceChatUIKit` 类的 `setup` 方法并传入如下参数，初始化 `VoiceChatUIKit`：

    - `roomConfig`：通用配置，包含后端域名地址、用户 ID、用户名、用户头像。
    - `rtcEngine`：声网 RTC 引擎。
    - `rtcClient`：声网 RTM 引擎。

    ```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 生成一个随机的用户 ID
        let uid = Int(arc4random_uniform(99999999))

        // 创建一个 AUICommonConfig 实例
        let commonConfig = AUICommonConfig()

        // 设置 AUICommonConfig 的属性值
        commonConfig.host = "https://service.agora.io/uikit-voiceroom" // 设置主机地址
        commonConfig.userId = "\(uid)" // 设置用户 ID
        commonConfig.userName = "user_\(uid)" // 设置用户名
        commonConfig.userAvatar = "https://accktvpic.oss-cn-beijing.aliyuncs.com/pic/sample_avatar/sample_avatar_1.png" // 设置用户头像

        // 调用 VoiceChatUIKit 的 setup 方法进行初始化设置
        VoiceChatUIKit.shared.setup(roomConfig: commonConfig,
                                    rtcEngine: nil,   // 如果有外部初始化的 rtc engine，可以传入该实例
                                    rtmClient: nil)   // 如果有外部初始化的 rtm client，可以传入该实例

        // 在应用程序启动完成后的自定义逻辑（可根据需要进行覆盖）
        ...

        return true
    }
    ```

### 2. 房主创建房间

本节展示如何让房主创建语聊房。

#### 添加按钮：创建房间

在 `ViewController.swift` 文件里导入依赖库：

```swift
import AUIKitCore
import AScenesKit
```

在 `ViewController` 类中，通过 iOS 原生方法增加一个「创建房间」按钮，用于让房主点击创建。

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // 作为房主创建房间的按钮
    let createButton = UIButton(frame: CGRect(x: 10, y: 100, width: 100, height: 60))
    createButton.setTitle("创建房间", for: .normal)
    createButton.setTitleColor(.red, for: .normal)
    createButton.addTarget(self, action: #selector(onCreateAction), for: .touchUpInside)
    view.addSubview(createButton)
}
```

#### 创建语聊房

在 `ViewController` 类中，调用 `VoiceChatUIKit` 类的 `createRoom` 并传入 `roomInfo` 参数以创建语聊房。`roomInfo` 里需传入房间信息。

如果创建房间成功，那么执行 `enterRoom` 函数。


```swift
@objc func onCreateAction(_ button: UIButton) {
    // 生成一个随机的房间 ID
    let roomId = Int(arc4random_uniform(99999999))
    // 创建一个 AUICreateRoomInfo 实例
    let room = AUICreateRoomInfo()
    // 设置房间名为生成的随机房间 ID
    room.roomName = "\(roomId)"
    // 禁用按钮，防止重复点击
    button.isEnabled = false

    // 调用 VoiceChatUIKit 的 createRoom 方法创建房间
    VoiceChatUIKit.shared.createRoom(roomInfo: room) { roomInfo in
        // 成功创建房间后的回调
        self.enterRoom(roomInfo: roomInfo!) // 加入房间
        button.isEnabled = true // 恢复按钮可用状态
    } failure: { error in
        // 创建房间失败的回调
        print("on create room fail: \(error.localizedDescription)")
        button.isEnabled = true // 恢复按钮可用状态
    }
}
```

### 3. 加入房间

本节展示如何让房主加入语聊房。

#### 声明属性

在 `ViewController` 类中声明了一个可选属性，用于存储 `AUIVoiceChatRoomView` 实例以显示语聊房的详情界面。

```swift
class ViewController: UIViewController {
    var voiceChatView: AUIVoiceChatRoomView?
    ...
}
```

#### 创建房间详情页并启动房间

在 `ViewController` 中，创建一个 `AUIVoiceChatRoomView` 实例，并将它设置为 `voiceChatView` 属性，用于显示语聊房的详情界面。

调用 `VoiceChatUIKit` 类的 `launchRoom` 方法，并传入以下参数，以启动语聊房：

- `roomInfo`：房间信息。包含如下：
  - `roomId`：房间 ID。
  - `owner`：房主信息。
  - `memberCount`：房间内的人数。
  - `createTime`：房间创建的时间（毫秒）。
- `voiceChatView`：房间的 UI View。


```swift
func enterRoom(roomInfo: AUIRoomInfo) {
    // 创建一个 AUIVoiceChatRoomView 实例，并设置其 frame 为当前视图的边界
    voiceChatView = AUIVoiceChatRoomView(frame: self.view.bounds)

    if let roomView = self.voiceChatView {
        // 调用 VoiceChatUIKit 的 launchRoom 方法，启动房间
        VoiceChatUIKit.shared.launchRoom(roomInfo: roomInfo,
                                         roomView: roomView) { [weak self] error in
            guard let self = self else { return }
            // 如果出现错误，直接返回
            if let _ = error { return }

            // 将 roomView 添加到当前视图中
            self.view.addSubview(roomView)
        }
    }
}
```

### 4. （可选）听众加入房间

本节展示如何让听众加入已存在的房间。

#### 添加按钮：加入房间

在 `ViewController` 类中，通过 iOS 原生方法增加一个「加入房间」按钮，用于让听众点击加入。

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // 作为房主创建房间的按钮
    let createButton = UIButton(frame: CGRect(x: 10, y: 100, width: 100, height: 60))
    createButton.setTitle("创建房间", for: .normal)
    createButton.setTitleColor(.red, for: .normal)
    createButton.addTarget(self, action: #selector(onCreateAction), for: .touchUpInside)
    view.addSubview(createButton)

    // highlight-start
    // 作为听众加入房间的按钮
    let joinButton = UIButton(frame: CGRect(x: 10, y: 160, width: 100, height: 60))
    joinButton.setTitle("加入房间", for: .normal)
    joinButton.setTitleColor(.red, for: .normal)
    joinButton.addTarget(self, action: #selector(onJoinAction), for: .touchUpInside)
    view.addSubview(joinButton)
    // highlight-end
}
```


#### 获取房间列表

在 `ViewController` 类中，调用 `VoiceChatUIKit` 类的 `getRoomInfoList` 方法并传入如下参数，以获取语聊房间列表：

- `lastCreateTime`：房间列表的起始时间（毫秒）。例如，1681879844085。
- `pageSize`：每一页房间列表所展示的房间数量。

如果在房间列表中找到匹配的房间名，那么执行 `enterRoom` 函数。通过[此前步骤](//TODO)中已添加的 `enterRoom` 函数即可实现加入房间。

```swift
@objc func onJoinAction() {
    // 创建 UIAlertController 实例，用于显示弹出对话框
    let alertController = UIAlertController(title: "房间名", message: "", preferredStyle: .alert)
    alertController.addTextField { (textField) in
        textField.placeholder = "请输入"
    }
    // 创建一个「取消」按钮，并指定点击事件
    let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
    }
    // 创建一个「确认」按钮，并指定点击事件
    let saveAction = UIAlertAction(title: "确认", style: .default) { (_) in
        // 获取用户输入的文本内容
        if let inputText = alertController.textFields?.first?.text {
            // 处理用户输入的内容
            VoiceChatUIKit.shared.getRoomInfoList(lastCreateTime: nil, pageSize: 50) { error, roomList in
                // 检查是否有错误发生，并确保成功获取到了房间列表
                guard let roomList = roomList else {return}
                // 遍历房间列表
                for room in roomList {
                    // 比对房间名与用户输入的文本内容是否匹配
                    if room.roomName == inputText {
                        // 找到匹配的房间名，调用 enterRoom 方法加入房间
                        self.enterRoom(roomInfo: room)
                        // 结束循环
                        break
                    }
                }
            }
        }
    }

    // 将「取消」按钮添加到弹出对话框
    alertController.addAction(cancelAction)
    // 将「确认」按钮添加到弹出对话框
    alertController.addAction(saveAction)
    // 在当前视图上显示弹出对话框
    present(alertController, animated: true, completion: nil)
}
```

### 5. （可选）退出或销毁房间

本节展示如何退出并销毁房间。

在语聊房中，房主可以主动销毁房间，房间销毁时听众会被动退出房间。房间存在时，听众也可以主动退出房间。


#### 主动退出或销毁房间

在 `enterRoom` 函数中添加如下高亮的几行代码，即可实现通过点击按钮主动退出房间（听众）或销毁房间（房主）。

```swift
func enterRoom(roomInfo: AUIRoomInfo) {
    // 创建一个 AUIVoiceChatRoomView 实例，并设置其 frame 为当前视图的边界
    voiceChatView = AUIVoiceChatRoomView(frame: self.view.bounds)

    // highlight-start
    // 点击退出房间按钮
    voiceChatView?.onClickOffButton = { [weak self] in
            self?.destroyRoom(roomId: roomInfo.roomId)
        }
    // highlight-end

    if let roomView = self.voiceChatView {
        // 调用 VoiceChatUIKit 的 launchRoom 方法，启动房间
        VoiceChatUIKit.shared.launchRoom(roomInfo: roomInfo,
                                         roomView: roomView) { [weak self] error in
            guard let self = self else { return }
            // 如果出现错误，直接返回
            if let _ = error { return }

            // 将 roomView 添加到当前视图中
            self.view.addSubview(roomView)
        }
    }
}
```


#### 被动退出房间

听众被动退出房间的代码逻辑如下：

1. 在 `enterRoom` 函数中添加如下高亮的代码行。调用 `VoiceChatUIKit` 类的 `bindRespDelegate` 方法，订阅房间被销毁的回调。

    ```swift
    func enterRoom(roomInfo: AUIRoomInfo) {
        // 创建一个 AUIVoiceChatRoomView 实例，并设置其 frame 为当前视图的边界
        voiceChatView = AUIVoiceChatRoomView(frame: self.view.bounds)

        // highlight-start
        // 点击退出房间按钮
        voiceChatView?.onClickOffButton = { [weak self] in
                self?.destroyRoom(roomId: roomInfo.roomId)
            }
        // highlight-end

        if let roomView = self.voiceChatView {
            // 调用 VoiceChatUIKit 的 launchRoom 方法，启动房间
            VoiceChatUIKit.shared.launchRoom(roomInfo: roomInfo,
                                             roomView: roomView) { [weak self] error in
                guard let self = self else { return }
                // 如果出现错误，直接返回
                if let _ = error { return }
                // highlight-start
                VoiceChatUIKit.shared.bindRespDelegate(delegate: self)
                // highlight-end
                // 将 roomView 添加到当前视图中
                self.view.addSubview(roomView)
            }
        }
    }
    ```

2. 在 `ViewController` 文件中，通过 `AUIRoomManagerRespDelegate` 中的 `onRoomDestroy` 回调来监听房间销毁事件。当监听到房间被销毁时，执行 `destroyRoom` 函数。

    ```swift
    extension ViewController: AUIRoomManagerRespDelegate {
        // 房间销毁回调
        func onRoomDestroy(roomId: String) {
            self.destroyRoom()
        }
        // 房间信息更新回调
        func onRoomInfoChange(roomId: String, roomInfo: AUIKitCore.AUIRoomInfo) {
        }
         // 房间成员列表更新回调
        func onRoomAnnouncementChange(roomId: String, announcement: String) {
        }
        // 听众被房主踢出房间回调
        func onRoomUserBeKicked(roomId: String, userId: String) {
            self.destroyRoom()
        }
    }
    ```

3. 在 `ViewController` 类中，增加 `destroyRoom` 函数。在该函数中，调用 `VoiceChatUIKit` 类的 `unbindRespDelegate` 方法，取消订阅房间被销毁的回调。

    ```swift
    func destroyRoom(roomId: String) {
        // 在退出房间时取消订阅，调用 VoiceChatUIKit 的 unbindRespDelegate 方法
        VoiceChatUIKit.shared.unbindRespDelegate(delegate: self)
    }
    ```

#### 添加销毁逻辑

在 `destroyRoom` 函数中，添加如下高亮的几行代码。调用 `VoiceChatUIKit` 类的 `destoryRoom` 方法并传入房间 ID，以销毁房间。至此，`destroyRoom` 函数的代码补充完成。

```swift
func destroyRoom(roomId: String) {
    // highlight-start
    // 点击退出，调用 VoiceChatView 的 onBackAction 方法
    self.VoiceChatView?.onBackAction()

    // 将 VoiceChatView 从父视图中移除
    self.VoiceChatView?.removeFromSuperview()

    // 调用 VoiceChatUIKit 的 destoryRoom 方法销毁房间，传入房间 ID
    VoiceChatUIKit.shared.destoryRoom(roomId: roomId)
    // highlight-end

    // 在退出房间时取消订阅，调用 VoiceChatUIKit 的 unbindRespDelegate 方法
    VoiceChatUIKit.shared.unbindRespDelegate(delegate: self)
}
```

## 注意事项

### 问题排查

如果在 Xcode 15 编译项目时遇到 `Sandbox: rsync.samba(47334) deny(1) file-write-create...` 报错信息，你可以依次进行如下操作：

1. 在 Xcode 中选中 **PROJECT**，点击 **Build Settings**，在 Filter 搜索框中搜索 User Script Sandboxing，将该选项设为 **No**。
2. 选中 **TARGETS**，检查并确保 User Script Sandboxing 的设置为 **No**。

![](https://web-cdn.agora.io/docs-files/1697685882007)

### 后端部署

为方便你快速集成语聊房，声网已经帮你部署好后端，无需你进行操作。

声网在示例项目中提供的后端服务主机地址 `https://service.agora.io/uikit-voiceroom` 仅用于测试体验，请你不要商用。

如需将项目商用，请参考[配置示例项目](//TODO)部署后端并在项目中配置你的后端服务主机地址。

## 下一步

在创建、进入房间后，你可以参考如下业务流程图开发后续的麦位管理、聊天、礼物等功能。

![](https://web-cdn.agora.io/docs-files/1697095578162)