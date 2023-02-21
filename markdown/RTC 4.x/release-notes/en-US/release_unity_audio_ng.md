## v4.1.0

v4.1.0 was released on November xx, 2022.

#### New features

**1. In-ear monitoring**

This release adds support for in-ear monitoring. You can call `EnableInEarMonitoring` to enable the in-ear monitoring function.

After successfully enabling the in-ear monitoring function, you can call `RegisterAudioFrameObserver` to register the audio observer, and the SDK triggers the `OnEarMonitoringAudioFrame` callback to report the audio frame data. You can use your own audio effect processing module to preprocess the audio frame data of the in-ear monitoring to implement custom audio effects. Agora recommends that you choose one of the following two methods to set the audio data format of the in-ear monitoring:

- Call the `SetEarMonitoringAudioFrameParameters` method to set the audio data format of in-ear monitoring. The SDK calculates the sampling interval based on the parameters in this method and triggers the `OnEarMonitoringAudioFrame` callback based on the sampling interval.
- Set the audio data format in the return value of the `GetEarMonitoringAudioParams` callback. The SDK calculates the sampling interval based on the return value of the callback and triggers the `OnEarMonitoringAudioFrame` callback based on the sampling interval.

To adjust the in-ear monitoring volume, you can call `SetInEarMonitoringVolume`.

**2. Audio capture device test (Android)**

This release adds support for testing local audio capture devices before joining a channel. You can call `StartRecordingDeviceTest` to start the audio capture device test. After the test is complete, call the `StopPlaybackDeviceTest` method to stop the audio capture device test.

**3. Local network connection types**

To make it easier for users to know the connection type of the local network at any stage, this release adds the `GetNetworkType` method. You can use this method to get the type of network connection in use. The available values are UNKNOWN, DISCONNECTED, LAN, WIFI, 2G, 3G, 4G, and 5G. When the local network connection type changes, the SDK triggers the `OnNetworkTypeChanged` callback to report the current network connection type.

**4. Audio stream filter**

This release introduces filtering audio streams based on volume. Once this function is enabled, the Agora server ranks all audio streams by volume and transports the three audio streams with the highest volumes to the receivers by default. The number of audio streams to be transported can be adjusted; contact [support@agora.io](support@agora.io) to adjust this number according to your scenarios. 

Agora also supports publishers in choosing whether the audio streams being published are to be filtered based on volume. Streams that are not filtered bypass this filter mechanism and are transported directly to the receivers. In scenarios with a number of publishers, enabling this function helps reduce the bandwidth and device system pressure for the receivers.

<div class="alert info">To enable this function, contact <a href="support@agora.io">support@agora.io</a>.</div>

**5. Loopback device (Windows)** 

The SDK uses the playback device as the loopback device by default. As of 4.1.0, you can specify a loopback device separately and publish the captured audio to the remote end.

- `SetLoopbackDevice`: Specifies the loopback device. If you do not want the current playback device to be the loopback device, you can call this method to specify another device as the loopback device.
- `GetLoopbackDevice`: Gets the current loopback device.
- `FollowSystemLoopbackDevice`: Whether the loopback device follows the default playback device of the system.

**6. Spatial audio effect**

This release adds the following features applicable to spatial audio effect scenarios, which can effectively enhance the user's sense-of-presence experience in virtual interactive scenarios.

- Sound insulation area: You can set a sound insulation area and sound attenuation parameter by calling `SetZones`. When the sound source (which can be a user or the media player) and the listener belong to the inside and outside of the sound insulation area, the listener experiences an attenuation effect similar to that of the sound in the real environment when it encounters a building partition. You can also set the sound attenuation parameter for the media player and the user by calling `SetPlayerAttenuation` and `SetRemoteAudioAttenuation` respectively, and specify whether to use that setting to force an override of the sound attenuation parameter in `SetZones`.
- Doppler sound: You can enable Doppler sound by setting the `enable_doppler` parameter in `SpatialAudioParams`. The receiver experiences noticeable tonal changes in the event of a high-speed relative displacement between the source source and receiver (such as in a racing game scenario).
- Headphone equalizer: You can use a preset headphone equalization effect by calling the `SetHeadphoneEQPreset` method to improve the audio experience for users with headphones.

**7. Headphone equalization effect**

This release adds the `SetHeadphoneEQParameters` method, which is used to adjust the low- and high-frequency parameters of the headphone EQ. This is mainly useful in spatial audio scenarios. If you cannot achieve the expected headphone EQ effect after calling `SetHeadphoneEQPreset`, you can call setHeadphoneEQParameters to adjust the EQ.

**8. MPUDP (MultiPath UDP) (Beta)** 

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

<div class="alert info">To enable this feature, contact <a href="sales-us@agora.io">sales-us@agora.io</a>.</div>

**9. Register extensions (Windows)**

This release adds the `RegisterExtension` method for registering extensions. When using a third-party extension, you need to call the extension-related APIs in the following order:

`loadExtensionProvider` -> `registerExtension` -> `setExtensionProviderProperty` -> `enableExtension`

**10. Device management (Windows,macOS)**

This release adds a series of callbacks to help you better understand the status of your audio devices:

- `OnAudioDeviceStateChanged`: Occurs when the status of the audio device changes. 
- `OnAudioDeviceVolumeChanged`: Occurs when the volume of an audio device or app changes. 

