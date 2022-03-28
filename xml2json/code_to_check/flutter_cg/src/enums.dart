import 'package:json_annotation/json_annotation.dart';

// ignore_for_file: constant_identifier_names

///
/// The region for connection, which is the region where
/// the server the SDK connects to is located.
///
///
enum AreaCode {
  ///
  /// Mainland China.
  ///
  @JsonValue(0x00000001)
  CN,

  ///
  /// North America.
  ///
  @JsonValue(0x00000002)
  NA,

  ///
  /// Europe.
  ///
  @JsonValue(0x00000004)
  EU,

  ///
  /// Asia, excluding Mainland China.
  ///
  @JsonValue(0x00000008)
  AS,

  ///
  /// Japan.
  ///
  @JsonValue(0x00000010)
  JP,

  ///
  /// India.
  ///
  @JsonValue(0x00000020)
  IN,

  ///
  /// (Default) Global.
  ///
  @JsonValue(0xffffffff)
  GLOB,
}

///
/// The codec type of the output audio stream for CDN live
/// streaming. The default value is LC-ACC.
///
///
///
/// 2: HE-AAC v2.
///
enum AudioCodecProfileType {
  @JsonValue(0)
  LCAAC,

  @JsonValue(1)
  HEAAC,
}

///
/// The midrange frequency for audio equalization.
///
///
enum AudioEqualizationBandFrequency {
  ///
  /// 0: 31 Hz
  ///
  @JsonValue(0)
  Band31,

  ///
  /// 1: 62 Hz
  ///
  @JsonValue(1)
  Band62,

  ///
  /// 2: 125 Hz
  ///
  @JsonValue(2)
  Band125,

  ///
  /// 3: 250 Hz
  ///
  @JsonValue(3)
  Band250,

  ///
  /// 4: 500 Hz
  ///
  @JsonValue(4)
  Band500,

  ///
  /// 5: 1 kHz
  ///
  @JsonValue(5)
  Band1K,

  ///
  /// 6: 2 kHz
  ///
  @JsonValue(6)
  Band2K,

  ///
  /// 7: 4 kHz
  ///
  @JsonValue(7)
  Band4K,

  ///
  /// 8: 8 kHz
  ///
  @JsonValue(8)
  Band8K,

  ///
  /// 9: 16 kHz
  ///
  @JsonValue(9)
  Band16K,
}

///
/// Local audio state error codes.
///
///
///
/// 8: The local audio capture is interrupted by a system call. If the local audio capture is required, remind your user to hang up the phone.
///
enum AudioLocalError {
  @JsonValue(0)
  Ok,

  @JsonValue(1)
  Failure,

  @JsonValue(2)
  DeviceNoPermission,

  @JsonValue(3)
  DeviceBusy,

  @JsonValue(4)
  RecordFailure,

  @JsonValue(5)
  EncodeFailure,

  @JsonValue(8)
  Interrupted,
}

///
/// Local audio states.
///
///
enum AudioLocalState {
  ///
  /// 0: The local audio is in the initial state.
  ///
  @JsonValue(0)
  Stopped,

  ///
  /// 1: The capturing device starts successfully.
  ///
  @JsonValue(1)
  Recording,

  ///
  /// 2: The first audio frame encodes successfully.
  ///
  @JsonValue(2)
  Encoding,

  ///
  /// 3: The local audio fails to start.
  ///
  @JsonValue(3)
  Failed,
}

///
/// The information acquisition state. This enum is reported in requestAudioFileInfoCallback.
///
///
enum AudioFileInfoError {
  ///
  /// 0: Successfully get the information of an audio file.
  ///
  @JsonValue(0)
  Ok,

  ///
  /// 1: Fail to get the information of an audio file.
  ///
  @JsonValue(1)
  Failure,
}

///
/// Errors that might occur when playing a music
/// file.
///
///
@Deprecated('This enum is deprecated, pls use AudioMixingReason instead.')
enum AudioMixingErrorType {
  ///
  /// The SDK cannot open the music file.
  ///
  @JsonValue(701)
  CanNotOpen,

  ///
  /// The SDK opens the music file too frequently.
  ///
  @JsonValue(702)
  TooFrequentCall,

  ///
  /// The playback of the music file is interrupted.
  ///
  @JsonValue(702)
  InterruptedEOF,

  ///
  /// The music file is playing.
  ///
  @JsonValue(0)
  OK,
}

///
/// The reason why the playback state of the music file changes. Reported in the audioMixingStateChanged callback.
///
///
enum AudioMixingReason {
  ///
  /// 701: The SDK cannot open the music file. For example, the local music file
  /// does not exist, the SDK does not support the file format, or  the SDK cannot
  /// access the music file URL.
  ///
  @JsonValue(701)
  CanNotOpen,

  ///
  /// 702: The SDK opens the music file too frequently. If you need to call startAudioMixing multiple times, ensure that the call interval is more than 500 ms.
  ///
  @JsonValue(702)
  TooFrequentCall,

  ///
  /// 703: The music file playback is interrupted.
  ///
  @JsonValue(703)
  InterruptedEOF,

  ///
  /// 720: The method call of startAudioMixing to play music
  /// files succeeds.
  ///
  @JsonValue(720)
  StartedByUser,

  ///
  /// 721: The music file completes a loop playback.
  ///
  @JsonValue(721)
  OneLoopCompleted,

  ///
  /// 722: The music file starts a new loop playback.
  ///
  @JsonValue(722)
  StartNewLoop,

  ///
  /// 723: The music file completes all loop playbacks.
  ///
  @JsonValue(723)
  AllLoopsCompleted,

  ///
  /// 724: The method call of stopAudioMixing to stop playing the
  /// music file succeeds.
  ///
  @JsonValue(724)
  StoppedByUser,

  ///
  /// 725: The method call of pauseAudioMixing to pause playing
  /// the music file succeeds.
  ///
  @JsonValue(725)
  PausedByUser,

  ///
  /// 726: The method call of resumeAudioMixing to resume playing
  /// the music file succeeds.
  ///
  @JsonValue(726)
  ResumedByUser,

  @JsonValue(0)
  OK,
}

///
/// The playback state of the music file.
///
///
enum AudioMixingStateCode {
  ///
  /// 710: The music file is playing.
  ///
  ///
  @JsonValue(710)
  Playing,

  ///
  /// 711: The music file pauses playing.
  ///
  ///
  @JsonValue(711)
  Paused,

  @JsonValue(712)
  Restart,

  ///
  /// 713: The music file stops playing.
  ///
  ///
  @JsonValue(713)
  Stopped,

  ///
  /// 714: An error occurs during the playback of the audio mixing file.
  ///
  ///
  @JsonValue(714)
  Failed,
}

///
/// The channel mode. Set in setAudioMixingDualMonoMode.
///
///
enum AudioMixingDualMonoMode {
  ///
  /// 0: Original mode.
  ///
  @JsonValue(0)
  Auto,

  ///
  /// 1: Left channel mode. This mode replaces the audio of the right channel with the audio of the left channel, which means the user can only hear the audio of the left channel.
  ///
  @JsonValue(1)
  L,

  ///
  /// 2: Right channel mode. This mode replaces the audio of the left channel with the audio of the right channel, which means the user can only hear the audio of the right channel.
  ///
  @JsonValue(2)
  R,

  ///
  /// 3: Mixed channel mode. This mode mixes the audio of the left channel and the right channel, which means the user can hear the audio of the left channel and the right channel at the same time.
  ///
  @JsonValue(3)
  MIX,
}

///
/// The type of the audio route.
///
///
enum AudioOutputRouting {
  ///
  /// -1: The default audio route.
  ///
  @JsonValue(-1)
  Default,

  ///
  /// 0: The headset.
  ///
  @JsonValue(0)
  Headset,

  ///
  /// 1: The earpiece.
  ///
  @JsonValue(1)
  Earpiece,

  ///
  /// 2: The headset with no microphone.
  ///
  @JsonValue(2)
  HeadsetNoMic,

  ///
  /// 3: The built-in speaker on a mobile device.
  ///
  @JsonValue(3)
  Speakerphone,

  ///
  /// 4: The external speaker.
  ///
  @JsonValue(4)
  Loudspeaker,

  ///
  /// 5: The bluetooth headset.
  ///
  @JsonValue(5)
  HeadsetBluetooth,

  @JsonValue(6)
  USB,

  @JsonValue(7)
  HDMI,

  @JsonValue(8)
  DisplayPort,

  @JsonValue(9)
  AirPlay,
}

///
/// The audio profile.
///
///
enum AudioProfile {
  ///
  /// 0: The default audio profile.
  /// For the interactive streaming profile: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  /// For the communication profile:
  ///
  ///
  ///
  ///
  @JsonValue(0)
  Default,

  ///
  /// 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
  ///
  @JsonValue(1)
  SpeechStandard,

  ///
  /// 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  ///
  @JsonValue(2)
  MusicStandard,

  ///
  /// 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps.
  ///
  @JsonValue(3)
  MusicStandardStereo,

  ///
  /// 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
  ///
  @JsonValue(4)
  MusicHighQuality,

  ///
  /// 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
  ///
  @JsonValue(5)
  MusicHighQualityStereo,
}

///
/// Recording quality.
///
///
///
/// 3: Ultra high quality. For example, the size of an AAC file with a sample rate of 32,000 Hz and a 10-minute recording is approximately 7.5 MB.
///
enum AudioRecordingQuality {
  @JsonValue(0)
  Low,

  @JsonValue(1)
  Medium,

  @JsonValue(2)
  High,
}

///
/// Recording content. Set in startAudioRecordingWithConfig.
///
///
enum AudioRecordingPosition {
  ///
  /// 0: (Default) Records the mixed audio of the local and all remote users.
  ///
  @JsonValue(0)
  PositionMixedRecordingAndPlayback,

  ///
  /// 1: Only records the audio of the local user.
  ///
  @JsonValue(1)
  PositionRecording,

  ///
  /// 2: Only records the audio of all remote users.
  ///
  @JsonValue(2)
  PositionMixedPlayback,
}

///
/// Remote audio states.
///
///
enum AudioRemoteState {
  ///
  /// 0: The local audio is in the initial state. The SDK reports this state in the case of LocalMuted, RemoteMuted or RemoteOffline.
  ///
  @JsonValue(0)
  Stopped,

