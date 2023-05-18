本文介绍如何实现电商直播场景。

## 示例项目

声网在 [Agora-Scenario-Examples](https://github.com/AgoraIO-Usecase/Agora-Scenario-Examples/tree/main) 仓库中提供[电商直播](https://github.com/AgoraIO-Usecase/Agora-Scenario-Examples/tree/main/Android/modules/Shopping)源代码供你参考。

## 业务流程图

本节介绍电商直播涉及到的通用业务流程，包含主播和观众的实时音视频互动、主播之间的跨直播间 PK 连麦。

### 实时互动

![](https://web-cdn.agora.io/docs-files/1684397470563)

### PK 连麦

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
        // 通过发版说明获取最新版本号。
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
   ```

## 实现电商直播

本节介绍集成电商直播的 API 时序和关键步骤。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>

<pic>


### 预览直播


```java
try {
    rtcEngine = RtcEngine.create(this, getString(R.string.rtc_app_id), new IRtcEngineEventHandler() {});
    FrameLayout surfaceViewContainer = findViewById(R.id.surface_view_container);
    SurfaceView videoView = new SurfaceView(this);
    surfaceViewContainer.removeAllViews();
    surfaceViewContainer.addView(videoView);
    rtcEngine.setupLocalVideo(new VideoCanvas(videoView, Constants.RENDER_MODE_HIDDEN));
    rtcEngine.startPreview();
} catch (Exception e) {
    e.printStackTrace();
}
```

### 加入直播间

```java
try {
    rtcEngine = (RtcEngineEx) RtcEngine.create(this, getString(R.string.rtc_app_id), new IRtcEngineEventHandler() {
        ...
    });
    rtcEngine.enableVideo();
    rtcEngine.enableAudio();

    rtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING);

    // Room owner render local video
    SurfaceView videoView = new SurfaceView(this);
    mBinding.localVideoContainer.removeAllViews();
    mBinding.localVideoContainer.addView(videoView);
    rtcEngine.setupLocalVideo(new VideoCanvas(videoView, Constants.RENDER_MODE_HIDDEN));

    // Audience render remote video
    SurfaceView videoView = new SurfaceView(AudienceDetailActivity.this);
    mBinding.localVideoContainer.removeAllViews();
    mBinding.localVideoContainer.addView(videoView);
    rtcEngine.setupRemoteVideo(new VideoCanvas(videoView, Constants.RENDER_MODE_HIDDEN, uid));

    // join channel
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

### 开始 PK 连麦

```java
exChannelConnection = new RtcConnection();
exChannelConnection.localUid = new Random(System.currentTimeMillis()).nextInt(1000) + 10000;
exChannelConnection.channelId = exChannelId;
rtcEngine.setVideoEncoderConfigurationEx(io.agora.scene.shopping.Constants.encoderConfiguration, exChannelConnection);
options = new ChannelMediaOptions();
options.clientRoleType = Constants.CLIENT_ROLE_AUDIENCE;
options.autoSubscribeAudio = true;
options.autoSubscribeVideo = true;
TokenGenerator.gen(this, exChannelConnection.channelId, exChannelConnection.localUid, new TokenGenerator.OnTokenGenCallback<String>() {
    @Override
    public void onTokenGen(String ret) {
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

### 结束 PK 连麦

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

### 退出直播间

```java
if (exChannelConnection != null) {
    rtcEngine.leaveChannelEx(exChannelConnection);
    exChannelConnection = null;
}
rtcEngine.leaveChannel();
RtcEngine.destroy();
```