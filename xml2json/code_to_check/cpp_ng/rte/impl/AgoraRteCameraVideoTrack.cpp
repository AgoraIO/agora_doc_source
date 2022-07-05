//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteCameraVideoTrack.h"

#include "AgoraRteBase.h"
#include "AgoraRteUtils.h"
#include "AgoraRteVideoTrackImpl.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteCameraObserver::AgoraRteCameraObserver(
    const std::shared_ptr<AgoraRteCameraVideoTrack>& camera_track)
    : camera_track_(camera_track) {}

RTE_INLINE void AgoraRteCameraObserver::onCameraStateChanged(
    ICameraCapturer::CAMERA_STATE state,
    ICameraCapturer::CAMERA_SOURCE source) {
  RTE_LOGGER_CALLBACK(onCameraStateChanged, "state: %d, source: %d", state,
                      source);
  auto camera_track = camera_track_.lock();
  if (camera_track) {
    auto& callback = camera_track->GetCallback();
    if (callback) {
      callback(state == ICameraCapturer::CAMERA_STATE::CAMERA_STARTED
                   ? CameraState::kStarted
                   : CameraState::kStopped,
               source == ICameraCapturer::CAMERA_SOURCE::CAMERA_BACK
                   ? CameraSource::kBack
                   : CameraSource::kFront);
    }
  }
}

RTE_INLINE void AgoraRteCameraVideoTrack::Init() {
  RTE_LOGGER_MEMBER(nullptr);
  auto this_shared =
      std::static_pointer_cast<AgoraRteCameraVideoTrack>(shared_from_this());
  camera_ob_ = std::make_shared<AgoraRteCameraObserver>(this_shared);
  camera_capturer_->registerCameraObserver(camera_ob_.get());
}

RTE_INLINE rtc::ICameraCapturer::CAMERA_SOURCE
AgoraRteCameraVideoTrack::GetRtcCameraSource(CameraSource src) {
  RTE_LOGGER_MEMBER("src: %d", src);
  switch (src) {
    case agora::rte::CameraSource::kFront:
      return rtc::ICameraCapturer::CAMERA_FRONT;
      break;
    case agora::rte::CameraSource::kBack:
      return rtc::ICameraCapturer::CAMERA_BACK;
      break;
    default:
      return rtc::ICameraCapturer::CAMERA_FRONT;
      break;
  }
}

#if RTE_IPHONE || RTE_ANDROID
RTE_INLINE int AgoraRteCameraVideoTrack::SetCameraSource(CameraSource source) {
  RTE_LOGGER_MEMBER("source: %d", source);
  int result = -ERR_FAILED;
  rtc::ICameraCapturer::CAMERA_SOURCE src =
      rtc::ICameraCapturer::CAMERA_SOURCE::CAMERA_FRONT;

  if (source == CameraSource::kBack) {
    src = rtc::ICameraCapturer::CAMERA_SOURCE::CAMERA_BACK;
  }

  std::lock_guard<std::mutex> _(camera_track_lock_);
  {
    result = camera_capturer_->setCameraSource(src);

    if (result == ERR_OK) {
      is_camera_source_assigned_ = true;
    }
  }

  return result;
}

RTE_INLINE void AgoraRteCameraVideoTrack::SwitchCamera() {
  RTE_LOGGER_MEMBER(nullptr);
  camera_capturer_->switchCamera();
}

RTE_INLINE int AgoraRteCameraVideoTrack::SetCameraZoom(float zoomValue) {
  RTE_LOGGER_MEMBER("zoomValue: %d", zoomValue);
  return camera_capturer_->setCameraZoom(zoomValue);
}

RTE_INLINE int AgoraRteCameraVideoTrack::SetCameraFocus(float x, float y) {
  RTE_LOGGER_MEMBER("x: %f, y: %f", x, y);
  return camera_capturer_->setCameraFocus(x, y);
}

RTE_INLINE int AgoraRteCameraVideoTrack::SetCameraAutoFaceFocus(bool enable) {
  RTE_LOGGER_MEMBER("enable: %d", enable);
  return camera_capturer_->setCameraAutoFaceFocus(enable);
}

RTE_INLINE int AgoraRteCameraVideoTrack::SetCameraFaceDetection(bool enable) {
  // TODO(minbo) Align the Arsenal
  RTE_LOGGER_MEMBER("enable: %d", enable);
  return camera_capturer_->enableFaceDetection(enable);
}
#elif RTE_DESKTOP

RTE_INLINE int AgoraRteCameraVideoTrack::SetCameraDevice(
    const std::string& device_id) {
  RTE_LOGGER_MEMBER("device_id: %s", device_id.c_str());
  int result = -ERR_FAILED;
  std::lock_guard<std::mutex> _(camera_track_lock_);
  {
    result = camera_capturer_->initWithDeviceId(device_id.c_str());

    if (result == ERR_OK) {
      is_camera_source_assigned_ = true;
    }
  }

  return result;
}

