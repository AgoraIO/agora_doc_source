import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

extension RtcEngineEventHandlerExt on RtcEngineEventHandler {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
<<<<<<< HEAD
      case 'onJoinChannelSuccessEx':
        if (onJoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnJoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnJoinChannelSuccessJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onJoinChannelSuccess!(connection, elapsed);
        break;

      case 'onRejoinChannelSuccessEx':
        if (onRejoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnRejoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnRejoinChannelSuccessJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onRejoinChannelSuccess!(connection, elapsed);
=======
      case 'onJoinChannelSuccess':
        if (onJoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnJoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnJoinChannelSuccessJson.fromJson(jsonMap);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (channel == null || uid == null || elapsed == null) {
          break;
        }
        onJoinChannelSuccess!(channel, uid, elapsed);
        break;

      case 'onRejoinChannelSuccess':
        if (onRejoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnRejoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnRejoinChannelSuccessJson.fromJson(jsonMap);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (channel == null || uid == null || elapsed == null) {
          break;
        }
        onRejoinChannelSuccess!(channel, uid, elapsed);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onWarning':
        if (onWarning == null) break;
        RtcEngineEventHandlerOnWarningJson paramJson =
            RtcEngineEventHandlerOnWarningJson.fromJson(jsonMap);
        int? warn = paramJson.warn;
        String? msg = paramJson.msg;
        if (warn == null || msg == null) {
          break;
        }
        onWarning!(warn, msg);
        break;

      case 'onError':
        if (onError == null) break;
        RtcEngineEventHandlerOnErrorJson paramJson =
            RtcEngineEventHandlerOnErrorJson.fromJson(jsonMap);
        int? err = paramJson.err;
        String? msg = paramJson.msg;
        if (err == null || msg == null) {
          break;
        }
        onError!(err, msg);
        break;

<<<<<<< HEAD
      case 'onAudioQualityEx':
        if (onAudioQuality == null) break;
        RtcEngineEventHandlerOnAudioQualityJson paramJson =
            RtcEngineEventHandlerOnAudioQualityJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? quality = paramJson.quality;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        if (connection == null ||
            remoteUid == null ||
            quality == null ||
            delay == null ||
            lost == null) {
          break;
        }
        onAudioQuality!(connection, remoteUid, quality, delay, lost);
=======
      case 'onAudioQuality':
        if (onAudioQuality == null) break;
        RtcEngineEventHandlerOnAudioQualityJson paramJson =
            RtcEngineEventHandlerOnAudioQualityJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        int? quality = paramJson.quality;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        if (uid == null || quality == null || delay == null || lost == null) {
          break;
        }
        onAudioQuality!(uid, quality, delay, lost);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onLastmileProbeResult':
        if (onLastmileProbeResult == null) break;
        RtcEngineEventHandlerOnLastmileProbeResultJson paramJson =
            RtcEngineEventHandlerOnLastmileProbeResultJson.fromJson(jsonMap);
        LastmileProbeResult? result = paramJson.result;
        if (result == null) {
          break;
        }
        onLastmileProbeResult!(result);
        break;

<<<<<<< HEAD
      case 'onAudioVolumeIndicationEx':
        if (onAudioVolumeIndication == null) break;
        RtcEngineEventHandlerOnAudioVolumeIndicationJson paramJson =
            RtcEngineEventHandlerOnAudioVolumeIndicationJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        AudioVolumeInfo? speakers = paramJson.speakers;
        int? speakerNumber = paramJson.speakerNumber;
        int? totalVolume = paramJson.totalVolume;
        if (connection == null ||
            speakers == null ||
            speakerNumber == null ||
            totalVolume == null) {
          break;
        }
        onAudioVolumeIndication!(
            connection, speakers, speakerNumber, totalVolume);
        break;

      case 'onLeaveChannelEx':
        if (onLeaveChannel == null) break;
        RtcEngineEventHandlerOnLeaveChannelJson paramJson =
            RtcEngineEventHandlerOnLeaveChannelJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLeaveChannel!(connection, stats);
        break;

      case 'onRtcStatsEx':
        if (onRtcStats == null) break;
        RtcEngineEventHandlerOnRtcStatsJson paramJson =
            RtcEngineEventHandlerOnRtcStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRtcStats!(connection, stats);
=======
      case 'onAudioVolumeIndication':
        if (onAudioVolumeIndication == null) break;
        RtcEngineEventHandlerOnAudioVolumeIndicationJson paramJson =
            RtcEngineEventHandlerOnAudioVolumeIndicationJson.fromJson(jsonMap);
        AudioVolumeInfo? speakers = paramJson.speakers;
        int? speakerNumber = paramJson.speakerNumber;
        int? totalVolume = paramJson.totalVolume;
        if (speakers == null || speakerNumber == null || totalVolume == null) {
          break;
        }
        onAudioVolumeIndication!(speakers, speakerNumber, totalVolume);
        break;

      case 'onLeaveChannel':
        if (onLeaveChannel == null) break;
        RtcEngineEventHandlerOnLeaveChannelJson paramJson =
            RtcEngineEventHandlerOnLeaveChannelJson.fromJson(jsonMap);
        RtcStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onLeaveChannel!(stats);
        break;

      case 'onRtcStats':
        if (onRtcStats == null) break;
        RtcEngineEventHandlerOnRtcStatsJson paramJson =
            RtcEngineEventHandlerOnRtcStatsJson.fromJson(jsonMap);
        RtcStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onRtcStats!(stats);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onAudioDeviceStateChanged':
        if (onAudioDeviceStateChanged == null) break;
        RtcEngineEventHandlerOnAudioDeviceStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceStateChangedJson.fromJson(
                jsonMap);
        String? deviceId = paramJson.deviceId;
        int? deviceType = paramJson.deviceType;
        int? deviceState = paramJson.deviceState;
        if (deviceId == null || deviceType == null || deviceState == null) {
          break;
        }
        onAudioDeviceStateChanged!(deviceId, deviceType, deviceState);
        break;

      case 'onAudioMixingFinished':
        if (onAudioMixingFinished == null) break;
        RtcEngineEventHandlerOnAudioMixingFinishedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingFinishedJson.fromJson(jsonMap);
        onAudioMixingFinished!();
        break;

      case 'onAudioEffectFinished':
        if (onAudioEffectFinished == null) break;
        RtcEngineEventHandlerOnAudioEffectFinishedJson paramJson =
            RtcEngineEventHandlerOnAudioEffectFinishedJson.fromJson(jsonMap);
        int? soundId = paramJson.soundId;
        if (soundId == null) {
          break;
        }
        onAudioEffectFinished!(soundId);
        break;

      case 'onVideoDeviceStateChanged':
        if (onVideoDeviceStateChanged == null) break;
        RtcEngineEventHandlerOnVideoDeviceStateChangedJson paramJson =
            RtcEngineEventHandlerOnVideoDeviceStateChangedJson.fromJson(
                jsonMap);
        String? deviceId = paramJson.deviceId;
        int? deviceType = paramJson.deviceType;
        int? deviceState = paramJson.deviceState;
        if (deviceId == null || deviceType == null || deviceState == null) {
          break;
        }
        onVideoDeviceStateChanged!(deviceId, deviceType, deviceState);
        break;

      case 'onMediaDeviceChanged':
        if (onMediaDeviceChanged == null) break;
        RtcEngineEventHandlerOnMediaDeviceChangedJson paramJson =
            RtcEngineEventHandlerOnMediaDeviceChangedJson.fromJson(jsonMap);
        int? deviceType = paramJson.deviceType;
        if (deviceType == null) {
          break;
        }
        onMediaDeviceChanged!(deviceType);
        break;

<<<<<<< HEAD
      case 'onNetworkQualityEx':
        if (onNetworkQuality == null) break;
        RtcEngineEventHandlerOnNetworkQualityJson paramJson =
            RtcEngineEventHandlerOnNetworkQualityJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? txQuality = paramJson.txQuality;
        int? rxQuality = paramJson.rxQuality;
        if (connection == null ||
            remoteUid == null ||
            txQuality == null ||
            rxQuality == null) {
          break;
        }
        onNetworkQuality!(connection, remoteUid, txQuality, rxQuality);
        break;

      case 'onIntraRequestReceivedEx':
        if (onIntraRequestReceived == null) break;
        RtcEngineEventHandlerOnIntraRequestReceivedJson paramJson =
            RtcEngineEventHandlerOnIntraRequestReceivedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onIntraRequestReceived!(connection);
=======
      case 'onNetworkQuality':
        if (onNetworkQuality == null) break;
        RtcEngineEventHandlerOnNetworkQualityJson paramJson =
            RtcEngineEventHandlerOnNetworkQualityJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        int? txQuality = paramJson.txQuality;
        int? rxQuality = paramJson.rxQuality;
        if (uid == null || txQuality == null || rxQuality == null) {
          break;
        }
        onNetworkQuality!(uid, txQuality, rxQuality);
        break;

      case 'onIntraRequestReceived':
        if (onIntraRequestReceived == null) break;
        RtcEngineEventHandlerOnIntraRequestReceivedJson paramJson =
            RtcEngineEventHandlerOnIntraRequestReceivedJson.fromJson(jsonMap);
        onIntraRequestReceived!();
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onUplinkNetworkInfoUpdated':
        if (onUplinkNetworkInfoUpdated == null) break;
        RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        UplinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        onUplinkNetworkInfoUpdated!(info);
        break;

      case 'onDownlinkNetworkInfoUpdated':
        if (onDownlinkNetworkInfoUpdated == null) break;
        RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        DownlinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        onDownlinkNetworkInfoUpdated!(info);
        break;

      case 'onLastmileQuality':
        if (onLastmileQuality == null) break;
        RtcEngineEventHandlerOnLastmileQualityJson paramJson =
            RtcEngineEventHandlerOnLastmileQualityJson.fromJson(jsonMap);
        int? quality = paramJson.quality;
        if (quality == null) {
          break;
        }
        onLastmileQuality!(quality);
        break;

<<<<<<< HEAD
      case 'onFirstLocalVideoFrameEx':
        if (onFirstLocalVideoFrame == null) break;
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFrameJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            width == null ||
            height == null ||
            elapsed == null) {
          break;
        }
        onFirstLocalVideoFrame!(connection, width, height, elapsed);
        break;

      case 'onFirstLocalVideoFramePublishedEx':
=======
      case 'onFirstLocalVideoFrame':
        if (onFirstLocalVideoFrame == null) break;
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFrameJson.fromJson(jsonMap);
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (width == null || height == null || elapsed == null) {
          break;
        }
        onFirstLocalVideoFrame!(width, height, elapsed);
        break;

      case 'onFirstLocalVideoFramePublished':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onFirstLocalVideoFramePublished == null) break;
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onFirstLocalVideoFramePublished!(connection, elapsed);
        break;

      case 'onVideoSourceFrameSizeChangedEx':
=======
        int? elapsed = paramJson.elapsed;
        if (elapsed == null) {
          break;
        }
        onFirstLocalVideoFramePublished!(elapsed);
        break;

      case 'onVideoSourceFrameSizeChanged':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onVideoSourceFrameSizeChanged == null) break;
        RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        VideoSourceType? sourceType = paramJson.sourceType;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (connection == null ||
            sourceType == null ||
            width == null ||
            height == null) {
          break;
        }
        onVideoSourceFrameSizeChanged!(connection, sourceType, width, height);
        break;

      case 'onFirstRemoteVideoDecodedEx':
=======
        VideoSourceType? sourceType = paramJson.sourceType;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (sourceType == null || width == null || height == null) {
          break;
        }
        onVideoSourceFrameSizeChanged!(sourceType, width, height);
        break;

      case 'onFirstRemoteVideoDecoded':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onFirstRemoteVideoDecoded == null) break;
        RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
            width == null ||
            height == null ||
            elapsed == null) {
          break;
        }
        onFirstRemoteVideoDecoded!(
            connection, remoteUid, width, height, elapsed);
        break;

      case 'onVideoSizeChangedEx':
        if (onVideoSizeChanged == null) break;
        RtcEngineEventHandlerOnVideoSizeChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSizeChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
