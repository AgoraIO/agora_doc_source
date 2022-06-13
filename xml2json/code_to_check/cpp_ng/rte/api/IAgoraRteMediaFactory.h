//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"

namespace agora {
namespace rte {

class IAgoraRteCameraVideoTrack;
class IAgoraRteScreenVideoTrack;
class IAgoraRteMixedVideoTrack;
class IAgoraRteCustomVideoTrack;
class IAgoraRteMicrophoneAudioTrack;
class IAgoraRteCustomAudioTrack;
class IAgoraRteMediaPlayer;
class IAgoraRteStreamingSource;
class IAgoraRtePlayList;

/**
 * The IAgoraMediaFactory class.
 */
class IAgoraRteMediaFactory {
 public:
  /**
   * Create a camera video track, the track will use camera as video source.
   * Check \ref agora::rte::IAgoraRteCameraVideoTrack for more details
   *
   * @return The created camera video track.
   */
  virtual std::shared_ptr<IAgoraRteCameraVideoTrack>
  CreateCameraVideoTrack() = 0;

  /**
   * Create a screen video track, the track will use screen as video source.
   * Check \ref agora::rte::IAgoraRteScreenVideoTrack for more details
   *
   * @return The created screen video track.
   */
  virtual std::shared_ptr<IAgoraRteScreenVideoTrack>
  CreateScreenVideoTrack() = 0;

  /**
   * Create a mixed video track, the track will mix video sources from other
   * tracks into single video source. Check \ref
   * agora::rte::IAgoraRteMixedVideoTrack for more details
   *
   * @return The created mixed video track.
   */
  virtual std::shared_ptr<IAgoraRteMixedVideoTrack> CreateMixedVideoTrack() = 0;

  /**
   * Create a custom video track, the track will use customized data as video
   * source. Check \ref agora::rte::IAgoraRteCustomVideoTrack for more details
   *
   * @return The created custom video track.
   */
  virtual std::shared_ptr<IAgoraRteCustomVideoTrack>
  CreateCustomVideoTrack() = 0;

  /**
   * Create a microphone audio track, the track will use microphone as audio
   * source. Check \ref agora::rte::IAgoraRteMicrophoneAudioTrack for more
   * details
   *
   * @return The created microphone audio track.
   */
  virtual std::shared_ptr<IAgoraRteMicrophoneAudioTrack>
  CreateMicrophoneAudioTrack() = 0;

  /**
   * Create a custom audio track, the track will use customized data as audio
   * source. Check \ref agora::rte::IAgoraRteCustomAudioTrack for more details
   *
   * @return The created custom audio track.
   */
  virtual std::shared_ptr<IAgoraRteCustomAudioTrack>
  CreateCustomAudioTrack() = 0;

  /**
   * Create a media player.
   * Check \ref agora::rte::IAgoraRteMediaPlayer for more details
   *
   * @return The created media player.
   */
  virtual std::shared_ptr<IAgoraRteMediaPlayer> CreateMediaPlayer() = 0;

  /**
   * Create a streaming source.
   * Check \ref agora::rte::IAgoraRteStreamingSource for more details
   *
   * @return The created streaming source.
   */
  virtual std::shared_ptr<IAgoraRteStreamingSource> CreateStreamingSource() = 0;

 protected:
  virtual ~IAgoraRteMediaFactory() = default;
};
}  // namespace rte
}  // namespace agora
