package io.agora.rtc2;

import io.agora.base.internal.CalledByNative;

/**
 * The leave channel options.
 */
public class LeaveChannelOptions {
  /**
   * Determines whether to stop playing and mixing the music file when leave channel.
   * - true: (Default) Stop playing and mixing the music file.
   * - false: Do not stop playing and mixing the music file.
   */
  public boolean stopAudioMixing;

  /**
   * Determines whether to stop all music effects when leave channel.
   * - true: (Default) Stop all music effects.
   * - false: Do not stop the music effect.
   */
  public boolean stopAllEffect;

  /**
   * Determines whether to stop microphone recording when leave channel.
   * - true: (Default) Stop microphone recording.
   * - false: Do not stop microphone recording.
   */
  public boolean stopMicrophoneRecording;

  public LeaveChannelOptions() {
    stopAudioMixing = true;
    stopAllEffect = true;
    stopMicrophoneRecording = true;
  }

  @CalledByNative
  public boolean isStopAudioMixing() {
    return stopAudioMixing;
  }

  @CalledByNative
  public boolean isStopAllEffect() {
    return stopAllEffect;
  }

  @CalledByNative
  public boolean isStopMicrophoneRecording() {
    return stopMicrophoneRecording;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("stopAudioMixing=").append(stopAudioMixing);
    sb.append("stopAllEffect=").append(stopAllEffect);
    sb.append("stopMicrophoneRecording=").append(stopMicrophoneRecording);
    return sb.toString();
  }
}
