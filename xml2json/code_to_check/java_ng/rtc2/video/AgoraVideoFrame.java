package io.agora.rtc2.video;

/**
 * The AgoraVideoFrame class, which defines the format of the external
 * video source.
 */
public class AgoraVideoFrame {
  /**
   * -1: No video format.
   */
  public static final int FORMAT_NONE = -1;
  /**
   * 10: The video format is TEXTURE_2D.
   */
  public static final int FORMAT_TEXTURE_2D = 10;
  /**
   * 11: The video format is TEXTURE_OES.
   */
  public static final int FORMAT_TEXTURE_OES = 11;
  /**
   * 1: The video format is I420.
   */
  public static final int FORMAT_I420 = 1;
  /**
   * 2: The video format is BGRA.
   */
  public static final int FORMAT_BGRA = 2;
  /**
   * 3: The video format is NV21.
   */
  public static final int FORMAT_NV21 = 3;
  /**
   * 4: The video format is RGBA.
   */
  public static final int FORMAT_RGBA = 4;

  /**
   * -1: No buffer type.
   */
  public static final int BUFFER_TYPE_NONE = -1;
  /**
   * 1: The buffer type is buffer.
   */
  public static final int BUFFER_TYPE_BUFFER = 1;
  /**
   * 2: The buffer type is array.
   */
  public static final int BUFFER_TYPE_ARRAY = 2;
  /**
   * 3: The buffer type is texture.
   */
  public static final int BUFFER_TYPE_TEXTURE = 3;

  public AgoraVideoFrame() {
    format = 10; // GL_TEXTURE_2D
    timeStamp = 0;
    stride = 0;
    height = 0;
    textureID = 0;
    syncMode = true;
    transform = null;
    eglContext11 = null;
    eglContext14 = null;
    buf = null;
    cropLeft = 0;
    cropTop = 0;
    cropRight = 0;
    cropBottom = 0;
    rotation = 0;
  }
  /**
   * Format of the incoming video frame, which must be specified as one of the following:
   * <ul>
   *     <li>10: (Default) {@link AgoraVideoFrame#FORMAT_TEXTURE_2D GL_TEXTURE_2D}
   *     <li>11: {@link AgoraVideoFrame#FORMAT_TEXTURE_OES OES}, typically from the camera
   *     <li>1: {@link AgoraVideoFrame#FORMAT_I420 I420}
   *     <li>3: {@link AgoraVideoFrame#FORMAT_NV21 NV21}
   *     <li>4: {@link AgoraVideoFrame#FORMAT_RGBA RGBA}
   * </ul>
   */
  public int format;
  /**
   * The timestamp (ms) of this frame.
   * @note
   * Ensure that you set the correct timestamp, or it may cause frame dropping.
   */
  public long timeStamp;
  /**
   * The stride of this frame, which means the number of pixels between two consecutive
   * rows.
   * @note
   * - Set this member is in pixel, not byte.
   * - If the video format is texture, set this member as the texture width.
   */
  public int stride;
  /**
   * The height of this frame.
   */
  public int height;

  /**
   * The ID of the texture.
   * @note
   * Applies to Android texture only.
   */
  public int textureID;
  /**
   * Determines whether to enable the sync mode, which means that
   * the SDK waits while the texture is being processed.
   * @note
   * Applies to Android texture only.
   */
  public boolean syncMode;
  /**
   * The extra transform for the texture.
   * @note
   * Applies to Android texture only.
   */
  public float[] transform;
  /**
   * EGLContext11.
   * @note
   * Applies to Android texture only.
   */
  public javax.microedition.khronos.egl.EGLContext eglContext11;
  /**
   * EGLContext14.
   * @note
   * Applies to Android texture only.
   */
  public android.opengl.EGLContext eglContext14;

  // TODO: for iOS
  // CVPixelBufferRef textureBuf;

  // Non-texture frame
  /**
   * The buffer of this frame.
   * @note
   * Applies to non-texture frames.
   */
  public byte[] buf;
  /**
   * The number of pixels to crop from the left. Typically, set
   * it as 0.
   * @note
   * Applies to non-texture frames.
   */
  public int cropLeft;
  /**
   * The number of pixels to crop from the top. Typically, set
   * it as 0.
   * @note
   * Applies to non-texture frames.
   */
  public int cropTop;
  /**
   * The number of pixels to crop from the right. Typically,
   * set it as the value of （stride - width）.
   * @note
   * Applies to non-texture frames.
   */
  public int cropRight;
  /**
   * The number of pixels to crop from the bottom. Typically,
   * set it as 0.
   * @note
   * Applies to non-texture frames.
   */
  public int cropBottom;
  /**
   * The rotation information (clockwise) of this frame. Set it as 0, 90, 180, or 270.
   */
  public int rotation;
  /* Note
   * 1. stride
   *    Stride is in unit of pixel, not byte
   * 2. About frame width and height
   *    No field defined for width. However, it can be deduced by:
   *       croppedWidth = (strideInPixels - cropLeft - cropRight)
   *    And
   *       croppedHeight = (height - cropTop - cropBottom)
   * 3. About crop
   *    _________________________________________________________________.....
   *    |                        ^                                      |  ^
   *    |                        |                                      |  |
   *    |                     cropTop                                   |  |
   *    |                        |                                      |  |
   *    |                        v                                      |  |
   *    |                ________________________________               |  |
   *    |                |                              |               |  |
   *    |                |                              |               |  |
   *    |<-- cropLeft -->|          valid region        |<- cropRight ->|
   *    |                |                              |               | height
   *    |                |                              |               |
   *    |                |_____________________________ |               |  |
   *    |                        ^                                      |  |
   *    |                        |                                      |  |
   *    |                     cropBottom                                |  |
   *    |                        |                                      |  |
   *    |                        v                                      |  v
   *    _________________________________________________________________......
   *    |                                                               |
   *    |<------------------------ stride ----------------------------->|
   *
   *    If your buffer contains garbage data, you can crop them. E.g. frame size is
   *    360 x 640, often the buffer stride is 368, i.e. there extra 8 pixels on the
   *    right are for padding, and should be removed. In this case, you can set:
   *    stride = 368;
   *    height = 640;
   *    cropRight = 8;
   *    // cropLeft, cropTop, cropBottom are default to 0
   */
}
