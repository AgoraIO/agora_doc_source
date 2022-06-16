import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'agora_rtc_ng_method_channel.dart';

abstract class AgoraRtcNgPlatform extends PlatformInterface {
  /// Constructs a AgoraRtcFlutterPlatform.
  AgoraRtcNgPlatform() : super(token: _token);

  static final Object _token = Object();

  static AgoraRtcNgPlatform _instance = MethodChannelAgoraRtcNg();

  /// The default instance of [AgoraRtcNgPlatform] to use.
  ///
  /// Defaults to [MethodChannelAgoraRtcNg].
  static AgoraRtcNgPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AgoraRtcNgPlatform] when
  /// they register themselves.
  static set instance(AgoraRtcNgPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
