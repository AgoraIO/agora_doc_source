---
title: 媒体播放器组件发版说明
platform: Android
updatedAt: 2021-03-26 07:17:57
---
本文提供媒体播放器组件的发版说明。

<div class="alert note">相关发版说明：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/mediaplayer_release_ios?platform=iOS"> 发版说明（iOS）</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/mediaplayer_release_mac?platform=macOS"> 发版说明（macOS）</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/mediaplayer_release_win?platform=Windows"> 发版说明（Windows）</a></div>

## 简介
媒体播放器组件是 Agora 针对音视频直播场景研发的媒体播放器插件，与 Agora Native SDK（2.4.0 或更高版本）兼容。

该插件通过精简、灵活的 API，帮助开发者在实时音视频直播中，实现媒体资源播放功能，将主播播放的本地或在线媒体资源分享给频道内所有用户欣赏。详见如下文档：

- [集成指南](./mediaplayer_android?platform=Android)
- [API 文档](./API%20Reference/mediaplayer_java/index.html)

为获取更多直播玩法和更好的实时互动体验，我们推荐你在如下场景中使用媒体播放器组件：
- 本地播放场景：播放本地或在线媒体资源。
- 在线教育场景：网络授课时，老师给学生分享一个视频。
- 赛事直播场景：主播直播时，给观众分享一个比赛的在线视频。
- 伪直播场景：将主播提前录好的视频分享给观众，制造一个伪直播。

## 1.2.3 版

该版本于 2021 年 3 月 1 日发布。

改进和问题修复如下：

- `open` 和 `seek` 方法中设置播放位置的参数单位由秒改为毫秒。
- 通过 `getDuration` 方法获取的时间单位由秒改为毫秒。
- 新增支持播放 WebM 格式的媒体资源。
- 修复开始播放媒体资源时有明显的黑屏等待时间的问题。

## 1.2.2 版

该版本于 2021 年 1 月 13 日发布。

该版本修复了与 Agora Native SDK 3.2.0 及以后版本不兼容的问题。

## 1.2.1 版

该版本于 2020 年 12 月 31 日发布。

### 升级必看

自该版本起，MediaPlayer Kit 包中新增 `libagora-ffmpeg.so` 文件。如果你将 MediaPlayer Kit 升级到 v1.2.1 或更高版本，请务必将上述文件拷贝至 `libAgoraMediaPlayer.so` 所在文件夹中。

### 新增特性

**1. 拓展播放功能**

为满足多样化的播放需求，该版本新增如下 API：

- `changePlaybackSpeed`: 改变播放速度。比如倍速播放。
- `selectAudioTrack`: 选择播放的音轨。

**2. 在线缓冲提示**

该版本新增在线缓冲提示。播放在线媒体资源时，MediaPlayer Kit 每隔一秒触发一次 `onPlayBufferUpdated` 回调，报告当前缓冲的数据能够支持多久的播放。

**3. 获取 Kit 版本号**

自该版本起，你可以通过 `getPlayerSdkVersion` 方法获取当前使用的 MediaPlayer Kit 的版本号。

**4. 设置私有选项**

为满足开发者的特殊需求，该版本新增 `setPlayerOption` 和 `setPlayerOptionString` 方法，以设置 MediaPlayer Kit 的私有选项。一般情况下，你可以直接使用默认的私有选项设置，无需了解该方法的具体用法。

**5. 设置日志文件**

为支持开发者自定义日志文件，该版本新增如下 API：

- `setLogFile`: 设置日志文件路径。
- `setLogFilter`: 设置输出日志的过滤等级。

### 改进

**1. 媒体附属信息**

为解析更多类型的 SEI 数据，如 Agora CDN 直播推流服务中发送的 SEI 数据，自该版本起，`onMetaData` 回调的触发时机发生改动：

| 1.2.1 版之前 | 1.2.1 版或之后  |
|-----------|-----------|
| 当 MediaPlayer Kit 接收到的 SEI 的 type 为 5 时| 当 MediaPlayer Kit 接收到的 SEI 的 type 为 5 或 100 时|

**2. 默认音量类型**

为贴近用户使用习惯，自该版本起，MediaPlayer Kit 默认走媒体音量。相比通话音量，媒体音量具有更好的声音表现力且可以调整为 0，更适用于播放音视频。

**3. 获取播放进度**

为支持开发者获取到更精确的播放进度，自该版本起，`getPlayPosition` 返回的播放进度的单位由秒更改为毫秒。

**4. 播放格式**

自该版本起，MediaPlayer 新增支持播放更多 codec 格式的音视频：

- Vorbis （解码 codec）
- HEVC/H.265（编码 codec）


## 1.1.4.0 版

该版本于 2020 年 8 月 19 日发布。

改进和问题修复如下：
- 降低了播放时设备的性能消耗。
- 减少了 MediaPlayer Kit 包体积。
- 修复了偶现的崩溃和应用程序无响应问题。

## 1.1.2 版

该版本于 2020 年 6 月 15 日发布。

新增特性和改进如下：
- 新增支持 X86_64 架构。
- 新增支持使用 MediaPlayer Kit C++ API。
- 优化 MediaPlayer Kit 包的结构。

## 1.1.1 版

该版本于 2020 年 5 月 11 日发布。

该版本修复了部分特殊视频文件播放异常的问题。

## 1.1.0 版
该版本于 2020 年 2 月 28 日发布。

这是媒体播放器组件的第一个版本，你可以在项目中使用它实现如下功能：

#### 1.共享媒体资源
主播端播放本地或在线音视频，同步分享给频道内的所有用户，实现更多直播玩法。

#### 2. 同时播放多个媒体资源
通过创建多个 AgoraMediaPlayerKit 实例，实现同时播放多个媒体资源，满足主播多种直播需求。

#### 3. 播放控制
打开、播放、暂停播放、恢复播放、定位播放该媒体资源，实现即时的播放控制。

#### 4. 精准音量控制
分别调节本地和远端的播放音量，精准地控制不同阶段的播放音量，同时照顾播放端和订阅端的用户体验。

#### 5. 获取播放信息
通过调用相关方法主动获取播放相关的各种信息，如当前播放进度、状态和媒体流的详细信息。

#### 6. 注册观测器监听事件
观测器中包含一系列事件，如播放进度、播放状态和定位状态。通过监听这些事件，你可以更好地掌握播放过程。当播放发生异常时，你可以通过这些事件来排查问题。

此外，你还可以监听媒体附属信息、每帧音频帧和每帧视频帧的接收事件，实现更为复杂的功能满足多种场景需求，如使用自定义格式数据、录制音频、录制视频和截图。
