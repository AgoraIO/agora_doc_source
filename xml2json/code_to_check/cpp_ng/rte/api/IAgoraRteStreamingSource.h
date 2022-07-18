//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once

#include "AgoraRteBase.h"
#include "IAgoraMediaStreamingSource.h"
#include "IAgoraRtePlayList.h"

namespace agora {
namespace rte {

class IAgoraRtePlayList;
class IAgoraRteVideoTrack;
class IAgoraRteAudioTrack;
class IAgoraRteStreamingSourceObserver;

/**
 * The RTE streaming source status structure.
 */
struct RteStreamingSourceStatus {
  int32_t curr_file_id;        ///< current file id
  std::string curr_file_url;   ///< curent file url
                               ///<   for local file is absolute path;
                               ///<   for online file is URL which support HTTP
                               ///<   and HTTPS protocol
  int64_t curr_file_duration;  ///< current file duration (ms)
  int32_t curr_file_index;     ///< current file index in the play list
  int64_t curr_file_begin_time;  ///< the begin timestamp (ms) of current file
                                 ///< in the list timeline

  agora::rtc::STREAMING_SRC_STATE
      source_state;      ///< the streaming source state machine of current file
  int64_t progress_pos;  ///< the playing progress position (ms) of current file
};

/**
 * The IAgoraStreamingSource class.
 */
class IAgoraRteStreamingSource {
 public:
  virtual ~IAgoraRteStreamingSource() = default;

  /**
   * @brief Create the play list
   * @param none
   * @return video track
   */
  virtual std::shared_ptr<IAgoraRtePlayList> CreatePlayList() = 0;

  /**
   * @brief Retrieve the RTE video track
   * @param none
   * @return video track
   */
  virtual std::shared_ptr<IAgoraRteVideoTrack> GetRteVideoTrack() = 0;

  /**
   * @brief Retrieve the RTE audio track
   * @param none
   * @return audio track
   */
  virtual std::shared_ptr<IAgoraRteAudioTrack> GetRteAudioTrack() = 0;

  /**
   * @brief Opens a media streaming source
   * @param url The path of the media file. Both the local path and online path
   * are supported. for local file is absolute path; for online file is URL
   * which support HTTP and HTTPS protocol
   * @param startPos : The starting position (ms) for pushing
   * @param auto_play : Whether to automatically play the media streaming source
   * after opening.
   * @return
   * - 0: Success.
   * - < 0: Failure
   */
  virtual int Open(const char* url, int64_t start_pos,
                   bool auto_play = true) = 0;

  /**
   * @brief Open a play list
   * @param play_list : The play list which will be played
   * @param start_pos : The start position(ms) of the first file in the playlist
   * @param auto_play : Whether to automatically play the media streaming source
   * after opening.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Open(std::shared_ptr<IAgoraRtePlayList> play_list,
                   int64_t start_pos, bool auto_play = true) = 0;

  /**
   * @brief Closes the media streaming source. It will close a single file or a
   * play list
   * @return
   * - 0: Success.
   * - < 0: Failure
   */
  virtual int Close() = 0;

  /**
   * @brief Returns whether the video stream is valid.
   * @return: true: valid;  false: invalid
   */
  virtual bool IsVideoValid() = 0;

  /**
   * @brief Retrieve whether audio stream is valid
   * @return: true: valid;  false: invalid
   */
  virtual bool IsAudioValid() = 0;

  /**
   * @brief Gets the duration of the streaming source.
   * @param [out] duration A reference to the duration (ms) of the media file.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int GetDuration(int64_t& duration) = 0;

  /**
   * @brief Gets the number of media streams in the streaming source.
   * @param [out] count The number of the media streams in the media source.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int GetStreamCount(int64_t& count) = 0;

  /**
   * @brief Gets the detailed information of a media stream.
   * @param index The index of the media stream.
   * @param [out] out_info The detailed information of the media stream. See
   * \ref media::base::PlayerStreamInfo "PlayerStreamInfo" for details.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int GetStreamInfo(int64_t index,
                            media::base::PlayerStreamInfo* out_info) = 0;

  /**
   * @brief Sets the number of loops for playback.
   * @param loop_count The number of times of looping the media file.
   * - 1: Play the media file once.
   * - 2: Play the media file twice.
   * - <= 0: Play the media file in a loop indefinitely, until {@link stop} is
   * called.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int SetLoopCount(int64_t loop_count) = 0;

  /**
   * @brief Plays and pushes the streaming source.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int Play() = 0;

  /**
   * @brief Pauses playing the streaming source and keeps the playback position.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int Pause() = 0;

  /**
   * @brief Stops playing the streaming source and sets the playback position to
   * 0.
   * @return
   * - 0: Success.
   * - < 0: Failure.See {@link STREAMINGSRC_ERR}.
   */
  virtual int Stop() = 0;

