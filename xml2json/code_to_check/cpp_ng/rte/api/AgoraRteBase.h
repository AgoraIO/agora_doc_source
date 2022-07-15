//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once

#include <algorithm>
#include <atomic>
#include <chrono>
#include <functional>
#include <map>
#include <memory>
#include <mutex>
#include <string>
#include <unordered_set>
#include <vector>

// RTC headers
//
#include "AgoraBase.h"
#include "AgoraMediaBase.h"
#include "AgoraMediaPlayerTypes.h"
#include "AgoraRefCountedObject.h"
#include "AgoraRefPtr.h"
#include "IAgoraMediaComponentFactory.h"
#include "IAgoraService.h"
#include "media_player_i.h"

// RTC NG APIs
//
#include "NGIAgoraAudioDeviceManager.h"
#include "NGIAgoraAudioTrack.h"
#include "NGIAgoraCameraCapturer.h"
#include "NGIAgoraLocalUser.h"
#include "NGIAgoraMediaNode.h"
#include "NGIAgoraMediaNodeFactory.h"
#include "NGIAgoraRtcConnection.h"
#include "NGIAgoraScreenCapturer.h"
#include "NGIAgoraVideoMixerSource.h"
#include "NGIAgoraVideoTrack.h"

// RTE facility
//
#include "AgoraRteLog.h"

// MACRO
//
#define RTE_INLINE
#ifndef GUARDED_BY
#if defined(__clang__)
#define THREAD_ANNOTATION_ATTRIBUTE__(x) __attribute__((x))
#else
#define THREAD_ANNOTATION_ATTRIBUTE__(x)  // no-op
#endif
#define GUARDED_BY(x) THREAD_ANNOTATION_ATTRIBUTE__(guarded_by(x))
#endif

#if defined(_WIN32)
#define RTE_WIN 1
#elif TARGET_OS_MAC
#define RTE_APPLE 1
//+---------------------------------------------------------------------+
//|                            TARGET_OS_MAC                            |
//| +---+ +-----------------------------------------------+ +---------+ |
//| |   | |               TARGET_OS_IPHONE                | |         | |
//| |   | | +---------------+ +----+ +-------+ +--------+ | |         | |
//| |   | | |      IOS      | |    | |       | |        | | |         | |
//| |OSX| | |+-------------+| | TV | | WATCH | | BRIDGE | | |DRIVERKIT| |
//| |   | | || MACCATALYST || |    | |       | |        | | |         | |
//| |   | | |+-------------+| |    | |       | |        | | |         | |
//| |   | | +---------------+ +----+ +-------+ +--------+ | |         | |
//| +---+ +-----------------------------------------------+ +---------+ |
//+---------------------------------------------------------------------+
#if TARGET_OS_OSX
#define RTE_MAC 1
#elif TARGET_OS_IPHONE
#define RTE_IPHONE 1
#endif
#elif defined(__ANDROID__) or defined(ANDROID)
#define RTE_ANDROID 1
#elif defined(__linux__)
#define RTE_LINUX 1
#endif

#if RTE_WIN || RTE_MAC || RTE_LINUX
#define RTE_DESKTOP 1
#endif

