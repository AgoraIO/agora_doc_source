// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agora_rtc_engine_ex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RtcConnection _$RtcConnectionFromJson(Map<String, dynamic> json) =>
    RtcConnection(
      channelId: json['channelId'] as String?,
      localUid: json['localUid'] as int?,
    );

Map<String, dynamic> _$RtcConnectionToJson(RtcConnection instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'localUid': instance.localUid,
    };
