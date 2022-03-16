package io.agora.rtc2.internal;

import static io.agora.rtc2.internal.AudioRoutingController.EVT_PHONE_STATE_CHANGED;

import android.app.ActivityManager;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.hardware.SensorManager;
import android.media.AudioManager;
import android.net.ConnectivityManager;
import android.net.DhcpInfo;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.os.HandlerThread;
import android.telephony.CellSignalStrength;
import android.telephony.CellSignalStrengthCdma;
import android.telephony.CellSignalStrengthGsm;
import android.telephony.CellSignalStrengthLte;
import android.telephony.CellSignalStrengthWcdma;
import android.telephony.PhoneStateListener;
import android.telephony.SignalStrength;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;
import android.view.OrientationEventListener;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.annotation.VisibleForTesting;
import io.agora.base.internal.CalledByNative;
import io.agora.base.internal.ThreadUtils;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.WeakReference;
import java.lang.reflect.Method;
import java.net.Inet4Address;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.CountDownLatch;
/**
 * CommonUtility
 * Created by eaglewangy on 2018/4/16.
 *
 * <p>permission related: android.permission.ACCESS_NETWORK_STATE
 * android.permission.ACCESS_WIFI_STATE android.permission.WRITE_EXTERNAL_STORAGE
 */
@SuppressWarnings("WeakerAccess")
class CommonUtility {
  private static final String TAG = "CommonUtility";

  static final int UNKNOWN_BATTERY_PERCENTAGE = 255;
  private static final String PREFIX_URI = "content://";

  // Android Context.
  private final WeakReference<Context> mContext;
  // Native C++ pointer.
  private long mNativeHandle;
  private final ThreadUtils.ThreadChecker mThreadChecker;
  // Handler.
  private final Handler mHandler;
  // Battery percentage.
  private volatile int mBatteryPercentage = UNKNOWN_BATTERY_PERCENTAGE;
  // Flag, whether disposed.
  private boolean mDisposed = false;

  // Phone State Listener.
  private AgoraPhoneStateListener mPhoneStateListener = null;
  // BroadcastReceiver for Connection change.
  private ConnectionChangeBroadcastReceiver mConnectionBroadcastReceiver = null;
  // BroadcastReceiver for Battery change.
  private PowerChangeReceiver mPowerChangeReceiver = null;
  // BroadcastReceiver for Activity Lifecycle
  private ProcessLifecycleOwner mProcessLifecycleOwner = null;
  // for gravity orientation for segment
  private OrientationEventListener mOrientationListener = null;
  private int mLastOrientation = -1;

  // Visible for testing.
  private String mExtraConnectivityFilterActionForTesting;
  // Visible for testing.
  private Listener mListener;
  private static boolean ignoreMonitor = false;
  public static void setIgnoreMonitor(boolean ignore) {
    ignoreMonitor = ignore;
  }

  @CalledByNative
  public CommonUtility(Context context, long handle) {
    Logging.d(TAG, "constructor()");
    mContext = new WeakReference<Context>(context);
    mNativeHandle = handle;
    mThreadChecker = new ThreadUtils.ThreadChecker();

    HandlerThread handlerThread = new HandlerThread("UtilityThread");
    handlerThread.start();
    mHandler = new Handler(handlerThread.getLooper());
    mHandler.post(new Runnable() {
      @Override
      public void run() {
        startMonitor();
      }
    });
  }

  @CalledByNative
  public long getNativeHandle() {
    mThreadChecker.checkIsOnValidThread();
    return mNativeHandle;
  }

  @VisibleForTesting
  void setExtraConnectionActionForTesting(String action) {
    mExtraConnectivityFilterActionForTesting = action;
  }

  @VisibleForTesting
  void setListener(Listener listener) {
    mListener = listener;
  }

  @VisibleForTesting
  Handler getHandler() {
    return mHandler;
  }

  @VisibleForTesting
  ProcessLifecycleOwner getProcessLifecycleOwner() {
    return mProcessLifecycleOwner;
  }

