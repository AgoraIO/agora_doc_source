package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;
import java.nio.ByteBuffer;

public interface IAudioEncodedFrameObserver {
  /**
   * Occurs when the recorded audio frame is received.
   * @param buffer The audio frame payload.
   * @param samplesPerChannel The samples per channel.
   * @param channels The number of audio channels. If the channel uses stereo, the data is
   *     interleaved.
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerSec The number of samples per channel per second in the audio frame.
   * @param codecType The codec type.
   */
  @CalledByNative
  public abstract void onRecordAudioEncodedFrame(
      ByteBuffer buffer, int samplesPerChannel, int channels, int samplesPerSec, int codecType);
  /**
   * Occurs when the playback audio frame is received.
   * @param buffer The audio frame payload.
   * @param samplesPerChannel The samples per channel.
   * @param channels The number of audio channels. If the channel uses stereo, the data is
   *     interleaved.
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerSec The number of samples per channel per second in the audio frame.
   * @param codecType The codec type.
   */
  @CalledByNative
  public abstract void onPlaybackAudioEncodedFrame(
      ByteBuffer buffer, int samplesPerChannel, int channels, int samplesPerSec, int codecType);
  /**
   * Occurs when the mixed playback audio frame is received.
   * @param buffer The audio frame payload.
   * @param samplesPerChannel The samples per channel.
   * @param channels The number of audio channels. If the channel uses stereo, the data is
   *     interleaved.
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerSec The number of samples per channel per second in the audio frame.
   * @param codecType The codec type.
   */
  @CalledByNative
  public abstract void onMixedAudioEncodedFrame(
      ByteBuffer buffer, int samplesPerChannel, int channels, int samplesPerSec, int codecType);
}