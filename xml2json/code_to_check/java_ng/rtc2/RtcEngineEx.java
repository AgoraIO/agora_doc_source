package io.agora.rtc2;

import io.agora.base.VideoFrame;
import io.agora.rtc2.UserInfo;
import io.agora.rtc2.video.AgoraVideoFrame;
import io.agora.rtc2.video.EncodedVideoFrameInfo;
import io.agora.rtc2.video.VideoCanvas;
import io.agora.rtc2.video.VideoEncoderConfiguration;
import io.agora.rtc2.video.WatermarkOptions;
import java.nio.ByteBuffer;

public abstract class RtcEngineEx extends RtcEngine {
  /**
   * Stops or resumes receiving the audio stream of a specified user with specified connection.
   *
   * @note
   * Once you leave the channel, the settings in this method becomes invalid.
   *
   * @param uid ID of the specified remote user.
   * @param mute Determines whether to receive or stop receiving the specified audio stream:
   * - true: Stop receiving the specified audio stream.
   * - false: (Default) Receive the specified audio stream.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteRemoteAudioStreamEx(int uid, boolean muted, RtcConnection connection);

  /**
   * Stops or resumes receiving the video stream of a specified user with specified connection.
   *
   * @note
   * Once you leave the channel, the settings in this method becomes invalid.
   *
   * @param uid ID of the specified remote user.
   * @param muted Determines whether to receive or stop receiving a specified video stream:
   * - true: Stop receiving the specified video stream.
   * - false: (Default) Receive the specified video stream.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteRemoteVideoStreamEx(int uid, boolean muted, RtcConnection connection);

  /**
   * Sets the remote video stream type.
   *
   * If the remote user has enabled the dual-stream mode, by default the SDK receives the
   * high-stream video by Call this method to switch to the low-stream video.
   *
   * @note
   * This method applies to scenarios where the remote user has enabled the dual-stream mode using
   * {@link enableDualStreamMode enableDualStreamMode}(true) before joining the channel.
   *
   * @param uid ID of the remote user sending the video stream.
   * @param streamType Sets the video stream type:
   * - 0: High-stream video.
   * - 1: Low-stream video.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteVideoStreamTypeEx(int uid, int streamType, RtcConnection connection);

  /**
   * Updates the display mode of the video view of a remote user with the specified connection.
   *
   * After initializing the video view of a remote user, you can call this method to update its
   * rendering and mirror modes. This method affects only the video view that the local user sees.
   *
   * @note
   * - Ensure that you have called {@link setupRemoteVideo setupRemoteVideo} to initialize the
   * remote video view before calling this method.
   * - During a call, you can call this method as many times as necessary to update the display mode
   * of the video view of a remote user.
   *
   * @param uid ID of the remote user.
   * @param renderMode Sets the remote display mode:
   * - `RENDER_MODE_HIDDEN(1)`: Uniformly scale the video until it fills the visible boundaries
   * (cropped). One dimension of the video may have clipped contents.
   * - `RENDER_MODE_FIT(2)`: Uniformly scale the video until one of its dimension fits the boundary
   * (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be
   * filled with black.
   * @param mirrorMode Sets the remote video mirror mode:
   * - `VIDEO_MIRROR_MODE_ENABLED(1)`: Enable the mirror mode.
   * - `VIDEO_MIRROR_MODE_DISABLED(2)`: Disable the mirror mode.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteRenderModeEx(
      int uid, int renderMode, int mirrorMode, RtcConnection connection);

  /**
   * Initializes the video view of a remote user with a specified connection ID.
   *
   * This method initializes the video view of a remote stream on the local device. It affects only
   * the video view that the local user sees.
   *
   * Usually the app should specify the `uid` of the remote video in the method call before the
   * remote user joins the channel. If the remote `uid` is unknown to the app, set it later when the
   * app receives the {@link IRtcEngineEventHandler#onUserJoined onUserJoined} callback.
   *
   * To unbind the remote user from the view, set `view` in VideoCanvas as `null`.
   *
   * @note
   * Ensure that you call this method in the UI thread.
   *
   * @param remote The remote video view settings: {@link io.agora.rtc2.video.VideoCanvas
   *     VideoCanvas}.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setupRemoteVideoEx(VideoCanvas remote, RtcConnection connection);

  /**
   * Sets the video encoder configuration with specified connection.
   *
   * Each configuration profile corresponds to a set of video parameters, including
   * the resolution, frame rate, and bitrate.
   *
   * The parameters specified in this method are the maximum values under ideal network conditions.
   * If the video engine cannot render the video using the specified parameters due
   * to poor network conditions, the parameters further down the list are considered
   * until a successful configuration is found.
   *
   * @param config The local video encoder configuration: VideoEncoderConfiguration.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setVideoEncoderConfigurationEx(
      VideoEncoderConfiguration config, RtcConnection connection);

  /**
   *  Updates the media options after joining the channel with specified connection.
   *
   * @param options The channel media options: ChannelMediaOptions.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int updateChannelMediaOptionsEx(
      ChannelMediaOptions options, RtcConnection connection);

  /**
   * Joins a channel with the connection ID.
   *
   * You can call this method multiple times to join more than one channels at a time.
   *
   * @param token The token for authentication:
   *              - In situations not requiring high security: You can use the temporary token
   * generated at Console. For details, see [Get a temporary
   * token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#temptoken).
   *              - In situations requiring high security: Set it as the token generated at your
   * server. For details, see [Get a
   * token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#generatetoken).
   * @param connection {@link RtcConnection} is used to control different connection instances
   *    *     when you join the same channel multiple times
   * @param options The channel media options: ChannelMediaOptions.
   * @param eventHandler The pointer to the IRtcEngine event handler: IRtcEngineEventHandler.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int joinChannelEx(String token, RtcConnection connection,
      ChannelMediaOptions options, IRtcEngineEventHandler eventHandler);

  /**
   * Leaves the channel with the specified connection ID.
   *
   * @param connection {@link RtcConnection} is used to control different connection instances
   *    *     when you join the same channel multiple times
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int leaveChannelEx(RtcConnection connection);

  /**
   * Pushes the external video frame to the app.
   *
   * @note
   * Ensure that you call {@link setExternalVideoSource setExternalVideoSource} before
   * calling this method.
   *
   * @param frame The external video frame: {@link io.agora.core.video.VideoFrame VideoFrame}.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pushExternalVideoFrameEx(VideoFrame frame, RtcConnection connection);

  /**
   * Pushes the external video frame to the app with specified connection.
   *
   * @note
   * Ensure that you call {@link setExternalVideoSource setExternalVideoSource} before
   * calling this method.
   *
   * @param frame The external video frame: {@link io.agora.rtc2.video.ExternalVideoFrame
   *     ExternalVideoFrame}.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success, which means that the external video frame is pushed successfully.
   * - < 0: Failure, which means that the external video frame fails to be pushed.
   */
  public abstract int pushExternalVideoFrameEx(AgoraVideoFrame frame, RtcConnection connection);

