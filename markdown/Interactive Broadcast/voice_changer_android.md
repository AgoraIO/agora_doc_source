---
title: 设置人声效果
platform: Android
updatedAt: 2021-03-05 04:57:55
---

在社交娱乐应用中，为增加产品的趣味性和互动性，用户常常需要变声和混响效果。Agora 提供多种预置的变声和混响效果，你也可以灵活定制自己想要的声音，比如设置音调、均衡和混响等。

Agora 提供[在线 Demo](https://www.agora.io/cn/audio-demo)，你可以体验变声与混响效果。

#### 语聊美声

语聊美声是指在不改变原声辨识度的前提下，根据男女声各自的特点美化说话声。

通过 `setLocalVoiceChanger` 中以下枚举值，你可以实现语聊美声效果：

| 枚举值                                 | 描述                                                           |
| :------------------------------------- | :------------------------------------------------------------- |
| `GENERAL_BEAUTY_VOICE_MALE_MAGNETIC`   | 磁性（男）。请确保使用该枚举美化男声，否则音频可能会产生失真。 |
| `GENERAL_BEAUTY_VOICE_FEMALE_FRESH`    | 清新（女）。请确保使用该枚举美化女声，否则音频可能会产生失真。 |
| `GENERAL_BEAUTY_VOICE_FEMALE_VITALITY` | 活力（女）。请确保使用该枚举美化女声，否则音频可能会产生失真。 |

```java
VOICE_CHANGER_PRESET voiceChanger;
// 预设人声效果为磁性（男）。
voiceChanger = GENERAL_BEAUTY_VOICE_MALE_MAGNETIC;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// 关闭人声效果。
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

#### 音色变换

音色变换可以让人声的音色朝特定的方向改变。根据不同的听众或用户声音的特点，用户可以选择最合适自己的效果。

通过 `setLocalVoiceChanger` 中以下枚举值，你可以实现音色变换效果：

| 枚举值                    | 描述   |
| :------------------------ | :----- |
| `VOICE_BEAUTY_VIGOROUS`   | 浑厚。 |
| `VOICE_BEAUTY_DEEP`       | 低沉。 |
| `VOICE_BEAUTY_MELLOW`     | 圆润。 |
| `VOICE_BEAUTY_FALSETTO`   | 假音。 |
| `VOICE_BEAUTY_FULL`       | 饱满。 |
| `VOICE_BEAUTY_CLEAR`      | 清澈。 |
| `VOICE_BEAUTY_RESOUNDING` | 高亢。 |
| `VOICE_BEAUTY_RINGING`    | 嘹亮。 |

```java
VOICE_CHANGER_PRESET voiceChanger;
// 预设人声效果为浑厚。
voiceChanger = VOICE_BEAUTY_VIGOROUS;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// 关闭人声效果。
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

#### 变声音效

变声音效是指将说话声朝着特定的方向进行调整，以达到区别原声的效果。

通过 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset` 中以下枚举值，你可以实现变声音效：

<table>
  <tr>
    <th>方法</th>
		<th>枚举值</th>
    <th>描述</th>
  </tr>
  <tr>
    <td rowspan="5"><tt>setLocalVoiceChanger</tt></td>
		<td><tt>VOICE_CHANGER_OLDMAN</tt></td>
    <td>老男人，建议用于处理男声。</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_BABYBOY</tt></td>
    <td>小男孩，建议用于处理男声。</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_BABYGIRL</tt></td>
    <td>小女孩，建议用于处理女声。</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_ZHUBAJIE</tt></td>
    <td>猪八戒。</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_HULK</tt></td>
    <td>绿巨人。 </td>
  </tr>
	<tr>
    <td rowspan="2"><tt>setLocalVoiceReverbPreset</tt></td>
		<td><tt>AUDIO_REVERB_FX_UNCLE</tt></td>
    <td>大叔，建议用于处理男声。</td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_FX_SISTER</tt></td>
    <td>少女，建议用于处理女声。</td>
  </tr>
 </table>

```java
VOICE_CHANGER_PRESET voiceChanger;
// 预设人声效果为绿巨人。
voiceChanger = VOICE_CHANGER_HULK;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// 关闭人声效果。
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

```java
AUDIO_REVERB_PRESET reverbPreset;
// 预设人声效果为大叔。
reverbPreset = AUDIO_REVERB_FX_UNCLE;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
// 关闭人声效果。
reverbPreset = AUDIO_REVERB_OFF;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
```

#### 曲风音效

曲风音效可以在演唱特定风格的歌曲时使歌声与伴奏更加契合。

通过 `setLocalVoiceReverbPreset` 中以下枚举值，你可以实现曲风音效：

<div class="alert note">为达到更好的人声效果，Agora 推荐使用以 <tt>AUDIO_REVERB_FX</tt> 为前缀的枚举值。</div>

| 枚举值                    | 描述           |
| :------------------------ | :------------- |
| `AUDIO_REVERB_POPULAR`    | 流行（旧版）。 |
| `AUDIO_REVERB_RNB`        | R&B（旧版）。  |
| `AUDIO_REVERB_ROCK`       | 摇滚。         |
| `AUDIO_REVERB_HIPHOP`     | 嘻哈。         |
| `AUDIO_REVERB_FX_POPULAR` | 流行。         |
| `AUDIO_REVERB_FX_RNB`     | R&B。          |

```java
AUDIO_REVERB_PRESET reverbPreset;
// 预设人声效果为流行。
reverbPreset = AUDIO_REVERB_FX_POPULAR;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
// 关闭人声效果。
reverbPreset = AUDIO_REVERB_OFF;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
```

#### 空间塑造

空间塑造是指通过空间混响效果营造一定的空间氛围，让人声仿佛从特定的场地中传出。

通过 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset` 中以下枚举值，你可以实现空间塑造效果：

<div class="alert note">为达到更好的人声效果，Agora 推荐使用以 <tt>AUDIO_REVERB_FX</tt> 为前缀的枚举值。</div>

<table>
  <tr>
    <th>方法</th>
		<th>枚举值</th>
    <th>描述</th>
  </tr>
  <tr>
    <td rowspan="2"><tt>setLocalVoiceChanger</tt></td>
		<td><tt>VOICE_BEAUTY_SPACIAL</tt></td>
    <td>空旷。</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_ETHEREAL</tt></td>
    <td>空灵。</td>
  </tr>
  <tr>
		<td rowspan="8"><tt>setLocalVoiceReverbPreset</tt></td>
    <td><tt>AUDIO_REVERB_VOCAL_CONCERT</tt></td>
    <td>演唱会（旧版）。</td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_KTV</tt></td>
    <td>KTV（旧版）。</td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_STUDIO</tt></td>
    <td>录音棚（旧版）。 </td>
  </tr>
	<tr>
		<td><tt>AUDIO_REVERB_FX_KTV</tt></td>
    <td>KTV。</td>
  </tr>
	<tr>
		<td><tt>AUDIO_REVERB_FX_VOCAL_CONCERT</tt></td>
    <td>演唱会。</td>
  </tr>
	<tr>
		<td><tt>AUDIO_REVERB_FX_STUDIO</tt></td>
    <td>录音棚。</td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_FX_PHONOGRAPH</tt></td>
    <td>留声机。</td>
  </tr>
	<tr>
		<td><tt>AUDIO_VIRTUAL_STEREO</tt></td>
		<td>虚拟立体声。虚拟立体声是指将单声道<p>的音轨渲染出立体声的效果。</p><p><b>Note</b></p><p>Agora 推荐在调用该方法前将 <p><tt>setAudioProfile</tt> 的 <tt>profile</tt> </p><p>参数设置为 </p><p><tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>。</p></td>
  </tr>
 </table>

```java
VOICE_CHANGER_PRESET voiceChanger;
// 预设人声效果为空旷。
voiceChanger = VOICE_BEAUTY_SPACIAL;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// 关闭人声效果。
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

```java
AUDIO_REVERB_PRESET reverbPreset;
// 预设人声效果为演唱会。
reverbPreset = AUDIO_REVERB_FX_VOCAL_CONCERT;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
// 关闭人声效果。
reverbPreset = AUDIO_REVERB_OFF;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
```

### 自定义人声效果

如果预设效果无法满足你的需求，你还可以通过 `setLocalVoicePitch`、`setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 自行调整音调、均衡和混响效果，获取想要的人声效果。

以下示例代码展示如何把原始人声变成绿巨人霍克的声音：

```java
// 设置音调。可以在 [0.5,2.0] 范围内设置。取值越小，则音调越低。默认值为 1.0，表示原始音调
double pitch = 0.5;
rtcEngine.setLocalVoicePitch(pitch);

// 设置本地人声均衡波段的中心频率
// 第 1 个参数为频谱子带索引，取值范围 [0,9]，分别代表 10 个频带，对应的中心频率是 [31,62,125,250,500,1000,2000,4000,8000,16000] Hz
// 第 2 个参数为每个频率区间的增益值，取值范围 [-15,15]，单位 dB, 默认值为 0
rtcEngine.setLocalVoiceEqualization(0, -15);
rtcEngine.setLocalVoiceEqualization(1, 3);
rtcEngine.setLocalVoiceEqualization(2, -9);
rtcEngine.setLocalVoiceEqualization(3, -8);
rtcEngine.setLocalVoiceEqualization(4, -6);
rtcEngine.setLocalVoiceEqualization(5, -4);
rtcEngine.setLocalVoiceEqualization(6, -3);
rtcEngine.setLocalVoiceEqualization(7, -2);
rtcEngine.setLocalVoiceEqualization(8, -1);
rtcEngine.setLocalVoiceEqualization(9, 1);

// 原始人声强度，即所谓的 dry signal，取值范围 [-20,10]，单位为 dB
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_DRY_LEVEL, 10);

