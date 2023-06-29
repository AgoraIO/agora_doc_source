# 客户端实现 (Android)

本文介绍如何实现元直播。

## 示例项目 //TODO fragment-1

声网在 GitHub 上提供一个开源的 [MetaWorld 示例项目](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 供你参考。

## 实现元直播

完成[集成声网 Meta SDK](./integrate_sdk_android) 后，你可以参考本节实现元直播。

下图展示实现元直播的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1687684407522)

实现流程中需要用到声网 SDK 的以下接口类：

- `RtcEngine` 类：提供实时音视频功能的核心类。
- `IMetaService` 类：提供 Meta 服务的核心类。可用于获取场景资源列表、下载场景资源、删除本地场景资源等场景资源管理，还可用于创建 `IMetaScene`。
- `IMetaScene` 类：场景资源相关操作。
- `ILocalUserAvatar` 类：包含在 `IMetaScene` 中，生命周期和 `IMetaScene` 相同，用于设置虚拟形象（Avatar）。
- `IMetaServiceEventHandler` 类：`IMetaService` 的异步方法的事件回调类。
- `IMetaSceneEventHandler` 类：`IMetaScene` 的异步方法的事件回调类。

### 1. 初始化 RTC 引擎和 Meta 服务

在创建元直播场景前，你需要创建并初始化 RTC 引擎和 Meta 服务。

- 调用 `RtcEngine.create` 创建并初始化 `RtcEngine` 对象：

    ```java
    // 配置 RtcEngine
    RtcEngineConfig rtcConfig = new RtcEngineConfig();
    rtcConfig.mContext = context; // Android 活动上下文
    rtcConfig.mAppId = KeyCenter.APP_ID; // 声网项目的 App ID
    rtcConfig.mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING; // 频道使用场景设置为直播模式
    // RtcEngine 的回调事件句柄
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

    // 创建并初始化 RtcEngine
    rtcEngine = RtcEngine.create(rtcConfig);
    rtcEngine.setParameters("{\"rtc.enable_debug_log\":true}");

    // 开启音视频模块并设置音频属性和路由
    rtcEngine.enableAudio();
    rtcEngine.enableVideo();
    rtcEngine.setAudioProfile(
            Constants.AUDIO_PROFILE_DEFAULT, Constants.AUDIO_SCENARIO_GAME_STREAMING
    );
    rtcEngine.setDefaultAudioRoutetoSpeakerphone(true);
    ```

