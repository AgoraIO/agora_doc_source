//
// AgoraEnumerates.h
// AgoraRtcEngineKit
//
// Copyright (c) 2018 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Warning code.
 *
 * Warning codes occur when the SDK encounters an error that may be recovered automatically.
 * These are only notifications, and can generally be ignored. For example, when the SDK loses connection to the server, the SDK reports the AgoraWarningCodeOpenChannelTimeout(106) warning and tries to reconnect automatically.
 */
typedef NS_ENUM(NSInteger, AgoraWarningCode) {
    /** 8: The specified view is invalid. Specify a view when using the video call function. */
    AgoraWarningCodeInvalidView = 8,
    /** 16: Failed to initialize the video function, possibly caused by a lack of resources. The users cannot see the video while the voice communication is not affected. */
    AgoraWarningCodeInitVideo = 16,
     /** 20: The request is pending, usually due to some module not being ready, and the SDK postpones processing the request. */
    AgoraWarningCodePending = 20,
    /** 103: No channel resources are available. Maybe because the server cannot allocate any channel resource. */
    AgoraWarningCodeNoAvailableChannel = 103,
    /** 104: A timeout occurs when looking up the channel. When joining a channel, the SDK looks up the specified channel. The warning usually occurs when the network condition is too poor for the SDK to connect to the server. */
    AgoraWarningCodeLookupChannelTimeout = 104,
    /** 105: The server rejects the request to look up the channel. The server cannot process this request or the request is illegal. */
    AgoraWarningCodeLookupChannelRejected = 105,
    /** 106: The server rejects the request to look up the channel. The server cannot process this request or the request is illegal. */
    AgoraWarningCodeOpenChannelTimeout = 106,
    /** 107: The server rejects the request to open the channel. The server cannot process this request or the request is illegal. */
    AgoraWarningCodeOpenChannelRejected = 107,
    /** 111: A timeout occurs when switching to the live video. */
    AgoraWarningCodeSwitchLiveVideoTimeout = 111,
    /** 118: A timeout occurs when setting the client role in the live broadcast profile. */
    AgoraWarningCodeSetClientRoleTimeout = 118,
    /** 119: The client role is unauthorized. */
    AgoraWarningCodeSetClientRoleNotAuthorized = 119,
    /** 121: The ticket to open the channel is invalid. */
    AgoraWarningCodeOpenChannelInvalidTicket = 121,
    /** 122: Try connecting to another server. */
    AgoraWarningCodeOpenChannelTryNextVos = 122,
    /** 701: An error occurs in opening the audio mixing file. */
    AgoraWarningCodeAudioMixingOpenError = 701,
    /** 1014: Audio Device Module: a warning occurs in the playback device. */
    AgoraWarningCodeAdmRuntimePlayoutWarning = 1014,
    /** 1016: Audio Device Module: a warning occurs in the recording device. */
    AgoraWarningCodeAdmRuntimeRecordingWarning = 1016,
    /** 1019: Audio Device Module: no valid audio data is collected. */
    AgoraWarningCodeAdmRecordAudioSilence = 1019,
    /** 1020: Audio Device Module: a playback device fails. */
    AgoraWarningCodeAdmPlaybackMalfunction = 1020,
    /** 1021: Audio Device Module: a recording device fails. */
    AgoraWarningCodeAdmRecordMalfunction = 1021,
    /** 1025: Call is interrupted by system events such as phone call or Siri. */
    AgoraWarningCodeAdmInterruption = 1025,
    /** 1031: Audio Device Module: the recorded audio is too low. */
    AgoraWarningCodeAdmRecordAudioLowlevel = 1031,
    /** 1032: Audio Device Module: the playback audio is too low. */
    AgoraWarningCodeAdmPlayoutAudioLowlevel = 1032,
    /** 1051: Audio Device Module: howling is detected. */
    AgoraWarningCodeApmHowling = 1051,
    /** 1052: Audio Device Module: the device is in the glitch state. */
    AgoraWarningCodeAdmGlitchState = 1052,
    /** 1053: Audio Device Module: the underlying audio settings have changed. */
    AgoraWarningCodeAdmImproperSettings = 1053,
};

/**
 * Error code.
 *
 * Error codes occur when the SDK encounters an error that cannot be recovered automatically without any app intervention.
 * For example, the SDK reports the {@link AgoraErrorCodeStartCall}(1002) error if it fails to start a call.
 */
typedef NS_ENUM(NSInteger, AgoraErrorCode) {
    /** 0: No error occurs. */
    AgoraErrorCodeNoError = 0,
    /** 1: A general error occurs (no specified reason). */
    AgoraErrorCodeFailed = 1,
    /** 2: An invalid parameter is used. For example, the specific channel name includes illegal characters. */
    AgoraErrorCodeInvalidArgument = 2,
    /**
     * 3: The SDK module is not ready.
     *
     * Possible solutions：
     * - Check the audio device.
     * - Check the completeness of the app.
     * - Re-initialize the SDK.
     */
    AgoraErrorCodeNotReady = 3,
    /** 4: The current state of the SDK does not support this function. */
    AgoraErrorCodeNotSupported = 4,
    /** 5: The request is rejected. This is for internal SDK use only, and is not returned to the app through any method or callback. */
    AgoraErrorCodeRefused = 5,
    /** 6: The buffer size is not big enough to store the returned data. */
    AgoraErrorCodeBufferTooSmall = 6,
    /** 7: The SDK is not initialized before calling this method. */
    AgoraErrorCodeNotInitialized = 7,
    /** 9: No permission exists. Check if the user has granted access to the audio or video device. */
    AgoraErrorCodeNoPermission = 9,
    /** 10: An API method timeout occurs. Some API methods require the SDK to return the execution result, and this error occurs if the request takes too long (over 10 seconds) for the SDK to process. */
    AgoraErrorCodeTimedOut = 10,
    /** 11: The request is canceled. This is for internal SDK use only, and is not returned to the app through any method or callback. */
    AgoraErrorCodeCanceled = 11,
    /** 12: The method is called too often. This is for internal SDK use only, and is not returned to the app through any method or callback. */
    AgoraErrorCodeTooOften = 12,
    /** 13: The SDK fails to bind to the network socket. This is for internal SDK use only, and is not returned to the app through any method or callback. */
    AgoraErrorCodeBindSocket = 13,
    /** 14: The network is unavailable. This is for internal SDK use only, and is not returned to the app through any method or callback. */
    AgoraErrorCodeNetDown = 14,
    /** 15: No network buffers are available. This is for internal SDK use only, and is not returned to the app through any method or callback. */
    AgoraErrorCodeNoBufs = 15,
    /**
     * 17: The request to join the channel is rejected.
     *
     * Possible reasons:
     * - The user is already in the channel, and still calls the API method to join the channel, for example `joinChannelByToken`.
     * - The user tries joining the channel during the echo test. Please join the channel after the echo test ends.
    */
    AgoraErrorCodeJoinChannelRejected = 17,
    /**
     * 18: The request to leave the channel is rejected.
     *
     * Possible reasons are:
     * - The user left the channel and still calls the API method to leave the channel, for example, {@link AgoraRtcEngineKit.leaveChannel: leaveChannel}.
     * - The user has not joined the channel and calls the API method to leave the channel.
     */
    AgoraErrorCodeLeaveChannelRejected = 18,
    /** 19: The resources are occupied and cannot be used. */
    AgoraErrorCodeAlreadyInUse = 19,
    /** 20: The SDK gave up the request due to too many requests.  */
    AgoraErrorCodeAbort = 20,
    /** 21: In Windows, specific firewall settings cause the SDK to fail to initialize and crash. */
    AgoraErrorCodeInitNetEngine = 21,
    /** 22: The app uses too much of the system resources and the SDK fails to allocate the resources. */
    AgoraErrorCodeResourceLimited = 22,
    /** 101: The specified App ID is invalid. Please try to rejoin the channel with a valid App ID.*/
    AgoraErrorCodeInvalidAppId = 101,
    /** 102: The specified channel name is invalid. Please try to rejoin the channel with a valid channel name. */
    AgoraErrorCodeInvalidChannelId = 102,
    /**
     * 109: The token expired.
     *
     * Possible reasons are:
     * - Authorized Timestamp expired: The timestamp is represented by the number of seconds elapsed since 1/1/1970. The user can use the token to access the Agora service within 24 hours after the token is generated. If the user does not access the Agora service after 24 hours, this token is no longer valid.
     * - Call Expiration Timestamp expired: The timestamp is the exact time when a user can no longer use the Agora service (for example, when a user is forced to leave an ongoing call). When a value is set for the Call Expiration Timestamp, it does not mean that the token will expire, but that the user will be banned from the channel.
     */
    AgoraErrorCodeTokenExpired = 109,
    /**
     * 110: The token is invalid.
     *
     * Possible reasons are:
     * - The App Certificate for the project is enabled in Console, but the user is using the App ID. Once the App Certificate is enabled, the user must use a token.
     * - The uid is mandatory, and users must set the same uid as the one set in the `joinChannelByToken` method.
     */
    AgoraErrorCodeInvalidToken = 110,
    /** 111: The Internet connection is interrupted. This applies to the Agora Web SDK only. */
    AgoraErrorCodeConnectionInterrupted = 111,
    /** 112: The Internet connection is lost. This applies to the Agora Web SDK only. */
    AgoraErrorCodeConnectionLost = 112,
    /** 113: The user is not in the channel when calling the `sendStreamMessage` or `getUserInfoByUserAccount` method. */
    AgoraErrorCodeNotInChannel = 113,
    /** 114: The size of the sent data is over 1024 bytes when the user calls the `sendStreamMessage` method. */
    AgoraErrorCodeSizeTooLarge = 114,
    /** 115: The bitrate of the sent data exceeds the limit of 6 Kbps when the user calls the `sendStreamMessage` method. */
    AgoraErrorCodeBitrateLimit = 115,
    /** 116: Too many data streams (over five streams) are created when the user calls the `createDataStream` method. */
    AgoraErrorCodeTooManyDataStreams = 116,
    /** 120: Decryption fails. The user may have used a different encryption password to join the channel. Check your settings or try rejoining the channel. */
    AgoraErrorCodeDecryptionFailed = 120,
    /** 124: Incorrect watermark file parameter. */
    AgoraErrorCodeWatermarkParam = 124,
    /** 125: Incorrect watermark file path. */
    AgoraErrorCodeWatermarkPath = 125,
    /** 126: Incorrect watermark file format. */
    AgoraErrorCodeWatermarkPng = 126,
    /** 127: Incorrect watermark file information. */
    AgoraErrorCodeWatermarkInfo = 127,
    /** 128: Incorrect watermark file data format. */
    AgoraErrorCodeWatermarkAGRB = 128,
    /** 129: An error occurs in reading the watermark file. */
    AgoraErrorCodeWatermarkRead = 129,
    /** 130: The encrypted stream is not allowed to publish. */
    AgoraErrorCodeEncryptedStreamNotAllowedPublish = 130,
    /** Stream publishing failed. */
    AgoraErrorCodePublishFailed = 150,
    /** 151: CDN related errors. Remove the original URL address and add a new one by calling the [removePublishStreamUrl]([AgoraRtcEngineKit removePublishStreamUrl:]) and [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) methods. */
    AgoraErrorCodePublishStreamCDNError = 151,
    /** 1001: Fails to load the media engine. */
    AgoraErrorCodeLoadMediaEngine = 1001,
    /** 1002: Fails to start the call after enabling the media engine. */
    AgoraErrorCodeStartCall = 1002,
    /** 1003: Fails to start the camera. */
    AgoraErrorCodeStartCamera = 1003,
    /** 1004: Fails to start the video rendering module. */
    AgoraErrorCodeStartVideoRender = 1004,
    /** 1005: A general error occurs in the Audio Device Module (the reason is not classified specifically). Check if the audio device is used by another app, or try rejoining the channel. */
    AgoraErrorCodeAdmGeneralError = 1005,
    /** 1006: Audio Device Module: An error occurs in using the Java resources. */
    AgoraErrorCodeAdmJavaResource = 1006,
    /** 1007: Audio Device Module: An error occurs in setting the sampling frequency. */
    AgoraErrorCodeAdmSampleRate = 1007,
    /** 1008: Audio Device Module: An error occurs in initializing the playback device. */
    AgoraErrorCodeAdmInitPlayout = 1008,
    /** 1009: Audio Device Module: An error occurs in starting the playback device. */
    AgoraErrorCodeAdmStartPlayout = 1009,
    /** 1010: Audio Device Module: An error occurs in stopping the playback device. */
    AgoraErrorCodeAdmStopPlayout = 1010,
    /** 1011: Audio Device Module: An error occurs in initializing the recording device. */
    AgoraErrorCodeAdmInitRecording = 1011,
    /** 1012: Audio Device Module: An error occurs in starting the recording device. */
    AgoraErrorCodeAdmStartRecording = 1012,
    /** 1013: Audio Device Module: An error occurs in stopping the recording device. */
    AgoraErrorCodeAdmStopRecording = 1013,
    /** 1015: Audio Device Module: A playback error occurs. Check your playback device, or try rejoining the channel. */
    AgoraErrorCodeAdmRuntimePlayoutError = 1015,
    /** 1017: Audio Device Module: A recording error occurs. */
    AgoraErrorCodeAdmRuntimeRecordingError = 1017,
    /** 1018: Audio Device Module: Fails to record. */
    AgoraErrorCodeAdmRecordAudioFailed = 1018,
    /** 1020: Audio Device Module: Abnormal audio playback frequency. */
    AgoraErrorCodeAdmPlayAbnormalFrequency = 1020,
    /** 1021: Audio Device Module: Abnormal audio recording frequency. */
    AgoraErrorCodeAdmRecordAbnormalFrequency = 1021,
    /** 1022: Audio Device Module: An error occurs in initializing the loopback device. */
    AgoraErrorCodeAdmInitLoopback  = 1022,
    /** 1023: Audio Device Module: An error occurs in starting the loopback device. */
    AgoraErrorCodeAdmStartLoopback = 1023,
    /** 1359: No recording device exists. */
    AgoraErrorCodeAdmNoRecordingDevice = 1359,
    /** 1360: No playback device exists. */
    AgoraErrorCodeAdmNoPlayoutDevice = 1360,
    /** 1501: Video Device Module: The camera is unauthorized. */
    AgoraErrorCodeVdmCameraNotAuthorized = 1501,
    /** 1600: Video Device Module: An unknown error occurs. */
    AgoraErrorCodeVcmUnknownError = 1600,
    /** 1601: Video Device Module: An error occurs in initializing the video encoder. */
    AgoraErrorCodeVcmEncoderInitError = 1601,
    /** 1602: Video Device Module: An error occurs in video encoding. */
    AgoraErrorCodeVcmEncoderEncodeError = 1602,
    /** @deprecated
     * 1603: Video Device Module: An error occurs in setting the video encoder.
     */
    AgoraErrorCodeVcmEncoderSetError = 1603,
};

