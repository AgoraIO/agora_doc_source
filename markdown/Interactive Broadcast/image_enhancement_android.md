---
title: 美颜
platform: Android
updatedAt: 2020-03-09 13:07:17
---

## 功能描述

在社交娱乐或教育场景中，用户进行视频通话或直播时，常常希望向对方呈现良好的肌肤状态和精神面貌。Agora SDK 提供 API 方法，帮助 App 轻松实现基础美颜功能。用户可以开启美颜开关，调整美白、磨皮、祛痘、红润效果等美颜参数，实现自然的美颜效果。

具体效果可参考下图：

![](https://web-cdn.agora.io/docs-files/1553753110307)

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端 ](./android_video)。

Agora SDK 提供 [setBeautyEffectOptions](./API%20Reference/java/v2.4.0/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa9327de4fb0c29f840b1e68ca2e83fc6) 方法帮助开发者根据场景需求灵活配置基础美颜功能。

该方法有 2 个参数：

- `enabled` 代表是否开启美颜功能。
- `options` 代表美颜选项，包含 `lighteningContrastLevel`（明暗对比度）、`lightening`（亮度）、`smoothness`（平滑度）、`redness`（红色度）四个参数，可用来实现美白、磨皮、红润等效果。

```java
mRtcEngine.setBeautyEffectOptions(true, new BeautyOptions(LIGHTENING_CONTRAST_NORMAL, 0.5F, 0.5F, 0.5F));
```

## 开发注意事项

以上方法有返回值，返回值小于 0 表示方法调用失败。
