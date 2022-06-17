import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart';

/// Extension for [RtcEngine]
extension RtcEngineExt on RtcEngine {

  /// Get the absolute path of flutter asset
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    final p = await impl.engineMethodChannel.invokeMethod<String>(
        'getAssetAbsolutePath', assetPath);

    return p;
  }
}
