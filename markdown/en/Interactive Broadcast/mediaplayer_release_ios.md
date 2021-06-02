---
title: Release Notes
platform: iOS
updatedAt: 2021-03-30 06:51:16
---
This page provides release notes for the Agora MediaPlayer Kit plugin.
## Overview
The Agora MediaPlayer Kit is a media player plug-in developed for live broadcast scenes, and is compatible with the Agora Native SDK (v2.4.0 or later).

This plug-in helps developers enable the function of playing media resources in real-time live broadcasts through the use of streamlined and flexible APIs, and synchronously sharing local or online media resources played by the broadcaster to all users in the channel. See [function description](https://docs.agora.io/en/Interactive%20Broadcast/mediaplayer_ios?platform=iOS#function-description) for details.

To enrich the live broadcast playability and improve the real-time interactive experience, we recommend using the mediaplayer kit in the following scenarios:
- Local playback: Play local or online media resources.
- Online education: The teacher shares a currently playing video with the students during an online class.
- Live sports: The broadcaster shares the live sports with the audience during his/her live broadcast.
- Pseudo live broadcast: Share or publish the video recorded by the broadcaster in advanced to the audience.

## v1.1.0

v1.1.0 is released on Feb 28, 2020.

This is the first release of the mediaplayer kit. You can use it in your project to enable the following functions:

#### 1. Sharing media resources
To enrich the live playability, the broadcaster can synchronously share the playback of the local and online media resource with all users in the channel.

#### 2. Playing multiple media resources simultaneously
To meet various demands for a varied audience, the broadcaster can play multiple media resources simultaneously by creating multiple instances of `AgoraMediaPlayer`.

#### 3. Playback controls
The broadcaster has access to real-time playback controls for opening the media resource, playing the media resource, pausing the playback, resuming the playback, and seeking to the new playback position of the media resource.

#### 4. Precise volume controls
To precisely control the playback volume at different stages, the broadcasters can adjust the local and remote playback volume separately, which improves the user experience on both the playback and subscription ends.

#### 5. Getting playback information
The broadcaster can actively obtain various playback information, such as current playback progress, playback state, and detailed media stream information.

#### 6. Overriding the delegate method and monitoring events
The `AgoraMediaPlayerDelegate` delegate method contains a series of events, such as playback progress, playback state, and the result of a seek operation to a new playback position. By listening for these events, you can have more control over the playback process. When an exception occurs, you can use these event callbacks for troubleshooting.

Besides, you can listen for events that report receiving the media metadata, each audio frame and each video frame. These events help you include more complex functions in multiple scenarios, such as using custom format data, recording audio, recording video, and screenshots.

### Related Links
We provide complete documentation for the mediaplayer kit. See the following links:
- [Integration documentation](https://docs.agora.io/en/Interactive%20Broadcast/mediaplayer_ios?platform=iOS)
- [API documentation](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/mediaplayer_oc/docs/headers/MediaPlayer-Kit-Objective-C-API-Overview.html)