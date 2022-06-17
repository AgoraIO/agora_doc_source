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
