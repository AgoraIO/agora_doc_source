package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.Constants;
import io.agora.rtc2.EncodedVideoTrackOptions;

/**
 * The channel media options.
 */
public class ChannelMediaOptions {
  /**
   * Determines whether to publish the video of the camera track.
   * - true: (Default) Publish the video track of the camera capturer.
   * - false: Do not publish the video track of the camera capturer.
   */
  public Boolean publishCameraTrack;
  /**
   * Determines whether to publish the video of the secondary camera track.
   * - true: Publish the video track of the secondary camera capturer.
   * - false: (Default) Do not publish the video track of the secondary camera capturer.
   */
  public Boolean publishSecondaryCameraTrack;
  /**
   * Determines whether to publish the video of the screen track.
   * - true: Publish the video track of the screen capturer.
   * - false: (Default) Do not publish the video track of the screen capturer.
   */
  public Boolean publishScreenTrack;
  /**
   * Determines whether to publish the audio of the custom audio track.
   * - true: Publish the audio of the custom audio track.
   * - false: (Default) Do not publish the audio of the custom audio track.
   */
  public Boolean publishCustomAudioTrack;
  /**
   * Determines whether to enable AEC when publish custom audio track.
   * - true: Enable AEC.
   * - false: (Default) Do not enable AEC.
   */
  public Boolean publishCustomAudioTrackEnableAec;
  /**
   * Determines whether to publish AEC custom audio track.
   * - true: Publish AEC track.
   * - false: (Default) Do not publish AEC track.
   */
  public Boolean publishCustomAudioTrackAec;
  /**
   * Determines whether to publish direct custom audio track.
   * - true: publish.
   * - false: (Default) Do not publish.
   */
  public Boolean publishDirectCustomAudioTrack;
  /**
   * Determines whether to publish the video of the custom video track.
   * - true: Publish the video of the custom video track.
   * - false: (Default) Do not publish the video of the custom video track.
   */
  public Boolean publishCustomVideoTrack;
  /**
   * Determines whether to publish the video of the encoded video track.
   * - true: Publish the video of the encoded video track.
   * - false: (default) Do not publish the video of the encoded video track.
   */
  public Boolean publishEncodedVideoTrack;
  /**
   * Determines whether to publish the audio track of media player source.
   * - true: Publish the audio track of media player source.
   * - false: (default) Do not publish the audio track of media player source.
   */
  public Boolean publishMediaPlayerAudioTrack;
  /**
   * Determines whether to publish the video track of media player source.
   * - true: Publish the video track of media player source.
   * - false: (default) Do not publish the video track of media player source.
   */
  public Boolean publishMediaPlayerVideoTrack;
  /**
   * Determines whether to publish the sound of the rhythm player to remote users.
   * - true: (Default) Publish the sound of the rhythm player.
   * - false: Do not publish the sound of the rhythm player.
   */
  public Boolean publishRhythmPlayerTrack;
  /**
   * Determines which media player source should be published.
   * - DEFAULT_PLAYER_ID(0) is default.
   */
  public Integer publishMediaPlayerId;
  /**
   * Determines whether to publish the recorded audio. This method replaces calling
   * {@link RtcEngine#muteLocalAudioStream muteLocalAudioStream} before joining a channel.
   * - true: (Default) Publish the recorded audio.
   * - false: Do not publish the recorded audio.
   */
  public Boolean publishAudioTrack;
  /**
   * Determines whether to subscribe to all audio streams automatically.
   *
   * This member replaces calling {@link RtcEngine#setDefaultMuteAllRemoteAudioStreams
   * setDefaultMuteAllRemoteAudioStreams} before joining a channel.
   * - true: (Default) Subscribe to all audio streams automatically.
   * - false: Do not subscribe to any audio stream automatically.
   */
  public Boolean autoSubscribeAudio;
  /**
   * Determines whether to subscribe to all video streams automatically.
   *
   * This member replaces calling {@link RtcEngine#setDefaultMuteAllRemoteVideoStreams
   * setDefaultMuteAllRemoteVideoStreams} before joining a channel.
   * - True: Subscribe to all video streams automatically.
   * - False: (default) Do not subscribe to any video stream automatically.
   */
  public Boolean autoSubscribeVideo;
  /**
   * Determines whether to enable audio recording or playout.
   * - true: It's used to publish audio and mix microphone, or subscribe audio and playout
   * - false: It's used to publish extenal audio frame only without mixing microphone, or no need
   * audio device to playout audio either
   */
  public Boolean enableAudioRecordingOrPlayout;
  /**
   * The client role type:
   * - `CLIENT_ROLE_BROADCASTER`(1): The broadcaster, who can both send and receive streams.
   * - `CLIENT_ROLE_AUDIENCE`(2): (Default) The audience, who can only receive streams.
   */
  public Integer clientRoleType;
  /**
   * The audience latency level type:
   * - `AUDIENCE_LATENCY_LEVEL_LOW_LATENCY`(1): Low latency. A low latency audience's play out
   * latency is 1.5 second.
   * - `AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY`(2): (Default) Ultra low latency. An ultra low
   * latency audience's play out latency is 0.5 second.
   */
  public Integer audienceLatencyLevel;
  /**
   * The default video stream type to subscribe to:
   * - `VIDEO_STREAM_HIGH`(0): (Default) The high-stream video, that is, the video stream featuring
   * in high resolution and high bitrate.
   * - `VIDEO_STREAM_LOW`(1): The low-stream video, that is, the video stream featuring in low
   * resolution and low bitrate.
   */
  public Integer defaultVideoStreamType;
  /**
   * The channel profile:
   * - `CHANNEL_PROFILE_COMMUNICATION`(0): Communication.
   * Use this profile in one-on-one calls or group calls, where all users can talk freely.
   * - `CHANNEL_PROFILE_LIVE_BROADCASTING`(1): (Default) Live Broadcast.
   * Users in a live-broadcast channel has a role as either broadcaster or audience.
   * A broadcaster can both send and receive streams; an audience can only receive streams.
   * - `CHANNEL_PROFILE_GAME`(2): Gaming.
   * This profile uses a codec with a low bitrate and consumes less power. Applies to the gaming
   * scenario, where all game players can talk freely.
   */
  public Integer channelProfile;
  /**
   * The delay in ms for sending audio frames. This is used for explicit control of A/V sync.
   * To switch off the delay, set the value to zero.
   */
  public Integer audioDelayMs;
  /**
   * The token to be renewed
   */
  public String token;
  /**
   * Enable media packet encryption.
   * This parameter is ignored when calling function updateChannelMediaOptions()
   */
  public Boolean enableBuiltInMediaEncryption;
  /**
   * The sender option for video encoded track.
   */
  public EncodedVideoTrackOptions encodedVideoTrackOption;
  /**
   * Determines the source id of the custom audio, default is 0.
   */
  public Integer publishCustomAudioSourceId;

