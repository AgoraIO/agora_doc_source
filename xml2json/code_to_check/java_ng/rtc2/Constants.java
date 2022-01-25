package io.agora.rtc2;

/**
 * Rating of the media or network quality.
 */
public class Constants {
  /**
   * 1: The last-mile probe result is complete.
   */
  public final static int LASTMILE_PROBE_RESULT_COMPLETE = 1;
  /**
   * 2: The last-mile network probe test is incomplete and the bandwidth estimation is not
   * available, probably due to limited test resources.
   */
  public final static int LASTMILE_PROBE_RESULT_INCOMPLETE_NO_BWE = 2;
  /**
   * 3: The last-mile network probe test is not carried out, probably due to poor network
   * conditions.
   */
  public final static int LASTMILE_PROBE_RESULT_UNAVAILABLE = 3;
  /**
   * The quality is unknown.
   */
  public final static int QUALITY_UNKNOWN = 0;
  /**
   * The quality is excellent.
   */
  public final static int QUALITY_EXCELLENT = 1;
  /**
   *  The quality is quite good, but the bitrate may be slightly lower than excellent.
   */
  public final static int QUALITY_GOOD = 2;
  /**
   * Users can feel the communication slightly impaired.
   */
  public final static int QUALITY_POOR = 3;
  /**
   * Users can communicate not very smoothly.
   */
  public final static int QUALITY_BAD = 4;
  /**
   * The quality is so bad that users can barely communicate.
   */
  public final static int QUALITY_VBAD = 5;
  /**
   * Users cannot communicate at all.
   */
  public final static int QUALITY_DOWN = 6;

  /**
   * The specified view is invalid. It is required to specify a view when using the video call
   * function.
   */
  public final static int WARN_INVALID_VIEW = 8;
  /**
   * Failed to initialize the video function.
   */
  public final static int WARN_INIT_VIDEO = 16;
  /**
   * The request is pending, usually due to some module not being ready, and the SDK postponed
   * processing the request.
   */
  public final static int WARN_PENDING = 20;
  /**
   * No channel resources are available. Maybe because the server cannot allocate any channel
   * resource.
   */
  public final static int WARN_NO_AVAILABLE_CHANNEL = 103;
  /**
   * A timeout when looking up the channel. When joining a channel, the SDK looks up the specified
   * channel. The warning usually occurs when the network condition is too poor to connect to the
   * server.
   */
  public final static int WARN_LOOKUP_CHANNEL_TIMEOUT = 104;
  /**
   * The server rejected the request to look up the channel. The server cannot process this request
   * or the request is illegal.
   */
  public final static int WARN_LOOKUP_CHANNEL_REJECTED = 105;
  /**
   * A timeout when opening the channel. Once the specific channel is found, the SDK opens the
   * channel. The warning usually occurs when the network condition is too poor to connect to the
   * server.
   */
  public final static int WARN_OPEN_CHANNEL_TIMEOUT = 106;
  /**
   * The server rejected the request to open the channel. The server cannot process this request or
   * the request is illegal.
   */
  public final static int WARN_OPEN_CHANNEL_REJECTED = 107;
  /**
   * A timeout when switching the live video.
   */
  public final static int WARN_SWITCH_LIVE_VIDEO_TIMEOUT = 111;
  /**
   * A timeout when setting the client role in the broadcast mode.
   */
  public final static int WARN_SET_CLIENT_ROLE_TIMEOUT = 118;
  /**
   * The client role is not authorized.
   */
  public final static int WARN_SET_CLIENT_ROLE_NOT_AUTHORIZED = 119;
  /**
   * The ticket to open the channel is invalid.
   */
  public final static int WARN_OPEN_CHANNEL_INVALID_TICKET = 121;
  /**
   * Try connecting to another server.
   */
  public final static int WARN_OPEN_CHANNEL_TRY_NEXT_VOS = 122;
  /**
   * Error in opening the audio mixing.
   */
  public final static int WARN_AUDIO_MIXING_OPEN_ERROR = 701;
  /**
   * Audio Device Module: A warning in the runtime playback device.
   */
  public final static int WARN_ADM_RUNTIME_PLAYOUT_WARNING = 1014;
  /**
   * Audio Device Module: A warning in the runtime recording device.
   */
  public final static int WARN_ADM_RUNTIME_RECORDING_WARNING = 1016;
  /**
   * Audio Device Module: No valid audio data is collected.
   */
  public final static int WARN_ADM_RECORD_AUDIO_SILENCE = 1019;
  /**
   * Audio Device Module: The recorded audio volume is too low.
   */
  public final static int WARN_ADM_RECORD_AUDIO_LOWLEVEL = 1031;
  /**
   * Audio Device Module: The playback audio volume is too low.
   */
  public final static int WARN_ADM_PLAYOUT_AUDIO_LOWLEVEL = 1032;
  /**
   * Audio Device Module: The recording device is occupied.
   */
  public final static int WARN_ADM_RECORD_IS_OCCUPIED = 1033;
  /**
   * Audio Device Module: Howling is detected.
   */
  public final static int WARN_APM_HOWLING = 1051;
  /**
   * Audio Device Module: The device is in the glitch state.
   */
  public final static int WARN_ADM_GLITCH_STATE = 1052;
  /**
   * Audio Device Module: The settings are improper.
   */
  public final static int WARN_ADM_IMPROPER_SETTINGS = 1053;

  /**
   * No error occurs.
   */
  public final static int ERR_OK = 0;
  /**
   * A general error occurs (no specified reason).
   */
  public final static int ERR_FAILED = 1;
  /**
   * An invalid parameter is used. For example, the specific channel name includes illegal
   * characters.
   */
  public final static int ERR_INVALID_ARGUMENT = 2;
  /**
   * The SDK module is not ready. We recommend the following methods to solve this error:
   * - Check the audio device.
   * - Check the completeness of the app.
   * - Re-initialize the SDK.
   */
  public final static int ERR_NOT_READY = 3;
  /**
   * The SDK does not support this function.
   */
  public final static int ERR_NOT_SUPPORTED = 4;
  /**
   * The request is rejected. This is for internal SDK internal use only, and it will not return to
   * the application through any API or callback event.
   */
  public final static int ERR_REFUSED = 5;
  /**
   * The buffer size is not big enough to store the returned data.
   */
  public final static int ERR_BUFFER_TOO_SMALL = 6;
  /**
   * The SDK is not initialized before calling this API.
   */
  public final static int ERR_NOT_INITIALIZED = 7;
  /**
   * The state is invalid.
   */
  public static final int ERR_INVALID_STATE = 8;
  /**
   * No permission. Check if the user has granted access to the audio or video device.
   */
  public final static int ERR_NO_PERMISSION = 9;
  /**
   * An API timeout. Some APIs require the SDK to return the execution result, and this error occurs
   * if the request takes too long for the SDK to process.
   */
  public final static int ERR_TIMEDOUT = 10;
  /**
   * The request is cancelled. This is for internal SDK internal use only, and it will not return to
   * the application through any API or callback event.
   */
  public final static int ERR_CANCELED = 11;
  /**
   * The call frequency is too high. This is for internal SDK internal use only, and it will not
   * return to the application through any API or callback event.
   */
  public final static int ERR_TOO_OFTEN = 12;
  /**
   * The SDK fails to bind to the network socket. This is for internal SDK internal use only, and
   * is not returned to the app through any method or callback.
   */
  public final static int ERR_BIND_SOCKET = 13;
  /**
   * The network is unavailable. This is for internal SDK internal use only, and it will not return
   * to the application through any API or callback event.
   */
  public final static int ERR_NET_DOWN = 14;
  /**
   * No network buffers available. This is for internal SDK internal use only, and it will not
   * return to the application through any API or callback event.
   */
  public final static int ERR_NET_NOBUFS = 15;
  /**
   * The request to join the channel is rejected. This error usually occurs when the user is already
   * in the channel, and still calls the API to join the channel, for example, {@link
   * joinChannel()}.
   */
  public final static int ERR_JOIN_CHANNEL_REJECTED = 17;
  /**
   * The request to leave the channel is rejected. This error usually occurs when the user has
   * already left the channel, and still calls the API to leave the channel, for example, {@link
   * leaveChannel()}.
   */
  public final static int ERR_LEAVE_CHANNEL_REJECTED = 18;
  /**
   * Resources are occupied, and cannot be reused.
   */
  public final static int ERR_ALREADY_IN_USE = 19;
  /**
   * The specified App ID is invalid.
   */
  public final static int ERR_INVALID_APP_ID = 101;
  /**
   * The specified channel name is invalid.
   */
  public final static int ERR_INVALID_CHANNEL_NAME = 102;
  /**
   * Fails to get server resources in the specified region.
   */
  public final static int ERR_NO_SERVER_RESOURCES = 103;
  /**
   * <p>The Token expired due to one of the following reasons:
   <ol>
   <li>Authorized Timestamp expired: The timestamp is represented by the number of seconds
   elapsed since 1/1/1970. The user can use the Token to access the Agora service within five
   minutes after the Token is generated. If the user does not access the Agora service after
   five minutes, this Token will no longer be valid.</li> <li>Call Expiration Timestamp expired:
   The timestamp indicates the exact time when a user can no longer use the Agora service (for
   example, when a user is forced to leave an ongoing call). When the value is set for the Call
   Expiration Timestamp, it does not mean that the Dynamic Key will be expired, but that the
   user will be kicked out of the channel.</il></ol>
   */
  public final static int ERR_TOKEN_EXPIRED = 109;
  /**
   * The Token is invalid due to one of the following reasons: The App Certificate for the project
   * is enabled on the Dashboard, but the user is still using the App ID. Once the App Certificate
   * is enabled, the user must use a Token. The uid field is mandatory, and users must set the same
   * uid when setting the uid parameter when calling joinChannel.
   */
  public final static int ERR_INVALID_TOKEN = 110;
  /**
   * The CONNECTION_INTERRUPTED callback. This applies to the Agora Web SDK only.
   */
  public final static int ERR_CONNECTION_INTERRUPTED = 111;
  /**
   * The CONNECTION_LOST callback. This applies to the Agora Web SDK only.
   */
  public final static int ERR_CONNECTION_LOST = 112;
  /**
   * The user is not in the channel.
   */
  public final static int ERR_NOT_IN_CHANNEL = 113;
  /**
   * The data size is too big.
   */
  public final static int ERR_SIZE_TOO_LARGE = 114;
  /**
   * The bitrate is limited.
   */
  public final static int ERR_BITRATE_LIMIT = 115;
  /**
   * Too many data streams.
   */
  public final static int ERR_TOO_MANY_DATA_STREAMS = 116;
  /**
   * Failed to decrypt.
   */
  public final static int ERR_DECRYPTION_FAILED = 120;
  /**
   * The client is banned by the server.
   */
  public final static int ERR_CLIENT_IS_BANNED_BY_SERVER = 123;
  public final static int ERR_INVALID_UID_NAME = 124;
  /**
   * Incorrect watermark file parameter.
   */
  public final static int ERR_WATERMARK_PARAM = 124;
  /**
   * Incorrect watermark file path.
   */
  public final static int ERR_WATERMARK_PATH = 125;
  /**
   * Incorrect watermark file format.
   */
  public final static int ERR_WATERMARK_PNG = 126;
  /**
   * Incorrect watermark file information.
   */
  public final static int ERR_WATERMARKR_INFO = 127;
  /**
   * Incorrect watermark file data format.
   */
  public final static int ERR_WATERMARK_ARGB = 128;
  /**
   * An error occurs in reading the watermark file.
   */
  public final static int ERR_WATERMARK_READ = 129;
  /**
   * Encryption is enabled when the user calls the {@link
   * io.agora.rtc2.RtcEngine#addPublishStreamUrl(String, boolean) addPublishStreamUrl} method (CDN
   * live streaming does not support encrypted streams).
   */
  public final static int ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISHED = 130;

