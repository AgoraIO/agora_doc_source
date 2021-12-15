---
title: 动态码率推荐
platform: Linux
updatedAt: 2020-11-24 09:52:12
---

## 功能描述

为提升数据传输量和避免网络拥塞，RTSA Lite 会根据网络带宽状况的变化建议开发者实时调整发送码率。

## 实现方法

开发者可根据自己的实际带宽和码率需要，调用 `agora_rtc_set_bwe_param` 方法配置 BWE (BandWidth Estimation)，设置发送码率的最小值、最大值和起始值。

码流传输过程中，当网络带宽状况的变化时，SDK 会触发 `on_target_bitrate_changed` 回调，提示应用程序实时调整发送码率。

以下为示例代码，仅供参考：

```c
// Handle the bitrate change event
static void OnTargetBitrateChanged (const char *channel, uint32_t target_bps) {
    /** ----------------PERSUDO CODE -----------------
     *  Please replace it with specific implementation
     *  ----------------------------------------------
     */
    video_encoder_t *video_encoder_ptr = get_video_encoder(channel);
    video_encoder_ptr->set_target_bps(target_bps);
}

// Listen to the bitrate change event
static const agora_rtc_event_handler_t listener = {
    .on_target_bitrate_changed = OnTargetBitrateChanged,
    // ...
};

// Config initial BWE parameters
const int VIDEO_TARGET_BPS_MAX = 1 << 23; // 8 Mbps
const int VIDEO_TARGET_BPS_MIN = 1 << 16; // 64 Kbps
const int VIDEO_START_BPS = 300 * 1024;   // 300 Kbps

agora_rtc_set_bwe_param(VIDEO_TARGET_BPS_MIN, VIDEO_TARGET_BPS_MAX , VIDEO_START_BPS)
```

## API 参考

- [`on_dec_bitrate`](./API%20Reference/rtsa_c/structagora__rtc__event__handler__t.html#a7c5b33c2402058257cb5d0fbae017936)
- [`on_inc_bitrate`](./API%20Reference/rtsa_c/structagora__rtc__event__handler__t.html#a59ca58445eb0f2067ea281274129b8ca)

## 开发注意事项

- 这两个回调返回的是 bps，不要和 kbps 及 Bps 混淆。
