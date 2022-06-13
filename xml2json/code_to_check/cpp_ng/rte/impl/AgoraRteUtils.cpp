//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteUtils.h"

#include <memory>
#include <regex>
#include <string>

#include "AgoraRteCameraVideoTrack.h"
#include "AgoraRteCustomAudioTrack.h"
#include "AgoraRteCustomVideoTrack.h"
#include "AgoraRteMicrophoneAudioTrack.h"
#include "AgoraRteMixedVideoTrack.h"
#include "AgoraRteRtcStreamObserver.h"
#include "AgoraRteScreenVideoTrack.h"
#include "AgoraRteTrackBase.h"
#include "AgoraRteWrapperAudioTrack.h"
#include "AgoraRteWrapperVideoTrack.h"
#include "IAgoraRteMediaTrack.h"

#if defined(_WIN32)
#include <Windows.h>
#include <processthreadsapi.h>
#elif (defined(__linux__) || defined(__ANDROID__))  // NOLINT
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>
#else
#include <pthread.h>
#endif

#if defined(__clang__)
#if __has_feature(cxx_rtti)
#define RTTI_ENABLED
#endif
#elif defined(__GNUG__)
#if defined(__GXX_RTTI)
#define RTTI_ENABLED
#endif
#elif defined(_MSC_VER)
#if defined(_CPPRTTI)
#define RTTI_ENABLED
#endif
#endif

