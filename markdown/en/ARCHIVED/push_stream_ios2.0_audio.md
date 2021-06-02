---
title: Push Streams to the CDN
platform: iOS
updatedAt: 2019-09-27 12:15:33
---
## Introduction

CDN live streaming refers to the process of publishing streams to the CDN (Content Delivery Network), where users can view a live broadcast with a web browser.

You can use [transcoding](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#transcoding) to combine the streams of all hosts in the channel into one stream, or set the audio/video profiles and picture-in-picture layout for the stream to be published to the CDN.

Agora's CDN publishing solution is based on the following API methods to publish streams to the CDN, inject external audio streams, transcode, and set the output layout.

-   [`addPublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addPublishStreamUrl:transcodingEnabled:)
-   [`removePublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:)
-   [`setLiveTranscoding`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLiveTranscoding:)

This solution is flexible and allows:

-   Starting or stopping publishing to the CDN.
-   Adding or removing a streaming URL without interrupting the ongoing publishing.
-   Adding extra controls to the ongoing streams.
-   Using callbacks to monitor the status of the publishing.
-   Quick migration from the legacy approach to the new approach.

## Pushing Streams to the CDN

Contact [sales@agora.io](mailto:sales@agora.io) to enable this function.

> You can enable this function in Dashboard in future releases.
> -  A host can dynamically add or remove a URL after joining the channel.
> -  A host can set transcoding and the layout, for example, the canvas settings, only after joining a channel. The host still needs to set a 16 &times; 16 view when only publishing an audio stream to CDN.

The following figure shows a typical CDN-pushing scenario.

![](https://web-cdn.agora.io/docs-files/1550737392049)


### Sample Code

```objective-c
// CDN transcoding settings.
AgoraLiveTranscodingUser *user = [[AgoraLiveTranscodingUser alloc] init];
user.uid = 12345;
user.rect = CGRectMake(0, 0, 16, 16);
user.audioChannel = 0;

AgoraRtcEngineKit *rtcEngine = [AgoraRtcEngineKit sharedEngineWithAppId:@"" delegate:nil];
AgoraLiveTranscoding *transcoding = [[AgoraLiveTranscoding alloc] init];
transcoding.audioSampleRate = AgoraAudioSampleRateType44100;
transcoding.audioChannels = 2;
transcoding.size = CGSizeMake(16, 16);
transcoding.videoFramerate = 15;
transcoding.videoCodecProfile = AgoraVideoCodecProfileTypeHigh;
transcoding.transcodingUsers = @[user];

[rtcEngine setLiveTranscoding:transcoding];
```

```objective-c
// Add a URL to which the host pushes a stream.
// transcodingEnabled: Whether to enable transcoding. Once enabled, use the setLiveTranscoding method to set the transcoding parameters.
[rtcEngine addPublishStreamUrl:streamUrl transcodingEnabled:NO];
```

```objective-c
// Remove a URL to which the host pushes a stream.
[rtcEngine removePublishStreamUrl:streamUrl];
```