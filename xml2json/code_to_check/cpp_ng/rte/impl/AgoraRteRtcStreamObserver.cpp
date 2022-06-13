//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteRtcStreamObserver.h"

#include "AgoraRteBase.h"
#include "AgoraRteRtcStream.h"
#include "AgoraRteScene.h"
#include "AgoraRteTrackBase.h"
#include "IAgoraRtmpStreamingService.h"

namespace agora {
namespace rte {

RTE_INLINE void RteStatsConvertHelper::LocalAudioStats(
    const rtc::LocalAudioStats& stats, RteLocalAudioStats& dest_stats) {
  dest_stats.numChannels = stats.numChannels;
  dest_stats.sentSampleRate = stats.sentSampleRate;
  dest_stats.sentBitrate = stats.sentBitrate;
  dest_stats.internalCodec = stats.internalCodec;
}

RTE_INLINE void RteStatsConvertHelper::LocalVideoStats(
    const rtc::LocalVideoTrackStats& stats, RteLocalVideoStats& dest_stats) {
  dest_stats.encoderOutputFrameRate = stats.encode_frame_rate;
  dest_stats.rendererOutputFrameRate = stats.render_frame_rate;
  dest_stats.encodedFrameWidth = stats.width;
  dest_stats.encodedFrameHeight = stats.height;
  dest_stats.encodedFrameCount = static_cast<int>(stats.frames_encoded);
}

RTE_INLINE void RteStatsConvertHelper::RemoteAudioStats(
    const rtc::RemoteAudioTrackStats& stats, RteRemoteAudioStats& dest_stats) {
  dest_stats.quality = stats.quality;
  dest_stats.networkTransportDelay = stats.network_transport_delay;
  dest_stats.jitterBufferDelay = static_cast<int>(stats.jitter_buffer_delay);
  dest_stats.audioLossRate = stats.audio_loss_rate;
  dest_stats.numChannels = stats.num_channels;
  dest_stats.receivedSampleRate = stats.received_sample_rate;
  dest_stats.receivedBitrate = stats.received_bitrate;
  dest_stats.totalFrozenTime = stats.total_frozen_time;
  dest_stats.frozenRate = stats.frozen_rate;
  dest_stats.mosValue = static_cast<int>(stats.mos_value);
}

RTE_INLINE void RteStatsConvertHelper::RemoteVideoStats(
    const rtc::RemoteVideoTrackStats& stats, RteRemoteVideoStats dest_stats) {
  dest_stats.delay = stats.delay;
  dest_stats.width = stats.width;
  dest_stats.height = stats.height;
  dest_stats.receivedBitrate = stats.receivedBitrate;
  dest_stats.decoderOutputFrameRate = stats.decoderOutputFrameRate;
  dest_stats.rendererOutputFrameRate = stats.rendererOutputFrameRate;
  dest_stats.frameLossRate = stats.frameLossRate;
  dest_stats.packetLossRate = stats.packetLossRate;
  dest_stats.rxStreamType = stats.rxStreamType;
  dest_stats.totalFrozenTime = stats.totalFrozenTime;
  dest_stats.frozenRate = stats.frozenRate;
  dest_stats.avSyncTimeMs = stats.avSyncTimeMs;
  dest_stats.superResolutionType = stats.superResolutionType;
}

RTE_INLINE AgoraRteRtcMajorStreamObserver::~AgoraRteRtcMajorStreamObserver() {
  if (fire_connection_closed_event_ && !is_close_event_failed_) {
    // The connection is already gone, so we get scene for weak_ptr
    //
    auto scene = scene_.lock();

    if (scene) {
      scene->ChangeSceneState(SceneState::kDisconnected,
                              rtc::CONNECTION_CHANGED_REASON_TYPE::
                                  CONNECTION_CHANGED_LEAVE_CHANNEL);
    }
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onConnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onConnected,
      "connection_info: (channel_id : %s, id: %zu, internalUid: "
      "%zu,localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);

  RTE_LOG_VERBOSE << "Connected: " << connection_info.localUserId;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_CONNECTED);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onDisconnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onDisconnected,
      "connection_info: (channel_id : %s, id: %zu, internalUid: %zu,"
      "localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);

  RTE_LOG_VERBOSE << "Disconnected: channel:" << connection_info.channelId
                  << " local user:" << connection_info.localUserId;
  // is_close_event_failed_ is to tell whether we should fire
  // CONNECTION_STATE_DISCONNECTED event in here or destructor function. Note
  // that fire_connection_closed_event_ is for rtc connection to tell us to fire
  // the event before our observer is unregistered
  is_close_event_failed_ = true;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_DISCONNECTED);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onConnecting(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onConnecting,
      "connection_info: (channel_id : %s, id: %zu, internalUid: "
      "%zu,localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);
  RTE_LOG_VERBOSE << "Connecting: " << connection_info.localUserId;
  is_close_event_failed_ = false;
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_CONNECTING);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onReconnecting(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onReconnecting,
      "connection_info: (channel_id : %s, id: %zu, internalUid: "
      "%zu,localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);
  RTE_LOG_VERBOSE << "Reconnecting: " << connection_info.localUserId;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_RECONNECTING);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onReconnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onReconnected,
      "connection_info: (channel_id : %s, id: %zu, internalUid: %zu,  "
      "localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);

