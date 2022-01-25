package io.agora.rtc2;

import java.util.Locale;

import io.agora.base.internal.CalledByNative;

/** Direct Cdn Streaming State. */
public class DirectCdnStreamingStats {
  /**
   * Width of the video pushed by rtmp.
   */
  public int videoWidth;

  /**
   * Height of the video pushed by rtmp.
   */
  public int videoHeight;

  /**
   * The frame rate of the video pushed by rtmp.
   */
  public int fps;

  /**
   * Real-time bit rate of the video streamed by rtmp.
   */
  public int videoBitrate;

  /**
   * Real-time bit rate of the audio pushed by rtmp.
   */
  public int audioBitrate;

  public DirectCdnStreamingStats() {
    videoWidth = 0;
    videoHeight = 0;
    fps = 0;
    videoBitrate = 0;
    audioBitrate = 0;
  }

  @CalledByNative
  public DirectCdnStreamingStats(
      int videoWidth, int videoHeight, int fps, int videoBitrate, int audioBitrate) {
    this.videoWidth = videoWidth;
    this.videoHeight = videoHeight;
    this.fps = fps;
    this.videoBitrate = videoBitrate;
    this.audioBitrate = audioBitrate;
  }

  @Override
  public String toString() {
    return String.format(Locale.getDefault(),
        "videoWidth=%d videoHeight=%d fps=%d videoBitrate=%d audioBitrate=%d", videoWidth,
        videoHeight, fps, videoBitrate, audioBitrate);
  }
}