/** @deprecated
 Video Profile */
typedef NS_ENUM(NSInteger, AgoraVideoProfile) {
    /** Invalid profile */
    AgoraVideoProfileInvalid = -1,
    /** 160 x 120  @ 15 fps */
    AgoraVideoProfileLandscape120P = 0,
    /** 120 x 120 @ 15 fps */
    AgoraVideoProfileLandscape120P_3 = 2, // iOS
    /** 320 x 180 @ 15 fps */
    AgoraVideoProfileLandscape180P = 10, // iOS
    /** 180 x 180  @ 15 fps */
    AgoraVideoProfileLandscape180P_3 = 12, // iOS
    /** 240 x 180 @ 15 fps */
    AgoraVideoProfileLandscape180P_4 = 13, // iOS
    /** 320 x 240 @ 15 fps */
    AgoraVideoProfileLandscape240P = 20,
    /** 240 x 240 @ 15 fps */
    AgoraVideoProfileLandscape240P_3 = 22, //iOS
    /** 424 x 240 @ 15 fps */
    AgoraVideoProfileLandscape240P_4 = 23, // iOS
    /** 640 x 360 @ 15 fps */
    AgoraVideoProfileLandscape360P = 30,
    /** 360 x 360 @ 15 fps */
    AgoraVideoProfileLandscape360P_3 = 32, // iOS
    /** 640 x 360 @ 30 fps */
    AgoraVideoProfileLandscape360P_4 = 33,
    /** 360 x 360 @ 30 fps */
    AgoraVideoProfileLandscape360P_6 = 35,
    /** 480 x 360 @ 15 fps */
    AgoraVideoProfileLandscape360P_7 = 36,
    /** 480 x 360 @ 30 fps */
    AgoraVideoProfileLandscape360P_8 = 37,
    /** 640 x 360 @ 15 fps */
    AgoraVideoProfileLandscape360P_9 = 38,
    /** 640 x 360 @ 24 fps */
    AgoraVideoProfileLandscape360P_10 = 39,
    /** 640 x 360 @ 24 fps */
    AgoraVideoProfileLandscape360P_11 = 100,
    /** 640 x 480 @ 15 fps */
    AgoraVideoProfileLandscape480P = 40,
    /** 480 x 480 @ 15 fps */
    AgoraVideoProfileLandscape480P_3 = 42, // iOS
    /** 640 x 480 @ 30 fps */
    AgoraVideoProfileLandscape480P_4 = 43,
     /** 480 x 480 @ 30 fps */
    AgoraVideoProfileLandscape480P_6 = 45,
    /** 848 x 480 @ 15 fps */
    AgoraVideoProfileLandscape480P_8 = 47,
    /** 848 x 480 @ 30 fps */
    AgoraVideoProfileLandscape480P_9 = 48,
    /** 640 x 480 @ 10 fps */
    AgoraVideoProfileLandscape480P_10 = 49,
    /** 1280 x 720 @ 15 fps */
    AgoraVideoProfileLandscape720P = 50,
    /** 1280 x 720 @ 30 fps */
    AgoraVideoProfileLandscape720P_3 = 52,
    /** 960 x 720 @ 15 fps */
    AgoraVideoProfileLandscape720P_5 = 54,
    /** 960 x 720 @ 30 fps */
    AgoraVideoProfileLandscape720P_6 = 55,
    /** 1920 x 1080 @ 15 fps */
    AgoraVideoProfileLandscape1080P = 60,
    /** 1920 x 1080 @ 30 fps */
    AgoraVideoProfileLandscape1080P_3 = 62,
    /** 1920 x 1080 @ 60 fps */
    AgoraVideoProfileLandscape1080P_5 = 64,
    /** 2560 x 1440 @ 30 fps */
    AgoraVideoProfileLandscape1440P = 66,
    /** 2560 x 1440 @ 60 fps */
    AgoraVideoProfileLandscape1440P_2 = 67,
    /** 3840 x 2160 @ 30 fps */
    AgoraVideoProfileLandscape4K = 70,
    /** 3840 x 2160 @ 60 fps */
    AgoraVideoProfileLandscape4K_3 = 72,
    /** 120 x 160 @ 15 fps */
    AgoraVideoProfilePortrait120P = 1000,
    /** 120 x 120 @ 15 fps */
    AgoraVideoProfilePortrait120P_3 = 1002, //iOS
    /** 180 x 320 @ 15 fps */
    AgoraVideoProfilePortrait180P = 1010, // iOS
    /** 180 x 180 @ 15 fps */
    AgoraVideoProfilePortrait180P_3 = 1012, // iOS
    /** 180 x 240 @ 15 fps */
    AgoraVideoProfilePortrait180P_4 = 1013, // iOS
    /** 240 x 320 @ 15 fps */
    AgoraVideoProfilePortrait240P = 1020,
    /** 240 x 240 @ 15 fps */
    AgoraVideoProfilePortrait240P_3 = 1022, // iOS
    /** 240 x 424 @ 15 fps */
    AgoraVideoProfilePortrait240P_4 = 1023,
    /** 360 x 640 @ 15 fps */
    AgoraVideoProfilePortrait360P = 1030, // iOS
    /** 360 x 360 @ 15 fps */
    AgoraVideoProfilePortrait360P_3 = 1032, // iOS
    /** 360 x 640 @ 30 fps */
    AgoraVideoProfilePortrait360P_4 = 1033,
    /** 360 x 360 @ 30 fps */
    AgoraVideoProfilePortrait360P_6 = 1035,
    /** 360 x 480 @ 15 fps */
    AgoraVideoProfilePortrait360P_7 = 1036,
    /** 360 x 480 @ 30 fps */
    AgoraVideoProfilePortrait360P_8 = 1037,
    /** 360 x 640 @ 15 fps */
    AgoraVideoProfilePortrait360P_9 = 1038,
    /** 360 x 640 @ 24 fps */
    AgoraVideoProfilePortrait360P_10 = 1039,
    /** 360 x 640 @ 24 fps */
    AgoraVideoProfilePortrait360P_11 = 1100,
    /** 480 x 640 @ 15 fps */
    AgoraVideoProfilePortrait480P = 1040,
    /** 480 x 480 @ 15 fps */
    AgoraVideoProfilePortrait480P_3 = 1042, // iOS
    /** 480 x 640 @ 30 fps */
    AgoraVideoProfilePortrait480P_4 = 1043,
    /** 480 x 480 @ 30 fps */
    AgoraVideoProfilePortrait480P_6 = 1045,
    /** 480 x 848 @ 15 fps */
    AgoraVideoProfilePortrait480P_8 = 1047,
    /** 480 x 848 @ 30 fps */
    AgoraVideoProfilePortrait480P_9 = 1048,
    /** 480 x 640 @ 10 fps */
    AgoraVideoProfilePortrait480P_10 = 1049,
    /** 720 x 1280 @ 15 fps */
    AgoraVideoProfilePortrait720P = 1050,
    /** 720 x 1280 @ 30 fps */
    AgoraVideoProfilePortrait720P_3 = 1052,
    /** 720 x 960 @ 15 fps */
    AgoraVideoProfilePortrait720P_5 = 1054,
     /** 720 x 960 @ 30 fps */
    AgoraVideoProfilePortrait720P_6 = 1055,
    /** 1080 x 1920 @ 15 fps */
    AgoraVideoProfilePortrait1080P = 1060, // macOS
    /** 1080 x 1920 @ 30 fps */
    AgoraVideoProfilePortrait1080P_3 = 1062, // macOS
    /** 1080 x 1920 @ 60 fps */
    AgoraVideoProfilePortrait1080P_5 = 1064, // macOS
    /** 1440 x 2560 @ 30 fps */
    AgoraVideoProfilePortrait1440P = 1066, // macOS
    /** 1440 x 2560 @ 60 fps */
    AgoraVideoProfilePortrait1440P_2 = 1067, // macOS
    /** 2160 x 3840 @ 30 fps */
    AgoraVideoProfilePortrait4K = 1070, // macOS
    /** 2160 x 3840 @ 60 fps */
    AgoraVideoProfilePortrait4K_3 = 1072, // macOS
    /** Default 640 x 360 @ 15 fps */
    AgoraVideoProfileDEFAULT = AgoraVideoProfileLandscape360P,
};

typedef NS_ENUM(NSInteger, AgoraVideoCodecType) {
  AgoraVideoCodecTypeVP8 = 1,
  AgoraVideoCodecTypeH264 = 2,
  AgoraVideoCodecTypeH265 = 3,
  AgoraVideoCodecTypeVP9 = 5,
  AgoraVideoCodecTypeGeneric = 6,
  AgoraVideoCodecTypeGenericH264 = 7,
  AgoraVideoCodecTypeGenericJpeg = 20,
};

typedef NS_ENUM(NSInteger, AgoraVideoFrameOrientation) {
  AgoraVideoFrameOrientation0 = 0,
  AgoraVideoFrameOrientation90 = 90,
  AgoraVideoFrameOrientation180 = 180,
  AgoraVideoFrameOrientation270 = 270,
};

/** Video frame rate */
typedef NS_ENUM(NSInteger, AgoraVideoFrameRate) {
    /** 1 fps */
    AgoraVideoFrameRateFps1 = 1,
    /** 7 fps */
    AgoraVideoFrameRateFps7 = 7,
    /** 10 fps */
    AgoraVideoFrameRateFps10 = 10,
    /** 15 fps */
    AgoraVideoFrameRateFps15 = 15,
    /** 24 fps */
    AgoraVideoFrameRateFps24 = 24,
    /** 30 fps */
    AgoraVideoFrameRateFps30 = 30,
    /** 60 fps */
    AgoraVideoFrameRateFps60 = 60,
};

/** Video output orientation mode

  Note: When a custom video source is used, if you set AgoraVideoOutputOrientationMode as AgoraVideoOutputOrientationModeFixedLandscape(1) or AgoraVideoOutputOrientationModeFixedPortrait(2), when the rotated video image has a different orientation than the specified output orientation, the video encoder will first crop it and then encode it.
 */
typedef NS_ENUM(NSInteger, AgoraVideoOutputOrientationMode) {
    /** Adaptive mode (Default).

     The video encoder adapts to the orientation mode of the video input device.

     - If the width of the captured video from the SDK is larger than the height, the video sent out by the encoder is in landscape mode. The encoder also sends out the rotational information of the video, and the receiving end will rotate the received video based on the rotational information.
     - When a custom video source is used, the output video from the encoder inherits the orientation of the original video. If the original video is in  portrait mode, the output video from the encoder is also in portrait mode. The encoder also sends out the rotational information of the video to the receiver.
     */
    AgoraVideoOutputOrientationModeAdaptative = 0,
    /** Landscape mode.

     The video encoder always sends out the video in landscape mode. The original video is rotated before being sent out and the rotational information is therefore 0. This mode applies to scenarios involving CDN streaming.
     */
    AgoraVideoOutputOrientationModeFixedLandscape = 1,
     /** Portrait mode.

      The video encoder always sends out the video in portrait mode. The original video is rotated before being sent out and the rotational information is therefore 0. This mode applies to scenarios involving CDN streaming.
      */
    AgoraVideoOutputOrientationModeFixedPortrait = 2,
};

/**
 * The channel profile.
 */
