package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

/**
 * Created by chenjianming on 17/05/2021.
 */

public interface IDirectCdnStreamingEventHandler {
  /**
   * Event callback of Direct Cdn Streaming
   * @param state Current state
   * @param err Error Code
   * @param msg Message
   */
  @CalledByNative
  void onDirectCdnStreamingStateChanged(
      DirectCdnStreamingState state, DirectCdnStreamingError err, String msg);

  /**
   * Current status data of rtmp streaming.
   * @param stats status data
   */
  @CalledByNative void onDirectCdnStreamingStats(DirectCdnStreamingStats stats);
}