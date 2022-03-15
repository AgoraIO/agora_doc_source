# API Overview

Agora provides ensured quality of experience (QoE) for worldwide Internet-based voice and video communications through SD-RTN™.

## Channel management

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [createAgoraRtcEngine](class_irtcengine.html#api_createagorartcengine) | Creates the IRtcEngine object.                               |
| [initialize](class_irtcengine.html#api_create2)              | Initializes IRtcEngine.                                      |
| [release](class_irtcengine.html#api_release)                 | Releases the IRtcEngine instance.                            |
| [setChannelProfile](class_irtcengine.html#api_setchannelprofile) | Sets the channel profile.                                    |
| [joinChannel [1/2\]](class_irtcengine.html#api_joinchannel)  | Joins a channel.                                             |
| [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng) | Joins a channel with media options.                          |
| [updateChannelMediaOptions](class_irtcengine.html#api_updatechannelmediaoptions) | Updates the channel media options after joining the channel. |
| [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) | Leaves a channel.                                            |
| [leaveChannel [2/2\]](class_irtcengine.html#api_leavechannel2) | Leaves a channel.                                            |
| [renewToken](class_irtcengine.html#api_renewtoken)           | Gets a new token when the current token expires after a period of time. |
| [setClientRole [1/2\]](class_irtcengine.html#api_setclientrole) | Sets the client role.                                        |
| [setClientRole [2/2\]](class_irtcengine.html#api_setclientrole2) | Sets the user role and level in an interactive live streaming channel. |
| [getConnectionState](class_irtcengine.html#api_getconnectionstate) | Gets the current connection state of the SDK.                |

## Channel events

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess) | Occurs when a user joins a channel.                          |
| [onRejoinChannelSuccess](class_irtcengineeventhandler.html#callback_onrejoinchannelsuccess) | Occurs when a user rejoins the channel.                      |
| [onClientRoleChanged](class_irtcengineeventhandler.html#callback_onclientrolechanged) | Occurs when the user role switches in the interactive live streaming. |
| [onLeaveChannel](class_irtcengineeventhandler.html#callback_onleavechannel) | Occurs when a user leaves a channel.                         |
| [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) | Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel. |
| [onUserOffline](class_irtcengineeventhandler.html#callback_onuseroffline) | Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) leaves the channel. |
| [onUserMuteAudio](class_irtcengineeventhandler.html#callback_onusermuteaudio) | Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) joins the channel. |
| [onNetworkTypeChanged](class_irtcengineeventhandler.html#callback_onnetworktypechanged) | Occurs when the local network type changes.                  |
| [onUplinkNetworkInfoUpdated](class_irtcengineeventhandler.html#callback_onuplinknetworkinfoupdated) | Occurs when the uplink network information changes.          |
| [onConnectionLost](class_irtcengineeventhandler.html#callback_onconnectionlost) | Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted. |
| [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) | Occurs when the network connection state changes.            |
| [onRequestToken](class_irtcengineeventhandler.html#callback_onrequesttoken) | Occurs when the token expires.                               |
| [onTokenPrivilegeWillExpire](class_irtcengineeventhandler.html#callback_ontokenprivilegewillexpire) | Occurs when the token expires in 30 seconds.                 |

## Audio management

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [enableAudio](class_irtcengine.html#api_enableaudio)         | Enables the audio module.                                    |
| [disableAudio](class_irtcengine.html#api_disableaudio)       | Disables the audio module.                                   |
| [setAudioProfile [1/2\]](class_irtcengine.html#api_setaudioprofile) | Sets the audio profile and audio scenario.                   |
| [setAudioProfile [2/2\]](class_irtcengine.html#api_setaudioprofile2) | Sets the audio parameters and application scenarios.         |
| [adjustRecordingSignalVolume](class_irtcengine.html#api_adjustrecordingsignalvolume) | Adjusts the capturing signal volume.                         |
| [adjustUserPlaybackSignalVolume](class_irtcengine.html#api_adjustuserplaybacksignalvolume) | Adjusts the playback signal volume of a specified remote user. |
| [adjustPlaybackSignalVolume](class_irtcengine.html#api_adjustplaybacksignalvolume) | Adjusts the playback signal volume of all remote users.      |
| [adjustLoopbackRecordingVolume](class_irtcengine.html#api_adjustloopbackrecordingvolume) | Adjusts the volume of the signal captured by the sound card. |
| [enableLocalAudio](class_irtcengine.html#api_enablelocalaudio) | Enables/Disables the local audio capture.                    |
| [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream) | Stops or resumes publishing the local audio stream.          |
| [muteRemoteAudioStream](class_irtcengine.html#api_muteremoteaudiostream) | Stops or resumes subscribing to the audio stream of a specified user. |
| [muteAllRemoteAudioStreams](class_irtcengine.html#api_muteallremoteaudiostreams) | Stops or resumes subscribing to the audio streams of all remote users. |
| [setDefaultMuteAllRemoteAudioStreams](class_irtcengine.html#api_setdefaultmuteallremoteaudiostreams) | Stops or resumes subscribing to the audio streams of all remote users by default. |
| [getAudioDeviceInfo](class_irtcengine.html#api_getaudiodeviceinfo) | Gets the audio device information.                           |

## Video management

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [enableVideo](class_irtcengine.html#api_enablevideo)         | Enables the video module.                                    |
| [disableVideo](class_irtcengine.html#api_disablevideo)       | Disables the video module.                                   |
| [setVideoEncoderConfiguration](class_irtcengine.html#api_setvideoencoderconfiguration) | Sets the video encoder configuration.                        |
| [startPreview](class_irtcengine.html#api_startpreview)       | Enables the local video preview.                             |
| [stopPreview](class_irtcengine.html#api_stoppreview)         | Stops the local video preview.                               |
| [setupLocalVideo](class_irtcengine.html#api_setuplocalvideo) | Initializes the local video view.                            |
| [setupRemoteVideo](class_irtcengine.html#api_setupremotevideo) | Initializes the video view of a remote user.                 |
| [setLocalRenderMode [2/2\]](class_irtcengine.html#api_setlocalrendermode2) | Updates the display mode of the local video view.            |
| [setRemoteRenderMode](class_irtcengine.html#api_setremoterendermode2) | Updates the display mode of the video view of a remote user. |
| [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo) | Enables/Disables the local video capture.                    |
| [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream) | Stops or resumes publishing the local video stream.          |
| [muteRemoteVideoStream](class_irtcengine.html#api_muteremotevideostream) | Stops or resumes subscribing to the video stream of a specified user. |
| [muteAllRemoteVideoStreams](class_irtcengine.html#api_muteallremotevideostreams) | Stops or resumes subscribing to the video streams of all remote users. |
| [setDefaultMuteAllRemoteVideoStreams](class_irtcengine.html#api_setdefaultmuteallremotevideostreams) | Stops or resumes subscribing to the video streams of all remote users by default. |

## Capture screenshots

| Method                                                 | Description                         |
| ------------------------------------------------------ | ----------------------------------- |
| [takeSnapshot](class_irtcengine.html#api_takesnapshot) | Takes a snapshot of a video stream. |

| Event                                                        | Description                                    |
| ------------------------------------------------------------ | ---------------------------------------------- |
| [onSnapshotTaken](class_irtcengineeventhandler.html#callback_onsnapshottaken) | Reports the result of taking a video snapshot. |

## Multi-device capture

| Method                                                       | Description                                      |
| ------------------------------------------------------------ | ------------------------------------------------ |
| [startPrimaryCameraCapture](class_irtcengine.html#api_startprimarycameracapture) | Starts video capture with a primary camera.      |
| [startPrimaryScreenCapture](class_irtcengine.html#api_startprimaryscreencapture) | Starts video capture with a primary camera.      |
| [startSecondaryCameraCapture](class_irtcengine.html#api_startsecondarycameracapture) | Starts video capture with a secondary camera.    |
| [startSecondaryScreenCapture](class_irtcengine.html#api_startsecondaryscreencapture) | Starts sharing a secondary screen.               |
| [stopPrimaryCameraCapture](class_irtcengine.html#api_stopprimarycameracapture) | Stops capturing video through the first camera.  |
| [stopPrimaryScreenCapture](class_irtcengine.html#api_stopprimaryscreencapture) | Stop sharing the first screen.                   |
| [stopSecondaryCameraCapture](class_irtcengine.html#api_stopsecondarycameracapture) | Stops capturing video through the second camera. |
| [stopSecondaryScreenCapture](class_irtcengine.html#api_stopsecondaryscreencapture) | Stop sharing the second screen.                  |

## Media player

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [createMediaPlayer](class_irtcengine.html#api_createmediaplayer) | Creates a media player instance.                             |
| [IMediaPlayer](class_imediaplayer.html#class_imediaplayer)   | This class provides media player functions and supports multiple instances. |
| [IMediaPlayerSourceObserver](class_imediaplayersourceobserver.html#class_imediaplayersourceobserver) | Provides callbacks for media players.                        |

## Local media events

| Event                                                        | Description                                       |
| ------------------------------------------------------------ | ------------------------------------------------- |
| [onLocalAudioStateChanged](class_irtcengineeventhandler.html#callback_onlocalaudiostatechanged) | Occurs when the local audio stream state changes. |
| [onLocalVideoStateChanged](class_irtcengineeventhandler.html#callback_onlocalvideostatechanged) | Occurs when the local video stream state changes. |
| [onFirstLocalAudioFramePublished](class_irtcengineeventhandler.html#callback_onfirstlocalaudioframepublished) | Occurs when the first audio frame is published.   |
| [onFirstLocalVideoFramePublished](class_irtcengineeventhandler.html#callback_onfirstlocalvideoframepublished) | Occurs when the first video frame is published.   |
| [onAudioPublishStateChanged](class_irtcengineeventhandler.html#callback_onaudiopublishstatechanged) | Occurs when the audio publishing state changes.   |
| [onVideoPublishStateChanged](class_irtcengineeventhandler.html#callback_onvideopublishstatechanged) | Occurs when the video publishing state changes.   |

## Remote media events

| Event                                                        | Description                                      |
| ------------------------------------------------------------ | ------------------------------------------------ |
| [onRemoteAudioStateChanged](class_irtcengineeventhandler.html#callback_onremoteaudiostatechanged) | Occurs when the remote audio state changes.      |
| [onRemoteVideoStateChanged](class_irtcengineeventhandler.html#callback_onremotevideostatechanged) | Occurs when the remote video state changes.      |
| [onAudioSubscribeStateChanged](class_irtcengineeventhandler.html#callback_onaudiosubscribestatechanged) | Occurs when the audio subscribing state changes. |
| [onVideoSubscribeStateChanged](class_irtcengineeventhandler.html#callback_onvideosubscribestatechanged) | Occurs when the video subscribing state changes. |

## Statistics events

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [onRtcStats](class_irtcengineeventhandler.html#callback_onrtcstats) | Reports the statistics of the current call.                  |
| [onNetworkQuality](class_irtcengineeventhandler.html#callback_onnetworkquality) | Reports the last mile network quality of each user in the channel. |
| [onLocalAudioStats](class_irtcengineeventhandler.html#callback_onlocalaudiostats) | Reports the statistics of the local audio stream.            |
| [onLocalVideoStats](class_irtcengineeventhandler.html#callback_onlocalvideostats) | Reports the statistics of the local video stream.            |
| [onRemoteAudioStats](class_irtcengineeventhandler.html#callback_onremoteaudiostats) | Reports the transport-layer statistics of each remote audio stream. |
| [onRemoteVideoStats](class_irtcengineeventhandler.html#callback_onremotevideostats) | Reports the transport-layer statistics of each remote video stream. |

## Video pre-process and post-process

| Method                                                       | Description                                             |
| ------------------------------------------------------------ | ------------------------------------------------------- |
| [setBeautyEffectOptions](class_irtcengine.html#api_setbeautyeffectoptions) | Sets the image enhancement options.                     |
| [enableVirtualBackground](class_irtcengine.html#api_enablevirtualbackground) | Enables/Disables the virtual background. (beta feature) |

## In-ear monitoring

**Attention:**

This method is for Android and iOS only.

| Method                                                       | Description                            |
| ------------------------------------------------------------ | -------------------------------------- |
| [enableInEarMonitoring](class_irtcengine.html#api_enableinearmonitoring2) | Enables in-ear monitoring.             |
| [setInEarMonitoringVolume](class_irtcengine.html#api_setinearmonitoringvolume) | Sets the volume of the in-ear monitor. |

## Music file playback and mixing

| Method                                                       | Description                                             |
| ------------------------------------------------------------ | ------------------------------------------------------- |
| [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2) | Starts playing the music file.                          |
| [stopAudioMixing](class_irtcengine.html#api_stopaudiomixing) | Stops playing and mixing the music file.                |
| [pauseAudioMixing](class_irtcengine.html#api_pauseaudiomixing) | Pauses playing and mixing the music file.               |
| [resumeAudioMixing](class_irtcengine.html#api_resumeaudiomixing) | Resumes playing and mixing the music file.              |
| [adjustAudioMixingVolume](class_irtcengine.html#api_adjustaudiomixingvolume) | Adjusts the volume during audio mixing.                 |
| [adjustAudioMixingPlayoutVolume](class_irtcengine.html#api_adjustaudiomixingplayoutvolume) | Adjusts the volume of audio mixing for local playback.  |
| [adjustAudioMixingPublishVolume](class_irtcengine.html#api_adjustaudiomixingpublishvolume) | Adjusts the volume of audio mixing for publishing.      |
| [getAudioMixingPlayoutVolume](class_irtcengine.html#api_getaudiomixingplayoutvolume) | Retrieves the audio mixing volume for local playback.   |
| [getAudioMixingPublishVolume](class_irtcengine.html#api_getaudiomixingpublishvolume) | Retrieves the audio mixing volume for publishing.       |
| [getAudioMixingDuration](class_irtcengine.html#api_getaudiomixingduration) | Retrieves the duration (ms) of the music file.          |
| [getAudioMixingCurrentPosition](class_irtcengine.html#api_getaudiomixingcurrentposition) | Retrieves the playback position (ms) of the music file. |
| [setAudioMixingPitch](class_imediaplayer.html#api_setaudiomixingpitch) | Sets the pitch of the local music file.                 |
| [setAudioMixingPosition](class_irtcengine.html#api_setaudiomixingposition) | Sets the audio mixing position.                         |

| Event                                                        | Description                                               |
| ------------------------------------------------------------ | --------------------------------------------------------- |
| [onAudioMixingStateChanged](class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng) | Occurs when the playback state of the music file changes. |

## Audio effect file playback

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [getEffectsVolume](class_irtcengine.html#api_geteffectsvolume) | Retrieves the volume of the audio effects.                   |
| [setEffectsVolume](class_irtcengine.html#api_seteffectsvolume) | Sets the volume of the audio effects.                        |
| [getVolumeOfEffect](class_irtcengine.html#api_getvolumeofeffect) | Gets the volume of a specified audio effect.                 |
| [setVolumeOfEffect](class_irtcengine.html#api_setvolumeofeffect) | Sets the volume of a specified audio effect.                 |
| [preloadEffect](class_irtcengine.html#api_preloadeffect)     | Preloads a specified audio effect file into the memory.      |
| [playEffect](class_irtcengine.html#api_playeffect3)          | Plays the specified local or online audio effect file.       |
| [playAllEffects](class_irtcengine.html#api_playalleffects)   | Plays all audio effects.                                     |
| [pauseEffect](class_irtcengine.html#api_pauseeffect)         | Pauses a specified audio effect.                             |
| [pauseAllEffects](class_irtcengine.html#api_pausealleffects) | Pauses all audio effects.                                    |
| [resumeEffect](class_irtcengine.html#api_resumeeffect)       | Resumes playing a specified audio effect.                    |
| [resumeAllEffects](class_irtcengine.html#api_resumealleffects) | Resumes playing all audio effects.                           |
| [stopEffect](class_irtcengine.html#api_stopeffect)           | Stops playing a specified audio effect.                      |
| [stopAllEffects](class_irtcengine.html#api_stopalleffects)   | Stops playing all audio effects.                             |
| [unloadEffect](class_irtcengine.html#api_unloadeffect)       | Releases a specified preloaded audio effect from the memory. |
| [unloadAllEffects](class_irtcengine.html#api_unloadalleffects) | releases a specified preloaded audio effect from the memory. |

## Virtual metronome

**Attention:**

This method is for Android and iOS only.

| Method                                                       | Description                       |
| ------------------------------------------------------------ | --------------------------------- |
| [startRhythmPlayer](class_irtcengine.html#api_startrhythmplayer) | Enables the virtual metronome.    |
| [stopRhythmPlayer](class_irtcengine.html#api_stoprhythmplayer) | Disables the virtual metronome.   |
| [configRhythmPlayer](class_irtcengine.html#api_configrhythmplayer) | Configures the virtual metronome. |

## Voice changer and reverberation

| Method                                                       | Description                                              |
| ------------------------------------------------------------ | -------------------------------------------------------- |
| [setLocalVoiceEqualization](class_irtcengine.html#api_setlocalvoiceequalization) | Sets the local voice equalization effect.                |
| [setLocalVoicePitch](class_irtcengine.html#api_setlocalvoicepitch) | Changes the voice pitch of the local speaker.            |
| [setLocalVoiceReverb](class_irtcengine.html#api_setlocalvoicereverb) | Sets the local voice reverberation.                      |
| [setVoiceBeautifierPreset](class_irtcengine.html#api_setvoicebeautifierpreset) | Sets a preset voice beautifier effect.                   |
| [setVoiceBeautifierParameters](class_irtcengine.html#api_setvoicebeautifierparameters) | Sets parameters for the preset voice beautifier effects. |
| [setAudioEffectPreset](class_irtcengine.html#api_setaudioeffectpreset) | Sets an SDK preset audio effect.                         |
| [setAudioEffectParameters](class_irtcengine.html#api_setaudioeffectparameters) | Sets parameters for SDK preset audio effects.            |
| [setVoiceConversionPreset](class_irtcengine.html#api_setvoiceconversionpreset) | Sets a preset voice beautifier effect.                   |

## Pre-call network test

| Method                                                       | Description                              |
| ------------------------------------------------------------ | ---------------------------------------- |
| [startEchoTest [2/2\]](class_irtcengine.html#api_startechotest2) | Starts an audio call test.               |
| [stopEchoTest](class_irtcengine.html#api_stopechotest)       | Stops the audio call test.               |
| [startLastmileProbeTest](class_irtcengine.html#api_startlastmileprobetest) | Starts the last mile network probe test. |
| [stopLastmileProbeTest](class_irtcengine.html#api_stoplastmileprobetest) | Stops the last mile network probe test.  |

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [onLastmileQuality](class_irtcengineeventhandler.html#callback_onlastmilequality) | Reports the last-mile network quality of the local user once every two seconds. |
| [onLastmileProbeResult](class_irtcengineeventhandler.html#callback_onlastmileproberesult) | Reports the last mile network probe result.                  |

## Screen sharing

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [startScreenCaptureByWindowId](class_irtcengine.html#api_startscreencapturebywindowid) | Shares the whole or part of a window by specifying the window ID. (For Windows and macOS only) |
| [startScreenCaptureByScreenRect](class_irtcengine.html#api_startscreencapturebyscreenrect) | Shares the whole or part of a screen by specifying the screen rect. (For Windows only) |
| [startScreenCaptureByDisplayId](class_irtcengine.html#api_startscreencapturebydisplayid) | Shares the screen by specifying the display ID. (For Windows and macOS only) |
| [setScreenCaptureContentHint](class_irtcengine.html#api_setscreencapturecontenthint) | Sets the content hint for screen sharing. (For Windows and macOS only) |
| [updateScreenCaptureRegion](class_irtcengine.html#api_updatescreencaptureregion) | Updates the screen sharing region. (For Windows and macOS only) |
| [updateScreenCaptureParameters](class_irtcengine.html#api_updatescreencaptureparameters) | Updates the screen sharing parameters. (For Windows and macOS only) |
| [startScreenCapture](class_irtcengine.html#api_startscreencapture_ng) | Starts screen sharing. (For Windows and Android only)        |
| [stopScreenCapture](class_irtcengine.html#api_stopscreencapture) | Stops screen sharing. (For Android, Windows and macOS only)  |

## Video dual stream

| Method                                                       | Description                                           |
| ------------------------------------------------------------ | ----------------------------------------------------- |
| [enableDualStreamMode [1/3\]](class_irtcengine.html#api_enabledualstreammode) | Enables/Disables dual-stream mode.                    |
| [enableDualStreamMode [2/3\]](class_irtcengine.html#api_enabledualstreammode2) | Enables/Disables dual-stream mode.                    |
| [enableDualStreamMode [3/3\]](class_irtcengine.html#api_enabledualstreammode3) | Enables/Disables dual-stream mode.                    |
| [setRemoteVideoStreamType](class_irtcengine.html#api_setremotevideostreamtype) | Sets the stream type of the remote video.             |
| [setRemoteDefaultVideoStreamType](class_irtcengine.html#api_setremotedefaultvideostreamtype) | Sets the default stream type of remote video streams. |

## Watermark

| Method                                                       | Description                                        |
| ------------------------------------------------------------ | -------------------------------------------------- |
| [addVideoWatermark [2/2\]](class_irtcengine.html#api_addvideowatermark2) | Adds a watermark image to the local video.         |
| [clearVideoWatermarks](class_irtcengine.html#api_clearvideowatermarks) | Removes the watermark image from the video stream. |

## Encryption

| Method                                                       | Description                               |
| ------------------------------------------------------------ | ----------------------------------------- |
| [enableEncryption](class_irtcengine.html#api_enableencryption) | Enables/Disables the built-in encryption. |
| [registerPacketObserver](class_irtcengine.html#api_registerpacketobserver) | Registers a packet observer.              |

| Event                                                        | Description                             |
| ------------------------------------------------------------ | --------------------------------------- |
| [onEncryptionError](class_irtcengineeventhandler.html#callback_onencryptionerror) | Reports the built-in encryption errors. |

## Sound localization

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [enableSoundPositionIndication](class_irtcengine.html#api_enablesoundpositionindication) | Enables/Disables stereo panning for remote users.            |
| [setRemoteVoicePosition](class_irtcengine.html#api_setremotevoiceposition) | Sets the 2D position (the position on the horizontal plane) of the remote user's voice. |

## CDN publisher

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding) | Sets the transcoding configurations for CDN live streaming.  |
| [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) | Publishes the local stream to a specified CDN live streaming URL. |
| [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl) | Removes an RTMP or RTMPS stream from the CDN.                |

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [onRtmpStreamingStateChanged](class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged) | Occurs when the state of the RTMP or RTMPS streaming changes. |
| [onTranscodingUpdated](class_irtcengineeventhandler.html#callback_ontranscodingupdated) | Occurs when the publisher's transcoding is updated.          |

## Channel media stream relay

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [startChannelMediaRelay](class_irtcengine.html#api_startchannelmediarelay) | Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels. |
| [updateChannelMediaRelay](class_irtcengine.html#api_updatechannelmediarelay) | Updates the channels for media stream relay.                 |
| [stopChannelMediaRelay](class_irtcengine.html#api_stopchannelmediarelay) | Stops the media stream relay. Once the relay stops, the host quits all the destination channels. |
| [pauseAllChannelMediaRelay](class_irtcengine.html#api_pauseallchannelmediarelay) | Pauses the media stream relay to all destination channels.   |
| [resumeAllChannelMediaRelay](class_irtcengine.html#api_resumeallchannelmediarelay) | Resumes the media stream relay to all destination channels.  |

| Event                                                        | Description                                              |
| ------------------------------------------------------------ | -------------------------------------------------------- |
| [onChannelMediaRelayStateChanged](class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged) | Occurs when the state of the media stream relay changes. |
| [onChannelMediaRelayEvent](class_irtcengineeventhandler.html#callback_onchannelmediarelayevent) | Reports events during the media stream relay.            |

## Custom audio source

| Method                                                       | Description                                |
| ------------------------------------------------------------ | ------------------------------------------ |
| [setExternalAudioSource](class_imediaengine.html#api_setexternalaudiosource2) | Sets the external audio source parameters. |
| [pushAudioFrame](class_imediaengine.html#api_imediaengine_pushaudioframe0) | Pushes the external audio frame.           |

## Custom audio renderer

| Method                                                       | Description                   |
| ------------------------------------------------------------ | ----------------------------- |
| [setExternalAudioSink](class_irtcengine.html#api_setexternalaudiosink_ng) | Sets the external audio sink. |
| [pullAudioFrame](class_imediaengine.html#api_imediaengine_pullaudioframe) | Pulls the remote audio data.  |

## Raw audio data

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [registerAudioFrameObserver](class_imediaengine.html#api_imediaengine_registeraudioframeobserver) | Registers an audio frame observer object.                    |
| [setRecordingAudioFrameParameters](class_irtcengine.html#api_setrecordingaudioframeparameters) | Set the format of the captured raw audio data.               |
| [setPlaybackAudioFrameParameters](class_irtcengine.html#api_setplaybackaudioframeparameters) | Sets the audio data format for playback.                     |
| [setMixedAudioFrameParameters](class_irtcengine.html#api_setmixedaudioframeparameters_ng) | Sets the audio data format reported by [onMixedAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onmixedaudioframe). |
| [setPlaybackAudioFrameBeforeMixingParameters](class_irtcengine.html#api_setplaybackaudioframebeforemixingparameters) | Sets the audio data format reported by [onPlaybackAudioFrameBeforeMixing](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframebeforemixing). |

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [onRecordAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onrecordaudioframe) | Gets the captured audio frame.                               |
| [onPlaybackAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframe) | Gtes the audio frame for playback.                           |
| [onPlaybackAudioFrameBeforeMixing](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onplaybackaudioframebeforemixing) | Retrieves the audio frame of a specified user before mixing. |
| [onMixedAudioFrame](class_iaudioframeobserverbase.html#callback_iaudioframeobserverbase_onmixedaudioframe) | Retrieves the mixed captured and playback audio frame.       |

## Encoded audio data

| Method                                                       | Description                          |
| ------------------------------------------------------------ | ------------------------------------ |
| [registerAudioEncodedFrameObserver](class_irtcengine.html#api_registeraudioencodedframeobserver) | Registers an encoded audio observer. |

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [OnRecordAudioEncodedFrame](class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onrecordaudioencodedframe) | Gets the encoded audio data of the local user.               |
| [OnPlaybackAudioEncodedFrame](class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onplaybackaudioencodedframe) | Gets the encoded audio data of all remote users.             |
| [OnMixedAudioEncodedFrame](class_iaudioencodedframeobserver.html#callback_iaudioencodedframeobserver_onmixedaudioencodedframe) | Gets the mixed and encoded audio data of the local and all remote users. |

## Audio spectrum

| Method                                                       | Description                              |
| ------------------------------------------------------------ | ---------------------------------------- |
| [registerAudioSpectrumObserver](class_irtcengine.html#api_registeraudiospectrumobserver) | Register an audio spectrum observer.     |
| [enableAudioSpectrumMonitor](class_irtcengine.html#api_enableaudiospectrummonitor) | Turn on audio spectrum monitoring.       |
| [disableAudioSpectrumMonitor](class_irtcengine.html#api_disableaudiospectrummonitor) | Disables audio spectrum monitoring.      |
| [unregisterAudioSpectrumObserver](class_irtcengine.html#api_unregisteraudiospectrumobserver) | Unregisters the audio spectrum observer. |

| Event                                                        | Description                                    |
| ------------------------------------------------------------ | ---------------------------------------------- |
| [onLocalAudioSpectrum](class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onlocalaudiospectrum) | Gets the statistics of a local audio spectrum. |
| [onRemoteAudioSpectrum](class_iaudiospectrumobserver.html#callback_iaudiospectrumobserver_onremoteaudiospectrum) | Gets the remote audio spectrum.                |

## External video source

| Method                                                       | Description                                         |
| ------------------------------------------------------------ | --------------------------------------------------- |
| [setExternalVideoSource](class_imediaengine.html#api_imediaengine_setexternalvideosource_ng) | Configures the external video source.               |
| [pushVideoFrame [1/2\]](class_imediaengine.html#api_imediaengine_pushvideoframe) | Pushes the external encoded video frame to the SDK. |
| [pushEncodedVideoImage [1/2\]](class_imediaengine.html#api_imediaengine_pushencodedvideoimage) | Pushes the external encoded video frame to the SDK. |

## Raw video data

| Method                                                       | Description                                              |
| ------------------------------------------------------------ | -------------------------------------------------------- |
| [registerVideoFrameObserver](class_imediaengine.html#api_imediaengine_registervideoframeobserver) | Registers a video frame observer object.                 |
| [registerVideoEncodedImageReceiver](class_imediaengine.html#api_imediaengine_registervideoencodedimagereceiver) | Registers a receiver object for the encoded video image. |

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [onCaptureVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_oncapturevideoframe) | Occurs each time the SDK receives a video frame captured by the local camera. |
| [onPreEncodeVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_onpreencodevideoframe) | Occurs each time the SDK receives a video frame before encoding. |
| [onPreEncodeScreenVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_onpreencodescreenvideoframe) | Gets the video data captured from the screen before encoding. |
| [onScreenCaptureVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_onscreencapturevideoframe) | Occurs each time the SDK receives a video frame captured by the screen. |
| [onSecondaryPreEncodeCameraVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_onsecondarypreencodecameravideoframe) | Gets the video data captured from the second camera before encoding. |
| [onSecondaryPreEncodeScreenVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_onsecondarypreencodescreenvideoframe) | Gets the video data captured from the second screen before encoding. |
| [onRenderVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_onrendervideoframe) | Occurs each time the SDK receives a video frame sent by the remote user. |
| [onMediaPlayerVideoFrame](class_ivideoframeobserver.html#callback_ivideoframeobserver_onmediaplayervideoframe) | Gets the video data of the media player.                     |
| [getObservedFramePosition](class_ivideoframeobserver.html#callback_ivideoframeobserver_getobservedframeposition) | Sets the frame position for the video observer.              |
| [getVideoFrameProcessMode](class_ivideoframeobserver.html#callback_ivideoframeobserver_getvideoframeprocessmode) | Occurs each time the SDK receives a video frame and prompts you to set the process mode of the video frame. |
| [OnEncodedVideoImageReceived](class_ivideoencodedimagereceiver.html#callback_ivideoencodedimagereceiver_onencodedvideoimagereceived) | Occurs each time the SDK receives an encoded video image.    |
| [getMirrorApplied](class_ivideoframeobserver.html#callback_ivideoframeobserver_getmirrorapplied) | Occurs each time the SDK receives a video frame and prompts you whether or not to mirror the captured video. |
| [getRotationApplied](class_ivideoframeobserver.html#callback_ivideoframeobserver_getrotationapplied) | Occurs each time the SDK receives a video frame, and prompts you whether to rotate the captured video. |

## Extension

| Method                                                       | Description                                    |
| ------------------------------------------------------------ | ---------------------------------------------- |
| [enableExtension](class_irtcengine.html#api_enableextension) | Enables/Disables extensions.                   |
| [setExtensionProperty](class_irtcengine.html#api_setextensionproperty) | Sets the properties of the extension.          |
| [setExtensionProviderProperty](class_irtcengine.html#api_setextensionproviderproperty) | Sets the properties of the extension provider. |

| Event                                                        | Description                                 |
| ------------------------------------------------------------ | ------------------------------------------- |
| [onExtensionEvent](class_irtcengineeventhandler.html#callback_onextensionevent) | The event callback of the extension.        |
| [onExtensionStarted](class_irtcengineeventhandler.html#callback_onextensionstarted) | Occurs when the extension is enabled.       |
| [onExtensionStopped](class_irtcengineeventhandler.html#callback_onextensionstoped) | Occurs when the extension is disabled.      |
| [onExtensionError](class_irtcengineeventhandler.html#callback_onextensionerror) | Occurs when the extension runs incorrectly. |

## Media metadata

| Method                                                       | Description                                  |
| ------------------------------------------------------------ | -------------------------------------------- |
| [registerMediaMetadataObserver](class_irtcengine.html#api_registermediametadataobserver) | Registers the metadata observer.             |
| [unregisterMediaMetadataObserver](class_irtcengine.html#api_unregistermediametadataobserver) | Unregisters the specified metadata observer. |

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [getMaxMetadataSize](class_imetadataobserver.html#callback_imetadataobserver_getmaxmetadatasize) | Occurs when the SDK requests the maximum size of the metadata. |
| [onReadyToSendMetadata](class_imetadataobserver.html#callback_imetadataobserver_onreadytosendmetadata) | Occurs when the SDK is ready to send metadata.               |
| [onMetadataReceived](class_imetadataobserver.html#callback_imetadataobserver_onmetadatareceived) | Occurs when the local user receives the metadata.            |

## Audio recording

| Method                                                       | Description                              |
| ------------------------------------------------------------ | ---------------------------------------- |
| [startAudioRecording](class_irtcengine.html#api_startaudiorecording3_ng) | Starts audio recording on the client.    |
| [stopAudioRecording](class_irtcengine.html#api_stopaudiorecording) | Stops the audio recording on the client. |

## Camera management

**Attention:** This method is for Android and iOS only.

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [switchCamera](class_irtcengine.html#api_switchcamera)       | Switches between front and rear cameras.                     |
| [setCameraCapturerConfiguration](class_irtcengine.html#api_setcameracapturerconfiguration) | Sets the camera capture configuration.                       |
| [isCameraZoomSupported](class_irtcengine.html#api_iscamerazoomsupported) | Checks whether the device supports camera zoom.              |
| [getCameraMaxZoomFactor](class_irtcengine.html#api_getcameramaxzoomfactor) | Gets the maximum zoom ratio supported by the camera.         |
| [setCameraZoomFactor](class_irtcengine.html#api_setcamerazoomfactor) | Sets the camera zoom ratio.                                  |
| [isCameraTorchSupported](class_irtcengine.html#api_iscameratorchsupported) | Checks whether the device supports camera flash.             |
| [setCameraTorchOn](class_irtcengine.html#api_setcameratorchon) | Enables the camera flash.                                    |
| [isCameraFaceDetectSupported](class_irtcengine.html#api_iscamerafacedetectsupported) | Checks whether the device camera supports face detection.    |
| [isCameraFocusSupported](class_irtcengine.html#api_iscamerafocussupported) | Check whether the device supports the manual focus function. |
| [setCameraFocusPositionInPreview](class_irtcengine.html#api_setcamerafocuspositioninpreview) | Sets the camera manual focus position.                       |
| [isCameraAutoFocusFaceModeSupported](class_irtcengine.html#api_iscameraautofocusfacemodesupported) | Checks whether the device supports the face auto-focus function. |
| [setCameraAutoFocusFaceModeEnabled](class_irtcengine.html#api_setcameraautofocusfacemodeenabled) | Enables the camera auto-face focus function.                 |
| [isCameraExposurePositionSupported](class_irtcengine.html#api_iscameraexposurepositionsupported) | Checks whether the device supports manual exposure.          |
| [setCameraExposurePosition](class_irtcengine.html#api_setcameraexposureposition) | Sets the camera exposure position.                           |

| Event                                                        | Description                                   |
| ------------------------------------------------------------ | --------------------------------------------- |
| [onCameraFocusAreaChanged](class_irtcengineeventhandler.html#callback_oncamerafocusareachanged) | Occurs when the camera focus area changes.    |
| [onCameraExposureAreaChanged](class_irtcengineeventhandler.html#callback_oncameraexposureareachanged) | Occurs when the camera exposure area changes. |

## Multiple channels

| Method                                                       | Description                             |
| ------------------------------------------------------------ | --------------------------------------- |
| [joinChannelEx](class_irtcengineex.html#api_irtcengineex_joinchannelex) | Joins a channel with the connection ID. |
| [leaveChannelEx](class_irtcengineex.html#api_irtcengineex_leavechannelex) | Leaves a channel.                       |

## Audio route

This method is for Android and iOS only.

| Method                                                       | Description                                    |
| ------------------------------------------------------------ | ---------------------------------------------- |
| [setDefaultAudioRouteToSpeakerphone](class_irtcengine.html#api_setdefaultaudioroutetospeakerphone_ng) | Sets the default audio playback route.         |
| [setEnableSpeakerphone](class_irtcengine.html#api_setenablespeakerphone_ng) | Enables/Disables the speakerphone temporarily. |
| [isSpeakerphoneEnabled](class_irtcengine.html#api_isspeakerphoneenabled) | Checks whether the speakerphone is enabled.    |

## Volume indication

| Method                                                       | Description                                        |
| ------------------------------------------------------------ | -------------------------------------------------- |
| [enableAudioVolumeIndication](class_irtcengine.html#api_enableaudiovolumeindication) | Enables the reporting of users' volume indication. |

| Event                                                        | Description                                      |
| ------------------------------------------------------------ | ------------------------------------------------ |
| [onAudioVolumeIndication](class_irtcengineeventhandler.html#callback_onaudiovolumeindication) | Reports the volume information of users.         |
| [onActiveSpeaker](class_irtcengineeventhandler.html#callback_onactivespeaker) | Occurs when the most active speaker is detected. |

## Data stream

| Method                                                       | Description                 |
| ------------------------------------------------------------ | --------------------------- |
| [createDataStream [2/2\]](class_irtcengine.html#api_createdatastream2) | Creates a data stream.      |
| [sendStreamMessage](class_irtcengine.html#api_sendstreammessage) | Sends data stream messages. |

| Event                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage) | Occurs when the local user receives the data stream from the remote user. |
| [onStreamMessageError](class_irtcengineeventhandler.html#callback_onstreammessageerror) | Occurs when the local user does not receive the data stream from the remote user. |

## Video device management

**Attention:**

This group of methods are for Windows only.

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [enumerateVideoDevices](class_ivideodevicemanager.html#api_ivideodevicemanager_enumeratevideodevices) | Enumerates the video devices.                                |
| [setDevice](class_ivideodevicemanager.html#api_ivideodevicemanager_setdevice) | Specifies the video capture device with the device ID.       |
| [getDevice](class_ivideodevicemanager.html#api_ivideodevicemanager_getdevice) | Retrieves the current video capture device.                  |
| [release](class_ivideodevicemanager.html#api_ivideodevicemanager_release) | Releases all the resources occupied by the [IVideoDeviceManager](class_ivideodevicemanager.html#class_ivideodevicemanager) object. |

## Video device collection

**Attention:**

This group of methods are for Windows only.

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [setDevice](class_ivideodevicecollection.html#api_ivideodevicecollection_setdevice) | Specifies a device with the device ID.                       |
| [getDevice](class_ivideodevicecollection.html#api_ivideodevicecollection_getdevice) | Gets a specified piece of information about an indexed video device. |
| [getCount](class_ivideodevicecollection.html#api_ivideodevicecollection_getcount) | Gets the total number of the indexed video devices in the system. |
| [release](class_ivideodevicecollection.html#api_ivideodevicecollection_release) | Releases all the resources occupied by the [IVideoDeviceCollection](class_ivideodevicecollection.html#class_ivideodevicecollection) object. |

## Audio device management

**Attention:**

This group of methods are for Windows only.

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [enumeratePlaybackDevices](class_iaudiodevicemanager.html#api_iaudiodevicemanager_enumerateplaybackdevices) | Enumerates the audio playback devices.                       |
| [enumerateRecordingDevices](class_iaudiodevicemanager.html#api_iaudiodevicemanager_enumeraterecordingdevices) | Enumerates the audio capture devices.                        |
| [setPlaybackDevice](class_iaudiodevicemanager.html#api_iaudiodevicemanager_setplaybackdevice) | Sets the audio playback device.                              |
| [getPlaybackDevice](class_iaudiodevicemanager.html#api_iaudiodevicemanager_getplaybackdevice) | Retrieves the audio playback device associated with the device ID. |
| [getPlaybackDeviceInfo](class_iaudiodevicemanager.html#api_iaudiodevicemanager_getplaybackdeviceinfo) | Retrieves the audio playback device information associated with the device ID and device name. |
| [setRecordingDevice](class_iaudiodevicemanager.html#api_iaudiodevicemanager_setrecordingdevice) | Sets the audio capture device.                               |
| [getRecordingDevice](class_iaudiodevicemanager.html#api_iaudiodevicemanager_getrecordingdevice) | Gets the current audio recording device.                     |
| [getRecordingDeviceInfo](class_iaudiodevicemanager.html#api_iaudiodevicemanager_getrecordingdeviceinfo) | Retrieves the audio capture device information associated with the device ID and device name. |
| [startPlaybackDeviceTest](class_iaudiodevicemanager.html#api_iaudiodevicemanager_startplaybackdevicetest) | Starts the audio playback device test. (For Windows and macOS only) |
| [stopPlaybackDeviceTest](class_iaudiodevicemanager.html#api_iaudiodevicemanager_stopplaybackdevicetest) | Stops the audio playback device test. (For Windows and macOS only) |
| [startRecordingDeviceTest](class_iaudiodevicemanager.html#api_iaudiodevicemanager_startrecordingdevicetest) | Starts the audio capture device test. (For Windows and macOS only) |
| [stopRecordingDeviceTest](class_iaudiodevicemanager.html#api_iaudiodevicemanager_stoprecordingdevicetest) | Stops the audio capture device test. (For Windows and macOS only) |
| [startAudioDeviceLoopbackTest](class_iaudiodevicemanager.html#api_iaudiodevicemanager_startaudiodeviceloopbacktest) | Starts an audio device loopback test. (For Windows and macOS only) |
| [stopAudioDeviceLoopbackTest](class_iaudiodevicemanager.html#api_iaudiodevicemanager_stopaudiodeviceloopbacktest) | Stops the audio device loopback test. (For Windows and macOS only) |
| [release](class_iaudiodevicemanager.html#api_iaudiodevicemanager_release) | Releases all the resources occupied by the [IAudioDeviceManager](class_iaudiodevicemanager.html#class_iaudiodevicemanager) object. |

| Event                                                        | Description                                 |
| ------------------------------------------------------------ | ------------------------------------------- |
| [onAudioDeviceStateChanged](class_irtcengineeventhandler.html#callback_onaudiodevicestatechanged) | Occurs when the audio device state changes. |

## Audio device collection

**Attention:**

This group of methods are for Windows only.

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [setDevice](class_iaudiodevicecollection.html#api_iaudiodevicecollection_setdevice) | Specifies an audio device.                                   |
| [getDevice](class_iaudiodevicecollection.html#api_iaudiodevicecollection_getdevice) | Gets the information of a specified audio device.            |
| [getCount](class_iaudiodevicecollection.html#api_iaudiodevicecollection_getcount) | Gets the total number of audio playback or audio capture devices. |
| [setApplicationVolume](class_iaudiodevicecollection.html#api_iaudiodevicecollection_setapplicationvolume) | Sets the application volume.                                 |
| [getApplicationVolume](class_iaudiodevicecollection.html#api_iaudiodevicecollection_getapplicationvolume) | Gets the volume of the application.                          |
| [setApplicationMute](class_iaudiodevicecollection.html#api_iaudiodevicecollection_setapplicationmute) | Mutes/Unmutes the application.                               |
| [isApplicationMute](class_iaudiodevicecollection.html#api_iaudiodevicecollection_isapplicationmute) | Gets the mute state of the application.                      |
| [release](class_iaudiodevicecollection.html#api_iaudiodevicecollection_release) | Releases all IAudioDeviceCollection resources.               |

## Miscellaneous audio control

**Attention:**

This method is for Windows and macOS only.

| Method                                                       | Description                       |
| ------------------------------------------------------------ | --------------------------------- |
| [enableLoopbackRecording](class_irtcengine.html#api_enableloopbackrecording_ng) | Enables loopback audio capturing. |

## Miscellaneous methods

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [sendCustomReportMessageEx](class_irtcengineex.html#api_irtcengineex_sendcustomreportmessageex) | Agora supports reporting and analyzing customized messages.  |
| [getCallId](class_irtcengine.html#api_getcallid)             | Retrieves the call ID.                                       |
| [rate](class_irtcengine.html#api_rate)                       | Allows a user to rate a call after the call ends.            |
| [complain](class_irtcengine.html#api_complain)               | Allows a user to complain about the call quality after a call ends. |
| [getVersion](class_irtcengine.html#api_getversion)           | Gets the SDK version.                                        |
| [getErrorDescription](class_irtcengine.html#api_geterrordescription) | Gets the warning or error description.                       |
| [queryInterface](class_irtcengine.html#api_queryinterface)   | Gets the pointer to the specified interface.                 |

## Miscellaneous events

| Event                                                        | Description                                  |
| ------------------------------------------------------------ | -------------------------------------------- |
| [onApiCallExecuted](class_irtcengineeventhandler.html#callback_onapicallexecuted) | Occurs when a method is executed by the SDK. |