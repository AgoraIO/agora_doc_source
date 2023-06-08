## 概览

### 实时音视频功能

实时音视频功能相关的 API，请直接查看 RTC SDK 4.x 的 API 参考。

| 类  | 描述     |
| -------- | ------- |
| `RtcEngine`  | 实时音视频功能的基础接口。详见  [`RtcEngine`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html)。     |
| `ILocalSpatialAudioEngine`  | 空间音效相关接口。详见 [`ILocalSpatialAudioEngine`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_ilocalspatialaudioengine.html)。       |
| `IMediaPlayer`  | 媒体播放器相关接口。详见  [`IMediaPlayer`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_imediaplayer.html)。      |

### 元语聊定制功能

本文重点提供元语聊定制功能的 API 参考。

| 类  | 描述  #TODO add more   |
| -------- | ------- |
| [IMetaService](#IMetaService)  | 房间和场景场景相关接口。     |
| [IMetaScene](#IMetaScene)   | 场景资源操作相关接口。           |
| [ILocalUserAvatar](#ilocaluseravatar) | 本地用户的昵称、虚拟形象、装扮、捏脸相关接口。   |
| [IMetaServiceEventHandler](#IMetaServiceEventHandler)   | 房间和场景场景相关回调。 |
| [IMetaSceneEventHandler](#IMetaSceneeventhandler) | 场景资源操作相关回调。       |

## IMetaService

元语聊服务的基础类。

### create


```java
public static synchronized IMetaService create();
```

创建 `IMetaService` 对象。

**返回值**

`IMetaService` 对象。

### initialize


```java
public abstract int initialize(MetaServiceConfig config);
```

初始化 `IMetaService` 对象并登录声网 RTM 系统。#TODO delete

成功调用该方法会触发 `onConnectionStateChanged` 回调。#TODO delete

**参数**

`config`：初始化 `IMetaService` 对象需要的配置信息，详见 [MetaServiceConfig](#metaserviceconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败


### destroy

```java
public static synchronized void destroy()
```

销毁 `IMetaService` 对象。

### addEventHandler

```java
public abstract int addEventHandler(IMetaServiceEventHandler eventHandler);
```

添加事件句柄。

**参数**

`eventHandler`：事件句柄：`IMetaServiceEventHandler`。

**返回值**

- 0：方法调用成功
- < 0：添加事件句柄失败

### removeEventHandler


```java
public abstract int removeEventHandler(IMetaServiceEventHandler eventHandler);
```

移除事件句柄。

**参数**

`eventHandler`：事件句柄：`IMetaServiceEventHandler`。

**返回值**

- 0：方法调用成功
- < 0：移除事件句柄失败

### getSceneAssetsInfo


```java
public abstract int getSceneAssetsInfo();
```

获取场景场景列表。

调用该方法会触发 [`onGetSceneAssetsInfosResult`](#ongetsceneassetsinfosresult) 回调。


**返回值**

- 0：方法调用成功
- < 0：获取场景场景列表失败


### isSceneAssetsDownloaded


```java
public abstract int isSceneAssetsDownloaded(long sceneId);
```

判断场景场景是否已下载到本地。

**参数**

`sceneId`：场景场景的 ID，可以从 [MetaSceneAssetsInfo](#metasceneassetsinfo) 获取。

**返回值**

- 0：未下载到本地。

- 1：已下载到本地。

### downloadScene


```java
public abstract int downloadSceneAssets(long sceneId);
```

下载场景资源到本地。

调用该方法会触发 `IMetaServiceEventHandler` 类的 `onDownloadSceneProgress` 回调。

**参数**

`sceneId`：场景资源的 ID，可以从 [MetaSceneAssetsInfo](#metasceneassetsinfo) 获取。

**返回值**

- 0：下载成功

- < 0：下载失败

### cancelDownloadScene


```java
public abstract int cancelDownloadSceneAssets(long sceneId);
```

取消下载场景资源到本地。

调用该方法会触发 `IMetaServiceEventHandler` 类的 `onDownloadSceneProgress` 回调，其中 `state` 为 `3(FAILED)`。

调用该方法后如果再次调用 `downloadSceneAssets`，会从上次取消下载时的进度恢复下载。

**参数**

`sceneId`：场景资源的 ID，可以从 [MetaSceneAssetsInfo](#metasceneassetsinfo) 获取。

**返回值**

- 0：取消下载成功

- < 0：取消下载失败

### cleanSceneAssets



```java
public abstract int cleanSceneAssets(long sceneId);
```

清理本地场景资源。

**参数**

`sceneId`：场景资源的 ID，可以从 [MetaSceneAssetsInfo](#metasceneassetsinfo) 获取。

**返回值**

- 0：清理成功

- < 0：清理失败

### createScene

创建 `IMetaScene` 对象。

```java
public abstract int createScene(MetaSceneConfig config);
```
调用该方法会触发 `IMetaServiceEventHandler` 类的 [onCreateSceneResult](#oncreatesceneresult) 回调。成功创建的 `IMetaScene` 对象可以在该回调里拿到。

**参数**

`config`：创建 `IMetaScene` 对象需要的配置信息，详见 [MetachatSceneConfig](#metasceneconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

## IMetaScene

场景资源相关操作。

### release

```java
public abstract int release();
```

销毁 IMetaScene 对象。

调用该方法会触发 [onReleasedScene](#onreleasedscene) 回调。#TODO

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### getLocalUserAvatar



```java
public abstract ILocalUserAvatar getLocalUserAvatar();
```

进入场景资源前，可以调用该方法获取用户的昵称、虚拟形象、装扮捏脸等信息。

**返回值**

`ILocalUserAvatar` 对象。


### addEventHandler


```java
public abstract int addEventHandler(IMetaSceneEventHandler eventHandler);
```

添加事件句柄。


**参数**

`eventHandler`：事件句柄：`IMetaServiceEventHandler`。

**返回值**

- 0：方法调用成功
- < 0：添加事件句柄失败


### removeEventHandler

```java
public abstract int removeEventHandler(IMetaServiceEventHandler eventHandler);
```

移除事件句柄。

**参数**

`eventHandler`：事件句柄：`IMetaServiceEventHandler`。

**返回值**

- 0：方法调用成功
- < 0：移除事件句柄失败

### enterScene



```java
public abstract int enterScene(EnterSceneConfig config);
```

进入场景。

成功调用该方法会触发 `IMetaSceneEventHandler` 类的 `onEnterSceneResult` 回调。

**参数**

`config`：进入场景所需要的配置信息，详见 [EnterSceneConfig](#entersceneconfig)。


**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### leaveScene

离开场景资源。

```java
public abstract int leaveScene();
```
成功调用该方法会触发 `IMetaSceneEventHandler` 类的 `onLeaveSceneResult` 回调。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### sendMessageToScene



```java
public abstract int sendSceneMessage(byte[] message);
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

### setSceneParameters

```java
public abstract int setSceneParameters(String jsonParam);
```

（预留方法，尚未实现）设置场景渲染相关参数。



### enableVideoDisplay


```java
public abstract int enableVideoDisplay(String displayId, boolean enable);
```

开启/关闭场景里的视频显示器。

**参数**

- `displayId`：指定显示器的 ID。ID 需要由你的 Native 开发者和 Unity 开发者协商后规定。
- `enable`：是否开启指定显示器：
  - `true`：开启显示器，即开始视频渲染。
  - `false`：关闭显示器，即关闭视频渲染。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### pushVideoFrameToDisplay

```java
public abstract int pushVideoFrameToDisplay(String displayId, AgoraVideoFrame frame);
```

往场景里的视频显示器推送原始视频帧。

**参数**

- `displayId`：指定显示器的 ID。ID 需要由你的 Native 开发者和 Unity 开发者协商后规定。
- `frame`：原始视频帧。详见 RTC SDK API 参考中的 [AgoraVideoFrame](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/rtc_api_data_type.html#class_externalvideoframe)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### addSceneView

```java
public abstract int addSceneView(TextureView view, SceneDisplayConfig config);
```

添加场景显示视图

该方法可添加一个额外的视图，以显示 Unity 场景的 Camera 的画面。调用成功后，SDK 会触发 `IMetaSceneEventHandler` 类的 `onAddSceneViewResult` 回调。#TODO

**参数**

- view：unity camera画面显示需要的视图。
- config：场景显示相关配置参数，[SceneDisplayConfig](#scenadiaplayconfig)。#TODO

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### removeSceneView

```java
public abstract int removeSceneView(TextureView view);
```

移除场景显示视图

调用成功后，SDK 会触发 `IMetaSceneEventHandler` 类的 `onRemoveSceneViewResult` 回调。

**参数**

view：待移除的视图。


**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### enableSceneVideoCapture

```java
public abstract int enableSceneVideoCapture(TextureView view, boolean enable);
```

开启或关闭场景渲染画面捕获

开启或关闭场景渲染画面捕获，配合RtcEngine的joinChannel，可以把场景渲染的画面发布到RTC频道里面。#TODO

**参数**

- view：需要捕获的场景视图。
- enable：为true时，表示把场景画面发布到RTC频道里面；所有场景视图捕获为false时，会把摄像头画面发布到RTC频道。默认为false。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败


## ILocalUserAvatar

### setUserInfo

设置用户的基本信息。

```java
int setUserInfo(MetaUserInfo userInfo);
```

**参数**

`userInfo`：在场景内展示的用户信息，详见 [MetaUserInfo](#metauserinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getUserInfo



```java
MetaUserInfo getUserInfo();
```
获取用户的基本信息。

**返回值**

[MetaUserInfo](#metauserinfo) 对象。

### setModelInfo


```java
int setModelInfo(AvatarModelInfo modelInfo);
```

设置用户的模型信息。


**参数**

`modelInfo`：用户的虚拟形象模型信息，详见 [AvatarModelInfo](#avatarmodelinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getModelInfo


```java
AvatarModelInfo getModelInfo();
```

获取当前使用的用户模型信息。

**返回值**

[AvatarModelInfo](#avatarmodelinfo) 对象。


### setExtraInfo



```java
int setExtraInfo(byte[] extraInfo);
```

设置自定义的用户信息。

你可以通过该方法设置用户的装扮信息、捏脸信息。

**参数**

`extraInfo`：自定义的用户信息。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getExtraInfo


```java
byte[] getExtraInfo();
```

获取自定义的用户信息。


**返回值**

当前使用的自定义的用户信息。

### applyInfo


```java
int applyInfo();
```

应用新设置的用户信息。

**注意**

- 如果你在进入场景资源前调用 `setUserInfo`、`setModelInfo`、`setExtraInfo`  方法，则不需要调用 `applyInfo`。
- 如果你在进入场景资源后调用了 `setUserInfo`、`setModelInfo`、`setExtraInfo` 方法，必须再调用 `applyInfo` 让设置的信息生效。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

## IMetaServiceEventHandler

`IMetaService` 类的回调。

### onCreateSceneResult


```java
public void onCreateSceneResult(IMetaScene scene, int errorCode);
```

`IMetaScene` 创建回调。

**参数**

- `scene`：创建的 `IMetaScene` 对象，用于后续进出场景资源等操作。
- `errorCode`：错误码：
  - 0 表示创建成功。
  - 其余情况表示创建失败。

### onConnectionStateChanged



```java
public void onConnectionStateChanged(int state, int reason);
```

连接状态改变回调。

**参数**

- `state`：连接状态。
  - 1：断开连接。
  - 2：正在连接。
  - 3：连接成功。
  - 4：正在重连。
  - 5：连接丢弃。

- `reason`：连接状态改变的原因。

### onTokenWillExpire


```java
public void onTokenWillExpire();
```

Token 即将过期回调。

### onGetSceneAssetsInfoResult



```java
public void onGetSceneAssetsInfoResult(MetaSceneAssetsInfo[] metaSceneAssetsInfo, int errorCode);
```

获取场景资源列表回调

**参数**

- `metaSceneAssetsInfo`：场景资源信息列表，详见 [MetaSceneAssetsInfo](#metasceneassetsinfo)。

- `errorCode`：错误码：
  - 0 表示获取列表成功。
  - 其余情况表示获取列表失败。

### onDownloadSceneAssetsProgress

下载场景资源进度回调。

```java
public void onDownloadSceneAssetsProgress(long sceneId, int progress, int state);
```
**参数**

- `sceneId`：场景资源 ID。

- `progress`：下载进度，取值范围 [0,100]。

- `state`：下载状态：
  - 0：空闲。
  - 1：正在下载。
  - 2：下载完成。
  - 3：下载失败

## IMetaSceneEventHandler

`IMetaScene` 类的回调。

### onEnterSceneResult


```java
public void onEnterSceneResult(int errorCode);
```

进入场景的结果回调。


**参数**

- `errorCode`：错误码：
  - 0 表示进入场景成功。
  - 其余情况进入场景失败。

### onLeaveSceneResult



```java
public void onLeaveSceneResult(int errorCode);
```

离开场景的结果回调。


**参数**

- `errorCode`：错误码：
  - 0 表示离开场景成功。
  - 其余情况离开场景失败。

### onSceneMessageReceived

```java
public void onSceneMessageReceived(byte[] message);public void onSceneMessageReceived(byte[] message);
```

接收场景信息回调。

App 收到 Unity 场景发送的自定义信息时，SDK 会触发该回调。

**参数**

`message`：自定义格式的消息。目前只支持字符串。

### onUserPositionChanged


```java
public void onUserPositionChanged(String uid, MetaUserPositionInfo posInfo);
```

本地或远端用户位置变化回调。

**参数**

- `uid`：本地或远端用户的用户 ID。
- `posInfo`：用户的位置信息，详见 [MetaUserPositionInfo](#metauserpositioninfo)。


### onReleasedScene


```java
void onReleasedScene(int status);
```

`IMetaScene` 释放回调。

**参数**

`status`：错误码：
- 0 表示释放 IMetaScene 成功。
- 其余情况释放 IMetaScene 失败。

### onAddSceneViewResult
```java
void onAddSceneViewResult(TextureView view, int errorCode);
```

添加场景显示视图回调

调用 IMetaScene 类的 addSceneView 方法添加场景显示视图后，SDK 会触发该回调。

**参数**
- view：视图对象：TextureView。
- errorCode：错误码：
  - 0 表示添加视图成功。
  - 其余情况添加视图失败。

### onRemoveSceneViewResult

```java
void onRemoveSceneViewResult(TextureView view, int errorCode);
```

移除场景显示视图回调

调用 IMetaScene 类的 removeSceneView 方法移除场景显示视图后，SDK 会触发该回调。

**参数**
- view：视图对象：TextureView。
- errorCode：错误码：
  - 0 表示移除视图成功。
  - 其余情况移除视图失败。


## 类型定义

### MetaServiceConfig

初始化 `IMetaService` 对象的配置信息。

```java
public class MetachatConfig {
  public RtcEngine mRtcEngine;
  public String mAppId;
  public String mRtmToken;
  public String mLocalDownloadPath;
  public String mUserId;
  public IMetaServiceEventHandler mEventHandler;
}
```

- `mRtcEngine`：`RtcEngine` 实例，创建方法详见 [create [1/2]](https://docs.agora.io/cn/video-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_create)。
- `mAppId`：在声网控制台获取的 App ID。
- `mRtmToken` ：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。
- `mLocalDownloadPath` ：场景场景下载到本地的保存路径。
- `mUserId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `mEventHandler`：回调事件，详见 [IMetaServiceEventHandler](#IMetaServiceEventHandler)。



### MetaUserInfo

用户信息。

```java
public class MetaUserInfo {
  public String mUserId; // 此接口设置无效 #TODO？
  public String mUserName;
  public String mUserIconUrl;
}
```

- `mUserId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `mUserName`：用户昵称，用于在场景资源内显示用户昵称。
- `mUserIconUrl`：用户头像的 URL，用于在场景资源内显示用户头像。


### MetaSceneAssetsInfo

场景资源信息。

```java
public class MetaSceneAssetsInfo {
  public long mSceneId;
  public String mSceneName;
  public String mThumbnailPath;
  public String mScenePath;
  public String mParentScenePath;
  public String mDescription;
  public String mSceneConfig;
  public String mExtraInfo;
  public MetachatBundleInfo[] mBundles;
  public String mSceneVersion;
  public String mSceneLocalVersion;
  public long mTotalSize;
}
```

- `mSceneId`：场景资源的唯一标识符。
- `mSceneName`：场景资源名称。
- `mThumbnailPath`：场景资源缩略图的本地路径。
- `mScenePath`：场景场景的本地路径。
- `mParentScenePath`：依赖的父场景场景的本地路径。
- `mDescription`：场景资源的文字描述。
- `mSceneConfig`：场景资源的配置信息。
- `mExtraInfo`：其它额外信息。
- `mBundles`：场景资源支持的资源包列表。
- `mSceneVersion`：场景场景在服务器上的版本号。
- `mSceneLocalVersion`：场景场景在本地的版本号。
- `mTotalSize`：场景场景包总大小。


### MetaBundleInfo

资源包信息。


```java
public class MetachatBundleInfo {
  public long mBundleId;
  public long mSceneId;
  public int mBundleType;
  public String mBundleCode;
  public String mBundleName;
  public String mDescription;
  public String mBundlePath;
  public String mThumbnailPath;
  public String mAssets;
  public String mExtraInfo;
  public long mBundleSize;

}
```

- `mBundleId`：资源包 ID，不同平台（Android、iOS）同一个资源包的ID 不同。
- `mSceneId`：所属的场景资源 ID。
- `mBundleType`：资源包类型：
  - 1：场景场景。
  - 2：虚拟形象（Avatar）资源。
  - 3：assetManifest 资源。
  - 100：其他资源。
- `mBundleCode`：资源包代码，不同平台（Android、iOS）同一个资源包的代码要保持一致。
- `mBundleName`：资源包名称。
- `mDescription`：资源包描述。
- `mBundlePath`：资源包的本地存储路径。
- `mThumbnailPath`：资源包缩略图的本地存储路径。
- `mAssets`：预留参数。
- `mExtraInfo`：资源包的其它额外信息。
- `mBundleSize`：资源包大小。

方法：
- `toString`：返回 `MetachatBundleInfo` 对象的字符串表示形式。

### MetachatSceneConfig

场景资源的配置信息。

```java
public class MetachatSceneConfig {
  public Context mActivityContext;

  public MetachatSceneConfig() {
    mActivityContext = null;
  }
}
```

属性：
- `mActivityContext`：Activity 的 Context 对象，用于初始化 Unity。

### EnterSceneConfig

进入场景资源的配置信息。

<details>
<summary>class EnterSceneConfig</summary>

```java
public class EnterSceneConfig {
  public String mRoomName;
  public TextureView mSceneView;
  public long mSceneId;
  public byte[] mExtraCustomInfo;

  public EnterSceneConfig() {
    mRoomName = "";
    mSceneView = null;
    mSceneId = 0;
    mExtraCustomInfo = null;
  }

  @Override
  public String toString() {
    return "EnterSceneConfig{"
        + "mRoomName='" + mRoomName + '\'' + ", mSceneView=" + mSceneView + ", mSceneId=" + mSceneId
        + ", mExtraCustomInfo=" + Arrays.toString(mExtraCustomInfo) + '}';
  }
}
```
</details>

属性：
- `mRoomName`：进入场景资源的房间名称。
- `mSceneView`：场景资源渲染所需要的视图。Android 上用原生的 [TextureView](https://developer.android.com/reference/android/view/TextureView) 对象即可。
- `mSceneId`：进入场景资源的 ID。
- `mExtraCustomInfo`：（可选）加载场景资源时需要的其它额外自定义信息。你可以自行定义，目前只支持字符串。

方法：
- `toString`：返回 `EnterSceneConfig` 对象的字符串表示形式。

### AvatarModelInfo

用户的虚拟形象（Avatar）信息。

```java
public class AvatarModelInfo {
public String mBundleCode;  // 素材编号
public boolean mLocalVisible;  // 本地是否可以看见人物模型
public boolean mRemoteVisible;  // 远端是否可以看见本地用户的人物模型
public boolean mSyncPosition;  // 是否同步本地用户的模型装扮等信息
}
```

- `mBundleCode`：人物模型所在的资源包代码。
- `mLocalVisible`：虚拟人物在本地是否显示。如果设为 `false`，`mRemoteVisible` 和 `mSyncPosition` 会自动设为 `false`，并且无法更改。
- `mRemoteVisible`：虚拟人物在远端是否可见。
- `mSyncPosition`：是否同步本地用户的位置，用于控制玩家和游客模式。如果设为 `false``，`mRemoteVisible`  不生效。


### DressInfo
用户的装扮信息。

<details>
<summary>class DressInfo</summary>

```java
public class DressInfo {
  public byte[] mExtraCustomInfo;

  @CalledByNative
  public DressInfo(byte[] mExtraCustomInfo) {
    this.mExtraCustomInfo = mExtraCustomInfo;
  }

  public DressInfo() {
    mExtraCustomInfo = null;
  }

  @Override
  public String toString() {
    return "DressInfo{"
        + "mExtraCustomInfo=" + Arrays.toString(mExtraCustomInfo) + '}';
  }
}
```
</details>

属性：
- `mExtraCustomInfo`：（可选）其他额外自定义信息。目前只支持字符串。

方法：
- `toString`：返回 `DressInfo` 对象的字符串表示形式。

### FaceInfo
用户的捏脸信息。

<details>
<summary>class FaceInfo</summary>

```java
public class FaceInfo {
  public byte[] mExtraCustomInfo;

  @CalledByNative
  public FaceInfo(byte[] mExtraCustomInfo) {
    this.mExtraCustomInfo = mExtraCustomInfo;
  }

  public FaceInfo() {
    mExtraCustomInfo = null;
  }

  @Override
  public String toString() {
    return "FaceInfo{"
        + "mExtraCustomInfo=" + Arrays.toString(mExtraCustomInfo) + '}';
  }
}
```
</details>

属性：
- `mExtraCustomInfo`：（可选）其他额外自定义信息。目前只支持字符串。

方法：
- `toString`：返回 `FaceInfo` 对象的字符串表示形式。

### MetaUserPositionInfo

用户的位置信息。

<details>
<summary>class MetaUserPositionInfo</summary>

```java
public class MetaUserPositionInfo {
  public float[] mPosition;
  public float[] mForward;
  public float[] mRight;
  public float[] mUp;

  @CalledByNative
  MetaUserPositionInfo(float[] position, float[] forward, float[] right, float[] up) {
    mPosition = position;
    mForward = forward;
    mRight = right;
    mUp = up;
  }

  @Override
  public String toString() {
    return "MetaUserPositionInfo{"
        + "mPosition=" + Arrays.toString(mPosition) + ", mForward=" + Arrays.toString(mForward)
        + ", mRight=" + Arrays.toString(mRight) + ", mUp=" + Arrays.toString(mUp) + '}';
  }
}
```
</details>

属性：
- `mPosition`：用户的坐标位置。
- `mForward`：用户朝向的三维向量。
- `mRight`：用户右手方向的向量。
- `mUp`：用户头朝向的向量。

方法：
- `toString`：返回 `MetaUserPositionInfo` 对象的字符串表示形式。
