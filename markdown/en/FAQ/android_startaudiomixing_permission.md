---
title: Why can't I play the background music using startAudioMixing on Android 10?
platform: ["Android"]
updatedAt: 2020-05-18 17:11:13
Products: ["Voice","Video","Interactive Broadcast"]
---
## Issue description

Cannot play an mp3, mp4, or any other music format using `startAudioMixing` on Android 10.

## Reason

This is caused by an Android permission limit. If `targetSdkVersion` &ge; 29, you need to add relevant app privileges to play the a music file.

## Solution

For Android projects with `targetSdkVersion` &ge; 29, add the following line in the `application` zone of the AndroidManifest.xml file to play the music file:

```xml
<application
   android:usesCleartextTraffic="true"
   android:requestLegacyExternalStorage="true"
   …
</application>
```

## Relevant links

For more Android permission settings and considerations, see [Add project permissions](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android#add-project-permissions).