  ///
  /// 1: The first remote audio packet is received.
  ///
  @JsonValue(1)
  Starting,

  ///
  /// 2: The remote audio stream is decoded and plays normally. The SDK reports this state in the case of NetworkRecovery, LocalUnmuted or RemoteUnmuted.
  ///
  @JsonValue(2)
  Decoding,

  ///
  /// 3: The remote audio is frozen. The SDK reports this state in the case of NetworkCongestion.
  ///
  @JsonValue(3)
  Frozen,

  ///
  /// 4: The remote audio fails to start. The SDK reports this state in the case of Internal.
  ///
  @JsonValue(4)
  Failed,
}

///
/// The reason for the remote audio state change.
///
///
enum AudioRemoteStateReason {
  ///
  /// 0: The SDK reports this reason when the audio state changes.
  ///
  @JsonValue(0)
  Internal,

  ///
  /// 1: Network congestion.
  ///
  @JsonValue(1)
  NetworkCongestion,

  ///
  /// 2: Network recovery.
  ///
  @JsonValue(2)
  NetworkRecovery,

  ///
  /// 3: The local user stops receiving the remote audio stream or disables the audio module.
  ///
  @JsonValue(3)
  LocalMuted,

  ///
  /// 4: The local user resumes receiving the remote audio stream or enables the audio module.
  ///
  @JsonValue(4)
  LocalUnmuted,

  ///
  /// 5: The remote user stops sending the audio stream or disables the audio module.
  ///
  @JsonValue(5)
  RemoteMuted,

  ///
  /// 6: The remote user resumes sending the audio stream or enables the audio module.
  ///
  @JsonValue(6)
  RemoteUnmuted,

  ///
  /// 7: The remote user leaves the channel.
  ///
  @JsonValue(7)
  RemoteOffline,
}

///
/// Voice reverb presets.
///
///
enum AudioReverbPreset {
  ///
  /// Turn off voice reverb, that is, to use the original voice.
  ///
  @JsonValue(0x00000000)
  Off,

  @JsonValue(0x00000001)
  Popular,

  @JsonValue(0x00000002)
  RnB,

  @JsonValue(0x00000003)
  Rock,

  @JsonValue(0x00000004)
  HipHop,

  @JsonValue(0x00000005)
  VocalConcert,

  @JsonValue(0x00000006)
  KTV,

  @JsonValue(0x00000007)
  Studio,

  ///
  /// The reverb style typical of a KTV venue (enhanced).
  ///
  @JsonValue(0x00100001)
  FX_KTV,

  ///
  /// The reverb style typical of a concert hall (enhanced).
  ///
  @JsonValue(0x00100002)
  FX_VOCAL_CONCERT,

  ///
  /// A middle-aged man's voice.
  ///
  @JsonValue(0x00100003)
  FX_UNCLE,

  ///
  /// The reverb style typical of a young woman's voice.
  ///
  @JsonValue(0x00100004)
  FX_SISTER,

  ///
  /// The reverb style typical of a recording studio (enhanced).
  ///
  @JsonValue(0x00100005)
  FX_STUDIO,

  ///
  /// The reverb style typical of popular music (enhanced).
  ///
  @JsonValue(0x00100006)
  FX_POPULAR,

  ///
  /// The reverb style typical of R&B music (enhanced).
  ///
  @JsonValue(0x00100007)
  FX_RNB,

  ///
  /// The voice effect typical of a vintage phonograph.
  ///
  @JsonValue(0x00100008)
  FX_PHONOGRAPH,

  ///
  /// The reverberation of the virtual stereo. The virtual stereo is an effect that renders the monophonic audio as the stereo audio, so that all users in the channel can hear the stereo voice effect.
  ///
  @JsonValue(0x00200001)
  VIRTUAL_STEREO,

  @JsonValue(0x00300001)
  AUDIO_ELECTRONIC_VOICE,

  @JsonValue(0x00400001)
  AUDIO_THREEDIM_VOICE,
}

///
/// Audio reverberation types.
///
///
enum AudioReverbType {
  ///
  /// 0: The level of the dry signal (dB). The value is between -20 and 10.
  ///
  @JsonValue(0)
  DryLevel,

  ///
  /// 1: The level of the early reflection signal (wet signal) (dB). The value is between -20 and 10.
  ///
  @JsonValue(1)
  WetLevel,

  ///
  /// 2: The room size of the reflection. The value is between 0 and 100.
  ///
  @JsonValue(2)
  RoomSize,

  ///
  /// 3: The length of the initial delay of the wet signal (ms). The value is between 0 and 200.
  ///
  @JsonValue(3)
  WetDelay,

  ///
  /// 4: The reverberation strength. The value is between 0 and 100.
  ///
  @JsonValue(4)
  Strength,
}

///
/// The audio sampling rate of the stream to be pushed to the CDN.
///
///
enum AudioSampleRateType {
  ///
  /// 32000: 32 kHz
  ///
  @JsonValue(32000)
  Type32000,

  ///
  /// 44100: 44.1 kHz
  ///
  @JsonValue(44100)
  Type44100,

  ///
  /// 48000: (Default) 48 kHz
  ///
  @JsonValue(48000)
  Type48000,
}

///
/// Audio application scenarios.
///
///
enum AudioScenario {
  ///
  /// 0: The default audio scenario.
  ///
  @JsonValue(0)
  Default,

  ///
  /// 1: Entertainment scenario where users need to frequently switch the user role.
  ///
  @JsonValue(1)
  ChatRoomEntertainment,

  ///
  /// 2: Education scenario where users want smoothness and stability.
  ///
  @JsonValue(2)
  Education,

  ///
  /// 3: High-quality audio chatroom scenario where hosts mainly play music.
  ///
  @JsonValue(3)
  GameStreaming,

  ///
  /// 4: Showroom scenario where a single host wants high-quality audio.
  ///
  @JsonValue(4)
  ShowRoom,

  ///
  /// 5: Gaming scenario for group chat that only contains the human voice.
  ///
  @JsonValue(5)
  ChatRoomGaming,

  ///
  /// 6: IoT (Internet of Things) scenario where users use IoT devices with low power consumption.
  ///
  @JsonValue(6)
  IOT,

  ///
  /// 8: Meeting scenario that mainly contains the human voice.
  ///
  ///
  @JsonValue(8)
  MEETING,
}

///
/// Local voice changer options.
///
///
enum AudioVoiceChanger {
  ///
  /// The original voice (no local voice change).
  ///
  @JsonValue(0x00000000)
  Off,

  ///
  /// The voice of an old man.
  ///
  @JsonValue(0x00000001)
  OldMan,

  ///
  /// The voice of a little boy.
  ///
  @JsonValue(0x00000002)
  BabyBoy,

  ///
  /// The voice of a little girl.
  ///
  @JsonValue(0x00000003)
  BabyGirl,

  ///
  /// The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a growling bear.
  ///
  @JsonValue(0x00000004)
  ZhuBaJie,

  ///
  /// The ethereal voice.
  ///
  @JsonValue(0x00000005)
  Ethereal,

  ///
  /// The voice of Hulk.
  ///
  @JsonValue(0x00000006)
  Hulk,

  ///
  /// A more vigorous voice.
  ///
  @JsonValue(0x00100001)
  BEAUTY_VIGOROUS,

  ///
  /// A deeper voice.
  ///
  @JsonValue(0x00100002)
  BEAUTY_DEEP,

  ///
  /// A mellower voice.
  ///
  @JsonValue(0x00100003)
  BEAUTY_MELLOW,

  ///
  /// Falsetto.
  ///
  @JsonValue(0x00100004)
  BEAUTY_FALSETTO,

  ///
  /// A fuller voice.
  ///
  @JsonValue(0x00100005)
  BEAUTY_FULL,

  ///
  /// A clearer voice.
  ///
  @JsonValue(0x00100006)
  BEAUTY_CLEAR,

  ///
  /// A more resounding voice.
  ///
  @JsonValue(0x00100007)
  BEAUTY_RESOUNDING,

  ///
  /// A more ringing voice.
  ///
  @JsonValue(0x00100008)
  BEAUTY_RINGING,

  ///
  /// A more spatially resonant voice.
  ///
  @JsonValue(0x00100009)
  BEAUTY_SPACIAL,

  ///
  /// (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice distortion occurs.
  ///
  @JsonValue(0x00200001)
  GENERAL_BEAUTY_VOICE_MALE_MAGNETIC,

  ///
  /// (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
  ///
  @JsonValue(0x00200002)
  GENERAL_BEAUTY_VOICE_FEMALE_FRESH,

  ///
  /// (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
  ///
  @JsonValue(0x00200003)
  GENERAL_BEAUTY_VOICE_FEMALE_VITALITY,
}

///
/// Camera capture preference.
///
///
enum CameraCaptureOutputPreference {
  ///
  /// 0: (Default) Automatically adjust the camera capture preference. The SDK adjusts the camera output parameters according to the system performance and network conditions to balance CPU consumption and video preview quality.
  ///
  @JsonValue(0)
  Auto,

  ///
  /// 1: Prioritizes the system performance. The SDK chooses the dimension and frame rate of the local camera capture closest to those set by setVideoEncoderConfiguration. In this case, the local preview quality depends on the encoder.
  ///
  @JsonValue(1)
  Performance,

  ///
  /// 2: Prioritizes the local preview quality. The SDK chooses higher camera output parameters to improve the local video preview quality. This option requires extra CPU and RAM usage for video pre-processing.
  ///
  @JsonValue(2)
  Preview,

  ///
  /// 3: Allows you to customize the width and height of the video image captured by the local camera.
  ///
  ///
  @JsonValue(3)
  Manual,
}

///
/// The camera direction.
///
///
enum CameraDirection {
  ///
  /// The rear camera.
  ///
  @JsonValue(0)
  Rear,

  ///
  /// The front camera.
  ///
  @JsonValue(1)
  Front,
}

///
/// The error code of the channel media replay.
///
///
enum ChannelMediaRelayError {
  ///
  /// 0: No error.
  ///
  @JsonValue(0)
  None,

  ///
  /// 1: An error occurs in the server response.
  ///
  @JsonValue(1)
  ServerErrorResponse,

