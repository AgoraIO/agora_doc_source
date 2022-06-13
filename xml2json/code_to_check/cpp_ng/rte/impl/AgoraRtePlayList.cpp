//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRtePlayList.h"

#include "AgoraRteUtils.h"

namespace agora {
namespace rte {

template <typename T>
constexpr auto ERR_CODE(T err) {
  return -1 * static_cast<int>(err);
}

/////////////////////////////////////////////////////////////////////////////
///////////////// Methods Implementation of AgoraRtePlayList ////////////
//////////////////////////////////////////////////////////////////////////////
RTE_INLINE AgoraRtePlayList::AgoraRtePlayList(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : rtc_service_(rtc_service) {}

RTE_INLINE AgoraRtePlayList::~AgoraRtePlayList() {
  streaming_source_.reset();
  file_list_.clear();
}

//////////////////////////////////////////////////////////////////////////
///////////////// Override Methods of IAgoraRtePlayList //////////////////
///////////////////////////////////////////////////////////////////////////

RTE_INLINE int AgoraRtePlayList::ClearFileList() {
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if (current_file_ != nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.ClearFileList> list is in use";
    return ERR_CODE(agora::ERR_ALREADY_IN_USE);
  }

  file_list_.clear();
  total_duration_ = 0;
  current_file_ = nullptr;
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int32_t AgoraRtePlayList::GetFileCount() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);
  int32_t file_count = static_cast<int32_t>(file_list_.size());
  return file_count;
}

RTE_INLINE int64_t AgoraRtePlayList::GetTotalDuration() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);
  return total_duration_;
}

