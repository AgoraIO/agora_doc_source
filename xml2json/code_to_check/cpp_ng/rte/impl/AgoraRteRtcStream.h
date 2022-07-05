//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include <utility>

#include "AgoraRteRtcStreamObserver.h"
#include "AgoraRteStream.h"
#include "AgoraRteUtils.h"
#include "IAgoraRteMediaTrack.h"
#include "IAgoraRteScene.h"
#include "IAgoraRtmpStreamingService.h"

namespace agora {
namespace rte {

class AgoraRteScene;

class AgoraRteRtcAudioTrackBase;
class AgoraRteRtcVideoTrackBase;

class AgoraRteRtcRemoteStream;
class AgoraRteRtcLocalStream;

class AgoraRteRtcStreamBase {
 public:
  struct RtcStreamBaseOption {
    std::string token_;
    bool is_user_visible_to_remote_;
    Optional<bool> enable_record_and_playout_;

    RtcStreamBaseOption(const std::string& token,
                        bool is_user_visible_to_remote)
        : token_(token),
          is_user_visible_to_remote_(is_user_visible_to_remote) {}

    RtcStreamBaseOption(const RtcStreamOptions& rtc_option)
        : token_(rtc_option.token),
          is_user_visible_to_remote_(true),
          enable_record_and_playout_(
              rtc_option.enable_audio_recording_or_playout) {}
  };

  AgoraRteRtcStreamBase(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
      const RtcStreamBaseOption& base_option);

  virtual ~AgoraRteRtcStreamBase() = default;

  std::shared_ptr<rtc::IRtcConnection> GetRtcConnection() {
    return internal_rtc_connection_;
  }

  std::shared_ptr<agora::base::IAgoraService> GetRtcService() {
    return rtc_service_;
  }

  const std::string& GetRtcStreamId() { return rtc_stream_id_; }

  void SetLocalUid(uint32_t uid) { local_uid_ = uid; }

  virtual int RegisterObservers() = 0;

  virtual void UnregisterObservers() = 0;

  int Connect();

  void Disconnect();

  int RenewRtcToken(const std::string& token);

  int UpdateLocalAudioObserver(bool enable,
                               const LocalAudioObserverOptions& options = {});
  int UpdateRemoteAudioObserver(bool enable,
                                const RemoteAudioObserverOptions& options = {});

  int UpdateRemoteVideoObserver(bool enable);

  virtual std::shared_ptr<AgoraRteRtcStreamBase> GetSharedSelf() = 0;

 protected:
  std::recursive_mutex callback_lock_;
  std::weak_ptr<AgoraRteScene> scene_;
  std::shared_ptr<rtc::IRtcConnection> internal_rtc_connection_;

  std::string token_;
  std::string rtc_stream_id_;
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;

  std::unique_ptr<AgoraRteRtcAudioFrameObserver> rtc_audio_observer_;
  std::unique_ptr<AgoraRteRtcRemoteVideoObserver> rtc_remote_video_observer_;

  AudioObserverOptions audio_option_;

  bool is_remote_video_observer_added_ = false;
  bool is_local_audio_observer_added_ = false;
  bool is_remote_audio_observer_added_ = false;
  uint32_t local_uid_ = 0;
};

class AgoraRteRtcMajorStream final : public AgoraRteRtcStreamBase,
                                     public AgoraRteMajorStream {
 public:
  AgoraRteRtcMajorStream(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
      const std::string& token, const JoinOptions& options);

  ~AgoraRteRtcMajorStream() override { Disconnect(); }

  // Scene will never parallel call override functions below, so we don't need
  // to add lock inside if these functions are only called from scene
  //
  int Connect() override;

  void Disconnect() override;

  int RenewSceneToken(const std::string& token) override;

  int RegisterObservers() override;

  void UnregisterObservers() override;

  void AddRemoteStream(const std::shared_ptr<AgoraRteRtcRemoteStream>& stream);

  void RemoveRemoteStream(const std::string& rtc_stream_id);

  std::shared_ptr<AgoraRteRtcRemoteStream> FindRemoteStream(
      const std::string& rtc_stream_id);

  std::shared_ptr<AgoraRteRtcRemoteStream> FindRemoteStream(
      const agora_refptr<rtc::IRemoteVideoTrack>& video_track);

  std::shared_ptr<AgoraRteRtcRemoteStream> FindRemoteStream(
      const agora_refptr<rtc::IRemoteAudioTrack>& audio_track);

  int PushUserInfo(const UserInfo& info, InstanceState state) override {
    return ERR_OK;
  }

  int PushStreamInfo(const StreamInfo& info, InstanceState state) override {
    return ERR_OK;
  }

  int PushMediaInfo(const StreamInfo& info, MediaType media_type,
                    InstanceState state) override {
    return ERR_OK;
  }

  std::shared_ptr<AgoraRteRtcStreamBase> GetSharedSelf() override {
    return std::static_pointer_cast<AgoraRteRtcMajorStream>(shared_from_this());
  }

 private:
  std::vector<std::shared_ptr<AgoraRteRtcRemoteStream>> remote_streams_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcMajorStreamUserObserver>>
      rtc_major_stream_user_observer_;

  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcMajorStreamObserver>>
      rtc_major_stream_observer_;
};

class AgoraRteRtcLocalStream final : public AgoraRteRtcStreamBase,
                                     public AgoraRteLocalStream {
 public:
  AgoraRteRtcLocalStream(
      std::shared_ptr<AgoraRteScene> scene,
      std::shared_ptr<agora::base::IAgoraService> rtc_service,
      const std::string& stream_id, const RtcStreamOptions& options);

  ~AgoraRteRtcLocalStream() override {
    DestroyRtmpService();
    Disconnect();
  }

  // Scene will never parallel call override functions below, so we don't need
  // to add lock inside if these functions are only called from scene
  //
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
      const LocalAudioObserverOptions& options) override {
    return UpdateLocalAudioObserver(true, options);
  }

