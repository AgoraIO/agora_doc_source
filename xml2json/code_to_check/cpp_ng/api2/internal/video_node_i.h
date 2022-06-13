//
//  Agora Media SDK
//
//  Created by Sting Feng in 2015-05.
//  Copyright (c) 2015 Agora IO. All rights reserved.
//
#pragma once

#include <memory>
#include <string>
#include <vector>

#include "AgoraRefPtr.h"

#include "NGIAgoraCameraCapturer.h"
#include "NGIAgoraVideoMixerSource.h"
#include "NGIAgoraScreenCapturer.h"
#include "NGIAgoraMediaNodeFactory.h"
#include "NGIAgoraMediaNode.h"
#include "modules/desktop_capture/desktop_capturer.h"
#include "api/video/video_frame.h"

namespace webrtc {
class VideoFrame;
}  // namespace webrtc

namespace rtc {
struct VideoSinkWants;

template <typename VideoFrameT>
class VideoSinkInterface;
}  // namespace rtc

namespace agora {
namespace rtc {

enum InternalRendererType {
  RENDERER_NONE = -1,
  RENDERER_BUILT_IN_RENDERER = 0,
  RENDERER_EXT_OBSERVER = 3,
};

struct PreviewMetaInfo {
  uintptr_t handle;
  bool mirror;
  media::base::RENDER_MODE_TYPE render_mode;
};

static const char* const BUILT_IN_METADATA_OBSERVER = "built-in-metadata-observer";
static const char* const BUILT_IN_ADAPTER = "built-in-adapter";
static const char* const BUILT_IN_WATERMARK_FILTER = "built-in-watermarker";
static const char* const BUILT_IN_PREVIEW_TEE = "built-in-preview-tee";
static const char* const BUILT_IN_MAJOR_TEE = "built-in-major-tee";
static const char* const BUILT_IN_MINOR_TEE = "built-in-minor-tee";
static const char* const BUILT_IN_MINOR_ADAPTER = "built-in-minor-adapter";

/** Filter definition for internal pipeline usage.
 */
class IVideoFilterEx : public IVideoFilter {
 public:
  using IVideoFilter::adaptVideoFrame;
  // Internal node can use webrtc video frame directly to reduce copy operation.
  virtual bool adaptVideoFrame(const webrtc::VideoFrame& capturedFrame,
                               webrtc::VideoFrame& adaptedFrame) = 0;
  // TODO(Bob): This should be moved to node base.
  virtual void onSinkWantsChanged(const ::rtc::VideoSinkWants& wants) = 0;
  bool isExternal() override { return false; }
  virtual void attachStatsSpace(uint64_t stats_space) {}

 protected:
  ~IVideoFilterEx() {}
};

/** Video frame adapter.
 */
class IVideoFrameAdapter : public IVideoFilterEx {
 public:
  // Requests the output frame size and frame interval from
  // |AdaptFrameResolution| to not be larger than |format|. Also, the input
  // frame size will be cropped to match the requested aspect ratio. When "fixed"
  // is set false, the requested aspect ratio is orientation agnostic
  // and will be adjusted to maintain the input orientation, so it doesn't matter
  // if e.g. 1280x720 or 720x1280 is requested. Otherwise, the output format is
  // fixed. The input frame may be cropped and rotated to meet the output format.
  virtual void setOutputFormat(const VideoFormat& format, bool fixed = false) = 0;

  // Request the output frame in a fixed rotation.
  virtual void setOutputRotation(webrtc::VideoRotation rotation) {}

  // mirror the frame
  virtual void setMirror(bool mirror) {}

