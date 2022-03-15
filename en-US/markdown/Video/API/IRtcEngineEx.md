# [IRtcEngineEx](class_irtcengineex.html#class_irtcengineex)

This interface class contains multi-channel methods.

Inherited from [IRtcEngine](class_irtcengine.html#class_irtcengine).

## [addPublishStreamUrlEx](class_irtcengineex.html#api_addpublishstreamurlex)

Publishes the local stream to a specified CDN live streaming URL.

```cpp
virtual int addPublishStreamUrlEx(const char* url, bool transcodingEnabled, const RtcConnection& connection) = 0;
```

After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN according to [RtcConnection](rtc_api_data_type.html#class_rtcconnection). The SDK triggers the [onRtmpStreamingStateChanged](class_irtcengineeventhandler.html#callback_onrtmpstreamingstatechanged) callback on the local client to report the state of adding a local stream to the CDN.

**Note**

- Call this method after joining a channel.
- Ensure that the media push function is enabled.
- This method takes effect only when you are a host in live interactive streaming.
- This method adds only one streaming URL to the CDN each time it is called. To push multiple URLs, call this method multiple times.
- In one [IRtcEngineEx](class_irtcengineex.html#class_irtcengineex) instance, you can only push one upstream media stream to the CDN (such as the video stream captured by the camera or the video stream for screen sharing selected by the RtcConnection).
- Agora only supports pushing media streams to the CDN in RTMPS protocol when you enable transcoding.

### Parameters

- url

  The CDN streaming URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.

- transcodingEnabled

  Whether to enable transcoding. [Transcoding](https://docs.agora.io/en/Agora Platform/transcoding) in a CDN live streaming converts the audio and video streams before pushing them to the CDN server. It applies to scenarios where a channel has multiple broadcasters and composite layout is needed.`true`: Enable transcoding.`false`: Disable transcoding.**Note** If you set this parameter as `true`, ensure that you call the [setLiveTranscoding](class_irtcengine.html#api_setlivetranscoding) method before calling this method.

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.
  - -2: Invalid parameter, usually an empty URL or a string with a length of 0.
  - -7: The engine is not initialized when streaming.

## [addVideoWatermarkEx](class_irtcengineex.html#api_irtcengineex_addvideowatermarkex)

Adds a watermark image to the local video.

```cpp
virtual int addVideoWatermarkEx(const char* watermarkUrl, 
    const WatermarkOptions& options, 
    const RtcConnection& connection) = 0;
```

This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.

The watermark coordinates are dependent on the settings in the [setVideoEncoderConfigurationEx](class_irtcengineex.html#api_irtcengineex_setvideoencoderconfigurationex) method:

- If the orientation mode of the encoding video ([ORIENTATION_MODE](rtc_api_data_type.html#enum_orientationmode)) is FIXED_LANDSCAPE, or the landscape mode in ADAPTIVE, the watermark uses the landscape orientation.
- If the orientation mode of the encoding video (ORIENTATION_MODE) is FIXED_PORTRAIT, or the portrait mode in ADAPTIVE, the watermark uses the portrait orientation.
- When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfigurationEx method. Otherwise, the watermark image will be cropped.

**Note**

- Ensure that you have called [enableVideo](class_irtcengine.html#api_enablevideo) before calling this method.
- This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
- If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
- If you have enabled the local video preview by calling the [startPreview](class_irtcengine.html#api_startpreview) method, you can use the `visibleInPreview` member to set whether or not the watermark is visible in the preview.
- If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.

### Parameters

- watermarkUrl

  The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.

- options

  The options of the watermark image to be added. For details, see [WatermarkOptions](rtc_api_data_type.html#class_watermarkoptions).

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

## [clearVideoWatermarkEx](class_irtcengineex.html#api_irtcengineex_clearvideowatermarkex)

Removes the watermark image from the video stream.

```cpp
virtual int clearVideoWatermarkEx(const RtcConnection& connection) = 0;
```

### Parameters

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

## [createDataStreamEx [1/2\]](class_irtcengineex.html#api_irtcengineex_createdatastreamex)

Creates a data stream.

```cpp
virtual int createDataStreamEx(int* streamId, bool reliable, bool ordered, const RtcConnection& connection) = 0;
```

- Deprecated:

  This method is deprecated. Please use [createDataStreamEx [2/2\]](class_irtcengineex.html#api_irtcengineex_createdatastreamex2) instead.

You can call this method to create a data stream and improve the reliability and ordering of data transmission.

**Note**

- Ensure that you set the same value for `reliable` and `ordered`.
- Each user can create up to five data streams during the lifecycle of [IRtcEngine](class_irtcengine.html#class_irtcengine).
- The data channel allows a data delay of up to 5 seconds. If the receiver does not receive the data stream within 5 seconds, the data channel reports an error.

### Parameters

- streamId

  Output parameter. Pointer to the ID of the created data stream.

- reliable

  Sets whether the recipients are guaranteed to receive the data stream from the sender within five seconds:`true`: The recipients receive the data stream from the sender within five seconds. If the recipient does not receive the data stream within five seconds, an error is reported to the application.`false`: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.

- ordered

  Sets whether the recipients receive the data stream in the sent order:`true`: The recipients receive the data in the sent order.`false`: The recipients receive the data in the sent order.

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: The data stream is successfully created.
- < 0: Fails to create the data stream.

## [createDataStreamEx [2/2\]](class_irtcengineex.html#api_irtcengineex_createdatastreamex2)

Creates a data stream.

```cpp
virtual int createDataStreamEx(int* streamId, DataStreamConfig& config, const RtcConnection& connection) = 0;
```

Creates a data stream. Each user can create up to five data streams in a single channel.

Compared with [createDataStreamEx [1/2\]](class_irtcengineex.html#api_irtcengineex_createdatastreamex), this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.

### Parameters

- streamId

  Output parameter. Pointer to the ID of the created data stream.

- config

  The configurations for the data stream. For details, see [DataStreamConfig](rtc_api_data_type.html#class_datastreamconfig).

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: The data stream is successfully created.
- < 0: Failure.

## [enableLoopbackRecordingEx](class_irtcengineex.html#api_irtcengineex_enableloopbackrecordingex)

Enables loopback audio capturing.

```cpp
virtual int enableLoopbackRecordingEx(bool enabled, const RtcConnection& connection) = 0;
```

If you enable loopback audio capturing, the output of the sound card is mixed into the audio stream sent to the other end.

**Note**

This method applies to macOS and Windows only.

### Parameters

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

- enabled

  Sets whether to enable loopback audio capturing.`true`: Enable loopback audio capturing.`false`: (Default) Disable loopback audio capturing.

### Returns

- 0: Success.
- < 0: Failure.

## [getConnectionStateEx](class_irtcengineex.html#api_irtcengineex_getconnectionstateex)

Gets the current connection state of the SDK.

```cpp
virtual CONNECTION_STATE_TYPE getConnectionStateEx(const RtcConnection& connection) = 0;
```

You can call this method either before or after joining a channel.

### Parameters

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

The current connection state. For details, see [CONNECTION_STATE_TYPE](rtc_api_data_type.html#enum_connectionstatetype).

## [joinChannelEx](class_irtcengineex.html#api_irtcengineex_joinchannelex)

Joins a channel with the connection ID.

```cpp
virtual int joinChannelEx(const char* token, const RtcConnection& connection,
                              const ChannelMediaOptions& options,
                              IRtcEngineEventHandler* eventHandler) = 0;
```

You can call this method multiple times to join more than one channels.

**Note**

- If you are already in a channel, you cannot rejoin it with the same user ID.
- We recommend using different user IDs for different channels.
- If you want to join the same channel from different devices, ensure that the user IDs in all devices are different.
- Ensure that the App ID you use to generate the token is the same with the App ID used when creating the [IRtcEngine](class_irtcengine.html#class_irtcengine) instance.

### Parameters

- token

  The token generated on your server for authentication. See [Authenticate Your Users with Token](https://docs.agora.io/en/live-streaming-4.x-preview/token_server_android_ng?platform=Windows).

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

- options

  The channel media options. See [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng) for details.

- eventHandler

  The callback class of [IRtcEngineEx](class_irtcengineex.html#class_irtcengineex). For details, see [IRtcEngineEventHandler](class_irtcengineeventhandler.html#class_irtcengineeventhandler).

### Returns

- 0: Success.
- < 0: Failure.

## [joinChannelWithUserAccountEx](class_irtcengineex.html#api_irtcengineex_joinchannelwithuseraccountex)

Joins the channel with a user account, and configures whether to automatically subscribe to audio or video streams after joining the channel.

```cpp
virtual int joinChannelWithUserAccountEx(const char* token, const char* channelId,
                                         const char* userAccount, const ChannelMediaOptions& options,
                                         IRtcEngineEventHandler* eventHandler) = 0;
```

This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks:

- The local client: [onLocalUserRegistered](class_irtcengineeventhandler.html#callback_onlocaluserregistered), [onJoinChannelSuccess](class_irtcengineeventhandler.html#callback_onjoinchannelsuccess) and [onConnectionStateChanged](class_irtcengineeventhandler.html#callback_onconnectionstatechanged) callbacks.
- The remote client: The [onUserJoined](class_irtcengineeventhandler.html#callback_onuserjoined) callback if the user is in the COMMUNICATION profile, and the [onUserInfoUpdated](class_irtcengineeventhandler.html#callback_onuserinfoupdated) callback if the user is a host in the LIVE_BROADCASTING profile.

Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.

**Note** To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.

### Parameters

- token

  The token generated on your server for authentication. See [Authenticate Your Users with Token](https://docs.agora.io/en/live-streaming-4.x-preview/token_server_android_ng?platform=Windows).

- channelId

  The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported character scopes are:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- userAccount

  The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):The 26 lowercase English letters: a to z.The 26 uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","

- options

  The channel media options. See [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng) for details.

- eventHandler

  The callback class of [IRtcEngineEx](class_irtcengineex.html#class_irtcengineex). For details, see [IRtcEngineEventHandler](class_irtcengineeventhandler.html#class_irtcengineeventhandler).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onLocalUserRegistered](../API/class_irtcengineeventhandler.html#callback_onlocaluserregistered)
- [onJoinChannelSuccess](../API/class_irtcengineeventhandler.html#callback_onjoinchannelsuccess)
- [onUserJoined](../API/class_irtcengineeventhandler.html#callback_onuserjoined)
- [onUserInfoUpdated](../API/class_irtcengineeventhandler.html#callback_onuserinfoupdated)

## [leaveChannelEx](class_irtcengineex.html#api_irtcengineex_leavechannelex)

Leaves a channel.

```cpp
virtual int leaveChannelEx(const RtcConnection& connection) = 0;
```

### Parameters

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onLeaveChannel](../API/class_irtcengineeventhandler.html#callback_onleavechannel)
- [onUserOffline](../API/class_irtcengineeventhandler.html#callback_onuseroffline)

## [muteRemoteAudioStreamEx](class_irtcengineex.html#api_irtcengineex_muteremoteaudiostreamex)

Stops or resumes receiving the audio stream of a specified user.

```cpp
virtual int muteRemoteAudioStreamEx(uid_t uid, bool mute, const RtcConnection& connection) = 0;
```

This method is used to stops or resumes receiving the audio stream of a specified user. You can call this method before or after joining a channel. If a user leaves a channel, the settings in this method become invalid.

### Parameters

- uid

  The ID of the specified user.

- mute

  Whether to stop receiving the audio stream of the specified user:`true`: Stop receiving the audio stream of the specified user.`false`: (Default) Resume receiving the audio stream of the specified user.

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

## [muteRemoteVideoStreamEx](class_irtcengineex.html#api_irtcengineex_muteremotevideostreamex)

Stops or resumes receiving the video stream of a specified user.

```cpp
virtual int muteRemoteVideoStreamEx(uid_t uid, bool mute, const RtcConnection& connection) = 0;
```

This method is used to stops or resumes receiving the video stream of a specified user. You can call this method before or after joining a channel. If a user leaves a channel, the settings in this method become invalid.

### Parameters

- uid

  The user ID of the remote user.

- mute

  Whether to stop receiving the video stream of the specified user:`true`: Stop receiving the video stream of the specified user.`false`: (Default) Resume receiving the video stream of the specified user.

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

## [sendCustomReportMessageEx](class_irtcengineex.html#api_irtcengineex_sendcustomreportmessageex)

Agora supports reporting and analyzing customized messages.

```cpp
virtual int sendCustomReportMessageEx(const char* id, const char* category, const char* event, const char* label,
      int value, const RtcConnection& connection) = 0;
```

Agora supports reporting and analyzing customized messages. This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes. To try out this function, contact [support@agora.io](mailto:support@agora.io) and discuss the format of customized messages with us.

## [setRemoteVoicePositionEx](class_irtcengineex.html#api_setremotevoicepositionex)

Sets the 2D position (the position on the horizontal plane) of the remote user's voice.

```cpp
virtual int setRemoteVoicePositionEx(uid_t uid, double pan, double gain, const RtcConnection& connection) = 0;
```

This method sets the voice position and volume of a remote user.

When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games.

**Note**

- For the best voice positioning, Agora recommends using a wired headset.
- Call this method after joining a channel.

### Parameters

- uid

  The user ID of the remote user.

- pan

  The voice position of the remote user. The value ranges from -1.0 to 1.0:-1.0: The remote voice comes from the left.0.0: (Default) The remote voice comes from the front.1.0: The remote voice comes from the right.

- gain

  The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

## [setVideoEncoderConfigurationEx](class_irtcengineex.html#api_irtcengineex_setvideoencoderconfigurationex)

Sets the encoder configuration for the local video.

```cpp
virtual int setVideoEncoderConfigurationEx(const VideoEncoderConfiguration& config, const RtcConnection& connection) = 0;
```

Each configuration profile corresponds to a set of video parameters, including the resolution, frame rate, and bitrate.

The **config** specified in this method is the maximum values under ideal network conditions. If the video engine cannot render the video using the specified **config** due to unreliable network conditions, the parameters further down the list are considered until a successful configuration is found.

### Parameters

- config

  Video profile. For details, see [VideoEncoderConfiguration](rtc_api_data_type.html#class_videoencoderconfiguration).

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

## [sendStreamMessageEx](class_irtcengineex.html#api_irtcengineex_sendstreammessageex)

Sends data stream messages.

```cpp
virtual int sendStreamMessageEx(int streamId, const char* data, size_t length, const RtcConnection& connection) = 0;
```

After calling [createDataStreamEx [2/2\]](class_irtcengineex.html#api_irtcengineex_createdatastreamex2), you can call this method to send data stream messages to all users in the channel.

The SDK has the following restrictions on this method:

- Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.
- Each client can send up to 6 KB of data per second.
- Each user can have up to five data streams simultaneously.

A successful method call triggers the [onStreamMessage](class_irtcengineeventhandler.html#callback_onstreammessage) callback on the remote client, from which the remote user gets the stream message. A failed method call triggers the [onStreamMessageError](class_irtcengineeventhandler.html#callback_onstreammessageerror) callback on the remote client.

**Note**

- Ensure that you call createDataStreamEx [2/2] to create a data channel before calling this method.
- This method applies only to the `COMMUNICATION` profile or to the hosts in the `LIVE_BROADCASTING` profile. If an audience in the `LIVE_BROADCASTING` profile calls this method, the audience may be switched to a host.

### Parameters

- streamId

  The data stream ID. You can get the data stream ID by calling createDataStreamEx [2/2].

- data

  The message to be sent.

- length

  The length of the data.

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.

**See also**

- [onStreamMessage](../API/class_irtcengineeventhandler.html#callback_onstreammessage)
- [onStreamMessageError](../API/class_irtcengineeventhandler.html#callback_onstreammessageerror)

## [updateChannelMediaOptionsEx](class_irtcengineex.html#api_irtcengineex_updatechannelmediaoptionsex)

Updates the channel media options after joining the channel.

```cpp
virtual int updateChannelMediaOptionsEx(const ChannelMediaOptions& options, const RtcConnection& connection) = 0;
```

### Parameters

- options

  The channel media options. See [ChannelMediaOptions](rtc_api_data_type.html#class_channelmediaoptions_ng).

- connection

  The connection info. For details, see [RtcConnection](rtc_api_data_type.html#class_rtcconnection).

### Returns

- 0: Success.
- < 0: Failure.