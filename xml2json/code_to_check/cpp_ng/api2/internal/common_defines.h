//
//  Agora RTC/MEDIA SDK
//
//  Created by Letao Zhang in 2019-08.
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
#pragma once

#include <memory>

namespace webrtc {
class Call;
}  // namespace webrtc

namespace agora {
namespace rtc {

using PipelineBuilder = std::shared_ptr<webrtc::Call>;
using WeakPipelineBuilder = std::weak_ptr<webrtc::Call>;

static const char* kAudioStreamTrackId = "audio_stream_track_id";
static const char* kVideoMajorStreamTrackId = "video_major_stream_track_id";
static const char* kVideoMinorStreamTrackId = "video_minor_stream_track_id";

}  // namespace rtc
}  // namespace agora