  ///
  /// 2: No server response.
  /// You can call leaveChannel to leave the channel.
  /// This error can also occur if your project has not enabled co-host token authentication. Contact support@agora.io to enable the co-host token authentication service before starting a channel media relay.
  ///
  ///
  @JsonValue(2)
  ServerNoResponse,

  ///
  /// 3: The SDK fails to access the service, probably due to limited resources of the server.
  ///
  @JsonValue(3)
  NoResourceAvailable,

  ///
  /// 4: Fails to send the relay request.
  ///
  @JsonValue(4)
  FailedJoinSourceChannel,

  ///
  /// 5: Fails to accept the relay request.
  ///
  @JsonValue(5)
  FailedJoinDestinationChannel,

  ///
  /// 6: The server fails to receive the media stream.
  ///
  @JsonValue(6)
  FailedPacketReceivedFromSource,

  ///
  /// 7: The server fails to send the media stream.
  ///
  @JsonValue(7)
  FailedPacketSentToDestination,

  ///
  /// 8: The SDK disconnects from the server due to poor network connections. You can call the leaveChannel method to leave the channel.
  ///
  @JsonValue(8)
  ServerConnectionLost,

  ///
  /// 9: An internal error occurs in the server.
  ///
  @JsonValue(9)
  InternalError,

  ///
  /// 10: The token of the source channel has expired.
  ///
  @JsonValue(10)
  SourceTokenExpired,

  ///
  /// 11: The token of the destination channel has expired.
  ///
  @JsonValue(11)
  DestinationTokenExpired,
}

///
/// The event code of channel media relay.
///
///
enum ChannelMediaRelayEvent {
  ///
  /// 0: The user disconnects from the server due to a poor network connection.
  ///
  @JsonValue(0)
  Disconnect,

  ///
  /// 1: The user is connected to the server.
  ///
  @JsonValue(1)
  Connected,

  ///
  /// 2: The user joins the source channel.
  ///
  @JsonValue(2)
  JoinedSourceChannel,

  ///
  /// 3: The user joins the destination channel.
  ///
  @JsonValue(3)
  JoinedDestinationChannel,

  ///
  /// 4: The SDK starts relaying the media stream to the destination channel.
  ///
  @JsonValue(4)
  SentToDestinationChannel,

  ///
  /// 5: The server receives the audio stream from the source channel.
  ///
  @JsonValue(5)
  ReceivedVideoPacketFromSource,

  ///
  /// 6: The server receives the audio stream from the source channel.
  ///
  @JsonValue(6)
  ReceivedAudioPacketFromSource,

  ///
  /// 7: The destination channel is updated.
  ///
  @JsonValue(7)
  UpdateDestinationChannel,

  ///
  /// 8: The destination channel update fails due to internal reasons.
  ///
  @JsonValue(8)
  UpdateDestinationChannelRefused,

  ///
  /// 9: The destination channel does not change, which means that the destination channel fails to be updated.
  ///
  @JsonValue(9)
  UpdateDestinationChannelNotChange,

  ///
  /// 10: The destination channel name is null.
  ///
  @JsonValue(10)
  UpdateDestinationChannelIsNil,

  ///
  /// 11: The video profile is sent to the server.
  ///
  @JsonValue(11)
  VideoProfileUpdate,

  ///
  /// 12: The SDK successfully pauses relaying the media stream to destination channels.
  ///
  @JsonValue(12)
  PauseSendPacketToDestChannelSuccess,

  ///
  /// 13: The SDK fails to pause relaying the media stream to destination channels.
  ///
  @JsonValue(13)
  PauseSendPacketToDestChannelFailed,

  ///
  /// 14: The SDK successfully resumes relaying the media stream to destination channels.
  ///
  @JsonValue(14)
  ResumeSendPacketToDestChannelSuccess,

  ///
  /// 15: The SDK fails to resume relaying the media stream to destination channels.
  ///
  @JsonValue(15)
  ResumeSendPacketToDestChannelFailed,
}

///
/// The state code of the channel media relay.
///
///
enum ChannelMediaRelayState {
  ///
  /// 0: The initial state. After you successfully stop the channel media relay by calling stopChannelMediaRelay, the channelMediaRelayStateChanged callback returns this state.
  ///
  @JsonValue(0)
  Idle,

  ///
  /// 1: The SDK tries to relay the media stream to the destination channel.
  ///
  @JsonValue(1)
  Connecting,

  ///
  /// 2: The SDK successfully relays the media stream to the destination channel.
  ///
  @JsonValue(2)
  Running,

  ///
  /// 3: An error occurs. See code in channelMediaRelayStateChanged for the error code.
  ///
  @JsonValue(3)
  Failure,
}

///
/// The channel profile.
///
///
enum ChannelProfile {
  ///
  /// 0: (Default) The communication profile. This profile applies to scenarios such as an audio call or video call, where all users can publish and subscribe to streams.
  ///
  @JsonValue(0)
  Communication,

  ///
  /// 1: Live streaming. In this profile, you can set the role of users as the host or audience by calling setClientRole. A host both publishes and subscribes to streams, while an audience subscribes to streams only. This profile applies to scenarios such as a chat room or interactive video streaming.
  ///
  @JsonValue(1)
  LiveBroadcasting,

  ///
  /// 2: Gaming. Agora does not recommend using this setting.
  ///
  @JsonValue(2)
  Game,
}

///
/// The user role in the interactive live streaming.
///
///
enum ClientRole {
  ///
  /// 1: Host. A host can both send and receive streams.
  ///
  @JsonValue(1)
  Broadcaster,

  ///
  /// 2: (Default) Audience. An audience member can only receive streams.
  ///
  @JsonValue(2)
  Audience,
}

///
/// Reasons causing the change of the connection state.
///
///
enum ConnectionChangedReason {
  ///
  /// 0: The SDK is connecting to the Agora edge server.
  ///
  @JsonValue(0)
  Connecting,

  ///
  /// 1: The SDK has joined the channel successfully.
  ///
  @JsonValue(1)
  JoinSuccess,

  ///
  /// 2: The connection between the SDK and the Agora edge server is interrupted.
  ///
  @JsonValue(2)
  Interrupted,

  ///
  /// 3: The connection between the SDK and the Agora edge server is banned by the Agora edge server. This error occurs when the user is kicked out of the channel by the server.
  ///
  @JsonValue(3)
  BannedByServer,

  ///
  /// 4: The SDK fails to join the channel. When the SDK fails to join the channel for more than 20 minutes, this error occurs and the SDK stops reconnecting to the channel.
  ///
  @JsonValue(4)
  JoinFailed,

  ///
  /// 5: The SDK has left the channel.
  ///
  @JsonValue(5)
  LeaveChannel,

  ///
  /// 6: The connection failed because the App ID is not valid. Please rejoin the channel with a valid App ID.
  ///
  @JsonValue(6)
  InvalidAppId,

  ///
  /// 7: The connection failed since channel name is not valid. Please rejoin the channel with a valid channel name.
  ///
  @JsonValue(7)
  InvalidChannelName,

  ///
  /// 8: The connection failed because the token is not valid. Typical reasons include:
  /// The App Certificate for the project is enabled in Agora Console, but you do not use a token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
  /// The uid specified when calling joinChannel to join the channel is inconsistent with the uid passed in when generating the token.
  ///
  ///
  @JsonValue(8)
  InvalidToken,

  ///
  /// 9: The connection failed since token is expired.
  ///
  @JsonValue(9)
  TokenExpired,

  ///
  /// 10: The connection is rejected by server. Typical reasons include:
  /// The user is already in the channel and still calls a method, for example, joinChannel, to join the channel. Stop calling this method to clear this error.
  /// The user tries to join the channel when conducting  a pre-call test. The user needs to call the channel after the call test ends.
  ///
  ///
  ///
  @JsonValue(10)
  RejectedByServer,

  ///
  /// 11: The connection state changed to reconnecting because the SDK has set a proxy server.
  ///
  @JsonValue(11)
  SettingProxyServer,

  ///
  /// 12: The connection state changed because the token is renewed.
  ///
  @JsonValue(12)
  RenewToken,

  ///
  /// 13: The IP address of the client has changed, possibly because the network type, IP address, or port has been changed.
  ///
  @JsonValue(13)
  ClientIpAddressChanged,

  ///
  /// 14: Timeout for the keep-alive of the connection between the SDK and the Agora edge server. The connection state changes to Reconnecting.
  ///
  @JsonValue(14)
  KeepAliveTimeout,

  @JsonValue(15)
  ProxyServerInterrupted,
}

///
/// Connection states.
///
///
enum ConnectionStateType {
  ///
  /// 1: The SDK is disconnected from the Agora edge server. The state indicates the SDK is in one of the following phases:
  /// The initial state before calling the joinChannel method.
  /// The app calls the leaveChannel method.
  ///
  ///
  ///
  @JsonValue(1)
  Disconnected,

  ///
  /// 2: The SDK is connecting to the Agora edge server. This state indicates that the SDK is establishing a connection with the specified channel after the app calls joinChannel.
  ///
  ///
  /// 4: The SDK keeps reconnecting to the Agora edge server. The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.
  /// If the SDK cannot rejoin the channel within 10 seconds, it triggers connectionLost, stays in the Reconnecting state, and keeps rejoining the channel.
  ///
  /// 5: The SDK fails to connect to the Agora edge server or join the channel. This state indicates that the SDK stops trying to rejoin the channel. You must call leaveChannel to leave the channel.
  /// You can call joinChannel to rejoin the channel.
  /// If the SDK is banned from joining the channel by the Agora edge server through the RESTful API, the SDK triggers the connectionStateChanged callback.
  ///
  ///
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from the Agora edge server, the SDK triggers the connectionStateChanged callback, switches to the Failed state, and stops rejoining the channel.
  ///
  ///
  /// 3: The SDK is connected to the Agora edge server. This state also indicates that the user has joined a channel and can now publish or subscribe to a media stream in the channel. If the connection to the Agora edge server is lost because, for example, the network is down or switched, the SDK automatically tries to reconnect and triggers connectionStateChanged that indicates the connection state switches to Reconnecting.
  ///
  /// If the SDK successfully joins the channel, it triggers the connectionStateChanged callback and the connection state switches to Connected.
  /// After the connection is established, the SDK also initializes the media and triggers joinChannelSuccess when everything is ready.
  ///
  ///
  ///
  @JsonValue(2)
  Connecting,

