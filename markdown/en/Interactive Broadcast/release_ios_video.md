---
title: Release Notes
platform: iOS
updatedAt: 2021-03-29 03:53:54
---
# Release Notes

This page provides the release notes for the Agora Full SDK for iOS.

## Overview

The Full SDK supports the following scenarios:

-   Voice/Video Communication
-   Live Voice/Video Broadcast

## v2.3.1 (Released Sept 26th, 2018)

### New Features

#### Disables/Re-enables the Local Audio Function

When a user joins a channel, its audio function is enabled by default.
To meet the customers' needs to receive audio streams without sending out any after joining a channel, this release adds the `enableLocalAudio` method to disable or re-enable the local audio function.
Once the local audio function is disabled or re-enabled, the SDK returns the `didMicrophoneEnabled` callback, and the local audio capturing stops.
This method does not affect receiving or playing the remote audio streams.

The difference between this method and `muteLocalAudioStream` is that the former does not capture or send any audio stream, while the latter captuers but does not send audio streams.


### Improvements

- Reduced the SDK's package size.
- Reduced the CPU consumption in the audio communication profile on some low-end iOS devices.


### Issues Fixed

- Occasional crashes on some iOS devices when using customized video source functions.
- Occasional crashes on some iOS devices when using customized remote renderer functions.
- Occasional crashes when switching between the front and rear camera.
- Occasional in the live broadcast profile: The App freezes and the user cannot leave channel a while after switching between the front and rear cameras on some iOS devices.
- Occasional in the live broadcast profile: it takes two taps for a successful focus on some iOS devices.
- In the communication profile: If one end disables the video and re-enables it during a one-to-one call, it takes a long while for the other end to see the image.
- In the live broadcast profile: Delay at the client due to wrong statistics.
- The timestamp in the captured raw video frames does not refresh with the frame.

## v2.3.0 (Released Aug 31st, 2018)

### Before Reading

-   To support scenarios with video rotation and enable better quality for the custom video source, this release deprecates the [setVideoProfile](/en/API%20Reference/live_video_ios) interface and uses [setVideoEncoderConfiguration](/en/API%20Reference/live_video_ios) instead to set the video encoding configurations. You can still use [setVideoProfile](/en/API%20Reference/live_video_ios) but Agora recommends using [setVideoEncoderConfiguration](/en/API%20Reference/live_video_ios) to set the video profile because:
    -   During a live broadcast, users can set the video orientation mode as adaptive, under which the SDK can transfer rotated video frames without cropping them, thus avoiding the “big headshot” or blurry images at the Player.
    -   In scenarios involving external video sources, the SDK adjusts the width and height of the output video frames based on the inputting video frames, avoiding unnecessary cropping and thereby rendering more image frames at the Player.
-   An `Accelerate.framework` library was added to the SDK in v2.3.0, which is capable of large-scale mathematical computations and image calculations, optimized for high performance.
-   The security keys are improved and updated in v2.1.0. If you are using an Agora SDK version earlier than v2.1.0 and wish to migrate to the latest version, see [Token Migration Guide](/en/Agora%20Platform/token_migration).


### New Features

#### 1. Fallback options for a live broadcast under unreliable network conditions.

The audio and video quality of a live broadcast will deteriorate under unreliable network conditions. To improve the efficiency of a live broadcast, the [setLocalPublishFallbackOption](/en/API%20Reference/live_video_ios) and [setRemoteSubscribFallbackOption](/en/API%20Reference/live_video_ios) interfaces are added. These interfaces allow the SDK to automatically disable the video stream when the network condition cannot support both audio and video, and enable the video when the network conditions improve. [didLocalPublishFallbackToAudioOnly](/en/API%20Reference/live_video_ios) or [didRemoteSubscribeFallbackToAudioOnly](/en/API%20Reference/live_video_ios) is triggered when the stream falls back to audio-only or when the stream switches back to the video.

