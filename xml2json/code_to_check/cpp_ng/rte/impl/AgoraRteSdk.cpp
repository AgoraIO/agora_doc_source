//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteSdk.h"

#include <memory>
#include <mutex>

#include "AgoraRteAudioDeviceManager.h"
#include "AgoraRteMediaFactory.h"
#include "AgoraRteScene.h"
#include "AgoraRteStreamFactory.h"
#include "AgoraRteUtils.h"
#include "AgoraRteVideoDeviceManager.h"
#include "IAgoraRteScene.h"

namespace agora {
namespace rte {

RTE_INLINE int AgoraRteSDK::Init(const SdkConfig& sdk_config) {
  std::lock_guard<std::mutex> lock(GetLock());

  return GetSdkInstance()->SetProfileInternal(sdk_config);
}

RTE_INLINE void AgoraRteSDK::Deinit() {
  std::lock_guard<std::mutex> lock(GetLock());

  return GetSdkInstance()->DeinitInternal();
}

RTE_INLINE std::shared_ptr<IAgoraRteScene> AgoraRteSDK::CreateRteScene(
    const std::string& scene_id, const SceneConfig& config) {
  std::lock_guard<std::mutex> lock(GetLock());

  auto factory = GetSdkInstance()->GetStreamFactory();
  if (GetSdkInstance()->IsCompatibleModeEnabled() !=
      (config.scene_type == SceneType::kCompatible)) {
    return nullptr;
  }

  return factory ? std::make_shared<AgoraRteScene>(factory, scene_id, config)
                 : nullptr;
}

RTE_INLINE void AgoraRteSDK::SetAgoraServiceCreator(
    AgoraServiceCreatorFunctionPtr func) {
  std::lock_guard<std::mutex> lock(GetLock());

  GetSdkInstance()->SetServiceCreator(func);
}

RTE_INLINE std::shared_ptr<IAgoraRteMediaFactory>
AgoraRteSDK::GetRteMediaFactory() {
  std::lock_guard<std::mutex> lock(GetLock());

  return GetSdkInstance()->GetRteMediaFactoryInternal();
}

RTE_INLINE int AgoraRteSDK::GetConfig(SdkConfig& sdk_config) {
  std::lock_guard<std::mutex> lock(GetLock());
  return GetSdkInstance()->GetProfileInternal(sdk_config);
}

#if RTE_WIN || RTE_LINUX
RTE_INLINE int AgoraRteSDK::LoadExtensionProvider(
    const std::string& extension_lib_path) {
  std::lock_guard<std::mutex> lock(GetLock());
  if (GetSdkInstance()->GetRtcServiceInternal()) {
    return GetSdkInstance()->GetRtcServiceInternal()->loadExtensionProvider(
        extension_lib_path.c_str());
  }
  return -ERR_FAILED;
}
#endif

RTE_INLINE int AgoraRteSDK::EnableExtensionOnRemoteStream(
    const std::string& provider_name, const std::string& extension_name) {
  if (GetSdkInstance()->GetRtcServiceInternal()) {
    return GetSdkInstance()->GetRtcServiceInternal()->enableExtension(
        provider_name.c_str(), extension_name.c_str(), nullptr, false);
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteSDK::DisableExtensionOnRemoteStream(
    const std::string& provider_name, const std::string& extension_name) {
  if (GetSdkInstance()->GetRtcServiceInternal()) {
    return GetSdkInstance()->GetRtcServiceInternal()->disableExtension(
        provider_name.c_str(), extension_name.c_str(), nullptr);
  }
  return -ERR_FAILED;
}

#if RTE_WIN || RTE_MAC
RTE_INLINE std::shared_ptr<IAgoraRteAudioDeviceManager>
AgoraRteSDK::GetAudioDeviceManager() {
  std::lock_guard<std::mutex> lock(GetLock());

  return GetSdkInstance()->GetRteAudioDeviceManager();
}

RTE_INLINE std::shared_ptr<IAgoraRteVideoDeviceManager>
AgoraRteSDK::GetVideoDeviceManager() {
  std::lock_guard<std::mutex> lock(GetLock());

  return GetSdkInstance()->GetRteVideoDeviceManager();
}

RTE_INLINE std::shared_ptr<IAgoraRteAudioDeviceManager>
AgoraRteSDK::GetRteAudioDeviceManager() {
  if (audio_device_mgr_) {
    return audio_device_mgr_;
  }

  auto rtc_service = GetRtcServiceInternal();
  audio_device_mgr_ =
      std::make_shared<AgoraRteAudioDeviceManager>(rtc_service.get(), nullptr);
  return audio_device_mgr_;
}

RTE_INLINE std::shared_ptr<IAgoraRteVideoDeviceManager>
AgoraRteSDK::GetRteVideoDeviceManager() {
  if (video_device_mgr_) {
    return video_device_mgr_;
  }

  auto rtc_service = GetRtcServiceInternal();
  video_device_mgr_ = std::make_shared<AgoraRteVideoDeviceManager>(rtc_service);
  return video_device_mgr_;
}

#endif

RTE_INLINE std::shared_ptr<AgoraRteSDK> AgoraRteSDK::GetSdkInstance() {
  static auto internal_sdk = std::shared_ptr<AgoraRteSDK>(new AgoraRteSDK());
  return internal_sdk;
}

RTE_INLINE std::mutex& AgoraRteSDK::GetLock() {
  static std::mutex lock;
  return lock;
}

RTE_INLINE std::shared_ptr<IAgoraRteMediaFactory>
AgoraRteSDK::GetRteMediaFactoryInternal() {
  RTE_LOGGER_MEMBER(nullptr);
  if (media_factory_) {
    return media_factory_;
  }

  auto rtc_service = GetRtcServiceInternal();
  media_factory_ = std::make_shared<AgoraRteMediaFactory>(rtc_service);
  return media_factory_;
}

RTE_INLINE void AgoraRteSDK::SetServiceCreator(
    AgoraServiceCreatorFunctionPtr func) {
  creator_ = func;
}

RTE_INLINE std::shared_ptr<AgoraRteStreamFactory>
AgoraRteSDK::GetStreamFactory() {
  RTE_LOGGER_MEMBER(nullptr);
  if (stream_factory_) {
    return stream_factory_;
  }

  auto rtc_service = GetRtcServiceInternal();
  if (!sdk_config_.appid.empty() && rtc_service_) {
    return stream_factory_ = std::make_shared<AgoraRteStreamFactory>(
               sdk_config_.appid, rtc_service);
  }

  return nullptr;
}

RTE_INLINE int AgoraRteSDK::SetProfileInternal(const SdkConfig& sdk_config) {
  if (sdk_config.appid.empty()) {
    return -ERR_INVALID_APP_ID;
  }
  sdk_config_ = sdk_config;
  return ERR_OK;
}

RTE_INLINE int AgoraRteSDK::GetProfileInternal(SdkConfig& sdk_config) {
  RTE_LOGGER_MEMBER(nullptr);
  sdk_config = sdk_config_;
  return ERR_OK;
}

RTE_INLINE std::shared_ptr<agora::base::IAgoraService>
AgoraRteSDK::GetRtcServiceInternal() {
  RTE_LOGGER_MEMBER(nullptr);
  if (rtc_service_) {
    return rtc_service_;
  }

  agora::base::IAgoraService* created_service =
      creator_ ? creator_() : createAgoraService();
  if (!created_service) {
    return nullptr;
  }

  rtc_service_ = std::shared_ptr<agora::base::IAgoraService>(
      static_cast<agora::base::IAgoraService*>(created_service),
      [](agora::base::IAgoraService* p) {
        if (p) {
          p->release();
        }
      });

  agora::base::AgoraServiceConfiguration svc_cfg_ex;
  svc_cfg_ex.appId = sdk_config_.appid.c_str();

#if RTE_ANDROID
  svc_cfg_ex.context = sdk_config_.app_context;
#else
  svc_cfg_ex.context = nullptr;
#endif

  svc_cfg_ex.logConfig.filePath = sdk_config_.log_config.file_path.c_str();
  svc_cfg_ex.logConfig.fileSizeInKB = sdk_config_.log_config.file_size_in_kb;
  svc_cfg_ex.logConfig.level = sdk_config_.log_config.level;
  svc_cfg_ex.useStringUid = !sdk_config_.enable_rtc_compatible_mode;
  svc_cfg_ex.enableVideo = true;
  svc_cfg_ex.enableAudioDevice = true;

  if (rtc_service_->initialize(svc_cfg_ex) != agora::ERR_OK) {
    rtc_service_ = nullptr;
  }

  return rtc_service_;
}

RTE_INLINE void AgoraRteSDK::DeinitInternal() {
  rtc_service_ = nullptr;
  media_factory_ = nullptr;
  stream_factory_ = nullptr;

#if RTE_WIN || RTE_MAC
  video_device_mgr_ = nullptr;
  audio_device_mgr_ = nullptr;
#endif
}

}  // namespace rte
}  // namespace agora
