//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#include "AgoraRteMediaPlayer.h"

#include "AgoraRtePlayList.h"
#include "AgoraRteScene.h"
#include "AgoraRteUtils.h"
#include "AgoraRteWrapperAudioTrack.h"
#include "AgoraRteWrapperVideoTrack.h"

namespace agora {
namespace rte {

RTE_INLINE AgoraRteMediaPlayer::AgoraRteMediaPlayer(
    const std::shared_ptr<agora::base::IAgoraService>& rtc_service)
    : rtc_service_(rtc_service) {
  auto factory = createAgoraMediaComponentFactory();
  auto media_player = factory->createMediaPlayer();

  media_player_ =
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::IMediaPlayer>(
          media_player);
  media_player_->initialize(rtc_service_.get());

  auto player = media_player_.get();
  auto video_track =
      static_cast<rtc::IMediaPlayerEx*>(player)->getLocalVideoTrack();
  video_track_ = std::make_shared<AgoraRteWrapperVideoTrack>(
      rtc_service_,
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalVideoTrack>(
          video_track));

  auto audio_track =
      static_cast<rtc::IMediaPlayerEx*>(player)->getLocalAudioTrack();

  audio_track_ = std::make_shared<AgoraRteWrapperAudioTrack>(
      rtc_service_,
      AgoraRteUtils::AgoraRefObjectToSharedObject<rtc::ILocalAudioTrack>(
          audio_track));
}

RTE_INLINE AgoraRteMediaPlayer::~AgoraRteMediaPlayer() {
  // Release track first before we release others
  //
  audio_track_ = nullptr;
  video_track_ = nullptr;

  if (!media_player_obs_.empty()) {
    media_player_->unregisterAudioFrameObserver(
        internal_media_play_audio_ob_.get());
    media_player_->unregisterVideoFrameObserver(
        internal_media_play_video_ob_.get());
    media_player_->unregisterPlayerSourceObserver(
        internal_media_play_src_ob_.get());
  }

  if (play_list_ != nullptr) {
    play_list_->SetCurrFileById(INVALID_RTE_FILE_ID);
    play_list_ = nullptr;
  }
}

RTE_INLINE std::shared_ptr<IAgoraRtePlayList>
AgoraRteMediaPlayer::CreatePlayList() {
  RTE_LOGGER_MEMBER(nullptr);
  return std::make_shared<AgoraRtePlayList>(rtc_service_);
}

RTE_INLINE int AgoraRteMediaPlayer::Open(const std::string& url,
                                         int64_t start_pos) {
  {
    RTE_LOGGER_MEMBER("url: %s, start_pos: %" PRId64 "", url.c_str(),
                      start_pos);
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {  // previous list have not closed
      return -agora::ERR_INVALID_STATE;
    }
    current_file_.Reset();
    current_file_.file_id = 1;
    current_file_.file_url = url;
    current_file_.index = 0;
    first_file_id_ = current_file_.file_id;
    auto_play_for_open_ = false;
  }
  return media_player_->open(url.c_str(), start_pos);
}

RTE_INLINE int AgoraRteMediaPlayer::Open(
    std::shared_ptr<IAgoraRtePlayList> in_play_list, int64_t start_pos) {
  RTE_LOGGER_MEMBER("in_play_list: %p, start_pos: %" PRId64 "",
                    in_play_list.get(), start_pos);
  std::string file_path;
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {  // previous list have not closed
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

    auto_play_for_open_ = false;
    file_path = current_file_.file_url;
  }

  return media_player_->open(file_path.c_str(), start_pos);
}

RTE_INLINE int AgoraRteMediaPlayer::Play() {
  RTE_LOGGER_MEMBER(nullptr);
  return media_player_->play();
}

RTE_INLINE int AgoraRteMediaPlayer::Pause() {
  RTE_LOGGER_MEMBER(nullptr);
  return media_player_->pause();
}

RTE_INLINE int AgoraRteMediaPlayer::Resume() {
  RTE_LOGGER_MEMBER(nullptr);
  return media_player_->resume();
}

RTE_INLINE int AgoraRteMediaPlayer::Stop() {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = media_player_->stop();

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {
      play_list_->SetCurrFileById(INVALID_RTE_FILE_ID);
      play_list_ = nullptr;
    }
  }