namespace agora {
namespace rte {

// RTE types
//

// Types from RTC
//
using LOG_LEVEL = agora::commons::LOG_LEVEL;
using MEDIA_PLAYER_STATE = media::base::MEDIA_PLAYER_STATE;
using RENDER_MODE_TYPE = media::base::RENDER_MODE_TYPE;
using MEDIA_PLAYER_ERROR = media::base::MEDIA_PLAYER_ERROR;
using MEDIA_PLAYER_EVENT = media::base::MEDIA_PLAYER_EVENT;
using MEDIA_PLAYER_METADATA_TYPE = media::base::MEDIA_PLAYER_METADATA_TYPE;
using VIDEO_MIRROR_MODE_TYPE = rtc::VIDEO_MIRROR_MODE_TYPE;
using RENDER_MODE_TYPE = media::base::RENDER_MODE_TYPE;
using VIDEO_CONTENT_HINT = rtc::VIDEO_CONTENT_HINT;
using AudioPcmFrame = media::base::AudioPcmFrame;
using AudioFrame = media::IAudioFrameObserver::AudioFrame;
using VideoFrame = media::base::VideoFrame;
using ExternalVideoFrame = media::base::ExternalVideoFrame;
using EncodedVideoFrameInfo = rtc::EncodedVideoFrameInfo;
using VIDEO_ORIENTATION = rtc::VIDEO_ORIENTATION;
using AudioRoute = rtc::AudioRoute;
using PlayerStreamInfo = media::base::PlayerStreamInfo;
using VideoEncoderConfiguration = rtc::VideoEncoderConfiguration;
using AudioEncoderConfiguration = rtc::AudioEncoderConfiguration;
using Rectangle = rtc::Rectangle;
using ICameraCapturer = rtc::ICameraCapturer;
using ConnectionChangedReason = rtc::CONNECTION_CHANGED_REASON_TYPE;
using VIDEO_STREAM_TYPE = rtc::VIDEO_STREAM_TYPE;
using VideoDimensions = rtc::VideoDimensions;
using VideoFormat = rtc::VideoFormat;

/**
 * The definition of the VideoCanvas struct, which contains the information of the video display window.
 */
struct VideoCanvas {
  /**
   * The video display window.
   */
  view_t view;
  /**
   * The video display mode: \ref agora::media::base::RENDER_MODE_TYPE "RENDER_MODE_TYPE".
   */
  media::base::RENDER_MODE_TYPE render_mode;
  /**
   * The video mirror mode:
   */
  VIDEO_MIRROR_MODE_TYPE mirror_mode;
};

/**
 * The pointer to the video display window.
 */
using View = void*;

// RTE POD struct
//
#if RTE_WIN || RTE_MAC
using AudioDeviceInfo = agora::rtc::AudioDeviceInfo;

struct VideoDeviceInfo {
  /**
   * The name of the device in the UTF8 format.
   */
  std::string device_name;
  /**
   * the unique Id of the device from system.
   */
  std::string device_id;
};
#endif

/**
 * The reason for stream state changes.
 */
enum class StreamStateChangedReason {
  /**
   * 1: The stream is published to network.
   */
  kPublished = 1,
  /**
   * 2: The stream is unpublished.
   */
  kUnpublished,
  /**
   * 3: The stream is subscribed and we have received data from the stream.
   */
  kSubscribed,
  // TODO (yejun): Need to confirm with team that the stream will get
  // unsubscribed if remote host pause the stream
  /**
   * 4: The stream is unsubscribed.
   */
  kUnsubscribed,
};

/**
 * The definition of the AudioVolumeInfo struct.
 */
struct AudioVolumeInfo {
  /**
   * User ID of the speaker.
   */
  std::string user_id;
  /**
   * The volume of the speaker that ranges from 0 to 255.
   */
  unsigned int volume;  // [0,255]
  unsigned int vad;

