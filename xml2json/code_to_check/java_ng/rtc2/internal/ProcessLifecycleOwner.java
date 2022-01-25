package io.agora.rtc2.internal;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import java.lang.ref.WeakReference;

class ProcessLifecycleOwner implements Application.ActivityLifecycleCallbacks {
  private static final String TAG = "ProcessLifecycleOwner";
  private static final long TIMEOUT_MS = 1000; // mls

  private final WeakReference<CommonUtility> mCommonUtility;
  private final Handler handler;
  private boolean isForeground;

  private final Runnable mDelayedPauseRunnable = new Runnable() {
    @Override
    public void run() {
      setForeground(false);
    }
  };

  private final Runnable mDelayedResumeRunnable = new Runnable() {
    @Override
    public void run() {
      setForeground(true);
    }
  };

  ProcessLifecycleOwner(boolean foreground, CommonUtility cu) {
    isForeground = foreground;
    handler = new Handler(Looper.getMainLooper());
    mCommonUtility = new WeakReference<>(cu);
    Logging.d(TAG, "ProcessLifecycleOwner, isForeground : " + isForeground);
  }

  @Override
  public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
    // Do nothing because do not care.
  }

  @Override
  public void onActivityStarted(Activity activity) {
    // Do nothing because do not care.
  }

  @Override
  public void onActivityResumed(Activity activity) {
    Logging.d(TAG, "onActivityResumed()");
    handler.removeCallbacks(mDelayedPauseRunnable);
    handler.postDelayed(mDelayedResumeRunnable, TIMEOUT_MS);
  }

  @Override
  public void onActivityPaused(Activity activity) {
    Logging.d(TAG, "onActivityPaused()");
    handler.removeCallbacks(mDelayedResumeRunnable);
    handler.postDelayed(mDelayedPauseRunnable, TIMEOUT_MS);
  }

  @Override
  public void onActivityStopped(Activity activity) {
    // Do nothing because do not care.
  }

  @Override
  public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
    // Do nothing because do not care.
  }

  @Override
  public void onActivityDestroyed(Activity activity) {
    // Do nothing because do not care.
  }

  private void setForeground(boolean para) {
    if (isForeground == para) {
      return;
    }
    isForeground = para;
    CommonUtility cu = mCommonUtility.get();
    if (cu == null) {
      return;
    }
    cu.onForegroundChanged(this.isForeground);
  }
}
