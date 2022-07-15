//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteWrapperVideoTrack.h"

#include "AgoraRteUtils.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteWrapperVideoTrack::AgoraRteWrapperVideoTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
    const std::shared_ptr<rtc::ILocalVideoTrack>& rtc_video_track)
    : AgoraRteRtcVideoTrackBase(rtc_service) {
  track_impl_ = std::make_shared<AgoraRteVideoTrackImpl>(rtc_service);
  track_impl_->SetTrack(rtc_video_track);
}

//////////////////////////////////////////////////////////////////////
///////////////// Override Methods of IAgoraRteVideoTrack ////////////
///////////////////////////////////////////////////////////////////////
RTE_INLINE int AgoraRteWrapperVideoTrack::SetPreviewCanvas(
    const VideoCanvas& canvas) {
  RTE_LOGGER_MEMBER("canvas: (mirrorMode: %d, renderMode: %d, view: %p)",
                    canvas.mirror_mode, canvas.render_mode, canvas.view);

  return track_impl_->SetPreviewCanvas(canvas);
}

RTE_INLINE SourceType AgoraRteWrapperVideoTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kVideo_Wrapper;
}

RTE_INLINE void AgoraRteWrapperVideoTrack::RegisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->RegisterLocalVideoFrameObserver(observer);
}
RTE_INLINE void AgoraRteWrapperVideoTrack::UnregisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->UnregisterLocalVideoFrameObserver(observer);
}

RTE_INLINE int AgoraRteWrapperVideoTrack::SetFilterProperty(
    const std::string& id, const std::string& key,
    const std::string& json_value) {
  RTE_LOGGER_MEMBER("id: %s, key: %s, json_value: %s", key.c_str(), key.c_str(),
                    json_value.c_str());
  return track_impl_->GetVideoTrack()->setFilterProperty(
      id.c_str(), key.c_str(), json_value.c_str());
}

RTE_INLINE std::string AgoraRteWrapperVideoTrack::GetFilterProperty(
    const std::string& id, const std::string& key) {
  RTE_LOGGER_MEMBER("id: %s, key: %s", id.c_str(), key.c_str());
  char buffer[1024];

  if (track_impl_->GetVideoTrack()->getFilterProperty(id.c_str(), key.c_str(),
                                                      buffer, 1024) == ERR_OK) {
    return buffer;
  }

  return "";
}

RTE_INLINE const std::string& AgoraRteWrapperVideoTrack::GetAttachedStreamId() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetStreamId();
}

///////////////////////////////////////////////////////////////////////////////
///////////////// Override Methods of AgoraRteRtcVideoTrackBase ///////////////
///////////////////////////////////////////////////////////////////////////////
RTE_INLINE std::shared_ptr<agora::rtc::ILocalVideoTrack>
AgoraRteWrapperVideoTrack::GetRtcVideoTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetVideoTrack();
}

////////////////////////////////////////////////////////////////////
///////////////// Override Methods of AgoraRteTrackBase ////////////
////////////////////////////////////////////////////////////////////
RTE_INLINE void AgoraRteWrapperVideoTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  track_impl_->SetStreamId(stream_id);
}

RTE_INLINE int AgoraRteWrapperVideoTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcVideoTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteWrapperVideoTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteWrapperVideoTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
