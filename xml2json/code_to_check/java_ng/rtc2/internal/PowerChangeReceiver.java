package io.agora.rtc2.internal;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.BatteryManager;
import java.lang.ref.WeakReference;

public class PowerChangeReceiver extends BroadcastReceiver {
  private WeakReference<CommonUtility> mCommonUtility;
  public PowerChangeReceiver(CommonUtility cu) {
    mCommonUtility = new WeakReference<CommonUtility>(cu);
  }

  @Override
  public void onReceive(Context context, Intent intent) {
    CommonUtility cu = mCommonUtility.get();
    if (cu == null) {
      Logging.w("rtc engine is not ready");
      return;
    }
    if (intent != null) {
      int level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
      int scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
      if (scale != 0) {
        float batteryPct = level / (float) scale;
        cu.onPowerChange((int) (batteryPct * 100));
      }
    }
  }
}
