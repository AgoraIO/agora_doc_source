//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteRtcStream.h"

#include "AgoraRteBase.h"
#include "AgoraRteRtcStreamObserver.h"
#include "AgoraRteScene.h"
#include "AgoraRteSdk.h"
#include "AgoraRteTrackBase.h"
#include "IAgoraRtmpStreamingService.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteRtcStreamBase::AgoraRteRtcStreamBase(
    const std::shared_ptr<AgoraRteScene>& scene,
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
    const RtcStreamBaseOption& base_option)
    : scene_(scene), token_(base_option.token_) {
  rtc::RtcConnectionConfiguration rtc_conn_cfg_ex;
  rtc_conn_cfg_ex.autoSubscribeAudio = false;
  rtc_conn_cfg_ex.autoSubscribeVideo = false;
  rtc_conn_cfg_ex.enableAudioRecordingOrPlayout =
      base_option.enable_record_and_playout_.has_value()
          ? base_option.enable_record_and_playout_.value()
          : true;

  if (base_option.is_user_visible_to_remote_) {
    rtc_conn_cfg_ex.clientRoleType =
        rtc::CLIENT_ROLE_TYPE::CLIENT_ROLE_BROADCASTER;
  } else {
    rtc_conn_cfg_ex.clientRoleType =
        rtc::CLIENT_ROLE_TYPE::CLIENT_ROLE_AUDIENCE;
  }

  auto rtc_con = rtc_service->createRtcConnection(rtc_conn_cfg_ex);
  assert(rtc_con.get() != nullptr);
  rtc_con->AddRef();

  internal_rtc_connection_ = {static_cast<rtc::IRtcConnection*>(rtc_con.get()),
                              [](rtc::IRtcConnection* con) {
                                if (con) {
                                  con->Release();
                                }
                              }};

  rtc_service_ = rtc_service;
}

RTE_INLINE int AgoraRteRtcStreamBase::Connect() {
  RTE_LOGGER_MEMBER(nullptr);
  auto state = internal_rtc_connection_->getConnectionInfo().state;

  if (state != rtc::CONNECTION_STATE_DISCONNECTED &&
      state != rtc::CONNECTION_STATE_FAILED) {
    // The connection state is still active, return directly
    //
    return ERR_OK;
  }

  auto scene = scene_.lock();

  if (scene) {
    std::string scene_id = scene->GetSceneInfo().scene_id;

    auto rtc_local_user = internal_rtc_connection_->getLocalUser();

    if (rtc_local_user) {
      int result = RegisterObservers();
      if (result != ERR_OK) {
        return result;
      }

      RTE_LOG_INFO << "Connecting " << rtc_stream_id_;

      return internal_rtc_connection_->connect(token_.c_str(), scene_id.c_str(),
                                               rtc_stream_id_.c_str());
    }
  }

  return -ERR_FAILED;
}

RTE_INLINE void AgoraRteRtcStreamBase::Disconnect() {
  RTE_LOGGER_MEMBER(nullptr);
  UnregisterObservers();

  RTE_LOG_INFO << "Disconnect " << rtc_stream_id_;

  auto rtc_local_user = internal_rtc_connection_->getLocalUser();

  if (rtc_audio_observer_) {
    rtc_local_user->unregisterAudioFrameObserver(rtc_audio_observer_.get());
  }

  if (rtc_remote_video_observer_) {
    rtc_local_user->unregisterVideoFrameObserver(
        rtc_remote_video_observer_.get());
  }

  internal_rtc_connection_->disconnect();
}

RTE_INLINE int AgoraRteRtcStreamBase::RenewRtcToken(const std::string& token) {
  return internal_rtc_connection_->renewToken(token.c_str());
}

RTE_INLINE AgoraRteRtcMajorStream::AgoraRteRtcMajorStream(
    const std::shared_ptr<AgoraRteScene>& scene,
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
    const std::string& token, const JoinOptions& options)
    : AgoraRteRtcStreamBase(scene, rtc_service,
                            {token, options.is_user_visible_to_remote}),
      AgoraRteMajorStream(scene->GetLocalUserInfo().user_id,
                          StreamType::kRtcStream) {
  rtc_stream_id_ = AgoraRteUtils::GenerateRtcStreamId(
      true, scene->GetLocalUserInfo().user_id, "");
}

