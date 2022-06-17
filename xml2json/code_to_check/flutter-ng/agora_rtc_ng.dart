import 'src/agora_rtc_engine.dart';
import 'src/agora_rtc_engine_ex.dart';
import 'src/impl/agora_rtc_engine_impl.dart' as impl;

export 'src/agora_base.dart';
export 'src/agora_log.dart';
export 'src/agora_media_base.dart';
export 'src/agora_media_player_source.dart';
export 'src/agora_media_player_types.dart';
export 'src/agora_media_player.dart';
export 'src/agora_media_streaming_source.dart';
export 'src/agora_rhythm_player.dart';
export 'src/agora_rtc_engine_ex.dart';
export 'src/agora_rtc_engine.dart';
export 'src/audio_device_manager.dart';

export 'src/render/agora_video_view.dart';
export 'src/render/video_view_controller.dart';
export 'src/render/media_player_controller.dart';

export 'src/agora_rtc_engine_ext.dart';

/// Create the [RtcEngine]
RtcEngine createAgoraRtcEngine(RtcEngineContext context) {
  return impl.RtcEngineImpl.create(context);
}

/// Create the [RtcEngineEx]
RtcEngineEx createAgoraRtcEngineEx(RtcEngineContext context) {
  return impl.RtcEngineImpl.create(context);
}