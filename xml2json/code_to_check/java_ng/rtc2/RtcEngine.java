package io.agora.rtc2;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.view.SurfaceView;
import android.view.TextureView;
import io.agora.base.VideoFrame;
import io.agora.mediaplayer.IMediaPlayer;
import io.agora.rtc2.ClientRoleOptions;
import io.agora.rtc2.EncodedVideoTrackOptions;
import io.agora.rtc2.audio.AgoraRhythmPlayerConfig;
import io.agora.rtc2.audio.IAudioSpectrumObserver;
import io.agora.rtc2.internal.AudioEncodedFrameObserverConfig;
import io.agora.rtc2.internal.AudioRecordingConfiguration;
import io.agora.rtc2.internal.DeviceUtils;
import io.agora.rtc2.internal.EncryptionConfig;
import io.agora.rtc2.internal.LastmileProbeConfig;
import io.agora.rtc2.internal.RtcEngineImpl;
import io.agora.rtc2.live.LiveInjectStreamConfig;
import io.agora.rtc2.live.LiveTranscoding;
import io.agora.rtc2.video.AgoraImage;
import io.agora.rtc2.video.AgoraVideoFrame;
import io.agora.rtc2.video.BeautyOptions;
import io.agora.rtc2.video.CameraCapturerConfiguration;
import io.agora.rtc2.video.ChannelMediaRelayConfiguration;
import io.agora.rtc2.video.ContentInspectConfig;
import io.agora.rtc2.video.EncodedVideoFrameInfo;
import io.agora.rtc2.video.IVideoEncodedImageReceiver;
import io.agora.rtc2.video.IVideoFrameObserver;
import io.agora.rtc2.video.ScreenCaptureParameters;
import io.agora.rtc2.video.VideoCanvas;
import io.agora.rtc2.video.VideoCompositingLayout;
import io.agora.rtc2.video.VideoEncoderConfiguration;
import io.agora.rtc2.video.VirtualBackgroundSource;
import io.agora.rtc2.video.WatermarkOptions;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

/**
 * Main interface class of the Agora Native SDK.
 *
 * Call the methods of this class to use all the functionalities of the SDK.
 * Agora recommends calling the {@link RtcEngine} API methods in the same thread instead
 * of in multiple threads. In previous versions, this class was named
 * AgoraAudio, and was renamed to {@link RtcEngine} from version 1.0.
 *
 */
public abstract class RtcEngine {
  protected static RtcEngineImpl mInstance = null;

  /**
   * Creates an {@link RtcEngine} instance.
   *
   * Unless otherwise specified, all the methods provided by the {@link RtcEngine} class are
   * executed asynchronously. Agora recommends calling these methods in the same thread.
   *
   * @note
   * - You must create an {@link RtcEngine} instance before calling any other method.
   * - You can create an {@link RtcEngine} instance either by calling this method or by
   * calling {@link RtcEngine#create(RtcEngineConfig config) create2}. The difference
   * between {@link RtcEngine#create(RtcEngineConfig config) create2} and this method is
   * that {@link RtcEngine#create(RtcEngineConfig config) create2} enables you to specify the
   * connection area.
   * - The Agora RTC Native SDK supports creating only one {@link RtcEngine} instance for an app for
   * now.
   *
   * @param context The context of Android Activity.
   * @param appId The App ID issued to you by Agora.
   * See [How to get the App ID](https://docs.agora.io/en/Agora%20Platform/token#get-an-app-id).
   * Only users in apps with the same App ID can join the same channel and communicate with each
   * other. Use an App ID to create only one {@link RtcEngine} instance. To change your App ID, call
   * destroy to {@link RtcEngine#destroy() destroy} the current {@link RtcEngine} instance and then
   * call `create` to create an {@link RtcEngine} instance with the new App ID.
   * @param handler {@link io.agora.rtc2.IRtcEngineEventHandler IRtcEngineEventHandler} is an
   * abstract class providing default implementation. The SDK uses this class to report to the app
   * on SDK runtime events.
   * @return
   * - The {@link RtcEngine} instance, if the method call succeeds.
   * - < 0, if the method call fails.
   * @throws Exception Fails to create an {@link RtcEngine} instance.
   */
  public static synchronized RtcEngine create(
      Context context, String appId, IRtcEngineEventHandler handler) throws Exception {
    if (context == null || !RtcEngineImpl.initializeNativeLibs())
      return null;

    RtcEngineConfig config = new RtcEngineConfig();
    config.mContext = context;
    config.mAppId = appId;
    config.mEventHandler = handler;

    if (mInstance == null) {
      mInstance = new RtcEngineImpl(config);
    } else {
      mInstance.reinitialize(config);
    }
    return mInstance;
  }

  /**
   * Creates an RtcEngine instance.
   *
   * The Agora Native SDK only supports one RtcEngine instance at a time,
   * therefore the app should create one RtcEngine object only. Unless otherwise
   * specified:
   * - All called methods provided by the RtcEngine class are executed asynchronously.
   * We recommends calling these methods in the same thread.
   * - The following rule applies to all APIs whose return values are integer types:
   *   - 0: The method call succeeds.
   *   - < 0: The method call fails.
   *
   * @note
   * - Ensure that you call this method before calling any other API.
   * - Only users with the same App ID can join the same channel and call each other.
   * - An App ID can create only one RtcEngine object. For multiple App IDs in an app, you
   * need to create multiple RtcEngine objects. Call {@link RtcEngine#destroy destroy}
   * first to destroy the current RtcEngine instance before calling this method.
   *
   * @param config Configurations for the RtcEngine instance. For details, see {@link
   *     RtcEngineConfig}.
   * @return An RtcEngine object.
   * @throws Exception Fails to create an RtcEngine instance.
   */
  public static synchronized RtcEngine create(RtcEngineConfig config) throws Exception {
    if (config == null || config.mContext == null
        || !RtcEngineImpl.initializeNativeLibs(config.mNativeLibPath))
      return null;
    if (mInstance == null) {
      mInstance = new RtcEngineImpl(config);
    } else {
      mInstance.reinitialize(config);
    }
    return mInstance;
  }

  public static synchronized boolean loadExtension(String name) {
    return RtcEngineImpl.loadExtension(name);
  }

  /**
   * Releases all the resources used by the Agora SDK.
   *
   * This method is useful for apps that occasionally make voice or video calls, to free up
   * resources for other operations when not making calls.
   *
   * @note
   * - Do not immediately uninstall the SDK's dynamic library after the call,
   * or it may crash because the SDK clean-up thread has not quit.
   * - Call this method in the sub-thread.
   * - Once the app destroys the created {@link RtcEngine} instance, you cannot use any method or
   * callback in the SDK.
   *
   */
  public static synchronized void destroy() {
    if (mInstance == null)
      return;
    mInstance.doDestroy();
    mInstance = null;
    System.gc();
  }

  /**
   * Sets the channel profile.
   *
   * The {@link RtcEngine} differentiates channel profiles and applies different optimization
   * algorithms accordingly. For example, it prioritizes smoothness and low latency for a video
   * call, and prioritizes video quality for a video broadcast.
   *
   * @note
   * - To ensure the quality of real-time communication, we recommend that all users in a channel
   * use the same channel profile.
   * - Call this method before calling `joinChannel`. You cannot set the channel
   * profile once you have joined the channel.
   *
   * @param profile The channel profile:
   * - `CHANNEL_PROFILE_COMMUNICATION`(0): (Default) Communication.
   * Use this profile when there are two users in the channel.
   * - `CHANNEL_PROFILE_LIVE_BROADCASTING`(1): Live Broadcast.
   * Use this profile when there are more than two users in the channel.
   * - `CHANNEL_PROFILE_GAME`(2): Gaming. This profile is deprecated.
   * - `CHANNEL_PROFILE_CLOUD_GAMING`(3): Cloud gaming.
   * This profile is for interactive streaming scenario which is highly sensitive to end-to-end
   * latency, and any delay in render impacts the end-user experience.
   * These use cases prioritize reducing delay over any smoothing done at the receiver.
   * We recommend using this profile in scenarios there users need to interact with each other.
   * - `CHANNEL_PROFILE_COMMUNICATION_1v1`(4): Communication 1v1.
   * Use this profile when needs communication 1v1.
   * - `CHANNEL_PROFILE_LIVE_BROADCASTING_2`(5): Live Broadcast 2.
   * Use this profile for technical preview.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setChannelProfile(int profile);

  /**
   * Sets the role of a user.
   *
   * This method sets the user role as either BROADCASTER or AUDIENCE (default).
   * - The broadcaster sends and receives streams.
   * - The audience receives streams only.
   *
   * By default, all users are audience regardless of the channel profile.
   * Call this method to change the user role to BROADCASTER so that the user can
   * send a stream.
   *
   * @note
   * After calling the setClientRole() method to CLIENT_ROLE_AUDIENCE, the SDK stops audio
   * recording. However, CLIENT_ROLE_AUDIENCE will keep audio recording with
   * AUDIO_SCENARIO_CHATROOM(5). Normally, app developer can also use mute api to achieve the same
   * result, and we implement this 'non-orthogonal' behavior only to make API backward compatible.
   *
   * @param role The role of the client:
   * - `CLIENT_ROLE_BROADCASTER`(1): The broadcaster.
   * - `CLIENT_ROLE_AUDIENCE(2)`: The audience.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setClientRole(int role);

  /**
   * Sets the role of a user (`LIVE_BROADCASTING` profile only).
   *
   * This method sets the role of a user, such as a host or an audience (default), before joining a
   * channel.
   *
   * This method can be used to switch the user role after a user joins a channel.
   * In the `LIVE_BROADCASTING` profile, when a user switches user roles after joining a channel, a
   * successful setClientRole method call triggers the following callbacks:
   * - The local client: {@link IRtcEngineEventHandler#onClientRoleChanged onClientRoleChanged}.
   * - The remote client: {@link IRtcEngineEventHandler#onUserJoined onUserJoined} or {@link
   * IRtcEngineEventHandler#onUserOffline onUserOffline}(USER_OFFLINE_BECOME_AUDIENCE).
   *
   * @param role Sets the role of a user:
   * - `CLIENT_ROLE_BROADCASTER`(1): Host. A host can both send and receive streams.
   * - `CLIENT_ROLE_AUDIENCE`(2): Audience, the default role. An audience can only receive streams.
   *
   * @param options Client role options of a user, see #ClientRoleOptions.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *   - -1(ERR_FAILED): A general error occurs (no specified reason).
   *   - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *   - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  public abstract int setClientRole(int role, ClientRoleOptions options);

  /**
   * Agora supports reporting and analyzing customized messages.
   *
   * This function is in the beta stage with a free trial. The ability provided
   * in its beta test version is reporting a maximum of 10 message pieces within
   * 6 seconds, with each message piece not exceeding 256 bytes.
   *
   * To try out this function, contact [support@agora.io](mailto:support@agora.io)
   * and discuss the format of customized messages with us.
   */
  public abstract int sendCustomReportMessage(
      String id, String category, String event, String label, int value);

  /**
   * Joins a channel.
   *
   * Users in the same channel can talk to each other; and multiple users in the same
   * channel can start a group chat. Note that users using different App IDs cannot call each
   * other.
   *
   * Once in a call, the user must call the {@link leaveChannel leaveChannel} method to exit the
   * current call before entering another channel.
   *
   * @note
   * - This method allows you to join only one channel at a time.
   * - A channel does not accept duplicate `uid`s, that is, two users with the same uid. If you set
   * `uid` as 0, the system automatically assigns a user ID.
   * - Ensure that the app ID you use to generate the token is the same app ID that you pass in the
   * {@link create create} method.
   *
   * @param token The token for authentication.
   * - In situations not requiring high security: You can use the temporary token generated at
   * Console. For details, see [Get a temporary
   * token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token).
   * - In situations requiring high security: Set it as the token generated at you server. For
   * details, see [Generate a
   * token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-token).
   *
   * @param channelName The unique channel name for the AgoraRTC session in the string format. The
   *     string
   * length must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param optionalInfo (Optional) Additional information about the channel that you want
   * to add. It can be set as a NULL string or channel related information.
   * Other users in the channel will not receive this message.
   * @param optionalUid (Optional) User ID: A 32-bit unsigned integer ranging from 1 to
   * (2^32-1). It must be unique. If not assigned (or set to 0), the SDK assigns one
   * and reports it in the {@link IRtcEngine::onJoinChannelSuccess onJoinChannelSuccess} callback.
   * Your app must record and maintain the returned value as the SDK does not maintain it.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int joinChannel(
      String token, String channelName, String optionalInfo, int optionalUid);

  /**
   * Joins a channel with media options.
   *
   * Users in the same channel can talk to each other; and multiple users in the same
   * channel can start a group chat. Note that users using different App IDs cannot call each
   * other.
   *
   * Once in a call, the user must call the {@link leaveChannel leaveChannel} method to exit the
   * current call before entering another channel.
   *
   * @note
   * - This method allows you to join only one channel at a time.
   * - A channel does not accept duplicate `uid`s, that is, two users with the same uid. If you set
   * `uid` as 0, the system automatically assigns a user ID.
   * - Ensure that the app ID you use to generate the token is the same app ID that you pass in the
   * {@link create create} method.
   *
   * @param token The token for authentication.
   * - In situations not requiring high security: You can use the temporary token generated at
   * Console. For details, see [Get a temporary
   * token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token).
   * - In situations requiring high security: Set it as the token generated at you server. For
   * details, see [Generate a
   * token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-token).
   *
   * @param channelId The unique channel name for the AgoraRTC session in the string format. The
   *     string
   * length must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param uid (Optional) User ID: A 32-bit unsigned integer ranging from 1 to
   * (2^32-1). It must be unique. If not assigned (or set to 0), the SDK assigns one
   * and reports it in the {@link IRtcEngineEventHandler#onJoinChannelSuccess onJoinChannelSuccess}
   * callback. Your app must record and maintain the returned value as the SDK does not maintain it.
   * @param options The channel media options: {@link ChannelMediaOptions ChannelMediaOptions}.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int joinChannel(
      String token, String channelId, int uid, ChannelMediaOptions options);

  /**
   * Leaves the channel.
   *
   * This method allows a user to leave the channel, for example, by hanging up or exiting a call.
   *
   * After joining a channel, the user must call this method to end the current call before joining
   * another one. This method also releases all resources related to the call.
   *
   * This method is an asynchronous call, which means that the result of this method returns even
   * before the user has not actually left the channel. Once the user successfully leaves the
   * channel, the SDK triggers the {@link IRtcEngineEventHandler onLeaveChannel} callback.
   *
   * @note
   * If you call {@link destroy destroy} immediately after this method, the leaveChannel process
   * will be interrupted, and the SDK will not trigger the `onLeaveChannel` callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int leaveChannel();

  /**
   * Leaves the channel.
   *
   * @param options The leave channel options.
   *
   * This method allows a user to leave the channel, for example, by hanging up or exiting a call.
   *
   * This method is an asynchronous call, which means that the result of this method returns even
   * before the user has not actually left the channel. Once the user successfully leaves the
   * channel, the SDK triggers the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel"
   * callback.
   *
   * @note
   * If you call \ref release "release" immediately after this method, the leaveChannel process will
   * be interrupted, and the SDK will not trigger the `onLeaveChannel` callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int leaveChannel(LeaveChannelOptions options);

  /**
   * Renews the token.
   *
   * Once a token is enabled and used, it expires after a certain period of time.
   *
   * Under the following circumstances, generate a new token on your server, and then call this
   * method to renew it. Failure to do so results in the SDK disconnecting from the server.
   * - The {@link IRtcEngineEventHandler#onTokenPrivilegeWillExpire onTokenPrivilegeWillExpire}
   * callback is triggered;
   * - The {@link IRtcEngineEventHandler#onRequestToken onRequestToken} callback is triggered;
   * - The `ERR_TOKEN_EXPIRED(-109)` error is reported.
   *
   * @param token The new token.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int renewToken(String token);

  /**
   * Registers a user account.
   *
   * Once registered, the user account can be used to identify the local user when the user joins
   * the channel. After the user successfully registers a user account, the SDK triggers the \ref
   * agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" callback on
   * the local client, reporting the user ID and user account of the local user.
   *
   * To join a channel with a user account, you can choose either of the following:
   *
   * - Call the \ref agora::rtc::IRtcEngine::registerLocalUserAccount "registerLocalUserAccount"
   * method to create a user account, and then the \ref
   * agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method to join
   * the channel.
   * - Call the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount"
   * method to join the channel.
   *
   * The difference between the two is that for the former, the time elapsed between calling the
   * \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method and
   * joining the channel is shorter than the latter.
   *
   * @note
   * - Ensure that you set the `userAccount` parameter. Otherwise, this method does not take effect.
   * - Ensure that the value of the `userAccount` parameter is unique in the channel.
   * - To ensure smooth communication, use the same parameter type to identify the user. For
   * example, if a user joins the channel with a user ID, then ensure all the other users use the
   * user ID too. The same applies to the user account. If a user joins the channel with the Agora
   * Web SDK, ensure that the uid of the user is set to the same parameter type.
   *
   * @param appId The App ID of your project.
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure
   *     that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int registerLocalUserAccount(String appId, String userAccount);

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
   * @param channelName The channel name. The maximum length of this parameter is 64 bytes.
   *     Supported
   * character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure
   * that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options  The channel media options: \ref
   * agora::rtc::ChannelMediaOptions::ChannelMediaOptions "ChannelMediaOptions"
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - #ERR_INVALID_ARGUMENT (-2)
   *  - #ERR_NOT_READY (-3)
   *  - #ERR_REFUSED (-5)
   */
  public abstract int joinChannelWithUserAccount(
      String token, String channelName, String userAccount);

  /**
   * Joins the channel with a user account, and configures whether to automatically subscribe to
   * audio or video streams after joining the channel.
   * @since v3.3.0.
   *
   * After the user successfully joins the channel, the SDK triggers the following callbacks:
   * - The local client: {@link IRtcEngineEventHandler#onLocalUserRegistered onLocalUserRegistered}
   * and {@link IRtcEngineEventHandler#onJoinChannelSuccess onJoinChannelSuccess}.
   * - The remote client: {@link IRtcEngineEventHandler#onUserJoined onUserJoined} and {@link
   * IRtcEngineEventHandler#onUserInfoUpdated onUserInfoUpdated}, if the user joining the channel is
   * in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * @note
   * - Compared with {@link RtcEngine#joinChannelWithUserAccount(String token, String channelName,
   * String userAccount) joinChannelWithUserAccount}[1/2], this method has the `options` parameter
   * to configure whether the end user automatically subscribes to all remote audio and video
   * streams in a channel when joining the channel. By default, the user subscribes to the audio and
   * video streams of all the other users in the channel, thus incurring all associated usage costs.
   * To unsubscribe, set the `options` parameter or call the `mute` methods accordingly.
   * - To ensure smooth communication, use the same parameter type to identify the user. For
   * example, if a user joins the channel with a user ID, then ensure all the other users use the
   * user ID too. The same applies to the user account. If a user joins the channel with the Agora
   * Web SDK, ensure that the uid of the user is set to the same parameter type.
   *
   * @param token The token generated at your server. For details, see [Generate a
   *     token](https://docs.agora.io/en/Interactive Broadcast/token_server?platform=Android).
   * @param channelName The channel name. The maximum length of this parameter is 64 bytes.
   *     Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure
   *     that you set this parameter and do not set it as null.
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options The channel media options: {@link io.agora.rtc.models.ChannelMediaOptions
   *     ChannelMediaOptions}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - {@link io.agora.rtc.Constants#ERR_INVALID_ARGUMENT ERR_INVALID_ARGUMENT(-2)}
   *   - {@link io.agora.rtc.Constants#ERR_NOT_READY ERR_NOT_READY(-3)}
   *   - {@link io.agora.rtc.Constants#ERR_REFUSED ERR_REFUSED(-5)}
   */
  public abstract int joinChannelWithUserAccount(
      String token, String channelName, String userAccount, ChannelMediaOptions options);

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
   *
   * @return userInfo  A userInfo object that identifies the user
   * - not null: Success.
   * - null: Failure.
   */
  public abstract UserInfo getUserInfoByUserAccount(String userAccount);

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
   * @return userInfo A userInfo object that identifies the user
   * - not null: Success.
   * - null: Failure.
   */
  public abstract UserInfo getUserInfoByUid(int uid);

