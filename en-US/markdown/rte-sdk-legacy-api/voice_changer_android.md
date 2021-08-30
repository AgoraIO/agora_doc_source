# Set the Voice Effect

In social or entertainment scenarios, voice effects such as chat beautifier, singing beautifier, and voice changer are popular features that greatly enhance user experience. In the online KTV use case, for example, applying a virtual stereo effect to the host's voice may attract a large audience in a short time.

This page shows how to impelement voice effects in your project.

## Understand the tech

To help you quickly integrate voice effects into your project, Agora preconfigures the voice effect parameters and encapsulates them into enumerations. 

Use the following methods and set the voice effect you want:

- Effects such as chat beautifier, singing beautifier, and timber transformation: `setVoiceBeautifierPreset`.
- Effects such as voice changer, style transformation, room acoustics, and pitch correction: `setAudioEffectPreset`.
- Completely changes the original voice beyond recognition: `setVoiceConversionPreset`.

If the preset voice effects do not meet your requirements, you can also call `setLocalVoicePitch`, `setLocalVoiceEqualization`, and `setLocalVoiceReverb` to cutomize the audio effects.

To understand more clearly how effects change your voice, try our [online demo](https://web-cdn.agora.io/marketing/audio_en_v3.html).

## Prerequsites

Before proceeding, ensure that you have a project that has implemented the [basic real-time audio and video engagement functionalities]().


## Implement voice effects

This section introduces how to implement the various audio effects in your project.

1. Set the audio profile for better voice effects

   In your Agora project, open the file used to manage `RtEngine` initialization and add the following code:

    ```java
    // Set MaudioScenario in RtcEngineConfig as AUDIO_SCENARIO_GAME_STREAMING.
    config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.HIGH_DEFINITION);
    mRtcEngine = RtcEngine.create(config);
    
    // Call setAudioProfile to set profile as AUDIO_PROFILE_MUSIC_HIGH_QUALITY or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO.
    mRtcEngine.setAudioProfile(Constants.AudioProfile.getValue(Constants.AudioProfile.MUSIC_HIGH_QUALITY_STEREO));
    ```
2. Set the voice effect according to your use case

   > You can set only one voice effect at one time. Otherwise, the voice effect set later overwrites the previous one.

   - Set the chat beautifier effect, which beautifies the characteristics of male or female speaking voices without altering the original voice beyond recognition:
    
     ```java
     // Set the voice effect as magnetic. This enumerator applies to male voices only.
     // Using it for female voices can cause voice distortion.
     mRtcEngine.setVoiceBeautifierPreset(Constants.CHAT_BEAUTIFIER_MAGNETIC);
     // Disables the voice effect.
     mRtcEngine.setVoiceBeautifierPreset(Constants.VOICE_BEAUTIFIER_OFF);
     ```
   - Set the singing beautifier effect, which beautifies male or female singing voices without altering their original characteristics:

     ```java
     // Beautifies the singing voice for a male user. Do not use it for a female user.
     mRtcEngine.setVoiceBeautifierPreset(Constants.SINGING_BEAUTIFIER); 
     // Disables the voice effect.
     mRtcEngine.setVoiceBeautifierPreset(Constants.VOICE_BEAUTIFIER_OFF);

     // Beautifies the singling voice for a female user.
     mRtcEngine.setVoiceBeautifierParameters(Constants.SINGING_BEAUTIFIER, 2, 3); 
     // Disables the voice effect.
     mRtcEngine.setVoiceBeautifierPreset(Constants.VOICE_BEAUTIFIER_OFF);
     ```
   - Set the timber transformation effect, which changes the timbre of a voice in a spcific way:

     ```java
     // Set the timber transformation effect.
     // Beautifies the local voice by making it more vigorous.
     mRtcEngine.setVoiceBeautifierPreset(Constants.TIMBRE_TRANSFORMATION_VIGOROUS);
     // Disables the voice effect.
     mRtcEngine.setVoiceBeautifierPreset(Constants.VOICE_BEAUTIFIER_OFF);
     ```
   - Set the voice changer effect, which changes the original voice for fun effects:

     ```java
     // Changes the loca voice to sound like the Hulk.
     mRtcEngine.setAudioEffectPreset(Constants.VOICE_CHANGER_EFFECT_HULK);
     // Disables the voice effect.
     mRtcEngine.setAudioEffectPreset(Constants.AUDIO_EFFECT_OFF);
     ```

   - Set the style transformation effect, which makes singing more harmonious for a specific style of songs:

     ```java
     // Transforms the local voice to the style of pop music.
     mRtcEngine.setAudioEffectPreset(Constants.STYLE_TRANSFORMATION_POPULAR);
     // Disables the voice effect.
     mRtcEngine.setAudioEffectPreset(Constants.AUDIO_EFFECT_OFF);
     ```
    
   - Set the room acoustics effect, which adds spatial dimensions to the voice:

     ```java
     // Adds spatial effect to the local voice as if the user is in KTV.
     mRtcEngine.setAudioEffectPreset(Constants.ROOM_ACOUSTICS_KTV);
     // Disables the voice effect.
     mRtcEngine.setAudioEffectPreset(Constants.AUDIO_EFFECT_OFF);
     ```

   - Set the pitch correction effect, which corrects a singing voice so that the voice better fits the song:

     ```java
     // Apply pitch correction to the local voice based on the pitch of the natural C major scale.
     mRtcEngine.setAudioEffectPreset(Constants.PITCH_CORRECTION);
     // Disables the voice effect.
     mRtcEngine.setAudioEffectPreset(Constants.AUDIO_EFFECT_OFF);
     ```
   - Set the voice conversion effect, which changes the original voice beyond recognition:

     ```java
     // Set the local voice by making it sound like a gender-neutral voice.
     mRtcEngine.setVoiceConversionPreset(Constants.VOICE_CHANGER_NEUTRAL);  
     // Disables voice effects. 
     mRtcEngine.setVoiceConversionPreset(Constants.VOICE_CONVERSION_OFF);
     ```
   
   - Customize the voice effect by adjusting the voice pitch, equalization, and reverberation settings.

     The following code shows how to change the original voice to the Hulk's voice by manaully setting the parameter values:

     ```java
     double pitch = 0.5;
     mRtcEngine.setLocalVoicePitch(pitch);

     // Sets the local voice equalization.
     // The first parameter sets the band frequency. The value ranges between 0 and 9. Each value represents the center frequency of the band: 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
     // The second parameter sets the gain of each band. The value ranges between -15 and 15 dB. The default value is 0.
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(0), -15);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(1), 3);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(2), -9);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(3), -8);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(4), -6);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(5), -4);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(6), -3);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(7), -2);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(8), -1);
     mRtcEngine.setLocalVoiceEqualization(Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY.fromInt(9), 1);

     // The level of the dry signal in dB. The value ranges between -20 and 10.
     mRtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_TYPE.fromInt(0), 10);

     // The level of the early reflection signal (wet signal) in dB. The value ranges between -20 and 10.
     mRtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_TYPE.fromInt(1), 7);

     // The room size of the reverberation. A larger room size means a stronger reverberation. The value ranges between 0 and 100.
     mRtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_TYPE.fromInt(2), 6);

     // The length of the initial delay of the wet signal (ms). The value ranges between 0 and 200.
     mRtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_TYPE.fromInt(3), 124);

     // The reverberation strength. The value ranges between 0 and 100. The higher the value, the stronger the reverberation.
     mRtcEngine.setLocalVoiceReverb(Constants.AUDIO_REVERB_TYPE.fromInt(4), 78);
     ``` 

## Reference

This section provides reference knowledge you need to know when implementing voice effects.

- Agora provides an open source [Voice Effects](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/VoiceEffects.java) sample project on GitHub. You can download the sample project to try it out or view the souce code.

- Some enumertors in `setVoiceBeautifierPreset`, `setAudioEffectPreset`, and `setVoiceConversionPreset` are gender specific and apply to one gender only. Using them on the other gender can lead to voice distortion. For details, see the API Reference of the following methods:

  - [setVoiceBeautifierPreset]()
  - [setAudioEffectPreset]()
  - [setVoiceConversionPreset]()
  - [setAudioEffectParameters]()
  - [setVoiceBeautifierParameters]()