---
title: Set the Voice Changer and Reverberation Effects
platform: Android
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
Ensure that you prepare the development environment. See [Integrate the SDK](start_live_android).

The following sample code shows how to change the original voice to Hulk's voice.

```java
// Sets the pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the pitch. The default value is 1.0, which is the original pitch.
double pitch = 0.5;
rtcEngine.setLocalVoicePitch(pitch);

// Sets the local voice equalization.
// The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz
// The second parameter sets the gain of each band. The value ranges between -15 and 15 dB. The default value is 0.
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

// The level of the dry signal in dB. The value ranges between -20 and 10.
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_DRY_LEVEL, 10);

// The level of the early reflection signal (wet signal) in dB. The value ranges between -20 and 10.
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_WET_LEVEL, 7);

// The room size of the reverberation. A larger room size means a stronger reverberation. The value ranges between 0 and 100.
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_ROOM_SIZE, 6);

// The length of the initial delay of the wet signal (ms). The value ranges between 0 and 200.
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_WET_DELAY, 124);

// The reverberation strength. The value ranges between 0 and 100. The higher the value, the stronger the reverberation.
rtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_STRENGTH, 78);
```

### API Reference

- [`setLocalVoicePitch`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a41b525f9cbf2911594bcda9b20a728c9)
- [`setLocalVoiceEqualization`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9e3aa79f0d6d8f2ea81907543506d960)
- [`setLocalVoiceReverb`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4afc32ba68e997e90ba3f128317827fa)

## Considerations
The API methods have return values. If the method call fails, the return value is < 0.