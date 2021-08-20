# Set the Audio Profile and Scenario

An audio profile includes the audio sample rate, encoding scheme, number of channels, and bitrate for the encoding audio stream; an audio scenario determines the audio processing module.

Different applications require different audio profiles or scenarios. This page introduces how to call Agora APIs to set an appropriate audio profile and scenario according to your application.

## Understand the tech

The SDK uses the `AUDIO_PROFILE_DEFAULT` profile and the `AUDIO_SCENARIO_HIGH_DEFINITION` scenario by default. If the default setting does not meet your requirements, you can call the following APIs to set another audio profile or scenario:

| API                                          | Description                                                  |
| :---------------------------------------------- | :----------------------------------------------------------- |
| `create(config.mAudioScenario)`        | Sets the audio scenario when you create the `RtcEngine` instance. The default value is `AUDIO_SCENARIO_HIGH_DEFINITION`. |
| `setAudioProfile(profile)` | Sets the audio profile either before or after joining a channel. |
| `setAudioProfile(profile, scenario)` | Sets the audio profile and scenario either before or after joining a channel. |

### Audio profile

The higher the bitrate in the audio profile, the higher the audio quality. If the default audio profile (`AUDIO_PROFILE_DEFAULT`) does not meet your requirements, you can set the following audio profiles instead:

| Audio profile (with the prefix `AUDIO_PROFILE_`)                              | Description                                                           |
| :-------------------------------------- | ------------------------------------------------------------ |
| `DEFAULT`                   | 0: Default audio profile:<li>For the interactive streaming profile: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.</li><li>For the communication profile: A sample rate of 32 kHz, music encoding, mono, and a bitrate of up to 18 Kbps.</li> |
| `SPEECH_STANDARD`           | 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps. |
| `MUSIC_STANDARD`            | 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps. |
| `MUSIC_STANDARD_STEREO`     | 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps. |
| `MUSIC_HIGH_QUALITY`        | 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps. |
| `MUSIC_HIGH_QUALITY_STEREO` | 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps. |

### Audio scenario

If the default audio scenario (`AUDIO_SCENARIO_HIGH_DEFINITION`) does not meet your requirements, you can set the following audio scenarios instead:

| Audio scenario (with the prefix `AUDIO_SCENARIO_`)                                          | Description                                                  |
| :---------------------------------------------- | :----------------------------------------------------------- |
| `DEFAULT`         | The scenario uses the audio processing module that is automatically changed according to the user role and the audio route. |
| `HIGH_DEFINITION`/`GAME_STREAMING`         | High audio quality. The scenario uses the audio processing module of the Agora SDK that has a high performance to music or singing voice. Agora recommends this scenario if users mainly play music. |
| `CHATROOM`         | Low audio quality. The scenario uses the audio processing module of the user's device that has a high performance to talk voice. Agora recommends this scenario if users frequently switches the roles or mute and unmute microphones. |

The audio scenario also affects the volume type. For details, see [Volume type](#volume_type).

## Prerequisites

Before proceeding, ensure that you have a project that has implemented the basic real-time engagement functionality.

## Implementation

To set the audio profile and scenario, see the following sample code:

```java
// Set the audio scenario as AUDIO_SCENARIO_HIGH_DEFINITION when creating the `RtcEngine` instance.
RtcEngineConfig config = new RtcEngineConfig();
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.HIGH_DEFINITION);
engine = RtcEngine.create(config);
// Set the audio profile as AUDIO_PROFILE_MUSIC_HIGH_QUALITY.
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY);
```

The following table shows the recommended audio profile and scenario in common applications:

| Application           | Audio profile (with the prefix `AUDIO_PROFILE_`)                    | Audio scenario (with the prefix `AUDIO_SCENARIO_`)                |
| :--------------------- | :------------------------- | :---------------------- |
| One-to-one classroom:<p>Requires the call quality with smooth transmission.</p>   | `DEFAULT`                    | `DEFAULT`                 |
| Battle royale game:<p>Transmits the voice of group talk. Requires noise reduction and low transmission bitrate.</p>     | `SPEECH_STANDARD`            | `CHATROOM`         |
| Murder mystery game:<p>Requires standard audio quality and smooth audio expirence when a user frequently switchs the user role or mute and unmute the microphone.</p>    | `MUSIC_STANDARD`             | `CHATROOM` |
| KTV: <p>Requires high-fidelity audio and a high performance to music or singing voice.</p>                    | `MUSIC_HIGH_QUALITY`        | `HIGH_DEFINITION`          |
| Podcast: <p>Uses professional audio hardware devices. Requires high-fidelity audio and stereo channels.</p>                | `MUSIC_HIGH_QUALITY_STEREO` | `HIGH_DEFINITION`                |

### API reference

- [create](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#afffd4c0d9b799631ed407c5167b6e09a) 2
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#abb4b63716fda137ecd5254137c79547f) 1
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#ac4d4cabacd4c45dcbb7439ba9d86136e) 2

## Reference

### Sample project

Agora provides an open-source demo project that implements [setting audio profile](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SetAudioProfile.java) on GitHub. You can try the demo and view the source code.

<a name="volume_type"></a>

### Volume type

The volume type includes the in-call volume and media volume. See the difference between them as follows:

- The in-call volume:
  - Has low audio quality, using the audio processing module of the user's device.
  - Cancels all echoes that are produced by the user's device, but might cause the loss of music or singing voice.
  - Cannot be adjusted to 0.
- The media volume:
  - Has high audio quality, using the audio processing module of the Agora SDK.
  - Has a high performance to music or singing voice, but might not completely cancel echoes that are produced by the user's device.
  - Can be adjusted to 0.

The following tables show the volume type according to different audio scenarios, user roles, and audio routes.

- In the `AUDIO_SCENARIO_DEFAULT` scenario:

| User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
| ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
| <li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li> | Media volume    | In-call volume            | In-call volume    |
| Single host in the interactive live  streaming profile       | Media volume    | Media volume              | In-call volume    |
| Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AUDIO_SCENARIO_HIGH_DEFINITION` or `AUDIO_SCENARIO_GAME_STREAMING` scenario:

| User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
| ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
| <li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li> | Media volume    | Media volume            | Media volume    |
| Single host in the interactive live  streaming profile       | Media volume    | Media volume              | Media volume    |
| Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AUDIO_SCENARIO_CHATROOM` scenario:

| User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
| ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
| <li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li> | Media volume    | In-call volume            | In-call volume    |
| Single host in the interactive live  streaming profile       | Media volume    | In-call volume              | In-call volume    |
| Audience in the interactive live  streaming profile          | Media volume    | In-call volume              | In-call volume      |
