import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_media_player.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/impl/media_player_controller_impl.dart';
import 'package:agora_rtc_ng/src/render/video_view_controller.dart';

/// The AgoraVideoView controller used to render the video for the media player.
///
abstract class MediaPlayerController
    implements MediaPlayer, VideoViewControllerBase {
  /// @nodoc
  factory MediaPlayerController(
          {required RtcEngine rtcEngine,
          required VideoCanvas canvas,
          RtcConnection? connection,
          bool useFlutterTexture = false,
          bool useAndroidSurfaceView = false}) =>
      MediaPlayerControllerImpl(
        rtcEngine,
        canvas,
        connection,
        useFlutterTexture,
        useAndroidSurfaceView,
      );

  /// @nodoc
  Future<void> initialize();
}
