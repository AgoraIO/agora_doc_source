## 概览

由于客户对在线课堂场景存在多种多样、定制化的需求，Agora 提供 Widget 帮助用户根据自身的需求开发插件并内嵌至灵动课堂内。

Widget 是包含界面与功能的独立插件。开发者可基于 `AgoraBaseWidget` 自定义实现一个 Widget，然后在 Agora Classroom SDK 内注册该 Widget。Agora Classroom SDK 支持注册多个 Widget。 Widget 与 Widget 之间，以及 Widget 与 UI 层的其他插件都能进行通讯。

<div class="alert info">Agora 提供了以下基于 Widget 实现的插件：倒计时、投票器和答题器等。你可在 <a href="https://github.com/AgoraIO-Community/apaas-extapp-ios">apaas-extapp-ios</a> 仓库中查看这些插件的源码。</div>

## 操作步骤

本节以倒计时插件为例，介绍通过 Widget 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

<div class="alert info">可在 <a href="https://github.com/AgoraIO-Community/apaas-extapp-ios">apaas-extapp-ios</a> 仓库中 <code>/AgoraWidgets/CountdownTimer</code> 文件夹查看倒计时插件的完整代码。</div>

### 1. 实现 Widget

参考以下步骤实现自定义 Widget:

1. 在 AgoraCountdownTimerWidget 中引入 `AgoraWidget` 库：

   ```swift
   import AgoraWidget
   ```

2. 在 `onWidgetDidLoad` 方法中初始化 Widget 的界面与数据：

   ```swift
   public override func onWidgetDidLoad() {
       super.onWidgetDidLoad()
       initViews()
       initConstraints()
       updateRoomData()
       updateViewData()
       updateViewFrame()
        
       log(content: info.roomProperties?.jsonString() ?? "nil",
           extra: nil,
           type: .info)
   }
   ```

3. 监听 `onWidgetRoomPropertiesUpdated` 与 `onMessageReceived` 方法，进行数据更新：

   ```swift
   public override func onWidgetRoomPropertiesUpdated(_ properties: [String : Any],
                                                      cause: [String : Any]?,
                                                      keyPaths: [String]) {
       super.onWidgetRoomPropertiesUpdated(properties,
                                           cause: cause,
                                           keyPaths: keyPaths)
       updateRoomData()
       updateViewData()
       shouldStartTime()
        
       log(content: properties.jsonString() ?? "nil",
           extra: cause?.jsonString(),
           type: .info)
   }
    
   public override func onMessageReceived(_ message: String) {
       super.onMessageReceived(message)
        
       if let timestamp = message.toSyncTimestamp() {
           objectCreateTimestamp = timestamp
           initCurrentTimestamp()
           shouldStartTime()
       }
        
       log(content: message,
           type: .info)
   }
   ```

4. 如果需要改动 Widget 尺寸，则通过 `sendMessage` 向外发出一条消息，由外部监听消息的父容器来更新 Widget 的尺寸：

   ```swift
   func updateViewFrame() {
       let size = ["width": countdownView.neededSize.width,
                   "height": countdownView.neededSize.height]
        
       guard let message = ["size": size].jsonString() else {
           return
       }
        
       sendMessage(message)
   }
   ```

### 2. 在 Agora Classroom SDK 中注册 Widget

在 `AgoraEduLaunchConfig.widgets` 中加入倒计时的 `AgoraWidgetConfig`，在调用 `launch` 时将实现好的插件注册到 Agora Classroom SDK 中：

```swift
   let launchConfig = AgoraEduLaunchConfig(userName: userName,          
                                           userUuid: userUuid,          
                                           userRole: userRole,          
                                           roomName: roomName,          
                                           roomUuid: roomUuid,          
                                           roomType: roomType,          
                                           appId: appId,                
                                           token: token,                
                                           startTime: nil,              
                                           duration: nil,               
                                           region: region,              
                                           mediaOptions: mediaOptions,  
                                           userProperties: nil)         
 
let widgetId = "countdownTimer"
 
launchConfig.widgets[widgetId] = AgoraWidgetConfig(with: AgoraCountdownTimerWidget.self,
                                                   widgetId: widgetId)
 
AgoraClassroomSDK.launch(launchConfig,
                         success: successBlock,
                         failure: failureBlock)
```

### 3. 在教室中使用 Widget

参考以下步骤实现在教室中使用倒计时插件的相关逻辑：