  // 1001~2000
  /**
   * Failed to load the media engine.
   */
  public final static int ERR_LOAD_MEDIA_ENGINE = 1001;
  /**
   * Failed to start the call after enabling the media engine.
   */
  public final static int ERR_START_CALL = 1002;
  /**
   * Failed to start the camera.
   */
  public final static int ERR_START_CAMERA = 1003;
  /**
   * Failed to start the video rendering module.
   */
  public final static int ERR_START_VIDEO_RENDER = 1004;
  /**
   * General error on the Audio Device Module (no classified reason).
   */
  public final static int ERR_ADM_GENERAL_ERROR = 1005;
  /**
   * Audio Device Module: Error in using the Java resources.
   */
  public final static int ERR_ADM_JAVA_RESOURCE = 1006;
  /**
   * Audio Device Module: Error in setting the sampling frequency.
   */
  public final static int ERR_ADM_SAMPLE_RATE = 1007;
  /**
   * Audio Device Module: Error in initializing the playback device.
   */
  public final static int ERR_ADM_INIT_PLAYOUT = 1008;
  /**
   * Audio Device Module: Error in starting the playback device.
   */
  public final static int ERR_ADM_START_PLAYOUT = 1009;
  /**
   * Audio Device Module: Error in stopping the playback device.
   */
  public final static int ERR_ADM_STOP_PLAYOUT = 1010;
  /**
   * Audio Device Module: Error in initializing the recording device.
   */
  public final static int ERR_ADM_INIT_RECORDING = 1011;
  /**
   * Audio Device Module: Error in starting the recording device.
   */
  public final static int ERR_ADM_START_RECORDING = 1012;
  /**
   * Audio Device Module: Error in stopping the recording device.
   */
  public final static int ERR_ADM_STOP_RECORDING = 1013;
  /**
   * Audio Device Module: Runtime playback error.
   */
  public final static int ERR_ADM_RUNTIME_PLAYOUT_ERROR = 1015;
  /**
   * Audio Device Module: Runtime recording error.
   */
  public final static int ERR_ADM_RUNTIME_RECORDING_ERROR = 1017;
  /**
   * Audio Device Module: Failed to record.
   */
  public final static int ERR_ADM_RECORD_AUDIO_FAILED = 1018;
  /**
   * Audio Device Module: Error in initializing the loopback device.
   */
  public final static int ERR_ADM_INIT_LOOPBACK = 1022;
  /**
   * Audio Device Module: Error in starting the loopback device.
   */
  public final static int ERR_ADM_START_LOOPBACK = 1023;
  /**
   * Audio Device Module: No recording permission. Please check if the
   * recording permission is granted.
   */
  public final static int ERR_ADM_NO_PERMISSION = 1027;

  public final static int ERR_AUDIO_BT_SCO_FAILED = 1030;
  /**
   * Audio Device Module: No recording device.
   */
  public final static int ERR_ADM_NO_RECORDING_DEVICE = 1359;
  /**
   * Audio Device Module: No playback device.
   */
  public final static int ERR_ADM_NO_PLAYOUT_DEVICE = 1360;
  /**
   * Video Device Module: The camera is not authorized.
   */
  public final static int ERR_VDM_CAMERA_NOT_AUTHORIZED = 1501;
  /**
   * Video Device Module: Unknown error.
   */
  public final static int ERR_VCM_UNKNOWN_ERROR = 1600;
  /**
   * Video Device Module: Error in initializing the video encoder.
   */
  public final static int ERR_VCM_ENCODER_INIT_ERROR = 1601;
  /**
   * Video Device Module: Error in encoding.
   */
  public final static int ERR_VCM_ENCODER_ENCODE_ERROR = 1602;
  /**
   * Video Device Module: Error in setting the video encoder.
   */
  public final static int ERR_VCM_ENCODER_SET_ERROR = 1603;

  /**
   *  0, 160 x 120  @ 15 fps, 65 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_120P = 0;
  /**
   * 120 x 120  @ 15 fps, 50 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_120P_3 = 2;
  /**
   * 320 x 180  @ 15 fps, 140 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_180P = 10;
  /**
   * 180 x 180  @ 15 fps, 100 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_180P_3 = 12;
  /**
   * 240 x 180  @ 15 fps, 120 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_180P_4 = 13;
  /**
   * 320 x 240  @ 15 fps, 200 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_240P = 20;
  /**
   * 240 x 240  @ 15 fps, 140 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_240P_3 = 22;
  /**
   * 424 x 240  @ 15 fps, 220 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_240P_4 = 23;
  /**
   * 640 x 360  @ 15 fps, 400 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P = 30;
  /**
   * 360 x 360  @ 15 fps, 260 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_3 = 32;
  /**
   * 640 x 360  @ 30 fps, 600 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_4 = 33;
  /**
   * 360 x 360  @ 30 fps, 400 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_6 = 35;
  /**
   * 480 x 360  @ 15 fps, 320 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_7 = 36;
  /**
   * 480 x 360  @ 30 fps, 490 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_8 = 37;
  /**
   * 640 x 360  @ 15 fps, 600 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_9 = 38;
  /**
   * 640 x 360  @ 24 fps, 800 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_10 = 39;
  /**
   * 640 x 360  @ 24 fps, 1000 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_360P_11 = 100;
  /**
   * 640 x 480  @ 15 fps, 500 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_480P = 40;
  /**
   * 480 x 480  @ 15 fps, 400 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_480P_3 = 42;
  /**
   * 640 x 480  @ 30 fps, 750 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_480P_4 = 43;
  /**
   * 480 x 480  @ 30 fps, 600 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_480P_6 = 45;
  /**
   * 848 x 480  @ 15 fps, 610 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_480P_8 = 47;
  /**
   * 848 x 480  @ 30 fps, 930 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_480P_9 = 48;
  /**
   * 640 x 480  @ 10 fps, 400 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_480P_10 = 49;
  /**
   * 1280 x 720  @ 15 fps, 1130 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_720P = 50;
  /**
   * 1280 x 720  @ 30 fps, 1710 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_720P_3 = 52;
  /**
   * 960 x 720  @ 15 fps, 910 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_720P_5 = 54;
  /**
   * 960 x 720  @ 30 fps, 1380 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_720P_6 = 55;
  /**
   * 1920 x 1080  @ 15 fps, 2080 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_1080P = 60;
  /**
   * 1920 x 1080  @ 30 fps, 3150 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_1080P_3 = 62;
  /**
   * 1920 x 1080  @ 60 fps, 4780 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_1080P_5 = 64;
  /**
   * 2560 x 1440  @ 30 fps, 4850 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_1440P = 66;
  /**
   * 2560 x 1440  @ 60 fps, 7350 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_1440P_2 = 67;
  /**
   * 3840 x 2160  @ 30 fps, 8910 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_4K = 70;
  /**
   * <p>3840 x 2160  @ 60 fps, 13500 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_4K_3 = 72;
  /**
   * <p>Default video profile: 640 x 360  @ 15 fps, 400 kbit/s
   */
  @Deprecated public final static int VIDEO_PROFILE_DEFAULT = VIDEO_PROFILE_360P;

