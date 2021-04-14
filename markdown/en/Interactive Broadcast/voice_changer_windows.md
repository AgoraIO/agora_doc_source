---
title: Set the Voice Effect
platform: Windows
updatedAt: 2021-03-05 04:57:09
---
In social and entertainment scenarios, users often need various voice effects to enhance an interactive experience. To accomplish this, Agora provides multiple preset voice changers and reverberation effects. You can also dynamically change the users' voice, such as adjusting the pitch and setting the equalization and reverberation modes.

Agora provides an [online demo](https://www.agora.io/en/audio-demo) to try out the voice changer and reverberation effects.

#### Chat enhancement 

Chat enhancement refers to enhancing the characteristics of male or female voices without altering the original voice beyond recognition.

You can implement the chat enhancement by the enumerations in `setLocalVoiceChanger` as follows:

| Enumeration                          | Description                                                  |
| :----------------------------------- | :----------------------------------------------------------- |
| GENERAL_BEAUTY_VOICE_MALE_MAGNETIC   | (For male-sounding voice only) A more magnetic voice. Do not use for speakers with a female-sounding voice; otherwise, voice distortion occurs. |
| GENERAL_BEAUTY_VOICE_FEMALE_FRESH    | (For female-sounding voice only) A fresher voice. Do not use for speakers with a male-sounding voice; otherwise, voice distortion occurs. |
| GENERAL_BEAUTY_VOICE_FEMALE_VITALITY | (For female-sounding voice only) A more vital voice. Do not use for speakers with a male-sounding voice; otherwise, voice distortion occurs. |

```c++
VOICE_CHANGER_PRESET voiceChanger;
// Beautifies the local voice by making it sound more magnetic (for male only).
voiceChanger = GENERAL_BEAUTY_VOICE_MALE_MAGNETIC;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// Disables voice effects.
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

#### Timbre transformation 

Timbre transformation changes the timbre of a voice in a specific way. Users can choose the most appropriate effect for their voice.

You can implement the timbre transformation by the enumerations in `setLocalVoiceChanger` as follows:

| Enumeration             | Description              |
| :---------------------- | :----------------------- |
| VOICE_BEAUTY_VIGOROUS   | A more vigorous voice.   |
| VOICE_BEAUTY_DEEP       | A deeper voice.          |
| VOICE_BEAUTY_MELLOW     | A mellower voice.        |
| VOICE_BEAUTY_FALSETTO   | Falsetto.                |
| VOICE_BEAUTY_FULL       | A fuller voice.          |
| VOICE_BEAUTY_CLEAR      | A clearer voice.         |
| VOICE_BEAUTY_RESOUNDING | A more resounding voice. |
| VOICE_BEAUTY_RINGING    | A more ringing voice.    |

```c++
VOICE_CHANGER_PRESET voiceChanger;
// Beautifies the local voice by making it sound more vigorous.
voiceChanger = VOICE_BEAUTY_VIGOROUS;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// Disables voice effects.
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

#### Voice changer effect

Voice changer effects adjust the voice to make it sound different from the original.

You can implement the voice changer effect by the enumerations in `setLocalVoiceChanger` or `setLocalVoiceReverbPreset` as follows:

<table>
  <tr>
    <th>Method</th>
		<th>Enumeration</th>
    <th>Description</th>
  </tr>
  <tr>
    <td rowspan="5"><tt>setLocalVoiceChanger</tt></td>
		<td><tt>VOICE_CHANGER_OLDMAN</tt></td>
    <td>(For male-sounding voice only) Voice of an old man.</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_BABYBOY</tt></td>
    <td>(For male-sounding voice only) Voice of a little boy.</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_BABYGIRL</tt></td>
    <td>(For female-sounding voice only) Voice of a little girl.</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_ZHUBAJIE</tt></td>
		<td>Voice of the Zhu Bajie, a character in <i>Journey to the West</i> who has a voice like that of a growling bear.</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_HULK</tt></td>
    <td>Voice of the Hulk. </td>
  </tr>
	<tr>
    <td rowspan="2"><tt>setLocalVoiceReverbPreset</tt></td>
		<td><tt>AUDIO_REVERB_FX_UNCLE</tt></td>
    <td>(For male-sounding voice only) Voice of a middle-aged uncle.</td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_FX_SISTER</tt></td>
    <td>(For female-sounding voice only) Voice of a maiden.</td>
  </tr>
 </table>

```c++
VOICE_CHANGER_PRESET voiceChanger;
// Presets the local voice by making it sound like the Hulk.
voiceChanger = VOICE_CHANGER_HULK;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// Disables voice effects.
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

```c++
AUDIO_REVERB_PRESET reverbPreset;
// Presets the local voice by making it sound like a middle-aged uncle (for male-sounding voice only).
reverbPreset = AUDIO_REVERB_FX_UNCLE;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
// Disables voice effects.
reverbPreset = AUDIO_REVERB_OFF;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
```

#### Style transformation 

A style transformation makes singing more harmonious for specific styles of songs.

You can implement the style transformation by the enumerations in `setLocalVoiceReverbPreset` as follows:

<div class="alert note">To implement better voice effects, Agora recommends enumerations with <tt>AUDIO_REVERB_FX</tt> as the prefix.</div>

| Enumeration             | Description                                                 |
| :---------------------- | :---------------------------------------------------------- |
| AUDIO_REVERB_FX_POPULAR | The reverberation style typical of pop music.               |
| AUDIO_REVERB_POPULAR    | The reverberation style typical of pop music (old version). |
| AUDIO_REVERB_FX_RNB     | The reverberation style typical of R&B music.               |
| AUDIO_REVERB_RNB        | The reverberation style typical of R&B music (old version). |
| AUDIO_REVERB_ROCK       | The reverberation style typical of rock music.              |
| AUDIO_REVERB_HIPHOP     | The reverberation style typical of hip-hop music.           |

```c++
AUDIO_REVERB_PRESET reverbPreset;
// Presets the local voice to the style of pop music.
reverbPreset = AUDIO_REVERB_FX_POPULAR;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
// Disables voice effects.
reverbPreset = AUDIO_REVERB_OFF;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
```

#### Room acoustics 

Room acoustics refers to the spatial dimension added to a user’s voice for making the voice seem to come from a specific type of enclosed place.

You can implement the space construction by the enumerations in `setLocalVoiceChanger` or `setLocalVoiceReverbPreset` as follows:

<div class="alert note"><li>To implement better voice effects, Agora recommends enumerations with <tt>AUDIO_REVERB_FX</tt> as the prefix.</li><li>To achieve better virtual stereo reverberation, Agora recommends setting the <tt>profile</tt> parameter of <tt>setAudioProfile</tt> as <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5).</tt></li></div>

<table>
  <tr>
    <th>Method</th>
		<th>Enumeration</th>
    <th>Description</th>
  </tr>
  <tr>
    <td rowspan="2"><tt>setLocalVoiceChanger</tt></td>
		<td><tt>VOICE_BEAUTY_SPACIAL</tt></td>
    <td>A more spatially resonant voice.</td>
  </tr>
  <tr>
    <td><tt>VOICE_CHANGER_ETHEREAL</tt></td>
    <td>An ethereal voice</td>
  </tr>
  <tr>
		<td rowspan="8"><tt>setLocalVoiceReverbPreset</tt></td>
    <td><tt>AUDIO_REVERB_FX_VOCAL_CONCERT</tt></td>
    <td>The reverberation style typical of a concert hall.</td>
  </tr>
	<tr>
		<td><tt>AUDIO_REVERB_VOCAL_CONCERT</tt></td>
    <td>The reverberation style typical of a concert hall (old version).</td>
  </tr>
	<tr>
		<td><tt>AUDIO_REVERB_FX_KTV</tt></td>
    <td>The reverberation style typical of a KTV venue.</td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_KTV</tt></td>
    <td>The reverberation style typical of a KTV venue (old version).</td>
  </tr>
	<tr>
		<td><tt>AUDIO_REVERB_FX_STUDIO</tt></td>
    <td>The reverberation style typical of a recording studio.</td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_STUDIO</tt></td>
    <td>The reverberation style typical of a recording studio (old version). </td>
  </tr>
  <tr>
    <td><tt>AUDIO_REVERB_FX_PHONOGRAPH</tt></td>
    <td>The reverberation style typical of a vintage phonograph.</td>
  </tr>
	<tr>
		<td><tt>AUDIO_VIRTUAL_STEREO</tt></td>
		<td>A reverberation style that adds a virtual stereo effect. The virtual stereo is an effect that renders the monophonic audio as stereo.</td>
  </tr>
 </table>

```c++
VOICE_CHANGER_PRESET voiceChanger;
// Presets the local voice by making it sound more spatially resonant.
voiceChanger = VOICE_BEAUTY_SPACIAL;
rtcEngine.setLocalVoiceChanger(voiceChanger);
// Disables voice effects.
voiceChanger = VOICE_CHANGER_OFF;
rtcEngine.setLocalVoiceChanger(voiceChanger);
```

```c++
AUDIO_REVERB_PRESET reverbPreset;
// Presets the local voice by making it sound like it is coming from a concert hall.
reverbPreset = AUDIO_REVERB_FX_VOCAL_CONCERT;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
// Disables voice effects.
reverbPreset = AUDIO_REVERB_OFF;
rtcEngine.setLocalVoiceReverbPreset(reverbPreset);
```

### Customize voice effects 

If the preset effect does not meet your requirement, you can also customize the voice effects by adjusting the voice pitch, equalization, and reverberation settings through `setLocalVoicePitch`, `setLocalVoiceEqualization`, and `setLocalVoiceReverb`.

The following sample code shows how to change the original user's voice to the Hulk's voice.

```c++
// Sets the pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the pitch. The default value is 1.0, which is the original pitch.
int nRet = rtcEngine.setLocalVoicePitch(0.5);
 
// Sets the local voice equalization.
// The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
// The second parameter sets the gain of each band. The value ranges between -15 and 15 dB. The default value is 0.
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
 
// The level of the dry signal in dB. The value ranges between -20 and 10.
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_DRY_LEVEL, 10);
 
