本文介绍声网 MetaWorld SDK 的 Objective API。

## 概述

MetaWorld SDK 是基于声网视频 SDK 开发的元系列特殊版 SDK。相比[视频 SDK](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/rtc_api_overview_ng.html)，MetaWorld SDK 中新增元系列相关的 API。

## AgoraMetaServiceKit

MetaWorld SDK 所有接口的入口，可用于获取场景资源列表、下载场景资源、删除本地场景资源等场景资源管理，还可用于创建 `AgoraMetaScene`。

### sharedMetaServiceWithConfig


```objective-c
+ (instancetype _Nonnull)sharedMetaServiceWithConfig:(AgoraMetaServiceConfig* _Nonnull)config NS_SWIFT_NAME(sharedMetaServiceWithConfig(_:));
```

创建和初始化 `AgoraMetaServiceKit` 对象，并且登录声网 RTM 系统。


**参数**

`config`：初始化 `AgoraMetaServiceKit` 对象需要的配置信息，详见 [AgoraMetaServiceConfig](#agorametaserviceconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败


### destroy



```objective-c
+ (void)destroy NS_SWIFT_NAME(destroy());
```

销毁 `AgoraMetaServiceKit` 对象。

### renewToken #TODO（android also）

```objective-c
- (NSInteger)renewToken:(NSString *_Nonnull)token;
```
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

`sceneId`：场景的 ID，可以从 [AgoraMetaSceneInfo](#agorametaceneinfo) 获取。

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

`sceneId`：场景的 ID，可以从 [AgoraMetaSceneInfo](#agorametaceneinfo) 获取。

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

`sceneId`：场景的 ID，可以从 [AgoraMetaSceneInfo](#agorametaceneinfo) 获取。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### cleanSceneAssets


```objective-c
- (NSInteger)cleanSceneAssets:(NSInteger)sceneId;
```

清理本地场景资源。

**参数**

`sceneId`：场景的 ID，可以从 [AgoraMetaSceneInfo](#agorametaceneinfo) 获取。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### createScene


```objective-c
- (NSInteger)createScene:(AgoraMetaSceneConfig *_Nonnull)config;
```

创建 `AgoraMetaScene` 对象。

调用该方法会触发 `AgoraMetaEventDelegate` 协议的 [onCreateSceneResult](#oncreatesceneresult) 回调。成功创建的 `AgoraMetaScene` 对象可以在该回调里拿到。

**参数**

`config`：创建 `AgoraMetaScene` 对象需要的配置信息，详见 [AgoraMetaSceneConfig](#agorametasceneconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

## AgoraMetaScene #TODO WIP

场景相关操作。

### destroy

销毁 AgoraMetaScene 对象。

```objective-c
- (NSInteger)destroy;
```

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### getLocalUserAvatar

进入场景前，可以调用该方法获取用户的昵称、虚拟形象、装扮捏脸等信息。

```objective-c
- (AgoraMetaLocalUserAvatar *_Nullable)getLocalUserAvatar;
```

**返回值**

`AgoraMetachatLocalUserAvatar` 对象。

### createRenderView

创建场景渲染所需的视图。

```objective-c
- (UIView *_Nullable)createRenderView:(CGRect)frame;
```

**参数**

- `venderType`：场景渲染引擎的厂商类型，详见 [AgoraMetachatVenderType](#agorametachatvendertype)。
- `region`：视图的位置和大小。

**返回值**

创建的视图对象。

### enterScene

进入场景。

```objective-c
- (NSInteger)enterScene:(AgoraMetaEnterSceneConfig *_Nonnull)config;
```
成功调用该方法会触发 `onEnterSceneResult` 回调。

**参数**

 `config`：进入场景所需要的配置信息，详见 [AgoraMetachatEnterSceneConfig](#agorametachatentersceneconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### leaveScene

离开场景。

```objective-c
- (NSInteger)leaveScene;
```
成功调用该方法会触发 `onLeaveSceneResult` 回调。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### sendSceneMessage

往场景发送自定义消息。

```objective-c
- (NSInteger)sendSceneMessage:(NSData *_Nonnull)message;
```

- 该方法适用于 app 需要和 Unity 通信的场景。Unity 收到自定义消息后可以进行自定义的逻辑处理。
- 该方法必须在 `enterScene` 之后调用。

**参数**

 `message`：自定义消息，目前只支持字符串。消息格式可以自定义。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败


### enableVideoDisplay

开启/关闭场景内指定的显示器。

```objective-c
- (NSInteger)enableVideoDisplay:(NSString *_Nonnull)displayId enable:(BOOL)enable;
```

**参数**

- `displayId`：指定显示器的 ID。
- `enable`：是否开启指定显示器：
  - `YES`：开启显示器，即开始视频渲染。
  - `NO`：关闭显示器，即关闭视频渲染。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### pushVideoFrameToDisplay

往场景内指定的显示器推送原始视频帧。

```objective-c
- (NSInteger)pushVideoFrameToDisplay:(NSString *_Nonnull)displayId frame:(AgoraVideoFrame *_Nullable)frame;
```

**参数**

- `displayId`：指定显示器的 ID。
- `frame`：视频帧。详见 RTC SDK 4.x API 参考中的 [AgoraVideoFrame](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/rtc_api_data_type.html#class_externalvideoframe)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### addSceneView

```objective-c
- (NSInteger)addSceneView:(UIView *_Nonnull)view sceneDisplayConfig:(AgoraMetaSceneDisplayConfig *_Nullable)config;
```


### removeSceneView
```objective-c
- (NSInteger)removeSceneView:(UIView *_Nonnull)view;
```


### enableFaceCapture
```objective-c
- (NSInteger)enableFaceCapture:(BOOL)enable;
```


### enableSceneVideoCapture
```objective-c
- (NSInteger)enableSceneVideoCapture:(UIView *_Nonnull)view enable:(BOOL)enable;
```

## AgoraMetaLocalUserAvatar

### setUserInfo

设置用户的基本信息。

```objective-c
- (NSInteger)setUserInfo:(AgoraMetaUserInfo *_Nullable)userInfo;
```

**参数**

 `userInfo`：在场景内展示的用户信息，详见 [AgoraMetachatUserInfo](#agorametachatuserinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getUserInfo

获取用户的基本信息。

```objective-c
- (AgoraMetaUserInfo *_Nullable)getUserInfo;
```

**返回值**

[AgoraMetachatUserInfo](#agorametachatuserinfo) 对象。

### setModelInfo

设置用户的模型信息。

```objective-c
- (NSInteger)setModelInfo:(AgoraMetaAvatarModelInfo *_Nullable)modelInfo;
```

**参数**

 `modelInfo`：用户的虚拟形象模型信息，详见 [AgoraMetachatAvatarModelInfo](#agorametachatavatarmodelinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getModelInfo

获取用户的模型信息。

```objective-c
- (AgoraMetaAvatarModelInfo *_Nullable)getModelInfo;
```

**返回值**

[AgoraMetachatAvatarModelInfo](#agorametachatavatarmodelinfo) 对象。


### setExtraInfo

设置自定义的用户信息。

```objective-c
- (NSInteger)setExtraInfo:(NSData *_Nullable)customInfo;
```

**参数**

 `customInfo`：自定义的用户信息。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getExtraInfo

获取自定义的用户信息。

```objective-c
- (NSData *_Nullable)getExtraInfo;
```

**返回值**

自定义的用户信息。

### applyInfo

应用新设置的用户信息。

```objective-c
- (NSInteger)applyInfo;
```

- 如果你在进入场景前调用 `setUserInfo`、`setModelInfo`、`setDressInfo`、`setFaceInfo` 或 `setExtraCustomInfo` 方法，则不需要调用 `applyInfo`。
- 如果你在进入场景后调用了 `setUserInfo`、`setModelInfo`、`setDressInfo`、`setFaceInfo` 或 `setExtraCustomInfo` 方法，必须再调用 `applyInfo` 让设置的信息生效。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

## AgoraMetaEventDelegate

`AgoraMetaServiceKit` 类的回调。

### onCreateSceneResult

创建 `AgoraMetaScene` 对象的状态回调。

```objective-c
- (void)onCreateSceneResult:(AgoraMetaScene *_Nullable)scene errorCode:(NSInteger)errorCode;
```
**参数**

- `scene`：创建的 `AgoraMetaScene` 对象，用于后续进出场景等操作。
- `errorCode`：错误码。0 表示创建成功。

### onConnectionStateChanged

连接状态改变回调。

```objective-c
- (void)onConnectionStateChanged:(AgoraMetaConnectionStateType)state reason:(AgoraMetaConnectionChangedReasonType)reason;
```
**参数**

- `state`：连接状态。
  - 1：断开连接。
  - 2：正在连接。
  - 3：连接成功。
  - 4：正在重连。
  - 5：连接丢弃。

- `reason`：连接状态改变的原因。

### onTokenWillExpire #TODOrequestToken

请求 token 回调。

```objective-c
- (void)onTokenWillExpire;
```

### onGetSceneAssetsInfoResult

获取场景列表回调。

```objective-c
- (void)onGetSceneAssetsInfoResult:(NSMutableArray * _Nonnull)sceneInfos errorCode:(NSInteger)errorCode;
```
**参数**

- `sceneInfos`：场景信息列表，详见 [MetachatSceneInfo](#metachatsceneinfo)。

- `errorCode`：错误码。0 表示获取场景列表成功。

### onDownloadSceneAssetsProgress

下载场景进度回调。

```objective-c
- (void)onDownloadSceneAssetsProgress:(NSInteger)sceneId progress:(NSInteger)progress state:(AgoraMetaDownloadStateType)state;
```
**参数**

- `sceneId`：场景 ID。

- `progress`：下载进度，取值范围 [0,100]。

- `state`：下载状态。
  - 0：空闲。
  - 1：正在下载。
  - 2：下载完成。
  - 3：下载失败

## AgoraMetaSceneEventDelegate

`AgoraMetaScene` 类的回调。

### onEnterSceneResult

进入场景回调。

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onEnterSceneResult:(NSInteger)errorCode;
```
**参数**

 `errorCode`：0 表示进入房间成功，其它表示失败

### onLeaveSceneResult

离开场景回调。

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onLeaveSceneResult:(NSInteger)errorCode;
```
**参数**

 `errorCode`：0 表示进入房间成功，其它表示失败

### onRecvMessageFromScene

App 收到 Unity 发送的自定义信息时，该回调被触发。

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onSceneMessageReceived:(NSData * _Nonnull)message;
```
**参数**

 `message`：自定义消息。目前只支持字符串。

### onUserPositionChanged

本地或远端用户位置变化回调。

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onUserPositionChanged:(NSString * _Nonnull)uid posInfo:(AgoraMetaPositionInfo * _Nonnull)posInfo;
```
**参数**

- `uid`：本地或远端用户的用户 ID。
- `posInfo`：用户的位置信息，详见 [AgoraMetachatPositionInfo](#agorametachatpositioninfo)。

### onReleasedScene

销毁 `AgoraMetaScene` 对象的回调。

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onReleasedScene:(NSInteger)errorCode;
```
**参数**

 `errorCode`：错误码，0 表示销毁成功。

### onAddSceneViewResult

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onAddSceneViewResult:(UIView * _Nonnull)view errorCode:(NSInteger)errorCode;
```

### onRemoveSceneViewResult

```objective-c
- (void)metaScene:(AgoraMetaScene *_Nonnull)scene onRemoveSceneViewResult:(UIView * _Nonnull)view errorCode:(NSInteger)errorCode;
```

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


属性：
- `rtcEngine`：`AgoraRtcEngineKit` 实例，创建方法详见 [create [1/2]](https://docs.agora.io/cn/video-call-4.x/API20%Reference/ios_ng/API/class_irtcengine.html#api_create)。
- `appId`：在声网控制台获取的 App ID。
- `rtmToken` ：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。集成及测试阶段请将 `token` 设置为 `null`。
- `localDownloadPath` ：场景资源下载到本地的保存路径。
- `userId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `delegate`：回调事件，详见 [AgoraMetachatEventDelegate](#agorametachateventdelegate)。


### AgoraMetaUserInfo

用户信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaUserInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull userId;
@property (nonatomic, copy) NSString * _Nonnull userName;
@property (nonatomic, copy) NSString * _Nonnull userIconUrl;
@end
```


属性：
- `userId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。

- `userName`：用户昵称，用于在场景里显示用户昵称。
- `userIconUrl`：用户头像的 URL，用于在场景里显示用户头像。
- `extraCustomInfo`：自定义的用户信息。目前只支持字符串。


### AgoraMetaSceneInfo

场景信息。

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

属性：
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

属性：
- `bundleId`：资源包 ID，不同平台（Android、iOS）同一个资源包的ID 不同。
- `sceneId`：所属的场景 ID。
- `bundleType`：资源包类型：
  - 1：场景资源。
  - 2：虚拟形象（avatar）资源。
  - 3：assetManifest 资源。
  - 100：其他资源。
- `bundleCode`：资源包代码，不同平台（Android、iOS）同一个资源包的代码要保持一致。
- `bundleName`：资源包名称。
- `desc`：资源包描述。
- `bundlePath`：资源包的本地存储路径。
- `thumbnailPath`：资源包缩略图的本地存储路径。
- `assets`：预留参数。
- `extraInfo`：资源包的其它额外信息。
- `bundleSize`：资源包大小。
### MetaSceneConfig

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

属性：
`delegate`：AgoraMetaSceneEventDelegate 对象。

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

属性：
- `roomName`：进入场景的房间名称。
- `sceneView`：渲染场景所需要的 view。iOS 上需要用 `AgoraMetaScene` 的 `createRenderView` 方法创建。
- `sceneId`：进入场景的 ID。
- `extraCustomInfo`：（可选）加载场景时需要的其它额外自定义信息。你可以自行定义，目前只支持字符串。


### AgoraMetaAvatarModelInfo

用户的虚拟人物配置。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaAvatarModelInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull bundleCode;
@property (nonatomic,assign) BOOL localVisible;
@property (nonatomic,assign) BOOL remoteVisible;
@property (nonatomic,assign) BOOL syncPosition;
@end
```

属性：
- `bundleCode`：人物模型所在的资源包代码。
- `localVisible`：虚拟人物在本地是否显示。如果设为 `false`，`mRemoteVisible` 和 `mSyncPosition` 会自动设为 `false`，并且无法更改。
- `remoteVisible`：虚拟人物在远端是否可见。
- `syncPosition`：是否同步本地用户的位置，用于控制玩家和游客模式。如果设为 `false``，`mRemoteVisible`  不生效。
- `extraCustomInfo`：（可选）其他额外自定义信息。目前只支持字符串。




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
属性：
- `position`：用户的坐标位置。

- `forward`：用户朝向的三维向量。

- `right`：用户右手方向的向量。

- `up`：用户头朝向的向量。

### AgoraMetaSceneDisplayConfig

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetaSceneDisplayConfig : NSObject
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSData * _Nullable extraInfo;
@end
```
