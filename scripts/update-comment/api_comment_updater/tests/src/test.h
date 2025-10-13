//
//  Agora SDK
//
#pragma once // NOLINT(build/header_guard)

namespace agora {
namespace rtc {

class IRtcEngine : public agora::base::IEngineBase {
  public:

};


/**
 * @brief Options for handling audio and video stream fallback when network conditions are weak.
 */
enum STREAM_FALLBACK_OPTIONS {
  /**
   * 0: No fallback processing is performed on audio and video streams, the quality of the audio and
   * video streams cannot be guaranteed.
   */
  STREAM_FALLBACK_OPTION_DISABLED = 0,
  /**
   * 1: Only receive low-quality (low resolution, low bitrate) video stream.
   */
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LOW = 1,
  /**
   * 2: When the network conditions are weak, try to receive the low-quality video stream first. If
   * the video cannot be displayed due to extremely weak network environment, then fall back to
   * receiving audio-only stream.
   */
  STREAM_FALLBACK_OPTION_AUDIO_ONLY = 2,
  /** 3~8: If the receiver SDK uses RtcEngineParameters::setRemoteSubscribeFallbackOption，it will receive
     one of the streams from agora::rtc::VIDEO_STREAM_LAYER_1 to agora::rtc::VIDEO_STREAM_LAYER_6
     if the related layer exists when the network condition is poor. The lower bound of fallback depends on
     the STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_X. */
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_1 = 3,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_2 = 4,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_3 = 5,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_4 = 6,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_5 = 7,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_6 = 8,
};


/**
 * The video noise reduction options.
 *
 * @since v4.0.0
 */
struct VideoDenoiserOptions {
  /**
   * @brief Video noise reduction mode.
   */
  enum VIDEO_DENOISER_MODE {
    /**
     * 0: (Default) Automatic mode. The SDK automatically enables or disables the video noise reduction
     * feature according to the ambient light.
     */
    VIDEO_DENOISER_AUTO = 0,
    /**
     * 1: Manual mode. Users need to enable or disable the video noise reduction feature manually.
     */
    VIDEO_DENOISER_MANUAL = 1,
  };
  /**
   * The video noise reduction level.
   */
  enum VIDEO_DENOISER_LEVEL {
    /**
     * 0: (Default) Promotes video quality during video noise reduction. `HIGH_QUALITY` balances
     * performance consumption and video noise reduction quality. The performance consumption is
     * moderate, the video noise reduction speed is moderate, and the overall video quality is
     * optimal.
     */
    VIDEO_DENOISER_LEVEL_HIGH_QUALITY = 0,
    /**
     * Promotes reducing performance consumption during video noise reduction. `FAST` prioritizes
     * reducing performance consumption over video noise reduction quality. The performance
     * consumption is lower, and the video noise reduction speed is faster. To avoid a noticeable
     * shadowing effect (shadows trailing behind moving objects) in the processed video, Agora
     * recommends that you use `FAST` when the camera is fixed.
     */
    VIDEO_DENOISER_LEVEL_FAST = 1,
  };
  /** The video noise reduction mode. See #VIDEO_DENOISER_MODE.
   */
  VIDEO_DENOISER_MODE mode;

  /** The video noise reduction level. See #VIDEO_DENOISER_LEVEL.
   */
  VIDEO_DENOISER_LEVEL level;

  VideoDenoiserOptions(VIDEO_DENOISER_MODE denoiserMode, VIDEO_DENOISER_LEVEL denoiserLevel)
      : mode(denoiserMode), level(denoiserLevel) {}

  VideoDenoiserOptions() : mode(VIDEO_DENOISER_AUTO), level(VIDEO_DENOISER_LEVEL_HIGH_QUALITY) {}
};

}  // namespace commons
}  // namespace agora



#undef OPTIONAL_LOG_LEVEL_SPECIFIER