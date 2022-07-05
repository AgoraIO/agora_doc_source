//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteMediaTrack.h"
#include "IAgoraRtePlayList.h"

namespace agora {
namespace rte {

class IAgoraRteVideoTrack;

/**
 * The RTE player status structure.
 */
struct RtePlayerStatus {
  int32_t curr_file_id;          ///< current file id
  std::string curr_file_url;     ///< curent file url
  int64_t curr_file_duration;    ///< current file duration(ms)
  int32_t curr_file_index;       ///< current file index in the play list
  int64_t curr_file_begin_time;  ///< the begin timestamp(ms) in the list total
                                 ///< timeline

  MEDIA_PLAYER_STATE
  player_state;          ///< the player state machine of current file
  int64_t progress_pos;  ///< the playing progress position(ms) of current file
};

/**
 * @brief The RTE media player event.
 *
 */
enum RTE_MEDIA_PLAYER_EVENT {
  /** The player begins to seek to the new playback position.
   */
  RTE_PLAYER_EVENT_SEEK_BEGIN = 0,
  /** The seek operation completes.
   */
  RTE_PLAYER_EVENT_SEEK_COMPLETE = 1,
  /** An error occurs during the seek operation.
   */
  RTE_PLAYER_EVENT_SEEK_ERROR = 2,
  /** The player publishes a video track.
   */
  RTE_PLAYER_EVENT_VIDEO_PUBLISHED = 3,
  /** The player publishes an audio track.
   */
  RTE_PLAYER_EVENT_AUDIO_PUBLISHED = 4,
  /** The player changes the audio track for playback.
   */
  RTE_PLAYER_EVENT_AUDIO_TRACK_CHANGED = 5,
  /** player buffer low
   */
  RTE_PLAYER_EVENT_BUFFER_LOW = 6,
  /** player buffer recover
   */
  RTE_PLAYER_EVENT_BUFFER_RECOVER = 7,
  /** The video or audio is interrupted
   */
  RTE_PLAYER_EVENT_FREEZE_START = 8,
  /** Interrupt at the end of the video or audio
   */
  RTE_PLAYER_EVENT_FREEZE_STOP = 9,
  /** The playback and all loops are completed
   */
  RTE_PLAYER_EVENT_PLAYBACK_COMPLETED = 10,
};

/**
 * The IAgoraMediaPlayerObserver class.
 */
class IAgoraRteMediaPlayerObserver {
 public:
  /**
   * Occurs when player state changed.
   * When the state of the palyer changes, the SDK triggers this callback to
   * report the new player state and the reason or error for the change.
   *
   * @param current_file_info The played file information.
   * @param state The player state after change.
   * @param ec The player's error code.
   */
  virtual void OnPlayerStateChanged(const RteFileInfo& current_file_info,
                                    MEDIA_PLAYER_STATE state,
                                    MEDIA_PLAYER_ERROR ec) = 0;

  /**
   * Occurs when play position changed.
   *
   * @param current_file_info The played file information.
   * @param position The play position. (second)
   */
  virtual void OnPositionChanged(const RteFileInfo& current_file_info,
                                 int64_t position) = 0;

  /**
   * Occurs when player event happened.
   * - After calling the `seek` method, the SDK triggers the callback to report
   * the results of the seek operation.
   * - After calling the `selectAudioTrack` method, the SDK triggers the
   * callback to report that the audio track changes.
   *
   * @param current_file_info The played file information.
   * @param event The player event.
   */
  virtual void OnPlayerEvent(const RteFileInfo& current_file_info,
                             RTE_MEDIA_PLAYER_EVENT event) = 0;


  /**
   * Occurs when metadata is received.
   * The callback occurs when the player receives the media metadata and reports
   * the detailed information of the media metadata.
   *
   * @param type The metadata type.
   * @param data The metadata.
   * @param length The metadata length.
   */
  virtual void OnMetadata(const RteFileInfo& current_file_info,
                          MEDIA_PLAYER_METADATA_TYPE type, const uint8_t* data,
                          uint32_t length) = 0;

  /**
   * Occurs when the player buffer is updated.
   *
   * @param current_file_info The played file information.
   * @param play_cached_buffer The updated palyer buffer.
   */
  virtual void OnPlayerBufferUpdated(const RteFileInfo& current_file_info,
                                     int64_t play_cached_buffer) = 0;

  /**
   * Occurs when an audio frame is received.
   *
   * @param current_file_info The played file information.
   * @param audio_frame The audio PCM frame.
   */
  virtual void OnAudioFrame(const RteFileInfo& current_file_info,
                            const AudioPcmFrame& audio_frame) = 0;

  /**
   * Occurs when a video frame is received.
   *
   * @param current_file_info The played file information.
   * @param video_frame The video frame.
   */
  virtual void OnVideoFrame(const RteFileInfo& current_file_info,
                            const VideoFrame& video_frame) = 0;

 protected:
  virtual ~IAgoraRteMediaPlayerObserver() = default;
};

/**
 * The IAgoraMediaPlayer class.
 */
class IAgoraRteMediaPlayer {
 public:
  /**
   * @brief Creates a play list.
   * @param none
   * @return the new IAgoraRtePlayList object
   */
  virtual std::shared_ptr<IAgoraRtePlayList> CreatePlayList() = 0;

