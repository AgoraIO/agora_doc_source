//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteRtcCompatibleStream.h"

#include "AgoraRteBase.h"
#include "AgoraRteRtcStream.h"
#include "AgoraRteScene.h"
#include "AgoraRteTrackBase.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteRtcCompatibleMajorStream::AgoraRteRtcCompatibleMajorStream(
    const std::shared_ptr<AgoraRteScene>& scene,
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
    const std::string& token, const JoinOptions& options)
    : AgoraRteRtcStreamBase(scene, rtc_service,
                            {token, options.is_user_visible_to_remote}),
      AgoraRteMajorStream(scene->GetLocalUserInfo().user_id,
                          StreamType::kRtcStream) {
  rtc_stream_id_ = scene->GetLocalUserInfo().user_id;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::RegisterObservers() {
  RTE_LOGGER_MEMBER(nullptr);
  int result = -ERR_FAILED;
  auto scene = scene_.lock();

  if (scene) {
    rtc_major_stream_observer_ =
        RtcCallbackWrapper<AgoraRteRtcCompatibleStreamObserver>::Create(
            scene, std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
                       shared_from_this()));

    result = internal_rtc_connection_->registerObserver(
        rtc_major_stream_observer_.get(), [](rtc::IRtcConnectionObserver* obs) {
          auto wrapper = static_cast<agora::rte::RtcCallbackWrapper<
              AgoraRteRtcCompatibleStreamObserver>*>(obs);
          wrapper->DeleteMe();
        });

    if (result != ERR_OK) {
      return result;
    }

    rtc_major_stream_user_observer_ =
        RtcCallbackWrapper<AgoraRteRtcCompatibleUserObserver>::Create(
            scene, std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
                       shared_from_this()));

    auto rtc_local_user = internal_rtc_connection_->getLocalUser();
    result = -ERR_FAILED;

    if (rtc_local_user) {
      result = rtc_local_user->registerLocalUserObserver(
          rtc_major_stream_user_observer_.get(),
          [](rtc::ILocalUserObserver* obs) {
            auto wrapper = static_cast<agora::rte::RtcCallbackWrapper<
                AgoraRteRtcCompatibleUserObserver>*>(obs);
            wrapper->DeleteMe();
          });
    }
  }

  return result;
}

RTE_INLINE void AgoraRteRtcCompatibleMajorStream::UnregisterObservers() {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_local_user = internal_rtc_connection_->getLocalUser();

  if (rtc_local_user) {
    rtc_local_user->unregisterLocalUserObserver(
        rtc_major_stream_user_observer_.get());
    internal_rtc_connection_->unregisterObserver(
        rtc_major_stream_observer_.get());

    // Do _not_ call DeleteMe for rtc_user_observer_ as it will be called inside
    // sdk
    //
    auto state = internal_rtc_connection_->getConnectionInfo().state;
    if (state == rtc::CONNECTION_STATE_CONNECTING ||
        state == rtc::CONNECTION_STATE_CONNECTED ||
        state == rtc::CONNECTION_STATE_RECONNECTING) {
      // When the connection is gone, rtc will never fire callback again as we
      // just unregistered the observer above, so here we tell observer to try
      // to fire the exiting event if that is not fired yet
      //
      rtc_major_stream_observer_->TryToFireClosedEvent();
    }
  }
}

RTE_INLINE std::shared_ptr<AgoraRteRtcStreamBase>
AgoraRteRtcCompatibleMajorStream::GetSharedSelf() {
  RTE_LOGGER_MEMBER(nullptr);
  return std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
      shared_from_this());
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::Connect() {
  RTE_LOGGER_MEMBER(nullptr);
  return AgoraRteRtcStreamBase::Connect();
}