  return ret;
}

RTE_INLINE int AgoraRteMediaPlayer::Seek(int64_t pos) {
  {
    RTE_LOGGER_MEMBER("pos: %" PRId64 "", pos);
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ != nullptr) {
      RteFileInfo curr_file_info;
      play_list_->GetCurrentFileInfo(curr_file_info);
      if ((curr_file_info.duration > 0) && (pos >= curr_file_info.duration)) {
        RTE_LOG_ERROR << "<AgoraRteMediaPlayer.Seek> pos is more than duration";
        return -agora::ERR_INVALID_ARGUMENT;
      }
    }
  }

  return media_player_->seek(pos);
}

RTE_INLINE int AgoraRteMediaPlayer::SeekToPrev(int64_t pos) {
  RTE_LOGGER_MEMBER("pos: %" PRId64 "", pos);
  std::string curr_file_url;
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToPrev> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {  // It don't support for only one file
      return -agora::ERR_INVALID_STATE;
    }
    if (play_list_->CurrentIsFirstFile()) {
      RTE_LOG_ERROR
          << "<AgoraRteMediaPlayer.SeekToPrev> current already is first file";
      return -agora::ERR_INVALID_STATE;
    }
    RteFileInfoSharePtr prev_file_ptr = play_list_->FindPrevFile(false);
    assert(prev_file_ptr != nullptr);
    if ((prev_file_ptr->duration > 0) && (pos >= prev_file_ptr->duration)) {
      RTE_LOG_ERROR
          << "<AgoraRteMediaPlayer.SeekToPrev> pos is more than duration";
      return -agora::ERR_INVALID_ARGUMENT;
    }
  }

  // stop current file
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToPrev> stopping...\n";
  int ret = media_player_->stop();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "Failed to stop media player, error : " << ret;
    return ret;
  }

  {  // switch to previous file
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToPrev> moving to prev...\n";
    ret = play_list_->MoveCurrentToPrev(false);
    if (ret != agora::ERR_OK) {
      RTE_LOG_ERROR << "Failed to move to previous file, error : " << ret;
      return ret;
    }

    current_file_.Reset();
    play_list_->GetCurrentFileInfo(current_file_);
    assert(current_file_.IsValid());
    auto_play_for_open_ = true;
    curr_file_url = current_file_.file_url;
  }

  // start play previous file
  if (!curr_file_url.empty()) {
    RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToPrev> opening...\n";
    ret = media_player_->open(curr_file_url.c_str(), pos);
  }

  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToPrev> Exit\n";
  return ret;
}

RTE_INLINE int AgoraRteMediaPlayer::SeekToNext(int64_t pos) {
  RTE_LOGGER_MEMBER("pos: %" PRId64 "", pos);
  std::string curr_file_url;
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToNext> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {
      return -agora::ERR_INVALID_STATE;
    }
    if (play_list_->CurrentIsLastFile()) {
      RTE_LOG_ERROR
          << "<AgoraRteMediaPlayer.SeekToNext> current already is last file";
      return -agora::ERR_INVALID_STATE;
    }
    RteFileInfoSharePtr next_file_ptr = play_list_->FindNextFile(false);
    assert(next_file_ptr != nullptr);
    if ((next_file_ptr->duration > 0) && (pos >= next_file_ptr->duration)) {
      RTE_LOG_ERROR
          << "<AgoraRteMediaPlayer.SeekToNext> pos is more than duration";
      return -agora::ERR_INVALID_ARGUMENT;
    }
  }

  // stop current file
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToNext> stopping...\n";
  int ret = media_player_->stop();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "Failed to stop media player, error : " << ret;
    return ret;
  }

  {  // switch to next file
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToNext> moving to next...\n";
    ret = play_list_->MoveCurrentToNext(false);
    if (ret != agora::ERR_OK) {
      RTE_LOG_ERROR << "Failed to move to next file, error : " << ret;
      return ret;
    }
    current_file_.Reset();
    play_list_->GetCurrentFileInfo(current_file_);
    assert(current_file_.IsValid());
    auto_play_for_open_ = true;
    curr_file_url = current_file_.file_url;
  }

  // start play next file
  if (!curr_file_url.empty()) {
    RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToNext> opening...\n";
    ret = media_player_->open(curr_file_url.c_str(), pos);
  }

  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToNext> Exit\n";
  return ret;
}

