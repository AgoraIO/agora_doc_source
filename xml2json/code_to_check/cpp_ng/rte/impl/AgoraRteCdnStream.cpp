//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteCdnStream.h"

#include "AgoraRteBase.h"
#include "AgoraRteScene.h"
#include "AgoraRteTrackBase.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteCdnLocalStream::AgoraRteCdnLocalStream(
    const std::shared_ptr<AgoraRteScene>& scene,
    std::shared_ptr<agora::base::IAgoraService> rtc_service,
    const std::string& stream_id, const std::string& url)
    : AgoraRteLocalStream(scene->GetLocalUserInfo().user_id, stream_id,
                          StreamType::kCdnStream),
      scene_(scene),
      url_(url),
      stream_id_(stream_id),
      rtc_service_(rtc_service) {
  CreateRtmpConnection();
}

RTE_INLINE int AgoraRteCdnLocalStream::Connect() {
  RTE_LOGGER_MEMBER(nullptr);
  if (url_.empty()) {
    return -ERR_INVALID_ARGUMENT;
  }

  int ret = CreateRtmpConnection();
  if (ret < 0) {
    return ret;
  }

  ret = rtmp_conn_->connect(url_.c_str());
  if (ret < 0) {
    RTE_LOG_ERROR << "Rtmp connect failed!";
    return ret;
  }

  streaming_state_ = STATE_PUBLISHING;
  return ERR_OK;
}

RTE_INLINE void AgoraRteCdnLocalStream::Disconnect() {
  RTE_LOGGER_MEMBER(nullptr);
  StopDirectCdnStreamingInternal();
}

