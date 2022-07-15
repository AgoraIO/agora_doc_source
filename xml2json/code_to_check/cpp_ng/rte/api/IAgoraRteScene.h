//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteMediaTrack.h"

namespace agora {
namespace rte {

class IAgoraRteSceneEventHandler;

/**
 * The IAgoraRteScene class.
 */
class IAgoraRteScene {
 public:
  /**
   * Joins an scene.
   *
   * @param user_id User ID to join a scene.
   * @param token The access token to join a scene.
   * @param options Options to join a scene.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int Join(const std::string& user_id, const std::string& token,
                   const JoinOptions& options) = 0;

  /**
   * Leaves an scene.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual void Leave() = 0;

  /**
   * Renew the scene token.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int RenewSceneToken(const std::string& new_token) = 0;

  /**
   * Get scene info.
   *
   * @return Current scene info.
   */
  virtual SceneInfo GetSceneInfo() const = 0;

  /**
   * Gets information of the local user.
   *
   * @return Information of the local user.
   */
  virtual UserInfo GetLocalUserInfo() const = 0;

  /**
   * Gets information of the remote user.
   *
   * @return Information of remote users.
   */
  virtual std::vector<UserInfo> GetRemoteUsers() const = 0;

  /**
   * Gets the information of local streams.
   *
   * @return Information of local streams.
   */
  virtual std::vector<StreamInfo> GetLocalStreams() const = 0;

  /**
   * Gets the information of remote streams.
   *
   * @return Information of remote streams.
   */
  virtual std::vector<StreamInfo> GetRemoteStreams() const = 0;

  /**
   * Gets the information of remote streams by user ID.
   *
   * @param user_id User ID.
   * @return std::vector<StreamInfo> Information of remote streams.
   */
  virtual std::vector<StreamInfo> GetRemoteStreamsByUserId(
      const std::string& user_id) const = 0;

