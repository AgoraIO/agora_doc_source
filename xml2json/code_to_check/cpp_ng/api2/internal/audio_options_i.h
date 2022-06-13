//  Agora SDK
//
//  Copyright (c) 2019 Agora.io. All rights reserved.
//  Reference from WebRTC project
//
#pragma once

#include <string>

#include "AgoraOptional.h"

#define SET_FROM(X) SetFrom(&X, change.X)

#define BEGIN_COMPARE() bool b = true
#define ADD_COMPARE(X) b = (b && (X == o.X))
#define END_COMPARE_AND_RETURN() \
  ;                              \
  return b

#define UNPUBLISH(X) X.reset()

namespace agora {
namespace rtc {

/**
 * OpenSL mode
 */
enum OPENSL_MODE {
  /**
   * always on
   */
  ALWAYS_ON,

  /**
   * always off
   */
  ALWAYS_OFF,

  /**
   * on with headset
   */
  ON_WITH_HEADSET,
};

// Options that can be applied to an audio track or audio engine.
struct AudioOptions {
  AudioOptions() = default;
  ~AudioOptions() = default;

  void SetAll(const AudioOptions& change) {
    SET_FROM(audio_scenario);
    SET_FROM(audio_routing);
    SET_FROM(opensl_mode);
    SET_FROM(adm_enable_estimated_device_delay);
    SET_FROM(adm_enable_preferred_aec_delay);
    SET_FROM(adm_enable_oboe);
    SET_FROM(has_published_stream);
    SET_FROM(has_subscribed_stream);

    SET_FROM(adm_mix_option_selected);
    SET_FROM(adm_input_sample_rate);
    SET_FROM(adm_output_sample_rate);
    SET_FROM(adm_input_channels);
    SET_FROM(adm_output_channels);
    SET_FROM(adm_has_recorded);
    SET_FROM(adm_force_use_bluetooth_a2dp);
    SET_FROM(adm_use_bluetooth_hfp);
    SET_FROM(adm_use_hw_aec);
    SET_FROM(adm_enable_hardware_ear_monitor);
    SET_FROM(adm_force_restart);
    SET_FROM(adm_audio_layer);
    SET_FROM(adm_audio_source);
    SET_FROM(adm_playout_bufsize_factor);
  
    SET_FROM(apm_process_channels);

    SET_FROM(apm_enable_aec);
    SET_FROM(apm_enable_ns);
    SET_FROM(apm_ains_mode);
    SET_FROM(apm_ains_gain_control);
    SET_FROM(apm_ains_speech_enhance);
    SET_FROM(apm_enable_agc);
    SET_FROM(apm_enable_md);
    SET_FROM(apm_aimd_value);
    SET_FROM(apm_enable_highpass_filter);
    SET_FROM(apm_enable_tone_remover);
    SET_FROM(apm_enable_pitch_smoother);
    SET_FROM(apm_enable_howling_control);
    SET_FROM(apm_delay_offset_ms);
    SET_FROM(apm_aec_suppression_level);
    SET_FROM(apm_aec_delay_type);
    SET_FROM(apm_aec_nlp_linear_partition);
    SET_FROM(apm_aec_nlp_aggressiveness);
    SET_FROM(apm_agc_target_level_dbfs);
    SET_FROM(apm_agc_compression_gain_db);
    SET_FROM(apm_agc_mode);
    SET_FROM(apm_ns_enable_ns_follow_agc);
    SET_FROM(apm_ns_level);
    SET_FROM(apm_ns_noiseGateThres);
    SET_FROM(apm_enable_dtd);

    SET_FROM(acm_bitrate);
    SET_FROM(acm_codec);
    SET_FROM(acm_dtx);
    SET_FROM(acm_plc);
    SET_FROM(acm_complex_level);
    SET_FROM(acm_ptime);
    SET_FROM(acm_hw_encode_opus);
    SET_FROM(acm_hw_decode_opus);

    SET_FROM(audio_resend);
    SET_FROM(audio_rsfec_frame_num);
    SET_FROM(audio_rsfec_interleave_num);
    SET_FROM(audio_fec_frame_num);
    SET_FROM(audio_fec_interleave_num);

    SET_FROM(neteq_live_min_delay);
    SET_FROM(neteq_jitter_buffer_max_packets);
    SET_FROM(neteq_jitter_buffer_fast_accelerate);
    SET_FROM(neteq_jitter_max_target_delay);
    SET_FROM(neteq_target_level_optimization);
    SET_FROM(neteq_aqm_voice_threshold);
    SET_FROM(neteq_dump_level);
    SET_FROM(neteq_dump_path);
    SET_FROM(neteq_limit_prob);
    SET_FROM(dwlink_gain);
    SET_FROM(uplink_gain);
    SET_FROM(derived_headset_black_list_device);
#if defined(WEBRTC_IOS) || defined(WEBRTC_ANDROID)
    SET_FROM(use_media_volume_in_headset);
    SET_FROM(use_media_volume_in_audience);
    SET_FROM(use_media_volume_in_solo);
    SET_FROM(use_media_volume_in_bluetooth);
#endif // defined(WEBRTC_IOS) || defined(WEBRTC_ANDROID)
  }

