---
title: Which media players can play the recored files?
platform: ["Linux"]
updatedAt: 2020-01-14 11:26:13
Products: ["Recording"]
---
You get different recorded files in different recording modes.

- In the individual recording mode, you get an audio file and a video file for each user. You need to [Use the Transcoding Script ](/en/Recording/recording_merge_files) to merge these files into one MP4 file for playback.
- In the composite recording mode, if you set `mixedVideoAudio` as `0`, you get an audio file and a video file for all the users. You also need to [Use the Transcoding Script ](/en/Recording/recording_merge_files) to merge the files. We recommend you set `mixedVideoAudio` as `2` to mix the audio and video into one MP4 file.

The following table lists the media players that can play the recorded files after transcoding, and when `mixedVideoAudio` is set as `1` or `2`.

> The recorded files after transcoding include the following files:
> - The MP4 file merged from the recorded files in the individual recording mode.
> - The MP4 file merged from the recorded files in the composite recording mode with `mixedVideoAudio`  set as `0`.

| Platform | Player/Browser          | After transcoding | mixedVideoAudio = 1 | mixedVideoAudio = 2 |
| -------- | ----------------------- | ----------------- | ------------------- | ------------------- |
| Linux    | VLC Media Player        | Supported         | Supported           | Supported           |
| Linux    | FFplay                | Supported         | Supported           | Supported           |
| Linux    | Chrome                  | **Not Supported** | **Not Supported**   | **Not Supported**   |
| Windows  | Media Player            | Supported         | Supported           | Supported           |
| Windows  | KM Player               | Supported         | Supported           | Supported           |
| Windows  | VLC Player              | Supported         | Supported           | Supported           |
| Windows  | Chrome (49.0.2623+)     | Supported         | Supported           | Supported           |
| macOS    | QuickTime Player        | Supported         | Supported           | Supported           |
| macOS    | VLC                     | **Not Supported** | **Not Supported**   | **Not Supported**   |
| macOS    | Movist                  | Supported         | Supported           | Supported           |
| macOS    | MPlayerX                | Supported         | Supported           | Supported           |
| macOS    | KMPlayer                | **Not Supported** | **Not Supported**   | **Not Supported**   |
| macOS    | Chrome (47.0.2526.111+) | Supported         | Supported           | Supported           |
| macOS    | Safari (11.0.3+)        | Supported         | Supported           | Supported           |
| iOS      | Default Player          | Supported         | Supported           | Supported           |
| iOS      | VLC for Mobile          | **Not Supported** | **Not Supported**   | Supported           |
| iOS      | KMPlayer                | Supported         | Supported           | Supported           |
| iOS      | Safari (9.0+)           | Supported         | Supported           | Supported           |
| Android  | Default Player          | Supported         | Supported           | Supported           |
| Android  | MXPlayer                | Supported         | Supported           | Supported           |
| Android  | VLC for Android         | Supported         | Supported           | Supported           |
| Android  | KMPlayer                | Supported         | Supported           | Supported           |
| Android  | Chrome (49.0.2623+)     | Supported         | Supported           | Supported           |