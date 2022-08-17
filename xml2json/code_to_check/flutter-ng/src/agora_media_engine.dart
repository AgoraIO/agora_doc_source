import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_media_engine.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum AudioMixingDualMonoMode {
  /// @nodoc
  @JsonValue(0)
  audioMixingDualMonoAuto,

  /// @nodoc
  @JsonValue(1)
  audioMixingDualMonoL,

  /// @nodoc
  @JsonValue(2)
  audioMixingDualMonoR,

  /// @nodoc
  @JsonValue(3)
  audioMixingDualMonoMix,
}

/// @nodoc
extension AudioMixingDualMonoModeExt on AudioMixingDualMonoMode {
  /// @nodoc
  static AudioMixingDualMonoMode fromValue(int value) {
    return $enumDecode(_$AudioMixingDualMonoModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioMixingDualMonoModeEnumMap[this]!;
  }
}

/// @nodoc
abstract class MediaEngine {
  /// @nodoc
  void registerAudioFrameObserver(AudioFrameObserver observer);

  /// @nodoc
  void registerVideoFrameObserver(VideoFrameObserver observer);

  /// @nodoc
  void registerVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  /// @nodoc
  Future<void> pushAudioFrame(
      {required MediaSourceType type,
      required AudioFrame frame,
      bool wrap = false,
      int sourceId = 0});

  /// @nodoc
  Future<void> pushCaptureAudioFrame(AudioFrame frame);

  /// @nodoc
  Future<void> pushReverseAudioFrame(AudioFrame frame);

  /// @nodoc
  Future<void> pushDirectAudioFrame(AudioFrame frame);

  /// @nodoc
  Future<void> pullAudioFrame(AudioFrame frame);

  /// @nodoc
  Future<void> setExternalVideoSource(
      {required bool enabled,
      required bool useTexture,
      ExternalVideoSourceType sourceType = ExternalVideoSourceType.videoFrame,

      /// @nodoc
      SenderOptions encodedVideoOption = const SenderOptions()});

  /// @nodoc
  Future<void> setExternalAudioSource(
      {required bool enabled,
      required int sampleRate,
      required int channels,
      int sourceNumber = 1,
      bool localPlayback = false,
      bool publish = true});

  /// @nodoc
  Future<void> setExternalAudioSink(
      {required bool enabled, required int sampleRate, required int channels});

  /// @nodoc
  Future<void> enableCustomAudioLocalPlayback(
      {required int sourceId, required bool enabled});

  /// @nodoc
  Future<void> setDirectExternalAudioSource(
      {required bool enable, bool localPlayback = false});

  /// @nodoc
  Future<void> pushVideoFrame(
      {required ExternalVideoFrame frame, int videoTrackId = 0});

  /// @nodoc
  Future<void> pushEncodedVideoImage(
      {required Uint8List imageBuffer,
      required int length,
      required EncodedVideoFrameInfo videoEncodedFrameInfo,
      int videoTrackId = 0});

  /// @nodoc
  Future<void> release();

  /// @nodoc
  void unregisterAudioFrameObserver(AudioFrameObserver observer);

  /// @nodoc
  void unregisterVideoFrameObserver(VideoFrameObserver observer);

  /// @nodoc
  void unregisterVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);
}
