import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/agora_media_recorder_impl.dart'
    as media_recorder_impl_binding;
import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart'
    as rtc_engine_impl;
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaRecorderImpl extends media_recorder_impl_binding.MediaRecorderImpl
    implements IrisEventHandler {
  MediaRecorderImpl._(this._rtcEngine) {
    _rtcEngine.addToPool(MediaRecorderImpl, this);
    apiCaller.addEventHandler(this);
  }

  factory MediaRecorderImpl.create(RtcEngine rtcEngine) {
    return MediaRecorderImpl._(rtcEngine);
  }

  final RtcEngine _rtcEngine;

  final Set<IrisEventHandler> _eventHandlers = {};

  @override
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback}) async {
    const apiType = 'MediaRecorder_setMediaRecorderObserver';
    final param = createParams({'connection': connection.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);

    await apiCaller.callIrisEventAsync(
        const IrisEventHandlerKey(
            op: CallIrisEventOp.create,
            registerName: 'MediaRecorder_setMediaRecorderObserver',
            unregisterName: 'MediaRecorder_unsetMediaRecorderObserver'),
        jsonEncode(param));

    _eventHandlers.add(MediaRecorderObserverWrapper(callback));
  }

  @override
  Future<void> release() async {
    if (_eventHandlers.isNotEmpty) {
      await apiCaller.callIrisEventAsync(
          const IrisEventHandlerKey(
              op: CallIrisEventOp.dispose,
              registerName: 'MediaRecorder_setMediaRecorderObserver',
              unregisterName: 'MediaRecorder_unsetMediaRecorderObserver'),
          jsonEncode({}));
      _eventHandlers.clear();
    }

    const apiType = 'MediaRecorder_release';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);

    _rtcEngine.removeFromPool(MediaRecorderImpl);
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    for (final e in _eventHandlers) {
      e.onEvent(event, data, buffers);
    }
  }
}
