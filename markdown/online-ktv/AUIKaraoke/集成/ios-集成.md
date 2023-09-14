本文介绍如何通过 [AUIKitKaraoke 组件](#link-to-description)快速搭建一个含 UI 界面的在线 K 歌房。

下图展示搭建 K 歌房间的完整流程：

<img src="/Users/admin/Library/Application Support/typora-user-images/image-20230830103826589.png" alt="image-20230830103826589" style="zoom:50%;" />

## 准备开发环境

//todo https://github.com/AgoraIO-Community/AUIKitKaraoke/blob/main/iOS/doc/KaraokeUIKit_zh.md input里面的前提条件是已经跑通demo

### 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 1.12.1 及以上

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 13.0 及以上

- iOS 设备，版本 13.0 及以上

  <Admonition type="info" title="信息">

  声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。

  </Admonition>

- 有效的苹果开发者账号

- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora Platform/sign_in_and_sign_up)和声网项目，请参考[开始使用声网平台](https://docs.agora.io/cn/Agora Platform/get_appid_token?platform=All Platforms)，从声网控制台获取以下信息：

  - App ID：声网随机生成的字符串，用于识别你的 app。
  - 临时 Token：你的 app 客户端加入频道时会使用 Token 对用户进行鉴权。临时 Token 的有效期为 24 小时。
  - rtm Token：

### 创建并配置项目 

按照下列步骤来创建并配置你的项目。

1. [创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

   如果你没有添加过开发团队信息，会看到 **Add account…** 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 **Next**，完成后即可选择你的 Apple 账户作为开发团队。

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 在 `KeyCenter.swift` 文件中添加你的业务服务器域名，你也可以直接使用声网测试域名来进行体验：https://service.agora.io/uikit-karaoke。//TODO 这里的测试域名跟demo里面的不一致，要确认下

   ```swift
   struct KeyCenter {
       static var HostUrl: String = "https://test-uikit-karaoke.bj2.agoralab.co"
   //    static var HostUrl: String = "https://service.agora.io/uikit-karaoke"  //该域名仅限体验使用，请勿用户正式商用环境
   }
   ```

5. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，配置麦克风和摄像头权限，如下图所示：

   ![image-20230911163222007](/Users/admin/Library/Application Support/typora-user-images/image-20230911163222007.png)

​       <Admonition type="info" title="信息">
       <ul><li><code>Value</code> 值填写使用麦克风或摄像头的目的即可。</li><li>如果你的项目中需要添加第三方插件或库（例如第三方摄像头），且该插件或库的签名与项目的签名不一致，你还需勾选 Hardened Runtime > Runtime Exceptions 中的 Disable Library Validation。</li><li>更多注意事项，可参考 <a href="https://developer.apple.com/documentation/xcode/preparing-your-app-for-distribution">Preparing Your App for Distribution</a>。</li></ul>
​       </Admonition>

### 集成组件

1. 将下列源码复制到你的项目中：

   - [AUIKit](https://github.com/AgoraIO-Community/AUIKit/tree/main/iOS)
   - [AScenesKit](https://github.com/AgoraIO-Community/AUIKitKaraoke/tree/main/iOS/AScenesKit)
   - [KeyCenter.swift](https://github.com/AgoraIO-Community/AUIKitKaraoke/blob/main/iOS/Example/AUIKitKaraoke/KeyCenter.swift)// TODO 为什么这个也要复制？

2. 在 Podfile 文件里添加依赖。

   ```ruby
   pod 'AScenesKit', :path => './AScenesKit'
   pod 'AUIKit', :path => './AUIKit'
   ```

## 实现在线 K 歌房

### 1. 初始化 KaraokeUiKit

创建 `AUiCommonConfig` 对象。//TODO 不用调setup吗❓

```swift
let commonConfig = AUICommonConfig()
commonConfig.host = KeyCenter.HostUrl
commonConfig.userId = userInfo.userId  
commonConfig.userName = userInfo.userName
commonConfig.userAvatar = userInfo.userAvatar
//rtmClient可空
let roomManager = AUIRoomManagerImpl(commonConfig: roomConfig, rtmClient: rtmClient)
```

### 2. 创建房间

调用 `createRoom` 创建房间。在创建房间之前，请确保你已经创建 `AUiCommonConfig` 对象。

```swift
let room = AUICreateRoomInfo()
// 房间名称
room.roomName = text
//
room.thumbnail = userInfo.userAvatar
room.seatCount = 8
roomManager.createRoom(room: roomInfo) { error, info in
}
```