RTE_INLINE int AgoraRteMediaPlayer::SeekToFile(int32_t file_id, int64_t pos) {
  RTE_LOGGER_MEMBER("file_id: %zu, pos: %" PRId64 "", file_id, pos);
  std::string curr_file_url;
  int ret = ERR_OK;
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToFile> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {
      return -agora::ERR_INVALID_STATE;
    }
    if (file_id == current_file_.file_id) {
      // Seek in current file
      RTE_LOG_ERROR << "<AgoraRteMediaPlayer.SeekToFile> seeking...\n";
      return media_player_->seek(pos);
    }
  }

  // stop current file
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToFile> sopping...\n";
  media_player_->stop();

  {  // switch to new file
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToFile> swithing to file...\n";
    ret = play_list_->SetCurrFileById(file_id);
    if (ret != agora::ERR_OK) {
      RTE_LOG_ERROR << "<AgoraRteMediaPlayer.SeekToFile> failed, file_id= "
                    << file_id << ", pos= " << pos;
      return -agora::ERR_INVALID_ARGUMENT;
    }
    current_file_.Reset();
    play_list_->GetCurrentFileInfo(current_file_);
    assert(current_file_.IsValid());
    auto_play_for_open_ = true;
    curr_file_url = current_file_.file_url;
  }

  // start play new file
  if (!curr_file_url.empty()) {
    RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToFile> opening...\n";
    ret = media_player_->open(curr_file_url.c_str(), pos);
  }

  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.SeekToFile> Exit\n";
  return ret;
}

RTE_INLINE int AgoraRteMediaPlayer::setPlaybackSpeed(
    int speed) {
  RTE_LOGGER_MEMBER("speed: %d", speed);
  return media_player_->setPlaybackSpeed(speed);
}

RTE_INLINE int AgoraRteMediaPlayer::AdjustPlayoutVolume(int volume) {
  RTE_LOGGER_MEMBER("volume: %d", volume);
  return media_player_->adjustPlayoutVolume(volume);
}