1. 通过 `AgoraEduContext.widget` 的 `addWidgetActivityObserver` 方法将` AgoraClassToolsViewController` 添加为 widget activity 的观察者，监听 activity 的回调：

   ```swift
   override func viewDidLoad() {
       super.viewDidLoad()
       contextPool.room.registerRoomEventHandler(self)
       contextPool.widget.add(self)
   }
   ```

2. 监听 activity 的回调：

   ```swift
   extension AgoraClassToolsViewController: AgoraWidgetActivityObserver {
       // 收到 onWidgetActive 回调时，创建 Widget
       func onWidgetActive(_ widgetId: String) {
           createWidget(widgetId)
       }
        
       // 收到 `onWidgetInactive` 回调时，销毁 Widget
       func onWidgetInactive(_ widgetId: String) {
           releaseWidget(widgetId)
       }
   }
   ```

3. 创建 AgoraCountdownTimer 的 Widget 对象并实现 Widget 在本地客户端的通讯：

   ```swift
   // 调用 createWidget 方法创建 AgoraCountdownTimer 的 Widget 对象
   func createWidget(_ widgetId: String) {
       let widgetController = contextPool.widget
        
       guard widgetIdList.contains(widgetId),
             // 调用 getWidgetConfig 获取 AgoraCountdownTimer 的 AgoraWidgetConfig
             let config = widgetController.getWidgetConfig(widgetId) else {
           return
       }
        
       if let _ = getWidget(widgetId) {
           return
       }
        
       // 通过 AgoraWidgetContext 的 addObserverForWidgetSyncFrame 将 AgoraClassToolsViewController 添加为 Widget syncFrame 的观察者，监听 syncFrame 的回调
       widgetController.addObserver(forWidgetSyncFrame: self,
                                    widgetId: widgetId)
       // 通过 AgoraWidgetContext 的  addWidgetMessageObserver 将 AgoraClassToolsViewController 添加为 widget message 的观察者，监听 message 的回调
       widgetController.add(self,
                            widgetId: widgetId)
        
       let widget = widgetController.create(config)
        
       view.addSubview(widget.view)
        
       switch widgetId {
       case PollWidgetId:
           pollWidget = widget
       case CountdownTimerWidgetId:
           countdownTimerWidget = widget
       case PopupQuizWidgetId:
           popupQuizWidget = widget
       default:
           return
       }
        
       sendWidgetCurrentTimestamp(widgetId)
   }
    
   func sendWidgetCurrentTimestamp(_ widgetId: String) {
       let syncTimestamp = contextPool.monitor.getSyncTimestamp()
       let tsDic = ["syncTimestamp": syncTimestamp]
        
       if let string = tsDic.jsonString() {
           // 调用 sendMessage 方法，将当前时间戳发给 Widget 
           contextPool.widget.sendMessage(toWidget: widgetId,
                                          message: string)
       }
   }
   ```

4. 监听 `syncFrame` 的回调方法：

   ```swift
   extension AgoraClassToolsViewController: AgoraWidgetSyncFrameObserver {
       // 当 syncFrame 更新时，更新 Widget 的位置与尺寸
       func onWidgetSyncFrameUpdated(_ syncFrame: CGRect,
                                     widgetId: String,
                                     operatorUser: AgoraWidgetUserInfo?) {
           let size = getWidgetSize(widgetId)
           updateWidgetFrame(widgetId,
                             size: size)
       }
   }
   ```

5. 监听 message 的回调方法：

   ```swift
   extension AgoraClassToolsViewController: AgoraWidgetMessageObserver {
       // 当收到 message 回调时，AgoraClassToolsViewController 作为父容器来更新 Widget 的尺寸
       func onMessageReceived(_ message: String,
                              widgetId: String) {
           if let size = parseSizeMessage(widgetId: widgetId,
                                          message: message) {
               updateWidgetFrame(widgetId,
                                 size: size)
           }
       }
   }
   ```

## API 参考

### AgoraBaseWidget

`AgoraBaseWidget` 是 Widget 的基类，实现具体功能的 Widget 需要继承该类。

#### 成员

| 名称   | 类型              | 描述                                               |
| :----- | :---------------- | :------------------------------------------------- |
| `info` | `AgoraWidgetInfo` | Widget 所需的基础信息 |
| `view` | View              | Widget 的容器 view                                 |

#### updateWidgetRoomProperties

```objc
- (void)updateWidgetRoomProperties:(NSDictionary<NSString *, id> *)properties
                             cause:(NSDictionary<NSString *, id> * _Nullable)cause
                           success:(AgoraWidgetCompletion _Nullable)success
                           failure:(AgoraWidgetErrorCompletion _Nullable)failure
```

