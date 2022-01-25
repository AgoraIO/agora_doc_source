package io.agora.rtc2;

import android.graphics.Rect;

/**
 * <p>Callback methods.</p>
 *
 * <p>The SDK uses the IRtcEngineEventHandler interface class to send callback event notifications
 to the application, and the application inherits the methods of this interface class to retrieve
 these event notifications. All methods in this interface class have their (empty) default
 implementations, and the application can inherit only some of the required events instead of all of
 them. In the callback methods, the application should avoid time-consuming tasks or call blocking
 APIs (such as SendMessage), otherwise, the SDK may not work properly.</p>
 */
public abstract class IRtcEngineEventHandler implements IAgoraEventHandler {
  // Enables callback event notifications to your application.

  /**
   * @deprecated Use the new {@link Constants} class
   *  with the same constants value
   */
  @Deprecated
  public static class Quality {
    public final static int UNKNOWN = Constants.QUALITY_UNKNOWN;
    public final static int EXCELLENT = Constants.QUALITY_EXCELLENT;
    public final static int GOOD = Constants.QUALITY_GOOD;
    public final static int POOR = Constants.QUALITY_POOR;
    public final static int BAD = Constants.QUALITY_BAD;
    public final static int VBAD = Constants.QUALITY_VBAD;
    public final static int DOWN = Constants.QUALITY_DOWN;
  }

  /**
   * The warning code.
   */
  public static class WarnCode {
    /**
     * 20: The request is pending, usually due to some module not being ready, and the SDK postponed
     * processing the request.
     */
    public final static int WARN_PENDING = Constants.WARN_PENDING;
    /**
     * 16: Fails to initialize the video function, possibly caused by lack of resources. The users
     * cannot see the video while the voice communication is not affected.
     */
    public final static int WARN_INIT_VIDEO = Constants.WARN_INIT_VIDEO;
    /**
     * 8: The specified view is invalid. You need to specify a view when using the video function.
     */
    public final static int WARN_INVALID_VIEW = Constants.WARN_INVALID_VIEW;
    /**
     * 103: No channel resources are available. Maybe because the server cannot allocate any channel
     * resource.
     */
    public final static int WARN_NO_AVAILABLE_CHANNEL = Constants.WARN_NO_AVAILABLE_CHANNEL;
    /**
     * 104: A timeout occurs when looking up the channel. When joining a channel, the SDK looks up
     * the specified channel. The warning usually occurs when the network condition is too poor for
     * the SDK to connect to the server.
     */
    public final static int WARN_LOOKUP_CHANNEL_TIMEOUT = Constants.WARN_LOOKUP_CHANNEL_TIMEOUT;
    /**
     * 105: The server rejects the request to look up the channel. The server cannot process this
     * request or the request is illegal.
     */
    public final static int WARN_LOOKUP_CHANNEL_REJECTED = Constants.WARN_LOOKUP_CHANNEL_REJECTED;
    /**
     * 106: A timeout occurs when opening the channel. Once the specific channel is found, the SDK
     * opens the channel. The warning usually occurs when the network condition is too poor for the
     * SDK to connect to the server.
     */
    public final static int WARN_OPEN_CHANNEL_TIMEOUT = Constants.WARN_OPEN_CHANNEL_TIMEOUT;
    /**
     * 107: The server rejects the request to open the channel. The server cannot process this
     * request or the request is illegal.
     */
    public final static int WARN_OPEN_CHANNEL_REJECTED = Constants.WARN_OPEN_CHANNEL_REJECTED;
    /**
     * 121: The ticket to open the channel is invalid.
     */
    public final static int WARN_OPEN_CHANNEL_INVALID_TICKET =
        Constants.WARN_OPEN_CHANNEL_INVALID_TICKET;
    /**
     * 122: Try another server.
     */
    public final static int WARN_OPEN_CHANNEL_TRY_NEXT_VOS =
        Constants.WARN_OPEN_CHANNEL_TRY_NEXT_VOS;
    /**
     * 701: An error occurs when opening the audio mixing file.
     */
    public final static int WARN_AUDIO_MIXING_OPEN_ERROR = Constants.WARN_AUDIO_MIXING_OPEN_ERROR;
    /**
     * 1014: Audio Device Module: A warning occurs in the playback device.
     */
    public final static int WARN_ADM_RUNTIME_PLAYOUT_WARNING =
        Constants.WARN_ADM_RUNTIME_PLAYOUT_WARNING;
    /**
     * 1016: Audio Device Module: A warning occurs in the recording device.
     */
    public final static int WARN_ADM_RUNTIME_RECORDING_WARNING =
        Constants.WARN_ADM_RUNTIME_RECORDING_WARNING;
    /**
     * 1019: Audio Device Module: No valid audio data is collected.
     */
    public final static int WARN_ADM_RECORD_AUDIO_SILENCE = Constants.WARN_ADM_RECORD_AUDIO_SILENCE;
    /**
     * 1033: Audio Device Module: The recording device is occupied.
     */
    public final static int WARN_ADM_RECORD_IS_OCCUPIED = Constants.WARN_ADM_RECORD_IS_OCCUPIED;
    /**
     * 1051: Audio Device Module: Howling is detected.
     */
    public final static int WARN_APM_HOWLING = Constants.WARN_APM_HOWLING;
  }

  /**
   * The error codes.
   */
  public static class ErrorCode {
    /**
     * 0: No error occurs.
     */
    public final static int ERR_OK = Constants.ERR_OK;
    /**
     * 1: A general error occurs (no specified reason).
     */
    public final static int ERR_FAILED = Constants.ERR_FAILED;
    /**
     * 2: An invalid parameter is used. For example, the specific channel name includes illegal
     * characters.
     */
    public final static int ERR_INVALID_ARGUMENT = Constants.ERR_INVALID_ARGUMENT;
    /**
     * 3: The SDK module is not ready. We recommend the following methods to solve this error:
     * - Check the audio device.
     * - Check the completeness of the app.
     * - Re-initialize the SDK.
     */
    public final static int ERR_NOT_READY = Constants.ERR_NOT_READY;
    /**
     * 4: The SDK does not support this function.
     */
    public final static int ERR_NOT_SUPPORTED = Constants.ERR_NOT_SUPPORTED;
    /**
     * 5: The request is rejected. This is for internal SDK internal use only, and is not return
     * to the app through any API or callback event.
     */
    public final static int ERR_REFUSED = Constants.ERR_REFUSED;
    /**
     * 6: The buffer size is not big enough to store the returned data.
     */
    public final static int ERR_BUFFER_TOO_SMALL = Constants.ERR_BUFFER_TOO_SMALL;
    /**
     * 7: The SDK is not initialized before calling this API.
     */
    public final static int ERR_NOT_INITIALIZED = Constants.ERR_NOT_INITIALIZED;
    /**
     * 9: No permission. Check if the user has granted access to the audio or video device.
     */
    public final static int ERR_NO_PERMISSION = Constants.ERR_NO_PERMISSION;
    /**
     * 10: An API timeout. Some APIs require the SDK to return the execution result, and this error
     * occurs if the request takes too long for the SDK to process.
     */
    public final static int ERR_TIMEDOUT = Constants.ERR_TIMEDOUT;
    /**
     * 11: The request is cancelled. This is for internal SDK internal use only, and is not return
     * to the application through any API or callback event.
     */
    public final static int ERR_CANCELED = Constants.ERR_CANCELED;
    /**
     * 12: The call frequency is too high. This is for internal SDK internal use only, and is not
     * return to the application through any API or callback event.
     */
    public final static int ERR_TOO_OFTEN = Constants.ERR_TOO_OFTEN;
    /**
     * 13: The SDK fails to bind to the network socket. This is for internal SDK internal use only,
     * and is not returned to the app through any method or callback.
     */
    public final static int ERR_BIND_SOCKET = Constants.ERR_BIND_SOCKET;
    /**
     * 14: The network is unavailable. This is for internal SDK internal use only, and is not
     * return to the application through any API or callback event.
     */
    public final static int ERR_NET_DOWN = Constants.ERR_NET_DOWN;
    /**
     * 15: No network buffers available. This is for internal SDK internal use only, and it will not
     * return to the application through any API or callback event.
     */
    public final static int ERR_NET_NOBUFS = Constants.ERR_NET_NOBUFS;
    /**
     * 17: The request to join the channel is rejected. This error usually occurs when:
     * - The user is already in the channel, and still calls the API to join the channel。
     * - The user tries to join the channel during echo test. Wait until the echo test is finished.
     */
    public final static int ERR_JOIN_CHANNEL_REJECTED = Constants.ERR_JOIN_CHANNEL_REJECTED;
    /**
     * 18: The request to leave the channel is rejected. This error usually occurs:
     * - When the user left the channel and still calls the API to leave the channel. This error
     * stops once the user stops calling the method.
     * - When the user calls `leaveChannel` before joining the channel. No extra operation is
     * needed.
     */
    public final static int ERR_LEAVE_CHANNEL_REJECTED = Constants.ERR_LEAVE_CHANNEL_REJECTED;
    /**
     * 101: The specified App ID is invalid. Please try to rejoin the channel with a valid App ID.
     */
    public final static int ERR_INVALID_APP_ID = Constants.ERR_INVALID_APP_ID;
    /**
     * 102: The specified channel name is invalid. Please try to rejoin the channel with a valid
     * channel name.
     */
    public final static int ERR_INVALID_CHANNEL_NAME = Constants.ERR_INVALID_CHANNEL_NAME;
    /**
     * Fails to get server resources in the specified region.
     */
    public final static int ERR_NO_SERVER_RESOURCES = Constants.ERR_NO_SERVER_RESOURCES;
    /**
     * 109: The token expired due to one of the following reasons:
     * - Authorized Timestamp expired: The timestamp is represented by the number of seconds elapsed
     * since 1/1/1970. The user can use the Token to access the Agora service within 24 hours after
     * the Token is generated. If the user does not access the Agora service within 24 hours, this
     * Token will no longer be valid.
     * - Call Expiration Timestamp expired: The timestamp is the exact time when a user can no
     * longer use the Agora service (for example, when a user is forced to leave an ongoing call).
     * When a value is set for the Call Expiration Timestamp, it does not mean that the Dynamic Key
     * will expire, but that the user will be banned from the channel.
     */
    public final static int ERR_TOKEN_EXPIRED = Constants.ERR_TOKEN_EXPIRED;
    /**
     * 110: The token is invalid due to one of the following reasons:
     * - The App Certificate for the project is enabled in Console, but the user is still using the
     * App ID.
     * - Once the App Certificate is enabled, the user must use a token. The uid is mandatory, and
     * users must set the same uid as the one set in the `joinChannel` method.
     */
    public final static int ERR_INVALID_TOKEN = Constants.ERR_INVALID_TOKEN;
    /**
     * 111: The CONNECTION_INTERRUPTED callback. This applies to the Agora Web SDK only.
     */
    public final static int ERR_CONNECTION_INTERRUPTED = Constants.ERR_CONNECTION_INTERRUPTED;
    /**
     * 112: The CONNECTION_LOST callback. This applies to the Agora Web SDK only.
     */
    public final static int ERR_CONNECTION_LOST = Constants.ERR_CONNECTION_LOST;
    /**
     * 113: The user is not in the channel.
     */
    public final static int ERR_NOT_IN_CHANNEL = Constants.ERR_NOT_IN_CHANNEL;
    /**
     * 114: The data size is too big.
     */
    public final static int ERR_SIZE_TOO_LARGE = Constants.ERR_SIZE_TOO_LARGE;
    /**
     * 115: The bitrate is limited.
     */
    public final static int ERR_BITRATE_LIMIT = Constants.ERR_BITRATE_LIMIT;
    /**
     * 116: Too many data streams.
     */
    public final static int ERR_TOO_MANY_DATA_STREAMS = Constants.ERR_TOO_MANY_DATA_STREAMS;
    /**
     * 120: Decryption fails. The user may have used a different encryption password to join the
     * channel. Please check your settings or try rejoining the channel.
     */
    public final static int ERR_DECRYPTION_FAILED = Constants.ERR_DECRYPTION_FAILED;
    /**
     * 123: The client is banned by the server.
     */
    public final static int ERR_CLIENT_IS_BANNED_BY_SERVER =
        Constants.ERR_CLIENT_IS_BANNED_BY_SERVER;
    /**
     * 1001: Fails to load the media engine.
     */
    public final static int ERR_LOAD_MEDIA_ENGINE = Constants.ERR_LOAD_MEDIA_ENGINE;
    /**
     * 1002: Fails to start the call after enabling the media engine.
     */
    public final static int ERR_START_CALL = Constants.ERR_START_CALL;
    /**
     * 1003: Fails to start the camera.
     */
    public final static int ERR_START_CAMERA = Constants.ERR_START_CAMERA;
    /**
     * 1004: Fails to start the video rendering module.
     */
    public final static int ERR_START_VIDEO_RENDER = Constants.ERR_START_VIDEO_RENDER;
    /**
     * 1005: General error on the audio device module (no specified reason).
     */
    public final static int ERR_ADM_GENERAL_ERROR = Constants.ERR_ADM_GENERAL_ERROR;
    /**
     * 1006: Audio Device Module: An error occurs in using the Java resources.
     */
    public final static int ERR_ADM_JAVA_RESOURCE = Constants.ERR_ADM_JAVA_RESOURCE;
    /**
     * 1007: Audio Device Module: An error occurs in setting the sampling frequency.
     */
    public final static int ERR_ADM_SAMPLE_RATE = Constants.ERR_ADM_SAMPLE_RATE;
    /**
     * 1008: Audio Device Module: An error occurs in initializing the playback device.
     */
    public final static int ERR_ADM_INIT_PLAYOUT = Constants.ERR_ADM_INIT_PLAYOUT;
    /**
     * 1009: Audio Device Module: An error occurs when starting the playback device.
     */
    public final static int ERR_ADM_START_PLAYOUT = Constants.ERR_ADM_START_PLAYOUT;
    /**
     * 1010: Audio Device Module: An error occurs when stopping the playback device.
     */
    public final static int ERR_ADM_STOP_PLAYOUT = Constants.ERR_ADM_STOP_PLAYOUT;
    /**
     * 1011: Audio Device Module: An error occurs when initializing the recording device.
     */
    public final static int ERR_ADM_INIT_RECORDING = Constants.ERR_ADM_INIT_RECORDING;
    /**
     * 1012: Audio Device Module: An error occurs when starting the recording device.
     */
    public final static int ERR_ADM_START_RECORDING = Constants.ERR_ADM_START_RECORDING;
    /**
     * 1013: Audio Device Module: An error occurs when stopping the recording device.
     */
    public final static int ERR_ADM_STOP_RECORDING = Constants.ERR_ADM_STOP_RECORDING;
    /**
     * 1015: Audio Device Module: A runtime playback error occurs.
     */
    public final static int ERR_ADM_RUNTIME_PLAYOUT_ERROR = Constants.ERR_ADM_RUNTIME_PLAYOUT_ERROR;
    /**
     * 1017: Audio Device Module: A runtime recording error occurs.
     */
    public final static int ERR_ADM_RUNTIME_RECORDING_ERROR =
        Constants.ERR_ADM_RUNTIME_RECORDING_ERROR;
    /**
     * 1018: Audio Device Module: Fails to record the audio.
     */
    public final static int ERR_ADM_RECORD_AUDIO_FAILED = Constants.ERR_ADM_RECORD_AUDIO_FAILED;
    /**
     * 1022: Audio Device Module: An error occurs when initializing the loopback device.
     */
    public final static int ERR_ADM_INIT_LOOPBACK = Constants.ERR_ADM_INIT_LOOPBACK;
    /**
     * 1023: Audio Device Module: An error occurs when starting the loopback device.
     */
    public final static int ERR_ADM_START_LOOPBACK = Constants.ERR_ADM_START_LOOPBACK;
    /**
     * 1501: Video Device Module: The camera is not authorized.
     */
    public final static int ERR_VDM_CAMERA_NOT_AUTHORIZED = Constants.ERR_VDM_CAMERA_NOT_AUTHORIZED;
  }

