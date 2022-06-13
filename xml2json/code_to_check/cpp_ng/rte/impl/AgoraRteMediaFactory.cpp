//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteMediaFactory.h"

#include "AgoraRteCameraVideoTrack.h"
#include "AgoraRteCustomAudioTrack.h"
#include "AgoraRteCustomVideoTrack.h"
#include "AgoraRteMediaPlayer.h"
#include "AgoraRteMicrophoneAudioTrack.h"
#include "AgoraRteMixedVideoTrack.h"
#include "AgoraRteScreenVideoTrack.h"
#include "AgoraRteStreamingSource.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteMediaFactory::AgoraRteMediaFactory(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : rtc_services_(rtc_service) {}

RTE_INLINE std::shared_ptr<IAgoraRteCameraVideoTrack>
AgoraRteMediaFactory::CreateCameraVideoTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteCameraVideoTrack>(rtc_services_);
  result->Init();
  return result;
}

RTE_INLINE std::shared_ptr<IAgoraRteScreenVideoTrack>
AgoraRteMediaFactory::CreateScreenVideoTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteScreenVideoTrack>(rtc_services_);
  result->Init();
  return result;
}

RTE_INLINE std::shared_ptr<IAgoraRteMixedVideoTrack>
AgoraRteMediaFactory::CreateMixedVideoTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteMixedVideoTrack>(rtc_services_);
  result->Init();
  return result;
}

RTE_INLINE std::shared_ptr<IAgoraRteCustomVideoTrack>
AgoraRteMediaFactory::CreateCustomVideoTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteCustomVideoTrack>(rtc_services_);
  result->Init();
  return result;
}

RTE_INLINE std::shared_ptr<IAgoraRteMicrophoneAudioTrack>
AgoraRteMediaFactory::CreateMicrophoneAudioTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteMicrophoneAudioTrack>(rtc_services_);
  result->Init();
  return result;
}

RTE_INLINE std::shared_ptr<IAgoraRteCustomAudioTrack>
AgoraRteMediaFactory::CreateCustomAudioTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteCustomAudioTrack>(rtc_services_);
  result->Init();
  return result;
}

RTE_INLINE std::shared_ptr<IAgoraRteMediaPlayer>
AgoraRteMediaFactory::CreateMediaPlayer() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteMediaPlayer>(rtc_services_);
  return result;
}

RTE_INLINE std::shared_ptr<IAgoraRteStreamingSource>
AgoraRteMediaFactory::CreateStreamingSource() {
  RTE_LOGGER_MEMBER(nullptr);
  auto result = std::make_shared<AgoraRteStreamingSource>(rtc_services_);
  return result;
}

}  // namespace rte
}  // namespace agora
