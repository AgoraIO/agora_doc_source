https://docs-preprod.agora.io/cn/live-streaming-standard-legacy/media_relay_windows?platform=Windows
CrossChannel/ https://github.com/AgoraIO/API-Examples/blob/main/windows/APIExample/APIExample/Advanced/CrossChannel/CAgoraCrossChannelDlg.cpp


## 功能描述

跨直播间连麦，指主播的媒体流可以同时转发进多个直播频道，实现主播跨频道与其他主播实时互动的场景。其中：

- 频道中的所有主播可以看见彼此，并听到彼此的声音。
- 频道中的观众可以看到所有主播，并听到主播的声音。

该功能因其实时性和互动性，尤其适用于连麦 PK、在线合唱等直播场景，在增加直播趣味的同时，有效吸粉。


## 示例项目

我们在 GitHub 上提供已实现[跨频道媒体流转发](https://github.com/AgoraIO/API-Examples/tree/legacy/windows/APIExample/APIExample/Advanced/CrossChannel)的开源示例项目。你可以下载体验并参考源代码。


## 实现方法

<div class="alert note">跨频道连麦功能需要<a href="https://agora-ticket.agora.io/">联系技术支持</a>开通。</div>

实现跨频道连麦功能前，请确保你已在项目中实现基本的实时音视频功能，详见[开始互动直播](start_live_windows)。

Agora Native SDK 在 v2.9.0 中新增如下跨频道媒体流转发接口，支持将源频道中的媒体流转发至最多 4 个目标频道，实现跨直播间连麦功能：

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

在跨频道媒体流转发过程中，SDK 会通过 onChannelMediaRelayStateChanged 和 onChannelMediaRelayEvent 回调报告媒体流转发的状态和事件，你可以参考如下状态码或事件码的含义实现相关的业务逻辑：


| 状态码 | 事件码 | 媒体流转发状态 |
| ---------------- | ---------------- | ---------------- |
| RELAY_STATE_RUNNING(2) 和 RELAY_OK(0)     | RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL(4)      | 源频道开始向目标频道传输数据      |
| RELAY_STATE_FAILURE(3)     | /      | 跨频道媒体流转发出现异常。可以参考 error 参数中报告的出错原因进行问题排查      |
| RELAY_STATE_IDLE(0) 和 RELAY_OK(0)     | /      | 已停止媒体流转发      |

**Note**：

- 一个频道内可以有多个主播转发媒体流。哪个主播调用 startChannelMediaRelay 方法，SDK 就转发哪个主播的流。
- 跨频道连麦中，如果目标频道的主播掉线或离开频道，源频道的主播会收到 onUserOffline 回调。

### API 调用时序

参考如下 API 时序图实现相关代码逻辑：

![](https://web-cdn.agora.io/docs-files/1568962777202)

### 示例代码

```C++
// 配置源频道信息、目标频道信息和目标频道数量。其中 channelName 使用用户填入的源频道名，uid 需要填为 0
// 注意 token 和用户加入源频道时的 Token 不一致，需要用 uid = 0 和源频道名重新生成
ChannelMediaInfo *lpSrcinfo = new ChannelMediaInfo;
lpSrcinfo->channelName = nullptr;
lpSrcinfo->token = nullptr;
lpSrcinfo->uid = 0;
ChannelMediaInfo  *lpDestInfos = NULL;
int nDestCount = arrayDestInfos.size();	
for(int nIndex = 0; nIndex < nDestCount; nIndex++) {
		std::string strChannelName = arrayDestInfos[nIndex]["channelName"].asString();
		std::string strtoken  = arrayDestInfos[nIndex]["token"].asString();
		uid_t uid = arrayDestInfos[nIndex]["uid"].asUInt();

		lpDestInfos[nIndex].channelName = new char[strChannelName.length() + 1];
		lpDestInfos[nIndex].token = new char[strtoken.length() + 1];
		strcpy_s((char*)lpDestInfos[nIndex].channelName,strChannelName.length() + 1,strChannelName.c_str());
		strcpy_s((char*)lpDestInfos[nIndex].token,strtoken.length() + 1,strtoken.c_str());
		lpDestInfos[nIndex].uid = uid;
}
ChannelMediaRelayConfiguration cmrc;
cmrc.srcInfo = lpSrcinfo;
cmrc.destInfos = lpDestInfos;
cmrc.destCount = nDestCount;
int ret = 0;
// 开始跨频道媒体流转发。
ret = m_lpAgoraEngine->startChannelMediaRelay(cmrc);

// 更新目标频道信息和目标频道数量。
ChannelMediaInfo *lpUpdateDestInfos = new ChannelMediaInfo;
lpUpdateDestInfos->channelName = "test";
lpUpdateDestInfos->token = nullptr;
lpUpdateDestInfos->uid = 0;
cmrc.destInfos = lpUpdateDestInfos;
cmrc.destCount = 1;
// 更新媒体流转发的频道。
ret = m_lpAgoraEngine->updateChannelMediaRelay(cmrc);	
```

<div class="alert note"><code>updateChannelMediaRelay</code> 方法需在 <code>startChannelMediaRelay</code> 后调用。</div>

### API 参考

- [`startChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#acb72f911830a6fdb77e0816d7b41dd5c)
- [`updateChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#afad0d3f3861c770200a884b855276663)
- [`stopChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ab4a1c52a83a08f7dacab6de36f4681b8)
- [`onChannelMediaRelayStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a8f22b85194d4b771bbab0e1c3b505b22)
- [`onChannelMediaRelayEvent`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89a4085f36c25eeed75c129c82ca9429)


## 开发注意事项

- 该功能最多支持将媒体流转发至 4 个目标频道。转发过程中，如果想添加或删除目标频道，可以调用 `updateChannelMediaRelay` 方法。
- 该功能不支持 String 型用户 ID。
- 在设置源频道信息时，请确保 `uid` 必须为 0，且用于生成 token 的 `uid` 也必须为 0。
- 在成功调用 `startChannelMediaRelay` 方法后，如果想再次调用该方法，必须先调用 `stopChannelMediaRelay` 方法退出当前的转发状态。