  /**
   * @deprecated Use the new {@link Constants} class
   *  with the same constants value
   */
  @Deprecated
  public static class VideoProfile {
    /**
     *  160 x 120  @ 15 fps, 65 kbit/s
     */
    public final static int VIDEO_PROFILE_120P = Constants.VIDEO_PROFILE_120P;
    /**
     * 120 x 120  @ 15 fps, 50 kbit/s
     */
    public final static int VIDEO_PROFILE_120P_3 = Constants.VIDEO_PROFILE_120P_3;
    /**
     * 320 x 180  @ 15 fps, 140 kbit/s
     */
    public final static int VIDEO_PROFILE_180P = Constants.VIDEO_PROFILE_180P;
    /**
     * 180 x 180  @ 15 fps, 100 kbit/s
     */
    public final static int VIDEO_PROFILE_180P_3 = Constants.VIDEO_PROFILE_180P_3;
    /**
     * 240 x 180  @ 15 fps, 120 kbit/s
     */
    public final static int VIDEO_PROFILE_180P_4 = Constants.VIDEO_PROFILE_180P_4;
    /**
     * 320 x 240  @ 15 fps, 200 kbit/s
     */
    public final static int VIDEO_PROFILE_240P = Constants.VIDEO_PROFILE_240P;
    /**
     * 240 x 240  @ 15 fps, 140 kbit/s
     */
    public final static int VIDEO_PROFILE_240P_3 = Constants.VIDEO_PROFILE_240P_3;
    /**
     * 424 x 240  @ 15 fps, 220 kbit/s
     */
    public final static int VIDEO_PROFILE_240P_4 = Constants.VIDEO_PROFILE_240P_4;
    /**
     * 640 x 360  @ 15 fps, 400 kbit/s
     */
    public final static int VIDEO_PROFILE_360P = Constants.VIDEO_PROFILE_360P;
    /**
     * 360 x 360  @ 15 fps, 260 kbit/s
     */
    public final static int VIDEO_PROFILE_360P_3 = Constants.VIDEO_PROFILE_360P_3;
    /**
     * 640 x 360  @ 30 fps, 600 kbit/s
     */
    public final static int VIDEO_PROFILE_360P_4 = Constants.VIDEO_PROFILE_360P_4;
    /**
     * 360 x 360  @ 30 fps, 400 kbit/s
     */
    public final static int VIDEO_PROFILE_360P_6 = Constants.VIDEO_PROFILE_360P_6;
    /**
     * 480 x 360  @ 15 fps, 320 kbit/s
     */
    public final static int VIDEO_PROFILE_360P_7 = Constants.VIDEO_PROFILE_360P_7;
    /**
     * 480 x 360  @ 30 fps, 490 kbit/s
     */
    public final static int VIDEO_PROFILE_360P_8 = Constants.VIDEO_PROFILE_360P_8;
    /**
     * 640 x 480  @ 15 fps, 500 kbit/s
     */
    public final static int VIDEO_PROFILE_480P = Constants.VIDEO_PROFILE_480P;
    /**
     * 480 x 480  @ 15 fps, 400 kbit/s
     */
    public final static int VIDEO_PROFILE_480P_3 = Constants.VIDEO_PROFILE_480P_3;
    /**
     * 640 x 480  @ 30 fps, 750 kbit/s
     */
    public final static int VIDEO_PROFILE_480P_4 = Constants.VIDEO_PROFILE_480P_4;
    /**
     * 480 x 480  @ 30 fps, 600 kbit/s
     */
    public final static int VIDEO_PROFILE_480P_6 = Constants.VIDEO_PROFILE_480P_6;
    /**
     * 848 x 480  @ 15 fps, 610 kbit/s
     */
    public final static int VIDEO_PROFILE_480P_8 = Constants.VIDEO_PROFILE_480P_8;
    /**
     * 848 x 480  @ 30 fps, 930 kbit/s
     */
    public final static int VIDEO_PROFILE_480P_9 = Constants.VIDEO_PROFILE_480P_9;
    /**
     * 1280 x 720  @ 15 fps, 1130 kbit/s
     */
    public final static int VIDEO_PROFILE_720P = Constants.VIDEO_PROFILE_720P;
    /**
     * 1280 x 720  @ 30 fps, 1710 kbit/s
     */
    public final static int VIDEO_PROFILE_720P_3 = Constants.VIDEO_PROFILE_720P_3;
    /**
     * 960 x 720  @ 15 fps, 910 kbit/s
     */
    public final static int VIDEO_PROFILE_720P_5 = Constants.VIDEO_PROFILE_720P_5;
    /**
     * 960 x 720  @ 30 fps, 1380 kbit/s
     */
    public final static int VIDEO_PROFILE_720P_6 = Constants.VIDEO_PROFILE_720P_6;
    /**
     * 1920 x 1080  @ 15 fps, 2080 kbit/s
     */
    public final static int VIDEO_PROFILE_1080P = Constants.VIDEO_PROFILE_1080P;
    /**
     * 1920 x 1080  @ 30 fps, 3150 kbit/s
     */
    public final static int VIDEO_PROFILE_1080P_3 = Constants.VIDEO_PROFILE_1080P_3;
    /**
     * 1920 x 1080  @ 60 fps, 4780 kbit/s
     */
    public final static int VIDEO_PROFILE_1080P_5 = Constants.VIDEO_PROFILE_1080P_5;
    /**
     * 2560 x 1440  @ 30 fps, 4850 kbit/s
     */
    public final static int VIDEO_PROFILE_1440P = Constants.VIDEO_PROFILE_1440P;
    /**
     * 2560 x 1440  @ 60 fps, 7350 kbit/s
     */
    public final static int VIDEO_PROFILE_1440P_2 = Constants.VIDEO_PROFILE_1440P_2;
    /**
     * 3840 x 2160  @ 30 fps, 8910 kbit/s
     */
    public final static int VIDEO_PROFILE_4K = Constants.VIDEO_PROFILE_4K;
    /**
     * <p>3840 x 2160  @ 60 fps, 13500 kbit/s
     */
    public final static int VIDEO_PROFILE_4K_3 = Constants.VIDEO_PROFILE_4K_3;
    /**
     * <p>Default video profile: 640 x 360  @ 15 fps, 400 kbit/s
     */
    public final static int VIDEO_PROFILE_DEFAULT = Constants.VIDEO_PROFILE_DEFAULT;
  }

  /**
   * @deprecated Use the new {@link Constants} class
   *  with the same constants value
   */
  @Deprecated
  public static class ClientRole {
    /**
     * The host in a live broadcast.
     */
    public final static int CLIENT_ROLE_BROADCASTER = Constants.CLIENT_ROLE_BROADCASTER;
    /**
     * The audience in a live broadcast.
     */
    public final static int CLIENT_ROLE_AUDIENCE = Constants.CLIENT_ROLE_AUDIENCE;
  }

  /**
   * @deprecated Use the new {@link Constants} class
   *  with the same constants value
   */
  @Deprecated
  public static class UserOfflineReason {
    /**
     * The user has quit the call.
     */
    public final static int USER_OFFLINE_QUIT = Constants.USER_OFFLINE_QUIT;
    /**
     * The SDK timed out and the user dropped offline because it has not received any data package
     * for a period of time.
     */
    public final static int USER_OFFLINE_DROPPED = Constants.USER_OFFLINE_DROPPED;
  }

  /**
   * Audio volume information.
   */
  public static class AudioVolumeInfo {
    /**
     * The user ID of the speaker. The uid of the local user is 0.
     */
    public int uid;
    /**
     * The volume of the speaker that ranges from 0 (lowest volume) to 255 (highest volume).
     */
    public int volume;
    public int vad;
    /**
     * Voice pitch frequency in Hz
     */
    public double voicePitch;
  }

  /**
   * Statistics of RtcEngine.
   */
  public static class RtcStats {
    /**
     * The call duration in seconds, represented by an aggregate value.
     */
    public int totalDuration;
    /**
     * The total number of bytes transmitted, represented by an aggregate value.
     */
    public int txBytes;
    /**
     * The total number of bytes received, represented by an aggregate value.
     */
    public int rxBytes;
    /**
     * The transmission bitrate in Kbps, represented by an instantaneous value.
     */
    public int txKBitRate;
    /**
     * Total number of audio bytes sent (bytes), represented by an aggregate value.
     */
    public int txAudioBytes;
    /**
     * Total number of audio bytes received (bytes) before network countermeasures, represented by
     * an aggregate value.
     */
    public int rxAudioBytes;
    /**
     * Total number of video bytes sent (bytes), represented by an aggregate value.
     */
    public int txVideoBytes;
    /**
     * Total number of video bytes received (bytes), represented by an aggregate value.
     */
    public int rxVideoBytes;
    /**
     * The receiving bitrate in Kbps, represented by an instantaneous value.
     */
    public int rxKBitRate;
    /**
     * The audio transmission bitrate in Kbps, represented by an instantaneous value.
     */
    public int txAudioKBitRate;
    /**
     * The audio receiving bitrate in Kbps, represented by an instantaneous value.
     */
    public int rxAudioKBitRate;
    /**
     * The video transmission bitrate in Kbps, represented by an instantaneous value.
     */
    public int txVideoKBitRate;
    /**
     * The video receiving bitrate in Kbps, represented by an instantaneous value.
     */
    public int rxVideoKBitRate;
    /**
     * The VOS client-server latency (ms).
     */
    public int lastmileDelay;
    /**
     * The system CPU usage (%).
     */
    public double cpuTotalUsage;
    /**
     * gateway Rtt
     */
    public int gatewayRtt;
    /**
     * The application CPU usage (%).
     */
    public double cpuAppUsage;
    /**
     * The number of users in the channel.
     */
    public int users;
    /**
     * The duration (ms) between connection establish and connect start, 0 if not valid.
     */
    public int connectTimeMs;
    /**
     * The packet loss rate of sender(broadcaster).
     */
    public int txPacketLossRate;
    /**
     * The packet loss rate of receiver(audience).
     */
    public int rxPacketLossRate;
    /**
     * The application memory usage (%).
     */
    public double memoryAppUsageRatio;
    /**
     * The system memory usage (%).
     */
    public double memoryTotalUsageRatio;
    /**
     * The application memory usage (Kbyte).
     */
    public int memoryAppUsageInKbytes;
  }

  /**
   * Statistics of the last-mile probe.
   */
  public static class LastmileProbeResult {
    /**
     * The one-way last-mile probe result.
     */
    public static class LastmileProbeOneWayResult {
      /**
       * The packet loss rate (%).
       */
      public int packetLossRate;
      /**
       * The network jitter (ms).
       */
      public int jitter;
      /**
       * The estimated available bandwidth (bps).
       */
      public int availableBandwidth;
    }

    /**
     * The state of the probe test:
     * <ul>
     *     <li>{@link io.agora.rtc2.Constants#LASTMILE_PROBE_RESULT_COMPLETE
     * LASTMILE_PROBE_RESULT_COMPLETE(1)}: the last-mile network probe test is complete. <li>{@link
     * io.agora.rtc2.Constants#LASTMILE_PROBE_RESULT_INCOMPLETE_NO_BWE
     * LASTMILE_PROBE_RESULT_INCOMPLETE_NO_BWE(2)}: the last-mile network probe test is incomplete
     * and the bandwidth estimation is not available, probably due to limited test resources.
     *     <li>{@link io.agora.rtc2.Constants#LASTMILE_PROBE_RESULT_UNAVAILABLE
     * LASTMILE_PROBE_RESULT_UNAVAILABLE(3)}: the last-mile network probe test is not carried out,
     * probably due to poor network conditions.
     * </ul>
     */
    public short state;
    /**
     * The round-trip delay time (ms).
     */
    public int rtt;
    /**
     * The uplink last-mile network report. For details, see {@link LastmileProbeOneWayResult
     * LastmileProbeOneWayResult}.
     */
    public LastmileProbeOneWayResult uplinkReport = new LastmileProbeOneWayResult();
    /**
     * The downlink last-mile network report. For details, see {@link LastmileProbeOneWayResult
     * LastmileProbeOneWayResult}.
     */
    public LastmileProbeOneWayResult downlinkReport = new LastmileProbeOneWayResult();
  }

