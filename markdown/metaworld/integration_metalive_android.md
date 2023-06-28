# 客户端实现 (Android)

本文介绍如何实现元直播。

## 示例项目

声网在 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/) 仓库的 `dev_metasdk1.0` 分支提供元直播源代码供你参考。

## 开通 Meta 服务

### 创建声网项目

1. 进入声网控制台的[项目管理](https://console.agora.io/projects)页面。

2. 在项目管理页面，点击**创建**按钮。

3. 在弹出的对话框内输入项目名称、使用场景，然后选择**安全模式：** **APP ID + Token**。

4. 点击**提交**按钮。新建的项目会显示在项目管理页中。

### 获取 ID 及证书

1. 创建项目后，从控制台获取声网项目的 [App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id) 和 [App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)。

2. 联系 [sales@agora.io](mailto:sales@agora.io) 并供你的声网项目 App ID，用于开通声网内容中心的权限并获取声网面部捕捉插件。

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
- [Android Studio](https://developer.android.com/studio/) 4.1 及以上
- Android API 级别 22 及以上。
- Android 设备，版本 Android 5.1 及以上
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

### 创建项目并集成 SDK

在 Android Studio 中进行以下操作，准备开发环境：

1. 如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   <div class="alert note">创建项目后，<b>Android Studio</b> 会自动开始同步 gradle, 稍等片刻至同步成功后再进行下一步操作。</div>

2. 添加网络及设备权限。

   打开 `./<Your Project>/app/src/main/AndroidManifest.xml` 文件，在 `</application>` 后面添加如下权限：

   ```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   ```

3. 将 Meta SDK 集成到你的项目中。

    1. 联系 [sales@agora.io](mailto:sales@agora.io) 获取 Meta SDK，下载并解压。
    2. 打开解压的 SDK，将以下文件或子文件夹复制到你的项目路径中。

        | 文件或子文件夹             | 项目路径     |
        |:-------------------------|:-----------|
        | `agora-rtc-sdk.jar` 文件	| `/app/libs/` |
        | `AgoraMetaKit.aar` 文件 	| `/app/libs/` |
        | `face_capture.jar` 文件   | `/app/libs/` |
        | `FaceCapture.aar` 文件    | `/app/libs/` |
        | `metakit.jar` 文件        | `/app/libs/` |
        | `arm64-v8a` 文件夹      	| `/app/src/main/jniLibs/` |
        | `armeabi-v7a` 文件夹	    | `/app/src/main/jniLibs/` |
        | `x86_64` 文件夹           | `/app/src/main/jniLibs/` |
        | `x86` 文件夹	            | `/app/src/main/jniLibs/` |

    3. 在 `./<Your Project>/app/build.gradle` 文件中添加以下代码指定本地依赖：

        ```java
        dependencies {
            ...
            // 指定 libs 目录下的所有 JAR 和 AAR 文件，即声网 Meta SDK
            implementation fileTree(dir: "libs", include: ["*.jar", "*.aar"])
            ...
        }
        ```

4. 除 SDK 外，你还需要添加其他依赖。在 `./<Your Project>/app/build.gradle` 文件中添加以下代码：

    ```java
    dependencies {
        ...
        // 指定两组远程依赖项
        implementation(['com.squareup.okhttp3:logging-interceptor:3.9.0',
                            'com.squareup.retrofit2:retrofit:2.3.0',
                            'com.squareup.retrofit2:adapter-rxjava2:2.3.0',
                            'com.squareup.retrofit2:converter-gson:2.3.0'])
        implementation(["io.reactivex.rxjava2:rxandroid:2.0.1",
                            "io.reactivex.rxjava2:rxjava:2.1.3"])
    }
    ```

    ![](https://web-cdn.agora.io/docs-files/1687674307175)


## 实现元直播

本节介绍在集成 Meta SDK 后，如何实现元直播的核心业务模块的功能。

实现流程中需要用到声网 SDK 的以下接口类：

- `RtcEngine` 类：提供实时音视频功能。
- `IMetaService` 类：Meta SDK 所有接口的入口，用于创建 `IMetaScene` 对象，负责获取、下载和删除场景资源。
- `IMetaScene` 类：负责进出场景、场景视频渲染、场景相关参数设置等场景相关操作。
- `ILocalUserAvatar` 类：用于设置用户昵称、徽章、Avatar 模型、捏脸换装等详细信息。
- `IMetaServiceEventHandler` 类：`IMetaService` 的异步方法的事件回调类。
- `IMetaSceneEventHandler` 类：`IMetaScene` 的异步方法的事件回调类。

元直播的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1687684407522)

### 1. 初始化 RTC 引擎和 Meta 服务

在创建元直播场景前，你需要创建并初始化 RTC 引擎和 Meta 服务。

- 调用 `RtcEngine.create` 创建并初始化 `RtcEngine` 对象：

    ```java
    // 配置 RtcEngine
    RtcEngineConfig rtcConfig = new RtcEngineConfig();
    rtcConfig.mContext = context; // Android 活动上下文
    rtcConfig.mAppId = KeyCenter.APP_ID; // 声网签发的 App ID
    rtcConfig.mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING; // 频道使用场景设置为直播模式
    // RtcEngine 的事件句柄
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

    rtcConfig.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.DEFAULT); // 音频场景设置为默认场景

    // 创建并初始化 RtcEngine
    rtcEngine = RtcEngine.create(rtcConfig);

    rtcEngine.setParameters("{\"rtc.enable_debug_log\":true}");
    
    rtcEngine.enableAudio();
    rtcEngine.enableVideo();
    
    rtcEngine.setAudioProfile(
            Constants.AUDIO_PROFILE_DEFAULT, Constants.AUDIO_SCENARIO_GAME_STREAMING
    );
    rtcEngine.setDefaultAudioRoutetoSpeakerphone(true);
    ```

- 调用 `IMetaService.create` 和 `IMetaService.initialize` 创建并初始化 `IMetaService` 对象：

    ```java
    scenePath = context.getExternalFilesDir("").getPath();
    {
        // 创建 IMetaService 对象
        metaService = IMetaService.create();
        // 配置 IMetaService
        MetaServiceConfig config = new MetaServiceConfig() {{
            mRtcEngine = rtcEngine; // RTC 引擎
            mAppId = KeyCenter.APP_ID; // 声网签发的 App ID
            mRtmToken = KeyCenter.RTM_TOKEN; // RTM token
            mLocalDownloadPath = scenePath; // 场景资源的本地下载路径
            mUserId = KeyCenter.RTM_UID; // RTM 用户 ID
            mEventHandler = MetaContext.this; // IMetaService 的异步回调接口类
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

进入场景后，你需要调用 `enableSceneVideoCapture` 开启场景渲染画面捕获，并调用 `joinChannel` 加入频道并把场景渲染的画面发布到 RTC 频道内。

进入场景后，你需要将主播端 Avatar 形象的视频流发布到 RTC 频道中，使 3D 场景中的用户都能看到直播：

- 调用 `enableVideoCapture` 开启场景渲染画面捕获，开启对主播 Avatar 形象的视频采集；`enable` 设置为 `true`，把场景画面和 Avatar 形象发布到频道，`enable` 设置为 `false`，把摄像头采集的主播真人画面发布到频道。
- 调用 `joinChannel` 使主播加入 RTC 频道。

<div class="alert note">发送 Avatar 视频前，请确保 <code>AgoraMetaSceneConfig</code> 中已设置开启面部捕捉。</div>

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