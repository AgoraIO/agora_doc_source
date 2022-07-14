import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

extension RtcEngineEventHandlerExExt on RtcEngineEventHandlerEx {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'onJoinChannelSuccessEx':
        if (onJoinChannelSuccessEx == null) break;
        RtcEngineEventHandlerExOnJoinChannelSuccessExJson paramJson =
            RtcEngineEventHandlerExOnJoinChannelSuccessExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onJoinChannelSuccessEx!(connection, elapsed);
        break;

      case 'onRejoinChannelSuccessEx':
        if (onRejoinChannelSuccessEx == null) break;
        RtcEngineEventHandlerExOnRejoinChannelSuccessExJson paramJson =
            RtcEngineEventHandlerExOnRejoinChannelSuccessExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onRejoinChannelSuccessEx!(connection, elapsed);
        break;

      case 'onAudioQualityEx':
        if (onAudioQualityEx == null) break;
        RtcEngineEventHandlerExOnAudioQualityExJson paramJson =
            RtcEngineEventHandlerExOnAudioQualityExJson.fromJson(jsonMap);
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
        onAudioQualityEx!(connection, remoteUid, quality, delay, lost);
        break;

      case 'onAudioVolumeIndicationEx':
        if (onAudioVolumeIndicationEx == null) break;
        RtcEngineEventHandlerExOnAudioVolumeIndicationExJson paramJson =
            RtcEngineEventHandlerExOnAudioVolumeIndicationExJson.fromJson(
                jsonMap);
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
        onAudioVolumeIndicationEx!(
            connection, speakers, speakerNumber, totalVolume);
        break;

      case 'onLeaveChannelEx':
        if (onLeaveChannelEx == null) break;
        RtcEngineEventHandlerExOnLeaveChannelExJson paramJson =
            RtcEngineEventHandlerExOnLeaveChannelExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLeaveChannelEx!(connection, stats);
        break;

      case 'onRtcStatsEx':
        if (onRtcStatsEx == null) break;
        RtcEngineEventHandlerExOnRtcStatsExJson paramJson =
            RtcEngineEventHandlerExOnRtcStatsExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRtcStatsEx!(connection, stats);
        break;

      case 'onNetworkQualityEx':
        if (onNetworkQualityEx == null) break;
        RtcEngineEventHandlerExOnNetworkQualityExJson paramJson =
            RtcEngineEventHandlerExOnNetworkQualityExJson.fromJson(jsonMap);
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
        onNetworkQualityEx!(connection, remoteUid, txQuality, rxQuality);
        break;

      case 'onIntraRequestReceivedEx':
        if (onIntraRequestReceivedEx == null) break;
        RtcEngineEventHandlerExOnIntraRequestReceivedExJson paramJson =
            RtcEngineEventHandlerExOnIntraRequestReceivedExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onIntraRequestReceivedEx!(connection);
        break;

      case 'onFirstLocalVideoFrameEx':
        if (onFirstLocalVideoFrameEx == null) break;
        RtcEngineEventHandlerExOnFirstLocalVideoFrameExJson paramJson =
            RtcEngineEventHandlerExOnFirstLocalVideoFrameExJson.fromJson(
                jsonMap);
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
        onFirstLocalVideoFrameEx!(connection, width, height, elapsed);
        break;

      case 'onFirstLocalVideoFramePublishedEx':
        if (onFirstLocalVideoFramePublishedEx == null) break;
        RtcEngineEventHandlerExOnFirstLocalVideoFramePublishedExJson paramJson =
            RtcEngineEventHandlerExOnFirstLocalVideoFramePublishedExJson
                .fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onFirstLocalVideoFramePublishedEx!(connection, elapsed);
        break;

      case 'onVideoSourceFrameSizeChangedEx':
        if (onVideoSourceFrameSizeChangedEx == null) break;
        RtcEngineEventHandlerExOnVideoSourceFrameSizeChangedExJson paramJson =
            RtcEngineEventHandlerExOnVideoSourceFrameSizeChangedExJson.fromJson(
                jsonMap);
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
        onVideoSourceFrameSizeChangedEx!(connection, sourceType, width, height);
        break;

