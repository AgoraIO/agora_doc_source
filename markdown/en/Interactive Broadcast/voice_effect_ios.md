---
title: Set the Voice Changer and Reverberation Effects
platform: iOS
updatedAt: 2019-12-10 12:20:29
---
## Introduction 

## Introduction

In social and entertainment scenarios, users often want various voice effects to improve their interactive experiences. For example, in chat rooms, a user can select a voice effect to add a virtual stereo effect to their voice.

To accomplish this, Agora RTC SDK provides preset voice effects. You can also dynamically change the users' voices, such as adjusting the pitch, setting the equalization, and reverberation modes. Try out the preset voice effects on the [online Demo](https://www.agora.io/en/audio-demo) provided by Agora.

## Sample project

<% 
if (os == "android") { %>
Agora provides an open-source sample project ([VoiceEffects.java](https://github.com/AgoraIO/API-Examples/tree/master/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/VoiceEffects.java)) that implements the voice beautifier and audio effects functions on GitHub. You can download it to try out this function and view the source code.
<% }

if (os == "windows") { %>
Agora provides an open-source sample project ([BeautyAudio](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/BeautyAudio)) that implements the voice beautifier and audio effects functions on GitHub. You can download it to try out this function and view the source code.
<% }

if (os == "apple") { %>
Agora provides the following open-source sample projects that implement the voice beautifier and audio effects functions on GitHub. You can download them to try out this function and view the source code.

- iOS: [VoiceChanger](https://github.com/AgoraIO/API-Examples/tree/master/iOS/APIExample/Examples/Advanced/VoiceChanger)
- macOS: [VoiceChanger](https://github.com/AgoraIO/API-Examples/tree/master/macOS/APIExample/Examples/Advanced/VoiceChanger)
<% }
%>

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

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./ios_video).

### Use a preset voice changer and reverberation effect

You can use one of the following preset voice changer options by calling `setLocalVoiceChanger`:

- An old man's voice.
- A little boy's voice.
- A little girl's voice.
- Zhu Bajie's voice (Zhu Bajie is a character from Journey to the West who has a voice like a growling bear).
- Ethereal vocal effects.
- Hulk's voice.

```swift
// swift
// Set the voice changer as old man
agoraKit.setLocalVoiceChanger(.oldMan)

// Turn off the voice changer
agoraKit.setLocalVoiceChanger(.off)
```

```objective-c
// objective-c
// Set the voice changer as old man
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceChangerOldMan];

// Turn off the voice changer
[self.agoraKit setLocalVoiceChanger: AgoraAudioVoiceChangerOff];
```

You can use one of the following preset reverberation effects by calling `setLocalVoiceReverbPreset`:

- Pop music
- R&B
- Rock music
- Hip-hop
- Pop concert
- KTV
- Recording studio

```swift
// swift
// Set the reverberation preset as pop
agoraKit.setLocalVoiceReverbPreset(.popular)

// Turn off the reverberation
agoraKit.setLocalVoiceReverbPreset(.off)
```

```objective-c
// objective-c
// Set the reverberation preset as pop
[self.agoraKit setLocalVoiceReverbPreset: AgoraAudioReverbPresetPopular];

// Turn off the reverberation
[self.agoraKit setLocalVoiceReverbPreset: AgoraAudioReverbPresetOff];
```

### Customize the voice effects

You can also customize the voice effects by adjusting the voice pitch, equalization, and reverberation settings.

The following sample code shows how to set the FM voice effect.

```swift
// swift
// Sets the pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the pitch. The default value is 1.0, which is the original pitch.
agoraKit.setLocalVoicePitch(1)

// Sets the local voice equalization.
// The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz
// The second parameter sets the gain of each band. The value range between -15 and 15 dB. The default value is 0.
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
// The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz
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

### API Reference

- [`setLocalVoiceChanger`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:)
- [`setLocalVoiceReverbPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:)
- [`setLocalVoicePitch`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoicePitch:)
- [`setLocalVoiceEqualizationOfBandFrequency`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceEqualizationOfBandFrequency:withGain:)
- [`setLocalVoiceReverbOfType`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbOfType:withValue:)

## Considerations
The API methods have return values. If the method call fails, the return value is < 0.
