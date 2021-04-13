---
title: Co-host across Channels
platform: Windows
updatedAt: 2021-03-08 02:44:19
---
## Introduction
Co-hosting across channels refers to the process where the Agora SDK relays the media stream of a host from an interactive live streaming channel (source channel) to a maximum of four interactive live streaming channels (destination channels). It has the following benefits:

- All hosts in the relay channels can see and hear each other.
- The audience members in the relay channels can see and hear all hosts.

Co-hosting across channels applies to scenarios such as an online singing contest, where hosts of different channels interact with each other.

## Implementation

<div class="alert note">To enable channel media relay, contact <a href="mailto:support@agora.io">support@agora.io</a>.</div>

Before relaying media streams across channels, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start Live Interactive Streaming](start_live_windows).

As of v2.9.0, the Agora Native SDK supports co-hosting across channels with the following methods:

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

Once the channel media relay starts, the SDK relays the media streams of a host from the source channel to at most four destination channels.

During the relay, the SDK reports the states and events of the channel media relay with the `onChannelMediaRelayStateChanged` and `onChannelMediaRelayEvent` callbacks. Refer to the following codes and their corresponding states to implement your code logic:

| State codes | Event codes | The media stream relay state |
| ---------------- | ---------------- | ---------------- |
| RELAY_STATE_RUNNING(2) and RELAY_OK(0)      | RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL(4)     | The channel media relay starts.      |
| RELAY_STATE_FAILURE(3)      | /     | Exceptions occur for the media stream relay. Refer to the error parameter for troubleshooting.      |
| RELAY_STATE_IDLE(0) and RELAY_OK(0)      | /     | The channel media relay stops.      |

**Note**:
- Any host in a live interactive streaming channel can call the `startChannelMediaRelay` method to enable channel media stream relay. The SDK relays the media streams of the host who calls the method.
- During the media stream relay, if the host of the destination channel drops offline or leaves the channel, the host of the source channel receives the `onUserOffline` callback.

### API call sequence

Follow the API call sequence to implement your code logic:

![](https://web-cdn.agora.io/docs-files/1568963288150)

### Sample code

```C++
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
// Sets the destination channel you want to join.
ret = m_lpAgoraEngine->startChannelMediaRelay(cmrc);


ChannelMediaInfo *lpUpdateDestInfos = new ChannelMediaInfo;
lpUpdateDestInfos->channelName = "test";
lpUpdateDestInfos->token = nullptr;
lpUpdateDestInfos->uid = 0;
cmrc.destInfos = lpUpdateDestInfos;
cmrc.destCount = 1;
// Updates the media relay channels.
ret = m_lpAgoraEngine->updateChannelMediaRelay(cmrc);	
```

<div class="alert note">After calling the <code>startChannelMediaRelay</code> method, you can call the <code>updateChannelMediaRelay</code> method to add or delete the relay channels.</div>

### API reference

- [`startChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#acb72f911830a6fdb77e0816d7b41dd5c)
- [`updateChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#afad0d3f3861c770200a884b855276663)
- [`stopChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ab4a1c52a83a08f7dacab6de36f4681b8)
- [`onChannelMediaRelayStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a8f22b85194d4b771bbab0e1c3b505b22)
- [`onChannelMediaRelayEvent`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89a4085f36c25eeed75c129c82ca9429)

## Considerations

- The Agora RTC SDK supports relaying media streams to a maximum of four destination channels. To add or delete a destination channel, call `updateChannelMediaRelay`.
- This feature supports integer user IDs only.




- When setting the source channel information, ensure that you set `uid` as 0, and the `uid` that you use to generate the token should also be set as 0.

- To call `startChannelMediaRelay` again after it succeeds, you must call `stopChannelMediaRelay` to quit the current relay.