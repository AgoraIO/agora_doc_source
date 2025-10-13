//
//  Agora SDK
//
#pragma once // NOLINT(build/header_guard)

namespace agora {
namespace rtc {

class IRtcEngine : public agora::base::IEngineBase {
  public:
  /*
   * Adjust the playback volume of the user specified by uid.
   *
   * You can call this method to adjust the playback volume of the user specified by uid
   * in call. If you want to adjust playback volume of the multi user, you can call this
   * this method multi times.
   *
   * @note
   * Please call this method after join channel.
   * This method adjust the playback volume of specified user.
   *
   * @param uid Remote user ID.
   * @param volume The playback volume of the specified remote user. The value ranges between 0 and 400, including the following:
   * 0: Mute.
   * 100: (Default) Original volume.
   * 400: Four times the original volume with signal-clipping protection.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustUserPlaybackSignalVolume(uid_t uid, int volume) = 0;

};

/**
 * The audio configuration for the shared screen stream.
 */
struct ScreenAudioParameters {
  /**
   * The audio sample rate (Hz). The default value is `16000`.
   */
  int sampleRate = 16000;
  /**
   * The number of audio channels. The default value is `2`, indicating dual channels.
   */
  int channels = 2;
  /**
   * The volume of the captured system audio. The value range is [0,100]. The default value is
   * `100`.
   */
  int captureSignalVolume = 100;
};

/**
 * The latency level of an audience member in interactive live streaming. This enum takes effect
 * only when the user role is set to `CLIENT_ROLE_AUDIENCE`.
 */
enum AUDIENCE_LATENCY_LEVEL_TYPE {
  /**
   * 1: Low latency.
   */
  AUDIENCE_LATENCY_LEVEL_LOW_LATENCY = 1,
  /**
   * 2: Ultra low latency.
   */
  AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY = 2,
};

}  // namespace commons
}  // namespace agora

#undef OPTIONAL_LOG_LEVEL_SPECIFIER