=======
        int? uid = paramJson.uid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (uid == null || width == null || height == null || elapsed == null) {
          break;
        }
        onFirstRemoteVideoDecoded!(uid, width, height, elapsed);
        break;

      case 'onVideoSizeChanged':
        if (onVideoSizeChanged == null) break;
        RtcEngineEventHandlerOnVideoSizeChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSizeChangedJson.fromJson(jsonMap);
>>>>>>> release/rtc-ng/3.8.200-framework
        int? uid = paramJson.uid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? rotation = paramJson.rotation;
<<<<<<< HEAD
        if (connection == null ||
            uid == null ||
=======
        if (uid == null ||
>>>>>>> release/rtc-ng/3.8.200-framework
            width == null ||
            height == null ||
            rotation == null) {
          break;
        }
<<<<<<< HEAD
        onVideoSizeChanged!(connection, uid, width, height, rotation);
        break;

      case 'onLocalVideoStateChangedEx':
        if (onLocalVideoStateChanged == null) break;
        RtcEngineEventHandlerOnLocalVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStreamState? state = paramJson.state;
        LocalVideoStreamError? errorCode = paramJson.errorCode;
        if (connection == null || state == null || errorCode == null) {
          break;
        }
        onLocalVideoStateChanged!(connection, state, errorCode);
        break;

      case 'onRemoteVideoStateChangedEx':
=======
        onVideoSizeChanged!(uid, width, height, rotation);
        break;

      case 'onLocalVideoStateChanged':
        if (onLocalVideoStateChanged == null) break;
        RtcEngineEventHandlerOnLocalVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStateChangedJson.fromJson(jsonMap);
        LocalVideoStreamState? state = paramJson.state;
        LocalVideoStreamError? error = paramJson.error;
        if (state == null || error == null) {
          break;
        }
        onLocalVideoStateChanged!(state, error);
        break;

      case 'onRemoteVideoStateChanged':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onRemoteVideoStateChanged == null) break;
        RtcEngineEventHandlerOnRemoteVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStateChangedJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        RemoteVideoState? state = paramJson.state;
        RemoteVideoStateReason? reason = paramJson.reason;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
            state == null ||
            reason == null ||
            elapsed == null) {
          break;
        }
        onRemoteVideoStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onFirstRemoteVideoFrameEx':
        if (onFirstRemoteVideoFrame == null) break;
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteVideoFrameJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
=======
        int? uid = paramJson.uid;
        RemoteVideoState? state = paramJson.state;
        RemoteVideoStateReason? reason = paramJson.reason;
        int? elapsed = paramJson.elapsed;
        if (uid == null || state == null || reason == null || elapsed == null) {
          break;
        }
        onRemoteVideoStateChanged!(uid, state, reason, elapsed);
        break;

      case 'onFirstRemoteVideoFrame':
        if (onFirstRemoteVideoFrame == null) break;
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteVideoFrameJson.fromJson(jsonMap);
        int? userId = paramJson.userId;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (userId == null ||
>>>>>>> release/rtc-ng/3.8.200-framework
            width == null ||
            height == null ||
            elapsed == null) {
          break;
        }
