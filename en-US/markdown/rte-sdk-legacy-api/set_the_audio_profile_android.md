# Set the audio profile and scenario

## Understand the tech

The setting of the audio profile determines the audio sample rate, encoding scheme, number of channels, and bitrate for the encoding audio stream; the setting of the audio scenario determines the audio processing module.

Different application requires different audio profile or scenario. This page introduces how to call Agora APIs to set an appropriate audio profile and scenario according to your application.

## Sample project

Agora provides an open-source demo project that implements [setting audio profile](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SetAudioProfile.java) on GitHub. You can try the demo and view the source code.

## API introduction

The default audio profile of the SDK is `AUDIO_PROFILE_DEFAULT` and the default audio scenario of the SDK is `AUDIO_SCENARIO_HIGH_DEFINITION`. If the default setting does not meet your requirements, you can call the following APIs to set another audio profile or scenario:

| API                                          | Description                                                  |
| :---------------------------------------------- | :----------------------------------------------------------- |
| `create(config.mAudioScenario)`        | Sets the audio scenario when you create an `RtcEngine` instance. The default value is `AUDIO_SCENARIO_HIGH_DEFINITION`. |
| `setAudioProfile(profile)` | Sets the audio profile either before or after joining a channel. |
| `setAudioProfile(profile, scenario)` | Sets both the audio profile and scenario either before or after joining a channel. |

### Audio profile

The higher bitrate in the audio profile, the higher audio quality. If the default audio profile `AUDIO_PROFILE_DEFAULT` does not meet your requirements, you can set the following audio profiles instead:

| Audio profile (with the prefix `AUDIO_PROFILE_` )                              | Description                                                           |
| :-------------------------------------- | ------------------------------------------------------------ |
| `DEFAULT`                   | 0: Default audio profile:<li>For the interactive streaming profile: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 64 Kbps.</li><li>For the communication profile: A sample rate of 32 KHz, music encoding, mono, and a bitrate of up to 18 Kbps.</li> |
| `SPEECH_STANDARD`           | 1: A sample rate of 32 KHz, audio encoding, mono, and a bitrate of up to 18 Kbps. |
| `MUSIC_STANDARD`            | 2: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 64 Kbps. |
| `MUSIC_STANDARD_STEREO`     | 3: A sample rate of 48 KHz, music encoding, stereo, and a bitrate of up to 80 Kbps. |
| `MUSIC_HIGH_QUALITY`        | 4: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 96 Kbps. |
| `MUSIC_HIGH_QUALITY_STEREO` | 5: A sample rate of 48 KHz, music encoding, stereo, and a bitrate of up to 128 Kbps. |

### Audio scenario

If the default audio scenario `AUDIO_SCENARIO_HIGH_DEFINITION` does not meet your requirements, you can set the following audio scenarios instead:

| Audio scenario (with the prefix `AUDIO_SCENARIO_`)                                          | Description                                                  |
| :---------------------------------------------- | :----------------------------------------------------------- |
| `DEFAULT`         | Low audio quality. The scenario uses the audio processing module that is automatically changed according to the user role and the audio route. |
| `HIGH_DEFINITION`/`GAME_STREAMING`         | High audio quality. The scenario uses the audio processing module of the Agora SDK that has high performance of music or singing voice. |
| `CHATROOM`         | Low audio quality. No matter what the user role is, the scenario uses the audio processing module of the user's device that has high performance of talk voice.  |

The audio scenario also affects the volume type. For details, see [Volume type](#volume_type).

### Sample code

The following table shows how to set the profile and scenario parameters in common applications:

| Applications           | Audio profile (with the prefix `AUDIO_PROFILE_` )                    | Audio scenario (with the prefix `AUDIO_SCENARIO_`)                |
| :--------------------- | :------------------------- | :---------------------- |
| One-to-one classroom:<p>Requires the call quality with smooth transmission and high-fidelity audio.</p>   | `DEFAULT`                    | `DEFAULT`                 |
| Battle royale game:<p>Transmits the talk voice only. Requires noise reduction and low transmission rate for multiplayer games.</p>     | `SPEECH_STANDARD`            | `CHATROOM`         |
| Murder mystery game:<p>Requires high-fidelity audio and smooth audio expirence when a user frequently switchs the user role.</p>    | `MUSIC_STANDARD`             | `CHATROOM` |
| KTV: <p>Requires high-fidelity audio and high performance of music or singing voice.</p>                    | `MUSIC_HIGH_QUALITY`        | `HIGH_DEFINITION`          |
| Podcast: <p>Uses professional audio hardware devices. Requires high-fidelity audio and stereo channels.</p>                | `MUSIC_HIGH_QUALITY_STEREO` | `HIGH_DEFINITION`                |

```java
RtcEngineConfig config = new RtcEngineConfig();
engine = RtcEngine.create(config);

// One-to-one classroom
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.DEFAULT);
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_DEFAULT);

// Battle royale game
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.CHATROOM);
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_SPEECH_STANDARD);

// Murder mystery game
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.CHATROOM);
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_STANDARD);

// KTV
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.HIGH_DEFINITION);
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY);

// Podcast
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.HIGH_DEFINITION);
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO);
```

### API reference

- [create](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#afffd4c0d9b799631ed407c5167b6e09a) 2
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#abb4b63716fda137ecd5254137c79547f) 1
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#ac4d4cabacd4c45dcbb7439ba9d86136e) 2

## Reference

<a name="volume_type"></a>

### Volume type

The volume type includes the in-call volume and media volume. See the difference between two volume types as follows:

- The in-call volume:
  - Uses the audio processing module of the user's device.
  - Low audio quality.
  - Cancels all echoes that is produced by the user's device, but might cause the loss of music or singing voice.
  - Cannot be adjusted to 0.
- The media volume:
  - Uses the audio processing module of the Agora SDK.
  - High audio quality.
  - Has high performance of music or singing voice, but might not completely cancel echoes that is produced by the user's device.
  - Can be adjusted to 0.

The following tables show the volume type according to different audio scenario, user role, and audio route.

- In the `AUDIO_SCENARIO_DEFAULT` scenario:

| User role \ Audio route                                     | Wired earphones | Speakerphone and earpiece | Bluetooth devices |
| ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
| <li>Hosts in the interactive live streaming  profile</li><li>Users in the communication profile</li> | Media volume    | In-call volume            | In-call volume    |
| Single host in the interactive live  streaming profile       | Media volume    | Media volume              | In-call volume    |
| Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AUDIO_SCENARIO_HIGH_DEFINITION` or `AUDIO_SCENARIO_GAME_STREAMING` scenario:

| User role \ Audio route                                     | Wired earphones | Speakerphone and earpiece | Bluetooth devices |
| ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
| <li>Hosts in the interactive live streaming  profile</li><li>Users in the communication profile</li> | Media volume    | Media volume            | Media volume    |
| Single host in the interactive live  streaming profile       | Media volume    | Media volume              | Media volume    |
| Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AUDIO_SCENARIO_CHATROOM` scenario:

| User role \ Audio route                                     | Wired earphones | Speakerphone and earpiece | Bluetooth devices |
| ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
| <li>Hosts in the interactive live streaming  profile</li><li>Users in the communication profile</li> | Media volume    | In-call volume            | In-call volume    |
| Single host in the interactive live  streaming profile       | Media volume    | In-call volume              | In-call volume    |
| Audience in the interactive live  streaming profile          | Media volume    | In-call volume              | In-call volume      |
