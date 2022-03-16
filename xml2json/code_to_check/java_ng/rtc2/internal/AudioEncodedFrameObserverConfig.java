package io.agora.rtc2.internal;

import io.agora.rtc2.Constants;

public class AudioEncodedFrameObserverConfig {
  /**
   * The postion type of audio data. Default is AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK.
   *                 <ul>
   *                 <li>{@link Constants#AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIC
   *                 AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIC(1)}
   *                 <li>{@link Constants#AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK
   *                 AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK(2)}
   *                 <li>{@link Constants#AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIXED
   *                 AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIXED(3)}
   *                 </ul>
   */
  public int postionType;
  /**
   * The encoding type of audio data. Default is AUDIO_ENCODING_TYPE_OPUS_48000_MEDIUM.
   *                 <ul>
   *                 <li>{@link Constants#AUDIO_ENCODING_TYPE_AAC_16000_LOW
   *                 AUDIO_ENCODING_TYPE_AAC_16000_LOW(1)}
   *                 <li>{@link Constants#AUDIO_ENCODING_TYPE_AAC_32000_MEDIUM
   *                 AUDIO_ENCODING_TYPE_AAC_32000_MEDIUM(4)}
   *                 <li>{@link Constants#AUDIO_ENCODING_TYPE_AAC_48000_HIGH
   *                 AUDIO_ENCODING_TYPE_AAC_48000_HIGH(7)}
   *                 <li>{@link Constants#AUDIO_ENCODING_TYPE_OPUS_16000_LOW
   *                 AUDIO_ENCODING_TYPE_OPUS_16000_LOW(11)}
   *                 <li>{@link Constants#AUDIO_ENCODING_TYPE_OPUS_48000_HIGH
   *                 AUDIO_ENCODING_TYPE_OPUS_48000_HIGH(14)}
   *                 </ul>
   */
  public int encodingType;

  public AudioEncodedFrameObserverConfig() {
    postionType = Constants.AUDIO_FILE_RECORDING_PLAYBACK;
    encodingType = Constants.AUDIO_ENCODING_TYPE_OPUS_48000_MEDIUM;
  }
}