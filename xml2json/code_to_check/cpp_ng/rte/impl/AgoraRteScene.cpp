//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteScene.h"

#include "AgoraRteMediaPlayer.h"
#include "AgoraRteRtcCompatibleStream.h"
#include "AgoraRteRtcStream.h"
#include "AgoraRteStream.h"
#include "AgoraRteStreamFactory.h"
#include "AgoraRteTrackBase.h"
#include "AgoraRteUtils.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteScene::AgoraRteScene(
    std::shared_ptr<AgoraRteStreamFactory> stream_factory,
    const std::string& scene_id, const SceneConfig& config)
    : scene_id_(scene_id), config_(config), stream_factory_(stream_factory) {}

RTE_INLINE int AgoraRteScene::Join(const std::string& user_id,
                                   const std::string& token,
                                   const JoinOptions& options) {
  // Sync user calls
  //
  RTE_LOGGER_MEMBER(
      "user_id: %s, token: %s, option: (is_user_visible_to_remote: %d)",
      user_id.c_str(), token.c_str(), options.is_user_visible_to_remote);
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);

  {
    // Sync between callbacks to change state
    //
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);
    if (scene_state_ != SceneState::kDisconnected) {
      return -ERR_INVALID_STATE;
    }

    scene_state_ = SceneState::kConnecting;
  }

  user_id_ = user_id;

  auto major_stream = GetMajorStream();

  if (!major_stream) {
    major_stream =
        stream_factory_->CreateMajorStream(shared_from_this(), token, options);
    SetMajorStream(major_stream);
  }

  if (!major_stream || major_stream->Connect() != ERR_OK) {
    // If we failed to connect, no callback will be triggered
    //
    {
      std::lock_guard<std::recursive_mutex> lock(callback_lock_);
      major_stream_object_.reset();
    }
    user_id_ = "";

    {
      std::lock_guard<std::recursive_mutex> lock(callback_lock_);
      if (scene_state_ == SceneState::kConnecting) {
        scene_state_ = SceneState::kDisconnected;
      }
    }

    return -ERR_FAILED;
  }

  return ERR_OK;
}

RTE_INLINE void AgoraRteScene::Leave() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);

  // Leave should never fail
  //

  // Only change the state when we could "disconnect", e.g. we don't want to
  // turn disconneted state to disconnecting
  //
  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);
    if (scene_state_ == SceneState::kConnecting ||
        scene_state_ == SceneState::kConnected ||
        scene_state_ == SceneState::kReconnecting) {
      scene_state_ = SceneState::kDisconnecting;
      remote_stream_objects_.clear();
    }
  }

  // local_stream_objects_ could only be changed with operation_lock_
  //
  std::for_each(
      local_stream_objects_.begin(), local_stream_objects_.end(),
      [this](const auto& con_pair) { DestroyStream(con_pair.second); });

  local_stream_objects_.clear();

  // Here should be the last reference on major stream
  //
  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);
    major_stream_object_.reset();
  }
  user_id_ = "";

  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);
    if (scene_state_ == SceneState::kDisconnecting) {
      scene_state_ = SceneState::kDisconnected;
    }
  }

  // If scene object is deleted after Leave(), no callback will trigged to tell
  // the state change from kDisconnecting to kDisconnected, however, as soon as
  // Leave returned, customer could expect all stream should be disconnected in
  // soon time
  //
}

RTE_INLINE int AgoraRteScene::RenewSceneToken(const std::string& new_token) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  auto major_stream = GetMajorStream();
  if (major_stream) {
    return major_stream->RenewSceneToken(new_token);
  }

  return -ERR_INVALID_STATE;
}

RTE_INLINE SceneInfo AgoraRteScene::GetSceneInfo() const {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);

  SceneInfo info;
  info.scene_id = scene_id_;
  info.state = scene_state_;
  info.scene_type = config_.scene_type;
  return info;
}

RTE_INLINE UserInfo AgoraRteScene::GetLocalUserInfo() const {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  UserInfo info;
  info.user_id = user_id_;
  return info;
}

RTE_INLINE std::vector<UserInfo> AgoraRteScene::GetRemoteUsers() const {
  // Don't need operation_lock_ , callback_lock_ is enough
  //
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);

  std::vector<UserInfo> result;
  for (const auto& user : remote_users_) {
    result.push_back({user});
  }
  return result;
}

RTE_INLINE std::vector<StreamInfo> AgoraRteScene::GetLocalStreams() const {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);

  std::vector<StreamInfo> result;
  for (const auto& stream_pair : local_stream_objects_) {
    const auto& stream = stream_pair.second;
    StreamInfo info;
    info.stream_id = stream->GetStreamId();
    info.user_id = user_id_;
    result.push_back(info);
  }

  return result;
}

