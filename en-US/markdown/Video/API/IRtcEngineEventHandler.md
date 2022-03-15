# [IRtcEngineEventHandler](class_irtcengineeventhandler.html#class_irtcengineeventhandler)

The SDK uses the IRtcEngineEventHandler interface to send event notifications to your app. Your app can get those notifications through methods that inherit this interface.

All methods in this interface have default (empty) implementation. You can choose to inherit events related to your app scenario. In the callbacks, avoid implementing time-consuming tasks or calling APIs that may cause thread blocking (such as sendMessage). Otherwise, the SDK may not work properly.

**See als**

- [joinChannelEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelex)
- [joinChannelWithUserAccountEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelwithuseraccountex)

## [onActiveSpeaker](class_irtcengineeventhandler.html#callback_onactivespeaker)

Occurs when the most active speaker is detected.

```cpp
virtual void onActiveSpeaker(uid_t userId) { (void)userId; }
```



After a successful call of [enableAudioVolumeIndication](class_irtcengine.html#api_enableaudiovolumeindication), the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user, who is detected as the loudest for the most times, is the most active user.

When the number of users exceeds two (included) and an active speaker is detected, the SDK triggers this callback and reports the **uid** of the most active speaker.

- If the most active speaker remains the same, the SDK triggers the onActiveSpeaker callback only once.
- If the most active speaker changes to another user, the SDK triggers this callback again and reports the **uid** of the new active speaker.

### Parameters

- userId

  The user ID of the most active speaker.

## [onApiCallExecuted](class_irtcengineeventhandler.html#callback_onapicallexecuted)

Occurs when a method is executed by the SDK.

```cpp
virtual void onApiCallExecuted(int err,
     const char* api,
     const char* result) {
     (void)err;
     (void)api;
     (void)result;
     }
```

### Parameters

- err

  The error code returned by the SDK when the method call fails. If the SDK returns 0, then the method call is successful.

- api

  The method executed by the SDK.

- result

  The result of the method call.

## [onAudioDeviceStateChanged](class_irtcengineeventhandler.html#callback_onaudiodevicestatechanged)

Occurs when the audio device state changes.

```cpp
virtual void onAudioDeviceStateChanged(const char* deviceId,
     int deviceType,
     int deviceState) {
     (void)deviceId;
     (void)deviceType;
     (void)deviceState;
     }
```

This callback notifies the application that the system's audio device state is changed. For example, a headset is unplugged from the device.

**Note** This method is for Windows and macOS only.

### Parameters

- deviceId

  The device ID.

- deviceType

  The device type. For details, see [MEDIA_DEVICE_TYPE](rtc_api_data_type.html#enum_mediadevicetype).

- deviceState

  The device state.on macOS:0: The device is ready for use.8: The device is not connected.On Windows: [MEDIA_DEVICE_STATE_TYPE](rtc_api_data_type.html#enum_mediadevicestatetype).

## [onAudioEffectFinished](class_irtcengineeventhandler.html#callback_onaudioeffectfinished)

Occurs when the playback of the local audio effect file finishes.

```cpp
virtual void onAudioEffectFinished(int soundId) {
    }
```

This callback occurs when the local audio effect file finishes playing.

### Parameters

- soundId

  The audio effect ID. The ID of each audio effect file is unique.

## [onAudioMixingFinished](class_irtcengineeventhandler.html#callback_onaudiomixingfinished)

Occurs when the playback of the local music file finishes.

```cpp
virtual void onAudioMixingFinished() {
    }
```

- Deprecated:

  This method is deprecated as of v2.4.0. Use [onAudioMixingStateChanged](class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng) instead.

After you call [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2) to play a local music file, this callback occurs when the playback finishes. If the call of startAudioMixing [2/2] fails, the callback returns the error code **WARN_AUDIO_MIXING_OPEN_ERROR**.

## [onAudioMixingStateChanged](class_irtcengineeventhandler.html#callback_onaudiomixingstatechanged_ng)

Occurs when the playback state of the music file changes.

```cpp
virtual void onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_ERROR_TYPE errorCode) {
    (void)state;
    (void)errorCode;
```

This callback occurs when the playback state of the music file changes, and reports the current state and error code.

### Parameters

- state

  The playback state of the music file. For details, see [AUDIO_MIXING_STATE_TYPE](rtc_api_data_type.html#enum_audiomixingstatetype).

- errorCode

  Error code. For details, see [AUDIO_MIXING_ERROR_TYPE](rtc_api_data_type.html#enum_audiomixingerrortype).

## [onAudioPublishStateChanged](class_irtcengineeventhandler.html#callback_onaudiopublishstatechanged)

Occurs when the audio publishing state changes.

```cpp
virtual void onAudioPublishStateChanged(const char* channel,
     STREAM_PUBLISH_STATE oldState,
     STREAM_PUBLISH_STATE newState,
     int elapseSinceLastState) {
     (void)channel;
     (void)oldState;
     (void)newState;
     (void)elapseSinceLastState;
     }
```



### Parameters

- channel

  The name of the channel.

- oldState

  For the previous publishing state, see [STREAM_PUBLISH_STATE](rtc_api_data_type.html#enum_streampublishstate).

- newState

  For the current publishing state, see STREAM_PUBLISH_STATE.

- elapseSinceLastState

  The time elapsed (ms) from the previous state to the current state.

## [onAudioQuality](class_irtcengineeventhandler.html#callback_onaudioquality)

Reports the statistics of the audio stream from each remote user.

```cpp
virtual void onAudioQuality(uid_t uid, int quality, unsigned short delay, unsigned short lost) {
  (void)uid;
  (void)quality;
  (void)delay;
  (void)lost;
}
```

- Deprecated:

  Deprecated.Please use [onRemoteAudioStats](class_irtcengineeventhandler.html#callback_onremoteaudiostats) instead.

The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple users/hosts sending audio streams, the SDK triggers this callback as many times.

### Parameters

- uid

  The user ID of the remote user sending the audio stream.

- quality

  Audio quality of the user. For details, see [QUALITY_TYPE](rtc_api_data_type.html#enum_qualitytype).

- delay

  The network delay (ms) from the sender to the receiver, including the delay caused by audio sampling pre-processing, network transmission, and network jitter buffering.

- lost

  Packet loss rate (%) of the audio packet sent from the sender to the receiver.

## [onAudioRoutingChanged](class_irtcengineeventhandler.html#callback_onaudioroutechanged)

Occurs when the local audio route changes.

```cpp
virtual void onAudioRoutingChanged(int routing) { (void)routing; }
            
```

**注：**

This method applies to Android and iOS only.

### Parameters

- routing

  The current audio routing.-1: Default audio route.0: The audio route is a headset with a microphone.1: The audio route is an earpiece.2: The audio route is a headset without a microphone.3: The audio route is the speaker that comes with the device.4: The audio route is an external speaker.5：The audio route is a Bluetooth headset.

**See als**

- [setEnableSpeakerphone](../API/class_irtcengine.html#api_setenablespeakerphone_ng)
- [setDefaultAudioRouteToSpeakerphone](../API/class_irtcengine.html#api_setdefaultaudioroutetospeakerphone_ng)

## [onAudioSubscribeStateChanged](class_irtcengineeventhandler.html#callback_onaudiosubscribestatechanged)

Occurs when the audio subscribing state changes.

```cpp
virtual void onAudioSubscribeStateChanged(const char* channel,
     uid_t uid,
     STREAM_SUBSCRIBE_STATE oldState,
     STREAM_SUBSCRIBE_STATE newState,
     int elapseSinceLastState) {
     (void)channel;
     (void)uid;
     (void)oldState;
     (void)newState;
     (void)elapseSinceLastState;
     }
```



### Parameters

- channel

  The name of the channel.

- uid

  The ID of the remote user.

- oldState

  The previous subscribing status, see [STREAM_SUBSCRIBE_STATE](rtc_api_data_type.html#enum_streamsubscribestate) for details.

- newState

  The current subscribing status, see STREAM_SUBSCRIBE_STATE for details.

- elapseSinceLastState

  The time elapsed (ms) from the previous state to the current state.

## [onAudioVolumeIndication](class_irtcengineeventhandler.html#callback_onaudiovolumeindication)

Reports the volume information of users.

```cpp
virtual void onAudioVolumeIndication(const AudioVolumeInfo* speakers,
    unsigned int speakerNumber,
    int totalVolume) {
    (void)speakers;
    (void)speakerNumber;
    (void)totalVolume;
    }
```

By default, this callback is disabled. You can enable it by calling [enableAudioVolumeIndication](class_irtcengine.html#api_enableaudiovolumeindication). Once this callback is enabled and users send streams in the channel, the SDK triggers the enableAudioVolumeIndication callback at the time interval set in onAudioVolumeIndication. The SDK triggers two independent onAudioVolumeIndication callbacks simultaneously, which separately report the volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous volumes are the highest.

**Note** After you enable this callback, calling [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream) affects the SDK's behavior as follows:

- If the local user stops publishing the audio stream, the SDK stops triggering the local user's callback.
- 20 seconds after a remote user whose volume is one of the three highest stops publishing the audio stream, the callback excludes this user's information; 20 seconds after all remote users stop publishing audio streams, the SDK stops triggering the callback for remote users.

### Parameters

- speakers

  The volume information of the users, see [AudioVolumeInfo](rtc_api_data_type.html#class_audiovolumeinfo). An empty **speakers** array in the callback indicates that no remote user is in the channel or sending a stream at the moment.

- speakerNumber

  The total number of users.In the callback for the local user, if the local user is sending streams, the value of **speakerNumber** is 1.In the callback for remote users, the value range of **speakerNumber** is [0,3]. If the number of remote users who send streams is greater than or equal to three, the value of **speakerNumber** is 3.

- totalVolume

  The volume of the speaker. The value range is [0,255].In the callback for the local user, **totalVolume** is the volume of the local user who sends a stream.In the callback for remote users, **totalVolume** is the sum of the volume of all remote users (up to three) whose instantaneous volumes are the highest. If the user calls [startAudioMixing [2/2\]](class_irtcengine.html#api_startaudiomixing2), then **totalVolume** is the volume after audio mixing.

**See als**

- [enableAudioVolumeIndication](../API/class_irtcengine.html#api_enableaudiovolumeindication)
- [startPlaybackDeviceTest](../API/class_iaudiodevicemanager.html#api_iaudiodevicemanager_startplaybackdevicetest)
- [startRecordingDeviceTest](../API/class_iaudiodevicemanager.html#api_iaudiodevicemanager_startrecordingdevicetest)
- [startAudioDeviceLoopbackTest](../API/class_iaudiodevicemanager.html#api_iaudiodevicemanager_startaudiodeviceloopbacktest)

## [onCameraExposureAreaChanged](class_irtcengineeventhandler.html#callback_oncameraexposureareachanged)

Occurs when the camera exposure area changes.

```cpp
virtual void onCameraExposureAreaChanged(int x, int y, int width, int height) {
     (void)x;
     (void)y;
     (void)width;
     (void)height;
     }
```

The SDK triggers this callback when the local user changes the camera exposure position by calling [setCameraExposurePosition](class_irtcengine.html#api_setcameraexposureposition).

**Note** This method is for Android and iOS only.

### Parameters

- x

  The x coordinate of the changed camera exposure area.

- y

  The y coordinate of the changed camera exposure area.

- width

  The width of the changed camera exposure area.

- height

  The height of the changed exposure area.

## [onCameraFocusAreaChanged](class_irtcengineeventhandler.html#callback_oncamerafocusareachanged)

Occurs when the camera focus area changes.

```cpp
virtual void onCameraFocusAreaChanged(int x, int y, int width, int height) {
     (void)x;
     (void)y;
     (void)width;
     (void)height;
     }
```

The SDK triggers this callback when the local user changes the camera focus position by calling [setCameraFocusPositionInPreview](class_irtcengine.html#api_setcamerafocuspositioninpreview).

**Note** This method is for Android and iOS only.

### Parameters

- x

  The x coordinate of the changed camera focus area.

- y

  The y coordinate of the changed camera focus area.

- width

  The width of the changed camera focus area.

- height

  The height of the changed camera focus area.

## [onCameraReady](class_irtcengineeventhandler.html#callback_oncameraready)

Occurs when the camera turns on and is ready to capture the video.

```cpp
virtual void onCameraReady()
```

- Deprecated:

  Please use LOCAL_VIDEO_STREAM_STATE_CAPTURING(1) in [onLocalVideoStateChanged](class_irtcengineeventhandler.html#callback_onlocalvideostatechanged) instead.

This callback indicates that the camera has been successfully turned on and you can start to capture video.

## [onChannelMediaRelayEvent](class_irtcengineeventhandler.html#callback_onchannelmediarelayevent)

Reports events during the media stream relay.

```cpp
virtual void onChannelMediaRelayEvent(int code) {
  (void)code;
}
```



### Parameters

- code

  The event code of channel media relay. See [CHANNEL_MEDIA_RELAY_EVENT](rtc_api_data_type.html#enum_channelmediarelayevent).

**See als**

- [startChannelMediaRelay](../API/class_irtcengine.html#api_startchannelmediarelay)
- [updateChannelMediaRelay](../API/class_irtcengine.html#api_updatechannelmediarelay)
- [pauseAllChannelMediaRelay](../API/class_irtcengine.html#api_pauseallchannelmediarelay)
- [resumeAllChannelMediaRelay](../API/class_irtcengine.html#api_resumeallchannelmediarelay)

## [onChannelMediaRelayStateChanged](class_irtcengineeventhandler.html#callback_onchannelmediarelaystatechanged)

Occurs when the state of the media stream relay changes.

```cpp
virtual void onChannelMediaRelayStateChanged(CHANNEL_MEDIA_RELAY_STATE state,CHANNEL_MEDIA_RELAY_ERROR code) {
    }
```

The SDK returns the state of the current media relay with any error message.

### Parameters

- state

  The state code. For details, see [CHANNEL_MEDIA_RELAY_STATE](rtc_api_data_type.html#enum_channelmediarelaystate).

- code

  The error code of the channel media replay. For details, see [CHANNEL_MEDIA_RELAY_ERROR](rtc_api_data_type.html#enum_channelmediarelayerror).

**See als**

- [startChannelMediaRelay](../API/class_irtcengine.html#api_startchannelmediarelay)
- [stopChannelMediaRelay](../API/class_irtcengine.html#api_stopchannelmediarelay)

## [onClientRoleChanged](class_irtcengineeventhandler.html#callback_onclientrolechanged)

Occurs when the user role switches in the interactive live streaming.

```cpp
virtual void onClientRoleChanged(CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole)
```

The SDK triggers this callback when the local user switches the user role after joining the channel.

### Parameters

- oldRole

  Role that the user switches from: [CLIENT_ROLE_TYPE](rtc_api_data_type.html#enum_clientroletype).

- newRole

  Role that the user switches to: [CLIENT_ROLE_TYPE](rtc_api_data_type.html#enum_clientroletype).

**See als**

- [setClientRole [1/2\]](../API/class_irtcengine.html#api_setclientrole)
- [setClientRole [2/2\]](../API/class_irtcengine.html#api_setclientrole2)

## [onConnectionBanned](class_irtcengineeventhandler.html#callback_onconnectionbanned)

Occurs when the connection is banned by the Agora server.

```cpp
virtual void onConnectionBanned()
```

- Deprecated:

  Please use [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) instead.

## [onConnectionInterrupted](class_irtcengineeventhandler.html#callback_onconnectioninterrupted)

Occurs when the connection between the SDK and the server is interrupted.

```cpp
virtual void onConnectionInterrupted() {}
```

- Deprecated:

  Please use [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) instead.

The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. The difference between this callback and [onConnectionLost](class_irtcengineeventhandler.html#callback_onconnectionlost) is:

- The SDK triggers the onConnectionInterrupted callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
- The SDK triggers the onConnectionLost callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.

If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.

## [onConnectionLost](class_irtcengineeventhandler.html#callback_onconnectionlost)

Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.

```cpp
virtual void onConnectionLost()
```

The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the joinChannel [2/2] method, regardless of whether it is in the channel. If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.

## [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged)

Occurs when the network connection state changes.

```cpp
virtual void onConnectionStateChanged(CONNECTION_STATE_TYPE state, CONNECTION_CHANGED_REASON_TYPE reason) {
     (void)state;
     (void)reason;
     }
```

When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.

### Parameters

- state

  The current connection state. For details, see [CONNECTION_STATE_TYPE](rtc_api_data_type.html#enum_connectionstatetype).

- reason

  The reason for a connection state change. For details, see [CONNECTION_CHANGED_REASON_TYPE](rtc_api_data_type.html#enum_connectionchangedreasontype).

**See als**

- [renewToken](../API/class_irtcengine.html#api_renewtoken)

## [onEncryptionError](class_irtcengineeventhandler.html#callback_onencryptionerror)

Reports the built-in encryption errors.

```cpp
virtual void onEncryptionError(ENCRYPTION_ERROR_TYPE errorType) {
  (void)errorType;
}
```

When encryption is enabled by calling [enableEncryption](class_irtcengine.html#api_enableencryption), the SDK triggers this callback if an error occurs in encryption or decryption on the sender or the receiver side.

### Parameters

- errorType

  For details about the error type, see [ENCRYPTION_ERROR_TYPE](rtc_api_data_type.html#enum_encryptionerrortype).

## [onError](class_irtcengineeventhandler.html#callback_onerror)

Reports an error during SDK runtime.

```cpp
virtual void onError(int err, const char* msg) {
    (void)err;
    (void)msg;
    }
```

This callback indicates that an error (concerning network or media) occurs during SDK runtime. In most cases, the SDK cannot fix the issue and resume running. The SDK requires the application to take action or informs the user about the issue. For example, the SDK reports an **ERR_START_CALL** error when failing to initialize a call. The app informs the user that the call initialization failed and calls [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel) to leave the channel.

### Parameters

- err

  The error code.

## [onExtensionError](class_irtcengineeventhandler.html#callback_onextensionerror)

Occurs when the extension runs incorrectly.

```cpp
virtual void onExtensionError(const char* provider, const char* extension, int error, const char* message) {
    (void)provider;
    (void)extension;
    (void)error;
    (void)message;
  }
```

When calling `enableExtension(true)` fails or the extension runs in error, the extension triggers this callback and reports the error code and reason.

### Parameters

- provider

  The name of the extension provider.

- extension

  The name of the extension.

- error

  Error code. For details, see the extension documentation provided by the extension provider.

- message

  Reason. For details, see the extension documentation provided by the extension provider.

**See als**

- [enableExtension](../API/class_irtcengine.html#api_enableextension)

## [onExtensionEvent](class_irtcengineeventhandler.html#callback_onextensionevent)

The event callback of the extension.

```cpp
virtual void onExtensionEvent(const char* provider, const char* extension, const char* key, const char* value) {
 (void)provider;
  (void)extension;
  (void)key;
  (void)value;
  }
```

To listen for events while the extension is running, you need to register this callback.

### Parameters

- provider

  The name of the extension provider.

- extension

  The name of the extension.

- key

  The key of the extension.

- value

  The value of the extension key.

## [onExtensionStarted](class_irtcengineeventhandler.html#callback_onextensionstarted)

Occurs when the extension is enabled.

```cpp
virtual void onExtensionStarted(const char* provider, const char* extension) {
  (void)provider;
  (void)extension;
}
```

After a successful call of `enableExtension(true)`, the extension triggers this callback.

### Parameters

- provider

  The name of the extension provider.

- extension

  The name of the extension.

**See als**

- [enableExtension](../API/class_irtcengine.html#api_enableextension)

## [onExtensionStopped](class_irtcengineeventhandler.html#callback_onextensionstoped)

Occurs when the extension is disabled.

```cpp
virtual void onExtensionStopped(const char* provider, const char* extension) {
    (void)provider;
    (void)extension;
  }
```

After a successful call of `enableExtension(false)`, the extension triggers this callback.

### Parameters

- provider

  The name of the extension provider.

- extension

  The name of the extension.

**See als**

- [enableExtension](../API/class_irtcengine.html#api_enableextension)

## [onFacePositionChanged](class_irtcengineeventhandler.html#callback_onfacepositionchanged)

Reports the face detection result of the local user.

```cpp
virtual void onFacePositionChanged(int imageWidth, int imageHeight,
                const Rectangle* vecRectangle, const int* vecDistance,
                int numFaces) {
                (void) imageWidth;
                (void) imageHeight;
                (void) vecRectangle;
                (void) vecDistance;
                (void) numFaces;
                }
```



Once you enable face detection by calling [enableFaceDetection](class_irtcengine.html#api_enablefacedetection)(true), you can get the following information on the local user in real-time:

- The width and height of the local video.
- The position of the human face in the local video.
- The distance between the human face and the screen.

The distance between the human face and the screen is based on the fitting calculation of the local video size and the position of the human face captured by the camera.

**Note**

- This callback is for Android and iOS only.
- If the SDK does not detect a face, it reduces the frequency of this callback to reduce power consumption on the local device.
- The SDK stops triggering this callback when a human face is in close proximity to the screen.
- On Android, the value of **distance** reported in this callback may be slightly different from the actual distance. Therefore, Agora does not recommend using it for accurate calculation.

### Parameters

- imageWidth

  The width (px) of the video image captured by the local camera.

- imageHeight

  The height (px) of the video image captured by the local camera.

- vecRectangle

  The information of the detected human face.`x`: The x coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the x coordinate represents the relative lateral displacement of the top left corner of the human face to the origin.`y`: The y coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the y coordinate represents the relative longitudinal displacement of the top left corner of the human face to the origin.`width`: The `width` (px) of the human face in the captured video.`height`: The `height` (px) of the human face in the captured video.

- vecDistance

  The distance between the human face and the device screen (cm).

- numFaces

  The number of faces detected. If the value is 0, it means that no human face is detected.

## [onFirstLocalAudioFramePublished](class_irtcengineeventhandler.html#callback_onfirstlocalaudioframepublished)

Occurs when the first audio frame is published.

```cpp
virtual void onFirstLocalAudioFramePublished(int elapsed) {
    (void)elapsed;
    }
```

The SDK triggers this callback under one of the following circumstances:

- The local client enables the audio module and calls joinChannel [2/2] successfully.
- The local client calls [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream)(`true`) and muteLocalAudioStream(`false`) in sequence.
- The local client calls [disableAudio](class_irtcengine.html#api_disableaudio) and [enableAudio](class_irtcengine.html#api_enableaudio) in sequence.
- The[pushAudioFrame](class_imediaengine.html#api_imediaengine_pushaudioframe0) local client calls to successfully push the audio frame to the SDK.

### Parameters

- elapsed

  The time elapsed (ms) from the local client calling joinChannel [2/2] until the SDK triggers this callback.

## [onFirstLocalVideoFrame](class_irtcengineeventhandler.html#callback_onfirstlocalvideoframe)

Occurs when the first local video frame is rendered.

```cpp
virtual void onFirstLocalVideoFrame(int width,
     int height,
     int elapsed) {
     (void)width;
     (void)height;
     (void)elapsed;
     }
```

The SDK triggers this callback when the first local video frame is displayed/rendered on the local video view.

### Parameters

- width

  The width (px) of the first local video frame.

- height

  The height (px) of the first local video frame.

- elapsed

  The time elapsed (ms) from the local user calling joinChannel [2/2]until the SDK triggers this callback. If you call [startPreview](class_irtcengine.html#api_startpreview) before calling joinChannel [2/2], then this parameter is the time elapsed from calling the startPreview method until the SDK triggers this callback.

## [onFirstLocalVideoFramePublished](class_irtcengineeventhandler.html#callback_onfirstlocalvideoframepublished)

Occurs when the first video frame is published.

```cpp
virtual void onFirstLocalVideoFramePublished(int elapsed) {
    (void)elapsed;
    }
```

The SDK triggers this callback under one of the following circumstances:

- The local client enables the video module and calls joinChannel [2/2] successfully.
- The local client calls [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream)(`true`) and muteLocalVideoStream(`false`) in sequence.
- The local client calls [disableVideo](class_irtcengine.html#api_disablevideo) and [enableVideo](class_irtcengine.html#api_enablevideo) in sequence.
- The local client calls [pushVideoFrame [1/2\]](class_imediaengine.html#api_imediaengine_pushvideoframe) to successfully push the video frame to the SDK.

### Parameters

- elapsed

  The time elapsed(ms) from the local client calling joinChannel [2/2] until the SDK triggers this callback.

## [onFirstRemoteAudioFrame](class_irtcengineeventhandler.html#callback_onfirstremoteaudioframe)

Occurs when the SDK receives the first audio frame from a specific remote user.

```cpp
virtual void onFirstRemoteAudioFrame(uid_t uid, int elapsed) AGORA_DEPRECATED_ATTRIBUTE {
    (void)uid;
    (void)elapsed;
  }
```

- Deprecated:

  Please use [onRemoteAudioStateChanged](class_irtcengineeventhandler.html#callback_onremoteaudiostatechanged) instead.

### Parameters

- uid

  The user ID of the remote user.

- elapsed

  The time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.

## [onFirstRemoteAudioDecoded](class_irtcengineeventhandler.html#callback_onfirstremoteaudiodecoded)

Occurs when the SDK decodes the first remote audio frame for playback.

```cpp
virtual void onFirstRemoteAudioDecoded(uid_t uid, int elapsed) {
                (void)uid;
                (void)elapsed;
                }
            
```



- Deprecated:

  Please use [onRemoteAudioStateChanged](class_irtcengineeventhandler.html#callback_onremoteaudiostatechanged) instead.

The SDK triggers this callback under one of the following circumstances:

- The remote user joins the channel and sends the audio stream for the first time.
- The remote user's audio is offline and then goes online to re-send audio. It means the local user cannot receive audio in 15 seconds. Reasons for such an interruption include:
  - The remote user leaves channel.
  - The remote user drops offline.
  - The remote user calls [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream) to stop sending the audio stream.
  - The remote user calls [disableAudio](class_irtcengine.html#api_disableaudio) to disable audio.

### Parameters

- uid

  The ID of the remote user.

- elapsed

  The time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.

## [onFirstRemoteVideoDecoded](class_irtcengineeventhandler.html#callback_onfirstremotevideodecoded)

Occurs when the first remote video frame is received and decoded.

```cpp
virtual void onFirstRemoteVideoDecoded(uid_t uid,
    int width,
    int height,
    int elapsed) {
    (void)uid;
    (void)width;
    (void)height;
    (void)elapsed;
    }
```

- Deprecated:

  Please use the [onRemoteVideoStateChanged](class_irtcengineeventhandler.html#callback_onremotevideostatechanged) callback with the following parameters:REMOTE_VIDEO_STATE_STARTING (1).REMOTE_VIDEO_STATE_DECODING (2).

The SDK triggers this callback under one of the following circumstances:

- The remote user joins the channel and sends the video stream.
- The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:
  - The remote user leaves the channel.
  - The remote user drops offline.
  - The remote user calls [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream) to stop sending the video stream.
  - The remote user calls [disableVideo](class_irtcengine.html#api_disablevideo) to disable video.

### Parameters

- uid

  The user ID of the remote user sending the video stream.

- width

  The width (px) of the video stream.

- height

  The height (px) of the video stream.

- elapsed

  The time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.

## [onFirstRemoteVideoFrame](class_irtcengineeventhandler.html#callback_onfirstremotevideoframe)

Occurs when the first remote video frame is rendered.

```cpp
virtual void onFirstRemoteVideoFrame(uid_t userId, int width, int height, int elapsed) {
                    (void)userId;
                    (void)width;
                    (void)height;
                    (void)elapsed;
                    }
```



The SDK triggers this callback when the first local video frame is displayed/rendered on the local video view. The application can retrieve the time elapsed (the **elapsed** parameter) from a user joining the channel until the first video frame is displayed.

### Parameters

- userId

  The user ID of the remote user sending the video stream.

- width

  The width (px) of the video stream.

- height

  The height (px) of the video stream.

- elapsed

  Time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.

## [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess)

Occurs when a user joins a channel.

```cpp
virtual void onJoinChannelSuccess(const char* channel,
     uid_t uid,
     int elapsed) {
     (void)channel;
     (void)uid;
     (void)elapsed;
     }
```

This callback notifies the application that a user joins a specified channel.

### Parameters

- channel

  The name of the channel.

- uid

  The ID of the user who joins the channel.

- elapsed

  The time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.

**See als**

- [joinChannel [1/2\]](../API/class_irtcengine.html#api_joinchannel)
- [joinChannel [2/2\]](../API/class_irtcengine.html#api_joinchannel2_ng)
- [joinChannelWithUserAccountEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelwithuseraccountex)
- [joinChannelWithUserAccount [1/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount)
- [joinChannelWithUserAccount [2/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount2)

## [onLastmileProbeResult](class_irtcengineeventhandler.html#callback_onlastmileproberesult)

Reports the last mile network probe result.

```cpp
virtual void onLastmileProbeResult(const LastmileProbeResult& result) {
    (void)result;
    }
```

The SDK triggers this callback within 30 seconds after the app calls [startLastmileProbeTest](class_irtcengine.html#api_startlastmileprobetest).

### Parameters

- result

  The uplink and downlink last-mile network probe test result. For details, see [LastmileProbeResult](rtc_api_data_type.html#class_lastmileproberesult).

**See als**

- [startLastmileProbeTest](../API/class_irtcengine.html#api_startlastmileprobetest)

## [onLastmileQuality](class_irtcengineeventhandler.html#callback_onlastmilequality)

Reports the last-mile network quality of the local user once every two seconds.

```cpp
virtual void onLastmileQuality(int quality) {
    (void)quality;
    }
```

This callback reports the last-mile network conditions of the local user before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server.

Before the user joins the channel, this callback is triggered by the SDK once [startLastmileProbeTest](class_irtcengine.html#api_startlastmileprobetest) is called and reports the last-mile network conditions of the local user.

### Parameters

- quality

  The last mile network quality. See [QUALITY_TYPE](rtc_api_data_type.html#enum_qualitytype).

**See als**

- [startLastmileProbeTest](../API/class_irtcengine.html#api_startlastmileprobetest)

## [onLeaveChannel](class_irtcengineeventhandler.html#callback_onleavechannel)

Occurs when a user leaves a channel.

```cpp
virtual void onLeaveChannel(const RtcStats& stats) {
    (void)stats;
    }
```

This callback notifies the app that the user leaves the channel by calling [leaveChannel [1/2\]](class_irtcengine.html#api_leavechannel). From this callback, the app can get information such as the call duration and quality statistics.

### Parameters

- stats

  The statistics of the call, see [RtcStats](rtc_api_data_type.html#class_rtcstats) .

**See als**

- [leaveChannel [1/2\]](../API/class_irtcengine.html#api_leavechannel)
- [leaveChannel [2/2\]](../API/class_irtcengine.html#api_leavechannel2)
- [leaveChannelEx](../API/class_irtcengineex.html#api_irtcengineex_leavechannelex)

## [onLocalAudioStateChanged](class_irtcengineeventhandler.html#callback_onlocalaudiostatechanged)

Occurs when the local audio stream state changes.

```cpp
virtual void onLocalAudioStateChanged(LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_ERROR error) {
    (void)state;
    (void)error;
    }
```

When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local audio stream, and allows you to troubleshoot issues when audio exceptions occur.

**Note** When the state isLOCAL_AUDIO_STREAM_STATE_FAILED (3), you can view the **error** information in the **error** parameter.

### Parameters

- state

  The state of the local audio. For details, see [LOCAL_AUDIO_STREAM_STATE](rtc_api_data_type.html#enum_localaudiostreamstate).

- error

  Local audio state error codes. For details, see [LOCAL_AUDIO_STREAM_ERROR](rtc_api_data_type.html#enum_localaudiostreamerror).

**See als**

- [enableLocalAudio](../API/class_irtcengine.html#api_enablelocalaudio)

## [onLocalAudioStats](class_irtcengineeventhandler.html#callback_onlocalaudiostats)

Reports the statistics of the local audio stream.

```cpp
virtual void onLocalAudioStats(const LocalAudioStats& stats) {
    (void)stats;
    }
```

The SDK triggers this callback once every two seconds.

### Parameters

- stats

  Local audio statistics. For details, see [LocalAudioStats](rtc_api_data_type.html#class_localaudiostats).

## [onLocalUserRegistered](class_irtcengineeventhandler.html#callback_onlocaluserregistered)

Occurs when the local user registers a user account.



```cpp
virtual void onLocalUserRegistered(uid_t uid, const char* userAccount) {
     (void)uid;
     (void)userAccount;
     }
```

After the local user successfully calls [registerLocalUserAccount](class_irtcengine.html#api_registerlocaluseraccount) to register the user account or calls joinChannelWithUserAccount [2/2] to join a channel, the SDK triggers the callback and informs the local user's UID and User Account.

### Parameters

- uid

  The ID of the local user.

- userAccount

  The user account of the local user.

**See als**

- [registerLocalUserAccount](../API/class_irtcengine.html#api_registerlocaluseraccount)
- [joinChannelWithUserAccount [1/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount)
- [joinChannelWithUserAccount [2/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount2)
- [joinChannelWithUserAccountEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelwithuseraccountex)

## [onLocalVideoStateChanged](class_irtcengineeventhandler.html#callback_onlocalvideostatechanged)

Occurs when the local video stream state changes.

```cpp
virtual void onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE state, LOCAL_VIDEO_STREAM_ERROR error) {
                (void)state;
                (void)error;
                }
```



When the state of the local video stream changes (including the state of the video capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local video stream, including camera capturing and video encoding, and allows you to troubleshoot issues when exceptions occur.

The SDK triggers the onLocalVideoStateChanged callback with the state code `LOCAL_VIDEO_STREAM_STATE_FAILED` and error code `LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE` in the following situations:

- The app switches to the background, and the system gets the camera resource.
- The camera starts normally, but does not output video for four consecutive seconds.

When the camera outputs the captured video frames, if the video frames are the same for 15 consecutive frames, the SDK triggers the onLocalVideoStateChanged callback with the state code `LOCAL_VIDEO_STREAM_STATE_CAPTURING` and error code `LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE`. Note that the video frame duplication detection is only available for video frames with a resolution greater than 200 × 200, a frame rate greater than or equal to 10 fps, and a bitrate less than 20 Kbps.

**Note** For some device models, the SDK does not trigger this callback when the state of the local video changes while the local video capturing device is in use, so you have to make your own timeout judgment.

### Parameters

- state

  The state of the local video, see [LOCAL_VIDEO_STREAM_STATE](rtc_api_data_type.html#enum_localvideostreamstate).

- error

  The detailed error information, see [LOCAL_VIDEO_STREAM_ERROR](rtc_api_data_type.html#enum_localvideostreamerror).

## [onLocalVideoStats](class_irtcengineeventhandler.html#callback_onlocalvideostats)

Reports the statistics of the local video stream.

```cpp
virtual void onLocalVideoStats(const LocalVideoStats& stats) {
    (void)stats;
    }
```

The SDK triggers this callback once every two seconds to report the statistics of the local video stream.

### Parameters

- stats

  The statistics of the local video stream. For details, see [LocalVideoStats](rtc_api_data_type.html#class_localvideostats).

## [onMediaEngineStartCallSuccess](class_irtcengineeventhandler.html#callback_onmediaenginestartcallsuccess)

Occurs when the media engine call starts.

```cpp
virtual void onMediaEngineStartCallSuccess()
```

## [onNetworkQuality](class_irtcengineeventhandler.html#callback_onnetworkquality)

Reports the last mile network quality of each user in the channel.

```cpp
virtual void onNetworkQuality(uid_t uid, int txQuality, int rxQuality) {
    (void)uid;
    (void)txQuality;
    (void)rxQuality;
    }
```

This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server.

The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.

### Parameters

- uid

  User ID. The network quality of the user with this user ID is reported.

- txQuality

  Uplink network quality rating of the user in terms of the transmission bit rate, packet loss rate, average RTT (Round-Trip Time) and jitter of the uplink network. This parameter is a quality rating helping you understand how well the current uplink network conditions can support the selected video encoder configuration. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 × 480 and a frame rate of 15 fps in the LIVE_BROADCASTING profile, but might be inadequate for resolutions higher than 1280 × 720. For details, see [QUALITY_TYPE](rtc_api_data_type.html#enum_qualitytype).

- rxQuality

  Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network. For details, see [QUALITY_TYPE](rtc_api_data_type.html#enum_qualitytype).

## [onNetworkTypeChanged](class_irtcengineeventhandler.html#callback_onnetworktypechanged)

Occurs when the local network type changes.

```cpp
virtual void onNetworkTypeChanged(NETWORK_TYPE type) {
    (void)type;
    }
```

This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.

### Parameters

- type

  The type of the local network connection. For details, see [NETWORK_TYPE](rtc_api_data_type.html#enum_networktype).

## [onPermissionError](class_irtcengineeventhandler.html#callback_onpermissionerror)

Occurs when the SDK cannot get the device permission.

```cpp
virtual void onPermissionError(PERMISSION_TYPE permissionType) {
  (void)permissionType;
}
```

When the SDK fails to get the device permission, the SDK triggers this callback to report which device permission cannot be got.

**Note** This method is for Android and iOS only.

### Parameters

- permissionType

  The type of the device permission. For details, see [PERMISSION_TYPE](rtc_api_data_type.html#enum_permissiontype).

## [onRejoinChannelSuccess](class_irtcengineeventhandler.html#callback_onrejoinchannelsuccess)

Occurs when a user rejoins the channel.

```cpp
virtual void onRejoinChannelSuccess(const char* channel, uid_t uid, int elapsed) {
     (void)channel;
     (void)uid;
     (void)elapsed;
     }
```

When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.

### Parameters

- channel

  The name of the channel.

- uid

  The ID of the user who rejoins the channel.

- elapsed

  Time elapsed (ms) from starting to reconnect until the SDK triggers this callback.

**See als**

- [joinChannel [1/2\]](../API/class_irtcengine.html#api_joinchannel)
- [joinChannel [2/2\]](../API/class_irtcengine.html#api_joinchannel2_ng)

## [onRemoteAudioStateChanged](class_irtcengineeventhandler.html#callback_onremoteaudiostatechanged)

Occurs when the remote audio state changes.

```cpp
virtual void onRemoteAudioStateChanged(uid_t uid,
     REMOTE_AUDIO_STATE state,
     REMOTE_AUDIO_STATE_REASON reason,
     int elapsed) {
     (void)uid;
     (void)state;
     (void)reason;
     (void)elapsed;
     }
```

When the audio state of a remote user (in the voice/video call channel) or host (in the live streaming channel) changes, the SDK triggers this callback to report the current state of the remote audio stream.

**Note** This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.

### Parameters

- uid

  The ID of the remote user whose audio state changes.

- state

  The state of the remote audio, see [REMOTE_AUDIO_STATE](rtc_api_data_type.html#enum_remoteaudiostate).

- reason

  The reason of the remote audio state change, see [REMOTE_AUDIO_STATE_REASON](rtc_api_data_type.html#enum_remoteaudiostatereason).

- elapsed

  Time elapsed (ms) from the local user calling the joinChannel [2/2] method until the SDK triggers this callback.

## [onRemoteAudioStats](class_irtcengineeventhandler.html#callback_onremoteaudiostats)

Reports the transport-layer statistics of each remote audio stream.

```cpp
virtual void onRemoteAudioStats(const RemoteAudioStats& stats) {
    (void)stats;
    }
```

The SDK triggers this callback once every two seconds for each remote user who is sending audio streams. If a channel includes multiple remote users, the SDK triggers this callback as many times.

### Parameters

- stats

  The statistics of the received remote audio streams. See [RemoteAudioStats](rtc_api_data_type.html#class_remoteaudiostats).

## [onRemoteAudioTransportStats](class_irtcengineeventhandler.html#callback_onremoteaudiotransportstats)

Reports the transport-layer statistics of each remote audio stream.

```cpp
virtual void onRemoteAudioTransportStats(uid_t uid,
     unsigned short delay,
     unsigned short lost,
     unsigned short rxKBitRate) {
     (void)uid;
     (void)delay;
     (void)lost;
     (void)rxKBitRate;
     }
```

- Deprecated:

  Please use [onRemoteAudioStats](class_irtcengineeventhandler.html#callback_onremoteaudiostats) instead.

This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives an audio packet from a remote user. During a call, when the user receives the audio packet sent by the remote user/host, the callback is triggered every 2 seconds.

### Parameters

- uid

  The ID of the remote user sending the audio streams.

- delay

  The network delay (ms) from the sender to the receiver.

- lost

  Packet loss rate (%) of the audio packet sent from the sender to the receiver.

- rxKBitrate

  Bitrate of the received audio (Kbps).

## [onRemoteVideoStateChanged](class_irtcengineeventhandler.html#callback_onremotevideostatechanged)

Occurs when the remote video state changes.

```cpp
virtual void onRemoteVideoStateChanged(uid_t uid,
     REMOTE_VIDEO_STATE state,
     REMOTE_VIDEO_STATE_REASON reason,
     int elapsed) {
     (void)uid;
     (void)state;
     (void)reason;
     (void)elapsed;
     }
```

**Note** This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.

### Parameters

- uid

  The ID of the remote user whose video state changes.

- state

  The state of the remote video, see [REMOTE_VIDEO_STATE](rtc_api_data_type.html#enum_remotevideostate).

- reason

  The reason for the remote video state change, see [REMOTE_VIDEO_STATE_REASON](rtc_api_data_type.html#enum_remotevideostatereason).

- elapsed

  Time elapsed (ms) from the local user calling the joinChannel [2/2] method until the SDK triggers this callback.

**See als**

- [enableVideo](../API/class_irtcengine.html#api_enablevideo)
- [disableVideo](../API/class_irtcengine.html#api_disablevideo)

## [onRemoteVideoStats](class_irtcengineeventhandler.html#callback_onremotevideostats)

Reports the transport-layer statistics of each remote video stream.

```cpp
virtual void onRemoteVideoStats(const RemoteVideoStats& stats) {
    (void)stats;
    }
```

Reports the statistics of the video stream from the remote users. The SDK triggers this callback once every two seconds for each remote user. If a channel has multiple users/hosts sending video streams, the SDK triggers this callback as many times.

### Parameters

- stats

  Statistics of the remote video stream. For details, see [RemoteVideoStats](rtc_api_data_type.html#class_remotevideostats).

## [onRemoteVideoTransportStats](class_irtcengineeventhandler.html#callback_onremotevideotransportstats)

Reports the transport-layer statistics of each remote video stream.

```cpp
virtual void onRemoteVideoTransportStats(uid_t uid,
     unsigned short delay,
     unsigned short lost,
     unsigned short rxKBitRate) {
     (void)uid;
     (void)delay;
     (void)lost;
     (void)rxKBitRate;
     }
```

- Deprecated:

  Please use [onRemoteVideoStats](class_irtcengineeventhandler.html#callback_onremotevideostats) instead.

This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives a video packet from a remote user.

During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.

### Parameters

- uid

  The ID of the remote user sending the video packets.

- delay

  The network delay (ms) from the sender to the receiver.

- lost

  The packet loss rate (%) of the video packet sent from the remote user.

- rxKBitRate

  The bitrate of the received video (Kbps).

## [onRequestToken](class_irtcengineeventhandler.html#callback_onrequesttoken)

Occurs when the token expires.

```cpp
virtual void onRequestToken()
```

When the token expires during a call, the SDK triggers this callback to remind the app to renew the token.

Once you receive this callback, generate a new token on your app server, and call [joinChannel [2/2\]](class_irtcengine.html#api_joinchannel2_ng) to rejoin the channel.

## [onRtcStats](class_irtcengineeventhandler.html#callback_onrtcstats)

Reports the statistics of the current call.

```cpp
virtual void onRtcStats(const RtcStats& stats) {
    (void)stats;
    }
```

The SDK triggers this callback once every two seconds after the user joins the channel.

### Parameters

- stats

  Statistics of the RTC engine, see [RtcStats](rtc_api_data_type.html#class_rtcstats) for details.

## [onRtmpStreamingStateChanged](class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged)

Occurs when the state of the RTMP or RTMPS streaming changes.

```cpp
virtual void onRtmpStreamingStateChanged(const char *url,
     RTMP_STREAM_PUBLISH_STATE state,
     RTMP_STREAM_PUBLISH_ERROR errCode) {
     (void) url;
     (void) state;
     (void) errCode;
     }
```

The SDK triggers this callback to report the result of the local user calling the [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) or [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl) method. When the RTMP/RTMPS streaming status changes, the SDK triggers this callback and report the URL address and the current status of the streaming. This callback indicates the state of the RTMP or RTMPS streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code parameter.

### Parameters

- url

  The CDN streaming URL.

- state

  The RTMP or RTMPS streaming state, see [RTMP_STREAM_PUBLISH_STATE](rtc_api_data_type.html#enum_rtmpstreampublishstate). When the streaming status is RTMP_STREAM_PUBLISH_STATE_FAILURE(4), you can view the error information in the **errorCode** parameter.

- errCode

  The detailed error information for streaming, see [RTMP_STREAM_PUBLISH_ERROR](rtc_api_data_type.html#enum_rtmpstreampublisherror).

**See als**

- [addPublishStreamUrl](../API/class_irtcengine.html#api_addpublishstreamurl)
- [removePublishStreamUrl](../API/class_irtcengine.html#api_removepublishstreamurl)

## [onSnapshotTaken](class_irtcengineeventhandler.html#callback_onsnapshottaken)

Reports the result of taking a video snapshot.

```cpp
virtual void onSnapshotTaken(const char* channel, uid_t uid, const char* filePath, int width, int height, int errCode) {
    (void)channel;
    (void)uid;
    (void)filePath;
    (void)width;
    (void)height;
    (void)errCode;
  }
```

After a successful [takeSnapshot](class_irtcengine.html#api_takesnapshot) method call, the SDK triggers this callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.

### Parameters

- channel

  The channel name.

- uid

  The user ID. A **uid** of 0 indicates the local user.

- filePath

  The local path of the snapshot.

- width

  The width (px) of the snapshot.

- height

  The height (px) of the snapshot.

- errCode

  The message that confirms success or the reason why the snapshot is not successfully taken:0: Success.< 0: Failure:-1: The SDK fails to write data to a file or encode a JPEG image.-2: The SDK does not find the video stream of the specified user within one second after the takeSnapshot method call succeeds.

**See als**

- [takeSnapshot](../API/class_irtcengine.html#api_takesnapshot)

## [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage)

Occurs when the local user receives the data stream from the remote user.

```cpp
virtual void onStreamMessage(uid_t userId, int streamId, const char* data, size_t length, uint64_t sentTs) {
  (void)userId;
  (void)streamId;
  (void)data;
  (void)length;
  (void)sentTs;
} 
```



The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the [sendStreamMessage](class_irtcengine.html#api_sendstreammessage) method.

### Parameters

- userId

  The ID of the remote user sending the message.

- streamId

  The stream ID of the received message.

- data

  The data received.

- length

  The data length (byte).

- sentTs

  The time when the data stream is sent.

**See als**

- [sendStreamMessageEx](../API/class_irtcengineex.html#api_irtcengineex_sendstreammessageex)
- [sendStreamMessage](../API/class_irtcengine.html#api_sendstreammessage)

## [onStreamMessageError](class_irtcengineeventhandler.html#callback_onstreammessageerror)

Occurs when the local user does not receive the data stream from the remote user.

```cpp
virtual void onStreamMessageError(uid_t userId, int streamId, int code, int missed, int cached) {
    (void)userId;
    (void)streamId;
    (void)code;
    (void)missed;
    (void)cached;
  }
```



The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the [sendStreamMessage](class_irtcengine.html#api_sendstreammessage) method.

### Parameters

- userId

  The ID of the remote user sending the message.

- streamId

  The stream ID of the received message.

- code

  The error code.

- missed

  The number of lost messages.

- cached

  Number of incoming cached messages when the data stream is interrupted.

**See als**

- [sendStreamMessageEx](../API/class_irtcengineex.html#api_irtcengineex_sendstreammessageex)
- [sendStreamMessage](../API/class_irtcengine.html#api_sendstreammessage)

## [onStreamPublished](class_irtcengineeventhandler.html#callback_onstreampublished)

Occurs when an RTMP or RTMPS stream is published.

```cpp
virtual void onStreamPublished(const char *url, int error) {
    (void)url;
    (void)error;
    }
```

- Deprecated:

  Please use [onRtmpStreamingStateChanged](class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged) instead.

Reports the result of publishing an RTMP or RTMPS stream.

### Parameters

- url

  The CDN streaming URL.

- error

  Error codes of the RTMP or RTMPS streaming.`ERR_OK` (0): The publishing succeeds.`ERR_FAILED` (1): The publishing fails.`ERR_INVALID_ARGUMENT` (-2): Invalid argument used. If you do not call [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding) to configure [LiveTranscoding](rtc_api_data_type.html#class_livetranscoding) before calling [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl), the SDK reports `ERR_INVALID_ARGUMENT`.`ERR_TIMEDOUT` (10): The publishing timed out.`ERR_ALREADY_IN_USE` (19): The chosen URL address is already in use for CDN live streaming.`ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH` (130): You cannot publish an encrypted stream.`ERR_PUBLISH_STREAM_CDN_ERROR` (151): CDN related error. Remove the original URL address and add a new one by calling the [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl) and [addPublishStreamUrl](class_irtcengine.html#api_addpublishstreamurl) methods.`ERR_PUBLISH_STREAM_NUM_REACH_LIMIT` (152): The host manipulates more than 10 URLs. Delete the unnecessary URLs before adding new ones.`ERR_PUBLISH_STREAM_NOT_AUTHORIZED` (153): The host manipulates other hosts' URLs. Please check your app logic.`ERR_PUBLISH_STREAM_INTERNAL_SERVER_ERROR` (154): An error occurs in Agora's streaming server. Call the [removePublishStreamUrl](class_irtcengine.html#api_removepublishstreamurl) method to publish the streaming again.`ERR_PUBLISH_STREAM_FORMAT_NOT_SUPPORTED` (156): The format of the CDN streaming URL is not supported. Check whether the URL format is correct.

## [onStreamUnpublished](class_irtcengineeventhandler.html#callback_onstreamunpublished)

Occurs when an RTMP or RTMPS stream is removed.

```cpp
virtual void onStreamUnpublished(const char *url) {
    (void)url;
    }
```

- Deprecated:

  Please use [onRtmpStreamingStateChanged](class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged) instead.

### Parameters

- url

  The URL of the removed RTMP or RTMPS stream.

## [onTokenPrivilegeWillExpire](class_irtcengineeventhandler.html#callback_ontokenprivilegewillexpire)

Occurs when the token expires in 30 seconds.

```cpp
virtual void onTokenPrivilegeWillExpire(const char* token) {
    (void)token;
    }
```

When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token.

Upon receiving this callback, generate a new token on your server, and call [renewToken](class_irtcengine.html#api_renewtoken) to pass the new token to the SDK.

### Parameters

- token

  The token that expires in 30 seconds.

**See als**

- [renewToken](../API/class_irtcengine.html#api_renewtoken)

## [onTranscodingUpdated](class_irtcengineeventhandler.html#callback_ontranscodingupdated)

Occurs when the publisher's transcoding is updated.

```cpp
virtual void onTranscodingUpdated()
```

When the [LiveTranscoding](rtc_api_data_type.html#class_livetranscoding) class in the [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding) method updates, the SDK triggers the onTranscodingUpdated callback to report the update information.

**Note** If you call the setLiveTranscoding method to set the LiveTranscoding class for the first time, the SDK does not trigger this callback.

**See als**

- [setLiveTranscoding](../API/class_irtcengine.html#api_setlivetranscoding)

## [onUplinkNetworkInfoUpdated](class_irtcengineeventhandler.html#callback_onuplinknetworkinfoupdated)

Occurs when the uplink network information changes.

```cpp
virtual void onUplinkNetworkInfoUpdated(const UplinkNetworkInfo& info) {
  (void)info;
}
```

The SDK triggers this callback when the uplink network information changes.

**Note** This callback only applies to scenarios where you push externally encoded video data in H.264 format to the SDK.

### Parameters

- info

  The uplink network information. See [UplinkNetworkInfo](rtc_api_data_type.html#class_uplinknetworkinfo).

## [onUserEnableLocalVideo](class_irtcengineeventhandler.html#callback_onuserenablelocalvideo)

Occurs when a specific remote user enables/disables the local video capturing function.

```cpp
virtual void onUserEnableLocalVideo(uid_t uid, bool enabled) {
    (void)uid;
    (void)enabled;
    }
```

The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the [enableLocalVideo](class_irtcengine.html#api_enablelocalvideo) method.

### Parameters

- uid

  The user ID of the remote user.

- enabled

  Whether the specified remote user enables/disables the local video capturing function:`true`: Enable. Other users in the channel can see the video of this remote user.`false`: Disable. Other users in the channel can no longer receive the video stream from this remote user, while this remote user can still receive the video streams from other users.

**See als**

- [enableLocalVideo](../API/class_irtcengine.html#api_enablelocalvideo)

## [onUserEnableVideo](class_irtcengineeventhandler.html#callback_onuserenablevideo)

Occurs when a remote user enables/disables the video module.

```cpp
virtual void onUserEnableVideo(uid_t uid, bool enabled) {
    (void)uid;
    (void)enabled;
    }
```

Once the video module is disabled, the user can only use a voice call. The user cannot send or receive any video.

The SDK triggers this callback when a remote user enables or disables the video module by calling the [enableVideo](class_irtcengine.html#api_enablevideo) or [disableVideo](class_irtcengine.html#api_disablevideo) method.

### Parameters

- uid

  The user ID of the remote user.

- enabled

  `true`: Enable.`false`: Disable.

**See als**

- [enableVideo](../API/class_irtcengine.html#api_enablevideo)
- [disableVideo](../API/class_irtcengine.html#api_disablevideo)

## [onUserInfoUpdated](class_irtcengineeventhandler.html#callback_onuserinfoupdated)

Occurs when the SDK gets the user ID and user account of the remote user.



```cpp
virtual void onUserInfoUpdated(uid_t uid, const UserInfo& info) {
     (void)uid;
     (void)info;
     }
```

After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers this callback on the local client.

### Parameters

- uid

  The ID of the remote user.

- info

  The UserInfo object that contains the user ID and user account of the remote user. See [UserInfo](rtc_api_data_type.html#class_userinfo) for details.

**See als**

- [joinChannelWithUserAccountEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelwithuseraccountex)
- [joinChannelWithUserAccount [1/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount)
- [joinChannelWithUserAccount [2/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount2)

## [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined)

Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel.

```cpp
virtual void onUserJoined(uid_t uid, int elapsed) {
    (void)uid;
    (void)elapsed;
    }
```

- In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
- In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17.

The SDK triggers this callback under one of the following circumstances:

- A remote user/host joins the channel by calling the joinChannel [2/2] method.
- A remote user switches the user role to the host after joining the channel.
- A remote user/host rejoins the channel after a network interruption.

### Parameters

- uid

  The ID of the user or host who joins the channel.

- elapsed

  Time delay (ms) from the local user calling joinChannel [2/2] until this callback is triggered.

**See als**

- [joinChannel [1/2\]](../API/class_irtcengine.html#api_joinchannel)
- [joinChannel [2/2\]](../API/class_irtcengine.html#api_joinchannel2_ng)
- [setClientRole [1/2\]](../API/class_irtcengine.html#api_setclientrole)
- [setClientRole [2/2\]](../API/class_irtcengine.html#api_setclientrole2)
- [joinChannelWithUserAccountEx](../API/class_irtcengineex.html#api_irtcengineex_joinchannelwithuseraccountex)
- [joinChannelWithUserAccount [1/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount)
- [joinChannelWithUserAccount [2/2\]](../API/class_irtcengine.html#api_joinchannelwithuseraccount2)

## [onUserMuteAudio](class_irtcengineeventhandler.html#callback_onusermuteaudio)

Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) joins the channel.

```cpp
virtual void onUserMuteAudio(uid_t uid, bool muted) {
    (void)uid;
    (void)muted;
    }
```

The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the [muteLocalAudioStream](class_irtcengine.html#api_mutelocalaudiostream) method.

**Note** This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming profile) in the channel exceeds 17.

### Parameters

- uid

  User ID.

- muted

  Whether the remote user's audio stream is muted/unmuted:`true`: Muted.`false`: Unmuted.

**See als**

- [muteLocalAudioStream](../API/class_irtcengine.html#api_mutelocalaudiostream)

## [onUserMuteVideo](class_irtcengineeventhandler.html#callback_onusermutevideo)

Occurs when a remote user's video stream playback pauses/resumes.

```cpp
virtual void onUserMuteVideo(uid_t uid, bool muted) {
    (void)uid;
    (void)muted;
    }
```

The SDK triggers this callback when the remote user stops or resumes sending the video stream by calling the [muteLocalVideoStream](class_irtcengine.html#api_mutelocalvideostream) method.

**Note** This callback does not work properly when the number of users (in the COMMUNICATION profile) or hosts (in the LIVE_BROADCASTING profile) in the channel exceeds 17.

### Parameters

- uid

  The ID of the remote user.

- muted

  Whether the remote user's video stream playback is paused/resumed:`true`: Paused.`false`: Resumed.

**See als**

- [muteLocalVideoStream](../API/class_irtcengine.html#api_mutelocalvideostream)

## [onUserOffline](class_irtcengineeventhandler.html#callback_onuseroffline)

Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) leaves the channel.

```cpp
virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason) {
    (void)uid;
    (void)reason;
    }
```

There are two reasons for users to become offline:

- Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
- Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.

### Parameters

- uid

  The ID of the user who leaves the channel or goes offline.

- reason

  Reasons why the user goes offline: [USER_OFFLINE_REASON_TYPE](rtc_api_data_type.html#enum_userofflinereasontype).

**See als**

- [setClientRole [1/2\]](../API/class_irtcengine.html#api_setclientrole)
- [setClientRole [2/2\]](../API/class_irtcengine.html#api_setclientrole2)
- [leaveChannel [1/2\]](../API/class_irtcengine.html#api_leavechannel)
- [leaveChannel [2/2\]](../API/class_irtcengine.html#api_leavechannel2)
- [leaveChannelEx](../API/class_irtcengineex.html#api_irtcengineex_leavechannelex)

## [onVideoPublishStateChanged](class_irtcengineeventhandler.html#callback_onvideopublishstatechanged)

Occurs when the video publishing state changes.

```cpp
virtual void onVideoPublishStateChanged(const char* channel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {
     (void)channel;
     (void)oldState;
     (void)newState;
     (void)elapseSinceLastState;
     }
```



### Parameters

- channel

  The name of the channel.

- oldState

  For the previous publishing state, see [STREAM_PUBLISH_STATE](rtc_api_data_type.html#enum_streampublishstate).

- newState

  For the current publishing state, see STREAM_PUBLISH_STATE.

- elapseSinceLastState

  The time elapsed (ms) from the previous state to the current state.

## [onVideoSizeChanged](class_irtcengineeventhandler.html#callback_onvideosizechanged)

Occurs when the video size or rotation of a specified user changes.

```cpp
virtual void onVideoSizeChanged(uid_t uid,
     int width,
     int height,
     int rotation) {
     (void)uid;
     (void)width;
     (void)height;
     (void)rotation;
     }
```

### Parameters

- uid

  The ID of the user whose video size or rotation changes. **uid** is 0 for the local user.

- width

  The width (pixels) of the video stream.

- height

  The height (pixels) of the video stream.

- rotation

  The rotation information. The value range is [0,360).

## [onVideoStopped](class_irtcengineeventhandler.html#callback_onvideostopped)

Occurs when the video stops playing.

```cpp
virtual void onVideoStopped()
```

- Deprecated:

  Please use LOCAL_VIDEO_STREAM_STATE_STOPPED(0) in the [onLocalVideoStateChanged](class_irtcengineeventhandler.html#callback_onlocalvideostatechanged) callback instead.

The application can use this callback to change the configuration of the **view** (for example, displaying other pictures in the view) after the video stops playing.

## [onVideoSubscribeStateChanged](class_irtcengineeventhandler.html#callback_onvideosubscribestatechanged)

Occurs when the video subscribing state changes.

```cpp
virtual void onVideoSubscribeStateChanged(const char* channel,
     uid_t uid,
     STREAM_SUBSCRIBE_STATE oldState,
     STREAM_SUBSCRIBE_STATE newState,
     int elapseSinceLastState) {
     (void)channel;
     (void)uid;
     (void)oldState;
     (void)newState;
     (void)elapseSinceLastState;
     }
```



### Parameters

- channel

  The name of the channel.

- uid

  The ID of the remote user.

- oldState

  The previous subscribing status, see [STREAM_SUBSCRIBE_STATE](rtc_api_data_type.html#enum_streamsubscribestate) for details.

- newState

  The current subscribing status, see STREAM_SUBSCRIBE_STATE for details.

- elapseSinceLastState

  The time elapsed (ms) from the previous state to the current state.

## [onWarning](class_irtcengineeventhandler.html#callback_onwarning)

Reports a warning during SDK runtime.

```cpp
virtual void onWarning(int warn, const char* msg) {
    (void)warn;
    (void)msg;
    }
```

Occurs when a warning occurs during SDK runtime. In most cases, the app can ignore the warnings reported by the SDK because the SDK can usually fix the issue and resume running. For example, when losing connection with the server, the SDK may report **WARN_LOOKUP_CHANNEL_TIMEOUT** and automatically try to reconnect.

### Parameters

- warn

  Warning codes.

- msg

  Warning description.