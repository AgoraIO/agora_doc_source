//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteTrackBase.h"

namespace agora {

namespace rte {

class AgoraRteScreenVideoTrack : public IAgoraRteScreenVideoTrack,
                                 public AgoraRteRtcVideoTrackBase {
 public:
  explicit AgoraRteScreenVideoTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteScreenVideoTrack() = default;

  // Inherited via IAgoraRteScreenVideoTrack
  int SetPreviewCanvas(const VideoCanvas& canvas) override;

  SourceType GetSourceType() override;

  void RegisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  void UnregisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  int SetFilterProperty(const std::string& id, const std::string& key,
                        const std::string& json_value) override;

  std::string GetFilterProperty(const std::string& id,
                                const std::string& key) override;

  const std::string& GetAttachedStreamId() override;

#if RTE_WIN
  int StartCaptureScreen(const Rectangle& screenRect,
                         const Rectangle& regionRect) override;

  int StartCaptureWindow(view_t windowId, const Rectangle& regionRect) override;
#elif RTE_MAC
  int StartCaptureScreen(uint32_t display_id,
                         const Rectangle& region_rect) override;

  int StartCaptureWindow(view_t window_id,
                         const Rectangle& region_rect) override;
#elif RTE_ANDROID
  int StartCaptureScreen(void* data,
                         const VideoDimensions& dimensions) override;
#elif RTE_IPHONE
  int StartCaptureScreen() override;
#endif

  void StopCapture() override;

#if RTE_WIN || RTE_MAC
  int SetContentHint(VIDEO_CONTENT_HINT content_hint) override;

  int UpdateScreenCaptureRegion(const Rectangle& region_rect) override;
#endif

  // Inherited via AgoraRteRtcVideoTrackBase
  void SetStreamId(const std::string& stream_id) override;
  std::shared_ptr<agora::rtc::ILocalVideoTrack> GetRtcVideoTrack()
      const override;

  int EnableExtension(const std::string& provider_name,
                      const std::string& extension_name) override;

  int SetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           const std::string& json_value) override;

  int GetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           std::string& json_value) override;

 private:
  agora_refptr<rtc::IScreenCapturer> capture_;
};
}  // namespace rte
}  // namespace agora