  /**
   * Pushes the encoded external video frame to the app with specified connection.
   *
   * @note
   * Ensure that you call {@link setExternalVideoSource setExternalVideoSource} before
   * calling this method.
   *
   * @param data The encoded external video data, which must be the direct buffer.
   * @param frameInfo The encoded external video frame info: {@link
   *     io.agora.rtc2.video.EncodedVideoFrameInfo EncodedVideoFrameInfo}.
   * @param connection The connection. Use the connection you use when calling
   *     `joinChannelEx`. If
   * you use `joinChannel`, use `DEFAULT_CONNECTION_ID(0)`.
   * @return
   * - 0: Success, which means that the encoded external video frame is pushed successfully.
   * - < 0: Failure, which means that the encoded external video frame fails to be pushed.
   */
  public abstract int pushExternalEncodedVideoFrameEx(
      ByteBuffer data, EncodedVideoFrameInfo frameInfo, RtcConnection connection);

  /**
   * Gets the connection state of the SDK.
   *
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return The connection state:
   * - {@link RtcConnection#CONNECTION_STATE_DISCONNECTED CONNECTION_STATE_DISCONNECTED(1)}: The SDK
   * is disconnected from Agora's edge server.
   * - {@link RtcConnection#CONNECTION_STATE_CONNECTING CONNECTION_STATE_CONNECTING(2)}: The SDK is
   * connecting to Agora's edge server.
   * - {@link RtcConnection#CONNECTION_STATE_CONNECTED CONNECTION_STATE_CONNECTED(3)}: The SDK
   * joined a channel and is connected to Agora's edge server. You can now publish or subscribe to a
   * media stream in the channel.
   * - {@link RtcConnection#CONNECTION_STATE_RECONNECTING CONNECTION_STATE_RECONNECTING(4)}: The SDK
   * keeps rejoining the channel after being disconnected from a joined channel because of network
   * issues.
   * - {@link RtcConnection#CONNECTION_STATE_FAILED CONNECTION_STATE_FAILED(5)}: The SDK fails to
   * join the channel.
   */
  public abstract RtcConnection.CONNECTION_STATE_TYPE getConnectionStateEx(
      RtcConnection connection);

