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

#if RTE_WIN || RTE_MAC

/**
 * The maximum device ID length.
 */
enum MAX_DEVICE_ID_LENGTH_TYPE {
  /**
   * The maximum device ID length is 512.
   */
  MAX_DEVICE_ID_LENGTH = 512
};

/**
 * The IAgoraRteAudioDeviceCollection class.
 */
class IAgoraRteAudioDeviceCollection {
 public:
  virtual ~IAgoraRteAudioDeviceCollection() = default;

  /**
   * Gets the total number of the playback and recording devices.
   *
   * Call \ref IAgoraRteAudioDeviceManager::EnumeratePlaybackDevices
   * "EnumeratePlaybackDevices" first, and then call this method to return the
   * number of the audio playback devices.
   *
   * @return
   * - The number of the audio devices, if the method call succeeds.
   * - < 0, if the method call fails.
   */
  virtual int GetCount() = 0;

  /**
   * Gets the information of a specified audio device.
   * @param index An input parameter that specifies the audio device.
   * @param device_name An output parameter that indicates the device name.
   * @param device_id An output parameter that indicates the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetDevice(int index, char device_name[MAX_DEVICE_ID_LENGTH],
                        char device_id[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Specifies a device with the device ID.
   * @param device_id The device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetDevice(const char device_id[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Sets the volume of the app.
   *
   * @param volume The volume of the app. The value range is [0, 255].
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetApplicationVolume(int volume) = 0;

  /**
   * Gets the volume of the app.
   *
   * @param volume The volume of the app. The value range is [0, 255]
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetApplicationVolume(int& volume) = 0;

  /** Mute or unmute the application playback volume.
   *
   * @param mute Determines whether to mute current application:
   * - true: Mute the app.
   * - false: Unmute the app.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int MuteApplication(bool mute) = 0;

  /**
   * Gets the mute state of the app.
   *
   * @param mute A reference to the mute state of the app:
   * - true: The app is muted.
   * - false: The app is not muted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int IsApplicationMuted(bool& mute) = 0;

  /**
   * Releases all IAgoraRteAudioDeviceCollection resources.
   */
  virtual void Release() = 0;
};

/**
 * The IAgoraRteAudioDeviceManager class.
 */
class IAgoraRteAudioDeviceManager {
 public:
  virtual ~IAgoraRteAudioDeviceManager() = default;

