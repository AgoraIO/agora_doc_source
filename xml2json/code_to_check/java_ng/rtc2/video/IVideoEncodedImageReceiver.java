package io.agora.rtc2.video;

import io.agora.base.internal.CalledByNative;
import java.nio.ByteBuffer;

/**
 * The IVideoEncodedImageReceiver interface.
 */
public interface IVideoEncodedImageReceiver {
  /**
   * Occurs each time the SDK receives an encoded video image.
   * @param buffer The encoded image.
   * @param info The encoded video image information: {@link io.agora.rtc2.video.EncodedVideoFrameInfo EncodedVideoFrameInfo}.
   *
   * @return Whether or not to ignore the current video frame if the pre-processing fails:
   * - true: Do not ignore.
   * - false: Ignore the current video frame, and do not send it back to the SDK.
   */
  @CalledByNative
  boolean OnEncodedVideoImageReceived(ByteBuffer buffer, EncodedVideoFrameInfo info);
}