RTE_INLINE std::vector<StreamInfo> AgoraRteScene::GetRemoteStreams() const {
  // Don't need operation_lock_ , callback_lock_ is enough
  //
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);

  std::vector<StreamInfo> result;
  for (const auto& stream_pair : remote_stream_objects_) {
    const auto& stream = stream_pair.second;

    result.push_back({stream->GetStreamId(), stream->GetUserId()});
  }

  return result;
}

RTE_INLINE std::vector<StreamInfo> AgoraRteScene::GetRemoteStreamsByUserId(
    const std::string& user_id) const {
  // Don't need operation_lock_ , callback_lock_ is enough
  //
  RTE_LOGGER_MEMBER("user_id: %s", user_id.c_str());
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);

  std::vector<StreamInfo> result;
  for (const auto& stream_pair : remote_stream_objects_) {
    const auto& stream = stream_pair.second;

    if (stream->GetUserId() == user_id) {
      result.push_back({stream->GetStreamId(), stream->GetUserId()});
    }
  }

  return result;
}

RTE_INLINE int AgoraRteScene::CreateOrUpdateStreamCommon(
    const std::string& local_stream_id, const StreamOption& option) {
  RTE_LOGGER_MEMBER("local_stream_id: %s", local_stream_id.c_str());
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);

  if (config_.scene_type == SceneType::kCompatible &&
      local_stream_id != user_id_) {
    RTE_LOG_ERROR
        << "For compatible scene, user name should equals with stream name ";
  }

  std::shared_ptr<AgoraRteLocalStream> local_stream =
      GetLocalStream(local_stream_id);

  if (!local_stream) {
    local_stream = CreatLocalStream(local_stream_id, option);
    if (local_stream) {
      return ERR_OK;
    }
  } else {
    return local_stream->UpdateOption(option);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::CreateOrUpdateRTCStream(
    const std::string& local_stream_id, const RtcStreamOptions& options) {
  RTE_LOGGER_MEMBER("local_stream_id: %s", local_stream_id.c_str());
  return CreateOrUpdateStreamCommon(local_stream_id, options);
}

RTE_INLINE int AgoraRteScene::CreateOrUpdateDirectCDNStream(
    const std::string& local_stream_id, const DirectCdnStreamOptions& options) {
  return CreateOrUpdateStreamCommon(local_stream_id, options);
}

RTE_INLINE int AgoraRteScene::SetAudioEncoderConfiguration(
    const std::string& local_stream_id,
    const AudioEncoderConfiguration& config) {
  std::shared_ptr<AgoraRteLocalStream> stream = GetLocalStream(local_stream_id);

  if (stream) {
    return stream->SetAudioEncoderConfiguration(config);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::SetVideoEncoderConfiguration(
    const std::string& local_stream_id,
    const VideoEncoderConfiguration& config) {
  std::shared_ptr<AgoraRteLocalStream> stream = GetLocalStream(local_stream_id);

  if (stream) {
    return stream->SetVideoEncoderConfiguration(config);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::SetExtensionProperty(
    const std::string& remote_stream_id, const std::string& provider_name,
    const std::string& extension_name, const std::string& key,
    const std::string& json_value) {
  auto stream = GetRemoteStream(remote_stream_id);
  if (stream) {
    return stream->SetExtensionProperty(provider_name, extension_name, key,
                                        json_value);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::GetExtensionProperty(
    const std::string& remote_stream_id, const std::string& provider_name,
    const std::string& extension_name, const std::string& key,
    std::string& json_value) {
  auto stream = GetRemoteStream(remote_stream_id);
  if (stream) {
    return stream->GetExtensionProperty(provider_name, extension_name, key,
                                        json_value);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::SetCloudCdnTranscoding(
    const std::string& local_stream_id,
    const agora::rtc::LiveTranscoding& transcoding) {
  std::shared_ptr<AgoraRteLocalStream> stream = GetLocalStream(local_stream_id);

  if (stream) {
    return stream->SetCloudCdnTranscoding(transcoding);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::AddCloudCdnUrl(const std::string& local_stream_id,
                                             const std::string& target_cdn_url,
                                             bool transcoding_enabled) {
  std::shared_ptr<AgoraRteLocalStream> stream = GetLocalStream(local_stream_id);

  if (stream) {
    return stream->AddCloudCdnUrl(target_cdn_url, transcoding_enabled);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::RemoveCloudCdnUrl(
    const std::string& local_stream_id, const std::string& target_cdn_url) {
  std::shared_ptr<AgoraRteLocalStream> stream = GetLocalStream(local_stream_id);

  if (stream) {
    return stream->RemoveCloudCdnUrl(target_cdn_url);
  }

  return -ERR_FAILED;
}

RTE_INLINE bool AgoraRteScene::IsSceneActive() {
  if (scene_state_ == SceneState::kDisconnecting ||
      scene_state_ == SceneState::kDisconnected ||
      scene_state_ == SceneState::kFailed) {
    return false;
  }

  return true;
}

RTE_INLINE std::shared_ptr<AgoraRteMajorStream>
AgoraRteScene::GetMajorStream() {
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  return major_stream_object_;
}

RTE_INLINE void AgoraRteScene::SetMajorStream(
    const std::shared_ptr<AgoraRteMajorStream>& stream) {
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  major_stream_object_ = stream;
}

RTE_INLINE void AgoraRteScene::OnRtcStats(const std::string& stream_id,
                                          const rtc::RtcStats& stats) {
  const std::string major_stream_id = GetMajorStream()->GetStreamId();
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);

  rtc_stats_map_[stream_id].push_back(stats);
  if (major_stream_id != stream_id) {
    return;
  }

  SceneStats scene_stats = {};
  scene_stats.duration = stats.duration;
  scene_stats.cpuTotalUsage = stats.cpuTotalUsage;
  scene_stats.cpuAppUsage = stats.cpuAppUsage;
  scene_stats.memoryAppUsageRatio = stats.memoryAppUsageRatio;
  scene_stats.memoryTotalUsageRatio = stats.memoryTotalUsageRatio;
  scene_stats.memoryAppUsageInKbytes = stats.memoryAppUsageInKbytes;

  for (auto& rtc_stats_vec : rtc_stats_map_) {
    for (auto& rtc_stats : rtc_stats_vec.second) {
      scene_stats.txBytes += static_cast<int>(rtc_stats.txBytes);
      scene_stats.rxBytes += static_cast<int>(rtc_stats.rxBytes);
      scene_stats.txAudioBytes += static_cast<int>(rtc_stats.txAudioBytes);
      scene_stats.txVideoBytes += static_cast<int>(rtc_stats.txVideoBytes);
      scene_stats.rxAudioBytes += static_cast<int>(rtc_stats.rxAudioBytes);
      scene_stats.rxVideoBytes += static_cast<int>(rtc_stats.rxVideoBytes);
      scene_stats.txKBitRate += static_cast<int>(rtc_stats.txKBitRate);
      scene_stats.rxKBitRate += static_cast<int>(rtc_stats.rxKBitRate);
      scene_stats.txAudioKBitRate +=
          static_cast<int>(rtc_stats.txAudioKBitRate);
      scene_stats.rxAudioKBitRate +=
          static_cast<int>(rtc_stats.rxAudioKBitRate);
      scene_stats.txVideoKBitRate +=
          static_cast<int>(rtc_stats.txVideoKBitRate);
      scene_stats.rxVideoKBitRate +=
          static_cast<int>(rtc_stats.rxVideoKBitRate);
    }
  }

  rtc_stats_map_.clear();

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_,
      [&](const auto& handler) { handler->OnSceneStats(scene_stats); });
}

RTE_INLINE void AgoraRteScene::OnLocalStreamAudioStats(
    const std::string& stream_id, const RteLocalAudioStats& stats) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnLocalStreamAudioStats(stream_id, stats);
      });
}

RTE_INLINE void AgoraRteScene::OnLocalStreamVideoStats(
    const std::string& stream_id, const RteLocalVideoStats& stats) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnLocalStreamVideoStats(stream_id, stats);
      });
}

RTE_INLINE void AgoraRteScene::OnRemoteStreamAudioStats(
    const std::string& stream_id, const RteRemoteAudioStats& stats) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnRemoteStreamAudioStats(stream_id, stats);
      });
}

RTE_INLINE void AgoraRteScene::OnRemoteStreamVideoStats(
    const std::string& stream_id, const RteRemoteVideoStats& stats) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnRemoteStreamVideoStats(stream_id, stats);
      });
}

