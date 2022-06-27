import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_base.g.dart';

@JsonEnum(alwaysCreate: true)
enum ChannelProfileType {
  @JsonValue(0)
  channelProfileCommunication,
  @JsonValue(1)
  channelProfileLiveBroadcasting,
  @JsonValue(2)
  channelProfileGame,
  @JsonValue(3)
  channelProfileCloudGaming,
  @JsonValue(4)
  channelProfileCommunication1v1,
  @JsonValue(5)
  channelProfileLiveBroadcasting2,
}

extension ChannelProfileTypeExt on ChannelProfileType {
  int value() {
    return _$ChannelProfileTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum WarnCodeType {
  @JsonValue(8)
  warnInvalidView,
  @JsonValue(16)
  warnInitVideo,
  @JsonValue(20)
  warnPending,
  @JsonValue(103)
  warnNoAvailableChannel,
  @JsonValue(104)
  warnLookupChannelTimeout,
  @JsonValue(105)
  warnLookupChannelRejected,
  @JsonValue(106)
  warnOpenChannelTimeout,
  @JsonValue(107)
  warnOpenChannelRejected,
  @JsonValue(111)
  warnSwitchLiveVideoTimeout,
  @JsonValue(118)
  warnSetClientRoleTimeout,
  @JsonValue(121)
  warnOpenChannelInvalidTicket,
  @JsonValue(122)
  warnOpenChannelTryNextVos,
  @JsonValue(131)
  warnChannelConnectionUnrecoverable,
  @JsonValue(132)
  warnChannelConnectionIpChanged,
  @JsonValue(133)
  warnChannelConnectionPortChanged,
  @JsonValue(134)
  warnChannelSocketError,
  @JsonValue(701)
  warnAudioMixingOpenError,
  @JsonValue(1014)
  warnAdmRuntimePlayoutWarning,
  @JsonValue(1016)
  warnAdmRuntimeRecordingWarning,
  @JsonValue(1019)
  warnAdmRecordAudioSilence,
  @JsonValue(1020)
  warnAdmPlayoutMalfunction,
  @JsonValue(1021)
  warnAdmRecordMalfunction,
  @JsonValue(1029)
  warnAdmIosCategoryNotPlayandrecord,
  @JsonValue(1030)
  warnAdmIosSamplerateChange,
  @JsonValue(1031)
  warnAdmRecordAudioLowlevel,
  @JsonValue(1032)
  warnAdmPlayoutAudioLowlevel,
  @JsonValue(1040)
  warnAdmWindowsNoDataReadyEvent,
  @JsonValue(1051)
  warnApmHowling,
  @JsonValue(1052)
  warnAdmGlitchState,
  @JsonValue(1053)
  warnAdmImproperSettings,
  @JsonValue(1322)
  warnAdmWinCoreNoRecordingDevice,
  @JsonValue(1323)
  warnAdmWinCoreNoPlayoutDevice,
  @JsonValue(1324)
  warnAdmWinCoreImproperCaptureRelease,
}

extension WarnCodeTypeExt on WarnCodeType {
  int value() {
    return _$WarnCodeTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ErrorCodeType {
  @JsonValue(0)
  errOk,
  @JsonValue(1)
  errFailed,
  @JsonValue(2)
  errInvalidArgument,
  @JsonValue(3)
  errNotReady,
  @JsonValue(4)
  errNotSupported,
  @JsonValue(5)
  errRefused,
  @JsonValue(6)
  errBufferTooSmall,
  @JsonValue(7)
  errNotInitialized,
  @JsonValue(8)
  errInvalidState,
  @JsonValue(9)
  errNoPermission,
  @JsonValue(10)
  errTimedout,
  @JsonValue(11)
  errCanceled,
  @JsonValue(12)
  errTooOften,
  @JsonValue(13)
  errBindSocket,
  @JsonValue(14)
  errNetDown,
  @JsonValue(15)
  errNetNobufs,
  @JsonValue(17)
  errJoinChannelRejected,
  @JsonValue(18)
  errLeaveChannelRejected,
  @JsonValue(19)
  errAlreadyInUse,
  @JsonValue(20)
  errAborted,
  @JsonValue(21)
  errInitNetEngine,
  @JsonValue(22)
  errResourceLimited,
  @JsonValue(101)
  errInvalidAppId,
  @JsonValue(102)
  errInvalidChannelName,
  @JsonValue(103)
  errNoServerResources,
  @JsonValue(109)
  errTokenExpired,
  @JsonValue(110)
  errInvalidToken,
  @JsonValue(111)
  errConnectionInterrupted,
  @JsonValue(112)
  errConnectionLost,
  @JsonValue(113)
  errNotInChannel,
  @JsonValue(114)
  errSizeTooLarge,
  @JsonValue(115)
  errBitrateLimit,
  @JsonValue(116)
  errTooManyDataStreams,
  @JsonValue(117)
  errStreamMessageTimeout,
  @JsonValue(119)
  errSetClientRoleNotAuthorized,
  @JsonValue(120)
  errDecryptionFailed,
  @JsonValue(121)
  errInvalidUserId,
  @JsonValue(123)
  errClientIsBannedByServer,
  @JsonValue(124)
  errWatermarkParam,
  @JsonValue(125)
  errWatermarkPath,
  @JsonValue(126)
  errWatermarkPng,
  @JsonValue(127)
  errWatermarkrInfo,
  @JsonValue(128)
  errWatermarkArgb,
  @JsonValue(129)
  errWatermarkRead,
  @JsonValue(130)
  errEncryptedStreamNotAllowedPublish,
  @JsonValue(131)
  errLicenseCredentialInvalid,
  @JsonValue(134)
  errInvalidUserAccount,
  @JsonValue(157)
  errCertRaw,
  @JsonValue(158)
  errCertJsonPart,
  @JsonValue(159)
  errCertJsonInval,
  @JsonValue(160)
  errCertJsonNomem,
  @JsonValue(161)
  errCertCustom,
  @JsonValue(162)
  errCertCredential,
  @JsonValue(163)
  errCertSign,
  @JsonValue(164)
  errCertFail,
  @JsonValue(165)
  errCertBuf,
  @JsonValue(166)
  errCertNull,
  @JsonValue(167)
  errCertDuedate,
  @JsonValue(168)
  errCertRequest,
  @JsonValue(200)
  errPcmsendFormat,
  @JsonValue(201)
  errPcmsendBufferoverflow,
  @JsonValue(400)
  errLogoutOther,
  @JsonValue(401)
  errLogoutUser,
  @JsonValue(402)
  errLogoutNet,
  @JsonValue(403)
  errLogoutKicked,
  @JsonValue(404)
  errLogoutPacket,
  @JsonValue(405)
  errLogoutTokenExpired,
  @JsonValue(406)
  errLogoutOldversion,
  @JsonValue(407)
  errLogoutTokenWrong,
  @JsonValue(408)
  errLogoutAlreadyLogout,
  @JsonValue(420)
  errLoginOther,
  @JsonValue(421)
  errLoginNet,
  @JsonValue(422)
  errLoginFailed,
  @JsonValue(423)
  errLoginCanceled,
  @JsonValue(424)
  errLoginTokenExpired,
  @JsonValue(425)
  errLoginOldVersion,
  @JsonValue(426)
  errLoginTokenWrong,
  @JsonValue(427)
  errLoginTokenKicked,
  @JsonValue(428)
  errLoginAlreadyLogin,
  @JsonValue(440)
  errJoinChannelOther,
  @JsonValue(440)
  errSendMessageOther,
  @JsonValue(441)
  errSendMessageTimeout,
  @JsonValue(450)
  errQueryUsernumOther,
  @JsonValue(451)
  errQueryUsernumTimeout,
  @JsonValue(452)
  errQueryUsernumByuser,
  @JsonValue(460)
  errLeaveChannelOther,
  @JsonValue(461)
  errLeaveChannelKicked,
  @JsonValue(462)
  errLeaveChannelByuser,
  @JsonValue(463)
  errLeaveChannelLogout,
  @JsonValue(464)
  errLeaveChannelDisconnected,
  @JsonValue(470)
  errInviteOther,
  @JsonValue(471)
  errInviteReinvite,
  @JsonValue(472)
  errInviteNet,
  @JsonValue(473)
  errInvitePeerOffline,
  @JsonValue(474)
  errInviteTimeout,
  @JsonValue(475)
  errInviteCantRecv,
  @JsonValue(1001)
  errLoadMediaEngine,
  @JsonValue(1002)
  errStartCall,
  @JsonValue(1003)
  errStartCamera,
  @JsonValue(1004)
  errStartVideoRender,
  @JsonValue(1005)
  errAdmGeneralError,
  @JsonValue(1006)
  errAdmJavaResource,
  @JsonValue(1007)
  errAdmSampleRate,
  @JsonValue(1008)
  errAdmInitPlayout,
  @JsonValue(1009)
  errAdmStartPlayout,
  @JsonValue(1010)
  errAdmStopPlayout,
  @JsonValue(1011)
  errAdmInitRecording,
  @JsonValue(1012)
  errAdmStartRecording,
  @JsonValue(1013)
  errAdmStopRecording,
  @JsonValue(1015)
  errAdmRuntimePlayoutError,
  @JsonValue(1017)
  errAdmRuntimeRecordingError,
  @JsonValue(1018)
  errAdmRecordAudioFailed,
  @JsonValue(1022)
  errAdmInitLoopback,
  @JsonValue(1023)
  errAdmStartLoopback,
  @JsonValue(1027)
  errAdmNoPermission,
  @JsonValue(1033)
  errAdmRecordAudioIsActive,
  @JsonValue(1101)
  errAdmAndroidJniJavaResource,
  @JsonValue(1108)
  errAdmAndroidJniNoRecordFrequency,
  @JsonValue(1109)
  errAdmAndroidJniNoPlaybackFrequency,
  @JsonValue(1111)
  errAdmAndroidJniJavaStartRecord,
  @JsonValue(1112)
  errAdmAndroidJniJavaStartPlayback,
  @JsonValue(1115)
  errAdmAndroidJniJavaRecordError,
  @JsonValue(1151)
  errAdmAndroidOpenslCreateEngine,
  @JsonValue(1153)
  errAdmAndroidOpenslCreateAudioRecorder,
  @JsonValue(1156)
  errAdmAndroidOpenslStartRecorderThread,
  @JsonValue(1157)
  errAdmAndroidOpenslCreateAudioPlayer,
  @JsonValue(1160)
  errAdmAndroidOpenslStartPlayerThread,
  @JsonValue(1201)
  errAdmIosInputNotAvailable,
  @JsonValue(1206)
  errAdmIosActivateSessionFail,
  @JsonValue(1210)
  errAdmIosVpioInitFail,
  @JsonValue(1213)
  errAdmIosVpioReinitFail,
  @JsonValue(1214)
  errAdmIosVpioRestartFail,
  @JsonValue(1219)
  errAdmIosSetRenderCallbackFail,
  @JsonValue(1221)
  errAdmIosSessionSampleratrZero,
  @JsonValue(1301)
  errAdmWinCoreInit,
  @JsonValue(1303)
  errAdmWinCoreInitRecording,
  @JsonValue(1306)
  errAdmWinCoreInitPlayout,
  @JsonValue(1307)
  errAdmWinCoreInitPlayoutNull,
  @JsonValue(1309)
  errAdmWinCoreStartRecording,
  @JsonValue(1311)
  errAdmWinCoreCreateRecThread,
  @JsonValue(1314)
  errAdmWinCoreCaptureNotStartup,
  @JsonValue(1319)
  errAdmWinCoreCreateRenderThread,
  @JsonValue(1320)
  errAdmWinCoreRenderNotStartup,
  @JsonValue(1322)
  errAdmWinCoreNoRecordingDevice,
  @JsonValue(1323)
  errAdmWinCoreNoPlayoutDevice,
  @JsonValue(1351)
  errAdmWinWaveInit,
  @JsonValue(1353)
  errAdmWinWaveInitRecording,
  @JsonValue(1354)
  errAdmWinWaveInitMicrophone,
  @JsonValue(1355)
  errAdmWinWaveInitPlayout,
  @JsonValue(1356)
  errAdmWinWaveInitSpeaker,
  @JsonValue(1357)
  errAdmWinWaveStartRecording,
  @JsonValue(1358)
  errAdmWinWaveStartPlayout,
  @JsonValue(1359)
  errAdmNoRecordingDevice,
  @JsonValue(1360)
  errAdmNoPlayoutDevice,
  @JsonValue(1501)
  errVdmCameraNotAuthorized,
  @JsonValue(1502)
  errVdmWinDeviceInUse,
  @JsonValue(1600)
  errVcmUnknownError,
  @JsonValue(1601)
  errVcmEncoderInitError,
  @JsonValue(1602)
  errVcmEncoderEncodeError,
  @JsonValue(1603)
  errVcmEncoderSetError,
}

extension ErrorCodeTypeExt on ErrorCodeType {
  int value() {
    return _$ErrorCodeTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioSessionOperationRestriction {
  @JsonValue(0)
  audioSessionOperationRestrictionNone,
  @JsonValue(1)
  audioSessionOperationRestrictionSetCategory,
  @JsonValue(1 << 1)
  audioSessionOperationRestrictionConfigureSession,
  @JsonValue(1 << 2)
  audioSessionOperationRestrictionDeactivateSession,
  @JsonValue(1 << 7)
  audioSessionOperationRestrictionAll,
}

extension AudioSessionOperationRestrictionExt
    on AudioSessionOperationRestriction {
  int value() {
    return _$AudioSessionOperationRestrictionEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum UserOfflineReasonType {
  @JsonValue(0)
  userOfflineQuit,
  @JsonValue(1)
  userOfflineDropped,
  @JsonValue(2)
  userOfflineBecomeAudience,
}

extension UserOfflineReasonTypeExt on UserOfflineReasonType {
  int value() {
    return _$UserOfflineReasonTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum InterfaceIdType {
  @JsonValue(1)
  agoraIidAudioDeviceManager,
  @JsonValue(2)
  agoraIidVideoDeviceManager,
  @JsonValue(3)
  agoraIidParameterEngine,
  @JsonValue(4)
  agoraIidMediaEngine,
  @JsonValue(5)
  agoraIidAudioEngine,
  @JsonValue(6)
  agoraIidVideoEngine,
  @JsonValue(7)
  agoraIidRtcConnection,
  @JsonValue(8)
  agoraIidSignalingEngine,
  @JsonValue(9)
  agoraIidMediaEngineRegulator,
  @JsonValue(10)
  agoraIidCloudSpatialAudio,
  @JsonValue(11)
  agoraIidLocalSpatialAudio,
}

extension InterfaceIdTypeExt on InterfaceIdType {
  int value() {
    return _$InterfaceIdTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum QualityType {
  @JsonValue(0)
  qualityUnknown,
  @JsonValue(1)
  qualityExcellent,
  @JsonValue(2)
  qualityGood,
  @JsonValue(3)
  qualityPoor,
  @JsonValue(4)
  qualityBad,
  @JsonValue(5)
  qualityVbad,
  @JsonValue(6)
  qualityDown,
  @JsonValue(7)
  qualityUnsupported,
  @JsonValue(8)
  qualityDetecting,
}

extension QualityTypeExt on QualityType {
  int value() {
    return _$QualityTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum FitModeType {
  @JsonValue(1)
  modeCover,
  @JsonValue(2)
  modeContain,
}

extension FitModeTypeExt on FitModeType {
  int value() {
    return _$FitModeTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoOrientation {
  @JsonValue(0)
  videoOrientation0,
  @JsonValue(90)
  videoOrientation90,
  @JsonValue(180)
  videoOrientation180,
  @JsonValue(270)
  videoOrientation270,
}

extension VideoOrientationExt on VideoOrientation {
  int value() {
    return _$VideoOrientationEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum FrameRate {
  @JsonValue(1)
  frameRateFps1,
  @JsonValue(7)
  frameRateFps7,
  @JsonValue(10)
  frameRateFps10,
  @JsonValue(15)
  frameRateFps15,
  @JsonValue(24)
  frameRateFps24,
  @JsonValue(30)
  frameRateFps30,
  @JsonValue(60)
  frameRateFps60,
}

extension FrameRateExt on FrameRate {
  int value() {
    return _$FrameRateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum FrameWidth {
  @JsonValue(640)
  frameWidth640,
}

extension FrameWidthExt on FrameWidth {
  int value() {
    return _$FrameWidthEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum FrameHeight {
  @JsonValue(360)
  frameHeight360,
}

extension FrameHeightExt on FrameHeight {
  int value() {
    return _$FrameHeightEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoFrameType {
  @JsonValue(0)
  videoFrameTypeBlankFrame,
  @JsonValue(3)
  videoFrameTypeKeyFrame,
  @JsonValue(4)
  videoFrameTypeDeltaFrame,
  @JsonValue(5)
  videoFrameTypeBFrame,
  @JsonValue(6)
  videoFrameTypeDroppableFrame,
  @JsonValue(7)
  videoFrameTypeUnknow,
}

extension VideoFrameTypeExt on VideoFrameType {
  int value() {
    return _$VideoFrameTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum OrientationMode {
  @JsonValue(0)
  orientationModeAdaptive,
  @JsonValue(1)
  orientationModeFixedLandscape,
  @JsonValue(2)
  orientationModeFixedPortrait,
}

extension OrientationModeExt on OrientationMode {
  int value() {
    return _$OrientationModeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum DegradationPreference {
  @JsonValue(0)
  maintainQuality,
  @JsonValue(1)
  maintainFramerate,
  @JsonValue(2)
  maintainBalanced,
  @JsonValue(3)
  maintainResolution,
  @JsonValue(100)
  disabled,
}

extension DegradationPreferenceExt on DegradationPreference {
  int value() {
    return _$DegradationPreferenceEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoDimensions {
  const VideoDimensions({this.width, this.height});

  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDimensionsToJson(this);
}

const standardBitrate = 0;

const compatibleBitrate = -1;

const defaultMinBitrate = -1;

const defaultMinBitrateEqualToTargetBitrate = -2;

@JsonEnum(alwaysCreate: true)
enum VideoCodecType {
  @JsonValue(0)
  videoCodecNone,
  @JsonValue(1)
  videoCodecVp8,
  @JsonValue(2)
  videoCodecH264,
  @JsonValue(3)
  videoCodecH265,
  @JsonValue(5)
  videoCodecVp9,
  @JsonValue(6)
  videoCodecGeneric,
  @JsonValue(7)
  videoCodecGenericH264,
  @JsonValue(12)
  videoCodecAv1,
  @JsonValue(20)
  videoCodecGenericJpeg,
}

extension VideoCodecTypeExt on VideoCodecType {
  int value() {
    return _$VideoCodecTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum TCcMode {
  @JsonValue(0)
  ccEnabled,
  @JsonValue(1)
  ccDisabled,
}

extension TCcModeExt on TCcMode {
  int value() {
    return _$TCcModeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class SenderOptions {
  const SenderOptions({this.ccMode, this.codecType, this.targetBitrate});

  @JsonKey(name: 'ccMode')
  final TCcMode? ccMode;
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;
  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;
  factory SenderOptions.fromJson(Map<String, dynamic> json) =>
      _$SenderOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$SenderOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioCodecType {
  @JsonValue(1)
  audioCodecOpus,
  @JsonValue(3)
  audioCodecPcma,
  @JsonValue(4)
  audioCodecPcmu,
  @JsonValue(5)
  audioCodecG722,
  @JsonValue(8)
  audioCodecAaclc,
  @JsonValue(9)
  audioCodecHeaac,
  @JsonValue(10)
  audioCodecJc1,
  @JsonValue(11)
  audioCodecHeaac2,
  @JsonValue(12)
  audioCodecLpcnet,
}

extension AudioCodecTypeExt on AudioCodecType {
  int value() {
    return _$AudioCodecTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioEncodingType {
  @JsonValue(0x010101)
  audioEncodingTypeAac16000Low,
  @JsonValue(0x010102)
  audioEncodingTypeAac16000Medium,
  @JsonValue(0x010201)
  audioEncodingTypeAac32000Low,
  @JsonValue(0x010202)
  audioEncodingTypeAac32000Medium,
  @JsonValue(0x010203)
  audioEncodingTypeAac32000High,
  @JsonValue(0x010302)
  audioEncodingTypeAac48000Medium,
  @JsonValue(0x010303)
  audioEncodingTypeAac48000High,
  @JsonValue(0x020101)
  audioEncodingTypeOpus16000Low,
  @JsonValue(0x020102)
  audioEncodingTypeOpus16000Medium,
  @JsonValue(0x020302)
  audioEncodingTypeOpus48000Medium,
  @JsonValue(0x020303)
  audioEncodingTypeOpus48000High,
}

extension AudioEncodingTypeExt on AudioEncodingType {
  int value() {
    return _$AudioEncodingTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum WatermarkFitMode {
  @JsonValue(0)
  fitModeCoverPosition,
  @JsonValue(1)
  fitModeUseImageRatio,
}

extension WatermarkFitModeExt on WatermarkFitMode {
  int value() {
    return _$WatermarkFitModeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class EncodedAudioFrameAdvancedSettings {
  const EncodedAudioFrameAdvancedSettings({this.speech, this.sendEvenIfEmpty});

  @JsonKey(name: 'speech')
  final bool? speech;
  @JsonKey(name: 'sendEvenIfEmpty')
  final bool? sendEvenIfEmpty;
  factory EncodedAudioFrameAdvancedSettings.fromJson(
          Map<String, dynamic> json) =>
      _$EncodedAudioFrameAdvancedSettingsFromJson(json);
  Map<String, dynamic> toJson() =>
      _$EncodedAudioFrameAdvancedSettingsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EncodedAudioFrameInfo {
  const EncodedAudioFrameInfo(
      {this.codec,
      this.sampleRateHz,
      this.samplesPerChannel,
      this.numberOfChannels,
      this.advancedSettings});

  @JsonKey(name: 'codec')
  final AudioCodecType? codec;
  @JsonKey(name: 'sampleRateHz')
  final int? sampleRateHz;
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;
  @JsonKey(name: 'numberOfChannels')
  final int? numberOfChannels;
  @JsonKey(name: 'advancedSettings')
  final EncodedAudioFrameAdvancedSettings? advancedSettings;
  factory EncodedAudioFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedAudioFrameInfoFromJson(json);
  Map<String, dynamic> toJson() => _$EncodedAudioFrameInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AudioPcmDataInfo {
  const AudioPcmDataInfo(
      {this.samplesPerChannel,
      this.channelNum,
      this.samplesOut,
      this.elapsedTimeMs,
      this.ntpTimeMs});

  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;
  @JsonKey(name: 'channelNum')
  final int? channelNum;
  @JsonKey(name: 'samplesOut')
  final int? samplesOut;
  @JsonKey(name: 'elapsedTimeMs')
  final int? elapsedTimeMs;
  @JsonKey(name: 'ntpTimeMs')
  final int? ntpTimeMs;
  factory AudioPcmDataInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmDataInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioPcmDataInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum H264PacketizeMode {
  @JsonValue(0)
  nonInterleaved,
  @JsonValue(1)
  singleNalUnit,
}

extension H264PacketizeModeExt on H264PacketizeMode {
  int value() {
    return _$H264PacketizeModeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoStreamType {
  @JsonValue(0)
  videoStreamHigh,
  @JsonValue(1)
  videoStreamLow,
}

extension VideoStreamTypeExt on VideoStreamType {
  int value() {
    return _$VideoStreamTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class EncodedVideoFrameInfo {
  const EncodedVideoFrameInfo(
      {this.codecType,
      this.width,
      this.height,
      this.framesPerSecond,
      this.frameType,
      this.rotation,
      this.trackId,
      this.renderTimeMs,
      this.internalSendTs,
      this.uid,
      this.streamType});

  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'framesPerSecond')
  final int? framesPerSecond;
  @JsonKey(name: 'frameType')
  final VideoFrameType? frameType;
  @JsonKey(name: 'rotation')
  final VideoOrientation? rotation;
  @JsonKey(name: 'trackId')
  final int? trackId;
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;
  @JsonKey(name: 'internalSendTs')
  final int? internalSendTs;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;
  factory EncodedVideoFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedVideoFrameInfoFromJson(json);
  Map<String, dynamic> toJson() => _$EncodedVideoFrameInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoMirrorModeType {
  @JsonValue(0)
  videoMirrorModeAuto,
  @JsonValue(1)
  videoMirrorModeEnabled,
  @JsonValue(2)
  videoMirrorModeDisabled,
}

extension VideoMirrorModeTypeExt on VideoMirrorModeType {
  int value() {
    return _$VideoMirrorModeTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoEncoderConfiguration {
  const VideoEncoderConfiguration(
      {this.codecType,
      this.dimensions,
      this.frameRate,
      this.bitrate,
      this.minBitrate,
      this.orientationMode,
      this.degradationPreference,
      this.mirrorMode});

  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;
  @JsonKey(name: 'frameRate')
  final int? frameRate;
  @JsonKey(name: 'bitrate')
  final int? bitrate;
  @JsonKey(name: 'minBitrate')
  final int? minBitrate;
  @JsonKey(name: 'orientationMode')
  final OrientationMode? orientationMode;
  @JsonKey(name: 'degradationPreference')
  final DegradationPreference? degradationPreference;
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataStreamConfig {
  const DataStreamConfig({this.syncWithAudio, this.ordered});

  @JsonKey(name: 'syncWithAudio')
  final bool? syncWithAudio;
  @JsonKey(name: 'ordered')
  final bool? ordered;
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SimulcastStreamConfig {
  const SimulcastStreamConfig({this.dimensions, this.bitrate, this.framerate});

  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;
  @JsonKey(name: 'bitrate')
  final int? bitrate;
  @JsonKey(name: 'framerate')
  final int? framerate;
  factory SimulcastStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$SimulcastStreamConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SimulcastStreamConfigToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Rectangle {
  const Rectangle({this.x, this.y, this.width, this.height});

  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WatermarkRatio {
  const WatermarkRatio({this.xRatio, this.yRatio, this.widthRatio});

  @JsonKey(name: 'xRatio')
  final double? xRatio;
  @JsonKey(name: 'yRatio')
  final double? yRatio;
  @JsonKey(name: 'widthRatio')
  final double? widthRatio;
  factory WatermarkRatio.fromJson(Map<String, dynamic> json) =>
      _$WatermarkRatioFromJson(json);
  Map<String, dynamic> toJson() => _$WatermarkRatioToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WatermarkOptions {
  const WatermarkOptions(
      {this.visibleInPreview,
      this.positionInLandscapeMode,
      this.positionInPortraitMode,
      this.watermarkRatio,
      this.mode});

  @JsonKey(name: 'visibleInPreview')
  final bool? visibleInPreview;
  @JsonKey(name: 'positionInLandscapeMode')
  final Rectangle? positionInLandscapeMode;
  @JsonKey(name: 'positionInPortraitMode')
  final Rectangle? positionInPortraitMode;
  @JsonKey(name: 'watermarkRatio')
  final WatermarkRatio? watermarkRatio;
  @JsonKey(name: 'mode')
  final WatermarkFitMode? mode;
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcStats {
  const RtcStats(
      {this.duration,
      this.txBytes,
      this.rxBytes,
      this.txAudioBytes,
      this.txVideoBytes,
      this.rxAudioBytes,
      this.rxVideoBytes,
      this.txKBitRate,
      this.rxKBitRate,
      this.rxAudioKBitRate,
      this.txAudioKBitRate,
      this.rxVideoKBitRate,
      this.txVideoKBitRate,
      this.lastmileDelay,
      this.userCount,
      this.cpuAppUsage,
      this.cpuTotalUsage,
      this.gatewayRtt,
      this.memoryAppUsageRatio,
      this.memoryTotalUsageRatio,
      this.memoryAppUsageInKbytes,
      this.connectTimeMs,
      this.firstAudioPacketDuration,
      this.firstVideoPacketDuration,
      this.firstVideoKeyFramePacketDuration,
      this.packetsBeforeFirstKeyFramePacket,
      this.firstAudioPacketDurationAfterUnmute,
      this.firstVideoPacketDurationAfterUnmute,
      this.firstVideoKeyFramePacketDurationAfterUnmute,
      this.firstVideoKeyFrameDecodedDurationAfterUnmute,
      this.firstVideoKeyFrameRenderedDurationAfterUnmute,
      this.txPacketLossRate,
      this.rxPacketLossRate});

  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'txBytes')
  final int? txBytes;
  @JsonKey(name: 'rxBytes')
  final int? rxBytes;
  @JsonKey(name: 'txAudioBytes')
  final int? txAudioBytes;
  @JsonKey(name: 'txVideoBytes')
  final int? txVideoBytes;
  @JsonKey(name: 'rxAudioBytes')
  final int? rxAudioBytes;
  @JsonKey(name: 'rxVideoBytes')
  final int? rxVideoBytes;
  @JsonKey(name: 'txKBitRate')
  final int? txKBitRate;
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;
  @JsonKey(name: 'rxAudioKBitRate')
  final int? rxAudioKBitRate;
  @JsonKey(name: 'txAudioKBitRate')
  final int? txAudioKBitRate;
  @JsonKey(name: 'rxVideoKBitRate')
  final int? rxVideoKBitRate;
  @JsonKey(name: 'txVideoKBitRate')
  final int? txVideoKBitRate;
  @JsonKey(name: 'lastmileDelay')
  final int? lastmileDelay;
  @JsonKey(name: 'userCount')
  final int? userCount;
  @JsonKey(name: 'cpuAppUsage')
  final double? cpuAppUsage;
  @JsonKey(name: 'cpuTotalUsage')
  final double? cpuTotalUsage;
  @JsonKey(name: 'gatewayRtt')
  final int? gatewayRtt;
  @JsonKey(name: 'memoryAppUsageRatio')
  final double? memoryAppUsageRatio;
  @JsonKey(name: 'memoryTotalUsageRatio')
  final double? memoryTotalUsageRatio;
  @JsonKey(name: 'memoryAppUsageInKbytes')
  final int? memoryAppUsageInKbytes;
  @JsonKey(name: 'connectTimeMs')
  final int? connectTimeMs;
  @JsonKey(name: 'firstAudioPacketDuration')
  final int? firstAudioPacketDuration;
  @JsonKey(name: 'firstVideoPacketDuration')
  final int? firstVideoPacketDuration;
  @JsonKey(name: 'firstVideoKeyFramePacketDuration')
  final int? firstVideoKeyFramePacketDuration;
  @JsonKey(name: 'packetsBeforeFirstKeyFramePacket')
  final int? packetsBeforeFirstKeyFramePacket;
  @JsonKey(name: 'firstAudioPacketDurationAfterUnmute')
  final int? firstAudioPacketDurationAfterUnmute;
  @JsonKey(name: 'firstVideoPacketDurationAfterUnmute')
  final int? firstVideoPacketDurationAfterUnmute;
  @JsonKey(name: 'firstVideoKeyFramePacketDurationAfterUnmute')
  final int? firstVideoKeyFramePacketDurationAfterUnmute;
  @JsonKey(name: 'firstVideoKeyFrameDecodedDurationAfterUnmute')
  final int? firstVideoKeyFrameDecodedDurationAfterUnmute;
  @JsonKey(name: 'firstVideoKeyFrameRenderedDurationAfterUnmute')
  final int? firstVideoKeyFrameRenderedDurationAfterUnmute;
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;
  @JsonKey(name: 'rxPacketLossRate')
  final int? rxPacketLossRate;
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoSourceType {
  @JsonValue(0)
  videoSourceCameraPrimary,
  @JsonValue(0)
  videoSourceCamera,
  @JsonValue(1)
  videoSourceCameraSecondary,
  @JsonValue(2)
  videoSourceScreenPrimary,
  @JsonValue(2)
  videoSourceScreen,
  @JsonValue(3)
  videoSourceScreenSecondary,
  @JsonValue(4)
  videoSourceCustom,
  @JsonValue(5)
  videoSourceMediaPlayer,
  @JsonValue(6)
  videoSourceRtcImagePng,
  @JsonValue(7)
  videoSourceRtcImageJpeg,
  @JsonValue(8)
  videoSourceRtcImageGif,
  @JsonValue(9)
  videoSourceRemote,
  @JsonValue(10)
  videoSourceTranscoded,
  @JsonValue(100)
  videoSourceUnknown,
}

extension VideoSourceTypeExt on VideoSourceType {
  int value() {
    return _$VideoSourceTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ClientRoleType {
  @JsonValue(1)
  clientRoleBroadcaster,
  @JsonValue(2)
  clientRoleAudience,
}

extension ClientRoleTypeExt on ClientRoleType {
  int value() {
    return _$ClientRoleTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum QualityAdaptIndication {
  @JsonValue(0)
  adaptNone,
  @JsonValue(1)
  adaptUpBandwidth,
  @JsonValue(2)
  adaptDownBandwidth,
}

extension QualityAdaptIndicationExt on QualityAdaptIndication {
  int value() {
    return _$QualityAdaptIndicationEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudienceLatencyLevelType {
  @JsonValue(1)
  audienceLatencyLevelLowLatency,
  @JsonValue(2)
  audienceLatencyLevelUltraLowLatency,
  @JsonValue(3)
  audienceLatencyLevelHighLatency,
}

extension AudienceLatencyLevelTypeExt on AudienceLatencyLevelType {
  int value() {
    return _$AudienceLatencyLevelTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class ClientRoleOptions {
  const ClientRoleOptions({this.audienceLatencyLevel});

  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;
  factory ClientRoleOptions.fromJson(Map<String, dynamic> json) =>
      _$ClientRoleOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ClientRoleOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ExperienceQualityType {
  @JsonValue(0)
  experienceQualityGood,
  @JsonValue(1)
  experienceQualityBad,
}

extension ExperienceQualityTypeExt on ExperienceQualityType {
  int value() {
    return _$ExperienceQualityTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class RemoteAudioStats {
  const RemoteAudioStats(
      {this.uid,
      this.quality,
      this.networkTransportDelay,
      this.jitterBufferDelay,
      this.audioLossRate,
      this.numChannels,
      this.receivedSampleRate,
      this.receivedBitrate,
      this.totalFrozenTime,
      this.frozenRate,
      this.mosValue,
      this.totalActiveTime,
      this.publishDuration,
      this.qoeQuality});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'quality')
  final int? quality;
  @JsonKey(name: 'networkTransportDelay')
  final int? networkTransportDelay;
  @JsonKey(name: 'jitterBufferDelay')
  final int? jitterBufferDelay;
  @JsonKey(name: 'audioLossRate')
  final int? audioLossRate;
  @JsonKey(name: 'numChannels')
  final int? numChannels;
  @JsonKey(name: 'receivedSampleRate')
  final int? receivedSampleRate;
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;
  @JsonKey(name: 'mosValue')
  final int? mosValue;
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;
  @JsonKey(name: 'qoeQuality')
  final int? qoeQuality;
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioProfileType {
  @JsonValue(0)
  audioProfileDefault,
  @JsonValue(1)
  audioProfileSpeechStandard,
  @JsonValue(2)
  audioProfileMusicStandard,
  @JsonValue(3)
  audioProfileMusicStandardStereo,
  @JsonValue(4)
  audioProfileMusicHighQuality,
  @JsonValue(5)
  audioProfileMusicHighQualityStereo,
  @JsonValue(6)
  audioProfileIot,
  @JsonValue(7)
  audioProfileNum,
}

extension AudioProfileTypeExt on AudioProfileType {
  int value() {
    return _$AudioProfileTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioScenarioType {
  @JsonValue(0)
  audioScenarioDefault,
  @JsonValue(3)
  audioScenarioGameStreaming,
  @JsonValue(5)
  audioScenarioChatroom,
  @JsonValue(6)
  audioScenarioHighDefinition,
  @JsonValue(7)
  audioScenarioChorus,
  @JsonValue(8)
  audioScenarioNum,
}

extension AudioScenarioTypeExt on AudioScenarioType {
  int value() {
    return _$AudioScenarioTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFormat {
  const VideoFormat({this.width, this.height, this.fps});

  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'fps')
  final int? fps;
  factory VideoFormat.fromJson(Map<String, dynamic> json) =>
      _$VideoFormatFromJson(json);
  Map<String, dynamic> toJson() => _$VideoFormatToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoFormatEnum {
  @JsonValue(3840)
  kMaxWidthInPixels,
  @JsonValue(2160)
  kMaxHeightInPixels,
  @JsonValue(60)
  kMaxFps,
}

extension VideoFormatEnumExt on VideoFormatEnum {
  int value() {
    return _$VideoFormatEnumEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoContentHint {
  @JsonValue(0)
  contentHintNone,
  @JsonValue(1)
  contentHintMotion,
  @JsonValue(2)
  contentHintDetails,
}

extension VideoContentHintExt on VideoContentHint {
  int value() {
    return _$VideoContentHintEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamState {
  @JsonValue(0)
  localAudioStreamStateStopped,
  @JsonValue(1)
  localAudioStreamStateRecording,
  @JsonValue(2)
  localAudioStreamStateEncoding,
  @JsonValue(3)
  localAudioStreamStateFailed,
}

extension LocalAudioStreamStateExt on LocalAudioStreamState {
  int value() {
    return _$LocalAudioStreamStateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamError {
  @JsonValue(0)
  localAudioStreamErrorOk,
  @JsonValue(1)
  localAudioStreamErrorFailure,
  @JsonValue(2)
  localAudioStreamErrorDeviceNoPermission,
  @JsonValue(3)
  localAudioStreamErrorDeviceBusy,
  @JsonValue(4)
  localAudioStreamErrorRecordFailure,
  @JsonValue(5)
  localAudioStreamErrorEncodeFailure,
}

extension LocalAudioStreamErrorExt on LocalAudioStreamError {
  int value() {
    return _$LocalAudioStreamErrorEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamState {
  @JsonValue(0)
  localVideoStreamStateStopped,
  @JsonValue(1)
  localVideoStreamStateCapturing,
  @JsonValue(2)
  localVideoStreamStateEncoding,
  @JsonValue(3)
  localVideoStreamStateFailed,
}

extension LocalVideoStreamStateExt on LocalVideoStreamState {
  int value() {
    return _$LocalVideoStreamStateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamError {
  @JsonValue(0)
  localVideoStreamErrorOk,
  @JsonValue(1)
  localVideoStreamErrorFailure,
  @JsonValue(2)
  localVideoStreamErrorDeviceNoPermission,
  @JsonValue(3)
  localVideoStreamErrorDeviceBusy,
  @JsonValue(4)
  localVideoStreamErrorCaptureFailure,
  @JsonValue(5)
  localVideoStreamErrorEncodeFailure,
  @JsonValue(6)
  localVideoStreamErrorCaptureInbackground,
  @JsonValue(7)
  localVideoStreamErrorCaptureMultipleForegroundApps,
  @JsonValue(8)
  localVideoStreamErrorDeviceNotFound,
  @JsonValue(9)
  localVideoStreamErrorDeviceDisconnected,
  @JsonValue(10)
  localVideoStreamErrorDeviceInvalidId,
  @JsonValue(101)
  localVideoStreamErrorDeviceSystemPressure,
  @JsonValue(11)
  localVideoStreamErrorScreenCaptureWindowMinimized,
  @JsonValue(12)
  localVideoStreamErrorScreenCaptureWindowClosed,
  @JsonValue(13)
  localVideoStreamErrorScreenCaptureWindowOccluded,
  @JsonValue(20)
  localVideoStreamErrorScreenCaptureWindowNotSupported,
}

extension LocalVideoStreamErrorExt on LocalVideoStreamError {
  int value() {
    return _$LocalVideoStreamErrorEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RemoteAudioState {
  @JsonValue(0)
  remoteAudioStateStopped,
  @JsonValue(1)
  remoteAudioStateStarting,
  @JsonValue(2)
  remoteAudioStateDecoding,
  @JsonValue(3)
  remoteAudioStateFrozen,
  @JsonValue(4)
  remoteAudioStateFailed,
}

extension RemoteAudioStateExt on RemoteAudioState {
  int value() {
    return _$RemoteAudioStateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RemoteAudioStateReason {
  @JsonValue(0)
  remoteAudioReasonInternal,
  @JsonValue(1)
  remoteAudioReasonNetworkCongestion,
  @JsonValue(2)
  remoteAudioReasonNetworkRecovery,
  @JsonValue(3)
  remoteAudioReasonLocalMuted,
  @JsonValue(4)
  remoteAudioReasonLocalUnmuted,
  @JsonValue(5)
  remoteAudioReasonRemoteMuted,
  @JsonValue(6)
  remoteAudioReasonRemoteUnmuted,
  @JsonValue(7)
  remoteAudioReasonRemoteOffline,
}

extension RemoteAudioStateReasonExt on RemoteAudioStateReason {
  int value() {
    return _$RemoteAudioStateReasonEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RemoteVideoState {
  @JsonValue(0)
  remoteVideoStateStopped,
  @JsonValue(1)
  remoteVideoStateStarting,
  @JsonValue(2)
  remoteVideoStateDecoding,
  @JsonValue(3)
  remoteVideoStateFrozen,
  @JsonValue(4)
  remoteVideoStateFailed,
}

extension RemoteVideoStateExt on RemoteVideoState {
  int value() {
    return _$RemoteVideoStateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RemoteVideoStateReason {
  @JsonValue(0)
  remoteVideoStateReasonInternal,
  @JsonValue(1)
  remoteVideoStateReasonNetworkCongestion,
  @JsonValue(2)
  remoteVideoStateReasonNetworkRecovery,
  @JsonValue(3)
  remoteVideoStateReasonLocalMuted,
  @JsonValue(4)
  remoteVideoStateReasonLocalUnmuted,
  @JsonValue(5)
  remoteVideoStateReasonRemoteMuted,
  @JsonValue(6)
  remoteVideoStateReasonRemoteUnmuted,
  @JsonValue(7)
  remoteVideoStateReasonRemoteOffline,
  @JsonValue(8)
  remoteVideoStateReasonAudioFallback,
  @JsonValue(9)
  remoteVideoStateReasonAudioFallbackRecovery,
  @JsonValue(10)
  remoteVideoStateReasonVideoStreamTypeChangeToLow,
  @JsonValue(11)
  remoteVideoStateReasonVideoStreamTypeChangeToHigh,
}

extension RemoteVideoStateReasonExt on RemoteVideoStateReason {
  int value() {
    return _$RemoteVideoStateReasonEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RemoteUserState {
  @JsonValue((1 << 0))
  userStateMuteAudio,
  @JsonValue((1 << 1))
  userStateMuteVideo,
  @JsonValue((1 << 4))
  userStateEnableVideo,
  @JsonValue((1 << 8))
  userStateEnableLocalVideo,
}

extension RemoteUserStateExt on RemoteUserState {
  int value() {
    return _$RemoteUserStateEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoTrackInfo {
  const VideoTrackInfo(
      {this.isLocal,
      this.ownerUid,
      this.trackId,
      this.channelId,
      this.streamType,
      this.codecType,
      this.encodedFrameOnly,
      this.sourceType,
      this.observationPosition});

  @JsonKey(name: 'isLocal')
  final bool? isLocal;
  @JsonKey(name: 'ownerUid')
  final int? ownerUid;
  @JsonKey(name: 'trackId')
  final int? trackId;
  @JsonKey(name: 'channelId')
  final String? channelId;
  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;
  @JsonKey(name: 'encodedFrameOnly')
  final bool? encodedFrameOnly;
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;
  @JsonKey(name: 'observationPosition')
  final int? observationPosition;
  factory VideoTrackInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoTrackInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoTrackInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RemoteVideoDownscaleLevel {
  @JsonValue(0)
  remoteVideoDownscaleLevelNone,
  @JsonValue(1)
  remoteVideoDownscaleLevel1,
  @JsonValue(2)
  remoteVideoDownscaleLevel2,
  @JsonValue(3)
  remoteVideoDownscaleLevel3,
  @JsonValue(4)
  remoteVideoDownscaleLevel4,
}

extension RemoteVideoDownscaleLevelExt on RemoteVideoDownscaleLevel {
  int value() {
    return _$RemoteVideoDownscaleLevelEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioVolumeInfo {
  const AudioVolumeInfo({this.uid, this.volume, this.vad, this.voicePitch});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'volume')
  final int? volume;
  @JsonKey(name: 'vad')
  final int? vad;
  @JsonKey(name: 'voicePitch')
  final double? voicePitch;
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeviceInfo {
  const DeviceInfo({this.isLowLatencyAudioSupported});

  @JsonKey(name: 'isLowLatencyAudioSupported')
  final bool? isLowLatencyAudioSupported;
  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Packet {
  const Packet({this.buffer, this.size});

  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;
  @JsonKey(name: 'size')
  final int? size;
  factory Packet.fromJson(Map<String, dynamic> json) => _$PacketFromJson(json);
  Map<String, dynamic> toJson() => _$PacketToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioSampleRateType {
  @JsonValue(32000)
  audioSampleRate32000,
  @JsonValue(44100)
  audioSampleRate44100,
  @JsonValue(48000)
  audioSampleRate48000,
}

extension AudioSampleRateTypeExt on AudioSampleRateType {
  int value() {
    return _$AudioSampleRateTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoCodecTypeForStream {
  @JsonValue(1)
  videoCodecH264ForStream,
  @JsonValue(2)
  videoCodecH265ForStream,
}

extension VideoCodecTypeForStreamExt on VideoCodecTypeForStream {
  int value() {
    return _$VideoCodecTypeForStreamEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoCodecProfileType {
  @JsonValue(66)
  videoCodecProfileBaseline,
  @JsonValue(77)
  videoCodecProfileMain,
  @JsonValue(100)
  videoCodecProfileHigh,
}

extension VideoCodecProfileTypeExt on VideoCodecProfileType {
  int value() {
    return _$VideoCodecProfileTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioCodecProfileType {
  @JsonValue(0)
  audioCodecProfileLcAac,
  @JsonValue(1)
  audioCodecProfileHeAac,
  @JsonValue(2)
  audioCodecProfileHeAacV2,
}

extension AudioCodecProfileTypeExt on AudioCodecProfileType {
  int value() {
    return _$AudioCodecProfileTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class LocalAudioStats {
  const LocalAudioStats(
      {this.numChannels,
      this.sentSampleRate,
      this.sentBitrate,
      this.internalCodec,
      this.txPacketLossRate});

  @JsonKey(name: 'numChannels')
  final int? numChannels;
  @JsonKey(name: 'sentSampleRate')
  final int? sentSampleRate;
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;
  @JsonKey(name: 'internalCodec')
  final int? internalCodec;
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishState {
  @JsonValue(0)
  rtmpStreamPublishStateIdle,
  @JsonValue(1)
  rtmpStreamPublishStateConnecting,
  @JsonValue(2)
  rtmpStreamPublishStateRunning,
  @JsonValue(3)
  rtmpStreamPublishStateRecovering,
  @JsonValue(4)
  rtmpStreamPublishStateFailure,
  @JsonValue(5)
  rtmpStreamPublishStateDisconnecting,
}

extension RtmpStreamPublishStateExt on RtmpStreamPublishState {
  int value() {
    return _$RtmpStreamPublishStateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishErrorType {
  @JsonValue(0)
  rtmpStreamPublishErrorOk,
  @JsonValue(1)
  rtmpStreamPublishErrorInvalidArgument,
  @JsonValue(2)
  rtmpStreamPublishErrorEncryptedStreamNotAllowed,
  @JsonValue(3)
  rtmpStreamPublishErrorConnectionTimeout,
  @JsonValue(4)
  rtmpStreamPublishErrorInternalServerError,
  @JsonValue(5)
  rtmpStreamPublishErrorRtmpServerError,
  @JsonValue(6)
  rtmpStreamPublishErrorTooOften,
  @JsonValue(7)
  rtmpStreamPublishErrorReachLimit,
  @JsonValue(8)
  rtmpStreamPublishErrorNotAuthorized,
  @JsonValue(9)
  rtmpStreamPublishErrorStreamNotFound,
  @JsonValue(10)
  rtmpStreamPublishErrorFormatNotSupported,
  @JsonValue(11)
  rtmpStreamPublishErrorNotBroadcaster,
  @JsonValue(13)
  rtmpStreamPublishErrorTranscodingNoMixStream,
  @JsonValue(14)
  rtmpStreamPublishErrorNetDown,
  @JsonValue(15)
  rtmpStreamPublishErrorInvalidAppid,
  @JsonValue(100)
  rtmpStreamUnpublishErrorOk,
}

extension RtmpStreamPublishErrorTypeExt on RtmpStreamPublishErrorType {
  int value() {
    return _$RtmpStreamPublishErrorTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum RtmpStreamingEvent {
  @JsonValue(1)
  rtmpStreamingEventFailedLoadImage,
  @JsonValue(2)
  rtmpStreamingEventUrlAlreadyInUse,
  @JsonValue(3)
  rtmpStreamingEventAdvancedFeatureNotSupport,
  @JsonValue(4)
  rtmpStreamingEventRequestTooOften,
}

extension RtmpStreamingEventExt on RtmpStreamingEvent {
  int value() {
    return _$RtmpStreamingEventEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcImage {
  const RtcImage(
      {this.url,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha});

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'zOrder')
  final int? zOrder;
  @JsonKey(name: 'alpha')
  final double? alpha;
  factory RtcImage.fromJson(Map<String, dynamic> json) =>
      _$RtcImageFromJson(json);
  Map<String, dynamic> toJson() => _$RtcImageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveStreamAdvancedFeature {
  const LiveStreamAdvancedFeature({this.featureName, this.opened});

  @JsonKey(name: 'featureName')
  final String? featureName;
  @JsonKey(name: 'opened')
  final bool? opened;
  factory LiveStreamAdvancedFeature.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamAdvancedFeatureFromJson(json);
  Map<String, dynamic> toJson() => _$LiveStreamAdvancedFeatureToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ConnectionStateType {
  @JsonValue(1)
  connectionStateDisconnected,
  @JsonValue(2)
  connectionStateConnecting,
  @JsonValue(3)
  connectionStateConnected,
  @JsonValue(4)
  connectionStateReconnecting,
  @JsonValue(5)
  connectionStateFailed,
}

extension ConnectionStateTypeExt on ConnectionStateType {
  int value() {
    return _$ConnectionStateTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class TranscodingUser {
  const TranscodingUser(
      {this.uid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.audioChannel});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'zOrder')
  final int? zOrder;
  @JsonKey(name: 'alpha')
  final double? alpha;
  @JsonKey(name: 'audioChannel')
  final int? audioChannel;
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveTranscoding {
  const LiveTranscoding(
      {this.width,
      this.height,
      this.videoBitrate,
      this.videoFramerate,
      this.lowLatency,
      this.videoGop,
      this.videoCodecProfile,
      this.backgroundColor,
      this.videoCodecType,
      this.userCount,
      this.transcodingUsers,
      this.transcodingExtraInfo,
      this.metadata,
      this.watermark,
      this.watermarkCount,
      this.backgroundImage,
      this.backgroundImageCount,
      this.audioSampleRate,
      this.audioBitrate,
      this.audioChannels,
      this.audioCodecProfile,
      this.advancedFeatures,
      this.advancedFeatureCount});

  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;
  @JsonKey(name: 'lowLatency')
  final bool? lowLatency;
  @JsonKey(name: 'videoGop')
  final int? videoGop;
  @JsonKey(name: 'videoCodecProfile')
  final VideoCodecProfileType? videoCodecProfile;
  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;
  @JsonKey(name: 'videoCodecType')
  final VideoCodecTypeForStream? videoCodecType;
  @JsonKey(name: 'userCount')
  final int? userCount;
  @JsonKey(name: 'transcodingUsers')
  final List<TranscodingUser>? transcodingUsers;
  @JsonKey(name: 'transcodingExtraInfo')
  final String? transcodingExtraInfo;
  @JsonKey(name: 'metadata')
  final String? metadata;
  @JsonKey(name: 'watermark')
  final List<RtcImage>? watermark;
  @JsonKey(name: 'watermarkCount')
  final int? watermarkCount;
  @JsonKey(name: 'backgroundImage')
  final List<RtcImage>? backgroundImage;
  @JsonKey(name: 'backgroundImageCount')
  final int? backgroundImageCount;
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;
  @JsonKey(name: 'audioCodecProfile')
  final AudioCodecProfileType? audioCodecProfile;
  @JsonKey(name: 'advancedFeatures')
  final List<LiveStreamAdvancedFeature>? advancedFeatures;
  @JsonKey(name: 'advancedFeatureCount')
  final int? advancedFeatureCount;
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TranscodingVideoStream {
  const TranscodingVideoStream(
      {this.sourceType,
      this.remoteUserUid,
      this.imageUrl,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.mirror});

  @JsonKey(name: 'sourceType')
  final MediaSourceType? sourceType;
  @JsonKey(name: 'remoteUserUid')
  final int? remoteUserUid;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'zOrder')
  final int? zOrder;
  @JsonKey(name: 'alpha')
  final double? alpha;
  @JsonKey(name: 'mirror')
  final bool? mirror;
  factory TranscodingVideoStream.fromJson(Map<String, dynamic> json) =>
      _$TranscodingVideoStreamFromJson(json);
  Map<String, dynamic> toJson() => _$TranscodingVideoStreamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocalTranscoderConfiguration {
  const LocalTranscoderConfiguration(
      {this.streamCount,
      this.videoInputStreams,
      this.videoOutputConfiguration});

  @JsonKey(name: 'streamCount')
  final int? streamCount;
  @JsonKey(name: 'VideoInputStreams')
  final List<TranscodingVideoStream>? videoInputStreams;
  @JsonKey(name: 'videoOutputConfiguration')
  final VideoEncoderConfiguration? videoOutputConfiguration;
  factory LocalTranscoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalTranscoderConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$LocalTranscoderConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LastmileProbeConfig {
  const LastmileProbeConfig(
      {this.probeUplink,
      this.probeDownlink,
      this.expectedUplinkBitrate,
      this.expectedDownlinkBitrate});

  @JsonKey(name: 'probeUplink')
  final bool? probeUplink;
  @JsonKey(name: 'probeDownlink')
  final bool? probeDownlink;
  @JsonKey(name: 'expectedUplinkBitrate')
  final int? expectedUplinkBitrate;
  @JsonKey(name: 'expectedDownlinkBitrate')
  final int? expectedDownlinkBitrate;
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum LastmileProbeResultState {
  @JsonValue(1)
  lastmileProbeResultComplete,
  @JsonValue(2)
  lastmileProbeResultIncompleteNoBwe,
  @JsonValue(3)
  lastmileProbeResultUnavailable,
}

extension LastmileProbeResultStateExt on LastmileProbeResultState {
  int value() {
    return _$LastmileProbeResultStateEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class LastmileProbeOneWayResult {
  const LastmileProbeOneWayResult(
      {this.packetLossRate, this.jitter, this.availableBandwidth});

  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;
  @JsonKey(name: 'jitter')
  final int? jitter;
  @JsonKey(name: 'availableBandwidth')
  final int? availableBandwidth;
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LastmileProbeResult {
  const LastmileProbeResult(
      {this.state, this.uplinkReport, this.downlinkReport, this.rtt});

  @JsonKey(name: 'state')
  final LastmileProbeResultState? state;
  @JsonKey(name: 'uplinkReport')
  final LastmileProbeOneWayResult? uplinkReport;
  @JsonKey(name: 'downlinkReport')
  final LastmileProbeOneWayResult? downlinkReport;
  @JsonKey(name: 'rtt')
  final int? rtt;
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ConnectionChangedReasonType {
  @JsonValue(0)
  connectionChangedConnecting,
  @JsonValue(1)
  connectionChangedJoinSuccess,
  @JsonValue(2)
  connectionChangedInterrupted,
  @JsonValue(3)
  connectionChangedBannedByServer,
  @JsonValue(4)
  connectionChangedJoinFailed,
  @JsonValue(5)
  connectionChangedLeaveChannel,
  @JsonValue(6)
  connectionChangedInvalidAppId,
  @JsonValue(7)
  connectionChangedInvalidChannelName,
  @JsonValue(8)
  connectionChangedInvalidToken,
  @JsonValue(9)
  connectionChangedTokenExpired,
  @JsonValue(10)
  connectionChangedRejectedByServer,
  @JsonValue(11)
  connectionChangedSettingProxyServer,
  @JsonValue(12)
  connectionChangedRenewToken,
  @JsonValue(13)
  connectionChangedClientIpAddressChanged,
  @JsonValue(14)
  connectionChangedKeepAliveTimeout,
  @JsonValue(15)
  connectionChangedRejoinSuccess,
  @JsonValue(16)
  connectionChangedLost,
  @JsonValue(17)
  connectionChangedEchoTest,
  @JsonValue(18)
  connectionChangedClientIpAddressChangedByUser,
  @JsonValue(19)
  connectionChangedSameUidLogin,
  @JsonValue(20)
  connectionChangedTooManyBroadcasters,
}

extension ConnectionChangedReasonTypeExt on ConnectionChangedReasonType {
  int value() {
    return _$ConnectionChangedReasonTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ClientRoleChangeFailedReason {
  @JsonValue(1)
  clientRoleChangeFailedTooManyBroadcasters,
  @JsonValue(2)
  clientRoleChangeFailedNotAuthorized,
  @JsonValue(3)
  clientRoleChangeFailedRequestTimeOut,
  @JsonValue(4)
  clientRoleChangeFailedConnectionFailed,
}

extension ClientRoleChangeFailedReasonExt on ClientRoleChangeFailedReason {
  int value() {
    return _$ClientRoleChangeFailedReasonEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum NetworkType {
  @JsonValue(-1)
  networkTypeUnknown,
  @JsonValue(0)
  networkTypeDisconnected,
  @JsonValue(1)
  networkTypeLan,
  @JsonValue(2)
  networkTypeWifi,
  @JsonValue(3)
  networkTypeMobile2g,
  @JsonValue(4)
  networkTypeMobile3g,
  @JsonValue(5)
  networkTypeMobile4g,
}

extension NetworkTypeExt on NetworkType {
  int value() {
    return _$NetworkTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoViewSetupMode {
  @JsonValue(0)
  videoViewSetupReplace,
  @JsonValue(1)
  videoViewSetupAdd,
  @JsonValue(2)
  videoViewSetupRemove,
}

extension VideoViewSetupModeExt on VideoViewSetupMode {
  int value() {
    return _$VideoViewSetupModeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoCanvas {
  const VideoCanvas(
      {this.view,
      this.renderMode,
      this.mirrorMode,
      this.uid,
      this.isScreenView,
      this.priv,
      this.privSize,
      this.sourceType,
      this.cropArea,
      this.setupMode});

  @JsonKey(name: 'view')
  final int? view;
  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'isScreenView')
  final bool? isScreenView;
  @JsonKey(name: 'priv', ignore: true)
  final Uint8List? priv;
  @JsonKey(name: 'priv_size')
  final int? privSize;
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;
  @JsonKey(name: 'cropArea')
  final Rectangle? cropArea;
  @JsonKey(name: 'setupMode')
  final VideoViewSetupMode? setupMode;
  factory VideoCanvas.fromJson(Map<String, dynamic> json) =>
      _$VideoCanvasFromJson(json);
  Map<String, dynamic> toJson() => _$VideoCanvasToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BeautyOptions {
  const BeautyOptions(
      {this.lighteningContrastLevel,
      this.lighteningLevel,
      this.smoothnessLevel,
      this.rednessLevel,
      this.sharpnessLevel});

  @JsonKey(name: 'lighteningContrastLevel')
  final LighteningContrastLevel? lighteningContrastLevel;
  @JsonKey(name: 'lighteningLevel')
  final double? lighteningLevel;
  @JsonKey(name: 'smoothnessLevel')
  final double? smoothnessLevel;
  @JsonKey(name: 'rednessLevel')
  final double? rednessLevel;
  @JsonKey(name: 'sharpnessLevel')
  final double? sharpnessLevel;
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum LighteningContrastLevel {
  @JsonValue(0)
  lighteningContrastLow,
  @JsonValue(1)
  lighteningContrastNormal,
  @JsonValue(2)
  lighteningContrastHigh,
}

extension LighteningContrastLevelExt on LighteningContrastLevel {
  int value() {
    return _$LighteningContrastLevelEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class VirtualBackgroundSource {
  const VirtualBackgroundSource(
      {this.backgroundSourceType, this.color, this.source, this.blurDegree});

  @JsonKey(name: 'background_source_type')
  final BackgroundSourceType? backgroundSourceType;
  @JsonKey(name: 'color')
  final int? color;
  @JsonKey(name: 'source')
  final String? source;
  @JsonKey(name: 'blur_degree')
  final BackgroundBlurDegree? blurDegree;
  factory VirtualBackgroundSource.fromJson(Map<String, dynamic> json) =>
      _$VirtualBackgroundSourceFromJson(json);
  Map<String, dynamic> toJson() => _$VirtualBackgroundSourceToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum BackgroundSourceType {
  @JsonValue(1)
  backgroundColor,
  @JsonValue(2)
  backgroundImg,
  @JsonValue(3)
  backgroundBlur,
}

extension BackgroundSourceTypeExt on BackgroundSourceType {
  int value() {
    return _$BackgroundSourceTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum BackgroundBlurDegree {
  @JsonValue(1)
  blurDegreeLow,
  @JsonValue(2)
  blurDegreeMedium,
  @JsonValue(3)
  blurDegreeHigh,
}

extension BackgroundBlurDegreeExt on BackgroundBlurDegree {
  int value() {
    return _$BackgroundBlurDegreeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class FishCorrectionParams {
  const FishCorrectionParams(
      {this.xCenter,
      this.yCenter,
      this.scaleFactor,
      this.focalLength,
      this.polFocalLength,
      this.splitHeight,
      this.ss});

  @JsonKey(name: '_x_center')
  final double? xCenter;
  @JsonKey(name: '_y_center')
  final double? yCenter;
  @JsonKey(name: '_scale_factor')
  final double? scaleFactor;
  @JsonKey(name: '_focal_length')
  final double? focalLength;
  @JsonKey(name: '_pol_focal_length')
  final double? polFocalLength;
  @JsonKey(name: '_split_height')
  final double? splitHeight;
  @JsonKey(name: '_ss')
  final List<double>? ss;
  factory FishCorrectionParams.fromJson(Map<String, dynamic> json) =>
      _$FishCorrectionParamsFromJson(json);
  Map<String, dynamic> toJson() => _$FishCorrectionParamsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VoiceBeautifierPreset {
  @JsonValue(0x00000000)
  voiceBeautifierOff,
  @JsonValue(0x01010100)
  chatBeautifierMagnetic,
  @JsonValue(0x01010200)
  chatBeautifierFresh,
  @JsonValue(0x01010300)
  chatBeautifierVitality,
  @JsonValue(0x01020100)
  singingBeautifier,
  @JsonValue(0x01030100)
  timbreTransformationVigorous,
  @JsonValue(0x01030200)
  timbreTransformationDeep,
  @JsonValue(0x01030300)
  timbreTransformationMellow,
  @JsonValue(0x01030400)
  timbreTransformationFalsetto,
  @JsonValue(0x01030500)
  timbreTransformationFull,
  @JsonValue(0x01030600)
  timbreTransformationClear,
  @JsonValue(0x01030700)
  timbreTransformationResounding,
  @JsonValue(0x01030800)
  timbreTransformationRinging,
  @JsonValue(0x01040100)
  ultraHighQualityVoice,
}

extension VoiceBeautifierPresetExt on VoiceBeautifierPreset {
  int value() {
    return _$VoiceBeautifierPresetEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioEffectPreset {
  @JsonValue(0x00000000)
  audioEffectOff,
  @JsonValue(0x02010100)
  roomAcousticsKtv,
  @JsonValue(0x02010200)
  roomAcousticsVocalConcert,
  @JsonValue(0x02010300)
  roomAcousticsStudio,
  @JsonValue(0x02010400)
  roomAcousticsPhonograph,
  @JsonValue(0x02010500)
  roomAcousticsVirtualStereo,
  @JsonValue(0x02010600)
  roomAcousticsSpacial,
  @JsonValue(0x02010700)
  roomAcousticsEthereal,
  @JsonValue(0x02010800)
  roomAcoustics3dVoice,
  @JsonValue(0x02020100)
  voiceChangerEffectUncle,
  @JsonValue(0x02020200)
  voiceChangerEffectOldman,
  @JsonValue(0x02020300)
  voiceChangerEffectBoy,
  @JsonValue(0x02020400)
  voiceChangerEffectSister,
  @JsonValue(0x02020500)
  voiceChangerEffectGirl,
  @JsonValue(0x02020600)
  voiceChangerEffectPigking,
  @JsonValue(0x02020700)
  voiceChangerEffectHulk,
  @JsonValue(0x02030100)
  styleTransformationRnb,
  @JsonValue(0x02030200)
  styleTransformationPopular,
  @JsonValue(0x02040100)
  pitchCorrection,
}

extension AudioEffectPresetExt on AudioEffectPreset {
  int value() {
    return _$AudioEffectPresetEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VoiceConversionPreset {
  @JsonValue(0x00000000)
  voiceConversionOff,
  @JsonValue(0x03010100)
  voiceChangerNeutral,
  @JsonValue(0x03010200)
  voiceChangerSweet,
  @JsonValue(0x03010300)
  voiceChangerSolid,
  @JsonValue(0x03010400)
  voiceChangerBass,
}

extension VoiceConversionPresetExt on VoiceConversionPreset {
  int value() {
    return _$VoiceConversionPresetEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class ScreenCaptureParameters {
  const ScreenCaptureParameters(
      {this.dimensions,
      this.frameRate,
      this.bitrate,
      this.captureMouseCursor,
      this.windowFocus,
      this.excludeWindowList,
      this.excludeWindowCount});

  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;
  @JsonKey(name: 'frameRate')
  final int? frameRate;
  @JsonKey(name: 'bitrate')
  final int? bitrate;
  @JsonKey(name: 'captureMouseCursor')
  final bool? captureMouseCursor;
  @JsonKey(name: 'windowFocus')
  final bool? windowFocus;
  @JsonKey(name: 'excludeWindowList')
  final List<int>? excludeWindowList;
  @JsonKey(name: 'excludeWindowCount')
  final int? excludeWindowCount;
  factory ScreenCaptureParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParametersFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenCaptureParametersToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioRecordingQualityType {
  @JsonValue(0)
  audioRecordingQualityLow,
  @JsonValue(1)
  audioRecordingQualityMedium,
  @JsonValue(2)
  audioRecordingQualityHigh,
}

extension AudioRecordingQualityTypeExt on AudioRecordingQualityType {
  int value() {
    return _$AudioRecordingQualityTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioFileRecordingType {
  @JsonValue(1)
  audioFileRecordingMic,
  @JsonValue(2)
  audioFileRecordingPlayback,
  @JsonValue(3)
  audioFileRecordingMixed,
}

extension AudioFileRecordingTypeExt on AudioFileRecordingType {
  int value() {
    return _$AudioFileRecordingTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AudioEncodedFrameObserverPosition {
  @JsonValue(1)
  audioEncodedFrameObserverPositionRecord,
  @JsonValue(2)
  audioEncodedFrameObserverPositionPlayback,
  @JsonValue(3)
  audioEncodedFrameObserverPositionMixed,
}

extension AudioEncodedFrameObserverPositionExt
    on AudioEncodedFrameObserverPosition {
  int value() {
    return _$AudioEncodedFrameObserverPositionEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioRecordingConfiguration {
  const AudioRecordingConfiguration(
      {this.filePath,
      this.encode,
      this.sampleRate,
      this.fileRecordingType,
      this.quality});

  @JsonKey(name: 'filePath')
  final String? filePath;
  @JsonKey(name: 'encode')
  final bool? encode;
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;
  @JsonKey(name: 'fileRecordingType')
  final AudioFileRecordingType? fileRecordingType;
  @JsonKey(name: 'quality')
  final AudioRecordingQualityType? quality;
  factory AudioRecordingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordingConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$AudioRecordingConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameObserverConfig {
  const AudioEncodedFrameObserverConfig({this.postionType, this.encodingType});

  @JsonKey(name: 'postionType')
  final AudioEncodedFrameObserverPosition? postionType;
  @JsonKey(name: 'encodingType')
  final AudioEncodingType? encodingType;
  factory AudioEncodedFrameObserverConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverConfigFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AreaCode {
  @JsonValue(0x00000001)
  areaCodeCn,
  @JsonValue(0x00000002)
  areaCodeNa,
  @JsonValue(0x00000004)
  areaCodeEu,
  @JsonValue(0x00000008)
  areaCodeAs,
  @JsonValue(0x00000010)
  areaCodeJp,
  @JsonValue(0x00000020)
  areaCodeIn,
  @JsonValue((0xFFFFFFFF))
  areaCodeGlob,
}

extension AreaCodeExt on AreaCode {
  int value() {
    return _$AreaCodeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum AreaCodeEx {
  @JsonValue(0x00000040)
  areaCodeOc,
  @JsonValue(0x00000080)
  areaCodeSa,
  @JsonValue(0x00000100)
  areaCodeAf,
  @JsonValue(0x00000200)
  areaCodeKr,
  @JsonValue(0xFFFFFFFE)
  areaCodeOvs,
}

extension AreaCodeExExt on AreaCodeEx {
  int value() {
    return _$AreaCodeExEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayError {
  @JsonValue(0)
  relayOk,
  @JsonValue(1)
  relayErrorServerErrorResponse,
  @JsonValue(2)
  relayErrorServerNoResponse,
  @JsonValue(3)
  relayErrorNoResourceAvailable,
  @JsonValue(4)
  relayErrorFailedJoinSrc,
  @JsonValue(5)
  relayErrorFailedJoinDest,
  @JsonValue(6)
  relayErrorFailedPacketReceivedFromSrc,
  @JsonValue(7)
  relayErrorFailedPacketSentToDest,
  @JsonValue(8)
  relayErrorServerConnectionLost,
  @JsonValue(9)
  relayErrorInternalError,
  @JsonValue(10)
  relayErrorSrcTokenExpired,
  @JsonValue(11)
  relayErrorDestTokenExpired,
}

extension ChannelMediaRelayErrorExt on ChannelMediaRelayError {
  int value() {
    return _$ChannelMediaRelayErrorEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayEvent {
  @JsonValue(0)
  relayEventNetworkDisconnected,
  @JsonValue(1)
  relayEventNetworkConnected,
  @JsonValue(2)
  relayEventPacketJoinedSrcChannel,
  @JsonValue(3)
  relayEventPacketJoinedDestChannel,
  @JsonValue(4)
  relayEventPacketSentToDestChannel,
  @JsonValue(5)
  relayEventPacketReceivedVideoFromSrc,
  @JsonValue(6)
  relayEventPacketReceivedAudioFromSrc,
  @JsonValue(7)
  relayEventPacketUpdateDestChannel,
  @JsonValue(8)
  relayEventPacketUpdateDestChannelRefused,
  @JsonValue(9)
  relayEventPacketUpdateDestChannelNotChange,
  @JsonValue(10)
  relayEventPacketUpdateDestChannelIsNull,
  @JsonValue(11)
  relayEventVideoProfileUpdate,
  @JsonValue(12)
  relayEventPauseSendPacketToDestChannelSuccess,
  @JsonValue(13)
  relayEventPauseSendPacketToDestChannelFailed,
  @JsonValue(14)
  relayEventResumeSendPacketToDestChannelSuccess,
  @JsonValue(15)
  relayEventResumeSendPacketToDestChannelFailed,
}

extension ChannelMediaRelayEventExt on ChannelMediaRelayEvent {
  int value() {
    return _$ChannelMediaRelayEventEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayState {
  @JsonValue(0)
  relayStateIdle,
  @JsonValue(1)
  relayStateConnecting,
  @JsonValue(2)
  relayStateRunning,
  @JsonValue(3)
  relayStateFailure,
}

extension ChannelMediaRelayStateExt on ChannelMediaRelayState {
  int value() {
    return _$ChannelMediaRelayStateEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class ChannelMediaInfo {
  const ChannelMediaInfo({this.channelName, this.token, this.uid});

  @JsonKey(name: 'channelName')
  final String? channelName;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'uid')
  final int? uid;
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChannelMediaRelayConfiguration {
  const ChannelMediaRelayConfiguration(
      {this.srcInfo, this.destInfos, this.destCount});

  @JsonKey(name: 'srcInfo')
  final ChannelMediaInfo? srcInfo;
  @JsonKey(name: 'destInfos')
  final List<ChannelMediaInfo>? destInfos;
  @JsonKey(name: 'destCount')
  final int? destCount;
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UplinkNetworkInfo {
  const UplinkNetworkInfo({this.videoEncoderTargetBitrateBps});

  @JsonKey(name: 'video_encoder_target_bitrate_bps')
  final int? videoEncoderTargetBitrateBps;
  factory UplinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$UplinkNetworkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UplinkNetworkInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DownlinkNetworkInfo {
  const DownlinkNetworkInfo(
      {this.lastmileBufferDelayTimeMs,
      this.bandwidthEstimationBps,
      this.totalDownscaleLevelCount,
      this.peerDownlinkInfo,
      this.totalReceivedVideoCount});

  @JsonKey(name: 'lastmile_buffer_delay_time_ms')
  final int? lastmileBufferDelayTimeMs;
  @JsonKey(name: 'bandwidth_estimation_bps')
  final int? bandwidthEstimationBps;
  @JsonKey(name: 'total_downscale_level_count')
  final int? totalDownscaleLevelCount;
  @JsonKey(name: 'peer_downlink_info')
  final List<PeerDownlinkInfo>? peerDownlinkInfo;
  @JsonKey(name: 'total_received_video_count')
  final int? totalReceivedVideoCount;
  factory DownlinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$DownlinkNetworkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DownlinkNetworkInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PeerDownlinkInfo {
  const PeerDownlinkInfo(
      {this.uid,
      this.streamType,
      this.currentDownscaleLevel,
      this.expectedBitrateBps});

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'stream_type')
  final VideoStreamType? streamType;
  @JsonKey(name: 'current_downscale_level')
  final RemoteVideoDownscaleLevel? currentDownscaleLevel;
  @JsonKey(name: 'expected_bitrate_bps')
  final int? expectedBitrateBps;
  factory PeerDownlinkInfo.fromJson(Map<String, dynamic> json) =>
      _$PeerDownlinkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PeerDownlinkInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum EncryptionMode {
  @JsonValue(1)
  aes128Xts,
  @JsonValue(2)
  aes128Ecb,
  @JsonValue(3)
  aes256Xts,
  @JsonValue(4)
  sm4128Ecb,
  @JsonValue(5)
  aes128Gcm,
  @JsonValue(6)
  aes256Gcm,
  @JsonValue(7)
  aes128Gcm2,
  @JsonValue(8)
  aes256Gcm2,
  @JsonValue(9)
  modeEnd,
}

extension EncryptionModeExt on EncryptionMode {
  int value() {
    return _$EncryptionModeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class EncryptionConfig {
  const EncryptionConfig(
      {this.encryptionMode, this.encryptionKey, this.encryptionKdfSalt});

  @JsonKey(name: 'encryptionMode')
  final EncryptionMode? encryptionMode;
  @JsonKey(name: 'encryptionKey')
  final String? encryptionKey;
  @JsonKey(name: 'encryptionKdfSalt', ignore: true)
  final Uint8List? encryptionKdfSalt;
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum EncryptionErrorType {
  @JsonValue(0)
  encryptionErrorInternalFailure,
  @JsonValue(1)
  encryptionErrorDecryptionFailure,
  @JsonValue(2)
  encryptionErrorEncryptionFailure,
}

extension EncryptionErrorTypeExt on EncryptionErrorType {
  int value() {
    return _$EncryptionErrorTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum UploadErrorReason {
  @JsonValue(0)
  uploadSuccess,
  @JsonValue(1)
  uploadNetError,
  @JsonValue(2)
  uploadServerError,
}

extension UploadErrorReasonExt on UploadErrorReason {
  int value() {
    return _$UploadErrorReasonEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum PermissionType {
  @JsonValue(0)
  recordAudio,
  @JsonValue(1)
  camera,
}

extension PermissionTypeExt on PermissionType {
  int value() {
    return _$PermissionTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MaxUserAccountLengthType {
  @JsonValue(256)
  maxUserAccountLength,
}

extension MaxUserAccountLengthTypeExt on MaxUserAccountLengthType {
  int value() {
    return _$MaxUserAccountLengthTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum StreamSubscribeState {
  @JsonValue(0)
  subStateIdle,
  @JsonValue(1)
  subStateNoSubscribed,
  @JsonValue(2)
  subStateSubscribing,
  @JsonValue(3)
  subStateSubscribed,
}

extension StreamSubscribeStateExt on StreamSubscribeState {
  int value() {
    return _$StreamSubscribeStateEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum StreamPublishState {
  @JsonValue(0)
  pubStateIdle,
  @JsonValue(1)
  pubStateNoPublished,
  @JsonValue(2)
  pubStatePublishing,
  @JsonValue(3)
  pubStatePublished,
}

extension StreamPublishStateExt on StreamPublishState {
  int value() {
    return _$StreamPublishStateEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class UserInfo {
  const UserInfo({this.uid, this.userAccount});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'userAccount')
  final String? userAccount;
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum EarMonitoringFilterType {
  @JsonValue((1 << 0))
  earMonitoringFilterNone,
  @JsonValue((1 << 1))
  earMonitoringFilterBuiltInAudioFilters,
  @JsonValue((1 << 2))
  earMonitoringFilterNoiseSuppression,
}

extension EarMonitoringFilterTypeExt on EarMonitoringFilterType {
  int value() {
    return _$EarMonitoringFilterTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum ThreadPriorityType {
  @JsonValue(0)
  lowest,
  @JsonValue(1)
  low,
  @JsonValue(2)
  normal,
  @JsonValue(3)
  high,
  @JsonValue(4)
  highest,
  @JsonValue(5)
  critical,
}

extension ThreadPriorityTypeExt on ThreadPriorityType {
  int value() {
    return _$ThreadPriorityTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true)
class SpatialAudioParams {
  const SpatialAudioParams(
      {this.speakerAzimuth,
      this.speakerElevation,
      this.speakerDistance,
      this.speakerOrientation,
      this.enableBlur,
      this.enableAirAbsorb});

  @JsonKey(name: 'speaker_azimuth')
  final double? speakerAzimuth;
  @JsonKey(name: 'speaker_elevation')
  final double? speakerElevation;
  @JsonKey(name: 'speaker_distance')
  final double? speakerDistance;
  @JsonKey(name: 'speaker_orientation')
  final int? speakerOrientation;
  @JsonKey(name: 'enable_blur')
  final bool? enableBlur;
  @JsonKey(name: 'enable_air_absorb')
  final bool? enableAirAbsorb;
  factory SpatialAudioParams.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioParamsFromJson(json);
  Map<String, dynamic> toJson() => _$SpatialAudioParamsToJson(this);
}
