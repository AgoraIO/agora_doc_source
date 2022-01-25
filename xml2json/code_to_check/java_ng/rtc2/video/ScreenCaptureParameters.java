package io.agora.rtc2.video;

import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.video.VideoEncoderConfiguration.VideoDimensions;

/**
 * The ScreenCaptureParameters class, which defines the parameters
 * for screen sharing.
 */
public class ScreenCaptureParameters {
  /**
   * The video dimensions.
   */
  private VideoDimensions videoDimensions;
  /**
   * The frame rate of the screen capture video.
   */
  private int frameRate;
  /**
   * The bitrate (Kbps) of the screen capture video.
   */
  private int bitrate;

  public ScreenCaptureParameters() {
    videoDimensions = new VideoDimensions(1080, 1920);
    frameRate = 5;
    bitrate = 4098;
  }

  public ScreenCaptureParameters setVideoDimensions(VideoDimensions videoDimensions) {
    this.videoDimensions = videoDimensions;
    return this;
  }

  public ScreenCaptureParameters setFrameRate(int frameRate) {
    this.frameRate = frameRate;
    return this;
  }

  public ScreenCaptureParameters setBitrate(int bitrate) {
    this.bitrate = bitrate;
    return this;
  }

  public VideoDimensions getVideoDimensions() {
    return videoDimensions;
  }

  @CalledByNative
  int getWidth() {
    return videoDimensions != null ? videoDimensions.width : 0;
  }

  @CalledByNative
  int getHeight() {
    return videoDimensions != null ? videoDimensions.height : 0;
  }

  @CalledByNative
  public int getFrameRate() {
    return frameRate;
  }

  @CalledByNative
  public int getBitrate() {
    return bitrate;
  }
}
