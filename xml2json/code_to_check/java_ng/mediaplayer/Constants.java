//
//  Agora RTC/MEDIA SDK
//
//  Created by Tongjiangyong in 2019-11.
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
package io.agora.mediaplayer;

import io.agora.base.internal.CalledByNative;

public class Constants {
  /**
   * Media type.
   */
  public enum MediaPlayerState {
    /**
     * Player unknown
     */
    PLAYER_STATE_UNKNOWN(-1),
    /**
     * Player idle
     */
    PLAYER_STATE_IDLE(0),
    /**
     * Opening media file
     */
    PLAYER_STATE_OPENING(1),
    /**
     * Media file opened successfully
     */
    PLAYER_STATE_OPEN_COMPLETED(2),
    /**
     * Player playing
     */
    PLAYER_STATE_PLAYING(3),
    /**
     * Player paused
     */
    PLAYER_STATE_PAUSED(4),
    /**
     * Player playback one loop completed
     */
    PLAYER_STATE_PLAYBACK_COMPLETED(5),
    /**
     * Player playback all loops completed
     */
    PLAYER_STATE_PLAYBACK_ALL_LOOPS_COMPLETED(6),
    /**
     * The playback is stopped.
     */
    PLAYER_STATE_STOPPED(7),
    /**
     *Player pausing (internal)
     */
    PLAYER_STATE_PAUSING_INTERNAL(50),
    /**
     * Player stopping (internal)
     */
    PLAYER_STATE_STOPPING_INTERNAL(51),
    /**
     * Player seeking state (internal)
     */
    PLAYER_STATE_SEEKING_INTERNAL(52),
    /**
     * Player getting state (internal)
     */
    PLAYER_STATE_GETTING_INTERNAL(53),
    /**
     * None state for state machine (internal)
     */
    PLAYER_STATE_NONE_INTERNAL(54),
    /**
     * Do nothing state for state machine (internal)
     */
    PLAYER_STATE_DO_NOTHING_INTERNAL(55),
    /**
     * Player failed
     */
    PLAYER_STATE_FAILED(100);

    private int value;

    private MediaPlayerState(int v) {
      value = v;
    }

    public static int getValue(MediaPlayerState type) {
      return type.value;
    }

    @CalledByNative("MediaPlayerState")
    public static MediaPlayerState fromNativeIndex(int nativeIndex) {
      return getStateByValue(nativeIndex);
    }

    public static MediaPlayerState getStateByValue(int value) {
      MediaPlayerState[] states = values();
      for (MediaPlayerState state : states) {
        if (state.value == value) {
          return state;
        }
      }
      return PLAYER_STATE_UNKNOWN;
    }
  }

  /**
   * @brief Player error code
   */

  public enum MediaPlayerError {
    /**
     * No error
     */
    PLAYER_ERROR_NONE(0),
    /**
     * The parameter is incorrect
     */
    PLAYER_ERROR_INVALID_ARGUMENTS(-1),
    /**
     * Internel error
     */
    PLAYER_ERROR_INTERNAL(-2),
    /**
     * No resource error
     */
    PLAYER_ERROR_NO_RESOURCE(-3),
    /**
     * Media source is invalid
     */
    PLAYER_ERROR_INVALID_MEDIA_SOURCE(-4),
    /**
     * Unknown stream type
     */
    PLAYER_ERROR_UNKNOWN_STREAM_TYPE(-5),
    /**
     * Object is not initialized
     */
    PLAYER_ERROR_OBJ_NOT_INITIALIZED(-6),
    /**
     * Decoder codec not supported
     */
    PLAYER_ERROR_CODEC_NOT_SUPPORTED(-7),
    /**
     * Video renderer is invalid
     */
    PLAYER_ERROR_VIDEO_RENDER_FAILED(-8),
    /**
     * Internal state error
     */
    PLAYER_ERROR_INVALID_STATE(-9),
    /**
     * Url not found
     */
    PLAYER_ERROR_URL_NOT_FOUND(-10),
    /**
     * Invalid connection state
     */
    PLAYER_ERROR_INVALID_CONNECTION_STATE(-11),
    /**
     * Insufficient buffer data
     */
    PLAY_ERROR_SRC_BUFFER_UNDERFLOW(-12),
    /**
     * Url not found
     */
    PLAYER_ERROR_INTERRUPTED(-13),
    /**
     * format not support
     */
    PLAYER_ERROR_NOT_SUPPORTED(-14),
    /**
     * token expired
     */
    PLAYER_ERROR_TOKEN_EXPIRED(-15),
    /**
     * ip expired
     */
    PLAYER_ERROR_IP_EXPIRED(-16),

    /**
     * Error unknown
     */
    PLAYER_ERROR_UNKNOWN(-100);
    private int value;

    private MediaPlayerError(int v) {
      value = v;
    }

    public static int getValue(MediaPlayerError type) {
      return type.value;
    }

    @CalledByNative("MediaPlayerError")
    public static MediaPlayerError fromNativeIndex(int nativeIndex) {
      return getErrorByValue(nativeIndex);
    }

    public static MediaPlayerError getErrorByValue(int value) {
      MediaPlayerError[] errors = values();
      for (MediaPlayerError error : errors) {
        if (error.value == value) {
          return error;
        }
      }
      return PLAYER_ERROR_UNKNOWN;
    }
  }

  /**
   * @brief Player event
   */

