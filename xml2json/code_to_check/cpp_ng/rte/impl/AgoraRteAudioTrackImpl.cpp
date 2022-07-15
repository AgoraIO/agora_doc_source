//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteAudioTrackImpl.h"

#include "AgoraRteUtils.h"
#include "NGIAgoraAudioTrack.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteAudioTrackImpl::AgoraRteAudioTrackImpl(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service) {
  rtc_service_ = rtc_service;

  auto media_node_factory = rtc_service->createMediaNodeFactory();

  media_node_factory_ =
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IMediaNodeFactory>(
          media_node_factory);
}

RTE_INLINE void AgoraRteAudioTrackImpl::SetTrack(
    const std::shared_ptr<rtc::ILocalAudioTrack>& track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  audio_track_ = track;
}

RTE_INLINE int AgoraRteAudioTrackImpl::EnableLocalPlayback() {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_track_->enableLocalPlayback(true);
}

RTE_INLINE int AgoraRteAudioTrackImpl::AdjustPublishVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return audio_track_->adjustPublishVolume(volume);
}

RTE_INLINE int AgoraRteAudioTrackImpl::AdjustPlayoutVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return audio_track_->adjustPlayoutVolume(volume);
}

RTE_INLINE int AgoraRteAudioTrackImpl::EnableEarMonitor(
    bool enable, int include_audio_filter) {
  RTE_LOGGER_MEMBER("enable: %d, include_audio_filter: %d", enable,
                    include_audio_filter);
  audio_track_->enableEarMonitor(enable, include_audio_filter);
  return ERR_OK;
}

RTE_INLINE std::shared_ptr<agora::rtc::ILocalAudioTrack>
AgoraRteAudioTrackImpl::GetAudioTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_track_;
}

RTE_INLINE int AgoraRteAudioTrackImpl::Start() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::mutex> _(track_lock_);
  if (is_started_) {
    return ERR_OK;
  }

  bool enable_track = true;
  audio_track_->setEnabled(enable_track);

  is_started_ = true;

  return ERR_OK;
}

RTE_INLINE void AgoraRteAudioTrackImpl::Stop() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::mutex> _(track_lock_);
  bool enable_playback = false;
  audio_track_->enableLocalPlayback(enable_playback);
  bool enable_track = false;
  audio_track_->setEnabled(enable_track);

  is_started_ = false;
}
}  // namespace rte
}  // namespace agora