  /**
   * Gets the the Audio device Info
   * @return deviceInfo
   * - not null: Success.
   * - null: Failure.
   */
  public abstract DeviceInfo getAudioDeviceInfo();

  /**
   * Enables interoperability with the Agora Web SDK (Live Broadcast only).
   *
   * Use this method when the channel profile is Live Broadcast. Interoperability
   * with the Agora Web SDK is enabled by default when the channel profile is
   * Communication.
   *
   * @param enabled Determines whether to enable interoperability with the Agora Web SDK.
   * - true: Enable interoperability with the Agora Native SDK.
   * - false: Disable interoperability with the Agora Native SDK.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableWebSdkInteroperability(boolean enabled);

  /**
   * Gets the connection state of the SDK.
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
   *
   */
  public abstract RtcConnection.CONNECTION_STATE_TYPE getConnectionState();

  /**
   * Enables the audio.
   *
   * The audio is enabled by default.
   *
   * @note
   * This method controls the underlying states of the Engine. It is still
   * valid after one leaves channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableAudio();

  /**
   * Disables the audio.
   *
   * @note
   * This method controls the underlying states of the Engine. It is still
   * valid after one leaves channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int disableAudio();

  /**
   * Disables the audio function in the channel.
   * <p>
   * Note: This method controls the underlying states of the Engine. It is still
   * valid after one leaves channel.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int pauseAudio();

  /**
   * Enables the audio function in the channel.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int resumeAudio();

  /**
   * Sets the audio profile.
   *
   * @note
   * - Call this method before calling `joinChannel` method.
   * - In scenarios requiring high-quality audio, Agora recommends setting `profile` as
   * `MUSIC_HIGH_QUALITY`(4).
   * - To set the audio scenario, call {@link RtcEngine#create(RtcEngineConfig config) create2} and
   * pass value in the `mAudioScenario` member.
   *
   * @param profile Sets the sample rate, bitrate, encoding mode, and the number of channels. See
   * {@link Constants#AudioProfile AudioProfile}.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setAudioProfile(int profile);

  /**
   * Sets the audio parameters and application scenarios.
   *
   * @note
   * - Call this method before calling `joinChannel`.
   * - In scenarios requiring high-quality audio, we recommend setting `profile` as
   * `MUSIC_HIGH_QUALITY`(4) and `scenario` as `AUDIO_SCENARIO_GAME_STREAMING`(3).
   *
   * @param profile Sets the sample rate, bitrate, encoding mode, and the number of channels. See
   * {@link Constants#AudioProfile AudioProfile}.
   * @param scenario Sets the audio application scenarios. See {@link Constants#AudioScenario
   * AudioScenario}.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setAudioProfile(int profile, int scenario);

  /**
   * <p>
   * Sets high-quality audio preferences.
   *
   * <p>
   * Call this method and set all the modes before joining a channel. Do NOT call
   * this method again after joining a channel.
   *
   * <p>
   * Note: Agora does not recommend using this method. If you want to set the
   * audio profile, see {@link setAudioProfile(int profile, int scenario)
   * setAudioProfile}.
   *
   * @param fullband    Full-band codec (48 kHz sampling rate), not compatible
   *                    with versions before v1.7.4.
   *                    <ul>
   *                    <li>True: Enable full-band codec.
   *                    <li>False: Disable full-band codec.
   *                    </ul>
   * @param stereo      Stereo codec, not compatible with versions before v1.7.4.
   *                    <ul>
   *                    <li>True: Enable stereo codec.
   *                    <li>False: Disable stereo codec.
   *                    </ul>
   * @param fullBitrate High bitrate. Recommended in voice-only mode.
   *                    <ul>
   *                    <li>True: Enable high bitrate mode.
   *                    <li>False: Disable high bitrate mode.
   *                    </ul>
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   *
   */
  public abstract int setHighQualityAudioParameters(
      boolean fullband, boolean stereo, boolean fullBitrate);

  /**
   * Adjusts the recording volume.
   *
   * @param volume Recording volume, ranges from 0 to 400:
   *               <ul>
   *               <li>0: Mute
   *               <li>100: Original volume
   *               <li>400: (Maximum) Four times the original volume with signal
   *               clipping protection
   *               </ul>
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int adjustRecordingSignalVolume(int volume);

  /**
   * Adjusts the playback volume.
   *
   * @param volume Playback volume, ranges from 0 to 400:
   *               <ul>
   *               <li>0: Mute
   *               <li>100: Original volume
   *               <li>400: (Maximum) Four times the original volume with signal
   *               clipping protection
   *               </ul>
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int adjustPlaybackSignalVolume(int volume);

  /**
   * Enables the `onAudioVolumeIndication` callback to report on which users are speaking
   * and the speakers' volume.
   *
   * Once the {@link IRtcEngineEventHandler#onAudioVolumeIndication onAudioVolumeIndication}
   * callback is enabled, the SDK returns the volume indication in the at the time interval set
   * in `enableAudioVolumeIndication`, regardless of whether any user is speaking in the channel.
   *
   * @param interval Sets the time interval between two consecutive volume indications:
   * - <= 0: Disables the volume indication.
   * - > 0: Time interval (ms) between two consecutive volume indications,
   * and should be integral multiple of 200 (less than 200 will be set to 200).
   * @param smooth The smoothing factor that sets the sensitivity of the audio volume
   * indicator. The value ranges is [0, 10]. The greater the value, the more sensitive the
   * indicator. The recommended value is 3.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableAudioVolumeIndication(int interval, int smooth, boolean reportVad);

  /**
   * <p>
   * Enables the audio quality notification callbacks.
   * @deprecated From v2.4.1.
   *
   * <p>
   * The {@link IRtcEngineEventHandler#onAudioQuality(int, int, short, short)
   * onAudioQuality} callback triggers periodically after this callback is
   * enabled.
   *
   * @param enabled Whether to enable the audio quality notification callbacks.
   *                True/False.
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  @Deprecated public abstract int enableAudioQualityIndication(boolean enabled);

  /**
   * Enables or disables the local audio capture.
   *
   * The audio function is enabled by default. This method disables or re-enables the
   * local audio function, that is, to stop or restart local audio capture and
   * processing.
   *
   * This method does not affect receiving or playing the remote audio streams,
   * and `enableLocalAudio` (false) is applicable to scenarios where the user
   * wants to receive remote audio streams without sending any audio stream to other users
   * in the channel.
   *
   * @param enabled Determines whether to disable or re-enable the local audio function:
   * - true: (Default) Re-enable the local audio function, that is, to start local
   * audio capture and processing.
   * - false: Disable the local audio function, that is, to stop local audio
   * capture and processing.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableLocalAudio(boolean enabled);

  /**
   * Stops or resumes sending the local audio stream.
   *
   * @param mute Determines whether to send or stop sending the local audio stream:
   * - true: Stop sending the local audio stream.
   * - false: (Default) Send the local audio stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteLocalAudioStream(boolean muted);

  /**
   * Stops or resumes receiving the audio stream of a specified user.
   *
   * You can call this method before or after joining a channel. If a user leaves a channel, the
   * settings in this method become invalid.
   *
   * @param uid The ID of the specified user.
   * @param mute Whether to stop receiving the audio stream of the specified user:
   * - true: Stop receiving the specified audio stream.
   * - false: (Default) Receive the specified audio stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteRemoteAudioStream(int uid, boolean muted);

  /**
   * Adjust the playback volume of the user specified by uid.
   *
   * You can call this method to adjust the playback volume of the user specified by uid
   * in call. If you want to adjust playback volume of the multi user, you can call this
   * this method multi times.
   *
   * @note
   * Please call this method after join channel.
   * This method adjust the playback volume of specified user.
   *
   * @param uid Remote user ID.
   * @param volume The playback volume, range is [0,100]:
   * 0: mute, 100: The original volume
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int adjustUserPlaybackSignalVolume(int uid, int volume);

  /**
   * Stops or resumes receiving all remote audio streams.
   *
   * This method works for all remote users that join or will join a channel using the `joinChannel`
   * method. It is equivalent to the `autoSubscribeAudio` member in the ChannelMediaOptions class.
   * You can call this method before, during, or after a call.
   * - If you call `muteAllRemoteAudioStreams(true)` before joining a channel, the local user does
   * not receive any audio stream after joining the channel.
   * - If you call `muteAllRemoteAudioStreams(true)` after joining a channel, the local use stops
   * receiving any audio stream from any user in the channel, including any user who joins the
   * channel after you call this method.
   * - If you call `muteAllRemoteAudioStreams(true)` after leaving a channel, the local user does
   * not receive any audio stream the next time the user joins a channel.
   *
   * After you successfully call `muteAllRemoteAudioStreams(true)`, you can take the following
   * actions:
   * - To resume receiving all remote audio streams, call `muteAllRemoteAudioStreams(false)`.
   * - To resume receiving the audio stream of a specified user, call `muteRemoteAudioStream(uid,
   * false)`, where `uid` is the ID of the user whose audio stream you want to resume receiving.
   *
   * @note
   * - The result of calling this method is affected by calling `enableAudio` and `disableAudio`.
   * Settings in `muteAllRemoteAudioStreams` stop taking effect if either of the following occurs:
   *   - Calling `enableAudio` after `muteAllRemoteAudioStreams(true)`.
   *   - Calling `disableAudio` after `muteAllRemoteAudioStreams(false)`.
   * - This method only works for the channel created by calling `joinChannel`. To set whether to
   * receive remote audio streams for a specific channel, Agora recommends using
   * `autoSubscribeAudio` in the `ChannelMediaOptions` class.
   *
   * @param muted Whether to stop receiving remote audio streams:
   * - true: Stop receiving any remote audio stream.
   * - false: (Default) Resume receiving all remote audio streams.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteAllRemoteAudioStreams(boolean muted);

  /**
   * Determines whether to receive all remote audio streams by default.
   *
   * @deprecated This method is deprecated. To set whether to receive remote audio streams by
   *     default, call {@link muteAllRemoteAudioStreams
   * muteAllRemoteAudioStreams} before calling `joinChannel`.
   *
   * Use `setDefaultMuteAllRemoteAudioStreams` to set whether to receive audio streams of subsequent
   * peer users. Agora recommends calling it before joining a channel.
   *
   * A successful call of `setDefaultMuteAllRemoteAudioStreams(true)` results in that the local user
   * not receiving any audio stream after joining a channel.
   *
   * @param muted Whether to receive remote audio streams by default:
   * - true: Do not receive any remote audio stream by default.
   * - false: (Default)) Receive remote audio streams by default.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setDefaultMuteAllRemoteAudioStreams(boolean muted);

  /**
   * Enables the video.
   *
   * You can call this method either before joining a channel or during a call.
   * If you call this method before entering a channel, the service starts the video; if you call it
   * during a call, the audio call switches to a video call.
   *
   * @note
   * This method controls the underlying states of the Engine. It is still
   * valid after one leaves the channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableVideo();

  /**
   * Disables the video.
   *
   * This method stops capturing the local video and receiving any remote video.
   * To enable the local preview function, call {@link enableLocalVideo enableLocalVideo} (true).
   * @return
   *
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int disableVideo();

  /**
   * <p>
   * Sets the video encoding profile.
   *
   * <p>
   * Each profile includes a set of parameters, such as the resolution, frame
   * rate, and bitrate. When the camera does not support the specified resolution,
   * the SDK chooses a suitable camera resolution, while the encoder resolution is
   * the one specified by
   * {@link RtcEngine#setVideoProfile(int profile, boolean swapWidthAndHeight)
   * setVideoProfile}.
   *
   * <p>
   * Note:
   * <ul>
   * <li>Always set the video profile after calling the
   * {@link RtcEngine#enableVideo() enableVideo} method.
   * <li>Always set the video profile before calling the
   * {@link RtcEngine#joinChannel(java.lang.String token, java.lang.String channelName,
   * java.lang.String optionalInfo, int optionalUid) joinChannel} or {@link RtcEngine#startPreview()
   * startPreview} method.
   * </ul>
   *
   * @param profile            {@link IRtcEngineEventHandler.VideoProfile
   *                           VideoProfile}.
   * @param swapWidthAndHeight The width and height of the output video is
   *                           consistent with that of the video profile you set.
   *                           This parameter sets whether to swap the width and
   *                           height of the stream:
   *                           <ul>
   *                           <li>True: Swap the width and height. After that the
   *                           video will be in the portrait mode, that is, width
   *                           < height.
   *                           <li>False: (Default) Do not swap the width and
   *                           height, and the video remains in the landscape
   *                           mode, that is, width > height.
   *                           </ul>
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int setVideoProfile(int profile, boolean swapWidthAndHeight);

  /**
   * Sets the video encoder configuration.
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
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /**
   * Sets the camera capturer configuration.
   * @param config The camera capturer configuration. For details, see {@link
   * io.agora.rtc2.video.CameraCapturerConfiguration CameraCapturerConfiguration}.
   * @note Call this method before enabling the local camera. That said, you can call this method
   * before calling  {@link RtcEngine#joinChannel joinChannel}, {@link RtcEngine#enableVideo
   * enableVideo}, or {@link RtcEngine#enableLocalVideo enableLocalVideo}, depending on which
   * method you use to turn on your local camera.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setCameraCapturerConfiguration(CameraCapturerConfiguration config);

  /**
   * Initializes the local video view.
   *
   * This method initializes the video view of the local stream on the local device. It affects only
   * the video view that the local user sees, not the published local video stream.
   *
   * To unbind the local video from the view, set `view` in VideoCanvas as `null`.
   *
   * @note
   * Call this method before joining a channel.
   *
   * @param local The local video view setting: VideoCanvas.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setupLocalVideo(VideoCanvas local);

  /**
   * Initializes the video view of a remote user.
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
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setupRemoteVideo(VideoCanvas remote);

  /**
   * Updates the display mode of the local video view.
   *
   * After initializing the local video view, you can call this method to  update its rendering
   * mode. It affects only the video view that the local user sees, not the published local video
   * stream.
   *
   * @note
   * - Ensure that you have called {@link setupLocalVideo setupLocalVideo} to initialize the local
   * video view before this method.
   * - During a call, you can call this method as many times as necessary to update the local video
   * view.
   *
   * @param renderMode Sets the local display mode:
   * - `RENDER_MODE_HIDDEN`(1): Uniformly scale the video until it fills the visible boundaries
   * (cropped). One dimension of the video may have clipped contents.
   * - `RENDER_MODE_FIT`(2): Uniformly scale the video until one of its dimension fits the boundary
   * (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be
   * filled with black.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  @Deprecated public abstract int setLocalRenderMode(int renderMode);

  /**
   * Updates the display mode of the local video view.
   *
   * After initializing the local video view, you can call this method to  update its rendering
   * mode. It affects only the video view that the local user sees, not the published local video
   * stream.
   *
   * @note
   * - Ensure that you have called {@link setupLocalVideo setupLocalVideo} to initialize the local
   * video view before this method.
   * - During a call, you can call this method as many times as necessary to update the local video
   * view.
   *
   * @param renderMode Sets the local display mode:
   * - `RENDER_MODE_HIDDEN`(1): Uniformly scale the video until it fills the visible boundaries
   * (cropped). One dimension of the video may have clipped contents.
   * - `RENDER_MODE_FIT`(2): Uniformly scale the video until one of its dimension fits the boundary
   * (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be
   * filled with black.
   *
   * @param mirrorMode Sets the local video mirror mode:
   * - `VIDEO_MIRROR_MODE_AUTO(0)`: (Default) The mirror mode determined by the SDK.
   * If you use the front camera, the SDK enables the mirror mode;
   * if you use the rear camera, the SDK disables the mirror mode.
   * - `VIDEO_MIRROR_MODE_ENABLED(1)`: Enable the mirror mode.
   * - `VIDEO_MIRROR_MODE_DISABLED(2)`: Disable the mirror mode.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setLocalRenderMode(int renderMode, int mirrorMode);

  /**
   * Updates the display mode of the video view of a remote user.
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
   * - `RENDER_MODE_HIDDEN`(1): Uniformly scale the video until it fills the visible boundaries
   * (cropped). One dimension of the video may have clipped contents.
   * - `RENDER_MODE_FIT`(2): Uniformly scale the video until one of its dimension fits the boundary
   * (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be
   * filled with black.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  @Deprecated public abstract int setRemoteRenderMode(int userId, int renderMode);

  /**
   * Updates the display mode of the video view of a remote user.
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
   * - `RENDER_MODE_HIDDEN`(1): Uniformly scale the video until it fills the visible boundaries
   * (cropped). One dimension of the video may have clipped contents.
   * - `RENDER_MODE_FIT`(2): Uniformly scale the video until one of its dimension fits the boundary
   * (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be
   * filled with black.
   * @param mirrorMode Sets the remote video mirror mode:
   * - `VIDEO_MIRROR_MODE_ENABLED(1)`: Enable the mirror mode.
   * - `VIDEO_MIRROR_MODE_DISABLED(2)`: Disable the mirror mode.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteRenderMode(int userId, int renderMode, int mirrorMode);

  /**
   * <p>
   * Creates a video renderer view.
   * @deprecated This method is deprecated. You can use SurfaceView or TextureView created by
   *     Android system.
   * <p>
   * It returns the {@link android.view.SurfaceView SurfaceView} type. The
   * operation and layout of the view are managed by the application, and the
   * Agora SDK renders the view provided by the application. The view to display
   * videos must be created using this method instead of directly calling
   * {@link android.view.SurfaceView SurfaceView}.
   *
   * @return {@link android.view.SurfaceView SurfaceView}
   */
  @Deprecated
  public static SurfaceView CreateRendererView(Context context) {
    return new SurfaceView(context);
  }

  /**
   * <p>
   * Creates a TextureView.
   * @deprecated This method is deprecated. You can use SurfaceView or TextureView created by
   *     Android system.
   * <p>
   * It returns the {@link android.view.TextureView TextureView} type. The
   * operation and layout of the view are managed by the application, and the
   * Agora SDK renders the view provided by the application. The view to display
   * videos must be created using this method instead of directly calling
   * {@link android.view.TextureView TextureView}.
   *
   * @return {@link android.view.TextureView TextureView}
   */
  @Deprecated
  public static TextureView CreateTextureView(Context context) {
    return new TextureView(context);
  }

  /**
   * Starts the local video preview before joining a channel.
   *
   * Once you call this method to start the local video preview, if you leave
   * the channel by calling {@link leaveChannel leaveChannel}, the local video preview remains until
   * you call {@link stopPreview stopPreview} to disable it.
   *
   * @return
   * <ul>
   *     <li>0: Success.
   *     <li><0: Failure.
   *         <ul>
   *             <li>{@link io.agora.rtc2.Constants#ERR_NOT_INITIALIZED ERR_NOT_INITIALIZED(-7)}.
   *             <li>{@link io.agora.rtc2.Constants#ERR_INVALID_STATE ERR_INVALID_STATE(-8)}
   *         </ul>
   * </ul>
   */
  public abstract int startPreview();

  /**
   * Starts the local video preview before joining a channel.
   * @param sourceType - The video source type.
   */
  public abstract int startPreview(Constants.VideoSourceType sourceType);

  /**
   * Stops the local video preview and the video.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopPreview();

  /**
   * Stops the local video preview and the video.
   * @param sourceType - The video source type.
   */
  public abstract int stopPreview(Constants.VideoSourceType sourceType);

  /**
   * Disables or re-enables the local video capture.
   *
   * Once you enable the video using {@link enableVideo enableVideo}, the local video is enabled
   * by default. This method disables or re-enables the local video capture.
   *
   * `enableLocalVideo(false)` applies to scenarios when the user wants to watch the remote video
   * without sending any video stream to the other user.
   *
   * @note
   * Call this method after `enableVideo`. Otherwise, this method may not work properly.
   *
   * @param enabled Determines whether to disable or re-enable the local video, including
   * the capturer, renderer, and sender:
   * - true:  (Default) Re-enable the local video.
   * - false: Disable the local video. Once the local video is disabled, the remote
   * users can no longer receive the video stream of this user, while this user
   * can still receive the video streams of other remote users. When you set
   * `enabled` as `false`, this method does not require a local camera.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableLocalVideo(boolean enabled);

  /**
   * Start the secondary camera capture.
   * @param config - The config for secondary camera capture
   */
  public abstract int startSecondaryCameraCapture(CameraCapturerConfiguration config);