RTE_INLINE void AgoraRteCameraVideoTrack::SetDeviceOrientation(
    VIDEO_ORIENTATION orientation) {
  RTE_LOGGER_MEMBER("orientation: %d", orientation);
  camera_capturer_->setDeviceOrientation(orientation);
}

#endif

RTE_INLINE int AgoraRteCameraVideoTrack::SetPreviewCanvas(
    const VideoCanvas& canvas) {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->SetPreviewCanvas(canvas);
}

RTE_INLINE SourceType AgoraRteCameraVideoTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kVideo_Camera;
}

RTE_INLINE void AgoraRteCameraVideoTrack::RegisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->RegisterLocalVideoFrameObserver(observer);
}

RTE_INLINE void AgoraRteCameraVideoTrack::UnregisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->UnregisterLocalVideoFrameObserver(observer);
}

RTE_INLINE int AgoraRteCameraVideoTrack::SetFilterProperty(
    const std::string& id, const std::string& key,
    const std::string& json_value) {
  RTE_LOGGER_MEMBER("id: %d, key: %d, json_value:%s", id.c_str(), key.c_str(),
                    json_value.c_str());
  return track_impl_->GetVideoTrack()->setFilterProperty(
      id.c_str(), key.c_str(), json_value.c_str());
}

RTE_INLINE std::string AgoraRteCameraVideoTrack::GetFilterProperty(
    const std::string& id, const std::string& key) {
  RTE_LOGGER_MEMBER(nullptr);
  char buffer[1024];

  if (track_impl_->GetVideoTrack()->getFilterProperty(id.c_str(), key.c_str(),
                                                      buffer, 1024) == ERR_OK) {
    return buffer;
  }

  return "";
}

RTE_INLINE int AgoraRteCameraVideoTrack::StartCapture(
    CameraCallbackFun callback) {
  RTE_LOGGER_MEMBER(nullptr);
  int result = ERR_OK;

  callback_ = callback;

  if (!is_camera_source_assigned_) {
    std::lock_guard<std::mutex> _(camera_track_lock_);
    if (!is_camera_source_assigned_) {
      is_camera_source_assigned_ = true;
#if RTE_IPHONE || RTE_ANDROID
      result =
          camera_capturer_->setCameraSource(rtc::ICameraCapturer::CAMERA_FRONT);

#elif RTE_DESKTOP
      constexpr int max_device_name = 260;
      result = -ERR_FAILED;

      std::unique_ptr<rtc::ICameraCapturer::IDeviceInfo> device_info(
          camera_capturer_->createDeviceInfo());
      if (device_info && device_info->NumberOfDevices() > 0) {
        std::string device_id;

        auto device_name = std::make_unique<char[]>(max_device_name);
        auto device_uuid = std::make_unique<char[]>(max_device_name);
        auto id = std::make_unique<char[]>(max_device_name);
        if (device_info->GetDeviceName(0, device_name.get(), max_device_name,
                                       id.get(), max_device_name,
                                       device_uuid.get(),
                                       max_device_name) == ERR_OK) {
          device_id.assign(id.get());
        }

        if (!device_id.empty()) {
          result = camera_capturer_->initWithDeviceId(device_id.c_str());
        }
      }
#endif
    }
  }

  if (result == ERR_OK) {
    result = track_impl_->Start();
  }

  return result;
}

RTE_INLINE void AgoraRteCameraVideoTrack::StopCapture() {
  RTE_LOGGER_MEMBER(nullptr);
  track_impl_->Stop();
}

RTE_INLINE void AgoraRteCameraVideoTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  track_impl_->SetStreamId(stream_id);
}

RTE_INLINE const std::string& AgoraRteCameraVideoTrack::GetAttachedStreamId() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetStreamId();
}

RTE_INLINE std::shared_ptr<agora::rtc::ILocalVideoTrack>
AgoraRteCameraVideoTrack::GetRtcVideoTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetVideoTrack();
}

RTE_INLINE AgoraRteCameraVideoTrack::AgoraRteCameraVideoTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : AgoraRteRtcVideoTrackBase(rtc_service) {
  auto track_impl = std::make_shared<AgoraRteVideoTrackImpl>(rtc_service);

  auto media_node_factory = track_impl->GetMediaNodeFactory();

  camera_capturer_ = media_node_factory->createCameraCapturer();

  auto track = rtc_service->createCameraVideoTrack(camera_capturer_);
  track_impl->SetTrack(
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalVideoTrack>(
          track));

  track_impl_ = track_impl;
}

RTE_INLINE AgoraRteCameraVideoTrack::~AgoraRteCameraVideoTrack() {
  camera_capturer_->unregisterCameraObserver(camera_ob_.get());
}

RTE_INLINE int AgoraRteCameraVideoTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcVideoTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteCameraVideoTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteCameraVideoTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