<<<<<<< HEAD
        onFirstRemoteVideoFrame!(connection, remoteUid, width, height, elapsed);
        break;

      case 'onUserJoinedEx':
        if (onUserJoined == null) break;
        RtcEngineEventHandlerOnUserJoinedJson paramJson =
            RtcEngineEventHandlerOnUserJoinedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || remoteUid == null || elapsed == null) {
          break;
        }
        onUserJoined!(connection, remoteUid, elapsed);
        break;

      case 'onUserOfflineEx':
        if (onUserOffline == null) break;
        RtcEngineEventHandlerOnUserOfflineJson paramJson =
            RtcEngineEventHandlerOnUserOfflineJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        UserOfflineReasonType? reason = paramJson.reason;
        if (connection == null || remoteUid == null || reason == null) {
          break;
        }
        onUserOffline!(connection, remoteUid, reason);
        break;

      case 'onUserMuteAudioEx':
        if (onUserMuteAudio == null) break;
        RtcEngineEventHandlerOnUserMuteAudioJson paramJson =
            RtcEngineEventHandlerOnUserMuteAudioJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        onUserMuteAudio!(connection, remoteUid, muted);
        break;

      case 'onUserMuteVideoEx':
        if (onUserMuteVideo == null) break;
        RtcEngineEventHandlerOnUserMuteVideoJson paramJson =
            RtcEngineEventHandlerOnUserMuteVideoJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        onUserMuteVideo!(connection, remoteUid, muted);
        break;

      case 'onUserEnableVideoEx':
        if (onUserEnableVideo == null) break;
        RtcEngineEventHandlerOnUserEnableVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableVideoJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        onUserEnableVideo!(connection, remoteUid, enabled);
        break;

      case 'onUserStateChangedEx':
        if (onUserStateChanged == null) break;
        RtcEngineEventHandlerOnUserStateChangedJson paramJson =
            RtcEngineEventHandlerOnUserStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? state = paramJson.state;
        if (connection == null || remoteUid == null || state == null) {
          break;
        }
        onUserStateChanged!(connection, remoteUid, state);
        break;

      case 'onUserEnableLocalVideoEx':
        if (onUserEnableLocalVideo == null) break;
        RtcEngineEventHandlerOnUserEnableLocalVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableLocalVideoJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        onUserEnableLocalVideo!(connection, remoteUid, enabled);
=======
        onFirstRemoteVideoFrame!(userId, width, height, elapsed);
        break;

      case 'onUserJoined':
        if (onUserJoined == null) break;
        RtcEngineEventHandlerOnUserJoinedJson paramJson =
            RtcEngineEventHandlerOnUserJoinedJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (uid == null || elapsed == null) {
          break;
        }
        onUserJoined!(uid, elapsed);
        break;

      case 'onUserOffline':
        if (onUserOffline == null) break;
        RtcEngineEventHandlerOnUserOfflineJson paramJson =
            RtcEngineEventHandlerOnUserOfflineJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        UserOfflineReasonType? reason = paramJson.reason;
        if (uid == null || reason == null) {
          break;
        }
        onUserOffline!(uid, reason);
        break;

      case 'onUserMuteAudio':
        if (onUserMuteAudio == null) break;
        RtcEngineEventHandlerOnUserMuteAudioJson paramJson =
            RtcEngineEventHandlerOnUserMuteAudioJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        bool? muted = paramJson.muted;
        if (uid == null || muted == null) {
          break;
        }
        onUserMuteAudio!(uid, muted);
        break;

      case 'onUserMuteVideo':
        if (onUserMuteVideo == null) break;
        RtcEngineEventHandlerOnUserMuteVideoJson paramJson =
            RtcEngineEventHandlerOnUserMuteVideoJson.fromJson(jsonMap);
        int? userId = paramJson.userId;
        bool? muted = paramJson.muted;
        if (userId == null || muted == null) {
          break;
        }
        onUserMuteVideo!(userId, muted);
        break;

      case 'onUserEnableVideo':
        if (onUserEnableVideo == null) break;
        RtcEngineEventHandlerOnUserEnableVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableVideoJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        bool? enabled = paramJson.enabled;
        if (uid == null || enabled == null) {
          break;
        }
        onUserEnableVideo!(uid, enabled);
        break;

      case 'onUserStateChanged':
        if (onUserStateChanged == null) break;
        RtcEngineEventHandlerOnUserStateChangedJson paramJson =
            RtcEngineEventHandlerOnUserStateChangedJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        int? state = paramJson.state;
        if (uid == null || state == null) {
          break;
        }
        onUserStateChanged!(uid, state);
        break;

      case 'onUserEnableLocalVideo':
        if (onUserEnableLocalVideo == null) break;
        RtcEngineEventHandlerOnUserEnableLocalVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableLocalVideoJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        bool? enabled = paramJson.enabled;
        if (uid == null || enabled == null) {
          break;
        }
        onUserEnableLocalVideo!(uid, enabled);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onApiCallExecuted':
        if (onApiCallExecuted == null) break;
        RtcEngineEventHandlerOnApiCallExecutedJson paramJson =
            RtcEngineEventHandlerOnApiCallExecutedJson.fromJson(jsonMap);
        int? err = paramJson.err;
        String? api = paramJson.api;
        String? result = paramJson.result;
        if (err == null || api == null || result == null) {
          break;
        }
        onApiCallExecuted!(err, api, result);
        break;

