//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteStream.h"
#include "AgoraRteUtils.h"
#include "IAgoraRteMediaTrack.h"
#include "IAgoraRtmpStreamingService.h"

namespace agora {
namespace rte {

class AgoraRteScene;

class AgoraRteRtcMajorStream;

class AgoraRteRtcLocalStream;

class AgoraRteRtcStreamBase;

struct RteRtcStreamInfo {
  std::string user_id;    // the user id we expose to scene
  std::string stream_id;  // the stream id we expose to scene
  bool is_major_stream;   // whether rtc stream is used as major stream
};

class AgoraRteRtcMajorStreamObserver : public rtc::IRtcConnectionObserver {
 public:
  AgoraRteRtcMajorStreamObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcMajorStream>& stream)
      : scene_(scene), stream_(stream) {}

  ~AgoraRteRtcMajorStreamObserver() override;

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

  void onTokenPrivilegeWillExpire(const char* token) override;

  void onTokenPrivilegeDidExpire() override;

  void onConnectionFailure(const rtc::TConnectionInfo& connection_info,
                           rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;

  void onUserJoined(user_id_t user_id) override;

  void onUserLeft(user_id_t user_id,
                  rtc::USER_OFFLINE_REASON_TYPE reason) override;

  void onChannelMediaRelayStateChanged(int state, int code) override {}

  // Inherited via IRtcConnectionObserver and not implemented
  //
  void onTransportStats(const rtc::RtcStats& stats) override;

  void onUserAccountUpdated(rtc::uid_t uid, const char* user_account) override {
  }

  void onLastmileQuality(const rtc::QUALITY_TYPE quality) override {}

  void onLastmileProbeResult(const rtc::LastmileProbeResult& result) override {}

  void TryToFireClosedEvent() { fire_connection_closed_event_ = true; }

 private:
  std::weak_ptr<AgoraRteScene> scene_;
  std::weak_ptr<AgoraRteRtcMajorStream> stream_;
  bool fire_connection_closed_event_ = false;
  bool is_close_event_failed_ = true;
};

class AgoraRteRtcLocalStreamObserver : public rtc::IRtcConnectionObserver {
 public:
  AgoraRteRtcLocalStreamObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcLocalStream>& stream)
      : scene_(scene), stream_(stream) {}

  void onTokenPrivilegeWillExpire(const char* token) override;

  void onTokenPrivilegeDidExpire() override;