  @JsonValue(3)
  Connected,

  @JsonValue(4)
  Reconnecting,

  @JsonValue(5)
  Failed,
}

///
/// Video degradation preferences when the bandwidth is a constraint.
///
///
enum DegradationPreference {
  ///
  /// 0: (Default) Prefers to reduce the video frame rate while maintaining video quality during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.
  ///   In the COMMUNICATION channel profile, the resolution of the video sent may change, so remote users need to handle this issue. See videoSizeChanged.
  ///
  @JsonValue(0)
  MaintainQuality,

  ///
  /// 1: Prefers to reduce the video quality while maintaining the video frame rate during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where smoothness is prioritized and video quality is allowed to be reduced.
  ///
  @JsonValue(1)
  MaintainFramerate,

  ///
  /// 2: Reduces the video frame rate and video quality simultaneously during video encoding under limited bandwidth. MaintainBalanced has a lower reduction than MaintainQuality and MaintainFramerate, and this preference is suitable for scenarios where both smoothness and video quality are a priority.
  /// The resolution of the video sent may change, so remote users need to handle this issue. See videoSizeChanged.
  ///
  ///
  @JsonValue(2)
  MaintainBalanced
}

///
/// The built-in encryption mode.
/// Agora recommends using AES128GCM2 or AES256GCM2 encrypted mode. These two modes support the use of salt for higher security.
///
enum EncryptionMode {
  @Deprecated('')
  @JsonValue(0)
  None,

  ///
  ///
  ///
  @JsonValue(1)
  AES128XTS,

  ///
  /// 2: 128-bit AES encryption, ECB mode.
  ///
  @JsonValue(2)
  AES128ECB,

  ///
  /// 3: 256-bit AES encryption, XTS mode.
  ///
  @JsonValue(3)
  AES256XTS,

  ///
  /// 4: 128-bit SM4 encryption, ECB mode.
  ///
  @JsonValue(4)
  SM4128ECB,

  ///
  /// 5: 128-bit AES encryption, GCM mode.
  ///
  @JsonValue(5)
  AES128GCM,

  ///
  /// 6: 256-bit AES encryption, GCM mode.
  ///
  @JsonValue(6)
  AES256GCM,

  ///
  ///
  ///
  @JsonValue(7)
  AES128GCM2,

  ///
  /// 8: 256-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (encryptionKdfSalt).
  ///
  @JsonValue(8)
  AES256GCM2,
}

/* TODO(doc): enum-ErrorCode */
enum ErrorCode {
  @JsonValue(0)
  NoError,

  @JsonValue(1)
  Failed,

  @JsonValue(2)
  InvalidArgument,

  @JsonValue(3)
  NotReady,

  @JsonValue(4)
  NotSupported,

  @JsonValue(5)
  Refused,

  @JsonValue(6)
  BufferTooSmall,

  @JsonValue(7)
  NotInitialized,

  @JsonValue(9)
  NoPermission,

  @JsonValue(10)
  TimedOut,

  @JsonValue(11)
  Canceled,

  @JsonValue(12)
  TooOften,

  @JsonValue(13)
  BindSocket,

  @JsonValue(14)
  NetDown,

  @JsonValue(15)
  NoBufs,

  @JsonValue(17)
  JoinChannelRejected,

  @JsonValue(18)
  LeaveChannelRejected,

  @JsonValue(19)
  AlreadyInUse,

  @JsonValue(20)
  Abort,

  @JsonValue(21)
  InitNetEngine,

  @JsonValue(22)
  ResourceLimited,

  @JsonValue(101)
  InvalidAppId,

  @JsonValue(102)
  InvalidChannelId,

  @JsonValue(103)
  NoServerResources,

  @Deprecated('')
  @JsonValue(109)
  TokenExpired,

  @Deprecated('')
  @JsonValue(110)
  InvalidToken,

  @JsonValue(111)
  ConnectionInterrupted,

  @JsonValue(112)
  ConnectionLost,

  @JsonValue(113)
  NotInChannel,

  @JsonValue(114)
  SizeTooLarge,

  @JsonValue(115)
  BitrateLimit,

  @JsonValue(116)
  TooManyDataStreams,

  @JsonValue(120)
  DecryptionFailed,

  @JsonValue(123)
  ClientIsBannedByServer,

  @JsonValue(124)
  WatermarkParam,

  @JsonValue(125)
  WatermarkPath,

  @JsonValue(126)
  WatermarkPng,

  @JsonValue(127)
  WatermarkInfo,

  @JsonValue(128)
  WatermarkAGRB,

  @JsonValue(129)
  WatermarkRead,

  @JsonValue(130)
  EncryptedStreamNotAllowedPublish,

  @JsonValue(134)
  InvalidUserAccount,

  @JsonValue(151)
  PublishStreamCDNError,

  @JsonValue(152)
  PublishStreamNumReachLimit,

  @JsonValue(153)
  PublishStreamNotAuthorized,

  @JsonValue(154)
  PublishStreamInternalServerError,

  @JsonValue(155)
  PublishStreamNotFound,

  @JsonValue(156)
  PublishStreamFormatNotSuppported,

  @JsonValue(157)
  ModuleNotFound,

  @JsonValue(160)
  AlreadyInRecording,

  @JsonValue(1001)
  LoadMediaEngine,

  @JsonValue(1002)
  StartCall,

  @Deprecated('')
  @JsonValue(1003)
  StartCamera,

  @JsonValue(1004)
  StartVideoRender,

  @JsonValue(1005)
  AdmGeneralError,

  @JsonValue(1006)
  AdmJavaResource,

  @JsonValue(1007)
  AdmSampleRate,

  @JsonValue(1008)
  AdmInitPlayout,

  @JsonValue(1009)
  AdmStartPlayout,

  @JsonValue(1010)
  AdmStopPlayout,

  @JsonValue(1011)
  AdmInitRecording,

  @JsonValue(1012)
  AdmStartRecording,

  @JsonValue(1013)
  AdmStopRecording,

  @JsonValue(1015)
  AdmRuntimePlayoutError,

  @JsonValue(1017)
  AdmRuntimeRecordingError,

  @JsonValue(1018)
  AdmRecordAudioFailed,

  @JsonValue(1020)
  AdmPlayAbnormalFrequency,

  @JsonValue(1021)
  AdmRecordAbnormalFrequency,

  @JsonValue(1022)
  AdmInitLoopback,

  @JsonValue(1023)
  AdmStartLoopback,

  @JsonValue(1027)
  AdmNoPermission,

  @JsonValue(1030)
  AudioBtScoFailed,

  @JsonValue(1359)
  AdmNoRecordingDevice,

  @JsonValue(1360)
  AdmNoPlayoutDevice,

  @JsonValue(1501)
  VdmCameraNotAuthorized,

  @JsonValue(1600)
  VcmUnknownError,

  @JsonValue(1601)
  VcmEncoderInitError,

  @JsonValue(1602)
  VcmEncoderEncodeError,

  @Deprecated('')
  @JsonValue(1603)
  VcmEncoderSetError,
}

///
/// States of importing an external video stream in the interactive live streaming.
///
///
enum InjectStreamStatus {
  ///
  /// 0: The external video stream is imported successfully.
  ///
  @JsonValue(0)
  StartSuccess,

  ///
  /// 1: The external video stream already exists.
  ///
  @JsonValue(1)
  StartAlreadyExists,

  ///
  /// 2: The external video stream to be imported is unauthorized.
  ///
  @JsonValue(2)
  StartUnauthorized,

  ///
  /// 3: A timeout occurs when importing the external video stream.
  ///
  @JsonValue(3)
  StartTimedout,

  ///
  /// 4: The SDK fails to import the external video stream.
  ///
  @JsonValue(4)
  StartFailed,

  ///
  /// 5: The SDK successfully stops importing the external video stream.
  ///
  @JsonValue(5)
  StopSuccess,

  ///
  /// 6: The external video stream to be stopped importing is not found.
  ///
  @JsonValue(6)
  StopNotFound,

  ///
  /// 7: The external video stream to be stopped importing is unauthorized.
  ///
  @JsonValue(7)
  StopUnauthorized,

  ///
  /// 8: A timeout occurs when stopping importing the external video stream.
  ///
  @JsonValue(8)
  StopTimedout,

  ///
  /// 9: The SDK fails to stop importing the external video stream.
  ///
  @JsonValue(9)
  StopFailed,

  ///
  /// 10: The external video stream is corrupted.
  ///
  @JsonValue(10)
  Broken,
}

///
/// The status of the last-mile network tests.
///
///
enum LastmileProbeResultState {
  ///
  /// 1: The last-mile network probe test is complete.
  ///
  @JsonValue(1)
  Complete,

  ///
  /// 2: The last-mile network probe test is incomplete because the bandwidth estimation is not available due to limited test resources.
  ///
  @JsonValue(2)
  IncompleteNoBwe,

  ///
  /// 3: The last-mile network probe test is not carried out, probably due to poor network conditions.
  ///
  @JsonValue(3)
  Unavailable,
}

///
/// The contrast level.
///
///
enum LighteningContrastLevel {
  ///
  /// Low contrast level.
  ///
  @JsonValue(0)
  Low,

  ///
  /// (Default) Normal contrast level.
  ///
  @JsonValue(1)
  Normal,

  ///
  /// High contrast level.
  ///
  @JsonValue(2)
  High,
}

///
/// Local video state error codes.
///
///
enum LocalVideoStreamError {
  ///
  /// 0: The local video is normal.
  ///
  @JsonValue(0)
  OK,

  ///
  /// 1: No specified reason for the local video failure.
  ///
  @JsonValue(1)
  Failure,

  ///
  /// 2: No permission to use the local video capturing device.
  ///
  @JsonValue(2)
  DeviceNoPermission,

  ///
  /// 3: The local video capturing device is in use.
  ///
  @JsonValue(3)
  DeviceBusy,

  ///
  /// 4: The local video capture fails. Check whether the capturing device is working properly.
  ///
  @JsonValue(4)
  CaptureFailure,

  ///
  /// 5: The local video encoding fails.
  ///
  @JsonValue(5)
  EncodeFailure,

