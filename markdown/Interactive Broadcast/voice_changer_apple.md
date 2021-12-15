---
title: 设置人声效果
platform: iOS
updatedAt: 2021-03-05 04:58:08
---

在社交娱乐应用中，为增加产品的趣味性和互动性，用户常常需要变声和混响效果。Agora 提供多种预置的变声和混响效果，你也可以灵活定制自己想要的声音，比如设置音调、均衡和混响等。

Agora 提供[在线 Demo](https://www.agora.io/cn/audio-demo)，你可以体验变声与混响效果。

#### 语聊美声

语聊美声是指在不改变原声辨识度的前提下，根据男女声各自的特点美化说话声。

通过 `setLocalVoiceChanger` 中以下枚举值，你可以实现语聊美声效果：

| 枚举值                                       | 描述                                                           |
| :------------------------------------------- | :------------------------------------------------------------- |
| `AgoraAudioGeneralBeautyVoiceMaleMagnetic`   | 磁性（男）。请确保使用该枚举美化男声，否则音频可能会产生失真。 |
| `AgoraAudioGeneralBeautyVoiceFemaleFresh`    | 清新（女）。请确保使用该枚举美化女声，否则音频可能会产生失真。 |
| `AgoraAudioGeneralBeautyVoiceFemaleVitality` | 活力（女）。请确保使用该枚举美化女声，否则音频可能会产生失真。 |

```swift
// swift
// 预设人声效果为磁性（男）。
agoraKit.setLocalVoiceChanger(.generalBeautyVoiceMaleMagnetic)
// 关闭人声效果。
agoraKit.setLocalVoiceChanger(.voiceChangerOff)
```

```objective-c
// objective-c
// 预设人声效果为磁性（男）。
[self.agoraKit setLocalVoiceChanger: AgoraAudioGeneralBeautyVoiceMaleMagnetic];
// 关闭人声效果。
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceChangerOff];
```

#### 音色变换

音色变换可以让人声的音色朝特定的方向改变。根据不同的听众或用户声音的特点，用户可以选择最合适自己的效果。

通过 `setLocalVoiceChanger` 中以下枚举值，你可以实现音色变换效果：

| 枚举值                            | 描述   |
| :-------------------------------- | :----- |
| `AgoraAudioVoiceBeautyVigorous`   | 浑厚。 |
| `AgoraAudioVoiceBeautyDeep`       | 低沉。 |
| `AgoraAudioVoiceBeautyMellow`     | 圆润。 |
| `AgoraAudioVoiceBeautyFalsetto`   | 假音。 |
| `AgoraAudioVoiceBeautyFull`       | 饱满。 |
| `AgoraAudioVoiceBeautyClear`      | 清澈。 |
| `AgoraAudioVoiceBeautyResounding` | 高亢。 |
| `AgoraAudioVoiceBeautyRinging`    | 嘹亮。 |

```swift
// swift
// 预设人声效果为浑厚。
agoraKit.setLocalVoiceChanger(.voiceBeautyVigorous)
// 关闭人声效果。
agoraKit.setLocalVoiceChanger(.voiceChangerOff)
```

```objective-c
// objective-c
// 预设人声效果为浑厚。
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceBeautyVigorous];
// 关闭人声效果。
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceChangerOff];
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
		<td><tt>AgoraAudioVoiceChangerOldMan</tt></td>
    <td>老男人，建议用于处理男声。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioVoiceChangerBabyBoy</tt></td>
    <td>小男孩，建议用于处理男声。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioVoiceChangerBabyGirl</tt></td>
    <td>小女孩，建议用于处理女声。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioVoiceChangerZhuBaJie</tt></td>
    <td>猪八戒。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioVoiceChangerHulk</tt></td>
    <td>绿巨人。 </td>
  </tr>
	<tr>
    <td rowspan="2"><tt>setLocalVoiceReverbPreset</tt></td>
		<td><tt>AgoraAudioReverbPresetFxUncle</tt></td>
    <td>大叔，建议用于处理男声。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioReverbPresetFxSister</tt></td>
    <td>少女，建议用于处理女声。</td>
  </tr>
 </table>

```swift
// swift
// 预设人声效果为绿巨人。
agoraKit.setLocalVoiceChanger(.VoiceChangerHulk)
// 关闭人声效果。
agoraKit.setLocalVoiceReverbPreset(.voiceChangerOff)
```

```c++
// objective-c
// 预设人声效果为绿巨人。
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceChangerHulk];
// 关闭人声效果。
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceChangerOff];
```

#### 曲风音效

曲风音效可以在演唱特定风格的歌曲时使歌声与伴奏更加契合。

通过 `setLocalVoiceReverbPreset` 中以下枚举值，你可以实现曲风音效：

<div class="alert note">为达到更好的人声效果，Agora 推荐使用以 <tt>AgoraAudioReverbPresetFx</tt> 为前缀的枚举值。</div>

| 枚举值                            | 描述           |
| :-------------------------------- | :------------- |
| `AgoraAudioReverbPresetPopular`   | 流行（旧版）。 |
| `AgoraAudioReverbPresetRnB`       | R&B（旧版）。  |
| `AgoraAudioReverbPresetRock`      | 摇滚。         |
| `AgoraAudioReverbPresetHipHop`    | 嘻哈。         |
| `AgoraAudioReverbPresetFxPopular` | 流行。         |
| `AgoraAudioReverbPresetFxRNB`     | R&B。          |

```swift
// swift
// 预设人声效果为流行。
agoraKit.setLocalVoiceChanger(.fxPopular)
// 关闭人声效果。
agoraKit.setLocalVoiceReverbPreset(.off)
```

```objective-c
// objective-c
// 预设人声效果为流行。
[self.agoraKit setLocalVoiceReverbPreset: AgoraAudioReverbPresetFxPopular];
// 关闭人声效果。
[self.agoraKit setLocalVoiceReverbPreset: AgoraAudioReverbPresetOff];
```

#### 空间塑造

空间塑造是指通过空间混响效果营造一定的空间氛围，让人声仿佛从特定的场地中传出。

通过 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset` 中以下枚举值，你可以实现空间塑造效果：

