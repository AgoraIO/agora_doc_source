---
title: Interactive Gaming API
platform: Android
updatedAt: 2019-02-11 11:54:46
---
The Interactive Gaming Audio Only API is composed of **Java Interface** and **C++ Interface**:

- Java Interface: Provides main methods and callback events of the SDK on the Android platform, including:

  * [Basic Methods](#rtcengine)
  * [Audio Effect Methods](#iaudioeffectmanager)
  * [Callback Methods](#rtcengineeventhandler)

- C++ Interface: Provides main methods and callback events of the SDK on the Windows platform, including:

  * [Basic Methods](#irtcengine)
  * [Parameter Methods](#rtcengineparameters)
  * [Audio Device Management Methods](#iaudiodevicemanager)
  * [Audio Device Collection Methods](#iaudiodevicecollection)
  * [Video Device Management Methods](#ivideodevicemanager)
  * [Video Device Collection Methods ](#ivideodevicecollection)
  * [Callback Methods](#irtcengineeventhandler)

## Java Interface

<a id = "rtcengine"></a>
### Basic Methods (RtcEngine)

**Developer suite: io.agora.rtc**

The RtcEngine interface class is the main interface class of the Agora Native SDK. Call the methods of this class to use all the functionalities of the SDK. Agora recommends calling the RtcEngine API methods in the same thread instead of in multiple threads. In previous versions, this class was named AgoraAudio, and is renamed to RtcEngine from version 1.0.

#### Create an RtcEngine Object (create)

```
public static synchronized RtcEngine create(Context context,
                                             String appId,
                                             IRtcEngineEventHandler handler);
```

This method creates an RtcEngine object.

The Agora Native SDK only supports one RtcEngine instance at a time, therefore the application should create one RtcEngine object only. Unless otherwise specified, all called methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling the interface methods in the same thread. Unless otherwise specified, the following rule applies to all APIs whose return values are integer types: A return value of 0 indicates that the call was successful, and a return value less than 0 indicates that the call failed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>context</td>
<td>The context of Android Activity.</td>
</tr>
<tr><td>appId</td>
<td>The App ID issued to the application developers by Agora. Apply for a new one from Agora if the key is missing in your kit.</td>
</tr>
<tr><td>handler</td>
<td>IRtcEngineEventHandler is an abstract class that provides default implementations. The SDK uses this class to report to the application on SDK runtime events.</td>
</tr>
<tr><td>Return Value</td>
<td>An RtcEngine object.</td>
</tr>
</tbody>
</table>

#### Set the Channel Profile (setChannelProfile)

```
public abstract int setChannelProfile(int profile);
```

This method configures the channel profile. The Agora RtcEngine needs to know what scenario the application is in to apply different methods for optimization.

The Agora Native SDK supports the following profiles:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Profile</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Communication</td>
<td>Default setting. This is used in one-on-one calls, where all users in the channel can talk freely.</td>
</tr>
<tr><td>Live Broadcast</td>
<td>Live Broadcast. Host and audience roles that can be set by calling setClientRole.  The host sends and receives voice, while the audience receives voice only with the sending function disabled.</td>
</tr>
<tr><td>Gaming</td>
<td>Gaming Mode. Any user in the channel can talk freely. This mode uses the codec with low-power consumption and low bitrate by default.</td>
</tr>
</tbody>
</table>


> -   Only one profile can be used at the same time in the same channel. If you want to switch to another profile, use `destroy` to destroy the current Engine and create a new one using `create` before calling this method to set the new channel profile.
> -   Make sure that different App IDs are used for different channel profiles.
> -   This method must be called and configured before a user joining a channel, because the channel profile cannot be configured when the channel is in use.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>profile</td>
<td><p>The channel profile. Choose one of the following:</p>
<div><ul>
<li>CHANNEL_PROFILE_COMMUNICATION = 0: Communication (default)</li>
<li>CHANNEL_PROFILE_LIVE_BROADCASTING = 1: Live Broadcast</li>
<li>CHANNEL_PROFILE_GAME = 2: Gaming</li>
</ul>
</div>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the User Role (setClientRole)

```
public abstract int setClientRole(int role);
```

In a live broadcast channel, this method allows you to:
* Set the user role as a host or an audience (default) before joining a channel;
* Switch the user role after joining a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>role</td>
<td><p>The user role in a live broadcast:</p>
<ul>
<li>CLIENT_ROLE_BROADCASTER = 1; Host</li>
<li>CLIENT_ROLE_AUDIENCE = 2; Audience(default)</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: The method is called successfully</li>
<li>&lt;0: Failed to call the method</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Enable the Audio Mode (enableAudio)

```
public abstract int enableAudio();
```

This method enables the audio mode. This function is enabled by default.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> This method sets to enable the internal engine, and still works after `leaveChannel` is called.

#### Disables/Re-enables the Local Audio Function (enableLocalAudio)

```
public abstract int enableLocalAudio(boolean enabled);
```

When an App joins a channel, the audio function is enabled by default. This method disables or re-enables the local audio function, that is, to stop or restart local audio capturing and handling.
This method does not affect receiving or playing the remote audio streams, and is applicable to scenarios where the user wants to receive the remote audio streams without sending any audio stream to other users in the channel.
The `onMicrophoneEnabled` callback function will be triggered once the local audio function is disabled or re-enabled.

> - Call this method after `joinChannel`.
> - This method is different from `muteLocalAudioStream`:
>   * `enableLocalAudio`: Disables/Re-enables the local audio capturing and handling.
>   * `muteLocalAudioStream`: Stops/Continues sending the local audio streams.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>enabled</td>
<td>
<ul>
<li>true: Re-enable the local audio function, that is, to start local audio capturing and handling.</li>
<li>false: Disable the local audio function, that is, to stop local audio capturing and handling.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Success</li>
<li>&lt;0: Failure</li>
</ul>
</td>
</tr>
</tbody>
</table>

#### Disable the Audio Mode (disableAudio)

```
public abstract int disableAudio();
```

This method disables the audio mode.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> This method sets to disable the internal engine, and still works after `leaveChannel` is called.

#### Set the Audio Profile (setAudioProfile)

```
public abstract int setAudioProfile(int profile, int scenario);
```

This method sets the audio parameters and application scenarios.


> This API is only valid when you call it before joining a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>profile</td>
<td><p>Sets the sampling rate, bitrate, encode mode, and the number of channels:</p>
<ul>
<li>AUDIO_PROFILE_SPEECH_STANDARD = 1: Specifies the sampling rate as 32 kHz, audio encoding, single channel, and bitrate up to 18 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_STANDARD = 2: Specifies the sampling rate as 48 kHz, music encoding, single channel, and bitrate up to 48 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_STANDARD_STEREO = 3: Specifies the sampling rate as 48 kHz, music encoding, dual-channel, and bitrate up to 56 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_HIGH_QUALITY = 4: Specifies the sampling rate as 48 kHz, music encoding, single channel, and bitrate up to 128 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO = 5: Specifies the sampling rate as 48 kHz, music encoding, dual-channel, and bitrate up to 192 kbit/s</li>
</ul>
</td>
</tr>
<tr><td>scenario</td>
<td><p>Sets the audio application scenarios:</p>
<ul>
<li>AUDIO_SCENARIO_DEFAULT = 0: default</li>
<li>AUDIO_SCENARIO_CHARROOM_ENTERTAINMENT = 1: Applicable to the entertainment scenario that supports voice during gameplay</li>
<li>AUDIO_SCENARIO_EDUCATION = 2: Applicable to the education scenario that prioritizes fluency and stability</li>
<li>AUDIO_SCENARIO_GAME_STREAMING = 3: Applicable to the live gaming scenario that needs to enable the gaming audio effects in the speaker mode in a live broadcast scenario</li>
<li>AUDIO_SCENARIO_SHOWROOM = 4: Applicable to the showroom scenario that optimizes the audio quality with professional external equipment</li>
<li>AUDIO_SCENARIO_CHATROOM_GAMING = 5: Applicable to the gaming scenario</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>

> -   Use this method before `joinChannel`, else it does not work.
> -   In the communication mode, setting `profile` works, but not `scenario`.
> -   In the communication and live-broadcast mode, the bitrate may be different from your settings due to network self-adaptation.
> -   In scenarios with music teaching, Agora recommends setting `profile` as MUSIC_HIGH_QUALITY(4) and `scenario` as GAME_STREAMING(3).
> -   CHATROOM_ENTERTAINMENT(1) and CHATROOM_GAMING(5) are recommended for audio-only scenarios.


#### Set High-quality Audio Preferences (setHighQualityAudioParameters)

```
public abstract int setHighQualityAudioParameters(boolean fullband, boolean stereo, boolean fullBitrate);
```

This method sets high-quality audio preferences. Call this method and set all the three modes before joining a channel. Do **NOT** call this method again after joining a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>fullband</td>
<td><p>Full-band codec (48 kHz sampling rate), not compatible with versions before v1.7.4.</p>
<ul>
<li>true: Enable full-band codec.</li>
<li>false: Disable full-band codec.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>stereo</td>
<td><p>Stereo codec, not compatible with versions before v1.7.4.</p>
<ul>
<li>true: Enable stereo codec.</li>
<li>false: Disable stereo codec.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>fullBitrate</td>
<td><p>High bitrate. Recommended in voice-only mode.</p>
<ul>
<li>true: Enable high bitrate mode.</li>
<li>false: Disable high bitrate mode.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> Agora does not recommend using this method. If you want to set the audio profile, see `setAudioProfile`.

#### Join a Channel (joinChannel)

```
public abstract int joinChannel(String token,
                                String channelName,
                                String optionalInfo,
                                int optionalUid);
```

This method allows a user to join a channel. Users in the same channel can talk to each other; and multiple users in the same channel can start a group chat. Users using different App IDs cannot call each other. Once in a call, the user must call the leaveChannel method to exit the current call before entering another channel.


> A channel does not accept duplicate UIDs, such as two users with the same UID. If your app supports logging in a user from different devices at the same time, ensure that you use different UIDs. For example, if you already used the same UID, make the UIDs different by adding the respective device ID to the UID. This is not applicable if your app does not support a user logging in from different devices at the same time. In this case, when you log in a new device, you will be logged out from the other device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>token</td>
<td><p>A Token generated by the application.</p>
<p>This parameter is optional if the user uses a static App ID. In this case, pass NULL as the parameter value.</p>
<p>If the user uses a Token, Agora issues an additional App Certificate to the application developers. The developers can then generate a user key using the algorithm and App Certificate provided by Agora for user authentication on the server.</p>
<p>In most circumstances, the static App ID will suffice. For added security, use a Token.</p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>channelName</td>
<td><p>A string providing the unique channel name for the AgoraRTC session. The length must be within 64 bytes.</p>
<p>The following is the supported scope: 
<ul>
<li>The 26 lowercase English letters from a to z</li>
<li>The 26 uppercase English letters from A to Z</li>
<li>The 10 numbers from 0 to 9</li>
<li>The space</li>
<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr/>
<tr><td>optionalInfo</td>
<td>(Optional) Additional information about the channel. Other users in the channel will not receive this information.</td>
</tr>
<tr><td>optionalUid</td>
<td><p>(Optional) User ID: A 32-bit unsigned integer ranging from 1 to (2^32-1). It must be unique. If not assigned (or set to 0), the SDK will assign one and return it in the onJoinChannelSuccess callback. The app needs to record and maintain the returned value as the SDK does not maintain it.</p>
<p>The UID is represented as a 32-bit unsigned integer in the SDK. Since unsigned integers are not supported by Java, the UID is handled as a 32-bit signed integer and larger numbers are interpreted as negative numbers in Java. If necessary, the UID can be converted to a 64-bit integer through “uid&amp;0xffffffffL”.</p>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<ul>
<li>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid.</li>
<li>ERR_NOT_READY (-3): Initialization failed.</li>
</ul>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
</tbody>
</table>



#### Leave a Channel (leaveChannel)

```
public abstract int leaveChannel();
```

This method allows a user to leave a channel, such as hanging up or exiting a call.

After joining a channel, the user must call the leaveChannel method to end the call before joining another one. The leaveChannel method releases all resources related to the call. The leaveChannel method is called asynchronously, and the user has not actually left the channel when the call returns. Once the user leaves the channel, the SDK triggers the onLeaveChannel callback.


> If you call `destroy()` immediately after `leaveChannel`, the `leavechannel` process will be interrupted, and the SDK will not trigger the onLeaveChannel callback.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Set the Local Voice Pitch (setLocalVoicePitch)

```
public abstract int setLocalVoicePitch(double pitch);
```

This method changes the voice pitch of the local speaker.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>pitch</td>
<td>Voice frequency, in the range of [0.5, 2.0]. The default value is 1.0.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>

#### Sets the Voice Position of the Remote user (setRemoteVoicePosition)

```
public int setRemoteVoicePosition(int uid, double pan, double gain);
```

This method sets the voice position of the remote user.

> This API is valid only for earphones, and is invalid when the speakerphone is enabled.

<table>
<colgroup>
<col>
</col>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td><p>User ID of the remote user</p>
</td></tr>
<tr><td>pan</td>
<td><p>Sets whether to change the spatial position of the audio effect. The range is [-1, 1]:</p>
<ul>
<li>0: The audio effect shows right ahead.</li>
<li>-1: The audio effect shows on the left.</li>
<li>1: The audio effect shows on the right.</li>
</ul>
</td>
</tr>
<tr><td>gain</td>
<td><p>Sets whether to change the volume of a single audio effect. The range is [0.0, 100.0]. The default value is 100.0. The smaller the number is, the lower the volume of the audio effect.</p>
</td></tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Success</li>
<li>&lt; 0: Failure</li>
</ul>
</td>
</tr>
</tbody>
</table>

#### Sets to Voice-only Mode (setVoiceOnlyMode)

```
public int setVoiceOnlyMode(boolean enable);
```

This method sets to voice-only mode (transmit the audio stream only), and the other streams will be ignored; for example the sound of the keyboard strokes.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>enable</td>
<td>
<ul>
<li>true: Enable voice-only mode.</li>
<li>false: Disable voice-only mode.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Success</li>
<li>&lt; 0: Failure</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Set the Local Voice Equalization (setLocalVoiceEqualization)

```
public abstract int setLocalVoiceEqualization(int bandFrequency, int bandGain);
```

This method sets the local voice equalization effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>bandFrequency</td>
<td>The band frequency ranging from 0 to 9; representing the respective 10-band center frequencies of voice effects, including 31, 62, 125, 500, 1k, 2k, 4k, 8k, and 16k Hz.</td>
</tr>
<tr><td>bandGain</td>
<td>Gain of each band in dB; ranging from -15 to 15.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the Local Voice Reverberation (setLocalVoiceReverb)

```
public abstract int setLocalVoiceReverb(int reverbKey, int value);
```

This method sets local voice reverberation.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>reverbKey</td>
<td>The reverberation key. This method contains five reverberation keys. For details, see the description of each value:</td>
</tr>
<tr><td>value</td>
<td><ul>
<li>AUDIO_REVERB_DRY_LEVEL = 0, (dB, [-20,10]), level of the dry signal</li>
<li>AUDIO_REVERB_WET_LEVEL = 1, (dB, [-20,10]), level of the early reflection signal (wet signal)</li>
<li>AUDIO_REVERB_ROOM_SIZE = 2, ([0, 100]), room size of the reflection</li>
<li>AUDIO_REVERB_WET_DELAY = 3, (ms, [0, 200]), length of the initial latency of the wet signal in ms</li>
<li>AUDIO_REVERB_STRENGTH = 4, ([0, 100]), length of the late reverberation</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Create a Video Renderer View (createRendererView)

```
public static SurfaceView createRendererView (Context context);
```

This method creates a video renderer view. It returns the SurfaceView type.

The operation and layout of the view are managed by the application, and the Agora SDK renders the view provided by the application.

The view to display videos must be created using this method instead of directly calling SurfaceView.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>context</td>
<td>The context of Android Activity.</td>
</tr>
</tbody>
</table>


#### Enable the Video Mode (enableVideo)

```
public abstract int enableVideo();
```

This method enables the video mode.

The application can call this method either before entering a channel or during a call. If it is called before entering a channel, the service starts in the video mode; if it is called during a call, it switches from the audio to video mode. To disable the video mode, call the disablevideo method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> This method sets to enable the internal engine, and still works after `leaveChannel` is called.

#### Disable the Video Mode (disableVideo)

```
public abstract int disableVideo();
```

This method disables the video mode. The application can call this method either before entering a channel or during a call. If it is called before entering a channel, the service starts in the audio mode; if it is called during a call, it switches from the video to audio mode. To enable the video mode, call the enablevideo method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> This method sets to disable the internal engine, and still works after `leaveChannel` is called.

#### Enable the Local Video (enableLocalVideo)

```
public abstract int enableLocalVideo(boolean enabled);
```

This method enables/disables the local video, which is only applicable to the scenario when the user only wants to watch the remote video without sending any video stream to the other user.

-   Call this method after `enableVideo`, otherwise this method may not work properly.

-   After `enableVideo` is called, the local video will be enabled by default. This method is useds to enable and disable the local video while the remote video remains unaffected.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>enabled</td>
<td><p>Sets to enable the local video:</p>
<div><ul>
<li>true: Enable the local video (default)</li>
<li>false: Disable the local video. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of other remote users. When set to false, this method does not require a local camera.</li>
</ul>
</div>
</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>


> This method sets to enable/disable the internal engine, and still works after `leaveChannel` is called.

#### Set the Video Profile (setVideoProfile)

> This method has been deprecated. If you hope to set the video encoder profile, Agora recommends using `setVideoEncoderConfiguration`.

```
public abstract int setVideoProfile(int profile, boolean swapWidthAndHeight);
```

This method sets the video encoding profile. If the user does not need to set the video encoding profile after joining the channel, Agora recommends calling this method before `enableVideo` to minimize the time delay in receiving the first video frame.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>profile</td>
<td>The video profile. See the Video Profile Definition Table below.</td>
</tr>
<tr><td>swapWidthAndHeight</td>
<td><p>The width and height of the output video is consistent with that of the video profile you set. This parameter sets whether to swap the width and height of the stream:</p>
<ul>
<li>true: Swap the width and height. After that the video will be in the portrait mode, that is, width &lt; height.</li>
<li>false: (Default) Do not swap the width and height, and the video remains in the landscape mode, that is, width &gt; height.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>


**Video Profile Definition Table**

<table>
<colgroup>
<col/>
<col/>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Video Profile</td>
<td>Resolution (Width x Height)</td>
<td>Frame Rate (fps)</td>
<td>Bitrate</td>
</tr>
<tr><td>120P</td>
<td>160 x 120</td>
<td>15</td>
<td>65</td>
</tr>
<tr><td>120P_3</td>
<td>120 x 120</td>
<td>15</td>
<td>50</td>
</tr>
<tr><td>180P</td>
<td>320 x 180</td>
<td>15</td>
<td>140</td>
</tr>
<tr><td>180P_3</td>
<td>180 x 180</td>
<td>15</td>
<td>100</td>
</tr>
<tr><td>180P_4</td>
<td>240 x 180</td>
<td>15</td>
<td>120</td>
</tr>
<tr><td>240P</td>
<td>320 x 240</td>
<td>15</td>
<td>200</td>
</tr>
<tr><td>240P_3</td>
<td>240 x 240</td>
<td>15</td>
<td>140</td>
</tr>
<tr><td>240P_4</td>
<td>424 x 240</td>
<td>15</td>
<td>220</td>
</tr>
<tr><td>360P</td>
<td>640 x 360</td>
<td>15</td>
<td>400</td>
</tr>
<tr><td>360P_3</td>
<td>360 x 360</td>
<td>15</td>
<td>260</td>
</tr>
<tr><td>360P_4</td>
<td>640 x 360</td>
<td>30</td>
<td>600</td>
</tr>
<tr><td>360P_6</td>
<td>360 x 360</td>
<td>30</td>
<td>400</td>
</tr>
<tr><td>360P_7</td>
<td>480 x 360</td>
<td>15</td>
<td>320</td>
</tr>
<tr><td>360P_8</td>
<td>480 x 360</td>
<td>30</td>
<td>490</td>
</tr>
<tr><td>360P_9</td>
<td>640 x 360</td>
<td>15</td>
<td>600</td>
</tr>
<tr><td>360P_10</td>
<td>640 x 360</td>
<td>24</td>
<td>800</td>
</tr>
<tr><td>360P_11</td>
<td>640 x 360</td>
<td>24</td>
<td>800</td>
</tr>
<tr><td>480P</td>
<td>640 x 480</td>
<td>15</td>
<td>500</td>
</tr>
<tr><td>480P_3</td>
<td>480 x 480</td>
<td>15</td>
<td>400</td>
</tr>
<tr><td>480P_4</td>
<td>640 x 480</td>
<td>30</td>
<td>750</td>
</tr>
<tr><td>480P_6</td>
<td>480 x 480</td>
<td>30</td>
<td>600</td>
</tr>
<tr><td>480P_8</td>
<td>848 x 480</td>
<td>15</td>
<td>610</td>
</tr>
<tr><td>480P_9</td>
<td>848 x 480</td>
<td>30</td>
<td>930</td>
</tr>
<tr><td>480P_10</td>
<td>640 x 480</td>
<td>10</td>
<td>400</td>
</tr>
<tr><td>720P</td>
<td>1280 x 720</td>
<td>15</td>
<td>1130</td>
</tr>
<tr><td>720P_3</td>
<td>1280 x 720</td>
<td>30</td>
<td>1710</td>
</tr>
<tr><td>720P_5</td>
<td>960 x 720</td>
<td>15</td>
<td>910</td>
</tr>
<tr><td>720P_6</td>
<td>960 x 720</td>
<td>30</td>
<td>1380</td>
</tr>
</tbody>
</table>






##### Manually Set the Video Profile (SetVideoProfile)


> This method has been deprecated. If you hope to set the video encoder profile, Agora recommends using `setVideoEncoderConfiguration`.

```
public abstract int setVideoProfile(int width, int height, int frameRate, int bitrate);
```

If the video profiles listed in the table do not meet your needs, use this method to manually set the width, height, frame rate, and bitrate of the video. If the user does not need to set the video encoding profile after joining the channel, Agora recommends calling this method before `enableVideo` to minimize the time delay in receiving the first video frame.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>width</td>
<td>Width of the video that you want to set. The highest value is 1280.</td>
</tr>
<tr><td>height</td>
<td>Height of the video that you want to set. The highest value is 720.</td>
</tr>
<tr><td>frameRate</td>
<td>Frame rate of the video that you want to set. The highest value is 30. You can set it to 5, 10, 15, 24, 30, and so on.</td>
</tr>
<tr><td>bitrate</td>
<td><p>Bitrate of the video that you want to set. You need to manually work out the bitrate according to the width, height, and frame rate. With the same width and height, the bitrate varies with the change of the frame rate:</p>
<ul>
<li>If the frame rate is 5 fps, divide the recommended bitrate in the table by 2.</li>
<li>If the frame rate is 15 fps, use the recommended bitrate in the table.</li>
<li>If the frame rate is 30 fps, multiply the recommended bitrate in the table by 1.5.</li>
<li>Calculate your bitrate with the ratio if you choose other frame rates.</li>
</ul>
<p>If the bitrate you set is beyond the proper range, the SDK will automatically adjust it to a value within the range.</p>
</td>
</tr>
</tbody>
</table>


#### Set the Local Video View (setupLocalVideo)

```
public abstract int setupLocalVideo(VideoCanvas local);
```

This method configures the video display settings on the local machine.

The application calls this method to bind with the video window (view) of local video streams and configure the video display settings. Call this method after initialization to configure the local video display settings before entering a channel. After leaving the channel, the bind is still valid, which means the window still displays. To unbind the window, set the view value to NULL when calling setupLocalVideo.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>local</td>
<td><p>Video display settings. Class VideoCanvas:</p>
<ul>
<li>view: Video display window (view).</li>
<li>renderMode: Video display mode.<ul>
<li>RENDER_MODE_HIDDEN (1): Uniformly scale the video until it fills the visible boundaries. One dimension of the video may have clipped contents.</li>
<li>RENDER_MODE_FIT (2): Uniformly scale the video until one of its dimension fits the boundary. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.</li>
</ul>
</li>
<li>Return value: The local user ID as set in the joinchannel method.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the Remote Video View (setupRemoteVideo)

```
public abstract int setupRemoteVideo(VideoCanvas remote);
```

This method binds the remote user to the video display window, that is, sets the view for the user of the specified uid. The application should specify the uid of the remote video in the method call before the user enters a channel.

If the remote uid is unknown to the application, set it later when the application receives the onUserJoined event. If the Video Recording function is enabled, the Video Recording Service joins the channel as a dumb client, which means other clients also receive this onUserJoined event. Your application should not bind it with the view, because it does not send any video stream. If your application cannot recognize the dumb client, bind it with the view when the onFirstRemoteVideoDecoded event is triggered. To unbind the user with the view, set the view to null. Once the user has left the channel, the SDK unbinds the remote user.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>remote</td>
<td><p>Video display settings. Class VideoCanvas:</p>
<ul>
<li><p>view: Video display window (view).</p>
</li>
<li><p>renderMode: Video display mode.</p>
<div><ul>
<li>RENDER_MODE_HIDDEN (1): Uniformly scale the video until it fills the visible boundaries. One dimension of the video may have clipped contents.</li>
<li>RENDER_MODE_FIT (2): Uniformly scale the video until one of its dimension fits the boundary. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.</li>
</ul>
</div>
</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Enable Dual-stream Mode (enableDualStreamMode)

```
public abstract int enableDualStreamMode(boolean enabled);
```

This method sets the stream mode to single- (default) or dual-stream mode. After it is enabled, the receiver can choose to receive the high stream, that is, high-resolution high-bitrate video stream, or low stream, that is, low-resolution low-bitrate video stream.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>enabled</td>
<td><p>The mode is in single stream or dual stream:</p>
<ul>
<li>true: Dual stream</li>
<li>false: Single stream</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Set the Remote Video-stream Type (setRemoteVideoStreamType)

```
public abstract int setRemoteVideoStreamType(int uid, int streamType);
```

This method specifies the video-stream type of the remote user to be received by the local user when the remote user sends dual streams.

-   If dual-stream mode is enabled by calling `enableDualStreamMode`, you will receive the high-video stream by default. This method allows the application to adjust the corresponding video-stream type according to the size of the video windows to save the bandwidth and calculation resources.

-   If dual-stream mode is not enabled, you will receive the high-video stream by default.


The result after calling this method will be returned in `onApiCallExecuted`. The Agora SDK receives the high-video stream by default to save the bandwidth. If needed, users can switch to the low-video stream using this method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>streamType</td>
<td><p>Set the video-stream size.</p>
<p>The following lists the video-stream types:</p>
<ul>
<li>VIDEO_STREAM_HIGH(0): High-video stream</li>
<li>VIDEO_STREAM_LOW(1): Low-video stream</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



The resolution of the high-video stream is 1.1, 4.3, or 16.9. By default, the aspect ratio of the low-video stream is the same as that of the high-video stream. Once the resolution of the high-video stream is set, the system automatically sets the aspect ratio for the low-video stream.

<table>
<colgroup>
<col/>
<col/>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Resolution</th>
<th>Frame Rate</th>
<th>Keyframe Interval</th>
<th>Bitrate (kbit/s)</th>
</tr>
</thead>
<tbody>
<tr><td>160 x 160</td>
<td>5</td>
<td>5</td>
<td>45</td>
</tr>
<tr><td>160 x 120</td>
<td>5</td>
<td>5</td>
<td>32</td>
</tr>
<tr><td>160 x 90</td>
<td>5</td>
<td>5</td>
<td>28</td>
</tr>
</tbody>
</table>



#### Set the Default Remote Video Stream Type (setRemoteDefaultVideoStreamType)

```
public abstract int setRemoteDefaultVideoStreamType(int streamType);
```

This method sets the default remote video stream type to high or low.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>streamType</td>
<td><p>The default remote video stream:</p>
<ul>
<li>VIDEO_STREAM_HIGH(0): High-video stream</li>
<li>VIDEO_STREAM_LOW(1): Low-video stream</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set High-quality Video Preferences (setVideoQualityParameters)

```
public abstract int setVideoQualityParameters(boolean preferFrameRateOverImageQuality);
```

This method allows users to set video preferences.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>preferFrameRateOverImageQuality</td>
<td><p>The video preference to be set:</p>
<ul>
<li>true: Frame rate over image quality</li>
<li>false: Image quality over frame rate (default)</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Start a Video Preview (startPreview)

```
public abstract int startPreview();
```

This method starts the local video preview before joining the channel. Before using this method, you need to:

-   Call `setupLocalVideo` to set up the local preview window and configure the attributes

-   Call `enableVideo` to enable video


> Once the local video preview is enabled, the preview will not be shut down if you call `leaveChannel` to leave the channel. To shut down the preview, call `stopPreview`.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop a Video Preview (stopPreview)

```
public abstract int stopPreview();
```

This method stops the local video preview and closes the video.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Set the Local Video Display Mode (setLocalRenderMode)

```
public abstract int setLocalRenderMode(int mode);
```

This method configures the local video display mode.

The application can call this method multiple times during a call to change the display mode.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>mode</td>
<td><p>Configures the video display mode:</p>
<ul>
<li>RENDER_MODE_HIDDEN (1): Uniformly scale the video until it fills the visible boundaries. One dimension of the video may have clipped contents.</li>
<li>RENDER_MODE_FIT (2): Uniformly scale the video until one of its dimension fits the boundary. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the Remote Video Display Mode (setRemoteRenderMode)

```
public abstract int setRemoteRenderMode(int uid, int mode);
```

This method configures the remote video display mode. The application can call this method multiple times during a call to change the display mode.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>uid</td>
<td>The user ID of the user whose video streams are received.</td>
</tr>
<tr><td>mode</td>
<td><p>Configures the video display mode:</p>
<ul>
<li>RENDER_MODE_HIDDEN (1): Uniformly scale the video until it fills the visible boundaries. One dimension of the video may have clipped contents.</li>
<li>RENDER_MODE_FIT (2): Uniformly scale the video until one of its dimension fits the boundary. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Set the Local Video Mirror Mode (setLocalVideoMirrorMode)

```
public abstract int setLocalVideoMirrorMode(int mode);
```

This method sets the local video mirror mode. Use this method before `startPreview`, or it does not take effect until you re-enable `startPreview`.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>mode</td>
<td><p>Sets the local video mirror mode</p>
<div><ul>
<li>0: The default mirror mode, that is, the mode set by the SDK</li>
<li>1: Enable the mirror mode</li>
<li>2: Disable the mirror mode</li>
</ul>
</div>
</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Switch between Front and Back Cameras (switchCamera)

```
public abstract int switchCamera();
```

This method switches between front and back cameras.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Check whether Camera Zoom is Supported (isCameraZoomSupported)

```
public abstract boolean isCameraZoomSupported();
```

It returns:

-   true: The device supports the camera zoom function
-   false: The device does not support the camera zoom function


#### Check whether Camera Flash is Supported (isCameraTorchSupported)

```
public abstract boolean isCameraTorchSupported();
```

It returns:

-   true: The device supports the camera flash function
-   false: The device does not support the camera flash function


> The App generally enables the front camera by default. If your front camera does not support front camera torch, this method will return false. If you want to check if the rear camera torch is supported, call `switchCamera` before using this method.

#### Check whether Manual Focus is Supported (isCameraFocusSupported)

```
public abstract boolean isCameraFocusSupported();
```

It returns:

-   true: The device supports the manual focus function
-   false: The device does not support the manual focus function


#### Check whether Autofocus is Supported (isCameraAutoFocusFaceModeSupported)

```
public abstract boolean isCameraAutoFocusFaceModeSupported();
```

It returns:

-   true: The device supports the autofocus function;
-   false: The device does not support the autofocus function;


#### Set the Camera Zoom Ratio (setCameraZoomFactor)

```
public abstract int setCameraZoomFactor(float factor);
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>factor</td>
<td>Camera zoom factor ranging from 1.0 to the max zoom</td>
</tr>
</tbody>
</table>



#### Get the Supported Max Zoom Ratio (getCameraMaxZoomFactor)

```
public abstract float getCameraMaxZoomFactor();
```

This method gets the max zoom ratio supported by the camera.

#### Set the Manual Focus Position (setCameraFocusPositionInPreview)

```
public abstract int setCameraFocusPositionInPreview(float positionX, float positionY);
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>positionX</td>
<td>Horizontal coordinate of the touch point in the view</td>
</tr>
<tr><td>positionY</td>
<td>Vertical coordinate of the touch point in the view</td>
</tr>
</tbody>
</table>



#### Enable the Camera Flash (setCameraTorchOn)

```
public abstract int setCameraTorchOn(boolean isOn);
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>isOn</td>
<td>Whether to enable the camera flash function: true/false</td>
</tr>
</tbody>
</table>



#### Enable the Camera Autofocus (setCameraAutoFocusFaceModeEnabled)

```
public abstract int setCameraAutoFocusFaceModeEnabled(boolean enabled);
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>enabled</td>
<td>Whether to enable the camera autofocus function: true/false</td>
</tr>
</tbody>
</table>




#### Enable Web SDK Interoperability (enableWebSdkInteroperability)

```
public int enableWebSdkInteroperability(bool enabled);
```

This method enables interoperability with the Agora Web SDK.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>enabled</td>
<td><p>Whether to enable the interoperability with the Agora Web SDK is enabled:</p>
<ul>
<li>True: Enable the interoperability</li>
<li>False: Disable the interoperability</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Set the Default Audio Route (setDefaultAudioRouteToSpeakerphone)

```
public abstract int setDefaultAudioRoutetoSpeakerphone(boolean defaultToSpeaker);
```

This method modifies the default audio route if necessary.

> -   Call this method only if you want to change the default settings.
> -   This method only works in audio mode.
> -   Call this method before `joinChannel`.


The default audio routes are listed in the following table:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Channel Mode</th>
<th>Default Audio Route</th>
</tr>
</thead>
<tbody>
<tr><td>Communication</td>
<td><p>Voice Communication: Earpiece</p>
<p>Video Communication: Speakerphone</p>
<p>If the user in a communication channel has called <code>disableVideo</code> or if the user has called <code>muteLocalVideoStream</code> and <code>muteAllRemoteVideoStreams</code>, the audio route is switched back to the earpiece automatically.</p>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Live Broadcast</td>
<td>Speakerphone</td>
</tr>
<tr><td>Game Voice</td>
<td>Speakerphone</td>
</tr>
</tbody>
</table>



Modify the default audio route **if necessary** according to the following table:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>defaultToSpeaker</td>
<td><ul>
<li>true: Speakerphone.</li>
<li>false: Earpiece.</li>
</ul>
<p>Whether the audio is routed to the speakerphone or earpiece, once a headset is plugged in or Bluetooth is connected,</p>
<p>the audio route will be changed. The audio route will be switched to default once removing the headset or disconnecting Bluetooth.</p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Enable the Speakerphone (setEnableSpeakerphone)

```
public abstract int setEnableSpeakerphone(boolean enabled);
```

This method enables the audio routing to the speakerphone.

After calling this method, the SDK will return the `onAudioRouteChanged` callback to indicate the changes.

> Read the default audio route explanation according to `setDefaultAudioRouteToSpeakerphone` and check whether it is necessary to call this method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>enabled</td>
<td><ul>
<li>true:<ul>
<li>If this API is called after joining a channel, whether the audio was routed to the headset, Bluetooth device, or earpiece, it will be routed to the speaker.</li>
<li>If this API is called before joining a channel, when joining a channel, the audio will be routed to the speaker whether the user uses a headset or Bluetooth device.</li>
</ul>
</li>
<li>false: The audio will follow the default audio route mentioned in <a href="#setdefaultroutetospeakerphone-live"><span>Set the Default Audio Route (setDefaultAudioRouteToSpeakerphone)</span></a>.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Check Whether the Speakerphone is Enabled (isSpeakerphoneEnabled)

```
public abstract boolean isSpeakerphoneEnabled();
```

This method checks whether the speakerphone is enabled or disabled.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>true: The speakerphone is enabled.</li>
<li>false: The speakerphone is not enabled.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Enable In-ear Monitoring (enableInEarMonitoring)

```
public abstract int enableInEarMonitoring(boolean enabled);
```

This method enables or disables the in-ear monitoring function.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>enabled</td>
<td><ul>
<li>true: Enable in-ear monitoring.</li>
<li>false: Disable in-ear monitoring.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Enable the Audio Volume Indication (enableAudioVolumeIndication)

```
public abstract int enableAudioVolumeIndication(int interval, int smooth);
```

This method allows the SDK to regularly report to the application on which user is speaking and the volume of the speaker. Once the method is enabled, the SDK returns the volume indication at the set time interval in the `onAudioVolumeIndication` callback, regardless of whether anyone is speaking in the channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>interval</td>
<td><p>Time interval between two consecutive volume indications:</p>
<div><ul>
<li>&lt;= 0: Disables the volume indication.</li>
<li>&gt; 0: The time interval between two consecutive volume indications in milliseconds. Agora recommends setting it to more than 200 ms. Do not set it lower than 10 ms, or the <code>onAudioVolumeIndication</code> callback will not be triggered.</li>
</ul>
</div>
</td>
</tr>
<tr><td>smooth</td>
<td>Smoothing factor. The default value is 3.</td>
</tr>
<tr><td>Return values</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the Volume of the In-ear Monitor (setInEarMonitoringVolume)

```
public abstract int setInEarMonitoringVolume(int volume);
```

This method sets the volume of the in-ear monitor.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>volume</td>
<td>Volume of the in-ear monitor, ranging from 0 to 100. The default value is 100.</td>
</tr>
<tr><td>Return values</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>

#### Mute the Local Audio Stream (muteLocalAudioStream)

```
public abstract int muteLocalAudioStream(boolean muted);
```

This method enables/disables sending local audio streams to the network.

> When set to true, this method does not disable the microphone, and thus does not affect any ongoing recording.
> This method takes effect only when the user is in the channel. After the user leaves the channel, the mute state is reset.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>On</td>
<td><ul>
<li>true: Stops sending local audio streams to the network.</li>
<li>false: Allows sending local audio streams to the network.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Mute all Remote Audio Streams (muteAllRemoteAudioStreams)

```
public abstract int muteAllRemoteAudioStreams(boolean muted);
```

This method enables/disables playing all remote users’ audio streams.


> When set to true, this method stops playing audio streams without affecting the audio stream receiving process.
> This method takes effect only when the user is in the channel. After the user leaves the channel, the mute state is reset.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>On</td>
<td><ul>
<li>true: Stops playing all the received audio streams</li>
<li>false: Allows playing all the received audio streams</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Mute a Specified Remote Audio Stream (muteRemoteAudioStream)

```
public abstract int muteRemoteAudioStream(int uid, boolean muted);
```

This method mutes/unmutes a specified remote user’s audio stream.


> When set to true, this method stops playing audio streams without affecting the audio stream receiving process.
> This method takes effect only when the user is in the channel. After the user leaves the channel, the mute state is reset.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID whose audio streams the user intends to mute.</td>
</tr>
<tr><td>muted</td>
<td><ul>
<li>true: Stops playing a specified user’s audio streams.</li>
<li>false: Allows playing a specified user’s audio streams.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>

#### Mute the Local Video Stream (muteLocalVideoStream)

```
public abstract int muteLocalVideoStream(boolean muted);
```

This method enables/disables sending local video streams to the network.


> When set to true, this method does not disable the camera and thus does not affect the retrieval of local video streams. This method responds faster than enableLocalVideo (false).
> This method takes effect only when the user is in the channel. After the user leaves the channel, the mute state is reset.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>mute</td>
<td><ul>
<li>true:  Stops sending local video streams to the network.</li>
<li>false: Allows sending local video streams to the network.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Mute all Remote Video Streams (muteAllRemoteVideoStreams)

```
public abstract int muteAllRemoteVideoStreams(boolean muted);
```

This method enables/disables playing all remote callers’ video streams.


> When set to true, this method stops playing video streams without affecting the video stream receiving process.
> This method takes effect only when the user is in the channel. After the user leaves the channel, the mute state is reset.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>mute</td>
<td><ul>
<li>true: Stops playing all the received video streams.</li>
<li>false: Allows playing all the received video streams.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Mute a Specified Remote Video Stream (muteRemoteVideoStream)

```
public abstract int muteRemoteVideoStream(int uid, boolean muted);
```

This method pauses/resumes receiving a specified user’s video stream.

> When set to true, this method stops playing video streams without affecting the video stream receiving process.
> This method takes effect only when the user is in the channel. After the user leaves the channel, the mute state is reset.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>Specified user’s user ID.</td>
</tr>
<tr><td>mute</td>
<td><ul>
<li>true: Stops playing a specified user’s video stream.</li>
<li>false: Allows playing a specified user’s video stream.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Start Audio Mixing (startAudioMixing)

```
public abstract int startAudioMixing(String filePath,
                                     boolean loopback,
                                     boolean replace,
                                     int cycle);
```

This method mixes the specified local audio file with the audio stream from the microphone; or, it replaces the microphone’s audio stream with the specified local audio file. You can choose whether the other user can hear the local audio playback and specify the number of loop playbacks. This API also supports online music playback.


> -   To use this API, ensure that the Android device version is 4.2 or later, and the API version is 16 or later.
> -   Call this API when you are in the channel, otherwise, it may cause issues.
> -   If you call this API on an emulator, only the MP3 file format is supported.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>filePath</td>
<td><p>Name and path of the local audio file to be mixed:</p>
<ul>
<li>If the path begins with <code>/assets/</code>, find the audio file in the <code>/assets/</code> directory.</li>
<li>Otherwise, find the audio file in the absolute path.</li>
</ul>
<p>Supported audio formats: mp3, aac, m4a, 3gp, wav, flac</p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>loopback</td>
<td><ul>
<li>true: Only the local user can hear the remix or the replaced audio stream.</li>
<li>false: Both users can hear the remix or the replaced audio stream.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>replace</td>
<td><ul>
<li>true: The content of the local audio file replaces the audio stream from the microphone.</li>
<li>false:  Local audio file mixed with the audio stream from the microphone.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>cycle</td>
<td><p>Number of loop playbacks:</p>
<ul>
<li>Positive integer: Number of loop playbacks</li>
<li>-1: Infinite loop</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop Audio Mixing (stopAudioMixing)

```
public abstract int stopAudioMixing();
```

This method stops audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Pause Audio Mixing (pauseAudioMixing)

```
public abstract int pauseAudioMixing();
```

This method pauses audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Resume Audio Mixing (resumeAudioMixing)

```
public abstract int resumeAudioMixing();
```

This method resumes audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Adjust the Audio Mixing Volume (adjustAudioMixingVolume)

```
public abstract int adjustAudioMixingVolume(int volume);
```

This method adjusts the volume during audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>volume</td>
<td>Volume ranging from 0 to 100. By default, 100 is the original volume.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Get the Audio Mixing Duration (getAudioMixingDuration)

```
public abstract int getAudioMixingDuration();
```

This method gets the duration (ms) of audio mixing. Call this API when you are in a channel.

#### Get the Current Audio Position (getAudioMixingCurrentPosition)

```
public abstract int getAudioMixingCurrentPosition();
```

This method gets the playback position (ms) of the audio. Call this API when you are in a channel.

#### Drag the Audio Progress Bar (setAudioMixingPosition)

```
public abstract int setAudioMixingPosition(int pos);
```

This method drags the playback progress bar of the audio mixing file to where you want to play instead of playing it from the beginning.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>pos</td>
<td>Integer. The position of the audio mixing file (ms).</td>
</tr>
</tbody>
</table>

#### Start an Audio Recording (startAudioRecording)

```
public abstract int startAudioRecording(String filePath, int quality);
```

This method starts an audio recording. The SDK allows recording during a call, which supports either one of the following two formats:

-   *.wav*: Large file size with high sound fidelity **OR**

-   *.aac*: Small file size with low sound fidelity


Ensure that the directory to save the recording file exists and is writable. This method is usually called after the `joinChannel()` method. The recording automatically stops when the `leaveChannel()` method is called.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>filePath</td>
<td>Full file path of the recording file. The string of the file name is in UTF-8 code.</td>
</tr>
<tr><td>quality</td>
<td><p>Audio recording quality:</p>
<ul>
<li><code>AUDIO_RECORDING_QUALITY_LOW = 0</code>: Low quality, file size is around 1.2 MB after 10 minutes of recording.</li>
<li><code>AUDIO_RECORDING_QUALITY_MEDIUM = 1</code>: Medium quality, file size is around 2 MB after 10 minutes of recording.</li>
<li><code>AUDIO_RECORDING_QUALITY_HIGH = 2</code>: High quality, file size is around 3.75 MB after 10 minutes of recording.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop an Audio Recording (stopAudioRecording)

```
public abstract int stopAudioRecording();
```

This method stops recording on the client.


> Call this method before calling leaveChannel, otherwise, the recording automatically stops when the leaveChannel method is called.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Adjust the Recording Volume (adjustRecordingSignalVolume)

```
public abstract int adjustRecordingSignalVolume(int volume);
```

This method adjusts the recording volume.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>volume</td>
<td><p>Recording volume, ranges from 0 to 400:</p>
<ul>
<li>0: Mute</li>
<li>100: Original volume</li>
<li>400: (Maximum) Four times the original volume with signal clipping protection</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Adjust the Playback Volume (adjustPlaybackSignalVolume)

```
public abstract int adjustPlaybackSignalVolume(int volume);
```

This method adjusts the playback volume.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>volume</td>
<td><p>Playback volume, ranges from 0 to 400:</p>
<ul>
<li>0: Mute</li>
<li>100: Original volume</li>
<li>400: (Maximum) Four times the original volume with signal clipping protection</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Enable Built-in Encryption and Set the Encryption Secret (setEncryptionSecret)

```
public abstract int setEncryptionSecret(String secret);
```

Use setEncryptionSecret to specify an encryption password to enable built-in encryption before joining a channel. All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user has left the channel. If the encryption password is not specified or set to empty, the encryption function will be disabled.


> Do not use this method together with CDN.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>secret</td>
<td>Encryption Password</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Set the Built-in Encryption Mode (setEncryptionMode)

```
public abstract int setEncryptionMode(String encryptionMode);
```

The Agora Native SDK supports built-in encryption, which is in AES-128-XTS mode by default. If you want to use other modes, call this API to set the encryption mode.

All users in the same channel must use the same encryption mode and password. Refer to information related to the AES encryption algorithm on the differences between encryption modes.

Call setEncryptionSecret to enable the built-in encryption function before calling this API.


> Do not use this function together with CDN.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>encryptionMode</td>
<td><p>Encryption mode. The following modes are supported:</p>
<ul>
<li>“aes-128-xts”:128-bit AES encryption, XTS mode</li>
<li>“aes-128-ecb”:128-bit AES encryption, ECB mode</li>
<li>“aes-256-xts”: 256-bit AES encryption, XTS mode</li>
<li>“”: When it is set to NUL string, the encryption is in “aes-128-xts” by default.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Create a Data Stream (createDataStream)

```
public abstract int createDataStream(boolean reliable, boolean ordered);
```

This method creates a data stream. Each user can only have up to five data channels at the same time.


> Set `reliable` and `ordered` both as true or both as false. Do not set one as *true* and the other as *false*.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>reliable</td>
<td><ul>
<li>true: The recipients will receive data from the sender within 5 seconds. If the recipient does not receive the sent data within 5 seconds, the data channel will report an error to the application.</li>
<li>false: The recipients may not receive any data, and the SDK will not report any error upon data missing.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>ordered</td>
<td><ul>
<li>true: The recipients will receive data in the order of the sender.</li>
<li>false: The recipients will not receive data in the order of the sender.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>&lt;0: Returns an error code when it fails to create the data stream. <sup>[3]</sup></li>
<li>&gt;0: Returns the Stream ID when the data stream is created.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



> [3] The error code is related to the positive integer displayed in [Error Codes and Warning Codes](/en/API%20Reference/the_error_native), for example, if it returns -2, then it indicates 2: ERR_INVALID_ARGUMENT in [Error Codes and Warning Codes](/en/API%20Reference/the_error_native).

#### Send a Data Stream (sendStreamMessage)

```
public abstract int sendStreamMessage(int streamId, byte[] message);
```

This method sends data stream messages to all users in a channel. Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB. The API controls the data channel transfer rate. Each client can send up to 6 kB of data per second. Each user can have up to five data channels simultaneously.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>streamId</td>
<td>Stream ID returned by createDataStream.</td>
</tr>
<tr><td>message</td>
<td>Data to be sent</td>
</tr>
<tr><td>Return Value</td>
<td><p>When it fails to send the message, the following error code will be returned:</p>
<p>ERR_SIZE_TOO_LARGE/ERR_TOO_OFTEN/ERR_BITRATE_LIMIT</p>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Start an Audio Call Test (startEchoTest)

```
public abstract int startEchoTest();
```

This method launches an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly. In the test, the user first speaks, and the recording is played back in 10 seconds. If the user can hear the recording in 10 seconds, it indicates that the audio devices and network connection work properly.

> -   After calling the startEchoTest method, call stopEchoTest to end the test; otherwise, the application cannot run the next echo test, nor can it call the `joinChannel` method to start a new call.
> -   This method is applicable only when the user role is broadcaster. If you switch the channel mode from communication to live broadcast, ensure that `setClientRole` is called to change the user role from audience(default in the live broadcast mode) to broadcaster before using this method.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_REFUSED (-5): Failed to launch the echo test, for example, initialization failed.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>



#### Stop an Audio Call Test (stopEchoTest)

```
public abstract int stopEchoTest();
```

This method stops an audio call test.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_REFUSED(-5): Failed to stop the echo test. It could be that the echo test is not running.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>



#### Enable the Network Test (enableLastmileTest)

```
public abstract int enableLastmileTest();
```

This method tests the quality of the user’s network connection and is disabled by default.

This method is mainly used in two scenarios:

-   Before users join a channel, this method can be called to check the uplink network quality.

-   Before the audience in a channel switch to a host role, this method can be called to check the uplink network quality.


In both scenarios, calling this method consumes extra network traffic, which affects the communication quality.

Call disableLastmileTest to disable it immediately once the users have received the onLastmileQuality callback before they join the channel or switch the user role.


> For current hosts, do not call this method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Disable the Network Test (disableLastmileTest)

```
public abstract int disableLastmileTest();
```

This method disables the network connection quality test.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Retrieve the Current Call ID (getCallId)

```
public abstract String getCallId();
```

This method retrieves the current call ID.

When a user joins a channel on a client, a CallId is generated to identify the call from the client. Some methods such as rate and complain need to be called after the call ends in order to submit feedback to the SDK. These methods require assigned values of the CallId parameters. To use these feedback methods, call the getCallId method to retrieve the CallId during the call, and then pass the value as an argument in the feedback methods after the call ends.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td>Current call ID.</td>
</tr>
</tbody>
</table>



#### Rate the Call (rate)

```
public abstract int rate(String callId,
                         int rating,
                         String description);
```

This method lets the user rate the call. It is usually called after the call ends.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>callId</td>
<td>Call ID retrieved from the getCallId method.</td>
</tr>
<tr><td>rating</td>
<td>Rating for the call between 1 (lowest score) to 10 (highest score).</td>
</tr>
<tr><td>description</td>
<td><p>A given description for the call with a length less than 800 bytes.</p>
<p>This parameter is optional.</p>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid, for example, callId invalid.</li>
<li>ERR_NOT_READY (-3): The SDK status is incorrect, for example, initialization failed.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
</tbody>
</table>



#### Complain about the Call Quality (complain)

```
public abstract int complain(String callId,
                             String description);
```

This method allows the user to complain about the call quality. It is usually called after the call ends.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>callId</td>
<td>Call ID retrieved from the getCallId method.</td>
</tr>
<tr><td>description</td>
<td><p>A given description of the call with a length less than 800 bytes.</p>
<p>This parameter is optional.</p>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid, for example, callId invalid.</li>
<li>ERR_NOT_READY (-3): The SDK status is incorrect, for example, initialization failed.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
</tbody>
</table>


#### Renew Token (renewtoken)

```
public abstract int renewToken(String token);
```

This method updates the Token.

The key expires after a certain period of time once the Token schema is enabled when:

-   The `onError` callback reports the ERR_TOKEN_EXPIRED(109) error, or
-   The `onRequestToken` callback reports the ERR_TOKEN_EXPIRED(109) error, or


The application should retrieve a new key and then call this method to renew it. Failure to do so will result in the SDK disconnecting with the server.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>token</td>
<td>Specifies the Token to be renewed.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Specify a Log File (setLogFile)

```
public abstract int setLogFile(String filePath);
```

This method specifies an SDK output log file. The log file records all the log data of the SDK’s operation. Ensure that the directory to save the log file exists and is writable.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>filePath</td>
<td>File path of the log file. The string of the log file is in UTF-8 code.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> The default log file location is at: sdcard/<appname\>/agorasdk.log, where appname is the name of the application.

#### Set the Log Filter (setLogFilter)

```
public abstract int setLogFilter(int filter);
```

This method sets the output log level of the SDK. You can use either one or a combination of the filters.

The log level follows the sequence of *OFF*, *CRITICAL*, *ERROR*, *WARNING*, *INFO*, and *DEBUG*. Choose a level, and you can see logs that precede that level.

For example, if you set the log level as *WARNING*, then you can see logs in levels *CRITICAL*, *ERROR* and *WARNING*.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>filter</td>
<td><p>Set the levels of the filters:</p>
<div><ul>
<li>LOG_FILTER_OFF = 0: Output no log.</li>
<li>LOG_FILTER_DEBUG = 0x80f: Output all the API logs.</li>
<li>LOG_FILTER_INFO = 0x0f: Output logs of the CRITICAL, ERROR, WARNING and INFO level.</li>
<li>LOG_FILTER_WARNING = 0x0e: Output logs of the CRITICAL, ERROR and WARNING level.</li>
<li>LOG_FILTER_ERROR = 0x0c: Output logs of the CRITICAL and ERROR level.</li>
<li>LOG_FILTER_CRITICAL = 0x08: Output logs of the CRITICAL level.</li>
</ul>
</div>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Destroy the Engine Instance (destroy)

```
public static synchronized void destroy();
```

This method releases all the resources used by the Agora SDK. This is useful for applications that occasionally make voice or video calls, to free up resources for other operations when not making calls.

Once the application has called destroy() to destroy the created RtcEngine instance, no other methods in the SDK can be used and no callbacks occur.

To start communications again, a new Initialize(sharedEngineWithappId) must be performed to establish a new AgoraRtcEngineKit instance.


> -   Use this method in the sub thread.
> -   This method is called synchronously. The result returns after the IRtcEngine object resources are released. The app should not call this interface in the callback generated by the SDK, otherwise the SDK must wait for the callback to return before it can reclaim the related object resources, causing a deadlock.


#### Get the SDK Version (getSdkVersion)

```
public static String getSdkVersion();
```

This method returns the string of the version number in char format.


<a id = "iaudioeffectmanager"></a>
### Audio Effect Methods (IAudioEffectManager)

#### Get the Audio Effect Volume (getEffectsVolume)

```
public double getEffectsVolume();
```

This method gets the volume of the audio effects from 0.0 to 100.0.

#### Set the Audio Effect Volume (setEffectsVolume)

```
public int setEffectsVolume(double volume);
```

This method sets the volume of the audio effects.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>volume</td>
<td>Value ranges from 0.0 to 100.0. 100.0 is the default value.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Adjust the Audio Effect Volume in Real Time (setVolumeOfEffect)

```
public int setVolumeOfEffect(int soundId, double volume);
```

This method adjusts the volume of the specified audio effect in real time.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>volume</td>
<td>Value ranges from 0.0 to 100.0. 100.0 is the default value.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Play the Audio Effect (playEffect)

```
public int playEffect(int soundId, String filePath, int loopCount, double pitch, double pan, double gain, boolean publish);
```

This method plays the specified audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the specified audio effect. Each audio effect has a unique ID <sup>[4]</sup>.</td>
</tr>
<tr><td>filePath</td>
<td>The absolute file path of the audio effect file.</td>
</tr>
<tr><td>loopCount</td>
<td><p>Set the number of times looping the audio effect:</p>
<ul>
<li>0: Play the audio effect once</li>
<li>1: Play the audio effect twice</li>
<li>-1: Play the audio effect in a loop indefinitely, until <code>stopEffect</code> or <code>stopAllEffects</code> is called</li>
</ul>
</td>
</tr>
<tr><td>pitch</td>
<td>Set whether to change the pitch of the audio effect. The range is [0.5, 2].
The default value is 1, which means no change to the pitch. The smaller the value, the lower the pitch.</td>
</tr>
<tr><td>pan</td>
<td><p>Spatial position of the local audio effect. The range is [-1.0, 1.0]</p>
<ul>
<li>0.0: The audio effect shows ahead.</li>
<li>1.0: The audio effect shows on the right.</li>
<li>-1.0: The audio effect shows on the left.</li>
</ul>
</td>
</tr>
<tr><td>gain</td>
<td>Volume of the audio effect. The range is [0.0, 100,0].
The default value is 100.0. The smaller the value, the lower the volume of the audio effect.</td>
</tr>
<tr><td>publish</td>
<td><p>Set whether to publish the specified audio effect to the remote stream:</p>
<ul>
<li>true: The audio effect, played locally, is published to the Agora Cloud and the remote users can hear it.</li>
<li>false: The audio effect, played locally, is not published to the Agora Cloud and the remote users cannot hear it.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



> [4] If you preloaded the audio effect into the memory through `preloadEffect`, ensure that the `soundID` value is set to the same value as in `preloadEffect`.

> In version v2.1.x, the following method, which is not recommended by Agora, is used.

```
public int playEffect(int soundId, String filePath, boolean loop, double pitch, double pan, double gain);
```

#### Stop Playing an Audio Effect (stopEffect)

```
public int stopEffect(int soundId);
```

This method stops playing a specific audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop Playing all Audio Effects (stopAllEffects)

```
public int stopAllEffects();
```

This method stops playing all the audio effects.

### Preload an Audio Effect (preloadEffect)

```
public int preloadEffect(int soundId, String filePath);
```

This method preloads a specific audio effect file (compressed audio file) to the memory.


> To ensure smooth communication, pay attention to the size of the audio effect file. Agora recommends using this method to preload the audio effect before calling `joinChannel`.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>filePath</td>
<td>Absolute path of the audio effect file.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Release an Audio Effect (unloadEffect)

```
public int unloadEffect(int soundId);
```

This method releases a specific preloaded audio effect from the memory.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Pause an Audio Effect (pauseEffect)

```
public int pauseEffect(int soundId);
```

This method pauses a specific audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>The ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Pause all Audio Effects (pauseAllEffects)

```
public int pauseAllEffects();
```

This method pauses all the audio effects.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Resume an Audio Effect (resumeEffect)

```
public int resumeEffect(int soundId);
```

This method resumes playing a specific audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Resume all Audio Effects (resumeAllEffects)

```
public int resumeAllEffects();
```

This method resumes all the audio effects.



<a id = "rtcengineeventhandler"></a>

### Callback Methods (IRtcEngineEventHandler)

**Developer Suite: io.agora.rtc**

The SDK uses the IRtcEngineEventHandler interface class to send callback event notifications to the application, and the application inherits the methods of this interface class to retrieve these event notifications.

All methods in this interface class have their (empty) default implementations, and the application can inherit only some of the required events instead of all of them. In the callback methods, the application should avoid time-consuming tasks or call blocking APIs (such as SendMessage), otherwise, the SDK may not work properly.

#### Join Channel Callback (onJoinChannelSuccess)

```
public void onJoinChannelSuccess(String channel,
                                 int uid,
                                 int elapsed);
```

This callback indicates that the user has successfully joined the specified channel with the channel ID and user ID assigned. The channel ID is assigned based on the channel name specified in join() API. If the User ID is not specified when join() is called, the server assigns one automatically.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>channel</td>
<td>The channel name.</td>
</tr>
<tr><td>uid</td>
<td><p>User ID.</p>
<p>If the uid is specified in the joinChannel method, it returns the specified ID; if not, it returns an ID that is automatically assigned by the Agora server.</p>
</td>
</tr>
<tr/>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this event occurs.</td>
</tr>
</tbody>
</table>



#### Rejoin Channel Callback (onRejoinChannelSuccess)

```
public void onRejoinChannelSuccess(String channel,
                                   int uid,
                                   int elapsed);
```

When the client loses connection with the server because of network problems, the SDK automatically attempts to reconnect, and then triggers this callback method upon reconnection.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>channel</td>
<td>Channel name.</td>
</tr>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this event occurs.</td>
</tr>
</tbody>
</table>

#### Warning Occurred Callback (onWarning)

```
public void onWarning(int warn);
```

This callback indicates that some warning occurred during SDK runtime of the SDK. In most cases, the application can ignore the warnings reported by the SDK because the SDK can usually fix the issue and resume running. For instance, the SDK may report an ERR_OPEN_CHANNEL_TIMEOUT warning upon disconnection with the server and attempts to reconnect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>warn</td>
<td>Warning Code.</td>
</tr>
</tbody>
</table>



#### Error Occurred Callback (onError)

```
public void onError(int err);
```

This callback indicates that a network or media error occurred during SDK runtime.

In most cases, reporting an error means that the SDK cannot fix the issue and resume running, and therefore requires actions from the application or simply informs the user on the issue. For instance, the SDK reports an ERR_START_CALL error when failing to initialize a call. In this case, the application informs the user that the call initialization failed and calls the leaveChannel method to exit the channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>err</td>
<td><p>Error codes:</p>
<ul>
<li>ERR_INVALID_VENDOR_KEY(101): Invalid App ID.</li>
<li>ERR_INVALID_CHANNEL_NAME(102): Invalid channel name.</li>
<li>ERR_LOOKUP_CHANNEL_REJECTED(105): Failed to look up the channel, because the server rejected the request.</li>
<li>ERR_OPEN_CHANNEL_REJECTED(107): Failed to join the channel, because the media server rejected the request.</li>
<li>ERR_LOAD_MEDIA_ENGINE(1001): Failed to load the media engine.</li>
<li>ERR_START_CALL(1002): Failed to turn on the local audio or video devices and thus failed to start a call.</li>
<li>ERR_START_CAMERA(1003): Failed to turn on the local camera.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr/>
<tr/>
<tr/>
<tr/>
</tbody>
</table>



#### API Call Executed Callback (onApiCallExecuted)

```
public void onApiCallExecuted(int error, String api, String result)
```

This callback is triggered when the API has been executed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>error</td>
<td>The error code that the SDK returns when the method call fails. If the SDK returns o, then the method has been called successfully.</td>
</tr>
<tr><td>api</td>
<td>The API that the SDK executes</td>
</tr>
<tr><td>result</td>
<td>The result of calling the API</td>
</tr>
</tbody>
</table>



#### Leave a Channel Callback (onLeaveChannel)

```
public void onLeaveChannel(RtcStats stats);
```

When the application calls the leaveChannel() method, the SDK uses this callback to notify the application that the user has successfully left the channel. With this callback function, the application retrieves information such as the call duration and the statistics of data received/transmitted by the SDK.Audio Quality Callback (onAudioQuality)

**Definition of RtcStats**

```
public static class RtcStats {
    public int totalDuration; // in seconds
    public int txBytes;
    public int rxBytes;
    public int txKBitRate;
    public int rxKBitRate;
    public int txAudioKBitRate;
    public int rxAudioKBitRate;
    public int txVideoKBitRate;
    public int rxVideoKBitRate;
    public int lastmileDelay;
    public int users;
    public double cpuTotalUsage;
    public double cpuAppUsage;
}
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>stats</td>
<td><p>Statistics of the call:</p>
<ul>
<li>totalDuration: Call duration in seconds, represented by an aggregate value.</li>
<li>txBytes: Total number of bytes transmitted, represented by an aggregate value.</li>
<li>rxBytes: Total number of bytes received, represented by an aggregate value.</li>
<li>txKBitRate: Transmission bitrate in kbit/s, represented by an instantaneous value.</li>
<li>rxKBitRate: Receive bitrate in kbit/s, represented by an instantaneous value.</li>
<li>txAudioKBitrate: Audio transmission bitrate in kbit/s, represented by an instantaneous value.</li>
<li>rxAudioKBitRate: Audio receive bitrate in kbit/s, represented by an instantaneous value.</li>
<li>txVideoKBitRate: Video transmission bitrate in kbit/s, represented by an instantaneous value.</li>
<li>rxVideoKBitRate: Video receive bitrate in kbit/s, represented by an instantaneous value.</li>
<li>lastmileDelay: The time delay in milliseconds from the Client to the VO Server</li>
<li>users: The instant number of users in the channel when the user leaves the channel.</li>
<li>puTotalUsage: System CPU usage (%).</li>
<li>cpuAppUsage: Application CPU usage (%).</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Audio Route Changed Callback (onAudioRouteChanged)

```
public void onAudioRouteChanged(int routing);
```

The SDK notifies the application that the audio route is changed after calling `setEnableSpeakerphone` successfully.

It notifies the current audio route is switched to an earpiece, a speakerphone, headset or Bluetooth device. The definition of `routing` is listed as follows:

```
public static final int AUDIO_ROUTE_DEFAULT = -1;
public static final int AUDIO_ROUTE_HEADSET = 0;
public static final int AUDIO_ROUTE_EARPIECE = 1;
public static final int AUDIO_ROUTE_HEADSETNOMIC = 2;
public static final int AUDIO_ROUTE_SPEAKERPHONE = 3;
public static final int AUDIO_ROUTE_LOUDSPEAKER = 4;
public static final int AUDIO_ROUTE_HEADSETBLUETOOTH = 5;
```

#### The State of the Microphone Has Changed Callback (onMicrophoneEnabled)

```
public void onMicrophoneEnabled(boolean enabled)
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>enabled</td>
<td>
	<ul>
		<li>true: The microphone is enabled.</li>
		<li>false: The microphone is disabled.</li>
	</ul>
	</td>
</tr>
</tbody>
</table>


#### Audio Quality Callback (onAudioQuality)

```
public void onAudioQuality(int uid,
                           int quality,
                           short delay,
                           short lost);
```

During a call, this callback is triggered once every two seconds to report on the audio quality of the current call. By default it is enabled.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>User ID of the speaker</td>
</tr>
<tr><td>quality</td>
<td><p>Rating of the audio quality:</p>
<ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</td>
</tr>
<tr><td>delay</td>
<td>Time delay in milliseconds.</td>
</tr>
<tr><td>lost</td>
<td>The packet loss rate(%).</td>
</tr>
</tbody>
</table>



#### Audio Volume Indication Callback (onAudioVolumeIndication)

```
public void onAudioVolumeIndication(AudioVolumeInfo[] speakers, int totalVolume);
```

This callback indicates who is speaking and the speaker’s volume.

By default, the indication is disabled. If needed, use the enableAudioVolumeIndication() method to configure it.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>speakers</td>
<td><p>The speakers (array). Each speaker ():</p>
<ul>
<li>uid: User ID of the speaker. The uid of the local user is 0.</li>
<li>volume: The volume of the speaker that ranges from 0 (lowest volume) to 255 (highest volume).</li>
</ul>
</td>
</tr>
<tr><td>totalVolume</td>
<td>Total volume after audio mixing that ranges from 0 (lowest volume) to 255 (highest volume).</td>
</tr>
</tbody>
</table>



In the returned speakers array:

-   If the uid is 0, that is, the local user is the speaker, the returned `volume` is the same as `totalVolumn`.

-   If the uid is not 0 and the volume is 0, it indicates that the user specified by the uid did not speak.

-   If a uid is contained in the previous speakers array but not in the present one, it indicates that the user specified by the uid did not speak.


#### Other User Joined the Channel Callback (onUserJoined)

```
public void onUserJoined(int uid, int elapsed);
```

This callback method notifies the application the broadcaster has joined the channel. If the broadcaster is already in the channel when the application joins the channel, the SDK also reports to the application on the broadcaster that is already in the channel.


> In the live broadcast scenario:
> -   The broadcaster can receive the callback when another broadcaster joins the channel.
> -   All the audience in the channel can receive the callback when the new broadcaster joins the channel.
> -   When a web application joins the channel, this callback is triggered as long as the web application publishes streams.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>elapsed</td>
<td>Time delay (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>



#### Other User is Offline Callback (onUserOffline)

```
public void onUserOffline(int uid, int reason);
```

This callback notifies the application that the broadcaster has left the channel or gone offline.

The SDK reads the timeout data to determine if a user has left the channel (or has gone offline). If no data package is received from the user in 15 seconds, the SDK takes assumes the user is offline. A poor network connection may lead to false detections; therefore, use signaling for reliable offline detection.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>reason</td>
<td><p>Reasons for the user going offline:</p>
<div><ul>
<li><strong>USER_OFFLINE_QUIT(0)</strong>: User has quit the call.</li>
<li><strong>USER_OFFLINE_DROPPED(1)</strong>: The SDK timed out and the user dropped offline because it has not received any data package for a period of time.</li>
<li><strong>USER_OFFLINE_BECOME_AUDIENCE</strong>: Triggered when the client role has changed from the broadcaster to the audience.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>


#### Other User Muted the Audio Callback (onUserMuteAudio)

```
public void onUserMuteAudio(int uid, boolean muted);
```

This callback indicates that some other user has muted/unmuted his/her audio stream.

> Currently, this callback returns invalid when the number of broadcasters in a channel exceeds 20, which will be improved in the future.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>muted</td>
<td><ul>
<li>true: User has muted his/her audio.</li>
<li>false: User has unmuted his/her audio.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### RtcEngine Statistics Callback (onRtcStats)

```
public void onRtcStats(RtcStats stats);
```

The SDK updates the application on the statistics of the RtcEngine runtime status once every two seconds.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>stats</td>
<td>Refer to the descriptions in <a href="#onleavechannel-live-android"><span>Leave a Channel Callback (onLeaveChannel)</span></a>.</td>
</tr>
</tbody>
</table>



#### Network Quality Callback (onLastmileQuality)

```
public void onLastmileQuality(int quality);
```

This callback reports the network quality of the local user. It is triggered once every 2 seconds after you have called `enableLastmileTest()`.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>quality</td>
<td><p>Quality of the last mile network:</p>
<div><ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>



#### Channel Network Quality Callback (onNetworkQuality)

```
public void onNetworkQuality(int uid, int txQuality, int rxQuality);
```

This callback is triggered every 2 seconds to update the application on the network quality of each user in a communication or live broadcast channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>User ID. The network quality of the user with this UID will be reported.
If uid is 0, it reports the local network quality.</td>
</tr>
<tr><td>txQuality</td>
<td><p>The transmission quality of the user:</p>
<div><ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</div>
</td>
</tr>
<tr><td>rxQuality</td>
<td><p>The receiving quality of the user:</p>
<div><ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>


#### Remote Video State Changed Callback (onRemoteVideoStateChanged)

```
public void onRemoteVideoStateChanged(int uid, int state)
```

This callback indicates that the state of the remote video has changed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>ID of the user whose remote video state has changed.</td>
</tr>
<tr><td>state</td>
<td><p>The state of the remote video:</p>
<ul>
<li>1: The remote video is normal.</li>
<li>2: The remote video is frozen.</li>
</ul>
</td>
</tr>
</tbody>
</table>

#### Connection Interrupted Callback (onConnectionInterrupted)

```
public void onConnectionInterrupted();
```

This method indicates that the SDK has lost connection with the server.

This method is triggered by a connection lost, while the onConnectionLost method (stated below) is triggered when the SDK attempts to reconnect after losing connection. Once the connection is lost, and if the application does not call leaveChannel, the SDK automatically tries to reconnect repeatedly.

#### Connection Lost Callback (onConnectionLost)

```
public void onConnectionLost();
```

This callback indicates that the SDK has lost connection with the network, and it has remained unconnected for a period of time (10 seconds by default) despite that it attempts to reconnect. It is also triggered when the SDK fails to join the channel 10 seconds after it calls joinChannel. The SDK will keep trying to reconnect after this callback is triggered. Upon reconnection, an onRejoinChannelSuccess callback will then be triggered.

#### Connection Banned Callback (onConnectionBanned)

```
public void onConnectionBanned();
```

This callback is triggered when your connection is banned by the Agora Server.


#### First Local Audio Frame Sent Callback (onFirstLocalAudioFrame)

```
public void onFirstLocalAudioFrame (int elapsed);
```

This callback is triggered when the first local audio frame is sent.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>

#### First Remote Audio Frame Received Callback (onFirstRemoteAudioFrame)

```
public void onFirstRemoteAudioFrame(int uid, int elapsed)
```

This callback method is triggered when the first remote audio frame is received.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>The UID of the remote user whose audio frame is received.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>


#### First Local Video Frame Sent Callback (onFirstLocalVideoFrame)

```
public void onFirstLocalVideoFrame (int width, int height, int elapsed);
```

This callback is triggered when the first local video frame is sent.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>width</td>
<td>Width (pixels) of the video stream.</td>
</tr>
<tr><td>height</td>
<td>Height (pixels) of the video stream.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>


#### First Remote Video Frame Displayed Callback (onFirstRemoteVideoFrame)

```
public void onFirstRemoteVideoFrame(int uid, int width, int height, int elapsed);
```

This method is triggered when the first frame of the remote video appears in the user’s video window. The application can retrieve the data of time elapsed from user joining the channel until the first video frame is displayed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID of the user whose video streams are received.</td>
</tr>
<tr><td>width</td>
<td>Width (pixels) of the video stream.</td>
</tr>
<tr><td>height</td>
<td>Height (pixels) of the video stream.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>

#### First Remote Video Frame Received and Decoded Callback (onFirstRemoteVideoDecoded)

```
public void onFirstRemoteVideoDecoded(int uid, int width, int height, int elapsed);
```

This callback is triggered upon receiving and successfully decoding the first frame of the remote video. The application can configure the user view settings in this callback.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID of the user whose video streams are received.</td>
</tr>
<tr><td>width</td>
<td>Width (pixels) of the video stream.</td>
</tr>
<tr><td>height</td>
<td>Height (pixels) of the video stream.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>


#### Other User Paused/Resumed Audio Callback (onUserMuteAudio)

```
public void onUserMuteAudio(int uid, boolean muted);
```

This callback indicates that some other user has paused/resumed his/her audio stream.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>muted</td>
<td><ul>
<li>true: User has paused his/her audio.</li>
<li>false: User has resumed his/her audio.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Other User Paused/Resumed Video Callback (onUserMuteVideo)

```
public void onUserMuteVideo(int uid, boolean muted);
```

This callback indicates that some other user has paused/resumed his/her video stream.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>muted</td>
<td><ul>
<li>true: User has paused his/her video.</li>
<li>false: User has resumed his/her video.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Other User Enabled/Disabled Video Callback (onUserEnableVideo)

```
public void onUserEnableVideo(int uid, boolean enabled);
```

This callback indicates that some other user has enabled/disabled the video function. Disabling the video function means that the user can only use voice call, can neither show/send their own videos nor receive or display videos from other people.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>enabled</td>
<td><ul>
<li>true: The user has enabled the video function and can enter a video call or video live broadcast.</li>
<li>false: The user has disabled the video function and can only enter a voice session where the user can neither send or receive any video streams.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Other User Enabled/Disabled Local Video Callback (onUserEnableLocalVideo)

```
public void onUserEnableLocalVideo(int uid, boolean enabled)
```

This callback indicates that some other user has enabled/disabled the local video function.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>enabled</td>
<td><ul>
<li>true: The user has enabled the local video function. Other users in the channel can see the video of this user.</li>
<li>false: the user has disabled the local video function. Other users in the channel can no longer receive the video stream from this user, while this user can still receive the video streams from other users.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Local Video Statistics Callback (onLocalVideoStats)

```
public void onLocalVideoStats(LocalVideoStats stats) {
};
```

The SDK updates the application on the statistics of uploading local video streams once every two seconds.

**Definition of LocalVideoStats**

```
public static class LocalVideoStats {
    public int sentBitrate;
    public int sentFrameRate;
}
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>stats</td>
<td><p>The statistics of the local video, including:</p>
<ul>
<li>sentBitrate: Data sending bitrate (kbit/s) since last count.</li>
<li>sentFrameRate: Data sending frame rate (fps) since last count.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>


#### Remote Video Statistics Callback (onRemoteVideoStats)

```
public void onRemoteVideoStats(RemoteVideoStats stats) {
};
```

The SDK updates the application on the statistics of receiving remote video streams for each host once every 2 seconds. If there are muptiple remote hosts, this callback is triggered for multiple times every 2 seconds.

**Definition of RemoteVideoStats**

```
public static class RemoteVideoStats {
       public int uid;
       public int delay;
       public int width;
       public int height;
       public int receivedBitrate;
       public int receivedFrameRate;
       public int rxStreamType;
 }
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>stats</td>
<td><p>The statistics of the remote video, including:</p>
<div><ul>
<li>uid: User ID of the user whose video streams are received.</li>
<li>delay: Time delay (ms).</li>
<li>width: Width of the remote video.</li>
<li>height: Height of the remote video.</li>
<li>receivedBitrate: Data receiving bitrate (kbit/s).</li>
<li>receivedFrameRate: Data receiving frame rate (fps).</li>
<li>rxStreamType: High Video Stream or Low Video Stream.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>

#### Camera Ready Callback (onCameraReady)

```
public void onCameraReady();
```

This callback indicates that the camera is turned on and ready to capture video. If the camera fails to turn on, handle the error in the onError() method.

#### Video Stopped Callback (onVideoStopped)

```
public void onVideoStopped();
```

This callback indicates that the video has stopped. The application can use this callback to change the configuration of the view (for example, displaying other pictures on the view) after the video stops.


#### Data Stream Received Callback (onStreamMessage)

```
public void onStreamMessage(int uid, int streamId, byte[] data);
```

This callback indicates that the local user has received the data stream from the other user within five seconds.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>streamId</td>
<td>Stream ID</td>
</tr>
<tr><td>data</td>
<td>The data received by the recipients.</td>
</tr>
</tbody>
</table>



#### Data Stream Sent Failure Callback (onStreamMessageError)

```
public void onStreamMessageError(int uid, int streamId, int error, int missed, int cached);
```

This callback indicates that the local user has not received the data stream from the other user within five seconds.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>streamId</td>
<td>Stream ID</td>
</tr>
<tr><td>error</td>
<td><ul>
<li>ERR_OK = 0, No error</li>
<li>ERR_NOT_IN_CHANNEL=113, the user is not in a channel</li>
<li>ERR_BITRATE_LIMIT=115, limited bitrate</li>
</ul>
<p>For more error code descriptions, see <a href="/en/Interactive%20Gaming/the_error_game"><span>Error Codes and Warning Codes</span></a></p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>missed</td>
<td>The number of lost messages</td>
</tr>
<tr><td>cached</td>
<td>The number of incoming cached messages when the data stream is interrupted.</td>
</tr>
</tbody>
</table>


#### Active Speaker Detected Callback (onActiveSpeaker)

```
public void onActiveSpeaker(int uid);
```

If you used the `enableAudioVolumeIndication` API, this callback is triggered when the volume detecting unit detects an active speaker in the channel, and returns the uid of the active speaker.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>uid</td>
<td>The UID of the active speaker. By default, 0 is the local user. You can also add relative functions on your app, for example, the active speaker, once detected, will have his/her head portrait zoomed in.</td>
</tr>
</tbody>
</table>


> -   You need to call `enableAudioVolumeIndication` to receive this callback.
> -   The active speaker has the uid of the speaker who speaks at the highest volume during a certain period of time.


#### Token Expired Callback (onRequestToken)

```
public void onRequestToken();
```

If a Token is specified when calling joinChannel, and due to Token will be expired after a certain amount of time, and if SDK lost the connection with the Agora server out of network issues, it might need a new Token to reconnect to the server.

This callback notifies the application of generating a new Token, and calling renewtoken to specify the newly generated Token.

This function was previously provided in the callback report of onError(): ERR_TOKEN_EXPIRED(109), ERR_INVALID_TOKEN(110). Starting from v1.7.3, the old method is still working, but it is recommended for you to put the related logic in this callback.

#### Audio Mixing File Playback Finished Callback (onAudioMixingFinished)

```
public void onAudioMixingFinished();
```

This callback is triggered when the audio mixing file playback is finished after calling `startAudioMixing`. If you failed to execute the `startAudioMixing` method, it returns the error code in the `onError` callback.

#### Local Audio Effect Playback Finished Callback (onAudioEffectFinished)

```
public void onAudioEffectFinished(int soundId)
```

This callback is triggered when the local audio effect playback is finished.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
</tbody>
</table>



#### User Role Changed Callback (onClientRoleChanged)

```
public void onClientRoleChanged(int oldRole, int newRole);
```

This callback is triggered when the user role is switched, for example, from a host to an audience or vice versa.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>oldRole</td>
<td>Role that you switched from.</td>
</tr>
<tr><td>newRole</td>
<td>Role that you switched to.</td>
</tr>
</tbody>
</table>

#### Camera Focus Area Changed (onCameraFocusAreaChanged)

```
public void onCameraFocusAreaChanged (Rect rect){};

This callback is triggered when the camera focus area has changed.
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>rect</td>
<td>The rectangle area in the camera zoom that specifies the focus area</td>
</tr>
</tbody>
</table>


#### Video Size Changed Callback (onVideoSizeChanged)

```
public void onVideoSizeChanged(int uid, int width, int height, int rotation)
```

This callback indicates that the size of the video frame has changed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Parameter</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>width</td>
<td>Width (pixels) of the video frame.</td>
</tr>
<tr><td>height</td>
<td>Height (pixels) of the video frame.</td>
</tr>
<tr><td>rotation</td>
<td>New rotational angle of the video. Can be 0, 90, 180, or 270. It is set as 0 by default.</td>
</tr>
</tbody>
</table>


## C++ Interface

<a id = "irtcengine"></a>
### Basic Methods (IRtcEngine)

**agora::IRtcEngine** is the basic interface class of Agora Native SDK. Creating an agora::IRtcEngine object and then calling the methods of this object enables the use of Agora Native SDK’s communication functionality. In the previous versions this class is named as IAgoraAudio, and it is renamed to agora::IRtcEngine from version 1.0.

#### Create an agora::IRtcEngine Object (create)

```
agora::rtc::IRtcEngine* AGORA_CALL createAgoraRtcEngine();
```

This method creates an IRtcEngine object. Unless otherwise specified, all called methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling the interface methods in the same thread. Unless otherwise specified, the following rule applies to all APIs whose return values are integer types: A return value of 0 indicates that the call was successful, and a return value less than 0 indicates that the call failed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td>An agora::IRtcEngine object.</td>
</tr>
</tbody>
</table>



#### Initialize (initialize)

```
virtual int initialize(const RtcEngineContext& context) = 0;
```

This method initializes the Agora SDK service. Enter the Agoran App ID issued to developers to start initialization. After creating an `agora::IRtcEngine` object, call this method to initialize service before using any other methods. After initialization, the service is set to audio mode by default. To enable video mode, call enableVideo API afterwards.

The definition of RTCEngineContext is：

```
struct RtcEngineContext
{
    IRtcEngineEventHandler* eventHandler;
    /** App ID issued to the developers by Agora. Apply for a new one from Agora if it is missing from your kit.
    */
    const char* appId;
    RtcEngineContext()
    :eventHandler(NULL)
    ,appId(NULL)
    {}
};
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>appID</td>
<td>App ID issued to application developers by Agora. Apply for a new one from Agora if the key is missing from your kit. See <a href="/en/Voice/token"><span>Getting an App ID</span></a> for more information to how to get an App ID.</td>
</tr>
<tr><td>eventHandler</td>
<td>IRtcEngineEventHandler is an abstract class that provides default implementations. The SDK uses this class to report to the application on SDK runtime events.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
<li>ERR_INVALID_VENDOR_KEY(-101): The entered App ID is invalid.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Set a Channel Profile (setChannelProfile)

```
virtual int setChannelProfile(CHANNEL_PROFILE_TYPE profile) = 0;
```

This method configures the channel profile. The Agora RtcEngine needs to know what scenario the application is in to apply different methods for optimization.

The Agora Native SDK supports the following profiles:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Profile</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Communication</td>
<td>Default setting. This is used in one-on-one calls, where all users in the channel can talk freely.</td>
</tr>
<tr><td>Live Broadcast</td>
<td>Live Broadcast. Host and audience roles that can be set by calling setClientRole.  The host sends and receives voice, while the audience receives voice only with the sending function disabled.</td>
</tr>
<tr><td>Gaming</td>
<td>Gaming Mode. Any user in the channel can talk freely. This mode uses the codec with low-power consumption and low bitrate by default.</td>
</tr>
</tbody>
</table>


> -   Only one profile can be used at the same time in the same channel. If you want to switch to another profile, use `release` to destroy the current Engine and create a new one using `create` and `initialize` before calling this method to set the new channel profile.
> -   Make sure that different App IDs are used for different channel profiles.
> -   This method must be called and configured before a user joining a channel, because the channel profile cannot be configured when the channel is in use.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>profile</td>
<td><p>The channel profile. Choose one of the following:</p>
<div><ul>
<li>CHANNEL_PROFILE_COMMUNICATION = 0: Communication (default)</li>
<li>CHANNEL_PROFILE_LIVE_BROADCASTING = 1: Live Broadcast</li>
<li>CHANNEL_PROFILE_GAME = 2: Gaming</li>
</ul>
</div>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the User Role (setClientRole)

```
virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;
```

In a live-broadcast channel, this method allows you to:
* Set the user role as a host or an audience (default) before joining a channel;
* Switch the user role after joining a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>role</td>
<td><p>The user role in a live broadcast:</p>
<ul>
<li>CLIENT_ROLE_BROADCASTER = 1; Host</li>
<li>CLIENT_ROLE_AUDIENCE = 2; Audience(default)</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: The Method is called successfully</li>
<li>&lt;0: Failed to call the method</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Enable the Audio Mode (enableAudio)

```
virtual int enableAudio() = 0;
```

This method enables the audio mode. This function is enabled by default.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> This method sets to enable the internal engine, and still works after `leaveChannel` is called.


#### Disables/Re-enables the Local Audio Function (enableLocalAudio)

```
virtual int enableLocalAudio(bool enabled) = 0;
```

When an App joins a channel, the audio function is enabled by default. This method disables or re-enables the local audio function, that is, to stop or restart local audio capturing and handling.
This method does not affect receiving or playing the remote audio streams, and is applicable to scenarios where the user wants to receive the remote audio streams without sending any audio stream to other users in the channel.
The `onMicrophoneEnabled` callback function will be triggered once the local audio function is disabled or re-enabled.

> - Call this method after `joinChannel`.
> - This method is different from `muteLocalAudioStream`:
>   * `enableLocalAudio`: Disables/Re-enables the local audio capturing and handling.
>   * `muteLocalAudioStream`: Stops/Continues sending the local audio streams.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>enabled</td>
<td>
<ul>
<li>true: Re-enable the local audio function, that is, to start local audio capturing and handling.</li>
<li>false: Disable the local audio function, that is, to stop local audio capturing and handling.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Success</li>
<li>&lt;0: Failure</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Disable the Audio Mode (disableAudio)

```
virtual int disableAudio() = 0;
```

This method disables the audio mode.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> This method sets to disable the internal engine, and still works after `leaveChannel` is called.

#### Set the Audio Profile (setAudioProfile)

```
virtual int setAudioProfile(AUDIO_PROFILE_TYPE profile, AUDIO_SCENARIO_TYPE scenario) = 0;
```

This method sets the audio parameters and application scenarios.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>profile</td>
<td><p>Sets the sampling rate, bitrate, encode mode, and the number of channels:</p>
<ul>
<li>AUDIO_PROFILE_SPEECH_STANDARD = 1: Specifies the sampling rate as 32 kHz, audio encoding, single channel, and bitrate up tp 18 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_STANDARD = 2: Specifies the sampling rate as 48 kHz, music encoding, single channel, and bitrate up to 48 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_STANDARD_STEREO = 3: Specifies the sampling rate as 48 kHz, music encoding, dual-channel, and bitrate up to 56 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_HIGH_QUALITY = 4: Specifies the sampling rate as 48 kHz, music encoding, single channel, and bitrate up to 128 kbit/s</li>
<li>AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO = 5: Specifies the sampling rate as 48 kHz, music encoding, dual-channel, and bitrate up to 192 kbit/s</li>
</ul>
</td>
</tr>
<tr><td>scenario</td>
<td><p>Sets the audio application scenarios:</p>
<ul>
<li>AUDIO_SCENARIO_DEFAULT = 0: default</li>
<li>AUDIO_SCENARIO_CHARROOM_ENTERTAINMENT = 1: Applicable to the entertainment scenario that supports voice during gameplay</li>
<li>AUDIO_SCENARIO_EDUCATION = 2: Applicable to the education scenario that prioritizes fluency and stability</li>
<li>AUDIO_SCENARIO_GAME_STREAMING = 3: Applicable to the live gaming scenario that needs to enable the gaming audio effects in the speaker mode in a live broadcast scenario</li>
<li>AUDIO_SCENARIO_SHOWROOM = 4: Applicable to the showroom scenario that optimizes the audio quality with professional external equipment</li>
<li>AUDIO_SCENARIO_CHATROOM_GAMING = 5: Applicable to the gaming scenario</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>


> -   Use this method before `joinChannel`, else it does not work.
> -   In the communication mode, setting `profile` works, but not `scenario`.
> -   In the communication and live-broadcast mode, the bitrate may be different from your settings due to network self-adaptation.
> -   In scenarios with music teaching, Agora recommends setting `profile` as MUSIC_HIGH_QUALITY(4) and `scenario` as GAME_STREAMING(3).
> -   CHATROOM_ENTERTAINMENT(1) and CHATROOM_GAMING(5) are recommended for audio-only scenarios.


#### Set High-quality Audio Preferences (setHighQualityAudioParameters)

```
int setHighQualityAudioParameters(boolean fullband, boolean stereo, boolean fullBitrate)
```

This method sets high-quality audio preferences. Call this method and set all the three modes before joining a channel. Do **NOT** call this method again after joining a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>fullband</td>
<td><p>Full-band codec (48 kHz sampling rate), not compatible with versions before v1.7.4.</p>
<ul>
<li>True: Enable full-band codec.</li>
<li>False: Disable full-band codec.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>stereo</td>
<td><p>Stereo codec, not compatible with versions before v1.7.4.</p>
<ul>
<li>True: Enable stereo codec.</li>
<li>False: Disable stereo codec.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>fullBitrate</td>
<td><p>High bitrate. Recommended in voice-only mode.</p>
<ul>
<li>True: Enable high bitrate mode.</li>
<li>False: Disable high bitrate mode.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>

> Agora does not recommend using this method. If you want to set the audio profile, see `setAudioProfile`.

#### Join a Channel (joinChannel)

```
virtual int joinChannel(const char* token, const char* channelId, const char* info, uid_t uid) = 0;
```

This method allows a user to join a channel. Users in the same channel can talk to each other; and multiple users in the same channel can start a group chat. Users using different App IDs cannot call each other. Once in a call, the user must call the leaveChannel method to exit the current call before entering another channel.

> A channel does not accept duplicate UIDs, such as two users with the same UID. If your app supports logging in a user from different devices at the same time, ensure that you use different UIDs. For example, if you already used the same UID, make the UIDs different by adding the respective device ID to the UID. This is not applicable if your app does not support a user logging in from different devices at the same time. In this case, when you log in a new device, you will be logged out from the other device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>token</td>
<td><p>A Token generated by the application.</p>
<p>This parameter is optional if the user uses a static key, or App ID. In this case, pass NULL as the parameter value.</p>
<p>If the user uses a Channel key, Agora issues an additional App Certificate to the developers. The developers can then generate a user key using the algorithm and App Certificate provided by Agora for user authentication on the server.</p>
<p>In most circumstances, the static App ID will suffice. For added security, use the Channel Key.</p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>channel</td>
<td><p>A string providing the unique channel name for the AgoraRTC session. The length must be within 64 bytes.</p>
<p>The following is the supported scope: a-z, A-Z, 0-9, space, ! #$%&amp;, ()+, -, :;&lt;=., &gt;? @[], ^_, {|}, ~</p>
</td>
</tr>
<tr/>
<tr><td>info</td>
<td>(Optional) Additional information about the channel that developers need to add. <sup>[1]</sup> It can be set as a NULL String or channel related information. Other users in the channel will not receive this message.</td>
</tr>
<tr><td>uid</td>
<td>(Optional) User ID: A 32-bit unsigned integer ranging from 1 to (2^32-1). It must be unique. If not assigned (or set to 0), the SDK assigns one and returns it in the onJoinChannelSuccess callback. Your app must record and maintain the returned value, as the SDK does not maintain it.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid.</li>
<li>ERR_NOT_READY (-3): Initialization failed.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
</tbody>
</table>


> [1] For example, when a host wants to customize the resolution and bitrate for a live broadcast channel with CDN Live enabled, they can include them in this parameter in JSON format. For example, \{“owner”:true, …, “width”:300, “height”:400, “bitrate”:100\}. Only when neither `width`, `height`, and `bitrate` is 0 can the bitrate and resolution settings take effect.

#### Leave a Channel (leaveChannel)

```
virtual int leaveChannel() = 0;
```

This method allows a user to leave a channel, such as hanging up or exiting a call.

After joining a channel, the user must call the leaveChannel method to end the call before joining another one. The leaveChannel method releases all resources related to the call. The leaveChannel method is called asynchronously, and the user has not actually left the channel when the call returns. Once the user leaves the channel, the SDK triggers the onLeaveChannel callback.


> If you call `release()` immediately after you call `leaveChannel`, it will interrupt the `leavechannel` process, and the SDK will not trigger the `onLeaveChannel` callback.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_REFUSED (-5): Failed to leave the channel, reasons being that the user is not currently in a call or is in the process of leaving the channel.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>

#### Set the Local Voice Pitch (setLocalVoicePitch)

```
int setLocalVoicePitch(double pitch);
```

This method changes the voice pitch of the local speaker.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>pitch</td>
<td>Voice frequency, in the range of [0.5, 2.0]. The default value is 1.0.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>

#### Sets the Voice Position of the Remote user (setRemoteVoicePosition)

```
virtual int setRemoteVoicePosition(int uid, double pan, double gain) = 0;
```

This method sets the voice position of the remote user.

> This API is valid only for earphones, and is invalid when the speakerphone is enabled.

<table>
<colgroup>
<col>
</col>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td><p>User ID of the remote user</p>
</td></tr>
<tr><td>pan</td>
<td><p>Sets whether to change the spatial position of the audio effect. The range is [-1, 1]:</p>
<ul>
<li>0: The audio effect shows right ahead.</li>
<li>-1: The audio effect shows on the left.</li>
<li>1: The audio effect shows on the right.</li>
</ul>
</td>
</tr>
<tr><td>gain</td>
<td><p>Sets whether to change the volume of a single audio effect. The range is [0.0, 100.0]. The default value is 100.0. The smaller the number is, the lower the volume of the audio effect.</p>
</td></tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Success</li>
<li>&lt; 0: Failure</li>
</ul>
</td>
</tr>
</tbody>
</table>

#### Sets to Voice-only Mode (setVoiceOnlyMode)

```
virtual int setVoiceOnlyMode(bool enable) = 0;
```

This method sets to voice-only mode (transmit the audio stream only), and the other streams will be ignored; for example the sound of the keyboard strokes.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>enable</td>
<td>
<ul>
<li>true: Enable voice-only mode.</li>
<li>false: Disable voice-only mode.</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Success</li>
<li>&lt; 0: Failure</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Set the Local Voice Equalization (setLocalVoiceEqualization)

```
int setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, int bandGain);
```

This method sets the local voice equalization effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>bandFrequency</td>
<td>The band frequency ranging from 0 to 9, representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 500, 1k, 2k, 4k, 8k, and 16k Hz.</td>
</tr>
<tr><td>bandGain</td>
<td>Gain of each band in dB; ranging from -15 to 15.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the Local Voice Reverberation (setLocalVoiceReverb)

```
int setLocalVoiceReverb(AUDIO_REVERB_TYPE reverbKey, int value)
```

This method sets local voice reverberation.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>reverbKey</td>
<td>The reverberation key. This method contains five reverberation keys. For details, see the description of each value:</td>
</tr>
<tr><td>value</td>
<td><ul>
<li>AUDIO_REVERB_DRY_LEVEL = 0, (dB, [-20,10]), level of the dry signal</li>
<li>AUDIO_REVERB_WET_LEVEL = 1, (dB, [-20,10]), level of the early reflection signal (wet signal)</li>
<li>AUDIO_REVERB_ROOM_SIZE = 2, ([0, 100]), room size of the reflection</li>
<li>AUDIO_REVERB_WET_DELAY = 3, (ms, [0, 200]), length of the initial latency of the wet signal in ms</li>
<li>AUDIO_REVERB_STRENGTH = 4, ([0, 100]), length of the late reverberation</li>
</ul>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Get the Audio Effect Volume (getEffectsVolume)

```
int getEffectsVolume();
```

This method gets the volume of the audio effects from 0.0 to 100.0.

#### Set the Audio Effect Volume (setEffectsVolume)

```
int setEffectsVolume(int volume);
```

This method sets the volume of the audio effects from 0.0 to 1.0.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>volume</td>
<td>The value ranges from 0.0 to 100.0. 100.0 is the default value.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Adjust the Audio Effect Volume in Real Time (setVolumeOfEffect)

```
int setVolumeOfEffect(int soundId, int volume);
```

This method adjusts the volume of the specified sound effect in real time.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>volume</td>
<td>The value ranges from 0.0 to 100.0. 100.0 is the default value.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt; 0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Play the Audio Effect (playEffect)

```
int playEffect(int soundId, const char* filePath, int loopCount, double pitch, double pan, int gain, bool publish)
```

This method plays the specified audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the specified audio effect. Each audio effect has a unique ID <sup>[2]</sup></td>
</tr>
<tr><td>filePath</td>
<td>The absolute path of the audio effect file</td>
</tr>
<tr><td>loopCount</td>
<td><p>Set the number of times looping the audio effect</p>
<div><ul>
<li>0: Play the audio effect once</li>
<li>1: Play the audio effect twice</li>
<li>-1: Play the audio effect in a loop indefinitely, until <code>stopEffect</code> or <code>stopAllEffects</code> is called</li>
</ul>
</div>
</td>
</tr>
<tr><td>pitch</td>
<td>Set whether to change the pitch of the audio effect. The range is [0.5, 2].
The default value is 1, which means no change to the pitch. The smaller the value, the lower the pitch.</td>
</tr>
<tr><td>pan</td>
<td><p>Spatial position of the local audio effect. The range is [-1.0, 1.0]</p>
<div><ul>
<li>0.0: The audio effect shows ahead</li>
<li>1.0: The audio effect shows on the right</li>
<li>-1.0: The audio effect shows on the left</li>
</ul>
</div>
</td>
</tr>
<tr><td>gain</td>
<td>Volume of the audio effect. The range is [0.0, 100,0]
The default value is 100.0. The smaller the value, the lower the volume of the audio effect</td>
</tr>
<tr><td>publish</td>
<td><p>Set whether to publish the specified audio effect to the remote stream:</p>
<div><ul>
<li>true: The audio effect, played locally, is published to the Agora Cloud and the remote users can hear it</li>
<li>false: The audio effect, played locally, is not published to the Agora Cloud and the remote users cannot hear it</li>
</ul>
</div>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



> [2] If you preloaded the audio effect into the memory through `preloadEffect`, ensure that the `soundID` value is set to the same value as in `preloadEffect` 

#### Stop Playing an Audio Effect (stopEffect)

```
int stopEffect(int soundId);
```

This method stops playing a specific audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop Playing all Audio Effects (stopAllEffects)

```
int stopAllEffects();
```

This method stops playing all the audio effects.

#### Preload an Audio Effect (preloadEffect)

```
int preloadEffect(int soundId, String filePath);
```

This method preloads a specific audio effect file (compressed audio file) to the memory.


> To ensure smooth communication, pay attention to the size of the audio effect file. Agora recommends using this method to preload the audio effect before calling `joinChannel`.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>filePath</td>
<td>Absolute path of the audio effect file.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Release an Audio Effect (unloadEffect)

```
int unloadEffect(int soundId);
```

This method releases a specific preloaded audio effect from the memory.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Pause an Audio Effect (pauseEffect)

```
int pauseEffect(int soundId);
```

This method pauses a specific audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Pause all Audio Effects (pauseAllEffects)

```
int pauseAllEffects();
```

This method pauses all the audio effects.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Resume an Audio Effect (resumeEffect)

```
int resumeEffect(int soundId);
```

This method resumes playing a specific audio effect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Resume Playing all Audio Effects (resumeAllEffects)

```
int resumeAllEffects();
```

This method resumes playing all the audio effects.


#### Enable Web SDK Interoperability (enableWebSdkInteroperability)

```
int enableWebSdkInteroperability(bool enabled);
```

This method enables interoperability with the Agora Web SDK.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>enabled</td>
<td><p>Whether to enable the interoperability with the Agora Web SDK is enabled:</p>
<ul>
<li>True: Enable the interoperability</li>
<li>False: Disable the interoperability</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Enable Built-in Encryption and Set the Encryption Secret (setEncryptionSecret)

```
virtual int setEncryptionSecret(const char* secret) = 0;
```

Use setEncryptionSecret to specify an encryption password to enable built-in encryption before joining a channel. All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user has left the channel. If the encryption password is not specified or set to empty, the encryption function will be disabled.


> Do not use this function together with CDN.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>secret</td>
<td>Encryption Password</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Set the Built-in Encryption Mode (setEncryptionMode)

```
virtual int setEncryptionMode(const char* encryptionMode) = 0;
```

AThe Agora Native SDK supports built-in encryption, which is in AES-128-XTS mode by default. If you want to use other modes, call this API to set the encryption mode.

All users in the same channel must use the same encryption mode and password. Refer to information related to the AES encryption algorithm on the differences between encryption modes.

Call setEncryptionSecret to enable the built-in encryption function before calling this API.


> Do not use this function together with CDN

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>encryptionMode</td>
<td><p>Encryption mode. The following modes are currently supported:</p>
<ul>
<li>“aes-128-xts”:128-bit AES encryption, XTS mode</li>
<li>“aes-128-ecb”:128-bit AES encryption, ECB mode</li>
<li>“aes-256-xts”: 256-bit AES encryption, XTS mode</li>
<li>“”: When it is set to NUL string, the encryption is in “aes-128-xts” by default.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Create a Data Stream (createDataStream)

```
virtual int createDataStream(int* streamId, bool reliable, bool ordered) = 0;
```

This method creates a data stream. Each user can only have up to five data channels at the same time.


> Set `reliable` and `ordered` both as True or both as False. Do not set one as *True* and the other as *False*.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>reliable</td>
<td><ul>
<li>True: The recipients will receive data from the sender within 5 seconds. If the recipient does not receive the sent data within 5 seconds, the data channel will report an error to the application.</li>
<li>False: The recipients may not receive any data, and the SDK will not report any error upon data missing.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>ordered</td>
<td><ul>
<li>True: The recipients will receive data in the order of the sender.</li>
<li>False: The recipients will not receive data in the order of the sender.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>&lt;0: Returns an error code when it fails to create the data stream. <sup>[4]</sup></li>
<li>&gt;0: Returns the Stream ID when the data stream is created.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>

> [4] The error code is related to the positive integer displayed in [Error Codes and Warning Codes](/en/Interactive%20Gaming/the_error_game), for example, if it returns -2, then it indicates 2: ERR_INVALID_ARGUMENT in [Error Codes and Warning Codes](/en/Interactive%20Gaming/the_error_game).

#### Send a Data Stream (sendStreamMessage)

```
virtual int sendStreamMessage(int streamId, const char* data, size_t length) = 0;
```

This method sends data stream messages to all users in a channel. Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB. The API controls the data channel transfer rate. Each client can send up to 6 kB of data per second. Each user can have up to five data channels simultaneously.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>streamId</td>
<td>Stream ID returned by createDataStream</td>
</tr>
<tr><td>data</td>
<td>Data to be sent</td>
</tr>
<tr><td>Return Value</td>
<td><p>When it fails to send the message, the following error code will be returned:</p>
<p>ERR_SIZE_TOO_LARGE/ERR_TOO_OFTEN/ERR_BITRATE_LIMIT</p>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Start an Audio Call Test (startEchoTest)

```
virtual int startEchoTest() = 0;
```

This method launches an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly. In the test, the user first speaks, and the recording is played back in 10 seconds. If the user can hear the recording in 10 seconds, it indicates that the audio devices and network connection work properly.


> -   After calling the startEchoTest method, call stopEchoTest to end the test; otherwise, the application cannot run the next echo test, nor can it call the `joinChannel` method to start a new call.
> -   This method is applicable only when the user role is broadcaster. If you switch the channel mode from communication to live broadcast, ensure that `setClientRole` is called to change the user role from audience(default in the live broadcast mode) to broadcaster before using this method.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_REFUSED (-5): Failed to launch the echo test, for example, initialization failed.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>



#### Stop an Audio Call Test (stopEchoTest)

```
virtual int stopEchoTest() = 0;
```

This method stops an audio call test.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_REFUSED(-5): Failed to stop the echo test. It could be that the echo test is not running.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>



#### Enable the Network Test (enableLastmileTest)

```
virtual int enableLastmileTest() = 0;
```

This method tests the quality of the user’s network connection and is disabled by default.

This method is mainly used in two scenarios:

-   Before users join a channel, this method can be called to check the uplink network quality.

-   Before the audience in a channel switch to a host role, this method can be called to check the uplink network quality.


In both scenarios, calling this method consumes extra network traffic, which affects the communication quality.

Call disableLastmileTest to disable it immediately once the users have received the onLastmileQuality callback before they join the channel or switch the user role.


> For current hosts, do not call this method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Disable the Network Test (disableLastmileTest)

```
virtual int disableLastmileTest() = 0;
```

This method disables the network connection quality test.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Retrieve the Current Call ID (getCallId)

```
virtual int getCallId(agora::util::AString& callId) = 0;
```

When a user joins a channel on a client, a CallId is generated to identify the call from the client. Some methods such as rate and complain need to be called after the call ends in order to submit feedback to the SDK. These methods require assigned values of the CallId parameters. To use these feedback methods, call the getCallId method to retrieve the CallId during the call, and then pass the value as an argument in the feedback methods after the call ends.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>callId</td>
<td>The current call ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Rate the Call (rate)

```
virtual int rate(const char* callId, int rating, const char* description) = 0;
```

This method lets the user rate the call. It is usually called after the call ends.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>callId</td>
<td>Call ID retrieved from the getCallId method.</td>
</tr>
<tr><td>rating</td>
<td>The rating for the call between 1 (lowest score) to 10 (highest score).</td>
</tr>
<tr><td>description</td>
<td><p>A given description for the call with a length less than 800 bytes.</p>
<p>This parameter is optional.</p>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid, for example, callId invalid.</li>
<li>ERR_NOT_READY (-3): The SDK status is incorrect, for example, initialization failed.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
</tbody>
</table>



#### Complain about the Call Quality (complain)

```
virtual int complain(const char* callId, const char* description) = 0;
```

This method allows the user to complain about the call quality. It is usually called after the call ends.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>callId</td>
<td>Call ID retrieved from the getCallId method.</td>
</tr>
<tr><td>description</td>
<td><p>A given description of the call with a length less than 800 bytes.</p>
<p>This parameter is optional.</p>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
<li>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid, for example, callId invalid.</li>
<li>ERR_NOT_READY (-3): The SDK status is incorrect, for example, initialization failed.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
</tbody>
</table>

#### Renew Token (renewtoken)

```
virtual int renewToken(const char* token) = 0;
```

This method updates the Channel Key.

The key expires after a certain period of time once the Token schema is enabled. When:

-   The `onError` callback reports the error ERR_TOKEN_EXPIRED(109), or

-   The `onRequestToken` callback reports the error ERR_TOKEN_EXPIRED(109)


The application should retrieve a new key and then call this method to renew it. Failure to do so will result in the SDK disconnecting with the server.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>token</td>
<td>Specifies the Channel Key to be renewed.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Specify a Log File (setLogFile)

```
int setLogFile(const char* filePath);
```

This method specifies an SDK output log file. The log file records all the log data of the SDK’s operation. Ensure that the directory to save the log file exists and is writable.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>filePath</td>
<td>File path of the log file. The string of the log file is in UTF-8 code.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


> The default log file location is at: C:Users<user_name\>AppDataLocalAgora<process_name\>.

#### Set the Log Filter (setLogFilter)

```
int setLogFilter(unsigned int filter);
```

This method sets the output log level of the SDK. You can use either one or a combination of the filters.

The log level follows the sequence of *OFF*, *CRITICAL*, *ERROR*, *WARNING*, *INFO*, and *DEBUG*. Choose a level, and you can see logs that precede that level.

For example, if you set the log level as *WARNING*, then you can see logs in levels *CRITICAL*, *ERROR* and *WARNING*.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>filter</td>
<td><p>Set the levels of the filters:</p>
<div><ul>
<li>LOG_FILTER_OFF = 0: Output no log.</li>
<li>LOG_FILTER_DEBUG = 0x80f: Output all the API logs.</li>
<li>LOG_FILTER_INFO = 0x0f: Output logs of the CRITICAL, ERROR, WARNING and INFO level.</li>
<li>LOG_FILTER_WARNING = 0x0e: Output logs of the CRITICAL, ERROR and WARNING level.</li>
<li>LOG_FILTER_ERROR = 0x0c: Output logs of the CRITICAL and ERROR level.</li>
<li>LOG_FILTER_CRITICAL = 0x08: Output logs of the CRITICAL level.</li>
</ul>
</div>
</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Release the IRtcEngine Object (release)

```
virtual void release() = 0;
```

This method releases the IRtcEngine object.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>sync</td>
<td><p>Indicates whether this method is called synchronously or asynchronously.</p>
<ul>
<li>True: Synchronous call. The result returns after the IRtcEngine Object resources are released. The app should not call this interface in the callback generated by the SDK, otherwise the SDK must wait for the callback to return in order to recover the associated object resources, resulting in a deadlock. The SDK automatically detects the deadlock and turns it into an asynchronous call, but the test itself takes extra time.</li>
<li>False: Asynchronous call. The result returns immediately even when the IRtcEngine object resources are not released, and the SDK will release all resources on its own. Pay attention: Do not immediately uninstall the SDK’s dynamic library after the call, otherwise it may crash because the SDK clean-up thread has not quit.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>&lt;0: error code.</li>
<li>0: method call succeed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Get the SDK Version (getVersion)

```
virtual const char* getVersion(int* build) = 0;
```

This method returns the string of the SDK version number in char format.

<a id = "RtcEngineParameters"></a>
### Parameter Methods (RtcEngineParameters)

This is an auxiliary class that sets parameters for the SDK. The following section describes each of the methods in this class.

#### Mute the Local Audio Stream (muteLocalAudioStream)

```
int muteLocalAudioStream(bool mute);
```

This method mutes/unmutes local audio. It enables/disables sending local audio streams to the network.


> This method does not disable the microphone, and thus does not affect the recording process, if any.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>mute</td>
<td><ul>
<li>True: Mutes local audio.</li>
<li>False: Unmutes local audio.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Mute All Remote Audio Streams (muteAllRemoteAudioStreams)

```
int muteAllRemoteAudioStreams(bool mute);
```

This method enables/disables playing all remote callers’ audio streams.


> When set to True, this method stops playing audio streams without affecting the audio stream receiving process.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>mute</td>
<td><ul>
<li>True: Stops playing all the received audio streams.</li>
<li>False: Allows playing all the received audio streams.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Mute A Specified Remote Audio Stream (muteRemoteAudioStream)

```
int muteRemoteAudioStream(uid_t uid, bool mute);
```

This method mutes/unmutes the audio streams of a specified user. It enables or disables playing a certain user’s audio streams.


> When set to True, this method stops playing audio streams without affecting the audio stream receiving process.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID whose audio streams the user intends to mute.</td>
</tr>
<tr><td>mute</td>
<td><ul>
<li>True: Stops playing a specified user’s audio streams.</li>
<li>False: Allows playing a specified user’s audio streams.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


#### Enable the Audio Volume Indication (enableAudioVolumeIndication)

```
int enableAudioVolumeIndication(int interval, int smooth);
```

This method enables the SDK to regularly report to the application on which user is talking and the volume of the speaker. Once the method is enabled, the SDK returns the volume indications at the set time internal in the [Audio Volume Indication Callback `onAudioVolumeIndication` callback, regardless of whether anyone is speaking in the channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>interval</td>
<td><p>Time interval between two consecutive volume indications:</p>
<div><ul>
<li>&lt;= 0: Disables the volume indication</li>
<li>&gt; 0: The time interval between two consecutive volume indications in milliseconds. Agora recommends setting it to more than 200 ms. Do not set it lower than 10 ms, or the <code>onAudioVolumeIndication</code> callback will not be triggered.</li>
</ul>
</div>
</td>
</tr>
<tr><td>smooth</td>
<td>Smoothing factor. The default value is 3</td>
</tr>
<tr><td>Return values</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Start Audio Mixing (startAudioMixing)

```
int startAudioMixing(const char* filePath, bool loopback, bool replace, int cycle);
```

This method mixes the specified local audio file with the audio stream from the microphone; or, it replaces the microphone’s audio stream with the specified local audio file. You can choose whether the other user can hear the local audio playback and specify the number of loop playbacks. This API also supports online music playback.


> Call this API when you are in a channel, otherwise it may cause issues.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>filePath</td>
<td><p>Name and path of the local audio file to be mixed.</p>
<p>Supported audio formats: mp3, aac, m4a, 3gp, and wav.</p>
</td>
</tr>
<tr/>
<tr><td>loopback</td>
<td><ul>
<li>True: Only the local user can hear the remix or the replaced audio stream.</li>
<li>False: Both users can hear the remix or the replaced audio stream.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>replace</td>
<td><ul>
<li>True: the content of the local audio file replaces the audio stream from the microphone.</li>
<li>False:  Local audio file mixed with the audio stream from the microphone.</li>
</ul>
</td>
</tr>
<tr/>
<tr><td>cycle</td>
<td><p>Number of loop playbacks:</p>
<ul>
<li>Positive integer: Number of loop playbacks.</li>
<li>-1: Infinite loop.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop Audio Mixing (stopAudioMixing)

```
int stopAudioMixing();
```

This method stops the audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Pause Audio Mixing (pauseAudioMixing)

```
int pauseAudioMixing();
```

This method pauses audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Resume Audio Mixing (resumeAudioMixing)

```
int resumeAudioMixing();
```

This method resumes audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Adjust the Audio Mixing Volume (adjustAudioMixingVolume)

```
int adjustAudioMixingVolume(int volume);
```

This method adjusts the volume during audio mixing. Call this API when you are in a channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>volume</td>
<td>Volume ranging from 0 to 100. By default, 100 is the original volume.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Get the Audio Mixing Duration (getAudioMixingDuration)

```
int getAudioMixingDuration();
```

This method gets the duration (ms) of audio mixing. Call this API when you are in a channel.

#### Get the Current Audio Position (getAudioMixingCurrentPosition)

```
int getAudioMixingCurrentPosition();
```

This method gets the playback position (ms) of the audio. Call this API when you are in a channel.

#### Drag the Audio Progress Bar (setAudioMixingPosition)

```
int setAudioMixingPosition(int pos /*in ms*/);
```

This method drags the playback progress bar of the audio mixing file to where you want to play instead of playing it from the beginning.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>pos</td>
<td>Integer. The position of the audio mixing file (ms).</td>
</tr>
</tbody>
</table>


#### Start an Audio Recording (startAudioRecording)

```
int startAudioRecording(const char* filePath, AUDIO_RECORDING_QUALITY_TYPE quality);
```

This method starts an audio recording. The SDK allows recording during a call, which supports either one of the following two formats:

-   *.wav*: Large file size with high sound fidelity **OR**
-   *.aac*: Small file size with low sound fidelity


Ensure that the directory to save the recording file exists and is writable. This method is usually called after the joinChannel method. The recording automatically stops when the leaveChannel method is called.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>filePath</td>
<td>Full file path of the recording file. The string of the file name is in UTF-8 code.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop an Audio Recording (stopAudioRecording)

```
int stopAudioRecording();
```

This method stops recording on the client.

Call this method before calling leaveChannel; otherwise the recording automatically stops when the leaveChannel method is called.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Adjust the Recording Volume (adjustRecordingSignalVolume)

```
int adjustRecordingSignalVolume(int volume);
```

This method adjusts the recording volume.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>volume</td>
<td><p>Recording volume, ranges from 0 to 400:</p>
<ul>
<li>0: Mute</li>
<li>100: Original volume</li>
<li>400: (Maximum) Four times the original volume with signal clipping protection</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Adjust the Playback Volume (adjustPlaybackSignalVolume)

```
int adjustPlaybackSignalVolume(int volume);
```

This method adjusts the playback volume.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>volume</td>
<td><p>Playback volume, ranges from 0 to 400:</p>
<ul>
<li>0: Mute</li>
<li>100: Original volume</li>
<li>400: (Maximum) Four times the original volume with signal clipping protection</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


<a id = "iaudiodevicemanager)"></a>
### Audio Device Management Methods (IAudioDeviceManager)

The *agora::IAudioDeviceManager* interface class tests the interfaces of the audio devices. Instantiate an AAudioDeviceManager class to get an IAudioDeviceManager interface.

#### Enumerate Playback Devices (enumeratePlaybackDevices)

```
virtual IAudioDeviceCollection* enumeratePlaybackDevices() = 0;
```

This method returns an IAudioDeviceCollection object that includes all the playback devices in the system. With the IAudioDeviceCollection object, the application can enumerate the playback devices. The application must call the IAudioDeviceCollection::release() method to release the returned object after using it.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><p>It returns an IAudioDeviceCollection object that includes all the playback devices in the system when the method call succeeds.</p>
<p>It returns NULL when the method call fails.</p>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Enumerate Recording Devices (enumerateRecordingDevices)

```
virtual IAudioDeviceCollection* enumerateRecordingDevices() = 0;
```

This method returns an IAudioDeviceCollection object that includes all the recording devices in the system. With the IAudioDeviceCollection object, the application can enumerate the recording devices. The application needs to call the IAudioDeviceCollection::release() method to release the returned object after using it.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><p>When successful, it returns an IAudioDeviceCollection object that includes all the recording devices in the system when the call succeeds.</p>
<p>It returns NULL when the call fails.</p>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Specify a Playback Device with the Device ID (setPlaybackDevice)

```
virtual int setPlaybackDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method uses the device ID to specify a playback device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>deviceId</td>
<td>Device ID of the playback device. It can be retrieved by the enumeratePlaybackDevices() method. Plugging or unplugging the device does not change the device ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Specify a Recording Device with the Device ID (setRecordingDevice)

```
virtual int setRecordingDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method uses the device ID to specify a recording device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>deviceId</td>
<td>Device ID of the recording device. It can be retrieved by the enumerateRecordingDevices() method. Plugging or unplugging the device does not change the device ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Set the Playback Device Volume (setPlaybackDeviceVolume)

```
virtual int setPlaybackDeviceVolume(int volume) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>volume</td>
<td>Volume of the playing device, ranging from 0 to 255</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Get the Playback Device Volume (getPlaybackDeviceVolume)

```
virtual int getPlaybackDeviceVolume(int *volume) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>volume</td>
<td>Volume of the playing device, ranging from 0 to 255</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the Recording Device Volume (setRecordingDeviceVolume)

```
virtual int setRecordingDeviceVolume(int volume) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>volume</td>
<td>Volume of the microphone, ranging from 0 to 255</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Get the Recording Device Volume (getRecordingDeviceVolume)

```
virtual int getRecordingDeviceVolume(int *volume) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>volume</td>
<td>Volume of the microphone, ranging from 0 to 255</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Mute the Playback Device (setPlaybackDeviceMute)

```
virtual int setPlaybackDeviceMute(bool mute) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>mute</td>
<td>
<div>Mute the playback device:</div>
<ul>
<li>True: Mute</li>
<li>False: Unmute</li>
</ul>
</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Check Whether the Playback Device is Muted (getPlaybackDeviceMute)

```
virtual int getPlaybackDeviceMute(bool *mute) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>mute</td>
<td>
<div>Checks whether the playback device is muted:</div>
<ul>
<li>True: Muted</li>
<li>False: Unmuted</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Mute the Recording Device (setRecordingDeviceMute)

```
virtual int setRecordingDeviceMute(bool mute) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>mute</td>
<td>
<div>Mute the recording device:</div>
<ul>
<li>True: Mute</li>
<li>False: Unmute</li>
</ul>
</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Check Whether the Recording Device is Mute (getRecordingDeviceMute)

```
virtual int getRecordingDeviceMute(bool *mute) = 0;
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>mute</td>
<td>
<div>Check whether the recording device is muted:</div>
<ul>
<li>True: Muted</li>
<li>False: Unmuted</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Enable Loopback Recording (enableLoopbackRecording)

```
int enableLoopbackRecording(bool enabled);
```

This method enables loopback recording. Once enabled, the SDK collects all local sounds.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>enabled</td>
<td>Enable loopback recording</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Start the Playback Device Test (startPlaybackDeviceTest)

```
virtual int startPlaybackDeviceTest(const char* testAudioFilePath) = 0;
```

This method checks whether the playback device works properly. The SDK plays an audio file specified by the user. If the user can hear the sound, then the playback device works properly.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>testAudioFilePath</td>
<td><p>File path of the audio file for the test, which is in UTF-8 absolute path:</p>
<ul>
<li>File formats: wav, mp3, m4a, and aac</li>
<li>File sampling rates: 8000, 16000, 32000, 44100, and 48000</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop the Playback Device Test (stopPlaybackDeviceTest)

```
virtual int stopPlaybackDeviceTest() = 0;
```

This method stops a playback device test. To stop the test, call this method after calling the `startPlaybackDeviceTest()` method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Start the Microphone Test (startRecordingDeviceTest)

```
virtual int startRecordingDeviceTest(int indicationInterval) = 0;
```

This method checks whether the microphone works properly. Once the test starts, the SDK uses the onAudioVolumeIndication callback to notify the application about the volume information.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop the Microphone Test (stopRecordingDeviceTest)

```
virtual int stopRecordingDeviceTest() = 0;
```

This method stops the microphone test. To stop the test, call this method after calling the startRecordingDeviceTest() method.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


<a id = "iaudiodevicecollection"></a>
### Audio Device Collection Methods (IAudioDeviceCollection)

The `agora::IAudioDeviceCollection` interface class retrieves device-related information.

#### Retrieve the Total Number of Playback or Recording Devices (getCount)

```
virtual int getCount() = 0;
```

First call `enumeratePlaybackDevices()`, then call this method to return the number of audio playback devices. First call `enumerateRecordingDevices()`, then call this method to return the number of audio recording devices.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td>The number of audio devices.</td>
</tr>
</tbody>
</table>



#### Retrieve the Indexed Device Information (getDevice)

```
virtual int getDevice(int index, char deviceName[MAX_DEVICE_ID_LENGTH], char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method retrieves information about an audio device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>index</td>
<td>An input parameter to specify the device information to be retrieved.</td>
</tr>
<tr><td>deviceName</td>
<td>An output parameter that indicates the device name.</td>
</tr>
<tr><td>deviceId</td>
<td>An output parameter that indicates the device ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Specify a Device with the Device ID (setDevice)

```
virtual int setDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method (recommended) uses the device ID to specify a video-capture device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>deviceId</td>
<td>Device ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Set the Application Volume (setApplicationVolume)

```
virtual int setApplicationVolume(int volume) = 0;
```

This method sets the volume of the Application.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>volume</td>
<td>The volume value, which ranges from 0-255</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>1: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Get the Application Volume (getApplicationVolume)

```
virtual int getApplicationVolume(int& volume) = 0;
```

This method gets the volume of the Application.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>volume</td>
<td>The volume value, which ranges from 0-255</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>1: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Set the Application Mute (setApplicationMute)

```
virtual int setApplicationMute(bool mute) = 0;
```

This method sets the Application mute.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>mute</td>
<td><p>Whether to mute the Application</p>
<ul>
<li>True: Mute the Application</li>
<li>False: Unmute the Application</li>
</ul>
</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>1: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Get the Mute State of the Application (isApplicationMute)

```
virtual int isApplicationMute(bool& mute) = 0;
```

This method gets the mute state of the Application.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>mute</td>
<td><p>The mute state of the current Application</p>
<ul>
<li>True: The application is mute</li>
<li>False: The application is not mute</li>
</ul>
</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt; 0: Method call failed</li>
</ul>
</td>
</tr>
</tbody>
</table>


<a id = "ivideodevicemanager"></a>
### Video Device Management Methods (IVideoDeviceManager)

The `agora::IVideoDeviceManager` interface class tests the interfaces of the video devices. Instantiate an AVideoDeviceManager class to get an IVideoDeviceManager interface.

#### Enumerate the Video Capture Devices (enumerateVideoDevices)

```
virtual IVideoDeviceCollection* enumerateVideoDevices() = 0;
```

This method returns an IVideoDeviceCollection object that includes all the video-capture devices in the system. With the IVideoDeviceCollection object, the application can enumerate the video-capture devices. The application must call the IVideoDeviceCollection::release() method to release the returned object after using it.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><p>It returns an IVideoDeviceCollection object that includes all the video-capture devices in the system when the method call succeeds.</p>
<p>It returns NULL when the method call fails.</p>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Specify a Device with the Device ID (setDevice)

```
virtual int setDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method (recommended) uses the device ID to specify a video-capture device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>deviceId</td>
<td>Device ID of the video-capture device. You can call enumerateVideoDevices() to retrieve it. Plugging or unplugging the device does not change the device ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Retrieve the Video Capture Device (getDevice)

```
virtual int getDevice(char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method retrieves the video-capture device that is in use.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>deviceId</td>
<td><p>Output parameter.</p>
<p>Device ID of the video-capture device.</p>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Start the Video Capture Device Test (startDeviceTest)

```
virtual int startDeviceTest(view_t hwnd) = 0;
```

This method tests whether the video-capture device works properly. Before calling this method, ensure that you have already called enableVideo, and the HWND window handle of the incoming parameter is valid.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>hwnd</td>
<td><p>Output parameter.</p>
<p>The window handle is used to display the screen.</p>
</td>
</tr>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop the Video Capture Device Test (stopDeviceTest)

```
virtual int stopDeviceTest() = 0;
```

This method stops the video-capture device test.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


<a id = "ivideodevicecollection"></a>
### Video Device Collection Methods (IVideoDeviceCollection)

The `agora::IVideoDeviceCollection` interface class retrieves the video device related numbers or data.

#### Retrieve the Total Number of Video Capture Devices (getCount)

```
virtual int getCount() = 0;
```

This method retrieves the total number of the indexed video-capture devices in the system.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Return Value</td>
<td>Total number of the indexed video-capture devices.</td>
</tr>
</tbody>
</table>



#### Retrieve the Indexed Device Information (getDevice)

```
virtual int getDevice(int index, char deviceName[MAX_DEVICE_ID_LENGTH], char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method retrieves a specified piece of information about an indexed video-capture device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>index</td>
<td><p>An input parameter. Specified index.</p>
<p>It must be smaller than the return value of getCount.</p>
</td>
</tr>
<tr/>
<tr><td>deviceName</td>
<td>An output parameter that indicates the device name.</td>
</tr>
<tr><td>deviceId</td>
<td>An output parameter that indicates the device ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Specify a Device with the Device ID (setDevice)

```
virtual int setDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;
```

This method (recommended) uses the device ID to specify a video-capture device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>deviceId</td>
<td>Device ID.</td>
</tr>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>


<a id = "irtcengineeventhandler"></a>
### Callback Methods (IRtcEngineEventHandler)

The SDK uses the `agora::IRtcEngineEventHandler` interface class to send callback event notifications to the application, and the application inherits the methods of this interface class to retrieve these event notifications. All methods in this interface class have their (empty) default implementations, and the application can inherit only some of the required events instead of all of them. In the callback methods, the application should avoid time-consuming tasks or calling blocking APIs, for example, SendMessage, otherwise the SDK may not work properly.

#### Join a Channel Callback (onJoinChannelSuccess)

```
virtual void onJoinChannelSuccess (const char* channel, uid_t uid, int elapsed);
```

This callback indicates that the user has successfully joined the specified channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>channel</td>
<td>The channel name.</td>
</tr>
<tr><td>uid</td>
<td><p>User ID.</p>
<p>If the uid is specified in the joinChannel method, it returns the specified ID; if not, it returns an ID that is automatically assigned by the Agora server.</p>
</td>
</tr>
<tr/>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this event occurs.</td>
</tr>
</tbody>
</table>



#### Rejoin Channel Callback (onRejoinChannelSuccess)

```
virtual void onRejoinChannelSuccess(const char* channel, uid_t uid, int elapsed);
```

When the client loses connection with the server because of network problems, the SDK automatically attempts to reconnect, and then triggers this callback method upon reconnection.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>channel</td>
<td>The channel name.</td>
</tr>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this event occurs.</td>
</tr>
</tbody>
</table>



#### Warning Occurred Callback (onWarning)

```
virtual void onWarning(int warn, const char* msg);
```

This callback method indicates that some warning occurred during SDK runtime. In most cases the application can ignore the warnings reported by the SDK, because the SDK can usually fix the issue and resume running. For instance, the SDK may report an ERR_OPEN_CHANNEL_TIMEOUT warning upon disconnection with the server and attempts to reconnect.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>warn</td>
<td>The warning code.</td>
</tr>
<tr><td>msg</td>
<td>The warning message.</td>
</tr>
</tbody>
</table>



#### Error Occurred Callback (onError)

```
virtual void onError(int err, const char* msg);
```

This callback indicates that a network or media error occurred during SDK runtime. In most cases, reporting an error means that the SDK cannot fix the issue and resume running, and therefore requires actions from the application or simply informs the user on the issue. For instance, the SDK reports an ERR_START_CALL error when failing to initialize a call. In this case, the application informs the user that the call initialization failed and calls the leaveChannel method to exit the channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>err</td>
<td><p>Error code:</p>
<ul>
<li>ERR_INVALID_VENDOR_KEY(101): Invalid App ID.</li>
<li>ERR_INVALID_CHANNEL_NAME(102): Invalid channel name.</li>
<li>ERR_LOOKUP_CHANNEL_REJECTED(105): Failed to look up the channel, because the server rejected the request.</li>
<li>ERR_OPEN_CHANNEL_REJECTED(107): Failed to join the channel, because the media server rejected the request.</li>
<li>ERR_LOAD_MEDIA_ENGINE(1001): Failed to load the media engine.</li>
<li>ERR_START_CALL(1002): Failed to turn on the local audio or video devices and thus failed to start a call.</li>
<li>ERR_START_CAMERA(1003): Failed to turn on the local camera.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr/>
<tr/>
<tr/>
<tr/>
<tr><td>msg</td>
<td>The error message.</td>
</tr>
</tbody>
</table>



#### API Call Executed Callback (onApiCallExecuted)

```
virtual void onApiCallExecuted(int err, const char* api, const char* result);
```

This callback is triggered when the API has been executed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>error</td>
<td>The error code that the SDK returns when the method call fails. If the SDK returns o, then the method has been called successfully.</td>
</tr>
<tr><td>api</td>
<td>The API that the SDK executes</td>
</tr>
<tr><td>result</td>
<td>The result of calling the API</td>
</tr>
</tbody>
</table>

#### The State of the Microphone Has Changed Callback (onMicrophoneEnabled)

```
virtual void onMicrophoneEnabled(bool enabled)
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>enabled</td>
<td>
	<ul>
		<li>true: The microphone is enabled.</li>
		<li>false: The microphone is disabled.</li>
	</ul>
	</td>
</tr>
</tbody>
</table>


#### Audio Quality Callback (onAudioQuality)

```
virtual void onAudioQuality(uid_t uid, int quality, unsigned short delay, unsigned short lost);
```

During a call, this callback is triggered once every two seconds to report on the audio quality of the call.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>User ID of the speaker</td>
</tr>
<tr><td>quality</td>
<td><p>Rating of the audio quality:</p>
<ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</td>
</tr>
<tr><td>delay</td>
<td>Time delay in milliseconds.</td>
</tr>
<tr><td>lost</td>
<td>The packet loss rate(%).</td>
</tr>
</tbody>
</table>



#### Audio Volume Indication Callback (onAudioVolumeIndication)

```
virtual void onAudioVolumeIndication (const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume);
```

This callback indicates who is talking and the speaker’s volume. By default the indication is disabled. If needed, use the enableAudioVolumeIndication() method to configure it.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>speakers</td>
<td><p>The speakers (array). Each speaker ():</p>
<ul>
<li>uid: User ID of the speaker. The uid of the local user is 0.</li>
<li>volume: The volume of the speaker between 0 (lowest volume) to 255 (highest volume).</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr><td>speakerNumber</td>
<td>Total number of speakers.</td>
</tr>
<tr><td>totalVolume</td>
<td>Total volume after audio mixing between 0 (lowest volume) to 255 (highest volume).</td>
</tr>
</tbody>
</table>



In the returned speakers array:

-   If the uid is 0, that is, the local user is the speaker, the returned `volume` is the same as `totalVolumn`.

-   If the uid is not 0 and the volume is 0, it indicates that the user specified by the uid did not speak.

-   If a uid is contained in the previous speakers array but not in the present one, it indicates that the user specified by the uid did not speak.


#### Leave Channel Callback (onLeaveChannel)

```
virtual void onLeaveChannel(const RtcStats& stat);
```

When the application calls the leaveChannel() method, the SDK uses this callback to notify the application that the user has successfully left the channel. With this callback function, the application retrieves information such as the call duration and the statistics of data received/transmitted by the SDK.

**Definition of RtcStats**

```
struct RtcStats
{
    unsigned int duration;
    unsigned int txBytes;
    unsigned int rxBytes;
    unsigned short txKBitRate;
    unsigned short rxKBitRate;

    unsigned short rxAudioKBitRate;
    unsigned short txAudioKBitRate;

    unsigned short rxVideoKBitRate;
    unsigned short txVideoKBitRate;
    unsigned int userCount;
    double cpuAppUsage;
    double cpuTotalUsage;
};
```

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>stats</td>
<td><p>Statistics about the call:</p>
<ul>
<li>duration: Call duration in seconds, represented by an aggregate value.</li>
<li>txBytes: Total number of bytes transmitted, represented by an aggregate value.</li>
<li>rxBytes: Total number of bytes received, represented by an aggregate value.</li>
<li>txKBitRate: Transmission bitrate in kbps, represented by an instantaneous value.</li>
<li>rxKBitRate: Receive bitrate in kbps, represented by an instantaneous value.</li>
<li>txAudioKBitrate: Audio transmission bitrate in kbps, represented by an instantaneous value.</li>
<li>rxAudioKBitRate: Audio receive bitrate in kbps, represented by an instantaneous value.</li>
<li>txVideoKBitRate: Video transmission bitrate in kbps, represented by an instantaneous value.</li>
<li>rxVideoKBitRate: Video receive bitrate in kbps, represented by an instantaneous value.</li>
<li>users: The instant number of users in the channel when the user leaves the channel.</li>
<li>puTotalUsage: System CPU usage (%).</li>
<li>cpuAppUsage: Application CPU usage (%).</li>
</ul>
</td>
</tr>
</tbody>
</table>



#### Other User Joined Channel Callback (onUserJoined)

```
virtual void onUserJoined(uid_t uid, int elapsed);
```

This callback method notifies the application the broadcaster has joined the channel. If the broadcaster is already in the channel when the application joins the channel, the SDK also reports to the application on the broadcaster that is already in the channel.


> In the live broadcast scenario:
> -   The broadcaster can receive the callback when another broadcaster joins the channel.
> -   All the audience in the channel can receive the callback when the new broadcaster joins the channel.
> -   When a web application joins the channel, this callback is triggered as long as the web application publishes streams.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>elapsed</td>
<td>Time delay (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>



#### Other User Offline Callback (onUserOffline)

```
virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason);
```

This callback notifies the application that the broadcaster has left the channel or gone offline.

The SDK reads the timeout data to determine if a user has left the channel (or has gone offline). If no data package is received from the user in 15 seconds, the SDK assumes the user is offline. A poor network connection may lead to false detections; therefore, use signaling for reliable offline detection.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>reason</td>
<td><p>This callback is triggered when:</p>
<ul>
<li><strong>USER_OFFLINE_QUIT(0)</strong>: User has quit the call.</li>
<li><strong>USER_OFFLINE_DROPPED(1)</strong>: The SDK timed out and the user dropped offline because it has not received a data package within a certain period of time. If a user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the event has timed out.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>



#### Call Session Statistics Callback (onRtcStats)

```
virtual void onRtcStats(const RtcStats& stats);
```

The SDK updates the application on the statistics of the call session once every two seconds.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>stat</td>
<td>See descriptions in <a href="#onleavechannel-live-windows"><span>Leave Channel Callback (onLeaveChannel)</span></a> .</td>
</tr>
</tbody>
</table>


#### First Remote Audio Frame Received Callback (onFirstRemoteAudioFrame)

```
virtual void onFirstRemoteAudioFrame(uid_t uid, int elapsed)
```

This callback method is triggered when the first remote audio frame is received.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>The UID of the remote user whose audio frame is received.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannel until this callback is triggered.</td>
</tr>
</tbody>
</table>



#### Audio Device State Changed Callback (onAudioDeviceStateChanged)

```
virtual void onAudioDeviceStateChanged(const char* deviceId, int deviceType, int deviceState);
```

This callback notifies the application that the system’s audio device state has been changed, for example, a headset is unplugged from the device.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>deviceId</td>
<td>The device ID.</td>
</tr>
<tr><td>deviceType</td>
<td><p>The device type defined as follows:</p>
<div><ul>
<li>UNKNOWN_DEVICE(-1): The device type is unknown.</li>
<li>AUDIO_PLAYOUT_DEVICE(0): The device is a playout device.</li>
<li>AUDIO_RECORDING_DEVICE(1): The device is a recording device.</li>
</ul>
</div>
</td>
</tr>
<tr><td>deviceState</td>
<td><p>The device state defined as follows:</p>
<div><ul>
<li>DEVICE_STATE_ACTIVE(1): The device is active.</li>
<li>DEVICE_STATE_DISABLED(2): The device is disabled.</li>
<li>DEVICE_STATE_NOT_PRESENT(4): The device is not present.</li>
<li>DEVICE_STATE_UNPLUGGED(8): The device is unplugged.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>



#### Network Quality Callback (onLastmileQuality)

```
virtual void onLastmileQuality(int quality);
```

This callback reports on the network quality. It is triggered once every two seconds after `enableLastmileTest()` is called. When not in a call and the network test is enabled (by calling enableLastmileTest), this callback function is triggered irregularly to update the application on the network connection quality of the local user.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>quality</td>
<td><p>Quality of the last mile network:</p>
<div><ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>



#### Channel Network Quality Callback (onNetworkQuality)

```
virtual void onNetworkQuality(uid_t uid, int txQuality, int rxQuality);
```

This callback is triggered every 2 seconds to update the application on the network quality of each user in a communication or live broadcast channel.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>uid</td>
<td>User ID. The network quality of the user with this UID will be reported.
If uid is 0, it reports the local network quality.</td>
</tr>
<tr><td>txQuality</td>
<td><p>The transmission quality of the user:</p>
<div><ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</div>
</td>
</tr>
<tr><td>rxQuality</td>
<td><p>The receiving quality of the user:</p>
<div><ul>
<li>QUALITY_UNKNOWN(0): The network quality is unknown.</li>
<li>QUALITY_EXCELLENT(1): The network quality is excellent.</li>
<li>QUALITY_GOOD(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>QUALITY_POOR(3): Users can feel the communication slightly impaired.</li>
<li>QUALITY_BAD(4): Users can communicate only not very smoothly.</li>
<li>QUALITY_VBAD(5): The network is so bad that users can hardly communicate.</li>
<li>QUALITY_DOWN(6): Users cannot communicate at all.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>



#### Other User Muted Audio Callback (onUserMuteAudio)

```
virtual void onUserMuteAudio(uid_t uid, bool muted);
```

This callback indicates that some other user has muted/unmuted his/her audio streams.



> Currently, this callback returns invalid when the number of broadcasters in a channel exceeds 20, which will be improved later.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID.</td>
</tr>
<tr><td>muted</td>
<td><ul>
<li>True: User has muted his/her audio.</li>
<li>False: User has unmuted his/her audio.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Connection Interrupted Callback (onConnectionInterrupted)

```
virtual void onConnectionInterrupted();
```

This method indicates that the SDK has lost connection with the server.

This method is triggered upon connection lost, while the onConnectionLost method is triggered when the SDK attempts to reconnect after losing connection. Once the connection is lost, and if the application does not call leaveChannel, the SDK automatically tries to reconnect repeatedly.

#### Connection Lost Callback (onConnectionLost)

```
virtual void onConnectionLost();
```

This callback indicates that the SDK has lost connection with the network, and it has remained unconnected for a period of time (10 seconds by default) despite that it attempts to reconnect. It is also triggered when the SDK fails to join the channel 10 seconds after it calls joinChannel. The SDK will keep trying to reconnect after this callback is triggered. Upon reconnection, an onRejoinChannelSuccess callback will then be triggered.

#### Connection Banned Callback (onConnectionBanned)

```
virtual void onConnectionBanned();
```

This callback is triggered when your connection is banned by the Agora Server.

#### Video-stream Type Switched (onApiCallExecuted)

```
virtual void onApiCallExecuted(const char* api, int error);
```

This callback indicates whether the video-stream type is switched or not.

<table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>API</th>
<th>API String Parameter</th>
<th>Status Code</th>
</tr>
</thead>
<tbody>
<tr><td>setRemotVideoStream</td>
<td>rtc.video.set_remote_video_stream</td>
<td>See the Error Code.</td>
</tr>
</tbody>
</table>



#### Data Stream Received Callback (onStreamMessage)

```
virtual void onStreamMessage(uid_t uid, int streamID, const char* data, size_t length);
```

This callback indicates the local user has received the data stream from the other user within five seconds.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>data</td>
<td>Data received by the recipients.</td>
</tr>
<tr><td>length</td>
<td>Length of the data</td>
</tr>
</tbody>
</table>



#### Data Stream Sent Failure Callback (onStreamMessageError)

```
virtual void onStreamMessageError(uid_t uid, int streamId, int code, int missed, int cached);
```

This callback indicates that the local user has not received the data stream from the other user within five seconds.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>uid</td>
<td>User ID</td>
</tr>
<tr><td>streamId</td>
<td>Stream ID</td>
</tr>
<tr><td>code</td>
<td><ul>
<li>ERR_OK = 0, No error</li>
<li>ERR_NOT_IN_CHANNEL=113, the user is not in a channel</li>
<li>ERR_BITRATE_LIMIT=115, limited bitrate</li>
</ul>
<p>For more error code descriptions, see <a href="/en/Interactive%20Gaming/the_error_game"><span>Error Codes and Warning Codes</span></a></p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>missed</td>
<td>The number of lost messages</td>
</tr>
<tr><td>cached</td>
<td>The number of incoming cached messages when the data stream is interrupted</td>
</tr>
</tbody>
</table>



#### Token Expired Callback (onRequestToken)

```
virtual void onRequestToken();
```

When a Channel Key is specified by calling `joinChannel()`, if the SDK lost connection with the Agora server due to network issues, the Channel Key may expire after a certain period of time and a new Channel Key may be required to reconnect to the server.

This callback notifies the application of generating a new Token, and calling renew token to specify the newly generated Channel Key.

This function was previously provided in the callback report of onError(): ERR_TOEKN_EXPIRED(109), ERR_INVALID_TOKEN(110). Starting from v1.7.3, the old method is still working, but it is recommended for you to put the related logic in this callback.

#### Audio Mixing File Playback Finished Callback (onAudioMixingFinished)

```
virtual void onAudioMixingFinished();
```

This callback is triggered when the audio mixing file playback is finished after calling `startAudioMixing`. If you failed to execute the `startAudioMixing` method, it returns the error code in the `onError` callback.

#### Local Audio Effect Playback Finished Callback (onAudioEffectFinished)

```
virtual void onAudioEffectFinished(int soundId)
```

This callback is triggered when the local audio effect playback is finished.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
</tbody>
</table>



#### Active Speaker Detected Callback (onActiveSpeaker)

```
virtual void onActiveSpeaker(uid_t uid);
```

If you have used the `enableAudioVolumeIndication` API, this callback is triggered then the volume detecting unit has detected active speaker in the channel. Also returns with the uid of the active speaker.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>uid</td>
<td>The UID of the active speaker. By default, 0 means the local user. If needed, you can also add relative functions on your App, for example, the active speaker, once detected, will have his/her head portrait zoomed in.</td>
</tr>
</tbody>
</table>




> -   You need to call `enableAudioVolumeIndication` to receive this callback.
>-   The active speaker means the uid of the speaker who speaks at the highest volume during a certain period of time.


#### User Role Changed Callback (onClientRoleChanged)

```
virtual void onClientRoleChanged(CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole);
```

This callback is triggered when the user role is switched, for example, from a host to an audience or vice versa.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>oldRole</td>
<td>Role that you switched from.</td>
</tr>
<tr><td>newRole</td>
<td>Role that you switched to.</td>
</tr>
</tbody>
</table>



#### Audio Device Volume Changed Callback (onAudioDeviceVolumeChanged)

```
virtual void onAudioDeviceVolumeChanged(MEDIA_DEVICE_TYPE deviceType, int volume, bool muted);
```

This callback is triggered when the volume of the playback, microphone, or application is changed.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>deviceType</td>
<td>Device type:</td>
</tr>
<tr><td>deviceType</td>
<td><ul>
<li>AUDIO_PLAYOUT_DEVICE: Playback device</li>
</ul>
</td>
</tr>
<tr><td>deviceType</td>
<td><ul>
<li>AUDIO_RECORDING_DEVICE: Recording device, microphone</li>
</ul>
</td>
</tr>
<tr><td>deviceType</td>
<td><ul>
<li>AUDIO_APPLICATION_PLAYOUT_DEVICE: Application</li>
</ul>
</td>
</tr>
<tr><td>volume</td>
<td>Volume, ranging from 0 to 255</td>
</tr>
<tr><td>muted</td>
<td>Whether the device is muted: True/False</td>
</tr>
</tbody>
</table>


### Error Codes

See [Error Codes and Warning Codes](/en/Interactive%20Gaming/the_error_game).
