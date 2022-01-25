package io.agora.mediaplayer;

import io.agora.base.VideoFrame;
import io.agora.base.internal.CalledByNative;
import io.agora.mediaplayer.Constants;

public interface IMediaPlayerVideoFrameObserver {
  /**
   * Occurs when one video frame was captured.
   * @param audioFrame The callbacked AudioPcmFrame.
   *
   */
  @CalledByNative void onFrame(VideoFrame frame);
}