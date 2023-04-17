灵活课堂中的白板模块是基于 `AgoraWidget` 实现的。你可以通过将 widget 状态设置为活跃（active）或非活跃（inactive）来在教室中打开或关闭白板模块。

关闭白板模块后，铅笔、文本框、形状和橡皮擦等绘图工具将不再可用，用户也不能在白板上显示课件，上传或删除课程文件。弹出式测验、倒计时和屏幕共享等其他不依赖白板的功能不会受到影响。

白板 widget 对应的容器（即组件）是 `AgoraEduWhiteBoardComponent`，widget ID 可通过 `AgoraWidgetDefaultId.WhiteBoard.id` 获取。使用该组件可以达到开启和关闭白板的目的。

实现开启或关闭白板的过程中，你需要监控教师客户端引起的白板状态变化，并相应地调整 UI。 你可以在 `AgoraEduUIKit/src/main/java/com/agora/edu/component/whiteboard/AgoraEduWhiteBoardComponent.kt` 文件中的 `initView()` 方法里看到注册观察者和监听活跃状态，创建或销毁白板组件的逻辑。

如果你想要自己实现开启和关闭白板，可参考以下代码：

- 开启白板：

    ```kotlin
    // 在开启白板的按钮所在的文件中添加以下代码：
    val info = AgoraWidgetRoomPropsUpdateReq(state = 1)
    eduContext?.widgetContext()?.setWidgetActive(AgoraWidgetDefaultId.WhiteBoard.id, info)
    ```

- 关闭白板：

    ```kotlin
    // 在开启白板的按钮所在的文件中添加以下代码：
    eduContext?.widgetContext()?.setWidgetInActive(AgoraWidgetDefaultId.WhiteBoard.id)
    ```

- 注册观察者：

    ```kotlin
    eduContext?.widgetContext()?.addWidgetActiveObserver(widgetActiveObserver, AgoraWidgetDefaultId.LargeWindow.id)
    ```


- 监听状态：

    ```kotlin
    private val widgetActiveObserver = object : AgoraWidgetActiveObserver {
            override fun onWidgetActive(widgetId: String) {
                // 白板已经创建，这里是子线程
                if (widgetId == AgoraWidgetDefaultId.WhiteBoard.id) {

                }
            }
    
            override fun onWidgetInActive(widgetId: String) {
                // 白板已经移除，这里是子线程
                if (widgetId == AgoraWidgetDefaultId.WhiteBoard.id) {
                
                }
            }
    }
    ```

