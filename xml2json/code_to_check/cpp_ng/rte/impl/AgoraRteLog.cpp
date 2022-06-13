//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteLog.h"

#include "AgoraRteUtils.h"

namespace agora {
namespace rte {

RTE_INLINE void AgoraRteLogger::SetLevel(LogLevel log_level) {
  auto& log = GetLogger();
  log.log_level_ = log_level;
}

RTE_INLINE void AgoraRteLogger::EnableLogging(bool enabled) {
  auto& log = GetLogger();
  log.is_log_enabled_ = enabled;
}

RTE_INLINE void AgoraRteLogger::SetListener(LogListener listener) {
  auto& log = GetLogger();

  std::lock_guard<std::mutex> _(log.listener_lock_);
  log.log_listener_ = listener;
}

RTE_INLINE void AgoraRteLogger::Write(LogLevel level,
                                      const std::string& message) {
  auto& log = GetLogger();

  std::lock_guard<std::mutex> _(log.listener_lock_);
  if (log.log_listener_) {
    log.log_listener_(message);
  }
}

RTE_INLINE bool AgoraRteLogger::ShouldWriteLog(LogLevel level) const {
  return is_log_enabled_ && level >= log_level_;
}

RTE_INLINE AgoraRteLogger& AgoraRteLogger::GetLogger() {
  static AgoraRteLogger g_logger;
  return g_logger;
}

RTE_INLINE std::string LoggerFormat::Format() {
  auto str_level = AgoraRteLogger::GetLabel(level_);

  std::ostringstream format;
  format << str_level << " [" << AgoraRteUtils::get_thread_id() << "] "
         << AgoraRteUtils::GetNowTimeAsString() << "  "
         << file_.substr(file_.find_last_of('/') + 1) << ":" << line_ << "  "
         << (function_.empty() ? "" : (function_) + "  ");
  return format.str();
}

}  // namespace rte
}  // namespace agora