  /**
   * 0: The default audio profile.
   * - In the Communication profile, the default value is the same with
   * `AUDIO_PROFILE_SPEECH_STANDARD`(1).
   * - In the Live-broadcast profile, it represents a sample rate of 48 kHz, music encoding, mono,
   * and a bitrate of up to 64 Kbps.
   */
  public final static int AUDIO_PROFILE_DEFAULT = 0;
  /**
   * 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate up to 18 Kbps.
   */
  public final static int AUDIO_PROFILE_SPEECH_STANDARD = 1;
  /**
   * 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
   */
  public final static int AUDIO_PROFILE_MUSIC_STANDARD = 2;
  /**
   * 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80
   * Kbps.
   */
  public final static int AUDIO_PROFILE_MUSIC_STANDARD_STEREO = 3;
  /**
   * 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
   */
  public final static int AUDIO_PROFILE_MUSIC_HIGH_QUALITY = 4;
  /**
   * 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
   */
  public final static int AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO = 5;

  /**
   * 0: (Recommended) The default audio scenario.
   */
  public final static int AUDIO_SCENARIO_DEFAULT = 0;
  /**
   * 3: (Recommended) The live gaming scenario, which needs to enable the gaming audio effects in
   * the speaker mode in a live broadcast scenario. Choose this scenario to
   * achieve high-fidelity music playback.
   */
  public final static int AUDIO_SCENARIO_GAME_STREAMING = 3;
  /**
   * 5: The chatroom scenario, which needs to keep recording when setClientRole to audience.
   * Normally, app developer can also use mute api to achieve the same result,
   * and we implement this 'non-orthogonal' behavior only to make API backward compatible.
   */
  public final static int AUDIO_SCENARIO_CHATROOM = 5;
  /**
   * 6: (Recommended) The scenario requiring high-quality audio.
   */
  public final static int AUDIO_SCENARIO_HIGH_DEFINITION = 6;

  /**
   * 7: The chorus scenario.
   */
  public final static int AUDIO_SCENARIO_CHORUS = 7;

  /**
   * Turn off the local voice changer, that is, to use the original voice.
   */
  public final static int VOICE_CHANGER_OFF = 0x00000000;
  /**
   * The voice of an old man.
   */
  public final static int VOICE_CHANGER_OLDMAN = 0x02020200;
  /**
   * The voice of a little boy.
   */
  public final static int VOICE_CHANGER_BABYBOY = 0x02020300;
  /**
   * The voice of a little girl.
   */
  public final static int VOICE_CHANGER_BABYGIRL = 0x02020500;
  /**
   * The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a
   * growling bear.
   */
  public final static int VOICE_CHANGER_ZHUBAJIE = 0x02020600;
  /**
   * The ethereal voice.
   */
  public final static int VOICE_CHANGER_ETHEREAL = 0x02010700;
  /**
   * The voice of Hulk.
   */
  public final static int VOICE_CHANGER_HULK = 0x02020700;
  /**
   * A more vigorous voice.
   */
  public final static int VOICE_BEAUTY_VIGOROUS = 0x01030100;
  /**
   * A deeper voice.
   */
  public final static int VOICE_BEAUTY_DEEP = 0x01030200;
  /**
   * A mellower voice.
   */
  public final static int VOICE_BEAUTY_MELLOW = 0x01030300;
  /**
   * Falsetto.
   */
  public final static int VOICE_BEAUTY_FALSETTO = 0x01030400;
  /**
   * A fuller voice.
   */
  public final static int VOICE_BEAUTY_FULL = 0x01030500;
  /**
   * A clearer voice.
   */
  public final static int VOICE_BEAUTY_CLEAR = 0x01030600;
  /**
   * A more resounding voice.
   */
  public final static int VOICE_BEAUTY_RESOUNDING = 0x01030700;
  /**
   * A more ringing voice.
   */
  public final static int VOICE_BEAUTY_RINGING = 0x01030800;
  /**
   * A more spatially resonant voice.
   */
  public final static int VOICE_BEAUTY_SPACIAL = 0x02010600;
  /**
   * (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise,
   * voice distortion occurs.
   */
  public final static int GENERAL_BEAUTY_VOICE_MALE_MAGNETIC = 0x01010100;
  /**
   * (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice
   * distortion occurs.
   */
  public final static int GENERAL_BEAUTY_VOICE_FEMALE_FRESH = 0x01010200;
  /**
   * (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise,
   * voice distortion occurs.
   */
  public final static int GENERAL_BEAUTY_VOICE_FEMALE_VITALITY = 0x01010300;

  /**
   * Turn off local voice reverberation, that is, to use the original voice.
   */
  public final static int AUDIO_REVERB_OFF = 0x00000000;
  /**
   * The reverberation style typical of a KTV venue (enhanced).
   */
  public final static int AUDIO_REVERB_FX_KTV = 0x02010100;
  /**
   * The reverberation style typical of a concert hall (enhanced).
   */
  public final static int AUDIO_REVERB_FX_VOCAL_CONCERT = 0x02010200;
  /**
   * The reverberation style typical of an uncle's voice.
   */
  public final static int AUDIO_REVERB_FX_UNCLE = 0x02020100;
  /**
   * The reverberation style typical of a little sister's voice.
   */
  public final static int AUDIO_REVERB_FX_SISTER = 0x02020400;
  /**
   * The reverberation style typical of a recording studio (enhanced).
   */
  public final static int AUDIO_REVERB_FX_STUDIO = 0x02010300;
  /**
   * The reverberation style typical of popular music (enhanced).
   */
  public final static int AUDIO_REVERB_FX_POPULAR = 0x02030200;
  /**
   * The reverberation style typical of R&B music (enhanced).
   */
  public final static int AUDIO_REVERB_FX_RNB = 0x02030100;
  /**
   * The reverberation style typical of the vintage phonograph.
   */
  public final static int AUDIO_REVERB_FX_PHONOGRAPH = 0x02010400;
  /**
   * Turn off voice beautifier effects and use the original voice.
   */
  public final static int VOICE_BEAUTIFIER_OFF = 0x00000000;
  /**
   * Turn off audio effects and use the original voice.
   */
  public final static int AUDIO_EFFECT_OFF = 0x00000000;
  /**
   * A more magnetic voice.
   *
   * @note
   * Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * experience vocal distortion.
   */
  public final static int CHAT_BEAUTIFIER_MAGNETIC = 0x01010100;
  /**
   * A fresher voice.
   *
   * @note
   * Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * experience vocal distortion.
   */
  public final static int CHAT_BEAUTIFIER_FRESH = 0x01010200;
  /**
   * A more vital voice.
   *
   * @note
   * Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * experience vocal distortion.
   */
  public final static int CHAT_BEAUTIFIER_VITALITY = 0x01010300;
  /**
   * Singing beautifier effect.
   *
   * - If you call {@link RtcEngine#setVoiceBeautifierPreset
   * setVoiceBeautifierPreset(SINGING_BEAUTIFIER)}, you can beautify a male-sounding voice and add a
   * reverberation effect that sounds like singing in a small room. Agora recommends not using
   * `setVoiceBeautifierPreset(SINGING_BEAUTIFIER)` to process a female-sounding voice; otherwise,
   * you may experience vocal distortion.
   * - If you call {@link RtcEngine#setVoiceBeautifierParameters
   * setVoiceBeautifierParameters(SINGING_BEAUTIFIER, param1, param2)}, you can beautify a male- or
   * female-sounding voice and add a reverberation effect.
   *
   * @since v3.3.0
   */
  public final static int SINGING_BEAUTIFIER = 0x01020100;
  /**
   * A more vigorous voice.
   */
  public final static int TIMBRE_TRANSFORMATION_VIGOROUS = 0x01030100;
  /**
   * A deeper voice.
   */
  public final static int TIMBRE_TRANSFORMATION_DEEP = 0x01030200;
  /**
   * A mellower voice.
   */
  public final static int TIMBRE_TRANSFORMATION_MELLOW = 0x01030300;
  /**
   * A falsetto voice.
   */
  public final static int TIMBRE_TRANSFORMATION_FALSETTO = 0x01030400;
  /**
   * A fuller voice.
   */
  public final static int TIMBRE_TRANSFORMATION_FULL = 0x01030500;
  /**
   * A clearer voice.
   */
  public final static int TIMBRE_TRANSFORMATION_CLEAR = 0x01030600;
  /**
   * A more resounding voice.
   */
  public final static int TIMBRE_TRANSFORMATION_RESOUNDING = 0x01030700;
  /**
   * A more ringing voice.
   */
  public final static int TIMBRE_TRANSFORMATION_RINGING = 0x01030800;
  /**
   * A ultra high quality voice.
   */
  public final static int ULTRA_HIGH_QUALITY_VOICE = 0x01040100;
  /**
   * An audio effect typical of a KTV venue.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int ROOM_ACOUSTICS_KTV = 0x02010100;
  /**
   * An audio effect typical of a concert hall.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int ROOM_ACOUSTICS_VOCAL_CONCERT = 0x02010200;
  /**
   * An audio effect typical of a recording studio.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int ROOM_ACOUSTICS_STUDIO = 0x02010300;
  /**
   * An audio effect typical of a vintage phonograph.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int ROOM_ACOUSTICS_PHONOGRAPH = 0x02010400;
  /**
   * A virtual stereo effect that renders monophonic audio as stereo audio.
   *
   * @note
   * Call {@link RtcEngine#setAudioProfile setAudioProfile} and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator; otherwise, the enumerator setting does not take effect.
   */
  public final static int ROOM_ACOUSTICS_VIRTUAL_STEREO = 0x02010500;
  /**
   * A more spatial audio effect.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int ROOM_ACOUSTICS_SPACIAL = 0x02010600;
  /**
   * A more ethereal audio effect.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int ROOM_ACOUSTICS_ETHEREAL = 0x02010700;
  /**
   * A 3D voice effect that makes the voice appear to be moving around the user. The default cycle
   * period of the 3D voice effect is 10 seconds. To change the cycle period, call {@link
   * RtcEngine#setAudioEffectParameters setAudioEffectParameters} after this method.
   *
   * @note
   * - Call {@link RtcEngine#setAudioProfile setAudioProfile} and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator; otherwise, the enumerator setting does not take effect
   * - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear
   * the anticipated voice effect.
   */
  public final static int ROOM_ACOUSTICS_3D_VOICE = 0x02010800;
  /**
   * The voice of a middle-aged man.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int VOICE_CHANGER_EFFECT_UNCLE = 0x02020100;
  /**
   * The voice of an old man.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int VOICE_CHANGER_EFFECT_OLDMAN = 0x02020200;
  /**
   * The voice of a boy.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int VOICE_CHANGER_EFFECT_BOY = 0x02020300;
  /**
   * The voice of a young woman.
   *
   * @note
   * - Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int VOICE_CHANGER_EFFECT_SISTER = 0x02020400;
  /**
   * The voice of a girl.
   *
   * @note
   * - Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int VOICE_CHANGER_EFFECT_GIRL = 0x02020500;
  /**
   * The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int VOICE_CHANGER_EFFECT_PIGKING = 0x02020600;
  /**
   * The voice of Hulk.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int VOICE_CHANGER_EFFECT_HULK = 0x02020700;
  /**
   * An audio effect typical of R&B music.
   *
   * @note
   * Call {@link RtcEngine#setAudioProfile setAudioProfile} and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator; otherwise, the enumerator setting does not take effect.
   */
  public final static int STYLE_TRANSFORMATION_RNB = 0x02030100;
  /**
   * An audio effect typical of popular music.
   *
   * @note
   * Call {@link RtcEngine#setAudioProfile setAudioProfile} and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator; otherwise, the enumerator setting does not take effect.
   */
  public final static int STYLE_TRANSFORMATION_POPULAR = 0x02030200;
  /**
   * A pitch correction effect that corrects the user's pitch based on the pitch of the natural C
   * major scale. To change the basic mode and tonic pitch, call {@link
   * RtcEngine#setAudioEffectParameters setAudioEffectParameters} after this method.
   *
   * @note
   * To achieve better audio effect quality, Agora recommends calling {@link
   * RtcEngine#setAudioProfile setAudioProfile} and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  public final static int PITCH_CORRECTION = 0x02040100;
  /**
   * Turn off voice conversion effects and use the original voice.
   *
   * @since v3.3.1.
   */
  public final static int VOICE_CONVERSION_OFF = 0x00000000;
  /**
   * A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to
   * process a female-sounding voice.
   *
   * @since v3.3.1.
   */
  public final static int VOICE_CHANGER_NEUTRAL = 0x03010100;
  /**
   * A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a
   * female-sounding voice.
   *
   * @since v3.3.1.
   */
  public final static int VOICE_CHANGER_SWEET = 0x03010200;
  /**
   * A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a
   * male-sounding voice.
   *
   * @since v3.3.1.
   */
  public final static int VOICE_CHANGER_SOLID = 0x03010300;
  /**
   * A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a
   * male-sounding voice.
   *
   * @since v3.3.1.
   */
  public final static int VOICE_CHANGER_BASS = 0x03010400;

