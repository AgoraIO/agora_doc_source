import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/src/classes.dart';
import 'package:agora_rtc_engine/src/impl/rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/media_recorder.dart';

// ignore_for_file: public_member_api_docs

abstract class MediaRecorderImplApiType {
  static const int kEngineMediaRecorderStart = 205;
  static const int kEngineMediaRecorderStop = 206;
  static const int kEngineMediaRecorderRelease = 207;
}

mixin MediaRecorderImplMixin implements MediaRecorder {
  MediaRecorderObserver? _callback;

  void setMediaRecorderObserver(MediaRecorderObserver? callback) {
    _callback = callback;
  }

  MediaRecorderObserver? getMediaRecorderObserver() {
    return _callback;
  }

  @override
  Future<void> releaseRecorder() async {
    await RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': MediaRecorderImplApiType.kEngineMediaRecorderRelease,
      'params': jsonEncode({}),
    });
    _callback = null;
  }

  @override
  Future<void> startRecording(MediaRecorderConfiguration config) {
    return RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': MediaRecorderImplApiType.kEngineMediaRecorderStart,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> stopRecording() {
    return RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': MediaRecorderImplApiType.kEngineMediaRecorderStop,
      'params': jsonEncode({}),
    });
  }
}

class MediaRecorderImpl implements MediaRecorder {
  MediaRecorderImpl._(this._mediaRecorderImplMixin);
  final MediaRecorderImplMixin? _mediaRecorderImplMixin;
  static MediaRecorderImpl getMediaRecorder(
      RtcEngine engine, {MediaRecorderObserver? callback}) {
    final mediaRecorderImplMixin = engine as MediaRecorderImplMixin;
    mediaRecorderImplMixin.setMediaRecorderObserver(callback);
    return MediaRecorderImpl._(mediaRecorderImplMixin);
  }

  @override
  Future<void> releaseRecorder() async {
    await _mediaRecorderImplMixin?.releaseRecorder();
  }

  @override
  Future<void> startRecording(MediaRecorderConfiguration config) async {
    await _mediaRecorderImplMixin?.startRecording(config);
  }

  @override
  Future<void> stopRecording() async {
    await _mediaRecorderImplMixin?.stopRecording();
  }
}