#### 2. Notifies the user that the Token will expire in 30 seconds.

The SDK returns the [tokenPrivilegeWillExpire](/en/API%20Reference/live_video_ios) callback 30 seconds before a Token expires to notify the app to renew it. When this callback is received, you need to generate a new Token on your server and call [renewToken](/en/API%20Reference/live_video_ios) to pass the newly-generated Token to the SDK.

#### 3. Returns user-specific upstream and downstream statistics, including the bitrate, frame rate, packet loss rate and time delay

The [audioTransportStatsOfUid](/en/API%20Reference/live_video_ios) and [videoTransportStatsOfUid](/en/API%20Reference/live_video_ios) callbacks are added to provide user-specific upstream and downstream statistics, including the bitrate, frame rate, and packet loss rate. During a call or a live broadcast, these callbacks are triggered every two seconds after the user receives audio/video packets from a remote user. The callbacks include the user ID, audio bitrate at the receiver, packet loss rate, and time delay (ms).

#### 4. Sets the SDK’s Control over an Audio Session

The SDK and app both have control over the audio session. However, the app may restrict the SDK’s control over an audio session and allow another app or a third-party component to control it by using the [setAudioSessionOperationRestriction](/en/API%20Reference/live_video_ios) method. You can implement different levels of control by choosing the corresponding restriction. You can call this method before or after joining the channel.

#### 5. Sets the video encoder configurations

To support scenarios with video rotation and enable better quality for custom video source, this release deprecates the [setVideoProfile](/en/API%20Reference/live_video_ios) interface and uses [setVideoEncoderConfiguration](/en/API%20Reference/live_video_ios) instead to set the video encoding configurations. You can still use [setVideoProfile](/en/API%20Reference/live_video_ios) but Agora recommends using [setVideoEncoderConfiguration](/en/API%20Reference/live_video_ios) to set the video profile because:

-   During a live broadcast, users can set the video orientation mode as adaptive, under which the SDK can transfer rotated video frames without cropping them, thus avoiding the “big headshot” or blurry images at the Player.
-   In scenarios involving external video sources, the SDK adjusts the width and height of the output video frames on basis of the inputting video frames, avoiding unnecessary cropping and thereby rendering more image frames at the Player.


The <code>AgoraVideoEncoderConfiguration</code> class provides a set of configurable video parameters, including the dimension, frame rate, bitrate, and orientation. For more information on the API, see descriptions in [Set the Video Encoder Configuration](/en/API%20Reference/communication_ios_video).

#### 6. Adds support for background image settings in setLiveTranscoding

The backgroundImage parameter is added to the [setLiveTranscoding](/en/API%20Reference/live_video_ios) method allowing you to set the background image in the combined video of a live broadcast.

### Improvements

-   Improved the quality for one-on-one voice/video scenarios with optimized latency and smoothness, especially for areas like Southeast Asia, South America, Africa, and the Middle East.
-   Improved the audio encoder efficiency in a live broadcast to reduce user traffic while ensuring the call quality.
-   Improved the audio quality during a call or a live broadcast using the deep-learning algorithm.


### Issues Fixed