  /**
   * Stop the secondary camera capture.
   */
  public abstract int stopSecondaryCameraCapture();

  /**
   * Stops or resumes sending the local video stream.
   *
   * @param mute Determines whether to send or stop sending the local video stream:
   * - true: Stop sending the local video stream.
   * - false: (Default) Send the local video stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteLocalVideoStream(boolean muted);

  /**
   * Stops or resumes receiving the video stream of a specified user.
   *
   * You can call this method before or after joining a channel. If a user leaves a channel, the
   * settings in this method become invalid.
   *
   * @param userId The ID of the specified user.
   * @param mute Whether to stop receiving the video stream of the specified user:
   * - true: Stop receiving the video stream of the specified user.
   * - false: (Default) Resume receiving the video stream of the specified user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteRemoteVideoStream(int userId, boolean muted);

  /**
   * Stops or resumes receiving all remote video streams.
   *
   * This method works for all remote users that join or will join a channel using the `joinChannel`
   * method. It is equivalent to the `autoSubscribeVideo` member in the ChannelMediaOptions class.
   * You can call this method before, during, or after a call.
   * - If you call `muteAllRemoteVideoStreams(true)` before joining a channel, the local user does
   * not receive any video stream after joining the channel.
   * - If you call `muteAllRemoteVideoStreams(true)` after joining a channel, the local use stops
   * receiving any video stream from any user in the channel, including any user who joins the
   * channel after you call this method.
   * - If you call `muteAllRemoteVideoStreams(true)` after leaving a channel, the local user does
   * not receive any video stream the next time the user joins a channel.
   *
   * After you successfully call `muteAllRemoteVideoStreams(true)`, you can take the following
   * actions:
   * - To resume receiving all remote video streams, call `muteAllRemoteVideoStreams(false)`.
   * - To resume receiving the video stream of a specified user, call `muteRemoteVideoStream(uid,
   * false)`, where `uid` is the ID of the user whose video stream you want to resume receiving.
   *
   * @note
   * - The result of calling this method is affected by calling `enableVideo` and `disableVideo`.
   * Settings in `muteAllRemoteVideoStreams` stop taking effect if either of the following occurs:
   *   - Calling `enableVideo` after `muteAllRemoteVideoStreams(true)`.
   *   - Calling `disableVideo` after `muteAllRemoteVideoStreams(false)`.
   * - This method only works for the channel created by calling `joinChannel`. To set whether to
   * receive remote audio streams for a specific channel, Agora recommends using
   * `autoSubscribeVideo` in the ChannelMediaOptions class.
   *
   * @param muted Whether to stop receiving remote video streams:
   * - true: Stop receiving any remote video stream.
   * - false: (Default) RResume receiving all remote video streams.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteAllRemoteVideoStreams(boolean muted);

  /**
   * Determines whether to receive all remote video streams by default.
   *
   * @deprecated This method is deprecated. To set whether to receive remote video streams by
   *     default, call {@link muteAllRemoteVideoStreams
   * muteAllRemoteVideoStreams} before calling `joinChannel`.
   *
   * Use `setDefaultMuteAllRemoteVideoStreams` to set whether to receive video streams of subsequent
   * peer users. Agora recommends calling it before joining a channel.
   *
   * A successful call of `setDefaultMuteAllRemoteVideoStreams(true)` results in that the local user
   * not receiving any video stream after joining a channel.
   *
   * @param muted Whether to receive remote video streams by default:
   * - true: Do not receive any remote video stream by default.
   * - false: (Default) Receive remote video streams by default.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setDefaultMuteAllRemoteVideoStreams(boolean muted);

  /**
   * Enables/Disables image enhancement and sets the options.
   * @since v2.4.0.
   *
   * @note
   * - Call this method after calling {@link enableVideo enableVideo}.
   * - This method applies to Android 4.4 or later.
   *
   * @param enabled Whether to enable image enhancement:
   *                - `true`: Enables image enhancement.
   *                - `false`: Disables image enhancement.
   * @param options The image enhancement options. See {@link io.agora.rtc2.video.BeautyOptions
   *     BeautyOptions}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *    - ERR_NOT_SUPPORTED(4): The system version is earlier than Android 4.4, which does not
   * support this function.
   */
  public abstract int setBeautyEffectOptions(boolean enabled, BeautyOptions options);

  /**
   * Enables/Disables portrait segmentation and repalce the background(not portrait area) with
   * specified source.
   *
   * @note
   * - This method applies to Android 4.4 or later.
   *
   * @param enabled Sets whether or not to enable capture image background subtitution:
   *                - true: enables background subtitution.
   *                - false: disables background subtitution.
   * @param VirtualBackgroundSource Sets the background source data. See {@link
   *     io.agora.rtc.video.VirtualBackgroundSource VirtualBackgroundSource}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_IMAGE_NOT_EXIST = -1,
   *  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_COLOR_FORMAT_NOT_SUPPORTED = -2,
   *  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_DEVICE_NOT_SUPPORTED = -3,
   */
  public abstract int enableVirtualBackground(
      boolean enabled, VirtualBackgroundSource backgroundSource);

  /**
   * Sets the default audio route.
   *
   * Most mobile phones have two audio routes: an earpiece at the top, and a speakerphone at the
   * bottom. The earpiece plays at a lower volume, and the speakerphone at a higher volume.
   *
   * When setting the default audio route, you determine whether audio playback comes through the
   * earpiece or speakerphone when no external audio device is connected.
   *
   * Depending on the scenario, Agora uses different default audio routes:
   * - Voice call: Earpiece.
   * - Video call: Speakerphone.
   * - Audio broadcast: Speakerphone.
   * - Video broadcast: Speakerphone.
   *
   * Call this method before, during, or after a call, to change the default audio route. When the
   * audio route changes, the SDK triggers the {@link IRtcEngineEventHandler#onAudioRouteChanged
   * onAudioRouteChanged} callback.
   *
   * @note The system audio route changes when an external audio device, such as a headphone or a
   * Bluetooth audio device, is connected. See *Principles for Changing the Audio Route*.
   *
   * @param defaultToSpeaker Whether to set the speakerphone as the default audio route:
   * - true: Set the speakerphone as the default audio route.
   * - false: Do not set the speakerphone as the default audio route.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setDefaultAudioRoutetoSpeakerphone(boolean defaultToSpeaker);

  /**
   * Enables or disables the speakerphone temporarily.
   *
   * When the audio route changes, the SDK triggers the {@link
   * IRtcEngineEventHandler#onAudioRouteChanged onAudioRouteChanged} callback.
   *
   * You can call this method before, during, or after a call. However, Agora recommends calling
   * this method only when you are in a channel to change the audio route temporarily.
   *
   * @note This method sets the audio route temporarily. Plugging in or unplugging a headphone, or
   * the SDK re-enabling the audio device module (ADM) to adjust the media volume in some scenarios
   * relating to audio, leads to a change in the audio route. See *Principles for Changing the Audio
   * Route*.
   *
   * @param enabled Whether to set the speakerphone as the temporary audio route:
   * - true: Set the speakerphone as the audio route temporarily.
   * - false: Do not set the speakerphone as the audio route.
   * @return
   * - 0: Success.
   * - <0: Failure.
   */
  public abstract int setEnableSpeakerphone(boolean enabled);

  /**
   * Checks whether the speakerphone is enabled.
   *
   * @return
   * - true: The speakerphone is enabled, and the audio plays from the speakerphone.
   * - false: The speakerphone is not enabled, and the audio plays from devices other than the
   * speakerphone. For example, the headset or earpiece.
   */
  public abstract boolean isSpeakerphoneEnabled();

  /**
   * Enables in-ear monitoring.
   *
   * @param enabled Determines whether to enable in-ear monitoring.
   * - true: Enable in-ear monitoring.
   * - false: Disable in-ear monitoring.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableInEarMonitoring(boolean enabled);

  /**
   * Enables in-ear monitoring.
   *
   * @param enabled Determines whether to enable in-ear monitoring.
   * - true: Enable in ear monitoring.
   * - false: Disable in ear monitoring.
   * @param includeAudioFilters The type of the ear monitoring
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableInEarMonitoring(boolean enabled, int includeAudioFilters);

  /**
   * Sets the volume of the in-ear monitoring.
   *
   * @param volume The volume of the in-ear monitor, ranging from 0 to 100. The
   * default value is 100.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setInEarMonitoringVolume(int volume);

  /**
   * Use the external audio device.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int useExternalAudioDevice();

  /**
   * Sets the voice pitch of the local speaker.
   *
   * @param pitch Voice frequency, in the range of 0.5 to 2.0. The default value
   *              is 1.0.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int setLocalVoicePitch(double pitch);

  /**
   * Sets the local voice equalization effect.
   *
   * @param bandFrequency The band frequency ranging from 0 to 9; representing the
   *                      respective 10-band center frequencies of voice effects,
   *                      including 31, 62, 125, 500, 1k, 2k, 4k, 8k, and 16k Hz.
   *                      {@link Constants#AUDIO_EQUALIZATION_BAND_FREQUENCY}
   * @param bandGain      Gain of each band in dB; ranging from -15 to 15.
   */
  public abstract int setLocalVoiceEqualization(
      Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, int bandGain);

  /**
   * Sets the local voice reverberation.
   *
   * @param reverbKey The reverberation key. This method contains five
   *                  reverberation keys. For details, see the description of each
   *                  value.
   * @param value     Local voice reverberation value:
   *                  <ul>
   *                  <li>{@link AUDIO_REVERB_TYPE#AUDIO_REVERB_DRY_LEVEL
   *                  AUDIO_REVERB_DRY_LEVEL(0)}
   *                  <li>{@link AUDIO_REVERB_TYPE#AUDIO_REVERB_WET_LEVEL
   *                  AUDIO_REVERB_WET_LEVEL(1)}
   *                  <li>{@link AUDIO_REVERB_TYPE#AUDIO_REVERB_ROOM_SIZE
   *                  AUDIO_REVERB_ROOM_SIZE(2)}
   *                  <li>{@link AUDIO_REVERB_TYPE#AUDIO_REVERB_WET_DELAY
   *                  AUDIO_REVERB_WET_DELAY(3)}
   *                  <li>{@link AUDIO_REVERB_TYPE#AUDIO_REVERB_STRENGTH
   *                  AUDIO_REVERB_STRENGTH(4)}
   *                  </ul>
   */
  public abstract int setLocalVoiceReverb(Constants.AUDIO_REVERB_TYPE reverbKey, int value);

  /**
   * Sets the local voice changer option.
   *
   * This method can be used to set the local voice effect for users in a communication channel or
   * broadcasters in a live broadcast channel. Voice changer options include the following voice
   * effects:
   * - `VOICE_CHANGER_XXX`: Changes the local voice to an old man, a little boy, or the Hulk.
   * Applies to the voice talk scenario.
   * - `VOICE_BEAUTY_XXX`: Beautifies the local voice by making it sound more vigorous, resounding,
   * or adding spacial resonance. Applies to the voice talk and singing scenario.
   * - `GENERAL_VOICE_BEAUTY_XXX`: Adds gender-based beautification effect to the local voice.
   * Applies to the voice talk scenario.
   *   - For a male voice: Adds magnetism to the voice.
   *   - For a female voice: Adds freshness or vitality to the voice.
   *
   * @note
   * - To achieve better voice effect quality, Agora recommends setting the profile parameter in
   * {@link RtcEngine#setAudioProfile setAudioProfile} as `AUDIO_PROFILE_MUSIC_HIGH_QUALITY` or
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO`.
   * - This method works best with the human voice, and Agora does not recommend using it for audio
   * containing music and a human voice.
   * - Do not use this method with {@link RtcEngine#setLocalVoiceReverbPreset
   * setLocalVoiceReverbPreset}, because the method called later overrides the one called earlier.
   *
   * @param voiceChanger The local voice changer option:
   * - {@link Constants#VOICE_CHANGER_OFF VOICE_CHANGER_OFF}: (Default) Turn off the local voice
   * changer, that is, to use the original voice.
   * - {@link Constants#VOICE_CHANGER_OLDMAN VOICE_CHANGER_OLDMAN}: The voice of an old man.
   * - {@link Constants#VOICE_CHANGER_BABYBOY VOICE_CHANGER_BABYBOY}: The voice of a little boy.
   * - {@link Constants#VOICE_CHANGER_BABYGIRL VOICE_CHANGER_BABYGILR}: The voice of a little girl.
   * - {@link Constants#VOICE_CHANGER_ZHUBAJIE VOICE_CHANGER_ZHUBAJIE}: The voice of Zhu Bajie, a
   * character in Journey to the West who has a voice like that of a growling bear.
   * - {@link Constants#VOICE_CHANGER_ETHEREAL VOICE_CHANGER_ETHEREAL}: The ethereal voice.
   * - {@link Constants#VOICE_CHANGER_HULK VOICE_CHANGER_HULK}: The voice of Hulk.
   * - {@link Constants#VOICE_BEAUTY_VIGOROUS VOICE_BEAUTY_VIGOROUS}: A more vigorous voice.
   * - {@link Constants#VOICE_BEAUTY_DEEP VOICE_BEAUTY_DEEP}: A deeper voice.
   * - {@link Constants#VOICE_BEAUTY_MELLOW VOICE_BEAUTY_MELLOW}: A mellower voice.
   * - {@link Constants#VOICE_BEAUTY_FALSETTO VOICE_BEAUTY_FALSETTO}: Falsetto.
   * - {@link Constants#VOICE_BEAUTY_FULL VOICE_BEAUTY_FULL}: A fuller voice.
   * - {@link Constants#VOICE_BEAUTY_CLEAR VOICE_BEAUTY_CLEAR}: A clearer voice.
   * - {@link Constants#VOICE_BEAUTY_RESOUNDING VOICE_BEAUTY_RESOUNDING}: A more resounding voice.
   * - {@link Constants#VOICE_BEAUTY_RINGING VOICE_BEAUTY_RINGING}: A more ringing voice.
   * - {@link Constants#VOICE_BEAUTY_SPACIAL VOICE_BEAUTY_SPACIAL}: A more spatially resonant voice.
   * - {@link Constants#GENERAL_BEAUTY_VOICE_MALE_MAGNETIC GENERAL_BEAUTY_VOICE_MALE_MAGNETIC}: (For
   * male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice
   * distortion occurs.
   * - {@link Constants#GENERAL_BEAUTY_VOICE_FEMALE_FRESH GENERAL_BEAUTY_VOICE_FEMALE_FRESH}: (For
   * female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice
   * distortion occurs.
   * - {@link Constants#GENERAL_BEAUTY_VOICE_FEMALE_VITALITY GENERAL_BEAUTY_VOICE_FEMALE_VITALITY}:
   * (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise,
   * voice distortion occurs.
   * @return
   * - 0: Success.
   * - -1: Failure. Check if the enumeration is properly set.
   */
  public abstract int setLocalVoiceChanger(int voiceChanger);

  /**
   * Sets the local voice reverberation option.
   *
   * This method sets the local voice reverberation for users in a communication channel or
   * broadcasters in a live-broadcast channel. After successfully calling this method, all users in
   * the channel can hear the voice with reverberation.
   *
   * @note
   * - When calling this method with enumerations that begin with `AUDIO_REVERB_FX`, ensure that you
   * set profile in
   * {@link RtcEngine#setAudioProfile setAudioProfile} as `AUDIO_PROFILE_MUSIC_HIGH_QUALITY` or
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO`. Otherwise, this method call does not take effect.
   * - This method works best with the human voice, and Agora does not recommend using it for audio
   * containing music and a human voice.
   * - Do not use this method with {@link RtcEngine#setLocalVoiceChanger setLocalVoiceChanger},
   * because the method called later overrides the one called earlier.
   *
   * @param reverbPreset The local voice reverberation option. To achieve better voice effects,
   *     Agora recommends the enumeration whose name begins with `AUDIO_REVERB_FX`.
   * - {@link Constants#AUDIO_REVERB_OFF AUDIO_REVERB_OFF}: (Default) Turn off local voice
   * reverberation, that is, to use the original voice.
   * - {@link Constants#AUDIO_REVERB_POPULAR AUDIO_REVERB_POPULAR}: The reverberation style typical
   * of popular music.
   * - {@link Constants#AUDIO_REVERB_RNB AUDIO_REVERB_RNB}: The reverberation style typical of R&B
   * music.
   * - {@link Constants#AUDIO_REVERB_ROCK AUDIO_REVERB_ROCK}: The reverberation style typical of
   * rock music.
   * - {@link Constants#AUDIO_REVERB_HIPHOP AUDIO_REVERB_HIPHOP}: The reverberation style typical of
   * hip-hop music.
   * - {@link Constants#AUDIO_REVERB_VOCAL_CONCERT AUDIO_REVERB_VOCAL_CONCERT}: The reverberation
   * style typical of a concert hall.
   * - {@link Constants#AUDIO_REVERB_KTV AUDIO_REVERB_KTV}: The reverberation style typical of a KTV
   * venue.
   * - {@link Constants#AUDIO_REVERB_STUDIO AUDIO_REVERB_STUDIO}: The reverberation style typical of
   * a recording studio.
   * - {@link Constants#AUDIO_REVERB_FX_KTV AUDIO_REVERB_FX_KTV}: The reverberation style typical of
   * a KTV venue (enhanced).
   * - {@link Constants#AUDIO_REVERB_FX_VOCAL_CONCERT AUDIO_REVERB_FX_VOCAL_CONCERT}: The
   * reverberation style typical of a concert hall (enhanced).
   * - {@link Constants#AUDIO_REVERB_FX_UNCLE AUDIO_REVERB_FX_UNCLE}: The reverberation style
   * typical of an uncle's voice.
   * - {@link Constants#AUDIO_REVERB_FX_SISTER AUDIO_REVERB_FX_SISTER}: The reverberation style
   * typical of a little sister's voice.
   * - {@link Constants#AUDIO_REVERB_FX_STUDIO AUDIO_REVERB_FX_STUDIO}: The reverberation style
   * typical of a recording studio (enhanced).
   * - {@link Constants#AUDIO_REVERB_FX_POPULAR AUDIO_REVERB_FX_POPULAR}: The reverberation style
   * typical of popular music (enhanced).
   * - {@link Constants#AUDIO_REVERB_FX_RNB AUDIO_REVERB_FX_RNB}: The reverberation style typical of
   * R&B music (enhanced).
   * - {@link Constants#AUDIO_REVERB_FX_PHONOGRAPH AUDIO_REVERB_FX_PHONOGRAPH}: The reverberation
   * style typical of the vintage phonograph.
   * @return
   * - 0: Success.
   * - -1: Failure. Check if the enumeration is properly set.
   */
  public abstract int setLocalVoiceReverbPreset(int reverbPreset);