  /**
   * Voice pitch frequency in Hz
   */
  double voicePitch;
};

/**
 * The camera source.
 */
enum class CameraSource {
  /**
   * The camera source is the rear camera.
   */
  kBack,
  /**
   * The camera source is the front camera.
   */
  kFront,
};

/**
 * The camera state.
 */
enum class CameraState {
  /**
   * The camera is started.
   */
  kStarted,
  /**
   * The camera is stopped.
   */
  kStopped,
};

// Background config.
//
struct CanvasConfig {
  /**
   * Width of the canvas (pixel)
   */
  int width = 1920;
  /**
   * Height of the canvas (pixel)
   */
  int height = 1080;
  /**
   * Fps of the mixed video.
   * The value will be replaced by stream's video encoder configuration
   * when the video is published to stream.
   */
  int fps = 15;
  /**
   * Local file path of the canvas background image, if path
   * is invalid or empty, the background will be back.
   */
  std::string image_file_path;
};

// Layout config types.
//
enum class LayoutType {
  /**
   * Apply layout setting for image defined in LayoutConfig.
   */
  Image,
  /**
   * Apply layout setting for track which will apply the LayoutConfig.
   */
  Track,
};

// Config of Video layout.
//
struct LayoutConfig {
  /**
   * layout type to tell which tar.
   */
  LayoutType layout_type;
  /**
   * The unique id where we apply layout setting to.
   * The Id will be automaticaly created if it doesn't exist.
   */
  std::string id;
  /**
   * The horizontal position of the top left corner of the video frame. (pixel)
   */
  int x = 0;
  /**
   * The vertical position of the top left corner of the video frame. (pixel)
   */
  int y = 0;
  /**
   * // TODO (yejun): Need to confirm pixel is the unit
   * The width of the video frame. (pixel)
   */
  int width = 0;
  /**
   * The height of the video frame. (pixel)
   */
  int height = 0;
  /**
   * The layer of the video frame that ranges from 1 to 100:
   * - 1: (Default) The lowest layer.
   * - 100: The highest layer.
   */
  int zOrder = 0;
  /**
   * The transparency of the video frame.
   * 0 means the region is transparent, and 1 means the region is opaque
   */
  float alpha = 1.0;
  /**
   * mirror of the source video frame (only valid for camera streams)
   */
  bool mirror = false;

  /**
   * Local image file path.
   * 1. When layout type is Image, the image will be mixed with layer settings.
   * 2. When layout type is track, the image is only valid for remote track
   * which will display the image when remote track is muted.
   */
  std::string image_path;
};

// Layout configurations.
//
struct LayoutConfigs {
  /**
   * Canvas setting for the video frame.
   */
  CanvasConfig canvas;
  /**
   * Layout settings.
   */
  std::vector<LayoutConfig> layouts;
};

// Connection state.
//
enum class ConnectionState {
  /**
   * The connection is disconnected from the server.
   */
  kDisconnected,
  /**
   * The connection is disconnecting to the server.
   */
  kDisconnecting,
  /**
   * The connection is connecting to the server.
   */
  kConnecting,
  /**
   * The connection is connected to the server and has joined a scene.
   * You can now publish or subscribe data through the stream now.
   */
  kConnected,
  /**
   * The connection keeps rejoining the scene after being disconnected,probably
   * because of network issues.
   */
  kReconnecting,
  /**
   * The connection failed to connect to the server or join the scene
   */
  kFailed
};

using SceneState = ConnectionState;

// Media state in stream.
//
enum class StreamMediaState {
  /**
   * For local stream, no data is sent to the stream
   * For remote stream, not data is received from the stream
   */
  kIdle,
  /**
   * For local stream, there is data sent to the stream
   * For remote stream, there is data received from the stream
   */
  kStreaming,
};

// Source types of tracks
//
enum class SourceType {
  /**
   * No source type is assigned, default value
   */
  kNone,
  /**
   * The track for audio from microphone
   */
  kAudio_Microphone,
  /**
   * The track is for audio from customized data
   */
  kAudio_Custom,
  /**
   * // TODO (yejun): Consider to hiden this type
   * The track is for audio from RTC track , this type helps to
   * operator RTC audio track through RTE interface
   */
  kAudio_Wrapper,
  /**
   * The track is for video from camera
   */
  kVideo_Camera,
  /**
   * The track is for video from customized data
   */
  kVideo_Custom,
  /**
   * The track is for mixing video from several video tracks
   */
  kVideo_Mix,
  /**
   * The track is for video from screen
   */
  kVideo_Screen,
  /**
   * // TODO (yejun): Consider to hiden this type
   * The track is for video from RTC track , this type helps to
   * operator RTC audio track through RTE interface
   */
  kVideo_Wrapper,
};

// Publish state of track
//
enum class PublishState {
  /**
   * The track is been publishing to stream
   */
  kPublishing,
  /**
   * The track is published to stream
   */
  kPublished,
  /**
   * The track is been unpublishing to stream
   */
  kUnpublishing,
  /**
   * The track is unpublished to stream
   */
  kUnpublished,
  /**
   * SDK failed to publish the track
   */
  kFailed,
};

// The state when subscribe remote track
//
enum class SubscribeState {
  /**
   * SDK is subscribing the remote track
   */
  kSubscribing,
  /**
   * The remote track is subscribed
   */
  kSubscribed,
  /**
   * // TODO (yejun): Confirm with team about this comment
   * Remote track is stopped
   */
  kNoSubscribe,
  /**
   * SDK failed to subscribe the remote track
   */
  kFailed,
};

// Scene types
//
enum class SceneType {
  /**
   * Adhoc scene type.
   * This scene type is using RTC connection as user manager stream. In future,
   * we could use different ways to sync user informations.
   */
  kAdhoc,
  /**
   * Compatible scene type. In this scene type, the SDK can interoperate with
   * the RTC SDK, but the user can only publish one track to the local stream.
   * Also, the RTC SDK must use string uid for successful interoperation.
   */
  kCompatible,
};

// Scene Infomation
//
struct SceneInfo {
  /**
   * Scene id.
   * This id should be unique across all scenes. For adhoc scene types,
   * the scene id could be equal with rtc channel ID
   */
  std::string scene_id;
  /**
   * Scene type
   */
  SceneType scene_type;
  /**
   * Scene state
   */
  SceneState state;
};

// User Infomation
//
struct UserInfo {
  /**
   * User id.
   * This id should be unique across all users.
   */
  std::string user_id;
  /**
   * User name.
   */
  std::string user_name;
};

// Media Stream information
//
struct StreamInfo {
  /**
   * Stream id.
   * This id should be unique across all streams.
   */
  std::string stream_id;
  /**
   * User id. Which user is the stream belongs to
   */
  std::string user_id;
};

// Stream Type Information
enum class StreamType {
  /**
   * Invalid stream type.
   */
  kInvalid,
  /**
   * RTC stream type
   */
  kRtcStream,
  /**
   * CDN stream type.
   */
  kCdnStream,
};

// Base class for Stream Options
//
struct StreamOption {
  StreamOption(StreamType input_type) : type_(input_type) {}