  /**
   * 0: Communication.
   * Use this profile when there are two users in the channel.
   */
  public final static int CHANNEL_PROFILE_COMMUNICATION = 0;
  /**
   * 1: (Default) Live Broadcast.
   * Use this profile when there are more than two users in the channel.
   */
  public final static int CHANNEL_PROFILE_LIVE_BROADCASTING = 1;
  /**
   * 2: Gaming.
   * This profile is deprecated.
   */
  public final static int CHANNEL_PROFILE_GAME = 2;
  /**
   * 3: Cloud Gaming.
   *
   * This profile is for the interactive streaming scenario, which is highly sensitive to end-to-end
   * latency, and any delay in render impacts the end-user experience. These use cases prioritize
   * reducing delay over any smoothing done at the receiver.
   *
   * We recommend using this profile in scenarios there users need to interact with each other.
   */
  public final static int CHANNEL_PROFILE_CLOUD_GAMING = 3;

  /**
   * 4: Communication 1v1.
   *
   * This profile uses a special network transport strategy for communication 1v1
   */
  public final static int CHANNEL_PROFILE_COMMUNICATION_1v1 = 4;

  /**
   * 5: Live Broadcast 2.
   *
   * This profile technical preview.
   */
  public final static int CHANNEL_PROFILE_LIVE_BROADCASTING_2 = 5;

  /**
   * The broadcaster.
   */
  public final static int CLIENT_ROLE_BROADCASTER = 1;
  /**
   * The audience.
   */
  public final static int CLIENT_ROLE_AUDIENCE = 2;

  /**
   * 1: Low latency. A low latency audience's jitter buffer is 1.2 second.
   */
  public final static int AUDIENCE_LATENCY_LEVEL_LOW_LATENCY = 1;
  /**
   * 2: Ultra low latency. An ultra low latency audience's jitter buffer is 0.5 second.
   */
  public final static int AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY = 2;

  /**
   * 0: The user has quit the call.
   */
  public final static int USER_OFFLINE_QUIT = 0;
  /**
   * 1. The SDK timed out and the user dropped offline because it has not received any data package
   * for a period of time.
   */
  public final static int USER_OFFLINE_DROPPED = 1;
  /**
   * 2. Triggered when the client role has changed from the broadcaster to the audience.
   */
  public final static int USER_OFFLINE_BECOME_AUDIENCE = 2;

  // Inject stream status
  /** The external video stream imported successfully. */
  public final static int INJECT_STREAM_STATUS_START_SUCCESS = 0;
  /** The external video stream already exists. */
  public final static int INJECT_STREAM_STATUS_START_ALREADY_EXISTS = 1;
  /** The external video stream import is unauthorized */
  public final static int INJECT_STREAM_STATUS_START_UNAUTHORIZED = 2;
  /** Import external video stream timeout. */
  public final static int INJECT_STREAM_STATUS_START_TIMEDOUT = 3;
  /** The external video stream failed to import. */
  public final static int INJECT_STREAM_STATUS_START_FAILED = 4;
  /** The xternal video stream imports successfully. */
  public final static int INJECT_STREAM_STATUS_STOP_SUCCESS = 5;
  /** No external video stream is found. */
  public final static int INJECT_STREAM_STATUS_STOP_NOT_FOUND = 6;
  /** The external video stream is stopped from being unauthorized. */
  public final static int INJECT_STREAM_STATUS_STOP_UNAUTHORIZED = 7;
  /** Importing the external video stream timeout. */
  public final static int INJECT_STREAM_STATUS_STOP_TIMEDOUT = 8;
  /** Importing the external video stream failed. */
  public final static int INJECT_STREAM_STATUS_STOP_FAILED = 9;
  /** The external video stream is broken. */
  public final static int INJECT_STREAM_STATUS_BROKEN = 10;

  // Format pf the quality report
  /**
   * The quality report in JSON format.
   */
  public static final int QUALITY_REPORT_FORMAT_JSON = 0;
  /**
   * The quality report in HTML format.
   */
  public static final int QUALITY_REPORT_FORMAT_HTML = 1;

  /**
   * 1: Uniformly scale the video until it fills the visible boundaries (cropped). One dimension of
   * the video may have clipped contents.
   */
  public static final int RENDER_MODE_HIDDEN = 1;
  /**
   * 2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit).
   * Areas that are not filled due to the disparity in the aspect ratio will be filled with black.
   */
  public static final int RENDER_MODE_FIT = 2;
  /**
   * 3: This mode is deprecated.
   */
  public static final int RENDER_MODE_ADAPTIVE = 3;

  // Local video mirror mode
  /**
   * The default mirror mode, that is, the mode set by the SDK.
   */
  public static final int VIDEO_MIRROR_MODE_AUTO = 0;
  /**
   * Enable the mirror mode.
   */
  public static final int VIDEO_MIRROR_MODE_ENABLED = 1;
  /**
   * Disable the mirror mode
   */
  public static final int VIDEO_MIRROR_MODE_DISABLED = 2;
  /**
   * Video captured by the camera.
   */
  public static final int VIDEO_SOURCE_CAMERA_PRIMARY = 0;
  /**
   * Video captured by the secondary camera.
   */
  public static final int VIDEO_SOURCE_CAMERA_SECONDARY = 1;
  /**
   * Video for screen sharing.
   */
  public static final int VIDEO_SOURCE_SCREEN_PRIMARY = 2;
  /**
   * Video for secondary screen sharing.
   */
  public static final int VIDEO_SOURCE_SCREEN_SECONDARY = 3;
  /**
   * Not define.
   */
  public static final int VIDEO_SOURCE_CUSTOM = 4;
  /**
   * Video for media player sharing.
   */
  public static final int VIDEO_SOURCE_MEDIA_PLAYER = 5;
  /**
   * Video for png image.
   */
  public static final int VIDEO_SOURCE_RTC_IMAGE_PNG = 6;
  /**
   * Video for png image.
   */
  public static final int VIDEO_SOURCE_RTC_IMAGE_JPEG = 7;
  /**
   * Video for png image.
   */
  public static final int VIDEO_SOURCE_RTC_IMAGE_GIF = 8;
  /**
   * Remote video received from network.
   */
  public static final int VIDEO_SOURCE_REMOTE = 9;
  /**
   * Video for transcoded.
   */
  public static final int VIDEO_SOURCE_TRANSCODED = 10;

  public static final int VIDEO_SOURCE_UNKNOWN = 100;

