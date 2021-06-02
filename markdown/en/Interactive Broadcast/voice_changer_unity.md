---
title: Set the Voice Effect
platform: Unity
updatedAt: 2021-03-12 04:52:22
---
## Introduction

In social and entertainment scenarios, users often want various voice effects to improve their interactive experiences. For example, in chat rooms, a user can select a voice effect to add a virtual stereo effect to their voice.

To accomplish this, Agora RTC SDK provides preset voice effects. You can also dynamically change the users' voices, such as adjusting the pitch, setting the equalization, and reverberation modes. Try out the preset voice effects on the [online Demo](https://www.agora.io/en/audio-demo) provided by Agora.

## Use preset voice effects

To meet the requirements for voice effects in different scenarios, Agora provides `SetVoiceBeautifierPreset`, `SetAudioEffectPreset` and `SetVoiceConversionPreset`. You can use the following SDK preset voice effects:

<table>
  <tr>
    <th colspan="2">Category</th>
    <th>Scenario</th>
  </tr>
  <tr>
    <td rowspan="3">Voice beautifier<p><tt>SetVoiceBeautifierPreset</tt></p></td>
    <td>Chat beautifier</td>
    <td>Audio and video scenarios focusing on a user’s speaking voice:<li>Blind date</li><li>Emotional radio</li><li>Co-host audio streaming</li><li>Voice-only PK Hosting</li><li>Gaming chatroom</li></td>
  </tr>
	  <tr>
    <td>Singing beautifier</td>
    <td>Audio and video scenarios focusing on a user’s singing voice:<li>Online KTV</li><li>Music radio</li><li>Live-streaming showroom</li></td>
  </tr>
  <tr>
    <td>Timbre transformation</td>
    <td>Audio and video scenarios focusing on a user’s speaking or singing voice:<li>Co-host audio streaming</li><li>Voice PK hosting</li><li>Gaming chatroom</li><li>Blind date</li><li>Online KTV</li><li>FM radio</li></td>
  </tr>
  <tr>
    <td rowspan="4">Audio effect<p><tt>SetAudioEffectPreset</tt></p></td>
    <td>Voice changer</td>
    <td>Audio and video scenarios focusing on a user’s speaking voice:<li>Co-host audio streaming</li><li>Voice-only PK Hosting</li><li>Gaming chatroom</li></td>
  </tr>
  <tr>
    <td>Style transformation</td>
    <td>Audio and video scenarios focusing on a user’s singing voice:<li>Online KTV</li><li>Music radio</li><li>Live-streaming showroom</li></td>
  </tr>
  <tr>
    <td>Room acoustics</td>
    <td>Audio and video scenarios focusing on a user’s speaking or singing voice:<li>Co-host audio streaming</li><li>Voice PK hosting</li><li>Gaming chatroom</li><li>Blind date</li><li>Online KTV</li><li>FM radio</li></td>
  </tr>
  <tr>
    <td>Pitch correction</td>
    <td>Audio and video scenarios focusing on a user’s singing voice:<li>Online KTV</li><li>Music radio</li><li>Live-streaming showroom</li></td>
  </tr>
	<tr>
    <td>Voice conversion<p><tt>SetVoiceConversionPreset</tt></p></td>
    <td>Voice conversion</td>
    <td>Audio and video scenarios focusing on a user’s speaking or singing voice:<li>Co-host audio streaming</li><li>Voice PK hosting</li><li>Gaming chatroom</li><li>Blind date</li><li>Online KTV</li><li>FM radio</li></td>
  </tr>
 </table>

### Chat beautifier

Chat beautifier refers to beautifying the characteristics of male or female voices without altering the original voice beyond recognition.

You can implement the chat beautifier by the enumerations in `SetVoiceBeautifierPreset` as follows:

| Enumeration                | Description                                                  |
| :------------------------- | :----------------------------------------------------------- |
| `CHAT_BEAUTIFIER_MAGNETIC` | (For male-sounding voice only) A more magnetic voice. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion. |
| `CHAT_BEAUTIFIER_FRESH`    | (For female-sounding voice only) A fresher voice. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion. |
| `CHAT_BEAUTIFIER_VITALITY` | (For female-sounding voice only) A more vital voice. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion. |

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>SetAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</div>

```c#
// Beautifies the local voice by making it sound more magnetic (for male only).
public int SetVoiceBeautifierPreset() 
{
  return mRtcEngine.SetVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET.CHAT_BEAUTIFIER_MAGNETIC);
}
```

### Singing beautifier

Singing beautifier refers to beautifying male or female singing voices without greatly altering their original characteristics, as well as adding a reverberation effect.