  public AudioOptionsAdvanced audioOptionsAdvanced = new AudioOptionsAdvanced();

  public ChannelMediaOptions() {}

  public ChannelMediaOptions(Integer clientRoleType) {
    this.clientRoleType = clientRoleType;
  }

  @CalledByNative
  public Boolean isPublishCameraTrack() {
    return publishCameraTrack;
  }

  @CalledByNative
  public Boolean isPublishSecondaryCameraTrack() {
    return publishSecondaryCameraTrack;
  }

  @CalledByNative
  public Boolean isPublishScreenTrack() {
    return publishScreenTrack;
  }

  @CalledByNative
  public Boolean isPublishCustomAudioTrack() {
    return publishCustomAudioTrack;
  }

  @CalledByNative
  public Boolean isPublishCustomAudioTrackEnableAec() {
    return publishCustomAudioTrackEnableAec;
  }

  @CalledByNative
  public Boolean isPublishCustomAudioTrackAec() {
    return publishCustomAudioTrackAec;
  }

  @CalledByNative
  public Boolean isPublishDirectCustomAudioTrack() {
    return publishDirectCustomAudioTrack;
  }

  @CalledByNative
  public Boolean isPublishCustomVideoTrack() {
    return publishCustomVideoTrack;
  }

  @CalledByNative
  public Boolean isPublishEncodedVideoTrack() {
    return publishEncodedVideoTrack;
  }

  @CalledByNative
  public Boolean isPublishMediaPlayerAudioTrack() {
    return publishMediaPlayerAudioTrack;
  }

  @CalledByNative
  public Boolean isPublishMediaPlayerVideoTrack() {
    return publishMediaPlayerVideoTrack;
  }

  @CalledByNative
  public Integer getPublishMediaPlayerId() {
    return publishMediaPlayerId;
  }

  @CalledByNative
  public Boolean isPublishAudioTrack() {
    return publishAudioTrack;
  }

