---
title: 设置音频属性
platform: iOS
updatedAt: 2021-03-11 07:03:37
---
## 功能描述
 在一些比较专业的场景里，用户对声音的效果尤为敏感，比如语音电台，此时就需要对双声道和高音质的支持。
 所谓的高音质指的是我们提供采样率为 48 kHz、码率 192 Kbps 的能力，帮助用户实现高逼真的音乐场景，这种能力在语音电台、唱歌比赛类直播场景中应用较多。

本文指导开发者根据对音质、声道、场景等的不同需求，选择不同的音频属性，获得最佳实时互动效果。
## 实现方法
在设置音频属性前，请确保已在你的项目中实现基本的实时音视频功能。详见快速开始文档：

- iOS: [实现音视频通话](start_call_ios)/[实现互动直播](start_live_ios)
- macOS: [实现音视频通话](start_call_mac)/[实现互动直播](start_live_mac)

Agora SDK 提供 `setAudioProfile` 方法给开发者根据场景需求灵活配置适合的音质属性。

### API 时序图

下图展示使用设置音频属性的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1569472315882)

### 参数搭配
你可以参考下图，根据应用场景对音质、设备的不同需求，选择不同的参数搭配。
<table>
<tr>
<th>参数</th>
<th>场景需求</th>
<th>选项</th>
</tr>
<tr>
<td rowspan="3">profile</td>
<td>高音质</td>
<td><li>MusicHighQuality</li>
	<li>MusicHighQualityStereo</li></td>
</tr>
	<tr>
<!--<td></td>-->
<td>有一定音质要求</td>
<td><li>MusicStandard</li>
	<li>MusicStandardStereo</li></td>
</tr>
		<tr>
<!--<td></td>-->
<td>对音质无要求</td>
<td><li>Default</li>
	<li>SpeechStandard</li></td>
</tr>
<tr>
<td rowspan="8">scenario</td>
	<td>音质/音效优先</td>
<td>GameStreaming</td>
	</tr>
		<tr>
<!--<td></td>-->
	<td>频繁上下麦</td>
<td>ChatRoomEntertainment</td>
</tr>
	<tr>
<!--<td></td>-->
	<td>支持外放设备</td>
<td>ShowRoom</td>
</tr>
		<tr>
<!--<td></td>-->
	<td>开黑少杂音</td>
<td>ChatRoomGaming</td>
</tr>
				<tr>
<!--<td></td>-->
	<td>高流畅度和稳定性</td>
<td>Education</td>
</tr>
			<tr>
<!--<td></td>-->
	<td>使用低功耗 IoT 设备</td>
<td>Iot</td>
</tr>
			<tr>
<!--<td></td>-->
	<td>人声为主的多人会议</td>
<td>Meeting</td>
</tr>
		<tr>
<!--<td></td>-->
	<td>传输质量稳定</td>
<td>Default</td>
</tr>
</table>

也可以根据下表中提供的场景，直接选择参数进行搭配。

| 场景 | profile | scenario | 特性 |
| ---------------- | ---------------- | ---------------- | ---------------- |
| 1 v 1 小班课 | Default | Default | 传输流畅、音质高清，优先保证通话质量 |
| 游戏开黑 | SpeechStandard | ChatRoomGaming | 只保留语音，非语音部分（键盘声、外放音乐等）不会被传输。节省码率的同时减少杂音，适合多人团战 |
| 剧本杀 | MusicStandard | ChatRoomEntertainment | 优秀的音乐编解码技术，提供更为丰富的声音呈现。上下麦没有音量、音质变化 |
| KTV 练歌房 | MusicHighQuality | GameStreaming | 高音质搭配丰富音效，适用于对音质要求高的场景 |
| 语音电台 | MusicHighQualityStereo | ShowRoom | 高音质，立体声，支持专业外放设备 |
| 音乐教学 | MusicStandardStereo | GameStreaming | 优先保证音质。适用于外放音效也能直播出去的场景 |
| 双师课堂 | MusicStandardStereo | ChatRoomEntertainment | 保证音质的同时，呈现更丰富的声音效果。上下麦没有音量、音质变化 |

### 示例代码

```swift
// swift
// 开黑聊天室
agoraKit.setAudioProfile(.speechStandard, scenario: .chatRoomGaming)
// 娱乐聊天室
agoraKit.setAudioProfile(.musicStandard, scenario: .chatRoomEntertainment)
// K 歌房
agoraKit.setAudioProfile(.musicHighQuality, scenario: .chatRoomEntertainment)
// FM 超高音质
agoraKit.setAudioProfile(.musicHighQuality, scenario: .gameStreaming)
```

```objective-c
// objective-c
// 开黑聊天室
[agoraKit setAudioProfile: AgoraAudioProfileSpeechStandard scenario: AgoraAudioScenarioChatRoomGaming];
// 娱乐聊天室
[agoraKit setAudioProfile: AgoraAudioProfilemusicStandard, scenario: AgoraAudioScenarioChatRoomEntertainment];
// K 歌房
[agoraKit setAudioProfile: AgoraAudioProfileMusicHighQuality, scenario: AgoraAudioScenarioChatRoomEntertainment];
// FM 超高音质
[agoraKit setAudioProfile: AgoraAudioProfilemusicHighQuality, scenario: AgoraAudioScenarioGameStreaming]
```

### API 参考

- [`setAudioProfile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioProfile:scenario:)

## 开发注意事项

该方法需要在 [`joinChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) 之前调用。

不同的 Audio scenario 下，设备的系统音量是不同的。

系统音量分通话音量和媒体音量两种：
- 通话音量指的是进行语音、视频通话时的音量。通话音量有较好的回声消除。
- 媒体音量指的是播放音乐、视频或游戏的音效、背景音的音量。媒体音量有较好的声音表现力。

两者的差异在于媒体音量可以调整到 0，而通话音量不可以。

SDK 在 `setAudioProfile` 中提供 6 种不同的 Audio scenario，其中不同的 Audio scenario 使用的音量不同。如果需要将音量调整到 0，建议使用媒体音量控制的 Audio scenario。
<table>
<tr>
<th> Audio scenario</th>
<th>音量</th>
</tr>
<tr>
<td>GameStreaming</td>
<td>媒体音量</td>
</tr>
	<tr>
<td>Default</td>
<td  rowspan="3">	<li>通信场景下，所有用户使用通话音量</li>
	<li>直播场景下，主播及连麦主播使用通话音量，观众使用媒体音量</li></td>
</tr>
		<tr>
<td>Education</td>
<!--<td></td>-->
</tr>
<tr>
<td>ShowRoom</td>
<!--<td></td>-->
	</tr>
		<tr>
<td>ChatRoomEntertainment</td>
	<td>通话音量</td>
</tr>
	<tr>
<td>ChatRoomGaming</td>
	<td>通话音量</td>
</tr>
  <tr>
<td>Iot</td>
	<td>通话音量</td>
</tr>
	<tr>
<td>Meeting</td>
	<td>媒体音量</td>
</tr>
</table>

## 相关链接

设置音频属性过程中，你还可以参考如下文档：

- [如何避免直播上下麦音量变化？](https://docs.agora.io/cn/faq/audio_role)