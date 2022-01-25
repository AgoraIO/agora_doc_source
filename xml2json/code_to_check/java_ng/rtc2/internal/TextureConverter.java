package io.agora.rtc2.internal;

import android.graphics.Matrix;
import android.opengl.GLES20;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.agora.base.TextureBufferHelper;
import io.agora.base.VideoFrame;
import io.agora.base.internal.CalledByNative;
import io.agora.base.internal.Logging;
import io.agora.base.internal.video.EglBase;
import io.agora.base.internal.video.GlRectDrawer;
import io.agora.base.internal.video.GlTextureFrameBuffer;
import io.agora.base.internal.video.GlUtil;
import io.agora.base.internal.video.VideoFrameDrawer;
import java.util.concurrent.Callable;

public class TextureConverter {
  private static final String TAG = TextureConverter.class.getSimpleName();
  private EglBase.Context eglContext = null;
  private TextureBufferHelper textureBufferHelper = null;

  // Drawer used to draw input textures onto the target framebuffer.
  private final GlRectDrawer textureDrawer = new GlRectDrawer();
  private final VideoFrameDrawer frameDrawer = new VideoFrameDrawer();
  private final Matrix drawMatrix = new Matrix();

  @Nullable private GlTextureFrameBuffer textureFrameBuffer;

  @CalledByNative
  public TextureConverter() {
    Logging.d(TAG, "constructor()");
  }

  @CalledByNative
  public void dispose() {
    Logging.d(TAG, "dispose()");
    releaseEglEnv();
  }

  @CalledByNative
  public VideoFrame convert(final VideoFrame inputFrame) {
    if (inputFrame == null || inputFrame.getBuffer() == null) {
      return null;
    }
    if (!(inputFrame.getBuffer() instanceof VideoFrame.TextureBuffer)) {
      return null;
    }
    VideoFrame.TextureBuffer buffer = (VideoFrame.TextureBuffer) inputFrame.getBuffer();
    if (!reconfigEglEnv(buffer.getEglBaseContext())) {
      Logging.e(TAG, "failed to reconfig egl env");
      return null;
    }
    return textureBufferHelper.invoke(new Callable<VideoFrame>() {
      @Override
      public VideoFrame call() throws Exception {
        if (textureBufferHelper.isTextureInUse()) {
          Logging.e(TAG, "failed to convert, texture in use");
          return null;
        }

        drawMatrix.reset();
        drawMatrix.preTranslate(0.5f, 0.5f);
        drawMatrix.preScale(1f, -1f); // We want the output to be upside down for Bitmap.
        drawMatrix.preTranslate(-0.5f, -0.5f);

        if (textureFrameBuffer == null) {
          textureFrameBuffer = new GlTextureFrameBuffer(GLES20.GL_RGBA);
        }
        // Setup target framebuffer.
        final int viewportWidth = inputFrame.getRotatedWidth();
        final int viewportHeight = inputFrame.getRotatedHeight();
        textureFrameBuffer.setSize(viewportWidth, viewportHeight);

        // Bind the framebuffer.
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, textureFrameBuffer.getFrameBufferId());
        GlUtil.checkNoGLES2Error("VideoFrameRotator.glBindFramebuffer");

        // Draw input frame into target framebuffer.
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
        frameDrawer.drawFrame(inputFrame, textureDrawer, drawMatrix /* additionalRenderMatrix */);
        GlUtil.checkNoGLES2Error("VideoFrameRotator.drawFrame");

        // Restore this framebuffer.
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0);
        GLES20.glFlush();

        // Return new video frame.
        VideoFrame.TextureBuffer outBuffer =
            textureBufferHelper.wrapTextureBuffer(viewportWidth, viewportHeight,
                VideoFrame.TextureBuffer.Type.RGB, textureFrameBuffer.getTextureId(), new Matrix());
        return new VideoFrame(outBuffer, 0, inputFrame.getTimestampNs());
      }
    });
  }

  private boolean reconfigEglEnv(final EglBase.Context eglContext) {
    if (eglContext == null) {
      return false;
    }
    if (eglContext.equals(this.eglContext)) {
      return true;
    }
    Logging.d(TAG, "reconfigEglEnv(()");
    releaseEglEnv();
    return configEglEnv(eglContext);
  }

  private void releaseEglEnv() {
    if (textureBufferHelper != null) {
      if (textureFrameBuffer != null) {
        textureBufferHelper.invoke(new Callable<Object>() {
          @Override
          public Object call() throws Exception {
            if (textureFrameBuffer != null) {
              textureFrameBuffer.release();
            }
            textureFrameBuffer = null;
            return null;
          }
        });
      }
      textureBufferHelper.dispose();
      textureBufferHelper = null;
    }
    eglContext = null;
  }

  private boolean configEglEnv(@NonNull final EglBase.Context eglContext) {
    textureBufferHelper = TextureBufferHelper.create("AgConvertor", eglContext);
    if (textureBufferHelper == null) {
      Logging.e(TAG, "Failed to create texture buffer helper.");
      return false;
    }
    this.eglContext = eglContext;
    return true;
  }
}
