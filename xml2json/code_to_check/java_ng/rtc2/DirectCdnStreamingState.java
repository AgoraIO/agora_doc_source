package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

/** Direct Cdn Streaming State. */
public enum DirectCdnStreamingState {
  /**
   * idle.
   */
  IDLE(0),
  /**
   * running.
   */
  RUNNING(1),
  /**
   * stopped.
   */
  STOPPED(2),
  /**
   * error.
   */
  FAILED(3),
  /**
   * Recovering.
   */
  RECOVERING(4);

  private int value;
  private DirectCdnStreamingState(int v) {
    value = v;
  }

  public int getValue() {
    return this.value;
  }

  @CalledByNative
  public static DirectCdnStreamingState fromInt(int v) {
    for (DirectCdnStreamingState type : values()) {
      if (type.getValue() == v) {
        return type;
      }
    }
    return FAILED;
  }
}