  ///
  /// 6: The local video capturing device not available due to app did enter background.
  ///
  @JsonValue(6)
  CaptureInBackground,

  ///
  /// 7: The local video capturing device not available because the app is running in a multi-app layout (generally on the pad).
  ///
  @JsonValue(7)
  CaptureMultipleForegroundApps,

  ///
  /// 8: Fails to find a local video capture device.
  ///
  ///
  @JsonValue(8)
  DeviceNotFound,

  ///
  /// startScreenCaptureByWindowId11: When calling to share the window, the shared window is in a minimized state.
  ///
  @JsonValue(11)
  ScreenCaptureWindowMinmized,

  ///
  /// 12: The error code indicates that a window shared by the window ID has been closed, or a full-screen window shared by the window ID has exited full-screen mode. After exiting full-screen mode, remote users cannot see the shared window. To prevent remote users from seeing a black screen, Agora recommends that you immediately stop screen sharing.
  /// Common scenarios for reporting this error code:
  ///  When the local user closes the shared window, the SDK reports this error code.
  /// The local user shows some slides in full-screen mode first, and then shares the windows of the slides. After the user exits full-screen mode, the SDK reports this error code.
  /// The local user watches web video or reads web document in full-screen mode first, and then shares the window of the web video or document. After the user exits full-screen mode, the SDK reports this error code.
  ///
  ///
  ///
  @JsonValue(12)
  ScreenCaptureWindowClosed,

  @JsonValue(10)
  LocalVideoStreamErrorDeviceInvalidId,

  @JsonValue(13)
  LocalVideoStreamErrorScreenCaptureWindowOccluded,

  @JsonValue(20)
  LocalVideoStreamErrorScreenCaptureWindowNotSupported,
}

///
/// Local video state types
///
///
enum LocalVideoStreamState {
  ///
  /// 0: The local video is in the initial state.
  ///
  @JsonValue(0)
  Stopped,

  ///
  /// 1: The local video capturing device starts successfully.
  ///
  @JsonValue(1)
  Capturing,

  ///
  /// 2: The first video frame is successfully encoded.
  ///
  @JsonValue(2)
  Encoding,

  ///
  /// 3: Fails to start the local video.
  ///
  @JsonValue(3)
  Failed,
}

///
/// The output log level of the SDK.
///
///
enum LogFilter {
  ///
  /// 0: Do not output any log information.
  ///
  @JsonValue(0)
  Off,

  ///
  /// 0x080f: Output all log information. Set your log filter as DEBUG if you want to get the most complete log file.
  ///
  @JsonValue(0x080f)
  Debug,

  ///
  /// 0x000f: Output CRITICAL, ERROR, WARNING, and INFO level log information. We recommend setting your log filter as this level.
  ///
  @JsonValue(0x000f)
  Info,

  ///
  /// 0x000e: Output CRITICAL, ERROR, and WARNING level log information.
  ///
  @JsonValue(0x000e)
  Warning,

  ///
  /// 0x000c: Output CRITICAL and ERROR level log information.
  ///
  @JsonValue(0x000c)
  Error,

  ///
  /// 0x0008: Output CRITICAL level log information.
  ///
  @JsonValue(0x0008)
  Critical,
}

///
/// Network quality types.
///
///
enum NetworkQuality {
  ///
  /// 0: The network quality is unknown.
  ///
  @JsonValue(0)
  Unknown,

  ///
  /// 1: The network quality is excellent.
  ///
  @JsonValue(1)
  Excellent,

  ///
  /// 2: The network quality is quite good, but the bitrate may be slightly lower than excellent.
  ///
  @JsonValue(2)
  Good,

  ///
  /// 3: Users can feel the communication slightly impaired.
  ///
  @JsonValue(3)
  Poor,

  ///
  /// 4: Users cannot communicate smoothly.
  ///
  @JsonValue(4)
  Bad,

  ///
  /// 5: The quality is so bad that users can barely communicate.
  ///
  @JsonValue(5)
  VBad,

  ///
  /// 6: The network is down and users cannot communicate at all.
  ///
  @JsonValue(6)
  Down,

  ///
  /// 7: Users cannot detect the network quality. (Not in use.)
  ///
  @JsonValue(7)
  Unsupported,

  ///
  /// 8: Detecting the network quality.
  ///
  @JsonValue(8)
  Detecting,
}

///
/// Network type.
///
///
enum NetworkType {
  ///
  /// -1: The network type is unknown.
  ///
  @JsonValue(-1)
  Unknown,

  ///
  /// 0: The SDK disconnects from the network.
  ///
  @JsonValue(0)
  Disconnected,

  ///
  /// 1: The network type is LAN.
  ///
  @JsonValue(1)
  LAN,

  ///
  /// 2: The network type is Wi-Fi (including hotspots).
  ///
  @JsonValue(2)
  WIFI,

  ///
  /// 3: The network type is mobile 2G.
  ///
  @JsonValue(3)
  Mobile2G,

  ///
  /// 4: The network type is mobile 3G.
  ///
  @JsonValue(4)
  Mobile3G,

  ///
  /// 5: The network type is mobile 4G.
  ///
  @JsonValue(5)
  Mobile4G,

  @JsonValue(6)
  Mobile5G,
}

///
/// Error codes of the RTMP or RTMPS streaming.
///
///
///
/// 100: The streaming has been stopped normally. After you call removePublishStreamUrl to stop streaming, the SDK returns this value.
///
///
/// The URL format is incorrect. Check whether the URL format is correct.
///
enum RtmpStreamingErrorCode {
  @JsonValue(0)
  OK,

  @JsonValue(1)
  InvalidParameters,

  @JsonValue(2)
  EncryptedStreamNotAllowed,

  @JsonValue(3)
  ConnectionTimeout,

  @JsonValue(4)
  InternalServerError,

  @JsonValue(5)
  RtmpServerError,

  @JsonValue(6)
  TooOften,

  @JsonValue(7)
  ReachLimit,

  @JsonValue(8)
  NotAuthorized,

  @JsonValue(9)
  StreamNotFound,

  @JsonValue(10)
  FormatNotSupported,

  @JsonValue(11)
  NotBroadcaster,

  @JsonValue(13)
  TranscodingNoMixStream,

  @JsonValue(14)
  NetDown,

  @JsonValue(15)
  InvalidAppid,

  @JsonValue(100)
  UnPublishOK,
}

///
/// States of the RTMP or RTMPS streaming.
///
///
///
/// 5: The SDK is disconnecting from the Agora streaming server and CDN. When you call removePublishStreamUrl or stopRtmpStream to stop the streaming normally, the SDK reports the streaming state as RTMP_STREAM_PUBLISH_STATE_DISCONNECTING, Idle in sequence.
///
///
///
/// The RTMP or RTMPS streaming fails. See the error code for the detailed error information. You can also call the
///
///
/// method to publish the RTMP or RTMPS stream again.
///
///
enum RtmpStreamingState {
  @JsonValue(0)
  Idle,

  @JsonValue(1)
  Connecting,

  @JsonValue(2)
  Running,

  @JsonValue(3)
  Recovering,

  @JsonValue(4)
  Failure,
}

///
/// Stream fallback options.
///
///
enum StreamFallbackOptions {
  ///
  /// 0: No fallback behavior for the local/remote video stream when the uplink/downlink network conditions are poor. The quality of the stream is not guaranteed.
  ///
  @JsonValue(0)
  Disabled,

  ///
  /// 1: Under poor downlink network conditions, the remote video stream, to which you subscribe, falls back to the low-quality (low resolution and low bitrate) video stream. This option is only valid for
  /// .
  ///
  @JsonValue(1)
  VideoStreamLow,

  ///
  /// 2: Under poor uplink network conditions, the published video stream falls back to audio-only. Under poor downlink network conditions, the remote video stream, to which you subscribe, first falls back to the low-quality (low resolution and low bitrate) video stream; and then to an audio-only stream if the network conditions worsen.
  ///
  @JsonValue(2)
  AudioOnly,
}

///
/// Reasons for a user being offline.
///
///
enum UserOfflineReason {
  ///
  /// 0: The user quits the call.
  ///
  @JsonValue(0)
  Quit,

  ///
  /// 1: The SDK times out and the user drops offline because no data packet is received within a certain period of time.
  /// If the user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline.
  ///
  @JsonValue(1)
  Dropped,

  ///
  /// 2: The user switches the client role from the host to the audience.
  ///
  @JsonValue(2)
  BecomeAudience,
}

///
/// The priority of the remote user.
///
///
enum UserPriority {
  ///
  /// The user's priority is high.
  ///
  @JsonValue(50)
  High,

  ///
  /// (Default) The user's priority is normal.
  ///
  @JsonValue(100)
  Normal,
}

///
/// Video codec profile types.
///
///
enum VideoCodecProfileType {
  ///
  /// 66: Baseline video codec profile. Generally used for video calls on mobile phones.
  ///
  @JsonValue(66)
  BaseLine,

  ///
  /// 77: Main video codec profile. Generally used in mainstream electronics such as MP4 players, portable video players, PSP, and iPads.
  ///
  @JsonValue(77)
  Main,

  ///
  /// 100: (Default) High video codec profile. Generally used in high-resolution live streaming or television.
  ///
  @JsonValue(100)
  High,
}

///
/// Video frame rate.
///
///
enum VideoFrameRate {
  @JsonValue(-1)
  Min,

  ///
  /// 1: 1 fps
  ///
  @JsonValue(1)
  Fps1,

  ///
  /// 7: 7 fps
  ///
  @JsonValue(7)
  Fps7,

  ///
  /// 10: 10 fps
  ///
  @JsonValue(10)
  Fps10,

  ///
  /// 15: 15 fps
  ///
  @JsonValue(15)
  Fps15,

  ///
  /// 24: 24 fps
  ///
  @JsonValue(24)
  Fps24,

  ///
  /// 30: 30 fps
  ///
  @JsonValue(30)
  Fps30,

  @JsonValue(60)
  Fps60,
}

/* TODO(doc): enum-BitRate */
enum BitRate {
  @JsonValue(0)
  Standard,

  @JsonValue(-1)
  Compatible,
}

