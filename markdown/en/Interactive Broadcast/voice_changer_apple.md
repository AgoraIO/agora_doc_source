---
title: Set the Voice Effect
platform: iOS
updatedAt: 2021-03-05 04:56:53
---
## Introduction

In social and entertainment scenarios, users often want various voice effects to improve their interactive experiences. For example, in chat rooms, a user can select a voice effect to add a virtual stereo effect to their voice.

To accomplish this, Agora RTC SDK provides preset voice effects. You can also dynamically change the users' voices, such as adjusting the pitch, setting the equalization, and reverberation modes. Try out the preset voice effects on the [online Demo](https://www.agora.io/en/audio-demo) provided by Agora.

## Sample project


Agora provides the following open-source sample projects that implement the voice beautifier and audio effects functions on GitHub. You can download them to try out this function and view the source code.

- iOS: [VoiceChanger](https://github.com/AgoraIO/API-Examples/tree/master/iOS/APIExample/Examples/Advanced/VoiceChanger)
- macOS: [VoiceChanger](https://github.com/AgoraIO/API-Examples/tree/master/macOS/APIExample/Examples/Advanced/VoiceChanger)


## Implementation

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project.

### Use preset voice effects

To meet the requirements for voice effects in different scenarios, Agora provides `setVoiceBeautifierPreset` and `setAudioEffectPreset`. You can use the following SDK preset voice effects:

<table>
  <tr>
    <th colspan="2">Category</th>
    <th>Scenario</th>
  </tr>
  <tr>
    <td rowspan="3">Voice beautifier<p><tt>setVoiceBeautifierPreset</tt></p></td>
    <td>Chat beautifier</td>
    <td>Audio and video scenarios focusing on a user’s speaking voice:<li>Blind date</li><li>Emotional radio</li><li>Co-host audio streaming</li><li>Voice-only PK Hosting</li><li>Gaming chatroom</li></td>
  </tr>
	  <tr>
    <td>Singing beautifier</td>
    <td>Audio and video scenarios focusing on a user’s singing voice:<li>Online KTV</li><li>Music radio</li><li>Live-streaming showroom</li></td>
  </tr>
  <tr>
    <td>Timbre transformation</td>
    <td>Audio and video scenarios focusing on a user’s speaking voice or singing voice:<li>Co-host audio streaming</li><li>Voice PK hosting</li><li>Gaming chatroom</li><li>Blind date</li><li>Online KTV</li><li>FM radio</li></td>
  </tr>
  <tr>
    <td rowspan="4">Audio effect<p><tt>setAudioEffectPreset</tt></p></td>
    <td>Voice changer effect</td>
    <td>Audio and video scenarios focusing on a user’s speaking voice:<li>Co-host audio streaming</li><li>Voice-only PK Hosting</li><li>Gaming chatroom</li></td>
  </tr>
  <tr>
    <td>Style transformation</td>
    <td>Audio and video scenarios focusing on a user’s singing voice:<li>Online KTV</li><li>Music radio</li><li>Live-streaming showroom</li></td>
  </tr>
  <tr>
    <td>Room acoustics</td>
    <td>Audio and video scenarios focusing on a user’s speaking voice or singing voice:<li>Co-host audio streaming</li><li>Voice PK hosting</li><li>Gaming chatroom</li><li>Blind date</li><li>Online KTV</li><li>FM radio</li></td>
  </tr>
  <tr>
    <td>Pitch correction</td>
    <td>Audio and video scenarios focusing on a user’s singing voice:<li>Online KTV</li><li>Music radio</li><li>Live-streaming showroom</li></td>
  </tr>
 </table>

#### Chat beautifier

Chat beautifier refers to beautifying the characteristics of male or female voices without altering the original voice beyond recognition.

You can implement the chat beautifier by the enumerations in `setVoiceBeautifierPreset` as follows:

| Enumeration                | Description                                                  |
| :------------------------- | :----------------------------------------------------------- |
| `AgoraChatBeautifierMagnetic` | (For male-sounding voice only) A more magnetic voice. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion. |
| `AgoraChatBeautifierFresh`    | (For female-sounding voice only) A fresher voice. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion. |
| `AgoraChatBeautifierVitality` | (For female-sounding voice only) A more vital voice. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion. |

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>setAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AgoraAudioProfileMusicHighQuality(4)</tt> or <tt>AgoraAudioProfileMusicHighQualityStereo(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AgoraAudioScenarioGameStreaming(3)</tt> before setting this enumerator.</div>

```swift
// Beautifies the local voice by making it sound more magnetic (for male only).
agoraKit.setVoiceBeautifierPreset(.chatBeautifierMagnetic)
// Disables voice effects.
agoraKit.setVoiceBeautifierPreset(.voiceBeautifierOff)
```

```objective-c
// Beautifies the local voice by making it sound more magnetic (for male only).
[self.agoraKit setVoiceBeautifierPreset: AgoraChatBeautifierMagnetic];
// Disables voice effects.
[self.agoraKit setVoiceBeautifierPreset: AgoraVoiceBeautifierOff];
```

#### Timbre transformation

Timbre transformation changes the timbre of a voice in a specific way. Users can choose the most appropriate effect for their voice.

You can implement the timbre transformation by the enumerations in `setVoiceBeautifierPreset` as follows:

| Enumeration                        | Description              |
| :--------------------------------- | :----------------------- |
| `AgoraTimbreTransformationVigorous`   | A more vigorous voice.   |
| `AgoraTimbreTransformationDeep`       | A deeper voice.          |
| `AgoraTimbreTransformationMellow`     | A mellower voice.        |
| `AgoraTimbreTransformationFalsetto`   | A falsetto voice.        |
| `AgoraTimbreTransformationFull`       | A fuller voice.          |
| `AgoraTimbreTransformationClear`      | A clearer voice.         |
| `AgoraTimbreTransformationResounding` | A more resounding voice. |
| `AgoraTimbreTransformationRinging`    | A more ringing voice.    |

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>setAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AgoraAudioProfileMusicHighQuality(4)</tt> or <tt>AgoraAudioProfileMusicHighQualityStereo(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AgoraAudioScenarioGameStreaming(3)</tt> before setting this enumerator.</div>

```swift
// Beautifies the local voice by making it sound more vigorous.
agoraKit.setVoiceBeautifierPreset(.timbreTransformationVigorous)
// Disables voice effects.
agoraKit.setVoiceBeautifierPreset(.voiceBeautifierOff)
```

```objective-c
// Beautifies the local voice by making it sound more vigorous.
[self.agoraKit setVoiceBeautifierPreset: AgoraTimbreTransformationVigorous];
// Disables voice effects.
[self.agoraKit setVoiceBeautifierPreset: AgoraVoiceBeautifierOff];
```
####  Voice changer effect

Voice changer effects adjust the voice to make it sound different from the original.

You can implement the voice changer effect by the enumerations in `setAudioEffectPreset` as follows:

| Enumeration                    | Description                                                  |
| :----------------------------- | :----------------------------------------------------------- |
| `AgoraVoiceChangerEffectUncle`   | The voice of an uncle. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `AgoraVoiceChangerEffectOldMan`  | The voice of an old man. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `AgoraVoiceChangerEffectBoy`     | The voice of a boy. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `AgoraVoiceChangerEffectSister`  | The voice of a young woman. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `AgoraVoiceChangerEffectGirl`    | The voice of a girl. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `AgoraVoiceChangerEffectPigKing` | The voice of Pig King, a character in Journey to the West who has a voice like a growling bear. |
| `AgoraVoiceChangerEffectHulk`    | The voice of Hulk.                                           |

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>setAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AgoraAudioProfileMusicHighQuality(4)</tt> or <tt>AgoraAudioProfileMusicHighQualityStereo(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AgoraAudioScenarioGameStreaming(3)</tt> before setting this enumerator.</div>

```swift
// Presets the local voice by making it sound like the Hulk.
agoraKit.setAudioEffectPreset(.voiceChangerEffectHulk)
// Disables voice effects.
agoraKit.setAudioEffectPreset(.audioEffectOff)
```

```objective-c
// Presets the local voice by making it sound like the Hulk.
[self.agoraKit setAudioEffectPreset: AgoraVoiceChangerEffectHulk];
// Disables voice effects.
[self.agoraKit setAudioEffectPreset: AgoraAudioEffectOff];
```

#### Style transformation

A style transformation makes singing more harmonious for specific styles of songs.

You can implement the style transformation by the enumerations in `setAudioEffectPreset` as follows:

| Enumeration                    | Description                               |
| :----------------------------- | :---------------------------------------- |
| `AgoraStyleTransformationPopular` | An audio effect typical of popular music. |
| `AgoraStyleTransformationRnB`     | An audio effect typical of R&B music.     |

<div class="alert note"><li>Call <tt>setAudioProfile</tt> and set the <tt>profile</tt> parameter to <tt>AgoraAudioProfileMusicHighQuality(4)</tt> or <tt>AgoraAudioProfileMusicHighQualityStereo(5)</tt> before setting this enumerator; otherwise, the enumerator setting does not take effect.</li><li>To achieve better audio effect quality, Agora recommends setting the <tt>scenario</tt> parameter of <tt>setAudioProfile</tt> to <tt>AgoraAudioScenarioGameStreaming(3)</tt> before setting this enumerator.</div>

```swift
// Presets the local voice to the style of pop music.
agoraKit.setAudioEffectPreset(.styleTransformationPopular)
// Disables voice effects.
agoraKit.setAudioEffectPreset(.audioEffectOff)
```

```objective-c
// Presets the local voice to the style of pop music.
[self.agoraKit setAudioEffectPreset: AgoraStyleTransformationPopular];
// Disables voice effects.
[self.agoraKit setAudioEffectPreset: AgoraAudioEffectOff];
```

#### Room acoustics

Room acoustics refers to the spatial dimension added to a user’s voice for making the voice seem to come from a specific type of enclosed place.

You can implement the space construction by the enumerations in `setAudioEffectPreset` as follows:

| Enumeration                     | Description                                                  |
| :------------------------------ | :----------------------------------------------------------- |
| `AgoraRoomAcousticsKTV`            | An audio effect typical of a KTV venue.                      |
| `AgoraRoomAcousticsVocalConcert`  | An audio effect typical of a concert hall.                   |
| `AgoraRoomAcousticsStudio`         | An audio effect typical of a recording studio.               |
| `AgoraRoomAcousticsPhonograph`     | An audio effect typical of a vintage phonograph.             |
| `AgoraRoomAcousticsVirtualStereo` | A virtual stereo effect that renders monophonic audio as stereo audio.<p>**Note**</p><li>Call `setAudioProfile` and set the `profile` parameter to `AgoraAudioProfileMusicStandardStereo(3)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator; otherwise, the enumerator setting does not take effect.</li><li>To achieve better audio effect quality, Agora recommends setting the `scenario` parameter of `setAudioProfile` to `AgoraAudioScenarioGameStreaming(3)` before setting this enumerator.</li> |
| `AgoraRoomAcousticsSpacial`        | A more spatial audio effect.                                 |
| `AgoraRoomAcousticsEthereal`       | A more ethereal audio effect.                                |
| `AgoraRoomAcoustics3DVoice`       | A 3D voice effect that makes the voice appear to be moving around the user. The default cycle period of the 3D voice effect is 10 seconds. To change the cycle period, call `setAudioEffectParameters` after this method.<p>**Note**</p><li>Call `setAudioProfile` and set the `profile` parameter to `AgoraAudioProfileMusicStandardStereo(3)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator; otherwise, the enumerator setting does not take effect.</li><li>To achieve better audio effect quality, Agora recommends setting the `scenario` parameter of `setAudioProfile` to `AgoraAudioScenarioGameStreaming(3)` before setting this enumerator.</li><li>If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.</li> |

<div class="alert note">If you use an enumerator excluding <tt>AgoraRoomAcousticsVirtualStereo</tt> or <tt>AgoraRoomAcoustics3DVoice</tt> to implement better voice effects, Agora recommends calling <tt>setAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AgoraAudioProfileMusicHighQuality(4)</tt> or <tt>AgoraAudioProfileMusicHighQualityStereo(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AgoraAudioScenarioGameStreaming(3)</tt> before setting this enumerator.</div>

```swift
// Presets the local voice by making it appear to be moving around the user.
agoraKit.setAudioEffectPreset(.roomAcoustics3DVoice)
// Changes the cycle period to 30 seconds.
agoraKit.setAudioEffectParameters(.roomAcoustics3DVoice, 30, 0)
// Disables voice effects.
agoraKit.setAudioEffectPreset(.audioEffectOff)
```

```objective-c
// Presets the local voice by making it appear to be moving around the user.
[self.agoraKit setAudioEffectPreset: AgoraRoomAcoustics3DVoice];
// Changes the cycle period to 30 seconds.
[self.agoraKit setAudioEffectParameters: AgoraRoomAcoustics3DVoice param1:30 param2:0];
// Disables voice effects.
[self.agoraKit setAudioEffectPreset: AgoraAudioEffectOff];
```

#### Pitch correction

Pitch correction refers to the effect for correcting a singing voice to make it match the song based on the basic mode and the tonic pitch.

You can implement the pitch correction by the enumerations in `setAudioEffectPreset` as follows:

| Enumeration        | Description                                                  |
| :----------------- | :----------------------------------------------------------- |
| `AgoraPitchCorrection` | A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. To change the basic mode and tonic pitch, call `setAudioEffectParameters` after this method. |

<div class="alert note"><li>To achieve better audio effect quality, Agora recommends calling <tt>setAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AgoraAudioProfileMusicHighQuality(4)</tt> or <tt>AgoraAudioProfileMusicHighQualityStereo(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AgoraAudioScenarioGameStreaming(3)</tt> before setting this enumerator.</li><li>Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively.</li></div>

```swift
// Presets the local voice by making it match the song.
agoraKit.setAudioEffectPreset(.pitchCorrection)
// Changes the basic mode to natural minor scale and the tonic pitch to D.
agoraKit.setAudioEffectParameters(.pitchCorrection, 2, 6)
// Disables voice effects.
agoraKit.setAudioEffectPreset(.audioEffectOff)
```

```objective-c
// Presets the local voice by making it match the song.
[self.agoraKit setAudioEffectPreset: AgoraPitchCorrection];
// Changes the basic mode to natural minor scale and the tonic pitch to D.
[self.agoraKit setAudioEffectParameters: AgoraPitchCorrection param1:2 param2:6];
// Disables voice effects.
[self.agoraKit setAudioEffectPreset: AgoraAudioEffectOff];
```

### Customize voice effects 

If the preset effect does not meet your requirement, you can also customize the voice effects by adjusting the voice pitch, equalization, and reverberation settings through `setLocalVoicePitch`, `setLocalVoiceEqualization`, and `setLocalVoiceReverb`.

The following sample code shows how to change the original user's voice to the Hulk's voice.

```swift
// swift
// Sets the pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the pitch. The default value is 1.0, which is the original pitch.
agoraKit.setLocalVoicePitch(1)
 
// Sets the local voice equalization.
// The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
// The second parameter sets the gain of each band. The value ranges between -15 and 15 dB. The default value is 0.
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
 
// The level of the dry signal in dB. The value ranges between -20 and 10.
agoraKit.setLocalVoiceReverbOf(.dryLevel, withValue: -1)
 
// The level of the early reflection signal (wet signal) in dB. The value ranges between -20 and 10.
agoraKit.setLocalVoiceReverbOf(.wetLevel, withValue: -7)
 
// The room size of the reverberation. A larger room size means a stronger reverberation. The value ranges between 0 and 100.
agoraKit.setLocalVoiceReverbOf(.roomSize, withValue: 57)
 
// The length of the initial delay of the wet signal (ms). The value ranges between 0 and 200.
agoraKit.setLocalVoiceReverbOf(.wetDelay, withValue: 135)
 
// The reverberation strength. The value ranges between 0 and 100. The higher the value, the stronger the reverberation.
agoraKit.setLocalVoiceReverbOf(.strength, withValue: 45)
```

```objective-c
// objective-c
// Sets the pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the pitch. The default value is 1.0, which is the original pitch.
[agoraKit setLocalVoicePitch: 1];
 
// Sets the local voice equalization.
// The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
// The second parameter sets the gain of each band. The value ranges between -15 and 15 dB. The default value is 0.
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
 
// The level of the dry signal in dB. The value ranges between -20 and 10.
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbDryLevel withValue: -1];
 
// The level of the early reflection signal (wet signal) in dB. The value ranges between -20 and 10.
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbWetLevel withValue: -7];
 
// The room size of the reverberation. A larger room size means a stronger reverberation. The value ranges between 0 and 100.
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbRoomSize withValue: 57];
 
// The length of the initial delay of the wet signal (ms). The value ranges between 0 and 200.
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbWetDelay withValue: 135];
 
// The reverberation strength. The value ranges between 0 and 100. The higher the value, the stronger the reverberation.
[agoraKit setLocalVoiceReverbOfType:AgoraAudioReverbStrength withValue: 45];
```

##  API reference

**Preset voice effects**

- [`setAudioEffectPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioEffectPreset:)
- [`setVoiceBeautifierPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVoiceBeautifierPreset:)
- [`setAudioEffectParameters`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioEffectParameters:param1:param2:)

**Customized voice effects**

- [`setLocalVoicePitch`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoicePitch:)
- [`setLocalVoiceEqualizationOfBandFrequency`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceEqualizationOfBandFrequency:withGain:)
- [`setLocalVoiceReverbOfType`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbOfType:withValue:)

## Considerations

- Do not set the `profile` parameter of `setAudioProfile` to `AgoraAudioProfileSpeechStandard(1)`; otherwise, `setAudioEffectPreset`, `setAudioEffectParameters` or `setVoiceBeautifierPreset` method call fails.
- All methods mentioned in this article work best with the human voice. Agora does not recommend using them for audio containing both music and voice.
- Agora recommends not calling the following methods together, because the method called subsequently overrides whichever one is called before it:
  - `setAudioEffectPreset`
  - `setVoiceBeautifierPreset`
  - `setLocalVoicePitch`
  - `setLocalVoiceEqualizationOfBandFrequency`
  - `setLocalVoiceReverbOfType`