  /**
   * Statistics of the local video.
   */
  public static class LocalVideoStats {
    /**
     * ID of the local user whose video is sent.
     */
    public int uid;
    /**
     * Bitrate (Kbps) sent in the reported interval, which does not include
     * the bitrate of the retransmission video after packet loss.
     */
    public int sentBitrate;
    /**
     * Frame rate (fps) sent in the reported interval, which does not include
     * the frame rate of the retransmission video after packet loss.
     */
    public int sentFrameRate;
    /**
     * The encoder output frame rate (fps) of the local video.
     */
    public int encoderOutputFrameRate;
    /**
     * The render output frame rate (fps) of the local video.
     */
    public int rendererOutputFrameRate;
    /**
     *  The target bitrate (Kbps) of the current encoder. This value is estimated by the SDK based
     * on the current network conditions.
     */
    public int targetBitrate;
    /**
     * The target frame rate (fps) of the current encoder.
     */
    public int targetFrameRate;
    /**
     * Quality change of the local video in terms of target frame rate and target bit rate since
     * last count.
     * @since v2.4.0.
     * - {@link Constants#ADAPT_NONE ADAPT_NONE(0)}: The quality of the local video stays the same.
     * - {@link Constants#ADAPT_UP_BANDWIDTH ADAPT_UP_BANDWIDTH(1)}: The quality improves because
     * the network bandwidth increases.
     * - {@link Constants#ADAPT_DOWN_BANDWIDTH ADAPT_DOWN_BANDWIDTH(2)}: The quality worsens because
     * the network bandwidth decreases.
     */
    public int qualityAdaptIndication;
    /**
     * The encoding bitrate (Kbps), which does not include the bitrate of the
     * re-transmission video after packet loss.
     */
    public int encodedBitrate;
    /**
     * The width of the encoding frame (px).
     */
    public int encodedFrameWidth;
    /**
     * The height of the encoding frame (px).
     */
    public int encodedFrameHeight;
    /**
     * The value of the sent frames, represented by an aggregate value.
     */
    public int encodedFrameCount;
    /**
     * The codec type of the local video:
     * - VIDEO_CODEC_VP8 = 1: VP8.
     * - VIDEO_CODEC_H264 = 2: (Default) H.264.
     */
    public int codecType;
  }

  /**
   * Statistics of the remote video.
   */
  public static class RemoteVideoStats {
    /**
     * User ID of the remote user sending the video streams.
     */
    public int uid;
    /**
     * **DEPRECATED** Time delay (ms).
     */
    public int delay;
    /**
     * Width (pixels) of the video stream.
     */
    public int width;
    /**
     * Height (pixels) of the video stream.
     */
    public int height;
    /**
     * Bitrate (Kbps) received since the last count.
     */
    public int receivedBitrate;
    /**
     * The decoder output frame rate (fps) of the remote video.
     */
    public int decoderOutputFrameRate;
    /**
     * The render output frame rate (fps) of the remote video.
     */
    public int rendererOutputFrameRate;
    /**
     * The video frame loss rate (%) of the remote video stream in the reported interval.
     */
    public int frameLossRate;
    /**
     *  Packet loss rate (%) of the remote video stream after using the anti-packet-loss method.
     */
    public int packetLossRate;
    /**
     * Remote video stream type
     */
    public int rxStreamType;
    /**
     * The total freeze time (ms) of the remote video stream after the remote user joins the
     * channel. In a video session where the frame rate is set to no less than 5 fps, video freeze
     * occurs when the time interval between two adjacent renderable video frames is more than 500
     * ms.
     */
    public int totalFrozenTime;
    /**
     * The total video freeze time as a percentage (%) of the total time when the video is
     * available.
     */
    public int frozenRate;
    /**
     * The offset (ms) between audio and video stream. A positive value indicates the audio leads
     * the video, and a negative value indicates the audio lags the video.
     */
    public int avSyncTimeMs;

    /**
     The total time (ms) when the remote user neither stops sending the video
     stream nor disables the video module after joining the channel.
     */
    public long totalActiveTime;
    /**
     The total publish duration (ms) of the remote video stream.
     */
    public long publishDuration;
  }

  /**
   * The statistics of the local audio.
   */
  public static class LocalAudioStats {
    /**
     * The number of channels.
     */
    public int numChannels;
    /**
     * The sample rate (Hz).
     */
    public int sentSampleRate;
    /**
     * The average sending bitrate (Kbps).
     */
    public int sentBitrate;
    /**
     * The internal payload type
     */
    public int internalCodec;
  };

  /**
   * Statistics of the remote audio.
   */
  public static class RemoteAudioStats {
    /**
     * ID of the user sending the audio streams.
     */
    public int uid;
    /**
     * The receiving audio quality:
     * - `QUALITY_UNKNOWN(0)`: The quality is unknown.
     * - `QUALITY_EXCELLENT(1)`: The quality is excellent.
     * - `QUALITY_GOOD QUALITY_GOOD(2)`: The quality is quite good, but the bitrate may be slightly
     * lower than excellent.
     * - `QUALITY_POOR(3)`: Users can feel the communication slightly impaired.
     * - `QUALITY_BAD(4)`: Users can communicate not very smoothly.
     * - `QUALITY_VBAD(5)`: The quality is so bad that users can barely communicate.
     * - `QUALITY_DOWN(6)`: The network is disconnected and users cannot communicate at all.
     */
    public int quality;
    /**
     * The network delay from the sender to the receiver.
     */
    public int networkTransportDelay;
    /**
     * The jitter buffer delay at the receiver.
     */
    public int jitterBufferDelay;
    /**
     * The packet loss rate in the reported interval.
     */
    public int audioLossRate;
    /**
     * The number of channels.
     */
    public int numChannels;
    /**
     * The sample rate (Hz) of the received audio stream, represented by an instantaneous value.
     */
    public int receivedSampleRate;
    /**
     * The bitrate (Kbps) of the received audio stream, represented by an
     * instantaneous value.
     */
    public int receivedBitrate;
    /**
     * The total freeze time (ms) of the remote audio stream after the remote user
     * joins the channel. In a session, audio freeze occurs when the audio frame loss rate reaches
     * 4% within two seconds.
     */
    public int totalFrozenTime;
    /**
     * The total audio freeze time as a percentage (%) of the total time when the
     * audio is available.
     */
    public int frozenRate;
    /**
     * The quality of the remote audio stream as determined by the Agora
     * real-time audio MOS (Mean Opinion Score) measurement method in the
     * reported interval. The return value ranges from 0 to 500. Dividing the
     * return value by 100 gets the MOS score, which ranges from 0 to 5. The
     * higher the score, the better the audio quality.
     *
     * The subjective perception of audio quality corresponding to the Agora
     * real-time audio MOS scores is as follows:
     *
     * | MOS score       | Perception of audio quality |
     * |-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
     * | Greater than 4  | Excellent. The audio sounds clear and smooth. | | From 3.5 to 4   | Good.
     * The audio has some perceptible impairment, but still sounds clear. | | From 3 to 3.5   |
     * Fair. The audio freezes occasionally and requires attentive listening. | | From 2.5 to 3   |
     * Poor. The audio sounds choppy and requires considerable effort to understand. | | From 2
     * to 2.5   | Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting
     * in some information loss. The users can communicate only with difficulty.  | | Less than 2 |
     * Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting
     * in severe information loss. Communication is nearly impossible. |
     *
     */
    public int mosValue;

    /**
     * The total time (ms) when the remote user neither stops sending the audio
     * stream nor disables the audio module after joining the channel.
     */
    public long totalActiveTime;
    /**
     * The total publish duration (ms) of the remote audio stream.
     */
    public long publishDuration;
  }

  /** The information of the detected human face. */
  public static class AgoraFacePositionInfo {
    /**
     * The x coordinate (px) of the human face in the local video. Taking the top left corner of
     * the captured video as the origin, the x coordinate represents the relative lateral
     * displacement of the top left corner of the human face to the origin.
     *
     * */
    public int x;
    /**
     *  The y coordinate (px) of the human face in the local video. Taking the top left corner of
     *  the captured video as the origin, the y coordinate represents the relative longitudinal
     *  displacement of the top left corner of the human face to the origin.
     * */
    public int y;
    /** The width (px) of the human face in the captured video. */
    public int width;
    /** The height (px) of the human face in the captured video. */
    public int height;
    /** The distance (cm) between the human face and the screen. */
    public int distance;
  }

  /**
   * The statistics of the uplink network info.
   */
  public static class UplinkNetworkInfo {
    /**
     * The encoder target bitrate bps.
     */
    public int video_encoder_target_bitrate_bps;
  };

  /**
   * The statistics of the downlink network info.
   */
  public static class DownlinkNetworkInfo {
    /**
     * The lastmile buffer delay time in ms.
     */
    public int lastmile_buffer_delay_time_ms;
    /**
     * The bandwidth estimation bitrate in bps.
     */
    public int bandwidth_estimation_bps;
  };

  /**
   * The local audio state type.
   */
  public enum LOCAL_AUDIO_STREAM_STATE {
    /**
     * 0: The initial state.
     */
    LOCAL_AUDIO_STREAM_STATE_STOPPED(0),
    /**
     * 1: The capturer starts successfully.
     */
    LOCAL_AUDIO_STREAM_STATE_RECORDING(1),
    /**
     * 2: The first video frame is successfully encoded.
     */
    LOCAL_AUDIO_STREAM_STATE_ENCODING(2),
    /**
     * 3: The local video fails to start.
     */
    LOCAL_AUDIO_STREAM_STATE_FAILED(3);

    private int value;
    private LOCAL_AUDIO_STREAM_STATE(int v) {
      value = v;
    }

    public static int getValue(LOCAL_AUDIO_STREAM_STATE type) {
      return type.value;
    }
  }

  /**
   * The local audio state type.
   */
  public enum LOCAL_AUDIO_STREAM_ERROR {
    /**
     * 0: The local audio is normal.
     */
    LOCAL_AUDIO_STREAM_ERROR_OK(0),
    /**
     * 1: No specified reason for the local audio failure.
     */
    LOCAL_AUDIO_STREAM_ERROR_FAILURE(1),
    /**
     * 2: No permission to use the local audio device.
     */
    LOCAL_AUDIO_STREAM_ERROR_DEVICE_NO_PERMISSION(2),
    /**
     * 3: The microphone is in use.
     */
    LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY(3),
    /**
     * 4: The local audio recording fails. Check whether the recording device
     * is working properly.
     */
    LOCAL_AUDIO_STREAM_ERROR_RECORD_FAILURE(4),
    /**
     * 5: The local audio encoding fails.
     */
    LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE(5);

    private int value;
    private LOCAL_AUDIO_STREAM_ERROR(int v) {
      value = v;
    }

    public static int getValue(LOCAL_AUDIO_STREAM_ERROR type) {
      return type.value;
    }
  }

  /**
   * Remote audio states.
   */
  public enum REMOTE_AUDIO_STATE {
    /**
     * 0: The remote audio is in the default state, probably due to
     * #REMOTE_AUDIO_REASON_LOCAL_MUTED (3),
     * #REMOTE_AUDIO_REASON_REMOTE_MUTED (5), or
     * #REMOTE_AUDIO_REASON_REMOTE_OFFLINE (7).
     */
    REMOTE_AUDIO_STATE_STOPPED(
        0), // Default state, audio is started or remote user disabled/muted audio stream
    /**
     * 1: The first remote audio packet is received.
     */
    REMOTE_AUDIO_STATE_STARTING(1), // The first audio frame packet has been received
    /**
     * 2: The remote audio stream is decoded and plays normally, probably
     * due to #REMOTE_AUDIO_REASON_NETWORK_RECOVERY (2),
     * #REMOTE_AUDIO_REASON_LOCAL_UNMUTED (4), or
     * #REMOTE_AUDIO_REASON_REMOTE_UNMUTED (6).
     */
    REMOTE_AUDIO_STATE_DECODING(
        2), // The first remote audio frame has been decoded or fronzen state ends
    /**
     * 3: The remote audio is frozen, probably due to
     * #REMOTE_AUDIO_REASON_NETWORK_CONGESTION (1).
     */
    REMOTE_AUDIO_STATE_FROZEN(3), // Remote audio is frozen, probably due to network issue
    /**
     * 4: The remote audio fails to start, probably due to
     * #REMOTE_AUDIO_REASON_INTERNAL (0).
     */
    REMOTE_AUDIO_STATE_FAILED(4); // Remote audio play failed

    private int value;
    private REMOTE_AUDIO_STATE(int v) {
      value = v;
    }

    public static int getValue(REMOTE_AUDIO_STATE type) {
      return type.value;
    }
  }

  /**
   * Remote audio state reasons.
   */
  public enum REMOTE_AUDIO_STATE_REASON {
    /**
     * 0: Internal reasons.
     */
    REMOTE_AUDIO_REASON_INTERNAL(0),
    /**
     * 1: Network congestion.
     */
    REMOTE_AUDIO_REASON_NETWORK_CONGESTION(1),
    /**
     * 2: Network recovery.
     */
    REMOTE_AUDIO_REASON_NETWORK_RECOVERY(2),
    /**
     * 3: The local user stops receiving the remote audio stream or
     * disables the audio module.
     */
    REMOTE_AUDIO_REASON_LOCAL_MUTED(3),
    /**
     * 4: The local user resumes receiving the remote audio stream or
     * enables the audio module.
     */
    REMOTE_AUDIO_REASON_LOCAL_UNMUTED(4),
    /**
     * 5: The remote user stops sending the audio stream or disables the
     * audio module.
     */
    REMOTE_AUDIO_REASON_REMOTE_MUTED(5),
    /**
     * 6: The remote user resumes sending the audio stream or enables the
     * audio module.
     */
    REMOTE_AUDIO_REASON_REMOTE_UNMUTED(6),
    /**
     * 7: The remote user leaves the channel.
     */
    REMOTE_AUDIO_REASON_REMOTE_OFFLINE(7);

