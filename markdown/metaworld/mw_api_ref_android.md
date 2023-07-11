本文介绍声网 Meta SDK 的 Java API。

## 概述

Meta SDK 是基于声网视频 SDK 开发的元系列特殊版 SDK。相比[视频 SDK](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/rtc_api_overview_ng.html)，Meta SDK 中新增元系列相关的 API。

### 接口对象关系图

![](https://web-cdn.agora.io/docs-files/1686215859897)

## IMetaService

提供 Meta 服务的核心类。可用于获取场景资源列表、下载场景资源、删除本地场景资源等场景资源管理，还可用于创建 `IMetaScene`。

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

初始化 `IMetaService` 对象并登录声网 RTM 系统。


**参数**

`config`：初始化 `IMetaService` 对象需要的配置信息，详见 [`MetaServiceConfig`](#metaserviceconfig)。

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

### renewToken

```objective-c
public abstract int renewToken(String token);
```

更新 Token。

Token 有有效期，在过期前 SDK 会触发 [`onTokenWillExpire`](#ontokenwillexpire) 回调报告 Token 即将过期。此时，你需要在服务器生成新的 Token，然后调用 `renewToken` 并在参数里传入新 Token。


### getSceneAssetsInfo


```java
public abstract int getSceneAssetsInfo();
```

获取场景列表。

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

`sceneId`：场景场景的 ID，可以从 [`MetaSceneAssetsInfo`](#metasceneassetsinfo) 获取。

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

`sceneId`：场景资源的 ID，可以从 [`MetaSceneAssetsInfo`](#metasceneassetsinfo) 获取。

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

`sceneId`：场景资源的 ID，可以从 [`MetaSceneAssetsInfo`](#metasceneassetsinfo) 获取。

**返回值**

- 0：取消下载成功

- < 0：取消下载失败

### cleanSceneAssets

```java
public abstract int cleanSceneAssets(long sceneId);
```


**参数**

`sceneId`：场景资源的 ID，可以从 [`MetaSceneAssetsInfo`](#metasceneassetsinfo) 获取。

**返回值**

- 0：清理成功

- < 0：清理失败

### createScene


```java
public abstract int createScene(MetaSceneConfig config);
```

创建 `IMetaScene` 对象。

调用该方法会触发 `IMetaServiceEventHandler` 类的 [`onCreateSceneResult`](#oncreatesceneresult) 回调。成功创建的 `IMetaScene` 对象可以在该回调里拿到。

**参数**

`config`：创建 `IMetaScene` 对象需要的配置信息，详见 [`MetaSceneConfig`](#metasceneconfig)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

## IMetaScene

场景资源相关操作。

### release

```java
public abstract int release();
```

销毁 `IMetaScene` 对象。

调用该方法会触发 [`onReleasedScene`](#onreleasedscene) 回调。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### getLocalUserAvatar

```java
public abstract ILocalUserAvatar getLocalUserAvatar();
```

获取 `ILocalUserAvatar` 对象。

进入场景前，可以调用该方法获取用户的昵称、虚拟形象、装扮捏脸等信息。

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

成功调用该方法会触发 `IMetaSceneEventHandler` 类的 [`onEnterSceneResult`](#onentersceneresult) 回调。

**参数**

`config`：进入场景所需要的配置信息，详见 [`EnterSceneConfig`](#entersceneconfig)。


**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### leaveScene


```java
public abstract int leaveScene();
```

离开场景。

成功调用该方法会触发 `IMetaSceneEventHandler` 类的 [`onLeaveSceneResult`](#onleavesceneresult) 回调。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### sendSceneMessage


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

- `displayId`：指定显示器的 ID。该 ID 需要由你的 Native 开发人员和 Unity 开发人员协商后规定。
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

- `displayId`：指定显示器的 ID。ID 需要由你的 Native 开发人员和 Unity 开发人员协商后规定。
- `frame`：原始视频帧。详见 RTC SDK API 参考中的 [`AgoraVideoFrame`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/rtc_api_data_type.html#class_externalvideoframe)。

**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### addSceneView

```java
public abstract int addSceneView(TextureView view, SceneDisplayConfig config);
```

添加场景显示视图。

调用该方法在场景中添加一个视图，用于在频道内发布主播的 Avatar 形象。调用成功后，SDK 会触发 `IMetaSceneEventHandler` 协议的 [`onAddSceneViewResult`](onaddsceneviewresult) 回调。

**参数**

- `view`：视频视图。
- `config`：场景显示相关配置参数，[`SceneDisplayConfig`](#scenadiaplayconfig)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### removeSceneView

```java
public abstract int removeSceneView(TextureView view);
```

移除场景显示视图。

调用成功后，SDK 会触发 `IMetaSceneEventHandler` 类的 [`onRemoveSceneViewResult`](#onremovesceneviewresult) 回调。

**参数**

`view`：待移除的视图。


**返回值**

- 0：方法调用成功

- < 0：方法调用失败

### enableSceneVideoCapture

```java
public abstract int enableSceneVideoCapture(TextureView view, boolean enable);
```

开启或关闭场景渲染画面捕获。

该方法用于开启或关闭场景渲染画面捕获。通过与 `RtcEngine` 的 [`joinChannel` [2/2]](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_joinchannel2) 方法配合使用，可以将场景渲染的画面发布到 RTC 频道中。

**参数**

- `view`：需要捕获的场景视图。
- `enable`：是否开启场景渲染画面捕获。
  - `true`：开启。场景画面会发布到 RTC 频道中。
  - `false`：（默认）不开启。场景画面不会发不到 RTC 频道中。


**返回值**

- 0：方法调用成功
- < 0：方法调用失败



## ILocalUserAvatar

包含在 `IMetaScene` 中，生命周期和 `IMetaScene` 相同，用于设置虚拟形象（Avatar）。

### setUserInfo


```java
int setUserInfo(MetaUserInfo userInfo);
```

设置用户的基本信息。

**参数**

`userInfo`：在场景内展示的用户信息，详见 [`MetaUserInfo`](#metauserinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getUserInfo

```java
MetaUserInfo getUserInfo();
```
获取用户的基本信息。

**返回值**

[`MetaUserInfo`](#metauserinfo) 对象。

### setModelInfo


```java
int setModelInfo(AvatarModelInfo modelInfo);
```

设置用户的模型信息。


**参数**

`modelInfo`：用户的虚拟形象模型信息，详见 [`AvatarModelInfo`](#avatarmodelinfo)。

**返回值**

- 0：方法调用成功
- < 0：方法调用失败

### getModelInfo


```java
AvatarModelInfo getModelInfo();
```

获取当前使用的用户模型信息。

**返回值**

[`AvatarModelInfo`](#avatarmodelinfo) 对象。


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

`IMetaService` 的异步方法的事件回调类。

### onCreateSceneResult


```java
public void onCreateSceneResult(IMetaScene scene, int errorCode);
```

`IMetaScene` 创建回调。

**参数**

- `scene`：创建的 `IMetaScene` 对象，用于后续进出场景等操作。
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
  - `1`：断开连接。
  - `2`：正在连接。
  - `3`：连接成功。
  - `4`：正在重连。
  - `5`：连接丢弃。

- `reason`：连接状态改变的原因。

### onTokenWillExpire

```java
public void onTokenWillExpire();
```

Token 即将过期回调。

收到该回调后，你需要在服务器生成新的 Token，然后调用 [`renewToken`](#renewtoken) 并在参数里传入新 Token。

### onGetSceneAssetsInfoResult


```java
public void onGetSceneAssetsInfoResult(MetaSceneAssetsInfo[] metaSceneAssetsInfo, int errorCode);
```

获取场景资源列表回调。

**参数**

- `metaSceneAssetsInfo`：场景资源信息列表，详见 [`MetaSceneAssetsInfo`](#metasceneassetsinfo)。

- `errorCode`：错误码：
  - 0 表示获取列表成功。
  - 其余情况表示获取列表失败。

### onDownloadSceneAssetsProgress


```java
public void onDownloadSceneAssetsProgress(long sceneId, int progress, int state);
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

## IMetaSceneEventHandler

`IMetaScene` 的异步方法的事件回调类。

### onEnterSceneResult


```java
public void onEnterSceneResult(int errorCode);
```

进入场景的结果回调。


**参数**

`errorCode`：错误码：
- 0 表示进入场景成功。
- 其余情况进入场景失败。

### onLeaveSceneResult

```java
public void onLeaveSceneResult(int errorCode);
```

离开场景的结果回调。


**参数**

`errorCode`：错误码：
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

用户位置变化时，SDK 会触发该回调。

**参数**

- `uid`：本地或远端用户的用户 ID。
- `posInfo`：用户的位置信息，详见 [`MetaUserPositionInfo`](#metauserpositioninfo)。


### onReleasedScene


```java
void onReleasedScene(int status);
```

`IMetaScene` 释放回调。

**参数**

`status`：错误码：
- 0 表示释放 `IMetaScene` 成功。
- 其余情况释放 `IMetaScene` 失败。

### onAddSceneViewResult
```java
void onAddSceneViewResult(TextureView view, int errorCode);
```

添加场景显示视图回调。

调用 `IMetaScene` 类的 `addSceneView` 方法添加场景显示视图后，SDK 会触发该回调。

**参数**

- `view`：视图对象：`TextureView`。
- `errorCode`：错误码：
  - 0 表示添加视图成功。
  - 其余情况添加视图失败。

### onRemoveSceneViewResult

```java
void onRemoveSceneViewResult(TextureView view, int errorCode);
```

移除场景显示视图回调。

调用 `IMetaScene` 类的 `removeSceneView` 方法移除场景显示视图后，SDK 会触发该回调。

**参数**

- `view`：视图对象：`TextureView`。
- `errorCode`：错误码：
  - 0 表示移除视图成功。
  - 其余情况移除视图失败。


## 类型定义

### MetaServiceConfig

初始化 `IMetaService` 对象的配置信息。

```java
public class MetaServiceConfig {
  public RtcEngine mRtcEngine;
  public String mAppId;
  public String mRtmToken;
  public String mLocalDownloadPath;
  public String mUserId;
  public IMetaServiceEventHandler mEventHandler;
}
```

- `mRtcEngine`：`RtcEngine` 实例，创建方法详见 [`create` [1/2]](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_create)。
- `mAppId`：在声网控制台获取的 App ID。
- `mRtmToken` ：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。
- `mLocalDownloadPath` ：场景资源下载到本地的保存路径。
- `mUserId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `mEventHandler`：回调事件，详见 [`IMetaServiceEventHandler`](#imetaserviceeventhandler)。

### MetaUserInfo

用户信息。

```java
public class MetaUserInfo {
  public String mUserId;
  public String mUserName;
  public String mUserIconUrl;
}
```

- `mUserId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
  - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
  - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
  - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
- `mUserName`：用户昵称，用于在场景内显示用户昵称。
- `mUserIconUrl`：用户头像的 URL，用于在场景内显示用户头像。


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
  public MetaBundleInfo[] mBundles;
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
public class MetaBundleInfo {
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

- `mBundleId`：资源包 ID。不同平台（Android、iOS）的同一个资源包的 ID 是不同的。
- `mSceneId`：所属的场景资源 ID。
- `mBundleType`：资源包类型：
  - `1`：场景场景。
  - `2`：虚拟形象（Avatar）资源。
  - `3`：assetManifest 资源。
  - `100`：其他资源。
- `mBundleCode`：资源包代码，不同平台（Android、iOS）同一个资源包的代码要保持一致。
- `mBundleName`：资源包名称。
- `mDescription`：资源包描述。
- `mBundlePath`：资源包的本地存储路径。
- `mThumbnailPath`：资源包缩略图的本地存储路径。
- `mAssets`：预留参数。
- `mExtraInfo`：资源包的其它额外信息。
- `mBundleSize`：资源包大小。


### MetaSceneConfig

场景资源的配置信息。

```java
public class MetaSceneConfig {
  public int mSyncMode;
  public Context mActivityContext;
  public boolean mEnableFaceCapture;
  public String mFaceCaptureAppId;
  public String mFaceCaptureCertificate;
}
```

- `mSyncMode`：消息同步模式：
  - `STATE_SYNC_MODE_NONE(0)`：不同步消息。
  - `STATE_SYNC_MODE_NORMAL(1)`：（默认）通过 RTM 同步消息。
- `mActivityContext`：Activity 的 Context 对象，用于初始化 Unity。
- `mEnableFaceCapture`：是否开启面部捕捉：
  - `true`：开启。
  - `false`：（默认）不开启。
- `mFaceCaptureAppId`：开启面部捕捉时设置的 App ID。开启面捕时必填。
- `mFaceCaptureCertificate`：开启面部捕捉时设置的 Certificate（证书）。开启面捕时必填。

通过面捕 App ID 和 Certificate 可以获取对应的面捕证书（license）。开启面捕功能时，需要你设置面捕证书（license）。

### EnterSceneConfig

进入场景的配置信息。

```java
public class EnterSceneConfig {
  public String mRoomName;
  public TextureView mSceneView;
  public long mSceneId;
  public String mScenePath;
  public byte[] mExtraInfo;
}
```

- `mRoomName`：进入场景的房间名称。
- `mSceneView`：场景资源渲染所需要的视图。Android 上用原生的 [TextureView](https://developer.android.com/reference/android/view/TextureView) 对象即可。
- `mSceneId`：进入场景的 ID。
- `mScenePath`：（可选）`mSceneId` 为 0 时，表示从本地路径加载资源，此时，`mScenePath` 必须设为本地资源文件夹的路径。
- `mExtraInfo`：（可选）加载场景资源时需要的其它额外自定义信息。你可以自行定义，目前只支持字符串。


### AvatarModelInfo

用户的虚拟形象（Avatar）信息。

```java
public class AvatarModelInfo {
public String mBundleCode;
public boolean mLocalVisible;
public boolean mRemoteVisible;
public boolean mSyncPosition;
}
```

- `mBundleCode`：人物模型所在的资源包代码。
- `mLocalVisible`：虚拟人物模型是否在本地可见。如果设为 `false`，`mRemoteVisible` 和 `mSyncPosition` 会自动设为 `false`，并且无法更改。
- `mRemoteVisible`：虚拟人物模型是否在远端可见。
- `mSyncPosition`：是否同步本地人物渲染时所需要的信息（例如模型、装扮、捏脸信息等），用于控制玩家和游客模式。如果设为 `false`，`mRemoteVisible` 不生效。


### MetaUserPositionInfo

用户的位置信息。

```java
public class MetaUserPositionInfo {
  public float[] mPosition;
  public float[] mForward;
  public float[] mRight;
  public float[] mUp;
}
```

- `mPosition`：用户的坐标位置。
- `mForward`：用户朝向的三维向量。
- `mRight`：用户右手方向的向量。
- `mUp`：用户头朝向的向量。

### SceneDisplayConfig

场景显示相关配置。

```java
public class SceneDisplayConfig {
  public int width;
  public int height;
  public byte[] extraInfo;
}
```

- `width`：场景渲染画面的宽。
- `height`：场景渲染画面的高度。该宽高决定拿到场景渲染画面的原始视频帧的大小。如果要将画面发布到 RTC 频道中，建议将该宽高设置为与 RTC 的视频编码参数宽高一致，以避免缩放裁剪导致的性能损耗。
- `extraInfo`：Unity 渲染场景所需的额外信息，该字段是用户自定义的，一般由你的 Native 开发人员和 Unity 开发人员约定好。