  void startMonitor() {
    Logging.d(TAG, "startMonitor()");
    // check android context.
    if (ignoreMonitor) {
      Logging.e(TAG, "ignoreMonitor in simulator, just for ut");
      return;
    }
    Context context = mContext.get();
    if (context == null) {
      return;
    }

    // register PhoneState listener.
    try {
      mPhoneStateListener = new AgoraPhoneStateListener(CommonUtility.this, mHandler);
      TelephonyManager telephonyManager =
          (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
      telephonyManager.listen(mPhoneStateListener,
          PhoneStateListener.LISTEN_SIGNAL_STRENGTHS | PhoneStateListener.LISTEN_CALL_STATE);
    } catch (Exception e) {
      Logging.e(TAG, "Unable to create PhoneStateListener, ", e);
    }

    // register Connection broadcast receiver.
    try {
      mConnectionBroadcastReceiver = new ConnectionChangeBroadcastReceiver(CommonUtility.this);
      context.registerReceiver(
          mConnectionBroadcastReceiver, new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION));
      if (!TextUtils.isEmpty(mExtraConnectivityFilterActionForTesting)) {
        context.registerReceiver(mConnectionBroadcastReceiver,
            new IntentFilter(mExtraConnectivityFilterActionForTesting));
      }
    } catch (Exception e) {
      Logging.e(TAG, "Unable to create ConnectionChangeBroadcastReceiver, ", e);
    }

    // register Power change Receiver
    try {
      mPowerChangeReceiver = new PowerChangeReceiver(CommonUtility.this);
      IntentFilter iFilter = new IntentFilter();
      iFilter.addAction(Intent.ACTION_BATTERY_CHANGED);
      context.registerReceiver(mPowerChangeReceiver, iFilter);
    } catch (Exception e) {
      Logging.e(TAG, "Unable to create PowerChangeReceiver, ", e);
    }

    // register System volume change Receiver
    try {
      mProcessLifecycleOwner =
          new ProcessLifecycleOwner(isAppInForeground(context), CommonUtility.this);
      Application app = (Application) context.getApplicationContext();
      app.registerActivityLifecycleCallbacks(mProcessLifecycleOwner);
    } catch (Exception e) {
      Logging.e(TAG, "Unable to registerActivityLifecycleCallbacks, ", e);
    }
  }