  // Inherited via IRtcConnectionObserver and not implemented
  //
  void onConnected(const rtc::TConnectionInfo& connection_info,
                   rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;

  void onDisconnected(const rtc::TConnectionInfo& connection_info,
                      rtc::CONNECTION_CHANGED_REASON_TYPE reason) override {}

  void onConnecting(const rtc::TConnectionInfo& connection_info,
                    rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;

  void onReconnecting(const rtc::TConnectionInfo& connection_info,
                      rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;

  void onReconnected(const rtc::TConnectionInfo& connection_info,
                     rtc::CONNECTION_CHANGED_REASON_TYPE reason) override;

  void onConnectionLost(const rtc::TConnectionInfo& connection_info) override {}

  void onLastmileQuality(const rtc::QUALITY_TYPE quality) override {}

  void onLastmileProbeResult(const rtc::LastmileProbeResult& result) override {}

  void onConnectionFailure(
      const rtc::TConnectionInfo& connection_info,
      rtc::CONNECTION_CHANGED_REASON_TYPE reason) override {}

  void onUserJoined(user_id_t user_id) override {}

  void onUserLeft(user_id_t user_id,
                  rtc::USER_OFFLINE_REASON_TYPE reason) override {}

  void onTransportStats(const rtc::RtcStats& stats) override;

  void onChannelMediaRelayStateChanged(int state, int code) override {}

  void onUserAccountUpdated(rtc::uid_t uid, const char* user_account) override {
  }

 private:
  std::weak_ptr<AgoraRteScene> scene_;
  std::weak_ptr<AgoraRteRtcLocalStream> stream_;
};

class AgoraRteRtcLocalStreamUserObserver : public rtc::ILocalUserObserver {
 public:
  AgoraRteRtcLocalStreamUserObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcLocalStream>& stream)
      : scene_(scene), stream_(stream) {}

  void onAudioTrackPublishSuccess(
      agora_refptr<rtc::ILocalAudioTrack> audio_track) override;

  void onAudioTrackPublicationFailure(
      agora_refptr<rtc::ILocalAudioTrack> audio_track,
      ERROR_CODE_TYPE error) override {}

  void onLocalAudioTrackStateChanged(
      agora_refptr<rtc::ILocalAudioTrack> audio_track,
      rtc::LOCAL_AUDIO_STREAM_STATE state,
      rtc::LOCAL_AUDIO_STREAM_ERROR error_code) override {}

  void onLocalAudioTrackStatistics(const rtc::LocalAudioStats& stats) override;

  void onVideoTrackPublishSuccess(
      agora_refptr<rtc::ILocalVideoTrack> video_track) override;

  void onVideoTrackPublicationFailure(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      ERROR_CODE_TYPE error) override {}

  void onLocalVideoTrackStateChanged(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      rtc::LOCAL_VIDEO_STREAM_STATE state,
      rtc::LOCAL_VIDEO_STREAM_ERROR error_code) override {}

  void onLocalVideoTrackStatistics(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      const rtc::LocalVideoTrackStats& stats) override;

  void onAudioPublishStateChanged(const char* channel,
                                  rtc::STREAM_PUBLISH_STATE old_state,
                                  rtc::STREAM_PUBLISH_STATE new_state,
                                  int elapse_since_last_state) override;

  void onVideoPublishStateChanged(const char* channel,
                                  rtc::STREAM_PUBLISH_STATE old_state,
                                  rtc::STREAM_PUBLISH_STATE new_state,
                                  int elapse_since_last_state) override;

  void onUserInfoUpdated(user_id_t user_id, USER_MEDIA_INFO msg,
                         bool val) override {}

  void onIntraRequestReceived() override {}

  void onStreamMessage(user_id_t user_id, int stream_id, const char* data,
                       size_t length) override {}

  // Inherited via ILocalUserObserver and not implemented
  //
  void onRemoteAudioTrackStatistics(
      agora_refptr<rtc::IRemoteAudioTrack> audio_track,
      const rtc::RemoteAudioTrackStats& stats) override {}

  void onUserAudioTrackSubscribed(
      user_id_t user_id,
      agora_refptr<rtc::IRemoteAudioTrack> audio_track) override {}

  void onUserAudioTrackStateChanged(
      user_id_t user_id, agora_refptr<rtc::IRemoteAudioTrack> audio_track,
      rtc::REMOTE_AUDIO_STATE state, rtc::REMOTE_AUDIO_STATE_REASON reason,
      int elapsed) override {}

  void onUserVideoTrackSubscribed(
      user_id_t user_id, rtc::VideoTrackInfo track_info,
      agora_refptr<rtc::IRemoteVideoTrack> video_track) override {}

  void onUserVideoTrackStateChanged(
      user_id_t user_id, agora_refptr<rtc::IRemoteVideoTrack> video_track,
      rtc::REMOTE_VIDEO_STATE state, rtc::REMOTE_VIDEO_STATE_REASON reason,
      int elapsed) override {}

  void onFirstRemoteVideoFrameRendered(user_id_t user_id, int width, int height,
                                       int elapsed) override {}

  void onRemoteVideoTrackStatistics(
      agora_refptr<rtc::IRemoteVideoTrack> video_track,
      const rtc::RemoteVideoTrackStats& stats) override {}

  void onAudioVolumeIndication(const rtc::AudioVolumeInformation* speakers,
                               unsigned int speaker_number,
                               int total_volume) override {}

  void onActiveSpeaker(user_id_t userId) override {}

  void onAudioSubscribeStateChanged(const char* channel, user_id_t user_id,
                                    rtc::STREAM_SUBSCRIBE_STATE old_state,
                                    rtc::STREAM_SUBSCRIBE_STATE new_state,
                                    int elapse_since_last_state) override {}

  void onVideoSubscribeStateChanged(const char* channel, user_id_t user_id,
                                    rtc::STREAM_SUBSCRIBE_STATE old_state,
                                    rtc::STREAM_SUBSCRIBE_STATE new_state,
                                    int elapse_since_last_state) override {}

  void onFirstRemoteAudioFrame(user_id_t userId, int elapsed) override {}

  void onFirstRemoteAudioDecoded(user_id_t userId, int elapsed) override {}

  void onFirstRemoteVideoFrame(user_id_t userId, int width, int height,
                               int elapsed) override {}

  void onFirstRemoteVideoDecoded(user_id_t userId, int width, int height,
                                 int elapsed) override {}

  void onVideoSizeChanged(user_id_t userId, int width, int height,
                          int rotation) override {}

 private:
  std::weak_ptr<AgoraRteScene> scene_;
  std::weak_ptr<AgoraRteRtcLocalStream> stream_;
};

class AgoraRteRtcLocalStreamCdnObserver : public rtc::IRtmpStreamingObserver {
 public:
  AgoraRteRtcLocalStreamCdnObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcLocalStream>& stream)
      : scene_(scene), stream_(stream) {}

  void onRtmpStreamingStateChanged(
      const char* url, agora::rtc::RTMP_STREAM_PUBLISH_STATE state,
      agora::rtc::RTMP_STREAM_PUBLISH_ERROR_TYPE err_code) override;
  void onStreamPublished(const char* url, int error) override;
  void onStreamUnpublished(const char* url) override;
  void onTranscodingUpdated() override;

 private:
  std::weak_ptr<AgoraRteScene> scene_;
  std::weak_ptr<AgoraRteRtcLocalStream> stream_;
};

class AgoraRteRtcMajorStreamUserObserver : public rtc::ILocalUserObserver {
 public:
  AgoraRteRtcMajorStreamUserObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcMajorStream>& stream)
      : scene_(scene), stream_(stream) {}

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