<<<<<<< HEAD
      case 'onLocalAudioStatsEx':
        if (onLocalAudioStats == null) break;
        RtcEngineEventHandlerOnLocalAudioStatsJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLocalAudioStats!(connection, stats);
        break;

      case 'onRemoteAudioStatsEx':
        if (onRemoteAudioStats == null) break;
        RtcEngineEventHandlerOnRemoteAudioStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RemoteAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRemoteAudioStats!(connection, stats);
        break;

      case 'onLocalVideoStatsEx':
        if (onLocalVideoStats == null) break;
        RtcEngineEventHandlerOnLocalVideoStatsJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLocalVideoStats!(connection, stats);
        break;

      case 'onRemoteVideoStatsEx':
        if (onRemoteVideoStats == null) break;
        RtcEngineEventHandlerOnRemoteVideoStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RemoteVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRemoteVideoStats!(connection, stats);
=======
      case 'onLocalAudioStats':
        if (onLocalAudioStats == null) break;
        RtcEngineEventHandlerOnLocalAudioStatsJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStatsJson.fromJson(jsonMap);
        LocalAudioStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onLocalAudioStats!(stats);
        break;

      case 'onRemoteAudioStats':
        if (onRemoteAudioStats == null) break;
        RtcEngineEventHandlerOnRemoteAudioStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStatsJson.fromJson(jsonMap);
        RemoteAudioStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onRemoteAudioStats!(stats);
        break;

      case 'onLocalVideoStats':
        if (onLocalVideoStats == null) break;
        RtcEngineEventHandlerOnLocalVideoStatsJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStatsJson.fromJson(jsonMap);
        LocalVideoStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onLocalVideoStats!(stats);
        break;

      case 'onRemoteVideoStats':
        if (onRemoteVideoStats == null) break;
        RtcEngineEventHandlerOnRemoteVideoStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStatsJson.fromJson(jsonMap);
        RemoteVideoStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onRemoteVideoStats!(stats);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onCameraReady':
        if (onCameraReady == null) break;
        RtcEngineEventHandlerOnCameraReadyJson paramJson =
            RtcEngineEventHandlerOnCameraReadyJson.fromJson(jsonMap);
        onCameraReady!();
        break;

      case 'onCameraFocusAreaChanged':
        if (onCameraFocusAreaChanged == null) break;
        RtcEngineEventHandlerOnCameraFocusAreaChangedJson paramJson =
            RtcEngineEventHandlerOnCameraFocusAreaChangedJson.fromJson(jsonMap);
        int? x = paramJson.x;
        int? y = paramJson.y;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (x == null || y == null || width == null || height == null) {
          break;
        }
        onCameraFocusAreaChanged!(x, y, width, height);
        break;

      case 'onCameraExposureAreaChanged':
        if (onCameraExposureAreaChanged == null) break;
        RtcEngineEventHandlerOnCameraExposureAreaChangedJson paramJson =
            RtcEngineEventHandlerOnCameraExposureAreaChangedJson.fromJson(
                jsonMap);
        int? x = paramJson.x;
        int? y = paramJson.y;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (x == null || y == null || width == null || height == null) {
          break;
        }
        onCameraExposureAreaChanged!(x, y, width, height);
        break;

      case 'onFacePositionChanged':
        if (onFacePositionChanged == null) break;
        RtcEngineEventHandlerOnFacePositionChangedJson paramJson =
            RtcEngineEventHandlerOnFacePositionChangedJson.fromJson(jsonMap);
        int? imageWidth = paramJson.imageWidth;
        int? imageHeight = paramJson.imageHeight;
        Rectangle? vecRectangle = paramJson.vecRectangle;
        int? vecDistance = paramJson.vecDistance;
        int? numFaces = paramJson.numFaces;
        if (imageWidth == null ||
            imageHeight == null ||
            vecRectangle == null ||
            vecDistance == null ||
            numFaces == null) {
          break;
        }
        onFacePositionChanged!(
            imageWidth, imageHeight, vecRectangle, vecDistance, numFaces);
        break;

      case 'onVideoStopped':
        if (onVideoStopped == null) break;
        RtcEngineEventHandlerOnVideoStoppedJson paramJson =
            RtcEngineEventHandlerOnVideoStoppedJson.fromJson(jsonMap);
        onVideoStopped!();
        break;

      case 'onAudioMixingStateChanged':
        if (onAudioMixingStateChanged == null) break;
        RtcEngineEventHandlerOnAudioMixingStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingStateChangedJson.fromJson(
                jsonMap);
        AudioMixingStateType? state = paramJson.state;
        AudioMixingErrorType? errorCode = paramJson.errorCode;
        if (state == null || errorCode == null) {
          break;
        }
        onAudioMixingStateChanged!(state, errorCode);
        break;

      case 'onRhythmPlayerStateChanged':
        if (onRhythmPlayerStateChanged == null) break;
        RtcEngineEventHandlerOnRhythmPlayerStateChangedJson paramJson =
            RtcEngineEventHandlerOnRhythmPlayerStateChangedJson.fromJson(
                jsonMap);
        RhythmPlayerStateType? state = paramJson.state;
        RhythmPlayerErrorType? errorCode = paramJson.errorCode;
        if (state == null || errorCode == null) {
          break;
        }
        onRhythmPlayerStateChanged!(state, errorCode);
        break;

<<<<<<< HEAD
      case 'onConnectionLostEx':
        if (onConnectionLost == null) break;
        RtcEngineEventHandlerOnConnectionLostJson paramJson =
            RtcEngineEventHandlerOnConnectionLostJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionLost!(connection);
        break;

      case 'onConnectionInterruptedEx':
        if (onConnectionInterrupted == null) break;
        RtcEngineEventHandlerOnConnectionInterruptedJson paramJson =
            RtcEngineEventHandlerOnConnectionInterruptedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionInterrupted!(connection);
        break;

      case 'onConnectionBannedEx':
        if (onConnectionBanned == null) break;
        RtcEngineEventHandlerOnConnectionBannedJson paramJson =
            RtcEngineEventHandlerOnConnectionBannedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionBanned!(connection);
        break;

      case 'onStreamMessageEx':
        if (onStreamMessage == null) break;
        RtcEngineEventHandlerOnStreamMessageJson paramJson =
            RtcEngineEventHandlerOnStreamMessageJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