namespace agora {
namespace rte {

static const std::string g_rte_user_format = "u=%s";
static const std::string g_rte_stream_format = "v=%s&u=%s&s=%s";
static const std::string g_rte_token_version = "1";

RTE_INLINE std::shared_ptr<AgoraRteRtcVideoTrackBase> AgoraRteUtils::CastToImpl(
    std::shared_ptr<IAgoraRteVideoTrack> track) {
  std::shared_ptr<AgoraRteRtcVideoTrackBase> result;
  if (track) {
    switch (track->GetSourceType()) {
      case agora::rte::SourceType::kVideo_Camera: {
        result = std::static_pointer_cast<AgoraRteCameraVideoTrack>(track);
        break;
      }
      case agora::rte::SourceType::kVideo_Custom: {
        result = std::static_pointer_cast<AgoraRteCustomVideoTrack>(track);
        break;
      }
      case agora::rte::SourceType::kVideo_Mix: {
        result = std::static_pointer_cast<AgoraRteMixedVideoTrack>(track);
        break;
      }
      case agora::rte::SourceType::kVideo_Screen: {
        result = std::static_pointer_cast<AgoraRteScreenVideoTrack>(track);
        break;
      }
      case agora::rte::SourceType::kVideo_Wrapper: {
        result = std::static_pointer_cast<AgoraRteWrapperVideoTrack>(track);
        break;
      }
      default:
        assert(false);
        break;
    }
  }
  return result;
}

RTE_INLINE std::shared_ptr<AgoraRteRtcAudioTrackBase> AgoraRteUtils::CastToImpl(
    std::shared_ptr<IAgoraRteAudioTrack> track) {
  std::shared_ptr<AgoraRteRtcAudioTrackBase> result;
  if (track) {
    switch (track->GetSourceType()) {
      case agora::rte::SourceType::kAudio_Microphone: {
        result = std::static_pointer_cast<AgoraRteMicrophoneAudioTrack>(track);
        break;
      }
      case agora::rte::SourceType::kAudio_Custom: {
        result = std::static_pointer_cast<AgoraRteCustomAudioTrack>(track);
        break;
      }
      case agora::rte::SourceType::kAudio_Wrapper: {
        result = std::static_pointer_cast<AgoraRteWrapperAudioTrack>(track);
        break;
      }
      default:
        assert(false);
        break;
    }
  }
  return result;
}

RTE_INLINE std::string AgoraRteUtils::GenerateRtcStreamId(
    bool is_major_stream, const std::string& rtc_user_id,
    const std::string& stream_id) {
  std::string result;

  if (is_major_stream) {
    const std::string empty;
    result = GeneratorJsonUserId(g_rte_user_format, rtc_user_id.c_str());
  } else {
    result =
        GeneratorJsonUserId(g_rte_stream_format, g_rte_token_version.c_str(),
                            rtc_user_id.c_str(), stream_id.c_str());
  }

  return result;
}

RTE_INLINE bool AgoraRteUtils::SplitKeyPairInRtcStream(
    const std::string& key_pair, std::map<std::string, std::string>& store) {
  auto start = 0U;
  auto end = key_pair.find('=');
  if (end != std::string::npos) {
    std::string key = key_pair.substr(start, end - start);
    std::string value = key_pair.substr(end + 1);
    if (store[key].empty() && !value.empty()) {
      store[key] = value;
      return true;
    }
  }

  return false;
}

RTE_INLINE bool AgoraRteUtils::ExtractRtcStreamInfo(
    const std::string& rtc_stream_id, RteRtcStreamInfo& info) {
  std::smatch sm;

  if (rtc_stream_id.find("u=") == 0) {
    info.user_id = rtc_stream_id.substr(2);
    info.stream_id = "";
    info.is_major_stream = true;
    return !info.user_id.empty();
  }

  std::map<std::string, std::string> key_pairs;
  auto start = 0U;
  auto end = rtc_stream_id.find('&');
  while (end != std::string::npos) {
    std::string key_pair = rtc_stream_id.substr(start, end - start);
    start = end + 1U;
    end = rtc_stream_id.find('&', start);
    if (!SplitKeyPairInRtcStream(key_pair, key_pairs)) {
      return false;
    }
  }

  std::string last_pair = rtc_stream_id.substr(start, end);
  if (!SplitKeyPairInRtcStream(last_pair, key_pairs)) {
    return false;
  }

  info.user_id = key_pairs["u"];
  info.stream_id = key_pairs["s"];
  info.is_major_stream = false;
  return !info.user_id.empty() && !info.stream_id.empty();
}

RTE_INLINE ConnectionState
AgoraRteUtils::GetConnStateFromRtcState(rtc::CONNECTION_STATE_TYPE state) {
  switch (state) {
    case agora::rtc::CONNECTION_STATE_DISCONNECTED:
      return ConnectionState::kDisconnected;
    case agora::rtc::CONNECTION_STATE_CONNECTING:
      return ConnectionState::kConnecting;
    case agora::rtc::CONNECTION_STATE_CONNECTED:
      return ConnectionState::kConnected;
    case agora::rtc::CONNECTION_STATE_RECONNECTING:
      return ConnectionState::kReconnecting;
    case agora::rtc::CONNECTION_STATE_FAILED:
    default:
      return ConnectionState::kFailed;
  }
}

RTE_INLINE size_t AgoraRteUtils::get_thread_id() {
#ifdef _WIN32
  return static_cast<size_t>(::GetCurrentThreadId());
#elif defined(__linux__)
#if defined(__ANDROID__) && defined(__ANDROID_API__) && (__ANDROID_API__ < 21)
#define SYS_gettid __NR_gettid
#endif
  return static_cast<size_t>(::syscall(SYS_gettid));
#elif __APPLE__
  uint64_t tid;
  pthread_threadid_np(nullptr, &tid);
  return static_cast<size_t>(tid);
#else  // Default to standard C++11 (other Unix)
  return static_cast<size_t>(
      std::hash<std::thread::id>()(std::this_thread::get_id()));
#endif
}

RTE_INLINE RteApiLogger::RteApiLogger(const char* name, std::string fileName,
                                      int fileLine, const void* This,
                                      const char* params, ...) {
  va_list ap;
  char* buf = NULL;
  std::vector<char> vBuff;

  APPEND_LOG(params);

  uint64_t id = get_logid();
  std::string functionName = AgoraRteUtils::get_func_name(name);
  std::string nowtime = AgoraRteUtils::GetNowTimeAsString();
  int bufsize =
      snprintf(NULL, 0, "[%s][%zu] %s:%d (%.8" PRIu64 "):  %s(this:%p, %s)",
               nowtime.c_str(), AgoraRteUtils::get_thread_id(),
               fileName.substr(fileName.find_last_of('/') + 1).c_str(),
               fileLine, id, functionName.c_str(), This, buf ? buf : "void");
  if (bufsize <= 0) {
    return;
  }

  std::vector<char> vBuffer(bufsize + 1);
  char* logbuff = vBuffer.data();
  snprintf(logbuff, vBuffer.size(),
           "[%s][%zu] %s:%d (%.8" PRIu64 "):  %s(this:%p, %s)", nowtime.c_str(),
           AgoraRteUtils::get_thread_id(),
           fileName.substr(fileName.find_last_of('/') + 1).c_str(), fileLine,
           id, functionName.c_str(), This, buf ? buf : "void");

  agora::rte::AgoraRteLogger::GetLogger() << logbuff << "\n";
}

RTE_INLINE RteApiLogger::RteApiLogger(const char* name, std::string fileName,
                                      int fileLine, const char* callback_name,
                                      const void* This, const char* params,
                                      ...) {
  va_list ap;
  char* buf = NULL;
  std::vector<char> vBuff;

  APPEND_LOG(params);

  uint64_t id = get_logid();
  std::string nowtime = AgoraRteUtils::GetNowTimeAsString();
  std::string functionName =
      AgoraRteUtils::get_func_name(name) + "->" + callback_name;
  int bufsize =
      snprintf(NULL, 0, "[%s][%zu] %s:%d (%.8" PRIu64 "):  %s(this:%p, %s)",
               nowtime.c_str(), AgoraRteUtils::get_thread_id(),
               fileName.substr(fileName.find_last_of('/') + 1).c_str(),
               fileLine, id, functionName.c_str(), This, buf ? buf : "void");
  if (bufsize <= 0) {
    return;
  }

  std::vector<char> vBuffer(bufsize + 1);
  char* logbuff = vBuffer.data();
  snprintf(logbuff, vBuffer.size(),
           "[%s][%zu] %s:%d (%.8" PRIu64 "):  %s(this:%p, %s)", nowtime.c_str(),
           AgoraRteUtils::get_thread_id(),
           fileName.substr(fileName.find_last_of('/') + 1).c_str(), fileLine,
           id, functionName.c_str(), This, buf ? buf : "void");

  agora::rte::AgoraRteLogger::GetLogger() << logbuff << "\n";
}

RTE_INLINE uint64_t RteApiLogger::get_logid() {
  static std::atomic<uint64_t> logid = {0};
  return ++logid;
}

}  // namespace rte
}  // namespace agora
