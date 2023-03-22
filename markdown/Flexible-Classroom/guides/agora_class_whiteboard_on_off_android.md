### 白板组件
- 白板Widget的容器是：AgoraEduWhiteBoardComponent
- 白板Widget：AgoraEduWhiteBoardComponent
- 白板Widget ID:AgoraWidgetDefaultId.WhiteBoard.id

通过 AgoraEduWhiteBoardComponent容器监听事件是否创建白板，还是销毁白板组件AgoraWhiteBoardWidget。如果自定义布局，可以直接使用AgoraEduWhiteBoardComponent组件，来控制白板。

### 白板创建和销毁
在 AgoraEduWhiteBoardComponent 的initView中，注册监听创建或销毁白板组件。

注册：
```
eduContext?.widgetContext()?.addWidgetActiveObserver(widgetActiveObserver, AgoraWidgetDefaultId.LargeWindow.id)
```

监听：
```
private val widgetActiveObserver = object : AgoraWidgetActiveObserver {
        override fun onWidgetActive(widgetId: String) {
            if (widgetId == AgoraWidgetDefaultId.WhiteBoard.id) {
                 //create whiteborad widget（child thread）
            }
        }
 
        override fun onWidgetInActive(widgetId: String) {
            if (widgetId == AgoraWidgetDefaultId.WhiteBoard.id) {
                //release whiteborad widget（child thread）
            }
        }
}
```

### 开启白板
```
val info = AgoraWidgetRoomPropsUpdateReq(state = 1)
eduContext?.widgetContext()?.setWidgetActive(AgoraWidgetDefaultId.WhiteBoard.id, info)
```

### 关闭白板
```
eduContext?.widgetContext()?.setWidgetInActive(AgoraWidgetDefaultId.WhiteBoard.id)
```