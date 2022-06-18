import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
<<<<<<< HEAD
import 'package:flutter/foundation.dart';

/// A controller for an [AgoraVideoView] rendering local and remote video.
=======
>>>>>>> release/rtc-ng/3.8.200-framework

class VideoViewController
    with VideoViewControllerBaseMixin
    implements VideoViewControllerBase {
<<<<<<< HEAD
  /// Creates a controller for an [AgoraVideoView] for rendering local video.
=======
>>>>>>> release/rtc-ng/3.8.200-framework
  VideoViewController({
    required this.rtcEngine,
    required this.canvas,
    this.useFlutterTexture = false,
    this.useAndroidSurfaceView = false,
  }) : connection = const RtcConnection();

<<<<<<< HEAD
  /// Creates a controller for an [AgoraVideoView] for rendering remote video.
=======
>>>>>>> release/rtc-ng/3.8.200-framework
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

<<<<<<< HEAD
  /// Force render by Flutter Texture(https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html)
  /// only work on iOS/macOS/Windows
  @override
  final bool useFlutterTexture;

  /// Force render by Android SurfaceView
  /// only work on Android
  @override
  final bool useAndroidSurfaceView;

  @protected
=======
  @override
  final bool useFlutterTexture;

  @override
  final bool useAndroidSurfaceView;

>>>>>>> release/rtc-ng/3.8.200-framework
  @override
  int getVideoSourceType() {
    return canvas.uid! == 0
        ? VideoSourceType.videoSourceCamera.value()
        : VideoSourceType.videoSourceRemote.value();
  }

  // @override
  // int get textureId => super.textureId;
}
