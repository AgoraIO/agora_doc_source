//
//  Agora RTC/MEDIA SDK
//
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
package io.agora.mediaplayer;

import io.agora.base.AudioFrame;
import io.agora.base.internal.CalledByNative;

public interface IMediaPlayerAudioFrameObserver {
  /**
   * Occurs when one audio frame was captured.
   * @param audioFrame The callbacked AudioPcmFrame.
   *
   */
  @CalledByNative AudioFrame onFrame(AudioFrame audioFrame);
}