-   Increased memory usage when multiple delegated hosts broadcasted in the channel.
-   Occasional video renderer crashes when the app switches to the background on some iOS devices.
-   Occasional app crashes on some iOS devices.
-   The remote view does not display on some devices.
-   Occasional black screens on some iOS devices.
-   Occasional ghost images.
-   Occasional green line at the bottom of the video when a user switches from low stream to high stream in the communication mode.
-   Crashes after publishing streams from some iOS devices.
-   Occasional crashes on some iOS devices.
-   Crash when a user frequently mutes and resumes all sound effects on some iOS devices.
-   Excessive increase in memory usage associated with a host when he/she frequently joins and leaves a channel of multiple delegated hosts.
-   Occasional issue that the remote user cannot hear the host when the host switches to AUDIENCE and then back to BROADCASTER.
-   Occasional issue that the settings to the background image of live transcoding do not take effect.
-   Occasional issue that some devices have the video height and width swapped in communication mode.
-   Occasional failure to respond to the destroy method after a user enables the video and joins a channel.
-   Occasional issue on some iOS devices that a user fails to hear any sound after returning to the channel from a system phone call.
-   The audience cannot adjust the channel volume on some special occasions.
-   Occasional crashes when a user frequently joins and leaves the channel.
-   Occasional crashes when frequently setting the video encoder profile on some iOS devices.
-   Occasional issue on iOS devices that videos from a remote user in a communication channel cannot be seen.
-   Occasional failure to capture video of the delegated host when the hosts and the audience frequently change roles.
-   Occasional issue on some iOS devices that a Web user can subscribe to the low video stream even when the iOS device does not have the dual-stream mode enabled.
-   Occasional crashes when calling the <code>setCameraFocusPositionInPreview</code> method on some devices.
-   Occasional crashes when one of the two broadcasters mutes or disables the local audio while playing the background music.
-   Occasional crashes on the iOS device when the device interoperates with the web and when a Web user frequently joins and leaves a channel.
-   A user cannot join a communication channel after frequently changing his/her video encoder profiles.
-   Occasional crashes on some devices when preloading the sound effects.
-   Video resolution inconsistency between the encoder end and the decoder end in the live broadcast mode.
-   Occasional video freeze in the communication or live broadcast mode.
-   Occasional crashes when calling the <code>muteRemoteVideoStream</code> method after joining the channel.
-   Occasional issue that some iOS devices can still receive the video fallback-specific callbacks even when the video fallback option is not enabled.
-   Incorrect video orientation on some iOS devices when setting the video profile of an external video source during a live broadcast.
-   An iOS issue that the bitrates cannot reach the target values when manually setting the video profile.
-   Occasional failures to interoperate between an iOS and a macOS device.
-   Occasional crashes on some iOS devices when a user leaves the live broadcast channel while playing music using a third-party application.
-   Occasional crashes on some iOS devices when leaving the channel.
-   An iOS issue that when a host has injected a stream to a broadcast channel other hosts can still inject a second stream to the channel.
-   Occasional crashes on some iOS devices when the user frequently turns on and off the camera.
-   Occasional video freezes when switching from multiple hosts to one single host.
-   Occasional interoperability failures between the SIP devices and the SDK.
-   Occasional echoes when using a specific audio card.
-   Occasional video delay on some iOS devices.
-   The video window size jumps from small to big on some iOS devices.
-   Image blurs on some iOS devices when the camera vibrates.
-   Failure to adjust the volume on some iOS devices.


### API Changes

To improve user experience, Agora has cleaned up and made the following changes to its APIs:

To avoid adding too many users with the same uid into the CDN publishing channel, the following APIs are added in v2.3.0:

-   [addUser](/en/API%20Reference/live_video_ios)
-   [removeUser](/en/API%20Reference/live_video_ios)


The following API methods are deleted and no longer supported in v2.3.0. Agora provides the Recording SDK for better recording services. For more information on the Recoding SDK, see [Release Notes for Agora Recording SDK](/en/Product%20Overview/release_recording).

-   <code>startRecordingService</code>
-   <code>stopRecordingService</code>
-   <code>refreshRecordingServiceStatus</code>


The following deprecated API methods are deleted and no longer supported from v2.3.0:

-   <code>switchView</code>
-   <code>setSpeakerphoneVolume</code>


### Backwards Compatibility Breaking Changes

None.

### Known Issues

None.

## v2.2.3 (Released Jul 5th, 2018)

### Read This First

The security keys are improved and updated in v2.1.0. If you are using an Agora SDK version earlier than v2.1.0 and wish to migrate to the latest version, see [Token Migration Guide](/en/Agora%20Platform/token_migration).

### Issues Fixed

