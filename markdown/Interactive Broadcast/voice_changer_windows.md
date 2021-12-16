---
title: 设置人声效果
platform: Windows
updatedAt: 2021-03-05 04:58:20
---
## 功能描述

## 功能描述

在社交娱乐应用中，为增添场景的趣味性并提升互动体验，通常需要设置人声效果。例如在语聊房场景中，用户可以选择音效来增添自己声音的立体感。Agora RTC SDK 提供预设的人声效果，也支持通过音调、声音均衡和混响等设置自定义人声效果。你可以通过 Agora 提供的[在线 Demo](https://www.agora.io/cn/audio-demo) 体验 SDK 预设的人声效果。

## 示例项目

<% 
if (os == "android") { %>
Agora 在 GitHub 上提供实现了美声与音效功能的开源示例项目 [VoiceEffects.java](https://github.com/AgoraIO/API-Examples/tree/master/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/VoiceEffects.java)，你可以前往下载体验或参考源代码。
<% }

if (os == "windows") { %>
Agora 在 GitHub 上提供实现了美声与音效功能的开源示例项目 [BeautyAudio](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/BeautyAudio)，你可以前往下载体验或参考源代码。
<% }

if (os == "apple") { %>
Agora 在 GitHub 上提供以下实现了美声与音效功能的开源示例项目，你可以前往下载体验或参考源代码。

- iOS：[VoiceChanger](https://github.com/AgoraIO/API-Examples/tree/master/iOS/APIExample/Examples/Advanced/VoiceChanger)
- macOS：[VoiceChanger](https://github.com/AgoraIO/API-Examples/tree/master/macOS/APIExample/Examples/Advanced/VoiceChanger)
<% }
%>

## 使用预设的人声效果

为满足不同场景对人声效果的需求，SDK 提供 `setVoiceBeautifierPreset` 和 `setAudioEffectPreset` 方法，你可以使用以下预设的人声效果：

<table>
  <tr>
    <th colspan="2">人声效果</th>
    <th>适用场景</th>
  </tr>
  <tr>
    <td rowspan="3">美声<p><tt>setVoiceBeautifierPreset</tt></p></td>
    <td>语聊美声</td>
    <td>以说话声为主的音视频场景：<li>语音相亲</li><li>情感电台</li><li>语音连麦直播</li><li>语音 PK 直播</li><li>语聊房</li><li>开黑语音</li></td>
  </tr>
  <tr>
    <td>歌唱美声</td>
    <td>以歌声为主的音视频场景：<li>K 歌房</li><li>音乐电台</li><li>直播秀场</li></td>
  </tr>
  <tr>
    <td>音色变换</td>
    <td>以说话声或歌声为主的音视频场景：<li>语音连麦直播</li><li>语音 PK 直播</li><li>语聊房</li><li>开黑语音</li><li>语音相亲</li><li>K 歌房</li><li>FM 电台</li></td>
  </tr>
  <tr>
    <td rowspan="4">音效<p><tt>setAudioEffectPreset</tt></p></td>
    <td>变声音效</td>
    <td>以说话声为主的音视频场景：<li>语音连麦直播</li><li>语音 PK 直播</li><li>语聊房</li><li>开黑语音</li></td>
  </tr>
  <tr>
    <td>曲风音效</td>
    <td>以歌声为主的音视频场景：<li>K 歌房</li><li>音乐电台</li><li>直播秀场</li></td>
  </tr>
  <tr>
    <td>空间塑造</td>
    <td>以说话声或歌声为主的音视频场景：<li>语音连麦直播</li><li>语音 PK 直播</li><li>语聊房</li><li>开黑语音</li><li>语音相亲</li><li>K 歌房</li><li>FM 电台</li></td>
  </tr>
  <tr>
    <td>电音音效</td>
    <td>以歌声为主的音视频场景：<li>K 歌房</li><li>音乐电台</li><li>直播秀场</li></td>
  </tr>
	<tr>
    <td>变声<p><tt>setVoiceConversionPreset</tt></p></td>
    <td>基础变声</td>
    <td>以说话声或歌声为主的音视频场景：<li>语音连麦直播</li><li>语音 PK 直播</li><li>语聊房</li><li>开黑语音</li><li>语音相亲</li><li>K 歌房</li><li>FM 电台</li></td>
  </tr>
	
 </table>

## 实现方法

开始前请确保已在你的项目中实现基本的实时音视频功能。 详见[开始音视频通话](start_call_windows)或[开始互动直播](start_live_windows)。

### 使用预置效果

通过 `setLocalVoiceChanger` 可以选择以下预设的语音变声效果：

- 老男孩
- 小男孩
- 小女孩
- 猪八戒
- 空灵
- 绿巨人

通过 `setLocalVoiceReverbPreset` 可以选择以下预设的语音混响效果：

- 流行
- R&B
- 摇滚
- 嘻哈
- 演唱会
- KTV
- 录音棚

```c++
VOICE_CHANGER_PRESET voiceChanger;
AUDIO_REVERB_PRESET reverbPreset;

// 设置变声效果为老男孩
voiceChanger = VOICE_CHANGER_OLDMAN;
rtcEngine.setLocalVoiceChanger(voiceChanger);

// 关闭变声效果
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);

// 设置混响效果为流行
reverbPreset = AUDIO_REVERB_POPULAR;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);

// 关闭混响效果
reverbPreset = AUDIO_REVERB_OFF;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
```

### 定制变声和混响效果

如果预置效果无法满足你的需求，你也可以自行调整音调、均衡和混响设置。

你可以根据以下方法把原始声音变成绿巨人霍克的声音。

```c++
// 设置音调。可以在 [0.5, 2.0] 范围内设置。取值越小，则音调越低。默认值为 1.0，表示不需要修改音调。
int nRet = rtcEngine.setLocalVoicePitch(0.5);

// 设置本地语音均衡波段的中心频率
// 第 1 个参数为频谱子带索引，取值范围 [0, 9]，分别代表 10 个频带，对应的中心频率是 [31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, 16k] Hz
// 第 2 个参数为每个频率区间的增益值，取值范围 [-15, 15]，单位 dB, 默认值为 0
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_31, -15);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_62, 3);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_125, -9);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_250, -8);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_500, -6);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_1K, -4);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_2K, -3);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_4K, -2);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_8K, -1);
nRet = rtcEngine.setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_16K, 1);

// 原始声音强度，即所谓的 dry signal，取值范围 [-20, 10]，单位为 dB
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_DRY_LEVEL, 10);

// 早期反射信号强度，即所谓的 wet signal，取值范围 [-20, 10]，单位为 dB
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_WET_LEVEL, 7);

// 所需混响效果的房间尺寸，一般房间越大，混响越强，取值范围 [0, 100]
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_ROOM_SIZE, 6);

// Wet signal 的初始延迟长度，取值范围 [0, 200]，单位为 ms
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_WET_DELAY, 124);

// 混响持续的强度，取值范围为 [0, 100]，值越大，混响越强
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_STRENGTH, 78);
```

### API 参考

- [`setLocalVoiceChanger`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a99dc3d74202422436d40f6d7aa6e99dc)
- [`setLocalVoiceReverbPreset`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a51a429a5a848b2ad591220aa6c24a898)
- [`setLocalVoicePitch`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a43616f919e0906279dff5648830ce31a)
- [`setLocalVoiceEqualization`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a8c75994eb06ab26a1704715ec76e0189)
- [`setLocalVoiceReverb`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a4d1d1309f97f3c430a1aa2d060bb7316)

## 开发注意事项

以上方法都有返回值，返回值小于 0 表示方法调用失败。