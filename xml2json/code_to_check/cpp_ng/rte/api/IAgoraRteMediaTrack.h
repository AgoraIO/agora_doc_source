//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include "AgoraRteBase.h"
#include "IAgoraRteMediaObserver.h"

namespace agora {
namespace rte {
class IAgoraRteMediaPlayer;

/**
 * The IAgoraVideoTrack class.
 * This is the base class for all video tracks.
 */
class IAgoraRteVideoTrack {
 public:
  /**
   * Sets the video canvas for local preview.
   *
   * @param canvas Video canvas settings.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetPreviewCanvas(const VideoCanvas& canvas) = 0;

  /**
   * Get the video source Type
   *
   * @return SourceType The video source type
   */
  virtual SourceType GetSourceType() = 0;

  /**
   * Registers a video frame observer.
   *
   * @param observer Point to an IAgoraRteVideoFrameObserver object.
   */
  virtual void RegisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) = 0;

  /**
   * Unregisters a video frame observer.
   *
   * @param observer Pointer to an IAgoraRteVideoFrameObserver object.
   */
  virtual void UnregisterVideoFrameObserver(
      std::shared_ptr<IAgoraRteVideoFrameObserver> observer) = 0;

  /**
   * Sets the property of a filter by ID
   *
   * @param id ID of the filter.
   * @param key Key of the filter.
   * @param json_value Value of the filter in JSON format.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetFilterProperty(const std::string& id, const std::string& key,
                                const std::string& json_value) = 0;

  /**
   * Gets the property of a filter by ID.
   *
   * @param id ID of the filter.
   * @param key Key of the filter.
   * @return std::string Value of the filter in JSON format.
   */
  virtual std::string GetFilterProperty(const std::string& id,
                                        const std::string& key) = 0;

  /**
   * Gets the stream ID where the track is published to.
   *
   * @return const std::string& The stream ID, empty if the track isn't
   * published yet.
   */
  virtual const std::string& GetAttachedStreamId() = 0;

  /**
   * Enable extension.
   *
   * @param provider_name name for provider, e.g. agora.io.
   * @param extension_name name for extension, e.g. agora.beauty.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int EnableExtension(const std::string& provider_name,
                              const std::string& extension_name) = 0;

  /**
   * Set extension specific property.
   *
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
  virtual int SetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   const std::string& json_value) = 0;

  /**
   * Get extension specific property.
   *
   * @param remote_stream_id ID of the remote video stream.
   * @param provider_name name for provider, e.g. agora.io.
   * @param extension_name name for extension, e.g. agora.beauty.
   * @param key key for the property.
   * @param json_value property value.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   std::string& json_value) = 0;

 protected:
  virtual ~IAgoraRteVideoTrack() = default;
};

/**
 * The IAgoraAudioTrack class.
 * This is the base class for all audio tracks.
 */
class IAgoraRteAudioTrack {
 public:
  /**
   * Enable local playback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int EnableLocalPlayback() = 0;

  /**
   *  Get the audio source type object
   *
   * @return SourceType The audio source type.
   */
  virtual SourceType GetSourceType() = 0;

  /**
   * Adjusts the publish volume of the local audio track..
   *
   * @param volume The volume for publishing. The value ranges between 0 and 100
   * (default).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int AdjustPublishVolume(int volume) = 0;

  /**
   * Adjusts the playback volume.
   * @param volume The playback volume. The value ranges between 0 and 100
   * (default).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int AdjustPlayoutVolume(int volume) = 0;

  /**
   * Gets the stream ID where the track is published to.
   *
   * @return const std::string& The stream ID, empty if the track isn't
   * published yet.
   */
  virtual const std::string& GetAttachedStreamId() = 0;

