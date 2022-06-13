//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteMixedVideoTrack.h"

#include <list>

#include "AgoraRteMediaPlayer.h"
#include "AgoraRteTrackBase.h"
#include "AgoraRteUtils.h"
#include "AgoraRteVideoTrackImpl.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteMixedVideoTrack::AgoraRteMixedVideoTrack(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : AgoraRteRtcVideoTrackBase(rtc_service) {
  track_impl_ = std::make_shared<AgoraRteVideoTrackImpl>(rtc_service);

  auto media_node_factory = track_impl_->GetMediaNodeFactory();
  video_mixer_ = media_node_factory->createVideoMixer();

  auto track = rtc_service->createMixedVideoTrack(video_mixer_);

  track_impl_->SetTrack(
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalVideoTrack>(
          track));
  track_impl_->Start();
}

RTE_INLINE AgoraRteMixedVideoTrack::~AgoraRteMixedVideoTrack() {
  video_mixer_->clearLayout();
}

RTE_INLINE int AgoraRteMixedVideoTrack::AddImage(
    const std::string& id, const rtc::MixerLayoutConfig& layout) {
  RTE_LOGGER_MEMBER(
      "id: %s, layout: (alpha: %d, height: %d, image_path: %s, \
      mirror: %d, width: %d, x: %d, y: %d, zOrder: %d)",
      id.c_str(), layout.alpha, layout.height, layout.image_path, layout.mirror,
      layout.width, layout.x, layout.y, layout.zOrder);
  if (layout.image_path == nullptr) {
    return -ERR_INVALID_ARGUMENT;
  }

  rtc::ImageType image_type;
  const std::string file_name = layout.image_path;
  std::string file_suffix = file_name.substr(file_name.find_last_of('.'));
  std::transform(file_suffix.begin(), file_suffix.end(), file_suffix.begin(),
                 ::tolower);

  if (file_suffix == ".jpg" || file_suffix == ".jpeg") {
    image_type = rtc::kJpeg;
  } else if (file_suffix == ".png" || file_suffix == ".flv" ||
             file_suffix == ".mp4") {
    image_type = rtc::kPng;
  } else if (file_suffix == ".gif") {
    image_type = rtc::kGif;
  } else {
    return -ERR_NOT_SUPPORTED;
  }

  return video_mixer_->addImageSource(id.c_str(), layout, image_type);
}

