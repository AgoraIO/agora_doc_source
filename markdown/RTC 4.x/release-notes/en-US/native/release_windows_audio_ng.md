## v4.2.2

v4.2.2 was released on July xx, 2023.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard tokens](links).

   <div class="alert note"> All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `preloadChannel[1/2]` and `preloadChannel[2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard tokens](links).

#### Improvements

**Channel media relay**

The number of target channels for media relay has been increased to 6. When calling `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

#### Issues fixed

This release fixed the following issues:

- Slow channel reconnection after the connection was interrupted due to network reasons.
- In multi-device audio recording scenarios, after repeatedly plugging and unplugging or enabling/disabling the audio recording device, no sound could be heard occasionally when calling the `startRecordingDeviceTest` to start an audio capturing device test. 

#### API changes

**Added**

- `preloadChannel[1/2]`
- `preloadChannel[2/2]`
- `updatePreloadChannelToken`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio interactions.

#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `setAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.

## v4.2.0

v4.2.0 was released on May xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Channel media options**

- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `publishCustomAudioTrack` instead.
- `publishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `publishCustomAudioTrackId`.

**2. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`, thus the prototype of the following methods are updated accordingly:
  - `onFrame`
  - `registerAudioFrameObserver` [1/2] and `registerAudioFrameObserver`[2/2] in `IMediaPlayer`
- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use `setDualStreamMode`[1/2] and `setDualStreamMode`[2/2] instead.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.
- `OnRecordAudioEncodedFrame` is renamed to `onRecordAudioEncodedFrame` 
- `OnPlaybackAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame` 
- `OnMixedAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame` 

#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.

#### Improvements

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

**2. Channel media relay**

This release introduces `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**3. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

#### Issues fixed

This release fixed the issue that when the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.

#### API changes

**Added**

- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setAINSMode`
- `createAudioCustomTrack`
- `destroyAudioCustomTrack`
- `AudioTrackConfig`
- `AUDIO_TRACK_TYPE`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`

**Modified**

- `OnRecordAudioEncodedFrame` is renamed to `onRecordAudioEncodedFrame`
- `OnPlaybackAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame`
- `OnMixedAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame`

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