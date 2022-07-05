import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

const defaultConnectionId = 0;

const dummyConnectionId = 4294967295;

@JsonEnum(alwaysCreate: true)
enum AudioRoute {
  @JsonValue(-1)
  routeDefault,
  @JsonValue(0)
  routeHeadset,
  @JsonValue(1)
  routeEarpiece,
  @JsonValue(2)
  routeHeadsetnomic,
  @JsonValue(3)
  routeSpeakerphone,
  @JsonValue(4)
  routeLoudspeaker,
  @JsonValue(5)
  routeHeadsetbluetooth,
  @JsonValue(6)
  routeHdmi,
  @JsonValue(7)
  routeUsb,
}

extension AudioRouteExt on AudioRoute {
  int value() {
    return _$AudioRouteEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum NlpAggressiveness {
  @JsonValue(0)
  nlpNotSpecified,
  @JsonValue(1)
  nlpMild,
  @JsonValue(2)
  nlpNormal,
  @JsonValue(3)
  nlpAggressive,
  @JsonValue(4)
  nlpSuperAggressive,
  @JsonValue(5)
  nlpExtreme,
}

extension NlpAggressivenessExt on NlpAggressiveness {
  int value() {
    return _$NlpAggressivenessEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum BytesPerSample {
  @JsonValue(2)
  twoBytesPerSample,
}

extension BytesPerSampleExt on BytesPerSample {
  int value() {
    return _$BytesPerSampleEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioParameters {
  const AudioParameters({this.sampleRate, this.channels, this.framesPerBuffer});

  @JsonKey(name: 'sample_rate')
  final int? sampleRate;
  @JsonKey(name: 'channels')
  final int? channels;
  @JsonKey(name: 'frames_per_buffer')
  final int? framesPerBuffer;
  factory AudioParameters.fromJson(Map<String, dynamic> json) =>
      _$AudioParametersFromJson(json);
  Map<String, dynamic> toJson() => _$AudioParametersToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RawAudioFrameOpModeType {
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,
  @JsonValue(2)
  rawAudioFrameOpModeReadWrite,
}

extension RawAudioFrameOpModeTypeExt on RawAudioFrameOpModeType {
  int value() {
    return _$RawAudioFrameOpModeTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MediaSourceType {
  @JsonValue(0)
  audioPlayoutSource,
  @JsonValue(1)
  audioRecordingSource,
  @JsonValue(2)
  primaryCameraSource,
  @JsonValue(3)
  secondaryCameraSource,
  @JsonValue(4)
  primaryScreenSource,
  @JsonValue(5)
  secondaryScreenSource,
  @JsonValue(6)
  customVideoSource,
  @JsonValue(7)
  mediaPlayerSource,
  @JsonValue(8)
  rtcImagePngSource,
  @JsonValue(9)
  rtcImageJpegSource,
  @JsonValue(10)
  rtcImageGifSource,
  @JsonValue(11)
  remoteVideoSource,
  @JsonValue(12)
  transcodedVideoSource,
  @JsonValue(100)
  unknownMediaSource,
}

extension MediaSourceTypeExt on MediaSourceType {
  int value() {
    return _$MediaSourceTypeEnumMap[this]!;
  }
}

const kMaxCodecNameLength = 50;

@JsonSerializable(explicitToJson: true)
class PacketOptions {
  const PacketOptions({this.timestamp, this.audioLevelIndication});

  @JsonKey(name: 'timestamp')
  final int? timestamp;
  @JsonKey(name: 'audioLevelIndication')
  final int? audioLevelIndication;
  factory PacketOptions.fromJson(Map<String, dynamic> json) =>
      _$PacketOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$PacketOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioProcessingChannels {
  @JsonValue(1)
  audioProcessingMono,
  @JsonValue(2)
  audioProcessingStereo,
}

extension AudioProcessingChannelsExt on AudioProcessingChannels {
  int value() {
    return _$AudioProcessingChannelsEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class AdvancedAudioOptions {
  const AdvancedAudioOptions({this.audioProcessingChannels});

  @JsonKey(name: 'audioProcessingChannels')
  final AudioProcessingChannels? audioProcessingChannels;
  factory AdvancedAudioOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedAudioOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$AdvancedAudioOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameInfo {
  const AudioEncodedFrameInfo({this.sendTs, this.codec});

  @JsonKey(name: 'sendTs')
  final int? sendTs;
  @JsonKey(name: 'codec')
  final int? codec;
  factory AudioEncodedFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioEncodedFrameInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AudioPcmFrame {
  const AudioPcmFrame(
      {this.captureTimestamp,
      this.samplesPerChannel,
      this.sampleRateHz,
      this.numChannels,
      this.bytesPerSample,
      this.data});

  @JsonKey(name: 'capture_timestamp')
  final int? captureTimestamp;
  @JsonKey(name: 'samples_per_channel_')
  final int? samplesPerChannel;
  @JsonKey(name: 'sample_rate_hz_')
  final int? sampleRateHz;
  @JsonKey(name: 'num_channels_')
  final int? numChannels;
  @JsonKey(name: 'bytes_per_sample')
  final BytesPerSample? bytesPerSample;
  @JsonKey(name: 'data_')
  final List<int>? data;
  factory AudioPcmFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmFrameFromJson(json);
  Map<String, dynamic> toJson() => _$AudioPcmFrameToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioPcmFrameEnum {
  @JsonValue(3840)
  kMaxDataSizeSamples,
  @JsonValue(7680)
  kMaxDataSizeBytes,
}

extension AudioPcmFrameEnumExt on AudioPcmFrameEnum {
  int value() {
    return _$AudioPcmFrameEnumEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioDualMonoMode {
  @JsonValue(0)
  audioDualMonoStereo,
  @JsonValue(1)
  audioDualMonoL,
  @JsonValue(2)
  audioDualMonoR,
  @JsonValue(3)
  audioDualMonoMix,
}

extension AudioDualMonoModeExt on AudioDualMonoMode {
  int value() {
    return _$AudioDualMonoModeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoPixelFormat {
  @JsonValue(0)
  videoPixelUnknown,
  @JsonValue(1)
  videoPixelI420,
  @JsonValue(2)
  videoPixelBgra,
  @JsonValue(3)
  videoPixelNv21,
  @JsonValue(4)
  videoPixelRgba,
  @JsonValue(8)
  videoPixelNv12,
  @JsonValue(10)
  videoTexture2d,
  @JsonValue(11)
  videoTextureOes,
  @JsonValue(16)
  videoPixelI422,
}

extension VideoPixelFormatExt on VideoPixelFormat {
  int value() {
    return _$VideoPixelFormatEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  @JsonValue(1)
  renderModeHidden,
  @JsonValue(2)
  renderModeFit,
  @JsonValue(3)
  renderModeAdaptive,
}

extension RenderModeTypeExt on RenderModeType {
  int value() {
    return _$RenderModeTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum EglContextType {
  @JsonValue(0)
  eglContext10,
  @JsonValue(1)
  eglContext14,
}

extension EglContextTypeExt on EglContextType {
  int value() {
    return _$EglContextTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoBufferType {
  @JsonValue(1)
  videoBufferRawData,
  @JsonValue(2)
  videoBufferArray,
  @JsonValue(3)
  videoBufferTexture,
}

extension VideoBufferTypeExt on VideoBufferType {
  int value() {
    return _$VideoBufferTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MediaPlayerSourceType {
  @JsonValue(0)
  mediaPlayerSourceDefault,
  @JsonValue(1)
  mediaPlayerSourceFullFeatured,
  @JsonValue(2)
  mediaPlayerSourceSimple,
}

extension MediaPlayerSourceTypeExt on MediaPlayerSourceType {
  int value() {
    return _$MediaPlayerSourceTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoModulePosition {
  @JsonValue(1 << 0)
  positionPostCapturer,
  @JsonValue(1 << 1)
  positionPreRenderer,
  @JsonValue(1 << 2)
  positionPreEncoder,
  @JsonValue(1 << 3)
  positionPostFilters,
}

extension VideoModulePositionExt on VideoModulePosition {
  int value() {
    return _$VideoModulePositionEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioFrameType {
  @JsonValue(0)
  frameTypePcm16,
}

extension AudioFrameTypeExt on AudioFrameType {
  int value() {
    return _$AudioFrameTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioSpectrumData {
  const AudioSpectrumData({this.audioSpectrumData, this.dataLength});

  @JsonKey(name: 'audioSpectrumData')
  final List<double>? audioSpectrumData;
  @JsonKey(name: 'dataLength')
  final int? dataLength;
  factory AudioSpectrumData.fromJson(Map<String, dynamic> json) =>
      _$AudioSpectrumDataFromJson(json);
  Map<String, dynamic> toJson() => _$AudioSpectrumDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserAudioSpectrumInfo {
  const UserAudioSpectrumInfo({this.uid, this.spectrumData});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'spectrumData')
  final AudioSpectrumData? spectrumData;
  factory UserAudioSpectrumInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAudioSpectrumInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserAudioSpectrumInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoFrameProcessMode {
  @JsonValue(0)
  processModeReadOnly,
  @JsonValue(1)
  processModeReadWrite,
}

extension VideoFrameProcessModeExt on VideoFrameProcessMode {
  int value() {
    return _$VideoFrameProcessModeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ContentInspectResult {
  @JsonValue(1)
  contentInspectNeutral,
  @JsonValue(2)
  contentInspectSexy,
  @JsonValue(3)
  contentInspectPorn,
}

extension ContentInspectResultExt on ContentInspectResult {
  int value() {
    return _$ContentInspectResultEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ContentInspectDeviceType {
  @JsonValue(0)
  contentInspectDeviceInvalid,
  @JsonValue(1)
  contentInspectDeviceAgora,
  @JsonValue(2)
  contentInspectDeviceHive,
  @JsonValue(3)
  contentInspectDeviceTupu,
}

extension ContentInspectDeviceTypeExt on ContentInspectDeviceType {
  int value() {
    return _$ContentInspectDeviceTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ContentInspectType {
  @JsonValue(0)
  contentInspectInvalide,
  @JsonValue(1)
  contentInspectModeration,
  @JsonValue(2)
  contentInspectSupervise,
}

extension ContentInspectTypeExt on ContentInspectType {
  int value() {
    return _$ContentInspectTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class ContentInspectModule {
  const ContentInspectModule({this.type, this.frequency});

  @JsonKey(name: 'type')
  final ContentInspectType? type;
  @JsonKey(name: 'frequency')
  final int? frequency;
  factory ContentInspectModule.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectModuleFromJson(json);
  Map<String, dynamic> toJson() => _$ContentInspectModuleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContentInspectConfig {
  const ContentInspectConfig(
      {this.enable,
      this.deviceWork,
      this.cloudWork,
      this.deviceworkType,
      this.extraInfo,
      this.modules,
      this.moduleCount});

  @JsonKey(name: 'enable')
  final bool? enable;
  @JsonKey(name: 'DeviceWork')
  final bool? deviceWork;
  @JsonKey(name: 'CloudWork')
  final bool? cloudWork;
  @JsonKey(name: 'DeviceworkType')
  final ContentInspectDeviceType? deviceworkType;
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;
  @JsonKey(name: 'modules')
  final List<ContentInspectModule>? modules;
  @JsonKey(name: 'moduleCount')
  final int? moduleCount;
  factory ContentInspectConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ContentInspectConfigToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SnapShotConfig {
  const SnapShotConfig({this.channel, this.uid, this.filePath});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'filePath')
  final String? filePath;
  factory SnapShotConfig.fromJson(Map<String, dynamic> json) =>
      _$SnapShotConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SnapShotConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ExternalVideoSourceType {
  @JsonValue(0)
  videoFrame,
  @JsonValue(1)
  encodedVideoFrame,
}

extension ExternalVideoSourceTypeExt on ExternalVideoSourceType {
  int value() {
    return _$ExternalVideoSourceTypeEnumMap[this]!;
  }
}
