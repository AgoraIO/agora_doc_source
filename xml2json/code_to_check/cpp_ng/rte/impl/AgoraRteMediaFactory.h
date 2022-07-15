//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "IAgoraRteMediaFactory.h"

namespace agora {
namespace rte {

class IAgoraRteAudioTrack;
class IAgoraRteVideoTrack;

class AgoraRteMediaFactory final
    : public std::enable_shared_from_this<AgoraRteMediaFactory>,
      public IAgoraRteMediaFactory {
 public:
  explicit AgoraRteMediaFactory(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteMediaFactory() = default;

  std::shared_ptr<IAgoraRteCameraVideoTrack> CreateCameraVideoTrack() override;

  std::shared_ptr<IAgoraRteScreenVideoTrack> CreateScreenVideoTrack() override;

  std::shared_ptr<IAgoraRteMixedVideoTrack> CreateMixedVideoTrack() override;

  std::shared_ptr<IAgoraRteCustomVideoTrack> CreateCustomVideoTrack() override;

  std::shared_ptr<IAgoraRteMicrophoneAudioTrack> CreateMicrophoneAudioTrack()
      override;

  std::shared_ptr<IAgoraRteCustomAudioTrack> CreateCustomAudioTrack() override;

  std::shared_ptr<IAgoraRteMediaPlayer> CreateMediaPlayer() override;

  std::shared_ptr<IAgoraRteStreamingSource> CreateStreamingSource() override;

 private:
  std::shared_ptr<agora::base::IAgoraService> rtc_services_;
};
}  // namespace rte
}  // namespace agora