  /**
   * Report custom event to argus.
   *
   * @param id Custom Event ID
   * @param category Custom Event category
   * @param event Custom Event to report
   * @param label Custom Event label
   * @param value Custom Event value
   * @param connection The connection ID.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int sendCustomReportMessageEx(
      String id, String category, String event, String label, int value, RtcConnection connection);

  /**
   * Sends data stream messages to all users in a channel.
   *
   * Up to 30 packets can be sent per second in a channel with each packet having
   * a maximum size of 1 kB. The API controls the data channel transfer rate. Each
   * client can send up to 6 kB of data per second. Each user can have up to five
   * data channels simultaneously.
   *
   * @param streamId Stream ID
   * @param message Data to be sent.
   * @param connection Connection ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int sendStreamMessageEx(int streamId, byte[] message, RtcConnection connection);

  /**
   * Creates a data stream.
   *
   * Each user can only have up to five data channels at the same time.
   *
   * @param reliable
   * - True: The recipients will receive data from the sender
   *         within 5 seconds. If the recipient does not receive the sent
   *         data within 5 seconds, the data channel will report an error
   *         to the application.
   * - False: The recipients will not receive any data, and it
   *          will not report any error upon data missing.
   *
   * @param ordered
   * - True: The recipients will receive data in the order of the sender.
   * - False: The recipients will not receive data in the order of the sender.
   *
   * @return
   * - > 0: the Stream ID when the data stream is created.
   * - < 0: an error code when it fails to create the data srteam.
   */
  public abstract int createDataStreamEx(
      boolean reliable, boolean ordered, RtcConnection connection);
  /**
   * Creates a data stream.
   *
   * Each user can create up to five data streams during the lifecycle of the RtcEngine.
   *
   * @param config The config of data stream.
   *
   * @return
   * - Returns the stream ID, if the method call is successful.
   * - < 0: Failure. The error code is related to the integer displayed in {@link
   * IRtcEngineEventHandler#onError(int) Error Codes}. For example, if it returns -2, then it
   * indicates {@link Constants#ERR_INVALID_ARGUMENT ERR_INVALID_ARGUMENT(-2)} in {@link
   * IRtcEngineEventHandler#onError(int) Error Codes}.
   */
  public abstract int createDataStreamEx(DataStreamConfig config, RtcConnection connection);

  /**
   * Joins the channel with a user account.
   *
   * After the user successfully joins the channel, the SDK triggers the following callbacks:
   *
   * - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered
   * "onLocalUserRegistered" and \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess
   * "onJoinChannelSuccess" . The remote client: \ref
   * agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" and \ref
   * agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" , if the user joining
   * the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * @note To ensure smooth communication, use the same parameter type to identify the user. For
   * example, if a user joins the channel with a user ID, then ensure all the other users use the
   * user ID too. The same applies to the user account. If a user joins the channel with the Agora
   * Web SDK, ensure that the uid of the user is set to the same parameter type.
   *
   * @param token The token generated at your server:
   * - For low-security requirements: You can use the temporary token generated at Console. For
   * details, see [Get a temporary
   * toke](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-temporary-token).
   * - For high-security requirements: Set it as the token generated at your server. For details,
   * see [Get a token](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-token).
   * @param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported
   *     character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure
   *     that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options  The channel media options: \ref
   *     agora::rtc::ChannelMediaOptions::ChannelMediaOptions "ChannelMediaOptions"
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - #ERR_INVALID_ARGUMENT (-2)
   *  - #ERR_NOT_READY (-3)
   *  - #ERR_REFUSED (-5)
   */
  public abstract int joinChannelWithUserAccountEx(String token, String channelId,
      String userAccount, ChannelMediaOptions options, IRtcEngineEventHandler eventHandler);

  /**
   * Gets the user information by passing in the user account.
   *
   * After a remote user joins the channel, the SDK gets the user ID and user account of the remote
   * user, caches them in a mapping table object (`userInfo`), and triggers the \ref
   * agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback on the local
   * client.
   *
   * After receiving the o\ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated
   * "onUserInfoUpdated" callback, you can call this method to get the user ID of the remote user
   * from the `userInfo` object by passing in the user account.
   *
   * @param userAccount The user account of the user. Ensure that you set this parameter.
   * @param channelId The channel name.
   * @param localUserAccount The user account of the local user.
   * @return userInfo  A userInfo object that identifies the user
   * - not null: Success.
   * - null: Failure.
   */
  public abstract UserInfo getUserInfoByUserAccount(String userAccount, String channelId, String localUserAccount);

