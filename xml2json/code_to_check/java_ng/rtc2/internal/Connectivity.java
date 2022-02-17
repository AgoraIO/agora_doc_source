package io.agora.rtc2.internal;

import android.content.Context;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.telephony.TelephonyManager;
import java.lang.reflect.Method;
import java.util.ArrayList;

/**
 * <p>permission related: android.permission.ACCESS_NETWORK_STATE
 */
class Connectivity {
  private static final String TAG = "Connectivity";

  public static final int Network_UNKNOWN = -1;
  public static final int Network_DISCONNECTED = 0;
  public static final int Network_LAN = 1;
  public static final int Network_WIFI = 2;
  public static final int Network_2G = 3;
  public static final int Network_3G = 4;
  public static final int Network_4G = 5;
  public static final int Network_SubType_WIFI_2P4G = 100;
  public static final int Network_SubType_WIFI_5G = 101;

  /**
   * Get the network info
   *
   * @param context
   * @return
   */
  public static NetworkInfo getNetworkInfo(Context context) {
    if (context == null) {
      return null;
    }
    if (!CommonUtility.checkAccessNetworkState(context)) {
      return null;
    }
    ConnectivityManager cm =
            (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
    // @RequiresPermission(android.Manifest.permission.ACCESS_NETWORK_STATE)
    return cm.getActiveNetworkInfo();
  }

  /**
   * Check if there is any connectivity
   *
   * @param context
   * @return
   */
  public static boolean isConnected(Context context) {
    NetworkInfo info = Connectivity.getNetworkInfo(context);
    return (info != null && info.isConnected());
  }

  /**
   * convert NetworkType to agora define
   */
  public static int getNetworkType(NetworkInfo info) {
    if (info == null)
      return Network_UNKNOWN;
    if (!info.isConnected())
      return Network_DISCONNECTED;
    int type = info.getType();
    if (type == ConnectivityManager.TYPE_WIFI)
      return Network_WIFI;
    else if (type != ConnectivityManager.TYPE_MOBILE)
      return Network_UNKNOWN;

    switch (info.getSubtype()) {
      case TelephonyManager.NETWORK_TYPE_1xRTT: // ~ 50-100 kbps
      case TelephonyManager.NETWORK_TYPE_CDMA: // ~ 14-64 kbps
      case TelephonyManager.NETWORK_TYPE_EDGE: // ~ 50-100 kbps
      case TelephonyManager.NETWORK_TYPE_IDEN: // ~ 25 kbps
      case TelephonyManager.NETWORK_TYPE_GPRS: // ~ 100 kbps
        return Network_2G;
      case TelephonyManager.NETWORK_TYPE_EVDO_0: // ~ 400-1000 kbps
      case TelephonyManager.NETWORK_TYPE_EVDO_A: // ~ 600-1400 kbps
      case TelephonyManager.NETWORK_TYPE_HSDPA: // ~ 2-14 Mbps
      case TelephonyManager.NETWORK_TYPE_HSPA: // ~ 700-1700 kbps
      case TelephonyManager.NETWORK_TYPE_HSUPA: // ~ 1-23 Mbps
      case TelephonyManager.NETWORK_TYPE_UMTS: // ~ 400-7000 kbps
      case TelephonyManager.NETWORK_TYPE_EHRPD: // ~ 1-2 Mbps
      case TelephonyManager.NETWORK_TYPE_EVDO_B: // ~ 5 Mbps
      case TelephonyManager.NETWORK_TYPE_HSPAP: // ~ 10-20 Mbps
        return Network_3G;
      case TelephonyManager.NETWORK_TYPE_LTE: // ~ 10+ Mbps
        return Network_4G;
      case TelephonyManager.NETWORK_TYPE_UNKNOWN:
      default:
        return Network_UNKNOWN;
    }
  }

  /**
   * Network type
   * @param context Android context
   */
  public static int getNetworkType(Context context) {
    NetworkInfo info = Connectivity.getNetworkInfo(context);
    return getNetworkType(info);
  }

  /**
   * Dns list
   */
  public static ArrayList<String> getDnsList() {
    Logging.d(TAG, "getDnsList()");
    try {
      // https://stackoverflow.com/a/11362271
      Class<?> SystemProperties = Class.forName("android.os.SystemProperties");
      Method method = SystemProperties.getMethod("get", new Class[] {String.class});
      ArrayList<String> servers = new ArrayList<String>();
      for (String name : new String[] {
               "net.dns1",
               "net.dns2",
               "net.dns3",
               "net.dns4",
           }) {
        String value = (String) method.invoke(null, name);
        if (value != null && !"".equals(value) && !servers.contains(value))
          servers.add(value);
      }
      return servers;
    } catch (Exception e) {
    }
    return null;
  }
}