更新 Widget 的房间属性。更新的房间属性会通过 `onWidgetRoomPropertiesUpdated` 回调传给 Widget。

**参数**

| 名称         | 类型               | 描述                                                      |
| :----------- | :----------------- | :-------------------------------------------------------- |
| `properties` | `NSDictionary<NSString *, id>` | 需要更新的 properties，支持 keyPath，只需要传入待更新的值 |
| `cause`      | `NSDictionary<NSString *, id>` | 更新的原因，可以为空                                      |
| `success`    | `AgoraWidgetCompletion`   | 请求成功                                                  |
| `failure`    | `AgoraWidgetErrorCompletion`  | 请求失败，返回一个 error                                  |

#### deleteWidgetRoomProperties

```objc
- (void)deleteWidgetRoomProperties:(NSArray<NSString *> *)keyPaths
                             cause:(NSDictionary<NSString *, id> * _Nullable)cause
                           success:(AgoraWidgetCompletion _Nullable)success
                           failure:(AgoraWidgetErrorCompletion _Nullable)failure
```

删除 Widget 的房间属性。删除的房间属性会通过 `onWidgetRoomPropertiesDeleted` 回调传给 Widget。

**参数**

| 名称      | 类型               | 描述                                            |
| :-------- | :----------------- | :---------------------------------------------- |
| `keyPaths`    | `NSArray<NSString *>`    | 需要删除的 properties 的 key 数组，支持 keyPath |
| `cause`   | `NSDictionary<NSString *, id>` | 更新的原因，可以为空                            |
| `success` | `AgoraWidgetCompletion`   | 请求成功                                        |
| `failure` | `AgoraWidgetErrorCompletion`  | 请求失败，返回一个 error                        |

#### updateWidgetUserProperties

```objc
- (void)updateWidgetUserProperties:(NSDictionary<NSString *, id> *)properties
                             cause:(NSDictionary<NSString *, id> * _Nullable)cause
                           success:(AgoraWidgetCompletion _Nullable)success
                           failure:(AgoraWidgetErrorCompletion _Nullable)failure
```

更新 Widget 的用户属性。更新的房间属性会通过 `onWidgetUserPropertiesUpdated` 回调传给 Widget。

**参数**

| 名称         | 类型               | 描述                                                      |
| :----------- | :----------------- | :-------------------------------------------------------- |
| `properties` | `NSDictionary<NSString *, id>` | 需要更新的 properties，支持 keyPath，只需要传入待更新的值 |
| `cause`      | `NSDictionary<NSString *, id>` | 更新的原因，可以为空                                      |
| `success`    | `AgoraWidgetCompletion `   | 请求成功                                                  |
| `failure`    | `AgoraWidgetErrorCompletion `  | 请求失败，返回一个 error                                  |

#### deleteWidgetUserProperties

```objc
- (void)deleteWidgetUserProperties:(NSArray<NSString *> *)keyPaths
                             cause:(NSDictionary<NSString *, id> * _Nullable)cause
                           success:(AgoraWidgetCompletion _Nullable)success
                           failure:(AgoraWidgetErrorCompletion _Nullable)failure
```

删除 Widget 的用户属性。删除的房间属性会通过 `onWidgetUserPropertiesDeleted` 回调传给 Widget。

**参数**

| 名称      | 类型               | 描述                                            |
| :-------- | :----------------- | :---------------------------------------------- |
| `keyPaths`    | `NSArray<NSString *>`    | 需要删除的 properties 的 key 数组，支持 keyPath |
| `cause`   | `NSDictionary<NSString *, id>` | 更新的原因，可以为空                            |
| `success` | `AgoraWidgetCompletion`   | 请求成功                                        |
| `failure` | `AgoraWidgetErrorCompletion`  | 请求失败，返回一个 error                        |

#### sendMessage

```objc
- (void)sendMessage:(NSString *)message
```

发送消息给观察者。

**参数**

| 名称      | 类型     | 描述     |
| :-------- | :------- | :------- |
| `message` | `NSString ` | 消息内容 |

#### onLoad

```objc
- (void)onLoad
```

Widget 加载完成。

#### onMessageReceived

```objc
- (void)onMessageReceived:(NSString *)message
```

Widget 收到消息。

调用 WidgetContext 协议中的 `sendMessageToWidget` 后会触发此回调。

**参数**