RTE_INLINE void AgoraRteScene::OnLocalStreamEvent(const std::string& stream_id,
                                                  LocalStreamEventType event) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnLocalStreamEvent(stream_id, event);
      });
}

RTE_INLINE void AgoraRteScene::OnRemoteStreamEvent(
    const std::string& stream_id, RemoteStreamEventType event) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnRemoteStreamEvent(stream_id, event);
      });
}

RTE_INLINE std::shared_ptr<AgoraRteLocalStream> AgoraRteScene::CreatLocalStream(
    const std::string& local_stream_id, const StreamOption& option) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);

  auto itr = local_stream_objects_.find(local_stream_id);
  if (itr != local_stream_objects_.end()) {
    return itr->second;
  }

  RTE_LOG_INFO << "Create a new stream: " << local_stream_id;
  auto major_stream = GetMajorStream();
  if (major_stream) {
    auto stream = stream_factory_->CreateLocalStream(shared_from_this(), option,
                                                     local_stream_id);
    if (stream) {
      if (stream->Connect() == ERR_OK) {
        local_stream_objects_[local_stream_id] = stream;

        // Tell remote server our stream is created if required
        //
        major_stream->PushStreamInfo({local_stream_id, user_id_},
                                     InstanceState::kCreated);
        return stream;
      } else {
        // Tell server our stream is destoried if required
        //
        major_stream->PushStreamInfo({local_stream_id, user_id_},
                                     InstanceState::kDestroyed);
      }
    }
  }

  return nullptr;
}