  /**
   * Create a Or Update RTC Stream object.
   * If the stream doesn't exist, a new stream will be created, otherwise, the
   * stream will be updated by the new option (e.g. rtc token will be updated).
   *
   * @param local_stream_id Target stream id
   * @param options Options to apply
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int CreateOrUpdateRTCStream(const std::string& local_stream_id,
                                      const RtcStreamOptions& options) = 0;

  /**
   * Create a Or Update CDN Stream object.
   * If the stream doesn't exist, a new stream will be created, otherwise, the
   * stream will be updated by the new option (e.g. CDN url will be updated).
   *
   * @param local_stream_id Target stream id
   * @param options Options to apply
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int CreateOrUpdateDirectCDNStream(
      const std::string& local_stream_id,
      const DirectCdnStreamOptions& options) = 0;

  /**
   * Destroys a local stream by ID.
   *
   * @param local_stream_id ID of the local stream to be destroyed
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int DestroyStream(const std::string& local_stream_id) = 0;

  /**
   * Configures the audio encoder for the local stream.
   * Note that all audio tracks published to the stream will apply the new
   * configuration.
   *
   * @param local_stream_id ID of the local stream.
   * @param config Audio encoder configurations.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetAudioEncoderConfiguration(
      const std::string& local_stream_id,
      const AudioEncoderConfiguration& config) = 0;

  /**
   * Configures the video encoder for the local stream.
   * Note that all video tracks published to the stream will apply the new
   * configuration.
   *
   * @param local_stream_id ID of the local stream.
   * @param config Video encoder configurations.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetVideoEncoderConfiguration(
      const std::string& local_stream_id,
      const VideoEncoderConfiguration& config) = 0;

  /**
   * Set extension specific property.
   *
   * @param remote_stream_id ID of the remote stream.
   * @param provider_name name for provider, e.g. agora.io.
   * @param extension_name name for extension, e.g. agora.beauty.
   * @param key key for the property. if want to enabled filter, use a special
   * key kExtensionPropertyEnabledKey.
   * @param json_value property value.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetExtensionProperty(const std::string& remote_stream_id,
                                   const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   const std::string& json_value) = 0;

  /**
   * Get extension specific property.
   *
   * @param remote_stream_id ID of the remote stream.
   * @param provider_name name for provider, e.g. agora.io.
   * @param extension_name name for extension, e.g. agora.beauty.
   * @param key key for the property.
   * @param json_value property value.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetExtensionProperty(const std::string& remote_stream_id,
                                   const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   std::string& json_value) = 0;

  /**
   * Set the transcoding parameter for publish CDN bypass
   * If you call this method for the first time, it will NOT trigger the
   * `OnBypassTranscodingUpdated` callback,
   *
   * @param local_stream_id ID of the local stream to be destroyed
   * @param transcoding Parameter of live transcoding
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetCloudCdnTranscoding(
      const std::string& local_stream_id,
      const agora::rtc::LiveTranscoding& transcoding) = 0;

  /**
   * Add a target bypass CDN URL to a local stream
   * This method will trigger 'OnCloudCdnStateChanged' and
   'OnCloudCdnPublished' callback
   *
   * @param local_stream_id ID of the local stream to be destroyed
   * @param target_cdn_url The CDN streaming URL in the RTMP format.
             The maximum length of this parameter is 1024 bytes.
   *         The URL address must not contain special character, such as Chinese
   language characters.
   * @param transcoding_enabled  Sets whether transcoding is enabled/disabled.
   *        If you set this parameter as `true`, ensure that you call the
   `SetCloudCdnTranscoding`
   * method before this method.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int AddCloudCdnUrl(const std::string& local_stream_id,
                              const std::string& target_cdn_url,
                              bool transcoding_enabled) = 0;

  /**
   * Remove a cloud CDN URL from a local stream
   * This method will trigger 'OnCloudCdnStateChanged' and
   'OnCloudCdnUnpublished' callback
   *
   * @param local_stream_id ID of the local stream to be destroyed
   * @param target_cdn_url The CDN streaming URL in the RTMP format.
             The maximum length of this parameter is 1024 bytes.
   *         The URL address must not contain special character, such as Chinese
   language characters.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int RemoveCloudCdnUrl(const std::string& local_stream_id,
                                 const std::string& target_cdn_url) = 0;

  /**
   * Publishes a local audio track to a local stream by ID.
   * Note that remote peers could only see one audio track even several local
   * audio tracks are published to the stream. This is because all local audio
   * tracks will be mixed automatically in internal before sending the audio
   * data to remote peers.
   *
   * @param local_stream_id ID of the local stream.
   * @param track The local audio track.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int PublishLocalAudioTrack(
      const std::string& local_stream_id,
      std::shared_ptr<IAgoraRteAudioTrack> track) = 0;

  /**
   * Publishes a local video track to a local stream by ID.
   * Note that one stream could only contains one video track, so several
   * streams are required to publish several video tracks, or one stream with
   * mixing all video tracks together.
   *
   * @param local_stream_id ID of the local stream.
   * @param track The local video track.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int PublishLocalVideoTrack(
      const std::string& local_stream_id,
      std::shared_ptr<IAgoraRteVideoTrack> track) = 0;

  /**
   * Unpublishes a local audio track.
   *
   * @param track The local audio track.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int UnpublishLocalAudioTrack(
      std::shared_ptr<IAgoraRteAudioTrack> track) = 0;

  /**
   * Unpublishes a local video track.
   * Note that even the track is unpublished, but for camera track or screen
   * track, the track could be still captering data from camera or screen, so
   * the preview function isn't impact after unpublishing. To stop the camera or
   * screen track, user need to call StopCapture().
   *
   * @param track The local video track.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int UnpublishLocalVideoTrack(
      std::shared_ptr<IAgoraRteVideoTrack> track) = 0;

  /**
   * Publishes a media player to a local stream by ID. The played audio and
   * video will be sent to the stream.
   *
   * @param local_stream_id ID of the local stream.
   * @param player The media player.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int PublishMediaPlayer(
      const std::string& local_stream_id,
      std::shared_ptr<IAgoraRteMediaPlayer> player) = 0;

  /**
   * Unpublishes a media player.
   *
   * @param player The media player.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int UnpublishMediaPlayer(
      std::shared_ptr<IAgoraRteMediaPlayer> player) = 0;

  /**
   * Subscribes the remote audio data from remote stream
   *
   * @param remote_stream_id The remote stream ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SubscribeRemoteAudio(const std::string& remote_stream_id) = 0;

  /**
   * Unsubscribes the remote audio data from remote stream
   *
   * @param remote_stream_id The remote stream ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int UnsubscribeRemoteAudio(const std::string& remote_stream_id) = 0;

  /**
   * Subscribes the remote video data from remote stream
   *
   * @param remote_stream_id The remote stream ID.
   * @param options Subscription options.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SubscribeRemoteVideo(const std::string& remote_stream_id,
                                   const VideoSubscribeOptions& options) = 0;

  /**
   * Unsubscribes the remote video data from remote stream
   *
   * @param remote_stream_id The remote stream ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int UnsubscribeRemoteVideo(const std::string& remote_stream_id) = 0;

  /**
   * Set video canvas for the remote stream. Video frame from the remote stream
   * will be applied to the canvas. Note that SDK will try to hold related
   * resource internal (e.g window resource from system), and the resource
   * referenced by canvas will be released when scene is destroyed or user set
   * the canvas with empty resource.
   *
   * @param remote_stream_id The remote stream ID
   * @param canvas The input Canvas.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetRemoteVideoCanvas(const std::string& remote_stream_id,
                                   const VideoCanvas& canvas) = 0;

  /**
   * Registers an event handler for the scene.
   *
   * @param event_handler An IAgoraRteSceneEventHandler object.
   */
  virtual void RegisterEventHandler(
      std::shared_ptr<IAgoraRteSceneEventHandler> event_handler) = 0;