=======
      case 'onConnectionLost':
        if (onConnectionLost == null) break;
        RtcEngineEventHandlerOnConnectionLostJson paramJson =
            RtcEngineEventHandlerOnConnectionLostJson.fromJson(jsonMap);
        onConnectionLost!();
        break;

      case 'onConnectionInterrupted':
        if (onConnectionInterrupted == null) break;
        RtcEngineEventHandlerOnConnectionInterruptedJson paramJson =
            RtcEngineEventHandlerOnConnectionInterruptedJson.fromJson(jsonMap);
        onConnectionInterrupted!();
        break;

      case 'onConnectionBanned':
        if (onConnectionBanned == null) break;
        RtcEngineEventHandlerOnConnectionBannedJson paramJson =
            RtcEngineEventHandlerOnConnectionBannedJson.fromJson(jsonMap);
        onConnectionBanned!();
        break;

      case 'onStreamMessage':
        if (onStreamMessage == null) break;
        RtcEngineEventHandlerOnStreamMessageJson paramJson =
            RtcEngineEventHandlerOnStreamMessageJson.fromJson(jsonMap);
        int? userId = paramJson.userId;
>>>>>>> release/rtc-ng/3.8.200-framework
        int? streamId = paramJson.streamId;
        Uint8List? data = paramJson.data;
        int? length = paramJson.length;
        int? sentTs = paramJson.sentTs;
<<<<<<< HEAD
        if (connection == null ||
            remoteUid == null ||
=======
        if (userId == null ||
>>>>>>> release/rtc-ng/3.8.200-framework
            streamId == null ||
            data == null ||
            length == null ||
            sentTs == null) {
          break;
        }
<<<<<<< HEAD
        onStreamMessage!(connection, remoteUid, streamId, data, length, sentTs);
        break;

      case 'onStreamMessageErrorEx':
        if (onStreamMessageError == null) break;
        RtcEngineEventHandlerOnStreamMessageErrorJson paramJson =
            RtcEngineEventHandlerOnStreamMessageErrorJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
=======
        onStreamMessage!(userId, streamId, data, length, sentTs);
        break;

      case 'onStreamMessageError':
        if (onStreamMessageError == null) break;
        RtcEngineEventHandlerOnStreamMessageErrorJson paramJson =
            RtcEngineEventHandlerOnStreamMessageErrorJson.fromJson(jsonMap);
        int? userId = paramJson.userId;
>>>>>>> release/rtc-ng/3.8.200-framework
        int? streamId = paramJson.streamId;
        int? code = paramJson.code;
        int? missed = paramJson.missed;
        int? cached = paramJson.cached;
<<<<<<< HEAD
        if (connection == null ||
            remoteUid == null ||
=======
        if (userId == null ||
>>>>>>> release/rtc-ng/3.8.200-framework
            streamId == null ||
            code == null ||
            missed == null ||
            cached == null) {
          break;
        }
<<<<<<< HEAD
        onStreamMessageError!(
            connection, remoteUid, streamId, code, missed, cached);
        break;

      case 'onRequestTokenEx':
        if (onRequestToken == null) break;
        RtcEngineEventHandlerOnRequestTokenJson paramJson =
            RtcEngineEventHandlerOnRequestTokenJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onRequestToken!(connection);
        break;

      case 'onTokenPrivilegeWillExpireEx':
=======
        onStreamMessageError!(userId, streamId, code, missed, cached);
        break;

      case 'onRequestToken':
        if (onRequestToken == null) break;
        RtcEngineEventHandlerOnRequestTokenJson paramJson =
            RtcEngineEventHandlerOnRequestTokenJson.fromJson(jsonMap);
        onRequestToken!();
        break;

      case 'onTokenPrivilegeWillExpire':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onTokenPrivilegeWillExpire == null) break;
        RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson paramJson =
            RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        String? token = paramJson.token;
        if (connection == null || token == null) {
          break;
        }
        onTokenPrivilegeWillExpire!(connection, token);
        break;

      case 'onFirstLocalAudioFramePublishedEx':
=======
        String? token = paramJson.token;
        if (token == null) {
          break;
        }
        onTokenPrivilegeWillExpire!(token);
        break;

      case 'onFirstLocalAudioFramePublished':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onFirstLocalAudioFramePublished == null) break;
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onFirstLocalAudioFramePublished!(connection, elapsed);
        break;

      case 'onFirstRemoteAudioFrameEx':
        if (onFirstRemoteAudioFrame == null) break;
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioFrameJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? userId = paramJson.userId;
        int? elapsed = paramJson.elapsed;
        if (connection == null || userId == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioFrame!(connection, userId, elapsed);
        break;

      case 'onFirstRemoteAudioDecodedEx':
=======
        int? elapsed = paramJson.elapsed;
        if (elapsed == null) {
          break;
        }
        onFirstLocalAudioFramePublished!(elapsed);
        break;

      case 'onFirstRemoteAudioFrame':
        if (onFirstRemoteAudioFrame == null) break;
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioFrameJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (uid == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioFrame!(uid, elapsed);
        break;

      case 'onFirstRemoteAudioDecoded':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onFirstRemoteAudioDecoded == null) break;
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || uid == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioDecoded!(connection, uid, elapsed);
        break;

      case 'onLocalAudioStateChangedEx':
        if (onLocalAudioStateChanged == null) break;
        RtcEngineEventHandlerOnLocalAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStreamState? state = paramJson.state;
        LocalAudioStreamError? error = paramJson.error;
        if (connection == null || state == null || error == null) {
          break;
        }
        onLocalAudioStateChanged!(connection, state, error);
        break;

      case 'onRemoteAudioStateChangedEx':
=======
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (uid == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioDecoded!(uid, elapsed);
        break;

      case 'onLocalAudioStateChanged':
        if (onLocalAudioStateChanged == null) break;
        RtcEngineEventHandlerOnLocalAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStateChangedJson.fromJson(jsonMap);
        LocalAudioStreamState? state = paramJson.state;
        LocalAudioStreamError? error = paramJson.error;
        if (state == null || error == null) {
          break;
        }
        onLocalAudioStateChanged!(state, error);
        break;

      case 'onRemoteAudioStateChanged':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onRemoteAudioStateChanged == null) break;
        RtcEngineEventHandlerOnRemoteAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStateChangedJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        RemoteAudioState? state = paramJson.state;
        RemoteAudioStateReason? reason = paramJson.reason;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
            state == null ||
            reason == null ||
            elapsed == null) {
          break;
        }
        onRemoteAudioStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onActiveSpeakerEx':
        if (onActiveSpeaker == null) break;
        RtcEngineEventHandlerOnActiveSpeakerJson paramJson =
            RtcEngineEventHandlerOnActiveSpeakerJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        if (connection == null || uid == null) {
          break;
        }
        onActiveSpeaker!(connection, uid);
        break;

      case 'onContentInspectResultEx':
