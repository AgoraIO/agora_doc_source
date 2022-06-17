import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'audio_device_manager.g.dart';

@JsonEnum(alwaysCreate: true)
enum MaxDeviceIdLengthType {
  @JsonValue(512)
  maxDeviceIdLength,
}

extension MaxDeviceIdLengthTypeExt on MaxDeviceIdLengthType {
  int value() {
    return _$MaxDeviceIdLengthTypeEnumMap[this]!;
  }
}

abstract class AudioDeviceManager {
  List<AudioDeviceInfo> enumeratePlaybackDevices();

  List<AudioDeviceInfo> enumerateRecordingDevices();

  void setPlaybackDevice(String deviceId);

  String getPlaybackDevice();

  AudioDeviceInfo getPlaybackDeviceInfo();

  void setPlaybackDeviceVolume(int volume);

  int getPlaybackDeviceVolume();

  void setRecordingDevice(String deviceId);

  String getRecordingDevice();

  AudioDeviceInfo getRecordingDeviceInfo();

  void setRecordingDeviceVolume(int volume);

  int getRecordingDeviceVolume();

  void setPlaybackDeviceMute(bool mute);

  bool getPlaybackDeviceMute();

  void setRecordingDeviceMute(bool mute);

  bool getRecordingDeviceMute();

  void startPlaybackDeviceTest(String testAudioFilePath);

  void stopPlaybackDeviceTest();

  void startRecordingDeviceTest(int indicationInterval);

  void stopRecordingDeviceTest();

  void startAudioDeviceLoopbackTest(int indicationInterval);

  void stopAudioDeviceLoopbackTest();

  void release();
}
