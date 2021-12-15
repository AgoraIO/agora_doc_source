---
title: 通话前探测网络质量
platform: Unity
updatedAt: 2020-02-28 11:00:23
---

## 功能描述

在加入频道或切换角色为主播前，进行网络质量探测，可以判断或预测用户当前的网络状况是否良好，可以满足音频码率或者当前选定的视频属性的目标码率。

在对网络质量要求高的场景下，Agora 建议在加入频道前进行探测，保证通信顺畅。

## 实现方法

开始检测网络质量前，请确保你已在项目中实现了基本的音视频通信或直播功能。详见快速开始：

- [实现语音通话](start_call_audio_unity)或[实现音频互动直播](start_live_audio_unity)
- [实现视频通话](start_call_unity)或[实现视频互动直播](start_live_unity)

1. 在用户加入频道或上麦前，调用 `StartLastmileProbeTest` 进行网络质量探测，向用户反馈上下行网络的带宽、丢包、网络抖动和往返时延。

2. 启用该方法后，SDK 会依次返回如下 2 个回调：

   - `OnLastmileQualityHandler`：约 2 秒内返回。该回调通过打分反馈上下行网络质量，更贴近主观感受
   - `OnLastmileProbeResultHandler`：约 30 秒内返回。该回调通过客观数据反馈上下行网络质量，更客观。

3. 获取到网络质量数据后，调用 `StopLastmileProbeTest` 停止通话前网络质量探测。

<div class="alert note">在测试结束前，Agora 建议不要调用其他 API 方法。</div>

### API 调用时序

参考如下时序在你的项目中实现通话前网络探测功能。

![](https://web-cdn.agora.io/docs-files/1582858685523)

### 示例代码

参考下文代码在你的项目中实现通话前网络探测功能。

```c#
// 注册回调接口。
// 开始 Last-mile 网络探测后，约 2 秒后发生该回调。
void OnLastmileQualityHandler(int quality)
{

}

// 开始 Last-mile 网络探测后，约 30 秒后发生该回调。
void OnLastmileProbeResultHandler(LastmileProbeResult result)
{
    //（1）可以选择在回调内部结束 Last-mile 网络探测。在测试结束前，Agora 建议不要调用其他 API 方法。
    mRtcEngine.StopLastmileProbeTest();
}

mRtcEngine.OnLastmileQuality = OnLastmileQualityHandler;
mRtcEngine.OnLastmileProbeResult = OnLastmileProbeResultHandler;
// 配置一个 LastmileProbeConfig 实例。
LastmileProbeConfig config = new LastmileProbeConfig();
// 确认探测上行网络质量。
config.probeUplink = true;
// 确认探测下行网络质量。
config.probeDownlink = true;
// 期望的最高发送码率，单位为 bps，范围为 [100000, 5000000]。
config.expectedUplinkBitrate = 100000;
// 期望的最高接收码率，单位为 bps，范围为 [100000, 5000000]。
config.expectedDownlinkBitrate = 100000;
// 加入频道前开始 Last-mile 网络探测。
mRtcEngine.StartLastmileProbeTest(config);
// （2）也可以选择其他时候结束 Last-mile 网络探测。在测试结束前，Agora 建议不要调用其他 API 方法。
mRtcEngine.StopLastmileProbeTest();
```

### API 参考

- [`StartLastmileProbeTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a1d70042741eed8fd27234d43f0bdd86e)
- [`StopLastmileProbeTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a7097b5aa40f1124c5cb5ae7cc68d636f)
- [`OnLastmileQualityHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ad91eb7212a21d5596d4a96dfedaa7753)
- [`OnLastmileProbeResultHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#afa2ac45e7687a97653fedb80c5346019)

## 开发注意事项

- Lastmile 测试必须在加入通话频道之前。在结束测试之前，Agora 不建议调用其他 API 方法。
- `OnLastmileQualityHandler` 回调第一次报告的结果有一定概率是 `unknown`, 可通过之后的几次回调获得结果。
- 纯语音产品使用 48 Kbps 的固定探测码率；视频产品会根据当前选定的视频属性调整探测码率。