RTE_INLINE int AgoraRteMediaPlayer::Mute(bool mute) {
  {
    RTE_LOGGER_MEMBER("mute: %d", mute);
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    setting_mute_ = mute;
  }

  media_player_->mute(mute);  // don't care the result
  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteMediaPlayer::SelectAudioTrack(int index) {
  RTE_LOGGER_MEMBER("index: %d", index);
  return media_player_->selectAudioTrack(index);
}

RTE_INLINE int AgoraRteMediaPlayer::SetLoopCount(int loop_count) {
  {
    RTE_LOGGER_MEMBER("loop_count: %d", loop_count);
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    setting_loop_count_ = loop_count;
    list_played_count_ = 0;
  }

  if (play_list_ == nullptr) {  // Open only one file
    return media_player_->setLoopCount(loop_count);
  }

  return agora::ERR_OK;
}

RTE_INLINE int AgoraRteMediaPlayer::MuteAudio(bool audio_mute) {
  RTE_LOGGER_MEMBER("audio_mute: %d", audio_mute);
  return media_player_->muteAudio(audio_mute);
}

RTE_INLINE bool AgoraRteMediaPlayer::IsAudioMuted() {
  RTE_LOGGER_MEMBER(nullptr);
  bool audio_muted = media_player_->isAudioMuted();
  return audio_muted;
}

RTE_INLINE int AgoraRteMediaPlayer::MuteVideo(bool video_mute) {
  RTE_LOGGER_MEMBER("video_mute: %d", video_mute);
  return media_player_->muteVideo(video_mute);
}

RTE_INLINE bool AgoraRteMediaPlayer::IsVideoMuted() {
  RTE_LOGGER_MEMBER(nullptr);
  bool video_muted = media_player_->isVideoMuted();
  return video_muted;
}

RTE_INLINE int AgoraRteMediaPlayer::SetView(View view) {
  RTE_LOGGER_MEMBER("view: %p", view);
  return media_player_->setView(view);
}

RTE_INLINE int AgoraRteMediaPlayer::SetRenderMode(RENDER_MODE_TYPE mode) {
  RTE_LOGGER_MEMBER("mode: %d", mode);
  return media_player_->setRenderMode(mode);
}

RTE_INLINE int AgoraRteMediaPlayer::SetPlayerOption(const std::string& key,
                                                    int value) {
  RTE_LOGGER_MEMBER("key: %s, value: %d", key.c_str(), value);
  return media_player_->setPlayerOption(key.c_str(), value);
}

RTE_INLINE int AgoraRteMediaPlayer::SetPlayerOptionString(
    const std::string& key, const std::string& value) {
  RTE_LOGGER_MEMBER("key: %s, value: %d", key.c_str(), value.c_str());
  return media_player_->setPlayerOption(key.c_str(), value.c_str());
}

RTE_INLINE int AgoraRteMediaPlayer::GetPlayerStatus(
    RtePlayerStatus& out_playing_status) {
  RTE_LOGGER_MEMBER(nullptr);

  int64_t progress_pos = 0;
  media_player_->getPlayPosition(progress_pos);
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    out_playing_status.curr_file_id = current_file_.file_id;
    out_playing_status.curr_file_url = current_file_.file_url;
    out_playing_status.curr_file_index = current_file_.index;
    out_playing_status.curr_file_duration = current_file_.duration;
    out_playing_status.curr_file_begin_time = current_file_.begin_time;
    out_playing_status.player_state = media_player_->getState();
    out_playing_status.progress_pos = progress_pos;
  }
  return agora::ERR_OK;
}

RTE_INLINE agora::rte::MEDIA_PLAYER_STATE AgoraRteMediaPlayer::GetState() {
  return media_player_->getState();
}

RTE_INLINE int AgoraRteMediaPlayer::GetDuration(int64_t& duration) {
  return media_player_->getDuration(duration);
}

RTE_INLINE int AgoraRteMediaPlayer::GetPlayPosition(int64_t& pos) {
  return media_player_->getPlayPosition(pos);
}

RTE_INLINE int AgoraRteMediaPlayer::GetPlayoutVolume(int& volume) {
  return media_player_->getPlayoutVolume(volume);
}

RTE_INLINE int AgoraRteMediaPlayer::GetStreamCount(int64_t& count) {
  return media_player_->getStreamCount(count);
}

RTE_INLINE int AgoraRteMediaPlayer::GetStreamInfo(int64_t index,
                                                  PlayerStreamInfo& info) {
  return media_player_->getStreamInfo(index, &info);
}

RTE_INLINE bool AgoraRteMediaPlayer::IsMuted() {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
  return setting_mute_;
}

RTE_INLINE const char* AgoraRteMediaPlayer::GetPlayerVersion() {
  RTE_LOGGER_MEMBER(nullptr);
  return media_player_->getPlayerSdkVersion();
}

