//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteVideoDeviceManager.h"

#include "AgoraRteUtils.h"

namespace agora {
namespace rte {

#if RTE_WIN || RTE_MAC

RTE_INLINE AgoraRteVideoDeviceManager::AgoraRteVideoDeviceManager(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service) {
  auto media_node_factory = rtc_service->createMediaNodeFactory();
  camera_capturer_ = media_node_factory->createCameraCapturer();
}

RTE_INLINE std::vector<VideoDeviceInfo>
AgoraRteVideoDeviceManager::EnumerateVideoDevices() {
  RTE_LOGGER_MEMBER(nullptr);
  std::vector<VideoDeviceInfo> result;
  std::unique_ptr<rtc::ICameraCapturer::IDeviceInfo> device_info(
      camera_capturer_->createDeviceInfo());
  if (device_info) {
    int number = device_info->NumberOfDevices();
    constexpr int max_string_len = 260;
    for (int i = 0; i < number; i++) {
      char device_name[max_string_len] = {0};
      char device_id[max_string_len] = {0};
      char product_id[max_string_len] = {0};
      if (device_info->GetDeviceName(i, device_name, max_string_len, device_id,
                                     max_string_len, product_id,
                                     max_string_len) == ERR_OK) {
        std::string device_name_str(device_name);
        std::string device_id_str(device_id);
        result.push_back(
            {std::move(device_name_str), std::move(device_id_str)});
      }
    }
  }

  return result;
}

#endif
}  // namespace rte
}  // namespace agora