typedef NS_ENUM(NSInteger, AgoraChannelProfile) {
    /**
     * 0: Communication.
     *
     * This profile prioritizes smoothness and applies to the one-to-one scenario.
     */
    AgoraChannelProfileCommunication = 0,
    /**
     * 1: (Default) Live Broadcast.
     *
     * This profile prioritizes supporting a large audience in a live broadcast channel.
     */
    AgoraChannelProfileLiveBroadcasting = 1,
    /**
     * @deprecated
     * 2: Gaming.
     *
     */
    AgoraChannelProfileGame = 2,
    /**
     * 3: Cloud Gaming.
     *
     * This profile prioritizes low end-to-end latency and applies to scenarios where users interact
     * with each other, and any delay affects the user experience.
     */
    AgoraChannelProfileCloudGaming = 3,

    /**
     * 4： 1-to-1 communication.
     */
    AgoraChannelProfileCommunication_1v1 = 4,

    /**
     * 5: Live Broadcast 2.
     *
     * This profile technical preview.
     */
    AgoraChannelProfileLiveBroadcasting_2 = 5,
};

/** Client role. */
typedef NS_ENUM(NSInteger, AgoraClientRole) {
    /** Broadcaster */
    AgoraClientRoleBroadcaster = 1,
    /** Audience */
    AgoraClientRoleAudience = 2,
};

/** Audience latency levels in broadcaster mode. */
typedef NS_ENUM(NSInteger, AgoraAudienceLatencyLevelType) {
    /** 1: Low latency. A low latency audience's jitter buffer is 1.2 second. */
    AgoraAudienceLatencyLevelLowLatency = 1,
    /** 2: Default Ultra low latency. An ultra low latency audience's jitter buffer is 0.5 second. */
    AgoraAudienceLatencyLevelUltraLowLatency = 2,
};

/** Media type */
typedef NS_ENUM(NSInteger, AgoraMediaType) {
    /** No audio and video */
    AgoraMediaTypeNone = 0,
    /** Audio only */
    AgoraMediaTypeAudioOnly = 1,
    /** Video only */
    AgoraMediaTypeVideoOnly = 2,
    /** Audio and video */
    AgoraMediaTypeAudioAndVideo = 3,
};


/** Encryption mode */
typedef NS_ENUM(NSInteger, AgoraEncryptionMode) {
    /** 128-bit AES encryption, XTS mode. */
    AgoraEncryptionModeAES128XTS = 1,
    /** 128-bit AES encryption, ECB mode. */
    AgoraEncryptionModeAES128ECB = 2,
    /** 256-bit AES encryption, XTS mode. */
    AgoraEncryptionModeAES256XTS = 3,
    /** 128-bit SM4 encryption, ECB mode. */
    AgoraEncryptionModeSM4128ECB = 4,
    /** 128-bit AES encryption, GCM mode. */
    AgoraEncryptionModeAES128GCM = 5,
    /** 256-bit AES encryption, GCM mode. */
    AgoraEncryptionModeAES256GCM = 6,
    /** 128-bit AES encryption, GCM mode, with KDF salt */
    AgoraEncryptionModeAES128GCM2 = 7,
    /** 256-bit AES encryption, GCM mode, with KDF salt */
    AgoraEncryptionModeAES256GCM2 = 8,
    /** Enumerator boundary */
    AgoraEncryptionModeEnd,
};

/** Reason for the user being offline */
typedef NS_ENUM(NSUInteger, AgoraUserOfflineReason) {
    /** A user has quit the call. */
    AgoraUserOfflineReasonQuit = 0,
    /** The SDK timed out and the user dropped offline because it has not received any data package within a certain period of time. If a user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the event has timed out. */
    AgoraUserOfflineReasonDropped = 1,
    /** User switched to an audience */
    AgoraUserOfflineReasonBecomeAudience = 2,
};

/** Status of importing an external video stream in a live broadcast */
typedef NS_ENUM(NSUInteger, AgoraInjectStreamStatus) {
    /** The external video stream imported successfully. */
    AgoraInjectStreamStatusStartSuccess = 0,
    /** The external video stream already exists. */
    AgoraInjectStreamStatusStartAlreadyExists = 1,
    /** The external video stream import is unauthorized */
    AgoraInjectStreamStatusStartUnauthorized = 2,
    /** Import external video stream timeout. */
    AgoraInjectStreamStatusStartTimedout = 3,
    /** The external video stream failed to import. */
    AgoraInjectStreamStatusStartFailed = 4,
    /** The xternal video stream imports successfully. */
    AgoraInjectStreamStatusStopSuccess = 5,
    /** No external video stream is found. */
    AgoraInjectStreamStatusStopNotFound = 6,
    /** The external video stream is stopped from being unauthorized. */
    AgoraInjectStreamStatusStopUnauthorized = 7,
    /** Importing the external video stream timeout. */
    AgoraInjectStreamStatusStopTimedout = 8,
    /** Importing the external video stream failed. */
    AgoraInjectStreamStatusStopFailed = 9,
    /** The external video stream is broken. */
    AgoraInjectStreamStatusBroken = 10,
};

/** Output log filter level */
typedef NS_ENUM(NSUInteger, AgoraLogFilter) {
    /** Do not output any log information. */
    AgoraLogFilterOff = 0,
    /** Output all API log information */
    AgoraLogFilterDebug = 0x080f,
    /** Output CRITICAL, ERROR, WARNING, and INFO level log information. */
    AgoraLogFilterInfo = 0x000f,
    /** Outputs CRITICAL, ERROR, and WARNING level log information. */
    AgoraLogFilterWarning = 0x000e,
    /** Outputs CRITICAL and ERROR level log information */
    AgoraLogFilterError = 0x000c,
    /** Outputs CRITICAL level log information. */
    AgoraLogFilterCritical = 0x0008,
};

/** Audio recording quality */
typedef NS_ENUM(NSInteger, AgoraAudioRecordingQuality) {
   /** Low quality, file size around 1.2 MB after 10 minutes of recording. */
    AgoraAudioRecordingQualityLow = 0,
    /** Medium quality, file size around 2 MB after 10 minutes of recording. */
    AgoraAudioRecordingQualityMedium = 1,
    /** High quality, file size around 3.75 MB after 10 minutes of recording. */
    AgoraAudioRecordingQualityHigh = 2,
};

/** The audio file record type. */
typedef NS_ENUM(NSInteger, AgoraAudioFileRecordingType) {
    /** mic audio file recording. */
    AgoraAudioFileRecordingTypeMic = 1,
    /** playback audio file recording. */
    AgoraAudioFileRecordingTypePlayback = 2,
    /** mixed audio file recording. */
    AgoraAudioFileRecordingTypeMixed = 3,
};

/** The encoded audio frame observer position. */
typedef NS_ENUM(NSInteger, AgoraAudioEncodedFrameDelegatePosition) {
    /** mic audio file recording. */
    AgoraAudioEncodedFrameObserverPositionRecord = 1,
    /** playback audio file recording. */
    AgoraAudioEncodedFrameObserverPositionPlayback = 2,
    /** mixed audio file recording. */
    AgoraAudioEncodedFrameObserverPositionMixed = 3,
};

/** The codec type of audio */
typedef NS_ENUM(NSInteger, AgoraAudioCodecType) {
  AgoraAudioCodecTypeOPUS = 1,
  AgoraAudioCodecTypeAACLC = 8,
  AgoraAudioCodecTypeHEAAC = 9,
  AgoraAudioCodecTypeHEAAC2 = 11,
};
/** the audio encoding type of audio encoded frame delegate */
typedef NS_ENUM(NSInteger, AgoraAudioEncodingType) {
    /** codecType AAC; sampleRate 16000; quality low which around 1.2 MB after 10 minutes */
    AgoraAudioEncodingTypeAAC16000Low = 0x010101,
    /** codecType AAC; sampleRate 16000; quality medium which around 2 MB after 10 minutes */
    AgoraAudioEncodingTypeAAC16000Medium = 0x010102,
    /** codecType AAC; sampleRate 32000; quality low which around 1.2 MB after 10 minutes */
    AgoraAudioEncodingTypeAAC32000Low = 0x010201,
    /** codecType AAC; sampleRate 32000; quality medium which around 2 MB after 10 minutes */
    AgoraAudioEncodingTypeAAC32000Medium = 0x010202,
    /** codecType AAC; sampleRate 32000; quality high which around 3.5 MB after 10 minutes */
    AgoraAudioEncodingTypeAAC32000High = 0x010203,
    /** codecType AAC; sampleRate 48000; quality medium which around 2 MB after 10 minutes */
    AgoraAudioEncodingTypeAAC48000Medium = 0x010302,
    /** codecType AAC; sampleRate 48000; quality high which around 3.5 MB after 10 minutes */
    AgoraAudioEncodingTypeAAC48000High = 0x010303,
    /** codecType OPUS; sampleRate 16000; quality low which around 1.2 MB after 10 minutes */
    AgoraAudioEncodingTypeOPUS16000Low = 0x020101,
    /** codecType OPUS; sampleRate 16000; quality medium which around 2 MB after 10 minutes */
    AgoraAudioEncodingTypeOPUS6000Medium = 0x020102,
    /** codecType OPUS; sampleRate 48000; quality medium which around 2 MB after 10 minutes */
    AgoraAudioEncodingTypeOPUS48000Medium = 0x020302,
    /** codecType OPUS; sampleRate 48000; quality high which around 3.5 MB after 10 minutes */
    AgoraAudioEncodingTypeOPUS48000High = 0x020303,
};

/** Video stream lifecyle of CDN Live.                                                                                                   */
typedef NS_ENUM(NSInteger, AgoraRtmpStreamLifeCycle) {
    /** Bound to the channel lifecycle. */
    AgoraRtmpStreamLifeCycleBindToChannel = 1,
    /** Bound to the owner of the RTMP stream. */
    AgoraRtmpStreamLifeCycleBindToOwner = 2,
};

/** Network quality */
typedef NS_ENUM(NSUInteger, AgoraNetworkQuality) {
    /** The network quality is unknown. */
    AgoraNetworkQualityUnknown = 0,
    /**  The network quality is excellent. */
    AgoraNetworkQualityExcellent = 1,
    /** The network quality is quite good, but the bitrate may be slightly lower than excellent. */
    AgoraNetworkQualityGood = 2,
    /** Users can feel the communication slightly impaired. */
    AgoraNetworkQualityPoor = 3,
    /** Users can communicate only not very smoothly. */
    AgoraNetworkQualityBad = 4,
     /** The network is so bad that users can hardly communicate. */
    AgoraNetworkQualityVBad = 5,
     /** The network is down  and users cannot communicate at all. */
    AgoraNetworkQualityDown = 6,
    /** Users cannot detect the network quality. (Not in use.) */
    AgoraNetworkQualityUnsupported = 7,
    /** Detecting the network quality. */
    AgoraNetworkQualityDetecting = 8,
};

/**
 * The state of the probe test.
 */
typedef NS_ENUM(NSUInteger, AgoraLastmileProbeResultState) {
  /**
   * 1: The last-mile network probe test is complete.
   */
  AgoraLastmileProbeResultComplete = 1,
  /**
   * 2: The last-mile network probe test is incomplete and the bandwidth estimation is not available, probably due to limited test resources.
   */
  AgoraLastmileProbeResultIncompleteNoBwe = 2,
  /**
   * 3: The last-mile network probe test is not carried out, probably due to poor network conditions.
   */
  AgoraLastmileProbeResultUnavailable = 3,
};

typedef NS_ENUM(NSInteger, AgoraUploadErrorReason) {
    AgoraUploadErrorReasonSuccess = 0,
    AgoraUploadErrorReasonNetError = 1,
    AgoraUploadErrorReasonServerError = 2,
};

/** Video stream type */
typedef NS_ENUM(NSInteger, AgoraVideoStreamType) {
    /** High-video stream */
    AgoraVideoStreamTypeHigh = 0,
    /** Low-video stream */
    AgoraVideoStreamTypeLow = 1,
};

/**  Quality change of the local video in terms of target frame rate and target bit rate since last count. */
typedef NS_ENUM(NSInteger, AgoraVideoQualityAdaptIndication) {
  /** The quality of the local video stays the same. */
  AgoraVideoQualityAdaptNone = 0,
  /** The quality improves because the network bandwidth increases. */
  AgoraVideoQualityAdaptUpBandwidth = 1,
  /** The quality worsens because the network bandwidth decreases. */
  AgoraVideoQualityAdaptDownBandwidth = 2,
} NS_SWIFT_NAME(AgoraVideoQualityAdaptIndication);

/** Video display mode */
typedef NS_ENUM(NSUInteger, AgoraVideoRenderMode) {
    /** Hidden(1): Uniformly scale the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents. */
    AgoraVideoRenderModeHidden = 1,

    /** Fit(2): Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be filled with black. */
    AgoraVideoRenderModeFit = 2,

    /** @deprecated
     Adaptive(3)：This mode is obsolete.
     */
    AgoraVideoRenderModeAdaptive __deprecated_enum_msg("AgoraVideoRenderModeAdaptive is deprecated.") = 3,
};

/** Video codec profile type */
typedef NS_ENUM(NSInteger, AgoraVideoCodecProfileType) {
    /** Baseline video codec profile */
    AgoraVideoCodecProfileTypeBaseLine = 66,
    /** Main video codec profile */
    AgoraVideoCodecProfileTypeMain = 77,
    /** High Video codec profile (default) */
    AgoraVideoCodecProfileTypeHigh = 100
};