  RTE_LOG_VERBOSE << "Reconnected: " << connection_info.localUserId;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_CONNECTED);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onConnectionLost(
    const rtc::TConnectionInfo& connection_info) {
  RTE_LOGGER_CALLBACK(onConnectionLost,
                      "connection_info: (channel_id : %s, id: %zu, "
                      "internalUid: %zu, localUserId: %s, state: %d)",
                      connection_info.channelId.get()->c_str(),
                      connection_info.id, connection_info.internalUid,
                      connection_info.localUserId.get()->c_str());

  RTE_LOG_VERBOSE << "LostConnect: " << connection_info.localUserId;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat =
        AgoraRteUtils::GetConnStateFromRtcState(rtc::CONNECTION_STATE_FAILED);
    scene->ChangeSceneState(
        conn_stat,
        rtc::CONNECTION_CHANGED_REASON_TYPE::CONNECTION_CHANGED_LOST);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onUserJoined(
    user_id_t user_id) {
  RTE_LOGGER_CALLBACK(onUserJoined, "user_id: %s", user_id);
  RTE_LOG_VERBOSE << "user_id: " << user_id;
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  if (scene && local_stream) {
    const std::string remote_stream_id(user_id);
    RteRtcStreamInfo stream_info;
    auto is_extract_ok =
        AgoraRteUtils::ExtractRtcStreamInfo(remote_stream_id, stream_info);
    // Here we only accept NGAPI protocol connection
    //
    if (!is_extract_ok) {
      RTE_LOG_ERROR << "Failed to parser user_id: " << user_id;
      assert(false);
      return;
    }

    if (stream_info.is_major_stream) {
      scene->AddRemoteUser(stream_info.user_id);
    } else if (stream_info.user_id != scene->GetLocalUserInfo().user_id) {
      auto remote_stream = std::make_shared<AgoraRteRtcRemoteStream>(
          stream_info.user_id, local_stream->GetRtcService(),
          stream_info.stream_id, remote_stream_id, local_stream);

      local_stream->AddRemoteStream(remote_stream);
      scene->AddRemoteStream(stream_info.stream_id, remote_stream);
    }
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onUserLeft(
    user_id_t user_id, rtc::USER_OFFLINE_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onUserLeft, "user_id: %s, reason: %d", user_id, reason);
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  if (scene && local_stream) {
    std::string rtc_stream_id(user_id);
    RteRtcStreamInfo info;

    auto is_extract_ok =
        AgoraRteUtils::ExtractRtcStreamInfo(rtc_stream_id, info);

    if (is_extract_ok) {
      if (info.is_major_stream) {
        scene->RemoveRemoteUser(info.user_id);
      } else if (info.user_id != scene->GetLocalUserInfo().user_id) {
        local_stream->RemoveRemoteStream(info.stream_id);
        scene->RemoveRemoteStream(info.stream_id);
      }
    } else {
      RTE_LOG_ERROR << "Failed to parser user_id: " << user_id;
      assert(false);
    }
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onTokenPrivilegeWillExpire(
    const char* token) {
  RTE_LOGGER_CALLBACK(onTokenPrivilegeWillExpire, "token: %s",
                      token ? token : "");
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  if (local_stream && scene) {
    std::string token_s(token);
    scene->OnSceneTokenWillExpire(token_s);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onTokenPrivilegeDidExpire() {
  RTE_LOGGER_CALLBACK(onTokenPrivilegeDidExpire, nullptr);
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  if (local_stream && scene) {
    scene->OnSceneTokenExpired();
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamObserver::onTokenPrivilegeWillExpire(
    const char* token) {
  RTE_LOGGER_CALLBACK(onTokenPrivilegeWillExpire, "token: %s",
                      token ? token : "");
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();
  if (local_stream && scene) {
    std::string token_s(token);
    scene->OnStreamTokenWillExpire(local_stream->GetStreamId(), token_s);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamObserver::onTransportStats(
    const rtc::RtcStats& stats) {
  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    scene->OnRtcStats(stream->GetStreamId(), stats);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamObserver::onTokenPrivilegeDidExpire() {
  RTE_LOGGER_CALLBACK(onTokenPrivilegeDidExpire, nullptr);
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();
  if (local_stream && scene) {
    scene->OnStreamTokenExpired(local_stream->GetStreamId());
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamObserver::onConnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onConnected,
      "connection_info: (channel_id : %s, id: %zu, internalUid: %zu, "
      "localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);

  auto stream = stream_.lock();
  if (stream) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
    stream->OnConnected();
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamObserver::onConnecting(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onConnecting,
      "connection_info: (channel_id : %s, id: %zu, internalUid: "
      "%zu,localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);
  auto stream = stream_.lock();
  if (stream) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamObserver::onReconnecting(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onReconnecting,
      "connection_info: (channel_id : %s, id: %zu, internalUid: "
      "%zu,localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);

  auto stream = stream_.lock();
  if (stream) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamObserver::onReconnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onReconnected,
      "connection_info: (channel_id : %s, id: %zu, internalUid: %zu, "
      "localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);

  auto stream = stream_.lock();
  if (stream) {
    stream->SetLocalUid(static_cast<uint32_t>(connection_info.internalUid));
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onConnectionFailure(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(
      onConnectionFailure,
      "connection_info: (channel_id : %s, id: %zu, internalUid: %zu, "
      "localUserId: %s, state: %d), reason: %d",
      connection_info.channelId.get()->c_str(), connection_info.id,
      connection_info.internalUid, connection_info.localUserId.get()->c_str(),
      connection_info.state, reason);

  auto stream = stream_.lock();
  auto scene = scene_.lock();
  if (stream && scene) {
    auto conn_state =
        AgoraRteUtils::GetConnStateFromRtcState(rtc::CONNECTION_STATE_FAILED);
    scene->ChangeSceneState(conn_state, reason);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamObserver::onTransportStats(
    const rtc::RtcStats& stats) {
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    scene->OnRtcStats(stream->GetStreamId(), stats);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamUserObserver::onAudioTrackPublishSuccess(
    agora_refptr<rtc::ILocalAudioTrack> audio_track) {
  RTE_LOGGER_CALLBACK(onAudioTrackPublishSuccess, "audio_track: %p",
                      audio_track.get());
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->OnAudioTrackPublished(audio_track);
    scene->OnLocalStreamEvent(stream->GetStreamId(),
                              LocalStreamEventType::kFirstAudioFramePublished);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamUserObserver::onLocalAudioTrackStatistics(
    const rtc::LocalAudioStats& stats) {
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    RteLocalAudioStats audio_stats = {};
    RteStatsConvertHelper::LocalAudioStats(stats, audio_stats);
    scene->OnLocalStreamAudioStats(stream->GetStreamId(), audio_stats);
  }
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onRemoteAudioTrackStatistics(
    agora_refptr<rtc::IRemoteAudioTrack> audio_track,
    const rtc::RemoteAudioTrackStats& stats) {
  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    RteRemoteAudioStats dest_stats = {};
    RteStatsConvertHelper::RemoteAudioStats(stats, dest_stats);
    scene->OnRemoteStreamAudioStats(stream->GetStreamId(), dest_stats);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamUserObserver::onUserAudioTrackSubscribed(
    user_id_t user_id, agora_refptr<rtc::IRemoteAudioTrack> audio_track) {
  RTE_LOGGER_CALLBACK(onUserAudioTrackSubscribed,
                      "user_id: %s, audio_track: %p", user_id,
                      audio_track.get());
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string rtc_stream_id(user_id);
    RteRtcStreamInfo info;

    AgoraRteUtils::ExtractRtcStreamInfo(rtc_stream_id, info);

    auto remote_stream = stream->FindRemoteStream(info.stream_id);
    if (remote_stream) {
      auto remote_audio_track =
          AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IRemoteAudioTrack>(
              audio_track);
      remote_stream->OnAudioTrackSubscribed(remote_audio_track);
    }
  }
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onUserAudioTrackStateChanged(
    user_id_t user_id, agora_refptr<rtc::IRemoteAudioTrack> audio_track,
    rtc::REMOTE_AUDIO_STATE state, rtc::REMOTE_AUDIO_STATE_REASON reason,
    int elapsed) {
  if (rtc::REMOTE_AUDIO_STATE::REMOTE_AUDIO_STATE_DECODING != state) {
    return;
  }

  auto stream = stream_.lock();
  auto scene = scene_.lock();
  if (scene && stream) {
    auto remote_stream = stream->FindRemoteStream(audio_track);
    if (!remote_stream) {
      scene->OnRemoteStreamEvent(
          remote_stream->GetStreamId(),
          RemoteStreamEventType::kFirstAudioFrameReceived);
    }
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamUserObserver::onVideoTrackPublishSuccess(
    agora_refptr<rtc::ILocalVideoTrack> video_track) {
  RTE_LOGGER_CALLBACK(onVideoTrackPublishSuccess, "video_track: %p",
                      video_track.get());
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->OnVideoTrackPublished(video_track);
    scene->OnLocalStreamEvent(stream->GetStreamId(),
                              LocalStreamEventType::kFirstVideoFramePublished);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamUserObserver::onLocalVideoTrackStatistics(
    agora_refptr<rtc::ILocalVideoTrack> video_track,
    const rtc::LocalVideoTrackStats& stats) {
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    RteLocalVideoStats video_stats = {};
    RteStatsConvertHelper::LocalVideoStats(stats, video_stats);
    scene->OnLocalStreamVideoStats(stream->GetRtcStreamId(), video_stats);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamUserObserver::onUserVideoTrackSubscribed(
    user_id_t user_id, rtc::VideoTrackInfo track_info,
    agora_refptr<rtc::IRemoteVideoTrack> video_track) {
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string rtc_stream_id(user_id);
    RteRtcStreamInfo info;
    AgoraRteUtils::ExtractRtcStreamInfo(rtc_stream_id, info);

    auto remote_stream = stream->FindRemoteStream(info.stream_id);
    if (remote_stream) {
      auto remote_video_track =
          AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IRemoteVideoTrack>(
              video_track);
      remote_stream->OnVideoTrackSubscribed(remote_video_track);
    }
  }
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onUserVideoTrackStateChanged(
    user_id_t user_id, agora_refptr<rtc::IRemoteVideoTrack> video_track,
    rtc::REMOTE_VIDEO_STATE state, rtc::REMOTE_VIDEO_STATE_REASON reason,
    int elapsed) {
  if (rtc::REMOTE_VIDEO_STATE::REMOTE_VIDEO_STATE_DECODING != state) {
    return;
  }

  auto stream = stream_.lock();
  auto scene = scene_.lock();
  if (scene && stream) {
    auto remote_stream = stream->FindRemoteStream(video_track);
    if (remote_stream) {
      scene->OnRemoteStreamEvent(
          remote_stream->GetStreamId(),
          RemoteStreamEventType::kFirstVideoFrameReceived);
    }
  }
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onFirstRemoteVideoFrameRendered(
    user_id_t user_id, int width, int height, int elapsed) {
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string rtc_stream_id(user_id);
    RteRtcStreamInfo info;
    AgoraRteUtils::ExtractRtcStreamInfo(rtc_stream_id, info);

    auto remote_stream = stream->FindRemoteStream(info.stream_id);
    if (remote_stream) {
      scene->OnRemoteStreamEvent(
          remote_stream->GetStreamId(),
          RemoteStreamEventType::kFirstVideoFrameRendered);
    }
  }
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onRemoteVideoTrackStatistics(
    agora_refptr<rtc::IRemoteVideoTrack> video_track,
    const rtc::RemoteVideoTrackStats& stats) {
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto remote_stream = stream->FindRemoteStream(video_track);
    if (remote_stream) {
      RteRemoteVideoStats dest_stats = {};
      RteStatsConvertHelper::RemoteVideoStats(stats, dest_stats);
      std::string stream_id = remote_stream->GetStreamId();
      scene->OnRemoteStreamVideoStats(remote_stream->GetStreamId(), dest_stats);
    }
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamUserObserver::onAudioVolumeIndication(
    const rtc::AudioVolumeInformation* speakers, unsigned int speaker_number,
    int total_volume) {
  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    std::vector<AudioVolumeInfo> infos(speaker_number);
    for (unsigned int i = 0; i < speaker_number; i++) {
      std::string user_id = speakers->userId;
      if ("0" != user_id) {
        RteRtcStreamInfo info;
        auto is_extract_ok = AgoraRteUtils::ExtractRtcStreamInfo(user_id, info);
        if (!is_extract_ok) {
          RTE_LOG_ERROR << "extract rtc stream info fail, user_id: " << user_id;
          continue;
        }
        user_id = info.user_id;
      }

      infos.push_back({user_id, speakers->volume});
      speakers++;
    }
    scene->OnAudioVolumeIndication(infos, total_volume);
  }
}

RTE_INLINE void AgoraRteRtcMajorStreamUserObserver::onActiveSpeaker(user_id_t userId) {
  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    scene->OnActiveSpeaker(userId);
  }
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onAudioSubscribeStateChanged(
    const char* channel, user_id_t user_id,
    rtc::STREAM_SUBSCRIBE_STATE old_state,
    rtc::STREAM_SUBSCRIBE_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onAudioSubscribeStateChanged,
                      "channel: %s, user_id: %s, old_state: %d,new_state: %d, "
                      "elapse_since_last_state: %d",
                      channel ? channel : "", user_id, old_state, new_state,
                      elapse_since_last_state);

  onSubscribeStateChangedCommon(channel, user_id, old_state, new_state,
                                elapse_since_last_state, MediaType::kAudio);
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onVideoSubscribeStateChanged(
    const char* channel, user_id_t user_id,
    rtc::STREAM_SUBSCRIBE_STATE old_state,
    rtc::STREAM_SUBSCRIBE_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onVideoSubscribeStateChanged,
                      "channel: %s, user_id: %s, old_state: %d, \
      new_state: %d, elapse_since_last_state: %d",
                      channel ? channel : "", user_id, old_state, new_state,
                      elapse_since_last_state);

  onSubscribeStateChangedCommon(channel, user_id, old_state, new_state,
                                elapse_since_last_state, MediaType::kVideo);
}

RTE_INLINE void AgoraRteRtcLocalStreamUserObserver::onAudioPublishStateChanged(
    const char* channel, rtc::STREAM_PUBLISH_STATE old_state,
    rtc::STREAM_PUBLISH_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onAudioPublishStateChanged,
                      "channel: %s, old_state: %d, \
      new_state: %d, elapse_since_last_state: %d",
                      channel ? channel : "", old_state, new_state,
                      elapse_since_last_state);

  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    AgoraRteRtcObserveHelper::onPublishStateChanged(
        channel, old_state, new_state, elapse_since_last_state,
        MediaType::kAudio, scene, stream);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamUserObserver::onVideoPublishStateChanged(
    const char* channel, rtc::STREAM_PUBLISH_STATE old_state,
    rtc::STREAM_PUBLISH_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onVideoPublishStateChanged,
                      "channel: %s, old_state: %d, \
      new_state: %d, elapse_since_last_state: %d",
                      channel ? channel : "", old_state, new_state,
                      elapse_since_last_state);

  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    AgoraRteRtcObserveHelper::onPublishStateChanged(
        channel, old_state, new_state, elapse_since_last_state,
        MediaType::kVideo, scene, stream);
  }
}

RTE_INLINE void
AgoraRteRtcMajorStreamUserObserver::onSubscribeStateChangedCommon(
    const char* channel, user_id_t user_id,
    rtc::STREAM_SUBSCRIBE_STATE old_state,
    rtc::STREAM_SUBSCRIBE_STATE new_state, int elapse_since_last_state,
    MediaType type) {
  RTE_LOGGER_CALLBACK(onSubscribeStateChangedCommon,
                      "channel: %s, user_id: %s, old_state: %d, new_state: %d, "
                      "elapse_since_last_state: %d, type: %d",
                      channel ? channel : "", user_id, old_state, new_state,
                      elapse_since_last_state, type);

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (scene && stream) {
    SubscribeState state = SubscribeState::kFailed;
    bool notify_callback = false;

    if (old_state == rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBING &&
        new_state == rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBED) {
      state = SubscribeState::kSubscribed;
      notify_callback = true;
    }

    if (old_state == rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBED &&
        new_state != rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBED) {
      state = SubscribeState::kNoSubscribe;
      notify_callback = true;
    }

    if (notify_callback) {
      StreamInfo stream_info;
      RteRtcStreamInfo rtc_info;
      std::string rtc_stream_id(user_id);

      auto is_extract_ok =
          AgoraRteUtils::ExtractRtcStreamInfo(rtc_stream_id, rtc_info);

      if (is_extract_ok) {
        stream_info.stream_id = rtc_info.stream_id;
        stream_info.user_id = rtc_info.user_id;

        if (state == SubscribeState::kSubscribed) {
          switch (type) {
            case MediaType::kAudio:
              stream->OnAudioConnected();
              break;
            case MediaType::kVideo:
              stream->OnVideoConnected();
              break;
            default:
              break;
          }

          scene->OnRemoteStreamStateChanged(
              stream_info, type, StreamMediaState::kIdle,
              StreamMediaState::kStreaming,
              StreamStateChangedReason::kSubscribed);
        } else {
          switch (type) {
            case MediaType::kAudio:
              stream->OnAudioDisconnected();
              break;
            case MediaType::kVideo:
              stream->OnVideoDisconnected();
              break;
            default:
              break;
          }

          scene->OnRemoteStreamStateChanged(
              stream_info, type, StreamMediaState::kStreaming,
              StreamMediaState::kIdle, StreamStateChangedReason::kUnsubscribed);
        }
      }
    }
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamCdnObserver::onRtmpStreamingStateChanged(
    const char* url, agora::rtc::RTMP_STREAM_PUBLISH_STATE state,
    agora::rtc::RTMP_STREAM_PUBLISH_ERROR_TYPE err_code) {
  RTE_LOGGER_CALLBACK(onRtmpStreamingStateChanged,
                      "url: %s, state: %d, err_code: %d", url ? url : "", state,
                      err_code);

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnStateChanged(stream_id, url, state, err_code);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamCdnObserver::onStreamPublished(
    const char* url, int error) {
  RTE_LOGGER_CALLBACK(onStreamPublished, "url: %s, error: %d", url ? url : "",
                      error);

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnPublished(stream_id, url, error);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamCdnObserver::onStreamUnpublished(
    const char* url) {
  RTE_LOGGER_CALLBACK(onStreamUnpublished, "url: %s", url ? url : "");
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnUnpublished(stream_id, url);
  }
}

RTE_INLINE void AgoraRteRtcLocalStreamCdnObserver::onTranscodingUpdated() {
  RTE_LOGGER_CALLBACK(onTranscodingUpdated, nullptr);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnTranscodingUpdated(stream_id);
  }
}

RTE_INLINE bool AgoraRteRtcAudioFrameObserver::onRecordAudioFrame(
    const char* channelId, AudioFrame& audio_frame) {
  RTE_LOGGER_CALLBACK(onRecordAudioFrame, nullptr);
  auto scene = scene_.lock();
  if (scene) {
    scene->OnRecordAudioFrame(audio_frame);
  }

  return true;
}

RTE_INLINE bool AgoraRteRtcAudioFrameObserver::onPlaybackAudioFrame(
    const char* channelId, AudioFrame& audio_frame) {
  auto scene = scene_.lock();
  if (scene) {
    scene->OnPlaybackAudioFrame(audio_frame);
  }

  return true;
}

RTE_INLINE bool AgoraRteRtcAudioFrameObserver::onMixedAudioFrame(
    const char* channelId, AudioFrame& audio_frame) {
  auto scene = scene_.lock();
  if (scene) {
    scene->OnMixedAudioFrame(audio_frame);
  }

  return true;
}

RTE_INLINE bool AgoraRteRtcAudioFrameObserver::onEarMonitoringAudioFrame(
    AudioFrame& audio_frame) {
  return false;
}

RTE_INLINE bool AgoraRteRtcAudioFrameObserver::onPlaybackAudioFrameBeforeMixing(
    const char* channelId, user_id_t user_id, AudioFrame& audio_frame) {
  auto scene = scene_.lock();
  if (scene) {
    RteRtcStreamInfo info;
    std::string rtc_stream_id(user_id);

    auto is_extract_ok =
        AgoraRteUtils::ExtractRtcStreamInfo(rtc_stream_id, info);

    if (is_extract_ok) {
      scene->OnPlaybackAudioFrameBeforeMixing(user_id, audio_frame);
    }
  }
  return true;
}

RTE_INLINE void AgoraRteRtcRemoteVideoObserver::onFrame(
    const char* channel_id, user_id_t remote_uid,
    const media::base::VideoFrame* frame) {
  auto scene = scene_.lock();
  if (scene) {
    RteRtcStreamInfo info;
    std::string rtc_stream_id(remote_uid);

    auto is_extract_ok =
        AgoraRteUtils::ExtractRtcStreamInfo(rtc_stream_id, info);

    if (is_extract_ok) {
      scene->OnRemoteVideoFrame(info.stream_id, *frame);
    }
  }
}

RTE_INLINE void AgoraRteRtcObserveHelper::onPublishStateChanged(
    const char* channel, rtc::STREAM_PUBLISH_STATE old_state,
    rtc::STREAM_PUBLISH_STATE new_state, int elapse_since_last_state,
    MediaType type, const std::shared_ptr<AgoraRteScene>& scene,
    const std::shared_ptr<AgoraRteStream>& stream) {
  assert(type == MediaType::kAudio || type == MediaType::kVideo);

  bool notify_callback = false;
  PublishState state = PublishState::kFailed;

  if (old_state == rtc::STREAM_PUBLISH_STATE::PUB_STATE_PUBLISHING &&
      new_state == rtc::STREAM_PUBLISH_STATE::PUB_STATE_PUBLISHED) {
    state = PublishState::kPublished;
    notify_callback = true;
  }

  if (new_state == rtc::STREAM_PUBLISH_STATE::PUB_STATE_NO_PUBLISHED &&
      old_state == rtc::STREAM_PUBLISH_STATE::PUB_STATE_PUBLISHED) {
    state = PublishState::kUnpublished;
    notify_callback = true;
  }

  if (notify_callback) {
    StreamInfo info;
    info.user_id = scene->GetLocalUserInfo().user_id;

    if (scene->GetSceneInfo().scene_type == SceneType::kCompatible) {
      info.stream_id = info.user_id;
    } else {
      info.stream_id = stream->GetStreamId();
    }

    if (state == PublishState::kPublished) {
      switch (type) {
        case MediaType::kAudio:
          stream->OnAudioConnected();
          break;
        case MediaType::kVideo:
          stream->OnVideoConnected();
          break;
        default:
          break;
      }

      scene->OnLocalStreamStateChanged(info, type, StreamMediaState::kIdle,
                                       StreamMediaState::kStreaming,
                                       StreamStateChangedReason::kPublished);
    } else {
      switch (type) {
        case MediaType::kAudio:
          stream->OnAudioDisconnected();
          break;
        case MediaType::kVideo:
          stream->OnVideoDisconnected();
          break;
        default:
          break;
      }

      scene->OnLocalStreamStateChanged(info, type, StreamMediaState::kStreaming,
                                       StreamMediaState::kIdle,
                                       StreamStateChangedReason::kUnpublished);
    }
  }
}

}  // namespace rte
}  // namespace agora