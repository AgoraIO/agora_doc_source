//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteDeviceManager.h"

namespace agora {
namespace rte {
#if RTE_WIN || RTE_MAC
class AgoraRteVideoDeviceManager : public IAgoraRteVideoDeviceManager {
 public:
  explicit AgoraRteVideoDeviceManager(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  std::vector<VideoDeviceInfo> EnumerateVideoDevices() override;

 private:
  agora::agora_refptr<rtc::ICameraCapturer> camera_capturer_;
};

#endif
}  // namespace rte
}  // namespace agora
