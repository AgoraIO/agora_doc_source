---
title: Why can't I use startAudioMixing to play a music file?
platform: ["All Platforms"]
updatedAt: 2021-02-05 07:28:29
Products: ["Voice","Video","Interactive Broadcast","live-streaming","Audio Broadcast"]
---
## Issue description

Music playback fails when you call `startAudioMixing` to play a local or online music file.

## Solutions

### Step 1: Self-check

- Ensure that you call `startAudioMixing` after joining a channel.
- Ensure that the file format is supported; otherwise, the SDK returns the warning code `701` ("An error occurs in opening the audio mixing file"). The following file formats are supported:
  - Android: MP3, MP4, M4A, AAC, 3GP, MKV, and WAV.
  - iOS/macOS: MP3, AAC, M4A, 3GP, and WAV.
  - Windows: 3GP, ASF, ADTS, AVI, MP3, MP4, MPEG-4, SAMI, and WAVE.
- To play a local music file, ensure that you use the correct absolute path; otherwise, the SDK returns the warning code `701`. 
- To play an online music file:
  - Ensure that the URL is accessible; otherwise, the SDK returns the warning code `701`. 
  - On Android devices, Agora does not recommend using a redirected URL address because it may fail to work.
  - On Android, iOS, and macOS devices, ensure that the time interval between calling `startAudioMixing` is more than 100 ms; otherwise, the SDK returns the warning code `702` ("The SDK opens the audio mixing file too frequently"). 
- If you use an Android device, ensure that the Android version is 4.2 or later, and that the API level is 16 or later.
- If you use an iOS device, ensure that the iOS version is 8.0 or later.
- If you use an Android simulator, ensure that the music file is an MP3 file stored under the path `/sdcard/`.

If the issue remains, open the file with the default music player in your operating system:

- If the file cannot be played, the file itself is likely the problem. Try a different music file.
- If the file can be played normally, the file is probably not the issue. In this case, go to Step 2.

### Step 2: Contact Agora Customer Support

If the issue persists, contact Agora Customer Support and submit the issue with the following information:

- The self-check steps you have performed and the corresponding results.
- The music file that fails to be played.
- The SDK log file. See [How can I set the log file?](https://docs.agora.io/en/Video/faq/logfile).

## Relevant link

[Why can't I play the background music using startAudioMixing on Android 10?](https://docs.agora.io/en/Video/faq/android_startaudiomixing_permission)