// 早期反射信号强度，即所谓的 wet signal，取值范围 [-20,10]，单位为 dB
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_WET_LEVEL, 7);

// 所需混响效果的房间尺寸，一般房间越大，混响效果越强。取值范围 [0,100]
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_ROOM_SIZE, 6);

// Wet signal 的初始延迟长度，取值范围 [0,200]，单位为 ms
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_WET_DELAY, 124);

// 混响效果持续的强度，取值范围为 [0,100]，值越大，混响效果越强
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_STRENGTH, 78);
```

## API 参考

**预设的人声效果：**

- [`setLocalVoiceChanger`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ade6883c7878b7a596d5b2563462597dd)
- [`setLocalVoiceReverbPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a10dd25bc8e129512cd6727133b7fc42f)

**自定义人声效果：**

- [`setLocalVoicePitch`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a41b525f9cbf2911594bcda9b20a728c9)
- [`setLocalVoiceEqualization`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9e3aa79f0d6d8f2ea81907543506d960)
- [`setLocalVoiceReverb`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4afc32ba68e997e90ba3f128317827fa)

## 开发注意事项

- 本文所有方法对人声的处理效果最佳，Agora 不推荐调用这类方法处理含音乐的音频数据。
- Agora 建议不要一起使用预设的人声效果和自定义人声效果相关方法，否则可能会发生未定义行为。如需一起使用，你需要在调用预设人声效果相关方法后调用自定义人声效果相关方法，否则自定义人声效果相关方法会不生效。
