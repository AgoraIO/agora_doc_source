package io.agora.rtc2.video;
/**
 * The video encoder configuration.
 */
public class VideoEncoderConfiguration {
  /**
   * The video dimensions.
   */
  static public class VideoDimensions {
    /**
     * The width of the video.
     */
    public int width;
    /**
     * The height of the video.
     */
    public int height;

    public VideoDimensions(int width, int height) {
      this.width = width;
      this.height = height;
    }

    public VideoDimensions() {
      this.width = 0;
      this.height = 0;
    }
  }
  /**
   * VD_120x120: The video resolution is 120 &times; 120.
   */
  public final static VideoDimensions VD_120x120 = new VideoDimensions(120, 120);
  /**
   * VD_160x120: The video resolution is 160 &times; 120.
   */
  public final static VideoDimensions VD_160x120 = new VideoDimensions(160, 120);
  /**
   * VD_180x180: The video resolution is 180 &times; 180.
   */
  public final static VideoDimensions VD_180x180 = new VideoDimensions(180, 180);
  /**
   * VD_240x180: The video resolution is 240 &times; 180.
   */
  public final static VideoDimensions VD_240x180 = new VideoDimensions(240, 180);
  /**
   * VD_320x180: The video resolution is 320 &times; 180.
   */
  public final static VideoDimensions VD_320x180 = new VideoDimensions(320, 180);
  /**
   * VD_240x240: The video resolution is 240 &times; 240.
   */
  public final static VideoDimensions VD_240x240 = new VideoDimensions(240, 240);
  /**
   * VD_320x240: The video resolution is 320 &times; 240.
   */
  public final static VideoDimensions VD_320x240 = new VideoDimensions(320, 240);
  /**
   * VD_424x240: The video resolution is 424 &times; 240.
   */
  public final static VideoDimensions VD_424x240 = new VideoDimensions(424, 240);
  /**
   * VD_360x360: The video resolution is 360 &times; 360.
   */
  public final static VideoDimensions VD_360x360 = new VideoDimensions(360, 360);
  /**
   * VD_480x360: The video resolution is 480 &times; 360.
   */
  public final static VideoDimensions VD_480x360 = new VideoDimensions(480, 360);
  /**
   * VD_640x360: The video resolution is 640 &times; 360.
   */
  public final static VideoDimensions VD_640x360 = new VideoDimensions(640, 360);
  /**
   * VD_480x480: The video resolution is 480 &times; 480.
   */
  public final static VideoDimensions VD_480x480 = new VideoDimensions(480, 480);
  /**
   * VD_640x480: The video resolution is 640 &times; 480.
   */
  public final static VideoDimensions VD_640x480 = new VideoDimensions(640, 480);
  /**
   * VD_840x480: The video resolution is 840 &times; 480.
   */
  public final static VideoDimensions VD_840x480 = new VideoDimensions(840, 480);
  /**
   * VD_960x720: The video resolution is 640 &times; 360.
   */
  public final static VideoDimensions VD_960x720 = new VideoDimensions(960, 720);
  /**
   * VD_1280x720: The video resolution is 640 &times; 360.
   */
  public final static VideoDimensions VD_1280x720 = new VideoDimensions(1280, 720);
  /**
   * Not supported.
   */
  public final static VideoDimensions VD_1920x1080 = new VideoDimensions(1920, 1080);
  /**
   * Not supported.
   */
  public final static VideoDimensions VD_2540x1440 = new VideoDimensions(2540, 1440);
  /**
   * Not supported.
   */
  public final static VideoDimensions VD_3840x2160 = new VideoDimensions(3840, 2160);

  /**
   * The frame rate of the video.
   */
  public enum FRAME_RATE {
    /**
     * 1: 1 fps.
     */
    FRAME_RATE_FPS_1(1),
    /**
     * 7: 7 fps.
     */
    FRAME_RATE_FPS_7(7),
    /**
     * 10: 10 fps.
     */
    FRAME_RATE_FPS_10(10),
    /**
     * 15: 15 fps.
     */
    FRAME_RATE_FPS_15(15),
    /**
     * 24: 24 fps.
     */
    FRAME_RATE_FPS_24(24),
    /**
     * 30: 30 fps.
     */
    FRAME_RATE_FPS_30(30),
    /**
     * Not supported.
     */
    FRAME_RATE_FPS_60(60);

    private int value;
    private FRAME_RATE(int v) {
      value = v;
    }

