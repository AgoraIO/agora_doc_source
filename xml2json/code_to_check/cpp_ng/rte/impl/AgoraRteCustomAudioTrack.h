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

class AgoraRteCustomAudioTrack final : public IAgoraRteCustomAudioTrack,
                                       public AgoraRteRtcAudioTrackBase {
 public:
  explicit AgoraRteCustomAudioTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteCustomAudioTrack() = default;

  int EnableLocalPlayback() override;

  SourceType GetSourceType() override;

  int AdjustPublishVolume(int volume) override;

  int AdjustPlayoutVolume(int volume) override;

  const std::string& GetAttachedStreamId() override;

  int PushAudioFrame(AudioFrame& frame) override;

  void SetStreamId(const std::string& stream_id) override;

  std::shared_ptr<agora::rtc::ILocalAudioTrack> GetRtcAudioTrack()
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
  agora_refptr<rtc::IAudioPcmDataSender> audio_frame_sender_;
};
}  // namespace rte
}  // namespace agora
