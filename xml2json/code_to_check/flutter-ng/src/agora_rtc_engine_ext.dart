import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart';
import 'agora_media_player.dart';
import 'agora_rtc_engine.dart';
import 'agora_rtc_engine_ex.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;
import 'impl/media_player_impl.dart';

/// The derived interface class from RtcEngine.
///
extension RtcEngineExt on RtcEngine {
  /// @nodoc
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    final p = await impl.engineMethodChannel
        .invokeMethod<String>('getAssetAbsolutePath', assetPath);
    return p;
  }

  /// @nodoc
  MediaPlayerCacheManager getMediaPlayerCacheManager() {
    return MediaPlayerCacheManagerImpl.create(this);
  }
}

/// @nodoc
class AgoraRtcException implements Exception {
  /// @nodoc
  AgoraRtcException({required this.code, this.message});

  /// @nodoc
  final int code;

  /// @nodoc
  final String? message;

  /// @nodoc
  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// @nodoc
RtcEngine createAgoraRtcEngine() {
  return impl.RtcEngineImpl.create();
}

/// @nodoc
RtcEngineEx createAgoraRtcEngineEx() {
  return impl.RtcEngineImpl.create();
}
