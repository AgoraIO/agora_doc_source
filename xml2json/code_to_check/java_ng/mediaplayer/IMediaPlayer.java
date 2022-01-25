//
//  Agora RTC/MEDIA SDK
//
//  Created by Wei Wu in 2020-12.
//  Copyright (c) 2020 Agora.io. All rights reserved.
//

package io.agora.mediaplayer;

import android.view.View;
import io.agora.mediaplayer.data.MediaStreamInfo;

public interface IMediaPlayer {
  /**
   * Get unique source id of the media player.
   * @return
   * - >= 0: The source id of this media player.
   * - < 0: Failure.
   */
  int getMediaPlayerId();

  /**
   * Opens a media file with a specified URL.
   * @param url The URL of the media file that you want to play.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int open(String url, long startPos);

  /**
   * Opens a media with custom data provider
   * @param startPos the start position
   * @param provider custom data provider
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int openWithCustomSource(long startPos, IMediaPlayerCustomDataProvider provider);

  /**
   * Plays the media file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int play();

  /**
   * Pauses playing the media file.
   */
  int pause();

  /**
   * Stops playing the current media file.
   */
  int stop();

  /**
   * Resumes playing the media file.
   */
  int resume();

  /**
   * Sets the current playback position of the media file.
   * @param newPos The new playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int seek(long newPos);

  /**
   * Sets the pitch of the current media file.
   * @param pitch Sets the pitch of the local music file by chromatic scale. The default value is 0,
   * which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value
   * between consecutive values is a chromatic value. The greater the absolute value of this
   * parameter, the higher or lower the pitch of the local music file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int setAudioPitch(int pitch);

  /**
   * @param mute Whether to mute on
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   * @brief Turn mute on or off
   */
  int mute(boolean mute);

  /**
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   * @brief Get mute state
   * @param[out] mute Whether is mute on
   */
  boolean isMuted();

  /**
   * @param volume The volume value to be adjusted
   *               The volume can be adjusted from 0 to 400:
   *               0: mute;
   *               100: original volume;
   *               400: Up to 4 times the original volume (with built-in overflow protection).
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   * @brief Adjust playback volume
   */
  int adjustPlayoutVolume(int volume);

  /**
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   * @brief Get the current playback volume
   * @param[out] volume
   */
  int getPlayoutVolume();

  /**
   * Gets the current playback position of the media file.
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   */
  long getPlayPosition();

  /**
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   * @brief Get media duration
   * @param[out] duration Duration in seconds
   */
  long getDuration();

  /**
   * @return MediaPlayerState
   * @brief Get player state
   */
  Constants.MediaPlayerState getState();

  /**
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   * @brief Get the number of streams in the media
   * @param[out] count
   */
  int getStreamCount();

  /**
   * @param videoView view object, windows platform is HWND
   * @return int <= 0 On behalf of an error, the value corresponds to one of MediaPlayerError
   * @brief Set video rendering view
   */
  int setView(View videoView);

  /**
   * @brief Set video display mode
   *
   * @param mode Video display mode
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_ERROR
   */
  int setRenderMode(int mode);

  MediaStreamInfo getStreamInfo(int index);

  /**
   * Sets whether to loop the media file for playback.
   * @param loopCount the number of times looping the media file.
   * - 0: Play the audio effect once.
   * - 1: Play the audio effect twice.
   * - -1: Play the audio effect in a loop indefinitely, until stopEffect() or stop() is called.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int setLoopCount(int loopCount);

  /**
   * Change playback speed
   * @param speed the enum of playback speed
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int setPlaybackSpeed(int speed);

  /**
   * Select playback audio track of the media file
   * @param index the index of the audio track in media file
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int selectAudioTrack(int index);

  /**
   * change player option before play a file
   * @param key the key of the option param
   * @param value the value of option param
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int setPlayerOption(String key, int value);

  /**
   * take screenshot while playing  video
   * @param filename the filename of screenshot file
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int takeScreenshot(String filename);

  /**
   * select internal subtitles in video
   * @param index the index of the internal subtitles
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int selectInternalSubtitle(int index);

  /**
   * set an external subtitle for video
   * @param url The URL of the subtitle file that you want to load.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int setExternalSubtitle(String url);

  /**
   * @brief adjust publish signal volume
   *
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_ERROR
   */
  int adjustPublishSignalVolume(int volume);

  /**
   * @brief get publish signal volume
   *
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_ERROR
   */
  int getPublishSignalVolume();

  /**
   * Gets the url of the current play media file for publishing.
   *
   * @return
   * the current play media file for publishing.
   */
  String getPlaySrc();

  /**
   * @brief switch to another play source
   * @param src The URL of the source
   * @param syncPts whether to sync pts for the other source
   *
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_ERROR
   */
  int switchSrc(String src, boolean syncPts);

  /**
   * @brief preload  another play source
   * @param src The URL of the source
   * @param syncPts whether to sync pts for the other source
   *
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_ERROR
   */
  int preloadSrc(String src, long startPos);
  
  int unloadSrc(String src);

  /**
   * @brief play the preloaded source
   * @param src The URL of the source
   *
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_ERROR
   */
  int playPreloadedSrc(String src);

  /**
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int destroy();

  /**
   * Registers a media player observer.
   *
   * Once the media player observer is registered, you can use the observer to monitor the state
   * change of the media player.
   * @param playerObserver The pointer to the IMediaPlayerObserver object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int registerPlayerObserver(IMediaPlayerObserver playerObserver);

  /**
   * Releases the media player observer.
   * @param playerObserver The pointer to the IMediaPlayerObserver object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int unRegisterPlayerObserver(IMediaPlayerObserver playerObserver);

  // AudioFrameObserver
  int registerAudioFrameObserver(IMediaPlayerAudioFrameObserver audioFrameObserver, int mode);

  /**
   * Set dual-mono output mode of the music file.
   * @param mode See {@link Constants#AudioDualMonoMode AudioDualMonoMode}. Default in
   *     AUDIO_DUAL_MONO_STEREO
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int setAudioDualMonoMode(int mode);

  // VideoFrameObserver
  int registerVideoFrameObserver(IMediaPlayerVideoFrameObserver videoFrameObserver);

  /**
   * Open the Agora CDN media source.
   * @param src The src of the media file that you want to play.
   * @param startPos The  playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */

  int openWithAgoraCDNSrc(String src, long startPos);

  /**
   * Gets the number of  Agora CDN lines.
   * @return
   * - > 0: number of CDN.
   * - <= 0: Failure.
   */
  int getAgoraCDNLineCount();

  /**
   * Switch Agora CDN lines.
   * @param index Specific CDN line index.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int switchAgoraCDNLineByIndex(int index);

  /**
   * Gets the line of the current CDN.
   * @return
   * - >= 0: Specific line.
   * - < 0: Failure.
   */
  int getCurrentAgoraCDNIndex();

  /**
   * Enable automatic CDN line switching.
   * @param enable Whether enable.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int enableAutoSwitchAgoraCDN(boolean enable);

  /**
   * Update the CDN source token and timestamp.
   * @param token token.
   * @param ts ts.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int renewAgoraCDNSrcToken(String token, long ts);

  /**
   * Switch the CDN source.
   * @param src Specific src.
   * @param syncPts Live streaming must be set to false.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  int switchAgoraCDNSrc(String src, boolean syncPts);
}
