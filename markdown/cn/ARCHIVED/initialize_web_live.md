---
title: 创建并初始化 Client 对象
platform: Web
updatedAt: 2019-01-24 13:26:25
---
在创建并初始化 Client 对象前，请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](/cn/Interactive%20Broadcast/web_prepare)。

## 实现方法
### 创建 Client 对象
用 `AgoraRTC.createClient` 方法创建 Client 对象，设置 `mode` 和 `codec` 。

```javascript
var client = AgoraRTC.createClient({mode: 'live', codec: "h264"});
```

### 初始化 Client 对象
创建 Client 对象后，将项目的 App ID 填入 `client.init` 方法，即可初始化 Client。

```javascript
client.init(<APPID>, function () {
  console.log("AgoraRTC client initialized");

}, function (err) {
  console.log("AgoraRTC client init failed", err);
});
```

> 请确保在调用其他 API 前先调用 `create` 和 `client.init` 方法创建并初始化 AgoraRtcEngine。

## 相关文档
初始化 Client 对象后，你可以使用 Agora SDK，依次实现如下功能进行互动直播：
- [加入频道](/cn/Interactive%20Broadcast/join_live_web)
- [切换用户角色](/cn/Interactive%20Broadcast/role_web)
- [发布和订阅音频流](/cn/Interactive%20Broadcast/publish_web_live)

如果对网络或音质有特殊的需求，你还可以在加入频道前：
- [使用双声道/高音质](/cn/Interactive%20Broadcast/audio_profile_web)
