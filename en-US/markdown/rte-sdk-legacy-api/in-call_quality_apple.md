# In-call Statistics

The Agora RTC SDK provides callbacks to feedback quality of calls and live streamings in real-time, such as network quality, audio quality, video quality, and real-time interaction statistics of users in the channel. This page describes how to understand the information returned by the callbacks and how to use these callbacks.

## Understand the tech

After a user successfully joins the channel, the SDK sends the monitored real-time interaction quality statistics back to you from a series of callbacks with a two-second callback period. When the user's audio or video state changes, the SDK triggers a callback to report the latest audio or video state and the reason for the state change. You can learn about users' interaction experience from the statistic callbacks and state callbacks, and conduct corresponding troubleshooting and experience optimization.

### Network quality report

The `networkQuality` callback reports the uplink and downlink last-mile network quality of each user in the `Communication` profile or each host in the `LiveBroadcasting` profile in the current call, see [quality rating table](#rate) for details. The last mile is the network from your device to the Agora edge server. The uplink last mile quality rating is based on the actual transmission bitrate, the uplink network packet loss rate, the average round-trip delay, and the uplink network jitter; while the downlink last mile quality rating is based on the downlink network packet loss rate, the average round-trip delay, and the downlink network jitter. The higher the ratio of the actual transmission bitrate to the target transmission bitrate, the better the call quality and the higher the network quality. The average round-trip delay refers to the average value of multiple round-trip delays in the reported interval.

### Statistics report

The `reportRtcStats` callback reports call statistics. You can see the duration, the number of users in the channel, the system CPU usage, the application CPU usage, and so on. For details, see [API reference](#api).

### Audio quality report

This section describes the user's audio quality report, including local audio stream statistics, local audio stream state change, remote audio stream statistics, and remote audio stream state change.

#### Statistics of local audio streams

The `localAudioStats` callback, which is triggered once every two seconds, reports the statistics of the audio streams sent. You can learn about the following important statistics:

- The number of audio channels.
- The actual sample rate of the audio streams sent in the reported interval.
- The average sending bitrate in the reported interval.

#### State changes of local audio streams

When the state of local audio changes, such as the state of audio recording or audio encoding changes, the SDK triggers the `localAudioStateChange` callback to report the current state. You can troubleshoot with the error code when exceptions occur.

#### Statistics of remote audio streams

The following figure shows the transmission process between app clients.

![](https://web-cdn.agora.io/docs-files/1565945275984)

The `remoteAudioStats` callback reports the audio statistics of each remote user in the `Communication` profile or remote host in the `LiveBroadcasting` profile in the current call. You can learn about the quality of the audio stream sent by each remote user in the `Communication` profile or remote host in the `LiveBroadcasting` profile (see [quality rating table](#rate)), the number of audio channels, and so on. For details, see [API reference](#api).


To analyse statistics more closely linked to the user's experience and audio transmission quality, use `remoteAudioStats`. Even if network packet loss occurs, users might find the overall audio quality acceptable because the audio frame loss rate of the received audio streams might not be high due to the **anti-packet-loss** and congestion control methods, such as forward error correction (FEC), retransmissions and bandwidth estimation.


#### State changes of remote audio streams

When the audio state of a remote user in the `Communication` profile or remote host in the `LiveBroadcasting` profile changes, the SDK triggers the `remoteAudioStateChangeOfUid` callback to report the current state and the reason for the state change.

### Video quality report

This section describes the user's video quality report, including local video stream statistics, local video stream state change, remote video stream statistics, and remote video stream state change.


#### Statistics of local video streams

The `localVideoStats` callback reports the statistics of the video streams sent. You can learn about the dimensions of the encoding frame, the target bitrate of the encoder, the bitrate of the video sent in the reported interval, and so on. For details, see [API reference](#api).

> If you have called the `enableDualStreamMode` method to enable [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode), this callback reports the statistics of the high-video streams sent.

#### State changes of local video streams

When the state of the local video changes, the SDK triggers the `localVideoStateChanged` callback to report the current state. You can troubleshoot with the error code when exceptions occur.

#### Statistics of remote video streams

The following figure shows the transmission process between app clients.

![](https://web-cdn.agora.io/docs-files/1565945292345)

The `remoteVideoStats` callback reports the video statistics of each remote user in the `Communication` profile or remote host in the `LiveBroadcasting` profile in the current call. You can learn about their video dimensions, the type of video streams, the bitrate of the video received in the reported interval, and so on. For details, see [API reference](#api).

#### State changes of remote video streams

When the video state of a remote user in the `Communication` profile or remote host in the `LiveBroadcasting` profile changes, the SDK triggers the `remoteVideoStateChangedOfUid` callback to report the current state and the reason for the state change.


## Implementation

1. Ensure that you have a project that has implemented the basic real-time engagement functionality. For details, see [Start a Call](start_call_android) or [Start Interactive Live Streaming](start_live_android).

2. Implement the following real-time interaction quality statistic callbacks and audio or video state callbacks in `AgoraRtcEngineDelegate` to monitor user interaction experience.

    - `networkQuality`: Reports the quality of uplink and downlink last-mile network.
    - `reportRtcStats`: Reports real-time interaction statistics.
    - `localAudioStats`: Reports statistics of the audio stream sent.
    - `localAudioStateChange`: Reports the local audio stream state changes.
    - `remoteAudioStats`: Reports statistics of a remote audio stream received.
    - `remoteAudioStateChangeOfUid`: Reports the remote audio stream state changes.
    - `localVideoStats`: Reports statistics of the video stream sent.
    - `localVideoStateChanged`: Reports the local video stream state changes.
    - `remoteVideoStats`: Reports statistics of a remote video stream received.
    - `remoteVideoStateChangedOfUid`: Reports the remote video stream state changes.

```swift
extension JoinChannelVideoMain: AgoraRtcEngineDelegate {

    func rtcEngine(_ engine: AgoraRtcEngineKit, reportRtcStats stats: AgoraChannelStats) {
        localVideo.statsInfo?.updateChannelStats(stats)
    }

    func rtcEngine(_ engine: AgoraRtcEngineKit, localVideoStats stats: AgoraRtcLocalVideoStats) {
        localVideo.statsInfo?.updateLocalVideoStats(stats)
    }

    func rtcEngine(_ engine: AgoraRtcEngineKit, localAudioStats stats: AgoraRtcLocalAudioStats) {
        localVideo.statsInfo?.updateLocalAudioStats(stats)
    }

    func rtcEngine(_ engine: AgoraRtcEngineKit, remoteVideoStats stats: AgoraRtcRemoteVideoStats) {
        remoteVideo.statsInfo?.updateVideoStats(stats)
    }

    func rtcEngine(_ engine: AgoraRtcEngineKit, remoteAudioStats stats: AgoraRtcRemoteAudioStats) {
        remoteVideo.statsInfo?.updateAudioStats(stats)
    }
}
```

<a name="api"></a>
## API Reference

- [`networkQuality`]()
- [`reportRtcStats`]()
- [`localAudioStats`]()
- [`localAudioStateChange`]()
- [`remoteAudioStats`]()
- [`remoteAudioStateChangeOfUid`]()
- [`localVideoStats`]()
- [`localVideoStateChanged`]()
- [`remoteVideoStats`]()
- [`remoteVideoStateChangedOfUid`]()

<a name="rate"></a>
## Quality rating table

| Code        |     Description                                                       |
| :------------------ | ------------------------------------------------------------ |
| `AgoraNetworkQualityUnknown (0)`     | The network quality is unknown.                           |
| `AgoraNetworkQualityExcellent (1)`   |The network quality is excellent.                         |
| `AgoraNetworkQualityGood(2)`       | The user subjectively feels that the network quality is similar to `AgoraNetworkQualityExcellent (1)`, but the bitrate might be slightly lower than `AgoraNetworkQualityExcellent (1)`. |
| `AgoraNetworkQualityPoor (3)`       | The user subjectively feels that the network quality is flawed but does not affect communication.|
| `AgoraNetworkQualityBad (4)`         | The user can barely communicate, but the communication is not smooth. |
| `AgoraNetworkQualityVBad (5)`       | The network quality is so poor and the communication is basically impossible. |
| `AgoraNetworkQualityDown (6)`        | Users cannot communicate with each other at all.  |