  /**
   * Opens a media file.
   *
   * @param url The URL of the file to be opened.
   *            For local file, it's a asbolute path
   *            For cloud file, it's a http or https URL (we support HTTP and
   * HTTPS protocol)
   * @param start_pos The start position (ms) of the file to be opened, the rang
   * is 0 ~ file_duration
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Open(const std::string& url, int64_t start_pos) = 0;

  /**
   * Opens a play list.
   *
   * @param play_list : The play list to open.
   * @param start_pos : The start position (ms) of the file to be opened, the
   * rang is 0 ~ file_duration
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Open(std::shared_ptr<IAgoraRtePlayList> play_list,
                   int64_t start_pos) = 0;

  /**
   * Play the media file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Play() = 0;

  /**
   * Pauses playing the media file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Pause() = 0;

  /**
   * Resumes playing the paused media file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Resume() = 0;

  /**
   * Stops playing the media file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Stop() = 0;

  /**
   * Seeks the playing media file to a position in current file
   *
   * @param pos The position (ms) to seek in the current file
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Seek(int64_t pos) = 0;

  /**
   * Seeks the previous file in the play list.
   *
   * @param pos The position (ms) to seek in the previous file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SeekToPrev(int64_t pos) = 0;

  /**
   * Seeks the next file in the play list.
   *
   * @param pos The position (ms) to seek in the next file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SeekToNext(int64_t pos) = 0;

  /**
   * Seeks a file by ID.
   *
   * @param file_id The ID of the file to seek.
   * @param pos The position (ms) to seek in the file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SeekToFile(int32_t file_id, int64_t pos) = 0;

  /**
   * Changes playback speed.
   *
   * @param speed The speed to be changed to ref [50-400].
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlaybackSpeed(int speed) = 0;

  /**
   * Adjusts playout volume.
   *
   * @param volume The volume to be adjusted to. valure range in [0, 100]
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int AdjustPlayoutVolume(int volume) = 0;

  /**
   * Whether to mute or unmute the local playing,
   * This function will NOT effect publishing
   *
   * @param true: Mutes the local playing
            false: Unmutes the local playing
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Mute(bool mute) = 0;

  /**
   * Selects audio track by index.
   *
   * @param index The index of the audio track.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SelectAudioTrack(int index) = 0;

  /**
   * Sets the loop count to play.
   *
   * @param loop_count The loop count to be set.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetLoopCount(int loop_count) = 0;

  /**
   * Mutes the audio.
   * @param audio_mute : mute or unmute audio
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int MuteAudio(bool audio_mute) = 0;

  /**
   * Gets whehter audio is muted
   * @param None
   * @return true or false
   */
  virtual bool IsAudioMuted() = 0;

  /**
   * Mutes the video.
   * @param video_mute : mute or unmute video
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int MuteVideo(bool video_mute) = 0;

  /**
   * Gets whether video is muted.
   * @param None
   * @return true or false
   */
  virtual bool IsVideoMuted() = 0;

  /**
   * Set view.
   *
   * @param view The view pointer to be set.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetView(View view) = 0;

  /**
   * Set render mode.
   *
   * @param mode The render mode to be set.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetRenderMode(RENDER_MODE_TYPE mode) = 0;

  /**
   * Set player option with an integer value.
   *
   * @param key The key of the option to be set.
   * @param value The value of the option to be set.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetPlayerOption(const std::string& key, int value) = 0;

  /**
   * Set player option with a string value.
   *
   * @param key The key of the option to be set.
   * @param value The value of the option to be set.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetPlayerOptionString(const std::string& key,
                                    const std::string& value) = 0;

  /**
   * Get current playing status of Media Player .
   *
   * @param [out] out_playing_status The playing status for output
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetPlayerStatus(RtePlayerStatus& out_playing_status) = 0;

  /**
   * Gets player state.
   *
   * @return
   * Current player state.
   */
  virtual MEDIA_PLAYER_STATE GetState() = 0;

  /**
   * Get duration.
   *
   * @param [out] duration The to be set duration.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetDuration(int64_t& duration) = 0;

  /**
   * Get play position.
   *
   * @param [out] pos The to be set play position.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetPlayPosition(int64_t& pos) = 0;

  /**
   * Get play volume.
   *
   * @param [out] volume The to be set play volume.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetPlayoutVolume(int& volume) = 0;

  /**
   * Gets the number of streams.
   *
   * @param [out] count : the number of streams in the media file
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetStreamCount(int64_t& count) = 0;

  /**
   * Get stream info.
   *
   * @param index The index of the stream info.
   * @param [out] info : output the stream information
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetStreamInfo(int64_t index, PlayerStreamInfo& info) = 0;

  /**
   * Gets whether the local playing of media player is muted.
   *
   * @return
   * Whether muted.
   */
  virtual bool IsMuted() = 0;

  /**
   * Gets the version of the media player.
   *
   * @return Current player version string
   */
  virtual const char* GetPlayerVersion() = 0;

  /**
   * Set stream ID.
   *
   * @param stream_id The stream ID to be set.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetStreamId(const std::string& stream_id) = 0;

  /**
   * Get stream ID.
   *
   * @param [out] stream_id The stream ID to be gotten.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetStreamId(std::string& stream_id) const = 0;

  /**
   * Registers an media player observer.
   *
   * @param observer The observer to be registered.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int RegisterMediaPlayerObserver(
      std::shared_ptr<IAgoraRteMediaPlayerObserver> observer) = 0;

  /**
   * Unregisters the media player observer.
   *
   * @param observer The observer to be unregistered.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int UnregisterMediaPlayerObserver(
      std::shared_ptr<IAgoraRteMediaPlayerObserver> observer) = 0;

  /**
   * Gets an video track.
   *
   * @param None
   * @return Pointer to video track.
   */
  virtual std::shared_ptr<IAgoraRteVideoTrack> GetVideoTrack() = 0;

  /**
   * Gets an audio track.
   *
   * @param None
   * @return Pointer to audio track.
   */
  virtual std::shared_ptr<IAgoraRteAudioTrack> GetAudioTrack() = 0;

 protected:
  virtual ~IAgoraRteMediaPlayer() = default;
};

}  // namespace rte
}  // namespace agora
