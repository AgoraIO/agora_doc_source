// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agora_rhythm_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraRhythmPlayerConfig _$AgoraRhythmPlayerConfigFromJson(
        Map<String, dynamic> json) =>
    AgoraRhythmPlayerConfig(
      beatsPerMeasure: json['beatsPerMeasure'] as int?,
      beatsPerMinute: json['beatsPerMinute'] as int?,
    );

Map<String, dynamic> _$AgoraRhythmPlayerConfigToJson(
        AgoraRhythmPlayerConfig instance) =>
    <String, dynamic>{
      'beatsPerMeasure': instance.beatsPerMeasure,
      'beatsPerMinute': instance.beatsPerMinute,
    };

const _$RhythmPlayerStateTypeEnumMap = {
  RhythmPlayerStateType.rhythmPlayerStateIdle: 810,
  RhythmPlayerStateType.rhythmPlayerStateOpening: 811,
  RhythmPlayerStateType.rhythmPlayerStateDecoding: 812,
  RhythmPlayerStateType.rhythmPlayerStatePlaying: 813,
  RhythmPlayerStateType.rhythmPlayerStateFailed: 814,
};

const _$RhythmPlayerErrorTypeEnumMap = {
  RhythmPlayerErrorType.rhythmPlayerErrorOk: 0,
  RhythmPlayerErrorType.rhythmPlayerErrorFailed: 1,
  RhythmPlayerErrorType.rhythmPlayerErrorCanNotOpen: 801,
  RhythmPlayerErrorType.rhythmPlayerErrorCanNotPlay: 802,
  RhythmPlayerErrorType.rhythmPlayerErrorFileOverDurationLimit: 803,
};
