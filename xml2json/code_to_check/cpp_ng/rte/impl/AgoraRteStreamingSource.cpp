//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteStreamingSource.h"

#include "AgoraRtePlayList.h"
#include "AgoraRteUtils.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteStreamingSource::AgoraRteStreamingSource(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : rtc_service_(rtc_service) {
  //
  // Create rtc object
  //
  rtc_node_factory_ = rtc_service_->createMediaNodeFactory();
  rtc_streaming_source_ = rtc_node_factory_->createMediaStreamingSource();
  if (rtc_streaming_source_ == nullptr) {
    RTE_LOG_VERBOSE << "<AgoraRteStreamingSource> streaming_source is NULL";
    return;
  }
  auto rtc_audio_track =
      rtc_service_->createMediaStreamingAudioTrack(rtc_streaming_source_);
  auto rtc_video_track =
      rtc_service_->createMediaStreamingVideoTrack(rtc_streaming_source_);

  //
  // Create rte object
  //
  rte_audio_track_ = std::make_shared<AgoraRteWrapperAudioTrack>(
      rtc_service,
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalAudioTrack>(
          rtc_audio_track));
  rte_video_track_ = std::make_shared<AgoraRteWrapperVideoTrack>(
      rtc_service,
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalVideoTrack>(
          rtc_video_track));

  rtc_streaming_source_->registerObserver(this);
}

RTE_INLINE AgoraRteStreamingSource::~AgoraRteStreamingSource() {
  if (rtc_streaming_source_.get() != nullptr) {
    rtc_streaming_source_->unregisterObserver(this);
    rtc_streaming_source_.reset();
  }
  rte_audio_track_.reset();
  rte_audio_track_.reset();
  observer_list_.clear();

  if (play_list_ != nullptr) {
    play_list_->SetCurrFileById(INVALID_RTE_FILE_ID);
    play_list_ = nullptr;
  }
}

//////////////////////////////////////////////////////////////////////////
///////////////// Override Methods of IAgoraRteStreamingSource ////////////
///////////////////////////////////////////////////////////////////////////

RTE_INLINE std::shared_ptr<IAgoraRtePlayList>
AgoraRteStreamingSource::CreatePlayList() {
  RTE_LOGGER_MEMBER(nullptr);
  return std::make_shared<AgoraRtePlayList>(rtc_service_);
}

RTE_INLINE std::shared_ptr<IAgoraRteVideoTrack>
AgoraRteStreamingSource::GetRteVideoTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  return static_cast<std::shared_ptr<IAgoraRteVideoTrack>>(rte_video_track_);
}

RTE_INLINE std::shared_ptr<IAgoraRteAudioTrack>
AgoraRteStreamingSource::GetRteAudioTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  return static_cast<std::shared_ptr<IAgoraRteAudioTrack>>(rte_audio_track_);
}

RTE_INLINE int AgoraRteStreamingSource::Open(const char* url, int64_t start_pos,
                                             bool auto_play /* = true */) {
  {
    RTE_LOGGER_MEMBER("url: %s, start_pos: %" PRId64 ", auto_play: %d", url,
                      start_pos, auto_play);

    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {  // previous list have not closed
      RTE_LOG_ERROR
          << "<AgoraRteStreamingSource.Open> there is a play list exist";
      return -agora::ERR_INVALID_STATE;
    }

    current_file_.Reset();
    current_file_.file_id = 1;
    current_file_.file_url = url;
    current_file_.index = 0;
    first_file_id_ = current_file_.file_id;

    auto_play_for_open_ = auto_play;
  }

  int ret = rtc_streaming_source_->open(url, start_pos, auto_play);
  RTE_LOG_ERROR << "<AgoraRteStreamingSource.Open> finished, url=" << url;
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::Open(
    std::shared_ptr<IAgoraRtePlayList> in_play_list, int64_t start_pos,
    bool auto_play /* = true */) {
  RTE_LOGGER_MEMBER("in_play_list: %p, start_pos: %" PRId64 ", auto_play: %d",
                    in_play_list.get(), start_pos, auto_play);

  std::string start_file_url;

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {  // previous list have not closed
      RTE_LOG_ERROR
          << "<AgoraRteStreamingSource.Open> there is a play list exist";
      return -agora::ERR_INVALID_STATE;
    }
    if (in_play_list == nullptr) {
      return -agora::ERR_INVALID_ARGUMENT;
    }
    if (in_play_list->GetFileCount() <= 0) {
      return -agora::ERR_INVALID_ARGUMENT;
    }

    play_list_ = std::static_pointer_cast<AgoraRtePlayList>(in_play_list);

    current_file_.Reset();
    play_list_->GetFirstFileInfo(current_file_);
    play_list_->SetCurrFileById(current_file_.file_id);
    assert(current_file_.IsValid());
    first_file_id_ = current_file_.file_id;
    list_played_count_ = 0;

    auto_play_for_open_ = auto_play;
    start_file_url = current_file_.file_url;
  }

  int ret =
      rtc_streaming_source_->open(start_file_url.c_str(), start_pos, auto_play);
  RTE_LOG_ERROR << "<AgoraRteStreamingSource.Open> finished, start_file_url="
                << start_file_url;
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::Close() {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = rtc_streaming_source_->close();

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {
      play_list_->SetCurrFileById(INVALID_RTE_FILE_ID);
      play_list_ = nullptr;
    }
  }

  return ConvertErrCode(ret);
}