      case 'onFirstRemoteVideoDecodedEx':
        if (onFirstRemoteVideoDecodedEx == null) break;
        RtcEngineEventHandlerExOnFirstRemoteVideoDecodedExJson paramJson =
            RtcEngineEventHandlerExOnFirstRemoteVideoDecodedExJson.fromJson(
                jsonMap);
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
        onFirstRemoteVideoDecodedEx!(
            connection, remoteUid, width, height, elapsed);
        break;

      case 'onVideoSizeChangedEx':
        if (onVideoSizeChangedEx == null) break;
        RtcEngineEventHandlerExOnVideoSizeChangedExJson paramJson =
            RtcEngineEventHandlerExOnVideoSizeChangedExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? rotation = paramJson.rotation;
        if (connection == null ||
            uid == null ||
            width == null ||
            height == null ||
            rotation == null) {
          break;
        }
        onVideoSizeChangedEx!(connection, uid, width, height, rotation);
        break;

      case 'onContentInspectResultEx':
        if (onContentInspectResultEx == null) break;
        RtcEngineEventHandlerExOnContentInspectResultExJson paramJson =
            RtcEngineEventHandlerExOnContentInspectResultExJson.fromJson(
                jsonMap);
        ContentInspectResult? result = paramJson.result;
        if (result == null) {
          break;
        }
        onContentInspectResultEx!(result);
        break;

      case 'onSnapshotTakenEx':
        if (onSnapshotTakenEx == null) break;
        RtcEngineEventHandlerExOnSnapshotTakenExJson paramJson =
            RtcEngineEventHandlerExOnSnapshotTakenExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        String? filePath = paramJson.filePath;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? errCode = paramJson.errCode;
        if (connection == null ||
            filePath == null ||
            width == null ||
            height == null ||
            errCode == null) {
          break;
        }
        onSnapshotTakenEx!(connection, filePath, width, height, errCode);
        break;

      case 'onLocalVideoStateChangedEx':
        if (onLocalVideoStateChangedEx == null) break;
        RtcEngineEventHandlerExOnLocalVideoStateChangedExJson paramJson =
            RtcEngineEventHandlerExOnLocalVideoStateChangedExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStreamState? state = paramJson.state;
        LocalVideoStreamError? errorCode = paramJson.errorCode;
        if (connection == null || state == null || errorCode == null) {
          break;
        }
        onLocalVideoStateChangedEx!(connection, state, errorCode);
        break;

      case 'onRemoteVideoStateChangedEx':
        if (onRemoteVideoStateChangedEx == null) break;
        RtcEngineEventHandlerExOnRemoteVideoStateChangedExJson paramJson =
            RtcEngineEventHandlerExOnRemoteVideoStateChangedExJson.fromJson(
                jsonMap);
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
        onRemoteVideoStateChangedEx!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onFirstRemoteVideoFrameEx':
        if (onFirstRemoteVideoFrameEx == null) break;
        RtcEngineEventHandlerExOnFirstRemoteVideoFrameExJson paramJson =
            RtcEngineEventHandlerExOnFirstRemoteVideoFrameExJson.fromJson(
                jsonMap);
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
        onFirstRemoteVideoFrameEx!(
            connection, remoteUid, width, height, elapsed);
        break;