  int DisableLocalAudioObserver() override {
    return UpdateLocalAudioObserver(false);
  }

  int SetCloudCdnTranscoding(
      const agora::rtc::LiveTranscoding& transcoding) override;

  int AddCloudCdnUrl(const std::string& target_cdn_url,
                     bool transcoding_enabled) override;

  int RemoveCloudCdnUrl(const std::string& target_cdn_url) override;

  int RegisterObservers() override;

  void UnregisterObservers() override;

  void OnConnected();

  void OnAudioTrackPublished(
      const agora_refptr<rtc::ILocalAudioTrack>& audio_track);

  void OnVideoTrackPublished(
      const agora_refptr<rtc::ILocalVideoTrack>& audio_track);

  std::shared_ptr<AgoraRteRtcStreamBase> GetSharedSelf() override {
    return std::static_pointer_cast<AgoraRteRtcLocalStream>(shared_from_this());
  }

 protected:
  int SetVideoTrack(std::shared_ptr<AgoraRteRtcVideoTrackBase> track);

  int SetAudioTrack(std::shared_ptr<AgoraRteRtcAudioTrackBase> track);

  int UnsetVideoTrack(std::shared_ptr<AgoraRteRtcVideoTrackBase> track);

  int UnsetAudioTrack(std::shared_ptr<AgoraRteRtcAudioTrackBase> track);

  int CreateRtmpService();

  int DestroyRtmpService();

  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcLocalStreamUserObserver>>
      rtc_local_stream_user_observer_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcLocalStreamObserver>>
      rtc_local_stream_observer_;

  std::shared_ptr<AgoraRteRtcVideoTrackBase> video_track_;
  std::vector<std::shared_ptr<AgoraRteRtcAudioTrackBase>> audio_tracks_;

  Optional<VideoEncoderConfiguration> config_;

  std::vector<agora::rtc::LiveTranscoding>
      transcoding_vec_;  ///< only cache one transcoding
  std::map<std::string, bool> cdnbypass_url_map_;  ///< cache CDN bypass urls
  std::shared_ptr<rtc::IRtmpStreamingService> rtmp_service_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteRtcLocalStreamCdnObserver>>
      rtmp_observer_;
};

class AgoraRteRtcRemoteStream final : public AgoraRteRemoteStream {
 public:
  AgoraRteRtcRemoteStream(
      const std::string& user_id,
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
      const std::string& stream_id, const std::string& rtc_stream_id,
      std::shared_ptr<AgoraRteRtcStreamBase> major_stream);

  ~AgoraRteRtcRemoteStream() override;

  // Scene will never parallel call override functions below, so we don't need
  // to add lock inside if these functions are only called from scene
  //
  int SubscribeRemoteAudio() override;

  int UnsubscribeRemoteAudio() override;

  int SubscribeRemoteVideo(const VideoSubscribeOptions& options) override;

  int UnsubscribeRemoteVideo() override;

  int SetRemoteVideoCanvas(const VideoCanvas& canvas) override;

  int EnableRemoteVideoObserver() override;

  int DisableRemoveVideoObserver() override;

  int EnableRemoteAudioObserver(
      const RemoteAudioObserverOptions& options) override;

  int DisableRemoteAudioObserver() override;

  int AdjustRemoteVolume(int volume) override;

  int GetRemoteVolume(int* volume) override;

  int SetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           const std::string& json_value) override;

  int GetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           std::string& json_value) override;

  void OnAudioTrackSubscribed(
      std::shared_ptr<rtc::IRemoteAudioTrack> audio_track) {
    contains_audio_ = true;
    std::lock_guard<std::recursive_mutex> _(callback_lock_);
    audio_track_ = std::move(audio_track);
  }

  void OnVideoTrackSubscribed(
      std::shared_ptr<rtc::IRemoteVideoTrack> video_track) {
    std::lock_guard<std::recursive_mutex> _(callback_lock_);
    contains_video_ = true;
    video_track_ = std::move(video_track);

    if (render_) {
      video_track_->addRenderer(render_);
    }
  }

  std::shared_ptr<rtc::IRemoteAudioTrack> GetAudioTrack() const {
    return audio_track_;
  }

  std::shared_ptr<rtc::IRemoteVideoTrack> GetVideoTrack() const {
    return video_track_;
  }

 protected:
  // All remote stream operations goes to local rtc stream , this is just follow
  // how current rtc works since rtc doesn't expose remote connection
  //
  std::weak_ptr<AgoraRteRtcStreamBase> rtc_stream_;
  std::recursive_mutex callback_lock_;
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;
  agora_refptr<rtc::IVideoRenderer> render_;
  agora_refptr<rtc::IMediaNodeFactory> media_node_factory_;
  std::string rtc_stream_id_;
  std::shared_ptr<rtc::IRemoteAudioTrack> audio_track_;
  std::shared_ptr<rtc::IRemoteVideoTrack> video_track_;
};

class AgoraRteRtcObserveHelper {
 public:
  static void onPublishStateChanged(
      const char* channel, rtc::STREAM_PUBLISH_STATE old_state,
      rtc::STREAM_PUBLISH_STATE new_state, int elapse_since_last_state,
      MediaType type, const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteStream>& stream);

 private:
  AgoraRteRtcObserveHelper() = default;
};

}  // namespace rte
}  // namespace agora
