package io.agora.rtc2.audio;

import io.agora.base.internal.CalledByNative;

public class UserAudioSpectrumInfo {
  private int uid;
  private AudioSpectrumInfo audioSpectrumInfo;

  /**
   *
   * @param uid which is the UID of each remote speaker
   * @param audioSpectrumInfo which reports the audio spectrum of each remote speaker.
   */
  @CalledByNative
  public UserAudioSpectrumInfo(int uid, AudioSpectrumInfo audioSpectrumInfo) {
    this.uid = uid;
    this.audioSpectrumInfo = audioSpectrumInfo;
  }

  public int getUid() {
    return uid;
  }

  public AudioSpectrumInfo getAudioSpectrumInfo() {
    return audioSpectrumInfo;
  }
}
