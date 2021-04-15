---
title: Report Call Statistics
platform: Web
updatedAt: 2021-01-05 06:13:20
---
## Introduction

The Agora Web SDK provides API methods for you to get the audio and video statistics reflecting the overall quality of a call.

The statistics include:

- [The statistics of the system ](#system_statistics)
- [The statistics of the network](#network_statistics)
- [The statistics of the session](#session_statistics)
- [The statistics of the local stream](#local_stream_statistics)
- [The statistics of the remote stream](#remote_stream_statistics)
- [The uplink and downlink network conditions of the local user](#updownlink_network_quality)
- [Exception events in the channel](#exception)

## Implementation

Ensure that you implement a video call or interactive video streaming in your project. For details, see [Start a Call](start_call_web) or [Start Live Interactive Streaming](start_live_web).

<a name ="system_statistics"></a>

### Get the statistics of the system

Call the [`Client.getSystemStats`](./API%20Reference/web/interfaces/agorartc.client.html#getsystemstats) method to get the statistics of the system for optimizing your app. Currently, only the battery level information is provided.

``` javascript
client.getSystemStats((stats) => {
	console.log(`Current battery level: ${stats.BatteryLevel}`);
});
```

> This method is under testing. For web browser compatibility, see [Battery Status API](https://developer.mozilla.org/en-US/docs/Web/API/Battery_Status_API).

<a name ="network_statistics"></a>

### Get the statistics of the network

Call the  [`Client.getTransportStats`](./API%20Reference/web/interfaces/agorartc.client.html#gettransportstats)[<sup>[1]</sup>](#reference) method to get the network type and the statistics of the network connection[<sup>[2]</sup>](#reference), including: 

  - `NetworkType`: The network type[<sup>[3]</sup>](#reference), such as Wi-Fi, cellular network or bluetooth network.
  - `OutgoingAvailableBandwidth`: The estimated available bandwidth for sending the stream, in Kbps.
  - `RTT`: The RTT (Round-Trip Time) between the SDK and the access node of the SD-RTN, in ms.

``` javascript
setInterval(() => {
  client.getTransportStats((stats) => {
    console.log(`Current Transport RTT: ${stats.RTT}`);
    console.log(`Current Network Type: ${stats.networkType}`);
    console.log(`Current Transport OutgoingAvailableBandwidth: ${stats.OutgoingAvailableBandwidth}`);
  });
}, 1000)                        
```

<a name ="reference"></a>

> - [1] This method only supports Google Chrome.
> - [2] It takes at most 3 seconds to get the statistics.
> - [3] Google Chrome 61 or later is required for the  `NetworkType` parameter, and the compatibility is not guaranteed.  For more information, see [Network Information API](https://developer.mozilla.org/en-US/docs/Web/API/Network_Information_API).

<a name ="session_statistics"></a>

### Get the statistics of the session

Call the [`Client.getSessionStats`](./API%20Reference/web/interfaces/agorartc.client.html#getsessionstats) method to get the statistics of the session, including: 

- `Duration`: Call duration in seconds, represented by an aggregate value.
- `RecvBitrate`: Total received bitrate of the stream, in Kbps, represented by an instantaneous value.
- `RecvBytes`: Total number of bytes received, represented by an aggregate value.
- `SendBitrate`: Total sent bitrate of the stream, in Kbps, represented by an instantaneous value.
- `SendBytes`: Total number of bytes sent, represented by an aggregate value.
- `UserCount`: Number of users in the channel.
  - In rtc mode, the number of all users in the channel.
  - In live mode, 
    - If the local user is an audience: The number of hosts in the channel + 1.
    - If the local user is a host: The number of hosts in the channel.

```javascript
setInterval(() => {
  client.getSessionStats((stats) => {
    console.log(`Current Session Duration: ${stats.Duration}`);
    console.log(`Current Session UserCount: ${stats.UserCount}`);
    console.log(`Current Session SendBytes: ${stats.SendBytes}`);
    console.log(`Current Session RecvBytes: ${stats.RecvBytes}`);
    console.log(`Current Session SendBitrate: ${stats.SendBitrate}`);
    console.log(`Current Session RecvBitrate: ${stats.RecvBitrate}`);
  });
}, 1000)
```

> - This method only supports Google Chrome.
> - It takes at most 3 seconds to get the statistics.

<a name ="local_stream_statistics"></a>

### Get the statistics of the local stream

- Call the [`Client.getLocalAudioStats`](./API%20Reference/web/interfaces/agorartc.client.html#getlocalaudiostats) method to get the **audio** statistics of the local stream, including:
  - `CodecType`: Encoding type of the sent audio.
  - `MuteState`: Whether the audio is muted or not.
  - `RecordingLevel`: Energy level of the captured audio.
  - `SamplingRate`: Sampling rate of the sent audio, in kHz.
  - `SendBitrate`: Bitrate of the sent audio, in Kbps.
  - `SendLevel`: Energy level of the sent audio.

``` javascript
setInterval(() => {
  client.getLocalAudioStats((localAudioStats) => {
    for(var uid in localAudioStats){
      console.log(`Audio CodecType from ${uid}: ${localAudioStats[uid].CodecType}`);
      console.log(`Audio MuteState from ${uid}: ${localAudioStats[uid].MuteState}`);
      console.log(`Audio RecordingLevel from ${uid}: ${localAudioStats[uid].RecordingLevel}`);
      console.log(`Audio SamplingRate from ${uid}: ${localAudioStats[uid].SamplingRate}`);
      console.log(`Audio SendBitrate from ${uid}: ${localAudioStats[uid].SendBitrate}`);
      console.log(`Audio SendLevel from ${uid}: ${localAudioStats[uid].SendLevel}`);
    }
  });
}, 1000)
```

- Call the [`Client.getLocalVideoStats`](./API%20Reference/web/interfaces/agorartc.client.html#getlocalvideostats) method to get the **video** statistics of the local stream, including:
  - `CaptureFrameRate`: Frame rate of the captured video, in fps.
  - `CaptureResolutionHeight`: Height of the captured video, in pixels.
  - `CaptureResolutionWidth`: Width of the captured video, in pixels.
  - `EncodeDelay`: Delay from capturing to encoding the local video, in ms.
  - `MuteState`: Whether the video is muted or not.
  - `SendBitrate`: Bitrate of the sent video, in Kbps.
  - `SendFrameRate`: Frame rate of the sent video, in fps.
  - `SendResolutionHeight`: Height of the sent video, in pixels.
  - `SendResolutionWidth`: Width of the sent video, in pixels.
  - `TargetSendBitrate`: Bitrate of the local video set in `setVideoProfile`.
  - `TotalDuration`: Total duration of the published video, in seconds.
  - `TotalFreezeTime`: Total freeze time of the encoded video, in seconds.

``` javascript
setInterval(() => {
  client.getLocalVideoStats((localVideoStats) => {
    for(var uid in localVideoStats){
      console.log(`Video CaptureFrameRate from ${uid}: ${localVideoStats[uid].CaptureFrameRate}`);
      console.log(`Video CaptureResolutionHeight from ${uid}: ${localVideoStats[uid].CaptureResolutionHeight}`);
      console.log(`Video CaptureResolutionWidth from ${uid}: ${localVideoStats[uid].CaptureResolutionWidth}`);
      console.log(`Video EncodeDelay from ${uid}: ${localVideoStats[uid].EncodeDelay}`);
      console.log(`Video MuteState from ${uid}: ${localVideoStats[uid].MuteState}`);
      console.log(`Video SendBitrate from ${uid}: ${localVideoStats[uid].SendBitrate}`);
      console.log(`Video SendFrameRate from ${uid}: ${localVideoStats[uid].SendFrameRate}`);
      console.log(`Video SendResolutionHeight from ${uid}: ${localVideoStats[uid].SendResolutionHeight}`);
      console.log(`Video SendResolutionWidth from ${uid}: ${localVideoStats[uid].SendResolutionWidth}`);
      console.log(`Video TargetSendBitrate from ${uid}: ${localVideoStats[uid].TargetSendBitrate}`);
      console.log(`Video TotalDuration from ${uid}: ${localVideoStats[uid].TotalDuration}`);
      console.log(`Video TotalFreezeTime from ${uid}: ${localVideoStats[uid].TotalFreezeTime}`);
    }
  });
}, 1000)
```

> - This method only supports Google Chrome.
> - It takes at most 3 seconds to get the statistics.

<a name ="remote_stream_statistics"></a>

### Get the statistics of the remote stream

**Statistics of remote audio streams**

![](https://web-cdn.agora.io/docs-files/1565945275984)

- Call the [`Client.getRemoteAudioStats`](./API%20Reference/web/interfaces/agorartc.client.html#getremoteaudiostats) method to get the **audio** statistics of the remote stream.

  | Parameter           | Description                                                  |
  | ------------------- | ------------------------------------------------------------ |
  | `CodecType`         | Decoding type of the received audio.                         |
  | `End2EndDelay`      | End-to-end delay (ms). Delay from capturing to playing the audio.<br>Stages 1 + 2 + 3 + 4 + 5 + 6 in the above figure. |
  | `MuteState`         | Whether the audio is muted.                                  |
  | `PacketLossRate`    | Packet loss rate (%) of the remote audio.                    |
  | `RecvBitrate`       | Bitrate of the received audio (Kbps).                        |
  | `RecvLevel`         | Volume of the received audio.                                |
  | `TotalFreezeTime`   | Total freeze time (s) of the received audio.                |
  | `TotalPlayDuration` | Total playing duration (s) of the received audio.           |
  | `TransportDelay`    | Transport delay (ms). Delay from sending to receiving the audio.<br>Stages 2 + 3 + 4 in the above figure. |

``` javascript
setInterval(() => {
  client.getRemoteAudioStats((remoteAudioStatsMap) => {
    for(var uid in remoteAudioStatsMap){
      console.log(`Audio CodecType from ${uid}: ${remoteAudioStatsMap[uid].CodecType}`);
      console.log(`Audio End2EndDelay from ${uid}: ${remoteAudioStatsMap[uid].End2EndDelay}`);
      console.log(`Audio MuteState from ${uid}: ${remoteAudioStatsMap[uid].MuteState}`);
      console.log(`Audio PacketLossRate from ${uid}: ${remoteAudioStatsMap[uid].PacketLossRate}`);
      console.log(`Audio RecvBitrate from ${uid}: ${remoteAudioStatsMap[uid].RecvBitrate}`);
      console.log(`Audio RecvLevel from ${uid}: ${remoteAudioStatsMap[uid].RecvLevel}`);
      console.log(`Audio TotalFreezeTime from ${uid}: ${remoteAudioStatsMap[uid].TotalFreezeTime}`);
      console.log(`Audio TotalPlayDuration from ${uid}: ${remoteAudioStatsMap[uid].TotalPlayDuration}`);
      console.log(`Audio TransportDelay from ${uid}: ${remoteAudioStatsMap[uid].TransportDelay}`);
    }
  });
}, 1000)
```

**Statistics of remote video streams**

![](https://web-cdn.agora.io/docs-files/1565945292345)

- Call the [`Client.getRemoteVideoStats`](./API%20Reference/web/interfaces/agorartc.client.html#getremotevideostats) method to get the **video** statistics of the remote stream.

  | Parameter                | Description                                                  |
  | ------------------------ | ------------------------------------------------------------ |
  | `End2EndDelay`           | End-to-end delay (ms). Delay from capturing to playing the video.<br/>Stages 1 + 2 + 3 + 4 + 5 + 6 in the above figure. |
  | `MuteState`              | Whether the video is muted.                                  |
  | `PacketLossRate`         | Packet loss rate (%) of the remote video.                    |
  | `RecvBitrate`            | Bitrate of the received video (Kbps).                        |
  | `RecvResolutionHeight`   | Height of the received video, in pixels.                     |
  | `RecvResolutionWidth`    | Width of the received video, in pixels.                      |
  | `RenderFrameRate`        | Rendering frame rate of the decoded video, in fps.           |
  | `RenderResolutionHeight` | Height of the rendered video, in pixels.                     |
  | `RenderResolutionWidth`  | Width of the rendered video, in pixels.                      |
  | `TotalFreezeTime`        | Total freeze time (s) of the received video.                 |
  | `TotalPlayDuration`      | Total playing duration (s) of the received video.            |
  | `TransportDelay`         | Transport delay (ms). Delay from sending to receiving the video.<br/>Stages 2 + 3 + 4 in the above figure. |

``` javascript
setInterval(() => {
  client.getRemoteVideoStats((remoteVideoStatsMap) => {
    for(var uid in remoteVideoStatsMap){
      console.log(`Video End2EndDelay from ${uid}: ${remoteVideoStatsMap[uid].End2EndDelay}`);
      console.log(`Video MuteState from ${uid}: ${remoteVideoStatsMap[uid].MuteState}`);
      console.log(`Video PacketLossRate from ${uid}: ${remoteVideoStatsMap[uid].PacketLossRate}`);
      console.log(`Video RecvBitrate from ${uid}: ${remoteVideoStatsMap[uid].RecvBitrate}`);
      console.log(`Video RecvResolutionHeight from ${uid}: ${remoteVideoStatsMap[uid].RecvResolutionHeight}`);
      console.log(`Video RecvResolutionWidth from ${uid}: ${remoteVideoStatsMap[uid].RecvResolutionWidth}`);
      console.log(`Video RenderFrameRate from ${uid}: ${remoteVideoStatsMap[uid].RenderFrameRate}`);
      console.log(`Video RenderResolutionHeight from ${uid}: ${remoteVideoStatsMap[uid].RenderResolutionHeight}`);
      console.log(`Video RenderResolutionWidth from ${uid}: ${remoteVideoStatsMap[uid].RenderResolutionWidth}`);
      console.log(`Video TotalFreezeTime from ${uid}: ${remoteVideoStatsMap[uid].TotalFreezeTime}`);
      console.log(`Video TotalPlayDuration from ${uid}: ${remoteVideoStatsMap[uid].TotalPlayDuration}`);
      console.log(`Video TransportDelay from ${uid}: ${remoteVideoStatsMap[uid].TransportDelay}`);
    }
  });
}, 1000)
```

> - This method only supports Google Chrome.
> - It takes at most 3 seconds to get the statistics.

<a name ="updownlink_network_quality"></a>

### Reports on the uplink and downlink network conditions of the local user

The [`network-quality`](./API%20Reference/web/interfaces/agorartc.client.html#on) callback in  `Client.on` reports on the uplink and downlink network conditions of the local user once every two seconds.

- `downlinkNetworkQuality`: The downlink network quality.
- `uplinkNetworkQuality`: The uplink network quality.

**Quality Rating Table**

| Rating | Description                                                  |
| ------ | :----------------------------------------------------------- |
| 0      | The network quality is unknown.                              |
| 1      | The network quality is excellent.                            |
| 2      | The network quality is quite good, but the bitrate may be slightly lower than excellent. |
| 3      | Users can feel the communication slightly impaired.          |
| 4      | Users cannot communicate smoothly.                           |
| 5      | The network is so bad that users can barely communicate.     |
| 6      | The network is down and users cannot communicate at all.     |

``` javascript
client.on("network-quality", function(stats) {
    console.log("downlinkNetworkQuality", stats.downlinkNetworkQuality);
    console.log("uplinkNetworkQuality", stats.uplinkNetworkQuality);
});
```

> This is an experimental feature and the network quality rating is for reference only.

<a name ="exception"></a>

### Reports exception events in the channel

The [`exception`](./API%20Reference/web/interfaces/agorartc.client.html#on)  callback in  `Client.on` reports on exception events in the channel. Exceptions are not errors, but usually mean quality issues. This callback also reports recovery from an exception.

- `code`: Event code.
- `msg`: Event message.
- `uid`: The uid of the user who experiences the exception or recovery event.

``` javascript
client.on("exception", function(evt) {
  console.log(evt.code, evt.msg, evt.uid);
})
```

Each exception event has a corresponding recovery event. See the table below for details.

![](https://web-cdn.agora.io/docs-files/1550136373895)

> This callback only supports Google Chrome.

## Considerations

All the methods should be called after joining the channel.