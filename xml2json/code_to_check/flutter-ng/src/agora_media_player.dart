import 'package:agora_rtc_ng/src/binding_forward_export.dart';

abstract class MediaPlayer {
  int getMediaPlayerId();

  void open({required String url, required int startPos});

  void play();

  void pause();

  void stop();

  void resume();

  void seek(int newPos);

  void setAudioPitch(int pitch);

  int getDuration();

  int getPlayPosition();

  int getStreamCount();

  PlayerStreamInfo getStreamInfo(int index);

  void setLoopCount(int loopCount);

  void muteAudio(bool audioMute);

  bool isAudioMuted();

  void muteVideo(bool videoMute);

  bool isVideoMuted();

  void setPlaybackSpeed(int speed);

  void selectAudioTrack(int index);

  void setPlayerOption({required String key, required int value});

  void setPlayerOption2({required String key, required String value});

  void takeScreenshot(String filename);

  void selectInternalSubtitle(int index);

  void setExternalSubtitle(String url);

  MediaPlayerState getState();

  void mute(bool mute);

  bool getMute();

  void adjustPlayoutVolume(int volume);

  int getPlayoutVolume();

  void adjustPublishSignalVolume(int volume);

  int getPublishSignalVolume();

  void setView(int view);

  void setRenderMode(RenderModeType renderMode);

  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer);

  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer);

  void setAudioDualMonoMode(AudioDualMonoMode mode);

  String getPlayerSdkVersion();

  String getPlaySrc();

  void openWithAgoraCDNSrc({required String src, required int startPos});

  void getAgoraCDNLineCount();

  void switchAgoraCDNLineByIndex(int index);

  void getCurrentAgoraCDNIndex();

  void enableAutoSwitchAgoraCDN(bool enable);

  void renewAgoraCDNSrcToken({required String token, required int ts});

  void switchAgoraCDNSrc({required String src, bool syncPts = false});

  void switchSrc({required String src, bool syncPts = true});

  void preloadSrc({required String src, required int startPos});

  void playPreloadedSrc(String src);

  void unloadSrc(String src);

  void setSpatialAudioParams(SpatialAudioParams params);
}
