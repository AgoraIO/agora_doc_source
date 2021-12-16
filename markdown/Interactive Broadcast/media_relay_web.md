---
title: 跨直播间连麦
platform: Web
updatedAt: 2021-03-05 09:08:11
---
## 功能描述

跨直播间连麦，指主播的媒体流可以同时转发进多个直播频道，实现主播跨频道与其他主播实时互动的场景。其中：

- 频道中的所有主播可以看见彼此，并听到彼此的声音。
- 频道中的观众可以看到所有主播，并听到主播的声音。

该功能因其实时性和互动性，尤其适用于连麦 PK、在线合唱等直播场景，在增加直播趣味的同时，有效吸粉。

## 实现方法

<div class="alert note">跨频道连麦功能需要联系 <a href="mailto:sales@agora.io">sales@agora.io</a> 开通。</div>

实现跨频道连麦功能前，请确保你已在项目中实现基本的实时音视频功能，详见[开始互动直播](start_live_web)。

Agora Web SDK 在 v3.0.0 中新增如下跨频道媒体流转发接口，支持将源频道中的媒体流转发至最多 4 个目标频道，实现跨直播间连麦功能：

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

<div class="alert info">API 调用顺序要求：<li><code>startChannelMediaRelay</code> 方法必须在发布流 （<code>Client.publish</code>）之后调用。</li><li><code>updateChannelMediaRelay</code> 方法必须在 <code>startChannelMediaRelay</code> 后调用。</li></div>

在跨频道媒体流转发过程中，SDK 会通过 `Client.on("channel-media-relay-state")` 回调报告媒体流转发的状态码（`state`）和错误码（`code`）， `Client.on("channel-media-relay-event")` 回调报告媒体流转发的事件码，你可以参考如下状态码或事件码的含义实现相关的业务逻辑：


| <span style="white-space:nowrap;">状态码</span> | 错误码                                                       | <span style="white-space:nowrap;">事件码</span> | 媒体流转发状态                                               |
| ----------------------------------------------- | ------------------------------------------------------------ | ----------------------------------------------- | ------------------------------------------------------------ |
| 2                                               | 0                                                            | 4                                               | 源频道开始向目标频道传输数据。                               |
| 3                                               | [错误码](./API%20Reference/web/classes/agorartc.channelmediaerror.html) | /                                               | 跨频道媒体流转发出现异常，可以参考错误码进行问题排查。出现此状态后，如果你还希望继续进行跨频道媒体流转发，必须重新调用 `startChannelMediaRelay` 方法。 |
| 0                                               | 0                                                            | /                                               | 已停止媒体流转发。                                           |

**Note**：

- 一个频道内可以有多个主播转发媒体流。哪个主播调用 `startChannelMediaRelay` 方法，SDK 就转发哪个主播的流。
- 调用 `startChannelMediaRelay` 或 `updateChannelMediaRelay` 成功跨频道连麦后，目标频道的用户会收到 `Client.on("stream-added")` 回调。
- 跨频道连麦中，如果目标频道的主播掉线或离开频道，源频道的主播会收到 `Client.on("peer-leave")` 回调。

### 示例代码

- 配置跨频道媒体流转发

  ```javascript
  var channelMediaConfig = new AgoraRTC.ChannelMediaRelayConfiguration();
  // 设置源频道信息
  channelMediaConfig.setSrcChannelInfo({
   channelName: "srcChannel",
   uid: 0,
   token: "yourSrcToken",
  })
  // 设置目标频道信息，可多次调用，最多设置 4 个目标频道
  channelMediaConfig.setDestChannelInfo("destChannel1", {
   channelName: "destChannel1",
   uid: 123,
   token: "yourDestToken",
  })
  ```

- 开始跨频道媒体流转发

  ```javascript
  client.startChannelMediaRelay(channelMediaConfig, function(e) {
    if(e) {
      utils.notification(`startChannelMediaRelay failed: ${JSON.stringify(e)}`);
    } else {
      utils.notification(`startChannelMediaRelay success`);
    }
  });
  ```

- 更新媒体流转发频道

  ```javascript
  // 删除一个目标频道
  channelMediaConfig.removeDestChannelInfo("destChannel1")
  // 更新跨频道媒体流转发设置
  client.updateChannelMediaRelay(channelMediaConfig, function(e) {
    if(e) {
      utils.notification(`updateChannelMediaRelay failed: ${JSON.stringify(e)}`);
    } else {
      utils.notification(`updateChannelMediaRelay success`);
    }
  });
  ```

- 停止跨频道媒体流转发

  ```javascript
  stopChannelMediaRelay: function() {
    client.stopChannelMediaRelay(function(e) {
      if(e) {
        utils.notification(`stopChannelMediaRelay failed: ${JSON.stringify(e)}`);
      } else {
        utils.notification(`stopChannelMediaRelay success`);
      }
    });
  }
  ```

### API 参考

- [`startChannelMediaRelay`](./API%20Reference/web/interfaces/agorartc.client.html#startchannelmediarelay)
- [`updateChannelMediaRelay`](./API%20Reference/web/interfaces/agorartc.client.html#updatechannelmediarelay)
- [`stopChannelMediaRelay`](./API%20Reference/web/interfaces/agorartc.client.html#stopchannelmediarelay)

## 开发注意事项


- 该功能最多支持将媒体流转发至 4 个目标频道。转发过程中，如果想添加或删除目标频道，可以调用 `updateChannelMediaRelay` 方法。
- 该功能不支持 String 型用户 ID。

<% if (platform == "Web") { %>

- 在设置源频道信息（`setSrcChannelInfo`）时，请确保 `uid` 设置与当前主播的 UID 不同。我们建议将这里的 `uid` 设置为  0，由服务器随机分配。<% } %>

<% if (platform == "Android" || platform == "iOS" || platform == "macOS" || platform == "Windows")  { %>

- 在设置源频道信息时，请确保 `uid` 必须为 0，且用于生成 token 的 `uid` 也必须为 0。<% } %>

- 在成功调用 `startChannelMediaRelay` 方法后，如果想再次调用该方法，必须先调用 `stopChannelMediaRelay` 方法退出当前的转发状态。