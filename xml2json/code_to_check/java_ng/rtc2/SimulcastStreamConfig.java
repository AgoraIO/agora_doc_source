package io.agora.rtc2;

import io.agora.rtc2.video.VideoEncoderConfiguration;

public class SimulcastStreamConfig {
  public VideoEncoderConfiguration.VideoDimensions dimensions;
  /**
   * The video bitrate (Kbps).
   */
  public int bitrate;
  /**
   * The video framerate.
   */
  public int framerate;

  public SimulcastStreamConfig() {
    // Currently, use default simulcast config.
    // set all field as -1 for high level api, low level sdk will determine the simulcast
    // config according to major stream
    this.dimensions = new VideoEncoderConfiguration.VideoDimensions(-1, -1);
    this.bitrate = -1;
    this.framerate = 5;
  }

  public SimulcastStreamConfig(
      VideoEncoderConfiguration.VideoDimensions dimensions, int bitrate, int framerate) {
    this.dimensions = dimensions;
    this.bitrate = bitrate;
    this.framerate = framerate;
  }
}
