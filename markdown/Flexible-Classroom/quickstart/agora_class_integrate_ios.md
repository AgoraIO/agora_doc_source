本文详细介绍如何将灵动课堂集成到你自己的 iOS 项目中。

## 技术原理

灵动课堂包含以下库：

-   `AgoraClassroomSDK`: 胶水层，串联起 `AgoraEduContext`、`AgoraEduUI` 和 `AgoraEduCore`。`AgoraClassroomSDK` 在 GitHub 与 CocoaPods 上开源发布。
-   `AgoraEduUI`: 提供灵动课堂交互层的代码，并包含交互层所使用的文案信息和资源文件。`AgoraEduCore` 通过 `AgoraEduContext` 为该层提供灵动课堂中的能力与数据。`AgoraEduUI` 在 GitHub 与 CocoaPods 上开源发布。
-   `AgoraEduContext`: 定义了 Context Protocol 和数据结构。`AgoraEduContext` 在 GitHub 与 CocoaPods 上开源发布。
-   `AgoraEduCore`: 提供灵动课堂中的能力与数据，遵守 `AgoraEduContext` 中定义的协议。`AgoraEduCore` 闭源，以二进制包在 CocoaPods 上发布。
-   `Widget`: 包含界面与功能的独立插件，由 `AgoraClassroomSDK` 注入灵动课堂内。`Widget` 与 `Widget` 之间，以及与 UI 层中的其他组件都能进行通讯。

下图展示了灵动课堂的架构。

