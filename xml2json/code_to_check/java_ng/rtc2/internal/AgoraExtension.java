package io.agora.rtc2.internal;

import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.IMediaExtensionObserver;

public class AgoraExtension {
  private String vendor;
  private long nativeProvider;

  public AgoraExtension(String vendor, long nativeProvider) {
    this.vendor = vendor;
    this.nativeProvider = nativeProvider;
  }

  @CalledByNative
  public String getVendor() {
    return vendor;
  }

  @CalledByNative
  public long getNativeProvider() {
    return nativeProvider;
  }
}