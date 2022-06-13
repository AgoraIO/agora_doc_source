//
//  Agora Media SDK
//
//  Copyright (c) 2015 Agora IO. All rights reserved.
//

#pragma once

#include "api/video/video_frame.h"
#include "IAgoraMediaEngine.h"

namespace agora {
namespace media {
namespace base {
class IVideoFrameObserverEx : public IVideoFrameObserver {
 public:
  virtual ~IVideoFrameObserverEx() {}
  void onFrame(const VideoFrame* frame) final {}
  bool isExternal() final { return false; }
  virtual void onFrame(const webrtc::VideoFrame& frame) = 0;
};
}

/**
 * The IVideoFrameObserverEx class.
 */
class IVideoFrameObserverEx : public IVideoFrameObserver {
 public:
  virtual ~IVideoFrameObserverEx() {}

  bool onCaptureVideoFrame(VideoFrame& videoFrame) final { return false; }
  bool onPreEncodeVideoFrame(VideoFrame& videoFrame) final { return false; }
  bool onSecondaryCameraCaptureVideoFrame(VideoFrame& videoFrame) final { return false; }
  bool onSecondaryPreEncodeCameraVideoFrame(VideoFrame& videoFrame) final { return false; }

  bool onScreenCaptureVideoFrame(VideoFrame& videoFrame) final { return false; }
  bool onPreEncodeScreenVideoFrame(VideoFrame& videoFrame) final { return false; }
  bool onSecondaryScreenCaptureVideoFrame(VideoFrame& videoFrame) final { return false; }
  bool onSecondaryPreEncodeScreenVideoFrame(VideoFrame& videoFrame) final { return false; }

  bool onRenderVideoFrame(const char* channelId, rtc::uid_t remoteUid,
                          VideoFrame& videoFrame) final { return false; }
  bool onTranscodedVideoFrame(VideoFrame& videoFrame) final { return false; }
  bool onMediaPlayerVideoFrame(VideoFrame& videoFrame, int mediaPlayerId) final { return false; }
  bool isExternal() final { return false; }

  virtual bool onCaptureVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onPreEncodeVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onSecondaryCameraCaptureVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onSecondaryPreEncodeCameraVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }

  virtual bool onScreenCaptureVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onPreEncodeScreenVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onSecondaryScreenCaptureVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onSecondaryPreEncodeScreenVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }

  virtual bool onRenderVideoFrame(const char* channelId, rtc::uid_t remoteUid,
                                  const webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onTranscodedVideoFrame(webrtc::VideoFrame& videoFrame) { return false; }
  virtual bool onMediaPlayerVideoFrame(webrtc::VideoFrame& videoFrame, int mediaPlayerId) { return false; }
};

/**
 * The IMediaEngineEx class
 */
class IMediaEngineEx : public IMediaEngine {
 public:
  virtual int pushVideoFrameEx(const webrtc::VideoFrame& frame) = 0;
  virtual int pushVideoFrameEx(const webrtc::VideoFrame& frame, const rtc::RtcConnection& connection) = 0;

  virtual int enableDualStreamModeEx(rtc::VIDEO_SOURCE_TYPE sourceType, bool enabled, const rtc::SimulcastStreamConfig& streamConfig,
                             const rtc::RtcConnection& connection) = 0;
  /**
   * Deprecated by IRtcEngine::setVideoEncoderConfiguration.
   */
  virtual int setExternalVideoConfigEx(const rtc::VideoEncoderConfiguration& config) = 0;
  virtual int setExternalVideoConfigEx(const rtc::VideoEncoderConfiguration& config, const rtc::RtcConnection& connection) = 0;

 protected:
  ~IMediaEngineEx() override = default;
};

}  // namespace media
}  // namespace agora
