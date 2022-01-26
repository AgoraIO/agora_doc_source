package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

/** Direct Cdn Streaming Error Code. */
public enum DirectCdnStreamingError {
  /**
   * success.
   */
  OK(0),
  /**
   * error.
   */
  FAILED(1),
  /**
   * audio.
   */
  AUDIO_PUBLICATION(2),
  /**
   * video.
   */
  VIDEO_PUBLICATION(3),
  /**
   * net connect.
   */
  NET_CONNECT(4),
  /**
   * Generally, Already exist stream name.
   */
  BAD_NAME(5);

  private int value;
  private DirectCdnStreamingError(int v) {
    value = v;
  }

  public int getValue() {
    return this.value;
  }

  @CalledByNative
  public static DirectCdnStreamingError fromInt(int v) {
    for (DirectCdnStreamingError type : values()) {
      if (type.getValue() == v) {
        return type;
      }
    }
    return FAILED;
  }
}