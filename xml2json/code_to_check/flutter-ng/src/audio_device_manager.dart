import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'audio_device_manager.g.dart';

/// The maximum length of the device ID.
///
@JsonEnum(alwaysCreate: true)
enum MaxDeviceIdLengthType {
  /// The maximum length of the device ID is 512 bytes.
  @JsonValue(512)
  maxDeviceIdLength,
}

/// @nodoc
extension MaxDeviceIdLengthTypeExt on MaxDeviceIdLengthType {
  /// @nodoc
  static MaxDeviceIdLengthType fromValue(int value) {
    return $enumDecode(_$MaxDeviceIdLengthTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MaxDeviceIdLengthTypeEnumMap[this]!;
  }
}

/// Audio device management methods.
///
abstract class AudioDeviceManager {
  /// Enumerates the audio playback devices.
  ///
  ///
  /// Returns
  /// A AudioDeviceInfo array, which includes all the audio playback devices, if the method call succeeds.
  ///  Failure: An empty array.
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices();

  /// Enumerates the audio capture devices.
  ///
  ///
  /// Returns
  /// A AudioDeviceInfo array, which includes all the audio capture devices, if the method call succeeds.
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices();

  /// Sets the audio playback device.
  ///
  ///
  /// * [deviceId] The ID of the specified audio playback device. You can get the device ID by calling enumeratePlaybackDevices . Plugging or unplugging the audio device does not change the value of deviceId.
  ///
  Future<void> setPlaybackDevice(String deviceId);

  /// Retrieves the current audio playback device.
  ///
  ///
  /// Returns
  /// The current audio playback device.
  Future<String> getPlaybackDevice();

  ///  Retrieves the audio playback device associated with the device ID.
  ///
  ///
  /// Returns
  /// A AudioDeviceInfo object, which contains the ID and device name of the audio devices.
  Future<AudioDeviceInfo> getPlaybackDeviceInfo();

  /// @nodoc
  Future<void> setPlaybackDeviceVolume(int volume);

  /// @nodoc
  Future<int> getPlaybackDeviceVolume();

  /// Sets the audio recording device.
  ///
  ///
  /// * [deviceId] The ID of the audio recording device. You can get the device ID by calling enumerateRecordingDevices . Plugging or unplugging the audio device does not change the value of deviceId.
  ///
  Future<void> setRecordingDevice(String deviceId);

  /// Gets the current audio recording device.
  ///
  ///
  /// Returns
  /// The current audio recording device.
  Future<String> getRecordingDevice();

  ///  Retrieves the volume of the audio recording device.
  ///
  ///
  /// Returns
  /// A AudioDeviceInfo object, which includes the device ID and device name.
  Future<AudioDeviceInfo> getRecordingDeviceInfo();

  /// @nodoc
  Future<void> setRecordingDeviceVolume(int volume);

  /// @nodoc
  Future<int> getRecordingDeviceVolume();

  /// @nodoc
  Future<void> setPlaybackDeviceMute(bool mute);

  /// @nodoc
  Future<bool> getPlaybackDeviceMute();

  /// @nodoc
  Future<void> setRecordingDeviceMute(bool mute);

  /// @nodoc
  Future<bool> getRecordingDeviceMute();

  /// Starts the audio playback device test.
  /// This method tests whether the audio playback device works properly. Once a user starts the test, the SDK plays an audio file specified by the user. If the user can hear the audio, the playback device works properly.
  ///  After calling this method, the SDK triggers the onAudioVolumeIndication callback every 100 ms, reporting uid = 1 and the volume information of the playback device.
  ///  Ensure that you call this method before joining a channel.
  ///
  /// * [testAudioFilePath] The path of the audio file. The data format is string in UTF-8.
  ///  Supported file formats: wav, mp3, m4a, and aac.
  ///  Supported file sample rates: 8000, 16000, 32000, 44100, and 48000 Hz.
  Future<void> startPlaybackDeviceTest(String testAudioFilePath);

  /// Stops the audio playback device test.
  /// This method stops the audio playback device test. You must call this method to stop the test after calling the startPlaybackDeviceTest method.
  ///  Ensure that you call this method before joining a channel.
  Future<void> stopPlaybackDeviceTest();

  /// Starts the audio recording device test.
  /// This method tests whether the audio capture device works properly. After calling this method, the SDK triggers the onAudioVolumeIndication callback at the time interval set in this method, which reports uid = 0 and the volume information of the capturing device.
  ///  Ensure that you call this method before joining a channel.
  ///
  /// * [indicationInterval] The time interval (ms) at which the SDK triggers the onAudioVolumeIndication callback. Agora recommends setting a value greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the onAudioVolumeIndication callback.
  Future<void> startRecordingDeviceTest(int indicationInterval);

  /// Stops the audio capture device test.
  /// This method stops the audio capture device test. You must call this method to stop the test after calling the startRecordingDeviceTest method.
  ///  Ensure that you call this method before joining a channel.
  Future<void> stopRecordingDeviceTest();

  /// Starts an audio device loopback test.
  /// This method tests whether the local audio capture device and playback device are working properly. Once the test starts, the audio recording device records the local audio, and the audio playback device plays the captured audio. The SDK triggers two independent onAudioVolumeIndication callbacks at the time interval set in this method, which reports the volume information of the capture device (uid = 0) and the volume information of the playback device (uid = 1) respectively. Ensure that you call this method before joining a channel.
  ///  This method tests local audio devices and does not report the network conditions.
  ///
  /// * [indicationInterval] The time interval (ms) at which the SDK triggers the onAudioVolumeIndication callback. Agora recommends setting a value greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the onAudioVolumeIndication callback.
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval);

  /// Stops the audio device loopback test.
  /// Ensure that you call this method before joining a channel.
  ///  Ensure that you call this method to stop the loopback test after calling the startAudioDeviceLoopbackTest method.
  Future<void> stopAudioDeviceLoopbackTest();

  /// @nodoc
  Future<void> followSystemPlaybackDevice(bool enable);

  /// @nodoc
  Future<void> followSystemRecordingDevice(bool enable);

  /// Releases all the resources occupied by the AudioDeviceManager object.
  ///
  Future<void> release();
}
