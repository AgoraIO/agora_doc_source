---
title: 限定访问区域
platform: Unity
updatedAt: 2021-03-24 02:26:35
---

## 功能描述

为适应不同国家或地区的法律法规，声网支持限定访问区域功能，实现 SDK 只访问指定区域内的声网服务器，希望将音视频和消息数据传输限定在某一区域范围内。

假设你指定北美为访问区域，SDK 只访问北美区域内的声网服务器。无法分配可用的北美区域服务器时，SDK 会报错，而不是使用其他区域服务器替代。

<div class="alert note">该功能为高级设置，适用于有访问安全限制的场景。</div>

## 实现方法

Agora RTC Unity SDK 从 v3.0.1 起，支持限定区域访问。一旦指定了访问区域，音视频数据将不会访问指定区域以外的服务器。

你需要在调用 [`GetEngine`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1a02000088c915aa36065325f42d166) 方法创建 `IRtcEngine` 实例时，通过设置 `RtcEngineConfig` 的中的 `areaCode` 参数来指定访问区域。

- `AREA_CODE_GLOB`: （默认）全球。
- `AREA_CODE_CN`: 中国大陆。
- `AREA_CODE_NA`: 北美。
- `AREA_CODE_EU`: 欧洲。
- `AREA_CODE_AS`: 除中国大陆以外的亚洲区域。
- `AREA_CODE_JP`: 日本。
- `AREA_CODE_IN`: 印度。

<div class="alert note"><ul><li>上述区域码适用于 RTC Unity SDK v3.2.1 及之后版本。v3.2.1 之前版本的区域码可以参考各版本 API 文档。</li><li>区域码支持位操作。</li></ul></div>

## 示例代码

```C#
// 初始化 IRtcEngine 对象，并指定访问区域。
RtcEngineConfig mRtcEngineConfig = new RtcEngineConfig(appId, AREA_CODE.AREA_CODE_NA);
mRtcEngine = IRtcEngine.GetEngine(mRtcEngineConfig);
}
```

## 开发注意事项

如果你的网络环境部署了防火墙，使用该功能还需要根据[使用云代理](cloudproxy_native)添加防火墙白名单。
