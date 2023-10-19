

### 1. 初始化VoiceChatUIKit

#### 设置依赖库

在AppDelegate.swift里设置依赖库
```swift
import AUIKitCore
import AScenesKit
```
#### 初始化

在AppDelegate.swift里初始化VoiceChatUIKit
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let uid = Int(arc4random_uniform(99999999))
    let commonConfig = AUICommonConfig()
    commonConfig.host = "https://service.agora.io/uikit-VoiceChat"
    commonConfig.userId = "\(uid)"
    commonConfig.userName = "user_\(uid)"
    commonConfig.userAvatar = "https://accktvpic.oss-cn-beijing.aliyuncs.com/pic/sample_avatar/sample_avatar_1.png"
    VoiceChatUIKit.shared.setup(roomConfig: commonConfig,
                              rtcEngine: nil,   //如果有外部初始化的rtc engine
                              rtmClient: nil)   //如果有外部初始化的rtm client
    // Override point for customization after application launch.
    return true
}
```

### 2. 房主创建房间

#### 添加“创建房间”按钮

1. 在ViewController.swift里设置依赖
    ```swift
    import AUIKitCore
    import AScenesKit
    ```

2. 添加“创建房间”按钮

    ```swift
    override func viewDidLoad() {
        super.viewDidLoad()

        //作为房主创建房间的按钮
        let createButton = UIButton(frame: CGRect(x: 10, y: 100, width: 100, height: 60))
        createButton.setTitle("创建房间", for: .normal)
        createButton.setTitleColor(.red, for: .normal)
        createButton.addTarget(self, action: #selector(onCreateAction), for: .touchUpInside)
        view.addSubview(createButton)
    }
    ```
#### 创建VoiceChat房间

```swift
@objc func onCreateAction(_ button: UIButton) {
    let roomId = Int(arc4random_uniform(99999999))
    let room = AUICreateRoomInfo()
    room.roomName = "\(roomId)"
    button.isEnabled = false
    VoiceChatUIKit.shared.createRoom(roomInfo: room) { roomInfo in
        self.enterRoom(roomInfo: roomInfo!)
        button.isEnabled = true
    } failure: { error in
        print("on create room fail: \(error.localizedDescription)")
        button.isEnabled = true
    }
}
```

### 3.进入房间

#### 声明属性

ViewController里声明一个VoiceChat房间容器的属性

```swift
class ViewController: UIViewController {
    var VoiceChatView: AUIVoiceChatRoomView?

    ....
}
```

#### 创建并启动

创建房间详情页并启动VoiceChat房间

```swift
func enterRoom(roomInfo: AUIRoomInfo) {
    VoiceChatView = AUIVoiceChatRoomView(frame: self.view.bounds)
    VoiceChatView!.onClickOffButton = { [weak self] in
        //房间内点击退出
        self?.destroyRoom()
    }
            if let roomView = self.VoiceChatView {
            VoiceChatUIKit.shared.launchRoom(roomInfo: roomInfo,
                                             roomView: roomView) {[weak self] error in
                guard let self = self else {return}
                if let _ = error { return }
                //订阅房间被销毁回调
                VoiceChatUIKit.shared.bindRespDelegate(delegate: self)
                self.view.addSubview(roomView)
            }
        }
}
```

### 4. 观众进入房间准备（可选）

#### 添加“加入房间”按钮

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    //作为观众加入房间的按钮
    let joinButton = UIButton(frame: CGRect(x: 10, y: 160, width: 100, height: 60))
    joinButton.setTitle("加入房间", for: .normal)
    joinButton.setTitleColor(.red, for: .normal)
    joinButton.addTarget(self, action: #selector(onJoinAction), for: .touchUpInside)
    view.addSubview(joinButton)
}
```

#### 获取VoiceChat房间信息

```swift
@objc func onJoinAction() {
    let alertController = UIAlertController(title: "房间名", message: "", preferredStyle: .alert)
    alertController.addTextField { (textField) in
        textField.placeholder = "请输入"
    }
    let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
    }
    let saveAction = UIAlertAction(title: "确认", style: .default) { (_) in
        if let inputText = alertController.textFields?.first?.text {
            // 处理用户输入的内容
            VoiceChatUIKit.shared.getRoomInfoList(lastCreateTime: nil, pageSize: 50) { error, roomList in
                guard let roomList = roomList else {return}
                for room in roomList {
                    if room.roomName == inputText {
                        self.enterRoom(roomInfo: room)
                        break
                    }
                }
            }
        }
    }
    alertController.addAction(cancelAction)
    alertController.addAction(saveAction)

    present(alertController, animated: true, completion: nil)
}
```



### 5. 退出/销毁房间

#### 设置退出方法

1. 设置退出方法

    ```swift
    func destroyRoom(roomId: String) {
        //点击退出
        self.VoiceChatView?.onBackAction()
        self.VoiceChatView?.removeFromSuperview()

        VoiceChatUIKit.shared.destoryRoom(roomId: roomId)
        //在退出房间时取消订阅
        VoiceChatUIKit.shared.unbindRespDelegate(delegate: self)
    }
    ```

#### 主动退出

在上一步创建VoiceChatView时设置回调，即可主动退出房间

```swift
//AUIVoiceChatRoomView提供了onClickOffButton点击返回的clousure
VoiceChatView.onClickOffButton = { [weak self] in
    //点击退出
    self?.destroyRoom()
}
```

#### 被动退出

1. 在加入房间之后订阅AUIRoomManagerRespDelegate的回调

    ```swift
    VoiceChatUIKit.shared.bindRespDelegate(delegate: self)
    ```

2. 在退出房间时取消订阅

    ```swift
    VoiceChatUIKit.shared.unbindRespDelegate(delegate: self)
    ```

3. 然后通过AUIRoomManagerRespDelegate回调方法中的onRoomDestroy来处理房间销毁

    ```swift
    extension ViewController: AUIRoomManagerRespDelegate {
        //房间销毁
        func onRoomDestroy(roomId: String) {
            self.destroyRoom()
        }

        func onRoomInfoChange(roomId: String, roomInfo: AUIKitCore.AUIRoomInfo) {
        }

        func onRoomAnnouncementChange(roomId: String, announcement: String) {
        }

        //被房主踢出
        func onRoomUserBeKicked(roomId: String, userId: String) {
            self.destroyRoom()
        }
    }
    ```
