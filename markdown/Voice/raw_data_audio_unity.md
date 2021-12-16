---
title: 原始音频数据
platform: Unity
updatedAt: 2020-02-18 22:12:25
---
## 功能描述

音频传输过程中，我们可以获取采集到的音频原始数据。

Agora Unity SDK 通过提供 `AudioRawDataManager` 类，实现采集原始音频数据功能。

## 实现方法

在使用原始音频数据功能前，请确保你已在项目中完成基本的实时音频功能，详见[实现音频通话](start_call_audio_unity)或[实现音频直播](start_live_audio_unity)。

参考如下步骤，在你的项目中实现原始音频数据功能：

1. 加入频道前调用 `RegisterAudioRawDataObserver` 方法注册音频观测器。

2. 成功注册后，根据需求调用以下方法：

   - 调用 `SetOnRecordAudioFrameCallback` 监听 `OnRecordAudioFrameHandler` 回调。SDK 会通过 `OnRecordAudioFrameHandler` 回调向用户发送采集到的原始音频数据。
   - 调用 `SetOnPlaybackAudioFrameCallback` 监听 `OnPlaybackAudioFrameHandler` 回调。SDK 会通过 `OnPlaybackAudioFrameHandler` 回调向用户发送播放的原始音频数据，即所有远端用户混音后的音频数据。
   - 调用 `SetOnMixedAudioFrameCallback` 监听 `OnMixedAudioFrameHandler` 回调。SDK 会通过 `OnMixedAudioFrameHandler` 回调向用户发送混音后的采集和播放的原始音频数据，即所有本地和远端用户混音后的音频数据。 
   - 调用 `SetOnPlaybackAudioFrameBeforeMixingCallback` 监听 `OnPlaybackAudioFrameBeforeMixingHandler` 回调。SDK 会通过 `OnPlaybackAudioFrameBeforeMixingHandler` 回调向用户发送指定远端用户混音前的原始音频数据。

3. 用户拿到音频数据后，根据场景需要自行进行处理。以通过 Unity `AudioSource` 组件播放音频原始数据为例，大致流程如下：

   - 创建一个有限队列。
   - 在步骤 2 中调用任意回调后，会返回 `buffer` 数据。在该队列后端插入回调返回的 `buffer` 数据。
   - 通过 `AudioClip` 组件的 `setData` 方法，从该队列前端按顺序取出 `buffer` 数据，并存入 `AudioClip` 组件。
   - 通过 `AudioSource` 组件播放 `AudioClip` 组件中的数据。

4. 离开频道后调用 `UnRegisterAudioRawDataObserver` 注销音频观测器。

### API 调用时序

下图展示使用原始音频数据的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1582031895689)

### 示例代码

你可以对照 API 时序图，参考下面的示例代码片段，在项目中实现原始音频数据功能：

```
void Start()
{
   // 初始化 IRtcEngine 对象。
   mRtcEngine = IRtcEngine.GetEngine(mVendorKey);
   // 获取 AudioRawDataManager 对象。
   AudioRawDataManager = AudioRawDataManager.GetInstance(mRtcEngine);
   // 注册音频观测器。
   mRtcEngine.RegisterAudioRawDataObserver();
   // 监听 OnRecordAudioFrameHandler delegate。
   AudioRawDataManager.SetOnRecordAudioFrameCallback(OnRecordAudioFrameHandler);
   // 监听 OnPlaybackAudioFrameHandler delegate。
   AudioRawDataManager.SetOnPlaybackAudioFrameCallback(OnPlaybackAudioFrameHandler);
   // 监听 OnMixedAudioFrameHandler delegate。
   AudioRawDataManager.SetOnMixedAudioFrameCallback(OnMixedAudioFrameHandler);
   // 监听 OnPlaybackAudioFrameBeforeMixingHandler delegate。
   AudioRawDataManager.SetOnPlaybackAudioFrameBeforeMixingCallback(OnPlaybackAudioFrameBeforeMixingHandler);
}
 
// 获取本地采集到的原始音频数据。
void OnRecordAudioFrameHandler(AudioFrame audioFrame);
{
   Debug.Log("OnRecordAudioFrameHandler");
}
 
// 获取从远端接收到的原始音频数据。
void OnPlaybackAudioFrameHandler(AudioFrame audioFrame);
{
   Debug.Log("OnPlaybackAudioFrameHandler");
}
 
// 获取本地和远端混音后的原始音频数据。
void OnMixedAudioFrameHandler(AudioFrame audioFrame);
{
   Debug.Log("OnMixedAudioFrameHandler");
}
 
// 获取指定本地或远端用户混音前的原始音频数据。
void OnPlaybackAudioFrameBeforeMixingHandler(AudioFrame audioFrame);
{
   Debug.Log("OnPlaybackAudioFrameBeforeMixingHandler");
}
 
public enum AUDIO_FRAME_TYPE 
{
   // 0: PCM16
   FRAME_TYPE_PCM16 = 0,
};
 
public struct AudioFrame 
{
   // 音频帧类型。详见 #AUDIO_FRAME_TYPE 。
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
   // 声音数据缓存区（如果是立体声，数据是交叉存储的）。缓存区数据大小：buffer = samples × channels × bytesPerSample。
   public byte[] buffer; 
   // 外部音频帧的渲染时间戳。你可以使用该时间戳还原音频帧顺序；在有视频的场景中（包含使用外部视频源的场景），该参数可以用于实现音视频同步。
   public long renderTimeMs;
   // 预留参数。
   public int avsync_type;
};
```

### API 参考

- [RegisterAudioRawDataObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a383ab15736c601371ef2c2a4adc222b6)
- [UnRegisterAudioRawDataObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#ab5a84bd4a281ba355723c94a53d5f440)
- [SetOnRecordAudioFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#aa9cfcbcf865a20a31985d804f01da015)
- [SetOnPlaybackAudioFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#af98e7659c8950e85cd49dfe0e3fcf8fc)
- [SetOnMixedAudioFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a14176fcaa8f7574c797c44e8510dd216)
- [SetOnPlaybackAudioFrameBeforeMixingCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a6c1cbace7f81de8004b4a7945c999bbb)
- [OnRecordAudioFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a11cc2a11aae003aad55972f1fa45902d)
- [OnPlaybackAudioFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a314bf23c8d6da5a534e7e3129c2db99f)
- [OnMixedAudioFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#ab48b7b118a31e6433d83d3fbe750d150)
- [OnPlaybackAudioFrameBeforeMixingHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a8396bcc09ad94c0ac25d0f0ce073fc9a)

如果想要修改上述回调中的音频采样率，可以根据场景需求，调用如下方法进行设置：

- [SetRecordingAudioFrameParameters](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a869d8e781cddb4db957338900b0154ad)
- [SetPlaybackAudioFrameParameters](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6ab86b7a541f1dc244e1cab3135935b4)
- [SetMixedAudioFrameParameters](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ae9dc5fb3c4fde9da875ed8cfa783c5ea)

## 开发注意事项

- Agora 推荐在频道外调用  `RegisterAudioRawDataObserver` 和 `UnRegisterAudioRawDataObserver` 方法。
- Agora Unity SDK 提供四种监听回调的方法，你可以独立使用各回调，无需全部调用。为避免浪费设备性能，请根据实际需求调用回调。