///
/// Video mirror mode.
///
///
enum VideoMirrorMode {
  ///
  /// 0: (Default) The SDK determines the mirror mode.
  ///
  @JsonValue(0)
  Auto,

  ///
  /// 1: Enable mirror mode.
  ///
  @JsonValue(1)
  Enabled,

  ///
  /// 2: Disable mirror mode.
  ///
  @JsonValue(2)
  Disabled,
}

///
/// Video output orientation modes.
///
///
enum VideoOutputOrientationMode {
  ///
  /// 0: (Default) The output video always follows the orientation of the captured video. The receiver takes the rotational information passed on from the video encoder. This mode applies to scenarios where video orientation can be adjusted on the receiver.
  ///
  ///  If the captured video is in landscape mode, the output video is in landscape mode.
  ///  If the captured video is in portrait mode, the output video is in portrait mode.
  ///
  ///
  ///
  @JsonValue(0)
  Adaptative,

  ///
  /// 1: In this mode, the SDK always outputs videos in landscape (horizontal) mode. If the captured video is in portrait mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
  ///
  @JsonValue(1)
  FixedLandscape,

  ///
  /// 2: In this mode, the SDK always outputs video in portrait (portrait) mode. If the captured video is in landscape mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
  ///
  @JsonValue(2)
  FixedPortrait,
}

///
/// Quality change of the local video in terms of target frame rate and target bit rate since last count.
///
///
enum VideoQualityAdaptIndication {
  ///
  /// 0: The local video quality stays the same.
  ///
  @JsonValue(0)
  AdaptNone,

  ///
  /// 1: The local video quality improves because the network bandwidth increases.
  ///
  @JsonValue(1)
  AdaptUpBandwidth,

  ///
  /// 2: The local video quality deteriorates because the network bandwidth decreases.
  ///
  @JsonValue(2)
  AdaptDownBandwidth,
}

///
/// The state of the remote video.
///
///
enum VideoRemoteState {
  ///
  /// 0: The remote video is in the initial state. The SDK reports this state in the case of LocalMuted, RemoteMuted or RemoteOffline.
  ///
  @JsonValue(0)
  Stopped,

  ///
  /// 1: The first remote video packet is received.
  ///
  @JsonValue(1)
  Starting,

  ///
  /// 2: The remote video stream is decoded and plays normally. The SDK reports this state in the case of NetworkRecovery, LocalUnmuted,RemoteUnmuted, or AudioFallbackRecovery.
  ///
  @JsonValue(2)
  Decoding,

  ///
  /// 3: The remote video is frozen. The SDK reports this state in the case of NetworkCongestion or AudioFallback.
  ///
  @JsonValue(3)
  Frozen,

  ///
  /// 4: The remote video fails to start. The SDK reports this state in the case of Internal.
  ///
  @JsonValue(4)
  Failed,
}

///
/// The reason for the remote video state change.
///
///
enum VideoRemoteStateReason {
  ///
  /// 0: The SDK reports this reason when the video state changes.
  ///
  @JsonValue(0)
  Internal,

  ///
  /// 1: Network congestion.
  ///
  @JsonValue(1)
  NetworkCongestion,

  ///
  /// 2: Network recovery.
  ///
  @JsonValue(2)
  NetworkRecovery,

  ///
  /// 3: The local user stops receiving the remote
  ///   video stream or disables the video module.
  ///
  @JsonValue(3)
  LocalMuted,

  ///
  /// 4: The local user resumes receiving the remote video stream or enables the video module.
  ///
  @JsonValue(4)
  LocalUnmuted,

  ///
  /// 5: The remote user stops sending the video stream or disables the video module.
  ///
  @JsonValue(5)
  RemoteMuted,

  ///
  /// 6: The remote user resumes sending the video stream or enables the video module.
  ///
  @JsonValue(6)
  RemoteUnmuted,

  ///
  /// 7: The remote user leaves the channel.
  ///
  @JsonValue(7)
  RemoteOffline,

  ///
  /// 8: The remote audio-and-video stream falls back to the audio-only stream due to poor network conditions.
  ///
  @JsonValue(8)
  AudioFallback,

  ///
  /// 9: The remote audio-only stream switches back to the audio-and-video stream after the network conditions improve.
  ///
  @JsonValue(9)
  AudioFallbackRecovery,
}

///
/// Video display modes.
///
///
enum VideoRenderMode {
  ///
  /// 1: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Hidden mode. One dimension of the video may have clipped contents.
  ///
  @JsonValue(1)
  Hidden,

  ///
  /// 2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Fit mode. Areas that are not filled due to disparity in the aspect ratio are filled with black.
  ///
  @JsonValue(2)
  Fit,

  ///
  ///
  ///
  /// Deprecated:
  /// 3: This mode is deprecated.
  ///
  ///
  ///
  @Deprecated('')
  @JsonValue(3)
  Adaptive,

  @JsonValue(4)
  FILL,
}

///
/// The type of video streams.
///
///
enum VideoStreamType {
  ///
  /// 0: High-quality video stream.
  ///
  @JsonValue(0)
  High,

  ///
  /// 1: Low-quality video stream.
  ///
  @JsonValue(1)
  Low,
}

/* TODO(doc): enum-WarningCode */
enum WarningCode {
  @JsonValue(8)
  InvalidView,

  @JsonValue(16)
  InitVideo,

  @JsonValue(20)
  Pending,

  @JsonValue(103)
  NoAvailableChannel,

  @JsonValue(104)
  LookupChannelTimeout,

  @Deprecated('')
  @JsonValue(105)
  LookupChannelRejected,

  @JsonValue(106)
  OpenChannelTimeout,

  @JsonValue(107)
  OpenChannelRejected,

  @JsonValue(111)
  SwitchLiveVideoTimeout,

  @JsonValue(118)
  SetClientRoleTimeout,

  @JsonValue(119)
  SetClientRoleNotAuthorized,

  @JsonValue(121)
  OpenChannelInvalidTicket,

  @JsonValue(122)
  OpenChannelTryNextVos,

  @JsonValue(701)
  AudioMixingOpenError,

  @JsonValue(1014)
  AdmRuntimePlayoutWarning,

  @JsonValue(1016)
  AdmRuntimeRecordingWarning,

  @JsonValue(1019)
  AdmRecordAudioSilence,

  @JsonValue(1020)
  AdmPlaybackMalfunction,

  @JsonValue(1021)
  AdmRecordMalfunction,

  @JsonValue(1025)
  AdmInterruption,

  @JsonValue(1029)
  AdmCategoryNotPlayAndRecord,

  @JsonValue(1031)
  AdmRecordAudioLowlevel,

  @JsonValue(1032)
  AdmPlayoutAudioLowlevel,

  @JsonValue(1033)
  AdmRecordIsOccupied,

  @JsonValue(1040)
  AdmNoDataReadyCallback,

  @JsonValue(1042)
  AdmInconsistentDevices,

  @JsonValue(1051)
  ApmHowling,

  @JsonValue(1052)
  AdmGlitchState,

  @JsonValue(1053)
  ApmResidualEcho,

  @JsonValue(1610)
  SuperResolutionStreamOverLimitation,

  @JsonValue(1611)
  SuperResolutionUserCountOverLimitation,

  @JsonValue(1612)
  SuperResolutionDeviceNotSupported,
}

/* TODO(doc): enum-AudioChannel */
enum AudioChannel {
  @JsonValue(0)
  Channel0,

  @JsonValue(1)
  Channel1,

  @JsonValue(2)
  Channel2,

  @JsonValue(3)
  Channel3,

  @JsonValue(4)
  Channel4,

  @JsonValue(5)
  Channel5,
}

///
/// Video codec types.
///
///
enum VideoCodecType {
  ///
  /// Standard VP8.
  ///
  @JsonValue(1)
  VP8,

  ///
  /// Standard H.264.
  ///
  @JsonValue(2)
  H264,

  @JsonValue(3)
  EVP,

  @JsonValue(4)
  E264,
}

///
/// The codec type of the output video.
///
///
enum VideoCodecTypeForStream {
  @JsonValue(1)
  H264,

  @JsonValue(2)
  H265,
}

///
/// The publishing state.
///
///
enum StreamPublishState {
  ///
  /// 0: The initial publishing state after joining the channel.
  ///
  @JsonValue(0)
  Idle,

  ///
  /// 1: Fails to publish the local stream. Possible reasons:
  ///  The local user calls muteLocalAudioStream(true) or muteLocalVideoStream(true) to stop sending the local media stream.
  ///  The local user calls disableAudio or disableVideo to disable the local audio or video module.
  ///  The local user calls enableLocalAudio(false) or enableLocalVideo(false) to disable the local audio or video capture.
  /// The role of the local user is audience.
  ///
  ///
  ///
  ///
  /// 3: Publishes successfully.
  ///
  @JsonValue(1)
  NoPublished,

  ///
  /// 2: Publishing.
  ///
  @JsonValue(2)
  Publishing,

  @JsonValue(3)
  Published,
}

///
/// The subscribing state.
///
///
enum StreamSubscribeState {
  ///
  /// 0: The initial subscribing state after joining the channel.
  ///
  @JsonValue(0)
  Idle,

  ///
  /// 1: Fails to subscribe to the remote stream. Possible reasons:
  /// The remote user:
  /// Calls muteLocalAudioStream(true) or muteLocalVideoStream(true) to stop sending local media stream.
  /// Calls disableAudio or disableVideo to disable the local audio or video module.
  /// Calls enableLocalAudio(false) or enableLocalVideo(false) to disable the local audio or video capture.
  /// The role of the remote user is audience.
  ///
  /// The local user calls the following methods to stop receiving remote streams:
  /// Calls muteRemoteAudioStream(true), muteAllRemoteAudioStreams(true) or setDefaultMuteAllRemoteAudioStreams(true) to stop receiving the remote audio streams.
  /// Calls muteRemoteVideoStream(true), muteAllRemoteVideoStreams(true) or setDefaultMuteAllRemoteVideoStreams(true) to stop receiving the remote video streams.
  ///
  ///
  ///
  ///
  ///
  /// 3: Subscribes to and receives the remote stream successfully.
  ///
  @JsonValue(1)
  NoSubscribed,

  ///
  /// 2: Subscribing.
  ///
  @JsonValue(2)
  Subscribing,

