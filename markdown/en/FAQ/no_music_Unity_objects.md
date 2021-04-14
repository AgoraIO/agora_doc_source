---
title: Why can't I hear the music when using Unity objects to play the music?
platform: ["Unity"]
updatedAt: 2020-03-09 10:13:36
Products: ["Voice","Video","Interactive Broadcast"]
---
## Issue description

When using Unity objects like AudioSource and AudioClip to play the music on an iOS device, you may encounter the following issue:

- Being able to hear the music at first, but no longer hearing it after joining a channel.
- Being able to hear the music in a channel, but no longer hearing it after leaving the channel.

## Reason

When you use Unity objects to play the music before joining a channel, the status of the system `AudioSession` is set to active. After you join or leave a channel, the Agora Unity SDK changes the status of the system `AudioSession` to inactive, which is why you cannot hear the music after joining or leaving a channel.

## Solution

Before joining a channel, call `mRtcEngine.SetParameters("{\"che.audio.keep.audiosession\":true}");` to keep the status of the system `AudioSession` as active. This ensures that you can hear the music, even after you join or leave a channel.