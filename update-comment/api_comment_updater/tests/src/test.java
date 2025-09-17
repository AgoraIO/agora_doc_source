
public interface IAudioSpectrumObserver {
  /**
   * @brief Gets the statistics of a local audio spectrum.
   *
   * @details
   * After successfully calling `registerAudioSpectrumObserver` to implement the
   * `onLocalAudioSpectrum` callback in `IAudioSpectrumObserver` and calling
   * `enableAudioSpectrumMonitor` to enable audio spectrum monitoring, the SDK triggers this callback
   * as the time interval you set to report the received remote audio data spectrum before encoding.
   *
   * @param data The audio spectrum data of the local user. See `AudioSpectrumInfo`.
   *
   * @return
   * Whether the spectrum data is received:
   * - `true`: Spectrum data is received.
   * - `false`: No spectrum data is received.
   */
  @CalledByNative boolean onLocalAudioSpectrum(AudioSpectrumInfo data);

  /**
   * @brief Gets the remote audio spectrum.
   *
   * @details
   * After successfully calling `registerAudioSpectrumObserver` to implement the
   * `onRemoteAudioSpectrum` callback in the `IAudioSpectrumObserver` and calling
   * `enableAudioSpectrumMonitor` to enable audio spectrum monitoring, the SDK will trigger the
   * callback as the time interval you set to report the received remote audio data spectrum.
   *
   * @param userAudioSpectrumInfos The audio spectrum information of the remote user. See
   * `UserAudioSpectrumInfo`. The number of arrays is the number of remote users monitored by the SDK.
   * If the array is null, it means that no audio spectrum of remote users is detected.
   * @param spectrumNumber The number of remote users.
   *
   * @return
   * Whether the spectrum data is received:
   * - `true`: Spectrum data is received.
   * - `false`: No spectrum data is received.
   */
  @CalledByNative
  boolean onRemoteAudioSpectrum(UserAudioSpectrumInfo[] userAudioSpectrumInfos, int spectrumNumber);
}

public interface IAudioFrameObserver {
}

public abstract class RtcEngine {
  protected static RtcEngineImpl mInstance = null;
  /**
   * Gets the properties of an extension.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param key The key of the extension.
   *
   * @return JSON formatted string of property's value; return null if failed
   */
  public abstract String getExtensionProperty(String provider, String extension, String key);

  /**
   * @brief Gets detailed information on the extensions.
   *
   * @details
   * Call timing: This method can be called either before or after joining the channel.
   *
   * @param provider The name of the extension provider.
   * @param extension The name of the extension.
   * @param key The key of the extension.
   * @param sourceType Source type of the extension. See `MediaSourceType`.
   *
   * @return
   * - The extension information, if the method call succeeds.
   * - An empty string, if the method call fails.
   */
  public abstract String getExtensionProperty(
      String provider, String extension, String key, Constants.MediaSourceType sourceType);
}

public abstract class RtcEngineEx extends RtcEngine {
  /**
   * @brief Gets the call ID with the connection ID.
   *
   * @details
   * When a user joins a channel on a client, a `callId` is generated to identify the call from the
   * client. You can call this method to get `callId`, and pass it in when calling methods such as
   * `rate` and `complain`.
   * Call timing: Call this method after joining a channel.
   *
   * @param connection The connection information. See `RtcConnection`.
   *
   */
  public abstract String getCallIdEx(RtcConnection connection);
}