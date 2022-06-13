//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteMicrophoneAudioTrack.h"

#include "AgoraRteAudioTrackImpl.h"
#include "AgoraRteUtils.h"
namespace agora {
namespace rte {

RTE_INLINE AgoraRteMicrophoneAudioTrack::AgoraRteMicrophoneAudioTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : AgoraRteRtcAudioTrackBase(rtc_service) {
  track_impl_ = std::make_shared<AgoraRteAudioTrackImpl>(rtc_service);
  auto track = rtc_service->createLocalAudioTrack();
  track_impl_->SetTrack(
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalAudioTrack>(
          track));
}

RTE_INLINE SourceType AgoraRteMicrophoneAudioTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kAudio_Microphone;
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::AdjustPublishVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return track_impl_->AdjustPublishVolume(volume);
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::AdjustPlayoutVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return track_impl_->AdjustPlayoutVolume(volume);
}

RTE_INLINE const std::string&
AgoraRteMicrophoneAudioTrack::GetAttachedStreamId() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetStreamId();
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::StartRecording() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->Start();
}

RTE_INLINE void AgoraRteMicrophoneAudioTrack::StopRecording() {
  RTE_LOGGER_MEMBER(nullptr);
  track_impl_->Stop();
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::EnableEarMonitor(
    bool enable, int include_audio_filter) {
  RTE_LOGGER_MEMBER("enable: %, include_audio_filter: %d", enable,
                    include_audio_filter);
  return track_impl_->EnableEarMonitor(enable, include_audio_filter);
}

RTE_INLINE void AgoraRteMicrophoneAudioTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  return track_impl_->SetStreamId(stream_id);
}

RTE_INLINE std::shared_ptr<agora::rtc::ILocalAudioTrack>
AgoraRteMicrophoneAudioTrack::GetRtcAudioTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetAudioTrack();
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::EnableLocalPlayback() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->EnableLocalPlayback();
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcAudioTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcAudioTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteMicrophoneAudioTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcAudioTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
