import 'dart:convert';

import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/impl/api_caller.dart';
import 'package:agora_rtc_ng/src/audio_device_manager.dart';
import 'package:agora_rtc_ng/src/binding/audio_device_manager_impl.dart'
    as audio_device_manager_impl_binding;
import 'package:meta/meta.dart';

// class IAudioDeviceCollectionInernal implements IAudioDeviceCollection {
//   @visibleForOverriding
//   @override
//   int getApplicationVolume() {
//     throw UnimplementedError();
//   }

//   @visibleForOverriding
//   @override
//   void getCount() {
//     throw UnimplementedError();
//   }

//   @visibleForOverriding
//   @override
//   String getDevice({required int index, required String deviceId}) {
//     throw UnimplementedError();
//   }

//   @visibleForOverriding
//   @override
//   bool isApplicationMute() {
//     throw UnimplementedError();
//   }

//   @visibleForOverriding
//   @override
//   void release() {
//     throw UnimplementedError();
//   }

//   @visibleForOverriding
//   @override
//   void setApplicationMute(bool mute) {
//     throw UnimplementedError();
//   }

//   @visibleForOverriding
//   @override
//   void setApplicationVolume(int volume) {
//     throw UnimplementedError();
//   }

//   @visibleForOverriding
//   @override
//   void setDevice(String deviceId) {
//     throw UnimplementedError();
//   }
// }

extension DeviceInfoListExt on List<AudioDeviceInfo> {
  void fill(dynamic rm) {
    // assert(rm.containsKey('devices'));
    // final devices = rm['devices'];
    final devicesList = List.from(rm);
    final List<AudioDeviceInfo> deviceInfoList = [];
    for (final d in devicesList) {
      final dm = Map<String, dynamic>.from(d);

      deviceInfoList.add(AudioDeviceInfo.fromJson(dm));
    }
  }
}

class AudioDeviceManagerImpl extends audio_device_manager_impl_binding
    .AudioDeviceManagerImpl implements AudioDeviceManager {
  static AudioDeviceManagerImpl? _instance;

  AudioDeviceManagerImpl._();

  static AudioDeviceManager create() {
    if (_instance != null) return _instance!;

    _instance = AudioDeviceManagerImpl._();

    return _instance!;
  }

  @override
  List<AudioDeviceInfo> enumeratePlaybackDevices() {
    const apiType = 'AudioDeviceManager_enumeratePlaybackDevices';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
    // final devices = rm['devices'];
    // final devicesList = List.from(devices);
    final List<AudioDeviceInfo> deviceInfoList = [];
    deviceInfoList.fill(result);
    // for (final d in devicesList) {
    //   final dm = Map<String, dynamic>.from(d);

    //   deviceInfoList.add(DeviceInfo(
    //     deviceId: dm['deviceId'],
    //     deviceName: dm['deviceName'],
    //   ));
    // }

    return deviceInfoList;
  }

  @override
  List<AudioDeviceInfo> enumerateRecordingDevices() {
    const apiType = 'AudioDeviceManager_enumerateRecordingDevices';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
    final List<AudioDeviceInfo> deviceInfoList = [];
    deviceInfoList.fill(result);

    return deviceInfoList;
  }

  @override
  AudioDeviceInfo getPlaybackDeviceInfo() {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceInfo';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    return AudioDeviceInfo.fromJson(result);
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    return AudioDeviceInfo.fromJson(rm);
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  AudioDeviceInfo getRecordingDeviceInfo() {
    const apiType = 'AudioDeviceManager_getRecordingDeviceInfo';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    return AudioDeviceInfo.fromJson(result);
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    return AudioDeviceInfo.fromJson(rm);
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void release() {
    _instance = null;
  }
}
