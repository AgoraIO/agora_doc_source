本文详细介绍如何将灵动课堂集成到你自己的 iOS 项目中。

## 技术原理

灵动课堂包含以下库：

-   `AgoraClassroomSDK`: 灵动课堂教育场景的胶水层，串联起 `AgoraEduUI` 和 `AgoraEduCore`。`AgoraClassroomSDK` 在 GitHub 与 CocoaPods 上开源发布。
-   `AgoraEduUI`: 提供灵动课堂教育场景的交互层代码，并包含交互层所使用的文案信息和资源文件。`AgoraEduCore` 为该层提供灵动课堂中的能力与数据。`AgoraEduUI` 在 GitHub 与 CocoaPods 上开源发布。
-   `AgoraProctorSDK`: 灵动课堂监考场景的胶水层，串联起 `AgoraProctorUI ` 和 `AgoraEduCore`。`AgoraProctorSDK ` 在 GitHub 与 CocoaPods 上开源发布。
-   `AgoraProctorUI`: 提供灵动课堂监考场景的交互层代码，并包含交互层所使用的文案信息和资源文件。`AgoraEduCore` 为该层提供灵动课堂中的能力与数据。`AgoraProctorUI ` 在 GitHub 与 CocoaPods 上开源发布。
-   `AgoraEduCore`: 提供灵动课堂中的能力与数据。`AgoraEduCore` 闭源，以二进制包在 CocoaPods 上发布。
-   `Widget`: 包含界面与功能的独立插件，由 `AgoraClassroomSDK` 或 `AgoraEduCore` 注入灵动课堂内。`Widget` 与 `Widget` 之间，以及与 UI 层中的其他组件都能进行通讯。

下图展示了灵动课堂的架构。

