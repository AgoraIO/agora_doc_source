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

## Prerequisites

Before proceeding, ensure that you have a project that has implemented the [basic real-time engagement functionality](https://docs-preprod.agora.io/en/video-call-4.x-preview/start_call_android_ng?platform=Android).

## Implementation

This section shows you how to set the audio profile and scenario in common applications. You can add the sample code in `/app/java/com.example.<projectname>/MainActivity` of your project.

### One-to-one classroom

For the one-to-one classroom that requires the call quality with smooth transmission, add the following code to your project:

```java
// Set the audio scenario when you create the `RtcEngine` instance
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.DEFAULT);
engine = RtcEngine.create(config);

// Set the audio profile
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_DEFAULT);
```
### Battle royale game

For the battle royale game that transmits the voice of group talk, and requires noise reduction and low transmission bitrate, add the following code to your project:

```java
// Set the audio scenario when you create the `RtcEngine` instance
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.CHATROOM);
engine = RtcEngine.create(config);

// Set the audio profile
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_SPEECH_STANDARD);
```
### Murder mystery game

For the murder mystery game that requires standard audio quality and smooth audio experience when a user frequently switches the user role or mute and unmute the microphone, add the following code to your project:

```java
// Set the audio scenario when you create the `RtcEngine` instance
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.CHATROOM);
engine = RtcEngine.create(config);

// Set the audio profile
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_STANDARD);
```
### KTV

For the KTV that requires high-fidelity audio and a high performance to music or singing voice, add the following code to your project:

```java
// Set the audio scenario when you create the `RtcEngine` instance
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.HIGH_DEFINITION);
engine = RtcEngine.create(config);

// Set the audio profile
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY);
```
### Podcast

For the podcast that uses professional audio hardware devices, and requires high-fidelity audio and stereo audio channels, add the following code to your project:

```java
// Set the audio scenario when you create the `RtcEngine` instance
config.mAudioScenario = Constants.AudioScenario.getValue(Constants.AudioScenario.HIGH_DEFINITION);
engine = RtcEngine.create(config);

// Set the audio profile
RtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO);
```

## Reference

This section provides reference information you may need when setting the audio profile and scenario.

### Sample project

Agora provides an open-source sample project that implements [setting audio profile](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SetAudioProfile.java) on GitHub. You can try the sample project and view the source code.

### API reference

- [create](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#afffd4c0d9b799631ed407c5167b6e09a) [2/2]
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#ac4d4cabacd4c45dcbb7439ba9d86136e) [1/2]
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#abb4b63716fda137ecd5254137c79547f) [2/2]

### Volume type

The audio scenario affects the volume type. See the difference between two kinds of volume type as follows:

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