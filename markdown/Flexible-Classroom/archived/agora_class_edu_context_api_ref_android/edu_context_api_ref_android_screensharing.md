## ScreenShareContext

`ScreenShareContext` 类提供可供 App 调用的屏幕共享相关方法。

### setScreenShareState

```kotlin
abstract fun setScreenShareState(sharing: Boolean)
```

开启或关闭屏幕共享。

| 参数      | 描述               |
| :-------- | :----------------- |
| `sharing` | 是否开启屏幕共享。 |

### renderScreenShare

```kotlin
abstract fun renderScreenShare(container: ViewGroup?, streamUuid: String)
```

开始或停止渲染屏幕共享流。

| 参数         | 描述                                                   |
| :----------- | :----------------------------------------------------- |
| `container`  | 视频 Container。`viewGroup` 为 `null` 代表关闭流渲染。 |
| `streamUuid` | 流 ID。                                                |

## IScreenShareHandler

`IScreenShareHandler` 类用于向 App 报告屏幕共享相关的事件回调。

### onScreenShareStateUpdated

```kotlin
fun onScreenShareStateUpdated(state: EduContextScreenShareState, streamUuid: String)
```

屏幕共享状态发生改变。

| 参数         | 描述                                                                                                                                                |
| :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `state`      | 屏幕共享状态，详见 [EduContextScreenShareState](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextscreensharestate)。 |
| `streamUuid` | 流 ID。                                                                                                                                             |

### onScreenShareTip

```kotlin
fun onScreenShareTip(tips: String)
```

显示屏幕共享相关提示。

有以下提示：

-   XXX 开启了屏幕分享。
-   XXX 关闭了屏幕分享。

| 参数   | 描述       |
| :----- | :--------- |
| `tips` | 提示信息。 |
