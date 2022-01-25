package io.agora.rtc2.video;

import android.view.View;

/**
 * The VideoCanvas class.
 */
public class VideoCanvas {
  /**
   *
   * 1: Uniformly scale the video until it fills the visible boundaries (cropped).
   * One dimension of the video may have clipped contents.
   */
  public static final int RENDER_MODE_HIDDEN = 1;
  /**
   * 2: Uniformly scale the video until one of its dimension
   * fits the boundary (zoomed to fit). Areas that are not filled due to the
   * disparity in the aspect ratio are filled with black.
   */
  public static final int RENDER_MODE_FIT = 2;
  /**
   * 3: This mode is deprecated and Agora does not recommend using it.
   */
  public static final int RENDER_MODE_ADAPTIVE = 3;

  /**
   * Video display window.
   * Must be SurfaceView or TextureView
   */
  public View view;
  /**
   * The video render mode:
   * - `RENDER_MODE_HIDDEN(1)`: Uniformly scale the video until it fills the visible
   * boundaries (cropped). One dimension of the video may have clipped contents.
   * - `RENDER_MODE_FIT(2)`: Uniformly scale the video until one of its dimension
   * fits the boundary (zoomed to fit). Areas that are not filled due to the
   * disparity in the aspect ratio are filled with black.
   * - `RENDER_MODE_ADAPTIVE(3)`: This mode is deprecated and Agora does not
   * recommend using it.
   *
   */
  public int renderMode;

  /**
   * The video mirror mode:
   * - `VIDEO_MIRROR_MODE_AUTO(0)`: (Default) The mirror mode determined by the SDK.
   * If you use the front camera, the SDK enables the mirror mode;
   * if you use the rear camera, the SDK disables the mirror mode.
   * - `VIDEO_MIRROR_MODE_ENABLED(1)`: Enable the mirror mode.
   * - `VIDEO_MIRROR_MODE_DISABLED(2)`: Disable the mirror mode.
   */
  public int mirrorMode;
  /**
   * The video source type:
   */
  public int sourceType;

  /**
   * ID of the video source.
   */
  public int sourceId;
  /**
   * ID of the user in the integer format.
   */
  public int uid;

  public VideoCanvas(View view) {
    this.view = view;
    this.renderMode = RENDER_MODE_HIDDEN;
  }

  public VideoCanvas(View view, int renderMode) {
    this.view = view;
    this.renderMode = renderMode;
    this.uid = 0;
  }

  public VideoCanvas(View view, int renderMode, int uid) {
    this.view = view;
    this.renderMode = renderMode;
    this.uid = uid;
  }

  public VideoCanvas(View view, int renderMode, int mirrorMode, int uid) {
    this.view = view;
    this.renderMode = renderMode;
    this.mirrorMode = mirrorMode;
    this.uid = uid;
  }

  public VideoCanvas(View view, int renderMode, int mirrorMode, int sourceType, int uid) {
    this.view = view;
    this.renderMode = renderMode;
    this.mirrorMode = mirrorMode;
    this.sourceType = sourceType;
    this.uid = uid;
  }

  public VideoCanvas(
      View view, int renderMode, int mirrorMode, int sourceType, int sourceId, int uid) {
    this.view = view;
    this.renderMode = renderMode;
    this.mirrorMode = mirrorMode;
    this.sourceType = sourceType;
    this.sourceId = sourceId;
    this.uid = uid;
  }
}