RTE_INLINE int AgoraRtePlayList::GetFileInfoById(int32_t file_id,
                                                 RteFileInfo& out_file_info) {
  RTE_LOGGER_MEMBER("file_id: %d", file_id);
  std::lock_guard<std::recursive_mutex> _(list_lock_);
  RteFileInfoSharePtr found_file = FindFileById(file_id);
  if (found_file == nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.GetFileInfoById> file_id=" << file_id
                  << ", NOT found";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  out_file_info.file_id = found_file->file_id;
  out_file_info.file_url = found_file->file_url;
  out_file_info.duration = found_file->duration;
  out_file_info.index = found_file->index;
  out_file_info.begin_time = found_file->begin_time;
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::GetFileInfoByIndex(
    int32_t file_index, RteFileInfo& out_file_info) {
  RTE_LOGGER_MEMBER("file_index: %d", file_index);
  std::lock_guard<std::recursive_mutex> _(list_lock_);
  RteFileInfoSharePtr found_file = FindFileByIndex(file_index);
  if (found_file == nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.GetFileInfoByIndex> file_index="
                  << file_index << ", NOT found";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  out_file_info.file_id = found_file->file_id;
  out_file_info.file_url = found_file->file_url;
  out_file_info.duration = found_file->duration;
  out_file_info.index = found_file->index;
  out_file_info.begin_time = found_file->begin_time;
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::GetFirstFileInfo(
    RteFileInfo& first_file_info) {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if (file_list_.empty()) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.GetFirstFileInfo> no files";
    return ERR_CODE(agora::ERR_INVALID_STATE);
  }

  RteFileInfoSharePtr front = file_list_.front();
  front->CloneTo(first_file_info);
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::GetLastFileInfo(RteFileInfo& last_file_info) {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if (file_list_.empty()) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.GetFirstFileInfo> no files";
    return ERR_CODE(agora::ERR_INVALID_STATE);
  }

  RteFileInfoSharePtr back = file_list_.back();
  back->CloneTo(last_file_info);
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::GetFileList(
    std::vector<RteFileInfo>& out_file_list) {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  std::list<RteFileInfoSharePtr>::iterator it;
  out_file_list.clear();
  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    out_file_list.push_back(*file_info);
  }

  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::InsertFile(const char* file_url,
                                            int32_t insert_index,
                                            RteFileInfo& out_file_info) {
  RTE_LOGGER_MEMBER("file_url: %s, insert_index: %d", file_url, insert_index);
  if ((file_url == nullptr) || (strlen(file_url) <= 0)) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.InsertFile> file_url invalid";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  media::base::PlayerStreamInfo video_info;
  media::base::PlayerStreamInfo audio_info;
  int ret = ParseMediaInfo(file_url, video_info, audio_info);
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR
        << "<AgoraRtePlayList.InsertFile> fail to parse media info, file_url="
        << file_url;
    return ERR_CODE(agora::ERR_LOAD_MEDIA_ENGINE);
  }

  {
    std::lock_guard<std::recursive_mutex> _(list_lock_);

    int32_t file_count = static_cast<int32_t>(file_list_.size());
    RteFileInfoSharePtr file_info = std::make_shared<RteFileInfo>();
    file_info->file_id = GetNextFileId();
    file_info->file_url = file_url;
    file_info->duration = (video_info.duration > audio_info.duration)
                              ? video_info.duration
                              : audio_info.duration;
    file_info->video_width = video_info.videoWidth;
    file_info->video_height = video_info.videoHeight;
    file_info->frame_rate = video_info.videoFrameRate;

    if (insert_index <= 0) {
      // insert into front of list
      file_list_.push_front(file_info);
    } else if (insert_index >= file_count) {
      // append into tail of list
      file_list_.push_back(file_info);
    } else {
      // find position and insert file info
      std::list<RteFileInfoSharePtr>::iterator it = file_list_.begin();
      int32_t i = 0;
      while (it != file_list_.end()) {
        if (i == insert_index) {
          file_list_.insert(it, file_info);
          break;
        }

        i++;
        it++;
      }
    }

    // Update begin_time & file index & total duration
    UpdateFileList(total_duration_);

    out_file_info.file_id = file_info->file_id;
    out_file_info.file_url = file_info->file_url;
    out_file_info.duration = file_info->duration;
    out_file_info.video_width = file_info->video_width;
    out_file_info.video_height = file_info->video_height;
    out_file_info.frame_rate = file_info->frame_rate;
    out_file_info.index = file_info->index;
    out_file_info.begin_time = file_info->begin_time;
  }

  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::AppendFile(const char* file_url,
                                            RteFileInfo& out_file_info) {
  RTE_LOGGER_MEMBER("file_url: %s", file_url);
  if ((file_url == nullptr) || (strlen(file_url) <= 0)) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.AppendFile> file_url invalid";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  media::base::PlayerStreamInfo video_info;
  media::base::PlayerStreamInfo audio_info;
  int ret = ParseMediaInfo(file_url, video_info, audio_info);
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR
        << "<AgoraRtePlayList.AppendFile> fail to parse duration, file_url="
        << file_url;
    return ERR_CODE(agora::ERR_LOAD_MEDIA_ENGINE);
  }

  {
    std::lock_guard<std::recursive_mutex> _(list_lock_);
    RteFileInfoSharePtr file_info = std::make_shared<RteFileInfo>();
    file_info->file_id = GetNextFileId();
    file_info->file_url = file_url;
    file_info->duration = (video_info.duration > audio_info.duration)
                              ? video_info.duration
                              : audio_info.duration;
    file_info->video_width = video_info.videoWidth;
    file_info->video_height = video_info.videoHeight;
    file_info->frame_rate = video_info.videoFrameRate;

    // append into tail of list
    file_list_.push_back(file_info);

    // Update begin_time & file index & total duration
    UpdateFileList(total_duration_);

    out_file_info.file_id = file_info->file_id;
    out_file_info.file_url = file_info->file_url;
    out_file_info.duration = file_info->duration;
    out_file_info.video_width = file_info->video_width;
    out_file_info.video_height = file_info->video_height;
    out_file_info.frame_rate = file_info->frame_rate;
    out_file_info.index = file_info->index;
    out_file_info.begin_time = file_info->begin_time;
  }

  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::RemoveFileById(int32_t remove_file_id) {
  RTE_LOGGER_MEMBER("remove_file_id: %d", remove_file_id);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  RteFileInfoSharePtr found_file = FindFileById(remove_file_id);
  if (found_file == nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileById> file_id="
                  << remove_file_id << ", NOT found";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  // Removing file is current playing file, close current file firstly
  if ((current_file_ != nullptr) &&
      (current_file_->file_id == found_file->file_id)) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileById> file_id="
                  << remove_file_id << ", is playing";
    return ERR_CODE(agora::ERR_ALREADY_IN_USE);
  }

  file_list_.remove(found_file);

  // Update begin_time & file index & total duration
  UpdateFileList(total_duration_);

  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::RemoveFileByIndex(int32_t remove_file_index) {
  RTE_LOGGER_MEMBER("remove_file_index: %d", remove_file_index);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  int32_t file_count = static_cast<int32_t>(file_list_.size());
  if (remove_file_index < 0 || remove_file_index >= file_count) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileByIndex> index="
                  << remove_file_index << ", Invalid";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  RteFileInfoSharePtr found_file = FindFileByIndex(remove_file_index);
  if (found_file == nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileByIndex> index="
                  << remove_file_index << ", NOT found";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  // Removing file is current playing file, close current file firstly
  if ((current_file_ != nullptr) &&
      (current_file_->file_id == found_file->file_id)) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileByIndex> index="
                  << remove_file_index << ", is playing";
    return ERR_CODE(agora::ERR_ALREADY_IN_USE);
  }

  file_list_.remove(found_file);

  // Update begin_time & file index & total duration
  UpdateFileList(total_duration_);

  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::RemoveFileByUrl(const char* remove_file_url) {
  RTE_LOGGER_MEMBER("remove_file_url: %s", remove_file_url);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if ((remove_file_url == nullptr) || (strlen(remove_file_url) <= 0)) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileByUrl> url Invalid";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  std::vector<RteFileInfoSharePtr> found_list;
  FindFileByUrl(remove_file_url, found_list);
  if (found_list.empty()) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileByUrl> url="
                  << remove_file_url << ", NOT found";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  for (RteFileInfoSharePtr found_info : found_list) {
    if ((current_file_ != nullptr) &&
        (current_file_->file_id == found_info->file_id)) {
      RTE_LOG_ERROR << "<AgoraRtePlayList.RemoveFileByIndex> url="
                    << remove_file_url << ", is playing";
      return ERR_CODE(agora::ERR_ALREADY_IN_USE);
    }
  }

  // Removing found files
  for (RteFileInfoSharePtr found_info : found_list) {
    file_list_.remove(found_info);
  }

  // Update begin_time & file index & total duration
  UpdateFileList(total_duration_);

  return ERR_CODE(agora::ERR_OK);
}

///////////////////////////////////////////////////////////////
///////////////// Only public for RTE Internal ///////////////
///////////////////////////////////////////////////////////////

RTE_INLINE int AgoraRtePlayList::SetCurrFileById(int32_t file_id) {
  RTE_LOGGER_MEMBER("file_id: %d", file_id);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if (file_id == INVALID_RTE_FILE_ID) {
    current_file_ = nullptr;
    return ERR_CODE(agora::ERR_OK);
  }

  RteFileInfoSharePtr found_file = FindFileById(file_id);
  if (found_file == nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.SetCurrentFile> file_id=" << file_id
                  << ", NOT found";
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  current_file_ = found_file;
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::SetCurrFileByListTime(
    int64_t time_in_list, int64_t& out_time_in_file) {
  RTE_LOGGER_MEMBER("time_in_list: %" PRId64 "", time_in_list);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if ((time_in_list < 0) || (time_in_list >= total_duration_)) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.SetCurrFileByListTime> Invalid time "
                  << time_in_list;
    return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
  }

  std::list<RteFileInfoSharePtr>::iterator it;
  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    int64_t end_time = file_info->begin_time + file_info->duration;
    if ((time_in_list >= file_info->begin_time) && (time_in_list < end_time)) {
      current_file_ = file_info;
      out_time_in_file = (time_in_list - file_info->begin_time);
      return agora::ERR_OK;
    }
  }

  RTE_LOG_ERROR << "<AgoraRtePlayList.SetCurrFileByListTime> Invalid time "
                << time_in_list;
  return ERR_CODE(agora::ERR_INVALID_ARGUMENT);
}

RTE_INLINE bool AgoraRtePlayList::CurrentIsFirstFile() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if ((file_list_.empty()) || (current_file_ == nullptr)) {
    return false;
  }

  RteFileInfoSharePtr front = file_list_.front();
  if (front->file_id == current_file_->file_id) {
    return true;
  }

  return false;
}

RTE_INLINE bool AgoraRtePlayList::CurrentIsLastFile() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if ((file_list_.empty()) || (current_file_ == nullptr)) {
    return false;
  }

  RteFileInfoSharePtr back = file_list_.back();
  if (back->file_id == current_file_->file_id) {
    return true;
  }

  return false;
}

RTE_INLINE int AgoraRtePlayList::GetCurrentFileInfo(
    RteFileInfo& out_curr_file_info) {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  if (current_file_ == nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.GetCurrentFileInfo> no current file";
    return ERR_CODE(agora::ERR_INVALID_STATE);
  }

  out_curr_file_info.file_id = current_file_->file_id;
  out_curr_file_info.file_url = current_file_->file_url;
  out_curr_file_info.duration = current_file_->duration;
  out_curr_file_info.video_width = current_file_->video_width;
  out_curr_file_info.video_height = current_file_->video_height;
  out_curr_file_info.frame_rate = current_file_->frame_rate;
  out_curr_file_info.index = current_file_->index;
  out_curr_file_info.begin_time = current_file_->begin_time;
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::MoveCurrentToPrev(bool list_loop) {
  RTE_LOGGER_MEMBER("list_loop: %d", list_loop);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  RteFileInfoSharePtr file_info = FindPrevFile(list_loop);
  if (file_info == nullptr) {
    RTE_LOG_ERROR
        << "<AgoraRtePlayList.MoveCurrentFileToPrev> no previous file";
    return ERR_CODE(agora::ERR_INVALID_STATE);
  }

  // set new current file
  current_file_ = file_info;
  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE int AgoraRtePlayList::MoveCurrentToNext(bool list_loop) {
  RTE_LOGGER_MEMBER("list_loop: %d", list_loop);
  std::lock_guard<std::recursive_mutex> _(list_lock_);

  RteFileInfoSharePtr file_info = FindNextFile(list_loop);
  if (file_info == nullptr) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.MoveCurrentFileToNext> no next file";
    return ERR_CODE(agora::ERR_INVALID_STATE);
  }

  // set new current file
  current_file_ = file_info;
  return ERR_CODE(agora::ERR_OK);
}

//////////////////////////////////////////////////////////////////////////////
////////////////// Implementation of Internal Methods  ////////////////////////
///////////////////////////////////////////////////////////////////////////////
RTE_INLINE int AgoraRtePlayList::ParseMediaInfo(
    const char* file_url, media::base::PlayerStreamInfo& video_info,
    media::base::PlayerStreamInfo& audio_info) {
  RTE_LOGGER_MEMBER("file_url: %s", file_url);
  if (streaming_source_ == nullptr) {
    streaming_source_ =
        rtc_service_->createMediaNodeFactory()->createMediaStreamingSource();
  }

  if (streaming_source_ == nullptr) {
    return ERR_CODE(agora::ERR_NOT_READY);
  }

  int ret = streaming_source_->parseMediaInfo(file_url, video_info, audio_info);
  if (ret != agora::rtc::STREAMING_SRC_ERR_NONE) {
    RTE_LOG_ERROR << "<AgoraRtePlayList.ParseMediaDuration> fail to parse, url="
                  << file_url;
    return ERR_CODE(agora::ERR_NOT_SUPPORTED);
  }

  int64_t out_duration = (video_info.duration > audio_info.duration)
                             ? video_info.duration
                             : audio_info.duration;
  if (out_duration <= 0) {
    RTE_LOG_ERROR
        << "<AgoraRtePlayList.ParseMediaDuration> media info invalid, url="
        << file_url;
    return ERR_CODE(agora::ERR_NOT_SUPPORTED);
  }

  return ERR_CODE(agora::ERR_OK);
}

RTE_INLINE RteFileInfoSharePtr
AgoraRtePlayList::FindFileById(int32_t find_file_id) {
  RTE_LOGGER_MEMBER("find_file_id: %d", find_file_id);
  std::list<RteFileInfoSharePtr>::iterator it;
  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    if (file_info->file_id == find_file_id) {
      return file_info;
    }
  }

  return nullptr;
}

RTE_INLINE RteFileInfoSharePtr
AgoraRtePlayList::FindFileByIndex(int32_t find_file_index) {
  RTE_LOGGER_MEMBER("find_file_index: %d", find_file_index);
  std::list<RteFileInfoSharePtr>::iterator it;
  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    if (file_info->index == find_file_index) {
      return file_info;
    }
  }

  return nullptr;
}

RTE_INLINE void AgoraRtePlayList::FindFileByUrl(
    const char* find_file_url,
    std::vector<RteFileInfoSharePtr>& file_info_list) {
  RTE_LOGGER_MEMBER("find_file_url: %s", find_file_url);
  std::list<RteFileInfoSharePtr>::iterator it;
  std::string str_find_url = find_file_url;

  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    std::string str_file_url = file_info->file_url;
    if (str_find_url.compare(str_file_url) == 0) {
      file_info_list.push_back(file_info);
    }
  }
}

RTE_INLINE RteFileInfoSharePtr AgoraRtePlayList::FindPrevFile(bool list_loop) {
  RTE_LOGGER_MEMBER("list_loop: %d", list_loop);
  RteFileInfoSharePtr prev_file = nullptr;

  if (current_file_ == nullptr)  // current file is none
  {
    if (list_loop) {
      prev_file = file_list_.back();
    }
    return prev_file;
  }

  std::list<RteFileInfoSharePtr>::iterator it;
  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    if (file_info->file_id == current_file_->file_id) {
      if ((list_loop) && (prev_file == nullptr)) {
        prev_file = file_list_.back();
      }
      return prev_file;
    }
    prev_file = file_info;
  }

  return nullptr;  // not found current file
}

RTE_INLINE RteFileInfoSharePtr AgoraRtePlayList::FindNextFile(bool list_loop) {
  RTE_LOGGER_MEMBER("list_loop: %d", list_loop);
  RteFileInfoSharePtr next_file = nullptr;

  if (current_file_ == nullptr)  // current file is none
  {
    next_file = file_list_.front();
    return next_file;
  }

  std::list<RteFileInfoSharePtr>::iterator it;
  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    if (file_info->file_id == current_file_->file_id) {
      it++;  // next file

      if (it == file_list_.end()) {
        if (list_loop) {
          next_file = file_list_.front();
        }
      } else {
        next_file = (*it);
      }

      return next_file;
    }
  }

  return nullptr;  // not found current file
}