<div class="alert note"><li>为达到更好的人声效果，Agora 推荐使用以 <tt>AgoraAudioReverbPresetFx</tt> 为前缀的枚举值。</li><li>Agora 推荐在使用 <tt>AgoraAudioReverbPresetVirtualStereo</tt> 前将 <tt>setAudioProfile</tt> 的 <tt>profile</tt> 参数设置为 <tt>AgoraAudioProfileMusicHighQualityStereo(5)</tt>。</li></div>

<table>
  <tr>
    <th>方法</th>
		<th>枚举值</th>
    <th>描述</th>
  </tr>
  <tr>
    <td rowspan="2"><tt>setLocalVoiceChanger</tt></td>
		<td><tt>AgoraAudioVoiceBeautySpacial</tt></td>
    <td>空旷。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioVoiceChangerEthereal</tt></td>
    <td>空灵。</td>
  </tr>
  <tr>
		<td rowspan="8"><tt>setLocalVoiceReverbPreset</tt></td>
    <td><tt>AgoraAudioReverbPresetVocalConcert</tt></td>
    <td>演唱会（旧版）。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioReverbPresetKTV</tt></td>
    <td>KTV（旧版）。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioReverbPresetStudio</tt></td>
    <td>录音棚（旧版）。 </td>
  </tr>
	<tr>
		<td><tt>AgoraAudioReverbPresetFxKTV</tt></td>
    <td>KTV。</td>
  </tr>
	<tr>
		<td><tt>AgoraAudioReverbPresetFxVocalConcert</tt></td>
    <td>演唱会。</td>
  </tr>
	<tr>
		<td><tt>AgoraAudioReverbPresetFxStudio</tt></td>
    <td>录音棚。</td>
  </tr>
  <tr>
    <td><tt>AgoraAudioReverbPresetFxPhonograph</tt></td>
    <td>留声机。</td>
  </tr>
	<tr>
		<td><tt>AgoraAudioReverbPresetVirtualStereo</tt></td>
		<td>虚拟立体声。虚拟立体声是指将单声道的音轨渲染出立体声的效果，使频道内所有用户听到有空间感的人声效果。</td>
  </tr>
 </table>

```swift
// swift
// 预设人声效果为空旷。
agoraKit.setLocalVoiceChanger(.voiceBeautySpacial)
// 关闭人声效果。
agoraKit.setLocalVoiceReverbPreset(.off)
```

```objective-c
// objective-c
// 预设美音效果为浑厚
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceBeautySpacial];
// 关闭效果
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceChangerOff];
```

