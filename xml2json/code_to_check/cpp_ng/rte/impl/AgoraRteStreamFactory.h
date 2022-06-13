//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteScene.h"

namespace agora {
namespace rte {

class AgoraRteLocalStream;
class AgoraRteScene;
class AgoraRteMajorStream;

class AgoraRteStreamFactory {
 public:
  AgoraRteStreamFactory(
      const std::string& appid,
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  std::shared_ptr<AgoraRteLocalStream> CreateLocalStream(
      std::shared_ptr<AgoraRteScene> scene, const StreamOption& option,
      const std::string& stream_id);

  std::shared_ptr<AgoraRteMajorStream> CreateMajorStream(
      std::shared_ptr<AgoraRteScene> scene, const std::string& token,
      const JoinOptions& options);

 protected:
  std::string appid_;
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;
};
}  // namespace rte
}  // namespace agora