// The level of the early reflection signal (wet signal) in dB. The value ranges between -20 and 10.
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_WET_LEVEL, 7);
 
// The room size of the reverberation. A larger room size means a stronger reverberation. The value ranges between 0 and 100.
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_ROOM_SIZE, 6);
 
// The length of the initial delay of the wet signal (ms). The value ranges between 0 and 200.
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_WET_DELAY, 124);
 
// The reverberation strength. The value ranges between 0 and 100. The higher the value, the stronger the reverberation.
nRet = rtcEngine.setLocalVoiceReverb(AUDIO_REVERB_STRENGTH, 78);
```

##  API reference

**Preset voice effects**

- [`setLocalVoiceChanger`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a99dc3d74202422436d40f6d7aa6e99dc)
- [`setLocalVoiceReverbPreset`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a51a429a5a848b2ad591220aa6c24a898)

**Customized voice effects**

- [`setLocalVoicePitch`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a43616f919e0906279dff5648830ce31a)
- [`setLocalVoiceEqualization`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a8c75994eb06ab26a1704715ec76e0189)
- [`setLocalVoiceReverb`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a4d1d1309f97f3c430a1aa2d060bb7316)

## Considerations

- All methods mentioned in this article work best with the human voice only. Agora does not recommend using them for audio containing both music and voice.
- Agora recommends not using the methods for presetting voice effects and for customizing voice effects together, as undefined behaviors may result. If you want to use preset voice effects together with methods that customize voice effects, call the preset methods before the customization methods, or the method called later overrides the one called earlier.