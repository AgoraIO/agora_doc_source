package io.agora.rtc2.audio;

import io.agora.base.internal.CalledByNative;

public class AudioSpectrumInfo {
  private float[] audioSpectrumData;
  private int dataLength;

  /**
   * @param audioSpectrumData which reports the audio spectrum of each remote speaker.
   * @param dataLength the length of audio spectrum data.
   */
  @CalledByNative
  public AudioSpectrumInfo(float[] audioSpectrumData, int dataLength) {
    this.audioSpectrumData = audioSpectrumData;
    this.dataLength = dataLength;
  }

  public float[] getAudioSpectrumData() {
    return audioSpectrumData;
  }

  public int getDataLength() {
    return dataLength;
  }
}