RTE_INLINE int AgoraRteRtcMajorStream::Connect() {
  RTE_LOGGER_MEMBER(nullptr);
  return AgoraRteRtcStreamBase::Connect();
}

RTE_INLINE void AgoraRteRtcMajorStream::Disconnect() {
  RTE_LOGGER_MEMBER(nullptr);
  AgoraRteRtcStreamBase::Disconnect();
}

RTE_INLINE int AgoraRteRtcMajorStream::RenewSceneToken(
    const std::string& token) {
  return AgoraRteRtcStreamBase::RenewRtcToken(token);
}

RTE_INLINE int AgoraRteRtcMajorStream::RegisterObservers() {
  RTE_LOGGER_MEMBER(nullptr);
  int result = -ERR_FAILED;
  auto scene = scene_.lock();

  if (scene) {
    rtc_major_stream_observer_ =
        RtcCallbackWrapper<AgoraRteRtcMajorStreamObserver>::Create(
            scene, std::static_pointer_cast<AgoraRteRtcMajorStream>(
                       shared_from_this()));

    result = internal_rtc_connection_->registerObserver(
        rtc_major_stream_observer_.get(), [](rtc::IRtcConnectionObserver* obs) {
          auto wrapper = static_cast<
              agora::rte::RtcCallbackWrapper<AgoraRteRtcMajorStreamObserver>*>(
              obs);
          wrapper->DeleteMe();
        });

    if (result != ERR_OK) {
      return result;
    }

    rtc_major_stream_user_observer_ =
        RtcCallbackWrapper<AgoraRteRtcMajorStreamUserObserver>::Create(
            scene, std::static_pointer_cast<AgoraRteRtcMajorStream>(
                       shared_from_this()));

    auto rtc_local_user = internal_rtc_connection_->getLocalUser();
    result = -ERR_FAILED;

    if (rtc_local_user) {
      result = rtc_local_user->registerLocalUserObserver(
          rtc_major_stream_user_observer_.get(),
          [](rtc::ILocalUserObserver* obs) {
            auto wrapper = static_cast<agora::rte::RtcCallbackWrapper<
                AgoraRteRtcMajorStreamUserObserver>*>(obs);
            wrapper->DeleteMe();
          });
    }
  }

  return result;
}

RTE_INLINE int AgoraRteRtcStreamBase::UpdateRemoteAudioObserver(
    bool enable, const RemoteAudioObserverOptions& options) {
  RTE_LOGGER_MEMBER(
      "enable: %d, option: (after_playback_before_mix: %d, numberOfChannels: "
      "%d, sampleRateHz: %d)",
      enable, options.after_playback_before_mix, options.numberOfChannels,
      options.sampleRateHz);
  if (enable == is_remote_audio_observer_added_) {
    if (!enable || memcmp(&options, &audio_option_.remote_option,
                          sizeof(RemoteAudioObserverOptions)) == 0) {
      return ERR_OK;
    }
  }

  int result = -ERR_FAILED;
  auto scene = scene_.lock();
  auto rtc_local_user = internal_rtc_connection_->getLocalUser();

  if (rtc_local_user && scene) {
    result = ERR_OK;
    if (enable) {
      if (!rtc_audio_observer_) {
        rtc_audio_observer_ = std::make_unique<AgoraRteRtcAudioFrameObserver>(
            scene, GetSharedSelf());
        result = rtc_local_user->registerAudioFrameObserver(
            rtc_audio_observer_.get());
        if (result != ERR_OK) {
          return result;
        }
      }

      rtc_local_user->setPlaybackAudioFrameBeforeMixingParameters(
          options.numberOfChannels, options.sampleRateHz);

      is_remote_audio_observer_added_ = true;
      audio_option_.remote_option = options;

    } else {
      // Disable
      //
      if (!is_local_audio_observer_added_) {
        // Both local and remote audio are not required
        //
        result = rtc_local_user->unregisterAudioFrameObserver(
            rtc_audio_observer_.get());
        if (result != ERR_OK) {
          return result;
        }
      } else {
        // Just disable remote audio observer
        //
        rtc_local_user->setPlaybackAudioFrameBeforeMixingParameters(0, 0);
      }

      is_remote_audio_observer_added_ = false;
    }
  }
  return result;
}