    public int getValue() {
      return this.value;
    }
  }
  /**
   * The video orientation mode of the video.
   */
  public enum ORIENTATION_MODE {
    /**
     * 0: (Default) The adaptive mode.
     *
     * The output video always follows the orientation of the captured video, because the receiver
     * takes the rotational information passed on from the video encoder. Mainly used between
     * Agora’s SDKs.</p> If the captured video is in landscape mode, the output video is in
     * landscape mode. If the captured video is in portrait mode, the output video is in portrait
     * mode.
     */
    ORIENTATION_MODE_ADAPTIVE(0),
    /**
     * 1. The landscape mode.
     *
     * The output video is always in landscape mode. If the captured video is in portrait mode, the
     * video encoder crops it to fit the output. Applies to situations where the receiving end
     * cannot process the rotational information. For example, CDN live streaming.
     */
    ORIENTATION_MODE_FIXED_LANDSCAPE(1),
    /**
     * 2. The portrait mode.
     *
     * The output video is always in portrait mode. If the captured video is in landscape mode, the
     * video encoder crops it to fit the output. Applies to situations where the receiving end
     * cannot process the rotational information. For example, CDN live streaming.
     */
    ORIENTATION_MODE_FIXED_PORTRAIT(2);

    private int value;
    private ORIENTATION_MODE(int v) {
      value = v;
    }

    public int getValue() {
      return this.value;
    }
  }

  /**
   * The video encoding degradation preference under limited bandwidth.
   */
  public enum DEGRADATION_PREFERENCE {
    /**
     * 0: (Default) Degrade the frame rate and keep resolution to guarantee the video quality.
     */
    MAINTAIN_QUALITY(0),
    /**
     * 1: Degrade resolution in order to maintain framerate.
     */
    MAINTAIN_FRAMERATE(1),
    /**
     * 2: Maintain resolution in video quality control process. Under limited bandwidth, degrade
     * video quality first and then degrade frame rate.
     */
    MAINTAIN_BALANCED(2),
    /**
     * 3: Degrade framerate in order to maintain resolution.
     */
    MAINTAIN_RESOLUTION(3),
    /**
     * 4: Disabled VQC adjustion.
     */
    DISABLED(100);

    private int value;

    private DEGRADATION_PREFERENCE(int v) {
      value = v;
    }

    public int getValue() {
      return this.value;
    }
  }

  /**
   * Video mirror mode types.
   */
  public enum MIRROR_MODE_TYPE {
    /**
     * (Default) 0: The mirror mode determined by the SDK.
     */
    MIRROR_MODE_AUTO(0),
    /**
     * 1: Enable the mirror mode.
     */
    MIRROR_MODE_ENABLED(1),
    /**
     * 2: Disable the mirror mode.
     */
    MIRROR_MODE_DISABLED(2);

    private int value;

    private MIRROR_MODE_TYPE(int v) {
      value = v;
    }

    public int getValue() {
      return this.value;
    }
  }

  /**
   * 0: The standard bitrate mode. In this mode, the bitrates under the Live Broadcast and
   * Communication profiles differ:
   * - In the Communication profile, the video bitrate is the same as the base bitrate.
   * - In the Live Broadcast profile, the video bitrate is twice the base bitrate.
   */
  public static final int STANDARD_BITRATE = 0;
  /**
   * -1: The compatible bitrate mode. In this mode, the bitrate stays the same regardless of the
   * profile. If you choose this mode for the Live Broadcast profile, the video frame rate may be
   * lower than the set value.
   */
  public static final int COMPATIBLE_BITRATE = -1;

  /**
   * (For future use) Use the default minimum bitrate.
   */
  public static final int DEFAULT_MIN_BITRATE = -1;

  /**
   * (For future use) The default minimum frame rate.
   */
  public static final int DEFAULT_MIN_FRAMERATE = -1;

  /**
   * -2: (For future use) Set minimum bitrate the same as target bitrate.
   */
  public static final int DEFAULT_MIN_BITRATE_EQUAL_TO_TARGET_BITRATE = -2;

