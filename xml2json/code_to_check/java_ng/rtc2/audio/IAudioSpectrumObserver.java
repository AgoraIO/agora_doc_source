package io.agora.rtc2.audio;

import io.agora.base.internal.CalledByNative;
import io.agora.rtc2.RtcEngine;

/**
 * The IAudioSpectrumObserver interface.
 */
public interface IAudioSpectrumObserver {
  /**
   * Reports the audio spectrum of audio recording.
   *
   * This callback reports the audio spectrum data of the audio recording at the moment
   * in the channel.
   *
   * You can set the time interval of this callback using {@link
   * RtcEngine#enableAudioSpectrumMonitor(int)}.
   *
   * @param data The audio spectrum data of audio recording.
   * - true: Processed.
   * - false: Not processed.
   */
  @CalledByNative boolean onLocalAudioSpectrum(AudioSpectrumInfo data);

  /**
   * Reports the audio spectrum of remote user.
   *
   * This callback reports the IDs and audio spectrum data of the loudest speakers at the moment
   * in the channel.
   *
   * You can set the time interval of this callback using {@link
   * RtcEngine#enableAudioSpectrumMonitor(int)}..
   *
   * @param userAudioSpectrumInfos The pointer to \ref agora::media::AudioSpectrumInfo
   *     "AudioSpectrumInfo",
   *                  which is an array containing
   * the user ID and audio spectrum data for each speaker.
   * - This array contains the following members:
   *   - `uid`, which is the UID of each remote speaker
   *   - `audioSpectrumData`, which reports the audio spectrum of each remote speaker.
   *   - `spectrumDataLength`, the length of audio spectrum data.
   * @param spectrumNumber The array length of the audioSpectrumInfoList.
   * - true: Processed.
   * - false: Not processed.
   */
  @CalledByNative
  boolean onRemoteAudioSpectrum(UserAudioSpectrumInfo[] userAudioSpectrumInfos, int spectrumNumber);
}
