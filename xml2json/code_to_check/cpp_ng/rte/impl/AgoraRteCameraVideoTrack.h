//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteTrackBase.h"

namespace agora {
namespace rte {

class AgoraRteScene;
class AgoraRteCameraVideoTrack;

class AgoraRteCameraObserver final : public rtc::ICameraCaptureObserver {
 public:
  explicit AgoraRteCameraObserver(
      const std::shared_ptr<AgoraRteCameraVideoTrack>& camera_track);

  void onCameraStateChanged(ICameraCapturer::CAMERA_STATE state,
                            ICameraCapturer::CAMERA_SOURCE source) override;

 protected:
  std::weak_ptr<AgoraRteCameraVideoTrack> camera_track_;
};

class AgoraRteCameraVideoTrack final : public IAgoraRteCameraVideoTrack,
                                       public AgoraRteRtcVideoTrackBase {
 public:
  explicit AgoraRteCameraVideoTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteCameraVideoTrack();

#if RTE_IPHONE || RTE_ANDROID
  int SetCameraSource(CameraSource source) override;

  void SwitchCamera() override;

  int SetCameraZoom(float zoomValue) override;

  int SetCameraFocus(float x, float y) override;

  int SetCameraAutoFaceFocus(bool enable) override;

  int SetCameraFaceDetection(bool enable) override;
#elif RTE_DESKTOP
  int SetCameraDevice(const std::string& device_id) override;

  void SetDeviceOrientation(VIDEO_ORIENTATION orientation) override;

#endif

  int SetPreviewCanvas(const VideoCanvas& canvas) override;

  SourceType GetSourceType() override;

  const std::string& GetAttachedStreamId() override;

  void RegisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  void UnregisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  int SetFilterProperty(const std::string& id, const std::string& key,
                        const std::string& json_value) override;

  std::string GetFilterProperty(const std::string& id,
                                const std::string& key) override;

  int StartCapture(CameraCallbackFun callback = nullptr) override;

  void StopCapture() override;

  void Init() override;

  void SetStreamId(const std::string& stream_id) override;

  std::shared_ptr<agora::rtc::ILocalVideoTrack> GetRtcVideoTrack()
      const override;

  int EnableExtension(const std::string& provider_name,
                      const std::string& extension_nam) override;

  int SetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           const std::string& json_value) override;

  int GetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           std::string& json_value) override;

  CameraCallbackFun& GetCallback() { return callback_; }

 private:
  rtc::ICameraCapturer::CAMERA_SOURCE GetRtcCameraSource(CameraSource src);

 protected:
  agora_refptr<rtc::ICameraCapturer> camera_capturer_;
  CameraSource source_ = CameraSource::kFront;
  std::mutex camera_track_lock_;
  bool is_camera_source_assigned_ = false;
  std::shared_ptr<AgoraRteCameraObserver> camera_ob_;
  CameraCallbackFun callback_;
};
}  // namespace rte
}  // namespace agora
