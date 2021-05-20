---
title: Release Notes
platform: Web
updatedAt: 2021-01-27 07:10:56
---
# Release Notes

This page provides the release notes for the Agora Web SDK.

## Overview

The Agora Web SDK (WebRTC) is a JavaScript library loaded by an HTML web page. The Agora Web SDK library uses APIs in the web browser to establish connections and control the communication and live broadcast services.

## Known Issues and Limitations

-   Compatibility: To enable interoperability between the Agora Native SDK and Agora Web SDK, use the Agora Native SDK v1.12 or later.
-   The Agora Web SDK supports video profiles up to 1080p resolutions if the client has a true HD camera installed. However, the maximum resolution is limited by the camera device capabilities.
-   The Agora Web SDK does not provide the following functionalities available in the Agora Native SDK: Quality indicators, testing services, providing feedback ratings for sessions, recording, and logging.
-   The Agora Web SDK does not support IPv6.
-   The Agora Web SDK does not support code obfuscation.


For more issues, see [Web FAQs](https://docs.agora.io/en/2.3.1/faq/faq/web)

## v2.4.0 (Released August 24, 2018)

### New Functions

#### 1. Support for Token

See [Security Keys](/en/Agora%20Platform/token) for details.

#### 2. Support for Audio Processing

Added support for AEC (Acoustic Echo Cancellation) and ANS (Automatic Noise Suppression) in the audioProcessing property, see descriptions of <code>client.createStream</code> in [Agora Web SDK API](/en/API%20Reference/web).

#### 3. Support for Audio/Video Pre-processing

Added the <code>audioSource</code> and <code>videoSource</code> properties in the <code>client.createStream</code> method, which specify the audio and video tracks. Therefore, you can process the audio/video before creating a stream. See [Set the audioSource and videoSource properties](/en/API%20Reference/web) for details.

#### 4. Support for Setting Audio Profile

Added the <code>stream.setAudioProfile</code> method, which provides various audio profile options (sample rate, mono or stereo, and encoding rate), see [Set the Audio Profile（setAudioProfile）](/en/API%20Reference/web) for details.

#### 5. Support for Setting Stream Fallback

Added the <code>client.setStreamFallbackOption</code> method, which allows the receiver to automatically subscribe to the low-video stream or only the audio stream under poor network conditions, see [Set Stream Fallback Option (setStreamFallbackOption)](/en/API%20Reference/web) for details.

#### 6. Added Delay-related Statistics

The callback function of <code>stream.getStats</code> added delay-related statistics, including the delays from the publisher to SD-RTN, from SD-RTN to the subscriber, from end to end, and from sending to playing audio/video. See [Get the Connection Status](/en/API%20Reference/web) for details.

#### 7. Support for Log Upload

Added the <code>AgoraRTC.Logger.enableLogUplaod</code> method, which supports uploading the SDK’s log to Agora’s server, see [Enable Log Upload (Logger.enableLogUpload)](/en/API%20Reference/web) for details.

### Issues Fixed

-   The settings of <code>cameraId</code> and <code>microphoneId</code> would not take effect unless <code>stream.setVideoProfile</code> is called.
-   Calling <code>setScreenProfile</code> would not take effect on the Firefox browser.
-   An error occurs if both audio and screen are enabled in the <code>client.createStream</code> method.
-   The <code>microphoneId</code> setting would not take effect in screen sharing.
-   The <code>audioProcessing</code> settings would not take effect.


## v2.3.1 (Released June 7, 2018)

### Issues Fixed

-   Fixed the issue of occasional publishing failures on browsers that installed the Adblock Plus extension.
-   Fixed the issue of invalid IP jumps.


## v2.3.0 (Released June 4, 2018)

### New Functions

#### 1. New Session Mode

To increase the applicable scenarios and improve its interoperability with the Agora Native SDK, the <code>mode</code> and <code>codec</code> parameters are added in the <code>createClient</code> method, in which <code>mode</code> includes <code>rtc</code> and <code>live</code>, while <code>codec</code> includes <code>vp8</code> and <code>h264</code>. See the descriptions on <code>createClient</code> in [Agora Web SDK API](/en/API%20Reference/web) for details.

#### 2. Support for Audio Gain Control

To meet the customers’ needs for audio control during a communication or live broadcast session, the <code>audioProcessing</code> parameter is added in the <code>createStream</code> method. For details, see the descriptions on <code>createStream</code> in [Agora Web SDK API](/en/API%20Reference/web).

#### 3. Support for Proxy on the Web Side

To enable enterprises with a company firewall to access the Agora’s services, <code>setProxyServer</code> and <code>setTurnServer</code> methods are added. By calling these two methods, users can bypass the firewall and send the signaling messages and media data directly to the Agora SD-RTN through the servers. Users need to deploy the Nginx and TURN Server before using this function and calling the methods before joining the channel. For more information on how the proxy works, deploy steps and APIs, see [Advanced: Deploying the Enterprise Proxy](/en/Quickstart%20Guide/proxy_web).

#### 4. Support for Encryption

Encryption was supported to enhance security for communication or live broadcast. Users need to set the encryption mode and password before joining the channel to use this function. For more information, seen descriptions on <code>setEncryptionSecret</code> and <code>setEncryptionMode</code> in [Agora Web SDK API](/en/API%20Reference/web).

### Issues Fixed

In the case of p2plost, the SDK stops reconnecting to the server after one or several reconnections.

## v2.2 (Released April 16, 2018)

### New Functions

#### 1. Get the version information.

Supported getting the version of the current Web SDK. See the description for <code>version</code> in [Agora Web SDK API](/en/API%20Reference/live_video_web).

#### 2. Set the low-stream parameter.

Added an interface to set the low-stream parameter. See the description for <code>setLowStreamParameter</code> in [Agora Web SDK API](/en/API%20Reference/live_video_web).

#### 3. Support screen-sharing for the Firefox browser.

Added the support for the Firefox browser to share the screen, by adding a <code>mediaSource</code> property in the <code>createStream</code> method. See the descriptions for <code>mediaSource</code> in <code>createStream</code> in [Agora Web SDK API](/en/API%20Reference/live_video_web).

#### 4. Support the QQ browser.

Added the support for the QQ browser.

### Issues Fixed

Fixed the issue of no voice in the voice-only mode when an iOS device joins a session using the Safari browser.

## v2.1.1 (Released March 19, 2018)

Fixed the issue of not able to view the remote video when using the Web SDK on the Firefox browser v59.01 on macOS.

## v2.1.0 (Released March 7, 2018)

### New Functions

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>Function</th>
<th>Description</th>
</tr>
<tr><td>Quality Detection</td>
<td>Added callbacks to return the quality of the compatibility, microphone, camera, and network status.</td>
</tr>
<tr><td>Simulcast</td>
<td>Added the function of controlling which stream type to send or receive; in high stream or low stream.</td>
</tr>
<tr><td>User-ban Notification</td>
<td>Added an interface to notify a user of being banned from the channel.</td>
</tr>
<tr><td>RTMP Stream-Pushing</td>
<td>Added an interface to support RTMP stream-pushing.</td>
</tr>
<tr><td>Log Output Level Settings</td>
<td>Added an interface to set the log output level.</td>
</tr>
<tr><td>Mute/Unmute</td>
<td>Added an interface to mute or unmute the users in a call or an interactive broadcast.</td>
</tr>
</tbody>
</table>



### Improvements

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>Improvement</th>
<th>Description</th>
</tr>
<tr><td>P2P Connection Establishment</td>
<td>Shortened the time from 1.8 s to 500 ms.</td>
</tr>
<tr><td>Packet Loss</td>
<td>Optimized the FEC packet loss and ULP FEC packet loss.</td>
</tr>
</tbody>
</table>



### Issues Fixed

-   Fixed the 90-degree video rotation on Safari
-   Fixed the issue of not seeing the remote video when using the Web SDK on the Firefox browser v59.01 on macOS


## v.2.0 (Released November 21, 2017)

### New Functions

-   Added the check browser compatibility function before calling <code>CreateClient</code>, to check the compatibility between the system and the browser.
-   Added the callback to notify the application that the user has granted or denied access to the camera or microphone.
-   Added the video self-adjustment function, by automatically lowering the resolution or frame rate until the video profile matches the input hardware’s capability.


### Issues Fixed

-   Volume issue with iOS SDK interop.
-   Disconnection issue on Google Chrome caused by prolonged communication.
-   Abnormal screen display on Android devices when the device switches between its front and rear cameras.
-   Abnormal screen display on Android devices when one of the Android devices in the session leaves the channel.
-   No camera-access-grant notification on Google Chrome when it joins the channel without access to the camera.
-   No image on the iOS Safari web browser after the user has returned from another application.


## v1.14 (Released October 20, 2017)

Added the screen sharing function by modifying the screen parameter and adding the parameter in the <code>createStream</code> API.

## v1.13 (Released September 4, 2017)

### New Functions

-   Supported CDN Live with the <code>configPublisher</code> API.
-   Supported Google Chrome for Android.


## v1.12 (Released July 25, 2017)

-   Added and Updated APIs:

    <table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>API</strong></th>
<th>Type</strong></th>
<th>Description</strong></th>
</tr>
<tr><td><code>createClient</code></td>
<td>New</td>
<td>Creates a client object for web-only or web interop depending on which mode you set</td>
</tr>
<tr><td><code>renewChannelKey</code></td>
<td>New</td>
<td>Updates a Channel Key when the previous Channel Key is expired</td>
</tr>
<tr><td><code>active-speaker</code></td>
<td>New</td>
<td>Indicates who is the active speaker in the current channel</td>
</tr>
<tr><td><code>setRemoteVideoStreamType</code></td>
<td>New</td>
<td>Specifies the video stream type of the remote user to be received by the local when the remote user sends dual streams</td>
</tr>
<tr><td><code>setVideoProfile</code></td>
<td>Updated</td>
<td>Sets the video profile, and the default value is <em>480p_1</em></td>
</tr>
<tr><td><code>init</code></td>
<td>Updated</td>
<td>Initializes the client object</td>
</tr>
<tr><td><code>join</code></td>
<td>Updated</td>
<td>Allows the user to join an Agora channel</td>
</tr>
</tbody>
</table>

-   Updated the error codes.


## v1.8.1 (Released March 16, 2017)

Fixed the incompatibility issue on Google Chrome v57.

## v1.8 (Released December 26, 2016)

The Agora Web SDK supports both communication and live broadcast scenarios starting from v1.8. This release is a beta version.



