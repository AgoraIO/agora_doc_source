灵活课堂中的白板模块是基于 `AgoraWidget` 实现的。你可以通过将 widget 状态设置为活跃（active）或非活跃（inactive）来在教室中打开或关闭白板模块。

禁用白板模块后，铅笔、文本框、形状和橡皮擦等绘图工具将不再可用，用户也不能在白板上显示类文件。 上传或删除课程文件、弹出式测验、倒计时和屏幕共享等其他不依赖白板的功能不会受到影响。//TODO 什么是类文件

白板 widget 对应的容器（组件）是 `AgoraEduWhiteBoardComponent`，widget ID 可通过 `AgoraWidgetDefaultId.WhiteBoard.id` 获取。使用该组件可以达到启用和禁用白板的目的。

## 启用和禁用白板

实现启用或禁用白板的过程中，你需要监控教师客户端引起的白板状态变化，并相应地调整 UI。 你可以参考下面这个 web 端示例项目。

在 `AgoraEduUIKit/src/main/java/com/agora/edu/component/whiteboard/AgoraEduWhiteBoardComponent.kt` 文件中，在 `initView()` 方法里，注册观察者和监听活跃状态，创建或销毁白板组件。这里是我们写好的

下面是自己实现

注册观察者：//TODO 改下顺序

```kotlin
eduContext?.widgetContext()?.addWidgetActiveObserver(widgetActiveObserver, AgoraWidgetDefaultId.LargeWindow.id)
```

// TODO 难道不是下面这个额
eduContext?.widgetContext()?.addWidgetActiveObserver(widgetActiveObserver, AgoraWidgetDefaultId.WhiteBoard.id)

监听状态：

```kotlin
private val widgetActiveObserver = object : AgoraWidgetActiveObserver {
        override fun onWidgetActive(widgetId: String) {
             // 已经创建好了，这里是子线程
            if (widgetId == AgoraWidgetDefaultId.WhiteBoard.id) {

            }
        }
 
        override fun onWidgetInActive(widgetId: String) {
             // 已经移除好了，这里是子线程
            if (widgetId == AgoraWidgetDefaultId.WhiteBoard.id) {
               
            }
        }
}
```

### 开启白板
//TODO state = 1 的含义也不清楚，AgoraWidgetRoomPropsUpdateReq 也没介绍。看下 API 参考
//开启关闭按钮所在的文件
```
val info = AgoraWidgetRoomPropsUpdateReq(state = 1)
eduContext?.widgetContext()?.setWidgetActive(AgoraWidgetDefaultId.WhiteBoard.id, info)
```

### 关闭白板

//TODO 没在白板 component 文件中找到这个接口
```
eduContext?.widgetContext()?.setWidgetInActive(AgoraWidgetDefaultId.WhiteBoard.id)
```