/** Video mirror mode */
typedef NS_ENUM(NSUInteger, AgoraVideoMirrorMode) {
    /**
     * 0: The default mirror mode (the SDK determines the mirror mode).
     */
    AgoraVideoMirrorModeAuto = 0,
    /**
     * 1: Enable the mirror mode.
     */
    AgoraVideoMirrorModeEnabled = 1,
    /**
     * 2: Disable the mirror mode.
     */
    AgoraVideoMirrorModeDisabled = 2,
};

/** States of the local video. */
typedef NS_ENUM(NSUInteger, AgoraVideoLocalState) {
  /**
   * 0: The local video is in the initial state.
   */
  AgoraVideoLocalStateStopped = 0,
  /**
   * 1: The capturer starts successfully.
   */
  AgoraVideoLocalStateCapturing = 1,
  /**
   * 2: The first video frame is encoded successfully.
   */
  AgoraVideoLocalStateEncoding = 2,
  /**
   * 3: The local video fails to start.
   */
  AgoraVideoLocalStateFailed = 3
};

/** States of the local video. */
typedef NS_ENUM(NSUInteger, AgoraLocalVideoStreamError) {
  /**
   * 0: The local video is normal.
  */
  AgoraLocalVideoStreamErrorOK = 0,
  /**
   * 1: No specified reason for the local video failure.
  */
  AgoraLocalVideoStreamErrorFailure = 1,
  /**
   * 2: No permission to use the local video device.
   */
  AgoraLocalVideoStreamErrorDeviceNoPermission = 2,
  /**
   * 3: The local video capturer is in use.
   */
  AgoraLocalVideoStreamErrorDeviceBusy = 3,
  /**
   * 4: The local video capture fails. Check whether the capturer is working properly.
   */
  AgoraLocalVideoStreamErrorCaptureFailure = 4,
  /**
   * 5: The local video encoding fails.
   */
  AgoraLocalVideoStreamErrorEncodeFailure = 5,
  /**
   * 6: The local video capturing device not avalible due to app did enter background.
   */
  AgoraLocalVideoStreamErrorBackgroud = 6,
  /**
   * 7: The local video capturing device not avalible because the app is running in a multi-app layout (generally on the pad)
   */
  AgoraLocalVideoStreamErrorMultipleForegroundApps = 7,
  /**
   * 8: The local video capturing device  temporarily being made unavailable due to system pressure.
   */
  AgoraLocalVideoStreamErrorSystemPressure = 8
};

/** The state of the remote video. */
typedef NS_ENUM(NSUInteger, AgoraVideoRemoteState) {
    /** 0: The remote video is in the default state, probably due to `AgoraVideoRemoteStateReasonLocalMuted(3)`, `AgoraVideoRemoteStateReasonRemoteMuted(5)`, or `AgoraVideoRemoteStateReasonRemoteOffline(7)`. */
    AgoraVideoRemoteStateStopped = 0,
    /** 1: The first remote video packet is received. */
    AgoraVideoRemoteStateStarting = 1,
    /** 2: The remote video stream is decoded and plays normally, probably due to `AgoraVideoRemoteStateReasonNetworkRecovery(2)`, `AgoraVideoRemoteStateReasonLocalUnmuted(4)`, `AgoraVideoRemoteStateReasonRemoteUnmuted(6)`, or `AgoraVideoRemoteStateReasonAudioFallbackRecovery(9)`. */
    AgoraVideoRemoteStateDecoding = 2,
    /** 3: The remote video is frozen, probably due to `AgoraVideoRemoteStateReasonNetworkCongestion(1)` or `AgoraVideoRemoteStateReasonAudioFallback(8)`. */
    AgoraVideoRemoteStateFrozen = 3,
    /** 4: The remote video fails to start, probably due to `AgoraVideoRemoteStateReasonInternal(0)`. */
    AgoraVideoRemoteStateFailed = 4,
};

/**
 * The reason of the remote video state change.
 */
typedef NS_ENUM(NSUInteger, AgoraVideoRemoteReason) {
      /**
      * 0: Internal reasons.
      */
      AgoraVideoRemoteReasonInternal = 0,

      /**
      * 1: Network congestion.
      */
      AgoraVideoRemoteReasonCongestion = 1,

      /**
      * 2: Network recovery.
      */
      AgoraVideoRemoteReasonRecovery = 2,

      /**
      * 3: The local user stops receiving the remote video stream or disables the video module.
      */
      AgoraVideoRemoteReasonLocalMuted = 3,

      /**
      * 4: The local user resumes receiving the remote video stream or enables the video module.
      */
      AgoraVideoRemoteReasonLocalUnmuted = 4,

      /**
      * 5: The remote user stops sending the video stream or disables the video module.
      */
      AgoraVideoRemoteReasonRemoteMuted = 5,

      /**
      * 6: The remote user resumes sending the video stream or enables the video module.
      */
      AgoraVideoRemoteReasonRemoteUnmuted = 6,

      /**
      * 7: The remote user leaves the channel.
      */
      AgoraVideoRemoteReasonRemoteOffline = 7,

      /**
      * 8: The remote media stream falls back to the audio-only stream due to poor network conditions.
      */
      AgoraVideoRemoteReasonAudioFallback = 8,

      /**
      * 9: The remote media stream switches back to the video stream after the network conditions improve.
      */
      AgoraVideoRemoteReasonAudioFallbackRecovery = 9
};

/**
 * The state of the local audio.
 */
typedef NS_ENUM(NSUInteger, AgoraAudioLocalState) {
    /**
     * 0: The local audio is in the initial state.
     */
    AgoraAudioLocalStateStopped = 0,
    /**
     * 1: The recording device starts successfully.
     */
    AgoraAudioLocalStateRecording = 1,
    /**
     * 2: The first audio frame encodes successfully.
     */
    AgoraAudioLocalStateEncoding = 2,
    /**
     * 3: The local audio fails to start.
     */
    AgoraAudioLocalStateFailed = 3,
};

/**
 * The error information of the local audio.
 */
typedef NS_ENUM(NSUInteger, AgoraAudioLocalError) {
    /**
     * 0: No error.
     */
    AgoraAudioLocalErrorOK = 0,
    /**
     * 1: No specified reason for the local audio failure.
     */
    AgoraAudioLocalErrorFailure = 1,
    /**
     * 2: No permission to use the local audio device.
     */
    AgoraAudioLocalErrorDeviceNoPermission = 2,
    /**
     * 3: The microphone is in use.
     */
    AgoraAudioLocalErrorDeviceBusy = 3,
    /**
     * 4: The local audio recording fails. Check whether the recording device is working properly.
     */
    AgoraAudioLocalErrorRecordFailure = 4,
    /**
     * 5: The local audio encoding fails.
     */
    AgoraAudioLocalErrorEncodeFailure = 5,
};

/** Audio codec profile. */
typedef NS_ENUM(NSInteger, AgoraAudioCodecProfileType) {
    /** (Default) LC-AAC, the low-complexity audio codec profile. */
  AgoraAudioCodecProfileLCAAC = 0,
  /** HE-AAC, the high-efficiency audio codec profile. */
  AgoraAudioCodecProfileHEAAC = 1
};

/**
 * The state of the remote audio.
 */
typedef NS_ENUM(NSUInteger, AgoraAudioRemoteState) {
    /**
     * 0: The remote audio stops (the default state). The following are possible reasons:
     * - {@link AgoraAudioRemoteReasonLocalMuted}(3)
     * - {@link AgoraAudioRemoteReasonRemoteMuted}(5)
     * - {@link AgoraAudioRemoteReasonRemoteOffline}(7)
     */
    AgoraAudioRemoteStateStopped = 0,
    /**
     * 1: The first remote audio packet is received.
     */
    AgoraAudioRemoteStateStarting = 1,
    /**
     * 2: The remote audio stream is decoded and plays normally. The following are possible reasons:
     * - {@link AgoraAudioRemoteReasonNetworkRecovery}(2)
     * - {@link AgoraAudioRemoteReasonLocalUnmuted}(4)
     * - {@link AgoraAudioRemoteReasonRemoteUnmuted}(6)
     */
    AgoraAudioRemoteStateDecoding = 2,
    /**
     * 3: The remote audio is frozen. The possible reason is {@link AgoraAudioRemoteReasonNetworkCongestion}(1).
     */
    AgoraAudioRemoteStateFrozen = 3,
    /**
     * 4: The remote audio fails to start. The possible reason is {@link AgoraAudioRemoteReasonInternal}(0).
     */
    AgoraAudioRemoteStateFailed = 4,
};

/**
 * The reason of the remote audio state change.
 */
typedef NS_ENUM(NSUInteger, AgoraAudioRemoteReason) {
      /**
       * 0: Internal reasons.
       */
      AgoraAudioRemoteReasonInternal = 0,
      /**
       * 1: Network congestion.
       */
      AgoraAudioRemoteReasonNetworkCongestion = 1,
      /**
       * 2: Network recovery.
       */
      AgoraAudioRemoteReasonNetworkRecovery = 2,
      /**
       * 3: The local user stops receiving the remote audio stream or disables the audio module.
       */
      AgoraAudioRemoteReasonLocalMuted = 3,
      /**
       * 4: The local user resumes receiving the remote audio stream or enables the audio module.
       */
      AgoraAudioRemoteReasonLocalUnmuted = 4,
      /**
       * 5: The remote user stops sending the audio stream or disables the audio module.
       */
      AgoraAudioRemoteReasonRemoteMuted = 5,
      /**
       * 6: The remote user resumes sending the audio stream or enables the audio module.
       */
      AgoraAudioRemoteReasonRemoteUnmuted = 6,
      /**
       * 7: The remote user leaves the channel.
       */
      AgoraAudioRemoteReasonRemoteOffline = 7,
};

/** Stream fallback option */
typedef NS_ENUM(NSInteger, AgoraStreamFallbackOptions) {
    /** Default option */
    AgoraStreamFallbackOptionDisabled = 0,
    /** Under poor network conditions, the SDK will send or receive AgoraVideoStreamTypeLow. You can only set this option in [setRemoteSubscribeFallbackOption]([AgoraRtcEngineKit setRemoteSubscribeFallbackOption:]). Nothing happens when you set this in  [setLocalPublishFallbackOption]([AgoraRtcEngineKit setLocalPublishFallbackOption:]). */
    AgoraStreamFallbackOptionVideoStreamLow = 1,
    /** Under poor network conditions, the SDK may receive AgoraVideoStreamTypeLow first, but if the network still does not allow displaying the video, the SDK will send or receive audio only. */
    AgoraStreamFallbackOptionAudioOnly = 2,
};

/** Audio sampling rate */
typedef NS_ENUM(NSInteger, AgoraAudioSampleRateType) {
    /** 32 kHz */
    AgoraAudioSampleRateType32000 = 32000,
    /** 44.1 kHz */
    AgoraAudioSampleRateType44100 = 44100,
    /** 48 kHz */
    AgoraAudioSampleRateType48000 = 48000,
};

/**
 * Audio profile types.
 */
typedef NS_ENUM(NSInteger, AgoraAudioProfile) {
  /**
   * 0: The default audio profile.
   * - In the Communication profile, it represents a sample rate of 16 kHz, music encoding, mono, and a bitrate
   * of up to 16 Kbps.
   * - In the Live-broadcast profile, it represents a sample rate of 48 kHz, music encoding, mono, and a bitrate
   * of up to 64 Kbps.
   */
    AgoraAudioProfileDefault = 0,
    /**
     * 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate up to 18 Kbps.
     */
    AgoraAudioProfileSpeechStandard = 1,
    /**
     * 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
     */
    AgoraAudioProfileMusicStandard = 2,
    /**
     * 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80
     * Kbps.
     */
    AgoraAudioProfileMusicStandardStereo = 3,
    /**
     * 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
     */
    AgoraAudioProfileMusicHighQuality = 4,
    /**
     * 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
     */
    AgoraAudioProfileMusicHighQualityStereo = 5,
    /**
     * 6: A sample rate of 16 kHz, audio encoding, mono, and a bitrate of up to 64 Kbps.
     */
    AgoraAudioProfileIot = 6,
};

/**
 * Audio application scenarios.
 */
typedef NS_ENUM(NSInteger, AgoraAudioScenario) {
    /**
     * 0: (Recommended) The default audio scenario.
     */
    AgoraAudioScenarioDefault = 0,
    /**
     * 3: (Recommended) The live gaming scenario, which needs to enable gaming
     * audio effects in the speaker. Choose this scenario to achieve high-fidelity
     * music playback.
     */
    AgoraAudioScenarioGameStreaming = 3,
    /**
     * 5: The chatroom scenario.
     */
    AgoraAudioScenarioChatRoom = 5,
    /**
     * 6: (Recommended) The scenario requiring high-quality audio.
     */
    AgoraAudioScenarioHighDefinition = 6,
    /** Chorus */
    AgoraAudioScenarioChorus = 7
};

/**
 * The audio output routing.
 */