-   Fixed occasional online statistics crashes.
-   Fixed occasional crashes during a live broadcast.
-   Fixed the excessive increase in the memory use when multiple delegated hosts broadcast in the channel.
-   Fixed the issue of failing to report the uid and volume of the speaker in a channel.
-   Fixed unsteady voice volume of the broadcaster in a live broadcast.
-   Fixed the issue of occasional video freeze after a view size change.


## v2.2.1 (Released May 30th, 2018)

### Issues Fixed

-   Fixed occasional crashes on some iOS devices.
-   Fixed occasional memory leak on some iOS devices.
-   Fixed occasional app crashes when the app starts audio mixing on some iOS devices.


## v2.2.0 (Released May 4th, 2018)

### New Functions

#### 1. Play the audio effect in the channel

Added a <code>publish</code> parameter in the <code>playEffect</code> method, to enable the remote user in the channel to hear the audio effect played locally. For details, see descriptions on <code>playEffect</code> in [Video Call API](/en/API%20Reference/communication_ios_video).

>  If your SDK is upgraded to v2.2 from a previous version, pay attention to the functional changes of this API.

#### 2. Deploy the proxy at the server

Agora has provided a proxy package for enterprise users with corporate firewalls to deploy before accessing the services of Agora. For details, see descriptions in [Advanced: Deploying the Enterprise Proxy](/en/Quickstart%20Guide/proxy).

#### 3. Get the remote video state

Added the <code>remoteVideoStateChangedOfUid</code> method to get the state of the remote video stream. For details, see the descriptions of <code>remoteVideoStateChangedOfUid</code> in [Video Call API](/en/API%20Reference/communication_ios_video).

#### 4. Add watermarks on the broadcasting video

Added the watermark function which enables users to add a PNG file to the local or CDN broadcast as a watermark. Added the <code>addVideoWatermark</code> and <code>clearVideoWatermarks</code> methods to add and delete watermarks in a local live-broadcast; the <code>watermark</code> parameter in the <code>LiveTranscording</code> interface enables watermarks in CDN broadcasts. For details, see the descriptions for <code>addVideoWatermark</code>, <code>clearVideoWatermarks</code>, and <code>LiveTranscoding</code> in [Interactive Broadcast API](/en/API%20Reference/live_video_ios).

### Improvements

#### 1. Audio volume indication

Improved the function of <code>enableAudioVolumeIndication</code>. The method, once enabled, sends the audio volume indication of the speaker in its callback at set intervals, regardless of whether any one is speaking in the channel.

#### 2. Network quality detection during a session

To meet the customers’ need for real-time network quality detection in the channel, the <code>onNetworkQuality</code> method has improved its data accuracy. For more information, see descriptions about <code>onNetworkQuality</code> in [Video Call API](/en/API%20Reference/communication_ios_video).

#### 3. Lastmile quality detection before joining a channel

To test if the customers’ network condition can support audio or video calls before joining the channel, <code>onLastmileQuality</code> has changed its detection base from a fixed bitrate to the bitrate set by the customer in <code>videoProfile</code> to improve data accuracy. When the network condition is unknown, this callback is still triggered at a time interval of 2 seconds. For more information, see descriptions about <code>onLastmileQuality</code> in [Video Call API](/en/API%20Reference/communication_ios_video).

#### 4. Audio Quality Enhancement

Improved the audio quality in scenarios that involve music playing. To achieve high-fidelity music play, you can set <code>Scenario：AgoraAudioScenarioGameStreaming = 3</code> in the <code>setAudioProfile</code> method. For details, see descriptions on <code>setAudioProfile</code> in [Video Call API](/en/API%20Reference/communication_ios_video).

#### 5. Bitcode support

Added support for Bitcode, which enables App optimization and thinning by the App Store. The package size of the Bitcode SDK is 2.5 times that of the normal one.

### Issues Fixed

