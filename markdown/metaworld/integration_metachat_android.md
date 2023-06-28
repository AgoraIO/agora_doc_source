MetaWorld 解决方案支持元语聊、元直播场景。本文介绍如何实现元语聊。

## 示例项目

#TODO add

## 准备开发环境

参考[集成声网 Meta SDK](./integrate_sdk_android) 准备开发环境。

## 实现元语聊

本节介绍集成 Meta SDK 后如何实现元语聊。

实现元语聊会用到以下接口类：

- `RtcEngine` 类：提供实时音视频功能的核心类。
- `IMetaService` 类：提供 Meta 服务的核心类。用于创建 `IMetaScene` 对象，负责获取、下载和删除场景资源。
- `IMetaScene` 类：提供 Meta 场景的核心类。负责进出场景、场景视频渲染、场景相关参数设置等场景相关操作。
- `ILocalUserAvatar` 类：用于设置用户昵称、徽章、Avatar 模型、捏脸换装等详细信息。
- `IMetaServiceEventHandler` 类：`IMetaService` 的异步方法的事件回调类。
- `IMetaSceneEventHandler` 类：`IMetaScene` 的异步方法的事件回调类。

下图展示实现元语聊的 API 时序：

<pic> #TODO

### 1. 创建并初始化 IMetaService

调用 RtcEngine 类的 create 创建 RtcEngine。调用 IMetaService 类的 create 和 initialize 创建并初始化 IMetaService。


```java
// 设置 RtcEngine 配置
RtcEngineConfig rtcConfig = new RtcEngineConfig();
rtcConfig.mContext = context;
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
        mRtcEngine = rtcEngine;
        mAppId = KeyCenter.APP_ID;
        mRtmToken = KeyCenter.RTM_TOKEN;
        mLocalDownloadPath = scenePath;
        mUserId = KeyCenter.RTM_UID;
        mEventHandler = MetaContext.this;
    }};
    // 初始化 IMetaService
    ret += metaService.initialize(config);
    Log.i(TAG, "launcher version=" + metaService.getLauncherVersion(context));
}
```


### 2. 下载场景资源

调用 IMetaService 类的 getSceneAssetsInfo 获取场景资源，并通过 IMetaServiceEventHandler 类的 onGetSceneAssetsInfoResult 回调监听获取场景资源时的事件。

调用 IMetaService 类的 downloadScene 获取场景资源，并通过 IMetaServiceEventHandler 类的 onDownloadSceneAssetsProgress 回调监听获取场景资源时的事件。

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

调用 createScene 创建 IMetaScene，并在 sceneConfig 中设置场景配置信息。通过 IMetaServiceEventHandler 类的onCreateSceneResult 和 onConnectionStateChanged 回调监听创建场景和连接状态的事件。

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

### 4. 设置用户信息并进入场景 #TODO 换装捏脸

依次调用 setUserInfo 和 setModelInfo 设置用户的基本信息和虚拟形象（Avatar）的模型信息。调用 IMetaScene 类的 addEventHandler 添加事件句柄，监听 IMetaScene 的事件回调。调用 enterScene 进入场景，并通过 config 设置配置信息。最后通过 IMetaSceneEventHandler 类的 onEnterSceneResult 回调知晓进入场景的结果。

```java
// 进入场景
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

调用 leaveScene 离开场景。通过 IMetaSceneEventHandler 类的 onLeaveSceneResult 回调得知成功离开场景后，调用 release 释放 IMetaScene。通过 IMetaSceneEventHandler 类的 onReleasedScene 回调监听 IMetaScene 是否释放成功。最后依次调用 IMetaService 和 RtcEngine 类的 destroy 方法销毁 IMetaService 和 RtcEngine。

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

### 开发注意事项 #TODO fragment

在使用 3D 场景的过程中，需要注意以下几点：

- 为了保持场景的连续性和流畅性，通常不能销毁 Activity。为了避免销毁场景所在的 Activity，可以使用 `Intent.FLAG_ACTIVITY_REORDER_TO_FRONT` 标志将 Activity 置于后台。
- 由于 Texture 的数据是在 GPU 中处理的，因此不能在运行时被销毁或重新创建，否则会影响应用程序的性能和稳定性。如果 Texture 尺寸大小发生变化，例如切换场景时需要切换横竖屏，你需要在 `setSurfaceTextureListener` 的回调方法 `onSurfaceTextureSizeChanged` 中再次调用 `createScene` 和 `enterScene` 等方法，重新创建和进入场景。