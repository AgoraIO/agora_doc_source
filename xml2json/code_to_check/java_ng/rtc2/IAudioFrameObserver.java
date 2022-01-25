package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;
import java.nio.ByteBuffer;

/**
 * The IAudioFrameObserver interface.
 */
public interface IAudioFrameObserver {
  /**
   * Occurs when the recorded audio frame is received.
   * @param channelId The channel name
   * @param type The audio frame type.
   * @param samplesPerChannel The samples per channel.
   * @param bytesPerSample The number of bytes per audio sample. For example, each PCM
   * audio sample usually takes up 16 bits (2 bytes).
   * @param channels The number of audio channels. If the channel uses stereo, the data is
   *     interleaved.
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerSec The number of samples per channel per second in the audio frame.
   * @param buffer The audio frame payload.
   * @param renderTimeMs The render timestamp in ms.
   * @param avsync_type The audio/video sync type.
   *
   * @return
   * - true: The recorded audio frame is valid and is encoded and sent.
   * - false: The recorded audio frame is invalid and is not encoded or sent.
   */
  @CalledByNative
  public abstract boolean onRecordAudioFrame(String channelId, int type, int samplesPerChannel,
      int bytesPerSample, int channels, int samplesPerSec, ByteBuffer buffer, long renderTimeMs,
      int avsync_type);
  /**
   * Occurs when the playback audio frame is received.
   * @param channelId The channel name
   * @param type The audio frame type.
   * @param samplesPerChannel The samples per channel.
   * @param bytesPerSample The number of bytes per audio sample. For example, each PCM
   * audio sample usually takes up 16 bits (2 bytes).
   * @param channels The number of audio channels. If the channel uses stereo, the data is
   *     interleaved.
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerSec The number of samples per channel per second in the audio frame.
   * @param buffer The audio frame payload.
   * @param renderTimeMs The render timestamp in ms.
   * @param avsync_type The audio/video sync type.
   *
   * @return
   * - true: The playback audio frame is valid and is encoded and sent.
   * - false: The playback audio frame is invalid and is not encoded or sent.
   */
  @CalledByNative
  public abstract boolean onPlaybackAudioFrame(String channelId, int type, int samplesPerChannel,
      int bytesPerSample, int channels, int samplesPerSec, ByteBuffer buffer, long renderTimeMs,
      int avsync_type);

  /**
   * Occurs when the mixed playback audio frame is received.
   * @param channelId The channel name
   * @param type The audio frame type.
   * @param samplesPerChannel The samples per channel.
   * @param bytesPerSample The number of bytes per audio sample. For example, each PCM
   * audio sample usually takes up 16 bits (2 bytes).
   * @param channels The number of audio channels. If the channel uses stereo, the data is
   *     interleaved.
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerSec The number of samples per channel per second in the audio frame.
   * @param buffer The audio frame payload.
   * @param renderTimeMs The render timestamp in ms.
   * @param avsync_type The audio/video sync type.
   *
   * @return
   * - true: The mixed audio data is valid and is encoded and sent.
   * - false: The mixed audio data is invalid and is not encoded or sent.
   */
  @CalledByNative
  public abstract boolean onMixedAudioFrame(String channelId, int type, int samplesPerChannel,
      int bytesPerSample, int channels, int samplesPerSec, ByteBuffer buffer, long renderTimeMs,
      int avsync_type);

  /**
   * Occurs when the playback audio frame before mixing is received.
   * @param channelId The channel name
   * @param userId The user Id.
   * @param type The audio frame type.
   * @param samplesPerChannel The samples per channel.
   * @param bytesPerSample The number of bytes per audio sample. For example, each PCM
   * audio sample usually takes up 16 bits (2 bytes).
   * @param channels The number of audio channels. If the channel uses stereo, the data is
   *     interleaved.
   * - 1: Mono.
   * - 2: Stereo.
   * @param samplesPerSec The number of samples per channel per second in the audio frame.
   * @param buffer The audio frame payload.
   * @param renderTimeMs The render timestamp in ms.
   * @param avsync_type The audio/video sync type.
   *
   * @return
   * - true: The playback audio frame before mixing is valid and is encoded and sent.
   * - false: The playback audio frame before mixing is invalid and is not encoded or sent.
   */
  @CalledByNative
  public abstract boolean onPlaybackAudioFrameBeforeMixing(String channelId, int userId, int type,
      int samplesPerChannel, int bytesPerSample, int channels, int samplesPerSec, ByteBuffer buffer,
      long renderTimeMs, int avsync_type);
}
