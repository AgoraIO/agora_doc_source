//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteWrapperAudioTrack.h"

#include "AgoraRteUtils.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteWrapperAudioTrack::AgoraRteWrapperAudioTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
    const std::shared_ptr<rtc::ILocalAudioTrack>& rtc_audio_track)
    : AgoraRteRtcAudioTrackBase(rtc_service) {
  track_impl_ = std::make_shared<AgoraRteAudioTrackImpl>(rtc_service);
  track_impl_->SetTrack(rtc_audio_track);
}

//////////////////////////////////////////////////////////////////////
///////////////// Override Methods of IAgoraRteAudioTrack ////////////
///////////////////////////////////////////////////////////////////////
RTE_INLINE int AgoraRteWrapperAudioTrack::EnableLocalPlayback() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->EnableLocalPlayback();
}

RTE_INLINE SourceType AgoraRteWrapperAudioTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kAudio_Wrapper;
}

RTE_INLINE int AgoraRteWrapperAudioTrack::AdjustPublishVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return track_impl_->AdjustPublishVolume(volume);
}

RTE_INLINE int AgoraRteWrapperAudioTrack::AdjustPlayoutVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return track_impl_->AdjustPlayoutVolume(volume);
}

RTE_INLINE const std::string& AgoraRteWrapperAudioTrack::GetAttachedStreamId() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetStreamId();
}

////////////////////////////////////////////////////////////////////////////////
///////////////// Override Methods of AgoraRteRtcAudioTrackBase ////////////////
////////////////////////////////////////////////////////////////////////////////
RTE_INLINE std::shared_ptr<agora::rtc::ILocalAudioTrack>
AgoraRteWrapperAudioTrack::GetRtcAudioTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetAudioTrack();
}

////////////////////////////////////////////////////////////////////
///////////////// Override Methods of AgoraRteTrackBase ////////////
////////////////////////////////////////////////////////////////////
RTE_INLINE void AgoraRteWrapperAudioTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  track_impl_->SetStreamId(stream_id);
}

RTE_INLINE int AgoraRteWrapperAudioTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcAudioTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteWrapperAudioTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcAudioTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteWrapperAudioTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcAudioTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
