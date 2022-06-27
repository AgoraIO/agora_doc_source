import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_log.g.dart';

@JsonEnum(alwaysCreate: true)
enum LogLevel {
  @JsonValue(0x0000)
  logLevelNone,
  @JsonValue(0x0001)
  logLevelInfo,
  @JsonValue(0x0002)
  logLevelWarn,
  @JsonValue(0x0004)
  logLevelError,
  @JsonValue(0x0008)
  logLevelFatal,
}

extension LogLevelExt on LogLevel {
  int value() {
    return _$LogLevelEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum LogFilterType {
  @JsonValue(0)
  logFilterOff,
  @JsonValue(0x080f)
  logFilterDebug,
  @JsonValue(0x000f)
  logFilterInfo,
  @JsonValue(0x000e)
  logFilterWarn,
  @JsonValue(0x000c)
  logFilterError,
  @JsonValue(0x0008)
  logFilterCritical,
  @JsonValue(0x80f)
  logFilterMask,
}

extension LogFilterTypeExt on LogFilterType {
  int value() {
    return _$LogFilterTypeEnumMap[this]!;
  }
}

const maxLogSize = 20 * 1024 * 1024;

const minLogSize = 128 * 1024;

const defaultLogSizeInKb = 1024;

@JsonSerializable(explicitToJson: true)
class LogConfig {
  const LogConfig({this.filePath, this.fileSizeInKB, this.level});

  @JsonKey(name: 'filePath')
  final String? filePath;
  @JsonKey(name: 'fileSizeInKB')
  final int? fileSizeInKB;
  @JsonKey(name: 'level')
  final LogLevel? level;
  factory LogConfig.fromJson(Map<String, dynamic> json) =>
      _$LogConfigFromJson(json);
  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}