  protected:
   ~IVideoFrameAdapter() {}
};

enum CAMERA_OUTPUT_DATA_TYPE {
    CAMERA_OUTPUT_RAW = 0,              // YUV
    CAMERA_OUTPUT_TEXTURE = 1,          // Texture
    CAMERA_OUTPUT_TEXTURE_AND_RAW = 2,  // YUV && Texture
};

class ICameraCapturerEx : public ICameraCapturer {
 public:
  virtual ~ICameraCapturerEx() {}

#if defined(__ANDROID__) || defined(TARGET_OS_IPHONE)
  virtual void setPreviewInfo(const PreviewMetaInfo& info) {}
#endif

#if defined(__ANDROID__)
  virtual void setCameraOutputDataType(CAMERA_OUTPUT_DATA_TYPE type) = 0;
  virtual CAMERA_OUTPUT_DATA_TYPE getCameraOutputDataType() = 0;
  virtual void setCameraSelected(int module_selected) = 0;
  virtual void setCameraSelectedLevel(int camera_selected_level) = 0;  
  virtual void setCameraPqFirst(bool pq_first) = 0;
#endif

#if defined(WEBRTC_IOS)
  virtual void setCameraDropCount(int dropcount) = 0;
#endif

#if defined(_WIN32) || (defined(__linux__) && !defined(__ANDROID__)) || \
    (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
  virtual std::string getDeviceId() = 0;
#endif
  virtual void enableRegulator(bool enable) = 0;
};

class IScreenCapturerEx : public IScreenCapturer {
public:
    enum SCREEN_CAPTURER_STATE {
        SCREEN_CAPTURER_STARTED,
        SCREEN_CAPTURER_STOPPED,
    };
 public:
  virtual ~IScreenCapturerEx() {}
  virtual int StartCapture() = 0;
  virtual int StopCapture() = 0;
  virtual void SetFrameRate(int rate) = 0;
  virtual void RegisterCaptureDataCallback(
      std::weak_ptr<::rtc::VideoSinkInterface<webrtc::VideoFrame>> dataCallback) = 0;
  virtual int CaptureMouseCursor(bool capture) = 0;
  virtual int GetScreenDimensions(VideoDimensions& dimension) = 0;
  virtual bool FocusOnSelectedSource() = 0;

#if defined(_WIN32)
  virtual int InitUsingLastRegionSetting() = 0;
  virtual int InitUsingLastScreenSetting(const rtc::Rectangle& regionRect) = 0;
  virtual void SetCaptureSource(bool allow_magnification_api, bool allow_directx_capturer) = 0;
  virtual void GetCaptureSource(bool& allow_magnification_api, bool& allow_directx_capturer) = 0;
#endif // _WIN32

#if defined(_WIN32) || (defined(WEBRTC_MAC) && !defined(WEBRTC_IOS))
  virtual void ForcedUsingScreenCapture(bool using_screen_capture) = 0;
#endif // _WIN32 || (WEBRTC_MAC&&!WEBRTC_IOS)

#if defined(_WIN32)
  virtual void SetExcludeWindowList(const std::vector<void *>& window_list) = 0;
  virtual webrtc::DesktopCapturer::SourceId GetSourceId() = 0;
  virtual int GetCaptureType() = 0;
#endif // _WIN32
    virtual int registerScreenCaptureObserver(IScreenCaptureObserver* observer) {
        return -ERR_NOT_SUPPORTED;
    }
    virtual int unregisterScreenCaptureObserver(IScreenCaptureObserver* observer) {
        return -ERR_NOT_SUPPORTED;
    }
};

class IScreenCaptureObserver {
public:
    virtual void onScreenCaptureStateChanged(IScreenCapturerEx::SCREEN_CAPTURER_STATE state) {
        (void) state;
    }
protected:
    virtual ~IScreenCaptureObserver() {}
};

class IVideoRendererEx : public IVideoRenderer {
 public:
  using IVideoRenderer::onFrame;
  virtual int onFrame(const webrtc::VideoFrame& videoFrame) {
    (void)videoFrame;
    return -ERR_NOT_SUPPORTED;
  };

  int setView(void* view) override{
    (void) view;
    return -ERR_NOT_SUPPORTED;
  };

  int addView(void* view, const Rectangle& cropArea) override {
    (void) view;
    (void) cropArea;
    return -ERR_NOT_SUPPORTED;
  };

  int removeView(void* view) override {
    (void) view;
    return -ERR_NOT_SUPPORTED;
  };

  virtual int addViewEx(uintptr_t handle, const Rectangle& cropArea) {
    (void) handle;
    (void) cropArea;
    return -ERR_NOT_SUPPORTED;
  };

  virtual int addViewEx(uintptr_t handle) {
    (void) handle;
    return -ERR_NOT_SUPPORTED;
  };

  virtual int removeViewEx(uintptr_t handle) {
    (void) handle;
    return unsetView();
  };

  int setRenderMode(void* view, media::base::RENDER_MODE_TYPE renderMode) override {
    (void) view;
    (void) renderMode;
    return -ERR_NOT_SUPPORTED;
  };

  int setMirror(void* view, bool mirror) override {
    (void) view;
    (void) mirror;
    return -ERR_NOT_SUPPORTED;
  };

