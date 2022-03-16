package io.agora.rtc2.internal;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import java.lang.ref.WeakReference;

public class ConnectionChangeBroadcastReceiver extends BroadcastReceiver {
  private WeakReference<CommonUtility> mCommonUtility;

  public ConnectionChangeBroadcastReceiver(CommonUtility cu) {
    mCommonUtility = new WeakReference<CommonUtility>(cu);
  }

  @Override
  public void onReceive(Context context, Intent intent) {
    CommonUtility cu = mCommonUtility.get();
    if (cu == null) {
      Logging.w("rtc engine is not ready");
      return;
    }
    cu.onNetworkChange();
  }
}