    private int value;
    private REMOTE_AUDIO_STATE_REASON(int v) {
      value = v;
    }

    public static int getValue(REMOTE_AUDIO_STATE_REASON type) {
      return type.value;
    }
  }

  /**
    The state of the rhythm player.
   */
  public enum RHYTHM_PLAYER_STATE_TYPE {
    /** 810: The rhythm player is idle. */
    RHYTHM_PLAYER_STATE_IDLE(810),
    /** 811: The rhythm player is opening files. */
    RHYTHM_PLAYER_STATE_OPENING(811),
    /** 812: Files opened successfully, the rhythm player starts decoding files. */
    RHYTHM_PLAYER_STATE_DECODING(812),
    /**
     * 813: Files decoded successfully, the rhythm player starts mixing the two files and playing
     * back them locally.
     */
    RHYTHM_PLAYER_STATE_PLAYING(813),
    /**
     * 814: The rhythm player is starting to fail, and you need to check the error code for
     * detailed failure reasons
     */
    RHYTHM_PLAYER_STATE_FAILED(814);

    private int value;
    RHYTHM_PLAYER_STATE_TYPE(int v) {
      this.value = v;
    }

    public int getValue() {
      return this.value;
    }

    public static RHYTHM_PLAYER_STATE_TYPE fromInt(int v) {
      for (RHYTHM_PLAYER_STATE_TYPE type : values()) {
        if (type.getValue() == v) {
          return type;
        }
      }
      return RHYTHM_PLAYER_STATE_FAILED;
    }
  }

  /**
   The error codes of the rhythm player.
   */
  public enum RHYTHM_PLAYER_ERROR_TYPE {
    /** 0: The rhythm player works well. */
    RHYTHM_PLAYER_ERROR_OK(0),
    /** 1: The rhythm player occurs a internal error. */
    RHYTHM_PLAYER_ERROR_FAILED(1),
    /** 801: The rhythm player can not open the file. */
    RHYTHM_PLAYER_ERROR_CAN_NOT_OPEN(801),
    /** 802: The rhythm player can not play the file. */
    RHYTHM_PLAYER_ERROR_CAN_NOT_PLAY(802),
    /** 803: The file duration over the limit. The file duration limit is 1.2 seconds. */
    RHYTHM_PLAYER_ERROR_FILE_OVER_DURATION_LIMIT(803);

    private int value;
    RHYTHM_PLAYER_ERROR_TYPE(int v) {
      this.value = v;
    }

    public int getValue() {
      return this.value;
    }

    public static RHYTHM_PLAYER_ERROR_TYPE fromInt(int v) {
      for (RHYTHM_PLAYER_ERROR_TYPE type : values()) {
        if (type.getValue() == v) {
          return type;
        }
      }
      return RHYTHM_PLAYER_ERROR_FAILED;
    }
  }

  /**
   * States of the RTMP streaming.
   */
  public enum RTMP_STREAM_PUBLISH_STATE {
    /**
     * 0: The RTMP streaming has not started or has ended.
     *
     * This state is also reported after you remove
     * an RTMP address from the CDN by calling `removePublishStreamUrl`.
     */
    RTMP_STREAM_PUBLISH_STATE_IDLE(0),
    /**
     * 1: The SDK is connecting to the streaming server and the RTMP server.
     *
     * This state is reported after you call `addPublishStreamUrl`.
     */
    RTMP_STREAM_PUBLISH_STATE_CONNECTING(1),
    /**
     * 2: The RTMP streaming publishes. The SDK successfully publishes the RTMP streaming and
     * returns this state.
     */
    RTMP_STREAM_PUBLISH_STATE_RUNNING(2),
    /**
     * 3: The RTMP streaming is recovering. When exceptions occur to the CDN, or the streaming is
     * interrupted, the SDK tries to resume RTMP streaming and reports this state.
     *
     * - If the SDK successfully resumes the streaming, `RTMP_STREAM_PUBLISH_STATE_RUNNING(2)` is
     * reported.
     * - If the streaming does not resume within 60 seconds or server errors occur,
     * `RTMP_STREAM_PUBLISH_STATE_FAILURE(4)` is reported. You can also reconnect to the server by
     * calling `removePublishStreamUrl` and `addPublishStreamUrl`.
     */
    RTMP_STREAM_PUBLISH_STATE_RECOVERING(3),
    /**
     * 4: The RTMP streaming fails. See the `errCode` parameter for the detailed error information.
     * You can also call `addPublishStreamUrl` to publish the RTMP streaming again.
     */
    RTMP_STREAM_PUBLISH_STATE_FAILURE(4);

    private int value;
    private RTMP_STREAM_PUBLISH_STATE(int v) {
      value = v;
    }

    public int getValue() {
      return value;
    }

    public static RTMP_STREAM_PUBLISH_STATE fromInt(int v) {
      for (RTMP_STREAM_PUBLISH_STATE type : values()) {
        if (type.getValue() == v) {
          return type;
        }
      }
      return RTMP_STREAM_PUBLISH_STATE_FAILURE;
    }
  }

  /**
   * Error codes of the RTMP streaming.
   */
  public enum RTMP_STREAM_PUBLISH_ERROR {
    /**
     * -1: The RTMP streaming fails.
     */
    RTMP_STREAM_PUBLISH_ERROR_FAILED(-1),
    /**
     * 0: The RTMP streaming publishes successfully.
     */
    RTMP_STREAM_PUBLISH_ERROR_OK(0),
    /**
     * 1: Invalid argument. If, for example, you did not call `setLiveTranscoding` to configure the
     * LiveTranscoding parameters before calling `addPublishStreamUrl`, the SDK reports this error.
     * Check whether you set the parameters in `LiveTranscoding` properly.
     */
    RTMP_STREAM_PUBLISH_ERROR_INVALID_ARGUMENT(1),
    /**
     * 2: The RTMP streaming is encrypted and cannot be published.
     */
    RTMP_STREAM_PUBLISH_ERROR_ENCRYPTED_STREAM_NOT_ALLOWED(2),
    /**
     * 3: A timeout occurs with the RTMP streaming. Call `addPublishStreamUrl`
     * to publish the streaming again.
     */
    RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT(3),
    /**
     * 4: An error occurs in the streaming server. Call `addPublishStreamUrl` to publish
     * the stream again.
     */
    RTMP_STREAM_PUBLISH_ERROR_INTERNAL_SERVER_ERROR(4),
    /**
     * 5: An error occurs in the RTMP server.
     */
    RTMP_STREAM_PUBLISH_ERROR_RTMP_SERVER_ERROR(5),
    /**
     * 6: The RTMP streaming publishes too frequently.
     */
    RTMP_STREAM_PUBLISH_ERROR_TOO_OFTEN(6),
    /**
     * 7: The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
     */
    RTMP_STREAM_PUBLISH_ERROR_REACH_LIMIT(7),
    /**
     * 8: The host manipulates other hosts' URLs. Check your app logic.
     */
    RTMP_STREAM_PUBLISH_ERROR_NOT_AUTHORIZED(8),
    /**
     * 9: The Agora server fails to find the RTMP streaming.
     */
    RTMP_STREAM_PUBLISH_ERROR_STREAM_NOT_FOUND(9),
    /**
     * 10: The format of the RTMP streaming URL is not supported. Check whether the URL format is
     * correct.
     */
    RTMP_STREAM_PUBLISH_ERROR_FORMAT_NOT_SUPPORTED(10),
    /**
     * 11: CDN related errors. Remove the original URL address and add a new one by calling
     * `removePublishStreamUrl` and `addPublishStreamUrl`.
     */
    RTMP_STREAM_PUBLISH_ERROR_CDN_ERROR(11),
    /**
     * 12: Resources are occupied and cannot be reused.
     */
    RTMP_STREAM_PUBLISH_ERROR_ALREADY_IN_USE(12),
    /**
     * 100:The streaming has been stopped normally. After you call
     * \ref IRtcEngine::removePublishStreamUrl "removePublishStreamUrl"
     * to stop streaming, the SDK returns this value.
     */
    RTMP_STREAM_UNPUBLISH_ERROR_OK(100);

    private int value;
    private RTMP_STREAM_PUBLISH_ERROR(int v) {
      value = v;
    }

    public int getValue() {
      return this.value;
    }

    public static RTMP_STREAM_PUBLISH_ERROR fromInt(int v) {
      for (RTMP_STREAM_PUBLISH_ERROR type : values()) {
        if (type.getValue() == v) {
          return type;
        }
      }
      return RTMP_STREAM_PUBLISH_ERROR_FAILED;
    }
  }

  /**
   * Error type of encryption.
   */
  public enum ENCRYPTION_ERROR_TYPE {
    ENCRYPTION_ERROR_INTERNAL_FAILURE(0),
    ENCRYPTION_ERROR_DECRYPTION_FAILURE(1),
    ENCRYPTION_ERROR_ENCRYPTION_FAILURE(2);

    private int value;
    private ENCRYPTION_ERROR_TYPE(int v) {
      value = v;
    }

    public static int getValue(ENCRYPTION_ERROR_TYPE type) {
      return type.value;
    }
  }

  /**
   * The stream subscribe state.
   */
  public enum STREAM_SUBSCRIBE_STATE {
    SUB_STATE_IDLE(0),
    SUB_STATE_NO_SUBSCRIBED(1),
    SUB_STATE_SUBSCRIBING(2),
    SUB_STATE_SUBSCRIBED(3);

    private int value;

    private STREAM_SUBSCRIBE_STATE(int v) {
      value = v;
    }

    public static int getValue(STREAM_SUBSCRIBE_STATE type) {
      return type.value;
    }
  }

  /**
   * The stream publish state.
   */
  public enum STREAM_PUBLISH_STATE {
    PUB_STATE_IDLE(0),
    PUB_STATE_NO_PUBLISHED(1),
    PUB_STATE_PUBLISHING(2),
    PUB_STATE_PUBLISHED(3);

    private int value;

    private STREAM_PUBLISH_STATE(int v) {
      value = v;
    }

    public static int getValue(STREAM_PUBLISH_STATE type) {
      return type.value;
    }
  }

  /**
   * Type of permission.
   */
  public enum PERMISSION {
    RECORD_AUDIO(0),
    CAMERA(1);

    private int value;
    private PERMISSION(int v) {
      value = v;
    }

    public static int getValue(PERMISSION type) {
      return type.value;
    }
  }

  /**
   * <p>A warning occurred during SDK runtime.
   * @deprecated
   * <p>In most cases, the application can ignore the warnings reported by the SDK because the SDK
   * can usually fix the issue and resume running. For instance, the SDK may report a {@link
   * Constants#WARN_LOOKUP_CHANNEL_TIMEOUT WARN_LOOKUP_CHANNEL_TIMEOUT} warning upon disconnection
   * with the server and attempts to reconnect.
   *
   * @param warn {@link WarnCode Warning code}
   */
  @Deprecated
  public void onWarning(int warn) {}

  /**
   * <p>An error occurred during SDK runtime.
   * @deprecated
   * <p>In most cases, reporting an error means that the SDK cannot fix the issue and resume
   * running, and therefore requires actions from the application or simply informs the user about
   * the issue. For instance, the SDK reports an {@link Constants#ERR_START_CALL ERR_START_CALL}
   * error when it fails to initialize a call. In this case, the application informs the user that
   * the call initialization has failed, and calls the {@link RtcEngine#leaveChannel() leaveChannel}
   * method to exit the channel.
   *
   * @param err {@link ErrorCode Error code}
   */
  @Deprecated
  public void onError(int err) {}

  /**
   * Occurs when the local user successfully joins the specified channel.
   *
   * @param channel The channel name.
   * @param uid The user ID.
   * - If you specified a `uid` in the `joinChannel` method, the SDK returns the specified ID;
   * - If not, this callback returns an ID that is automatically assigned by the Agora server.
   * @param elapsed The time elapsed (ms) from the local user calling {@link RtcEngine#joinChannel
   *     joinChannel}
   * until this event occurs.
   */
  public void onJoinChannelSuccess(String channel, int uid, int elapsed) {}

  /**
   * Occurs when the local user rejoins the channel after being disconnected due to
   * network problems.
   *
   * When the app loses connection with the server because of network
   * problems, the SDK automatically tries to reconnect to the server, and triggers this
   * callback method upon reconnection.
   *
   * @param channel The channel name.
   * @param uid The user ID.
   * @param elapsed Time elapsed (ms) from starting to reconnect until this callback is triggered
   */
  public void onRejoinChannelSuccess(String channel, int uid, int elapsed) {}

  /**
   * Occurs when the local user successfully leaves the channel.
   *
   * When the user successfully leaves the channel after calling {@link RtcEngine#leaveChannel
   * leaveChannel}, the SDK uses this callback to notify the app that the user has left the channel.
   *
   * This callback also reports information such as the call duration and the statistics of data
   * received or transmitted by the SDK.
   *
   * @param stats The statistics on the call: {@link RtcStats RtcStats}.
   */
  public void onLeaveChannel(RtcStats stats) {}

  /**
   * Occurs when the user role in a Live-Broadcast channel has switched, for example, from a
   * broadcaster to an audience or vice versa.
   *
   * @param oldRole The old role of the user.
   * @param newRole The new role of the user
   */
  public void onClientRoleChanged(int oldRole, int newRole) {}

