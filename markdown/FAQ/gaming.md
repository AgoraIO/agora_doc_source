---
title: 如何处理游戏场景的声音问题？
platform: ["Android", "iOS"]
updatedAt: 2021-02-05 02:48:32
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

**加入频道之前，游戏音效是静音状态，但是指挥模式下进入语音频道之后，为什么游戏音效自动打开？**

进入通话后，音效播放的音量为通话音量，而通话音量无法设置为 0。

**打开游戏音效，设置一定的系统音量不改变，进入频道后听到的游戏音效的音量，为什么明显比进入频道之前听到的游戏音效的音量高？**

媒体音量和通话音量分别属于 2 个不同的、独立的系统，一个设置不会影响到另外一个。 进入通话后，音效的播放音量由通话音量控制。退出通话后，则由媒体音量控制。

**iOS 上开了游戏语音后，启动语音并立马退出语音房间，为什么游戏背景音就变小了？**

在 `joinChannel` 之前，设备使用 Unity 播放游戏背景音乐，对应的 `AudioSessionCategory` 为 `AVAudioSessionCategoryAmbient`，`mode` 为 `AVAudioSessionModeDefault`，使用媒体音量。

在 `joinChannel` 之后，SDK 将 `AudioSessionCategory` 更改为 `AVAudioSessionCategoryPlayAndRecord`，`mode` 为 `AVAudioSessionModeVoiceChat`，使用通话音量。

如果不想在进出房间时发生音量变化，我们建议在退出语音房间时，把 `AudioSessionCategory` 和 `mode` 设置回进房间之前的设置。

<div class="alert note">游戏 SDK v2.2 及之后的版本，以及 2019 年之后发布的 SDK，会自动完成该操作。</div>

**为什么接入 SDK 后游戏音效与语音相互冲突？**

在加入频道的过程中，会发生音频断一下的问题。可以通过设置游戏音效与语音通话均通过媒体音量播出解决，但有可能会导致回声等问题。我们建议充分测试后进行实现。

**麻将棋牌游戏中，4 个人的背景音乐为什么会被相互串到通话里面 ？**

如果是用户自己播放的音频，不是通过调用声网 API 播放的背景音乐，是会存在这个问题的。由于游戏的声音不通过 SDK 播放，播放出来的声音会被录进去。

我们建议在通话的时候，直接关掉音乐和音效，或者在通话连麦时，降低游戏背景音量，以避免该问题。

**在 app 里播放背景音乐， 然后加入频道， 为什么背景音乐音量会变化？调用 leaveChannel 之后，为什么背景音乐也没有了？**

请使用以下方法解决该问题：在 `joinChannel` 之前，调用：`setParameters("{\"che.audio.keep.audiosession\":true}")`;

**播放背景音效的情况下，通信模式加入频道或者直播模式连麦后，为什么听到的背景音效声音会变小？**

在语音连麦过程中，手机系统会开启回声消除以保证人声体验，因此会压低声音，也会压低背景音效。你可以选择如下一种方法解决该问题：

- 确保声音都走外放。你可以调用 `setEnableSpeakerphone` 方法设置语音路由为外放。
- 调用 `startAudioMixing` 或 `playEffect` 方法来播放音效文件。

**`onAudioVolumeIndication` 获得的音量是 0~255, 有没有什么合适的经验阈值界定说话和没说话？**

根据经验，阈值为 40 ～ 50 较合适。音量小于该阈值为没说话，大于该阈值为说话。考虑到不同的人对说话、没说话的定义不一，我们建议你基于该阈值稍作调整。

**游戏 SDK 中媒体音量系统，在连麦后进入通话音量系统时，如何实现静音？**

在 `joinChannel` 前设置如下接口，即可实现静音。

#### iOS 平台

`mRtcEngine.setParameters("{\"che.audio.use.remoteio\":true}");`

#### Android 平台

`mRtcEngine.setParameters("{\"che.audio.stream_type\":3}");`
`mRtcEngine.setParameters("{\"che.audio.audioMode\":0}");`

#### Android 和 iOS 通用的设置

`mRtcEngine.setParameters("{\"che.audio.enable.aec\":true}");`
`mRtcEngine.setParameters("{\"che.audio.enable.agc\":true}");`
`mRtcEngine.setParameters("{\"che.audio.enable.ns\":true}");`

<div class="alert note">上述设置可能会造成回声问题，我们建议充分测试后进行实现。</div>

**蓝牙耳机为什么没有立体声 ？**

因为蓝牙要开通话模式，即 SCO，才能实现播放和录音双向功能。 而在 SCO 模式下，蓝牙只能单声道播放；在 A2DP 模式下蓝牙才可以双声道播放，但如果蓝牙音箱只支持 A2DP 不支持 SCO，又无法进行语音通话。

- A2DP：是一种单向的高品质音频数据传输链路，通常用于播放立体声音乐。
- SCO： 则是一种双向的音频数据的传输链路，该链路只支持 8K 及 16K 单声道的音频数据，只能用于普通语音的传输。