  /**
   * Gets the user information by passing in the user ID.
   *
   * After a remote user joins the channel, the SDK gets the user ID and user account of the remote
   * user, caches them in a mapping table object (`userInfo`), and triggers the \ref
   * agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback on the local
   * client.
   *
   * After receiving the \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated
   * "onUserInfoUpdated" callback, you can call this method to get the user account of the remote
   * user from the `userInfo` object by passing in the user ID.
   *
   * @param uid The user ID of the remote user. Ensure that you set this parameter.
   * @param channelId The channel name.
   * @param localUserAccount The user account of the local user.
   * @return userInfo A userInfo object that identifies the user
   * - not null: Success.
   * - null: Failure.
   */
  public abstract UserInfo getUserInfoByUid(int uid, String channelId, String localUserAccount);

  /**
   * Sets the sound position and gain of a remote user.
   * When the local user calls this method to set the sound position of a remote user, the sound
   * difference between the left and right channels allows the local user to track the real-time
   * position of the remote user, creating a real sense of space. This method applies to massively
   * multiplayer online games, such as Battle Royale games.
   * @note
   * - For this method to work, enable stereo panning for remote users by calling the \ref
   * agora::rtc::IRtcEngine::enableSoundPositionIndication "enableSoundPositionIndication" method
   * before joining a channel.
   * - This method requires hardware support. For the best sound positioning, we recommend using a
   * wired headset.
   * - Ensure that you call this method after joining a channel.
   * @param uid The ID of the remote user.
   * @param pan The sound position of the remote user. The value ranges from -1.0 to 1.0:
   * - 0.0: the remote sound comes from the front.
   * - -1.0: the remote sound comes from the left.
   * - 1.0: the remote sound comes from the right.
   * @param gain Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is
   *     100.0 (the original gain of the remote user). The smaller the value, the less the gain.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteVoicePositionEx(
      int uid, double pan, double gain, RtcConnection connection);

  /**
   * Adds a watermark image to the local video.
   * @since v2.9.1 to replace {@link RtcEngine#addVideoWatermark(AgoraImage) addVideoWatermark}1.
   *
   * This method adds a PNG watermark image to the local video stream in a live streaming. Once the
   * watermark image is added, all the audience in the channel (CDN audience included), and the
   * sampling device can see and capture it.
   *
   * Agora supports adding only one watermark image onto the local video, and the newly watermark
   * image replaces the previous one.
   *
   * The watermark position depends on the settings in the {@link
   * RtcEngine#setVideoEncoderConfiguration(VideoEncoderConfiguration) setVideoEncoderConfiguration}
   * method:
   * - If the orientation mode of the encoding video is ORIENTATION_MODE_FIXED_LANDSCAPE, or the
   * landscape mode in ORIENTATION_MODE_ADAPTIVE, the watermark uses the landscape orientation.
   * - If the orientation mode of the encoding video is ORIENTATION_MODE_FIXED_PORTRAIT, or the
   * portrait mode in ORIENTATION_MODE_ADAPTIVE, the watermark uses the portrait orientation.
   * - When setting the watermark position, the region must be less than the dimensions set in the
   * setVideoEncoderConfiguration method. Otherwise, the watermark image will be cropped.
   *
   * @note
   * - Ensure that you have called the {@link RtcEngine#enableVideo enableVideo} method to enable
   * the video module before calling this method.
   * - If you only want to add a watermark image to the local video for the audience in the CDN live
   * streaming channel to see and capture, you can call this method or the {@link
   * RtcEngine#setLiveTranscoding setLiveTranscoding} method.
   * - This method supports adding a watermark image in the PNG file format only. Supported pixel
   * formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
   * - If the dimensions the PNG image differ from your settings in this method, the image will be
   * cropped or zoomed to conform to your settings.
   * - If you have enabled the local video preview by calling the {@link RtcEngine#startPreview
   * startPreview} method, you can use the `visibleInPreview` member in the `WatermarkOptions` class
   * to set whether or not the watermark is visible in preview.
   * - If you have enabled the mirror mode for the local video, the watermark on the local video is
   * also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the
   * mirror and watermark functions for the local video at the same time. You can implement the
   * watermark function in your application layer.
   *
   * @param watermarkUrl The local file path of the watermark image to be added. This method
   *     supports adding a watermark image from either the local file path or the assets file path.
   * If you use the assets file path, you need to start with `/assets/` when filling in this
   * parameter.
   * @param options  The options of the watermark image to be added. See {@link
   *     io.agora.rtc.video.WatermarkOptions Watermark Options}.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int addVideoWatermarkEx(
      String watermarkUrl, WatermarkOptions options, RtcConnection connection);

  /**
   * Removes the watermark image from the video stream added by {@link
   * RtcEngine#addVideoWatermarkEx(String watermarkUrl, WatermarkOptions options, RtcConnection
   * connection) addVideoWatermarkEx}.
   * @param connection {@link RtcConnection} is used to control different connection instances.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int clearVideoWatermarkEx(RtcConnection connection);
}
