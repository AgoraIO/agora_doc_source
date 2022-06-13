//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include <memory>

#include "AgoraRefPtr.h"
#include "AgoraRteBase.h"
#include "AgoraRteUtils.h"
#include "AgoraRteWrapperAudioTrack.h"
#include "AgoraRteWrapperVideoTrack.h"
#include "IAgoraRteStreamingSource.h"

namespace agora {
namespace rte {

class AgoraRteScene;
class AgoraRtePlayList;

class AgoraRteStreamingSource
    : public std::enable_shared_from_this<AgoraRteStreamingSource>,
      public IAgoraRteStreamingSource,
      public agora::rtc::IMediaStreamingSourceObserver {
 public:
  explicit AgoraRteStreamingSource(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);
  virtual ~AgoraRteStreamingSource();

  //////////////////////////////////////////////////////////////////////////
  ///////////////// Override Methods of IAgoraRteStreamingSource ////////////
  ///////////////////////////////////////////////////////////////////////////
  std::shared_ptr<IAgoraRtePlayList> CreatePlayList() override;
  std::shared_ptr<IAgoraRteVideoTrack> GetRteVideoTrack() override;
  std::shared_ptr<IAgoraRteAudioTrack> GetRteAudioTrack() override;
  int Open(const char* url, int64_t start_pos, bool auto_play = true) override;
  int Open(std::shared_ptr<IAgoraRtePlayList> in_play_list, int64_t start_pos,
           bool auto_play = true) override;
  int Close() override;
  bool IsVideoValid() override;
  bool IsAudioValid() override;
  int GetDuration(int64_t& duration) override;
  int GetStreamCount(int64_t& count) override;
  int GetStreamInfo(int64_t index,
                    media::base::PlayerStreamInfo* out_info) override;
  int SetLoopCount(int64_t loop_count) override;
  int Play() override;
  int Pause() override;
  int Stop() override;
  int Seek(int64_t new_pos) override;
  int SeekToPrev(int64_t pos) override;
  int SeekToNext(int64_t pos) override;
  int SeekToFile(int32_t file_id, int64_t pos) override;
  int GetStreamingSourceStatus(
      RteStreamingSourceStatus& out_source_status) override;
  int GetCurrPosition(int64_t& pos) override;
  agora::rtc::STREAMING_SRC_STATE GetCurrState() override;
  int AppendSeiData(const agora::rtc::InputSeiData& in_sei_data) override;
  int RegisterObserver(
      std::shared_ptr<IAgoraRteStreamingSourceObserver> observer) override;
  int UnregisterObserver(
      std::shared_ptr<IAgoraRteStreamingSourceObserver> observer) override;

  void GetCurrFileInfo(RteFileInfo& out_current_file);
  int ProcessOneMediaCompleted();

  //////////////////////////////////////////////////////////////////////////////
  /////////////// Override Methods of IMediaStreamingSourceObserver ////////////
  ///////////////////////////////////////////////////////////////////////////////
  void onStateChanged(agora::rtc::STREAMING_SRC_STATE state,
                      agora::rtc::STREAMING_SRC_ERR err_code) override;
  void onOpenDone(agora::rtc::STREAMING_SRC_ERR err_code) override;
  void onSeekDone(agora::rtc::STREAMING_SRC_ERR err_code) override;
  void onEofOnce(int64_t progress_ms, int64_t repeat_count) override;
  void onProgress(int64_t position_ms) override;
  void onMetaData(const void* data, int length) override;

 protected:
  static int32_t ConvertErrCode(int32_t src_err_code);

 protected:
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;
  agora_refptr<rtc::IMediaNodeFactory> rtc_node_factory_;
  agora_refptr<rtc::IMediaStreamingSource> rtc_streaming_source_;
  std::shared_ptr<AgoraRteWrapperVideoTrack> rte_video_track_;
  std::shared_ptr<AgoraRteWrapperAudioTrack> rte_audio_track_;

  std::recursive_mutex streaming_source_lock_;  ///< locker for streaming source
  std::vector<std::weak_ptr<IAgoraRteStreamingSourceObserver>>
      observer_list_;  // GUARDED_BY(rte_streaming_src_lock_);

  std::recursive_mutex file_manager_lock_;  ///< locker for file manager
  std::shared_ptr<AgoraRtePlayList> play_list_ = nullptr;  ///< play list
  RteFileInfo current_file_;  ///< current file information
  int32_t first_file_id_ =
      INVALID_RTE_FILE_ID;           ///< The file id of start file in list
  int64_t setting_loop_count = 1;    ///< default play count is only once
  bool setting_mute_ = false;        ///< default play is unmute
  int64_t list_played_count_ = 0;    ///< the played count of list
  bool auto_play_for_open_ = false;  ///< whether open for play list
};

}  // namespace rte
}  // namespace agora
