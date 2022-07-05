//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"

namespace agora {
namespace rte {

/**
 * The IAudioFrameObserver class.
 */
class IAgoraRteAudioFrameObserver {
 public:
  /**
   * Occurs when the recorded audio frame is received.
   * @param audioFrame The reference to the audio frame: AudioFrame.
   * @return
   * - true: The recorded audio frame is valid to observer.
   * - false: The recorded audio frame is invalid to observer.
   */
  virtual bool OnRecordAudioFrame(AudioFrame& audio_frame) = 0;

  /**
   * Occurs when the playback audio frame is received.
   * @param audioFrame The reference to the audio frame: AudioFrame.
   * @return
   * - true: The playback audio frame is valid to observer.
   * - false: The playback audio frame is invalid to observer.
   */
  virtual bool OnPlaybackAudioFrame(AudioFrame& audio_frame) = 0;

  /**
   * Occurs when the mixed audio data is received.
   * @param audioFrame The reference to the audio frame: AudioFrame.
   * @return
   * - true: The mixed audio data is valid to observer.
   * - false: The mixed audio data is invalid to observer.
   */
  virtual bool OnMixedAudioFrame(AudioFrame& audio_frame) = 0;

  /**
   * Occurs when the ear monitoring audio frame is received.
   * @param audioFrame The reference to the audio frame: AudioFrame.
   * @return
   * - true: The ear monitoring audio data is valid and is encoded and sent.
   * - false: The ear monitoring audio data is invalid and is not encoded or sent.
   */
  virtual bool OnEarMonitoringAudioFrame(AudioFrame& audioFrame) = 0;

  /**
   * Occurs when the playback audio frame before mixing is received.
   * @param uid ID of the remote user.
   * @param audioFrame The reference to the audio frame: AudioFrame.
   * @return
   * - true: The playback audio frame before mixing is valid and is encoded and
   * sent.
   * - false: The playback audio frame before mixing is invalid and is not
   * encoded or sent.
   */
  virtual bool OnPlaybackAudioFrameBeforeMixing(const std::string& stream_id,
                                                AudioFrame& audio_frame) = 0;

 protected:
  virtual ~IAgoraRteAudioFrameObserver() = default;
};

class IAgoraRteVideoFrameObserver {
 public:
  /**
   * Occurs when a video frame was captured from local or received from remote.
   *
   * @param stream_id ID of the stream which the video comes from.
   * If the track is not published to stream yet, stream_id will be empty.
   * @param video_frame The reference to the video frame
   */
  virtual void OnFrame(const std::string& stream_id,
                       const media::base::VideoFrame& video_frame) = 0;

 protected:
  virtual ~IAgoraRteVideoFrameObserver() = default;
};

}  // namespace rte
}  // namespace agora