  using IVideoRenderer::setRenderMode;
  virtual int setRenderModeEx(uintptr_t handle, media::base::RENDER_MODE_TYPE renderMode){
    (void) handle;
    return setRenderMode(renderMode);
  }

  using IVideoRenderer::setMirror;
  virtual int setMirrorEx(uintptr_t handle, bool mirror){
    (void) handle;
    return setMirror(mirror);
  }

  virtual void attachUserInfo(uid_t uid, uint64_t state_space) {
    (void) uid;
    (void) state_space;
  }

  virtual int getViewMetaInfo(PreviewMetaInfo& info) {
    (void) info;
    return -ERR_NOT_SUPPORTED;
  }

  virtual int getViewMetaInfo(uintptr_t handle, PreviewMetaInfo& info) {
    (void) handle;
    (void) info;
    return -ERR_NOT_SUPPORTED;
  }

  virtual int getViewCount() {
    return -ERR_NOT_SUPPORTED;
  }
};

struct VideoEncodedImageData : public RefCountInterface {
  std::string image;
  VIDEO_FRAME_TYPE frameType;
  int width;
  int height;
  int framesPerSecond;
  // int64_t renderTimeInMs;
  VIDEO_ORIENTATION rotation;
  VIDEO_CODEC_TYPE codec;
  VIDEO_STREAM_TYPE streamType;
  int64_t captureTimeMs;
  int64_t decodeTimeMs;
};

struct CameraInfo {
  bool inUse;
  std::string deviceName;
  std::string deviceId;
};
using CameraInfoList = std::vector<CameraInfo>;

class IVideoEncodedImageCallback {
 public:
  virtual ~IVideoEncodedImageCallback() {}
  virtual void OnVideoEncodedImage(agora_refptr<VideoEncodedImageData> data) = 0;
};

class IVideoEncodedImageSenderEx : public IVideoEncodedImageSender {
 public:
  virtual ~IVideoEncodedImageSenderEx() {}
  virtual void RegisterEncodedImageCallback(IVideoEncodedImageCallback* dataCallback) = 0;
  virtual void DeRegisterEncodedImageCallback() = 0;
  virtual int getWidth() const  =0;
  virtual int getHeight() const =0;
};

class IVideoFrameSenderEx : public IVideoFrameSender {
 public:
  using IVideoFrameSender::sendVideoFrame;

  virtual ~IVideoFrameSenderEx() {}

  virtual int sendVideoFrame(const webrtc::VideoFrame& videoFrame) = 0;

  virtual void RegisterVideoFrameCallback(
      ::rtc::VideoSinkInterface<webrtc::VideoFrame>* dataCallback) = 0;
  virtual void DeRegisterVideoFrameCallback() = 0;

  virtual int getVideoFrame(webrtc::VideoFrame& videoFrame) = 0;
  virtual bool pushMode() = 0;
};

class IVideoMixerSourceEx : public IVideoMixerSource {
 public:
  virtual ~IVideoMixerSourceEx() = default;
  virtual void registerMixedFrameCallback(
        ::rtc::VideoSinkInterface<webrtc::VideoFrame>* dataCallback) = 0;
  virtual void deRegisterMixedFrameCallback(::rtc::VideoSinkInterface<webrtc::VideoFrame>* dataCallback) = 0;
  virtual void onFrame(const std::string& uid, const webrtc::VideoFrame& frame) = 0;
  virtual void startMixing() = 0;
  virtual void stopMixing() = 0;
  virtual bool hasVideoTrack(const std::string& id) = 0;
};

class IVideoFrameTransceiverEx : public IVideoFrameTransceiver {
 public:
  virtual int onFrame(const webrtc::VideoFrame& videoFrame) = 0;
  virtual void registerFrameCallback(
      ::rtc::VideoSinkInterface<webrtc::VideoFrame>* dataCallback) = 0;
  virtual void deRegisterFrameCallback(::rtc::VideoSinkInterface<webrtc::VideoFrame>* dataCallback) = 0;
  virtual void observeTxDelay(ILocalVideoTrack* track) = 0;
};

class IExtensionVideoFilterControlEx : public IExtensionVideoFilter::Control {
 public:
  virtual ~IExtensionVideoFilterControlEx() = default;
  virtual int ReportCounter(int32_t counter_id, int32_t value) = 0;
  virtual int ReportEvent(int32_t event_id, void* event) = 0;
};

}  // namespace rtc
}  // namespace agora
