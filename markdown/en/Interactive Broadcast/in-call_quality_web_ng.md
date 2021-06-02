---
title: Report Call Statistics
platform: Web
updatedAt: 2021-03-10 08:23:51
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./in-call_quality_web?platform=Web">Report Call Statistics</a>.</li></div>

## Introduction
The Agora Web SDK provides APIs for you to get the audio and video statistics reflecting the overall quality of a call. The statistics include:
- The last-mile uplink and downlink network conditions of the users.
- The statistics of the call.
- The statistics of the local audio and video tracks.
- The statistics of the remote audio and video tracks.
- Exception events in the channel.

<div class="alert info">Click the <a href="https://webdemo.agora.io/agora-websdk-api-example-4.x/displayCallStats/index.html">online demo</a> to try this feature out.</div>

## Implementation

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

### Get the last-mile network quality of the users

Last mile refers to the connection between your local device and the Agora edge servers.

After the local user joins the channel, the SDK triggers the [AgoraRTCClient.on("network-quality")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_network_quality) callback once every two seconds and provides the uplink and downlink last-mile network conditions of the local user.

You can also call [AgoraRTCClient.getRemoteNetworkQuality](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getremotenetworkquality) to get the network quality of all the remote users to whom the local user subscribes.

**Quality Rating Table**

| Rating | Description                                                  |
| :----- | :----------------------------------------------------------- |
| 0      | The network quality is unknown.                              |
| 1      | The network quality is excellent.                            |
| 2      | The network quality is good, but the bitrate may be slightly lower than optimal. |
| 3      | Users experience slightly impaired communication.            |
| 4      | Users cannot communicate smoothly.                           |
| 5      | The network is so poor that users can barely communicate.    |
| 6      | The network is down and users cannot communicate at all.     |

```js
client.on("network-quality", (stats) => {
    console.log("downlinkNetworkQuality", stats.downlinkNetworkQuality);
    console.log("uplinkNetworkQuality", stats.uplinkNetworkQuality);
});
```
```js
const remoteNetworkQuality = client.getRemoteNetworkQuality();
```

### Get the statistics of the call

Call [AgoraRTCClient.getRTCStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getrtcstats) to get the statistics of the call. For the statistics description, see [AgoraRTCStats](./API%20Reference/web_ng/interfaces/agorartcstats.html).

```
const clientStats = client.getRTCStats();
```

### Get the statistics of local tracks

Call [AgoraRTCClient.getLocalAudioStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getlocalaudiostats) to get the statistics of a local audio track, and call [AgoraRTCClient.getLocalVideoStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getlocalvideostats) to get the statistics of a local video track. For the statistics description, see [LocalAudioTrackStats](./API%20Reference/web_ng/interfaces/localaudiotrackstats.html) and [LocalVideoTrackStats](./API%20Reference/web_ng/interfaces/localvideotrackstats.html).

```
const localStats = {
  video: client.getLocalVideoStats(),
  audio: client.getLocalAudioStats()
};
```

### Get the statistics of remote tracks

Call [AgoraRTCClient.getRemoteAudioStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getremoteaudiostats) to get the statistics of a remote audio track, and call [AgoraRTCClient.getRemoteVideoStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getremotevideostats) to get the statistics of a remote video track. For the statistics description, see [RemoteAudioTrackStats](./API%20Reference/web_ng/interfaces/remoteaudiotrackstats.html) and [RemoteVideoTrackStats](./API%20Reference/web_ng/interfaces/remotevideotrackstats.html). See the following picture for the description of the `end2EndDelay`, `receiveDelay`, and `transportDelay` properties. For the description of other properties, see [RemoteAudioTrackStats](./API%20Reference/web_ng/interfaces/remoteaudiotrackstats.html) and [RemoteVideoTrackStats](./API%20Reference/web_ng/interfaces/remotevideotrackstats.html).

![](https://web-cdn.agora.io/docs-files/1615364618517)

| Property         | Description                                                  |
| :--------------- | :----------------------------------------------------------- |
| `end2EndDelay`   | The delay (ms) between a remote client sampling the audio or video and the local client playing the audio or video. Stages 1 + 2 + 3 + 4 + 5 + 6 in the picture above. |
| `receiveDelay`   | The delay (ms) between a remote client sending the audio or video and the local client playing the audio or video. Stages 2 + 3 + 4 + 5 + 6 in the picture above. |
| `transportDelay` | The delay (ms) between a remote client sending the audio or video and the local client receiving the audio or video. Stages 2 + 3 + 4 in the picture above. |

```
const remoteTracksStats = {
  video: client.getRemoteVideoStats()[uid],
  audio: client.getRemoteAudioStats()[uid]
};
```

### Reports exception events in the channel
The SDK reports exception events in the channel by triggering the [`exception`](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_exception) callback. Exceptions are not errors, but usually indicate quality issues. This callback also reports recovery from an exception.
- `code`: The event code.
- `msg`: The event message.
- `uid`: The uid of the user who experiences the exception or recovery event.

``` javascript
client.on("exception", function(evt) {
  console.log(evt.code, evt.msg, evt.uid);
})
```

Each exception event has a corresponding recovery event. See the table below for details.

![](https://web-cdn.agora.io/docs-files/1550136373895)

## Considerations
All the above methods must be called after joining the channel.