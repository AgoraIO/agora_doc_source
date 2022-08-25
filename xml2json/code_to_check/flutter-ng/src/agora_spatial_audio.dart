import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_spatial_audio.g.dart';

/// @nodoc
@JsonSerializable(explicitToJson: true)
class RemoteVoicePositionInfo {
  /// @nodoc
  const RemoteVoicePositionInfo({this.position, this.forward});

  /// @nodoc
  @JsonKey(name: 'position')
  final List<double>? position;

  /// @nodoc
  @JsonKey(name: 'forward')
  final List<double>? forward;

  /// @nodoc
  factory RemoteVoicePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteVoicePositionInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVoicePositionInfoToJson(this);
}

/// @nodoc
abstract class BaseSpatialAudioEngine {
  /// @nodoc
  Future<void> release();

  /// @nodoc
  Future<void> setMaxAudioRecvCount(int maxCount);

  /// @nodoc
  Future<void> setAudioRecvRange(double range);

  /// @nodoc
  Future<void> setDistanceUnit(double unit);

  /// @nodoc
  Future<void> updateSelfPosition(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp});

  /// @nodoc
  Future<void> updateSelfPositionEx(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp,
      required RtcConnection connection});

  /// @nodoc
  Future<void> updatePlayerPositionInfo(
      {required int playerId, required RemoteVoicePositionInfo positionInfo});

  /// @nodoc
  Future<void> setParameters(String params);

  /// @nodoc
  Future<void> muteLocalAudioStream(bool mute);

  /// @nodoc
  Future<void> muteAllRemoteAudioStreams(bool mute);
}

/// @nodoc
abstract class LocalSpatialAudioEngine implements BaseSpatialAudioEngine {
  /// @nodoc
  Future<void> initialize();

  /// @nodoc
  Future<void> updateRemotePosition(
      {required int uid, required RemoteVoicePositionInfo posInfo});

  /// @nodoc
  Future<void> updateRemotePositionEx(
      {required int uid,
      required RemoteVoicePositionInfo posInfo,
      required RtcConnection connection});

  /// @nodoc
  Future<void> removeRemotePosition(int uid);

  /// @nodoc
  Future<void> removeRemotePositionEx(
      {required int uid, required RtcConnection connection});

  /// @nodoc
  Future<void> clearRemotePositions();

  /// @nodoc
  Future<void> clearRemotePositionsEx(RtcConnection connection);
}
