//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteDeviceManager.h"
#include "IAgoraRteMediaFactory.h"
#include "IAgoraRteScene.h"

namespace agora {
namespace rte {

class AgoraRteStreamFactory;
using AgoraServiceCreatorFunctionPtr =
    agora::base::IAgoraService*(AGORA_CALL*)();

class AgoraRteSDK {
 public:
  /**
   * Initialize the rte sdk
   * @param sdk_config [in]  SDK config
   * 
   * @return Returns ERR_OK on success
   */
  static int Init(const SdkConfig& sdk_config);

  static void Deinit();

  /**
   *  Create a usage scenario
   *  Check \ref agora::rte::IAgoraRteScene for more details
   *  @param scene_id [in] The scene ID
   *  @param config [in] Scenario configuration parameters
   * 
   *  @return The created rte scene
   */
  static std::shared_ptr<IAgoraRteScene> CreateRteScene(
      const std::string& scene_id, const SceneConfig& config);

  static void SetAgoraServiceCreator(AgoraServiceCreatorFunctionPtr func);

  /**
   * Create a media factory 
   * Check \ref agora::rte::IAgoraRteMediaFactory for more details
   * 
   * @return The created rte media factory
   */
  static std::shared_ptr<IAgoraRteMediaFactory> GetRteMediaFactory();

  /**
   * Get the sdk config 
   * @param sdk_config [out] sdk config
   * 
   * @return Returns ERR_OK on success
   */
  static int GetConfig(SdkConfig& sdk_config);

#if RTE_WIN || RTE_LINUX
  /**
   * Load Extension Provider
   * @param  extension_lib_path [in] The extension library path
   * 
   * @return Returns ERR_OK on success
   */
  static int LoadExtensionProvider(const std::string& extension_lib_path);
#endif

  /**
   * Enable the extension on the remote stream 
   * @param provider_name [in] The provider name
   * @param extension_name [in] The extension name
   * 
   * @return Returns ERR_OK on success
   */
  static int EnableExtensionOnRemoteStream(const std::string& provider_name,
                                           const std::string& extension_name);

  /**
   * Disable the extension on the remote stream
   * @param provider_name [in] The provider name
   * @param extension_name [in] The extension name
   * 
   * @return Returns ERR_OK on success
   */
  static int DisableExtensionOnRemoteStream(const std::string& provider_name,
                                            const std::string& extension_name);

#if RTE_WIN || RTE_MAC
  /**
   * Get the audio device manager
   * Check \ref agora::rte::IAgoraRteAudioDeviceManager for more details
   * 
   * @return The created rte audio device manager 
   */
  static std::shared_ptr<IAgoraRteAudioDeviceManager> GetAudioDeviceManager();

  /**
   * Get the video device manager
   * Check \ref agora::rte::IAgoraRteVideoDeviceManager for more details
   * 
   * @return The created rte video device manager
   */
  static std::shared_ptr<IAgoraRteVideoDeviceManager> GetVideoDeviceManager();
#endif

 private:
  /**
   * Get a unique instance of the SDK
   * 
   * @return The created rte sdk 
   */
  static std::shared_ptr<AgoraRteSDK> GetSdkInstance();

  static std::mutex& GetLock();

 private:
  AgoraRteSDK() = default;

  int SetProfileInternal(const SdkConfig& sdk_config);
  int GetProfileInternal(SdkConfig& sdk_config);

#if RTE_WIN || RTE_MAC
  std::shared_ptr<IAgoraRteAudioDeviceManager> GetRteAudioDeviceManager();

  std::shared_ptr<IAgoraRteVideoDeviceManager> GetRteVideoDeviceManager();
#endif

  std::shared_ptr<IAgoraRteMediaFactory> GetRteMediaFactoryInternal();

  void SetServiceCreator(AgoraServiceCreatorFunctionPtr func);

  std::shared_ptr<agora::base::IAgoraService> GetRtcServiceInternal();

  std::shared_ptr<AgoraRteStreamFactory> GetStreamFactory();

  void DeinitInternal();

  bool IsCompatibleModeEnabled() const { return sdk_config_.enable_rtc_compatible_mode; }

 private:
  std::shared_ptr<agora::base::IAgoraService> rtc_service_ = nullptr;
  std::shared_ptr<IAgoraRteMediaFactory> media_factory_ = nullptr;

#if RTE_WIN || RTE_MAC
  std::shared_ptr<IAgoraRteVideoDeviceManager> video_device_mgr_ = nullptr;
  std::shared_ptr<IAgoraRteAudioDeviceManager> audio_device_mgr_ = nullptr;
#endif

  std::shared_ptr<AgoraRteStreamFactory> stream_factory_ = nullptr;

  SdkConfig sdk_config_;

  AgoraServiceCreatorFunctionPtr creator_ = nullptr;
};
}  // namespace rte
}  // namespace agora
