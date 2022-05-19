## 教室与 UI 组件介绍

### 数据交互流程

在 Agora Classroom SDK 中，灵动课堂的 UI 层代码和核心业务逻辑相隔离，独立成 **AgoraEduUI** 和 **AgoraEduCore** 两个库，两者通过 [Agora Edu Context](/cn/agora-class/API%20Reference/edu_context_swift/API/edu_context_api_overview.html) 产生关联。举例来说，对于灵动课堂中的设备开关功能，需要通过一个按钮改变设备状态。为实现该功能，我们在 `AgoraEduUI` 中调用 `AgoraEduMediaContext` 的 `openLocalDevice` 方法，并监听 `AgoraEduMediaHandler` 抛出的设备状态改变相关事件。

数据流转示意图如下：

![](https://web-cdn.agora.io/docs-files/1650273644082)

### 教室和 UI 组件结构说明

`AgoraEduUI` 中包含灵动课堂的 UI 组件代码。`AgoraEduUI` 的源码位于 GitHub 上 CloudClass-iOS 仓库 `/SDKs/AgoraEduUI` 目录下，核心项目结构介绍如下：

| 文件夹         | 描述                                                                                                                              |
| :------------- | :-------------------------------------------------------------------------------------------------------------------------------- |
| `/Scene`       | 在灵动课堂的各种版型中组装 UI 组件的 `UIManager`，如一对一课堂、小班课等。                                                        |
| `/Components`  | 灵动课堂使用的高阶 UI 组件 (UIController)，如花名册、状态栏等。                                                                   |
| `/Config`      | 灵动课堂的 UI 配置。能够根据 `AgoraUIMode` 自动适配背景颜色、字体颜色、边框宽度等。开发者可以在此文件中定义自己的 `AgoraUIMode`。 |
| `/CustomViews` | 灵动课堂使用的基础 UI 组件，如视频渲染窗口、弹窗等。                                                                              |
| `/Utils`       | 灵动课堂的扩展功能，如获取图片、数据类型转换等。                                                                                  |
| `WidgetModels` | 用于在 `AgoraEduUI` 中解析 Widget 数据所定义的对应数据模型及解析方法。                                                            |

### 类型说明

-   `UIManager`

    -   一个 `UIManager ` 对应一种班型，类型为 `UIViewController`。
    -   `UIManager` 管理多个 `UIController`，负责 `UIController` 之间的通讯。
    -   `UIManager` 拥有一个 `contentView`，是当前教室界面最底部的容器视图，用于框出一块 16:9 的适配区域。
    -   每个 `UIManager` 都持有一个 `contextPool`，用于使用 `AgoraEduContext` 层的能力。

-   `UIController`

    -   一个 `UIController` 对应一个 UI 组件，类型为 `UIViewController`。

    -   `UIController` 的 view 是 `UIManager.contentView` 的 subView，用于该功能的占位。

    -   `UIController` 位于 `AgoraEduUI` 库的 `/Components` 文件夹下，分为以下两种：
        -   `FlatComponents`: 平铺类型的 UI。
        -   `SuspendComponents`: 弹窗类型的 UI。

### UI 结构示意图

![](https://web-cdn.agora.io/docs-files/1651750314208)

以小班课教师端举例，UI 组件布局如下：

![](https://web-cdn.agora.io/docs-files/1651750043245)

## 自定义课堂 UI

本节介绍自定义课堂 UI 的具体步骤。

### 1. 获取灵动课堂源码

如需修改灵动课堂的默认 UI，你需要通过下载 GitHub 源码的方式集成灵动课堂，步骤如下：

1. 运行以下命令将 [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) 和 [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) 项目克隆至本地，并切换至最新发版分支。

    ```bash
    git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
    ```

    ```bash
    git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
    ```

2. 通过 `git remote add <shortname> <url>` 命令为 **CloudClass-iOS** 和 **apaas-extapp-ios** 仓库添加远端仓库，指向你的项目仓库。

3. 基于最新的发版分支创建一个你自己的分支，推向你的项目仓库。

4. 在你的项目的 `Podfile` 文件中添加如下代码引用 CloudClass-iOS 项目中的 `AgoraClassroomSDK_iOS.podspec`、`AgoraEduContext.podspec`、`AgoraEduUI.podspec` 和 apaas-extapp-ios 项目中的 `AgoraWidgets.podspec` 以及其它依赖的库。

    ```swift
    # Third-party libs
    pod 'OpenSSL-Universal', '1.0.2.17'
    pod 'Protobuf', '3.17.0'
    pod "CocoaLumberjack", '3.6.1'
    pod 'AliyunOSSiOS',  '2.10.8'
    pod 'Armin',  '1.0.10'
    pod 'Alamofire', '4.7.3'
    pod 'SSZipArchive', '2.4.2'
    pod 'SwifterSwift', '5.2.0'
    pod 'Masonry', '1.1.0'
    pod 'SDWebImage', '5.12.0'
    pod 'WHToast', '0.0.7'
    pod 'FLAnimatedImage', '1.0.16'

    # Agora libs
    pod 'AgoraRtcEngine_iOS', '3.4.6'
    pod 'AgoraRtm_iOS', '1.4.8'
    pod 'HyphenateChat', '3.8.6'
    pod 'Whiteboard', '2.16.13'

    # Open-source libs
    pod 'AgoraClassroomSDK_iOS', :path => '../AgoraClassroomSDK_iOS.podspec'
    pod 'AgoraEduContext', :path => '../AgoraEduContext.podspec'
    pod 'AgoraEduUI', :path => '../AgoraEduUI.podspec'

    # Open-source widgets and extApps
    pod 'AgoraWidgets', :path => '../../apaas-extapp-ios/AgoraWidgets.podspec'

    # Closed-source libs
    pod 'AgoraEduCore', '2.4.0'
    ```

### 2. 修改现有的 UI 组件

#### 示例一：修改导航栏的颜色与布局

你可通过以下三种方式修改导航栏的颜色：

-   方式一：直接修改 `UIController` 中的代码。

-   方式二：自定义 `AgoraUIMode`。灵动课堂默认使用 `agoraLight` 模式，你可以定义一个模式。

-   方式三：直接修改在 `agoraLight` 模式。

以下为方式三的示例代码：

**修改前**

```swift
var room_state_bg_color: UIColor {
    switch mode {
    case .agoraLight:  return .white
    case .akasuo:      return UIColor(hex: 0x1D35AD)!
    }
}
```

![](https://web-cdn.agora.io/docs-files/1651751702539)

**修改后**

```swift
var room_state_bg_color: UIColor {
    switch mode {
    case .agoraLight:  return .systemTeal
    case .akasuo:      return UIColor(hex: 0x1D35AD)!
    }
}
```

![](https://web-cdn.agora.io/docs-files/1651751774540)

#### 示例二：修改花名册图片资源

花名册 UI 组件的代码主要位于以下两个文件中：

-   AgoraEduUI/AgoraEduUI/Classes/Components/SuspendComponents/AgoraUserListUIController.swift
-   AgoraEduUI/AgoraEduUI/Classes/CustomViews/AgoraUserList/AgoraUserListItemCell.swift

花名册 UI 组件应用于学生端小班课、教师端小班课、教师端大班课教室中。教师端可以操作花名册，学生端不可操作。学生信息列表中包含学生姓名、上下台、白板授权、摄像头、麦克风、奖励六栏，如下图所示：

![](https://web-cdn.agora.io/docs-files/1651752243091)

其中：

-   上下台和白板授权仅有 **true** 和 **false** 两种状态。
-   摄像头和麦克风有**未上台+不可操作**、**已上台+设备关闭**、**已上台+设备开启+发流权限关闭**、**已上台+设备开启+发流权限开启**四种状态。

花名册的数据源如下：

-   学生总人数的变化和上台人数变化由 `AgoraEduUserHandler` 中的回调报告。
-   麦克风状态和摄像头状态由 `AgoraEduStreamHandler` 中的回调报告。
-   白板授权状态由 ID 为 `netlessBoard` 的 Widget 消息报告。

以摄像头状态为例，数据流转过程如下：

1. 当流状态发生变化，会触发 `AgoraEduStreamHandler` 的 `onStreamUpdated` 回调，然后通过 `updateModel` 方法更新数据源。
2. 数据源更新完成后，调用 `tableView.reloadData()` 刷新 tableView 的每个 Cell。
3. 在 `AgoraUserListItemCell` 的 `updateState` 方法中刷新图标。

因此，如果我们想更新学生端小班课中花名册的摄像头图标，可参考以下步骤：

1. 将新的摄像头图标 **new_camera_on** 和 **new_camera_off** 放置于 `AgoraEduUI/AgoraEduUI/Assets/images.xcassets/NameRoll` 文件夹中：

    ![](https://web-cdn.agora.io/docs-files/1651755311560)

2. 更新 `AgoraUserListItemCell.swift` 文件中的代码。

**修改前**

```swift
// colors
let onColor = UIColor(hex: 0x0073FF)
let offColor = UIColor(hex: 0xF04C36)
let disabledColor = UIColor(hex: 0xE2E2EE)

// state
case .camera:
    if !model.stageState.isOn {
        // unCohost
        let image = UIImage.agedu_named("ic_nameroll_camera_on")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = disabledColor
    } else if !model.cameraState.deviceOn {
        // cohost + device off
        let image = UIImage.agedu_named("ic_nameroll_camera_off")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = disabledColor
    } else if !model.cameraState.streamOn {
        // cohost + device on + no video stream privilege
        let image = UIImage.agedu_named("ic_nameroll_camera_off")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = offColor
    } else {
        // cohost + device on + video stream privilege
        let image = UIImage.agedu_named("ic_nameroll_camera_on")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = onColor
    }
    cameraButton.isUserInteractionEnabled = model.cameraState.isEnable
```

**修改后**

```swift
case .camera:
    if !model.stageState.isOn {
        // unCohost
        let image = UIImage.agedu_named("new_camera_on")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = disabledColor
    } else if !model.cameraState.deviceOn {
        // cohost + device off
        let image = UIImage.agedu_named("new_camera_off")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = disabledColor
    } else if !model.cameraState.streamOn {
        // cohost + device on + no video stream privilege
        let image = UIImage.agedu_named("new_camera_off")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = offColor
    } else {
        // cohost + device on + video stream privilege
        let image = UIImage.agedu_named("new_camera_on")
        if let i = image?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setImageForAllStates(i)
        }
        cameraButton.tintColor = onColor
    }
    cameraButton.isUserInteractionEnabled = model.cameraState.isEnable
```

![](https://web-cdn.agora.io/docs-files/1651756155692)

![](https://web-cdn.agora.io/docs-files/1651756204269)

### 3. 新增 UI 组件

新增 UI 组件的基本步骤如下：

1. 在 `/Components` 文件夹中新增一个 `UIController`。
2. 在 `UIManager` 中添加该 `UIController` 并添加视图。

以下示例展示了如何在工具栏组件 `AgoraToolBarUIController` 中新增一个用于上传日志的按钮。该改动涉及以下两个文件：

-   AgoraEduUI/AgoraEduUI/Classes/Components/FlatComponents/AgoraToolBarUIController.swift
-   AgoraEduUI/Classes/Scene/Small/AgoraSmallUIManager.swift

**修改前**

```swift
// AgoraToolBarUIController.swift
public enum ItemType {
    case setting, nameRoll, message, handsup, handsList, brushTool, help

    func cellImage() -> UIImage? {
        switch self {
        case .setting:          return UIImage.agedu_named("ic_func_setting")
        case .nameRoll:         return UIImage.agedu_named("ic_func_name_roll")
        case .message:          return UIImage.agedu_named("ic_func_message")
        case .handsup:          return UIImage.agedu_named("ic_func_hands_up")
        case .handsList:        return UIImage.agedu_named("ic_func_hands_list")
        case .brushTool:        return UIImage.agedu_named("ic_brush_pencil")
        case .help:             return UIImage.agedu_named("ic_func_help")
        default:                return nil
        }
    }
}


// AgoraSmallUIManager.swift
if contextPool.user.getLocalUserInfo().userRole == .teacher {
    toolBarController.tools = [.setting, .message,.nameRoll, .handsList]
}


extension AgoraSmallUIManager: AgoraToolBarDelegate {
    func toolsViewDidSelectTool(tool: AgoraToolBarUIController.ItemType,
                                selectView: UIView) {
        // button actions
        switch tool {
        case .setting:
            settingViewController.view.frame = CGRect(origin: .zero,
                                                      size: settingViewController.suggestSize)
            ctrlView = settingViewController.view
        case .nameRoll:
            nameRollController.view.frame = CGRect(origin: .zero,
                                                   size: nameRollController.suggestSize)
            ctrlView = nameRollController.view
        case .message:
            chatController.view.frame = CGRect(origin: .zero,
                                               size: chatController.suggestSize)
            ctrlView = chatController.view
        case .handsList:
            if handsListController.dataSource.count > 0 {
                handsListController.view.frame = CGRect(origin: .zero,
                                                         size: handsListController.suggestSize)
                ctrlView = handsListController.view
            }
        default:
            break
        }
        ctrlViewAnimationFromView(selectView)
    }

    func toolsViewDidDeselectTool(tool: AgoraToolBarUIController.ItemType) {
        ctrlView = nil
    }
}
```

**修改后**

```swift
// AgoraToolBarUIController.swift
// add new ItemType like "upload"，and put new icon picture as "ic_func_upload@2x.png","ic_func_upload@3x.png" in the assets of AgoraEduUI
public enum ItemType {
    case setting, nameRoll, message, handsup, handsList, brushTool, help, upload

    func cellImage() -> UIImage? {
        switch self {
        case .setting:          return UIImage.agedu_named("ic_func_setting")
        case .nameRoll:         return UIImage.agedu_named("ic_func_name_roll")
        case .message:          return UIImage.agedu_named("ic_func_message")
        case .handsup:          return UIImage.agedu_named("ic_func_hands_up")
        case .handsList:        return UIImage.agedu_named("ic_func_hands_list")
        case .brushTool:        return UIImage.agedu_named("ic_brush_pencil")
        case .help:             return UIImage.agedu_named("ic_func_help")
        case .upload:           return UIImage.agedu_named("ic_func_upload")
        default:                return nil
        }
    }
}


// AgoraSmallUIManager.swift
// In the AgoraSmallaUIManager，find where to set tools for toolBarController and add your new type
if contextPool.user.getLocalUserInfo().userRole == .teacher {
    toolBarController.tools = [.setting, .message,.nameRoll, .handsList, .upload]
}


// button actions
extension AgoraSmallUIManager: AgoraToolBarDelegate {
    func toolsViewDidSelectTool(tool: AgoraToolBarUIController.ItemType,
                                selectView: UIView) {
        switch tool {
        case .setting:
            settingViewController.view.frame = CGRect(origin: .zero,
                                                      size: settingViewController.suggestSize)
            ctrlView = settingViewController.view
        case .nameRoll:
            nameRollController.view.frame = CGRect(origin: .zero,
                                                   size: nameRollController.suggestSize)
            ctrlView = nameRollController.view
        case .message:
            chatController.view.frame = CGRect(origin: .zero,
                                               size: chatController.suggestSize)
            ctrlView = chatController.view
        case .handsList:
            if handsListController.dataSource.count > 0 {
                handsListController.view.frame = CGRect(origin: .zero,
                                                         size: handsListController.suggestSize)
                ctrlView = handsListController.view
            }
        // [new action]，call the context to upload log
        case .upload:
            contextPool.monitor.uploadLog(success: nil,
                                          failure: nil)
        default:
            break
        }
        ctrlViewAnimationFromView(selectView)
    }

    func toolsViewDidDeselectTool(tool: AgoraToolBarUIController.ItemType) {
        ctrlView = nil
    }
}
```