typedef NS_ENUM(NSInteger, AgoraAudioOutputRouting) {
    /**
     * -1: The default audio route.
     */
    AgoraAudioOutputRoutingDefault = -1,
    /**
     * 0: Headset.
     */
    AgoraAudioOutputRoutingHeadset = 0,
    /**
     * 1: Earpiece.
     */
    AgoraAudioOutputRoutingEarpiece = 1,
    /**
     * 2: Headset with no microphone.
     */
    AgoraAudioOutputRoutingHeadsetNoMic = 2,
    /**
     * 3: Speakerphone.
     */
    AgoraAudioOutputRoutingSpeakerphone = 3,
    /**
     * 4: Loudspeaker.
     */
    AgoraAudioOutputRoutingLoudspeaker = 4,
    /**
     * 5: Bluetooth headset.
     */
    AgoraAudioOutputRoutingHeadsetBluetooth = 5
};

/** Use mode of the onRecordAudioFrame callback */
typedef NS_ENUM(NSInteger, AgoraAudioRawFrameOperationMode) {
    /** Read-only mode: Users only read the AudioFrame data without modifying anything. For example, when users acquire data with the Agora SDK then push the RTMP streams. */
    AgoraAudioRawFrameOperationModeReadOnly = 0,
    /** Write-only mode: Users replace the AudioFrame data with their own data and pass them to the SDK for encoding. For example, when users acquire data. */
    AgoraAudioRawFrameOperationModeWriteOnly = 1,
    /** Read and write mode: Users read the data from AudioFrame, modify it, and then play it. For example, when users have their own sound-effect processing module and do some voice pre-processing such as a voice change. */
    AgoraAudioRawFrameOperationModeReadWrite = 2,
};

/** Audio equalization band frequency */
typedef NS_ENUM(NSInteger, AgoraAudioEqualizationBandFrequency) {
    /** 31 Hz */
    AgoraAudioEqualizationBand31 = 0,
    /** 62 Hz */
    AgoraAudioEqualizationBand62 = 1,
    /** 125 Hz */
    AgoraAudioEqualizationBand125 = 2,
    /** 250 Hz */
    AgoraAudioEqualizationBand250 = 3,
    /** 500 Hz */
    AgoraAudioEqualizationBand500 = 4,
    /** 1 kHz */
    AgoraAudioEqualizationBand1K = 5,
    /** 2 kHz */
    AgoraAudioEqualizationBand2K = 6,
    /** 4 kHz */
    AgoraAudioEqualizationBand4K = 7,
    /** 8 kHz */
    AgoraAudioEqualizationBand8K = 8,
    /** 16 kHz */
    AgoraAudioEqualizationBand16K = 9,
};

/** Audio reverberation type */
typedef NS_ENUM(NSInteger, AgoraAudioReverbType) {
    /** (dB, -20 to 10), the level of the dry signal */
    AgoraAudioReverbDryLevel = 0,
    /** (dB, -20 to 10), the level of the early reflection signal (wet signal) */
    AgoraAudioReverbWetLevel = 1,
    /** (0 to 100), the room size of the reflection */
    AgoraAudioReverbRoomSize = 2,
    /** (ms, 0 to 200), the length of the initial delay of the wet signal in ms */
    AgoraAudioReverbWetDelay = 3,
     /** (0 to 100), the strength of the late reverberation */
    AgoraAudioReverbStrength = 4,
};

/** The preset audio voice configuration used to change the voice effect. */
typedef NS_ENUM(NSInteger, AgoraAudioVoiceChanger) {
    /** The original voice (no local voice change). */
    AgoraAudioVoiceChangerOff = 0x00000000,
    /** The voice of an old man. */
    AgoraAudioVoiceChangerOldMan = 0x02020200,
    /** The voice of a little boy. */
    AgoraAudioVoiceChangerBabyBoy = 0x02020300,
    /** The voice of a little girl. */
    AgoraAudioVoiceChangerBabyGirl = 0x02020500,
    /** The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a growling bear. */
    AgoraAudioVoiceChangerZhuBaJie = 0x02020600,
    /** The ethereal voice. */
    AgoraAudioVoiceChangerEthereal = 0x02010700,
    /** The voice of Hulk. */
    AgoraAudioVoiceChangerHulk = 0x02020700,
    /** A more vigorous voice. */
    AgoraAudioVoiceBeautyVigorous = 0x01030100,
    /** A deeper voice. */
    AgoraAudioVoiceBeautyDeep = 0x01030200,
    /** A mellower voice. */
    AgoraAudioVoiceBeautyMellow = 0x01030300,
    /** Falsetto. */
    AgoraAudioVoiceBeautyFalsetto = 0x01030400,
    /** A fuller voice. */
    AgoraAudioVoiceBeautyFull = 0x01030500,
    /** A clearer voice. */
    AgoraAudioVoiceBeautyClear = 0x01030600,
    /** A more resounding voice. */
    AgoraAudioVoiceBeautyResounding = 0x01030700,
    /** A more ringing voice. */
    AgoraAudioVoiceBeautyRinging = 0x01030800,
    /** A more spatially resonant voice. */
    AgoraAudioVoiceBeautySpacial = 0x02010600,
    /** (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice distortion occurs. */
    AgoraAudioGeneralBeautyVoiceMaleMagnetic = 0x01010100,
    /** (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs. */
    AgoraAudioGeneralBeautyVoiceFemaleFresh = 0x01010200,
    /** (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs. */
    AgoraAudioGeneralBeautyVoiceFemaleVitality = 0x01010300,
};
/** The options for SDK preset voice beautifier effects.*/
typedef NS_ENUM(NSInteger, AgoraVoiceBeautifierPreset) {
  /** Turn off voice beautifier effects and use the original voice.
   */
  AgoraVoiceBeautifierPresetOff = 0x00000000,
  /** A more magnetic voice.
   *
   * @note Agora recommends using this enumerator to process a male-sounding voice; otherwise, you
   * may experience vocal distortion.
   */
  AgoraVoiceBeautifierPresetChatBeautifierMagnetic = 0x01010100,
  /** A fresher voice.
   *
   * @note Agora recommends using this enumerator to process a female-sounding voice; otherwise, you
   * may experience vocal distortion.
   */
  AgoraVoiceBeautifierPresetChatBeautifierFresh = 0x01010200,
  /** A more vital voice.
   *
   * @note Agora recommends using this enumerator to process a female-sounding voice; otherwise, you
   * may experience vocal distortion.
   */
  AgoraVoiceBeautifierPresetChatBeautifierVitality = 0x01010300,
  /**
   * @since v3.3.0
   *
   * Singing beautifier effect.
   * - If you call \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   * (SINGING_BEAUTIFIER), you can beautify a male-sounding voice and add a reverberation effect
   * that sounds like singing in a small room. Agora recommends not using \ref
   * IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset" (SINGING_BEAUTIFIER) to process
   * a female-sounding voice; otherwise, you may experience vocal distortion.
   * - If you call \ref IRtcEngine::setVoiceBeautifierParameters
   * "setVoiceBeautifierParameters"(SINGING_BEAUTIFIER, param1, param2), you can beautify a male- or
   * female-sounding voice and add a reverberation effect.
   */
  AgoraVoiceBeautifierPresetSingingBeautifier= 0x01020100,
  /** A more vigorous voice.
   */
  AgoraVoiceBeautifierTimbreTransformationVigorous = 0x01030100,
  /** A deeper voice.
   */
  AgoraVoiceBeautifierTimbreTransformationDeep = 0x01030200,
  /** A mellower voice.
   */
  AgoraVoiceBeautifierTimbreTransformationMellow= 0x01030300,
  /** A falsetto voice.
   */
  AgoraVoiceBeautifierTimbreTransformationFalsetto= 0x01030400,
  /** A fuller voice.
   */
  AgoraVoiceBeautifierTimbreTransformationFull = 0x01030500,
  /** A clearer voice.
   */
  AgoraVoiceBeautifierTimbreTransformationClear = 0x01030600,
  /** A more resounding voice.
   */
  AgoraVoiceBeautifierTimbreTransformationResounding = 0x01030700,
  /** A more ringing voice.
   */
  AgoraVoiceBeautifierTimbreTransformatRinging= 0x01030800,
    
  AgoraVoiceBeautifierUltraHighQuality = 0x01040100
};

