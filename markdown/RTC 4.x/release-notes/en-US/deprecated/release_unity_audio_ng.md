## v4.2.2

This version was released on July, xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

1. **Audio frame observer**

The following methods in the `IAudioFrameObserver` class are deleted:

- `GetObservedAudioFramePosition`: Use the newly-added `position` parameter in  `RegisterAudioFrameObserver` instead.
- `GetPlaybackAudioParams`: Use `SetPlaybackAudioFrameParameters` instead.
- `GetRecordAudioParams`: Use `SetRecordingAudioFrameParameters` instead.
- `GetMixedAudioParams`: Use `SetMixedAudioFrameParameters` instead.
- `GetEarMonitoringAudioParams`: Use `SetEarMonitoringAudioFrameParameters` instead.

2. **Metadata**

This release deletes `GetMaxMetadataSize` and `OnReadyToSendMetadata` in the `IMetadataObserver` class. You can use the newly-added `SetMaxMetadataSize` and `SendMetadata` methods instead.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert info">All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `PreloadChannel[1/2]` and `PreloadChannel[2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).


#### Improvements

**Channel media relay**

The number of target channels for media relay has been increased to 6. When calling `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

This release also includes the following additional improvements:

To improve the switching experience between multiple audio routes, this release adds the `SetRouteInCommunicationMode` method. This method can switch the audio route from a Bluetooth headphone to the earpiece, wired headphone or speaker in communication volume mode ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)). (Android)

#### Issues fixed

This release fixed the following issues:

- Occasionally, noise occurred when the local user listened to their own and remote audio after joining the channel. (macOS)
- Slow channel reconnection after the connection was interrupted due to network reasons.
- In multi-device audio recording scenarios, after repeatedly plugging and unplugging or enabling/disabling the audio recording device, no sound could be heard occasionally when calling the `StartRecordingDeviceTest` to start an audio capturing device test. (Windows)

#### API changes

**Added**

- `PreloadChannel[1/2]`
- `PreloadChannel[2/2]`
- `UpdatePreloadChannelToken`
- `SetRouteInCommunicationMode` (Android)
- `SetMaxMetadataSize`
- `SendMetadata`
- `position` parameter in `RegisterAudioFrameObserver` 

**Deleted**

- `GetObservedAudioFramePosition`
- `GetPlaybackAudioParams`
- `GetRecordAudioParams`
- `GetMixedAudioParams`
- `GetEarMonitoringAudioParams`
- `GetMaxMetadataSize`
- `OnReadyToSendMetadata`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio interactions.

#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `SetAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- Occasional crash after calling the `DestroyMediaPlayer` method. (iOS)

## v4.2.0

v4.2.0 was released on May xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Channel media options**

- `PublishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `PublishCustomAudioTrack` instead.
- `PublishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `PublishCustomAudioTrackId`.

**2. Virtual sound card (macOS)**

As of v4.2.0, Agora supports third-party virtual sound cards. You can use a third-party virtual sound card as the audio input or output device for the SDK. You can use the `stateChanged` callback to see whether the current input or output device selected by the SDK is a virtual sound card.

<div class="alert info">If you set AgoraALD or Soundflower as the default input or output device when joining a channel, you will not hear audio.</div>

**3. Miscellaneous**

- `OnApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.

  The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`,thus the prototype of the following methods are updated accordingly:

  - `OnFrame`
  - `RegisterAudioFrameObserver` [1/2] and `RegisterAudioFrameObserver`[2/2] in `IMediaPlayer`

- `StartChannelMediaRelay`, `UpdateChannelMediaRelay`, `StartChannelMediaRelayEx` and `UpdateChannelMediaRelayEx` are deprecated. Use `StartOrUpdateChannelMediaRelay`And `StartOrUpdateChannelMediaRelayEx` instead.

#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `SetAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `GetNtpWallTimeInMs`For obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyricsprogression, resulting in a better collaborative experience.

**3. Instant frame rendering**

This release adds the `EnableInstantMediaRendering` method to enable instant rendering mode for audio  frames, which can speed up the first audio frame rendering after the user joins the channel.


#### Improvements

**1. Voice changer**

This release introduces the `SetLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `SetLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.


 **2. Improved compatibility with audio file types (Android)**

As of v4.2.0, you can use the following methods to open files with a URI starting with `Content://` : `StartAudioMixing` [2/2], `PlayEffect` [3/3], `Open`, and `OpenWithMediaSource`.

**3. Channel media relay**

This release introduces `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**4. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `CreateCustomAudioTrack` and `DestroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

#### Issues fixed

This release fixed the following issues:

**Android**

- Occasional crashes occur on Android devices when users joining or leaving a channel. 
- Occational failure when enabling in-ear monitoring. 
- Occational echo. 
- In real-time chorus scenarios, remote users heard noises and echoes when an OPPO R11 device joined the channel in loudspeaker mode. 
- When the playback of the local music finished, the `OnAudioMixingFinished` callback was not properly triggered. 
- Abnormal client status caused by an exception in the `OnRemoteAudioStateChanged` callback. 

**iOS**

- Abnormal client status cased by an exception in the `OnRemoteAudioStateChanged` callback.

**All platforms**

- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Playing audio files with a sample rate of 48 kHz failed.

#### API changes

**Added**

- `StartOrUpdateChannelMediaRelay`
- `StartOrUpdateChannelMediaRelayEx`
- `GetNtpWallTimeInMs`
- `CreateAudioCustomTrack`
- `DestroyAudioCustomTrack`
- `AudioTrackConfig`
- `AUDIO_TRACK_TYPE`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `channelId` and `uid` parameters in `OnRecorderStateChanged` and `OnRecorderInfoUpdated` callbacks
- `EnableInstantMediaRendering`

**Deprecated**

- `StartChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelay`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**Deleted**

- `OnApiCallExecuted`
- `PublishCustomAudioTrackEnableAec ` in ` ChannelMediaOptions`