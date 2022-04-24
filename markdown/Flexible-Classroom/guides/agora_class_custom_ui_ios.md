## 教室与 UI 组件介绍

### 数据交互流程

在 Agora Classroom SDK 中，灵动课堂的 UI 层代码和核心业务逻辑相隔离，独立成 **AgoraEduUI** 和 **AgoraEduCore** 两个库，两者通过 [Agora Edu Context](/cn/agora-class/API%20Reference/edu_context_swift/API/edu_context_api_overview.html) 产生关联。举例来说，对于灵动课堂中的设备开关功能，需要通过一个按钮改变设备状态。为实现该功能，我们在 `AgoraEduUI` 中调用 `AgoraEduMediaContext` 的 `openLocalDevice` 方法，并监听 `AgoraEduMediaHandler` 抛出的设备状态改变相关事件。

数据流转示意图如下：

![](https://web-cdn.agora.io/docs-files/1650273644082)

### 教室和 UI 组件结构说明

`AgoraEduUI` 中包含灵动课堂的 UI 组件代码。`AgoraEduUI` 的源码位于 GitHub 上 CloudClass-iOS 仓库 `/SDKs/AgoraEduUI` 目录下，核心项目结构介绍如下：

| 文件夹         | 描述                                                                                                                                             |
| :------------- | :----------------------------------------------------------------------------------------------------------------------------------------------- |
| `/Scene`       | 在灵动课堂的各种教学场景中组装 UI 组件的 `UIManager`，如 1v1 课堂，小班课等。                                                                    |
| `/Components`  | 灵动课堂使用的高阶 UI 组件(**UIController**)，如花名册、状态栏等。                                                                               |
| `/Config`      | 灵动课堂的 UI 配置，根据 AgoraUIMode 自动适配，如背景颜色、字体颜色、边框宽度。开发者可以在此文件中定义自己的 AgoraUIMode 即可便捷更换 UI 风格。 |
| `/CustomViews` | 灵动课堂使用的基础 UI 组件，如视频渲染窗口、弹窗等。                                                                                             |
| `/Utils`       | 灵动课堂常用的 x 扩展功能，如获取图片，context 数据类型转换为 UI 所需数据类型等。                                                                |
| `WidgetModels` | AgoraEduUI 用于解析 widget 数据所定义的对应数据模型及解析方法。                                                                                  |

### 类型说明

-   `UIManager`

    -   每种班型都对应一个 `UIManager`，类型为 `UIViewController`。
    -   `UIManager` 管理多个 `UIController`，负责 `UIController` 之间的通讯。
    -   `UIManager` 拥有一个 `contentView`，是当前教室界面最底部的容器视图，用于框出一块 16:9 的适配区域。
    -   每个 `UIManager` 都持有一个 `contextPool`，用于使用 AgoraEduContext 层的功能。

-   `UIController`

    -   每个 `UIController` 即一个 UI 组件，类型为 `UIViewController`，对应一个交互模块。

    -   `UIController` 的 view 是 `UIManager.contentView` 的 subView，用于该功能的占位。

    -   `UIController` 位于 `AgoraEduUI` 库的 `/Components` 文件夹下，分为以下两种：

        -   `FlatComponents`: 一般为教室平铺类型的 UI。
        -   `SuspendComponents`: 一般为弹窗类型的 UI。

        如下图所示：

### 教室结构示意图

以下以小班课教师端举例

### 修改灵动课堂的默认 UI

如果你想要修改灵动课堂的默认 UI，则参考以下步骤集成灵动课堂：

1. 将 [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) 和 [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) 项目克隆至本地，并切换至最新发版分支。

    ```bash
    git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
    ```

    ```
    git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
    ```

2. 通过 `git remote add <shortname> <url>` 命令为 CloudClass-iOS 和 apaas-extapp-ios 仓库添加远端仓库，指向你的项目仓库。

3. 基于最新的发版分支创建一个你自己的分支，推向你的项目仓库。

<div class="alert info">发版分支为 release/apaas/x.y.z。x.y.z 为版本号。你可在<a href="/cn/agora-class/release_agora_class_ios?platform=iOS">发版说明</a>中获取最新版本号。</div>

1. 在你的项目的 `Podfile` 文件中添加如下代码引用依赖库。

    ```
    # Third-party libs
    pod 'OpenSSL-Universal', '1.0.2.17'
    pod 'Protobuf', '3.17.0'
    pod "CocoaLumberjack", '3.6.1'
    pod 'AliyunOSSiOS',  '2.10.8'
    pod 'Armin',  '1.0.9'
    pod 'Alamofire', '4.7.3'
    pod 'SSZipArchive', '2.4.2'
    pod 'SwifterSwift', '5.2.0'
    pod 'Masonry'
    pod 'SDWebImage', '5.12.0'

    # Agora libs
    pod 'AgoraRtm_iOS', '1.4.8'
    pod 'Whiteboard', '2.15.8'
    pod 'AgoraRtcEngine_iOS', '3.4.6'
    pod 'HyphenateChat', '3.8.6'

    # Open-source libs
    pod 'AgoraClassroomSDK_iOS', :path => 'CloudClass-iOS/SDKs/AgoraClassroomSDK/AgoraClassroomSDK_Local.podspec'
    pod 'AgoraEduContext', :path => 'CloudClass-iOS/SDKs/AgoraEduContext/AgoraEduContext_Local.podspec'
    pod 'AgoraEduUI', :path => 'CloudClass-iOS/SDKs/AgoraEduUI/AgoraEduUI_Local.podspec'

    # Open-source widgets and extApps
    pod 'AgoraWidgets', :path => 'apaas-extapp-ios/Widgets/AgoraWidgets/AgoraWidgets_Local.podspec'
    pod 'ChatWidget', :path => 'apaas-extapp-ios/Widgets/ChatWidget/ChatWidget_Local.podspec'
    pod 'AgoraExtApps', :path => 'apaas-extapp-ios/ExtApps/AgoraExtApps_Local.podspec'

    # Closed-source libs
    pod 'AgoraEduCore', '2.0.1'
    ```
