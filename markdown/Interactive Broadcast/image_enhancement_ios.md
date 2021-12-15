---
title: 美颜
platform: iOS
updatedAt: 2020-01-14 10:39:02
---

## 功能描述

在社交娱乐或教育场景中，用户进行视频通话或直播时，常常希望向对方呈现良好的肌肤状态和精神面貌。Agora SDK 提供 API 方法，帮助 App 轻松实现基础美颜功能。用户可以开启美颜开关，调整美白、磨皮、祛痘、红润效果等美颜参数，实现自然的美颜效果。

具体效果可参考下图：

![](https://web-cdn.agora.io/docs-files/1553753458997)

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./ios_video)。

Agora SDK 提供 [setBeautyEffectOptions](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setBeautyEffectOptions:options:) 方法帮助开发者根据场景需求灵活配置基础美颜功能。

该方法有 2 个参数：

`enabled` 代表是否开启美颜功能。
`options` 代表美颜选项，包含 `lighteningContrastLevel`（明暗对比度）、`lightening`（亮度）、`smoothness`（平滑度）、`redness`（红色度）四个参数，可用来实现美白、磨皮、红润等效果。

```swift
//swift
let options = AgoraBeautyOptions()
options.lighteningContrastLevel = .normal
options.rednessLevel = 0
options.smoothnessLevel = 0
options.lighteningLevel = 0

agoraKit.setBeautyEffectOptions(true, options: options)
```

```oc
//objective-c
AgoraBeautyOptions *options = [[AgoraBeautyOptions alloc] init];
options.lighteningContrastLevel = AgoraLighteningContrastNormal;
options.rednessLevel = 0;
options.smoothnessLevel = 0;
options.lighteningContrastLevel = 0;

[self.agoraKit setBeautyEffectOptions:YES options:options];
```

## 示例代码

Agora 提供已实现美颜功能的开源示例代码。你可以前往[OpenLive-iOS Github Repo](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS)下载。

## 开发注意事项

- 以上方法有返回值，返回值小于 0 表示方法调用失败。
- 美颜功能的开启会对低端机的性能造成影响，以至于无法达到预期的要求。对于低端机，视频编码设置为 360P 30fps，720P 15fps 或更高分辨率时，我们不建议开启美颜。
