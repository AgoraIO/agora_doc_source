//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteCustomVideoTrack.h"

#include "AgoraRteUtils.h"
#include "AgoraRteVideoTrackImpl.h"

namespace agora {
namespace rte {
RTE_INLINE AgoraRteCustomVideoTrack::AgoraRteCustomVideoTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : AgoraRteRtcVideoTrackBase(rtc_service) {
  track_impl_ = std::make_shared<AgoraRteVideoTrackImpl>(rtc_service);

  auto media_node_factory = track_impl_->GetMediaNodeFactory();
  video_frame_sender_ = media_node_factory->createVideoFrameSender();

  auto track = rtc_service->createCustomVideoTrack(video_frame_sender_);

  track_impl_->SetTrack(
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalVideoTrack>(
          track));
  track_impl_->Start();
}

RTE_INLINE SourceType AgoraRteCustomVideoTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kVideo_Custom;
}

RTE_INLINE int AgoraRteCustomVideoTrack::PushVideoFrame(
    const ExternalVideoFrame& frame) {
  return video_frame_sender_->sendVideoFrame(frame);
}

RTE_INLINE int AgoraRteCustomVideoTrack::SetPreviewCanvas(
    const VideoCanvas& canvas) {
  RTE_LOGGER_MEMBER("canvas: (mirrorMode: %d, renderMode: %d, view: %p)",
                    canvas.mirror_mode, canvas.render_mode, canvas.view);
  return track_impl_->SetPreviewCanvas(canvas);
}

RTE_INLINE void AgoraRteCustomVideoTrack::RegisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->RegisterLocalVideoFrameObserver(observer);
}

RTE_INLINE void AgoraRteCustomVideoTrack::UnregisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->UnregisterLocalVideoFrameObserver(observer);
}

RTE_INLINE int AgoraRteCustomVideoTrack::SetFilterProperty(
    const std::string& id, const std::string& key,
    const std::string& json_value) {
  RTE_LOGGER_MEMBER("id: %s, key: %s, json_value: %d", id.c_str(), key.c_str(),
                    json_value.c_str());
  return track_impl_->GetVideoTrack()->setFilterProperty(
      id.c_str(), key.c_str(), json_value.c_str());
}

RTE_INLINE std::string AgoraRteCustomVideoTrack::GetFilterProperty(
    const std::string& id, const std::string& key) {
  RTE_LOGGER_MEMBER(nullptr);
  char buffer[1024];

  if (track_impl_->GetVideoTrack()->getFilterProperty(id.c_str(), key.c_str(),
                                                      buffer, 1024) == ERR_OK) {
    return buffer;
  }

  return "";
}

RTE_INLINE void AgoraRteCustomVideoTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  track_impl_->SetStreamId(stream_id);
}

RTE_INLINE const std::string& AgoraRteCustomVideoTrack::GetAttachedStreamId() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetStreamId();
}

RTE_INLINE std::shared_ptr<agora::rtc::ILocalVideoTrack>
AgoraRteCustomVideoTrack::GetRtcVideoTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetVideoTrack();
}

RTE_INLINE int AgoraRteCustomVideoTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcVideoTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteCustomVideoTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteCustomVideoTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
