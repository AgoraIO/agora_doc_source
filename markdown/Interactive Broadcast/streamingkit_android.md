---
title: 推流组件
platform: Android
updatedAt: 2021-02-02 03:20:47
---

## 简介

Agora 为 CDN 直播推流场景研发 Streaming Kit（推流组件），支持将单个主播音视频流推送到 CDN。如果你同时集成 Streaming Kit 和 Agora RTC SDK，你还可以在观众无感知的情况下实现单主播和多主播画面的动态切换。

![](https://web-cdn.agora.io/docs-files/1597407156923)

## 示例项目

Agora 在 GitHub 上提供开源的 [RtmpStreaming](https://github.com/AgoraIO/Agora-Extensions/tree/master/RtmpStreaming) 示例项目供你参考。

## 准备开发环境

### 前提条件

- Android Studio 3.0 或以上版本
- Android SDK API 等级 16 或以上
- Android 4.1 或以上版本的设备

> 使用 Agora RTC SDK 时，请确保你有有效的 Agora 账户（免费[注册](https://dashboard.agora.io/)）并参考[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android#准备开发环境)集成 SDK。

### 创建项目

参考以下步骤创建一个 Android 项目。

 <details>
<summary><font color="#3ab7f8">创建 Android 项目</font></summary>

1. 打开 <b>Android Studio</b>，点击 <b>Start a new Android Studio project</b>。

2. 在 <b>Choose your project</b> 界面，选择 <b>Phone and Tablet</b> > <b>Empty Activity</b>，然后点击 <b>Next</b>。

3. 在 <b>Configure your project</b> 界面，依次填入以下内容：

   - <b>Name</b>：你的 Android 项目名称，如 LiveStreaming
   - <b>Package name</b>：你的项目包的名称，如 io.agora.streaming
   - <b>Project location</b>：项目的存储路径
   - <b>Language</b>：项目的编程语言，如 Java
   - <b>Minimum API level</b>：项目的最低 API 等级

然后点击 <b>Finish</b>。根据屏幕提示，安装可能需要的插件。

</details>

### 集成 Streaming Kit

**方法一：使用 JCenter 自动集成**

在项目的 /app/build.gradle 文件中，添加如下行：

```
...
dependencies {
    ...
    implementation 'io.agora:streamingkit:1.0.0'
}
```

**方法二：手动复制 Streaming Kit 文件**

1. 前往[下载](./downloads?platform=Android)页面，下载最新版 Streaming Kit，然后解压。

2. 将 Streaming Kit 的如下文件，拷贝到你的项目路径下：

   | 文件或文件夹                 | 项目路径                 |
   | :--------------------------- | :----------------------- |
   | `AgoraStreamingKit.jar` 文件 | `/app/libs/`             |
   | `arm-v8a` 文件夹             | `/app/src/main/jniLibs/` |
   | `armeabi-v7a` 文件夹         | `/app/src/main/jniLibs/` |
   | `x86` 文件夹                 | `/app/src/main/jniLibs/` |
   | `x86_64` 文件夹              | `/app/src/main/jniLibs/` |

3. 在 `/app/src/main/AndroidManifest.xml` 中添加如下内容，配置需要的设备权限。

   ```java
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   <uses-permission android:name="android.permission.READ_PHONE_STATE" />
   <uses-permission android:name="android.permission.BLUETOOTH" />
   ```

## 实现方法

你可以参考本节依次实现如下功能：

1. 单主播推流。
2. 单主播推流切换为多位主播直播推流。
3. 多位主播直播推流切换为单主播推流。

### 单主播推流

#### 1. 创建 Streaming Kit

创建一个 `StreamingKit` 实例，并设置 `StreamingContext` 的如下参数：

- `appId`: 你的 App ID。
- `eventHandler`: 事件句柄。详见 `StreamingEventHandler` 类。
- `audioStreamConfiguration`: 音频编码属性。推荐使用默认的音频编码属性：采样率 44.1 kHz，码率 48 Kbps，16 bits，单声道，LC-AAC。
- `videoStreamConfiguration`: 视频编码属性，推荐参考示例代码取值。

```java
public void createStreamingKit(Context appContext) {
  // 视频参数配置
  VideoStreamConfiguration videoStreamConfig = new VideoStreamConfiguration(
      VideoStreamConfiguration.VD_640x360,
      VideoStreamConfiguration.FRAME_RATE.FRAME_RATE_FPS_15,
      VideoStreamConfiguration.STANDARD_BITRATE,
      VideoStreamConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_FIXED_PORTRAIT);

  StreamingContext streamingContext = new StreamingContext(
      streamingEventHandler, appId, appContext, videoStreamConfig);
  try {
    streamingKit = StreamingKit.create(streamingContext);
  } catch (Exception e) {
    e.printStackTrace();
  }
}
```

#### 2. 管理日志

你可以使用默认的日志设置。如果你需要管理日志，请在创建 Streaming Kit 后立即调用如下方法。

```java
public void setupLog(String filePath) {
  // 设置日志文件路径，默认为 /sdcard/Android/data/<packageName>/files/streaming-kit.log
  streamingKit.setLogFile(filePath);

  // 设置日志文件大小，默认为 512 KB
  streamingKit.setLogFileSize(512);

  // 设置日志过滤级别，默认为 INFO
  streamingKit.setLogFilter(StreamingKit.LogFilter.LOG_FILTER_INFO);
}
```

#### 3. 管理本地预览视图

如果你想让主播在直播推流开始前进行本地预览，请在创建 Streaming Kit 后调用如下方法：

```java
public void setupPreview(SurfaceView view) {
  //（必须）获取 preview renderer 对象，以管理所有与渲染相关的操作
  if (previewRenderer == null) {
    previewRenderer = streamingKit.getVideoPreviewRenderer();
  }

  // 设置本地预览视图
  previewRenderer.setView(view);

  // 设置本地预览视图的镜像模式，默认情况下，使用前置摄像头开启镜像，使用后置摄像头不开启镜像
  previewRenderer.setMirrorMode(VideoMirrorMode.VIDEO_MIRROR_MODE_AUTO);

  // 设置本地预览视图的渲染模式, 默认为 FIT 模式
  previewRenderer.setRenderMode(VideoRenderMode.RENDER_MODE_FIT);
}
```

#### 4. 开启录音和摄像头

开始直播推流前，你需要让 Streaming Kit 对主播进行录音和视频采集。该步骤和步骤 3 无严格先后顺序。

```java
// 开启录音，不支持推流过程中调用
streamingKit.enableAudioRecording(true);

// 开启视频采集，不支持推流过程中调用
streamingKit.enableVideoCapturing(true);
```

#### 5. 添加和删除自定义美颜

如果你想给主播美颜，请调用 `addVideoFilter` 向 video track 添加一个 video filter。然后自行实现 VideoFilter 类，使用该类的 `process` 方法。

Streaming Kit 通过 `process` 方法的 `inputFrame` 参数向你输出采集到的视频帧。拿到视频帧后，你可以通过第三方 SDK 对视频帧进行美颜等前处理。最后，将处理后的视频帧通过 `process` 方法的返回值传回 Steaming Kit。

> 如果你想抛弃视频帧，将返回值传空。

```java
// 添加自定义美颜
streamingKit.addVideoFilter(videoFilter);

// 删除自定义美颜
streamingKit.removeVideoFilter(videoFilter);
```

#### 6. 开始和结束单主播 CDN 直播推流

调用如下方法开始推流：

```java
// 开始单主播 CDN 直播推流
streamingKit.startStreaming(publishUrl);

// 结束单主播 CDN 直播推流
streamingKit.stopStreaming();
```

`startStreaming` 成功和失败会分别触发 `onStartStreamingSuccess` 和 `onStartStreamingFailure` 回调。失败时，请通过 `StartStreamingError` 排查问题。`startStreaming` 成功后，如果推送的媒体流出错，kit 会触发 `onMediaStreamingError` 回调。你可以通过 `MediaStreamingError` 和 `msg` 信息排查媒体流的问题。推流过程中，你可以通过 `onStreamingConnectionStateChanged` 回调监听当前推流状态，详见 `StreamingConnectionState`。

如果你想只推视频流或只推音视流，你可以在 `startStreaming` 后调用 `muteAudioStream` 或 `muteVideoStream`。如果你想切换摄像头，可以在 `startStreaming` 前和后调用 `switchCamera`。

> - Streaming Kit 在 Android 设备上默认使用前置摄像头。
> - Streaming Kit 不支持在 `startStreaming` 后调用 `enableAudioRecording` 和 `enableVideoCapturing`。

#### 7. 销毁 Streaming Kit

销毁 Streaming Kit 后，请确保不再使用 Streaming Kit 提供的 API。

> 如果你需要重新使用 Streaming Kit，请重新创建一个 StreamingKit 实例。

```java
StreamingKit.destroy();
```

### 动态切换

#### 单主播切换为多主播

当其他主播加入单主播的直播推流时，你需要先结束单主播的 CDN 直播推流，然后注册音视频观测器接收音频帧，并将音视频帧作为 RTC SDK 的自定义音频源和自定义视频源。最后使用 RTC SDK 提供的 CDN 推流 API 完成多主播的直播推流。

![](https://web-cdn.agora.io/docs-files/1597407185467)

```java
public void switchToAgoraChannel() {
  // 结束单主播 CDN 直播推流
  streamingKit.stopStreaming();

  // 设置 RTC SDK 自定义音频源
  rtcEngine.setExternalAudioSource(true, audioSampleRate, audioChannels);

  // 注册 Streaming Kit 的音频帧观测器，从回调中拿到音频帧，音频帧即为 RTC SDK 的自定义音频源
  streamingKit.registerAudioFrameObserver(audioFrameObserver);

  // 设置 RTC SDK 自定义视频源
  rtcEngine.setVideoSource(videoSource);

  // 注册 Streaming Kit 的视频帧观测器，从回调中拿到视频帧，视频帧即为 RTC SDK 的自定义视频源
  streamingKit.registerVideoFrameObserver(videoFrameObserver);

  // 加入 Agora RTC 频道
  rtcEngine.joinChannel(null, "channelName", "", 0);

  // 在 onJoinChannelSuccess 和 onUserJoined 回调之后，依次调用 setLiveTranscoding 和 addPublishStreamUrl 开始旁路推流
  ......
}
```

详情请参考如下文档：

- [自定义音频采集](https://docs.agora.io/cn/Interactive%20Broadcast/custom_audio_android?platform=Android#自定义音频采集)
- [自定义视频采集(MediaIO)](https://docs.agora.io/cn/Interactive%20Broadcast/custom_video_android?platform=Android#自定义视频采集)
- [使用 RTC SDK 推流到 CDN](https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_android?platform=Android#前提条件)

#### 多主播切换为单主播

当其他主播离开单主播的直播推流时，你需要使用 RTC SDK 的推流 API 结束多主播的直播推流，然后离开 RTC 频道，并取消注册音视频观测器。最后开始单主播的直播推流。

![](https://web-cdn.agora.io/docs-files/1597407199944)

```java
public void switchToRtmpStreaming() {
  // 结束 RTC SDK 提供的旁路推流
  rtcEngine.removePublishStreamUrl(publishUrl);

  // 退出 Agora RTC 频道
  rtcEngine.leaveChannel();

  // 取消注册 Streaming Kit 的视频帧观测器
  streamingKit.unregisterVideoFrameObserver(videoFrameObserver);

  // 取消注册 Streaming Kit 的音频帧观测器
  streamingKit.unregisterAudioFrameObserver(audioFrameObserver);

  // 开始单主播 CDN 直播推流
  streamingKit.startStreaming(publishUrl);
}
```

## API 参考

[Streaming Kit API 文档](./API%20Reference/rsk_java/index.html)
