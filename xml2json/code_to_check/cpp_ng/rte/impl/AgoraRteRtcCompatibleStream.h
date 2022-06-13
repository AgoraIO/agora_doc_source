//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteRtcStream.h"
#include "AgoraRteSdk.h"
#include "AgoraRteStream.h"
#include "AgoraRteUtils.h"
#include "IAgoraRteMediaTrack.h"
#include "IAgoraRteScene.h"

namespace agora {
namespace rte {
class AgoraRteRtcCompatibleStreamObserver;
class AgoraRteRtcCompatibleUserObserver;
class AgoraRteRtcCompatibleAudioFrameObserver;
class AgoraRteRtcCompatibleRemoteVideoObserver;
class AgoraRteRtcCompatibleStreamCdnObserver;

class AgoraRteRtcCompatibleMajorStream final : public AgoraRteRtcStreamBase,
                                               public AgoraRteMajorStream {
 public:
  AgoraRteRtcCompatibleMajorStream(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
      const std::string& token, const JoinOptions& options);
  ~AgoraRteRtcCompatibleMajorStream() {
    DestroyRtmpService();
    Disconnect();
  }
  // Inherited via AgoraRteRtcStreamBase
  int RegisterObservers() override;
  void UnregisterObservers() override;
  std::shared_ptr<AgoraRteRtcStreamBase> GetSharedSelf() override;

  // Inherited via AgoraRteMajorStream
  int Connect() override;
  void Disconnect() override;
  int RenewSceneToken(const std::string& token) override;
  int PushUserInfo(const UserInfo& info, InstanceState state) override;
  int PushStreamInfo(const StreamInfo& info, InstanceState state) override;
  int PushMediaInfo(const StreamInfo& info, MediaType media_type,
                    InstanceState state) override;

  void AddRemoteStream(const std::shared_ptr<AgoraRteRtcRemoteStream>& stream);

  void RemoveRemoteStream(const std::string& rtc_stream_id);

  std::shared_ptr<AgoraRteRtcRemoteStream> FindRemoteStream(
      const std::string& stream_id);

  // Interface from AgoraRteLocalStream
  int UpdateOption(const StreamOption& option);
  int PublishLocalAudioTrack(
      const std::shared_ptr<AgoraRteRtcAudioTrackBase>& track);
  int PublishLocalVideoTrack(
      const std::shared_ptr<AgoraRteRtcVideoTrackBase>& track);
  int UnpublishLocalAudioTrack(
      const std::shared_ptr<AgoraRteRtcAudioTrackBase>& track);
  int UnpublishLocalVideoTrack(
      const std::shared_ptr<AgoraRteRtcVideoTrackBase>& track);
  int SetAudioEncoderConfiguration(const AudioEncoderConfiguration& config);
  int SetVideoEncoderConfiguration(const VideoEncoderConfiguration& config);
  int EnableLocalAudioObserver(const LocalAudioObserverOptions& options);
  int DisableLocalAudioObserver();
  int SetCloudCdnTranscoding(const agora::rtc::LiveTranscoding& transcoding);
  int AddCloudCdnUrl(const std::string& target_cdn_url,
                     bool transcoding_enabled);
  int RemoveCloudCdnUrl(const std::string& target_cdn_url);

  void OnConnected();

  void OnAudioTrackPublished(
      const agora_refptr<rtc::ILocalAudioTrack>& audio_track);

  void OnVideoTrackPublished(
      const agora_refptr<rtc::ILocalVideoTrack>& audio_track);

 protected:
  int SetVideoTrack(std::shared_ptr<AgoraRteRtcVideoTrackBase> track);

  int SetAudioTrack(std::shared_ptr<AgoraRteRtcAudioTrackBase> track);

  int UnsetVideoTrack(std::shared_ptr<AgoraRteRtcVideoTrackBase> track);

  int UnsetAudioTrack(std::shared_ptr<AgoraRteRtcAudioTrackBase> track);

  int CreateRtmpService();

  int DestroyRtmpService();

 private:
  std::shared_ptr<AgoraRteRtcVideoTrackBase> video_track_;

  std::vector<std::shared_ptr<AgoraRteRtcAudioTrackBase>> audio_tracks_;

  Optional<VideoEncoderConfiguration> config_;

  std::vector<std::shared_ptr<AgoraRteRtcRemoteStream>> remote_streams_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcCompatibleUserObserver>>
      rtc_major_stream_user_observer_;

  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcCompatibleStreamObserver>>
      rtc_major_stream_observer_;

  std::vector<agora::rtc::LiveTranscoding>
      transcoding_vec_;  ///< only cache one transcoding
  std::map<std::string, bool> cdnbypass_url_map_;  ///< cache CDN bypass urls
  std::shared_ptr<rtc::IRtmpStreamingService> rtmp_service_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcCompatibleStreamCdnObserver>>
      rtmp_observer_;
};

class AgoraRteRtcCompatibleLocalStream final : public AgoraRteLocalStream {
 public:
  AgoraRteRtcCompatibleLocalStream(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcCompatibleMajorStream>& major_stream);
  ~AgoraRteRtcCompatibleLocalStream() { Disconnect(); }
  // Inherited via AgoraRteLocalStream
  int Connect() override { return ERR_OK; }
  void Disconnect() override {}

