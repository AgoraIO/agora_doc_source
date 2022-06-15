//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"

namespace agora {
namespace rte {
class AgoraRteTrackImplBase {
 public:
  std::shared_ptr<rtc::IMediaNodeFactory> GetMediaNodeFactory() {
    return media_node_factory_;
  }

  void SetStreamId(const std::string& stream_id) { stream_id_ = stream_id; }

  const std::string& GetStreamId() const { return stream_id_; }

  virtual ~AgoraRteTrackImplBase() = default;

  virtual int Start() = 0;
  virtual void Stop() = 0;

 protected:
  std::mutex track_lock_;
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;
  std::shared_ptr<rtc::IMediaNodeFactory> media_node_factory_;
  bool is_started_ = false;
  std::string stream_id_;
};
}  // namespace rte
}  // namespace agora
