---
title: Report In-call Statistics
platform: Windows
updatedAt: 2021-03-05 02:49:27
---
## Introduction

**After joining the channel**, the SDK triggers the following callbacks related to the call quality **once every two seconds**. You can see the last mile network quality, local statistics, audio quality, and video quality of the current call.

We provide an open-source [OpenLive-Windows](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Windows) demo project. 

<div class="alert note">Ensure that you implement a video call or interactive video streaming in your project. For details, see <a href="start_call_windows">Start a Call</a> or <a href="start_live_windows">Start Live Interactive Streaming</a>.</div>

## Sample project

Agora provides an open-source sample project on GitHub that implements the [in-call statistics monitoring](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/ReportInCall) function. You can download the sample project to try it out or view the source code.

## Network quality report

The `onNetworkQuality` callback reports the uplink and downlink last mile network quality of each user/host in the current call, see [Quality Rating](./API%20Reference/cpp/namespaceagora_1_1rtc.html#aeaf419fcafaa4d58da8b6d8718e31891) for details. Last mile refers to the network from your device to Agora’s edge server. The uplink last mile quality rating is based on the actual transmission bitrate, the uplink network packet loss rate, the average round-trip delay, and the uplink network jitter; while the downlink last mile quality rating is based on the downlink network packet loss rate, the average round-trip delay, and the downlink network jitter.

**Note**:

- In the <code>COMMUNICATION</code> profile, you receive network quality reports of all the users (including yours) in the channel once every two seconds.
- In the <code>LIVE_BROADCASTING</code> profile, if you are the host, you receive network quality reports of all hosts (including yours) in the channel once every two seconds; if you are the audience, you receive the report of all hosts and yourself once every two seconds.
- The higher the ratio of the actual transmission bitrate to the target transmission bitrate, the better the call quality and the higher the network quality.
- <a name="RTT"></a>**The average round-trip delay** refers to the average value of multiple round-trip delays in the reported interval.

#### Sample code

```C++
virtual void onNetworkQuality(uid_t uid, int txQuality, int rxQuality)override {
        ;
    }
```

## Statistics report

The `onRtcStats` callback reports call statistics. You can see the duration, the number of users in the channel, the system CPU usage, the application CPU usage, and the following parameters of the current call.

| Parameter                           | Description                                                  | Comment                                                      |
| :---------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `txBytes`/`rxBytes`                 | The total number of bytes sent/received.                     | The number of bytes accumulated since joining the channel.   |
| `txAudioBytes`/`rxAudioByte`        | The total number of audio bytes sent/received.               | The number of bytes accumulated since joining the channel.   |
| `txVideoBytes`/`rxVideoBytes`       | The total number of video bytes sent/received.               | The number of bytes accumulated since joining the channel.   |
| `txKBitRate`/`rxKBitRate`           | The bitrate sent/received.                                   | The actual bitrate sent/received in the reported interval.   |
| `txAudioKBitRate`/`rxAudioKBitRate` | The bitrate sent/received of the audio packet.               | The actual bitrate sent/received in the reported interval.   |
| `txVideoKBitRate`/`rxVideoKBitRate` | The bitrate sent/received of the video packet.               | The actual bitrate sent/received in the reported interval.   |
| `lastmileDelay`                     | The network delay from the local client to Agora’s edge server. | <li>This refers to half of [the average round-trip delay](#RTT), and not the **one-way** network delay from the client to Agora’s edge server or vice versa. <li>The network delay here does not distinguish between the audio and video delay, and is the data obtained by the UDP packet. |
| `txPacketLossRate`                  | The packet loss rate from the local client to Agora’s edge server. | <li>The larger value between audio’s and video’s uplink packet loss rate. <li>The packet loss rate before using the **anti-packet-loss** method. |
| `rxPacketLossRate`                  | The packet loss rate from Agora’s edge server to the local client. | <li>The larger value between audio’s and video’s downlink packet loss rate.  <li>The packet loss rate before using the **anti-packet-loss** method. |

#### Sample code

```c++
virtual void onRtcStats(const RtcStats& stats) {
        if (m_hMsgHanlder)
            ::PostMessage(m_hMsgHanlder, WM_MSGID(EID_RTC_STATS),(WPARAM)new RtcStats(stats), 0);
    }
```

```C++
LRESULT CAgoraReportInCallDlg::OnEIDRtcStats(WPARAM wParam, LPARAM lParam)
{
    RtcStats *p = reinterpret_cast<RtcStats *>(wParam);
    if (p)
    {
        CString tmp;
        tmp.Format(_T("%dKbps/%dKbps"), p->txKBitRate, p->rxKBitRate);
        m_staTotalBitrateVal.SetWindowText(tmp);
        tmp.Format(_T("%.2fMB/%.2fMB"), p->txBytes ? p->txBytes / 1024.0 / 1024 : 0, p->rxBytes ? p->rxBytes / 1024.0 / 1024 : 0);
        m_staTotalBytesVal.SetWindowText(tmp);
        delete p;
    }
    return TRUE;
}
```
	
## Audio Quality Report

### Statistics of local audio streams

The `onLocalAudioStats` callback reports the statistics of the audio streams sent. You can see the number of channels (mono or dual), the sample rate, and the **average** sending bitrate in the reported interval.

**Note**:

The SDK triggers this callback once every two seconds. The sample rate refers to the actual sample rate of the audio streams sent in the reported interval. 
	
#### Sample code

```c++
virtual void onLocalAudioStats(const LocalAudioStats& stats) {
        (void)stats;
    }
```

<a name="32"></a>
### State changes of local audio streams

When the state of the local audio stream changes (including the state of the audio recording and encoding), the SDK triggers the `onLocalAudioStateChanged` callback to report the current state. You can troubleshoot with the error code when exceptions occur.

#### Sample code

```c++
virtual void onLocalAudioStateChanged(LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_ERROR error) {
        (void)state;
        (void)error;
    }
```

### Statistics of remote audio streams

![](https://web-cdn.agora.io/docs-files/1565945275984)

The `onRemoteAudioStats` callback reports the audio statistics of each remote user/host in the current call. You can see the quality of the audio stream sent by each remote user/host (see [Quality Rating](./API%20Reference/cpp/namespaceagora_1_1rtc.html#aeaf419fcafaa4d58da8b6d8718e31891)), the number of channels (mono or dual), and the following parameters.

| Parameter               | Description                                                  | Comment                                                      |
| :---------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `networkTransportDelay` | The network delay from the sender to the receiver.           | Stages 2 + 3 + 4 in the figure above                         |
| `jitterBufferDelay`     | The network delay from the receiver to the network jitter buffer. | Stage 5 in the figure above                                  |
| `audioLossRate`         | The frame loss rate of the received remote audio streams in the reported interval. | <li>Stages 2 + 3 + 4 + 5 in the figure above<li>In a reported interval, audio **freeze** occurs when the audio frame loss rate reaches 4%. |
| `receivedSampleRate`    | The sample rate of the received remote audio streams in the reported interval. |                                                              |
| `receivedBitrate`       | The **average** bitrate of the received remote audio streams in the reported interval. |                                                              |
| `totalFrozenTime`       | The total **freeze** time (ms) of the remote audio streams after the remote user joins the channel. | <li>Agora defines `totalFrozenTime` = The number of times the audio freezes × 2 × 1000 (ms).<li>The total time is the cumulative duration after the remote user joins the channel. |
| `frozenRate`            | The total audio freeze time as a percentage of the total time when the audio is available. | When the remote user/host neither stops sending the audio stream nordisables the audio module after joining the channel, the audio is **available**. |
| `qoeQuality`     |   Quality of experience (QoE) of the local user when receiving a remote audio stream.              |                                |
	| `qualityChangedReason`     |   The reason for poor QoE of the local user when receiving a remote audio stream.       |                       |

The `onRemoteAudioStats` callback reports statistics more closely linked to the real-user experience of the audio transmission quality. Even if network packet loss occurs, users may find the overall audio quality acceptable because the audio frame loss rate of the received audio streams may not be high due to the **anti-packet-loss** and congestion control methods, such as forward error correction (FEC), retransmissions and bandwidth estimation.

**Note**:

- In the <code>COMMUNICATION</code> profile, you receive the audio stream statistics of all the remote users (excluding yours) in the channel once every two seconds.
- In the <code>LIVE_BROADCASTING</code> profile, if you are the host, you receive the audio stream statistics of all remote hosts (excluding yours) in the channel once every two seconds; if you are the audience, you receive the statistics of all hosts in the channel once every two seconds.
- Agora's **audio module** refers to the audio processing process, and not the actual module in the SDK. When sending audio streams, the audio module refers to the processes of audio sampling, pre-processing, and encoding; when receiving audio streams, the audio module refers to the processes of audio decoding, post-processing, and playback.
- Users can only turn on/off their own audio modules.
- By default, the audio freezes at most once in each reported interval.
	
#### Sample code

```c++
virtual void onRemoteAudioStats(const RemoteAudioStats& stats) {
        if (m_hMsgHanlder)
            ::PostMessage(m_hMsgHanlder, WM_MSGID(EID_REMOTE_AUDIO_STATS), (WPARAM)new RemoteAudioStats(stats), 0);
    }
```

```c++
LRESULT CAgoraReportInCallDlg::OnEIDRemoteAudioStats(WPARAM wParam, LPARAM lParam)
{
    RemoteAudioStats *p = reinterpret_cast<RemoteAudioStats *>(wParam);
    if (p)
    {
        CString tmp;
        tmp.Format(_T("%dms"), p->networkTransportDelay);
        m_staAudioNetWorkDelayVal.SetWindowText(tmp);
 
 
        tmp.Format(_T("%dKbps"), p->receivedBitrate);
        m_staAudioRecvBitrateVal.SetWindowText(tmp);
 
        delete p;
    }
    return TRUE;
}
```

### <a name="34"></a>State changes of remote audio streams 

When the state of **remote** audio stream changes, the SDK triggers the `onRemoteAudioStateChanged` callback to report the current state and the reason for the state change.

**Note**:

- In the <code>COMMUNICATION</code> profile, this callback reports to you the audio stream state information of all the remote users (excluding yours) in the channel once every two seconds.
- In the <code>LIVE_BROADCASTING</code> profile, if you are the host, this callback reports to you the audio stream state information of all the remote hosts(excluding yours) in the channel once every two seconds; if you are the audience, this callback reports to you the audio stream state information of all the remote hosts in the channel once every two seconds.
	
#### Sample code

```c++
virtual void onRemoteAudioStateChanged(uid_t uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed) {
        (void)uid;
        (void)state;
        (void)reason;
        (void)elapsed;
    }
```

## Video Quality Report

### Statistics of local video streams

The `onLocalVideoStats` callback reports the statistics of the video streams sent. You can see the dimensions of the encoding frame and the following parameters.

**Note**: 
If you have called the `enableDualStreamMode` method to enable [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode), this callback reports the statistics of the high-video streams sent.

| Parameter                 | Description                                                  | Comment                                                      |
| :------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `rendererOutputFrameRate` | The output frame rate of the local video renderer.           |                                                              |
| `encoderOutputFrameRate`  | The output frame rate of the local video encoder.            |                                                              |
| `targetBitrate`           | The target bitrate of the current encoder.                   | This value is estimated by the SDK based on current network conditions. |
| targetFrameRate           | The target frame rate of the current encoder.                |                                                              |
| `encodedBitrate`          | The bitrate of the encoding video.                           | Does not include the bitrate of the retransmission videos.   |
| `sentBitrate`             | The bitrate of the video sent in the reported interval.      | Does not include the bitrate of the retransmission videos.   |
| `sentFrameRate`           | The frame rate of the video sent in the reported interval.   | Does not include the frame rate of the retransmission videos. |
| `encodedFrameCount`       | The total frames of the video sent.                          | The number of frames accumulated since joining the channel.  |
| `codecType`               | The codec type of the local video.                           | <li>`VIDEO_CODEC_VP8 = 1`: VP8<li>`VIDEO_CODEC_H264 = 2`: (Default) H.264 |
| `qualityAdaptIndication`  | The local video quality change in terms of `targetBitrate` and `targetFrameRate` in thisreported interval. | Compared to the video quality in the last statistics (two seconds ago), the video quality change in this reported interval:<li>The quality stays the same.<li>The quality improves.<li>The quality deteriorates. |

#### Sample code

```c++
virtual void onLocalVideoStats(const LocalVideoStats& stats) {
        if (m_hMsgHanlder)
            ::PostMessage(m_hMsgHanlder, WM_MSGID(EID_LOCAL_VIDEO_STATS), (WPARAM)new LocalVideoStats(stats), 0);
    }
```

```c++
LRESULT CAgoraReportInCallDlg::OnEIDLocalVideoStats(WPARAM wParam, LPARAM lParam)
{
    LocalVideoStats *p = reinterpret_cast<LocalVideoStats *>(wParam);
    if (p)
    {
        CString tmp;
        tmp.Format(_T("%d fps"), p->sentFrameRate);
        m_staLocalVideoFPSVal.SetWindowText(tmp);
        tmp.Format(_T("%d X %d"), p->encodedFrameWidth, p->encodedFrameHeight);
        m_staLocalVideoResoultionVal.SetWindowText(tmp);
        delete p;
    }
    return TRUE;
}
```

<a name="42"></a>	
### State changes of local video streams

When the state of the local video changes, the SDK triggers the `onLocalVideoStateChanged` callback to report the current state. You can troubleshoot with the error code when exceptions occur.

#### Sample code

```c++
virtual void onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE localVideoState, LOCAL_VIDEO_STREAM_ERROR error) {
        (void)localVideoState;
        (void)error;
    }
```

### Statistics of remote video streams

![](https://web-cdn.agora.io/docs-files/1565945292345)

The `onRemoteVideoStats` callback reports the video statistics of each remote user/host in the current call. You can see their video dimensions and the following parameters.

| Parameter                 | Description                                                  | Comment                                                      |
| :------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `rxStreamType`            | The type of video streams.                                   | High-video streams or low-video streams, see [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode). |
| `receivedBitrate`         | The bitrate of the video received in the reported interval.  |                                                              |
| `packetLossRate`          | The packet loss rate of the video received in the reported interval. | <li>Stages 2 + 3 + 4 in the figure above<li>The packet loss rate after using the **anti-packet-loss** method, which is lower than before. |
| `decoderOutputFrameRate`  | The output frame rate of the remote video decoder.           |                                                              |
| `rendererOutputFrameRate` | The output frame rate of the remote video renderer.          |                                                              |
| `totalFrozenTime`         | The total **freeze** time (ms) of the remote video stream after the remote user joins the channel. | In a video call or interactive video streaming session where the frame rate is set to no less than 5 fps, video **freeze** occurs when the time interval between two adjacent renderable video frames is more than 500 ms. |
| `frozenRate`              | The total video freeze time as a percentage of the total time when the video is available. | When the remote user/host neither stops sending the video stream nor disables the video module after joining the channel, the video is **available**. |

**Note**:

- In the <code>COMMUNICATION</code> profile, you receive video stream statistics of all the remote users (excluding yours) in the channel once every two seconds.
- In the <code>LIVE_BROADCASTING</code> profile, if you are the host, you receive video stream statistics of all the remote hosts (excluding yours) in the channel once every two seconds; if you are the audience, you receive the statistics for all the hosts in the channel once every two seconds.
- Agora’s **video module** refers to the video processing process, and not the actual module in the SDK. When sending video streams, the video module refers to the processes of video capturing, pre-processing, and encoding; when receiving video streams, the video module refers to the processes of video decoding, post-processing, and rendering/playing.
- Users can only turn on/off their own video modules.
	
#### Sample code

```c++
virtual void onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE localVideoState, LOCAL_VIDEO_STREAM_ERROR error) {
        (void)localVideoState;
        (void)error;
    }
```

<a name="44"></a>
### State changes of remote video streams

When the state of remote video streams changes, the SDK triggers the `onRemoteVideoStateChanged` callback to report the current state and the reason for the state change.

**Note**:

- In the <code>COMMUNICATION</code> profile, this callback reports to you the video stream state information of all the remote users (excluding yours) in the channel once every two seconds.
- In the <code>LIVE_BROADCASTING</code> profile, if you are the host, this callback reports to you the video stream state information of all the remote hosts (excluding yours) in the channel once every two seconds; if you are the audience, this callback reports to you the video stream state information of all the remote hosts in the channel once every two seconds.
	
#### Sample code

```c++
virtual void onRemoteVideoStateChanged(uid_t uid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed) override
    {
        if (m_hMsgHanlder) {
            PVideoStateStateChanged stateChanged = new VideoStateStateChanged;
            stateChanged->uid = uid;
            stateChanged->reason = reason;
            stateChanged->state = state;
            ::PostMessage(m_hMsgHanlder, WM_MSGID(EID_REMOTE_VIDEO_STATE_CHANED), (WPARAM)stateChanged, 0);
        }
    }
```

## API reference

- [`onNetworkQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a80003ae8cce02039f3aa0e8ffad7deed)
- [`onRtcStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ada38743982296a75879018c5773f08a1)
- [`onLocalAudioStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0cb47df6a8ef7acee229eb307d6f32c3)
- [`onLocalAudioStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9296c329331eb83b3af1315c52e7f91a)
- [`onRemoteAudioStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af8a59626a9265264fb4638e048091d3a)
- [`onRemoteAudioStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa168380f86f1dc2df1c269a785c56612)
- [`onLocalVideoStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab611030063161c594cd7c4cc0dfe0681)
- [`onLocalVideoStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a5a8bfdc3a7c4ba054f90365ed00781d6)
- [`onRemoteVideoStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7163ffb650852be270ba0215b596d968)
- [`onRemoteVideoStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aac7b62b1307be124423008e45eb02f80)

## Considerations

The SDK does not trigger the [`onLocalAudioStateChanged`](#32), [`onRemoteAudioStateChanged`](#34), [`onLocalVideoStateChanged`](#42), and [`onRemoteVideoStateChanged`](#44) callbacks once every two seconds. See their respective trigger conditions on this page.