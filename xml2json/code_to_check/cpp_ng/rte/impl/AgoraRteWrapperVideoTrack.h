//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once

#include "AgoraRefPtr.h"
#include "AgoraRteBase.h"
#include "AgoraRteTrackBase.h"
#include "AgoraRteVideoTrackImpl.h"
#include "IAgoraRteMediaTrack.h"

namespace agora {

namespace rtc {
class ILocalVideoTrack;
class ILocalAudioTrack;
class IMediaStreamingSource;
}  // namespace rtc

namespace rte {
class AgoraRteWrapperVideoTrack : public IAgoraRteVideoTrack,
                                  public AgoraRteRtcVideoTrackBase {
 public:
  AgoraRteWrapperVideoTrack(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service,
      const std::shared_ptr<rtc::ILocalVideoTrack>& rtc_video_track);

  //////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of IAgoraRteVideoTrack ////////////
  ///////////////////////////////////////////////////////////////////////
  int SetPreviewCanvas(const VideoCanvas& canvas) override;
  SourceType GetSourceType() override;
  void RegisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;
  void UnregisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) override;
  int SetFilterProperty(const std::string& id, const std::string& key,
                        const std::string& json_value) override;
  std::string GetFilterProperty(const std::string& id,
                                const std::string& key) override;
  const std::string& GetAttachedStreamId() override;

  ////////////////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of AgoraRteRtcVideoTrackBase
  ///////////////////
  ////////////////////////////////////////////////////////////////////////////////
  std::shared_ptr<agora::rtc::ILocalVideoTrack> GetRtcVideoTrack()
      const override;

  ////////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of AgoraRteTrackBase ////////////////
  ////////////////////////////////////////////////////////////////////////
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

 protected:
};
}  // namespace rte
}  // namespace agora
