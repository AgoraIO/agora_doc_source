//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteScreenVideoTrack.h"

#include "AgoraRteUtils.h"
#include "AgoraRteVideoTrackImpl.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteScreenVideoTrack::AgoraRteScreenVideoTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : AgoraRteRtcVideoTrackBase(rtc_service) {
  track_impl_ = std::make_shared<AgoraRteVideoTrackImpl>(rtc_service);

  auto media_node_factory = track_impl_->GetMediaNodeFactory();
  capture_ = media_node_factory->createScreenCapturer();

  auto track = rtc_service->createScreenVideoTrack(capture_);

  track_impl_->SetTrack(
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalVideoTrack>(
          track));
}

RTE_INLINE int AgoraRteScreenVideoTrack::SetPreviewCanvas(
    const VideoCanvas& canvas) {
  RTE_LOGGER_MEMBER("canvas: (mirrorMode: %d, renderMode: %d, view: %p)",
                    canvas.mirror_mode, canvas.render_mode, canvas.view);

  return track_impl_->SetPreviewCanvas(canvas);
}

RTE_INLINE SourceType AgoraRteScreenVideoTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kVideo_Screen;
}

RTE_INLINE void AgoraRteScreenVideoTrack::RegisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  track_impl_->RegisterLocalVideoFrameObserver(observer);
}

RTE_INLINE void AgoraRteScreenVideoTrack::UnregisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->UnregisterLocalVideoFrameObserver(observer);
}

RTE_INLINE int AgoraRteScreenVideoTrack::SetFilterProperty(
    const std::string& id, const std::string& key,
    const std::string& json_value) {
  RTE_LOGGER_MEMBER("id: %s, key: %s, json_value: %s", id.c_str(), key.c_str(),
                    json_value.c_str());

  return track_impl_->GetVideoTrack()->setFilterProperty(
      id.c_str(), key.c_str(), json_value.c_str());
}

RTE_INLINE std::string AgoraRteScreenVideoTrack::GetFilterProperty(
    const std::string& id, const std::string& key) {
  RTE_LOGGER_MEMBER("id: %s, key: %s", id.c_str(), key.c_str());
  char buffer[1024];

  if (track_impl_->GetVideoTrack()->getFilterProperty(id.c_str(), key.c_str(),
                                                      buffer, 1024) == ERR_OK) {
    return buffer;
  }

  return "";
}

RTE_INLINE void AgoraRteScreenVideoTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  track_impl_->SetStreamId(stream_id);
}

RTE_INLINE const std::string& AgoraRteScreenVideoTrack::GetAttachedStreamId() {
  return track_impl_->GetStreamId();
}

#if RTE_WIN
RTE_INLINE int AgoraRteScreenVideoTrack::StartCaptureScreen(
    const Rectangle& screenRect, const Rectangle& region_rect) {
  RTE_LOGGER_MEMBER(
      "screenRect: (height: %d, width: %d, x: %d, y: %d), \
      reginRect: (height: %d, width: %d, x: %d, y: %d)",
      screenRect.height, screenRect.width, screenRect.x, screenRect.y,
      region_rect.height, region_rect.width, region_rect.x, region_rect.y);
  int result = capture_->initWithScreenRect(screenRect, region_rect);
  if (result == ERR_OK) {
    return track_impl_->Start();
  }

  return result;
}

RTE_INLINE int AgoraRteScreenVideoTrack::StartCaptureWindow(
    view_t windowId, const Rectangle& region_rect) {
  RTE_LOGGER_MEMBER(
      "windowId: %p, reginRect: (height: %d, width: %d, x: %d, y: %d)",
      windowId, region_rect.height, region_rect.width, region_rect.x,
      region_rect.y);

  int result = capture_->initWithWindowId(windowId, region_rect);
  if (result == ERR_OK) {
    return track_impl_->Start();
  }

  return result;
}
#elif RTE_MAC
RTE_INLINE int AgoraRteScreenVideoTrack::StartCaptureScreen(
    uint32_t display_id, const Rectangle& region_rect) {
  int result = capture_->initWithDisplayId(display_id, region_rect);
  if (result == ERR_OK) {
    return track_impl_->Start();
  }

  return result;
}

RTE_INLINE int AgoraRteScreenVideoTrack::StartCaptureWindow(
    view_t window_id, const Rectangle& region_rect) {
  int result = capture_->initWithWindowId(window_id, region_rect);
  if (result == ERR_OK) {
    return track_impl_->Start();
  }

  return result;
}
#elif RTE_ANDROID
RTE_INLINE int AgoraRteScreenVideoTrack::StartCaptureScreen(
    void* data, const VideoDimensions& dimensions) {
  int result =
      capture_->initWithMediaProjectionPermissionResultData(data, dimensions);
  if (result == ERR_OK) {
    return track_impl_->Start();
  }

  return result;
}
#elif RTE_IPHONE
RTE_INLINE int AgoraRteScreenVideoTrack::StartCaptureScreen() {
  return track_impl_->Start();
}
#endif

RTE_INLINE void AgoraRteScreenVideoTrack::StopCapture() {
  RTE_LOGGER_MEMBER(nullptr);
  track_impl_->Stop();
}

#if RTE_WIN || RTE_MAC

RTE_INLINE int AgoraRteScreenVideoTrack::SetContentHint(
    VIDEO_CONTENT_HINT content_hint) {
  RTE_LOGGER_MEMBER("content_hint: %d", content_hint);
  return capture_->setContentHint(content_hint);
}

RTE_INLINE int AgoraRteScreenVideoTrack::UpdateScreenCaptureRegion(
    const Rectangle& region_rect) {
  RTE_LOGGER_MEMBER("region_rect: (height: %d, width: %d, x: %d, y: %d)",
                    region_rect.height, region_rect.width, region_rect.x,
                    region_rect.y);
  return capture_->updateScreenCaptureRegion(region_rect);
}
#endif

RTE_INLINE std::shared_ptr<agora::rtc::ILocalVideoTrack>
AgoraRteScreenVideoTrack::GetRtcVideoTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetVideoTrack();
}

RTE_INLINE int AgoraRteScreenVideoTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcVideoTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteScreenVideoTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteScreenVideoTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