  /**
   * Do not output any log.
   */
  public static final int LOG_FILTER_OFF = 0;
  /**
   * Output all the API logs.
   */
  public static final int LOG_FILTER_DEBUG = 0x80f;
  /**
   * Output logs of the CRITICAL, ERROR, WARNING, and INFO level.
   */
  public static final int LOG_FILTER_INFO = 0x0f;
  /**
   * Output logs of the CRITICAL, ERROR, and WARNING level.
   */
  public static final int LOG_FILTER_WARNING = 0x0e;
  /**
   * Output logs of the CRITICAL and ERROR level.
   */
  public static final int LOG_FILTER_ERROR = 0x0c;
  /**
   * Output logs of the CRITICAL level.
   */
  public static final int LOG_FILTER_CRITICAL = 0x08;

  /**
   * -1: The default audio route.
   */
  public static final int AUDIO_ROUTE_DEFAULT = -1;
  /**
   * 0: Headset.
   */
  public static final int AUDIO_ROUTE_HEADSET = 0;
  /**
   * 1: Earpiece. The SDK uses the in-call volume.
   */
  public static final int AUDIO_ROUTE_EARPIECE = 1;
  /**
   * 2: Headset with no microphone.
   */
  public static final int AUDIO_ROUTE_HEADSETNOMIC = 2;
  /**
   * 3: Speakerphone.
   */
  public static final int AUDIO_ROUTE_SPEAKERPHONE = 3;
  /**
   * 4: Loudspeaker
   */
  public static final int AUDIO_ROUTE_LOUDSPEAKER = 4;
  /**
   * 5: Bluetooth headset.
   */
  public static final int AUDIO_ROUTE_HEADSETBLUETOOTH = 5;

  /**
   * 0: The high-stream video, that is, the video stream featuring in high resolution
   * and high bitrate.
   */
  public static final int VIDEO_STREAM_HIGH = 0;
  /**
   * 1: The low-stream video, that is, the video stream featuring in low resolution and
   * low bitrate.
   */
  public static final int VIDEO_STREAM_LOW = 1;
  /**
   * High Priority, if you set a user with high priority, then streams of
   * this user will have high priority than streams of other users with normal default priority.
   * i.e., the SDK will take priority into account when deciding which user's stream need to
   * fallback when network congestion occurs.
   */
  public static final int USER_PRIORITY_HIGH = 50;
  /**
   * Default priority.
   */
  public static final int USER_PRIORITY_NORANL = 100;

  /**
   * Hardware encoder.
   */
  public static final int HARDWARE_ENCODER = 0;
  /**
   * Software encoder.
   */
  public static final int SOFTWARE_ENCODER = 1;
  /**
   * Read-only mode, users only read the AudioFrame data without modifying anything. For example,
   * when users acquire data with the Agora SDK, and push RTMP streams by themselves.
   */
  public static final int RAW_AUDIO_FRAME_OP_MODE_READ_ONLY = 0;
  /**
   * Write-only mode, users replace the AudioFrame data with their own data  and pass it to the SDK
   * for encoding. For example, when users acquire data by themselves.
   */
  public static final int RAW_AUDIO_FRAME_OP_MODE_WRITE_ONLY = 1;
  /**
   *  Read and write mode, users read the data from AudioFrame, modify it and then play it. For
   * example, when users have their own sound-effect processing module, and want to do voice
   * pre-processing, such as a voice change.
   */
  public static final int RAW_AUDIO_FRAME_OP_MODE_READ_WRITE = 2;

  public static final int MEDIA_ENGINE_RECORDING_ERROR = 0;
  public static final int MEDIA_ENGINE_PLAYOUT_ERROR = 1;
  public static final int MEDIA_ENGINE_RECORDING_WARNING = 2;
  public static final int MEDIA_ENGINE_PLAYOUT_WARNING = 3;
  public static final int MEDIA_ENGINE_AUDIO_FILE_MIX_FINISH = 10;
  // Media engine role changed
  public static final int MEDIA_ENGINE_ROLE_BROADCASTER_SOLO = 20;
  public static final int MEDIA_ENGINE_ROLE_BROADCASTER_INTERACTIVE = 21;
  public static final int MEDIA_ENGINE_ROLE_AUDIENCE = 22;
  public static final int MEDIA_ENGINE_ROLE_COMM_PEER = 23;

  // Network type
  /** -1: The network type is unknown. */
  public static final int NETWORK_TYPE_UNKNOWN = -1;
  /** 0: The SDK disconnects from the network. */
  public static final int NETWORK_TYPE_DISCONNECTED = 0;
  /** 1: The network type is LAN. */
  public static final int NETWORK_TYPE_LAN = 1;
  /** 2: The network type is Wi-Fi (including hotspots). */
  public static final int NETWORK_TYPE_WIFI = 2;
  /** 3: The network type is mobile 2G. */
  public static final int NETWORK_TYPE_MOBILE_2G = 3;
  /** 4: The network type is mobile 3G. */
  public static final int NETWORK_TYPE_MOBILE_3G = 4;
  /** 5: The network type is mobile 4G. */
  public static final int NETWORK_TYPE_MOBILE_4G = 5;

  // RTMP stream lifecycle
  /**
   * Bound to the channel lifecycle.
   */
  public static final int STREAM_LIFE_CYCLE_BIND2CHANNEL = 1;
  /**
   * Bound to the owner of the RTMP stream.
   */
  public static final int STREAM_LIFE_CYCLE_BIND2OWNER = 2;

  /**
   * 1: mic audio file recording.
   */
  public static final int AUDIO_FILE_RECORDING_MIC = 1;
  /**
   * 2: playback audio file recording.
   */
  public static final int AUDIO_FILE_RECORDING_PLAYBACK = 2;
  /**
   * 3: mixed audio file recording, include mic and playback.
   */
  public static final int AUDIO_FILE_RECORDING_MIXED = 3;

  /**
   * Low quality, file size is around 1.2 MB after 10 minutes of recording.
   */
  public static final int AUDIO_RECORDING_QUALITY_LOW = 0;
  /**
   * Medium quality, file size is around 2 MB after 10 minutes of recording.
   */
  public static final int AUDIO_RECORDING_QUALITY_MEDIUM = 1;
  /**
   * High quality, file size is around 3.75 MB after 10 minutes of recording.
   */
  public static final int AUDIO_RECORDING_QUALITY_HIGH = 2;

  /**
   * 1: mic audio frame observer
   */
  public static final int AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIC = 1;
  /**
   * 2: playback audio frame observer
   */
  public static final int AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK = 2;
  /**
   * 3: mixed audio frame observer
   */
  public static final int AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIXED = 3;

  /**
   * 1: codecType AAC; sampleRate 16000; quality low which around 1.2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_AAC_16000_LOW = 0x010101;
  /**
   * 2: codecType AAC; sampleRate 16000; quality medium which around 2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_AAC_16000_MEDIUM = 0x010102;
  /**
   * 3: codecType AAC; sampleRate 32000; quality low which around 1.2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_AAC_32000_LOW = 0x010201;
  /**
   * 4: codecType AAC; sampleRate 32000; quality medium which around 2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_AAC_32000_MEDIUM = 0x010202;
  /**
   * 5: codecType AAC; sampleRate 32000; quality high which around 3.5 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_AAC_32000_HIGH = 0x010203;
  /**
   * 6: codecType AAC; sampleRate 48000; quality medium which around 2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_AAC_48000_MEDIUM = 0x010302;
  /**
   * 7: codecType AAC; sampleRate 48000; quality high which around 3.5 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_AAC_48000_HIGH = 0x010303;
  /**
   * 11: codecType OPUS; sampleRate 16000; quality low which around 1.2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_OPUS_16000_LOW = 0x020101;
  /**
   * 12: codecType OPUS; sampleRate 16000; quality medium which around 2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_OPUS_16000_MEDIUM = 0x020102;
  /**
   * 13: codecType OPUS; sampleRate 48000; quality medium which around 2 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_OPUS_48000_MEDIUM = 0x020302;
  /**
   * 14: codecType OPUS; sampleRate 48000; quality high which around 3.5 MB after 10 minutes
   */
  public static final int AUDIO_ENCODING_TYPE_OPUS_48000_HIGH = 0x020303;

  /** None */
  public final static int MEDIA_TYPE_NONE = 0;
  /** Audio only */
  public final static int MEDIA_TYPE_AUDIO_ONLY = 1;
  /** Video only */
  public final static int MEDIA_TYPE_VIDEO_ONLY = 2;
  /** Audio and video */
  public final static int MEDIA_TYPE_AUDIO_AND_VIDEO = 3;

  public final static int STREAM_FALLBACK_OPTION_DISABLED = 0;

  public final static int STREAM_FALLBACK_OPTION_VIDEO_STREAM_LOW = 1;

  /** Local video state types */
  /** Initial state */
  public final static int LOCAL_VIDEO_STREAM_STATE_STOPPED = 0;
  /** The capturer starts successfully. */
  public final static int LOCAL_VIDEO_STREAM_STATE_CAPTURING = 1;
  /** The first video frame is successfully encoded. */
  public final static int LOCAL_VIDEO_STREAM_STATE_ENCODING = 2;
  /** The local video fails to start. */
  public final static int LOCAL_VIDEO_STREAM_STATE_FAILED = 3;

  /** Reasons for the local video failure. */
  /**
   * 0: The local video is normal.
   */
  public final static int LOCAL_VIDEO_STREAM_ERROR_OK = 0;
  /**
   * 1: No specified reason for the local video failure.
   */
  public final static int LOCAL_VIDEO_STREAM_ERROR_FAILURE = 1;
  /**
   * 2: No permission to use the local video device.
   */
  public final static int LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION = 2;
  /**
   * 3: The local video capturer is in use.
   */
  public final static int LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY = 3;
  /**
   * 4: The local video capture fails. Check whether the capturer is working properly.
   */
  public final static int LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE = 4;
  /**
   * 5: The local video encoding fails.
   */
  public final static int LOCAL_VIDEO_STREAM_ERROR_ENCODE_FAILURE = 5;