RTE_INLINE int AgoraRteMediaPlayer::SetStreamId(const std::string& stream_id) {
  RTE_LOGGER_MEMBER("stream_id: %s", stream_id.c_str());
  stream_id_ = stream_id;
  return ERR_OK;
}

RTE_INLINE int AgoraRteMediaPlayer::GetStreamId(std::string& stream_id) const {
  RTE_LOGGER_MEMBER(nullptr);
  stream_id = stream_id_;
  return ERR_OK;
}

RTE_INLINE int AgoraRteMediaPlayer::RegisterMediaPlayerObserver(
    std::shared_ptr<IAgoraRteMediaPlayerObserver> observer) {
  {
    RTE_LOGGER_MEMBER("observer: %p", observer.get());
    std::lock_guard<std::recursive_mutex> _(media_player_lock_);
    if (!internal_media_play_src_ob_) {
      internal_media_play_src_ob_ =
          RtcCallbackWrapper<AgoraRteMediaPlayerObserver>::Create(
              shared_from_this());
      internal_media_play_audio_ob_ =
          RtcCallbackWrapper<AgoraRteMediaPlayerAudioObserver>::Create(
              shared_from_this());
      internal_media_play_video_ob_ =
          RtcCallbackWrapper<AgoraRteMediaPlayerVideoObserver>::Create(
              shared_from_this());
    }
  }

  UnregisterMediaPlayerObserver(observer);

  {
    std::lock_guard<std::recursive_mutex> _(media_player_lock_);

    if (media_player_obs_.empty()) {
      media_player_->registerAudioFrameObserver(
          internal_media_play_audio_ob_.get());
      media_player_->registerVideoFrameObserver(
          internal_media_play_video_ob_.get());
      media_player_->registerPlayerSourceObserver(
          internal_media_play_src_ob_.get());
    }

    media_player_obs_.push_back(observer);
  }

  return ERR_OK;
}

RTE_INLINE int AgoraRteMediaPlayer::UnregisterMediaPlayerObserver(
    std::shared_ptr<IAgoraRteMediaPlayerObserver> observer) {
  RTE_LOGGER_MEMBER("observer: %p", observer.get());

  AgoraRteUtils::UnregisterSharedPtrFromContainer(media_player_lock_,
                                                  media_player_obs_, observer);

  {
    std::lock_guard<std::recursive_mutex> _(media_player_lock_);

    if (media_player_obs_.empty()) {
      media_player_->unregisterAudioFrameObserver(
          internal_media_play_audio_ob_.get());
      media_player_->unregisterVideoFrameObserver(
          internal_media_play_video_ob_.get());
      media_player_->unregisterPlayerSourceObserver(
          internal_media_play_src_ob_.get());
    }
  }
  return ERR_OK;
}

RTE_INLINE std::shared_ptr<IAgoraRteAudioTrack>
AgoraRteMediaPlayer::GetAudioTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  return audio_track_;
}

RTE_INLINE std::shared_ptr<IAgoraRteVideoTrack>
AgoraRteMediaPlayer::GetVideoTrack() {
  RTE_LOGGER_MEMBER(nullptr);
  return video_track_;
}

RTE_INLINE void AgoraRteMediaPlayer::GetCurrFileInfo(
    RteFileInfo& out_current_file) {
  RTE_LOGGER_MEMBER(nullptr);
  std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
  current_file_.CloneTo(out_current_file);
}

RTE_INLINE int AgoraRteMediaPlayer::ProcessOpened() {
  RTE_LOGGER_MEMBER(nullptr);
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.ProcessOpened> \n";
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {  // Only play one file
      return agora::ERR_OK;
    }
    if ((!auto_play_for_open_) && (play_list_->CurrentIsFirstFile())) {
      return agora::ERR_OK;
    }
  }

  media_player_->mute(setting_mute_);

  // Auto play media file
  int ret = media_player_->play();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "<AgoraRteMediaPlayer.ProcessOpened> fail to play()="
                  << ret;
  }
  return ret;
}

