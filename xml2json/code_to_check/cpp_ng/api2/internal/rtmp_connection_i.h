//
//  Agora RTC/MEDIA SDK
//
//  Created by Pengfei Han in 2021-02.
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once

#include <stddef.h>
#include <stdint.h>

#include "NGIAgoraRtmpConnection.h"

namespace agora {
namespace rtc {

class IRtmpConnectionEx : public IRtmpConnection {
public:
  virtual int initialize(const RtmpConnectionConfiguration &config) = 0;
  virtual int deinitialize() = 0;
  virtual int SendAudioFrame(const uint8_t* data, size_t size, int64_t pts_ms) = 0;
  virtual int SendVideoFrame(const uint8_t* data, size_t size, int64_t pts_ms, bool is_key) = 0;
};

}  // namespace rtc
}  // namespace agora