RTE_INLINE std::shared_ptr<AgoraRteLocalStream> AgoraRteScene::GetLocalStream(
    const std::string& local_stream_id) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  auto itr = local_stream_objects_.find(local_stream_id);
  if (itr != local_stream_objects_.end()) {
    return itr->second;
  }

  return nullptr;
}

RTE_INLINE std::shared_ptr<AgoraRteLocalStream>
AgoraRteScene::RemoveLocalStream(const std::string& local_stream_id) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  std::shared_ptr<AgoraRteLocalStream> stream;
  auto itr = local_stream_objects_.find(local_stream_id);
  if (itr != local_stream_objects_.end()) {
    stream = itr->second;
    local_stream_objects_.erase(itr);
    return stream;
  }

  return nullptr;
}

template <>
RTE_INLINE int AgoraRteScene::PublishSpecific<AgoraRteRtcVideoTrackBase>(
    const std::shared_ptr<AgoraRteLocalStream>& stream,
    const std::shared_ptr<AgoraRteRtcVideoTrackBase>& track) {
  return stream->PublishLocalVideoTrack(track);
}

template <>
RTE_INLINE int AgoraRteScene::PublishSpecific<AgoraRteRtcAudioTrackBase>(
    const std::shared_ptr<AgoraRteLocalStream>& stream,
    const std::shared_ptr<AgoraRteRtcAudioTrackBase>& track) {
  return stream->PublishLocalAudioTrack(track);
}

template <typename track_type>
RTE_INLINE int AgoraRteScene::PublishCommon(
    std::shared_ptr<track_type> track, const std::string& local_stream_id) {
  int result = -ERR_FAILED;

  RTE_LOG_VERBOSE << " stream id: " << local_stream_id;
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  auto stream = GetLocalStream(local_stream_id);
  if (stream) {
    auto track_impl = AgoraRteUtils::CastToImpl(track);

    assert(track_impl);

    result = track_impl->BeforePublish(stream);

    if (result == ERR_OK) {
      result = PublishSpecific(stream, track_impl);
    }

    track_impl->AfterPublish(result, stream);
  }

  return result;
}

RTE_INLINE int AgoraRteScene::PublishLocalAudioTrack(
    const std::string& local_stream_id,
    std::shared_ptr<IAgoraRteAudioTrack> track) {
  return PublishCommon(track, local_stream_id);
}

RTE_INLINE int AgoraRteScene::PublishLocalVideoTrack(
    const std::string& local_stream_id,
    std::shared_ptr<IAgoraRteVideoTrack> track) {
  return PublishCommon(track, local_stream_id);
}

template <>
RTE_INLINE int AgoraRteScene::UnpublishSpecific<AgoraRteRtcAudioTrackBase>(
    const std::shared_ptr<AgoraRteLocalStream>& stream,
    const std::shared_ptr<AgoraRteRtcAudioTrackBase>& track) {
  return stream->UnpublishLocalAudioTrack(track);
}

template <>
RTE_INLINE int AgoraRteScene::UnpublishSpecific<AgoraRteRtcVideoTrackBase>(
    const std::shared_ptr<AgoraRteLocalStream>& stream,
    const std::shared_ptr<AgoraRteRtcVideoTrackBase>& track) {
  return stream->UnpublishLocalVideoTrack(track);
}

template <typename track_type>
RTE_INLINE int AgoraRteScene::UnpublishCommon(
    std::shared_ptr<track_type> track) {
  int result = -ERR_FAILED;
  std::string local_stream_id = track->GetAttachedStreamId();
  if (!local_stream_id.empty()) {
    RTE_LOG_VERBOSE << " stream id: " << local_stream_id;
    std::lock_guard<std::recursive_mutex> lock(operation_lock_);
    auto stream = GetLocalStream(local_stream_id);

    if (stream) {
      auto track_impl = AgoraRteUtils::CastToImpl(track);

      assert(track_impl);

      result = track_impl->BeforeUnPublish(stream);

      if (result == ERR_OK) {
        result = UnpublishSpecific(stream, track_impl);
      }

      track_impl->AfterUnPublish(result, stream);
    }
  }

  return result;
}

RTE_INLINE int AgoraRteScene::UnpublishLocalAudioTrack(
    std::shared_ptr<IAgoraRteAudioTrack> track) {
  return UnpublishCommon(track);
}

RTE_INLINE int AgoraRteScene::UnpublishLocalVideoTrack(
    std::shared_ptr<IAgoraRteVideoTrack> track) {
  return UnpublishCommon(track);
}

