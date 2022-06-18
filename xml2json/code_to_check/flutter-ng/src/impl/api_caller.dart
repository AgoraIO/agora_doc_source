import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:agora_rtc_ng/src/impl/native_iris_api_engine_bindings.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iris_event/iris_event.dart';

<<<<<<< HEAD
const int kBasicResultLength = 64 * 1024;

class CallApiResult {
  CallApiResult({required this.irisReturnCode, required this.data});

  final int irisReturnCode;

  final Map<String, dynamic> data;
}
=======

const int kBasicResultLength = 64 * 1024;
>>>>>>> release/rtc-ng/3.8.200-framework

class AgoraRtcException implements Exception {
  /// Creates a [PlatformException] with the specified error [code] and optional
  /// [message], and with the optional error [details] which must be a valid
  /// value for the [MethodCodec] involved in the interaction.
  AgoraRtcException({
    required this.code,
    this.message,
  });

  final int code;

  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

Uint8List uint8ListFromPtr(int intPtr, int length) {
  debugPrint('intPtr: $intPtr');
  final ptr = ffi.Pointer<ffi.Uint8>.fromAddress(intPtr);
  return ptr.asTypedList(length);
}

ffi.Pointer<ffi.Void> uint8ListToPtr(Uint8List buffer) {
  ffi.Pointer<ffi.Void> bufferPointer;

  final ffi.Pointer<ffi.Uint8> bufferData =
      calloc.allocate<ffi.Uint8>(buffer.length);

  final pointerList = bufferData.asTypedList(buffer.length);
  pointerList.setAll(0, buffer);

  bufferPointer = bufferData.cast<ffi.Void>();
  return bufferPointer;
}

void freePointer(ffi.Pointer<ffi.Void> ptr) {
  calloc.free(ptr);
}

ffi.DynamicLibrary _loadAgoraFpaServiceLib() {
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('AgoraRtcWrapper.dll');
  }

  if (Platform.isAndroid) {
    return ffi.DynamicLibrary.open("libAgoraRtcWrapper.so");
  }

  return ffi.DynamicLibrary.process();
}

ApiCaller _defaultApiCaller =
    ApiCaller(NativeIrisApiEngineBinding(_loadAgoraFpaServiceLib()));
ApiCaller get apiCaller => _defaultApiCaller;

class ApiCaller implements IrisEventHandler {
  ApiCaller(this._nativeIrisApiEngineBinding);

  final NativeIrisApiEngineBinding _nativeIrisApiEngineBinding;
  IrisApiEnginePtr? _irisApiEnginePtr;
  int get irisApiEngineIntPtr => _irisApiEnginePtr!.address;

  final IrisEvent? _irisEvent = IrisEvent();
  ffi.Pointer<IrisCEventHandler>? _irisCEventHandler;
  ffi.Pointer<ffi.Void>? _irisEventHandlerPtr;
  ffi.Pointer<ffi.Void>? _irisMediaPlayerEventHandlerPtr;

  final Set<IrisEventHandler> _irisEventHandlers = {};

  T callApi<T>(int apiType, String params, {Uint8List? buffer}) {
    return '' as T;
  }

  void initilize() {
    _irisApiEnginePtr = _nativeIrisApiEngineBinding.CreateIrisApiEngine();
  }

