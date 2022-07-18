//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteTrackBase.h"

namespace agora {
namespace rte {
class AgoraRteMixedVideoTrack final : public IAgoraRteMixedVideoTrack,
                                      public AgoraRteRtcVideoTrackBase {
 public:
  explicit AgoraRteMixedVideoTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteMixedVideoTrack();

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

  int SetLayout(const LayoutConfigs& layout_configs) override;

  int GetLayout(LayoutConfigs& layout_configs) override;

  int AddTrack(std::shared_ptr<IAgoraRteVideoTrack> track) override;

  int RemoveTrack(std::shared_ptr<IAgoraRteVideoTrack> track) override;

  int AddMediaPlayer(
      std::shared_ptr<IAgoraRteMediaPlayer> media_player) override;

  int RemoveMediaPlayer(
      std::shared_ptr<IAgoraRteMediaPlayer> media_player) override;

  void SetStreamId(const std::string& stream_id) override;

  std::shared_ptr<agora::rtc::ILocalVideoTrack> GetRtcVideoTrack()
      const override;

  int BeforeVideoEncodingChanged(
      const VideoEncoderConfiguration& config) override;

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
  int AddImage(const std::string& id, const rtc::MixerLayoutConfig& layout);

  int RemoveImage(const std::string& id);

 protected:
  agora_refptr<rtc::IVideoMixerSource> video_mixer_;
  Optional<LayoutConfigs> layout_configs_;
  int fps_from_encoder_ = 0;
};
}  // namespace rte
}  // namespace agora
