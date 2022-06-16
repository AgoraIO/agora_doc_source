import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_rtc_engine_ex.g.dart';

@JsonSerializable(explicitToJson: true)
class RtcConnection {
  const RtcConnection({this.channelId, this.localUid});

  @JsonKey(name: 'channelId')
  final String? channelId;
  @JsonKey(name: 'localUid')
  final int? localUid;
  factory RtcConnection.fromJson(Map<String, dynamic> json) =>
      _$RtcConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$RtcConnectionToJson(this);
}

class RtcEngineEventHandlerEx extends RtcEngineEventHandler {
  const RtcEngineEventHandlerEx({
    void Function(String channel, int uid, int elapsed)? onJoinChannelSuccess,
    void Function(String channel, int uid, int elapsed)? onRejoinChannelSuccess,
    void Function(int warn, String msg)? onWarning,
    void Function(int err, String msg)? onError,
    void Function(int uid, int quality, int delay, int lost)? onAudioQuality,
    void Function(LastmileProbeResult result)? onLastmileProbeResult,
    void Function(AudioVolumeInfo speakers, int speakerNumber, int totalVolume)?
        onAudioVolumeIndication,
    void Function(RtcStats stats)? onLeaveChannel,
    void Function(RtcStats stats)? onRtcStats,
    void Function(String deviceId, int deviceType, int deviceState)?
        onAudioDeviceStateChanged,
    void Function()? onAudioMixingFinished,
    void Function(int soundId)? onAudioEffectFinished,
    void Function(String deviceId, int deviceType, int deviceState)?
        onVideoDeviceStateChanged,
    void Function(int deviceType)? onMediaDeviceChanged,
    void Function(int uid, int txQuality, int rxQuality)? onNetworkQuality,
    void Function()? onIntraRequestReceived,
    void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated,
    void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated,
    void Function(int quality)? onLastmileQuality,
    void Function(int width, int height, int elapsed)? onFirstLocalVideoFrame,
    void Function(int elapsed)? onFirstLocalVideoFramePublished,
    void Function(VideoSourceType sourceType, int width, int height)?
        onVideoSourceFrameSizeChanged,
    void Function(int uid, int width, int height, int elapsed)?
        onFirstRemoteVideoDecoded,
    void Function(int uid, int width, int height, int rotation)?
        onVideoSizeChanged,
    void Function(LocalVideoStreamState state, LocalVideoStreamError error)?
        onLocalVideoStateChanged,
    void Function(int uid, RemoteVideoState state,
            RemoteVideoStateReason reason, int elapsed)?
        onRemoteVideoStateChanged,
    void Function(int userId, int width, int height, int elapsed)?
        onFirstRemoteVideoFrame,
    void Function(int uid, int elapsed)? onUserJoined,
    void Function(int uid, UserOfflineReasonType reason)? onUserOffline,
    void Function(int uid, bool muted)? onUserMuteAudio,
    void Function(int userId, bool muted)? onUserMuteVideo,
    void Function(int uid, bool enabled)? onUserEnableVideo,
    void Function(int uid, int state)? onUserStateChanged,
    void Function(int uid, bool enabled)? onUserEnableLocalVideo,
    void Function(int err, String api, String result)? onApiCallExecuted,
    void Function(LocalAudioStats stats)? onLocalAudioStats,
    void Function(RemoteAudioStats stats)? onRemoteAudioStats,
    void Function(LocalVideoStats stats)? onLocalVideoStats,
    void Function(RemoteVideoStats stats)? onRemoteVideoStats,
    void Function()? onCameraReady,
    void Function(int x, int y, int width, int height)?
        onCameraFocusAreaChanged,
    void Function(int x, int y, int width, int height)?
        onCameraExposureAreaChanged,
    void Function(int imageWidth, int imageHeight, Rectangle vecRectangle,
            int vecDistance, int numFaces)?
        onFacePositionChanged,
    void Function()? onVideoStopped,
    void Function(AudioMixingStateType state, AudioMixingErrorType errorCode)?
        onAudioMixingStateChanged,
    void Function(RhythmPlayerStateType state, RhythmPlayerErrorType errorCode)?
        onRhythmPlayerStateChanged,
    void Function()? onConnectionLost,
    void Function()? onConnectionInterrupted,
    void Function()? onConnectionBanned,
    void Function(
            int userId, int streamId, Uint8List data, int length, int sentTs)?
        onStreamMessage,
    void Function(int userId, int streamId, int code, int missed, int cached)?
        onStreamMessageError,
    void Function()? onRequestToken,
    void Function(String token)? onTokenPrivilegeWillExpire,
    void Function(int elapsed)? onFirstLocalAudioFramePublished,
    void Function(int uid, int elapsed)? onFirstRemoteAudioFrame,
    void Function(int uid, int elapsed)? onFirstRemoteAudioDecoded,
    void Function(LocalAudioStreamState state, LocalAudioStreamError error)?
        onLocalAudioStateChanged,
    void Function(int uid, RemoteAudioState state,
            RemoteAudioStateReason reason, int elapsed)?
        onRemoteAudioStateChanged,
    void Function(int userId)? onActiveSpeaker,
    void Function(ContentInspectResult result)? onContentInspectResult,
    void Function(String channel, int uid, String filePath, int width,
            int height, int errCode)?
        onSnapshotTaken,
    void Function(ClientRoleType oldRole, ClientRoleType newRole)?
        onClientRoleChanged,
    void Function(
            ClientRoleChangeFailedReason reason, ClientRoleType currentRole)?
        onClientRoleChangeFailed,
    void Function(MediaDeviceType deviceType, int volume, bool muted)?
        onAudioDeviceVolumeChanged,
    void Function(String url, RtmpStreamPublishState state,
            RtmpStreamPublishErrorType errCode)?
        onRtmpStreamingStateChanged,
    void Function(String url, RtmpStreamingEvent eventCode)?
        onRtmpStreamingEvent,
    void Function(String url, int error)? onStreamPublished,
    void Function(String url)? onStreamUnpublished,
    void Function()? onTranscodingUpdated,
    void Function(int routing)? onAudioRoutingChanged,
    void Function(ChannelMediaRelayState state, ChannelMediaRelayError code)?
        onChannelMediaRelayStateChanged,
    void Function(int code)? onChannelMediaRelayEvent,
    void Function(bool isFallbackOrRecover)? onLocalPublishFallbackToAudioOnly,
    void Function(int uid, bool isFallbackOrRecover)?
        onRemoteSubscribeFallbackToAudioOnly,
    void Function(int uid, int delay, int lost, int rxKBitRate)?
        onRemoteAudioTransportStats,
    void Function(int uid, int delay, int lost, int rxKBitRate)?
        onRemoteVideoTransportStats,
    void Function(
            ConnectionStateType state, ConnectionChangedReasonType reason)?
        onConnectionStateChanged,
    void Function(NetworkType type)? onNetworkTypeChanged,
    void Function(EncryptionErrorType errorType)? onEncryptionError,
    void Function(PermissionType permissionType)? onPermissionError,
    void Function(int uid, String userAccount)? onLocalUserRegistered,
    void Function(int uid, UserInfo info)? onUserInfoUpdated,
    void Function(String requestId, bool success, UploadErrorReason reason)?
        onUploadLogResult,
    void Function(String channel, int uid, StreamSubscribeState oldState,
            StreamSubscribeState newState, int elapseSinceLastState)?
        onAudioSubscribeStateChanged,
    void Function(String channel, int uid, StreamSubscribeState oldState,
            StreamSubscribeState newState, int elapseSinceLastState)?
        onVideoSubscribeStateChanged,
    void Function(String channel, StreamPublishState oldState,
            StreamPublishState newState, int elapseSinceLastState)?
        onAudioPublishStateChanged,
    void Function(String channel, StreamPublishState oldState,
            StreamPublishState newState, int elapseSinceLastState)?
        onVideoPublishStateChanged,
    void Function(String provider, String extName, String key, String value)?
        onExtensionEvent,
    void Function(String provider, String extName)? onExtensionStarted,
    void Function(String provider, String extName)? onExtensionStopped,
    void Function(String provider, String extName, int error, String msg)?
        onExtensionErrored,
    void Function(int uid, String userAccount)? onUserAccountUpdated,
    this.onJoinChannelSuccessEx,
    this.onRejoinChannelSuccessEx,
    this.onAudioQualityEx,
    this.onAudioVolumeIndicationEx,
    this.onLeaveChannelEx,
    this.onRtcStatsEx,
    this.onNetworkQualityEx,
    this.onIntraRequestReceivedEx,
    this.onFirstLocalVideoFrameEx,
    this.onFirstLocalVideoFramePublishedEx,
    this.onVideoSourceFrameSizeChangedEx,
    this.onFirstRemoteVideoDecodedEx,
    this.onVideoSizeChangedEx,
    this.onContentInspectResultEx,
    this.onSnapshotTakenEx,
    this.onLocalVideoStateChangedEx,
    this.onRemoteVideoStateChangedEx,
    this.onFirstRemoteVideoFrameEx,
    this.onUserJoinedEx,
    this.onUserOfflineEx,
    this.onUserMuteAudioEx,
    this.onUserMuteVideoEx,
    this.onUserEnableVideoEx,
    this.onUserEnableLocalVideoEx,
    this.onUserStateChangedEx,
    this.onLocalAudioStatsEx,
    this.onRemoteAudioStatsEx,
    this.onLocalVideoStatsEx,
    this.onRemoteVideoStatsEx,
    this.onConnectionLostEx,
    this.onConnectionInterruptedEx,
    this.onConnectionBannedEx,
    this.onStreamMessageEx,
    this.onStreamMessageErrorEx,
    this.onRequestTokenEx,
    this.onTokenPrivilegeWillExpireEx,
    this.onFirstLocalAudioFramePublishedEx,
    this.onFirstRemoteAudioFrameEx,
    this.onFirstRemoteAudioDecodedEx,
    this.onLocalAudioStateChangedEx,
    this.onRemoteAudioStateChangedEx,
    this.onActiveSpeakerEx,
    this.onClientRoleChangedEx,
    this.onClientRoleChangeFailedEx,
    this.onRemoteAudioTransportStatsEx,
    this.onRemoteVideoTransportStatsEx,
    this.onConnectionStateChangedEx,
    this.onNetworkTypeChangedEx,
    this.onEncryptionErrorEx,
    this.onUploadLogResultEx,
    this.onUserAccountUpdatedEx,
  }) : super(
          onJoinChannelSuccess: onJoinChannelSuccess,
          onRejoinChannelSuccess: onRejoinChannelSuccess,
          onWarning: onWarning,
          onError: onError,
          onAudioQuality: onAudioQuality,
          onLastmileProbeResult: onLastmileProbeResult,
          onAudioVolumeIndication: onAudioVolumeIndication,
          onLeaveChannel: onLeaveChannel,
          onRtcStats: onRtcStats,
          onAudioDeviceStateChanged: onAudioDeviceStateChanged,
          onAudioMixingFinished: onAudioMixingFinished,
          onAudioEffectFinished: onAudioEffectFinished,
          onVideoDeviceStateChanged: onVideoDeviceStateChanged,
          onMediaDeviceChanged: onMediaDeviceChanged,
          onNetworkQuality: onNetworkQuality,
          onIntraRequestReceived: onIntraRequestReceived,
          onUplinkNetworkInfoUpdated: onUplinkNetworkInfoUpdated,
          onDownlinkNetworkInfoUpdated: onDownlinkNetworkInfoUpdated,
          onLastmileQuality: onLastmileQuality,
          onFirstLocalVideoFrame: onFirstLocalVideoFrame,
          onFirstLocalVideoFramePublished: onFirstLocalVideoFramePublished,
          onVideoSourceFrameSizeChanged: onVideoSourceFrameSizeChanged,
          onFirstRemoteVideoDecoded: onFirstRemoteVideoDecoded,
          onVideoSizeChanged: onVideoSizeChanged,
          onLocalVideoStateChanged: onLocalVideoStateChanged,
          onRemoteVideoStateChanged: onRemoteVideoStateChanged,
          onFirstRemoteVideoFrame: onFirstRemoteVideoFrame,
          onUserJoined: onUserJoined,
          onUserOffline: onUserOffline,
          onUserMuteAudio: onUserMuteAudio,
          onUserMuteVideo: onUserMuteVideo,
          onUserEnableVideo: onUserEnableVideo,
          onUserStateChanged: onUserStateChanged,
          onUserEnableLocalVideo: onUserEnableLocalVideo,
          onApiCallExecuted: onApiCallExecuted,
          onLocalAudioStats: onLocalAudioStats,
          onRemoteAudioStats: onRemoteAudioStats,
          onLocalVideoStats: onLocalVideoStats,
          onRemoteVideoStats: onRemoteVideoStats,
          onCameraReady: onCameraReady,
          onCameraFocusAreaChanged: onCameraFocusAreaChanged,
          onCameraExposureAreaChanged: onCameraExposureAreaChanged,
          onFacePositionChanged: onFacePositionChanged,
          onVideoStopped: onVideoStopped,
          onAudioMixingStateChanged: onAudioMixingStateChanged,
          onRhythmPlayerStateChanged: onRhythmPlayerStateChanged,
          onConnectionLost: onConnectionLost,
          onConnectionInterrupted: onConnectionInterrupted,
          onConnectionBanned: onConnectionBanned,
          onStreamMessage: onStreamMessage,
          onStreamMessageError: onStreamMessageError,
          onRequestToken: onRequestToken,
          onTokenPrivilegeWillExpire: onTokenPrivilegeWillExpire,
          onFirstLocalAudioFramePublished: onFirstLocalAudioFramePublished,
          onFirstRemoteAudioFrame: onFirstRemoteAudioFrame,
          onFirstRemoteAudioDecoded: onFirstRemoteAudioDecoded,
          onLocalAudioStateChanged: onLocalAudioStateChanged,
          onRemoteAudioStateChanged: onRemoteAudioStateChanged,
          onActiveSpeaker: onActiveSpeaker,
          onContentInspectResult: onContentInspectResult,
          onSnapshotTaken: onSnapshotTaken,
          onClientRoleChanged: onClientRoleChanged,
          onClientRoleChangeFailed: onClientRoleChangeFailed,
          onAudioDeviceVolumeChanged: onAudioDeviceVolumeChanged,
          onRtmpStreamingStateChanged: onRtmpStreamingStateChanged,
          onRtmpStreamingEvent: onRtmpStreamingEvent,
          onStreamPublished: onStreamPublished,
          onStreamUnpublished: onStreamUnpublished,
          onTranscodingUpdated: onTranscodingUpdated,
          onAudioRoutingChanged: onAudioRoutingChanged,
          onChannelMediaRelayStateChanged: onChannelMediaRelayStateChanged,
          onChannelMediaRelayEvent: onChannelMediaRelayEvent,
          onLocalPublishFallbackToAudioOnly: onLocalPublishFallbackToAudioOnly,
          onRemoteSubscribeFallbackToAudioOnly:
              onRemoteSubscribeFallbackToAudioOnly,
          onRemoteAudioTransportStats: onRemoteAudioTransportStats,
          onRemoteVideoTransportStats: onRemoteVideoTransportStats,
          onConnectionStateChanged: onConnectionStateChanged,
          onNetworkTypeChanged: onNetworkTypeChanged,
          onEncryptionError: onEncryptionError,
          onPermissionError: onPermissionError,
          onLocalUserRegistered: onLocalUserRegistered,
          onUserInfoUpdated: onUserInfoUpdated,
          onUploadLogResult: onUploadLogResult,
          onAudioSubscribeStateChanged: onAudioSubscribeStateChanged,
          onVideoSubscribeStateChanged: onVideoSubscribeStateChanged,
          onAudioPublishStateChanged: onAudioPublishStateChanged,
          onVideoPublishStateChanged: onVideoPublishStateChanged,
          onExtensionEvent: onExtensionEvent,
          onExtensionStarted: onExtensionStarted,
          onExtensionStopped: onExtensionStopped,
          onExtensionErrored: onExtensionErrored,
          onUserAccountUpdated: onUserAccountUpdated,
        );

  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccessEx;

  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccessEx;