  /**
   * The video frame dimensions (px), which is used to specify the video quality and measured by the
   * total number of pixels along a frame's width and height. The default value is 640 &times; 360.
   * Users can either set the resolution manually or choose from the following options:
   * - {@link VideoEncoderConfiguration#VD_120x120 VD_120x120}.
   * - {@link VideoEncoderConfiguration#VD_160x120 VD_160x120}.
   * - {@link VideoEncoderConfiguration#VD_180x180 VD_180x180}.
   * - {@link VideoEncoderConfiguration#VD_240x180 VD_240x180}.
   * - {@link VideoEncoderConfiguration#VD_320x180 VD_320x180}.
   * - {@link VideoEncoderConfiguration#VD_240x240 VD_240x240}.
   * - {@link VideoEncoderConfiguration#VD_320x240 VD_320x240}.
   * - {@link VideoEncoderConfiguration#VD_424x240 VD_424x240}.
   * - {@link VideoEncoderConfiguration#VD_360x360 VD_360x360}.
   * - {@link VideoEncoderConfiguration#VD_480x360 VD_480x360}.
   * - {@link VideoEncoderConfiguration#VD_640x360 VD_640x360}.
   * - {@link VideoEncoderConfiguration#VD_480x480 VD_480x480}.
   * - {@link VideoEncoderConfiguration#VD_640x480 VD_640x480}.
   * - {@link VideoEncoderConfiguration#VD_840x480 VD_840x480}.
   * - {@link VideoEncoderConfiguration#VD_960x720 VD_960x720}.
   * - {@link VideoEncoderConfiguration#VD_1280x720 VD_1280x720}.
   *
   * @note
   * - The value of the dimension does not indicate the orientation mode of the output ratio. For
   * how to set the video orientation, see {@link ORIENTATION_MODE ORIENTATION_MODE}.
   * - Whether 720p+ can be supported depends on the device. If the device cannot support 720p, the
   * frame rate will be lower than the one listed in the table.
   */
  public VideoDimensions dimensions;
  /**
   * The video frame rate (fps). The default value is 15. Users can either set the frame rate
   * manually or choose from the following options. We do not recommend setting this to a value
   * greater than 30.
   * - {@link FRAME_RATE#FRAME_RATE_FPS_1 FRAME_RATE_FPS_1(1)}.
   * - {@link FRAME_RATE#FRAME_RATE_FPS_7 FRAME_RATE_FPS_7(7)}.
   * - {@link FRAME_RATE#FRAME_RATE_FPS_10 FRAME_RATE_FPS_10(10)}.
   * - {@link FRAME_RATE#FRAME_RATE_FPS_15 FRAME_RATE_FPS_15(15)}.
   * - {@link FRAME_RATE#FRAME_RATE_FPS_24 FRAME_RATE_FPS_24(24)}.
   * - {@link FRAME_RATE#FRAME_RATE_FPS_30 FRAME_RATE_FPS_30(30)}.
   * - {@link FRAME_RATE#FRAME_RATE_FPS_60 FRAME_RATE_FPS_60(60)}.
   */
  public int frameRate;