=======
        int? uid = paramJson.uid;
        RemoteAudioState? state = paramJson.state;
        RemoteAudioStateReason? reason = paramJson.reason;
        int? elapsed = paramJson.elapsed;
        if (uid == null || state == null || reason == null || elapsed == null) {
          break;
        }
        onRemoteAudioStateChanged!(uid, state, reason, elapsed);
        break;

      case 'onActiveSpeaker':
        if (onActiveSpeaker == null) break;
        RtcEngineEventHandlerOnActiveSpeakerJson paramJson =
            RtcEngineEventHandlerOnActiveSpeakerJson.fromJson(jsonMap);
        int? userId = paramJson.userId;
        if (userId == null) {
          break;
        }
        onActiveSpeaker!(userId);
        break;

      case 'onContentInspectResult':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onContentInspectResult == null) break;
        RtcEngineEventHandlerOnContentInspectResultJson paramJson =
            RtcEngineEventHandlerOnContentInspectResultJson.fromJson(jsonMap);
        ContentInspectResult? result = paramJson.result;
        if (result == null) {
          break;
        }
        onContentInspectResult!(result);
        break;

<<<<<<< HEAD
      case 'onSnapshotTakenEx':
        if (onSnapshotTaken == null) break;
        RtcEngineEventHandlerOnSnapshotTakenJson paramJson =
            RtcEngineEventHandlerOnSnapshotTakenJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
=======
      case 'onSnapshotTaken':
        if (onSnapshotTaken == null) break;
        RtcEngineEventHandlerOnSnapshotTakenJson paramJson =
            RtcEngineEventHandlerOnSnapshotTakenJson.fromJson(jsonMap);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
>>>>>>> release/rtc-ng/3.8.200-framework
        String? filePath = paramJson.filePath;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? errCode = paramJson.errCode;