  /**
   * Enable extension.
   *
   * @param provider_name name for provider, e.g. agora.io.
   * @param extension_name name for extension, e.g. agora.beauty.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int EnableExtension(const std::string& provider_name,
                              const std::string& extension_name) = 0;

  /**
   * Set extension specific property.
   *
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
  virtual int SetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   const std::string& json_value) = 0;

  /**
   * Get extension specific property.
   *
   * @param remote_stream_id ID of the remote video stream.
   * @param provider_name name for provider, e.g. agora.io.
   * @param extension_name name for extension, e.g. agora.beauty.
   * @param key key for the property.
   * @param json_value property value.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int GetExtensionProperty(const std::string& provider_name,
                                   const std::string& extension_name,
                                   const std::string& key,
                                   std::string& json_value) = 0;

 protected:
  virtual ~IAgoraRteAudioTrack() = default;
};

/**
 * The IAgoraCameraVideoTrack class.
 * This class represents a camera track. A camera track takes camera as data
 * source and receives video frames from camera. This class also contains some
 * camera related operations.
 */
class IAgoraRteCameraVideoTrack : public IAgoraRteVideoTrack {
 public:
#if RTE_IPHONE || RTE_ANDROID
  /**
   * Sets the camera source of the camera track
   *
   * @param source Camera source.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetCameraSource(CameraSource source) = 0;

  /**
   * Switches the camera source.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual void SwitchCamera() = 0;

  /**
   * Sets the camera zoom value
   *
   * @param zoomValue Camera zoom value
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetCameraZoom(float zoomValue) = 0;

  /**
   * Sets the coordinates of camera focus area.
   *
   * @param x X axis value.
   * @param y Y axis value.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetCameraFocus(float x, float y) = 0;

  /**
   * Whether to enable the camera to automatically focus on a human face.
   *
   * @param enable
   * true: Enables the camera to automatically focus on a human face.
   * false: Disables the camera to automatically focus on a human face.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetCameraAutoFaceFocus(bool enable) = 0;

  /**
   * Whether to enable the camera to detect human face.
   *
   * @param enable
   * true: Enables the camera to detect on a human face.
   * false: Disables the camera to detect on a human face.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetCameraFaceDetection(bool enable) = 0;

#elif RTE_DESKTOP
  /**
   * Sets the video orientation of the capture device.
   *
   * @param orientation orientation of the device 0(by default), 90, 180, 270
   */
  virtual void SetDeviceOrientation(VIDEO_ORIENTATION orientation) = 0;

  /**
   * Selects the camera by device ID.
   *
   * @param device_id The unique device id from system
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int SetCameraDevice(const std::string& device_id) = 0;
#endif
  /**
   * Starts capturing with the selected camera.
   *
   * @param func The function which SDK will call when camera state changed.
   * Check \ref agora::rte::CameraState for state details. The function will
   * be stored in SDK and will be released when IAgoraRteCameraVideoTrack is
   * released.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StartCapture(CameraCallbackFun func = nullptr) = 0;

  /**
   * Stops capturing with the selected camera.
   *
   */
  virtual void StopCapture() = 0;

 protected:
  virtual ~IAgoraRteCameraVideoTrack() override = default;
};

/**
 * The IAgoraRteScreenVideoTrack class.
 * This class represents a screen track. A screen track can capture screen as
 * video source.
 *
 */
class IAgoraRteScreenVideoTrack : public IAgoraRteVideoTrack {
 public:
#if RTE_WIN
  /**
   * (Windows) Starts capturing the screen by screenRect.
   *
   * @param screenRect Relative location of the screen to the virtual screen.
   * @param regionRect Relative location of the region to the screen.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StartCaptureScreen(const Rectangle& screenRect,
                                 const Rectangle& regionRect) = 0;

  /**
   * (Windows) Starts capturing a window by window ID.
   *
   * @param windowId windowId ID of the window.
   * @param regionRect regionRect Relative location of the region to the screen.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StartCaptureWindow(view_t windowId,
                                 const Rectangle& regionRect) = 0;
#elif RTE_MAC
  /**
   * (macOS) Starts capturing the screen by displayId.
   *
   * @param display_id Display ID of the screen.
   * @param region_rect Relative location of the region to the screen.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StartCaptureScreen(uint32_t display_id,
                                 const Rectangle& region_rect) = 0;

  /**
   * (macOS) Starts capturing a window by window ID.
   *
   * @param window_id ID of the window.
   * @param region_rect Relative location of the region to the screen.
   * @return int
   */
  virtual int StartCaptureWindow(view_t window_id,
                                 const Rectangle& region_rect) = 0;
#elif RTE_ANDROID
  /**
   * Starts screen capturing by specifying the Intent data obtained from
   * MediaProjection. This method shares the whole screen.
   * @note
   * This method applies to Android only.
   * @param data The Intent data from onActivityResult (int requestCode, int
   * resultCode, Intent data) after you create an Intent from MediaProjection
   * and sends the Intent to startActivityForResult.
   * @param dimensions The reference to the captured screen's resolution in
   * terms of width × height. If you set width or height as 0, the dimensions
   * will be the screen's width × height.
   * @return
   * 0: Success.
   * < 0: Failure.
   * ERR_INVALID_ARGUMENT if data is null.
   */
  virtual int StartCaptureScreen(void* data,
                                 const VideoDimensions& dimensions) = 0;
#elif RTE_IPHONE
  /**
   * (iOS) Starts capturing the screen,
   *
   * @return
   * 0: Success.
   * < 0: Failure.
   */
  virtual int StartCaptureScreen() = 0;
#endif

#if RTE_WIN || RTE_MAC
  /**
   * Sets the content hint for screen sharing.
   * A content hint suggests the type of the content being shared, so that the
   * SDK applies different optimization algorithms to different types of
   * content.
   *
   * @param content_hint The content hint for screen capture.
   * @return
   * 0: Success.
   * < 0: Failure.
   */
  virtual int SetContentHint(VIDEO_CONTENT_HINT content_hint) = 0;

