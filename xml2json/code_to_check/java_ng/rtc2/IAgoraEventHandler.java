package io.agora.rtc2;

import android.graphics.Rect;

/**
 * Created by eaglewangy on 29/03/2018.
 */

public interface IAgoraEventHandler {
  /**
   * 警告信息回调
   * @param warn 警告号
   */
  void onWarning(int warn);

  /**
   * 错误信息回调
   * @param err 错误号
   */
  void onError(int err);

  /**
   * API执行完毕后，该回调会被触发
   * @param error 如果调用失败这里返回错误号，0为成功
   * @param api 所调用的API
   * @param result 调用结果
   */
  void onApiCallExecuted(int error, String api, String result);

  /**
   * 摄像头设备就绪之后，该回调将被触发
   */
  void onCameraReady();

  /**
   * 摄像头对焦区域或状态发生变化之后，该回调将会被触发
   * @param rect 对焦的区域
   */
  void onCameraFocusAreaChanged(Rect rect);

  /**
   * The camera exposure area has changed.
   *
   * The SDK triggers this callback when the local user changes the camera exposure position by
   * calling the {@link RtcEngine#setCameraExposurePosition setCameraExposurePosition} method.
   * @since v2.3.2.
   * @param rect Rectangular area in the camera zoom specifying the exposure area.
   */
  void onCameraExposureAreaChanged(Rect rect);
  void onContentInspectResult(int result);
  void onSnapshotTaken(
      String channel, int uid, String filePath, int width, int height, int errCode);
  /**
   * Occurs when the camera exposure area has changed.
   *
   * @param imageWidth width of output image.
   * @param imageHeight height of output image.
   * @param faceRectArr Rectangular area in the camera zoom that specifies the focus area.
   */
  void onFacePositionChanged(
      int imageWidth, int imageHeight, IRtcEngineEventHandler.AgoraFacePositionInfo[] faceRectArr);

  /**
   * 所有视频流都停止之后，该回调会被触发
   * @note 可在该回调被触发时重绘视频窗口
   */
  void onVideoStopped();

  /**
   * 退出频道的回调
   * @param stats 状态信息
   * @note RecStats类细节请参考其定义
   */
  void onLeaveChannel(IRtcEngineEventHandler.RtcStats stats);

  /**
   * 状态信息回调
   * @param stats 状态信息
   * @note RecStats类细节请参考其定义
   */
  void onRtcStats(IRtcEngineEventHandler.RtcStats stats);

  /**
   * 远端音频流音量强度回调
   * @param speakers 音频信息数组，包含每个远端用户的UID及其音量
   * @param totalVolume 所有音频流信息混音后总音量强度
   * @note 必须事先调用enableAudioVolumeIndication后该回调才会被触发
   */
  void onAudioVolumeIndication(IRtcEngineEventHandler.AudioVolumeInfo[] speakers, int totalVolume);

  /**
   * Lastmile测试得到的网络质量回调
   * @param quality 网络质量评分
   */
  void onLastmileQuality(int quality);

  void onLastmileProbeResult(IRtcEngineEventHandler.LastmileProbeResult result);

  @Deprecated void onLocalVideoStat(int sentBitrate, int sentFrameRate);

  /**
   * 远端视频流质量回调
   */
  void onRemoteVideoStats(IRtcEngineEventHandler.RemoteVideoStats stats);

  /**
   * 远端音频流质量回调
   */
  void onRemoteAudioStats(IRtcEngineEventHandler.RemoteAudioStats stats);

  /**
   * 近端视频流质量回调
   */
  void onLocalVideoStats(IRtcEngineEventHandler.LocalVideoStats stats);

  void onLocalAudioStats(IRtcEngineEventHandler.LocalAudioStats stats);

  /**
   * 当引擎获取到本地首帧视频信息之后，该回调会被调用
   * @param width 帧宽度
   * @param height 帧高度
   * @param elapsed 此刻距离用户发出登陆请求包的时间间隔
   */
  void onFirstLocalVideoFrame(int width, int height, int elapsed);

  /**
   * 确认连接不可用后，该回调会被调用
   * @note 意外掉线之后，SDK会自动进行重连，重连多次都失败之后，该回调会被触发，判定为连接不可用
   */
  void onConnectionLost();

  /**
   * 连接意外断开后，该回调会被触发
   * @note 意外断开之后，SDK会自动尝试掉线重连
   */
  void onConnectionInterrupted();

  /**
   * 连接状态改变后，该回调会被触发
   */
  void onConnectionStateChanged(int state, int reason);

  /**
   * 网络类型改变后，该回调会被触发
   */
  void onNetworkTypeChanged(int type);

  /**
   * 连接被服务器禁止，该回调会被触发
   * @note 连接禁止后，SDK不会重新连接服务器
   */
  void onConnectionBanned();

  void onRefreshRecordingServiceStatus(int status);

  void onMediaEngineLoadSuccess();

  void onMediaEngineStartCallSuccess();

  /**
   * @brief When audio mixing file playback finished, this callback will be triggered.
   */
  void onAudioMixingFinished();

  /**
   * @brief when token is enabled, and specified token is invalid or expired, this function will be
   * called. APP should generate a new token and call renewToken() to refresh the token. NOTE: to be
   * compatible with previous version, ERR_TOKEN_EXPIRED and ERR_INVALID_TOKEN are also reported via
   * onError() callback. You should move renew of token logic into this callback.
   */
  void onRequestToken();

  /**
   * @brief: when sdk is responsible for monitoring audio routing,
   * this function will be called by sdk to notify app that audio routing changed.
   */
  void onAudioRouteChanged(int routing);