| 名称      | 类型     | 描述     |
| :-------- | :------- | :------- |
| `message` | `NSString` | 消息内容 |

#### onLocalUserInfoUpdated

```objc
- (void)onLocalUserInfoUpdated:(AgoraWidgetUserInfo *)localUserInfo
```

Widget 收到本地用户信息更新。

**参数**

| 名称            | 类型                  | 描述           |
| :-------------- | :-------------------- | :------------- |
| `localUserInfo` | `AgoraWidgetUserInfo` | 本地的用户信息 |

#### onRoomInfoUpdated

```objc
- (void)onRoomInfoUpdated:(AgoraWidgetRoomInfo *)roomInfo
```

Widget 收到房间信息更新。

**参数**

| 名称       | 类型                  | 描述     |
| :--------- | :-------------------- | :------- |
| `roomInfo` | `AgoraWidgetRoomInfo` | 房间信息 |

#### onWidgetRoomPropertiesUpdated

```objc
- (void)onWidgetRoomPropertiesUpdated:(NSDictionary<NSString *,id> *)properties
                                cause:(NSDictionary<NSString *,id> * _Nullable)cause
                             keyPaths:(NSArray<NSString *> *)keyPaths
                         operatorUser:(AgoraWidgetUserInfo *_Nullable)operatorUser
```

Widget 收到房间属性更新。

**参数**

| 名称         | 类型               | 描述                      |
| :----------- | :----------------- | :------------------------ |
| `properties`   | `NSDictionary<NSString *,id>` | 最终完整的属性            |
| `cause`        | `Map<String: Any>` | 原因，可以为空            |
| `keyPaths`     | `NSArray<NSString *>`    | 发生改变的属性的 key 数组 |
| `operatorUser` | `AgoraWidgetUserInfo` | 操作者，可以为空            |

#### onWidgetRoomPropertiesDeleted

```objc
- (void)onWidgetRoomPropertiesDeleted:(NSDictionary<NSString *,id> * _Nullable)properties
                                cause:(NSDictionary<NSString *,id> * _Nullable)cause
                             keyPaths:(NSArray<NSString *> *)keyPaths
                         operatorUser:(AgoraWidgetUserInfo *_Nullable)operatorUser
```

Widget 收到房间属性删除。

**参数**

| 名称         | 类型               | 描述                  |
| :----------- | :----------------- | :-------------------- |
| `properties`   | `NSDictionary<NSString *,id>` | 最终完整的属性            |
| `cause`        | `Map<String: Any>` | 原因，可以为空            |
| `keyPaths`     | `NSArray<NSString *>`    | 发生改变的属性的 key 数组 |
| `operatorUser` | `AgoraWidgetUserInfo` | 操作者，可以为空            |


#### onWidgetUserPropertiesUpdated

```objc
- (void)onWidgetUserPropertiesUpdated:(NSDictionary<NSString *,id> *)properties
                                cause:(NSDictionary<NSString *,id> * _Nullable)cause
                             keyPaths:(NSArray<NSString *> *)keyPaths
                         operatorUser:(AgoraWidgetUserInfo *_Nullable)operatorUser
```

Widget 收到用户属性更新。

**参数**

| 名称         | 类型               | 描述                  |
| :----------- | :----------------- | :-------------------- |
| `properties`   | `NSDictionary<NSString *,id>` | 最终完整的属性            |
| `cause`        | `Map<String: Any>` | 原因，可以为空            |
| `keyPaths`     | `NSArray<NSString *>`    | 发生改变的属性的 key 数组 |
| `operatorUser` | `AgoraWidgetUserInfo` | 操作者，可以为空            |

#### onWidgetUserPropertiesDeleted

```objc
- (void)onWidgetUserPropertiesDeleted:(NSDictionary<NSString *,id> * _Nullable)properties
                                cause:(NSDictionary<NSString *,id> * _Nullable)cause
                             keyPaths:(NSArray<NSString *> *)keyPaths
                         operatorUser:(AgoraWidgetUserInfo *_Nullable)operatorUser;                                   
```

Widget 收到用户属性删除。

**参数**

| 名称         | 类型               | 描述                  |
| :----------- | :----------------- | :-------------------- |
| `properties`   | `NSDictionary<NSString *,id>` | 最终完整的属性            |
| `cause`        | `Map<String: Any>` | 原因，可以为空            |
| `keyPaths`     | `NSArray<NSString *>`    | 发生改变的属性的 key 数组 |
| `operatorUser` | `AgoraWidgetUserInfo` | 操作者，可以为空            |