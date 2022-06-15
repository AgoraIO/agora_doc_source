//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteScene.h"

namespace agora {
namespace rte {

enum class MediaType;
class AgoraRteMajorStream;
class AgoraRteLocalStream;
class AgoraRteRemoteStream;
class AgoraRteStreamFactory;
class AgoraRteTrackBase;

class AgoraRteScene : public std::enable_shared_from_this<AgoraRteScene>,
                      public IAgoraRteScene {
 public:
  AgoraRteScene(std::shared_ptr<AgoraRteStreamFactory> stream_factory,
                const std::string& scene_id, const SceneConfig& config);

  virtual ~AgoraRteScene() override { Leave(); }

  // Note: All publish functions should be protected by lock which makes them
  // thread-safe
  //
  int Join(const std::string& user_id, const std::string& token,
           const JoinOptions& options) override;

  void Leave() override;

  int RenewSceneToken(const std::string& new_token) override;

  SceneInfo GetSceneInfo() const override;

  UserInfo GetLocalUserInfo() const override;

  std::vector<UserInfo> GetRemoteUsers() const override;

  std::vector<StreamInfo> GetLocalStreams() const override;

  std::vector<StreamInfo> GetRemoteStreams() const override;

  std::vector<StreamInfo> GetRemoteStreamsByUserId(
      const std::string& user_id) const override;

  int CreateOrUpdateRTCStream(const std::string& local_stream_id,
                              const RtcStreamOptions& options) override;

  int CreateOrUpdateDirectCDNStream(
      const std::string& local_stream_id,
      const DirectCdnStreamOptions& options) override;

  int DestroyStream(const std::string& local_stream_id) override;

  int SetAudioEncoderConfiguration(
      const std::string& local_stream_id,
      const AudioEncoderConfiguration& config) override;

  int SetVideoEncoderConfiguration(
      const std::string& local_stream_id,
      const VideoEncoderConfiguration& config) override;

  int SetExtensionProperty(const std::string& remote_stream_id,
                           const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           const std::string& json_value) override;

  int GetExtensionProperty(const std::string& remote_stream_id,
                           const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           std::string& json_value) override;

  int SetCloudCdnTranscoding(
      const std::string& local_stream_id,
      const agora::rtc::LiveTranscoding& transcoding) override;

  int AddCloudCdnUrl(const std::string& local_stream_id,
                     const std::string& target_cdn_url,
                     bool transcoding_enabled) override;

  int RemoveCloudCdnUrl(const std::string& local_stream_id,
                        const std::string& target_cdn_url) override;

  int PublishLocalAudioTrack(
      const std::string& local_stream_id,
      std::shared_ptr<IAgoraRteAudioTrack> track) override;

  int PublishLocalVideoTrack(
      const std::string& local_stream_id,
      std::shared_ptr<IAgoraRteVideoTrack> track) override;

  int UnpublishLocalAudioTrack(
      std::shared_ptr<IAgoraRteAudioTrack> track) override;

  int UnpublishLocalVideoTrack(
      std::shared_ptr<IAgoraRteVideoTrack> track) override;

  int PublishMediaPlayer(const std::string& local_stream_id,
                         std::shared_ptr<IAgoraRteMediaPlayer> player) override;

  int UnpublishMediaPlayer(
      std::shared_ptr<IAgoraRteMediaPlayer> player) override;

  int SubscribeRemoteAudio(const std::string& remote_stream_id) override;

  int UnsubscribeRemoteAudio(const std::string& remote_stream_id) override;

  int SubscribeRemoteVideo(const std::string& remote_stream_id,
                           const VideoSubscribeOptions& options) override;

  int UnsubscribeRemoteVideo(const std::string& remote_stream_id) override;

  int SetRemoteVideoCanvas(const std::string& remote_stream_id,
                           const VideoCanvas& canvas) override;

  void RegisterEventHandler(
      std::shared_ptr<IAgoraRteSceneEventHandler> event_handler) override;

  void UnregisterEventHandler(
      std::shared_ptr<IAgoraRteSceneEventHandler> event_handler) override;

  void RegisterRemoteVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  void UnregisterRemoteVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;

  void RegisterAudioFrameObserver(
      std::shared_ptr<IAgoraRteAudioFrameObserver> observer,
      const AudioObserverOptions& options) override;

  void UnregisterAudioFrameObserver(
      std::shared_ptr<IAgoraRteAudioFrameObserver> observer) override;

  int AdjustUserPlaybackSignalVolume(const std::string& remote_stream_id,
                                     int volume) override;

  int GetUserPlaybackSignalVolume(const std::string& remote_stream_id,
                                  int* volume) override;

 public:
  void ChangeSceneState(SceneState state, ConnectionChangedReason reason);

  void AddRemoteUser(const std::string& user_id);

  void RemoveRemoteUser(const std::string& user_id);

  void AddRemoteStream(const std::string& remote_stream_id,
                       const std::shared_ptr<AgoraRteRemoteStream>& stream);

  void RemoveRemoteStream(const std::string& stream_id);

  void OnLocalStreamStateChanged(const StreamInfo& stream, MediaType media_type,
                                 StreamMediaState old_state,
                                 StreamMediaState new_state,
                                 StreamStateChangedReason reason);

  void OnRemoteStreamStateChanged(const StreamInfo& stream,
                                  MediaType media_type,
                                  StreamMediaState old_state,
                                  StreamMediaState new_state,
                                  StreamStateChangedReason reason);

  void OnAudioVolumeIndication(const std::vector<AudioVolumeInfo>& speakers,
                               int total_volume);

  void OnActiveSpeaker(const std::string& stream_id);

  void OnRemoteVideoFrame(const std::string& stream_id,
                          const media::base::VideoFrame& frame);

  void OnRecordAudioFrame(AudioFrame& audio_frame);

  void OnPlaybackAudioFrame(AudioFrame& audio_frame);

  void OnMixedAudioFrame(AudioFrame& audio_frame);

  void OnPlaybackAudioFrameBeforeMixing(const std::string& stream_id,
                                        AudioFrame& audio_frame);

  void OnSceneTokenWillExpire(const std::string& token);

  void OnSceneTokenExpired();

  void OnStreamTokenWillExpire(const std::string& stream_id,
                               const std::string& token);

  void OnStreamTokenExpired(const std::string& stream_id);

  void OnCdnStateChanged(const std::string& stream_id, const char* url,
                         rtc::RTMP_STREAM_PUBLISH_STATE state,
                         rtc::RTMP_STREAM_PUBLISH_ERROR_TYPE err_code);

  void OnCdnPublished(const std::string& stream_id, const char* url, int error);

  void OnCdnUnpublished(const std::string& stream_id, const char* url);

  void OnCdnTranscodingUpdated(const std::string& stream_id);

  void OnRtcStats(const std::string& stream_id, const rtc::RtcStats& stats);

  void OnLocalStreamAudioStats(const std::string& stream_id,
                               const RteLocalAudioStats& stats);

  void OnLocalStreamVideoStats(const std::string& stream_id,
                               const RteLocalVideoStats& stats);

  void OnRemoteStreamAudioStats(const std::string& stream_id,
                                const RteRemoteAudioStats& stats);

  void OnRemoteStreamVideoStats(const std::string& stream_id,
                                const RteRemoteVideoStats& stats);

  void OnLocalStreamEvent(const std::string& stream_id,
                          LocalStreamEventType event);

  void OnRemoteStreamEvent(const std::string& stream_id,
                           RemoteStreamEventType event);

  std::shared_ptr<AgoraRteMajorStream> GetMajorStream();

 private:
  int CreateOrUpdateStreamCommon(const std::string& local_stream_id,
                                 const StreamOption& option);

  std::shared_ptr<AgoraRteLocalStream> CreatLocalStream(
      const std::string& local_stream_id, const StreamOption& option);

  std::shared_ptr<AgoraRteLocalStream> GetLocalStream(
      const std::string& local_stream_id);

  std::shared_ptr<AgoraRteLocalStream> RemoveLocalStream(
      const std::string& local_stream_id);

  void SetMajorStream(const std::shared_ptr<AgoraRteMajorStream>& stream);

  std::shared_ptr<AgoraRteRemoteStream> GetRemoteStream(
      const std::string& stream_id);

  void DestroyStream(const std::shared_ptr<AgoraRteLocalStream>& local_stream);

  bool IsSceneActive();

  template <typename track_type>
  int PublishCommon(std::shared_ptr<track_type> track,
                    const std::string& local_stream_id);

  template <typename track_type>
  int PublishSpecific(const std::shared_ptr<AgoraRteLocalStream>& stream,
                      const std::shared_ptr<track_type>& track);

  template <typename track_type>
  int UnpublishCommon(std::shared_ptr<track_type> track);

  template <typename track_type>
  int UnpublishSpecific(const std::shared_ptr<AgoraRteLocalStream>& stream,
                        const std::shared_ptr<track_type>& track);

 private:
  mutable std::recursive_mutex operation_lock_;  // Sync between user operations
  mutable std::recursive_mutex callback_lock_;   // Sync between callbacks

  std::string scene_id_;
  std::string user_id_;
  SceneState scene_state_ = SceneState::kDisconnected;
  SceneConfig config_;

  std::vector<std::weak_ptr<IAgoraRteSceneEventHandler>> event_handlers_;
  std::vector<std::weak_ptr<IAgoraRteVideoFrameObserver>>
      remote_video_frame_observers_;
  std::vector<std::weak_ptr<IAgoraRteAudioFrameObserver>>
      audio_frame_observers_;

  AudioObserverOptions audio_observer_option_;

  std::shared_ptr<AgoraRteMajorStream> major_stream_object_;
  std::map<std::string, std::shared_ptr<AgoraRteLocalStream>>
      local_stream_objects_;
  std::map<std::string, std::shared_ptr<AgoraRteRemoteStream>>
      remote_stream_objects_;
  std::unordered_set<std::string> remote_users_;

  std::shared_ptr<AgoraRteStreamFactory> stream_factory_;
  std::map<std::string, std::vector<rtc::RtcStats>> rtc_stats_map_;
};

}  // namespace rte
}  // namespace agora