RTE_INLINE int AgoraRteScene::PublishMediaPlayer(
    const std::string& local_stream_id,
    std::shared_ptr<IAgoraRteMediaPlayer> player) {
  int result = -ERR_NOT_READY;
  // Publish video first since one stream only allow one video
  //
  auto video_track =
      std::static_pointer_cast<AgoraRteMediaPlayer>(player)->GetVideoTrack();
  if (video_track) {
    result = PublishLocalVideoTrack(local_stream_id, video_track);
  }

  if (result == ERR_OK) {
    auto audio_track =
        std::static_pointer_cast<AgoraRteMediaPlayer>(player)->GetAudioTrack();
    if (audio_track) {
      result = PublishLocalAudioTrack(local_stream_id, audio_track);
    }

    if (result != ERR_OK && video_track) {
      UnpublishLocalVideoTrack(video_track);
    }
  }

  return result;
}

RTE_INLINE int AgoraRteScene::UnpublishMediaPlayer(
    std::shared_ptr<IAgoraRteMediaPlayer> player) {
  int video_result = -ERR_NOT_READY;
  int audio_result = -ERR_NOT_READY;
  auto video_track =
      std::static_pointer_cast<AgoraRteMediaPlayer>(player)->GetVideoTrack();
  if (video_track) {
    video_result = UnpublishLocalVideoTrack(video_track);
  }

  auto audio_track =
      std::static_pointer_cast<AgoraRteMediaPlayer>(player)->GetAudioTrack();
  if (audio_track) {
    audio_result = UnpublishLocalAudioTrack(audio_track);
  }

  return video_result == ERR_OK ? audio_result : video_result;
}

RTE_INLINE std::shared_ptr<AgoraRteRemoteStream> AgoraRteScene::GetRemoteStream(
    const std::string& remote_stream_id) {
  // Don't need operation_lock_ , callback_lock_ is enough
  //
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  auto itr = remote_stream_objects_.find(remote_stream_id);
  if (itr != remote_stream_objects_.end()) {
    return itr->second;
  }
  return nullptr;
}

RTE_INLINE int AgoraRteScene::SubscribeRemoteAudio(
    const std::string& remote_stream_id) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  std::shared_ptr<AgoraRteRemoteStream> stream =
      GetRemoteStream(remote_stream_id);

  if (stream) {
    return stream->SubscribeRemoteAudio();
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::UnsubscribeRemoteAudio(
    const std::string& remote_stream_id) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  std::shared_ptr<AgoraRteRemoteStream> stream =
      GetRemoteStream(remote_stream_id);

  if (stream) {
    return stream->UnsubscribeRemoteAudio();
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::SubscribeRemoteVideo(
    const std::string& remote_stream_id, const VideoSubscribeOptions& options) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  std::shared_ptr<AgoraRteRemoteStream> stream =
      GetRemoteStream(remote_stream_id);

  if (stream) {
    return stream->SubscribeRemoteVideo(options);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::UnsubscribeRemoteVideo(
    const std::string& remote_stream_id) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  std::shared_ptr<AgoraRteRemoteStream> stream =
      GetRemoteStream(remote_stream_id);

  if (stream) {
    return stream->UnsubscribeRemoteVideo();
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteScene::SetRemoteVideoCanvas(
    const std::string& remote_stream_id, const VideoCanvas& canvas) {
  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  std::shared_ptr<AgoraRteRemoteStream> stream =
      GetRemoteStream(remote_stream_id);

  if (stream) {
    return stream->SetRemoteVideoCanvas(canvas);
  }

  return -ERR_FAILED;
}

RTE_INLINE void AgoraRteScene::RegisterEventHandler(
    std::shared_ptr<IAgoraRteSceneEventHandler> event_handler) {
  UnregisterEventHandler(event_handler);
  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);
    event_handlers_.push_back(event_handler);
  }
}

RTE_INLINE void AgoraRteScene::UnregisterEventHandler(
    std::shared_ptr<IAgoraRteSceneEventHandler> event_handler) {
  AgoraRteUtils::UnregisterSharedPtrFromContainer(
      callback_lock_, event_handlers_, event_handler);
}

RTE_INLINE void AgoraRteScene::RegisterRemoteVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  UnregisterRemoteVideoFrameObserver(observer);
  std::vector<std::shared_ptr<AgoraRteRemoteStream>> remote_streams;

  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);
    remote_video_frame_observers_.push_back(observer);
    for (auto& stream_pair : remote_stream_objects_) {
      remote_streams.push_back(stream_pair.second);
    }
  }

  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  for (auto& stream : remote_streams) {
    stream->EnableRemoteVideoObserver();
  }
}