  /**
   * Unregisters an event handler.
   *
   * @param event_handler  An IAgoraRteSceneEventHandler object.
   */
  virtual void UnregisterEventHandler(
      std::shared_ptr<IAgoraRteSceneEventHandler> event_handler) = 0;

  /**
   * Registers a video frame observer for the remote stream.
   * For local video frame observer, user can register observer on track object.
   *
   * @param observer An IAgoraRteVideoFrameObserver object.
   */
  virtual void RegisterRemoteVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) = 0;

  /**
   * Unregisters an audio frame observer.
   *
   * @param observer  An IAgoraRteVideoFrameObserver object.
   */
  virtual void UnregisterRemoteVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) = 0;

  /**
   * Registers a audio frame observer for the local or remote stream.
   *
   * @param observer An IAgoraRteAudioFrameObserver object.
   */
  virtual void RegisterAudioFrameObserver(
      std::shared_ptr<IAgoraRteAudioFrameObserver> observer,
      const AudioObserverOptions& options) = 0;

  /**
   * Unregisters an audio frame observer.
   *
   * @param observer  An IAgoraRteAudioFrameObserver object.
   */
  virtual void UnregisterAudioFrameObserver(
      std::shared_ptr<IAgoraRteAudioFrameObserver> observer) = 0;

   /**
    * Adjust the playback volume for remote user
    * 
    * @param remote_stream_id The remote stream id
    * @param volume The playback volume, range is [0,100]
    * @return
    * - 0: Success
    * - < 0: Failure
    */
  virtual int AdjustUserPlaybackSignalVolume(const std::string& remote_stream_id, int volume) = 0;

  /**
   * Get the playback volume for remote user
   * 
   * @param remote_stream_id The remote stream id
   * @param volume The playback volume
   * @return
   * - 0: Success
   * - < 0: Failure
   */
  virtual int GetUserPlaybackSignalVolume(const std::string& remote_stream_id, int* volume) = 0;
 protected:
  virtual ~IAgoraRteScene() = default;
};

/**
 * The IAgoraRteSceneEventHandler class.
 */
class IAgoraRteSceneEventHandler {
 public:
  /**
   * Occurs when the connection state changes.
   *
   * @param old_state The old connection state.
   * @param new_state The new connection state.
   * @param reason The reason of the connection state change.
   */
  virtual void OnConnectionStateChanged(ConnectionState old_state,
                                        ConnectionState new_state,
                                        ConnectionChangedReason reason) = 0;
  /**
   * Occurs when remote users join.
   *
   * @param users Joined remote users.
   */
  virtual void OnRemoteUserJoined(const std::vector<UserInfo>& users) = 0;

  /**
   * Occurs when remote users left.
   *
   * @param users Left remote users.
   */
  virtual void OnRemoteUserLeft(const std::vector<UserInfo>& users) = 0;

  /**
   * Occurs when remote streams are added.
   *
   * @param streams Added remote streams.
   */
  virtual void OnRemoteStreamAdded(const std::vector<StreamInfo>& streams) = 0;

  /**
   * Occurs when remote streams are removed.
   *
   * @param streams Removed remote streams.
   */
  virtual void OnRemoteStreamRemoved(
      const std::vector<StreamInfo>& streams) = 0;

  /**
   * Occurs when the media state of the local stream changes.
   *
   * @param stream Information of the local stream.
   * @param media_type Media type of the local stream.
   * @param old_state Old state of the local stream.
   * @param new_state New state of the local stream.
   * @param reason The reason of the state change.
   */
  virtual void OnLocalStreamStateChanged(const StreamInfo& stream,
                                         MediaType media_type,
                                         StreamMediaState old_state,
                                         StreamMediaState new_state,
                                         StreamStateChangedReason reason) = 0;