  @CalledByNative
  public Boolean isAutoSubscribeAudio() {
    return autoSubscribeAudio;
  }

  @CalledByNative
  public Boolean isAutoSubscribeVideo() {
    return autoSubscribeVideo;
  }

  @CalledByNative
  public Boolean isEnableAudioRecordingOrPlayout() {
    return enableAudioRecordingOrPlayout;
  }

  @CalledByNative
  public Integer getClientRoleType() {
    return clientRoleType;
  }

  @CalledByNative
  public Integer getAudienceLatencyLevel() {
    return audienceLatencyLevel;
  }

  @CalledByNative
  public Integer getDefaultVideoStreamType() {
    return defaultVideoStreamType;
  }

  @CalledByNative
  public Integer getChannelProfile() {
    return channelProfile;
  }

  @CalledByNative
  public Integer getAudioDelayMs() {
    return audioDelayMs;
  }

  @CalledByNative
  public String getToken() {
    return token;
  }

  @CalledByNative
  public Boolean isEnableBuiltInMediaEncryption() {
    return enableBuiltInMediaEncryption;
  }

  @CalledByNative
  public Boolean getPublishRhythmPlayerTrack() {
    return publishRhythmPlayerTrack;
  }

  @CalledByNative
  public EncodedVideoTrackOptions getEncodedVideoTrackOption() {
    return encodedVideoTrackOption;
  }

  @CalledByNative
  public AudioOptionsAdvanced getAudioOptionsAdvanced() {
    return audioOptionsAdvanced;
  }

  @CalledByNative
  public Integer getPublishCustomAudioSourceId() {
    return publishCustomAudioSourceId;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("publishCameraTrack=").append(publishCameraTrack);
    sb.append(" publishSecondaryCameraTrack=").append(publishSecondaryCameraTrack);
    sb.append(" publishScreenTrack=").append(publishScreenTrack);
    sb.append(" publishCustomAudioTrack=").append(publishCustomAudioTrack);
    sb.append(" publishCustomAudioSourceId=").append(publishCustomAudioSourceId);
    sb.append(" publishCustomAudioTrackEnableAec=").append(publishCustomAudioTrackEnableAec);
    sb.append(" publishCustomAudioTrackAec=").append(publishCustomAudioTrackAec);
    sb.append(" publishCustomVideoTrack=").append(publishCustomVideoTrack);
    sb.append(" publishDirectCustomAudioTrack=").append(publishDirectCustomAudioTrack);
    sb.append(" publishEncodedVideoTrack=").append(publishEncodedVideoTrack);
    sb.append(" publishMediaPlayerAudioTrack=").append(publishMediaPlayerAudioTrack);
    sb.append(" publishMediaPlayerVideoTrack=").append(publishMediaPlayerVideoTrack);
    sb.append(" publishMediaPlayerId=").append(publishMediaPlayerId);
    sb.append(" publishAudioTrack=").append(publishAudioTrack);
    sb.append(" autoSubscribeAudio=").append(autoSubscribeAudio);
    sb.append(" autoSubscribeVideo=").append(autoSubscribeVideo);
    sb.append(" clientRoleType=").append(clientRoleType);
    sb.append(" audienceLatencyLevel=").append(audienceLatencyLevel);
    sb.append(" defaultVideoStreamType=").append(defaultVideoStreamType);
    sb.append(" channelProfile=").append(channelProfile);
    sb.append(" audioDelayMs=").append(audioDelayMs);
    sb.append(" enableBuiltInMediaEncryption=").append(enableBuiltInMediaEncryption);
    sb.append(" publishRhythmPlayerTrack=").append(publishRhythmPlayerTrack);
    sb.append(" AudioOptionsAdvanced=").append(audioOptionsAdvanced.toString());
    return sb.toString();
  }

  public static class AudioOptionsAdvanced {
    Boolean enableAecExternalForCustom;

    Boolean enableAECExternalForLoopback;

    @CalledByNative("AudioOptionsAdvanced")
    public Boolean isEnableAecExternalForLoopback() {
      return enableAECExternalForLoopback;
    }

    @CalledByNative("AudioOptionsAdvanced")
    public Boolean isEnableAecExternalForCustom() {
      return enableAecExternalForCustom;
    }

    @Override
    public String toString() {
      return "AudioOptionsAdvanced{"
          + "enableAECExternalForPushReverse=" + enableAecExternalForCustom
          + ", enableAECExternalForLoopback=" + enableAECExternalForLoopback + '}';
    }
  }
}