  final void Function(RtcConnection connection, int remoteUid, int quality,
      int delay, int lost)? onAudioQualityEx;

  final void Function(RtcConnection connection, AudioVolumeInfo speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndicationEx;

  final void Function(RtcConnection connection, RtcStats stats)?
      onLeaveChannelEx;

  final void Function(RtcConnection connection, RtcStats stats)? onRtcStatsEx;

  final void Function(RtcConnection connection, int remoteUid, int txQuality,
      int rxQuality)? onNetworkQualityEx;

  final void Function(RtcConnection connection)? onIntraRequestReceivedEx;

  final void Function(
          RtcConnection connection, int width, int height, int elapsed)?
      onFirstLocalVideoFrameEx;

  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalVideoFramePublishedEx;

  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int width, int height)? onVideoSourceFrameSizeChangedEx;

  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecodedEx;

  final void Function(RtcConnection connection, int uid, int width, int height,
      int rotation)? onVideoSizeChangedEx;

  final void Function(ContentInspectResult result)? onContentInspectResultEx;

  final void Function(RtcConnection connection, String filePath, int width,
      int height, int errCode)? onSnapshotTakenEx;

  final void Function(RtcConnection connection, LocalVideoStreamState state,
      LocalVideoStreamError errorCode)? onLocalVideoStateChangedEx;

  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChangedEx;

  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrameEx;

  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoinedEx;

  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOfflineEx;

  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudioEx;

  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideoEx;

  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideoEx;

  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideoEx;

  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChangedEx;

  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStatsEx;

  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStatsEx;

