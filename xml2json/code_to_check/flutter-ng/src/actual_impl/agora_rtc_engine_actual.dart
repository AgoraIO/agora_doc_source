

// import 'binding/iagora_rtc_engine.dart';
// import 'impl/agora_rtc_engine_impl.dart';
// import 'media_player_old.dart';

// // class RtcEngineEventHandler extends IRtcEngineEventHandler {
// //   const RtcEngineEventHandler({
// //     String Function()? eventHandlerType,
// //     /// See [IRtcEngineEventHandler.onJoinChannelSuccess]
// //     void Function(String channel, int uid, int elapsed)? onJoinChannelSuccess,
// //     /// See [IRtcEngineEventHandler.onRejoinChannelSuccess]
// //     void Function(String channel, int uid, int elapsed)? onRejoinChannelSuccess,
// //     void Function(int warn, String msg)? onWarning,
// //     void Function(int err, String msg)? onError,
// //     void Function(int uid, int quality, int delay, int lost)? onAudioQuality,
// //     void Function(LastmileProbeResult result)? onLastmileProbeResult,
// //     void Function(AudioVolumeInfo speakers, int speakerNumber, int totalVolume)?
// //         onAudioVolumeIndication,
// //     void Function(RtcStats stats)? onLeaveChannel,
// //     void Function(RtcStats stats)? onRtcStats,
// //     void Function(String deviceId, int deviceType, int deviceState)?
// //         onAudioDeviceStateChanged,
// //     void Function()? onAudioMixingFinished,
// //     void Function(int soundId)? onAudioEffectFinished,
// //     void Function(String deviceId, int deviceType, int deviceState)?
// //         onVideoDeviceStateChanged,
// //     void Function(int deviceType)? onMediaDeviceChanged,
// //     void Function(int uid, int txQuality, int rxQuality)? onNetworkQuality,
// //     void Function()? onIntraRequestReceived,
// //     void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated,
// //     void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated,
// //     void Function(int quality)? onLastmileQuality,
// //     void Function(int width, int height, int elapsed)? onFirstLocalVideoFrame,
// //     void Function(int elapsed)? onFirstLocalVideoFramePublished,
// //     void Function(VideoSourceType sourceType, int width, int height)?
// //         onVideoSourceFrameSizeChanged,
// //     void Function(int uid, int width, int height, int elapsed)?
// //         onFirstRemoteVideoDecoded,
// //     void Function(int uid, int width, int height, int rotation)?
// //         onVideoSizeChanged,
// //     void Function(LocalVideoStreamState state, LocalVideoStreamError error)?
// //         onLocalVideoStateChanged,
// //     void Function(int uid, RemoteVideoState state,
// //             RemoteVideoStateReason reason, int elapsed)?
// //         onRemoteVideoStateChanged,
// //     void Function(int userId, int width, int height, int elapsed)?
// //         onFirstRemoteVideoFrame,
// //     void Function(int uid, int elapsed)? onUserJoined,
// //     void Function(int uid, UserOfflineReasonType reason)? onUserOffline,
// //     void Function(int uid, bool muted)? onUserMuteAudio,
// //     void Function(int userId, bool muted)? onUserMuteVideo,
// //     void Function(int uid, bool enabled)? onUserEnableVideo,
// //     void Function(int uid, int state)? onUserStateChanged,
// //     void Function(int uid, bool enabled)? onUserEnableLocalVideo,
// //     void Function(int err, String api, String result)? onApiCallExecuted,
// //     void Function(LocalAudioStats stats)? onLocalAudioStats,
// //     void Function(RemoteAudioStats stats)? onRemoteAudioStats,
// //     void Function(LocalVideoStats stats)? onLocalVideoStats,
// //     void Function(RemoteVideoStats stats)? onRemoteVideoStats,
// //     void Function()? onCameraReady,
// //     void Function(int x, int y, int width, int height)?
// //         onCameraFocusAreaChanged,
// //     void Function(int x, int y, int width, int height)?
// //         onCameraExposureAreaChanged,
// //     void Function()? onVideoStopped,
// //     void Function(AudioMixingStateType state, AudioMixingErrorType errorCode)?
// //         onAudioMixingStateChanged,
// //     void Function(RhythmPlayerStateType state, RhythmPlayerErrorType errorCode)?
// //         onRhythmPlayerStateChanged,
// //     void Function()? onConnectionLost,
// //     void Function()? onConnectionInterrupted,
// //     void Function()? onConnectionBanned,
// //     void Function(
// //             int userId, int streamId, String data, int length, int sentTs)?
// //         onStreamMessage,
// //     void Function(int userId, int streamId, int code, int missed, int cached)?
// //         onStreamMessageError,
// //     void Function()? onRequestToken,
// //     void Function(String token)? onTokenPrivilegeWillExpire,
// //     void Function(int elapsed)? onFirstLocalAudioFramePublished,
// //     void Function(int uid, int elapsed)? onFirstRemoteAudioFrame,
// //     void Function(int uid, int elapsed)? onFirstRemoteAudioDecoded,
// //     void Function(LocalAudioStreamState state, LocalAudioStreamError error)?
// //         onLocalAudioStateChanged,
// //     void Function(int uid, RemoteAudioState state,
// //             RemoteAudioStateReason reason, int elapsed)?
// //         onRemoteAudioStateChanged,
// //     void Function(int userId)? onActiveSpeaker,
// //     void Function(ContentInspectResult result)? onContentInspectResult,
// //     void Function(String channel, int uid, String filePath, int width,
// //             int height, int errCode)?
// //         onSnapshotTaken,
// //     void Function(ClientRoleType oldRole, ClientRoleType newRole)?
// //         onClientRoleChanged,
// //     void Function(
// //             ClientRoleChangeFailedReason reason, ClientRoleType currentRole)?
// //         onClientRoleChangeFailed,
// //     void Function(MediaDeviceType deviceType, int volume, bool muted)?
// //         onAudioDeviceVolumeChanged,
// //     void Function(String url, RtmpStreamPublishState state,
// //             RtmpStreamPublishErrorType errCode)?
// //         onRtmpStreamingStateChanged,
// //     void Function(String url, RtmpStreamingEvent eventCode)?
// //         onRtmpStreamingEvent,
// //     void Function(String url, int error)? onStreamPublished,
// //     void Function(String url)? onStreamUnpublished,
// //     void Function()? onTranscodingUpdated,
// //     void Function(int routing)? onAudioRoutingChanged,
// //     void Function(int state, int code)? onChannelMediaRelayStateChanged,
// //     void Function(int code)? onChannelMediaRelayEvent,
// //     void Function(bool isFallbackOrRecover)? onLocalPublishFallbackToAudioOnly,
// //     void Function(int uid, bool isFallbackOrRecover)?
// //         onRemoteSubscribeFallbackToAudioOnly,
// //     void Function(int uid, int delay, int lost, int rxKBitRate)?
// //         onRemoteAudioTransportStats,
// //     void Function(int uid, int delay, int lost, int rxKBitRate)?
// //         onRemoteVideoTransportStats,
// //     void Function(
// //             ConnectionStateType state, ConnectionChangedReasonType reason)?
// //         onConnectionStateChanged,
// //     void Function(NetworkType type)? onNetworkTypeChanged,
// //     void Function(EncryptionErrorType errorType)? onEncryptionError,
// //     void Function(PermissionType permissionType)? onPermissionError,
// //     void Function(int uid, String userAccount)? onLocalUserRegistered,
// //     void Function(int uid, UserInfo info)? onUserInfoUpdated,
// //     void Function(String requestId, bool success, UploadErrorReason reason)?
// //         onUploadLogResult,
// //     void Function(String channel, int uid, StreamSubscribeState oldState,
// //             StreamSubscribeState newState, int elapseSinceLastState)?
// //         onAudioSubscribeStateChanged,
// //     void Function(String channel, int uid, StreamSubscribeState oldState,
// //             StreamSubscribeState newState, int elapseSinceLastState)?
// //         onVideoSubscribeStateChanged,
// //     void Function(String channel, StreamPublishState oldState,
// //             StreamPublishState newState, int elapseSinceLastState)?
// //         onAudioPublishStateChanged,
// //     void Function(String channel, StreamPublishState oldState,
// //             StreamPublishState newState, int elapseSinceLastState)?
// //         onVideoPublishStateChanged,
// //     void Function(String provider, String extName, String key, String value)?
// //         onExtensionEvent,
// //     void Function(String provider, String extName)? onExtensionStarted,
// //     void Function(String provider, String extName)? onExtensionStopped,
// //     void Function(String provider, String extName, int error, String msg)?
// //         onExtensionErrored,
// //     void Function(int uid, String userAccount)? onUserAccountUpdated,
// //   }) : super(
// //           eventHandlerType,
// //           onJoinChannelSuccess,
// //           onRejoinChannelSuccess,
// //           onWarning,
// //           onError,
// //           onAudioQuality,
// //           onLastmileProbeResult,
// //           onAudioVolumeIndication,
// //           onLeaveChannel,
// //           onRtcStats,
// //           onAudioDeviceStateChanged,
// //           onAudioMixingFinished,
// //           onAudioEffectFinished,
// //           onVideoDeviceStateChanged,
// //           onMediaDeviceChanged,
// //           onNetworkQuality,
// //           onIntraRequestReceived,
// //           onUplinkNetworkInfoUpdated,
// //           onDownlinkNetworkInfoUpdated,
// //           onLastmileQuality,
// //           onFirstLocalVideoFrame,
// //           onFirstLocalVideoFramePublished,
// //           onVideoSourceFrameSizeChanged,
// //           onFirstRemoteVideoDecoded,
// //           onVideoSizeChanged,
// //           onLocalVideoStateChanged,
// //           onRemoteVideoStateChanged,
// //           onFirstRemoteVideoFrame,
// //           onUserJoined,
// //           onUserOffline,
// //           onUserMuteAudio,
// //           onUserMuteVideo,
// //           onUserEnableVideo,
// //           onUserStateChanged,
// //           onUserEnableLocalVideo,
// //           onApiCallExecuted,
// //           onLocalAudioStats,
// //           onRemoteAudioStats,
// //           onLocalVideoStats,
// //           onRemoteVideoStats,
// //           onCameraReady,
// //           onCameraFocusAreaChanged,
// //           onCameraExposureAreaChanged,
// //           onVideoStopped,
// //           onAudioMixingStateChanged,
// //           onRhythmPlayerStateChanged,
// //           onConnectionLost,
// //           onConnectionInterrupted,
// //           onConnectionBanned,
// //           onStreamMessage,
// //           onStreamMessageError,
// //           onRequestToken,
// //           onTokenPrivilegeWillExpire,
// //           onFirstLocalAudioFramePublished,
// //           onFirstRemoteAudioFrame,
// //           onFirstRemoteAudioDecoded,
// //           onLocalAudioStateChanged,
// //           onRemoteAudioStateChanged,
// //           onActiveSpeaker,
// //           onContentInspectResult,
// //           onSnapshotTaken,
// //           onClientRoleChanged,
// //           onClientRoleChangeFailed,
// //           onAudioDeviceVolumeChanged,
// //           onRtmpStreamingStateChanged,
// //           onRtmpStreamingEvent,
// //           onStreamPublished,
// //           onStreamUnpublished,
// //           onTranscodingUpdated,
// //           onAudioRoutingChanged,
// //           onChannelMediaRelayStateChanged,
// //           onChannelMediaRelayEvent,
// //           onLocalPublishFallbackToAudioOnly,
// //           onRemoteSubscribeFallbackToAudioOnly,
// //           onRemoteAudioTransportStats,
// //           onRemoteVideoTransportStats,
// //           onConnectionStateChanged,
// //           onNetworkTypeChanged,
// //           onEncryptionError,
// //           onPermissionError,
// //           onLocalUserRegistered,
// //           onUserInfoUpdated,
// //           onUploadLogResult,
// //           onAudioSubscribeStateChanged,
// //           onVideoSubscribeStateChanged,
// //           onAudioPublishStateChanged,
// //           onVideoPublishStateChanged,
// //           onExtensionEvent,
// //           onExtensionStarted,
// //           onExtensionStopped,
// //           onExtensionErrored,
// //           onUserAccountUpdated,
// //         );
// // }

