import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:flutter/foundation.dart';

/// A controller for an [AgoraVideoView] rendering local and remote video.

class VideoViewController
    with VideoViewControllerBaseMixin
    implements VideoViewControllerBase {
  /// Creates a controller for an [AgoraVideoView] for rendering local video.
  VideoViewController({
    required this.rtcEngine,
    required this.canvas,
    this.useFlutterTexture = false,
    this.useAndroidSurfaceView = false,
  }) : connection = const RtcConnection();

  /// Creates a controller for an [AgoraVideoView] for rendering remote video.
  VideoViewController.remote({
    required this.rtcEngine,
    required this.canvas,
    required this.connection,
    this.useFlutterTexture = false,
    this.useAndroidSurfaceView = false,
  }) : assert(connection.channelId != null);

  @override
  final RtcEngine rtcEngine;

  @override
  final VideoCanvas canvas;

  @override
  final RtcConnection connection;

  /// Force render by Flutter Texture(https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html)
  /// only work on iOS/macOS/Windows
  @override
  final bool useFlutterTexture;

  /// Force render by Android SurfaceView
  /// only work on Android
  @override
  final bool useAndroidSurfaceView;

  @protected
  @override
  int getVideoSourceType() {
    return canvas.uid! == 0
        ? VideoSourceType.videoSourceCamera.value()
        : VideoSourceType.videoSourceRemote.value();
  }

  // @override
  // int get textureId => super.textureId;
}