RTE_INLINE void AgoraRteScene::UnregisterRemoteVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  AgoraRteUtils::UnregisterSharedPtrFromContainer(
      callback_lock_, remote_video_frame_observers_, observer);

  std::vector<std::shared_ptr<AgoraRteRemoteStream>> remote_streams;

  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);

    if (remote_video_frame_observers_.empty()) {
      for (auto& stream_pair : remote_stream_objects_) {
        remote_streams.push_back(stream_pair.second);
      }
    }
  }

  std::lock_guard<std::recursive_mutex> lock(operation_lock_);
  for (auto& stream : remote_streams) {
    stream->DisableRemoveVideoObserver();
  }
}

RTE_INLINE void AgoraRteScene::RegisterAudioFrameObserver(
    std::shared_ptr<IAgoraRteAudioFrameObserver> observer,
    const AudioObserverOptions& options) {
  UnregisterAudioFrameObserver(observer);
  {
    {
      std::lock_guard<std::recursive_mutex> lock(callback_lock_);

      audio_observer_option_ = options;

      audio_frame_observers_.push_back(observer);
    }

    auto major_stream = GetMajorStream();

    if (options.local_option.after_mix || options.local_option.after_record ||
        options.local_option.before_playback) {
      std::lock_guard<std::recursive_mutex> lock(operation_lock_);
      if (config_.scene_type == SceneType::kAdhoc) {
        auto stream =
            std::static_pointer_cast<AgoraRteRtcMajorStream>(major_stream);
        stream->UpdateLocalAudioObserver(true, options.local_option);
      }
      if (config_.scene_type == SceneType::kCompatible) {
        auto stream =
            std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
                major_stream);
        stream->UpdateLocalAudioObserver(true, options.local_option);
      } else {
        // Add Observer when we can register observers to audio device manager
        //
      }
    }

    if (options.remote_option.after_playback_before_mix) {
      std::lock_guard<std::recursive_mutex> lock(operation_lock_);
      if (config_.scene_type == SceneType::kAdhoc) {
        auto stream =
            std::static_pointer_cast<AgoraRteRtcMajorStream>(major_stream);
        stream->UpdateRemoteAudioObserver(true, options.remote_option);
      }
      if (config_.scene_type == SceneType::kCompatible) {
        auto stream =
            std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
                major_stream);
        stream->UpdateRemoteAudioObserver(true, options.remote_option);
      } else {
        // Add Observer when we can register observers to audio device manager
        //
      }
    }
  }
}

RTE_INLINE void AgoraRteScene::UnregisterAudioFrameObserver(
    std::shared_ptr<IAgoraRteAudioFrameObserver> observer) {
  AgoraRteUtils::UnregisterSharedPtrFromContainer(
      callback_lock_, audio_frame_observers_, observer);

  auto major_stream = GetMajorStream();
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  {
    if (audio_frame_observers_.empty()) {
      constexpr bool enable = true;
      std::lock_guard<std::recursive_mutex> lock(operation_lock_);
      if (config_.scene_type == SceneType::kAdhoc) {
        auto stream =
            std::static_pointer_cast<AgoraRteRtcMajorStream>(major_stream);
        stream->UpdateLocalAudioObserver(!enable);
        stream->UpdateRemoteAudioObserver(!enable);
      }
      if (config_.scene_type == SceneType::kCompatible) {
        auto stream =
            std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
                major_stream);
        stream->UpdateLocalAudioObserver(!enable);
        stream->UpdateRemoteAudioObserver(!enable);
      } else {
        // Add Observer when we can register observers to audio device manager
        //
      }
    }
  }
}

RTE_INLINE int AgoraRteScene::AdjustUserPlaybackSignalVolume(
    const std::string& remote_stream_id, int volume) {
  std::shared_ptr<AgoraRteRemoteStream> stream =
      GetRemoteStream(remote_stream_id);
  if (stream == nullptr) {
    return -ERR_FAILED;
  }

  return stream->AdjustRemoteVolume(volume);
}

RTE_INLINE int AgoraRteScene::GetUserPlaybackSignalVolume(
    const std::string& remote_stream_id, int* volume) {
  std::shared_ptr<AgoraRteRemoteStream> stream =
      GetRemoteStream(remote_stream_id);
  if (stream == nullptr) {
    return -ERR_FAILED;
  }

  return stream->GetRemoteVolume(volume);
}

RTE_INLINE void AgoraRteScene::AddRemoteUser(const std::string& user_id) {
  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);

    // Don't need to add remote user if scene is already closed
    //
    if (!IsSceneActive()) {
      return;
    }

    if (remote_users_.find(user_id) != remote_users_.end()) {
      return;
    }

    remote_users_.insert(user_id);
  }

  std::vector<UserInfo> users;
  users.push_back({user_id});

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_,
      [&users](const auto& handler) { handler->OnRemoteUserJoined(users); });
}

RTE_INLINE void AgoraRteScene::RemoveRemoteUser(const std::string& user_id) {
  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);

    auto itr = remote_users_.find(user_id);

    if (itr == remote_users_.end()) {
      return;
    }

    remote_users_.erase(itr);
  }

  std::vector<UserInfo> users;
  users.push_back({user_id});

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_,
      [&users](const auto& handler) { handler->OnRemoteUserLeft(users); });
}

