//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteAudioDeviceManager.h"

#include "AgoraRteUtils.h"
#include "IAudioDeviceManager.h"

namespace agora {
namespace rte {

#if RTE_WIN || RTE_MAC

RTE_INLINE AgoraRteAudioDeviceCollection::AgoraRteAudioDeviceCollection(
    rtc::IAudioDeviceCollection* collection)
    : collection_(collection) {
  if (!collection) {
    RTE_LOG_ERROR << "collection is null ";
    return;
  }
}

RTE_INLINE int AgoraRteAudioDeviceCollection::GetCount() {
  if (collection_) {
    return collection_->getCount();
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteAudioDeviceCollection::GetDevice(
    int index, char device_name[MAX_DEVICE_ID_LENGTH],
    char device_id[MAX_DEVICE_ID_LENGTH]) {
  RTE_LOGGER_MEMBER("index: %d, device_name: %s, device_id: %s", index,
                    device_name, device_id);
  if (collection_) {
    return collection_->getDevice(index, device_name, device_id);
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteAudioDeviceCollection::SetDevice(
    const char device_id[MAX_DEVICE_ID_LENGTH]) {
  RTE_LOGGER_MEMBER("device_id: %s", device_id);
  if (collection_) {
    return collection_->setDevice(device_id);
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteAudioDeviceCollection::SetApplicationVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  if (collection_) {
    return collection_->setApplicationVolume(volume);
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteAudioDeviceCollection::GetApplicationVolume(
    int& volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  if (collection_) {
    return collection_->getApplicationVolume(volume);
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteAudioDeviceCollection::MuteApplication(bool mute) {
  RTE_LOGGER_MEMBER("mute: %d", mute);
  if (collection_) {
    return collection_->setApplicationMute(mute);
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteAudioDeviceCollection::IsApplicationMuted(bool& mute) {
  RTE_LOGGER_MEMBER(nullptr);
  if (collection_) {
    return collection_->isApplicationMute(mute);
  }
  return -ERR_FAILED;
}

RTE_INLINE void AgoraRteAudioDeviceCollection::Release() {
  RTE_LOGGER_MEMBER(nullptr);
  if (collection_) {
    return collection_->release();
  }
}

RTE_INLINE AgoraRteAudioDeviceManager::AgoraRteAudioDeviceManager(
    base::IAgoraService* service, rtc::IAudioDeviceManagerObserver* observer) {
  if (!service) {
    RTE_LOG_ERROR << "service is null ";
    return;
  }
  audio_device_manager_ = service->createAudioDeviceManagerComponent(observer);
}

RTE_INLINE AgoraRteAudioDeviceManager::~AgoraRteAudioDeviceManager() {
  audio_device_manager_ = nullptr;
}

RTE_INLINE IAgoraRteAudioDeviceCollection*
AgoraRteAudioDeviceManager::EnumeratePlaybackDevices() {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_collection = audio_device_manager_->enumeratePlaybackDevices();
  if (!rtc_collection) {
    return nullptr;
  }
  auto rte_collection =
      std::make_unique<AgoraRteAudioDeviceCollection>(rtc_collection);
  return rte_collection.release();
}

RTE_INLINE IAgoraRteAudioDeviceCollection*
AgoraRteAudioDeviceManager::EnumerateRecordingDevices() {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_collection = audio_device_manager_->enumerateRecordingDevices();
  if (!rtc_collection) {
    return nullptr;
  }
  auto rte_collection =
      std::make_unique<AgoraRteAudioDeviceCollection>(rtc_collection);
  return rte_collection.release();
}

RTE_INLINE int AgoraRteAudioDeviceManager::SetPlaybackDevice(
    const char device_id[MAX_DEVICE_ID_LENGTH]) {
  RTE_LOGGER_MEMBER("device_id: %s", device_id);
  return audio_device_manager_->setPlaybackDevice(device_id);
}

RTE_INLINE int AgoraRteAudioDeviceManager::GetPlaybackDevice(
    char device_id[MAX_DEVICE_ID_LENGTH]) {
  RTE_LOGGER_MEMBER("device_id: %s", device_id);
  return audio_device_manager_->getPlaybackDevice(device_id);
}

RTE_INLINE int AgoraRteAudioDeviceManager::SetPlaybackDeviceVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return audio_device_manager_->setPlaybackDeviceVolume(volume);
}

RTE_INLINE int AgoraRteAudioDeviceManager::GetPlaybackDeviceVolume(
    int& volume) {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_device_manager_->getPlaybackDeviceVolume(&volume);
}

RTE_INLINE int AgoraRteAudioDeviceManager::SetRecordingDevice(
    const char device_id[MAX_DEVICE_ID_LENGTH]) {
  RTE_LOGGER_MEMBER("device_id: %s", device_id);
  return audio_device_manager_->setRecordingDevice(device_id);
}

RTE_INLINE int AgoraRteAudioDeviceManager::GetRecordingDevice(
    char device_id[MAX_DEVICE_ID_LENGTH]) {
  RTE_LOGGER_MEMBER("device_id: %s", device_id);
  return audio_device_manager_->getRecordingDevice(device_id);
}

RTE_INLINE int AgoraRteAudioDeviceManager::SetRecordingDeviceVolume(
    int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return audio_device_manager_->setRecordingDeviceVolume(volume);
}

RTE_INLINE int AgoraRteAudioDeviceManager::GetRecordingDeviceVolume(
    int& volume) {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_device_manager_->getRecordingDeviceVolume(&volume);
}

RTE_INLINE int AgoraRteAudioDeviceManager::MutePlaybackDevice(bool mute) {
  RTE_LOGGER_MEMBER("mute: %d", mute);
  return audio_device_manager_->setPlaybackDeviceMute(mute);
}

RTE_INLINE int AgoraRteAudioDeviceManager::IsPlaybackDeviceMuted(bool& muted) {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_device_manager_->getPlaybackDeviceMute(&muted);
}

RTE_INLINE int AgoraRteAudioDeviceManager::MuteRecordingDevice(bool mute) {
  RTE_LOGGER_MEMBER("mute: %d", mute);
  return audio_device_manager_->setRecordingDeviceMute(mute);
}

RTE_INLINE int AgoraRteAudioDeviceManager::IsRecordingDeviceMuted(bool& muted) {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_device_manager_->getRecordingDeviceMute(&muted);
}

RTE_INLINE int AgoraRteAudioDeviceManager::StartPlaybackDeviceTest(
    const char* test_audio_file_path) {
  RTE_LOGGER_MEMBER("test_audio_file_path: %s",
                    test_audio_file_path ? test_audio_file_path : nullptr);
  return audio_device_manager_->startPlaybackDeviceTest(test_audio_file_path);
}

RTE_INLINE int AgoraRteAudioDeviceManager::StopPlaybackDeviceTest() {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_device_manager_->stopPlaybackDeviceTest();
}

RTE_INLINE int AgoraRteAudioDeviceManager::StartRecordingDeviceTest(
    int indication_interval) {
  RTE_LOGGER_MEMBER("indication_interval: %d", indication_interval);
  return audio_device_manager_->startRecordingDeviceTest(indication_interval);
}

RTE_INLINE int AgoraRteAudioDeviceManager::StopRecordingDeviceTest() {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_device_manager_->stopRecordingDeviceTest();
}

RTE_INLINE int AgoraRteAudioDeviceManager::StartDeviceLoopbackTest(
    int indication_interval) {
  RTE_LOGGER_MEMBER("indication_interval: %d", indication_interval);
  return audio_device_manager_->startAudioDeviceLoopbackTest(
      indication_interval);
}

RTE_INLINE int AgoraRteAudioDeviceManager::StopDeviceLoopbackTest() {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_device_manager_->stopAudioDeviceLoopbackTest();
}

#endif

}  // namespace rte
}  // namespace agora
