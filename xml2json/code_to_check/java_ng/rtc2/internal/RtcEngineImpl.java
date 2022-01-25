package io.agora.rtc2.internal;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Rect;
import android.media.AudioFormat;
import android.media.AudioManager;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;
import android.util.Pair;
import android.view.SurfaceView;
import android.view.TextureView;
import android.view.View;
import io.agora.base.VideoFrame;
import io.agora.base.internal.BuildConfig;
import io.agora.base.internal.CalledByNative;
import io.agora.mediaplayer.IMediaPlayer;
import io.agora.mediaplayer.IMediaPlayerAudioFrameObserver;
import io.agora.mediaplayer.IMediaPlayerCustomDataProvider;
import io.agora.mediaplayer.IMediaPlayerObserver;
import io.agora.mediaplayer.IMediaPlayerVideoFrameObserver;
import io.agora.mediaplayer.data.MediaStreamInfo;
import io.agora.rtc2.ChannelMediaOptions;
import io.agora.rtc2.ClientRoleOptions;
import io.agora.rtc2.Constants;
import io.agora.rtc2.DataStreamConfig;
import io.agora.rtc2.DeviceInfo;
import io.agora.rtc2.DirectCdnStreamingMediaOptions;
import io.agora.rtc2.EncodedVideoTrackOptions;
import io.agora.rtc2.IAgoraEventHandler;
import io.agora.rtc2.IAudioEffectManager;
import io.agora.rtc2.IAudioEncodedFrameObserver;
import io.agora.rtc2.IAudioFrameObserver;
import io.agora.rtc2.IDirectCdnStreamingEventHandler;
import io.agora.rtc2.IMetadataObserver;
import io.agora.rtc2.IRtcEngineEventHandler;
import io.agora.rtc2.LeaveChannelOptions;
import io.agora.rtc2.PublisherConfiguration;
import io.agora.rtc2.RtcConnection;
import io.agora.rtc2.RtcEngineConfig;
import io.agora.rtc2.RtcEngineInternal;
import io.agora.rtc2.SimulcastStreamConfig;
import io.agora.rtc2.UserInfo;
import io.agora.rtc2.audio.AgoraRhythmPlayerConfig;
import io.agora.rtc2.audio.IAudioSpectrumObserver;
import io.agora.rtc2.live.LiveInjectStreamConfig;
import io.agora.rtc2.live.LiveTranscoding;
import io.agora.rtc2.video.AgoraImage;
import io.agora.rtc2.video.AgoraVideoFrame;
import io.agora.rtc2.video.BeautyOptions;
import io.agora.rtc2.video.CameraCapturerConfiguration;
import io.agora.rtc2.video.ChannelMediaInfo;
import io.agora.rtc2.video.ChannelMediaRelayConfiguration;
import io.agora.rtc2.video.ContentInspectConfig;
import io.agora.rtc2.video.EncodedVideoFrameInfo;
import io.agora.rtc2.video.IVideoEncodedImageReceiver;
import io.agora.rtc2.video.IVideoFrameObserver;
import io.agora.rtc2.video.ScreenCaptureParameters;
import io.agora.rtc2.video.VideoCanvas;
import io.agora.rtc2.video.VideoCompositingLayout;
import io.agora.rtc2.video.VideoEncoderConfiguration;
import io.agora.rtc2.video.VirtualBackgroundSource;
import io.agora.rtc2.video.WatermarkOptions;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.ref.WeakReference;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.microedition.khronos.egl.EGLContext;

public class RtcEngineImpl extends RtcEngineInternal implements IAudioEffectManager {
  private static final String TAG = "RtcEngine";
  private static final int DEFAULT_EXTERNAL_AUDIO_SOURCE_COUNT = 1;

  private int mExSourceAudioSampleRate = 0;
  private int mExSourceAudioChannels = 0;
  private int mExSinkAudioSampleRate = 0;
  private int mExSinkAudioChannels = 0;
  private long mNativeHandle = 0;

  private PublisherConfiguration mConfiguration;

  private static boolean sLibLoaded = false;
  private final ConcurrentHashMap<IAgoraEventHandler, Integer> mRtcHandlers =
      new ConcurrentHashMap<>();
  private final ConcurrentHashMap<Pair<String, Object>, IAgoraEventHandler> mRtcExHandlers =
      new ConcurrentHashMap<>();
  private IRtcEngineEventHandler.RtcStats mRtcStats = null;
  private static ConcurrentHashMap<String, ExtensionLoadState> mLoadedExtensions =
      new ConcurrentHashMap<>();

  private enum ExtensionLoadState { LOADED, LOAD_FAIL }

  private WifiManager.WifiLock mWifiLock = null;

  private final WeakReference<Context> mContext;

  private static class InitResult {
    private int retVal;
    private long nativeHandle;

    @CalledByNative("InitResult")
    public InitResult(int retVal, long nativeHandle) {
      this.retVal = retVal;
      this.nativeHandle = nativeHandle;
    }
  }

  static String nativeLibraryName = "agora-rtc-sdk-jni";

  public static synchronized boolean initializeNativeLibs() {
    return initializeNativeLibs(null);
  }

  public static synchronized boolean initializeNativeLibs(String libPath) {
    if (!sLibLoaded) {
      for (int i = 0; i < BuildConfig.so_list.size(); i++) {
        sLibLoaded = safeLoadLibrary(libPath, BuildConfig.so_list.get(i));
        if (!sLibLoaded)
          return sLibLoaded;
      }
      sLibLoaded = safeLoadLibrary(libPath, nativeLibraryName);
    }
    return sLibLoaded;
  }

  public static synchronized boolean loadExtension(String name) {
    if (mLoadedExtensions.get(name) == ExtensionLoadState.LOADED)
      return true;

    boolean loaded = safeLoadLibrary(null, name);
    mLoadedExtensions.put(name, loaded ? ExtensionLoadState.LOADED : ExtensionLoadState.LOAD_FAIL);
    return loaded;
  }

  @SuppressLint("UnsafeDynamicallyLoadedCode")
  private static boolean safeLoadLibrary(String path, String name) {
    boolean loaded = true;
    try {
      if (TextUtils.isEmpty(path)) {
        System.loadLibrary(name);
      } else {
        System.load(getNativeLibFullPath(path, name));
      }
    } catch (SecurityException e) {
      Log.e(TAG, Logging.getStackTraceString(e));
      loaded = false;
    } catch (UnsatisfiedLinkError e) {
      Log.e(TAG, Logging.getStackTraceString(e));
      loaded = false;
    } catch (NullPointerException e) {
      Log.e(TAG, Logging.getStackTraceString(e));
      loaded = false;
    } catch (Exception e) {
      Log.e(TAG, Logging.getStackTraceString(e));
      loaded = false;
    }
    return loaded;
  }

  static String nativeLibraryPrefix = "lib";
  static String nativeLibrarySurffix = ".so";

  static String getNativeLibFullPath(String path, String name) {
    String fullName = nativeLibraryPrefix + name + nativeLibrarySurffix;
    if (TextUtils.isEmpty(path)) {
      return fullName;
    } else {
      return path.endsWith(File.separator) ? (path + fullName) : (path + File.separator + fullName);
    }
  }

  public RtcEngineImpl(RtcEngineConfig config) throws Exception {
    mContext = new WeakReference<Context>(config.mContext);
    addHandler(config.mEventHandler);
    InitResult initResult = (InitResult) nativeObjectInit(config);
    if (initResult.retVal != Constants.ERR_OK) {
      String errMsg = String.format(Locale.getDefault(),
          "cannot initialize Agora Rtc Engine, error=%d", Math.abs(initResult.retVal));
      throw new IllegalArgumentException(errMsg);
    }
    mNativeHandle = initResult.nativeHandle;
    setUidCompatibleMode(true);
    for (String providerName : config.mExtensionList) {
      Logging.i(TAG, "load extension: " + providerName);
      safeLoadLibrary(null, providerName);
    }
  }

  public Context getContext() {
    return mContext.get();
  }

  public synchronized void doDestroy() {
    setExternalAudioSource(false, 0, 0, 0, false, false);
    setExternalVideoSource(false, false, Constants.ExternalVideoSourceType.VIDEO_FRAME);

    if (mNativeHandle != 0) {
      nativeDestroy(mNativeHandle);
      mNativeHandle = 0;
      sLibLoaded = false;
    }
  }

  public synchronized void reinitialize(RtcEngineConfig config) {
    addHandler(config.mEventHandler);
  }

  public synchronized void addHandler(IAgoraEventHandler handler) {
    mRtcHandlers.put(handler, 0);
  }

  public synchronized void removeHandler(IAgoraEventHandler handler) {
    mRtcHandlers.remove(handler);
  }

  private static String toStringUserId(int uid) {
    return RtcEngineMessage.toStringUserId(uid);
  }

  private boolean validateVideoRendererView(View view) {
    return view == null || view instanceof SurfaceView || view instanceof TextureView;
  }

  @Override
  public synchronized int setupRemoteVideo(VideoCanvas remote) {
    return setupRemoteVideoEx(remote, null);
  }

  @Override
  public synchronized int setupRemoteVideoEx(VideoCanvas remote, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (remote == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    if (!validateVideoRendererView(remote.view)) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    int uid = remote.uid;
    if (uid != 0) {
      return nativeSetupRemoteVideo(mNativeHandle, remote.view, remote.renderMode,
          remote.mirrorMode, uid, getChannelId(connection), getUserId(connection));
    } else {
      return -Constants.ERR_FAILED;
    }
  }

  @Override
  public synchronized int setupLocalVideo(VideoCanvas local) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (local != null) {
      if (!validateVideoRendererView(local.view)) {
        return -Constants.ERR_INVALID_ARGUMENT;
      } else {
        return nativeSetupLocalVideo(mNativeHandle, local.view, local.renderMode, local.mirrorMode,
            local.sourceType, local.sourceId);
      }
    } else {
      return nativeSetupLocalVideo(mNativeHandle, null, VideoCanvas.RENDER_MODE_HIDDEN,
          Constants.VIDEO_MIRROR_MODE_AUTO, Constants.VIDEO_SOURCE_CAMERA_PRIMARY, 0);
    }
  }

