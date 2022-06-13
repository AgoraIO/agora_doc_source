//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once

#include <list>
#include <memory>

#include "AgoraRefPtr.h"
#include "AgoraRteBase.h"
#include "AgoraRteUtils.h"
#include "IAgoraMediaStreamingSource.h"
#include "IAgoraRtePlayList.h"

namespace agora {
namespace rte {

class AgoraRtePlayList : public IAgoraRtePlayList {
 public:
  explicit AgoraRtePlayList(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);
  virtual ~AgoraRtePlayList();

  //////////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of IAgoraRtePlayList //////////////////
  ///////////////////////////////////////////////////////////////////////////
  int ClearFileList() override;
  int32_t GetFileCount() override;
  int64_t GetTotalDuration() override;
  int GetFileInfoById(int32_t file_id, RteFileInfo& out_file_info) override;
  int GetFileInfoByIndex(int32_t file_index,
                         RteFileInfo& out_file_info) override;
  int GetFirstFileInfo(RteFileInfo& first_file_info) override;
  int GetLastFileInfo(RteFileInfo& last_file_info) override;
  int GetFileList(std::vector<RteFileInfo>& out_file_list) override;

  int InsertFile(const char* file_url, int32_t insert_index,
                 RteFileInfo& out_file_info) override;
  int AppendFile(const char* file_url, RteFileInfo& out_file_info) override;

  int RemoveFileById(int32_t remove_file_id) override;
  int RemoveFileByIndex(int32_t remove_file_index) override;
  int RemoveFileByUrl(const char* remove_file_url) override;

  ///////////////////////////////////////////////////////////////
  ///////////////// Only public for RTE Internal ///////////////
  ///////////////////////////////////////////////////////////////
  int SetCurrFileById(int32_t file_id);
  int SetCurrFileByListTime(int64_t time_in_list, int64_t& out_time_in_file);
  bool CurrentIsFirstFile();
  bool CurrentIsLastFile();
  int GetCurrentFileInfo(RteFileInfo& out_curr_file_info);
  int MoveCurrentToPrev(bool list_loop);
  int MoveCurrentToNext(bool list_loop);
  RteFileInfoSharePtr FindPrevFile(bool list_loop);
  RteFileInfoSharePtr FindNextFile(bool list_loop);

 protected:
  int ParseMediaInfo(const char* file_url,
                     media::base::PlayerStreamInfo& video_info,
                     media::base::PlayerStreamInfo& audio_info);
  RteFileInfoSharePtr FindFileById(int32_t find_file_id);
  RteFileInfoSharePtr FindFileByIndex(int32_t find_file_index);
  void FindFileByUrl(const char* find_file_url,
                     std::vector<RteFileInfoSharePtr>& file_info_list);
  void UpdateFileList(int64_t& out_total_duration);

  static int32_t GetNextFileId() {
    static std::atomic<int32_t> global_file_id_ = {0};
    return global_file_id_++;
  }

 protected:
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;
  static std::atomic<int32_t>
      global_file_id_;  ///< Global increase-self file Id
  agora_refptr<agora::rtc::IMediaStreamingSource> streaming_source_ = nullptr;
  std::recursive_mutex list_lock_;              ///< locker for AgoraRtePlayList
  std::list<RteFileInfoSharePtr> file_list_;    ///< file list
  RteFileInfoSharePtr current_file_ = nullptr;  ///< current file
  int64_t total_duration_ = 0;                  ///< total duration
};

}  // namespace rte
}  // namespace agora
