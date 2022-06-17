import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_media_base.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/audio_device_manager.dart';
import 'package:agora_rtc_ng/src/binding/agora_rtc_engine_event_impl.dart';
import 'package:agora_rtc_ng/src/binding/agora_rtc_engine_ex_impl.dart'
    as rtc_engine_ex_binding;
import 'package:agora_rtc_ng/src/binding/agora_rtc_engine_impl.dart'
    as rtc_engine_binding;
import 'package:agora_rtc_ng/src/binding/event_handler_param_json.dart';
import 'package:agora_rtc_ng/src/binding/agora_rtc_engine_ex_event_impl.dart'
    as event_ex;
import 'package:agora_rtc_ng/src/agora_media_player.dart';
import 'package:agora_rtc_ng/src/binding/agora_media_base_event_impl.dart';
import 'package:agora_rtc_ng/src/impl/audio_device_manager_impl.dart';
import 'package:agora_rtc_ng/src/impl/media_player_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iris_event/iris_event.dart';

import 'api_caller.dart';
import 'global_video_view_controller.dart';
import 'package:meta/meta.dart';

extension RtcEngineExt on RtcEngine {
  GlobalVideoViewController get globalVideoViewController =>
      (this as RtcEngineImpl)._globalVideoViewController;
}

extension ThumbImageBufferExt on ThumbImageBuffer {
  ThumbImageBuffer copyWithBuffer(Map<String, dynamic> origanalJson) {
    return ThumbImageBuffer(
      buffer: uint8ListFromPtr(origanalJson['buffer'], length!),
      length: length,
      width: width,
      height: height,
    );
  }
}

extension RtcEngineEventHandlerExt on RtcEngineEventHandler {
  bool eventIntercept(String event, String eventData, List<Uint8List> buffers) {
    switch (event) {
      case 'onStreamMessage':
        if (onStreamMessage == null) break;
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnStreamMessageJson paramJson =
            RtcEngineEventHandlerOnStreamMessageJson.fromJson(jsonMap);
        int? userId = paramJson.userId;
        int? streamId = paramJson.streamId;
        Uint8List? data = buffers[0];
        int? length = paramJson.length;
        int? sentTs = paramJson.sentTs;
        if (userId == null ||
            streamId == null ||
            data == null ||
            length == null ||
            sentTs == null) {
          break;
        }
        onStreamMessage!(userId, streamId, data, length, sentTs);

        return true;
      default:
        break;
    }
    return false;
  }
}

extension RtcEngineEventHandlerExExt on RtcEngineEventHandlerEx {
  bool eventIntercept(String event, String eventData, List<Uint8List> buffers) {
    switch (event) {
      case 'onStreamMessageEx':
        if (onStreamMessageEx == null) break;
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerExOnStreamMessageExJson paramJson =
            RtcEngineEventHandlerExOnStreamMessageExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? streamId = paramJson.streamId;

        int? length = paramJson.length;
        int? sentTs = paramJson.sentTs;

        if (connection == null ||
            remoteUid == null ||
            streamId == null ||
            length == null ||
            sentTs == null) {
          break;
        }
        Uint8List? data = buffers[0];

        onStreamMessageEx!(
            connection, remoteUid, streamId, data, length, sentTs);
        return true;
      default:
        break;
    }
    return false;
  }
}

extension MetadataObserverExt on MetadataObserver {
  bool eventIntercept(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MetadataObserver_onMetadataReceived':
        if (onMetadataReceived == null) break;
        MetadataObserverOnMetadataReceivedJson paramJson =
            MetadataObserverOnMetadataReceivedJson.fromJson(jsonMap);
        Metadata? metadata = paramJson.metadata;

        if (metadata == null) {
          break;
        }

        metadata = Metadata(
          uid: metadata.uid,
          size: metadata.size,
          buffer: buffers[0],
          timeStampMs: metadata.timeStampMs,
        );

        onMetadataReceived!(metadata);
        return true;
      default:
        break;
    }

