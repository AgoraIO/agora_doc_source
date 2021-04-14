---
title: 如何区分媒体音量和通话音量？
platform: ["Android","iOS","macOS","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-07-09 12:02:43
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
一般而言，通话音量指的是进行语音、视频通话时的音量；媒体音量指的是播放音乐、视频或游戏的音效、背景音的音量。在实际使用中，两者的差异在于，通话音量有较好的回声消除，媒体音量有较好的声音表现力。媒体音量可以调整到 0，而通话音量不可以。因此需要区分系统音量走的是通话音量还是媒体音量。

系统音量走通话音量，是指当你在设备上调整音量时，调整的是通话音量。媒体音量同理。

SDK 在 `setAudioProfile` 中提供 6 种不同的 Audio Scenario，包括：`DEFAULT`、`CHATROOM_ENTERTAINMENT`、`EDUCATION`、`GAME_STREAMING`、`SHOWROOM` 和 `CHATROOM_GAMING`。其中：

- `GAME_STREAMING` 场景下，通信时使用媒体音量；直播时无论观众还是主播也都使用媒体音量
- `DEFAULT`、`EDUCATION` 和 `SHOWROOM` 场景下，通信时使用通话音量；直播时观众使用媒体音量，连麦后使用通话音量
- `CHATROMM_ENTERTAINMENT` 和 `CHATROOM_GAMING` 场景下，通信时使用通话音量；直播时无论观众还是主播也都使用通话音量

由于系统限制，媒体音量可以调整到 0，而通话音量不可以。如果需要将音量调整到 0，建议尝试使用媒体音量控制的 Audio Scenario。