//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once
#include <mutex>
#include <string>

#include "AgoraRteBase.h"
#include "AgoraRteUtils.h"
#include "IAgoraRteMediaTrack.h"

namespace agora {
namespace rte {

class AgoraRteRtcAudioTrackBase;
class AgoraRteRtcVideoTrackBase;

class AgoraRteStream {
 public:
  AgoraRteStream(const std::string& user_id, const std::string& stream_id,
                 StreamType stream_type)
      : stream_id_(stream_id), user_id_(user_id), stream_type_(stream_type) {}

  const std::string& GetStreamId() { return stream_id_; }

  const std::string& GetUserId() { return user_id_; }

  bool ContainsAudio() { return contains_audio_; }

  bool ContainsVideo() { return contains_video_; }

  void OnAudioConnected() {
    RTE_LOG_VERBOSE << " stream id: " << stream_id_;
    contains_audio_ = true;
  }

  void OnVideoConnected() {
    RTE_LOG_VERBOSE << " stream id: " << stream_id_;
    contains_video_ = true;
  }

  void OnAudioDisconnected() {
    RTE_LOG_VERBOSE << " stream id: " << stream_id_;
    contains_audio_ = false;
  }

  void OnVideoDisconnected() {
    RTE_LOG_VERBOSE << " stream id: " << stream_id_;
    contains_video_ = false;
  }

  StreamType GetStreamType() { return stream_type_; }

 protected:
  std::atomic<bool> contains_audio_ = {false};
  std::atomic<bool> contains_video_ = {false};
  std::string stream_id_;
  std::string user_id_;
  StreamType stream_type_;
};

class AgoraRteMajorStream
    : public std::enable_shared_from_this<AgoraRteMajorStream>,
      public AgoraRteStream {
 public:
  AgoraRteMajorStream(const std::string& user_id, StreamType stream_type)
      : AgoraRteStream(user_id, "", stream_type) {}
  virtual ~AgoraRteMajorStream() = default;
  virtual int Connect() = 0;
  virtual void Disconnect() = 0;

  virtual int PushUserInfo(const UserInfo& info, InstanceState state) = 0;
  virtual int PushStreamInfo(const StreamInfo& info, InstanceState state) = 0;
  virtual int PushMediaInfo(const StreamInfo& info, MediaType media_type,
                            InstanceState state) = 0;
  virtual int RenewSceneToken(const std::string& token) = 0;
  // TODO: Push in batch
  //
};

class AgoraRteLocalStream
    : public std::enable_shared_from_this<AgoraRteLocalStream>,
      public AgoraRteStream {
 public:
  AgoraRteLocalStream(const std::string& user_id, const std::string& stream_id,
                      StreamType stream_type)
      : AgoraRteStream(user_id, stream_id, stream_type) {}

  virtual ~AgoraRteLocalStream() = default;

  // Expose Connect/Disconnect here , for rtc, if we failed to connect, no
  // callback will be trigged, so we expose this to scene to handle error there,
  // meanwhile, exposing these functions hurts nothing, streams could check
  // their internal status and do whatever they want.
  //
  virtual int Connect() = 0;

  virtual void Disconnect() = 0;

  // Update stream options, e.g. token , url
  //
  virtual int UpdateOption(const StreamOption& option) = 0;

  // Publish/Unpublish tracks
  //
  virtual int PublishLocalAudioTrack(
      std::shared_ptr<AgoraRteRtcAudioTrackBase> track) = 0;

  virtual int PublishLocalVideoTrack(
      std::shared_ptr<AgoraRteRtcVideoTrackBase> track) = 0;

  virtual int UnpublishLocalAudioTrack(
      std::shared_ptr<AgoraRteRtcAudioTrackBase> track) = 0;

  virtual int UnpublishLocalVideoTrack(
      std::shared_ptr<AgoraRteRtcVideoTrackBase> track) = 0;

  // Set audio/video encoder configuration
  //
  virtual int SetAudioEncoderConfiguration(
      const AudioEncoderConfiguration& config) = 0;

  virtual int SetVideoEncoderConfiguration(
      const VideoEncoderConfiguration& config) = 0;

  // Enable or disable audio observer, scene will call this when customer
  // registed related observer to scene, or disable observer when none observer
  // is registed in scene
  //
  virtual int EnableLocalAudioObserver(
      const LocalAudioObserverOptions& options) = 0;

  virtual int DisableLocalAudioObserver() = 0;

  virtual int SetCloudCdnTranscoding(
      const agora::rtc::LiveTranscoding& transcoding) = 0;

  virtual int AddCloudCdnUrl(const std::string& target_cdn_url,
                             bool transcoding_enabled) = 0;

  virtual int RemoveCloudCdnUrl(const std::string& target_cdn_url) = 0;
};

class AgoraRteRemoteStream
    : public std::enable_shared_from_this<AgoraRteRemoteStream>,
      public AgoraRteStream {
 public:
  AgoraRteRemoteStream(const std::string& user_id, const std::string& stream_id,
                       StreamType stream_type)
      : AgoraRteStream(user_id, stream_id, stream_type) {}

  virtual ~AgoraRteRemoteStream() = default;

  // Subscribe/Unsubscribe tracks
  //
  virtual int SubscribeRemoteAudio() = 0;

  virtual int UnsubscribeRemoteAudio() = 0;

  virtual int SubscribeRemoteVideo(const VideoSubscribeOptions& options) = 0;

  virtual int UnsubscribeRemoteVideo() = 0;

  // Set remote video canvas
  //
  virtual int SetRemoteVideoCanvas(const VideoCanvas& canvas) = 0;

  virtual int AdjustRemoteVolume(int volume) = 0;

  virtual int GetRemoteVolume(int* volume) = 0;

  // Enable or disable audio/video observer, scene will call this when customer
  // registed related observer to scene, or disable observer when none observer
  // is registed in scene
  //
  virtual int EnableRemoteVideoObserver() = 0;

  virtual int DisableRemoveVideoObserver() = 0;

  virtual int EnableRemoteAudioObserver(
      const RemoteAudioObserverOptions& options) = 0;

  virtual int DisableRemoteAudioObserver() = 0;

  virtual int SetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   const std::string& json_value) = 0;

  virtual int GetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   std::string& json_value) = 0;
};

}  // namespace rte
}  // namespace agora
