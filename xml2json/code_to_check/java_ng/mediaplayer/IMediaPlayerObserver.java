package io.agora.mediaplayer;

import io.agora.base.internal.CalledByNative;
import io.agora.mediaplayer.data.PlayerUpdatedInfo;
import io.agora.mediaplayer.data.SrcInfo;
import io.agora.mediaplayer.Constants;
import io.agora.mediaplayer.data.SrcInfo;

public interface IMediaPlayerObserver {
  /**
   * @param state New player state
   * @param error Reason for state change
   * @brief Triggered when the player state changes
   */
  @CalledByNative
  void onPlayerStateChanged(Constants.MediaPlayerState state, Constants.MediaPlayerError error);

  /**
   * @param position Current playback progress, in seconds
   * @brief Triggered when the player progress changes, once every 1 second
   */
  @CalledByNative void onPositionChanged(long position);

  /**
   * @brief Reports the playback event.
   *
   * - After calling the `seek` method, the SDK triggers the callback to report the results of the
   * seek operation.
   * - After calling the `selectAudioTrack` method, the SDK triggers the callback to report that the
   * audio track changes.
   *
   * @param eventCode The playback event. See {@link media::base::MEDIA_PLAYER_EVENT
   *     MEDIA_PLAYER_EVENT}.
   * @param elapsedTime The playback elapsed time.
   * @param message The playback message.
   */
  @CalledByNative
  void onPlayerEvent(Constants.MediaPlayerEvent eventCode, long elapsedTime, String message);

  /**
   * @brief Triggered when information is obtained
   */
  @CalledByNative void onMetaData(Constants.MediaPlayerMetadataType type, byte[] data);

  /**
   * @param playCachedBuffer Current playback buffer, in seconds
   * @brief Triggered current playback buffer, once every 1 second
   */
  @CalledByNative void onPlayBufferUpdated(long playCachedBuffer);

  /**
   * @param src Current preload src
   * @param event Triggered event happened
   * @brief Triggered current playback buffer, once every 1 second
   */
  @CalledByNative void onPreloadEvent(String src, Constants.MediaPlayerPreloadEvent event);

  /**
   * @brief Occurs when one playback of the media file is completed.
   */
  @CalledByNative void onCompleted();

  /**
   * @brief AgoraCDN Token has expired and needs to be set up with renewAgoraCDNSrcToken.
   */
  @CalledByNative void onAgoraCDNTokenWillExpire();

  /**
   * @brief Reports current playback source bitrate changed.
   * @brief Reports current playback source info changed.
   *
   * @param from Streaming media information before the change.
   * @param to Streaming media information after the change.
   */
  @CalledByNative void onPlayerSrcInfoChanged(SrcInfo from, SrcInfo to);

  /**
   * @brief Triggered when  media player information updated.
   *
   * @param info Include information of media player.
   */
  @CalledByNative void onPlayerInfoUpdated(PlayerUpdatedInfo info);

  /**
   * @brief Triggered  every 200 millisecond ,update player current volume range [0,255]
   *
   * @param volume volume of current player.
   */
  @CalledByNative void onAudioVolumeIndication(int volume);
}