You can implement the singing beautifier by the enumeration `SINGING_BEAUTIFIER`.
- If you call `SetVoiceBeautifierPreset(SINGING_BEAUTIFIER)`, you can beautify a male-sounding voice and add a reverberation effect that sounds like singing in a small room. Agora recommends not using `SetVoiceBeautifierPreset(SINGING_BEAUTIFIER)` to process a female-sounding voice; otherwise, you may experience vocal distortion.
- If you call `SetVoiceBeautifierParameters(SINGING_BEAUTIFIER, param1, param2)`, you can beautify a male- or female-sounding voice and add one of several reverberation effects.

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>SetAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</div>

```c#
// Beautifies the singing voice of the local user. 
public int SetVoiceBeautifierPreset() 
{
  return mRtcEngine.SetVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET.SINGING_BEAUTIFIER);
}

// Beautifies a female-sounding voice and add a reverberation effect that sounds like singing in a hall.
public int SetAudioEffectParameters() 
{
  return mRtcEngine.SetVoiceBeautifierParameters(VOICE_BEAUTIFIER_PRESET.SINGING_BEAUTIFIER, 2, 3);
}
```

### Timbre transformation

Timbre transformation changes the timbre of a voice in a specific way. Users can choose the most appropriate effect for their voice.

You can implement the timbre transformation by the enumerations in `SetVoiceBeautifierPreset` as follows:

| Enumeration                        | Description              |
| :--------------------------------- | :----------------------- |
| `TIMBRE_TRANSFORMATION_VIGOROUS`   | A more vigorous voice.   |
| `TIMBRE_TRANSFORMATION_DEEP`       | A deeper voice.          |
| `TIMBRE_TRANSFORMATION_MELLOW`     | A mellower voice.        |
| `TIMBRE_TRANSFORMATION_FALSETTO`   | A falsetto voice.        |
| `TIMBRE_TRANSFORMATION_FULL`       | A fuller voice.          |
| `TIMBRE_TRANSFORMATION_CLEAR`      | A clearer voice.         |
| `TIMBRE_TRANSFORMATION_RESOUNDING` | A more resounding voice. |
| `TIMBRE_TRANSFORMATION_RINGING`    | A more ringing voice.    |

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>SetAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</div>

```c#
// Beautifies the local voice by making it sound more vigorous.
public int SetVoiceBeautifierPreset() 
{
  return mRtcEngine.SetVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET.TIMBRE_TRANSFORMATION_VIGOROUS);
}
```

###  Voice changer

Voice changer changes the original voice mainly for fun effects. This effect makes the original voice less natural, so that listeners can tell that the voice has been changed.

You can implement the voice changer effect by the enumerations in `SetAudioEffectPreset` as follows:

| Enumeration                    | Description                                                  |
| :----------------------------- | :----------------------------------------------------------- |
| `VOICE_CHANGER_EFFECT_UNCLE`   | The voice of an uncle. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `VOICE_CHANGER_EFFECT_OLDMAN`  | The voice of an old man. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `VOICE_CHANGER_EFFECT_BOY`     | The voice of a boy. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `VOICE_CHANGER_EFFECT_SISTER`  | The voice of a young woman. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `VOICE_CHANGER_EFFECT_GIRL`    | The voice of a girl. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect. |
| `VOICE_CHANGER_EFFECT_PIGKING` | The voice of Pig King, a character in Journey to the West who has a voice like a growling bear. |
| `VOICE_CHANGER_EFFECT_HULK`    | The voice of Hulk.                                           |

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>SetAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</div>

```c#
// Presets the local voice by making it sound like the Hulk.
public int SetAudioEffectPreset() 
{
  return mRtcEngine.SetAudioEffectPreset(AUDIO_EFFECT_PRESET.VOICE_CHANGER_EFFECT_HULK);
}
```

### Style transformation

A style transformation makes singing more harmonious for specific styles of songs.

You can implement the style transformation by the enumerations in `SetAudioEffectPreset` as follows:

| Enumeration                    | Description                               |
| :----------------------------- | :---------------------------------------- |
| `STYLE_TRANSFORMATION_POPULAR` | An audio effect typical of popular music. |
| `STYLE_TRANSFORMATION_RNB`     | An audio effect typical of R&B music.     |

<div class="alert note"><li>Call <tt>SetAudioProfile</tt> and set the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt> before setting this enumerator; otherwise, the enumerator setting does not take effect.</li><li>To achieve better audio effect quality, Agora recommends setting the <tt>scenario</tt> parameter of <tt>SetAudioProfile</tt> to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</div>

```c#
// Presets the local voice to the style of pop music.
public int SetAudioEffectPreset() 
{
  return mRtcEngine.SetAudioEffectPreset(AUDIO_EFFECT_PRESET.STYLE_TRANSFORMATION_POPULAR);
}
```

### Room acoustics

Room acoustics refers to the spatial dimension added to a user’s voice for making the voice seem to come from a specific type of enclosed place.

