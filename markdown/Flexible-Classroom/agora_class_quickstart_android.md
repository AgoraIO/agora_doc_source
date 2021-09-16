根据本文指导通过 Agora Classroom SDK 快速启动并体验灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>
## 前提条件

- 已在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)。
- Android Studio 4.0 及以上。
- Android 5.0 或以上版本。
- 一台 Android 设备。模拟机可能出现功能缺失或者性能问题，所以推荐使用真机。

## 启动灵动课堂

参照以下步骤启动灵动课堂：

1. 运行以下命令将 Agora 提供的灵动课堂项目 CloudClass-Android 克隆至本地：

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
   ```

2. 在 Android Studio 中打开 CloudClass-Android。

3. 将 `app/src/normal/res/values/string_config.xml` 文件中的 `Agora App ID` 和 `Agora App Certificate` 替换成[你的 App ID 和 App 证书](#prerequisites)。

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <resources>
           <string name="agora_app_id" translatable="false">Agora App ID</string>
           <string name="agora_app_cert" translatable="false">Agora App Certificate</string>
           <string name="agora_api_host" translatable="false">Agora API Host</string>
           <string name="agora_report_host" translatable="false">Report API Host</string>
   </resources>
   ```

   为方便你快速测试，CloudClass-Android 项目中已包含一个临时 RTM Token 生成器，会用你传入的 App ID 和 App 证书生成一个临时 RTM Token。但是在正式环境中，为确保安全，RTM Token 必须在服务端生成。

   你可在 `app/src/normal/java/io/agora/education/MainActivity2.kt` 文件中查看启动课堂的具体逻辑：

   1. 调用 [AgoraEduSDK.setConfig](/cn/agora-class/agora_class_api_ref_android?platform=Android#setconfig) 方法全局配置 SDK。
   2. 调用 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_android?platform=Android#launch) 方法启动灵动课堂。

4. 在 Android Studio 中编译并运行该项目。你可以在 Android 设备上看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1623315354864)

5. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂，看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1622431132516)

## 后续步骤

如果 Agora Classroom SDK 中默认的 UI 无法满足你的需求，你可以参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_android?platform=Android)，获取 Agora Classroom SDK 的源码，自行修改灵动课堂的 UI，如更换颜色、调整布局。

## 更多信息

<a name="sdk"></a>

### 集成灵动课堂

本节详细介绍如何将灵动课堂集成到你自己的 iOS 项目中。

灵动课堂可分为 AgoraClassroomSDK、AgoraEduCore、AgoraEduUI、AgoraEduContext 四个 SDK，如下图所示。其中 AgoraClassroomSDK、AgoraEduUI、AgoraEduContext 在 Github 与 Cocoapods 上开源发布；AgoraEduCore 闭源，以二进制包在 Cocoapods 上发布。



![edu-apaas-structure](/Users/lyy/github-repos/doc_source/markdown/Flexible-Classroom/images/edu-apaas-structure.png)

#### 使用灵动课堂的默认 UI

如果你无需修改灵动课堂的默认 UI，在你自己项目的 `Podfile` 文件中添加如下引用即可集成灵动课堂：

```
# Open source libs
pod 'AgoraClassroomSDK_iOS', "1.1.5"
pod 'AgoraEduContext', "1.1.5"
pod 'AgoraEduUI', "1.1.5"
pod 'AgoraUIEduBaseViews', "1.1.5"
 
# Close source libs
pod 'AgoraEduCore', "1.1.5.4"
 
# Common libs
pod 'AgoraUIBaseViews', '1.0.1'
pod 'AgoraExtApp', '1.0.0'
pod 'AgoraWidget', '1.0.0'
 
# Widgets
pod 'AgoraWidgets', "1.0.0"
   
# Third-party libs
pod 'Protobuf', '3.17.0'
pod "AFNetworking", "4.0.1"
pod "CocoaLumberjack", "3.6.1"
pod "AliyunOSSiOS", "2.10.8"
pod "Whiteboard", "2.13.19"
pod "AgoraRtcEngine_iOS", "3.4.6"
pod "AgoraRtm_iOS", "1.4.8"
```

#### 需要自定义课堂 UI

如果灵动课堂的默认 UI 无法满足你的需求，你需要自定义课堂 UI，则参考以下步骤将灵动课堂集成到你自己的项目中：

1. 运行以下命令将 CloudClass-iOS 仓库克隆至本地：

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS
   ```

3. 通过 `git remote add` 命令， 为 CloudClass-iOS 仓库添加一个远端仓库，指向你自己的仓库。

3. 基于 release/apaas/1.1.5 分支创建一个你自己的分支，如 `edu_apaas_ui`，推向你自己的仓库。

4. 在你自己项目的 `Podfile` 文件中添加如下代码引用 CloudClass-iOS 仓库中的 `AgoraClassroomSDK.podspec`、`AgoraEduContext.podspec`、`AgoraEduUI.podspec`、`AgoraUIEduBaseViews.podspec` 以及其它依赖的库。

   ```
   # Open source libs
   pod 'AgoraClassroomSDK', :path => '../SDKs/AgoraClassroomSDK/AgoraClassroomSDK.podspec'
   pod 'AgoraEduContext', :path => '../SDKs/AgoraEduContext/AgoraEduContext.podspec'
   pod 'AgoraEduUI', :path => '../SDKs/AgoraEduUI/AgoraEduUI.podspec'
   pod 'AgoraUIEduBaseViews', :path => '../SDKs/Modules/AgoraUIEduBaseViews/AgoraUIEduBaseViews_Local.podspec'
    
   # Close source libs
   pod 'AgoraEduCore', "1.1.5.4"
   
   # Common libs
   pod 'AgoraUIBaseViews', '1.0.1'
   pod 'AgoraExtApp', '1.0.0'
   pod 'AgoraWidget', '1.0.0'
    
   # Widgets
   pod 'AgoraWidgets', :path => '../Widgets/AgoraWidgets/AgoraWidgets.podspec'
   pod 'ChatWidget', :path => '../Widgets/ChatWidget/ChatWidget.podspec', :subspecs => ['SOURCE']
    
   # Third-party libs
   pod 'Protobuf', '3.17.0'
   pod "AFNetworking", "4.0.1"
   pod "CocoaLumberjack", "3.6.1"
   pod "AliyunOSSiOS", "2.10.8"
   pod "Whiteboard", "2.13.19"
   pod "AgoraRtcEngine_iOS", "3.4.6"
   pod "AgoraRtm_iOS", "1.4.8"
   ```

5. 后续你可在 `edu_apaas_ui`分支，参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_ios?platform=iOS)自行修改灵动课堂的 UI，如更换颜色、调整布局。

### 集成 Agora Classroom SDK

你可以参考以下步骤，通过 [JitPack](https://jitpack.io/#AgoraIO-Community/CloudClass-Android) 将 Agora Classroom SDK 集成到你自己的 Android 项目中：

1. 在项目的 **build.gradle** 文件中添加以下库：

   ```
   allprojects {
   	repositories {
   		...
   		maven { url'http://maven.aliyun.com/nexus/content/groups/public' }
   		maven { url 'https://jitpack.io' }
   	}
   }
   ```

2. 在项目的 **build.gradle** 文件中添加以下依赖：

   ```
   dependencies {
           ...
   		// 请访问 https://jitpack.io/#AgoraIO-Community/CloudClass-Android 获取最新 Tag
   		implementation 'com.github.AgoraIO-Community:CloudClass-Android:Tag'
   }
   ```