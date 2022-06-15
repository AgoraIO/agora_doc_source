//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteTrackImplBase.h"
#include "IAgoraRteMediaObserver.h"

namespace agora {
namespace rte {

class AgoraRteVideoTrackImpl;

class AgoraRteRawVideoFrameRender : public rtc::IVideoRenderer {
 public:
  explicit AgoraRteRawVideoFrameRender(
      std::shared_ptr<AgoraRteVideoTrackImpl> video_track)
      : video_track_(video_track) {}

  virtual ~AgoraRteRawVideoFrameRender() = default;

  int onFrame(const media::base::VideoFrame& video_frame) override;

 private:
  int setRenderMode(media::base::RENDER_MODE_TYPE render_mode) override {
    return ERR_OK;
  }

  int setMirror(bool mirror) override { return ERR_OK; }

  int setView(void* view) override { return ERR_OK; }

  int unsetView() override { return ERR_OK; }

  int addView(void* view, const Rectangle& cropArea) override {
    (void) view;
    (void) cropArea;
    return ERR_OK;
  };

  int removeView(void* view) override {
    (void) view;
    return ERR_OK;
  };

  int setRenderMode(void* view, media::base::RENDER_MODE_TYPE renderMode) override {
    (void) view;
    (void) renderMode;
    return ERR_OK;
  };

  int setMirror(void* view, bool mirror) override {
    (void) view;
    (void) mirror;
    return ERR_OK;
  };

  std::weak_ptr<AgoraRteVideoTrackImpl> video_track_;
};

class AgoraRteVideoTrackImpl
    : public std::enable_shared_from_this<AgoraRteVideoTrackImpl>,
      public AgoraRteTrackImplBase {
  friend class AgoraRteRawVideoFrameRender;

 public:
  std::shared_ptr<rtc::IVideoRenderer> GetVideoRender(
      bool create_if_not_exist = true);

  explicit AgoraRteVideoTrackImpl(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteVideoTrackImpl() override;

  int SetPreviewCanvas(const VideoCanvas& canvas);

  void DisableAnyRender() { is_render_enabled_ = false; }

  void SetTrack(std::shared_ptr<rtc::ILocalVideoTrack> track);

  int SetView(View view);

  int SetVideoEncoderConfiguration(const VideoEncoderConfiguration& config);

  int RegisterLocalVideoFrameObserver(
      const std::shared_ptr<IAgoraRteVideoFrameObserver>& observer);

  void UnregisterLocalVideoFrameObserver(
      const std::shared_ptr<IAgoraRteVideoFrameObserver>& observer);

  std::shared_ptr<rtc::ILocalVideoTrack> GetVideoTrack() const;

  int Start() override;

  void Stop() override;

  void Reset();

 protected:
  std::mutex render_lock_;
  bool is_render_enabled_ = true;
  std::shared_ptr<rtc::ILocalVideoTrack> video_track_;
  std::shared_ptr<rtc::IVideoRenderer> video_render_;
  std::vector<std::weak_ptr<IAgoraRteVideoFrameObserver>>
      local_video_frame_observers_;
  agora_refptr<AgoraRteRawVideoFrameRender> raw_video_frame_renders_;
};
}  // namespace rte
}  // namespace agora
