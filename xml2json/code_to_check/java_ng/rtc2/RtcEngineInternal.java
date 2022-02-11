package io.agora.rtc2;

// import android.opengl.EGLContext;
import javax.microedition.khronos.egl.EGLContext;

public abstract class RtcEngineInternal extends RtcEngineEx {
  public abstract int setProfile(String profile, boolean merge);
  public abstract int enableTransportQualityIndication(boolean enabled);
  public abstract int playRecap();
  public abstract int enableRecap(int interval);

  /**
   * Queries internal states
   * @param parameters
   *     JSON string, array type
   * @return A JSON string
   */
  public abstract String getParameters(String parameters);

  public abstract String makeQualityReportUrl(
      String channel, String listenerUid, String speakerUid, int format);

  /**
   * Shared context of MediaCodec. Only takes effect when using the hardware encoder and texture as
   * the input source.
   *
   * @param sharedContext Shared context
   * @return int
   */
  public abstract int updateSharedContext(EGLContext sharedContext);

  public abstract int updateSharedContext(android.opengl.EGLContext sharedContext);

  /**
   * Sets the texture ID to MediaCodec.
   *
   * @param id: Texture ID
   * @param eglContext: eglContext which the texture belongs to
   * @param width Texture's original width
   * @param height Texture's original height
   * @param ts Timestamp of the captured frame (ms)
   * @return Texture ID
   */
  public abstract int setTextureId(int id, EGLContext eglContext, int width, int height, long ts);

  public abstract int setTextureId(
      int id, android.opengl.EGLContext eglContext, int width, int height, long ts);

  /**
   * <p>Enables the audio routing monitoring by the SDK.
   *
   * <p>Call before joining a channel.
   *
   * @param isMonitoring: Default value is true
   * @return
   */
  public abstract int monitorAudioRouteChange(boolean isMonitoring);
  /**
   * @param syncCallTimeout: Synchronous or asynchronous mode
   *     -1: Asynchronous mode
   *      >=0: Synchronous mode, timeout (ms)
   */
  public abstract int setApiCallMode(int syncCallTimeout);
}