RTE_INLINE void AgoraRteScene::ChangeSceneState(
    SceneState state, ConnectionChangedReason reason) {
  SceneState old_state = SceneState::kFailed;
  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);

    // Customer could fire disconnect any time, so we need to check state first,
    // If we are disconnecting the connection, we could ignore all states except
    // disconnected
    //
    if (scene_state_ == SceneState::kDisconnecting) {
      switch (state) {
        case SceneState::kDisconnected:
        case SceneState::kFailed:
          break;
        default:
          return;
      }
    }

    old_state = scene_state_;
    scene_state_ = state;
  }

  auto major_stream = GetMajorStream();

  if (major_stream) {
    switch (state) {
      case SceneState::kConnected:
        major_stream->PushUserInfo(GetLocalUserInfo(), InstanceState::kOnline);
        break;
      case SceneState::kDisconnected:
        major_stream->PushUserInfo(GetLocalUserInfo(), InstanceState::kOffline);
        break;
      default:
        break;
    }
  }

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_,
      [old_state, state, reason](const auto& handler) {
        handler->OnConnectionStateChanged(old_state, state, reason);
      });
}

RTE_INLINE void AgoraRteScene::AddRemoteStream(
    const std::string& remote_stream_id,
    const std::shared_ptr<AgoraRteRemoteStream>& stream) {
  bool notify_event = false;

  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);

    // Don't need to add remote stream if scene is already closed
    //
    if (!IsSceneActive()) {
      return;
    }

    auto itr = remote_stream_objects_.find(remote_stream_id);
    if (itr == remote_stream_objects_.end()) {
      remote_stream_objects_[remote_stream_id] = stream;
      if (!remote_video_frame_observers_.empty()) {
        stream->EnableRemoteVideoObserver();
      }

      if (audio_observer_option_.remote_option.after_playback_before_mix) {
        stream->EnableRemoteAudioObserver(audio_observer_option_.remote_option);
      }

      notify_event = true;
    }
  }

  if (notify_event) {
    std::vector<StreamInfo> infos;
    infos.push_back({stream->GetStreamId(), stream->GetUserId()});

    AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
        callback_lock_, event_handlers_,
        [&infos](const auto& handler) { handler->OnRemoteStreamAdded(infos); });
  }
}

RTE_INLINE void AgoraRteScene::RemoveRemoteStream(
    const std::string& remote_stream_id) {
  bool notify_event = false;
  std::vector<StreamInfo> infos;

  {
    std::lock_guard<std::recursive_mutex> lock(callback_lock_);
    auto itr = remote_stream_objects_.find(remote_stream_id);
    if (itr != remote_stream_objects_.end()) {
      infos.push_back({itr->second->GetStreamId(), itr->second->GetUserId()});
      remote_stream_objects_.erase(itr);
      notify_event = true;
    }
  }

  if (notify_event) {
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
        callback_lock_, event_handlers_, [&infos](const auto& handler) {
          handler->OnRemoteStreamRemoved(infos);
        });
  }
}

RTE_INLINE void AgoraRteScene::OnLocalStreamStateChanged(
    const StreamInfo& stream, MediaType media_type, StreamMediaState old_state,
    StreamMediaState new_state, StreamStateChangedReason reason) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnLocalStreamStateChanged(stream, media_type, old_state,
                                           new_state, reason);
      });

  auto major_stream = GetMajorStream();
  if (major_stream) {
    switch (new_state) {
      case StreamMediaState::kStreaming:
        major_stream->PushMediaInfo(stream, media_type, InstanceState::kOnline);
        break;
      case StreamMediaState::kIdle:
        major_stream->PushMediaInfo(stream, media_type,
                                    InstanceState::kOffline);
        break;
      default:
        break;
    }
  }
}

RTE_INLINE void AgoraRteScene::OnRemoteStreamStateChanged(
    const StreamInfo& stream, MediaType media_type, StreamMediaState old_state,
    StreamMediaState new_state, StreamStateChangedReason reason) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnRemoteStreamStateChanged(stream, media_type, old_state,
                                            new_state, reason);
      });
}

RTE_INLINE void AgoraRteScene::OnAudioVolumeIndication(
    const std::vector<AudioVolumeInfo>& speakers, int total_volume) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnAudioVolumeIndication(speakers, total_volume);
      });
}

RTE_INLINE void AgoraRteScene::OnActiveSpeaker(const std::string& stream_id) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_,
      [&](const auto& handler) { handler->OnActiveSpeaker(stream_id); });
}

RTE_INLINE void AgoraRteScene::OnSceneTokenWillExpire(
    const std::string& token) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnSceneTokenWillExpire(scene_id_, token);
      });
}

