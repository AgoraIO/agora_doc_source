##启用和禁用白板
灵活课堂中的白板模块是基于AgoraWidget实现的。 您可以通过将widget状态设置为活动或非活动来在教室中打开或关闭白板模块。

禁用白板模块后，铅笔、文本框、形状和橡皮擦等绘图工具将不再可用。 用户也不能在白板上显示类文件。 上传或删除课程文件、弹出式测验、倒计时和屏幕共享等其他功能不会受到影响。

###禁用白板
您需要监控教师客户端引起的白板widget状态变化，并相应地调整UI。 下面以一个iOS项目为例。 一般来说，你需要编辑 SDKs/AgoraEduUI/Classes/Components/FlatComponents/AgoraBoardUIComponent.swift 文件。

1.根据 CloudClass-Android 存储库中的最新发布分支创建一个新分支。
2.在AgoraBoardUIComponent.swift文件中添加一个函数，用于销毁AgoraBoardUIController中的board widget，如下：
```
private extension AgoraBoardUIController {
    ...
    func deinitBoardWidget() {
    self.boardWidget?.view.removeFromSuperview()
    self.boardWidget = nil
    contextPool.widget.remove(self,
                              widgetId: netlessKey)
    }
    ...
}
```


3.在 AgoraBoardUIController.swift 的 init 函数中添加 contextPool.widget.add(self) 来注册一个观察者，用于观察白板状态变化。
```
init(context: AgoraEduContextPool) {
    super.init(nibName: nil, bundle: nil)
    contextPool = context
    view.backgroundColor = .clear
 
    contextPool.room.registerRoomEventHandler(self)
    contextPool.media.registerMediaEventHandler(self)
    // Monitor the state change of the whiteboard widget.
    contextPool.widget.add(self)
}
```

4.当白板控件状态发生变化时，SDK会触发onWidgetActive或onWidgetInactive回调。 在 onWidgetActive 和 onWidgetInactive 回调中添加逻辑。 当白板状态变为active时，渲染白板； 当白板状态变为inactive时，调用deinitBoardWidget销毁白板widget。
```
extension AgoraBoardUIController: AgoraWidgetActivityObserver {
    func onWidgetActive(_ widgetId: String) {
        guard widgetId == netlessKey else {
            return
        }
 
        initBoardWidget()
        joinBoard()
    }
 
    func onWidgetInactive(_ widgetId: String) {
        guard widgetId == netlessKey else {
            return
        }
 
        deinitBoardWidget()
    }
}
```
##参考

AgoraWidgetContext
1.create
```
AgoraBaseWidget create(AgoraWidgetConfig config)
```

创建一个Widget对象.

参数:

- config: Widget对象的初始化配置.

返回: An AgoraBaseWidget object.

2.setWidgetActive
```
void setWidgetActive(String widgetId,
                     String ownerUuid,
                     Map<String: Any> roomProperties,
                     AgoraWidgetFrame syncFrame,
                     Callback<Void> success,
                     Callback<Error> failure)
                    
```
将widget设置为active


参数:
- widgetId：widget ID。
- ownerUuid：（可为空）widget所属用户的 ID。 当用户下线时，会触发该用户拥有的widget的onWidgetInactive回调。
- roomProperties：（可为空）与widget相关的房间属性。
- syncFrame：（可为空）widget的大小和位置。
- success：方法调用成功。
- failure：方法调用失败，SDK返回错误。

3.setWidgetInactive
```
void setWidgetInactive(String widgetId,
                       Callback<Void> success,
                       Callback<Error> failure)

```
将widget设置为inactive.

参数:

- widgetId：widget ID。
- roomProperties：（可为空）与widget相关的房间属性。
- success：方法调用成功。
- failure：方法调用失败，SDK返回错误。

4.getWidgetConfigs
```
Array<AgoraWidgetConfig> getWidgetConfigs()
```

获取指定widget的状态

参数:

- widgetId：widget ID。
返回：widget是否处于活动状态。

5.getWidgetConfig
```
AgoraWidgetConfig getWidgetConfig(String widgetId)
```

获取所有widget的配置。

返回：一组 AgoraWidgetConfig 对象。

6.getWidgetActivity
```
Bool getWidgetActivity(String widgetId)
```

Gets the state of a specified widget.

参数:

- widgetId: The widget ID.

返回: Whether the widget is active or not.


7.addWidgetActiveObserver
```
AgoraWidgetError addWidgetActiveObserver(AgoraWidgetActiveObserver observer,
                                         String widgetId)

```
注册一个观察者来观察指定widget的状态。 当widget的状态发生变化时，SDK 会触发回调。.

参数:

- observer: 参见 AgoraWidgetActiveObserver.
- widgetId: The widget ID.
返回: 当widget ID不合法时，SDK返回错误.

8.removeWidgetActiveObserver
```
AgoraWidgetError removeWidgetActiveObserver(AgoraWidgetActiveObserver observer,
                                            String widgetId)

```
注册指定widget的观察者。.

参数:

- observer: 参见 AgoraWidgetActiveObserver.
- widgetId: The widget ID.

返回: 当widget ID不合法时，SDK返回错误.

###AgoraWidgetActiveObserver
1.onWidgetActive
```
void onWidgetActive(String widgetId)
```

当widget状态更改为活动时发生。

参数:

- widgetId: The widget ID.

2.onWidgetInactive
```
void onWidgetInactive(String widgetId)
```

当widget状态更改为非活动时发生。.

参数:
- widgetId: The widget ID.
