//
//  Agora RTC/MEDIA SDK
//
//  Created by Pengfei Han in 2020-09.
//  Copyright (c) 2020 Agora.io. All rights reserved.
//
#pragma once

#include <string>
#include <vector>

#include "AgoraBase.h"

namespace agora {
namespace rtc {

class IRtcConnectionEx;
struct TConnectionInfo;

class IDumpStateObserver {
public:
  virtual ~IDumpStateObserver();
  virtual void OnAudioFrameDumpCompleted(const char* channel_id, const user_id_t user_id, const std::string& location,
      const std::string& uuid, const std::vector<std::string>& files) = 0;
};

class ConnInfosIterator {
public:
  virtual ~ConnInfosIterator();
  virtual bool HasMoreConnInfo() const = 0;
  virtual int NextConnInfo() = 0;
  virtual TConnectionInfo CurrentConnInfo() const = 0;
};

class IDiagnosticService {
public:
  IDiagnosticService() = default;
  virtual ~IDiagnosticService() = default;

  virtual void Uninitialize()  = 0;

  virtual int RegisterDumpStateObserver(IDumpStateObserver* observer) = 0;
  virtual int UnregisterDumpStateObserver(IDumpStateObserver* observer) = 0;

  virtual int RegisterRtcConnection(IRtcConnectionEx* conn) = 0;
  virtual int UnregisterRtcConnection(IRtcConnectionEx* conn) = 0;

  /*
   * User should release the ConnInfosIterator got from this function with operator delete self.
   */
  virtual ConnInfosIterator* GetConnInfosIterator() const = 0;

  /*
   * If auto_upload is true, the dump file will be uploaded automatically when dump completed or stopped.
   */
  virtual int StartAudioFrameDump(const char* channel_id, user_id_t user_id, const std::string& location,
      const std::string& uuid, const std::string& passwd, int64_t duration_ms, bool auto_upload) = 0;
  /*
   * If auto_upload is set to false when call StartAudioFrameDump(), the file path of dump file will be
   * stored into files, or the dump file will be uploaded to the dump server automatically.
   */
  virtual int StopAudioFrameDump(const char* channel_id, user_id_t user_id, const std::string& location) = 0;

  /*
   * Start tracing
   */
  virtual int StartTrace(uint32_t count, uint64_t mask, int scale, bool truncate_group) = 0;

  /*
   * Stop tracing
   */
  virtual int StopTrace(const std::string& file_path) = 0;

};

}  // namespace rtc
}  // namespace agora
