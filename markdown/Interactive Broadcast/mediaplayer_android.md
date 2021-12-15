---
title: 媒体播放器组件
platform: Android
updatedAt: 2020-12-16 09:00:25
---

## 功能描述

媒体播放器组件（MediaPlayer Kit）是一款功能强大的播放器，支持播放本地或在线的媒体资源。通过该播放器，你可以本地播放媒体资源，或将媒体资源同步分享给 Agora 频道内的远端用户观看/收听。

### 使用须知

- 目前支持播放的媒体格式：AVI、MP4、MKV 和 FLV 格式的本地文件，RTMP 和 RTSP 协议的在线媒体流。
- 本地播放媒体资源时，只需单独使用 MediaPlayer Kit。分享媒体资源到远端时，需同时使用 MediaPlayer Kit，Agora RTC Native SDK 和 RtcChannelPublishHelper 三者。其中，MediaPlayer Kit 支持本地用户使用播放器功能，RTC Native SDK 支撑本地用户和远端用户的实时音视频直播场景，RtcChannelPublishHelper 支持将播放的媒体流发送给 Agora 频道中远端用户。
- 分享媒体资源到远端时，播放器的画面会抢占主播摄像头采集的画面。所以，如果你希望远端用户同时看到主播和播放器的画面，则需另起一个进程来采集主播的画面。

## 准备开发环境

### 前提条件

- Android Studio 3.0 或以上版本
- Android SDK API 等级 16 或以上
- 支持 Android 4.1 或以上版本的移动设备

