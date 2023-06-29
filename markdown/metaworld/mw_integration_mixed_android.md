# 客户端实现 (Android)

本文介绍如何实现元语聊和元直播的融合场景。

## 示例项目 //TODO fragment-1

声网在 GitHub 上提供一个开源的 [MetaWorld 示例项目](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0)。

## 实现元语聊和元直播

完成[集成声网 Meta SDK](./integrate_sdk_android) 后，你可以参考本节实现元语聊。

下图展示实现元语聊的 API 调用时序：

//TODO: 时序

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

调用 `IMetaService.getSceneAssetsInfo` 获取场景资源，并通过 `IMetaServiceEventHandler.onGetSceneAssetsInfoResult` 回调监听获取场景资源时的事件。

调用 `IMetaService.downloadScene` 获取场景资源，并通过 `IMetaServiceEventHandler.onDownloadSceneAssetsProgress` 回调监听获取场景资源时的事件。