RTE_INLINE int AgoraRteRtcStreamBase::UpdateLocalAudioObserver(
    bool enable, const LocalAudioObserverOptions& options) {
  RTE_LOGGER_MEMBER(
      "enable: %d, option: (after_mix: %d, after_record: %d, before_playback: %d, \
      numberOfChannels: %d, sampleRateHz: %d)",
      enable, options.after_mix, options.after_record, options.before_playback,
      options.numberOfChannels, options.sampleRateHz);

  if (enable == is_local_audio_observer_added_) {
    if (!enable || memcmp(&options, &audio_option_.local_option,
                          sizeof(LocalAudioObserverOptions)) == 0) {
      return ERR_OK;
    }
  }

  auto scene = scene_.lock();
  auto rtc_local_user = internal_rtc_connection_->getLocalUser();
  if (rtc_local_user && scene) {
    if (enable) {
      if (!rtc_audio_observer_) {
        rtc_audio_observer_ = std::make_unique<AgoraRteRtcAudioFrameObserver>(
            scene, GetSharedSelf());
        int register_ret = rtc_local_user->registerAudioFrameObserver(
            rtc_audio_observer_.get());
        if (register_ret != ERR_OK) {
          return register_ret;
        }
      }

      if (options.after_record) {
        rtc_local_user->setRecordingAudioFrameParameters(
            options.numberOfChannels, options.sampleRateHz);
      } else {
        rtc_local_user->setRecordingAudioFrameParameters(0, 0);
      }

      if (options.after_mix) {
        rtc_local_user->setMixedAudioFrameParameters(options.numberOfChannels,
                                                     options.sampleRateHz);
      } else {
        rtc_local_user->setMixedAudioFrameParameters(0, 0);
      }

      if (options.before_playback) {
        rtc_local_user->setPlaybackAudioFrameParameters(
            options.numberOfChannels, options.sampleRateHz);
      } else {
        rtc_local_user->setPlaybackAudioFrameParameters(0, 0);
      }

      is_local_audio_observer_added_ = true;
      audio_option_.local_option = options;

    } else {
      // Disable
      //
      if (!is_remote_audio_observer_added_) {
        // Both local and remote audio are not required
        //
        auto unregister_ret = rtc_local_user->unregisterAudioFrameObserver(
            rtc_audio_observer_.get());
        if (unregister_ret != ERR_OK) {
          return unregister_ret;
        }
      } else {
        // Just disable local audio observer
        //
        rtc_local_user->setRecordingAudioFrameParameters(0, 0);
        rtc_local_user->setMixedAudioFrameParameters(0, 0);
        rtc_local_user->setPlaybackAudioFrameParameters(0, 0);
      }

      is_local_audio_observer_added_ = false;
    }
  }
  return ERR_OK;
}

RTE_INLINE int AgoraRteRtcStreamBase::UpdateRemoteVideoObserver(bool enable) {
  RTE_LOGGER_MEMBER("enable: %d", enable);
  if (enable == is_remote_video_observer_added_) {
    return ERR_OK;
  }
  int result = -ERR_FAILED;
  auto scene = scene_.lock();
  auto rtc_local_user = internal_rtc_connection_->getLocalUser();

  if (rtc_local_user && scene) {
    if (enable) {
      if (!rtc_remote_video_observer_) {
        rtc_remote_video_observer_ =
            std::make_unique<AgoraRteRtcRemoteVideoObserver>(scene);
      }

      result = rtc_local_user->registerVideoFrameObserver(
          rtc_remote_video_observer_.get());
      if (result != ERR_OK) {
        return result;
      }

      is_remote_video_observer_added_ = true;
    } else {
      result = rtc_local_user->unregisterVideoFrameObserver(
          rtc_remote_video_observer_.get());
      if (result != ERR_OK) {
        return result;
      }
      is_remote_video_observer_added_ = false;
    }
  }

  return result;
}

