//
//  Agora Media SDK
//
//  Created by Sting Feng in 2015-05.
//  Copyright (c) 2015 Agora IO. All rights reserved.
//
#pragma once

#include "AgoraRefPtr.h"
#include "IAgoraRtcEngine.h"

#include "NGIAgoraMediaNodeFactory.h"

#include "video_node_i.h"

namespace agora {
namespace rtc {

class IMediaNodeFactoryEx : public IMediaNodeFactory {
 public:
  virtual ~IMediaNodeFactoryEx() {}

  /** This method creates built-in video frame adapter
   */
  virtual agora_refptr<IVideoFrameAdapter> createVideoFrameAdapter() = 0;

  /**
   * Creates a observable video sink
   *
   * This method creates an IVideoSinkBase object, which can be used to observer video
   *
   * @param observer The pointer to the observer
   * @param trackInfo The info of the track that needs observer
   * @return
   * - The pointer to IVideoSinkBase, if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual agora_refptr<rtc::IVideoSinkBase> createObservableVideoSink(
      media::IVideoFrameObserver* observer, VideoTrackInfo trackInfo, IRtcEngineEventHandler* eventHandler = nullptr) = 0;

  /**
   * Creates a observable video filter
   *
   * This method creates an IVideoSinkBase object, which can be used to observer video
   *
   * @param observer The pointer to the observer
   * @param trackInfo The info of the track that needs observer
   * @return
   * - The pointer to IVideoFilterBase, if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual agora_refptr<rtc::IVideoFilter> createObservableVideoFilter(
      media::IVideoFrameObserver* observer, VideoTrackInfo trackInfo, IRtcEngineEventHandler* eventHandler = nullptr) = 0;
};

class IMediaPacketCallback {
 public:
  virtual ~IMediaPacketCallback() {}

  virtual void OnMediaPacket(const uint8_t *packet, size_t length,
                             const media::base::PacketOptions &options) = 0;
};

class IMediaPacketSenderEx : public IMediaPacketSender {
 public:
  virtual ~IMediaPacketSenderEx() {}

  virtual void RegisterMediaPacketCallback(IMediaPacketCallback* dataCallback) = 0;
  virtual void UnregisterMediaPacketCallback() = 0;
};

class IMediaControlPacketCallback {
 public:
  virtual ~IMediaControlPacketCallback() {}

  virtual void OnPeerMediaControlPacket(user_id_t userId, const uint8_t *packet, size_t length) = 0;
  virtual void OnBroadcastMediaControlPacket(const uint8_t *packet, size_t length) = 0;
};

class IMediaControlPacketSenderEx : public IMediaControlPacketSender {
 public:
  virtual ~IMediaControlPacketSenderEx() {}

  virtual void RegisterMediaControlPacketCallback(IMediaControlPacketCallback* ctrlDataCallback) = 0;
  virtual void UnregisterMediaControlPacketCallback() = 0;
};

}  // namespace rtc
}  // namespace agora
