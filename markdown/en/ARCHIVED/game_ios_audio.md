---
title: Interactive Gaming API
platform: iOS
updatedAt: 2019-02-11 11:53:06
---
The Interactive Gaming API is composed of **Objective-C Interface** and **C++ Interface**, both of which provide main methods and callback events of the SDK on the iOS platform:

- Objective-C Interface: 

  * [Basic Methods](#rtcenginekit)
  * [Delegate Methods](#rtcenginedelegate)
  * [Block Callbacks](#block)

- C++ Interface: 

  * [Basic Methods](#irtcengine)
  * [Parameter Methods](#rtcengineparameters)
  * [Callback Methods](#irtcengineeventhandler)

## Objective-C Interface

<a id = "rtcenginekit"></a>
### Basic Methods (AgoraRtcEngineKit)

`AgoraRtcEngineKit` is the basic interface class of Agora Native SDK. Creating an AgoraRtcEngineKit object and then calling the methods of this object enables the use of Agora Native SDK’s communication functionality.

#### Initialize (sharedEngineWithAppId)

```
+ (instancetype _Nonnull)sharedEngineWithAppId:(NSString * _Nonnull)appId
                                      delegate:(id<AgoraRtcEngineDelegate> _Nullable)delegate;
```

This method initializes the `AgoraRtcEngineKit` class as a singleton instance. Call this method to initialize service before using `AgoraRtcEngineKit`.

The SDK uses `Delegate` to inform the application on the engine runtime events. All methods defined in Delegate are optional implementation methods.

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
<tr><td>appId</td>
<td>The App ID issued to the application developers by Agora. Apply for a new one from Agora if the key is missing in your kit.</td>
</tr>
<tr><td>delegate</td>
<td> </td>
</tr>
</tbody>
</table>

#### Set the Channel Profile (setChannelProfile)

```
- (int)setChannelProfile:(AgoraChannelProfile)profile;
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
<td>Default setting. This is used in one-on-one calls, where all users in the channel can talk.</td>
</tr>
<tr><td>Live Broadcast</td>
<td>Live Broadcast. Host and audience roles that can be set by calling setClientRole.  The host sends and receives voice, while the audience receives voice only with the sending function disabled.</td>
</tr>
<tr><td>Gaming</td>
<td>Gaming Mode. Any user in the channel can talk freely. This mode uses the codec with low-power consumption and low bitrate by default.</td>
</tr>
</tbody>
</table>

> -   Only one profile can be used at the same time in the same channel. If you want to switch to another profile, use `destroy` to destroy the current Engine and create a new one using `sharedEngineWithAppId` before calling this method to set the new channel profile.
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
<li>AgoraChannelProfileCommunication = 0: Communication (default)</li>
<li>AgoraChannelProfileLiveBroadcasting = 1: Live Broadcast</li>
<li>AgoraChannelProfileGame = 2: Gaming</li>
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
- (int)setClientRole:(AgoraClientRole)role;
```

In a live broadcasr channel, this method allows you:
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
<td>The user role in a live broadcast:</td>
</tr>
<tr><td><ul>
<li>AgoraClientRoleBroadcaster = 1; Host</li>
<li>AgoraClientRoleAudience = 2; Audience (default)</li>
</ul>
</td>
</tr>
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
- (int)enableAudio;
```

This method enables the audio mode. The application can call this method either before joining a channel. This function is enabled by default.

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
- (int)enableLocalAudio:(BOOL)enabled;
```

When an App joins a channel, the audio function is enabled by default. This method disables or re-enables the local audio function, that is, to stop or restart local audio capturing and handling.
This method does not affect receiving or playing the remote audio streams, and is applicable to scenarios where the user wants to receive the remote audio streams without sending any audio stream to other users in the channel.
The `didMicrophoneEnabled` callback function will be triggered once the local audio function is disabled or re-enabled.

> - Call this method after `joinChannelByToken`.
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
- (int)disableAudio;
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


#### Join a Channel (joinChannelByToken)

```
- (int)joinChannelByToken:(NSString * _Nullable)token
                channelId:(NSString * _Nonnull)channelId
                     info:(NSString * _Nullable)info
                      uid:(NSUInteger)uid
              joinSuccess:(void(^ _Nullable)(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed))joinSuccessBlock;
```

This method allows a user to join a channel. Users in the same channel can talk to each other; and multiple users in the same channel can start a group chat. Users using different App IDs cannot call each other. Once in a call, the user must call the `leaveChannel` method to exit the current call before entering another channel. This method is called asynchronously; therefore, it can be called in the main user interface thread.

The SDK uses the OS X’s `AVAudioSession` shared object for audio recording and playing, so using this object may affect the SDK’s audio functions.

Once this method is called successfully, the SDK will trigger the callback. If both `joinChannelSuccessBlock` and `didJoinChannel` are implemented, the priority of `joinChannelSuccessBlock` is higher than `didJoinChannel`, thus `didJoinChannel` will be ignored. If you want to use `didJoinChannel`, set `joinChannelSuccessBlock` as nil.


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
<p>This parameter is optional if the user uses a static App ID. In this case, pass NIL as the parameter value.</p>
<p>If the user uses a Token, Agora issues an additional App Certificate to the application developers. The developers can then generate a user key using the algorithm and App Certificate provided by Agora for user authentication on the server.</p>
<p>In most circumstances, the static App ID will suffice. For added security, use a Token.</p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>channelName</td>
<td><p>A string providing the unique channel name for the AgoraRTC session. The length must be within 64 bytes.</p>
<p>The following is the supported scope: a-z, A-Z, 0-9, space, !</p>
<p>#$%&amp;, ()+,</p>
<p>-, :;&lt;=., &gt;?</p>
<p>@[], ^_, {|}, ~</p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr/>
<tr><td>info</td>
<td>(Optional) Any additional information the developer wants to add. <sup>[1]</sup> It can be set as a NIL Sting or channel related information. Other users in the channel will not receive this information.</td>
</tr>
<tr><td>uid</td>
<td>(Optional) User ID: A 32-bit unsigned integer ranging from 1 to (2^32-1). It must be unique. If not assigned (or set to 0), the SDK assigns one and returns it in the joinSuccessBlock callback. The app must record and maintain the returned value, as the SDK does not maintain it.</td>
</tr>
<tr><td>joinSuccessBlock</td>
<td>Callback on user successfully joined the channel.</td>
</tr>
</tbody>
</table>


> [1] For example, when a host wants to customize the resolution and bitrate for a live broadcast channel with CDN Live enabled, they can include them in this parameter in JSON format. For example, \{“owner”:true, …, “width”:300, “height”:400, “bitrate”:100\}. Only when neither `width`, `height`, and `bitrate` is 0 can the bitrate and resolution settings take effect.

> When joining a channel, the SDK calls `setCategory AVAudioSessionCategoryPlayAndRecord` to set `AVAudioSession` to `PlayAndRecord` mode. The application should not set it to any other mode. When setting to this mode, the sound being played (for example a ringtone) will be interrupted.

#### Leave a Channel (leaveChannel)

```
- (int)leaveChannel:(void(^ _Nullable)(AgoraChannelStats * _Nonnull stat))leaveChannelBlock;
```

This method allows a user to leave a channel, such as hanging up or exiting a call. After joining a channel, the user must call the leaveChannel method to end the call before joining another one.

The `leaveChannel` method releases all resources related to the call. The `leaveChannel` method is called asynchronously, and the user has not actually left the channel when the call returns. When the user leaves the channel, the SDK triggers the `didLeaveChannelWithstats` callback.

> If you call `destroy()` immediately after `leaveChannel`, the `leaveChannel` process will be interrupted, and the SDK will not trigger the `didLeaveChannelWithstats` callback.

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
<tr><td>leaveChannelBlock</td>
<td>Callback on user successfully left the channel.</td>
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


#### Set the Local Voice Pitch (setLocalVoicePitch)

```
- (int) setLocalVoicePitch:(double) pitch;
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
- (int)setRemoteVoicePosition:(int)uid pan:(double)pan gain:(double)gain;
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
- (int)setVoiceOnlyMode:(bool)enable;
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


#### Set the Local Voice Equalization (setLocalVoiceEqualizationOfBandFrequency)

```
- (int)setLocalVoiceEqualizationOfBandFrequency:(AgoraAudioEqualizationBandFrequency)bandFrequency withGain:(NSInterger)gain;
```

This method sets the local voice equalization.

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
<td>The band frequency ranging from 0 to 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 500, 1k, 2k, 4k, 8k, and 16k Hz.</td>
</tr>
<tr><td>gain</td>
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



#### Set the Local Voice Reverberation (setLocalVoiceReverbOfType)

```
- (int)setLocalVoiceReverbOfType:(AgoraAudioReverbType)reverbType withValue:(NSInterger)value;
```

This method sets the local voice reverberation.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Name</td>
<td>Description</td>
</tr>
<tr><td>reverbType</td>
<td>The reverberation types. This method contains five reverberation types. For details, see the description of each value:</td>
</tr>
<tr><td>value</td>
<td><ul>
<li>AgoraAudioReverbDryLevel = 0, (dB, [-20,10]), level of the dry signal</li>
<li>AgoraAudioReverbWetLevel = 1, (dB, [-20,10]), level of the early reflection signal (wet signal)</li>
<li>AgoraAudioReverbRoomSize = 2, ([0, 100]), room size of the reflection</li>
<li>AgoraAudioReverbWetDelay = 3, (ms, [0, 200]), length of the initial latency of the wet signal in ms</li>
<li>AgoraAudioReverbStrength = 4, ([0, 100]), length of the late reverberation</li>
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


#### Enable Web SDK Interoperability (enableWebSdkInteroperability)

```
- (int)enableWebSdkInteroperability:(BOOL)enabled;
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


#### Set the Default Audio Route (setDefaultAudioRouteToSpeakerPhone)

```
- (int)setDefaultAudioRouteToSpeakerphone:(BOOL)defaultToSpeaker;
```

This method sets whether the received audio is routed to the earpiece or speakerphone.


> -   Call this method only if you want to change the default settings.
> -   This method only works in audio mode.
> -   Call this method before `joinChannel`.


If the user does not call this method, the audio is routed to the earpiece by default.

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
<td>YES: Audio is routed to the speakerphone</td>
</tr>
<tr><td>NO: Audio is routed to the earpiece</td>
</tr>
<tr><td>Return Value</td>
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
</tbody>
</table>



#### Enable the Speakerphone (setEnableSpeakerphone)

```
- (int)setEnableSpeakerphone:(BOOL)enableSpeaker;
```

This method enables the audio routing to the speaker. Ensure that the joinChannelByKey method has been executed successfully before calling this method.

The SDK calls setCategory AVAudioSessionCategoryPlayAndRecord with options to configure the headset/speaker, so any sound will be interrupted when calling this method.

After this method is called, the SDK returns the didAudioRouteChanged callback, indicating that the audio routing has changed.

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
<tr><td>enableSpeaker</td>
<td>Yes: Switches to the speaker.</td>
</tr>
<tr><td>No: Switches to the headset.</td>
</tr>
<tr><td>Return Value</td>
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
</tbody>
</table>



#### Check Whether the Speakerphone is Enabled (isSpeakerphoneEnabled)

```
- (BOOL)isSpeakerphoneEnabled;
```

This method checks whether the speakerphone is enabled.

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
<li>Yes: Yes, enabled.</li>
<li>No: No, not enabled.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Enable In-ear Monitoring (enableInEarMonitoring)

```
- (int)enableInEarMonitoring:(BOOL)enabled;
```

This method enables or disables the in-ear monitoring function.

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
<li>YES: Enable in-ear monitoring</li>
<li>NO: Disable in-ear monitoring (default)</li>
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



#### Set the Audio Session Operation Restriction (setAudioSessionOperationRestriction)

```
- (void)setAudioSessionOperationRestriction:(AgoraAudioSessionOperationRestriction)restriction;
```

The SDK and the app can both configure the audio session by default. The app may occassionally use other applications or third-party components to manipulate the audio session and restrict the SDK from doing so. This API allows the app to restrict the SDK’s manipulation of the audio session.


> -   You can call this method before or after joining the channel.
> -   This method restricts the SDK’s manipulation of the audio session. Any operation to the audio session relies solely on the app, other applications, or third-party components.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>restriction</td>
<td><p>The operational restriction of the SDK on the audio session. It comes as a bit mask.</p>
<div><ul>
<li>AgoraAudioSessionOperationRestrictionNone = 0: No restrictions. The SDK has full control over the audio session operation.</li>
<li>AgoraAudioSessionOperationRestrictionSetCategory = 1: The SDK cannot change the category of the audio session.</li>
<li>AgoraAudioSessionOperationRestrictionConfigurationSession = 1 &lt;&lt; 1: The SDK cannot change the category, mode or categoryOptions of the audio session.</li>
<li>AgoraAudioSessionOperationRestrictionDeactivateSession = 1 &lt;&lt; 2: The SDK cannot deactivate the session when it leaves the channel.</li>
<li>AgoraAudioSessionOperationRestrictionAll = 1 &lt;&lt; 7: Restricts the SDK from manipulating the audio session.</li>
</ul>
</div>
</td>
</tr>
</tbody>
</table>


#### Enable the Audio Volume Indication (enableAudioVolumeIndication)

```
- (int)enableAudioVolumeIndication:(NSInteger)interval
                            smooth:(NSInteger)smooth;
```

This method allows the SDK to regularly report to the application on which user is speaking and the volume of the speaker. Once the method is enabled, the SDK returns the volume indications at the set time internal in the `reportAudioVolumeIndicationOfSpeakers` and `audioVolumeIndicationBlock` callback, regardless of whether anyone is speaking in the channel.

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
<li>&gt; 0: The time interval between two consecutive volume indications in milliseconds. Agora recommends setting it to more than 200 ms. Do not set it lower than 10 ms, or the <code>reportAudioVolumeIndicationOfSpeakers</code> callback will not be triggered.</li>
</ul>
</div>
</td>
</tr>
<tr><td>smooth</td>
<td>The Smoothing factor that determines the sensitivity of this method. The range is [0-10] and Agora recommends setting it 3. The bigger the number, the more sensitive it is.</td>
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



#### Set the Volume of In-ear Monitor (setInEarMonitoringVolume)

```
- (int)setInEarMonitoringVolume:(NSInteger)volume;
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


#### Get the Audio Effect Volume (getEffectsVolume)

```
- (double)getEffectsVolume;
```

This method gets the volume of the audio effects from 0.0 to 100.0.

#### Set the Audio Effect Volume (setEffectsVolume)

```
- (int)setEffectsVolume:(double)volume;
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
<td>Value ranging from 0.0 to 100.0. 100.0 is the default value.</td>
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
- (int)setVolumeOfEffect:(int)soundId
              withVolume:(double)volume;
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
<td>Value ranging from 0.0 to 100.0. 100.0 is the default value.</td>
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
- (int)playEffect:(int)soundId
         filePath:(NSString * _Nullable)filePath
        loopCount:(int)loopCount
            pitch:(double)pitch
              pan:(double)pan
             gain:(double)gain
          publish:(BOOL)publish;
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
<td>ID of the specified audio effect. Each audio effect has a unique ID <sup>[4]</sup></td>
</tr>
<tr><td>filePath</td>
<td>The absolute path of the audio effect file</td>
</tr>
<tr><td>loopCount</td>
<td><p>Set the number of times looping the audio effect</p>
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
<li>0.0: The audio effect shows ahead</li>
<li>1.0: The audio effect shows on the right</li>
<li>-1.0: The audio effect shows on the left</li>
</ul>
</td>
</tr>
<tr><td>gain</td>
<td>Volume of the audio effect. The range is [0.0, 100,0]
The default value is 100.0. The smaller the value, the lower the volume of the audio effect</td>
</tr>
<tr><td>publish</td>
<td><p>Set whether to publish the specified audio effect to the remote stream:</p>
<ul>
<li>true: The audio effect, played locally, is published to the Agora Cloud and the remote users can hear it</li>
<li>false: The audio effect, played locally, is not published to the Agora Cloud and the remote users cannot hear it</li>
</ul>
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



> [4] If you preloaded the audio effect into the memory through `preloadEffect`, ensure that the `soundID` value is set to the same value as in `preloadEffect`.

> In version v2.1.x, the following method, which is not recommended by Agora, is used.

```
- (int) playEffect: (int) soundId
          filePath: (NSString*) filePath
              loop: (BOOL) loop
             pitch: (double) pitch
               pan: (double) pan
              gain: (double) gain;
```

#### Stop Playing an Audio Effect (stopEffect)

```
- (int)stopEffect:(int)soundId;
```

This method stops playing a specified audio effect.

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
- (int)stopAllEffects;
```

This method stops playing all the audio effects.

#### Preload an Audio Effect (preloadEffect)

```
- (int)preloadEffect:(int)soundId
            filePath:(NSString * _Nullable) filePath;
```

This method preloads a specific audio effect file (compressed audio file) to the memory.


> To ensure smooth communication, pay attention to the size of the audio effect file. Agora recommends using this method to preload the audio effect before calling `joinChannelByToken`.

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
- (int)unloadEffect:(int)soundId;
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
- (int)pauseEffect:(int)soundId;
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
- (int)pauseAllEffects;
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
- (int)resumeEffect:(int)soundId;
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
- (int) esumeAllEffects;
```

This method resumes all the audio effects.

#### Mute the Local Audio Stream (muteLocalAudioStream)

```
- (int)muteLocalAudioStream:(BOOL)mute;
```

This method mutes/unmutes the local audio.

> This method is valid only when the user is in the channel. Once the user leaves the channel, all the mute states are reset.

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
<li>True: Mutes the local audio.</li>
<li>False: Unmutes the local audio.</li>
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
- (int)muteAllRemoteAudioStreams:(BOOL)mute;
```

This method mutes/unmutes all remote users’ audio streams.
> This method is valid only when the user is in the channel. Once the user leaves the channel, all the mute states are reset.

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
<tr><td>muted</td>
<td><ul>
<li>True: Stops playing all received audio streams.</li>
<li>False: Resumes playing all received audio streams.</li>
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
- (int)muteRemoteAudioStream:(NSUInteger)uid muted:(BOOL)mute;
```

Mute/unmute a specified remote user’s audio stream.

> When set to **True**, this method stops playing audio streams without affecting the audio stream receiving process.
> This method is valid only when the user is in the channel. Once the user leaves the channel, all the mute states are reset.

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


#### Start Audio Mixing (startAudioMixing)

```
- (int)startAudioMixing:(NSString *  _Nonnull)filePath
               loopback:(BOOL)loopback
                replace:(BOOL)replace
                  cycle:(NSInteger)cycle;
```

This method mixes the specified local audio file with the audio stream from the microphone; or, it replaces the microphone’s audio stream with the specified local audio file. You can choose whether the other user can hear the local audio playback and specify the number of loop playbacks. This API also supports online music playback.


> -   To use the startAudioMixing API, ensure the iOS device version is 8.0 or later.
> -   Call this API when you are in a channel, otherwise it may cause issues.


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
<td>Name and path of the local audio file to be mixed.</td>
</tr>
<tr><td>Supported audio formats: mp3, aac, m4a, 3gp, and wav.</td>
</tr>
<tr><td>loopback</td>
<td>True:  Only the local user can hear the remix or the replaced audio stream.</td>
</tr>
<tr><td>False:  Both users can hear the remix or the replaced audio stream.</td>
</tr>
<tr><td>replace</td>
<td>True:  The content of the local audio file replaces the audio stream from the microphone.</td>
</tr>
<tr><td>False:  Local audio file mixed with the audio stream from the microphone.</td>
</tr>
<tr><td>cycle</td>
<td>Number of loop playbacks:</td>
</tr>
<tr><td>Positive integer: Number of loop playbacks</td>
</tr>
<tr><td>-1：Infinite loop</td>
</tr>
<tr><td>Return Value</td>
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
</tbody>
</table>



#### Stop Audio Mixing (stopAudioMixing)

```
- (int)stopAudioMixing;
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
- (int)pauseAudioMixing;
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
- (int)resumeAudioMixing;
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
- (int)adjustAudioMixingVolume:(NSInteger)volume;
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
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
</tbody>
</table>



#### Get the Audio Mixing Duration (getAudioMixingDuration)

```
- (int)getAudioMixingDuration;
```

This method gets the duration (ms) of audio mixing. Call this API when you are in a channel.

#### Get Current Audio Position (getAudioMixingCurrentPosition)

```
- (int)getAudioMixingCurrentPosition;
```

This method gets the playback position (ms) of the audio. Call this API when you are in a channel.

#### Drag the Audio Progress Bar (setAudioMixingPosition)

```
- (int)setAudioMixingPosition:(NSInteger)pos;
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
- (int)startAudioRecording:(NSString * _Nonnull)filePath
                   quality:(AgoraAudioRecordingQuality)quality;
```

This method starts an audio recording. The SDK allows recording during a call, which supports either one of the following two formats:

-   *.wav*: Large file size with high sound fidelity **OR**

-   *.aac*: Small file size with low sound fidelity


Ensure that the saving directory in the application exists and is writable. This method is usually called after the `joinChannelByToken` method. The recording automatically stops when the `leaveChannel` method is called.

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
<li><code>AgoraRtc_AudioRecordingQuality_Low = 0</code>: Low quality, file size around 1.2 MB after 10 minutes of recording</li>
<li><code>AgoraRtc_AudioRecordingQuality_Low = 1</code>: Medium quality, file size around 2 MB after 10 minutes of recording</li>
<li><code>AgoraRtc_AudioRecordingQuality_Low = 2</code>: High quality, file size around 3.75 MB after 10 minutes of recording</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
<tr/>
<tr><td>Return Value</td>
<td><ul>
<li>0: Method call succeeded</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



#### Stop an Audio Recording (stopAudioRecording)

```
- (int)stopAudioRecording;
```

This method stops recording on the client.


> Call this method before calling `leaveChannel`, otherwise the recording automatically stops when the `leaveChannel` method is called.

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
- (int)adjustRecordingSignalVolume:(NSInteger)volume;
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
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
</tbody>
</table>



#### Adjust the Playback Volume (adjustPlaybackSignalVolume)

```
- (int)adjustPlaybackSignalVolume:(NSInteger)volume;
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
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
</tbody>
</table>


#### Enable Built-in Encryption and Set the Encryption Secret (setEncryptionSecret)

```
- (int)setEncryptionSecret:(NSString * _Nullable)secret;
```

Use `setEncryptionSecret` to specify an encryption password to enable built-in encryption before joining a channel. All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user has left the channel. If the encryption password is not specified or set to empty, the encryption function will be disabled.


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
- (int)setEncryptionMode:(NSString * _Nullable)encryptionMode;
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
- (int)createDataStream:(NSInteger * _Nonnull)streamId
               reliable:(BOOL)reliable
                ordered:(BOOL)ordered;
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
<li>&lt;0: Returns an error code when it fails to create the data stream. <sup>[5]</sup></li>
<li>&gt;0: Returns the Stream ID when the data stream is created.</li>
</ul>
</td>
</tr>
<tr/>
</tbody>
</table>



> [5] The error code is related to the positive integer displayed in [Error Codes and Warning Codes](/en/API%20Reference/the_error_native) for example, if it returns -2, then it indicates 2: ERR_INVALID_ARGUMENT in [Error Codes and Warning Codes](/en/API%20Reference/the_error_native).

#### Send a Data Stream (sendStreamMessage)

```
- (int)sendStreamMessage:(NSInteger)streamId
                    data:(NSData * _Nonnull)data;
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
<td>Stream ID.</td>
</tr>
<tr><td>message</td>
<td>Data to be sent</td>
</tr>
<tr><td>Return Value</td>
<td>When it fails to send the message, the following error code will be returned: ERR_SIZE_TOO_LARGE/ERR_TOO_OFTEN/ERR_BITRATE_LIMIT</td>
</tr>
</tbody>
</table>


#### Start an Audio Call Test (startEchoTest)

```
- (int)startEchoTest:(void(^ _Nullable)(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed))successBlock;
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
<tr><td>successBlock</td>
<td>Callback on successfully starting the echo test. See  joinSuccessBlock in joinChannelByToken for a description of the callback parameters.</td>
</tr>
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
- (int)stopEchoTest;
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
- (int)enableLastmileTest;
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
- (int)disableLastmileTest;
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
- (NSString * _Nullable)getCallId;
```

When a user joins a channel on a client, a CallId is generated to identify the call from the client. Some methods such as rate and complain need to be called after the call ends in order to submit feedback to the SDK. These methods require assigned values of the `CallId` parameters. To use these feedback methods, call the getCallId method to retrieve the `CallId` during the call, and then pass the value as an argument in the feedback methods after the call ends.

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
- (int)rate:(NSString * _Nonnull)callId
     rating:(NSInteger)rating
description:(NSString * _Nullable)description;
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
<td>A given description for the call with a length less than 800 bytes.</td>
</tr>
<tr><td>This parameter is optional.</td>
</tr>
<tr><td>Return Value</td>
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
<tr><td>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid, for example, callId invalid.</td>
</tr>
<tr><td>ERR_NOT_READY (-3): The SDK status is incorrect, for example, initialization failed.</td>
</tr>
</tbody>
</table>



#### Complain about the Call Quality (complain)

```
- (int)complain:(NSString * _Nonnull)callId
    description:(NSString * _Nullable)description;
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
<td>A given description of the call with a length less than 800 bytes.</td>
</tr>
<tr><td>This parameter is optional.</td>
</tr>
<tr><td>Return Value</td>
<td>0: Method call succeeded.</td>
</tr>
<tr><td>&lt;0: Method call failed.</td>
</tr>
<tr><td>ERR_INVALID_ARGUMENT (-2): The passed argument is invalid, for example, callId invalid.</td>
</tr>
<tr><td>ERR_NOT_READY (-3): The SDK status is incorrect, for example, initialization failed.</td>
</tr>
</tbody>
</table>


#### Renew Token (renewToken)

```
- (int)renewToken:(NSString * _Nonnull)token;
```

This method updates the Token.

The key expires after a certain period of time once the Token schema is enabled when:

-   The `rtcEngine:didOccurError:` callback reports the ERR_TOKEN_EXPIRED(109) error, or

-   The `rtcEngineRequestToken:` callback reports the ERR_TOKEN_EXPIRED(109) error, or


The application should retrieve a new key and then call this method to renew it. Failure to do so will result in the SDK disconnecting from the server.

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
<td>Token to be renewed.</td>
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
- (int)setLogFile:(NSString * _Nonnull)filePath;
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


> The default log file location is at: Library/caches/agorasdk.log.

#### Set the Log Filter (setLogFilter)

```
- (int)setLogFilter:(NSUInteger)filter;
```

This method sets the output log level of the SDK. You can use either one or a combination of the filters.

The log level follows the sequence of *Off*, *Critical*, *Error*, *Warning*, *Info*, and *Debug*. Choose a level, and you can see logs that precede that level.

For example, if you set the log level as *Warning*, then you can see logs in levels *Critical*, *Error* and *Wwarning*.

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
<li>AgoraLogFilterOff = 0: Output no log.</li>
<li>AgoraLogFilterDebug = 0x080f: Output all the API logs.</li>
<li>AgoraLogFilterInfo = 0x000f: Output logs of the CRITICAL, ERROR, WARNING and INFO level.</li>
<li>AgoraLogFilterWarning = 0x000e: Output logs of the CRITICAL, ERROR and WARNING level.</li>
<li>AgoraLogFilterError = 0x000c: Output logs of the CRITICAL and ERROR level.</li>
<li>AgoraLogFilterCritical = 0x0008: Output logs of the CRITICAL level.</li>
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
+ (void)destroy;
```

This method releases all the resources used by the Agora SDK. This is useful for applications that occasionally make voice or video calls, to free up resources for other operations when not making calls.

Once the application has called destroy() to destroy the created RtcEngine instance, no other methods in the SDK can be used and no callbacks occur. To start communications again, initialize `sharedEngineWithappId` to establish a new `AgoraRtcEngineKit` instance.


> -   Use this method in the sub thread.
> -   This method is called synchronously. The result returns after the IRtcEngine object resources are released. The app should not call this interface in the callback generated by the SDK, otherwise the SDK must wait for the callback to return before it can reclaim the related object resources, causing a deadlock.


#### Get the SDK Version (getSdkVersion)

```
+ (NSString * _Nonnull)getSdkVersion;
```

This method returns the string of the SDK version number.


<a id = "rtcenginedelegate"></a>
### Delegate Methods (AgoraRtcEngineDelegate)

The SDK uses Delegate methods `AgoraRtcEngineDelegate` to report runtime events to the application. From v1.1, some Block callbacks in the SDK are replaced with Delegate methods. The old Block callbacks are therefore being deprecated, but can still be used in the current version. However, we recommend replacing them with Delegate methods. The SDK calls the Block method if a callback is defined in both Block and Delegate.

#### Warning Occurred Callback (didOccurWarning)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraRtcErrorCode)warningCode;
```

This callback method indicates that some warning occurred during SDK runtime. In most cases, the application can ignore the warnings reported by the SDK because the SDK can usually fix the issue and resume running.

For instance, the SDK may report an `AgoraRtc_Error_OpenChannelTimeout(106)` warning upon disconnection with the server and attempts to reconnect.

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
<tr><td>warningCode</td>
<td>The warning code.</td>
</tr>
</tbody>
</table>



#### Error Occurred Callback (didOccurError)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraRtcErrorCode)errorCode;
```

This callback indicates that a network or media error occurred during SDK runtime. In most cases, reporting an error means that the SDK cannot fix the issue and resume running, and therefore requires actions from the application or simply informs the user on the issue. For instance, the SDK reports an `AgoraRtc_Error_StartCall(1002)` error when failing to initialize a call. In this case, the application informs the user that the call initialization failed and calls the leaveChannel method to exit the channel.

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
<tr><td>Engine</td>
<td>The AgoraRtcEngineKit Object.</td>
</tr>
<tr><td>errorCode</td>
<td>Error code.</td>
</tr>
</tbody>
</table>



#### API Call Executed Callback (didApiCallExecute)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didApiCallExecute:(NSInteger)error api:(NSString * _Nonnull)api result:(NSString * _Nonnull)result;
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



#### Join Channel Callback (didJoinChannel)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didJoinChannel:(NSString * _Nonnull)channel withUid:(NSUInteger)uid elapsed:(NSInteger) elapsed;
```

Same as joinSuccessBlock in the joinChannelByToken API. This callback indicates that the user has successfully joined the specified channel.

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
<td><p>User ID.</p>
<p>If the uid is specified in the joinChannelByToken method, returns the specified ID; if not, returns an ID that is automatically allocated by the Agora server.</p>
</td>
</tr>
<tr/>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannelByToken until this event occurs.</td>
</tr>
</tbody>
</table>



#### Rejoin Channel (didRejoinChannel)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didRejoinChannel:(NSString * _Nonnull)channel withUid:(NSUInteger)uid elapsed:(NSInteger) elapsed;
```

If the client loses connection with the server because of network problems, the SDK automatically attempts to reconnect, and then triggers this callback method upon reconnection, indicating that the user has rejoined the channel with the assigned channel ID and user ID.

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
<td>Time elapsed (ms) from calling joinChannelByToken until this event occurs.</td>
</tr>
</tbody>
</table>



#### User Left Channel Callback (didLeaveChannelWithStats)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didLeaveChannelWithStats:(AgoraChannelStats * _Nonnull)stats;
```

When the user executes leaveChannel() successfully, SDK will trigger this callback. Same as `leaveChannelBlock`.

**Definition of AgoraChannelStats**

```
__attribute__((visibility("default"))) @interface AgoraChannelStats: NSObject
@property (assign, nonatomic) NSInteger duration;
@property (assign, nonatomic) NSInteger txBytes;
@property (assign, nonatomic) NSInteger rxBytes;
@property (assign, nonatomic) NSInteger txAudioKBitrate;
@property (assign, nonatomic) NSInteger rxAudioKBitrate;
@property (assign, nonatomic) NSInteger txVideoKBitrate;
@property (assign, nonatomic) NSInteger rxVideoKBitrate;
@property (assign, nonatomic) NSInteger lastmileDelay;
@property (assign, nonatomic) NSInteger userCount;
@property (assign, nonatomic) double cpuAppUsage;
@property (assign, nonatomic) double cpuTotalUsage;
@end
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
<li>duration: Call duration in seconds, represented by an aggregate value.</li>
<li>txBytes: Total number of bytes transmitted, represented by an aggregate value.</li>
<li>rxBytes: Total number of bytes received, represented by an aggregate value.</li>
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


#### Audio Route Changed Callback (didAudioRouteChanged)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didAudioRouteChanged:(AgoraAudioOutputRouting)routing;
```

This callback is triggered when the audio routing is changed. The definition of AgoraAudioOutputRouting is listed as follows:

```
typedef NS_ENUM(NSInteger, AgoraAudioOutputRouting)
{
    AgoraAudioOutputRoutingDefault = -1,
    AgoraAudioOutputRoutingHeadset = 0,
    AgoraAudioOutputRoutingEarpiece = 1,
    AgoraAudioOutputRoutingHeadsetNoMic = 2,
    AgoraAudioOutputRoutingSpeakerphone = 3,
    AgoraAudioOutputRoutingLoudspeaker = 4,
    AgoraAudioOutputRoutingHeadsetBluetooth = 5
};
```

#### The State of the Microphone Has Changed Callback (didMicrophoneEnabled)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didMicrophoneEnabled:(BOOL)enabled;
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


#### Audio Quality Callback (audioQualityOfUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine audioQualityOfUid:(NSUInteger)uid quality:(AgoraNetworkQuality)quality delay:(NSUInteger)delay lost:(NSUInteger)lost;
```

Same as `audioQualityBlock`. During a call, this callback is triggered once every two seconds to report on the audio quality of the current call.

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
<li>AgoraNetworkQualityUnknown(0): The network quality is unknown.</li>
<li>AgoraNetworkQualityExcellent(1): The network quality is excellent.</li>
<li>AgoraNetworkQualityGood(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>AgoraNetworkQualityPoor(3): Users can feel the communication slightly impaired.</li>
<li>AgoraNetworkQualityBad(4): Users can communicate only not very smoothly.</li>
<li>AgoraNetworkQualityVBad(5): The network is so bad that users can hardly communicate.</li>
<li>AgoraNetworkQualityDown(6): Users cannot communicate at all.</li>
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



#### Audio Volume Indication Callback (reportAudioVolumeIndicationOfSpeakers)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> * _Nonnull)speakers totalVolume:(NSInteger)totalVolume;
```

Same as `audioVolumeIndicationBlock`. By default this notification is disabled. If you need it, use the `enableAudioVolumeIndication` method to configure it.

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
<li>uid: User ID of the speaker. By default, 0 means the local user.</li>
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


#### Other User Joined Callback (didJoinedOfUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed;
```

Same as `userJoinedBlock`. This callback method notifies the application the broadcaster has joined the channel. If the broadcaster is already in the channel when the application joins the channel, the SDK also reports to the application on the broadcaster that is already in the channel.


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
<td><p>User ID of the host.</p>
<p>If the uid is specified in the joinChannelByToken method, returns the specified ID; if not, returns an ID that is automatically allocated by the Agora server.</p>
</td>
</tr>
<tr/>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannelByToken until this callback is triggered.</td>
</tr>
</tbody>
</table>



#### Other User Offline Callback (didOfflineOfUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason;
```

Same as `userOfflineBlock`. This callback indicates that the broadcaster has left the call or gone offline.

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
<li>AgoraRtc_UserOffline_Quit(0): A user has quit the call.</li>
<li>AgoraRtc_UserOffline_Dropped(1): The SDK timed out and the user dropped offline because it has not received any data package within a certain period of time. If a user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the event has timed out.</li>
</ul>
</td>
</tr>
<tr/>
<tr/>
</tbody>
</table>



#### Other User Muted Audio Callback (didAudioMuted)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didAudioMuted:(BOOL)muted byUid:(NSUInteger)uid;
```

Same as userMuteAudioBlock. This callback indicates that some other user has muted/unmuted his/her audio streams.

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
<td>Yes: User has muted his/her audio.</td>
</tr>
<tr><td>No: User has unmuted his/her audio.</td>
</tr>
</tbody>
</table>



#### RtcEngine Statistics Callback (reportRtcStats)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine
reportRtcStats:(AgoraRtcStats*)stats;
```

Same as rtcStatsBlock. The SDK updates the application on the statistics of the RtcEngine runtime status once every two seconds.

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
<td>See descriptions in <a href="#didleavechannelwithstats-live-ios"><span>User Left Channel Callback (didLeaveChannelWithStats)</span></a> .</td>
</tr>
</tbody>
</table>



#### Channel Network Quality Callback (networkQuality)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine networkQuality:(NSUInteger)uid txQuality:(AgoraRtcQuality)txQuality rxQuality:(AgoraRtcQuality)rxQuality;
```

This callback is triggered every 2 seconds to update the application on the current network quality of each user in a communication or live broadcast channel.

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
<td>
<div>User ID. The network quality of the user with this UID will be reported.</div>
<p>If uid is 0, it reports the local network quality.</p>
</td>
</tr>
<tr><td>txQuality</td>
<td><p>The transmission quality of the user:</p>
<ul>
<li>AgoraNetworkQualityUnknown(0): The network quality is unknown.</li>
<li>AgoraNetworkQualityExcellent(1): The network quality is excellent.</li>
<li>AgoraNetworkQualityGood(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>AgoraNetworkQualityPoor(3): Users can feel the communication slightly impaired.</li>
<li>AgoraNetworkQualityBad(4): Users can communicate only not very smoothly.</li>
<li>AgoraNetworkQualityVBad(5): The network is so bad that users can hardly communicate.</li>
<li>AgoraNetworkQualityDown(6): Users cannot communicate at all.</li>
</ul>
</td>
</tr>
<tr><td>rxQuality</td>
<td><p>The receiving quality of the user:</p>
<ul>
<li>AgoraNetworkQualityUnknown(0): The network quality is unknown.</li>
<li>AgoraNetworkQualityExcellent(1): The network quality is excellent.</li>
<li>AgoraNetworkQualityGood(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>AgoraNetworkQualityPoor(3): Users can feel the communication slightly impaired.</li>
<li>AgoraNetworkQualityBad(4): Users can communicate only not very smoothly.</li>
<li>AgoraNetworkQualityVBad(5): The network is so bad that users can hardly communicate.</li>
<li>AgoraNetworkQualityDown(6): Users cannot communicate at all.</li>
</ul>
</td>
</tr>
</tbody>
</table>


#### Connection Interrupted Callback (rtcEngineConnectionDidInterrupted)

```
- (void)rtcEngineConnectionDidInterrupted:(AgoraRtcEngineKit * _Nonnull)engine;
```

This method indicates that the SDK has lost connection with the server.

This method is triggered upon connection lost, while the onConnectionLost method is triggered when the SDK attempts to reconnect after losing connection. Once the connection is lost, and if the application does not call leaveChannel, the SDK automatically tries to reconnect repeatedly.

#### Connection Lost Callback (rtcEngineConnectionDidLost)

```
- (void)rtcEngineConnectionDidLost:(AgoraRtcEngineKit * _Nonnull)engine;
```

This callback indicates that the SDK has lost connection with the network, and it has remained unconnected for a period of time (10 seconds by default) despite that it attempts to reconnect. It is also triggered when the SDK fails to join the channel 10 seconds after it calls joinChannel. The SDK will keep trying to reconnect after this callback is triggered. Upon reconnection, an onRejoinChannelSuccess callback will then be triggered.

#### Connection Banned Callback (rtcEngineConnectionDidBanned)

```
- (void)rtcEngineConnectionDidBanned:(AgoraRtcEngineKit * _Nonnull)engine;
```

This callback is triggered when your connection is banned by the Agora Server.

#### First Remote Audio Frame Received Callback (firstRemoteAudioFrameOfUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteAudioFrameOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed;
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



#### Data Stream Received Callback (receiveStreamMessageFromUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine receiveStreamMessageFromUid:(NSUInteger)uid streamId:(NSInteger)streamId data:(NSData * _Nonnull)data;
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
<td>Data received by the recipients.</td>
</tr>
</tbody>
</table>



#### Data Stream Sent Failure Callback (didOccurStreamMessageErrorFromUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOccurStreamMessageErrorFromUid:(NSUInteger)uid streamId:(NSInteger)streamId error:(NSInteger)error missed:(NSInteger)missed cached:(NSInteger)cached;
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
<p>For more error code descriptions, see <a href="the_error_native"><span>Error Codes and Warning Codes</span></a>.</p>
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



#### Active Speaker Detected Callback (ActiveSpeaker)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine activeSpeaker:(NSUInteger)speakerUid;
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
<tr><td>speakerUid</td>
<td>The UID of the active speaker. By default, 0 means the local user. If needed, you can also add relative functions on your App, for example, the active speaker, once detected, will have his/her head portrait zoomed in.</td>
</tr>
</tbody>
</table>

> -   You need to call `enableAudioVolumeIndication` to receive this callback.
> -   The active speaker means the uid of the speaker who speaks at the highest volume during a certain period of time.


Refer to the following code for the logic:

```
 - (void)rtcEngine:(AgoraRtcEngineKit *)engine activeSpeaker:(NSUInteger)speakerUid {
[self switchToMainViewOfSpeaker:speakerUid];
}
```

#### User Role Changed Callback (didClientRoleChanged)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole;
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



#### API Call Executed Callback (didApiCallExecute)

```
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didApiCallExecute:(NSInteger)error api:(NSString * _Nonnull)api result:(NSString * _Nonnull)result;
```

This callback indicates that the API call has been executed.

<table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Method</th>
<th>API String Parameter</th>
<th>Status Code</th>
</tr>
</thead>
<tbody>
<tr><td>settRemoteVideoStream</td>
<td>rtc.video.set_remote_video_stream</td>
<td>See <a href="the_error_native"><span>Error Codes and Warning Codes</span></a></td>
</tr>
</tbody>
</table>



#### Token Expired Callback (rtcEngineRequestToken)

```
- (void)rtcEngineRequestToken:(AgoraRtcEngineKit * _Nonnull)engine;
```

If a Token is specified when calling joinChannelByToken, and due to Token will be expired after a certain amount of time, and if SDK lost the connection with the Agora server out of network issues, it might need a new Token to reconnect to the server.

This callback notifies the application of generating a new Token, and calling renewtoken to specify the newly generated Token.

This function was previously provided in the callback report of didOccurError(): ERR_TOKEN_EXPIRED(109), ERR_INVALID_TOKEN(110). Starting from v1.7.3, the old method is still working, but it is recommended for you to put the related logic in this callback.

This function was previously provided when the callback reported didOccurError(): ERR_CHANNEL_KEY_EXPIRED(109)、ERR_INVALID_CHANNEL_KEY(110). Starting from v1.7.3, the old method still works, but it is recommended to use this callback.

#### Local Audio Mixing Playback Finished Callback (rtcEngineLocalAudioMixingDidFinish)

```
- (void)rtcEngineLocalAudioMixingDidFinish:(AgoraRtcEngineKit * _Nonnull)engine;
```

This callback is triggered when the audio mixing file playback is finished after calling `startAudioMixing`. If you failed to execute the `startAudioMixing` method, it returns the error code in the `didOccurError` callback.

#### Local Audio Effect Playback Finished Callback (rtcEngineDidAudioEffectFinish)

```
- (void)rtcEngineDidAudioEffectFinish:(AgoraRtcEngineKit * _Nonnull)engine soundId:(NSInteger)soundId;
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
<tr><td>soundId</td>
<td>ID of the audio effect. Each audio effect has a unique ID.</td>
</tr>
</tbody>
</table>



#### Remote Audio Mixing Started Callback (rtcEngineRemoteAudioMixingDidStart)

```
- (void)rtcEngineRemoteAudioMixingDidStart:(AgoraRtcEngineKit * _Nonnull)engine;
```

This callback is triggered when a remote host calls `startAudioMixing`.

#### Remote Audio Mixing Stopped Callback (rtcEngineRemoteAudioMixingDidFinish)

```
- (void)rtcEngineRemoteAudioMixingDidFinish:(AgoraRtcEngineKit * _Nonnull)engine;
```

This callback is triggered when a remote host stops calling `startAudioMixing`.

<a id = "block"></a>
### Block Callbacks

The SDK supports Block callbacks to report runtime events to the application. From version 1.1, some Block callbacks in the SDK are replaced with Delegate methods. The old Block callbacks are therefore being deprecated, but can still be used in current versions. However, we recommend replacing them with Delegate methods. The SDK calls the Block method if a callback is defined in both Block and Delegate. If you want to use the Delegate methods, set the Block attribute of the method as nil. The following section describes each of the callback methods in the SDK.

#### Other User Joined Callback (userJoinedBlock)

```
- (void)userJoinedBlock:(void(^)
(NSUInteger uid, NSInteger elapsed))userJoinedBlock;
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
<tr><td>If the uid is specified in the joinChannelByToken method, returns the specified ID; if not, returns an ID that is automatically allocated by the Agora server.</td>
</tr>
<tr><td>elapsed</td>
<td>Time elapsed (ms) from calling joinChannelByToken until this callback is triggered.</td>
</tr>
</tbody>
</table>



#### Other User offline Callback (userOfflineBlock)

```
- (void)userOfflineBlock:(void(^)
(NSUInteger uid))userOfflineBlock;
```

This callback indicates that a user has left the call or gone offline.

The SDK reads the timeout data to determine if a user has left the channel (or has gone offline). If no data package is received from the user in 15 seconds, the SDK assumes the user is offline. Sometimes a weak network connection may lead to false detections, therefore we recommend using signaling for reliable offline detection.

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
</tbody>
</table>



#### Rejoin Channel Callback (rejoinChannelSuccessBlock)

```
 - (void)rejoinChannelSuccessBlock:(void(^)(NSString* channel,
NSUInteger uid, NSInteger elapsed))rejoinChannelSuccessBlock;
```

When the local machine loses connection with the server because of network problems, the SDK automatically attempts to reconnect, and then triggers this callback method upon reconnection. The callback indicates that the user has rejoined the channel with an assigned channel ID and user ID.

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
<td>Time delay (ms) in rejoining the channel.</td>
</tr>
</tbody>
</table>



#### User Left Channel Callback (leaveChannelBlock)

```
- (void)leaveChannelBlock:(void(^)
(AgoraRtcStats* stat))leaveChannelBlock;
```

This callback indicates that a user has left the channel, and it also provides call session statistics including the duration of the call and tx/rx bytes.

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
<tr><td>stat</td>
<td>See the table below.</td>
</tr>
</tbody>
</table>



<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>AgoraRtcStats</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>duration</td>
<td>Call duration (s), represented by an aggregate value.</td>
</tr>
<tr><td>txBytes</td>
<td>Total number of bytes transmitted, represented by an aggregate value.</td>
</tr>
<tr><td>rxBytes</td>
<td>Total number of bytes received, represented by an aggregate value.</td>
</tr>
</tbody>
</table>



#### RtcEngine Statistics Callback (rtcStatsBlock)

```
- (void)rtcStatsBlock:(void(^)
(AgoraRtcStats* stat))rtcStatsBlock;
```

This callback is triggered once every two seconds to update the application on RtcEngine runtime statistics.

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
<tr><td>stat</td>
<td>See the table below.</td>
</tr>
</tbody>
</table>



<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>AgoraRtcStats</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>duration</td>
<td>Call duration (s), represented by an aggregate value.</td>
</tr>
<tr><td>txBytes</td>
<td>Total number of bytes transmitted, represented by an aggregate value.</td>
</tr>
<tr><td>rxBytes</td>
<td>Total number of bytes received, represented by an aggregate value.</td>
</tr>
</tbody>
</table>



#### Audio Volume Indication Callback (audioVolumeIndicationBlock)

```
- (void)audioVolumeIndicationBlock:(void(^)(NSArray *speakers,
NSInteger totalVolume))audioVolumeIndicationBlock;
```

This callback indicates who is talking and the speaker’s volume. By default it is disabled. If needed, use the enableAudioVolumeIndication method to configure it.

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
<td>The speakers (array). Each speaker ():</td>
</tr>
<tr><td>uid: User ID of the speaker.</td>
</tr>
<tr><td>volume：Volume of the speaker, between 0 (lowest volume) to 255 (highest volume).</td>
</tr>
<tr><td>totalVolume</td>
<td>The total volume after audio mixing between 0 (lowest volume) to 255 (highest volume).</td>
</tr>
</tbody>
</table>



#### Other User Muted Audio Callback (userMuteAudioBlock)

```
- (void)userMuteAudioBlock:(void(^)
(NSUInteger uid, bool muted))userMuteAudioBlock;
```

This callback indicates that a user has muted/unmuted his/her audio stream.

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
<td>Yes: Muted audio.</td>
</tr>
<tr><td>No: Unmuted audio.</td>
</tr>
</tbody>
</table>



#### Audio Quality Callback (audioQualityBlock)

```
- (void)audioQualityBlock:(void(^)(NSUInteger uid,
AgoraNetworkQuality quality,  NSUInteger delay,
NSUInteger lost))audioQualityBlock;
```

During a conversation, this callback is triggered once every two seconds to report on the audio quality of the current call.

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
<li>AgoraNetworkQualityUnknown(0): The network quality is unknown.</li>
<li>AgoraNetworkQualityExcellent(1): The network quality is excellent.</li>
<li>AgoraNetworkQualityGood(2): The network quality is quite good, but the bitrate may be slightly lower than excellent.</li>
<li>AgoraNetworkQualityPoor(3): Users can feel the communication slightly impaired.</li>
<li>AgoraNetworkQualityBad(4): Users can communicate only not very smoothly.</li>
<li>AgoraNetworkQualityVBad(5): The network is so bad that users can hardly communicate.</li>
<li>AgoraNetworkQualityDown(6): Users cannot communicate at all.</li>
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



#### Network Quality Callback (lastmileQualityBlock)

```
- (void)lastmileQualityBlock:(void(^)
(AgoraNetworkQuality quality))lastmileQualityBlock;
```

This callback is triggered once every two seconds during a call to report on the network quality.

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
<tr><td>quality</td>
<td>Rating of the network quality:</td>
</tr>
<tr><td>AgoraRtc_Quality_Unknown = 0</td>
</tr>
<tr><td>AgoraRtc_Quality_Excellent = 1</td>
</tr>
<tr><td>AgoraRtc_Quality_Good = 2</td>
</tr>
<tr><td>AgoraRtc_Quality_Poor = 3</td>
</tr>
<tr><td>AgoraRtc_Quality_Bad = 4</td>
</tr>
<tr><td>AgoraRtc_Quality_VBad = 5</td>
</tr>
<tr><td>AgoraRtc_Quality_Down = 6</td>
</tr>
</tbody>
</table>



#### Connection Lost Callback (connectionLostBlock)

```
- (void)connectionLostBlock:(void(^)())connectionLostBlock;
```

This callback indicates that the SDK has lost network connection with the server.

#### Data Stream Received Callback (receiveStreamMessageFromUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine receiveStreamMessageFromUid:(NSUInteger)uid streamId:(NSInteger)streamId data:(NSData*)data;
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
<td>Data received by the recipients.</td>
</tr>
</tbody>
</table>



#### Data Stream Sent Failure Callback (didOccurStreamMessageErrorFromUid)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurStreamMessageErrorFromUid:(NSUInteger)uid streamId:(NSInteger)streamId error:(NSInteger)error missed:(NSInteger)missed cached:(NSInteger)cached;
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
<li>ERR_SIZE_TOO_LARGE=114, data size is too big</li>
<li>ERR_BITRATE_LIMIT=115, limited bitrate</li>
<li>ERR_TOO_MANY_DATA_STREAMS =116, too many data streams</li>
<li>ERR_STREAM_MESSAGE_TIMEOUT=117, data stream timed out</li>
</ul>
<p>For more error code descriptions, see <a href="the_error_native"><span>Error Codes and Warning Codes</span></a>.</p>
</td>
</tr>
<tr/>
<tr/>
<tr/>
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



#### User Role Changed Callback (didClientRoleChanged)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole;
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



#### Audio Route Changed Callback (didAudioRouteChanged)

```
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didAudioRouteChanged:(AgoraAudioOutputRouting)routing;
```

This callback is triggered when the audio routing is changed. The definition of AgoraAudioOutputRouting is listed as follows:

```
typedef NS_ENUM(NSInteger, AgoraAudioOutputRouting)
{
    AgoraAudioOutputRoutingDefault = -1,
    AgoraAudioOutputRoutingHeadset = 0,
    AgoraAudioOutputRoutingEarpiece = 1,
    AgoraAudioOutputRoutingHeadsetNoMic = 2,
    AgoraAudioOutputRoutingSpeakerphone = 3,
    AgoraAudioOutputRoutingLoudspeaker = 4,
    AgoraAudioOutputRoutingHeadsetBluetooth = 5
};
```


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
<td>App ID issued to application developers by Agora. Apply for a new one from Agora if the key is missing from your kit. See <a href="../Agora Platform/token#app-id-native"><span>Getting an App ID</span></a> for more information to how to get an App ID.</td>
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

> [4] The error code is related to the positive integer displayed in [Error Codes and Warning Codes](/en/API%20Reference/the_error_native), for example, if it returns -2, then it indicates 2: ERR_INVALID_ARGUMENT in [Error Codes and Warning Codes](/en/API%20Reference/the_error_native).

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

> The default log file location is at: Library/caches/agorasdk.log.

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
> This method is valid only when the user is in the channel. Once the user leaves the channel, all the mute states are reset.

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
> This method is valid only when the user is in the channel. Once the user leaves the channel, all the mute states are reset.

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
> This method is valid only when the user is in the channel. Once the user leaves the channel, all the mute states are reset.

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
<p>For more error code descriptions, see <a href="the_error_native"><span>Error Codes and Warning Codes</span></a></p>
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



### Error Codes

See [Error Codes and Warning Codes](/en/API%20Reference/the_error_native).