  virtual ~StreamOption() = default;

  StreamType GetType() const { return type_; }

 protected:
  /**
   * Stream type.
   */
  StreamType type_;
};

// RTC Stream Options
//
struct RtcStreamOptions : public StreamOption {
  RtcStreamOptions() : StreamOption(StreamType::kRtcStream), token("") {}

  RtcStreamOptions(const std::string& input_token)
    : StreamOption(StreamType::kRtcStream), token(input_token) {}

  /**
   * The token for joining scene
   */
  std::string token;

  /**
   * Determines whether to enable audio recording or playout.
   * - true: (Default) It's used to publish audio and mix microphone, or subscribe audio and playout
   * - false: It's used to publish external audio frame only without mixing microphone, or no need audio device to playout audio either
   *
   * This option is only used when create the stream.
   */
  Optional<bool> enable_audio_recording_or_playout;
};

struct DirectCdnStreamOptions : public StreamOption {
  DirectCdnStreamOptions() : StreamOption(StreamType::kCdnStream), url("") {}

  DirectCdnStreamOptions(const std::string& input_url)
    : StreamOption(StreamType::kCdnStream), url(input_url) {}

  /**
   * CDN URL address that the audio/video will be published to
   */
  std::string url;
};

// Options for subscribing video
//
struct VideoSubscribeOptions {
  /**
   * Video stream quality. Available options:
   * 1. VIDEO_STREAM_HIGH (default)
   * 2. VIDEO_STREAM_LOW
   */
  VIDEO_STREAM_TYPE type = VIDEO_STREAM_TYPE::VIDEO_STREAM_HIGH;
};

struct LogConfig {
  /**The log file path, default is NULL for default log path
   */
  std::string file_path;
  /** The log file size, KB , set 1024KB to use default log size
   */
  uint32_t file_size_in_kb = agora::commons::DEFAULT_LOG_SIZE_IN_KB;
  /** The log level, set LOG_LEVEL_INFO to use default log level
   */
  LOG_LEVEL level = LOG_LEVEL::LOG_LEVEL_WARN;
};

// SDK Profile
//
struct SdkConfig {
  /**
   * The App ID of your project.
   */
  std::string appid;
#if RTE_ANDROID
  /**
   * The app context.
   * - For Windows, it is the handle of the window that loads the video. Specify
   * this value to support plugging or unplugging the video devices while the
   * host is powered on.
   * - For Android, it is the context of activity.
   */
  void* app_context;
#endif
  /** 
   * The config for custumer set log path, log size and log level.
   */
  LogConfig log_config;

