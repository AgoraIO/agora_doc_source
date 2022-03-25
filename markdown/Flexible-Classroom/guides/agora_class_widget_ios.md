## 概览

Widget 是包含界面与功能的独立组件。开发者可基于 AgoraBaseWidget 自定义实现一个 Widget，然后在 Agora Classroom SDK 内注册该 Widget。Agora Classroom SDK 支持注册多个 Widget。 Widget 与 Widget 之间，以及 Widget 与 UI 层的其他组件都能进行通讯。

## 操作步骤

本节介绍通过 Widget 实现自定义组件并在灵动课堂内嵌入该组件的基本步骤。

### 开发 Widget

#### Desktop

引用 `agora-edu-core` 库，然后继承 `IAgoraWidget` 类开发一个 Widget。`IAgoraWidget` 类提供以下属性和方法：

```javascript
export interface IAgoraWidget {
  /**
   * Widget ID。
   */
  widgetId: string;
  /**
   * Widget 挂载时触发。
   *
   * @param dom 挂载的 DOM。
   * @param widgetProps Widget 属性。
   * @param sendMsg Widget 向教室发送消息。
   * @param onReceivedMsg Widget 接收教室的消息。
   */
  widgetDidLoad(dom: Element, widgetProps: any, sendMsg?: any, onReceivedMsg?: any): void;
  /**
   * Widget 卸载时触发。
   */
  widgetWillUnload(): void;
}
```

#### Android/iOS

引用 `AgoraWidget` 库，然后继承 `AgoraBaseWidget` 基类开发一个 Widget。

### 注册 Widget

#### Desktop

通过 `LaunchOption` 中的 `widgets` 参数里插入想要注册的 Widget 对象，调用 `AgoraEduSDK.launch` 方法时，会将该 Widget 注册进 SDK。

#### Android/iOS

通过 `AgoraEduLaunchConfig` 中的 `widgets` 里插入想要注册的 Widget 所对应的 `AgoraWidgetConfig` 对象，调用 `AgoraClassroomSDK` 的 `launch` 方法时，会将该 Widget 注册进 SDK。

### 设置 Widget 的状态（活跃或非活跃）

灵动课堂中的白板模块是通过 Widget 实现的，所以你可以通过设置 Widget 的状态来实现房间内打开或关闭白板。

#### Desktop


#### Android/iOS

本地可通过 `AgoraWidgetContext` 的 `setWidgetActive` 和 `setWidgetInactive` 方法设置 Widget 的状态（活跃或非活跃）。本地 Widget 的状态会同步至远端。远端可通过 `AgoraWidgetContext.addWidgetActiveObserver` 监听指定 Widget 的状态。



