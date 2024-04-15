import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

/// @nodoc
const defaultConnectionId = 0;

/// @nodoc
const dummyConnectionId = 4294967295;

/// The type of the audio route.
///
@JsonEnum(alwaysCreate: true)
enum AudioRoute {
  /// -1: Default audio route.
  @JsonValue(-1)
  routeDefault,

  /// Audio output routing is a headset with microphone.
  @JsonValue(0)
  routeHeadset,

  /// 1: The audio route is an earpiece.
  @JsonValue(1)
  routeEarpiece,

  /// 2: The audio route is a headset without a microphone.
  @JsonValue(2)
  routeHeadsetnomic,

  /// 3: The audio route is the speaker that comes with the device.
  @JsonValue(3)
  routeSpeakerphone,

  /// @nodoc
  @JsonValue(4)
  routeLoudspeaker,

  /// 5: The audio route is a bluetooth headset.
  @JsonValue(5)
  routeHeadsetbluetooth,

  /// @nodoc
  @JsonValue(6)
  routeUsb,

  /// @nodoc
  @JsonValue(7)
  routeHdmi,

  /// @nodoc
  @JsonValue(8)
  routeDisplayport,

  /// @nodoc
  @JsonValue(9)
  routeAirplay,
}

/// @nodoc
extension AudioRouteExt on AudioRoute {
  /// @nodoc
  static AudioRoute fromValue(int value) {
    return $enumDecode(_$AudioRouteEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioRouteEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum BytesPerSample {
  /// @nodoc
  @JsonValue(2)
  twoBytesPerSample,
}

/// @nodoc
extension BytesPerSampleExt on BytesPerSample {
  /// @nodoc
  static BytesPerSample fromValue(int value) {
    return $enumDecode(_$BytesPerSampleEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$BytesPerSampleEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioParameters {
  /// @nodoc
  const AudioParameters({this.sampleRate, this.channels, this.framesPerBuffer});

  /// @nodoc
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// @nodoc
  @JsonKey(name: 'channels')
  final int? channels;

  /// @nodoc
  @JsonKey(name: 'frames_per_buffer')
  final int? framesPerBuffer;

  /// @nodoc
  factory AudioParameters.fromJson(Map<String, dynamic> json) =>
      _$AudioParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioParametersToJson(this);
}

/// The use mode of the audio data.
///
@JsonEnum(alwaysCreate: true)
enum RawAudioFrameOpModeType {
  /// 0: Read-only mode:
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,

  /// 2: Read and write mode:
  @JsonValue(2)
  rawAudioFrameOpModeReadWrite,
}

/// @nodoc
extension RawAudioFrameOpModeTypeExt on RawAudioFrameOpModeType {
  /// @nodoc
  static RawAudioFrameOpModeType fromValue(int value) {
    return $enumDecode(_$RawAudioFrameOpModeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RawAudioFrameOpModeTypeEnumMap[this]!;
  }
}

/// Media source type.
///
@JsonEnum(alwaysCreate: true)
enum MediaSourceType {
  /// 0: Audio playback device.
  @JsonValue(0)
  audioPlayoutSource,

  /// 1: Audio capturing device.
  @JsonValue(1)
  audioRecordingSource,

  /// @nodoc
  @JsonValue(2)
  primaryCameraSource,

  /// @nodoc
  @JsonValue(3)
  secondaryCameraSource,

  /// @nodoc
  @JsonValue(4)
  primaryScreenSource,

  /// @nodoc
  @JsonValue(5)
  secondaryScreenSource,

  /// @nodoc
  @JsonValue(6)
  customVideoSource,

  /// @nodoc
  @JsonValue(7)
  mediaPlayerSource,

  /// @nodoc
  @JsonValue(8)
  rtcImagePngSource,

  /// @nodoc
  @JsonValue(9)
  rtcImageJpegSource,

  /// @nodoc
  @JsonValue(10)
  rtcImageGifSource,

  /// @nodoc
  @JsonValue(11)
  remoteVideoSource,

  /// @nodoc
  @JsonValue(12)
  transcodedVideoSource,

  /// @nodoc
  @JsonValue(100)
  unknownMediaSource,
}

/// @nodoc
extension MediaSourceTypeExt on MediaSourceType {
  /// @nodoc
  static MediaSourceType fromValue(int value) {
    return $enumDecode(_$MediaSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaSourceTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ContentInspectResult {
  /// @nodoc
  @JsonValue(1)
  contentInspectNeutral,

  /// @nodoc
  @JsonValue(2)
  contentInspectSexy,

  /// @nodoc
  @JsonValue(3)
  contentInspectPorn,
}

/// @nodoc
extension ContentInspectResultExt on ContentInspectResult {
  /// @nodoc
  static ContentInspectResult fromValue(int value) {
    return $enumDecode(_$ContentInspectResultEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ContentInspectResultEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ContentInspectType {
  /// @nodoc
  @JsonValue(0)
  contentInspectInvalid,

  /// @nodoc
  @JsonValue(1)
  contentInspectModeration,

  /// @nodoc
  @JsonValue(2)
  contentInspectSupervision,
}

/// @nodoc
extension ContentInspectTypeExt on ContentInspectType {
  /// @nodoc
  static ContentInspectType fromValue(int value) {
    return $enumDecode(_$ContentInspectTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ContentInspectTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class ContentInspectModule {
  /// @nodoc
  const ContentInspectModule({this.type, this.interval});

  /// @nodoc
  @JsonKey(name: 'type')
  final ContentInspectType? type;

  /// @nodoc
  @JsonKey(name: 'interval')
  final int? interval;

  /// @nodoc
  factory ContentInspectModule.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectModuleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ContentInspectModuleToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class ContentInspectConfig {
  /// @nodoc
  const ContentInspectConfig({this.extraInfo, this.modules, this.moduleCount});

  /// @nodoc
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  /// @nodoc
  @JsonKey(name: 'modules')
  final List<ContentInspectModule>? modules;

  /// @nodoc
  @JsonKey(name: 'moduleCount')
  final int? moduleCount;

  /// @nodoc
  factory ContentInspectConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ContentInspectConfigToJson(this);
}

/// @nodoc
const kMaxCodecNameLength = 50;

/// @nodoc
@JsonSerializable(explicitToJson: true)
class PacketOptions {
  /// @nodoc
  const PacketOptions({this.timestamp, this.audioLevelIndication});

  /// @nodoc
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// @nodoc
  @JsonKey(name: 'audioLevelIndication')
  final int? audioLevelIndication;

  /// @nodoc
  factory PacketOptions.fromJson(Map<String, dynamic> json) =>
      _$PacketOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PacketOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameInfo {
  /// @nodoc
  const AudioEncodedFrameInfo({this.sendTs, this.codec});

  /// @nodoc
  @JsonKey(name: 'sendTs')
  final int? sendTs;

  /// @nodoc
  @JsonKey(name: 'codec')
  final int? codec;

  /// @nodoc
  factory AudioEncodedFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioEncodedFrameInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioPcmFrame {
  /// @nodoc
  const AudioPcmFrame(
      {this.captureTimestamp,
      this.samplesPerChannel,
      this.sampleRateHz,
      this.numChannels,
      this.bytesPerSample,
      this.data});

  /// @nodoc
  @JsonKey(name: 'capture_timestamp')
  final int? captureTimestamp;

  /// @nodoc
  @JsonKey(name: 'samples_per_channel_')
  final int? samplesPerChannel;

  /// @nodoc
  @JsonKey(name: 'sample_rate_hz_')
  final int? sampleRateHz;

  /// @nodoc
  @JsonKey(name: 'num_channels_')
  final int? numChannels;

  /// @nodoc
  @JsonKey(name: 'bytes_per_sample')
  final BytesPerSample? bytesPerSample;

  /// @nodoc
  @JsonKey(name: 'data_')
  final List<int>? data;

  /// @nodoc
  factory AudioPcmFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmFrameFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioPcmFrameToJson(this);
}

/// The channel mode.
///
@JsonEnum(alwaysCreate: true)
enum AudioDualMonoMode {
  /// 0: Original mode.
  @JsonValue(0)
  audioDualMonoStereo,

  /// 1: Left channel mode. This mode replaces the audio of the right channel with the audio of the left channel, which means the user can only hear the audio of the left channel.
  @JsonValue(1)
  audioDualMonoL,

  /// 2: Right channel mode. This mode replaces the audio of the left channel with the audio of the right channel, which means the user can only hear the audio of the right channel.
  @JsonValue(2)
  audioDualMonoR,

  /// 3: Mixed channel mode. This mode mixes the audio of the left channel and the right channel, which means the user can hear the audio of the left channel and the right channel at the same time.
  @JsonValue(3)
  audioDualMonoMix,
}

/// @nodoc
extension AudioDualMonoModeExt on AudioDualMonoMode {
  /// @nodoc
  static AudioDualMonoMode fromValue(int value) {
    return $enumDecode(_$AudioDualMonoModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioDualMonoModeEnumMap[this]!;
  }
}

/// The video pixel format.
///
@JsonEnum(alwaysCreate: true)
enum VideoPixelFormat {
  /// @nodoc
  @JsonValue(0)
  videoPixelDefault,

  /// 1: The format is I420.
  @JsonValue(1)
  videoPixelI420,

  /// 2: The format is BGRA.
  @JsonValue(2)
  videoPixelBgra,

  /// @nodoc
  @JsonValue(3)
  videoPixelNv21,

  /// @nodoc
  @JsonValue(4)
  videoPixelRgba,

  /// 8: The format is NV12.
  @JsonValue(8)
  videoPixelNv12,

  /// @nodoc
  @JsonValue(10)
  videoTexture2d,

  /// @nodoc
  @JsonValue(11)
  videoTextureOes,

  /// @nodoc
  @JsonValue(12)
  videoCvpixelNv12,

  /// @nodoc
  @JsonValue(13)
  videoCvpixelI420,

  /// @nodoc
  @JsonValue(14)
  videoCvpixelBgra,

  /// @nodoc
  @JsonValue(16)
  videoPixelI422,
}

/// @nodoc
extension VideoPixelFormatExt on VideoPixelFormat {
  /// @nodoc
  static VideoPixelFormat fromValue(int value) {
    return $enumDecode(_$VideoPixelFormatEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoPixelFormatEnumMap[this]!;
  }
}

/// Video display modes.
///
@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  /// 1: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). The window is filled. One dimension of the video might have clipped contents.
  @JsonValue(1)
  renderModeHidden,

  /// 2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Priority is to ensuring that all video content is displayed. Areas that are not filled due to disparity in the aspect ratio are filled with black.
  @JsonValue(2)
  renderModeFit,

  ///  Deprecated:
  ///  3: This mode is deprecated.
  @JsonValue(3)
  renderModeAdaptive,
}

/// @nodoc
extension RenderModeTypeExt on RenderModeType {
  /// @nodoc
  static RenderModeType fromValue(int value) {
    return $enumDecode(_$RenderModeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RenderModeTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class ExternalVideoFrame {
  /// @nodoc
  const ExternalVideoFrame(
      {this.type,
      this.format,
      this.buffer,
      this.stride,
      this.height,
      this.cropLeft,
      this.cropTop,
      this.cropRight,
      this.cropBottom,
      this.rotation,
      this.timestamp,
      this.eglType,
      this.textureId,
      this.matrix,
      this.metadataBuffer,
      this.metadataSize});

  /// @nodoc
  @JsonKey(name: 'type')
  final VideoBufferType? type;

  /// @nodoc
  @JsonKey(name: 'format')
  final VideoPixelFormat? format;

  /// @nodoc
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// @nodoc
  @JsonKey(name: 'stride')
  final int? stride;

  /// @nodoc
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  @JsonKey(name: 'cropLeft')
  final int? cropLeft;

  /// @nodoc
  @JsonKey(name: 'cropTop')
  final int? cropTop;

  /// @nodoc
  @JsonKey(name: 'cropRight')
  final int? cropRight;

  /// @nodoc
  @JsonKey(name: 'cropBottom')
  final int? cropBottom;

  /// @nodoc
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// @nodoc
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// @nodoc
  @JsonKey(name: 'eglType')
  final EglContextType? eglType;

  /// @nodoc
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// @nodoc
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// @nodoc
  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  /// @nodoc
  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  /// @nodoc
  factory ExternalVideoFrame.fromJson(Map<String, dynamic> json) =>
      _$ExternalVideoFrameFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ExternalVideoFrameToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum EglContextType {
  /// @nodoc
  @JsonValue(0)
  eglContext10,

  /// @nodoc
  @JsonValue(1)
  eglContext14,
}

/// @nodoc
extension EglContextTypeExt on EglContextType {
  /// @nodoc
  static EglContextType fromValue(int value) {
    return $enumDecode(_$EglContextTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$EglContextTypeEnumMap[this]!;
  }
}

/// The video buffer type.
///
@JsonEnum(alwaysCreate: true)
enum VideoBufferType {
  /// 1: The video buffer in the format of raw data.
  @JsonValue(1)
  videoBufferRawData,

  /// @nodoc
  @JsonValue(2)
  videoBufferArray,

  /// @nodoc
  @JsonValue(3)
  videoBufferTexture,
}

/// @nodoc
extension VideoBufferTypeExt on VideoBufferType {
  /// @nodoc
  static VideoBufferType fromValue(int value) {
    return $enumDecode(_$VideoBufferTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoBufferTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class VideoFrame {
  /// @nodoc
  const VideoFrame(
      {this.type,
      this.width,
      this.height,
      this.yStride,
      this.uStride,
      this.vStride,
      this.yBuffer,
      this.uBuffer,
      this.vBuffer,
      this.rotation,
      this.renderTimeMs,
      this.avsyncType,
      this.metadataBuffer,
      this.metadataSize,
      this.textureId,
      this.matrix,
      this.alphaBuffer});

  /// @nodoc
  @JsonKey(name: 'type')
  final VideoPixelFormat? type;

  /// @nodoc
  @JsonKey(name: 'width')
  final int? width;

  /// @nodoc
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  @JsonKey(name: 'yStride')
  final int? yStride;

  /// @nodoc
  @JsonKey(name: 'uStride')
  final int? uStride;

  /// @nodoc
  @JsonKey(name: 'vStride')
  final int? vStride;

  /// @nodoc
  @JsonKey(name: 'yBuffer', ignore: true)
  final Uint8List? yBuffer;

  /// @nodoc
  @JsonKey(name: 'uBuffer', ignore: true)
  final Uint8List? uBuffer;

  /// @nodoc
  @JsonKey(name: 'vBuffer', ignore: true)
  final Uint8List? vBuffer;

  /// @nodoc
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// @nodoc
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// @nodoc
  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  /// @nodoc
  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  /// @nodoc
  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  /// @nodoc
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// @nodoc
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// @nodoc
  @JsonKey(name: 'alphaBuffer', ignore: true)
  final Uint8List? alphaBuffer;

  /// @nodoc
  factory VideoFrame.fromJson(Map<String, dynamic> json) =>
      _$VideoFrameFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoFrameToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MediaPlayerSourceType {
  /// @nodoc
  @JsonValue(0)
  mediaPlayerSourceDefault,

  /// @nodoc
  @JsonValue(1)
  mediaPlayerSourceFullFeatured,

  /// @nodoc
  @JsonValue(2)
  mediaPlayerSourceSimple,
}

/// @nodoc
extension MediaPlayerSourceTypeExt on MediaPlayerSourceType {
  /// @nodoc
  static MediaPlayerSourceType fromValue(int value) {
    return $enumDecode(_$MediaPlayerSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaPlayerSourceTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoModulePosition {
  /// @nodoc
  @JsonValue(1 << 0)
  positionPostCapturer,

  /// @nodoc
  @JsonValue(1 << 1)
  positionPreRenderer,

  /// @nodoc
  @JsonValue(1 << 2)
  positionPreEncoder,

  /// @nodoc
  @JsonValue(1 << 3)
  positionPostFilters,
}

/// @nodoc
extension VideoModulePositionExt on VideoModulePosition {
  /// @nodoc
  static VideoModulePosition fromValue(int value) {
    return $enumDecode(_$VideoModulePositionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoModulePositionEnumMap[this]!;
  }
}

/// @nodoc
class AudioFrameObserverBase {
  /// @nodoc
  const AudioFrameObserverBase({
    this.onRecordAudioFrame,
    this.onPlaybackAudioFrame,
    this.onMixedAudioFrame,
  });

  /// @nodoc
  final void Function(String channelId, AudioFrame audioFrame)?
      onRecordAudioFrame;

  /// @nodoc
  final void Function(String channelId, AudioFrame audioFrame)?
      onPlaybackAudioFrame;

  /// @nodoc
  final void Function(String channelId, AudioFrame audioFrame)?
      onMixedAudioFrame;
}

/// Audio frame type.
///
@JsonEnum(alwaysCreate: true)
enum AudioFrameType {
  /// 0: PCM 16
  @JsonValue(0)
  frameTypePcm16,
}

/// @nodoc
extension AudioFrameTypeExt on AudioFrameType {
  /// @nodoc
  static AudioFrameType fromValue(int value) {
    return $enumDecode(_$AudioFrameTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioFrameTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioFrame {
  /// @nodoc
  const AudioFrame(
      {this.type,
      this.samplesPerChannel,
      this.bytesPerSample,
      this.channels,
      this.samplesPerSec,
      this.buffer,
      this.renderTimeMs,
      this.avsyncType});

  /// @nodoc
  @JsonKey(name: 'type')
  final AudioFrameType? type;

  /// @nodoc
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// @nodoc
  @JsonKey(name: 'bytesPerSample')
  final BytesPerSample? bytesPerSample;

  /// @nodoc
  @JsonKey(name: 'channels')
  final int? channels;

  /// @nodoc
  @JsonKey(name: 'samplesPerSec')
  final int? samplesPerSec;

  /// @nodoc
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// @nodoc
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// @nodoc
  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  /// @nodoc
  factory AudioFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioFrameFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioFrameToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum AudioFramePosition {
  /// @nodoc
  @JsonValue(0x0000)
  audioFramePositionNone,

  /// @nodoc
  @JsonValue(0x0001)
  audioFramePositionPlayback,

  /// @nodoc
  @JsonValue(0x0002)
  audioFramePositionRecord,

  /// @nodoc
  @JsonValue(0x0004)
  audioFramePositionMixed,

  /// @nodoc
  @JsonValue(0x0008)
  audioFramePositionBeforeMixing,
}

/// @nodoc
extension AudioFramePositionExt on AudioFramePosition {
  /// @nodoc
  static AudioFramePosition fromValue(int value) {
    return $enumDecode(_$AudioFramePositionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioFramePositionEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioParams {
  /// @nodoc
  const AudioParams(
      {this.sampleRate, this.channels, this.mode, this.samplesPerCall});

  /// @nodoc
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// @nodoc
  @JsonKey(name: 'channels')
  final int? channels;

  /// @nodoc
  @JsonKey(name: 'mode')
  final RawAudioFrameOpModeType? mode;

  /// @nodoc
  @JsonKey(name: 'samples_per_call')
  final int? samplesPerCall;

  /// @nodoc
  factory AudioParams.fromJson(Map<String, dynamic> json) =>
      _$AudioParamsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioParamsToJson(this);
}

/// @nodoc
class AudioFrameObserver extends AudioFrameObserverBase {
  /// @nodoc
  const AudioFrameObserver({
    /// @nodoc
    void Function(String channelId, AudioFrame audioFrame)? onRecordAudioFrame,

    /// @nodoc
    void Function(String channelId, AudioFrame audioFrame)?
        onPlaybackAudioFrame,

    /// @nodoc
    void Function(String channelId, AudioFrame audioFrame)? onMixedAudioFrame,
    this.onPlaybackAudioFrameBeforeMixing,
  }) : super(
          onRecordAudioFrame: onRecordAudioFrame,
          onPlaybackAudioFrame: onPlaybackAudioFrame,
          onMixedAudioFrame: onMixedAudioFrame,
        );

  /// @nodoc
  final void Function(String channelId, int uid, AudioFrame audioFrame)?
      onPlaybackAudioFrameBeforeMixing;
}

/// The audio spectrum data.
///
@JsonSerializable(explicitToJson: true)
class AudioSpectrumData {
  /// @nodoc
  const AudioSpectrumData({this.audioSpectrumData, this.dataLength});

  /// The audio spectrum data. Agora divides the audio frequency into 160 frequency domains, and reports the energy value of each frequency domain through this parameter. The value range of each energy type is [0, 1].
  ///
  @JsonKey(name: 'audioSpectrumData')
  final List<double>? audioSpectrumData;

  /// The length of the audio spectrum data in byte.
  ///
  @JsonKey(name: 'dataLength')
  final int? dataLength;

  /// @nodoc
  factory AudioSpectrumData.fromJson(Map<String, dynamic> json) =>
      _$AudioSpectrumDataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioSpectrumDataToJson(this);
}

/// Audio spectrum information of the remote user.
///
@JsonSerializable(explicitToJson: true)
class UserAudioSpectrumInfo {
  /// @nodoc
  const UserAudioSpectrumInfo({this.uid, this.spectrumData});

  /// The user ID of the remote user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Audio spectrum information of the remote user.  AudioSpectrumData
  ///
  @JsonKey(name: 'spectrumData')
  final AudioSpectrumData? spectrumData;

  /// @nodoc
  factory UserAudioSpectrumInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAudioSpectrumInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserAudioSpectrumInfoToJson(this);
}

/// @nodoc
class AudioSpectrumObserver {
  /// @nodoc
  const AudioSpectrumObserver({
    this.onLocalAudioSpectrum,
    this.onRemoteAudioSpectrum,
  });

  /// @nodoc
  final void Function(AudioSpectrumData data)? onLocalAudioSpectrum;

  /// @nodoc
  final void Function(
          List<UserAudioSpectrumInfo> spectrums, int spectrumNumber)?
      onRemoteAudioSpectrum;
}

/// @nodoc
class VideoEncodedFrameObserver {
  /// @nodoc
  const VideoEncodedFrameObserver({
    this.onEncodedVideoFrameReceived,
  });

  /// @nodoc
  final void Function(int uid, Uint8List imageBuffer, int length,
      EncodedVideoFrameInfo videoEncodedFrameInfo)? onEncodedVideoFrameReceived;
}

/// @nodoc
class VideoFrameObserver {
  /// @nodoc
  const VideoFrameObserver({
    this.onCaptureVideoFrame,
    this.onPreEncodeVideoFrame,
    this.onSecondaryCameraCaptureVideoFrame,
    this.onSecondaryPreEncodeCameraVideoFrame,
    this.onScreenCaptureVideoFrame,
    this.onPreEncodeScreenVideoFrame,
    this.onMediaPlayerVideoFrame,
    this.onSecondaryScreenCaptureVideoFrame,
    this.onSecondaryPreEncodeScreenVideoFrame,
    this.onRenderVideoFrame,
    this.onTranscodedVideoFrame,
  });

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onCaptureVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onPreEncodeVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryCameraCaptureVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeCameraVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onScreenCaptureVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onPreEncodeScreenVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame, int mediaPlayerId)?
      onMediaPlayerVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryScreenCaptureVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeScreenVideoFrame;

  /// @nodoc
  final void Function(String channelId, int remoteUid, VideoFrame videoFrame)?
      onRenderVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onTranscodedVideoFrame;
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoFrameProcessMode {
  /// @nodoc
  @JsonValue(0)
  processModeReadOnly,

  /// @nodoc
  @JsonValue(1)
  processModeReadWrite,
}

/// @nodoc
extension VideoFrameProcessModeExt on VideoFrameProcessMode {
  /// @nodoc
  static VideoFrameProcessMode fromValue(int value) {
    return $enumDecode(_$VideoFrameProcessModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoFrameProcessModeEnumMap[this]!;
  }
}

/// The external video frame encoding type.
///
@JsonEnum(alwaysCreate: true)
enum ExternalVideoSourceType {
  /// 0: The video frame is not encoded.
  @JsonValue(0)
  videoFrame,

  /// 1: The video frame is encoded.
  @JsonValue(1)
  encodedVideoFrame,
}

/// @nodoc
extension ExternalVideoSourceTypeExt on ExternalVideoSourceType {
  /// @nodoc
  static ExternalVideoSourceType fromValue(int value) {
    return $enumDecode(_$ExternalVideoSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ExternalVideoSourceTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MediaRecorderContainerFormat {
  /// @nodoc
  @JsonValue(1)
  formatMp4,
}

/// @nodoc
extension MediaRecorderContainerFormatExt on MediaRecorderContainerFormat {
  /// @nodoc
  static MediaRecorderContainerFormat fromValue(int value) {
    return $enumDecode(_$MediaRecorderContainerFormatEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaRecorderContainerFormatEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MediaRecorderStreamType {
  /// @nodoc
  @JsonValue(0x01)
  streamTypeAudio,

  /// @nodoc
  @JsonValue(0x02)
  streamTypeVideo,

  /// @nodoc
  @JsonValue(0x01 | 0x02)
  streamTypeBoth,
}

/// @nodoc
extension MediaRecorderStreamTypeExt on MediaRecorderStreamType {
  /// @nodoc
  static MediaRecorderStreamType fromValue(int value) {
    return $enumDecode(_$MediaRecorderStreamTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaRecorderStreamTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RecorderState {
  /// @nodoc
  @JsonValue(-1)
  recorderStateError,

  /// @nodoc
  @JsonValue(2)
  recorderStateStart,

  /// @nodoc
  @JsonValue(3)
  recorderStateStop,
}

/// @nodoc
extension RecorderStateExt on RecorderState {
  /// @nodoc
  static RecorderState fromValue(int value) {
    return $enumDecode(_$RecorderStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RecorderStateEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RecorderErrorCode {
  /// @nodoc
  @JsonValue(0)
  recorderErrorNone,

  /// @nodoc
  @JsonValue(1)
  recorderErrorWriteFailed,

  /// @nodoc
  @JsonValue(2)
  recorderErrorNoStream,

  /// @nodoc
  @JsonValue(3)
  recorderErrorOverMaxDuration,

  /// @nodoc
  @JsonValue(4)
  recorderErrorConfigChanged,
}

/// @nodoc
extension RecorderErrorCodeExt on RecorderErrorCode {
  /// @nodoc
  static RecorderErrorCode fromValue(int value) {
    return $enumDecode(_$RecorderErrorCodeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RecorderErrorCodeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class MediaRecorderConfiguration {
  /// @nodoc
  const MediaRecorderConfiguration(
      {this.storagePath,
      this.containerFormat,
      this.streamType,
      this.maxDurationMs,
      this.recorderInfoUpdateInterval});

  /// @nodoc
  @JsonKey(name: 'storagePath')
  final String? storagePath;

  /// @nodoc
  @JsonKey(name: 'containerFormat')
  final MediaRecorderContainerFormat? containerFormat;

  /// @nodoc
  @JsonKey(name: 'streamType')
  final MediaRecorderStreamType? streamType;

  /// @nodoc
  @JsonKey(name: 'maxDurationMs')
  final int? maxDurationMs;

  /// @nodoc
  @JsonKey(name: 'recorderInfoUpdateInterval')
  final int? recorderInfoUpdateInterval;

  /// @nodoc
  factory MediaRecorderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MediaRecorderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MediaRecorderConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class RecorderInfo {
  /// @nodoc
  const RecorderInfo({this.fileName, this.durationMs, this.fileSize});

  /// @nodoc
  @JsonKey(name: 'fileName')
  final String? fileName;

  /// @nodoc
  @JsonKey(name: 'durationMs')
  final int? durationMs;

  /// @nodoc
  @JsonKey(name: 'fileSize')
  final int? fileSize;

  /// @nodoc
  factory RecorderInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RecorderInfoToJson(this);
}

/// @nodoc
class MediaRecorderObserver {
  /// @nodoc
  const MediaRecorderObserver({
    this.onRecorderStateChanged,
    this.onRecorderInfoUpdated,
  });

  /// @nodoc
  final void Function(RecorderState state, RecorderErrorCode error)?
      onRecorderStateChanged;

  /// @nodoc
  final void Function(RecorderInfo info)? onRecorderInfoUpdated;
}