  /**
   * Sets an SDK preset audio effect.
   *
   * @since v3.2.0
   *
   * Call this method to set an SDK preset audio effect for the local user who sends an audio
   * stream. This audio effect does not change the gender characteristics of the original voice.
   * After setting an audio effect, all users in the channel can hear the effect.
   *
   * You can set different audio effects for different scenarios. See *Set the Voice Effect*.
   *
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `scenario` parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` before calling this method.
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the profile parameter of `setAudioProfile` to `AUDIO_PROFILE_SPEECH_STANDARD(1)`;
   * otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - If you call this method and set the preset parameter to enumerators except
   * `ROOM_ACOUSTICS_3D_VOICE` or `PITCH_CORRECTION`, do not call {@link setAudioEffectParameters
   * setAudioEffectParameters}; otherwise, `setAudioEffectParameters` overrides this method.
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override `setAudioEffectPreset`:
   *
   *   - {@link RtcEngine#setVoiceBeautifierPreset setVoiceBeautifierPreset}
   *   - {@link RtcEngine#setLocalVoiceReverbPreset setLocalVoiceReverbPreset}
   *   - {@link RtcEngine#setLocalVoiceChanger setLocalVoiceChanger}
   *   - {@link RtcEngine#setLocalVoicePitch setLocalVoicePitch}
   *   - {@link RtcEngine#setLocalVoiceEqualization setLocalVoiceEqualization}
   *   - {@link RtcEngine#setLocalVoiceReverb setLocalVoiceReverb}
   *   - {@link RtcEngine#setVoiceBeautifierParameters setVoiceBeautifierParameters}
   * @param preset The options for SDK preset audio effects
   * - {@link Constants#AUDIO_EFFECT_OFF AUDIO_EFFECT_OFF}
   * - {@link Constants#ROOM_ACOUSTICS_KTV ROOM_ACOUSTICS_KTV}
   * - {@link Constants#ROOM_ACOUSTICS_VOCAL_CONCERT ROOM_ACOUSTICS_VOCAL_CONCERT}
   * - {@link Constants#ROOM_ACOUSTICS_STUDIO ROOM_ACOUSTICS_STUDIO}
   * - {@link Constants#ROOM_ACOUSTICS_PHONOGRAPH ROOM_ACOUSTICS_PHONOGRAPH}
   * - {@link Constants#ROOM_ACOUSTICS_VIRTUAL_STEREO ROOM_ACOUSTICS_VIRTUAL_STEREO}
   * - {@link Constants#ROOM_ACOUSTICS_SPACIAL ROOM_ACOUSTICS_SPACIAL}
   * - {@link Constants#ROOM_ACOUSTICS_ETHEREAL ROOM_ACOUSTICS_ETHEREAL}
   * - {@link Constants#ROOM_ACOUSTICS_3D_VOICE ROOM_ACOUSTICS_3D_VOICE}
   * - {@link Constants#VOICE_CHANGER_EFFECT_UNCLE VOICE_CHANGER_EFFECT_UNCLE}
   * - {@link Constants#VOICE_CHANGER_EFFECT_OLDMAN VOICE_CHANGER_EFFECT_OLDMAN}
   * - {@link Constants#VOICE_CHANGER_EFFECT_BOY VOICE_CHANGER_EFFECT_BOY}
   * - {@link Constants#VOICE_CHANGER_EFFECT_SISTER VOICE_CHANGER_EFFECT_SISTER}
   * - {@link Constants#VOICE_CHANGER_EFFECT_GIRL VOICE_CHANGER_EFFECT_GIRL}
   * - {@link Constants#VOICE_CHANGER_EFFECT_PIGKING VOICE_CHANGER_EFFECT_PIGKING}
   * - {@link Constants#VOICE_CHANGER_EFFECT_HULK VOICE_CHANGER_EFFECT_HULK}
   * - {@link Constants#STYLE_TRANSFORMATION_RNB STYLE_TRANSFORMATION_RNB}
   * - {@link Constants#STYLE_TRANSFORMATION_POPULAR STYLE_TRANSFORMATION_POPULAR}
   * - {@link Constants#PITCH_CORRECTION PITCH_CORRECTION}
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setAudioEffectPreset(int preset);

  /**
   * Sets an SDK preset voice beautifier effect.
   *
   * @since v3.2.0
   *
   * Call this method to set an SDK preset voice beautifier effect for the local user who sends an
   * audio stream. After setting a voice beautifier effect, all users in the channel can hear the
   * effect.
   *
   * You can set different voice beautifier effects for different scenarios. See *Set the Voice
   * Effect*.
   *
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `scenario` parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` and the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * calling this method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the profile parameter of `setAudioProfile` to `AUDIO_PROFILE_SPEECH_STANDARD(1)`;
   * otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override {@link RtcEngine#setVoiceBeautifierPreset setVoiceBeautifierPreset}:
   *   - {@link RtcEngine#setAudioEffectPreset setAudioEffectPreset}
   *   - {@link RtcEngine#setAudioEffectParameters setAudioEffectParameters}
   *   - {@link RtcEngine#setLocalVoiceReverbPreset setLocalVoiceReverbPreset}
   *   - {@link RtcEngine#setLocalVoiceChanger setLocalVoiceChanger}
   *   - {@link RtcEngine#setLocalVoicePitch setLocalVoicePitch}
   *   - {@link RtcEngine#setLocalVoiceEqualization setLocalVoiceEqualization}
   *   - {@link RtcEngine#setLocalVoiceReverb setLocalVoiceReverb}
   *   - {@link RtcEngine#setVoiceBeautifierParameters setVoiceBeautifierParameters}
   *   - {@link RtcEngine#setVoiceConversionPreset setVoiceConversionPreset}
   * @param preset The options for SDK preset voice beautifier effects:
   * - {@link Constants#VOICE_BEAUTIFIER_OFF VOICE_BEAUTIFIER_OFF}
   * - {@link Constants#CHAT_BEAUTIFIER_MAGNETIC CHAT_BEAUTIFIER_MAGNETIC}
   * - {@link Constants#CHAT_BEAUTIFIER_FRESH CHAT_BEAUTIFIER_FRESH}
   * - {@link Constants#CHAT_BEAUTIFIER_VITALITY CHAT_BEAUTIFIER_VITALITY}
   * - {@link Constants#TIMBRE_TRANSFORMATION_VIGOROUS TIMBRE_TRANSFORMATION_VIGOROUS}
   * - {@link Constants#TIMBRE_TRANSFORMATION_DEEP TIMBRE_TRANSFORMATION_DEEP}
   * - {@link Constants#TIMBRE_TRANSFORMATION_MELLOW TIMBRE_TRANSFORMATION_MELLOW}
   * - {@link Constants#TIMBRE_TRANSFORMATION_FALSETTO TIMBRE_TRANSFORMATION_FALSETTO}
   * - {@link Constants#TIMBRE_TRANSFORMATION_FULL TIMBRE_TRANSFORMATION_FULL}
   * - {@link Constants#TIMBRE_TRANSFORMATION_CLEAR TIMBRE_TRANSFORMATION_CLEAR}
   * - {@link Constants#TIMBRE_TRANSFORMATION_RESOUNDING TIMBRE_TRANSFORMATION_RESOUNDING}
   * - {@link Constants#TIMBRE_TRANSFORMATION_RINGING TIMBRE_TRANSFORMATION_RINGING
   * - {@link Constants#ULTRA_HIGH_QUALITY_VOICE ULTRA_HIGH_QUALITY_VOICE}
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setVoiceBeautifierPreset(int preset);
  /**
   * Sets an SDK preset voice conversion effect.
   *
   * @since v3.3.1
   *
   * Call this method to set an SDK preset voice conversion effect for the local user who sends an
   * audio stream. After setting a voice conversion effect, all users in the channel can hear the
   * effect.
   *
   * You can set different voice conversion effects for different scenarios. See *Set the Voice
   * Effect*.
   *
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `scenario` parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` and the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * calling this method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the `profile` parameter of `setAudioProfile` to
   * `AUDIO_PROFILE_SPEECH_STANDARD(1)`; otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override {@link RtcEngine#setVoiceConversionPreset setVoiceConversionPreset}:
   *   - {@link RtcEngine#setAudioEffectPreset setAudioEffectPreset}
   *   - {@link RtcEngine#setAudioEffectParameters setAudioEffectParameters}
   *   - {@link RtcEngine#setVoiceBeautifierPreset setVoiceBeautifierPreset}
   *   - {@link RtcEngine#setVoiceBeautifierParameters setVoiceBeautifierParameters}
   *   - {@link RtcEngine#setLocalVoiceReverbPreset setLocalVoiceReverbPreset}
   *   - {@link RtcEngine#setLocalVoiceChanger setLocalVoiceChanger}
   *   - {@link RtcEngine#setLocalVoicePitch setLocalVoicePitch}
   *   - {@link RtcEngine#setLocalVoiceEqualization setLocalVoiceEqualization}
   *   - {@link RtcEngine#setLocalVoiceReverb setLocalVoiceReverb}
   *
   * @param preset The options for SDK preset voice conversion effects:
   * - {@link Constants#VOICE_CONVERSION_OFF VOICE_CONVERSION_OFF}
   * - {@link Constants#VOICE_CHANGER_NEUTRAL VOICE_CHANGER_NEUTRAL}
   * - {@link Constants#VOICE_CHANGER_SWEET VOICE_CHANGER_SWEET}
   * - {@link Constants#VOICE_CHANGER_SOLID VOICE_CHANGER_SOLID}
   * - {@link Constants#VOICE_CHANGER_BASS VOICE_CHANGER_BASS}
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setVoiceConversionPreset(int preset);
  /**
   * Sets parameters for SDK preset audio effects.
   *
   * @since v3.2.0
   *
   * Call this method to set the following parameters for the local user who sends an audio stream:
   * - 3D voice effect: Sets the cycle period of the 3D voice effect.
   * - Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect.
   * Different songs have different modes and tonic pitches. Agora recommends bounding this method
   * with interface elements to enable users to adjust the pitch correction interactively.
   *
   * After setting parameters, all users in the channel can hear the relevant effect.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - To achieve better audio effect quality, Agora recommends calling `setAudioProfile` and
   * setting the scenario parameter to `AUDIO_SCENARIO_GAME_STREAMING(3)` before calling this
   * method.
   * - Do not set the profile parameter of setAudioProfile to `AUDIO_PROFILE_SPEECH_STANDARD(1)`;
   * otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override `setAudioEffectParameters`:
   *   - {@link RtcEngine#setAudioEffectPreset setAudioEffectPreset}
   *   - {@link RtcEngine#setVoiceBeautifierPreset setVoiceBeautifierPreset}
   *   - {@link RtcEngine#setLocalVoiceReverbPreset setLocalVoiceReverbPreset}
   *   - {@link RtcEngine#setLocalVoiceChanger setLocalVoiceChanger}
   *   - {@link RtcEngine#setLocalVoicePitch setLocalVoicePitch}
   *   - {@link RtcEngine#setLocalVoiceEqualization setLocalVoiceEqualization}
   *   - {@link RtcEngine#setLocalVoiceReverb setLocalVoiceReverb}
   *   - {@link RtcEngine#setVoiceBeautifierParameters setVoiceBeautifierParameters}
   *   - {@link RtcEngine#setVoiceConversionPreset setVoiceConversionPreset}
   * @param preset The options for SDK preset audio effects:
   * - 3D voice effect: `ROOM_ACOUSTICS_3D_VOICE`
   *     - Call `setAudioProfile` and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator; otherwise, the enumerator setting does not take effect.
   *     - If the 3D voice effect is enabled, users need to use stereo audio playback devices to
   * hear the anticipated voice effect.
   * - Pitch correction effect: `PITCH_CORRECTION`. To achieve better audio effect quality, Agora
   * recommends calling `setAudioProfile` and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   * @param param1
   *   - If you set `preset` to `ROOM_ACOUSTICS_3D_VOICE`, the `param1` sets the cycle period of the
   * 3D voice effect. The value range is [1, 60] and the unit is a second. The default value is 10
   * seconds, indicating that the voice moves around you every 10 seconds.
   *   - If you set `preset` to `PITCH_CORRECTION`, `param1` sets the basic mode of the pitch
   * correction effect:
   *      - `1`: (Default) Natural major scale.
   *      - `2`: Natural minor scale.
   *      - `3`: Japanese pentatonic scale.
   * @param param2
   *   - You need to set `param2` to `0`.
   *   - If you set `preset` to `PITCH_CORRECTION`, `param2` sets the tonic pitch of the pitch
   * correction effect:
   *     - `1`: A
   *     - `2`: A#
   *     - `3`: B
   *     - `4`: (Default) C
   *     - `5`: C#
   *     - `6`: D
   *     - `7`: D#
   *     - `8`: E
   *     - `9`: F
   *     - `10`: F#
   *     - `11`: G
   *     - `12`: G#
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setAudioEffectParameters(int preset, int param1, int param2);

  /**
   * Sets parameters for SDK preset voice beautifier effects.
   *
   * @since 3.3.0.
   *
   * Call this method to set a gender characteristic and a reverberation effect for the singing
   * beautifier effect. This method sets parameters for the local user who sends an audio stream.
   *
   * After you call this method successfully, all users in the channel can hear the relevant effect.
   *
   * To achieve better audio effect quality, before you call this method, Agora recommends calling
   * {@link RtcEngine#setAudioProfile setAudioProfile}, and setting the scenario parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` and the profile parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the `profile` parameter of `setAudioProfile` to
   * `AUDIO_PROFILE_SPEECH_STANDARD(1)`; otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - After you call this method, Agora recommends not calling the following methods, because they
   * can override `setVoiceBeautifierParameters`:
   *   - {@link RtcEngine#setAudioEffectPreset setAudioEffectPreset}
   *   - {@link RtcEngine#setAudioEffectParameters setAudioEffectParameters}
   *   - {@link RtcEngine#setVoiceBeautifierPreset setVoiceBeautifierPreset}
   *   - {@link RtcEngine#setLocalVoiceReverbPreset setLocalVoiceReverbPreset}
   *   - {@link RtcEngine#setLocalVoiceChanger setLocalVoiceChanger}
   *   - {@link RtcEngine#setLocalVoicePitch setLocalVoicePitch}
   *   - {@link RtcEngine#setLocalVoiceEqualization setLocalVoiceEqualization}
   *   - {@link RtcEngine#setLocalVoiceReverb setLocalVoiceReverb}
   *   - {@link RtcEngine#setVoiceConversionPreset setVoiceConversionPreset}
   * @param preset The options for SDK preset voice beautifier effects:
   *               - `SINGING_BEAUTIFIER`: Singing beautifier effect.
   * @param param1 The gender characteristics options for the singing voice:
   *               - `1`: A male-sounding voice.
   *               - `2`: A female-sounding voice.
   * @param param2 The reverberation effects options:
   *               - `1`: The reverberation effect sounds like singing in a small room.
   *               - `2`: The reverberation effect sounds like singing in a large room.
   *               - `3`: The reverberation effect sounds like singing in a hall.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setVoiceBeautifierParameters(int preset, int param1, int param2);

  /**
   * Set parameters for SDK preset voice conversion.
   *
   * @note
   * - reserved interface
   *
   * @param preset The options for SDK preset audio effects. See #VOICE_CONVERSION_PRESET.
   * @param param1 reserved.
   * @param param2 reserved.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setVoiceConversionParameters(int preset, int param1, int param2);

  /**
   * Enables/Disables stereo panning for remote users.
   * Ensure that you call this method before joinChannel to enable stereo panning for remote users
   * so that the local user can track the position of a remote user by calling \ref
   * agora::rtc::IRtcEngine::setRemoteVoicePosition "setRemoteVoicePosition".
   * @param enabled Sets whether or not to enable stereo panning for remote users:
   * - true: enables stereo panning.
   * - false: disables stereo panning.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableSoundPositionIndication(boolean enabled);

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
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteVoicePosition(int uid, double pan, double gain);

  /**
   * Starts playing and mixing the music file.
   *
   * This method mixes the specified local or online audio file with the audio stream from the
   * microphone, or replaces the microphone’s audio stream with the specified local or remote audio
   * file.
   *
   * You can choose whether the other user can hear the local audio playback and specify the number
   * of playback loops.
   *
   * A successful `startAudioMixing` method call triggers the {@link
   * IRtcEngineEventHandler#onAudioMixingStateChanged
   * onAudioMixingStateChanged}(AUDIO_MIXING_STATE_PLAYING) callback on the local client. When the
   * audio mixing file playback finishes, the SDK triggers the {@link
   * IRtcEngineEventHandler#onAudioMixingStateChanged
   * onAudioMixingStateChanged}(AUDIO_MIXING_STATE_STOPPED) callback on the local client.
   * @param filePath Specifies the absolute path (including the suffixes of the filename) of the
   *     local or online audio file to be mixed.
   * For example, `/sdcard/emulated/0/audio.mp4`. Supported audio formats: mp3, mp4, m4a, aac, 3gp,
   * mkv, and wav.
   * - If the path begins with /assets/, the audio file is in the /assets/ directory.
   * - Otherwise, the audio file is in the absolute path.
   * @param loopback Sets which user can hear the audio mixing:
   * - true: Only the local user can hear the audio mixing.
   * - false: Both users can hear the audio mixing.
   * @param replace Sets the audio mixing content:
   * - true: Only publish the specified audio file; the audio stream from the microphone is not
   * published.
   * - false: The local audio file is mixed with the audio stream from the microphone.
   * @param cycle Sets the number of playback loops:
   * - Positive integer: Number of playback loops.
   * - -1: Infinite playback loops.
   *
   * @note
   * - To use this method, ensure that the Android device is v4.2 or later, and the API version is
   * v16 or later.
   * - Call this method when you are in the channel, otherwise it may cause issues.
   * - If you want to play an online music file, ensure that the time interval between calling this
   * method is more than 100 ms, or the `AUDIO_FILE_OPEN_TOO_FREQUENT(702)` warning occurs.
   * - If you want to play an online music file, Agora does not recommend using the redirected URL
   * address. Some Android devices may fail to open a redirected URL address.
   * - If you call this method on an emulator, only the MP3 file format is supported.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *     - {@link Constants#WARN_AUDIO_MIXING_OPEN_ERROR WARN_AUDIO_MIXING_OPEN_ERROR (701)}: If the
   * local audio file does not exist, or the online audio packet is not received within five seconds
   * after it is opened, the SDK assumes that the media file cannot be used and returns this
   * warning.
   */
  public abstract int startAudioMixing(
      String filePath, boolean loopback, boolean replace, int cycle);

  /**
   * Starts playing and mixing the music file.
   *
   * This method mixes the specified local or online audio file with the audio stream from the
   * microphone, or replaces the microphone’s audio stream with the specified local or remote audio
   * file.
   *
   * You can choose whether the other user can hear the local audio playback and specify the number
   * of playback loops.
   *
   * A successful `startAudioMixing` method call triggers the {@link
   * IRtcEngineEventHandler#onAudioMixingStateChanged
   * onAudioMixingStateChanged}(AUDIO_MIXING_STATE_PLAYING) callback on the local client. When the
   * audio mixing file playback finishes, the SDK triggers the {@link
   * IRtcEngineEventHandler#onAudioMixingStateChanged
   * onAudioMixingStateChanged}(AUDIO_MIXING_STATE_STOPPED) callback on the local client.
   * @param filePath Specifies the absolute path (including the suffixes of the filename) of the
   *     local or online audio file to be mixed.
   * For example, `/sdcard/emulated/0/audio.mp4`. Supported audio formats: mp3, mp4, m4a, aac, 3gp,
   * mkv, and wav.
   * - If the path begins with /assets/, the audio file is in the /assets/ directory.
   * - Otherwise, the audio file is in the absolute path.
   * @param loopback Sets which user can hear the audio mixing:
   * - true: Only the local user can hear the audio mixing.
   * - false: Both users can hear the audio mixing.
   * @param replace Sets the audio mixing content:
   * - true: Only publish the specified audio file; the audio stream from the microphone is not
   * published.
   * - false: The local audio file is mixed with the audio stream from the microphone.
   * @param cycle Sets the number of playback loops:
   * - Positive integer: Number of playback loops.
   * - -1: Infinite playback loops.
   * @param startPos The playback position (ms) of the music file.
   *
   * @note
   * - To use this method, ensure that the Android device is v4.2 or later, and the API version is
   * v16 or later.
   * - Call this method when you are in the channel, otherwise it may cause issues.
   * - If you want to play an online music file, ensure that the time interval between calling this
   * method is more than 100 ms, or the `AUDIO_FILE_OPEN_TOO_FREQUENT(702)` warning occurs.
   * - If you want to play an online music file, Agora does not recommend using the redirected URL
   * address. Some Android devices may fail to open a redirected URL address.
   * - If you call this method on an emulator, only the MP3 file format is supported.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *     - {@link Constants#WARN_AUDIO_MIXING_OPEN_ERROR WARN_AUDIO_MIXING_OPEN_ERROR (701)}: If the
   * local audio file does not exist, or the online audio packet is not received within five seconds
   * after it is opened, the SDK assumes that the media file cannot be used and returns this
   * warning.
   */
  public abstract int startAudioMixing(
      String filePath, boolean loopback, boolean replace, int cycle, int startPos);

  /**
   * Stops playing or mixing the music file.
   *
   * Call this method when you are in a channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopAudioMixing();

  /**
   * Pauses playing and mixing the music file.
   *
   * Call this method when you are in a channel.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pauseAudioMixing();

  /**
   * Resumes playing and mixing the music file.
   *
   * Call this method when you are in a channel.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int resumeAudioMixing();

  /**
   * Adjusts the volume of audio mixing.
   *
   * Call this method when you are in a channel.
   *
   * @note Calling this method does not affect the volume of the audio effect file
   * playback invoked by the {@link RtcEngine#playEffect() playEffect} method.
   *
   * @param volume Audio mixing volume. The value ranges between 0 and 100 (default).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int adjustAudioMixingVolume(int volume);

  /**
   * Adjusts the audio mixing volume for local playback.
   * @note Call this method when you are in a channel.
   * @param volume Audio mixing volume for local playback. The value ranges between 0 and 100
   * (default).
   * @return
   *  - 0: Success.
   *  - < 0: Failure.
   */
  public abstract int adjustAudioMixingPlayoutVolume(int volume);

