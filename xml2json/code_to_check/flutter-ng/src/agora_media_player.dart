import 'package:agora_rtc_ng/src/binding_forward_export.dart';

/// This class provides media player functions and supports multiple instances.
///
abstract class MediaPlayer {
  /// Gets the ID of the media player.
  ///
  ///
  /// Returns
  /// ≥ 0: Success. The ID of the media player.
  ///  < 0: Failure.
  int getMediaPlayerId();

  /// Opens the media resource.
  ///
  ///
  /// * [url] The path of the media file. Both local path and online path are supported.On the Android platform, the URI format is not supported.
  ///
  /// * [startPos] The starting position (ms) for playback. Default value is 0.
  Future<void> open({required String url, required int startPos});

  /// @nodoc
  Future<void> openWithMediaSource(MediaSource source);

  /// Plays the media file.
  /// After calling open or seek, you can call this method to play the media file.
  Future<void> play();

  /// Pauses the playback.
  ///
  Future<void> pause();

  /// Stops playing the media track.
  ///
  Future<void> stop();

  /// Resumes playing the media file.
  ///
  Future<void> resume();

  /// Seeks to a new playback position.
  /// After successfully calling this method, you will receive the onPlayerEvent callback, reporting the result of the seek operation to the new playback position.
  ///  To play the media file from a specific position, do the following:
  ///  Call this method to seek to the position you want to begin playback.
  ///  Call the play method to play the media file.
  ///
  /// * [newPos] The new playback position (ms).
  Future<void> seek(int newPos);

  /// Sets the pitch of the current media resource.
  /// Call this method after calling open .
  ///
  /// * [pitch] Sets the pitch of the local music file by the chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.
  Future<void> setAudioPitch(int pitch);

  /// Gets the duration of the media resource.
  ///
  ///
  /// Returns
  /// The total duration (ms) of the media file.
  Future<int> getDuration();

  /// Gets current local playback progress.
  ///
  ///
  /// Returns
  /// Returns the current playback progress (ms) if the call succeeds.
  ///  < 0: Failure. See MediaPlayerError .
  Future<int> getPlayPosition();

  /// Gets the number of the media streams in the media resource.
  /// Call this method after calling open .
  ///
  /// Returns
  /// The number of the media streams in the media resource if the method call succeeds.
  ///  < 0: Failure. See MediaPlayerError .
  Future<int> getStreamCount();

  /// Gets the detailed information of the media stream.
  /// Call this method after calling getStreamCount .
  ///
  /// * [index] The index of the media stream.
  ///
  /// Returns
  /// If the call succeeds, returns the detailed information of the media stream. See PlayerStreamInfo .
  ///  If the call fails, returns NULL.
  Future<PlayerStreamInfo> getStreamInfo(int index);

  /// Sets the loop playback.
  /// If you want to loop, call this method and set the number of the loops.
  ///  When the loop finishes, the SDK triggers onPlayerSourceStateChanged and reports the playback state as playerStatePlaybackAllLoopsCompleted.
  ///
  /// * [loopCount] The number of times the audio effect loops:
  Future<void> setLoopCount(int loopCount);

  /// @nodoc
  Future<void> setPlaybackSpeed(int speed);

  /// @nodoc
  Future<void> selectAudioTrack(int index);

  /// @nodoc
  Future<void> takeScreenshot(String filename);

  /// @nodoc
  Future<void> selectInternalSubtitle(int index);

  /// @nodoc
  Future<void> setExternalSubtitle(String url);

  /// Gets current playback state.
  ///
  ///
  /// Returns
  /// The current playback state. See MediaPlayerState .
  Future<MediaPlayerState> getState();

  /// Sets whether to mute the media file.
  ///
  ///
  /// * [mute] Whether to mute the media file:
  ///  true: Mute the media file.
  ///  false: (Default) Unmute the media file.
  ///
  Future<void> mute(bool muted);

  /// Reports whether the media resource is muted.
  ///
  ///
  /// Returns
  /// true: Reports whether the media resource is muted.
  ///  false: Reports whether the media resource is muted.
  Future<bool> getMute();

  /// Adjusts the local playback volume.
  ///
  ///
  /// * [volume] The local playback volume, which ranges from 0 to 100:
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///
  Future<void> adjustPlayoutVolume(int volume);

  /// Gets the local playback volume.
  ///
  ///
  /// Returns
  /// The local playback volume, which ranges from 0 to 100.
  ///  0: Mute.
  ///  100: (Default) The original volume.
  Future<int> getPlayoutVolume();

  /// Adjusts the volume of the media file for publishing.
  /// After connected to the Agora server, you can call this method to adjust the volume of the media file heard by the remote user.
  ///
  /// * [volume] The volume, which ranges from 0 to 400:
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  ///
  Future<void> adjustPublishSignalVolume(int volume);

