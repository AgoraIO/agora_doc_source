---
title: 如何选择视频分辨率、帧率、码率？
platform: ["Android", "iOS", "macOS", "Web", "Windows", "Unity", "Electron", "React Native", "Flutter"]
updatedAt: 2020-07-09 12:03:02
Products: ["Video", "Interactive Broadcast", "live-streaming"]
---

通常来讲，视频参数的选择要根据产品实际情况来确定，比如，如果是 1 对 1，老师和学生的窗口比较大，要求分辨率会高一点，随之帧率和码率也要高一点；如果是 1 对 4， 老师和学生的窗口都比较小，分辨率可以低一点，对应的码率帧率也会低一点，以减少编解码的资源消耗和缓解下行带宽压力。一般可按下列场景中的推荐值进行设置。

- 2 人视频通话场景：
  - 分辨率 320 x 240、帧率 15 fps、码率 200 Kbps
  - 分辨率 640 x 360、帧率 16 fps、码率 400 Kbps
- 多人视频通话场景：
  - 分辨率 160 x 120、帧率 15 fps、码率 65 Kbps
  - 分辨率 320 x 180、帧率 15 fps、码率 140 Kbps
  - 分辨率 320 x 240、帧率 15 fps、码率 200 Kbps

如果你希望自定义视频参数，比如调高码率以保证视频质量，也可以使用 setVideoEncoderConfiguration 对各参数进行自定义设置。高分辨率、帧率、码率会提高视频的清晰度，但同时也可能导致卡顿，并引起计费增加。

通常的，直播场景下需要较大码率来提升视频质量。因此 Agora 建议将直播码率值设为通信值的 2 倍。详情请参考[设置码率](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8)。
