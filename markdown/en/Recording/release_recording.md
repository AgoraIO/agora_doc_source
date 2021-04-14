---
title: Release Notes for the Recording SDK
platform: Linux
updatedAt: 2021-01-13 07:35:40
---
## Overview

The Agora Recording SDK records communication and live broadcast contents based on the Agora Native SDK.

### Compatibility

This component package is compatible with the following SDKs:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>SDK</th>
<th>Description</th>
</tr>
<tr><td>The Agora Native SDK</td>
<td>The Agora Recording SDK is compatible with the Agora Native SDK v1.7.0 or later. If any user in the channel uses the Agora SDK v1.6, the whole channel will not be able to record.</td>
</tr>
<tr><td>The Agora Web SDK</td>
<td>The Recording SDK is compatible with the Agora Web SDK v1.12.0 or later.</td>
</tr>
</tbody>
</table>



### Known Issues and Limitation

-   When you record using an Android client, the image is turned upside down when you switch from a front-facing camera to a rear one.
-   If the user calls <code>leaveChannel</code> in the channel to stop recording, the recording file ends with a period of silence determined by the <code>idleLimitSec</code> field set for the configuration when calling <code>joinChannel</code>.
-   The recorded voice or video files are not encrypted. To be compliant with HIPPA, encrypt the disk with a disk encryption tool, such as cryptsetup.


> Agora Recording SDK supports both Java and C++ from v2.2.0.

## v2.3.3

The version 2.3.3 was released on March 29, 2019. See below for new features and issues fixed.

### New Features

#### 1. Support for monitoring the network connection status

Adds the following callbacks to inform the app of the connection between the recording SDK and Agora's edge server:

- `onConnectionLost` : Informs that the SDK loses connection to the server.
- `onConnectionInterrupted` : Informs that the connection between the SDK and the server is interrupted.

#### 2. Inform the reception of the first frame 

Adds the following callbacks to inform the app of the local reception of the first remote audio or video frame:

- `onFirstRemoteAudioFrame` : Informs that the first remote audio frame is received.
- `onFirstRemoteVideoDecoded` : Informs that the first remote video frame is decoded. 

#### 3. Get the receiving stream state

Adds the `onReceivingStreamStatusChanged` callback to get the status of receiving the audio or video stream changes.

#### 4. Get the volum indication

Adds the `onAudioVolumeIndication` callback to get the list of users who are speaking and their volumes. 

### Issues Fixed

- Failed to run the transcoding script when the recording SDK exiting the channel and then entering the channel again in manual mode.
- Occasional crashes when calling the illegal `mixedVideoAudio` parameter.
- Freeze frames when recording in HD.
- Invalid setting for recording video frame rate.
- Occasional crashes when compiling the recording Java sample code in manual mode.
- Failed to run the transcoding command `-f . -m 3`.


## v2.3.0

The version 2.3.0 was released on January 14, 2019. See below for new features and improvements . 

> The billing of Recording SDK v2.3.0 or later is seperated from that of Agora Voice Call/Voice Interactive Broadcast SDK and Agora Video Call/Video Interactive Broadcast SDK. Contact [sales@agora.io](mailto:sales@agora.io) to get more details.

### New Features

#### 1. Support for Stereo Audio in Composite Recording Mode

Support high audio quality (sampling rate of 48 kHz, stereo and a bitrate of up to 192 Kbps) in the composite recording mode.

> Stereo is not applicable to raw data. 

`audio profile` can be set as `0` or `1` :

- Individual recording (file mode)
  - By default or set `audio profile=0`: the sampling rate 48 KHz, same number of sound channels as the orignal audio, and adaptive bitrate.
- Individual recording (raw data)
  - The sampling rate is fixed to 48 KHz and the number of sound channels is the same as the original audio.
    - PCM: The bitrate may change.
    - AAC: The bitrate is the same as in the file mode.
- Composite recording (file mode)  
  - `audio profile=0`: Sampleing rate 48 KHz, mono, bitrate 48 Kbps
  - `audio profile=1`: Sampleing rate 48 KHz, mono, bitrate 128 Kbps
  - `audio profile=2`: Sampleing rate 48 KHz, stereo, bitrate 192 Kbps
- Composite recording (raw data)  
  - Fixed sampling rate 48 KHz, mono

#### 2. Support for Web Video Players 

The video files transcoded in real time or transcoded by the transcoding script can be played by browsers on Android, iOS/macOS, and Windows. Below is a list of compatible browsers on each platform.