  int UpdateOption(const StreamOption& option) override {
    return major_stream_->UpdateOption(option);
  }
  int PublishLocalAudioTrack(
      std::shared_ptr<AgoraRteRtcAudioTrackBase> track) override {
    return major_stream_->PublishLocalAudioTrack(track);
  }
  int PublishLocalVideoTrack(
      std::shared_ptr<AgoraRteRtcVideoTrackBase> track) override {
    return major_stream_->PublishLocalVideoTrack(track);
  }
  int UnpublishLocalAudioTrack(
      std::shared_ptr<AgoraRteRtcAudioTrackBase> track) override {
    return major_stream_->UnpublishLocalAudioTrack(track);
  }
  int UnpublishLocalVideoTrack(
      std::shared_ptr<AgoraRteRtcVideoTrackBase> track) override {
    return major_stream_->UnpublishLocalVideoTrack(track);
  }
  int SetAudioEncoderConfiguration(
      const AudioEncoderConfiguration& config) override {
    return major_stream_->SetAudioEncoderConfiguration(config);
  }
  int SetVideoEncoderConfiguration(
      const VideoEncoderConfiguration& config) override {
    return major_stream_->SetVideoEncoderConfiguration(config);
  }
  int EnableLocalAudioObserver(
      const LocalAudioObserverOptions& option) override {
    return major_stream_->EnableLocalAudioObserver(option);
  }
  int DisableLocalAudioObserver() override {
    return major_stream_->DisableLocalAudioObserver();
  }
  int SetCloudCdnTranscoding(
      const agora::rtc::LiveTranscoding& transcoding) override {
    return major_stream_->SetCloudCdnTranscoding(transcoding);
  }
  int AddCloudCdnUrl(const std::string& target_cdn_url,
                     bool transcoding_enabled) override {
    return major_stream_->AddCloudCdnUrl(target_cdn_url, transcoding_enabled);
  };
  int RemoveCloudCdnUrl(const std::string& target_cdn_url) override {
    return major_stream_->RemoveCloudCdnUrl(target_cdn_url);
  }

 private:
  std::shared_ptr<AgoraRteRtcCompatibleMajorStream> major_stream_;
};

class AgoraRteRtcCompatibleStreamObserver : public rtc::IRtcConnectionObserver {
 public:
  AgoraRteRtcCompatibleStreamObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcCompatibleMajorStream>& stream)
      : stream_(stream), scene_(scene) {}

  ~AgoraRteRtcCompatibleStreamObserver();

