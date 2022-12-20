https://docs-preprod.agora.io/cn/live-streaming-standard-legacy/media_relay_android?platform=Android
HostAcrossChannel.java https://github.com/AgoraIO/API-Examples/blob/dev/4.1.0/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/HostAcrossChannel.java


## 功能描述

跨直播间连麦，指主播的媒体流可以同时转发进多个直播频道，实现主播跨频道与其他主播实时互动的场景。其中：

- 频道中的所有主播可以看见彼此，并听到彼此的声音。
- 频道中的观众可以看到所有主播，并听到主播的声音。

该功能因其实时性和互动性，尤其适用于连麦 PK、在线合唱等直播场景，在增加直播趣味的同时，有效吸粉。


## 示例项目

我们在 GitHub 提供了开源的跨频道媒体流转发示例项目 [HostAcrossChannel](https://github.com/AgoraIO/API-Examples/blob/legacy/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/HostAcrossChannel.java)，你可以前往下载，并参考其中的源代码。


## 实现方法

<div class="alert note">跨频道连麦功能需要<a href="https://agora-ticket.agora.io/">联系技术支持</a>开通。</div>

实现跨频道连麦功能前，请确保你已在项目中实现基本的实时音视频功能。

Agora Native SDK 在 v2.9.0 中新增如下跨频道媒体流转发接口，支持将源频道中的媒体流转发至最多 4 个目标频道，实现跨直播间连麦功能：

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

在跨频道媒体流转发过程中，SDK 会通过 `onChannelMediaRelayStateChanged` 和 `onChannelMediaRelayEvent` 回调报告媒体流转发的状态和事件，你可以参考如下状态码或事件码的含义实现相关的业务逻辑：


| 状态码 | 事件码 | 媒体流转发状态 |
| ---------------- | ---------------- | ---------------- |
| RELAY_STATE_RUNNING(2) 和 RELAY_OK(0)     | RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL(4)      | 源频道开始向目标频道传输数据      |
| RELAY_STATE_FAILURE(3)     | /      | 跨频道媒体流转发出现异常。可以参考 error 参数中报告的出错原因进行问题排查      |
| RELAY_STATE_IDLE(0) 和 RELAY_OK(0)     | /      | 已停止媒体流转发      |

<div class="alert note"><ul>
	<li>一个频道内可以有多个主播转发媒体流。哪个主播调用 <code>startChannelMediaRelay</code> 方法，SDK 就转发哪个主播的流。</li>
	<li>跨频道连麦中，如果目标频道的主播掉线或离开频道，源频道的主播会收到 <code>onUserOffline</code> 回调。</li></ul></div>

### API 调用时序

参考如下 API 时序图实现相关代码逻辑：

![](https://web-cdn.agora.io/docs-files/1568961337521)

### 示例代码

```java
// 初始化引擎
engine = RtcEngine.create(context.getApplicationContext(), yourAppId, iRtcRngineEventHandler);

...

// 将用户填入的目标频道名赋值给 destChannelName
String destChannelName = et_channel_ex.getText().toString();
if(destChannelName.length() == 0){
  showAlert("Destination channel name is empty!");
}

// 配置源频道信息，其中 channelName 使用用户填入的源频道名，myUid 需要填为 0
// 注意 sourceChannelToken 和用户加入源频道时的 Token 不一致，需要用 uid = 0 和源频道名重新生成
ChannelMediaInfo srcChannelInfo = new ChannelMediaInfo(et_channel.getText().toString(), sourceChannelToken, myUid);
ChannelMediaRelayConfiguration mediaRelayConfiguration = new ChannelMediaRelayConfiguration();
mediaRelayConfiguration.setSrcChannelInfo(srcChannelInfo);

// 配置目标频道信息，其中 destChannelName 使用用户填入的目标频道名，myUid 填入用户在目标频道内的用户名
ChannelMediaInfo destChannelInfo = new ChannelMediaInfo(destChannelName, destChannelToken, myUid);
mediaRelayConfiguration.setDestChannelInfo(destChannelName, destChannelInfo);

// 调用 startChannelMediaRelay 开始跨频道媒体流转发
engine.startChannelMediaRelay(mediaRelayConfiguration);

// 调用 stopChannelMediaRelay 停止跨频道媒体流转发
engine.stopChannelMediaRelay();
```

```java
// 使用 onChannelMediaRelayStateChanged 回调监控跨频道媒体流的状态
public void onChannelMediaRelayStateChanged(int state, int code) {
  switch (state){
    case RELAY_STATE_CONNECTING:
      mediaRelaying = true;
      handler.post(() ->{
        showLongToast("channel media relay connected.");
      });
      break;
    case RELAY_STATE_FAILURE:
      mediaRelaying = false;
      handler.post(() ->{
        showLongToast(String.format("channel media relay failed at error code: %d", code));
      });
  }
}
```

### API 参考

- [`startChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6f09ba685f8ab01d7dc06173286950f6)
- [`updateChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#abd40d706379d27cf617376a504f394bd)
- [`stopChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0f9f19e48c21190dd4e697dec632c328)
- [`onChannelMediaRelayStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89fd95b3536e8e6afd5f001926162f66)
- [`onChannelMediaRelayEvent`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a6fe2367e9ea61e48a4cc3b373d198b54)


## 开发注意事项

- 该功能最多支持将媒体流转发至 4 个目标频道。转发过程中，如果想添加或删除目标频道，可以调用 `updateChannelMediaRelay` 方法。
- 该功能不支持 String 型用户 ID。
- 在设置源频道信息时，请确保 `uid` 必须为 0，且用于生成 token 的 `uid` 也必须为 0。
- 在成功调用 `startChannelMediaRelay` 方法后，如果想再次调用该方法，必须先调用 `stopChannelMediaRelay` 方法退出当前的转发状态。