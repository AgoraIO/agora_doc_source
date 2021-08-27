# Set the Voice Effect

In social or entertainment scenarios, voice effects such as chat beautifier, singing beautifier, and voice changer are popular features that greatly enhance user experience. In the online KTV use case, for example, applying a virtual stereo effect to the host's voice may attract a large audience in a short time.

This page shows how to impelement voice effects in your project.

## Understand the tech

To help you quickly integrate voice effects into your project, Agora preconfigures the voice effect parameters and encapsulates them into enumerations. 

Use the following methods and set the voice effect you want:

- Effects such as chat beautifier, singing beautifier, and timber transformation: `setVoiceBeautifierPreset`.
- Effects such as voice changer, style transformation, room acoustics, and pitch correction: `setAudioEffectPreset`.
- Completely changes the original voice beyond recognition: `setVoiceConversionPreset`.

If the preset voice effects do not meet your requirements, you can also call `setLocalVoicePitch`, `setLocalVoiceEqualizationOfBandFrequency`, and `setLocalVoiceReverb` to cutomize the audio effects.

To understand more clearly how effects change your voice, try our [online demo](https://web-cdn.agora.io/marketing/audio_en_v3.html).

## Prerequsites

Before proceeding, ensure that you have a project that has implemented the [basic real-time audio and video engagement functionalities]().


## Implement voice effects

This section introduces how to implement the various audio effects in your project.

1. Set the audio profile for better voice effects

   In your Agora project, open the file used to manage `AgoraRtEngineKit` initialization and add the following code:

    ```swift
    // Set audioScenario in AgoraRtcEngineConfig as AgoraAudioScenarioGameStreaming.
    config.audioScenario = .gameStreaming
    agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

    // Call setAudioProfile to set profile as AgoraAudioProfileMusicHighQuality or AgoraAudioProfileMusicHighQualityStereo.
    agoraKit.setAudioProfile(.musicHighQaulityStereo)
    ```
2. Set the voice effect according to your use case

   > You can set only one voice effect at one time. Otherwise, the voice effect set later overwrites the previous one.

   - Set the chat beautifier effect, which beautifies the characteristics of male or female speaking voices without altering the original voice beyond recognition:
    
     ```swift
     // Set the voice effect as magnetic. This enumerator applies to male voices only.
     // Using it for female voices can cause voice distortion.
     agoraKit.setVoiceBeautifierPreset(.chatBeautifierMagnetic)
     // Disables the voice effect.
     agoraKit.setVoiceBeautifierPreset(.voiceBeautifierOff)
     ```
   - Set the singing beautifier effect, which beautifies male or female singing voices without altering their original characteristics:

     ```swift
     // Beautifies the singing voice for a male user. Do not use it for a female user.
     agoraKit.setVoiceBeautifierPreset(.singingBeautifier)
     // Disables the voice effect.
     agoraKit.setVoiceBeautifierPreset(.voiceBeautifierOff)

     // Beautifies the singling voice for a female user.
     agoraKit.setVoiceBeautifierParameters(.singingBeautifier, 2, 3)
     // Disables the voice effect.
     agoraKit.setVoiceBeautifierPreset(.voiceBeautifierOff)
     ```
   - Set the timber transformation effect, which changes the timbre of a voice in a spcific way:

     ```swift
     // Set the timber transformation effect.
     // Beautifies the local voice by making it more vigorous.
     agoraKit.setVoiceBeautifierPreset(.timbreTransformationVigorous)
     // Disables the voice effect.
     agoraKit.setVoiceBeautifierPreset(.voiceBeautifierOff)
     ```
   - Set the voice changer effect, which changes the original voice for fun effects:

     ```swift
     // Changes the loca voice to sound like the Hulk.
     agoraKit.setAudioEffectPreset(.voiceChangerEffectHulk)
     // Disables the voice effect.
     agoraKit.setAudioEffectPreset(.audioEffectOff)
     ```

   - Set the style transformation effect, which makes singing more harmonious for a specific style of songs:

     ```swift
     // Transforms the local voice to the style of pop music.
     agoraKit.setAudioEffectPreset(.styleTransformationPopular)
     // Disables the voice effect.
     agoraKit.setAudioEffectPreset(.audioEffectOff)
     ```
    
   - Set the room acoustics effect, which adds spatial dimensions to the voice:

     ```swift
     // Adds spatial effect to the local voice as if the user is in KTV.
     agoraKit.setAudioEffectPreset(.roomAcousticKTV)
     // Disables the voice effect.
     agoraKit.setAudioEffectPreset(.audioEffectOff)
     ```

   - Set the pitch correction effect, which corrects a singing voice so that the voice better fits the song:

     ```swift
     // Apply pitch correction to the local voice based on the pitch of the natural C major scale.
     agoraKit.setAudioEffectPreset(.pitchCorrection)
     // Disables the voice effect.
     agoraKit.setAudioEffectPreset(.audioEffectOff)
     ```
   - Set the voice conversion effect, which changes the original voice beyond recognition:

     ```swift
     // Set the local voice by making it sound like a gender-neutral voice.
     agoraKit.setVoiceConversionPreset(.voiceChangerNeutral)  
     // Disables voice effects. 
     agoraKit.setVoiceConversionPreset(.voiceConversionOff)
     ```
   
   - Customize the voice effect by adjusting the voice pitch, equalization, and reverberation settings.

     The following code shows how to change the original voice to the Hulk's voice by manaully setting the parameter values:

     ```swift
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

## Reference

Some enumertors in `setVoiceBeautifierPreset`, `setAudioEffectPreset`, and `setVoiceConversionPreset` are gender specific and apply to one gender only. Using them on the other gender can lead to voice distortion. For details, see the API Reference of the following methods:

- [setVoiceBeautifierPreset]()
- [setAudioEffectPreset]()
- [setVoiceConversionPreset]()
- [setAudioEffectParameters]()
- [setVoiceBeautifierParameters]()