  /**
   * Occurs when the local user registers a user account.
   * @since v2.8.0.
   *
   * This callback is triggered when the local user successfully registers a user account by calling
  the {@link RtcEngine#registerLocalUserAccount registerLocalUserAccount} method, or joins a
  channel by calling the {@link RtcEngine#joinChannelWithUserAccount joinChannelWithUserAccount}
  method. This callback reports the user ID and user account of the local user.
   * @param uid The ID of the local user.
   * @param userAccount The user account of the local user.
   */
  @Override
  public void onLocalUserRegistered(int uid, String userAccount) {}
  /**
   * Occurs when the SDK gets the user ID and user account of the remote user.
   * @since v2.8.0.
   *
   * After a remote user joins the channel, the SDK gets the UID and user account of the remote
   * user, caches them in a mapping table object ({@link io.agora.rtc2.UserInfo UserInfo}),
   * and triggers this callback on the local client.
   * @param uid The ID of the remote user.
   * @param userInfo The {@link io.agora.rtc2.UserInfo UserInfo} object that contains the user
   *     ID and user account of the remote user.
   */
  @Override
  public void onUserInfoUpdated(int uid, UserInfo userInfo) {}

  /**
   * Occurs when a remote user or broadcaster joins the channel.
   *
   * If other users are already in the channel, the SDK also reports to the app on the existing
   * users.
   *
   * The SDK triggers this callback under one of the following circumstances:
   * - A broadcaster joins the channel by calling {@link RtcEngine#joinChannel
   * joinChannel}.
   * - A remote user switches the user role to broadcaster by calling {@link RtcEngine#setClientRole
   * setClientRole}. after joining the channel.
   * - A remote user or broadcaster rejoins the channel after a network interruption.
   *
   * @note
   * When a Web app joins the channel, this callback is triggered as long as the app publishes a
   * stream.
   *
   * @param uid ID of the remote user or broadcaster joining the channel.
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` or
   *     `setClientRole`
   * until this callback is triggered.
   */
  public void onUserJoined(int uid, int elapsed) {}

  /**
   * Occurs when a remote user or broadcaster goes offline.
   *
   * @param uid ID of the remote user or broadcaster who leaves the channel or drops offline.
   * @param reason The reason why the remote user goes offline:
   * - `USER_OFFLINE_QUIT`(0): When the user leaves the channel, the user sends a goodbye message.
   * When this message is received, the SDK determines that the user leaves the channel.
   * - `USER_OFFLINE_DROPPED`(1): When no data packet of the user is received for a certain period
   * of time, the SDK assumes that the user drops offline. A poor network connection may lead to
   * false detection, so we recommend using the RTM SDK for reliable offline detection.
   * - `USER_OFFLINE_BECOME_AUDIENCE`(2): The user switches the user role from a broadcaster to an
   * audience.
   */
  public void onUserOffline(int uid, int reason) {}

  /**
   * Occurs when the network connection state changes.
   * @since v2.3.2.
   *
   * The Agora SDK returns this callback to report on the current network connection state when it
   * changes, and the reason to such change.
   *
   * @param state The current network connection state:
   * <ul>
   *     <li>{@link Constants#CONNECTION_STATE_DISCONNECTED CONNECTION_STATE_DISCONNECTED(1)}: The
   * SDK is disconnected from Agora's edge server.
   *     <li>{@link Constants#CONNECTION_STATE_CONNECTING CONNECTION_STATE_CONNECTING(2)}: The SDK
   * is connecting to Agora's edge server. <li>{@link Constants#CONNECTION_STATE_CONNECTED
   * CONNECTION_STATE_CONNECTED(3)}: The SDK joined a channel and is connected to Agora's edge
   * server. You can now publish or subscribe to a media stream in the channel. <li>{@link
   * Constants#CONNECTION_STATE_RECONNECTING CONNECTION_STATE_RECONNECTING(4)}: The SDK keeps
   * rejoining the channel after being disconnected from a joined channel because of network issues.
   *     <li>{@link Constants#CONNECTION_STATE_FAILED CONNECTION_STATE_FAILED(5)}:  The SDK fails to
   * join the channel.
   * </ul>
   * @param reason The reason causing the change of the connection state:
   * <ul>
   *     <li>{@link Constants#CONNECTION_CHANGED_CONNECTING CONNECTION_CHANGED_CONNECTING(0)}:
   * Connecting. <li>{@link Constants#CONNECTION_CHANGED_JOIN_SUCCESS
   * CONNECTION_CHANGED_JOIN_SUCCESS(1)}: The SDK has joined the channel successfully. <li>{@link
   * Constants#CONNECTION_CHANGED_INTERRUPTED CONNECTION_CHANGED_INTERRUPTED(2)}: The connection is
   * interrupted. <li>{@link Constants#CONNECTION_CHANGED_BANNED_BY_SERVER
   * CONNECTION_CHANGED_BANNED_BY_SERVER(3)}: The connection is banned by Agora's edge server.
   *     <li>{@link Constants#CONNECTION_CHANGED_JOIN_FAILED CONNECTION_CHANGED_JOIN_FAILED(4)}: The
   * SDK fails to join the channel for more than 20 minutes and stops reconnecting to the channel.
   *     <li>{@link Constants#CONNECTION_CHANGED_LEAVE_CHANNEL CONNECTION_CHANGED_LEAVE_CHANNEL(5)}:
   * The SDK has left the channel.
   *     <li>{@link Constants#CONNECTION_CHANGED_INVALID_APP_ID
   * CONNECTION_CHANGED_INVALID_APP_ID(6)}: The specified App ID is invalid. Try to rejoin the
   * channel with a valid App ID.
   *     <li>{@link Constants#CONNECTION_CHANGED_INVALID_CHANNEL_NAME
   * CONNECTION_CHANGED_INVALID_CHANNEL_NAME(7)}: The specified channel name is invalid. Try to
   * rejoin the channel with a valid channel name.
   *     <li>{@link Constants#CONNECTION_CHANGED_INVALID_TOKEN CONNECTION_CHANGED_INVALID_TOKEN(8)}:
   * The generated token is invalid probably due to the following reasons: <ul> <li>The App
   * Certificate for the project is enabled in Console, but you do not use the token. <li>The uid
   * that you specify in the {@link RtcEngine#joinChannel joinChannel} method is different from the
   * uid that you pass for generating the token.
   *            </ul>
   *     <li>{@link Constants#CONNECTION_CHANGED_TOKEN_EXPIRED CONNECTION_CHANGED_TOKEN_EXPIRED(9)}:
   * The token has expired. Generate a new token from your server.
   *     <li>{@link Constants#CONNECTION_CHANGED_REJECTED_BY_SERVER
   * CONNECTION_CHANGED_REJECTED_BY_SERVER(10)}: The user is banned by the server. <li>{@link
   * Constants#CONNECTION_CHANGED_SETTING_PROXY_SERVER CONNECTION_CHANGED_SETTING_PROXY_SERVER(11)}:
   * The SDK tries to reconnect after setting a proxy server. <li>{@link
   * Constants#CONNECTION_CHANGED_RENEW_TOKEN CONNECTION_CHANGED_RENEW_TOKEN(12)}: The token renews.
   *     <li>{@link Constants#CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED
   * CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED(13)}: The client IP address has changed, probably
   * due to a change of the network type, IP address, or network port.
   *     <li>{@link Constants#CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT
   * CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT(14)}: Timeout for the keep-alive of the connection
   * between the SDK and Agora's edge server. The connection state changes to {@link
   * Constants#CONNECTION_STATE_RECONNECTING CONNECTION_STATE_RECONNECTING(4)}.
   * </ul>
   */
  public void onConnectionStateChanged(int state, int reason) {}

  /**
   * The SDK has lost connection to the server. This method is triggered upon connection is lost,
   * while the {@link onConnectionLost() onConnectionLost} method is triggered when the SDK attempts
   * to reconnect after losing connection. Once the connection is lost, and if the application does
   * not call {@link RtcEngine#leaveChannel() leaveChannel}, the SDK automatically tries to
   * reconnect repeatedly.
   *
   */
  public void onConnectionInterrupted() {}

  /**
   * Occurs when the SDK cannot reconnect to the server 10 seconds after its connection to the
   * server is interrupted.
   *
   * The SDK triggers this callback when it cannot connect to the server 10 seconds after calling
   * {@link RtcEngine#joinChannel joinChannel}, regardless of whether it is in the channel or not.
   */
  public void onConnectionLost() {}

  /**
   * <p>Your connection is banned by the Agora Server.
   *
   * <p>Note: The SDK does not try to reconnect. </p>
   *
   */
  public void onConnectionBanned() {}

  /**
   * Occurs when an API method is executed.
   *
   * @param error The error code that the SDK returns when the method call fails.
   * @param api The API method that the SDK executes.
   * @param result The result of the method call.
   */
  public void onApiCallExecuted(int error, String api, String result) {}

  /**
   * Occurs when the token will expire in 30 seconds.
   *
   * If the token you specified when calling {@link RtcEngine#joinChannel joinChannel} expires,
   * the user will drop offline. This callback is triggered 30 seconds before the token expires, to
   * remind you to renew the token.

   * Upon receiving this callback, generate a new token at your app server and call
   * {@link RtcEngine#renewToken renewToken} to pass the new Token to the SDK.
   *
   * @sa [How to generate a
  token](https://docs.agora.io/en/Interactive%20Broadcast/token_server_cpp?platform=CPP).
   *
   * @param token The token that will expire in 30 seconds.
   */
  public void onTokenPrivilegeWillExpire(String token) {}

  /**
   * Occurs when the token has expired.
   *
   * If a token is specified when calling the {@link RtcEngine#joinChannel joinChannel} method,
   * the token expires after a certain period of time and you need a new token to reconnect to the
   * server.
   *
   * Upon receiving this callback, generate a new token at your app server and call
   * {@link RtcEngine#renewToken renewToken} to pass the new token to the SDK.
   *
   * @sa [How to generate a
   * token](https://docs.agora.io/en/Interactive%20Broadcast/token_server_cpp?platform=CPP).
   */
  public void onRequestToken() {}

  /**
   * Reports which users are speaking and the speaker‘s volume.
   *
   * This callback reports the IDs and volumes of the loudest speakers (at most 3) at the moment in
   * the channel, and whether the local user is speaking. Once enabled, this callback is triggered
   * at the set interval, regardless of whether a user speaks or not.
   *
   * The SDK triggers two independent `onAudioVolumeIndication` callbacks at one time, which
   * separately report the volume information of the local user and all the remote speakers. For
   * more information, see the detailed parameter descriptions.
   *
   * Calling the {@link RtcEngine#muteLocalAudioStream muteLocalAudioStream} method affects
   * the SDK's behavior.
   * - If the local user calls the `muteLocalAudioStream` method, the SDK stops triggering the local
   * user's callback.
   * - 20 seconds after a remote speaker calls the `muteLocalAudioStream` method, the remote
   * speakers' callback does not include information of this remote user; 20 seconds after all
   * remote users call the `muteLocalAudioStream` method, the SDK stops triggering the remote
   * speakers' callback.
   *
   * @param speakers An array containing the user ID and volume information for each speaker:
   * {@link AudioVolumeInfo AudioVolumeInfo}.
   * - In the local user's callback, this array contains the following members:
   *   - `uid` = 0,
   *   - `volume` = `totalVolume`, which reports the sum of the voice volume and audio-mixing volume
   * of the local user.
   * - In the remote users' callback, this array contains the following members:
   *   - `uid` of each remote speaker.
   *   - `volume`, which reports the sum of the voice volume and audio-mixing volume of each remote
   * speaker.
   *
   *   An empty `speakers` array in the callback indicates that no remote user is speaking at the
   * moment.
   * @param totalVolume The total volume after audio mixing. The value ranges between 0 (the lowest
   *     volume)
   * and 255 (the highest volume).
   * - In the local user's callback, `totalVolume` is the sum of the voice volume and audio-mixing
   * volume of the local user.
   * - In the remote users' callback, `totalVolume` is the sum of the voice volume and audio-mixing
   * volume of all the remote speakers.
   */
  public void onAudioVolumeIndication(AudioVolumeInfo[] speakers, int totalVolume) {}

  /**
   * Occurs when an active speaker is detected.
   *
   * If you have called the {@link RtcEngine#enableAudioVolumeIndication
   * enableAudioVolumeIndication} method, this callback is triggered when the volume detecting unit
   * has detected an active speaker in the channel. This callback also returns the `uid` of the
   * active speaker.
   *
   * You can add relative functions on your app, for example, the active speaker, once detected,
   * will have the portrait zoomed in.
   *
   * @note
   * - You need to call `enableAudioVolumeIndication` to receive this callback.
   * - The active speaker means the user ID of the speaker who speaks at the highest volume during a
   * certain period of time.
   *
   * @param uid The ID of the active speaker. A `uid` of 0 means the local user.
   */
  public void onActiveSpeaker(int uid) {}

  /**
   * Occurs when the first audio frame is published.
   * @param elapsed The time elapsed (ms) from the local user calling joinChannel to the SDK
   * triggers this callback.
   */
  public void onFirstLocalAudioFramePublished(int elapsed) {}

  /**
   *Occurs when the first remote audio frame is received.
   *
   * @param uid ID of the remote user.
   * @param elapsed The time elapsed (ms) from the local user calling
   * {@link RtcEngine#joinChannel} until this callback is triggered.
   **/
  public void onFirstRemoteAudioFrame(int uid, int elapsed) {}

  /**
   * Occurs when the SDK decodes the first remote audio frame for playback.
   *
   * @param uid User ID of the remote user sending the audio stream.
   * @param elapsed The time elapsed (ms) from the loca user calling
   * \ref IRtcEngine::joinChannel "joinChannel()" until this callback is triggered.
   */
  public void onFirstRemoteAudioDecoded(int uid, int elapsed) {}

  /**
   * <p>The video has stopped playing.
   *
   * <p>The application can use this callback to change the configuration of the view (for example,
   * display other pictures in the view) after the video stops.
   */
  public void onVideoStopped() {}

  /**
   * The first local video frame is displayed on the screen.
   *
   * @param width Width (pixels) of the video stream.
   * @param height Height (pixels) of the video stream.
   * @param elapsed Time elapsed (ms) from calling {@link RtcEngine#joinChannel(java.lang.String
          token, java.lang.String channelName, java.lang.String optionalInfo, int optionalUid)
  joinChannel} until this callback is triggered.
   */
  public void onFirstLocalVideoFrame(int width, int height, int elapsed) {}