/** The options for SDK preset audio effects.*/
typedef NS_ENUM(NSInteger, AgoraAudioEffectPreset) {
  /** Turn off audio effects and use the original voice.
   */
  AgoraAudioEffectPresetOff = 0x00000000,
  /** An audio effect typical of a KTV venue.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetRoomAcousticsKTV = 0x02010100,
  /** An audio effect typical of a concert hall.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetRoomAcousVocalConcer = 0x02010200,
  /** An audio effect typical of a recording studio.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetRoomAcousStudio = 0x02010300,
  /** An audio effect typical of a vintage phonograph.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetRoomAcousPhonograph = 0x02010400,
  /** A virtual stereo effect that renders monophonic audio as stereo audio.
   *
   * @note Call \ref IRtcEngine::setAudioProfile "setAudioProfile" and set the `profile` parameter
   * to `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * before setting this enumerator; otherwise, the enumerator setting does not take effect.
   */
  AgoraAudioEffectPresetRoomAcousVirtualStereo = 0x02010500,
  /** A more spatial audio effect.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetRoomAcousSpatial = 0x02010600,
  /** A more ethereal audio effect.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetRoomAcousEthereal = 0x02010700,
  /** A 3D voice effect that makes the voice appear to be moving around the user. The default cycle
   * period of the 3D voice effect is 10 seconds. To change the cycle period, call \ref
   * IRtcEngine::setAudioEffectParameters "setAudioEffectParameters" after this method.
   *
   * @note
   * - Call \ref IRtcEngine::setAudioProfile "setAudioProfile" and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator; otherwise, the enumerator setting does not take effect.
   * - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear
   * the anticipated voice effect.
   */
  AgoraAudioEffectPresetRoomAcous3DVoice = 0x02010800,
  /** The voice of an uncle.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetVoiceChangerEffectUncle = 0x02020100,
  /** The voice of an old man.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetVoiceChangerEffectOldMan = 0x02020200,
  /** The voice of a boy.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetVoiceChangerEffectBoy= 0x02020300,
  /** The voice of a young woman.
   *
   * @note
   * - Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetVoiceChangerEffectSister= 0x02020400,
  /** The voice of a girl.
   *
   * @note
   * - Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetVoiceChangerEffectGirl = 0x02020500,
  /** The voice of Pig King, a character in Journey to the West who has a voice like a growling
   * bear.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetVoiceChangerEffectPigKin = 0x02020600,
  /** The voice of Hulk.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetVoiceChangerEffectHulk = 0x02020700,
  /** An audio effect typical of R&B music.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetStyleTransformationRnb = 0x02030100,
  /** An audio effect typical of popular music.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetStyleTransformationPopular= 0x02030200,
  /** A pitch correction effect that corrects the user's pitch based on the pitch of the natural C
   * major scale. To change the basic mode and tonic pitch, call \ref
   * IRtcEngine::setAudioEffectParameters "setAudioEffectParameters" after this method.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  AgoraAudioEffectPresetPitchCorrection = 0x02040100
};

/** The options for SDK preset voice conversion. */
typedef NS_ENUM(NSInteger, AgoraVoiceConversionPreset) {
  /** Turn off voice conversion and use the original voice. */
  AgoraVoiceConversionPresetOff = 0x00000000,
  /** A neutral voice. */
  AgoraVoiceConversionPresetNeutral = 0x03010100,
  /** A sweet voice. */
  AgoraVoiceConversionPresetSweet = 0x03010200,
  /** A solid voice. */
  AgoraVoiceConversionPresetChangerSolid = 0x03010300,
  /** A bass voice. */
  AgoraVoiceConversionPresetChangerBass = 0x03010400
};

/** The preset local voice reverberation option. */
typedef NS_ENUM(NSInteger, AgoraAudioReverbPreset) {
    /** The original voice (no local voice reverberation). */
    AgoraAudioReverbPresetOff = 0x00000000,
    /** The reverberation style typical of a KTV venue (enhanced). */
    AgoraAudioReverbPresetFxKTV = 0x02010100,
    /** The reverberation style typical of a concert hall (enhanced). */
    AgoraAudioReverbPresetFxVocalConcert = 0x02010200,
    /** The reverberation style typical of an uncle's voice. */
    AgoraAudioReverbPresetFxUncle = 0x02020100,
    /** The reverberation style typical of a little sister's voice. */
    AgoraAudioReverbPresetFxSister = 0x02020400,
    /** The reverberation style typical of a recording studio (enhanced). */
    AgoraAudioReverbPresetFxStudio = 0x02010300,
    /** The reverberation style typical of popular music (enhanced). */
    AgoraAudioReverbPresetFxPopular = 0x02030200,
    /** The reverberation style typical of R&B music (enhanced). */
    AgoraAudioReverbPresetFxRNB = 0x02030100,
    /** The reverberation style typical of the vintage phonograph. */
    AgoraAudioReverbPresetFxPhonograph = 0x02010400
};

/** Audio session restriction */
typedef NS_OPTIONS(NSUInteger, AgoraAudioSessionOperationRestriction) {
    /** No restriction, the SDK has full control on the audio session operations. */
    AgoraAudioSessionOperationRestrictionNone              = 0,
    /** The SDK will not change the audio session category */
    AgoraAudioSessionOperationRestrictionSetCategory       = 1,
    /** The SDK will not change any setting of the audio session (category, mode, categoryOptions) */
    AgoraAudioSessionOperationRestrictionConfigureSession  = 1 << 1,
    /** The SDK will keep the audio session active when leaving a channel */
    AgoraAudioSessionOperationRestrictionDeactivateSession = 1 << 2,
    /** The SDK will not configure the audio session anymore */
    AgoraAudioSessionOperationRestrictionAll               = 1 << 7
};

/** Media device type */
typedef NS_ENUM(NSInteger, AgoraMediaDeviceType) {
    /** Unknown device*/
    AgoraMediaDeviceTypeAudioUnknown = -1,
    /** Microphone device */
    AgoraMediaDeviceTypeAudioRecording = 0,
    /** Audio playback device */
    AgoraMediaDeviceTypeAudioPlayout = 1,
    /** Video render device*/
    AgoraMediaDeviceTypeVideoRender = 2,
    /** Video capture device*/
    AgoraMediaDeviceTypeVideoCapture = 3,
};

/** Video frame format */
typedef NS_ENUM(NSInteger, AgoraVideoFormat) {
    /** i420 video frame fromat*/
    AgoraVideoFormatI420 = 1,
    /** BGRA video frame fromat*/
    AgoraVideoFormatBGRA = 2,
    /** NV21 video frame fromat*/
    AgoraVideoFormatNV21 = 3,
    /** RGBA video frame fromat*/
    AgoraVideoFormatRGBA = 4,
    /** NV12 video frame fromat*/
    AgoraVideoFormatNV12 = 8,
    /** iOS texture (CVPixelBufferRef)*/
    AgoraVideoFormatCVPixel = 12,
    /** I422 video frame fromat*/
    AgoraVideoFormatI422 = 16
};

/**
 * Types of the video frame.
 */
typedef NS_ENUM(NSInteger, AgoraVideoFrameType) {
  /** (Default) Blank frame */
  AgoraVideoFrameTypeBlankFrame = 0,
  /** (Default) Key frame */
  AgoraVideoFrameTypeKeyFrame = 3,
  /** (Default) Delta frame */
  AgoraVideoFrameTypeDeltaFrame = 4,
  /** (Default) B frame */
  AgoraVideoFrameTypeBFrame = 5,
  /** (Default) Droppable frame */
  AgoraVideoFrameTypeDroppableFrame = 6,
  /** (Default) Unknown frame type */
  AgoraVideoFrameTypeUnknow
};

typedef NS_ENUM(NSInteger, AgoraVideoFrameProcessMode) {
  AgoraVideoFrameProcessModeReadOnly, // Observer works as a pure renderer and will not modify the original frame.
  AgoraVideoFrameProcessModeReadWrite, // Observer works as a filter that will process the video frame and affect the following frame processing in SDK.
};

/** The connection state of the SDK. */
typedef NS_ENUM(NSInteger, AgoraConnectionState) {
  /**
   * 1: The SDK is disconnected from the edge server.
   */
  AgoraConnectionStateDisconnected = 1,
  /**
   * 2: The SDK is connecting to the edge server.
   */
  AgoraConnectionStateConnecting = 2,
  /**
   * 3: The SDK is connected to the edge server and has joined a channel. You can now publish or subscribe to a media stream in the channel.
   */
  AgoraConnectionStateConnected = 3,
  /**
   * 4: The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.
   */
  AgoraConnectionStateReconnecting = 4,
  /**
   * 5: The SDK fails to connect to the edge server or join the channel.
   */
  AgoraConnectionStateFailed = 5,
};

/** The network type. */
typedef NS_ENUM(NSInteger, AgoraNetworkType) {
  /**
   * -1: The network type is unknown.
   */
  AgoraNetworkTypeUnknown = -1,
  /**
   * 0: The network type is disconnected.
   */
  AgoraNetworkTypeDisconnected = 0,
  /**
   * 1: The network type is LAN.
   */
  AgoraNetworkTypeLAN = 1,
  /**
   * 2: The network type is Wi-Fi.
   */
  AgoraNetworkTypeWIFI = 2,
  /**
   * 3: The network type is mobile 2G.
   */
  AgoraNetworkType2G = 3,
  /**
   * 4: The network type is mobile 3G.
   */
  AgoraNetworkType3G = 4,
  /**
   * 5: The network type is mobile 4G.
   */
  AgoraNetworkType4G = 5,
};

/** The video encoding degradation preference under limited bandwidth. */
typedef NS_ENUM(NSInteger, AgoraDegradationPreference) {
    /** (Default) Degrade the frame rate and keep resolution to guarantee the video quality. */
    AgoraDegradationMaintainQuality = 0,
    /** Degrade resolution in order to maintain framerate. */
    AgoraDegradationMaintainFramerate = 1,
    /** Maintain resolution in video quality control process. Under limited bandwidth, degrade video quality first and then degrade frame rate. */
    AgoraDegradationBalanced = 2,
    /** Degrade framerate in order to maintain resolution. */
    AgoraDegradationMaintainResolution = 3,
};

/** The lightening contrast level. */
typedef NS_ENUM(NSUInteger, AgoraLighteningContrastLevel) {
  /** Low contrast level. */
  AgoraLighteningContrastLow = 0,
  /** (Default) Normal contrast level. */
  AgoraLighteningContrastNormal = 1,
  /** High contrast level. */
  AgoraLighteningContrastHigh = 2,
};

/** The type of the custom background image.
 @since v3.7.200
 */
typedef NS_ENUM(NSUInteger, AgoraVirtualBackgroundSourceType) {
  /** 1: (Default) The background image is a solid color.*/
  AgoraVirtualBackgroundColor = 1,
  /** 2: The background image is a file in PNG or JPG format.*/
  AgoraVirtualBackgroundImg = 2,
  /** Background source is blur your background */
  AgoraVirtualBackgroundBlur = 3,
} NS_SWIFT_NAME(AgoraVirtualBackgroundSourceType);

/** The lightening contrast level. */
typedef NS_ENUM(NSUInteger, AgoraBlurDegree) {
  /** Background few things*/
  AgoraBlurLow = 1,
  /** Background blur more things*/
  AgoraBlurMedium = 2,
  /** Background blur most */
  AgoraBlurHigh = 3,
} NS_SWIFT_NAME(AgoraBlurDegree);

typedef NS_ENUM(NSInteger, AgoraConnectionChangedReason) {
  /**
   * 0: The SDK is connecting to Agora's edge server.
   */
  AgoraConnectionChangedReasonConnecting = 0,
  /**
   * 1: The SDK has joined the channel successfully.
   */
  AgoraConnectionChangedReasonJoinSuccess = 1,
  /**
   * 2: The connection between the SDK and Agora's edge server is interrupted.
   */
  AgoraConnectionChangedReasonInterrupted = 2,
  /**
   * 3: The connection between the SDK and Agora's edge server is banned by Agora's edge server.
   */
  AgoraConnectionChangedReasonBannedByServer = 3,
  /**
   * 4: The SDK fails to join the channel for more than 20 minutes and stops reconnecting to the channel.
   */
  AgoraConnectionChangedReasonJoinFailed = 4,
  /**
   * 5: The SDK has left the channel.
   */
  AgoraConnectionChangedReasonLeaveChannel = 5,
  /**
   * 6: The connection failed since Appid is not valid.
   */
  AgoraConnectionChangedReasonInvalidAppId = 6,
  /**
   * 7: The connection failed since channel name is not valid.
   */
  AgoraConnectionChangedReasonInvalidChannelName = 7,
  /**
   * 8: The connection failed since token is not valid, possibly because:
   - The App Certificate for the project is enabled in Console, but you do not use Token when
   joining the channel. If you enable the App Certificate, you must use a token to join the channel.
   - The uid that you specify in the `joinChannel` method
   is different from the uid that you pass for generating the token.
   */
  AgoraConnectionChangedReasonInvalidToken = 8,
  /**
   * 9: The connection failed since token is expired.
   */
  AgoraConnectionChangedReasonTokenExpired = 9,
  /**
   * 10: The connection is rejected by server.
   */
  AgoraConnectionChangedReasonRejectedByServer = 10,
  /**
   * 11: The connection changed to reconnecting since SDK has set a proxy server.
   */
  AgoraConnectionChangedReasonSettingProxyServer = 11,
  /**
   * 12: When SDK is in connection failed, the renew token operation will make it connecting.
   */
  AgoraConnectionChangedReasonRenewToken = 12,
  /**
   * 13: The IP Address of SDK client has changed. i.e., Network type or IP/Port changed by network
     operator might change client IP address.
   */
  AgoraConnectionChangedReasonClientIpAddressChanged = 13,
  /**
   * 14: Timeout for the keep-alive of the connection between the SDK and Agora's edge server. The
     connection state changes to CONNECTION_STATE_RECONNECTING(4).
   */
  AgoraConnectionChangedReasonKeepAliveTimeout = 14,
  /**
   * 15: The SDK has rejoined the channel successfully.
   */
  AgoraConnectionChangedReasonRejoinSuccess = 15,
  /**
   * 16: The connection between the SDK and Agora's edge server is lost.
   */
  AgoraConnectionChangedReasonLost = 16,
  /**
   * 17: The change of connection state is caused by echo test.
   */
  AgoraConnectionChangedReasonEchoTest = 17,
};

/**
 * The playback state of the audio mixing file.
 */
typedef NS_ENUM(NSInteger, AgoraAudioMixingStateType) {
  /**
   * 710: The audio mixing file is playing.
   */
  AgoraAudioMixingStateTypePlaying = 710,
  /**
   * 711: The audio mixing file pauses playing.
   */
  AgoraAudioMixingStateTypePaused = 711,
  /**
   * 713: The audio mixing file stops playing.
   */
  AgoraAudioMixingStateTypeStopped = 713,
  /**
   * 714: The audio mixing file playback fails. See `AgoraAudioMixingErrorType` for details.
   */
  AgoraAudioMixingStateTypeFailed = 714,
  /**
   * 715: The audio mixing file is played once.
   */
  AgoraAudioMixingStateTypeCompleted = 715,
  /**
   * 716: The audio mixing file is all played out.
   */
  AgoraAudioMixingStateTypeAllLoopsCompleted = 716,
};

/**
 * The audio mixing error code.
 */
typedef NS_ENUM(NSInteger, AgoraAudioMixingErrorType) {
  /**
   * 701: The SDK cannot open the audio file.
   */
  AgoraAudioMixingErrorTypeCanNotOpen = 701,
  /**
   * 702: The SDK opens the audio mixing file too frequently. Ensure that the time interval between calling {@link AgoraRtcEngineKit.startAudioMixing:loopback:replace:cycle: startAudioMixing} is more than 100 ms.
   */
  AgoraAudioMixingErrorTypeTooFrequentlyCall = 702,
  /**
   * 703: The audio mixing file playback is interrupted.
   */
  AgoraAudioMixingErrorTypeInterruptedEOF = 703,
  /**
   * 0: No error.
   */
  AgoraAudioMixingErrorTypeOk = 0,
};

typedef NS_ENUM (NSInteger, AgoraMetadataType) {
  /** -1: The metadata type is unknown.
   */
  AgoraMetadataTypeUnknown = -1,
  /** 0: The metadata type is video.
   */
  AgoraMetadataTypeVideo = 0
};

/**
 * The maximum metadata size.
 */
typedef NS_ENUM (NSInteger, AgoraMaxMetadataSizeType) {
  AgoraMaxMetadataSizeTypeInvalid = -1,
  AgoraMaxMetadataSizeTypeDefault = 512,
  AgoraMaxMetadataSizeTypeMax = 1024
};

/**
 * Supported logging severities of SDK.
 */
typedef NS_ENUM (NSInteger, AgoraLogLevel) {
  /**
   * Do not output any log file.
   */
  AgoraLogLevelNone = 0x0000,
  /**
   * (Recommended) Output log files of the Info level.
   */
  AgoraLogLevelInfo = 0x0001,
  /**
   * Output log files of the Warning level.
   */
  AgoraLogLevelWarn = 0x0002,
  /**
   * Output log files of the Error level.
   */
  AgoraLogLevelError = 0x0004,
  /**
   * Output log files of the Critical level.
   */
  AgoraLogLevelFatal = 0x0008
};

/** Areas for geofencing.
 */
typedef NS_ENUM(NSUInteger, AgoraAreaCodeType) {
  /**
   * Mainland China.
   */
  AgoraAreaCodeTypeCN = 0x1,
  /**
   * North America.
   */
  AgoraAreaCodeTypeNA = 0x2,
  /**
   * Europe.
   */
  AgoraAreaCodeTypeEUR = 0x4,
  /**
   * Asia, excluding Mainland China.
   */
  AgoraAreaCodeTypeAS = 0x8,
  /**
   * Japan.
   */
  AgoraAreaCodeTypeJP = 0x10,
  /**
   * India
   */
  AgoraAreaCodeTypeIN = 0x20,
  /**
   * (Default) Global.
   */
  AgoraAreaCodeTypeGlobal = 0xFFFFFFFF
};

/**
 * States of the RTMP streaming.
 */
typedef NS_ENUM(NSUInteger, AgoraRtmpStreamPublishState) {
  /**
   * 0: The RTMP streaming has not started or has ended.
   *
   * This state is also reported after you remove
   * an RTMP address from the CDN by calling `removePublishStreamUrl`.
   */
  RTMP_STREAM_PUBLISH_STATE_IDLE = 0,
  /**
   * 1: The SDK is connecting to the streaming server and the RTMP server.
   *
   * This state is reported after you call `addPublishStreamUrl`.
   */
  RTMP_STREAM_PUBLISH_STATE_CONNECTING = 1,
  /**
   * 2: The RTMP streaming publishes. The SDK successfully publishes the RTMP streaming and returns
   * this state.
   */
  RTMP_STREAM_PUBLISH_STATE_RUNNING = 2,
  /**
   * 3: The RTMP streaming is recovering. When exceptions occur to the CDN, or the streaming is
   * interrupted, the SDK tries to resume RTMP streaming and reports this state.
   *
   * - If the SDK successfully resumes the streaming, `RTMP_STREAM_PUBLISH_STATE_RUNNING(2)` is reported.
   * - If the streaming does not resume within 60 seconds or server errors occur,
   * `RTMP_STREAM_PUBLISH_STATE_FAILURE(4)` is reported. You can also reconnect to the server by calling
   * `removePublishStreamUrl` and `addPublishStreamUrl`.
   */
  RTMP_STREAM_PUBLISH_STATE_RECOVERING = 3,
  /**
   * 4: The RTMP streaming fails. See the `errCode` parameter for the detailed error information. You
   * can also call `addPublishStreamUrl` to publish the RTMP streaming again.
   */
  RTMP_STREAM_PUBLISH_STATE_FAILURE = 4
};

/**
 * Error codes of the RTMP streaming.
 */
typedef NS_ENUM(NSInteger, AgoraRtmpStreamPublishError) {
  /**
   * -1: The RTMP streaming fails.
   */
  RTMP_STREAM_PUBLISH_ERROR_FAILED = -1,
  /**
   * 0: The RTMP streaming publishes successfully.
   */
  RTMP_STREAM_PUBLISH_ERROR_OK = 0,
  /**
   * 1: Invalid argument. If, for example, you did not call `setLiveTranscoding` to configure the
   * LiveTranscoding parameters before calling `addPublishStreamUrl`, the SDK reports this error.
   * Check whether you set the parameters in `LiveTranscoding` properly.
   */
  RTMP_STREAM_PUBLISH_ERROR_INVALID_ARGUMENT = 1,
  /**
   * 2: The RTMP streaming is encrypted and cannot be published.
   */
  RTMP_STREAM_PUBLISH_ERROR_ENCRYPTED_STREAM_NOT_ALLOWED = 2,
  /**
   * 3: A timeout occurs with the RTMP streaming. Call `addPublishStreamUrl`
   * to publish the streaming again.
   */
  RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT = 3,
  /**
   * 4: An error occurs in the streaming server. Call `addPublishStreamUrl` to publish
   * the stream again.
   */
  RTMP_STREAM_PUBLISH_ERROR_INTERNAL_SERVER_ERROR = 4,
  /**
   * 5: An error occurs in the RTMP server.
   */
  RTMP_STREAM_PUBLISH_ERROR_RTMP_SERVER_ERROR = 5,
  /**
   * 6: The RTMP streaming publishes too frequently.
   */
  RTMP_STREAM_PUBLISH_ERROR_TOO_OFTEN = 6,
  /**
   * 7: The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
   */
  RTMP_STREAM_PUBLISH_ERROR_REACH_LIMIT = 7,
  /**
   * 8: The host manipulates other hosts' URLs. Check your app logic.
   */
  RTMP_STREAM_PUBLISH_ERROR_NOT_AUTHORIZED = 8,
  /**
   * 9: The Agora server fails to find the RTMP streaming.
   */
  RTMP_STREAM_PUBLISH_ERROR_STREAM_NOT_FOUND = 9,
  /**
   * 10: The format of the RTMP streaming URL is not supported. Check whether the URL format is correct.
   */
  RTMP_STREAM_PUBLISH_ERROR_FORMAT_NOT_SUPPORTED = 10,
  /**
   * 11: CDN related errors. Remove the original URL address and add a new one by calling
   * `removePublishStreamUrl` and `addPublishStreamUrl`.
   */
  RTMP_STREAM_PUBLISH_ERROR_CDN_ERROR = 11,
  /**
   * 12: Resources are occupied and cannot be reused.
   */
  RTMP_STREAM_PUBLISH_ERROR_ALREADY_IN_USE = 12,
  /**
   * 100:The streaming has been stopped normally. After you call
   * \ref IRtcEngine::removePublishStreamUrl "removePublishStreamUrl"
   * to stop streaming, the SDK returns this value.
   */
   RTMP_STREAM_UNPUBLISH_ERROR_OK = 100
};

/**
 * Encryption error type.
 */
typedef NS_ENUM(NSInteger, AgoraEncryptionErrorType) {
  ENCRYPTION_ERROR_INTERNAL_FAILURE = 0,
  ENCRYPTION_ERROR_DECRYPTION_FAILURE = 1,
  ENCRYPTION_ERROR_ENCRYPTION_FAILURE = 2
};

/**
 * The camera direction
 */
typedef NS_ENUM(NSUInteger, AgoraCameraDirection) {
  /**
   * 0: Uses the rear camera.
   */
  AgoraCameraDirectionRear = 0,
  /**
   * 1: Uses the front camera.
   */
  AgoraCameraDirectionFront = 1,
};

/** The state code in AgoraChannelMediaRelayState.
 */
typedef NS_ENUM(NSInteger, AgoraChannelMediaRelayState) {
  /** 0: The SDK is initializing.
   */
  AgoraChannelMediaRelayStateIdle = 0,
  /** 1: The SDK tries to relay the media stream to the destination channel.
   */
  AgoraChannelMediaRelayStateConnecting = 1,
  /** 2: The SDK successfully relays the media stream to the destination channel.
   */
  AgoraChannelMediaRelayStateRunning = 2,
  /** 3: A failure occurs. See the details in `error`.
   */
  AgoraChannelMediaRelayStateFailure = 3,
};

/** The event code in AgoraChannelMediaRelayEvent.
 */
typedef NS_ENUM(NSInteger, AgoraChannelMediaRelayEvent) {
  /** 0: The user disconnects from the server due to poor network connections.
   */
  AgoraChannelMediaRelayEventDisconnect = 0,
  /** 1: The network reconnects.
   */
  AgoraChannelMediaRelayEventConnected = 1,
  /** 2: The user joins the source channel.
   */
  AgoraChannelMediaRelayEventJoinedSourceChannel = 2,
  /** 3: The user joins the destination channel.
   */
  AgoraChannelMediaRelayEventJoinedDestinationChannel = 3,
  /** 4: The SDK starts relaying the media stream to the destination channel.
   */
  AgoraChannelMediaRelayEventSentToDestinationChannel = 4,
  /** 5: The server receives the video stream from the source channel.
   */
  AgoraChannelMediaRelayEventReceivedVideoPacketFromSource = 5,
  /** 6: The server receives the audio stream from the source channel.
   */
  AgoraChannelMediaRelayEventReceivedAudioPacketFromSource = 6,
  /** 7: The destination channel is updated.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannel = 7,
  /** 8: The destination channel update fails due to internal reasons.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannelRefused = 8,
  /** 9: The destination channel does not change, which means that the destination channel fails to be updated.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannelNotChange = 9,
  /** 10: The destination channel name is NULL.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannelIsNil = 10,
  /** 11: The video profile is sent to the server.
   */
  AgoraChannelMediaRelayEventVideoProfileUpdate = 11,
    /** 12: pause send packet to dest channel success.
   */
  AgoraChannelMediaRelayEventPauseSendPacketToDestChannelSuccess = 12,
  /** 13: pause send packet to dest channel failed.
   */
  AgoraChannelMediaRelayEventPauseSendPacketToDestChannelFailed = 13,
  /** 14: resume send packet to dest channel success.
   */
  AgoraChannelMediaRelayEventResumeSendPacketToDestChannelSuccess = 14,
  /** 15: pause send packet to dest channel failed.
   */
  AgoraChannelMediaRelayEventResumeSendPacketToDestChannelFailed = 15,
};

/** The error code in AgoraChannelMediaRelayError.
 */
typedef NS_ENUM(NSInteger, AgoraChannelMediaRelayError) {
  /** 0: The state is normal.
   */
  AgoraChannelMediaRelayErrorNone = 0,
  /** 1: An error occurs in the server response.
   */
  AgoraChannelMediaRelayErrorServerErrorResponse = 1,
  /** 2: No server response. You can call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method to leave the channel.
   */
  AgoraChannelMediaRelayErrorServerNoResponse = 2,
  /** 3: The SDK fails to access the service, probably due to limited resources of the server.
   */
  AgoraChannelMediaRelayErrorNoResourceAvailable = 3,
  /** 4: Fails to send the relay request.
   */
  AgoraChannelMediaRelayErrorFailedJoinSourceChannel = 4,
  /** 5: Fails to accept the relay request.
   */
  AgoraChannelMediaRelayErrorFailedJoinDestinationChannel = 5,
  /** 6: The server fails to receive the media stream.
   */
  AgoraChannelMediaRelayErrorFailedPacketReceivedFromSource = 6,
  /** 7: The server fails to send the media stream.
   */
  AgoraChannelMediaRelayErrorFailedPacketSentToDestination = 7,
  /** 8: The SDK disconnects from the server due to poor network connections. You can call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method to leave the channel.
   */
  AgoraChannelMediaRelayErrorServerConnectionLost = 8,
  /** 9: An internal error occurs in the server.
   */
  AgoraChannelMediaRelayErrorInternalError = 9,
  /** 10: The token of the source channel has expired.
   */
  AgoraChannelMediaRelayErrorSourceTokenExpired = 10,
  /** 11: The token of the destination channel has expired.
   */
  AgoraChannelMediaRelayErrorDestinationTokenExpired = 11,
};

/*
 * The stream subscribe state.
 */
typedef NS_ENUM (NSInteger, AgoraStreamSubscribeState) {
  AgoraStreamSubscribeStateIdle = 0,
  AgoraStreamSubscribeStateNoSubscribed = 1,
  AgoraStreamSubscribeStateSubscribing = 2,
  AgoraStreamSubscribeStateSubscribed = 3
};

/**
 * The stream publish state.
 */
typedef NS_ENUM (NSInteger, AgoraStreamPublishState) {
  AgoraStreamPublishStateIdle = 0,
  AgoraStreamPublishStateNoPublished = 1,
  AgoraStreamPublishStatePublishing = 2,
  AgoraStreamPublishStatePublished = 3
};

/**
 * Media source types definition.
 */
typedef NS_ENUM(NSInteger, AgoraMediaSourceType) {
  /** 
   * 0: The audio playback device.
   */
  AgoraMediaSourceTypeAudioPlayout = 0,
  /** 
   * 1: Microphone.
   */
  AgoraMediaSourceTypeRecording = 1,
  /**
   * 2: Video captured by primary camera.
   */
  AgoraMediaSourceTypePrimaryCamera = 2,
  /**
   * 3: Video captured by secondary camera.
   */
  AgoraMediaSourceTypeSecondaryCamera = 3,
  /**
   * 4: Video captured by primary screen capturer.
   */
  AgoraMediaSourceTypePrimaryScreen = 4,
  /**
   * 5: Video captured by secondary screen capturer.
   */
  AgoraMediaSourceTypeSecondaryScreen = 5,
  /**
   * 6: Video captured by custom video source.
   */
  AgoraMediaSourceTypeCustomVideo = 6,
  /**
   * 7: Video for media player sharing.
   */
  AgoraMediaSourceTypeMediaPlayer = 7,
  /**
   * 8: Video for png image.
   */
  AgoraMediaSourceTypeRtcImagePng = 8,
  /**
   * 9: Video for jpeg image.
   */
  AgoraMediaSourceTypeRtcImageJpeg = 9,
  /**
   * 10: Video for gif image.
   */
  AgoraMediaSourceTypeRtcImageGif = 10,
  /**
   * 11: Remote video received from network.
   */
  AgoraMediaSourceTypeRemoteVideo = 11,
  /**
   * 12: Video for transcoded.
   */
  AgoraMediaSourceTypeTranscodedVideo = 12,
  /**
   * 100: unknown media source.
   */
  AgoraMediaSourceTypeUnknown = 100
};

/**
 * Video source types definition.
 */
typedef NS_ENUM(NSInteger, AgoraVideoSourceType) {
  /** Video captured by the camera.
   */
  AgoraVideoSourceTypeCamera = 0,
  /** Video captured by the secondary camera.
   */
  AgoraVideoSourceTypeCameraSecondary = 1,
  /** Video for screen sharing.
   */
  AgoraVideoSourceTypeScreen = 2,
  /** Video for secondary screen sharing.
   */
  AgoraVideoSourceTypeScreenSecondary = 3,
  /** Video for custom video.
   */
  AgoraVideoSourceTypeCustom = 4,
  /** Video for media player sharing.
   */
  AgoraVideoSourceTypeMediaPlayer = 5,
  /** Video for png image.
   */
  AgoraVideoSourceTypeImagePNG = 6,
  /** Video for JPEG image.
   */
  AgoraVideoSourceTypeImageJPEG = 7,
  /** Video for GIF image.
   */
  AgoraVideoSourceTypeImageGIF = 8,
  /** Remote video received from network.
   */
  AgoraVideoSourceTypeRemote = 9,
  /** Video for transcoded.
   */
  AgoraVideoSourceTypeTransCoded = 10,
  /** Not define.
   */
  AgoraVideoSourceTypeUnknown = 100
};

/**
 * The external video source type.
 */
typedef NS_ENUM(NSInteger, AgoraExternalVideoSourceType) {
  /**
   * 0: non-encoded video frame.
   */
  AgoraExternalVideoSourceTypeVideoFrame = 0,
  /**
   * 1: encoded video frame.
   */
  AgoraExternalVideoSourceTypeEncodedVideoFrame,
};

/**
 * AgoraMediaStreamType, reporting the type of the media stream.
 */
typedef NS_ENUM(NSInteger, AgoraMediaStreamType) {
  /** `0`: The type is unknown. */
  AgoraMediaStreamTypeUnknow = 0,
  /** `1`: The video stream.  */
  AgoraMediaStreamTypeVideo = 1,
  /** `2`: The audio stream. */
  AgoraMediaStreamTypeAudio = 2,
  /** `3`: The subtitle stream. */
  AgoraMediaStreamTypeSubtitle = 3,
};

/**
 * @brief Player state
 *
 */
typedef NS_ENUM(NSInteger, AgoraMediaPlayerState) {
  /** Player idle
   */
  AgoraMediaPlayerStateIdle = 0,
  /** Opening media file
   */
  AgoraMediaPlayerStateOpening,
  /** Media file opened successfully
   */
  AgoraMediaPlayerStateOpenCompleted,
  /** Player playing
   */
  AgoraMediaPlayerStatePlaying,
  /** Player paused
   */
  AgoraMediaPlayerStatePaused,
  /** Player playback one loop completed
   */
  AgoraMediaPlayerStatePlayBackCompleted,
  /** Player playback all loops completed
   */
  AgoraMediaPlayerStatePlayBackAllLoopsCompleted,
  /** Player stopped
   */
  AgoraMediaPlayerStateStopped,
  /** Player pausing (internal)
   */
  AgoraMediaPlayerStatePausingInternal = 50,
  /** Player stopping (internal)
   */
  AgoraMediaPlayerStateStoppingInternal,
  /** Player seeking state (internal)
   */
  AgoraMediaPlayerStateSeekingInternal,
  /** Player getting state (internal)
   */
  AgoraMediaPlayerStateGettingInternal,
  /** None state for state machine (internal)
   */
  AgoraMediaPlayerStateNoneInternal,
  /** Do nothing state for state machine (internal)
   */
  AgoraMediaPlayerStateDoNothingInternal,
  /** Player failed
   */
  AgoraMediaPlayerStateFailed = 100,
};

/**
 * The video display mode.
 */
typedef NS_ENUM(NSUInteger, AgoraMediaPlayerRenderMode) {
  /**
   * 1: Uniformly scale the video until it fills the visible boundaries
   * (cropped). One dimension of the video may have clipped contents.
   */
  AgoraMediaPlayerRenderModeHidden = 1,
  /**
   * 2: Uniformly scale the video until one of its dimension fits the boundary
   * (zoomed to fit). Areas that are not filled due to the disparity in the
   * aspect ratio will be filled with black.
   */
  AgoraMediaPlayerRenderModeFit = 2,
};

/** AgoraMediaPlayerError, reporting the player's error code. */
typedef NS_ENUM(NSInteger, AgoraMediaPlayerError) {
  /** `0`: No error. */
  AgoraMediaPlayerErrorNone = 0,
  /** `-1`: Invalid arguments. */
  AgoraMediaPlayerErrorInvalidArguments = -1,
  /** `-2`: Internal error. */
  AgoraMediaPlayerErrorInternal = -2,
  /** `-3`: No resource. */
  AgoraMediaPlayerErrorNoSource = -3,
  /** `-4`: Invalid media resource. */
  AgoraMediaPlayerErrorInvalidMediaSource = -4,
  /** `-5`: The type of the media stream is unknown. */
  AgoraMediaPlayerErrorUnknowStreamType = -5,
  /** `-6`: The object is not initialized. */
  AgoraMediaPlayerErrorObjNotInitialized = -6,
  /** `-7`: The codec is not supported. */
  AgoraMediaPlayerErrorCodecNotSupported = -7,
  /** `-8`: Invalid renderer. */
  AgoraMediaPlayerErrorVideoRenderFailed = -8,
  /** `-9`: Error occurs in the internal state of the player. */
  AgoraMediaPlayerErrorInvalidState = -9,
  /** `-10`: The URL of the media resource can not be found. */
  AgoraMediaPlayerErrorUrlNotFound = -10,
  /** `-11`: Invalid connection between the player and Agora's Server. */
  AgoraMediaPlayerErrorInvalidConnectState = -11,
  /** `-12`: The playback buffer is insufficient. */
  AgoraMediaPlayerErrorSrcBufferUnderflow = -12,
};

/** AgoraMediaPlayerEvent, reporting the result of the seek operation to the new
 playback position.
 */
typedef NS_ENUM(NSInteger, AgoraMediaPlayerEvent) {
  /** `0`: Begins to seek to the new playback position. */
  AgoraMediaPlayerEventSeekBegin = 0,
  /** `1`: Finish seeking to the new playback position. */
  AgoraMediaPlayerEventSeekComplete = 1,
  /** `2`: Error occurs when seeking to the new playback position. */
  AgoraMediaPlayerEventSeekError = 2,
  /** The player publishes a video track. */
  AgoraMediaPlayerEventVideoPublished = 3,
  /** The player publishes an audio track. */
  AgoraMediaPlayerEventAudioPublished = 4,
  /** The player changes the audio track for playback. */
  AgoraMediaPlayerEventAudioTrackChanged= 5,
  /** player buffer low. */
  AgoraMediaPlayerEventBufferLow = 6,
  /** player buffer recover. */
  AgoraMediaPlayerEventBufferRecover = 7,
  /** `8`: The video or audio is interrupted. */
  AgoraMediaPlayerEventFreezeStart = 8,
  /** `9`: Interrupt at the end of the video or audio. */
  AgoraMediaPlayerEventFreezeStop = 9,
  /** switch source begin. */
  AgoraMediaPlayerEventSwitchBegin = 10,
  /** switch source complete. */
  AgoraMediaPlayerEventSwitchComplete = 11,
  /** switch source error. */
  AgoraMediaPlayerEventSwitchError = 12,
  /** An application can render the video to less than a second. */
  AgoraMediaPlayerEventFirstDisplayed = 13,
  /** device id or player id updated. */
  AgoraMediaPlayerEventIdsUpdate = 14,
};

/**
 * @brief The play preload another source event.
 */
typedef NS_ENUM(NSUInteger, AgoraMediaPlayerPreloadEvent) {
  /** preload source begin. */
  AgoraMediaPlayerPreloadEventBegin = 0,
  /** preload source complete. */
  AgoraMediaPlayerPreloadEventComplete = 1,
  /** preload source error. */
  AgoraMediaPlayerPreloadEventError = 2,
};

/**
 * AgoraMediaPlayerMetaDataType, reporting the type of the media metadata.
 */
typedef NS_ENUM(NSUInteger, AgoraMediaPlayerMetaDataType) {
  /** `0`: The type is unknown. */
  AgoraMediaPlayerMetaDataTypeUnknown = 0,
  /** `1`: The type is SEI. */
  AgoraMediaPlayerMetaDataTypeSEI = 1,
};

/** Type of permission.
 */
typedef NS_ENUM(NSInteger, AgoraPermissionType) {
  /** 0: Permission, Record Audio
   */
  AgoraPermissionTypeRecordAudio = 0,
  /** 1:Permission, Camera
   */
  AgoraPermissionTypeCamera = 1,
};

/**
 * @brief Streaming state
 *
 */
typedef NS_ENUM(NSInteger, AgoraDirectCdnStreamingState) {
  /** State idle. */
  AgoraDirectCdnStreamingStateIdle = 0,
  /** Start pushing the stream. */
  AgoraDirectCdnStreamingStateRunning = 1,
   /** Stop  push stream. */
  AgoraDirectCdnStreamingStateStopped = 2,
  /** Failed to push the stream.*/
  AgoraDirectCdnStreamingStateFailed = 3,
  /** Retrying to push stream */
  AgoraDirectCdnStreamingStateRecovering = 4,
};

/**
 */
typedef NS_ENUM(NSInteger, AgoraDirectCdnStreamingError) {
// No error occurs.
  AgoraDirectCdnStreamingErrorOK = 0,
// A general error occurs (no specified reason).
  AgoraDirectCdnStreamingErrorFailed = 1,
// Audio publication error.
  AgoraDirectCdnStreamingErrorAudioPublication = 2,
// Video publication error.
  AgoraDirectCdnStreamingErrorVideoPublication = 3,
// Network connect error.
  AgoraDirectCdnStreamingErrorNetConnect = 4,
// Already exist stream name.
  AgoraDirectCdnStreamingErrorBadName = 5,
};

/** Type of ear monitoring.
 */
typedef NS_OPTIONS(NSInteger, AgoraEarMonitoringFilterType) {
  /**
   * 1: Do not add an audio filter to the in-ear monitor.
   */
  AgoraEarMonitoringFilterNone = (1<<0),
  /**
   * 2: Add an audio filter to the in-ear monitor.
   */
  AgoraEarMonitoringFilterBuiltInAudioFilters = (1<<1),
  /**
   * 4: Enable noise suppression to the in-ear monitor.
   */
  AgoraEarMonitoringFilterNoiseSuppression = (1<<2)
};

typedef NS_ENUM(NSUInteger, AgoraContentInspectType) {
    /**< default type is invalid */
    AgoraContentInspectTypeInvalid = 0,
    /**< content inspect type moderation */
    AgoraContentInspectTypeModeration = 1,
    /**< content inspect type supervise */
    AgoraContentInspectTypeSupervise = 2
};

typedef NS_ENUM(NSUInteger, AgoraContentInspectDeviceType) {
    /**< default type is invalid */
    AgoraContentInspectDeviceTypeInvalid = 0,
    AgoraContentInspectDeviceTypeAgora = 1,
    /*not used now*/
    AgoraContentInspectDeviceTypeHive = 2,
    /*not used now*/
    AgoraContentInspectDeviceTypeTupu = 3,
};

typedef NS_ENUM(NSUInteger, AgoraContentInspectResult) {
  AgoraContentInspectNeutral = 1,
  // background image does not exist
  AgoraContentInspectSexy = 2,
  // color format is not supported
  AgoraContentInspectPorn = 3,
};

/** Thread priority type.
 */
typedef NS_ENUM(NSInteger, AgoraThreadPriorityType) {
  /**
   * 0: Lowest priority.
   */
  AgoraThreadPriorityTypeLowest = 0,
  /**
   * 1: Low priority.
   */
  AgoraThreadPriorityTypeLow = 1,
  /**
   * 2: Normal priority.
   */
  AgoraThreadPriorityTypeNormal = 2,
  /**
   * 3: High priority.
   */
  AgoraThreadPriorityTypeHigh = 3,
  /**
   * 4. Highest priority.
   */
  AgoraThreadPriorityTypeHighest = 4,
  /**
   * 5. Critical priority.
   */
  AgoraThreadPriorityTypeCritical = 5,
};

/** The audio dual-mono output mode.
 */
typedef NS_ENUM(NSUInteger, AgoraAudioDualMonoMode) {
    /**< ChanLOut=ChanLin, ChanRout=ChanRin */
    AgoraAudioDualMonoStereo,
    /**< ChanLOut=ChanRout=ChanLin */
    AgoraAudioDualMonoL,
    /**< ChanLOut=ChanRout=ChanRin */
    AgoraAudioDualMonoR,
    /**< ChanLout=ChanRout=(ChanLin+ChanRin)/2 */
    AgoraAudioDualMonoMix
};

/**
 The states of the rhythm player.
 */
typedef NS_ENUM(NSInteger, AgoraRhythmPlayerState) {
  /** 810: The rhythm player is idle. */
  AgoraRhythmPlayerStateIdle = 810,
  /** 811: The rhythm player is opening files. */
  AgoraRhythmPlayerStateOpening,
  /** 812: 812: Files opened successfully, the rhythm player starts decoding files. */
  AgoraRhythmPlayerStateDecoding,
  /** 813: Files decoded successfully, the rhythm player starts mixing the two files and playing back them locally. */
  AgoraRhythmPlayerStatePlaying,
  /** 814: The rhythm player is starting to fail, and you need to check the error code for detailed failure reasons. */
  AgoraRhythmPlayerStateFailed,
};

/**
 The error codes of the rhythm player.
 */
typedef NS_ENUM(NSInteger, AgoraRhythmPlayerError) {
  /** 0: The rhythm player works well. */
  AgoraRhythmPlayerErrorOK = 0,
  /** 1: The rhythm player occurs a internal error. */
  AgoraRhythmPlayerErrorFailed = 1,
  /** 801: The rhythm player can not open the file. */
  AgoraRhythmPlayerErrorCanNotOpen = 801,
  /** 802: The rhythm player can not play the file. */
  AgoraRhythmPlayerErrorCanNotPlay,
  /** 803: The file duration over the limit. The file duration limit is 1.2 seconds. */
  AgoraRhythmPlayerErrorFileOverDurationLimit,
};