  @JsonValue(3)
  Subscribed,
}

///
/// Events during the RTMP or RTMPS streaming.
///
///
///
/// 4: Reserved.
///
enum RtmpStreamingEvent {
  @JsonValue(1)
  FailedLoadImage,

  @JsonValue(2)
  UrlAlreadyInUse,

  @JsonValue(3)
  AdvancedFeatureNotSupport,

  @JsonValue(4)
  RequestTooOften,
}

///
/// The operational permission of the SDK on the audio session.
///
///
enum AudioSessionOperationRestriction {
  ///
  /// No restriction, the SDK has full control of the audio session operations.
  ///
  @JsonValue(0)
  None,

  ///
  /// The SDK does not change the audio session category.
  ///
  @JsonValue(1)
  SetCategory,

  ///
  /// The SDK does not change any setting of the audio session (category, mode, categoryOptions).
  ///
  @JsonValue(1 << 1)
  ConfigureSession,

  ///
  /// The SDK keeps the audio session active when leaving a channel.
  ///
  @JsonValue(1 << 2)
  DeactivateSession,

  ///
  /// The SDK does not configure the audio session anymore.
  ///
  @JsonValue(1 << 7)
  All,
}

///
/// Preset voice effects.
/// For better voice effects, Agora recommends setting the profile parameter of setAudioProfile to MusicHighQuality or MusicHighQualityStereo before using the following presets:
///
/// RoomAcousticsKTV
/// RoomAcousticsVocalConcert
/// RoomAcousticsStudio
/// RoomAcousticsPhonograph
/// RoomAcousticsSpacial
/// RoomAcousticsEthereal
/// VoiceChangerEffectUncle
/// VoiceChangerEffectOldMan
/// VoiceChangerEffectBoy
/// VoiceChangerEffectSister
/// VoiceChangerEffectGirl
/// VoiceChangerEffectPigKing
/// VoiceChangerEffectHulk
/// PitchCorrection
///
enum AudioEffectPreset {
  ///
  /// Turn off voice effects, that is, use the original voice.
  ///
  @JsonValue(0x00000000)
  AudioEffectOff,

  ///
  /// The voice effect typical of a KTV venue.
  ///
  @JsonValue(0x02010100)
  RoomAcousticsKTV,

  ///
  /// The voice effect typical of a concert hall.
  ///
  @JsonValue(0x02010200)
  RoomAcousticsVocalConcert,

  ///
  /// The voice effect typical of a recording studio.
  ///
  @JsonValue(0x02010300)
  RoomAcousticsStudio,

  ///
  /// The voice effect typical of a vintage phonograph.
  ///
  @JsonValue(0x02010400)
  RoomAcousticsPhonograph,

  ///
  /// The virtual stereo effect, which renders monophonic audio as stereo audio.
  /// Before using this preset, set the profile parameter of setAudioProfile to MusicHighQuality or MusicHighQualityStereo; otherwise, the preset setting is invalid.
  ///
  ///
  @JsonValue(0x02010500)
  RoomAcousticsVirtualStereo,

  ///
  /// A more spatial voice effect.
  ///
  @JsonValue(0x02010600)
  RoomAcousticsSpacial,

  ///
  /// A more ethereal voice effect.
  ///
  @JsonValue(0x02010700)
  RoomAcousticsEthereal,

  ///
  /// A 3D voice effect that makes the voice appear to be moving around the user. The default movement cycle is 10 seconds. After setting this effect, you can call setAudioEffectParameters to modify the movement period.
  ///
  ///
  ///  Before using this preset, set the profile parameter of setAudioProfile to MusicStandardStereo or MusicHighQualityStereo; otherwise, the preset setting is invalid.
  ///  If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.
  ///
  ///
  ///
  ///
  @JsonValue(0x02010800)
  RoomAcoustics3DVoice,

  ///
  /// A middle-aged man's voice.
  /// Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  ///
  ///
  @JsonValue(0x02020100)
  VoiceChangerEffectUncle,

  ///
  /// A senior man's voice.
  /// Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  ///
  ///
  @JsonValue(0x02020200)
  VoiceChangerEffectOldMan,

  ///
  /// A boy's voice.
  /// Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  ///
  ///
  @JsonValue(0x02020300)
  VoiceChangerEffectBoy,

  ///
  /// A young woman's voice.
  /// Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  ///
  ///
  @JsonValue(0x02020400)
  VoiceChangerEffectSister,

  ///
  /// A girl's voice.
  /// Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  ///
  ///
  @JsonValue(0x02020500)
  VoiceChangerEffectGirl,

  ///
  /// The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.
  ///
  @JsonValue(0x02020600)
  VoiceChangerEffectPigKing,

  ///
  /// The Hulk's voice.
  ///
  @JsonValue(0x02020700)
  VoiceChangerEffectHulk,

  ///
  /// The voice effect typical of R&B music.
  /// Before using this preset, set the profile parameter of setAudioProfile to MusicHighQuality or MusicHighQualityStereo; otherwise, the preset setting is invalid.
  ///
  ///
  @JsonValue(0x02030100)
  StyleTransformationRnB,

  ///
  /// The voice effect typical of popular music.
  /// Before using this preset, set the profile parameter of setAudioProfile to MusicHighQuality or MusicHighQualityStereo; otherwise, the preset setting is invalid.
  ///
  ///
  @JsonValue(0x02030200)
  StyleTransformationPopular,

  ///
  /// A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. After setting this voice effect, you can call setAudioEffectParameters to adjust the basic mode of tuning and the pitch of the main tone.
  ///
  @JsonValue(0x02040100)
  PitchCorrection,
}

///
/// The options for SDK preset voice beautifier effects.
///
///
enum VoiceBeautifierPreset {
  ///
  /// Turn off voice beautifier effects and use the original voice.
  ///
  @JsonValue(0x00000000)
  VoiceBeautifierOff,

  ///
  /// A more magnetic voice.
  /// Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion.
  ///
  @JsonValue(0x01010100)
  ChatBeautifierMagnetic,

  ///
  /// A fresher voice.
  /// Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  ///
  ///
  @JsonValue(0x01010200)
  ChatBeautifierFresh,

  ///
  /// A more vital voice.
  /// Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  ///
  ///
  @JsonValue(0x01010300)
  ChatBeautifierVitality,

  ///
  /// Singing beautifier effect.
  ///
  ///  If you call setVoiceBeautifierPreset(SingingBeautifier), you can beautify a male-sounding voice and add a reverberation effect that sounds like singing in a small room. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you might experience vocal distortion.
  ///  If you call setVoiceBeautifierParameters(SingingBeautifier, param1, param2), you can beautify a male- or female-sounding voice and add a reverberation effect.
  ///
  ///
  ///
  @JsonValue(0x01020100)
  SingingBeautifier,

  ///
  /// A more vigorous voice.
  ///
  @JsonValue(0x01030100)
  TimbreTransformationVigorous,

  ///
  /// A deep voice.
  ///
  @JsonValue(0x01030200)
  TimbreTransformationDeep,

  ///
  /// A mellower voice.
  ///
  @JsonValue(0x01030300)
  TimbreTransformationMellow,

  ///
  /// Falsetto.
  ///
  @JsonValue(0x01030400)
  TimbreTransformationFalsetto,

  ///
  /// A fuller voice.
  ///
  @JsonValue(0x01030500)
  TimbreTransformationFull,

  ///
  /// A clearer voice.
  ///
  @JsonValue(0x01030600)
  TimbreTransformationClear,

  ///
  /// A more resounding voice.
  ///
  @JsonValue(0x01030700)
  TimbreTransformationResounding,

  ///
  /// A more ringing voice.
  ///
  @JsonValue(0x01030800)
  TimbreTransformationRinging,
}

///
/// The latency level of an audience member in interactive live streaming. This enum takes effect only when the user role is set to Audience.
///
///
enum AudienceLatencyLevelType {
  ///
  /// 1: Low latency.
  ///
  @JsonValue(1)
  LowLatency,

  ///
  /// 2: (Default) Ultra low latency.
  ///
  @JsonValue(2)
  UltraLowLatency,
}

///
/// The output log level of the SDK.
///
///
enum LogLevel {
  ///
  /// 0: Do not output any log information.
  ///
  @JsonValue(0x0000)
  None,

  ///
  /// 0x0001: (Default) Output FATAL, ERROR,
  /// WARN, and INFO level log information. We
  /// recommend setting your log filter as this level.
  ///
  @JsonValue(0x0001)
  Info,

  ///
  /// 0x0002: Output FATAL, ERROR, and WARN level
  /// log information.
  ///
  @JsonValue(0x0002)
  Warn,

  ///
  /// 0x0004: Output FATAL and ERROR level log information.
  ///
  @JsonValue(0x0004)
  Error,

  ///
  /// 0x0008: Output FATAL level log information.
  ///
  @JsonValue(0x0008)
  Fatal,
}

///
/// The brightness level of the video image captured by the local camera.
///
///
///
/// 1: The brightness level of the video image is too bright.
///
enum CaptureBrightnessLevelType {
  ///
  /// -1: The SDK does not detect the brightness level of the video image. Wait a few seconds to get the brightness level from captureBrightnessLevel in the next callback.
  ///
  @JsonValue(-1)
  Invalid,

  ///
  /// 0: The brightness level of the video image is normal.
  ///
  @JsonValue(0)
  Normal,

  @JsonValue(1)
  Bright,

  ///
  /// 2: The brightness level of the video image is too dark.
  ///
  @JsonValue(2)
  Dark,
}

///
/// The reason why super resolution is not successfully enabled.
/// Since
/// v3.5.1
///
enum SuperResolutionStateReason {
  ///
  /// 0: Super resolution is successfully enabled.
  ///
  @JsonValue(0)
  Success,

  ///
  /// 1: The original resolution of the remote video is beyond the range where super resolution can be applied.
  ///
  @JsonValue(1)
  StreamOverLimitation,

  ///
  /// 2: Super resolution is already being used to boost another remote user’s video.
  ///
  @JsonValue(2)
  UserCountOverLimitation,

  ///
  /// 3: The device does not support using super resolution.
  ///
  @JsonValue(3)
  DeviceNotSupported,
}

///
/// The reason for the upload failure.
///
///
enum UploadErrorReason {
  ///
  /// 0: Successfully upload the log files.
  ///
  @JsonValue(0)
  Success,