RTE_INLINE bool AgoraRteStreamingSource::IsVideoValid() {
  RTE_LOGGER_MEMBER(nullptr);
  bool video_valid = rtc_streaming_source_->isVideoValid();
  return video_valid;
}

RTE_INLINE bool AgoraRteStreamingSource::IsAudioValid() {
  bool audio_valid = rtc_streaming_source_->isAudioValid();
  return audio_valid;
}

RTE_INLINE int AgoraRteStreamingSource::GetDuration(int64_t& duration) {
  int ret = rtc_streaming_source_->getDuration(duration);
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::GetStreamCount(int64_t& count) {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = rtc_streaming_source_->getStreamCount(count);
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::GetStreamInfo(
    int64_t index, media::base::PlayerStreamInfo* out_info) {
  RTE_LOGGER_MEMBER("index: %" PRId64 "", index);
  int ret = rtc_streaming_source_->getStreamInfo(index, out_info);
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::SetLoopCount(int64_t loop_count) {
  {
    RTE_LOGGER_MEMBER("loop_count: %" PRId64 "", loop_count);
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    setting_loop_count = loop_count;
    list_played_count_ = 0;
  }

  if (play_list_ == nullptr) {  // Open only one file
    return rtc_streaming_source_->setLoopCount(loop_count);
  }

  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteStreamingSource::Play() {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = rtc_streaming_source_->play();
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::Pause() {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = rtc_streaming_source_->pause();
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::Stop() {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = rtc_streaming_source_->stop();
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::Seek(int64_t new_pos) {
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {
      RteFileInfo curr_file_info;
      play_list_->GetCurrentFileInfo(curr_file_info);
      if ((curr_file_info.duration > 0) &&
          (new_pos >= curr_file_info.duration)) {
        RTE_LOG_ERROR
            << "<AgoraRteStreamingSource.Seek> pos is more than duration";
        return -agora::ERR_INVALID_ARGUMENT;
      }
    }
  }

  int ret = rtc_streaming_source_->seek(new_pos);
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::SeekToPrev(int64_t pos) {
  RTE_LOGGER_MEMBER("pos: %" PRId64 "", pos);
  std::string curr_file_url;
  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToPrev> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {  // It doesn't support for only one file
      return -agora::ERR_INVALID_STATE;
    }
    if (play_list_->CurrentIsFirstFile()) {
      RTE_LOG_ERROR << "<AgoraRteStreamingSource.SeekToPrev> current already "
                       "is first file";
      return -agora::ERR_INVALID_STATE;
    }
    RteFileInfoSharePtr prev_file_ptr = play_list_->FindPrevFile(false);
    assert(prev_file_ptr != nullptr);
    if ((prev_file_ptr->duration > 0) && (pos >= prev_file_ptr->duration)) {
      RTE_LOG_ERROR
          << "<AgoraRteStreamingSource.SeekToPrev> pos is more than duration";
      return -agora::ERR_INVALID_ARGUMENT;
    }
  }

  // close current file
  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToPrev> closing...\n";
  int ret = rtc_streaming_source_->close();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "Failed to close source, error : " << ret;
    return ret;
  }

  // switch to previous file
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    RTE_LOG_VERBOSE
        << "<AgoraRteStreamingSource.SeekToPrev> moving to prev...\n";
    ret = play_list_->MoveCurrentToPrev(false);
    if (ret != agora::ERR_OK) {
      RTE_LOG_ERROR << "Failed to move to previous file, error : " << ret;
      return ret;
    }
    current_file_.Reset();
    play_list_->GetCurrentFileInfo(current_file_);
    assert(current_file_.IsValid());

    // start play previous file
    auto_play_for_open_ = true;
    curr_file_url = current_file_.file_url;
  }

  // start play previous file
  if (!curr_file_url.empty()) {
    RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToPrev> opening...\n";
    ret = rtc_streaming_source_->open(curr_file_url.c_str(), pos, true);
  }

  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToPrev> Exit\n";
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::SeekToNext(int64_t pos) {
  RTE_LOGGER_MEMBER("pos: %" PRId64 "", pos);
  std::string curr_file_url;
  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToNext> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {
      return -agora::ERR_INVALID_STATE;
    }
    if (play_list_->CurrentIsLastFile()) {
      RTE_LOG_ERROR << "<AgoraRteStreamingSource.SeekToNext> current already "
                       "is last file";
      return -agora::ERR_INVALID_STATE;
    }
    RteFileInfoSharePtr next_file_ptr = play_list_->FindNextFile(false);
    assert(next_file_ptr != nullptr);
    if ((next_file_ptr->duration > 0) && (pos >= next_file_ptr->duration)) {
      RTE_LOG_ERROR
          << "<AgoraRteStreamingSource.SeekToNext> pos is more than duration";
      return -agora::ERR_INVALID_ARGUMENT;
    }
  }

  // close current file
  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToNext> closing...\n";
  int ret = rtc_streaming_source_->close();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "Failed to close source, error : " << ret;
    return ret;
  }

  // switch to next file
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    RTE_LOG_VERBOSE
        << "<AgoraRteStreamingSource.SeekToPrev> moving to next...\n";
    ret = play_list_->MoveCurrentToNext(false);
    if (ret != agora::ERR_OK) {
      RTE_LOG_ERROR << "Failed to move to next file, error : " << ret;
      return ret;
    }
    current_file_.Reset();
    play_list_->GetCurrentFileInfo(current_file_);
    assert(current_file_.IsValid());

    // start play next file
    auto_play_for_open_ = true;
    curr_file_url = current_file_.file_url;
  }

  // start play next file
  if (!curr_file_url.empty()) {
    RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToNext> opening...\n";
    ret = rtc_streaming_source_->open(curr_file_url.c_str(), pos, true);
  }

  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToNext> Exit\n";
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::SeekToFile(int32_t file_id,
                                                   int64_t pos) {
  RTE_LOGGER_MEMBER("file_id: %d, pos: %" PRId64 "", file_id, pos);
  std::string curr_file_url;
  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToFile> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {
      return -agora::ERR_INVALID_STATE;
    }
    if (file_id == current_file_.file_id) {
      // Seek in current file
      int ret_inner_seek = rtc_streaming_source_->seek(pos);
      return ConvertErrCode(ret_inner_seek);
    }
  }

  // close current file
  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToFile> closing...\n";
  int ret = rtc_streaming_source_->close();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "Failed to close source, error : " << ret;
    return ret;
  }

  // switch to new file
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    RTE_LOG_VERBOSE
        << "<AgoraRteStreamingSource.SeekToFile> moving to file...\n";
    ret = play_list_->SetCurrFileById(file_id);
    if (ret != agora::ERR_OK) {
      RTE_LOG_ERROR << "<AgoraRteMediaPlayer.SeekToFile> failed, file_id= "
                    << file_id << ", pos= " << pos;
      return -agora::ERR_INVALID_ARGUMENT;
    }
    current_file_.Reset();
    play_list_->GetCurrentFileInfo(current_file_);
    assert(current_file_.IsValid());

    // start play new file
    auto_play_for_open_ = true;
    curr_file_url = current_file_.file_url;
  }

  // start play file
  if (!curr_file_url.empty()) {
    RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToFile> opening...\n";
    ret = rtc_streaming_source_->open(curr_file_url.c_str(), pos, true);
  }

  RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.SeekToFile> Exit\n";
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::GetStreamingSourceStatus(
    RteStreamingSourceStatus& out_source_status) {
  RTE_LOGGER_MEMBER(nullptr);
  int64_t progress_pos = 0;
  rtc_streaming_source_->getCurrPosition(progress_pos);
  agora::rtc::STREAMING_SRC_STATE src_state =
      rtc_streaming_source_->getCurrState();

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    out_source_status.curr_file_id = current_file_.file_id;
    out_source_status.curr_file_url = current_file_.file_url;
    out_source_status.curr_file_index = current_file_.index;
    out_source_status.curr_file_duration = current_file_.duration;
    out_source_status.curr_file_begin_time = current_file_.begin_time;
    out_source_status.progress_pos = progress_pos;
    out_source_status.source_state = src_state;
  }
  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteStreamingSource::GetCurrPosition(int64_t& pos) {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = rtc_streaming_source_->getCurrPosition(pos);
  return ConvertErrCode(ret);
}

RTE_INLINE agora::rtc::STREAMING_SRC_STATE
AgoraRteStreamingSource::GetCurrState() {
  agora::rtc::STREAMING_SRC_STATE state = rtc_streaming_source_->getCurrState();
  return state;
}

RTE_INLINE int AgoraRteStreamingSource::AppendSeiData(
    const agora::rtc::InputSeiData& in_sei_data) {
  int ret = rtc_streaming_source_->appendSeiData(in_sei_data);
  return ConvertErrCode(ret);
}

RTE_INLINE int AgoraRteStreamingSource::RegisterObserver(
    std::shared_ptr<IAgoraRteStreamingSourceObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  UnregisterObserver(observer);

  {
    std::lock_guard<std::recursive_mutex> _(streaming_source_lock_);
    observer_list_.push_back(observer);
  }
  return agora::rtc::STREAMING_SRC_ERR_NONE;
}

RTE_INLINE int AgoraRteStreamingSource::UnregisterObserver(
    std::shared_ptr<IAgoraRteStreamingSourceObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());
  std::lock_guard<std::recursive_mutex> _(streaming_source_lock_);

  AgoraRteUtils::UnregisterSharedPtrFromContainer(streaming_source_lock_,
                                                  observer_list_, observer);
  return agora::rtc::STREAMING_SRC_ERR_NONE;
}