RTE_INLINE int AgoraRteMediaPlayer::ProcessOneMediaCompleted() {
  RTE_LOGGER_MEMBER(nullptr);
  int ret = ERR_OK;
  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> Enter\n";

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (play_list_ == nullptr) {  // Only play one file
      return agora::ERR_OK;
    }
  }

  // Stop current playing file
  RTE_LOG_VERBOSE
      << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> closing... \n";
  ret = media_player_->stop();
  if (ret != agora::ERR_OK) {
    RTE_LOG_ERROR << "Failed to stop media player, error : " << ret;
    return ret;
  }

  RTE_LOG_VERBOSE
      << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> nexting... \n";
  std::string new_file_path;
  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    if (!play_list_->CurrentIsLastFile()) {
      // switch to next file
      RTE_LOG_VERBOSE
          << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> switch to "
             "next file...";
      ret = play_list_->MoveCurrentToNext(false);
      if (ret != agora::ERR_OK) {
        RTE_LOG_ERROR
            << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> failed, ret= "
            << ret;
        return -agora::ERR_INVALID_STATE;
      }

      // set next file
      play_list_->GetCurrentFileInfo(current_file_);
      auto_play_for_open_ = true;
      new_file_path = current_file_.file_url;
    }
  }
  if (!new_file_path.empty()) {
    RTE_LOG_VERBOSE
        << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> opening... \n";
    ret = media_player_->open(new_file_path.c_str(), 0);
    RTE_LOG_ERROR << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> Exit\n";
    return ret;
  }

  {
    std::lock_guard<std::recursive_mutex> _(file_manager_lock_);
    list_played_count_++;
    if (list_played_count_ >=
        setting_loop_count_)  // all file loops are finished finished
    {
      play_list_->SetCurrFileById(INVALID_RTE_FILE_ID);  // reset current file
      current_file_.Reset();
      RTE_LOG_VERBOSE
          << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> all loop finished";
      return -agora::ERR_CANCELED;
    } else  // Repeat play first file
    {
      RTE_LOG_VERBOSE
          << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> switch to "
             "first file...";

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
        << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> opening 2... \n";
    ret = media_player_->open(new_file_path.c_str(), 0);
  }

  RTE_LOG_VERBOSE << "<AgoraRteMediaPlayer.ProcessOneMediaCompleted> Exit 2\n";
  return ret;
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onPlayerSourceStateChanged(
    media::base::MEDIA_PLAYER_STATE state, media::base::MEDIA_PLAYER_ERROR ec) {
  RTE_LOGGER_CALLBACK(onPlayerSourceStateChanged, "state: %d, ec: %d", state,
                      ec);
  auto palyer = media_player_.lock();
  if (palyer) {
    RteFileInfo current_file;
    palyer->GetCurrFileInfo(current_file);
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
        palyer->media_player_lock_, palyer->media_player_obs_,
        [&current_file, state, ec](const auto& ob) {
          ob->OnPlayerStateChanged(current_file, state, ec);
        });

    if (media::base::PLAYER_STATE_OPEN_COMPLETED == state) {
      palyer->ProcessOpened();
    } else if (media::base::PLAYER_STATE_PLAYBACK_COMPLETED == state ||
               media::base::PLAYER_STATE_PLAYBACK_ALL_LOOPS_COMPLETED ==
                   state) {
      int ret = palyer->ProcessOneMediaCompleted();
      if (-agora::ERR_CANCELED == ret) {  // All file and loop are finished
        RteFileInfo current_file;
        palyer->GetCurrFileInfo(current_file);
        AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
            palyer->media_player_lock_, palyer->media_player_obs_,
            [&current_file, ec](const auto& ob) {
              ob->OnPlayerEvent(current_file,
                                RTE_PLAYER_EVENT_PLAYBACK_COMPLETED);
            });
      }
    }
  }
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onPositionChanged(
    int64_t position) {
  auto palyer = media_player_.lock();
  if (palyer) {
    RteFileInfo current_file;
    palyer->GetCurrFileInfo(current_file);
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
        palyer->media_player_lock_, palyer->media_player_obs_,
        [&current_file, position](const auto& ob) {
          ob->OnPositionChanged(current_file, position);
        });
  }
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onPlayerEvent(
    media::base::MEDIA_PLAYER_EVENT event, int64_t elapsedTime, const char* message) {
  auto palyer = media_player_.lock();
  if (palyer) {
    RteFileInfo current_file;
    palyer->GetCurrFileInfo(current_file);
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
        palyer->media_player_lock_, palyer->media_player_obs_,
        [&current_file, event](const auto& ob) {
          agora::rte::RTE_MEDIA_PLAYER_EVENT rte_event =
              static_cast<agora::rte::RTE_MEDIA_PLAYER_EVENT>(event);
          ob->OnPlayerEvent(current_file, rte_event);
        });
  }
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onMetaData(const void* data,
                                                        int length) {
  auto palyer = media_player_.lock();
  if (palyer) {
    RteFileInfo current_file;
    palyer->GetCurrFileInfo(current_file);
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
        palyer->media_player_lock_, palyer->media_player_obs_,
        [&current_file, data, length](const auto& ob) {
          ob->OnMetadata(current_file,
                         MEDIA_PLAYER_METADATA_TYPE::PLAYER_METADATA_TYPE_SEI,
                         static_cast<const uint8_t*>(data), length);
        });
  }
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onCompleted() {
  // IAgoraRteMediaPlayerObserver doesn't need this callback
  //
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onPreloadEvent(const char* src, media::base::PLAYER_PRELOAD_EVENT event) {
  // TODO
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onAgoraCDNTokenWillExpire() {
  // TODO
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onPlayerSrcInfoChanged(const media::base::SrcInfo& from, const media::base::SrcInfo& to) {
  // TODO
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onPlayerInfoUpdated(const media::base::PlayerUpdatedInfo& info) {
  // TODO
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onAudioVolumeIndication(int volume) {
}

RTE_INLINE void AgoraRteMediaPlayerObserver::onPlayBufferUpdated(
    int64_t play_cached_buffer) {
  auto palyer = media_player_.lock();
  if (palyer) {
    RteFileInfo current_file;
    palyer->GetCurrFileInfo(current_file);
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
        palyer->media_player_lock_, palyer->media_player_obs_,
        [&current_file, play_cached_buffer](const auto& ob) {
          ob->OnPlayerBufferUpdated(current_file, play_cached_buffer);
        });
  }
}

RTE_INLINE void AgoraRteMediaPlayerAudioObserver::onFrame(
    AudioPcmFrame* audio_frame) {
  // AGO_LOG("<AudioObserver.onFrame> timestamp=%d\n",
  //        static_cast<int>(audio_frame->capture_timestamp));

  auto palyer = media_player_.lock();
  if (palyer) {
    RteFileInfo current_file;
    palyer->GetCurrFileInfo(current_file);
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
        palyer->media_player_lock_, palyer->media_player_obs_,
        [&current_file, &audio_frame](const auto& ob) {
          ob->OnAudioFrame(current_file, *audio_frame);
        });
  }
}

RTE_INLINE void AgoraRteMediaPlayerVideoObserver::onFrame(
    const VideoFrame* video_frame) {
  auto palyer = media_player_.lock();
  if (palyer) {
    RteFileInfo current_file;
    palyer->GetCurrFileInfo(current_file);
    AgoraRteUtils::NotifyEventHandlers<IAgoraRteMediaPlayerObserver>(
        palyer->media_player_lock_, palyer->media_player_obs_,
        [&current_file, &video_frame](const auto& ob) {
          ob->OnVideoFrame(current_file, *video_frame);
        });
  }
}

}  // namespace rte
}  // namespace agora