  /**
   * Adjusts the audio mixing volume for publishing (for remote users).
   * @note Call this method when you are in a channel.
   * @param volume Audio mixing volume for publishing. The value ranges between 0 and 100 (default).
   * @return
   *  - 0: Success.
   *  - < 0: Failure.
   */
  public abstract int adjustAudioMixingPublishVolume(int volume);

  /**
   * Retrieves the audio mixing volume for local playback.
   * This method helps troubleshoot audio volume related issues.
   * @note Call this method when you are in a channel.
   * @return
   *  - &ge; 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
   *  - < 0: Failure.
   */
  public abstract int getAudioMixingPlayoutVolume();

  /**
   * Retrieves the audio mixing volume for publishing.
   * This method helps troubleshoot audio volume related issues.
   * @note Call this method when you are in a channel.
   * @return
   *  - &ge; 0: The audio mixing volume for publishing, if this method call succeeds. The value
   * range is [0,100].
   *  - < 0: Failure.
   */
  public abstract int getAudioMixingPublishVolume();

  /**
   * Gets the duration (ms) of the music file.
   *
   * Call this method when you are in a channel.
   *
   * @return
   * - Returns the audio mixing duration, if the method call is successful.
   * - < 0: Failure.
   */
  public abstract int getAudioMixingDuration();

  /**
   * Gets the playback position (ms) of the music file.
   *
   * Call this method when you are in a channel.
   *
   * @return
   * - Returns the current playback position of the audio mixing, if the method call is successful.
   * - < 0: Failure.
   */
  public abstract int getAudioMixingCurrentPosition();

  /**
   * Sets the playback position (ms) of the music file to a different starting position (the default
   * plays from the beginning).
   *
   * @param pos The playback starting position (ms) of the audio mixing file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setAudioMixingPosition(int pos);

  /**
   * Sets the pitch of the music file.
   *
   * @param pitch The pitch of the music file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setAudioMixingPitch(int pitch);

  /**
   * Gets the IAudioEffectManager object associated with the current RTC engine.
   *
   * @return IAudioEffectManager
   */
  public abstract IAudioEffectManager getAudioEffectManager();

  /**
   * <p>
   * Starts an audio recording.
   *
   * <p>
   * The SDK allows recording during a call, which supports either one of the
   * following formats:
   * <ul>
   * <li>.wav: Large file size with high sound fidelity
   * <li>.aac: Small file size with low sound fidelity
   * </ul>
   * <p>
   * Ensure that the directory to save the recording file exists and is writable.
   * This method is usually called after the
   * {@link RtcEngine#joinChannel(java.lang.String token, java.lang.String channelName,
   * java.lang.String optionalInfo, int optionalUid) joinChannel} method. The recording
   * automatically stops when the
   * {@link RtcEngine#leaveChannel() leaveChannel} method is called.
   *
   * @param filePath Full file path of the recording file. The string of the file
   *                 name is in UTF-8 code.
   * @param quality  Audio recording quality:
   *                 <ul>
   *                 <li>{@link Constants#AUDIO_RECORDING_QUALITY_LOW
   *                 AUDIO_RECORDING_QUALITY_LOW(0)}
   *                 <li>{@link Constants#AUDIO_RECORDING_QUALITY_MEDIUM
   *                 AUDIO_RECORDING_QUALITY_MEDIUM(1)}
   *                 <li>{@link Constants#AUDIO_RECORDING_QUALITY_HIGH
   *                 AUDIO_RECORDING_QUALITY_HIGH(2)}
   *                 </ul>
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int startAudioRecording(String filePath, int quality);

  /**
   * <p>
   * Starts an audio recording.
   *
   * <p>
   * The SDK allows recording during a call, which supports either one of the
   * following formats:
   * <ul>
   * <li>.wav: Large file size with high sound fidelity
   * <li>.aac: Small file size with low sound fidelity
   * </ul>
   * <p>
   * Ensure that the directory to save the recording file exists and is writable.
   * This method is usually called after the
   * {@link RtcEngine#joinChannel(java.lang.String token, java.lang.String channelName,
   * java.lang.String optionalInfo, int optionalUid) joinChannel} method. The recording
   * automatically stops when the
   * {@link RtcEngine#leaveChannel() leaveChannel} method is called.
   *
   * @param config audio file recording config
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int startAudioRecording(AudioRecordingConfiguration config);

  /**
   * <p>
   * Stops the audio recording on the client.
   *
   * <p>
   * Note: Call this method before calling {@link RtcEngine#leaveChannel()
   * leaveChannel}, otherwise the recording automatically stops when the
   * {@link RtcEngine#leaveChannel() leaveChannel} method is called.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   *
   */
  public abstract int stopAudioRecording();

  /**
   *
   * @deprecated Now use {@link #startEchoTest（int）}
   *
   * <p>
   * Starts an audio call test to determine whether the audio devices (for
   * example, headset and speaker) and the network connection are working
   * properly.
   *
   * <p>
   * In the test, the user first speaks, and the recording is played back in 10
   * seconds. If the user can hear the recording in 10 seconds, it indicates that
   * the audio devices and network connection work properly.
   *
   * <p>
   * Note: After calling the {@link RtcEngine#startEchoTest() startEchoTest}
   * method, call {@link RtcEngine#stopEchoTest() stopEchoTest} to end the test;
   * otherwise the application cannot run the next echo test, nor can it call the
   * {@link RtcEngine#joinChannel(java.lang.String token, java.lang.String channelName,
   * java.lang.String optionalInfo, int optionalUid) joinChannel} method to start a new call.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  @Deprecated public abstract int startEchoTest();

  /**
   * Starts an audio call test.
   * @since v2.4.0.
   * <p>In the audio call test, you record your voice. If the recording plays back within the set
   * time interval, the audio devices and the network connection are working properly.
   *
   * @note
   * - Call this method before joining a channel.
   * - After calling this method, call the {@link RtcEngine#stopEchoTest stopEchoTest} method to end
   * the test. Otherwise, the app cannot run the next echo test, or call the {@link
   * RtcEngine#joinChannel joinchannel} method.
   * - In the `LIVE_BROADCASTING` profile, only a host can call this method.
   *
   * @param intervalInSeconds The time interval (s) between when you speak and when the recording
   *     plays back.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int startEchoTest(int intervalInSeconds);

  /**
   * Stops an audio call test.
   *
   * @return
   *         <ul>
   *         <li>0: Succeeded.
   *         <li><0: Failed.
   *         <ul>
   *         <li>{@link Constants#ERR_REFUSED ERR_REFUSED(-5)}. Failed to stop the
   *         echo test. The echo test may not be running.
   *         </ul>
   *         </ul>
   */
  public abstract int stopEchoTest();

  /**
   * Starts the last-mile network probe test before joining a channel to get the uplink and downlink
   * last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time
   * (RTT).
   *
   * Once this method is enabled, the SDK triggers the {@link
   * IRtcEngineEventHandler#onLastmileProbeResult onLastmileProbeResult} callback within 30 seconds,
   * and reports the real-time statistics of the network conditions.
   *
   * Call this method to check the uplink network quality before users join a channel or before an
   * audience switches to a host.
   * @note
   * - This method consumes extra network traffic and may affect communication quality.
   * - Do not call other methods before receiving the {@link
   * IRtcEngineEventHandler#onLastmileProbeResult onLastmileProbeResult} callback. Otherwise, the
   * callback may be interrupted by other methods.
   * @param config The configurations of the last-mile network probe test. For details, see
   * {@link io.agora.rtc2.internal.LastmileProbeConfig LastmileProbeConfig}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int startLastmileProbeTest(LastmileProbeConfig config);

  /**
   * Stops the last-mile network probe test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopLastmileProbeTest();

  public abstract int enableEchoCancellationExternal(boolean enabled, int audioSourceDelay);

  /**
   * Sets the external audio sink.
   *
   * This method applies to scenarios where you want to use external audio data for playback.
   * After calling the {@link RtcEngine#create(RtcEngineConfig)} method and pass value of false in
   * the `enableAudioDevice` member in the {@link RtcEngineConfig#mEnableAudioDevice}, you can call
   * the
   * {@link RtcEngine#pullPlaybackAudioFrame pullPlaybackAudioFrame} method to pull the remote audio
   * data, process it, and play it with the audio effects that you want.
   *
   * Ensure that you call this method before joining a channel.
   *
   * @note
   * Once you call the {@link RtcEngine#create(RtcEngineConfig)} method and pass value of false in
   * the `enableAudioDevice` member in the {@link RtcEngineConfig#mEnableAudioDevice}, the app will
   * not retrieve any audio data from the {@link
   * io.agora.rtc2.IAudioFrameObserver#onPlaybackAudioFrame(int, int, int, int, int, ByteBuffer,
   * long, int)}  onPlaybackFrame} callback.
   *
   * @param sampleRate The sample rate (Hz) of the external audio sink. You can set this parameter
   *     as 16000, 32000, 44100, or 48000.
   * @param channels The number of audio channels of the external audio sink:
   *                 - 1: Mono.
   *                 - 2: Stereo.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setExternalAudioSink(int sampleRate, int channels);

  public abstract int pushCaptureAudioFrame(byte[] data);

  public abstract int pushCaptureAudioFrame(ByteBuffer data, int lengthInByte);

  public abstract int pushReverseAudioFrame(byte[] data);

  public abstract int pushReverseAudioFrame(ByteBuffer data, int lengthInByte);

  /**
   * Pulls the remote audio frame.
   *
   * Before calling this method, call the {@link RtcEngine#create(RtcEngineConfig)} method and pass
   * value of false in the `enableAudioDevice` member in the {@link
   * RtcEngineConfig#mEnableAudioDevice}, and call the {@link RtcEngine#setExternalAudioSink(int,
   * int)} method to enable and set the external audio sink.
   *
   * Ensure that you call this method after joining a channel.
   *
   * After a successful method call, the app pulls the decoded and mixed audio data for playback.
   *
   * @note
   * - Once you call the `pullPlaybackAudioFrame` method successfully, the app will not retrieve any
   * audio data from the {@link io.agora.rtc2.IAudioFrameObserver#onPlaybackAudioFrame(int, int,
   * int, int, int, ByteBuffer, long, int)}  onPlaybackFrame} callback.
   * - The difference between the `onPlaybackFrame` callback and the `pullPlaybackAudioFrame` method
   * is as follows:
   *   - `onPlaybackFrame`: The SDK sends the audio data to the app through this callback. Any delay
   * in processing the audio frames may result in audio jitter.
   *   - `pullPlaybackAudioFrame`: The app pulls the remote audio data. After setting the audio data
   * parameters, the SDK adjusts the frame buffer and avoids problems caused by jitter in the
   * external audio playback.
   *
   * @param data The audio data that you want to pull. The data format is in byte[].
   * @param lengthInByte The data length (byte) of the external audio data. The value of this
   *     parameter is related to the audio duration, and the values of the `sampleRate` and
   *     `channels` parameters that you set in {@link RtcEngine#setExternalAudioSink
   *     setExternalAudioSink}. Agora recommends setting the audio duration no shorter than 10 ms.
   *     The formula for `lengthInByte` is: <br>lengthInByte = sampleRate/1000 × 2 × channels ×
   *     audio duration (ms).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pullPlaybackAudioFrame(byte[] data, int lengthInByte);

  /**
   * Pulls the remote audio frame.
   *
   * Before calling this method, call the {@link RtcEngine#setExternalAudioSink
   * setExternalAudioSink}(enabled: true) method to enable and set the external audio sink.
   *
   * Ensure that you call this method after joining a channel.
   *
   * After a successful method call, the app pulls the decoded and mixed audio data for playback.
   *
   * @note
   * - Once you call the `pullPlaybackAudioFrame` method successfully, the app will not retrieve any
   * audio data from the {@link io.agora.rtc2.IAudioFrameObserver#onPlaybackAudioFrame(int, int,
   * int, int, int, ByteBuffer, long, int)}  onPlaybackFrame} callback.
   * - The difference between the `onPlaybackFrame` callback and the `pullPlaybackAudioFrame` method
   * is as follows:
   *   - `onPlaybackFrame`: The SDK sends the audio data to the app through this callback. Any delay
   * in processing the audio frames may result in audio jitter.
   *   - `pullPlaybackAudioFrame`: The app pulls the remote audio data. After setting the audio data
   * parameters, the SDK adjusts the frame buffer and avoids problems caused by jitter in the
   * external audio playback.
   *
   * @param data The audio data that you want to pull. The data format is in ByteBuffer.
   * @param lengthInByte The data length (byte) of the external audio data. The value of this
   *     parameter is related to the audio duration, and the values of the `sampleRate` and
   *     `channels` parameters that you set in {@link RtcEngine#setExternalAudioSink
   *     setExternalAudioSink}. Agora recommends setting the audio duration no shorter than 10 ms.
   *     The formula for `lengthInByte` is: <br>lengthInByte = sampleRate/1000 × 2 × channels ×
   *     audio duration (ms).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pullPlaybackAudioFrame(ByteBuffer data, int lengthInByte);

  /**
   * Sets the external audio source.
   *
   * @note Ensure that you call this method before calling `joinChannel`.
   *
   * @param enabled Determines whether to enable the external audio source:
   * - true: Enable the external audio source.
   * - false: (default) Disable the external audio source.
   * @param sampleRate The Sample rate (Hz) of the external audio source, which can set be as
   * 8000, 16000, 32000, 44100, or 48000.
   * @param channels The number of channels of the external audio source, which can be set as 1 or
   *     2:
   * - 1: Mono.
   * - 2: Stereo.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setExternalAudioSource(boolean enabled, int sampleRate, int channels);

  /**
   * Sets the external audio source.
   *
   * @note
   * Ensure that you call this method before `joinChannel`.
   *
   * @param enabled Determines whether to enable the external audio source:
   * - true: Enable the external audio source.
   * - false: (default) Disable the external audio source.
   * @param sampleRate The Sample rate (Hz) of the external audio source, which can set be as
   * 8000, 16000, 32000, 44100, or 48000.
   * @param channels The number of channels of the external audio source, which can be set as 1 or
   *     2:
   * - 1: Mono.
   * - 2: Stereo.
   * @param sourceNumber The number of audio source per channel.
   * - 1: Mono.
   * - 2: Stereo.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setExternalAudioSource(boolean enabled, int sampleRate, int channels,
      int sourceNumber, boolean localPlayback, boolean publish);

  /**
   * Sets the direct external audio source.
   *
   * @param enabled Determines whether to enable the direct external audio source:
   * - true: Enable the direct external audio source.
   * - false: (default) Disable the direct external audio source.
   */
  public abstract int setDirectExternalAudioSource(boolean enabled);

  /**
   * Sets the direct external audio source.
   *
   * @param enabled Determines whether to enable the direct external audio source:
   * - true: Enable the direct external audio source.
   * - false: (default) Disable the direct external audio source.
   * @param localPlayback Determines whether to enable the local playback of the direct external audio source
   */
  public abstract int setDirectExternalAudioSource(boolean enabled, boolean localPlayback);

  /**
   * Pushes the direct send audio data to the SDK.
   *
   * @param data The audio buffer data.
   * @param timestamp The timestamp of the audio data.
   * @param sampleRate The sample rate of the audio data, which can be set as 8000, 16000, 32000,
   *     44100, or 48000 Hz.
   * @param channels The number of the audio data, which can be set as 1 or 2:
   * - 1: Mono.
   * - 2: Stereo.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pushDirectAudioFrame(
      ByteBuffer data, long timestamp, int sampleRate, int channels);

  /**
   * Pushes the external audio data to the app.
   *
   * @param data The audio buffer data.
   * @param timestamp The timestamp of the audio data.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pushExternalAudioFrame(byte[] data, long timestamp);

  /**
   * Pushes the external audio data to the app.
   *
   * @param data The audio buffer data.
   * @param timestamp The timestamp of the audio data.
   * @param sourceId The audio track ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pushExternalAudioFrame(ByteBuffer data, long timestamp, int sourceId);

  /**
   * Sets the external video source.
   *
   * Once the external video source is enabled, the SDK prepares to accept the external video frame.
   *
   * @param enable Determines whether to enable the external video source.
   * - true: Enable the external video source. Once set, the SDK creates the external source and
   * prepares video data from `pushExternalVideoFrame` or `pushExternalEncodedVideoFrame`.
   * - false: Disable the external video source.
   * @param useTexture Determines whether to use textured video data.
   * - true: Use texture, which is not supported now.
   * - False: Do not use texture.
   * @param sourceType Determines whether the external video source is encoded.
   * - {@link Constants#ExternalVideoSourceType VIDEO_FRAME(0)}: The external video source is not
   * encoded.
   * - {@link Constants#ExternalVideoSourceType ENCODED_VIDEO_FRAME(1)}: The external video source
   * is encoded.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setExternalVideoSource(
      boolean enable, boolean useTexture, Constants.ExternalVideoSourceType sourceType);

  /**
   * Sets the external video source.
   *
   * Once the external video source is enabled, the SDK prepares to accept the external video frame.
   *
   * @param enable Determines whether to enable the external video source.
   * - true: Enable the external video source. Once set, the SDK creates the external source and
   * prepares video data from `pushExternalVideoFrame` or `pushExternalEncodedVideoFrame`.
   * - false: Disable the external video source.
   * @param useTexture Determines whether to use textured video data.
   * - true: Use texture, which is not supported now.
   * - False: Do not use texture.
   * @param sourceType Determines whether the external video source is encoded.
   * - {@link Constants#ExternalVideoSourceType VIDEO_FRAME(0)}: The external video source is not
   * encoded.
   * - {@link Constants#ExternalVideoSourceType ENCODED_VIDEO_FRAME(1)}: The external video source
   * is encoded.
   * @param encodedOpt Determine encoded video track options including codec type, cc mode and
   * target bitrate.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setExternalVideoSource(boolean enable, boolean useTexture,
      Constants.ExternalVideoSourceType sourceType, EncodedVideoTrackOptions encodedOpt);

  /**
   * Pushes the video frame using the {@link io.agora.rtc2.video.AgoraVideoFrame AgoraVideoFrame}
   * class and passes the video frame to the Agora SDK.
   *
   * Call the {@link RtcEngine#setExternalVideoSource setExternalVideoSource} method and
   * set `pushMode` as `true` before calling this method. Otherwise, a failure returns after calling
   * this method.
   *
   * @note
   * You can push the video frame either by calling this method or by calling {@link
   * pushExternalVideoFrame(VideoFrame frame) pushExternalVideoFrame(VideoFrame frame)}. For
   * textured video frames, Agora recommends using the {@link pushExternalVideoFrame(VideoFrame
   * frame) pushExternalVideoFrame(VideoFrame frame)} method, so that the SDK can better utilize the
   * hardware performance.
   *
   * @param frame Video frame to be pushed. See {@link io.agora.rtc2.video.AgoraVideoFrame
   * AgoraVideoFrame}.
   * @note
   * In the `COMMUNICATION` profile, the SDK does not support textured video frames.
   * @return
   * - `true`: The frame is pushed successfully.
   * - `false`: Failed to push the frame.
   */
  @Deprecated public abstract boolean pushExternalVideoFrame(AgoraVideoFrame frame);

  /**
   * Pushes the video frame using the `VideoFrame` class and passes the video frame to the Agora
   * SDK.
   *
   * Call the {@link RtcEngine#setExternalVideoSource setExternalVideoSource} method and
   * set `pushMode` as `true` before calling this method. Otherwise, a failure returns after calling
   * this method.
   *
   * @note
   * You can push the video frame either by calling this method or by calling {@link
   * pushExternalVideoFrame(AgoraVideoFrame frame) pushExternalVideoFrame(AgoraVideoFrame frame)}.
   * For textured video frames, Agora recommends using the {@link pushExternalVideoFrame(VideoFrame
   * frame) pushExternalVideoFrame(VideoFrame frame)} method, so that the SDK can better utilize the
   * hardware performance.
   *
   * @param frame Video frame to be pushed. See {@link VideoFrame VideoFrame}:
   * - `buffer`: *Buffer* The buffer of the video frame.
   * - `rotation`: *int* Rotation of the video frame in degrees.
   * - `timestampNs`: *long* Timestamp of the video frame in nanoseconds.
   * @note
   * In the `COMMUNICATION` profile, the SDK does not support textured video frames.
   * @return
   * - `true`: The frame is pushed successfully.
   * - `false`: Failed to push the frame.
   */
  public abstract boolean pushExternalVideoFrame(VideoFrame frame);

