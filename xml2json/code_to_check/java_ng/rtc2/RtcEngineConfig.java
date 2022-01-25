package io.agora.rtc2;

import android.content.Context;
import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.internal.AgoraExtension;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

/** Configurations for the {@link RtcEngine} instance. */
public class RtcEngineConfig {
  /** The context of Android Activity. */
  public Context mContext;
  /**
   * The App ID issued to you by Agora.
   * See [How to get the App ID](https://docs.agora.io/en/Agora%20Platform/token#get-an-app-id).
   * Only users in apps with the same App ID can join the same channel and communicate with each
   * other. Use an App ID to create only one {@link RtcEngine} instance. To change your App ID, call
   * destroy to {@link RtcEngine#destroy() destroy} the current {@link RtcEngine} instance and then
   * call `create` to create an {@link RtcEngine} instance with the new App ID.
   */
  public String mAppId;

  /**
   * The region for connection. This advanced feature applies to scenarios that have regional
   * restrictions.
   *
   * For the regions that Agora supports, see {@link io.agora.rtc2.RtcEngineConfig#AreaCode
   * AreaCode}. After specifying the region, the app that integrates the Agora SDK connects to the
   * Agora servers within that region.
   */
  public int mAreaCode;

  /**
   * {@link IRtcEngineEventHandler IRtcEngineEventHandler} is an abstract class providing default
   * implementation. The SDK uses this class for reporting on SDK runtime events.
   */
  public IAgoraEventHandler mEventHandler;

  /**
   * The channel profile of the Agora {@link RtcEngine}.
   *
   * The Agora RtcEngine differentiates channel profiles and applies different optimization
   * algorithms accordingly. For example, it prioritizes smoothness and low latency for a video
   * call, and prioritizes video quality for a video broadcast.
   */
  public int mChannelProfile;
  /**
   * The audio application scenario. See {@link io.agora.rtc2.Constants#AudioScenario
   * AudioScenario}.
   */
  public int mAudioScenario;

  /**
   * Determines whether to enable audio device
   * -true: (Default) enable audio device
   * -false, disable audio device. If you want to pull the decoded and mixed audio data for playback
   * from
   *  {@link RtcEngine#pullPlaybackAudioFrame(ByteBuffer, int)}. This value must be false
   */
  public boolean mEnableAudioDevice;
  public List<String> mExtensionList;
  public IMediaExtensionObserver mExtensionObserver;
  public LogConfig mLogConfig;

  /**
   * Thread priority type.
   * see {@link io.agora.rtc2.Constants#ThreadPriorityType ThreadPriorityType}
   */
  public Integer mThreadPriority;
  /**
   * native c++ dynamic library path.
   *
   * If valued, SDK will use {@link java.lang.System#load(String)} to load the library at the
   * specify path; otherwise, {@link java.lang.System#loadLibrary(String)}} will be used.
   */
  public String mNativeLibPath;

  /** Regions for connection */
  public static class AreaCode {
    public final static int AREA_CODE_NONE = 0;
    /** Mainland China */
    public final static int AREA_CODE_CN = 0x00000001;
    /** North America */
    public final static int AREA_CODE_NA = 0x00000002;
    /** Europe */
    public final static int AREA_CODE_EU = 0x00000004;
    /** Asia, excluding Mainland China */
    public final static int AREA_CODE_AS = 0x00000008;
    /** Japan */
    public final static int AREA_CODE_JP = 0x00000010;
    /** India */
    public final static int AREA_CODE_IN = 0x00000020;
    /** (Default) Global */
    public final static int AREA_CODE_GLOB = 0xFFFFFFFF;

    private AreaCode() {}
  };

  public static class LogConfig {
    /**
     * The log file set by user, null for default log path.
     */
    public String filePath;
    /**
     * The log file size set by user, 1024KB will be set for default log size
     * if this value is less than or equal to 0.
     */
    public int fileSizeInKB;
    /**
     * The log level set by user, INFO is default level.
     * You can use one of the level defined in LogLevel.
     * {@link Constants.LogLevel#getValue(Constants.LogLevel)} .
     */
    public int level = Constants.LogLevel.getValue(Constants.LogLevel.LOG_LEVEL_INFO);

    @CalledByNative("LogConfig")
    public String getFilePath() {
      return filePath;
    }

    @CalledByNative("LogConfig")
    public int getFileSize() {
      return fileSizeInKB;
    }

    @CalledByNative("LogConfig")
    public int getLevel() {
      return level;
    }
  }

  public RtcEngineConfig() {
    mContext = null;
    mAppId = "";
    mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
    mEventHandler = null;
    mEnableAudioDevice = true;
    mAudioScenario = Constants.AUDIO_SCENARIO_DEFAULT;
    mAreaCode = AreaCode.AREA_CODE_GLOB;
    mExtensionList = new ArrayList<>();
    mExtensionObserver = null;
    mLogConfig = new LogConfig();
    mThreadPriority = null;
  }

  public void addExtension(String providerName) {
    mExtensionList.add(providerName);
  }

  @CalledByNative
  public Context getContext() {
    return mContext;
  }

  @CalledByNative
  public String getAppId() {
    return mAppId;
  }

  @CalledByNative
  public int getChannelProfile() {
    return mChannelProfile;
  }

  @CalledByNative
  public int getAudioScenario() {
    return mAudioScenario;
  }

  @CalledByNative
  public boolean isAudioDeviceEnabled() {
    return mEnableAudioDevice;
  }

  @CalledByNative
  public int getAreaCode() {
    return mAreaCode;
  }

  @CalledByNative
  public IMediaExtensionObserver getExtensionObserver() {
    return mExtensionObserver;
  }

  @CalledByNative
  public LogConfig getLogConfig() {
    return mLogConfig;
  }

  @CalledByNative
  public Integer getThreadPriority() {
    return mThreadPriority;
  }
}
