本文介绍如何实现电商直播场景。

## 示例项目

声网在 [Agora-Scenario-Examples](https://github.com/AgoraIO-Usecase/Agora-Scenario-Examples/tree/main) 仓库中提供[电商直播](https://github.com/AgoraIO-Usecase/Agora-Scenario-Examples/tree/main/Android/modules/Shopping)源代码供你参考。

## 业务流程图

本节介绍电商直播涉及到的通用业务流程，包含主播和观众的实时音视频互动、主播之间的跨直播间 PK 连麦。

### 实时互动

房主进入直播间，开始上架商品，进行电商直播。用户可以查看商品列表进行下单。

![](https://web-cdn.agora.io/docs-files/1684397470563)

### PK 连麦

房主邀请另一个房间的房主开始 PK 连麦。用户可以看到两个房主 PK 连麦直播的画面。

![](https://web-cdn.agora.io/docs-files/1684397483079)


## 准备开发环境

### 前提条件

- Android Studio 4.1 以上版本。
- Android API 级别 16 或以上。
- 两台运行 Android 4.1 或以上版本的移动设备。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 有效的[声网账户](https://console.agora.io/)和声网项目，请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)，从声网控制台获取以下信息：
  - App ID：声网随机生成的字符串，用于识别你的 app。
  - 临时 Token：你的 app 客户端加入频道时会使用 Token 对用户进行鉴权。临时 Token 的有效期为 24 小时。
  - 频道名称：用于标识直播频道的字符串。

### 创建项目

按照以下步骤准备开发环境：

1. 如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   <div class="alert note">创建项目后，<b>Android Studio</b> 会自动开始同步 gradle, 稍等片刻至同步成功后再进行下一步操作。</div>

2. 使用 Maven Central 将声网视频 SDK 集成到你的项目中。

   a. 在 `/Gradle Scripts/build.gradle(Project: <projectname>)` 文件中添加如下代码，添加 Maven Central 依赖：

   ```java
    buildscript {
        repositories {
            ...
            mavenCentral()
        }
        ...
   }

     allprojects {
        repositories {
            ...
            mavenCentral()
        }
   }
   ```

    <div class="alert note">如果你的 Android 项目设置了 <a href="https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration">dependencyResolutionManagement</a>，添加 Maven Central 依赖的方式可能存在差异。</div>

   b. 在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 文件中添加如下代码，将声网视频 SDK 集成到你的 Android 项目中：

   ```java
   ...
    dependencies {
        ...
        // x.y.z，请填写具体的 SDK 版本号，如：4.0.0 或 4.1.0-1。
        // 通过互动直播产品发版说明获取最新版本号。
        implementation 'io.agora.rtc:full-sdk:x.y.z'
     }
   ```

3. 添加网络及设备权限。

   在 `/app/Manifests/AndroidManifest.xml` 文件中，在 `</application>` 后面添加如下权限：

   ```xml
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.BLUETOOTH"/>
    <!-- 对于 Android 12.0 及以上且集成 v4.1.0 以下 SDK 的设备，还需要添加以下权限 -->
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
    <!-- 对于 Android 12.0 及以上设备，还需要添加以下权限 -->
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
   ```

4. 在 `/Gradle Scripts/proguard-rules.pro` 文件中添加如下行，以防止声网 SDK 的代码被混淆：

   ```java
   -keep class io.agora.**{*;}
   -dontwarn javax.**
   -dontwarn com.google.devtools.build.android.**
   ```

## 实现电商直播

如下时序图中展示了如何预览直播、加入直播间、上下架商品、PK 连麦、退出直播间。声网 RTC SDK 承担实时音视频的业务，声网云服务承担信令消息和数据存储的业务。本节会详细介绍如何调用 RTC SDK 的 API 完成这些逻辑，但是信令消息的逻辑需要你参考时序图自行实现。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>

![](https://web-cdn.agora.io/docs-files/1684484123337)

### 1. 预览直播

房主进入直播间前一般需要预览本地直播视频。你可以调用如下方法，创建 `RtcEngine` 引擎并开启本地视频预览：

- [`create`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_create): 创建 `RtcEngine` 引擎。
- [`setupLocalVideo`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_process.html#api_irtcengine_setuplocalvideo): 初始化本地视图。
- [`startPreview`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_process.html#api_irtcengine_startpreview): 开启视频预览。


```java
try {
    // 创建 RtcEngine 引擎
    rtcEngine = RtcEngine.create(this, getString(R.string.rtc_app_id), new IRtcEngineEventHandler() {});
    FrameLayout surfaceViewContainer = findViewById(R.id.surface_view_container);
    SurfaceView videoView = new SurfaceView(this);
    surfaceViewContainer.removeAllViews();
    surfaceViewContainer.addView(videoView);
    // 开启本地视频
    rtcEngine.setupLocalVideo(new VideoCanvas(videoView, Constants.RENDER_MODE_HIDDEN));
    // 开启本地预览
    rtcEngine.startPreview();
} catch (Exception e) {
    e.printStackTrace();
}
```

### 2. 加入直播间

你可以使用声网 RTC SDK 的 [`create`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_create) 方法创建一个 `RtcEngine` 引擎，再通过 [`joinChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_joinchannel2) 和 [`setChannelProfile`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_setchannelprofile) 方法让用户加入一个频道场景为 `LIVE_BROADCASTING` 的频道。频道用于传输直播间中的音视频流，云服务用于传输直播间中的信令消息和存储数据。用户在频道内可以进行实时音视频互动。频道内的用户有两种角色：

- 主播：可以发送和接收音视频流。直播间的房主即为主播。
- 观众：只可以接收音视频流。

你需要调用 `setupLocalVideo` 在主播端渲染本地视频，调用 `setupRemoteVideo` 在观众端渲染远端视频（即主播的视频）。#TODO add link

```java
try {
    // 创建 RtcEngine 引擎
    rtcEngine = (RtcEngineEx) RtcEngine.create(this, getString(R.string.rtc_app_id), new IRtcEngineEventHandler() {
        ...
    });

    // 开启视频和音频
    rtcEngine.enableVideo();
    rtcEngine.enableAudio();

    // 设置频道场景为直播
    rtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING);

    // 主播端渲染本地视频
    SurfaceView videoView = new SurfaceView(this);
    mBinding.localVideoContainer.removeAllViews();
    mBinding.localVideoContainer.addView(videoView);
    rtcEngine.setupLocalVideo(new VideoCanvas(videoView, Constants.RENDER_MODE_HIDDEN));

    // 观众端渲染远端视频，即渲染主播的视频
    SurfaceView videoView = new SurfaceView(AudienceDetailActivity.this);
    mBinding.localVideoContainer.removeAllViews();
    mBinding.localVideoContainer.addView(videoView);
    rtcEngine.setupRemoteVideo(new VideoCanvas(videoView, Constants.RENDER_MODE_HIDDEN, uid));

    // 加入频道
    ChannelMediaOptions options = new ChannelMediaOptions();
    options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
    options.publishMicrophoneTrack = true;
    options.publishCameraTrack = true;
    options.autoSubscribeVideo = true;
    options.autoSubscribeAudio = true;
    int uid = Integer.parseInt(RoomManager.getCacheUserId());
    TokenGenerator.gen(this, roomInfo.roomId, uid, ret -> rtcEngine.joinChannel(ret, roomInfo.roomId, uid, options));
} catch (Exception e) {
    e.printStackTrace();
}
```

### 3. 开始 PK 连麦

房主跨直播间 PK 连麦意味着不同频道内的主播加入对方频道进行连麦。当房间内用户收到房主 PK 连麦的信令消息后，房间内用户的代码逻辑如下：

- 房间 A：
    - 房主 A 通过 [`joinChannelEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_joinchannelex) 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 [`setupRemoteVideoEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_setupremotevideoex) 渲染频道 B 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 B 中主播的视频。
- 房间 B：
    - 房主 B 通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。

完成这些逻辑后，观众可以同时接收频道 A 和 B 的音视频流，因此可以同时看到两个房间的房主。房主仅在自己的频道发流，在对方的频道内不发流仅收流，因此，房主可以（在对方频道）看到对方，达到连麦的效果。


```java
exChannelConnection = new RtcConnection();
exChannelConnection.localUid = new Random(System.currentTimeMillis()).nextInt(1000) + 10000;
exChannelConnection.channelId = exChannelId;
rtcEngine.setVideoEncoderConfigurationEx(io.agora.scene.shopping.Constants.encoderConfiguration, exChannelConnection);
options = new ChannelMediaOptions();
// 加入对方频道时，订阅音视频流，但是不发送音视频流
options.clientRoleType = Constants.CLIENT_ROLE_AUDIENCE;
options.autoSubscribeAudio = true;
options.autoSubscribeVideo = true;
TokenGenerator.gen(this, exChannelConnection.channelId, exChannelConnection.localUid, new TokenGenerator.OnTokenGenCallback<String>() {
    @Override
    public void onTokenGen(String ret) {
        // 加入对方频道以 PK 连麦
        rtcEngine.joinChannelEx(ret, exChannelConnection, options, new IRtcEngineEventHandler() {
            @Override
            public void onUserJoined(int uid, int elapsed) {
                super.onUserJoined(uid, elapsed);
                runOnUiThread(() -> {
                    mBinding.pkVideoContainer.setVisibility(View.VISIBLE);
                    mBinding.ivPkIcon.setVisibility(View.VISIBLE);
                    mBinding.btnStopPk.setVisibility(View.VISIBLE);
                    SurfaceView videoView = new SurfaceView(HostDetailActivity.this);
                    mBinding.pkVideoContainer.removeAllViews();
                    mBinding.pkVideoContainer.addView(videoView);
                    // 渲染对方房主的视频
                    rtcEngine.setupRemoteVideoEx(new VideoCanvas(videoView, Constants.RENDER_MODE_HIDDEN, uid), exChannelConnection);
                });
            }
            @Override
            public void onUserOffline(int uid, int reason) {
                super.onUserOffline(uid, reason);
                runOnUiThread(() -> {
                    mBinding.pkVideoContainer.setVisibility(View.GONE);
                    mBinding.pkVideoContainer.removeAllViews();
                    mBinding.ivPkIcon.setVisibility(View.GONE);
                    mBinding.btnStopPk.setVisibility(View.GONE);
                    endPK();
                });
            }
        });
    }
```

### 4. 结束 PK 连麦

结束 PK 连麦时，房间内用户都需要调用 [`leaveChannelEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_leavechannelex) 离开对方频道。

```java
mBinding.pkVideoContainer.setVisibility(View.GONE);
mBinding.pkVideoContainer.removeAllViews();
mBinding.ivPkIcon.setVisibility(View.GONE);
mBinding.btnStopPk.setVisibility(View.GONE);
if (exChannelConnection != null) {
    rtcEngine.leaveChannelEx(exChannelConnection);
    exChannelConnection = null;
}
```

### 5. 退出直播间

直播结束，所有用户退出直播间时都需要调用 [`leaveChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_leavechannel) 离开频道。如果不再加入房间，还可以调用 [`destroy`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_release) 销毁 `RtcEngine` 引擎。

```java
if (exChannelConnection != null) {
    rtcEngine.leaveChannelEx(exChannelConnection);
    exChannelConnection = null;
}
rtcEngine.leaveChannel();
RtcEngine.destroy();
```