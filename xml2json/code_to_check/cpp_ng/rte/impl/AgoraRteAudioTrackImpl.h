//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteTrackImplBase.h"
#include "IAgoraRteMediaObserver.h"

namespace agora {
namespace rte {

class AgoraRteAudioTrackImpl final
    : public std::enable_shared_from_this<AgoraRteAudioTrackImpl>,
      public AgoraRteTrackImplBase {
 public:
  explicit AgoraRteAudioTrackImpl(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  void SetTrack(const std::shared_ptr<rtc::ILocalAudioTrack>& track);

  int EnableLocalPlayback();

  int AdjustPublishVolume(int volume);

  int AdjustPlayoutVolume(int volume);

  int EnableEarMonitor(bool enable, int include_audio_filter);

  std::shared_ptr<rtc::ILocalAudioTrack> GetAudioTrack() const;

  int Start() override;

  void Stop() override;

 protected:
  std::shared_ptr<rtc::ILocalAudioTrack> audio_track_;
  rtc::AudioEncoderConfiguration config_;
};
}  // namespace rte
}  // namespace agora
