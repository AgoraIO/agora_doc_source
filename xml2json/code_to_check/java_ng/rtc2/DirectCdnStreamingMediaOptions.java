package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

/**
 * The channel media options.
 */
public class DirectCdnStreamingMediaOptions {
  /**
   * Determines whether to publish the video of the camera track.
   * - true: (Default) Publish the video track of the camera capturer.
   * - false: Do not publish the video track of the camera capturer.
   */
  public Boolean publishCameraTrack;
  /**
   * Determines whether to publish the audio of the Microphonetrack.
   * - true: Publish the audio of the Microphone track.
   * - false: (Default) Do not publish the audio of the Microphone track.
   */
  public Boolean publishMicrophoneTrack;
  /**
   * Determines whether to publish the audio of the custom audio track.
   * - true: Publish the audio of the custom audio track.
   * - false: (Default) Do not publish the audio of the custom audio track.
   */
  public Boolean publishCustomAudioTrack;
  /**
   * Determines whether to publish the video of the custom video track.
   * - true: Publish the video of the custom video track.
   * - false: (Default) Do not publish the video of the custom video track.
   */
  public Boolean publishCustomVideoTrack;

  public DirectCdnStreamingMediaOptions() {
    publishCameraTrack = false;
    publishMicrophoneTrack = false;
    publishCustomAudioTrack = false;
    publishCustomVideoTrack = false;
  }

  @CalledByNative
  public Boolean isPublishCameraTrack() {
    return publishCameraTrack;
  }

  @CalledByNative
  public Boolean isPublishMicrophoneTrack() {
    return publishMicrophoneTrack;
  }

  @CalledByNative
  public Boolean isPublishCustomAudioTrack() {
    return publishCustomAudioTrack;
  }

  @CalledByNative
  public Boolean isPublishCustomVideoTrack() {
    return publishCustomVideoTrack;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("publishCameraTrack=").append(publishCameraTrack);
    sb.append(" publishMicrophoneTrack=").append(publishMicrophoneTrack);
    sb.append(" publishCustomAudioTrack=").append(publishCustomAudioTrack);
    sb.append(" publishCustomVideoTrack=").append(publishCustomVideoTrack);

    return sb.toString();
  }
}