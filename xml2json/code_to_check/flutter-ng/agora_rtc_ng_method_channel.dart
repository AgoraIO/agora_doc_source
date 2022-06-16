import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'agora_rtc_ng_platform_interface.dart';

/// An implementation of [AgoraRtcNgPlatform] that uses method channels.
class MethodChannelAgoraRtcNg extends AgoraRtcNgPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('agora_rtc_ng');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