  void onUserVideoTrackSubscribed(
      user_id_t user_id, rtc::VideoTrackInfo track_info,
      agora_refptr<rtc::IRemoteVideoTrack> video_track) override;

  void onUserVideoTrackStateChanged(
      user_id_t user_id, agora_refptr<rtc::IRemoteVideoTrack> video_track,
      rtc::REMOTE_VIDEO_STATE state, rtc::REMOTE_VIDEO_STATE_REASON reason,
      int elapsed) override;

  void onFirstRemoteVideoFrameRendered(user_id_t user_id, int width, int height,
                                       int elapsed) override;

  void onRemoteVideoTrackStatistics(
      agora_refptr<rtc::IRemoteVideoTrack> video_track,
      const rtc::RemoteVideoTrackStats& stats) override;

  void onAudioSubscribeStateChanged(const char* channel, user_id_t user_id,
                                    rtc::STREAM_SUBSCRIBE_STATE old_state,
                                    rtc::STREAM_SUBSCRIBE_STATE new_state,
                                    int elapse_since_last_state) override;

  void onAudioVolumeIndication(const rtc::AudioVolumeInformation* speakers,
                               unsigned int speaker_number,
                               int total_volume) override;

  void onActiveSpeaker(user_id_t userId) override;

  void onVideoSubscribeStateChanged(const char* channel, user_id_t user_id,
                                    rtc::STREAM_SUBSCRIBE_STATE old_state,
                                    rtc::STREAM_SUBSCRIBE_STATE new_state,
                                    int elapse_since_last_state) override;

  void onUserInfoUpdated(user_id_t user_id, USER_MEDIA_INFO msg,
                         bool val) override {}

  void onStreamMessage(user_id_t user_id, int stream_id, const char* data,
                       size_t length) override {}

  void onSubscribeStateChangedCommon(const char* channel, user_id_t user_id,
                                     rtc::STREAM_SUBSCRIBE_STATE old_state,
                                     rtc::STREAM_SUBSCRIBE_STATE new_state,
                                     int elapse_since_last_state,
                                     MediaType type);

