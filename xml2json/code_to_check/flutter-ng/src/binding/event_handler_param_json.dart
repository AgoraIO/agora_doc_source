import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'event_handler_param_json.g.dart';

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnJoinChannelSuccessJson {
  const RtcEngineEventHandlerOnJoinChannelSuccessJson(
      {this.channel, this.uid, this.elapsed});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnJoinChannelSuccessJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnJoinChannelSuccessJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnJoinChannelSuccessJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRejoinChannelSuccessJson {
  const RtcEngineEventHandlerOnRejoinChannelSuccessJson(
      {this.channel, this.uid, this.elapsed});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnRejoinChannelSuccessJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnWarningJson {
  const RtcEngineEventHandlerOnWarningJson({this.warn, this.msg});

  @JsonKey(name: 'warn')
  final int? warn;
  @JsonKey(name: 'msg')
  final String? msg;
  factory RtcEngineEventHandlerOnWarningJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnWarningJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnWarningJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnErrorJson {
  const RtcEngineEventHandlerOnErrorJson({this.err, this.msg});

  @JsonKey(name: 'err')
  final int? err;
  @JsonKey(name: 'msg')
  final String? msg;
  factory RtcEngineEventHandlerOnErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnErrorJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioQualityJson {
  const RtcEngineEventHandlerOnAudioQualityJson(
      {this.uid, this.quality, this.delay, this.lost});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'quality')
  final int? quality;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  factory RtcEngineEventHandlerOnAudioQualityJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioQualityJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioQualityJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLastmileProbeResultJson {
  const RtcEngineEventHandlerOnLastmileProbeResultJson({this.result});

  @JsonKey(name: 'result')
  final LastmileProbeResult? result;
  factory RtcEngineEventHandlerOnLastmileProbeResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLastmileProbeResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLastmileProbeResultJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioVolumeIndicationJson {
  const RtcEngineEventHandlerOnAudioVolumeIndicationJson(
      {this.speakers, this.speakerNumber, this.totalVolume});

  @JsonKey(name: 'speakers')
  final AudioVolumeInfo? speakers;
  @JsonKey(name: 'speakerNumber')
  final int? speakerNumber;
  @JsonKey(name: 'totalVolume')
  final int? totalVolume;
  factory RtcEngineEventHandlerOnAudioVolumeIndicationJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioVolumeIndicationJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioVolumeIndicationJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLeaveChannelJson {
  const RtcEngineEventHandlerOnLeaveChannelJson({this.stats});

  @JsonKey(name: 'stats')
  final RtcStats? stats;
  factory RtcEngineEventHandlerOnLeaveChannelJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLeaveChannelJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLeaveChannelJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRtcStatsJson {
  const RtcEngineEventHandlerOnRtcStatsJson({this.stats});

  @JsonKey(name: 'stats')
  final RtcStats? stats;
  factory RtcEngineEventHandlerOnRtcStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRtcStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRtcStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioDeviceStateChangedJson {
  const RtcEngineEventHandlerOnAudioDeviceStateChangedJson(
      {this.deviceId, this.deviceType, this.deviceState});

  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'deviceType')
  final int? deviceType;
  @JsonKey(name: 'deviceState')
  final int? deviceState;
  factory RtcEngineEventHandlerOnAudioDeviceStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioDeviceStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioDeviceStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioMixingFinishedJson {
  const RtcEngineEventHandlerOnAudioMixingFinishedJson();

  factory RtcEngineEventHandlerOnAudioMixingFinishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioMixingFinishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioMixingFinishedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioEffectFinishedJson {
  const RtcEngineEventHandlerOnAudioEffectFinishedJson({this.soundId});

  @JsonKey(name: 'soundId')
  final int? soundId;
  factory RtcEngineEventHandlerOnAudioEffectFinishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioEffectFinishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioEffectFinishedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoDeviceStateChangedJson {
  const RtcEngineEventHandlerOnVideoDeviceStateChangedJson(
      {this.deviceId, this.deviceType, this.deviceState});

  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'deviceType')
  final int? deviceType;
  @JsonKey(name: 'deviceState')
  final int? deviceState;
  factory RtcEngineEventHandlerOnVideoDeviceStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoDeviceStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoDeviceStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnMediaDeviceChangedJson {
  const RtcEngineEventHandlerOnMediaDeviceChangedJson({this.deviceType});

  @JsonKey(name: 'deviceType')
  final int? deviceType;
  factory RtcEngineEventHandlerOnMediaDeviceChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnMediaDeviceChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnMediaDeviceChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnNetworkQualityJson {
  const RtcEngineEventHandlerOnNetworkQualityJson(
      {this.uid, this.txQuality, this.rxQuality});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'txQuality')
  final int? txQuality;
  @JsonKey(name: 'rxQuality')
  final int? rxQuality;
  factory RtcEngineEventHandlerOnNetworkQualityJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnNetworkQualityJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnNetworkQualityJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnIntraRequestReceivedJson {
  const RtcEngineEventHandlerOnIntraRequestReceivedJson();

  factory RtcEngineEventHandlerOnIntraRequestReceivedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnIntraRequestReceivedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnIntraRequestReceivedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson {
  const RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson({this.info});

  @JsonKey(name: 'info')
  final UplinkNetworkInfo? info;
  factory RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson {
  const RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson({this.info});

  @JsonKey(name: 'info')
  final DownlinkNetworkInfo? info;
  factory RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLastmileQualityJson {
  const RtcEngineEventHandlerOnLastmileQualityJson({this.quality});

  @JsonKey(name: 'quality')
  final int? quality;
  factory RtcEngineEventHandlerOnLastmileQualityJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLastmileQualityJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLastmileQualityJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstLocalVideoFrameJson {
  const RtcEngineEventHandlerOnFirstLocalVideoFrameJson(
      {this.width, this.height, this.elapsed});

  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstLocalVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson {
  const RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson(
      {this.elapsed});

  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson {
  const RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson(
      {this.sourceType, this.width, this.height});

  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson {
  const RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson(
      {this.uid, this.width, this.height, this.elapsed});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoSizeChangedJson {
  const RtcEngineEventHandlerOnVideoSizeChangedJson(
      {this.uid, this.width, this.height, this.rotation});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'rotation')
  final int? rotation;
  factory RtcEngineEventHandlerOnVideoSizeChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoSizeChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoSizeChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalVideoStateChangedJson {
  const RtcEngineEventHandlerOnLocalVideoStateChangedJson(
      {this.state, this.error});

  @JsonKey(name: 'state')
  final LocalVideoStreamState? state;
  @JsonKey(name: 'error')
  final LocalVideoStreamError? error;
  factory RtcEngineEventHandlerOnLocalVideoStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteVideoStateChangedJson {
  const RtcEngineEventHandlerOnRemoteVideoStateChangedJson(
      {this.uid, this.state, this.reason, this.elapsed});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'state')
  final RemoteVideoState? state;
  @JsonKey(name: 'reason')
  final RemoteVideoStateReason? reason;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnRemoteVideoStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteVideoFrameJson {
  const RtcEngineEventHandlerOnFirstRemoteVideoFrameJson(
      {this.userId, this.width, this.height, this.elapsed});

  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserJoinedJson {
  const RtcEngineEventHandlerOnUserJoinedJson({this.uid, this.elapsed});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnUserJoinedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserJoinedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserJoinedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserOfflineJson {
  const RtcEngineEventHandlerOnUserOfflineJson({this.uid, this.reason});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'reason')
  final UserOfflineReasonType? reason;
  factory RtcEngineEventHandlerOnUserOfflineJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserOfflineJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserOfflineJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserMuteAudioJson {
  const RtcEngineEventHandlerOnUserMuteAudioJson({this.uid, this.muted});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerOnUserMuteAudioJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserMuteAudioJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserMuteAudioJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserMuteVideoJson {
  const RtcEngineEventHandlerOnUserMuteVideoJson({this.userId, this.muted});

  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerOnUserMuteVideoJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserMuteVideoJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserMuteVideoJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserEnableVideoJson {
  const RtcEngineEventHandlerOnUserEnableVideoJson({this.uid, this.enabled});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  factory RtcEngineEventHandlerOnUserEnableVideoJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserEnableVideoJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserEnableVideoJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserStateChangedJson {
  const RtcEngineEventHandlerOnUserStateChangedJson({this.uid, this.state});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'state')
  final int? state;
  factory RtcEngineEventHandlerOnUserStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserEnableLocalVideoJson {
  const RtcEngineEventHandlerOnUserEnableLocalVideoJson(
      {this.uid, this.enabled});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  factory RtcEngineEventHandlerOnUserEnableLocalVideoJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnApiCallExecutedJson {
  const RtcEngineEventHandlerOnApiCallExecutedJson(
      {this.err, this.api, this.result});

  @JsonKey(name: 'err')
  final int? err;
  @JsonKey(name: 'api')
  final String? api;
  @JsonKey(name: 'result')
  final String? result;
  factory RtcEngineEventHandlerOnApiCallExecutedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnApiCallExecutedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnApiCallExecutedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalAudioStatsJson {
  const RtcEngineEventHandlerOnLocalAudioStatsJson({this.stats});

  @JsonKey(name: 'stats')
  final LocalAudioStats? stats;
  factory RtcEngineEventHandlerOnLocalAudioStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalAudioStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalAudioStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteAudioStatsJson {
  const RtcEngineEventHandlerOnRemoteAudioStatsJson({this.stats});

  @JsonKey(name: 'stats')
  final RemoteAudioStats? stats;
  factory RtcEngineEventHandlerOnRemoteAudioStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteAudioStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteAudioStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalVideoStatsJson {
  const RtcEngineEventHandlerOnLocalVideoStatsJson({this.stats});

  @JsonKey(name: 'stats')
  final LocalVideoStats? stats;
  factory RtcEngineEventHandlerOnLocalVideoStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalVideoStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalVideoStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteVideoStatsJson {
  const RtcEngineEventHandlerOnRemoteVideoStatsJson({this.stats});

  @JsonKey(name: 'stats')
  final RemoteVideoStats? stats;
  factory RtcEngineEventHandlerOnRemoteVideoStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteVideoStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteVideoStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnCameraReadyJson {
  const RtcEngineEventHandlerOnCameraReadyJson();

  factory RtcEngineEventHandlerOnCameraReadyJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnCameraReadyJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnCameraReadyJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnCameraFocusAreaChangedJson {
  const RtcEngineEventHandlerOnCameraFocusAreaChangedJson(
      {this.x, this.y, this.width, this.height});

  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory RtcEngineEventHandlerOnCameraFocusAreaChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnCameraFocusAreaChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnCameraFocusAreaChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnCameraExposureAreaChangedJson {
  const RtcEngineEventHandlerOnCameraExposureAreaChangedJson(
      {this.x, this.y, this.width, this.height});

  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory RtcEngineEventHandlerOnCameraExposureAreaChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFacePositionChangedJson {
  const RtcEngineEventHandlerOnFacePositionChangedJson(
      {this.imageWidth,
      this.imageHeight,
      this.vecRectangle,
      this.vecDistance,
      this.numFaces});

  @JsonKey(name: 'imageWidth')
  final int? imageWidth;
  @JsonKey(name: 'imageHeight')
  final int? imageHeight;
  @JsonKey(name: 'vecRectangle')
  final Rectangle? vecRectangle;
  @JsonKey(name: 'vecDistance')
  final int? vecDistance;
  @JsonKey(name: 'numFaces')
  final int? numFaces;
  factory RtcEngineEventHandlerOnFacePositionChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFacePositionChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFacePositionChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoStoppedJson {
  const RtcEngineEventHandlerOnVideoStoppedJson();

  factory RtcEngineEventHandlerOnVideoStoppedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoStoppedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoStoppedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioMixingStateChangedJson {
  const RtcEngineEventHandlerOnAudioMixingStateChangedJson(
      {this.state, this.errorCode});

  @JsonKey(name: 'state')
  final AudioMixingStateType? state;
  @JsonKey(name: 'errorCode')
  final AudioMixingErrorType? errorCode;
  factory RtcEngineEventHandlerOnAudioMixingStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioMixingStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioMixingStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRhythmPlayerStateChangedJson {
  const RtcEngineEventHandlerOnRhythmPlayerStateChangedJson(
      {this.state, this.errorCode});

  @JsonKey(name: 'state')
  final RhythmPlayerStateType? state;
  @JsonKey(name: 'errorCode')
  final RhythmPlayerErrorType? errorCode;
  factory RtcEngineEventHandlerOnRhythmPlayerStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionLostJson {
  const RtcEngineEventHandlerOnConnectionLostJson();

  factory RtcEngineEventHandlerOnConnectionLostJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionLostJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionLostJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionInterruptedJson {
  const RtcEngineEventHandlerOnConnectionInterruptedJson();

  factory RtcEngineEventHandlerOnConnectionInterruptedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionInterruptedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionInterruptedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionBannedJson {
  const RtcEngineEventHandlerOnConnectionBannedJson();

  factory RtcEngineEventHandlerOnConnectionBannedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionBannedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionBannedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnStreamMessageJson {
  const RtcEngineEventHandlerOnStreamMessageJson(
      {this.userId, this.streamId, this.data, this.length, this.sentTs});

  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'streamId')
  final int? streamId;
  @JsonKey(name: 'data', ignore: true)
  final Uint8List? data;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'sentTs')
  final int? sentTs;
  factory RtcEngineEventHandlerOnStreamMessageJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnStreamMessageJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnStreamMessageJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnStreamMessageErrorJson {
  const RtcEngineEventHandlerOnStreamMessageErrorJson(
      {this.userId, this.streamId, this.code, this.missed, this.cached});

  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'streamId')
  final int? streamId;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'missed')
  final int? missed;
  @JsonKey(name: 'cached')
  final int? cached;
  factory RtcEngineEventHandlerOnStreamMessageErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnStreamMessageErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnStreamMessageErrorJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRequestTokenJson {
  const RtcEngineEventHandlerOnRequestTokenJson();

  factory RtcEngineEventHandlerOnRequestTokenJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRequestTokenJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRequestTokenJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson {
  const RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson({this.token});

  @JsonKey(name: 'token')
  final String? token;
  factory RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnTokenPrivilegeWillExpireJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnTokenPrivilegeWillExpireJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson {
  const RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson(
      {this.elapsed});

  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteAudioFrameJson {
  const RtcEngineEventHandlerOnFirstRemoteAudioFrameJson(
      {this.uid, this.elapsed});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteAudioFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson {
  const RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson(
      {this.uid, this.elapsed});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalAudioStateChangedJson {
  const RtcEngineEventHandlerOnLocalAudioStateChangedJson(
      {this.state, this.error});

  @JsonKey(name: 'state')
  final LocalAudioStreamState? state;
  @JsonKey(name: 'error')
  final LocalAudioStreamError? error;
  factory RtcEngineEventHandlerOnLocalAudioStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalAudioStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalAudioStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteAudioStateChangedJson {
  const RtcEngineEventHandlerOnRemoteAudioStateChangedJson(
      {this.uid, this.state, this.reason, this.elapsed});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'state')
  final RemoteAudioState? state;
  @JsonKey(name: 'reason')
  final RemoteAudioStateReason? reason;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnRemoteAudioStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnActiveSpeakerJson {
  const RtcEngineEventHandlerOnActiveSpeakerJson({this.userId});

  @JsonKey(name: 'userId')
  final int? userId;
  factory RtcEngineEventHandlerOnActiveSpeakerJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnActiveSpeakerJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnActiveSpeakerJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnContentInspectResultJson {
  const RtcEngineEventHandlerOnContentInspectResultJson({this.result});

  @JsonKey(name: 'result')
  final ContentInspectResult? result;
  factory RtcEngineEventHandlerOnContentInspectResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnContentInspectResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnContentInspectResultJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnSnapshotTakenJson {
  const RtcEngineEventHandlerOnSnapshotTakenJson(
      {this.channel,
      this.uid,
      this.filePath,
      this.width,
      this.height,
      this.errCode});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'filePath')
  final String? filePath;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'errCode')
  final int? errCode;
  factory RtcEngineEventHandlerOnSnapshotTakenJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnSnapshotTakenJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnSnapshotTakenJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnClientRoleChangedJson {
  const RtcEngineEventHandlerOnClientRoleChangedJson(
      {this.oldRole, this.newRole});

  @JsonKey(name: 'oldRole')
  final ClientRoleType? oldRole;
  @JsonKey(name: 'newRole')
  final ClientRoleType? newRole;
  factory RtcEngineEventHandlerOnClientRoleChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnClientRoleChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnClientRoleChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnClientRoleChangeFailedJson {
  const RtcEngineEventHandlerOnClientRoleChangeFailedJson(
      {this.reason, this.currentRole});

  @JsonKey(name: 'reason')
  final ClientRoleChangeFailedReason? reason;
  @JsonKey(name: 'currentRole')
  final ClientRoleType? currentRole;
  factory RtcEngineEventHandlerOnClientRoleChangeFailedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnClientRoleChangeFailedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnClientRoleChangeFailedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson {
  const RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson(
      {this.deviceType, this.volume, this.muted});

  @JsonKey(name: 'deviceType')
  final MediaDeviceType? deviceType;
  @JsonKey(name: 'volume')
  final int? volume;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRtmpStreamingStateChangedJson {
  const RtcEngineEventHandlerOnRtmpStreamingStateChangedJson(
      {this.url, this.state, this.errCode});

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'state')
  final RtmpStreamPublishState? state;
  @JsonKey(name: 'errCode')
  final RtmpStreamPublishErrorType? errCode;
  factory RtcEngineEventHandlerOnRtmpStreamingStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRtmpStreamingEventJson {
  const RtcEngineEventHandlerOnRtmpStreamingEventJson(
      {this.url, this.eventCode});

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'eventCode')
  final RtmpStreamingEvent? eventCode;
  factory RtcEngineEventHandlerOnRtmpStreamingEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRtmpStreamingEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRtmpStreamingEventJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnStreamPublishedJson {
  const RtcEngineEventHandlerOnStreamPublishedJson({this.url, this.error});

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'error')
  final int? error;
  factory RtcEngineEventHandlerOnStreamPublishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnStreamPublishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnStreamPublishedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnStreamUnpublishedJson {
  const RtcEngineEventHandlerOnStreamUnpublishedJson({this.url});

  @JsonKey(name: 'url')
  final String? url;
  factory RtcEngineEventHandlerOnStreamUnpublishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnStreamUnpublishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnStreamUnpublishedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnTranscodingUpdatedJson {
  const RtcEngineEventHandlerOnTranscodingUpdatedJson();

  factory RtcEngineEventHandlerOnTranscodingUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnTranscodingUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnTranscodingUpdatedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioRoutingChangedJson {
  const RtcEngineEventHandlerOnAudioRoutingChangedJson({this.routing});

  @JsonKey(name: 'routing')
  final int? routing;
  factory RtcEngineEventHandlerOnAudioRoutingChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioRoutingChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioRoutingChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson {
  const RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson(
      {this.state, this.code});

  @JsonKey(name: 'state')
  final ChannelMediaRelayState? state;
  @JsonKey(name: 'code')
  final ChannelMediaRelayError? code;
  factory RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnChannelMediaRelayEventJson {
  const RtcEngineEventHandlerOnChannelMediaRelayEventJson({this.code});

  @JsonKey(name: 'code')
  final int? code;
  factory RtcEngineEventHandlerOnChannelMediaRelayEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnChannelMediaRelayEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnChannelMediaRelayEventJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson {
  const RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson(
      {this.isFallbackOrRecover});

  @JsonKey(name: 'isFallbackOrRecover')
  final bool? isFallbackOrRecover;
  factory RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson {
  const RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson(
      {this.uid, this.isFallbackOrRecover});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'isFallbackOrRecover')
  final bool? isFallbackOrRecover;
  factory RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteAudioTransportStatsJson {
  const RtcEngineEventHandlerOnRemoteAudioTransportStatsJson(
      {this.uid, this.delay, this.lost, this.rxKBitRate});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;
  factory RtcEngineEventHandlerOnRemoteAudioTransportStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteVideoTransportStatsJson {
  const RtcEngineEventHandlerOnRemoteVideoTransportStatsJson(
      {this.uid, this.delay, this.lost, this.rxKBitRate});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;
  factory RtcEngineEventHandlerOnRemoteVideoTransportStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionStateChangedJson {
  const RtcEngineEventHandlerOnConnectionStateChangedJson(
      {this.state, this.reason});

  @JsonKey(name: 'state')
  final ConnectionStateType? state;
  @JsonKey(name: 'reason')
  final ConnectionChangedReasonType? reason;
  factory RtcEngineEventHandlerOnConnectionStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnNetworkTypeChangedJson {
  const RtcEngineEventHandlerOnNetworkTypeChangedJson({this.type});

  @JsonKey(name: 'type')
  final NetworkType? type;
  factory RtcEngineEventHandlerOnNetworkTypeChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnNetworkTypeChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnNetworkTypeChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnEncryptionErrorJson {
  const RtcEngineEventHandlerOnEncryptionErrorJson({this.errorType});

  @JsonKey(name: 'errorType')
  final EncryptionErrorType? errorType;
  factory RtcEngineEventHandlerOnEncryptionErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnEncryptionErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnEncryptionErrorJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnPermissionErrorJson {
  const RtcEngineEventHandlerOnPermissionErrorJson({this.permissionType});

  @JsonKey(name: 'permissionType')
  final PermissionType? permissionType;
  factory RtcEngineEventHandlerOnPermissionErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnPermissionErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnPermissionErrorJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalUserRegisteredJson {
  const RtcEngineEventHandlerOnLocalUserRegisteredJson(
      {this.uid, this.userAccount});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'userAccount')
  final String? userAccount;
  factory RtcEngineEventHandlerOnLocalUserRegisteredJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalUserRegisteredJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalUserRegisteredJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserInfoUpdatedJson {
  const RtcEngineEventHandlerOnUserInfoUpdatedJson({this.uid, this.info});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'info')
  final UserInfo? info;
  factory RtcEngineEventHandlerOnUserInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserInfoUpdatedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUploadLogResultJson {
  const RtcEngineEventHandlerOnUploadLogResultJson(
      {this.requestId, this.success, this.reason});

  @JsonKey(name: 'requestId')
  final String? requestId;
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'reason')
  final UploadErrorReason? reason;
  factory RtcEngineEventHandlerOnUploadLogResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUploadLogResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUploadLogResultJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioSubscribeStateChangedJson {
  const RtcEngineEventHandlerOnAudioSubscribeStateChangedJson(
      {this.channel,
      this.uid,
      this.oldState,
      this.newState,
      this.elapseSinceLastState});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'oldState')
  final StreamSubscribeState? oldState;
  @JsonKey(name: 'newState')
  final StreamSubscribeState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnAudioSubscribeStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoSubscribeStateChangedJson {
  const RtcEngineEventHandlerOnVideoSubscribeStateChangedJson(
      {this.channel,
      this.uid,
      this.oldState,
      this.newState,
      this.elapseSinceLastState});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'oldState')
  final StreamSubscribeState? oldState;
  @JsonKey(name: 'newState')
  final StreamSubscribeState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnVideoSubscribeStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioPublishStateChangedJson {
  const RtcEngineEventHandlerOnAudioPublishStateChangedJson(
      {this.channel, this.oldState, this.newState, this.elapseSinceLastState});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'oldState')
  final StreamPublishState? oldState;
  @JsonKey(name: 'newState')
  final StreamPublishState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnAudioPublishStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioPublishStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioPublishStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoPublishStateChangedJson {
  const RtcEngineEventHandlerOnVideoPublishStateChangedJson(
      {this.channel, this.oldState, this.newState, this.elapseSinceLastState});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'oldState')
  final StreamPublishState? oldState;
  @JsonKey(name: 'newState')
  final StreamPublishState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnVideoPublishStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoPublishStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoPublishStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionEventJson {
  const RtcEngineEventHandlerOnExtensionEventJson(
      {this.provider, this.extName, this.key, this.value});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'ext_name')
  final String? extName;
  @JsonKey(name: 'key')
  final String? key;
  @JsonKey(name: 'value')
  final String? value;
  factory RtcEngineEventHandlerOnExtensionEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionEventJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionStartedJson {
  const RtcEngineEventHandlerOnExtensionStartedJson(
      {this.provider, this.extName});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'ext_name')
  final String? extName;
  factory RtcEngineEventHandlerOnExtensionStartedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionStartedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionStartedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionStoppedJson {
  const RtcEngineEventHandlerOnExtensionStoppedJson(
      {this.provider, this.extName});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'ext_name')
  final String? extName;
  factory RtcEngineEventHandlerOnExtensionStoppedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionStoppedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionStoppedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionErroredJson {
  const RtcEngineEventHandlerOnExtensionErroredJson(
      {this.provider, this.extName, this.error, this.msg});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'ext_name')
  final String? extName;
  @JsonKey(name: 'error')
  final int? error;
  @JsonKey(name: 'msg')
  final String? msg;
  factory RtcEngineEventHandlerOnExtensionErroredJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionErroredJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionErroredJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserAccountUpdatedJson {
  const RtcEngineEventHandlerOnUserAccountUpdatedJson(
      {this.uid, this.userAccount});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'userAccount')
  final String? userAccount;
  factory RtcEngineEventHandlerOnUserAccountUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserAccountUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserAccountUpdatedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MetadataObserverOnMetadataReceivedJson {
  const MetadataObserverOnMetadataReceivedJson({this.metadata});

  @JsonKey(name: 'metadata')
  final Metadata? metadata;
  factory MetadataObserverOnMetadataReceivedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MetadataObserverOnMetadataReceivedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MetadataObserverOnMetadataReceivedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson {
  const DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson(
      {this.state, this.error, this.message});

  @JsonKey(name: 'state')
  final DirectCdnStreamingState? state;
  @JsonKey(name: 'error')
  final DirectCdnStreamingError? error;
  @JsonKey(name: 'message')
  final String? message;
  factory DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson {
  const DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson(
      {this.stats});

  @JsonKey(name: 'stats')
  final DirectCdnStreamingStats? stats;
  factory DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SnapshotCallbackOnSnapshotTakenJson {
  const SnapshotCallbackOnSnapshotTakenJson(
      {this.channel,
      this.uid,
      this.filePath,
      this.width,
      this.height,
      this.errCode});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'filePath')
  final String? filePath;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'errCode')
  final int? errCode;
  factory SnapshotCallbackOnSnapshotTakenJson.fromJson(
          Map<String, dynamic> json) =>
      _$SnapshotCallbackOnSnapshotTakenJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SnapshotCallbackOnSnapshotTakenJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerSourceStateChangedJson {
  const MediaPlayerSourceObserverOnPlayerSourceStateChangedJson(
      {this.state, this.ec});

  @JsonKey(name: 'state')
  final MediaPlayerState? state;
  @JsonKey(name: 'ec')
  final MediaPlayerError? ec;
  factory MediaPlayerSourceObserverOnPlayerSourceStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPositionChangedJson {
  const MediaPlayerSourceObserverOnPositionChangedJson({this.position});

  @JsonKey(name: 'position')
  final int? position;
  factory MediaPlayerSourceObserverOnPositionChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPositionChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPositionChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerEventJson {
  const MediaPlayerSourceObserverOnPlayerEventJson(
      {this.eventCode, this.elapsedTime, this.message});

  @JsonKey(name: 'eventCode')
  final MediaPlayerEvent? eventCode;
  @JsonKey(name: 'elapsedTime')
  final int? elapsedTime;
  @JsonKey(name: 'message')
  final String? message;
  factory MediaPlayerSourceObserverOnPlayerEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerEventJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnMetaDataJson {
  const MediaPlayerSourceObserverOnMetaDataJson({this.data, this.length});

  @JsonKey(name: 'data')
  final int? data;
  @JsonKey(name: 'length')
  final int? length;
  factory MediaPlayerSourceObserverOnMetaDataJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnMetaDataJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnMetaDataJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayBufferUpdatedJson {
  const MediaPlayerSourceObserverOnPlayBufferUpdatedJson(
      {this.playCachedBuffer});

  @JsonKey(name: 'playCachedBuffer')
  final int? playCachedBuffer;
  factory MediaPlayerSourceObserverOnPlayBufferUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPreloadEventJson {
  const MediaPlayerSourceObserverOnPreloadEventJson({this.src, this.event});

  @JsonKey(name: 'src')
  final String? src;
  @JsonKey(name: 'event')
  final PlayerPreloadEvent? event;
  factory MediaPlayerSourceObserverOnPreloadEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPreloadEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPreloadEventJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnCompletedJson {
  const MediaPlayerSourceObserverOnCompletedJson();

  factory MediaPlayerSourceObserverOnCompletedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnCompletedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnCompletedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson {
  const MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson();

  factory MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson {
  const MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson(
      {this.from, this.to});

  @JsonKey(name: 'from')
  final SrcInfo? from;
  @JsonKey(name: 'to')
  final SrcInfo? to;
  factory MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerSrcInfoChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerSrcInfoChangedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerInfoUpdatedJson {
  const MediaPlayerSourceObserverOnPlayerInfoUpdatedJson({this.info});

  @JsonKey(name: 'info')
  final PlayerUpdatedInfo? info;
  factory MediaPlayerSourceObserverOnPlayerInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerInfoUpdatedJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnAudioVolumeIndicationJson {
  const MediaPlayerSourceObserverOnAudioVolumeIndicationJson({this.volume});

  @JsonKey(name: 'volume')
  final int? volume;
  factory MediaPlayerSourceObserverOnAudioVolumeIndicationJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnJoinChannelSuccessExJson {
  const RtcEngineEventHandlerExOnJoinChannelSuccessExJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnJoinChannelSuccessExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnJoinChannelSuccessExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnJoinChannelSuccessExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRejoinChannelSuccessExJson {
  const RtcEngineEventHandlerExOnRejoinChannelSuccessExJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnRejoinChannelSuccessExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRejoinChannelSuccessExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRejoinChannelSuccessExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnAudioQualityExJson {
  const RtcEngineEventHandlerExOnAudioQualityExJson(
      {this.connection, this.remoteUid, this.quality, this.delay, this.lost});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'quality')
  final int? quality;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  factory RtcEngineEventHandlerExOnAudioQualityExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnAudioQualityExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnAudioQualityExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnAudioVolumeIndicationExJson {
  const RtcEngineEventHandlerExOnAudioVolumeIndicationExJson(
      {this.connection, this.speakers, this.speakerNumber, this.totalVolume});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'speakers')
  final AudioVolumeInfo? speakers;
  @JsonKey(name: 'speakerNumber')
  final int? speakerNumber;
  @JsonKey(name: 'totalVolume')
  final int? totalVolume;
  factory RtcEngineEventHandlerExOnAudioVolumeIndicationExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnAudioVolumeIndicationExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnAudioVolumeIndicationExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnLeaveChannelExJson {
  const RtcEngineEventHandlerExOnLeaveChannelExJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RtcStats? stats;
  factory RtcEngineEventHandlerExOnLeaveChannelExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnLeaveChannelExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnLeaveChannelExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRtcStatsExJson {
  const RtcEngineEventHandlerExOnRtcStatsExJson({this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RtcStats? stats;
  factory RtcEngineEventHandlerExOnRtcStatsExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRtcStatsExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRtcStatsExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnNetworkQualityExJson {
  const RtcEngineEventHandlerExOnNetworkQualityExJson(
      {this.connection, this.remoteUid, this.txQuality, this.rxQuality});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'txQuality')
  final int? txQuality;
  @JsonKey(name: 'rxQuality')
  final int? rxQuality;
  factory RtcEngineEventHandlerExOnNetworkQualityExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnNetworkQualityExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnNetworkQualityExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnIntraRequestReceivedExJson {
  const RtcEngineEventHandlerExOnIntraRequestReceivedExJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerExOnIntraRequestReceivedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnIntraRequestReceivedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnIntraRequestReceivedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnFirstLocalVideoFrameExJson {
  const RtcEngineEventHandlerExOnFirstLocalVideoFrameExJson(
      {this.connection, this.width, this.height, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnFirstLocalVideoFrameExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnFirstLocalVideoFrameExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnFirstLocalVideoFrameExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnFirstLocalVideoFramePublishedExJson {
  const RtcEngineEventHandlerExOnFirstLocalVideoFramePublishedExJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnFirstLocalVideoFramePublishedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnFirstLocalVideoFramePublishedExJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnFirstLocalVideoFramePublishedExJsonToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnVideoSourceFrameSizeChangedExJson {
  const RtcEngineEventHandlerExOnVideoSourceFrameSizeChangedExJson(
      {this.connection, this.sourceType, this.width, this.height});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory RtcEngineEventHandlerExOnVideoSourceFrameSizeChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnVideoSourceFrameSizeChangedExJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnVideoSourceFrameSizeChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnFirstRemoteVideoDecodedExJson {
  const RtcEngineEventHandlerExOnFirstRemoteVideoDecodedExJson(
      {this.connection, this.remoteUid, this.width, this.height, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnFirstRemoteVideoDecodedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnFirstRemoteVideoDecodedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnFirstRemoteVideoDecodedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnVideoSizeChangedExJson {
  const RtcEngineEventHandlerExOnVideoSizeChangedExJson(
      {this.connection, this.uid, this.width, this.height, this.rotation});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'rotation')
  final int? rotation;
  factory RtcEngineEventHandlerExOnVideoSizeChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnVideoSizeChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnVideoSizeChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnContentInspectResultExJson {
  const RtcEngineEventHandlerExOnContentInspectResultExJson({this.result});

  @JsonKey(name: 'result')
  final ContentInspectResult? result;
  factory RtcEngineEventHandlerExOnContentInspectResultExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnContentInspectResultExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnContentInspectResultExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnSnapshotTakenExJson {
  const RtcEngineEventHandlerExOnSnapshotTakenExJson(
      {this.connection, this.filePath, this.width, this.height, this.errCode});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'filePath')
  final String? filePath;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'errCode')
  final int? errCode;
  factory RtcEngineEventHandlerExOnSnapshotTakenExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnSnapshotTakenExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnSnapshotTakenExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnLocalVideoStateChangedExJson {
  const RtcEngineEventHandlerExOnLocalVideoStateChangedExJson(
      {this.connection, this.state, this.errorCode});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'state')
  final LocalVideoStreamState? state;
  @JsonKey(name: 'errorCode')
  final LocalVideoStreamError? errorCode;
  factory RtcEngineEventHandlerExOnLocalVideoStateChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnLocalVideoStateChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnLocalVideoStateChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRemoteVideoStateChangedExJson {
  const RtcEngineEventHandlerExOnRemoteVideoStateChangedExJson(
      {this.connection, this.remoteUid, this.state, this.reason, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'state')
  final RemoteVideoState? state;
  @JsonKey(name: 'reason')
  final RemoteVideoStateReason? reason;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnRemoteVideoStateChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRemoteVideoStateChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRemoteVideoStateChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnFirstRemoteVideoFrameExJson {
  const RtcEngineEventHandlerExOnFirstRemoteVideoFrameExJson(
      {this.connection, this.remoteUid, this.width, this.height, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnFirstRemoteVideoFrameExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnFirstRemoteVideoFrameExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnFirstRemoteVideoFrameExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserJoinedExJson {
  const RtcEngineEventHandlerExOnUserJoinedExJson(
      {this.connection, this.remoteUid, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnUserJoinedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserJoinedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserJoinedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserOfflineExJson {
  const RtcEngineEventHandlerExOnUserOfflineExJson(
      {this.connection, this.remoteUid, this.reason});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'reason')
  final UserOfflineReasonType? reason;
  factory RtcEngineEventHandlerExOnUserOfflineExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserOfflineExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserOfflineExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserMuteAudioExJson {
  const RtcEngineEventHandlerExOnUserMuteAudioExJson(
      {this.connection, this.remoteUid, this.muted});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerExOnUserMuteAudioExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserMuteAudioExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserMuteAudioExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserMuteVideoExJson {
  const RtcEngineEventHandlerExOnUserMuteVideoExJson(
      {this.connection, this.remoteUid, this.muted});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerExOnUserMuteVideoExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserMuteVideoExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserMuteVideoExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserEnableVideoExJson {
  const RtcEngineEventHandlerExOnUserEnableVideoExJson(
      {this.connection, this.remoteUid, this.enabled});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  factory RtcEngineEventHandlerExOnUserEnableVideoExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserEnableVideoExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserEnableVideoExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserEnableLocalVideoExJson {
  const RtcEngineEventHandlerExOnUserEnableLocalVideoExJson(
      {this.connection, this.remoteUid, this.enabled});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  factory RtcEngineEventHandlerExOnUserEnableLocalVideoExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserEnableLocalVideoExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserEnableLocalVideoExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserStateChangedExJson {
  const RtcEngineEventHandlerExOnUserStateChangedExJson(
      {this.connection, this.remoteUid, this.state});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'state')
  final int? state;
  factory RtcEngineEventHandlerExOnUserStateChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserStateChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserStateChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnLocalAudioStatsExJson {
  const RtcEngineEventHandlerExOnLocalAudioStatsExJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final LocalAudioStats? stats;
  factory RtcEngineEventHandlerExOnLocalAudioStatsExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnLocalAudioStatsExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnLocalAudioStatsExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRemoteAudioStatsExJson {
  const RtcEngineEventHandlerExOnRemoteAudioStatsExJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RemoteAudioStats? stats;
  factory RtcEngineEventHandlerExOnRemoteAudioStatsExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRemoteAudioStatsExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRemoteAudioStatsExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnLocalVideoStatsExJson {
  const RtcEngineEventHandlerExOnLocalVideoStatsExJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final LocalVideoStats? stats;
  factory RtcEngineEventHandlerExOnLocalVideoStatsExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnLocalVideoStatsExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnLocalVideoStatsExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRemoteVideoStatsExJson {
  const RtcEngineEventHandlerExOnRemoteVideoStatsExJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RemoteVideoStats? stats;
  factory RtcEngineEventHandlerExOnRemoteVideoStatsExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRemoteVideoStatsExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRemoteVideoStatsExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnConnectionLostExJson {
  const RtcEngineEventHandlerExOnConnectionLostExJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerExOnConnectionLostExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnConnectionLostExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnConnectionLostExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnConnectionInterruptedExJson {
  const RtcEngineEventHandlerExOnConnectionInterruptedExJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerExOnConnectionInterruptedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnConnectionInterruptedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnConnectionInterruptedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnConnectionBannedExJson {
  const RtcEngineEventHandlerExOnConnectionBannedExJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerExOnConnectionBannedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnConnectionBannedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnConnectionBannedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnStreamMessageExJson {
  const RtcEngineEventHandlerExOnStreamMessageExJson(
      {this.connection,
      this.remoteUid,
      this.streamId,
      this.data,
      this.length,
      this.sentTs});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'streamId')
  final int? streamId;
  @JsonKey(name: 'data', ignore: true)
  final Uint8List? data;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'sentTs')
  final int? sentTs;
  factory RtcEngineEventHandlerExOnStreamMessageExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnStreamMessageExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnStreamMessageExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnStreamMessageErrorExJson {
  const RtcEngineEventHandlerExOnStreamMessageErrorExJson(
      {this.connection,
      this.remoteUid,
      this.streamId,
      this.code,
      this.missed,
      this.cached});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'streamId')
  final int? streamId;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'missed')
  final int? missed;
  @JsonKey(name: 'cached')
  final int? cached;
  factory RtcEngineEventHandlerExOnStreamMessageErrorExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnStreamMessageErrorExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnStreamMessageErrorExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRequestTokenExJson {
  const RtcEngineEventHandlerExOnRequestTokenExJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerExOnRequestTokenExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRequestTokenExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRequestTokenExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnTokenPrivilegeWillExpireExJson {
  const RtcEngineEventHandlerExOnTokenPrivilegeWillExpireExJson(
      {this.connection, this.token});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'token')
  final String? token;
  factory RtcEngineEventHandlerExOnTokenPrivilegeWillExpireExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnTokenPrivilegeWillExpireExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnTokenPrivilegeWillExpireExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnFirstLocalAudioFramePublishedExJson {
  const RtcEngineEventHandlerExOnFirstLocalAudioFramePublishedExJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnFirstLocalAudioFramePublishedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnFirstLocalAudioFramePublishedExJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnFirstLocalAudioFramePublishedExJsonToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnFirstRemoteAudioFrameExJson {
  const RtcEngineEventHandlerExOnFirstRemoteAudioFrameExJson(
      {this.connection, this.userId, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnFirstRemoteAudioFrameExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnFirstRemoteAudioFrameExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnFirstRemoteAudioFrameExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnFirstRemoteAudioDecodedExJson {
  const RtcEngineEventHandlerExOnFirstRemoteAudioDecodedExJson(
      {this.connection, this.uid, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnFirstRemoteAudioDecodedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnFirstRemoteAudioDecodedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnFirstRemoteAudioDecodedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnLocalAudioStateChangedExJson {
  const RtcEngineEventHandlerExOnLocalAudioStateChangedExJson(
      {this.connection, this.state, this.error});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'state')
  final LocalAudioStreamState? state;
  @JsonKey(name: 'error')
  final LocalAudioStreamError? error;
  factory RtcEngineEventHandlerExOnLocalAudioStateChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnLocalAudioStateChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnLocalAudioStateChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRemoteAudioStateChangedExJson {
  const RtcEngineEventHandlerExOnRemoteAudioStateChangedExJson(
      {this.connection, this.remoteUid, this.state, this.reason, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'state')
  final RemoteAudioState? state;
  @JsonKey(name: 'reason')
  final RemoteAudioStateReason? reason;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerExOnRemoteAudioStateChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRemoteAudioStateChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRemoteAudioStateChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnActiveSpeakerExJson {
  const RtcEngineEventHandlerExOnActiveSpeakerExJson(
      {this.connection, this.uid});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'uid')
  final int? uid;
  factory RtcEngineEventHandlerExOnActiveSpeakerExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnActiveSpeakerExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnActiveSpeakerExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnClientRoleChangedExJson {
  const RtcEngineEventHandlerExOnClientRoleChangedExJson(
      {this.connection, this.oldRole, this.newRole});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'oldRole')
  final ClientRoleType? oldRole;
  @JsonKey(name: 'newRole')
  final ClientRoleType? newRole;
  factory RtcEngineEventHandlerExOnClientRoleChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnClientRoleChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnClientRoleChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnClientRoleChangeFailedExJson {
  const RtcEngineEventHandlerExOnClientRoleChangeFailedExJson(
      {this.connection, this.reason, this.currentRole});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'reason')
  final ClientRoleChangeFailedReason? reason;
  @JsonKey(name: 'currentRole')
  final ClientRoleType? currentRole;
  factory RtcEngineEventHandlerExOnClientRoleChangeFailedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnClientRoleChangeFailedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnClientRoleChangeFailedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRemoteAudioTransportStatsExJson {
  const RtcEngineEventHandlerExOnRemoteAudioTransportStatsExJson(
      {this.connection,
      this.remoteUid,
      this.delay,
      this.lost,
      this.rxKBitRate});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;
  factory RtcEngineEventHandlerExOnRemoteAudioTransportStatsExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRemoteAudioTransportStatsExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRemoteAudioTransportStatsExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnRemoteVideoTransportStatsExJson {
  const RtcEngineEventHandlerExOnRemoteVideoTransportStatsExJson(
      {this.connection,
      this.remoteUid,
      this.delay,
      this.lost,
      this.rxKBitRate});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;
  factory RtcEngineEventHandlerExOnRemoteVideoTransportStatsExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnRemoteVideoTransportStatsExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnRemoteVideoTransportStatsExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnConnectionStateChangedExJson {
  const RtcEngineEventHandlerExOnConnectionStateChangedExJson(
      {this.connection, this.state, this.reason});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'state')
  final ConnectionStateType? state;
  @JsonKey(name: 'reason')
  final ConnectionChangedReasonType? reason;
  factory RtcEngineEventHandlerExOnConnectionStateChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnConnectionStateChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnConnectionStateChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnNetworkTypeChangedExJson {
  const RtcEngineEventHandlerExOnNetworkTypeChangedExJson(
      {this.connection, this.type});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'type')
  final NetworkType? type;
  factory RtcEngineEventHandlerExOnNetworkTypeChangedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnNetworkTypeChangedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnNetworkTypeChangedExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnEncryptionErrorExJson {
  const RtcEngineEventHandlerExOnEncryptionErrorExJson(
      {this.connection, this.errorType});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'errorType')
  final EncryptionErrorType? errorType;
  factory RtcEngineEventHandlerExOnEncryptionErrorExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnEncryptionErrorExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnEncryptionErrorExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUploadLogResultExJson {
  const RtcEngineEventHandlerExOnUploadLogResultExJson(
      {this.connection, this.requestId, this.success, this.reason});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'requestId')
  final String? requestId;
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'reason')
  final UploadErrorReason? reason;
  factory RtcEngineEventHandlerExOnUploadLogResultExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUploadLogResultExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUploadLogResultExJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerExOnUserAccountUpdatedExJson {
  const RtcEngineEventHandlerExOnUserAccountUpdatedExJson(
      {this.connection, this.remoteUid, this.userAccount});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'userAccount')
  final String? userAccount;
  factory RtcEngineEventHandlerExOnUserAccountUpdatedExJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerExOnUserAccountUpdatedExJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerExOnUserAccountUpdatedExJsonToJson(this);
}
