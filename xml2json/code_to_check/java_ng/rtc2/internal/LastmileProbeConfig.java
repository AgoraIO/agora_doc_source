package io.agora.rtc2.internal;

/**
 * Last-mile probe configuration.
 */
public class LastmileProbeConfig {
  /**
   * Whether to probe the uplink quality of the last-mile network.
   * - true: Probe the quality of the uplink last-mile network.
   * - false: Do not probe the quality of the uplink last-mile network.
   */
  public boolean probeUplink;
  /**
   * Whether to probe the downlink quality of the last-mile network.
   * - true: Probe the quality of the downlink last-mile network.
   * - false: Do not probe the quality of the downlink last-mile network.
   */
  public boolean probeDownlink;
  /**
   * The expected maximum sending bitrate in bps in range of [100000, 5000000]. Agora recommends
   * setting this value according to the required bitrate of selected video profile.
   */
  public int expectedUplinkBitrate;
  /**
   * The expected maximum receive bitrate in bps in range of [100000, 5000000].
   */
  public int expectedDownlinkBitrate;

  public LastmileProbeConfig() {}
}
