import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_media_player_types.g.dart';

const kMaxCharBufferLength = 50;

@JsonEnum(alwaysCreate: true)
enum MediaPlayerState {
  @JsonValue(0)
  playerStateIdle,
  @JsonValue(1)
  playerStateOpening,
  @JsonValue(2)
  playerStateOpenCompleted,
  @JsonValue(3)
  playerStatePlaying,
  @JsonValue(4)
  playerStatePaused,
  @JsonValue(5)
  playerStatePlaybackCompleted,
  @JsonValue(6)
  playerStatePlaybackAllLoopsCompleted,
  @JsonValue(7)
  playerStateStopped,
  @JsonValue(50)
  playerStatePausingInternal,
  @JsonValue(51)
  playerStateStoppingInternal,
  @JsonValue(52)
  playerStateSeekingInternal,
  @JsonValue(53)
  playerStateGettingInternal,
  @JsonValue(54)
  playerStateNoneInternal,
  @JsonValue(55)
  playerStateDoNothingInternal,
  @JsonValue(56)
  playerStateSetTrackInternal,
  @JsonValue(100)
  playerStateFailed,
}

extension MediaPlayerStateExt on MediaPlayerState {
  int value() {
    return _$MediaPlayerStateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MediaPlayerError {
  @JsonValue(0)
  playerErrorNone,
  @JsonValue(-1)
  playerErrorInvalidArguments,
  @JsonValue(-2)
  playerErrorInternal,
  @JsonValue(-3)
  playerErrorNoResource,
  @JsonValue(-4)
  playerErrorInvalidMediaSource,
  @JsonValue(-5)
  playerErrorUnknownStreamType,
  @JsonValue(-6)
  playerErrorObjNotInitialized,
  @JsonValue(-7)
  playerErrorCodecNotSupported,
  @JsonValue(-8)
  playerErrorVideoRenderFailed,
  @JsonValue(-9)
  playerErrorInvalidState,
  @JsonValue(-10)
  playerErrorUrlNotFound,
  @JsonValue(-11)
  playerErrorInvalidConnectionState,
  @JsonValue(-12)
  playerErrorSrcBufferUnderflow,
  @JsonValue(-13)
  playerErrorInterrupted,
  @JsonValue(-14)
  playerErrorNotSupported,
  @JsonValue(-15)
  playerErrorTokenExpired,
  @JsonValue(-16)
  playerErrorIpExpired,
  @JsonValue(-17)
  playerErrorUnknown,
}

extension MediaPlayerErrorExt on MediaPlayerError {
  int value() {
    return _$MediaPlayerErrorEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MediaStreamType {
  @JsonValue(0)
  streamTypeUnknown,
  @JsonValue(1)
  streamTypeVideo,
  @JsonValue(2)
  streamTypeAudio,
  @JsonValue(3)
  streamTypeSubtitle,
}

extension MediaStreamTypeExt on MediaStreamType {
  int value() {
    return _$MediaStreamTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MediaPlayerEvent {
  @JsonValue(0)
  playerEventSeekBegin,
  @JsonValue(1)
  playerEventSeekComplete,
  @JsonValue(2)
  playerEventSeekError,
  @JsonValue(5)
  playerEventAudioTrackChanged,
  @JsonValue(6)
  playerEventBufferLow,
  @JsonValue(7)
  playerEventBufferRecover,
  @JsonValue(8)
  playerEventFreezeStart,
  @JsonValue(9)
  playerEventFreezeStop,
  @JsonValue(10)
  playerEventSwitchBegin,
  @JsonValue(11)
  playerEventSwitchComplete,
  @JsonValue(12)
  playerEventSwitchError,
  @JsonValue(13)
  playerEventFirstDisplayed,
}

extension MediaPlayerEventExt on MediaPlayerEvent {
  int value() {
    return _$MediaPlayerEventEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum PlayerPreloadEvent {
  @JsonValue(0)
  playerPreloadEventBegin,
  @JsonValue(1)
  playerPreloadEventComplete,
  @JsonValue(2)
  playerPreloadEventError,
}

extension PlayerPreloadEventExt on PlayerPreloadEvent {
  int value() {
    return _$PlayerPreloadEventEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class PlayerStreamInfo {
  const PlayerStreamInfo(
      {this.streamIndex,
      this.streamType,
      this.codecName,
      this.language,
      this.videoFrameRate,
      this.videoBitRate,
      this.videoWidth,
      this.videoHeight,
      this.videoRotation,
      this.audioSampleRate,
      this.audioChannels,
      this.audioBitsPerSample,
      this.duration});

  @JsonKey(name: 'streamIndex')
  final int? streamIndex;
  @JsonKey(name: 'streamType')
  final MediaStreamType? streamType;
  @JsonKey(name: 'codecName')
  final String? codecName;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'videoFrameRate')
  final int? videoFrameRate;
  @JsonKey(name: 'videoBitRate')
  final int? videoBitRate;
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;
  @JsonKey(name: 'videoRotation')
  final int? videoRotation;
  @JsonKey(name: 'audioSampleRate')
  final int? audioSampleRate;
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;
  @JsonKey(name: 'audioBitsPerSample')
  final int? audioBitsPerSample;
  @JsonKey(name: 'duration')
  final int? duration;
  factory PlayerStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerStreamInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStreamInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SrcInfo {
  const SrcInfo({this.bitrateInKbps, this.name});

  @JsonKey(name: 'bitrateInKbps')
  final int? bitrateInKbps;
  @JsonKey(name: 'name')
  final String? name;
  factory SrcInfo.fromJson(Map<String, dynamic> json) =>
      _$SrcInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SrcInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum MediaPlayerMetadataType {
  @JsonValue(0)
  playerMetadataTypeUnknown,
  @JsonValue(1)
  playerMetadataTypeSei,
}

extension MediaPlayerMetadataTypeExt on MediaPlayerMetadataType {
  int value() {
    return _$MediaPlayerMetadataTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class PlayerUpdatedInfo {
  const PlayerUpdatedInfo({this.playerId, this.deviceId});

  @JsonKey(name: 'playerId')
  final String? playerId;
  @JsonKey(name: 'deviceId')
  final String? deviceId;
  factory PlayerUpdatedInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerUpdatedInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerUpdatedInfoToJson(this);
}