  @Deprecated
  public synchronized int setLocalRenderMode(int renderMode) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    setParameterObject(
        "che.video.render_mode", formatString("{\"uid\":0,\"mode\":%d}", renderMode));
    return nativeSetLocalRenderMode(mNativeHandle, renderMode, Constants.VIDEO_MIRROR_MODE_AUTO);
  }

  @Override
  public synchronized int setLocalRenderMode(int renderMode, int mirrorMode) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    setParameterObject(
        "che.video.render_mode", formatString("{\"uid\":0,\"mode\":%d}", renderMode));
    return nativeSetLocalRenderMode(mNativeHandle, renderMode, mirrorMode);
  }

  @Deprecated
  @Override
  public synchronized int setRemoteRenderMode(int userId, int renderMode) {
    return setRemoteRenderModeEx(userId, renderMode, Constants.VIDEO_MIRROR_MODE_DISABLED, null);
  }

  @Override
  public synchronized int setRemoteRenderMode(int userId, int renderMode, int mirrorMode) {
    return setRemoteRenderModeEx(userId, renderMode, mirrorMode, null);
  }

  @Override
  public synchronized int setRemoteRenderModeEx(
      int userId, int renderMode, int mirrorMode, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetRemoteRenderMode(mNativeHandle, userId, renderMode, mirrorMode,
        getChannelId(connection), getUserId(connection));
  }

  @Deprecated
  @Override
  public synchronized int setLocalVideoMirrorMode(int mode) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    String modeStr;
    switch (mode) {
      case Constants.VIDEO_MIRROR_MODE_AUTO:
        modeStr = "default";
        break;
      case Constants.VIDEO_MIRROR_MODE_ENABLED:
        modeStr = "forceMirror";
        break;
      case Constants.VIDEO_MIRROR_MODE_DISABLED:
        modeStr = "disableMirror";
        break;
      default:
        return -Constants.ERR_INVALID_ARGUMENT;
    }
    setParameter("che.video.localViewMirrorSetting", modeStr);
    return nativeSetLocalVideoMirrorMode(mNativeHandle, mode);
  }

  @Override
  public synchronized int addVideoWatermark(AgoraImage watermark) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (watermark == null || TextUtils.isEmpty(watermark.url)) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    WatermarkOptions options = new WatermarkOptions();
    String watermarkUrl = watermark.url;

    options.visibleInPreview = false;
    options.positionInLandscapeMode =
        new WatermarkOptions.Rectangle(watermark.x, watermark.y, watermark.width, watermark.height);
    options.positionInPortraitMode = options.positionInLandscapeMode;

    return addVideoWatermark(watermarkUrl, options);
  }

  @Override
  public synchronized int switchChannel(String token, String channelName) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (channelName == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeswitchChannel(mNativeHandle, token, channelName);
  }

  @Override
  public synchronized int addVideoWatermark(String watermarkUrl, WatermarkOptions options) {
    return addVideoWatermarkEx(watermarkUrl, options, null);
  }

  @Override
  public synchronized int addVideoWatermarkEx(
      String watermarkUrl, WatermarkOptions options, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (watermarkUrl == null || TextUtils.isEmpty(watermarkUrl) || options == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }

    int[] lrect = new int[4];
    int[] prect = new int[4];
    if (options.positionInLandscapeMode != null) {
      lrect[0] = options.positionInLandscapeMode.x;
      lrect[1] = options.positionInLandscapeMode.y;
      lrect[2] = options.positionInLandscapeMode.width;
      lrect[3] = options.positionInLandscapeMode.height;
    }
    if (options.positionInPortraitMode != null) {
      prect[0] = options.positionInPortraitMode.x;
      prect[1] = options.positionInPortraitMode.y;
      prect[2] = options.positionInPortraitMode.width;
      prect[3] = options.positionInPortraitMode.height;
    }
    return nativeAddVideoWatermark(mNativeHandle, watermarkUrl, options.visibleInPreview, lrect,
        prect, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int clearVideoWatermarkEx(RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeClearVideoWatermarkEx(
        mNativeHandle, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int clearVideoWatermarks() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeClearVideoWatermarks(mNativeHandle);
  }

  @Override
  public synchronized int enableDualStreamMode(boolean enabled) {
    return enableDualStreamMode(Constants.VideoSourceType.VIDEO_SOURCE_CAMERA_PRIMARY, enabled,
        new SimulcastStreamConfig());
  }

  @Override
  public synchronized int enableDualStreamMode(
      Constants.VideoSourceType sourceType, boolean enabled) {
    return enableDualStreamMode(sourceType, enabled, new SimulcastStreamConfig());
  }

  @Override
  public synchronized int enableDualStreamMode(
      Constants.VideoSourceType sourceType, boolean enabled, SimulcastStreamConfig streamConfig) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (streamConfig == null) {
      streamConfig = new SimulcastStreamConfig();
    }
    setParameters(
        String.format("{\"rtc.dual_stream_mode\":%b,\"che.video.enableLowBitRateStream\":%d}",
            enabled, enabled ? 1 : 0));
    return nativeEnableDualStreamMode(mNativeHandle, Constants.VideoSourceType.getValue(sourceType),
        enabled, streamConfig.dimensions.width, streamConfig.dimensions.height,
        streamConfig.bitrate, streamConfig.framerate);
  }

  @Deprecated
  @Override
  public synchronized void monitorHeadsetEvent(boolean monitor) {
    Logging.i(TAG, "enter monitorHeadsetEvent:" + monitor);
  }

  @TargetApi(Build.VERSION_CODES.HONEYCOMB)
  @Deprecated
  @Override
  public synchronized void monitorBluetoothHeadsetEvent(boolean monitor) {
    Logging.i(TAG, "enter monitorBluetoothHeadsetEvent:" + monitor);
  }

  @Override
  public synchronized boolean enableHighPerfWifiMode(boolean enable) {
    Context context = mContext.get();
    if (context == null)
      return false;
    if (enable) {
      int wakeLock = context.checkCallingOrSelfPermission("android.permission.WAKE_LOCK");
      if (wakeLock != PackageManager.PERMISSION_GRANTED) {
        Logging.w(TAG, "Failed to enableHighPerfWifiMode, permission WAKE_LOCK not granted ");
        mWifiLock = null;
        return false;
      }
      if (mWifiLock == null) {
        WifiManager wifiManager =
            (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        mWifiLock =
            wifiManager.createWifiLock(WifiManager.WIFI_MODE_FULL_HIGH_PERF, "agora.voip.lock");
      }
    } else {
      mWifiLock = null;
    }
    return true;
  }

  private IRtcEngineEventHandler.RtcStats getRtcStats() {
    if (mRtcStats == null) {
      mRtcStats = new IRtcEngineEventHandler.RtcStats();
    }
    return mRtcStats;
  }

  private void updateRtcStats(RtcEngineMessage.PMediaResRtcStats stats) {
    IRtcEngineEventHandler.RtcStats rtcStats = getRtcStats();
    rtcStats.totalDuration = stats.totalDuration;
    rtcStats.txBytes = stats.totalTxBytes;
    rtcStats.rxBytes = stats.totalRxBytes;
    rtcStats.txAudioBytes = stats.txAudioBytes;
    rtcStats.rxAudioBytes = stats.rxAudioBytes;
    rtcStats.txVideoBytes = stats.txVideoBytes;
    rtcStats.rxVideoBytes = stats.rxVideoBytes;
    rtcStats.txKBitRate = stats.txKBitRate;
    rtcStats.rxKBitRate = stats.rxKBitRate;
    rtcStats.txAudioKBitRate = stats.txAudioKBitRate;
    rtcStats.rxAudioKBitRate = stats.rxAudioKBitRate;
    rtcStats.txVideoKBitRate = stats.txVideoKBitRate;
    rtcStats.rxVideoKBitRate = stats.rxVideoKBitRate;
    rtcStats.lastmileDelay = stats.lastmileDelay;
    rtcStats.users = stats.users;
    rtcStats.cpuTotalUsage = stats.cpuTotalUsage / 100.0;
    rtcStats.gatewayRtt = stats.gatewayRtt;
    rtcStats.cpuAppUsage = stats.cpuAppUsage / 100.0;
    rtcStats.connectTimeMs = stats.connectTimeMs;
    rtcStats.txPacketLossRate = stats.txPacketLossRate;
    rtcStats.rxPacketLossRate = stats.rxPacketLossRate;
    rtcStats.memoryAppUsageRatio = stats.memoryAppUsageRatio;
    rtcStats.memoryTotalUsageRatio = stats.memoryTotalUsageRatio;
    rtcStats.memoryAppUsageInKbytes = stats.memoryAppUsageInKbytes;

    // String msg = formatString("mem %dkB, audio routing %d volume %d",
    // rtcStats.memAppUsage, rtcStats.audioRouting,
    // rtcStats.audioVolume);logInfo(msg);
  }

  private void doMonitorSystemEvent(Context context) {
    if (Connectivity.getNetworkType(context) != Connectivity.Network_WIFI) {
      return;
    }
    if (mWifiLock != null) {
      mWifiLock.acquire();
      Logging.i(TAG, "hp connection mode detected");
    }
  }

  private void doStopMonitorSystemEvent() {
    if (mWifiLock != null && mWifiLock.isHeld()) {
      mWifiLock.release();
      Logging.i(TAG, "hp connection mode ended");
    }
  }

  @Override
  public synchronized int joinChannel(
      String key, String channelName, String optionalInfo, int optionalUid) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    Context context = mContext.get();
    if (context == null) {
      return -Constants.ERR_NOT_INITIALIZED;
    }

    doMonitorSystemEvent(context);

    if (mConfiguration != null && mConfiguration.validate()) {
      if (optionalInfo != null) {
        Logging.w(TAG, "override optionalInfo by publisherConfiguration");
      }
      optionalInfo = mConfiguration.toJsonString();
    }
    return nativeJoinChannel(mNativeHandle, key, channelName, optionalInfo, optionalUid);
  }

  @Override
  public synchronized int joinChannel(
      String token, String channelId, int uid, ChannelMediaOptions options) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeJoinChannel2(mNativeHandle, token, channelId, uid, options);
  }

  @Override
  public synchronized int joinChannelEx(String token, RtcConnection connection,
      ChannelMediaOptions options, IRtcEngineEventHandler eventHandler) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    String channelId = getChannelId(connection);
    int uid = getUserId(connection);
    int result = nativeJoinChannelEx(mNativeHandle, token, channelId, uid, options);
    if (result == Constants.ERR_OK) {
      mRtcExHandlers.put(Pair.create(channelId, uid), eventHandler);
    }
    return result;
  }

  @Override
  public synchronized int updateChannelMediaOptions(ChannelMediaOptions options) {
    return updateChannelMediaOptionsEx(options, null);
  }

  @Override
  public synchronized int updateChannelMediaOptionsEx(
      ChannelMediaOptions options, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeUpdateChannelMediaOptions(
        mNativeHandle, options, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int leaveChannel() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    doStopMonitorSystemEvent();
    return nativeLeaveChannel(mNativeHandle);
  }

  @Override
  public synchronized int leaveChannel(LeaveChannelOptions options) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    doStopMonitorSystemEvent();
    return nativeLeaveChannelWithOptions(mNativeHandle, options);
  }

  @Override
  public synchronized int leaveChannelEx(RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeLeaveChannelEx(mNativeHandle, getChannelId(connection), getUserId(connection));
  }

  private int setUidCompatibleMode(boolean enabled) {
    return setParameter("rtc.api.set_uid_compatible_mode", enabled);
  }

  @Override
  public synchronized int startEchoTest(int intervalInSeconds) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    Context context = mContext.get();
    if (context == null) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    doMonitorSystemEvent(context);
    return nativeStartEchoTestWithInterval(mNativeHandle, intervalInSeconds);
  }

  @Override
  public synchronized int startEchoTest() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    Context context = mContext.get();
    if (context == null) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    doMonitorSystemEvent(context);
    return nativeStartEchoTest(mNativeHandle);
  }

  @Override
  public synchronized int stopEchoTest() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopEchoTest(mNativeHandle);
  }

  @Override
  public synchronized int startLastmileProbeTest(LastmileProbeConfig config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    Context context = mContext.get();
    if (context == null) {
      return -Constants.ERR_NOT_INITIALIZED;
    }

    doMonitorSystemEvent(context);
    return nativeStartLastmileProbeTest(mNativeHandle, config.probeUplink, config.probeDownlink,
        config.expectedUplinkBitrate, config.expectedDownlinkBitrate);
  }

  @Override
  public synchronized int stopLastmileProbeTest() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopLastmileProbeTest(mNativeHandle);
  }

  @Override
  public synchronized int enableVideo() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableVideo(mNativeHandle);
  }

  @Override
  public synchronized int disableVideo() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeDisableVideo(mNativeHandle);
  }

  @Override
  public synchronized int enableLocalVideo(boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableLocalVideo(mNativeHandle, enabled);
  }

  @Override
  public synchronized int startSecondaryCameraCapture(CameraCapturerConfiguration config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStartSecondaryCameraCapture(mNativeHandle, config);
  }

  @Override
  public synchronized int stopSecondaryCameraCapture() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopSecondaryCameraCapture(mNativeHandle);
  }

  @Override
  public synchronized int startPreview() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStartPreview(mNativeHandle);
  }

  @Override
  public synchronized int startPreview(Constants.VideoSourceType sourceType) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStartPreviewForSourceType(
        mNativeHandle, Constants.VideoSourceType.getValue(sourceType));
  }

  @Override
  public synchronized int stopPreview() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopPreview(mNativeHandle);
  }

  @Override
  public synchronized int stopPreview(Constants.VideoSourceType sourceType) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopPreviewForSourceType(
        mNativeHandle, Constants.VideoSourceType.getValue(sourceType));
  }

  @Override
  public synchronized int enableAudio() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableAudio(mNativeHandle, true);
  }

  @Override
  public synchronized int disableAudio() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableAudio(mNativeHandle, false);
  }

  @Override
  public synchronized int enableLocalAudio(boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableLocalAudio(mNativeHandle, enabled);
  }

  @Override
  public synchronized int pauseAudio() {
    return setParameter("rtc.audio.paused", true);
  }

  @Override
  public synchronized int resumeAudio() {
    return setParameter("rtc.audio.paused", false);
  }

  @Override
  public synchronized int muteLocalAudioStream(boolean muted) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMuteLocalAudioStream(mNativeHandle, muted);
  }

  @Override
  public synchronized int muteLocalVideoStream(boolean muted) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMuteLocalVideoStream(mNativeHandle, muted);
  }

  @Override
  public synchronized int muteAllRemoteAudioStreams(boolean muted) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMuteAllRemoteAudioStreams(mNativeHandle, muted);
  }

  @Override
  public synchronized int setDefaultMuteAllRemoteAudioStreams(boolean muted) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    setParameter("rtc.audio.set_default_mute_peers", muted);
    return nativeSetDefaultMuteAllRemoteAudioStreams(mNativeHandle, muted);
  }

  @Override
  public synchronized int muteAllRemoteVideoStreams(boolean muted) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMuteAllRemoteVideoStreams(mNativeHandle, muted);
  }

  @Override
  public synchronized int setDefaultMuteAllRemoteVideoStreams(boolean muted) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    setParameter("rtc.video.set_default_mute_peers", muted);
    return nativeSetDefaultMuteAllRemoteVideoStreams(mNativeHandle, muted);
  }

  public synchronized int setBeautyEffectOptions(boolean enabled, BeautyOptions options) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetBeautyEffectOptions(mNativeHandle, enabled, options.lighteningContrastLevel,
        options.lighteningLevel, options.smoothnessLevel, options.rednessLevel,
        options.sharpnessLevel);
  }

  @Override
  public synchronized int enableVirtualBackground(
      boolean enabled, VirtualBackgroundSource backgroundSource) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (backgroundSource == null) {
      if (enabled) {
        return -Constants.ERR_INVALID_ARGUMENT;
      } else {
        backgroundSource = new VirtualBackgroundSource();
      }
    }
    return nativeEnableVirtualBackground(mNativeHandle, enabled,
        backgroundSource.backgroundSourceType, backgroundSource.color, backgroundSource.source,
        backgroundSource.blurDegree);
  }

  @Override
  public synchronized int muteRemoteAudioStream(int uid, boolean muted) {
    return muteRemoteAudioStreamEx(uid, muted, null);
  }

  @Override
  public synchronized int muteRemoteAudioStreamEx(
      int uid, boolean muted, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMuteRemoteAudioStream(
        mNativeHandle, uid, muted, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int muteRemoteVideoStream(int uid, boolean muted) {
    return muteRemoteVideoStreamEx(uid, muted, null);
  }

  @Override
  public synchronized int muteRemoteVideoStreamEx(
      int uid, boolean muted, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMuteRemoteVideoStream(
        mNativeHandle, uid, muted, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int setRemoteVideoStreamTypeEx(
      int uid, int streamType, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetRemoteVideoStreamType(
        mNativeHandle, uid, streamType, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int renewToken(String token) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (token == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeRenewToken(mNativeHandle, token);
  }

  @Override
  public synchronized int setDefaultAudioRoutetoSpeakerphone(boolean defaultToSpeaker) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetDefaultAudioRoutetoSpeakerphone(mNativeHandle, defaultToSpeaker);
  }

  @Override
  public synchronized int setEnableSpeakerphone(boolean speakerOn) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetEnableSpeakerphone(mNativeHandle, speakerOn);
  }

  @Override
  public synchronized boolean isSpeakerphoneEnabled() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return false;
    }
    return nativeIsSpeakerphoneEnabled(mNativeHandle);
  }

  @Override
  public synchronized int startRecordingService(String recordingKey) {
    if (recordingKey == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return setParameter("rtc.api.start_recording_service", recordingKey);
  }

  @Override
  public synchronized int stopRecordingService(String recordingKey) {
    if (recordingKey == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return setParameter("rtc.api.stop_recording_service", recordingKey);
  }

  @Override
  public synchronized int refreshRecordingServiceStatus() {
    return setParameter("rtc.api.query_recording_service_status", true);
  }

  @Override
  public synchronized int muteRecordingSignal(boolean muted) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMuteRecordingSignal(mNativeHandle, muted);
  }

  @Override
  public synchronized int adjustRecordingSignalVolume(int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (volume < 0) {
      volume = 0;
    } else if (volume > 400) {
      volume = 400;
    }
    return nativeAdjustRecordingSignalVolume(mNativeHandle, volume);
  }

  @Override
  public synchronized int adjustPlaybackSignalVolume(int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (volume < 0) {
      volume = 0;
    } else if (volume > 400) {
      volume = 400;
    }
    return nativeAdjustPlaybackSignalVolume(mNativeHandle, volume);
  }

  @Override
  public synchronized int adjustUserPlaybackSignalVolume(int uid, int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (volume < 0) {
      volume = 0;
    } else if (volume > 100) {
      volume = 100;
    }
    return nativeAdjustUserPlaybackSignalVolume(mNativeHandle, uid, volume);
  }

  @Override
  public synchronized int setRecordingAudioFrameParameters(
      int sampleRate, int channel, int mode, int samplesPerCall) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetRecordingAudioFrameParameters(
        mNativeHandle, sampleRate, channel, mode, samplesPerCall);
  }

  @Override
  public synchronized int setPlaybackAudioFrameParameters(
      int sampleRate, int channel, int mode, int samplesPerCall) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetPlaybackAudioFrameParameters(
        mNativeHandle, sampleRate, channel, mode, samplesPerCall);
  }

  @Override
  public synchronized int setMixedAudioFrameParameters(
      int sampleRate, int channel, int samplesPerCall) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetMixedAudioFrameParameters(mNativeHandle, sampleRate, channel, samplesPerCall);
  }

  @Override
  public synchronized int setPlaybackAudioFrameBeforeMixingParameters(int sampleRate, int channel) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetPlaybackAudioFrameBeforeMixingParameters(mNativeHandle, sampleRate, channel);
  }

  synchronized int mediaPlayerRegisterAudioFrameObserver(
      int sourceId, IMediaPlayerAudioFrameObserver audioFrameObserver, int mode) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerRegisterAudioFrameObserver)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerRegisterAudioFrameObserver(
        mNativeHandle, sourceId, audioFrameObserver, mode);
  }

  synchronized int mediaPlayerRegisterVideoFrameObserver(
      int sourceId, IMediaPlayerVideoFrameObserver observer) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerRegisterVideoFrameObserver)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerRegisterVideoFrameObserver(mNativeHandle, sourceId, observer);
  }

  @Override
  public synchronized int registerAudioFrameObserver(io.agora.rtc2.IAudioFrameObserver observer) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeRegisterAudioFrameObserver(mNativeHandle, observer);
  }

  public synchronized int enableAudioSpectrumMonitor(int intervalInMS) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableAudioSpectrumMonitor(mNativeHandle, intervalInMS);
  }

  public synchronized int disableAudioSpectrumMonitor() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeDisableAudioSpectrumMonitor(mNativeHandle);
  }

  public synchronized int registerAudioSpectrumObserver(IAudioSpectrumObserver observer) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeRegisterAudioSpectrumObserver(mNativeHandle, observer);
  }

  public synchronized int unRegisterAudioSpectrumObserver(IAudioSpectrumObserver observer) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeUnRegisterAudioSpectrumObserver(mNativeHandle, observer);
  }

  @Override
  public synchronized int registerAudioEncodedFrameObserver(
      AudioEncodedFrameObserverConfig config, IAudioEncodedFrameObserver observer) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (config == null) {
      config = new AudioEncodedFrameObserverConfig();
    }
    return nativeregisterAudioEncodedFrameObserver(
        mNativeHandle, observer, config.postionType, config.encodingType);
  }

  @Override
  public synchronized int setHighQualityAudioParameters(
      boolean fullband, boolean stereo, boolean fullBitrate) {
    return setParameterObject("che.audio.codec.hq",
        formatString(
            "{\"fullband\":%b,\"stereo\":%b,\"fullBitrate\":%b}", fullband, stereo, fullBitrate));
  }

  @Override
  public synchronized int enableInEarMonitoring(boolean enabled, int includeAudioFilters) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableInEarMonitoring(mNativeHandle, enabled, includeAudioFilters);
  }

  @Override
  public synchronized int enableInEarMonitoring(boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return enableInEarMonitoring(enabled, Constants.EAR_MONITORING_FILTER_BUILT_IN_AUDIO_FILTERS);
  }

  @Override
  public synchronized int enableWebSdkInteroperability(boolean enabled) {
    return setParameters(String.format(
        "{\"rtc.video.web_h264_interop_enable\":%b,\"che.video.web_h264_interop_enable\":%b}",
        enabled, enabled));
  }

  @Override
  public synchronized int setVideoQualityParameters(boolean preferFrameRateOverImageQuality) {
    return setParameters(
        String.format("{\"rtc.video.prefer_frame_rate\":%b,\"che.video.prefer_frame_rate\":%b}",
            preferFrameRateOverImageQuality, preferFrameRateOverImageQuality));
  }

  @Deprecated
  public synchronized void setPreferHeadset(boolean enabled) {}

  @Override
  public synchronized int enableAudioVolumeIndication(int interval, int smooth, boolean reportVad) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableAudioVolumeIndication(mNativeHandle, interval, smooth, reportVad);
  }

  @Override
  public synchronized int enableAudioQualityIndication(boolean enabled) {
    return setParameter("rtc.audio_quality_indication", enabled);
  }

  @Override
  public synchronized int enableTransportQualityIndication(boolean enabled) {
    return setParameter("rtc.transport_quality_indication", enabled);
  }

  @Override
  public synchronized int playRecap() {
    return setParameter("che.audio.recap.start_play", true);
  }

  @Override
  public synchronized int enableRecap(
      int interval) { // in ms: <= 0: disable, > 0: enable, interval in ms
    if (interval < 0)
      interval = 0;
    return setParameter("che.audio.recap.interval", interval);
  }

  @Override
  public synchronized int setVideoProfile(int profile, boolean swapWidthAndHeight) {
    if (profile < 0) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return setParameters(
        formatString("{\"rtc.video.profile\":[%d,%b]}", profile, swapWidthAndHeight));
  }

  @Override
  public synchronized int setVideoEncoderConfiguration(VideoEncoderConfiguration config) {
    return setVideoEncoderConfigurationEx(config, null);
  }

  @Override
  public synchronized int setVideoEncoderConfigurationEx(
      VideoEncoderConfiguration config, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetVideoEncoderConfiguration(mNativeHandle, config.dimensions.width,
        config.dimensions.height, config.frameRate, config.bitrate, config.minBitrate,
        config.orientationMode.getValue(), config.mirrorMode.getValue(),
        config.degradationPrefer.getValue(), getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int setAudioProfile(int profile, int scenario) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioProfileScenario(mNativeHandle, profile, scenario);
  }

  @Override
  public synchronized int setAudioProfile(int profile) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioProfile(mNativeHandle, profile);
  }

  @Override
  public synchronized int monitorAudioRouteChange(boolean isMonitoring) {
    Logging.i("API call monitorAudioRouteChange:" + isMonitoring);
    return 0;
  }

  @Override
  public synchronized int switchCamera() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSwitchCamera(mNativeHandle);
  }

  @Override
  public synchronized boolean isCameraZoomSupported() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return false;
    }
    return nativeGetCameraZoomSupported(mNativeHandle);
  }

  @Override
  public synchronized boolean isCameraTorchSupported() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return false;
    }
    return nativeGetCameraTorchSupported(mNativeHandle);
  }

  @Override
  public synchronized boolean isCameraFocusSupported() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return false;
    }
    return nativeGetCameraFocusSupported(mNativeHandle);
  }

  @Override
  public synchronized boolean isCameraFaceDetectSupported() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return false;
    }
    return nativeGetCameraFaceDetectSupported(mNativeHandle);
  }

  @Override
  public synchronized boolean isCameraAutoFocusFaceModeSupported() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return false;
    }
    return nativeGetCameraAutoFocusFaceModeSupported(mNativeHandle);
  }

  @Override
  public synchronized boolean isCameraExposurePositionSupported() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return false;
    }
    return nativeGetCameraExposurePositionSupported(mNativeHandle);
  }

  @Override
  public synchronized int setCameraZoomFactor(float factor) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetCameraZoomFactor(mNativeHandle, factor);
  }

  @Override
  public synchronized float getCameraMaxZoomFactor() {
    if (mNativeHandle == 0) {
      return 1.0f;
    }
    return nativeGetCameraMaxZoomFactor(mNativeHandle);
  }

  @Override
  public synchronized int setCameraFocusPositionInPreview(float positionX, float positionY) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetCameraFocusPositionInPreview(mNativeHandle, positionX, positionY);
  }

  @Override
  public synchronized int setCameraTorchOn(boolean isOn) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetCameraTorchOn(mNativeHandle, isOn);
  }

  @Override
  public synchronized int enableFaceDetection(boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableFaceDetection(mNativeHandle, enabled);
  }

  @Override
  public synchronized int setCameraAutoFocusFaceModeEnabled(boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetCameraAutoFocusFaceModeEnabled(mNativeHandle, enabled);
  }

  @Override
  public synchronized int setCameraCapturerConfiguration(CameraCapturerConfiguration config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    } else if (config == null) {
      Logging.e(TAG, "CameraCapturerConfiguration is null");
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeSetCameraCapturerConfiguration(mNativeHandle, config);
  }

  @Override
  public synchronized int setCameraExposurePosition(float positionXinView, float positionYinView) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetCameraExposurePosition(mNativeHandle, positionXinView, positionYinView);
  }

  @Override
  public synchronized int sendCustomReportMessage(
      String id, String category, String event, String label, int value) {
    return sendCustomReportMessageEx(id, category, event, label, value, null);
  }

  @Override
  public synchronized int sendCustomReportMessageEx(
      String id, String category, String event, String label, int value, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSendCustomReportMessage(mNativeHandle, id, category, event, label, value,
        getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized IMediaPlayer createMediaPlayer() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }

    IMediaPlayer mediaPlayer = null;
    int sourceId = nativeCreateMediaPlayer(mNativeHandle);
    if (sourceId >= 0) {
      mediaPlayer = new MediaPlayerImpl(this, sourceId);
    } else {
      Logging.e(TAG, "Create media player failed " + sourceId);
    }
    return mediaPlayer;
  }

  synchronized int mediaPlayerOpen(int sourceId, String url, long startPos) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerOpen)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerOpen(mNativeHandle, sourceId, url, startPos);
  }

  synchronized int mediaPlayerOpenWithCustomSource(
      int sourceId, long startPos, IMediaPlayerCustomDataProvider provider) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerOpenWithCustomSource)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerOpenWithCustormProviderData(
        mNativeHandle, sourceId, startPos, provider);
  }

  synchronized int mediaPlayerPlay(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerPlay)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerPlay(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerPause(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerPause)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerPause(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerStop(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerStop)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerStop(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerResume(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerResume)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerResume(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerSeek(int sourceId, long newPos) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerSeek)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSeek(mNativeHandle, sourceId, newPos);
  }

  synchronized int mediaPlayerSetAudioPitch(int sourceId, int pitch) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerSetAudioPitch)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSetAudioPitch(mNativeHandle, sourceId, pitch);
  }

  synchronized long mediaPlayerGetPlayPosition(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetPlayPosition)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetPlayPosition(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerMute(int sourceId, boolean mute) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerMute)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerMute(mNativeHandle, sourceId, mute);
  }

  synchronized boolean mediaPlayerIsMuted(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerIsMuted)");
      return false;
    }
    return nativeMediaPlayerIsMuted(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerGetState(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetState)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetState(mNativeHandle, sourceId);
  }

  synchronized long mediaPlayerGetDuration(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetDuration)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetDuration(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerGetStreamCount(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetStreamCount)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetStreamCount(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerSetView(int sourceId, View videoView) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerSetView)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSetView(mNativeHandle, sourceId, videoView);
  }

  synchronized int mediaPlayerSetRenderMode(int sourceId, int mode) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerSetRenderMode)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSetRenderMode(mNativeHandle, sourceId, mode);
  }

  synchronized MediaStreamInfo mediaPlayerGetStreamInfo(int sourceId, int index) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetStreamInfo)");
      return null;
    }
    return nativeMediaPlayerGetStreamInfo(mNativeHandle, sourceId, index);
  }

  synchronized int mediaPlayerSetLoopCount(int sourceId, int loopCount) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerSetLoopCount)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSetLoopCount(mNativeHandle, sourceId, loopCount);
  }

  synchronized int mediaPlayerChangePlaybackSpeed(int sourceId, int speed) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerChangePlaybackSpeed)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerChangePlaybackSpeed(mNativeHandle, sourceId, speed);
  }

  synchronized int mediaPlayerSelectAudioTrack(int sourceId, int index) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerSelectAudioTrack)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSelectAudioTrack(mNativeHandle, sourceId, index);
  }

  synchronized int mediaPlayerSetPlayerOption(int sourceId, String key, int value) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerSetPlayerOption)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSetPlayerOption(mNativeHandle, sourceId, key, value);
  }

  synchronized int mediaPlayerTakeScreenshot(int sourceId, String filename) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerTakeScreenshot)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerTakeScreenshot(mNativeHandle, sourceId, filename);
  }

  synchronized int mediaPlayerSelectInternalSubtitle(int sourceId, int index) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerSelectInternalSubtitle)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSelectInternalSubtitle(mNativeHandle, sourceId, index);
  }

  synchronized int mediaPlayerSetExternalSubtitle(int sourceId, String url) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerSetExternalSubtitle)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSetExternalSubtitle(mNativeHandle, sourceId, url);
  }

  synchronized int mediaPlayerAdjustPlayoutVolume(int sourceId, int volume) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerAdjustPlayoutVolume)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerAdjustPlayoutVolume(mNativeHandle, sourceId, volume);
  }

  synchronized int mediaPlayerGetPlayoutVolume(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetPlayoutVolume)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetPlayoutVolume(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerAdjustPublishSignalVolume(int sourceId, int volume) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerAdjustPublishSignalVolume)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerAdjustPublishSignalVolume(mNativeHandle, sourceId, volume);
  }

  synchronized int mediaPlayerGetPublishSignalVolume(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetPublishSignalVolume)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetPublishSignalVolume(mNativeHandle, sourceId);
  }

  synchronized String mediaPlayerGetPlaySrc(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerGetPlaySrc)");
      return null;
    }
    return nativeMediaPlayerGetPlaySrc(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerSwitchSrc(int sourceId, String src, boolean syncPts) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSwitchSrc(mNativeHandle, sourceId, src, syncPts);
  }

  synchronized int mediaPlayerPreloadSrc(int sourceId, String src, long startPos) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerPreloadSrc(mNativeHandle, sourceId, src, startPos);
  }

  synchronized int mediaPlayerUnloadSrc(int sourceId, String src) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerUnloadSrc(mNativeHandle, sourceId, src);
  }

  synchronized int mediaPlayerPlayPreloadedSrc(int sourceId, String src) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerPlayPreloadedSrc(mNativeHandle, sourceId, src);
  }

  synchronized int mediaPlayerDestroy(int sourceId) {
    if (mNativeHandle == 0) {
      Logging.e(
          TAG, "RtcEngine does not initialize or it may be destroyed (mediaPlayerSourceDestroy)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerDestroy(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerRegisterPlayerObserver(
      int sourceId, IMediaPlayerObserver playerObserver) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerRegisterPlayerObserver)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerRegisterPlayerObserver(mNativeHandle, sourceId, playerObserver);
  }

  synchronized int mediaPlayerUnRegisterPlayerObserver(
      int sourceId, IMediaPlayerObserver playerObserver) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerUnRegisterPlayerObserver)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerUnRegisterPlayerObserver(mNativeHandle, sourceId, playerObserver);
  }

  synchronized int mediaPlayerOpenWithAgoraCDNSrc(int sourceId, String src, long startPos) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerOpenWithAgoraCDNSrc(mNativeHandle, sourceId, src, startPos);
  }

  synchronized int mediaPlayerGetAgoraCDNLineCount(int sourceId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetAgoraCDNLineCount(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerSwitchAgoraCDNLineByIndex(int sourceId, int index) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSwitchAgoraCDNLineByIndex(mNativeHandle, sourceId, index);
  }

  synchronized int mediaPlayerGetCurrentAgoraCDNIndex(int sourceId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerGetCurrentAgoraCDNIndex(mNativeHandle, sourceId);
  }

  synchronized int mediaPlayerEnableAutoSwitchAgoraCDN(int sourceId, boolean enable) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerEnableAutoSwitchAgoraCDN(mNativeHandle, sourceId, enable);
  }

  synchronized int mediaPlayerRenewAgoraCDNSrcToken(int sourceId, String token, long ts) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerRenewAgoraCDNSrcToken(mNativeHandle, sourceId, token, ts);
  }

  synchronized int mediaPlayerSwitchAgoraCDNSrc(int sourceId, String src, boolean syncPts) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSwitchAgoraCDNSrc(mNativeHandle, sourceId, src, syncPts);
  }

  synchronized int mediaPlayerSetAudioDualMonoMode(int sourceId, int mode) {
    if (mNativeHandle == 0) {
      Logging.e(TAG,
          "RtcEngine does not initialize or it may be destroyed (mediaPlayerSetAudioDualMonoMode)");
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeMediaPlayerSetAudioDualMonoMode(mNativeHandle, sourceId, mode);
  }

  /**
   * enable/disable remote video
   *
   * @param enabled true, start receiving and rendering remote video; false, stop
   *                receiving and rendering remote video
   * @param uid     remote user id to enable/disable
   */
  public synchronized int enableRemoteVideo(boolean enabled, int uid) {
    return setParameterObject("che.video.peer.receive",
        formatString("{\"enable\":%b, \"uid\":\"%s\"}", enabled, toStringUserId(uid)));
  }

  public synchronized int stopRemoteVideo(int uid) {
    return setParameter("che.video.peer.stop_video", toStringUserId(uid));
  }

  private static String formatString(String format, Object... args) {
    return String.format(Locale.US, format, args);
  }

  public synchronized int stopAllRemoteVideo() {
    return setParameter("che.video.peer.stop_all_renders", true);
  }

  @Override
  public synchronized int startAudioRecording(String filePath, int quality) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (TextUtils.isEmpty(filePath)) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeStartAudioRecording(mNativeHandle, filePath, quality);
  }

  @Override
  public synchronized int startAudioRecording(AudioRecordingConfiguration config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (TextUtils.isEmpty(config.filePath)) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeStartAudioRecording2(mNativeHandle, config.filePath, config.codec,
        config.sampleRate, config.fileRecordOption, config.quality);
  }

  @Override
  public synchronized int stopAudioRecording() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopAudioRecording(mNativeHandle);
  }

  @Override
  public synchronized int startPlayingStream(String url) {
    return setParameter("rtc.api.video.start_play_stream", url);
  }

  @Override
  public synchronized int stopPlayingStream() {
    return setParameter("rtc.api.video.stop_play_stream", true);
  }

  @Override
  public synchronized int startAudioMixing(
      String filePath, boolean loopback, boolean replace, int cycle) {
    return startAudioMixing(filePath, loopback, replace, cycle, 0);
  }

  @Override
  public synchronized int startAudioMixing(
      String filePath, boolean loopback, boolean replace, int cycle, int startPos) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStartAudioMixing(mNativeHandle, filePath, loopback, replace, cycle, startPos);
  }

  @Override
  public synchronized int stopAudioMixing() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopAudioMixing(mNativeHandle);
  }

  @Override
  public synchronized int pauseAudioMixing() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativePauseAudioMixing(mNativeHandle);
  }

  @Override
  public synchronized int resumeAudioMixing() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeResumeAudioMixing(mNativeHandle);
  }

  @Override
  public synchronized int adjustAudioMixingVolume(int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeAdjustAudioMixingVolume(mNativeHandle, volume);
  }

  @Override
  public synchronized int adjustAudioMixingPublishVolume(int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeAdjustAudioMixingPublishVolume(mNativeHandle, volume);
  }

  @Override
  public synchronized int getAudioMixingPublishVolume() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeGetAudioMixingPublishVolume(mNativeHandle);
  }

  @Override
  public synchronized int adjustAudioMixingPlayoutVolume(int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeAdjustAudioMixingPlayoutVolume(mNativeHandle, volume);
  }

  @Override
  public synchronized int getAudioMixingPlayoutVolume() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeGetAudioMixingPlayoutVolume(mNativeHandle);
  }

  @Override
  public synchronized int getAudioMixingDuration() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeGetAudioMixingDuration(mNativeHandle);
  }

  @Override
  public synchronized int getAudioMixingCurrentPosition() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeGetAudioMixingCurrentPosition(mNativeHandle);
  }

  @Override
  public synchronized int setAudioMixingPosition(int pos) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioMixingPosition(mNativeHandle, pos);
  }

  @Override
  public synchronized int setAudioMixingPitch(int pitch) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioMixingPitch(mNativeHandle, pitch);
  }

  public synchronized int useExternalAudioDevice() {
    return setParameters(
        "{\"che.audio.audioSampleRate\":32000, \"che.audio.external_device\":true}");
  }

  @Override
  public synchronized int setExternalAudioSource(boolean enabled, int sampleRate, int channels) {
    return setExternalAudioSource(
        enabled, sampleRate, channels, DEFAULT_EXTERNAL_AUDIO_SOURCE_COUNT, false, true);
  }

  @Override
  public synchronized int setExternalAudioSource(boolean enabled, int sampleRate, int channels,
      int sourceCount, boolean localPlayback, boolean publish) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    mExSourceAudioSampleRate = sampleRate;
    mExSourceAudioChannels = channels;
    return nativeSetExternalAudioSource(
        mNativeHandle, enabled, sampleRate, channels, sourceCount, localPlayback, publish);
  }

  @Override
  public synchronized int setDirectExternalAudioSource(boolean enabled) {
    return setDirectExternalAudioSource(enabled, false);
  }

  @Override
  public synchronized int setDirectExternalAudioSource(boolean enabled, boolean localPlayback) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetDirectExternalAudioSource(mNativeHandle, enabled, localPlayback);
  }

  @Override
  public synchronized int pushDirectAudioFrame(
      ByteBuffer data, long timestamp, int sampleRate, int channels) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (!data.isDirect()) {
      throw new IllegalArgumentException("data must be direct buffer!");
    }
    return nativePushDirectAudioFrameRawData(
        mNativeHandle, data, timestamp, sampleRate, AudioFormat.ENCODING_PCM_16BIT, channels);
  }

  @Override
  public synchronized int pushExternalAudioFrame(byte[] data, long timestamp) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (data == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    ByteBuffer frame = ByteBuffer.allocateDirect(data.length);
    frame.order(ByteOrder.LITTLE_ENDIAN);
    frame.put(data, 0, data.length);
    frame.flip();
    // set default sourceId to 0 which less than DEFAULT_EXTERNAL_AUDIO_SOURCE_NUMBER
    return pushExternalAudioFrame(frame, timestamp, 0);
  }

  @Override
  public synchronized int pushExternalAudioFrame(ByteBuffer data, long timestamp, int sourceId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (!data.isDirect()) {
      throw new IllegalArgumentException("data must be direct buffer!");
    }
    return nativePushExternalAudioFrameRawData(mNativeHandle, data, timestamp,
        mExSourceAudioSampleRate, AudioFormat.ENCODING_PCM_16BIT, mExSourceAudioChannels, sourceId);
  }

  @Override
  public synchronized int enableEchoCancellationExternal(boolean enabled, int audioSourceDelay) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableEchoCancellationExternal(mNativeHandle, enabled, audioSourceDelay);
  }

  @Override
  public synchronized int setExternalAudioSink(int sampleRate, int channels) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    mExSinkAudioSampleRate = sampleRate;
    mExSinkAudioChannels = channels;
    return nativeSetExternalAudioSink(mNativeHandle, sampleRate, channels);
  }

  @Override
  public synchronized int pushCaptureAudioFrame(byte[] data) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (data == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    ByteBuffer frame = ByteBuffer.allocateDirect(data.length);
    frame.order(ByteOrder.LITTLE_ENDIAN);
    frame.put(data, 0, data.length);
    frame.flip();
    // set default sourceId to 0 which less than DEFAULT_EXTERNAL_AUDIO_SOURCE_NUMBER
    return pushCaptureAudioFrame(frame, data.length);
  }

  @Override
  public synchronized int pushCaptureAudioFrame(ByteBuffer data, int lengthInByte) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (data == null || data.capacity() != lengthInByte) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    if (!data.isDirect()) {
      throw new IllegalArgumentException("data must be direct buffer!");
    }
    return nativePushCaptureAudioFrame(
        mNativeHandle, data, lengthInByte, mExSourceAudioSampleRate, mExSourceAudioChannels);
  }

  @Override
  public synchronized int pushReverseAudioFrame(byte[] data) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (data == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    ByteBuffer frame = ByteBuffer.allocateDirect(data.length);
    frame.order(ByteOrder.LITTLE_ENDIAN);
    frame.put(data, 0, data.length);
    frame.flip();
    // set default sourceId to 0 which less than DEFAULT_EXTERNAL_AUDIO_SOURCE_NUMBER
    return pushReverseAudioFrame(frame, data.length);
  }

  @Override
  public synchronized int pushReverseAudioFrame(ByteBuffer data, int lengthInByte) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (data == null || data.capacity() != lengthInByte) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    if (!data.isDirect()) {
      throw new IllegalArgumentException("data must be direct buffer!");
    }
    return nativePushReverseAudioFrame(
        mNativeHandle, data, lengthInByte, mExSourceAudioSampleRate, mExSourceAudioChannels);
  }

  @Override
  public synchronized int pullPlaybackAudioFrame(byte[] data, int lengthInByte) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (data == null || data.length != lengthInByte) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    ByteBuffer frame = ByteBuffer.allocateDirect(lengthInByte);
    frame.order(ByteOrder.LITTLE_ENDIAN);
    int ret = pullPlaybackAudioFrame(frame, lengthInByte);
    if (ret == Constants.ERR_OK) {
      frame.get(data, 0, lengthInByte);
    }
    return ret;
  }

  @Override
  public synchronized int pullPlaybackAudioFrame(ByteBuffer data, int lengthInByte) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (data == null || data.capacity() != lengthInByte) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    if (!data.isDirect()) {
      throw new IllegalArgumentException("data must be direct buffer!");
    }
    return nativePullAudioFrame(
        mNativeHandle, data, lengthInByte, mExSinkAudioSampleRate, mExSinkAudioChannels);
  }

  @Override
  public synchronized int setLogFile(String filePath) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetLogFile(mNativeHandle, filePath);
  }

  @Override
  public synchronized int setLogFilter(int filter) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetLogFilter(mNativeHandle, filter & 0x80f);
  }

  @Override
  public synchronized int setLogFileSize(long fileSizeInKBytes) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetLogFileSize(mNativeHandle, fileSizeInKBytes);
  }

  @Override
  public synchronized String uploadLogFile() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeUploadLogFile(mNativeHandle);
  }

  @Override
  public synchronized int setProfile(String profile, boolean merge) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetProfile(mNativeHandle, profile, merge);
  }

  public synchronized String getProfile() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeGetProfile(mNativeHandle);
  }

  @Override
  public synchronized int setParameters(String parameters) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetParameters(mNativeHandle, parameters);
  }

  public synchronized String getParameters(String parameters) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeGetParameters(mNativeHandle, parameters);
  }

  @Override
  public synchronized String getParameter(String parameter, String args) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeGetParameter(mNativeHandle, parameter, args);
  }

  @Override
  public synchronized String makeQualityReportUrl(
      String channelName, String listenerUid, String speakerUid, int format) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeMakeQualityReportUrl(mNativeHandle, channelName, listenerUid, speakerUid, format);
  }

  @Override
  public synchronized String getCallId() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeGetCallId(mNativeHandle);
  }

  @Override
  public synchronized RtcConnection.CONNECTION_STATE_TYPE getConnectionState() {
    return getConnectionStateEx(null);
  }

  @Override
  public synchronized RtcConnection.CONNECTION_STATE_TYPE getConnectionStateEx(
      RtcConnection connection) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return RtcConnection.CONNECTION_STATE_TYPE.CONNECTION_STATE_NOT_INITIALIZED;
    }
    int state =
        nativeGetConnectionState(mNativeHandle, getChannelId(connection), getUserId(connection));
    return RtcConnection.CONNECTION_STATE_TYPE.values()[state];
  }

  @Override
  public synchronized int rate(String callId, int rating, String description) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeRate(mNativeHandle, callId, rating, description);
  }

  @Override
  public synchronized int complain(String callId, String description) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeComplain(mNativeHandle, callId, description);
  }

  @Override
  public synchronized int setChannelProfile(int profile) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetChannelProfile(mNativeHandle, profile);
  }

  @Override
  public synchronized int setClientRole(int role) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetClientRole(mNativeHandle, role, null);
  }

  @Override
  public synchronized int setClientRole(int role, ClientRoleOptions options) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetClientRole(mNativeHandle, role, options);
  }

  @Override
  public synchronized int setRemoteVideoStreamType(int userId, int streamType) {
    return setRemoteVideoStreamTypeEx(userId, streamType, null);
  }

  public synchronized int setRemoteVideoStreamType(String userId, int streamType) {
    return setParameters(formatString(
        "{\"rtc.video.set_remote_video_stream\":{\"uid\":\"%s\",\"stream\":%d},\"che.video.setstream\":{\"uid\":\"%s\",\"stream\":%d}}",
        userId, streamType, userId, streamType));
    // return
    // setParameters(formatString("{\"rtc.video.set_remote_video_stream\":{\"uid\":\"%s\",\"stream\":%d}}",
    // userId, streamType));
  }

  @Override
  public synchronized int setRemoteDefaultVideoStreamType(int streamType) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    setParameter("rtc.video.set_remote_default_video_stream_type", streamType);
    return nativeSetRemoteDefaultVideoStreamType(mNativeHandle, streamType);
  }

  @Override
  public synchronized int setRemoteUserPriority(int uid, int userPriority) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetRemoteUserPriority(mNativeHandle, uid, userPriority);
  }

  @Override
  public synchronized int setLocalPublishFallbackOption(int option) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return setParameter("rtc.local_publish_fallback_option", option);
  }

  @Override
  public synchronized int setRemoteSubscribeFallbackOption(int option) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return setParameter("rtc.remote_subscribe_fallback_option", option);
  }

  @Override
  public synchronized int setEncryptionMode(String encryptionMode) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    setParameter("rtc.encryption.mode", encryptionMode);
    return nativeSetEncryptionMode(mNativeHandle, encryptionMode);
  }

  @Override
  public synchronized int setEncryptionSecret(String secret) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    // secret may contain characters that are invalid for json string,
    // so here we need avoid using simple json generation method
    return nativeSetEncryptionSecret(mNativeHandle, secret);
  }

  @Override
  public synchronized int enableEncryption(boolean enabled, EncryptionConfig config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableEncryption(mNativeHandle, enabled, config.encryptionMode.getValue(),
        config.encryptionKey, config.encryptionKdfSalt);
  }

  @CalledByNative
  private void onLogEvent(int level, String message) {
    // mHandler.onLogEvent(level, message);
  }

  @CalledByNative
  protected void onEvent(int eventId, byte[] evt) {
    try {
      Iterator<IAgoraEventHandler> it = mRtcHandlers.keySet().iterator();
      while (it.hasNext()) {
        IAgoraEventHandler h = it.next();
        if (h == null) {
          it.remove();
          continue;
        }
        handleEvent(eventId, evt, h);
      }
    } catch (Throwable ex /* Catch Throwable to include errors like OutOfMemoryError*/) {
      // CalledByNative, we can not handler user's exception in Java. if exception,
      // checker ini jni will fail. so just print to log.
      try {
        Log.e(TAG, "onEvent: " + ex.toString());
      } catch (Throwable extra) {
        // ignore the exception
      }
    }
  }

  @CalledByNative
  protected void onEventEx(String channelId, int uid, String userId, int eventId, byte[] evt) {
    try {
      IAgoraEventHandler h = null;
      if (!TextUtils.isEmpty(userId)) {
        h = mRtcExHandlers.get(Pair.create(channelId, userId));
      }
      if (h == null) {
        h = mRtcExHandlers.get(Pair.create(channelId, uid));
      }
      if (h != null) {
        handleEvent(eventId, evt, h);
      } else {
        Log.e(TAG, "onEventEx: can't find exhandler for channelId=" + channelId + " uid=" + uid);
      }
    } catch (Throwable ex /* Catch Throwable to include errors like OutOfMemoryError*/) {
      // CalledByNative, we can not handler user's exception in Java. if exception,
      // checker ini jni will fail. so just print to log.
      try {
        Log.e(TAG, "onEventEx: channelId=" + channelId + " uid=" + uid + " ex=" + ex.toString());
      } catch (Throwable extra) {
        // ignore the exception
      }
    }
  }

  protected void handleEvent(int eventId, byte[] evt, IAgoraEventHandler handler) {
    if (handler == null || !(handler instanceof IRtcEngineEventHandler))
      return;

    switch (eventId) {
      case RtcEngineEvent.EvtType.EVT_NATIVE_LOG:
        sendLogEvent(evt);
        break;
      case RtcEngineEvent.EvtType.EVT_ERROR: {
        RtcEngineMessage.PError pe = new RtcEngineMessage.PError();
        pe.unmarshall(evt);
        handler.onError(pe.err);
      } break;
      case RtcEngineEvent.EvtType.EVT_WARNING: {
        RtcEngineMessage.PError pe = new RtcEngineMessage.PError();
        pe.unmarshall(evt);
        handler.onWarning(pe.err);
      } break;
      case RtcEngineEvent.EvtType.EVT_MEDIA_ENGINE_LOAD_SUCCESS:
        handler.onMediaEngineLoadSuccess();
        break;
      case RtcEngineEvent.EvtType.EVT_MEDIA_ENGINE_START_CAMERA_SUCCESS:
        handler.onCameraReady();
        break;
      case RtcEngineEvent.EvtType.EVT_MEDIA_ENGINE_START_CALL_SUCCESS:
        // monitorAudioRouting();
        handler.onMediaEngineStartCallSuccess();
        break;
      case RtcEngineEvent.EvtType.EVT_VIDEO_STOPPED:
        handler.onVideoStopped();
        break;
      case RtcEngineEvent.EvtType.EVT_AUDIO_QUALITY:
        RtcEngineMessage.PMediaResAudioQuality aq = new RtcEngineMessage.PMediaResAudioQuality();
        aq.unmarshall(evt);
        ((IRtcEngineEventHandler) handler)
            .onAudioQuality(aq.uid, aq.quality, (short) (aq.delay), aq.lost);
        break;
      case RtcEngineEvent.EvtType.EVT_MEDIA_ENGINE_EVENT:
        RtcEngineMessage.PMediaEngineEvent pmee = new RtcEngineMessage.PMediaEngineEvent();
        pmee.unmarshall(evt);
        switch (pmee.code) {
          case Constants.MEDIA_ENGINE_AUDIO_FILE_MIX_FINISH:
            handler.onAudioMixingFinished();
            break;
          case Constants.MEDIA_ENGINE_ROLE_BROADCASTER_SOLO:
          case Constants.MEDIA_ENGINE_ROLE_BROADCASTER_INTERACTIVE:
          case Constants.MEDIA_ENGINE_ROLE_AUDIENCE:
          case Constants.MEDIA_ENGINE_ROLE_COMM_PEER:
            // if (mAudioRoutingController != null)
            // mAudioRoutingController.sendEvent(AudioRoutingController.EVT_ENGINE_ROLE_CHANGED,
            // pmee.code);
            break;
        }
        break;
      case RtcEngineEvent.EvtType.EVT_API_CALL_EXECUTED:
        onApiCallExecuted(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_REQUEST_TOKEN:
        handler.onRequestToken();
        break;
      case RtcEngineEvent.EvtType.EVT_CLIENT_ROLE_CHANGED:
        RtcEngineMessage.PClientRoleChanged pcrc = new RtcEngineMessage.PClientRoleChanged();
        pcrc.unmarshall(evt);
        handler.onClientRoleChanged(pcrc.oldRole, pcrc.newRole);
        break;
      case RtcEngineEvent.EvtType.EVT_PUBLISH_STREAM_STATE:
        RtcEngineMessage.PStreamPublishState sps = new RtcEngineMessage.PStreamPublishState();
        sps.unmarshall(evt);
        handler.onRtmpStreamingStateChanged(sps.url,
            IRtcEngineEventHandler.RTMP_STREAM_PUBLISH_STATE.fromInt(sps.state),
            IRtcEngineEventHandler.RTMP_STREAM_PUBLISH_ERROR.fromInt(sps.error));
        break;
      case RtcEngineEvent.EvtType.EVT_PUBLISH_URL:
        RtcEngineMessage.PStreamPublished psp = new RtcEngineMessage.PStreamPublished();
        psp.unmarshall(evt);
        handler.onStreamPublished(psp.url, psp.error);
        break;
      case RtcEngineEvent.EvtType.EVT_UNPUBLISH_URL:
        RtcEngineMessage.PStreamUnPublished psup = new RtcEngineMessage.PStreamUnPublished();
        psup.unmarshall(evt);
        handler.onStreamUnpublished(psup.url);
        break;
      case RtcEngineEvent.EvtType.EVT_LIVE_TRANSCODING:
        handler.onTranscodingUpdated();
        break;
      case RtcEngineEvent.EvtType.EVT_STREAM_INJECTED_STATUS:
        RtcEngineMessage.PStreamInjectedStatus sis = new RtcEngineMessage.PStreamInjectedStatus();
        sis.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onStreamInjectedStatus(sis.url, sis.userId, sis.status);
        break;
      case RtcEngineEvent.EvtType.EVT_PRIVILEGE_WILL_EXPIRE:
        RtcEngineMessage.PPrivilegeWillExpire ppwe = new RtcEngineMessage.PPrivilegeWillExpire();
        ppwe.unmarshall(evt);
        handler.onTokenPrivilegeWillExpire(ppwe.token);
        break;
      case RtcEngineEvent.EvtType.EVT_OPEN_CHANNEL_SUCCESS:
        RtcEngineMessage.PMediaResJoinMedia pmjm = new RtcEngineMessage.PMediaResJoinMedia();
        pmjm.unmarshall(evt);
        if (pmjm.firstSuccess) {
          ((IRtcEngineEventHandler) handler)
              .onJoinChannelSuccess(pmjm.channel, pmjm.uid, pmjm.elapsed);
        } else {
          ((IRtcEngineEventHandler) handler)
              .onRejoinChannelSuccess(pmjm.channel, pmjm.uid, pmjm.elapsed);
        }
        break;
      case RtcEngineEvent.EvtType.EVT_LEAVE_CHANNEL:
        RtcEngineMessage.PMediaResRtcStats rtcStats2 = new RtcEngineMessage.PMediaResRtcStats();
        rtcStats2.unmarshall(evt);
        updateRtcStats(rtcStats2);
        handler.onLeaveChannel(getRtcStats());
        break;
      case RtcEngineEvent.EvtType.EVT_NETWORK_QUALITY:
        RtcEngineMessage.PMediaResNetworkQuality nq =
            new RtcEngineMessage.PMediaResNetworkQuality();
        nq.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onNetworkQuality(nq.uid, nq.txQuality, nq.rxQuality);
        break;
      case RtcEngineEvent.EvtType.EVT_NETWORK_TYPE_CHANGED:
        RtcEngineMessage.PNetworkTypeChanged ntc = new RtcEngineMessage.PNetworkTypeChanged();
        ntc.unmarshall(evt);
        handler.onNetworkTypeChanged(ntc.type);
        break;
      case RtcEngineEvent.EvtType.EVT_USER_OFFLINE:
        RtcEngineMessage.PMediaResUserOfflineEvent euo =
            new RtcEngineMessage.PMediaResUserOfflineEvent();
        euo.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onUserOffline(euo.uid, euo.reason);
        break;
      case RtcEngineEvent.EvtType.EVT_RTC_STATS:
        RtcEngineMessage.PMediaResRtcStats rtcStats = new RtcEngineMessage.PMediaResRtcStats();
        rtcStats.unmarshall(evt);
        updateRtcStats(rtcStats);
        handler.onRtcStats(getRtcStats());
        break;
      case RtcEngineEvent.EvtType.EVT_USER_JOINED:
        RtcEngineMessage.PMediaResUserJoinedEvent euj =
            new RtcEngineMessage.PMediaResUserJoinedEvent();
        euj.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onUserJoined(euj.uid, euj.elapsed);
        break;
      case RtcEngineEvent.EvtType.EVT_USER_MUTE_AUDIO:
        RtcEngineMessage.PMediaResUserState euma = new RtcEngineMessage.PMediaResUserState();
        euma.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onUserMuteAudio(euma.uid, euma.state);
        break;
      case RtcEngineEvent.EvtType.EVT_USER_MUTE_VIDEO:
        RtcEngineMessage.PMediaResUserState eumv = new RtcEngineMessage.PMediaResUserState();
        eumv.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onUserMuteVideo(eumv.uid, eumv.state);
        break;
      case RtcEngineEvent.EvtType.EVT_USER_ENABLE_VIDEO:
        RtcEngineMessage.PMediaResUserState euev = new RtcEngineMessage.PMediaResUserState();
        euev.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onUserEnableVideo(euev.uid, euev.state);
        break;
      case RtcEngineEvent.EvtType.EVT_LASTMILE_QUALITY:
        RtcEngineMessage.PMediaResLastmileQuality lq =
            new RtcEngineMessage.PMediaResLastmileQuality();
        lq.unmarshall(evt);
        handler.onLastmileQuality(lq.quality);
        break;
      case RtcEngineEvent.EvtType.EVT_LASTMILE_PROBE_RESULT:
        RtcEngineMessage.PMediaResLastmileProbeResult result =
            new RtcEngineMessage.PMediaResLastmileProbeResult();
        result.unmarshall(evt);
        IRtcEngineEventHandler.LastmileProbeResult r =
            new IRtcEngineEventHandler.LastmileProbeResult();

        r.state = result.state;
        r.rtt = result.rtt;
        r.uplinkReport.packetLossRate = result.uplinkReport.packetLossRate;
        r.uplinkReport.jitter = result.uplinkReport.jitter;
        r.uplinkReport.availableBandwidth = result.uplinkReport.availableBandwidth;
        r.downlinkReport.packetLossRate = result.downlinkReport.packetLossRate;
        r.downlinkReport.jitter = result.downlinkReport.jitter;
        r.downlinkReport.availableBandwidth = result.downlinkReport.availableBandwidth;
        handler.onLastmileProbeResult(r);
        break;
      case RtcEngineEvent.EvtType.EVT_UPLINK_NETWORK_INFO_UPDATE:
        RtcEngineMessage.PUplinkNetworkInfoUpdated uip =
            new RtcEngineMessage.PUplinkNetworkInfoUpdated();
        uip.unmarshall(evt);
        IRtcEngineEventHandler.UplinkNetworkInfo info =
            new IRtcEngineEventHandler.UplinkNetworkInfo();

        info.video_encoder_target_bitrate_bps = uip.videoEncoderTargetBitrateBps;
        handler.onUplinkNetworkInfoUpdated(info);
        break;
      case RtcEngineEvent.EvtType.EVT_DOWNLINK_NETWORK_INFO_UPDATE:
        RtcEngineMessage.PDownlinkNetworkInfoUpdated diu =
            new RtcEngineMessage.PDownlinkNetworkInfoUpdated();
        diu.unmarshall(evt);
        IRtcEngineEventHandler.DownlinkNetworkInfo network_info =
            new IRtcEngineEventHandler.DownlinkNetworkInfo();

        network_info.lastmile_buffer_delay_time_ms = diu.lastmile_buffer_delay_time_ms;
        network_info.bandwidth_estimation_bps = diu.bandwidth_estimation_bps;
        handler.onDownlinkNetworkInfoUpdated(network_info);
        break;
      case RtcEngineEvent.EvtType.EVT_AUDIO_EFFECT_FINISHED:
        RtcEngineMessage.PMediaResAudioEffectFinished aef =
            new RtcEngineMessage.PMediaResAudioEffectFinished();
        aef.unmarshall(evt);
        handler.onAudioEffectFinished(aef.soundId);
        break;
      case RtcEngineEvent.EvtType.EVT_USER_ENABLE_LOCAL_VIDEO:
        RtcEngineMessage.PMediaResUserState euelv = new RtcEngineMessage.PMediaResUserState();
        euelv.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onUserEnableLocalVideo(euelv.uid, euelv.state);
        break;
      case RtcEngineEvent.EvtType.EVT_AUDIO_VOLUME_INDICATION:
        onSpeakersReport(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_FIRST_REMOTE_AUDIO_FRAME:
        RtcEngineMessage.PFirstRemoteAudioFrame efraf =
            new RtcEngineMessage.PFirstRemoteAudioFrame();
        efraf.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onFirstRemoteAudioFrame(efraf.uid, efraf.elapsed);
        break;
      case RtcEngineEvent.EvtType.EVT_FIRST_REMOTE_AUDIO_DECODED:
        RtcEngineMessage.PFirstRemoteAudioDecoded frad =
            new RtcEngineMessage.PFirstRemoteAudioDecoded();
        frad.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onFirstRemoteAudioDecoded(frad.uid, frad.elapsed);
        break;
      case RtcEngineEvent.EvtType.EVT_FIRST_REMOTE_VIDEO_FRAME:
        onFirstRemoteVideoFrame(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_LOCAL_VIDEO_STAT:
        onLocalVideoStat(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_REMOTE_VIDEO_STAT:
        onRemoteVideoStat(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_FIRST_LOCAL_VIDEO_FRAME:
        onFirstLocalVideoFrame(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_FIRST_REMOTE_VIDEO_DECODED:
        onFirstRemoteVideoDecoded(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_CONNECTION_LOST:
        handler.onConnectionLost();
        break;
      case RtcEngineEvent.EvtType.EVT_STREAM_MESSAGE:
        onStreamMessage(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_CONNECTION_INTERRUPTED:
        handler.onConnectionInterrupted();
        break;
      case RtcEngineEvent.EvtType.EVT_QUERY_RECORDING_SERVICE_STATUS: {
        RtcEngineMessage.PRecordingServiceStatus cmd =
            new RtcEngineMessage.PRecordingServiceStatus();
        cmd.unmarshall(evt);
        handler.onRefreshRecordingServiceStatus(cmd.status);
      } break;
      case RtcEngineEvent.EvtType.EVT_STREAM_MESSAGE_ERROR:
        onStreamMessageError(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_RHYTHM_PLAYFR_STATE_CHANGED:
        onRhythmPlayerStateChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_VIDEO_SIZE_CHANGED:
        onVideoSizeChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_FIRST_LOCAL_AUDIO_FRAME_PUBLISHED:
        onFirstLocalAudioFramePublished(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_FIRST_LOCAL_VIDEO_FRAME_PUBLISHED:
        onFirstLocalVideoFramePublished(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_ACTIVE_SPEAKER:
        RtcEngineMessage.PActiveSpeaker eas = new RtcEngineMessage.PActiveSpeaker();
        eas.unmarshall(evt);
        ((IRtcEngineEventHandler) handler).onActiveSpeaker(eas.uid);
        break;
      case RtcEngineEvent.EvtType.EVT_CONNECTION_BANNED:
        handler.onConnectionBanned();
        break;
      case RtcEngineEvent.EvtType.EVT_CAMERA_FOCUS_AREA_CHANGED:
        onCameraFocusAreaChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_CAMERA_EXPOSURE_AREA_CHANGED:
        onCameraExposureAreaChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_FACE_DETECT_VALUE:
        onFacePositionChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_SNAPSHOT_TAKEN_VALUE:
        onSnapshotTaken(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_CONTENT_INSPECT_RESULT_VALUE:
        onContentInspectResult(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_REMOTE_VIDEO_STATE_CHANGED:
        onRemoteVideoStateChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_LOCAL_PUBLISH_FALLBACK_TO_AUDIO_ONLY:
        RtcEngineMessage.PLocalFallbackStatus lfs = new RtcEngineMessage.PLocalFallbackStatus();
        lfs.unmarshall(evt);
        handler.onLocalPublishFallbackToAudioOnly(lfs.state);
        break;
      case RtcEngineEvent.EvtType.EVT_REMOTE_SUBSCRIBE_FALLBACK_TO_AUDIO_ONLY:
        RtcEngineMessage.PMediaResUserState erfsc = new RtcEngineMessage.PMediaResUserState();
        erfsc.unmarshall(evt);
        ((IRtcEngineEventHandler) handler)
            .onRemoteSubscribeFallbackToAudioOnly(erfsc.uid, erfsc.state);
        break;
      case RtcEngineEvent.EvtType.EVT_USER_TRANSPORT_STAT:
        RtcEngineMessage.PUserTransportStat ts = new RtcEngineMessage.PUserTransportStat();
        ts.unmarshall(evt);
        if (ts.isAudio) {
          ((IRtcEngineEventHandler) handler)
              .onRemoteAudioTransportStats(ts.peer_uid, ts.delay, ts.lost, ts.rxKBitRate);
        } else {
          ((IRtcEngineEventHandler) handler)
              .onRemoteVideoTransportStats(ts.peer_uid, ts.delay, ts.lost, ts.rxKBitRate);
        }
        break;
      case RtcEngineEvent.EvtType.EVT_REMOTE_AUDIO_STATE_CHANGED:
        onRemoteAudioStateChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_LOCAL_AUDIO_STATE_CHANGED:
        RtcEngineMessage.PLocalAudioState audioState = new RtcEngineMessage.PLocalAudioState();
        audioState.unmarshall(evt);
        ((IRtcEngineEventHandler) handler)
            .onLocalAudioStateChanged(
                IRtcEngineEventHandler.LOCAL_AUDIO_STREAM_STATE.values()[audioState.state],
                IRtcEngineEventHandler.LOCAL_AUDIO_STREAM_ERROR.values()[audioState.errorCode]);
        break;
      case RtcEngineEvent.EvtType.EVT_LOCAL_VIDEO_STATE_CHANGED:
        RtcEngineMessage.PLocalVideoState videoState = new RtcEngineMessage.PLocalVideoState();
        videoState.unmarshall(evt);
        ((IRtcEngineEventHandler) handler)
            .onLocalVideoStateChanged(videoState.state, videoState.errorCode);
        break;
      case RtcEngineEvent.EvtType.EVT_CROSS_CHANNEL_STATE:
        onChannelMediaRelayStateChanged(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_CROSS_CHANNEL_EVENT:
        onChannelMediaRelayEvent(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_LOCAL_AUDIO_STAT:
        onLocalAudioStat(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_REMOTE_AUDIO_STAT:
        onRemoteAudioStat(evt, handler);
        break;
      case RtcEngineEvent.EvtType.EVT_CONNECTION_STATE_CHANGED:
        RtcEngineMessage.PConnectionState cs = new RtcEngineMessage.PConnectionState();
        cs.unmarshall(evt);
        handler.onConnectionStateChanged(cs.state, cs.reason);
        break;
      case RtcEngineEvent.EvtType.EVT_AUDIO_ROUTING_CHANGED:
        RtcEngineMessage.PAudioRoutingChanged arc = new RtcEngineMessage.PAudioRoutingChanged();
        arc.unmarshall(evt);
        handler.onAudioRouteChanged(arc.routing);
        break;
      case RtcEngineEvent.EvtType.EVT_AUDIO_MIXING_STATE_CHANGED:
        RtcEngineMessage.PAudioMixingStateChanged amsc =
            new RtcEngineMessage.PAudioMixingStateChanged();
        amsc.unmarshall(evt);
        handler.onAudioMixingStateChanged(amsc.state, amsc.errorCode);
        break;
      case RtcEngineEvent.EvtType.EVT_INTRA_REQUEST_RECEIVED:
        handler.onIntraRequestReceived();
        break;
      case RtcEngineEvent.EvtType.EVT_ENCRYPTION_ERROR:
        RtcEngineMessage.PEncryptionError encryptError = new RtcEngineMessage.PEncryptionError();
        encryptError.unmarshall(evt);
        handler.onEncryptionError(
            IRtcEngineEventHandler.ENCRYPTION_ERROR_TYPE.values()[encryptError.errorType]);
        break;
      case RtcEngineEvent.EvtType.EVT_PERMISSION_ERROR:
        RtcEngineMessage.PPermissionError permissionError = new RtcEngineMessage.PPermissionError();
        permissionError.unmarshall(evt);
        handler.onPermissionError(
            IRtcEngineEventHandler.PERMISSION.values()[permissionError.permission]);
        break;
      case RtcEngineEvent.EvtType.EVT_LOCAL_USER_REGISTERED: {
        RtcEngineMessage.PUserInfoState m = new RtcEngineMessage.PUserInfoState();
        m.unmarshall(evt);
        handler.onLocalUserRegistered(m.uid, m.userAccount);
        break;
      }
      case RtcEngineEvent.EvtType.EVT_USER_INFO_UPDATED: {
        RtcEngineMessage.PUserInfoState m = new RtcEngineMessage.PUserInfoState();
        m.unmarshall(evt);
        UserInfo userInfo = new UserInfo(m.uid, m.userAccount);
        handler.onUserInfoUpdated(m.uid, userInfo);
        break;
      }
      case RtcEngineEvent.EvtType.EVT_AUDIO_SUBSCRIBE_STATE_CHANGED:
        RtcEngineMessage.PSubscribeAudioStateChanged subscribeAudio =
            new RtcEngineMessage.PSubscribeAudioStateChanged();
        subscribeAudio.unmarshall(evt);
        handler.onAudioSubscribeStateChanged(subscribeAudio.channelId, subscribeAudio.uid,
            IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE.values()[subscribeAudio.oldState],
            IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE.values()[subscribeAudio.newState],
            subscribeAudio.elapseSinceLastState);
        break;
      case RtcEngineEvent.EvtType.EVT_VIDEO_SUBSCRIBE_STATE_CHANGED:
        RtcEngineMessage.PSubscribeVideoStateChanged subscribeVideo =
            new RtcEngineMessage.PSubscribeVideoStateChanged();
        subscribeVideo.unmarshall(evt);
        handler.onVideoSubscribeStateChanged(subscribeVideo.channelId, subscribeVideo.uid,
            IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE.values()[subscribeVideo.oldState],
            IRtcEngineEventHandler.STREAM_SUBSCRIBE_STATE.values()[subscribeVideo.newState],
            subscribeVideo.elapseSinceLastState);
        break;
      case RtcEngineEvent.EvtType.EVT_AUDIO_PUBLISH_STATE_CHANGED:
        RtcEngineMessage.PPublishAudioStateChanged publishAudio =
            new RtcEngineMessage.PPublishAudioStateChanged();
        publishAudio.unmarshall(evt);
        handler.onAudioPublishStateChanged(publishAudio.channelId,
            IRtcEngineEventHandler.STREAM_PUBLISH_STATE.values()[publishAudio.oldState],
            IRtcEngineEventHandler.STREAM_PUBLISH_STATE.values()[publishAudio.newState],
            publishAudio.elapseSinceLastState);
        break;
      case RtcEngineEvent.EvtType.EVT_VIDEO_PUBLISH_STATE_CHANGED:
        RtcEngineMessage.PPublishVideoStateChanged publishVideo =
            new RtcEngineMessage.PPublishVideoStateChanged();
        publishVideo.unmarshall(evt);
        handler.onVideoPublishStateChanged(publishVideo.channelId,
            IRtcEngineEventHandler.STREAM_PUBLISH_STATE.values()[publishVideo.oldState],
            IRtcEngineEventHandler.STREAM_PUBLISH_STATE.values()[publishVideo.newState],
            publishVideo.elapseSinceLastState);
        break;
      case RtcEngineEvent.EvtType.EVT_UPLOAD_LOG_RESULT:
        RtcEngineMessage.PUploadLogResult uploadResult = new RtcEngineMessage.PUploadLogResult();
        uploadResult.unmarshall(evt);
        handler.onUploadLogResult(
            uploadResult.requestId, uploadResult.success, uploadResult.reason);
        break;
      default:
        break;
    }
  }

  private void onApiCallExecuted(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PApiCallExecuted r = new RtcEngineMessage.PApiCallExecuted();
    r.unmarshall(evt);
    handler.onApiCallExecuted(r.error, r.api, r.result);
  }

  private void onFirstRemoteVideoDecoded(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PFirstRemoteVideoDecoded v = new RtcEngineMessage.PFirstRemoteVideoDecoded();
    v.unmarshall(evt);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler)
          .onFirstRemoteVideoDecoded(v.uid, v.width, v.height, v.elapsed);
    }
  }

  private void onCameraFocusAreaChanged(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PCameraFocusAreaChanged v = new RtcEngineMessage.PCameraFocusAreaChanged();
    v.unmarshall(evt);
    handler.onCameraFocusAreaChanged(new Rect(v.x, v.y, v.x + v.width, v.y + v.height));
  }

  private void onCameraExposureAreaChanged(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PCameraExposureAreaChanged v =
        new RtcEngineMessage.PCameraExposureAreaChanged();
    v.unmarshall(evt);
    handler.onCameraExposureAreaChanged(new Rect(v.x, v.y, v.x + v.width, v.y + v.height));
  }
  private void onSnapshotTaken(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PSnapshotTaken m = new RtcEngineMessage.PSnapshotTaken();
    m.unmarshall(evt);
    handler.onSnapshotTaken(m.channel, m.uid, m.filepath, m.width, m.height, m.errCode);
  }
  private void onContentInspectResult(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PContentInspectResult m = new RtcEngineMessage.PContentInspectResult();
    m.unmarshall(evt);
    handler.onContentInspectResult(m.result);
  }
  private void onFacePositionChanged(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PFacePositionChanged v = new RtcEngineMessage.PFacePositionChanged();
    v.unmarshall(evt);
    IRtcEngineEventHandler.AgoraFacePositionInfo[] faceRectArr = null;

    if (v.rectArr != null && v.rectArr.length > 0) {
      faceRectArr = new IRtcEngineEventHandler.AgoraFacePositionInfo[v.rectArr.length];

      for (int i = 0; i < v.rectArr.length; i++) {
        RtcEngineMessage.PFacePositionChanged.FaceRect rect = v.rectArr[i];
        IRtcEngineEventHandler.AgoraFacePositionInfo faceInfo =
            new IRtcEngineEventHandler.AgoraFacePositionInfo();
        faceInfo.x = rect.x;
        faceInfo.y = rect.y;
        faceInfo.width = rect.width;
        faceInfo.height = rect.height;
        faceInfo.distance = v.disArr[i];

        faceRectArr[i] = faceInfo;
      }
    } else {
      faceRectArr = new IRtcEngineEventHandler.AgoraFacePositionInfo[0];
    }
    handler.onFacePositionChanged(v.imageWidth, v.imageHeight, faceRectArr);
  }

  private void onRhythmPlayerStateChanged(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PRhythmPlayerStateChanged rpsc =
        new RtcEngineMessage.PRhythmPlayerStateChanged();
    rpsc.unmarshall(evt);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler)
          .onRhythmPlayerStateChanged(
              IRtcEngineEventHandler.RHYTHM_PLAYER_STATE_TYPE.fromInt(rpsc.state),
              IRtcEngineEventHandler.RHYTHM_PLAYER_ERROR_TYPE.fromInt(rpsc.errorCode));
    }
  }

  private void onVideoSizeChanged(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PVideoSizeChanged v = new RtcEngineMessage.PVideoSizeChanged();
    v.unmarshall(evt);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler).onVideoSizeChanged(v.uid, v.width, v.height, v.rotation);
    }
  }

  private void onRemoteVideoStateChanged(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PRemoteVideoState m = new RtcEngineMessage.PRemoteVideoState();
    m.unmarshall(evt);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler)
          .onRemoteVideoStateChanged(m.uid, m.state, m.reason, m.elapsed);
    }
  }

  private void onStreamMessage(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PStreamMessage v = new RtcEngineMessage.PStreamMessage();
    v.unmarshall(evt);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler).onStreamMessage(v.uid, v.streamId, v.payload);
    }
  }

  private void onStreamMessageError(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PStreamMessageError v = new RtcEngineMessage.PStreamMessageError();
    v.unmarshall(evt);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler)
          .onStreamMessageError(v.uid, v.streamId, v.error, v.missed, v.cached);
    }
  }

  private void onFirstLocalVideoFrame(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PFirstLocalVideoFrame v = new RtcEngineMessage.PFirstLocalVideoFrame();
    v.unmarshall(evt);
    handler.onFirstLocalVideoFrame(v.width, v.height, v.elapsed);
  }

  private void onRemoteVideoStat(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PRemoteVideoStat v = new RtcEngineMessage.PRemoteVideoStat();
    v.unmarshall(data);
    handler.onRemoteVideoStats(v.stats);
  }

  private void onRemoteAudioStat(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PRemoteAudioStat v = new RtcEngineMessage.PRemoteAudioStat();
    v.unmarshall(data);
    if (v.stats.uid == 0)
      return;
    handler.onRemoteAudioStats(v.stats);
  }

  private void onLocalVideoStat(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PLocalVideoStat v = new RtcEngineMessage.PLocalVideoStat();
    v.unmarshall(data);
    handler.onLocalVideoStats(v.stats);
  }

  private void onLocalAudioStat(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PLocalAudioStat v = new RtcEngineMessage.PLocalAudioStat();
    v.unmarshall(data);
    handler.onLocalAudioStats(v.stats);
  }

  private void onFirstRemoteVideoFrame(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PFirstRemoteVideoFrame v = new RtcEngineMessage.PFirstRemoteVideoFrame();
    v.unmarshall(data);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler)
          .onFirstRemoteVideoFrame(v.uid, v.width, v.height, v.elapsed);
    }
  }

  private void onFirstLocalAudioFramePublished(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PFirstLocalAudioFrame v = new RtcEngineMessage.PFirstLocalAudioFrame();
    v.unmarshall(data);
    handler.onFirstLocalAudioFramePublished(v.elapsed);
  }

  private void onFirstLocalVideoFramePublished(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PFirstLocalAudioFrame v = new RtcEngineMessage.PFirstLocalAudioFrame();
    v.unmarshall(data);
    handler.onFirstLocalVideoFramePublished(v.elapsed);
  }

  private void onRemoteAudioStateChanged(byte[] evt, IAgoraEventHandler handler) {
    RtcEngineMessage.PRemoteAudioState m = new RtcEngineMessage.PRemoteAudioState();
    m.unmarshall(evt);
    if (handler instanceof IRtcEngineEventHandler) {
      ((IRtcEngineEventHandler) handler)
          .onRemoteAudioStateChanged(m.uid,
              IRtcEngineEventHandler.REMOTE_AUDIO_STATE.values()[m.state],
              IRtcEngineEventHandler.REMOTE_AUDIO_STATE_REASON.values()[m.reason], m.elapsed);
    }
  }

  private void onChannelMediaRelayStateChanged(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PCrossChannelState c = new RtcEngineMessage.PCrossChannelState();
    c.unmarshall(data);
    handler.onChannelMediaRelayStateChanged(c.state, c.code);
  }

  private void onChannelMediaRelayEvent(byte[] data, IAgoraEventHandler handler) {
    RtcEngineMessage.PCrossChannelEvent c = new RtcEngineMessage.PCrossChannelEvent();
    c.unmarshall(data);
    handler.onChannelMediaRelayEvent(c.code);
  }

  private void onSpeakersReport(byte[] evt, IAgoraEventHandler handler) {
    if (evt == null)
      return;
    RtcEngineMessage.PMediaResSpeakersReport report =
        new RtcEngineMessage.PMediaResSpeakersReport();
    report.unmarshall(evt);
    if (report.speakers != null && report.speakers.length >= 0) {
      IRtcEngineEventHandler.AudioVolumeInfo[] speakers =
          new IRtcEngineEventHandler.AudioVolumeInfo[report.speakers.length];
      for (int i = 0; i < report.speakers.length; i++) {
        speakers[i] = new IRtcEngineEventHandler.AudioVolumeInfo();
        speakers[i].uid = report.speakers[i].uid;
        speakers[i].volume = report.speakers[i].volume;
        speakers[i].vad = report.speakers[i].vad;
        speakers[i].voicePitch = report.speakers[i].voicePitch;
      }
      handler.onAudioVolumeIndication(speakers, report.mixVolume);
    } else {
      handler.onAudioVolumeIndication(
          new IRtcEngineEventHandler.AudioVolumeInfo[0], report.mixVolume);
    }
  }

  private void sendLogEvent(byte[] evt) {
    try {
      String msg = new String(evt, "ISO-8859-1");
      onLogEvent(0, msg);
    } catch (UnsupportedEncodingException e) {
    }
  }

  @Override
  public synchronized int createDataStream(boolean reliable, boolean ordered) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return createDataStreamEx(reliable, ordered, null);
  }

  @Override
  public synchronized int createDataStreamEx(
      boolean reliable, boolean ordered, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeCreateDataStream(
        mNativeHandle, reliable, ordered, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int createDataStream(DataStreamConfig config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return createDataStreamEx(config, null);
  }

  @Override
  public synchronized int createDataStreamEx(DataStreamConfig config, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeCreateDataStream2(mNativeHandle, config.ordered, config.syncWithAudio,
        getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int sendStreamMessage(int streamId, byte[] message) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return sendStreamMessageEx(streamId, message, null);
  }

  @Override
  public synchronized int sendStreamMessageEx(
      int streamId, byte[] message, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSendStreamMessage(
        mNativeHandle, streamId, message, getChannelId(connection), getUserId(connection));
  }

  /*
   * External video source related functions: updateSharedContext and setTextureId
   * is the older interface, will deprecated in the future.
   */
  public synchronized int updateSharedContext(EGLContext sharedContext) {
    return -Constants.ERR_NOT_SUPPORTED;
  }

  public synchronized int updateSharedContext(android.opengl.EGLContext sharedContext) {
    return -Constants.ERR_NOT_SUPPORTED;
  }

  // for forwards Compatibility, this interface only support TEXTURE_2D
  public synchronized int setTextureId(
      int id, EGLContext sharedContext, int width, int height, long ts) {
    return -Constants.ERR_NOT_SUPPORTED;
  }

  // for forwards Compatibility, this interface only support TEXTURE_2D
  public synchronized int setTextureId(
      int id, android.opengl.EGLContext sharedContext, int width, int height, long ts) {
    return -Constants.ERR_NOT_SUPPORTED;
  }

  public synchronized int setTextureIdWithMatrix(int id, EGLContext sharedContext, int format,
      int width, int height, long ts, float[] matrix) {
    return -Constants.ERR_NOT_SUPPORTED;
  }

  public synchronized int setTextureIdWithMatrix(int id, android.opengl.EGLContext sharedContext,
      int format, int width, int height, long ts, float[] matrix) {
    return -Constants.ERR_NOT_SUPPORTED;
  }

  @Override
  public synchronized boolean isTextureEncodeSupported() {
    return DeviceUtils.getRecommendedEncoderType() == Constants.HARDWARE_ENCODER;
  }

  @Override
  public synchronized int setExternalVideoSource(
      boolean enable, boolean useTexture, Constants.ExternalVideoSourceType sourceType) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return setExternalVideoSource(enable, useTexture, sourceType, null);
  }

  @Override
  public synchronized int setExternalVideoSource(boolean enable, boolean useTexture,
      Constants.ExternalVideoSourceType sourceType, EncodedVideoTrackOptions encoded_opt) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetExternalVideoSource(mNativeHandle, enable, useTexture,
        Constants.ExternalVideoSourceType.getValue(sourceType), encoded_opt);
  }

  @Override
  public synchronized boolean pushExternalVideoFrame(AgoraVideoFrame frame) {
    return pushExternalVideoFrameEx(frame, null) == Constants.ERR_OK;
  }

  @Override
  public synchronized int pushExternalVideoFrameEx(
      AgoraVideoFrame frame, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (frame == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativePushExternalAgoraVideoFrame(mNativeHandle, frame.format, frame.buf, frame.stride,
        frame.height, frame.cropLeft, frame.cropTop, frame.cropRight, frame.cropBottom,
        frame.rotation, frame.timeStamp, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized boolean pushExternalVideoFrame(VideoFrame frame) {
    int result = pushExternalVideoFrameEx(frame, null);
    if (result != Constants.ERR_OK) {
      Logging.e(TAG, "Failed to pushExternalVideoFrame, " + result);
      return false;
    }
    return true;
  }

  @Override
  public synchronized int pushExternalVideoFrameEx(VideoFrame frame, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (frame == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativePushExternalVideoFrame(
        mNativeHandle, frame, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int pushExternalEncodedVideoFrame(
      ByteBuffer data, EncodedVideoFrameInfo frameInfo) {
    return pushExternalEncodedVideoFrameEx(data, frameInfo, null);
  }

  @Override
  public synchronized int pushExternalEncodedVideoFrameEx(
      ByteBuffer data, EncodedVideoFrameInfo frameInfo, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (!data.isDirect()) {
      throw new IllegalArgumentException("data must be direct buffer!");
    }
    return nativePushExternalEncodedVideoFrame(
        mNativeHandle, data, frameInfo, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int registerVideoEncodedImageReceiver(IVideoEncodedImageReceiver receiver) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (receiver == null) {
      Logging.e(TAG, "Failed to registerVideoEncodedImageReceiver, observer null");
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeRegisterVideoEncodedImageReceiver(mNativeHandle, receiver);
  }

  @Override
  public synchronized int addPublishStreamUrl(String url, boolean transcodingEnabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeAddPublishStreamUrl(mNativeHandle, url, transcodingEnabled);
  }

  @Override
  public synchronized int removePublishStreamUrl(String url) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeRemovePublishStreamUrl(mNativeHandle, url);
  }

  @Override
  public synchronized int setLiveTranscoding(LiveTranscoding transcoding) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (transcoding == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }

    if (transcoding.getUsers() != null) {
      for (LiveTranscoding.TranscodingUser user : transcoding.getUsers()) {
        if (user.uid == 0) {
          return -Constants.ERR_INVALID_ARGUMENT;
        }

        if (user.width <= 0 || user.height <= 0) {
          throw new IllegalArgumentException("transcoding user's width and height must be >0");
        }
      }
    }
    RtcEngineMessage.PLiveTranscoding pt = new RtcEngineMessage.PLiveTranscoding();
    byte[] data = pt.marshall(transcoding);
    return nativeSetLiveTranscoding(mNativeHandle, data);
  }

  @Override
  public synchronized int addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (url == null || config == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    RtcEngineMessage.PInjectStreamConfig pi = new RtcEngineMessage.PInjectStreamConfig();
    byte[] data = pi.marshall(config);
    return nativeAddInjectStreamUrl(mNativeHandle, url, data);
  }

  @Override
  public synchronized int removeInjectStreamUrl(String url) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (url == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeRemoveInjectStreamUrl(mNativeHandle, url);
  }

  @Override
  public synchronized int startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (!checkRelayConfiguration(channelMediaRelayConfiguration)) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    Map<String, ChannelMediaInfo> descInfos =
        channelMediaRelayConfiguration.getDestChannelMediaInfos();
    ChannelMediaInfo[] descInfosArray = new ChannelMediaInfo[descInfos.size()];
    descInfos.values().toArray(descInfosArray);
    return nativeStartChannelMediaRelay(
        mNativeHandle, channelMediaRelayConfiguration.getSrcChannelMediaInfo(), descInfosArray);
  }

  @Override
  public synchronized int stopChannelMediaRelay() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopChannelMediaRelay(mNativeHandle);
  }

  @Override
  public synchronized int pauseAllChannelMediaRelay() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativePauseAllChannelMediaRelay(mNativeHandle);
  }

  @Override
  public synchronized int resumeAllChannelMediaRelay() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeResumeAllChannelMediaRelay(mNativeHandle);
  }

  @Override
  public synchronized int updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (!checkRelayConfiguration(channelMediaRelayConfiguration)) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    Map<String, ChannelMediaInfo> descInfos =
        channelMediaRelayConfiguration.getDestChannelMediaInfos();
    ChannelMediaInfo[] descInfosArray = new ChannelMediaInfo[descInfos.size()];
    descInfos.values().toArray(descInfosArray);
    return nativeUpdateChannelMediaRelay(
        mNativeHandle, channelMediaRelayConfiguration.getSrcChannelMediaInfo(), descInfosArray);
  }

  private boolean checkRelayConfiguration(ChannelMediaRelayConfiguration relayConfiguration) {
    if (relayConfiguration == null || relayConfiguration.getSrcChannelMediaInfo() == null
        || relayConfiguration.getDestChannelMediaInfos() == null
        || relayConfiguration.getDestChannelMediaInfos().isEmpty()
        || relayConfiguration.getDestChannelMediaInfos().size()
            > Constants.MAX_CROSS_DEST_CHANNEL_SIZE) {
      return false;
    }

    Map<String, ChannelMediaInfo> descInfos = relayConfiguration.getDestChannelMediaInfos();
    for (ChannelMediaInfo info : descInfos.values()) {
      if (info == null || TextUtils.isEmpty(info.getChannelName())) {
        return false;
      }
    }
    return true;
  }

  @Override
  public synchronized long getNativeHandle() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeGetRtcEngine(mNativeHandle);
  }

  @Deprecated
  @Override
  public synchronized int configPublisher(PublisherConfiguration configuration) {
    if (!configuration.validate()) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    mConfiguration = configuration;
    return 0;
  }

  @Deprecated
  @Override
  public synchronized int setVideoCompositingLayout(VideoCompositingLayout layout) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (layout == null || layout.regions == null)
      return -Constants.ERR_INVALID_ARGUMENT;
    for (int i = 0; i < layout.regions.length; i++) {
      if (layout.regions[i] == null || layout.regions[i].uid == 0 || layout.regions[i].width <= 0
          || layout.regions[i].height <= 0)
        return -Constants.ERR_INVALID_ARGUMENT;
    }
    RtcEngineMessage.PVideoCompositingLayout pv = new RtcEngineMessage.PVideoCompositingLayout();
    return nativeSetVideoCompositingLayout(mNativeHandle, pv.marshall(layout));
  }

  @Deprecated
  @Override
  public synchronized int clearVideoCompositingLayout() {
    return setParameter("rtc.api.clear_video_compositing_layout", true);
  }

  /**
   * Begin of implementations of IAudioEffectManager
   */
  @Override
  public IAudioEffectManager getAudioEffectManager() {
    return this;
  }

  @Override
  public synchronized int setVoiceBeautifierPreset(int preset) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetVoiceBeautifierPreset(mNativeHandle, preset);
  }

  @Override
  public synchronized int setAudioEffectPreset(int preset) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioEffectPreset(mNativeHandle, preset);
  }

  @Override
  public synchronized int setVoiceConversionPreset(int preset) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetVoiceConversionPreset(mNativeHandle, preset);
  }

  @Override
  public synchronized int setAudioEffectParameters(int preset, int param1, int param2) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioEffectParameters(mNativeHandle, preset, param1, param2);
  }

  @Override
  public synchronized int setVoiceBeautifierParameters(int preset, int param1, int param2) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetVoiceBeautifierParameters(mNativeHandle, preset, param1, param2);
  }

  @Override
  public synchronized int setVoiceConversionParameters(int preset, int param1, int param2) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetVoiceConversionParameters(mNativeHandle, preset, param1, param2);
  }

  @Override
  public synchronized int setLocalVoicePitch(double pitch) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetLocalVoicePitch(mNativeHandle, pitch);
  }

  @Override
  public synchronized int setLocalVoiceEqualization(
      Constants.AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, int bandGain) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (bandFrequency == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeSetLocalVoiceEqualization(mNativeHandle, bandFrequency.getValue(), bandGain);
  }

  @Override
  public synchronized int setLocalVoiceReverb(Constants.AUDIO_REVERB_TYPE reverbKey, int value) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (reverbKey == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeSetLocalVoiceReverb(mNativeHandle, reverbKey.getValue(), value);
  }

  @Override
  public synchronized int setLocalVoiceChanger(int voiceChanger) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetLocalVoiceChanger(mNativeHandle, voiceChanger);
  }

  @Override
  public synchronized int setLocalVoiceReverbPreset(int reverbPreset) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetLocalVoiceReverbPreset(mNativeHandle, reverbPreset);
  }

  @Override
  public synchronized int setInEarMonitoringVolume(int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetInEarMonitoringVolume(mNativeHandle, volume);
  }

  @Override
  public synchronized double getEffectsVolume() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return 0.0;
    }

    return nativeGetEffectsVolume(mNativeHandle);
  }

  @Override
  public synchronized int setEffectsVolume(double volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetEffectsVolume(mNativeHandle, volume);
  }

  @Override
  public synchronized int preloadEffect(int soundId, String filePath) {
    return preloadEffect(soundId, filePath, 0);
  }

  @Override
  public synchronized int preloadEffect(int soundId, String filePath, int startPos) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (TextUtils.isEmpty(filePath)) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativePreloadEffect(mNativeHandle, soundId, filePath, startPos);
  }

  @Deprecated
  @Override
  public synchronized int playEffect(
      int soundId, String filePath, int loopCount, double pitch, double pan, double gain) {
    return playEffect(soundId, filePath, loopCount, pitch, pan, gain, false);
  }

  @Override
  public synchronized int playEffect(int soundId, String filePath, int loopCount, double pitch,
      double pan, double gain, boolean publish) {
    return playEffect(soundId, filePath, loopCount, pitch, pan, gain, publish, 0);
  }

  @Override
  public synchronized int playEffect(int soundId, String filePath, int loopCount, double pitch,
      double pan, double gain, boolean publish, int startPos) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativePlayEffectWithFilePath(
        mNativeHandle, soundId, filePath, loopCount, pitch, pan, gain, publish, startPos);
  }

  @Override
  public synchronized int playAllEffects(
      int loopCount, double pitch, double pan, double gain, boolean publish) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativePlayAllEffects(mNativeHandle, loopCount, pitch, pan, gain, publish);
  }

  @Override
  public synchronized int getVolumeOfEffect(int soundId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeGetVolumeOfEffect(mNativeHandle, soundId);
  }

  @Override
  public synchronized int setVolumeOfEffect(int soundId, double volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetVolumeOfEffect(mNativeHandle, soundId, volume);
  }

  @Override
  public synchronized int pauseEffect(int soundId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativePauseEffect(mNativeHandle, soundId);
  }

  @Override
  public synchronized int pauseAllEffects() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativePauseAllEffects(mNativeHandle);
  }

  @Override
  public synchronized int resumeEffect(int soundId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeResumeEffect(mNativeHandle, soundId);
  }

  @Override
  public synchronized int resumeAllEffects() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeResumeAllEffects(mNativeHandle);
  }

  @Override
  public synchronized int stopEffect(int soundId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopEffect(mNativeHandle, soundId);
  }

  @Override
  public synchronized int stopAllEffects() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopAllEffects(mNativeHandle);
  }

  @Override
  public synchronized int unloadEffect(int soundId) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeUnloadEffect(mNativeHandle, soundId);
  }

  @Override
  public synchronized int unloadAllEffects() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeUnloadAllEffects(mNativeHandle);
  }

  /**
   * End of implementations of IAudioEffectManager
   */

  @Override
  public synchronized int setApiCallMode(int syncCallTimeout) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetApiCallMode(mNativeHandle, syncCallTimeout);
  }

  @Override
  public synchronized int setAudioOptionParams(String params) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioOptionParams(mNativeHandle, params);
  }

  @Override
  public synchronized String getAudioOptionParams() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeGetAudioOptionParams(mNativeHandle);
  }

  @Override
  public synchronized int setAudioSessionParams(String params) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetAudioSessionParams(mNativeHandle, params);
  }

  @Override
  public synchronized String getAudioSessionParams() {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeGetAudioSessionParams(mNativeHandle);
  }

  @Override
  public synchronized int startScreenCapture(
      Intent mediaProjectionPermissionResultData, ScreenCaptureParameters parameters) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStartScreenCapture(mNativeHandle, mediaProjectionPermissionResultData, parameters);
  }

  @Override
  public synchronized int stopScreenCapture() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopScreenCapture(mNativeHandle);
  }

  @Override
  public synchronized int registerVideoFrameObserver(IVideoFrameObserver observer) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (observer == null) {
      Logging.e(TAG, "Failed to registerVideoFrameObserver, observer null");
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeRegisterVideoFrameObserver(mNativeHandle, observer);
  }

  @Override
  public synchronized int takeSnapshot(String channel, int uid, String filePath) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeTakeSnapshot(mNativeHandle, channel, uid, filePath);
  }

  @Override
  public synchronized int enableContentInspect(boolean enabled, ContentInspectConfig config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    byte[] data = null;
    if (enabled) {
      if (config == null)
        return -Constants.ERR_NOT_INITIALIZED;

      RtcEngineMessage.PContentInspectConfig pt = new RtcEngineMessage.PContentInspectConfig();
      data = pt.marshall(config);
    }
    return nativeEnableContentInspect(mNativeHandle, enabled, data);
  }
  @Override
  public void finalize() {
    if (mNativeHandle != 0) {
      nativeDestroy(mNativeHandle);
    }
  }

  @Override
  public synchronized int enableExtension(String provider, String extension, boolean enable) {
    return enableExtension(
        provider, extension, enable, Constants.MediaSourceType.UNKNOWN_MEDIA_SOURCE);
  }

  @Override
  public synchronized int enableExtension(
      String provider, String extension, boolean enable, Constants.MediaSourceType sourceType) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableExtension(
        mNativeHandle, provider, extension, enable, Constants.MediaSourceType.getValue(sourceType));
  }

  @Override
  public synchronized int setExtensionProperty(
      String provider, String extension, String key, String value) {
    return setExtensionProperty(
        provider, extension, key, value, Constants.MediaSourceType.UNKNOWN_MEDIA_SOURCE);
  }

  @Override
  public synchronized int setExtensionProperty(String provider, String extension, String key,
      String value, Constants.MediaSourceType sourceType) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetExtensionProperty(mNativeHandle, provider, extension, key, value,
        Constants.MediaSourceType.getValue(sourceType));
  }

  @Override
  public synchronized int setExtensionProviderProperty(String provider, String key, String value) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetExtensionProviderProperty(mNativeHandle, provider, key, value);
  }

  @Override
  public synchronized int registerMediaMetadataObserver(IMetadataObserver observer, int type) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (observer == null) {
      Logging.e(TAG, "Failed to registerMediaMetadataObserver, observer null");
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeRegisterMediaMetadataObserver(mNativeHandle, observer, type);
  }

  @Override
  public synchronized int unregisterMediaMetadataObserver(IMetadataObserver observer, int type) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (observer == null) {
      Logging.e(TAG, "Failed to unRegisterMediaMetadataObserver, observer null");
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeUnregisterMediaMetadataObserver(mNativeHandle, observer, type);
  }

  @Override
  public synchronized int setLogLevel(int level) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetLogLevel(mNativeHandle, level);
  }

  @Override
  public synchronized int enableExternalAudioSourceLocalPlayback(boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableExternalAudioSourceLocalPlayback(mNativeHandle, enabled);
  }

  @Override
  public synchronized int adjustCustomAudioPublishVolume(int sourceId, int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeAdjustCustomAudioPublishVolume(mNativeHandle, sourceId, volume);
  }

  @Override
  public synchronized int adjustCustomAudioPlayoutVolume(int sourceId, int volume) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeAdjustCustomAudioPlayoutVolume(mNativeHandle, sourceId, volume);
  }

  @Override
  public synchronized int startRhythmPlayer(
      String sound1, String sound2, AgoraRhythmPlayerConfig config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (TextUtils.isEmpty(sound1) || TextUtils.isEmpty(sound2) || config == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeStartRhythmPlayer(mNativeHandle, sound1, sound2, config);
  }

  @Override
  public synchronized int stopRhythmPlayer() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopRhythmPlayer(mNativeHandle);
  }

  @Override
  public synchronized int configRhythmPlayer(AgoraRhythmPlayerConfig config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (config == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativeConfigRhythmPlayer(mNativeHandle, config);
  }

  @Override
  public synchronized int enableCustomAudioLocalPlayback(int sourceId, boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableCustomAudioLocalPlayback(mNativeHandle, sourceId, enabled);
  }

  @Override
  public synchronized int enableSoundPositionIndication(boolean enabled) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeEnableSoundPositionIndication(mNativeHandle, enabled);
  }

  @Override
  public synchronized int setRemoteVoicePosition(int uid, double pan, double gain) {
    return setRemoteVoicePositionEx(uid, pan, gain, null);
  }

  @Override
  public synchronized int setRemoteVoicePositionEx(
      int uid, double pan, double gain, RtcConnection connection) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetRemoteVoicePosition(
        mNativeHandle, uid, pan, gain, getChannelId(connection), getUserId(connection));
  }

  @Override
  public synchronized int registerLocalUserAccount(String appId, String userAccount) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeRegisterLocalUserAccount(mNativeHandle, appId, userAccount);
  }

  @Override
  public synchronized int joinChannelWithUserAccount(
      String token, String channelId, String userAccount) {
    return joinChannelWithUserAccount(token, channelId, userAccount, null);
  }

  @Override
  public synchronized int joinChannelWithUserAccount(
      String token, String channelId, String userAccount, ChannelMediaOptions options) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeJoinChannelWithUserAccount(mNativeHandle, token, channelId, userAccount, options);
  }

  @Override
  public synchronized int joinChannelWithUserAccountEx(String token, String channelId,
      String userAccount, ChannelMediaOptions options, IRtcEngineEventHandler eventHandler) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    int result =
        nativeJoinChannelWithUserAccountEx(mNativeHandle, token, channelId, userAccount, options);
    if (result == Constants.ERR_OK) {
      mRtcExHandlers.put(Pair.create(channelId, userAccount), eventHandler);
    }
    return result;
  }

  @Override
  public synchronized UserInfo getUserInfoByUserAccount(String userAccount) {
    return getUserInfoByUserAccount(userAccount, null, null);
  }

  @Override
  public synchronized UserInfo getUserInfoByUserAccount(
      String userAccount, String channelId, String localUserAccount) {
    if (mNativeHandle == 0) {
      return null;
    }
    return nativeGetUserInfoByUserAccount(mNativeHandle, userAccount, channelId, localUserAccount);
  }

  @Override
  public synchronized UserInfo getUserInfoByUid(int uid) {
    return getUserInfoByUid(uid, null, null);
  }

  @Override
  public synchronized UserInfo getUserInfoByUid(
      int uid, String channelId, String localUserAccount) {
    if (mNativeHandle == 0) {
      Logging.e(TAG, "RtcEngine does not initialize or it may be destroyed");
      return null;
    }
    return nativeGetUserInfoByUid(mNativeHandle, uid, channelId, localUserAccount);
  }

  @Override
  public synchronized int setDirectCdnStreamingAudioConfiguration(int profile) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetDirectCdnStreamingAudioConfiguration(mNativeHandle, profile);
  }

  @Override
  public synchronized int setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeSetDirectCdnStreamingVideoConfiguration(mNativeHandle, config.dimensions.width,
        config.dimensions.height, config.frameRate, config.bitrate, config.minBitrate,
        config.orientationMode.getValue(), config.mirrorMode.getValue(),
        config.degradationPrefer.getValue());
  }

  @Override
  public synchronized int startDirectCdnStreaming(IDirectCdnStreamingEventHandler eventHandler,
      String publishUrl, DirectCdnStreamingMediaOptions options) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStartDirectCdnStreaming(mNativeHandle, eventHandler, publishUrl, options);
  }

  @Override
  public synchronized int stopDirectCdnStreaming() {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeStopDirectCdnStreaming(mNativeHandle);
  }

  @Override
  public synchronized int updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    return nativeUpdateDirectCdnStreamingMediaOptions(mNativeHandle, options);
  }

  @Override
  public synchronized int pushDirectCdnStreamingCustomVideoFrame(VideoFrame frame) {
    if (mNativeHandle == 0) {
      return -Constants.ERR_NOT_INITIALIZED;
    }
    if (frame == null) {
      return -Constants.ERR_INVALID_ARGUMENT;
    }
    return nativePushDirectCdnStreamingCustomVideoFrame(mNativeHandle, frame);
  }

  @Override
  public synchronized DeviceInfo getAudioDeviceInfo() {
    if (mNativeHandle == 0) {
      return null;
    }
    return nativeGetAudioDeviceInfo(mNativeHandle);
  }

  private int setParameter(String key, boolean value) {
    return setParameters(formatString("{\"%s\":%b}", key, value));
  }

  private int setParameter(String key, int value) {
    return setParameters(formatString("{\"%s\":%d}", key, value));
  }

  private int setParameter(String key, String value) {
    return setParameters(formatString("{\"%s\":\"%s\"}", key, value));
  }

  private int setParameterObject(String key, String value) {
    return setParameters(formatString("{\"%s\":%s}", key, value));
  }

  static String getChannelId(RtcConnection connection) {
    return (connection != null ? connection.channelId : null);
  }

  static int getUserId(RtcConnection connection) {
    return (connection != null ? connection.localUid : Constants.DEFAULT_CONNECTION_ID);
  }

  static native int nativeLog(int level, String msg);

  public static native String nativeGetSdkVersion();

  public static native String nativeGetChatEngineVersion();

  public static native String nativeGetErrorDescription(int err);

  public static native int nativeGetCertificateVerifyResult(
      String credential, int credentialLen, String certificate, int certificateLen);

  private native Object nativeObjectInit(RtcEngineConfig config);

  private static native int nativeDestroy(long handle);

  private native int nativeSetProfile(long nativeRtcEngineAndroid, String profile, boolean merge);

  private native int nativeSetEncryptionSecret(long nativeRtcEngineAndroid, String secret);

  private native int nativeEnableEncryption(long nativeRtcEngineAndroid, boolean enabled,
      int encryptionMode, String encryptionKey, byte[] encryptionKdfSalt);

  private native int nativeSetEncryptionMode(long nativeRtcEngineAndroid, String encryptionMode);

  private native String nativeGetProfile(long nativeRtcEngineAndroid);

  private native int nativeSetParameters(long nativeRtcEngineAndroid, String parameters);

  private native String nativeGetParameters(long nativeRtcEngineAndroid, String parameters);

  private native String nativeGetParameter(
      long nativeRtcEngineAndroid, String parameter, String args);

  private native int nativeJoinChannel(
      long nativeRtcEngineAndroid, String token, String channelID, String info, int uid);

  private native int nativeJoinChannel2(long nativeRtcEngineAndroid, String token, String channelID,
      int uid, ChannelMediaOptions options);

  private native int nativeJoinChannelEx(long nativeRtcEngineAndroid, String token,
      String channelID, int uid, ChannelMediaOptions options);

  private native int nativeUpdateChannelMediaOptions(
      long nativeRtcEngineAndroid, ChannelMediaOptions options, String channelId, int localUid);

  private native int nativeLeaveChannel(long nativeRtcEngineAndroid);

  private native int nativeLeaveChannelWithOptions(
      long nativeRtcEngineAndroid, LeaveChannelOptions options);

  private native int nativeLeaveChannelEx(long nativeRtcEngineAndroid, String channelId, int uid);

  private native int nativeSetClientRole(long nativeRtcEngineAndroid, int role, Object options);

  private native int nativeEnableAudio(long nativeRtcEngineAndroid, boolean enable);

  private native int nativeEnableLocalAudio(long nativeRtcEngineAndroid, boolean enable);

  private native int nativeMuteLocalAudioStream(long nativeRtcEngineAndroid, boolean mute);

  private native int nativeEnableAudioVolumeIndication(
      long nativeRtcEngineAndroid, int interval, int smooth, boolean reportVad);

  private native int nativeMuteAllRemoteAudioStreams(long nativeRtcEngineAndroid, boolean mute);

  private native int nativeMuteRemoteAudioStream(
      long nativeRtcEngineAndroid, int uid, boolean mute, String channelId, int localUid);

  private native int nativeSetDefaultMuteAllRemoteAudioStreams(
      long nativeRtcEngineAndroid, boolean mute);

  private native int nativeStartEchoTest(long nativeRtcEngineAndroid);

  private native int nativeStartEchoTestWithInterval(
      long nativeRtcEngineAndroid, int intervalInSeconds);

  private native int nativeStopEchoTest(long nativeRtcEngineAndroid);

  private native int nativeStartLastmileProbeTest(long nativeRtcEngineAndroid, boolean probeUplink,
      boolean probeDownlink, int expectedUplinkBitrate, int expectedDownlinkBitrate);

  private native int nativeStopLastmileProbeTest(long nativeRtcEngineAndroid);

  private native int nativeSwitchCamera(long nativeRtcEngineAndroid);

  private native int nativeSetCameraCapturerConfiguration(
      long nativeRtcEngineAndroid, CameraCapturerConfiguration config);

  private native int nativeStartPreview(long nativeRtcEngineAndroid);

  private native int nativeStartPreviewForSourceType(long nativeRtcEngineAndroid, int sourceType);

  private native int nativeStopPreview(long nativeRtcEngineAndroid);

  private native int nativeStopPreviewForSourceType(long nativeRtcEngineAndroid, int sourceType);

  private native int nativeCreateDataStream(long nativeRtcEngineAndroid, boolean reliable,
      boolean ordered, String channelId, int localUid);

  private native int nativeCreateDataStream2(long nativeRtcEngineAndroid, boolean ordered,
      boolean syncWithAudio, String channelId, int localUid);

  private native int nativeSendStreamMessage(
      long nativeRtcEngineAndroid, int streamId, byte[] data, String channelId, int localUid);

  private native int nativeAddPublishStreamUrl(
      long nativeRtcEngineAndroid, String url, boolean transcodingEnabled);

  private native int nativeRemovePublishStreamUrl(long nativeRtcEngineAndroid, String url);

  private native int nativeSetLiveTranscoding(long nativeRtcEngineAndroid, byte[] transcoding);

  private native int nativeAddInjectStreamUrl(
      long nativeRtcEngineAndroid, String url, byte[] config);

  private native int nativeRemoveInjectStreamUrl(long nativeRtcEngineAndroid, String url);

  private native int nativeRenewToken(long nativeRtcEngineAndroid, String token);

  private native int nativeSetupRemoteVideo(long nativeRtcEngineAndroid, View view, int renderMode,
      int mirrorMode, int uid, String channelId, int localUid);

  private native int nativeSetupLocalVideo(long nativeRtcEngineAndroid, View view, int renderMode,
      int mirrorMode, int sourceType, int sourceId);

  private native int nativeSetLocalRenderMode(
      long nativeRtcEngineAndroid, int renderMode, int mirrorMode);

  private native int nativeSetRemoteRenderMode(long nativeRtcEngineAndroid, int uid, int renderMode,
      int mirrorMode, String channelId, int localUid);

  private native int nativeSetLocalVideoMirrorMode(long nativeRtcEngineAndroid, int mirrorMode);

  private native int nativeSetAudioProfileScenario(
      long nativeRtcEngineAndroid, int profile, int scenario);

  private native int nativeSetAudioProfile(long nativeRtcEngineAndroid, int profile);

  private native int nativeSetVideoEncoderConfiguration(long nativeRtcEngineAndroid, int width,
      int height, int frameRate, int bitrate, int minBitrate, int orientationMode, int mirrorMode,
      int degradationPrefer, String channelId, int localUid);

  private native int nativeSetBeautyEffectOptions(long nativeRtcEngineAndroid, boolean enable,
      int contrast, float lightening, float smoothness, float redness, float sharpness);

  private native int nativeEnableVirtualBackground(long nativeRtcEngineAndroid, boolean enabled,
      int backgroundSourceType, int color, String source, int blurDegree);

  private native int nativeSetVideoCompositingLayout(long nativeRtcEngineAndroid, byte[] layout);

  private native int nativeAddVideoWatermark(long nativeRtcEngineAndroid, String url,
      boolean visibleInPreivew, int[] lrect, int[] prect, String channelId, int localUid);

  private native int nativeswitchChannel(
      long nativeRtcEngineAndroid, String token, String channelName);
  private native int nativeClearVideoWatermarkEx(
      long nativeRtcEngineAndroid, String channelId, int localUid);

  private native int nativeClearVideoWatermarks(long nativeRtcEngineAndroid);

  private native int nativeSetRemoteUserPriority(
      long nativeRtcEngineAndroid, int uid, int userPriority);

  private native String nativeMakeQualityReportUrl(long nativeRtcEngineAndroid, String channel,
      String listenerUid, String speakerUid, int format);

  private native String nativeGetCallId(long nativeRtcEngineAndroid);

  private native int nativeRate(
      long nativeRtcEngineAndroid, String callId, int rating, String description);

  private native int nativeComplain(long nativeRtcEngineAndroid, String callId, String description);

  private native int nativeRegisterAudioFrameObserver(
      long nativeRtcEngineAndroid, io.agora.rtc2.IAudioFrameObserver receiver);

  private native int nativeEnableAudioSpectrumMonitor(
      long nativeRtcEngineAndroid, int intervalInMS);

  private native int nativeDisableAudioSpectrumMonitor(long nativeRtcEngineAndroid);

  private native int nativeRegisterAudioSpectrumObserver(
      long nativeRtcEngineAndroid, IAudioSpectrumObserver observer);

  private native int nativeUnRegisterAudioSpectrumObserver(
      long nativeRtcEngineAndroid, IAudioSpectrumObserver observer);

  private native int nativeregisterAudioEncodedFrameObserver(long nativeRtcEngineAndroid,
      IAudioEncodedFrameObserver observer, int postionType, int encodingType);

  private native int nativeSetExternalAudioSource(long nativeRtcEngineAndroid, boolean enabled,
      int sampleRate, int channels, int sourceNumber, boolean localPlayback, boolean publish);

  private native int nativeSetDirectExternalAudioSource(
      long nativeRtcEngineAndroid, boolean enabled, boolean localPlayback);

  private native int nativePushDirectAudioFrameRawData(long nativeRtcEngineAndroid, ByteBuffer data,
      long timestamp, int sampleRate, int bytesPerSample, int channels);

  private native int nativePushExternalAudioFrameRawData(long nativeRtcEngineAndroid,
      ByteBuffer data, long timestamp, int sampleRate, int bytesPerSample, int channels,
      int sourceId);

  private native int nativeEnableEchoCancellationExternal(
      long nativeRtcEngineAndroid, boolean enabled, int audioSourceDelay);

  private native int nativeSetExternalAudioSink(
      long nativeRtcEngineAndroid, int sampleRate, int channels);

  private native int nativePushCaptureAudioFrame(
      long nativeRtcEngineAndroid, ByteBuffer data, int length, int sampleRate, int channel);

  private native int nativePushReverseAudioFrame(
      long nativeRtcEngineAndroid, ByteBuffer data, int length, int sampleRate, int channel);

  private native int nativePullAudioFrame(
      long nativeRtcEngineAndroid, ByteBuffer data, int length, int sampleRate, int channel);

  private native int nativeSetApiCallMode(long nativeRtcEngineAndroid, int syncCallTimeout);

  private native long nativeGetRtcEngine(long nativeRtcEngineAndroid);

  private native int nativeSetExternalVideoSource(long nativeRtcEngineAndroid, boolean enabled,
      boolean useTexture, int sourceType, EncodedVideoTrackOptions opt);

  private native int nativePushExternalEncodedVideoFrame(long nativeRtcEngineAndroid,
      ByteBuffer data, EncodedVideoFrameInfo frameInfo, String channelId, int localUid);

  private native int nativeRegisterVideoEncodedImageReceiver(
      long nativeRtcEngineAndroid, IVideoEncodedImageReceiver receiver);

  private native int nativeEnableVideo(long nativeRtcEngineAndroid);

  private native int nativeDisableVideo(long nativeRtcEngineAndroid);

  private native int nativeEnableLocalVideo(long nativeRtcEngineAndroid, boolean enabled);

  private native int nativeStartSecondaryCameraCapture(
      long nativeRtcEngineAndroid, CameraCapturerConfiguration config);

  private native int nativeStopSecondaryCameraCapture(long nativeRtcEngineAndroid);

  private native int nativeMuteLocalVideoStream(long nativeRtcEngineAndroid, boolean muted);

  private native int nativeMuteAllRemoteVideoStreams(long nativeRtcEngineAndroid, boolean muted);

  private native int nativeSetDefaultMuteAllRemoteVideoStreams(
      long nativeRtcEngineAndroid, boolean muted);

  private native int nativeSetRemoteDefaultVideoStreamType(
      long nativeRtcEngineAndroid, int streamType);

  private native int nativeSetRemoteVideoStreamType(
      long nativeRtcEngineAndroid, int userId, int streamType, String channelId, int localUid);

  private native int nativeEnableDualStreamMode(long nativeRtcEngineAndroid, int sourceType,
      boolean enabled, int width, int height, int bitrate, int framerate);

  private native int nativeMuteRemoteVideoStream(
      long nativeRtcEngineAndroid, int uid, boolean muted, String channelId, int localUid);

  private native int nativeSetDefaultAudioRoutetoSpeakerphone(
      long nativeRtcEngineAndroid, boolean defaultToSpeaker);

  private native int nativeSetEnableSpeakerphone(long nativeRtcEngineAndroid, boolean speakerOn);

  private native boolean nativeIsSpeakerphoneEnabled(long nativeRtcEngineAndroid);

  private native int nativeAdjustRecordingSignalVolume(long nativeRtcEngineAndroid, int volume);

  private native int nativeAdjustPlaybackSignalVolume(long nativeRtcEngineAndroid, int volume);

  private native int nativeAdjustUserPlaybackSignalVolume(
      long nativeRtcEngineAndroid, int uid, int volume);

  private native int nativeMuteRecordingSignal(long nativeRtcEngineAndroid, boolean muted);

  private native int nativeSetRecordingAudioFrameParameters(
      long nativeRtcEngineAndroid, int sampleRate, int channel, int mode, int samplesPerCall);

  private native int nativeSetPlaybackAudioFrameParameters(
      long nativeRtcEngineAndroid, int sampleRate, int channel, int mode, int samplesPerCall);

  private native int nativeSetMixedAudioFrameParameters(
      long nativeRtcEngineAndroid, int sampleRate, int channel, int samplesPerCall);

  private native int nativeSetPlaybackAudioFrameBeforeMixingParameters(
      long nativeRtcEngineAndroid, int sampleRate, int channel);

  private native int nativeSetChannelProfile(long nativeRtcEngineAndroid, int profile);

  private native int nativeSetAudioOptionParams(long nativeRtcEngineAndroid, String params);

  private native String nativeGetAudioOptionParams(long nativeRtcEngineAndroid);

  private native int nativeSetAudioSessionParams(long nativeRtcEngineAndroid, String params);

  private native String nativeGetAudioSessionParams(long nativeRtcEngineAndroid);

  private native int nativeStartScreenCapture(long nativeRtcEngineAndroid,
      Intent mediaProjectionPermissionResultData, ScreenCaptureParameters parameters);

  private native int nativeStopScreenCapture(long nativeRtcEngineAndroid);

  private native int nativeSetLogFile(long nativeRtcEngineAndroid, String filePath);

  private native int nativeSetLogFilter(long nativeRtcEngineAndroid, int filter);

  private native int nativeSetLogFileSize(long nativeRtcEngineAndroid, long fileSizeInKBytes);

  private native String nativeUploadLogFile(long nativeRtcEngineAndroid);

  private native int nativeEnableExtension(long nativeRtcEngineAndroid, String provider,
      String extension, boolean enable, int sourceType);

  private native int nativeSetExtensionProperty(long nativeRtcEngineAndroid, String provider,
      String extension, String key, String value, int sourceType);

  private native int nativeSetExtensionProviderProperty(
      long nativeRtcEngineAndroid, String provider, String key, String value);

  private native int nativeEnableInEarMonitoring(
      long nativeRtcEngineAndroid, boolean enabled, int includeAudioFilters);

  private native int nativeSetInEarMonitoringVolume(long nativeRtcEngineAndroid, int volume);

  private native double nativeGetEffectsVolume(long nativeRtcEngineAndroid);

  private native int nativeSetEffectsVolume(long nativeRtcEngineAndroid, double volume);

  private native int nativeSetVolumeOfEffect(
      long nativeRtcEngineAndroid, int soundId, double volume);

  private native int nativePlayEffectWithFilePath(long nativeRtcEngineAndroid, int soundId,
      String filePath, int loopCount, double pitch, double pan, double gain, boolean publish,
      int startPos);

  private native int nativePlayAllEffects(long nativeRtcEngineAndroid, int loopCount, double pitch,
      double pan, double gain, boolean publish);

  private native int nativeGetVolumeOfEffect(long nativeRtcEngineAndroid, int soundId);

  private native int nativeStopEffect(long nativeRtcEngineAndroid, int soundId);

  private native int nativeStopAllEffects(long nativeRtcEngineAndroid);

  private native int nativePreloadEffect(
      long nativeRtcEngineAndroid, int soundId, String filePath, int startPos);

  private native int nativeUnloadEffect(long nativeRtcEngineAndroid, int soundId);

  private native int nativeUnloadAllEffects(long nativeRtcEngineAndroid);

  private native int nativePauseEffect(long nativeRtcEngineAndroid, int soundId);

  private native int nativePauseAllEffects(long nativeRtcEngineAndroid);

  private native int nativeResumeEffect(long nativeRtcEngineAndroid, int soundId);

  private native int nativeResumeAllEffects(long nativeRtcEngineAndroid);

  private native int nativeGetConnectionState(
      long nativeRtcEngineAndroid, String channelId, int localUid);

  private native int nativeSetLocalVoiceChanger(long nativeRtcEngineAndroid, int voiceChanger);

  private native int nativeSetLocalVoiceReverbPreset(long nativeRtcEngineAndroid, int reverbPreset);

  private native int nativeStartAudioRecording(
      long nativeRtcEngineAndroid, String filePath, int quality);

  private native int nativeStartAudioRecording2(long nativeRtcEngineAndroid, String filePath,
      boolean codec, int sampleRate, int fileRecordOption, int quality);

  private native int nativeStopAudioRecording(long nativeRtcEngineAndroid);

  private native int nativeStartAudioMixing(long nativeRtcEngineAndroid, String filePath,
      boolean loopback, boolean replace, int cycle, int startPos);

  private native int nativeStopAudioMixing(long nativeRtcEngineAndroid);

  private native int nativePauseAudioMixing(long nativeRtcEngineAndroid);

  private native int nativeResumeAudioMixing(long nativeRtcEngineAndroid);

  private native int nativeAdjustAudioMixingVolume(long nativeRtcEngineAndroid, int volume);

  private native int nativeAdjustAudioMixingPublishVolume(long nativeRtcEngineAndroid, int volume);

  private native int nativeGetAudioMixingPublishVolume(long nativeRtcEngineAndroid);

  private native int nativeAdjustAudioMixingPlayoutVolume(long nativeRtcEngineAndroid, int volume);

  private native int nativeGetAudioMixingPlayoutVolume(long nativeRtcEngineAndroid);

  private native int nativeGetAudioMixingDuration(long nativeRtcEngineAndroid);

  private native int nativeGetAudioMixingCurrentPosition(long nativeRtcEngineAndroid);

  private native int nativeSetAudioMixingPosition(long nativeRtcEngineAndroid, int pos);

  private native int nativeSetAudioMixingPitch(long nativeRtcEngineAndroid, int pitch);

  public native int nativePushExternalVideoFrame(
      long nativeRtcEngineAndroid, VideoFrame frame, String channelId, int localUid);

  private native int nativePushExternalAgoraVideoFrame(long nativeRtcEngineAndroid, int format,
      byte[] buffer, int stride, int height, int cropLeft, int cropTop, int cropRight,
      int cropBottom, int rotation, long timestamp, String channelId, int localUid);

  private native int nativeRegisterMediaMetadataObserver(
      long nativeRtcEngineAndroid, Object observer, int type);

  private native int nativeUnregisterMediaMetadataObserver(
      long nativeRtcEngineAndroid, Object observer, int type);

  private native int nativeRegisterVideoFrameObserver(
      long nativeRtcEngineAndroid, IVideoFrameObserver ob);

  private native int nativeSendCustomReportMessage(long nativeRtcEngineAndroid, String id,
      String category, String event, String label, int value, String channelId, int localUid);

  private native int nativeSetLogLevel(long nativeRtcEngineAndroid, int level);

  private native int nativeCreateMediaPlayer(long nativeRtcEngineAndroid);

  private native int nativeMediaPlayerOpenWithCustormProviderData(long nativeRtcEngineAndroid,
      int sourceId, long startPos, IMediaPlayerCustomDataProvider provider);

  private native int nativeMediaPlayerOpen(
      long nativeRtcEngineAndroid, int sourceId, String url, long startPos);

  private native int nativeMediaPlayerPlay(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerPause(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerStop(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerResume(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerSeek(long nativeRtcEngineAndroid, int sourceId, long newPos);

  private native int nativeMediaPlayerSetAudioPitch(
      long nativeRtcEngineAndroid, int sourceId, int pitch);

  private native long nativeMediaPlayerGetPlayPosition(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerGetState(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerMute(long nativeRtcEngineAndroid, int sourceId, boolean mute);

  private native boolean nativeMediaPlayerIsMuted(long nativeRtcEngineAndroid, int sourceId);

  private native long nativeMediaPlayerGetDuration(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerGetStreamCount(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerSetView(
      long nativeRtcEngineAndroid, int sourceId, View videoView);

  private native int nativeMediaPlayerSetRenderMode(
      long nativeRtcEngineAndroid, int sourceId, int mode);

  private native MediaStreamInfo nativeMediaPlayerGetStreamInfo(
      long nativeRtcEngineAndroid, int sourceId, int index);

  private native int nativeMediaPlayerSetLoopCount(
      long nativeRtcEngineAndroid, int sourceId, int loopCount);

  private native int nativeMediaPlayerChangePlaybackSpeed(
      long nativeRtcEngineAndroid, int sourceId, int speed);

  private native int nativeMediaPlayerSelectAudioTrack(
      long nativeRtcEngineAndroid, int sourceId, int index);

  private native int nativeMediaPlayerSetPlayerOption(
      long nativeRtcEngineAndroid, int sourceId, String key, int value);

  private native int nativeMediaPlayerTakeScreenshot(
      long nativeRtcEngineAndroid, int sourceId, String filename);

  private native int nativeMediaPlayerSelectInternalSubtitle(
      long nativeRtcEngineAndroid, int sourceId, int index);

  private native int nativeMediaPlayerSetExternalSubtitle(
      long nativeRtcEngineAndroid, int sourceId, String url);

  private native int nativeMediaPlayerAdjustPlayoutVolume(
      long nativeRtcEngineAndroid, int sourceId, int volume);

  private native int nativeMediaPlayerGetPlayoutVolume(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerAdjustPublishSignalVolume(
      long nativeRtcEngineAndroid, int sourceId, int volume);

  private native int nativeMediaPlayerGetPublishSignalVolume(
      long nativeRtcEngineAndroid, int sourceId);

  private native String nativeMediaPlayerGetPlaySrc(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerPreloadSrc(
      long nativeRtcEngineAndroid, int sourceId, String src, long startPos);

  private native int nativeMediaPlayerUnloadSrc(
      long nativeRtcEngineAndroid, int sourceId, String src);

  private native int nativeMediaPlayerPlayPreloadedSrc(
      long nativeRtcEngineAndroid, int sourceId, String src);

  private native int nativeMediaPlayerSwitchSrc(
      long nativeRtcEngineAndroid, int sourceId, String src, boolean syncPts);

  private native int nativeMediaPlayerDestroy(long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerRegisterPlayerObserver(
      long nativeRtcEngineAndroid, int sourceId, IMediaPlayerObserver playerObserver);

  private native int nativeMediaPlayerUnRegisterPlayerObserver(
      long nativeRtcEngineAndroid, int sourceId, IMediaPlayerObserver playerObserver);

  private native int nativeMediaPlayerSetAudioDualMonoMode(
      long nativeRtcEngineAndroid, int sourceId, int mode);

  private native int nativeMediaPlayerOpenWithAgoraCDNSrc(
      long nativeRtcEngineAndroid, int sourceId, String src, long startPos);

  private native int nativeMediaPlayerGetAgoraCDNLineCount(
      long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerSwitchAgoraCDNLineByIndex(
      long nativeRtcEngineAndroid, int sourceId, int index);

  private native int nativeMediaPlayerGetCurrentAgoraCDNIndex(
      long nativeRtcEngineAndroid, int sourceId);

  private native int nativeMediaPlayerEnableAutoSwitchAgoraCDN(
      long nativeRtcEngineAndroid, int sourceId, boolean enable);

  private native int nativeMediaPlayerRenewAgoraCDNSrcToken(
      long nativeRtcEngineAndroid, int sourceId, String token, long ts);

  private native int nativeMediaPlayerSwitchAgoraCDNSrc(
      long nativeRtcEngineAndroid, int sourceId, String src, boolean syncPts);

  private native int nativeRegisterLocalUserAccount(
      long nativeRtcEngineAndroid, String appId, String userAccount);

  private native int nativeJoinChannelWithUserAccount(long nativeRtcEngineAndroid, String token,
      String channelId, String userAccount, ChannelMediaOptions options);

  private native int nativeJoinChannelWithUserAccountEx(long nativeRtcEngineAndroid, String token,
      String channelId, String userAccount, ChannelMediaOptions options);

  private native UserInfo nativeGetUserInfoByUserAccount(
      long nativeRtcEngineAndroid, String userAccount, String channelId, String localUserAccount);

  private native DeviceInfo nativeGetAudioDeviceInfo(long nativeRtcEngineAndroid);

  private native UserInfo nativeGetUserInfoByUid(
      long nativeRtcEngineAndroid, int uid, String channelId, String localUserAccount);

  private native int nativeStartChannelMediaRelay(
      long nativeRtcEngineAndroid, ChannelMediaInfo srcInfo, final ChannelMediaInfo[] descInfos);

  private native int nativeStopChannelMediaRelay(long nativeRtcEngineAndroid);

  private native int nativePauseAllChannelMediaRelay(long nativeRtcEngineAndroid);

  private native int nativeResumeAllChannelMediaRelay(long nativeRtcEngineAndroid);

  private native int nativeUpdateChannelMediaRelay(
      long nativeRtcEngineAndroid, ChannelMediaInfo srcInfo, final ChannelMediaInfo[] descInfos);

  private native int nativeEnableExternalAudioSourceLocalPlayback(
      long nativeRtcEngineAndroid, boolean enabled);

  private native int nativeAdjustCustomAudioPublishVolume(
      long nativeRtcEngineAndroid, int sourceId, int volume);
  
  private native int nativeAdjustCustomAudioPlayoutVolume(
      long nativeRtcEngineAndroid, int sourceId, int volume);
  
  private native int nativeStartRhythmPlayer(
      long nativeRtcEngineAndroid, String sound1, String sound2, AgoraRhythmPlayerConfig config);

  private native int nativeStopRhythmPlayer(long nativeRtcEngineAndroid);

  private native int nativeConfigRhythmPlayer(
      long nativeRtcEngineAndroid, AgoraRhythmPlayerConfig config);

  private native int nativeEnableCustomAudioLocalPlayback(
      long nativeRtcEngineAndroid, int sourceId, boolean enabled);

  private native int nativeEnableSoundPositionIndication(
      long nativeRtcEngineAndroid, boolean enabled);

  private native int nativeSetRemoteVoicePosition(long nativeRtcEngineAndroid, int uid, double pan,
      double gain, String channelId, int localUid);
  private native boolean nativeGetCameraTorchSupported(long nativeRtcEngineAndroid);

  private native boolean nativeGetCameraFocusSupported(long nativeRtcEngineAndroid);

  private native boolean nativeGetCameraZoomSupported(long nativeRtcEngineAndroid);

  private native boolean nativeGetCameraAutoFocusFaceModeSupported(long nativeRtcEngineAndroid);

  private native boolean nativeGetCameraFaceDetectSupported(long nativeRtcEngineAndroid);

  private native boolean nativeGetCameraExposurePositionSupported(long nativeRtcEngineAndroid);

  private native int nativeSetCameraFocusPositionInPreview(
      long nativeRtcEngineAndroid, float positionX, float positionY);

  private native int nativeSetCameraTorchOn(long nativeRtcEngineAndroid, boolean isOn);

  private native int nativeSetCameraZoomFactor(long nativeRtcEngineAndroid, float factor);

  private native int nativeSetCameraAutoFocusFaceModeEnabled(
      long nativeRtcEngineAndroid, boolean enabled);

  private native int nativeEnableFaceDetection(long nativeRtcEngineAndroid, boolean enabled);

  private native int nativeSetCameraExposurePosition(
      long nativeRtcEngineAndroid, float positionXinView, float positionYinView);

  private native float nativeGetCameraMaxZoomFactor(long nativeRtcEngineAndroid);

  private native int nativeSetVoiceBeautifierPreset(long nativeRtcEngineAndroid, int preset);

  private native int nativeSetAudioEffectPreset(long nativeRtcEngineAndroid, int preset);

  private native int nativeSetVoiceConversionPreset(long nativeRtcEngineAndroid, int preset);

  private native int nativeSetAudioEffectParameters(
      long nativeRtcEngineAndroid, int preset, int param1, int param2);

  private native int nativeSetVoiceBeautifierParameters(
      long nativeRtcEngineAndroid, int preset, int param1, int param2);

  private native int nativeSetVoiceConversionParameters(
      long nativeRtcEngineAndroid, int preset, int param1, int param2);

  private native int nativeSetLocalVoicePitch(long nativeRtcEngineAndroid, double pitch);

  private native int nativeSetLocalVoiceEqualization(
      long nativeRtcEngineAndroid, int bandFrequency, int bandGain);

  private native int nativeSetLocalVoiceReverb(
      long nativeRtcEngineAndroid, int reverbKey, int value);

  private native int nativeMediaPlayerRegisterAudioFrameObserver(
      long nativeRtcEngineAndroid, int sourceId, IMediaPlayerAudioFrameObserver receiver, int mode);
  private native int nativeTakeSnapshot(
      long nativeRtcEngineAndroid, String channel, int uid, String filePath);
  private native int nativeEnableContentInspect(
      long nativeRtcEngineAndroid, boolean enabled, byte[] config);

  private native int nativeMediaPlayerRegisterVideoFrameObserver(
      long nativeRtcEngineAndroid, int sourceId, IMediaPlayerVideoFrameObserver observer);

  // DirectCdnStreaming RTMP
  private native int nativeSetDirectCdnStreamingAudioConfiguration(
      long nativeRtcEngineAndroid, int profile);

  private native int nativeSetDirectCdnStreamingVideoConfiguration(long nativeRtcEngineAndroid,
      int width, int height, int frameRate, int bitrate, int minBitrate, int orientationMode,
      int mirrorMode, int degradationPrefer);

  private native int nativeStartDirectCdnStreaming(long nativeRtcEngineAndroid, Object eventHandler,
      String publishUrl, DirectCdnStreamingMediaOptions options);

  private native int nativeStopDirectCdnStreaming(long nativeRtcEngineAndroid);

  private native int nativeUpdateDirectCdnStreamingMediaOptions(
      long nativeRtcEngineAndroid, DirectCdnStreamingMediaOptions options);

  private native int nativePushDirectCdnStreamingCustomVideoFrame(
      long nativeRtcEngineAndroid, VideoFrame frame);
}
