package io.agora.rtc2.internal;

public interface IHardwareEarMonitor {
  void initialize();
  boolean isHardwareEarMonitorSupported();
  int enableHardwareEarMonitor(boolean enable);
  int setHardwareEarMonitorVolume(int vol);
  void destroy();
}