  /**
   * Occurs when the first video frame is published.
   * @param elapsed The time elapsed (ms) from the local user calling joinChannel to the SDK
   * triggers this callback.
   */
  public void onFirstLocalVideoFramePublished(int elapsed) {}

  /**
   * Occurs when the first remote video frame is received and decoded.
   *
   * @deprecated
   * This callback is deprecated. Use `REMOTE_VIDEO_STATE_STARTING(1)` or
   * `REMOTE_VIDEO_STATE_DECODING(2)` in the {@link onRemoteVideoStateChanged
   * onRemoteVideoStateChanged} callback instead.
   *
   * This callback is triggered in either of the following scenarios:
   * <ul>
   *     <li>The remote user joins the channel and sends the video stream.
   *     <li>The remote user stops sending the video stream and re-sends it after 15 seconds.
   * Possible reasons include: <ul> <li>The remote user leaves channel. <li>The remote user drops
   * offline. <li>The remote user calls the {@link RtcEngine#muteLocalVideoStream
   * muteLocalVideoStream} method. <li>The remote user calls the {@link RtcEngine#disableVideo
   * disableVideo} method.
   *         </ul>
   * </ul>
   *
   * @param uid User ID of the remote user sending the video streams.
   * @param width Width (pixels) of the video stream.
   * @param height Height (pixels) of the video stream.
   * @param elapsed Time elapsed (ms) from the local user calling the {@link RtcEngine#joinChannel
   * joinChannel} method until this callback is triggered.
   */
  public void onFirstRemoteVideoDecoded(int uid, int width, int height, int elapsed) {}

  /**
   * <p>The first frame of the remote video appears in the user’s video window.
   *
   * <p>The application can retrieve the data of time elapsed from user joining the channel until
   the first video frame is displayed.
   *
   * @param uid User ID of the user whose video streams are received.
   * @param width Width (pixels) of the video stream.
   * @param height Height (pixels) of the video stream.
   * @param elapsed Time elapsed (ms) from calling {@link RtcEngine#joinChannel(java.lang.String
          token, java.lang.String channelName, java.lang.String optionalInfo, int optionalUid)
  joinChannel} until this callback is triggered.
   */
  public void onFirstRemoteVideoFrame(int uid, int width, int height, int elapsed) {}

  /**
   * Occurs when a remote user stops/resumes sending the audio stream.
   *
   * The SDK triggers this callback when the remote user stops or resumes sending the audio stream
   * by calling the {@link RtcEngine#muteLocalAudioStream muteLocalAudioStream} method.
   *
   * @note This callback does not work properly when the number of users (in the `COMMUNICATION`
   * profile) or hosts (in the `LIVE_BROADCASTING` profile) in the channel exceeds 17.
   *
   * @param uid ID of the remote user.
   * @param muted Whether the remote user's audio stream playback pauses/resumes:
   * <ul>
   *      <li>True: User's audio is paused.
   *      <li>False: User's audio is resumed.
   * </ul>
   */
  public void onUserMuteAudio(int uid, boolean muted) {}
  /**
   * Occurs when a remote user stops/resumes sending the video stream.
   *
   * @deprecated
   * This callback is deprecated. Use the {@link onRemoteVideoStateChanged
   * onRemoteVideoStateChanged} callback with the following parameters for the same function:
   * - `REMOTE_VIDEO_STATE_STOPPED(0)` and `REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5)`.
   * - `REMOTE_VIDEO_STATE_DECODING(2)` and `REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6)`.
   *
   * The SDK triggers this callback when the remote user stops or resumes sending the video stream
   * by calling the {@link RtcEngine#muteLocalVideoStream muteLocalVideoStream} method.
   *
   * @note This callback does not work properly when the number of users (in the `COMMUNICATION`
   * profile) or hosts (in the `LIVE_BROADCASTING` profile) in the channel exceeds 17.
   *
   * @param uid ID of the remote user.
   * @param muted Whether the remote user's video stream playback pauses/resumes:
   * <ul>
   *      <li>True: User's video is paused.
   *      <li>False: User's video is resumed.
   * </ul>
   */
  @Deprecated
  public void onUserMuteVideo(int uid, boolean muted) {}

  /**
   * Occurs when a remote user enables/disables the video module.
   * @deprecated
   * This callback is deprecated and replaced by the {@link onRemoteVideoStateChanged
   * onRemoteVideoStateChanged} callback with the following parameters:
   * - `REMOTE_VIDEO_STATE_STOPPED(0)` and `REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5)`.
   * - `REMOTE_VIDEO_STATE_DECODING(2)` and `REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6)`.
   *
   * Once the video module is disabled, the remote user can only use a voice call. The remote user
   * cannot send or receive any video from other users.
   *
   * The SDK triggers this callback when the remote user enables or disables the video module by
   * calling the {@link RtcEngine#enableVideo enableVideo} or {@link RtcEngine#disableVideo
   * disableVideo} method.
   *
   * @note This callback is invalid when the number of users or hosts in the channel exceeds 20.
   * @param uid User ID of the remote user.
   * @param enabled Whether the specific remote user enables/disables the video module:
   * <ul>
   *     <li>true: Enabled. The remote user can enter a video session.
   *     <li>false: Disabled. The remote user can only enter a voice session, and cannot send or
   * receive any video stream.
   * </ul>
   *
   */
  @Deprecated
  public void onUserEnableVideo(int uid, boolean enabled) {}

  /**
   * Occurs when a remote user enables/disables the local video capture function.
   * @deprecated
   * This callback is deprecated and replaced by the {@link onRemoteVideoStateChanged
   * onRemoteVideoStateChanged} callback with the following parameters:
   * - `REMOTE_VIDEO_STATE_STOPPED(0)` and `REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5)`.
   * - `REMOTE_VIDEO_STATE_DECODING(2)` and `REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6)`.
   *
   * The SDK triggers this callback when the remote user resumes or stops capturing the video stream
   * by calling the {@link RtcEngine#enableLocalVideo enableLocalVideo} method.
   *
   * This callback is only applicable to the scenario when the remote user only wants to watch the
   * remote video without sending any video stream to the other user.
   *
   * @param uid User ID of the remote user.
   * @param enabled Whether the specific remote user enables/disables the local video capturing
   * function: <ul> <li>true: Enabled. Other users in the channel can see the video of this remote
   * user. <li>false: Disabled. Other users in the channel can no longer receive the video stream
   * from this remote user, while this remote user can still receive the video streams from other
   * users.
   * </ul>
   *
   */
  @Deprecated
  public void onUserEnableLocalVideo(int uid, boolean enabled) {}

  /**
   * The local or remote video size or rotation changed.
   *
   * @param uid User ID of the user whose video size or rotation has changed.
   * @param width Width (pixels) of the video stream.
   * @param height Height (pixels) of the video stream.
   * @param rotation Rotation [0 to 360).
   */
  public void onVideoSizeChanged(int uid, int width, int height, int rotation) {}

  /**
   * Occurs when the remote audio state changes.
   *
   * This callback indicates the state change of the remote audio stream.
   *
   * @param uid ID of the user whose audio state changes.
   * @param state The state of the remote audio:
   * - `REMOTE_AUDIO_STATE_STOPPED(0)`: The remote audio is in the default state, probably due to
   * `REMOTE_AUDIO_REASON_LOCAL_MUTED(3)`, `REMOTE_AUDIO_REASON_REMOTE_MUTED(5)`, or
   * `REMOTE_AUDIO_REASON_REMOTE_OFFLINE(7)`.
   * - `REMOTE_AUDIO_STATE_STARTING(1)`: The first remote audio packet is received.
   * - `REMOTE_AUDIO_STATE_DECODING(2)`: The remote audio stream is decoded and plays normally,
   * probably due to `REMOTE_AUDIO_REASON_NETWORK_RECOVERY(2)`,
   * `REMOTE_AUDIO_REASON_LOCAL_UNMUTED(4)` or `REMOTE_AUDIO_REASON_REMOTE_UNMUTED(6)`.
   * - `REMOTE_AUDIO_STATE_FROZEN(3)`: The remote audio is frozen, probably due to
   * `REMOTE_AUDIO_REASON_NETWORK_CONGESTION(1)`.
   * - `REMOTE_AUDIO_STATE_FAILED(4)`: The remote audio fails to start, probably due to
   * `REMOTE_AUDIO_REASON_INTERNAL(0)`.
   * @param reason The reason of the remote audio state change.
   * - `REMOTE_AUDIO_REASON_INTERNAL(0)`: Internal reasons.
   * - `REMOTE_AUDIO_REASON_NETWORK_CONGESTION(1)`: Network congestion.
   * - `REMOTE_AUDIO_REASON_NETWORK_RECOVERY(2)`: Network recovery.
   * - `REMOTE_AUDIO_REASON_LOCAL_MUTED(3)`: The local user stops receiving the remote audio stream
   * or disables the audio module.
   * - `REMOTE_AUDIO_REASON_LOCAL_UNMUTED(4)`: The local user resumes receiving the remote audio
   * stream or enables the audio module.
   * - `REMOTE_AUDIO_REASON_REMOTE_MUTED(5)`: The remote user stops sending the audio stream or
   * disables the audio module.
   * - `REMOTE_AUDIO_REASON_REMOTE_UNMUTED(6)`: The remote user resumes sending the audio stream or
   * enables the audio module.
   * - `REMOTE_AUDIO_REASON_REMOTE_OFFLINE(7)`: The remote user leaves the channel.
   * @param elapsed Time elapsed (ms) from the local user calling the {@link RtcEngine#joinChannel
   *     joinChannel} method until the SDK triggers this callback.
   */
  public void onRemoteAudioStateChanged(
      int uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed) {}