  bool operator==(const AudioOptions& o) const {
    BEGIN_COMPARE();
    ADD_COMPARE(audio_scenario);
    ADD_COMPARE(audio_routing);
    ADD_COMPARE(opensl_mode);
    ADD_COMPARE(adm_enable_estimated_device_delay);
    ADD_COMPARE(adm_enable_preferred_aec_delay);
    ADD_COMPARE(adm_enable_oboe);
    ADD_COMPARE(has_published_stream);
    ADD_COMPARE(has_subscribed_stream);

    ADD_COMPARE(adm_mix_option_selected);
    ADD_COMPARE(adm_input_sample_rate);
    ADD_COMPARE(adm_output_sample_rate);
    ADD_COMPARE(adm_input_channels);
    ADD_COMPARE(adm_output_channels);
    ADD_COMPARE(adm_has_recorded);
    ADD_COMPARE(adm_force_use_bluetooth_a2dp);
    ADD_COMPARE(adm_use_bluetooth_hfp);
    ADD_COMPARE(adm_use_hw_aec);
    ADD_COMPARE(adm_enable_hardware_ear_monitor);
    ADD_COMPARE(adm_force_restart);
    ADD_COMPARE(adm_audio_layer);
    ADD_COMPARE(adm_audio_source);
    ADD_COMPARE(adm_playout_bufsize_factor);

    ADD_COMPARE(apm_process_channels);

    ADD_COMPARE(apm_enable_aec);
    ADD_COMPARE(apm_enable_ns);
    ADD_COMPARE(apm_ains_mode);
    ADD_COMPARE(apm_ains_gain_control);
    ADD_COMPARE(apm_ains_speech_enhance);
    ADD_COMPARE(apm_enable_agc);
    ADD_COMPARE(apm_enable_md);
    ADD_COMPARE(apm_aimd_value);
    ADD_COMPARE(apm_enable_highpass_filter);
    ADD_COMPARE(apm_enable_tone_remover);
    ADD_COMPARE(apm_enable_pitch_smoother);
    ADD_COMPARE(apm_enable_howling_control);
    ADD_COMPARE(apm_delay_offset_ms);
    ADD_COMPARE(apm_aec_suppression_level);
    ADD_COMPARE(apm_aec_delay_type);
    ADD_COMPARE(apm_aec_nlp_linear_partition);
    ADD_COMPARE(apm_aec_nlp_aggressiveness);
    ADD_COMPARE(apm_agc_target_level_dbfs);
    ADD_COMPARE(apm_agc_compression_gain_db);
    ADD_COMPARE(apm_agc_mode);
    ADD_COMPARE(apm_ns_enable_ns_follow_agc);
    ADD_COMPARE(apm_ns_level);
    ADD_COMPARE(apm_ns_noiseGateThres);
    ADD_COMPARE(apm_enable_dtd);

    ADD_COMPARE(acm_bitrate);
    ADD_COMPARE(acm_codec);
    ADD_COMPARE(acm_dtx);
    ADD_COMPARE(acm_plc);
    ADD_COMPARE(acm_complex_level);
    ADD_COMPARE(acm_ptime);
    ADD_COMPARE(acm_hw_encode_opus);
    ADD_COMPARE(acm_hw_decode_opus);

    ADD_COMPARE(audio_resend);
    ADD_COMPARE(audio_rsfec_frame_num);
    ADD_COMPARE(audio_rsfec_interleave_num);    
    ADD_COMPARE(audio_fec_frame_num);
    ADD_COMPARE(audio_fec_interleave_num);

    ADD_COMPARE(neteq_live_min_delay);
    ADD_COMPARE(neteq_jitter_buffer_max_packets);
    ADD_COMPARE(neteq_jitter_buffer_fast_accelerate);
    ADD_COMPARE(neteq_jitter_max_target_delay);
    ADD_COMPARE(neteq_target_level_optimization);
    ADD_COMPARE(neteq_aqm_voice_threshold);
    ADD_COMPARE(neteq_dump_level);
    ADD_COMPARE(neteq_dump_path);
    ADD_COMPARE(neteq_limit_prob);
    ADD_COMPARE(dwlink_gain);
    ADD_COMPARE(uplink_gain);
    ADD_COMPARE(derived_headset_black_list_device);
#if defined(WEBRTC_IOS) || defined(WEBRTC_ANDROID)
    ADD_COMPARE(use_media_volume_in_headset);
    ADD_COMPARE(use_media_volume_in_audience);
    ADD_COMPARE(use_media_volume_in_solo);
    ADD_COMPARE(use_media_volume_in_bluetooth);
#endif // defined(WEBRTC_IOS) || defined(WEBRTC_ANDROID)
    END_COMPARE_AND_RETURN();
  }

  AudioOptions& Filter() {
    UNPUBLISH(derived_headset_black_list_device);
    return *this;
  }