  // Inherited via ILocalUserObserver and not implemented
  //
  void onAudioTrackPublishSuccess(
      agora_refptr<rtc::ILocalAudioTrack> audio_track) override {}

  void onAudioTrackPublicationFailure(
      agora_refptr<rtc::ILocalAudioTrack> audio_track,
      ERROR_CODE_TYPE error) override {}

  void onLocalAudioTrackStateChanged(
      agora_refptr<rtc::ILocalAudioTrack> audio_track,
      rtc::LOCAL_AUDIO_STREAM_STATE state,
      rtc::LOCAL_AUDIO_STREAM_ERROR error_code) override {}

  void onLocalAudioTrackStatistics(const rtc::LocalAudioStats& stats) override {
  }

  void onVideoTrackPublishSuccess(
      agora_refptr<rtc::ILocalVideoTrack> video_track) override {}

  void onVideoTrackPublicationFailure(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      ERROR_CODE_TYPE error) override {}

  void onLocalVideoTrackStateChanged(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      rtc::LOCAL_VIDEO_STREAM_STATE state,
      rtc::LOCAL_VIDEO_STREAM_ERROR error_code) override {}

  void onLocalVideoTrackStatistics(
      agora_refptr<rtc::ILocalVideoTrack> video_track,
      const rtc::LocalVideoTrackStats& stats) override {}

  void onAudioPublishStateChanged(const char* channel,
                                  rtc::STREAM_PUBLISH_STATE old_state,
                                  rtc::STREAM_PUBLISH_STATE new_state,
                                  int elapse_since_last_state) override {}

  void onVideoPublishStateChanged(const char* channel,
                                  rtc::STREAM_PUBLISH_STATE old_state,
                                  rtc::STREAM_PUBLISH_STATE new_state,
                                  int elapse_since_last_state) override {}

  void onFirstRemoteAudioFrame(user_id_t userId, int elapsed) override {}

  void onFirstRemoteAudioDecoded(user_id_t userId, int elapsed) override {}

  void onFirstRemoteVideoFrame(user_id_t userId, int width, int height,
                               int elapsed) override {}

  void onFirstRemoteVideoDecoded(user_id_t userId, int width, int height,
                                 int elapsed) override {}

  void onVideoSizeChanged(user_id_t userId, int width, int height,
                          int rotation) override {}

 private:
  std::weak_ptr<AgoraRteScene> scene_;
  std::weak_ptr<AgoraRteRtcMajorStream> stream_;
};

class AgoraRteRtcAudioFrameObserver
    : public agora::media::IAudioFrameObserverBase {
 public:
  AgoraRteRtcAudioFrameObserver(
      const std::shared_ptr<AgoraRteScene>& scene,
      const std::shared_ptr<AgoraRteRtcStreamBase>& stream)
      : scene_(scene), stream_(stream) {}

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
  std::weak_ptr<AgoraRteRtcStreamBase> stream_;
};

class AgoraRteRtcRemoteVideoObserver : public rtc::IVideoFrameObserver2 {
 public:
  explicit AgoraRteRtcRemoteVideoObserver(
      const std::shared_ptr<AgoraRteScene>& scene)
      : scene_(scene) {}

  void onFrame(const char* channel_id, user_id_t remote_uid,
               const media::base::VideoFrame* frame) override;

 private:
  std::weak_ptr<AgoraRteScene> scene_;
};

class RteStatsConvertHelper {
 public:
  static void LocalAudioStats(const rtc::LocalAudioStats& stats,
                              RteLocalAudioStats& dest_stats);
  static void LocalVideoStats(const rtc::LocalVideoTrackStats& stats,
                              RteLocalVideoStats& dest_stats);
  static void RemoteAudioStats(const rtc::RemoteAudioTrackStats& stats,
                               RteRemoteAudioStats& dest_stats);
  static void RemoteVideoStats(const rtc::RemoteVideoTrackStats& stats,
                               RteRemoteVideoStats dest_stats);
};

}  // namespace rte
}  // namespace agora