RTE_INLINE void AgoraRteStreamingSource::GetCurrFileInfo(
    RteFileInfo& out_current_file) {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
  current_file_.CloneTo(out_current_file);
}

RTE_INLINE int AgoraRteStreamingSource::ProcessOneMediaCompleted() {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = agora::ERR_OK;
  std::string new_file_path;
  RTE_LOG_VERBOSE
      << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {  // Only play one file, Ignore this handle
      return agora::ERR_OK;
    }
  }

  // Close current playing file
  RTE_LOG_VERBOSE
      << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> closing...\n";
  ret = rtc_streaming_source_->close();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "Failed to close source, error : " << ret;
    return ret;
  }

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (!play_list_->CurrentIsLastFile()) {
      // switch to next file
      RTE_LOG_VERBOSE << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> "
                         "switch to next file...";
      ret = play_list_->MoveCurrentToNext(false);
      if (ret != agora::ERR_OK) {
        RTE_LOG_ERROR << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> "
                         "failed, ret= "
                      << ret;
        return -agora::ERR_INVALID_STATE;
      }

      // start play next file
      play_list_->GetCurrentFileInfo(current_file_);
      auto_play_for_open_ = true;
      new_file_path = current_file_.file_url;
    }
  }
  if (!new_file_path.empty()) {
    RTE_LOG_VERBOSE
        << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> opening... \n";
    rtc_streaming_source_->open(new_file_path.c_str(), 0, true);
    RTE_LOG_VERBOSE
        << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> Exit\n";
    return ConvertErrCode(ret);
  }

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    list_played_count_++;
    if (list_played_count_ >= setting_loop_count) {
      // all file loops are finished
      play_list_->SetCurrFileById(INVALID_RTE_FILE_ID);  // reset current file
      current_file_.Reset();
      RTE_LOG_ERROR << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> all "
                       "loop finished";
      return -agora::ERR_CANCELED;

    } else  // Repeat play first file
    {
      RTE_LOG_ERROR << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> "
                       "switch to first...";

      // Switch to first file
      play_list_->GetFirstFileInfo(current_file_);
      play_list_->SetCurrFileById(current_file_.file_id);

      // start play first file
      auto_play_for_open_ = true;
      new_file_path = current_file_.file_url;
    }
  }

  if (!new_file_path.empty()) {
    RTE_LOG_VERBOSE
        << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> opening 2... \n";
    rtc_streaming_source_->open(new_file_path.c_str(), 0, true);
  }

  RTE_LOG_VERBOSE
      << "<AgoraRteStreamingSource.ProcessOneMediaCompleted> Exit 2\n";
  return ret;
}

