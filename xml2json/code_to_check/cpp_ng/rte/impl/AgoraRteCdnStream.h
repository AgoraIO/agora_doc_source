//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include <map>

#include "AgoraRteStream.h"
#include "AgoraRteUtils.h"
#include "IAgoraRteMediaTrack.h"
#include "IAgoraRteScene.h"
#include "NGIAgoraRtmpConnection.h"
#include "NGIAgoraRtmpLocalUser.h"

namespace agora {
namespace rte {

class AgoraRteScene;

class AgoraRteCdnLocalStream : public AgoraRteLocalStream,
                               public rtc::IRtmpConnectionObserver,
                               public rtc::IRtmpLocalUserObserver {
 public:
  AgoraRteCdnLocalStream(
      const std::shared_ptr<AgoraRteScene>& scene,
      std::shared_ptr<agora::base::IAgoraService> rtc_service,
      const std::string& stream_id, const std::string& url);

  // Inherited via AgoraRteLocalStream
  int Connect() override;

  void Disconnect() override;

  int UpdateOption(const StreamOption& option) override;

  int PublishLocalAudioTrack(
      std::shared_ptr<AgoraRteRtcAudioTrackBase> track) override;

  int PublishLocalVideoTrack(
      std::shared_ptr<AgoraRteRtcVideoTrackBase> track) override;

  int UnpublishLocalAudioTrack(
      std::shared_ptr<AgoraRteRtcAudioTrackBase> track) override;

  int UnpublishLocalVideoTrack(
      std::shared_ptr<AgoraRteRtcVideoTrackBase> track) override;

  int SetAudioEncoderConfiguration(
      const AudioEncoderConfiguration& config) override;

  int SetVideoEncoderConfiguration(
      const VideoEncoderConfiguration& config) override;

  int EnableLocalAudioObserver(
      const LocalAudioObserverOptions& options) override;

  int DisableLocalAudioObserver() override;

  int SetCloudCdnTranscoding(
      const agora::rtc::LiveTranscoding& transcoding) override;

  int AddCloudCdnUrl(const std::string& target_cdn_url,
                     bool transcoding_enabled) override;

  int RemoveCloudCdnUrl(const std::string& target_cdn_url) override;

 private:
  // IRtmpConnectionObserver
  void onConnected(const rtc::RtmpConnectionInfo& connection_info) override;
  void onDisconnected(const rtc::RtmpConnectionInfo& connection_info) override;
  void onReconnecting(const rtc::RtmpConnectionInfo& connection_info) override;
  void onReconnected(const rtc::RtmpConnectionInfo& connection_info) override;
  void onConnectionFailure(const rtc::RtmpConnectionInfo& connection_info,
                           rtc::RTMP_CONNECTION_ERROR err_code) override;
  void onTransferStatistics(uint64_t video_bitrate, uint64_t audio_bitrate,
                            uint64_t video_frame_rate,
                            uint64_t push_video_frame_cnt,
                            uint64_t pop_video_frame_cnt) override;

  // IRtmpLocalUserObserver
  void onAudioTrackPublishSuccess(
      agora_refptr<rtc::ILocalAudioTrack> audio_track) override;
  void onAudioTrackPublicationFailure(
      agora_refptr<rtc::ILocalAudioTrack> audio_track,
      rtc::PublishAudioError error) override;
  void onVideoTrackPublishSuccess(
      agora_refptr<rtc::ILocalVideoTrack> video_track) override;
  void onVideoTrackPublicationFailure(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      rtc::PublishVideoError error) override;

  int CreateRtmpConnection();
  int StopDirectCdnStreamingInternal();
  void FireStreamStateChange(MediaType media_type, StreamMediaState old_state,
                             StreamMediaState new_state,
                             StreamStateChangedReason reason);

 private:
  enum streaming_state_internal {
    STATE_IDLE = 0,
    STATE_PUBLISHING,
    STATE_PUBLISHED,
    STATE_PUBLISH_STOPPED,
    STATE_PUBLISH_FAILED
  };
  streaming_state_internal streaming_state_ = STATE_IDLE;

  rtc::RtmpStreamingAudioConfiguration audio_encoder_config_;
  rtc::RtmpStreamingVideoConfiguration video_encoder_config_;

  VideoEncoderConfiguration track_video_encoder_config_;
  bool is_video_encoder_set_ = false;

  agora_refptr<rtc::ILocalVideoTrack> published_video_track_;
  StreamMediaState published_video_stream_state_ = StreamMediaState::kIdle;
  std::map<agora_refptr<rtc::ILocalAudioTrack>, StreamMediaState>
      published_audio_tracks_;

  std::weak_ptr<AgoraRteScene> scene_;
  std::string url_;
  std::string stream_id_;
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;
  agora_refptr<rtc::IRtmpConnection> rtmp_conn_;
  rtc::IRtmpLocalUser* local_user_ = nullptr;
};

}  // namespace rte
}  // namespace agora
