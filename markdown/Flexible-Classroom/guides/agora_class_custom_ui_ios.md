Classroom SDK（AgoraEduUI）和 Proctor SDK（AgoraProctorUI）原理相同，本文以 Classroom SDK 为例。

在声网 Classroom SDK 中，灵动课堂的 UI 层代码和核心业务逻辑相隔离，独立成 **AgoraEduUI** 和 **AgoraEduCore** 两个库，两者通过 [Agora Edu Context](/cn/agora-class/API%20Reference/edu_context_swift/API/edu_context_api_overview.html) 产生关联。

如果你需要自定义课堂 UI，需要下载并修改灵动课堂源码。具体步骤参照[集成教育场景下灵动课堂并自定义](agora_class_integrate_ios#%E9%9B%86%E6%88%90%E6%95%99%E8%82%B2%E5%9C%BA%E6%99%AF%E4%B8%8B%E7%81%B5%E5%8A%A8%E8%AF%BE%E5%A0%82%E5%B9%B6%E8%87%AA%E5%AE%9A%E4%B9%89)和[集成监考场景下灵动课堂并自定义](agora_class_integrate_ios#%E9%9B%86%E6%88%90%E7%9B%91%E8%80%83%E5%9C%BA%E6%99%AF%E7%81%B5%E5%8A%A8%E8%AF%BE%E5%A0%82%E5%B9%B6%E8%87%AA%E5%AE%9A%E4%B9%89)。


# 文件夹介绍
`AgoraEduUI` 的源码位于 `CloudClass-iOS` 仓库 `/SDKs/AgoraEduUI/Classes` 目录下，核心结构介绍如下：

| 文件夹         | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| `/Scenes`       | 灵动课堂班型场景的组件 `UIScene`，适用于一对一课堂、小班课等班型。 |
| `/Components`  | 灵动课堂的 UI 组件 `UIComponent`，可用于花名册、状态栏等 UI 设计。 |
| `/Configs`      | 灵动课堂的 UI 配置，用于设置颜色，字体，图片等。 |
| `/Views` | 灵动课堂使用的 UI 元素，如视频渲染窗口、设置界面等。         |
| `/Models` | 用于 `AgoraEduUI` 的数据模型。 |

# 交互层架构
灵动课堂的交互层和逻辑层是相互分离，交互层的架构与设计模式如下图所示

![](https://web-cdn.agora.io/docs-files/1670308423580)

## UIScene
* 业务场景的抽象，例如一对一课堂场景对应 `FcrOneToOneUIScene`
* 管理所有的 UIComponent

## UIComponent
* 业务功能的抽象，例如一对一教学课堂中的视频列表窗口对应 `FcrOneToOneTachedWindowUIComponent`
* 管理 view object 与 logic object
![](https://web-cdn.agora.io/docs-files/1680863775387)

## View Object
* 视图对象，负责视图数据的显示与响应用户交互，例如 `FcrWindowRenderView`

## Logic Object
* 逻辑对象，提供功能 API 给 UIComponent 调用，例如媒体模块中的打开本地设备对应 `AgoraEduMediaContext.openLocalDevice`

## Logic Data
* 由 Logic Object 输出的逻辑数据，例如媒体流数据对应 `AgoraEduContextStreamInfo`

## View Data
* 由 Logic Data 转换而来，为视图展示所需要的数据，例如媒体流窗口数据对应  `FcrStreamWindowViewData`

# UIConfig
UI 配置，用于设置颜色、字体、图片等。源文件位于 `SDKs/AgoraEduUI/Classes/Configs` 下，分为两个文件夹 Scenes 与 Theme。

## Theme 文件夹

提供与主题相关的设置，例如明亮模式与暗黑模式，前景色，字体样式等。

| Theme              | 说明                   |
| :-------------     | :-------------        |
| `FcrUIMode`        | 明亮模式和暗夜模式。       | 
| `FcrUIColorGroup ` | 灵动课堂所使用的通用颜色。  | 
| `FcrUIFontGroup `  | 灵动课堂所使用的通用字体。  |
| `FcrUIFrameGroup ` | 灵动课堂所使用的通用尺寸。  |


例如，你想要修改明亮模式下的系统背景色，可参考以下代码：

```swift
struct FcrUIColorGroup {
	...
	static var systemBackgroundColor: UIColor {
        switch UIMode {
        // 明亮模式下的系统背景色设置为绿色
        case .agoraLight: return .green
        case .agoraDark:  return UIColor(hex: 0x262626)!
        }
    }
	...
}
```

效果如下图所示：
![](https://web-cdn.agora.io/docs-files/1680863801830)


## Scenes 文件夹

提供每个 UIScene、UIComponent、View Object 具体的配置属性，大部分属性的值会来自 Theme 下定义好的通用属性值。例如，`FcrUIComponents.swift` 文件中配置状态栏对应的 UI Component 的背景颜色：

```swift
struct FcrUIComponentStateBar: FcrUIComponentProtocol {
	...
    var backgroundColor: UIColor = FcrUIColorGroup.systemForegroundColor
	...    
}
```



| 配置文件          | 交互层级          | 例子 |
| :-------------   | :-------------  |:------------- |
| `FcrLectureUIConfig.swift`，`FcrOneToOneUIConfig.swift`，`FcrSmallUIConfig.swift`       | UIScene      | `FcrOneToOneConfig.swift` 对应 `FcrOneToOneScene` |
| `FcrUIComponents.swift`   | UIComponent   | `FcrUIComponentStateBar` 对应 `FcrRoomStateUIComponent`  |
| `FcrUIItems.swift`         | View Object   | `FcrUIItemStateBarNetworkState` 对应 `AgoraRoomStateBar.netStateView` |


例如，你想要修改状态栏的背景颜色为蓝色，可参考以下代码：

```swift
struct FcrUIComponentStateBar: FcrUIComponentProtocol {
	...
    var backgroundColor: UIColor = .blue
	...   
}
```

![](https://web-cdn.agora.io/docs-files/1680863821711)

# 资源文件
灵动课堂所使用的图片、动图、UI 文字等资源文件都位于 `SDKs/AgoraEduUI/Assets/` 下

| 文件夹              | 说明                        |
| :-------------     | :-------------             |
| `images.xcassets`  | 存放所有的 PNG 文件               | 
| `others `          | 非 PNG 文件，包括动图、文案等  | 

## 增加新语言

1. 在 `others ` 文件夹下，复制一个原有的语言文件夹（例如 `en.Iproj`），重命名为新语言对应的名称（例如 `jp.Iproj`）。
2. 把文件夹内的 `Localizable.strings` 文件里的 `value` 都替换为新增语言对应的值。
3. 在进入房间前，将 `AgoraUIBaseViews` 里的全局变量 `agora_ui_language` 的指设置为新增语言对应的文件夹名，再进入房间即可生效。
