package io.agora.rtc2.internal;

import io.agora.rtc2.Constants;

public class AudioRecordingConfiguration {
  /**
   * The path of recording file.
   * The string of the file path is in UTF-8 code.
   */
  public String filePath;

  /**
   * The sample rate of audio data. Default is 32000.
   * The optional value is 16000, 32000, 44100, or 48000.
   */
  public int sampleRate;

  /**
   * Determines whether to encode audio data.
   * - true: (Default) Encode the audio data with AAC Encoder.
   * - false: Do not encode the audio data. Save audio data as a wav file.
   */
  public boolean codec;

  /**
   * The recording type of audio data. Default is AUDIO_FILE_RECORDING_MIXED.
   *                 <ul>
   *                 <li>{@link Constants#AUDIO_FILE_RECORDING_MIC
   *                 AUDIO_FILE_RECORDING_MIC(1)}
   *                 <li>{@link Constants#AUDIO_FILE_RECORDING_PLAYBACK
   *                 AUDIO_FILE_RECORDING_PLAYBACK(2)}
   *                 <li>{@link Constants#AUDIO_FILE_RECORDING_MIXED
   *                 AUDIO_FILE_RECORDING_MIXED(3)}
   *                 </ul>
   */
  public int fileRecordOption;

  /**
   * The recording quality of audio data. Default is AUDIO_RECORDING_QUALITY_LOW.
   *                <ul>
   *                <li>{@link Constants#AUDIO_RECORDING_QUALITY_LOW
   *                AUDIO_RECORDING_QUALITY_LOW(0)}
   *                <li>{@link Constants#AUDIO_RECORDING_QUALITY_MEDIUM
   *                AUDIO_RECORDING_QUALITY_MEDIUM(1)}
   *                <li>{@link Constants#AUDIO_RECORDING_QUALITY_HIGH
   *                AUDIO_RECORDING_QUALITY_HIGH(2)}
   *                </ul>
   */
  public int quality;

  /**
   * The Audio file recording config.
   */
  public AudioRecordingConfiguration() {
    sampleRate = 32000;
    codec = true;
    fileRecordOption = Constants.AUDIO_FILE_RECORDING_MIXED;
    quality = Constants.AUDIO_RECORDING_QUALITY_LOW;
  }
}