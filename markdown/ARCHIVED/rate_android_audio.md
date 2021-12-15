---
title: 给通话评分
platform: Android
updatedAt: 2018-12-27 15:33:28
---

## 功能描述

通话或直播结束后，让用户对通话/直播进行评分，可以收集用户对通话质量体验的主观评价，帮助改进产品。

Agora SDK 提供接口可以让你的用户为通话打分并提供反馈意见。

实现评分功能后，你可以在[水晶球](./aa_guide)的**通话调查**里看到用户对通话的评分，如下图所示：

![](https://web-cdn.agora.io/docs-files/1545801192291)

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端 ](./android_audio)。

```java
String callId = rtcEngine.getCallId();
rtcEngine.rate(callId, 5, "This is an awesome call!");
```

### API 参考

- [rate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab7083355af531cc43d455024bd1f7662)
- [getCallId](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa4d80e8de0e8ae4d2fd3f153945d289f)

## 开发注意事项

- 所有相关的方法都有返回值。返回值小于 0 表示方法调用失败
