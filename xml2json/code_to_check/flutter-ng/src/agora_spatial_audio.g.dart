// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_spatial_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteVoicePositionInfo _$RemoteVoicePositionInfoFromJson(
        Map<String, dynamic> json) =>
    RemoteVoicePositionInfo(
      position: (json['position'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      forward: (json['forward'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$RemoteVoicePositionInfoToJson(
        RemoteVoicePositionInfo instance) =>
    <String, dynamic>{
      'position': instance.position,
      'forward': instance.forward,
    };
