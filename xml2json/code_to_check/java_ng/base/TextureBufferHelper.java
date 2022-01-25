package io.agora.base;

import android.graphics.Matrix;
import android.opengl.GLES20;
import android.os.Handler;
import android.os.HandlerThread;

import io.agora.base.internal.Logging;
import io.agora.base.internal.ThreadUtils;
import io.agora.base.internal.video.EglBase;
import io.agora.base.internal.video.EglBase10;
import io.agora.base.internal.video.EglBase14;
import io.agora.base.internal.video.GlRectDrawer;
import io.agora.base.internal.video.GlTextureFrameBuffer;
import io.agora.base.internal.video.RendererCommon;
import io.agora.base.internal.video.YuvConverter;

import java.util.concurrent.Callable;

public class TextureBufferHelper {
  private static final String TAG = "TextureBufferHelper";
  private GlRectDrawer textureDrawer;
  private GlTextureFrameBuffer textureFrameBuffer;

  /**
   * Construct a new TextureBufferHelper sharing OpenGL resources with |sharedContext|. A dedicated
   * thread and handler is created for handling TextureBuffer. May return null if EGL fails to
   * initialize a pixel buffer surface and make it current.
   */
  public static TextureBufferHelper create(
      final String threadName, final EglBase.Context sharedContext) {
    final HandlerThread thread = new HandlerThread(threadName);
    thread.start();
    final Handler handler = new Handler(thread.getLooper());

    return ThreadUtils.invokeAtFrontUninterruptibly(handler, new Callable<TextureBufferHelper>() {
      @Override
      public TextureBufferHelper call() {
        try {
          return new TextureBufferHelper(sharedContext, handler);
        } catch (RuntimeException e) {
          Logging.e(TAG, threadName + " create failure", e);
          return null;
        }
      }
    });
  }

  private final Handler handler;
  private final EglBase eglBase;
  private final YuvConverter yuvConverter = new YuvConverter();

  // The possible states of this class. Only accessed from the |handler| thread.
  private int numOfTextureInUse = 0;
  private boolean isQuitting = false;

  private TextureBufferHelper(EglBase.Context sharedContext, Handler handler) {
    if (handler.getLooper().getThread() != Thread.currentThread()) {
      throw new IllegalStateException("TextureBufferHelper must be created on the handler thread");
    }
    this.handler = handler;

    eglBase = (EglBase14.isEGL14Supported()
                  && (sharedContext == null || sharedContext instanceof EglBase14.Context))
        ? new EglBase14((EglBase14.Context) sharedContext, EglBase.CONFIG_PIXEL_BUFFER)
        : new EglBase10((EglBase10.Context) sharedContext, EglBase.CONFIG_PIXEL_BUFFER);
    try {
      // Both these statements have been observed to fail on rare occasions, see BUG=webrtc:5682.
      eglBase.createDummyPbufferSurface();
      eglBase.makeCurrent();
    } catch (RuntimeException e) {
      // Clean up before rethrowing the exception.
      eglBase.release();
      handler.getLooper().quit();
      throw e;
    }
  }

  /** Retrieve the handler. This handler is valid until dispose() is called. */
  public Handler getHandler() {
    return handler;
  }

  /** Retrieve the EglBase instance. This EglBase instance is valid until dispose() is called. */
  public EglBase getEglBase() {
    return eglBase;
  }

  /**
   * Post |callable| to be executed on the |handler| thread and wait for the result.
   */
  public <V> V invoke(final Callable<V> callable) {
    return ThreadUtils.invokeAtFrontUninterruptibly(handler, callable);
  }

  /**
   * This can only be called from the |handler| thread.
   */
  public VideoFrame.TextureBuffer wrapTextureBuffer(
      int width, int height, VideoFrame.TextureBuffer.Type type, int id, Matrix transformMatrix) {
    numOfTextureInUse++;

    return new TextureBuffer(eglBase.getEglBaseContext(), width, height, type, id,
        transformMatrix, handler, yuvConverter, new Runnable() {
          @Override
          public void run() {
            returnTextureFrame();
          }
        });
  }

  /**
   * This can only be called from the |handler| thread.
   * @param buffer TextureBuffer with type of OES
   * @param rotation The angle of texture buffer should be rotated
   * @return Texture id with RGBA format converted from OES buffer
   */
  public int convertToRGBA(TextureBuffer buffer, int rotation) {
    if (buffer == null) {
      return 0;
    } else if (buffer.getType() == VideoFrame.TextureBuffer.Type.RGB) {
      return buffer.getTextureId();
    } else {
      if (textureDrawer == null) {
        textureDrawer = new GlRectDrawer();
      }
      if (textureFrameBuffer == null) {
        textureFrameBuffer = new GlTextureFrameBuffer(GLES20.GL_RGBA);
      }
      final int frameWidth = rotation % 180 == 0 ? buffer.getWidth() : buffer.getHeight();
      final int frameHeight = rotation % 180 == 0 ? buffer.getHeight() : buffer.getWidth();
      textureFrameBuffer.setSize(frameWidth, frameHeight);
      // Bind the framebuffer.
      GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, textureFrameBuffer.getFrameBufferId());
      // Draw video frame without rotation.
      GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
      final Matrix renderMatrix = new Matrix();
      renderMatrix.preTranslate(0.5F, 0.5F);
      renderMatrix.preRotate(rotation);
      renderMatrix.preTranslate(-0.5F, -0.5F);
      renderMatrix.postConcat(buffer.getTransformMatrix());
      float[] finalGlMatrix = RendererCommon.convertMatrixFromAndroidGraphicsMatrix(renderMatrix);
      textureDrawer.drawOes(buffer.getTextureId(), finalGlMatrix, frameWidth, frameHeight, 0, 0,
          frameWidth, frameHeight);
      // Unbind the framebuffer.
      GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0);

      return textureFrameBuffer.getTextureId();
    }
  }

  /**
   * This function is called when the texture frame is released. Only one texture frame can be in
   * flight at once for a certain texture id, so this function must be called before a new frame
   * with the same texture ID is delivered.
   */
  private void returnTextureFrame() {
    handler.post(new Runnable() {
      @Override
      public void run() {
        numOfTextureInUse--;
        if (isQuitting) {
          TextureBufferHelper.this.release();
        }
      }
    });
  }

  /**
   * This can only be called from the |handler| thread.
   */
  public boolean isTextureInUse() {
    return numOfTextureInUse > 0;
  }

  /**
   * Call dispose() to stop receiving frames. OpenGL resources are released and the handler is
   * stopped when the texture frame has been released.
   */
  public void dispose() {
    Logging.d(TAG, "dispose()");
    ThreadUtils.invokeAtFrontUninterruptibly(handler, new Runnable() {
      @Override
      public void run() {
        isQuitting = true;
        if (!TextureBufferHelper.this.isTextureInUse()) {
          TextureBufferHelper.this.release();
        }
      }
    });
  }

  private void release() {
    if (handler.getLooper().getThread() != Thread.currentThread()) {
      throw new IllegalStateException("Wrong thread.");
    }
    if (isTextureInUse() || !isQuitting) {
      throw new IllegalStateException("Unexpected release.");
    }
    Logging.d(TAG, "release()");
    if (textureDrawer != null) {
      textureDrawer.release();
      textureDrawer = null;
    }
    if (textureFrameBuffer != null) {
      textureFrameBuffer.release();
      textureFrameBuffer = null;
    }
    yuvConverter.release();
    eglBase.release();
    handler.getLooper().quit();
  }
}