  /**
   * Pushes the encoded external video frame to Agora SDK.
   *
   * @note
   * Ensure that you have configured encoded video source before calling this method.
   *
   * @param data The encoded external video data, which must be the direct buffer.
   * @param frameInfo The encoded external video frame info: {@link
   *     io.agora.rtc2.video.EncodedVideoFrameInfo
   * EncodedVideoFrameInfo}.
   * @return
   * - 0: Success, which means that the encoded external video frame is pushed successfully.
   * - < 0: Failure, which means that the encoded external video frame fails to be pushed.
   */
  public abstract int pushExternalEncodedVideoFrame(
      ByteBuffer data, EncodedVideoFrameInfo frameInfo);

  /**
   * Checks whether texture encoding is supported.
   *
   * @return True/False.
   */
  public abstract boolean isTextureEncodeSupported();

  /**
   * Registers an audio frame observer object.
   *
   * @note Call this method before calling `joinChannel`.
   *
   * @param observer The IAudioFrameObserver interface, null means unregistering observer instead.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int registerAudioFrameObserver(IAudioFrameObserver observer);

  /**
   * Registers an encoded audio frame observer object.
   *
   * @note
   * Ensure that you call this method before joining the channel.
   *
   * @param observer The IAudioEncodedFrameObserver interface, null means unregistering observer
   *     instead.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int registerAudioEncodedFrameObserver(
      AudioEncodedFrameObserverConfig config, IAudioEncodedFrameObserver observer);

  /**
   * Sets the audio recording format for the
   * {@link io.agora.rtc2.IAudioFrameObserver#onRecordAudioFrame onRecordAudioFrame} callback.
   *
   * @param sampleRate Sets the sample rate (`samplesPerSec`) returned in the
   * `onRecordAudioFrame` callback, which can be set as 8000, 16000, 32000, 44100, or
   * 48000 Hz.
   * @param channel Sets the number of audio channels (channels) returned in the
   * `onRecordAudioFrame` callback:
   * - 1: Mono.
   * - 2: Stereo.
   * @param mode Sets the use mode of the onRecordAudioFrame callback:
   * - `RAW_AUDIO_FRAME_OP_MODE_READ_ONLY(0)`: Read-only mode: Users only read the
   * audio data without modifying anything. For example, when users acquire the data
   * with the Agora SDK then push the RTMP streams.
   * - `RAW_AUDIO_FRAME_OP_MODE_WRITE_ONLY(1)`: Write-only mode: Users replace the
   * audio data with their own data and pass the data to the SDK for encoding.
   * For example, when users acquire the data.
   * - `RAW_AUDIO_FRAME_OP_MODE_READ_WRITE(2)`: Read and write mode: Users read the
   * data from AudioFrame, modify it, and then play it. For example, when users have
   * their own sound-effect processing module and perform some voice pre-processing,
   * such as a voice change.
   * @param samplesPerCall Sets the number of samples the `onRecordAudioFrame` callback returns.
   * In RTMP streaming scenarios, set it as 1024.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *
   * @note
   * The SDK calculates the sample interval according to the value of the `sampleRate`,
   * `channel`, and `samplesPerCall` parameters you set in this method.
   * Sample interval (s) = samplePerCall/(sampleRate × channel). Ensure that the value
   * of sample interval >= 0.01. The SDK triggers the `onRecordAudioFrame` callback according
   * to the sample interval.
   */
  public abstract int setRecordingAudioFrameParameters(
      int sampleRate, int channel, int mode, int samplesPerCall);

  /**
   * Sets the audio recording format for the
   * {@link io.agora.rtc2.IAudioFrameObserver#onPlaybackAudioFrame onPlaybackAudioFrame} callback.
   *
   * @param sampleRate Sets the sample rate (`samplesPerSec`) returned in the
   * `onPlaybackAudioFrame` callback, which can be set as 8000, 16000, 32000, 44100, or
   * 48000 Hz.
   * @param channel Sets the number of audio channels (channels) returned in the
   * `onPlaybackAudioFrame` callback:
   * - 1: Mono.
   * - 2: Stereo.
   * @param mode Sets the use mode of the onPlaybackAudioFrame callback:
   * - `RAW_AUDIO_FRAME_OP_MODE_READ_ONLY(0)`: Read-only mode: Users only read the
   * audio data without modifying anything. For example, when users acquire the data
   * with the Agora SDK then push the RTMP streams.
   * - `RAW_AUDIO_FRAME_OP_MODE_WRITE_ONLY(1)`: Write-only mode: Users replace the
   * audio data with their own data and pass the data to the SDK for encoding.
   * For example, when users acquire the data.
   * - `RAW_AUDIO_FRAME_OP_MODE_READ_WRITE(2)`: Read and write mode: Users read the
   * data from AudioFrame, modify it, and then play it. For example, when users have
   * their own sound-effect processing module and perform some voice pre-processing,
   * such as a voice change.
   * @param samplesPerCall Sets the number of samples the `onPlaybackAudioFrame` callback returns.
   * In RTMP streaming scenarios, set it as 1024.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *
   * @note
   * The SDK calculates the sample interval according to the value of the `sampleRate`,
   * `channel`, and `samplesPerCall` parameters you set in this method.
   * Sample interval (s) = samplePerCall/(sampleRate × channel). Ensure that the value
   * of sample interval >= 0.01. The SDK triggers the `onPlaybackAudioFrame` callback according
   * to the sample interval.
   */
  public abstract int setPlaybackAudioFrameParameters(
      int sampleRate, int channel, int mode, int samplesPerCall);

  /**
   * Sets the mixed audio format for the
   * {@link io.agora.rtc2.IAudioFrameObserver#onMixedAudioFrame onMixedAudioFrame} callback.
   * @param sampleRate Sets the sample rate (`samplesPerSec`) returned in the
   * `onMixedAudioFrame` callback, which can be set as 8000, 16000, 32000, 44100, or
   * 48000 Hz.
   * @param channel Sets the number of audio channels (channels) returned in the
   * `onPlaybackAudioFrame` callback:
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerCall Sets the number of samples the `onMixedAudioFrame` callback returns.
   * In RTMP streaming scenarios, set it as 1024.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *
   * @note
   * The SDK calculates the sample interval according to the value of the `sampleRate`
   * and `samplesPerCall` parameters you set in this method.
   * Sample interval (s) = samplePerCall/(sampleRate × channel). Ensure that the value
   * of sample interval >= 0.01. The SDK triggers the `onMixedAudioFrame` callback according
   * to the sample interval.
   */
  public abstract int setMixedAudioFrameParameters(int sampleRate, int channel, int samplesPerCall);

  /**
   * Adds a watermark image to the local video.
   *
   * @deprecated From v2.9.1. We recommend using the {@link RtcEngine#addVideoWatermark(String,
   *     WatermarkOptions) addVideoWatermark}2 method instead.
   *
   * This method adds a PNG watermark image to the local video stream for the sampling device,
   * channel audience, or CDN live audience to see and capture. To add the PNG file to a CDN live
   * publishing stream, see the {@link RtcEngine#setLiveTranscoding(LiveTranscoding)
   * setLiveTranscoding} method.
   *
   * @param watermark Watermark image to be added to the local video stream. See {@link
   *     io.agora.rtc.video.AgoraImage Agora Image}.
   * @note
   * <ul>
   *     <li>The URL descriptions are different for the local video and CDN live streams:
   *       <ul>
   *         <li>In a local video stream, @p url in {@link io.agora.rtc.video.AgoraImage Agora
   * Image} refers to the absolute path of the added watermark image file in the local video
   * stream.</li> <li>In a CDN live stream, @p url in {@link io.agora.rtc.video.AgoraImage Agora
   * Image} refers to the address of the added watermark image in the CDN live streaming.</li>
   *      </ul>
   *     <li>The source file of the watermark image must be in the PNG file format. If the width and
   * height of the PNG file differ from your settings in this method, the PNG file is cropped to
   * conform to your settings. <li>The Agora SDK supports adding only one watermark image onto a
   * local video or CDN live stream. The newly added watermark image replaces the previous one.
   *     <li>If you set @p orientationMode as Adaptive in the {@link
   * RtcEngine#setVideoEncoderConfiguration setVideoEncoderConfiguration} method, the watermark
   * image rotates with the video frame around the upper left corner of the watermark image.
   * </ul>
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  @Deprecated public abstract int addVideoWatermark(AgoraImage watermark);

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
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int addVideoWatermark(String watermarkUrl, WatermarkOptions options);

  /**
   * Removes the watermark image from the video stream added by {@link
   * RtcEngine#addVideoWatermark(String watermarkUrl, WatermarkOptions options) addVideoWatermark}.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int clearVideoWatermarks();

  /**
   * switch to another channel added by {@link
   * RtcEngine#switchChannel(String token, String channelName) switchChannel}.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int switchChannel(String token, String channelName);
  /**
   * Sets the priority of a remote user's media stream.
   *
   * @since v2.4.0.
   *        <p>
   *        Use this method with the
   *        {@link RtcEngine#setRemoteSubscribeFallbackOption
   *        setRemoteSubscribeFallbackOption} method. If the fallback function is
   *        enabled for a subscribed stream, the SDK ensures the high-priority
   *        user gets the best possible stream quality.
   *
   * @note The SDK supports setting userPriority as high for one user only.
   *
   * @param uid          The ID of the remote user.
   * @param userPriority The priority of the remote user:
   *                     <ul>
   *                     <li>{@link Constants#USER_PRIORITY_HIGH
   *                     USER_PRIORITY_HIGH(50)}: the user's priority is high.
   *                     <li>{@link Constants#USER_PRIORITY_NORANL
   *                     USER_PRIORITY_NORANL(100)}: (default) the user's priority
   *                     is normal.
   *                     </ul>
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int setRemoteUserPriority(int uid, int userPriority);

  /**
   * Sets the fallback option for the locally published video stream based on the network
   * conditions.
   *
   * If @p option is set as {@link io.agora.rtc.Constants#STREAM_FALLBACK_OPTION_AUDIO_ONLY
   * STREAM_FALLBACK_OPTION_AUDIO_ONLY(2)}, the SDK will: <ul> <li>Disable the upstream video but
   * enable audio only when the network conditions deteriorate and cannot support both video and
   * audio. <li>Re-enable the video when the network conditions improve.
   * </ul>
   * When the locally published video stream falls back to audio only or when the audio-only stream
   * switches back to the video, the SDK triggers the {@link
   * IRtcEngineEventHandler#onLocalPublishFallbackToAudioOnly(boolean)
   * onLocalPublishFallbackToAudioOnly}.
   *
   * Ensure that you call this method before joining a channel.
   *
   * @param option The fallback option for the locally published video stream:
   *               - {@link io.agora.rtc.Constants#STREAM_FALLBACK_OPTION_DISABLED
   * STREAM_FALLBACK_OPTION_DISABLED(0)}: (Default) No fallback behavior for the locally published
   * video stream when the uplink network condition is poor. The stream quality is not guaranteed.
   *               - {@link io.agora.rtc.Constants#STREAM_FALLBACK_OPTION_AUDIO_ONLY
   * STREAM_FALLBACK_OPTION_AUDIO_ONLY(2)}: The locally published video stream falls back to audio
   * only when the uplink network condition is poor.
   * @note Agora does not recommend using this method for CDN live streaming, because the remote CDN
   * live user will have a noticeable lag when the locally published video stream falls back to
   * audio only.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setLocalPublishFallbackOption(int option);

  /**
   * Sets the fallback option for the remotely subscribed video stream based on the network
   * conditions.
   *
   * If @p option is set as {@link io.agora.rtc.Constants#STREAM_FALLBACK_OPTION_AUDIO_ONLY
   * STREAM_FALLBACK_OPTION_AUDIO_ONLY(2)}, the SDK automatically switches the video from a
   * high-stream to a low-stream, or disables the video when the downlink network condition cannot
   * support both audio and video to guarantee the quality of the audio. The SDK monitors the
   * network quality and restores the video stream when the network conditions improve. When the
   * remotely subscribed video stream falls back to audio only, or the audio-only stream switches
   * back to the video, the SDK triggers the {@link
   * IRtcEngineEventHandler#onRemoteSubscribeFallbackToAudioOnly(int, boolean)
   * onRemoteSubscribeFallbackToAudioOnly} callback.
   *
   * Ensure that you call this method before joining a channel.
   *
   * @param option The fallback option for the remotely subscribed video stream:
   *               - {@link io.agora.rtc.Constants#STREAM_FALLBACK_OPTION_DISABLED
   * STREAM_FALLBACK_OPTION_DISABLED(0)}: No fallback behavior for the remotely subscribed video
   * stream when the downlink network condition is poor. The quality of the video stream is not
   * guaranteed.
   *               - {@link io.agora.rtc.Constants#STREAM_FALLBACK_OPTION_VIDEO_STREAM_LOW
   * STREAM_FALLBACK_OPTION_VIDEO_STREAM_LOW(1)}: (Default) The remotely subscribed video stream
   * falls back to the low-stream video when the downlink network condition worsens. This option
   * works only for this method and not for the {@link
   * io.agora.rtc.RtcEngine#setLocalPublishFallbackOption(int) setLocalPublishFallbackOption}
   * method.
   *               - {@link io.agora.rtc.Constants#STREAM_FALLBACK_OPTION_AUDIO_ONLY
   * STREAM_FALLBACK_OPTION_AUDIO_ONLY(2)}: Under poor downlink network conditions, the remotely
   * subscribed video stream first falls back to the low-stream video; and then to an audio-only
   * stream if the network condition worsens.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteSubscribeFallbackOption(int option);

  /**
   * Enables or disables the dual video stream mode.
   *
   * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
   * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video
   * stream) video using {@link setRemoteVideoStreamType setRemoteVideoStreamType}.
   *
   * @param enabled
   * - true: Enable the dual-stream mode.
   * - false: (default) Disable the dual-stream mode.
   */
  public abstract int enableDualStreamMode(boolean enabled);

  /**
   * Enables or disables the dual video stream mode.
   *
   * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
   * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video
   * stream) video using {@link setRemoteVideoStreamType setRemoteVideoStreamType}.
   *
   * @param sourceType
   * - The video source type.
   * @param enabled
   * - true: Enable the dual-stream mode.
   * - false: (default) Disable the dual-stream mode.
   */
  public abstract int enableDualStreamMode(Constants.VideoSourceType sourceType, boolean enabled);

  /**
   * Enables or disables the dual video stream mode.
   *
   * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
   * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video
   * stream) video using {@link setRemoteVideoStreamType setRemoteVideoStreamType}.
   *
   * @param sourceType
   * - The video source type.
   * @param enabled
   * - true: Enable the dual-stream mode.
   * - false: (default) Disable the dual-stream mode.
   * @param streamConfig
   * - The minor stream config
   */
  public abstract int enableDualStreamMode(
      Constants.VideoSourceType sourceType, boolean enabled, SimulcastStreamConfig streamConfig);

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
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteVideoStreamType(int uid, int streamType);

  /**
   * Sets the default stream type of the remote video if the remote user has enabled dual-stream.
   *
   * @param streamType Sets the default video stream type:
   * - 0: High-stream video.
   * - 1: Low-stream video.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setRemoteDefaultVideoStreamType(int streamType);

  /**
   * <p>
   * Specifies an encryption password to enable built-in encryption before joining
   * a channel.
   *
   * @deprecated This method is deprecated.
   *
   * <p>
   * All users in a channel must set the same encryption password. The encryption
   * password is automatically cleared once a user has left the channel. If the
   * encryption password is not specified or set to empty, the encryption function
   * will be disabled.
   *
   * <p>
   * Note: Do not use this function together with CDN.
   *
   * @param secret Encryption Password
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   *
   */
  @Deprecated public abstract int setEncryptionSecret(String secret);

  /**
   * <p>
   * Sets the built-in encryption mode.
   *
   * @deprecated This method is deprecated.
   *
   * <p>
   * The Agora Native SDK supports built-in encryption.
   * Call this API to set the encryption mode.
   * <p>
   * All users in the same channel must use the same encryption mode and password.
   * Refer to information related to the encryption algorithm on the differences
   * between encryption modes.
   * <p>
   * Call {@link RtcEngine#setEncryptionSecret(String secret) setEncryptionSecret}
   * to enable the built-in encryption function before calling this API.
   *
   * <p>
   * Note: Do not use this function together with CDN.
   *
   * @param encryptionMode Encryption mode:
   *                       <ul>
   *                       <li>"sm4-128-ecb": 128-bit SM4 encryption, ECB mode
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   *
   */
  @Deprecated public abstract int setEncryptionMode(String encryptionMode);

  /**
   * Enables/Disables the built-in encryption.
   *
   * In scenarios requiring high security, Agora recommends calling `enableEncryption` to enable the
   * built-in encryption before joining a channel.
   *
   * All users in the same channel must use the same encryption mode and encryption key. Once all
   * users leave the channel, the encryption key of this channel is automatically cleared.
   *
   * @note
   * - If you enable the built-in encryption, you cannot use the RTMP streaming function.
   * @param enabled Whether to enable the built-in encryption.
   *                - `true`: Enable the built-in encryption.
   *                - `false`: Disable the built-in encryption.
   * @param config Configurations of built-in encryption schemas. See {@link
   * io.agora.rtc2.internal.EncryptionConfig EncryptionConfig}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - -2(ERR_INVALID_ARGUMENT): An invalid parameter is used. Set the parameter with a valid
   * value.
   *   - -7(ERR_NOT_INITIALIZED: The SDK is not initialized. Initialize the IRtcEngine instance
   * before calling this method.
   *   - -4(ERR_NOT_SUPPORTED): The encryption mode is incorrect or the SDK fails to load the
   * external encryption library. Check the enumeration or reload the external encryption library.
   */
  public abstract int enableEncryption(boolean enabled, EncryptionConfig config);

  /**
   * <p>
   * Adds a URL address of the added stream into the live broadcast channel.
   *
   * <p>
   * If successful, you can find the stream in the channels of argus and the uid
   * of the stream is 666.
   *
   * @param url    URL address to be added into the ongoing live broadcast. You
   *               can use the RTMP, HLS, and FLV live streaming protocols.
   * @param config {@link LiveInjectStreamConfig}
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  /**
   * Removes the URL from the live broadcast.
   *
   * @param url URL address of the added stream to be removed.
   */
  public abstract int removeInjectStreamUrl(String url);

  /**
   * <p>
   * Adds the URL to which the host publishes the stream.
   *
   * <p>
   * Used in CDN live only.
   *
   * @param url                URL to which the host publishes the stream.
   * @param transcodingEnabled Whether transcoding is enabled. True/False.
   */
  public abstract int addPublishStreamUrl(String url, boolean transcodingEnabled);

  /**
   *
   * <p>
   * Removes the URL to which the host publishes the stream.
   *
   * <p>
   * Used in CDN live only.
   *
   * <p>
   * Note:
   * <ul>
   * <li>This method only removes one URL each time it is called.</li>
   * <li>Do not add special characters such as Chinese to the URL.</li>
   * </ul>
   *
   *
   * @param url URL to which the host publishes the stream.
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   *
   */
  public abstract int removePublishStreamUrl(String url);

  /**
   * <p>
   * Sets the video layout and audio for CDN Live.
   *
   * <p>
   * Used in CDN live only.
   *
   * @param transcoding {@link LiveTranscoding}
   */
  public abstract int setLiveTranscoding(LiveTranscoding transcoding);