![](https://web-cdn.agora.io/docs-files/1681291532244)


## 前提条件

下列所介绍的集成方式均需要通过 [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 进行集成，版本需要为 1.10 或更高版本。

安装后，可以在终端输入以下命令，如果终端能正常打印出版本信息，则表示安装成功：


```
pod --version
```

例如，你安装了 1.11.3 版本，则终端会打印如下信息：

```
1.11.3
```

## 集成教育场景下灵动课堂（默认）

如果你使用教育场景下灵动课堂，没有修改代码的需求，可参考以下步骤通过 CocoaPods 添加远程依赖，进行集成：

1. 用 Xcode 打开你的项目，在项目的 `Podfile` 文件中添加以下引用：

   ```
   # third-party libs
   pod 'CocoaLumberjack',   '3.6.1'
   pod 'AliyunOSSiOS',      '2.10.8'
   pod 'SSZipArchive',      '2.4.2'
   pod 'SwifterSwift',      '5.2.0'
   pod 'SDWebImage',        '5.12.0'
   pod 'Protobuf',          '3.17.0'
   pod 'Masonry',           '1.1.0'
   pod 'Armin',             '1.1.0'
   
   # agora libs
   pod 'AgoraRtcEngine_iOS/RtcBasic', '3.7.2'
   pod 'AgoraMediaPlayer_iOS',        '1.3.0'
   pod 'Agora_Chat_iOS',              '1.0.6'
   pod 'AgoraRtm_iOS',                '1.4.8'
   pod 'Whiteboard',                  '2.16.51'
   
   # open-source libs
   pod 'AgoraClassroomSDK_iOS', '2.8.20'
   pod 'AgoraEduUI',            '2.8.20'
      
   pod 'AgoraWidgets',          '2.8.20'
   
   # close-source libs
   pod 'AgoraUIBaseViews',      '2.8.0'
   pod 'AgoraEduCore', 	       '2.8.20'
   pod 'AgoraWidget',           '2.8.0'
   ```

2. 在终端中进入到工程目录，执行 `pod install` 命令安装依赖包。以 2.8.20 为例，安装过程中会打印如下信息：

   ```
   Analyzing dependencies
   Downloading dependencies
   Installing AgoraClassroomSDK_iOS (2.8.20)
   Installing AgoraEduCore (2.8.20)
   Installing AgoraEduUI (2.8.20)
   Installing AgoraLog (1.0.2)
   Installing AgoraMediaPlayer_iOS (1.3.0)
   Installing AgoraRtcEngine_iOS (3.7.2)
   Installing AgoraRtm_iOS (1.4.8)
   Installing AgoraUIBaseViews (2.8.0)
   Installing AgoraWidget (2.8.0)
   Installing AgoraWidgets (2.8.20)
   Installing Agora_Chat_iOS (1.0.6)
   Installing AliyunOSSiOS (2.10.8)
   Installing Armin (1.1.0)
   Installing CocoaLumberjack (3.6.1)
   Installing Masonry (1.1.0)
   Installing NTLBridge (3.1.5)
   Installing Protobuf (3.17.0)
   Installing SDWebImage (5.12.0)
   Installing SSZipArchive (2.4.2)
   Installing SwifterSwift (5.2.0)
   Installing Whiteboard (2.16.51)
   Installing YYModel (1.0.4)
   Generating Pods project
   Integrating client project
   ```

3. 通过以下代码导入头文件：

   ```swift
   /* Swift */
   import AgoraClassroomSDK_iOS
   ```

   ```objc
   /* Objective-C */
   import <AgoraClassroomSDK_iOS/AgoraClassroomSDK.h>
   ```

4. 调用 [AgoraClassroomSDK.launch](/cn/agora-class/agora_class_api_ref_ios?platform=iOS#launch) 方法启动教育场景的灵动课堂。示例代码如下：

   ```swift
   /* Swift */

   let launchConfig = AgoraEduLaunchConfig(userName: userName,          // 用户名
                                           userUuid: userUuid,          // 用户 ID
                                           userRole: userRole,          // 用户角色: 1 为老师，2 为学生
                                           roomName: roomName,          // 房间名
                                           roomUuid: roomUuid,          // 房间 ID
                                           roomType: roomType,          // 房间类型: 0 为 一对一，2 为大班课，4 为小班课
                                           appId: appId,                //声网 App ID
                                           token: token,                // 测试环境下，你可以使用临时 Token；生产或安全环境下，强烈建议你使用服务器生成的 Token
                                           startTime: nil,              // 课堂开始时间
                                           duration: nil,               // 课堂持续时长
                                           region: region,              // 区域
                                           mediaOptions: mediaOptions,  // 媒体相关配置
                                           userProperties: nil)         // 用户自定义属性

   AgoraClassroomSDK.setDelegate(self)

   AgoraClassroomSDK.launch(launchConfig,
                            success: successBlock,
                            failure: failureBlock)
   ```

   ```objc
	/* Objective-C */
   AgoraEduLaunchConfig *launchConfig = [[AgoraEduLaunchConfig alloc] initWithUserName:userName            // 用户名
                                                                              userUuid:userUuid            // 用户 ID
                                                                              userRole:userRole            // 用户角色: 1 为老师，2 为学生
                                                                              roomName:roomName            // 房间名
                                                                              roomUuid:roomUuid            // 房间 ID
                                                                              roomType:roomType            // 房间类型: 0 为 一对一，2 为大班课，4 为小班课
                                                                              appId:appId                  //声网 App ID
                                                                              token:token                  // 测试环境下，你可以使用临时 Token；生产或安全环境下，强烈建议你使用服务器生成的 Token
                                                                              startTime:nil                // 课堂开始时间
                                                                              duration:nil                 // 课堂持续时长
                                                                              region:region                // 区域
                                                                              mediaOptions:mediaOptions    // 媒体相关配置
                                                                              userProperties:nil];         // 用户自定义属性

   [AgoraClassroomSDK setDelegate:self];

   [AgoraClassroomSDK launch:launchConfig
                     success:successBlock
                     failure:failureBlock];
   ```

   示例代码中需要传入 `token`。你可以参考[获取 RTM Token](/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-rtm-token) 了解什么是 Token，如何获取测试用途的临时 Token，如何从服务器生成 Token。
   <div class="alert note">声网提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。在正式环境中，为确保安全，你必须参考<a href="/cn/Real-time-Messaging/token_upgrade_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。生成的 token 传入的 <code>userId</code> 需要和 <code>launch</code> 方法中传入的参数 <code>userUuid</code> 保持一致，否则生成的 token 无效。</div>

5. （可选）自定义教育场景的灵动课堂界面的显示模式（明亮/暗黑）和语言（中文/英文）。

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

## 集成监考场景下灵动课堂

如果你使用监考场景下灵动课堂，没有修改代码的需求，可参考以下步骤通过 CocoaPods 添加远程依赖，进行集成：

1. 用 Xcode 打开你的项目，在项目的 `Podfile` 文件中添加以下引用：

   ```
   # third-party libs
   pod 'CocoaLumberjack',   '3.6.1'
   pod 'AliyunOSSiOS',      '2.10.8'
   pod 'SSZipArchive',      '2.4.2'
   pod 'SwifterSwift',      '5.2.0'
   pod 'SDWebImage',        '5.12.0'
   pod 'Protobuf',          '3.17.0'
   pod 'Masonry',           '1.1.0'
   pod 'Armin',             '1.1.0'
   
   # agora libs
   pod 'AgoraRtcEngine_iOS/RtcBasic', '3.7.2'
   pod 'AgoraMediaPlayer_iOS',        '1.3.0'
   pod 'AgoraRtm_iOS',                '1.4.8'
      
   # open-source libs
   pod 'AgoraProctorSDK',       '1.0.0'
   pod 'AgoraProctorUI',        '1.0.0'
   
   # close-source libs
   pod 'AgoraUIBaseViews',      '2.8.0'
   pod 'AgoraEduCore', 	       '2.8.20'
   pod 'AgoraWidget',           '2.8.0'
   ```
   
2. 在终端中进入到工程目录，执行 `pod install` 命令安装依赖包。以 2.8.20 为例，安装过程中会打印如下信息：

  ```
   Analyzing dependencies
   Downloading dependencies
   Installing AgoraProctorSDK (1.0.0)
   Installing AgoraProctorUI (1.0.0)
   Installing AgoraEduCore (2.8.20)
   Installing AgoraLog (1.0.2)
   Installing AgoraMediaPlayer_iOS (1.3.0)
   Installing AgoraRtcEngine_iOS (3.7.2)
   Installing AgoraRtm_iOS (1.4.8)
   Installing AgoraUIBaseViews (2.8.0)
   Installing AgoraWidget (2.8.0)
   Installing AliyunOSSiOS (2.10.8)
   Installing Armin (1.1.0)
   Installing CocoaLumberjack (3.6.1)
   Installing Masonry (1.1.0)
   Installing Protobuf (3.17.0)
   Installing SDWebImage (5.12.0)
   Installing SSZipArchive (2.4.2)
   Installing SwifterSwift (5.2.0)
   Installing YYModel (1.0.4)
   Generating Pods project
   Integrating client project
  ```
  
3. 通过以下代码导入头文件：

   ```swift
   /* Swift */
   import AgoraProctorSDK
   ```

   ```objc
   /* Objective-C */
   import <AgoraProctorSDK/AgoraProctorSDK.h>
   ```

4. 调用 [AgoraProctorSDK.launch](agora_class_proctor_api_ios#launch) 方法启动监考场景的灵动课堂。示例代码如下：

   ```swift
   /* Swift */

   let launchConfig = AgoraProctorLaunchConfig(userName: userName,           // 用户名
                                               userUuid: userUuid,           // 用户 ID
                                               userRole: userRole,           // 用户角色
                                               roomName: roomName,           // 房间名
                                               roomUuid: roomUuid,           // 房间 ID
                                               appId: appId,                 //声网 App ID
                                               token: token,                 // 测试环境下，你可以使用临时 Token；生产或安全环境下，强烈建议你使用服务器生成的 Token
                                               region: region,               // 区域
                                               mediaOptions: mediaOptions,   // 媒体相关配置
                                               userProperties: nil)          // 用户自定义属性

	let proctor = AgoraProctorSDK(launchConfig,
						              delegate: self)

   proctor.launch(success: successBlock,
                   failure: failureBlock)
   ```

   ```objc
	/* Objective-C */
   AgoraProctorLaunchConfig *launchConfig = [[AgoraProctorLaunchConfig alloc] initWithUserName:userName          // 用户名
                                                                                      userUuid:userUuid          // 用户 ID
                                                                                      userRole:userRole          // 用户角色
                                                                                      roomName:roomName          // 房间名
                                                                                      roomUuid:roomUuid          // 房间 ID
                                                                                      appId:appId                //声网 App ID
                                                                                      token:token                // 测试环境下，你可以使用临时 Token；生产或安全环境下，强烈建议你使用服务器生成的 Token
                                                                                      region:region              // 区域
                                                                                      mediaOptions:mediaOptions  // 媒体相关配置
                                                                                      userProperties:nil];       // 用户自定义属性

   AgoraProctorSDK *proctor = [[AgoraProctorSDK alloc] init:launchConfig
   												           delegate:self];

   [proctor launch:successBlock
             failure:failureBlock];
   ```

   示例代码中需要传入 `token`。你可以参考[获取 RTM Token](/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-rtm-token) 了解什么是 Token，如何获取测试用途的临时 Token，如何从服务器生成 Token。
   <div class="alert note">声网提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。在正式环境中，为确保安全，你必须参考<a href="/cn/Real-time-Messaging/token_upgrade_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。生成的 token 传入的 <code>userId</code> 需要和 <code>launch</code> 方法中传入的参数 <code>userUuid</code> 保持一致，否则生成的 token 无效。</div>

5. （可选）自定义监考场景的灵动课堂界面的显示模式（明亮/暗黑）和语言（中文/英文）。

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
    
## 集成教育场景下灵动课堂并自定义

如需自定义教育场景下灵动课堂，你需要通过 GitHub 下载源码的方式来集成灵动课堂，步骤如下：

1. 运行以下命令将 [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) 和 [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) 项目克隆至本地，可以切换你所需要版本的分支（默认为最新版本的分支）：

	```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git 
	```

	```bash
   git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
	```

2. 通过 `git remote add <shortname> <url>` 命令为 `CloudClass-iOS` 和 `apaas-extapp-ios` 仓库添加远端仓库，指向你的项目仓库，并将所需的分支推向你的仓库。
3. 在你的项目的 `Podfile` 文件中添加如下依赖，来引用 CloudClass-iOS 仓库中的 `AgoraClassroomSDK_iOS.podspec`、`AgoraEduUI.podspec` 和 apaas-extapp-ios 项目中的 `AgoraWidgets.podspec` 以及其它依赖的库。

   ```
   # third-party libs
   pod 'CocoaLumberjack',   '3.6.1'
   pod 'AliyunOSSiOS',      '2.10.8'
   pod 'SSZipArchive',      '2.4.2'
   pod 'SwifterSwift',      '5.2.0'
   pod 'SDWebImage',        '5.12.0'
   pod 'Protobuf',          '3.17.0'
   pod 'Masonry',           '1.1.0'
   pod 'Armin',             '1.1.0'
     
   # agora libs
   pod 'AgoraRtcEngine_iOS/RtcBasic', '3.7.2'
   pod 'AgoraMediaPlayer_iOS',        '1.3.0'
   pod 'Agora_Chat_iOS',              '1.0.6'
   pod 'AgoraRtm_iOS',                '1.4.8'
   pod 'Whiteboard',                  '2.16.51'
    
   # open-source libs
   pod 'AgoraClassroomSDK_iOS',   :path => '../CloudClass-iOS/AgoraClassroomSDK_iOS.podspec'
   pod 'AgoraEduUI', 			  :path => '../CloudClass-iOS/AgoraEduUI.podspec'
   pod 'AgoraWidgets', 			  :path => '../apaas-extapp-ios/AgoraWidgets.podspec'
    
   # close-source libs
   pod 'AgoraUIBaseViews',      '2.8.0'
   pod 'AgoraEduCore', 			'2.8.20'
   pod 'AgoraWidget', 			'2.8.0'
   ```

4. 在终端中进入到工程目录，执行 `pod install` 命令。

安装完成后，参照[自定义课堂 UI](agora_class_custom_ui_ios) 了解灵动课堂的开源层设计思路，就可以修改源代码来自定义场景了。

## 集成监考场景下灵动课堂并自定义

如需自定义监考场景下灵动课堂，你需要通过下载 GitHub 仓库源码的方式来集成灵动课堂，步骤如下：

1. 运行以下命令将 [proctor-ios](https://github.com/AgoraIO-Community/proctor-ios) 项目克隆至本地，可以切换你所需要版本的分支（默认为最新版本的分支）：

	```bash
   	git clone https://github.com/AgoraIO-Community/proctor-ios.git
	```

2. 通过 `git remote add <shortname> <url>` 命令为 `proctor-ios` 仓库添加远端仓库，指向你的项目仓库，并将所需的分支推向你的仓库。
3. 在你的项目的 `Podfile` 文件中添加如下依赖，来引用 proctor-ios 仓库中的 `AgoraProctorSDK.podspec`、`AgoraProctorUI.podspec` 以及其它依赖的库：

   ```
   # third-party libs
   pod 'CocoaLumberjack',   '3.6.1'
   pod 'AliyunOSSiOS',      '2.10.8'
   pod 'SSZipArchive',      '2.4.2'
   pod 'SwifterSwift',      '5.2.0'
   pod 'SDWebImage',        '5.12.0'
   pod 'Protobuf',          '3.17.0'
   pod 'Masonry',           '1.1.0'
   pod 'Armin',             '1.1.0'
     
   # agora libs
   pod 'AgoraRtcEngine_iOS/RtcBasic', '3.7.2'
   pod 'AgoraMediaPlayer_iOS',        '1.3.0'
   pod 'AgoraRtm_iOS',                '1.4.8'
    
   # open-source libs
   pod 'AgoraProctorSDK',   :path => '../proctor-ios/AgoraProctorSDK.podspec'
   pod 'AgoraProctorUI',    :path => '../proctor-ios/AgoraProctorUI.podspec'
    
   # close-source libs
   pod 'AgoraUIBaseViews',      '2.8.0'
   pod 'AgoraEduCore', 			'2.8.20'
   pod 'AgoraWidget', 			'2.8.0'
   ```
4. 在终端中进入到工程目录，执行 `pod install` 命令。

安装完成后，参照[自定义课堂 UI](agora_class_custom_ui_ios) 了解灵动课堂的开源层设计思路，就可以修改源代码来自定义场景了。

## 注意事项
集成后在你的项目中的 `info.plist` 文件里增加 `Privacy - Camera Usage Description`、 `Privacy - Microphone Usage Description`、 `Privacy - Photo Library Additions Usage Description`、 `Privacy - Photo Library Usage Description`，以获取在运行灵动课堂时所必要的权限。