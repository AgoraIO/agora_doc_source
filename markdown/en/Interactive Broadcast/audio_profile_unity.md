---
title: Set the Audio Profile
platform: Unity
updatedAt: 2021-03-11 07:13:09
---
## Introduction 

High-fidelity audio is essential for professional audio scenarios, such as for podcasts and singing competitions. For example, podcasts require stereo and high-fidelity audio. High-fidelity audio refers to an audio profile with a sample rate of 48 kHz and a bitrate of 192 Kbps.


To obtain high-fidelity audio during real-time communications, you can choose the appropriate audio profile based on the audio quality, channel, and scenario.

## Implementation

Before setting the audio profile, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](start_call_audio_unity) or [Start Live Interactive Streaming](start_live_audio_unity).

The Agora SDK provides the `SetAudioProfile` method to set the appropriate audio profile according to the scenario. This method has two parameters:
<table>
<tr>
<th>Parameters</th>
<th>Description</th>
</tr>
<tr>
<td>audioProfile</td>
<td>Sets the sample rate, bitrate, encoding mode, and the number of channels.
	<li>AUDIO_PROFILE_DEFAULT(0): The default audio profile. <ul><ul><li>In the Communication profile:<ul><li>Windows: A sample rate of 16 KHz, audio encoding, mono, and a bitrate of up to 16 Kbps.<li>Android/iOS/macOS: A sample rate of 32 KHz, audio encoding, mono, and a bitrate of up to 18 Kbps.</ul> <li>In the Live-broadcast profile: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 52 Kbps..</li></ul></ul>
	<li>AUDIO_PROFILE_SPEECH_STANDARD(1): A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.</li>
	<li>AUDIO_PROFILE_MUSIC_STANDARD(2): A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.</li>
	<li>AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3): A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 56 Kbps.</li>
	<li>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4): A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.</li>
	<li>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5): A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.</li>
	</td>
</tr>
<tr>
<td>scenario</td>
<td>Sets the audio scenario. For example, entertainment, education, or live gaming. The Agora SDK optimizes the noise control and audio quality based on the scenarios.
 <li>AUDIO_SCENARIO_DEFAULT(0): The default scenario.</li>
 <li>AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT(1): The entertainment scenario, supporting voice during gameplay.</li>
 <li>AUDIO_SCENARIO_EDUCATION(2): The education scenario, prioritizing smoothness and stability.</li>
 <li>AUDIO_SCENARIO_GAME_STREAMING(3): The live gaming scenario, enabling the gaming audio effects in the speaker mode in an interactive live streaming scenario. Choose this scenario for high-fidelity music playback.</li>
 <li>AUDIO_SCENARIO_SHOWROOM(4): The showroom scenario, optimizing the audio quality with external professional equipment.</li>
 <li>AUDIO_SCENARIO_CHATROOM_GAMING(5): The gaming scenario.</li>
	</td>
</tr>
</table>

### API call sequence

