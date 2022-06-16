import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';

class VideoViewController
    with VideoViewControllerBaseMixin
    implements VideoViewControllerBase {
  VideoViewController({
    required this.rtcEngine,
    required this.canvas,
    this.useFlutterTexture = false,
    this.useAndroidSurfaceView = false,
  }) : connection = const RtcConnection();

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

  @override
  final bool useFlutterTexture;

  @override
  final bool useAndroidSurfaceView;

  @override
  int getVideoSourceType() {
    return canvas.uid! == 0
        ? VideoSourceType.videoSourceCamera.value()
        : VideoSourceType.videoSourceRemote.value();
  }

  // @override
  // int get textureId => super.textureId;
}