<table>
  <tr>
    <th>Platform</th>
    <th>Chrome </th>
    <th>Safari</th>
  </tr>
  <tr>
    <td>Android </td>
    <td>Chrome 49+</td>
    <td>N/A</td>
  </tr>
  <tr>
    <td>iOS</td>
    <td>✘</td>
    <td>Safari 9+</td>
  </tr>
  <tr>
    <td>macOS 10+</td>
    <td>Chrome 47+</td>
    <td>Safari 11+</td>
  </tr>
  <tr>
    <td>Windows</td>
    <td>Chrome 49+</td>
    <td>N/A</td>
  </tr>
</table>

#### 3. Support for Customizing Background Image in Composite Recording Mode 

- Users can add a backgroud image while recording audio in the Composite Recording Mode;

- Use a customized image for the user who do not have video while recording video in the Composite Recording Mode.

> This function is not applicable to raw data and screenshot.

#### 4. Added Two Pre-defined Layout Templates to the Sample Code

To make the sample code in the Recoridng SDK easier to use, two pre-defined layout templates for composite recording are provided:

##### Best Fit (bestFit)

The default layout. Supports up to 17 video streams.

This layout automatically scales according to the number of videos. The number of columns and rows of varies depending on the number of videos. For example:

![](https://web-cdn.agora.io/docs-files/1542680053900)

##### Vertiacal Presentation （verticalPresentation）

A specified uid displays the large video on the left of the screen, while the others are arranged vertically on the right with small videos. At most two columns with 8 videos each column are supported. 

For example:

![](https://web-cdn.agora.io/docs-files/1542680070362)

#### 5. Screenshot in Composite Recording Mode

Capture the screen of every single user while recording video in the Composite Recording Mode. The recording and the screen capturing use the same video stream.

#### 6. Speaker Detection

The new callback `onActiveSpeaker` returns the UID of the active speaker in the channel.

This function is disabled by default and can be enabled by setting the parameter of `audioIndicationInterval` in `RecordingConfig`. The Recording SDK will return `onActiveSpeaker` at the set interval.

### Improvements

- Improved audio and video synchronization in the Individual Recording Mode;
- Supported automatic rotation of recorded videos which are not transcoded in real time in the Individual Recording Mode;
- Changed the idle behavior in the manual mode:
     - For the versions earlier than v2.3.0, in the Manually Mode, the idle mechanism takes effect immediately after joining the channel, which might cause the recording SDK to exit the channel.
     - For v2.3.0 or later versions,  the idle mechanism does not take effect until `startService` is called.
- Optimized the log levels and split some major logs in INFO into NOTICE, WARN, and ERROR.
- Optimized the naming of recording directory to ensure the uniqueness of each folder.

## v2.2.3 

The version 2.2.3 was released on October 18, 2018. See below for issues fixed.

### Issues Fixed

-   Coredump loss caused by .backtrace.
-   Fixed system crash caused by Java jni. and optimized stability.
-   Bug of the transcoding script in manully mode. 
-   The recording video file was split into two files after a web client joined the channel.
-   Occasional system crash caused by the issue that the sub thread was still active after the main thread was released.

## v2.2.2 

The version 2.2.2 was released on August 1, 2018. See below for new features, improvements, and issues fixed.

### Improvements

-   The naming of the screenshots will be `uidYmdHMSms.jpg` instead of `uidYmdHMS.jpg`.
-   The transcoding script supports autorotation.
-   The structure of the Java folder is modified.


### Issues Fixed

-   webm recording time abnormality.
-   Memory leak.
-   Multi-party intercommunication issue.
-   H.264 parser issue.
-   Audio and video out of sync.


## v2.2.1

The version 2.2.1 was released on June  5, 2018. See below for new features, improvements, and issues fixed.

### Improvements

-   Improved the performance of the communication mode. The number of recording channels that a system supports with the same performance has increased by 150%.
-   Improved the efficiency to find the port.
-   The time to find the port is no longer part of the idle time.


### Issues Fixed

Port conflicts when the search for the port takes too long and exceeds the idle time. As a result, the port is not connected.


## v2.2.0

The version 2.2.0 was released on May 4, 2018. See below for issues fixed.

### New Features

> The package you downloaded supports both Java and C++.

### Issues Fixed

-   Fixed the issue of oversized logs.
-   Fixed abnormal issues that occurred when recording fast-forward videos.
-   Fixed intermittent failures.
-   Performance improvements.
-   Fixed some crash issues.


## v2.1.0

The version 2.1.0 was released on March 7, 2018. See below for new features, improvements and issues fixed.


### New Features

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><th>Function</th>
<th>Description</th>
</tr>
<tr><td>Recording Mode</td>
<td>Supported selecting auto or manual mode when joining a channel to flexibly control the recording.</td>
</tr>
<tr><td>Control Recording</td>
<td>Added interfaces to unbind the operation of joining a channel and recording. If the auto recording mode is used, the recording starts when a user joins the channel. If the manual recording mode is used, you can control when to start and stop the recording.</td>
</tr>
<tr><td>Mix Raw Audio</td>
<td>Supported the function of mixing raw audio data.</td>
</tr>
<tr><td>Java Recording API</td>
<td>Supported Java APIs for recording.</td>
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
<tr><td>Transcoding Script</td>
<td>Supported the setting of the transcoding frame rate and resolution, either in picture-in-picture or single-stream mode.</td>
</tr>
</tbody>
</table>



### Issues Fixed

-   Occasional recording file transcoding failures.
-   Occasionally the video screen turns upside down.
-   Occasional abnormal audio during recording.


## v2.0

The version 2.0 was released on November 21, 2017. 

For 2.0 Beta documentation, see [2.0 Document Center](https://docs.agora.io/en/2.0/addons/Recording/Quickstart/recording?platform=All%20Platforms)

-   Optimized the raw data to support various formats:
    -   Modified the <code>decodeAudio</code> and <code>decodeVideo</code> parameters, and added the <code>VideoJpgFrame</code> struct. For details, see [Recording API Beta](/en/API%20Reference/recording_java)
    -   Modified the <code>getAudioFrame</code> and <code>getVideoFrame</code> parameters. For details, see [Recording Quickstart](/en/API%20Reference/recording_java-1).
-   Added the <code>captureInterval</code> parameter to set the time interval of the captured screenshots. For details, see [Recording API Beta](/en/API%20Reference/recording_java) and [Recording Quickstart](/en/API%20Reference/recording_java-1).
-   Added the <code>streamType</code> parameter to support different video stream types. For details, see [Recording API Beta](/en/API%20Reference/recording_java) and [Recording Quickstart](/en/API%20Reference/recording_java-1).
-   Added the <code>isVideoOnly</code> parameter. For details, see [Recording API Beta](/en/API%20Reference/recording_java) and [Recording Quickstart](/en/API%20Reference/recording_java-1).
-   The transcoding scripts, once used, will generate a convert.log file under the same path as the voice/video file. For details, see [How to Record](https://docs.agora.io/en/2.0/addons/Recording/API%20Reference/recording?platform=All%20Platforms).
-   Added the video rotating information in `UID_HHMMSSMS.txt`. For details, see [How to Record](https://docs.agora.io/en/2.0/addons/Recording/API%20Reference/recording?platform=All%20Platforms).


## v1.3 

The version 1.3 was released on October 20, 2017. See below for new features.

### New Features:

-   Added the mixing of the audio and video recording functions by adding the <code>mixedVideoAudio</code> and <code>cfgFilePath</code> parameters in the <code>joinChannel</code> method.
-   Added the function of merging the audio and video file of the same uid as one, see [Play the Recording Files](https://docs.agora.io/en/1.14/addons/Recording/tutorial/recording?platform=All%20Platforms).
-   Added the <code>getProperties</code> method to get the recording path immediately after recording is started before joining any channel.
-   Modified the <code>onError</code> and <code>onLeaveChannel</code> callback functions.


## v1.2

The version 1.2  was released on August 21, 2017. See below for new features.

### New Features:

-   Supported the function of getting the audio and video raw data.
-   Supported the function of detecting sexually explicit content.
-   Provided a log file, `recordingsys.log`, to check for failures.
-   Supported the recording channel timestamp, that is, the first user who starts recording in the channel.


## v1.1

The version 1.1  was released on July 25, 2017. See below for new features and issues fixed.

### New Features:

- Added recording at the web client side.
- Added the real-time video mixing function.
- Added a set of callback functions.
- Modified the file format after transcoding.
- Enabled the configure UDP port function.

### Issues Fixed:

- Wrong timestamps.
- Transcoding failure.
- Unable to playback VLC files.


## v1.0.1

The version 1.0.1  was released on June 27, 2017. See below for issues fixed.

Fixed the crash when you set the channel profile of the recording as live broadcast.

## v1.0.0

The version 1.0.0  was released on June 15, 2017. 

This is the first release of the Recording SDK with the following functions:

- Communication and live broadcast scenarios.
- Recording the voice and video of all users in a channel.
- Recording the voice and video of all users in multiple channels simultaneously.
- Recording the voice of all users in a channel or in multiple channels simultaneously.
- Recording an encrypted channel if the application has integrated the Agora built-in encryption.