//
// Func: update file index and begin global timestamp
//
RTE_INLINE void AgoraRtePlayList::UpdateFileList(int64_t& out_total_duration) {
  RTE_LOGGER_MEMBER(nullptr);
  std::list<RteFileInfoSharePtr>::iterator it;
  int64_t begin_time = 0;
  int32_t file_index = 0;
  for (it = file_list_.begin(); it != file_list_.end(); it++) {
    RteFileInfoSharePtr file_info = (*it);
    file_info->begin_time = begin_time;
    file_info->index = file_index;

    begin_time += file_info->duration;
    file_index++;
  }
  out_total_duration = begin_time;
}
//
////
//// Func: Locate file information and position by global timestamp
////
// int AgoraRtePlayList::LocatePosition(int64_t global_timestamp,
// RteFileInfoSharePtr& found_file_info,
//                                          int64_t& pos_in_file) {
//  std::list<RteFileInfoSharePtr>::iterator it;
//  for (it = file_list_.begin(); it != file_list_.end(); it++) {
//    RteFileInfoSharePtr file_info = (*it);
//    int64_t end_time = file_info->begin_time + file_info->duration;
//    if ((global_timestamp >= file_info->begin_time) && (global_timestamp <
//    end_time)) {
//      found_file_info = file_info;
//      pos_in_file = (global_timestamp - file_info->begin_time);
//      return agora::rtc::STREAMING_SRC_ERR_NONE;
//    }
//  }
//
//  // global_timestamp < 0 or global_timestamp >= total_duration
//  return ERR_CODE(agora::rtc::STREAMING_SRC_ERR_INVALID_PARAM);
//}

}  // namespace rte
}  // namespace agora