  /**
   * Occurs when the state of the local user's audio mixing file changes.
   *
   * When the audio mixing file plays, pauses playing, or stops playing, this callback returns 710,
   * 711, or 713 in state, and 0 in errorCode.
   * When exceptions occur during playback, this callback returns 714 in state and an error in
   * errorCode.
   * If the local audio mixing file does not exist, or if the SDK does not support the file format
   * or cannot access the music file URL, the SDK returns WARN_AUDIO_MIXING_OPEN_ERROR = 701.
   *
   * @param state The state code. See #AUDIO_MIXING_STATE_*.
   * @param errorCode The error code. See #AUDIO_MIXING_ERROR_*.
   */
  void onAudioMixingStateChanged(int state, int errorCode);

  /**
   * 当引擎发送本地首帧音频帧时，该回调会被调用
   * @param elapsed 此刻距离用户发出登陆请求包的时间间隔
   */
  void onFirstLocalAudioFramePublished(int elapsed);

  void onFirstRemoteAudioFrame(int uid, int elapsed);

  void onFirstRemoteAudioDecoded(int uid, int elapsed);

  void onAudioEffectFinished(int soundId);

  void onClientRoleChanged(int oldRole, int newRole);

  void onRtmpStreamingStateChanged(String url,
      IRtcEngineEventHandler.RTMP_STREAM_PUBLISH_STATE state,
      IRtcEngineEventHandler.RTMP_STREAM_PUBLISH_ERROR errCode);

  void onStreamPublished(String url, int error);

  void onStreamUnpublished(String url);

  void onTranscodingUpdated();

  void onTokenPrivilegeWillExpire(String token);

  void onLocalPublishFallbackToAudioOnly(boolean isFallbackOrRecover);

  void onChannelMediaRelayStateChanged(int state, int code);

  void onChannelMediaRelayEvent(int code);

  void onIntraRequestReceived();

  void onUplinkNetworkInfoUpdated(IRtcEngineEventHandler.UplinkNetworkInfo info);

  void onDownlinkNetworkInfoUpdated(IRtcEngineEventHandler.DownlinkNetworkInfo info);

  void onEncryptionError(IRtcEngineEventHandler.ENCRYPTION_ERROR_TYPE errorType);

  void onPermissionError(IRtcEngineEventHandler.PERMISSION permission);

  /**
   Occurs when the local user successfully registers a user account by calling the
   * \ref agora::rtc::IRtcEngine::registerLocalUserAccount "registerLocalUserAccount" method
   * or joins a channel by calling the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount
   "joinChannelWithUserAccount" method.
   * This callback reports the user ID and user account of the local user.

   @param uid The ID of the local user.
   @param userAccount The user account of the local user.
   */
  void onLocalUserRegistered(int uid, String userAccount);

  /**
   Occurs when the SDK gets the user ID and user account of the remote user.

   After a remote user joins the channel, the SDK gets the UID and user account of the remote user,
   caches them in a mapping table object (`userInfo`), and triggers this callback on the local
   client.

   @param uid The ID of the remote user.
   @param info The `UserInfo` object that contains the user ID and user account of the remote user.
   */
  void onUserInfoUpdated(int uid, UserInfo info);

  /**
   * Occurs when the first video frame is published.
   * @param elapsed The time elapsed (ms) from the local user calling joinChannel to the SDK
   * triggers this callback.
   */
  void onFirstLocalVideoFramePublished(int elapsed);

  /**
   * Occurs when the audio subscribe state changed.
   *
   * @param channel              The channel name of user joined.
   * @param uid                  The remote user ID that is subscribed to.
   * @param oldState             The old state of the audio stream subscribe :
   *     #STREAM_SUBSCRIBE_STATE.
   * @param newState             The new state of the audio stream subscribe :
   *     #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onAudioSubscribeStateChanged(String channel, int uid,
      IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE oldState,
      IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState);

  /**
   * Occurs when the video subscribe state changed.
   *
   * @param channel              The channel name of user joined.
   * @param uid                  The remote user ID that is subscribed to.
   * @param oldState             The old state of the video stream subscribe :
   *     #STREAM_SUBSCRIBE_STATE.
   * @param newState             The new state of the video stream subscribe :
   *     #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onVideoSubscribeStateChanged(String channel, int uid,
      IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE oldState,
      IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState);

  /**
   * Occurs when the audio publish state changed.
   *
   * @param channel              The channel name of user joined.
   * @param oldState             The old state of the audio stream publish : #STREAM_PUBLISH_STATE.
   * @param newState             The new state of the audio stream publish : #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onAudioPublishStateChanged(String channel,
      IRtcEngineEventHandler.STREAM_PUBLISH_STATE oldState,
      IRtcEngineEventHandler.STREAM_PUBLISH_STATE newState, int elapseSinceLastState);

  /**
   * Occurs when the video publish state changed.
   *
   * @param channel              The channel name of user joined.
   * @param oldState             The old state of the video stream publish : #STREAM_PUBLISH_STATE.
   * @param newState             The new state of the video stream publish : #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onVideoPublishStateChanged(String channel,
      IRtcEngineEventHandler.STREAM_PUBLISH_STATE oldState,
      IRtcEngineEventHandler.STREAM_PUBLISH_STATE newState, int elapseSinceLastState);
  /**
   * Reports the user log upload result
   * @param requestId RequestId of the upload
   * @param success Is upload success
   * @param reason Reason of the upload, 0: OK, 1 Network Error, 2 Server Error.
   */
  public void onUploadLogResult(String requestId, boolean success, int reason);
}
