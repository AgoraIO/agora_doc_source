---
title: 自定义音频采集和渲染
platform: Android
updatedAt: 2021-01-13 03:49:21
---

## 功能介绍

实时音频传输过程中，Agora SDK 通常会启动默认的音频模块进行采集和渲染。在以下场景中，你可能会发现默认的音频模块无法满足开发需求：

- app 中已有自己的音频模块
- 需要使用自定义的前处理库
- 某些音频采集设备被系统独占。为避免与其它业务产生冲突，需要灵活的设备管理策略

基于此，Agora Native SDK 支持使用自定义的音频源或渲染器，实现相关场景。本文介绍如何实现自定义音频采集和渲染。

## 示例代码

我们在 GitHub 上提供一个开源的[示例项目](https://github.com/AgoraIO/API-Examples/tree/master/Android/APIExample)，你可以前往下载，或查看其中的源代码。

## 实现方法

开始自定义采集和渲染前，请确保你已在项目中实现基本的通话或者直播功能，详见[一对一通话](https://docs.agora.io/cn/Voice/start_call_audio_android?platform=Android)或[互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_audio_android?platform=Android)。

### 自定义音频采集

参考如下步骤，在你的项目中实现自定义音频采集功能：

1. `joinChannel` 前，通过调用 `setExternalAudioSource` 指定音频源。
2. 指定音频源后，开发者自行管理音频数据采集和处理。
3. 完成音频数据处理后，再通过 `pushExternalAudioFrame` 发送给 SDK 进行后续操作。

#### **API 时序图**

参考下图时序在你的项目中实现自定义音频采集。

![img](https://web-cdn.agora.io/docs-files/1568966776336)

#### 数据流转图

自定义音频采集的数据流转如下：

![](https://web-cdn.agora.io/docs-files/1607660076905)

- 你必须自行开发采集模块
- 使用 `pushExternalAudioFrame` 将音频帧推送给 SDK

#### 示例代码

参考下文代码在你的项目中实现自定义音频采集。

1. 在本地用户加入频道前，指定音频源。

```java
// 指定音频源
engine.setExternalAudioSource(true, DEFAULT_SAMPLE_RATE, DEFAULT_CHANNEL_COUNT);
// 本地用户加入频道
int res = engine.joinChannel(accessToken, channelId, "Extra Optional Data", 0);
```

2. 本地用户加入频道成功后，使用自采集模块采集音频帧。

```java
public void onJoinChannelSuccess(String channel, int uid, int elapsed)
        {
            Log.i(TAG, String.format("onJoinChannelSuccess channel %s uid %d", channel, uid));
            showLongToast(String.format("onJoinChannelSuccess channel %s uid %d", channel, uid));
            myUid = uid;
            joined = true;
            handler.post(new Runnable()
            {
                @Override
                public void run()
                {
                    mute.setEnabled(true);
                    join.setEnabled(true);
                    join.setText(getString(R.string.leave));
                }
            });
            // 开始采集音频。自采集模块使用了 Android 原生的 AudioRecord 类实现音频采集
            startAudioRecord();
        }
```

3. 将音频帧推送给 SDK。

```java
public void run()
        {
            // 开启音频采集，如果音频采集未停止，则读取并推送音频帧
            try
            {

                audioRecord.startRecording();
                while (!stopped)
                {
                    // 读取采集的音频帧
                    int result = audioRecord.read(buffer, 0, buffer.length);
                    if (result >= 0)
                    {
                        // 将音频帧推送给 SDK
                        CustomAudioSource.engine.pushExternalAudioFrame(
                                buffer, System.currentTimeMillis());
                    }
                    else
                    {
                        logRecordError(result);
                    }
                    Log.e(TAG, "数据大小:" + result);
                }
                release();
            }
            catch (Exception e)
            {e.printStackTrace();}
        }
```

#### API 参考

- [`setExternalAudioSource`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5e5630afd7104ee7be8b246ae004efb3)
- [`pushExternalAudioFrame`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9e219a679d066cfc2544b5e8f9d4d69f)

### 自定义音频渲染

参考如下步骤，在你的项目中实现自定义音频渲染功能：

1. `joinChannel` 前，通过调用 `setExternalAudioSink` 开启并设置外部音频渲染。
2. 成功加入频道后，调用 `pullPlaybackAudioFrame` 拉取远端发送的音频数据。
3. 开发者自行渲染并播放拉取到的音频数据。

#### API 时序图

参考下图时序在你的项目中实现自定义音频渲染。

![img](https://web-cdn.agora.io/docs-files/1568966971796)

#### 数据流转图

自定义音频渲染的数据流转如下：

![](https://web-cdn.agora.io/docs-files/1607672646235)

- 你必须自行开发渲染模块
- 使用 `pullPlaybackAudioFrame` 拉取远端发送的音频数据

#### 示例代码

参考下文代码在你的项目中实现自定义音频渲染。

```java
// 首先开启自定义音频渲染
rtcEngine.setExternalAudioSink(
    true,      // 开启外部音频渲染
    44100,     // 采样率，可以有8 k，16 k，32 k，44.1 k 和 48 kHz 等模式
    1          // 外部音源的通道数，最多 2 个
);

// 主动拉取远端音频帧进行播放
rtcEngine.pullPlaybackAudioFrame(
    data,             // byte[] 类型的音频数据
    lengthInByte      // 拉取的音频数据的字节数，单位为 byte
);
```

#### API 参考

- [`setExternalAudioSink`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)

## 开发注意事项

自定义音频采集和渲染场景中，需要开发者具有采集或渲染音频数据的能力：

- 自定义音频采集场景中，你需要自行管理音频数据的采集和处理。
- 自定义音频渲染场景中，你需要自行管理音频数据的处理和播放。
