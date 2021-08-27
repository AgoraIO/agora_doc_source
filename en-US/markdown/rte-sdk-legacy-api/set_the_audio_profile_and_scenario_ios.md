# Set the Audio Profile and Scenario

An audio profile includes the audio sample rate, encoding scheme, number of channels, and bitrate for the encoding audio stream; an audio scenario determines the audio performance.

Different applications require different audio profiles or scenarios. This page shows you how to set the appropriate audio profile and scenario in your app using Agora SDKs.

## Understand the tech

The SDK uses the `AgoraAudioProfileDefault` profile and the `AgoraAudioScenarioHighDefinition` scenario by default. If the default setting does not meet your requirements, you can call the following APIs to set another audio profile or scenario:

| API                                          | Description                                                  |
| :---------------------------------------------- | :----------------------------------------------------------- |
| `sharedEngineWithConfig(config.audioScenario)`        | Sets the audio scenario when you create the `AgoraRtcEngineKit` instance. The default value is `AgoraAudioScenarioHighDefinition`. |
| `setAudioProfile(profile)` | Sets the audio profile either before or after joining a channel. |
| `setAudioProfile(profile, scenario)` | Sets the audio profile and scenario either before or after joining a channel. |

## Prerequisites

Before proceeding, ensure that you have a project that has implemented the [basic real-time engagement functionality](https://docs-preprod.agora.io/en/null/start_call_ios_ng?platform=iOS).

## Implementation

This section shows you how to set the audio profile and scenario in common applications. You can add the sample code in `ViewController.swift` of your project.

### One-to-one classroom

For the one-to-one classroom that requires the call quality with smooth transmission, add the following code to your project:

```swift
// Swift
// Set the audio scenario when you create the `AgoraRtcEngineKit` instance
var audioScenario:AgoraAudioScenario = .default
config.audioScenario = audioScenario
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

// Set the audio profile
var audioProfile:AgoraAudioProfile = .default
agoraKit.setAudioProfile(audioProfile)
```

### Battle royale game

For the battle royale game that transmits the voice of group talk, and requires noise reduction and low transmission bitrate, add the following code to your project:

```swift
// Swift
// Set the audio scenario when you create the `AgoraRtcEngineKit` instance
var audioScenario:AgoraAudioScenario = .chatroom
config.audioScenario = audioScenario
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

// Set the audio profile
var audioProfile:AgoraAudioProfile = .speechstandard
agoraKit.setAudioProfile(audioProfile)
```

### Murder mystery game

For the murder mystery game that requires standard audio quality and smooth audio experience when a user frequently switches the user role or mute and unmute the microphone, add the following code to your project:

```swift
// Swift
// Set the audio scenario when you create the `AgoraRtcEngineKit` instance
var audioScenario:AgoraAudioScenario = .chatroom
config.audioScenario = audioScenario
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

// Set the audio profile
var audioProfile:AgoraAudioProfile = .musicstandard
agoraKit.setAudioProfile(audioProfile)
```

### KTV

For the KTV that requires high-fidelity audio and a high performance to music or singing voice, add the following code to your project:

```swift
// Swift
// Set the audio scenario when you create the `AgoraRtcEngineKit` instance
var audioScenario:AgoraAudioScenario = .highdefinition
config.audioScenario = audioScenario
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

// Set the audio profile
var audioProfile:AgoraAudioProfile = .musichighquality
agoraKit.setAudioProfile(audioProfile)
```

### Podcast

For the podcast that uses professional audio hardware devices, and requires high-fidelity audio and stereo audio channels, add the following code to your project:

```swift
// Swift
// Set the audio scenario when you create the `AgoraRtcEngineKit` instance
var audioScenario:AgoraAudioScenario = .highdefinition
config.audioScenario = audioScenario
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

// Set the audio profile
var audioProfile:AgoraAudioProfile = .musichighqualitystereo
agoraKit.setAudioProfile(audioProfile)
```

## Reference

This section provides reference information you may need when setting the audio profile and scenario.

### Sample project

Agora provides an open-source sample project that implements [setting audio profile](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Basic/JoinChannelAudio/JoinChannelAudio.swift) on GitHub. You can try the sample project and view the source code.

### API reference

- [sharedEngineWithConfig](https://docs-preview.agoralab.co/en/trinity/API%20Reference/oc_high_level/interface_agora_rtc_engine_kit.html#a7b846b533c9144396668b7ce9d90cb8b)
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/oc_high_level/interface_agora_rtc_engine_kit.html#a420dff42a101a418c796c537969a1db1) [1/2]
- [setAudioProfile](https://docs-preview.agoralab.co/en/trinity/API%20Reference/oc_high_level/interface_agora_rtc_engine_kit.html#a417eef3a3746c4e68488269fef41b2af) [2/2]

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

- In the `AgoraAudioScenarioDefault` scenario:

  | User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
  | ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
  | <ul><li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li></ul> | Media volume    | In-call volume            | In-call volume    |
  | Single host in the interactive live  streaming profile       | Media volume    | Media volume              | In-call volume    |
  | Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AgoraAudioScenarioHighDefinition` or `AgoraAudioScenarioGameStreaming` scenario:

  | User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
  | ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
  | <ul><li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li></ul> | Media volume    | Media volume            | Media volume    |
  | Single host in the interactive live  streaming profile       | Media volume    | Media volume              | Media volume    |
  | Audience in the interactive live  streaming profile          | Media volume    | Media volume              | Media volume      |

- In the `AgoraAudioScenarioChatRoom` scenario:

  | User role \ Audio route                                     | Wired earphones | Speakerphone or earpiece | Bluetooth devices |
  | ------------------------------------------------------------ | --------------- | ------------------------- | ----------------- |
  | <ul><li>Hosts in the interactive live streaming profile</li><li>Users in the communication profile</li></ul> | Media volume    | In-call volume            | In-call volume    |
  | Single host in the interactive live  streaming profile       | Media volume    | In-call volume              | In-call volume    |
  | Audience in the interactive live  streaming profile          | Media volume    | In-call volume              | In-call volume      |