  final void Function(RtcConnection connection, LocalVideoStats stats)?
      onLocalVideoStatsEx;

  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStatsEx;

  final void Function(RtcConnection connection)? onConnectionLostEx;

  final void Function(RtcConnection connection)? onConnectionInterruptedEx;

  final void Function(RtcConnection connection)? onConnectionBannedEx;

  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessageEx;

  final void Function(RtcConnection connection, int remoteUid, int streamId,
      int code, int missed, int cached)? onStreamMessageErrorEx;

  final void Function(RtcConnection connection)? onRequestTokenEx;

  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpireEx;

  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublishedEx;

  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrameEx;

  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecodedEx;

  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamError error)? onLocalAudioStateChangedEx;

  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChangedEx;

  final void Function(RtcConnection connection, int uid)? onActiveSpeakerEx;

  final void Function(RtcConnection connection, ClientRoleType oldRole,
      ClientRoleType newRole)? onClientRoleChangedEx;

  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailedEx;

  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStatsEx;

  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStatsEx;

  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChangedEx;

  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChangedEx;

  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionErrorEx;

  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResultEx;

  final void Function(
          RtcConnection connection, int remoteUid, String userAccount)?
      onUserAccountUpdatedEx;
}

abstract class RtcEngineEx implements RtcEngine {
  void joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options});

  void leaveChannelEx(RtcConnection connection);

  void updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection});

  void setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection});

  void setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection});

  void muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  void muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  void setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection});

  void setRemoteVoicePositionEx(
      {required int uid,
      required double pan,
      required double gain,
      required RtcConnection connection});

  void setRemoteUserSpatialAudioParamsEx(
      {required int uid,
      required SpatialAudioParams params,
      required RtcConnection connection});

  void setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection});

  void enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName});

  ConnectionStateType getConnectionStateEx(RtcConnection connection);

  void enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config});

  int createDataStreamEx(
      {required bool reliable,
      required bool ordered,
      required RtcConnection connection});

  int createDataStreamEx2(
      {required DataStreamConfig config, required RtcConnection connection});

  void sendStreamMessageEx(
      {required int streamId,
      required int data,
      required int length,
      required RtcConnection connection});

  void addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection});

  void clearVideoWatermarkEx(RtcConnection connection);

  void sendCustomReportMessageEx(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value,
      required RtcConnection connection});

  void enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection});

  UserInfo getUserInfoByUserAccountEx(
      {required String userAccount, required RtcConnection connection});

  UserInfo getUserInfoByUidEx(
      {required int uid, required RtcConnection connection});

  void setVideoProfileEx(
      {required int width,
      required int height,
      required int frameRate,
      required int bitrate});

  void enableDualStreamModeEx(
      {required VideoSourceType sourceType,
      required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  void addPublishStreamUrlEx(
      {required String url,
      required bool transcodingEnabled,
      required RtcConnection connection});
}
