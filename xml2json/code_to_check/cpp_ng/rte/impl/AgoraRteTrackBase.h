//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteMediaTrack.h"

namespace agora {
namespace rte {

class AgoraRteLocalStream;
class AgoraRteTrackImplBase;
class AgoraRteVideoTrackImpl;
class AgoraRteAudioTrackImpl;

// This class is to define private interface functions, we don't want to define
// these functions in IAgoraRteXXXX.h.
//
class AgoraRteTrackBase
    : public std::enable_shared_from_this<AgoraRteTrackBase> {
 public:
  AgoraRteTrackBase();

  virtual ~AgoraRteTrackBase() = default;

  virtual void Init() {}

  virtual void SetStreamId(const std::string& stream_id) = 0;

  // These functions are to change track states since we don't want to expose
  // state change to child class.
  //
  virtual int BeforePublish(const std::shared_ptr<AgoraRteLocalStream>& stream);

  virtual void AfterPublish(int result,
                            const std::shared_ptr<AgoraRteLocalStream>& stream);

  virtual int BeforeUnPublish(
      const std::shared_ptr<AgoraRteLocalStream>& stream);

  virtual void AfterUnPublish(
      int result, const std::shared_ptr<AgoraRteLocalStream>& stream);

  virtual void OnTrackPublished();

  virtual void OnTrackUnpublished();

  const std::string& GetTrackId() { return track_id_; }

  virtual int BeforeVideoEncodingChanged(
      const VideoEncoderConfiguration& config) = 0;

  static int64_t GenerateTrackTicket() {
    static std::atomic<int64_t> track_ticket = {0};
    return ++track_ticket;
  }

 protected:
  int CheckAndChangePublishState();

  int CheckAndChangeUnpublishState();

  std::string track_id_;
  std::mutex track_pub_state_lock_;
  PublishState track_pub_stat_ = PublishState::kUnpublished;
  PublishState track_state_before_unpub = PublishState::kUnpublished;
};

class AgoraRteRtcTrackBase : public AgoraRteTrackBase {
 public:
  explicit AgoraRteRtcTrackBase(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
      : rtc_service_(rtc_service) {}

  virtual ~AgoraRteRtcTrackBase() = default;

  virtual std::shared_ptr<AgoraRteTrackImplBase> GetTackImpl() = 0;

  int BeforeVideoEncodingChanged(
      const VideoEncoderConfiguration& config) override {
    return ERR_OK;  // Do nothing by default
  }

  virtual int EnableExtension(const std::string& provider_name,
                              const std::string& extension_name) = 0;

  virtual int SetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   const std::string& json_value) = 0;
  virtual int GetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   std::string& json_value) = 0;

 protected:
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;
};

class AgoraRteRtcVideoTrackBase : public AgoraRteRtcTrackBase {
 public:
  explicit AgoraRteRtcVideoTrackBase(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
      : AgoraRteRtcTrackBase(rtc_service) {}

  virtual ~AgoraRteRtcVideoTrackBase() = default;

  virtual std::shared_ptr<agora::rtc::ILocalVideoTrack> GetRtcVideoTrack()
      const = 0;

  std::shared_ptr<AgoraRteTrackImplBase> GetTackImpl() override;

  int EnableExtension(const std::string& provider_name,
                      const std::string& extension_name) override;

  int SetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           const std::string& json_value) override;

  int GetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           std::string& json_value) override;

 protected:
  std::shared_ptr<AgoraRteVideoTrackImpl> track_impl_;
};

class AgoraRteRtcAudioTrackBase : public AgoraRteRtcTrackBase {
 public:
  explicit AgoraRteRtcAudioTrackBase(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
      : AgoraRteRtcTrackBase(rtc_service) {}

  virtual ~AgoraRteRtcAudioTrackBase() = default;

  virtual std::shared_ptr<agora::rtc::ILocalAudioTrack> GetRtcAudioTrack()
      const = 0;

  std::shared_ptr<AgoraRteTrackImplBase> GetTackImpl() override;

  int EnableExtension(const std::string& provider_name,
                      const std::string& extension_name) override;

  int SetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           const std::string& json_value) override;

  int GetExtensionProperty(const std::string& provider_name,
                           const std::string& extension_name,
                           const std::string& key,
                           std::string& json_value) override;

 protected:
  std::shared_ptr<AgoraRteAudioTrackImpl> track_impl_;
};
}  // namespace rte
}  // namespace agora
