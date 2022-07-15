//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteDeviceManager.h"
#include "IAudioDeviceManager.h"

namespace agora {
namespace rte {

// The implementation is only for WIN and MAC
//
#if RTE_WIN || RTE_MAC

class AgoraRteAudioDeviceCollection : public IAgoraRteAudioDeviceCollection {
 public:
  explicit AgoraRteAudioDeviceCollection(
      rtc::IAudioDeviceCollection* collection);
  int GetCount() override;
  int GetDevice(int index, char device_name[MAX_DEVICE_ID_LENGTH],
                char device_id[MAX_DEVICE_ID_LENGTH]) override;
  int SetDevice(const char device_id[MAX_DEVICE_ID_LENGTH]) override;
  int SetApplicationVolume(int volume) override;
  int GetApplicationVolume(int& volume) override;
  int MuteApplication(bool mute) override;
  int IsApplicationMuted(bool& mute) override;
  void Release() override;

 private:
  rtc::IAudioDeviceCollection* collection_;
};

class AgoraRteAudioDeviceManager final : public IAgoraRteAudioDeviceManager {
 public:
  explicit AgoraRteAudioDeviceManager(
      base::IAgoraService* service, rtc::IAudioDeviceManagerObserver* observer);
  virtual ~AgoraRteAudioDeviceManager();

  IAgoraRteAudioDeviceCollection* EnumeratePlaybackDevices() override;
  IAgoraRteAudioDeviceCollection* EnumerateRecordingDevices() override;

  int SetPlaybackDevice(const char device_id[MAX_DEVICE_ID_LENGTH]) override;
  int GetPlaybackDevice(char device_id[MAX_DEVICE_ID_LENGTH]) override;

  int SetPlaybackDeviceVolume(int volume) override;
  int GetPlaybackDeviceVolume(int& volume) override;

  int SetRecordingDevice(const char device_id[MAX_DEVICE_ID_LENGTH]) override;
  int GetRecordingDevice(char device_id[MAX_DEVICE_ID_LENGTH]) override;

  int SetRecordingDeviceVolume(int volume) override;
  int GetRecordingDeviceVolume(int& volume) override;

  int MutePlaybackDevice(bool mute) override;
  int IsPlaybackDeviceMuted(bool& muted) override;

  int MuteRecordingDevice(bool mute) override;
  int IsRecordingDeviceMuted(bool& muted) override;

  int StartPlaybackDeviceTest(const char* test_audio_file_path) override;
  int StopPlaybackDeviceTest() override;

  int StartRecordingDeviceTest(int indication_interval) override;
  int StopRecordingDeviceTest() override;

  int StartDeviceLoopbackTest(int indication_interval) override;
  int StopDeviceLoopbackTest() override;

 private:
  agora_refptr<rtc::IAudioDeviceManager> audio_device_manager_;
  IAgoraRteSceneEventHandler* event_handler_ = nullptr;
};

#endif
}  // namespace rte
}  // namespace agora