  /**
   * Updates the screen capture region.
   *
   * @param region_rect The reference to the relative location of the region to
   * the screen or window. See \ref agora::rtc::Rectangle "Rectangle". If the
   * specified region overruns the screen or window, the screen capturer
   * captures only the region within it. If you set width or height as 0, the
   * SDK shares the whole screen or window.
   *
   * @return
   * 0: Success.
   * < 0: Failure.
   */
  virtual int UpdateScreenCaptureRegion(const Rectangle& region_rect) = 0;
#endif
  /**
   * Stops screen capture.
   *
   * @return
   * 0: Success.
   * < 0: Failure.
   */
  virtual void StopCapture() = 0;

 protected:
  virtual ~IAgoraRteScreenVideoTrack() override = default;
};

/**
 * The IAgoraMixedVideoTrack class.
 * This class contains a mixer which can mix video frames from different video
 * tracks into single video source, then publish the mixed result to stream.
 */
class IAgoraRteMixedVideoTrack : public IAgoraRteVideoTrack {
 public:
  /**
   * Sets the layout for the mixed video track.
   *
   * @param layout_configs layoutConfigs Configurations for the layout.
   * @return
   * 0: Success.
   * < 0: Failure
   */
  virtual int SetLayout(const LayoutConfigs& layout_configs) = 0;

  /**
   * Gets the layout for the mixed video track.
   *
   * @param layout_configs Configurations for the layout
   * @return
   * 0: Success.
   * < 0: Failure
   */
  virtual int GetLayout(LayoutConfigs& layout_configs) = 0;

  /**
   * Adds a video track to the mixed video track.
   *
   * @param track IAgoraRteVideoTrack
   * @return
   * 0: Success.
   * < 0: Failure
   */
  virtual int AddTrack(std::shared_ptr<IAgoraRteVideoTrack> track) = 0;

  /**
   * Removes a video track from the mixed video track.
   *
   * @param track IAgoraRteVideoTrack
   * @return
   * 0: Success.
   * < 0: Failure
   */
  virtual int RemoveTrack(std::shared_ptr<IAgoraRteVideoTrack> track) = 0;

  /**
   * Adds a media player to the mixed video track. Note that only audio frame
   * from the media player will be added into mixed track.
   *
   * @param media_player IAgoraRteMediaPlayer.
   * @return
   * 0: Success.
   * < 0: Failure
   */
  virtual int AddMediaPlayer(
      std::shared_ptr<IAgoraRteMediaPlayer> media_player) = 0;

  /**
   * Removes a media player from the mixed video track.
   *
   * @param media_player IAgoraRteMediaPlayer.
   * @return
   * 0: Success.
   * < 0: Failure
   */
  virtual int RemoveMediaPlayer(
      std::shared_ptr<IAgoraRteMediaPlayer> media_player) = 0;

 protected:
  ~IAgoraRteMixedVideoTrack() override = default;
};

/**
 * The IAgoraCustomVideoTrack class.
 */
class IAgoraRteCustomVideoTrack : public IAgoraRteVideoTrack {
 public:
  /**
   * Push external video frame.
   *
   * @param frame The external video frame to be pushed.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int PushVideoFrame(const ExternalVideoFrame& frame) = 0;

 protected:
  ~IAgoraRteCustomVideoTrack() override = default;
};

/**
 * The IAgoraMicrophoneAudioTrack class.
 */
class IAgoraRteMicrophoneAudioTrack : public IAgoraRteAudioTrack {
 public:
  /**
   * Starts audio recording.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int StartRecording() = 0;

  /**
   * Stops audio recording.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual void StopRecording() = 0;

  /**
   * Enables in-ear monitoring (for Android and iOS only).
   *
   * @param enabled Determines whether to enable in-ear monitoring.
   * - true: Enable.
   * - false: (Default) Disable.
   * @param includeAudioFilters The type of the ear monitoring:
   * #EAR_MONITORING_FILTER_TYPE
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int EnableEarMonitor(bool enable, int include_audio_filter) = 0;

 protected:
  ~IAgoraRteMicrophoneAudioTrack() override = default;
};

/**
 * The IAgoraCustomAudioTrack class.
 */
class IAgoraRteCustomAudioTrack : public IAgoraRteAudioTrack {
 public:
  /**
   * Push external audio frame.
   *
   * @param frame The external audio frame to be pushed.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int PushAudioFrame(AudioFrame& frame) = 0;

 protected:
  ~IAgoraRteCustomAudioTrack() override = default;
};

}  // namespace rte
}  // namespace agora