  /**
   * (For future use) The minimum video encoder frame rate (fps). The default value is {@link
   * VideoEncoderConfiguration#DEFAULT_MIN_FRAMERATE DEFAULT_MIN_FRAMERATE(-1)}
   * (the SDK uses the lowest encoder frame rate).
   *
   */
  public int minFrameRate;
  /**
   * The bitrate of the video (Kbps). Refer to the table below and set your bitrate. If you set a
   * bitrate beyond the proper range, the SDK automatically adjusts it to a value within the range.
   * You can also choose from the following options:
   * - STANDARD_BITRATE(0): (Recommended) The standard bitrate mode. In this mode, the bitrates
   * differ between the Live Broadcast and Communication profiles:
   *   - In the Communication profile, the video bitrate is the same as the base bitrate.
   *   - In the Live Broadcast profile, the video bitrate is twice the base bitrate.
   * - COMPATIBLE_BITRATE(-1): The compatible bitrate mode. In this mode, the bitrate stays the same
   * regardless of the profile. If you choose this mode for the Live Broadcast profile, the video
   * frame rate may be lower than the set value.
   *
   * Agora uses different video codecs for different profiles to optimize the user experience. For
   * example, the Communication profile prioritizes the smoothness while the Live Broadcast profile
   * prioritizes the video quality (a higher bitrate). Therefore, We recommend setting this
   * parameter as {@link VideoEncoderConfiguration#STANDARD_BITRATE STANDARD_BITRATE = 0}.
   *
   * **Video Bitrate Table**
   * <table>
   *     <tr>
   *         <th>Resolution</th>
   *         <th>Frame rate（fps）</th>
   *         <th>Base Bitrate (Kbps, for Communication)</th>
   *         <th>Live Bitrate (Kbps, for Live Broadcast)</th>
   *     </tr>
   *     <tr>
   *         <td>160 &times; 120</td>
   *         <td>15</td>
   *         <td>65</td>
   *         <td>130</td>
   *     </tr>
   *     <tr>
   *         <td>120 &times; 120</td>
   *         <td>15</td>
   *         <td>50</td>
   *         <td>100</td>
   *     </tr>
   *     <tr>
   *         <td>320 &times; 180</td>
   *         <td>15</td>
   *         <td>140</td>
   *         <td>280</td>
   *     </tr>
   *     <tr>
   *         <td>180 &times; 180</td>
   *         <td>15</td>
   *         <td>100</td>
   *         <td>200</td>
   *     </tr>
   *     <tr>
   *         <td>240 &times; 180</td>
   *         <td>15</td>
   *         <td>120</td>
   *         <td>240</td>
   *     </tr>
   *     <tr>
   *         <td>320 &times; 240</td>
   *         <td>15</td>
   *         <td>200</td>
   *         <td>400</td>
   *     </tr>
   *     <tr>
   *         <td>240 &times; 240</td>
   *         <td>15</td>
   *         <td>140</td>
   *         <td>280</td>
   *     </tr>
   *     <tr>
   *         <td>424 &times; 240</td>
   *         <td>15</td>
   *         <td>220</td>
   *         <td>440</td>
   *     </tr>
   *     <tr>
   *         <td>640 &times; 360</td>
   *         <td>15</td>
   *         <td>400</td>
   *         <td>800</td>
   *     </tr>
   *     <tr>
   *         <td>360 &times; 360</td>
   *         <td>15</td>
   *         <td>260</td>
   *         <td>520</td>
   *     </tr>
   *     <tr>
   *         <td>640 &times; 360</td>
   *         <td>30</td>
   *         <td>600</td>
   *         <td>1200</td>
   *     </tr>
   *     <tr>
   *         <td>360 &times; 360</td>
   *         <td>30</td>
   *         <td>400</td>
   *         <td>800</td>
   *     </tr>
   *     <tr>
   *         <td>480 &times; 360</td>
   *         <td>15</td>
   *         <td>320</td>
   *         <td>640</td>
   *     </tr>
   *     <tr>
   *         <td>480 &times; 360</td>
   *         <td>30</td>
   *         <td>490</td>
   *         <td>980</td>
   *     </tr>
   *     <tr>
   *         <td>640 &times; 480</td>
   *         <td>15</td>
   *         <td>500</td>
   *         <td>1000</td>
   *     </tr>
   *     <tr>
   *         <td>480 &times; 480</td>
   *         <td>15</td>
   *         <td>400</td>
   *         <td>800</td>
   *     </tr>
   *     <tr>
   *         <td>640 &times; 480</td>
   *         <td>30</td>
   *         <td>750</td>
   *         <td>1500</td>
   *     </tr>
   *     <tr>
   *         <td>480 &times; 480</td>
   *         <td>30</td>
   *         <td>600</td>
   *         <td>1200</td>
   *     </tr>
   *     <tr>
   *         <td>848 &times; 480</td>
   *         <td>15</td>
   *         <td>610</td>
   *         <td>1220</td>
   *     </tr>
   *     <tr>
   *         <td>848 &times; 480</td>
   *         <td>30</td>
   *         <td>930</td>
   *         <td>1860</td>
   *     </tr>
   *     <tr>
   *         <td>640 &times; 480</td>
   *         <td>10</td>
   *         <td>400</td>
   *         <td>800</td>
   *     </tr>
   *     <tr>
   *         <td>1280 &times; 720</td>
   *         <td>15</td>
   *         <td>1130</td>
   *         <td>2260</td>
   *     </tr>
   *     <tr>
   *         <td>1280 &times; 720</td>
   *         <td>30</td>
   *         <td>1710</td>
   *         <td>3420</td>
   *     </tr>
   *     <tr>
   *         <td>960 &times; 720</td>
   *         <td>15</td>
   *         <td>910</td>
   *         <td>1820</td>
   *     </tr>
   *     <tr>
   *         <td>960 &times; 720</td>
   *         <td>30</td>
   *         <td>1380</td>
   *         <td>2760</td>
   *     </tr>
   * </table>
   *
   * @note
   * The base bitrate in this table applies to the Communication profile. The Live Broadcast profile
   * generally requires a higher bitrate for better video quality. We recommend setting the bitrate
   * mode as {@link VideoEncoderConfiguration#STANDARD_BITRATE STANDARD_BITRATE = 0}. You can also
   * set the bitrate as the base bitrate value &times; 2.
   *
   */
  public int bitrate;

