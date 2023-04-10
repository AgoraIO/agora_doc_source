灵活课堂中的白板模块是基于 `AgoraWidget` 实现的。你可以通过将 widget 状态设置为活跃（active）或非活跃（inactive）来在教室中打开或关闭白板模块。

禁用白板模块后，铅笔、文本框、形状和橡皮擦等绘图工具将不再可用，用户也不能在白板上显示课件，上传或删除课程文件。弹出式测验、倒计时和屏幕共享等其他不依赖白板的功能不会受到影响。//TODO 确认下

### 启用和禁用白板

实现启用或禁用白板的过程中，你需要监控教师客户端引起的白板状态变化，并相应地调整 UI。 你可以参考下面这个 iOS 端示例项目。

1. 获取源码 ext 和 cloudclass

2. 在 `SDKs/AgoraEduUI/Classes/Components/Flat/AgoraBoardUIComponent.swift` 文件中添加一个函数，用于销毁 `AgoraBoardUIController` 中的 board widget，即禁用白板。参考以下示例代码： //TODO 改成 Fcrxxx 而不是 Agoraxxx。下面代码要加在哪个位置？...的部分是还需要用户自己补充吗？已经在代码里了

    ```swift
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


3. 在 `AgoraBoardUIController.swift` 的 `init` 函数中添加 `contextPool.widget.add(self)` 来注册一个观察者，用于观察白板状态变化，参考以下示例代码。//TODO 找不到这个文件

    ```swift
    init(context: AgoraEduContextPool) {
        super.init(nibName: nil, bundle: nil)
        contextPool = context
        view.backgroundColor = .clear
    
        contextPool.room.registerRoomEventHandler(self)
        contextPool.media.registerMediaEventHandler(self)
        // 添加以下这行代码观察白板状态变化

        contextPool.widget.add(self)
    }
    ```

4. 当白板控件状态发生变化时，SDK 会触发 `onWidgetActive` 或 `onWidgetInactive` 回调，因此你可以在 `onWidgetActive` 和 `onWidgetInactive` 回调中添加逻辑：当白板状态变为活跃时，渲染白板；当白板状态变为非活跃时，调用步骤 2 中定义的 `deinitBoardWidget` 函数禁用白板。

    ```swift
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

## API 参考
//TODO 等待孙亮提供 3 端 API 参考

### AgoraWidgetContext

#### create

```swift
AgoraBaseWidget create(AgoraWidgetConfig config)
```

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `config` | Widget 对象的初始化配置，详见 [`AgoraWidgetConfig`](#agorawidgetconfig)。 |//TODO 找不到这个类的信息

创建一个 widget 对象.

**返回值**

一个 `AgoraBaseWidget` 对象。

#### setWidgetActive

```swift
void setWidgetActive(String widgetId,
                     String ownerUuid,
                     Map<String: Any> roomProperties,
                     AgoraWidgetFrame syncFrame,
                     Callback<Void> success,
                     Callback<Error> failure)
```

把 widget 设置为活跃状态。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 
| `ownerUuid` | （非必填）String 型，widget 所属用户（如有）的 ID。当用户下线时，会触发该用户拥有的 widget （如有） 的 `onWidgetInactive` 回调。 | 
| `roomProperties` | （非必填）键为 String 类型，值为任意类型的 Map，与 widget 相关的房间属性。 | 
| `syncFrame` | （非必填）widget 的大小和位置，详见[`AgoraWidgetFrame`](#agorawidgetframe)。 | //TODO 找不到这个类的信息
| `success` | 方法调用成功回调。 | 
| `failure` | 方法调用失败回调，SDK 会返回错误。 | 

#### setWidgetInactive
```swift
void setWidgetInactive(String widgetId,
                       Callback<Void> success,
                       Callback<Error> failure)
```
把 widget 设置为非活跃状态。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 
| `success` | 方法调用成功回调。 | 
| `failure` | 方法调用失败回调，SDK 会返回错误。 | 

#### getWidgetConfig
```swift
AgoraWidgetConfig getWidgetConfig(String widgetId)
```

获取所有 widget 的配置。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 

**返回值**

`AgoraWidgetConfig` 对象的数组。

#### getWidgetActivity

```swift
Bool getWidgetActivity(String widgetId)
```

获取指定 widget 的状态。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 

**返回值**
//TODO 确认下
- `true`：活跃。
- `false`：非活跃。


#### addWidgetActiveObserver

```swift
AgoraWidgetError addWidgetActiveObserver(AgoraWidgetActiveObserver observer,
                                         String widgetId)
```
注册一个观察者来观察指定 widget 的状态。当 widget 的状态发生变化时，SDK 会触发回调 `onWidgetActive` 或 `onWidgetInactive`。.

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `observer` | 活跃状态观察者，详见 [`AgoraWidgetActiveObserver`](#agorawidgetactiveobserver)。 | 
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 

**返回值**
//TODO 不合法有哪些情况
Widget ID 不合法时，SDK 会返回错误。

#### removeWidgetActiveObserver

```swift
AgoraWidgetError removeWidgetActiveObserver(AgoraWidgetActiveObserver observer,
                                            String widgetId)
```

删除 widget 状态观察者。.

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `observer` | 活跃状态观察者，详见 [`AgoraWidgetActiveObserver`](#agorawidgetactiveobserver)。 | 
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 

**返回值**
//TODO 不合法有哪些情况
Widget ID 不合法时，SDK 会返回错误。

### AgoraWidgetActiveObserver
#### onWidgetActive

```swift
void onWidgetActive(String widgetId)
```

当 widget 状态改变为活跃时发生。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 

#### onWidgetInactive
```swift
void onWidgetInactive(String widgetId)
```

当 widget 状态改变为非活跃时发生。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `widgetId` | String 型，widget ID。//TODO 有无限制，长度，支持字符集之类的 | 
