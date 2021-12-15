---
title: 美颜
platform: Windows
updatedAt: 2020-04-20 17:29:07
---

## 功能描述

在社交娱乐或教育场景中，用户进行视频通话或直播时，常常希望向对方呈现良好的肌肤状态和精神面貌。Agora SDK 提供 API 方法，帮助 App 轻松实现基础美颜功能。用户可以开启美颜开关，调整美白、磨皮、祛痘、红润效果等美颜参数，实现理想的美颜效果。

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./windows_video)。

Agora SDK 提供 [setBeautyEffectOptions]() 方法帮助开发者根据场景需求灵活配置基础美颜功能。

该方法有 2 个参数：

- `enabled` 代表是否开启美颜功能。
- `options` 代表美颜选项，包含 `lighteningContrastLevel`（明暗对比度）、`lightening`（亮度）、`smoothness`（平滑度）、`redness`（红色度）四个参数，可用来实现美白、磨皮、红润等效果。

```cpp
bool enabled = true; BeautyOptions options = agora::rtc::LIGHTENING_CONTRAST_LOW;
m_lpAgoraEngine->setBeautyEffectOptions(enabled, options); //美颜
```

### API 参考

[setBeautyEffectOptions]()

## 开发注意事项

以上方法有返回值，返回值小于 0 表示方法调用失败。