RTE_INLINE int AgoraRteMixedVideoTrack::RemoveImage(const std::string& id) {
  RTE_LOGGER_MEMBER("id: %s", id.c_str());
  if (id.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  return video_mixer_->delImageSource(id.c_str());
}

RTE_INLINE int AgoraRteMixedVideoTrack::SetLayout(
    const LayoutConfigs& layout_configs) {
  RTE_LOGGER_MEMBER(
      "layout_configs: canvas (fps: %d, height: %d, image_file_path: %s, "
      "width: "
      "%d)",
      layout_configs.canvas.fps, layout_configs.canvas.height,
      layout_configs.canvas.image_file_path.c_str(),
      layout_configs.canvas.width);
  int ret = ERR_OK;

  video_mixer_->clearLayout();

  auto background = layout_configs.canvas;
  ret = video_mixer_->setBackground(
      background.width, background.height,
      fps_from_encoder_ ? fps_from_encoder_ : background.fps,
      background.image_file_path.c_str());

  if (ret != ERR_OK) {
    video_mixer_->clearLayout();
    return ret;
  }

  auto layouts = layout_configs.layouts;

  ret = ERR_OK;
  std::list<std::string> image_id_list;
  int layouts_size = static_cast<int>(layouts.size());
  for (int i = 0; i < layouts_size; i++) {
    auto layout = layouts[i];

    rtc::MixerLayoutConfig mixer_layout_config;
    mixer_layout_config.alpha = layout.alpha;
    mixer_layout_config.x = layout.x;
    mixer_layout_config.y = layout.y;
    mixer_layout_config.width = layout.width;
    mixer_layout_config.height = layout.height;
    mixer_layout_config.zOrder = layout.zOrder;
    mixer_layout_config.mirror = layout.mirror;
    mixer_layout_config.image_path = layout.image_path.c_str();

    if (layout.layout_type == LayoutType::Track) {
      ret =
          video_mixer_->setStreamLayout(layout.id.c_str(), mixer_layout_config);
    } else if (layout.layout_type == LayoutType::Image) {
      image_id_list.push_back(layout.id);
      ret = AddImage(layout.id, mixer_layout_config);
    }

    if (ret != ERR_OK) {
      break;
    }
  }

  if (ret == ERR_OK) {
    ret = video_mixer_->refresh();
  } else {
    video_mixer_->clearLayout();
    return ret;
  }

  layout_configs_ = layout_configs;

  return ret;
}

RTE_INLINE int AgoraRteMixedVideoTrack::GetLayout(
    LayoutConfigs& layout_configs) {
  RTE_LOGGER_MEMBER(nullptr);
  if (layout_configs_.has_value()) {
    layout_configs = layout_configs_.value();
    return ERR_OK;
  }
  return ERR_NOT_READY;
}

RTE_INLINE int AgoraRteMixedVideoTrack::AddTrack(
    std::shared_ptr<IAgoraRteVideoTrack> video_track) {
  auto track = AgoraRteUtils::CastToImpl(video_track);

  agora_refptr<rtc::ILocalVideoTrack> agora_track(
      track->GetRtcVideoTrack().get());
  return video_mixer_->addVideoTrack(track->GetTrackId().c_str(), agora_track);
}

RTE_INLINE int AgoraRteMixedVideoTrack::RemoveTrack(
    std::shared_ptr<IAgoraRteVideoTrack> video_track) {
  RTE_LOGGER_MEMBER("video_track: %p", video_track.get());
  auto track = AgoraRteUtils::CastToImpl(video_track);

  agora_refptr<rtc::ILocalVideoTrack> agora_track(
      track->GetRtcVideoTrack().get());
  return video_mixer_->removeVideoTrack(track->GetTrackId().c_str(),
                                        agora_track);
}

RTE_INLINE int AgoraRteMixedVideoTrack::AddMediaPlayer(
    std::shared_ptr<IAgoraRteMediaPlayer> media_player) {
  RTE_LOGGER_MEMBER("media_player: %p", media_player.get());
  auto video_track = std::static_pointer_cast<AgoraRteMediaPlayer>(media_player)
                         ->GetVideoTrack();
  std::string id;

  // GetStreamId from media_player is different from rtc's GetStreamId
  //
  media_player->GetStreamId(id);

  if (!id.empty() && video_track) {
    agora_refptr<rtc::ILocalVideoTrack> track(
        AgoraRteUtils::CastToImpl(video_track)->GetRtcVideoTrack().get());
    return video_mixer_->addVideoTrack(id.c_str(), track);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteMixedVideoTrack::RemoveMediaPlayer(
    std::shared_ptr<IAgoraRteMediaPlayer> media_player) {
  RTE_LOGGER_MEMBER("media_player: %p", media_player.get());
  auto video_track = std::static_pointer_cast<AgoraRteMediaPlayer>(media_player)
                         ->GetVideoTrack();
  std::string id;
  // GetStreamId from media_player is different from rtc's GetStreamId
  //
  media_player->GetStreamId(id);

  if (!id.empty() && video_track) {
    agora_refptr<rtc::ILocalVideoTrack> track(
        AgoraRteUtils::CastToImpl(video_track)->GetRtcVideoTrack().get());
    return video_mixer_->removeVideoTrack(id.c_str(), track);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteMixedVideoTrack::SetPreviewCanvas(
    const VideoCanvas& canvas) {
  RTE_LOGGER_MEMBER("canvas: (mirrorMode: %d, renderMode: %d, view: %p)",
                    canvas.mirror_mode, canvas.render_mode, canvas.view);
  return track_impl_->SetPreviewCanvas(canvas);
}

RTE_INLINE SourceType AgoraRteMixedVideoTrack::GetSourceType() {
  RTE_LOGGER_MEMBER(nullptr);
  return SourceType::kVideo_Mix;
}

RTE_INLINE void AgoraRteMixedVideoTrack::RegisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->RegisterLocalVideoFrameObserver(observer);
}

RTE_INLINE void AgoraRteMixedVideoTrack::UnregisterVideoFrameObserver(
    std::shared_ptr<IAgoraRteVideoFrameObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  track_impl_->UnregisterLocalVideoFrameObserver(observer);
}

RTE_INLINE int AgoraRteMixedVideoTrack::SetFilterProperty(
    const std::string& id, const std::string& key,
    const std::string& json_value) {
  RTE_LOGGER_MEMBER("id: %s, key: %s, json_value: %s", id.c_str(), key.c_str(),
                    json_value.c_str());
  return track_impl_->GetVideoTrack()->setFilterProperty(
      id.c_str(), key.c_str(), json_value.c_str());
}

RTE_INLINE std::string AgoraRteMixedVideoTrack::GetFilterProperty(
    const std::string& id, const std::string& key) {
  RTE_LOGGER_MEMBER("id: %s, key: %s", id.c_str(), key.c_str());
  char buffer[1024];

  if (track_impl_->GetVideoTrack()->getFilterProperty(id.c_str(), key.c_str(),
                                                      buffer, 1024) == ERR_OK) {
    return buffer;
  }

  return "";
}

RTE_INLINE void AgoraRteMixedVideoTrack::SetStreamId(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  track_impl_->SetStreamId(stream_id);
}

RTE_INLINE const std::string& AgoraRteMixedVideoTrack::GetAttachedStreamId() {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetStreamId();
}

RTE_INLINE std::shared_ptr<agora::rtc::ILocalVideoTrack>
AgoraRteMixedVideoTrack::GetRtcVideoTrack() const {
  RTE_LOGGER_MEMBER(nullptr);
  return track_impl_->GetVideoTrack();
}

RTE_INLINE int AgoraRteMixedVideoTrack::BeforeVideoEncodingChanged(
    const VideoEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER(
      "config:(bitrate: %d, codecType: %d, degradationPreference: %d, \
      dimensions.height: %d, dimensions.width: %d, frameRate: %d, minBitrate: %d, \
      mirrorMode: %d, orientationMode: %d)",
      config.bitrate, config.codecType, config.degradationPreference,
      config.dimensions.height, config.dimensions.width, config.frameRate,
      config.minBitrate, config.mirrorMode, config.orientationMode);
  if (layout_configs_.has_value()) {
    const auto& layout_config = layout_configs_.value();
    fps_from_encoder_ = layout_config.canvas.fps;
    int result = video_mixer_->setBackground(
        layout_config.canvas.width, layout_config.canvas.height,
        fps_from_encoder_, layout_config.canvas.image_file_path.c_str());
    if (result == ERR_OK) {
      result = video_mixer_->refresh();
    }
    return result;
  }

  return ERR_OK;
}

RTE_INLINE int AgoraRteMixedVideoTrack::EnableExtension(
    const std::string& provider_name, const std::string& extension_name) {
  return AgoraRteRtcVideoTrackBase::EnableExtension(provider_name,
                                                    extension_name);
}

RTE_INLINE int AgoraRteMixedVideoTrack::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::SetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

RTE_INLINE int AgoraRteMixedVideoTrack::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  return AgoraRteRtcVideoTrackBase::GetExtensionProperty(
      provider_name, extension_name, key, json_value);
}

}  // namespace rte
}  // namespace agora
