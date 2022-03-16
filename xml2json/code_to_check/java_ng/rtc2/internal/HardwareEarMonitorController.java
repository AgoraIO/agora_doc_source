package io.agora.rtc2.internal;

import android.content.Context;
import android.content.IntentFilter;
import android.os.Build;
import androidx.annotation.VisibleForTesting;
import io.agora.base.internal.CalledByNative;
import io.agora.base.internal.ContextUtils;

public class HardwareEarMonitorController implements HardwareEarMonitorListener {
  private static final String TAG = HardwareEarMonitorController.class.getSimpleName();
  private final static String MANUFACTURER_HUAWEI = "huawei";
  private static HardwareEarMonitorController mInstance = null;
  private IHardwareEarMonitor mHardwareEarMonitor = null;
  /**
   * BroadcastReceiver for System Volume change.
   */
  protected VolumeChangeReceiver mVolumeChangeReceiver = null;

  @CalledByNative
  public static synchronized HardwareEarMonitorController getInstance() {
    if (mInstance == null) {
      mInstance = new HardwareEarMonitorController();
    }
    return mInstance;
  }

  private HardwareEarMonitorController() {
    String build = Build.MANUFACTURER;
    if (build.trim().toLowerCase().contains(MANUFACTURER_HUAWEI)) {
      mHardwareEarMonitor = new HuaweiHardwareEarMonitor(this);
    }
  }

  @CalledByNative
  public synchronized void initialize() {
    if (mHardwareEarMonitor != null) {
      mHardwareEarMonitor.initialize();
    }
  }

  @VisibleForTesting
  void setHardwareEarMonitor(IHardwareEarMonitor mHardwareEarMonitor) {
    this.mHardwareEarMonitor = mHardwareEarMonitor;
  }

  @CalledByNative
  public synchronized boolean isHardwareEarMonitorSupported() {
    return mHardwareEarMonitor != null && mHardwareEarMonitor.isHardwareEarMonitorSupported();
  }

  @CalledByNative
  public synchronized int enableHardwareEarMonitor(boolean enable) {
    if (mHardwareEarMonitor != null) {
      return mHardwareEarMonitor.enableHardwareEarMonitor(enable);
    }
    return -7;
  }

  @CalledByNative
  public synchronized int setHardwareEarMonitorVolume(int vol) {
    if (mHardwareEarMonitor != null) {
      return mHardwareEarMonitor.setHardwareEarMonitorVolume(vol);
    }
    return -7;
  }

  private synchronized void destroyImpl() {
    // unRegister System volume change Receiver
    Context context = ContextUtils.getApplicationContext();
    try {
      if (mVolumeChangeReceiver != null && context != null) {
        context.unregisterReceiver(mVolumeChangeReceiver);
        mVolumeChangeReceiver = null;
      }
    } catch (Exception e) {
      Logging.e(TAG, "unregister VolumeChangeReceiver failed ", e);
    }

    if (mHardwareEarMonitor != null) {
      mHardwareEarMonitor.destroy();
      mHardwareEarMonitor = null;
    }
  }

  @CalledByNative
  public static synchronized void destroy() {
    if (mInstance != null) {
      mInstance.destroyImpl();
    }
    mInstance = null;
  }

  @Override
  public synchronized void onInitSuccess() {
    // register System volume change Receiver
    Context context = ContextUtils.getApplicationContext();
    if (context == null) {
      return;
    }
    try {
      mVolumeChangeReceiver = new VolumeChangeReceiver();
      IntentFilter iFilter = new IntentFilter();
      iFilter.addAction(VolumeChangeReceiver.ACTION_VOLUME_CHANGED);
      context.registerReceiver(mVolumeChangeReceiver, iFilter);
    } catch (Exception e) {
      Logging.e(TAG, "Unable to create VolumeChangeReceiver, ", e);
    }
  }
}