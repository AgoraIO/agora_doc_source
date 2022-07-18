//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "AgoraRteUtils.h"
#include "IAgoraMediaPlayer.h"
#include "IAgoraMediaPlayerSource.h"
#include "IAgoraRteMediaPlayer.h"

namespace agora {
namespace rte {

class AgoraRteMediaPlayer;
class AgoraRteScene;
class AgoraRtePlayList;

class AgoraRteMediaPlayerObserver : public rtc::IMediaPlayerSourceObserver {
 public:
  explicit AgoraRteMediaPlayerObserver(
      const std::shared_ptr<AgoraRteMediaPlayer>& media_player)
      : media_player_(media_player) {}

  void onPlayerSourceStateChanged(media::base::MEDIA_PLAYER_STATE state,
                                  media::base::MEDIA_PLAYER_ERROR ec) override;

  void onPositionChanged(int64_t position) override;

  void onPlayerEvent(media::base::MEDIA_PLAYER_EVENT event, int64_t elapsedTime, const char* message) override;

  void onMetaData(const void* data, int length) override;

  void onCompleted() override;

  void onPlayBufferUpdated(int64_t play_cached_buffer) override;

  void onPreloadEvent(const char* src, media::base::PLAYER_PRELOAD_EVENT event) override;

  void onAgoraCDNTokenWillExpire() override;

  void onPlayerSrcInfoChanged(const media::base::SrcInfo& from, const media::base::SrcInfo& to) override;

  void onPlayerInfoUpdated(const media::base::PlayerUpdatedInfo& info) override;
  
  void onAudioVolumeIndication(int volume) override;
 private:
  std::weak_ptr<AgoraRteMediaPlayer> media_player_;
};

class AgoraRteMediaPlayerAudioObserver
    : public agora::media::base::IAudioFrameObserver {
 public:
  explicit AgoraRteMediaPlayerAudioObserver(
      const std::shared_ptr<AgoraRteMediaPlayer>& media_player)
      : media_player_(media_player) {}

  void onFrame(AudioPcmFrame* frame) override;

 private:
  std::weak_ptr<AgoraRteMediaPlayer> media_player_;
};

class AgoraRteMediaPlayerVideoObserver
    : public agora::media::base::IVideoFrameObserver {
 public:
  explicit AgoraRteMediaPlayerVideoObserver(
      const std::shared_ptr<AgoraRteMediaPlayer>& media_player)
      : media_player_(media_player) {}

  void onFrame(const VideoFrame* frame) override;

 private:
  std::weak_ptr<AgoraRteMediaPlayer> media_player_;
};

class AgoraRteMediaPlayer final
    : public std::enable_shared_from_this<AgoraRteMediaPlayer>,
      public IAgoraRteMediaPlayer {
  friend class AgoraRteMediaPlayerObserver;
  friend class AgoraRteMediaPlayerAudioObserver;
  friend class AgoraRteMediaPlayerVideoObserver;

 public:
  explicit AgoraRteMediaPlayer(
      const std::shared_ptr<agora::base::IAgoraService>& rtc_service);

  ~AgoraRteMediaPlayer();

  std::shared_ptr<IAgoraRtePlayList> CreatePlayList() override;

  int Open(const std::string& url, int64_t start_pos) override;

  int Open(std::shared_ptr<IAgoraRtePlayList> in_play_list,
           int64_t start_pos) override;

  int Play() override;

  int Pause() override;

  int Resume() override;

  int Stop() override;

  int Seek(int64_t pos) override;

  int SeekToPrev(int64_t pos) override;

  int SeekToNext(int64_t pos) override;

  int SeekToFile(int32_t file_id, int64_t pos) override;

  int setPlaybackSpeed(int speed) override;

  int AdjustPlayoutVolume(int volume) override;

  int Mute(bool mute) override;

  int SelectAudioTrack(int index) override;

  int SetLoopCount(int loop_count) override;

  int MuteAudio(bool audio_mute) override;

  bool IsAudioMuted() override;

  int MuteVideo(bool video_mute) override;

  bool IsVideoMuted() override;

  int SetView(View view) override;

  int SetRenderMode(RENDER_MODE_TYPE mode) override;

  int SetPlayerOption(const std::string& key, int value) override;

  int SetPlayerOptionString(const std::string& key,
                            const std::string& value) override;

  int GetPlayerStatus(RtePlayerStatus& out_playing_status) override;

  MEDIA_PLAYER_STATE GetState() override;

  int GetDuration(int64_t& duration) override;

  int GetPlayPosition(int64_t& pos) override;

  int GetPlayoutVolume(int& volume) override;

  int GetStreamCount(int64_t& count) override;

  int GetStreamInfo(int64_t index, PlayerStreamInfo& info) override;

  bool IsMuted() override;

  const char* GetPlayerVersion() override;

  int SetStreamId(const std::string& stream_id) override;

  int GetStreamId(std::string& stream_id) const override;

  int RegisterMediaPlayerObserver(
      std::shared_ptr<IAgoraRteMediaPlayerObserver> observer) override;

  int UnregisterMediaPlayerObserver(
      std::shared_ptr<IAgoraRteMediaPlayerObserver> observer) override;

  std::shared_ptr<IAgoraRteAudioTrack> GetAudioTrack() override;

  std::shared_ptr<IAgoraRteVideoTrack> GetVideoTrack() override;

  void GetCurrFileInfo(RteFileInfo& out_current_file);
  int ProcessOpened();
  int ProcessOneMediaCompleted();

 protected:
  std::shared_ptr<agora::base::IAgoraService> rtc_service_;

  std::shared_ptr<IAgoraRteAudioTrack> audio_track_;
  std::shared_ptr<IAgoraRteVideoTrack> video_track_;

  std::string stream_id_;
  std::shared_ptr<rtc::IMediaPlayer> media_player_;
  std::vector<std::weak_ptr<IAgoraRteMediaPlayerObserver>> media_player_obs_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteMediaPlayerObserver>>
      internal_media_play_src_ob_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteMediaPlayerAudioObserver>>
      internal_media_play_audio_ob_;
  std::shared_ptr<RtcCallbackWrapper<AgoraRteMediaPlayerVideoObserver>>
      internal_media_play_video_ob_;
  std::recursive_mutex media_player_lock_;

  std::recursive_mutex file_manager_lock_;  ///< locker for file manager
  std::shared_ptr<AgoraRtePlayList> play_list_ = nullptr;  ///< play list
  RteFileInfo current_file_;  ///< current file information
  int32_t first_file_id_ =
      INVALID_RTE_FILE_ID;           ///< The file id of start file in list
  int64_t setting_loop_count_ = 1;   ///< default play count is only once
  bool setting_mute_ = false;        ///< default play is unmute
  int64_t list_played_count_ = 0;    ///< the played count of list
  bool auto_play_for_open_ = false;  ///< whether open for play list
};
}  // namespace rte
}  // namespace agora
