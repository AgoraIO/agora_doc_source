package io.agora.rtc2.video;

/**
 * Sets the image enhancement options.
 */
public class BeautyOptions {
  /**
   * 0: low contrast for lightening.
   */
  public static final int LIGHTENING_CONTRAST_LOW = 0;

  /**
   * 1: normal contrast for lightening.
   */
  public static final int LIGHTENING_CONTRAST_NORMAL = 1;

  /**
   * 2: high contrast for lightening.
   */
  public static final int LIGHTENING_CONTRAST_HIGH = 2;

  /**
   * The lightening contrast level, used with {@link
   * io.agora.rtc2.video.BeautyOptions#lighteningLevel lighteningLevel}: <ul> <li>{@link
   * io.agora.rtc2.video.BeautyOptions#LIGHTENING_CONTRAST_LOW LIGHTENING_CONTRAST_LOW(0)}: low
   * contrast level. <li>{@link io.agora.rtc2.video.BeautyOptions#LIGHTENING_CONTRAST_NORMAL
   * LIGHTENING_CONTRAST_NORMAL(1)}: (default) normal contrast level. <li>{@link
   * io.agora.rtc2.video.BeautyOptions#LIGHTENING_CONTRAST_HIGH LIGHTENING_CONTRAST_HIGH(2)}: high
   * contrast level.
   * </ul>
   */
  public int lighteningContrastLevel;

  /**
   * The brightness level. The value ranges between 0.0 (original) and 1.0. The default value is
   * 0.6.
   */
  public float lighteningLevel;

  /**
   * The smoothness level. The value ranges between 0.0 (original) and 1.0. The default value is
   * 0.5. This parameter is usually used to remove blemishes.
   */
  public float smoothnessLevel;

  /**
   * The redness level. The value ranges between 0.0 (original) and 1.0. The default value is 0.1.
   * This parameter adjusts the red saturation level.
   */
  public float rednessLevel;

  /**
   * The smoothness level. The value ranges between 0.0 (original) and 1.0. The default value is
   * 0.3.
   */
  public float sharpnessLevel;

  /**
   * The image enhancement options.
   *
   * @param contrastLevel The contrast level, used with the {@link
   *     io.agora.rtc2.video.BeautyOptions#lighteningLevel lighteningLevel} parameter:
   * <ul>
   *     <li>{@link io.agora.rtc2.video.BeautyOptions#LIGHTENING_CONTRAST_LOW
   * LIGHTENING_CONTRAST_LOW(0)}: low contrast level. <li>{@link
   * io.agora.rtc2.video.BeautyOptions#LIGHTENING_CONTRAST_NORMAL LIGHTENING_CONTRAST_NORMAL(1)}:
   * (default) normal contrast level. <li>{@link
   * io.agora.rtc2.video.BeautyOptions#LIGHTENING_CONTRAST_HIGH LIGHTENING_CONTRAST_HIGH(2)}: high
   * contrast level.
   * </ul>
   * @param lightening The brightness level. The value ranges from 0.0 (original) to 1.0. The
   *     default value is 0.7.
   * @param smoothness  The sharpness level. The value ranges from 0.0 (original) to 1.0. The
   *     default value is 0.5. This parameter is usually used to remove blemishes.
   * @param redness The redness level. The value ranges from 0.0 (original) to 1.0. The default
   *     value is 0.1. This parameter adjusts the red saturation level.
   */
  public BeautyOptions(
      int contrastLevel, float lightening, float smoothness, float redness, float sharpness) {
    this.lighteningContrastLevel = contrastLevel;
    this.lighteningLevel = lightening;
    this.smoothnessLevel = smoothness;
    this.rednessLevel = redness;
    this.sharpnessLevel = sharpness;
  }

  public BeautyOptions() {
    this.lighteningContrastLevel = LIGHTENING_CONTRAST_NORMAL;
    this.lighteningLevel = 0.6f;
    this.smoothnessLevel = 0.5f;
    this.rednessLevel = 0.1f;
    this.sharpnessLevel = 0.3f;
  }
}
