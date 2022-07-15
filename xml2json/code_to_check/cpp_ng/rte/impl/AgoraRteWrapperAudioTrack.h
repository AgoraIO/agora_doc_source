//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once

#include "AgoraRefPtr.h"
#include "AgoraRteAudioTrackImpl.h"
#include "AgoraRteBase.h"
#include "AgoraRteTrackBase.h"
#include "IAgoraRteMediaTrack.h"

namespace agora {

namespace rtc {
class ILocalVideoTrack;
class ILocalAudioTrack;
class IMediaStreamingSource;
}  // namespace rtc

namespace rte {

class AgoraRteScene;

class AgoraRteWrapperAudioTrack : public IAgoraRteAudioTrack,
                                  public AgoraRteRtcAudioTrackBase {
 public:
  AgoraRteWrapperAudioTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
      const std::shared_ptr<rtc::ILocalAudioTrack>& rtc_audio_track);

  //////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of IAgoraRteAudioTrack ////////////
  ///////////////////////////////////////////////////////////////////////
  int EnableLocalPlayback() override;
  SourceType GetSourceType() override;
  int AdjustPublishVolume(int volume) override;
  int AdjustPlayoutVolume(int volume) override;
  const std::string& GetAttachedStreamId() override;

  ///////////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of AgoraRteRtcAudioTrackBase ////////////
  ////////////////////////////////////////////////////////////////////////////
  std::shared_ptr<agora::rtc::ILocalAudioTrack> GetRtcAudioTrack()
      const override;

  ////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of AgoraRteTrackBase ////////////
  ////////////////////////////////////////////////////////////////////
  void SetStreamId(const std::string& stream_id) override;

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

 private:
};
}  // namespace rte
}  // namespace agora
