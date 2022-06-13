//
//  Agora SDK
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
//  Created by xiaohua.lu in 2020-03.
//  CodeStyle: Google C++
//

#pragma once

#include "IAgoraMediaStreamingSource.h"
#include "utils/thread/thread_control_block.h"  // for agora::utils::worker_type



namespace agora {

namespace base {
class IAgoraService;
}  // namespace base

namespace rtc {

class IAudioEncodedFrameSender;
class IVideoEncodedImageSender;

class IMediaStreamingSourceEx : public IMediaStreamingSource {
 protected:
  virtual ~IMediaStreamingSourceEx() = default;

 public:
  static agora_refptr<IMediaStreamingSource> Create(base::IAgoraService *agora_service,
                                                 utils::worker_type streaming_worker );

  virtual agora_refptr<IAudioEncodedFrameSender> getEncodedAudioFrameSender() = 0;
  virtual agora_refptr<IVideoEncodedImageSender> getEncodedVideoFrameSender() = 0;
};

}  // namespace rtc
}  // namespace agora
