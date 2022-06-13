//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteVideoTrackImpl.h"

#include "AgoraRteUtils.h"
namespace agora {
namespace rte {

RTE_INLINE int AgoraRteRawVideoFrameRender::onFrame(
    const media::base::VideoFrame& video_frame) {
  auto track = video_track_.lock();

  if (track) {
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteVideoFrameObserver>(
        track->track_lock_, track->local_video_frame_observers_,
        [&](const auto& handler) {
          handler->OnFrame(track->GetStreamId(), video_frame);
        });
  }

  return ERR_OK;
}

RTE_INLINE AgoraRteVideoTrackImpl::AgoraRteVideoTrackImpl(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service) {
  rtc_service_ = rtc_service;

  auto media_node_factory = rtc_service->createMediaNodeFactory();

  media_node_factory_ =
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IMediaNodeFactory>(
          media_node_factory);
}

RTE_INLINE AgoraRteVideoTrackImpl::~AgoraRteVideoTrackImpl() { Reset(); }

RTE_INLINE void AgoraRteVideoTrackImpl::SetTrack(
    std::shared_ptr<rtc::ILocalVideoTrack> track) {
  video_track_ = track;
}

RTE_INLINE std::shared_ptr<rtc::IVideoRenderer>
AgoraRteVideoTrackImpl::GetVideoRender(bool create_if_not_exist) {
  {
    std::lock_guard<std::mutex> _(render_lock_);
    if (!video_render_) {
      if (!create_if_not_exist) {
        return nullptr;
      }

      auto video_render = media_node_factory_->createVideoRenderer();

      if (video_render) {
        video_render_ =
            AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IVideoRenderer>(
                video_render);
      } else {
        return nullptr;
      }
    }
  }

  return video_render_;
}

RTE_INLINE int AgoraRteVideoTrackImpl::SetView(View view) {
  RTE_LOGGER_MEMBER("view: %p", view);
  auto render = GetVideoRender();

  if (!render) {
    return -ERR_FAILED;
  }
  return render->setView(view);
}

RTE_INLINE int AgoraRteVideoTrackImpl::SetVideoEncoderConfiguration(
    const VideoEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER(
      "config: (bitrate:%d, codecType: %d, degradationPreference: %d, dimensions(width: %d, height: %d), \
      frameRate: %d, minBitrate: %d, orientationMode: %d)",
      config.bitrate, config.codecType, config.degradationPreference,
      config.dimensions.width, config.dimensions.height, config.frameRate,
      config.minBitrate, config.orientationMode);

  return video_track_->setVideoEncoderConfiguration(config);
}

RTE_INLINE int AgoraRteVideoTrackImpl::SetPreviewCanvas(
    const VideoCanvas& canvas) {
  RTE_LOGGER_MEMBER("canvas: (mirrorMode: %d, renderMode: %d, view: %p)",
                    canvas.mirror_mode, canvas.render_mode, canvas.view);

  int result = -ERR_FAILED;
  auto render = GetVideoRender();

  if (render) {
    result = render->setRenderMode(canvas.render_mode);

    if (result != ERR_OK) {
      return result;
    }

    switch (canvas.mirror_mode) {
      case rtc::VIDEO_MIRROR_MODE_AUTO:
      case rtc::VIDEO_MIRROR_MODE_ENABLED:
        result = render->setMirror(true);
        break;
      case rtc::VIDEO_MIRROR_MODE_DISABLED:
      default:
        result = render->setMirror(false);
        break;
    }

    if (result != ERR_OK) {
      return result;
    }

    if (canvas.view) {
      result = render->setView(canvas.view);
    }
  }
  return result;
}

RTE_INLINE int AgoraRteVideoTrackImpl::RegisterLocalVideoFrameObserver(
    const std::shared_ptr<IAgoraRteVideoFrameObserver>& observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  UnregisterLocalVideoFrameObserver(observer);

  bool result = false;
  {
    std::lock_guard<std::mutex> _(track_lock_);
    local_video_frame_observers_.push_back(observer);

    if (!raw_video_frame_renders_) {
      raw_video_frame_renders_ =
          make_refptr<AgoraRteRawVideoFrameRender>(shared_from_this());

      result = video_track_->addRenderer(raw_video_frame_renders_);
    }
  }

  return result ? ERR_OK : -ERR_FAILED;
}

RTE_INLINE void AgoraRteVideoTrackImpl::UnregisterLocalVideoFrameObserver(
    const std::shared_ptr<IAgoraRteVideoFrameObserver>& observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  AgoraRteUtils::UnregisterSharedPtrFromContainer(
      track_lock_, local_video_frame_observers_, observer);
  {
    std::lock_guard<std::mutex> _(track_lock_);
    if (local_video_frame_observers_.empty() && raw_video_frame_renders_) {
      video_track_->removeRenderer(raw_video_frame_renders_);
      raw_video_frame_renders_ = nullptr;
    }
  }
}

RTE_INLINE std::shared_ptr<agora::rtc::ILocalVideoTrack>
AgoraRteVideoTrackImpl::GetVideoTrack() const {
  return video_track_;
}

RTE_INLINE int AgoraRteVideoTrackImpl::Start() {
  RTE_LOGGER_MEMBER(nullptr);
  int result = ERR_OK;
  {
    // Lock to synchronize between start and stop
    //
    std::lock_guard<std::mutex> _(track_lock_);

    if (is_started_) {
      return ERR_OK;
    }

    if (is_render_enabled_) {
      bool create_if_not_exist = false;
      auto render = GetVideoRender(create_if_not_exist);

      if (render) {
        agora_refptr<rtc::IVideoRenderer> agora_render(render.get());
        if (!video_track_->addRenderer(agora_render)) {
          result = -ERR_FAILED;
        }
      }
    }

    if (result == ERR_OK) {
      video_track_->setEnabled(true);
      is_started_ = true;

      result = ERR_OK;
    } else {
      Reset();
    }
  }

  return result;
}

RTE_INLINE void AgoraRteVideoTrackImpl::Reset() {
  RTE_LOGGER_MEMBER(nullptr);
  bool enable_track = false;
  bool create_if_not_exist = false;

  auto render = GetVideoRender(create_if_not_exist);
  if (render) {
    render->setView(nullptr);
  }

  if (video_track_) {
    video_track_->setEnabled(enable_track);
  }

  if (raw_video_frame_renders_) {
    agora_refptr<rtc::IVideoSinkBase> sink(raw_video_frame_renders_);
    video_track_->removeRenderer(sink);
  }

  is_started_ = false;
}

RTE_INLINE void AgoraRteVideoTrackImpl::Stop() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::mutex> _(track_lock_);

  Reset();
}
}  // namespace rte
}  // namespace agora
