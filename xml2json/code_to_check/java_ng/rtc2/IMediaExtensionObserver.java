package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

public interface IMediaExtensionObserver {
  @CalledByNative void onEvent(String provider, String extension, String key, String value);
  @CalledByNative void onStarted(String provider, String extension);
  @CalledByNative void onStopped(String provider, String extension);
  @CalledByNative void onError(String provider, String extension, int errCode, String errMsg);
}