  /**
   * @brief Sets the playback position of current file
   *        After seek done, it will return to previous status
   * @param newPos The new playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int Seek(int64_t new_pos) = 0;

  /**
   * @brief Seeks the previous file in the play list.
   * @param pos The position to be seeked in the file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SeekToPrev(int64_t pos) = 0;

  /**
   * @brief Seeks the next file in the playlist.
   * @param pos The position to be seeked in the file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SeekToNext(int64_t pos) = 0;

  /**
   * @brief Seeks a file by ID.
   * @param file_id The file id that should be seeked
   * @param pos The position to be seeked in the file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SeekToFile(int32_t file_id, int64_t pos) = 0;

  /**
   * @brief Get current streaming source status
   * @param [out] out_source_status The streaming source status for output
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetStreamingSourceStatus(
      RteStreamingSourceStatus& out_source_status) = 0;

  /**
   * @brief Gets the current playback position of the media file.
   * @param [out] pos A reference to the current playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int GetCurrPosition(int64_t& pos) = 0;

  /**
   * @breif Gets the status of current streaming source.
   * @return The current state machine
   */
  virtual agora::rtc::STREAMING_SRC_STATE GetCurrState() = 0;

  /**
   * @brief Appends the SEI data, which can be attached to video packet
   * @param type  SEI type
   * @param timestamp the video frame timestamp which attached to
   * @param frame_index the video frame timestamp which attached to
   *
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int AppendSeiData(const agora::rtc::InputSeiData& in_sei_data) = 0;

  /**
   * Registers a media player source observer.
   *
   * Once the media player source observer is registered, you can use the
   * observer to monitor the state change of the media player.
   * @param observer The pointer to the IMediaStreamingSource object.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int RegisterObserver(
      std::shared_ptr<IAgoraRteStreamingSourceObserver> observer) = 0;

  /**
   * Unregisters the media player source observer.
   * @param observer The pointer to the IMediaStreamingSource object.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int UnregisterObserver(
      std::shared_ptr<IAgoraRteStreamingSourceObserver> observer) = 0;
};

/**
 * @brief The observer interface of the streaming source.
 */
class IAgoraRteStreamingSourceObserver {
 public:
  virtual ~IAgoraRteStreamingSourceObserver() = default;

  /**
   * @brief Reports the playback state change.
   *     When the state of the playback changes,
   *     the SDK triggers this callback to report the new playback state
   *     and the reason or error for the change.
   * @param current_file_info : current file information
   * @param state The new playback state after change. See {@link
   * STREAMING_SRC_STATE}.
   * @param ec The player's error code. See {@link STREAMINGSRC_ERR}.
   */
  virtual void OnStateChanged(const RteFileInfo& current_file_info,
                              agora::rtc::STREAMING_SRC_STATE state,
                              agora::rtc::STREAMING_SRC_ERR err_code) = 0;

  /**
   * @brief Triggered when file is opened
   * @param err_code The error code, eumulate with agora::rte::ERROR_CODE_TYPE
   * @return None
   */
  virtual void OnOpenDone(const RteFileInfo& current_file_info,
                          int32_t err_code) = 0;

  /**
   * @brief Triggered when seeking is done
   * @param err_code The error code, eumulate with agora::rte::ERROR_CODE_TYPE
   * @return None
   */
  virtual void OnSeekDone(const RteFileInfo& current_file_info,
                          int32_t err_code) = 0;

  /**
   * @brief Triggered when one file playing is end
   * @param current_file_info : current file information
   * @param progress_ms the progress position
   * @param repeat_count means repeated count of playing
   */
  virtual void OnEofOnce(const RteFileInfo& current_file_info,
                         int64_t progress_ms, int64_t repeat_count) = 0;

  /**
   * @brief Occurs when all media files playback is completed.
   * @param err_code The error code, eumulate with agora::rte::ERROR_CODE_TYPE
   */
  virtual void OnAllMediasCompleted(int32_t err_code) = 0;

  /**
   * @brief Reports current playback progress.
   *        The callback triggered once every one second during the playing
   * status
   * @param current_file_info : current file information
   * @param position_ms Current playback progress (millisecond).
   */
  virtual void OnProgress(const RteFileInfo& current_file_info,
                          int64_t position_ms) = 0;

  /**
   * @brief Occurs when the metadata is received.
   *       The callback occurs when the player receives the media metadata
   *        and reports the detailed information of the media metadata.
   * @param data The detailed data of the media metadata.
   * @param length The data length (bytes).
   */
  virtual void OnMetaData(const RteFileInfo& current_file_info,
                          const void* data, int length) = 0;
};

}  // namespace rte
}  // namespace agora