### 自定义人声效果

如果预设效果无法满足你的需求，你还可以通过 `setLocalVoicePitch`、`setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 自行调整音调、均衡和混响效果，获取想要的人声效果。

以下示例代码展示如何把原始人声变成绿巨人霍克的声音：

```swift
// swift
// 设置音调。可以在 [0.5, 2.0] 范围内设置。取值越小，则音调越低。默认值为 1.0，表示不需要修改音调。
agoraKit.setLocalVoicePitch(1)

// 设置本地人声均衡波段的中心频率
// 第 1 个参数为频谱子带索引，取值范围 [0,9]，分别代表 10 个频带，对应的中心频率是 [31,62,125,250,500,1000,2000,4000,8000,16000] Hz
// 第 2 个参数为每个频率区间的增益值，取值范围 [-15,15]，单位 dB, 默认值为 0
agoraKit.setLocalVoiceEqualizationOf(.band31, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band62, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band125, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band250, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band500, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band1K, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band2K, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band4K, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band8K, withGain: 0)
agoraKit.setLocalVoiceEqualizationOf(.band16K, withGain: 0)

// 原始人声强度，即所谓的 dry signal，取值范围 [-20,10]，单位为 dB
agoraKit.setLocalVoiceReverbOf(.dryLevel, withValue: -1)

// 早期反射信号强度，即所谓的 wet signal，取值范围 [-20,10]，单位为 dB
agoraKit.setLocalVoiceReverbOf(.wetLevel, withValue: -7)

// 所需混响效果的房间尺寸，一般房间越大，混响效果越强。取值范围 [0,100]
agoraKit.setLocalVoiceReverbOf(.roomSize, withValue: 57)

// Wet signal 的初始延迟长度，取值范围 [0,200]，单位为 ms
agoraKit.setLocalVoiceReverbOf(.wetDelay, withValue: 135)

// 混响效果持续的强度，取值范围为 [0,100]，值越大，混响效果越强
agoraKit.setLocalVoiceReverbOf(.strength, withValue: 45)
```

```objective-c
// objective-c
// 设置音调。可以在 [0.5, 2.0] 范围内设置。取值越小，则音调越低。默认值为 1.0，表示不需要修改音调。
[agoraKit setLocalVoicePitch: 1];

// 设置本地人声均衡波段的中心频率
// 第 1 个参数为频谱子带索引，取值范围 [0,9]，分别代表 10 个频带，对应的中心频率是 [31,62,125,250,500,1000,2000,4000,8000,16000] Hz
// 第 2 个参数为每个频率区间的增益值，取值范围 [-15,15]，单位 dB, 默认值为 0
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand31 withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand62 withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand125 withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand250 withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand500 withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand1K withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand2K withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand4K withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand8K withGain: 0];
[agoraKit setLocalVoiceEqualizationOfBandFrequency:AgoraAudioEqualizationBand16K withGain: 0];

// 原始人声强度，即所谓的 dry signal，取值范围 [-20,10]，单位为 dB
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbDryLevel withValue: -1];

// 早期反射信号强度，即所谓的 wet signal，取值范围 [-20,10]，单位为 dB
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbWetLevel withValue: -7];

// 所需混响效果的房间尺寸，一般房间越大，混响效果越强。取值范围 [0,100]
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbRoomSize withValue: 57];

// Wet signal 的初始延迟长度，取值范围 [0,200]，单位为 ms
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbWetDelay withValue: 135];

// 混响效果持续的强度，取值范围为 [0,100]，值越大，混响效果越强
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbStrength withValue: 45];
```

## API 参考

**预设的人声效果：**

- [`setLocalVoiceChanger`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:)
- [`setLocalVoiceReverbPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:)

**自定义人声效果：**

- [`setLocalVoicePitch`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoicePitch:)
- [`setLocalVoiceEqualizationOfBandFrequency`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceEqualizationOfBandFrequency:withGain:)
- [`setLocalVoiceReverbOfType`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbOfType:withValue:)

## 开发注意事项

- 本文所有方法对人声的处理效果最佳，Agora 不推荐调用这类方法处理含音乐的音频数据。
- Agora 建议不要一起使用预设的人声效果和自定义人声效果相关方法，否则可能会发生未定义行为。如需一起使用，你需要在调用预设人声效果相关方法后调用自定义人声效果相关方法，否则自定义人声效果相关方法会不生效。