RTE_INLINE void AgoraRteRtcMajorStream::UnregisterObservers() {
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

RTE_INLINE AgoraRteRtcLocalStream::AgoraRteRtcLocalStream(
    std::shared_ptr<AgoraRteScene> scene,
    std::shared_ptr<agora::base::IAgoraService> rtc_service,
    const std::string& stream_id, const RtcStreamOptions& options)
    : AgoraRteRtcStreamBase(scene, rtc_service, {options}),
      AgoraRteLocalStream(scene->GetLocalUserInfo().user_id, stream_id,
                          StreamType::kRtcStream) {
  rtc_stream_id_ = AgoraRteUtils::GenerateRtcStreamId(
      false, scene->GetLocalUserInfo().user_id, stream_id);
}

RTE_INLINE int AgoraRteRtcLocalStream::Connect() {
  RTE_LOGGER_MEMBER(nullptr);
  return AgoraRteRtcStreamBase::Connect();
}

RTE_INLINE void AgoraRteRtcLocalStream::Disconnect() {
  RTE_LOGGER_MEMBER(nullptr);
  return AgoraRteRtcStreamBase::Disconnect();
}

RTE_INLINE int AgoraRteRtcLocalStream::RegisterObservers() {
  RTE_LOGGER_MEMBER(nullptr);
  int result = -ERR_FAILED;
  auto scene = scene_.lock();
  if (scene) {
    rtc_local_stream_observer_ =
        RtcCallbackWrapper<AgoraRteRtcLocalStreamObserver>::Create(
            scene, std::static_pointer_cast<AgoraRteRtcLocalStream>(
                       shared_from_this()));

    result = internal_rtc_connection_->registerObserver(
        rtc_local_stream_observer_.get(), [](rtc::IRtcConnectionObserver* obs) {
          auto wrapper = static_cast<
              agora::rte::RtcCallbackWrapper<AgoraRteRtcLocalStreamObserver>*>(
              obs);
          wrapper->DeleteMe();
        });

    if (result != ERR_OK) {
      return result;
    }

    rtc_local_stream_user_observer_ =
        RtcCallbackWrapper<AgoraRteRtcLocalStreamUserObserver>::Create(
            scene, std::static_pointer_cast<AgoraRteRtcLocalStream>(
                       shared_from_this()));

    auto rtc_local_user = internal_rtc_connection_->getLocalUser();
    result = rtc_local_user->registerLocalUserObserver(
        rtc_local_stream_user_observer_.get(),
        [](rtc::ILocalUserObserver* obs) {
          auto wrapper = static_cast<agora::rte::RtcCallbackWrapper<
              AgoraRteRtcLocalStreamUserObserver>*>(obs);
          wrapper->DeleteMe();
        });
  }
  return result;
}

RTE_INLINE void AgoraRteRtcLocalStream::UnregisterObservers() {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_local_user = internal_rtc_connection_->getLocalUser();

  if (rtc_local_user) {
    rtc_local_user->unregisterLocalUserObserver(
        rtc_local_stream_user_observer_.get());
    internal_rtc_connection_->unregisterObserver(
        rtc_local_stream_observer_.get());
  }
}

RTE_INLINE int AgoraRteRtcLocalStream::UpdateOption(
    const StreamOption& input_option) {
  RTE_LOGGER_MEMBER("input_option: (type: %d)", input_option.GetType());
  assert(input_option.GetType() == StreamType::kRtcStream);
  const auto& option = static_cast<const RtcStreamOptions&>(input_option);
  return internal_rtc_connection_->renewToken(option.token.c_str());
}

RTE_INLINE int AgoraRteRtcLocalStream::PublishLocalAudioTrack(
    std::shared_ptr<AgoraRteRtcAudioTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int result = SetAudioTrack(track);
  if (result != ERR_OK) {
    return result;
  }

  const auto local_user = internal_rtc_connection_->getLocalUser();
  auto audio_track = track->GetRtcAudioTrack();

  if (result == ERR_OK && local_user && audio_track) {
    result = local_user->publishAudio(audio_track.get());
  }

  if (result != ERR_OK) {
    UnsetAudioTrack(track);
  }

  return result;
}

RTE_INLINE int AgoraRteRtcLocalStream::PublishLocalVideoTrack(
    std::shared_ptr<AgoraRteRtcVideoTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int result = SetVideoTrack(track);
  if (result != ERR_OK) {
    return result;
  }

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

RTE_INLINE int AgoraRteRtcLocalStream::UnpublishLocalAudioTrack(
    std::shared_ptr<AgoraRteRtcAudioTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int result = UnsetAudioTrack(track);
  if (result != ERR_OK) {
    return result;
  }

  auto local_user = internal_rtc_connection_->getLocalUser();
  auto audio_track = track->GetRtcAudioTrack();

  if (result == ERR_OK && local_user && audio_track) {
    result = local_user->unpublishAudio(audio_track.get());
  }

  if (result == ERR_OK) {
    contains_audio_ = !audio_tracks_.empty();
  }

  return result;
}

RTE_INLINE int AgoraRteRtcLocalStream::UnpublishLocalVideoTrack(
    std::shared_ptr<AgoraRteRtcVideoTrackBase> track) {
  RTE_LOGGER_MEMBER("track: %p", track.get());
  int result = UnsetVideoTrack(track);
  if (result != ERR_OK) {
    return result;
  }

  auto local_user = internal_rtc_connection_->getLocalUser();
  auto video_track = track->GetRtcVideoTrack();

  if (result == ERR_OK && local_user && video_track) {
    result = local_user->unpublishVideo(video_track.get());
  }

  if (result == ERR_OK) {
    contains_video_ = false;
  }

  return result;
}

RTE_INLINE int AgoraRteRtcLocalStream::SetAudioEncoderConfiguration(
    const AudioEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER("config: (audioProfile: %d)", config.audioProfile);
  auto local_user = internal_rtc_connection_->getLocalUser();
  if (local_user) {
    return local_user->setAudioEncoderConfiguration(config);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcLocalStream::SetVideoEncoderConfiguration(
    const VideoEncoderConfiguration& config) {
  RTE_LOGGER_MEMBER(
      "config: (bitrate: %d, codecType: %d, degradationPreference: %d, "
      "dimensions:(height: %d, width: %d), frameRate: %d, minBitrate: %d, "
      "mirrirMode: %d, orientationMode: %d)",
      config.bitrate, config.codecType, config.degradationPreference,
      config.dimensions.height, config.dimensions.width, config.frameRate,
      config.minBitrate, config.mirrorMode, config.orientationMode);

  std::lock_guard<std::recursive_mutex> _(callback_lock_);

  config_ = config;

  if (video_track_) {
    video_track_->BeforeVideoEncodingChanged(config);
    auto track = video_track_->GetRtcVideoTrack();
    if (track) {
      return track->setVideoEncoderConfiguration(config);
    }
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcLocalStream::CreateRtmpService() {
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
      RtcCallbackWrapper<AgoraRteRtcLocalStreamCdnObserver>::Create(
          scene,
          std::static_pointer_cast<AgoraRteRtcLocalStream>(shared_from_this()));
  rtmp_service_->registerObserver(rtmp_observer_.get());
  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteRtcLocalStream::DestroyRtmpService() {
  RTE_LOGGER_MEMBER(nullptr);
  if (rtmp_service_ != nullptr) {
    rtmp_service_->unregisterObserver(rtmp_observer_.get());
    rtmp_service_.reset();
    rtmp_observer_.reset();
  }

  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteRtcLocalStream::SetCloudCdnTranscoding(
    const agora::rtc::LiveTranscoding& transcoding) {
  RTE_LOGGER_MEMBER(
      "transcoding: (audioBitrate: %d, audioChannels: %d, audioCodecProfile: "
      "%d,audioSampleRate: %d, backgroundColor: %zu, backgroundImage: %p, "
      "backgroundImageCount: %zu,height: %d, lowLatency: %d, metadata: %s, "
      "transcodingExtraInfo: %s, transcodingUsers: %p,userCount: %d, "
      "videoBitrate: %d, videoCodecProfile: %d, videoFramerate: %d, videoGop: "
      "%d,watermark: %p, watermarkCount: %d, width: %d)",
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

  if (conn_info.state != rtc::CONNECTION_STATE_CONNECTED) {
    // cache the transcoding, we don't deep clone the content of
    // LiveTranscoding
    transcoding_vec_.clear();
    transcoding_vec_.push_back(transcoding);
    return ERR_OK;
  }

  CreateRtmpService();
  transcoding_vec_.clear();
  return rtmp_service_->setLiveTranscoding(transcoding);
}

RTE_INLINE int AgoraRteRtcLocalStream::AddCloudCdnUrl(
    const std::string& target_cdn_url, bool transcoding_enabled) {
  RTE_LOGGER_MEMBER("target_cdn_url: %s, transcoding_enabled: %d",
                    target_cdn_url.c_str(), transcoding_enabled);
  auto conn_info = internal_rtc_connection_->getConnectionInfo();

  if (conn_info.state != rtc::CONNECTION_STATE_CONNECTED) {
    // cache the bypass cdn url
    cdnbypass_url_map_.emplace(target_cdn_url, transcoding_enabled);
    return ERR_OK;
  }

  CreateRtmpService();
  for (auto& map_elm : cdnbypass_url_map_) {
    int ret = rtmp_service_->addPublishStreamUrl(map_elm.first.c_str(),
                                                 map_elm.second);
    if (ret != agora::ERR_OK) {
      RTE_LOG_INFO << "<AgoraRteRtcLocalStream::AddCloudCdnUrl> failed, url="
                   << map_elm.first;
    }
  }
  cdnbypass_url_map_.clear();

  return rtmp_service_->addPublishStreamUrl(target_cdn_url.c_str(),
                                            transcoding_enabled);
}

RTE_INLINE int AgoraRteRtcLocalStream::RemoveCloudCdnUrl(
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
        RTE_LOG_INFO
            << "<AgoraRteRtcLocalStream::RemoveCloudCdnUrl> failed, url="
            << map_elm.first;
      }
    }
    cdnbypass_url_map_.clear();

    ret = rtmp_service_->removePublishStreamUrl(target_cdn_url.c_str());
  }

  return ret;
}

RTE_INLINE int AgoraRteRtcLocalStream::UnsetVideoTrack(
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

RTE_INLINE int AgoraRteRtcLocalStream::UnsetAudioTrack(
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

RTE_INLINE int AgoraRteRtcLocalStream::SetVideoTrack(
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

RTE_INLINE int AgoraRteRtcLocalStream::SetAudioTrack(
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

RTE_INLINE void AgoraRteRtcLocalStream::OnConnected() {
  RTE_LOGGER_CALLBACK(OnConnected, nullptr);
  CreateRtmpService();
  int ret = 0;

  if (!transcoding_vec_.empty()) {
    agora::rtc::LiveTranscoding transcoding = transcoding_vec_.front();
    ret = rtmp_service_->setLiveTranscoding(transcoding);
    if (ret != agora::ERR_OK) {
      RTE_LOG_INFO
          << "<AgoraRteRtcLocalStream::OnConnected> transcoding failed, ret="
          << ret;
    }
    transcoding_vec_.clear();
  }

  for (auto& map_elm : cdnbypass_url_map_) {
    int publish_ret = rtmp_service_->addPublishStreamUrl(map_elm.first.c_str(),
                                                         map_elm.second);
    if (publish_ret != agora::ERR_OK) {
      RTE_LOG_INFO
          << "<AgoraRteRtcLocalStream::OnConnected> add url failed, url="
          << map_elm.first << ", ret=" << publish_ret;
    }
  }
  cdnbypass_url_map_.clear();
}

RTE_INLINE void AgoraRteRtcLocalStream::OnAudioTrackPublished(
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

RTE_INLINE void AgoraRteRtcLocalStream::OnVideoTrackPublished(
    const agora_refptr<rtc::ILocalVideoTrack>& audio_track) {
  RTE_LOGGER_CALLBACK(OnVideoTrackPublished, "audio_track: %p",
                      audio_track.get());
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  if (video_track_->GetRtcVideoTrack().get() == audio_track.get()) {
    video_track_->OnTrackPublished();
  }
}

RTE_INLINE AgoraRteRtcRemoteStream::AgoraRteRtcRemoteStream(
    const std::string& user_id,
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
    const std::string& stream_id, const std::string& rtc_stream_id,
    std::shared_ptr<AgoraRteRtcStreamBase> local_stream)
    : AgoraRteRemoteStream(user_id, stream_id, StreamType::kRtcStream),
      rtc_stream_(local_stream),
      rtc_service_(rtc_service),
      media_node_factory_(rtc_service->createMediaNodeFactory()),
      rtc_stream_id_(rtc_stream_id) {}

RTE_INLINE AgoraRteRtcRemoteStream::~AgoraRteRtcRemoteStream() {
  RTE_LOG_VERBOSE << "Remove Remote Stream";
  if (render_) {
    if (video_track_) {
      video_track_->removeRenderer(render_);
    }
    render_->unsetView();
  }
}

RTE_INLINE int AgoraRteRtcRemoteStream::SubscribeRemoteAudio() {
  RTE_LOGGER_MEMBER(nullptr);
  auto major_stream = rtc_stream_.lock();
  if (major_stream) {
    auto rtc_connection = major_stream->GetRtcConnection();
    auto rtc_user = rtc_connection->getLocalUser();
    if (rtc_user) {
      return rtc_user->subscribeAudio(rtc_stream_id_.c_str());
    }
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::UnsubscribeRemoteAudio() {
  RTE_LOGGER_MEMBER(nullptr);
  auto major_stream = rtc_stream_.lock();
  if (major_stream) {
    auto rtc_connection = major_stream->GetRtcConnection();
    auto rtc_user = rtc_connection->getLocalUser();
    if (rtc_user) {
      int result = rtc_user->unsubscribeAudio(rtc_stream_id_.c_str());

      if (result == ERR_OK) {
        contains_audio_ = false;
      }

      return result;
    }
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::SubscribeRemoteVideo(
    const VideoSubscribeOptions& options) {
  RTE_LOGGER_MEMBER("options: (type: %d)", options.type);
  auto major_stream = rtc_stream_.lock();
  if (major_stream) {
    auto rtc_connection = major_stream->GetRtcConnection();
    auto rtc_user = rtc_connection->getLocalUser();
    if (rtc_user) {
      rtc::VideoSubscriptionOptions subs_options;
      subs_options.type = options.type;

      return rtc_user->subscribeVideo(rtc_stream_id_.c_str(), subs_options);
    }
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::UnsubscribeRemoteVideo() {
  RTE_LOGGER_MEMBER(nullptr);
  auto major_stream = rtc_stream_.lock();
  if (major_stream) {
    auto rtc_connection = major_stream->GetRtcConnection();
    auto rtc_user = rtc_connection->getLocalUser();
    if (rtc_user) {
      int result = rtc_user->unsubscribeVideo(rtc_stream_id_.c_str());
      if (result == ERR_OK) {
        contains_video_ = false;
      }
    }
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::SetRemoteVideoCanvas(
    const VideoCanvas& canvas) {
  RTE_LOGGER_MEMBER("canvas: (mirrorMode: %d, renderMode: %d, view: %p)",
                    canvas.mirror_mode, canvas.render_mode, canvas.view);
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  if (!render_) {
    render_ = media_node_factory_->createVideoRenderer();
  }

  int result = -ERR_FAILED;

  if (render_) {
    result = render_->setMirror(canvas.mirror_mode);

    if (result != ERR_OK) {
      return result;
    }

    result = render_->setRenderMode(canvas.render_mode);

    if (result != ERR_OK) {
      return result;
    }

    result = render_->setView(canvas.view);

    if (result != ERR_OK) {
      return result;
    }

    if (video_track_) {
      video_track_->addRenderer(render_);
    }
  }

  return result;
}

RTE_INLINE int AgoraRteRtcRemoteStream::EnableRemoteVideoObserver() {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_stream = rtc_stream_.lock();
  if (rtc_stream) {
    constexpr bool enable = true;
    return rtc_stream->UpdateRemoteVideoObserver(enable);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::DisableRemoveVideoObserver() {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_stream = rtc_stream_.lock();
  if (rtc_stream) {
    constexpr bool enable = true;
    return rtc_stream->UpdateRemoteVideoObserver(!enable);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::EnableRemoteAudioObserver(
    const RemoteAudioObserverOptions& options) {
  RTE_LOGGER_MEMBER(
      "option: (after_playback_before_mix: %d, numberOfChannels: %d, "
      "sampleRateHz: %d)",
      options.after_playback_before_mix, options.numberOfChannels,
      options.sampleRateHz);
  auto rtc_stream = rtc_stream_.lock();
  if (rtc_stream) {
    constexpr bool enable = true;
    return rtc_stream->UpdateRemoteAudioObserver(enable, options);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::DisableRemoteAudioObserver() {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_stream = rtc_stream_.lock();
  if (rtc_stream) {
    constexpr bool enable = true;
    return rtc_stream->UpdateRemoteAudioObserver(!enable);
  }

  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::AdjustRemoteVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  auto rtc_stream = rtc_stream_.lock();
  if (!rtc_stream) {
    return -ERR_FAILED;
  }

  auto rtc_connection = rtc_stream->GetRtcConnection();
  if (!rtc_connection) {
    return -ERR_FAILED;
  }

  if (volume < 0) {
    volume = 0;
  }

  if (volume > 100) {
    volume = 100;
  }

  auto local_user = rtc_connection->getLocalUser();
  if (local_user) {
    return local_user->adjustUserPlaybackSignalVolume(rtc_stream_id_.c_str(),
                                                      volume);
  }
  return -ERR_FAILED;
}

RTE_INLINE int AgoraRteRtcRemoteStream::GetRemoteVolume(int* volume) {
  RTE_LOGGER_MEMBER(nullptr);
  auto rtc_stream = rtc_stream_.lock();
  if (!rtc_stream) {
    return -ERR_FAILED;
  }

  auto rtc_connection = rtc_stream->GetRtcConnection();
  if (!rtc_connection) {
    return -ERR_FAILED;
  }

  return rtc_connection->getLocalUser()->getUserPlaybackSignalVolume(
      rtc_stream_id_.c_str(), volume);
}

RTE_INLINE int AgoraRteRtcRemoteStream::SetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, const std::string& json_value) {
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  if (provider_name.empty() || extension_name.empty() || key.empty() ||
      !video_track_) {
    return -ERR_FAILED;
  }

  const char* id = rtc_service_->getExtensionId(provider_name.c_str(),
                                                extension_name.c_str());
  if (!id) {
    return -ERR_INVALID_ARGUMENT;
  }

  if (key == kExtensionPropertyEnabledKey) {
    if (json_value != kExtensionPropertyEnabledValue &&
        json_value != kExtensionPropertyDisabledValue) {
      RTE_LOG_ERROR << "invalid extension property value:" << json_value;
      return -ERR_INVALID_ARGUMENT;
    }
    bool enable = (json_value == kExtensionPropertyEnabledValue);
    return video_track_->enableVideoFilter(id, enable);
  }

  return video_track_->setFilterProperty(id, key.c_str(), json_value.c_str());
}

RTE_INLINE int AgoraRteRtcRemoteStream::GetExtensionProperty(
    const std::string& provider_name, const std::string& extension_name,
    const std::string& key, std::string& json_value) {
  std::lock_guard<std::recursive_mutex> _(callback_lock_);
  if (provider_name.empty() || extension_name.empty() || key.empty() ||
      !video_track_) {
    return -ERR_FAILED;
  }

  const char* id = rtc_service_->getExtensionId(provider_name.c_str(),
                                                extension_name.c_str());
  if (!id) {
    return -ERR_INVALID_ARGUMENT;
  }

  constexpr int length = 255;
  char ret_json_value[length];
  if (video_track_->getFilterProperty(id, key.c_str(), ret_json_value,
                                      length)) {
    return -ERR_FAILED;
  }
  json_value = ret_json_value;
  return ERR_OK;
}

RTE_INLINE void AgoraRteRtcMajorStream::AddRemoteStream(
    const std::shared_ptr<AgoraRteRtcRemoteStream>& stream) {
  RTE_LOGGER_MEMBER("stream: %p", stream.get());
  bool found = false;
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  for (auto& elem : remote_streams_) {
    if (elem->GetStreamId() == stream->GetStreamId()) {
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

RTE_INLINE void AgoraRteRtcMajorStream::RemoveRemoteStream(
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
AgoraRteRtcMajorStream::FindRemoteStream(const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  for (auto& stream : remote_streams_) {
    if (stream->GetStreamId() == stream_id) {
      return stream;
    }
  }

  return nullptr;
}

RTE_INLINE std::shared_ptr<AgoraRteRtcRemoteStream>
AgoraRteRtcMajorStream::FindRemoteStream(
    const agora_refptr<rtc::IRemoteVideoTrack>& video_track) {
  RTE_LOGGER_MEMBER("video_track: %p", video_track.get());
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  for (auto& stream : remote_streams_) {
    if (stream->GetVideoTrack().get() == video_track.get()) {
      return stream;
    }
  }
  return nullptr;
}

RTE_INLINE std::shared_ptr<AgoraRteRtcRemoteStream>
AgoraRteRtcMajorStream::FindRemoteStream(
    const agora_refptr<rtc::IRemoteAudioTrack>& audio_track) {
  RTE_LOGGER_MEMBER("audio_track: %p", audio_track.get());
  std::lock_guard<std::recursive_mutex> lock(callback_lock_);
  for (auto& stream : remote_streams_) {
    if (stream->GetAudioTrack().get() == audio_track.get()) {
      return stream;
    }
  }
  return nullptr;
}

}  // namespace rte
}  // namespace agora
