package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

/**
 * The channel media options.
 */
public class EncodedVideoTrackOptions {
  /**
   * Whether to enable CC mode.
   * - TCC_ENABLED = 0: (Default) enable cc.
   * - TCC_DISABLED = 1: disable cc.
   */
  public Integer ccMode;
  /**
   * The codec type used for the encoded images.
   * - VIDEO_CODEC_VP8 = 1: VP8.
   * - VIDEO_CODEC_H264 = 2: (Default) H.264.
   * - VIDEO_CODEC_H265 = 3: H.265.
   * - VIDEO_CODEC_VP9 = 5: VP9.
   * - VIDEO_CODEC_GENERIC = 6: GENERIC.
   * - VIDEO_CODEC_GENERIC_H264 = 7: GENERIC_H264.
   * - VIDEO_CODEC_GENERIC_JPEG = 20: GENERIC_JPEG.
   */
  public Integer codecType;
  /**
   * Target bitrate (Kbps) for sending encoded video frame.
   */
  public Integer targetBitrate;

  @CalledByNative
  public Integer getCcMode() {
    return ccMode;
  }

  @CalledByNative
  public Integer getCodecType() {
    return codecType;
  }

  @CalledByNative
  public Integer getTargetBitrate() {
    return targetBitrate;
  }
}