-   Fixed occasional screen display abnormalities when the iOS device sets its video in the landscape mode.
-   Fixed occasional screen display abnormalities when a large number of the audience join host in the live-broadcast channel.
-   Fixed occasional echo issues caused by some iOS device.


## v2.1.3 (Released Apr 19th, 2018)

In v2.1.3, Agora has updated the bitrate values of the <code>setVideoProfile</code> method in the live-broadcast mode. The bitrate values in v2.1.3 stay consistent with those in v2.0. For more information, see <code>setVideoProfile</code> in [Interactive Broadcast API](/en/API%20Reference/live_video_ios).

### Issues Fixed

-   Block callbacks were occasionally not received if the delegate was not set.
-   NSAssertionHandler appeared in external links to the SDK.
-   Occasional recording failures on some phones when the user leaves the channel and turns on the in-built recording device.
-   In a live-broadcast mode, the iOS client could not see the video from the web client in Windows 10 even after iOS called <code>enableWebSdkInteroperability</code>.
-   Occasional resolution changes after UIImagePickerController was used to enable the system camera and switch back to live broadcast mode.
-   Occasional crashes during a communication or live-broadcast session.


### Improvements

Improved the performance of screen sharing by shortening the time interval between which users switch from screen sharing to normal communication or live-broadcast mode.

## v2.1.2 (Released Apr 2nd, 2018)

>  If you upgraded the SDK to v2.1.2 from a previous version, the live-broadcast video quality will be better than the communication video quality in the same resolutions, resulting in the live broadcasts using more bandwidth. If you experience abnormal bandwidth issues, contact [sales-us@agora.io](mailto:sales-us@agora.io).

### New Functions

Extended the <code>setVideoProfile</code> interface to enable users to manually set the resolution, frame rate, and bitrate of the video. See [Set the Video Profile (setVideoProfile)](/en/API%20Reference/communication_ios_video).

### Issues Fixed

-   Occasional crashes on iOS 11.
-   Video freeze in DTX + AAC mode.


## v2.1.1 (Released Mar 16th, 2018)

Agora has identified a critical bug in SDK v2.1. Upgrade to v2.1.1 if you are using Agora SDK v2.1.

## v2.1.0 (Released Mar 7th, 2018)

### New Functions

#### 1. Voice Optimization

Added a scenario for the game chat room to reduce the bandwidth and cancel the noise with the <code>setAudioProfile</code> method.

#### 2. Enhanced audio effect input from a built-in microphone

In an interactive broadcast, the host can enhance the local audio effects from the built-in microphone with the <code>setLocalVoiceEqualization</code> and <code>setLocalVoiceReverb</code> methods by implementing the voice equalization and reverberation effects.

#### 3. Online Statistics Query

Added Restful APIs to check the status of the users in the channel, the channel list of a specific company, and whether the user is an audience or a host:

-   For voice or video calls, see [Online Statistics Query API](/en/API%20Reference/dashboard_restful_communication).
-   For interactive broadcasts, see [Online Statistics Query API](/en/API%20Reference/dashboard_restful_live).


#### 4. 17-way Video

Added the support of 17-way video in interactive broadcasts, see:

-   [Basic: Starting a Live Video Broadcast](/en/Quickstart%20Guide/broadcast_video_ios)
-   [Advanced: 17-Way Live Video Broadcast](/en/Quickstart%20Guide/seventeen_people)


#### 5. Video Source Customization

Supported the default video-capturing features provided by the camera and the customized video source. See [AgoraVideoSourceProtocol](/en/API%20Reference/communication_ios_video).

#### 6. Renderer Customization

Supported the default functions provided by the renderers to display the local and remote videos to meet developers’ requirements. Agora provides a set of interfaces for customized renderers. See [AgoraVideoSinkProtocol](/en/API%20Reference/communication_ios_video).

#### 7. Injecting an External Video Stream