  /**
   * Creates a data stream.
   *
   * You can call this method to create a data stream and improve the
   * reliability and ordering of data transmission.
   *
   * @note
   * - Ensure that you set the same value for `reliable` and `ordered`.
   * - Each user can only create a maximum of 5 data streams during an {@link RtcEngine}
   * lifecycle.
   * - The data channel allows a data delay of up to 5 seconds. If the receiver
   * does not receive the data stream within 5 seconds, the data channel reports
   * an error.
   *
   * @param reliable Sets whether the recipients are guaranteed to receive
   * the data stream from the sender within five seconds:
   * - true: The recipients receive the data stream from the sender within
   * five seconds. If the recipient does not receive the data stream within
   * five seconds, an error is reported to the application.
   * - false: There is no guarantee that the recipients receive the data stream
   * within five seconds and no error message is reported for any delay or
   * missing data stream.
   * @param ordered Sets whether the recipients receive the data stream
   * in the sent order:
   * - true: The recipients receive the data stream in the sent order.
   * - false: The recipients do not receive the data stream in the sent order.
   * @return
   * - Returns the stream ID, if the method call is successful.
   * - <0: Failure.
   *
   */
  public abstract int createDataStream(boolean reliable, boolean ordered);

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
  public abstract int createDataStream(DataStreamConfig config);

  /**
   * Sends a data stream.
   *
   * After calling {@link RtcEngine#createDataStream() createDataStream}, you can call
   * this method to send a data stream to all users in the channel.
   *
   * The SDK has the following restrictions on this method:
   * - Up to 60 packets can be sent per second in a channel with each packet having a maximum size
   * of 1 KB.
   * - Each client can send up to 30 KB of data per second.
   * - Each user can have up to five data streams simultaneously.
   *
   * After the remote user receives the data stream within 5 seconds, the SDK triggers the {@link
   * IRtcEngineEventHandler#onStreamMessage() onStreamMessage} callback on the remote client. After
   * the remote user does not receive the data stream within 5 seconds, the SDK triggers the {@link
   * IRtcEngineEventHandler#onStreamMessageError() onStreamMessageError} callback.
   *
   * @note
   * - Call this method after calling {@link RtcEngine#createDataStream() createDataStream}.
   * - This method applies only to the `COMMUNICATION` profile or to the hosts in the
   * `LIVE_BROADCASTING` profile. If an audience in the `LIVE_BROADCASTING` profile calls this
   * method, the audience may be switched to a host.
   *
   * @param streamId ID of the sent data stream returned by the {@link
   * RtcEngine#createDataStream(boolean reliable, boolean ordered) createDataStream} method.
   * @param message Sent data.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int sendStreamMessage(int streamId, byte[] message);

  /**
   * Sets the video quality preferences.
   *
   * @param preferFrameRateOverImageQuality The video preference to be set:
   *                                        <ul>
   *                                        <li>True: Frame rate over image
   *                                        quality
   *                                        <li>False: Image quality over frame
   *                                        rate (default)
   *                                        </ul>
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int setVideoQualityParameters(boolean preferFrameRateOverImageQuality);

  /**
   * Sets the local video mirror mode.
   *
   * Use this method before calling the {@link startPreview startPreview} method, or the mirror mode
   * does not take effect until you call the `startPreview` method again.
   * @param mirrorMode Sets the local video mirror mode:
   * - `VIDEO_MIRROR_MODE_AUTO(0)`: (Default) The mirror mode determined by the SDK.
   * If you use the front camera, the SDK enables the mirror mode;
   * if you use the rear camera, the SDK disables the mirror mode.
   * - `VIDEO_MIRROR_MODE_ENABLED(1)`: Enable the mirror mode.
   * - `VIDEO_MIRROR_MODE_DISABLED(2)`: Disable the mirror mode.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  @Deprecated public abstract int setLocalVideoMirrorMode(int mode);

  /**
   * Gets the recommended encoder type.
   * @deprecated This method is deprecated.
   *
   * @return The encoder type:
   * <ul>
   *     <li>{@link Constants#HARDWARE_ENCODER HARDWARE ENCODER(1)}: The hardware encoder.</li>
   *     <li>{@link Constants#SOFTWARE_ENCODER SOFTWARE ENCODER(2)}: The software encoder.</li>
   * </ul>
   */
  @Deprecated
  public static int getRecommendedEncoderType() {
    return DeviceUtils.getRecommendedEncoderType();
  }

  /**
   * Switches between front and rear cameras.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int switchCamera();

  /**
   * Checks whether the camera zoom function is supported.
   *
   * @return
   * - true: The camera zoom function is supported.
   * - false: The camera zoom function is not supported.
   */
  public abstract boolean isCameraZoomSupported();

  /**
   * Checks whether the camera flash function is supported.
   *
   * @return
   * - true: The camera flash function is supported.
   * - false: The camera flash function is not supported.
   */
  public abstract boolean isCameraTorchSupported();

  /**
   * Checks whether the camera manual focus function is supported.
   *
   * @return
   * - true: The camera manual focus function is supported.
   * - false: The camera manual focus function is not supported.
   */
  public abstract boolean isCameraFocusSupported();

  /**
   * Checks whether the camera exposure function is supported.
   *
   * Ensure that you call this method after the camera starts, for example, by calling
   * `startPreview` or `joinChannel`.
   *
   * @since v2.3.2.
   * @return
   * <ul>
   *     <li>true: The device supports the camera exposure function.</li>
   *     <li>false: The device does not support the camera exposure function.</li>
   * </ul>
   */
  public abstract boolean isCameraExposurePositionSupported();

  /**
   * Checks whether the camera auto focus function is supported.
   *
   * @return
   * - true: The camera auto focus function is supported.
   * - false: The camera auto focus function is not supported.
   */
  public abstract boolean isCameraAutoFocusFaceModeSupported();

  /**
   * Checks whether the camera face detect function is supported.
   *
   * @return
   * - true: The camera face detect is supported.
   * - false: The camera face detect is not supported.
   */
  public abstract boolean isCameraFaceDetectSupported();

  /**
   * Sets the camera zoom ratio.
   *
   * @param factor The camera zoom factor. It ranges from 1.0 to the maximum zoom
   * supported by the camera.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setCameraZoomFactor(float factor);

  /**
   * Gets the maximum zoom ratio supported by the camera.
   * @return The maximum zoom ratio supported by the camera.
   */
  public abstract float getCameraMaxZoomFactor();

  /**
   * Sets the manual focus position.
   *
   * @param positionX The horizontal coordinate of the touch point in the view.
   * @param positionY The vertical coordinate of the touch point in the view.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setCameraFocusPositionInPreview(float positionX, float positionY);

  /**
   * Sets the camera exposure position.
   *
   * Ensure that you call this method after the camera starts, for example, by calling
   * `startPreview` or `joinChannel`.
   *
   * A successful setCameraExposurePosition method call triggers the
   * {@link IRtcEngineEventHandler#onCameraExposureAreaChanged onCameraExposureAreaChanged} callback
   * on the local client.
   * @since v2.3.2.
   * @param positionXinView The horizontal coordinate of the touch point in the view.
   * @param positionYinView The vertical coordinate of the touch point in the view.
   *
   * @return
   * <ul>
   *     <li>0: Success.</li>
   *     <li>< 0: Failure.</li>
   * </ul>
   */
  public abstract int setCameraExposurePosition(float positionXinView, float positionYinView);

  /**
   * Enables the camera face detect.
   *
   * @param enabled Determines whether to enable the camera face detect.
   * - true: Enable the face detect.
   * - false: Do not enable the face detect.
   */
  public abstract int enableFaceDetection(boolean enabled);

  /**
   * Enables the camera flash.
   *
   * @param isOn Determines whether to enable the camera flash.
   * - true: Enable the flash.
   * - false: Do not enable the flash.
   */
  public abstract int setCameraTorchOn(boolean isOn);

  /**
   * Enables the camera auto focus face function.
   *
   * @param enabled Determines whether to enable the camera auto focus face mode.
   * - true: Enable the auto focus face function.
   * - false: Do not enable the auto focus face function.
   */
  public abstract int setCameraAutoFocusFaceModeEnabled(boolean enabled);

  /**
   * Gets the current call ID.
   *
   * When a user joins a channel on a client, a `callId` is generated to identify
   * the call.
   *
   * After a call ends, you can call `rate` or `complain` to gather feedback from the customer.
   * These methods require a `callId` parameter. To use these feedback methods, call the this
   * method first to retrieve the `callId` during the call, and then pass the value as an
   * argument in the `rate` or `complain` method after the call ends.
   *
   * @return
   * - The call ID if the method call is successful.
   * - < 0: Failure.
   */
  public abstract String getCallId();

  /**
   * Allows a user to rate the call.
   *
   * It is usually called after the call ends.
   *
   * @param callId The call ID retrieved from the {@link getCallId getCallId} method.
   * @param rating The rating of the call between 1 (the lowest score) to 5 (the highest score).
   * @param description (Optional) The description of the rating. The string length must be less
   * than 800 bytes.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int rate(String callId, int rating, String description);

  /**
   * Allows a user to complain about the call quality.
   *
   * This method is usually called after the call ends.
   *
   * @param callId The call ID retrieved from the `getCallId` method.
   * @param description (Optional) The description of the complaint. The string length must be less
   *     than
   * 800 bytes.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int complain(String callId, String description);

  /**
   * Gets the SDK version.
   * @return The version of the current SDK in the string format.
   */
  public static String getSdkVersion() {
    if (!RtcEngineImpl.initializeNativeLibs())
      return "";
    return RtcEngineImpl.nativeGetSdkVersion();
  }

  /**
   * license verify and return the result.
   *
   * @return
   * - 0:   Success.
   * - < 0: Failure.
   */
  public static int getCertificateVerifyResult(
      String credential, int credentialLen, String certificate, int certificateLen) {
    if (!RtcEngineImpl.initializeNativeLibs())
      return -1;
    return RtcEngineImpl.nativeGetCertificateVerifyResult(
        credential, credentialLen, certificate, certificateLen);
  }

  /**
   * Returns the media engine version.
   *
   * @return The string of the version number in char format.
   */
  @Deprecated
  public static String getMediaEngineVersion() {
    if (!RtcEngineImpl.initializeNativeLibs())
      return "";
    return RtcEngineImpl.nativeGetChatEngineVersion();
  }

  /**
   * Specifies an SDK output log file.
   *
   * The log file records all log data for the SDK’s operation. Ensure that the
   * directory for the log file exists and is writable.
   *
   * @note
   * Ensure that you call this method immediately after {@link create create},
   * or the output log may not be complete.
   *
   * @param filePath File path of the log file. The string of the log file is in UTF-8.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setLogFile(String filePath);

  /**
   * Sets the output log filter level of the SDK.
   *
   * You can use one or a combination of the filters. The log level follows the
   * sequence of `OFF`, `CRITICAL`, `ERROR`, `WARNING`, `INFO`, and `DEBUG`. Choose a level
   * and you will see logs preceding that level. For example, if you set the log level to
   * `WARNING`, you see the logs within levels `CRITICAL`, `ERROR`, and `WARNING`.
   *
   * @param filter Sets the log filter level:
   * - `LOG_FILTER_DEBUG(0x80f)`: Output all API logs. Set your log filter as DEBUG
   * if you want to get the most complete log file.
   * - `LOG_FILTER_INFO(0x0f)`: Output logs of the CRITICAL, ERROR, WARNING, and INFO
   * level. We recommend setting your log filter as this level.
   * - `LOG_FILTER_WARNING(0x0e)`: Output logs of the CRITICAL, ERROR, and WARNING level.
   * - `LOG_FILTER_ERROR(0x0c)`: Output logs of the CRITICAL and ERROR level.
   * - `LOG_FILTER_CRITICAL(0x08)`: Output logs of the CRITICAL level.
   * - `LOG_FILTER_OFF(0)`: Do not output any log.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setLogFilter(int filter);

  /**
   * Sets the output log level of the SDK.
   *
   * You can use one of the level defined in LogLevel.
   *
   * @param level Sets the log level:
   * {@link Constants.LogLevel LogLevel}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setLogLevel(int level);

  /**
   * Sets the log file size (KB).
   *
   * The SDK has two log files, each with a default size of 512 KB. If you set
   * `fileSizeInBytes` as 1024 KB, the SDK outputs log files with a total
   * maximum size of 2 MB.
   * If the total size of the log files exceed the set value,
   * the new output log files overwrite the old output log files.
   *
   * @param fileSizeInKBytes The SDK log file size (KB).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setLogFileSize(long fileSizeInKBytes);

  /**
   * Upload current log file immediately to server.
   *  only use this when an error occurs
   *  block before log file upload success or timeout.
   *
   *  @return
   *  - 0: Success.
   *  - < 0: Failure.
   */
  public abstract String uploadLogFile();

  /**
   * <p>
   * Returns the native handler of the SDK Engine.
   *
   * <p>
   * This interface is used to get native the C++ handler of the SDK engine that
   * can be used in special scenarios, such as register the audio and video frame
   * observer.
   *
   * @return
   */
  public abstract long getNativeHandle();

  /**
   * Adds the IRtcEngineEventHandler.
   *
   * @param handler The IRtcEngineEventHandler instance.
   */
  public void addHandler(IRtcEngineEventHandler handler) {
    mInstance.addHandler((IAgoraEventHandler) handler);
  }

  /**
   * Removes the specified IRtcEngineEventHandler object.
   *
   * For callback events that you only want to listen for once, call this method to remove
   * subsequent IRtcEngineEventHandler objects after you have received them. This interface is used
   * to remove the specific IRtcEngineEventHandler interface class instance.
   * @param handler The IRtcEngineEventHandler object.
   */
  public void removeHandler(IRtcEngineEventHandler handler) {
    mInstance.removeHandler((IAgoraEventHandler) handler);
  }

  /**
   * Enables the Wi-Fi mode.
   * @deprecated This method is deprecated.
   * @param enable Whether to enable/disable the Wi-Fi mode:
   *               - `true`: Enable the Wi-Fi mode.
   *               - `false`: Disable the Wi-Fi mode.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  @Deprecated public abstract boolean enableHighPerfWifiMode(boolean enable);

  /**
   * Gets the warning or error description.
   *
   * @param error The warning or error code.
   * @return The detailed warning or error description.
   */
  public static String getErrorDescription(int error) {
    if (!RtcEngineImpl.initializeNativeLibs())
      return "";
    return RtcEngineImpl.nativeGetErrorDescription(error);
  }

  /**
   * Monitors external headset device events.
   *
   * @param monitor Whether to enable monitoring external headset device events.
   *                True/False.
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  @Deprecated public abstract void monitorHeadsetEvent(boolean monitor);

  /**
   * Monitors Bluetooth headset device events.
   *
   * @param monitor Whether to enable monitoring Bluetooth headset device events.
   *                True/False.
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  @Deprecated public abstract void monitorBluetoothHeadsetEvent(boolean monitor);

  /**
   * Sets the default audio route to the headset.
   *
   * @deprecated This method is deprecated.
   * @param enabled Sets whether or not the default audio route is to the headset:
   * <ul>
   *     <li>true: Set the default audio route to the headset.</li>
   *     <li>false: Do not set the default audio route to the headset.</li>
   * </ul>
   */
  @Deprecated public abstract void setPreferHeadset(boolean enabled);

  /**
   * <p>
   * Provides technical preview functionalities or special customizations by
   * configuring the SDK with JSON options.
   *
   * <p>
   * The JSON options are not public by default. Agora is working on making
   * commonly used JSON options public in a standard way.
   *
   * @param parameters Parameter to be set as a JSON string in the specified
   *                   format.
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int setParameters(String parameters);

  /**
   * Gets the Agora SDK’s parameters for customization purposes.
   * This method is not disclosed yet. Contact <a
   * href="mailto:support@agora.io">support@agora.io</a> for more information.
   *
   */
  public abstract String getParameter(String parameter, String args);

  /**
   * Registers the metadata observer.
   *
   * You need to implement the IMetadataObserver class and specify the metadata type in this method.
   * This method enables you to add synchronized metadata in the video stream for more diversified
   * live interactive streaming, such as sending shopping links, digital coupons, and online
   * quizzes.
   *
   * A successful call of this method triggers the {@link
   * io.agora.rtc2.IMetadataObserver#getMaxMetadataSize() getMaxMetadataSize} callback.
   *
   * @note
   * - Call this method before the `joinChannel` method.
   * - This method applies to the Live Broadcast profile.
   *
   * @param observer The IMetadataObserver class.
   * @param type The metadata type. Currently, the SDK supports {@link
   * io.agora.rtc2.IMetadataObserver#VIDEO_METADATA VIDEO_METADATA(0)} only.
   *     - {@link io.agora.rtc2.IMetadataObserver#UNKNOWN_METADATA UNKNOWN_METADATA(-1)}: the
   * metadata type is unknown.
   *     - {@link io.agora.rtc2.IMetadataObserver#VIDEO_METADATA VIDEO_METADATA(0)}: the metadata
   * type is video.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *
   */
  public abstract int registerMediaMetadataObserver(IMetadataObserver observer, int type);

  /**
   * Unregisters the metadata observer.
   *
   * @param observer The IMetadataObserver class.
   * @param type The metadata type. Currently, the SDK supports {@link
   * io.agora.rtc2.IMetadataObserver#VIDEO_METADATA VIDEO_METADATA(0)} only.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *
   */
  public abstract int unregisterMediaMetadataObserver(IMetadataObserver observer, int type);

  /**
   * Starts to relay media streams across channels.
   *
   * After a successful method call, the SDK triggers the {@link
   * IRtcEngineEventHandler#onChannelMediaRelayStateChanged onChannelMediaRelayStateChanged} and
   * {@link IRtcEngineEventHandler#onChannelMediaRelayEvent onChannelMediaRelayEvent} callbacks, and
   * these callbacks return the state and events of the media stream relay.
   * - If the `onChannelMediaRelayStateChanged` callback returns `RELAY_STATE_RUNNING(2)` and
   * `RELAY_OK(0)`, and the `onChannelMediaRelayEvent` callback returns
   * `RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL(4)`, the SDK starts relaying media streams between the
   * original and the destination channel.
   * - If the `onChannelMediaRelayStateChanged` callback returns `RELAY_STATE_FAILURE(3)`, an
   * exception occurs during the media stream relay.
   *
   * @note
   * - Contact sales-us@agora.io before implementing this function.
   * - We do not support string user accounts in this API.
   * - Call this method after the `joinChannel` method.
   * - This method takes effect only when you are a broadcaster in a Live-broadcast channel.
   * - After a successful method call, if you want to call this method again, ensure that you call
   * the {@link stopChannelMediaRelay stopChannelMediaRelay} method to quit the current relay.
   *
   * @param channelMediaRelayConfiguration The configuration of the media stream relay. See {@link
   * io.agora.rtc2.video.ChannelMediaRelayConfiguration ChannelMediaRelayConfiguration}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /**
   * Stops the media stream relay.
   *
   * Once the relay stops, the broadcaster quits all the destination channels.
   * After a successful method call, the SDK triggers the {@link
   * IRtcEngineEventHandler#onChannelMediaRelayStateChanged onChannelMediaRelayStateChanged}
   * callback. If the callback returns `RELAY_STATE_IDLE(0)` and `RELAY_OK(0)`, the broadcaster
   * successfully stops the relay.
   *
   * @note
   *
   * If the method call fails, the SDK triggers the `onChannelMediaRelayStateChanged` callback with
   * the `RELAY_ERROR_SERVER_NO_RESPONSE(2)` or `RELAY_ERROR_SERVER_CONNECTION_LOST(8)` state code.
   * You can leave the channel by calling the {@link leaveChannel() leaveChannel} method, and the
   * media stream relay automatically stops.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopChannelMediaRelay();

  /**
   * Updates the channels for media relay.
   *
   * After the channel media relay starts, if you want to relay the media stream to more channels,
   * or leave the current relay channel, you can call the `updateChannelMediaRelay` method.
   *
   * After a successful method call, the SDK triggers the {@link
   * IRtcEngineEventHandler#onChannelMediaRelayEvent onChannelMediaRelayEvent} callback with the
   * RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL(7) state code.
   *
   *
   * @param channelMediaRelayConfiguration The media stream relay configuration: {@link
   *     io.agora.rtc.video.ChannelMediaRelayConfiguration ChannelMediaRelayConfiguration}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /**
   * pause the channels for media stream relay.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pauseAllChannelMediaRelay();

  /**
   * resume the channels for media stream relay.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int resumeAllChannelMediaRelay();

  // Auxiliary API
  /**
   *  Updates the channel media options after joining the channel.
   *
   * @param options The channel media options: ChannelMediaOptions.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int updateChannelMediaOptions(ChannelMediaOptions options);

  /**
   * Starts the recording service.
   *
   */
  public abstract int startRecordingService(String recordingKey);