//////////////////////////////////////////////////////////////////////////////
/////////////// Override Methods of IMediaStreamingSourceObserver ////////////
///////////////////////////////////////////////////////////////////////////////
RTE_INLINE void AgoraRteStreamingSource::onStateChanged(
    agora::rtc::STREAMING_SRC_STATE state,
    agora::rtc::STREAMING_SRC_ERR err_code) {
  RTE_LOG_VERBOSE << "<StreamingSrcObserver.onStateChanged> state=" << state
                  << ", err_code=" << err_code;
  RteFileInfo current_file;
  GetCurrFileInfo(current_file);

  // switch (state) {
  //  case agora::rtc::STREAMING_SRC_STATE_CLOSED:
  //    break;

  //  case agora::rtc::STREAMING_SRC_STATE_OPENING:
  //    break;

  //  case agora::rtc::STREAMING_SRC_STATE_IDLE:
  //    break;

  //  case agora::rtc::STREAMING_SRC_STATE_PLAYING:
  //    break;

  //  case agora::rtc::STREAMING_SRC_STATE_SEEKING:
  //    break;

  //  case agora::rtc::STREAMING_SRC_STATE_EOF:
  //    break;

  //  case agora::rtc::STREAMING_SRC_STATE_ERROR:
  //    break;

  //  default:
  //    break;
  //}

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteStreamingSourceObserver>(
      streaming_source_lock_, observer_list_,
      [&current_file, state, err_code](const auto& ob) {
        ob->OnStateChanged(current_file, state, err_code);
      });
}