- 调用 `IMetaService.create` 和 `IMetaService.initialize` 创建并初始化 `IMetaService` 对象。初始化 `IMetaService` 时，你需要在 `MetaServiceConfig` 中设置如下参数：
    - `mRtcEngine`：通过 `RtcEngine.create` 方法创建的 `RtcEngine` 实例。
    - `mAppId`：在声网控制台获取的 App ID。详见[集成声网 Meta SDK](./integrate_sdk_android)。
    - `mUserId`：登录声网 RTM 系统的用户 ID。推荐取值详见 [API 参考](./api_ref_android?platform=All%20Platforms#metaserviceconfig)。
    - `mRtmToken`：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。详见[生成 Token](https://docportal.shengwang.cn/cn/Real-time-Messaging/messaging_android?platform=Android#4-生成-token)。
    - `mLocalDownloadPath`：场景资源下载到本地的保存路径。
    - `mEventHandler`：`IMetaService` 的回调事件句柄。

    ```java
    scenePath = context.getExternalFilesDir("").getPath();
    {
        // 创建 IMetaService 对象
        metaService = IMetaService.create();
        // 配置 IMetaService
        MetaServiceConfig config = new MetaServiceConfig() {{
            mRtcEngine = rtcEngine; // RtcEngine 实例
            mAppId = KeyCenter.APP_ID; // 声网项目的 App ID
            mRtmToken = KeyCenter.RTM_TOKEN; // 声网 RTM（云信令）Token，保障安全，声网项目有 RTC Token 和 RTM Token，不要搞混淆
            mLocalDownloadPath = scenePath; // 场景资源的本地下载路径
            mUserId = KeyCenter.RTM_UID; // 声网 RTM（云信令）UID，用户 ID，标志用户身份，声网项目有 RTC UID 和 RTM UID，不要搞混淆
            mEventHandler = MetaContext.this; // IMetaService 的异步回调事件
        }};
        // 初始化 IMetaService
        ret += metaService.initialize(config);
        Log.i(TAG, "launcher version=" + metaService.getLauncherVersion(context));
    }
    ```

### 2. 获取并下载场景资源

初始化完成后，请参考如下代码调用 `getSceneAssetsInfo` 和 `downloadSceneAssets` 获取并下载场景资源。

```java
// 获取场景资源信息
public boolean getSceneInfos() {
    return metaService.getSceneAssetsInfo() == Constants.ERR_OK;
}
// 获取场景资源信息回调
@Override
public void onGetSceneAssetsInfoResult(MetaSceneAssetsInfo[] metaSceneAssetsInfos, int errorCode) {
}

// 下载场景资源信息
public boolean downloadScene(MetaSceneAssetsInfo sceneInfo) {
    return metaService.downloadSceneAssets(sceneInfo.mSceneId) == Constants.ERR_OK;
}
// 下载场景资源信息回调
@Override
public void onDownloadSceneAssetsProgress(long sceneId, int progress, int state) {
}

// 取消下载场景资源信息 (按需调用)
public boolean cancelDownloadScene(MetaSceneAssetsInfo sceneInfo) {
    return metaService.cancelDownloadSceneAssets(sceneInfo.mSceneId) == Constants.ERR_OK;
}
```

### 3. 创建元直播场景

搭建元直播首先需要调用 `createScene` 创建场景。为增加直播趣味性，声网推荐你开启面部捕捉，使用同步人脸表情的 Avatar 形象。你需要在 `MetaSceneConfig` 中设置 `mEnableFaceCapture` 为 `true`，并在 `mFaceCaptureAppId` 和 `mFaceCaptureCertificate` 中传入面部捕捉插件的 ID 和 Key。

```java
// 配置场景信息
MetaSceneConfig sceneConfig = new MetaSceneConfig();
sceneConfig.mActivityContext = activityContext; // Android 活动上下文
sceneConfig.mEnableFaceCapture = true; // 支持面部捕捉
sceneConfig.mFaceCaptureAppId = KeyCenter.FACE_CAP_APP_ID; // 传入面部捕捉插件
sceneConfig.mFaceCaptureCertificate = KeyCenter.FACE_CAP_APP_KEY; // 传入面部捕捉插件
int ret = -1;
if (metaScene == null) {
    // 创建场景
    ret = metaService.createScene(sceneConfig);
}

// 创建场景回调
@Override
public void onCreateSceneResult(IMetaScene scene, int errorCode) {
    Log.i(TAG, "onCreateSceneResult errorCode: " + errorCode);
    metaScene = scene;
    localUserAvatar = metaScene.getLocalUserAvatar();
}
```

### 4. 设置用户信息并进入场景

进入场景之前，你可以先设置好用户的基本信息、模型信息、装扮和捏脸信息等。如下示例代码展示设置用户信息后进入场景：

- 调用 `setUserInfo` 设置用户基本信息。
- 调用 `setModelInfo` 设置模型信息。
- 调用 `setExtraInfo` 设置自定义信息，此处设置了用户的捏脸和换装信息。
- 调用 `enterScene` 进入场景。

```java
public void enterScene() {
   if (null != localUserAvatar) {
        // 设置场景中展示的用户信息
        localUserAvatar.setUserInfo(userInfo);
        // 设置用户的 avatar 模型信息
        localUserAvatar.setModelInfo(modelInfo);
        if (null != roleInfo) {
                // 设置用户的自定义捏脸、换装信息
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("2dbg", "");
                jsonObject.put("avatar", roleInfo.getAvatarType());
                jsonObject.put("dress", roleInfo.getDressResourceMap().values().toArray((new Integer[0])));
                jsonObject.put("face", roleInfo.getFaceParameterResourceMap().values().toArray((new FaceParameterItem[0])));
                localUserAvatar.setExtraInfo(jsonObject.toJSONString().getBytes());
            }
    }
    if (null != metaScene) {
        // 设置回调接口
        metaScene.addEventHandler(MetaContext.getInstance());
        // 配置进入场景信息
        EnterSceneConfig config = new EnterSceneConfig();
        config.mSceneView = this.sceneView; // 场景的渲染视图，Android 上使用 TextureView 控件
        config.mRoomName = KeyCenter.CHANNEL_ID; // 场景的频道名
        if (null != sceneInfo) {
            config.mSceneId = this.sceneInfo.mSceneId; // 场景 ID
        }
        if (isEnableLocalSceneRes) {
            config.mSceneId = 0;
            config.mScenePath = scenePath + "/" + getSceneId(); // 场景的加载路径
        }
        // 示例项目中，sceneIndex 的 0 为元直播场景，1 为元语聊场景，在实际场景中，你可以根据业务需求调整自定义扩展信息
        "extraInfo": {
           "sceneIndex":1
        }
        EnterSceneExtraInfo extraInfo = new EnterSceneExtraInfo();
        extraInfo.setSceneIndex(MetaConstants.SCENE_DRESS);
        // 加载的场景 index
        config.mExtraInfo = JSONObject.toJSONString(extraInfo).getBytes();
        // 进入场景
        metaScene.enterScene(config);
    }
}

// 进入场景回调
@Override
public void onEnterSceneResult(int errorCode) {
    Log.d(TAG, String.format("onEnterSceneResult %d", errorCode));
}
```

<div class="alert note"><ul><li>本小节展示在<b>进入场景前</b>设置用户和模型信息，如需在<b>进入场景后</b>变更设置，需调用 <code>applyInfo</code> 使设置生效。</li><li>声网 Meta SDK 支持自定义装扮捏脸功能，详见 //TODO: 待链接。</li></ul></div>


### 5. 加入频道并开启元直播

进入场景后，你需要将主播端 Avatar 形象的视频流发布到 RTC 频道中，使 3D 场景中的用户都能看到直播：

- 调用 `enableSceneVideoCapture` 开启场景渲染画面捕获，开启对主播 Avatar 形象的视频采集；`enable` 设置为 `true`，把场景画面和 Avatar 形象发布到频道；`enable` 设置为 `false`，把摄像头采集的主播真人画面发布到频道。
- 调用 `joinChannel` 使主播加入 RTC 频道。

<div class="alert note">发送 Avatar 视频前，请确保 <code>MetaSceneConfig</code> 中已设置开启面部捕捉。</div>

```java
public void joinChannel() {
    if (null != rtcEngine) {
        rtcEngine.joinChannel(
                KeyCenter.RTC_TOKEN, KeyCenter.CHANNEL_ID, KeyCenter.RTC_UID,
                new ChannelMediaOptions() {{
                    publishMicrophoneTrack = true;
                    publishCameraTrack = true;
                    autoSubscribeAudio = true;
                    autoSubscribeVideo = true;
                    clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
                }});
    }
}

// 设置为 true，把场景画面和 avatar 形象发布到频道，设置为 false，把摄像头采集画面发布到频道
public void enableSceneVideo(TextureView view, boolean enable) {
    if (null != metaScene) {
        metaScene.enableSceneVideoCapture(view, enable);
    }
}
```

### 6. 离开频道并释放资源

直播结束时，你可以离开频道并释放资源。

```java
// 退出频道
rtcEngine.leaveChannel();

// 离开场景
private void leaveScene() {
    if (metaScene != null) {
        metaScene.leaveScene();
    }
}

// 离开场景回调
@Override
public void onLeaveSceneResult(int errorCode) {
    Log.d(TAG, String.format("onLeaveSceneResult %d", errorCode));
    if (errorCode == 0) {
        // 销毁场景
        metaScene.release();
        metaScene = null;
    }
}

// 销毁场景回调
@Override
public void onReleasedScene(int status) {
    Log.d(TAG, String.format("[meta] onReleasedScene %d", status));
    destroy();
}

public void destroy() {
    // 销毁 IMetaService
    IMetaService.destroy();
    metaService = null;
    // 销毁 RtcEngine
    RtcEngine.destroy();
    rtcEngine = null;
}
```

## 参考信息

### 开发注意事项

在使用 3D 场景的过程中，需要注意以下几点：

- 为了保持场景的连续性和流畅性，通常不能销毁 Activity。为了避免销毁场景所在的 Activity，可以使用 `Intent.FLAG_ACTIVITY_REORDER_TO_FRONT` 标志将 Activity 置于后台。
- 由于 Texture 的数据是在 GPU 中处理的，因此不能在运行时被销毁或重新创建，否则会影响应用程序的性能和稳定性。如果 Texture 尺寸大小发生变化，例如切换场景时需要切换横竖屏，你需要在`setSurfaceTextureListener` 的回调方法 `onSurfaceTextureSizeChanged` 中再次调用 `createScene` 和 `enterScene` 等方法，重新创建和进入场景。