![](https://web-cdn.agora.io/docs-files/1650596184055)

## 通过 CocoaPods 集成灵动课堂

如果你使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可参考以下步骤通过 CocoaPods 添加远程依赖集成完整的灵动课堂：

1. 用 Xcode 打开你的项目，在项目的 `Podfile` 文件中添加以下引用：

   ```swift
   pod 'OpenSSL-Universal', '1.0.2.17'
   pod 'Protobuf', '3.17.0'
   pod 'CocoaLumberjack', '3.6.1'
   pod 'AliyunOSSiOS', '2.10.8'
   pod 'Armin', '1.1.0'
   pod 'SSZipArchive', '2.4.2'
   pod 'SwifterSwift', '5.2.0'
   pod 'Masonry', '1.1.0'
   pod 'SDWebImage', '5.12.0'
   pod 'WHToast', '0.0.7'
   pod 'FLAnimatedImage', '3.8.6'

   # Agora libs
   pod 'AgoraRtm_iOS', '1.4.8'
   pod 'Whiteboard', '2.16.17'
   pod 'AgoraRtcEngine_iOS', '3.4.6'
   pod 'HyphenateChat', '3.8.6'

   # Open-source libs
   pod 'AgoraClassroomSDK_iOS', '2.5.0'
   ```

   下图仅为示例：

   <img src="https://web-cdn.agora.io/docs-files/1650596371481" style="zoom:50%;" />

2. 在终端中进入到工程目录，执行 `pod install` 命令安装依赖包。安装过程如下图所示：

   <img src="https://web-cdn.agora.io/docs-files/1650596467294" style="zoom: 50%;" />

3. 通过以下代码导入头文件：

   ```swift
   /* Swift */
   import AgoraClassroomSDK_iOS
   ```

   ```objc
   /* Objective-C */
   import <AgoraClassroomSDK_iOS/AgoraClassroomSDK.h>
   ```

4. 调用 [AgoraClassroomSDK.launch](/cn/agora-class/agora_class_api_ref_ios?platform=iOS#launch) 方法启动课堂。示例代码如下：

   ```swift
   /* Swift */
   let appId = Your AppId /* 填入你的 App ID。*/
   let rtmToken = Your rtmToken /* 填入你的 RTM Token。*/
   let userUuid = Your userId

   let launchConfig = AgoraEduLaunchConfig(userName: user /* 用户名。 */,
                                         userUuid: userUuid /* 用户 ID。*/,
                                         userRole: .student /* 用户角色：1 为老师，2 为学生。*/,
                                         roomName: room /* 房间名。*/,
                                         roomUuid: roomUuid /* 房间 ID。*/,
                                         roomType: roomStyle /* 房间类型：0 为 一对一，2 为大班课，4 为小班课。*/,
                                         appId: appId,
                                         token: rtmToken /* 测试环境下，你可以使用临时 RTM Token；生产或安全环境下，强烈建议你使用服务器生成的 RTM Token。*/,
                                         startTime: nil /* 课堂开始时间。*/,
                                         duration: NSNumber(value: duration) /* 课堂持续时长。*/,
                                         region: region.eduType /* 区域。*/,
                                         mediaOptions: nil /* 媒体相关配置。 */,
                                         userProperties: nil)

   AgoraClassroomSDK.setDelegate(self)
   AgoraClassroomSDK.launch(launchConfig,
                          success: launchSuccessBlock,
                          failure: failureBlock)
   ```

   ```objc
	/* Objective-C */
   AgoraEduMediaEncryptionConfig *config = [[AgoraEduMediaEncryptionConfig alloc] initWithMode:0 key:nil];

   AgoraEduMediaOptions *media = [[AgoraEduMediaOptions alloc] initWithEncryptionConfig:config videoEncoderConfig:nil latencyLevel:2 videoState:1 audioState:1];

   AgoraEduLaunchConfig *launchConfig =
   [[AgoraEduLaunchConfig alloc] initWithUserName: userName /* 用户名。 */
                                         userUuid: userUuid /* 用户 ID。*/
                                         userRole: /* 用户角色：1 为老师，2 为学生。*/
                                         roomName:@"房间名"
                                         roomUuid:@"房间UUID"
                                         roomType:4 /* 房间类型：0 为 一对一，2 为大班课，4 为小班课。*/
                                            appId:@"AppId"
                                            token:@"Your RTMToken" /* 测试环境下，你可以使用临时 RTM Token；生产或安全环境下，强烈建议你使用服务器生成的 RTM Token。*/
                                        startTime:nil /* 课堂开始时间。*/
                                         duration:[NSNumber numberWithInt:7200] /* 课堂持续时长。*/
                                           region:0 /* 区域。*/
                                     mediaOptions:media /* 媒体相关配置。 */
                                   userProperties:nil];

   [AgoraClassroomSDK launch:launchConfig success:^{
       NSLog(@"success");
   } failure:^(NSError * _Nonnull err) {
       NSLog(@"failure");
   }];
   ```

   示例代码中需要传入 `rtmToken`。你可以参考[获取 RTM Token](/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-rtm-token) 了解什么是 RTM Token，如何获取测试用途的临时 RTM Token，如何从服务器生成 RTM Token。

5. （可选）自定义课堂界面的显示模式（明亮/暗黑）和语言（中文/英文）。

    ```swift
    /* Swift */
    import AgoraUIBaseViews         /* 导入 AgoraUIBaseViews 库。该库提供自定义显示模式和语言的两个变量：agora_ui_mode 和 agora_ui_language。*/
    agora_ui_mode = .agoraLight     /* 设置界面显示模式，可设为 agoraLight 或 agoraDark，默认为 agoraLight。 */
    agora_ui_language = "zh-Hans"   /* 设置界面语言，可设为 "zh-Hans" 或 "en"。如果不设置，界面语言跟随系统语言。 */
    ```

    ```objc
    /* Objective-C */
    /* 导入 AgoraUIBaseViews 库。该库提供自定义显示模式和语言的两个变量：agora_ui_mode 和 agora_ui_language。*/
    #import <AgoraUIBaseViews/AgoraUIBaseView-Swift.h> 
    agora_ui_mode = AgoraUIModeAgoraLight              /* 设置界面显示模式，可设为 AgoraUIModeAgoraLight 或 AgoraUIModeAgoraDark，默认为 AgoraUIModeAgoraLight。*/
    agora_ui_language = @"zh-Hans"                     /* 设置界面语言，可设为 "zh-Hans" 或 "en"。如果不设置，界面语言跟随系统语言。*/
    ```

## 集成注意事项

- `AgoraEduCore` 是一个二进制 Swift 框架。由于苹果对二进制 Swift 框架兼容性不好，Agora 套用一层 OC 来避免兼容性问题。所以，你直接通过 `import AgoraEduCore` 引入 `AgoraEduCore` 可能会出现 Swift 版本不兼容的报错。你可通过以下方式解决该报错：

  -   OC: 使用 `#import <AgoraEduCorePuppet/AgoraEduCoreWrapper.h>` 引入 `AgoraEduCore`，并以 `AgoraEduCorePuppet` 类代替 `AgoraEduCore` 类。

  -   Swift: 使用 `import AgoraEduCorePuppet` 引入 `AgoraEduCore`，并以 `AgoraEduCorePuppet` 类代替 `AgoraEduCore` 类。

- 如果你的工程为 OC 工程，需要在 Build Settings 中 Add User-Defined Setting：
  - Key 设为 SWIFT_VERSION。
  - Value 设为你指定的 Swift 版本。

