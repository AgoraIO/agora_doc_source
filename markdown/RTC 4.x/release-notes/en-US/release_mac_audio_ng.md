# v4.2.0

v4.2.0 was released on May 23, 2023.

## Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**2. Channel media options**

- `publishCustomAudioTrackEnableAec` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` is renamed to `publishCustomAudioTrackId`.

**3. Audio recording**

- `sharedMediaRecorderWithRtcEngine` is deleted. You can create a recording object through the `createMediaRecorder` method released in this version.
- The `connection` parameter in the `startRecording`, `stopRecording`, and `setMediaRecorderDelegate` methods is deleted.
- The `destroy` method in the `AgoraMediaRecorder` class is deleted. You can use the `destroyMediaRecorder` method released in this version to destroy a recording object and release resources. 

**4. Virtual sound card** 

As of v4.2.0, Agora supports third-party virtual sound cards. You can use a third-party virtual sound card as the audio input or output device for the SDK. You can use the `stateChanged` callback to see whether the current input or output device selected by the SDK is a virtual sound card.

<div class="alert note">If you set AgoraALD or Soundflower as the default input or output device when joining a channel, you will not hear audio.</div>

**5. Miscellaneous**

- `didApiCallExecute` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.

## New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.

## Improvements 

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

**4. Channel media relay**

This release introduces `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**5. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

## Issues fixed

This release fixed the following issues:

- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Incorrect information in the `type` field of the return value after calling `getDefaultAudioDevice`.

## API changes

**Added**

- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `getCurrentMonotonicTimeInMs`
- `setAINSMode`
- `createAudioCustomTrack`
- `destroyAudioCustomTrack`
- `createMediaRecorder`
- `destroyMediaRecorder`
- `AudioTrackConfig`
- `RecorderStreamInfo`
- `AgoraAudioTrackType`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `AgoraRtcEngineConfig`
- The `channelId` and `uid` parameters in `stateDidChanged` and `informationDidUpdated` callbacks

**Deprecated**

- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `didReceiveChannelMediaRelayEvent`
- `AgoraChannelMediaRelayEvent`

**Deleted**

- `didApiCallExecute`
- `publishCustomAudioTrackEnableAec` in ` AgoraRtcChannelMediaOptions`
- `sharedMediaRecorderWithRtcEngine`
- `destroy` in `AgoraMediaRecorder`
- The `connection` parameter in `startRecording`, `stopRecording`, and `setMediaRecorderDelegate`

## v4.1.1 

v4.1.1 was released on January xx, 2023.


#### New features

**Instant frame rendering**

This release adds the `enableInstantMediaRendering` method to enable instant rendering mode for audio frames, which can speed up the first audio frame rendering after the user joins the channel.



#### Issues fixed

- This release fixed the issue that playing audio files with a sample rate of 48 kHz failed.
- At the moment when a user left a channel, a request for leaving was not sent to the server and the leaving behavior was incorrectly determined by the server as timed out.


#### API changes

**Added**

- `enableInstantMediaRendering`

## v4.1.0

v4.1.0 was released on November xx, 2022.

#### New features

**1. Headphone equalization effect**

This release adds the `setHeadphoneEQParameters` method, which is used to adjust the low- and high-frequency parameters of the headphone EQ. This is mainly useful in spatial audio scenarios. If you cannot achieve the expected headphone EQ effect after calling `setHeadphoneEQPreset`, you can call setHeadphoneEQParameters to adjust the EQ.

**2. MPUDP (MultiPath UDP) (Beta)**

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

> To enable this feature, contact [sales-us@agora.io](sales-us@agora.io).

**3. Device management**

This release adds a series of callbacks to help you better understand the status of your audio devices:

- `onAudioDeviceStateChanged`(C++) : Occurs when the status of the audio device changes. 
- `onAudioDeviceVolumeChanged` (C++) : Occurs when the volume of an audio device or app changes. 

**4. Multi-channel management**

This release adds a series of multi-channel related methods that you can call to manage audio streams in multi-channel scenarios.

- The `muteLocalAudioStreamEx` method is used to cancel or resume publishing a local audio stream, respectively.
- The `muteAllRemoteAudioStreamsEx` is used to cancel or resume the subscription of all remote users to audio streams, respectively.
- The `startRtmpStreamWithoutTranscodingEx`, `startRtmpStreamWithTranscodingEx`, `updateRtmpTranscodingEx`, and `stopRtmpStreamEx` methods are used to implement Media Push in multi-channel scenarios.
- The `startChannelMediaRelayEx`, `updateChannelMediaRelayEx`, `pauseAllChannelMediaRelayEx`, `resumeAllChannelMediaRelayEx`, and `stopChannelMediaRelayEx` methods are used to relay media streams across channels in multi-channel scenarios.
- Adds the `leaveChannelEx` [2/2] method. Compared with the `leaveChannelEx` [1/2] method, a new `options` parameter is added, which is used to choose whether to stop recording with the microphone when leaving a channel in a multi-channel scenario.

**5. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `didClientRoleChanged` callback. The value of this parameter is as follows:

- `AgoraAudienceLatencyLevelLowLatency` (1): Low latency.
- `AgoraAudienceLatencyLevelUltraLowLatency` (2): Ultra-low latency.

#### Improvements 

**1. Relaying media streams across channels**

This release optimizes the `updateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `AgoraChannelMediaRelayEventUpdateDestinationChannelRefused`(8), and you need to call the `updateChannelMediaRelay` method again.
- v4.1.0 and later: If the target channel update fails due to internal server reasons, the SDK retries the update until the target channel update is successful.

**2. Reconstructed AIAEC algorithm**

This release reconstructs the AEC algorithm based on the AI method. Compared with the traditional AEC algorithm, the new algorithm can preserve the complete, clear, and smooth near-end vocals under poor echo-to-signal conditions, significantly improving the system's echo cancellation and dual-talk performance. This gives users a more comfortable call and live-broadcast experience. AIAEC is suitable for conference calls, chats, karaoke, and other scenarios.

#### **Other improvements**

This release includes the following additional improvements:

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the `AgoraAudioScenarioMeeting` scenario.
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.

#### **Issues fixed**

This release fixed the following issues:

- After starting and stopping the audio capture device test, there was no sound when the audio playback device was subsequently started. 
- Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.
- The call `getExtensionProperty` failed and returned an empty string. 

#### **API changes**

**Added**

- `setHeadphoneEQParameters`
- `muteLocalAudioStreamEx`
- `muteAllRemoteAudioStreamsEx`
- `startRtmpStreamWithoutTranscodingEx`
- `startRtmpStreamWithTranscodingEx`
- `updateRtmpTranscodingEx`
- `stopRtmpStreamEx`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelayEx`
- `pauseAllChannelMediaRelayEx`
- `resumeAllChannelMediaRelayEx`
- `stopChannelMediaRelayEx`
- `followEncodeDimensionRatio` in `AgoraCameraCapturerConfiguration` 
- `leaveChannelEx` [2/2]
- `newRoleOptions` in `didClientRoleChanged` 
- `adjustUserPlaybackSignalVolumeEx`
- `enableAudioVolumeIndicationEx`

**Deprecated**

- `didApiCallExecute`. Use the callbacks triggered by specific methods instead.

**Deleted**

- Removes deprecated member parameters `backgroundImage` and `watermark` in `AgoraLiveTranscoding` class.
- Removes `AgoraChannelMediaRelayEventUpdateDestinationChannelRefused`(8) in `didReceiveChannelMediaRelayEvent` callback.