  /**
   * Stops the recording service.
   *
   */
  public abstract int stopRecordingService(String recordingKey);

  /**
   * Refreshes the server recording service status.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int refreshRecordingServiceStatus();

  /**
   * Mute or resume recording signal volume.
   *
   * @param muted Determines whether to mute or resume the recording signal volume.
   * - true: Mute the recording signal volume.
   * - false: (Default) Resume the recording signal volume.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int muteRecordingSignal(boolean muted);

  /**
   * Starts playing the imported stream from the URL.
   *
   * @param url URL of the imported stream to play.
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int startPlayingStream(String url);

  /**
   * Stops playing the imported stream.
   *
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int stopPlayingStream();

  /**
   * Sets the audio playback format before mixing for the
   * {@link io.agora.rtc2.IAudioFrameObserver#onPlaybackAudioFrameBeforeMixing
   * onPlaybackAudioFrameBeforeMixing} callback.
   *
   * @param sampleRate Sets the sample rate (`samplesPerSec`) returned in the
   * `onPlaybackAudioFrameBeforeMixing` callback, which can be set as 8000, 16000, 32000, 44100, or
   * 48000 Hz.
   * @param channel Number of channels of the audio data returned in
   *     `onPlaybackAudioFrameBeforeMixing`,
   * which can be set as 1 or 2:
   * - 1: Mono
   * - 2: Stereo
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *
   * @note
   * The SDK calculates the sample interval according to the value of the `sampleRate` and
   * `channel` parameters you set in this method.
   * Ensure that the value of sample interval >= 0.01. The SDK triggers the
   * `onPlaybackAudioFrameBeforeMixing` callback according to the sample interval.
   */
  public abstract int setPlaybackAudioFrameBeforeMixingParameters(int sampleRate, int channel);

  /**
   * Enable the audio spectrum monitor.
   *
   * @param intervalInMS Sets the time interval(ms) between two consecutive audio spectrum callback.
   * The default value is 100. This param should be larger than 10.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableAudioSpectrumMonitor(int intervalInMS);
  /**
   * Disalbe the audio spectrum monitor.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int disableAudioSpectrumMonitor();

  /**
   * Registers an audio spectrum observer.
   *
   * You need to implement the `IAudioSpectrumObserver` class in this method, and register the
   * following callbacks according to your scenario:
   * - \ref agora::media::IAudioSpectrumObserver::onAudioSpectrumComputed "onAudioSpectrumComputed":
   * Occurs when the SDK receives the audio data and at set intervals.
   *
   * @param observer A pointer to the audio spectrum observer: \ref
   *     agora::media::IAudioSpectrumObserver
   * "IAudioSpectrumObserver".
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int registerAudioSpectrumObserver(IAudioSpectrumObserver observer);
  /**
   * Releases the audio spectrum observer.
   *
   * @param observer The pointer to the audio spectrum observer: \ref
   *     agora::media::IAudioSpectrumObserver
   * "IAudioSpectrumObserver".
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int unRegisterAudioSpectrumObserver(IAudioSpectrumObserver observer);

  /**
   * Gets the volume of the audio effects.
   *
   * @return
   * - Returns the volume of audio effects, if the method call is successful. The value ranges
   * between 0.0 and 100.0 (original volume).
   * - < 0: Failure.
   */
  public abstract double getEffectsVolume();

  /**
   * Sets the volume of audio effects.
   *
   * @param volume The volume of audio effects. The value ranges between 0.0
   *               and 100.0 (default).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setEffectsVolume(double volume);

  /**
   * Preloads a specified audio effect.
   *
   * This method preloads only one specified audio effect into the memory each time
   * it is called. To preload multiple audio effects, call this method multiple times.
   *
   * After preloading, you can call {@link RtcEngine#playEffect() playEffect} to play the preloaded
   * audio effect or call
   * {@link RtcEngine#playAllEffects() playAllEffects} to play all the preloaded audio effects.
   *
   * @note
   * - To ensure smooth communication, limit the size of the audio effect file.
   * - Agora recommends calling this method before joining the channel.
   *
   * @param soundId  The ID of the audio effect.
   * @param filePath The absolute path of the local audio effect file or the URL
   * of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   * 3gp, mkv and wav.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int preloadEffect(int soundId, String filePath);

  /**
   * Preloads a specified audio effect.
   *
   * This method preloads only one specified audio effect into the memory each time
   * it is called. To preload multiple audio effects, call this method multiple times.
   *
   * After preloading, you can call {@link RtcEngine#playEffect() playEffect} to play the preloaded
   * audio effect or call
   * {@link RtcEngine#playAllEffects() playAllEffects} to play all the preloaded audio effects.
   *
   * @note
   * - To ensure smooth communication, limit the size of the audio effect file.
   * - Agora recommends calling this method before joining the channel.
   *
   * @param soundId  The ID of the audio effect.
   * @param filePath The absolute path of the local audio effect file or the URL
   * @param startPos The start position
   * of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   * 3gp, mkv and wav.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int preloadEffect(int soundId, String filePath, int startPos);

  /**
   * Plays a specified audio effect.
   *
   * After calling {@link RtcEngine#preloadEffect() preloadEffect}, you can call
   * this method to play the specified audio effect for all users in
   * the channel.
   *
   * This method plays only one specified audio effect each time it is called.
   * To play multiple audio effects, call this method multiple times.
   *
   * @note
   * - Agora recommends playing no more than three audio effects at the same time.
   * - The ID and file path of the audio effect in this method must be the same
   * as that in the {@link RtcEngine#preloadEffect() preloadEffect} method.
   *
   * @param soundId   The ID of the audio effect.
   * @param filePath  The absolute path of the local audio effect file or the URL
   *                  of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   *                  3gp, mkv and wav.
   * @param loopCount The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until you call {@link
   * RtcEngine#stopEffect() stopEffect} or {@link RtcEngine#stopAllEffects() stopAllEffects}.
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch     The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is 1.0 (original pitch). The lower the value, the lower the pitch.
   * @param pan       The spatial position of the audio effect. The value ranges between -1.0
   * and 1.0:
   *                  - `-1.0`: The audio effect shows on the left.
   *                  - `0.0`: The audio effect shows ahead.
   *                  - `1.0`: The audio effect shows on the right.
   * @param gain      The volume of the audio effect. The value ranges between 0.0 and 100.0.
   *                  The default value is 100 (original volume). The lower the value, the lower
   * the volume of the audio effect.
   * @param publish   Sets whether to publish the specified audio effect to the remote
   *                  stream:
   *                  - True: Publish the audio effect to the remote.
   *                  - False: false: Do not publish the audio effect to the remote.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int playEffect(int soundId, String filePath, int loopCount, double pitch,
      double pan, double gain, boolean publish);

  /**
   * Plays a specified audio effect.
   *
   * After calling {@link RtcEngine#preloadEffect() preloadEffect}, you can call
   * this method to play the specified audio effect for all users in
   * the channel.
   *
   * This method plays only one specified audio effect each time it is called.
   * To play multiple audio effects, call this method multiple times.
   *
   * @note
   * - Agora recommends playing no more than three audio effects at the same time.
   * - The ID and file path of the audio effect in this method must be the same
   * as that in the {@link RtcEngine#preloadEffect() preloadEffect} method.
   *
   * @param soundId   The ID of the audio effect.
   * @param filePath  The absolute path of the local audio effect file or the URL
   *                  of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   *                  3gp, mkv and wav.
   * @param loopCount The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until you call {@link
   * RtcEngine#stopEffect() stopEffect} or {@link RtcEngine#stopAllEffects() stopAllEffects}.
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch     The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is 1.0 (original pitch). The lower the value, the lower the pitch.
   * @param pan       The spatial position of the audio effect. The value ranges between -1.0
   * and 1.0:
   *                  - `-1.0`: The audio effect shows on the left.
   *                  - `0.0`: The audio effect shows ahead.
   *                  - `1.0`: The audio effect shows on the right.
   * @param gain      The volume of the audio effect. The value ranges between 0.0 and 100.0.
   *                  The default value is 100 (original volume). The lower the value, the lower
   * the volume of the audio effect.
   * @param publish   Sets whether to publish the specified audio effect to the remote
   *                  stream:
   *                  - True: Publish the audio effect to the remote.
   *                  - False: false: Do not publish the audio effect to the remote.
   * @param startPos  The start position
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int playEffect(int soundId, String filePath, int loopCount, double pitch,
      double pan, double gain, boolean publish, int startPos);

  /**
   * Plays all audio effects.
   *
   * After calling {@link RtcEngine#preloadEffect() preloadEffect} multiple times
   * to preload multiple audio effects into the memory, you can call this
   * method to play all the specified audio effects for all users in
   * the channel.
   *
   * @param loopCount The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until you call {@link
   * RtcEngine#stopEffect() stopEffect} or {@link RtcEngine#stopAllEffects() stopAllEffects}.
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is `1.0` (original pitch). The lower the value, the lower the pitch.
   * @param pan   The spatial position of the audio effect. The value ranges between -1.0 and 1.0:
   *              - `-1.0`: The audio effect shows on the left.
   *              - `0.0`: The audio effect shows ahead.
   *              - `1.0`: The audio effect shows on the right.
   * @param gain  The volume of the audio effect. The value ranges between 0.0 and 100.0.
   * The default value is `100` (original volume). The lower the value, the lower
   * the volume of the audio effect.
   * @param publish   Sets whether to publish the specified audio effect to the remote
   *                  stream:
   *                  - True: Publish the audio effect to the remote.
   *                  - False: Do not publish the audio effect to the remote.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int playAllEffects(
      int loopCount, double pitch, double pan, double gain, boolean publish);

  /**
   * Get the volume of a specified sound effect.
   *
   * @param soundId The ID of the audio effect.
   * @return
   * - Returns the volume of the specified audio effect, if the method call is successful. The value
   * ranges between 0.0 and 100.0 (original volume).
   * - < 0: Failure.
   */
  public abstract int getVolumeOfEffect(int soundId);

  /**
   * Sets the volume of the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   * @param volume  The volume of the specified audio effect. The value ranges between 0.0 and 100.0
   * (default).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setVolumeOfEffect(int soundId, double volume);

  /**
   * Pauses playing the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pauseEffect(int soundId);

  /**
   * Pauses playing all audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pauseAllEffects();

  /**
   * Resumes playing the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int resumeEffect(int soundId);

  /**
   * Resumes playing all audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int resumeAllEffects();

  /**
   * Stops playing the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopEffect(int soundId);

  /**
   * Stops playing all audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopAllEffects();

  /**
   * Releases the specific preloaded audio effect from the memory.
   *
   * @param soundId The ID of the audio effect.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int unloadEffect(int soundId);

  /**
   * Releases all preloaded audio effects from the memory.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int unloadAllEffects();

  /**
   * <p>
   * Configures the push-stream settings for the engine before joining a channel
   * for CDN Live.
   *
   * <p>
   * Agora provides a Builder class to configure the push-stream for CDN Live.
   *
   * <p>
   * Note:
   * <ul>
   * <li>Check the {@link PublisherConfiguration.Builder Builder Class} on how to
   * call each method included for the push-stream settings configuration.
   * <li>Set the resolution, frame rate, and bitrate the same as those of the
   * uplink host to avoid video quality degradation.
   * <li>This method is in beta. Contact
   * <a href="mailto:sales@agora.io">sales@agora.io</a> to use this method.
   * </ul>
   *
   * @param config {@link PublisherConfiguration}
   * @return
   *         <ul>
   *         <li>0: Success.
   *         <li><0: Failure.
   *         </ul>
   */
  public abstract int configPublisher(PublisherConfiguration config);

  /**
   * <p>
   * Sets the picture-in-picture layouts for live broadcast.
   *
   * <p>
   * This method is only applicable when you want to push streams at the Agora
   * server. When you push stream at the server:
   * <ol>
   * <li>Define a canvas, its width and height (video resolution), the background
   * color, and the number of videos you want to display in total.
   * <li>Define the position and size of each video on the canvas, and whether it
   * is cropped or zoomed to fit.
   * </ol>
   * <p>
   * The push stream application will format the information of the customized
   * layouts as JSON and package it to the Supplemental Enhancement Information
   * (SEI) of each keyframe when generating the H.264 video stream and pushing it
   * to the CDN vendors through the RTMP protocol.
   *
   *
   * <p>
   * Note:
   * <ul>
   * <li>Call this method after joining a channel.
   * <li>The application should only allow one user to call this method in the
   * same channel, if more than one user calls this method, the other users must
   * call {@link RtcEngine#clearVideoCompositingLayout()
   * clearVideoCompositingLayout} to remove the settings.
   * </ul>
   *
   * @param layout {@link VideoCompositingLayout VideoCompositingLayout}
   *
   */
  public abstract int setVideoCompositingLayout(VideoCompositingLayout layout);

  /**
   * Removes the settings made after calling
   * {@link RtcEngine#setVideoCompositingLayout(VideoCompositingLayout layout)
   * setVideoCompositingLayout}.
   */
  public abstract int clearVideoCompositingLayout();

  /**
   * Registers a receiver object for the encoded video image.
   *
   * @note
   * - Ensure that you call this method before joining the channel.
   * - If you register a receiver for encoded video data, you cannot register an IVideoFrameObserver
   * object.
   *
   * @param receiver The IVideoEncodedImageReceiver object: {@link
   *     io.agora.rtc2.video.IVideoEncodedImageReceiver IVideoEncodedImageReceiver}.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int registerVideoEncodedImageReceiver(IVideoEncodedImageReceiver receiver);
  public abstract int takeSnapshot(String channel, int uid, String filePath);
  public abstract int enableContentInspect(boolean enabled, ContentInspectConfig config);
  public abstract int setAudioOptionParams(String params);

  public abstract String getAudioOptionParams();

  public abstract int setAudioSessionParams(String params);

  public abstract String getAudioSessionParams();

  public abstract int enableExtension(String provider, String extension, boolean enable);

  public abstract int enableExtension(
      String provider, String extension, boolean enable, Constants.MediaSourceType sourceType);

  /**
   * Get local video filter property
   *
   * @param provider filter's vendor
   * @param extension filter's extension
   * @param key property's key
   * @param value property's value
   * @return true, if get property success, otherwise false
   */
  public abstract int setExtensionProperty(
      String provider, String extension, String key, String value);

  public abstract int setExtensionProperty(String provider, String extension, String key,
      String value, Constants.MediaSourceType sourceType);

  /**
   * Set extension provider specific property.
   *
   * @param provider filter's vendor
   * @param key property's key
   * @param value property's value
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setExtensionProviderProperty(String provider, String key, String value);

  /**
   * Screen sharing by specifying a result data which obtained from a successful screen
   * capture request.
   *
   * @note From Android 10 and later, a Service must be running and call startForeground to post a
   * Notification before we can obtain the MediaProjection instance; failing to do so will cause a
   * SecurityException.
   * https://developer.android.google.cn/about/versions/10/privacy/changes#screen-contents
   *
   * @param mediaProjectionPermissionResultData The resulting data from
   * `android.app.Activity#onActivityResult`.
   * @param parameters Sets the screen sharing encoding parameters. See
   * ScreenCaptureParameters.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - ERR_INVALID_ARGUMENT if mediaProjectionPermissionResultData is null.
   */
  @TargetApi(Build.VERSION_CODES.LOLLIPOP)
  public abstract int startScreenCapture(
      Intent mediaProjectionPermissionResultData, ScreenCaptureParameters parameters);

  /**
   * Stops the screen sharing.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  @TargetApi(Build.VERSION_CODES.LOLLIPOP) public abstract int stopScreenCapture();

  /**
   * Registers a video frame observer object.
   *
   * You need to implement the {@link io.agora.rtc2.video.IVideoFrameObserver IVideoFrameObserver}
   * class in this method, and register callbacks according to your scenarios.
   *
   * After you successfully register the video frame observer, the SDK triggers the registered
   * callbacks each time a video frame is received.
   *
   * @note
   * When handling the video data returned in the callbacks, pay attention to the changes in the
   * `width` and `height` parameters, which may be adapted under the following circumstances:
   *  - When the network condition deteriorates, the video resolution decreases incrementally.
   *  - If the user adjusts the video profile, the resolution of the video returned in the callbacks
   * also changes.
   *
   * @param observer Video frame observer object instance. See {@link
   * io.agora.rtc2.video.IVideoFrameObserver IVideoFrameObserver}.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int registerVideoFrameObserver(IVideoFrameObserver observer);

  /**
   * Create a media player
   *
   * You can use this function to create a ffmpeg or simple media player
   *
   * @return
   * {@link IMediaPlayer}
   */
  public abstract IMediaPlayer createMediaPlayer();

  /**
   * Enable or disable the external audio source local playback.
   *
   * * @param enabled Determines whether to enable the external audio source local playback:
   * - true: Enable the external audio source local playback.
   * - false: (default) Disable the external audio source local playback.
   * @return
   * -  0: Success.
   * - <0: Failure.
   */
  public abstract int enableExternalAudioSourceLocalPlayback(boolean enabled);


  /**
   * Adjust the custom audio publish volume by source id.
   * @param sourceId custom audio source id.
   * @param volume The volume, range is [0,100]:
   * 0: mute, 100: The original volume
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int adjustCustomAudioPublishVolume(int sourceId, int volume);

  /**
   * Adjust the custom audio playout volume by source id.
   * @param sourceId custom audio source id.
   * @param volume The volume, range is [0,100]:
   * 0: mute, 100: The original volume
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int adjustCustomAudioPlayoutVolume(int sourceId, int volume);

  /**
   * Enables the rhythm player.
   *
   * @param sound1 The absolute path or URL address (including the filename extensions) of the file
   *     for the downbeat.
   * @param sound2 The absolute path or URL address (including the filename extensions) of the file
   *     for the upbeats.
   * @param {@link AgoraRhythmPlayerConfig} The configuration of rhythm player.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int startRhythmPlayer(
      String sound1, String sound2, AgoraRhythmPlayerConfig config);

  /**
   * Disables the rhythm player.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopRhythmPlayer();

  /**
   * Configures the rhythm player.
   *
   * @param {@link AgoraRhythmPlayerConfig} The configuration of rhythm player.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int configRhythmPlayer(AgoraRhythmPlayerConfig config);

  /**
   * Set audio parameters for direct streaming to CDN
   *
   * Must call this api before "startDirectCdnStreaming"
   *
   * @param profile Sets the sample rate, bitrate, encoding mode, and the number of channels:
   * #AUDIO_PROFILE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setDirectCdnStreamingAudioConfiguration(int profile);

  /**
   * Set video parameters for direct streaming to CDN
   *
   * Each configuration profile corresponds to a set of video parameters, including
   * the resolution, frame rate, and bitrate.
   *
   * @note
   * Must call this api before "startDirectCdnStreaming"
   *
   * @param config The local video encoder configuration: VideoEncoderConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int setDirectCdnStreamingVideoConfiguration(VideoEncoderConfiguration config);

  /**
   * Start direct cdn streaming
   *
   * @param eventHandler A pointer to the direct cdn streaming event handler.
   * "IDirectCdnStreamingEventHandler".
   * @param publishUrl The url of the cdn used to publish the stream.
   * @param options The direct cdn streaming media options: DirectCdnStreamingMediaOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int startDirectCdnStreaming(IDirectCdnStreamingEventHandler eventHandler,
      String publishUrl, DirectCdnStreamingMediaOptions options);

  /**
   * Stop direct cdn streaming
   *
   * @note
   * This method is synchronous.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int stopDirectCdnStreaming();

  /**
   * Change the media source during the pushing
   *
   * @note
   * This method is temporarily not supported
   *
   * @param options The direct cdn streaming media options: DirectCdnStreamingMediaOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int updateDirectCdnStreamingMediaOptions(DirectCdnStreamingMediaOptions options);

  /**
   * Push external video data
   *
   * @param videoFrame The reference to the video frame to send.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int pushDirectCdnStreamingCustomVideoFrame(VideoFrame frame);

  /**
   * Sets the external audio source.
   *
   * @note
   * Ensure that you call this method before joining the channel.
   *
   * @param sourceId custom audio source id.
   * @param enabled Determines whether to local playback the external audio source:
   * - true: Local playback the external audio source.
   * - false: Local don`t playback the external audio source.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public abstract int enableCustomAudioLocalPlayback(int sourceId, boolean enabled);
}
