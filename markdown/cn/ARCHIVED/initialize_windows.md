---
title: 创建 AgoraRtcEngine 实例并初始化
platform: Windows
updatedAt: 2019-10-29 11:00:19
---
在创建 AgoraRtcEngine 实例并初始化前，请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](/cn/Voice/windows_video)。

## 实现方法
进入频道之前，调用 <code>create</code> 方法创建一个 AgoraRtcEngine 实例，并调用 <code>initialize</code> 方法完成初始化。

填入获取到的 App ID 。只有 App ID 相同的应用程序才能进入同一个频道进行互通。

```
m_lpAgoraObject = new CAgoraObject();
m_lpAgoraEngine = createAgoraRtcEngine();
RtcEngineContext ctx;

ctx.eventHandler = &m_EngineEventHandler;
ctx.appId = lpVendorKey;

m_lpAgoraEngine->initialize(ctx);
```

> 请确保在调用其他 API 前先调用 `create` 和 `initialize` 方法创建并初始化 AgoraRtcEngine。

## 相关文档
完成创建实例后，你可以使用 Agora SDK，依次实现如下功能进行语音通话：

- [加入频道](/cn/Voice/join_communication_windows)
- [发布和订阅音频流](/cn/Voice/publish_windows_audio)

如果对网络或音质有特殊需求，你还可以在加入频道前：

- [进行通话前网络质量测试](/cn/Voice/lastmile_windows)
- [使用双声道/高音质](/cn/Voice/audio_profile_windows)
