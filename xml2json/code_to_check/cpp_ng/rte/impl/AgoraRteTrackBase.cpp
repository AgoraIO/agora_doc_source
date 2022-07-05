//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteTrackBase.h"

#include "AgoraRteAudioTrackImpl.h"
#include "AgoraRteRtcStream.h"
#include "AgoraRteStream.h"
#include "AgoraRteVideoTrackImpl.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteTrackBase ::AgoraRteTrackBase() {
  auto current_point =
      std::chrono::system_clock::now().time_since_epoch().count();
  track_id_ += std::to_string(current_point);
  track_id_ += "_";
  track_id_ += std::to_string(GenerateTrackTicket());
}

RTE_INLINE void AgoraRteTrackBase::OnTrackPublished() {
  RTE_LOGGER_CALLBACK(OnTrackPublished, nullptr);
  std::lock_guard<std::mutex> _(track_pub_state_lock_);
  // Customer could unpublish in anytime
  //
  if (track_pub_stat_ == PublishState::kPublishing) {
    track_pub_stat_ = PublishState::kPublished;
  }
}

RTE_INLINE void AgoraRteTrackBase::OnTrackUnpublished() {
  RTE_LOGGER_CALLBACK(OnTrackUnpublished, nullptr);
  std::lock_guard<std::mutex> _(track_pub_state_lock_);
  if (track_pub_stat_ == PublishState::kUnpublishing) {
    SetStreamId("");
    track_pub_stat_ = PublishState::kUnpublished;
  }
}

RTE_INLINE int AgoraRteTrackBase::CheckAndChangePublishState() {
  {
    RTE_LOGGER_MEMBER(nullptr);
    std::lock_guard<std::mutex> _(track_pub_state_lock_);

    if (track_pub_stat_ != PublishState::kUnpublished) {
      return -ERR_INVALID_STATE;
    }
    track_pub_stat_ = PublishState::kPublishing;

    return ERR_OK;
  }
}

RTE_INLINE int AgoraRteTrackBase::CheckAndChangeUnpublishState() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::mutex> _(track_pub_state_lock_);
  if (track_pub_stat_ == PublishState::kUnpublished) {
    return ERR_OK;
  }

  track_state_before_unpub = track_pub_stat_;
  track_pub_stat_ = PublishState::kUnpublishing;
  return ERR_OK;
}

RTE_INLINE int AgoraRteTrackBase::BeforePublish(
    const std::shared_ptr<AgoraRteLocalStream>& stream) {
  RTE_LOGGER_MEMBER("stream: %p", stream.get());
  int result = CheckAndChangePublishState();
  return result;
}

RTE_INLINE void AgoraRteTrackBase::AfterPublish(
    int result, const std::shared_ptr<AgoraRteLocalStream>& stream) {
  RTE_LOGGER_MEMBER("result: %d, stream: %p", result, stream.get());
  if (result == ERR_OK) {
    SetStreamId(stream->GetStreamId());
  } else {
    track_pub_stat_ = PublishState::kUnpublished;
  }
}

RTE_INLINE int AgoraRteTrackBase::BeforeUnPublish(
    const std::shared_ptr<AgoraRteLocalStream>& stream) {
  RTE_LOGGER_MEMBER("stream: %p", stream.get());
  int result = CheckAndChangeUnpublishState();

  return result;
}

RTE_INLINE void AgoraRteTrackBase::AfterUnPublish(
    int result, const std::shared_ptr<AgoraRteLocalStream>& stream) {
  RTE_LOGGER_MEMBER("result: %d, stream: %p", result, stream.get());
  if (result == ERR_OK) {
    OnTrackUnpublished();
  } else {
    track_pub_stat_ = track_state_before_unpub;
  }
}

RTE_INLINE std::shared_ptr<AgoraRteTrackImplBase>
AgoraRteRtcVideoTrackBase::GetTackImpl() {
  return track_impl_;
}

