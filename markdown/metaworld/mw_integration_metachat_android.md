MetaWorld 解决方案支持元语聊、元直播场景。本文介绍如何实现元语聊。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 示例项目供你参考。

如果你还需了解 Unity 部分的工程文件和功能指南，请联系 [sales@agora.io](mailto:sales@agora.io) 获取。

## 实现元语聊

完成[集成声网 Meta SDK](./mw_integrate_sdk_android) 后，你可以参考本节实现元语聊。

下图展示实现元语聊的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1687943303371)

实现步骤需用到如下类：

- `RtcEngine` 类：提供实时音视频功能的核心类。
- `IMetaService` 类：提供 Meta 服务的核心类。可用于获取场景资源列表、下载场景资源、删除本地场景资源等场景资源管理，还可用于创建 `IMetaScene`。
- `IMetaScene` 类：场景资源相关操作。
- `ILocalUserAvatar` 类：包含在 `IMetaScene` 中，生命周期和 `IMetaScene` 相同，用于设置虚拟形象（Avatar）。
- `IMetaServiceEventHandler` 类：`IMetaService` 的异步方法的事件回调类。
- `IMetaSceneEventHandler` 类：`IMetaScene` 的异步方法的事件回调类。


### 1. 创建并初始化 IMetaService

调用 [`create`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_create) 创建 `RtcEngine`。调用 `IMetaService` 类的 [`create`](./mw_api_ref_android?platform=All%20Platforms#create) 和 [`initialize`](./mw_api_ref_android?platform=All%20Platforms#initialize) 创建并初始化 `IMetaService`。

初始化 `IMetaService` 时，需要在 `MetaServiceConfig` 里设置如下重要的字段：
- `mRtcEngine`：通过 `create` 方法创建的 `RtcEngine` 实例。
- `mAppId`：在声网控制台获取的 App ID。详见[集成声网 Meta SDK](./mw_integrate_sdk_android)。
- `mUserId`：登录声网 RTM 系统的用户 ID。推荐取值详见 [API 参考](./mw_api_ref_android?platform=All%20Platforms#metaserviceconfig)。
- `mRtmToken`：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。详见[生成 Token](https://docportal.shengwang.cn/cn/Real-time-Messaging/messaging_android?platform=Android#4-生成-token)。
- `mLocalDownloadPath`：场景资源下载到本地的保存路径。
- `mEventHandler`：`IMetaService` 的回调事件句柄。

声网项目有两种 Token 和 UID，请不要搞混淆：
- RTC UID：用于在实时音视频通讯中标志用户身份的用户 ID。推荐取值详见 [joinChannel 的参数解释](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_joinchannel2)。
- RTM UID：用于在云信令系统中标志用户身份的用户 ID。推荐取值详见 [MetaServiceConfig 的字段解释](./mw_api_ref_android?platform=All%20Platforms#metaserviceconfig)。
- RTC Token：用于保障实时音视频通讯安全的动态密钥。详见[如何生成 RTC Token 进行鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)。
- RTM Token：用于保障云信令系统安全的动态密钥。详见[如何生成 RTM Token 进行鉴权](https://docportal.shengwang.cn/cn/Real-time-Messaging/token2_server_rtm?platform=All%20Platforms)。


```java
// 设置 RtcEngine 配置
RtcEngineConfig rtcConfig = new RtcEngineConfig();
rtcConfig.mContext = context;
// 声网项目的 App ID，从控制台获取
rtcConfig.mAppId = KeyCenter.APP_ID;
rtcConfig.mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
// 监听 RTC 引擎回调事件
rtcConfig.mEventHandler = new IRtcEngineEventHandler() {
    @Override
    public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
        Log.d(TAG, String.format("onJoinChannelSuccess %s %d", channel, uid));
    }

    @Override
    public void onUserOffline(int uid, int reason) {
        Log.d(TAG, String.format("onUserOffline %d %d ", uid, reason));
    }

    @Override
    public void onAudioRouteChanged(int routing) {
        Log.d(TAG, String.format("onAudioRouteChanged %d", routing));
    }

    @Override
    public void onUserJoined(int uid, int elapsed) {
        Log.d(TAG, "onUserJoined uid=" + uid);
    }

    @Override
    public void onFirstRemoteVideoDecoded(int uid, int width, int height, int elapsed) {
        Log.d(TAG, "onFirstRemoteVideoDecoded uid=" + uid + ",width=" + width + ",heigh=" + height + ",elapsed=" + elapsed);
    }
};
rtcConfig.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.DEFAULT);

// 创建 RtcEngine
rtcEngine = RtcEngine.create(rtcConfig);
rtcEngine.setParameters("{\"rtc.enable_debug_log\":true}");

// 开启音视频模块并设置音频属性和路由
rtcEngine.enableAudio();
rtcEngine.enableVideo();
rtcEngine.setAudioProfile(
        Constants.AUDIO_PROFILE_DEFAULT, Constants.AUDIO_SCENARIO_GAME_STREAMING
);
rtcEngine.setDefaultAudioRoutetoSpeakerphone(true);

// 设置场景资源的下载路径
scenePath = context.getExternalFilesDir("").getPath();
{
   // 创建 IMetaService
    metaService = IMetaService.create();

    MetaServiceConfig config = new MetaServiceConfig() {{
        // RtcEngine 实例
        mRtcEngine = rtcEngine;
        // 声网项目的 App ID，从控制台获取
        mAppId = KeyCenter.APP_ID;
        // 声网 RTM（云信令）Token，保障安全
        // 声网项目有 RTC Token 和 RTM Token，不要搞混淆
        mRtmToken = KeyCenter.RTM_TOKEN;
        mLocalDownloadPath = scenePath;
        // 声网 RTM（云信令）UID，用户 ID，标志用户身份
        // 声网项目有 RTC UID 和 RTM UID，不要搞混淆
        mUserId = KeyCenter.RTM_UID;
        mEventHandler = MetaContext.this;
    }};
    // 初始化 IMetaService
    ret += metaService.initialize(config);
    Log.i(TAG, "launcher version=" + metaService.getLauncherVersion(context));
}
```


### 2. 下载场景资源

调用 `IMetaService` 类的 [`getSceneAssetsInfo`](./mw_api_ref_android?platform=All%20Platforms#getsceneassetsinfo) 获取场景资源，并通过 `IMetaServiceEventHandler` 类的 [`onGetSceneAssetsInfoResult`](./mw_api_ref_android?platform=All%20Platforms#ongetsceneassetsinforesult) 回调监听获取场景资源时的事件。

调用 `IMetaService` 类的 [`downloadScene`](./mw_api_ref_android?platform=All%20Platforms#downloadscene) 获取场景资源，并通过 `IMetaServiceEventHandler` 类的 [`onDownloadSceneAssetsProgress`](./mw_api_ref_android?platform=All%20Platforms#ondownloadsceneassetsprogress) 回调监听获取场景资源时的事件。

```java
// 获取场景资源
public boolean getSceneInfos() {
    return metaService.getSceneAssetsInfo() == Constants.ERR_OK;
}

// 监听获取场景资源的回调事件
@Override
public void onGetSceneAssetsInfoResult(MetaSceneAssetsInfo[] metaSceneAssetsInfos, int errorCode) {
}

// 下载场景资源
public boolean downloadScene(MetaSceneAssetsInfo sceneInfo) {
    return metaService.downloadSceneAssets(sceneInfo.mSceneId) == Constants.ERR_OK;
}

// 监听下载场景资源的回调事件
@Override
public void onDownloadSceneAssetsProgress(long sceneId, int progress, int state) {
}
```

### 3. 创建 IMetaScene

调用 [`createScene`](./mw_api_ref_android?platform=All%20Platforms#createscene) 创建 `IMetaScene`，并在 `sceneConfig` 中设置场景配置信息。通过 `IMetaServiceEventHandler` 类的 [`onCreateSceneResult`](./mw_api_ref_android?platform=All%20Platforms#oncreatesceneresult) 和 [`onConnectionStateChanged`](./mw_api_ref_android?platform=All%20Platforms#onconnectionstatechanged) 回调监听创建场景和连接状态的事件。

```java
// 设置场景配置信息
MetaSceneConfig sceneConfig = new MetaSceneConfig();
sceneConfig.mActivityContext = activityContext;
// 设置是否开启面部捕捉
// 元语聊场景无需开启面部捕捉
sceneConfig.mEnableFaceCapture = false;
// 传入面部捕捉插件的 App ID 和 Certificate
// 仅开启面部捕捉时才需要传值
sceneConfig.mFaceCaptureAppId = KeyCenter.FACE_CAP_APP_ID;
sceneConfig.mFaceCaptureCertificate = KeyCenter.FACE_CAP_APP_KEY;
int ret = -1;
if (metaScene == null) {
    // 创建场景
    ret = metaService.createScene(sceneConfig);
}

// 监听创建场景的回调事件
@Override
public void onCreateSceneResult(IMetaScene scene, int errorCode) {
    Log.i(TAG, "onCreateSceneResult errorCode: " + errorCode);
    metaScene = scene;
    // 获取 `ILocalUserAvatar` 对象
    localUserAvatar = metaScene.getLocalUserAvatar();
}

// 监听连接状态
@Override
public void onConnectionStateChanged(int state, int reason) {
    Log.d(TAG, "onConnectionStateChanged state=" + state + ",reason=" + reason);
    if (state == ConnectionState.META_CONNECTION_STATE_ABORTED) {
        setCurrentScene(MetaConstants.SCENE_NONE);
        resetRoleInfo();
        leaveScene();
    }
}
```

### 4. 设置用户信息并进入场景

要完成进入场景的操作，参考如下步骤：
1. 调用 [`setUserInfo`](./mw_api_ref_android?platform=All%20Platforms#setuserinfo) 和 [`setModelInfo`](./mw_api_ref_android?platform=All%20Platforms#setmodelinfo) 设置用户的基本信息和虚拟形象（Avatar）的模型信息。
2. 调用 `IMetaScene` 类的 [`addEventHandler`](./mw_api_ref_android?platform=All%20Platforms#addeventhandler-1) 添加事件句柄，监听 `IMetaScene` 的事件回调。
3. 调用 [`enterScene`](./mw_api_ref_android?platform=All%20Platforms#enterscene) 进入场景，并通过 `config` 设置配置信息。
4. 通过 `IMetaSceneEventHandler` 类的 [`onEnterSceneResult`](./mw_api_ref_android?platform=All%20Platforms#onentersceneresult) 回调监听进入场景的结果。

```java
public void enterScene() {
   if (null != localUserAvatar) {
        // 设置用户的基本信息
        localUserAvatar.setUserInfo(userInfo);
        // 设置用户的虚拟形象模型信息
        // 模型信息的 mBundleType 需设为 2(BUNDLE_TYPE_AVATAR)
        localUserAvatar.setModelInfo(modelInfo);
    }
    if (null != metaScene) {
        // 监听 IMetaScene 的事件回调
        metaScene.addEventHandler(MetaContext.getInstance());
        // 设置进入场景时的配置信息
        EnterSceneConfig config = new EnterSceneConfig();
        // 场景资源渲染时所需要的视图，Android 上使用原生 TextureView
        config.mSceneView = this.sceneView;
        // 进入场景的房间名称
        config.mRoomName = KeyCenter.CHANNEL_ID;
        // 内容中心对应的 ID
        if (null != sceneInfo) {
            config.mSceneId = this.sceneInfo.mSceneId;
        }
        // 设置进入场景的 ID 和加载场景资源的路径
        if (isEnableLocalSceneRes) {
            config.mSceneId = 0;
            config.mScenePath = scenePath + "/" + getSceneId();
        }
        /*
         * 仅为示例格式，具体格式以项目实际为准
         *   "extraInfo":{
         *     "sceneIndex":0  // 0 为默认场景，在这里指咖啡厅
         *   }
         */
        EnterSceneExtraInfo extraInfo = new EnterSceneExtraInfo();
        extraInfo.setSceneIndex(MetaConstants.SCENE_GAME);

        // 设置加载场景资源时需要的额外自定义信息，只支持字符串
        // 在这里指设置 sceneIndex
        // 在业务逻辑中包含多个场景的情况下，你可以用 sceneIndex 来区分不同的场景，Unity 场景脚本可以根据 sceneIndex 来确定进入哪个场景，并执行相应的逻辑
        config.mExtraInfo = JSONObject.toJSONString(extraInfo).getBytes();
        // 进入场景
        metaScene.enterScene(config);
    }
}

// 监听进入场景的回调事件
@Override
public void onEnterSceneResult(int errorCode) {
    Log.d(TAG, String.format("onEnterSceneResult %d", errorCode));
}
```

### 5. 离开场景并释放资源

离开场景时，参考如下步骤：
1. 调用 [`leaveScene`](./mw_api_ref_android?platform=All%20Platforms#leavescene) 离开场景。
2. 通过 `IMetaSceneEventHandler` 类的 [`onLeaveSceneResult`](./mw_api_ref_android?platform=All%20Platforms#onleavesceneresult) 回调得知成功离开场景后，调用 [`release`](./mw_api_ref_android?platform=All%20Platforms#release) 释放 `IMetaScene`。
3. 通过 `IMetaSceneEventHandler` 类的 [`onReleasedScene`](./mw_api_ref_android?platform=All%20Platforms#onreleasedscene) 回调监听 `IMetaScene` 是否释放成功。
4. 依次调用 `IMetaService` 和 `RtcEngine` 类的 `destroy` 方法销毁 `IMetaService` 和 `RtcEngine`。

```java
// 离开场景
private void leaveScene() {
    if (metaScene != null) {
        metaScene.leaveScene();
    }
}

// 监听离开场景的回调事件
@Override
public void onLeaveSceneResult(int errorCode) {
    Log.d(TAG, String.format("onLeaveSceneResult %d", errorCode));
    if (errorCode == 0) {
        // 释放 IMetaScene
        metaScene.release();
        metaScene = null;
    }
}

// 监听释放 IMetaScene 的回调事件
@Override
public void onReleasedScene(int status) {
    Log.d(TAG, String.format("[meta] onReleasedScene %d", status));
    destroy();
}

// 销毁 IMetaService 和 RtcEngine
public void destroy() {
    IMetaService.destroy();
    metaService = null;
    RtcEngine.destroy();
    rtcEngine = null;
}
```

## 参考信息

### 开发注意事项

在使用 3D 场景的过程中，需要注意以下几点：

- 为了保持场景的连续性和流畅性，通常不能销毁 Activity。为了避免销毁场景所在的 Activity，可以使用 `Intent.FLAG_ACTIVITY_REORDER_TO_FRONT` 标志将 Activity 置于后台。
- 由于 Texture 的数据是在 GPU 中处理的，因此不能在运行时被销毁或重新创建，否则会影响应用程序的性能和稳定性。如果 Texture 尺寸大小发生变化，例如切换场景时需要切换横竖屏，你需要在 `setSurfaceTextureListener` 的回调方法 `onSurfaceTextureSizeChanged` 中再次调用 `createScene` 和 `enterScene` 等方法，重新创建和进入场景。