  bool operator!=(const AudioOptions& o) const { return !(*this == o); }

  Optional<uint32_t> audio_scenario;  // agora::rtc::AUDIO_SCENARIO_TYPE
  Optional<uint32_t> audio_routing;  // agora::rtc::AudioRoute
  Optional<uint32_t> opensl_mode; // agora::rtc::OPENSL_MODE
  Optional<bool> adm_enable_estimated_device_delay;
  Optional<bool> adm_enable_preferred_aec_delay;
  Optional<bool> adm_enable_oboe;
  Optional<bool> has_published_stream;
  Optional<bool> has_subscribed_stream;

  // ios::AVAudioSessionCategoryOptionMixWithOthers
  Optional<uint32_t> adm_mix_option_selected;
  Optional<uint32_t> adm_input_sample_rate;
  Optional<uint32_t> adm_output_sample_rate;
  Optional<uint32_t> adm_input_channels;
  Optional<uint32_t> adm_output_channels;
  Optional<bool> adm_has_recorded;

  // ios::AVAudioSessionCategoryOptionAllowBluetoothA2DP
  Optional<bool> adm_force_use_bluetooth_a2dp;
  Optional<bool> adm_use_bluetooth_hfp;
  Optional<bool> adm_use_hw_aec;
  Optional<bool> adm_enable_hardware_ear_monitor;

  Optional<bool> adm_force_restart;

  Optional<uint32_t> adm_audio_layer;
  Optional<uint32_t> adm_audio_source; //for android
  Optional<float> adm_playout_bufsize_factor; //for android

  Optional<int> apm_process_channels; // agora::media::base::AUDIO_PROCESS_CHANNELS

  Optional<bool> apm_enable_aec;
  Optional<bool> apm_enable_ns;
  Optional<int> apm_ains_mode;
  Optional<int> apm_ains_gain_control;
  Optional<int> apm_ains_speech_enhance;
  Optional<bool> apm_enable_agc;
  Optional<bool> apm_enable_md;
  Optional<int> apm_aimd_value;
  Optional<bool> apm_enable_highpass_filter;
  Optional<bool> apm_enable_tone_remover;
  Optional<bool> apm_enable_pitch_smoother;
  Optional<bool> apm_enable_howling_control;
  Optional<uint32_t> apm_delay_offset_ms;
  Optional<uint32_t> apm_aec_suppression_level;
  Optional<uint32_t> apm_aec_delay_type;
  Optional<uint32_t> apm_aec_nlp_linear_partition;
  Optional<uint32_t> apm_aec_nlp_aggressiveness;
  Optional<uint32_t> apm_agc_target_level_dbfs;
  Optional<uint32_t> apm_agc_compression_gain_db;
  Optional<uint32_t> apm_agc_mode;
  Optional<uint32_t> apm_ns_enable_ns_follow_agc;
  Optional<uint32_t> apm_ns_level;
  Optional<uint32_t> apm_ns_noiseGateThres;
  
  // Double talk detection switcher. 
  // Android game streaming scenario should be true, all other cases should be false;
  Optional<bool> apm_enable_dtd;

  Optional<uint32_t> acm_bitrate;
  Optional<uint32_t> acm_codec;
  Optional<bool> acm_dtx;
  Optional<bool> acm_plc;
  Optional<uint32_t> acm_complex_level;
  Optional<uint32_t> acm_ptime;
  Optional<bool> acm_hw_encode_opus;
  Optional<bool> acm_hw_decode_opus;
  Optional<bool> audio_resend;
  Optional<uint32_t> audio_rsfec_frame_num;
  Optional<uint32_t> audio_rsfec_interleave_num;
  Optional<uint32_t> audio_fec_frame_num;
  Optional<uint32_t> audio_fec_interleave_num;
  Optional<uint32_t> neteq_live_min_delay;
  Optional<uint32_t> neteq_jitter_buffer_max_packets;
  Optional<bool> neteq_jitter_buffer_fast_accelerate;
  Optional<int32_t> neteq_jitter_max_target_delay;
  Optional<bool> neteq_target_level_optimization;
  Optional<uint32_t> neteq_aqm_voice_threshold;
  Optional<uint32_t> neteq_dump_level;
  Optional<std::string> neteq_dump_path;
  Optional<int> neteq_limit_prob;
  Optional<uint32_t> dwlink_gain;
  Optional<uint32_t> uplink_gain;

  // derived options
  Optional<bool> derived_headset_black_list_device;
#if defined(WEBRTC_IOS) || defined(WEBRTC_ANDROID)
  Optional<int> use_media_volume_in_headset;
  Optional<int> use_media_volume_in_audience;
  Optional<int> use_media_volume_in_solo;
  Optional<int> use_media_volume_in_bluetooth;
#endif // defined(WEBRTC_IOS) || defined(WEBRTC_ANDROID)

 private:
  template <typename T>
  static void SetFrom(Optional<T>* s, const Optional<T>& o) {
    if (o) {
      *s = o;
    }
  }
};

}  // namespace rtc
}  // namespace agora