RTE_INLINE int AgoraRteRtcVideoTrackBase::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  if (provider_name.empty() || extension_name.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  return rtc_service_->enableExtension(provider_name.c_str(),
                                       extension_name.c_str(), nullptr, true);
}

RTE_INLINE int AgoraRteRtcVideoTrackBase::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  if (provider_name.empty() || extension_name.empty() || key.empty() ||
      json_value.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  auto local_video_track = GetRtcVideoTrack();
  if (!local_video_track) {
    RTE_LOG_ERROR << "set extension property fail. provider_name:"
                  << provider_name << " extension_name:" << extension_name
                  << " key:" << key << " json_value:" << json_value;
    return -ERR_FAILED;
  }

  const char* id = rtc_service_->getExtensionId(provider_name.c_str(),
                                                extension_name.c_str());
  if (!id) {
    RTE_LOG_ERROR << "get extension id fail. provider_name:" << provider_name
                  << " extension_name:" << extension_name << " key:" << key
                  << " json_value:" << json_value;
    return -ERR_INVALID_ARGUMENT;
  }

  bool has_video_filter = local_video_track->hasVideoFilter(
      id, media::base::VIDEO_MODULE_POSITION::POSITION_POST_CAPTURER);
  if (!has_video_filter) {
    RTE_LOG_ERROR << "has no extension property. provider_name:"
                  << provider_name << " extension_name:" << extension_name
                  << " key:" << key << " json_value:" << json_value;
    return -ERR_INVALID_ARGUMENT;
  }

  if (key == kExtensionPropertyEnabledKey) {
    if (json_value != kExtensionPropertyEnabledValue &&
        json_value != kExtensionPropertyDisabledValue) {
      RTE_LOG_ERROR << "invalid extension property value:" << json_value;
      return -ERR_INVALID_ARGUMENT;
    }
    bool enable = (json_value == kExtensionPropertyEnabledValue);
    return local_video_track->enableVideoFilter(id, enable);
  }

  return local_video_track->setFilterProperty(id, key.c_str(),
                                              json_value.c_str());
}

RTE_INLINE int AgoraRteRtcVideoTrackBase::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  if (provider_name.empty() || extension_name.empty() || key.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  auto local_video_track = GetRtcVideoTrack();
  if (!local_video_track) {
    RTE_LOG_ERROR << "get extension property fail. provider_name:"
                  << provider_name << " extension_name:" << extension_name
                  << " key:" << key;
    return -ERR_FAILED;
  }

  const char* id = rtc_service_->getExtensionId(provider_name.c_str(),
                                                extension_name.c_str());
  if (!id) {
    RTE_LOG_ERROR << "get extension id fail. provider_name:" << provider_name
                  << " extension_name:" << extension_name << " key:" << key;
    return -ERR_INVALID_ARGUMENT;
  }

  bool has_video_filter = local_video_track->hasVideoFilter(
      id, media::base::VIDEO_MODULE_POSITION::POSITION_POST_CAPTURER);
  if (!has_video_filter) {
    RTE_LOG_ERROR << "has no extension property. provider_name:"
                  << provider_name << " extension_name:" << extension_name
                  << " key:" << key;
    return -ERR_INVALID_ARGUMENT;
  }

  constexpr int length = 255;
  char ret_json_value[length];
  if (local_video_track->getFilterProperty(id, key.c_str(), ret_json_value,
                                           length)) {
    return -ERR_FAILED;
  }
  json_value = ret_json_value;
  return ERR_OK;
}

RTE_INLINE std::shared_ptr<AgoraRteTrackImplBase>
AgoraRteRtcAudioTrackBase::GetTackImpl() {
  return track_impl_;
}

