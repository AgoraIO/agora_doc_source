import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

class AudioDeviceManagerImpl implements AudioDeviceManager {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @override
  List<AudioDeviceInfo> enumeratePlaybackDevices() {
    const apiType = 'AudioDeviceManager_enumeratePlaybackDevices';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<AudioDeviceInfo>;
  }

  @override
  List<AudioDeviceInfo> enumerateRecordingDevices() {
    const apiType = 'AudioDeviceManager_enumerateRecordingDevices';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<AudioDeviceInfo>;
  }

  @override
  void setPlaybackDevice(String deviceId) {
    const apiType = 'AudioDeviceManager_setPlaybackDevice';
    final param = createParams({'deviceId': deviceId});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  String getPlaybackDevice() {
    const apiType = 'AudioDeviceManager_getPlaybackDevice';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final deviceIdResult = rm['deviceId'];
    return deviceIdResult as String;
  }

  @override
  AudioDeviceInfo getPlaybackDeviceInfo() {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceInfo';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }

  @override
  void setPlaybackDeviceVolume(int volume) {
    const apiType = 'AudioDeviceManager_setPlaybackDeviceVolume';
    final param = createParams({'volume': volume});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  int getPlaybackDeviceVolume() {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceVolume';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final volumeResult = rm['volume'];
    return volumeResult as int;
  }

  @override
  void setRecordingDevice(String deviceId) {
    const apiType = 'AudioDeviceManager_setRecordingDevice';
    final param = createParams({'deviceId': deviceId});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  String getRecordingDevice() {
    const apiType = 'AudioDeviceManager_getRecordingDevice';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final deviceIdResult = rm['deviceId'];
    return deviceIdResult as String;
  }

  @override
  AudioDeviceInfo getRecordingDeviceInfo() {
    const apiType = 'AudioDeviceManager_getRecordingDeviceInfo';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }

  @override
  void setRecordingDeviceVolume(int volume) {
    const apiType = 'AudioDeviceManager_setRecordingDeviceVolume';
    final param = createParams({'volume': volume});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  int getRecordingDeviceVolume() {
    const apiType = 'AudioDeviceManager_getRecordingDeviceVolume';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final volumeResult = rm['volume'];
    return volumeResult as int;
  }

  @override
  void setPlaybackDeviceMute(bool mute) {
    const apiType = 'AudioDeviceManager_setPlaybackDeviceMute';
    final param = createParams({'mute': mute});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  bool getPlaybackDeviceMute() {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceMute';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final muteResult = rm['mute'];
    return muteResult as bool;
  }

  @override
  void setRecordingDeviceMute(bool mute) {
    const apiType = 'AudioDeviceManager_setRecordingDeviceMute';
    final param = createParams({'mute': mute});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  bool getRecordingDeviceMute() {
    const apiType = 'AudioDeviceManager_getRecordingDeviceMute';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final muteResult = rm['mute'];
    return muteResult as bool;
  }

  @override
  void startPlaybackDeviceTest(String testAudioFilePath) {
    const apiType = 'AudioDeviceManager_startPlaybackDeviceTest';
    final param = createParams({'testAudioFilePath': testAudioFilePath});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void stopPlaybackDeviceTest() {
    const apiType = 'AudioDeviceManager_stopPlaybackDeviceTest';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void startRecordingDeviceTest(int indicationInterval) {
    const apiType = 'AudioDeviceManager_startRecordingDeviceTest';
    final param = createParams({'indicationInterval': indicationInterval});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void stopRecordingDeviceTest() {
    const apiType = 'AudioDeviceManager_stopRecordingDeviceTest';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void startAudioDeviceLoopbackTest(int indicationInterval) {
    const apiType = 'AudioDeviceManager_startAudioDeviceLoopbackTest';
    final param = createParams({'indicationInterval': indicationInterval});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void stopAudioDeviceLoopbackTest() {
    const apiType = 'AudioDeviceManager_stopAudioDeviceLoopbackTest';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void release() {
    const apiType = 'AudioDeviceManager_release';
    final param = createParams({});
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }
}