  /** Remote video state. */
  /** Default state */
  public final static int REMOTE_VIDEO_STATE_STOPPED = 0;
  /** 1: video packet has been received, but not decoded yet. */
  public final static int REMOTE_VIDEO_STATE_STARTING = 1;
  /** 2: Remote video is playing. */
  public final static int REMOTE_VIDEO_STATE_PLAYING = 2;
  /** 3: Remote video is frozen, probably due to network issue. */
  public final static int REMOTE_VIDEO_STATE_FROZEN = 3;
  /** 4: Failed. */
  public final static int REMOTE_VIDEO_STATE_FAILED = 4;

  /**  Reasons for a remote video state change. */
  /**
   * 0: Internal reasons.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_INTERNAL = 0;
  /**
   * 1: Network congestion.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION = 1;
  /**
   * 2: Network recovery.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY = 2;
  /**
   * 3: The local user stops receiving the remote video stream or disables the video module.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED = 3;
  /**
   * 4: The local user resumes receiving the remote video stream or enables the video module.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED = 4;
  /**
   * 5: The remote user stops sending the video stream or disables the video module.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED = 5;
  /**
   * 6: The remote user resumes sending the video stream or enables the video module.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED = 6;
  /**
   * 7: The remote user leaves the channel.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE = 7;
  /**
   * 8: The remote media stream falls back to the audio-only stream due to poor network conditions.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK = 8;
  /**
   * 9: The remote media stream switches back to the video stream after the network conditions
   * improve.
   */
  public final static int REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY = 9;

  /** The audio mixing state types */
  /**
   * 710: The audio mixing file is playing.
   */
  public final static int AUDIO_MIXING_STATE_PLAYING = 710;
  /**
   * 711: The audio mixing file pauses playing.
   */
  public final static int AUDIO_MIXING_STATE_PAUSED = 711;
  /**
   * 713: The audio mixing file stops playing.
   */
  public final static int AUDIO_MIXING_STATE_STOPPED = 713;
  /**
   * 714: An exception occurs when playing the audio mixing file. See the errorCode for details.
   */
  public final static int AUDIO_MIXING_STATE_FAILED = 714;
  /**
   * 715: The audio mixing file is played once.
   */
  public final static int AUDIO_MIXING_STATE_COMPLETED = 715;
  /**
   * 716: The audio mixing file is all played out.
   */
  public final static int AUDIO_MIXING_STATE_ALL_LOOPS_COMPLETED = 716;

  /** The audio mixing error type. */
  /**
   * 701: An error occurs in opening the audio mixing file.
   */
  public final static int AUDIO_MIXING_ERROR_CAN_NOT_OPEN = 701;
  /**
   * 702: The SDK opens the audio mixing file too frequently.
   */
  public final static int AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL = 702;
  /**
   * 703: The audio mixing file playback is interrupted.
   */
  public final static int AUDIO_MIXING_ERROR_INTERRUPTED_EOF = 703;
  /**
   * 0: No error.
   */
  public final static int AUDIO_MIXING_ERROR_OK = 0;

  /** Video codec types VIDEO_CODEC_TYPE*/
  public final static int VIDEO_CODEC_VP8 = 1;
  public final static int VIDEO_CODEC_H264 = 2;
  public final static int VIDEO_CODEC_H265 = 3;
  public final static int VIDEO_CODEC_VP9 = 5;
  public final static int VIDEO_CODEC_GENERIC = 6;
  public final static int VIDEO_CODEC_GENERIC_H264 = 7;
  public final static int VIDEO_CODEC_GENERIC_JPEG = 20;

  /** Transport CC enabled */
  public final static int TCC_ENABLED = 0;
  public final static int TCC_DISABLED = 1;

  public final static int AUDIO_CODEC_OPUS = 1;
  public final static int AUDIO_CODEC_AACLC = 8;
  public final static int AUDIO_CODEC_HEAAC = 9;
  public final static int AUDIO_CODEC_HEAAC2 = 11;

  /** Packetize Mode H264PacketizeMode*/
  public final static int PACKETIZE_MODE_H264_NON_INTERLEAVED = 0;
  public final static int PACKETIZE_MODE_H264_SINGLE_NAL_UNIT = 1;

  /** Video Frame Type. VIDEO_FRAME_TYPE */
  public final static int VIDEO_FRAME_TYPE_BLANK_FRAME = 0;
  public final static int VIDEO_FRAME_TYPE_KEY_FRAME = 3;
  public final static int VIDEO_FRAME_TYPE_DELTA_FRAME = 4;
  public final static int VIDEO_FRAME_TYPE_B_FRAME = 5;
  public final static int VIDEO_FRAME_TYPE_UNKNOWN = 6;

  /** clockwise rotation. VIDEO_ORIENTATION*/
  /**
   * 0: No rotation.
   */
  public final static int VIDEO_ORIENTATION_0 = 0;
  /**
   * 90: 90 degrees.
   */
  public final static int VIDEO_ORIENTATION_90 = 90;
  /**
   * 180: 180 degrees.
   */
  public final static int VIDEO_ORIENTATION_180 = 180;
  /**
   * 270: 270 degrees.
   */
  public final static int VIDEO_ORIENTATION_270 = 270;

  /**
   * The default connection ID.
   */
  public final static int DEFAULT_CONNECTION_ID = 0;

  // Connection state type
  /**
   * 1: The SDK is disconnected from Agora edge server.
   * <ul>
   *   <li>This is the initial state before calling the `joinChannel` method.</li>
   *   <li>The SDK also enters this state when the app calls the {@link RtcEngine#leaveChannel
   * leaveChannel} method.</li>
   * </ul>
   */
  public static final int CONNECTION_STATE_DISCONNECTED = 1;
  /**
   * 2: The SDK is connecting to Agora edge server.
   * <ul>
   *   <li>When the app calls the `joinChannel` method, the SDK starts to establish a connection to
   * the specified channel, triggers the {@link IRtcEngineEventHandler#onConnectionStateChanged
   * onConnectionStateChanged} callback, and switches to the {@link
   * Constants#CONNECTION_STATE_CONNECTING CONNECTION_STATE_CONNECTING} state. <li>When a user
   * successfully joins a channel, the SDK triggers the {@link
   * IRtcEngineEventHandler#onConnectionStateChanged onConnectionStateChanged} callback and switches
   * to the {@link Constants#CONNECTION_STATE_CONNECTED CONNECTION_STATE_CONNECTED} state. <li>After
   * the SDK joins the channel and when it finishes initializing the media engine, the SDK triggers
   * the {@link IRtcEngineEventHandler#onJoinChannelSuccess onJoinChannelSuccess} callback.
   * </ul>
   *
   */
  public static final int CONNECTION_STATE_CONNECTING = 2;
  /**
   * 3: The SDK is connected to Agora edge server and has joined a channel. You can now publish or
   * subscribe to a media stream in the channel. If the connection to the channel is lost because,
   * for example, the network is down or switched, the SDK triggers:
   * <ul>
   *    <li>The {@link IRtcEngineEventHandler#onConnectionInterrupted onConnectionInterrupted}
   * (deprecated) callback. <li>The {@link IRtcEngineEventHandler#onConnectionStateChanged
   * onConnectionStateChanged} callback, and switches to the {@link
   * Constants#CONNECTION_STATE_RECONNECTING CONNECTION_STATE_RECONNECTING} state.
   * </ul>
   */
  public static final int CONNECTION_STATE_CONNECTED = 3;
  /**
   * 4: The SDK keeps rejoining the channel after being disconnected from a joined channel because
   * of network issues.
   * <ul>
   *    <li>If the SDK cannot join the channel within 10 seconds after being
   * disconnected from Agora edge server, the SDK triggers the {@link
   * IRtcEngineEventHandler#onConnectionLost onConnectionLost} (deprecated) callback, stays in the
   * {@link Constants#CONNECTION_STATE_RECONNECTING CONNECTION_STATE_RECONNECTING} state, and keeps
   * rejoining the channel.
   *    <li>If the SDK fails to rejoin the channel 20 minutes after being
   * disconnected from Agora edge server, the SDK triggers the {@link
   * IRtcEngineEventHandler#onConnectionStateChanged onConnectionStateChanged} callback, switches to
   * the {@link Constants#CONNECTION_STATE_FAILED CONNECTION_STATE_FAILED} state, and stops
   * rejoining the channel.
   * </ul>
   */
  public static final int CONNECTION_STATE_RECONNECTING = 4;
  /**
   * 5: The SDK fails to connect to Agora edge server or join the channel.
   * You must call the {@link RtcEngine#leaveChannel() leaveChannel} method to leave this state and
   * call the `joinChannel` method again to rejoin the channel. If the SDK is banned from joining
   * the channel by the Agora server (through the RESTful API), the SDK triggers the {@link
   * IRtcEngineEventHandler#onConnectionBanned onConnectionBanned} and {@link
   * IRtcEngineEventHandler#onConnectionStateChanged onConnectionStateChanged} callbacks.
   */
  public static final int CONNECTION_STATE_FAILED = 5;

