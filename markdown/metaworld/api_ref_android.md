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

| 类  | 描述     |
| -------- | ------- |
| [IMetachatService](#imetachatservice)  | 房间和场景资源相关接口。     |
| [IMetachatScene](#imetachatscene)   | 场景操作相关接口。           |
| [ILocalUserAvatar](#ilocaluseravatar) | 本地用户的昵称、虚拟形象、装扮、捏脸相关接口。   |
| [IMetachatEventhandler](#imetachateventhandler)   | 房间和场景资源相关回调。 |
| [IMetachatSceneEventhandler](#imetachatsceneeventhandler) | 场景操作相关回调。       |

## IMetachatService

元语聊服务的基础类。

### create

创建 `IMetachatService` 对象。

```java
public static synchronized IMetachatService create();
```

**返回值**

`IMetachatService` 对象。

### initialize

初始化 `IMetachatService` 对象并登录声网 RTM 系统。

```java
public abstract int initialize(MetachatConfig config);
```

成功调用该方法会触发 `onConnectionStateChanged` 回调。

**参数**

  `config`：初始化 `IMetachatService` 对象需要的配置信息，详见 [MetachatConfig](#metachatconfig)。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。


### destroy

销毁 `IMetachatService` 对象。

```java
public static synchronized void destroy()
```

### addEventHandler

添加事件处理器对象。

```java
public abstract int addEventHandler(IMetachatEventHandler eventHandler);
```

**参数**
  `eventHandler`：`IMetachatEventHandler` 对象。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### removeEventHandler

移除事件处理器对象。

```java
public abstract int removeEventHandler(IMetachatEventHandler eventHandler);
```

**参数**
  `eventHandler`：`IMetachatEventHandler` 对象。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getSceneInfos

获取场景列表。

调用该方法会触发 [`onGetSceneInfosResult`](#ongetsceneinfosresult) 回调。

```java
public abstract int getSceneInfos();
```

**返回值**

- 0：方法调用成功
- <0：方法调用失败。


### isSceneDownloaded

查询本地是否已经下载指定场景。

```java
public abstract int isSceneDownloaded(long sceneId);
```

**参数**

  `sceneId`：场景的 ID，可以从 [MetachatSceneInfo](#metachatsceneinfo) 获取。

**返回值**

- 0：本地没有下载该场景。

- 1：本地已经下载该场景。

### downloadScene

下载场景到本地。

```java
public abstract int downloadScene(long sceneId);
```
调用该方法会触发 `onDownloadSceneProgress` 回调。

**参数**

  `sceneId`：场景的 ID，可以从 [MetachatSceneInfo](#metachatsceneinfo) 获取。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### cancelDownloadScene

取消下载场景到本地。

```java
public abstract int cancelDownloadScene(long sceneId);
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

```java
public abstract int cleanScene(long sceneId);
```
**参数**

  `sceneId`：场景的 ID，可以从 [MetachatSceneInfo](#metachatsceneinfo) 获取。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### createScene

创建 `IMetachatScene` 对象。

```java
public abstract int createScene(MetachatSceneConfig config);
```
调用该方法会触发 [onCreateSceneResult](#oncreatesceneresult) 回调，创建的 `IMetachatScene` 对象可以在该回调里拿到。

**参数**

  `config`：创建 `IMetachatScene` 对象需要的配置信息，详见 [MetachatSceneConfig](#metachatsceneconfig)。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

## IMetachatScene

场景相关操作。

### release

销毁 IMetachatScene 对象。

```java
public abstract int release();
```
调用该方法会触发 [onReleasedScene](#onreleasedscene) 回调。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### getLocalUserAvatar

进入场景前，可以调用该方法获取用户的昵称、虚拟形象、装扮捏脸等信息。

```java
public abstract ILocalUserAvatar getLocalUserAvatar();
```

**返回值**

`ILocalUserAvatar` 对象。


### addEventHandler

添加事件处理器对象。

```java
public abstract int addEventHandler(IMetachatSceneEventHandler eventHandler);
```

**参数**
  `eventHandler`：`IMetachatSceneEventHandler` 对象。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### removeEventHandler

移除事件处理器对象。

```java
public abstract int removeEventHandler(IMetachatSceneEventHandler eventHandler);
```

**参数**
  `eventHandler`：`IMetachatSceneEventHandler` 对象。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### enterScene

进入场景。

```java
public abstract int enterScene(EnterSceneConfig config);
```
成功调用该方法会触发 `onEnterSceneResult` 回调。

**参数**

 `config`：进入场景所需要的配置信息，详见 [EnterSceneConfig](#entersceneconfig)。


**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### leaveScene

离开场景。

```java
public abstract int leaveScene();
```
成功调用该方法会触发 `onLeaveSceneResult` 回调。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### sendMessageToScene

往场景发送自定义消息。

```java
public abstract int sendMessageToScene(byte[] message);
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

```java
public abstract int enableUserPositionNotification(boolean enable);
```
**参数**

  `enable`：是否开启用户位置信息通知：

- `true`：开启用户位置信息通知，即监听 `onUserPositionChanged` 事件。
- `false`：关闭用户位置信息通知，即不监听 `onUserPositionChanged` 事件。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### enumerateVideoDisplays

列举场景内所有显示器的 ID。

```java
public abstract int enumerateVideoDisplays();
```

调用该方法会触发 [onEnumerateVideoDisplaysResult](#onenumeratevideodisplaysresult) 回调。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### enableVideoDisplay

开启/关闭场景内指定的显示器。

```java
public abstract int enableVideoDisplay(String displayId, boolean enable);
```

**参数**

- `displayId`：指定显示器的 ID。
- `enable`：是否开启指定显示器：
  - `true`：开启显示器，即开始视频渲染。
  - `false`：关闭显示器，即关闭视频渲染。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

### pushVideoFrameToDisplay

往场景内指定的显示器推送原始视频帧。

```java
public abstract int pushVideoFrameToDisplay(String displayId, AgoraVideoFrame frame);
```

**参数**

- `displayId`：指定显示器的 ID。
- `frame`：视频帧。详见 RTC SDK 4.x API 参考中的 [AgoraVideoFrame](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/rtc_api_data_type.html#class_externalvideoframe)。

**返回值**

- 0：方法调用成功

- <0：方法调用失败。

## ILocalUserAvatar

### setUserInfo

设置用户的基本信息。

```java
int setUserInfo(MetachatUserInfo userInfo);
```

**参数**

 `userInfo`：在场景内展示的用户信息，详见 [MetachatUserInfo](#metachatuserinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getUserInfo

获取用户的基本信息。

```java
MetachatUserInfo getUserInfo();
```

**返回值**

[MetachatUserInfo](#metachatuserinfo) 对象。

### setModelInfo

设置用户的模型信息。

```java
int setModelInfo(AvatarModelInfo modelInfo);
```

**参数**

 `modelInfo`：用户的虚拟形象模型信息，详见 [AvatarModelInfo](#avatarmodelinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getModelInfo

获取用户的模型信息。

```java
AvatarModelInfo getModelInfo();
```

**返回值**

[AvatarModelInfo](#avatarmodelinfo) 对象。

### setDressInfo

设置用户的装扮信息。

```java
int setDressInfo(DressInfo dressInfo);
```

**参数**

 `dressInfo`：用户的装扮信息，详见 [DressInfo](#dressinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getDressInfo

获取用户的装扮信息。

```java
DressInfo getDressInfo();
```

**返回值**

[DressInfo](#dressinfo) 对象。

### setFaceInfo
设置用户的捏脸信息。

```java
int setFaceInfo(FaceInfo faceInfo);
```

**参数**

 `faceInfo`：本地用户的捏脸信息，详见 [FaceInfo](#faceinfo)。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getFaceInfo

获取用户的捏脸信息。

```java
FaceInfo getFaceInfo();
```

**返回值**

[FaceInfo](#faceinfo) 对象。

### setExtraCustomInfo

设置自定义的用户信息。

```java
int setExtraCustomInfo(byte[] extraCustomInfo);
```

**参数**

 `extraCustomInfo`：自定义的用户信息。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

### getExtraCustomInfo

获取自定义的用户信息。

```java
byte[] getExtraCustomInfo();
```

**返回值**

自定义的用户信息。

### applyInfo

应用新设置的用户信息。

```java
int applyInfo();
```

- 如果你在进入场景前调用 `setUserInfo`、`setModelInfo`、`setDressInfo`、`setFaceInfo` 或 `setExtraCustomInfo` 方法，则不需要调用 `applyInfo`。
- 如果你在进入场景后调用了 `setUserInfo`、`setModelInfo`、`setDressInfo`、`setFaceInfo` 或 `setExtraCustomInfo` 方法，必须再调用 `applyInfo` 让设置的信息生效。

**返回值**

- 0：方法调用成功
- <0：方法调用失败。

## IMetachatEventHandler

`IMetaChatService` 类的回调。

### onCreateSceneResult

创建 `IMetachatScene` 对象的状态回调。

```java
public void onCreateSceneResult(IMetachatScene scene, int errorCode);
```
**参数**

- `scene`：创建的 `IMetachatScene` 对象，用于后续进出场景等操作。
- `errorCode`：错误码。0 表示创建成功。

### onConnectionStateChanged

连接状态改变回调。

```java
public void onConnectionStateChanged(int state, int reason);
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

```java
public void onRequestToken();
```

### onGetSceneInfosResult

获取场景列表回调。

```java
public void onGetSceneInfosResult(MetachatSceneInfo[] sceneInfos, int errorCode);
```
**参数**

- `sceneInfos`：场景信息列表，详见 [MetachatSceneInfo](#metachatsceneinfo)。

- `errorCode`：错误码。0 表示获取场景列表成功。

### onDownloadSceneProgress

下载场景进度回调。

```java
public void onDownloadSceneProgress(long sceneId, int progress, int state);
```
**参数**

- `sceneId`：场景 ID。

- `progress`：下载进度，取值范围 [0,100]。

- `state`：下载状态：
  - 0：空闲。
  - 1：正在下载。
  - 2：下载完成。
  - 3：下载失败。

## IMetachatSceneEventHandler

`IMetachatScene` 类的回调。

### onEnterSceneResult

进入场景回调。

```java
public void onEnterSceneResult(int errorCode);
```
**参数**

 `errorCode`：0 表示进入房间成功，其它表示失败。

### onLeaveSceneResult

离开场景回调。

```java
public void onLeaveSceneResult(int errorCode);
```
**参数**

 `errorCode`：0 表示进入房间成功，其它表示失败。

### onRecvMessageFromScene

App 收到 Unity 发送的自定义信息时，该回调被触发。

```java
public void onRecvMessageFromScene(byte[] message);
```
**参数**

 `message`：自定义消息。目前只支持字符串。

### onUserPositionChanged

本地或远端用户位置变化回调。

```java
public void onUserPositionChanged(String uid, MetachatUserPositionInfo posInfo);
```
**参数**

- `uid`：本地或远端用户的用户 ID。
- `posInfo`：用户的位置信息，详见 [MetachatUserPositionInfo](#metachatuserpositioninfo)。

### onEnumerateVideoDisplaysResult

列举场景内所有显示器的回调。

```java
public void onEnumerateVideoDisplaysResult(String[] displayIds);
```
**参数**

 `displayIds`：当前场景内所有显示器 ID 组成的列表。

### onReleasedScene

销毁 `IMetachatScene` 对象的回调。

```java
void onReleasedScene(int status);
```
**参数**

 `status`：错误码，0 表示销毁成功。



## 类型定义

### MetachatConfig

初始化 `IMetachatService` 对象的配置信息。

<details>
<summary>class MetachatConfig</summary>

```java
public class MetachatConfig {
  public RtcEngine mRtcEngine;
  public String mAppId;
  public String mRtmToken;
  public String mLocalDownloadPath;
  public String mUserId;
  public IMetachatEventHandler mEventHandler;

  public MetachatConfig() {
    mRtcEngine = null;
    mAppId = "";
    mRtmToken = "";
    mLocalDownloadPath = "";
    mUserId = "";
    mEventHandler = null;
  }

  @Override
  public String toString() {
    return "MetachatConfig{"
        + "mRtcEngine=" + mRtcEngine + ", mAppId='" + mAppId + '\'' + ", mRtmToken='" + mRtmToken
        + '\'' + ", mLocalDownloadPath='" + mLocalDownloadPath + '\'' + ", mUserId='" + mUserId
        + '\'' + ", mEventHandler=" + mEventHandler + '}';
  }
}
```
</details>

属性：
- `mRtcEngine`：`RtcEngine` 实例，创建方法详见 [create [1/2]](https://docs.agora.io/cn/video-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_create)。
- `mAppId`：在声网控制台获取的 App ID。
- `mRtmToken` ：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。集成及测试阶段请将 `Token` 设置为 `null`。
- `mLocalDownloadPath` ：场景资源下载到本地的保存路径。
- `mUserId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `mEventHandler`：回调事件，详见 [IMetachatEventHandler](#imetachateventhandler)。

方法：
- `toString`：返回 `MetachatConfig` 对象的字符串表示形式。


### MetachatUserInfo

用户信息。

<details>
<summary>class MetachatUserInfo</summary>

```java
public class MetachatUserInfo {
  public String mUserId;
  public String mUserName;
  public String mUserIconUrl;
  public byte[] mExtraCustomInfo;

  @CalledByNative
  public MetachatUserInfo(
      String mUserId, String mUserName, String mUserIconUrl, byte[] mExtraCustomInfo) {
    this.mUserId = mUserId;
    this.mUserName = mUserName;
    this.mUserIconUrl = mUserIconUrl;
    this.mExtraCustomInfo = mExtraCustomInfo;
  }

  public MetachatUserInfo() {
    mUserId = "";
    mUserName = "";
    mUserIconUrl = "";
    mExtraCustomInfo = null;
  }

  @Override
  public String toString() {
    return "MetachatUserInfo{"
        + "mUserId='" + mUserId + '\'' + ", mUserName='" + mUserName + '\'' + ", mUserIconUrl='"
        + mUserIconUrl + '\'' + ", mExtraCustomInfo=" + Arrays.toString(mExtraCustomInfo) + '}';
  }
}
```
</details>

属性：
- `mUserId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `mUserName`：用户昵称，用于在场景内显示用户昵称。
- `mUserIconUrl`：用户头像的 URL，用于在场景内显示用户头像。
- `mExtraCustomInfo`：自定义的用户信息。目前只支持字符串。

方法：
- `toString`：返回 `MetachatUserInfo` 对象的字符串表示形式。

### MetachatSceneInfo

场景信息。

<details>
<summary>class MetachatSceneInfo</summary>

```java
public class MetachatSceneInfo {
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

  public MetachatSceneInfo() {
    mSceneId = 0;
    mSceneName = "";
    mThumbnailPath = "";
    mScenePath = "";
    mParentScenePath = "";
    mDescription = "";
    mSceneConfig = "";
    mExtraInfo = "";
    mBundles = new MetachatBundleInfo[] {};
    mSceneVersion = "";
    mSceneLocalVersion = "";
    mTotalSize = 0;
  }

  @CalledByNative
  public MetachatSceneInfo(long sceneId, String sceneName, String thumbnailPath, String scenePath,
      String parentScenePath, String description, String sceneConfig, String extraInfo,
      MetachatBundleInfo[] bundles, String sceneVersion, String sceneLocalVersion, long totalSize) {
    mSceneId = sceneId;
    mSceneName = sceneName;
    mThumbnailPath = thumbnailPath;
    mScenePath = scenePath;
    mParentScenePath = parentScenePath;
    mDescription = description;
    mSceneConfig = sceneConfig;
    mExtraInfo = extraInfo;
    mBundles = bundles;
    mSceneVersion = sceneVersion;
    mSceneLocalVersion = sceneLocalVersion;
    mTotalSize = totalSize;
  }

  @Override
  public String toString() {
    return "MetachatSceneInfo{"
        + "mSceneId=" + mSceneId + ", mSceneName='" + mSceneName + '\'' + ", mThumbnailPath='"
        + mThumbnailPath + '\'' + ", mScenePath='" + mScenePath + '\'' + ", mParentScenePath='"
        + mParentScenePath + '\'' + ", mDescription='" + mDescription + '\'' + ", mSceneConfig='"
        + mSceneConfig + '\'' + ", mExtraInfo='" + mExtraInfo + '\''
        + ", mBundles=" + Arrays.toString(mBundles) + ", mSceneVersion='" + mSceneVersion + '\''
        + ", mSceneLocalVersion='" + mSceneLocalVersion + '\'' + ", mTotalSize=" + mTotalSize + '}';
  }
}
```
</details>

属性：
- `mSceneId`：场景的唯一标识符。
- `mSceneName`：场景名称。
- `mThumbnailPath`：场景缩略图的本地路径。
- `mScenePath`：场景资源的本地路径。
- `mParentScenePath`：依赖的父场景资源的本地路径。
- `mDescription`：场景的文字描述。
- `mSceneConfig`：场景的配置信息。
- `mExtraInfo`：其它额外信息。
- `mBundles`：场景支持的资源包列表。
- `mSceneVersion`：场景资源在服务器上的版本号。
- `mSceneLocalVersion`：场景资源在本地的版本号。
- `mTotalSize`：场景资源包总大小。

方法：
- `toString`：返回 `MetachatSceneInfo` 对象的字符串表示形式。

### MetachatBundleInfo

资源包信息。

<details>
<summary>class MetachatBundleInfo</summary>

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

  public MetachatBundleInfo() {
    mBundleId = 0;
    mSceneId = 0;
    mBundleType = 1;
    mBundleCode = "";
    mBundleName = "";
    mDescription = "";
    mBundlePath = "";
    mThumbnailPath = "";
    mAssets = "";
    mExtraInfo = "";
    mBundleSize = 0;
  }

  @CalledByNative
  public MetachatBundleInfo(long bundleId, long sceneId, int bundleType, String bundleCode,
      String bundleName, String descript, String bundlePath, String thumbnailPath, String assets,
      String extraInfo, long bundleSize) {
    mBundleId = bundleId;
    mSceneId = sceneId;
    mBundleType = bundleType;
    mBundleCode = bundleCode;
    mBundleName = bundleName;
    mDescription = descript;
    mBundlePath = bundlePath;
    mThumbnailPath = thumbnailPath;
    mAssets = assets;
    mExtraInfo = extraInfo;
    mBundleSize = bundleSize;
  }

  @Override
  public String toString() {
    return "MetachatBundleInfo{"
        + "mBundleId=" + mBundleId + ", mSceneId=" + mSceneId + ", mBundleType=" + mBundleType
        + ", mBundleCode='" + mBundleCode + '\'' + ", mBundleName='" + mBundleName + '\''
        + ", mDescription='" + mDescription + '\'' + ", mBundlePath='" + mBundlePath + '\''
        + ", mThumbnailPath='" + mThumbnailPath + '\'' + ", mAssets='" + mAssets + '\''
        + ", mExtraInfo='" + mExtraInfo + '\'' + ", mBundleSize=" + mBundleSize + '}';
  }

  public static class BundleType {
    private BundleType() {}

    public static final int BUNDLE_TYPE_SCENE = 1;
    public static final int BUNDLE_TYPE_AVATAR = 2;
    public static final int BUNDLE_TYPE_ASSET_MANIFEST = 3;
    public static final int BUNDLE_TYPE_OTHER = 100;
  }
}
```
</details>

属性：
- `mBundleId`：资源包 ID，不同平台（Android、iOS）同一个资源包的ID 不同。
- `mSceneId`：所属的场景 ID。
- `mBundleType`：资源包类型：
  - 1：场景资源。
  - 2：虚拟形象（avatar）avatar 资源。
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

场景的配置信息。

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

进入场景的配置信息。

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
- `mRoomName`：进入场景的房间名称。
- `mSceneView`：场景渲染所需要的视图。Android 上用原生的 [TextureView](https://developer.android.com/reference/android/view/TextureView) 对象即可。
- `mSceneId`：进入场景的 ID。
- `mExtraCustomInfo`：（可选）加载场景时需要的其它额外自定义信息。你可以自行定义，目前只支持字符串。

方法：
- `toString`：返回 `EnterSceneConfig` 对象的字符串表示形式。

### AvatarModelInfo

用户的虚拟形象信息。

<details>
<summary>class AvatarModelInfo</summary>

```java
public class AvatarModelInfo {
  public String mBundleCode;
  public boolean mLocalVisible;
  public boolean mRemoteVisible;
  public boolean mSyncPosition;
  public byte[] mExtraCustomInfo;

  @CalledByNative
  public AvatarModelInfo(String bundleCode, boolean localVisible, boolean remoteVisible,
      boolean syncPosition, byte[] extraCustomInfo) {
    this.mBundleCode = bundleCode;
    this.mLocalVisible = localVisible;
    this.mRemoteVisible = remoteVisible;
    this.mSyncPosition = syncPosition;
    this.mExtraCustomInfo = extraCustomInfo;
  }

  public AvatarModelInfo() {
    mBundleCode = "";
    mLocalVisible = false;
    mRemoteVisible = false;
    mSyncPosition = false;
    mExtraCustomInfo = null;
  }

  @Override
  public String toString() {
    return "AvatarModelInfo{"
        + "mBundleCode='" + mBundleCode + '\'' + ", mLocalVisible=" + mLocalVisible
        + ", mRemoteVisible=" + mRemoteVisible + ", mSyncPosition=" + mSyncPosition
        + ", mExtraCustomInfo=" + Arrays.toString(mExtraCustomInfo) + '}';
  }
}
```
</details>

属性：
- `mBundleCode`：人物模型所在的资源包代码。
- `mLocalVisible`：虚拟人物在本地是否显示。如果设为 `false`，`mRemoteVisible` 和 `mSyncPosition` 会自动设为 `false`，并且无法更改。
- `mRemoteVisible`：虚拟人物在远端是否可见。
- `mSyncPosition`：是否同步本地用户的位置，用于控制玩家和游客模式。如果设为 `false``，`mRemoteVisible`  不生效。
- `mExtraCustomInfo`：（可选）其他额外自定义信息。目前只支持字符串。

方法：
- `toString`：返回 `AvatarModelInfo` 对象的字符串表示形式。

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

### MetachatUserPositionInfo

用户的位置信息。

<details>
<summary>class MetachatUserPositionInfo</summary>

```java
public class MetachatUserPositionInfo {
  public float[] mPosition;
  public float[] mForward;
  public float[] mRight;
  public float[] mUp;

  @CalledByNative
  MetachatUserPositionInfo(float[] position, float[] forward, float[] right, float[] up) {
    mPosition = position;
    mForward = forward;
    mRight = right;
    mUp = up;
  }

  @Override
  public String toString() {
    return "MetachatUserPositionInfo{"
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
- `toString`：返回 `MetachatUserPositionInfo` 对象的字符串表示形式。