You can implement the space construction by the enumerations in `SetAudioEffectPreset` as follows:

| Enumeration                     | Description                                                  |
| :------------------------------ | :----------------------------------------------------------- |
| `ROOM_ACOUSTICS_KTV`            | An audio effect typical of a KTV venue.                      |
| `ROOM_ACOUSTICS_VOCAL_CONCERT`  | An audio effect typical of a concert hall.                   |
| `ROOM_ACOUSTICS_STUDIO`         | An audio effect typical of a recording studio.               |
| `ROOM_ACOUSTICS_PHONOGRAPH`     | An audio effect typical of a vintage phonograph.             |
| `ROOM_ACOUSTICS_VIRTUAL_STEREO` | A virtual stereo effect that renders monophonic audio as stereo audio.<p>**Note**</p><li>Call `SetAudioProfile` and set the `profile` parameter to `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting this enumerator; otherwise, the enumerator setting does not take effect.</li><li>To achieve better audio effect quality, Agora recommends setting the `scenario` parameter of `SetAudioProfile` to `AUDIO_SCENARIO_GAME_STREAMING(3)` before setting this enumerator.</li> |
| `ROOM_ACOUSTICS_SPACIAL`        | A more spatial audio effect.                                 |
| `ROOM_ACOUSTICS_ETHEREAL`       | A more ethereal audio effect.                                |
| `ROOM_ACOUSTICS_3D_VOICE`       | A 3D voice effect that makes the voice appear to be moving around the user. The default cycle period of the 3D voice effect is 10 seconds. To change the cycle period, call `SetAudioEffectParameters` after this method.<p>**Note**</p><li>Call `SetAudioProfile` and set the `profile` parameter to `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting this enumerator; otherwise, the enumerator setting does not take effect.</li><li>To achieve better audio effect quality, Agora recommends setting the `scenario` parameter of `SetAudioProfile` to `AUDIO_SCENARIO_GAME_STREAMING(3)` before setting this enumerator.</li><li>If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.</li> |

<div class="alert note">If you use an enumerator excluding <tt>ROOM_ACOUSTICS_VIRTUAL_STEREO</tt> or <tt>ROOM_ACOUSTICS_3D_VOICE</tt> to implement better voice effects, Agora recommends calling <tt>SetAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</div>

```c#
// Presets the local voice by making it appear to be moving around the user.
public int SetAudioEffectPreset() 
{
  return mRtcEngine.SetAudioEffectPreset(AUDIO_EFFECT_PRESET.ROOM_ACOUSTICS_3D_VOICE);
}

// Changes the cycle period to 30 seconds.
public int SetAudioEffectParameters() 
{
  return mRtcEngine.SetAudioEffectParameters(AUDIO_EFFECT_PRESET.ROOM_ACOUSTICS_3D_VOICE, 30, 0);
}
```

### Pitch correction

Pitch correction refers to the effect for correcting a singing voice to make it match the song based on the basic mode and the tonic pitch.

You can implement the pitch correction by the enumerations in `SetAudioEffectPreset` as follows:

| Enumeration        | Description                                                  |
| :----------------- | :----------------------------------------------------------- |
| `PITCH_CORRECTION` | A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. To change the basic mode and tonic pitch, call `SetAudioEffectParameters` after this method. |

<div class="alert note"><li>To achieve better audio effect quality, Agora recommends calling <tt>SetAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</li><li>Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively.</li></div>

```c#
// Presets the local voice by making it match the song.
public int SetAudioEffectPreset() 
{
  return mRtcEngine.SetAudioEffectPreset(AUDIO_EFFECT_PRESET.PITCH_CORRECTION);
}

// Changes the basic mode to natural minor scale and the tonic pitch to D.
public int SetAudioEffectParameters() 
{
  return mRtcEngine.SetAudioEffectParameters(AUDIO_EFFECT_PRESET.ROOM_ACOUSTICS_3D_VOICE, 2, 6);
}
```

### Voice conversion

Voice changer naturally changes the original voice mainly for anonymous effects. Listeners cannot tell that the voice has been changed without listening to the original voice.

You can implement the voice changer by the enumerations in `SetVoiceConversionPreset` as follows:

| Enumeration             | Description                                                  |
| :---------------------- | :----------------------------------------------------------- |
| `VOICE_CONVERSION_OFF`  | Turn off voice conversion effects and use the original voice. |
| `VOICE_CHANGER_NEUTRAL` | A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice. |
| `VOICE_CHANGER_SWEET`   | A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice. |
| `VOICE_CHANGER_SOLID`   | A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice. |
| `VOICE_CHANGER_BASS`    | A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice. |

