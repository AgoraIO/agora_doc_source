---
title: Migration Guide from v2.0.8 to v2.3.2 (Windows)
platform: Windows
updatedAt: 2020-11-16 04:20:37
---
This page contains information on major API changes during release v2.0.x and v2.3.2 for Agora SDK for Windows.

## Important Changes

#### 1. Dynamic Key

The Dynamic key is improved and updated in v2.1.0. If you are using an Agora SDK version below v2.1.0 and wish to migrate to the latest version, read the following contents thoroughly before migrating.

**Major changes**

- Before v2.1.0, for each step that requires authentication, such as joining a channel and setting the user role, the user needs to provide an independent dynamic key;
- v2.1.0 introduces the Token, a turnkey solution that has access to all Agora services and privileges. You only need to pass the Token when joining a channel. If you want to renew authentication, call [`renewToken`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a8f25b5ff97e2a070a69102e379295739).
- In a generated Token, the field name `unixTs/Ts` (The authorized timestamp) is removed.

**Related API Reference**

| Feature                      | v2.0.2                                                       | v2.1.0 and Later                                             |
| ---------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Join a channel               | `public int joinChannel(const char* channelKey, const char* channel, const char* info, uid_t uid)` | `virtual int joinChannel(const char* token, const char* channelId, const char* info, uid_t uid) = 0;` |
| Set the client role          | `public int setClientRole(CLIENT_ROLE_TYPE role, const char* permissionKey);` | `virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;`      |
| Notify the Token has expired | `public virtual void onRequestChannelKey();`                 | `virtual void onRequestToken();`                             |
| Renew the Token              | `public int renewChannelKey(const char* channelKey);`        | `virtual int renewToken(const char* token) = 0;`             |

For more information on Token migration and use guide, see:

- [Token Migration Guide](https://docs.agora.io/en/Agora%20Platform/token_migration)
- [Use Security Keys](./token?platform=All%20Platforms)
- [Generate a Token](./token_server?platform=Server)

#### 2. New Video Encoder Configuration

To support scenarios with video rotation and enable better quality for the custom video source, v2.3.2 deprecates the [`setVideoProfile`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac8b16d2a4e67bd75231a76e06d2d85eb) method and uses the [`setVideoEncoderConfiguration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a9bcbdcee0b5c52f96b32baec1922cf2e) method instead to set the video encoding configurations. You can still use the [`setVideoProfile`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac8b16d2a4e67bd75231a76e06d2d85eb) method, but Agora recommends using the [`setVideoEncoderConfiguration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a9bcbdcee0b5c52f96b32baec1922cf2e) method to set the video profile. 

For more information, see the following documents:

- [Set the Video Profile](https://docs.agora.io/en/Video/videoProfile_web?platform=Web)
- [Rotate the Video](https://docs.agora.io/en/Interactive%20Broadcast/rotation_guide_android?platform=Windows)

#### 3. More Accurate Call Quality Statistics

v2.3.2 deprecates the [`onAudioQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a36ad42975f3545382de07875016fb7fa) callback and replaces it with the [`onRemoteAudioStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af8a59626a9265264fb4638e048091d3a) callback to improve the accuracy of the call quality statistics. The [`onRemoteAudioStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af8a59626a9265264fb4638e048091d3a) callback uses more comprehensive algorithm and is more closely linked to the real user experience. 

In addition, v2.3.2 optimizes the algorithm of the last mile network quality of the local user before the user joins a channel, and improves the accuracy of the [`onLastmileQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ac7e14d1a26eb35ef236a0662d28d2b33) and the [`onNetworkQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a80003ae8cce02039f3aa0e8ffad7deed) callbacks statistics.

#### 4. New Network Connection Policy

v2.3.2 adds the  [`getConnectionState`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a512b149d4dc249c04f9e30bd31767362) method and the  [`onConnectionStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af409b2e721d345a65a2c600cea2f5eb4) callback to get the current network connection state and reason for a connection state change, and deprecates the [`onConnectionInterrupted`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9927b5cd2a67c1f48f17b5ed2303f483) and [`onConnectionBanned`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a38e9d403ae4732dff71110b454149404) callbacks.

#### 5. Speaker Volume Indication

v2.2.0 improves the function of [`enableAudioVolumeIndication`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a59ae67333fbc61a7002a46c809e2ec4f). The method, once enabled, sends the audio volume indication of the speaker in its callback at set intervals, regardless of whether any one is speaking in the channel

## Major New Features

- Added the  [`enableLoopbackRecording`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a065f485fd23b8c24a593680a47d754aa) API to enable Local audio recoding.
- Added the  [`setLocalVoiceEqualization`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a3de79ba906e6b254b997eda4d395d052) and the  [`setLocalVoiceReverb`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aa00e903b1cc6f2752373afbe556ef456) APIs to enable voice equalization and reverberation respectively.
- Added the [`addInjectStreamUrl`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a42247db589b55d3cfa98d8e1be06d8e6) API to enble adding a voice or video stream HTTP/HTTPS URL address to a live broadcast.
- Added Restful APIs to enable checking online channel statistics including the status of the users in the channel and the channel list of a specific company.
- Added the following APIs to enable sound effects management and playing. Enable playing short-time sound effects like clapping and gunshots. You can play multiple audio effects at the same time, and preload the audio effect file for efficiency. Related APIs are listed as follows:
  - [`getEffectsVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aab2353ccbd0e09b224448c72fd381d19): Retrieves the volume of the audio effects.
  - [`setEffectsVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aa3041ef19bfe10ffc5a1130cda91ab7b): Sets the volume of the audio effects.
  - [`setVolumeofEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a71fac1633ea84c892879781bee56d001): Sets the volume of a specified audio effect.
  - [`playEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a26307c09cbbaecee3bd662294a935821): Plays a specified audio effect.
  - [`stopEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#ab0520529fe0ca4eb56d75ff4468e4a03): Stops playing a specified audio effect.
  - [`stopAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a7f742bd2262899a90f4a36205995419e): Stops playing all audio effects.
  - [`preloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a61e4eac3b78f2774ef1b22d69bd4e166): Preloads a specified audio effect file into the memory.
  - [`unloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#afd2cc4d59101cef1b5dc9296e604d047): Releases a specified preloaded audio effect from the memory.
  - [`pauseEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a75fc09bdd0bd8b2bfe9c47770eb1e928): Pauses a specified audio effect.
  - [`pauseAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a98ff58bdd2b8683bd27a1f75694641dc): Pauses all audio effects.
  - [`resumeEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#adae083a10afd4b316a2071ba8d01ff80): Resumes playing a specified audio effect.
  - [`resumeAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a66dd1578478dd3ca163768d1314cd50a): Resumes playing all audio effects.   
- Added a method to deploy the proxy at the server. Agora has provided a proxy package for enterprise users with corporate firewalls to deploy before accessing the services of Agora.
- Added the [`onRemoteVideoStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aac7b62b1307be124423008e45eb02f80) to get the remote video state.
- Added the [`addVideoWatermark`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a7db71d3de47227f7419202fde0875058) API and `watermark` of the [`setLiveTranscoding`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a0601e4671357dc1ec942cccc5a6a1dde)  API to enable adding a PNG file to the local or CDN broadcast as a watermark respectively.
- Added the [`setExternalVideoSource`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a6716908edc14317f2f6f14ee4b1c01b7) and the [`pushVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#ae064aedfdb6ac63a981ca77a6b315985) APIs to enable external video data (Push Mode).
- Added the [`setExternalAudioSink`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a08450bffffc578290d4a1317f2938638) and the [`pullAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#aaf43fc265eb4707bb59f1bf0cbe01940) APIs to enable external audio sink (Pull Mode).
- Added the [`adjustAudioMixingPlayoutVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a99ab2878e0c4fbf1be6970a2c545d085) and the  [`adjustAudioMixingPublishVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a8f8d2af4b4c7988934e152e3b281d734) APIs to enable independent audio mixing volume adjustments for local playback and remote publishing respectively.
- Added the following APIs to enable fallback options for a live broadcast under unreliable network conditions. Unreliable network conditions affect the overall quality of a live broadcast. The function automatically disables the video stream when the network conditions cannot support both audio and video. Related APIs are listed as follows:
  - [`setLocalPublishFallbackOption`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a0402734b50749081b20db3826f6f00ec): Sets the fallback option for the locally published video stream based on the network conditions.
  - [`setRemoteSubscribeFallbackOption`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a50e727c34b662de64c03b0479a7fe8e7): Sets the fallback option for the remotely subscribed stream based on the network conditions.
  - [`onLocalPublishFallbackToAudioOnly`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ace4279c4d87c23a1fecc3eb8e862a513): Occurs when the locally published media stream falls back to an audio-only stream due to poor network conditions or switches back to the video after the network conditions improve.
  - [`onRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7ee343146ad6e3f120bd04a7a6fdda74): Occurs when the remotely subscribed media stream falls back to audio-only due to poor network conditions or switches back to the video after the network conditions improve.
- Added the  [`onRemoteAudioTransportStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad79bcd56075fa9c9f907bb4a7462352d) and the  [`onRemoteVideoTransportStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a3b8fd883a31d4a504ac3cbd50b1c5d0f) callbacks to enable upstream and downstream statistics of each remote user/host.

