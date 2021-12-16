---
title: 限定访问区域
platform: iOS
updatedAt: 2021-03-24 02:17:25
---
## 功能描述

为适应不同国家或地区的法律法规，声网支持限定访问区域功能，实现 SDK 只访问指定区域内的声网服务器，希望将音视频和消息数据传输限定在某一区域范围内。

假设你指定北美为访问区域，SDK 只访问北美区域内的声网服务器。无法分配可用的北美区域服务器时，SDK 会报错，而不是使用其他区域服务器替代。

<div class="alert note">该功能为高级设置，适用于有访问安全限制的场景。</div>

## 实现方法

Agora RTC Native SDK 从 v3.0.0.2 起，支持限定区域访问。一旦指定了访问区域，音视频数据将不会访问指定区域以外的服务器。

你需要在调用 [`initialize`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac71db65e66942e4e0a0550e95c16890f) 方法创建 `IRtcEngine` 实例时，通过设置 `RtcEngineContext` 的中的 `areaCode` 参数来指定访问区域。

对于 v3.0.0.2、v3.0.1、和 v3.0.1.1，区域码为：

- `AREA_CODE_GLOBAL`: （默认）全球。
- `AREA_CODE_CN`: 中国大陆。
- `AREA_CODE_NA`: 北美。
- `AREA_CODE_EUR`: 欧洲。
- `AREA_CODE_AS`: 除中国大陆以外的亚洲区域。

v3.1.0 在上述区域码的基础上新增了：

- `AREA_CODE_JAPAN`: 日本。
- `AREA_CODE_INDIA`: 印度。

对于 v3.1.1 及以后版本，区域码为：

- `AREA_CODE_GLOB`: （默认）全球。
- `AREA_CODE_CN`: 中国大陆。
- `AREA_CODE_NA`: 北美。
- `AREA_CODE_EU`: 欧洲。
- `AREA_CODE_AS`: 除中国大陆以外的亚洲区域。
- `AREA_CODE_JP`: 日本。
- `AREA_CODE_IN`: 印度。

<div class="alert note">仅支持指定单个访问区域。</div>

## 示例代码

```C++
IRtcEngine  *m_lpAgoraEngine = NULL;
RtcEngineContext ctx;
 
if(m_lpAgoraEngine == NULL)
    m_lpAgoraEngine = createAgoraRtcEngine();
ctx.eventHandler = &m_EngineEventHandler;
ctx.appId = appId;
if (hWnd != NULL)
    ctx.context = hWnd;
// 指定仅访问北美的服务器。
ctx.areaCode = rtc::AREA_CODE_NA;
m_lpAgoraEngine->initialize(ctx);
```

## 开发注意事项

如果你的网络环境部署了防火墙，使用该功能还需要根据[使用云代理](cloudproxy_native)添加防火墙白名单。