**11. Multi-channel management**

This release adds a series of multi-channel related methods that you can call to manage audio streams in multi-channel scenarios.

- The `MuteLocalAudioStreamEx` method is used to cancel or resume publishing a local audio stream.
- The `MuteAllRemoteAudioStreamsEx`  is used to cancel or resume the subscription of all remote users to audio streams.
- The `StartRtmpStreamWithoutTranscodingEx`, `StartRtmpStreamWithTranscodingEx`, `UpdateRtmpTranscodingEx`, and `StopRtmpStreamEx` methods are used to implement Media Push in multi-channel scenarios.
- The `StartChannelMediaRelayEx`, `UpdateChannelMediaRelayEx`, `PauseAllChannelMediaRelayEx`, `ResumeAllChannelMediaRelayEx`, and `StopChannelMediaRelayEx` methods are used to relay media streams across channels in multi-channel scenarios.
- Adds the `LeaveChannelEx` [2/2] method. Compared with the `LeaveChannelEx` [1/2] method, a new `options` parameter is added, which is used to choose whether to stop recording with the microphone when leaving a channel in a multi-channel scenario.

**12. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `OnClientRoleChanged` callback. The value of this parameter is as follows:

- `AUDIENCE_LATENCY_LEVEL_LOW_LATENCY` (1): Low latency.
- `AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY` (2): Ultra-low latency.

#### Improvements

**1. Bluetooth permissions (Android)**

To simplify integration, as of this release, you can use the SDK to enable Android users to use Bluetooth normally without adding the `BLUETOOTH_CONNECT`permission.

**2. Relaying media streams across channels**

This release optimizes the `UpdateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED`(8), and you need to call the `UpdateChannelMediaRelay` method again.
- v4.1.0 and later: If the target channel update fails due to internal server reasons, the SDK retries the update until the target channel update is successful.

**3. Reconstructed AIAEC algorithm**

This release reconstructs the AEC algorithm based on the AI method. Compared with the traditional AEC algorithm, the new algorithm can preserve the complete, clear, and smooth near-end vocals under poor echo-to-signal conditions, significantly improving the system's echo cancellation and dual-talk performance. This gives users a more comfortable call and live-broadcast experience. AIAEC is suitable for conference calls, chats, karaoke, and other scenarios.

#### **Other improvements**

This release includes the following additional improvements:

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the `AUDIO_SCENARIO_MEETING` scenario.
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.

#### Issues fixed

This release fixed the following issues:

- All platforms：
  - The call `GetExtensionProperty` failed and returned an empty string.
  - Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.
  - Crashes occurred if you call the `RegisterAudioEncodedFrameObserver` method after failing to initialize  `RtcEngine`.

- Android：
  - After calling `SetCloudProxy` to set the cloud proxy, calling `JoinChannelEx` to join multiple channels failed.

  - In online meeting scenarios, the local user and the remote user occasionally could not hear each other after the local user was interrupted by a call.

- iOS：
  - Calling `StartAudioMixing` to play music files in the `ipod-library://item` path failed.

- macOS：
  - After starting and stopping the audio capture device test, there was no sound when the audio playback device was subsequently started.

#### API changes

**Added** 

- `EnableInEarMonitoring`
- `SetEarMonitoringAudioFrameParameters`
- `OnEarMonitoringAudioFrame`
- `SetInEarMonitoringVolume`
- `GetEarMonitoringAudioParams`
- `StartRecordingDeviceTest` (Android)
- `StopRecordingDeviceTest` (Android)
- `GetNetworkType`
- `SetRecordingDeviceVolume`  (Windows)
- `isAudioFilterable` in `ChannelMediaOptions` 
- `SetLoopbackDevice` 
- `GetLoopbackDevice`
- `FollowSystemLoopbackDevice`
- `SetZones`
- `SetPlayerAttenuation`
- `SetRemoteAudioAttenuation`
- `MuteRemoteAudioStream`
- `SpatialAudioParams`
- `SetHeadphoneEQPreset`
- `HEADPHONE_EQUALIZER_PRESET`
- `SetHeadphoneEQParameters`
- `LeaveChannelEx` [2/2]
- `MuteLocalAudioStreamEx`
- `MuteAllRemoteAudioStreamsEx`
- `StartRtmpStreamWithoutTranscodingEx`
- `StartRtmpStreamWithTranscodingEx`
- `UpdateRtmpTranscodingEx`
- `StopRtmpStreamEx`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelayEx`
- `PauseAllChannelMediaRelayEx`
- `ResumeAllChannelMediaRelayEx`
- `StopChannelMediaRelayEx`
- `newRoleOptions` in `OnClientRoleChanged` 
- `AdjustUserPlaybackSignalVolumeEx`
- `EnableAudioVolumeIndicationEx`
- `OnAudioDeviceStateChanged ` (Windows,macOS)
- `OnAudioDeviceVolumeChanged ` (Windows,macOS)
- `SetParameters` in `IRtcEngine` (Windows)

**Deprecated**

- `StartEchoTest` [2/3]
- `OnApiCallExecuted`. Use the callbacks triggered by specific methods instead.

**Deleted**

- Removes `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED`(8) in `OnChannelMediaRelayEvent callback`