  /**
   * Occurs when the audio publish state changed.
   *
   * @param channel The channel name of user joined.
   * @param oldState The old state of the audio stream publish : #STREAM_PUBLISH_STATE.
   * @param newState The new state of the audio stream publish : #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onAudioPublishStateChanged(String channel, STREAM_PUBLISH_STATE oldState,
      STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {}

  /**
   * Occurs when the audio publish state changed.
   *
   * @param channel The channel name of user joined.
   * @param oldState The old state of the video stream subscribe state : #STREAM_PUBLISH_STATE.
   * @param newState The new state of the video stream subscribe state : #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onVideoPublishStateChanged(String channel, STREAM_PUBLISH_STATE oldState,
      STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {}

  /**
   * Occurs when the audio subscribe state changed.
   *
   * @param channel The channel name of user joined.
   * @param uid The remote user ID that is subscribed to.
   * @param oldState The old state of the audio stream subscribe : #STREAM_SUBSCRIBE_STATE.
   * @param newState The new state of the audio stream subscribe : #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onAudioSubscribeStateChanged(String channel, int uid, STREAM_SUBSCRIBE_STATE oldState,
      STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {}

  /**
   * Occurs when the video subscribe state changed.
   *
   * @param channel The channel name of user joined.
   * @param uid The remote user ID that is subscribed to.
   * @param oldState The old state of the video stream subscribe state : #STREAM_SUBSCRIBE_STATE.
   * @param newState The new state of the video stream subscribe state : #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the old state to the new state.
   */
  public void onVideoSubscribeStateChanged(String channel, int uid, STREAM_SUBSCRIBE_STATE oldState,
      STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {}

  /**
   * Occurs when the remote video state has changed.
   *
   * @note
   * This callback does not work properly when the number of users (in the `COMMUNICATION` profile)
   * or hosts (in the `LIVE_BROADCASTING` profile) in the channel exceeds 17.
   *
   *
   * @param uid ID of the user whose video state has changed.
   * @param state State of the remote video:
   * - {@link Constants#REMOTE_VIDEO_STATE_STOPPED REMOTE_VIDEO_STATE_STOPPED(0)}: The remote video
   * is in the default state, probably due to REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED(3),
   * REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5), or REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE(7).
   * - {@link Constants#REMOTE_VIDEO_STATE_STARTING REMOTE_VIDEO_STATE_STARTING(1)}: The first
   * remote video packet is received.
   * - {@link Constants#REMOTE_VIDEO_STATE_PLAYING REMOTE_VIDEO_STATE_PLAYING(2)}: The remote video
   * stream is decoded and plays normally, probably due to
   * REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY (2), REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED(4),
   * REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6), or
   * REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY(9).
   * - {@link Constants#REMOTE_VIDEO_STATE_FROZEN REMOTE_VIDEO_STATE_FROZEN(3)}: The remote video is
   * frozen, probably due to REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION(1) or
   * REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK(8).
   * - {@link Constants#REMOTE_VIDEO_STATE_FAILED REMOTE_VIDEO_STATE_FAILED(4)}: The remote video
   * fails to start, probably due to REMOTE_VIDEO_STATE_REASON_INTERNAL(0).
   * @param reason The reason of the remote video state change:
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_INTERNAL REMOTE_VIDEO_STATE_REASON_INTERNAL(0)}:
   * Internal reasons.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION
   * REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION(1)}: Network congestion.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY
   * REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY(2)}: Network recovery.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED
   * REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED(3)}: The local user stops receiving the remote video
   * stream or disables the video module.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED
   * REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED(4)}: The local user resumes receiving the remote video
   * stream or enables the video module.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED
   * REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5)}: The remote user stops sending the video stream or
   * disables the video module.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED
   * REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6)}: The remote user resumes sending the video stream
   * or enables the video module.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE
   * REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE(7)}: The remote user leaves the channel.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK
   * REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK(8)}: The remote media stream falls back to the
   * audio-only stream due to poor network conditions.
   * - {@link Constants#REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY
   * REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY(9)}: The remote media stream switches back to
   * the video stream after the network conditions improve.
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` until this
   * callback is triggered.
   */
  public void onRemoteVideoStateChanged(int uid, int state, int reason, int elapsed) {}
  /**
   * Occurs when the state of the media stream relay changes.
   *
   * The SDK reports the state of the current media relay and possible error messages in this
   * callback.
   *
   * @param state The state code:
   * - `RELAY_STATE_IDLE(0)`: The SDK is initializing.
   * - `RELAY_STATE_CONNECTING(1)`: The SDK tries to relay the media stream to the destination
   * channel.
   * - `RELAY_STATE_RUNNING(2)`: The SDK successfully relays the media stream to the destination
   * channel.
   * - `RELAY_STATE_FAILURE(3)`: A failure occurs. See the details in `code`.
   * @param code The error code:
   * - `RELAY_OK(0)`: The state is normal.
   * - `RELAY_ERROR_SERVER_ERROR_RESPONSE(1)`: An error occurs in the server response.
   * - `RELAY_ERROR_SERVER_NO_RESPONSE(2)`: No server response. You can call the leaveChannel method
   * to leave the channel.
   * - `RELAY_ERROR_NO_RESOURCE_AVAILABLE(3)`: The SDK fails to access the service, probably due to
   * limited resources of the server.
   * - `RELAY_ERROR_FAILED_JOIN_SRC(4)`: Fails to send the relay request.
   * - `RELAY_ERROR_FAILED_JOIN_DEST(5)`: Fails to accept the relay request.
   * - `RELAY_ERROR_FAILED_PACKET_RECEIVED_FROM_SRC(6)`: The server fails to receive the media
   * stream.
   * - `RELAY_ERROR_FAILED_PACKET_SENT_TO_DEST(7)`: The server fails to send the media stream.
   * - `RELAY_ERROR_SERVER_CONNECTION_LOST(8)`: The SDK disconnects from the server due to poor
   * network connections. You can call the leaveChannel method to leave the channel.
   * - `RELAY_ERROR_INTERNAL_ERROR(9)`: An internal error occurs in the server.
   * - `RELAY_ERROR_SRC_TOKEN_EXPIRED(10)`: The token of the source channel has expired.
   * - `RELAY_ERROR_DEST_TOKEN_EXPIRED(11)`: The token of the destination channel has expired.
   */
  public void onChannelMediaRelayStateChanged(int state, int code) {}
  /**
   * Reports events during the media stream relay.
   *
   * @param code The event code for media stream relay:
   * - `RELAY_EVENT_NETWORK_DISCONNECTED(0)`: The user disconnects from the server due to poor
   * network connections.
   * - `RELAY_EVENT_NETWORK_CONNECTED(1)`: The network reconnects.
   * - `RELAY_EVENT_PACKET_JOINED_SRC_CHANNEL(2)`: The user joins the source channel.
   * - `RELAY_EVENT_PACKET_JOINED_DEST_CHANNEL(3)`: The user joins the destination channel.
   * - `RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL(4)`: The SDK starts relaying the media stream to the
   * destination channel.
   * - `RELAY_EVENT_PACKET_RECEIVED_VIDEO_FROM_SRC(5)`: The server receives the video stream from
   * the source channel.
   * - `RELAY_EVENT_PACKET_RECEIVED_AUDIO_FROM_SRC(6)`: The server receives the audio stream from
   * the source channel.
   * - `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL(7)`: The destination channel is updated.
   * - `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED(8)`: The destination channel update fails due
   * to internal reasons.
   * - `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_NOT_CHANGE(9)`: The destination channel does not
   * change, which means that the destination channel fails to be updated.
   * - `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_IS_NULL(10)`: The destination channel name is NULL.
   * - `RELAY_EVENT_VIDEO_PROFILE_UPDATE(11)`: The video profile is sent to the server.
   */
  public void onChannelMediaRelayEvent(int code) {}

  public void onLocalPublishFallbackToAudioOnly(boolean isFallbackOrRecover) {}

  public void onRemoteSubscribeFallbackToAudioOnly(int uid, boolean isFallbackOrRecover) {}

  /**
   * Occurs when the local audio playback route changes.
   *
   * This callback returns that the audio route switched to an earpiece, speakerphone, headset, or
   * Bluetooth device.
   *
   * The definition of the routing is listed as follows:
   * - {@link Constants#AUDIO_ROUTE_DEFAULT AUDIO_ROUTE_DEFAULT(-1)}: The default audio route.
   * - {@link Constants#AUDIO_ROUTE_HEADSET AUDIO_ROUTE_HEADSET(0)}: Headset.
   * - {@link Constants#AUDIO_ROUTE_EARPIECE AUDIO_ROUTE_EARPIECE(1)}: Earpiece.
   * - {@link Constants#AUDIO_ROUTE_HEADSETNOMIC AUDIO_ROUTE_HEADSETNOMIC(2)}: Headset with no
   * microphone.
   * - {@link Constants#AUDIO_ROUTE_SPEAKERPHONE AUDIO_ROUTE_SPEAKERPHONE(3)}: Speakerphone.
   * - {@link Constants#AUDIO_ROUTE_LOUDSPEAKER AUDIO_ROUTE_LOUDSPEAKER(4)}: Loudspeaker.
   * - {@link Constants#AUDIO_ROUTE_HEADSETBLUETOOTH AUDIO_ROUTE_HEADSETBLUETOOTH(5)}: Bluetooth
   * headset.
   */
  public void onAudioRouteChanged(int routing) {}

  /**
   * <p>The camera is turned on and ready to capture video.
   *
   * <p>If the camera fails to turn on, an error is passed in the {@link onError(int err) onError}
   * method.
   */
  public void onCameraReady() {}

  /**
   * Occurs when the camera focus area has changed.
   *
   * @param rect Rectangular area in the camera zoom that specifies the focus area.
   */
  public void onCameraFocusAreaChanged(Rect rect) {}

  /**
   * Occurs when the camera exposure area has changed.
   *
   * @param rect Rectangular area in the camera zoom that specifies the focus area.
   */
  public void onCameraExposureAreaChanged(Rect rect) {}

  public void onContentInspectResult(int result) {}
  /**
   * Occurs when takeSnapshot API result is obtained
   *
   *
   * @brief snapshot taken callback
   *
   * @param channel channel name
   * @param uid user id
   * @param filePath image is saveed file path
   * @param width image width
   * @param height image height
   * @param errCode 0 is ok negative is error
   */
  public void onSnapshotTaken(
      String channel, int uid, String filePath, int width, int height, int errCode) {}
  /**
   * Occurs when the camera exposure area has changed.
   *
   * @param imageWidth width of output image.
   * @param imageHeight height of output image.
   * @param faceRectArr Rectangular area in the camera zoom that specifies the focus area.
   */
  public void onFacePositionChanged(
      int imageWidth, int imageHeight, AgoraFacePositionInfo[] faceRectArr) {}

  /**
   * <p>The audio quality of the specified user every two seconds.
   *
   * <p>By default, this callback is enabled.
   *
   * @param uid User ID of the speaker.
   * @param quality Rating of the audio quality:<ul><li>{@link Constants#QUALITY_UNKNOWN
   *     QUALITY_UNKNOWN(0)}<li>{@link Constants#QUALITY_EXCELLENT QUALITY_EXCELLENT(1)}<li>{@link
   *     Constants#QUALITY_GOOD QUALITY_GOOD(2)}<li>{@link Constants#QUALITY_POOR
   *     QUALITY_POOR(3)}<li>{@link Constants#QUALITY_BAD QUALITY_BAD(4)}<li>{@link
   *     Constants#QUALITY_VBAD QUALITY_VBAD(5)}</ul>
   * @param delay Time delay (ms).
   * @param lost Packet loss rate (%).
   */
  public void onAudioQuality(int uid, int quality, short delay, short lost) {}

  /**
   * Reports the statistics of the current call.
   *
   * This callback is triggered once every two seconds after the user joins the channel.
   *
   * @param stats The statistics on the current call: {@link RtcStats RtcStats}.
   */
  public void onRtcStats(RtcStats stats) {}

  /**
   * Reports the last-mile network quality of the local user.
   *
   * This callback is triggered once after `startLastmileProbeTest` is called.
   *
   * When the user is not in a channel and the last-mile network probe test is enabled
   * (by calling `startLastmileProbeTest`), this callback function is triggered
   * to update the app on the network connection quality of the local user.
   *
   * @param quality The network quality:
   * - `QUALITY_UNKNOWN(0)`: The quality is unknown.
   * - `QUALITY_EXCELLENT(1)`: The quality is excellent.
   * - `QUALITY_GOOD QUALITY_GOOD(2)`: The quality is quite good, but the bitrate may be slightly
   * lower than excellent.
   * - `QUALITY_POOR(3)`: Users can feel the communication slightly impaired.
   * - `QUALITY_BAD(4)`: Users can communicate not very smoothly.
   * - `QUALITY_VBAD(5)`: The quality is so bad that users can barely communicate.
   * - `QUALITY_DOWN(6)`: The network is disconnected and users cannot communicate at all.
   */
  public void onLastmileQuality(int quality) {}

  /**
   * Reports the last-mile network probe result.
   *
   * The SDK triggers this callback within 30 seconds after the app calls the {@link
   * RtcEngine#startLastmileProbeTest startLastmileProbeTest} method.
   * @param result The uplink and downlink lastmile network probe test result. For details, see
   * {@link LastmileProbeResult LastmileProbeResult}.
   */
  public void onLastmileProbeResult(LastmileProbeResult result) {}

  /**
   * Reports the network quality of each user.
   *
   * This callback is triggered once every two seconds after the user joins the channel.
   *
   * @param uid User ID. If `uid` is 0, the SDK reports the local network quality.
   * @param txQuality The transmission quality of the user:
   * - `QUALITY_UNKNOWN(0)`: The quality is unknown.
   * - `QUALITY_EXCELLENT(1)`: The quality is excellent.
   * - `QUALITY_GOOD QUALITY_GOOD(2)`: The quality is quite good, but the bitrate may be slightly
   * lower than excellent.
   * - `QUALITY_POOR(3)`: Users can feel the communication slightly impaired.
   * - `QUALITY_BAD(4)`: Users can communicate not very smoothly.
   * - `QUALITY_VBAD(5)`: The quality is so bad that users can barely communicate.
   * - `QUALITY_DOWN(6)`: The network is disconnected and users cannot communicate at all.
   * @param rxQuality The receiving quality of the user:
   * - `QUALITY_UNKNOWN(0)`: The quality is unknown.
   * - `QUALITY_EXCELLENT(1)`: The quality is excellent.
   * - `QUALITY_GOOD QUALITY_GOOD(2)`: The quality is quite good, but the bitrate may be slightly
   * lower than excellent.
   * - `QUALITY_POOR(3)`: Users can feel the communication slightly impaired.
   * - `QUALITY_BAD(4)`: Users can communicate not very smoothly.
   * - `QUALITY_VBAD(5)`: The quality is so bad that users can barely communicate.
   * - `QUALITY_DOWN(6)`: The network is disconnected and users cannot communicate at all.
   */
  public void onNetworkQuality(int uid, int txQuality, int rxQuality) {}

  /**
   * Reports the statistics of the local video streams.
   *
   * The SDK triggers this callback once every two seconds for each user/host.
   * If there are multiple users/hosts in the channel, the SDK triggers this callback as many times.
   *
   * @param stats The statistics of the local video stream. See {@link LocalVideoStats
   *     LocalVideoStats}.
   */
  public void onLocalVideoStats(LocalVideoStats stats) {}

  /**
   * Reports the statistics of the audio from each remote user or broadcaster.
   *
   * The SDK triggers this callback once every two seconds for each remote user or broadcaster. If a
   * channel has multiple remote users, the SDK triggers this callback as many times.
   * @param stats The statistics of the received audio: RemoteAudioStats.
   */
  public void onRemoteAudioStats(RemoteAudioStats stats) {}

  /**
   * Reports the statistics of the local audio stream.
   *
   * The SDK triggers this callback once every two seconds.
   *
   * @param stats The statistics of the local audio stream.
   * See LocalAudioStats.
   */
  public void onLocalAudioStats(LocalAudioStats stats) {}

  /**
   * Reports the statistics of the video stream from each remote user/host.
   *
   * The SDK triggers this callback once every two seconds for each remote user/host.
   * If a channel includes multiple remote users, the SDK triggers this callback as many times.
   *
   * @param stats The statistics of the remote video streams. See {@link RemoteVideoStats
   *     RemoteVideoStats}.
   */
  public void onRemoteVideoStats(RemoteVideoStats stats) {}

  /**
   * @deprecated
   * The statistics of the uploading local video streams once every two seconds.
   * @param sentBitrate Data sending bitrate (kbit/s) since last count.
   * @param sentFrameRate Data sending frame rate (fps) since last count.
   */
  public void onLocalVideoStat(int sentBitrate, int sentFrameRate) {}

  /**
   * @deprecated
   * The statistics of receiving remote video streams once every two seconds.
   *
   * @param uid User ID of the user whose video streams are received.
   * @param delay Time delay (ms).
   * @param receivedBitrate Data receiving bitrate (kbit/s).
   * @param receivedFrameRate Data receiving frame rate (fps).
   */
  public void onRemoteVideoStat(int uid, int delay, int receivedBitrate, int receivedFrameRate) {}

  public void onRemoteAudioTransportStats(int uid, int delay, int lost, int rxKBitRate) {}

  public void onRemoteVideoTransportStats(int uid, int delay, int lost, int rxKBitRate) {}

  /**
   * Occurs when the state of the local user's audio mixing file changes.
   *
   * When you call the {@link RtcEngine#startAudioMixing startAudioMixing} method and the state of
   * audio mixing file changes, the Agora SDK triggers this callback.
   * - When the audio mixing file plays, pauses playing, or stops playing, this callback returns
   * 710, 711, or 713 in state, and 0 in errorCode.
   * - When exceptions occur during playback, this callback returns 714 in state and an error in
   * errorCode.
   * - If the local audio mixing file does not exist, or if the SDK does not support the file format
   * or cannot access the music file URL, the SDK returns {@link
   * io.agora.rtc2.Constants#WARN_AUDIO_MIXING_OPEN_ERROR WARN_AUDIO_MIXING_OPEN_ERROR = 701}.
   *
   * @param state The state code:
   * - {@link Constants#AUDIO_MIXING_STATE_PLAYING AUDIO_MIXING_STATE_PLAYING(710)}: The audio
   * mixing file is playing.
   * - {@link Constants#AUDIO_MIXING_STATE_PAUSED AUDIO_MIXING_STATE_PAUSED(711)}: The audio mixing
   * file pauses playing.
   * - {@link Constants#AUDIO_MIXING_STATE_STOPPED AUDIO_MIXING_STATE_STOPPED(713)}: The audio
   * mixing file stops playing.
   * - {@link Constants#AUDIO_MIXING_STATE_FAILED AUDIO_MIXING_STATE_FAILED(714)}: An exception
   * occurs when playing the audio mixing file. See the errorCode for details.
   * @param errorCode The error code:
   * - {@link Constants#AUDIO_MIXING_ERROR_OK AUDIO_MIXING_ERROR_OK(701)}: No error.
   * - {@link Constants#AUDIO_MIXING_ERROR_CAN_NOT_OPEN AUDIO_MIXING_ERROR_CAN_NOT_OPEN(701)}: The
   * SDK cannot open the audio mixing file.
   * - {@link Constants#AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL
   * AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL(702)}: The SDK opens the audio mixing file too frequently.
   * - {@link Constants#AUDIO_MIXING_ERROR_INTERRUPTED_EOF AUDIO_MIXING_ERROR_INTERRUPTED_EOF(703)}:
   * The audio mixing file playback is interrupted.
   */
  public void onAudioMixingStateChanged(int state, int errorCode) {}

  /**
   * <p>The audio mixing file playback is finished after calling {@link
   * RtcEngine#startAudioMixing(String filePath, boolean loopback, boolean replace, int cycle)
   * startAudioMixing}.
   *
   * <p>If you failed to execute the {@link RtcEngine#startAudioMixing(String filePath, boolean
   * loopback, boolean replace, int cycle) startAudioMixing} method, it returns the error code in
   * the {@link onError(int err) onError} callback.
   */
  public void onAudioMixingFinished() {}

  /**
   * The local audio effect playback has finished.
   *
   * @param soundId ID of the audio effect. Each audio effect has a unique ID.
   */
  public void onAudioEffectFinished(int soundId) {}

  /**
   Occurs when the state of the local user's rhythm player changes.
   When you call the \ref IRtcEngine::startRhythmPlayer "startRhythmPlayer"
   method and the state of rhythm player changes, the SDK triggers this
   callback.

   @param state The state code. See #RHYTHM_PLAYER_STATE_TYPE.
   @param errorCode The error code. See #RHYTHM_PLAYER_ERROR_TYPE.
   */
  public void onRhythmPlayerStateChanged(
      RHYTHM_PLAYER_STATE_TYPE state, RHYTHM_PLAYER_ERROR_TYPE errorCode) {}

  /**
   * Occurs when the local audio stream state changes.
   *
   * This callback indicates the state change of the local audio stream, including
   * the state of the audio recording and encoding, and allows you to troubleshoot
   * issues when exceptions occur.
   *
   * @note
   * When the state is `LOCAL_AUDIO_STREAM_STATE_FAILED(3)`, see the `error` parameter for details.
   *
   * @param state State of the local audio:
   * - `LOCAL_AUDIO_STREAM_STATE_STOPPED(0)`: The local audio is in the initial state.
   * - `LOCAL_AUDIO_STREAM_STATE_RECORDING(1)`: The recording device starts successfully.
   * - `LOCAL_AUDIO_STREAM_STATE_ENCODING(2)`: The first audio frame encodes successfully.
   * - `LOCAL_AUDIO_STREAM_STATE_FAILED(3)`: The local audio fails to start.
   * @param error The error information of the local audio:
   * - `LOCAL_AUDIO_STREAM_ERROR_OK(0)`: The local audio is normal.
   * - `LOCAL_AUDIO_STREAM_ERROR_FAILURE(1)`: No specified reason for the local audio failure.
   * - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_NO_PERMISSION(2)`: No permission to use the local audio
   * device.
   * - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY(3)`: The microphone is in use.
   * - `LOCAL_AUDIO_STREAM_ERROR_CAPTURE_FAILURE(4)`: The local audio recording fails. Check whether
   * the recording device is working properly.
   * - `LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE(5)`: The local audio encoding fails.
   */
  public void onLocalAudioStateChanged(
      LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_ERROR error) {}

  /**
   * Occurs when the local video stream state changes.
   *
   * This callback indicates the state of the local video stream, including camera capturing and
   * video encoding, and allows you to troubleshoot issues when exceptions occur.
   *
   * @note
   * For some device models, the SDK will not trigger this callback when the state of the
   * local video changes while the local video capturing device is in use, so you have to make your
   * own timeout judgment.
   * @param state The local video state:
   * - {@link Constants#LOCAL_VIDEO_STREAM_STATE_STOPPED LOCAL_VIDEO_STREAM_STATE_STOPPED(0)}: The
   * local video is in the initial state.
   * - {@link Constants#LOCAL_VIDEO_STREAM_STATE_CAPTURING LOCAL_VIDEO_STREAM_STATE_CAPTURING(1)}:
   * The local video capturer starts successfully.
   * - {@link Constants#LOCAL_VIDEO_STREAM_STATE_ENCODING LOCAL_VIDEO_STREAM_STATE_ENCODING(2)}: The
   * first local video frame encodes successfully.
   * - {@link Constants#LOCAL_VIDEO_STREAM_STATE_FAILED LOCAL_VIDEO_STREAM_STATE_FAILED(3)}: The
   * local video fails to start.
   * @param error The detailed error information of the local video:
   * - {@link Constants#LOCAL_VIDEO_STREAM_ERROR_OK LOCAL_VIDEO_STREAM_ERROR_OK(0)}: The local video
   * is normal.
   * - {@link Constants#LOCAL_VIDEO_STREAM_ERROR_FAILURE LOCAL_VIDEO_STREAM_ERROR_FAILURE(1)}: No
   * specified reason for the local video failure.
   * - {@link Constants#LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION
   * LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION(2)}: No permission to use the local video device.
   * - {@link Constants#LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY
   * LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY(3)}: The local video capturer is in use.
   * - {@link Constants#LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE
   * LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE(4)}: The local video capture fails. Check whether the
   * capturer is working properly.
   *      - If your app runs in the background on a device running Android 9 or later, you cannot
   * access the camera.
   *      - If your app runs on a device running Android 6 or later, this error is reported if the
   * camera is occupied by a third-part app and not property released. Once the camera is released,
   *        the SDK triggers this callback again, reporting state `CAPTURING(1)`, and error
   * `ERROR_OK(0)`.
   * - {@link Constants#LOCAL_VIDEO_STREAM_ERROR_ENCODE_FAILURE
   * LOCAL_VIDEO_STREAM_ERROR_ENCODE_FAILURE(5)}: The local video encoding fails.
   *
   */
  public void onLocalVideoStateChanged(int state, int error) {}

  /**
   * Occurs when the state of the RTMP streaming changes.
   *
   * @param url The RTMP URL address.
   * @param state The RTMP streaming state. See {@link RTMP_STREAM_PUBLISH_STATE
   * RTMP_STREAM_PUBLISH_STATE}.
   * @param errCode The detailed error information for streaming. See {@link
   * RTMP_STREAM_PUBLISH_ERROR RTMP_STREAM_PUBLISH_ERROR}.
   */
  public void onRtmpStreamingStateChanged(
      String url, RTMP_STREAM_PUBLISH_STATE state, RTMP_STREAM_PUBLISH_ERROR errCode) {}

  /**
   * A stream was published.
   *
   * @param url URL address to which the publisher publishes the stream.
   * @param error {@link ErrorCode Error code}
   */
  public void onStreamPublished(String url, int error) {}

  /**
   * A stream was unpublished.
   *
   * @param url URL address to which the publisher unpublishes the stream.
   */
  public void onStreamUnpublished(String url) {}

  /**
   * Transcoding was successfully updated.
   */
  public void onTranscodingUpdated() {}

  /**
   * The status of the injected stream.
   *
   * @param url URL address added into the broadcast.
   * @param uid User ID.
   * @param status Status of the injected stream:<ul><li>{@link
   *     Constants#INJECT_STREAM_STATUS_START_SUCCESS
   *     INJECT_STREAM_STATUS_START_SUCCESS(0)}<li>{@link
   *     Constants#INJECT_STREAM_STATUS_START_ALREADY_EXISTS
   *     INJECT_STREAM_STATUS_START_ALREADY_EXIST(1)}<li>{@link
   *     Constants#INJECT_STREAM_STATUS_START_UNAUTHORIZED
   *     INJECT_STREAM_STATUS_START_UNAUTHORIZED(2)}<li>{@link
   *     Constants#INJECT_STREAM_STATUS_START_TIMEDOUT
   *     INJECT_STREAM_STATUS_START_TIMEDOUT(3)}<li>{@link
   *     Constants#INJECT_STREAM_STATUS_START_FAILED INJECT_STREAM_STATUS_START_FAILED(4)}<li>{@link
   *     Constants#INJECT_STREAM_STATUS_STOP_SUCCESS INJECT_STREAM_STATUS_STOP_SUCCESS(5)}<li>{@link
   *     Constants#INJECT_STREAM_STATUS_STOP_NOT_FOUND INJECT_STREAM_STATUS_STOP_NOT_FOUND =
   *     6}<li>{@link Constants#INJECT_STREAM_STATUS_STOP_UNAUTHORIZED
   *     INJECT_STREAM_STATUS_STOP_UNAUTHORIZED(7)}<li>{@link
   *     Constants#INJECT_STREAM_STATUS_STOP_TIMEDOUT
   *     INJECT_STREAM_STATUS_STOP_TIMEDOUT(8)}<li>{@link Constants#INJECT_STREAM_STATUS_STOP_FAILED
   *     INJECT_STREAM_STATUS_STOP_FAILED(9)}<li>{@link Constants#INJECT_STREAM_STATUS_BROKEN
   *     INJECT_STREAM_STATUS_BROKEN(10)}</ul>
   */
  public void onStreamInjectedStatus(String url, int uid, int status) {}

  /**
   * Receives the data stream.
   *onRtmpStreamingEvent
   * The SDK triggers this callback when the user receives the data stream that another user sends
   * by calling the {@link RtcEngine#sendStreamMessage() sendStreamMessage} method within 5 seconds.
   *
   * @param uid User ID.
   * @param streamId Stream ID.
   * @param data Data received by the recipients.
   */
  public void onStreamMessage(int uid, int streamId, byte[] data) {}

  /**
   * Fails to receive the data stream.
   *
   * The SDK triggers this callback when the user does not receive the data stream that another user
   * sends by calling the {@link RtcEngine#sendStreamMessage() sendStreamMessage} method within 5
   * seconds.
   *
   * @param uid ID of the user who sends the data stream.
   * @param streamId The ID of the stream data.
   * @param error The error code. See {@link ErrorCode Error code}.
   * @param missed The number of lost messages.
   * @param cached The number of incoming cached messages when the data stream is interrupted.
   */
  public void onStreamMessageError(int uid, int streamId, int error, int missed, int cached) {}

  /**
   * Occurs when the media engine is loaded.
   *
   */
  public void onMediaEngineLoadSuccess() {}

  /**
   * Occurs when the media engine starts.
   *
   */
  public void onMediaEngineStartCallSuccess() {}

  /**
   * Occurs when the network type is changed.
   *
   * @param type The network type.
   * <ul>
   *     <li>{@link Constants#NETWORK_TYPE_UNKNOWN NETWORK_TYPE_UNKNOWN(-1)}: unknown.
   *     <li>{@link Constants#NETWORK_TYPE_DISCONNECTED NETWORK_TYPE_DISCONNECTED(0)}: disconnected.
   *     <li>{@link Constants#NETWORK_TYPE_LAN NETWORK_TYPE_LAN(1)}: LAN.
   *     <li>{@link Constants#NETWORK_TYPE_WIFI NETWORK_TYPE_WIFI(2)}: WIFI.
   *     <li>{@link Constants#NETWORK_TYPE_MOBILE_2G NETWORK_TYPE_MOBILE_2G(3)}: 2G.
   *     <li>{@link Constants#NETWORK_TYPE_MOBILE_3G NETWORK_TYPE_MOBILE_3G(4)}: 3G.
   *     <li>{@link Constants#NETWORK_TYPE_MOBILE_4G NETWORK_TYPE_MOBILE_4G(5)}: 4G.
   * </ul>
   */
  public void onNetworkTypeChanged(int type) {}

  /**
   * Occurs when intra request from remote user is received.
   *
   * This callback is triggered once remote user needs one Key frame.
   *
   */
  public void onIntraRequestReceived() {}

  /**
   * Occurs when uplink network info is updated.
   *
   * This callback is used for notifying user to adjust the send pace based
   * on the target bitrate.
   *
   * @param info The uplink network info.
   */
  public void onUplinkNetworkInfoUpdated(UplinkNetworkInfo info) {}

  /**
   * Occurs when downlink network info is updated.
   *
   * This callback is used for notifying user to switch major/minor stream if needed.
   *
   * @param info The network info.
   */
  public void onDownlinkNetworkInfoUpdated(DownlinkNetworkInfo info) {}

  public void onRefreshRecordingServiceStatus(int status) {}

  /**
   * Reports the error type of encryption.
   *
   * @param type See #ENCRYPTION_ERROR_TYPE.
   */
  public void onEncryptionError(ENCRYPTION_ERROR_TYPE errorType) {}

  /**
   * Reports the permission error.
   * @param permission {@link PERMISSION}
   */
  public void onPermissionError(PERMISSION permission) {}

  /**
   * Reports the user log upload result
   * @param requestId RequestId of the upload
   * @param success Is upload success
   * @param reason Reason of the upload, 0: OK, 1 Network Error, 2 Server Error.
   */
  public void onUploadLogResult(String requestId, boolean success, int reason) {}
}
