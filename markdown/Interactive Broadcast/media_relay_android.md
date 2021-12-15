---
title: 跨直播间连麦
platform: Android
updatedAt: 2021-03-05 09:04:36
---

## 场景描述

跨直播间连麦，指主播的媒体流可以同时转发进多个直播频道，实现主播跨频道与其他主播实时互动的场景。其中：

- 频道中的所有主播可以看见彼此，并听到彼此的声音。
- 频道中的观众可以看到所有主播，并听到主播的声音。

该功能因其实时性和互动性，尤其适用于连麦 PK、在线合唱等直播场景，在增加直播趣味的同时，有效吸粉。

## 实现方法

请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](android_video)。

Agora Native SDK 在 v2.9.0 中新增如下跨频道媒体流转发接口，支持将源频道中的媒体流转发至最多 4 个目标频道，实现跨直播间连麦功能：

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

在跨频道媒体流转发过程中，SDK 会通过 onChannelMediaRelayStateChanged 和 onChannelMediaRelayEvent 回调报告媒体流转发的状态和事件，你可以参考如下状态码或事件码的含义实现相关的业务逻辑：

| 状态码                                | 事件码                                     | 媒体流转发状态                                                            |
| ------------------------------------- | ------------------------------------------ | ------------------------------------------------------------------------- |
| RELAY_STATE_RUNNING(2) 和 RELAY_OK(0) | RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL(4) | 源频道开始向目标频道传输数据                                              |
| RELAY_STATE_FAILURE(3)                | /                                          | 跨频道媒体流转发出现异常。可以参考 error 参数中报告的出错原因进行问题排查 |
| RELAY_STATE_IDLE(0) 和 RELAY_OK(0)    | /                                          | 已停止媒体流转发                                                          |

**Note**：

- 一个频道内可以有多个主播转发媒体流。哪个主播调用 startChannelMediaRelay 方法，SDK 就转发哪个主播的流。
- 跨频道连麦中，如果目标频道的主播掉线或离开频道，源频道的主播会收到 onUserOffline 回调。

### API 调用时序

参考如下 API 时序图实现相关代码逻辑：

![](https://web-cdn.agora.io/docs-files/1565771343016)

### 示例代码片段

- 开始跨频道媒体流转发

  ```java
  ChannelMediaInfo srcChannelInfo = new ChannelMediaInfo(srcChannelName,srcToken,workerSrcUid);
  ChannelMediaRelayConfiguration mediaRelayConfiguration = new ChannelMediaRelayConfiguration();
  // 设置本端频道信息
  mediaRelayConfiguration.setSrcChannelInfo(srcChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName1, destToken1, workerDestUid1);
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName2, destToken2, workerDestUid2);
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName3, destToken3, workerDestUid3);
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName4, destToken4, workerDestUid4);
  // 设置要加入的远端频道信息
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  int result = worker().getRtcEngine().startChannelMediaRelay(mediaRelayConfiguration);
  ```

- 更新媒体流转发频道

  ```java
  ChannelMediaInfo srcChannelInfo = new ChannelMediaInfo(srcChannelName,srcToken,workerSrcUid);
  ChannelMediaRelayConfiguration mediaRelayConfiguration = new ChannelMediaRelayConfiguration();
  // 设置本端频道信息
  mediaRelayConfiguration.setSrcChannelInfo(srcChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName1, destToken1, workerDestUid1);
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName2, destToken2, workerDestUid2);
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName3, destToken3, workerDestUid3);
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName4, destToken4, workerDestUid4);
  // 设置要更新的远端频道信息
  mediaRelayConfiguration.setDestChannelInfo(destChannelInfo.channelName,destChannelInfo);
  int result = worker().getRtcEngine().updateChannelMediaRelay(mediaRelayConfiguration);
  ```

**Note**：
`updateChannelMediaRelay` 方法需在 `startChannelMediaRelay` 后调用。

### API 参考

- startChannelMediaRelay
- updateChannelMediaRelay
- stopChannelMediaRelay
- onChannelMediaRelayStateChanged
- onChannelMediaRelayEvent

## 开发注意事项

- 该功能最多支持将媒体流转发至 4 个目标频道。转发过程中，如果想添加或删除目标频道，可以调用 `updateChannelMediaRelay` 方法。
- 该功能不支持 String 型用户 ID。

<% if (platform == "Web") { %>

- 在设置源频道信息（`setSrcChannelInfo`）时，请确保 `uid` 设置与当前主播的 UID 不同。我们建议将这里的 `uid` 设置为 0，由服务器随机分配。<% } %>

<% if (platform == "Android" || platform == "iOS" || platform == "macOS" || platform == "Windows") { %>

- 在设置源频道信息时，请确保 `uid` 必须为 0，且用于生成 token 的 `uid` 也必须为 0。<% } %>

- 在成功调用 `startChannelMediaRelay` 方法后，如果想再次调用该方法，必须先调用 `stopChannelMediaRelay` 方法退出当前的转发状态。