  private void stopMonitor() {
    Logging.d(TAG, "stopMonitor()");
    // check android context.
    Context context = mContext.get();
    if (context == null) {
      return;
    }

    // unRegister PhoneState listener.
    try {
      if (mPhoneStateListener != null) {
        TelephonyManager telephonyManager =
            (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        telephonyManager.listen(mPhoneStateListener, PhoneStateListener.LISTEN_NONE);
        mPhoneStateListener = null;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    // unRegister Connection broadcast receiver.
    try {
      if (mConnectionBroadcastReceiver != null) {
        context.unregisterReceiver(mConnectionBroadcastReceiver);
        mConnectionBroadcastReceiver = null;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    // unRegister Power change Receiver
    try {
      if (mPowerChangeReceiver != null) {
        context.unregisterReceiver(mPowerChangeReceiver);
        mPowerChangeReceiver = null;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    try {
      if (mProcessLifecycleOwner != null) {
        Application app = (Application) context.getApplicationContext();
        app.unregisterActivityLifecycleCallbacks(mProcessLifecycleOwner);
        mProcessLifecycleOwner = null;
      }
    } catch (Exception e) {
      Logging.e(TAG, "unregister ProcessLifecycleOwner failed ", e);
    }
    closeGravityMonitor();
  }

  @CalledByNative
  public void dispose() {
    mThreadChecker.checkIsOnValidThread();
    if (mDisposed) {
      return;
    }
    HardwareEarMonitorController.destroy();
    mDisposed = true;
    mNativeHandle = 0;
    Logging.d(TAG, "dispose()");
    mHandler.post(new Runnable() {
      @Override
      public void run() {
        stopMonitor();
      }
    });

    final CountDownLatch waitingLatch = new CountDownLatch(1);
    mHandler.post(new Runnable() {
      @Override
      public void run() {
        waitingLatch.countDown();
        mHandler.getLooper().quit();
      }
    });
    try {
      waitingLatch.await();
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    if (mListener != null) {
      mListener.onDispose();
    }
  }

  @CalledByNative
  public int getNetworkType() {
    Context context = mContext.get();
    if (context == null) {
      return Connectivity.Network_UNKNOWN;
    }

    if (checkAccessNetworkState(context)) {
      return Connectivity.getNetworkType(context);
    } else {
      Logging.w(TAG, "fail to getNetworkType, permission ACCESS_NETWORK_STATE not granted");
      return Connectivity.Network_UNKNOWN;
    }
  }

  @CalledByNative
  public int getBatteryLifePercent() {
    Context context = mContext.get();
    if (context != null) {
      return mBatteryPercentage;
    } else {
      return UNKNOWN_BATTERY_PERCENTAGE;
    }
  }

  @CalledByNative
  public MediaNetworkInfo getNetworkInfo() {
    Context context = mContext.get();
    if (context != null) {
      return getNetworkInfo(context);
    } else {
      return null;
    }
  }

  @CalledByNative
  public String getAssetsCacheFile(Context context, String pathOrUri, String fileName) {
    Logging.i(TAG, "getAssetsCacheFile filePath: " + pathOrUri);
    boolean isUri = pathOrUri.startsWith(PREFIX_URI);
    File cacheFile = new File(context.getCacheDir(), fileName);
    try {
      if (cacheFile.exists()) {
        cacheFile.delete();
      }
    } catch (SecurityException e) {
      e.printStackTrace();
      return null;
    }

    try (InputStream inputStream = isUri
             ? new FileInputStream(context.getContentResolver()
                                       .openFileDescriptor(Uri.parse(pathOrUri), "r")
                                       .getFileDescriptor())
             : context.getAssets().open(pathOrUri);
         FileOutputStream outputStream = new FileOutputStream(cacheFile);) {
      byte[] buf = new byte[1024];
      int len;
      while ((len = inputStream.read(buf)) > 0) {
        outputStream.write(buf, 0, len);
      }
    } catch (IOException e) {
      e.printStackTrace();
      return null;
    }
    return cacheFile.getAbsolutePath();
  }

  // called from `onReceive`
  void onAudioRoutingPhoneChanged(final boolean enableAudio, final int event, final int arg) {
    if (mDisposed || mNativeHandle == 0) {
      return;
    }

    Logging.d(TAG,
        "onAudioRoutingPhoneChanged() enableAudio:" + enableAudio + ", event:" + event
            + ", arg: " + arg);

    nativeAudioRoutingPhoneChanged(enableAudio, event, arg);

    // For test.
    if (mListener != null) {
      mListener.onAudioRoutingPhoneChanged(enableAudio, event, arg);
    }
  }

  // called from `onReceive`
  void onNetworkChange() {
    if (mDisposed || mNativeHandle == 0) {
      return;
    }

    Logging.d(TAG, "onNetworkChange()");
    final MediaNetworkInfo info = getNetworkInfo(mContext.get());
    nativeNotifyNetworkChange(info);

    // For test.
    if (mListener != null) {
      mListener.onNetworkChange(info);
    }
  }

  // called from `onReceive`
  void onForegroundChanged(boolean foreground) {
    Log.d(TAG, "onForegroundChanged() " + foreground);

    if (mDisposed) {
      return;
    }

    // For test.
    if (mListener != null) {
      mListener.onForegroundChanged(foreground);
    }

    if (mNativeHandle != 0) {
      nativeNotifyForegroundChanged(foreground);
    }
  }

  // called from `onReceive`
  void onPowerChange(int batteryPercentage) {
    Logging.d(TAG, "onPowerChange() " + batteryPercentage);
    mBatteryPercentage = batteryPercentage;
  }

  // That's the way Facebook detects emulators in React-Native
  // https://stackoverflow.com/a/21505193
  @CalledByNative
  public static boolean isSimulator() {
    return Build.FINGERPRINT.startsWith("generic") || Build.FINGERPRINT.startsWith("unknown")
        || Build.MODEL.contains("google_sdk") || Build.MODEL.contains("Emulator")
        || Build.MODEL.contains("Android SDK built for x86")
        || Build.MANUFACTURER.contains("Genymotion")
        || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
        || "google_sdk".equals(Build.PRODUCT);
  }

  @CalledByNative
  public static int getAndroidVersion() {
    return Build.VERSION.SDK_INT;
  }

  @CalledByNative
  public static int isSpeakerphoneEnabled(Context context) {
    if (context == null) {
      Logging.w(TAG, "fail to isSpeakerphoneEnabled, context null");
      return -1;
    }

    AudioManager audioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
    return audioManager.isSpeakerphoneOn() ? 1 : 0;
  }

  @CalledByNative
  public static AndroidContextInfo getContextInfo(Context context) {
    if (context == null) {
      Logging.w(TAG, "fail to getContextInfo, context null");
      return null;
    }

    AndroidContextInfo info = new AndroidContextInfo();
    info.device = DeviceUtils.getDeviceId();
    info.configDir = getAppPrivateStorageDir(context);
    info.dataDir = context.getCacheDir().getAbsolutePath();
    info.pluginDir = context.getApplicationInfo().nativeLibraryDir;
    info.deviceInfo = DeviceUtils.getDeviceInfo();
    info.systemInfo = DeviceUtils.getSystemInfo();
    return info;
  }

  @CalledByNative
  public static String[] getLocalHostList() {
    try {
      List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
      List<String> ips = new ArrayList<String>();
      for (NetworkInterface intf : interfaces) {
        if (intf.getName().startsWith("usb"))
          continue;
        List<InetAddress> addrs = Collections.list(intf.getInetAddresses());
        for (InetAddress addr : addrs) {
          String ip = inetAddressToIpAddress(addr);
          if (!TextUtils.isEmpty(ip)) {
            ips.add(ip);
          }
        }
      }
      if (!ips.isEmpty()) {
        String[] addresses = new String[ips.size()];
        int i = 0;
        for (String ip : ips) {
          addresses[i] = ip;
          i++;
        }
        return addresses;
      }
    } catch (Exception ex) {
      Logging.w(TAG, "fail to getLocalHostList", ex);
    } // for now eat exceptions
    return null;
  }

  @CalledByNative
  public static String getLocalHost(boolean is_ipv4) {
    try {
      List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
      StringBuilder first_local_ip = new StringBuilder();
      String public_ip = null;
      for (NetworkInterface inter : interfaces) {
        if (inter.getName().startsWith("usb")) {
          continue;
        }
        List<InetAddress> addresses = Collections.list(inter.getInetAddresses());
        for (InetAddress addr : addresses) {
          public_ip = getIpAddressByType(addr, is_ipv4, first_local_ip);
          if (!TextUtils.isEmpty(public_ip)) {
            return public_ip;
          }
        }
      }
      if (first_local_ip.length() > 0) {
        return first_local_ip.toString();
      }
    } catch (Exception ex) {
      Logging.w(TAG, "fail to getLocalHost", ex);
    }
    return null;
  }

  public int checkOrientation(int orientation) {
    if (orientation == OrientationEventListener.ORIENTATION_UNKNOWN)
      return -1;
    if ((orientation > 340 || orientation < 20) && mLastOrientation != 270) {
      mLastOrientation = 270;
      nativeNotifyGravityOriChange(270);
    } else if ((orientation > 70 && orientation < 110) && mLastOrientation != 180) {
      mLastOrientation = 180;
      nativeNotifyGravityOriChange(180);
    } else if ((orientation > 160 && orientation < 200) && mLastOrientation != 90) {
      mLastOrientation = 90;
      nativeNotifyGravityOriChange(90);
    } else if ((orientation > 250 && orientation < 290) && mLastOrientation != 0) {
      mLastOrientation = 0;
      nativeNotifyGravityOriChange(0);
    }
    return mLastOrientation;
  }

  @CalledByNative
  public int setupGravityMonitor() {
    Context context = mContext.get();
    if (context == null) {
      return -1;
    }
    try {
      if (mOrientationListener == null) {
        mOrientationListener =
            new OrientationEventListener(context, SensorManager.SENSOR_DELAY_UI) {
              public void onOrientationChanged(int orientation) {
                if (orientation == ORIENTATION_UNKNOWN) {
                  return;
                }
                checkOrientation(orientation);
              }
            };
      }
      mOrientationListener.enable();
      Logging.i(TAG, "[setupGravityMonitor] done!");
    } catch (Exception e) {
      Logging.e(TAG, "Unable to create OrientationEventListener, ", e);
    }
    return -1;
  }

  @CalledByNative
  public int closeGravityMonitor() {
    Context context = mContext.get();
    if (context == null) {
      return -1;
    }
    try {
      if (mOrientationListener != null) {
        mOrientationListener.disable();
        mOrientationListener = null;
        Logging.i(TAG, "[closeGravityMonitor] done!");
        return 0;
      } else {
        Logging.e(TAG, "[closeGravityMonitor] mOrientationListener is null!");
      }
    } catch (Exception e) {
      Logging.e(TAG, "Unable to close OrientationEventListener, ", e);
    }
    return -1;
  }

  private static String getIpAddressByType(
      InetAddress addr, boolean is_ipv4, StringBuilder first_local_ip) {
    if (is_ipv4 && (addr instanceof Inet4Address)) {
      if (first_local_ip.length() == 0) {
        first_local_ip.append(addr.getHostAddress());
      }
      return getPublicIpAddress(addr);
    }

    if (!is_ipv4 && (addr instanceof Inet6Address)) {
      if (first_local_ip.length() == 0) {
        first_local_ip.append(addr.getHostAddress());
      }
      return getPublicIpAddress(addr);
    }

    return null;
  }

  private static String getPublicIpAddress(InetAddress address) {
    if (!address.isLoopbackAddress() && !address.isLinkLocalAddress()
        && !address.isAnyLocalAddress()) {
      return address.getHostAddress();
    }
    return null;
  }

  static boolean checkAccessNetworkState(Context context) {
    if (context == null) {
      return false;
    }
    int res = context.checkCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE");
    return res == PackageManager.PERMISSION_GRANTED;
  }

  static boolean checkAccessWifiState(Context context) {
    if (context == null) {
      return false;
    }
    int res = context.checkCallingOrSelfPermission("android.permission.ACCESS_WIFI_STATE");
    return res == PackageManager.PERMISSION_GRANTED;
  }

  private MediaNetworkInfo getNetworkInfo(Context context) {
    MediaNetworkInfo ni = new MediaNetworkInfo();
    // check permission
    if (!checkAccessNetworkState(context)) {
      Logging.w(TAG, "fail to getNetworkInfo, permission ACCESS_NETWORK_STATE not granted");
      return ni;
    }

    // local Ip4.
    String localIp4 = getLocalHost(true);
    if (!TextUtils.isEmpty(localIp4)) {
      ni.localIp4 = localIp4;
    }

    // local Ip6.
    String localIp6 = getLocalHost(false);
    if (!TextUtils.isEmpty(localIp6)) {
      ni.localIp6 = localIp6;
    }

    // network type.
    NetworkInfo networkInfo = Connectivity.getNetworkInfo(context);
    ni.networkType = Connectivity.getNetworkType(networkInfo);
    if (networkInfo != null) {
      ni.networkSubtype = networkInfo.getSubtype();
    }

    // dns list.
    ni.dnsList = Connectivity.getDnsList();

    // other info. ssid, bssid, signalLevel, asu etc.
    if (ni.networkType == Connectivity.Network_WIFI) {
      fillWifiInfoIfPossible(context, ni);
      Logging.d(TAG, "networkType from WIFI, rssi = " + ni.rssi + " level = " + ni.signalLevel);
    } else {
      if (mPhoneStateListener != null) {
        // try to get from `mPhoneStateListener`
        mPhoneStateListener.fillCellInfoIfPossible(context, ni);
        Logging.d(TAG,
            "networkType from Phone State Listener， rssi = " + ni.rssi
                + " level = " + ni.signalLevel);
      }
    }
    return ni;
  }

  private static String inetAddressToIpAddress(InetAddress address) {
    if (!address.isLoopbackAddress()) {
      if (address instanceof Inet4Address) {
        Inet4Address address4 = (Inet4Address) address;
        return address4.getHostAddress();
      } else if (address instanceof Inet6Address) {
        // TODO(HaiyangWu): support IP6
        // Inet6Address address6 = (Inet6Address)address;
      }
    }
    return null;
  }

  private static InetAddress intToInetAddress(int hostAddress) {
    byte[] addressBytes = {(byte) (0xff & hostAddress), (byte) (0xff & (hostAddress >> 8)),
        (byte) (0xff & (hostAddress >> 16)), (byte) (0xff & (hostAddress >> 24))};

    try {
      return InetAddress.getByAddress(addressBytes);
    } catch (UnknownHostException e) {
      return null;
    }
  }

  private static void fillWifiInfoIfPossible(Context context, MediaNetworkInfo ni) {
    if (!checkAccessWifiState(context)) {
      Logging.w(TAG, "fail to fillWifiInfo, permission ACCESS_WIFI_STATE not granted");
      return;
    }

    WifiManager wifiManager =
        (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
    DhcpInfo dhcp = wifiManager.getDhcpInfo();
    if (dhcp != null) {
      InetAddress addr = intToInetAddress(dhcp.gateway);
      if (addr != null) {
        ni.gatewayIp4 = addr.getHostAddress();
      }
    }
    WifiInfo wifiInfo = wifiManager.getConnectionInfo();
    if (wifiInfo != null) {
      ni.rssi = wifiInfo.getRssi();
      ni.signalLevel = WifiManager.calculateSignalLevel(ni.rssi, 5);
      ni.linkspeed = wifiInfo.getLinkSpeed();

      if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        int freq = wifiInfo.getFrequency(); // in MHz
        ni.frequency = freq;
        if (freq >= 5000)
          ni.networkSubtype = Connectivity.Network_SubType_WIFI_5G;
        else if (freq >= 2400)
          ni.networkSubtype = Connectivity.Network_SubType_WIFI_2P4G;
      }
    } else {
      Logging.w(TAG, "fail to fillWifiInfo, wifiInfo null");
    }
  }

  static class AgoraPhoneStateListener extends PhoneStateListener {
    private final WeakReference<CommonUtility> mCommonUtilityRef;
    private final WeakReference<Handler> mHandlerRef;
    private SignalStrength mSignalStrength;
    private volatile boolean phoneStatusNeedResume = false;

    AgoraPhoneStateListener(CommonUtility commonUtility, Handler handler) {
      mCommonUtilityRef = new WeakReference<CommonUtility>(commonUtility);
      mHandlerRef = new WeakReference<Handler>(handler);
    }

    @RequiresApi(Build.VERSION_CODES.O)
    void fillCellInfoHighLevel(@NonNull MediaNetworkInfo cellInfo) {
      if (mSignalStrength != null) {
        try {
          Method method = mSignalStrength.getClass().getDeclaredMethod("getCellSignalStrengths");
          if (method != null) {
            List<CellSignalStrength> signalList =
                (List<CellSignalStrength>) method.invoke(mSignalStrength);
            fillCellInfoByNetworkType(signalList, cellInfo);
          }
        } catch (Exception e) {
          Logging.e(TAG, "fillCellInfoHighLevel getDeclareMethod:getCellSignalStrengths failed! ");
          fillCellInfoLowLevel(cellInfo); // Fix MS-46105
        }
      }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    void fillCellInfoByNetworkType(
        @NonNull List<CellSignalStrength> cellInfoList, @NonNull MediaNetworkInfo cellInfo) {
      for (CellSignalStrength cellSignal : cellInfoList) {
        if (cellSignal instanceof CellSignalStrengthLte) {
          CellSignalStrengthLte signalStrength = (CellSignalStrengthLte) cellSignal;
          cellInfo.rssi = signalStrength.getDbm();
          cellInfo.signalLevel = signalStrength.getLevel();
          cellInfo.snr = signalStrength.getRssnr();
          break;
        } else if (cellSignal instanceof CellSignalStrengthGsm
            || cellSignal instanceof CellSignalStrengthCdma
            || cellSignal instanceof CellSignalStrengthWcdma) {
          cellInfo.rssi = cellSignal.getDbm();
          cellInfo.signalLevel = cellSignal.getLevel();
          break;
        }
      }
    }

    void fillCellInfoLowLevel(@NonNull MediaNetworkInfo cellInfo) {
      cellInfo.rssi = getRssi();
      cellInfo.signalLevel = getLevel();
    }
    public void fillCellInfoIfPossible(Context context, MediaNetworkInfo cellInfo) {
      if (Build.VERSION.SDK_INT <= 28) {
        fillCellInfoLowLevel(cellInfo);
      } else {
        fillCellInfoHighLevel(cellInfo);
      }
    }

    public int getRssi() {
      return invokeMethod("getDbm");
    }

    public int getLevel() {
      // [0,4]
      return invokeMethod("getLevel");
    }

    @SuppressWarnings("unused")
    public int getAsuLevel() {
      // [0,99), 99=unknown
      return invokeMethod("getAsuLevel");
    }

    private int invokeMethod(String methodName) {
      try {
        if (mSignalStrength != null) {
          Method method = mSignalStrength.getClass().getDeclaredMethod(methodName);
          return (Integer) method.invoke(mSignalStrength);
        }
      } catch (Exception e) {
        // use reflection, do not log, just let it go.
      }
      return 0;
    }

    @Override
    public void onSignalStrengthsChanged(SignalStrength signalStrength) {
      super.onSignalStrengthsChanged(signalStrength);
      mSignalStrength = signalStrength;
    }

    @Override
    public void onCallStateChanged(int state, String incomingNumber) {
      super.onCallStateChanged(state, incomingNumber);
      final CommonUtility utility = mCommonUtilityRef.get();
      final Handler handler = mHandlerRef.get();
      if (utility == null || handler == null) {
        return;
      }

      if (state == TelephonyManager.CALL_STATE_IDLE) {
        if (phoneStatusNeedResume) {
          phoneStatusNeedResume = false;
          Logging.i(TAG, "system phone call end delay 1000ms");
          handler.postDelayed(new Runnable() {
            @Override
            public void run() {
              utility.onAudioRoutingPhoneChanged(true, EVT_PHONE_STATE_CHANGED, 0);
            }
          }, 1000);
        }
      } else if (state == TelephonyManager.CALL_STATE_RINGING) {
        Logging.i(TAG, "system phone call ring");
        phoneStatusNeedResume = true;
        utility.onAudioRoutingPhoneChanged(false, EVT_PHONE_STATE_CHANGED, 1);
      } else if (state == TelephonyManager.CALL_STATE_OFFHOOK) {
        Logging.i(TAG, "system phone call start");
        phoneStatusNeedResume = true;
        utility.onAudioRoutingPhoneChanged(false, EVT_PHONE_STATE_CHANGED, 2);
      }
    }
  }

  private static String getAppPrivateStorageDir(Context context) {
    if (Environment.MEDIA_MOUNTED.equals(Environment.getExternalStorageState())) {
      File file = context.getExternalFilesDir(null);
      if (file != null) {
        return file.getAbsolutePath();
      }
    }
    return context.getFilesDir().getAbsolutePath();
  }

  public static class MediaNetworkInfo {
    String localIp4 = "";
    String gatewayIp4 = "";
    String localIp6 = "";
    String gatewayIp6 = "";
    int networkType = Connectivity.Network_UNKNOWN;
    int networkSubtype = Connectivity.Network_UNKNOWN;
    int signalLevel = 0;
    int rssi = 0;
    int snr = -100;
    ArrayList<String> dnsList = null;
    int linkspeed = 0;
    int frequency = 0;
    @CalledByNative("MediaNetworkInfo")
    public String getLocalIp4() {
      return localIp4;
    }

    @CalledByNative("MediaNetworkInfo")
    public String getGatewayIp4() {
      return gatewayIp4;
    }

    @CalledByNative("MediaNetworkInfo")
    public String getLocalIp6() {
      return localIp6;
    }

    @CalledByNative("MediaNetworkInfo")
    public String getGatewayIp6() {
      return gatewayIp6;
    }

    @CalledByNative("MediaNetworkInfo")
    public int getNetworkType() {
      return networkType;
    }

    @CalledByNative("MediaNetworkInfo")
    public int getNetworkSubtype() {
      return networkSubtype;
    }

    @CalledByNative("MediaNetworkInfo")
    public int getSignalLevel() {
      return signalLevel;
    }

    @CalledByNative("MediaNetworkInfo")
    public int getRssi() {
      return rssi;
    }

    @CalledByNative("MediaNetworkInfo")
    public int getAsu() {
      return snr;
    }

    @CalledByNative("MediaNetworkInfo")
    public ArrayList<String> getDnsList() {
      return dnsList;
    }

    @CalledByNative("MediaNetworkInfo")
    public int getLinkspeed() {
      return linkspeed;
    }

    @CalledByNative("MediaNetworkInfo")
    public int getFrequency() {
      return frequency;
    }
  }

  public static class AndroidContextInfo {
    public String device;
    public String configDir;
    public String dataDir;
    public String pluginDir;

    public String deviceInfo;
    public String systemInfo;

    @CalledByNative("AndroidContextInfo")
    public String getDevice() {
      return device;
    }

    @CalledByNative("AndroidContextInfo")
    public String getConfigDir() {
      return configDir;
    }

    @CalledByNative("AndroidContextInfo")
    public String getDataDir() {
      return dataDir;
    }

    @CalledByNative("AndroidContextInfo")
    public String getPluginDir() {
      return pluginDir;
    }

    @CalledByNative("AndroidContextInfo")
    public String getDeviceInfo() {
      return deviceInfo;
    }

    @CalledByNative("AndroidContextInfo")
    public String getSystemInfo() {
      return systemInfo;
    }
  }

  private static boolean failedToGetRunningTasks = false;

  @CalledByNative
  public static boolean isAppInForeground(Context context) {
    if (context == null) {
      Logging.w(TAG, "isAppInForeground context is null");
      return false;
    }
    Context appContext = context.getApplicationContext();
    ActivityManager activityManager =
        (ActivityManager) appContext.getSystemService(Context.ACTIVITY_SERVICE);
    String packageName = appContext.getPackageName();

    if (!failedToGetRunningTasks) {
      try {
        return isAppInForegroundWithRunningTasks(activityManager, packageName);
      } catch (Exception e) {
        Logging.w(TAG, "Failed to get running tasks", e);
        failedToGetRunningTasks = true;
      }
    }
    return isAppInForegroundWithRunningProcesses(activityManager, packageName);
  }

  static boolean isAppInForegroundWithRunningTasks(
      ActivityManager activityManager, String packageName) {
    // java.lang.SecurityException: Permission Denial: getTasks() from pid=22083, uid=10178
    // requires android.permission.GET_TASKS
    List<ActivityManager.RunningTaskInfo> runningTaskInfos = activityManager.getRunningTasks(1);
    if (runningTaskInfos == null || runningTaskInfos.size() == 0) {
      Logging.w(TAG, "isAppInForeground getRunningTasks is null");
      return false;
    }
    ActivityManager.RunningTaskInfo taskInfo = runningTaskInfos.get(0);
    if (taskInfo != null && taskInfo.topActivity.getPackageName().equals(packageName)) {
      return true;
    }
    return false;
  }

  static boolean isAppInForegroundWithRunningProcesses(
      ActivityManager activityManager, String packageName) {
    List<ActivityManager.RunningAppProcessInfo> appProcesses =
        activityManager.getRunningAppProcesses();
    if (appProcesses == null) {
      Logging.w(TAG, "isAppInForeground appProcesses is null");
      return false;
    }
    for (ActivityManager.RunningAppProcessInfo appProcess : appProcesses) {
      // The name of the process that this object is associated with.
      if (appProcess.processName.equals(packageName)
          && appProcess.importance == ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND) {
        return true;
      }
    }
    return false;
  }

  @CalledByNative
  public static int getCpuTemperature() {
    return DeviceUtils.getCpuTemperature();
  }

  // Visible for testing.
  interface Listener {
    void onAudioRoutingPhoneChanged(boolean enableAudio, int event, int arg);

    void onNetworkChange(MediaNetworkInfo networkInfo);

    void onDispose();

    void onForegroundChanged(boolean isForeground);
  }

  private native void nativeAudioRoutingPhoneChanged(boolean enableAudio, int event, int arg);

  private native void nativeNotifyNetworkChange(MediaNetworkInfo networkInfo);

  private native void nativeNotifyForegroundChanged(boolean isForeground);

  private native void nativeNotifyGravityOriChange(int mOrientation);
}
