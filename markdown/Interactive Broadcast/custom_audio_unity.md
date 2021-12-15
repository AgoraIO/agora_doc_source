---
title: 自定义音频采集和渲染
platform: Unity
updatedAt: 2020-04-23 11:31:03
---

## 功能介绍

实时音视频传输过程中，Agora SDK 通常会启动默认的音视频模块进行采集和渲染。在以下场景中，你可能会发现默认的音视频模块无法满足开发需求：

- app 中已有自己的音频或视频模块
- 希望使用非 Camera 采集的视频源，如录屏数据
- 需要使用自定义的美颜库或有前处理库
- 某些视频采集设备被系统独占。为避免与其它业务产生冲突，需要灵活的设备管理策略

基于此，Agora Unity SDK 支持使用自定义的音视频源或渲染器，实现相关场景。本文介绍如何实现自定义音频采集和渲染。

## 实现方法

开始自定义采集和渲染前，请确保你已在项目中实现基本的通话或者直播功能，详见[实现语音通话](start_call_audio_unity)或[实现音频互动直播](start_live_audio_unity)。

### 自定义音频采集

参考如下步骤，在你的项目中实现自定义音频采集功能：

1. 加入频道前，通过调用 `SetExternalAudioSource` 指定外部音频采集设备。
2. 指定外部采集设备后，开发者自行管理音频数据采集和处理。
3. 完成音频数据处理后，再通过 `PushAudioFrame` 发送给 SDK 进行后续操作。

**示例代码**

参考下文代码在你的项目中实现自定义音频采集。

```c#
// 设置外部音频采集参数。
public int SetExternalAudioSource(bool enabled, int sampleRate, int channels)
{
    mRtcEngine.SetExternalAudioSource(enabled, sampleRate, channels);
}

// 推送外部音频帧。
public int PushAudioFrame(AudioFrame audioFrame)
{
    mRtcEngine.PushAudioFrame(audioFrame);
}

public struct AudioFrame
{
    // 音频帧类型。详见 #AUDIO_FRAME_TYPE。
    public AUDIO_FRAME_TYPE type;
    // 每个声道的采样点数。
    public int samples;
    // 每个采样点的字节数。通常为十六位，即两个字节。
    public int bytesPerSample;
    // 声道数量（如果是立体声，数据是交叉的）
    // - 1: 单声道。
    // - 2: 双声道。
    public int channels;
    // 采样率。
    public int samplesPerSec;
    // 声音数据缓存区（如果是立体声，数据是交叉存储的）。
    // 缓存区数据大小：buffer = samples × channels × bytesPerSample。
    public byte[] buffer;
    // 外部音频帧的渲染时间戳。你可以使用该时间戳还原音频帧顺序；在有视频的场景中（包含使用外部视频源的场景），该参数可以用于实现音视频同步。
    public long renderTimeMs;
    // 预留参数。
    public int avsync_type;
};
```

**API 参考**

- [`SetExternalAudioSource`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a91a7599be9ca163f0b43c83a4b3a902e)
- [`PushAudioFrame`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac7340e14573a6fdf089924b228555ba7)

### 自定义音频渲染

参考如下步骤，在你的项目中实现自定义音频渲染功能：

1. 加入频道前，通过调用 `SetExternalAudioSink` 开启并设置外部音频渲染。
2. 成功加入频道后，调用 `PullAudioFrame` 拉取远端发送的音频数据。
3. 开发者自行渲染并播放拉取到的音频数据。

**示例代码**

```c#
// 设置外部音频采集参数。
public int SetExternalAudioSource(bool enabled, int sampleRate, int channels)
{
    mRtcEngine.SetExternalAudioSource(enabled, sampleRate, channels);
}

// 拉取远端音频数据。
public int PullAudioFrame(IntPtr audioBuffer, int type, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int avsync_type)
{
    mRtcEngine.PullAudioFrame(audioBuffer, type, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, avsync_type);
}
```

**API 参考**

- [`SetExternalAudioSink`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac767651baab2797313e4c13db7f66260)
- [`PullAudioFrame`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a6aa04f6b4cf488d46bc64b39a11d891e)

## 注意事项

- 回调函数里处理音频数据要尽量高效，且保证算法稳定，避免影响整个客户端或产生崩溃。
- 需要设置 `RAW_AUDIO_FRAME_OF_MODE_READ_WRITE` 才可以读写和操作数据。
- 自定义音频采集和渲染场景中，需要开发者具有采集或渲染音频数据的能力：

  - 自定义音频采集场景中，你需要自行管理音频数据的采集和处理。
  - 自定义音频渲染场景中，你需要自行管理音频数据的处理和播放。
