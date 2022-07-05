//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteCustomAudioTrack.h"

#include "AgoraRteAudioTrackImpl.h"
#include "AgoraRteUtils.h"

namespace agora {
namespace rte {
RTE_INLINE AgoraRteCustomAudioTrack::AgoraRteCustomAudioTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : AgoraRteRtcAudioTrackBase(rtc_service) {
  track_impl_ = std::make_shared<AgoraRteAudioTrackImpl>(rtc_service);

  auto media_node_factory = track_impl_->GetMediaNodeFactory();

  audio_frame_sender_ = media_node_factory->createAudioPcmDataSender();

  auto track = rtc_service->createCustomAudioTrack(audio_frame_sender_);

  track_impl_->SetTrack(
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalAudioTrack>(
          track));
  track_impl_->Start();
}

RTE_INLINE int AgoraRteCustomAudioTrack::EnableLocalPlayback() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->EnableLocalPlayback();
}

RTE_INLINE SourceType AgoraRteCustomAudioTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kAudio_Custom;
}

RTE_INLINE int AgoraRteCustomAudioTrack::AdjustPlayoutVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return track_impl_->AdjustPlayoutVolume(volume);
}

RTE_INLINE int AgoraRteCustomAudioTrack::AdjustPublishVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return track_impl_->AdjustPublishVolume(volume);
}

RTE_INLINE const std::string& AgoraRteCustomAudioTrack::GetAttachedStreamId() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetStreamId();
}

RTE_INLINE int AgoraRteCustomAudioTrack::PushAudioFrame(AudioFrame& frame) {
  return audio_frame_sender_->sendAudioPcmData(
      frame.buffer, 0, frame.samplesPerChannel, frame.bytesPerSample,
      frame.channels, frame.samplesPerSec);
}

RTE_INLINE void AgoraRteCustomAudioTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  track_impl_->SetStreamId(stream_id);
}

RTE_INLINE std::shared_ptr<agora::rtc::ILocalAudioTrack>
AgoraRteCustomAudioTrack::GetRtcAudioTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetAudioTrack();
}

RTE_INLINE int AgoraRteCustomAudioTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcAudioTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteCustomAudioTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcAudioTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteCustomAudioTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcAudioTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