Added the function of injecting an external video stream to an ongoing live broadcast, see [Advanced: Injecting an External Stream to a Live Broadcast](/en/Quickstart%20Guide/inject_stream_ios).

#### 8. Interactive Broadcast Optimization

Added a set of APIs to enable faster integration with enhanced usability and function expandability. Developers upgrading to SDK v2.1.0 can choose both/either the legacy and/or new API(s), which are compatible:

-   [Lite Broadcast: API](/en/Solutions/live_plus_ios)
-   [Interactive Broadcast API](/en/API%20Reference/live_video_ios)


#### 9. Camera Focus Change

Added a <code>cameraFocusDidChanged</code> callback interface to indicate that the camera focus area has changed.

### Improvement

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>Improvement</th>
<th>Description</th>
</tr>
<tr><td>Video Freeze Rate</td>
<td>Reduced the video freeze rate in the audience mode and for specific devices.</td>
</tr>
<tr><td>Authentication</td>
<td>Supported a new authentication mechanism. Each legacy Dynamic Key (Channel Key) corresponds to a single privilege (for example, joining a channel), but each Token in the new authentication mechanism includes all the privileges (for example, joining a channel, hosting in, and stream-pushing).</td>
</tr>
<tr><td>Billing Optimization</td>
<td>Small video resolutions will be billed according to the voice-only mode, for example, 16 x 16.</td>
</tr>
<tr><td>API Naming Optimization</td>
<td>Modified a set of names for the API attributes and numeration values. See <a href="revisionhistory_video_ios">Document Revision History</a>.</td>
</tr>
</tbody>
</table>



### Issues Fixed

-   Occasional crashes.
-   Occasional blank screens.
-   Occasionally no voice after turning off the microphone.


## v2.0.2 (Released Dec 15th, 2017)

Fixed the FFmpeg symbol conflict.

## v2.0 (Released Dec 6th, 2017)

### New Functions

-   Added the <code>setRemoteVideoStreamType</code> and <code>enableDualStreamMode</code> methods in the communication scenario to support dual stream.
-   Updated the following callbacks for audio mixing and sound effects:

    <table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>Name</strong></th>
<th>Description</strong></th>
</tr>
<tr><td><code>rtcEngineMediaEngineDidAudioMixingFinish</code></td>
<td>Removed. Replaced by <code>rtcEngineLocalAudioMixingDidFinish<c/ode>.</td>
</tr>
<tr><td><code>rtcEngineDidAudioEffectFinish</code></td>
<td>Added. Notifies that the local audio effect has stopped.</td>
</tr>
<tr><td><code>rtcEngineRemoteAudioMixingDidStart</code></td>
<td>Added. Notifies that the remote user has started the audio mixing.</td>
</tr>
<tr><td><code>rtcEngineRemoteAudioMixingDidFinish</code></td>
<td>Added. Notifies that the remote user has stopped the audio mixing.</td>
</tr>
</tbody>
</table>



-   Added the camera management function in the communication and live broadcast scenarios by adding the following API methods:

    <table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th><strong>Name</strong></th>
<th><strong>Description</strong></th>
</tr>
<tr><td><code>isCameraZoomSupported</code></td>
<td>Checks whether the device supports camera zoom.</td>
</tr>
<tr><td><code>isCameraTorchSupported</code></td>
<td>Checks whether the device supports camera flash.</td>
</tr>
<tr><td><code>isCameraFocusPositionInReviewSupported</code></td>
<td>Checks whether the device supports camera manual focus.</td>
</tr>
<tr><td><code>isCameraAutoFocusFaceModeSupported</code></td>
<td>Checks whether the device supports auto-face focus.</td>
</tr>
<tr><td><code>setCameraZoomFactor</code></td>
<td>Sets the camera zoom ratio.</td>
</tr>
<tr><td><code>setCameraFocusPositionInPreview</code></td>
<td>Sets the position for manual focus and activates focusing.</td>
</tr>
<tr><td><code>setCameraTorchOn</code></td>
<td>Sets the device to turn on the camera flash.</td>
</tr>
<tr><td><code>setCameraAutoFocusFaceModeEnabled</code></td>
<td>Sets the device to start auto-face focusing.</td>
</tr>
</tbody>
</table>



