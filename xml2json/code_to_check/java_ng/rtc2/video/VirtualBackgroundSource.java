package io.agora.rtc2.video;

/**
 * Background substitude meta data.
 */
public class VirtualBackgroundSource {
  /**
   * 1: Background source is hex color string.
   */
  public static final int BACKGROUND_COLOR = 1;

  /**
   * 2: Background source is image path, only support png format.
   */
  public static final int BACKGROUND_IMG = 2;
  /**
   * 3: Background blur. blur your background, not including your body.
   */
  public static final int BACKGROUND_BLUR = 3;

  /**
   * blur degree low, have few blur effect
   */
  public static final int BLUR_DEGREE_LOW = 1;

  /**
   * blur degree medium, blur more than level 1
   */
  public static final int BLUR_DEGREE_MEDIUM = 2;

  /**
   * blur degree high, blur default, hard to find background
   */
  public static final int BLUR_DEGREE_HIGH = 3;

  /**
   * The source type used to substitude capture image background. {@link
   * io.agora.rtc.video.VirtualBackgroundSource#backgroundSourceType backgroundSourceType}: <ul>
   *     <li>{@link io.agora.rtc.video.VirtualBackgroundSource#BACKGROUND_NONE BACKGROUND_NONE(0)}:
   * background is none. <li>{@link io.agora.rtc.video.VirtualBackgroundSource#BACKGROUND_COLOR
   * BACKGROUND_COLOR(1)}: (default) background is color. <li>{@link
   * io.agora.rtc.video.VirtualBackgroundSource#BACKGROUND_IMG BACKGROUND_IMG(2)}: background is
   * image.
   * </ul>
   */
  public int backgroundSourceType;

  /** Background color value, for example: "#aabbcc" */
  public int color;

  /** Background image file path */
  public String source = null;

  /** Background blur degree */
  public int blurDegree;

  public VirtualBackgroundSource(
      int backgroundSourceType, int color, String source, int blurDegree) {
    this.backgroundSourceType = backgroundSourceType;
    this.color = color;
    this.source = source;
    this.blurDegree = blurDegree;
  }

  public VirtualBackgroundSource() {
    this.backgroundSourceType = BACKGROUND_COLOR;
    this.color = 0xffffff;
    this.source = "";
    this.blurDegree = BLUR_DEGREE_HIGH;
  }
}
