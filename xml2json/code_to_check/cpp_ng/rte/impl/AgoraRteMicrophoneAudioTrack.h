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

class AgoraRteMicrophoneAudioTrack final : public IAgoraRteMicrophoneAudioTrack,
                                           public AgoraRteRtcAudioTrackBase {
 public:
  explicit AgoraRteMicrophoneAudioTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteMicrophoneAudioTrack() = default;

  int EnableLocalPlayback() override;

  SourceType GetSourceType() override;

  int AdjustPublishVolume(int volume) override;

  int AdjustPlayoutVolume(int volume) override;

  const std::string& GetAttachedStreamId() override;

  int StartRecording() override;

  void StopRecording() override;

  int EnableEarMonitor(bool enable, int include_audio_filter) override;

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
  std::shared_ptr<rtc::ILocalAudioTrack> audio_frame_sender_;
};
}  // namespace rte
}  // namespace agora