  // Inherited via IRtcConnectionObserver
  void onConnected(const rtc::TConnectionInfo& connection_info,
                   rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;
  void onDisconnected(const rtc::TConnectionInfo& connection_info,
                      rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;
  void onConnecting(const rtc::TConnectionInfo& connection_info,
                    rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;
  void onReconnecting(const rtc::TConnectionInfo& connection_info,
                      rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;
  void onReconnected(const rtc::TConnectionInfo& connection_info,
                     rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;
  void onConnectionLost(const rtc::TConnectionInfo& connection_info) override;
  void onLastmileQuality(const rtc::QUALITY_TYPE quality) override;
  void onLastmileProbeResult(const rtc::LastmileProbeResult& result) override;
  void onTokenPrivilegeWillExpire(const char* token) override;
  void onTokenPrivilegeDidExpire() override;
  void onConnectionFailure(const rtc::TConnectionInfo& connection_info,
                           rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;
  void onUserJoined(user_id_t user_id) override;
  void onUserLeft(user_id_t user_id,
                  rtc::USER_OFFLINE_REASON_TYPE reason) override;
  void onTransportStats(const rtc::RtcStats& stats) override;
  void onChannelMediaRelayStateChanged(int state, int code) override;

  void TryToFireClosedEvent() { fire_connection_closed_event_ = true; }

 private:
  static std::string ToString(const rtc::TConnectionInfo& connection_info);

 private:
  std::mutex ob_lock_;
  std::weak_ptr<AgoraRteRtcCompatibleMajorStream> stream_;
  std::weak_ptr<AgoraRteScene> scene_;
  bool fire_connection_closed_event_ = false;
  bool is_close_event_failed_ = true;
};

class AgoraRteRtcCompatibleStreamCdnObserver
    : public rtc::IRtmpStreamingObserver {
 public:
  AgoraRteRtcCompatibleStreamCdnObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcCompatibleMajorStream>& stream);

  void onRtmpStreamingStateChanged(
      const char* url, agora::rtc::RTMP_STREAM_PUBLISH_STATE state,
      agora::rtc::RTMP_STREAM_PUBLISH_ERROR_TYPE err_code) override;
  void onStreamPublished(const char* url, int error) override;
  void onStreamUnpublished(const char* url) override;
  void onTranscodingUpdated() override;

 private:
  std::weak_ptr<AgoraRteScene> scene_;
  std::weak_ptr<AgoraRteRtcCompatibleMajorStream> stream_;
};

class AgoraRteRtcCompatibleUserObserver : public rtc::ILocalUserObserver {
 public:
  AgoraRteRtcCompatibleUserObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcCompatibleMajorStream>& stream);

  // Inherited via ILocalUserObserver
  void onAudioTrackPublishSuccess(
      agora_refptr<rtc::ILocalAudioTrack> audio_track) override;
  void onAudioTrackPublicationFailure(
      agora_refptr<rtc::ILocalAudioTrack> audio_track,
      ERROR_CODE_TYPE error) override;
  void onLocalAudioTrackStateChanged(
      agora_refptr<rtc::ILocalAudioTrack> audio_track,
      rtc::LOCAL_AUDIO_STREAM_STATE state,
      rtc::LOCAL_AUDIO_STREAM_ERROR error_code) override;
  void onLocalAudioTrackStatistics(const rtc::LocalAudioStats& stats) override;
  void onRemoteAudioTrackStatistics(
      agora_refptr<rtc::IRemoteAudioTrack> audio_track,
      const rtc::RemoteAudioTrackStats& stats) override;
  void onUserAudioTrackSubscribed(
      user_id_t user_id,
      agora_refptr<rtc::IRemoteAudioTrack> audio_track) override;
  void onUserAudioTrackStateChanged(
      user_id_t user_id, agora_refptr<rtc::IRemoteAudioTrack> audio_track,
      rtc::REMOTE_AUDIO_STATE state, rtc::REMOTE_AUDIO_STATE_REASON reason,
      int elapsed) override;
  void onVideoTrackPublishSuccess(
      agora_refptr<rtc::ILocalVideoTrack> video_track) override;
  void onVideoTrackPublicationFailure(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      ERROR_CODE_TYPE error) override;
  void onLocalVideoTrackStateChanged(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      rtc::LOCAL_VIDEO_STREAM_STATE state,
      rtc::LOCAL_VIDEO_STREAM_ERROR error_code) override;
  void onLocalVideoTrackStatistics(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      const rtc::LocalVideoTrackStats& stats) override;
  void onUserVideoTrackSubscribed(
      user_id_t user_id, rtc::VideoTrackInfo track_info,
      agora_refptr<rtc::IRemoteVideoTrack> video_track) override;
  void onUserVideoTrackStateChanged(
      user_id_t user_id, agora_refptr<rtc::IRemoteVideoTrack> video_track,
      rtc::REMOTE_VIDEO_STATE state, rtc::REMOTE_VIDEO_STATE_REASON reason,
      int elapsed) override;
  void onFirstRemoteVideoFrameRendered(user_id_t user_id, int width, int height,
                                       int elapsed) override {}
  void onRemoteVideoTrackStatistics(
      agora_refptr<rtc::IRemoteVideoTrack> video_track,
      const rtc::RemoteVideoTrackStats& stats) override;
  void onAudioVolumeIndication(const rtc::AudioVolumeInformation* speakers,
                               unsigned int speaker_number,
                               int total_volume) override;
  void onAudioSubscribeStateChanged(const char* channel, user_id_t user_id,
                                    rtc::STREAM_SUBSCRIBE_STATE old_state,
                                    rtc::STREAM_SUBSCRIBE_STATE new_state,
                                    int elapse_since_last_state) override;
  void onVideoSubscribeStateChanged(const char* channel, user_id_t user_id,
                                    rtc::STREAM_SUBSCRIBE_STATE old_state,
                                    rtc::STREAM_SUBSCRIBE_STATE new_state,
                                    int elapse_since_last_state) override;
  void onAudioPublishStateChanged(const char* channel,
                                  rtc::STREAM_PUBLISH_STATE old_state,
                                  rtc::STREAM_PUBLISH_STATE new_state,
                                  int elapse_since_last_state) override;
  void onVideoPublishStateChanged(const char* channel,
                                  rtc::STREAM_PUBLISH_STATE old_state,
                                  rtc::STREAM_PUBLISH_STATE new_state,
                                  int elapse_since_last_state) override;

  void onActiveSpeaker(user_id_t userId) override;

  void onSubscribeStateChangedCommon(const char* channel, user_id_t user_id,
                                     rtc::STREAM_SUBSCRIBE_STATE old_state,
                                     rtc::STREAM_SUBSCRIBE_STATE new_state,
                                     int elapse_since_last_state,
                                     MediaType type);

  void onFirstRemoteAudioFrame(user_id_t userId, int elapsed) override {}

  void onFirstRemoteAudioDecoded(user_id_t userId, int elapsed) override {}

  void onFirstRemoteVideoFrame(user_id_t userId, int width, int height,
                               int elapsed) override {}

  void onFirstRemoteVideoDecoded(user_id_t userId, int width, int height,
                                 int elapsed) override {}

  void onVideoSizeChanged(user_id_t userId, int width, int height, int rotation) override {}
 private:
  std::weak_ptr<AgoraRteScene> scene_;
  std::weak_ptr<AgoraRteRtcCompatibleMajorStream> stream_;
};

class AgoraRteRtcCompatibleAudioFrameObserver
    : public agora::media::IAudioFrameObserverBase {
 public:
  AgoraRteRtcCompatibleAudioFrameObserver(
      const std::shared_ptr<AgoraRteScene>& scene)
      : scene_(scene) {}

  // Inherited via IAudioFrameObserver
  bool onRecordAudioFrame(const char* channelId,
                          AudioFrame& audio_frame) override;
  bool onPlaybackAudioFrame(const char* channelId,
                            AudioFrame& audio_frame) override;
  bool onMixedAudioFrame(const char* channelId,
                         AudioFrame& audio_frame) override;
  bool onEarMonitoringAudioFrame(AudioFrame& audioFrame) override;
  bool onPlaybackAudioFrameBeforeMixing(const char* channelId,
                                        user_id_t user_id,
                                        AudioFrame& audio_frame) override;

 private:
  std::weak_ptr<AgoraRteScene> scene_;
};

class AgoraRteRtcCompatibleRemoteVideoObserver
    : public rtc::IVideoFrameObserver2 {
 public:
  AgoraRteRtcCompatibleRemoteVideoObserver(
      const std::shared_ptr<AgoraRteScene>& scene)
      : scene_(scene) {}

  // Inherited via IVideoFrameObserver2
  void onFrame(const char* channel_id, user_id_t remote_uid,
               const VideoFrame* frame) override;

 private:
  std::weak_ptr<AgoraRteScene> scene_;
};

}  // namespace rte
}  // namespace agora