  /**
   * Occurs when the media state of the remote stream changes.
   *
   * @param stream Information of the remote stream.
   * @param media_type Media type of the remote stream.
   * @param old_state Old state of the remote stream.
   * @param new_state New state of the remote stream.
   * @param reason The reason of the state change.
   */
  virtual void OnRemoteStreamStateChanged(const StreamInfo& stream,
                                          MediaType media_type,
                                          StreamMediaState old_state,
                                          StreamMediaState new_state,
                                          StreamStateChangedReason reason) = 0;

  /**
   * Reports the volume information of users.
   *
   * @param speakers The volume information of users.
   * @param total_volume Total volume after audio mixing. The value ranges
   * between 0 (lowest volume) and 255 (highest volume).
   */
  virtual void OnAudioVolumeIndication(
      const std::vector<AudioVolumeInfo>& speakers, int total_volume) = 0;

  /**
   * Occurs when an active speaker is detected.
   *
   * @note
   * - The active speaker means the user ID of the speaker who speaks at the highest volume during a
   * certain period of time.
   *
   * @param stream_id The ID of the active speaker. A `stream_id` of 0 means the local user.
   */
  virtual void OnActiveSpeaker(const std::string& stream_id) = 0;

  /**
   * Occurs when the token will expire in 30 seconds for the user.
   *
   * @param token The token that will expire in 30 seconds.
   */
  virtual void OnSceneTokenWillExpire(const std::string& scene_id,
                                       const std::string& token) = 0;

  /**
   * Occurs when the token has expired for a user.
   *
   * @param stream_id The ID of the scene.
   */
  virtual void OnSceneTokenExpired(const std::string& scene_id) = 0;

  /**
   * Occurs when the token of a stream expires in 30 seconds.
   * If the token you specified when calling 'CreateOrUpdateRTCStream' expires,
   * the stream will drop offline. This callback is triggered 30 seconds before
   * the token expires, to remind you to renew the token by calling
   * 'CreateOrUpdateRTCStream' again with new token.
   * //TODO (yejun): Need to tell how to generate new token, ETA for new token
   * facility Upon receiving this callback, generate a new token at your app
   * server
   *
   * @param stream_id
   * @param token
   */

  virtual void OnStreamTokenWillExpire(const std::string& stream_id,
                                       const std::string& token) = 0;

  /**
   * Occurs when the token has expired for a stream.
   *
   * Upon receiving this callback, you must generate a new token on your server
   * and call "CreateOrUpdateRTCStream" to pass the new token to the SDK.
   *
   * @param stream_id The ID of the scene.
   */
  virtual void OnStreamTokenExpired(const std::string& stream_id) = 0;

  virtual void OnCloudCdnStateChanged(
      const std::string& stream_id, const std::string& target_cdn_url,
      CLOUDCDN_STREAM_PUBLISH_STATE state,
      CLOUDCDN_STREAM_PUBLISH_ERROR err_code) = 0;

  virtual void OnCloudCdnPublished(
      const std::string& stream_id, const std::string& target_cdn_url,
                                   CLOUDCDN_STREAM_PUBLISH_ERROR err_code) = 0;

  virtual void OnCloudCdnUnpublished(const std::string& stream_id,
                                      const std::string& target_cdn_url) = 0;

  virtual void OnCloudTranscodingUpdated(const std::string& stream_id) = 0;

  virtual void OnSceneStats(const SceneStats& stats) = 0;

  virtual void OnLocalStreamAudioStats(const std::string& stream_id,
                                       const RteLocalAudioStats& stats) = 0;

  virtual void OnLocalStreamVideoStats(const std::string& stream_id,
                                       const RteLocalVideoStats& stats) = 0;

  virtual void OnRemoteStreamAudioStats(const std::string& stream_id,
                                        const RteRemoteAudioStats& stats) = 0;

  virtual void OnRemoteStreamVideoStats(const std::string& stream_id,
                                        const RteRemoteVideoStats& stats) = 0;

  virtual void OnLocalStreamEvent(const std::string& stream_id,
                                  LocalStreamEventType event) = 0;
  virtual void OnRemoteStreamEvent(const std::string& stream_id,
                                   RemoteStreamEventType event) = 0;

 protected:
  virtual ~IAgoraRteSceneEventHandler() = default;
};

}  // namespace rte
}  // namespace agora