-   Supported the external audio source in the communication and live broadcast scenarios by adding the following API methods:

    <table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>Name</strong></th>
<th>Description</strong></th>
</tr>
<tr><td><code>enableExternalAudioSourceWithSampleRate</code></td>
<td>Enables the external audio source.</td>
</tr>
<tr><td><code>disableExternalAudioSource</code></td>
<td>Disables the external audio source.</td>
</tr>
<tr><td><code>pushExternalAudioFrameRawData</code></td>
<td>Pushes the external audio frame.</td>
</tr>
</tbody>
</table>



-   Provided a set of RESTful APIs to ban a peer user from the server in the communication and live broadcast scenarios. Contact [sales-us@agora.io](mailto:sales-us@agora.io) to enable this function if required.


### Issues Fixed

Audio routing and Bluetooth issues.

## v1.14 (Released Oct. 20th, 2017)

### New Functions

-   Added the <code>setAudioProfile</code> method to set the audio parameters and scenarios.
-   Added the <code>setLocalVoicePitch</code> method to set the local voice pitch.
-   Live Broadcast: Added the <code>setInEarMonitoringVolume</code> method to adjust the volume of the in-ear monitor.


### Improvements

-   Optimized the audio at high bitrates.
-   Live Broadcast: The audience can view the host within one second in a single-stream mode (938 ms on average, and 734 ms when in good network conditions).
-   Added the ability to reduce the bandwidth.
    -   Before v1.14: If you muted the audio of a specific user, the network still sent the stream.
    -   Starting from v1.14: If you mute the audio of a specific user, the network will not send the stream of the user to reduce the bandwidth.
-   Accurate control over the bitrate:
    -   Before v1.14: Inaccurate control over the bitrate often caused huge fluctuations, leading to network congestion and higher rates of packet and frame loss. This affected the accuracy of the bandwidth estimation module, especially when the network was in poor conditions.
    -   Starting from v1.14: Accurate control over the bitrate prevents huge fluctuations avoiding network congestion and shortening the transmission latency.


### Issues Fixed:

Occasional crashes on iOS devices.

## v1.13.1 (Released Sept 28th, 2017)

-   Fixed the issue of not able to adjust the volume in the speaker mode on iOS 11 with iPhone 7 (or later).
-   Optimized the echo issue under certain circumstances.


## v1.13 (Released Sept 4th, 2017)

### New Functions

-   Added the function to dynamically enable and disable acquiring the sound card in a live broadcast.
-   Added the function to disable the audio playback.
-   Added the module map for the SDK, which means that bridging header files are not necessary for Swift projects.
-   Supported the profile configuration for stream-pushing on the client side.
-   Added the <code>didClientRoleChanged</code> method to indicate a user role change between the host and audience in a live broadcast.
-   Supported the push-stream failure callback on the server side.


### Improvements:

The video profile is controllable by the software codec.

### Issues Fixed:

Occasional crashes.

## v1.12 (Released July 25, 2017)

### New Functions:

-   Added the <code>injectStream</code> method to inject an RTMP stream into the current channel in live broadcasts.
-   Added the <code>aes-128-ecb</code> encryption mode in the <code>setEncryptionMode</code> method.
-   Added the <code>quality</code> parameter in the <code>startAudioRecording</code> method to set the recording audio quality.
-   Added a set of APIs to manage the audio effect.


### Improvements:

In the communication scenario, improved the 320 &times; 180 resolution profile:

-   Keep the video smooth under poor network and equipment conditions.
-   Enhance the image quality better than 180p under good network and equipment conditions.


### Issues Fixed:

Occasional crashes.