  void dispose() {
    assert(_irisApiEnginePtr != null);
    _irisEventHandlers.clear();

    disposeIrisMediaPlayerEventHandlerIfNeed();
    // The IrisRtcEngineEventHandler should be dispose on last, which will free the
    // _irisCEventHandler internally.
    _disposeIrisRtcEngineEventHandler();

    _nativeIrisApiEngineBinding.DestroyIrisApiEngine(_irisApiEnginePtr!);
    // calloc.free(_irisApiEnginePtr!);
    _irisApiEnginePtr = null;
  }

<<<<<<< HEAD
  CallApiResult callIrisApi(
=======
  Map<String, dynamic> callIrisApi(
>>>>>>> release/rtc-ng/3.8.200-framework
    String funcName,
    String params, {
    Uint8List? buffer,
  }) {
    assert(_irisApiEnginePtr != null, 'Make sure initilize() has been called.');

    // debugPrint('function name: $funcName, params: $params');

<<<<<<< HEAD
    return using<CallApiResult>((Arena arena) {
=======
    return using<Map<String, dynamic>>((Arena arena) {
>>>>>>> release/rtc-ng/3.8.200-framework
      final ffi.Pointer<ffi.Int8> resultPointer =
          arena.allocate<ffi.Int8>(kBasicResultLength).cast<ffi.Int8>();

      final ffi.Pointer<ffi.Int8> funcNamePointer =
          funcName.toNativeUtf8(allocator: arena).cast<ffi.Int8>();

      final ffi.Pointer<Utf8> paramsPointerUtf8 =
          params.toNativeUtf8(allocator: arena);
      final paramsPointerUtf8Length = paramsPointerUtf8.length;
      final ffi.Pointer<ffi.Int8> paramsPointer =
          paramsPointerUtf8.cast<ffi.Int8>();

      ffi.Pointer<ffi.Void> bufferPointer;
      ffi.Pointer<ffi.Pointer<ffi.Void>> bufferPtrToPtr;
      int bufferLength = buffer?.length ?? 0;
      if (buffer != null) {
        final ffi.Pointer<ffi.Uint8> bufferData =
            arena.allocate<ffi.Uint8>(buffer.length);

        final pointerList = bufferData.asTypedList(buffer.length);
        pointerList.setAll(0, buffer);

        bufferPointer = bufferData.cast<ffi.Void>();

        bufferPtrToPtr = arena();

        bufferPtrToPtr.value =
            ffi.Pointer<ffi.Void>.fromAddress(bufferPointer.address);
      } else {
        bufferPtrToPtr = ffi.nullptr;
      }

      try {
<<<<<<< HEAD
        final irisReturnCode = _nativeIrisApiEngineBinding.CallIrisApi(
=======
        _nativeIrisApiEngineBinding.CallIrisApi(
>>>>>>> release/rtc-ng/3.8.200-framework
            _irisApiEnginePtr!,
            funcNamePointer,
            paramsPointer,
            paramsPointerUtf8Length,
            bufferPtrToPtr,
            bufferLength,
            resultPointer);

        final result = resultPointer.cast<Utf8>().toDartString();
        final resultMap = Map<String, dynamic>.from(jsonDecode(result));
        debugPrint(
            'function name: $funcName, params: $params\nresultMap: ${resultMap.toString()}');

<<<<<<< HEAD
            

        return CallApiResult(irisReturnCode: irisReturnCode, data: resultMap);
      } catch (e) {
        debugPrint(
            'function name: $funcName, params: $params\nerror: ${e.toString()}');
        return CallApiResult(irisReturnCode: -1, data: const {});
=======
        return resultMap;
      } catch (e) {
        debugPrint(
            'function name: $funcName, params: $params\nerror: ${e.toString()}');
        return {};
>>>>>>> release/rtc-ng/3.8.200-framework
      }
    });
  }

  void checkReturnCode(int returnCode) {
    if (returnCode < 0) {
      throw AgoraRtcException(code: returnCode, message: '');
    }
  }

  void setupIrisRtcEngineEventHandler() {
    assert(_irisApiEnginePtr != null);
    assert(_irisCEventHandler == null);

    _irisCEventHandler = calloc<IrisCEventHandler>()
      ..ref.OnEvent = _irisEvent!.onEventPtr;
    // ..ref.OnEventWithBuffer = _irisEvent!.onEventWithBufferPtr;

    _irisEventHandlerPtr =
        _nativeIrisApiEngineBinding.SetIrisRtcEngineEventHandler(
            _irisApiEnginePtr!, _irisCEventHandler!);

    _irisEvent?.setEventHandler(this);
  }

  void _disposeIrisRtcEngineEventHandler() {
    if (_irisEventHandlerPtr != null && _irisCEventHandler != null) {
      _nativeIrisApiEngineBinding.UnsetIrisRtcEngineEventHandler(
          _irisApiEnginePtr!, _irisEventHandlerPtr!);

      calloc.free(_irisCEventHandler!);
      _irisCEventHandler = null;
      _irisEventHandlerPtr = null;
    }
  }

  void disposeIrisMediaPlayerEventHandlerIfNeed() {
    if (_irisMediaPlayerEventHandlerPtr != null && _irisCEventHandler != null) {
      _nativeIrisApiEngineBinding.UnsetIrisMediaPlayerEventHandler(
          _irisApiEnginePtr!, _irisMediaPlayerEventHandlerPtr!);

      _irisMediaPlayerEventHandlerPtr = null;
    }
  }

  void setupIrisMediaPlayerEventHandlerIfNeed() {
    assert(_irisApiEnginePtr != null);
    assert(_irisCEventHandler != null);
    if (_irisMediaPlayerEventHandlerPtr != null) return;
    _irisMediaPlayerEventHandlerPtr =
        _nativeIrisApiEngineBinding.SetIrisMediaPlayerEventHandler(
            _irisApiEnginePtr!, _irisCEventHandler!);
  }

  void addEventHandler(IrisEventHandler eventHandler) {
    _irisEventHandlers.add(eventHandler);
  }

  void removeEventHandler(IrisEventHandler eventHandler) {
    _irisEventHandlers.remove(eventHandler);
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    for (final eh in _irisEventHandlers) {
      eh.onEvent(event, data, buffers);
    }
  }
}
