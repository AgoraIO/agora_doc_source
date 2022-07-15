import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart';

import 'agora_rtc_engine.dart';
import 'agora_rtc_engine_ex.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;

/// Extension for [RtcEngine]
extension RtcEngineExt on RtcEngine {
  /// Get the absolute path of flutter asset
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    final p = await impl.engineMethodChannel
        .invokeMethod<String>('getAssetAbsolutePath', assetPath);

    return p;
  }
}

/// Exceptions are thrown when [RtcEngine] and releative class call error.
class AgoraRtcException implements Exception {
  AgoraRtcException({
    required this.code,
    this.message,
  });

  /// The error code, see [ErrorCodeType]
  final int code;

  /// The error description of the [code].
  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// Create the [RtcEngine]
RtcEngine createAgoraRtcEngine() {
  return impl.RtcEngineImpl.create();
}

/// Create the [RtcEngineEx]
RtcEngineEx createAgoraRtcEngineEx() {
  return impl.RtcEngineImpl.create();
}