  public enum MediaPlayerEvent {
    /**
     * Event unknown
     */
    PLAYER_EVENT_UNKNOWN(-1),
    /**
     * seek complete
     */
    PLAYER_EVENT_SEEK_BEGIN(0),
    /**
     * seek complete
     */
    PLAYER_EVENT_SEEK_COMPLETE(1),
    /**
     * seek failed
     */
    PLAYER_EVENT_SEEK_ERROR(2),
    /**
     * player video published
     */
    PLAYER_EVENT_VIDEO_PUBLISHED(3),
    /**
     * player audio published
     */
    PLAYER_EVENT_AUDIO_PUBLISHED(4),
    /**
     * audio track changed
     */
    PLAYER_EVENT_AUDIO_TRACK_CHANGED(5),
    /**
     * player buffer low
     */
    PLAYER_EVENT_BUFFER_LOW(6),
    /**
     * player buffer recover
     */
    PLAYER_EVENT_BUFFER_RECOVER(7),
    /**
     * The video or audio is interrupted
     */
    PLAYER_EVENT_FREEZE_START(8),
    /**
     * Interrupt at the end of the video or audio
     */
    PLAYER_EVENT_FREEZE_STOP(9),
    /**
     * switch source begin
     */
    PLAYER_EVENT_SWITCH_BEGIN(10),
    /**
     * switch source complete
     */
    PLAYER_EVENT_SWITCH_COMPLETE(11),
    /**
     * switch source error
     */
    PLAYER_EVENT_SWITCH_ERROR(12),
    /**
     * first video displayed
     */
    PLAYER_EVENT_FIRST_DISPLAYED(13);

    private int value;

    private MediaPlayerEvent(int v) {
      value = v;
    }

    public static int getValue(MediaPlayerEvent type) {
      return type.value;
    }

    @CalledByNative("MediaPlayerEvent")
    public static MediaPlayerEvent fromNativeIndex(int nativeIndex) {
      return getEventByValue(nativeIndex);
    }

    public static MediaPlayerEvent getEventByValue(int value) {
      MediaPlayerEvent[] events = values();
      for (MediaPlayerEvent event : events) {
        if (event.value == value) {
          return event;
        }
      }
      return PLAYER_EVENT_UNKNOWN;
    }
  }

  /**
   * @brief Player Preload event
   */
  public enum MediaPlayerPreloadEvent {
    PLAYER_PRELOAD_EVENT_BEGIN(0),
    PLAYER_PRELOAD_EVENT_COMPLETE(1),
    PLAYER_PRELOAD_EVENT_ERROR(2);

    private int value;

    private MediaPlayerPreloadEvent(int v) {
      value = v;
    }

    public static int getValue(MediaPlayerPreloadEvent type) {
      return type.value;
    }

    @CalledByNative("MediaPlayerPreloadEvent")
    public static MediaPlayerPreloadEvent fromNativeIndex(int nativeIndex) {
      return getTypeByValue(nativeIndex);
    }

    public static MediaPlayerPreloadEvent getTypeByValue(int value) {
      MediaPlayerPreloadEvent[] evnets = values();
      for (MediaPlayerPreloadEvent event : evnets) {
        if (event.value == value) {
          return event;
        }
      }
      return PLAYER_PRELOAD_EVENT_ERROR;
    }
  }

  /**
   * @brief Player Metadata type
   */
  public enum MediaPlayerMetadataType {
    /** data type unknown*/
    PLAYER_METADATA_TYPE_UNKNOWN(0),
    /** sei data*/
    PLAYER_METADATA_TYPE_SEI(1);

    private int value;

    private MediaPlayerMetadataType(int v) {
      value = v;
    }

    public static int getValue(MediaPlayerMetadataType type) {
      return type.value;
    }

    @CalledByNative("MediaPlayerMetadataType")
    public static MediaPlayerMetadataType fromNativeIndex(int nativeIndex) {
      return getTypeByValue(nativeIndex);
    }

    public static MediaPlayerMetadataType getTypeByValue(int value) {
      MediaPlayerMetadataType[] types = values();
      for (MediaPlayerMetadataType type : types) {
        if (type.value == value) {
          return type;
        }
      }
      return PLAYER_METADATA_TYPE_UNKNOWN;
    }
  }
  /**
   * @brief Media stream type
   */
  public enum MediaStreamType {
    /**
     * Unknown stream type
     */
    STREAM_TYPE_UNKNOWN(0),
    /**
     * Video stream
     */
    STREAM_TYPE_VIDEO(1),
    /**
     * Audio stream
     */
    STREAM_TYPE_AUDIO(2),
    /**
     * Subtitle stream
     */
    STREAM_TYPE_SUBTITLE(3);

    private int value;

    private MediaStreamType(int v) {
      value = v;
    }

    public static int getValue(MediaStreamType type) {
      return type.value;
    }
  }

  public enum AudioDualMonoMode {
    /**
     * ChanLOut=ChanLin, ChanRout=ChanRin
     */
    AUDIO_DUAL_MONO_STEREO(0),
    /**
     * ChanLOut=ChanRout=ChanLin
     */
    AUDIO_DUAL_MONO_L(1),
    /**
     * ChanLOut=ChanRout=ChanRin
     */
    AUDIO_DUAL_MONO_R(2),
    /**
     * ChanLout=ChanRout=(ChanLin+ChanRin)/2
     */
    AUDIO_DUAL_MONO_MIX(3);

    private int value;
    private AudioDualMonoMode(int v) {
      value = v;
    }

    public static int getValue(AudioDualMonoMode mode) {
      return mode.value;
    }
  }

  public static final int PLAYER_ERROR_NOT_INIT = -1;

  /**
   * @brief Media mode type
   */
  public static final int PLAYER_RENDER_MODE_HIDDEN = 1;
  public static final int PLAYER_RENDER_MODE_FIT = 2;
  public static final int PLAYER_RENDER_MODE_ADAPTIVE = 3;
}
