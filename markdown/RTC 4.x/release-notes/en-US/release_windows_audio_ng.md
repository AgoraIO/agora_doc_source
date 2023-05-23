# v4.2.0

v4.2.0 was released on May xx, 2023.

## Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Channel media options**

- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `publishCustomAudioTrack` instead.
- `publishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `publishCustomAudioTrackId`.

**2. Audio recording**

- `AGORA_IID_MEDIA_RECORDER` in `INTERFACE_ID_TYPE` is deleted. As of v4.2.0, before creating a recording object, you don't need to obtain the `AGORA_IID_MEDIA_RECORDER` interface class pointer. You can directly create a recording object through the `createMediaRecorder` method released in this version.
- The `connection` parameter in the `startRecording`, `stopRecording`, and `setMediaRecorderObserver` methods is deleted.
- The `release` method in the `IMediaRecorder` class is deleted. You can use the `destroyMediaRecorder `method released in this version to destroy a recording object and release resources.

**3. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`, thus the prototype of the following methods are updated accordingly:
  - `onFrame`
  - `registerAudioFrameObserver` [1/2] and `registerAudioFrameObserver`[2/2] in `IMediaPlayer`
- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use `setDualStreamMode`[1/2] and `setDualStreamMode`[2/2] instead.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.

## New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.

## Improvements

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

**2. Channel media relay**

This release introduces `startOrUpdateChannleMediaRelay` and `startOrUpdateChannleMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**3. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

## Issues fixed

This release fixed the issue that when the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.

## API changes

**Added**

- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setAINSMode`
- `createAudioCustomTrack`
- `destroyAudioCustomTrack`
- `createMediaRecorder`
- `destroyMediaRecorder`
- `AudioTrackConfig`
- `RecorderStreamInfo`
- `AUDIO_TRACK_TYPE`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `channelId` and `uid` parameters in `onRecorderStateChanged` and `onRecorderInfoUpdated` callbacks

**Deprecated**

- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**Deleted**

- `onApiCallExecuted`
- `publishCustomAudioTrackEnableAec ` in ` ChannelMediaOptions`
- `getMediaRecorder`
- `release` in `IMediaRecorder`
- `AGORA_IID_MEDIA_RECORDER`
- The `connection` parameter in `startRecording`, `stopRecording`, and `setMediaRecorderObserver`