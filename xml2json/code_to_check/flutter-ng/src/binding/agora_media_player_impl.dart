import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

class MediaPlayerImpl implements MediaPlayer {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @override
  int getMediaPlayerId() {
    const apiType = 'MediaPlayer_getMediaPlayerId';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    return result as int;
  }

  @override
  void open({required String url, required int startPos}) {
    const apiType = 'MediaPlayer_open';
    final param = createParams({'url': url, 'startPos': startPos});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void play() {
    const apiType = 'MediaPlayer_play';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void pause() {
    const apiType = 'MediaPlayer_pause';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void stop() {
    const apiType = 'MediaPlayer_stop';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void resume() {
    const apiType = 'MediaPlayer_resume';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void seek(int newPos) {
    const apiType = 'MediaPlayer_seek';
    final param = createParams({'newPos': newPos});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void setAudioPitch(int pitch) {
    const apiType = 'MediaPlayer_setAudioPitch';
    final param = createParams({'pitch': pitch});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  int getDuration() {
    const apiType = 'MediaPlayer_getDuration';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    final durationResult = rm['duration'];
    return durationResult as int;
  }

  @override
  int getPlayPosition() {
    const apiType = 'MediaPlayer_getPlayPosition';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    final posResult = rm['pos'];
    return posResult as int;
  }

  @override
  int getStreamCount() {
    const apiType = 'MediaPlayer_getStreamCount';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    final countResult = rm['count'];
    return countResult as int;
  }

  @override
  PlayerStreamInfo getStreamInfo(int index) {
    const apiType = 'MediaPlayer_getStreamInfo';
    final param = createParams({'index': index});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    final infoResult = rm['info'];
    return PlayerStreamInfo.fromJson(infoResult);
  }

  @override
  void setLoopCount(int loopCount) {
    const apiType = 'MediaPlayer_setLoopCount';
    final param = createParams({'loopCount': loopCount});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void muteAudio(bool audioMute) {
    const apiType = 'MediaPlayer_muteAudio';
    final param = createParams({'audio_mute': audioMute});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  bool isAudioMuted() {
    const apiType = 'MediaPlayer_isAudioMuted';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    return result as bool;
  }

  @override
  void muteVideo(bool videoMute) {
    const apiType = 'MediaPlayer_muteVideo';
    final param = createParams({'video_mute': videoMute});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  bool isVideoMuted() {
    const apiType = 'MediaPlayer_isVideoMuted';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    return result as bool;
  }

  @override
  void setPlaybackSpeed(int speed) {
    const apiType = 'MediaPlayer_setPlaybackSpeed';
    final param = createParams({'speed': speed});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void selectAudioTrack(int index) {
    const apiType = 'MediaPlayer_selectAudioTrack';
    final param = createParams({'index': index});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void setPlayerOption({required String key, required int value}) {
    const apiType = 'MediaPlayer_setPlayerOption';
    final param = createParams({'key': key, 'value': value});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void setPlayerOption2({required String key, required String value}) {
    const apiType = 'MediaPlayer_setPlayerOption2';
    final param = createParams({'key': key, 'value': value});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void takeScreenshot(String filename) {
    const apiType = 'MediaPlayer_takeScreenshot';
    final param = createParams({'filename': filename});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void selectInternalSubtitle(int index) {
    const apiType = 'MediaPlayer_selectInternalSubtitle';
    final param = createParams({'index': index});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void setExternalSubtitle(String url) {
    const apiType = 'MediaPlayer_setExternalSubtitle';
    final param = createParams({'url': url});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  MediaPlayerState getState() {
    const apiType = 'MediaPlayer_getState';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    return result as MediaPlayerState;
  }

  @override
  void mute(bool mute) {
    const apiType = 'MediaPlayer_mute';
    final param = createParams({'mute': mute});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  bool getMute() {
    const apiType = 'MediaPlayer_getMute';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    final muteResult = rm['mute'];
    return muteResult as bool;
  }

  @override
  void adjustPlayoutVolume(int volume) {
    const apiType = 'MediaPlayer_adjustPlayoutVolume';
    final param = createParams({'volume': volume});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  int getPlayoutVolume() {
    const apiType = 'MediaPlayer_getPlayoutVolume';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    final volumeResult = rm['volume'];
    return volumeResult as int;
  }

  @override
  void adjustPublishSignalVolume(int volume) {
    const apiType = 'MediaPlayer_adjustPublishSignalVolume';
    final param = createParams({'volume': volume});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  int getPublishSignalVolume() {
    const apiType = 'MediaPlayer_getPublishSignalVolume';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    final volumeResult = rm['volume'];
    return volumeResult as int;
  }

  @override
  void setView(int view) {
    const apiType = 'MediaPlayer_setView';
    final param = createParams({'view': view});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void setRenderMode(RenderModeType renderMode) {
    const apiType = 'MediaPlayer_setRenderMode';
    final param = createParams({'renderMode': renderMode.value()});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    const apiType = 'MediaPlayer_registerPlayerSourceObserver';
    final param = createParams({'observer': observer});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    const apiType = 'MediaPlayer_unregisterPlayerSourceObserver';
    final param = createParams({'observer': observer});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void setAudioDualMonoMode(AudioDualMonoMode mode) {
    const apiType = 'MediaPlayer_setAudioDualMonoMode';
    final param = createParams({'mode': mode.value()});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  String getPlayerSdkVersion() {
    const apiType = 'MediaPlayer_getPlayerSdkVersion';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    return result as String;
  }

  @override
  String getPlaySrc() {
    const apiType = 'MediaPlayer_getPlaySrc';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
>>>>>>> release/rtc-ng/3.8.200-framework
    final result = rm['result'];
    return result as String;
  }

  @override
  void openWithAgoraCDNSrc({required String src, required int startPos}) {
    const apiType = 'MediaPlayer_openWithAgoraCDNSrc';
    final param = createParams({'src': src, 'startPos': startPos});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void getAgoraCDNLineCount() {
    const apiType = 'MediaPlayer_getAgoraCDNLineCount';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void switchAgoraCDNLineByIndex(int index) {
    const apiType = 'MediaPlayer_switchAgoraCDNLineByIndex';
    final param = createParams({'index': index});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void getCurrentAgoraCDNIndex() {
    const apiType = 'MediaPlayer_getCurrentAgoraCDNIndex';
    final param = createParams({});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void enableAutoSwitchAgoraCDN(bool enable) {
    const apiType = 'MediaPlayer_enableAutoSwitchAgoraCDN';
    final param = createParams({'enable': enable});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void renewAgoraCDNSrcToken({required String token, required int ts}) {
    const apiType = 'MediaPlayer_renewAgoraCDNSrcToken';
    final param = createParams({'token': token, 'ts': ts});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void switchAgoraCDNSrc({required String src, bool syncPts = false}) {
    const apiType = 'MediaPlayer_switchAgoraCDNSrc';
    final param = createParams({'src': src, 'syncPts': syncPts});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void switchSrc({required String src, bool syncPts = true}) {
    const apiType = 'MediaPlayer_switchSrc';
    final param = createParams({'src': src, 'syncPts': syncPts});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void preloadSrc({required String src, required int startPos}) {
    const apiType = 'MediaPlayer_preloadSrc';
    final param = createParams({'src': src, 'startPos': startPos});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void playPreloadedSrc(String src) {
    const apiType = 'MediaPlayer_playPreloadedSrc';
    final param = createParams({'src': src});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void unloadSrc(String src) {
    const apiType = 'MediaPlayer_unloadSrc';
    final param = createParams({'src': src});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }

  @override
  void setSpatialAudioParams(SpatialAudioParams params) {
    const apiType = 'MediaPlayer_setSpatialAudioParams';
    final param = createParams({'params': params.toJson()});
<<<<<<< HEAD
    final callApiResult = apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
=======
    final rm = apiCaller.callIrisApi(apiType, jsonEncode(param));
    final result = rm['result'];
>>>>>>> release/rtc-ng/3.8.200-framework
  }
}
