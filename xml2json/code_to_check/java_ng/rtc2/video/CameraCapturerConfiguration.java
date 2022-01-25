package io.agora.rtc2.video;

import io.agora.base.internal.CalledByNative;

/**
 * The definition of CameraCapturerConfiguration.
 */
public class CameraCapturerConfiguration {
  /**
   *  Sets the camera direction.
   */
  public enum CAMERA_DIRECTION {
    /**
     *  0: Uses the rear camera.
     */
    CAMERA_REAR(0),
    /**
     * 1: Uses the front camera.
     */
    CAMERA_FRONT(1);

    private int value;

    private CAMERA_DIRECTION(int v) {
      value = v;
    }

    public int getValue() {
      return this.value;
    }
  }

  /**
   * The camera direction.
   *
   * @param cameraDirection The camera direction:
   * <ul>
   *     <li>{@link CAMERA_DIRECTION#CAMERA_REAR CAMERA_REAR(0)}：Uses the rear camera.
   *     <li>{@link CAMERA_DIRECTION#CAMERA_FRONT CAMERA_FRONT(1)}: Uses the front camera.
   * </ul>
   */
  public CAMERA_DIRECTION cameraDirection;

  static public class CaptureFormat {
    /**
     * The width (px) of the video image captured by the local camera.
     */
    public int width;
    /**
     * The height (px) of the video image captured by the local camera.
     */
    public int height;
    /**
     * The fps of the video image captured by the local camera.
     */
    public int fps;

    public CaptureFormat(int width, int height, int fps) {
      this.width = width;
      this.height = height;
      this.fps = fps;
    }

    public CaptureFormat() {
      this.width = 640;
      this.height = 480;
      this.fps = 15;
    }

    @CalledByNative("CaptureFormat")
    public int getHeight() {
      return height;
    }

    @CalledByNative("CaptureFormat")
    public int getWidth() {
      return width;
    }

    @CalledByNative("CaptureFormat")
    public int getFps() {
      return fps;
    }

    @Override
    public String toString() {
      return "CaptureFormat{"
          + "width=" + width + ", height=" + height + ", fps=" + fps + '}';
    }
  }

  public CaptureFormat captureFormat;

  /**
   * The camera capture configuration.
   *
   * @param cameraDirection The camera direction. For details, see {@link CAMERA_DIRECTION
   *     CAMERA_DIRECTION}.
   */
  public CameraCapturerConfiguration(CAMERA_DIRECTION cameraDirection) {
    this.cameraDirection = cameraDirection;
  }

  /**
   * The camera capture configuration.
   *
   * @param captureFormat The camera capture format. For details, see {@link
   *     CaptureFormat }.
   */
  public CameraCapturerConfiguration(CaptureFormat captureFormat) {
    this.captureFormat = captureFormat;
  }

  /**
   * The camera capture configuration.
   *
   * @param cameraDirection The camera direction. For details, see {@link CAMERA_DIRECTION
   *     CAMERA_DIRECTION}.
   * @param captureFormat The camera capture format. For details, see {@link
   *     CaptureFormat }.
   */
  public CameraCapturerConfiguration(
      CAMERA_DIRECTION cameraDirection, CaptureFormat captureFormat) {
    this.cameraDirection = cameraDirection;
    this.captureFormat = captureFormat;
  }

  @CalledByNative
  public int getCameraDirection() {
    return cameraDirection.value;
  }

  @CalledByNative
  public CaptureFormat getCaptureFormat() {
    return captureFormat;
  }

  @Override
  public String toString() {
    return "CameraCapturerConfiguration{"
        + "cameraDirection=" + cameraDirection + ", captureDimensions=" + captureFormat + '}';
  }
}
