---
title: 如何处理音视频互动直播中的炸房捣乱现象或行为？
platform:
  [
    "Android",
    "iOS",
    "macOS",
    "Web",
    "Windows",
    "Unity",
    "Cocos Creator",
    "React Native",
    "Flutter",
    "Electron",
    "Wechat",
  ]
updatedAt: 2021-02-05 07:08:19
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

炸房捣乱指业务漏洞导致的房间麦位信息混乱或非法用户利用业务漏洞故意扰乱房间聊天秩序。

炸房捣乱现象或行为常出现在以下场景：

- 在线语音聊天室
- 多人连麦直播

常见的炸房捣乱现象或行为包括：

- 由于业务漏洞，客户端上显示的麦位信息与频道中实际说话的人数不相符，出现不明的说话者。
- 捣乱者通过劫持信令消息，阻碍应用服务器向客户端下发状态消息，扰乱麦位更新或房间管理。
- 捣乱者非法登录频道后，制造噪音，不断发送违规的音视频内容，破环聊天或互动的秩序。
- 捣乱者利用 Token 设置的有效期过长，反复登录。

## 解决方案

### 定位非法用户

处理炸房捣乱行为的关键是排查并找出非法用户，你可以通过以下几种方法查找非法用户：

- **方法一（推荐）**：

  在客户端调用 [`enableAudioVolumeIndication`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaec0b8db9458b45d14cdcb3003f76fbe) 开启说话者音量提示。开启该方法后，SDK 会定期向 app 返回 [`onAudioVolumeIndication`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a4d37f2b4d569fa787bb8c0e3ae8cd424) 回调，其中包含了正在说话的远端用户列表。你可以将其和你的服务器维护的用户列表做对比，找出非法用户。

- **方法二**：

  业务服务器定期调用 Agora RESTful API [`https://api.agora.io/dev/v1/channel/user/{appid}/{channelName}`](https://docs.agora.io/cn/rtc/restfulapi/#/%E6%9F%A5%E8%AF%A2%E5%9C%A8%E7%BA%BF%E9%A2%91%E9%81%93%E4%BF%A1%E6%81%AF/userProperty) 查询在线频道的用户列表，并与自己的业务服务器上维护的用户列表做对比，找到非法用户。

- **方法三**：

  开通 Agora [消息通知服务](https://docs-preview.agoralab.co/cn/Agora%20Platform/ncs)并订阅[实时通信事件](https://docs-preview.agoralab.co/cn/Agora%20Platform/rtc_eventtype?platform=All%20Platforms#实时通信)。当收到主播加入频道或用户角色切换为主播事件时，查询业务服务器上维护的上麦用户列表，判断新加入的主播是否合法。

  <div class="alert note">Agora 消息通知服务目前处于 Beta 阶段，不建议你的核心业务依赖该服务。</div>

- **方法四：**

  如果频道内有捣乱者不断发送色情、暴恐和涉政等语音内容，你可以使用云录制的单流录制模式，接入第三方语音审核，并在审核结果中找到发送违规音频内容的用户。

### 处理非法用户

找到非法用户后，需要及时制止其行为，以尽快恢复秩序。你可以采用以下任意一种方法阻止捣乱行为：

- 禁止非法用户发流。

  **方法一：**
  你的业务服务器给非法用户的客户端下发下麦消息，让非法用户的客户端调用 [`setClientRole`](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) 将用户角色设置为观众，以取消其发流权限。

  **方法二：**

  业务服务器调用 Agora RESTful API [`https://api.agora.io/dev/v1/kicking-rule`](https://docs.agora.io/cn/rtc/restfulapi/#/%E8%B8%A2%E4%BA%BA%E8%A7%84%E5%88%99%E7%AE%A1%E7%90%86/createKickingRule), 并在请求包体中将 `privileges` 参数设置为 `publish_audio` 和 `publish_video`，以禁止非法用户发送音视频流。

- 停止接收非法用户的音频流。

  如果非法用户劫持了向其下发的消息，你的业务服务器可以向所有合法的客户端下发禁言消息，让合法客户端调用 [`muteRemoteAudioStream`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a3e17b5d2b71d628206d740d895044c5d) 停止接收非法用户的音频流。

- 将非法用户踢出频道或封禁其 IP 地址。

  业务服务器调用 [`https://api.agora.io/dev/v1/kicking-rule`](https://docs.agora.io/cn/rtc/restfulapi/#/%E8%B8%A2%E4%BA%BA%E8%A7%84%E5%88%99%E7%AE%A1%E7%90%86/createKickingRule)，并将请求包体中的 `privileges` 参数设置为`join_channel` 将非法用户踢出频道或封禁其 IP 地址。

  要实现上述功能，你需要将 `privileges` 参数设置为 `join_channel`，并按照如下方式填写 `cname`、`uid` 和 `ip` 三个字段：

  - 填写 `cname` 和 `uid`，不填写 `ip`，以禁止该 `uid` 登录 app 中该 `cname` 对应的频道。
  - 填写 `uid`，不填写 `cname` 和 `ip`，以禁止该 `uid` 登录 app 中的任何频道。
  - 填写 `ip`，不填写 `cname` 和 `uid`，以禁止该 `ip` 登录 app 中的任何频道。

### 预防措施

你可以采取以下措施，加强安全防范，避免业务漏洞，不给非法用户可乘之机：

- 优化 Token 管理。

  - 根据频道内用户平均在线时间设置 Token 的有效时间戳 [`privilegeExpiredTs`](https://docs.agora.io/cn/Interactive%20Broadcast/token_server?platform=Android#api-参考) 参数。Token 过期后，所有用户都会被移出频道，非法用户就无法使用该 Token 反复登录频道了。
  - 注册 [`onTokenPrivilegeWillExpire`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0ecee4bcca9b98dda251a57cfe92adb5) 回调，监听 Token 即将过期事件。当收到该回调时，在服务端生成新的 Token，然后调用 [`renewToken`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af1428905e5778a9ca209f64592b5bf80) 将新生成的 Token 传给 SDK。

- 防止 [App ID 和 App 证书](https://docs.agora.io/cn/Video/token?platform=All%20Platforms)泄露。
  建议将 App ID 和 App 证书存放在服务端，不要对外公开。如果疑似泄密，你可以更新 App 证书。

 <div class="alert info">建议在频道内在线人数处于低峰时更新 App 证书，以避免大规模的用户登录失败。</div>
  
- 为避免服务端下发的信令消息被劫持，可以建立超时机制，在确认客户端收到消息后，再进行下一步操作。
  例如，服务端给客户端下发下麦通知后，开启超时计时。如果在规定时间内收到客户端的确认消息，才认定客户端真正下麦，再更新 UI。

- 为避免业务端的频道用户列表与 Agora 服务器上的频道用户列表不一致，你需要在网络中断重连时注意监听 [`onRejoinChannelSuccess`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad222912d35c5f9c22f95f3072feed77d) 回调，以及时获取重新加入频道的用户 ID。
