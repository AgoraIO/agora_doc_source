//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteTrackBase.h"

namespace agora {
namespace rte {

class AgoraRteCustomVideoTrack final : public IAgoraRteCustomVideoTrack,
                                       public AgoraRteRtcVideoTrackBase {
 public:
  explicit AgoraRteCustomVideoTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteCustomVideoTrack() = default;

  SourceType GetSourceType() override;

  int SetPreviewCanvas(const VideoCanvas& canvas) override;

  void RegisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  void UnregisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  int SetFilterProperty(const std::string& id, const std::string& key,
                        const std::string& json_value) override;

  std::string GetFilterProperty(const std::string& id,
                                const std::string& key) override;

  const std::string& GetAttachedStreamId() override;

  void SetStreamId(const std::string& stream_id) override;

  std::shared_ptr<agora::rtc::ILocalVideoTrack> GetRtcVideoTrack()
      const override;

  int PushVideoFrame(const ExternalVideoFrame& frame) override;

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
  agora_refptr<rtc::IVideoFrameSender> video_frame_sender_;
};

}  // namespace rte
}  // namespace agora