  /// Gets the volume of the media file for publishing.
  ///
  ///
  /// Returns
  /// ≥ 0: The remote playback volume.
  ///  < 0: Failure.
  Future<int> getPublishSignalVolume();

  /// Sets the view.
  ///
  Future<void> setView(int view);

  /// Sets the render mode of the media player.
  ///
  ///
  /// * [renderMode] Sets the render mode of the view. See RenderModeType .
  ///
  Future<void> setRenderMode(RenderModeType renderMode);

  /// Registers a media player observer.
  ///
  ///
  /// * [observer] The player observer, listening for events during the playback. See MediaPlayerSourceObserver .
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// Releases a media player observer.
  ///
  ///
  /// * [observer] The player observer, listening for events during the playback. See MediaPlayerSourceObserver .
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// @nodoc
  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer, required int intervalInMS});

  /// @nodoc
  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer);

  /// Sets the channel mode of the current audio file.
  /// In a stereo music file, the left and right channels can store different audio data. According to your needs, you can set the channel mode to original mode, left channel mode, right channel mode, or mixed channel mode. For example, in the KTV scenario, the left channel of the music file stores the musical accompaniment, and the right channel stores the singing voice. If you only need to listen to the accompaniment, call this method to set the channel mode of the music file to left channel mode; if you need to listen to the accompaniment and the singing voice at the same time, call this method to set the channel mode to mixed channel mode. Call this method after calling open .
  ///  This method only applies to stereo audio files.
  ///
  /// * [mode] The channel mode. See AudioDualMonoMode .
  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode);

  /// @nodoc
  Future<String> getPlayerSdkVersion();

  /// @nodoc
  Future<String> getPlaySrc();

  /// @nodoc
  Future<void> openWithAgoraCDNSrc(
      {required String src, required int startPos});

  /// @nodoc
  Future<int> getAgoraCDNLineCount();

  /// @nodoc
  Future<void> switchAgoraCDNLineByIndex(int index);

  /// @nodoc
  Future<int> getCurrentAgoraCDNIndex();

  /// @nodoc
  Future<void> enableAutoSwitchAgoraCDN(bool enable);

  /// @nodoc
  Future<void> renewAgoraCDNSrcToken({required String token, required int ts});

  /// @nodoc
  Future<void> switchAgoraCDNSrc({required String src, bool syncPts = false});

  /// @nodoc
  Future<void> switchSrc({required String src, bool syncPts = true});

  /// @nodoc
  Future<void> preloadSrc({required String src, required int startPos});

  /// @nodoc
  Future<void> playPreloadedSrc(String src);

  /// @nodoc
  Future<void> unloadSrc(String src);

  /// @nodoc
  Future<void> setSpatialAudioParams(SpatialAudioParams params);

  /// @nodoc
  Future<void> setSoundPositionParams(
      {required double pan, required double gain});

  /// @nodoc
  void registerAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  /// @nodoc
  void unregisterAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  /// @nodoc
  void registerVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  /// @nodoc
  void unregisterVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  /// @nodoc
  Future<void> setPlayerOptionInInt({required String key, required int value});

  /// @nodoc
  Future<void> setPlayerOptionInString(
      {required String key, required String value});
}

/// @nodoc
abstract class MediaPlayerCacheManager {
  /// @nodoc
  Future<void> removeAllCaches();

  /// @nodoc
  Future<void> removeOldCache();

  /// @nodoc
  Future<void> removeCacheByUri(String uri);

  /// @nodoc
  Future<void> setCacheDir(String path);

  /// @nodoc
  Future<void> setMaxCacheFileCount(int count);

  /// @nodoc
  Future<void> setMaxCacheFileSize(int cacheSize);

  /// @nodoc
  Future<void> enableAutoRemoveCache(bool enable);

  /// @nodoc
  Future<String> getCacheDir(int length);

  /// @nodoc
  Future<int> getMaxCacheFileCount();

  /// @nodoc
  Future<int> getMaxCacheFileSize();

  /// @nodoc
  Future<int> getCacheFileCount();
}

/// @nodoc
class MediaPlayerAudioFrameObserver {
  /// @nodoc
  const MediaPlayerAudioFrameObserver({
    this.onFrame,
  });

  /// @nodoc
  final void Function(AudioPcmFrame frame)? onFrame;
}

/// @nodoc
class MediaPlayerVideoFrameObserver {
  /// @nodoc
  const MediaPlayerVideoFrameObserver({
    this.onFrame,
  });

  /// @nodoc
  final void Function(VideoFrame frame)? onFrame;
}