The following diagram shows how to set the audio profile:
![](https://web-cdn.agora.io/docs-files/1585557119461)

### Parameters and applications

You can set the profile and scenario parameters based on the requirements of different applications, such as the audio quality and the audio player.

<table>
<tr>
<th>Parameters</th>
<th>Applications</th>
<th>Options</th>
</tr>
<tr>
<td rowspan="3">audioProfile</td>
<td>High-fidelity audio</td>
<td><li>MUSIC_HIGH_QUALITY</li>
	<li>MUSIC_HIGH_QUALITY_STEREO</li></td>
</tr>
	<tr>
<!--<td></td>-->
<td>Standard audio</td>
<td><li>MUSIC_STANDARD</li>
	<li>MUSIC_STANDARD_STEREO</li></td>
</tr>
		<tr>
<!--<td></td>-->
<td>No requirement for audio quality</td>
<td><li>DEFAULT</li>
	<li>SPEECH_STANDARD</li></td>
</tr>
<tr>
<td rowspan="5">scenario</td>
	<td>Prioritize the audio quality and effects</td>
<td>GAME_STREAMING</td>
	</tr>
		<tr>
<!--<td></td>-->
	<td>Frequently mute/unmute the microphone</td>
<td>CHATROOM_ENTERTAINMENT</td>
</tr>
	<tr>
<!--<td></td>-->
	<td>External audio player</td>
<td>SHOWROOM</td>
</tr>
		<tr>
<!--<td></td>-->
	<td>Gaming noise reduction</td>
<td>CHATROOM_GAMING</td>
</tr>
		<tr>
<!--<td></td>-->
	<td>Stable transmission quality</td>
<td>DEFAULT</td>
</tr>
</table>

You can also set the profile and scenario parameters based on different applications.

| Applications | profile | scenario | Features |
| ---------------- | ---------------- | ---------------- | ---------------- |
| One-to-one classroom | DEFAULT | DEFAULT | Prioritizes the call quality with smooth transmission and high-fidelity audio. |
| Battle royale game | SPEECH_STANDARD | CHATROOM_GAMING | Noise reduction and transmits the voice only. Reduces the transmission rate and suitable for multiplayer games. |
| Murder mystery game | MUSIC_STANDARD | CHATROOM_<br/>ENTERTAINMENT | High-fidelity audio encoding and decoding. No volume or audio quality change when you mute/unmute the microphone. |
| KTV | MUSIC_HIGH_<br/>QUALITY | GAME_STREAMING | High-fidelity audio and effects. Adapts to the high-fidelity audio application. |
| Podcast | MUSIC_HIGH_<br/>QUALITY_STEREO | SHOWROOM | High-fidelity audio and stereo panning. Support for professional audio hardware. |
| Music education | MUSIC_STANDARD_<br/>STEREO | GAME_STREAMING | Prioritizes audio quality. Suitable for transmitting live external audio effects. |
| Collaborative teaching | MUSIC_STANDARD_<br/>STEREO | CHATROOM_<br/>ENTERTAINMENT | High-fidelity audio and effects. No volume or audio quality change when you mute/unmute the microphone. |

### Sample code

```C#
// FM high-fidelity
mRtcEngine.SetAudioProfile(AUDIO_PROFILE_TYPE.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO, AUDIO_SCENARIO_TYPE.AUDIO_SCENARIO_SHOWROOM);

// Gaming
mRtcEngine.SetAudioProfile(AUDIO_PROFILE_TYPE.AUDIO_PROFILE_SPEECH_STANDARD, AUDIO_SCENARIO_TYPE.AUDIO_SCENARIO_CHATROOM_GAMING);

// Entertainment
mRtcEngine.SetAudioProfile(AUDIO_PROFILE_TYPE.AUDIO_PROFILE_MUSIC_STANDARD, AUDIO_SCENARIO_TYPE.AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT);

// KTV
mRtcEngine.SetAudioProfile(AUDIO_PROFILE_TYPE.AUDIO_PROFILE_MUSIC_HIGH_QUALITY, AUDIO_SCENARIO_TYPE.AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT);
```

### API reference

- [`SetAudioProfile`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#adc5817c5d668f631123a643817cf3059)

## Considerations

Call this method before calling the [`JoinChannelByKey`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a5997a90398afe355d4d509a2a83a9999) method.

When you set the volume of a device, you can set either the in-call volume or the media volume.
- You can set the in-call volume during an audio or video call.
- You can set the media volume when you play video, games, or background music.

The differences between the two types of volumes are as follows:
- The in-call volume features acoustic echo cancellation, and should always be set above 0.
- The media volume features a higher audio quality, and can be set as 0.

The audio scenarios in the `SetAudioProfile` method use different volume settings.

<table>
<tr>
<th> Audio scenario</th>
<th>Volume setting</th>
</tr>
<tr>
<td>GAME_STREAMING</td>
<td>All users use the media volume.</td>
</tr>
	<tr>
<td>DEFAULT</td>
<td  rowspan="3">	<li>In the Communication profile, all users use the in-call volume.</li>
	<li>In the Live-broadcast profile, the hosts use the in-call volume, while the audience use the media volume.</li></td>
</tr>
		<tr>
<td>EDUCATION</td>
<!--<td></td>-->
</tr>
<tr>
<td>SHOWROOM</td>
<!--<td></td>-->
	</tr>
		<tr>
<td>CHATROOM_ENTERTAINMENT</td>
	<td>All users use the in-call volume.</td>
</tr>
	<tr>
<td>CHATROOM_GAMING</td>
	<td>All users use the in-call volume.</td>
</tr>
</table>

Given the system restrictions, the media volume can be set as 0, but not the in-call volume. Therefore, if you want to adjust the volume to 0, ensure that you set an audio scenario that uses the media volume.
