## 概览

Widget 是包含界面与功能的独立组件。开发者可基于 AgoraBaseWidget 自定义实现一个 Widget，然后在 Agora Classroom SDK 内注册该 Widget。Agora Classroom SDK 支持注册多个 Widget。 Widget 与 Widget 之间，以及 Widget 与 UI 层的其他组件都能进行通讯。

## 操作步骤

本节介绍通过 Widget 实现自定义组件并在灵动课堂内嵌入该组件的基本步骤。

### 1. 开发 Widget

你需要引用 `AgoraWidget` 库，然后继承 `AgoraBaseWidget` 基类开发一个 Widget。

`AgoraBaseWidget` 通过 `AgoraWidgetInfo` 提供必要的 Widget 基本信息，例如房间信息、本地用户信息。你需要额外注意 `widgetUserProperties` 和 `widgetRoomProperties` 两个属性。`widgetUserProperties` 是当前用户的个人数据源，远端用户无法访问或修改。`widgetRoomProperties` 可以同步给远端相同 `widgetId` 的对象，属于所有相同 `widgetId` 的共同数据源。

Agora 已基于 `AgoraBaseWidget` 实现了 `AgoraWhiteboardWidget`（白板功能）、`AgoraCloudWidget`（云盘功能）等 Widget，你可点击以下链接前往 GitHub 查看源码：

- Android: [AgoraWhiteBoardWidget.kt](https://github.com/AgoraIO-Community/CloudClass-Android/blob/release/apaas/2.1.0/AgoraEduUIKit/src/main/java/io/agora/agoraeduuikit/impl/whiteboard/AgoraWhiteBoardWidget.kt)
- iOS: [AgoraWidgets](https://github.com/AgoraIO-Community/apaas-extapp-ios/tree/release/apaas/2.1.0/AgoraWidgets)
- Web/Electron: TBD

<div class="alert info" target="_blank">

查看 [AgoraBaseWidget API 参考](#agorabasewidget)。</div>

### 2. 注册 Widget

调用 `AgoraEduSDK.registerExtApps` 方法，将该插件注册到 Agora Classroom SDK 中。

通过 `AgoraEduLaunchConfig` 中的 `widgets` 里插入想要注册的 Widget 所对应的 `AgoraWidgetConfig` 对象，调用 `AgoraClassroomSDK` 的 `launch` 方法时，会将该 Widget 注册进 SDK。

### 3. 创建 Widget 对象

注册 Widget 后，参考以下步骤创建 Widget 对象：
1. 调用 `AgoraWidgetContext` 中的 `getWidgetConfig` 或 `getWidgetConfigs` 方法获取已成功注册的 Widget 所对应的 `AgoraWidgetConfig` 对象。
2. 调用 `AgoraWidgetContext` 中的 `create` 方法，传入 `AgoraWidgetConfig` 对象，创建一个 Widget 对象。

## API 参考

### AgoraBaseWidget

