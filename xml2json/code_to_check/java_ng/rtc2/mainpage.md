# Agora High-Level API Reference for All Platforms

Agora provides ensured quality of experience (QoE) for worldwide Internet-based voice and video communications through a virtual global network optimized for real-time web and mobile-to-mobile applications.

-   This page provides [Reference for Agora high-level APIs](#agora-high-level-api-reference-for-java).
    -   [Channel management](#channelmanagement)
    -   [Channel events](#channelevents)
    -   [Audio management](#audiomanagement)
    -   [Video management](#videomanagement)
    -   [Local media events](#localmedia)
    -   [Remote media events](#remotemedia)
    -   [Statistics events](#statisticsevents)
    -   [Multiple channels](#multichannels)
    -   [Audio route](#audioroute)
    -   [Audio volume indication](#audiovolumeindication)
    -   [Audio file playback and mixing](#audiomixing)
    -   [Audio effect playback](#audioeffect)
    -   [Voice changer and reverberation](#voicechanger)
    -   [In-ear monitor](#inearmonitor)
    -   [Last-mile test](#lastmiletest)
    -   [Dual video stream](#dualvideostream)
    -   [Channel media relay](#channelmediarelay)
    -   [External audio data](#externalaudiodata)
    -   [External video data](#externalvideodata)
    -   [Raw audio data](#rawaudiodata)
    -   [Raw Video Data](#rawvideodata)
    -   [Media metadata](#mediametadata)
    -   [Stream message](#streammessage)
    -   [Camera control](#cameracontrol)
    -   [Miscellaneous methods](#miscmethods)
    -   [Miscellaneous events](#miscevents)

<a name="channelmanagement"></a>

### Channel management

| Method                                                                                                                         | Description                                                      |
| ------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#create(Context context, String appId, IRtcEngineEventHandler handler) create1}                  | Creates an RtcEngine instance.                                   |
| {@link io.agora.rtc2.RtcEngine#create(RtcEngineConfig config) create2}                                                         | Creates an RtcEngine instance and specifies the connection area. |
| {@link io.agora.rtc2.RtcEngine#destroy destroy}                                                                                | Releases the IRtcEngine object.                                  |
| {@link io.agora.rtc2.RtcEngine#setChannelProfile setChannelProfile}                                                            | Sets the channel profile.                                        |
| {@link io.agora.rtc2.RtcEngine#joinChannel joinChannel1}                                                                       | Joins a channel.                                                 |
| {@link io.agora.rtc2.RtcEngine#joinChannel(String token, String channelId, int uid, ChannelMediaOptions options) joinChannel2} | Joins a channel with media options.                              |
| {@link io.agora.rtc2.RtcEngine#updateChannelMediaOptions updateChannelMediaOptions}                                            | Updates the channel media options after joining a channel.       |
| {@link io.agora.rtc2.RtcEngine#leaveChannel leaveChannel}                                                                      | Leaves the channel.                                              |
| {@link io.agora.rtc2.RtcEngine#setClientRole setClientRole}                                                                    | Sets the role of the user.                                       |
| {@link io.agora.rtc2.RtcEngine#renewToken renewToken}                                                                          | Renews the token.                                                |
| {@link io.agora.rtc2.RtcEngine#getConnectionState getConnectionState}                                                          | Gets the connection state of the app.                            |

<a name="channelevents"></a>

### Channel events

| Event                                                                                             | Description                                                                                                       |
| ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onJoinChannelSuccess onJoinChannelSuccess}            | Occurs when the local user successfully joins the specified channel.                                              |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onRejoinChannelSuccess onRejoinChannelSuccess}        | Occurs when the local user rejoins the channel after being disconnected dut ro network problems.                  |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onClientRoleChanged onClientRoleChanged}              | Occurs when the user role in a Live-Broadcast channel has switched.                                               |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onLeaveChannel onLeaveChannel                         | Occurs when the local user successfully leaves the channel.                                                       |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onUserJoined onUserJoined                             | Occurs when a remote user or broadcaster joins the channel.                                                       |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onUserOffline onUserOffline}                          | Occurs when a remote user or broadcaster goes offline.                                                            |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onConnectionLost onConnectionLost                     | Occurs when the SDK cannot reconnect to the server 10 seconds after its connections to the server is interrupted. |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onRequestToken onRequestToken                         | Occurs when the token has expired.                                                                                |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onTokenPrivilegeWillExpire onTokenPrivilegeWillExpire | Occurs when the token will expire in 30 seconds.                                                                  |

<a name="audiomanagement"></a>

### Audio management

| Method                                                                                                  | Description                                                        |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| {@link io.agora.rtc2.RtcEngine#enableAudio enableAudio}                                                 | Enables the audio.                                                 |
| {@link io.agora.rtc2.RtcEngine#disableAudio disableAudio}                                               | Disables the audio.                                                |
| {@link io.agora.rtc2.RtcEngine#setAudioProfile(int profile, int scenario) setAudioProfile1}             | Sets the audio parameters and application scenarios.               |
| {@link io.agora.rtc2.RtcEngine#setAudioProfile(int profile) setAudioProfile2}                           | Sets the audio profile.                                            |
| {@link io.agora.rtc2.RtcEngine#adjustRecordingSignalVolume adjustRecordingSignalVolume}                 | Adjusts the recording volume.                                      |
| {@link io.agora.rtc2.RtcEngine#enableLocalAudio enableLocalAudio}                                       | Enables or disables the local audio capture.                       |
| {@link io.agora.rtc2.RtcEngine#muteLocalAudioStream muteLocalAudioStream}                               | Stops or resumes sending the local audio stream.                   |
| {@link io.agora.rtc2.RtcEngine#muteRemoteAudioStream muteRemoteAudioStream}                             | Stops or resumes receiving the audio stream of a specified user.   |
| {@link io.agora.rtc2.RtcEngine#muteAllRemoteAudioStreams muteAllRemoteAudioStreams}                     | Stops or resumes receiving all remote audio streams.               |
| {@link io.agora.rtc2.RtcEngine#setDefaultMuteAllRemoteAudioStreams setDefaultMuteAllRemoteAudioStreams} | Determines whether to receive all remote audio streams by default. |

<a name="videomanagement"></a>

### Video management

| Method                                                                                                  | Description                                                        |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| {@link io.agora.rtc2.RtcEngine#enableVideo enableVideo}                                                 | Enables the video.                                                 |
| {@link io.agora.rtc2.RtcEngine#disableVideo disableVideo}                                               | Disables the video.                                                |
| {@link io.agora.rtc2.RtcEngine#startPreview startPreview}                                               | Starts the local video preview before joining a channel.           |
| {@link io.agora.rtc2.RtcEngine#stopPreview stopPreview}                                                 | Stops the local video preview.                                     |
| {@link io.agora.rtc2.RtcEngine#setupLocalVideo setupLocalVideo}                                         | Initializes the local video view.                                  |
| {@link io.agora.rtc2.RtcEngine#setupRemoteVideo setupRemoteVideo}                                       | Initializes the video view of a remote user.                       |
| {@link io.agora.rtc2.RtcEngine#setLocalRenderMode setLocalRenderMode}                                   | Updates the display mode of the local video view.                  |
| {@link io.agora.rtc2.RtcEngine#setRemoteRenderMode setRemoteRenderMode}                                 | Updates the display mode of the video view of a remote user.       |
| {@link io.agora.rtc2.RtcEngine#enableLocalVideo enableLocalVideo}                                       | Disables or re-enables the local video capture.                    |
| {@link io.agora.rtc2.RtcEngine#muteLocalVideoStream muteLocalVideoStream}                               | Stops or resumes sending the local video stream.                   |
| {@link io.agora.rtc2.RtcEngine#muteRemoteVideoStream muteRemoteVideoStream}                             | Stops or resumes receiving the video stream of a specified user.   |
| {@link io.agora.rtc2.RtcEngine#muteAllRemoteVideoStreams muteAllRemoteVideoStreams}                     | Stops or resumes receiving all remote video streams.               |
| {@link io.agora.rtc2.RtcEngine#setDefaultMuteAllRemoteVideoStreams setDefaultMuteAllRemoteVideoStreams} | Determines whether to receive all remote video streams by default. |

<a name="localmedia"></a>

### Local media events

| Event                                                                                                        | Description                                     |
| ------------------------------------------------------------------------------------------------------------ | ----------------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onLocalAudioStateChanged onLocalAudioStateChanged}               | Occurs when the local audio state changes.      |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onLocalVideoStateChanged onLocalVideoStateChanged}               | Occurs when the local video state changes.      |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onFirstLocalAudioFramePublished onFirstLocalAudioFramePublished} | Occurs when the first audio frame is published. |

<a name="remotemedia"></a>

### Remote media events

| Event                                                                                            | Description                                |
| ------------------------------------------------------------------------------------------------ | ------------------------------------------ |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onRemoteAudioStateChanged onRemoteAudioStateChanged} | Occurs when the remote audio state changes |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onRemoteVideoStateChanged onRemoteVideoStateChanged} | Occurs when the remote video state changes |

<a name="statisticsevents"></a>

### Statistics events

| Event                                                                              | Description                                 |
| ---------------------------------------------------------------------------------- | ------------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onLocalAudioStats onLocalAudioStats}   | Reports the statistics of the local audio.  |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onRemoteAudioStats onRemoteAudioStats} | Reports the statistics of the remote audio. |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onRtcStats onRtcStats}                 | Reports the statistics of the current call. |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onNetworkQuality onNetworkQuality}     | Reports the network quality of each user.   |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onLocalVideoStats onLocalVideoStats}   | Reports the statistics of the local video.  |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onRemoteVideoStats onRemoteVideoStats} | Reports the statistics of the remote video. |

<a name="audiovolumeindication"></a>

### Audio volume indication

| Method                                                                                  | Description                                                                                                    |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#enableAudioVolumeIndication enableAudioVolumeIndication} | Enables the `onAudioVolumeIndication` callback to report on which users are speaking and the speakers' volume. |

| Event                                                                                        | Description                                                |
| -------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onAudioVolumeIndication onAudioVolumeIndication} | Reports which users are speaking and the speaker's volume. |

<a name="audiomixing"></a>

### Music file playback and mixing

| Method                                                                                      | Description                                                 |
| ------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#startAudioMixing startAudioMixing}                           | Starts playing and mixing the music file.                   |
| {@link io.agora.rtc2.RtcEngine#stopAudioMixing stopAudioMixing}                             | Stops playing or mixing the music file.                     |
| {@link io.agora.rtc2.RtcEngine#pauseAudioMixing pauseAudioMixing}                           | Pauses playing and mixing the music file.                   |
| {@link io.agora.rtc2.RtcEngine#resumeAudioMixing resumeAudioMixing}                         | Resumes playing and mixing the music file.                  |
| {@link io.agora.rtc2.RtcEngine#adjustAudioMixingVolume adjustAudioMixingVolume}             | Adjusts the volume of audio mixing.                         |
| {@link io.agora.rtc2.RtcEngine#getAudioMixingDuration getAudioMixingDuration}               | Gets the duration (ms) of the music file.                   |
| {@link io.agora.rtc2.RtcEngine#getAudioMixingCurrentPosition getAudioMixingCurrentPosition} | Gets the playback position (ms) of the music file.          |
| {@link io.agora.rtc2.RtcEngine#setAudioMixingPosition setAudioMixingPosition}               | Sets the playback starting position (ms) of the music file. |

| Event                                                                                            | Description                                                          |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onAudioMixingStateChanged onAudioMixingStateChanged} | Occurs when the state of the local user's audio mixing file changes. |

<a name="audioeffect"></a>

### Audio effect playback

| Method                                                              | Description                                                   |
| ------------------------------------------------------------------- | ------------------------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#getEffectsVolume getEffectsVolume}   | Gets the volume of the audio effects.                         |
| {@link io.agora.rtc2.RtcEngine#setEffectsVolume setEffectsVolume}   | Sets the volume of audio effects.                             |
| {@link io.agora.rtc2.RtcEngine#setVolumeOfEffect setVolumeOfEffect} | Sets the volume of the specified audio effect.                |
| {@link io.agora.rtc2.RtcEngine#playEffect playEffect}               | Plays a specified audio effect.                               |
| {@link io.agora.rtc2.RtcEngine#stopEffect stopEffect}               | Stops playing the specified audio effect.                     |
| {@link io.agora.rtc2.RtcEngine#stopAllEffects stopAllEffects}       | Stops playing all audio effects.                              |
| {@link io.agora.rtc2.RtcEngine#preloadEffect preloadEffect}         | Preloads a specified audio effect.                            |
| {@link io.agora.rtc2.RtcEngine#unloadEffect unloadEffect}           | Releases the specific preloaded audio effect from the memory. |
| {@link io.agora.rtc2.RtcEngine#unloadAllEffects unloadAllEffects}   | Releases all preloaded audio effects from the memory.         |
| {@link io.agora.rtc2.RtcEngine#pauseEffect pauseEffect}             | Pauses playing the specified audio effect.                    |
| {@link io.agora.rtc2.RtcEngine#pauseAllEffects pauseAllEffects}     | Pauses playing all audio effects.                             |
| {@link io.agora.rtc2.RtcEngine#resumeEffect resumeEffect}           | Resumes playing the specified audio effect.                   |
| {@link io.agora.rtc2.RtcEngine#resumeAllEffects resumeAllEffects}   | Resumes playing all audio effects.                            |

<a name="voicechanger"></a>

### Voice changer and reverberation

| Method                                                                              | Description                                |
| ----------------------------------------------------------------------------------- | ------------------------------------------ |
| {@link io.agora.rtc2.RtcEngine#setLocalVoiceChanger setLocalVoiceChanger}           | Sets the local voice changer option.       |
| {@link io.agora.rtc2.RtcEngine#setLocalVoiceReverbPreset setLocalVoiceReverbPreset} | Sets the local voice reverberation option. |

<a name="inearmonitor"></a>

### In-ear monitor

| Method                                                                            | Description                               |
| --------------------------------------------------------------------------------- | ----------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#enableInEarMonitoring enableInEarMonitoring}       | Enables in-ear monitoring.                |
| {@link io.agora.rtc2.RtcEngine#setInEarMonitoringVolume setInEarMonitoringVolume} | Sets the volume of the in-ear monitoring. |

<a name="lastmiletest"></a>

### Last-mile test

| Method                                                                        | Description                              |
| ----------------------------------------------------------------------------- | ---------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#startLastmileProbeTest startLastmileProbeTest} | Starts the last-mile network probe test. |
| {@link io.agora.rtc2.RtcEngine#stopLastmileProbeTest stopLastmileProbeTest}   | Stops the last-mile network probe test.  |

| Event                                                                                    | Description                                |
| ---------------------------------------------------------------------------------------- | ------------------------------------------ |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onLastmileProbeResult onLastmileProbeResult} | Reports the lastmile network probe result. |

<a name="dualvideostream"></a>

### Dual video stream

| Method                                                                                          | Description                                                                                  |
| ----------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#enableDualStreamMode enableDualStreamMode}                       | Enables or disables the dual video stream mode.                                              |
| {@link io.agora.rtc2.RtcEngine#setRemoteVideoStreamType setRemoteVideoStreamType}               | Sets the remote video stream type.                                                           |
| {@link io.agora.rtc2.RtcEngine#setRemoteDefaultVideoStreamType setRemoteDefaultVideoStreamType} | Sets the default stream type of the remote video if the remote user has enabled dual-stream. |

<a name="channelmediarelay"></a>

### Channel media relay

| Method                                                                        | Description                                    |
| ----------------------------------------------------------------------------- | ---------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#startChannelMediaRelay startChannelMediaRelay} | Starts to relay media streams across channels. |
| {@link io.agora.rtc2.RtcEngine#stopChannelMediaRelay stopChannelMediaRelay}   | Stops the media stream relay.                  |

| Event                                                                                                        | Description                                              |
| ------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onChannelMediaRelayStateChanged onChannelMediaRelayStateChanged} | Occurs when the state of the media stream relay changes. |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onChannelMediaRelayEvent onChannelMediaRelayEvent}               | Reports events during the media stream relay.            |

<a name="externalaudiodata"></a>

### External audio data

| Method                                                                        | Description                                |
| ----------------------------------------------------------------------------- | ------------------------------------------ |
| {@link io.agora.rtc2.RtcEngine#setExternalAudioSource setExternalAudioSource} | Sets the external audio source.            |
| {@link io.agora.rtc2.RtcEngine#pushExternalAudioFrame pushExternalAudioFrame  | Pushes the external audio data to the app. |

<a name="externalvideodata"></a>

### External video data

| Method                                                                                                | Description                                 |
| ----------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#setExternalVideoSource setExternalVideoSource}                         | Sets the external video source.             |
| {@link io.agora.rtc2.RtcEngine#pushExternalVideoFrame(AgoraVideoFrame frame) pushExternalVideoFrame1} | Pushes the external video frame to the SDK. |
| {@link io.agora.rtc2.RtcEngine#pushExternalVideoFrame(VideoFrame frame) pushExternalVideoFrame2}      | Pushes the external video frame to the SDK. |
| {@link io.agora.rtc2.RtcEngine#pushExternalEncodedVideoFrame pushExternalEncodedVideoFrame}           | Pushes the encoded video image to the app.  |

<a name="rawvideodata"></a>

### Raw Video Data

> You can also use the C++ methods for raw video data.
>
> | Method                                                                                | Description                              |
> | ------------------------------------------------------------------------------------- | ---------------------------------------- |
> | {@link io.agora.rtc2.RtcEngine#registerVideoFrameObserver registerVideoFrameObserver} | Registers a video frame observer object. |

| Event                                                                                   | Description                                                                   |
| --------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| {@link io.agora.rtc2.video.IVideoFrameObserver#onCaptureVideoFrame onCaptureVideoFrame} | Occurs each time The SDK receives a video frame captured by the local camera. |
| {@link io.agora.rtc2.video.IVideoFrameObserver#onRenderVideoFrame onRenderVideoFrame}   | Occurs each time the SDK receives a video frame sent by the remote user.      |

<a name="mediametadata"></a>

### Media metadata

> This group of methods apply to `LIVE_BROADCASTING` profile only.
> Do not implement {@link io.agora.rtc2.IMetadataObserver#getMaxMetadataSize getMaxMetadataSize}, {@link io.agora.rtc2.IMetadataObserver#onReadyToSendMetadata onReadyToSendMetadata}, and {@link io.agora.rtc2.IMetadataObserver#onMetadataReceived onMetadataReceived} in the `IRtcEngineEventHandler` class.

| Method                                                                                      | Description                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#registerMediaMetadataObserver registerMediaMetadataObserver} | Registers a media metadata observer object. |

| Event                                                                               | Description                                                    |
| ----------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| {@link io.agora.rtc2.IMetadataObserver#getMaxMetadataSize getMaxMetadataSize}       | Occurs when the SDK requests the maximum size of the metadata. |
| {@link io.agora.rtc2.IMetadataObserver#onReadyToSendMetadata onReadyToSendMetadata} | Occurs when the SDK is ready to receive and send metadata.     |
| {@link io.agora.rtc2.IMetadataObserver#onMetadataReceived onMetadataReceived}       | Occurs when the local user receives the metadata.              |

<a name="streammessage"></a>

### Stream message

| Method                                                              | Description                 |
| ------------------------------------------------------------------- | --------------------------- |
| {@link io.agora.rtc2.RtcEngine#createDataStream createDataStream}   | Creates a data stream.      |
| {@link io.agora.rtc2.RtcEngine#sendStreamMessage sendStreamMessage} | Sends data stream messages. |

| Event                                                                                  | Description                                                                   |
| -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onStreamMessage onStreamMessage}           | Occurs when the local user receives a remote data stream within five seconds. |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onStreamMessageError onStreamMessageError} | Occurs when the local user fails to receive the remote data stream.           |

<a name="cameracontrol"></a>

### Camera control

| Method                                                      | Description                              |
| ----------------------------------------------------------- | ---------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#switchCamera() switchCamera} | Switches between front and rear cameras. |

<a name="miscmethods"></a>

### Miscellaneous methods

| Method                                                                          | Description                                       |
| ------------------------------------------------------------------------------- | ------------------------------------------------- |
| {@link io.agora.rtc2.RtcEngine#sendCustomReportMessage sendCustomReportMessage} | Reports customized messages.                      |
| {@link io.agora.rtc2.RtcEngine#getCallId getCallId}                             | Gets the current call ID.                         |
| {@link io.agora.rtc2.RtcEngine#rate rate}                                       | Allows a user to rate the call.                   |
| {@link io.agora.rtc2.RtcEngine#complain complain}                               | Allows a user to complain about the call quality. |
| {@link io.agora.rtc2.RtcEngine#getSdkVersion getSdkVersion}                     | Gets the SDK version.                             |
| {@link io.agora.rtc2.RtcEngine#setLogFile setLogFile}                           | Specifies an SDK output log file.                 |
| {@link io.agora.rtc2.RtcEngine#setLogFilter setLogFilter}                       | Sets the output log level of the SDK.             |
| {@link io.agora.rtc2.RtcEngine#setLogLevel setLogLevel}                         | Sets the output log level of the SDK.             |
| {@link io.agora.rtc2.RtcEngine#addHandler addHandler}                           | Adds the IRtcEngineEventHandler instance.         |

<a name="miscevents"></a>

### Miscellaneous events

| Method                                                                           | Description                            |
| -------------------------------------------------------------------------------- | -------------------------------------- |
| {@link io.agora.rtc2.IRtcEngineEventHandler#onApiCallExecuted onApiCallExecuted} | Occurs when an API method is executed. |
