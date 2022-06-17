import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

class RtcEngineExImpl extends RtcEngineImpl implements RtcEngineEx {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @override
  void joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options}) {
    const apiType = 'RtcEngineEx_joinChannelEx';
    final param = createParams({
      'token': token,
      'connection': connection.toJson(),
      'options': options.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void leaveChannelEx(RtcConnection connection) {
    const apiType = 'RtcEngineEx_leaveChannelEx';
    final param = createParams({'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_updateChannelMediaOptionsEx';
    final param = createParams(
        {'options': options.toJson(), 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_setVideoEncoderConfigurationEx';
    final param = createParams(
        {'config': config.toJson(), 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_setupRemoteVideoEx';
    final param = createParams(
        {'canvas': canvas.toJson(), 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_muteRemoteAudioStreamEx';
    final param = createParams(
        {'uid': uid, 'mute': mute, 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_muteRemoteVideoStreamEx';
    final param = createParams(
        {'uid': uid, 'mute': mute, 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_setRemoteVideoStreamTypeEx';
    final param = createParams({
      'uid': uid,
      'streamType': streamType.value(),
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void setRemoteVoicePositionEx(
      {required int uid,
      required double pan,
      required double gain,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_setRemoteVoicePositionEx';
    final param = createParams({
      'uid': uid,
      'pan': pan,
      'gain': gain,
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void setRemoteUserSpatialAudioParamsEx(
      {required int uid,
      required SpatialAudioParams params,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_setRemoteUserSpatialAudioParamsEx';
    final param = createParams({
      'uid': uid,
      'params': params.toJson(),
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_setRemoteRenderModeEx';
    final param = createParams({
      'uid': uid,
      'renderMode': renderMode.value(),
      'mirrorMode': mirrorMode.value(),
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName}) {
    const apiType = 'RtcEngineEx_enableLoopbackRecordingEx';
    final param = createParams({
      'connection': connection.toJson(),
      'enabled': enabled,
      'deviceName': deviceName
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  ConnectionStateType getConnectionStateEx(RtcConnection connection) {
    const apiType = 'RtcEngineEx_getConnectionStateEx';
    final param = createParams({'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    return result as ConnectionStateType;
  }

  @override
  void enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config}) {
    const apiType = 'RtcEngineEx_enableEncryptionEx';
    final param = createParams({
      'connection': connection.toJson(),
      'enabled': enabled,
      'config': config.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  int createDataStreamEx(
      {required bool reliable,
      required bool ordered,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_createDataStreamEx';
    final param = createParams({
      'reliable': reliable,
      'ordered': ordered,
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    final streamIdResult = rm['streamId'];
    return streamIdResult as int;
  }

  @override
  int createDataStreamEx2(
      {required DataStreamConfig config, required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_createDataStreamEx2';
    final param = createParams(
        {'config': config.toJson(), 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    final streamIdResult = rm['streamId'];
    return streamIdResult as int;
  }

  @override
  void sendStreamMessageEx(
      {required int streamId,
      required int data,
      required int length,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_sendStreamMessageEx';
    final param = createParams({
      'streamId': streamId,
      'data': data,
      'length': length,
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_addVideoWatermarkEx';
    final param = createParams({
      'watermarkUrl': watermarkUrl,
      'options': options.toJson(),
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void clearVideoWatermarkEx(RtcConnection connection) {
    const apiType = 'RtcEngineEx_clearVideoWatermarkEx';
    final param = createParams({'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void sendCustomReportMessageEx(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_sendCustomReportMessageEx';
    final param = createParams({
      'id': id,
      'category': category,
      'event': event,
      'label': label,
      'value': value,
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_enableAudioVolumeIndicationEx';
    final param = createParams({
      'interval': interval,
      'smooth': smooth,
      'reportVad': reportVad,
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  UserInfo getUserInfoByUserAccountEx(
      {required String userAccount, required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_getUserInfoByUserAccountEx';
    final param = createParams(
        {'userAccount': userAccount, 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    final userInfoResult = rm['userInfo'];
    return UserInfo.fromJson(userInfoResult);
  }

  @override
  UserInfo getUserInfoByUidEx(
      {required int uid, required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_getUserInfoByUidEx';
    final param = createParams({'uid': uid, 'connection': connection.toJson()});
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
    final userInfoResult = rm['userInfo'];
    return UserInfo.fromJson(userInfoResult);
  }

  @override
  void setVideoProfileEx(
      {required int width,
      required int height,
      required int frameRate,
      required int bitrate}) {
    const apiType = 'RtcEngineEx_setVideoProfileEx';
    final param = createParams({
      'width': width,
      'height': height,
      'frameRate': frameRate,
      'bitrate': bitrate
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void enableDualStreamModeEx(
      {required VideoSourceType sourceType,
      required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_enableDualStreamModeEx';
    final param = createParams({
      'sourceType': sourceType.value(),
      'enabled': enabled,
      'streamConfig': streamConfig.toJson(),
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }

  @override
  void addPublishStreamUrlEx(
      {required String url,
      required bool transcodingEnabled,
      required RtcConnection connection}) {
    const apiType = 'RtcEngineEx_addPublishStreamUrlEx';
    final param = createParams({
      'url': url,
      'transcodingEnabled': transcodingEnabled,
      'connection': connection.toJson()
    });
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
  }
}