// /// (Recommended) 0: Standard bitrate mode.
// ///
// /// In this mode, the bitrates differ between the live broadcast and communication
// /// profiles:
// ///
// /// - Communication profile: The video bitrate is the same as the base bitrate.
// /// - Live Broadcast profile: The video bitrate is twice the base bitrate.
// const int standardBitrate = 0;

// /**
//  * -1: Compatible bitrate mode.
//  *
//  * In this mode, the bitrate remains the same regardless of the channel profile. If you choose
//  * this mode in the live-broadcast profile, the video frame rate may be lower
//  * than the set value.
//  */
// const int compatibleBitrate = -1;

// /**
//  * -1: (For future use) The default minimum bitrate.
//  */
// const int defaultMinBitrate = -1;

// /**
//  * -2: (For future use) Set minimum bitrate the same as target bitrate.
//  */
// const int defaultMinBitrateEqualToTargetBitrate = -2;

// abstract class RtcEngine implements IRtcEngineEx {
//   static RtcEngine create(RtcEngineContext context) {
//     return RtcEngineImpl.create(context);
//   }

//   @protected
//   @override
//   void initialize(RtcEngineContext context);

//   @override
//   Future<void> release({bool sync = false});

//   @override
//   void registerEventHandler(covariant RtcEngineEventHandler eventHandler);