<div class="alert note">To achieve better audio effect quality, Agora recommends calling <tt>SetAudioProfile</tt>, setting the <tt>profile</tt> parameter to <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)</tt> or <tt>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)</tt>, and setting the <tt>scenario</tt> parameter to <tt>AUDIO_SCENARIO_GAME_STREAMING(3)</tt> before setting this enumerator.</div>

```c#
// Presets the local voice by making it sound like a gender-neutral voice.
public int SetVoiceConversionPreset() 
{
  return mRtcEngine.SetVoiceConversionPreset(VOICE_CONVERSION_PRESET.VOICE_CHANGER_NEUTRAL);
}
```

## Customize voice effects 

If the preset effect does not meet your requirement, you can also customize the voice effects by adjusting the voice pitch, equalization, and reverberation settings through `SetLocalVoicePitch`, `SetLocalVoiceEqualization`, and `SetLocalVoiceReverb`.

The following sample code shows how to change the original user's voice to the Hulk's voice.

```c#
// Sets the pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the pitch. The default value is 1.0, which is the original pitch.
public int SetLocalVoicePitch(double pitch) 
{
  return mRtcEngine.SetLocalVoicePitch(pitch);
}

// Sets the local voice equalization.
// The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
// The second parameter sets the gain of each band. The value ranges between -15 and 15 dB. The default value is 0.
public void SetLocalVoiceEqualization() 
{
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_31, -15);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_62, 3);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_125, -9);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_250, -8);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_500, -6);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_1K, -4);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_2K, -3);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_4K, -2);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_8K, -1);
  mRtcEngine.SetLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY.AUDIO_EQUALIZATION_BAND_16K, 1);
}

public void SetLocalVoiceReverb()
{
  // The level of the dry signal in dB. The value ranges between -20 and 10.
  mRtcEngine.SetLocalVoiceReverb(AUDIO_REVERB_TYPE.AUDIO_REVERB_DRY_LEVEL, 10);
  // The level of the early reflection signal (wet signal) in dB. The value ranges between -20 and 10.
  mRtcEngine.SetLocalVoiceReverb(AUDIO_REVERB_TYPE.AUDIO_REVERB_WET_LEVEL, 7);
  // The room size of the reverberation. A larger room size means a stronger reverberation. The value ranges between 0 and 100.
  mRtcEngine.SetLocalVoiceReverb(AUDIO_REVERB_TYPE.AUDIO_REVERB_ROOM_SIZE, 6);
  // The length of the initial delay of the wet signal (ms). The value ranges between 0 and 200.
  mRtcEngine.SetLocalVoiceReverb(AUDIO_REVERB_TYPE.AUDIO_REVERB_WET_DELAY, 124);
  // The reverberation strength. The value ranges between 0 and 100. The higher the value, the stronger the reverberation.
  mRtcEngine.SetLocalVoiceReverb(AUDIO_REVERB_TYPE.AUDIO_REVERB_STRENGTH, 78);
}
```

##  API reference

**Preset voice effects**

- [`SetAudioEffectPreset`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a4bbf600b51a400fe6ab261a95e47bad6)
- [`SetVoiceBeautifierPreset`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab4953c6ce75adc42a13297af41676d9a)
- [`SetAudioEffectParameters`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9ccf7abdd5f7b4bc0e7f0a7807e34390)
- [`SetVoiceBeautifierParameters`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#acb6c5d42ea4e14b0f2e7bc8f27bc2def)
- [`SetVoiceConversionPreset`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#aee2fb5664266783a9ff855b4ef81e1b6)

**Customized voice effects**

- [`SetLocalVoicePitch`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#aa4b05f6b03d172520a887989be81b20e)
- [`SetLocalVoiceEqualization`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9737e27e79e059e42e01a0e3b26e4212)
- [`SetLocalVoiceReverb`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#aab74b2ee8ab0e33b75667cf5bb7cc4bf)

## Considerations

- Do not set the `profile` parameter of `SetAudioProfile` to `AUDIO_PROFILE_SPEECH_STANDARD(1)` or `AUDIO_PROFILE_IOT(6)`; otherwise, the following methods do not take effect.
 - `SetAudioEffectPreset`
 - `SetVoiceBeautifierPreset`
 - `SetAudioEffectParameters`
 - `SetVoiceBeautifierParameters`
 - `SetVoiceConversionPreset`
- All methods mentioned in this article work best with the human voice. Agora does not recommend using them for audio containing both music and voice.
- Agora recommends not calling the following methods together, because the method called subsequently overrides whichever one is called before it:
  - `SetAudioEffectPreset`
  - `SetVoiceBeautifierPreset`
  - `SetAudioEffectParameters`
  - `SetVoiceBeautifierParameters`
  - `SetVoiceConversionPreset`
  - `SetLocalVoicePitch`
  - `SetLocalVoiceEqualizationOfBandFrequency`
  - `SetLocalVoiceReverbOfType`