  ///
  /// 1: Network error. Check the network connection and call uploadLogFile again to upload the log file.
  ///
  @JsonValue(1)
  NetError,

  ///
  /// 2: An error occurs in the Agora server. Try uploading the log files later.
  ///
  @JsonValue(2)
  ServerError,
}

///
/// The cloud proxy type.
///
///
///
/// 2: The cloud proxy for the TCP (encryption) protocol, that is, the Force TCP cloud proxy mode. In this mode, the SDK always transmits data over TLS 443.
///
enum CloudProxyType {
  ///
  /// 0: The automatic mode. In this mode, the SDK attempts a direct connection to SD-RTN™ and automatically switches to TLS 443 if the attempt fails. As of v3.6.2, the SDK has this mode enabled by default.
  ///
  @JsonValue(0)
  None,

  ///
  /// 1: The cloud proxy for the UDP protocol, that is, the Force UDP cloud proxy mode. In this mode, the SDK always transmits data over UDP.
  ///
  @JsonValue(1)
  UDP,

  @JsonValue(2)
  TCP,
}

///
/// The Quality of Experience (QoE) of the local user when receiving a remote audio stream.
///
///
enum ExperienceQualityType {
  ///
  /// 0: The QoE of the local user is good.
  ///
  @JsonValue(0)
  Good,

  ///
  /// 1: The QoE of the local user is poor.
  ///
  @JsonValue(1)
  Bad,
}

///
/// Reasons why the QoE of the local user when receiving a remote audio stream is poor.
///
///
enum ExperiencePoorReason {
  ///
  /// 0: No reason, indicating a good QoE of the local user.
  ///
  @JsonValue(0)
  None,

  ///
  /// 1: The remote user's network quality is poor.
  ///
  @JsonValue(1)
  RemoteNetworkQualityPoor,

  ///
  /// 2: The local user's network quality is poor.
  ///
  @JsonValue(2)
  LocalNetworkQualityPoor,

  ///
  /// 4: The local user's Wi-Fi or mobile network signal is weak.
  ///
  @JsonValue(4)
  WirelessSignalPoor,

  ///
  /// 8: The local user enables both Wi-Fi and bluetooth, and their signals interfere with each other. As a result, audio transmission quality is undermined.
  ///
  @JsonValue(8)
  WifiBluetoothCoexist,
}

///
/// The options for SDK preset voice conversion effects.
///
///
enum VoiceConversionPreset {
  ///
  /// Turn off voice conversion effects and use the original voice.
  ///
  @JsonValue(0)
  Off,

  ///
  /// A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
  ///
  @JsonValue(50397440)
  Neutral,

  ///
  /// A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
  ///
  @JsonValue(50397696)
  Sweet,

  ///
  /// A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
  ///
  @JsonValue(50397952)
  Solid,

  ///
  /// A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
  ///
  @JsonValue(50398208)
  Bass,
}

///
/// The type of the custom background image.
///
///
enum VirtualBackgroundSourceType {
  ///
  /// 1: (Default) The background image is a solid color.
  ///
  @JsonValue(1)
  Color,

  ///
  /// The background image is a file in PNG or JPG format.
  ///
  @JsonValue(2)
  Img,

  ///
  /// The background image is the blurred background.
  ///
  @JsonValue(3)
  Blur,
}

///
/// The degree of blurring applied to the custom background image.
///
///
enum VirtualBackgroundBlurDegree {
  ///
  /// 1: The degree of blurring applied to the custom background image is low. The user can almost see the background clearly.
  ///
  @JsonValue(1)
  Low,

  ///
  /// The degree of blurring applied to the custom background image is medium. It is difficult for the user to recognize details in the background.
  ///
  @JsonValue(2)
  Medium,

  ///
  /// (Default) The degree of blurring applied to the custom background image is high. The user can barely see any distinguishing features in the background.
  ///
  @JsonValue(3)
  High,
}

///
/// The reason why virtual background is not successfully enabled.
/// Since
/// v3.5.0
///
enum VirtualBackgroundSourceStateReason {
  ///
  /// 0: The virtual background is successfully enabled.
  ///
  @JsonValue(0)
  Success,

  ///
  /// 1: The custom background image does not exist. Please check the value of source in VirtualBackgroundSource.
  ///
  @JsonValue(1)
  ImageNotExist,

  ///
  /// 2: The color format of the custom background image is invalid. Please check the value of color in VirtualBackgroundSource.
  ///
  @JsonValue(2)
  ColorFormatNotSupported,

  ///
  /// 3: The device does not support using the virtual background.
  ///
  @JsonValue(3)
  DeviceNotSupported,
}

///
/// The content hint for screen sharing.
///
///
enum VideoContentHint {
  ///
  /// (Default) No content hint.
  ///
  @JsonValue(0)
  None,

  ///
  /// Motion-intensive content. Choose this option if you prefer smoothness or when you are sharing a video clip, movie, or video game.
  ///
  @JsonValue(1)
  Motion,

  ///
  /// Motionless content. Choose this option if you prefer sharpness or when you are sharing a
  /// picture, PowerPoint slides, or texts.
  ///
  @JsonValue(2)
  Details,
}

///
/// Media device types.
///
///
enum MediaDeviceType {
  ///
  /// -1: Unknown device type.
  ///
  @JsonValue(-1)
  UnknownAudioDevice,

  ///
  /// 0: Audio playback device.
  ///
  @JsonValue(0)
  AudioPlayoutDevice,

  ///
  /// 1: Audio capturing device.
  ///
  @JsonValue(1)
  AudioRecordingDevice,

  ///
  /// 2: Video renderer.
  ///
  @JsonValue(2)
  VideoRenderDevice,

  ///
  /// 3: Video capturer.
  ///
  @JsonValue(3)
  VideoCaptureDevice,

  ///
  /// 4: Application audio playback device.
  ///
  @JsonValue(4)
  AudioApplicationPlayoutDevice,
}

///
/// Media device states.
///
///
enum MediaDeviceStateType {
  ///
  /// 0: The device is ready for use.
  ///
  @JsonValue(0)
  MediaDeviceStateIdle,

  ///
  /// 1: The device is in use.
  ///
  @JsonValue(1)
  MediaDeviceStateActive,

  ///
  /// 2: The device is disabled.
  ///
  @JsonValue(2)
  MediaDeviceStateDisabled,

  ///
  /// 4: The device is not found.
  ///
  @JsonValue(4)
  MediaDeviceStateNotPresent,

  ///
  /// 8: The device is unplugged.
  ///
  @JsonValue(8)
  MediaDeviceStateUnplugged,

  @JsonValue(16)
  MediaDeviceStateUnrecommended,
}

/* TODO(doc): enum-RecorderState */
enum RecorderState {
  @JsonValue(-1)
  Error,

  @JsonValue(2)
  Start,

  @JsonValue(3)
  Stop,
}

/* TODO(doc): enum-RecorderErrorCode */
enum RecorderErrorCode {
  @JsonValue(0)
  None,

  @JsonValue(1)
  WriteFailed,

  @JsonValue(2)
  NoStream,

  @JsonValue(3)
  OverMaxDuration,

  @JsonValue(4)
  ConfigChanged,

  @JsonValue(5)
  CustomStreamDetected,
}

/* TODO(doc): enum-MediaRecorderContainerFormat */
enum MediaRecorderContainerFormat {
  @JsonValue(1)
  MP4,

  @JsonValue(2)
  FLV,
}

/* TODO(doc): enum-MediaRecorderStreamType */
enum MediaRecorderStreamType {
  @JsonValue(1)
  Audio,

  @JsonValue(2)
  Video,

  @JsonValue(3)
  Both,
}

/* TODO(doc): enum-LocalProxyMode */
enum LocalProxyMode {
  @JsonValue(0)
  ConnectivityFirst,

  @JsonValue(1)
  LocalOnly,
}

/* TODO(doc): enum-LowLightEnhanceMode */
enum LowLightEnhanceMode {
  @JsonValue(0)
  Auto,

  @JsonValue(1)
  Manual,
}

/* TODO(doc): enum-LowLightEnhanceLevel */
enum LowLightEnhanceLevel {
  @JsonValue(0)
  HighQuality,

  @JsonValue(1)
  Fast
}

/* TODO(doc): enum-VideoDenoiserMode */
enum VideoDenoiserMode {
  @JsonValue(0)
  Auto,

  @JsonValue(1)
  Manual,
}

/* TODO(doc): enum-VideoDenoiserLevel */
enum VideoDenoiserLevel {
  @JsonValue(0)
  HighQuality,

  @JsonValue(1)
  Fast,

  @JsonValue(2)
  Strength,
}

/* TODO(doc): enum-ExcludeWindowError */
enum ExcludeWindowError {
  @JsonValue(-1)
  Fail,

  @JsonValue(0)
  None,
}

/* TODO(doc): enum-ClientRoleChangeFailedReason */
enum ClientRoleChangeFailedReason {
  @JsonValue(1)
  TooManyBroadcasters,

  @JsonValue(2)
  NotAuthorized,

  @JsonValue(3)
  RequestTimeOut,

  @JsonValue(4)
  ConnectionFailed,
}

/* TODO(doc): enum-WlaccMessageReason */
enum WlaccMessageReason {
  @JsonValue(0)
  WeakSignal,

  @JsonValue(1)
  ChannelCongestion,
}

/* TODO(doc): enum-WlaccSuggestAction */
enum WlaccSuggestAction {
  @JsonValue(0)
  CloseToWifi,

  @JsonValue(1)
  ConnectSsid,

  @JsonValue(2)
  Check5g,

  @JsonValue(3)
  ModifySsid,
}

/* TODO(doc): enum-ProxyType */
enum ProxyType {
  @JsonValue(0)
  None,

  @JsonValue(1)
  UDP,

  @JsonValue(2)
  TCP,

  @JsonValue(3)
  Local,

  @JsonValue(4)
  TCPProxyAutoFallbackType,
}

/* TODO(doc): enum-AudioDeviceTestVolumeType */
enum AudioDeviceTestVolumeType {
  @JsonValue(0)
  AudioTestRecordingVolume,

  @JsonValue(1)
  AudioTestPlaybackVolume,
}