RTE_INLINE void AgoraRteRtcCompatibleMajorStream::Disconnect() {
  RTE_LOGGER_MEMBER(nullptr);
  return AgoraRteRtcStreamBase::Disconnect();
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::RenewSceneToken(
    const std::string& token) {
  return AgoraRteRtcStreamBase::RenewRtcToken(token);
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::PushUserInfo(
    const UserInfo& info, InstanceState state) {
  RTE_LOGGER_MEMBER(nullptr);
  return 0;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::PushStreamInfo(
    const StreamInfo& info, InstanceState state) {
  RTE_LOGGER_MEMBER(nullptr);
  return 0;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::PushMediaInfo(
    const StreamInfo& info, MediaType media_type, InstanceState state) {
  RTE_LOGGER_MEMBER(nullptr);
  return 0;
}

RTE_INLINE void AgoraRteRtcCompatibleMajorStream::AddRemoteStream(
    const std::shared_ptr<AgoraRteRtcRemoteStream>& stream) {
  RTE_LOGGER_MEMBER("stream: %p", stream.get());
  bool found = false;
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  for (auto& elem : remote_streams_) {
    if (elem->GetStreamId() == elem->GetStreamId()) {
      found = true;
      break;
    }
  }

  if (!found) {
    remote_streams_.push_back(stream);
  } else {
    RTE_LOG_WARNING << "Find duplicated remote stream id: "
                    << stream->GetStreamId();
  }
}

RTE_INLINE void AgoraRteRtcCompatibleMajorStream::RemoveRemoteStream(
    const std::string& rtc_stream_id) {
  RTE_LOGGER_MEMBER("rtc_stream_id: %s", rtc_stream_id.c_str());
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  for (auto& stream : remote_streams_) {
    if (stream->GetStreamId() == rtc_stream_id) {
      // Set current stream as the last one, then pop last one
      //
      stream = remote_streams_.back();
      remote_streams_.pop_back();
      break;
    }
  }
}

RTE_INLINE std::shared_ptr<AgoraRteRtcRemoteStream>
AgoraRteRtcCompatibleMajorStream::FindRemoteStream(
    const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  for (auto& stream : remote_streams_) {
    if (stream->GetStreamId() == stream_id) {
      return stream;
    }
  }

  return nullptr;
}

RTE_INLINE AgoraRteRtcCompatibleLocalStream::AgoraRteRtcCompatibleLocalStream(
    const std::shared_ptr<AgoraRteScene>& scene,
    const std::shared_ptr<AgoraRteRtcCompatibleMajorStream>& major_stream)
    : AgoraRteLocalStream(scene->GetLocalUserInfo().user_id,
                          major_stream->GetRtcStreamId(),
                          StreamType::kRtcStream),
      major_stream_(major_stream) {}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::UpdateOption(
    const StreamOption& input_option) {
  RTE_LOGGER_MEMBER("inout_option: (type: %d)", input_option.GetType());
  assert(input_option.GetType() == StreamType::kRtcStream);
  const auto& option = static_cast<const RtcStreamOptions&>(input_option);
  return internal_rtc_connection_->renewToken(option.token.c_str());
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::PublishLocalAudioTrack(
    const std::shared_ptr<AgoraRteRtcAudioTrackBase>& track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  Connect();

  int result = SetAudioTrack(track);
  auto local_user = internal_rtc_connection_->getLocalUser();
  auto audio_track = track->GetRtcAudioTrack();

  if (result == ERR_OK && local_user && audio_track) {
    result = local_user->publishAudio(audio_track.get());
  }

  if (result != ERR_OK) {
    UnsetAudioTrack(track);
  }

  return result;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::PublishLocalVideoTrack(
    const std::shared_ptr<AgoraRteRtcVideoTrackBase>& track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  Connect();

  int result = SetVideoTrack(track);
  auto local_user = internal_rtc_connection_->getLocalUser();
  auto video_track = track->GetRtcVideoTrack();

  if (result == ERR_OK && local_user && video_track) {
    result = local_user->publishVideo(video_track.get());
  }

  if (result != ERR_OK) {
    UnsetVideoTrack(track);
  }

  return result;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::UnpublishLocalAudioTrack(
    const std::shared_ptr<AgoraRteRtcAudioTrackBase>& track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int result = UnsetAudioTrack(track);
  auto local_user = internal_rtc_connection_->getLocalUser();
  auto audio_track = track->GetRtcAudioTrack();

  if (result == ERR_OK && local_user && audio_track) {
    result = local_user->unpublishAudio(audio_track.get());
  }

  if (result != ERR_OK) {
    UnsetAudioTrack(track);
  } else {
    contains_audio_ = !audio_tracks_.empty();
  }

  return result;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::UnpublishLocalVideoTrack(
    const std::shared_ptr<AgoraRteRtcVideoTrackBase>& track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int result = UnsetVideoTrack(track);
  auto local_user = internal_rtc_connection_->getLocalUser();
  auto video_track = track->GetRtcVideoTrack();

  if (result == ERR_OK && local_user && video_track) {
    result = local_user->unpublishVideo(video_track.get());
  }

  if (result != ERR_OK) {
    UnsetVideoTrack(track);
  } else {
    contains_video_ = false;
  }

  return result;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::SetAudioEncoderConfiguration(
    const AudioEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER("config: (audioProfile: %d)", config.audioProfile);
  auto local_user = internal_rtc_connection_->getLocalUser();
  if (local_user) {
    return local_user->setAudioEncoderConfiguration(config);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::SetVideoEncoderConfiguration(
    const VideoEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER(
      "config: (bitrate: %d, codecType: %d, degradationPreference: %d, "
      "dimensions(height: %d, width: %d), frameRate: %d, minBitrate: %d, "
      "mirrorMode: %d, orientationMode: %d)",
      config.bitrate, config.codecType, config.degradationPreference,
      config.dimensions.height, config.dimensions.width, config.frameRate,
      config.minBitrate, config.mirrorMode, config.orientationMode);

  std::lock_guard<std::recursive_mutex> lock(callback_lock_);

  config_ = config;

  if (!video_track_) {
    return -ERR_FAILED;
  }

  video_track_->BeforeVideoEncodingChanged(config);
  auto track = video_track_->GetRtcVideoTrack();
  if (track) {
    return track->setVideoEncoderConfiguration(config);
  }
  return ERR_OK;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::UnsetVideoTrack(
    std::shared_ptr<AgoraRteRtcVideoTrackBase> track) {
  // Block callback while we are erasing track
  //
  RTE_LOGGER_MEMBER("track: %p", track.get());
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  if (video_track_ && video_track_->GetTrackId() == track->GetTrackId()) {
    video_track_ = nullptr;
    return ERR_OK;
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::UnsetAudioTrack(
    std::shared_ptr<AgoraRteRtcAudioTrackBase> track) {
  // Block callback while we are erasing track
  //
  RTE_LOGGER_MEMBER("track: %p", track.get());
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  for (auto& audio_track : audio_tracks_) {
    if (audio_track->GetTrackId() == track->GetTrackId()) {
      // Set last track to current track, then pop last one
      //
      audio_track = audio_tracks_.back();
      audio_tracks_.pop_back();
      return ERR_OK;
    }
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::SetVideoTrack(
    std::shared_ptr<AgoraRteRtcVideoTrackBase> track) {
  // Block callback while we are inserting track
  //
  RTE_LOGGER_MEMBER("track: %p", track.get());
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  if (!video_track_) {
    video_track_ = track;
    if (config_.has_value()) {
      SetVideoEncoderConfiguration(config_.value());
    }
    return ERR_OK;
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::SetAudioTrack(
    std::shared_ptr<AgoraRteRtcAudioTrackBase> track) {
  // Block callback while we are inserting track
  //
  RTE_LOGGER_MEMBER("track: %p", track.get());
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  bool found = false;
  for (auto& audio_track : audio_tracks_) {
    if (audio_track->GetTrackId() == track->GetTrackId()) {
      found = true;
      break;
    }
  }

  if (!found) {
    audio_tracks_.push_back(track);
    return ERR_OK;
  }

  return -ERR_FAILED;
}

RTE_INLINE void AgoraRteRtcCompatibleMajorStream::OnConnected() {
  RTE_LOGGER_CALLBACK(OnConnected, nullptr);
  CreateRtmpService();
  int ret = 0;

  if (!transcoding_vec_.empty()) {
    agora::rtc::LiveTranscoding transcoding = transcoding_vec_.front();
    ret = rtmp_service_->setLiveTranscoding(transcoding);
    if (ret != agora::ERR_OK) {
      RTE_LOG_INFO << "<AgoraRteRtcCompatibleMajorStream::OnConnected> "
                      "transcoding failed, ret="
                   << ret;
    }
    transcoding_vec_.clear();
  }

  for (auto& map_elm : cdnbypass_url_map_) {
    ret = rtmp_service_->addPublishStreamUrl(map_elm.first.c_str(),
                                             map_elm.second);
    if (ret != agora::ERR_OK) {
      RTE_LOG_INFO
          << "<AgoraRteRtcCompatibleMajorStream::OnConnected> failed, url="
          << map_elm.first;
    }
  }
  cdnbypass_url_map_.clear();
}

RTE_INLINE void AgoraRteRtcCompatibleMajorStream::OnAudioTrackPublished(
    const agora_refptr<rtc::ILocalAudioTrack>& audio_track) {
  RTE_LOGGER_CALLBACK(OnAudioTrackPublished, "audio_track: %p",
                      audio_track.get());
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  for (auto& track : audio_tracks_) {
    if (track->GetRtcAudioTrack().get() == audio_track.get()) {
      track->OnTrackPublished();
      break;
    }
  }
}

RTE_INLINE void AgoraRteRtcCompatibleMajorStream::OnVideoTrackPublished(
    const agora_refptr<rtc::ILocalVideoTrack>& audio_track) {
  RTE_LOGGER_CALLBACK(OnVideoTrackPublished, "audio_track: %p",
                      audio_track.get());
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  if (video_track_->GetRtcVideoTrack().get() == audio_track.get()) {
    video_track_->OnTrackPublished();
  }
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::EnableLocalAudioObserver(
    const LocalAudioObserverOptions& options) {
  RTE_LOGGER_MEMBER(
      "options: (after_mix: %d, after_record: %d, before_playback: %d, "
      "numberOfChannels: %zu, sampleRateHz: %zu)",
      options.after_mix, options.after_record, options.before_playback,
      options.numberOfChannels, options.sampleRateHz);
  return UpdateLocalAudioObserver(true, options);
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::DisableLocalAudioObserver() {
  RTE_LOGGER_MEMBER(nullptr);
  return UpdateLocalAudioObserver(false);
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::SetCloudCdnTranscoding(
    const agora::rtc::LiveTranscoding& transcoding) {
  RTE_LOGGER_MEMBER(
      "transcoding: (audioBitrate: %d, audioChannels: %d, audioCodecProfile: %d, \
      audioSampleRate: %d, backgroundColor: %zu, backgroundImage: %p, backgroundImageCount: %zu, \
      height: %d, lowLatency: %d, metadata: %s, transcodingExtraInfo: %s, transcodingUsers: %p, \
      userCount: %d, videoBitrate: %d, videoCodecProfile: %d, videoFramerate: %d, videoGop: %d, \
      watermark: %p, watermarkCount: %d, width: %d)",
      transcoding.audioBitrate, transcoding.audioChannels,
      transcoding.audioCodecProfile, transcoding.audioSampleRate,
      transcoding.backgroundColor, transcoding.backgroundImage,
      transcoding.backgroundImageCount, transcoding.height,
      transcoding.lowLatency, transcoding.metadata ? transcoding.metadata : "",
      transcoding.transcodingExtraInfo ? transcoding.transcodingExtraInfo : "",
      transcoding.transcodingUsers, transcoding.userCount,
      transcoding.videoBitrate, transcoding.videoCodecProfile,
      transcoding.videoFramerate, transcoding.videoGop, transcoding.watermark,
      transcoding.watermarkCount, transcoding.width);
  rtc::TConnectionInfo conn_info =
      internal_rtc_connection_->getConnectionInfo();
  int ret = agora::ERR_OK;

  if (conn_info.state != rtc::CONNECTION_STATE_CONNECTED) {
    // cache the transcoding, we don't deep clone the content of
    // LiveTranscoding
    transcoding_vec_.clear();
    transcoding_vec_.push_back(transcoding);

  } else {
    CreateRtmpService();

    transcoding_vec_.clear();
    ret = rtmp_service_->setLiveTranscoding(transcoding);
  }

  return ret;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::AddCloudCdnUrl(
    const std::string& target_cdn_url, bool transcoding_enabled) {
  RTE_LOGGER_MEMBER("target_cdn_url: %s, transcoding_enabled: %d",
                    target_cdn_url.c_str(), transcoding_enabled);
  rtc::TConnectionInfo conn_info =
      internal_rtc_connection_->getConnectionInfo();
  int ret = agora::ERR_OK;

  if (conn_info.state != rtc::CONNECTION_STATE_CONNECTED) {
    // cache the bypass cdn url
    cdnbypass_url_map_.emplace(target_cdn_url, transcoding_enabled);

  } else {
    CreateRtmpService();

    for (auto& map_elm : cdnbypass_url_map_) {
      ret = rtmp_service_->addPublishStreamUrl(map_elm.first.c_str(),
                                               map_elm.second);
      if (ret != agora::ERR_OK) {
        RTE_LOG_INFO
            << "<AgoraRteRtcCompatibleMajorStream::AddCloudCdnUrl> failed, url="
            << map_elm.first;
      }
    }
    cdnbypass_url_map_.clear();

    ret = rtmp_service_->addPublishStreamUrl(target_cdn_url.c_str(),
                                             transcoding_enabled);
  }

  return ret;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::RemoveCloudCdnUrl(
    const std::string& target_cdn_url) {
  RTE_LOGGER_MEMBER("target_cdn_url: %s", target_cdn_url.c_str());
  rtc::TConnectionInfo conn_info =
      internal_rtc_connection_->getConnectionInfo();
  int ret = agora::ERR_OK;

  if (conn_info.state != rtc::CONNECTION_STATE_CONNECTED) {
    // earsh the bypass cdn url
    cdnbypass_url_map_.erase(target_cdn_url);

  } else {
    CreateRtmpService();

    for (auto& map_elm : cdnbypass_url_map_) {
      ret = rtmp_service_->removePublishStreamUrl(map_elm.first.c_str());
      if (ret != agora::ERR_OK) {
        RTE_LOG_INFO << "<AgoraRteRtcCompatibleMajorStream::RemoveCloudCdnUrl> "
                        "failed, url="
                     << map_elm.first;
      }
    }
    cdnbypass_url_map_.clear();

    ret = rtmp_service_->removePublishStreamUrl(target_cdn_url.c_str());
  }

  return ret;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::CreateRtmpService() {
  RTE_LOGGER_MEMBER(nullptr);
  if (rtmp_service_ != nullptr) {
    return agora::ERR_OK;
  }

  SdkConfig sdk_config;
  AgoraRteSDK::GetConfig(sdk_config);
  auto rtmp_srv = rtc_service_->createRtmpStreamingService(
      internal_rtc_connection_.get(), sdk_config.appid.c_str());
  assert(rtmp_srv.get() != nullptr);
  rtmp_srv->AddRef();
  rtmp_service_ = {static_cast<rtc::IRtmpStreamingService*>(rtmp_srv.get()),
                   [](rtc::IRtmpStreamingService* con) {
                     if (con) {
                       con->Release();
                     }
                   }};

  auto scene = scene_.lock();
  rtmp_observer_ =
      RtcCallbackWrapper<AgoraRteRtcCompatibleStreamCdnObserver>::Create(
          scene, std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
                     shared_from_this()));
  rtmp_service_->registerObserver(rtmp_observer_.get());
  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteRtcCompatibleMajorStream::DestroyRtmpService() {
  RTE_LOGGER_MEMBER(nullptr);
  if (rtmp_service_ != nullptr) {
    rtmp_service_->unregisterObserver(rtmp_observer_.get());
    rtmp_service_.reset();
    rtmp_observer_.reset();
  }
  return agora::ERR_OK;
}

RTE_INLINE AgoraRteRtcCompatibleUserObserver::AgoraRteRtcCompatibleUserObserver(
    const std::shared_ptr<AgoraRteScene>& scene,
    const std::shared_ptr<AgoraRteRtcCompatibleMajorStream>& stream)
    : scene_(scene), stream_(stream) {}

RTE_INLINE AgoraRteRtcCompatibleStreamObserver::
    ~AgoraRteRtcCompatibleStreamObserver() {
  if (fire_connection_closed_event_ && !is_close_event_failed_) {
    //  When we are here , the connection is already gone, so we get scene for
    //  weak_ptr
    //
    auto scene = scene_.lock();

    if (scene) {
      scene->ChangeSceneState(SceneState::kDisconnected,
                              rtc::CONNECTION_CHANGED_REASON_TYPE::
                                  CONNECTION_CHANGED_LEAVE_CHANNEL);
    }
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onConnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onConnected,
                      "connection_info: (channelId : %s), reason: %d",
                      ToString(connection_info).c_str(), reason);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_CONNECTED);
    scene->ChangeSceneState(conn_stat, reason);
    stream->OnConnected();
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onDisconnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onDisconnected,
                      "connection_info: (channelId : %s), reason: %d",
                      ToString(connection_info).c_str(), reason);

  RTE_LOG_VERBOSE << "Disconnected: " << connection_info.localUserId;
  // is_close_event_failed_ is to tell whether we should fire
  // CONNECTION_STATE_DISCONNECTED event in here or destructor function.
  // Note that fire_connection_closed_event_ is for rtc connection to tell us
  // to fire the event before our observer is unregistered
  is_close_event_failed_ = true;

  auto scene = scene_.lock();
  auto stream = stream_.lock();

  if (stream && scene) {
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_DISCONNECTED);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onConnecting(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onConnecting,
                      "connection_info: (channelId : %s), reason: %d",
                      ToString(connection_info).c_str(), reason);
  RTE_LOG_VERBOSE << "Connecting: " << connection_info.localUserId;
  is_close_event_failed_ = false;
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_CONNECTING);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onReconnecting(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onReconnecting,
                      "connection_info: (channelId : %s), reason: %d",
                      ToString(connection_info).c_str(), reason);
  RTE_LOG_VERBOSE << "Reconnecting: " << connection_info.localUserId;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_RECONNECTING);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onReconnected(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onReconnected,
                      "connection_info: (channelId : %s), reason: %d",
                      ToString(connection_info).c_str(), reason);
  RTE_LOG_VERBOSE << "Reconnected: " << connection_info.localUserId;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat = AgoraRteUtils::GetConnStateFromRtcState(
        rtc::CONNECTION_STATE_CONNECTED);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onConnectionLost(
    const rtc::TConnectionInfo& connection_info) {
  RTE_LOGGER_CALLBACK(onConnectionLost, "connection_info: (channelId : %s)",
                      ToString(connection_info).c_str());
  RTE_LOG_VERBOSE << "LostConnect: " << connection_info.localUserId;

  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat =
        AgoraRteUtils::GetConnStateFromRtcState(rtc::CONNECTION_STATE_FAILED);
    scene->ChangeSceneState(
        conn_stat,
        rtc::CONNECTION_CHANGED_REASON_TYPE::CONNECTION_CHANGED_LOST);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onUserJoined(
    user_id_t user_id) {
  RTE_LOGGER_CALLBACK(onUserJoined, "user_id: %s", user_id);
  std::string user_id_str(user_id ? user_id : "");
  RTE_LOG_VERBOSE << "user_id: " << user_id_str;
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  RteRtcStreamInfo info;

  if (scene && local_stream) {
    auto is_extract_ok = AgoraRteUtils::ExtractRtcStreamInfo(user_id_str, info);
    // Compatible mode could accept both NGAPI protocal connection and
    // RTC protocal connection
    //
    if (is_extract_ok) {
      // NGAPI protocal connection
      //
      if (info.is_major_stream) {
        scene->AddRemoteUser(info.user_id);
      } else if (info.user_id != scene->GetLocalUserInfo().user_id) {
        auto remote_stream = std::make_shared<AgoraRteRtcRemoteStream>(
            info.user_id, local_stream->GetRtcService(), info.stream_id,
            user_id_str, local_stream);

        local_stream->AddRemoteStream(remote_stream);
        scene->AddRemoteStream(info.stream_id, remote_stream);
      }
    } else {
      // RTC protocal connection
      //
      scene->AddRemoteUser(user_id_str);

      auto remote_stream = std::make_shared<AgoraRteRtcRemoteStream>(
          user_id_str, local_stream->GetRtcService(), user_id_str, user_id_str,
          local_stream);

      local_stream->AddRemoteStream(remote_stream);
      scene->AddRemoteStream(user_id_str, remote_stream);
    }
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onUserLeft(
    user_id_t user_id, rtc::USER_OFFLINE_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onUserLeft, "user_id: %s, reason: %d", user_id, reason);

  std::string user_id_str(user_id ? user_id : "");
  RTE_LOG_VERBOSE << "user_id: " << user_id_str;
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  if (scene && local_stream) {
    scene->RemoveRemoteUser(user_id_str);

    local_stream->RemoveRemoteStream(user_id_str);
    scene->RemoveRemoteStream(user_id_str);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onTokenPrivilegeWillExpire(
    const char* token) {
  RTE_LOGGER_CALLBACK(onTokenPrivilegeWillExpire, "token: %s",
                      token ? token : "");
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  if (local_stream && scene) {
    std::string token_s(token);
    scene->OnSceneTokenWillExpire(token_s);
  }
}

RTE_INLINE void
AgoraRteRtcCompatibleStreamObserver::onTokenPrivilegeDidExpire() {
  RTE_LOGGER_CALLBACK(onTokenPrivilegeDidExpire, nullptr);
  auto local_stream = stream_.lock();
  auto scene = scene_.lock();

  if (local_stream && scene) {
    scene->OnSceneTokenExpired();
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onLastmileQuality(
    const rtc::QUALITY_TYPE quality) {
  RTE_LOGGER_CALLBACK(onLastmileQuality, "quality: %d", quality);
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onLastmileProbeResult(
    const rtc::LastmileProbeResult& result) {
  RTE_LOGGER_CALLBACK(onLastmileProbeResult, nullptr);
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onConnectionFailure(
    const rtc::TConnectionInfo& connection_info,
    rtc::CONNECTION_CHANGED_REASON_TYPE reason) {
  RTE_LOGGER_CALLBACK(onConnectionFailure,
                      "connection_info: (channelId : %s), reason: %d",
                      ToString(connection_info).c_str(), reason);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto conn_stat =
        AgoraRteUtils::GetConnStateFromRtcState(rtc::CONNECTION_STATE_FAILED);
    scene->ChangeSceneState(conn_stat, reason);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamObserver::onTransportStats(
    const rtc::RtcStats& stats) {}

RTE_INLINE void
AgoraRteRtcCompatibleStreamObserver::onChannelMediaRelayStateChanged(int state,
                                                                     int code) {
  RTE_LOGGER_CALLBACK(onChannelMediaRelayStateChanged, "state: %d, code: %d",
                      state, code);
}

RTE_INLINE std::string AgoraRteRtcCompatibleStreamObserver::ToString(
    const rtc::TConnectionInfo& connection_info) {
  std::stringstream ss;
  ss << " channelId:"
     << ((connection_info.channelId.get() == nullptr)
             ? ""
             : connection_info.channelId.get()->c_str());
  ss << " localUserId:"
     << ((connection_info.localUserId.get() == nullptr)
             ? ""
             : connection_info.localUserId.get()->c_str());
  ss << " id:" << connection_info.id;
  ss << " state:" << connection_info.state;
  ss << " internalUid:" << connection_info.internalUid;
  return ss.str();
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onAudioTrackPublishSuccess(
    agora_refptr<rtc::ILocalAudioTrack> audio_track) {
  RTE_LOGGER_CALLBACK(onAudioTrackPublishSuccess, "audio_track: %p",
                      audio_track.get());
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->OnAudioTrackPublished(audio_track);
  }
}

RTE_INLINE
AgoraRteRtcCompatibleStreamCdnObserver::AgoraRteRtcCompatibleStreamCdnObserver(
    const std::shared_ptr<AgoraRteScene>& scene,
    const std::shared_ptr<AgoraRteRtcCompatibleMajorStream>& stream)
    : scene_(scene), stream_(stream) {}

RTE_INLINE void
AgoraRteRtcCompatibleStreamCdnObserver::onRtmpStreamingStateChanged(
    const char* url, agora::rtc::RTMP_STREAM_PUBLISH_STATE state,
    agora::rtc::RTMP_STREAM_PUBLISH_ERROR_TYPE err_code) {
  RTE_LOGGER_CALLBACK(onRtmpStreamingStateChanged,
                      "url: %s, state: %d, err_code: %d", url ? url : "", state,
                      err_code);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnStateChanged(stream_id, url, state, err_code);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamCdnObserver::onStreamPublished(
    const char* url, int error) {
  RTE_LOGGER_CALLBACK(onStreamPublished, "url: %s, error: %d", url ? url : "",
                      error);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnPublished(stream_id, url, error);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamCdnObserver::onStreamUnpublished(
    const char* url) {
  RTE_LOGGER_CALLBACK(onStreamUnpublished, "url: %s", url ? url : "");
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnUnpublished(stream_id, url);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleStreamCdnObserver::onTranscodingUpdated() {
  RTE_LOGGER_CALLBACK(onTranscodingUpdated, nullptr);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    std::string stream_id = stream->GetStreamId();
    scene->OnCdnTranscodingUpdated(stream_id);
  }
}

// 1
RTE_INLINE void
AgoraRteRtcCompatibleUserObserver::onAudioTrackPublicationFailure(
    agora_refptr<rtc::ILocalAudioTrack> audio_track, ERROR_CODE_TYPE error) {
  RTE_LOGGER_CALLBACK(onAudioTrackPublicationFailure,
                      "audio_track: %p, error: %d", audio_track.get(), error);
}
// 1
RTE_INLINE void
AgoraRteRtcCompatibleUserObserver::onLocalAudioTrackStateChanged(
    agora_refptr<rtc::ILocalAudioTrack> audio_track,
    rtc::LOCAL_AUDIO_STREAM_STATE state,
    rtc::LOCAL_AUDIO_STREAM_ERROR error_code) {
  RTE_LOGGER_CALLBACK(onLocalAudioTrackStateChanged,
                      "audio_track: %p, state: %d, error_code: %d",
                      audio_track.get(), state, error_code);
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onLocalAudioTrackStatistics(
    const rtc::LocalAudioStats& stats) {}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onRemoteAudioTrackStatistics(
    agora_refptr<rtc::IRemoteAudioTrack> audio_track,
    const rtc::RemoteAudioTrackStats& stats) {}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onUserAudioTrackSubscribed(
    user_id_t user_id, agora_refptr<rtc::IRemoteAudioTrack> audio_track) {
  RTE_LOGGER_CALLBACK(onUserAudioTrackSubscribed,
                      "user_id: %s, audio_track: %p", user_id,
                      audio_track.get());
  std::string user_id_str(user_id);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto remote_stream = stream->FindRemoteStream(user_id_str);
    if (remote_stream) {
      auto remote_audio_track =
          AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IRemoteAudioTrack>(
              audio_track);
      remote_stream->OnAudioTrackSubscribed(remote_audio_track);
    }
  }
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onUserAudioTrackStateChanged(
    user_id_t user_id, agora_refptr<rtc::IRemoteAudioTrack> audio_track,
    rtc::REMOTE_AUDIO_STATE state, rtc::REMOTE_AUDIO_STATE_REASON reason,
    int elapsed) {
  RTE_LOGGER_CALLBACK(
      onUserAudioTrackStateChanged,
      "user_id: %s, audio_track: %p, state: %d, reason: %d, elapsed: %d",
      user_id, audio_track.get(), state, reason, elapsed);
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onVideoTrackPublishSuccess(
    agora_refptr<rtc::ILocalVideoTrack> video_track) {
  RTE_LOGGER_CALLBACK(onVideoTrackPublishSuccess, "video_track: %p",
                      video_track.get());
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    stream->OnVideoTrackPublished(video_track);
  }
}

RTE_INLINE void
AgoraRteRtcCompatibleUserObserver::onVideoTrackPublicationFailure(
    agora_refptr<rtc::ILocalVideoTrack> video_track, ERROR_CODE_TYPE error) {
  RTE_LOGGER_CALLBACK(onVideoTrackPublicationFailure,
                      "video_track: %p, error: %d", video_track.get(), error);
}

RTE_INLINE void
AgoraRteRtcCompatibleUserObserver::onLocalVideoTrackStateChanged(
    agora_refptr<rtc::ILocalVideoTrack> video_track,
    rtc::LOCAL_VIDEO_STREAM_STATE state,
    rtc::LOCAL_VIDEO_STREAM_ERROR error_code) {
  RTE_LOGGER_CALLBACK(onLocalVideoTrackStateChanged,
                      "video_track: %p, state: %d, error_code: %d",
                      video_track.get(), state, error_code);
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onLocalVideoTrackStatistics(
    agora_refptr<rtc::ILocalVideoTrack> video_track,
    const rtc::LocalVideoTrackStats& stats) {}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onUserVideoTrackSubscribed(
    user_id_t user_id, rtc::VideoTrackInfo track_info,
    agora_refptr<rtc::IRemoteVideoTrack> video_track) {
  std::string user_id_str(user_id);
  auto stream = stream_.lock();
  auto scene = scene_.lock();

  if (stream && scene) {
    auto remote_stream = stream->FindRemoteStream(user_id_str);
    if (remote_stream) {
      auto remote_video_track =
          AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IRemoteVideoTrack>(
              video_track);
      remote_stream->OnVideoTrackSubscribed(remote_video_track);
    }
  }
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onUserVideoTrackStateChanged(
    user_id_t user_id, agora_refptr<rtc::IRemoteVideoTrack> video_track,
    rtc::REMOTE_VIDEO_STATE state, rtc::REMOTE_VIDEO_STATE_REASON reason,
    int elapsed) {
  RTE_LOGGER_CALLBACK(
      onUserAudioTrackStateChanged,
      "user_id: %s, audio_track: %p, state: %d, reason: %d, elapsed: %d",
      user_id, video_track.get(), state, reason, elapsed);
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onRemoteVideoTrackStatistics(
    agora_refptr<rtc::IRemoteVideoTrack> video_track,
    const rtc::RemoteVideoTrackStats& stats) {}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onAudioVolumeIndication(
    const rtc::AudioVolumeInformation* speakers, unsigned int speaker_number,
    int total_volume) {
  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    std::vector<AudioVolumeInfo> infos(speaker_number);
    for (unsigned int i = 0; i < speaker_number; i++) {
      infos.push_back({speakers->userId, speakers->volume, speakers->vad,
                       speakers->voicePitch});
      speakers++;
    }
    scene->OnAudioVolumeIndication(infos, total_volume);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onActiveSpeaker(user_id_t userId) {
  auto scene = scene_.lock();
  auto stream = stream_.lock();
  std::string user_id_str(userId);
  if (scene && stream) {
    scene->OnActiveSpeaker(user_id_str);
  }
}

RTE_INLINE void
AgoraRteRtcCompatibleUserObserver::onSubscribeStateChangedCommon(
    const char* channel, user_id_t user_id,
    rtc::STREAM_SUBSCRIBE_STATE old_state,
    rtc::STREAM_SUBSCRIBE_STATE new_state, int elapse_since_last_state,
    MediaType type) {
  RTE_LOGGER_CALLBACK(onSubscribeStateChangedCommon,
                      "channel: %s, user_id: %s, old_state: %d, new_state: %d, "
                      "elapse_since_last_state: %d, type: %d",
                      channel ? channel : "", user_id, old_state, new_state,
                      elapse_since_last_state, type);

  auto stream = stream_.lock();
  auto scene = scene_.lock();
  std::string user_id_str(user_id);

  if (scene && stream) {
    SubscribeState state = SubscribeState::kFailed;
    bool notify_callback = false;

    if (old_state == rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBING &&
        new_state == rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBED) {
      state = SubscribeState::kSubscribed;
      notify_callback = true;
    }

    if (old_state == rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBED &&
        new_state != rtc::STREAM_SUBSCRIBE_STATE::SUB_STATE_SUBSCRIBED) {
      state = SubscribeState::kNoSubscribe;
      notify_callback = true;
    }

    if (notify_callback) {
      StreamInfo info;

      info.stream_id = user_id_str;
      info.user_id = user_id_str;

      if (state == SubscribeState::kSubscribed) {
        switch (type) {
          case MediaType::kAudio:
            stream->OnAudioConnected();
            break;
          case MediaType::kVideo:
            stream->OnVideoConnected();
            break;
          default:
            break;
        }

        scene->OnRemoteStreamStateChanged(
            info, type, StreamMediaState::kIdle, StreamMediaState::kStreaming,
            StreamStateChangedReason::kSubscribed);
      } else {
        switch (type) {
          case MediaType::kAudio:
            stream->OnAudioDisconnected();
            break;
          case MediaType::kVideo:
            stream->OnVideoDisconnected();
            break;
          default:
            break;
        }

        scene->OnRemoteStreamStateChanged(
            info, type, StreamMediaState::kStreaming, StreamMediaState::kIdle,
            StreamStateChangedReason::kUnsubscribed);
      }
    }
  }
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onAudioSubscribeStateChanged(
    const char* channel, user_id_t user_id,
    rtc::STREAM_SUBSCRIBE_STATE old_state,
    rtc::STREAM_SUBSCRIBE_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onAudioSubscribeStateChanged,
                      "channel: %s, user_id: %s, old_state: %d, \
      new_state: %d, elapse_since_last_state: %d",
                      channel ? channel : "", user_id, old_state, new_state,
                      elapse_since_last_state);

  onSubscribeStateChangedCommon(channel, user_id, old_state, new_state,
                                elapse_since_last_state, MediaType::kAudio);
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onVideoSubscribeStateChanged(
    const char* channel, user_id_t user_id,
    rtc::STREAM_SUBSCRIBE_STATE old_state,
    rtc::STREAM_SUBSCRIBE_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onVideoSubscribeStateChanged,
                      "channel: %s, user_id: %s, old_state: %d, \
      new_state: %d, elapse_since_last_state: %d",
                      channel ? channel : "", user_id, old_state, new_state,
                      elapse_since_last_state);

  onSubscribeStateChangedCommon(channel, user_id, old_state, new_state,
                                elapse_since_last_state, MediaType::kVideo);
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onAudioPublishStateChanged(
    const char* channel, rtc::STREAM_PUBLISH_STATE old_state,
    rtc::STREAM_PUBLISH_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onAudioPublishStateChanged,
                      "channel: %s, old_state: %d, \
      new_state: %d, elapse_since_last_state: %d",
                      channel ? channel : "", old_state, new_state,
                      elapse_since_last_state);

  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    AgoraRteRtcObserveHelper::onPublishStateChanged(
        channel, old_state, new_state, elapse_since_last_state,
        MediaType::kAudio, scene, stream);
  }
}

RTE_INLINE void AgoraRteRtcCompatibleUserObserver::onVideoPublishStateChanged(
    const char* channel, rtc::STREAM_PUBLISH_STATE old_state,
    rtc::STREAM_PUBLISH_STATE new_state, int elapse_since_last_state) {
  RTE_LOGGER_CALLBACK(onVideoPublishStateChanged,
                      "channel: %s, old_state: %d, \
      new_state: %d, elapse_since_last_state: %d",
                      channel ? channel : "", old_state, new_state,
                      elapse_since_last_state);

  auto scene = scene_.lock();
  auto stream = stream_.lock();
  if (scene && stream) {
    AgoraRteRtcObserveHelper::onPublishStateChanged(
        channel, old_state, new_state, elapse_since_last_state,
        MediaType::kVideo, scene, stream);
  }
}

RTE_INLINE bool AgoraRteRtcCompatibleAudioFrameObserver::onRecordAudioFrame(
    const char* channelId, AudioFrame& audio_frame) {
  auto scene = scene_.lock();
  if (scene) {
    scene->OnRecordAudioFrame(audio_frame);
  }

  return true;
}

RTE_INLINE bool AgoraRteRtcCompatibleAudioFrameObserver::onPlaybackAudioFrame(
    const char* channelId, AudioFrame& audio_frame) {
  auto scene = scene_.lock();
  if (scene) {
    scene->OnPlaybackAudioFrame(audio_frame);
  }

  return true;
}

RTE_INLINE bool AgoraRteRtcCompatibleAudioFrameObserver::onMixedAudioFrame(
    const char* channelId, AudioFrame& audio_frame) {
  auto scene = scene_.lock();
  if (scene) {
    scene->OnMixedAudioFrame(audio_frame);
  }

  return true;
}

RTE_INLINE bool
AgoraRteRtcCompatibleAudioFrameObserver::onEarMonitoringAudioFrame(
    AudioFrame& audio_frame) {
  return false;
}

RTE_INLINE bool
AgoraRteRtcCompatibleAudioFrameObserver::onPlaybackAudioFrameBeforeMixing(
    const char* channelId, user_id_t user_id, AudioFrame& audio_frame) {
  auto scene = scene_.lock();
  if (scene) {
    std::string str_user_id = (nullptr == user_id) ? "" : user_id;
    scene->OnPlaybackAudioFrameBeforeMixing(str_user_id, audio_frame);
  }
  return true;
}

RTE_INLINE void AgoraRteRtcCompatibleRemoteVideoObserver::onFrame(
    const char* channel_id, user_id_t remote_uid, const VideoFrame* frame) {
  auto scene = scene_.lock();
  if (scene) {
    const std::string str_uid = (nullptr == remote_uid) ? "" : remote_uid;
    scene->OnRemoteVideoFrame(str_uid, *frame);
  }
}

}  // namespace rte
}  // namespace agora