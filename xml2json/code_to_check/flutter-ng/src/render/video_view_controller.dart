import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

/// @nodoc
abstract class VideoViewControllerBase {
  /// @nodoc
  RtcEngine get rtcEngine;

  /// @nodoc
  VideoCanvas get canvas;

  /// @nodoc
  RtcConnection? get connection;

  /// @nodoc
  bool get useFlutterTexture;

  /// @nodoc
  bool get useAndroidSurfaceView;

  /// @nodoc
  @internal
  void setTextureId(int textureId);

  /// @nodoc
  @internal
  int getTextureId();

  /// @nodoc
  @internal
  int getVideoSourceType();

  /// @nodoc
  @internal
  Future<void> setupView(int nativeViewPtr);

  /// @nodoc
  @protected
  Future<int> createTextureRender(
    int uid,
    String channelId,
    int videoSourceType,
  );

  /// @nodoc
  @internal
  Future<void> initializeRender();

  /// @nodoc
  @internal
  Future<void> disposeRender();

  /// @nodoc
  Future<void> dispose();
}

/// A AgoraVideoView controller for rendering local and remote video.
/// On different platforms, the default view corresponding to this class is different:
///  Android: . If you want to use , set the useAndroidSurfaceView property to true.
///  iOS: . If you want to use Flutter Texture, set the useFlutterTexture property to true.
///  macOS and Windows: .
class VideoViewController
    with VideoViewControllerBaseMixin
    implements VideoViewControllerBase {
  /// @nodoc
  VideoViewController(
      {required this.rtcEngine,
      required this.canvas,
      this.useFlutterTexture = false,
      this.useAndroidSurfaceView = false})
      : connection = const RtcConnection();

  /// @nodoc
  VideoViewController.remote(
      {required this.rtcEngine,
      required this.canvas,
      required this.connection,
      this.useFlutterTexture = false,
      this.useAndroidSurfaceView = false})
      : assert(connection.channelId != null);

  ///  RtcEngine .
  @override
  final RtcEngine rtcEngine;

  /// Local video display properties. See VideoCanvas .
  @override
  final VideoCanvas canvas;

  /// The connection information. See RtcConnection .
  @override
  final RtcConnection connection;

  /// Whether to use FlutterTexture to render video:
  ///  true: Use FlutterTexture to render video.
  ///  false: Do not use FlutterTexture to render video. FlutterTexture applies to iOS, macOS and Windows platforms.
  @override
  final bool useFlutterTexture;

  /// Whether to use Android SurfaceView to render video:
  ///  true: Use Android SurfaceView to render video.
  ///  false: Do not use Android SurfaceView to render video. Android SurfaceView applies to Android platform only.
  @override
  final bool useAndroidSurfaceView;

  /// @nodoc
  @protected
  @override
  int getVideoSourceType() {
    return canvas.uid! == 0
        ? VideoSourceType.videoSourceCamera.value()
        : VideoSourceType.videoSourceRemote.value();
  }
}