RTE_INLINE int AgoraRteRtcAudioTrackBase::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  if (provider_name.empty() || extension_name.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  auto local_audio_track = GetRtcAudioTrack();
  if (!local_audio_track) {
    return -ERR_FAILED;
  }

  auto rte_audio_filter = local_audio_track->getAudioFilter(
      extension_name.c_str(),
      rtc::IAudioTrack::AudioFilterPosition::PostAudioProcessing);
  if (rte_audio_filter) {
    RTE_LOG_WARNING << "already has extension property. provider_name:"
                    << provider_name << " extension_name:" << extension_name;
    return ERR_OK;
  }

  int result = rtc_service_->enableExtension(
      provider_name.c_str(), extension_name.c_str(), nullptr, true);
  if (result != ERR_OK) {
    RTE_LOG_ERROR << "failed to enableExtension. provider_name:"
                  << provider_name << " extension_name:" << extension_name
                  << " result: " << result;
    return result;
  }

  auto media_factory = rtc_service_->createMediaNodeFactory();
  if (!media_factory) {
    RTE_LOG_ERROR << "failed to createMediaNodeFactory";
    return -ERR_FAILED;
  }

  auto audio_filter = media_factory->createAudioFilter(provider_name.c_str(),
                                                       extension_name.c_str());
  if (!audio_filter) {
    RTE_LOG_ERROR << "create audio filter fail. provider_name:" << provider_name
                  << " extension_name:" << extension_name;
    return -ERR_INVALID_ARGUMENT;
  }

  bool ret = local_audio_track->addAudioFilter(
      audio_filter, rtc::IAudioTrack::AudioFilterPosition::PostAudioProcessing);
  if (!ret) {
    RTE_LOG_ERROR << "add audio filter fail. provider_name:" << provider_name
                  << " extension_name:" << extension_name;
    return -ERR_FAILED;
  }

  return ERR_OK;
}

RTE_INLINE int AgoraRteRtcAudioTrackBase::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  if (provider_name.empty() || extension_name.empty() || key.empty() ||
      json_value.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  auto local_audio_track = GetRtcAudioTrack();
  if (!local_audio_track) {
    return -ERR_FAILED;
  }

  auto rte_audio_filter = local_audio_track->getAudioFilter(
      extension_name.c_str(),
      rtc::IAudioTrack::AudioFilterPosition::PostAudioProcessing);
  if (!rte_audio_filter) {
    RTE_LOG_ERROR << "has no extension property. provider_name:"
                  << provider_name << " extension_name:" << extension_name;
    return -ERR_INVALID_ARGUMENT;
  }

  if (key == kExtensionPropertyEnabledKey) {
    if (json_value != kExtensionPropertyEnabledValue &&
        json_value != kExtensionPropertyDisabledValue) {
      RTE_LOG_ERROR << "invalid extension property value:" << json_value;
      return -ERR_INVALID_ARGUMENT;
    }
    bool enable = (json_value == kExtensionPropertyEnabledValue);
    return local_audio_track->enableAudioFilter(extension_name.c_str(), enable);
  }

  return local_audio_track->setFilterProperty(extension_name.c_str(),
                                              key.c_str(), json_value.c_str());
}

RTE_INLINE int AgoraRteRtcAudioTrackBase::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  if (provider_name.empty() || extension_name.empty() || key.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  auto local_audio_track = GetRtcAudioTrack();
  if (!local_audio_track) {
    return -ERR_FAILED;
  }

  auto rte_audio_filter = local_audio_track->getAudioFilter(
      extension_name.c_str(),
      rtc::IAudioTrack::AudioFilterPosition::PostAudioProcessing);
  if (!rte_audio_filter) {
    RTE_LOG_ERROR << "has no extension property. provider_name:"
                  << provider_name << " extension_name:" << extension_name;
    return -ERR_INVALID_ARGUMENT;
  }

  constexpr int length = 255;
  char ret_json_value[length];
  if (rte_audio_filter->setProperty(key.c_str(), ret_json_value, length)) {
    return -ERR_FAILED;
  }
  json_value = ret_json_value;
  return ERR_OK;
}

}  // namespace rte
}  // namespace agora