RTE_INLINE void AgoraRteScene::OnSceneTokenExpired() {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_,
      [&](const auto& handler) { handler->OnSceneTokenExpired(scene_id_); });
}

RTE_INLINE void AgoraRteScene::OnStreamTokenWillExpire(
    const std::string& stream_id, const std::string& token) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnStreamTokenWillExpire(stream_id, token);
      });
}

RTE_INLINE void AgoraRteScene::OnStreamTokenExpired(
    const std::string& stream_id) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_,
      [&](const auto& handler) { handler->OnStreamTokenExpired(stream_id); });
}

RTE_INLINE void AgoraRteScene::OnCdnStateChanged(
    const std::string& stream_id, const char* url,
    rtc::RTMP_STREAM_PUBLISH_STATE state,
    rtc::RTMP_STREAM_PUBLISH_ERROR_TYPE err_code) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        std::string url_str(url);
        int state_value = static_cast<int>(state);
        int err_value = static_cast<int>(err_code);
        handler->OnCloudCdnStateChanged(
            stream_id, url_str,
            static_cast<CLOUDCDN_STREAM_PUBLISH_STATE>(state_value),
            static_cast<CLOUDCDN_STREAM_PUBLISH_ERROR>(err_value));
      });
}

RTE_INLINE void AgoraRteScene::OnCdnPublished(const std::string& stream_id,
                                              const char* url, int error) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        std::string url_str(url);
        handler->OnCloudCdnPublished(
            stream_id, url, static_cast<CLOUDCDN_STREAM_PUBLISH_ERROR>(error));
      });
}

RTE_INLINE void AgoraRteScene::OnCdnUnpublished(const std::string& stream_id,
                                                const char* url) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        std::string url_str(url);
        handler->OnCloudCdnUnpublished(stream_id, url);
      });
}

RTE_INLINE void AgoraRteScene::OnCdnTranscodingUpdated(
    const std::string& stream_id) {
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteSceneEventHandler>(
      callback_lock_, event_handlers_, [&](const auto& handler) {
        handler->OnCloudTranscodingUpdated(stream_id);
      });
}

RTE_INLINE void AgoraRteScene::OnRemoteVideoFrame(
    const std::string& stream_id, const media::base::VideoFrame& frame) {
  // We could miss the observer in race condition, but it hurts nothing
  //
  if (!remote_video_frame_observers_.empty()) {
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteVideoFrameObserver>(
        callback_lock_, remote_video_frame_observers_,
        [&](const auto& handler) { handler->OnFrame(stream_id, frame); });
  }
}

RTE_INLINE void AgoraRteScene::OnRecordAudioFrame(AudioFrame& audio_frame) {
  if (!audio_frame_observers_.empty()) {
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteAudioFrameObserver>(
        callback_lock_, audio_frame_observers_,
        [&](const auto& handler) { handler->OnRecordAudioFrame(audio_frame); });
  }
}

RTE_INLINE void AgoraRteScene::OnPlaybackAudioFrame(AudioFrame& audio_frame) {
  if (!audio_frame_observers_.empty()) {
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteAudioFrameObserver>(
        callback_lock_, audio_frame_observers_, [&](const auto& handler) {
          handler->OnPlaybackAudioFrame(audio_frame);
        });
  }
}

RTE_INLINE void AgoraRteScene::OnMixedAudioFrame(AudioFrame& audio_frame) {
  if (!audio_frame_observers_.empty()) {
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteAudioFrameObserver>(
        callback_lock_, audio_frame_observers_,
        [&](const auto& handler) { handler->OnMixedAudioFrame(audio_frame); });
  }
}

RTE_INLINE void AgoraRteScene::OnPlaybackAudioFrameBeforeMixing(
    const std::string& stream_id, AudioFrame& audio_frame) {
  if (!audio_frame_observers_.empty()) {
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteAudioFrameObserver>(
        callback_lock_, audio_frame_observers_, [&](const auto& handler) {
          handler->OnPlaybackAudioFrameBeforeMixing(stream_id, audio_frame);
        });
  }
}

RTE_INLINE int AgoraRteScene::DestroyStream(
    const std::string& local_stream_id) {
  std::shared_ptr<AgoraRteLocalStream> stream;
  stream = RemoveLocalStream(local_stream_id);
  if (stream) {
    DestroyStream(stream);
  }

  return ERR_OK;
}

RTE_INLINE void AgoraRteScene::DestroyStream(
    const std::shared_ptr<AgoraRteLocalStream>& local_stream) {
  const std::string& stream_id = local_stream->GetStreamId();

  auto major_stream = GetMajorStream();
  if (major_stream) {
    major_stream->PushStreamInfo({stream_id, user_id_},
                                 InstanceState::kDestroyed);
  }

  local_stream->Disconnect();
}

}  // namespace rte
}  // namespace agora