<<<<<<< HEAD
        if (connection == null ||
=======
        if (channel == null ||
            uid == null ||
>>>>>>> release/rtc-ng/3.8.200-framework
            filePath == null ||
            width == null ||
            height == null ||
            errCode == null) {
          break;
        }
<<<<<<< HEAD
        onSnapshotTaken!(connection, filePath, width, height, errCode);
        break;

      case 'onClientRoleChangedEx':
        if (onClientRoleChanged == null) break;
        RtcEngineEventHandlerOnClientRoleChangedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        ClientRoleType? oldRole = paramJson.oldRole;
        ClientRoleType? newRole = paramJson.newRole;
        if (connection == null || oldRole == null || newRole == null) {
          break;
        }
        onClientRoleChanged!(connection, oldRole, newRole);
        break;

      case 'onClientRoleChangeFailedEx':
        if (onClientRoleChangeFailed == null) break;
        RtcEngineEventHandlerOnClientRoleChangeFailedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangeFailedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        ClientRoleChangeFailedReason? reason = paramJson.reason;
        ClientRoleType? currentRole = paramJson.currentRole;
        if (connection == null || reason == null || currentRole == null) {
          break;
        }
        onClientRoleChangeFailed!(connection, reason, currentRole);
=======
        onSnapshotTaken!(channel, uid, filePath, width, height, errCode);
        break;

      case 'onClientRoleChanged':
        if (onClientRoleChanged == null) break;
        RtcEngineEventHandlerOnClientRoleChangedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangedJson.fromJson(jsonMap);
        ClientRoleType? oldRole = paramJson.oldRole;
        ClientRoleType? newRole = paramJson.newRole;
        if (oldRole == null || newRole == null) {
          break;
        }
        onClientRoleChanged!(oldRole, newRole);
        break;

      case 'onClientRoleChangeFailed':
        if (onClientRoleChangeFailed == null) break;
        RtcEngineEventHandlerOnClientRoleChangeFailedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangeFailedJson.fromJson(jsonMap);
        ClientRoleChangeFailedReason? reason = paramJson.reason;
        ClientRoleType? currentRole = paramJson.currentRole;
        if (reason == null || currentRole == null) {
          break;
        }
        onClientRoleChangeFailed!(reason, currentRole);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onAudioDeviceVolumeChanged':
        if (onAudioDeviceVolumeChanged == null) break;
        RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson.fromJson(
                jsonMap);
        MediaDeviceType? deviceType = paramJson.deviceType;
        int? volume = paramJson.volume;
        bool? muted = paramJson.muted;
        if (deviceType == null || volume == null || muted == null) {
          break;
        }
        onAudioDeviceVolumeChanged!(deviceType, volume, muted);
        break;

      case 'onRtmpStreamingStateChanged':
        if (onRtmpStreamingStateChanged == null) break;
        RtcEngineEventHandlerOnRtmpStreamingStateChangedJson paramJson =
            RtcEngineEventHandlerOnRtmpStreamingStateChangedJson.fromJson(
                jsonMap);
        String? url = paramJson.url;
        RtmpStreamPublishState? state = paramJson.state;
        RtmpStreamPublishErrorType? errCode = paramJson.errCode;
        if (url == null || state == null || errCode == null) {
          break;
        }
        onRtmpStreamingStateChanged!(url, state, errCode);
        break;

      case 'onRtmpStreamingEvent':
        if (onRtmpStreamingEvent == null) break;
        RtcEngineEventHandlerOnRtmpStreamingEventJson paramJson =
            RtcEngineEventHandlerOnRtmpStreamingEventJson.fromJson(jsonMap);
        String? url = paramJson.url;
        RtmpStreamingEvent? eventCode = paramJson.eventCode;
        if (url == null || eventCode == null) {
          break;
        }
        onRtmpStreamingEvent!(url, eventCode);
        break;

      case 'onStreamPublished':
        if (onStreamPublished == null) break;
        RtcEngineEventHandlerOnStreamPublishedJson paramJson =
            RtcEngineEventHandlerOnStreamPublishedJson.fromJson(jsonMap);
        String? url = paramJson.url;
        int? error = paramJson.error;
        if (url == null || error == null) {
          break;
        }
        onStreamPublished!(url, error);
        break;

      case 'onStreamUnpublished':
        if (onStreamUnpublished == null) break;
        RtcEngineEventHandlerOnStreamUnpublishedJson paramJson =
            RtcEngineEventHandlerOnStreamUnpublishedJson.fromJson(jsonMap);
        String? url = paramJson.url;
        if (url == null) {
          break;
        }
        onStreamUnpublished!(url);
        break;

      case 'onTranscodingUpdated':
        if (onTranscodingUpdated == null) break;
        RtcEngineEventHandlerOnTranscodingUpdatedJson paramJson =
            RtcEngineEventHandlerOnTranscodingUpdatedJson.fromJson(jsonMap);
        onTranscodingUpdated!();
        break;

      case 'onAudioRoutingChanged':
        if (onAudioRoutingChanged == null) break;
        RtcEngineEventHandlerOnAudioRoutingChangedJson paramJson =
            RtcEngineEventHandlerOnAudioRoutingChangedJson.fromJson(jsonMap);
        int? routing = paramJson.routing;
        if (routing == null) {
          break;
        }
        onAudioRoutingChanged!(routing);
        break;

      case 'onChannelMediaRelayStateChanged':
        if (onChannelMediaRelayStateChanged == null) break;
        RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson paramJson =
            RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson.fromJson(
                jsonMap);
        ChannelMediaRelayState? state = paramJson.state;
        ChannelMediaRelayError? code = paramJson.code;
        if (state == null || code == null) {
          break;
        }
        onChannelMediaRelayStateChanged!(state, code);
        break;

      case 'onChannelMediaRelayEvent':
        if (onChannelMediaRelayEvent == null) break;
        RtcEngineEventHandlerOnChannelMediaRelayEventJson paramJson =
            RtcEngineEventHandlerOnChannelMediaRelayEventJson.fromJson(jsonMap);
        int? code = paramJson.code;
        if (code == null) {
          break;
        }
        onChannelMediaRelayEvent!(code);
        break;

      case 'onLocalPublishFallbackToAudioOnly':
        if (onLocalPublishFallbackToAudioOnly == null) break;
        RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson paramJson =
            RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson.fromJson(
                jsonMap);
        bool? isFallbackOrRecover = paramJson.isFallbackOrRecover;
        if (isFallbackOrRecover == null) {
          break;
        }
        onLocalPublishFallbackToAudioOnly!(isFallbackOrRecover);
        break;

      case 'onRemoteSubscribeFallbackToAudioOnly':
        if (onRemoteSubscribeFallbackToAudioOnly == null) break;
        RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
            paramJson =
            RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
                .fromJson(jsonMap);
        int? uid = paramJson.uid;
        bool? isFallbackOrRecover = paramJson.isFallbackOrRecover;
        if (uid == null || isFallbackOrRecover == null) {
          break;
        }
        onRemoteSubscribeFallbackToAudioOnly!(uid, isFallbackOrRecover);
        break;

<<<<<<< HEAD
      case 'onRemoteAudioTransportStatsEx':
=======
      case 'onRemoteAudioTransportStats':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onRemoteAudioTransportStats == null) break;
        RtcEngineEventHandlerOnRemoteAudioTransportStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioTransportStatsJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (connection == null ||
            remoteUid == null ||
=======
        int? uid = paramJson.uid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (uid == null ||
>>>>>>> release/rtc-ng/3.8.200-framework
            delay == null ||
            lost == null ||
            rxKBitRate == null) {
          break;
        }
<<<<<<< HEAD
        onRemoteAudioTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onRemoteVideoTransportStatsEx':
=======
        onRemoteAudioTransportStats!(uid, delay, lost, rxKBitRate);
        break;

      case 'onRemoteVideoTransportStats':
>>>>>>> release/rtc-ng/3.8.200-framework
        if (onRemoteVideoTransportStats == null) break;
        RtcEngineEventHandlerOnRemoteVideoTransportStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoTransportStatsJson.fromJson(
                jsonMap);
<<<<<<< HEAD
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (connection == null ||
            remoteUid == null ||
=======
        int? uid = paramJson.uid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (uid == null ||
>>>>>>> release/rtc-ng/3.8.200-framework
            delay == null ||
            lost == null ||
            rxKBitRate == null) {
          break;
        }
<<<<<<< HEAD
        onRemoteVideoTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onConnectionStateChangedEx':
        if (onConnectionStateChanged == null) break;
        RtcEngineEventHandlerOnConnectionStateChangedJson paramJson =
            RtcEngineEventHandlerOnConnectionStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        ConnectionStateType? state = paramJson.state;
        ConnectionChangedReasonType? reason = paramJson.reason;
        if (connection == null || state == null || reason == null) {
          break;
        }
        onConnectionStateChanged!(connection, state, reason);
        break;

      case 'onNetworkTypeChangedEx':
        if (onNetworkTypeChanged == null) break;
        RtcEngineEventHandlerOnNetworkTypeChangedJson paramJson =
            RtcEngineEventHandlerOnNetworkTypeChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        NetworkType? type = paramJson.type;
        if (connection == null || type == null) {
          break;
        }
        onNetworkTypeChanged!(connection, type);
        break;

      case 'onEncryptionErrorEx':
        if (onEncryptionError == null) break;
        RtcEngineEventHandlerOnEncryptionErrorJson paramJson =
            RtcEngineEventHandlerOnEncryptionErrorJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        EncryptionErrorType? errorType = paramJson.errorType;
        if (connection == null || errorType == null) {
          break;
        }
        onEncryptionError!(connection, errorType);
=======
        onRemoteVideoTransportStats!(uid, delay, lost, rxKBitRate);
        break;

      case 'onConnectionStateChanged':
        if (onConnectionStateChanged == null) break;
        RtcEngineEventHandlerOnConnectionStateChangedJson paramJson =
            RtcEngineEventHandlerOnConnectionStateChangedJson.fromJson(jsonMap);
        ConnectionStateType? state = paramJson.state;
        ConnectionChangedReasonType? reason = paramJson.reason;
        if (state == null || reason == null) {
          break;
        }
        onConnectionStateChanged!(state, reason);
        break;

      case 'onNetworkTypeChanged':
        if (onNetworkTypeChanged == null) break;
        RtcEngineEventHandlerOnNetworkTypeChangedJson paramJson =
            RtcEngineEventHandlerOnNetworkTypeChangedJson.fromJson(jsonMap);
        NetworkType? type = paramJson.type;
        if (type == null) {
          break;
        }
        onNetworkTypeChanged!(type);
        break;

      case 'onEncryptionError':
        if (onEncryptionError == null) break;
        RtcEngineEventHandlerOnEncryptionErrorJson paramJson =
            RtcEngineEventHandlerOnEncryptionErrorJson.fromJson(jsonMap);
        EncryptionErrorType? errorType = paramJson.errorType;
        if (errorType == null) {
          break;
        }
        onEncryptionError!(errorType);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onPermissionError':
        if (onPermissionError == null) break;
        RtcEngineEventHandlerOnPermissionErrorJson paramJson =
            RtcEngineEventHandlerOnPermissionErrorJson.fromJson(jsonMap);
        PermissionType? permissionType = paramJson.permissionType;
        if (permissionType == null) {
          break;
        }
        onPermissionError!(permissionType);
        break;

      case 'onLocalUserRegistered':
        if (onLocalUserRegistered == null) break;
        RtcEngineEventHandlerOnLocalUserRegisteredJson paramJson =
            RtcEngineEventHandlerOnLocalUserRegisteredJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        String? userAccount = paramJson.userAccount;
        if (uid == null || userAccount == null) {
          break;
        }
        onLocalUserRegistered!(uid, userAccount);
        break;

      case 'onUserInfoUpdated':
        if (onUserInfoUpdated == null) break;
        RtcEngineEventHandlerOnUserInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserInfoUpdatedJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        UserInfo? info = paramJson.info;
        if (uid == null || info == null) {
          break;
        }
        onUserInfoUpdated!(uid, info);
        break;

<<<<<<< HEAD
      case 'onUploadLogResultEx':
        if (onUploadLogResult == null) break;
        RtcEngineEventHandlerOnUploadLogResultJson paramJson =
            RtcEngineEventHandlerOnUploadLogResultJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        String? requestId = paramJson.requestId;
        bool? success = paramJson.success;
        UploadErrorReason? reason = paramJson.reason;
        if (connection == null ||
            requestId == null ||
            success == null ||
            reason == null) {
          break;
        }
        onUploadLogResult!(connection, requestId, success, reason);
=======
      case 'onUploadLogResult':
        if (onUploadLogResult == null) break;
        RtcEngineEventHandlerOnUploadLogResultJson paramJson =
            RtcEngineEventHandlerOnUploadLogResultJson.fromJson(jsonMap);
        String? requestId = paramJson.requestId;
        bool? success = paramJson.success;
        UploadErrorReason? reason = paramJson.reason;
        if (requestId == null || success == null || reason == null) {
          break;
        }
        onUploadLogResult!(requestId, success, reason);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;

      case 'onAudioSubscribeStateChanged':
        if (onAudioSubscribeStateChanged == null) break;
        RtcEngineEventHandlerOnAudioSubscribeStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioSubscribeStateChangedJson.fromJson(
                jsonMap);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        StreamSubscribeState? oldState = paramJson.oldState;
        StreamSubscribeState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (channel == null ||
            uid == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          break;
        }
        onAudioSubscribeStateChanged!(
            channel, uid, oldState, newState, elapseSinceLastState);
        break;

      case 'onVideoSubscribeStateChanged':
        if (onVideoSubscribeStateChanged == null) break;
        RtcEngineEventHandlerOnVideoSubscribeStateChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSubscribeStateChangedJson.fromJson(
                jsonMap);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        StreamSubscribeState? oldState = paramJson.oldState;
        StreamSubscribeState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (channel == null ||
            uid == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          break;
        }
        onVideoSubscribeStateChanged!(
            channel, uid, oldState, newState, elapseSinceLastState);
        break;

      case 'onAudioPublishStateChanged':
        if (onAudioPublishStateChanged == null) break;
        RtcEngineEventHandlerOnAudioPublishStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioPublishStateChangedJson.fromJson(
                jsonMap);
        String? channel = paramJson.channel;
        StreamPublishState? oldState = paramJson.oldState;
        StreamPublishState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (channel == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          break;
        }
        onAudioPublishStateChanged!(
            channel, oldState, newState, elapseSinceLastState);
        break;

      case 'onVideoPublishStateChanged':
        if (onVideoPublishStateChanged == null) break;
        RtcEngineEventHandlerOnVideoPublishStateChangedJson paramJson =
            RtcEngineEventHandlerOnVideoPublishStateChangedJson.fromJson(
                jsonMap);
        String? channel = paramJson.channel;
        StreamPublishState? oldState = paramJson.oldState;
        StreamPublishState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (channel == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          break;
        }
        onVideoPublishStateChanged!(
            channel, oldState, newState, elapseSinceLastState);
        break;

      case 'onExtensionEvent':
        if (onExtensionEvent == null) break;
        RtcEngineEventHandlerOnExtensionEventJson paramJson =
            RtcEngineEventHandlerOnExtensionEventJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        String? key = paramJson.key;
        String? value = paramJson.value;
        if (provider == null ||
            extName == null ||
            key == null ||
            value == null) {
          break;
        }
        onExtensionEvent!(provider, extName, key, value);
        break;

      case 'onExtensionStarted':
        if (onExtensionStarted == null) break;
        RtcEngineEventHandlerOnExtensionStartedJson paramJson =
            RtcEngineEventHandlerOnExtensionStartedJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        if (provider == null || extName == null) {
          break;
        }
        onExtensionStarted!(provider, extName);
        break;

      case 'onExtensionStopped':
        if (onExtensionStopped == null) break;
        RtcEngineEventHandlerOnExtensionStoppedJson paramJson =
            RtcEngineEventHandlerOnExtensionStoppedJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        if (provider == null || extName == null) {
          break;
        }
        onExtensionStopped!(provider, extName);
        break;

      case 'onExtensionErrored':
        if (onExtensionErrored == null) break;
        RtcEngineEventHandlerOnExtensionErroredJson paramJson =
            RtcEngineEventHandlerOnExtensionErroredJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        int? error = paramJson.error;
        String? msg = paramJson.msg;
        if (provider == null ||
            extName == null ||
            error == null ||
            msg == null) {
          break;
        }
        onExtensionErrored!(provider, extName, error, msg);
        break;

<<<<<<< HEAD
      case 'onUserAccountUpdatedEx':
        if (onUserAccountUpdated == null) break;
        RtcEngineEventHandlerOnUserAccountUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserAccountUpdatedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        String? userAccount = paramJson.userAccount;
        if (connection == null || remoteUid == null || userAccount == null) {
          break;
        }
        onUserAccountUpdated!(connection, remoteUid, userAccount);
=======
      case 'onUserAccountUpdated':
        if (onUserAccountUpdated == null) break;
        RtcEngineEventHandlerOnUserAccountUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserAccountUpdatedJson.fromJson(jsonMap);
        int? uid = paramJson.uid;
        String? userAccount = paramJson.userAccount;
        if (uid == null || userAccount == null) {
          break;
        }
        onUserAccountUpdated!(uid, userAccount);
>>>>>>> release/rtc-ng/3.8.200-framework
        break;
      default:
        break;
    }
  }
}

