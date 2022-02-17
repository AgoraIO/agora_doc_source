package io.agora.rtc2.video;

import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.Constants;
/**
 * The EncodedVideoFrameInfo class, which defines the format of the
 * encoded video frame.
 */
public class EncodedVideoFrameInfo {
  /**
   * The codec type.
   * - 1: `VIDEO_CODEC_VP8`.
   * - 2: (Default) `VIDEO_CODEC_H264`.
   * - 5: `VIDEO_CODEC_VP9`.
   */
  public int codecType;
  /**
   * The width of this frame.
   */
  public int width;
  /**
   * The height of this frame.
   */
  public int height;
  /**
   * The number of frames per second of this frame.
   */
  public int framesPerSecond;
  /**
   * The frame type:
   * - 0: `VIDEO_FRAME_TYPE_BLANK_FRAME`.
   * - 3: `VIDEO_FRAME_TYPE_KEY_FRAME`.
   * - 4: `VIDEO_FRAME_TYPE_DELTA_FRAME`.
   * - 5: `VIDEO_FRAME_TYPE_B_FRAME`.
   * - 6: `VIDEO_FRAME_TYPE_UNKNOWN`.
   */
  public int frameType;
  /**
   * The rotation information (clockwise) of this frame.
   * Set it as 0, 90, 180 or 270.
   */
  public int rotation;

  // trackId can be reserved for multiple video tracks, we need to create different ssrc
  // and additional payload for later implementation.
  /**
   * The track ID. This member is used for scenarios with multiple video
   * tracks.
   */
  public int trackId;
  /**
   * The timestamp to render this frame.
   *
   * Attention that this parameter is just used in receiver side not sender side,
   * thus it belongs to output.
   */
  public long renderTimeMs;
  /**
   * The timestamp to send this frame internally.
   *
   * Attention that this parameter is just used in receiver side not sender side,
   * thus it belongs to output.
   */
  public long internalSendTs;
  /**
   * ID of the user who sends this video.
   */
  public int uid;

  public EncodedVideoFrameInfo() {
    codecType = Constants.VIDEO_CODEC_H264;
    width = 0;
    height = 0;
    framesPerSecond = 0;
    frameType = Constants.VIDEO_FRAME_TYPE_BLANK_FRAME;
    rotation = Constants.VIDEO_ORIENTATION_0;
    trackId = 0;
    renderTimeMs = 0;
    internalSendTs = 0;
    uid = 0;
  }

  @CalledByNative
  public EncodedVideoFrameInfo(int codecType, int width, int height, int framesPerSecond,
      int frameType, int rotation, int trackId, long renderTimeMs, long internalSendTs, int uid) {
    this.codecType = codecType;
    this.width = width;
    this.height = height;
    this.framesPerSecond = framesPerSecond;
    this.frameType = frameType;
    this.rotation = rotation;
    this.trackId = trackId;
    this.renderTimeMs = renderTimeMs;
    this.internalSendTs = internalSendTs;
    this.uid = uid;
  }

  @CalledByNative
  public int getCodecType() {
    return codecType;
  }

  @CalledByNative
  public int getWidth() {
    return width;
  }
  @CalledByNative
  public int getHeight() {
    return height;
  }
  @CalledByNative
  public int getFramesPerSecond() {
    return framesPerSecond;
  }
  @CalledByNative
  public int getFrameType() {
    return frameType;
  }
  @CalledByNative
  public int getRotation() {
    return rotation;
  }
  @CalledByNative
  public int getTrackId() {
    return trackId;
  }
  @CalledByNative
  public long getRenderTimeMs() {
    return renderTimeMs;
  }
  @CalledByNative
  public long getInternalSendTs() {
    return internalSendTs;
  }
  @CalledByNative
  public int getUid() {
    return uid;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("codecType=").append(codecType);
    sb.append(" width=").append(width);
    sb.append(" height=").append(height);
    sb.append(" framesPerSecond=").append(framesPerSecond);
    sb.append(" frameType=").append(frameType);
    sb.append(" rotation=").append(rotation);
    sb.append(" trackId=").append(trackId);
    sb.append(" renderTimeMs=").append(renderTimeMs);
    sb.append(" internalSendTs=").append(internalSendTs);
    sb.append(" uid=").append(uid);
    return sb.toString();
  }
}