RTE_INLINE void AgoraRteStreamingSource::onOpenDone(
    agora::rtc::STREAMING_SRC_ERR err_code) {
  RTE_LOGGER_CALLBACK(onOpenDone, "err_code: %d", err_code);
  RTE_LOG_VERBOSE << "<StreamingSrcObserver.onOpenDone> err_code=" << err_code;

  RteFileInfo current_file;
  GetCurrFileInfo(current_file);

  int32_t rte_err_code = ConvertErrCode(err_code);
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteStreamingSourceObserver>(
      streaming_source_lock_, observer_list_,
      [&current_file, rte_err_code](const auto& handler) {
        handler->OnOpenDone(current_file, rte_err_code);
      });
}

RTE_INLINE void AgoraRteStreamingSource::onSeekDone(
    agora::rtc::STREAMING_SRC_ERR err_code) {
  RTE_LOGGER_CALLBACK(onSeekDone, "err_code: %d", err_code);
  RTE_LOG_VERBOSE << "<StreamingSrcObserver.onSeekDone> err_code=" << err_code;

  RteFileInfo current_file;
  GetCurrFileInfo(current_file);

  int32_t rte_err_code = ConvertErrCode(err_code);
  AgoraRteUtils::NotifyEventHandlers<IAgoraRteStreamingSourceObserver>(
      streaming_source_lock_, observer_list_,
      [&current_file, rte_err_code](const auto& handler) {
        handler->OnSeekDone(current_file, rte_err_code);
      });
}

