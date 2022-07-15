//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteStreamFactory.h"

#include "AgoraRteCdnStream.h"
#include "AgoraRteRtcCompatibleStream.h"
#include "AgoraRteRtcStream.h"
#include "AgoraRteScene.h"

namespace agora {
namespace rte {
RTE_INLINE AgoraRteStreamFactory::AgoraRteStreamFactory(
    const std::string& appid,
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : appid_(appid), rtc_service_(rtc_service) {}

RTE_INLINE std::shared_ptr<AgoraRteMajorStream>
AgoraRteStreamFactory::CreateMajorStream(std::shared_ptr<AgoraRteScene> scene,
                                         const std::string& token,
                                         const JoinOptions& options) {
  // Here we don't check permission from remote server, as we assume everyone
  // could login
  //
  RTE_LOGGER_MEMBER(
      "scene: %p, token: %s, option: (is_user_visible_to_remote: %d)",
      scene.get(), token.c_str(), options.is_user_visible_to_remote);

  switch (scene->GetSceneInfo().scene_type) {
    case SceneType::kAdhoc: {
      auto stream = std::make_shared<AgoraRteRtcMajorStream>(
          scene, rtc_service_, token, options);
      return stream;
    }
    case SceneType::kCompatible: {
      auto stream = std::make_shared<AgoraRteRtcCompatibleMajorStream>(
          scene, rtc_service_, token, options);
      return stream;
    }
    default:
      break;
  }
  return nullptr;
}

RTE_INLINE std::shared_ptr<AgoraRteLocalStream>
AgoraRteStreamFactory::CreateLocalStream(std::shared_ptr<AgoraRteScene> scene,
                                         const StreamOption& option,
                                         const std::string& stream_id) {
  RTE_LOGGER_MEMBER("option: (type+ %d), stream_id: %s", option.GetType(),
                    stream_id.c_str());
  auto major_stream = scene->GetMajorStream();

  if (!major_stream) {
    return nullptr;
  }

  // Check whether we are allowed to create the stream from remote server (if
  // there is)
  //
  int result = major_stream->PushStreamInfo(
      {stream_id, scene->GetLocalUserInfo().user_id}, InstanceState::kCreating);
  if (result == ERR_OK) {
    // We are allowed to create stream
    //
    switch (option.GetType()) {
      case StreamType::kRtcStream: {
        const auto& rtc_option = static_cast<const RtcStreamOptions&>(option);

        switch (scene->GetSceneInfo().scene_type) {
          case SceneType::kAdhoc: {
            auto stream = std::make_shared<AgoraRteRtcLocalStream>(
                scene, rtc_service_, stream_id, rtc_option);
            return stream;
          }
          case SceneType::kCompatible: {
            auto compatible_major =
                std::static_pointer_cast<AgoraRteRtcCompatibleMajorStream>(
                    major_stream);
            auto stream = std::make_shared<AgoraRteRtcCompatibleLocalStream>(
                scene, compatible_major);
            return stream;
          }
          default:
            return nullptr;
        }
      }
      case StreamType::kCdnStream: {
        const auto& cnd_option =
            static_cast<const DirectCdnStreamOptions&>(option);
        auto stream = std::make_shared<AgoraRteCdnLocalStream>(
            scene, rtc_service_, stream_id, cnd_option.url);
        return stream;
      }
      default:
        break;
    }
  }

  return nullptr;
}
}  // namespace rte
}  // namespace agora
