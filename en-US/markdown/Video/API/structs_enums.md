C++ API Reference for All Platforms[API Overview](../API/rtc_api_overview_ng.html)[IRtcEngine](../API/class_irtcengine.html#class_irtcengine)[IRtcEngineEx](../API/class_irtcengineex.html#class_irtcengineex)[IRtcEngineEventHandler](../API/class_irtcengineeventhandler.html#class_irtcengineeventhandler)[IMediaPlayer](../API/class_imediaplayer.html#class_imediaplayer)[IAudioEncodedFrameObserver](../API/class_iaudioencodedframeobserver.html#class_iaudioencodedframeobserver)[IAudioDeviceManager](../API/class_iaudiodevicemanager.html#class_iaudiodevicemanager)[IAudioDeviceCollection](../API/class_iaudiodevicecollection.html#class_iaudiodevicecollection)[IVideoDeviceManager](../API/class_ivideodevicemanager.html#class_ivideodevicemanager)[IVideoDeviceCollection](../API/class_ivideodevicecollection.html#class_ivideodevicecollection)[IMediaEngine](../API/class_imediaengine.html#class_imediaengine)[IMediaPlayerCustomDataProvider](../API/class_imediaplayercustomdataprovider.html#class_imediaplayercustomdataprovider)[IMediaPlayerSourceObserver](../API/class_imediaplayersourceobserver.html#class_imediaplayersourceobserver)[IAudioFrameObserver](../API/class_iaudioframeobserver.html#class_iaudioframeobserver)[IAudioFrameObserverBase](../API/class_iaudioframeobserverbase.html#class_iaudioframeobserverbase)[IAudioSpectrumObserver](../API/class_iaudiospectrumobserver.html#class_iaudiospectrumobserver)[IPacketObserver](../API/class_ipacketobserver.html#class_ipacketobserver)[IMetadataObserver](../API/class_imetadataobserver.html#class_imetadataobserver)[IVideoEncodedImageReceiver](../API/class_ivideoencodedimagereceiver.html#class_ivideoencodedimagereceiver)[IVideoFrameObserver](../API/class_ivideoframeobserver.html#class_ivideoframeobserver)[Type definition](../API/rtc_api_data_type.html#rtc_api_data_type)

# Type definition

This page lists all the type definitions of the Windows API.

## [AREA_CODE](rtc_api_data_type.html#enum_areacode)

The region for connection, which is the region where the server the SDK connects to is located.

### Enumerator

- AREA_CODE_CN

  Mainland China.

- AREA_CODE_NA

  North America.

- AREA_CODE_EU

  Europe.

- AREA_CODE_AS

  Asia, excluding Mainland China.

- AREA_CODE_JP

  Japan.

- AREA_CODE_IN

  India.

- AREA_CODE_GLOB

  (Default) Global.

**See also**

- [initialize](../API/class_irtcengine.html#api_create2)

## [AUDIENCE_LATENCY_LEVEL_TYPE](rtc_api_data_type.html#enum_audiencelatencyleveltype)

The latency level of an audience member in interactive live streaming. This enum takes effect only when the user role is set to CLIENT_ROLE_AUDIENCE.

### Enumerator

- AUDIENCE_LATENCY_LEVEL_LOW_LATENCY

  1: Low latency.

- AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY

  2: (Default) Ultra low latency.

**See also**

- [setClientRole [2/2\]](../API/class_irtcengine.html#api_setclientrole2)

## [AUDIO_CODEC_PROFILE_TYPE](rtc_api_data_type.html#enum_audiocodecprofiletype)

The codec type of the output audio stream for CDN live streaming. The default value is LC-ACC.

### Enumerator

- AUDIO_CODEC_PROFILE_LC_AAC

  0: (Default) LC-AAC, which is the low-complexity audio codec type.

- AUDIO_CODEC_PROFILE_HE_AAC

  1: HE-AAC, which is the high-efficiency audio codec type.

**See also**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)

## [AUDIO_CODEC_TYPE](rtc_api_data_type.html#enum_audiocodectype)

The codec type of audio.

### Enumerator

- AUDIO_CODEC_OPUS

  1: OPUS.

- AUDIO_CODEC_PCMA

  3: PCMA.

- AUDIO_CODEC_PCMU

  4: PCMU.

- AUDIO_CODEC_G722

  5: G722.

- AUDIO_CODEC_AACLC

  8: LC-AAC.

- AUDIO_CODEC_HEAAC

  9: HE-AAC.

- AUDIO_CODEC_JC1

  10: JC1.

- AUDIO_CODEC_HEAAC2

  11: HE-AAC v2.

## [AUDIO_DUAL_MONO_MODE](rtc_api_data_type.html#enum_audiodualmonomode)

The channel mode.

### Enumerator

- AUDIO_DUAL_MONO_STEREO

  0: Original mode.

- AUDIO_DUAL_MONO_L

  1: Left channel mode. This mode replaces the audio of the right channel with the audio of the left channel, which means the user can only hear the audio of the left channel.

- AUDIO_DUAL_MONO_R

  2: Right channel mode. This mode replaces the audio of the left channel with the audio of the right channel, which means the user can only hear the audio of the right channel.

- AUDIO_DUAL_MONO_MIX

  3: Mixed channel mode. This mode mixes the audio of the left channel and the right channel, which means the user can hear the audio of the left channel and the right channel at the same time.

**See also**

- [setAudioDualMonoMode](../API/class_imediaplayer.html#api_setaudiodualmonomode)

## [AUDIO_EFFECT_PRESET](rtc_api_data_type.html#enum_audioeffectpreset)

Preset voice effects.

For better voice effects, Agora recommends setting the **profile** parameter of [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) to AUDIO_PROFILE_MUSIC_HIGH_QUALITY or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO before using the following presets:

- ROOM_ACOUSTICS_KTV
- ROOM_ACOUSTICS_VOCAL_CONCERT
- ROOM_ACOUSTICS_STUDIO
- ROOM_ACOUSTICS_PHONOGRAPH
- ROOM_ACOUSTICS_SPACIAL
- ROOM_ACOUSTICS_ETHEREAL
- VOICE_CHANGER_EFFECT_UNCLE
- VOICE_CHANGER_EFFECT_OLDMAN
- VOICE_CHANGER_EFFECT_BOY
- VOICE_CHANGER_EFFECT_SISTER
- VOICE_CHANGER_EFFECT_GIRL
- VOICE_CHANGER_EFFECT_PIGKING
- VOICE_CHANGER_EFFECT_HULK
- PITCH_CORRECTION

### Enumerator

- AUDIO_EFFECT_OFF

  Turn off voice effects, that is, use the original voice.

- ROOM_ACOUSTICS_KTV

  The voice effect typical of a KTV venue.

- ROOM_ACOUSTICS_VOCAL_CONCERT

  The voice effect typical of a concert hall.

- ROOM_ACOUSTICS_STUDIO

  The voice effect typical of a recording studio.

- ROOM_ACOUSTICS_PHONOGRAPH

  The voice effect typical of a vintage phonograph.

- ROOM_ACOUSTICS_VIRTUAL_STEREO

  The virtual stereo effect, which renders monophonic audio as stereo audio.**Note** Before using this preset, set the **profile** parameter of [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) to AUDIO_PROFILE_MUSIC_HIGH_QUALITY or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO; otherwise, the preset setting is invalid.

- ROOM_ACOUSTICS_SPACIAL

  A more spatial voice effect.

- ROOM_ACOUSTICS_ETHEREAL

  A more ethereal voice effect.

- ROOM_ACOUSTICS_3D_VOICE

  A 3D voice effect that makes the voice appear to be moving around the user. The default movement cycle is 10 seconds. After setting this effect, you can call [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters) to modify the movement period.**Note**Before using this preset, set the **profile** parameter of [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) to AUDIO_PROFILE_MUSIC_STANDARD_STEREO or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO; otherwise, the preset setting is invalid.If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.

- VOICE_CHANGER_EFFECT_UNCLE

  A middle-aged man's voice.**Note** Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.

- VOICE_CHANGER_EFFECT_OLDMAN

  A senior man's voice.**Note** Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.

- VOICE_CHANGER_EFFECT_BOY

  A boy's voice.**Note** Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.

- VOICE_CHANGER_EFFECT_SISTER

  A young woman's voice.**Note** Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.

- VOICE_CHANGER_EFFECT_GIRL

  A girl's voice.**Note** Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.

- VOICE_CHANGER_EFFECT_PIGKING

  The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.

- VOICE_CHANGER_EFFECT_HULK

  The Hulk's voice.

- STYLE_TRANSFORMATION_RNB

  The voice effect typical of R&B music.**Note** Before using this preset, set the **profile** parameter of [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) to AUDIO_PROFILE_MUSIC_HIGH_QUALITY or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO; otherwise, the preset setting is invalid.

- STYLE_TRANSFORMATION_POPULAR

  The voice effect typical of popular music.**Note** Before using this preset, set the **profile** parameter of [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) to AUDIO_PROFILE_MUSIC_HIGH_QUALITY or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO; otherwise, the preset setting is invalid.

- PITCH_CORRECTION

  A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. After setting this voice effect, you can call [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters) to adjust the basic mode of tuning and the pitch of the main tone.

**See also**

- [setAudioEffectPreset](../API/class_irtcengine.html#api_setaudioeffectpreset)

## [AUDIO_ENCODED_FRAME_OBSERVER_POSITION](rtc_api_data_type.html#enum_audioencodedframeobserverposition)

Audio profile.

### Enumerator

- AUDIO_ENCODED_FRAME_OBSERVER_POSITION_RECORD

  1: Only records the audio of the local user.

- AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK

  2: Only records the audio of all remote users.

- AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIXED

  3: Records the mixed audio of the local and all remote users.

**See also**

- [OnPlaybackAudioEncodedFrame](../API/class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onplaybackaudioencodedframe)
- [OnRecordAudioEncodedFrame](../API/class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onrecordaudioencodedframe)
- [OnMixedAudioEncodedFrame](../API/class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onmixedaudioencodedframe)

## [AUDIO_ENCODING_TYPE](rtc_api_data_type.html#enum_audioencodingtype)

Audio encoding type.

### Enumerator

- AUDIO_ENCODING_TYPE_AAC_16000_LOW

  AAC encoding format, 16000 Hz sampling rate, bass quality. A file with an audio duration of 10 minutes is approximately 1.2 MB after encoding.

- AUDIO_ENCODING_TYPE_AAC_16000_MEDIUM

  AAC encoding format, 16000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.

- AUDIO_ENCODING_TYPE_AAC_32000_LOW

  AAC encoding format, 32000 Hz sampling rate, bass quality. A file with an audio duration of 10 minutes is approximately 1.2 MB after encoding.

- AUDIO_ENCODING_TYPE_AAC_32000_MEDIUM

  AAC encoding format, 32000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.

- AUDIO_ENCODING_TYPE_AAC_32000_HIGH

  AAC encoding format, 32000 Hz sampling rate, high sound quality. A file with an audio duration of 10 minutes is approximately 3.5 MB after encoding.

- AUDIO_ENCODING_TYPE_AAC_48000_MEDIUM

  AAC encoding format, 48000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.

- AUDIO_ENCODING_TYPE_AAC_48000_HIGH

  AAC encoding format, 48000 Hz sampling rate, high sound quality. A file with an audio duration of 10 minutes is approximately 3.5 MB after encoding.

- AUDIO_ENCODING_TYPE_OPUS_16000_LOW

  OPUS encoding format, 16000 Hz sampling rate, bass quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.

- AUDIO_ENCODING_TYPE_OPUS_16000_MEDIUM

  OPUS encoding format, 16000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.

- AUDIO_ENCODING_TYPE_OPUS_48000_MEDIUM

  OPUS encoding format, 48000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.

- AUDIO_ENCODING_TYPE_OPUS_48000_HIGH

  OPUS encoding format, 48000 Hz sampling rate, high sound quality. A file with an audio duration of 10 minutes is approximately 3.5 MB after encoding.

## [AUDIO_EQUALIZATION_BAND_FREQUENCY](rtc_api_data_type.html#enum_audioequalizationbandfrequency)

The midrange frequency for audio equalization.

### Enumerator

- AUDIO_EQUALIZATION_BAND_31

  0: 31 Hz

- AUDIO_EQUALIZATION_BAND_62

  1: 62 Hz

- AUDIO_EQUALIZATION_BAND_125

  2: 125 Hz

- AUDIO_EQUALIZATION_BAND_250

  3: 250 Hz

- AUDIO_EQUALIZATION_BAND_500

  4: 500 Hz

- AUDIO_EQUALIZATION_BAND_1K

  5: 1 kHz

- AUDIO_EQUALIZATION_BAND_2K

  6: 2 kHz

- AUDIO_EQUALIZATION_BAND_4K

  7: 4 kHz

- AUDIO_EQUALIZATION_BAND_8K

  8: 8 kHz

- AUDIO_EQUALIZATION_BAND_16K

  9: 16 kHz

**See also**

- [setLocalVoiceEqualization](../API/class_irtcengine.html#api_setlocalvoiceequalization)

## [AUDIO_FRAME_TYPE](rtc_api_data_type.html#enum_audioframetype)

Audio frame type.

### Enumerator

- FRAME_TYPE_PCM16

  0: PCM 16

**See also**

- [pullAudioFrame](../API/class_imediaengine.html#api_imediaengine_pullaudioframe)
- [onRecordAudioFrame](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onrecordaudioframe)
- [onPlaybackAudioFrame](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframe)
- [onPlaybackAudioFrameBeforeMixing](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframebeforemixing)
- [onMixedAudioFrame](../API/class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onmixedaudioframe)

## [AUDIO_RECORDING_POSITION](rtc_api_data_type.html#enum_audiorecordingposition)

Recording content. Set in [startAudioRecording](class_irtcengine.html#api_startaudiorecording3_ng).



### Enumerator

- AUDIO_RECORDING_POSITION_MIXED_RECORDING_AND_PLAYBACK

  0: (Default) Records the mixed audio of the local and all remote users.

- AUDIO_RECORDING_POSITION_RECORDING

  1: Only records the audio of the local user.

- AUDIO_RECORDING_POSITION_MIXED_PLAYBACK

  2: Only records the audio of all remote users.

**See also**

- [startAudioRecording](../API/class_irtcengine.html#api_startaudiorecording3_ng)

## [AUDIO_MIXING_ERROR_TYPE](rtc_api_data_type.html#enum_audiomixingerrortype)

Errors that might occur when playing a music file.

- Deprecated:

  Deprecated as of v3.4.0.

### Enumerator

- AUDIO_MIXING_ERROR_CAN_NOT_OPEN

  The SDK cannot open the music file.

- AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL

  The SDK opens the music file too frequently.

- AUDIO_MIXING_ERROR_INTERRUPTED_EOF

  The playback of the music file is interrupted.

- AUDIO_MIXING_ERROR_OK

  The music file is playing.

## [AUDIO_MIXING_REASON_TYPE](rtc_api_data_type.html#enum_audiomixingreasontype)

The reason why the playback state of the music file changes. Reported in the [onAudioMixingStateChanged](class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng) callback.

- Since

  v3.4.0

### Enumerator

- AUDIO_MIXING_REASON_CAN_NOT_OPEN

  701: The SDK cannot open the music file. For example, the local music file does not exist, the SDK does not support the file format, or the SDK cannot access the music file URL.

- AUDIO_MIXING_REASON_TOO_FREQUENT_CALL

  702: The SDK opens the music file too frequently. If you need to call startAudioMixing multiple times, ensure that the call interval is more than 500 ms.

- AAUDIO_MIXING_REASON_INTERRUPTED_EOF

  703: The music file playback is interrupted.

- AUDIO_MIXING_REASON_STARTED_BY_USER

  720: The method call of startAudioMixing to play music files succeeds.

- AUDIO_MIXING_REASON_ONE_LOOP_COMPLETED

  721: The music file completes a loop playback.

- AUDIO_MIXING_REASON_START_NEW_LOOP

  722: The music file starts a new loop playback.

- AUDIO_MIXING_REASON_ALL_LOOPS_COMPLETED

  723: The music file completes all loop playbacks.

- AUDIO_MIXING_REASON_STOPPED_BY_USER

  724: The method call of [stopAudioMixing](class_irtcengine.html#api_stopaudiomixing) to stop playing the music file succeeds.

- AUDIO_MIXING_REASON_PAUSED_BY_USER

  725: The method call of [pauseAudioMixing](class_irtcengine.html#api_pauseaudiomixing) to pause playing the music file succeeds.

- AUDIO_MIXING_REASON_RESUMED_BY_USER

  726: The method call of [resumeAudioMixing](class_irtcengine.html#api_resumeaudiomixing) to resume playing the music file succeeds.

## [AUDIO_MIXING_STATE_TYPE](rtc_api_data_type.html#enum_audiomixingstatetype)

The playback state of the music file.

### Enumerator

- AUDIO_MIXING_STATE_PLAYING

  710: The music file is playing.

- AUDIO_MIXING_STATE_PAUSED

  711: The music file pauses playing.

- AUDIO_MIXING_STATE_STOPPED

  713: The music file stops playing.

- AUDIO_MIXING_STATE_FAILED

  714: An error occurs during the playback of the audio mixing file.

- AUDIO_MIXING_STATE_COMPLETED

  (715): The music file is played once.

- AUDIO_MIXING_STATE_ALL_LOOPS_COMPLETED

  (716): The music file is all played out.

**See also**

- [onAudioMixingStateChanged](../API/class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng)

## [AUDIO_PROFILE_TYPE](rtc_api_data_type.html#enum_audioprofiletype)

The audio profile.

### Enumerator

- AUDIO_PROFILE_DEFAULT

  0: The default audio profile.For the interactive streaming profile: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.For the communication profile:Windows: A sample rate of 16 kHz, audio encoding, mono, and a bitrate of up to 16 Kbps.Android/macOS/iOS: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.

- AUDIO_PROFILE_SPEECH_STANDARD

  1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.

- AUDIO_PROFILE_MUSIC_STANDARD

  2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.

- AUDIO_PROFILE_MUSIC_STANDARD_STEREO

  3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps.

- AUDIO_PROFILE_MUSIC_HIGH_QUALITY

  4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.

- AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO

  5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.

- AUDIO_PROFILE_IOT

  6: A sample rate of 16 kHz, audio encoding, mono, and Acoustic Echo Cancellation (AES) enabled.

**See also**

- [setAudioProfile [1/2\]](../API/class_irtcengine.html#api_setaudioprofile)
- [setAudioProfile [2/2\]](../API/class_irtcengine.html#api_setaudioprofile2)

## [AUDIO_RECORDING_QUALITY_TYPE](rtc_api_data_type.html#enum_audiorecordingqualitytype)

Recording quality.

### Enumerator

- AUDIO_RECORDING_QUALITY_LOW

  0: Low quality. The sample rate is 32 kHz, and the file size is around 1.2 MB for 10 minutes of recording.

- AUDIO_RECORDING_QUALITY_MEDIUM

  1: Medium quality. The sample rate is 32 kHz, and the file size is around 2 MB for 10 minutes of recording.

- AUDIO_RECORDING_QUALITY_HIGH

  2: High quality. The sample rate is 32 kHz, and the file size is around 3.75 MB for 10 minutes of recording.

**See also**

- [startAudioRecording](../API/class_irtcengine.html#api_startaudiorecording3_ng)

## [AUDIO_REVERB_PRESET](rtc_api_data_type.html#enum_audioreverbpreset)

Voice reverb presets.



### Enumerator

- AUDIO_REVERB_OFF

  Turn off voice reverb, that is, to use the original voice.

- AUDIO_REVERB_FX_KTV

  The reverb style typical of a KTV venue (enhanced).

- AUDIO_REVERB_FX_VOCAL_CONCERT

  The reverb style typical of a concert hall (enhanced).

- AUDIO_REVERB_FX_UNCLE

  A middle-aged man's voice.

- AUDIO_REVERB_FX_SISTER

  The reverb style typical of a young woman's voice.

- AUDIO_REVERB_FX_STUDIO

  The reverb style typical of a recording studio (enhanced).

- AUDIO_REVERB_FX_POPULAR

  The reverb style typical of popular music (enhanced).

- AUDIO_REVERB_FX_RNB

  The reverb style typical of R&B music (enhanced).

- AUDIO_REVERB_FX_PHONOGRAPH

  The voice effect typical of a vintage phonograph.

**See also**

- [setLocalVoiceReverbPreset](../API/class_irtcengine.html#api_setlocalvoicereverbpreset)

## [AUDIO_REVERB_TYPE](rtc_api_data_type.html#enum_audioreverbtype)

Audio reverberation types.

### Enumerator

- AUDIO_REVERB_DRY_LEVEL

  0: The level of the dry signal (dB). The value is between -20 and 10.

- AUDIO_REVERB_WET_LEVEL

  1: The level of the early reflection signal (wet signal) (dB). The value is between -20 and 10.

- AUDIO_REVERB_ROOM_SIZE

  2: The room size of the reflection. The value is between 0 and 100.

- AUDIO_REVERB_WET_DELAY

  3: The length of the initial delay of the wet signal (ms). The value is between 0 and 200.

- AUDIO_REVERB_STRENGTH

  4: The reverberation strength. The value is between 0 and 100.

**See also**

- [setLocalVoiceReverb](../API/class_irtcengine.html#api_setlocalvoicereverb)

## [AUDIO_ROUTE_TYPE](rtc_api_data_type.html#enum_audioroutetype)

The type of the audio route.

### Enumerator

- AUDIO_ROUTE_DEFAULT

  -1: The default audio route.

- AUDIO_ROUTE_HEADSET

  0: The headset.

- AUDIO_ROUTE_EARPIECE

  1: The earpiece.

- AUDIO_ROUTE_HEADSET_NO_MIC

  2: The headset with no microphone.

- AUDIO_ROUTE_SPEAKERPHONE

  3: The built-in speaker on a mobile device.

- AUDIO_ROUTE_LOUDSPEAKER

  4: The external speaker.

- AUDIO_ROUTE_BLUETOOTH

  5: The bluetooth headset.

**See also**

- [onAudioRoutingChanged](../API/class_irtcengineeventhandler.html#callback_onaudioroutechanged)

## [AUDIO_SAMPLE_RATE_TYPE](rtc_api_data_type.html#enum_audiosampleratetype)

The audio sampling rate of the stream to be pushed to the CDN.

### Enumerator

- AUDIO_SAMPLE_RATE_32000

  32000: 32 kHz

- AUDIO_SAMPLE_RATE_44100

  44100: 44.1 kHz

- AUDIO_SAMPLE_RATE_48000

  48000: (Default) 48 kHz

**See also**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)

## [AUDIO_SCENARIO_TYPE](rtc_api_data_type.html#enum_audioscenariotype_ng)

The audio scenario.

### Enumerator

- AUDIO_SCENARIO_DEFAULT

  0: (Default) Automatic scenario match, where the SDK chooses the appropriate audio quality according to the user role and audio route.

- AUDIO_SCENARIO_GAME_STREAMING

  3: High-quality audio scenario, where users mainly play music.

- AUDIO_SCENARIO_HIGH_DEFINITION

  6: High-quality audio scenario, where users mainly play music.

- AUDIO_SCENARIO_CHORUS

  7: Real-time chorus scenario, where users have good network conditions and require ultra-low latency.

- AUDIO_SCENARIO_NUM

  The number of enumerations.

**See also**

- [setAudioProfile [1/2\]](../API/class_irtcengine.html#api_setaudioprofile)

## [AUDIO_SESSION_OPERATION_RESTRICTION](rtc_api_data_type.html#enum_audiosessionoperationrestriction)

The operational permission of the SDK on the audio session.

### Enumerator

- AUDIO_SESSION_OPERATION_RESTRICTION_NONE

  No restriction, the SDK has full control of the audio session operations.

- AUDIO_SESSION_OPERATION_RESTRICTION_SET_CATEGORY

  The SDK does not change the audio session category.

- AUDIO_SESSION_OPERATION_RESTRICTION_CONFIGURE_SESSION

  The SDK does not change any setting of the audio session (category, mode, categoryOptions).

- AUDIO_SESSION_OPERATION_RESTRICTION_DEACTIVATE_SESSION

  The SDK keeps the audio session active when leaving a channel.

- AUDIO_SESSION_OPERATION_RESTRICTION_ALL

  The SDK does not configure the audio session anymore.

## [CAMERA_DIRECTION](rtc_api_data_type.html#enum_cameradirection)

The camera direction.

### Enumerator

- CAMERA_REAR

  The rear camera.

- CAMERA_FRONT

  The front camera.

**See also**

- [setCameraCapturerConfiguration](../API/class_irtcengine.html#api_setcameracapturerconfiguration)

## [CAPTURE_BRIGHTNESS_LEVEL_TYPE](rtc_api_data_type.html#enum_capturebrightnessleveltype)

The brightness level of the video image captured by the local camera.



### Enumerator

- CAPTURE_BRIGHTNESS_LEVEL_INVALID

  -1: The SDK does not detect the brightness level of the video image. Wait a few seconds to get the brightness level from **captureBrightnessLevel** in the next callback.

- CAPTURE_BRIGHTNESS_LEVEL_NORMAL

  0: The brightness level of the video image is normal.

- CAPTURE_BRIGHTNESS_LEVEL_BRIGHT

  1: The brightness level of the video image is too bright.

- CAPTURE_BRIGHTNESS_LEVEL_DARK

  2: The brightness level of the video image is too dark.

## [CAPTURER_OUTPUT_PREFERENCE](rtc_api_data_type.html#enum_captureroutputpreference)

Camera capture preference.

### Enumerator

- CAPTURER_OUTPUT_PREFERENCE_AUTO

  0: (Default) Automatically adjust the camera capture preference. The SDK adjusts the camera output parameters according to the system performance and network conditions to balance CPU consumption and video preview quality.

- CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE

  1: Prioritizes the system performance. The SDK chooses the dimension and frame rate of the local camera capture closest to those set by [setVideoEncoderConfiguration](class_irtcengine.html#api_setvideoencoderconfiguration). In this case, the local preview quality depends on the encoder.

- CAPTURER_OUTPUT_PREFERENCE_PREVIEW

  2: Prioritizes the local preview quality. The SDK chooses higher camera output parameters to improve the local video preview quality. This option requires extra CPU and RAM usage for video pre-processing.

- CAPTURER_OUTPUT_PREFERENCE_MANUAL

  3: Allows you to customize the width and height of the video image captured by the local camera.

**See also**

- [setCameraCapturerConfiguration](../API/class_irtcengine.html#api_setcameracapturerconfiguration)

## [CHANNEL_MEDIA_RELAY_ERROR](rtc_api_data_type.html#enum_channelmediarelayerror)

The error code of the channel media replay.

### Enumerator

- RELAY_OK

  0: No error.

- RELAY_ERROR_SERVER_ERROR_RESPONSE

  1: An error occurs in the server response.

- RELAY_ERROR_SERVER_NO_RESPONSE

  2: No server response.You can call [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) to leave the channel.This error can also occur if your project has not enabled co-host token authentication. Contact [support@agora.io](mailto:support@agora.io) to enable the co-host token authentication service before starting a channel media relay.

- RELAY_ERROR_NO_RESOURCE_AVAILABLE

  3: The SDK fails to access the service, probably due to limited resources of the server.

- RELAY_ERROR_FAILED_JOIN_SRC

  4: Fails to send the relay request.

- RELAY_ERROR_FAILED_JOIN_DEST

  5: Fails to accept the relay request.

- RELAY_ERROR_FAILED_PACKET_RECEIVED_FROM_SRC

  6: The server fails to receive the media stream.

- RELAY_ERROR_FAILED_PACKET_SENT_TO_DEST

  7: The server fails to send the media stream.

- RELAY_ERROR_SERVER_CONNECTION_LOST

  8: The SDK disconnects from the server due to poor network connections. You can call the [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) method to leave the channel.

- RELAY_ERROR_INTERNAL_ERROR

  9: An internal error occurs in the server.

- RELAY_ERROR_SRC_TOKEN_EXPIRED

  10: The token of the source channel has expired.

- RELAY_ERROR_DEST_TOKEN_EXPIRED

  11: The token of the destination channel has expired.

**See also**

- [onChannelMediaRelayStateChanged](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged)

## [CHANNEL_MEDIA_RELAY_EVENT](rtc_api_data_type.html#enum_channelmediarelayevent)

The event code of channel media relay.

### Enumerator

- RELAY_EVENT_NETWORK_DISCONNECTED

  0: The user disconnects from the server due to a poor network connection.

- RELAY_EVENT_NETWORK_CONNECTED

  1: The user is connected to the server.

- RELAY_EVENT_PACKET_JOINED_SRC_CHANNEL

  2: The user joins the source channel.

- RELAY_EVENT_PACKET_JOINED_DEST_CHANNEL

  3: The user joins the destination channel.

- RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL

  4: The SDK starts relaying the media stream to the destination channel.

- RELAY_EVENT_PACKET_RECEIVED_VIDEO_FROM_SRC

  5: The server receives the audio stream from the source channel.

- RELAY_EVENT_PACKET_RECEIVED_AUDIO_FROM_SRC

  6: The server receives the audio stream from the source channel.

- RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL

  7: The destination channel is updated.

- RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED

  8: The destination channel update fails due to internal reasons.

- RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_NOT_CHANGE

  9: The destination channel does not change, which means that the destination channel fails to be updated.

- RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_IS_NULL

  10: The destination channel name is `NULL`.

- RELAY_EVENT_VIDEO_PROFILE_UPDATE

  11: The video profile is sent to the server.

- RELAY_EVENT_PAUSE_SEND_PACKET_TO_DEST_CHANNEL_SUCCESS

  12: The SDK successfully pauses relaying the media stream to destination channels.

- RELAY_EVENT_PAUSE_SEND_PACKET_TO_DEST_CHANNEL_FAILED

  13: The SDK fails to pause relaying the media stream to destination channels.

- RELAY_EVENT_RESUME_SEND_PACKET_TO_DEST_CHANNEL_SUCCESS

  14: The SDK successfully resumes relaying the media stream to destination channels.

- RELAY_EVENT_RESUME_SEND_PACKET_TO_DEST_CHANNEL_FAILED

  15: The SDK fails to resume relaying the media stream to destination channels.

**See also**

- [onChannelMediaRelayEvent](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelayevent)

## [CHANNEL_MEDIA_RELAY_STATE](rtc_api_data_type.html#enum_channelmediarelaystate)

The state code of the channel media relay.

### Enumerator

- RELAY_STATE_IDLE

  0: The initial state. After you successfully stop the channel media relay by calling [stopChannelMediaRelay](class_irtcengine.html#api_stopchannelmediarelay), the [onChannelMediaRelayStateChanged](class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged) callback returns this state.

- RELAY_STATE_CONNECTING

  1: The SDK tries to relay the media stream to the destination channel.

- RELAY_STATE_RUNNING

  2: The SDK successfully relays the media stream to the destination channel.

- RELAY_STATE_FAILURE

  3: An error occurs. See **code** in [onChannelMediaRelayStateChanged](class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged) for the error code.

**See also**

- [onChannelMediaRelayStateChanged](../API/class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged)

## [CHANNEL_PROFILE_TYPE](rtc_api_data_type.html#enum_channelprofiletype_ng)

The channel profile.

### Enumerator

- CHANNEL_PROFILE_COMMUNICATION

  0: Communication. Use this profile of there are only two users in the channel.

- CHANNEL_PROFILE_LIVE_BROADCASTING

  1: Live streaming. Live streaming. Use this profile when there are more than two users in the channel.

- CHANNEL_PROFILE_GAME

  2: Gaming. This profile is deprecated.

- CHANNEL_PROFILE_CLOUD_GAMING

  Cloud gaming. The scenario is optimized for latency. Use this profile if the use case requires frequent interactions between users.

**See also**

- [setChannelProfile](../API/class_irtcengine.html#api_setchannelprofile)

## [CLIENT_ROLE_TYPE](rtc_api_data_type.html#enum_clientroletype)

The user role in the interactive live streaming.

### Enumerator

- CLIENT_ROLE_BROADCASTER

  1: Host. A host can both send and receive streams.

- CLIENT_ROLE_AUDIENCE

  2: (Default) Audience. An audience member can only receive streams.

**See also**

- [setClientRole [1/2\]](../API/class_irtcengine.html#api_setclientrole)
- [setClientRole [2/2\]](../API/class_irtcengine.html#api_setclientrole2)
- [onClientRoleChanged](../API/class_irtcengineeventhandler.html#callback_onclientrolechanged)

## [CLOUD_PROXY_TYPE](rtc_api_data_type.html#enum_cloudproxytype)

The cloud proxy type.



### Enumerator

- NONE_PROXY

  0: Do not use cloud proxy.

- UDP_PROXY

  1: Use cloud proxy with the UDP protocol.

## [CONNECTION_CHANGED_REASON_TYPE](rtc_api_data_type.html#enum_connectionchangedreasontype)

Reasons causing the change of the connection state.

### Enumerator

- CONNECTION_CHANGED_CONNECTING

  0: The SDK is connecting to the Agora edge server.

- CONNECTION_CHANGED_JOIN_SUCCESS

  1: The SDK has joined the channel successfully.

- CONNECTION_CHANGED_INTERRUPTED

  2: The connection between the SDK and the Agora edge server is interrupted.

- CONNECTION_CHANGED_BANNED_BY_SERVER

  3: The connection between the SDK and the Agora edge server is banned by the Agora edge server. This error occurs when the user is kicked out of the channel by the server.

- CONNECTION_CHANGED_JOIN_FAILED

  4: The SDK fails to join the channel. When the SDK fails to join the channel for more than 20 minutes, this error occurs and the SDK stops reconnecting to the channel.

- CONNECTION_CHANGED_LEAVE_CHANNEL

  5: The SDK has left the channel.

- CONNECTION_CHANGED_INVALID_APP_ID

  6: The connection failed because the App ID is not valid. Please rejoin the channel with a valid App ID.

- CONNECTION_CHANGED_INVALID_CHANNEL_NAME

  7: The connection failed since channel name is not valid. Please rejoin the channel with a valid channel name.

- CONNECTION_CHANGED_INVALID_TOKEN

  8: The connection failed because the token is not valid. Typical reasons include:The App Certificate for the project is enabled in Agora Console, but you do not use a token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.The uid specified when calling joinChannel [2/2] to join the channel is inconsistent with the uid passed in when generating the token.

- CONNECTION_CHANGED_TOKEN_EXPIRED

  9: The connection failed since token is expired.

- CONNECTION_CHANGED_REJECTED_BY_SERVER

  10: The connection is rejected by server. Typical reasons include:The user is already in the channel and still calls a method, for example, joinChannel [2/2], to join the channel. Stop calling this method to clear this error.The user tries to join the channel when conducting a pre-call test. The user needs to call the channel after the call test ends.

- CONNECTION_CHANGED_SETTING_PROXY_SERVER

  11: The connection state changed to reconnecting because the SDK has set a proxy server.

- CONNECTION_CHANGED_RENEW_TOKEN

  12: The connection state changed because the token is renewed.

- CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED

  13: The IP address of the client has changed, possibly because the network type, IP address, or port has been changed.

- CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT

  14: Timeout for the keep-alive of the connection between the SDK and the Agora edge server. The connection state changes to CONNECTION_STATE_RECONNECTING.

**See also**

- [onConnectionStateChanged](../API/class_irtcengineeventhandler.html#callback_onconnectionstatechanged)

## [CONNECTION_STATE_TYPE](rtc_api_data_type.html#enum_connectionstatetype)

Connection states.

### Enumerator

- CONNECTION_STATE_DISCONNECTED

  1: The SDK is disconnected from the Agora edge server. The state indicates the SDK is in one of the following phases:The initial state before calling the joinChannel [2/2] method.The app calls the [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) method.

- CONNECTION_STATE_CONNECTING

  2: The SDK is connecting to the Agora edge server. This state indicates that the SDK is establishing a connection with the specified channel after the app calls joinChannel [2/2].If the SDK successfully joins the channel, it triggers the [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callback and the connection state switches to CONNECTION_STATE_CONNECTED.After the connection is established, the SDK also initializes the media and triggers [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess) when everything is ready.

- CONNECTION_STATE_CONNECTED

  3: The SDK is connected to the Agora edge server. This state also indicates that the user has joined a channel and can now publish or subscribe to a media stream in the channel. If the connection to the Agora edge server is lost because, for example, the network is down or switched, the SDK automatically tries to reconnect and triggers [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) that indicates the connection state switches to CONNECTION_STATE_RECONNECTING.

- CONNECTION_STATE_RECONNECTING

  4: The SDK keeps reconnecting to the Agora edge server. The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.If the SDK cannot rejoin the channel within 10 seconds, it triggers [onConnectionLost](class_irtcengineeventhandler.html#callback_onconnectionlost), stays in the CONNECTION_STATE_RECONNECTING state, and keeps rejoining the channel.If the SDK fails to rejoin the channel 20 minutes after being disconnected from the Agora edge server, the SDK triggers the [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callback, switches to the CONNECTION_STATE_FAILED state, and stops rejoining the channel.

- CONNECTION_STATE_FAILED

  5: The SDK fails to connect to the Agora edge server or join the channel. This state indicates that the SDK stops trying to rejoin the channel. You must call [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) to leave the channel.You can call joinChannel [2/2] to rejoin the channel.If the SDK is banned from joining the channel by the Agora edge server through the RESTful API, the SDK triggers the [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callback.

**See also**

- [getConnectionStateEx](../API/class_irtcengineex.html#api_irtcengineex_getconnectionstateex)
- [onConnectionStateChanged](../API/class_irtcengineeventhandler.html#callback_onconnectionstatechanged)

## [DEGRADATION_PREFERENCE](rtc_api_data_type.html#enum_degradationpreference)

Video degradation preferences when the bandwidth is a constraint.

### Enumerator

- MAINTAIN_QUALITY

  0: (Default) Prefers to reduce the video frame rate while maintaining video quality during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.**Note** In the COMMUNICATION channel profile, the resolution of the video sent may change, so remote users need to handle this issue. See [onVideoSizeChanged](class_irtcengineeventhandler.html#callback_onvideosizechanged).

- MAINTAIN_FRAMERATE

  1: Prefers to reduce the video quality while maintaining the video frame rate during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where smoothness is prioritized and video quality is allowed to be reduced.

- MAINTAIN_BALANCED

  2: Reduces the video frame rate and video quality simultaneously during video encoding under limited bandwidth. MAINTAIN_BALANCED has a lower reduction than MAINTAIN_QUALITY and MAINTAIN_FRAMERATE, and this preference is suitable for scenarios where both smoothness and video quality are a priority.**Note** The resolution of the video sent may change, so remote users need to handle this issue. See [onVideoSizeChanged](class_irtcengineeventhandler.html#callback_onvideosizechanged).

**See also**

- [setVideoEncoderConfiguration](../API/class_irtcengine.html#api_setvideoencoderconfiguration)

## [EAR_MONITORING_FILTER_TYPE](rtc_api_data_type.html#enum_earmonitoringfiltertype)

The audio filter of in-ear monitoring:

### Enumerator

- EAR_MONITORING_FILTER_NONE

  1: Do not add an audio filter to the in-ear monitor.

- EAR_MONITORING_FILTER_BUILT_IN_AUDIO_FILTERS

  2: Add an audio filter to the in-ear monitor. If you implement functions such as voice beautifier and audio effect, users can hear the voice after adding these effects.

- EAR_MONITORING_FILTER_NOISE_SUPPRESSION

  4: Enable noise suppression to the in-ear monitor.

**See also**

- [enableInEarMonitoring](../API/class_irtcengine.html#api_enableinearmonitoring2)

## [ENCRYPTION_ERROR_TYPE](rtc_api_data_type.html#enum_encryptionerrortype)

Encryption error type.

### Enumerator

- ENCRYPTION_ERROR_INTERNAL_FAILURE

  0: Internal reason.

- ENCRYPTION_ERROR_DECRYPTION_FAILURE

  1: Decryption errors. Ensure that the receiver and the sender use the same encryption mode and key.

- ENCRYPTION_ERROR_ENCRYPTION_FAILURE

  2: Encryption errors.

**See also**

- [onEncryptionError](../API/class_irtcengineeventhandler.html#callback_onencryptionerror)

## [ENCRYPTION_MODE](rtc_api_data_type.html#enum_encryptionmode)

The built-in encryption mode.

Agora recommends using AES_128_GCM2 or AES_256_GCM2 encrypted mode. These two modes support the use of salt for higher security.

### Enumerator

- AES_128_XTS

  1: 128-bit AES encryption, XTS mode.

- AES_128_ECB

  2: 128-bit AES encryption, ECB mode.

- AES_256_XTS

  3: 256-bit AES encryption, XTS mode.

- SM4_128_ECB

  4: 128-bit SM4 encryption, ECB mode.

- AES_128_GCM

  5: 128-bit AES encryption, GCM mode.

- AES_256_GCM

  6: 256-bit AES encryption, GCM mode.

- AES_128_GCM2

  7: (Default) 128-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (`encryptionKdfSalt`).

- AES_256_GCM2

  8: 256-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (`encryptionKdfSalt`).

- MODE_END

  Enumerator boundary.

**See also**

- [enableEncryption](../API/class_irtcengine.html#api_enableencryption)

## [EXPERIENCE_POOR_REASON](rtc_api_data_type.html#enum_experiencepoorreason)

Reasons why the QoE of the local user when receiving a remote audio stream is poor.



### Enumerator

- EXPERIENCE_REASON_NONE

  0: No reason, indicating a good QoE of the local user.

- REMOTE_NETWORK_QUALITY_POOR

  1: The remote user's network quality is poor.

- LOCAL_NETWORK_QUALITY_POOR

  2: The local user's network quality is poor.

- WIRELESS_SIGNAL_POOR

  4: The local user's Wi-Fi or mobile network signal is weak.

- WIFI_BLUETOOTH_COEXIST

  8: The local user enables both Wi-Fi and bluetooth, and their signals interfere with each other. As a result, audio transmission quality is undermined.

## [EXPERIENCE_QUALITY_TYPE](rtc_api_data_type.html#enum_experiencequalitytype)

The Quality of Experience (QoE) of the local user when receiving a remote audio stream.



### Enumerator

- EXPERIENCE_QUALITY_GOOD

  0: The QoE of the local user is good.

- EXPERIENCE_QUALITY_BAD

  1: The QoE of the local user is poor.

## [EXTERNAL_VIDEO_SOURCE_TYPE](rtc_api_data_type.html#enum_externalvideosourcetype)

The external video frame encoding type.

### Enumerator

- VIDEO_FRAME

  0: The video frame is not encoded.

- ENCODED_VIDEO_FRAME

  1: The video frame is encoded.

## [FRAME_RATE](rtc_api_data_type.html#enum_framerate)

Video frame rate.

### Enumerator

- FRAME_RATE_FPS_1

  1: 1 fps

- FRAME_RATE_FPS_7

  7: 7 fps

- FRAME_RATE_FPS_10

  10: 10 fps

- FRAME_RATE_FPS_15

  15: 15 fps

- FRAME_RATE_FPS_24

  24: 24 fps

- FRAME_RATE_FPS_30

  30: 30 fps

- FRAME_RATE_FPS_60

  60: 60 fps**Note** (For Windows and macOS only)

**See also**

- [setVideoEncoderConfiguration](../API/class_irtcengine.html#api_setvideoencoderconfiguration)

## [INJECT_STREAM_STATUS](rtc_api_data_type.html#enum_injectstreamstatus)

States of importing an external video stream in the interactive live streaming.

### Enumerator

- INJECT_STREAM_STATUS_START_SUCCESS

  0: The external video stream is imported successfully.

- INJECT_STREAM_STATUS_START_ALREADY_EXISTS

  1: The external video stream already exists.

- INJECT_STREAM_STATUS_START_UNAUTHORIZED

  2: The external video stream to be imported is unauthorized.

- INJECT_STREAM_STATUS_START_TIMEDOUT

  3: A timeout occurs when importing the external video stream.

- INJECT_STREAM_STATUS_START_FAILED

  4: The SDK fails to import the external video stream.

- INJECT_STREAM_STATUS_STOP_SUCCESS

  5: The SDK successfully stops importing the external video stream.

- INJECT_STREAM_STATUS_STOP_NOT_FOUND

  6: The external video stream to be stopped importing is not found.

- INJECT_STREAM_STATUS_STOP_UNAUTHORIZED

  7: The external video stream to be stopped importing is unauthorized.

- INJECT_STREAM_STATUS_STOP_TIMEDOUT

  8: A timeout occurs when stopping importing the external video stream.

- INJECT_STREAM_STATUS_STOP_FAILED

  9: The SDK fails to stop importing the external video stream.

- INJECT_STREAM_STATUS_BROKEN

  10: The external video stream is corrupted.

## [INTERFACE_ID_TYPE](rtc_api_data_type.html#enum_interfaceidtype)

The interface class.

### Enumerator

- AGORA_IID_AUDIO_DEVICE_MANAGER

  The [IAudioDeviceManager](class_iaudiodevicemanager.html#class_iaudiodevicemanager) interface class.

- AGORA_IID_VIDEO_DEVICE_MANAGER

  The [IVideoDeviceManager](class_ivideodevicemanager.html#class_ivideodevicemanager) interface class.

- AGORA_IID_RTC_ENGINE_PARAMETER

  This interface class is deprecated.

- AGORA_IID_MEDIA_ENGINE

  The [IMediaEngine](class_imediaengine.html#class_imediaengine) interface class.

- AGORA_IID_SIGNALING_ENGINE

  This interface class is deprecated.

**See also**

- [queryInterface](../API/class_irtcengine.html#api_queryinterface)

## [LASTMILE_PROBE_RESULT_STATE](rtc_api_data_type.html#enum_lastmileproberesultstate)

The status of the last-mile network tests.

### Enumerator

- LASTMILE_PROBE_RESULT_COMPLETE

  1: The last-mile network probe test is complete.

- LASTMILE_PROBE_RESULT_INCOMPLETE_NO_BWE

  2: The last-mile network probe test is incomplete because the bandwidth estimation is not available due to limited test resources.

- LASTMILE_PROBE_RESULT_UNAVAILABLE

  3: The last-mile network probe test is not carried out, probably due to poor network conditions.

**See also**

- [onLastmileProbeResult](../API/class_irtcengineeventhandler.html#callback_onlastmileproberesult)

## [LIGHTENING_CONTRAST_LEVEL](rtc_api_data_type.html#enum_lighteningcontrastlevel)

The contrast level.

### Enumerator

- LIGHTENING_CONTRAST_LOW

  Low contrast level.

- LIGHTENING_CONTRAST_NORMAL

  (Default) Normal contrast level.

- LIGHTENING_CONTRAST_HIGH

  High contrast level.

## [LOCAL_AUDIO_STREAM_ERROR](rtc_api_data_type.html#enum_localaudiostreamerror)

Local audio state error codes.

### Enumerator

- LOCAL_AUDIO_STREAM_ERROR_OK

  0: The local audio is normal.

- LOCAL_AUDIO_STREAM_ERROR_FAILURE

  1: No specified reason for the local audio failure.

- LOCAL_AUDIO_STREAM_ERROR_DEVICE_NO_PERMISSION

  2: No permission to use the local audio device.

- LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY

  3: The microphone is in use.

- LOCAL_AUDIO_STREAM_ERROR_RECORD_FAILURE

  4: The local audio capturing fails. Check whether the capturing device is working properly.

- LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE

  5: The local audio encoding fails.

**See also**

- [onLocalAudioStateChanged](../API/class_irtcengineeventhandler.html#callback_onlocalaudiostatechanged)

## [LOCAL_AUDIO_STREAM_STATE](rtc_api_data_type.html#enum_localaudiostreamstate)

Local audio states.

### Enumerator

- LOCAL_AUDIO_STREAM_STATE_STOPPED

  0: The local audio is in the initial state.

- LOCAL_AUDIO_STREAM_STATE_RECORDING

  1: The capturing device starts successfully.

- LOCAL_AUDIO_STREAM_STATE_ENCODING

  2: The first audio frame encodes successfully.

- LOCAL_AUDIO_STREAM_STATE_FAILED

  3: The local audio fails to start.

**See also**

- [onLocalAudioStateChanged](../API/class_irtcengineeventhandler.html#callback_onlocalaudiostatechanged)

## [LOCAL_VIDEO_STREAM_ERROR](rtc_api_data_type.html#enum_localvideostreamerror)

Local video state error codes.

### Enumerator

- LOCAL_VIDEO_STREAM_ERROR_OK

  0: The local video is normal.

- LOCAL_VIDEO_STREAM_ERROR_FAILURE

  1: No specified reason for the local video failure.

- LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION

  2: No permission to use the local video capturing device.

- LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY

  3: The local video capturing device is in use.

- LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE

  4: The local video capture fails. Check whether the capturing device is working properly.

- LOCAL_VIDEO_STREAM_ERROR_ENCODE_FAILURE

  5: The local video encoding fails.

- LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND

  8: Fails to find a local video capture device.

- LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_MINIMIZED

  [startScreenCaptureByWindowId](class_irtcengine.html#api_startscreencapturebywindowid)11: When calling to share the window, the shared window is in a minimized state.

- LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_CLOSED

  12: The error code indicates that a window shared by the window ID has been closed, or a full-screen window shared by the window ID has exited full-screen mode. After exiting full-screen mode, remote users cannot see the shared window. To prevent remote users from seeing a black screen, Agora recommends that you immediately stop screen sharing.Common scenarios for reporting this error code:When the local user closes the shared window, the SDK reports this error code.The local user shows some slides in full-screen mode first, and then shares the windows of the slides. After the user exits full-screen mode, the SDK reports this error code.The local user watches web video or reads web document in full-screen mode first, and then shares the window of the web video or document. After the user exits full-screen mode, the SDK reports this error code.

**See also**

- [onLocalVideoStateChanged](../API/class_irtcengineeventhandler.html#callback_onlocalvideostatechanged)

## [LOCAL_VIDEO_STREAM_STATE](rtc_api_data_type.html#enum_localvideostreamstate)

Local video state types

### Enumerator

- LOCAL_VIDEO_STREAM_STATE_STOPPED

  0: The local video is in the initial state.

- LOCAL_VIDEO_STREAM_STATE_CAPTURING

  1: The local video capturing device starts successfully. The SDK also reports this state when you call [startScreenCaptureByWindowId](class_irtcengine.html#api_startscreencapturebywindowid) to share a maximized window.

- LOCAL_VIDEO_STREAM_STATE_ENCODING

  2: The first video frame is successfully encoded.

- LOCAL_VIDEO_STREAM_STATE_FAILED

  3: Fails to start the local video.

**See also**

- [onLocalVideoStateChanged](../API/class_irtcengineeventhandler.html#callback_onlocalvideostatechanged)

## [LOG_FILTER_TYPE](rtc_api_data_type.html#enum_logfiltertype)

The output log level of the SDK.

### Enumerator

- LOG_FILTER_OFF

  0: Do not output any log information.

- LOG_FILTER_DEBUG

  0x080f: Output all log information. Set your log filter as DEBUG if you want to get the most complete log file.

- LOG_FILTER_INFO

  0x000f: Output CRITICAL, ERROR, WARNING, and INFO level log information. We recommend setting your log filter as this level.

- LOG_FILTER_WARN

  0x000e: Output CRITICAL, ERROR, and WARNING level log information.

- LOG_FILTER_ERROR

  0x000c: Output CRITICAL and ERROR level log information.

- LOG_FILTER_CRITICAL

  0x0008: Output CRITICAL level log information.

**See also**

- [setLogFilter](../API/class_irtcengine.html#api_setlogfilter)

## [LOG_LEVEL](rtc_api_data_type.html#enum_loglevel)

The output log level of the SDK.



### Enumerator

- LOG_LEVEL_NONE

  0: Do not output any log information.

- LOG_LEVEL_INFO

  0x0001: (Default) Output `FATAL`, `ERROR`, `WARN`, and `INFO` level log information. We recommend setting your log filter as this level.

- LOG_LEVEL_WARN

  0x0002: Output `FATAL`, `ERROR`, and `WARN` level log information.

- LOG_LEVEL_ERROR

  0x0004: Output `FATAL` and `ERROR` level log information.

- LOG_LEVEL_FATAL

  0x0008: Output `FATAL` level log information.

**See also**

- [initialize](../API/class_irtcengine.html#api_create2)
- [setLogLevel](../API/class_irtcengine.html#api_setloglevel)

## [MAX_CHANNEL_ID_LENGTH_TYPE](rtc_api_data_type.html#enum_maxchannelidlengthtype)

The maximum length of the channel name.

### Enumerator

- MAX_CHANNEL_ID_LENGTH

  The maximum length of the channel name is 64 bytes.

## [MAX_DEVICE_ID_LENGTH_TYPE](rtc_api_data_type.html#enum_maxdeviceidlengthtype)

The maximum length of the device ID.

### Enumerator

- MAX_DEVICE_ID_LENGTH

  The maximum length of the device ID is 512 bytes.

**See also**

- [getPlaybackDevice](../API/class_iaudiodevicemanager.html#api_iaudiodevicemanager_getplaybackdevice)
- [getPlaybackDeviceInfo](../API/class_iaudiodevicemanager.html#api_iaudiodevicemanager_getplaybackdeviceinfo)
- [setPlaybackDevice](../API/class_iaudiodevicemanager.html#api_iaudiodevicemanager_setplaybackdevice)
- [setRecordingDevice](../API/class_iaudiodevicemanager.html#api_iaudiodevicemanager_setrecordingdevice)
- [getDevice](../API/class_ivideodevicecollection.html#api_ivideodevicecollection_getdevice)
- [release](../API/class_iaudiodevicecollection.html#api_iaudiodevicecollection_release)
- [setDevice](../API/class_iaudiodevicecollection.html#api_iaudiodevicecollection_setdevice)
- [getDevice](../API/class_ivideodevicemanager.html#api_ivideodevicemanager_getdevice)
- [setDevice](../API/class_ivideodevicemanager.html#api_ivideodevicemanager_setdevice)
- [setDevice](../API/class_ivideodevicecollection.html#api_ivideodevicecollection_setdevice)

## [MAX_USER_ACCOUNT_LENGTH_TYPE](rtc_api_data_type.html#enum_maxuseraccountlengthtype)

The maximum length of the user account.

### Enumerator

- MAX_USER_ACCOUNT_LENGTH

  The maximum length of the user account is 256 bytes.

## [MEDIA_DEVICE_STATE_TYPE](rtc_api_data_type.html#enum_mediadevicestatetype)

Media device states.

### Enumerator

- MEDIA_DEVICE_STATE_IDLE

  0: The device is ready for use.

- MEDIA_DEVICE_STATE_ACTIVE

  1: The device is in use.

- MEDIA_DEVICE_STATE_DISABLED

  2: The device is disabled.

- MEDIA_DEVICE_STATE_NOT_PRESENT

  4: The device is not found.

- MEDIA_DEVICE_STATE_UNPLUGGED

  8: The device is unplugged.

**See also**

- [onAudioDeviceStateChanged](../API/class_irtcengineeventhandler.html#callback_onaudiodevicestatechanged)

## [MEDIA_DEVICE_TYPE](rtc_api_data_type.html#enum_mediadevicetype)

Media device types.

### Enumerator

- UNKNOWN_AUDIO_DEVICE

  -1: Unknown device type.

- AUDIO_PLAYOUT_DEVICE

  0: Audio playback device.

- AUDIO_RECORDING_DEVICE

  1: Audio capturing device.

- VIDEO_RENDER_DEVICE

  2: Video renderer.

- VIDEO_CAPTURE_DEVICE

  3: Video capturer.

- AUDIO_APPLICATION_PLAYOUT_DEVICE

  4: Application audio playback device.

**See also**

- [onAudioDeviceStateChanged](../API/class_irtcengineeventhandler.html#callback_onaudiodevicestatechanged)

## [MEDIA_PLAYER_PLAYBACK_SPEED](rtc_api_data_type.html#enum_mediaplayerplaybackspeed)

The playback speed.

### Enumerator

- PLAYBACK_SPEED_ORIGINAL

  100: The original playback speed.

- PLAYBACK_SPEED_50_PERCENT

  50: The playback speed is 0.50 times the original speed.

- PLAYBACK_SPEED_75_PERCENT

  75: The playback speed is 0.75 times the original speed.

- PLAYBACK_SPEED_125_PERCENT

  125: The playback speed is 1.25 times the original speed.

- PLAYBACK_SPEED_150_PERCENT

  150: The playback speed is 1.50 times the original speed.

- PLAYBACK_SPEED_200_PERCENT

  200: The playback speed is 2.00 times the original speed.

## [MEDIA_PLAYER_ERROR](rtc_api_data_type.html#enum_mediaplayererror)

Error codes of the media player.

### Enumerator

- PLAYER_ERROR_NONE

  0: No error.

- PLAYER_ERROR_INVALID_ARGUMENTS

  -1: Invalid arguments.

- PLAYER_ERROR_INTERNAL

  -2: Internal errors.

- PLAYER_ERROR_NO_RESOURCE

  -3: No resource.

- PLAYER_ERROR_INVALID_MEDIA_SOURCE

  -4: Invalid media resource.

- PLAYER_ERROR_UNKNOWN_STREAM_TYPE

  -5: The type of the media stream is unknown.

- PLAYER_ERROR_OBJ_NOT_INITIALIZED

  -6: The object is not initialized.

- PLAYER_ERROR_CODEC_NOT_SUPPORTED

  -7: The codec is not supported.

- PLAYER_ERROR_VIDEO_RENDER_FAILED

  -8: Invalid renderer.

- PLAYER_ERROR_INVALID_STATE

  -9: An error with the internal state of the player occurs.

- PLAYER_ERROR_URL_NOT_FOUND

  -10: The URL of the media resource can not be found.

- PLAYER_ERROR_INVALID_CONNECTION_STATE

  -11: Invalid connection between the player and Agora's Server.

- PLAYER_ERROR_SRC_BUFFER_UNDERFLOW

  -12: The playback buffer is insufficient.

- PLAYER_ERROR_INTERRUPTED

  -13: The playback is interrupted.

- PLAYER_ERROR_NOT_SUPPORTED

  -14: The SDK does support the method being called.

- PLAYER_ERROR_UNKNOWN

  -100: An unknown error.

**See also**

- [onPlayerSourceStateChanged](../API/class_imediaplayersourceobserver.html#callback_imediaplayersourceobserver_onplayersourcestatechanged)
- [getPlayPosition](../API/class_imediaplayer.html#api_imediaplayer_getplayposition)

## [MEDIA_PLAYER_EVENT](rtc_api_data_type.html#enum_mediaplayerevent)

Media player events.

### Enumerator

- PLAYER_EVENT_SEEK_BEGIN

  0: The player begins to seek to a new playback position.

- PLAYER_EVENT_SEEK_COMPLETE

  1: The player finishes seeking to a new playback position.

- PLAYER_EVENT_SEEK_ERROR

  2: An error occurs when seeking to a new playback position.

- PLAYER_EVENT_AUDIO_TRACK_CHANGED

  5: The audio track used by the player has been changed.

- PLAYER_EVENT_BUFFER_LOW

  6: The currently buffered data is not enough to support playback.

- PLAYER_EVENT_BUFFER_RECOVER

  7: The currently buffered data is just enough to support playback.

- PLAYER_EVENT_FREEZE_START

  8: The audio or video playback freezes.

- PLAYER_EVENT_FREEZE_STOP

  9: The audio or video playback resumes without freezing.

- PLAYER_EVENT_SWITCH_BEGIN

  10: The player starts switching the media resource.

- PLAYER_EVENT_SWITCH_COMPLETE

  11: Media resource switching is complete.

- PLAYER_EVENT_SWITCH_ERROR

  12: Media resource switching error.

- PLAYER_EVENT_FIRST_DISPLAYED

  13: The first video frame is rendered.

**See also**

- [onPlayerEvent](../API/class_imediaplayersourceobserver.html#callback_imediaplayersourceobserver_onplayerevent)

## [MEDIA_PLAYER_METADATA_TYPE](rtc_api_data_type.html#enum_mediaplayermetadatatype)

The type of media metadata.

### Enumerator

- PLAYER_METADATA_TYPE_UNKNOWN

  0: The type is unknown.

- PLAYER_METADATA_TYPE_SEI

  1: The type is SEI.

## [MEDIA_PLAYER_STATE](rtc_api_data_type.html#enum_mediaplayerstate)

The playback state.

### Enumerator

- PLAYER_STATE_IDLE

  0: The default state. The media player returns this state code before you open the media resource or after you stop the playback.

- PLAYER_STATE_OPENING

  Opening the media resource.

- PLAYER_STATE_OPEN_COMPLETED

  Opens the media resource successfully.

- PLAYER_STATE_PLAYING

  The media resource is playing.

- PLAYER_STATE_PAUSED

  Pauses the playback.

- PLAYER_STATE_PLAYBACK_COMPLETED

  The playback finishes.

- PLAYER_STATE_PLAYBACK_ALL_LOOPS_COMPLETED

  The loop finishes.

- PLAYER_STATE_STOPPED

  The playback stops.

- PLAYER_STATE_FAILED

  100: The media player fails to play the media resource.

**See also**

- [getState](../API/class_imediaplayer.html#api_imediaplayer_getstate)
- [onPlayerSourceStateChanged](../API/class_imediaplayersourceobserver.html#callback_imediaplayersourceobserver_onplayersourcestatechanged)

## [MEDIA_SOURCE_TYPE](rtc_api_data_type.html#enum_mediasourcetype)

Media source type.

### Enumerator

- AUDIO_PLAYOUT_SOURCE

  0: Audio playback device.

- AUDIO_RECORDING_SOURCE

  1: Audio capturing device.

- SECONDARY_CAMERA_SOURCE

  3: A secondary camera.

- UNKNOWN_MEDIA_SOURCE

  100: Unknown media source.

**See also**

- [enableVirtualBackground](../API/class_irtcengine.html#api_enablevirtualbackground)
- [enableExtension](../API/class_irtcengine.html#api_enableextension)
- [setExtensionProperty](../API/class_irtcengine.html#api_setextensionproperty)

## [MEDIA_STREAM_TYPE](rtc_api_data_type.html#enum_mediastreamtype)

The type of the media stream.

### Enumerator

- STREAM_TYPE_UNKNOWN

  0: The type is unknown.

- STREAM_TYPE_VIDEO

  1: The video stream.

- STREAM_TYPE_AUDIO

  2: The audio stream.

- STREAM_TYPE_SUBTITLE

  3: The subtitle stream.

## [NETWORK_TYPE](rtc_api_data_type.html#enum_networktype)

Network type.

### Enumerator

- NETWORK_TYPE_UNKNOWN

  -1: The network type is unknown.

- NETWORK_TYPE_DISCONNECTED

  0: The SDK disconnects from the network.

- NETWORK_TYPE_LAN

  1: The network type is LAN.

- NETWORK_TYPE_WIFI

  2: The network type is Wi-Fi (including hotspots).

- NETWORK_TYPE_MOBILE_2G

  3: The network type is mobile 2G.

- NETWORK_TYPE_MOBILE_3G

  4: The network type is mobile 3G.

- NETWORK_TYPE_MOBILE_4G

  5: The network type is mobile 4G.

**See also**

- [onNetworkTypeChanged](../API/class_irtcengineeventhandler.html#callback_onnetworktypechanged)

## [ORIENTATION_MODE](rtc_api_data_type.html#enum_orientationmode)

Video output orientation modes.

### Enumerator

- ORIENTATION_MODE_ADAPTIVE

  0: (Default) The output video always follows the orientation of the captured video. The receiver takes the rotational information passed on from the video encoder. This mode applies to scenarios where video orientation can be adjusted on the receiver.If the captured video is in landscape mode, the output video is in landscape mode.If the captured video is in portrait mode, the output video is in portrait mode.

- ORIENTATION_FIXED_LANDSCAPE

  1: In this mode, the SDK always outputs videos in landscape (horizontal) mode. If the captured video is in portrait mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.

- ORIENTATION_FIXED_PORTRAIT

  2: In this mode, the SDK always outputs video in portrait (portrait) mode. If the captured video is in landscape mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.

**See also**

- [setVideoEncoderConfiguration](../API/class_irtcengine.html#api_setvideoencoderconfiguration)
- [addVideoWatermark [2/2\]](../API/class_irtcengine.html#api_addvideowatermark2)

## [PERMISSION_TYPE](rtc_api_data_type.html#enum_permissiontype)

The type of the device permission.

### Enumerator

- RECORD_AUDIO

  0: Permission for the audio capture device.

- CAMERA

  1: Permission for the camera.

**See also**

- [onPermissionError](../API/class_irtcengineeventhandler.html#callback_onpermissionerror)

## [PLAYER_PRELOAD_EVENT](rtc_api_data_type.html#enum_playerpreloadevent)

Events that occur when media resources are preloaded.

### Enumerator

- PLAYER_PRELOAD_EVENT_BEGIN

  0: Starts preloading media resources.

- PLAYER_PRELOAD_EVENT_COMPLETE

  1: Preloading media resources is complete.

- PLAYER_PRELOAD_EVENT_ERROR

  2: An error occurs when preloading media resources.

## [PRIORITY_TYPE](rtc_api_data_type.html#enum_prioritytype)

The priority of the remote user.

### Enumerator

- PRIORITY_HIGH

  The user's priority is high.

- PRIORITY_NORMAL

  (Default) The user's priority is normal.

## [QUALITY_ADAPT_INDICATION](rtc_api_data_type.html#enum_qualityadaptindication)

Quality change of the local video in terms of target frame rate and target bit rate since last count.

### Enumerator

- ADAPT_NONE

  0: The local video quality stays the same.

- ADAPT_UP_BANDWIDTH

  1: The local video quality improves because the network bandwidth increases.

- ADAPT_DOWN_BANDWIDTH

  2: The local video quality deteriorates because the network bandwidth decreases.

**See also**

- [onLocalVideoStats](../API/class_irtcengineeventhandler.html#callback_onlocalvideostats)

## [QUALITY_REPORT_FORMAT_TYPE](rtc_api_data_type.html#enum_qualityreportformattype)

Formats of the quality report.

### Enumerator

- QUALITY_REPORT_JSON

  0: The quality report in JSON format.

- QUALITY_REPORT_HTML

  1: The quality report in HTML format.

## [QUALITY_TYPE](rtc_api_data_type.html#enum_qualitytype)

Network quality types.

### Enumerator

- QUALITY_UNKNOWN

  0: The network quality is unknown.

- QUALITY_EXCELLENT

  1: The network quality is excellent.

- QUALITY_GOOD

  2: The network quality is quite good, but the bitrate may be slightly lower than excellent.

- QUALITY_POOR

  3: Users can feel the communication slightly impaired.

- QUALITY_BAD

  4: Users cannot communicate smoothly.

- QUALITY_VBAD

  5: The quality is so bad that users can barely communicate.

- QUALITY_DOWN

  6: The network is down and users cannot communicate at all.

- QUALITY_UNSUPPORTED

  7: Users cannot detect the network quality. (Not in use.)

- QUALITY_DETECTING

  8: Detecting the network quality.

**See also**

- [onNetworkQuality](../API/class_irtcengineeventhandler.html#callback_onnetworkquality)
- [onRemoteAudioStats](../API/class_irtcengineeventhandler.html#callback_onremoteaudiostats)
- [onLastmileQuality](../API/class_irtcengineeventhandler.html#callback_onlastmilequality)

## [RAW_AUDIO_FRAME_OP_MODE_TYPE](rtc_api_data_type.html#enum_rawaudioframeopmodetype)

The use mode of the audio data.

### Enumerator

- RAW_AUDIO_FRAME_OP_MODE_READ_ONLY

  0: Read-only mode: Users only read the [AudioFrame](class_iaudioframeobserverbase.html#class_audioframe) data without modifying anything.For example, when users acquire the data with the Agora SDK, then push the RTMP or RTMPS streams.

- RAW_AUDIO_FRAME_OP_MODE_READ_WRITE

  2: Read and write mode: Users read the data from [AudioFrame](class_iaudioframeobserverbase.html#class_audioframe), modify it, and then play it.For example, when users have their own sound-effect processing module and perform some voice pre-processing, such as a voice change.

**See also**

- [setRecordingAudioFrameParameters](../API/class_irtcengine.html#api_setrecordingaudioframeparameters)
- [setPlaybackAudioFrameParameters](../API/class_irtcengine.html#api_setplaybackaudioframeparameters)
- [registerAudioFrameObserver](../API/class_imediaengine.html#api_imediaengine_registeraudioframeobserver)

## [REMOTE_AUDIO_STATE_REASON](rtc_api_data_type.html#enum_remoteaudiostatereason)

The reason for the remote audio state change.

### Enumerator

- REMOTE_AUDIO_STATE_REASON_INTERNAL

  0: The SDK reports this reason when the audio state changes.

- REMOTE_AUDIO_STATE_REASON_NETWORK_CONGESTION

  1: Network congestion.

- REMOTE_AUDIO_STATE_REASON_NETWORK_RECOVERY

  2: Network recovery.

- REMOTE_AUDIO_STATE_REASON_LOCAL_MUTED

  3: The local user stops receiving the remote audio stream or disables the audio module.

- REMOTE_AUDIO_STATE_REASON_LOCAL_UNMUTED

  4: The local user resumes receiving the remote audio stream or enables the audio module.

- REMOTE_AUDIO_STATE_REASON_REMOTE_MUTED

  5: The remote user stops sending the audio stream or disables the audio module.

- REMOTE_AUDIO_STATE_REASON_REMOTE_UNMUTED

  6: The remote user resumes sending the audio stream or enables the audio module.

- REMOTE_AUDIO_STATE_REASON_REMOTE_OFFLINE

  7: The remote user leaves the channel.

**See also**

- [onRemoteAudioStateChanged](../API/class_irtcengineeventhandler.html#callback_onremoteaudiostatechanged)

## [REMOTE_AUDIO_STATE](rtc_api_data_type.html#enum_remoteaudiostate)

Remote audio states.

### Enumerator

- REMOTE_AUDIO_STATE_STOPPED

  0: The local audio is in the initial state. The SDK reports this state in the case of REMOTE_AUDIO_STATE_REASON_LOCAL_MUTED, REMOTE_AUDIO_STATE_REASON_REMOTE_MUTED or REMOTE_AUDIO_STATE_REASON_REMOTE_OFFLINE.

- REMOTE_AUDIO_STATE_STARTING

  1: The first remote audio packet is received.

- REMOTE_AUDIO_STATE_DECODING

  2: The remote audio stream is decoded and plays normally. The SDK reports this state in the case of REMOTE_AUDIO_STATE_REASON_NETWORK_RECOVERY, REMOTE_AUDIO_STATE_REASON_LOCAL_UNMUTED or REMOTE_AUDIO_STATE_REASON_REMOTE_UNMUTED.

- REMOTE_AUDIO_STATE_FROZEN

  3: The remote audio is frozen. The SDK reports this state in the case of REMOTE_AUDIO_STATE_REASON_NETWORK_CONGESTION.

- REMOTE_AUDIO_STATE_FAILED

  4: The remote audio fails to start. The SDK reports this state in the case of REMOTE_AUDIO_STATE_REASON_INTERNAL.

**See also**

- [onRemoteAudioStateChanged](../API/class_irtcengineeventhandler.html#callback_onremoteaudiostatechanged)

## [REMOTE_VIDEO_STATE_REASON](rtc_api_data_type.html#enum_remotevideostatereason)

The reason for the remote video state change.

### Enumerator

- REMOTE_VIDEO_STATE_REASON_INTERNAL

  0: The SDK reports this reason when the video state changes.

- REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION

  1: Network congestion.

- REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY

  2: Network recovery.

- REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED

  3: The local user stops receiving the remote video stream or disables the video module.

- REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED

  4: The local user resumes receiving the remote video stream or enables the video module.

- REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED

  5: The remote user stops sending the video stream or disables the video module.

- REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED

  6: The remote user resumes sending the video stream or enables the video module.

- REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE

  7: The remote user leaves the channel.

- REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK

  8: The remote audio-and-video stream falls back to the audio-only stream due to poor network conditions.

- REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY

  9: The remote audio-only stream switches back to the audio-and-video stream after the network conditions improve.

**See also**

- [onRemoteVideoStateChanged](../API/class_irtcengineeventhandler.html#callback_onremotevideostatechanged)

## [REMOTE_VIDEO_STATE](rtc_api_data_type.html#enum_remotevideostate)

The state of the remote video.

### Enumerator

- REMOTE_VIDEO_STATE_STOPPED

  0: The remote video is in the initial state. The SDK reports this state in the case of REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED, REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED or REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE.

- REMOTE_VIDEO_STATE_STARTING

  1: The first remote video packet is received.

- REMOTE_VIDEO_STATE_DECODING

  2: The remote video stream is decoded and plays normally. The SDK reports this state in the case of REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY, REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED,REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED, or REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY.

- REMOTE_VIDEO_STATE_FROZEN

  3: The remote video is frozen. The SDK reports this state in the case of REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION or REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK.

- REMOTE_VIDEO_STATE_FAILED

  4: The remote video fails to start. The SDK reports this state in the case of REMOTE_VIDEO_STATE_REASON_INTERNAL.

**See also**

- [onRemoteVideoStateChanged](../API/class_irtcengineeventhandler.html#callback_onremotevideostatechanged)

## [REMOTE_VIDEO_STREAM_TYPE](rtc_api_data_type.html#enum_remotevideostreamtype)

The type of video streams.

### Enumerator

- REMOTE_VIDEO_STREAM_HIGH

  0: High-quality video stream.

- REMOTE_VIDEO_STREAM_LOW

  1: Low-quality video stream.

**See also**

- [setRemoteVideoStreamType](../API/class_irtcengine.html#api_setremotevideostreamtype)
- [setRemoteDefaultVideoStreamType](../API/class_irtcengine.html#api_setremotedefaultvideostreamtype)
- [onRemoteVideoStats](../API/class_irtcengineeventhandler.html#callback_onremotevideostats)

## [RENDER_MODE_TYPE](rtc_api_data_type.html#enum_rendermodetype)

Video display modes.

### Enumerator

- RENDER_MODE_HIDDEN

  1: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Hidden mode. One dimension of the video may have clipped contents.

- RENDER_MODE_FIT

  2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Fit mode. Areas that are not filled due to disparity in the aspect ratio are filled with black.

- RENDER_MODE_ADAPTIVE

  Deprecated:3: This mode is deprecated.

**See also**

- [setupLocalVideo](../API/class_irtcengine.html#api_setuplocalvideo)
- [setupRemoteVideo](../API/class_irtcengine.html#api_setupremotevideo)
- [setLocalRenderMode [1/2\]](../API/class_irtcengine.html#api_setlocalrendermode)
- [setLocalRenderMode [2/2\]](../API/class_irtcengine.html#api_setlocalrendermode2)
- [setRemoteRenderMode](../API/class_irtcengine.html#api_setremoterendermode2)
- [setRenderMode](../API/class_imediaplayer.html#api_imediaplayer_setrendermode)

## [RTMP_STREAM_LIFE_CYCLE_TYPE](rtc_api_data_type.html#enum_rtmpstreamlifecycletype)

Lifecycle of the CDN live video stream.

- Deprecated

  

### Enumerator

- RTMP_STREAM_LIFE_CYCLE_BIND2CHANNEL

  Bind to the channel lifecycle. If all hosts leave the channel, the CDN live streaming stops after 30 seconds.

- RTMP_STREAM_LIFE_CYCLE_BIND2OWNER

  Bind to the owner of the RTMP stream. If the owner leaves the channel, the CDN live streaming stops immediately.

## [RTMP_STREAM_PUBLISH_ERROR](rtc_api_data_type.html#enum_rtmpstreampublisherror)

Error codes of the RTMP or RTMPS streaming.

### Enumerator

- RTMP_STREAM_PUBLISH_ERROR_OK

  The RTMP or RTMPS streaming publishes successfully.

- RTMP_STREAM_PUBLISH_ERROR_INVALID_ARGUMENT

  Invalid argument used. Please check the parameter setting. For example, if you do not call [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding) to set the transcoding parameters before calling [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl), the SDK returns this error.

- RTMP_STREAM_PUBLISH_ERROR_ENCRYPTED_STREAM_NOT_ALLOWED

  Check whether you set the parameters in the setLiveTranscoding method properly.

- RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT

  The RTMP or RTMPS streaming is encrypted and cannot be published. Call [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) to re-publish the stream.

- RTMP_STREAM_PUBLISH_ERROR_INTERNAL_SERVER_ERROR

  An error occurs in Agora's streaming server. Call the [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) method to publish the streaming again.

- RTMP_STREAM_PUBLISH_ERROR_RTMP_SERVER_ERROR

  An error occurs in the CDN server.

- RTMP_STREAM_PUBLISH_ERROR_TOO_OFTEN

  The RTMP or RTMPS streaming publishes too frequently.

- RTMP_STREAM_PUBLISH_ERROR_REACH_LIMIT

  The host has published more than 10 URLs. Delete the unnecessary URLs before adding new ones.

- RTMP_STREAM_PUBLISH_ERROR_NOT_AUTHORIZED

  The host manipulates other hosts' streams. For example, the host updates or stops other hosts' streams. Check your app logic.

- RTMP_STREAM_PUBLISH_ERROR_STREAM_NOT_FOUND

  Agora's server fails to find the RTMP or RTMPS streaming.

- RTMP_STREAM_PUBLISH_ERROR_FORMAT_NOT_SUPPORTED

  The URL format is incorrect. Check whether the URL format is correct.

**See also**

- [onRtmpStreamingStateChanged](../API/class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged)

## [RTMP_STREAM_PUBLISH_STATE](rtc_api_data_type.html#enum_rtmpstreampublishstate)

States of the RTMP or RTMPS streaming.

### Enumerator

- RTMP_STREAM_PUBLISH_STATE_IDLE

  The RTMP or RTMPS streaming has not started or has ended. This state is also triggered after you remove an RTMP or RTMPS stream from the CDN by calling [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl).

- RTMP_STREAM_PUBLISH_STATE_CONNECTING

  The SDK is connecting to Agora's streaming server and the CDN server. This state is triggered after you call the [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) method.

- RTMP_STREAM_PUBLISH_STATE_RUNNING

  The RTMP or RTMPS streaming publishes. The SDK successfully publishes the RTMP or RTMPS streaming and returns this state.

- RTMP_STREAM_PUBLISH_STATE_RECOVERING

  The RTMP or RTMPS streaming is recovering. When exceptions occur to the CDN, or the streaming is interrupted, the SDK tries to resume RTMP or RTMPS streaming and returns this state.If the SDK successfully resumes the streaming, RTMP_STREAM_PUBLISH_STATE_RUNNING(2) returns.If the streaming does not resume within 60 seconds or server errors occur, RTMP_STREAM_PUBLISH_STATE_FAILURE(4) returns. You can also reconnect to the server by calling the [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl) and [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) methods.

- RTMP_STREAM_PUBLISH_STATE_FAILURE

  The RTMP or RTMPS streaming fails. See the error code for the detailed error information. You can also call the [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) method to publish the RTMP or RTMPS stream again.

**See also**

- [onRtmpStreamingStateChanged](../API/class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged)

## [RTMP_STREAMING_EVENT](rtc_api_data_type.html#enum_rtmpstreamingevent)

Events during the RTMP or RTMPS streaming.

### Enumerator

- RTMP_STREAMING_EVENT_FAILED_LOAD_IMAGE

  An error occurs when you add a background image or a watermark image to the RTMP or RTMPS stream.

## [STREAM_PUBLISH_STATE](rtc_api_data_type.html#enum_streampublishstate)

The publishing state.

### Enumerator

- PUB_STATE_IDLE

  0: The initial publishing state after joining the channel.

- PUB_STATE_NO_PUBLISHED

  1: Fails to publish the local stream. Possible reasons:The local user calls [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream)(`true`) or [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream)(`true`) to stop sending the local media stream.The local user calls [disableAudio](class_irtcengine.html#api_disableaudio) or [disableVideo](class_irtcengine.html#api_disablevideo) to disable the local audio or video module.The local user calls [enableLocalAudio](class_irtcengine.html#api_enablelocalaudio)(`false`) or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo)(`false`) to disable the local audio or video capture.The role of the local user is audience.

- PUB_STATE_PUBLISHING

  2: Publishing.

- PUB_STATE_PUBLISHED

  3: Publishes successfully.

**See also**

- [onAudioPublishStateChanged](../API/class_irtcengineeventhandler.html#callback_onaudiopublishstatechanged)
- [onVideoPublishStateChanged](../API/class_irtcengineeventhandler.html#callback_onvideopublishstatechanged)

## [STREAM_SUBSCRIBE_STATE](rtc_api_data_type.html#enum_streamsubscribestate)

The subscribing state.

### Enumerator

- SUB_STATE_IDLE

  0: The initial subscribing state after joining the channel.

- SUB_STATE_NO_SUBSCRIBED

  1: Fails to subscribe to the remote stream. Possible reasons:The remote user:Calls [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream)(`true`) or [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream)(`true`) to stop sending local media stream.Calls [disableAudio](class_irtcengine.html#api_disableaudio) or [disableVideo](class_irtcengine.html#api_disablevideo) to disable the local audio or video module.Calls [enableLocalAudio](class_irtcengine.html#api_enablelocalaudio)(false) or [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo)(false) to disable the local audio or video capture.The role of the remote user is audience.The local user calls the following methods to stop receiving remote streams:Calls [muteRemoteAudioStream](class_irtcengine.html#api_muteremoteaudiostream)(true), [muteAllRemoteAudioStreams](class_irtcengine.html#api_muteallremoteaudiostreams)(true) or [setDefaultMuteAllRemoteAudioStreams](class_irtcengine.html#api_setdefaultmuteallremoteaudiostreams)(true) to stop receiving the remote audio streams.Calls [muteRemoteVideoStream](class_irtcengine.html#api_muteremotevideostream)(true), [muteAllRemoteVideoStreams](class_irtcengine.html#api_muteallremotevideostreams)(true) or [setDefaultMuteAllRemoteVideoStreams](class_irtcengine.html#api_setdefaultmuteallremotevideostreams)(true) to stop receiving the remote video streams.

- SUB_STATE_SUBSCRIBING

  2: Subscribing.

- SUB_STATE_SUBSCRIBED

  3: Subscribes to and receives the remote stream successfully.

**See also**

- [onAudioSubscribeStateChanged](../API/class_irtcengineeventhandler.html#callback_onaudiosubscribestatechanged)
- [onVideoSubscribeStateChanged](../API/class_irtcengineeventhandler.html#callback_onvideosubscribestatechanged)

## [USER_OFFLINE_REASON_TYPE](rtc_api_data_type.html#enum_userofflinereasontype)

Reasons for a user being offline.

### Enumerator

- USER_OFFLINE_QUIT

  0: The user quits the call.

- USER_OFFLINE_DROPPED

  1: The SDK times out and the user drops offline because no data packet is received within a certain period of time.**Note** If the user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline.

- USER_OFFLINE_BECOME_AUDIENCE

  2: The user switches the client role from the host to the audience.

**See also**

- [onUserOffline](../API/class_irtcengineeventhandler.html#callback_onuseroffline)

## [VIDEO_BUFFER_TYPE](rtc_api_data_type.html#enum_videobuffertype)

The video buffer type.

### Enumerator

- VIDEO_BUFFER_RAW_DATA

  1: The video buffer in the format of raw data.

- VIDEO_BUFFER_ARRAY

  2: The video buffer in the format of raw data.

- VIDEO_BUFFER_TEXTURE

  3: The video buffer in the format of `Texture`.

**See also**

- [pushVideoFrame [1/2\]](../API/class_imediaengine.html#api_imediaengine_pushvideoframe)
- [pushVideoFrame [2/2\]](../API/class_imediaengine.html#api_irtcengineex_pushvideoframeex)

## [VIDEO_CAPTURE_TYPE](rtc_api_data_type.html#enum_videocapturetype)

The capture type of the custom video source.

### Enumerator

- VIDEO_CAPTURE_UNKNOWN

  Unknown type.

- VIDEO_CAPTURE_CAMERA

  (Default) Video captured by the camera.

- VIDEO_CAPTURE_SCREEN

  Video for screen sharing.

## [VIDEO_CODEC_PROFILE_TYPE](rtc_api_data_type.html#enum_videocodecprofiletype)

Video codec profile types.

- VIDEO_CODEC_PROFILE_BASELINE

  66: Baseline video codec profile. Generally used for video calls on mobile phones.

- VIDEO_CODEC_PROFILE_MAIN

  77: Main video codec profile. Generally used in mainstream electronics such as MP4 players, portable video players, PSP, and iPads.

- VIDEO_CODEC_PROFILE_HIGH

  100: (Default) High video codec profile. Generally used in high-resolution live streaming or television.

**See also**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)

## [VIDEO_CODEC_TYPE](rtc_api_data_type.html#enum_videocodectype)

Video codec types.

### Enumerator

- VIDEO_CODEC_VP8

  Standard VP8.

- VIDEO_CODEC_H264

  Standard H.264.

- VIDEO_CODEC_H265

  Standard H.264.

- VIDEO_CODEC_GENERIC

  Generic.This type is used for transmitting raw video data, such as encrypted video frames. The SDK returns this type of video frames in callbacks, and you need to decode and render the frames yourself.

- VIDEO_CODEC_GENERIC_JPEG

  Generic JPEG.This type consumes minimum computing resources and applies to IoT devices.

- VIDEO_CODEC_VP9

  Standard VP9.

**See also**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)
- [onLocalVideoStats](../API/class_irtcengineeventhandler.html#callback_onlocalvideostats)

## [VideoContentHint](rtc_api_data_type.html#enum_videocontenthint)

The content hint for screen sharing.

### Enumerator

- CONTENT_HINT_NONE

  (Default) No content hint.

- CONTENT_HINT_MOTION

  Motion-intensive content. Choose this option if you prefer smoothness or when you are sharing a video clip, movie, or video game.

- CONTENT_HINT_DETAILS

  Motionless content. Choose this option if you prefer sharpness or when you are sharing a picture, PowerPoint slides, or texts.

**See also**

- [setScreenCaptureContentHint](../API/class_irtcengine.html#api_setscreencapturecontenthint)

## [VIDEO_FRAME_TYPE](rtc_api_data_type.html#enum_videoframetype_ng)

The video frame type.

### Enumerator

- VIDEO_FRAME_TYPE_BLANK_FRAME

  0: A black frame.

- VIDEO_FRAME_TYPE_KEY_FRAME

  3: Keyframe.

- VIDEO_FRAME_TYPE_DELTA_FRAME

  4: Delta frame.

- VIDEO_FRAME_TYPE_B_FRAME

  5: The B frame.

- VIDEO_FRAME_TYPE_DROPPABLE_FRAME

  6: A discarded frame.

- VIDEO_FRAME_TYPE_UNKNOW

  Unknown frame.

## [VIDEO_MIRROR_MODE_TYPE](rtc_api_data_type.html#enum_videomirrormodetype)

Video mirror mode.

### Enumerator

- VIDEO_MIRROR_MODE_AUTO

  0: (Default) The SDK determines the mirror mode.

- VIDEO_MIRROR_MODE_ENABLED

  1: Enable mirror mode.

- VIDEO_MIRROR_MODE_DISABLED

  2: Disable mirror mode.

**See also**

- [setVideoEncoderConfiguration](../API/class_irtcengine.html#api_setvideoencoderconfiguration)
- [setupLocalVideo](../API/class_irtcengine.html#api_setuplocalvideo)
- [setupRemoteVideo](../API/class_irtcengine.html#api_setupremotevideo)
- [setLocalRenderMode [1/2\]](../API/class_irtcengine.html#api_setlocalrendermode)
- [setLocalRenderMode [2/2\]](../API/class_irtcengine.html#api_setlocalrendermode2)
- [setRemoteRenderMode](../API/class_irtcengine.html#api_setremoterendermode2)
- [setLocalVideoMirrorMode](../API/class_irtcengine.html#api_setlocalvideomirrormode)

## [VIDEO_MODULE_POSITION](rtc_api_data_type.html#enum_videoobserverposition)

The frame position of the video observer.

### Enumerator

- POSITION_POST_CAPTURER

  1: The post-capturer position, which corresponds to the video data in the onCaptureVideoFrame callback.

- POSITION_PRE_RENDERER

  2: The pre-renderer position, which corresponds to the video data in the onRenderVideoFrame callback.

- POSITION_PRE_ENCODER

  4: The pre-encoder position, which corresponds to the video data in the onPreEncodeVideoFrame callback.

## [VIDEO_ORIENTATION](rtc_api_data_type.html#enum_videoorientation)

The clockwise rotation of the video.

### Enumerator

- VIDEO_ORIENTATION_0

  0: (Default) No rotation.

- VIDEO_ORIENTATION_90

  90: 90 degrees.

- VIDEO_ORIENTATION_180

  180: 180 degrees.

- VIDEO_ORIENTATION_270

  270: 270 degrees.

**See also**

- [setCameraDeviceOrientation](../API/class_irtcengine.html#api_setcameradeviceorientation)

## [VIDEO_PIXEL_FORMAT](rtc_api_data_type.html#enum_videopixelformat)

The video pixel format.

### Enumerator

**Note** The SDK does not support the alpha channel, and discards any alpha value passed to the SDK.

- VIDEO_PIXEL_UNKNOWN

  0: The format is known.

- VIDEO_PIXEL_I420

  1: The format is I420.

- VIDEO_PIXEL_BGRA

  2: The format is BGRA.

- VIDEO_PIXEL_NV21

  3: The format is NV21.

- VIDEO_PIXEL_RGBA

  4: The format is RGBA.

- VIDEO_PIXEL_IMC2

  5: The format is IMC2.

- VIDEO_PIXEL_ARGB

  7: The format is ARGB.

- VIDEO_PIXEL_NV12

  8: The format is NV12.

- VIDEO_PIXEL_I422

  16: The format is I422.

**See also**

- [pushVideoFrame [1/2\]](../API/class_imediaengine.html#api_imediaengine_pushvideoframe)
- [pushVideoFrame [2/2\]](../API/class_imediaengine.html#api_irtcengineex_pushvideoframeex)
- [onCaptureVideoFrame](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_oncapturevideoframe)
- [onRenderVideoFrame](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_onrendervideoframe)
- [getRotationApplied](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_getrotationapplied)

## [VIDEO_PROFILE_TYPE](rtc_api_data_type.html#enum_videoprofiletype)

Video profile

- Deprecated

  

### Enumerator

- VIDEO_PROFILE_LANDSCAPE_120P

  0: 160 × 120, frame rate 15 fps, bitrate 65 Kbps.

- VIDEO_PROFILE_LANDSCAPE_120P_3

  2: 120 × 120, frame rate 15 fps, bitrate 50 Kbps.

- VIDEO_PROFILE_LANDSCAPE_180P

  10: 320 × 180, frame rate 15 fps, bitrate 140 Kbps.

- VIDEO_PROFILE_LANDSCAPE_180P_3

  12: 180 × 180, frame rate 15 fps, bitrate 100 Kbps.

- VIDEO_PROFILE_LANDSCAPE_180P_4

  13: 240 × 180, frame rate 15 fps, bitrate 120 Kbps.

- VIDEO_PROFILE_LANDSCAPE_240P

  20: 320 × 240, frame rate 15 fps, bitrate 200 Kbps.

- VIDEO_PROFILE_LANDSCAPE_240P_3

  22: 240 × 240, frame rate 15 fps, bitrate 140 Kbps.

- VIDEO_PROFILE_LANDSCAPE_240P_4

  23: 424 × 240, frame rate 15 fps, bitrate 220 Kbps.

- VIDEO_PROFILE_LANDSCAPE_360P

  30: 640 × 360, frame rate 15 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_LANDSCAPE_360P_3

  32: 360 × 360, frame rate 15 fps, bitrate 260 Kbps.

- VIDEO_PROFILE_LANDSCAPE_360P_4

  33: 640 × 360, frame rate 30 fps, bitrate 600 Kbps.

- VIDEO_PROFILE_LANDSCAPE_360P_6

  35: 360 × 360, frame rate 30 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_LANDSCAPE_360P_7

  36: 480 × 360, frame rate 15 fps, bitrate 320 Kbps.

- VIDEO_PROFILE_LANDSCAPE_360P_8

  37: 480 × 360, frame rate 30 fps, bitrate 490 Kbps.

- VIDEO_PROFILE_LANDSCAPE_360P_9

  38: 640 × 360, frame rate 15 fps, bitrate 800 Kbps.**Note** This profile applies only to the live streaming channel profile.

- VIDEO_PROFILE_LANDSCAPE_360P_10

  39: 640 × 360, frame rate 24 fps, bitrate 800 Kbps.**Note** This profile applies only to the live streaming channel profile.

- VIDEO_PROFILE_LANDSCAPE_360P_11

  100: 640 × 360, frame rate 24 fps, bitrate 1000 Kbps.**Note** This profile applies only to the live streaming channel profile.

- VIDEO_PROFILE_LANDSCAPE_480P

  40: 640 × 480, frame rate 15 fps, bitrate 500 Kbps.

- VIDEO_PROFILE_LANDSCAPE_480P_3

  42: 480 × 480, frame rate 15 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_LANDSCAPE_480P_4

  43: 640 × 480, frame rate 30 fps, bitrate 750 Kbps.

- VIDEO_PROFILE_LANDSCAPE_480P_6

  45: 480 × 480, frame rate 30 fps, bitrate 600 Kbps.

- VIDEO_PROFILE_LANDSCAPE_480P_8

  47: 848 × 480, frame rate 15 fps, bitrate 610 Kbps.

- VIDEO_PROFILE_LANDSCAPE_480P_9

  48: 848 × 480, frame rate 30 fps, bitrate 930 Kbps.

- VIDEO_PROFILE_LANDSCAPE_480P_10

  49: 640 × 480, frame rate 10 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_LANDSCAPE_720P

  50: 1280 × 720, frame rate 15 fps, bitrate 1130 Kbps.

- VIDEO_PROFILE_LANDSCAPE_720P_3

  52: 1280 × 720, frame rate 30 fps, bitrate 1710 Kbps.

- VIDEO_PROFILE_LANDSCAPE_720P_5

  54: 960 × 720, frame rate 15 fps, bitrate 910 Kbps.

- VIDEO_PROFILE_LANDSCAPE_720P_6

  55: 960 × 720, frame rate 30 fps, bitrate 1380 Kbps.

- VIDEO_PROFILE_LANDSCAPE_1080P

  60: 1920 × 1080, frame rate 15 fps, bitrate 2080 Kbps.

- VIDEO_PROFILE_LANDSCAPE_1080P_3

  60: 1920 × 1080, frame rate 30 fps, bitrate 3150 Kbps.

- VIDEO_PROFILE_LANDSCAPE_1080P_5

  64: 1920 × 1080, frame rate 60 fps, bitrate 4780 Kbps.

- VIDEO_PROFILE_PORTRAIT_120P

  1000: 120 × 160, frame rate 15 fps, bitrate 65 Kbps.

- VIDEO_PROFILE_PORTRAIT_120P_3

  1002: 120 × 120, frame rate 15 fps, bitrate 50 Kbps.

- VIDEO_PROFILE_PORTRAIT_180P

  1010: 180 × 320, frame rate 15 fps, bitrate 140 Kbps.

- VIDEO_PROFILE_PORTRAIT_180P_3

  1012: 180 × 180, frame rate 15 fps, bitrate 100 Kbps.

- VIDEO_PROFILE_PORTRAIT_180P_4

  1013: 180 × 240, frame rate 15 fps, bitrate 120 Kbps.

- VIDEO_PROFILE_PORTRAIT_240P

  1020: 240 × 320, frame rate 15 fps, bitrate 200 Kbps.

- VIDEO_PROFILE_PORTRAIT_240P_3

  1022: 240 × 240, frame rate 15 fps, bitrate 140 Kbps.

- VIDEO_PROFILE_PORTRAIT_240P_4

  1023: 240 × 424, frame rate 15 fps, bitrate 220 Kbps.

- VIDEO_PROFILE_PORTRAIT_360P

  1030: 360 × 640, frame rate 15 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_PORTRAIT_360P_3

  1032: 360 × 360, frame rate 15 fps, bitrate 260 Kbps.

- VIDEO_PROFILE_PORTRAIT_360P_4

  1033: 360 × 640, frame rate 15 fps, bitrate 600 Kbps.

- VIDEO_PROFILE_PORTRAIT_360P_6

  1035: 360 × 360, frame rate 30 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_PORTRAIT_360P_7

  1036: 360 × 480, frame rate 15 fps, bitrate 320 Kbps.

- VIDEO_PROFILE_PORTRAIT_360P_8

  1037: 360 × 480, frame rate 30 fps, bitrate 490 Kbps.

- VIDEO_PROFILE_PORTRAIT_360P_9

  1038: 360 × 640, frame rate 15 fps, bitrate 800 Kbps.**Note** This profile applies only to the live streaming channel profile.

- VIDEO_PROFILE_PORTRAIT_360P_10

  1039: 360 × 640, frame rate 24 fps, bitrate 800 Kbps.**Note** This profile applies only to the live streaming channel profile.

- VIDEO_PROFILE_PORTRAIT_360P_11

  1100: 360 × 640, frame rate 24 fps, bitrate 1000 Kbps.**Note** This profile applies only to the live streaming channel profile.

- VIDEO_PROFILE_PORTRAIT_480P

  1040: 480 × 640, frame rate 15 fps, bitrate 500 Kbps.

- VIDEO_PROFILE_PORTRAIT_480P_3

  1042: 480 × 480, frame rate 15 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_PORTRAIT_480P_4

  1043: 480 × 640, frame rate 30 fps, bitrate 750 Kbps.

- VIDEO_PROFILE_PORTRAIT_480P_6

  1045: 480 × 480, frame rate 30 fps, bitrate 600 Kbps.

- VIDEO_PROFILE_PORTRAIT_480P_8

  1047: 480 × 848, frame rate 15 fps, bitrate 610 Kbps.

- VIDEO_PROFILE_PORTRAIT_480P_9

  1048: 480 × 848, frame rate 30 fps, bitrate 930 Kbps.

- VIDEO_PROFILE_PORTRAIT_480P_10

  1049: 480 × 640, frame rate 10 fps, bitrate 400 Kbps.

- VIDEO_PROFILE_PORTRAIT_720P

  1050: 720 × 1280, frame rate 15 fps, bitrate 1130 Kbps.

- VIDEO_PROFILE_PORTRAIT_720P_3

  1052: 720 × 1280, frame rate 30 fps, bitrate 1710 Kbps.

- VIDEO_PROFILE_PORTRAIT_720P_5

  1054: 720 × 960, frame rate 15 fps, bitrate 910 Kbps.

- VIDEO_PROFILE_PORTRAIT_720P_6

  1055: 720 × 960, frame rate 30 fps, bitrate 1380 Kbps.

- VIDEO_PROFILE_PORTRAIT_1080P

  1060: 1080 × 1920, frame rate 15 fps, bitrate 2080 Kbps.

- VIDEO_PROFILE_PORTRAIT_1080P_3

  1062: 1080 × 1920, frame rate 30 fps, bitrate 3150 Kbps.

- VIDEO_PROFILE_PORTRAIT_1080P_5

  1064: 1080 × 1920, frame rate 60 fps, bitrate 4780 Kbps.

- VIDEO_PROFILE_DEFAULT

  (Default) 640 × 360, frame rate 15 fps, bitrate 400 Kbps.

## [VIDEO_SOURCE_TYPE](rtc_api_data_type.html#enum_videosourcetype)

The capture type of the custom video source.

### Enumerator

- VIDEO_SOURCE_CAMERA_PRIMARY

  (Default) The primary camera.

- VIDEO_SOURCE_CAMERA

  The camera.

- VIDEO_SOURCE_CAMERA_SECONDARY

  The secondary camera.

- VIDEO_SOURCE_SCREEN_PRIMARY

  The primary screen.

- VIDEO_SOURCE_SCREEN

  The screen.

- VIDEO_SOURCE_SCREEN_SECONDARY

  The secondary screen.

- VIDEO_SOURCE_CUSTOM

  The custom video source.

- VIDEO_SOURCE_MEDIA_PLAYER

  The video source from the media player.

- VIDEO_SOURCE_RTC_IMAGE_PNG

  The video source is a PNG image.

- VIDEO_SOURCE_RTC_IMAGE_JPEG

  The video source is a JPEG image.

- VIDEO_SOURCE_RTC_IMAGE_GIF

  The video source is a GIF image.

- VIDEO_SOURCE_REMOTE

  The video source is remote video acquired by the network.

- VIDEO_SOURCE_TRANSCODED

  A transcoded video source.

- VIDEO_SOURCE_UNKNOWN

  An unknown video source.

**Note**

- VIDEO_SOURCE_CAMERA_PRIMARY and VIDEO_SOURCE_CAMERA are the same video source.
- VIDEO_SOURCE_SCREEN_PRIMARY and VIDEO_SOURCE_SCREEN are the same video source.

**See also**

- [enableDualStreamMode [2/3\]](../API/class_irtcengine.html#api_enabledualstreammode2)
- [enableDualStreamMode [3/3\]](../API/class_irtcengine.html#api_enabledualstreammode3)
- [setCameraDeviceOrientation](../API/class_irtcengine.html#api_setcameradeviceorientation)

## [VOICE_BEAUTIFIER_PRESET](rtc_api_data_type.html#enum_voicebeautifierpreset)

The options for SDK preset voice beautifier effects.

### Enumerator

- VOICE_BEAUTIFIER_OFF

  Turn off voice beautifier effects and use the original voice.

- CHAT_BEAUTIFIER_MAGNETIC

  A more magnetic voice.**Note** Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion.

- CHAT_BEAUTIFIER_FRESH

  A fresher voice.**Note** Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.

- CHAT_BEAUTIFIER_VITALITY

  A more vital voice.**Note** Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.

- SINGING_BEAUTIFIER

  Singing beautifier effect.If you call [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset)(SINGING_BEAUTIFIER), you can beautify a male-sounding voice and add a reverberation effect that sounds like singing in a small room. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you might experience vocal distortion.If you call [setVoiceBeautifierParameters](class_irtcengine.html#api_setvoicebeautifierparameters)(SINGING_BEAUTIFIER, param1, param2), you can beautify a male- or female-sounding voice and add a reverberation effect.

- TIMBRE_TRANSFORMATION_VIGOROUS

  A more vigorous voice.

- TIMBRE_TRANSFORMATION_DEEP

  A deep voice.

- TIMBRE_TRANSFORMATION_MELLOW

  A mellower voice.

- TIMBRE_TRANSFORMATION_FALSETTO

  Falsetto.

- TIMBRE_TRANSFORMATION_FULL

  A fuller voice.

- TIMBRE_TRANSFORMATION_CLEAR

  A clearer voice.

- TIMBRE_TRANSFORMATION_RESOUNDING

  A more resounding voice.

- TIMBRE_TRANSFORMATION_RINGING

  A more ringing voice.

- ULTRA_HIGH_QUALITY_VOICE

  A ultra-high quality voice, which makes the audio clearer and restores more details.To achieve better audio effect quality, Agora recommends that you call [setAudioProfile [2/2\]](class_irtcengine.html#api_setaudioprofile2) and set the **profile** to AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4) or AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO (5) and **scenario** to AUDIO_SCENARIO_HIGH_DEFINITION (6) before calling [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset).If you have an audio capturing device that can already restore audio details to a high degree, Agora recommends that you do not enable ultra-high quality; otherwise, the SDK may over-restore audio details, and you may not hear the anticipated voice effect.

**See also**

- [setVoiceBeautifierPreset](../API/class_irtcengine.html#api_setvoicebeautifierpreset)

## [VOICE_CHANGER_PRESET](rtc_api_data_type.html#enum_voicechangerpreset)

Local voice changer options.

- Deprecated

  Deprecated as of v3.2.0.

### Enumerator

- VOICE_CHANGER_OFF

  The original voice (no local voice change).

- VOICE_CHANGER_OLDMAN

  The voice of an old man.

- VOICE_CHANGER_BABYBOY

  The voice of a little boy.

- VOICE_CHANGER_BABYGIRL

  The voice of a little girl.

- VOICE_CHANGER_ZHUBAJIE

  The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a growling bear.

- VOICE_CHANGER_ETHEREAL

  The ethereal voice.

- VOICE_CHANGER_HULK

  The voice of Hulk.

- VOICE_BEAUTY_VIGOROUS

  A more vigorous voice.

- VOICE_BEAUTY_DEEP

  A deeper voice.

- VOICE_BEAUTY_MELLOW

  A mellower voice.

- VOICE_BEAUTY_FALSETTO

  Falsetto.

- VOICE_BEAUTY_FULL

  A fuller voice.

- VOICE_BEAUTY_CLEAR

  A clearer voice.

- VOICE_BEAUTY_RESOUNDING

  A more resounding voice.

- VOICE_BEAUTY_RINGING

  A more ringing voice.

- VOICE_BEAUTY_SPACIAL

  A more spatially resonant voice.

- GENERAL_BEAUTY_VOICE_MALE_MAGNETIC

  (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice distortion occurs.

- GENERAL_BEAUTY_VOICE_FEMALE_FRESH

  (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.

- GENERAL_BEAUTY_VOICE_FEMALE_VITALITY

  (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.

**See also**

- [setLocalVoiceChanger](../API/class_irtcengine.html#api_setlocalvoicechanger)

## [VOICE_CONVERSION_PRESET](rtc_api_data_type.html#enum_voiceconversionpreset)

The options for SDK preset voice conversion effects.



### Enumerator

- VOICE_CONVERSION_OFF

  Turn off voice conversion effects and use the original voice.

- VOICE_CHANGER_NEUTRAL

  A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.

- VOICE_CHANGER_SWEET

  A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.

- VOICE_CHANGER_SOLID

  A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.

- VOICE_CHANGER_BASS

  A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.

**See also**

- [setVoiceConversionPreset](../API/class_irtcengine.html#api_setvoiceconversionpreset)

## [AgoraRhythmPlayerConfig](rtc_api_data_type.html#class_agorarhythmplayerconfig)

The metronome configuration.

```cpp
struct AgoraRhythmPlayerConfig {
  int beatsPerMeasure;
  int beatsPerMinute;

  AgoraRhythmPlayerConfig() : beatsPerMeasure(4), beatsPerMinute(60) {}
};
```



### Attributes

- beatsPerMeasure

  The number of beats per measure, which ranges from 1 to 9. The default value is 4, which means that each measure contains one downbeat and three upbeats.

- beatsPerMinute

  The beat speed (beats/minute), which ranges from 60 to 360. The default value is 60, which means that the metronome plays 60 beats in one minute.

**See also**

- [startRhythmPlayer](../API/class_irtcengine.html#api_startrhythmplayer)
- [configRhythmPlayer](../API/class_irtcengine.html#api_configrhythmplayer)

## [AudioEncodedFrameObserverConfig](rtc_api_data_type.html#class_audioencodedframeobserverconfig)

Observer settings for the encoded audio.

```cpp
struct AudioEncodedFrameObserverConfig {
    AUDIO_ENCODED_FRAME_OBSERVER_POSITION postionType;
    AUDIO_ENCODING_TYPE encodingType;
    AudioEncodedFrameObserverConfig()
    : postionType(AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK),
      encodingType(AUDIO_ENCODING_TYPE_OPUS_48000_MEDIUM){}
};
```

### Attributes

- postionType

  Audio profile. For details, see [AUDIO_ENCODED_FRAME_OBSERVER_POSITION](rtc_api_data_type.html#enum_audioencodedframeobserverposition).

- encodingType

  Audio encoding type. For details, see [AUDIO_ENCODING_TYPE](rtc_api_data_type.html#enum_audioencodingtype).

**See also**

- [registerAudioEncodedFrameObserver](../API/class_irtcengine.html#api_registeraudioencodedframeobserver)

## [AudioRecordingConfiguration](rtc_api_data_type.html#class_audiorecordingconfiguration_ng)

Recording configuration.

```cpp
struct AudioRecordingConfiguration {
  const char* filePath;
  bool encode;
  int sampleRate;
  AUDIO_FILE_RECORDING_TYPE fileRecordingType;
  AUDIO_RECORDING_QUALITY_TYPE quality;

  AudioRecordingConfiguration()
    : filePath(NULL),
      encode(false),
      sampleRate(32000),
      fileRecordingType(AUDIO_FILE_RECORDING_MIXED),
      quality(AUDIO_RECORDING_QUALITY_LOW) {}

  AudioRecordingConfiguration(const char* file_path, int sample_rate, AUDIO_RECORDING_QUALITY_TYPE quality_type)
    : filePath(file_path),
      encode(false),
      sampleRate(sample_rate),
      fileRecordingType(AUDIO_FILE_RECORDING_MIXED),
      quality(quality_type) {}

  AudioRecordingConfiguration(const char* file_path, bool enc, int sample_rate, AUDIO_FILE_RECORDING_TYPE type, AUDIO_RECORDING_QUALITY_TYPE quality_type)
    : filePath(file_path),
      encode(enc),
      sampleRate(sample_rate),
      fileRecordingType(type),
      quality(quality_type) {}

  AudioRecordingConfiguration(const AudioRecordingConfiguration &rhs)
    : filePath(rhs.filePath),
      encode(rhs.encode),
      sampleRate(rhs.sampleRate),
      fileRecordingType(rhs.fileRecordingType),
      quality(rhs.quality) {}
};
```

### Attributes

- filePath

  The absolute path (including the filename extensions) of the recording file. For example: `C:\music\audio.mp4`.**Note**Ensure that the directory for the log files exists and is writable.

- encode

  Whether to encode the audio data:`true`: Encode audio data in AAC.`false`: (Default) Do not encode audio data, but save the recorded audio data directly.

- sampleRate

  Recording sample rate (Hz).16000(Default) 320004410048000**Note**If you set this parameter to 44100 or 48000, Agora recommends recording WAV files, or AAC files with **quality** to be AUDIO_RECORDING_QUALITY_MEDIUM or AUDIO_RECORDING_QUALITY_HIGH for better recording quality.

- fileRecordingType

  The recording content. See [AUDIO_RECORDING_POSITION](rtc_api_data_type.html#enum_audiorecordingposition).

- quality

  Recording quality. See [AUDIO_RECORDING_QUALITY_TYPE](rtc_api_data_type.html#enum_audiorecordingqualitytype).**Note**Note: This parameter applies to AAC files only.

**See also**

- [startAudioRecording](../API/class_irtcengine.html#api_startaudiorecording3_ng)

## [AudioSpectrumData](rtc_api_data_type.html#class_audiospectrumdata)

The audio spectrum data.

```cpp
struct AudioSpectrumData {
  const float *audioSpectrumData;
  int dataLength;

  AudioSpectrumData() : audioSpectrumData(NULL), dataLength(0) {}
  AudioSpectrumData(const float *data, int length) :
    audioSpectrumData(data), dataLength(length) {}
};
```

### Attributes

- AudioSpectrumData

  The audio spectrum data. Agora divides the audio frequency into 160 frequency domains, and reports the energy value of each frequency domain through this parameter. The value range of each energy type is [0, 1].

- dataLength

  The length of the audio spectrum data in byte.

**See also**

- [onLocalAudioSpectrum](../API/class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onlocalaudiospectrum)

## [AudioVolumeInfo](rtc_api_data_type.html#class_audiovolumeinfo)

The volume information of users.

```cpp
struct AudioVolumeInfo {
                    uid_t uid;
                    unsigned int volume;
                    unsigned int vad;
                    double voicePitch;
                    AudioVolumeInfo() : uid(0), volume(0), vad(0), voicePitch(0.0) {}
                    };
```

### Attributes

- uid

  The user ID.In the local user's callback, **uid** = 0.In the remote users' callback, **uid** is the user ID of a remote user whose instantaneous volume is one of the three highest.

- volume

  The volume of the user. The value ranges between 0 (lowest volume) and 255 (highest volume). If the user calls [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2), the value of **volume** is the volume after audio mixing.

- vad

  The voice activity status of the local user.0: The local user is not speaking.1: The local user is speaking.**Note**The **vad** parameter does not report the voice activity status of remote users. In the remote users' callback, the value of **vad** is always 0.To use this parameter, you must set **reportVad** to `true` when calling [enableAudioVolumeIndication](class_irtcengine.html#api_enableaudiovolumeindication).

- voicePitch

  The voice pitch of the local user. The value ranges between 0.0 and 4000.0.**Note** The **voicePitch** parameter does not report the voice pitch of remote users. In the remote users' callback, the value of **voicePitch** is always 0.

**See also**

- [onAudioVolumeIndication](../API/class_irtcengineeventhandler.html#callback_onaudiovolumeindication)

## [BeautyOptions](rtc_api_data_type.html#class_beautyoptions)

Image enhancement options.

```cpp
struct BeautyOptions {
    enum LIGHTENING_CONTRAST_LEVEL {
        LIGHTENING_CONTRAST_LOW = 0,
        LIGHTENING_CONTRAST_NORMAL,
        LIGHTENING_CONTRAST_HIGH
    };
    LIGHTENING_CONTRAST_LEVEL lighteningContrastLevel;
    float lighteningLevel;
    float smoothnessLevel;
    float rednessLevel;
    float sharpnessLevel;
    BeautyOptions(LIGHTENING_CONTRAST_LEVEL contrastLevel, float lightening, float smoothness, float redness, float sharpness) : lighteningContrastLevel(contrastLevel), lighteningLevel(lightening), smoothnessLevel(smoothness), rednessLevel(redness), sharpnessLevel(sharpness) {}
    BeautyOptions() : lighteningContrastLevel(LIGHTENING_CONTRAST_NORMAL), lighteningLevel(0), smoothnessLevel(0), rednessLevel(0), sharpnessLevel(0) {}
};
```

### Attributes

- lighteningContrastLevel

  The contrast level. For details, see [LIGHTENING_CONTRAST_LEVEL](rtc_api_data_type.html#enum_lighteningcontrastlevel).

- lighteningLevel

  The brightness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. This parameter makes video whitening.

- smoothnessLevel

  The smoothness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. This parameter is usually used to remove blemishes.

- rednessLevel

  The redness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. This parameter adjusts the red saturation level.

- sharpnessLevel

  The sharpness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0.

**See also**

- [setBeautyEffectOptions](../API/class_irtcengine.html#api_setbeautyeffectoptions)

## [CameraCapturerConfiguration](rtc_api_data_type.html#class_cameracapturerconfiguration_ng)

The camera capturer preference.

```cpp
struct CameraCapturerConfiguration {
  CAMERA_DIRECTION cameraDirection;
  char deviceId[MAX_DEVICE_ID_LENGTH];
  VideoFormat format;
};
```

### Attributes

- cameraDirection

  **Note** This parameter applies to Android and iOS only.The camera direction. For details, see [CAMERA_DIRECTION](rtc_api_data_type.html#enum_cameradirection).

- format

  For details, see [VideoFormat](rtc_api_data_type.html#class_videoformat_ng).

- deviceId

  The device ID of the playback device. The maximum length is [MAX_DEVICE_ID_LENGTH_TYPE](rtc_api_data_type.html#enum_maxdeviceidlengthtype).

**See also**

- [setCameraCapturerConfiguration](../API/class_irtcengine.html#api_setcameracapturerconfiguration)
- [startPrimaryCameraCapture](../API/class_irtcengine.html#api_startprimarycameracapture)
- [startSecondaryCameraCapture](../API/class_irtcengine.html#api_startsecondarycameracapture)

## [ChannelMediaInfo](rtc_api_data_type.html#class_channelmediainfo)

The definition of ChannelMediaInfo.

```cpp
struct ChannelMediaInfo {
	const char* channelName;
	const char* token;
	uid_t uid;
    };
```

### Attributes

- channelName

  The name of the channel.

- token

  The token that enables the user to join the channel.

- uid

  User ID.

**See also**

- [startChannelMediaRelay](../API/class_irtcengine.html#api_startchannelmediarelay)
- [updateChannelMediaRelay](../API/class_irtcengine.html#api_updatechannelmediarelay)

## [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng)

The channel media options.

```cpp
struct ChannelMediaOptions {
  Optional<bool> publishCameraTrack;
  Optional<bool> publishSecondaryCameraTrack;
  Optional<bool> publishAudioTrack;
  Optional<bool> publishScreenTrack;
  Optional<bool> publishSecondaryScreenTrack;
  Optional<bool> publishCustomAudioTrack;
  Optional<bool> publishCustomAudioTrackEnableAec;
  Optional<bool> publishCustomVideoTrack;
  Optional<bool> publishEncodedVideoTrack;
  Optional<bool> publishMediaPlayerAudioTrack;
  Optional<bool> publishMediaPlayerVideoTrack;
  Optional<bool> publishTrancodedVideoTrack;
  Optional<int> publishCustomAudioSourceId;
  Optional<bool> autoSubscribeAudio;
  Optional<bool> autoSubscribeVideo;
  Optional<bool> enableAudioRecordingOrPlayout;
  Optional<int> publishMediaPlayerId;
  Optional<CLIENT_ROLE_TYPE> clientRoleType;
  Optional<VIDEO_STREAM_TYPE> defaultVideoStreamType;
  Optional<CHANNEL_PROFILE_TYPE> channelProfile;
  Optional<int> audioDelayMs;
  Optional<char*> token;
  ChannelMediaOptions() {}
  ~ChannelMediaOptions() {}
```

### Attributes

- publishCameraTrack

  Whether to publish the video captured by the camera:`true`: Publish the video captured by the camera.`false`: Do not publish the video captured by the camera.

- publishSecondaryCameraTrack

  Whether to publish the video captured by the camera:`true`: Publish the video captured by the second camera.`false`: Do not publish the video captured by the second camera.

- publishAudioTrack

  Whether to publish the captured audio:`true`: Publish the captured audio.`false`: Do not publish the captured audio.

- publishScreenTrack

  Whether to publish the captured video from the screen:`true`: Publish the captured video from the screen.`false`: Do not publish the captured video from the screen.

- publishSecondaryScreenTrack

  Whether to publish the captured video from the second screen:`true`: Publish the captured video from the second screen.`false`: Do not publish the captured video from the second screen.

- publishTrancodedVideoTrack

  Whether to publish the local transcoded video.`true: Publish the local transcoded video.``false: Do not publish the local transcoded video.`

- publishCustomAudioTrack

  Whether to publish the captured audio from a custom source:`true`: Publish the captured audio from a custom source.`false`: Do not publish the captured audio from a custom source.

- publishCustomAudioSourceId

  The ID of the custom audio source to publish. The default value is 0.If you have set the value of **sourceNumber** greater than 1 in [setExternalAudioSource](class_imediaengine.html#api_setexternalaudiosource2), the SDK creates the corresponding number of custom audio tracks and assigns an ID to each audio track starting from 0.

- publishCustomAudioTrackEnableAec

  Whether to enable AEC when publishing the captured audio from a custom source:`true`: Enable AEC when publishing the captured audio from a custom source.`false`: Do not enable AEC when publishing the captured audio from a custom source.

- publishCustomVideoTrack

  Whether to publish the captured video from a custom source:`true`: Publish the captured video from a custom source.`false`: Do not publish the captured video from a custom source.

- publishEncodedVideoTrack

  Whether to publish the encoded video:`true`: Publish the encoded video.`false`: Do not publish the encoded video.

- publishMediaPlayerAudioTrack

  Whether to publish the audio from the media player:`true`: Publish the audio from the media player.`false`: Do not publish the audio from the media player.

- publishMediaPlayerVideoTrack

  Whether to publish the video from the media player:`true`: Publish the video from the media player.`false`: Do not publish the video from the media player.

- autoSubscribeAudio

  Whether to automatically subscribe to all remote audio streams when the user joins a channel:`true`: Subscribe to all remote audio streams.`false`: Do not subscribe to any remote audio stream.

- autoSubscribeVideo

  Whether to subscribe to all remote video streams when the user joins the channel:`true`: Subscribe to all remote video streams.`false`: Do not subscribe to any remote video stream.

- enableAudioRecordingOrPlayout

  Whether to enable audio capturing or playback.`true`: Enable audio capturing and playback.`false`: Do not enable audio capturing or playback.

- publishMediaPlayerId

  The ID of the media player to be published. The default value is 0.

- clientRoleType

  The user role. For details, see [CLIENT_ROLE_TYPE](rtc_api_data_type.html#enum_clientroletype).

- defaultVideoStreamType

  The default stream type of the remote video, see [REMOTE_VIDEO_STREAM_TYPE](rtc_api_data_type.html#enum_remotevideostreamtype).

- channelProfile

  The channel profile. For details, see [CHANNEL_PROFILE_TYPE](rtc_api_data_type.html#enum_channelprofiletype_ng).

- audioDelayMs

  The delay in ms for sending audio frames. This is used for explicit control of A/V sync.To switch off the delay, set the value to 0.

- token

  (Optional) The token generated on your server for authentication. See [Authenticate Your Users with Token](https://docs.agora.io/en/live-streaming-4.x-preview/token_server_android_ng?platform=Windows).**警告：**This parameter takes effect only when calling [updateChannelMediaOptions](class_irtcengine.html#api_updatechannelmediaoptions) or [updateChannelMediaOptionsEx](class_irtcengineex.html#api_irtcengineex_updatechannelmediaoptionsex).Ensure that the App ID, channel name, and user name used for creating the token are the same ones as those used by the [initialize](class_irtcengine.html#api_create2) method for initializing the RTC engine, and those used by the [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng) and [joinChannelEx](class_irtcengineex.html#api_irtcengineex_joinchannelex) methods for joining the channel.

**See also**

- [joinChannel [2/2\]](../API/class_irtcengine.html#api_joinchannel2_ng)
- [joinChannelWithUserAccount [2/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount2)
- [joinChannelWithUserAccountEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelwithuseraccountex)
- [joinChannelEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelex)
- [updateChannelMediaOptions](../API/class_irtcengine.html#api_updatechannelmediaoptions)
- [updateChannelMediaOptionsEx](../API/class_irtcengineex.html#api_irtcengineex_updatechannelmediaoptionsex)

## [ChannelMediaRelayConfiguration](rtc_api_data_type.html#class_channelmediarelayconfiguration)

The definition of ChannelMediaRelayConfiguration.

```cpp
struct ChannelMediaRelayConfiguration {
	ChannelMediaInfo *srcInfo;
	ChannelMediaInfo *destInfos;
	int destCount;

	ChannelMediaRelayConfiguration()
			: srcInfo(nullptr)
			, destInfos(nullptr)
			, destCount(0)
	{}
    };
```

### Attributes

- srcInfo

  The information of the source channel [ChannelMediaInfo](rtc_api_data_type.html#class_channelmediainfo). It contains the following members:channelName: The name of the source channel. The default value is , which means the SDK applies the name of the current channel.```NULL``uid`: The unique ID to identify the relay stream in the source channel. The default value is 0, which means the SDK generates a random `UID`. You must set it as 0.`token`: The token for joining the source channel``. It is generated with the `channelName` and `uid` you set in `srcInfo`.If you have not enabled the App Certificate, set this parameter as the default value `NULL` , which means the SDK applies the App ID.If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`, and the `uid` must be set as 0.

- destInfos

  The information of the destination channel ChannelMediaInfo. It contains the following members:`channelName`: The name of the destination channel.`uid`: The unique ID to identify the relay stream in the destination channel. The value ranges from 0 to (232-1). To avoid UID conflicts, this `UID` must be different from any other `UID` in the destination channel. The default value is 0, which means the SDK generates a random `UID`. Do not set this parameter as the `UID` of the host in the destination channel, and ensure that this `UID` is different from any other `UID` in the channel.`token`: The `token` for joining the destination channel. It is generated with the `channelName` and `uid` you set in `destInfos`.If you have not enabled the App Certificate, set this parameter as the default value `NULL` , which means the SDK applies the App ID.If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`.

- destCount

  The number of destination channels. The default value is 0, and the value range is from 0 to 4. Ensure that the value of this parameter corresponds to the number of ChannelMediaInfo structs you define in `destInfo`.

**See also**

- [startChannelMediaRelay](../API/class_irtcengine.html#api_startchannelmediarelay)
- [updateChannelMediaRelay](../API/class_irtcengine.html#api_updatechannelmediarelay)

## [ClientRoleOptions](rtc_api_data_type.html#class_clientroleoptions)

The detailed options of a user.



```cpp
struct ClientRoleOptions {
    AUDIENCE_LATENCY_LEVEL_TYPE audienceLatencyLevel;
    ClientRoleOptions()
        : audienceLatencyLevel(AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY) {}
    };
```

### Attributes

- audienceLatencyLevel

  The latency level of an audience member in interactive live streaming. See [AUDIENCE_LATENCY_LEVEL_TYPE](rtc_api_data_type.html#enum_audiencelatencyleveltype).

**See also**

- [setClientRole [2/2\]](../API/class_irtcengine.html#api_setclientrole2)

## [DataStreamConfig](rtc_api_data_type.html#class_datastreamconfig)

The configurations for the data stream.

```cpp
struct DataStreamConfig {
    bool syncWithAudio;
    bool ordered;
    };
```

The following table shows the SDK behaviors under different parameter settings:

| `syncWithAudio` | `ordered` | SDK behaviors                                                |
| --------------- | --------- | ------------------------------------------------------------ |
| `false`         | `false`   | The SDK triggers the [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage) callback immediately after the receiver receives a data packet. |
| `true`          | `false`   | If the data packet delay is within the audio delay, the SDK triggers the [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage) callback when the synchronized audio packet is played out. If the data packet delay exceeds the audio delay, the SDK triggers the [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage) callback as soon as the data packet is received. |
| `false`         | `true`    | If the delay of a data packet is less than five seconds, the SDK corrects the order of the data packet. If the delay of a data packet exceeds five seconds, the SDK discards the data packet. |
| `true`          | `true`    | If the delay of the data packet is within the range of the audio delay, the SDK corrects the order of the data packet. If the delay of a data packet exceeds the audio delay, the SDK discards this data packet. |

### Attributes

- syncWithAudio

  Whether to synchronize the data packet with the published audio packet.`true`: Synchronize the data packet with the audio packet.`false`: Do not synchronize the data packet with the audio packet.When you set the data packet to synchronize with the audio, then if the data packet delay is within the audio delay, the SDK triggers the [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage) callback when the synchronized audio packet is played out. Do not set this parameter as true if you need the receiver to receive the data packet immediately. Agora recommends that you set this parameter to `true` only when you need to implement specific functions, for example lyric synchronization.

- ordered

  Whether the SDK guarantees that the receiver receives the data in the sent order.`true`: Guarantee that the receiver receives the data in the sent order.`false`: Do not guarantee that the receiver receives the data in the sent order.Do not set this parameter as `true` if you need the receiver to receive the data packet immediately.

**See also**

- [createDataStream [2/2\]](../API/class_irtcengine.html#api_createdatastream2)
- [createDataStreamEx [2/2\]](../API/class_irtcengineex.html#api_irtcengineex_createdatastreamex2)

## [DeviceInfo](rtc_api_data_type.html#class_deviceinfo)

The audio device information.

```cpp
struct DeviceInfo {
  bool isLowLatencyAudioSupported;

  DeviceInfo() : isLowLatencyAudioSupported(false) {}
};
```

**Note** This class is for Android only.

### Attributes

- isLowLatencyAudioSupported

  Whether the audio device supports ultra-low-latency capture and playback:`true`: The device supports ultra-low-latency capture and playback.`false`: The device does not support ultra-low-latency capture and playback.

## [EncodedAudioFrameInfo](rtc_api_data_type.html#class_encodedaudioframeinfo)

Audio information after encoding.

```cpp
struct EncodedAudioFrameInfo {
  EncodedAudioFrameInfo()
      : codec(AUDIO_CODEC_AACLC),
        sampleRateHz(0),
        samplesPerChannel(0),
        numberOfChannels(0) {}
  EncodedAudioFrameInfo(const EncodedAudioFrameInfo& rhs)
      : codec(rhs.codec),
        sampleRateHz(rhs.sampleRateHz),
        samplesPerChannel(rhs.samplesPerChannel),
        numberOfChannels(rhs.numberOfChannels),
        advancedSettings(rhs.advancedSettings) {}
  AUDIO_CODEC_TYPE codec;
  int sampleRateHz;
  int samplesPerChannel;
  int numberOfChannels;
  EncodedAudioFrameAdvancedSettings advancedSettings;
};
```

### Attributes

- codec

  Audio Codec type:[AUDIO_CODEC_TYPE](rtc_api_data_type.html#enum_audiocodectype)

- sampleRateHz

  Audio sample rate (Hz).

- samplesPerChannel

  The number of audio samples per channel.

- numberOfChannels:

  The number of audio channels.

- advancedSettings

  This function is currently not supported.

**See also**

- [OnPlaybackAudioEncodedFrame](../API/class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onplaybackaudioencodedframe)
- [OnRecordAudioEncodedFrame](../API/class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onrecordaudioencodedframe)
- [OnMixedAudioEncodedFrame](../API/class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onmixedaudioencodedframe)

## [EncodedVideoFrameInfo](rtc_api_data_type.html#class_encodedvideoframeinfo)

Information about externally encoded video frames.

```cpp
struct EncodedVideoFrameInfo {
                    EncodedVideoFrameInfo()
                    : codecType(VIDEO_CODEC_H264),
                    width(0),
                    height(0),
                    framesPerSecond(0),
                    frameType(VIDEO_FRAME_TYPE_BLANK_FRAME),
                    rotation(VIDEO_ORIENTATION_0),
                    trackId(0),
                    renderTimeMs(0),
                    uid(0),
                    streamType(VIDEO_STREAM_HIGH) {}
                    EncodedVideoFrameInfo(const EncodedVideoFrameInfo& rhs)
                    : codecType(rhs.codecType),
                    width(rhs.width),
                    height(rhs.height),
                    framesPerSecond(rhs.framesPerSecond),
                    frameType(rhs.frameType),
                    rotation(rhs.rotation),
                    trackId(rhs.trackId),
                    renderTimeMs(rhs.renderTimeMs),
                    uid(rhs.uid),
                    streamType(rhs.streamType) {}
                    VIDEO_CODEC_TYPE codecType;
                    int width;
                    int height;
                    int framesPerSecond;
                    VIDEO_FRAME_TYPE frameType;
                    VIDEO_ORIENTATION rotation;
                    int trackId;
                    int64_t renderTimeMs;
                    uid_t uid;
                    VIDEO_STREAM_TYPE streamType;
                    };
                
```

### Attributes

- codecType

  The codec type of the local video stream. See [VIDEO_CODEC_TYPE](rtc_api_data_type.html#enum_videocodectype). The default value is `VIDEO_CODEC_H264 (2)`.

- width

  Width (pixel) of the video frame.

- height

  Height (pixel) of the video frame.

- framesPerSecond

  The number of video frames per second.When this parameter is not `0`, you can use it to calculate the Unix timestamp of externally encoded video frames.

- frameType

  The video frame type, see [VIDEO_FRAME_TYPE](rtc_api_data_type.html#enum_videoframetype_ng).

- rotation

  The rotation information of the video frame, see [VIDEO_ORIENTATION](rtc_api_data_type.html#enum_videoorientation).

- trackId

  Reserved for future use.

  The track ID. Used in scenarios with multiple video tracks in the channel.

- renderTimeMs

  The Unix timestamp (ms) for rendering externally encoded video frames.

- uid

  The user ID to push the externally encoded video frame.

- streamType

  The type of video streams.

**See also**

- [pushEncodedVideoImage [1/2\]](../API/class_imediaengine.html#api_imediaengine_pushencodedvideoimage)
- [OnEncodedVideoImageReceived](../API/class_ivideoencodedimagereceiver.html#callback_ivideoencodedimagereceiver_onencodedvideoimagereceived)

## [EncryptionConfig](rtc_api_data_type.html#class_encryptionconfig)

Built-in encryption configurations.

```cpp
struct EncryptionConfig {
  ENCRYPTION_MODE encryptionMode;
  const char* encryptionKey;
  uint8_t encryptionKdfSalt[32];

  EncryptionConfig()
    : encryptionMode(AES_128_GCM2),
      encryptionKey(NULL)
  {
    memset(encryptionKdfSalt, 0, sizeof(encryptionKdfSalt));
  }

  const char* getEncryptionString() const {
    switch(encryptionMode) {
      case AES_128_XTS:
        return "aes-128-xts";
      case AES_128_ECB:
        return "aes-128-ecb";
      case AES_256_XTS:
        return "aes-256-xts";
      case SM4_128_ECB:
        return "sm4-128-ecb";
      case AES_128_GCM:
        return "aes-128-gcm";
      case AES_256_GCM:
        return "aes-256-gcm";
      case AES_128_GCM2:
        return "aes-128-gcm-2";
      case AES_256_GCM2:
        return "aes-256-gcm-2";
      default:
        return "aes-128-gcm-2";
    }
    return "aes-128-gcm-2";
  }
};
```



### Attributes

- encryptionMode

  The built-in encryption mode. See [ENCRYPTION_MODE](rtc_api_data_type.html#enum_encryptionmode). Agora recommends using `AES_128_GCM2` or `AES_256_GCM2` encrypted mode. These two modes support the use of salt for higher security.

- encryptionKey

  Encryption key in string type.**Note** If you do not set an encryption key or set it as `NULL`, you cannot use the built-in encryption, and the SDK returns `-2`.

- encryptionKdfSalt

  Salt, 32 bytes in length. Agora recommends that you use OpenSSL to generate salt on the server side. See Media Stream Encryption for details.**Note** This parameter takes effect only in `AES_128_GCM2` or `AES_256_GCM2` encrypted mode. In this case, ensure that this parameter is not `0`.

**See also**

- [enableEncryption](../API/class_irtcengine.html#api_enableencryption)

## [ExternalVideoFrame](rtc_api_data_type.html#class_externalvideoframe_ng)

The external video frame.

```cpp
struct ExternalVideoFrame {
                    ExternalVideoFrame()
                    : type(VIDEO_BUFFER_RAW_DATA),
                    format(VIDEO_PIXEL_UNKNOWN),
                    buffer(NULL),
                    stride(0),
                    height(0),
                    cropLeft(0),
                    cropTop(0),
                    cropRight(0),
                    cropBottom(0),
                    rotation(0),
                    timestamp(0),
                    eglContext(NULL),
                    eglType(EGL_CONTEXT10),
                    textureId(0),
                    metadata_buffer(NULL),
                    metadata_size(0){}
                    enum EGL_CONTEXT_TYPE {
                    EGL_CONTEXT10 = 0,
                    EGL_CONTEXT14 = 1,
                    };
                    enum VIDEO_BUFFER_TYPE {
                    VIDEO_BUFFER_RAW_DATA = 1,
                    VIDEO_BUFFER_ARRAY = 2,
                    VIDEO_BUFFER_TEXTURE = 3,
                    };
                    VIDEO_BUFFER_TYPE type;
                    VIDEO_PIXEL_FORMAT format;
                    void* buffer;
                    int stride;
                    int height;
                    int cropLeft;
                    int cropTop;
                    int cropRight;
                    int cropBottom;
                    int rotation;
                    long long timestamp;
                    void *eglContext;
                    EGL_CONTEXT_TYPE eglType;
                    int textureId;
                    uint8_t* metadata_buffer;
                    int metadata_size;
                    };
```

### Attributes

- type

  The video buffer type. For details, see [VIDEO_BUFFER_TYPE](rtc_api_data_type.html#enum_videobuffertype).

- format

  The pixel format. For details, see [VIDEO_PIXEL_FORMAT](rtc_api_data_type.html#enum_videopixelformat).

- buffer

  Video frame buffer.

- stride

  Line spacing of the incoming video frame, which must be in pixels instead of bytes. For textures, it is the width of the texture.

- height

  Height of the incoming video frame.

- eglContext

  This parameter only applies to video data in Texture format.When using the OpenGL interface (javax.microedition.khronos.egl.*) defined by Khronos, set eglContext to this field.When using the OpenGL interface (android.opengl.*) defined by Android, set eglContext to this field.

- eglType

  This parameter only applies to video data in Texture format. Texture ID of the frame.

- textureId

  This parameter only applies to video data in Texture format. Incoming 4 x 4 transformational matrix. The typical value is a unit matrix.

- metadata_buffer

  This parameter only applies to video data in Texture format. The MetaData buffer. The default value is `NULL`.

- metadata_size

  This parameter only applies to video data in Texture format. The MetaData size. The default value is `0`.

- cropLeft

  Raw data related parameter. The number of pixels trimmed from the left. The default value is 0.

  This parameter only applies to raw video data.

- cropTop

  Raw data related parameter. The number of pixels trimmed from the top. The default value is 0.

  This parameter only applies to raw video data.

- cropRight

  Raw data related parameter. The number of pixels trimmed from the right. The default value is 0.

  This parameter only applies to raw video data.

- cropBottom

  Raw data related parameter. The number of pixels trimmed from the bottom. The default value is 0.

  This parameter only applies to raw video data.

- rotation

  Raw data related parameter. The clockwise rotation of the video frame. You can set the rotation angle as 0, 90, 180, or 270. The default value is 0.

- timestamp

  Timestamp (ms) of the incoming video frame. An incorrect timestamp results in frame loss or unsynchronized audio and video.

**See also**

- [pushVideoFrame [1/2\]](../API/class_imediaengine.html#api_imediaengine_pushvideoframe)
- [pushVideoFrame [2/2\]](../API/class_imediaengine.html#api_irtcengineex_pushvideoframeex)

## [LastmileProbeConfig](rtc_api_data_type.html#class_lastmileprobeconfig)

Configurations of the last-mile network test.

```cpp
struct LastmileProbeConfig {
    bool probeUplink;
    bool probeDownlink;
    unsigned int expectedUplinkBitrate;
    unsigned int expectedDownlinkBitrate;
    };
```

### Attributes

- probeUplink

  Sets whether to test the uplink network. Some users, for example, the audience members in a LIVE_BROADCASTING channel, do not need such a test.`true`: Test.`false`: Not test.

- probeDownlink

  Sets whether to test the downlink network:`true`: Test.`false`: Not test.

- expectedUplinkBitrate

  The expected maximum uplink bitrate (bps) of the local user. The value range is [100000, 5000000]. Agora recommends referring to [setVideoEncoderConfiguration](class_irtcengine.html#api_setvideoencoderconfiguration) to set the value.

- expectedDownlinkBitrate

  The expected maximum downlink bitrate (bps) of the local user. The value range is [100000,5000000].

**See also**

- [startLastmileProbeTest](../API/class_irtcengine.html#api_startlastmileprobetest)

## [LastmileProbeOneWayResult](rtc_api_data_type.html#class_lastmileprobeonewayresult)

Results of the uplink or downlink last-mile network test.

```cpp
struct LastmileProbeOneWayResult {
                    unsigned int packetLossRate;
                    unsigned int jitter;
                    unsigned int availableBandwidth;
                    
                    LastmileProbeOneWayResult() : packetLossRate(0),
                    jitter(0),
                    availableBandwidth(0) {}
                    };
struct LastmileProbeOneWayResult {
    unsigned int packetLossRate;
    unsigned int jitter;
    unsigned int availableBandwidth;
    };
```

### Attributes

- packetLossRate

  The packet loss rate (%).

- jitter

  The network jitter (ms).

- availableBandwidth

  The estimated available bandwidth (bps).

**See also**

- [onLastmileProbeResult](../API/class_irtcengineeventhandler.html#callback_onlastmileproberesult)

## [LastmileProbeResult](rtc_api_data_type.html#class_lastmileproberesult)

Results of the uplink and downlink last-mile network tests.

```cpp
struct LastmileProbeResult {
                    LASTMILE_PROBE_RESULT_STATE state;
                    LastmileProbeOneWayResult uplinkReport;
                    LastmileProbeOneWayResult downlinkReport;
                    unsigned int rtt;

                    LastmileProbeResult() : state(LASTMILE_PROBE_RESULT_UNAVAILABLE),
                    rtt(0) {}
                    };
```



### Attributes

- state

  The status of the last-mile network tests. See [LASTMILE_PROBE_RESULT_STATE](rtc_api_data_type.html#enum_lastmileproberesultstate).

- uplinkReport

  Results of the uplink last-mile network test. For details, see [LastmileProbeOneWayResult](rtc_api_data_type.html#class_lastmileprobeonewayresult).

- downlinkReport

  Results of the downlink last-mile network test. For details, see [LastmileProbeOneWayResult](rtc_api_data_type.html#class_lastmileprobeonewayresult).

- rtt

  The round-trip time (ms).

**See also**

- [onLastmileProbeResult](../API/class_irtcengineeventhandler.html#callback_onlastmileproberesult)

## [LeaveChannelOptions](rtc_api_data_type.html#class_leavechanneloptions)

The options for leaving a channel.

```cpp
struct LeaveChannelOptions {
  bool stopAudioMixing;
  bool stopAllEffect;
  bool stopMicrophoneRecording;
  LeaveChannelOptions() : stopAudioMixing(true), stopAllEffect(true), stopMicrophoneRecording(true) {}
};
```

### Attributes

- stopAudioMixing

  Whether to stop playing and mixing the music file when a user leaves the channel.`true`: (Default) Stop playing and mixing the music file.`false`: Do not stop playing and mixing the music file.

- stopAllEffect

  Whether to stop playing all audio effects when a user leaves the channel.`true`: (Default) Stop playing all audio effects.`false`: Do not stop playing any audio effect.

- stopMicrophoneRecording

  Whether to stop microphone recording when a user leaves the channel.`true`: (Default) Stop microphone recording.`false`: Do not stop microphone recording.

**See also**

- [leaveChannel [2/2\]](../API/class_irtcengine.html#api_leavechannel2)

## [LiveTranscoding](rtc_api_data_type.html#class_livetranscoding)

Transcoding configurations for CDN live streaming.

```cpp
struct LiveTranscoding {
  int width;
  int height;
  int videoBitrate;
  int videoFramerate;
  bool lowLatency;
  int videoGop;
  VIDEO_CODEC_PROFILE_TYPE videoCodecProfile;
  unsigned int backgroundColor;
  unsigned int userCount;
  TranscodingUser* transcodingUsers;
  const char* transcodingExtraInfo;
  const char* metadata;
  RtcImage* watermark;
  unsigned int watermarkCount;
  RtcImage* backgroundImage;
  unsigned int backgroundImageCount;
  AUDIO_SAMPLE_RATE_TYPE audioSampleRate;
  int audioBitrate;
  int audioChannels;
  AUDIO_CODEC_PROFILE_TYPE audioCodecProfile;

  LiveTranscoding()
      : width(360),
        height(640),
        videoBitrate(400),
        videoFramerate(15),
        lowLatency(false),
        videoGop(30),
        videoCodecProfile(VIDEO_CODEC_PROFILE_HIGH),
        backgroundColor(0x000000),
        userCount(0),
        transcodingUsers(NULL),
        transcodingExtraInfo(NULL),
        metadata(NULL),
        watermark(NULL),
        watermarkCount(0),
        backgroundImage(NULL),
        backgroundImageCount(0),
        audioSampleRate(AUDIO_SAMPLE_RATE_48000),
        audioBitrate(48),
        audioChannels(1),
        audioCodecProfile(AUDIO_CODEC_PROFILE_LC_AAC) {}
};
```

### Attributes

- width

  The width of the output media stream in pixels. The default value is 360.When the output media stream is video, ensure that `width` is set to 64 or higher. Otherwise, the Agora server adjusts the value to 64.When the output media stream is audio, set `width` to 0.

- height

  The height of the output media stream in pixels. The default value is 640.When the output media stream is video, ensure that `height` is set to 64 or higher. Otherwise, the Agora server adjusts the value to 64.When the output media stream is audio, set `height` to 0.

- videoBitrate

  The video bitrate (Kbps) of the output media stream. The default value is 400. You can refer to [Push Streams to CND](https://docs.agora.io/en/live-streaming-4.x-preview/cdn_streaming_windows?platform=Windows) for how to set the parameters.

- videoFrameRate

  The video frame rate (fps) of the output media stream. The default value is 15, and the value range is [1, 30].**Note** The Agora server adjusts any frame rate higher than 30 fps to 30 fps.

- lowLatency

  DeprecatedThis attribute is deprecated since v2.8.0, and Agora does not recommend it.`true`: Low latency with unassured quality.`false`: (Default) High latency with assured quality.

- videoGop

  The video GOP (Group of Pictures) of the output media stream. The default value is 30.

- videoCodecProfile

  The video encoding configuration of the output media stream. See [VIDEO_CODEC_PROFILE_TYPE](rtc_api_data_type.html#enum_videocodecprofiletype).**Note** If you set this parameter to any other value, Agora adjusts it to the default value.

- transcodingUsers

  Transcoding configurations of each host. One live streaming channel supports up to 17 hosts. For details, see [TranscodingUser](rtc_api_data_type.html#class_transcodinguser).

- transcodingExtraInfo

  The user SEI information embedded in the output media stream. This parameter is used to send SEI information to the CDN. The maximum length is 4096 bytes. See [How to solve SEI-related issues](https://docs.agora.io/en/faq/sei).

- backgroundColor

  The video background color of the output media stream. The format is a hexadecimal integer defined by RGB without the # symbol. For example, `0xFFB6C1` means light pink. The default value is `0x000000 `(black).

- userCount

  The number of hosts in the transcoding. The default value is 0.

- metadata

  Deprecated:This attribute is deprecated.The metadata sent to the CDN client.

- watermark

  The video watermark of the output media stream. Ensure that the format of the watermark image is PNG. For details, see [RtcImage](rtc_api_data_type.html#class_rtcimage).

- backgroundImage

  The video background image of the output media stream. For details, see [RtcImage](rtc_api_data_type.html#class_rtcimage).

- audioSampleRate

  The audio sampling rate (Hz) of the output media stream. See [AUDIO_SAMPLE_RATE_TYPE](rtc_api_data_type.html#enum_audiosampleratetype).

- audioBitrate

  The audio bitrate (Kbps) of the output media stream. The default value is 48, and the maximum is 128.

- audioChannels

  The number of audio channels of the output media stream. The default value is 1. Agora recommends setting it to 1 or 2.1: (Default) Mono2: Stereo.3: Three audio channels.4: Four audio channels.5: Five audio channels.

- audioCodecProfile

  The audio codec of the output media stream. For details, see [AUDIO_CODEC_PROFILE_TYPE](rtc_api_data_type.html#enum_audiocodecprofiletype).

- watermarkCount

  The number of watermarks of the output media stream.If you do not add a watermark or add only one watermark, this parameter is optional.If you add more than one watermarks, ensure that you set this parameter.

- backgroundCount

  The number of background images of the output media stream.If you do not add a background image or add only one background image, this parameter is optional.If you add more than one background images, ensure that you set this parameter.

**See also**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)

## [LocalAudioStats](rtc_api_data_type.html#class_localaudiostats)

Local audio statistics.

```cpp
struct LocalAudioStats
{
  int numChannels;
  int sentSampleRate;
  int sentBitrate;
  int internalCodec;
  int txPacketLossRate;
};
```

### Attributes

- numChannels

  The number of audio channels.

- sentSampleRate

  The sampling rate (Hz) of sending the local user's audio stream.

- sentBitrate

  The average bitrate (Kbps) of sending the local user's audio stream.

- txPacketLossRate

  The packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.

- internalCodec

  The internal payload codec.

**See also**

- [onLocalAudioStats](../API/class_irtcengineeventhandler.html#callback_onlocalaudiostats)

## [LocalTranscoderConfiguration](rtc_api_data_type.html#class_localtranscoderconfiguration)

The configuration of the video mixing on the local client.

```cpp
struct LocalTranscoderConfiguration {
  unsigned int streamCount;
  TranscodingVideoStream* VideoInputStreams;
  VideoEncoderConfiguration videoOutputConfiguration;
  LocalTranscoderConfiguration()
      : streamCount(0),
        VideoInputStreams(NULL),
        videoOutputConfiguration() {}
};
```

### Attributes

- streamCount

  The number of the video streams for the video mixing on the local client.

- VideoInputStreams

  The video streams for the video mixing on the local client. See [TranscodingVideoStream](rtc_api_data_type.html#class_transcodingvideostream).

- videoOutputConfiguration

  The encoding configuration of the mixed video stream after the video mixing on the local client. See [VideoEncoderConfiguration](rtc_api_data_type.html#class_videoencoderconfiguration).

## [LocalVideoStats](rtc_api_data_type.html#class_localvideostats)

The statistics of the local video stream.

```cpp
struct LocalVideoStats
{
    uid_t uid;
    int sentBitrate;
    int sentFrameRate;
    int encoderOutputFrameRate;
    int rendererOutputFrameRate;
    int targetBitrate;
    int targetFrameRate;
    QUALITY_ADAPT_INDICATION qualityAdaptIndication;
    int encodedBitrate;
    int encodedFrameWidth;
    int encodedFrameHeight;
    int encodedFrameCount;
    VIDEO_CODEC_TYPE codecType;
    int txPacketLossRate;
};
```

### Attributes

- uid

  The ID of the local user.

- sentBitrate

  The actual bitrate (Kbps) for sending the local video stream.**Note** This value does not include the bitrate for resending the video after packet loss.

- sentFrameRate

  The actual frame rate (Kbps) while sending the local video stream.**Note** This value does not include the frame rate for resending the video after packet loss.

- encoderOutputFrameRate

  The output frame rate (fps) of the local video encoder.

- rendererOutputFrameRate

  The output frame rate (fps) of the local video renderer.

- targetBitrate

  The target bitrate (Kbps) of the current encoder. This is an estimate made by the SDK based on the current network conditions.

- targetFrameRate

  The target frame rate (fps) of the current encoder.

- qualityAdaptIndication

  Quality change of the local video in terms of target frame rate and target bit rate in this reported interval. For details, see [QUALITY_ADAPT_INDICATION](rtc_api_data_type.html#enum_qualityadaptindication).

- encodedBitrate

  The bitrate (Kbps) for encoding the local video stream.**Note** This value does not include the bitrate for resending the video after packet loss.

- encodedFrameWidth

  The width of the encoded video (px).

- encodedFrameHeight

  The height of the encoded video (px).

- encodedFrameCount

  The number of the sent video frames, represented by an aggregate value.

- codecType

  The codec type of the local video. For details, see [VIDEO_CODEC_TYPE](rtc_api_data_type.html#enum_videocodectype).

- txPacketLossRate

  The video packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.

**See also**

- [onLocalVideoStats](../API/class_irtcengineeventhandler.html#callback_onlocalvideostats)

## [LogConfig](rtc_api_data_type.html#class_logconfig_ng)

The configuration of the SDK log files.

```cpp
struct LogConfig
{
  const char* filePath;
  uint32_t fileSizeInKB;
  LOG_LEVEL level;
  LogConfig() : filePath(NULL), fileSizeInKB(DEFAULT_LOG_SIZE_IN_KB), level(OPTIONAL_LOG_LEVEL_SPECIFIER LOG_LEVEL_INFO) {}
};
```

### Attributes

- filePath

  The complete path of the log files. Ensure that the path for the log file exists and is writable. You can use this parameter to rename the log files.The default file path is:Android: /storage/emulated/0/Android/data/<packagename>/files/agorasdk.log/.iOS: AppSandbox/Library/caches/agorasdk.log.macOS:If Sandbox is enabled: App~/Library/Logs/agorasdk.log. For example, /Users/<username>/Library/Containers/<AppBundleIdentifier>/Data/Library/Logs/agorasdk.log.If Sandbox is disabled: ~/Library/Logs/agorasdk.logWindows: C: \Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log.

- fileSizeInKB

  The size (KB) of an `agorasdk.log` file. The value range is [128,1024]. The default value is 1,024 KB. If you set `fileSizeInKByte` to a value lower than 128 KB, the SDK adjusts it to 128 KB. If you set `fileSizeInKBytes` to a value higher than 1,024 KB, the SDK adjusts it to 1,024 KB.

  **Note**This method only applies to the `agorasdk.log` file, but not the `agoraapi.log` file.

- level

  The output level of the SDK log file. See [LOG_LEVEL](rtc_api_data_type.html#enum_loglevel).For example, if you set the log level to WARN, the SDK outputs the logs within levels FATAL, ERROR, and WARN.

**See also**

- [initialize](../API/class_irtcengine.html#api_create2)

## [PlayerStreamInfo](rtc_api_data_type.html#class_playerstreaminfo)

The detailed information of the media stream.

```cpp
struct PlayerStreamInfo {
  int streamIndex;
  MEDIA_STREAM_TYPE streamType;
  char codecName[kMaxCharBufferLength];
  char language[kMaxCharBufferLength];
  int videoFrameRate;
  int videoBitRate;
  int videoWidth;
  int videoHeight;
  int videoRotation;
  int audioSampleRate;
  int audioChannels;
  int audioBitsPerSample;
  int64_t duration;
  PlayerStreamInfo() : streamIndex(0),
                       streamType(STREAM_TYPE_UNKNOWN),
                       videoFrameRate(0),
                       videoBitRate(0),
                       videoWidth(0),
                       videoHeight(0),
                       videoRotation(0),
                       audioSampleRate(0),
                       audioChannels(0),
                       audioBitsPerSample(0),
                       duration(0) {
    memset(codecName, 0, sizeof(codecName));
    memset(language, 0, sizeof(language));
```

### Attributes

- streamIndex

  The index of the media stream.

- streamType

  The type of the media stream. See [MEDIA_STREAM_TYPE](rtc_api_data_type.html#enum_mediastreamtype).

- codecName

  The codec of the media stream.

- language

  The language of the media stream.

- videoFrameRate

  This parameter only takes effect for video streams, and indicates the video frame rate (fps).

- videoBitrate

  This parameter only takes effect for video streams, and indicates the video bitrate (bps).

- videoWidth

  This parameter only takes effect for video streams, and indicates the video width (pixel).

- videoHeight

  This parameter only takes effect for video streams, and indicates the video height (pixel).

- audioSampleRate

  This parameter only takes effect for audio streams, and indicates the audio sample rate (Hz).

- audioChannels

  This parameter only takes effect for audio streams, and indicates the audio channel number.

- audioBitsPerSample

  This parameter only takes effect for audio streams, and indicates the bit number of each audio sample.

- duration

  The total duration (s) of the media stream.

**See also**

- [getStreamInfo](../API/class_imediaplayer.html#api_imediaplayer_getstreaminfo)

## [PlayerUpdatedInfo](rtc_api_data_type.html#class_playerupdatedinfo)

Information related to the media player.

```cpp
struct PlayerUpdatedInfo {
  Optional<const char*> playerId;
  Optional<const char*> deviceId;
};
```

### Attributes

- playerId

  The ID of a media player.

- deviceId

  The ID of a deivce.

## [Rectangle](rtc_api_data_type.html#class_rectangle)

The location of the target area relative to the screen or window. If you do not set this parameter, the SDK selects the whole screen or window.

```cpp
struct Rectangle {
    int x;
    int y;
    int width;
    int height;

    Rectangle(): x(0), y(0), width(0), height(0) {}
    Rectangle(int xx, int yy, int ww, int hh): x(xx), y(yy), width(ww), height(hh) {}
};
```

### Attributes

- x

  The horizontal offset from the top-left corner.

- y

  The vertical offset from the top-left corner.

- width

  The width of the target area.

- height

  The height of the target area.

**See also**

- [startScreenCaptureByScreenRect](../API/class_irtcengine.html#api_startscreencapturebyscreenrect)
- [startScreenCaptureByWindowId](../API/class_irtcengine.html#api_startscreencapturebywindowid)
- [updateScreenCaptureRegion](../API/class_irtcengine.html#api_updatescreencaptureregion)
- [addVideoWatermark [2/2\]](../API/class_irtcengine.html#api_addvideowatermark2)

## [RemoteAudioStats](rtc_api_data_type.html#class_remoteaudiostats)

Audio statistics of the remote user.

```cpp
struct RemoteAudioStats
{
  uid_t uid;
  int quality;
  int networkTransportDelay;
  int jitterBufferDelay;
  int audioLossRate;
  int numChannels;
  int receivedSampleRate;
  int receivedBitrate;
  int totalFrozenTime;
  int frozenRate;
  int mosValue;
  int totalActiveTime;
  int publishDuration;
  RemoteAudioStats() :
    uid(0),
    quality(0),
    networkTransportDelay(0),
    jitterBufferDelay(0),
    audioLossRate(0),
    numChannels(0),
    receivedSampleRate(0),
    receivedBitrate(0),
    totalFrozenTime(0),
    frozenRate(0),
    mosValue(0),
    totalActiveTime(0),
    publishDuration(0){}
};
```

### Attributes

- uid

  The user ID of the remote user.

- quality

  The quality of the audio stream sent by the user. See [QUALITY_TYPE](rtc_api_data_type.html#enum_qualitytype).

- networkTransportDelay

  The network delay (ms) from the sender to the receiver.

- jitterBufferDelay

  The network delay (ms) from the receiver to the jitter buffer.**Note** This parameter does not take effect if the receiver is an audience member and **audienceLatencyLevel** of [ClientRoleOptions](rtc_api_data_type.html#class_clientroleoptions) is 1.

- audioLossRate

  The frame loss rate (%) of the remote audio stream in the reported interval.

- numChannels

  The number of audio channels.

- receivedSampleRate

  The sampling rate of the received audio stream in the reported interval.

- receivedBitrate

  The average bitrate (Kbps) of the received audio stream in the reported interval.

- totalFrozenTime

  The total freeze time (ms) of the remote audio stream after the remote user joins the channel. In a session, audio freeze occurs when the audio frame loss rate reaches 4%.

- frozenRate

  The total audio freeze time as a percentage (%) of the total time when the audio is available. The audio is considered available when the remote user neither stops sending the audio stream nor disables the audio module after joining the channel.

- totalActiveTime

  The total active time (ms) between the start of the audio call and the callback of the remote user.The active time refers to the total duration of the remote user without the mute state.

- publishDuration

  The total duration (ms) of the remote audio stream.

- mosValue

  The quality of the remote audio stream in the reported interval. The quality is determined by the Agora real-time audio MOS (Mean Opinion Score) measurement method. The return value range is [0, 500]. Dividing the return value by 100 gets the MOS score, which ranges from 0 to 5. The higher the score, the better the audio quality.The subjective perception of audio quality corresponding to the Agora real-time audio MOS scores is as follows:MOS scorePerception of audio qualityGreater than 4Excellent. The audio sounds clear and smooth.From 3.5 to 4Good. The audio has some perceptible impairment but still sounds clear.From 3 to 3.5Fair. The audio freezes occasionally and requires attentive listening.From 2.5 to 3Poor. The audio sounds choppy and requires considerable effort to understand.From 2 to 2.5Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting in some information loss. The users can communicate only with difficulty.Less than 2Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting in severe information loss. Communication is nearly impossible.

**See also**

- [onRemoteAudioStats](../API/class_irtcengineeventhandler.html#callback_onremoteaudiostats)

## [RemoteVideoStats](rtc_api_data_type.html#class_remotevideostats)

Statistics of the remote video stream.

```cpp
struct RemoteVideoStats {
  uid_t uid;
  int delay;
  int width;
  int height;
  int receivedBitrate;
  int decoderOutputFrameRate;
  int rendererOutputFrameRate;
  int frameLossRate;
  int packetLossRate;
  VIDEO_STREAM_TYPE rxStreamType;
  int totalFrozenTime;
  int frozenRate;
  int avSyncTimeMs;
  int totalActiveTime;
  int publishDuration;
};
```

### Attributes

- uid

  The user ID of the remote user sending the video stream.

- delay

  Deprecated:In scenarios where audio and video are synchronized, you can get the video delay data from **networkTransportDelay** and **jitterBufferDelay** in [RemoteAudioStats](rtc_api_data_type.html#class_remoteaudiostats).The video delay (ms).

- width

  The width (pixels) of the video.

- height

  The height (pixels) of the video.

- receivedBitrate

  The bitrate (Kbps) of receiving the remote video since the last count.

- decoderOutputFrameRate

  The frame rate (fps) of decoding the remote video.

- rendererOutputFrameRate

  The frame rate (fps) of rendering the remote video.

- frameLossRate

  Packet loss rate (%) of the remote video.

- packetLossRate

  The packet loss rate (%) of the remote video after using the anti-packet-loss technology.

- rxStreamType

  The type of the video stream. For details, see [REMOTE_VIDEO_STREAM_TYPE](rtc_api_data_type.html#enum_remotevideostreamtype).

- totalFrozenTime

  The total freeze time (ms) of the remote video stream after the remote user joins the channel. In a video session where the frame rate is set to 5 fps or higher, video freeze occurs when the time interval between two adjacent video frames is more than 500 ms.

- frozenRate

  The total video freeze time as a percentage (%) of the total time when the video is available. The video is available means that the remote user neither stops sending the video stream nor disables the video module after joining the channel.

- totalActiveTime

  Total active time (ms) of the video.When the remote user/host neither stops sending the video stream nor disables the video module after joining the channel, the video is available.

- publishDuration

  The total duration (ms) of the remote video stream.

- avSyncTimeMs

  The amount of time (ms) that the audio is ahead of the video.**Note** If it is negative, it means that the audio is lagging behind the video.

**See also**

- [onRemoteVideoStats](../API/class_irtcengineeventhandler.html#callback_onremotevideostats)

## [RtcEngineContext](rtc_api_data_type.html#class_rtcengineconfig_ng)

Configurations for the RtcEngineContext instance.

```cpp
struct RtcEngineContext {
  IRtcEngineEventHandler* eventHandler;
  const char* appId;
  void* context;
  bool enableAudioDevice;
  CHANNEL_PROFILE_TYPE channelProfile;
  AUDIO_SCENARIO_TYPE audioScenario;
  unsigned int areaCode;
  commons::LogConfig logConfig;

  RtcEngineContext()
      : eventHandler(NULL), appId(NULL), context(NULL),
        enableAudioDevice(true), channelProfile(CHANNEL_PROFILE_LIVE_BROADCASTING),
        audioScenario(AUDIO_SCENARIO_HIGH_DEFINITION),
        areaCode(AREA_CODE_GLOB),
        logConfig() {}
};
```

### Attributes

- eventHandler

  The event handler for [IRtcEngine](class_irtcengine.html#class_irtcengine). See [IRtcEngineEventHandler](class_irtcengineeventhandler.html#class_irtcengineeventhandler).

- appId

  The App ID issued by Agora for your project. Only users in apps with the same App ID can join the same channel and communicate with each other. An App ID can only be used to create one IRtcEngine instance. To change your App ID, call [release](class_irtcengine.html#api_release) to destroy the current IRtcEngine instanceand then create a new one.

- context

  For Windows, it is the window handle of the app. Once set, this parameter enables you to plug or unplug the video devices while they are powered.For Android, it is the context of Android Activity.

- enableAudioDevice

  Sets whether to allow the SDK to use audio devices:`true`: (Default) Allow the SDK to use audio devices.`false`: Do not allow the SDK to use audio devices.

  **Note**If you need to get the mixed remote audio data through [pullAudioFrame](class_imediaengine.html#api_imediaengine_pullaudioframe), ensure that you set this parameter as `false`.

- channelProfile

  The channel profile. For details, see [CHANNEL_PROFILE_TYPE](rtc_api_data_type.html#enum_channelprofiletype_ng).

- audioScenario

  The audio scenario. See [AUDIO_SCENARIO_TYPE](rtc_api_data_type.html#enum_audioscenariotype_ng). Under different audio scenarios, the device uses different volume types.

- areaCode

  The region for connection. This is an advanced feature and applies to scenarios that have regional restrictions. For details on supported regions, see [AREA_CODE](rtc_api_data_type.html#enum_areacode).After specifying the region, the app integrated with the Agora SDK connects to the Agora servers within that region.

- logConfig

  The log files that the SDK outputs. See [LogConfig](rtc_api_data_type.html#class_logconfig_ng).By default, the SDK outputs four log files: `agorasdk.log`, `agorasdk1.log`, `agoraapi.log`, and `agoraapi1.log`. The `agorasdk.log` and `agorasdk1.log` files each have a default size of 1024 KB, and the `agoraapi.log` and `agoraapi1.log` files each have a default size of 2,048 KB. These log files are encoded in UTF-8.The SDK writes the latest logs in `agorasdk.log` or `agoraapi.log`. When `agorasdk.log` or `agoraapi.log` is full, the SDK deletes `agorasdk1.log` or `agoraapi1.log`, renames `agorasdk.log` to `agorasdk1.log` and `agoraapi.log` to `agorasapi1.log`, and creates a new `agorasdk.log` or `agoraapi.log` to record the latest logs.

**See also**

- [initialize](../API/class_irtcengine.html#api_create2)
- [setAudioProfile [2/2\]](../API/class_irtcengine.html#api_setaudioprofile2)

## [RtcConnection](rtc_api_data_type.html#class_rtcconnection)

Contains connection information.

```cpp
struct RtcConnection {
  const char* channelId;
  uid_t localUid;

  RtcConnection() : RtcConnection(NULL, 0) {}
  RtcConnection(const char* channel_id, uid_t local_uid)
      : channelId(channel_id), localUid(local_uid) {}
};
```

### Attributes

- channelId

  The channel name.

- localUid

  The ID of the local user.

## [RtcImage](rtc_api_data_type.html#class_rtcimage)

Image properties.

```cpp
typedef struct RtcImage {
            const char* url;
            int x;
            int y;
            int width;
            int height;
            int zOrder;
            
            RtcImage() : url(NULL), x(0), y(0), width(0), height(0), zOrder(0) {}
            } RtcImage;
```



This class sets the properties of the watermark and background images in the live video.

### Attributes

- url

  The HTTP/HTTPS URL address of the image in the live video. The maximum length of this parameter is 1024 bytes.

- x

  The x coordinate (pixel) of the image on the video frame (taking the upper left corner of the video frame as the origin).

- y

  The y coordinate (pixel) of the image on the video frame (taking the upper left corner of the video frame as the origin).

- width

  The width (pixel) of the image on the video frame.

- height

  The height (pixel) of the image on the video frame.

- zOrder

  The layer index of the video frame. An integer. The value range is [0, 100]. 1 represents the lowest layer. 100 represents the top layer.

**See also**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)
- [addVideoWatermark [1/2\]](../API/class_irtcengine.html#api_addvideowatermark)

## [RtcStats](rtc_api_data_type.html#class_rtcstats)

Statistics of a call session.

```cpp
struct RtcStats {
  unsigned int duration;
  unsigned int txBytes;
  unsigned int rxBytes;
  unsigned int txAudioBytes;
  unsigned int txVideoBytes;
  unsigned int rxAudioBytes;
  unsigned int rxVideoBytes;
  unsigned short txKBitRate;
  unsigned short rxKBitRate;
  unsigned short rxAudioKBitRate;
  unsigned short txAudioKBitRate;
  unsigned short rxVideoKBitRate;
  unsigned short txVideoKBitRate;
  unsigned short lastmileDelay;
  unsigned int userCount;
  double cpuAppUsage;
  double cpuTotalUsage;
  int gatewayRtt;
  double memoryAppUsageRatio;
  double memoryTotalUsageRatio;
  int memoryAppUsageInKbytes;
  int connectTimeMs;
  int txPacketLossRate;
  int rxPacketLossRate;
  RtcStats() :
      duration(0),
      txBytes(0),
      rxBytes(0),
      txAudioBytes(0),
      txVideoBytes(0),
      rxAudioBytes(0),
      rxVideoBytes(0),
      txKBitRate(0),
      rxKBitRate(0),
      rxAudioKBitRate(0),
      txAudioKBitRate(0),
      rxVideoKBitRate(0),
      txVideoKBitRate(0),
      lastmileDelay(0),
      userCount(0),
      cpuAppUsage(0.0),
      cpuTotalUsage(0.0),
      gatewayRtt(0),
      memoryAppUsageRatio(0.0),
      memoryTotalUsageRatio(0.0),
      memoryAppUsageInKbytes(0),
      connectTimeMs(0),
      txPacketLossRate(0),
      rxPacketLossRate(0) {}
};
```

### Attributes

- duration

  Call duration of the local user in seconds, represented by an aggregate value.

- txBytes

  The number of bytes sent.

- rxBytes

  The number of bytes received.

- txAudioBytes

  The total number of audio bytes sent, represented by an aggregate value.

- txVideoBytes

  The total number of video bytes sent, represented by an aggregate value.

- rxAudioBytes

  The total number of audio bytes received, represented by an aggregate value.

- rxVideoBytes

  The total number of video bytes received, represented by an aggregate value.

- txKBitRate

  Video transmission bitrate (Kbps), represented by an instantaneous value.

- rxKBitRate

  The receiving bitrate (Kbps), represented by an instantaneous value.

- rxAudioKBitRate

  Audio receive bitrate (Kbps), represented by an instantaneous value.

- txAudioKBitRate

  The bitrate (Kbps) of sending the audio packet.

- rxVideoKBitRate

  Video receive bitrate (Kbps), represented by an instantaneous value.

- txVideoKBitRate

  The bitrate (Kbps) of sending the video.

- lastmileDelay

  The client-to-server delay (milliseconds).

- txPacketLossRate

  The packet loss rate (%) from the client to the Agora server before applying the anti-packet-loss algorithm.

- rxPacketLossRate

  The packet loss rate (%) from the Agora server to the client before using the anti-packet-loss method.

- userCount

  The number of users in the channel.

- cpuAppUsage

  The CPU usage (%) of the app.

- cpuTotalUsage

  The system CPU usage (%).For Windows, in the multi-kernel environment, this member represents the average CPU usage. The value = 100 - System Idle Progress in Task Manager.**Note** The value of cpuTotalUsage is always reported as 0 in the [onLeaveChannel](class_irtcengineeventhandler.html#callback_onleavechannel) callback.

- connectTimeMs

  The duration (ms) between the SDK starts connecting and the connection is established. If the value reported is 0, it means invalid.

- gatewayRtt

  The round-trip time delay (ms) from the client to the local router.

- memoryAppUsageRatio

  The memory ratio occupied by the app (%).**Note** This value is for reference only. Due to system limitations, you may not get this value.

- memoryTotalUsageRatio

  The memory occupied by the system (%).**Note** This value is for reference only. Due to system limitations, you may not get this value.

- memoryAppUsageInKbytes

  The memory size occupied by the app (KB).**Note** This value is for reference only. Due to system limitations, you may not get this value.

**See also**

- [onLeaveChannel](../API/class_irtcengineeventhandler.html#callback_onleavechannel)
- [onRtcStats](../API/class_irtcengineeventhandler.html#callback_onrtcstats)

## [ScreenCaptureConfiguration](rtc_api_data_type.html#class_screencaptureconfiguration)

The configuration of the captured screen.

```cpp
struct ScreenCaptureConfiguration {
  bool isCaptureWindow;
  uint32_t displayId;
  Rectangle screenRect;
  view_t windowId;
  ScreenCaptureParameters params;
  Rectangle regionRect;

  ScreenCaptureConfiguration() : isCaptureWindow(false), displayId(0) {}
};
```

### Attributes

- isCaptureWindow

  Whether to capture the window on the screen:`true`: Capture the window.`false`: (Default) Capture the screen, not the window.

- displayId

  (macOS only) The display ID of the screen.**Note** This parameter takes effect only when you want to capture the screen on macOS.

- screenRect

  (Windows only) The relative position of the shared screen to the virtual screen.**Note** This parameter takes effect only when you want to capture the screen on Windows.

- windowId

  (For Windows and macOS only)**Note** This parameter takes effect only when you want to capture the window.

- params

  (For Windows and macOS only) The screen capture configuration. For details, see [ScreenCaptureParameters](rtc_api_data_type.html#class_screencaptureparameters).

- regionRect

  (For Windows and macOS only) The relative position of the shared region to the whole screen. For details, see [Rectangle](rtc_api_data_type.html#class_rectangle).If you do not set this parameter, the SDK shares the whole screen. If the region you set exceeds the boundary of the screen, only the region within in the screen is shared. If you set width or height in Rectangle as 0, the whole screen is shared.

**See also**

- [startPrimaryScreenCapture](../API/class_irtcengine.html#api_startprimaryscreencapture)
- [startSecondaryScreenCapture](../API/class_irtcengine.html#api_startsecondaryscreencapture)

## [ScreenCaptureParameters](rtc_api_data_type.html#class_screencaptureparameters)

Screen sharing configurations.

```cpp
struct ScreenCaptureParameters {
  VideoDimensions dimensions;
  int frameRate;
  int bitrate;
  bool captureMouseCursor;
  bool windowFocus;
  view_t *excludeWindowList;
  int excludeWindowCount;

  ScreenCaptureParameters()
    : dimensions(1920, 1080), frameRate(5), bitrate(STANDARD_BITRATE), captureMouseCursor(true), windowFocus(false), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0) {}
  ScreenCaptureParameters(const VideoDimensions& d, int f, int b)
    : dimensions(d), frameRate(f), bitrate(b), captureMouseCursor(true), windowFocus(false), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0) {}
  ScreenCaptureParameters(int width, int height, int f, int b)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(true), windowFocus(false), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0) {}
  ScreenCaptureParameters(int width, int height, int f, int b, bool cur, bool fcs)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(cur), windowFocus(fcs), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0) {}
  ScreenCaptureParameters(int width, int height, int f, int b, view_t *ex, int cnt)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(true), windowFocus(false), excludeWindowList(ex), excludeWindowCount(cnt) {}
  ScreenCaptureParameters(int width, int height, int f, int b, bool cur, bool fcs, view_t *ex, int cnt)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(cur), windowFocus(fcs), excludeWindowList(ex), excludeWindowCount(cnt) {}
};
```

### Attributes

- dimensions

  The maximum dimensions of encoding the shared region. For details, see [VideoDimensions](rtc_api_data_type.html#class_videodimensions). The default value is 1,920 × 1,080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges.If the screen dimensions are different from the value of this parameter, Agora applies the following strategies for encoding. Suppose `dimensions` are set to 1,920 x 1,080:If the value of the screen dimensions is lower than that of `dimensions`, for example, 1,000 x 1,000 pixels, the SDK uses 1,000 x 1,000 pixels for encoding.If the value of the screen dimensions is larger than that of `dimensions`, for example, 2,000 × 1,500, the SDK uses the maximum value next to 1,920 × 1,080 with the aspect ratio of the screen dimension (4:3) for encoding, that is, 1,440 × 1,080.

- frameRate

  The frame rate (fps) of the shared region. The default value is 5. Agora does not recommend setting it to a value greater than 15.

- bitrate

  The bitrate (Kbps) of the shared region. The default value is 0, which represents that the SDK works out a bitrate according to the dimensions of the current screen.

- captureMouseCursor

  Whether to capture the mouse in screen sharing:`true`: (Default) Capture the mouse.`false`: Do not capture the mouse.

- windowFocus

  Whether to bring the window to the front when calling the [startScreenCaptureByWindowId](class_irtcengine.html#api_startscreencapturebywindowid) method to share it:`true`:Bring the window to the front.`false`: (Default) Do not bring the window to the front.

- excludeWindowList

  The ID list of the windows to be blocked. When calling [startScreenCaptureByScreenRect](class_irtcengine.html#api_startscreencapturebyscreenrect) to start screen sharing, you can use this parameter to block a specified window. When calling to[updateScreenCaptureParameters](class_irtcengine.html#api_updatescreencaptureparameters) update screen sharing configurations, you can use this parameter to dynamically block a specified window.

- excludeWindowCount

  The number of windows to be blocked.

**See also**

- [startScreenCaptureByScreenRect](../API/class_irtcengine.html#api_startscreencapturebyscreenrect)
- [startScreenCaptureByWindowId](../API/class_irtcengine.html#api_startscreencapturebywindowid)
- [updateScreenCaptureParameters](../API/class_irtcengine.html#api_updatescreencaptureparameters)
- [startScreenCapture](../API/class_irtcengine.html#api_startscreencapture_ng)

## [SimulcastStreamConfig](rtc_api_data_type.html#class_simulcaststreamconfig)

The configuration of the low-quality video stream.

```cpp
struct SimulcastStreamConfig {
  VideoDimensions dimensions;
  int bitrate;
  int framerate;
  SimulcastStreamConfig() : dimensions(160, 120), bitrate(65), framerate(5) {}
  bool operator==(const SimulcastStreamConfig& rhs) const {
    return dimensions == rhs.dimensions && bitrate == rhs.bitrate && framerate == rhs.framerate;
  }
};
```

### Attributes

- dimensions

  The video dimensions, see [VideoDimensions](rtc_api_data_type.html#class_videodimensions). The default value is 160 × 120.

- bitrate

  Video receive bitrate (Kbps), represented by an instantaneous value. The default value of the log level is 5.

- frameRate

  The capture frame rate (fps) of the local video. The default value is 5.

**See also**

- [enableDualStreamMode [2/3\]](../API/class_irtcengine.html#api_enabledualstreammode2)
- [enableDualStreamMode [3/3\]](../API/class_irtcengine.html#api_enabledualstreammode3)

## [SrcInfo](rtc_api_data_type.html#class_srcinfo)

Information about the video bitrate of the media resource being played.

```cpp
struct SrcInfo {
  int bitrateInKbps;
  const char* name;
};
```

### Attributes

- bitrateInKbps

  The video bitrate (Kbps) of the media resource being played.

- name

  The name of the media resource.

## [TranscodingUser](rtc_api_data_type.html#class_transcodinguser)

Transcoding configurations of each host.

```cpp
truct TranscodingUser {
  uid_t uid;
  int x;
  int y;
  int width;
  int height;
  int zOrder;
  double alpha;
  int audioChannel;
  TranscodingUser()
      : uid(0),
        x(0),
        y(0),
        width(0),
        height(0),
        zOrder(0),
        alpha(1.0),
        audioChannel(0) {}
};
```

### Attributes

- uid

  The user ID of the host.

- x

  The x coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, width], where width is the [LiveTranscoding](rtc_api_data_type.html#class_livetranscoding)`width` set in .

- y

  The y coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, height], where height is the [LiveTranscoding](rtc_api_data_type.html#class_livetranscoding)`height` set in .

- width

  The width (pixel) of the host's video.

- height

  The height (pixel) of the host's video.

- zOrder

  The layer index number of the host's video. The value range is [0, 100].0: (Default) The host's video is the bottom layer.100: The host's video is the top layer.**Note**If the value is beyond this range, the SDK reports the error code `ERR_INVALID_ARGUMENT`.As of v2.3, the SDK supports setting zOrder to 0.

- alpha

  The transparency of the host's video. The value range is [0.0, 1.0].0.0: Completely transparent.1.0: (Default) Opaque.

- audioChannel

  The audio channel used by the host's audio in the output audio. The default value is 0, and the value range is [0, 5].`0`: (Recommended) The defaut setting, which supports dual channels at most and depends on the upstream of the host.`1`: The host's audio uses the FL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.`2`: The host's audio uses the FC audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.`3`: The host's audio uses the FR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.`4`: The host's audio uses the BL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.`5`: The host's audio uses the BR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.`0xFF` or a value greater than `5`: The host's audio is muted, and the Agora server removes the host's audio.**Note** If the value is not `0`, a special player is required.

**See also**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)

## [TranscodingVideoStream](rtc_api_data_type.html#class_transcodingvideostream)

The video streams for the video mixing on the local client.

```cpp
struct TranscodingVideoStream {
  agora::media::MEDIA_SOURCE_TYPE sourceType;
  uid_t remoteUserUid;
  const char* imageUrl;
  int x;
  int y;
  int width;
  int height;
  int zOrder;
  double alpha;
  bool mirror;

  TranscodingVideoStream()
      : sourceType(agora::media::PRIMARY_CAMERA_SOURCE),
        remoteUserUid(0),
        imageUrl(NULL),
        x(0),
        y(0),
        width(0),
        height(0),
        zOrder(0),
        alpha(1.0),
        mirror(false) {}
};
```

### Attributes

- sourceType

  The source type of video for the video mixing on the local client. See [VIDEO_SOURCE_TYPE](rtc_api_data_type.html#enum_videosourcetype).

- remoteUserUid

  The ID of the remote user.**Note** Use this parameter only when the source type of the video for the video mixing on the local client is VIDEO_SOURCE_REMOTE.

- imageUrl

  The URL of the image.**Note** Use this parameter only when the source type of the video for the video mixing on the local client is `RTC_IMAGE`.

- x

  The horizontal displacement of the top-left corner of the video for the video mixing on the client relative to the top-left corner (origin) of the canvas for this video mixing.

- y

  The vertical displacement of the top-left corner of the video for the video mixing on the client relative to the top-left corner (origin) of the canvas for this video mixing.

- width

  The width (px) of the video for the video mixing on the local client.

- heigh

  The height (px) of the video for the video mixing on the local client.

- zOrder

  The number of the layer to which the video for the video mixing on the local client belongs. The value range is [0,100].0: (Default) The layer is at the bottom.100: The layer is at the top.

- alpha

  The transparency of the video for the video mixing on the local client. The value range is [0.0,1.0]. 0.0 means the transparency is completely transparent. 1.0 means the transparency is opaque.

- mirror

  Whether to mirror the video for the video mixing on the local client.`true`: Mirroring.`false`: (Default) Do not mirror.**Note** The paramter only works for videos with the source type `CAMERA`.

## [UplinkNetworkInfo](rtc_api_data_type.html#class_uplinknetworkinfo)

The uplink network information.

```cpp
struct UplinkNetworkInfo {
  int video_encoder_target_bitrate_bps;

  UplinkNetworkInfo() : video_encoder_target_bitrate_bps(0) {}

  bool operator==(const UplinkNetworkInfo& rhs) const {
    return (video_encoder_target_bitrate_bps == rhs.video_encoder_target_bitrate_bps);
  }
};
```

### Attributes

- video_encoder_target_bitrate_bps

  The target video encoder bitrate (bps).

**See also**

- [onUplinkNetworkInfoUpdated](../API/class_irtcengineeventhandler.html#callback_onuplinknetworkinfoupdated)

## [UserAudioSpectrumInfo](rtc_api_data_type.html#class_useraudiospectruminfo)

Audio spectrum information of the remote user.

```cpp
struct UserAudioSpectrumInfo  {
  agora::rtc::uid_t uid;
  struct AudioSpectrumData spectrumData;

  UserAudioSpectrumInfo () : uid(0), spectrumData() {}
  UserAudioSpectrumInfo(agora::rtc::uid_t _uid, const float *data, int length) :
    uid(_uid) { spectrumData.audioSpectrumData = data; spectrumData.dataLength = length; }
};
```

### Attributes

- uid

  The ID of the remote user.

- spectrumData

  Audio spectrum information of the remote user. For details, see [AudioSpectrumData](rtc_api_data_type.html#class_audiospectrumdata).

**See also**

- [onRemoteAudioSpectrum](../API/class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onremoteaudiospectrum)

## [UserInfo](rtc_api_data_type.html#class_userinfo)

The information of the user.



```cpp
struct UserInfo {
                    uid_t uid;
                    char userAccount[MAX_USER_ACCOUNT_LENGTH];
                    UserInfo()
                    : uid(0) {
                    userAccount[0] = '\0';
                    }
                    };
```



### Attributes

- uid

  User ID

- userAccount

  The user account. The maximum data length is [MAX_USER_ACCOUNT_LENGTH_TYPE](rtc_api_data_type.html#enum_maxuseraccountlengthtype).

## [VideoCanvas](rtc_api_data_type.html#class_videocanvas_ng)

Attributes of video canvas object.





### Attributes

- view

  Video display window.

- renderMode

  The rendering mode of the video. See [RENDER_MODE_TYPE](rtc_api_data_type.html#enum_rendermodetype).

- mirrorMode

  The mirror mode of the view. See [VIDEO_MIRROR_MODE_TYPE](rtc_api_data_type.html#enum_videomirrormodetype).**Note**For the mirror mode of the local video view: If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.For the remote user: The mirror mode is disabled by default.

- uid

  User ID.

- sourceType

  The type of the video frame, see [VIDEO_SOURCE_TYPE](rtc_api_data_type.html#enum_videosourcetype).

**See also**

- [setupLocalVideo](../API/class_irtcengine.html#api_setuplocalvideo)
- [setupRemoteVideo](../API/class_irtcengine.html#api_setupremotevideo)

## [VideoDimensions](rtc_api_data_type.html#class_videodimensions)

Video dimensions.

```cpp
struct VideoDimensions {
  int width;
  int height;
  VideoDimensions() : width(640), height(480) {}
  VideoDimensions(int w, int h) : width(w), height(h) {}
  bool operator==(const VideoDimensions& rhs) const {
    return width == rhs.width && height == rhs.height;
  }
};
```

### Attributes

- width

  The width (pixels) of the video.

- height

  The height (pixels) of the video.

**See also**

- [setVideoEncoderConfiguration](../API/class_irtcengine.html#api_setvideoencoderconfiguration)
- [startScreenCaptureByScreenRect](../API/class_irtcengine.html#api_startscreencapturebyscreenrect)
- [startScreenCaptureByWindowId](../API/class_irtcengine.html#api_startscreencapturebywindowid)
- [updateScreenCaptureParameters](../API/class_irtcengine.html#api_updatescreencaptureparameters)

## [VideoEncoderConfiguration](rtc_api_data_type.html#class_videoencoderconfiguration)

Video encoder configurations.

```cpp
struct VideoEncoderConfiguration {
  VIDEO_CODEC_TYPE codecType;
  VideoDimensions dimensions;
  int frameRate;
  int bitrate;
  int minBitrate;
  ORIENTATION_MODE orientationMode;
  DEGRADATION_PREFERENCE degradationPreference;
  VIDEO_MIRROR_MODE_TYPE mirrorMode;

  VideoEncoderConfiguration(const VideoDimensions& d, int f, int b, ORIENTATION_MODE m, VIDEO_MIRROR_MODE_TYPE mirror = VIDEO_MIRROR_MODE_DISABLED)
      : codecType(VIDEO_CODEC_H264),
        dimensions(d),
        frameRate(f),
        bitrate(b),
        minBitrate(DEFAULT_MIN_BITRATE),
        orientationMode(m),
        degradationPreference(MAINTAIN_QUALITY),
        mirrorMode(mirror) {}
  VideoEncoderConfiguration(int width, int height, int f, int b, ORIENTATION_MODE m, VIDEO_MIRROR_MODE_TYPE mirror = VIDEO_MIRROR_MODE_DISABLED)
      : codecType(VIDEO_CODEC_H264),
        dimensions(width, height),
        frameRate(f),
        bitrate(b),
        minBitrate(DEFAULT_MIN_BITRATE),
        orientationMode(m),
        degradationPreference(MAINTAIN_QUALITY),
        mirrorMode(mirror) {}
  VideoEncoderConfiguration(const VideoEncoderConfiguration& config)
      : codecType(config.codecType),
        dimensions(config.dimensions),
        frameRate(config.frameRate),
        bitrate(config.bitrate),
        minBitrate(config.minBitrate),
        orientationMode(config.orientationMode),
        degradationPreference(config.degradationPreference),
        mirrorMode(config.mirrorMode) {}
  VideoEncoderConfiguration()
      : codecType(VIDEO_CODEC_H264),
        dimensions(FRAME_WIDTH_640, FRAME_HEIGHT_360),
        frameRate(FRAME_RATE_FPS_15),
        bitrate(STANDARD_BITRATE),
        minBitrate(DEFAULT_MIN_BITRATE),
        orientationMode(ORIENTATION_MODE_ADAPTIVE),
        degradationPreference(MAINTAIN_QUALITY),
        mirrorMode(VIDEO_MIRROR_MODE_DISABLED) {}
};
```

### Attributes

- dimensions

  The dimensions of the encoded video (px). See [VideoDimensions](rtc_api_data_type.html#class_videodimensions). This parameter measures the video encoding quality in the format of length × width. The default value is 640 × 360. You can set a custom value.

- codecType

  The codec type of the local video stream. See [VIDEO_CODEC_TYPE](rtc_api_data_type.html#enum_videocodectype).

- frameRate

  The frame rate (fps) of the encoding video frame. The default value is 15. See [FRAME_RATE](rtc_api_data_type.html#enum_framerate).

- minFramerate

  The minimum encoding frame rate of the video. The default value is -1.

- bitrate

  The encoding bitrate (Kbps) of the video.STANDARD_BITRATE : (Recommended) Standard bitrate mode. In this mode, the video bitrate is twice the base bitrate.COMPATIBLE_BITRATE: Adaptive bitrate mode. In this mode, the video bitrate is the same as the base bitrate. If you choose this mode in the interactive streaming profile, the video frame rate may be lower than the set value.

- minBitrate

  The minimum encoding bitrate (Kbps) of the video.The SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and sacrifice the smoothness of the video transmission. Unless you have special requirements for image quality, Agora does not recommend changing this value.**Note** This parameter only applies to the interactive streaming profile.

- orientationMode

  The orientation mode of the encoded video. See [ORIENTATION_MODE](rtc_api_data_type.html#enum_orientationmode).

- degradationPreference

  Video degradation preference under limited bandwidth. See [DEGRADATION_PREFERENCE](rtc_api_data_type.html#enum_degradationpreference).

- mirrorMode

  Sets the mirror mode of the published local video stream. It only affects the video that the remote user sees. See [VIDEO_MIRROR_MODE_TYPE](rtc_api_data_type.html#enum_videomirrormodetype).**Note** By default, the video is not mirrored.

**See also**

- [setVideoEncoderConfiguration](../API/class_irtcengine.html#api_setvideoencoderconfiguration)

## [VideoFrame](rtc_api_data_type.html#class_videoframe_ng)

Configurations of the video frame

```cpp
struct VideoFrame {
   VIDEO_PIXEL_FORMAT type;
   int width;
   int height;
   int yStride;
   int uStride;
   int vStride;
   void* yBuffer;
   void* uBuffer;
   void* vBuffer;
   int rotation;
   int64_t renderTimeMs;
   int avsync_type;
   };
```

The video data format is YUV420. Note that the buffer provides a pointer to a pointer. This interface cannot modify the pointer of the buffer but can modify the content of the buffer.

### Attributes

- type

  The pixel format. For details, see [VIDEO_PIXEL_FORMAT](rtc_api_data_type.html#enum_videopixelformat).

- width

  Width of the video in the number of pixels.

- height

  Height of the video in the number of pixels.

- yStride

  The line span of the Y buffer within the YUV data.

- uStride

  The line span of the U buffer within the YUV data.

- vStride

  The line span of the V buffer within the YUV data.

- yBuffer

  The pointer to the Y buffer pointer within the YUV data.

- uBuffer

  The pointer to the U buffer pointer within the YUV data.

- vBuffer

  The pointer to the V buffer pointer within the YUV data.

- rotation

  Sets the clockwise rotation of the video frame before rendering. Supported values include 0, 90, 180, and 270 degrees.

- renderTimeMs

  The timestamp (ms) of the external audio frame. It is mandatory. You can use it to restore the order of the captured audio frame, or synchronize audio and video frames in video-related scenarios (including scenarios where external video sources are used).

- avsync_type

  A reserved parameter.

**See also**

- [onCaptureVideoFrame](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_oncapturevideoframe)
- [onRenderVideoFrame](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_onrendervideoframe)
- [getRotationApplied](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_getrotationapplied)
- [onMediaPlayerVideoFrame](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_onmediaplayervideoframe)
- [onScreenCaptureVideoFrame](../API/class_ivideoframeobserver.html#callback_ivideoframeobserver_onscreencapturevideoframe)

## [VideoFormat](rtc_api_data_type.html#class_videoformat_ng)

The format of the video frame.

```cpp
struct VideoFormat {
  int width;
  int height;
  int fps;
}
```

### Attributes

- width

  The width (px) of the video frame.

- height

  The height (px) of the video frame.

- fps

  The video frame rate (fps).

## [VirtualBackgroundSource](rtc_api_data_type.html#class_virtualbackgroundsource)

The custom background image.



```cpp
struct VirtualBackgroundSource {
                    enum BACKGROUND_SOURCE_TYPE {
                    BACKGROUND_COLOR = 1,
                    BACKGROUND_IMG,
                    BACKGROUND_BLUR,
                    };
                    enum BACKGROUND_BLUR_DEGREE {
                    BLUR_DEGREE_LOW = 1,
                    BLUR_DEGREE_MEDIUM,
                    BLUR_DEGREE_HIGH,
                    };
                    BACKGROUND_SOURCE_TYPE background_source_type;
                    unsigned int color;
                    const char* source;
                    BACKGROUND_BLUR_DEGREE blur_degree;
                    VirtualBackgroundSource() : background_source_type(BACKGROUND_COLOR), color(0xffffff), source(NULL),  blur_degree(BLUR_DEGREE_HIGH) {}
                
```



### Attributes

- background_source_type

  The type of the custom background image. See [BACKGROUND_SOURCE_TYPE](rtc_api_data_type.html#enum_backgroundsourcetype).

- color

  The type of the custom background image. The color of the custom background image. The format is a hexadecimal integer defined by RGB, without the # sign, such as 0xFFB6C1 for light pink. The default value is 0xFFFFFF, which signifies white. The value range is [0x000000, 0xffffff]. If the value is invalid, the SDK replaces the original background image with a white background image.**Note** This parameter takes effect only when the type of the custom background image is BACKGROUND_COLOR.

- source

  The local absolute path of the custom background image. PNG and JPG formats are supported. If the path is invalid, the SDK replaces the original background image with a white background image.**Note** This parameter takes effect only when the type of the custom background image is BACKGROUND_IMG.

- blur_degree

  The degree of blurring applied to the custom background image. See [BACKGROUND_BLUR_DEGREE](rtc_api_data_type.html#enum_backgroundblurdegree).**Note** This parameter takes effect only when the type of the custom background image is BACKGROUND_BLUR.

**See also**

- [enableVirtualBackground](../API/class_irtcengine.html#api_enablevirtualbackground)

### [BACKGROUND_SOURCE_TYPE](rtc_api_data_type.html#enum_backgroundsourcetype)

The type of the custom background image.



#### Enumerator

- BACKGROUND_COLOR

  1: (Default) The background image is a solid color.

- BACKGROUND_IMG

  The background image is a file in PNG or JPG format.

- BACKGROUND_BLUR

  The background image is the blurred background.

**See also**

- [enableVirtualBackground](../API/class_irtcengine.html#api_enablevirtualbackground)

### [BACKGROUND_BLUR_DEGREE](rtc_api_data_type.html#enum_backgroundblurdegree)

The degree of blurring applied to the custom background image.



#### Enumerator

- BLUR_DEGREE_LOW

  1: The degree of blurring applied to the custom background image is low. The user can almost see the background clearly.

- BLUR_DEGREE_MEDIUM

  The degree of blurring applied to the custom background image is medium. It is difficult for the user to recognize details in the background.

- BLUR_DEGREE_HIGH

  (Default) The degree of blurring applied to the custom background image is high. The user can barely see any distinguishing features in the background.

**See also**

- [enableVirtualBackground](../API/class_irtcengine.html#api_enablevirtualbackground)

## [WatermarkOptions](rtc_api_data_type.html#class_watermarkoptions)

Configurations of the watermark image.

```cpp
typedef struct WatermarkOptions {
    bool visibleInPreview;
    Rectangle positionInLandscapeMode;
    Rectangle positionInPortraitMode;

    WatermarkOptions()
        : visibleInPreview(true)
        , positionInLandscapeMode(0, 0, 0, 0)
        , positionInPortraitMode(0, 0, 0, 0)
    {}
    } WatermarkOptions;
```

### Attributes

- visibleInPreview

  Whether the watermark image is visible in the local video preview:`true`: (Default) The watermark image is visible in the local preview.`false`: The watermark image is not visible in the local preview.

- positionInLandscapeMode

  The area to display the watermark image in landscape mode. For details, see [Rectangle](rtc_api_data_type.html#class_rectangle).For details about the landscape mode, see [Set the Video Profile](https://docs.agora.io/en/live-streaming-4.x-preview/video_profile_windows?platform=Windows).

- positionInPortraitMode

  The area to display the watermark image in portrait mode. For details, see [Rectangle](rtc_api_data_type.html#class_rectangle).For details about the portrait mode, see [Set the Video Profile](https://docs.agora.io/en/live-streaming-4.x-preview/video_profile_windows?platform=Windows).

**See also**

- [addVideoWatermark [2/2\]](../API/class_irtcengine.html#api_addvideowatermark2)
- [addVideoWatermarkEx](../API/class_irtcengineex.html#api_irtcengineex_addvideowatermarkex)