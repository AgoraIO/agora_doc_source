package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;
/**
 * The ClientRoleOptions class.
 * @since v3.4.200.
 */
public class ClientRoleOptions {
  /**
   * The audience role level in broadcaster mode.
   * #AUDIENCE_LATENCY_LEVEL_LOW_LATENCY 1: Low latency. A low latency audience's jitter buffer
   * is 1.2 second. #AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY 2: Ultra low latency. An ultra low
   * latency audience's jitter buffer is 0.5 second.
   */
  public int audienceLatencyLevel;

  @CalledByNative
  public int getAudienceLatencyLevel() {
    return audienceLatencyLevel;
  }
}
