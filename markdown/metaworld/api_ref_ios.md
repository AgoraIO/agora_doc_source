
## 概览

### 实时音视频功能

实时音视频功能相关的 API，请直接查看 RTC SDK 4.x 的 API 参考。

| 类  | 描述     |
| -------- | ------- |
| `AgoraRtcEngineKit`  | 实时音视频功能的基础接口。详见  [`RtcEngine`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/ios_ng/API/class_irtcengine.html)。     |
| `AgoraLocalSpatialAudioKit`  | 空间音效相关接口。详见 [`ILocalSpatialAudioEngine`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/ios_ng/API/class_ilocalspatialaudioengine.html)。       |
| `AgoraRtcMediaPlayerProtocol`  | 媒体播放器相关接口。详见  [`IMediaPlayer`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/ios_ng/API/class_imediaplayer.html)。      |

### 元语聊定制功能

本文重点提供元语聊定制功能的 API 参考。

| 类  | 描述     |
| -------- | ------- |
| [AgoraMetachatKit](#agorametachatkit)  | 房间和场景资源相关接口。     |
| [AgoraMetachatScene](#agorametachatscene)   | 场景操作相关接口。           |
| [AgoraMetachatLocalUserAvatar](#agorametachatlocaluseravatar) | 本地用户的昵称、虚拟形象、装扮、捏脸相关接口。   |
| [AgoraMetachatEventDelegate](#agorametachateventdelegate)   | 房间和场景资源相关回调。 |
| [AgoraMetachatSceneEventDelegate](#agorametachatsceneeventdelegate) | 场景操作相关回调。      |


## AgoraMetachatKit

元语聊服务的基础类。

### sharedMetachatWithConfig

创建和初始化 `AgoraMetachatKit` 对象，并且登录声网 RTM 系统。

```objective-c
+ (instancetype _Nonnull)sharedMetachatWithConfig:(AgoraMetachatConfig* _Nonnull)config;
```

成功调用该方法会触发 `onConnectionStateChanged` 回调。

**参数**

  `config`：初始化 `AgoraMetachatKit` 对象需要的配置信息，详见 [AgoraMetachatConfig](#agorametachatconfig)。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。


### destroy

销毁 `AgoraMetachatKit` 对象。

```objective-c
+ (void)destroy;
```

### getSceneInfos

获取场景列表。

调用该方法会触发 [`onGetSceneInfosResult`](#ongetsceneinfosresult) 回调。

```objective-c
- (NSInteger)getSceneInfos;
```

**返回值**

- 0：方法调用成功
- <0：方法调用失败。


### isSceneDownloaded

查询本地是否已经下载指定场景。

```objective-c
- (NSInteger)isSceneDownloaded:(NSInteger)sceneId;
```

**参数**

  `sceneId`：场景的 ID，可以从 [AgoraMetachatSceneInfo](#agorametachatsceneinfo) 获取。

**返回值**

- 0：本地没有下载该场景。

- 1：本地已经下载该场景。

### downloadScene

下载场景到本地。

```objective-c
- (NSInteger)downloadScene:(NSInteger)sceneId;
```
调用该方法会触发 `onDownloadSceneProgress` 回调。

**参数**

  `sceneId`：场景的 ID，可以从 [AgoraMetachatSceneInfo](#agorametachatsceneinfo) 获取。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### cancelDownloadScene

取消下载场景到本地。

```objective-c
- (NSInteger)cancelDownloadScene:(NSInteger)sceneId;
```

调用该方法会触发 `onDownloadSceneProgress` 回调，其中 `state` 为 3。

调用该方法后如果再次调用 `downloadScene`，会从上次取消下载时的进度恢复下载。

**参数**

  `sceneId`：场景的 ID，可以从 [MetachatSceneInfo](#metachatsceneinfo) 获取。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### cleanScene

清理本地场景。

```objective-c
- (NSInteger)cleanScene:(NSInteger)sceneId;
```
**参数**

  `sceneId`：场景的 ID，可以从 [AgoraMetachatSceneInfo](#agorametachatsceneinfo) 获取。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### createScene

创建 `AgoraMetachatScene` 对象。

```objective-c
- (NSInteger)createScene:(AgoraMetachatSceneConfig *_Nonnull)config;
```
调用该方法会触发 [onCreateSceneResult](#oncreatesceneresult) 回调，创建的 `AgoraMetachatScene` 对象可以在该回调里拿到。
**参数**

  `config`：创建 `AgoraMetachatScene` 对象需要的配置信息，详见 [AgoraMetachatSceneConfig](#agorametachatsceneconfig)。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

## AgoraMetachatScene

场景相关操作。

### destroy

销毁 AgoraMetachatScene 对象。

```objective-c
- (NSInteger)destroy;
```

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### getLocalUserAvatar

进入场景前，可以调用该方法获取用户的昵称、虚拟形象、装扮捏脸等信息。

```objective-c
- (AgoraMetachatLocalUserAvatar *_Nullable)getLocalUserAvatar;
```

**返回值**

`AgoraMetachatLocalUserAvatar` 对象。

### createRenderView

创建场景渲染所需的视图。

```objective-c
#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
- (NSView<AgoraMetaViewProtocol> *_Nullable)createRenderView:(AgoraMetachatVenderType)venderType region:(CGRect)region;
#else
- (UIView<AgoraMetaViewProtocol> *_Nullable)createRenderView:(AgoraMetachatVenderType)venderType region:(CGRect)region;
#endif
```

**参数**

- `venderType`：场景渲染引擎的厂商类型，详见 [AgoraMetachatVenderType](#agorametachatvendertype)。
- `region`：视图的位置和大小。

**返回值**

创建的视图对象。

### enterScene

进入场景。

```objective-c
- (NSInteger)enterScene:(AgoraMetachatEnterSceneConfig *_Nonnull)config;
```
成功调用该方法会触发 `onEnterSceneResult` 回调。

**参数**

 `config`：进入场景所需要的配置信息，详见 [AgoraMetachatEnterSceneConfig](#agorametachatentersceneconfig)。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### leaveScene

离开场景。

```objective-c
- (NSInteger)leaveScene;
```
成功调用该方法会触发 `onLeaveSceneResult` 回调。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### sendMessageToScene

往场景发送自定义消息。

```objective-c
- (NSInteger)sendMessageToScene:(NSData *_Nonnull)message;
```

- 该方法适用于 app 需要和 Unity 通信的场景。Unity 收到自定义消息后可以进行自定义的逻辑处理。
- 该方法必须在 `enterScene` 之后调用。

**参数**

 `message`：自定义消息，目前只支持字符串。消息格式可以自定义。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### enableUserPositionNotification

开启/关闭用户位置信息通知。

```objective-c
- (NSInteger)enableUserPositionNotification:(BOOL)enable;
```
**参数**

  `enable`：是否开启用户位置信息通知：

- `YES`：开启用户位置信息通知，即监听 `onUserPositionChanged` 事件。
- `NO`：关闭用户位置信息通知，即不监听 `onUserPositionChanged` 事件。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

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

- <0：方法调用失败。

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

- <0：方法调用失败。

## AgoraMetachatLocalUserAvatar

### setUserInfo

设置用户的基本信息。

```objective-c
- (NSInteger)setUserInfo:(AgoraMetachatUserInfo *_Nullable)userInfo;
```

**参数**

 `userInfo`：在场景内展示的用户信息，详见 [AgoraMetachatUserInfo](#agorametachatuserinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getUserInfo

获取用户的基本信息。

```objective-c
- (AgoraMetachatUserInfo *_Nullable)getUserInfo;
```

**返回值**

[AgoraMetachatUserInfo](#agorametachatuserinfo) 对象。

### setModelInfo

设置用户的模型信息。

```objective-c
- (NSInteger)setModelInfo:(AgoraMetachatAvatarModelInfo *_Nullable)modelInfo;
```

**参数**

 `modelInfo`：用户的虚拟形象模型信息，详见 [AgoraMetachatAvatarModelInfo](#agorametachatavatarmodelinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getModelInfo

获取用户的模型信息。

```objective-c
- (AgoraMetachatAvatarModelInfo *_Nullable)getModelInfo;
```

**返回值**

[AgoraMetachatAvatarModelInfo](#agorametachatavatarmodelinfo) 对象。

### setDressInfo

设置用户的装扮信息。

```objective-c
- (NSInteger)setDressInfo:(AgoraMetachatDressInfo *_Nullable)dressInfo;
```

**参数**

 `dressInfo`：用户的装扮信息，详见 [AgoraMetachatDressInfo](#agorametachatdressinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getDressInfo

获取用户的装扮信息。

```objective-c
- (AgoraMetachatDressInfo *_Nullable)getDressInfo;
```

**返回值**

[AgoraMetachatDressInfo](#agorametachatdressinfo) 对象。

### setFaceInfo
设置用户的捏脸信息。

```objective-c
- (NSInteger)setFaceInfo:(AgoraMetachatFaceInfo *_Nullable)faceInfo;
```

**参数**

 `faceInfo`：本地用户的捏脸信息，详见 [AgoraMetachatFaceInfo](#agorametachatfaceinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getFaceInfo

获取用户的捏脸信息。

```objective-c
- (AgoraMetachatFaceInfo *_Nullable)getFaceInfo;
```

**返回值**

[AgoraMetachatFaceInfo](#agorametachatfaceinfo) 对象。

### setExtraCustomInfo

设置自定义的用户信息。

```objective-c
- (NSInteger)setExtraCustomInfo:(NSData *_Nullable)customInfo;
```

**参数**

 `customInfo`：自定义的用户信息。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getExtraCustomInfo

获取自定义的用户信息。

```objective-c
- (NSData *_Nullable)getExtraCustomInfo;
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
- <0：方法调用失败。

## AgoraMetachatEventDelegate

`AgoraMetachatKit` 类的回调。

### onCreateSceneResult

创建 `AgoraMetachatScene` 对象的状态回调。

```objective-c
- (void)onCreateSceneResult:(AgoraMetachatScene *_Nullable)scene errorCode:(NSInteger)errorCode;
```
**参数**

- `scene`：创建的 `AgoraMetachatScene` 对象，用于后续进出场景等操作。
- `errorCode`：错误码。0 表示创建成功。

### onConnectionStateChanged

连接状态改变回调。

```objective-c
- (void)onConnectionStateChanged:(AgoraMetachatConnectionStateType)state reason:(AgoraMetachatConnectionChangedReasonType)reason;
```
**参数**

- `state`：连接状态。
  - 1：断开连接。
  - 2：正在连接。
  - 3：连接成功。
  - 4：正在重连。
  - 5：连接丢弃。

- `reason`：连接状态改变的原因。

### onRequestToken

请求 token 回调。

```objective-c
- (void)onRequestToken;
```

### onGetSceneInfosResult

获取场景列表回调。

```objective-c
- (void)onGetSceneInfosResult:(NSMutableArray * _Nonnull)sceneInfos errorCode:(NSInteger)errorCode;
```
**参数**

- `sceneInfos`：场景信息列表，详见 [MetachatSceneInfo](#metachatsceneinfo)。

- `errorCode`：错误码。0 表示获取场景列表成功。

### onDownloadSceneProgress

下载场景进度回调。

```objective-c
- (void)onDownloadSceneProgress:(NSInteger)sceneId progress:(NSInteger)progress state:(AgoraMetachatDownloadStateType)state;
```
**参数**

- `sceneId`：场景 ID。

- `progress`：下载进度，取值范围 [0,100]。

- `state`：下载状态。
  - 0：空闲。
  - 1：正在下载。
  - 2：下载完成。
  - 3：下载失败。

## AgoraMetachatSceneEventDelegate

`AgoraMetachatScene` 类的回调。

### onEnterSceneResult

进入场景回调。

```objective-c
- (void)metachatScene:(AgoraMetachatScene *_Nonnull)scene onEnterSceneResult:(NSInteger)errorCode;
```
**参数**

 `errorCode`：0 表示进入房间成功，其它表示失败。

### onLeaveSceneResult

离开场景回调。

```objective-c
- (void)metachatScene:(AgoraMetachatScene *_Nonnull)scene onLeaveSceneResult:(NSInteger)errorCode;
```
**参数**

 `errorCode`：0 表示进入房间成功，其它表示失败。

### onRecvMessageFromScene

App 收到 Unity 发送的自定义信息时，该回调被触发。

```objective-c
- (void)metachatScene:(AgoraMetachatScene *_Nonnull)scene onRecvMessageFromScene:(NSData * _Nonnull)message;
```
**参数**

 `message`：自定义消息。目前只支持字符串。

### onUserPositionChanged

本地或远端用户位置变化回调。

```objective-c
- (void)metachatScene:(AgoraMetachatScene *_Nonnull)scene onUserPositionChanged:(NSString * _Nonnull)uid posInfo:(AgoraMetachatPositionInfo * _Nonnull)posInfo;
```
**参数**

- `uid`：本地或远端用户的用户 ID。
- `posInfo`：用户的位置信息，详见 [AgoraMetachatPositionInfo](#agorametachatpositioninfo)。

### onReleasedScene

销毁 `AgoraMetachatScene` 对象的回调。

```objective-c
- (void)metachatScene:(AgoraMetachatScene *_Nonnull)scene onReleasedScene:(NSInteger)errorCode;
```
**参数**

 `errorCode`：错误码，0 表示销毁成功。




## 类型定义

### AgoraMetachatConfig

初始化 `AgoraMetachatKit` 的配置信息。

<details>
<summary>class AgoraMetachatConfig</summary>
```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatConfig : NSObject
@property (nonatomic, copy) NSString * _Nonnull appId;
@property (nonatomic, copy) NSString * _Nonnull rtmToken;
@property (nonatomic, copy) NSString * _Nonnull userId;
@property (nonatomic, weak) id<AgoraMetachatEventDelegate> _Nullable delegate;
@property (nonatomic, copy) NSString * _Nonnull localDownloadPath;
@property (nonatomic, assign) AgoraRtcEngineKit* _Nullable rtcEngine;
@end
```
</details>

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


### AgoraMetachatUserInfo

用户信息。

<details>
<summary>class AgoraMetachatUserInfo</summary>

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatUserInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull userId;
@property (nonatomic, copy) NSString * _Nonnull userName;
@property (nonatomic, copy) NSString * _Nonnull userIconUrl;
@property (nonatomic, strong) NSData * _Nullable extraCustomInfo;
@end
```
</details>

属性：
- `userId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。

- `userName`：用户昵称，用于在场景里显示用户昵称。
- `userIconUrl`：用户头像的 URL，用于在场景里显示用户头像。
- `extraCustomInfo`：自定义的用户信息。目前只支持字符串。


### MetachatSceneInfo

场景信息。

<details>
<summary>class AgoraMetachatSceneInfo</summary>

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatSceneInfo : NSObject
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
@property (nonatomic, strong) NSArray<AgoraMetachatBundleInfo *> * _Nonnull bundles;
@end
```
</details>

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

### AgoraMetachatBundleInfo

资源包信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatBundleInfo : NSObject
@property (nonatomic, assign) NSInteger bundleId;
@property (nonatomic, assign) NSInteger sceneId;
@property (nonatomic, assign) AgoraMetachatBundleType bundleType;
@property (nonatomic, copy) NSString * _Nonnull bundleCode;
@property (nonatomic, copy) NSString * _Nonnull bundleName;
@property (nonatomic, copy) NSString * _Nonnull desc;
// local path of bundle model path
@property (nonatomic, copy) NSString * _Nonnull bundlePath;
// local path of bundle thumbnail
@property (nonatomic, copy) NSString * _Nonnull thumbnailPath;
@property (nonatomic, copy) NSString * _Nonnull assets;
@property (nonatomic, copy) NSString * _Nullable extraInfo;
@property (nonatomic, assign) NSInteger bundleSize;
@end
}
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
### MetachatSceneConfig

场景的配置信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatSceneConfig : NSObject
@property (nonatomic, weak) id<AgoraMetachatSceneEventDelegate> _Nullable delegate;
@end
```

属性：
`delegate`：AgoraMetachatSceneEventDelegate 对象。

### AgoraMetachatEnterSceneConfig

进入场景的配置信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatEnterSceneConfig : NSObject
@property (nonatomic, copy) NSString * _Nonnull roomName;
#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
@property (nonatomic, strong) NSView * _Nonnull sceneView;
#else
@property (nonatomic, strong) UIView * _Nonnull sceneView;
#endif
@property (nonatomic, assign) NSInteger sceneId;
@property (nonatomic, strong) NSData * _Nullable extraCustomInfo;
@end
```

属性：
- `roomName`：进入场景的房间名称。
- `sceneView`：渲染场景所需要的 view。iOS 上需要用 `AgoraMetachatScene` 的 `createRenderView` 方法创建。
- `sceneId`：进入场景的 ID。
- `extraCustomInfo`：（可选）加载场景时需要的其它额外自定义信息。你可以自行定义，目前只支持字符串。




### AgoraMetachatAvatarModelInfo

用户的虚拟人物配置。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatAvatarModelInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull bundleCode;
@property (nonatomic,assign) BOOL localVisible;
@property (nonatomic,assign) BOOL remoteVisible;
@property (nonatomic,assign) BOOL syncPosition;
@property (nonatomic, strong) NSData * _Nullable extraCustomInfo;
@end
```

属性：
- `bundleCode`：人物模型所在的资源包代码。
- `localVisible`：虚拟人物在本地是否显示。如果设为 `false`，`mRemoteVisible` 和 `mSyncPosition` 会自动设为 `false`，并且无法更改。
- `remoteVisible`：虚拟人物在远端是否可见。
- `syncPosition`：是否同步本地用户的位置，用于控制玩家和游客模式。如果设为 `false``，`mRemoteVisible`  不生效。
- `extraCustomInfo`：（可选）其他额外自定义信息。目前只支持字符串。

### AgoraMetachatDressInfo
用户的装扮信息。

```objective-c

__attribute__((visibility("default"))) @interface AgoraMetachatDressInfo : NSObject
@property (nonatomic, strong) NSData * _Nullable extraCustomInfo;
@end
```

属性：
`extraCustomInfo`：（可选）其他额外自定义信息。目前只支持字符串。

### AgoraMetachatFaceInfo
用户的捏脸信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatFaceInfo : NSObject
@property (nonatomic, strong) NSData * _Nullable extraCustomInfo;
@end
```

属性：
`extraCustomInfo`：（可选）其他额外自定义信息。目前只支持字符串。


### AgoraMetachatPositionInfo

用户的位置信息。

```objective-c
__attribute__((visibility("default"))) @interface AgoraMetachatPositionInfo : NSObject
@property (nonatomic, strong) NSArray * _Nonnull position;
@property (nonatomic, strong) NSArray * _Nonnull forward;
@property (nonatomic, strong) NSArray * _Nonnull right;
@property (nonatomic, strong) NSArray * _Nonnull up;
@end
```
属性：
- `position`：用户的坐标位置。

- `forward`：用户朝向的三维向量。

- `right`：用户右手方向的向量。

- `up`：用户头朝向的向量。

### AgoraMetachatVenderType

场景渲染引擎的厂商类型。

```objective-c
typedef NS_ENUM(NSUInteger, AgoraMetachatVenderType) {
  AgoraMetachatVenderTypeUnity = 0,
};
```

枚举值：

- `AgoraMetachatVenderTypeUnity`：0，Unity 引擎。