extension MetadataObserverExt on MetadataObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MetadataObserver_onMetadataReceived':
        if (onMetadataReceived == null) break;
        MetadataObserverOnMetadataReceivedJson paramJson =
            MetadataObserverOnMetadataReceivedJson.fromJson(jsonMap);
        Metadata? metadata = paramJson.metadata;
        if (metadata == null) {
          break;
        }
        onMetadataReceived!(metadata);
        break;
      default:
        break;
    }
  }
}

extension DirectCdnStreamingEventHandlerExt on DirectCdnStreamingEventHandler {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'DirectCdnStreamingEventHandler_onDirectCdnStreamingStateChanged':
        if (onDirectCdnStreamingStateChanged == null) break;
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
            paramJson =
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
                .fromJson(jsonMap);
        DirectCdnStreamingState? state = paramJson.state;
        DirectCdnStreamingError? error = paramJson.error;
        String? message = paramJson.message;
        if (state == null || error == null || message == null) {
          break;
        }
        onDirectCdnStreamingStateChanged!(state, error, message);
        break;

      case 'DirectCdnStreamingEventHandler_onDirectCdnStreamingStats':
        if (onDirectCdnStreamingStats == null) break;
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson paramJson =
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson
                .fromJson(jsonMap);
        DirectCdnStreamingStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onDirectCdnStreamingStats!(stats);
        break;
      default:
        break;
    }
  }
}
