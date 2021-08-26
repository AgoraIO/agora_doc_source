# In-call Statistics

The Agora RTC SDK provides callbacks to feedback quality of calls and live streamings in real-time, such as network quality, audio quality, video quality, and real-time interaction statistics of users in the channel. This page describes how to understand the information returned by the callbacks and how to use these callbacks.

## Understand the tech

After a user successfully joins the channel, the SDK sends the monitored real-time interaction quality statistics back to you from a series of callbacks with a two-second callback period. When the user's audio or video state changes, the SDK triggers a callback to report the latest audio or video state and the reason for the state change. You can learn about users' interaction experience from the statistic callbacks and state callbacks, and conduct corresponding troubleshooting and experience optimization.

### Network quality report

The `onNetworkQuality` callback reports the uplink and downlink last-mile network quality of each user in the `COMMUNICATION` profile or each host in the `LIVE_BROADCASTING` profile in the current call, see [quality rating table](#rate) for details. The last mile is the network from your device to the Agora edge server. The uplink last mile quality rating is based on the actual transmission bitrate, the uplink network packet loss rate, the average round-trip delay, and the uplink network jitter; while the downlink last mile quality rating is based on the downlink network packet loss rate, the average round-trip delay, and the downlink network jitter. The higher the ratio of the actual transmission bitrate to the target transmission bitrate, the better the call quality and the higher the network quality. The average round-trip delay refers to the average value of multiple round-trip delays in the reported interval.

### Statistics report

The `onRtcStats` callback reports call statistics. You can see the duration, the number of users in the channel, the system CPU usage, the application CPU usage, and the following important parameters of the current call.

| Parameter                           | Description                                                  | Comment                                                      |
| :---------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `txBytes`/`rxBytes`                 | The total number of bytes sent/received.                     | The number of bytes accumulated since joining the channel.   |
| `txAudioBytes`/`rxAudioByte`        | The total number of audio bytes sent/received.               | The number of bytes accumulated since joining the channel.   |
| `txVideoBytes`/`rxVideoBytes`       | The total number of video bytes sent/received.               | The number of bytes accumulated since joining the channel.   |
| `txKBitRate`/`rxKBitRate`           | The bitrate sent/received.                                   | The actual bitrate sent/received in the reported interval.   |
| `txAudioKBitRate`/`rxAudioKBitRate` | The bitrate sent/received of the audio packet.               | The actual bitrate sent/received in the reported interval.   |
| `txVideoKBitRate`/`rxVideoKBitRate` | The bitrate sent/received of the video packet.               | The actual bitrate sent/received in the reported interval.   |
| `lastmileDelay`                     | The network delay from the local client to the Agora edge server. | <li>This parameter refers to half of [the average round-trip delay](#RTT), not the **one-way** network delay from the client to the Agora edge server or vice versa. <li>The network delay here does not distinguish between the audio and video delay and is the data obtained by the UDP packet. |
| `rxPacketLossRate`                  | The packet loss rate from the Agora edge server to the local client. | <li>The larger value between audio and video downlink packet loss rate.  <li>The packet loss rate before using the **anti-packet-loss** method. |


### Audio quality report

This section describes the user's audio quality report, including local audio stream statistics, local audio stream state change, remote audio stream statistics, and remote audio stream state change.

#### Statistics of local audio streams

The `onLocalAudioStats` callback, which is triggered once every two seconds, reports the statistics of the audio streams sent. You can learn about the following important statistics:

- The number of audio channels.
- The actual sample rate of the audio streams sent in the reported interval.
- The average sending bitrate in the reported interval.

#### State changes of local audio streams

When the state of local audio changes, such as the state of audio recording or audio encoding changes, the SDK triggers the `onLocalAudioStateChanged` callback to report the current state. You can troubleshoot with the error code when exceptions occur.

#### Statistics of remote audio streams

The following figure shows the transmission process between app clients.

![](https://web-cdn.agora.io/docs-files/1565945275984)

The `onRemoteAudioStats` callback reports the audio statistics of each remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile in the current call. You can learn about the quality of the audio stream sent by each remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile (see [quality rating table](#rate)), the number of audio channels, and the following important parameters.

| Parameter               | Description                                                  | Comment                                                      |
| :---------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `networkTransportDelay` | The network delay from the sender to the receiver.           | Stages 2, 3, and 4 in the previous figure                         |
| `jitterBufferDelay`     | The network delay from the receiver to the network jitter buffer. | Stage 5 in the previous figure                                  |
| `audioLossRate`         | The frame loss rate of the received remote audio streams in the reported interval. | <li>Stages 2, 3, 4, and 5 in the previous figure<li>In a reported interval, audio **freeze** occurs when the audio frame loss rate reaches 4%. |
| `receivedSampleRate`    | The sample rate of the received remote audio streams in the reported interval. |                N/A                                              |
| `receivedBitrate`       | The **average** bitrate of the received remote audio streams in the reported interval. |                    N/A                                          |
| `totalFrozenTime`       | The total **freeze** time (ms) of the remote audio streams after the remote user joins the channel. | <li>Agora defines `totalFrozenTime` = The number of times the audio freezes × 2 × 1000 (ms).<li>The total time is the cumulative duration after the remote user joins the channel. |
| `frozenRate`            | The total audio freeze time is a percentage of the total time when the audio is available. | When the remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile neither stops sending the audio stream nor disables the audio module after joining the channel, the audio is **available**. Note that the audio module refers to the audio processing, not the physical module in the SDK. When sending an audio stream, the audio module refers to the audio sampling, pre-processing, encoding and other processing; when receiving an audio stream, the audio module refers to the audio decoding, post-processing, playback and other processing. Users can only enable or disable their own audio modules. |
| `mosValue`     |   The quality of the remote audio stream as determined by the Agora real-time audio MOS (Mean Opinion Score) measurement system in the reported interval.      |              N/A                  |


> Agora defaults to no more than one audio freeze in each reported interval.

To analyse statistics more closely linked to the user's experience and audio transmission quality, call `onRemoteAudioStats`. Even if network packet loss occurs, users might find the overall audio quality acceptable because the audio frame loss rate of the received audio streams might not be high due to the **anti-packet-loss** and congestion control methods, such as forward error correction (FEC), retransmissions and bandwidth estimation.


#### State changes of remote audio streams

When the audio state of a remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile changes, the SDK triggers the `onRemoteAudioStateChanged` callback to report the current state and the reason for the state change.

### Video quality report

This section describes the user's video quality report, including local video stream statistics, local video stream state change, remote video stream statistics, and remote video stream state change.


#### Statistics of local video streams

The `onLocalVideoStats` callback reports the statistics of the video streams sent. You can see the dimensions of the encoding frame and the following important parameters.

> If you have called the `enableDualStreamMode` method to enable [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode), this callback reports the statistics of the high-video streams sent.

| Parameter                 | Description                                                  | Comment                                                      |
| :------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `rendererOutputFrameRate` | The output frame rate of the local video renderer.           |                             N/A                                 |
| `encoderOutputFrameRate`  | The output frame rate of the local video encoder.            |                            N/A                                  |
| `targetBitrate`           | The target bitrate of the current encoder.                   | This value is estimated by the SDK based on current network conditions. |
| targetFrameRate           | The target frame rate of the current encoder.                |                           N/A                                   |
| `encodedBitrate`          | The bitrate of the encoding video.                           | Does not include the bitrate of the retransmission videos.   |
| `sentBitrate`             | The bitrate of the video sent in the reported interval.      | Does not include the bitrate of the retransmission videos.   |
| `sentFrameRate`           | The frame rate of the video sent in the reported interval.   | Does not include the frame rate of the retransmission videos. |
| `encodedFrameCount`       | The total frames of the video sent.                          | The number of frames accumulated since joining the channel.  |
| `codecType`               | The codec type of the local video.                           | <li>`VIDEO_CODEC_VP8 = 1`: VP8<li>`VIDEO_CODEC_H264 = 2`: (Default) H.264 |

<!-- | `qualityAdaptIndication`  | The local video quality change in terms of `targetBitrate` and `targetFrameRate` in this reported interval. | Compared to the video quality in the last statistics (two seconds ago), the video quality change in this reported interval:<li>The quality stays the same.<li>The quality improves.<li>The quality deteriorates. | -->

#### State changes of local video streams

When the state of the local video changes, the SDK triggers the `onLocalVideoStateChanged` callback to report the current state. You can troubleshoot with the error code when exceptions occur.

#### Statistics of remote video streams

The following figure shows the transmission process between app clients.

![](https://web-cdn.agora.io/docs-files/1565945292345)

The `onRemoteVideoStats` callback reports the video statistics of each remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile in the current call. You can see their video dimensions and the following important parameters.

| Parameter                 | Description                                                  | Comment                                                      |
| :------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `rxStreamType`            | The type of video streams.                                   | High-video streams or low-video streams, see [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode). |
| `receivedBitrate`         | The bitrate of the video received in the reported interval.  |                              N/A                                |
| `packetLossRate`          | The packet loss rate of the video received in the reported interval. | <li>Stages 2 + 3 + 4 in the previous figure<li>The packet loss rate after using the **anti-packet-loss** method, which is lower than before. |
| `decoderOutputFrameRate`  | The output frame rate of the remote video decoder.           |                               N/A                               |
| `rendererOutputFrameRate` | The output frame rate of the remote video renderer.          |                           N/A                                   |
| `totalFrozenTime`         | The total **freeze** time (ms) of the remote video stream after the remote user joins the channel. | In a video call or interactive video streaming session where the frame rate is set to no less than 5 fps, video **freeze** occurs when the time interval between two adjacent renderable video frames is more than 500 ms. |
| `frozenRate`              | The total video freeze time is a percentage of the total time when the video is available. | When the remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile neither stops sending the video stream nor disables the video module after joining the channel, the video is **available**. Note that the video module refers to the video processing, not the physical module in the SDK. When sending a video stream, the video module refers to the video capturing, pre-processing, encoding and other processing; when receiving a video stream, the video module refers to the video decoding, post-processing, rendering, and other processing. Users can only enable or disable their own video modules.|


#### State changes of remote video streams

When the video state of a remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile changes, the SDK triggers the `onRemoteVideoStateChanged` callback to report the current state and the reason for the state change.


## Implementation

1. Ensure that you have a project that has implemented the basic real-time engagement functionality. For details, see [Start a Call](start_call_android) or [Start Interactive Live Streaming](start_live_android).

2. Implement the following real-time interaction quality statistic callbacks and audio or video state callbacks in `IRtcEngineEventHandler` to monitor user interaction experience.

    - `onNetworkQuality`: Reports the quality of uplink and downlink last-mile network.
    - `onRtcStats`: Reports real-time interaction statistics.
    - `onLocalAudioStats`: Reports statistics of the audio stream sent.
    - `onLocalAudioStateChanged`: Reports the local audio stream state changes.
    - `onRemoteAudioStats`: Reports statistics of a remote audio stream received.
    - `onRemoteAudioStateChanged`: Reports the remote audio stream state changes.
    - `onLocalVideoStats`: Reports statistics of the video stream sent.
    - `onLocalVideoStateChanged`: Reports the local video stream state changes.
    - `onRemoteVideoStats`: Reports statistics of a remote video stream received.
    - `onRemoteVideoStateChanged`: Reports the remote video stream state changes.

```java
private final IRtcEngineEventHandler iRtcEngineEventHandler = new IRtcEngineEventHandler()
{

    @Override
    public void onRemoteAudioStateChanged(int uid, int state, int reason, int elapsed)
    {
        super.onRemoteAudioStateChanged(uid, state, reason, elapsed);
        Log.i(TAG, "onRemoteAudioStateChanged->" + uid + ", state->" + state + ", reason->" + reason);
    }

    @Override
    public void onRemoteVideoStateChanged(int uid, int state, int reason, int elapsed)
    {
        super.onRemoteVideoStateChanged(uid, state, reason, elapsed);
        Log.i(TAG, "onRemoteVideoStateChanged->" + uid + ", state->" + state + ", reason->" + reason);
    }

    @Override
    public void onRemoteAudioStats(RemoteAudioStats remoteAudioStats) {
        statisticsInfo.setRemoteAudioStats(remoteAudioStats);
        updateRemoteStats();
    }

    @Override
    public void onLocalAudioStats(LocalAudioStats localAudioStats) {
        statisticsInfo.setLocalAudioStats(localAudioStats);
        updateLocalStats();
    }

    @Override
    public void onRemoteVideoStats(RemoteVideoStats remoteVideoStats) {
        statisticsInfo.setRemoteVideoStats(remoteVideoStats);
        updateRemoteStats();
    }

    @Override
    public void onLocalVideoStats(LocalVideoStats localVideoStats) {
        statisticsInfo.setLocalVideoStats(localVideoStats);
        updateLocalStats();
    }

    @Override
    public void onRtcStats(RtcStats rtcStats) {
        statisticsInfo.setRtcStats(rtcStats);
    }
};
```

## API Reference

- [`onNetworkQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a76be982389183c5fe3f6e4b03eaa3bd4)
- [`onRtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ada7aa10b092a6de23b598a9f77d4deee)
- [`onLocalAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aeba2aa3fc29404fc6f25bff5c00bfdf9)
- [`onLocalAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a59946a989f87c737899e2284539adf09)
- [`onRemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54)
- [`onRemoteAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff)
- [`onLocalVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a79fb5d32bb694d24b54a523d924dc7ef)
- [`onLocalVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c)
- [`onRemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#abb7af6e2827bbd03c6ab8338a0f616ca)
- [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aaa721f00a7409aa091c9763c3385332e)

<a name="rate"></a>
## Quality rating table

| Code        |     Description                                                       |
| :------------------ | ------------------------------------------------------------ |
| `QUALITY_UNKNOWN (0)`     | The network quality is unknown.                           |
| `QUALITY_EXCELLENT (1)`   |The network quality is excellent.                         |
| `QUALITY_GOOD(2)`       | The user subjectively feels that the network quality is similar to `QUALITY_EXCELLENT (1)`, but the bitrate might be slightly lower than `QUALITY_EXCELLENT(1)`. |
| `QUALITY_POOR (3)`       | The user subjectively feels that the network quality is flawed but does not affect communication.|
| `QUALITY_BAD (4)`         | The user can barely communicate, but the communication is not smooth. |
| `QUALITY_VBAD (5)`       | The network quality is so poor and the communication is basically impossible. |
| `QUALITY_DOWN (6)`        | Users cannot communicate with each other at all.  |