# 跨频道媒体流转发

在直播场景下，跨频道媒体流转发功能可实现主播角色的媒体流从源频道同时转发进多个目标频道，其中：

- 所有主播发布并接收彼此的音视频流，进行跨频道实时互动
- 观众可以接收到所有主播的音视频流，同时观看多位主播互动

该功能因其实时性和互动性，能够丰富直播玩法，尤其适用于连麦 PK、在线合唱等直播场景，为观众带来更好的观看体验的同时，也为主播带来更多的流量和收益。


## 前提条件

在开始前，请确保满足以下条件：

- 在你的项目中实现基本的实时音视频功能，详见[开始互动直播](./start_live_windows_ng)。
- <a href="https://agora-ticket.agora.io/">联系技术支持</a>开通跨频道连麦功能。


## 实现步骤

参考如下 API 时序图实现相关代码逻辑：

![](https://web-cdn.agora.io/docs-files/1672913742726)


### 1. 开始跨频道媒体流转发

成功加入频道后，可以调用 `startChannelMediaRelay` 方法转发媒体流。示例代码如下：

```cpp
// 配置源频道信息
ChannelMediaInfo* m_srcInfo = new ChannelMediaInfo;
m_srcInfo->channelName = new char[szChannelId.size() + 1];
strcpy_s(const_cast<char*>(m_srcInfo->channelName), szChannelId.size() + 1, szChannelId.data());
m_srcInfo->token = APP_TOKEN; // 注意 token 与用户加入源频道时的 token 不同，需要用源频道名和 uid = 0 重新生成
m_srcInfo->uid = 0; // 推荐将源频道的 uid 设为 0，由 SDK 随机分配一个 uid
// 配置目标频道信息
int nDestCount = m_vecChannelMedias.size()
ChannelMediaInfo  *lpDestInfos = new ChannelMediaInfo[nDestCount];
for (int nIndex = 0; nIndex < nDestCount; nIndex++) {
    lpDestInfos[nIndex].channelName = m_vecChannelMedias[nIndex].channelName;
    lpDestInfos[nIndex].token = m_vecChannelMedias[nIndex].token;
    lpDestInfos[nIndex].uid = m_vecChannelMedias[nIndex].uid; // 你可以将 uid 设为 0，由 SDK 随机分配一个 uid，或自行指定 uid，并确保其与目标频道中的所有 uid 不同
}
ChannelMediaRelayConfiguration cmrc;
cmrc.srcInfo = m_srcInfo;
cmrc.destInfos = lpDestInfos;
cmrc.destCount = nDestCount;
int ret = 0;
// 开始跨频道媒体流转发
ret = m_rtcEngine->startChannelMediaRelay(cmrc);
```


### 2. 更新媒体流转发的频道

成功调用 `startChannelMediaRelay` 开始跨频道媒体流转发后，如需添加或移除目标频道，可以调用 `updateChannelMediaRelay` 方法更新目标频道。

<div class="alert info">更新后的配置会<b>全量替换</b>掉之前的配置。</div>


### 3. 暂停/恢复转发媒体流

成功调用 `startChannelMediaRelay` 开始跨频道媒体流转发后，如果想暂停向所有目标频道发送媒体流，可调用 `pauseAllChannelMediaRelay` 方法，示例代码如下：

```cpp
m_rtcEngine->pauseAllChannelMediaRelay();
```

暂停跨频道媒体流转发后，如果想恢复向所有目标频道转发媒体流，可调用 `resumeAllChannelMediaRelay` 方法，示例代码如下：

```cpp
m_rtcEngine->resumeAllChannelMediaRelay();
```


### 4. 停止跨频道媒体流转发

在成功调用 `startChannelMediaRelay` 方法开始跨频道媒体流转发后，如需退出当前的转发状态，可以调用 `stopChannelMediaRelay`，示例代码如下：

```cpp
m_rtcEngine->stopChannelMediaRelay();
m_lstInfo.AddString(_T("stopChannelMediaRelay"));
m_btnStartMediaRelay.SetWindowText(CrossChannelStartMediaRelay);
```

<div class="alert info">如果该方法调用不成功，可以调用 <code>leaveChannel</code> 方法离开频道，跨频道媒体流转发会自动停止。</div>


### 5. 监听跨频道媒体流状态

在跨频道媒体流转发过程中，SDK 会通过 `onChannelMediaRelayStateChanged` 和 `onChannelMediaRelayEvent` 回调报告媒体流转发的状态和事件，你可以参考状态码或事件码的含义实现相关的业务逻辑。示例代码如下：

```cpp
class CAgoraCrossChannelEventHandler : public IRtcEngineEventHandler
{
	virtual void onChannelMediaRelayStateChanged(CHANNEL_MEDIA_RELAY_STATE state, CHANNEL_MEDIA_RELAY_ERROR code)override {
		if (m_hMsgHanlder)
			::PostMessage(m_hMsgHanlder, WM_MSGID(EID_CHANNEL_MEDIA_RELAY_STATE_CHNAGENED), state, code);
	}

	virtual void onChannelMediaRelayEvent(CHANNEL_MEDIA_RELAY_EVENT code) {
		if (m_hMsgHanlder)
			::PostMessage(m_hMsgHanlder, WM_MSGID(EID_CHANNEL_MEDIA_RELAY_EVENT), code, 0);
	}
};  
```

主要的状态码和事件码及其对应的媒体流转发状态如下：

| 状态码 | 事件码 | 媒体流转发状态 |
| ---------------- | ---------------- | ---------------- |
| `RELAY_STATE_RUNNING(2)` 和 `RELAY_OK(0)`  | `RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL(4)`     | 源频道开始向目标频道传输数据。      |
| `RELAY_STATE_FAILURE(3)`    | /   | 跨频道媒体流转发出现异常。可根据[错误码](./API%20Reference/windows_ng/API/toc_stream_management.html#callback_irtcengineeventhandler_onchannelmediarelaystatechanged)进行排查。      |
| `RELAY_STATE_IDLE(0)` 和 `RELAY_OK(0)`     | /      | 已停止媒体流转发。      |

## 参考信息

### 开发注意事项

- 在直播场景中，只有角色为主播的用户才能调用 `startChannelMediaRelay` 开始跨频道媒体流转发
- `startChannelMediaRelay` 必须在成功加入频道后调用，否则会报错
- 一个频道内可以有多个主播转发媒体流，哪个主播调用 `startChannelMediaRelay`，SDK 就转发哪个主播的流
- 该功能最多支持将媒体流转发至 4 个目标频道
- 在成功调用 `startChannelMediaRelay` 方法后，如果想再次调用该方法，必须先调用 `stopChannelMediaRelay` 方法退出当前的转发状态
- 该功能不支持 String 型 `uid`，如需使用跨频道连麦功能，则要在普通连麦中也使用 Int 型 `uid`，否则跨频道连麦功能无法正常使用

### 示例项目

我们在 GitHub 提供了开源的跨频道媒体流转发示例项目 [CrossChannel](https://github.com/AgoraIO/API-Examples/tree/main/windows/APIExample/APIExample/Advanced/CrossChannel) 供参考。

### API 参考

- [`startChannelMediaRelay`](./API%20Reference/windows_ng/API/toc_stream_management.html#api_irtcengine_startchannelmediarelay)
- [`updateChannelMediaRelay`](./API%20Reference/windows_ng/API/toc_stream_management.html#api_irtcengine_updatechannelmediarelay)
- [`stopChannelMediaRelay`](./API%20Reference/windows_ng/API/toc_stream_management.html#api_irtcengine_stopchannelmediarelay)
- [`pauseAllChannelMediaRelay`](./API%20Reference/windows_ng/API/toc_stream_management.html#api_irtcengine_pauseallchannelmediarelay)
- [`resumeAllChannelMediaRelay`](./API%20Reference/windows_ng/API/toc_stream_management.html#api_irtcengine_resumeallchannelmediarelay)
- [`onChannelMediaRelayStateChanged`](./API%20Reference/windows_ng/API/toc_stream_management.html#callback_irtcengineeventhandler_onchannelmediarelaystatechanged)
- [`onChannelMediaRelayEvent`](./API%20Reference/windows_ng/API/toc_stream_management.html#callback_irtcengineeventhandler_onchannelmediarelayevent)
- [`ChannelMediaRelayConfiguration`](./API%20Reference/windows_ng/API/class_channelmediarelayconfiguration.html)
- [`ChannelMediaInfo`](./API%20Reference/windows_ng/API/class_channelmediainfo.html)