RTE_INLINE void AgoraRteStreamingSource::onEofOnce(int64_t progress_ms,
                                                   int64_t repeat_count) {
  RTE_LOGGER_CALLBACK(onEofOnce,
                      "progress_ms: %" PRId64 ", repeat_count: %" PRId64 "",
                      progress_ms, repeat_count);

  RTE_LOG_VERBOSE << "<StreamingSrcObserver.onProgress> position_ms="
                  << progress_ms << ", repeat_count=" << repeat_count;
  RteFileInfo current_file;
  GetCurrFileInfo(current_file);

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteStreamingSourceObserver>(
      streaming_source_lock_, observer_list_,
      [&current_file, progress_ms, repeat_count](const auto& handler) {
        handler->OnEofOnce(current_file, progress_ms, repeat_count);
      });

  int ret = ProcessOneMediaCompleted();
  if (-agora::ERR_CANCELED == ret) {  // All file and loop are finished
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteStreamingSourceObserver>(
        streaming_source_lock_, observer_list_,
        [](const auto& ob) { ob->OnAllMediasCompleted(agora::ERR_OK); });
  }
}

RTE_INLINE void AgoraRteStreamingSource::onProgress(int64_t position_ms) {
  RteFileInfo current_file;
  GetCurrFileInfo(current_file);

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteStreamingSourceObserver>(
      streaming_source_lock_, observer_list_,
      [&current_file, position_ms](const auto& handler) {
        handler->OnProgress(current_file, position_ms);
      });
}

RTE_INLINE void AgoraRteStreamingSource::onMetaData(const void* data,
                                                    int length) {
  RteFileInfo current_file;
  GetCurrFileInfo(current_file);

  AgoraRteUtils::NotifyEventHandlers<IAgoraRteStreamingSourceObserver>(
      streaming_source_lock_, observer_list_,
      [&current_file, data, length](const auto& handler) {
        handler->OnMetaData(current_file, data, length);
      });
}

RTE_INLINE int32_t
AgoraRteStreamingSource::ConvertErrCode(int32_t src_err_code) {
  struct ErrCodeMap {
    agora::rtc::STREAMING_SRC_ERR src_err;
    agora::ERROR_CODE_TYPE common_err;
  };

  const ErrCodeMap error_code_map[] = {
      {agora::rtc::STREAMING_SRC_ERR_NONE, agora::ERR_OK},
      {agora::rtc::STREAMING_SRC_ERR_UNKNOWN, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_INVALID_PARAM,
       agora::ERR_INVALID_ARGUMENT},
      {agora::rtc::STREAMING_SRC_ERR_BAD_STATE, agora::ERR_INVALID_STATE},
      {agora::rtc::STREAMING_SRC_ERR_NO_MEM, agora::ERR_RESOURCE_LIMITED},
      {agora::rtc::STREAMING_SRC_ERR_BUFFER_OVERFLOW,
       agora::ERR_BUFFER_TOO_SMALL},
      {agora::rtc::STREAMING_SRC_ERR_BUFFER_UNDERFLOW,
       agora::ERR_BUFFER_TOO_SMALL},
      {agora::rtc::STREAMING_SRC_ERR_NOT_FOUND, agora::ERR_NOT_READY},
      {agora::rtc::STREAMING_SRC_ERR_TIMEOUT, agora::ERR_TIMEDOUT},
      {agora::rtc::STREAMING_SRC_ERR_EXPIRED, agora::ERR_NOT_READY},
      {agora::rtc::STREAMING_SRC_ERR_UNSUPPORTED, agora::ERR_NOT_SUPPORTED},
      {agora::rtc::STREAMING_SRC_ERR_NOT_EXIST, agora::ERR_NOT_READY},
      {agora::rtc::STREAMING_SRC_ERR_EXIST, agora::ERR_ALREADY_IN_USE},
      {agora::rtc::STREAMING_SRC_ERR_OPEN, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_CLOSE, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_READ, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_WRITE, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_SEEK, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_EOF, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_CODECOPEN, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_CODECCLOSE, agora::ERR_FAILED},
      {agora::rtc::STREAMING_SRC_ERR_CODECPROC, agora::ERR_FAILED}};
  int err_cnt = sizeof(error_code_map) / sizeof(error_code_map[0]);
  int32_t src_err = -1 * src_err_code;

  for (int i = 0; i < err_cnt; i++) {
    if (error_code_map[i].src_err == src_err) {
      return (-1 * error_code_map[i].common_err);
    }
  }

  return (-agora::ERR_FAILED);
}

}  // namespace rte
}  // namespace agora