RTE_INLINE int AgoraRteCdnLocalStream::UpdateOption(
    const StreamOption& option) {
  RTE_LOGGER_MEMBER(nullptr);
  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteCdnLocalStream::PublishLocalAudioTrack(
    std::shared_ptr<AgoraRteRtcAudioTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int ret = ERR_OK;
  if (!local_user_) {
    ret = Connect();
    if (ret != ERR_OK || !local_user_) {
      return ret;
    }
  }

  agora_refptr<rtc::ILocalAudioTrack> rtc_track =
      track->GetRtcAudioTrack().get();
  auto it = published_audio_tracks_.find(rtc_track);
  if (it != published_audio_tracks_.end()) {
    return ERR_OK;
  }
  published_audio_tracks_[rtc_track] = StreamMediaState::kIdle;
  local_user_->setAudioStreamConfiguration(audio_encoder_config_);
  ret = local_user_->publishAudio(rtc_track);
  return ret;
}

RTE_INLINE int AgoraRteCdnLocalStream::PublishLocalVideoTrack(
    std::shared_ptr<AgoraRteRtcVideoTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int ret = ERR_OK;
  if (!local_user_) {
    ret = Connect();
    if (ret != ERR_OK || !local_user_) {
      return ret;
    }
  }

  agora_refptr<rtc::ILocalVideoTrack> rtc_track =
      track->GetRtcVideoTrack().get();
  if (published_video_track_ == rtc_track) {
    return ERR_OK;
  }

  if (published_video_track_) {
    return -ERR_FAILED;
  }

  published_video_track_ = rtc_track;

  if (is_video_encoder_set_) {
    ret = published_video_track_->setVideoEncoderConfiguration(
        track_video_encoder_config_);
    if (ret != ERR_OK) {
      return ret;
    }
    ret = local_user_->setVideoStreamConfiguration(video_encoder_config_);

    if (ret != ERR_OK) {
      return ret;
    }
  }

  ret = local_user_->publishVideo(rtc_track);
  return ret;
}

RTE_INLINE int AgoraRteCdnLocalStream::UnpublishLocalAudioTrack(
    std::shared_ptr<AgoraRteRtcAudioTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  if (!local_user_) {
    return -ERR_NOT_INITIALIZED;
  }

  agora_refptr<rtc::ILocalAudioTrack> rtc_track =
      track->GetRtcAudioTrack().get();
  published_audio_tracks_.erase(rtc_track);

  int ret = local_user_->unpublishAudio(rtc_track);

  StreamMediaState old_state = StreamMediaState::kIdle;
  auto it = published_audio_tracks_.find(rtc_track);
  if (it != published_audio_tracks_.end()) {
    old_state = it->second;
    it->second = StreamMediaState::kIdle;
  }

  FireStreamStateChange(MediaType::kAudio, old_state, StreamMediaState::kIdle,
                        StreamStateChangedReason::kPublished);

  return ret;
}

RTE_INLINE int AgoraRteCdnLocalStream::UnpublishLocalVideoTrack(
    std::shared_ptr<AgoraRteRtcVideoTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  if (!local_user_) {
    return -ERR_NOT_INITIALIZED;
  }

  agora_refptr<rtc::ILocalVideoTrack> rtc_track =
      track->GetRtcVideoTrack().get();
  if (published_video_track_ == rtc_track) {
    published_video_track_ = nullptr;
  }

  int ret = local_user_->unpublishVideo(rtc_track);

  StreamMediaState old_state = published_video_stream_state_;
  published_video_stream_state_ = StreamMediaState::kIdle;
  FireStreamStateChange(MediaType::kVideo, old_state, StreamMediaState::kIdle,
                        StreamStateChangedReason::kPublished);
  return ret;
}

RTE_INLINE int AgoraRteCdnLocalStream::SetAudioEncoderConfiguration(
    const AudioEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER("config: (audioProfile: %d)", config.audioProfile);
  rtc::RtmpStreamingAudioConfiguration cfg;
  switch (config.audioProfile) {
    case rtc::AUDIO_PROFILE_MUSIC_STANDARD:
    case rtc::AUDIO_PROFILE_MUSIC_HIGH_QUALITY:
    case rtc::AUDIO_PROFILE_MUSIC_STANDARD_STEREO:
    case rtc::AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO: {
      cfg.sampleRateHz = 48000;
      cfg.bytesPerSample = 2;
      cfg.numberOfChannels = 2;
      cfg.bitrate = 128000;
    } break;

    default: {
      cfg.sampleRateHz = 48000;
      cfg.bytesPerSample = 2;
      cfg.numberOfChannels = 1;
      cfg.bitrate = 96000;
    } break;
  }
  audio_encoder_config_ = std::move(cfg);
  if (local_user_) {
    return local_user_->setAudioStreamConfiguration(audio_encoder_config_);
  }

  return ERR_OK;
}

RTE_INLINE int AgoraRteCdnLocalStream::SetVideoEncoderConfiguration(
    const VideoEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER(
      "config: (bitrate:%d, codecType: %d, degradationPreference: %d, dimensions(width: %d, height: %d), \
      frameRate: %d, minBitrate: %d, orientationMode: %d)",
      config.bitrate, config.codecType, config.degradationPreference,
      config.dimensions.width, config.dimensions.height, config.frameRate,
      config.minBitrate, config.orientationMode);
  track_video_encoder_config_ = config;

  rtc::RtmpStreamingVideoConfiguration cfg;
  cfg.width = config.dimensions.width;
  cfg.height = config.dimensions.height;
  cfg.framerate = config.frameRate;
  cfg.bitrate = config.bitrate ? config.bitrate : 800;
  track_video_encoder_config_.bitrate = cfg.bitrate;
  cfg.minBitrate =
      config.minBitrate == rtc::DEFAULT_MIN_BITRATE ? 0 : config.minBitrate;
  track_video_encoder_config_.minBitrate = cfg.minBitrate;
  cfg.maxBitrate = config.bitrate;
  cfg.orientationMode = config.orientationMode;
  is_video_encoder_set_ = true;

  video_encoder_config_ = std::move(cfg);
  if (local_user_) {
    if (published_video_track_) {
      int result = published_video_track_->setVideoEncoderConfiguration(
          track_video_encoder_config_);
      if (result != ERR_OK) {
        return result;
      }
    }

    return local_user_->setVideoStreamConfiguration(video_encoder_config_);
  }

  return ERR_OK;
}

RTE_INLINE int AgoraRteCdnLocalStream::EnableLocalAudioObserver(
    const LocalAudioObserverOptions& options) {
  RTE_LOGGER_MEMBER(nullptr);
  return -ERR_NOT_SUPPORTED;
}

RTE_INLINE int AgoraRteCdnLocalStream::DisableLocalAudioObserver() {
  RTE_LOGGER_MEMBER(nullptr);
  return -ERR_NOT_SUPPORTED;
}

RTE_INLINE int AgoraRteCdnLocalStream::SetCloudCdnTranscoding(
    const agora::rtc::LiveTranscoding& transcoding) {
  RTE_LOGGER_MEMBER(nullptr);
  return -ERR_NOT_SUPPORTED;
}

RTE_INLINE int AgoraRteCdnLocalStream::AddCloudCdnUrl(
    const std::string& target_cdn_url, bool transcoding_enabled) {
  RTE_LOGGER_MEMBER(nullptr);
  return -ERR_NOT_SUPPORTED;
}

RTE_INLINE int AgoraRteCdnLocalStream::RemoveCloudCdnUrl(
    const std::string& target_cdn_url) {
  RTE_LOGGER_MEMBER(nullptr);
  return -ERR_NOT_SUPPORTED;
}

RTE_INLINE int AgoraRteCdnLocalStream::CreateRtmpConnection() {
  RTE_LOGGER_MEMBER(nullptr);
  if (rtmp_conn_) {
    return ERR_OK;
  }
  if (!rtc_service_) {
    return -ERR_NOT_INITIALIZED;
  }

  rtc::RtmpConnectionConfiguration cfg;
  cfg.audioConfig = audio_encoder_config_;
  cfg.videoConfig = video_encoder_config_;

  auto conn = rtc_service_->createRtmpConnection(cfg);
  if (!conn) {
    RTE_LOG_ERROR << "Create rtmp connection failed!";
    return -ERR_FAILED;
  }

  rtmp_conn_ = conn;
  local_user_ = rtmp_conn_->getRtmpLocalUser();
  local_user_->registerRtmpUserObserver(this);
  rtmp_conn_->registerObserver(this);
  return ERR_OK;
}

RTE_INLINE int AgoraRteCdnLocalStream::StopDirectCdnStreamingInternal() {
  RTE_LOGGER_MEMBER(nullptr);
  if (local_user_) {
    local_user_->unregisteRtmpUserObserver(this);
    local_user_ = nullptr;
  }

  if (rtmp_conn_) {
    rtmp_conn_->disconnect();
    rtmp_conn_->unregisterObserver(this);
    rtmp_conn_ = nullptr;
  }

  streaming_state_ = STATE_PUBLISH_STOPPED;
  return ERR_OK;
}

// IRtmpConnectionObserver
RTE_INLINE void AgoraRteCdnLocalStream::onConnected(
    const rtc::RtmpConnectionInfo& connection_info) {
  RTE_LOGGER_CALLBACK(onConnected, "connection_info: (state: %d)",
                      connection_info.state);
  streaming_state_ = STATE_PUBLISHED;
}

RTE_INLINE void AgoraRteCdnLocalStream::onDisconnected(
    const rtc::RtmpConnectionInfo& connection_info) {
  RTE_LOGGER_CALLBACK(onDisconnected, "connection_info: (state: %d)",
                      connection_info.state);
  /*StopDirectCdnStreamingInternal();*/
}

RTE_INLINE void AgoraRteCdnLocalStream::onReconnecting(
    const rtc::RtmpConnectionInfo& connection_info) {
  RTE_LOGGER_CALLBACK(onReconnecting, "connection_info: (state: %d)",
                      connection_info.state);
}

RTE_INLINE void AgoraRteCdnLocalStream::onReconnected(
    const rtc::RtmpConnectionInfo& connection_info) {
  RTE_LOGGER_CALLBACK(onReconnected, "connection_info: (state: %d)",
                      connection_info.state);
}

RTE_INLINE void AgoraRteCdnLocalStream::onConnectionFailure(
    const rtc::RtmpConnectionInfo& connection_info,
    rtc::RTMP_CONNECTION_ERROR err_code) {
  RTE_LOGGER_CALLBACK(onConnectionFailure,
                      "connection_info: (state: %d), err_code: %d",
                      connection_info.state, err_code);
  if (streaming_state_ == STATE_PUBLISH_FAILED ||
      streaming_state_ == STATE_PUBLISH_STOPPED) {
    return;
  }

  /*StopDirectCdnStreamingInternal();*/
}

RTE_INLINE void AgoraRteCdnLocalStream::onTransferStatistics(
    uint64_t video_bitrate, uint64_t audio_bitrate, uint64_t video_frame_rate,
    uint64_t push_video_frame_cnt, uint64_t pop_video_frame_cnt) {
  RTE_LOGGER_CALLBACK(onTransferStatistics,
                      "video_bitrate: %" PRIu64 ", audio_bitrate: %" PRIu64
                      ", video_frame_rate: %" PRIu64
                      " push_video_frame_cnt: %" PRIu64
                      " pop_video_frame_cnt: %" PRIu64 "",
                      video_bitrate, audio_bitrate, video_frame_rate,
                      push_video_frame_cnt, pop_video_frame_cnt);
}

RTE_INLINE void AgoraRteCdnLocalStream::FireStreamStateChange(
    MediaType media_type, StreamMediaState old_state,
    StreamMediaState new_state, StreamStateChangedReason reason) {
  RTE_LOGGER_MEMBER("media_type: %d, old_state: %d, new_state: %d, reason: %d",
                    media_type, old_state, new_state, reason);
  auto scene = scene_.lock();
  if (!scene) {
    return;
  }

  StreamInfo info;
  info.user_id = scene->GetLocalUserInfo().user_id;
  info.stream_id = stream_id_;

  scene->OnLocalStreamStateChanged(info, media_type, old_state, new_state,
                                   reason);
}

RTE_INLINE void AgoraRteCdnLocalStream::onAudioTrackPublishSuccess(
    agora_refptr<rtc::ILocalAudioTrack> audio_track) {
  RTE_LOGGER_CALLBACK(onAudioTrackPublishSuccess, "audio_track: %p",
                      audio_track.get());
  StreamMediaState old_state = StreamMediaState::kIdle;
  auto it = published_audio_tracks_.find(audio_track);
  if (it != published_audio_tracks_.end()) {
    old_state = it->second;
    it->second = StreamMediaState::kStreaming;
  }

  FireStreamStateChange(MediaType::kAudio, old_state,
                        StreamMediaState::kStreaming,
                        StreamStateChangedReason::kPublished);
}

RTE_INLINE void AgoraRteCdnLocalStream::onAudioTrackPublicationFailure(
    agora_refptr<rtc::ILocalAudioTrack> audio_track,
    rtc::PublishAudioError error) {
  RTE_LOGGER_CALLBACK(onAudioTrackPublicationFailure,
                      "audio_track: %p, error: %d", audio_track.get(), error);
  StreamMediaState old_state = StreamMediaState::kIdle;
  auto it = published_audio_tracks_.find(audio_track);
  if (it != published_audio_tracks_.end()) {
    old_state = it->second;
    it->second = StreamMediaState::kIdle;
  }

  FireStreamStateChange(MediaType::kAudio, old_state, StreamMediaState::kIdle,
                        StreamStateChangedReason::kPublished);
}

RTE_INLINE void AgoraRteCdnLocalStream::onVideoTrackPublishSuccess(
    agora_refptr<rtc::ILocalVideoTrack> video_track) {
  RTE_LOGGER_CALLBACK(onVideoTrackPublishSuccess, "video_track: %p",
                      video_track.get());
  StreamMediaState old_state = published_video_stream_state_;
  published_video_stream_state_ = StreamMediaState::kStreaming;
  FireStreamStateChange(MediaType::kVideo, old_state,
                        StreamMediaState::kStreaming,
                        StreamStateChangedReason::kPublished);
}

RTE_INLINE void AgoraRteCdnLocalStream::onVideoTrackPublicationFailure(
    agora_refptr<rtc::ILocalVideoTrack> video_track,
    rtc::PublishVideoError error) {
  RTE_LOGGER_CALLBACK(onVideoTrackPublicationFailure,
                      "audio_track: %p, error: %d", video_track.get(), error);
  StreamMediaState old_state = published_video_stream_state_;
  published_video_stream_state_ = StreamMediaState::kIdle;
  FireStreamStateChange(MediaType::kVideo, old_state, StreamMediaState::kIdle,
                        StreamStateChangedReason::kPublished);
}

}  // namespace rte
}  // namespace agora