    return false;
  }
}

class RtcEngineImpl extends rtc_engine_ex_binding.RtcEngineExImpl
    implements RtcEngineEx, IrisEventHandler {
  RtcEngineImpl._() {}

  static RtcEngineImpl? _instance;
  final Set<RtcEngineEventHandler> _rtcEngineEventHandlers = {};
  final Set<MetadataObserver> _metadataObservers = {};
  SnapshotCallback? _snapshotCallback;
  DirectCdnStreamingEventHandler? _directCdnStreamingEventHandler;

  final GlobalVideoViewController _globalVideoViewController =
      const GlobalVideoViewController();

  int get irisRtcEngineIntPtr => apiCaller.irisApiEngineIntPtr;

  int _mediaPlayerCount = 0;

  @internal
  final MethodChannel engineMethodChannel =
      const MethodChannel('agora_rtc_ng');

  static RtcEngineEx create(RtcEngineContext context) {
    if (_instance != null) return _instance!;
    apiCaller.initilize();

    _instance = RtcEngineImpl._();
    _instance!.initialize(context);
    _instance!._initializeInternal(context);

    apiCaller.setupIrisRtcEngineEventHandler();
    apiCaller.addEventHandler(_instance!);

    return _instance!;
  }

  Future<void> _initializeInternal(RtcEngineContext context) async {
    await _globalVideoViewController
        .attachVideoFrameBufferManager(apiCaller.irisApiEngineIntPtr);
  }

  @override
  Future<void> release({bool sync = false}) async {
    apiCaller.removeEventHandler(this);
    _rtcEngineEventHandlers.clear();
    _metadataObservers.clear();
    _snapshotCallback = null;
    _directCdnStreamingEventHandler = null;
    _mediaPlayerCount = 0;

    await _globalVideoViewController
        .detachVideoFrameBufferManager(apiCaller.irisApiEngineIntPtr);

    super.release(sync: sync);

    apiCaller.dispose();
    _instance = null;
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    debugPrint('onEvent: event: $event, data: $data');
    for (final eh in _rtcEngineEventHandlers) {
      if (eh is RtcEngineEventHandlerEx) {
        if (!eh.eventIntercept(event, data, buffers)) {
          event_ex.RtcEngineEventHandlerExExt(eh).process(event, data, buffers);
        }
      }
      if (!eh.eventIntercept(event, data, buffers)) {
        eh.process(event, data, buffers);
      }
    }

    for (final observer in _metadataObservers) {
      if (!observer.eventIntercept(event, data, buffers)) {
        observer.process(event, data, buffers);
      }
    }

    _snapshotCallback?.process(event, data, buffers);
    _directCdnStreamingEventHandler?.process(event, data, buffers);
  }

  @override
  void registerEventHandler(covariant RtcEngineEventHandler eventHandler) {
    _rtcEngineEventHandlers.add(eventHandler);
  }

  @override
  void unregisterEventHandler(covariant RtcEngineEventHandler eventHandler) {
    _rtcEngineEventHandlers.remove(_rtcEngineEventHandlers);
  }

  @override
  void setupRemoteVideo(VideoCanvas canvas) {
    const apiType = 'RtcEngine_setupRemoteVideo';
    final jsonWithBuffer = canvas.toJson();
    final bufferPtr = canvas.priv != null ? uint8ListToPtr(canvas.priv!) : null;
    jsonWithBuffer['priv'] = bufferPtr?.address;
    final param = createParams({'canvas': jsonWithBuffer});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (bufferPtr != null) {
      freePointer(bufferPtr);
    }
    final result = rm['result'];
  }

  @override
  void setupLocalVideo(VideoCanvas canvas) {
    const apiType = 'RtcEngine_setupLocalVideo';
    final jsonWithBuffer = canvas.toJson();
    final bufferPtr = canvas.priv != null ? uint8ListToPtr(canvas.priv!) : null;
    jsonWithBuffer['priv'] = bufferPtr?.address;
    final param = createParams({'canvas': jsonWithBuffer});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (bufferPtr != null) {
      freePointer(bufferPtr);
    }
    final result = rm['result'];
  }

  @override
  void setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_setupRemoteVideoEx';
    final jsonWithBuffer = canvas.toJson();
    final bufferPtr = canvas.priv != null ? uint8ListToPtr(canvas.priv!) : null;
    jsonWithBuffer['priv'] = bufferPtr?.address;
    final param = createParams({
      'canvas': jsonWithBuffer,
      'connection': connection.toJson(),
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (bufferPtr != null) {
      freePointer(bufferPtr);
    }
    final result = rm['result'];
  }

  @override
  MediaPlayer createMediaPlayer() {
    const apiType = 'RtcEngine_createMediaPlayer';
    final param = createParams({});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];

    if (_mediaPlayerCount == 0) {
      apiCaller.setupIrisMediaPlayerEventHandlerIfNeed();
    }

    final MediaPlayer mediaPlayer = MediaPlayerImpl.create(result as int);
    ++_mediaPlayerCount;
    return mediaPlayer;
  }

  @override
  void destroyMediaPlayer(covariant MediaPlayer mediaPlayer) {
    const apiType = 'RtcEngine_destroyMediaPlayer';
    final param = createParams({'playerId': mediaPlayer.getMediaPlayerId()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    (mediaPlayer as MediaPlayerImpl).destroy();
    --_mediaPlayerCount;
    if (_mediaPlayerCount == 0) {
      apiCaller.disposeIrisMediaPlayerEventHandlerIfNeed();
    }
  }

  @override
  void sendStreamMessage(
      {required int streamId, required Uint8List data, required int length}) {
    const apiType = 'RtcEngine_sendStreamMessage';
    final dataPtr = uint8ListToPtr(data);
    final param = createParams(
        {'streamId': streamId, 'data': dataPtr.address, 'length': length});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    freePointer(dataPtr);
    final result = rm['result'];
  }

  @override
  void enableEncryption(
      {required bool enabled, required EncryptionConfig config}) {
    const apiType = 'RtcEngine_enableEncryption';
    final configJsonMap = config.toJson();
    if (config.encryptionKdfSalt != null) {
      configJsonMap['encryptionKdfSalt'] =
          // uint8ListToPtr(config.encryptionKdfSalt!).address;
          config.encryptionKdfSalt!;
    }

    final param = createParams({'enabled': enabled, 'config': configJsonMap});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config}) {
    const apiType = 'RtcEngineEx_enableEncryptionEx';
    final configJsonMap = config.toJson();
    if (config.encryptionKdfSalt != null) {
      configJsonMap['encryptionKdfSalt'] =
          // uint8ListToPtr(config.encryptionKdfSalt!).address;
          config.encryptionKdfSalt!;
    }

    final param = createParams({
      'connection': connection.toJson(),
      'enabled': enabled,
      'config': configJsonMap
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  List<ScreenCaptureSourceInfo> getScreenCaptureSources(
      {required Size thumbSize,
      required Size iconSize,
      required bool includeScreen}) {
    const apiType = 'RtcEngine_getScreenCaptureSources';
    final param = createParams({
      'thumbSize': thumbSize.toJson(),
      'iconSize': iconSize.toJson(),
      'includeScreen': includeScreen
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    final sourcesIntPtr = rm['sources'];
    final resultList = List.from(result);
    List<ScreenCaptureSourceInfo> output = [];
    for (final r in resultList) {
      final oldInfo = ScreenCaptureSourceInfo.fromJson(r);

      final newThumbImage = oldInfo.thumbImage!.copyWithBuffer(r['thumbImage']);
      final newIconImage = oldInfo.iconImage!.copyWithBuffer(r['iconImage']);
      final info = ScreenCaptureSourceInfo(
        type: oldInfo.type,
        sourceId: oldInfo.sourceId,
        sourceName: oldInfo.sourceName,
        thumbImage: newThumbImage,
        iconImage: newIconImage,
        processPath: oldInfo.processPath,
        sourceTitle: oldInfo.sourceTitle,
        primaryMonitor: oldInfo.primaryMonitor,
        isOccluded: oldInfo.isOccluded,
      );

      output.add(info);
    }

    apiCaller.callIrisApi(
      'RtcEngine_releaseScreenCaptureSources',
      jsonEncode({'sources': sourcesIntPtr}),
    );

    return output;
  }

  @override
  void sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType}) {
    assert(metadata.buffer != null);
    const apiType = 'RtcEngine_sendMetaData';
    final dataPtr = uint8ListToPtr(metadata.buffer!);
    final metadataMap = metadata.toJson();
    metadataMap['buffer'] = dataPtr.address;
    final param = createParams(
        {'metadata': metadataMap, 'source_type': sourceType.value()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    freePointer(dataPtr);
    final result = rm['result'];
  }

  @override
  void setMaxMetadataSize(int size) {
    const apiType = 'RtcEngine_setMaxMetadataSize';
    final param = createParams({'size': size});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) {
    const apiType = 'RtcEngine_registerMediaMetadataObserver';
    final param = createParams({'type': type.value()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    _metadataObservers.add(observer);
  }

  @override
  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) {
    const apiType = 'RtcEngine_unregisterMediaMetadataObserver';
    final param = createParams({'type': type.value()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    _metadataObservers.remove(observer);
  }

  @override
  void takeSnapshot(
      {required SnapShotConfig config, required SnapshotCallback callback}) {
    _snapshotCallback = callback;

    const apiType = 'RtcEngine_takeSnapshot';
    final param = createParams({'config': config.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options}) {
    _directCdnStreamingEventHandler = eventHandler;

    const apiType = 'RtcEngine_startDirectCdnStreaming';
    final param =
        createParams({'publishUrl': publishUrl, 'options': options.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void stopDirectCdnStreaming() {
    super.stopDirectCdnStreaming();

    _directCdnStreamingEventHandler = null;
  }

  @override
  VideoDeviceManager getVideoDeviceManager() {
    return VideoDeviceManagerImpl.create();
  }

  @override
  AudioDeviceManager getAudioDeviceManager() {
    return AudioDeviceManagerImpl.create();
  }
}

// class IVideoDeviceCollectionInternal extends IVideoDeviceCollection {
//   @override
//   void getCount() {
//     throw UnimplementedError();
//   }

//   @override
//   String getDevice({required int index, required String deviceIdUTF8}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> release() async {
//     throw UnimplementedError();
//   }

//   @override
//   void setDevice(String deviceIdUTF8) {
//     throw UnimplementedError();
//   }
// }

class VideoDeviceManagerImpl extends rtc_engine_binding.VideoDeviceManagerImpl
    implements VideoDeviceManager {
  static VideoDeviceManagerImpl? _instance;

  VideoDeviceManagerImpl._();

  @override
  factory VideoDeviceManagerImpl.create() {
    if (_instance != null) return _instance!;

    _instance = VideoDeviceManagerImpl._();

    return _instance!;
  }

  @override
  List<VideoDeviceInfo> enumerateVideoDevices() {
    const apiType = 'VideoDeviceManager_enumerateVideoDevices';
    final param = createParams({});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    // final devices = rm['devices'];
    final devicesList = List.from(result);
    final List<VideoDeviceInfo> deviceInfoList = [];
    // deviceInfoList.fill(rm);
    for (final d in devicesList) {
      final dm = Map<String, dynamic>.from(d);

      deviceInfoList.add(VideoDeviceInfo.fromJson(dm));
    }

    return deviceInfoList;
  }

  @override
  void release() {
    _instance = null;
  }
}
