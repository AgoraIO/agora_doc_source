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

class AgoraRteRtcVideoTrackBase;
class AgoraRteRtcAudioTrackBase;
class IAgoraRteVideoTrack;
class IAgoraRteAudioTrack;
struct RteRtcStreamInfo;

class AgoraRteUtils {
 public:
  template <typename EventHandlerT, typename MutexT>
  static void NotifyEventHandlers(
      MutexT& mutex, std::vector<std::weak_ptr<EventHandlerT>>& handlers,
      std::function<void(const std::shared_ptr<EventHandlerT>&)> task) {
    std::vector<std::shared_ptr<EventHandlerT>> shared_handles;

    {
      std::lock_guard<MutexT> _(mutex);

      handlers.erase(
          std::remove_if(
              handlers.begin(), handlers.end(),
              [&shared_handles](auto& handler) {
                bool should_remove = true;
                auto handler_shared = handler.lock();
                if (handler_shared) {
                  should_remove = false;
                  shared_handles.push_back(std::move(
                      std::static_pointer_cast<EventHandlerT>(handler_shared)));
                }

                return should_remove;
              }),
          handlers.end());
    }

    std::for_each(shared_handles.begin(), shared_handles.end(),
                  std::move(task));
  }

  template <typename EventHandlerT, typename MutexT>
  static void UnregisterSharedPtrFromContainer(
      MutexT& mutex, std::vector<std::weak_ptr<EventHandlerT>>& handlers,
      const std::shared_ptr<EventHandlerT>& shared_handles) {
    {
      std::lock_guard<MutexT> _(mutex);

      handlers.erase(
          std::remove_if(handlers.begin(), handlers.end(),
                         [&shared_handles](auto& handler) {
                           bool should_remove = true;
                           auto handler_shared = handler.lock();
                           if (handler_shared &&
                               handler_shared.get() != shared_handles.get()) {
                             should_remove = false;
                           }

                           return should_remove;
                         }),
          handlers.end());
    }
  }

  template <typename ObjectType>
  static std::shared_ptr<ObjectType> AgoraRefObjectToSharedObject(
      agora_refptr<ObjectType>& agora_object) {
    agora_object->AddRef();
    std::shared_ptr<ObjectType> result(agora_object.get(), [](ObjectType* obj) {
      if (obj) {
        obj->Release();
      }
    });
    return result;
  }

  static std::string GenerateRtcStreamId(bool is_major_stream,
                                         const std::string& user_id,
                                         const std::string& stream_id);

  template <typename... Args>
  static std::string GeneratorJsonUserId(const std::string& format,
                                         Args&&... args) {
    auto size =
        std::snprintf(nullptr, 0, format.c_str(), std::forward<Args>(args)...);
    std::string output(size + 1, '\0');
    std::sprintf(&output[0], format.c_str(), std::forward<Args>(args)...);
    return output;
  }

  static bool ExtractRtcStreamInfo(const std::string& rtc_stream_id,
                                   RteRtcStreamInfo& info);

  static ConnectionState GetConnStateFromRtcState(
      rtc::CONNECTION_STATE_TYPE state);

  static std::shared_ptr<AgoraRteRtcVideoTrackBase> CastToImpl(
      std::shared_ptr<IAgoraRteVideoTrack> track);

  static std::shared_ptr<AgoraRteRtcAudioTrackBase> CastToImpl(
      std::shared_ptr<IAgoraRteAudioTrack> track);

  static size_t get_thread_id();

  static std::string GetNowTimeAsString() {
    auto now = std::chrono::system_clock::now();
    auto ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                  now.time_since_epoch()) %
              1000;
    auto timer = std::chrono::system_clock::to_time_t(now);

    std::tm bt = *std::localtime(&timer);

    std::ostringstream oss;

    oss << std::put_time(&bt, "%H:%M:%S");
    oss << '.' << std::setfill('0') << std::setw(3) << ms.count();

    return oss.str();
  }

  static std::string get_func_name(const std::string& name) {
    size_t end = name.find('(');
    if (end == std::string::npos) return name;
    auto sub = name.substr(0, end);
    size_t colons = sub.rfind("::");
    if (colons == std::string::npos) return sub;
    colons = sub.rfind("::", colons - 2);
    if (colons == std::string::npos) return sub;
    return sub.substr(colons + 2);
  }

 private:
  static bool SplitKeyPairInRtcStream(
      const std::string& key_pair, std::map<std::string, std::string>& store);

};  // namespace rte

template <typename T>
class RtcCallbackWrapper : public T {
 public:
  using Type = std::shared_ptr<RtcCallbackWrapper<T>>;

  template <typename... Args>
  static Type Create(Args&&... args) {
    std::shared_ptr<RtcCallbackWrapper<T>> result(
        new RtcCallbackWrapper<T>(std::forward<Args>(args)...));
    // circular reference on purpose, function "DeleteMe" should be passed to
    // RTC as observer's safe deleter
    result->shared_me_ = result;
    return result;
  }

  virtual ~RtcCallbackWrapper() = default;

  // Note: This interface can only be invoked from inner callback deleter.
  void DeleteMe() { shared_me_.reset(); }

 private:
  template <typename... Args>
  explicit RtcCallbackWrapper(Args&&... args)
      : T(std::forward<Args>(args)...) {}

 private:
  // shared_me_ can only be invoked form inner callback thread.
  std::shared_ptr<RtcCallbackWrapper<T>> shared_me_;
};

#define APPEND_LOG(fmt)                       \
  do {                                        \
    if (!fmt) break;                          \
    va_start(ap, fmt);                        \
    int size = vsnprintf(NULL, 0, fmt, ap);   \
    va_end(ap);                               \
    vBuff.resize(size + 1);                   \
    buf = vBuff.data();                       \
    va_start(ap, fmt);                        \
    size = vsnprintf(buf, size + 1, fmt, ap); \
    va_end(ap);                               \
    if (size <= 0) {                          \
      buf = NULL;                             \
      break;                                  \
    }                                         \
  } while (0)

class RteApiLogger {
 public:
  RteApiLogger(const char* name, std::string fileName, int fileLine,
               const void* This, const char* params, ...);

  RteApiLogger(const char* name, std::string fileName, int fileLine,
               const char* callback_name, const void* This, const char* params,
               ...);

 private:
  uint64_t get_logid();
};

#if defined(_MSC_VER)
#define FUNCTION_MACRO __FUNCSIG__
#else
#define FUNCTION_MACRO __PRETTY_FUNCTION__
#endif

#define RTE_LOGGER_MEMBER(params, ...)                                      \
  RteApiLogger __logger__(FUNCTION_MACRO, __FILE__, __LINE__, this, params, \
                          ##__VA_ARGS__)

#define RTE_LOGGER_CALLBACK(callback, params, ...)                             \
  RteApiLogger __logger__(FUNCTION_MACRO, __FILE__, __LINE__, #callback, this, \
                          params, ##__VA_ARGS__)

}  // namespace rte
}  // namespace agora