  /**
   * Set whether to enable the rtc compatibility mode 
   */
  bool enable_rtc_compatible_mode = false;
};

// Media types
//
enum class MediaType {
  /**
   * Audio media type
   */
  kAudio,
  /**
   * Video media type
   */
  kVideo,
};

// The event type for local stream
//
enum class LocalStreamEventType {
  /**
   * The first video frame published
   */
  kFirstVideoFramePublished,
  /**
   * The first audio frame published
   */
  kFirstAudioFramePublished,
  /**
   * The first video frame rendered
   */
  kFirstVideoFrameRendered,
};

// The event type for remote stream
//
enum class RemoteStreamEventType {
  /**
   * The first video frame received
   */
  kFirstVideoFrameReceived,
  /**
   * The first audio frame received
   */
  kFirstAudioFrameReceived,
  /**
   * The first video frame rendered
   */
  kFirstVideoFrameRendered,
};

// Audio observer options for local audio data
//
struct LocalAudioObserverOptions {
  /**
   * The audio frame will be captured just after it's recorded from device,
   * Observer OnRecordAudioFrame() function will be called
   */
  bool after_record = false;
  /**
   * The audio frame will be captured before we play the audio, Observer
   * OnPlaybackAudioFrame() function will be called
   */
  bool before_playback = false;
  /**
   * The audio frame will be captured before we mix the audio frame with others,
   * Observer OnMixedAudioFrame() function will be called
   */
  bool after_mix = false;
  /**
   * Set the channel of captured audio frame
   */
  size_t numberOfChannels = 1;
  /**
   * Set the sample rate of captured audio frame
   */
  uint32_t sampleRateHz = 32000;
};

// Audio observer options for remote audio data
//
struct RemoteAudioObserverOptions {
  /**
   * The audio frame will be captured before we mix the audio frame with others,
   * Observer onPlaybackAudioFrameBeforeMixing() function will be called
   */
  bool after_playback_before_mix = false;
  /**
   * Set the channel of captured audio frame
   */
  size_t numberOfChannels = 1;
  /**
   * Set the sample rate of captured audio frame
   */
  uint32_t sampleRateHz = 32000;
};

// Audio observer options
//
struct AudioObserverOptions {
  /**
   * Options for local audio frame data
   */
  LocalAudioObserverOptions local_option;
  /**
   * Options for remote audio frame data
   */
  RemoteAudioObserverOptions remote_option;
};

// State of instance, an instance stands for entity like user/media/stream, the
// instance state will be synchronized with remote server if required, then
// remote server could sync the state with all clients. remote server could
// reject the synchronization request if SDK doesn't have permission to create
// the instance.
//
enum class InstanceState {
  /**
   * SDK is trying to create the instance
   */
  kCreating,
  /**
   * SDK have created the instance
   */
  kCreated,
  /**
   * SDK have published data from the instance to network
   */
  kOnline,
  /**
   * SDK have unpublished data from the instance
   */
  kOffline,
  /**
   * SDK have destroyed the instance
   */
  kDestroyed,
};

// Configuration for the scene
//
struct SceneConfig {
  /**
   * Scene Type
   */
  SceneType scene_type = SceneType::kAdhoc;
};

// Option for joining the scene
struct JoinOptions {
  /**
   * Flag to control whether SDK notify remote peers when user joined the scene
   */
  bool is_user_visible_to_remote = true;
};

// RTE Function/Lambda definition
//
using CameraCallbackFun = std::function<void(CameraState, CameraSource)>;

/**
 * States of the CDN(rtmp) bypass streaming.
 */
enum CLOUDCDN_STREAM_PUBLISH_STATE {
  /**
   * 0: The RTMP streaming has not started or has ended.
   *
   * This state is also reported after you remove
   * an RTMP address from the CDN by calling `removePublishStreamUrl`.
   */
  CLOUDCDN_STREAM_PUBLISH_STATE_IDLE = 0,
  /**
   * 1: The SDK is connecting to the streaming server and the RTMP server.
   *
   * This state is reported after you call `addPublishStreamUrl`.
   */
  CLOUDCDN_STREAM_PUBLISH_STATE_CONNECTING = 1,
  /**
   * 2: The RTMP streaming publishes. The SDK successfully publishes the RTMP
   * streaming and returns this state.
   */
  CLOUDCDN_STREAM_PUBLISH_STATE_RUNNING = 2,
  /**
   * 3: The RTMP streaming is recovering. When exceptions occur to the CDN, or
   * the streaming is interrupted, the SDK tries to resume RTMP streaming and
   * reports this state.
   *
   * - If the SDK successfully resumes the streaming,
   * `RTMP_STREAM_PUBLISH_STATE_RUNNING(2)` is reported.
   * - If the streaming does not resume within 60 seconds or server errors
   * occur, `RTMP_STREAM_PUBLISH_STATE_FAILURE(4)` is reported. You can also
   * reconnect to the server by calling `removePublishStreamUrl` and
   * `addPublishStreamUrl`.
   */
  CLOUDCDN_STREAM_PUBLISH_STATE_RECOVERING = 3,
  /**
   * 4: The RTMP streaming fails. See the `errCode` parameter for the detailed
   * error information. You can also call `addPublishStreamUrl` to publish the
   * RTMP streaming again.
   */
  CLOUDCDN_STREAM_PUBLISH_STATE_FAILURE = 4,
};

/**
 * Error codes of the cloud CDN(RTMP) streaming.
 */
enum CLOUDCDN_STREAM_PUBLISH_ERROR {
  /**
   * -1: The RTMP streaming fails.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_FAILED = -1,
  /**
   * 0: The RTMP streaming publishes successfully.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_OK = 0,
  /**
   * 1: Invalid argument. If, for example, you did not call `setLiveTranscoding`
   * to configure the LiveTranscoding parameters before calling
   * `addPublishStreamUrl`, the SDK reports this error. Check whether you set
   * the parameters in `LiveTranscoding` properly.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_INVALID_ARGUMENT = 1,
  /**
   * 2: The RTMP streaming is encrypted and cannot be published.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_ENCRYPTED_STREAM_NOT_ALLOWED = 2,
  /**
   * 3: A timeout occurs with the RTMP streaming. Call `addPublishStreamUrl`
   * to publish the streaming again.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT = 3,
  /**
   * 4: An error occurs in the streaming server. Call `addPublishStreamUrl` to
   * publish the stream again.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_INTERNAL_SERVER_ERROR = 4,
  /**
   * 5: An error occurs in the RTMP server.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_RTMP_SERVER_ERROR = 5,
  /**
   * 6: The RTMP streaming publishes too frequently.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_TOO_OFTEN = 6,
  /**
   * 7: The host publishes more than 10 URLs. Delete the unnecessary URLs before
   * adding new ones.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_REACH_LIMIT = 7,
  /**
   * 8: The host manipulates other hosts' URLs. Check your app logic.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_NOT_AUTHORIZED = 8,
  /**
   * 9: The Agora server fails to find the RTMP streaming.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_STREAM_NOT_FOUND = 9,
  /**
   * 10: The format of the RTMP streaming URL is not supported. Check whether
   * the URL format is correct.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_FORMAT_NOT_SUPPORTED = 10,
  /**
   * 11: CDN related errors. Remove the original URL address and add a new one
   * by calling `removePublishStreamUrl` and `addPublishStreamUrl`.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_CDN_ERROR = 11,
  /**
   * 12: Resources are occupied and cannot be reused.
   */
  CLOUDCDN_STREAM_PUBLISH_ERROR_ALREADY_IN_USE = 12,
};

struct SceneStats {
  /**
   * The total number of bytes transmitted, represented by an aggregate value.
   * The sum of all streams.
   */
  int txBytes;
  /**
   * The total number of bytes received, represented by an aggregate value.
   * The sum of all streams.
   */
  int rxBytes;
  /**
   * The total number of audio bytes sent (bytes), represented by an aggregate value.
   * The sum of all streams.
   */
  int txAudioBytes;
  /**
   * The total number of video bytes sent (bytes), represented by an aggregate value.
   * The sum of all streams.
   */
  int txVideoBytes;
  /**
   * The total number of audio bytes received (bytes), represented by an aggregate value.
   * The sum of all streams.
   */
  int rxAudioBytes;
  /**
   * The total number of video bytes received (bytes), represented by an aggregate value.
   * The sum of all streams.
   */
  int rxVideoBytes;
  /**
   * The transmission bitrate (Kbps), represented by an instantaneous value.
   * The sum of all streams.
   */
  int txKBitRate;
  /**
   * The receiving bitrate (Kbps), represented by an instantaneous value.
   * The sum of all streams.
   */
  int rxKBitRate;
  /**
   * The audio transmission bitrate (Kbps), represented by an instantaneous value.
   * The sum of all streams.
   */
  int txAudioKBitRate;
  /**
   * Audio receiving bitrate (Kbps), represented by an instantaneous value.
   * The sum of all streams.
   */
  int rxAudioKBitRate;
  /**
   * The video transmission bitrate (Kbps), represented by an instantaneous value.
   * The sum of all streams.
   */
  int txVideoKBitRate;
  /**
   * The video receive bitrate (Kbps), represented by an instantaneous value.
   * The sum of all streams.
   */
  int rxVideoKBitRate;
  /**
   * The call duration (s), represented by an aggregate value.
   * The sum of all streams.
   */
  unsigned int duration;
  /**
   * The system CPU usage (%).
   * Only the value of major stream.
   */
  double cpuTotalUsage;
  /**
   * The app CPU usage (%).
   * Only the value of major stream.
   */
  double cpuAppUsage;
  /**
   * The memory usage ratio of the app (%).
   * Only the value of major stream.
   */
  double memoryAppUsageRatio;
  /**
   * The memory usage ratio of the system (%).
   * Only the value of major stream.
   */
  double memoryTotalUsageRatio;
  /**
   * The memory usage of the app (KB).
   * Only the value of major stream.
   */
  int memoryAppUsageInKbytes;
};

/**
 * Statistics of the local audio stream.
 */
struct RteLocalAudioStats {
  /**
   * The number of audio channels.
   */
  int numChannels;
  /**
   * The sample rate (Hz).
   */
  int sentSampleRate;
  /**
   * The average sending bitrate (Kbps).
   */
  int sentBitrate;
  /**
   * The internal payload type
   */
  int internalCodec;
};

/**
 * Statistics of the local video stream.
 */
struct RteLocalVideoStats {
  /**
   * The encoder output frame rate (fps) of the local video.
   */
  int encoderOutputFrameRate;
  /**
   * The render output frame rate (fps) of the local video.
   */
  int rendererOutputFrameRate;
  /**
   * The width of the encoding frame (px).
   */
  int encodedFrameWidth;
  /**
   * The height of the encoding frame (px).
   */
  int encodedFrameHeight;
  /**
   * The value of the sent frames, represented by an aggregate value.
   */
  int encodedFrameCount;
};

/**
 * Statistics of the remote audio stream.
 */
struct RteRemoteAudioStats {
  /**
   * The quality of the remote audio: #QUALITY_TYPE.
   */
  int quality;
  /**
   * The network delay (ms) from the sender to the receiver.
   */
  int networkTransportDelay;
  /**
   * The network delay (ms) from the receiver to the jitter buffer.
   */
  int jitterBufferDelay;
  /**
   * The audio frame loss rate in the reported interval.
   */
  int audioLossRate;
  /**
   * The number of channels.
   */
  int numChannels;
  /**
   * The sample rate (Hz) of the remote audio stream in the reported interval.
   */
  int receivedSampleRate;
  /**
   * The average bitrate (Kbps) of the remote audio stream in the reported
   * interval.
   */
  int receivedBitrate;
  /**
   * The total freeze time (ms) of the remote audio stream after the remote
   * user joins the channel.
   *
   * In a session, audio freeze occurs when the audio frame loss rate reaches 4%.
   */
  int totalFrozenTime;
  /**
   * The total audio freeze time as a percentage (%) of the total time when the
   * audio is available.
   */
  int frozenRate;
  /**
   * The quality of the remote audio stream as determined by the Agora
   * real-time audio MOS (Mean Opinion Score) measurement method in the
   * reported interval. The return value ranges from 0 to 500. Dividing the
   * return value by 100 gets the MOS score, which ranges from 0 to 5. The
   * higher the score, the better the audio quality.
   *
   * | MOS score       | Perception of audio quality                                                                                                                                 |
   * |-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
   * | Greater than 4  | Excellent. The audio sounds clear and smooth.                                                                                                               |
   * | From 3.5 to 4   | Good. The audio has some perceptible impairment, but still sounds clear.                                                                                    |
   * | From 3 to 3.5   | Fair. The audio freezes occasionally and requires attentive listening.                                                                                      |
   * | From 2.5 to 3   | Poor. The audio sounds choppy and requires considerable effort to understand.                                                                               |
   * | From 2 to 2.5   | Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting in some information loss. The users can communicate only with difficulty.  |
   * | Less than 2     | Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting in severe information loss. Communication is nearly impossible. |
   */
  int mosValue;
};

/**
 * Statistics of the remote video stream.
 */
struct RteRemoteVideoStats {
  /**
   * @deprecated Time delay (ms).
   *
   * In scenarios where audio and video is synchronized, you can use the
   * value of `networkTransportDelay` and `jitterBufferDelay` in `RemoteAudioStats`
   * to know the delay statistics of the remote video.
   */
  int delay;
  /**
   * The width (pixels) of the video stream.
   */
  int width;
  /**
   * The height (pixels) of the video stream.
   */
  int height;
  /**
   * Bitrate (Kbps) received since the last count.
   */
  int receivedBitrate;
  /**
   * The decoder output frame rate (fps) of the remote video.
   */
  int decoderOutputFrameRate;
  /**
   * The render output frame rate (fps) of the remote video.
   */
  int rendererOutputFrameRate;
  /**
   * The video frame loss rate (%) of the remote video stream in the reported interval.
   */
  int frameLossRate;
  /**
   * Packet loss rate (%) of the remote video stream after using the anti-packet-loss method.
   */
  int packetLossRate;
  /**
   * The type of the remote video stream: #VIDEO_STREAM_TYPE.
   */
  VIDEO_STREAM_TYPE rxStreamType;
  /**
   * The total freeze time (ms) of the remote video stream after the remote user joins the channel.
   * In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when
   * the time interval between two adjacent renderable video frames is more than 500 ms.
   */
  int totalFrozenTime;
  /**
   * The total video freeze time as a percentage (%) of the total time when the video is available.
   */
  int frozenRate;
  /**
   * The offset (ms) between audio and video stream. A positive value indicates the audio leads the
   * video, and a negative value indicates the audio lags the video.
   */
  int avSyncTimeMs;
  /**
   * The SuperResolution stats. 0 is not ok. >0 is ok. 
   */
  int superResolutionType;
};

const std::string kExtensionPropertyEnabledKey = "key_enabled_extension";
const std::string kExtensionPropertyEnabledValue = "value_enabled_extension";
const std::string kExtensionPropertyDisabledValue = "value_disabled_extension";

}  // namespace rte
}  // namespace agora