//   @override
//   void unregisterEventHandler(covariant RtcEngineEventHandler eventHandler);

//   @internal
//   @override
//   MediaPlayer createMediaPlayer();

//   @internal
//   @override
//   void destroyMediaPlayer(covariant MediaPlayer mediaPlayer);

//   // @override
//   // void enableEncryption(
//   //     {required bool enabled, required EncryptionConfig config});

//   // void sendMetaData(
//   //     {required Metadata metadata, required VideoSourceType sourceType});

//   // void setMaxMetadataSize(int size);

//   Future<String?> getAssetAbsolutePath(String assetPath);
// }

// // class VideoDeviceInfo extends IVideoDeviceCollectionInternal {
// //   VideoDeviceInfo({
// //     required this.deviceId,
// //     required this.deviceName,
// //   });

// //   final String deviceId;
// //   final String deviceName;

// //   factory VideoDeviceInfo.fromJson(Map<String, dynamic> json) {
// //     return VideoDeviceInfo(
// //       deviceId: json['deviceId'],
// //       deviceName: json['deviceName'],
// //     );
// //   }
// // }

// abstract class VideoDeviceManager extends IVideoDeviceManager {
//   factory VideoDeviceManager.create() {
//     return VideoDeviceManagerImpl.create();
//   }

//   @override
//   List<VideoDeviceInfo> enumerateVideoDevices();
// }