  // Reason for the connection state change.
  /** 0: The SDK is connecting to Agora edge server. */
  public static final int CONNECTION_CHANGED_CONNECTING = 0;
  /** 1: The SDK has joined the channel successfully. */
  public static final int CONNECTION_CHANGED_JOIN_SUCCESS = 1;
  /** 2: The connection between the SDK and Agora edge server is interrupted. */
  public static final int CONNECTION_CHANGED_INTERRUPTED = 2;
  /** 3: The connection between the SDK and Agora edge server is banned by Agora edge server. */
  public static final int CONNECTION_CHANGED_BANNED_BY_SERVER = 3;
  /**
   * 4: The SDK fails to join the channel for more than 20 minutes and stops reconnecting to the
   * channel.
   */
  public static final int CONNECTION_CHANGED_JOIN_FAILED = 4;
  /** 5: The SDK has left the channel. */
  public static final int CONNECTION_CHANGED_LEAVE_CHANNEL = 5;
  /** 6:  The specified App ID is invalid. Try to rejoin the channel with a valid App ID. */
  public static final int CONNECTION_CHANGED_INVALID_APP_ID = 6;
  /**
   * 7: The specified channel name is invalid. Try to rejoin the channel with a valid channel name.
   */
  public static final int CONNECTION_CHANGED_INVALID_CHANNEL_NAME = 7;
  /**
   * 8: The generated token is invalid probably due to the following reasons:
   * <ul>
   *     <li>The App Certificate for the project is enabled in Console, but you do not use the
   * token.
   *     <li>The uid that you specify in the `joinChannel` method is different from the uid that you
   * pass for generating the token.
   * </ul>
   */
  public static final int CONNECTION_CHANGED_INVALID_TOKEN = 8;
  /** 9: The token has expired. Generate a new token from your server. */
  public static final int CONNECTION_CHANGED_TOKEN_EXPIRED = 9;
  /** 10: The user is banned by the server. */
  public static final int CONNECTION_CHANGED_REJECTED_BY_SERVER = 10;
  /** 11: The SDK tries to reconnect after setting a proxy server. */
  public static final int CONNECTION_CHANGED_SETTING_PROXY_SERVER = 11;
  /** 12: The token renews. */
  public static final int CONNECTION_CHANGED_RENEW_TOKEN = 12;
  /**
   * 13: The client IP address has changed, probably due to a change of the network type, IP
   * address, or network port.
   */
  public static final int CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED = 13;
  /**
   * 14: Timeout for the keep-alive of the connection between the SDK and Agora edge server.
   * The connection state changes to {@link Constants#CONNECTION_STATE_RECONNECTING}(4).
   */
  public static final int CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT = 14;
  /**
   * 15: The SDK has rejoined the channel successfully.
   */
  public static final int CONNECTION_CHANGED_REJOIN_SUCCESS = 15;
  /**
   * 16: The connection between the SDK and the server is lost.
   */
  public static final int CONNECTION_CHANGED_LOST = 16;
  /**
   * 17: The change of connection state is caused by echo test.
   */
  public static final int CONNECTION_CHANGED_ECHO_TEST = 17;

  /**
   * 0: The state is normal.
   */
  public final static int RELAY_OK = 0;
  /**
   * 1: An error occurs in the server response.
   */
  public final static int RELAY_ERROR_SERVER_ERROR_RESPONSE = 1;
  /**
   * 2: No server response. You can call the leaveChannel method to leave the channel.
   */
  public final static int RELAY_ERROR_SERVER_NO_RESPONSE = 2;
  /**
   * 3: The SDK fails to access the service, probably due to limited resources of the server.
   */
  public final static int RELAY_ERROR_NO_RESOURCE_AVAILABLE = 3;
  /**
   * 4: Fails to send the relay request.
   */
  public final static int RELAY_ERROR_FAILED_JOIN_SRC = 4;
  /**
   * 5: Fails to accept the relay request.
   */
  public final static int RELAY_ERROR_FAILED_JOIN_DEST = 5;
  /**
   * 6: The server fails to receive the media stream.
   */
  public final static int RELAY_ERROR_FAILED_PACKET_RECEIVED_FROM_SRC = 6;
  /**
   * 7: The server fails to send the media stream.
   */
  public final static int RELAY_ERROR_FAILED_PACKET_SENT_TO_DEST = 7;
  /**
   * 8: The SDK disconnects from the server due to poor network connections. You can call the
   * leaveChannel method to leave the channel.
   */
  public final static int RELAY_ERROR_SERVER_CONNECTION_LOST = 8;
  /**
   * 9: An internal error occurs in the server.
   */
  public final static int RELAY_ERROR_INTERNAL_ERROR = 9;
  /**
   * 10: The token of the source channel has expired.
   */
  public final static int RELAY_ERROR_SRC_TOKEN_EXPIRED = 10;
  /**
   * 11: The token of the destination channel has expired.
   */
  public final static int RELAY_ERROR_DEST_TOKEN_EXPIRED = 11;

  /**
   * 0: The user disconnects from the server due to poor network connections.
   */
  public final static int RELAY_EVENT_NETWORK_DISCONNECTED = 0;
  /**
   * 1: The network reconnects.
   */
  public final static int RELAY_EVENT_NETWORK_CONNECTED = 1;
  /**
   * 2: The user joins the source channel.
   */
  public final static int RELAY_EVENT_PACKET_JOINED_SRC_CHANNEL = 2;
  /**
   * 3: The user joins the destination channel.
   */
  public final static int RELAY_EVENT_PACKET_JOINED_DEST_CHANNEL = 3;
  /**
   * 4: The SDK starts relaying the media stream to the destination channel.
   */
  public final static int RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL = 4;
  /**
   * 5: The server receives the video stream from the source channel.
   */
  public final static int RELAY_EVENT_PACKET_RECEIVED_VIDEO_FROM_SRC = 5;
  /**
   * 6: The server receives the audio stream from the source channel.
   */
  public final static int RELAY_EVENT_PACKET_RECEIVED_AUDIO_FROM_SRC = 6;
  /**
   * 7: The destination channel is updated.
   */
  public final static int RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL = 7;
  /**
   * 8: The destination channel update fails due to internal reasons.
   */
  public final static int RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED = 8;
  /**
   * 9: The destination channel does not change, which means that the destination channel fails to
   * be updated.
   */
  public final static int RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_NOT_CHANGE = 9;
  /**
   * 10: The destination channel name is NULL.
   */
  public final static int RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_IS_NULL = 10;
  /**
   * 11: The video profile is sent to the server.
   */
  public final static int RELAY_EVENT_VIDEO_PROFILE_UPDATE = 11;
  /**
   * 12: pause send packet to dest channel success.
   */
  public final static int RELAY_EVENT_PAUSE_SEND_PACKET_TO_DEST_CHANNEL_SUCCESS = 12;
  /**
   * 13: pause send packet to dest channel failed.
   */
  public final static int RELAY_EVENT_PAUSE_SEND_PACKET_TO_DEST_CHANNEL_FAILED = 13;
  /**
   * 14: resume send packet to dest channel success.
   */
  public final static int RELAY_EVENT_RESUME_SEND_PACKET_TO_DEST_CHANNEL_SUCCESS = 14;
  /**
   * 15: pause send packet to dest channel failed.
   */
  public final static int RELAY_EVENT_RESUME_SEND_PACKET_TO_DEST_CHANNEL_FAILED = 15;
  /**
   * 0: The SDK is initializing.
   */
  public final static int RELAY_STATE_IDLE = 0;
  /**
   * 1: The SDK tries to relay the media stream to the destination channel.
   */
  public final static int RELAY_STATE_CONNECTING = 1;
  /**
   * 2: The SDK successfully relays the media stream to the destination channel.
   */
  public final static int RELAY_STATE_RUNNING = 2;
  /**
   * 3: A failure occurs.
   */
  public final static int RELAY_STATE_FAILURE = 3;

  /**
   * media relay max dest channel size
   */
  public final static int MAX_CROSS_DEST_CHANNEL_SIZE = 4;
  /**
   * 1: Do not add an audio filter to the in-ear monitor.
   */
  public static final int EAR_MONITORING_FILTER_NONE = (1 << 0);
  /**
   * 2: Add an audio filter to the in-ear monitor.
   */
  public static final int EAR_MONITORING_FILTER_BUILT_IN_AUDIO_FILTERS = (1 << 1);
  /**
   * 4: Enable noise suppression to the in-ear monitor.
   */
  public static final int EAR_MONITORING_FILTER_NOISE_SUPPRESSION = (1 << 2);

  /** Media type. */
  public enum MediaType {
    /**
     * No audio and video.
     */
    NONE(0),
    /**
     * Audio only.
     */
    AUDIO_ONLY(1),
    /**
     * Video only.
     */
    VIDEO_ONLY(2),
    /**
     * Audio and video.
     */
    AUDIO_AND_VIDEO(3);

    private int value;
    private MediaType(int v) {
      value = v;
    }

    public static int getValue(MediaType type) {
      return type.value;
    }
  }

  /**
   *
   * Sets the audio profile sampling rate, bitrate, encode mode, and the number of channels.
   */
  public enum AudioProfile {
    /**
     * 0: The default audio profile.
     * - In the Communication profile, the default value is the same with
     * `AUDIO_PROFILE_SPEECH_STANDARD`(1).
     * - In the Live-broadcast profile, it represents a sample rate of 48 kHz, music encoding, mono,
     * and a bitrate of up to 64 Kbps.
     */
    DEFAULT(Constants.AUDIO_PROFILE_DEFAULT),
    /**
     * 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate up to 18 Kbps.
     */
    SPEECH_STANDARD(Constants.AUDIO_PROFILE_SPEECH_STANDARD),
    /**
     * 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
     */
    MUSIC_STANDARD(Constants.AUDIO_PROFILE_MUSIC_STANDARD),
    /**
     * 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80
     * Kbps.
     */
    MUSIC_STANDARD_STEREO(Constants.AUDIO_PROFILE_MUSIC_STANDARD_STEREO),
    /**
     * 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
     */
    MUSIC_HIGH_QUALITY(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY),
    /**
     * 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
     */
    MUSIC_HIGH_QUALITY_STEREO(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO);