> 如果你的网络环境部署了防火墙，请根据[应用企业防火墙限制](https://docs.agora.io/cn/AgoraPlatform/firewall?platform=AllPlatforms)打开相关端口。
>
> 分享媒体资源到远端时，还需有效的 Agora 账户（免费[注册](https://dashboard.agora.io/)）。

### 创建项目

参考以下步骤创建一个 Android 项目。

 <details>
<summary><font color="#3ab7f8">创建 Android 项目</font></summary>
	
1. 打开 <b>Android Studio</b>，点击 <b>Start a new Android Studio project</b>。 
	
2. 在 <b>Choose your project</b> 界面，选择 <b>Phone and Tablet</b> > <b>Empty Activity</b>，然后点击 <b>Next</b>。

3. 在 <b>Configure your project</b> 界面，依次填入以下内容：

   - <b>Name</b>：你的 Android 项目名称，如 MediaPlayer
   - <b>Package name</b>：你的项目包的名称，如 io.agora.mediaplayer
   - <b>Project location</b>：项目的存储路径
   - <b>Language</b>：项目的编程语言，如 Java
   - <b>Minimum API level</b>：项目的最低 API 等级

然后点击 <b>Finish</b>。根据屏幕提示，安装可能需要的插件。

</details>

### 集成 MediaPlayer Kit

1. 前往[下载](https://docs.agora.io/cn/AgoraPlatform/downloads)页面，下载最新版 MediaPlayer Kit，然后解压。

2. 将 MediaPlayer Kit 的如下文件，拷贝到你的项目路径下：

   | 文件或文件夹              | 项目路径               |
   | :------------------------ | :--------------------- |
   | AgoraMediaPlayer.jar 文件 | /app/libs/             |
   | arm-v8a 文件夹            | /app/src/main/jniLibs/ |
   | armeabi-v7a 文件夹        | /app/src/main/jniLibs/ |
   | x86 文件夹                | /app/src/main/jniLibs/ |
   | x86_64 文件夹             | /app/src/main/jniLibs/ |

3. 在 /app/src/main/AndroidManifest.xml 中添加如下内容，配置需要的设备权限。

   ```java
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   ```

   如果你的 `targetSdkVersion` >= 29，还需要在 AndroidManifest.xml 文件的 `<application>` 区域添加如下行：

   ```java
   <application
         android:requestLegacyExternalStorage="true">
         ...
   </application>
   ```

### 集成 RTC Native SDK

**版本要求**：2.4.1 或更高版本。

集成步骤：参考[集成 RTC SDK ](https://docs.agora.io/cn/InteractiveBroadcast/start_live_android?platform=Android#集成-sdk)。

### 集成 RtcChannelPublishHelper

**版本要求**：与你使用的 RTC Native SDK 版本号一致。

集成步骤：

1. [下载]() RtcChannelPublishHelper 的 '.aar' 包。

2. 将 aar 包拷贝到 /app/libs 路径下。

3. 在 /app/build.gradle 文件中，添加以下内容：

   - 在 `android` 节点中添加以下内容，指定 aar 包的文件存放位置。

     ```java
     repositories {
         flatDir {
             dirs 'libs'
      }
     }
     ```

   - 在 `dependencies` 节点中添加以下内容，指定需要导入的 aar 包名。

     ```java
     implementation(name:'RtcChannelPublishHelper-release',ext:'aar')
     ```

## 实现方法

<a name="local"></a>

### 本地播放媒体资源

集成 MediaPlayer Kit 后，参考如下步骤实现本地播放功能。

**创建一个播放器实例**

创建一个 `AgoraMediaPlayerKit` 实例。

> 如需同时播放不同的媒体资源，你可以创建多个实例。

**注册一个播放器观测器对象**

1. 实现 `MediaPlayerObserver` 接口，并实例化 `MediaPlayerObserver` 对象。
2. 调用 `AgoraMediaPlayerKit` 接口的 `registerPlayerObserver` 方法注册一个播放器的观测器对象（`playerObserver`），监听以下播放事件：
   - `onPositionChanged`，报告当前播放进度
   - `onPlayerStateChanged`，报告播放状态改变
   - `onPlayerEvent`，报告定位播放状态
   - `onMetaData`，报告媒体附属信息（metadata）的接收

通过监听这些事件，你可以更好地掌握播放过程，并使用自定义格式数据（媒体附属信息）。如果播放发生异常，你可以根据这些事件排查问题。

**注册一个音频观测器对象**

1. 实现 `AudioFrameObserver` 接口，并实例化 `AudioFrameObserver` 对象。
2. 调用 `AgoraMediaPlayerKit` 接口的 `registerAudioFrameObserver` 方法注册一个音频观测器对象（observer），监听每帧音频帧的接收事件。获取到 `AudioFrame` 后你可以对音频进行录制。

**注册一个视频观测器对象**

1. 实现 `VideoFrameObserver` 接口，并实例化 `VideoFrameObserver` 对象。
2. 调用 `AgoraMediaPlayerKit` 接口的 `registerVideoFrameObserver` 方法注册一个视频观测器对象（observer），监听每帧视频帧的接收事件。获取到 VideoFrame 后你可以对视频进行录制和截图。

**准备播放**

1. 调用 `AgoraMediaPlayerKit` 接口的 `setView` 方法设置播放器的渲染视图。

2. 调用 `AgoraMediaPlayerKit` 接口的 `setRenderMode` 方法设置播放器视图的渲染模式。

3. 调用 `AgoraMediaPlayerKit` 接口的 `open` 方法打开媒体资源。媒体资源路径可以为网络路径或本地路径，支持绝对路径和相对路径。

   > 请收到 `onPlayerStateChanged` 回调报告播放状态为 `PLAYER_STATE_OPEN_COMPLETED`(2) 后再进行下一步操作。

4. 调用 `AgoraMediaPlayerKit` 接口的 `play` 方法本地播放该媒体资源。

**调节播放设置**

调用 `AgoraMediaPlayerKit` 接口的其他方法，你可以实现如下播放设置：

1. 暂停/恢复播放，调节播放进度，调节本地播放音量等。
2. 获取媒体资源总时长，获取播放进度，获取当前播放状态，获取该媒体资源中媒体流的个数和每个媒体流的详细信息。

**结束播放**

1. 调用 `AgoraMediaPlayerKit` 接口的 `stop` 方法停止播放。
2. （可选）调用 `AgoraMediaPlayerKit` 接口的 `unregisterPlayerObserver` 方法取消注册该播放器观测器对象。
3. 调用 `AgoraMediaPlayerKit` 接口的 `destroy` 方法销毁 `AgoraMediaPlayerKit` 实例。

**示例代码**

```java
AgoraMediaPlayerKit agoraMediaPlayerKit1 = new AgoraMediaPlayerKit(this.getActivity());

agoraMediaPlayerKit1.registerPlayerObserver(new MediaPlayerObserver() {
    @Override
 public void onPlayerStateChanged(MediaPlayerState state, MediaPlayerError error) {
        LogUtil.i("agoraMediaPlayerKit1 onPlayerStateChanged:"+state+" "+error);
 }

    @Override
 public void onPositionChanged(final long position) {
        LogUtil.i("agoraMediaPlayerKit1 onPositionChanged:"+position+" duration:"+player1Duration);
   }

    @Override
 public void onPlayerEvent(MediaPlayerEvent eventCode) {
        LogUtil.i("agoraMediaPlayerKit1 onEvent:"+eventCode);
 }

    @Override
 public void onMetaData(final byte[] data) {
        LogUtil.i("agoraMediaPlayerKit1 onMetaData "+ new String(data));
 }
});

 agoraMediaPlayerKit1.registerVideoFrameObserver(new VideoFrameObserver() {
     @Override
 public void onFrame(VideoFrame videoFrame) {
        LogUtil.i("agoraMediaPlayerKit1 video onFrame :"+videoFrame);
 }
});

 agoraMediaPlayerKit1.registerAudioFrameObserver(new AudioFrameObserver() {
     @Override
 public void onFrame(AudioFrame audioFrame) {
        LogUtil.i("agoraMediaPlayerKit1 audio onFrame :"+audioFrame);
 }
 });

agoraMediaPlayerKit1.open("/sdcard/test.mp4",0);
agoraMediaPlayerKit1.play();
agoraMediaPlayerKit1.stop();
```

### 分享媒体资源到远端

集成 MediaPlayer Kit、Agora RTC Native SDK 和 RtcChannelPublishHelper 后，参考如下步骤将本地用户使用播放器播放的媒体资源分享给 Agora 频道内的远端用户。

**实例化**

1. [实例化 RtcEngine](https://docs.agora.io/cn/InteractiveBroadcast/start_live_android?platform=Android#4-初始化-rtcengine)
2. 实例化 AgoraMediaPlayerKit 和 RtcChannelPublishHelper

**播放器完成准备工作**

参考[本地播放媒体资源](#local)，**注册播放器、音频和视频的观测器对象**，完成**准备播放。**

> 请收到 `onPlayerStateChanged` 回调报告播放状态为 `PLAYER_STATE_PLAYING (3)` 后再进行下一步操作。

**本地用户加入频道**

参考 [RTC 快速开始](https://docs.agora.io/cn/InteractiveBroadcast/start_live_android?platform=Android#5-设置频道模式)，实现本地用户以主播身份加入 Agora 直播频道：

1. 调用 `setChannelProfile` 方法设置频道模式为直播。
2. 调用 `setClientRole` 方法设置本地用户角色为主播。
3. 调用 `enableVideo` 方法开启视频模块。
4. 调用 `joinChannel` 方法使本地用户加入频道。

> 请收到 `onJoinChannelSuccess` 回调后再进行下一步操作。

**开始分享**

1. 调用 `attachPlayerToRtc` 方法将播放器和 Agora 频道捆绑。播放器画面将占据本地用户视图。

2. 调用 `publishVideo`/`publishAudio` 方法将播放的视频/音频流分享给 Agora 频道内远端用户。

3. 调用 `adjustPublishSignalVolume` 方法调节远端用户听到的本地用户音量（`microphoneVolume`）和播放音量（`movieVolume`）。

   > 音量的取值范围为 0 到 400，其中 100 代表原始音量，400 代表最大音量可为原始音量的 4 倍（自带溢出保护）。

**取消分享**

1. 调用 `unpublishVideo`/`unpublishAudio` 方法取消分享该视频/音频流。

   > 远端用户将看到播放画面暂停。

2. 调用 `detachPlayerFromRtc` 方法将播放器和 Agora 频道解绑。播放器画面不再占据本地用户视图。

3. 调用 `release` 方法释放 `RtcChannelPublishHelper。`

> 本地用户离开频道（`leaveChannel`）后，分享的视频/音频流不会中断。只有 `unpublishVideo`/`unpublishAudio` 方法才能取消分享。

**示例代码**

```java
RtcEngine mRtcEngine = RtcEngine.create（context,appid,null);
RtcEngine agoraMediaPlayerKit = new AgoraMediaPlayerKit(context)；
RtcChannelPublishHelper rtcChannelPublishHelper = RtcChannelPublishHelper.getInstance();

rtcChannelPublishHelper.attachPlayerToRtc(agoraMediaPlayerKit,mRtcEngine);


rtcChannelPublishHelper.publishVideo()
rtcChannelPublishHelper.publishAudio()
rtcChannelPublishHelper.unpublishVideo()
rtcChannelPublishHelper.unpublishAudio()

rtcChannelPublishHelper.detachPlayerFromRtc();
rtcChannelPublishHelper.release();
```

## API 文档

详见 [API 文档](./API%20Reference/mediaplayer_java/1.1.0/index.html)
