package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

/**
 * The definition of IMetadataObserver.
 *
 * @note Implement all the callbacks in this class in the critical thread. We recommend avoiding any
 * time-consuming operation in the critical thread.
 */
public interface IMetadataObserver {
  /**
   * (Not supported) The metadata type is unknown.
   */
  public final static int UNKNOWN_METADATA = -1;
  /**
   * The metadata type is video.
   */
  public final static int VIDEO_METADATA = 0;

  /**
   * Occurs when the SDK requests the maximum size of the metadata.
   *
   * The Metadata struct contains the following parameters:
   * - `uid`: ID of the user who sends the metadata.
   *  @note When sending the metadata, ignore this parameter.
   * When receiving the metadata, use this parameter to determine who sends the metadata.
   * - `size`: The metadata size.
   * - `buffer`: The metadata buffer.
   * - `timeStampMs`: The NTP timestamp (ms) that the metadata sends.
   *  @note If the metadata receiver is audience, this parameter does not work.
   * The SDK triggers this callback after you successfully call
   * the {@link RtcEngine#registerMediaMetadataObserver() registerMediaMetadataObserver} method. You
   * need to specify the maximum size of the metadata in the return value of this callback.
   *
   * @return The maximum size of the buffer of the metadata that you want to use. The highest value
   *     is 1024 bytes. Ensure that you set the return value.
   */
  @CalledByNative public abstract int getMaxMetadataSize();

  /**
   * Occurs when the SDK is ready to receive and send metadata.
   *
   * You need to specify the metadata in the return value of this callback.
   *
   * @note
   * Ensure that the size of the metadata does not exceed the value set in the {@link
   * io.agora.rtc2.IMetadataObserver#getMaxMetadataSize() getMaxMetadataSize} callback.
   *
   * @param timeStampMs The NTP timestamp (ms) that the metadata sends.
   * @param sourceType {@link Constants#VideoSourceType VideoSourceType}
   *
   * @return The metadata that you want to send in the format of byte[]. Ensure that you set the
   *     return value.
   */
  @CalledByNative public abstract byte[] onReadyToSendMetadata(long timeStampMs, int sourceType);

  /**
   * Occurs when the local user receives the metadata.
   *
   * @param buffer The metadata buffer.
   * @param uid The ID of the user who sent the metadata.
   * When sending the metadata, ignore this parameter. When receiving the metadata, use this
   * parameter to determine who sends the metadata.
   * @param timeStampMs The NTP timestamp (ms) that the metadata sends.
   * If the metadata receiver is audience, this parameter does not work.
   */
  @CalledByNative public abstract void onMetadataReceived(byte[] buffer, int uid, long timeStampMs);
}
