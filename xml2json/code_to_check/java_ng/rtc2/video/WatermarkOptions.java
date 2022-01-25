package io.agora.rtc2.video;

/**
 * Agora watermark options.
 * A class for setting the properties of watermark.
 */
public class WatermarkOptions {
  /**
   * The position and size of the watermark image.
   */
  public static class Rectangle {
    /**
     * The horizontal offset from the top-left corner.
     */
    public int x = 0;
    /**
     * The vertical offset from the top-left corner.
     */
    public int y = 0;
    /**
     * The width (pixels) of the watermark image.
     */
    public int width = 0;
    /**
     * The height (pixels) of the watermark image.
     */
    public int height = 0;

    public Rectangle() {
      x = 0;
      y = 0;
      width = 0;
      height = 0;
    }
    public Rectangle(int x_, int y_, int width_, int height_) {
      x = x_;
      y = y_;
      width = width_;
      height = height_;
    }
  };

  /**
   * Sets whether or not the watermark image is visible in the local video preview:
   * - true: (Default) The watermark image is visible in preview.
   * - false: The watermark image is not visible in preview.
   */
  public boolean visibleInPreview = true;

  /**
   * The watermark position in the landscape mode. See {@link Rectangle Rectangle}.
   * See details for the landscape mode in the advanced guide *Rotate the Video*.
   */
  public Rectangle positionInLandscapeMode = new Rectangle();

  /**
   * The watermark position in the portrait mode. See {@link Rectangle Rectangle}.
   * See details for the portrait mode in the advanced guide *Rotate the Video*.
   */
  public Rectangle positionInPortraitMode = new Rectangle();
}
