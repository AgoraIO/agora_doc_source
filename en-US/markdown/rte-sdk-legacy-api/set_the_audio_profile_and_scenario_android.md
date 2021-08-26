# Set the Audio Profile and Scenario

An audio profile includes the audio sample rate, encoding scheme, number of channels, and bitrate for the encoding audio stream; an audio scenario determines the audio performance.

Different applications require different audio profiles or scenarios. This page shows you how to set the appropriate audio profile and scenario in your app using Agora SDKs.

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
| `DEFAULT`                   | 0: Default audio profile:<li>For the interactive streaming profile: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.</li><li>For the communication profile: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.</li> |
| `SPEECH_STANDARD`           | 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps. |
| `MUSIC_STANDARD`            | 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps. |
| `MUSIC_STANDARD_STEREO`     | 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps. |
| `MUSIC_HIGH_QUALITY`        | 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps. |
| `MUSIC_HIGH_QUALITY_STEREO` | 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps. |

### Audio scenario

If the default audio scenario (`AUDIO_SCENARIO_HIGH_DEFINITION`) does not meet your requirements, you can set the following audio scenarios instead:

| Audio scenario (with the prefix `AUDIO_SCENARIO_`)                                          | Description                                                  |
| :---------------------------------------------- | :----------------------------------------------------------- |
| `DEFAULT`         | Automatic scenario match, where the SDK chooses the appropriate audio quality according to the user role and audio route. |
| `HIGH_DEFINITION`/`GAME_STREAMING`         | High-quality audio scenario, where users mainly play music. |
| `CHATROOM`         | Chatroom scenario, where users need to frequently switch the user role or mute and unmute the microphone. |

The audio scenario also affects the volume type. For details, see [Volume type](#volume_type).

## Prerequisites

Before proceeding, ensure that you have a project that has implemented the [basic real-time engagement functionality](https://docs-preprod.agora.io/en/live-streaming-4.x-preview/start_live_android_ng?platform=Android).

## Implementation

This section shows you how to set the audio scenario when you create the `RtcEngine` instance and set the audio profile either before or after joining a channel. In `/app/java/com.example.<projectname>/MainActivity`, add the following lines:

```java
// Set the audio scenario when you create the `RtcEngine` instance
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.HIGH_DEFINITION);
engine = RtcEngine.create(config);

// Set the audio profile
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY);
```

To know the recommended audio profile and scenario in common applications, see [Common applications](#common_applications).

## Reference

This section provides reference information you may need when setting the audio profile and scenario.

### Sample project

Agora provides an open-source sample project that implements [setting audio profile](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SetAudioProfile.java) on GitHub. You can try the sample project and view the source code.

### API reference

- [create](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#afffd4c0d9b799631ed407c5167b6e09a) 2
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#abb4b63716fda137ecd5254137c79547f) 1
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#ac4d4cabacd4c45dcbb7439ba9d86136e) 2

<a name="volume_type"></a>

### Volume type

The volume type includes the in-call volume and media volume. See the difference between them as follows:

- The in-call volume:
  - Low audio quality.
  - Cancels all echoes that are produced by the user's device, but might cause the loss of music or singing voice.
  - Cannot be adjusted to 0.
- The media volume:
  - High audio quality.
  - Has a high performance to music or singing voice, but might not completely cancel echoes that are produced by the user's device.
  - Can be adjusted to 0.

The following tables show the volume type according to different audio scenarios, user roles, and audio routes.

- In the `AUDIO_SCENARIO_DEFAULT` scenario:

  | User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
  | ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
  | <ul><li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li></ul> | Media volume    | In-call volume            | In-call volume    |
  | Single host in the interactive live  streaming profile       | Media volume    | Media volume              | In-call volume    |
  | Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AUDIO_SCENARIO_HIGH_DEFINITION` or `AUDIO_SCENARIO_GAME_STREAMING` scenario:

  | User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
  | ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
  | <ul><li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li></ul> | Media volume    | Media volume            | Media volume    |
  | Single host in the interactive live  streaming profile       | Media volume    | Media volume              | Media volume    |
  | Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AUDIO_SCENARIO_CHATROOM` scenario:

  | User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
  | ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
  | <ul><li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li></ul> | Media volume    | In-call volume            | In-call volume    |
  | Single host in the interactive live  streaming profile       | Media volume    | In-call volume              | In-call volume    |
  | Audience in the interactive live  streaming profile          | Media volume    | In-call volume              | In-call volume      |

<a name="common_applications"></a>

## Common applications

The following table shows the recommended audio profile and scenario in common applications:

| Application           | Audio profile (with the prefix `AUDIO_PROFILE_`)                    | Audio scenario (with the prefix `AUDIO_SCENARIO_`)                |
| :--------------------- | :------------------------- | :---------------------- |
| One-to-one classroom:<p>Requires the call quality with smooth transmission.</p>   | `DEFAULT`                    | `DEFAULT`                 |
| Battle royale game:<p>Transmits the voice of group talk. Requires noise reduction and low transmission bitrate.</p>     | `SPEECH_STANDARD`            | `CHATROOM`         |
| Murder mystery game:<p>Requires standard audio quality and smooth audio expirence when a user frequently switchs the user role or mute and unmute the microphone.</p>    | `MUSIC_STANDARD`             | `CHATROOM` |
| KTV: <p>Requires high-fidelity audio and a high performance to music or singing voice.</p>                    | `MUSIC_HIGH_QUALITY`        | `HIGH_DEFINITION`          |
| Podcast: <p>Uses professional audio hardware devices. Requires high-fidelity audio and stereo channels.</p>                | `MUSIC_HIGH_QUALITY_STEREO` | `HIGH_DEFINITION`                |