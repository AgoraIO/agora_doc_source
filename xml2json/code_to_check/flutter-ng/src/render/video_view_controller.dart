import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:flutter/foundation.dart';

/// A controller for an [AgoraVideoView] rendering local and remote video.
///
/// On mobile(Android/iOS), rendering by flutter [platform view](https://docs.flutter.dev/development/platform-integration/android/platform-views) by default.
/// * Android: Use [TextureView](https://developer.android.com/reference/android/view/TextureView) by default, you can
/// set [useAndroidSurfaceView] to `true` to force render by Android [SurfaceView](https://developer.android.com/reference/android/view/SurfaceView)
///
/// * iOS: Use [UIView](https://developer.apple.com/documentation/uikit/uiview),
/// you can set [useFlutterTexture] to `true` to force render by flutter texture.
///
/// On desktop(macOS/Windows), rendering by flutter texture by default.
///
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
  /// Android SurfaceView (https://developer.android.com/reference/android/view/SurfaceView).
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
