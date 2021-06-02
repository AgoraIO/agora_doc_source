---
title: How can I track the quality of a call?
platform: ["Android","iOS","macOS","Windows","Unity","electron"]
updatedAt: 2020-04-10 13:57:55
Products: ["Voice","Video","Interactive Broadcast","Audio Broadcast"]
---
You can track the quality of a call from the following aspects:

- The network quality before the call starts.
- The audio, video and network quality during the call. 

## Before a call

### Test the network quality

**startLastmileProbeTest**

Starts the last-mile network probe test before joining a channel to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

Once this method is enabled, the SDK returns the following callbacks:

- onLastmileQuality: the SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions with a score and is more closely linked to the user experience.
- onLastmileProbeResult: the SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.

### Test the audio device

**startEchoTest**

This method launches an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly.

To conduct the test, the user speaks, and the recording is played back within the set interval. If the user can hear the recording within the interval, the audio devices and network connection are working properly.

## During a call

During a call, the SDK triggers the following callbacks every two seconds. For callbacks that reflect the network quality of the remote user, if there are multiple users or broadcasters, the SDK returns the callbacks as many times.

### Network quality

**1. onNetworkQuality**

This callback reflects the uplink and downlink quality with scores. The uplink transmission quality of the user in terms of the transmission bitrate, packet loss rate, average RTT (Round-Trip Time) and jitter of the uplink network, while Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network.

**2. onLocalVideoStats**

This callback reports the statistics of the local video streams, including the sent bitrate, sent frame rate, target bitrate, target frame rate, and quality adaption.

**3. onRemoteVideoStats**

This callback reports the statistics of the video stream from each remote user or broadcaster, including the width and height of the video stream, the received bitrate, the decoder output frame rate, and the stream type.

**4. onRemoteAudioStats**

This callback reports the statistics of the audio stream from each remote user or broadcaster, including the quality score, network transport delay, jitter buffer delay and audio loss rate.

**5. onRtcStats**

This calback reports the statistics of the RtcEngine, including the total duration, received and sent bytes, received and sent bitrate, number of users, last-mile delay, CPU total usage and CPU app usage.

**6. onRemoteAudioTransportStats**

This callback reports the transport-layer statistics, such as the packet loss rate and time delay the local user receives an audio packet from a remote user.

**7. onRemoteVideoTransportStats**

This callback reports the transport-layer statistics, such as the packet loss rate and time delay after the local user receives the video packet from a remote user.

### Monitor the video state

**1. onLocalVideoStateChanged**

This callback returns the current video state and possible reasons for a video failure. When exceptions occur, you can use this callback for trouble shooting.

**2. onRemoteVideoStateChanged**

This callback reports whether the current remote video is running or frozen.

### Monitor the state of the RTMP streaming

**onRtmpStreamingStateChanged**

This callback reports the state of the RTMP streaming and possible reasons when an error occurs. 