      case 'onUserJoinedEx':
        if (onUserJoinedEx == null) break;
        RtcEngineEventHandlerExOnUserJoinedExJson paramJson =
            RtcEngineEventHandlerExOnUserJoinedExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || remoteUid == null || elapsed == null) {
          break;
        }
        onUserJoinedEx!(connection, remoteUid, elapsed);
        break;

      case 'onUserOfflineEx':
        if (onUserOfflineEx == null) break;
        RtcEngineEventHandlerExOnUserOfflineExJson paramJson =
            RtcEngineEventHandlerExOnUserOfflineExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        UserOfflineReasonType? reason = paramJson.reason;
        if (connection == null || remoteUid == null || reason == null) {
          break;
        }
        onUserOfflineEx!(connection, remoteUid, reason);
        break;

      case 'onUserMuteAudioEx':
        if (onUserMuteAudioEx == null) break;
        RtcEngineEventHandlerExOnUserMuteAudioExJson paramJson =
            RtcEngineEventHandlerExOnUserMuteAudioExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        onUserMuteAudioEx!(connection, remoteUid, muted);
        break;

      case 'onUserMuteVideoEx':
        if (onUserMuteVideoEx == null) break;
        RtcEngineEventHandlerExOnUserMuteVideoExJson paramJson =
            RtcEngineEventHandlerExOnUserMuteVideoExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        onUserMuteVideoEx!(connection, remoteUid, muted);
        break;

      case 'onUserEnableVideoEx':
        if (onUserEnableVideoEx == null) break;
        RtcEngineEventHandlerExOnUserEnableVideoExJson paramJson =
            RtcEngineEventHandlerExOnUserEnableVideoExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        onUserEnableVideoEx!(connection, remoteUid, enabled);
        break;

      case 'onUserEnableLocalVideoEx':
        if (onUserEnableLocalVideoEx == null) break;
        RtcEngineEventHandlerExOnUserEnableLocalVideoExJson paramJson =
            RtcEngineEventHandlerExOnUserEnableLocalVideoExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        onUserEnableLocalVideoEx!(connection, remoteUid, enabled);
        break;

      case 'onUserStateChangedEx':
        if (onUserStateChangedEx == null) break;
        RtcEngineEventHandlerExOnUserStateChangedExJson paramJson =
            RtcEngineEventHandlerExOnUserStateChangedExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? state = paramJson.state;
        if (connection == null || remoteUid == null || state == null) {
          break;
        }
        onUserStateChangedEx!(connection, remoteUid, state);
        break;

      case 'onLocalAudioStatsEx':
        if (onLocalAudioStatsEx == null) break;
        RtcEngineEventHandlerExOnLocalAudioStatsExJson paramJson =
            RtcEngineEventHandlerExOnLocalAudioStatsExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLocalAudioStatsEx!(connection, stats);
        break;

      case 'onRemoteAudioStatsEx':
        if (onRemoteAudioStatsEx == null) break;
        RtcEngineEventHandlerExOnRemoteAudioStatsExJson paramJson =
            RtcEngineEventHandlerExOnRemoteAudioStatsExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RemoteAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRemoteAudioStatsEx!(connection, stats);
        break;

      case 'onLocalVideoStatsEx':
        if (onLocalVideoStatsEx == null) break;
        RtcEngineEventHandlerExOnLocalVideoStatsExJson paramJson =
            RtcEngineEventHandlerExOnLocalVideoStatsExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLocalVideoStatsEx!(connection, stats);
        break;

      case 'onRemoteVideoStatsEx':
        if (onRemoteVideoStatsEx == null) break;
        RtcEngineEventHandlerExOnRemoteVideoStatsExJson paramJson =
            RtcEngineEventHandlerExOnRemoteVideoStatsExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RemoteVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRemoteVideoStatsEx!(connection, stats);
        break;

      case 'onConnectionLostEx':
        if (onConnectionLostEx == null) break;
        RtcEngineEventHandlerExOnConnectionLostExJson paramJson =
            RtcEngineEventHandlerExOnConnectionLostExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionLostEx!(connection);
        break;

      case 'onConnectionInterruptedEx':
        if (onConnectionInterruptedEx == null) break;
        RtcEngineEventHandlerExOnConnectionInterruptedExJson paramJson =
            RtcEngineEventHandlerExOnConnectionInterruptedExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionInterruptedEx!(connection);
        break;

      case 'onConnectionBannedEx':
        if (onConnectionBannedEx == null) break;
        RtcEngineEventHandlerExOnConnectionBannedExJson paramJson =
            RtcEngineEventHandlerExOnConnectionBannedExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionBannedEx!(connection);
        break;

      case 'onStreamMessageEx':
        if (onStreamMessageEx == null) break;
        RtcEngineEventHandlerExOnStreamMessageExJson paramJson =
            RtcEngineEventHandlerExOnStreamMessageExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? streamId = paramJson.streamId;
        Uint8List? data = paramJson.data;
        int? length = paramJson.length;
        int? sentTs = paramJson.sentTs;
        if (connection == null ||
            remoteUid == null ||
            streamId == null ||
            data == null ||
            length == null ||
            sentTs == null) {
          break;
        }
        onStreamMessageEx!(
            connection, remoteUid, streamId, data, length, sentTs);
        break;

      case 'onStreamMessageErrorEx':
        if (onStreamMessageErrorEx == null) break;
        RtcEngineEventHandlerExOnStreamMessageErrorExJson paramJson =
            RtcEngineEventHandlerExOnStreamMessageErrorExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? streamId = paramJson.streamId;
        int? code = paramJson.code;
        int? missed = paramJson.missed;
        int? cached = paramJson.cached;
        if (connection == null ||
            remoteUid == null ||
            streamId == null ||
            code == null ||
            missed == null ||
            cached == null) {
          break;
        }
        onStreamMessageErrorEx!(
            connection, remoteUid, streamId, code, missed, cached);
        break;

      case 'onRequestTokenEx':
        if (onRequestTokenEx == null) break;
        RtcEngineEventHandlerExOnRequestTokenExJson paramJson =
            RtcEngineEventHandlerExOnRequestTokenExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onRequestTokenEx!(connection);
        break;

      case 'onTokenPrivilegeWillExpireEx':
        if (onTokenPrivilegeWillExpireEx == null) break;
        RtcEngineEventHandlerExOnTokenPrivilegeWillExpireExJson paramJson =
            RtcEngineEventHandlerExOnTokenPrivilegeWillExpireExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        String? token = paramJson.token;
        if (connection == null || token == null) {
          break;
        }
        onTokenPrivilegeWillExpireEx!(connection, token);
        break;

      case 'onFirstLocalAudioFramePublishedEx':
        if (onFirstLocalAudioFramePublishedEx == null) break;
        RtcEngineEventHandlerExOnFirstLocalAudioFramePublishedExJson paramJson =
            RtcEngineEventHandlerExOnFirstLocalAudioFramePublishedExJson
                .fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onFirstLocalAudioFramePublishedEx!(connection, elapsed);
        break;

      case 'onFirstRemoteAudioFrameEx':
        if (onFirstRemoteAudioFrameEx == null) break;
        RtcEngineEventHandlerExOnFirstRemoteAudioFrameExJson paramJson =
            RtcEngineEventHandlerExOnFirstRemoteAudioFrameExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? userId = paramJson.userId;
        int? elapsed = paramJson.elapsed;
        if (connection == null || userId == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioFrameEx!(connection, userId, elapsed);
        break;

      case 'onFirstRemoteAudioDecodedEx':
        if (onFirstRemoteAudioDecodedEx == null) break;
        RtcEngineEventHandlerExOnFirstRemoteAudioDecodedExJson paramJson =
            RtcEngineEventHandlerExOnFirstRemoteAudioDecodedExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || uid == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioDecodedEx!(connection, uid, elapsed);
        break;

      case 'onLocalAudioStateChangedEx':
        if (onLocalAudioStateChangedEx == null) break;
        RtcEngineEventHandlerExOnLocalAudioStateChangedExJson paramJson =
            RtcEngineEventHandlerExOnLocalAudioStateChangedExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStreamState? state = paramJson.state;
        LocalAudioStreamError? error = paramJson.error;
        if (connection == null || state == null || error == null) {
          break;
        }
        onLocalAudioStateChangedEx!(connection, state, error);
        break;

      case 'onRemoteAudioStateChangedEx':
        if (onRemoteAudioStateChangedEx == null) break;
        RtcEngineEventHandlerExOnRemoteAudioStateChangedExJson paramJson =
            RtcEngineEventHandlerExOnRemoteAudioStateChangedExJson.fromJson(
                jsonMap);
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
        onRemoteAudioStateChangedEx!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onActiveSpeakerEx':
        if (onActiveSpeakerEx == null) break;
        RtcEngineEventHandlerExOnActiveSpeakerExJson paramJson =
            RtcEngineEventHandlerExOnActiveSpeakerExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        if (connection == null || uid == null) {
          break;
        }
        onActiveSpeakerEx!(connection, uid);
        break;

      case 'onClientRoleChangedEx':
        if (onClientRoleChangedEx == null) break;
        RtcEngineEventHandlerExOnClientRoleChangedExJson paramJson =
            RtcEngineEventHandlerExOnClientRoleChangedExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        ClientRoleType? oldRole = paramJson.oldRole;
        ClientRoleType? newRole = paramJson.newRole;
        if (connection == null || oldRole == null || newRole == null) {
          break;
        }
        onClientRoleChangedEx!(connection, oldRole, newRole);
        break;

      case 'onClientRoleChangeFailedEx':
        if (onClientRoleChangeFailedEx == null) break;
        RtcEngineEventHandlerExOnClientRoleChangeFailedExJson paramJson =
            RtcEngineEventHandlerExOnClientRoleChangeFailedExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        ClientRoleChangeFailedReason? reason = paramJson.reason;
        ClientRoleType? currentRole = paramJson.currentRole;
        if (connection == null || reason == null || currentRole == null) {
          break;
        }
        onClientRoleChangeFailedEx!(connection, reason, currentRole);
        break;

      case 'onRemoteAudioTransportStatsEx':
        if (onRemoteAudioTransportStatsEx == null) break;
        RtcEngineEventHandlerExOnRemoteAudioTransportStatsExJson paramJson =
            RtcEngineEventHandlerExOnRemoteAudioTransportStatsExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (connection == null ||
            remoteUid == null ||
            delay == null ||
            lost == null ||
            rxKBitRate == null) {
          break;
        }
        onRemoteAudioTransportStatsEx!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onRemoteVideoTransportStatsEx':
        if (onRemoteVideoTransportStatsEx == null) break;
        RtcEngineEventHandlerExOnRemoteVideoTransportStatsExJson paramJson =
            RtcEngineEventHandlerExOnRemoteVideoTransportStatsExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (connection == null ||
            remoteUid == null ||
            delay == null ||
            lost == null ||
            rxKBitRate == null) {
          break;
        }
        onRemoteVideoTransportStatsEx!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onConnectionStateChangedEx':
        if (onConnectionStateChangedEx == null) break;
        RtcEngineEventHandlerExOnConnectionStateChangedExJson paramJson =
            RtcEngineEventHandlerExOnConnectionStateChangedExJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        ConnectionStateType? state = paramJson.state;
        ConnectionChangedReasonType? reason = paramJson.reason;
        if (connection == null || state == null || reason == null) {
          break;
        }
        onConnectionStateChangedEx!(connection, state, reason);
        break;

      case 'onNetworkTypeChangedEx':
        if (onNetworkTypeChangedEx == null) break;
        RtcEngineEventHandlerExOnNetworkTypeChangedExJson paramJson =
            RtcEngineEventHandlerExOnNetworkTypeChangedExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        NetworkType? type = paramJson.type;
        if (connection == null || type == null) {
          break;
        }
        onNetworkTypeChangedEx!(connection, type);
        break;

      case 'onEncryptionErrorEx':
        if (onEncryptionErrorEx == null) break;
        RtcEngineEventHandlerExOnEncryptionErrorExJson paramJson =
            RtcEngineEventHandlerExOnEncryptionErrorExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        EncryptionErrorType? errorType = paramJson.errorType;
        if (connection == null || errorType == null) {
          break;
        }
        onEncryptionErrorEx!(connection, errorType);
        break;

      case 'onUploadLogResultEx':
        if (onUploadLogResultEx == null) break;
        RtcEngineEventHandlerExOnUploadLogResultExJson paramJson =
            RtcEngineEventHandlerExOnUploadLogResultExJson.fromJson(jsonMap);
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
        onUploadLogResultEx!(connection, requestId, success, reason);
        break;

      case 'onUserAccountUpdatedEx':
        if (onUserAccountUpdatedEx == null) break;
        RtcEngineEventHandlerExOnUserAccountUpdatedExJson paramJson =
            RtcEngineEventHandlerExOnUserAccountUpdatedExJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        String? userAccount = paramJson.userAccount;
        if (connection == null || remoteUid == null || userAccount == null) {
          break;
        }
        onUserAccountUpdatedEx!(connection, remoteUid, userAccount);
        break;
      default:
        break;
    }
  }
}
