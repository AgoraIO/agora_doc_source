# In-call Statistics

The Agora RTC SDK provides callbacks to feedback quality of calls and live streamings in real-time, such as network quality, audio quality, video quality, and real-time interaction statistics of users in the channel. This page describes how to understand the information returned by the callbacks and how to use these callbacks.

## Understand the tech

After a user successfully joins the channel, the SDK sends the monitored real-time interaction quality statistics back to you from a series of callbacks with a two-second callback period. When the user's audio or video state changes, the SDK triggers a callback to report the latest audio or video state and the reason for the state change. You can learn about users' interaction experience from the statistic callbacks and state callbacks, and conduct corresponding troubleshooting and experience optimization.

### Network quality report

The `onNetworkQuality` callback reports the uplink and downlink last-mile network quality of each user in the `COMMUNICATION` profile or each host in the `LIVE_BROADCASTING` profile in the current call, see [quality rating table](#rate) for details. The last mile is the network from your device to the Agora edge server. The uplink last mile quality rating is based on the actual transmission bitrate, the uplink network packet loss rate, the average round-trip delay, and the uplink network jitter; while the downlink last mile quality rating is based on the downlink network packet loss rate, the average round-trip delay, and the downlink network jitter. The higher the ratio of the actual transmission bitrate to the target transmission bitrate, the better the call quality and the higher the network quality. The average round-trip delay refers to the average value of multiple round-trip delays in the reported interval.

### Statistics report

The `onRtcStats` callback reports call statistics. You can learn about the duration, the number of users in the channel, the system CPU usage, the application CPU usage, and so on. For details, see [API reference](#api).

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

The `onRemoteAudioStats` callback reports the audio statistics of each remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile in the current call. You can learn about the quality of the audio stream sent by each remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile (see [quality rating table](#rate)), the number of audio channels, and so on. For details, see [API reference](#api).

To analyse statistics more closely linked to the user's experience and audio transmission quality, use `onRemoteAudioStats`. Even if network packet loss occurs, users might find the overall audio quality acceptable because the audio frame loss rate of the received audio streams might not be high due to the **anti-packet-loss** and congestion control methods, such as forward error correction (FEC), retransmissions and bandwidth estimation.


#### State changes of remote audio streams

When the audio state of a remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile changes, the SDK triggers the `onRemoteAudioStateChanged` callback to report the current state and the reason for the state change.

### Video quality report

This section describes the user's video quality report, including local video stream statistics, local video stream state change, remote video stream statistics, and remote video stream state change.


#### Statistics of local video streams

The `onLocalVideoStats` callback reports the statistics of the video streams sent. You can learn about the dimensions of the encoding frame, the target bitrate of the encoder, the bitrate of the video sent in the reported interval, and so on. For details, see [API reference](#api).

> If you have called the `enableDualStreamMode` method to enable [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode), this callback reports the statistics of the high-video streams sent.

#### State changes of local video streams

When the state of the local video changes, the SDK triggers the `onLocalVideoStateChanged` callback to report the current state. You can troubleshoot with the error code when exceptions occur.

#### Statistics of remote video streams

The following figure shows the transmission process between app clients.

![](https://web-cdn.agora.io/docs-files/1565945292345)

The `onRemoteVideoStats` callback reports the video statistics of each remote user in the `COMMUNICATION` profile or remote host in the `LIVE_BROADCASTING` profile in the current call. You can learn about their video dimensions, the type of video streams, the bitrate of the video received in the reported interval, and so on. For details, see [API reference](#api).

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

    public void onRemoteAudioStateChanged(int uid, IRtcEngineEventHandler.REMOTE_AUDIO_STATE state, IRtcEngineEventHandler.REMOTE_AUDIO_STATE_REASON reason, int elapsed)
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

<a name="api"></a>
## API Reference

- [`onNetworkQuality`]()
- [`onRtcStats`]()
- [`onLocalAudioStats`]()
- [`onLocalAudioStateChanged`]()
- [`onRemoteAudioStats`]()
- [`onRemoteAudioStateChanged`]()
- [`onLocalVideoStats`]()
- [`onLocalVideoStateChanged`]()
- [`onRemoteVideoStats`]()
- [`onRemoteVideoStateChanged`]()

<a name="rate"></a>
## Quality rating table

| Code        |     Description                                                       |
| :------------------ | ------------------------------------------------------------ |
| `QUALITY_UNKNOWN (0)`     | The network quality is unknown.                           |
| `QUALITY_EXCELLENT (1)`   |The network quality is excellent.                         |
| `QUALITY_GOOD(2)`       | The user subjectively feels that the network quality is similar to `QUALITY_EXCELLENT (1)`, but the bitrate might be slightly lower than `QUALITY_EXCELLENT (1)`. |
| `QUALITY_POOR (3)`       | The user subjectively feels that the network quality is flawed but does not affect communication.|
| `QUALITY_BAD (4)`         | The user can barely communicate, but the communication is not smooth. |
| `QUALITY_VBAD (5)`       | The network quality is so poor and the communication is basically impossible. |
| `QUALITY_DOWN (6)`        | Users cannot communicate with each other at all.  |