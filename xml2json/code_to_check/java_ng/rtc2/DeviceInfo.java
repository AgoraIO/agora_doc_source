package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

public class DeviceInfo {
  /**
   * Whether the device support low latency audio. Not support by default
   */
  public boolean isLowLatencyAudioSupported;

  @CalledByNative
  public DeviceInfo(boolean isLowLatencyAudioSupported) {
    this.isLowLatencyAudioSupported = isLowLatencyAudioSupported;
  }
}
