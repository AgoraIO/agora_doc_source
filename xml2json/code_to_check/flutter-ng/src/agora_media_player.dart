import 'package:agora_rtc_ng/src/binding_forward_export.dart';

abstract class MediaPlayer {
  int getMediaPlayerId();

  Future<void> open({required String url, required int startPos});

  Future<void> play();

  Future<void> pause();

  Future<void> stop();

  Future<void> resume();

  Future<void> seek(int newPos);

  Future<void> setAudioPitch(int pitch);

  Future<int> getDuration();

  Future<int> getPlayPosition();

  Future<int> getStreamCount();

  Future<PlayerStreamInfo> getStreamInfo(int index);

  Future<void> setLoopCount(int loopCount);

  Future<void> muteAudio(bool audioMute);

  Future<bool> isAudioMuted();

  Future<void> muteVideo(bool videoMute);

  Future<bool> isVideoMuted();

  Future<void> setPlaybackSpeed(int speed);

  Future<void> selectAudioTrack(int index);

  Future<void> setPlayerOption({required String key, required int value});

  Future<void> setPlayerOption2({required String key, required String value});

  Future<void> takeScreenshot(String filename);

  Future<void> selectInternalSubtitle(int index);

  Future<void> setExternalSubtitle(String url);

  Future<MediaPlayerState> getState();

  Future<void> mute(bool mute);

  Future<bool> getMute();

  Future<void> adjustPlayoutVolume(int volume);

  Future<int> getPlayoutVolume();

  Future<void> adjustPublishSignalVolume(int volume);

  Future<int> getPublishSignalVolume();

  Future<void> setView(int view);

  Future<void> setRenderMode(RenderModeType renderMode);

  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer);

  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer);

  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode);

  Future<String> getPlayerSdkVersion();

  Future<String> getPlaySrc();

  Future<void> openWithAgoraCDNSrc(
      {required String src, required int startPos});

  Future<void> getAgoraCDNLineCount();

  Future<void> switchAgoraCDNLineByIndex(int index);

  Future<void> getCurrentAgoraCDNIndex();

  Future<void> enableAutoSwitchAgoraCDN(bool enable);

  Future<void> renewAgoraCDNSrcToken({required String token, required int ts});

  Future<void> switchAgoraCDNSrc({required String src, bool syncPts = false});

  Future<void> switchSrc({required String src, bool syncPts = true});

  Future<void> preloadSrc({required String src, required int startPos});

  Future<void> playPreloadedSrc(String src);

  Future<void> unloadSrc(String src);

  Future<void> setSpatialAudioParams(SpatialAudioParams params);
}