  /**
   * Enumerates the audio playback devices.
   *
   * This method returns an IAgoraRteAudioDeviceCollection object that includes
   * all the audio playback devices in the system. With the
   * IAgoraRteAudioDeviceCollection object, the app can enumerate the audio
   * playback devices. The app must call the \ref
   * IAgoraRteAudioDeviceCollection::Release
   * "IAgoraRteAudioDeviceCollection::Release" method to release the returned
   * object after using it.
   *
   * @return
   * - A pointer to the IAgoraRteAudioDeviceCollection object that includes all
   * the audio playback devices in the system, if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual IAgoraRteAudioDeviceCollection* EnumeratePlaybackDevices() = 0;

  /**
   * Enumerates the audio recording devices.
   *
   * This method returns an IAgoraRteAudioDeviceCollection object that includes
   * all the audio recording devices in the system. With the
   * IAgoraRteAudioDeviceCollection object, the app can enumerate the audio
   * recording devices. The app needs to call the \ref
   * IAgoraRteAudioDeviceCollection::release
   * "IAgoraRteAudioDeviceCollection::release" method to release the returned
   * object after using it.
   *
   * @return
   * - A pointer to the IAgoraRteAudioDeviceCollection object that includes all
   * the audio recording devices in the system, if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual IAgoraRteAudioDeviceCollection* EnumerateRecordingDevices() = 0;

  /**
   * Specifies an audio playback device with the device ID.
   *
   * @param device_id ID of the audio playback device. It can be retrieved by the
   * \ref EnumeratePlaybackDevices "EnumeratePlaybackDevices" method. Plugging
   * or unplugging the audio device does not change the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetPlaybackDevice(const char device_id[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the ID of the audio playback device.
   * @param device_id An output parameter that specifies the ID of the audio
   * playback device.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetPlaybackDevice(char device_id[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Sets the volume of the audio playback device.
   * @param volume The volume of the audio playing device. The value range is
   * [0, 255].
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetPlaybackDeviceVolume(int volume) = 0;

  /**
   * Gets the volume of the audio playback device.
   * @param volume The volume of the audio playback device. The value range is
   * [0, 255].
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetPlaybackDeviceVolume(int& volume) = 0;

  /**
   * Specifies an audio recording device with the device ID.
   *
   * @param device_id ID of the audio recording device. It can be retrieved by
   * the \ref EnumerateRecordingDevices "EnumerateRecordingDevices" method.
   * Plugging or unplugging the audio device does not change the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetRecordingDevice(const char device_id[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the audio recording device by the device ID.
   *
   * @param device_id ID of the audio recording device.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetRecordingDevice(char device_id[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Sets the volume of the recording device.
   * @param volume The volume of the recording device. The value range is [0,
   * 255].
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetRecordingDeviceVolume(int volume) = 0;

  /**
   * Gets the volume of the recording device.
   * @param volume The volume of the microphone, ranging from 0 to 255.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetRecordingDeviceVolume(int& volume) = 0;

  /**
   * Mutes or unmutes the audio playback device.
   *
   * @param mute Determines whether to mute the audio playback device.
   * - true: Mute the device.
   * - false: Unmute the device.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int MutePlaybackDevice(bool mute) = 0;

  /**
   * Gets the mute state of the playback device.
   *
   * @param mute A pointer to the mute state of the playback device.
   * - true: The playback device is muted.
   * - false: The playback device is unmuted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int IsPlaybackDeviceMuted(bool& muted) = 0;

  /**
   * Mutes or unmutes the audio recording device.
   *
   * @param mute Determines whether to mute the recording device.
   * - true: Mute the microphone.
   * - false: Unmute the microphone.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int MuteRecordingDevice(bool mute) = 0;

  /**
   * Gets the mute state of the audio recording device.
   *
   * @param muted A pointer to the mute state of the recording device.
   * - true: The microphone is muted.
   * - false: The microphone is unmuted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int IsRecordingDeviceMuted(bool& muted) = 0;

  /**
   * Starts the audio playback device test.
   *
   * This method tests if the playback device works properly. In the test, the
   * SDK plays an audio file specified by the user. If the user hears the audio,
   * the playback device works properly.
   *
   * @param test_audio_file_path The file path of the audio file for the test,
   * which is an absolute path in UTF8:
   * - Supported file format: wav, mp3, m4a, and aac.
   * - Supported file sampling rate: 8000, 16000, 32000, 44100, and 48000.
   *
   * @return
   * - 0, if the method call succeeds and you can hear the sound of the
   * specified audio file.
   * - An error code, if the method call fails.
   */
  virtual int StartPlaybackDeviceTest(const char* test_audio_file_path) = 0;

  /**
   * Stops the audio playback device test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StopPlaybackDeviceTest() = 0;

  /**
   * Starts the recording device test.
   *
   * This method tests whether the recording device works properly. Once the
   * test starts, the SDK uses the \ref
   * IAudioDeviceManagerObserver::onAudioVolumeIndication
   * "onAudioVolumeIndication" callback to notify the app on the volume
   * information.
   *
   * @param indication_interval The time interval (ms) between which the SDK
   * triggers the `onAudioVolumeIndication` callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StartRecordingDeviceTest(int indication_interval) = 0;

  /**
   * Stops the recording device test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StopRecordingDeviceTest() = 0;

  /**
   * Starts the audio device loopback test.
   *
   * This method tests whether the local audio devices are working properly.
   * After calling this method, the microphone captures the local audio and
   * plays it through the speaker, and the \ref
   * IAudioDeviceManagerObserver::onAudioVolumeIndication
   * "onAudioVolumeIndication" callback returns the local audio volume
   * information at the set interval.
   *
   * @note This method tests the local audio devices and does not report the
   * network conditions.
   * @param indication_interval The time interval (ms) at which the \ref
   * IAudioDeviceManagerObserver::onAudioVolumeIndication
   * "onAudioVolumeIndication" callback returns.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StartDeviceLoopbackTest(int indication_interval) = 0;

  /**
   * Stops the audio device loopback test.
   *
   * @note Ensure that you call this method to stop the loopback test after
   * calling the \ref IAgoraRteAudioDeviceManager::StartAudioDeviceLoopbackTest
   * "StartAudioDeviceLoopbackTest" method.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StopDeviceLoopbackTest() = 0;
};

class IAgoraRteVideoDeviceManager {
 public:
  virtual std::vector<VideoDeviceInfo> EnumerateVideoDevices() = 0;
};
#endif
}  // namespace rte
}  // namespace agora
