package io.agora.rtc2.internal;
import android.content.Context;
import androidx.annotation.VisibleForTesting;
import io.agora.base.internal.ContextUtils;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class HuaweiHardwareEarMonitor implements IHardwareEarMonitor {
  private static final String TAG = HuaweiHardwareEarMonitor.class.getSimpleName();
  private AudioKitCallbackImpl mAudioKitCallbackImpl = new AudioKitCallbackImpl();
  private HardwareEarMonitorListener mListener;
  private Context mContext;
  private Object mHwAudioKit = null;
  private Object mHwAudioKaraokeFeatureKit = null;
  private Class<?> mHwAudioKaraokeFeatureKitClass;
  private Class<?> mHwAudioKitClass;
  private Class<?> mParamNameClass;
  private volatile boolean mInitialized = false;
  private volatile boolean mEarMonitorEnabled = false;

  public HuaweiHardwareEarMonitor(HardwareEarMonitorListener listener) {
    Logging.i(TAG, ">>ctor");
    this.mListener = listener;
    this.mContext = ContextUtils.getApplicationContext();
  }

  @VisibleForTesting
  void setHwAudioKaraokeFeatureKit(Object hwAudioKaraokeFeatureKit) {
    this.mHwAudioKaraokeFeatureKit = hwAudioKaraokeFeatureKit;
  }

  @VisibleForTesting
  InvocationHandler getInvocationHandler() {
    return this.mAudioKitCallbackImpl;
  }

  private class AudioKitCallbackImpl implements InvocationHandler {
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) {
      try {
        Logging.i(TAG, "invoke, method: " + method.getName());
        if ("onResult".equals(method.getName())) {
          int result = (int) args[0];
          switch (result) {
            case 0:
              Logging.i(TAG, "IAudioKitCallback: HwAudioKit init success");
              break;
            case 1000:
              mInitialized = true;
              if (mListener != null) {
                mListener.onInitSuccess();
              }
              Logging.i(TAG, "IAudioKitCallback: HwAudioKaraokeFeatureKit init success ");
              break;
            case 2:
              Logging.i(TAG, "IAudioKitCallback: audio kit not installed");
              break;
            default:
              Logging.e(TAG, "IAudioKitCallback: onResult error number " + result);
              break;
          }
        }
      } catch (Exception e) {
        Logging.e(TAG, "AudioKitCallbackImpl invoke failed ", e);
      }
      return proxy;
    }
  }

  @Override
  public void initialize() {
    Logging.i(TAG, ">>initialize");
    if (mContext == null) {
      Logging.e(TAG, "mContext is null!");
      return;
    }
    if (mInitialized) {
      Logging.w(TAG, "already initialized, ignore");
      return;
    }
    try {
      mHwAudioKaraokeFeatureKitClass =
          Class.forName("com.huawei.multimedia.audiokit.interfaces.HwAudioKaraokeFeatureKit");
      mHwAudioKitClass = Class.forName("com.huawei.multimedia.audiokit.interfaces.HwAudioKit");
      Class<?> iAudioKitCallbackClass =
          Class.forName("com.huawei.multimedia.audiokit.interfaces.IAudioKitCallback");
      Class<?> featureTypeClass =
          Class.forName("com.huawei.multimedia.audiokit.interfaces.HwAudioKit$FeatureType");
      mParamNameClass = Class.forName(
          "com.huawei.multimedia.audiokit.interfaces.HwAudioKaraokeFeatureKit$ParameName");

      Object audioKitCallback = Proxy.newProxyInstance(iAudioKitCallbackClass.getClassLoader(),
          new Class[] {iAudioKitCallbackClass}, mAudioKitCallbackImpl);
      Class<?>[] types = new Class[] {Context.class, iAudioKitCallbackClass};
      Constructor<?> hwAudioKitCon = mHwAudioKitClass.getConstructor(types);
      mHwAudioKit = hwAudioKitCon.newInstance(mContext, audioKitCallback);
      Method initializeMethod = mHwAudioKitClass.getDeclaredMethod("initialize");
      initializeMethod.invoke(mHwAudioKit);
      Method createFeatureMethod =
          mHwAudioKitClass.getDeclaredMethod("createFeature", featureTypeClass);
      mHwAudioKaraokeFeatureKit =
          createFeatureMethod.invoke(mHwAudioKit, featureTypeClass.getEnumConstants()[0]);
      Logging.i(TAG, "initialize success ");
    } catch (Exception e) {
      Logging.e(TAG, "initialize failed ");
    }
  }

  @Override
  public boolean isHardwareEarMonitorSupported() {
    Logging.i(TAG, ">>isHardwareEarMonitorSupported");
    if (!mInitialized) {
      return false;
    }
    try {
      Method isKaraokeFeatureSupportMethod =
          mHwAudioKaraokeFeatureKitClass.getDeclaredMethod("isKaraokeFeatureSupport");
      boolean isSupported =
          (boolean) isKaraokeFeatureSupportMethod.invoke(mHwAudioKaraokeFeatureKit);
      Logging.i(TAG, "isSupported " + isSupported);
      return isSupported;
    } catch (Exception e) {
      Logging.e(TAG, "isHardwareEarMonitorSupported false ", e);
      return false;
    }
  }

  @Override
  public int setHardwareEarMonitorVolume(int vol) {
    if (!mInitialized || !mEarMonitorEnabled) {
      return -7;
    }
    Logging.i(TAG, ">>setHardwareEarMonitorVolume " + vol);
    if (vol < 0) {
      vol = 0;
    } else if (vol > 100) {
      vol = 100;
    }
    try {
      Method setParameterMethod = mHwAudioKaraokeFeatureKitClass.getDeclaredMethod(
          "setParameter", mParamNameClass, int.class);
      int ret = (int) setParameterMethod.invoke(
          mHwAudioKaraokeFeatureKit, mParamNameClass.getEnumConstants()[1], vol);
      Logging.i(TAG, "setParameter ret " + ret);
      if (ret != 0) {
        return -1;
      }
    } catch (Exception e) {
      Logging.e(TAG, "setHardwareEarMonitorVolume failed ", e);
      return -1;
    }
    return 0;
  }

  @Override
  public int enableHardwareEarMonitor(boolean enable) {
    Logging.i(TAG, ">>enableHardwareEarMonitor " + enable);
    if (!mInitialized) {
      return -7;
    }
    if (!isHardwareEarMonitorSupported()) {
      Logging.e(TAG, "karaoke not supported");
      return -1;
    }
    try {
      Method enableKaraokeFeatureMethod =
          mHwAudioKaraokeFeatureKitClass.getDeclaredMethod("enableKaraokeFeature", boolean.class);
      int ret = (int) enableKaraokeFeatureMethod.invoke(mHwAudioKaraokeFeatureKit, enable);
      if (ret != 0) {
        Logging.e(TAG, "enableKaraokeFeature failed ret " + ret);
        return -1;
      }
      mEarMonitorEnabled = enable;
      if (mEarMonitorEnabled) {
        Method getKaraokeLatencyMethod =
            mHwAudioKaraokeFeatureKitClass.getDeclaredMethod("getKaraokeLatency");
        int latency = (int) getKaraokeLatencyMethod.invoke(mHwAudioKaraokeFeatureKit);
        Logging.i(TAG, "latency: " + latency);
      }
    } catch (Exception e) {
      Logging.e(TAG, "enableHardwareEarMonitor failed ", e);
      return -1;
    }
    return 0;
  }

  @Override
  public void destroy() {
    Logging.i(TAG, ">>destroy");
    mListener = null;
    if (!mInitialized) {
      return;
    }
    mInitialized = false;
    try {
      Method hwAudioKaraokeFeatureKitDestroyMethod =
          mHwAudioKaraokeFeatureKitClass.getDeclaredMethod("destroy");
      hwAudioKaraokeFeatureKitDestroyMethod.invoke(mHwAudioKaraokeFeatureKit);
      Method hwAudioKitDestroyMethod = mHwAudioKitClass.getDeclaredMethod("destroy");
      hwAudioKitDestroyMethod.invoke(mHwAudioKit);
      Logging.i(TAG, ">>destroy success");
    } catch (Exception e) {
      Logging.e(TAG, "destroy failed ", e);
    }
  }
}