import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_rtc_engine.g.dart';

@JsonEnum(alwaysCreate: true)
enum MediaDeviceType {
  @JsonValue(-1)
  unknownAudioDevice,
  @JsonValue(0)
  audioPlayoutDevice,
  @JsonValue(1)
  audioRecordingDevice,
  @JsonValue(2)
  videoRenderDevice,
  @JsonValue(3)
  videoCaptureDevice,
  @JsonValue(4)
  audioApplicationPlayoutDevice,
}

extension MediaDeviceTypeExt on MediaDeviceType {
  int value() {
    return _$MediaDeviceTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioMixingStateType {
  @JsonValue(710)
  audioMixingStatePlaying,
  @JsonValue(711)
  audioMixingStatePaused,
  @JsonValue(713)
  audioMixingStateStopped,
  @JsonValue(714)
  audioMixingStateFailed,
  @JsonValue(715)
  audioMixingStateCompleted,
  @JsonValue(716)
  audioMixingStateAllLoopsCompleted,
}

extension AudioMixingStateTypeExt on AudioMixingStateType {
  int value() {
    return _$AudioMixingStateTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioMixingErrorType {
  @JsonValue(701)
  audioMixingErrorCanNotOpen,
  @JsonValue(702)
  audioMixingErrorTooFrequentCall,
  @JsonValue(703)
  audioMixingErrorInterruptedEof,
  @JsonValue(0)
  audioMixingErrorOk,
}

extension AudioMixingErrorTypeExt on AudioMixingErrorType {
  int value() {
    return _$AudioMixingErrorTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum InjectStreamStatus {
  @JsonValue(0)
  injectStreamStatusStartSuccess,
  @JsonValue(1)
  injectStreamStatusStartAlreadyExists,
  @JsonValue(2)
  injectStreamStatusStartUnauthorized,
  @JsonValue(3)
  injectStreamStatusStartTimedout,
  @JsonValue(4)
  injectStreamStatusStartFailed,
  @JsonValue(5)
  injectStreamStatusStopSuccess,
  @JsonValue(6)
  injectStreamStatusStopNotFound,
  @JsonValue(7)
  injectStreamStatusStopUnauthorized,
  @JsonValue(8)
  injectStreamStatusStopTimedout,
  @JsonValue(9)
  injectStreamStatusStopFailed,
  @JsonValue(10)
  injectStreamStatusBroken,
}

extension InjectStreamStatusExt on InjectStreamStatus {
  int value() {
    return _$InjectStreamStatusEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioEqualizationBandFrequency {
  @JsonValue(0)
  audioEqualizationBand31,
  @JsonValue(1)
  audioEqualizationBand62,
  @JsonValue(2)
  audioEqualizationBand125,
  @JsonValue(3)
  audioEqualizationBand250,
  @JsonValue(4)
  audioEqualizationBand500,
  @JsonValue(5)
  audioEqualizationBand1k,
  @JsonValue(6)
  audioEqualizationBand2k,
  @JsonValue(7)
  audioEqualizationBand4k,
  @JsonValue(8)
  audioEqualizationBand8k,
  @JsonValue(9)
  audioEqualizationBand16k,
}

extension AudioEqualizationBandFrequencyExt on AudioEqualizationBandFrequency {
  int value() {
    return _$AudioEqualizationBandFrequencyEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioReverbType {
  @JsonValue(0)
  audioReverbDryLevel,
  @JsonValue(1)
  audioReverbWetLevel,
  @JsonValue(2)
  audioReverbRoomSize,
  @JsonValue(3)
  audioReverbWetDelay,
  @JsonValue(4)
  audioReverbStrength,
}

extension AudioReverbTypeExt on AudioReverbType {
  int value() {
    return _$AudioReverbTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum StreamFallbackOptions {
  @JsonValue(0)
  streamFallbackOptionDisabled,
  @JsonValue(1)
  streamFallbackOptionVideoStreamLow,
  @JsonValue(2)
  streamFallbackOptionAudioOnly,
}

extension StreamFallbackOptionsExt on StreamFallbackOptions {
  int value() {
    return _$StreamFallbackOptionsEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum PriorityType {
  @JsonValue(50)
  priorityHigh,
  @JsonValue(100)
  priorityNormal,
}

extension PriorityTypeExt on PriorityType {
  int value() {
    return _$PriorityTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class LocalVideoStats {
  const LocalVideoStats(
      {this.uid,
      this.sentBitrate,
      this.sentFrameRate,
      this.captureFrameRate,
      this.captureFrameWidth,
      this.captureFrameHeight,
      this.regulatedCaptureFrameRate,
      this.regulatedCaptureFrameWidth,
      this.regulatedCaptureFrameHeight,
      this.encoderOutputFrameRate,
      this.encodedFrameWidth,
      this.encodedFrameHeight,
      this.rendererOutputFrameRate,
      this.targetBitrate,
      this.targetFrameRate,
      this.qualityAdaptIndication,
      this.encodedBitrate,
      this.encodedFrameCount,
      this.codecType,
      this.txPacketLossRate});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;
  @JsonKey(name: 'sentFrameRate')
  final int? sentFrameRate;
  @JsonKey(name: 'captureFrameRate')
  final int? captureFrameRate;
  @JsonKey(name: 'captureFrameWidth')
  final int? captureFrameWidth;
  @JsonKey(name: 'captureFrameHeight')
  final int? captureFrameHeight;
  @JsonKey(name: 'regulatedCaptureFrameRate')
  final int? regulatedCaptureFrameRate;
  @JsonKey(name: 'regulatedCaptureFrameWidth')
  final int? regulatedCaptureFrameWidth;
  @JsonKey(name: 'regulatedCaptureFrameHeight')
  final int? regulatedCaptureFrameHeight;
  @JsonKey(name: 'encoderOutputFrameRate')
  final int? encoderOutputFrameRate;
  @JsonKey(name: 'encodedFrameWidth')
  final int? encodedFrameWidth;
  @JsonKey(name: 'encodedFrameHeight')
  final int? encodedFrameHeight;
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;
  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;
  @JsonKey(name: 'targetFrameRate')
  final int? targetFrameRate;
  @JsonKey(name: 'qualityAdaptIndication')
  final QualityAdaptIndication? qualityAdaptIndication;
  @JsonKey(name: 'encodedBitrate')
  final int? encodedBitrate;
  @JsonKey(name: 'encodedFrameCount')
  final int? encodedFrameCount;
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RemoteVideoStats {
  const RemoteVideoStats(
      {this.uid,
      this.delay,
      this.width,
      this.height,
      this.receivedBitrate,
      this.decoderOutputFrameRate,
      this.rendererOutputFrameRate,
      this.frameLossRate,
      this.packetLossRate,
      this.rxStreamType,
      this.totalFrozenTime,
      this.frozenRate,
      this.avSyncTimeMs,
      this.totalActiveTime,
      this.publishDuration,
      this.superResolutionType});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;
  @JsonKey(name: 'decoderOutputFrameRate')
  final int? decoderOutputFrameRate;
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;
  @JsonKey(name: 'frameLossRate')
  final int? frameLossRate;
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;
  @JsonKey(name: 'rxStreamType')
  final VideoStreamType? rxStreamType;
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;
  @JsonKey(name: 'avSyncTimeMs')
  final int? avSyncTimeMs;
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;
  @JsonKey(name: 'superResolutionType')
  final int? superResolutionType;
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideoCompositingLayout {
  const VideoCompositingLayout(
      {this.canvasWidth,
      this.canvasHeight,
      this.backgroundColor,
      this.regions,
      this.regionCount,
      this.appData,
      this.appDataLength});

  @JsonKey(name: 'canvasWidth')
  final int? canvasWidth;
  @JsonKey(name: 'canvasHeight')
  final int? canvasHeight;
  @JsonKey(name: 'backgroundColor')
  final String? backgroundColor;
  @JsonKey(name: 'regions')
  final List<Region>? regions;
  @JsonKey(name: 'regionCount')
  final int? regionCount;
  @JsonKey(name: 'appData')
  final int? appData;
  @JsonKey(name: 'appDataLength')
  final int? appDataLength;
  factory VideoCompositingLayout.fromJson(Map<String, dynamic> json) =>
      _$VideoCompositingLayoutFromJson(json);
  Map<String, dynamic> toJson() => _$VideoCompositingLayoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Region {
  const Region(
      {this.uid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.renderMode});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'x')
  final double? x;
  @JsonKey(name: 'y')
  final double? y;
  @JsonKey(name: 'width')
  final double? width;
  @JsonKey(name: 'height')
  final double? height;
  @JsonKey(name: 'zOrder')
  final int? zOrder;
  @JsonKey(name: 'alpha')
  final double? alpha;
  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;
  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InjectStreamConfig {
  const InjectStreamConfig(
      {this.width,
      this.height,
      this.videoGop,
      this.videoFramerate,
      this.videoBitrate,
      this.audioSampleRate,
      this.audioBitrate,
      this.audioChannels});

  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'videoGop')
  final int? videoGop;
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;
  factory InjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$InjectStreamConfigFromJson(json);
  Map<String, dynamic> toJson() => _$InjectStreamConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RtmpStreamLifeCycleType {
  @JsonValue(1)
  rtmpStreamLifeCycleBind2channel,
  @JsonValue(2)
  rtmpStreamLifeCycleBind2owner,
}

extension RtmpStreamLifeCycleTypeExt on RtmpStreamLifeCycleType {
  int value() {
    return _$RtmpStreamLifeCycleTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class PublisherConfiguration {
  const PublisherConfiguration(
      {this.width,
      this.height,
      this.framerate,
      this.bitrate,
      this.defaultLayout,
      this.lifecycle,
      this.owner,
      this.injectStreamWidth,
      this.injectStreamHeight,
      this.injectStreamUrl,
      this.publishUrl,
      this.rawStreamUrl,
      this.extraInfo});

  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'framerate')
  final int? framerate;
  @JsonKey(name: 'bitrate')
  final int? bitrate;
  @JsonKey(name: 'defaultLayout')
  final int? defaultLayout;
  @JsonKey(name: 'lifecycle')
  final int? lifecycle;
  @JsonKey(name: 'owner')
  final bool? owner;
  @JsonKey(name: 'injectStreamWidth')
  final int? injectStreamWidth;
  @JsonKey(name: 'injectStreamHeight')
  final int? injectStreamHeight;
  @JsonKey(name: 'injectStreamUrl')
  final String? injectStreamUrl;
  @JsonKey(name: 'publishUrl')
  final String? publishUrl;
  @JsonKey(name: 'rawStreamUrl')
  final String? rawStreamUrl;
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;
  factory PublisherConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PublisherConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AudioTrackConfig {
  const AudioTrackConfig({this.enableLocalPlayback});

  @JsonKey(name: 'enableLocalPlayback')
  final bool? enableLocalPlayback;
  factory AudioTrackConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AudioTrackConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum CameraDirection {
  @JsonValue(0)
  cameraRear,
  @JsonValue(1)
  cameraFront,
}

extension CameraDirectionExt on CameraDirection {
  int value() {
    return _$CameraDirectionEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum CloudProxyType {
  @JsonValue(0)
  noneProxy,
  @JsonValue(1)
  udpProxy,
  @JsonValue(2)
  tcpProxy,
}

extension CloudProxyTypeExt on CloudProxyType {
  int value() {
    return _$CloudProxyTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class CameraCapturerConfiguration {
  const CameraCapturerConfiguration(
      {this.cameraDirection, this.deviceId, this.format});

  @JsonKey(name: 'cameraDirection')
  final CameraDirection? cameraDirection;
  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'format')
  final VideoFormat? format;
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScreenCaptureConfiguration {
  const ScreenCaptureConfiguration(
      {this.isCaptureWindow,
      this.displayId,
      this.screenRect,
      this.windowId,
      this.params,
      this.regionRect});

  @JsonKey(name: 'isCaptureWindow')
  final bool? isCaptureWindow;
  @JsonKey(name: 'displayId')
  final int? displayId;
  @JsonKey(name: 'screenRect')
  final Rectangle? screenRect;
  @JsonKey(name: 'windowId')
  final int? windowId;
  @JsonKey(name: 'params')
  final ScreenCaptureParameters? params;
  @JsonKey(name: 'regionRect')
  final Rectangle? regionRect;
  factory ScreenCaptureConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenCaptureConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AudioOptionsExternal {
  const AudioOptionsExternal(
      {this.enableAecExternalCustom,
      this.enableAgcExternalCustom,
      this.enableAnsExternalCustom,
      this.aecAggressivenessExternalCustom,
      this.enableAecExternalLoopback});

  @JsonKey(name: 'enable_aec_external_custom_')
  final bool? enableAecExternalCustom;
  @JsonKey(name: 'enable_agc_external_custom_')
  final bool? enableAgcExternalCustom;
  @JsonKey(name: 'enable_ans_external_custom_')
  final bool? enableAnsExternalCustom;
  @JsonKey(name: 'aec_aggressiveness_external_custom_')
  final NlpAggressiveness? aecAggressivenessExternalCustom;
  @JsonKey(name: 'enable_aec_external_loopback_')
  final bool? enableAecExternalLoopback;
  factory AudioOptionsExternal.fromJson(Map<String, dynamic> json) =>
      _$AudioOptionsExternalFromJson(json);
  Map<String, dynamic> toJson() => _$AudioOptionsExternalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Size {
  const Size({this.width, this.height});

  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
  Map<String, dynamic> toJson() => _$SizeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ThumbImageBuffer {
  const ThumbImageBuffer({this.buffer, this.length, this.width, this.height});

  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory ThumbImageBuffer.fromJson(Map<String, dynamic> json) =>
      _$ThumbImageBufferFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbImageBufferToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ScreenCaptureSourceType {
  @JsonValue(-1)
  screencapturesourcetypeUnknown,
  @JsonValue(0)
  screencapturesourcetypeWindow,
  @JsonValue(1)
  screencapturesourcetypeScreen,
  @JsonValue(2)
  screencapturesourcetypeCustom,
}

extension ScreenCaptureSourceTypeExt on ScreenCaptureSourceType {
  int value() {
    return _$ScreenCaptureSourceTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class ScreenCaptureSourceInfo {
  const ScreenCaptureSourceInfo(
      {this.type,
      this.sourceId,
      this.sourceName,
      this.thumbImage,
      this.iconImage,
      this.processPath,
      this.sourceTitle,
      this.primaryMonitor,
      this.isOccluded});

  @JsonKey(name: 'type')
  final ScreenCaptureSourceType? type;
  @JsonKey(name: 'sourceId')
  final int? sourceId;
  @JsonKey(name: 'sourceName')
  final String? sourceName;
  @JsonKey(name: 'thumbImage')
  final ThumbImageBuffer? thumbImage;
  @JsonKey(name: 'iconImage')
  final ThumbImageBuffer? iconImage;
  @JsonKey(name: 'processPath')
  final String? processPath;
  @JsonKey(name: 'sourceTitle')
  final String? sourceTitle;
  @JsonKey(name: 'primaryMonitor')
  final bool? primaryMonitor;
  @JsonKey(name: 'isOccluded')
  final bool? isOccluded;
  factory ScreenCaptureSourceInfo.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureSourceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenCaptureSourceInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChannelMediaOptions {
  const ChannelMediaOptions(
      {this.publishCameraTrack,
      this.publishSecondaryCameraTrack,
      this.publishAudioTrack,
      this.publishScreenTrack,
      this.publishSecondaryScreenTrack,
      this.publishCustomAudioTrack,
      this.publishCustomAudioSourceId,
      this.publishCustomAudioTrackEnableAec,
      this.publishDirectCustomAudioTrack,
      this.publishCustomAudioTrackAec,
      this.publishCustomVideoTrack,
      this.publishEncodedVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerVideoTrack,
      this.publishTrancodedVideoTrack,
      this.autoSubscribeAudio,
      this.autoSubscribeVideo,
      this.startPreview,
      this.enableAudioRecordingOrPlayout,
      this.publishMediaPlayerId,
      this.clientRoleType,
      this.audienceLatencyLevel,
      this.defaultVideoStreamType,
      this.channelProfile,
      this.audioDelayMs,
      this.mediaPlayerAudioDelayMs,
      this.token,
      this.enableBuiltInMediaEncryption,
      this.publishRhythmPlayerTrack,
      this.audioOptionsExternal});

  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;
  @JsonKey(name: 'publishSecondaryCameraTrack')
  final bool? publishSecondaryCameraTrack;
  @JsonKey(name: 'publishAudioTrack')
  final bool? publishAudioTrack;
  @JsonKey(name: 'publishScreenTrack')
  final bool? publishScreenTrack;
  @JsonKey(name: 'publishSecondaryScreenTrack')
  final bool? publishSecondaryScreenTrack;
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;
  @JsonKey(name: 'publishCustomAudioSourceId')
  final int? publishCustomAudioSourceId;
  @JsonKey(name: 'publishCustomAudioTrackEnableAec')
  final bool? publishCustomAudioTrackEnableAec;
  @JsonKey(name: 'publishDirectCustomAudioTrack')
  final bool? publishDirectCustomAudioTrack;
  @JsonKey(name: 'publishCustomAudioTrackAec')
  final bool? publishCustomAudioTrackAec;
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;
  @JsonKey(name: 'publishEncodedVideoTrack')
  final bool? publishEncodedVideoTrack;
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;
  @JsonKey(name: 'publishMediaPlayerVideoTrack')
  final bool? publishMediaPlayerVideoTrack;
  @JsonKey(name: 'publishTrancodedVideoTrack')
  final bool? publishTrancodedVideoTrack;
  @JsonKey(name: 'autoSubscribeAudio')
  final bool? autoSubscribeAudio;
  @JsonKey(name: 'autoSubscribeVideo')
  final bool? autoSubscribeVideo;
  @JsonKey(name: 'startPreview')
  final bool? startPreview;
  @JsonKey(name: 'enableAudioRecordingOrPlayout')
  final bool? enableAudioRecordingOrPlayout;
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;
  @JsonKey(name: 'clientRoleType')
  final ClientRoleType? clientRoleType;
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;
  @JsonKey(name: 'defaultVideoStreamType')
  final VideoStreamType? defaultVideoStreamType;
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;
  @JsonKey(name: 'audioDelayMs')
  final int? audioDelayMs;
  @JsonKey(name: 'mediaPlayerAudioDelayMs')
  final int? mediaPlayerAudioDelayMs;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'enableBuiltInMediaEncryption')
  final bool? enableBuiltInMediaEncryption;
  @JsonKey(name: 'publishRhythmPlayerTrack')
  final bool? publishRhythmPlayerTrack;
  @JsonKey(name: 'audioOptionsExternal')
  final AudioOptionsExternal? audioOptionsExternal;
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum LocalProxyMode {
  @JsonValue(0)
  kConnectivityFirst,
  @JsonValue(1)
  kLocalOnly,
}

extension LocalProxyModeExt on LocalProxyMode {
  int value() {
    return _$LocalProxyModeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class LocalAccessPointConfiguration {
  const LocalAccessPointConfiguration(
      {this.ipList,
      this.ipListSize,
      this.domainList,
      this.domainListSize,
      this.verifyDomainName,
      this.mode});

  @JsonKey(name: 'ipList')
  final List<String>? ipList;
  @JsonKey(name: 'ipListSize')
  final int? ipListSize;
  @JsonKey(name: 'domainList')
  final List<String>? domainList;
  @JsonKey(name: 'domainListSize')
  final int? domainListSize;
  @JsonKey(name: 'verifyDomainName')
  final String? verifyDomainName;
  @JsonKey(name: 'mode')
  final LocalProxyMode? mode;
  factory LocalAccessPointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAccessPointConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAccessPointConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LeaveChannelOptions {
  const LeaveChannelOptions(
      {this.stopAudioMixing, this.stopAllEffect, this.stopMicrophoneRecording});

  @JsonKey(name: 'stopAudioMixing')
  final bool? stopAudioMixing;
  @JsonKey(name: 'stopAllEffect')
  final bool? stopAllEffect;
  @JsonKey(name: 'stopMicrophoneRecording')
  final bool? stopMicrophoneRecording;
  factory LeaveChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$LeaveChannelOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveChannelOptionsToJson(this);
}

class RtcEngineEventHandler {
  const RtcEngineEventHandler({
    this.onJoinChannelSuccess,
    this.onRejoinChannelSuccess,
    this.onWarning,
    this.onError,
    this.onAudioQuality,
    this.onLastmileProbeResult,
    this.onAudioVolumeIndication,
    this.onLeaveChannel,
    this.onRtcStats,
    this.onAudioDeviceStateChanged,
    this.onAudioMixingFinished,
    this.onAudioEffectFinished,
    this.onVideoDeviceStateChanged,
    this.onMediaDeviceChanged,
    this.onNetworkQuality,
    this.onIntraRequestReceived,
    this.onUplinkNetworkInfoUpdated,
    this.onDownlinkNetworkInfoUpdated,
    this.onLastmileQuality,
    this.onFirstLocalVideoFrame,
    this.onFirstLocalVideoFramePublished,
    this.onVideoSourceFrameSizeChanged,
    this.onFirstRemoteVideoDecoded,
    this.onVideoSizeChanged,
    this.onLocalVideoStateChanged,
    this.onRemoteVideoStateChanged,
    this.onFirstRemoteVideoFrame,
    this.onUserJoined,
    this.onUserOffline,
    this.onUserMuteAudio,
    this.onUserMuteVideo,
    this.onUserEnableVideo,
    this.onUserStateChanged,
    this.onUserEnableLocalVideo,
    this.onApiCallExecuted,
    this.onLocalAudioStats,
    this.onRemoteAudioStats,
    this.onLocalVideoStats,
    this.onRemoteVideoStats,
    this.onCameraReady,
    this.onCameraFocusAreaChanged,
    this.onCameraExposureAreaChanged,
    this.onFacePositionChanged,
    this.onVideoStopped,
    this.onAudioMixingStateChanged,
    this.onRhythmPlayerStateChanged,
    this.onConnectionLost,
    this.onConnectionInterrupted,
    this.onConnectionBanned,
    this.onStreamMessage,
    this.onStreamMessageError,
    this.onRequestToken,
    this.onTokenPrivilegeWillExpire,
    this.onFirstLocalAudioFramePublished,
    this.onFirstRemoteAudioFrame,
    this.onFirstRemoteAudioDecoded,
    this.onLocalAudioStateChanged,
    this.onRemoteAudioStateChanged,
    this.onActiveSpeaker,
    this.onContentInspectResult,
    this.onSnapshotTaken,
    this.onClientRoleChanged,
    this.onClientRoleChangeFailed,
    this.onAudioDeviceVolumeChanged,
    this.onRtmpStreamingStateChanged,
    this.onRtmpStreamingEvent,
    this.onStreamPublished,
    this.onStreamUnpublished,
    this.onTranscodingUpdated,
    this.onAudioRoutingChanged,
    this.onChannelMediaRelayStateChanged,
    this.onChannelMediaRelayEvent,
    this.onLocalPublishFallbackToAudioOnly,
    this.onRemoteSubscribeFallbackToAudioOnly,
    this.onRemoteAudioTransportStats,
    this.onRemoteVideoTransportStats,
    this.onConnectionStateChanged,
    this.onNetworkTypeChanged,
    this.onEncryptionError,
    this.onPermissionError,
    this.onLocalUserRegistered,
    this.onUserInfoUpdated,
    this.onUploadLogResult,
    this.onAudioSubscribeStateChanged,
    this.onVideoSubscribeStateChanged,
    this.onAudioPublishStateChanged,
    this.onVideoPublishStateChanged,
    this.onExtensionEvent,
    this.onExtensionStarted,
    this.onExtensionStopped,
    this.onExtensionErrored,
    this.onUserAccountUpdated,
  });

  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccess;

  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccess;

  final void Function(int warn, String msg)? onWarning;

  final void Function(int err, String msg)? onError;

  final void Function(RtcConnection connection, int remoteUid, int quality,
      int delay, int lost)? onAudioQuality;

  final void Function(LastmileProbeResult result)? onLastmileProbeResult;

  final void Function(RtcConnection connection, AudioVolumeInfo speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndication;

  final void Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  final void Function(RtcConnection connection, RtcStats stats)? onRtcStats;

  final void Function(String deviceId, int deviceType, int deviceState)?
      onAudioDeviceStateChanged;

  final void Function()? onAudioMixingFinished;

  final void Function(int soundId)? onAudioEffectFinished;

  final void Function(String deviceId, int deviceType, int deviceState)?
      onVideoDeviceStateChanged;

  final void Function(int deviceType)? onMediaDeviceChanged;

  final void Function(RtcConnection connection, int remoteUid, int txQuality,
      int rxQuality)? onNetworkQuality;

  final void Function(RtcConnection connection)? onIntraRequestReceived;

  final void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated;

  final void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated;

  final void Function(int quality)? onLastmileQuality;

  final void Function(
          RtcConnection connection, int width, int height, int elapsed)?
      onFirstLocalVideoFrame;

  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalVideoFramePublished;

  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int width, int height)? onVideoSourceFrameSizeChanged;

  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecoded;

  final void Function(RtcConnection connection, int uid, int width, int height,
      int rotation)? onVideoSizeChanged;

  final void Function(RtcConnection connection, LocalVideoStreamState state,
      LocalVideoStreamError errorCode)? onLocalVideoStateChanged;

  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChanged;

  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrame;

  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoined;

  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOffline;

  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudio;

  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideo;

  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideo;

  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChanged;

  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideo;

  final void Function(int err, String api, String result)? onApiCallExecuted;

  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStats;

  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStats;

  final void Function(RtcConnection connection, LocalVideoStats stats)?
      onLocalVideoStats;

  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStats;

  final void Function()? onCameraReady;

  final void Function(int x, int y, int width, int height)?
      onCameraFocusAreaChanged;

  final void Function(int x, int y, int width, int height)?
      onCameraExposureAreaChanged;

  final void Function(int imageWidth, int imageHeight, Rectangle vecRectangle,
      int vecDistance, int numFaces)? onFacePositionChanged;

  final void Function()? onVideoStopped;

  final void Function(
          AudioMixingStateType state, AudioMixingErrorType errorCode)?
      onAudioMixingStateChanged;

  final void Function(
          RhythmPlayerStateType state, RhythmPlayerErrorType errorCode)?
      onRhythmPlayerStateChanged;

  final void Function(RtcConnection connection)? onConnectionLost;

  final void Function(RtcConnection connection)? onConnectionInterrupted;

  final void Function(RtcConnection connection)? onConnectionBanned;

  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;

  final void Function(RtcConnection connection, int remoteUid, int streamId,
      int code, int missed, int cached)? onStreamMessageError;

  final void Function(RtcConnection connection)? onRequestToken;

  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpire;

  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublished;

  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrame;

  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecoded;

  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamError error)? onLocalAudioStateChanged;

  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChanged;

  final void Function(RtcConnection connection, int uid)? onActiveSpeaker;

  final void Function(ContentInspectResult result)? onContentInspectResult;

  final void Function(RtcConnection connection, String filePath, int width,
      int height, int errCode)? onSnapshotTaken;

  final void Function(RtcConnection connection, ClientRoleType oldRole,
      ClientRoleType newRole)? onClientRoleChanged;

  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailed;

  final void Function(MediaDeviceType deviceType, int volume, bool muted)?
      onAudioDeviceVolumeChanged;

  final void Function(String url, RtmpStreamPublishState state,
      RtmpStreamPublishErrorType errCode)? onRtmpStreamingStateChanged;

  final void Function(String url, RtmpStreamingEvent eventCode)?
      onRtmpStreamingEvent;

  final void Function(String url, int error)? onStreamPublished;

  final void Function(String url)? onStreamUnpublished;

  final void Function()? onTranscodingUpdated;

  final void Function(int routing)? onAudioRoutingChanged;

  final void Function(
          ChannelMediaRelayState state, ChannelMediaRelayError code)?
      onChannelMediaRelayStateChanged;

  final void Function(int code)? onChannelMediaRelayEvent;

  final void Function(bool isFallbackOrRecover)?
      onLocalPublishFallbackToAudioOnly;

  final void Function(int uid, bool isFallbackOrRecover)?
      onRemoteSubscribeFallbackToAudioOnly;

  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStats;

  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStats;

  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChanged;

  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChanged;

  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionError;

  final void Function(PermissionType permissionType)? onPermissionError;

  final void Function(int uid, String userAccount)? onLocalUserRegistered;

  final void Function(int uid, UserInfo info)? onUserInfoUpdated;

  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResult;

  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onAudioSubscribeStateChanged;

  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onVideoSubscribeStateChanged;

  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onAudioPublishStateChanged;

  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onVideoPublishStateChanged;

  final void Function(
          String provider, String extName, String key, String value)?
      onExtensionEvent;

  final void Function(String provider, String extName)? onExtensionStarted;

  final void Function(String provider, String extName)? onExtensionStopped;

  final void Function(String provider, String extName, int error, String msg)?
      onExtensionErrored;

  final void Function(
          RtcConnection connection, int remoteUid, String userAccount)?
      onUserAccountUpdated;
}

abstract class VideoDeviceManager {
  List<VideoDeviceInfo> enumerateVideoDevices();

  void setDevice(String deviceIdUTF8);

  String getDevice();

  void startDeviceTest(int hwnd);

  void stopDeviceTest();

  void release();
}

@JsonSerializable(explicitToJson: true)
class RtcEngineContext {
  const RtcEngineContext(
      {this.appId,
      this.enableAudioDevice,
      this.channelProfile,
      this.audioScenario,
      this.areaCode,
      this.logConfig,
      this.threadPriority,
      this.useExternalEglContext});

  @JsonKey(name: 'appId')
  final String? appId;
  @JsonKey(name: 'enableAudioDevice')
  final bool? enableAudioDevice;
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;
  @JsonKey(name: 'audioScenario')
  final AudioScenarioType? audioScenario;
  @JsonKey(name: 'areaCode')
  final int? areaCode;
  @JsonKey(name: 'logConfig')
  final LogConfig? logConfig;
  @JsonKey(name: 'threadPriority')
  final ThreadPriorityType? threadPriority;
  @JsonKey(name: 'useExternalEglContext')
  final bool? useExternalEglContext;
  factory RtcEngineContext.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineContextFromJson(json);
  Map<String, dynamic> toJson() => _$RtcEngineContextToJson(this);
}

class MetadataObserver {
  const MetadataObserver({
    this.onMetadataReceived,
  });

  final void Function(Metadata metadata)? onMetadataReceived;
}

@JsonEnum(alwaysCreate: true)
enum MetadataType {
  @JsonValue(-1)
  unknownMetadata,
  @JsonValue(0)
  videoMetadata,
}

extension MetadataTypeExt on MetadataType {
  int value() {
    return _$MetadataTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MaxMetadataSizeType {
  @JsonValue(-1)
  invalidMetadataSizeInByte,
  @JsonValue(512)
  defaultMetadataSizeInByte,
  @JsonValue(1024)
  maxMetadataSizeInByte,
}

extension MaxMetadataSizeTypeExt on MaxMetadataSizeType {
  int value() {
    return _$MaxMetadataSizeTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class Metadata {
  const Metadata({this.uid, this.size, this.buffer, this.timeStampMs});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;
  @JsonKey(name: 'timeStampMs')
  final int? timeStampMs;
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingError {
  @JsonValue(0)
  directCdnStreamingErrorOk,
  @JsonValue(1)
  directCdnStreamingErrorFailed,
  @JsonValue(2)
  directCdnStreamingErrorAudioPublication,
  @JsonValue(3)
  directCdnStreamingErrorVideoPublication,
  @JsonValue(4)
  directCdnStreamingErrorNetConnect,
  @JsonValue(5)
  directCdnStreamingErrorBadName,
}

extension DirectCdnStreamingErrorExt on DirectCdnStreamingError {
  int value() {
    return _$DirectCdnStreamingErrorEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingState {
  @JsonValue(0)
  directCdnStreamingStateIdle,
  @JsonValue(1)
  directCdnStreamingStateRunning,
  @JsonValue(2)
  directCdnStreamingStateStopped,
  @JsonValue(3)
  directCdnStreamingStateFailed,
  @JsonValue(4)
  directCdnStreamingStateRecovering,
}

extension DirectCdnStreamingStateExt on DirectCdnStreamingState {
  int value() {
    return _$DirectCdnStreamingStateEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingStats {
  const DirectCdnStreamingStats(
      {this.videoWidth,
      this.videoHeight,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});

  @JsonKey(name: 'videoWidth')
  final int? videoWidth;
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;
  @JsonKey(name: 'fps')
  final int? fps;
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;
  factory DirectCdnStreamingStats.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingStatsFromJson(json);
  Map<String, dynamic> toJson() => _$DirectCdnStreamingStatsToJson(this);
}

class DirectCdnStreamingEventHandler {
  const DirectCdnStreamingEventHandler({
    this.onDirectCdnStreamingStateChanged,
    this.onDirectCdnStreamingStats,
  });

  final void Function(
      DirectCdnStreamingState state,
      DirectCdnStreamingError error,
      String message)? onDirectCdnStreamingStateChanged;

  final void Function(DirectCdnStreamingStats stats)? onDirectCdnStreamingStats;
}

@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingMediaOptions {
  const DirectCdnStreamingMediaOptions(
      {this.publishCameraTrack,
      this.publishMicrophoneTrack,
      this.publishCustomAudioTrack,
      this.publishCustomVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerId});

  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;
  factory DirectCdnStreamingMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingMediaOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$DirectCdnStreamingMediaOptionsToJson(this);
}

abstract class RtcEngine {
  Future<void> release({bool sync = false});

  void initialize(RtcEngineContext context);

  SDKBuildInfo getVersion();

  String getErrorDescription(int code);

  void joinChannel(
      {required String token,
      required String channelId,
      required String info,
      required int uid});

  void joinChannel2(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options});

  void updateChannelMediaOptions(ChannelMediaOptions options);

  void leaveChannel();

  void leaveChannel2(LeaveChannelOptions options);

  void renewToken(String token);

  void setChannelProfile(ChannelProfileType profile);

  void setClientRole(ClientRoleType role);

  void setClientRole2(
      {required ClientRoleType role, required ClientRoleOptions options});

  void startEchoTest();

  void startEchoTest2(int intervalInSeconds);

  void stopEchoTest();

  void enableVideo();

  void disableVideo();

  void startPreview();

  void startPreview2(VideoSourceType sourceType);

  void stopPreview();

  void stopPreview2(VideoSourceType sourceType);

  void startLastmileProbeTest(LastmileProbeConfig config);

  void stopLastmileProbeTest();

  void setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  void setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  void enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource});

  void enableRemoteSuperResolution({required int userId, required bool enable});

  void setupRemoteVideo(VideoCanvas canvas);

  void setupLocalVideo(VideoCanvas canvas);

  void enableAudio();

  void disableAudio();

  void setAudioProfile(
      {required AudioProfileType profile, required AudioScenarioType scenario});

  void setAudioProfile2(AudioProfileType profile);

  void enableLocalAudio(bool enabled);

  void muteLocalAudioStream(bool mute);

  void muteAllRemoteAudioStreams(bool mute);

  void setDefaultMuteAllRemoteAudioStreams(bool mute);

  void muteRemoteAudioStream({required int uid, required bool mute});

  void muteLocalVideoStream(bool mute);

  void enableLocalVideo(bool enabled);

  void muteAllRemoteVideoStreams(bool mute);

  void setDefaultMuteAllRemoteVideoStreams(bool mute);

  void muteRemoteVideoStream({required int uid, required bool mute});

  void setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType});

  void setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  void enableAudioVolumeIndication(
      {required int interval, required int smooth, required bool reportVad});

  void startAudioRecording(
      {required String filePath, required AudioRecordingQualityType quality});

  void startAudioRecording2(
      {required String filePath,
      required int sampleRate,
      required AudioRecordingQualityType quality});

  void startAudioRecording3(AudioRecordingConfiguration config);

  void stopAudioRecording();

  MediaPlayer createMediaPlayer();

  void destroyMediaPlayer(MediaPlayer mediaPlayer);

  void startAudioMixing(
      {required String filePath,
      required bool loopback,
      required bool replace,
      required int cycle});

  void startAudioMixing2(
      {required String filePath,
      required bool loopback,
      required bool replace,
      required int cycle,
      required int startPos});

  void stopAudioMixing();

  void pauseAudioMixing();

  void resumeAudioMixing();

  void adjustAudioMixingVolume(int volume);

  void adjustAudioMixingPublishVolume(int volume);

  void getAudioMixingPublishVolume();

  void adjustAudioMixingPlayoutVolume(int volume);

  void getAudioMixingPlayoutVolume();

  void getAudioMixingDuration();

  void getAudioMixingCurrentPosition();

  void setAudioMixingPosition(int pos);

  void setAudioMixingPitch(int pitch);

  void getEffectsVolume();

  void setEffectsVolume(int volume);

  void preloadEffect(
      {required int soundId, required String filePath, int startPos = 0});

  void playEffect(
      {required int soundId,
      required String filePath,
      required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false,
      int startPos = 0});

  void playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false});

  void getVolumeOfEffect(int soundId);

  void setVolumeOfEffect({required int soundId, required int volume});

  void pauseEffect(int soundId);

  void pauseAllEffects();

  void resumeEffect(int soundId);

  void resumeAllEffects();

  void stopEffect(int soundId);

  void stopAllEffects();

  void unloadEffect(int soundId);

  void unloadAllEffects();

  void enableSoundPositionIndication(bool enabled);

  void setRemoteVoicePosition(
      {required int uid, required double pan, required double gain});

  void enableSpatialAudio(bool enabled);

  void setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params});

  void setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  void setAudioEffectPreset(AudioEffectPreset preset);

  void setVoiceConversionPreset(VoiceConversionPreset preset);

  void setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2});

  void setVoiceBeautifierParameters(
      {required VoiceBeautifierPreset preset,
      required int param1,
      required int param2});

  void setVoiceConversionParameters(
      {required VoiceConversionPreset preset,
      required int param1,
      required int param2});

  void setLocalVoicePitch(double pitch);

  void setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain});

  void setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value});

  void setLogFile(String filePath);

  void setLogFilter(int filter);

  void setLogLevel(LogLevel level);

  void setLogFileSize(int fileSizeInKBytes);

  void uploadLogFile(String requestId);

  void setLocalRenderMode(
      {required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  void setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  void setLocalRenderMode2(RenderModeType renderMode);

  void setLocalVideoMirrorMode(VideoMirrorModeType mirrorMode);

  void enableDualStreamMode(bool enabled);

  void enableDualStreamMode2(
      {required VideoSourceType sourceType, required bool enabled});

  void enableDualStreamMode3(
      {required VideoSourceType sourceType,
      required bool enabled,
      required SimulcastStreamConfig streamConfig});

  void enableEchoCancellationExternal(
      {required bool enabled, required int audioSourceDelay});

  void enableCustomAudioLocalPlayback(
      {required int sourceId, required bool enabled});

  void startPrimaryCustomAudioTrack(AudioTrackConfig config);

  void stopPrimaryCustomAudioTrack();

  void startSecondaryCustomAudioTrack(AudioTrackConfig config);

  void stopSecondaryCustomAudioTrack();

  void setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  void setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  void setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall});

  void setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel});

  void enableAudioSpectrumMonitor({int intervalInMS = 100});

  void disableAudioSpectrumMonitor();

  void adjustRecordingSignalVolume(int volume);

  void muteRecordingSignal(bool mute);

  void adjustPlaybackSignalVolume(int volume);

  void adjustUserPlaybackSignalVolume({required int uid, required int volume});

  void setLocalPublishFallbackOption(StreamFallbackOptions option);

  void setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  void enableLoopbackRecording({required bool enabled, String? deviceName});

  void adjustLoopbackRecordingVolume(int volume);

  void getLoopbackRecordingVolume();

  void enableInEarMonitoring(
      {required bool enabled, required int includeAudioFilters});

  void setInEarMonitoringVolume(int volume);

  void loadExtensionProvider(String extensionLibPath);

  void setExtensionProviderProperty(
      {required String provider, required String key, required String value});

  void enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  void setExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required String value,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  String getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  void setCameraCapturerConfiguration(CameraCapturerConfiguration config);

  void switchCamera();

  bool isCameraZoomSupported();

  bool isCameraFaceDetectSupported();

  bool isCameraTorchSupported();

  bool isCameraFocusSupported();

  bool isCameraAutoFocusFaceModeSupported();

  void setCameraZoomFactor(double factor);

  void enableFaceDetection(bool enabled);

  double getCameraMaxZoomFactor();

  void setCameraFocusPositionInPreview(
      {required double positionX, required double positionY});

  void setCameraTorchOn(bool isOn);

  void setCameraAutoFocusFaceModeEnabled(bool enabled);

  bool isCameraExposurePositionSupported();

  void setCameraExposurePosition(
      {required double positionXinView, required double positionYinView});

  bool isCameraAutoExposureFaceModeSupported();

  void setCameraAutoExposureFaceModeEnabled(bool enabled);

  void setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  void setEnableSpeakerphone(bool speakerOn);

  bool isSpeakerphoneEnabled();

  List<ScreenCaptureSourceInfo> getScreenCaptureSources(
      {required Size thumbSize,
      required Size iconSize,
      required bool includeScreen});

  void setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  void startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  void startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  DeviceInfo getAudioDeviceInfo();

  void startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  void setScreenCaptureContentHint(VideoContentHint contentHint);

  void updateScreenCaptureRegion(Rectangle regionRect);

  void updateScreenCaptureParameters(ScreenCaptureParameters captureParams);

  void stopScreenCapture();

  String getCallId();

  void rate(
      {required String callId,
      required int rating,
      required String description});

  void complain({required String callId, required String description});

  void addPublishStreamUrl(
      {required String url, required bool transcodingEnabled});

  void removePublishStreamUrl(String url);

  void setLiveTranscoding(LiveTranscoding transcoding);

  void startRtmpStreamWithoutTranscoding(String url);

  void startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding});

  void updateRtmpTranscoding(LiveTranscoding transcoding);

  void stopRtmpStream(String url);

  void startLocalVideoTranscoder(LocalTranscoderConfiguration config);

  void updateLocalTranscoderConfiguration(LocalTranscoderConfiguration config);

  void stopLocalVideoTranscoder();

  void startPrimaryCameraCapture(CameraCapturerConfiguration config);

  void startSecondaryCameraCapture(CameraCapturerConfiguration config);

  void stopPrimaryCameraCapture();

  void stopSecondaryCameraCapture();

  void setCameraDeviceOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  void setScreenCaptureOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  void startPrimaryScreenCapture(ScreenCaptureConfiguration config);

  void startSecondaryScreenCapture(ScreenCaptureConfiguration config);

  void stopPrimaryScreenCapture();

  void stopSecondaryScreenCapture();

  ConnectionStateType getConnectionState();

  void registerEventHandler(RtcEngineEventHandler eventHandler);

  void unregisterEventHandler(RtcEngineEventHandler eventHandler);

  void setRemoteUserPriority(
      {required int uid, required PriorityType userPriority});

  void setEncryptionMode(String encryptionMode);

  void setEncryptionSecret(String secret);

  void enableEncryption(
      {required bool enabled, required EncryptionConfig config});

  int createDataStream({required bool reliable, required bool ordered});

  int createDataStream2(DataStreamConfig config);

  void sendStreamMessage(
      {required int streamId, required Uint8List data, required int length});

  void addVideoWatermark(RtcImage watermark);

  void addVideoWatermark2(
      {required String watermarkUrl, required WatermarkOptions options});

  void clearVideoWatermark();

  void clearVideoWatermarks();

  void addInjectStreamUrl(
      {required String url, required InjectStreamConfig config});

  void removeInjectStreamUrl(String url);

  void pauseAudio();

  void resumeAudio();

  void enableWebSdkInteroperability(bool enabled);

  void sendCustomReportMessage(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value});

  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  void startAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location,
      required String uuid,
      required String passwd,
      required int durationMs,
      required bool autoUpload});

  void stopAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location});

  void registerLocalUserAccount(
      {required String appId, required String userAccount});

  void joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount});

  void joinChannelWithUserAccount2(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  void joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  UserInfo getUserInfoByUserAccount(String userAccount);

  UserInfo getUserInfoByUid(int uid);

  void startChannelMediaRelay(ChannelMediaRelayConfiguration configuration);

  void updateChannelMediaRelay(ChannelMediaRelayConfiguration configuration);

  void stopChannelMediaRelay();

  void pauseAllChannelMediaRelay();

  void resumeAllChannelMediaRelay();

  void setDirectCdnStreamingAudioConfiguration(AudioProfileType profile);

  void setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config);

  void startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options});

  void stopDirectCdnStreaming();

  void updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options);

  void takeSnapshot(
      {required SnapShotConfig config, required SnapshotCallback callback});

  void setContentInspect(ContentInspectConfig config);

  void switchChannel({required String token, required String channel});

  void startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config});

  void stopRhythmPlayer();

  void configRhythmPlayer(AgoraRhythmPlayerConfig config);

  void adjustCustomAudioPublishVolume(
      {required int sourceId, required int volume});

  void adjustCustomAudioPlayoutVolume(
      {required int sourceId, required int volume});

  void setCloudProxy(CloudProxyType proxyType);

  void setLocalAccessPoint(LocalAccessPointConfiguration config);

  void enableFishCorrection(
      {required bool enabled, required FishCorrectionParams params});

  AdvancedAudioOptions setAdvancedAudioOptions();

  void setAVSyncSource({required String channelId, required int uid});

  AudioDeviceManager getAudioDeviceManager();

  VideoDeviceManager getVideoDeviceManager();

  void sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  void setMaxMetadataSize(int size);
}

@JsonEnum(alwaysCreate: true)
enum QualityReportFormatType {
  @JsonValue(0)
  qualityReportJson,
  @JsonValue(1)
  qualityReportHtml,
}

extension QualityReportFormatTypeExt on QualityReportFormatType {
  int value() {
    return _$QualityReportFormatTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MediaDeviceStateType {
  @JsonValue(0)
  mediaDeviceStateIdle,
  @JsonValue(1)
  mediaDeviceStateActive,
  @JsonValue(2)
  mediaDeviceStateDisabled,
  @JsonValue(4)
  mediaDeviceStateNotPresent,
  @JsonValue(8)
  mediaDeviceStateUnplugged,
}

extension MediaDeviceStateTypeExt on MediaDeviceStateType {
  int value() {
    return _$MediaDeviceStateTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoProfileType {
  @JsonValue(0)
  videoProfileLandscape120p,
  @JsonValue(2)
  videoProfileLandscape120p3,
  @JsonValue(10)
  videoProfileLandscape180p,
  @JsonValue(12)
  videoProfileLandscape180p3,
  @JsonValue(13)
  videoProfileLandscape180p4,
  @JsonValue(20)
  videoProfileLandscape240p,
  @JsonValue(22)
  videoProfileLandscape240p3,
  @JsonValue(23)
  videoProfileLandscape240p4,
  @JsonValue(30)
  videoProfileLandscape360p,
  @JsonValue(32)
  videoProfileLandscape360p3,
  @JsonValue(33)
  videoProfileLandscape360p4,
  @JsonValue(35)
  videoProfileLandscape360p6,
  @JsonValue(36)
  videoProfileLandscape360p7,
  @JsonValue(37)
  videoProfileLandscape360p8,
  @JsonValue(38)
  videoProfileLandscape360p9,
  @JsonValue(39)
  videoProfileLandscape360p10,
  @JsonValue(100)
  videoProfileLandscape360p11,
  @JsonValue(40)
  videoProfileLandscape480p,
  @JsonValue(42)
  videoProfileLandscape480p3,
  @JsonValue(43)
  videoProfileLandscape480p4,
  @JsonValue(45)
  videoProfileLandscape480p6,
  @JsonValue(47)
  videoProfileLandscape480p8,
  @JsonValue(48)
  videoProfileLandscape480p9,
  @JsonValue(49)
  videoProfileLandscape480p10,
  @JsonValue(50)
  videoProfileLandscape720p,
  @JsonValue(52)
  videoProfileLandscape720p3,
  @JsonValue(54)
  videoProfileLandscape720p5,
  @JsonValue(55)
  videoProfileLandscape720p6,
  @JsonValue(60)
  videoProfileLandscape1080p,
  @JsonValue(62)
  videoProfileLandscape1080p3,
  @JsonValue(64)
  videoProfileLandscape1080p5,
  @JsonValue(66)
  videoProfileLandscape1440p,
  @JsonValue(67)
  videoProfileLandscape1440p2,
  @JsonValue(70)
  videoProfileLandscape4k,
  @JsonValue(72)
  videoProfileLandscape4k3,
  @JsonValue(1000)
  videoProfilePortrait120p,
  @JsonValue(1002)
  videoProfilePortrait120p3,
  @JsonValue(1010)
  videoProfilePortrait180p,
  @JsonValue(1012)
  videoProfilePortrait180p3,
  @JsonValue(1013)
  videoProfilePortrait180p4,
  @JsonValue(1020)
  videoProfilePortrait240p,
  @JsonValue(1022)
  videoProfilePortrait240p3,
  @JsonValue(1023)
  videoProfilePortrait240p4,
  @JsonValue(1030)
  videoProfilePortrait360p,
  @JsonValue(1032)
  videoProfilePortrait360p3,
  @JsonValue(1033)
  videoProfilePortrait360p4,
  @JsonValue(1035)
  videoProfilePortrait360p6,
  @JsonValue(1036)
  videoProfilePortrait360p7,
  @JsonValue(1037)
  videoProfilePortrait360p8,
  @JsonValue(1038)
  videoProfilePortrait360p9,
  @JsonValue(1039)
  videoProfilePortrait360p10,
  @JsonValue(1100)
  videoProfilePortrait360p11,
  @JsonValue(1040)
  videoProfilePortrait480p,
  @JsonValue(1042)
  videoProfilePortrait480p3,
  @JsonValue(1043)
  videoProfilePortrait480p4,
  @JsonValue(1045)
  videoProfilePortrait480p6,
  @JsonValue(1047)
  videoProfilePortrait480p8,
  @JsonValue(1048)
  videoProfilePortrait480p9,
  @JsonValue(1049)
  videoProfilePortrait480p10,
  @JsonValue(1050)
  videoProfilePortrait720p,
  @JsonValue(1052)
  videoProfilePortrait720p3,
  @JsonValue(1054)
  videoProfilePortrait720p5,
  @JsonValue(1055)
  videoProfilePortrait720p6,
  @JsonValue(1060)
  videoProfilePortrait1080p,
  @JsonValue(1062)
  videoProfilePortrait1080p3,
  @JsonValue(1064)
  videoProfilePortrait1080p5,
  @JsonValue(1066)
  videoProfilePortrait1440p,
  @JsonValue(1067)
  videoProfilePortrait1440p2,
  @JsonValue(1070)
  videoProfilePortrait4k,
  @JsonValue(1072)
  videoProfilePortrait4k3,
  @JsonValue(30)
  videoProfileDefault,
}

extension VideoProfileTypeExt on VideoProfileType {
  int value() {
    return _$VideoProfileTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class SDKBuildInfo {
  const SDKBuildInfo({this.buildNumber, this.version});

  @JsonKey(name: 'build_number')
  final int? buildNumber;
  @JsonKey(name: 'version')
  final String? version;
  factory SDKBuildInfo.fromJson(Map<String, dynamic> json) =>
      _$SDKBuildInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SDKBuildInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideoDeviceInfo {
  const VideoDeviceInfo({this.deviceId, this.deviceName});

  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'deviceName')
  final String? deviceName;
  factory VideoDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoDeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDeviceInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AudioDeviceInfo {
  const AudioDeviceInfo({this.deviceId, this.deviceName});

  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'deviceName')
  final String? deviceName;
  factory AudioDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioDeviceInfoToJson(this);
}
