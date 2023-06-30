本文介绍声网 Meta SDK 的 Objective API。

## 概述

Meta SDK 是基于声网视频 SDK 开发的元系列特殊版 SDK。相比[视频 SDK](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/rtc_api_overview_ng.html)，Meta SDK 中新增元系列相关的 API。

## AgoraMetaServiceKit

Meta SDK 所有接口的入口，可用于获取场景资源列表、下载场景资源、删除本地场景资源等场景资源管理，还可用于创建 `AgoraMetaScene`。

### sharedMetaServiceWithConfig


```objective-c
+ (instancetype _Nonnull)sharedMetaServiceWithConfig:(AgoraMetaServiceConfig* _Nonnull)config NS_SWIFT_NAME(sharedMetaServiceWithConfig(_:));
```

创建和初始化 `AgoraMetaServiceKit` 对象，并且登录声网 RTM 系统。


**参数**

`config`：初始化 `AgoraMetaServiceKit` 对象需要的配置信息，详见 [`AgoraMetaServiceConfig`](#agorametaserviceconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败


### destroy

```objective-c
+ (void)destroy NS_SWIFT_NAME(destroy());
```

销毁 `AgoraMetaServiceKit` 对象。

### renewToken

```objective-c
- (NSInteger)renewToken:(NSString *_Nonnull)token;
```

更新 Token。

Token 有有效期，在过期前 SDK 会触发 [`onTokenWillExpire`](#ontokenwillexpire) 回调报告 Token 即将过期。此时，你需要在服务器生成新的 Token，然后调用 `renewToken` 并在参数里传入新 Token。


### getSceneAssetsInfo

```objective-c
- (NSInteger)getSceneAssetsInfo;
```


获取场景列表。

调用该方法会触发 [`onGetSceneAssetsInfoResult`](#ongetsceneassetsinforesult) 回调。



**返回值**

- 0：方法调用成功
- < 0：方法调用失败


### isSceneAssetsDownloaded


```objective-c
- (NSInteger)isSceneAssetsDownloaded:(NSInteger)sceneId;
```

判断本地是否已经下载指定场景。

**参数**

`sceneId`：场景的 ID，可以从 [`AgoraMetaSceneInfo`](#agorametaceneinfo) 获取。

**返回值**

- 0：未下载到本地。

- 1：已下载到本地。

### downloadSceneAssets


```objective-c
- (NSInteger)downloadSceneAssets:(NSInteger)sceneId;
```

下载场景资源到本地。

调用该方法会触发 `AgoraMetaEventDelegate` 协议的 `onDownloadSceneAssetsProgress` 回调。

**参数**

`sceneId`：场景的 ID，可以从 [`AgoraMetaSceneInfo`](#agorametaceneinfo) 获取。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### cancelDownloadSceneAssets


```objective-c
- (NSInteger)cancelDownloadSceneAssets:(NSInteger)sceneId;
```

取消下载场景到本地。

调用该方法会触发 `AgoraMetaEventDelegate` 协议的 `onDownloadSceneAssetsProgress` 回调，其中 `state` 为 `3(Failed)`。

调用该方法后如果再次调用 `downloadSceneAssets`，会从上次取消下载时的进度恢复下载。

**参数**

`sceneId`：场景的 ID，可以从 [`AgoraMetaSceneInfo`](#agorametaceneinfo) 获取。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### cleanSceneAssets


```objective-c
- (NSInteger)cleanSceneAssets:(NSInteger)sceneId;
```

清理本地场景资源。

**参数**

`sceneId`：场景的 ID，可以从 [`AgoraMetaSceneInfo`](#agorametaceneinfo) 获取。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### createScene


```objective-c
- (NSInteger)createScene:(AgoraMetaSceneConfig *_Nonnull)config;
```

创建 `AgoraMetaScene` 对象。

调用该方法会触发 `AgoraMetaEventDelegate` 协议的 [`onCreateSceneResult`](#oncreatesceneresult) 回调。成功创建的 `AgoraMetaScene` 对象可以在该回调里拿到。

**注意**

- 如果你在创建场景时想开启面部捕捉，你可以通过 `config` 中的 `enableFaceCapture` 属性设置。
- 如果你在创建场景时不想开启面部捕捉，但是在后续流程中想开启面部捕捉，你可以调用 [`enableFaceCapture`](#enablefacecapture)。

**参数**

`config`：创建 `AgoraMetaScene` 对象需要的配置信息，详见 [`AgoraMetaSceneConfig`](#agorametasceneconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

## AgoraMetaScene

场景相关操作。

### destroy

销毁 `AgoraMetaScene` 对象。

```objective-c
- (NSInteger)destroy;
```

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### getLocalUserAvatar


```objective-c
- (AgoraMetaLocalUserAvatar *_Nullable)getLocalUserAvatar;
```

进入场景前，可以调用该方法获取用户的昵称、虚拟形象、装扮捏脸等信息。

**返回值**

`AgoraMetaLocalUserAvatar` 对象。

### createRenderView

```objective-c
- (UIView *_Nullable)createRenderView:(CGRect)frame;
```

创建场景渲染所需的视图。

**参数**

- `frame`：视图的位置和大小。

**返回值**

创建的视图对象。

### enterScene



```objective-c
- (NSInteger)enterScene:(AgoraMetaEnterSceneConfig *_Nonnull)config;
```

进入场景。

成功调用该方法会触发 `AgoraMetaSceneEventDelegate` 协议的 [`onEnterSceneResult`](onentersceneresult) 回调。

**参数**

`config`：进入场景所需要的配置信息，详见 [`AgoraMetaEnterSceneConfig`](#agorametaentersceneconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### leaveScene


```objective-c
- (NSInteger)leaveScene;
```
进入场景。

成功调用该方法会触发 `AgoraMetaSceneEventDelegate` 协议的 [`onLeaveSceneResult`](onleavesceneresult) 回调。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### sendSceneMessage

```objective-c
- (NSInteger)sendSceneMessage:(NSData *_Nonnull)message;
```
往场景发送自定义消息。

该方法适用于 app 需要和 Unity 通信的场景资源。Unity 收到自定义消息后可以进行自定义的逻辑处理。

**注意**

该方法必须在 `enterScene` 之后调用。

**参数**

`message`：自定义消息，目前只支持字符串。消息格式可以自定义。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败


### enableVideoDisplay


```objective-c
- (NSInteger)enableVideoDisplay:(NSString *_Nonnull)displayId enable:(BOOL)enable;
```

开启/关闭场景里的视频显示器。

**参数**

- `displayId`：指定显示器的 ID。该 ID 需要由你的 Native 开发人员和 Unity 开发人员协商后规定。
- `enable`：是否开启指定显示器：
  - `YES`：开启显示器，即开始视频渲染。
  - `NO`：关闭显示器，即关闭视频渲染。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### pushVideoFrameToDisplay


```objective-c
- (NSInteger)pushVideoFrameToDisplay:(NSString *_Nonnull)displayId frame:(AgoraVideoFrame *_Nullable)frame;
```
往场景里的视频显示器推送原始视频帧。

**参数**

- `displayId`：指定显示器的 ID。ID 需要由你的 Native 开发人员和 Unity 开发人员协商后规定。
- `frame`：视频帧。详见 RTC SDK API 参考中的 [`AgoraVideoFrame`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/rtc_api_data_type.html#class_externalvideoframe)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### addSceneView

```objective-c
- (NSInteger)addSceneView:(UIView *_Nonnull)view sceneDisplayConfig:(AgoraMetaSceneDisplayConfig *_Nullable)config;
```
添加场景显示视图。

调用该方法在场景中添加一个视图，用于在频道内发布主播的 Avatar 形象。调用成功后，SDK 会触发 `AgoraMetaSceneEventDelegate` 协议的 [`onAddSceneViewResult`](onaddsceneviewresult) 回调。

**参数**

- `view`：视频视图。
- `config`：场景显示相关配置参数，[`AgoraMetaSceneDisplayConfig`](#agorametascenedisplayconfig)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### removeSceneView
```objective-c
- (NSInteger)removeSceneView:(UIView *_Nonnull)view;
```

移除场景显示视图。

调用成功后，SDK 会触发 `AgoraMetaSceneEventDelegate` 协议的 [`onRemoveSceneViewResult`](onremovesceneviewresult) 回调。

**参数**

`view`：待移除的视图。


**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### enableFaceCapture

```objective-c
- (NSInteger)enableFaceCapture:(BOOL)enable;
```

开启或关闭面部捕捉。

**注意**

如果你在调用 [`createScene`](#createscene) 创建场景时不想开启面部捕捉，但是在后续流程中想开启面部捕捉，你可以调用本方法。

**参数**

`enable`：是否开启面部捕捉：
- `YES`：开启。
- `NO`：不开启。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### enableSceneVideoCapture

```objective-c
- (NSInteger)enableSceneVideoCapture:(UIView *_Nonnull)view enable:(BOOL)enable;
```

开启或关闭场景渲染画面捕获。

该方法用于开启或关闭场景渲染画面捕获。通过与 `AgoraRtcEngineKit` 的 [`joinChannelByToken` [1/2]](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_joinchannel) 方法配合使用，可以将场景渲染的画面发布到 RTC 频道中。

**参数**

- `view`：需要捕获的场景视图。
- `enable`：是否开启场景渲染画面捕获。
  - `YES`：开启。场景画面会发布到 RTC 频道中。
  - `NO`：（默认）不开启。场景画面不会发不到 RTC 频道中。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

## AgoraMetaLocalUserAvatar

包含在 `AgoraMetaScene` 中，生命周期和 `AgoraMetaScene` 相同。


### setUserInfo


```objective-c
- (NSInteger)setUserInfo:(AgoraMetaUserInfo *_Nullable)userInfo;
```

设置用户的基本信息。

**参数**

`userInfo`：在场景内展示的用户信息，详见 [`AgoraMetaUserInfo`](#agorametauserinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getUserInfo


```objective-c
- (AgoraMetaUserInfo *_Nullable)getUserInfo;
```
获取用户的基本信息。

**返回值**

[`AgoraMetaUserInfo`](#metauserinfo) 对象。

### setModelInfo


```objective-c
- (NSInteger)setModelInfo:(AgoraMetaAvatarModelInfo *_Nullable)modelInfo;
```

设置用户的模型信息。


**参数**

`modelInfo`：用户的虚拟形象模型信息，详见 [`AgoraMetaAvatarModelInfo`](#agorametaavatarmodelinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getModelInfo


```objective-c
- (AgoraMetaAvatarModelInfo *_Nullable)getModelInfo;
```

获取当前使用的用户模型信息。

**返回值**

[`AgoraMetaAvatarModelInfo`](#agorametaavatarmodelinfo) 对象。


### setExtraInfo


```objective-c
- (NSInteger)setExtraInfo:(NSData *_Nullable)customInfo;
```

设置自定义的用户信息。

你可以通过该方法设置用户的装扮信息、捏脸信息。

**参数**

`customInfo`：自定义的用户信息。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getExtraInfo


```objective-c
- (NSData *_Nullable)getExtraInfo;
```
获取自定义的用户信息。

**返回值**

当前使用的自定义的用户信息。

### applyInfo


```objective-c
- (NSInteger)applyInfo;
```

应用新设置的用户信息。

**注意**

- 如果你在进入场景资源前调用 `setUserInfo`、`setModelInfo`、`setExtraInfo`  方法，则不需要调用 `applyInfo`。
- 如果你在进入场景资源后调用了 `setUserInfo`、`setModelInfo`、`setExtraInfo` 方法，必须再调用 `applyInfo` 让设置的信息生效。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

## AgoraMetaEventDelegate

`AgoraMetaServiceKit` 接口的异步方法的事件回调协议。

### onCreateSceneResult

```objective-c
- (void)onCreateSceneResult:(AgoraMetaScene *_Nullable)scene errorCode:(NSInteger)errorCode;
```
`AgoraMetaScene` 创建回调。

**参数**

- `scene`：创建的 `AgoraMetaScene` 对象，用于后续进出场景等操作。
- `errorCode`：错误码：
  - 0 表示创建成功。
  - 其余情况表示创建失败。

### onConnectionStateChanged


```objective-c
- (void)onConnectionStateChanged:(AgoraMetaConnectionStateType)state reason:(AgoraMetaConnectionChangedReasonType)reason;
```

连接状态改变回调。

**参数**

- `state`：连接状态。
  - `1`：断开连接。
  - `2`：正在连接。
  - `3`：连接成功。
  - `4`：正在重连。
  - `5`：连接丢弃。

- `reason`：连接状态改变的原因。

### onTokenWillExpire


```objective-c
- (void)onTokenWillExpire;
```

Token 即将过期回调。

收到该回调后，你需要在服务器生成新的 Token，然后调用 [`renewToken`](#renewToken) 并在参数里传入新 Token。

### onGetSceneAssetsInfoResult



```objective-c
- (void)onGetSceneAssetsInfoResult:(NSMutableArray * _Nonnull)sceneInfos errorCode:(NSInteger)errorCode;
```

获取场景资源列表回调。

**参数**

- `metaSceneAssetsInfo`：场景资源信息列表，详见 [`AgoraMetaSceneInfo`](#agormetasceneinfo)。

- `errorCode`：错误码：
  - 0 表示获取列表成功。
  - 其余情况表示获取列表失败。

### onDownloadSceneAssetsProgress

```objective-c
- (void)onDownloadSceneAssetsProgress:(NSInteger)sceneId progress:(NSInteger)progress state:(AgoraMetaDownloadStateType)state;
```
下载场景资源进度回调。

**参数**

- `sceneId`：场景资源 ID。

- `progress`：下载进度，取值范围 [0,100]。

- `state`：下载状态：
  - `0`：空闲。
  - `1`：正在下载。
  - `2`：下载完成。
  - `3`：下载失败

## AgoraMetaSceneEventDelegate

`AgoraMetaScene` 接口的异步方法的事件回调协议。

### onEnterSceneResult


```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onEnterSceneResult:(NSInteger)errorCode;
```
进入场景的结果回调。


**参数**

`errorCode`：错误码：
- 0 表示进入场景成功。
- 其余情况进入场景失败。

### onLeaveSceneResult


```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onLeaveSceneResult:(NSInteger)errorCode;
```

离开场景的结果回调。


**参数**

`errorCode`：错误码：
- 0 表示离开场景成功。
- 其余情况离开场景失败。

### onSceneMessageReceived

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onSceneMessageReceived:(NSData * _Nonnull)message;
```

接收场景信息回调。

App 收到 Unity 场景发送的自定义信息时，SDK 会触发该回调。

**参数**

`message`：自定义格式的消息。目前只支持字符串。

### onUserPositionChanged


```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onUserPositionChanged:(NSString * _Nonnull)uid posInfo:(AgoraMetaPositionInfo * _Nonnull)posInfo;
```

本地或远端用户位置变化回调。

用户位置变化时，SDK 会触发该回调。

**参数**

- `uid`：本地或远端用户的用户 ID。
- `posInfo`：用户的位置信息，详见 [`AgoraMetaPositionInfo`](#agorametapositioninfo)。

### onReleasedScene


```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onReleasedScene:(NSInteger)errorCode;
```

`AgoraMetaScene` 释放回调。

**参数**

`status`：错误码：
- 0 表示释放 `AgoraMetaScene` 成功。
- 其余情况释放 `AgoraMetaScene` 失败。

### onAddSceneViewResult

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onAddSceneViewResult:(UIView * _Nonnull)view errorCode:(NSInteger)errorCode;
```


添加场景显示视图回调。

调用 `AgoraMetaScene` 类的 [`addSceneView`](#addsceneview) 方法添加场景显示视图后，SDK 会触发该回调。

**参数**

- `view`：视频视图。
- `errorCode`：错误码：
  - 0 表示添加视图成功。
  - 其余情况添加视图失败。


### onRemoveSceneViewResult

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onRemoveSceneViewResult:(UIView * _Nonnull)view errorCode:(NSInteger)errorCode;
```

移除场景显示视图回调。

调用 `AgoraMetaScene` 类的 [`removeSceneView`](#removesceneview) 方法移除场景显示视图后，SDK 会触发该回调。

**参数**

- `view`：视频视图。
- `errorCode`：错误码：
  - 0 表示移除视图成功。
  - 其余情况移除视图失败。


## 类型定义

### AgoraMetaServiceConfig

初始化 `AgoraMetaServiceKit` 的配置信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaServiceConfig : NSObject
@property (nonatomic, copy) NSString * _Nonnull appId;
@property (nonatomic, copy) NSString * _Nonnull rtmToken;
@property (nonatomic, copy) NSString * _Nonnull userId;
@property (nonatomic, weak) id<AgoraMetaEventDelegate> _Nullable delegate;
@property (nonatomic, copy) NSString * _Nonnull localDownloadPath;
@property (nonatomic, assign) AgoraRtcEngineKit* _Nullable rtcEngine;
@end
```


- `appId`：在声网控制台获取的 App ID。
- `rtmToken` ：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。
- `userId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `delegate`：回调事件，详见 [AgoraMetaEventDelegate](#agorametaeventdelegate)。
- `localDownloadPath` ：场景资源下载到本地的保存路径。
- `rtcEngine`：`AgoraRtcEngineKit` 实例，创建方法详见 [`sharedEngineWithConfig`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_initialize)。

### AgoraMetaUserInfo

用户信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaUserInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull userId;
@property (nonatomic, copy) NSString * _Nonnull userName;
@property (nonatomic, copy) NSString * _Nonnull userIconUrl;
@end
```

- `userId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。

- `userName`：用户昵称，用于在场景里显示用户昵称。

- `userIconUrl`：用户头像的 URL，用于在场景里显示用户头像。



### AgoraMetaSceneInfo

场景资源信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaSceneInfo : NSObject
@property (nonatomic, assign) NSInteger sceneId;
@property (nonatomic, copy) NSString * _Nonnull sceneName;
@property (nonatomic, copy) NSString * _Nonnull thumbnailPath;
@property (nonatomic, copy) NSString * _Nonnull scenePath;
@property (nonatomic, copy) NSString * _Nonnull parentScenePath;
@property (nonatomic, copy) NSString * _Nonnull desc;
@property (nonatomic, copy) NSString * _Nonnull sceneConfig;
@property (nonatomic, copy) NSString * _Nullable extraInfo;
@property (nonatomic, copy) NSString * _Nonnull sceneVersion;
@property (nonatomic, copy) NSString * _Nonnull sceneLocalVersion;
@property (nonatomic, assign) NSInteger totalSize;
@property (nonatomic, strong) NSArray<AgoraMetaBundleInfo *> * _Nonnull bundles;
@end
```

- `sceneId`：场景的唯一标识符。
- `sceneName`：场景名称。
- `thumbnailPath`：场景缩略图的本地路径。
- `scenePath`：场景资源的本地路径。
- `parentScenePath`：依赖的父场景资源的本地路径。
- `desc`：场景的描述文字。
- `sceneConfig`：场景的配置信息。
- `extraInfo`：其它额外信息。
- `bundles`：场景支持的资源包列表。
- `sceneVersion`：场景资源在服务器上的版本号。
- `sceneLocalVersion`：场景资源在本地的版本号。
- `totalSize`：场景资源包总大小。

### AgoraMetaBundleInfo

资源包信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaBundleInfo : NSObject
@property (nonatomic, assign) NSInteger bundleId;
@property (nonatomic, assign) NSInteger sceneId;
@property (nonatomic, assign) AgoraMetaBundleType bundleType;
@property (nonatomic, copy) NSString * _Nonnull bundleCode;
@property (nonatomic, copy) NSString * _Nonnull bundleName;
@property (nonatomic, copy) NSString * _Nonnull desc;
@property (nonatomic, copy) NSString * _Nonnull bundlePath;
@property (nonatomic, copy) NSString * _Nonnull thumbnailPath;
@property (nonatomic, copy) NSString * _Nonnull assets;
@property (nonatomic, copy) NSString * _Nullable extraInfo;
@property (nonatomic, assign) NSInteger bundleSize;
@end
```

- `bundleId`：资源包 ID。不同平台（Android、iOS）的同一个资源包的 ID 是不同的。
- `sceneId`：所属的场景资源 ID。
- `bundleType`：资源包类型：
  - `1`：场景资源。
  - `2`：虚拟形象（avatar）资源。
  - `3`：assetManifest 资源。
  - `100`：其他资源。
- `bundleCode`：资源包代码，不同平台（Android、iOS）同一个资源包的代码要保持一致。
- `bundleName`：资源包名称。
- `desc`：资源包描述。
- `bundlePath`：资源包的本地存储路径。
- `thumbnailPath`：资源包缩略图的本地存储路径。
- `assets`：预留参数。
- `extraInfo`：资源包的其它额外信息。
- `bundleSize`：资源包大小。
### AgoraMetaSceneConfig

场景的配置信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaSceneConfig : NSObject
@property (nonatomic, assign) AgoraMetaStateSyncMode syncMode;
@property (nonatomic, weak) id<AgoraMetaSceneEventDelegate> _Nullable delegate;
@property (nonatomic, assign) BOOL enableFaceCapture;
@property (nonatomic, copy) NSString * _Nonnull faceCaptureAppId;
@property (nonatomic, copy) NSString * _Nonnull faceCaptureCertificate;
@end
```

- `syncMode`：消息同步模式：
  - `AgoraMetaStateSyncModeNone(0)`：不同步消息。
  - `AgoraMetaStateSyncModeNormal(1)`：（默认）通过 RTM 同步消息。
- `delegate`：`AgoraMetaSceneEventDelegate` 事件回调协议。
- `enableFaceCapture`：是否开启面部捕捉：
  - `YES`：开启。
  - `NO`：（默认）不开启。
- `faceCaptureAppId`：开启面部捕捉时设置的 App ID。开启面捕时必填。
- `faceCaptureCertificate`：开启面部捕捉时设置的 Certificate（证书）。开启面捕时必填。

通过面捕 App ID 和 Certificate 可以获取对应的面捕证书（license）。开启面捕功能时，需要你设置面捕证书（license）。

### AgoraMetaEnterSceneConfig

进入场景的配置信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaEnterSceneConfig : NSObject
@property (nonatomic, copy) NSString * _Nonnull roomName;
@property (nonatomic, strong) UIView * _Nonnull sceneView;
@property (nonatomic, assign) NSInteger sceneId;
@property (nonatomic, copy) NSString * _Nullable scenePath;
@property (nonatomic, strong) NSData * _Nullable extraInfo;
@end
```

- `roomName`：进入场景的房间名称。
- `sceneView`：场景渲染所需要的视图。iOS 上需要用 `AgoraMetaScene` 类的的 `createRenderView` 方法创建。
- `sceneId`：进入场景的 ID。
- `scenePath`：（可选）`sceneId` 为 0 时，表示从本地路径加载资源，此时，`scenePath` 必须设为本地资源文件夹的路径。
- `extraInfo`：（可选）加载场景资源时需要的其它额外自定义信息。你可以自行定义，目前只支持字符串。


### AgoraMetaAvatarModelInfo

用户的虚拟形象（Avatar）信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaAvatarModelInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull bundleCode;
@property (nonatomic,assign) BOOL localVisible;
@property (nonatomic,assign) BOOL remoteVisible;
@property (nonatomic,assign) BOOL syncPosition;
@end
```


- `bundleCode`：人物模型所在的资源包代码。
- `localVisible`：虚拟人物模型是否在本地可见。如果设为 `NO`，`remoteVisible` 和 `syncPosition` 会自动设为 `NO`，并且无法更改。
- `remoteVisible`：虚拟人物模型是否在远端可见。
- `syncPosition`：是否同步本地人物渲染时所需要的信息（例如模型、装扮、捏脸信息等），用于控制玩家和游客模式。如果设为 `NO`，`remoteVisible` 不生效。


### AgoraMetaPositionInfo

用户的位置信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaPositionInfo : NSObject
@property (nonatomic, copy) NSArray * _Nonnull position;
@property (nonatomic, copy) NSArray * _Nonnull forward;
@property (nonatomic, copy) NSArray * _Nonnull right;
@property (nonatomic, copy) NSArray * _Nonnull up;
@end
```

- `position`：用户的坐标位置。
- `forward`：用户朝向的三维向量。
- `right`：用户右手方向的向量。
- `up`：用户头朝向的向量。

### AgoraMetaSceneDisplayConfig

场景显示相关配置。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaSceneDisplayConfig : NSObject
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSData * _Nullable extraInfo;
@end
```
- `width`：场景渲染画面的宽。
- `height`：场景渲染画面的高度。该宽高决定拿到场景渲染画面的原始视频帧的大小。如果要将画面发布到 RTC 频道中，建议将该宽高设置为与 RTC 的视频编码参数宽高一致，以避免缩放裁剪导致的性能损耗。
- `extraInfo`：Unity 渲染场景所需的额外信息，该字段是用户自定义的，一般由你的 Native 开发人员和 Unity 开发人员约定好。