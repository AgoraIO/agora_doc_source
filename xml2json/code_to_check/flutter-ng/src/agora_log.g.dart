// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agora_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogConfig _$LogConfigFromJson(Map<String, dynamic> json) => LogConfig(
      filePath: json['filePath'] as String?,
      fileSizeInKB: json['fileSizeInKB'] as int?,
      level: $enumDecodeNullable(_$LogLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$LogConfigToJson(LogConfig instance) => <String, dynamic>{
      'filePath': instance.filePath,
      'fileSizeInKB': instance.fileSizeInKB,
      'level': _$LogLevelEnumMap[instance.level],
    };

const _$LogLevelEnumMap = {
  LogLevel.logLevelNone: 0,
  LogLevel.logLevelInfo: 1,
  LogLevel.logLevelWarn: 2,
  LogLevel.logLevelError: 4,
  LogLevel.logLevelFatal: 8,
};

const _$LogFilterTypeEnumMap = {
  LogFilterType.logFilterOff: 0,
  LogFilterType.logFilterDebug: 2063,
  LogFilterType.logFilterInfo: 15,
  LogFilterType.logFilterWarn: 14,
  LogFilterType.logFilterError: 12,
  LogFilterType.logFilterCritical: 8,
  LogFilterType.logFilterMask: 2063,
};
