---
title: 加入频道前的 API 调用
platform: All Platforms
updatedAt: 2021-02-02 02:33:43
---

本文介绍在加入频道（`joinChannel`）之前的 API 调用和设置。通常在加入频道前只需要简单调用一两个 API 即可快速实现实时音视频功能，但是如果你的应用场景对通话质量和稳定性有较高的要求，我们建议参考本文进行更多的设置。

如无特别说明，本文内容适用于 Agora RTC SDK 以下平台：

- Android
- iOS
- macOS
- Windows
- Electron
- Unity

<div class="alert note">阅读本文前请确保你已经了解如何实现一个<a href="https://docs.agora.io/cn/Video/start_call_android?platform=Android">音视频通话</a>或<a href="https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android">直播</a>。</div>

## 日志文件设置

为了确保 SDK 输出的日志信息完整，方便调查问题，我们建议在引擎初始化之后立即调用 `setLogFile` 设置日志文件，另外可以配合 `setLogFileSize`、`setLogFilter` 设置日志文件大小和输出等级，详见[如何设置日志文件](https://docs.agora.io/cn/faqs/logfile)。

## 音频设置

如果你的场景有高音质需求（例如音乐教学场景），建议在加入频道前调用 `setAudioProfile` 并将 `profile` 参数设置为 `MUSIC_HIGH_QUALITY`(4)，`scenario` 参数设置为 `GAME_STREAMING`(3)，更多的设置可以参考[设置音频属性](https://docs.agora.io/cn/Interactive%20Broadcast/audio_profile_android?platform=Android)。

<div class="alert note">不同平台的参数枚举值可能略有不同，请根据实际情况进行调整。</div>

## 视频设置

SDK 默认关闭视频功能，如果要使用视频，在加入频道之前调用 `enableVideo` 开启全局的视频功能。

`enableVideo` 会开启本地视频采集、编码、发送和远端视频接收，如果需要更精细的控制，可以调用以下 API：

- `enableLocalVideo`：是否启动摄像头采集并创建本地视频流。
- `muteLocalVideoStream`：是否发送本地视频流。
- `muteRemoteVideoStream`：是否接收并播放指定的远端视频流。
- `muteAllRemoteVideoStreams`：是否接收并播放所有远端视频流。

<div class="alert note">
	注意事项：
	<li>加入频道前不要同时调用 <code>enableLocalVideo</code> 和 <code>enableVideo</code>，如果两个方法都调用会导致摄像头打开两次以及加入频道时间变长。</li>
	<li>因为 <code>enableVideo</code> 方法会重置整个视频引擎，加入频道之后我们建议用精细控制的 API 关闭或打开视频。</li>
</div>

在加入频道前调用 `startPreview` 可以加快本地首帧出图时间，如果调用了 `startPreview`，在 `destroy` 之前**必须**调用 `stopPreview`。

## 与 Web 平台互通

如果你的应用场景中包括 Web 端，并且你使用的 Native SDK 版本在 3.0.0 之前，直播模式下一定要在加入频道前调用 `enableWebSdkInteroperability` 方法打开和 Web 端的互通。

<div class="alert info">从 3.0.0 版本开始无需调用该方法，Native SDK 默认打开和 Web 端的互通。</div>

## 高级设置

我们建议将高级设置预埋到应用的代码里，采用读取参数配置的方式，当出现异常的时候方便在专业人员的指导下快速便捷地调试解决，不需要为个例问题而单独发版。

### 设置音视频属性

通常对音质没有特殊要求可以使用默认的音频属性，但我们仍然建议在加入频道之前调用 `setAudioProfile`，当出现音频问题时方便调试 `profile` 和 `scenario` 的参数设置。

同理，对于有视频的场景，我们也建议在加入频道之前调用 `setVideoEncoderConfiguration`，出现视频问题时方便调试视频编码配置。

### Windows 平台

以下高级设置仅适用于 Windows 平台。

#### **音频处理**

部分 Windows 设备可能会因为系统处理导致音频异常，可以通过以下方法使用软件进行音频处理。

```c++
setParameters("{"che.audio.current.bypassSystemAPO": true}")
```

#### **视频采集**

如果遇到 Windows 设备的摄像头无法打开的情况，可以通过调试下面的设置尝试解决问题。

**采集方式设置**

SDK 默认的视频采集方式可能与部分摄像头不兼容，建议按照下面的代码设置视频采集方式。

```c++
setParameters("{"che.video.videoCaptureType", n}")
```

其中 `n` 的取值可以为：

- `0`: (默认) Direct Show 采集方式。
- `1`: Video for Windows (VfW) 采集方式。
- `2`: Media Foundation (MF) 采集方式，仅支持 Windows 7 及以后版本。
- `3`: New Direct Show 采集方式，声网对 Direct Show 进行优化后的采集方式。

**采集分辨率设置**

部分摄像头无法在某些分辨率打开，却可在其他分辨率打开，可以通过以下方法设置摄像头采集的分辨率。

```c++
setParameters("{"che.video.capture_width": width, "che.video.capture_height": height}")
```
