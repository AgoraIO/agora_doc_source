---
title: Set up subscription lists
platform: All Platforms
updatedAt: 2020-09-27 10:19:08
---
## Overview

By default, Agora Cloud Recording subscribes to all published audio and video streams in a channel. This feature enables you to create a whitelist or blacklist for audio and video subscriptions. You can also update the subscription lists during a cloud recording.

## Implementation

When the recording starts, set the parameters in [`start`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/start) to create subscription lists. During the recording, set the `streamSubscribe` parameter in [`update`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/update) to update the subscription lists.

 <div class="alert note">If you set up a subscription list for audio, but not for video, then Agora Cloud Recording will not subscribe to any video streams. <br>If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</div>


### Set up the subscription list for audio streams

Use either of the following parameters to set up a subscription list for audio:

- `subscribeAudioUids`: Specify the users whose audio streams you want to subscribe to. The setting creates a whitelist for audio subscription.
- `unSubscribeAudioUids`: Specify the users whose audio streams you do not want to subscribe to. The setting creates a blacklist for audio subscription.

### Set up the subscription list for video streams

Use either of the following parameters to set up a subscription list for video:

- `subscribeVideoUids`: Specify the users whose video streams you want to subscribe to. The setting creates a whitelist for video subscription.
- `unSubscribeVideoUids`: Specify the users whose video streams you do not want to subscribe to. The setting creates a blacklist for video subscription.

## Example

Suppose that four users, whose UIDs are 111, 222, 333, and 444, are in a channel when the recording begins, and two more users with unknown UIDs join the channel during the recording. The following lists the typical scenarios and recommended settings:

| Scenarios                                                    | Recommended settings                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| Subscribe to all audio and video streams.                    | You do not need to set up a subscription list.               |
| Subscribe to all audio streams and the video streams of 111 and 222. | `subscribeAudioUids: ["#allstream#"]`, `subscribeVideoUids: ["111","222"]` |
| Subscribe to all audio streams and the video streams of all UIDs except 111 and 222. | `subscribeAudioUids: ["#allstream#"]`, `unSubscribeVideoUids: ["111","222"]`<br>The recording service records the audio streams of all UIDs and the video streams of 333, 444, and the other two unknown UIDs. |
| Subscribe to all audio streams but no video streams.         | `subscribeAudioUids: ["#allstream#"]` <br>(Setting `streamType` to `0` leads to the same result.) |
| Subscribe to the audio streams of all UIDs except 222 and the video stream of 111. | `unSubscribeAudioUids: ["222"]`, `subscribeVideoUids: ["111"]`<br>The recording service records the audio streams of 111, 333, 444, and the other two unknown UIDs, and the video stream of 222. |

## Considerations

- Use `["#allstream#"]` to specify all UIDs in a channel.
- When `streamTypes` in `recordingConfig` is set to `0` (audio only), you cannot set `subscribeVideoUids` or `unSubscribeVideoUids`; when `streamTypes` in `recordingConfig` is set to `1` (video only), you cannot set `subscribeAudioUids` or `unSubscribeAudioUids`.
- The recording service only records the first 17 UIDs that join a channel. If a subscribed UID leaves, then the recording service automatically subscribes to the 18th UID that joined the channel.