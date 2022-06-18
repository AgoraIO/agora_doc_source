import 'dart:typed_data';

import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_media_player.dart';
import 'package:agora_rtc_ng/src/agora_media_player_source.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
<<<<<<< HEAD
import 'package:agora_rtc_ng/src/binding/agora_media_player_impl.dart'
    as agora_media_player_impl_binding;
=======
import 'package:agora_rtc_ng/src/binding/agora_media_player_impl.dart' as agora_media_player_impl_binding;
>>>>>>> release/rtc-ng/3.8.200-framework
import 'package:agora_rtc_ng/src/binding/agora_media_player_source_event_impl.dart';
import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_ng/src/render/media_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:iris_event/iris_event.dart';

import 'api_caller.dart';
import 'video_view_controller_impl.dart';

class MediaPlayerImpl extends agora_media_player_impl_binding.MediaPlayerImpl
    with VideoViewControllerBaseMixin
    implements MediaPlayer, MediaPlayerController, IrisEventHandler {
  MediaPlayerImpl._(this._mediaPlayerId);

  // static MediaPlayerImpl? _instance;

  final int _mediaPlayerId;

  final Set<MediaPlayerSourceObserver> _mediaPlayerSourceObservers = {};

  factory MediaPlayerImpl.create(int mediaPlayerId) {
    // if (_instance != null) return _instance!;

    final instance = MediaPlayerImpl._(mediaPlayerId);
    // apiCaller.setupIrisMediaPlayerEventHandlerIfNeed();
    apiCaller.addEventHandler(instance);
    // _mediaPlayerId = super.getMediaPlayerId();

    return instance;
  }

  @protected
  @override
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return {
      'playerId': _mediaPlayerId,
      ...param,
    };
  }

  @override
  int getMediaPlayerId() {
    // _mediaPlayerId = super.getMediaPlayerId();
    return _mediaPlayerId;
  }

  // @override
  // void setView(int view) {
  //   const apiType = 'MediaPlayer_setView';
  //   final param = createParams({'view': view, 'playerId': _mediaPlayerId});//{'view': view, 'playerId': _mediaPlayerId};
  //   final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
  //   final result = rm['result'];
  // }

  // @override
  // void open({required String url, required int startPos}) {
  //   const apiType = 'MediaPlayer_open';
  //   final param = {
  //     'url': url,
  //     'startPos': startPos,
  //     'playerId': getMediaPlayerId()
  //   };
  //   final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
  //   final result = rm['result'];
  // }

  @override
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    _mediaPlayerSourceObservers.add(observer);
  }

  @override
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    _mediaPlayerSourceObservers.remove(observer);
  }

<<<<<<< HEAD
  void destroy() {
    stop();
=======
  @override
  void destroy() {
>>>>>>> release/rtc-ng/3.8.200-framework
    // apiCaller.disposeIrisMediaPlayerEventHandlerIfNeed();
    apiCaller.removeEventHandler(this);

    // _instance = null;
    _mediaPlayerSourceObservers.clear();
  }

  @override
  Future<void> dispose() async {
    // _mediaPlayerId = kMediaPlayerNotInit;
    super.dispose();
    destroy();
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    for (final eh in _mediaPlayerSourceObservers) {
      eh.process(event, data, buffers);
    }
  }

  RtcEngine? _rtcEngine;
  set rtcEngine(RtcEngine rtcEngine) {
    _rtcEngine = rtcEngine;
  }

  @override
  RtcEngine get rtcEngine => _rtcEngine!;

  VideoCanvas? _canvas;
  set canvas(VideoCanvas canvas) {
    _canvas = canvas;
  }

  @override
  VideoCanvas get canvas => _canvas!;

  RtcConnection? _connection;
  set connection(RtcConnection? connection) {
    _connection = connection;
  }

  @override
  RtcConnection? get connection => _connection;

  bool? _useFlutterTexture;
  set useFlutterTexture(bool useFlutterTexture) {
    _useFlutterTexture = useFlutterTexture;
  }

  @override
  bool get useFlutterTexture => _useFlutterTexture!;

  bool? _useAndroidSurfaceView;
  set useAndroidSurfaceView(bool useAndroidSurfaceView) {
    _useAndroidSurfaceView = useAndroidSurfaceView;
  }

  @override
  bool get useAndroidSurfaceView => _useAndroidSurfaceView!;

  // @override
  // int getTextureId();

  @override
  Future<int> createTextureRender(
      int uid, String channelId, int videoSourceType) {
    return rtcEngine.globalVideoViewController.createTextureRender(
      getMediaPlayerId(),
      channelId,
      videoSourceType,
    );
  }

  @override
<<<<<<< HEAD
  int getVideoSourceType() => VideoSourceType.videoSourceMediaPlayer.value();
=======
  int getVideoSourceType() =>
      VideoSourceType.videoSourceMediaPlayer.value();
>>>>>>> release/rtc-ng/3.8.200-framework

  @override
  void setupView(int nativeViewPtr) {
    setView(nativeViewPtr);
  }
}