    private int value;
    private AudioProfile(int v) {
      value = v;
    }

    public static int getValue(AudioProfile type) {
      return type.value;
    }
  }

  /**
   *
   * Sets the audio application scenarios.
   */
  public enum AudioScenario {
    /**
     * 0: (Recommended) The default audio scenario.
     */
    DEFAULT(Constants.AUDIO_SCENARIO_DEFAULT),
    /**
     * 3: (Recommended) The live gaming scenario, which needs to enable the gaming audio effects in
     * the speaker mode in a live broadcast scenario. Choose this scenario to
     * achieve high-fidelity music playback.
     */
    GAME_STREAMING(Constants.AUDIO_SCENARIO_GAME_STREAMING),
    /**
     * 5: The chatroom scenario, which needs to keep recording when setClientRole to audience.
     * Normally, app developer can also use mute api to achieve the same result,
     * and we implement this 'non-orthogonal' behavior only to make API backward compatible.
     */
    CHATROOM(Constants.AUDIO_SCENARIO_CHATROOM),
    /**
     * 6: (Recommended) High definition.
     */
    HIGH_DEFINITION(Constants.AUDIO_SCENARIO_HIGH_DEFINITION);

    private int value;
    private AudioScenario(int v) {
      value = v;
    }

    public static int getValue(AudioScenario type) {
      return type.value;
    }
  }

  /** Log Level. */
  public enum LogLevel {
    /**
     * Outputs no log.
     */
    LOG_LEVEL_NONE(0x0000),
    /**
     * Outputs logs of the INFO level.
     */
    LOG_LEVEL_INFO(0x0001),
    /**
     * Outputs logs of the WARNING level.
     */
    LOG_LEVEL_WARN(0x0002),
    /**
     * Outputs logs of the ERROR level.
     */
    LOG_LEVEL_ERROR(0x0004),
    /**
     * Outputs logs of the CRITICAL level.
     */
    LOG_LEVEL_FATAL(0x0008);

    private int value;
    private LogLevel(int v) {
      value = v;
    }

    public static int getValue(LogLevel type) {
      return type.value;
    }
  }

  /**
   * Video source types definition.
   */
  public enum VideoSourceType {
    /**
     * Video captured by the camera.
     */
    VIDEO_SOURCE_CAMERA_PRIMARY(0),
    /**
     * Video captured by the secondary camera.
     *  Not supported by Android
     */
    VIDEO_SOURCE_CAMERA_SECONDARY(1),
    /**
     * Video for screen sharing.
     */
    VIDEO_SOURCE_SCREEN_PRIMARY(2),
    /**
     * Video for secondary screen sharing.
     *  Not supported by Android
     */
    VIDEO_SOURCE_SCREEN_SECONDARY(3),
    /**
     * Video for external video frame
     */
    VIDEO_SOURCE_CUSTOM(4),
    /**
     * Video for media player sharing.
     */
    VIDEO_SOURCE_MEDIA_PLAYER(5),
    /**
     * Video for png image.
     *  Not supported by Android
     */
    VIDEO_SOURCE_RTC_IMAGE_PNG(6),
    /**
     * Video for png image.
     *  Not supported by Android
     */
    VIDEO_SOURCE_RTC_IMAGE_JPEG(7),
    /**
     * Video for png image.
     *  Not supported by Android
     */
    VIDEO_SOURCE_RTC_IMAGE_GIF(8),
    /**
     * Remote video received from network.
     *  Not supported by Android
     */
    VIDEO_SOURCE_REMOTE(9),
    /**
     * Video for transcoded.
     *  Not supported by Android
     */
    VIDEO_SOURCE_TRANSCODED(10),
    /**
     * Not define.
     */
    VIDEO_SOURCE_UNKNOWN(100);

    private int value;
    private VideoSourceType(int v) {
      value = v;
    }

    public static int getValue(VideoSourceType type) {
      return type.value;
    }
  }

  /**
   * External video source types definition.
   */
  public enum ExternalVideoSourceType {
    /**
     * 0: non-encoded video frame.
     */
    VIDEO_FRAME(0),
    /**
     * 1: encoded video frame.
     */
    ENCODED_VIDEO_FRAME(1);

    private int value;
    private ExternalVideoSourceType(int v) {
      value = v;
    }

    public static int getValue(ExternalVideoSourceType type) {
      return type.value;
    }
  }

  /**
   * The type of media device.
   */
  public enum MediaSourceType {
    /**
     * 0: The audio playback device.
     */
    AUDIO_PLAYOUT_SOURCE(0),
    /**
     * 1: Microphone.
     */
    AUDIO_RECORDING_SOURCE(1),
    /**
     * 2: Video captured by primary camera.
     */
    PRIMARY_CAMERA_SOURCE(2),
    /**
     * 3: Video captured by secondary camera.
     */
    SECONDARY_CAMERA_SOURCE(3),
    /**
     * 4: Video captured by primary screen capturer.
     */
    PRIMARY_SCREEN_SOURCE(4),
    /**
     * 5: Video captured by secondary screen capturer.
     */
    SECONDARY_SCREEN_SOURCE(5),
    /**
     * 6: Video captured by custom video source.
     */
    CUSTOM_VIDEO_SOURCE(6),
    /**
     * 7: Video for media player sharing.
     */
    MEDIA_PLAYER_SOURCE(7),
    /**
     * 8: Video for png image.
     */
    RTC_IMAGE_PNG_SOURCE(8),
    /**
     * 9: Video for jpeg image.
     */
    RTC_IMAGE_JPEG_SOURCE(9),
    /**
     * 10: Video for gif image.
     */
    RTC_IMAGE_GIF_SOURCE(10),
    /**
     * 11: Remote video received from network.
     */
    REMOTE_VIDEO_SOURCE(11),
    /**
     * 12: Video for transcoded.
     */
    TRANSCODED_VIDEO_SOURCE(12),
    /**
     * 100: unknown media source.
     */
    UNKNOWN_MEDIA_SOURCE(100);

    private int value;
    private MediaSourceType(int v) {
      value = v;
    }

    public static int getValue(MediaSourceType type) {
      if (type != null) {
        return type.value;
      }
      return UNKNOWN_MEDIA_SOURCE.value;
    }
  }
  ;

  /**
   * The audio equalization band frequency.
   */
  public enum AUDIO_EQUALIZATION_BAND_FREQUENCY {
    /**
     * 0: 31 Hz.
     */
    AUDIO_EQUALIZATION_BAND_31(0),
    /**
     * 1: 62 Hz.
     */
    AUDIO_EQUALIZATION_BAND_62(1),
    /**
     * 2: 125 Hz.
     */
    AUDIO_EQUALIZATION_BAND_125(2),
    /**
     * 3: 250 Hz.
     */
    AUDIO_EQUALIZATION_BAND_250(3),
    /**
     * 4: 500 Hz.
     */
    AUDIO_EQUALIZATION_BAND_500(4),
    /**
     * 5: 1 KHz.
     */
    AUDIO_EQUALIZATION_BAND_1K(5),
    /**
     * 6: 2 KHz.
     */
    AUDIO_EQUALIZATION_BAND_2K(6),
    /**
     * 7: 4 KHz.
     */
    AUDIO_EQUALIZATION_BAND_4K(7),
    /**
     * 8: 8 KHz.
     */
    AUDIO_EQUALIZATION_BAND_8K(8),
    /**
     * 9: 16 KHz.
     */
    AUDIO_EQUALIZATION_BAND_16K(9);

    private int value;
    public int getValue() {
      return this.value;
    }
    private AUDIO_EQUALIZATION_BAND_FREQUENCY(int v) {
      value = v;
    }

    public static AUDIO_EQUALIZATION_BAND_FREQUENCY fromInt(int v) {
      for (AUDIO_EQUALIZATION_BAND_FREQUENCY type : values()) {
        if (type.getValue() == v) {
          return type;
        }
      }
      return null;
    }
  }

  public enum AUDIO_REVERB_TYPE {
    /**
     *  Level of the dry signal (-20 to 10 dB).
     */
    AUDIO_REVERB_DRY_LEVEL(0),
    /**
     *  Level of the early reflection signal (wet signal) (-20 to 10 dB).
     */
    AUDIO_REVERB_WET_LEVEL(1),
    /**
     * Room size of the reflection (0 to 100 dB).
     */
    AUDIO_REVERB_ROOM_SIZE(2),
    /**
     * Length of the initial delay of the wet signal (0 to 200 ms)
     */
    AUDIO_REVERB_WET_DELAY(3),
    /**
     * Strength of the late reverberation (0 to 100).
     */
    AUDIO_REVERB_STRENGTH(4);

    private int value;
    public int getValue() {
      return this.value;
    }
    private AUDIO_REVERB_TYPE(int v) {
      value = v;
    }

    public static AUDIO_REVERB_TYPE fromInt(int v) {
      for (AUDIO_REVERB_TYPE type : values()) {
        if (type.getValue() == v) {
          return type;
        }
      }
      return null;
    }
  }

  /**
   * Thread priority type.
   */
  public enum ThreadPriorityType {
    /**
     * 0: Lowest priority.
     */
    LOWEST(0),
    /**
     * 1: Low priority.
     */
    LOW(1),
    /**
     * 2: Normal priority.
     */
    NORMAL(2),
    /**
     * 3: High priority.
     */
    HIGH(3),
    /**
     * 4. Highest priority.
     */
    HIGHEST(4),
    /**
     * 5. Critical priority.
     */
    CRITICAL(5);
    private int value;
    private ThreadPriorityType(int v) {
      value = v;
    }

    public static int getValue(ThreadPriorityType type) {
      return type.value;
    }
  }
}