  /**
   * (For future use) The minimum encoding bitrate (Kbps).
   * The Agora SDK automatically adjusts the encoding bitrate to adapt to the network conditions.
   * Using a value greater than the default value forces the video encoder to output high-quality
   * images but may cause more packet loss and hence sacrifice the smoothness of the video
   * transmission. That said, unless you have special requirements for image quality, Agora does not
   * recommend changing this value.
   *
   * @note
   * This parameter applies to the Live Broadcast profile only.
   *
   */
  public int minBitrate;
  /**
   * The orientation mode.
   * See {@link ORIENTATION_MODE ORIENTATION_MODE}.
   */
  public ORIENTATION_MODE orientationMode;

  /**
   * The video encoding degradation preference under limited bandwidth: {@link
   * DEGRADATION_PREFERENCE DEGRADATION_PREFERENCE}.
   *
   * Currently, this member supports `MAINTAIN_QUALITY`(0) only.
   */
  public DEGRADATION_PREFERENCE degradationPrefer;

  /**
   * If mirror_type is set to VIDEO_MIRROR_MODE_ENABLED, then the video frame would be mirrored
   * before encoding.
   */
  public MIRROR_MODE_TYPE mirrorMode;

  public VideoEncoderConfiguration() {
    this.dimensions = new VideoDimensions(640, 480);
    this.frameRate = FRAME_RATE.FRAME_RATE_FPS_15.getValue();
    this.minFrameRate = DEFAULT_MIN_FRAMERATE;
    this.bitrate = STANDARD_BITRATE;
    this.minBitrate = DEFAULT_MIN_BITRATE;
    this.orientationMode = ORIENTATION_MODE.ORIENTATION_MODE_ADAPTIVE;
    this.degradationPrefer = DEGRADATION_PREFERENCE.MAINTAIN_QUALITY;
    this.mirrorMode = MIRROR_MODE_TYPE.MIRROR_MODE_DISABLED;
  }

  public VideoEncoderConfiguration(VideoDimensions dimensions, FRAME_RATE frameRate, int bitrate,
      ORIENTATION_MODE orientationMode) {
    this.dimensions = dimensions;
    this.frameRate = frameRate.getValue();
    this.minFrameRate = DEFAULT_MIN_FRAMERATE;
    this.bitrate = bitrate;
    this.minBitrate = DEFAULT_MIN_BITRATE;
    this.orientationMode = orientationMode;
    this.degradationPrefer = DEGRADATION_PREFERENCE.MAINTAIN_QUALITY;
    this.mirrorMode = MIRROR_MODE_TYPE.MIRROR_MODE_DISABLED;
  }

  public VideoEncoderConfiguration(VideoDimensions dimensions, FRAME_RATE frameRate, int bitrate,
      ORIENTATION_MODE orientationMode, MIRROR_MODE_TYPE mirrorMode) {
    this.dimensions = dimensions;
    this.frameRate = frameRate.getValue();
    this.minFrameRate = DEFAULT_MIN_FRAMERATE;
    this.bitrate = bitrate;
    this.minBitrate = DEFAULT_MIN_BITRATE;
    this.orientationMode = orientationMode;
    this.degradationPrefer = DEGRADATION_PREFERENCE.MAINTAIN_QUALITY;
    this.mirrorMode = mirrorMode;
  }

  public VideoEncoderConfiguration(
      int width, int height, FRAME_RATE frameRate, int bitrate, ORIENTATION_MODE orientationMode) {
    this.dimensions = new VideoDimensions(width, height);
    this.frameRate = frameRate.getValue();
    this.minFrameRate = DEFAULT_MIN_FRAMERATE;
    this.bitrate = bitrate;
    this.minBitrate = DEFAULT_MIN_BITRATE;
    this.orientationMode = orientationMode;
    this.degradationPrefer = DEGRADATION_PREFERENCE.MAINTAIN_QUALITY;
    this.mirrorMode = MIRROR_MODE_TYPE.MIRROR_MODE_DISABLED;
  }

  public VideoEncoderConfiguration(int width, int height, FRAME_RATE frameRate, int bitrate,
      ORIENTATION_MODE orientationMode, MIRROR_MODE_TYPE mirrorMode) {
    this.dimensions = new VideoDimensions(width, height);
    this.frameRate = frameRate.getValue();
    this.minFrameRate = DEFAULT_MIN_FRAMERATE;
    this.bitrate = bitrate;
    this.minBitrate = DEFAULT_MIN_BITRATE;
    this.orientationMode = orientationMode;
    this.degradationPrefer = DEGRADATION_PREFERENCE.MAINTAIN_QUALITY;
    this.mirrorMode = mirrorMode;
  }
}
