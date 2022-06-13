//
//  Agora Media SDK
//
//  Created by Rao Qi in 2019-05.
//  Copyright (c) 2019 Agora IO. All rights reserved.
//
#pragma once

#include <cstdint>
#include <sstream>
#include <string>

#include "AgoraBase.h"
#include "AgoraOptional.h"

#if defined(WEBRTC_WIN)
#define NEW_LINE "\r\n"
#else
#define NEW_LINE "\n"
#endif

namespace agora {
namespace rtc {

struct VideoConfigurationEx {
 public:
  // do NOT add any default value here
  VideoConfigurationEx() = default;
  ~VideoConfigurationEx() = default;
  void SetAll(const VideoConfigurationEx& change) {
#define SET_FROM(X) SetFrom(&X, change.X)

    SET_FROM(codec_type);
    SET_FROM(frame_width);
    SET_FROM(frame_height);
    SET_FROM(frame_rate);
    SET_FROM(start_bitrate);
    SET_FROM(target_bitrate);
    SET_FROM(min_bitrate);
    SET_FROM(max_bitrate);
    SET_FROM(orientation_mode);
    SET_FROM(number_of_temporal_layers);
    SET_FROM(number_of_bframe_temporal_layers);
    SET_FROM(sps_data);
    SET_FROM(pps_data);
    SET_FROM(h264_profile);
    SET_FROM(adaptive_op_mode);
    SET_FROM(number_of_spatial_layers);
    SET_FROM(flexible_mode);
    SET_FROM(interlayer_pred);
    SET_FROM(num_of_encoder_cores);
    SET_FROM(degradation_preference);
    SET_FROM(fps_down_step);
    SET_FROM(fps_up_step);
    SET_FROM(vqc_version);
    SET_FROM(overuse_detector_version);
    //TODO(kefan) these vqc parameters should placed in MediaEngineParameterCollection
    SET_FROM(vqc_quick_adaptNetwork);
    SET_FROM(vqc_min_framerate);
    SET_FROM(vqc_min_holdtime_auto_resize_zoomin);
    SET_FROM(vqc_min_holdtime_auto_resize_zoomout);
    SET_FROM(vqc_qp_adjust);
    SET_FROM(vqc_ios_h265_adjust);
    SET_FROM(min_qp);
    SET_FROM(max_qp);
    SET_FROM(frame_max_size);
    SET_FROM(fec_fix_rate);
    SET_FROM(quick_response_intra_request);
    SET_FROM(fec_method);
    SET_FROM(enable_pvc);
    SET_FROM(pvc_one_model);
    SET_FROM(PvcSupport);
    SET_FROM(PvcConfig);
    SET_FROM(color_space_enable);
    SET_FROM(videoFullrange);
    SET_FROM(matrixCoefficients);
    SET_FROM(enable_sr);
    SET_FROM(sr_type); 

    SET_FROM(complexity);
    SET_FROM(denoising_on);
    SET_FROM(automatic_resize_on);
    SET_FROM(frame_dropping_on);
    SET_FROM(has_intra_request);
    SET_FROM(key_frame_interval);
    SET_FROM(entropy_coding_mode_flag);
    SET_FROM(loop_filter_disable_idc);
    SET_FROM(background_detection_on);
    SET_FROM(posted_frames_waiting_for_encode);
    SET_FROM(bitrate_adjust_ratio);
    SET_FROM(minbitrate_ratio);
    SET_FROM(quality_scale_only_on_average_qp);
    SET_FROM(h264_qp_thresholds_low);
    SET_FROM(h264_qp_thresholds_high);
    SET_FROM(enable_hw_decoder);
    SET_FROM(hw_decoder_provider);
    SET_FROM(low_stream_enable_hw_encoder);
    SET_FROM(av_dec_common_input_format);
    SET_FROM(av_dec_common_output_format);
    SET_FROM(av_dec_mmcss_class);
    SET_FROM(enable_hw_encoder);
    SET_FROM(hw_encoder_provider);
    SET_FROM(av_enc_codec_type);
    SET_FROM(av_enc_common_buffer_in_level);
    SET_FROM(av_enc_common_buffer_out_level);
    SET_FROM(av_enc_common_buffer_size);
    SET_FROM(av_enc_common_low_latency);
    SET_FROM(av_enc_common_max_bit_rate);
    SET_FROM(av_enc_common_mean_bit_rate);
    SET_FROM(av_enc_common_mean_bit_rate_interval);
    SET_FROM(av_enc_common_min_bit_rate);
    SET_FROM(av_enc_common_quality);
    SET_FROM(av_enc_common_quality_vs_speed);
    SET_FROM(av_enc_common_rate_control_mode);
    SET_FROM(av_enc_common_real_time);
    SET_FROM(av_enc_common_stream_end_handling);
    SET_FROM(av_enc_mux_output_stream_type);
    SET_FROM(av_dec_video_acceleration_h264);
    SET_FROM(av_dec_video_acceleration_mpeg2);
    SET_FROM(av_dec_video_acceleration_vc1);
    SET_FROM(av_dec_video_drop_pic_with_missing_ref);
    SET_FROM(av_dec_video_fast_decode_mode);
    SET_FROM(av_dec_video_input_scan_type);
    SET_FROM(av_dec_video_pixel_aspect_ratio);
    SET_FROM(av_dec_video_software_deinterlace_mode);
    SET_FROM(av_dec_video_sw_power_level);
    SET_FROM(av_dec_video_thumbnail_generation_mode);
    SET_FROM(av_enc_input_video_system);
    SET_FROM(av_enc_video_cbr_motion_tradeoff);
    SET_FROM(av_enc_video_coded_video_access_unit_size);
    SET_FROM(av_enc_video_default_upper_field_dominant);
    SET_FROM(av_enc_video_display_dimension);
    SET_FROM(av_enc_video_encode_dimension);
    SET_FROM(av_enc_video_encode_offset_origin);
    SET_FROM(av_enc_video_field_swap);
    SET_FROM(av_enc_video_force_source_scan_type);
    SET_FROM(av_enc_video_header_drop_frame);
    SET_FROM(av_enc_video_header_frames);
    SET_FROM(av_enc_video_header_hours);
    SET_FROM(av_enc_video_header_minutes);
    SET_FROM(av_enc_video_header_seconds);
    SET_FROM(av_enc_video_input_chroma_resolution);
    SET_FROM(av_enc_video_input_chroma_subsampling);
    SET_FROM(av_enc_video_input_color_lighting);
    SET_FROM(av_enc_video_input_color_nominal_range);
    SET_FROM(av_enc_video_input_color_primaries);
    SET_FROM(av_enc_video_input_color_transfer_function);
    SET_FROM(av_enc_video_input_color_transfer_matrix);
    SET_FROM(av_enc_video_inverse_telecine_enable);
    SET_FROM(av_enc_video_inverse_telecine_threshold);
    SET_FROM(av_enc_video_max_keyframe_distance);
    SET_FROM(av_enc_video_no_of_fields_to_encode);
    SET_FROM(av_enc_video_no_of_fields_to_skip);
    SET_FROM(av_enc_video_output_chroma_resolution);
    SET_FROM(av_enc_video_output_chroma_subsampling);
    SET_FROM(av_enc_video_output_color_lighting);
    SET_FROM(av_enc_video_output_color_nominal_range);
    SET_FROM(av_enc_video_output_color_primaries);
    SET_FROM(av_enc_video_output_color_transfer_function);
    SET_FROM(av_enc_video_output_color_transfer_matrix);
    SET_FROM(av_enc_video_output_frame_rate);
    SET_FROM(av_enc_video_output_frame_rate_conversion);
    SET_FROM(av_enc_video_output_scan_type);
    SET_FROM(av_enc_video_pixel_aspect_ratio);
    SET_FROM(av_enc_video_source_film_content);
    SET_FROM(av_enc_video_source_is_bw);
    SET_FROM(av_enc_mpv_add_seq_end_code);
    SET_FROM(av_enc_mpv_default_b_picture_count);
    SET_FROM(av_enc_mpv_frame_field_mode);
    SET_FROM(av_enc_mpv_generate_header_pic_disp_ext);
    SET_FROM(av_enc_mpv_generate_header_pic_ext);
    SET_FROM(av_enc_mpv_generate_header_seq_disp_ext);
    SET_FROM(av_enc_mpv_generate_header_seq_ext);
    SET_FROM(av_enc_mpv_generate_header_seq_scale_ext);
    SET_FROM(av_enc_mpvgop_open);
    SET_FROM(av_enc_mpvgops_in_seq);
    SET_FROM(av_enc_mpvgop_size);
    SET_FROM(av_enc_mpv_intra_dc_precision);
    SET_FROM(av_enc_mpv_intra_vlc_table);
    SET_FROM(av_enc_mpv_level);
    SET_FROM(av_enc_mpv_profile);
    SET_FROM(av_enc_mpvq_scale_type);
    SET_FROM(av_enc_mpv_scan_pattern);
    SET_FROM(av_enc_mpv_scene_detection);
    SET_FROM(av_enc_mpv_use_concealment_motion_vectors);
    SET_FROM(vdm_not_override_lua_smallvideo_not_use_hwenc_policy);
    SET_FROM(enable_video_sender_frame_dropper);
    SET_FROM(enable_video_freeze_diagnose);
    SET_FROM(enable_video_qoe_assess);
    SET_FROM(h264_hw_min_res_level);
    SET_FROM(av_enc_video_max_slices);
    SET_FROM(vp8_enc_switch);
    SET_FROM(av1_dec_enable);
    SET_FROM(av1_camera_enable);
    SET_FROM(av1_screen_enable);
    SET_FROM(av1_encoder_thread_num);

    SET_FROM(isScreenSharingJbEnabled);
    SET_FROM(enable_video_vpr);
    SET_FROM(video_vpr_init_size);
    SET_FROM(video_vpr_max_size);
    SET_FROM(video_vpr_frozen_ms_thres);
    SET_FROM(video_vpr_frozen_rate_thres);
    SET_FROM(video_vpr_method);
    SET_FROM(retrans_detect_enable);
    SET_FROM(use_sent_ts_enable);
    SET_FROM(video_rotation);
    SET_FROM(scale_type);
    SET_FROM(scc_auto_framerate);
    SET_FROM(scc_quality_opt);
    SET_FROM(video_render_d3d9_texture);
    SET_FROM(av_enc_video_width_alignment);
    SET_FROM(av_enc_video_height_alignment);
    SET_FROM(av_enc_video_force_alignment);
    SET_FROM(av_dec_output_byte_frame);
    SET_FROM(av_dec_video_hwdec_config);
    SET_FROM(av_enc_video_hwenc_config);

    SET_FROM(av_enc_video_use_a264);
    SET_FROM(av_enc_vmaf_calc);
    SET_FROM(av_enc_screen_sharing_subclass);
    
    SET_FROM(enable_iptos);

    SET_FROM(key_frame_interval_intra_request);
    SET_FROM(video_switch_soft_decoder_threshold);
    SET_FROM(min_encode_keyframe_interval);
    SET_FROM(bFrames);
    SET_FROM(video_skip_enable);
    SET_FROM(av_enc_new_complexity);
    SET_FROM(av_enc_default_complexity);
    SET_FROM(av_enc_intra_key_interval);
    SET_FROM(key_force_device_score);
    SET_FROM(av_enc_bitrate_adjustment_type);
    SET_FROM(use_single_slice_parser);
    SET_FROM(enable_parser_reject);

    SET_FROM(direct_cdn_streaming_h264_profile);
#undef SET_FROM
  }

  bool operator==(const VideoConfigurationEx& o) const {
#define BEGIN_COMPARE() bool b = true
#define ADD_COMPARE(X) b = (b && (X == o.X))
#define END_COMPARE()

    BEGIN_COMPARE();
    ADD_COMPARE(codec_type);
    ADD_COMPARE(frame_width);
    ADD_COMPARE(frame_height);
    ADD_COMPARE(frame_rate);
    ADD_COMPARE(start_bitrate);
    ADD_COMPARE(target_bitrate);
    ADD_COMPARE(min_bitrate);
    ADD_COMPARE(orientation_mode);
    ADD_COMPARE(number_of_temporal_layers);
    ADD_COMPARE(number_of_bframe_temporal_layers);
    ADD_COMPARE(sps_data);
    ADD_COMPARE(pps_data);
    ADD_COMPARE(h264_profile);
    ADD_COMPARE(adaptive_op_mode);
    ADD_COMPARE(number_of_spatial_layers);
    ADD_COMPARE(flexible_mode);
    ADD_COMPARE(interlayer_pred);
    ADD_COMPARE(num_of_encoder_cores);
    ADD_COMPARE(degradation_preference);
    ADD_COMPARE(fps_down_step);
    ADD_COMPARE(fps_up_step);
    ADD_COMPARE(vqc_version);
    ADD_COMPARE(overuse_detector_version);
    //TODO(kefan) these vqc parameters should placed in MediaEngineParameterCollection
    ADD_COMPARE(vqc_quick_adaptNetwork);
    ADD_COMPARE(vqc_min_framerate);
    ADD_COMPARE(vqc_min_holdtime_auto_resize_zoomin);
    ADD_COMPARE(vqc_min_holdtime_auto_resize_zoomout);
    ADD_COMPARE(vqc_qp_adjust);
    ADD_COMPARE(vqc_ios_h265_adjust);
    ADD_COMPARE(min_qp);
    ADD_COMPARE(max_qp);
    ADD_COMPARE(frame_max_size);   
    ADD_COMPARE(fec_fix_rate);
    ADD_COMPARE(quick_response_intra_request);
    ADD_COMPARE(fec_method);
    ADD_COMPARE(enable_pvc);
    ADD_COMPARE(pvc_one_model);
    ADD_COMPARE(PvcSupport);
    ADD_COMPARE(PvcConfig);
    ADD_COMPARE(enable_sr);
    ADD_COMPARE(sr_type); 

    ADD_COMPARE(complexity);
    ADD_COMPARE(denoising_on);
    ADD_COMPARE(automatic_resize_on);
    ADD_COMPARE(frame_dropping_on);
    ADD_COMPARE(has_intra_request);
    ADD_COMPARE(key_frame_interval);
    ADD_COMPARE(entropy_coding_mode_flag);
    ADD_COMPARE(loop_filter_disable_idc);
    ADD_COMPARE(background_detection_on);
    ADD_COMPARE(posted_frames_waiting_for_encode);
    ADD_COMPARE(bitrate_adjust_ratio);
    ADD_COMPARE(minbitrate_ratio);
    ADD_COMPARE(quality_scale_only_on_average_qp);
    ADD_COMPARE(h264_qp_thresholds_low);
    ADD_COMPARE(h264_qp_thresholds_high);
    ADD_COMPARE(enable_hw_decoder);
    ADD_COMPARE(hw_decoder_provider);
    ADD_COMPARE(low_stream_enable_hw_encoder);
    ADD_COMPARE(av_dec_common_input_format);
    ADD_COMPARE(av_dec_common_output_format);
    ADD_COMPARE(av_dec_mmcss_class);
    ADD_COMPARE(enable_hw_encoder);
    ADD_COMPARE(hw_encoder_provider);
    ADD_COMPARE(av_enc_codec_type);
    ADD_COMPARE(av_enc_common_buffer_in_level);
    ADD_COMPARE(av_enc_common_buffer_out_level);
    ADD_COMPARE(av_enc_common_buffer_size);
    ADD_COMPARE(av_enc_common_low_latency);
    ADD_COMPARE(av_enc_common_max_bit_rate);
    ADD_COMPARE(av_enc_common_mean_bit_rate);
    ADD_COMPARE(av_enc_common_mean_bit_rate_interval);
    ADD_COMPARE(av_enc_common_min_bit_rate);
    ADD_COMPARE(av_enc_common_quality);
    ADD_COMPARE(av_enc_common_quality_vs_speed);
    ADD_COMPARE(av_enc_common_rate_control_mode);
    ADD_COMPARE(av_enc_common_real_time);
    ADD_COMPARE(av_enc_common_stream_end_handling);
    ADD_COMPARE(av_enc_mux_output_stream_type);
    ADD_COMPARE(av_dec_video_acceleration_h264);
    ADD_COMPARE(av_dec_video_acceleration_mpeg2);
    ADD_COMPARE(av_dec_video_acceleration_vc1);
    ADD_COMPARE(av_dec_video_drop_pic_with_missing_ref);
    ADD_COMPARE(av_dec_video_fast_decode_mode);
    ADD_COMPARE(av_dec_video_input_scan_type);
    ADD_COMPARE(av_dec_video_pixel_aspect_ratio);
    ADD_COMPARE(av_dec_video_software_deinterlace_mode);
    ADD_COMPARE(av_dec_video_sw_power_level);
    ADD_COMPARE(av_dec_video_thumbnail_generation_mode);
    ADD_COMPARE(av_enc_input_video_system);
    ADD_COMPARE(av_enc_video_cbr_motion_tradeoff);
    ADD_COMPARE(av_enc_video_coded_video_access_unit_size);
    ADD_COMPARE(av_enc_video_default_upper_field_dominant);
    ADD_COMPARE(av_enc_video_display_dimension);
    ADD_COMPARE(av_enc_video_encode_dimension);
    ADD_COMPARE(av_enc_video_encode_offset_origin);
    ADD_COMPARE(av_enc_video_field_swap);
    ADD_COMPARE(av_enc_video_force_source_scan_type);
    ADD_COMPARE(av_enc_video_header_drop_frame);
    ADD_COMPARE(av_enc_video_header_frames);
    ADD_COMPARE(av_enc_video_header_hours);
    ADD_COMPARE(av_enc_video_header_minutes);
    ADD_COMPARE(av_enc_video_header_seconds);
    ADD_COMPARE(av_enc_video_input_chroma_resolution);
    ADD_COMPARE(av_enc_video_input_chroma_subsampling);
    ADD_COMPARE(av_enc_video_input_color_lighting);
    ADD_COMPARE(av_enc_video_input_color_nominal_range);
    ADD_COMPARE(av_enc_video_input_color_primaries);
    ADD_COMPARE(av_enc_video_input_color_transfer_function);
    ADD_COMPARE(av_enc_video_input_color_transfer_matrix);
    ADD_COMPARE(av_enc_video_inverse_telecine_enable);
    ADD_COMPARE(av_enc_video_inverse_telecine_threshold);
    ADD_COMPARE(av_enc_video_max_keyframe_distance);
    ADD_COMPARE(av_enc_video_no_of_fields_to_encode);
    ADD_COMPARE(av_enc_video_no_of_fields_to_skip);
    ADD_COMPARE(av_enc_video_output_chroma_resolution);
    ADD_COMPARE(av_enc_video_output_chroma_subsampling);
    ADD_COMPARE(av_enc_video_output_color_lighting);
    ADD_COMPARE(av_enc_video_output_color_nominal_range);
    ADD_COMPARE(av_enc_video_output_color_primaries);
    ADD_COMPARE(av_enc_video_output_color_transfer_function);
    ADD_COMPARE(av_enc_video_output_color_transfer_matrix);
    ADD_COMPARE(av_enc_video_output_frame_rate);
    ADD_COMPARE(av_enc_video_output_frame_rate_conversion);
    ADD_COMPARE(av_enc_video_output_scan_type);
    ADD_COMPARE(av_enc_video_pixel_aspect_ratio);
    ADD_COMPARE(av_enc_video_source_film_content);
    ADD_COMPARE(av_enc_video_source_is_bw);
    ADD_COMPARE(av_enc_mpv_add_seq_end_code);
    ADD_COMPARE(av_enc_mpv_default_b_picture_count);
    ADD_COMPARE(av_enc_mpv_frame_field_mode);
    ADD_COMPARE(av_enc_mpv_generate_header_pic_disp_ext);
    ADD_COMPARE(av_enc_mpv_generate_header_pic_ext);
    ADD_COMPARE(av_enc_mpv_generate_header_seq_disp_ext);
    ADD_COMPARE(av_enc_mpv_generate_header_seq_ext);
    ADD_COMPARE(av_enc_mpv_generate_header_seq_scale_ext);
    ADD_COMPARE(av_enc_mpvgop_open);
    ADD_COMPARE(av_enc_mpvgops_in_seq);
    ADD_COMPARE(av_enc_mpvgop_size);
    ADD_COMPARE(av_enc_mpv_intra_dc_precision);
    ADD_COMPARE(av_enc_mpv_intra_vlc_table);
    ADD_COMPARE(av_enc_mpv_level);
    ADD_COMPARE(av_enc_mpv_profile);
    ADD_COMPARE(av_enc_mpvq_scale_type);
    ADD_COMPARE(scc_auto_framerate);
    ADD_COMPARE(scc_quality_opt);
    ADD_COMPARE(video_render_d3d9_texture);
    ADD_COMPARE(av_enc_mpv_scan_pattern);
    ADD_COMPARE(av_enc_mpv_scene_detection);
    ADD_COMPARE(av_enc_mpv_use_concealment_motion_vectors);
    ADD_COMPARE(vdm_not_override_lua_smallvideo_not_use_hwenc_policy);
    ADD_COMPARE(enable_video_sender_frame_dropper);
    ADD_COMPARE(enable_video_freeze_diagnose);
    ADD_COMPARE(enable_video_qoe_assess);
    ADD_COMPARE(h264_hw_min_res_level);
    ADD_COMPARE(av_enc_video_max_slices);
    ADD_COMPARE(vp8_enc_switch);
    ADD_COMPARE(av1_dec_enable);
    ADD_COMPARE(av1_camera_enable);
    ADD_COMPARE(av1_screen_enable);
    ADD_COMPARE(av1_encoder_thread_num);
    ADD_COMPARE(color_space_enable);
    ADD_COMPARE(videoFullrange);
    ADD_COMPARE(matrixCoefficients);

    ADD_COMPARE(isScreenSharingJbEnabled);
    ADD_COMPARE(enable_video_vpr);
    ADD_COMPARE(video_vpr_init_size);
    ADD_COMPARE(video_vpr_max_size);
    ADD_COMPARE(video_vpr_frozen_ms_thres);
    ADD_COMPARE(video_vpr_frozen_rate_thres);
    ADD_COMPARE(video_vpr_method);
    ADD_COMPARE(av_enc_intra_key_interval);    
    ADD_COMPARE(key_force_device_score);
    ADD_COMPARE(av_enc_bitrate_adjustment_type);
    ADD_COMPARE(retrans_detect_enable);
    ADD_COMPARE(use_sent_ts_enable);
    ADD_COMPARE(video_rotation);
    ADD_COMPARE(scale_type);
    ADD_COMPARE(av_enc_video_use_a264);
    ADD_COMPARE(av_enc_vmaf_calc);
    ADD_COMPARE(av_enc_screen_sharing_subclass);
    ADD_COMPARE(av_enc_video_width_alignment);
    ADD_COMPARE(av_enc_video_height_alignment);
    ADD_COMPARE(av_enc_video_force_alignment);
    ADD_COMPARE(av_dec_output_byte_frame);

    ADD_COMPARE(enable_iptos);

    ADD_COMPARE(key_frame_interval_intra_request);
    ADD_COMPARE(video_switch_soft_decoder_threshold);
    ADD_COMPARE(min_encode_keyframe_interval);
    ADD_COMPARE(bFrames);
    ADD_COMPARE(video_skip_enable);
    ADD_COMPARE(av_enc_new_complexity);
    ADD_COMPARE(av_enc_default_complexity);
    ADD_COMPARE(use_single_slice_parser);
    ADD_COMPARE(av_enc_video_hwenc_config);
    ADD_COMPARE(av_dec_video_hwdec_config);
    ADD_COMPARE(enable_parser_reject);
    ADD_COMPARE(direct_cdn_streaming_h264_profile);
    END_COMPARE();

#undef BEGIN_COMPARE
#undef ADD_COMPARE
#undef END_COMPARE
    return b;
  }

  bool operator!=(const VideoConfigurationEx& o) const { return !(*this == o); }

  std::string ToString() const {
#define ADD_STRING(X) ost << ToStringIfSet(#X, X)

    std::ostringstream ost;
    ADD_STRING(codec_type);
    ADD_STRING(frame_width);
    ADD_STRING(frame_height);
    ADD_STRING(frame_rate);
    ADD_STRING(start_bitrate);
    ADD_STRING(target_bitrate);
    ADD_STRING(min_bitrate);
    ADD_STRING(max_bitrate);
    ADD_STRING(orientation_mode);
    ADD_STRING(number_of_temporal_layers);
    ADD_STRING(number_of_bframe_temporal_layers);
    ADD_STRING(sps_data);
    ADD_STRING(pps_data);
    ADD_STRING(h264_profile);
    ADD_STRING(adaptive_op_mode);
    ADD_STRING(number_of_spatial_layers);
    ADD_STRING(flexible_mode);
    ADD_STRING(interlayer_pred);
    ADD_STRING(num_of_encoder_cores);
    ADD_STRING(degradation_preference);
    ADD_STRING(fps_down_step);
    ADD_STRING(fps_up_step);
    ADD_STRING(vqc_version);
    ADD_STRING(overuse_detector_version);
    //TODO(kefan) these vqc parameters should placed in MediaEngineParameterCollection
    ADD_STRING(vqc_quick_adaptNetwork);
    ADD_STRING(vqc_min_framerate);
    ADD_STRING(vqc_min_holdtime_auto_resize_zoomin);
    ADD_STRING(vqc_min_holdtime_auto_resize_zoomout);
    ADD_STRING(vqc_qp_adjust);
    ADD_STRING(vqc_ios_h265_adjust);
    ADD_STRING(min_qp);
    ADD_STRING(max_qp);
    ADD_STRING(frame_max_size);   
    ADD_STRING(fec_fix_rate);
    ADD_STRING(quick_response_intra_request);
    ADD_STRING(fec_method);
    ADD_STRING(enable_pvc);
    ADD_STRING(pvc_one_model);
    ADD_STRING(PvcSupport);
    ADD_STRING(PvcConfig);
    ADD_STRING(enable_sr);
    ADD_STRING(sr_type); 

    ADD_STRING(complexity);
    ADD_STRING(denoising_on);
    ADD_STRING(automatic_resize_on);
    ADD_STRING(frame_dropping_on);
    ADD_STRING(has_intra_request);
    ADD_STRING(key_frame_interval);
    ADD_STRING(entropy_coding_mode_flag);
    ADD_STRING(loop_filter_disable_idc);
    ADD_STRING(background_detection_on);
    ADD_STRING(posted_frames_waiting_for_encode);
    ADD_STRING(bitrate_adjust_ratio);
    ADD_STRING(minbitrate_ratio);
    ADD_STRING(quality_scale_only_on_average_qp);
    ADD_STRING(h264_qp_thresholds_low);
    ADD_STRING(h264_qp_thresholds_high);
    ADD_STRING(enable_hw_decoder);
    ADD_STRING(hw_decoder_provider);
    ADD_STRING(low_stream_enable_hw_encoder);
    ADD_STRING(av_dec_common_input_format);
    ADD_STRING(av_dec_common_output_format);
    ADD_STRING(av_dec_mmcss_class);
    ADD_STRING(enable_hw_encoder);
    ADD_STRING(hw_encoder_provider);
    ADD_STRING(av_enc_codec_type);
    ADD_STRING(av_enc_common_buffer_in_level);
    ADD_STRING(av_enc_common_buffer_out_level);
    ADD_STRING(av_enc_common_buffer_size);
    ADD_STRING(av_enc_common_low_latency);
    ADD_STRING(av_enc_common_max_bit_rate);
    ADD_STRING(av_enc_common_mean_bit_rate);
    ADD_STRING(av_enc_common_mean_bit_rate_interval);
    ADD_STRING(av_enc_common_min_bit_rate);
    ADD_STRING(av_enc_common_quality);
    ADD_STRING(av_enc_common_quality_vs_speed);
    ADD_STRING(av_enc_common_rate_control_mode);
    ADD_STRING(av_enc_common_real_time);
    ADD_STRING(av_enc_common_stream_end_handling);
    ADD_STRING(av_enc_mux_output_stream_type);
    ADD_STRING(av_dec_video_acceleration_h264);
    ADD_STRING(av_dec_video_acceleration_mpeg2);
    ADD_STRING(av_dec_video_acceleration_vc1);
    ADD_STRING(av_dec_video_drop_pic_with_missing_ref);
    ADD_STRING(av_dec_video_fast_decode_mode);
    ADD_STRING(av_dec_video_input_scan_type);
    ADD_STRING(av_dec_video_pixel_aspect_ratio);
    ADD_STRING(av_dec_video_software_deinterlace_mode);
    ADD_STRING(av_dec_video_sw_power_level);
    ADD_STRING(av_dec_video_thumbnail_generation_mode);
    ADD_STRING(av_enc_input_video_system);
    ADD_STRING(av_enc_video_cbr_motion_tradeoff);
    ADD_STRING(av_enc_video_coded_video_access_unit_size);
    ADD_STRING(av_enc_video_default_upper_field_dominant);
    ADD_STRING(av_enc_video_display_dimension);
    ADD_STRING(av_enc_video_encode_dimension);
    ADD_STRING(av_enc_video_encode_offset_origin);
    ADD_STRING(av_enc_video_field_swap);
    ADD_STRING(av_enc_video_force_source_scan_type);
    ADD_STRING(av_enc_video_header_drop_frame);
    ADD_STRING(av_enc_video_header_frames);
    ADD_STRING(av_enc_video_header_hours);
    ADD_STRING(av_enc_video_header_minutes);
    ADD_STRING(av_enc_video_header_seconds);
    ADD_STRING(av_enc_video_input_chroma_resolution);
    ADD_STRING(av_enc_video_input_chroma_subsampling);
    ADD_STRING(av_enc_video_input_color_lighting);
    ADD_STRING(av_enc_video_input_color_nominal_range);
    ADD_STRING(av_enc_video_input_color_primaries);
    ADD_STRING(av_enc_video_input_color_transfer_function);
    ADD_STRING(av_enc_video_input_color_transfer_matrix);
    ADD_STRING(av_enc_video_inverse_telecine_enable);
    ADD_STRING(av_enc_video_inverse_telecine_threshold);
    ADD_STRING(av_enc_video_max_keyframe_distance);
    ADD_STRING(av_enc_video_no_of_fields_to_encode);
    ADD_STRING(av_enc_video_no_of_fields_to_skip);
    ADD_STRING(av_enc_video_output_chroma_resolution);
    ADD_STRING(av_enc_video_output_chroma_subsampling);
    ADD_STRING(av_enc_video_output_color_lighting);
    ADD_STRING(av_enc_video_output_color_nominal_range);
    ADD_STRING(av_enc_video_output_color_primaries);
    ADD_STRING(av_enc_video_output_color_transfer_function);
    ADD_STRING(av_enc_video_output_color_transfer_matrix);
    ADD_STRING(av_enc_video_output_frame_rate);
    ADD_STRING(av_enc_video_output_frame_rate_conversion);
    ADD_STRING(av_enc_video_output_scan_type);
    ADD_STRING(av_enc_video_pixel_aspect_ratio);
    ADD_STRING(av_enc_video_source_film_content);
    ADD_STRING(av_enc_video_source_is_bw);
    ADD_STRING(av_enc_mpv_add_seq_end_code);
    ADD_STRING(av_enc_mpv_default_b_picture_count);
    ADD_STRING(av_enc_mpv_frame_field_mode);
    ADD_STRING(av_enc_mpv_generate_header_pic_disp_ext);
    ADD_STRING(av_enc_mpv_generate_header_pic_ext);
    ADD_STRING(av_enc_mpv_generate_header_seq_disp_ext);
    ADD_STRING(av_enc_mpv_generate_header_seq_ext);
    ADD_STRING(av_enc_mpv_generate_header_seq_scale_ext);
    ADD_STRING(av_enc_mpvgop_open);
    ADD_STRING(av_enc_mpvgops_in_seq);
    ADD_STRING(av_enc_mpvgop_size);
    ADD_STRING(av_enc_mpv_intra_dc_precision);
    ADD_STRING(av_enc_mpv_intra_vlc_table);
    ADD_STRING(av_enc_mpv_level);
    ADD_STRING(av_enc_mpv_profile);
    ADD_STRING(av_enc_mpvq_scale_type);
    ADD_STRING(av_enc_mpv_scan_pattern);
    ADD_STRING(av_enc_mpv_scene_detection);
    ADD_STRING(av_enc_mpv_use_concealment_motion_vectors);
    ADD_STRING(vdm_not_override_lua_smallvideo_not_use_hwenc_policy);
    ADD_STRING(enable_video_sender_frame_dropper);
    ADD_STRING(enable_video_freeze_diagnose);
    ADD_STRING(enable_video_qoe_assess);
    ADD_STRING(h264_hw_min_res_level);
    ADD_STRING(av_enc_video_max_slices);
    ADD_STRING(vp8_enc_switch);
    ADD_STRING(av1_dec_enable);
    ADD_STRING(av1_camera_enable);
    ADD_STRING(av1_screen_enable);
    ADD_STRING(av1_encoder_thread_num);
    
    ADD_STRING(color_space_enable);
    ADD_STRING(videoFullrange);
    ADD_STRING(matrixCoefficients);

    ADD_STRING(isScreenSharingJbEnabled);
    ADD_STRING(enable_video_vpr);
    ADD_STRING(video_vpr_init_size);
    ADD_STRING(video_vpr_max_size);
    ADD_STRING(video_vpr_frozen_ms_thres);
    ADD_STRING(video_vpr_frozen_rate_thres);
    ADD_STRING(video_vpr_method);
    ADD_STRING(retrans_detect_enable);
    ADD_STRING(use_sent_ts_enable);
    ADD_STRING(video_rotation);
    ADD_STRING(scale_type);
    ADD_STRING(scc_auto_framerate);
    ADD_STRING(scc_quality_opt);
    ADD_STRING(video_render_d3d9_texture);
    ADD_STRING(av_enc_video_width_alignment);
    ADD_STRING(av_enc_video_height_alignment);
    ADD_STRING(av_enc_video_force_alignment);
    ADD_STRING(av_dec_output_byte_frame);
    ADD_STRING(av_dec_video_hwdec_config);
    ADD_STRING(av_enc_video_hwenc_config);

    ADD_STRING(av_enc_video_use_a264);
    ADD_STRING(av_enc_vmaf_calc);
    ADD_STRING(av_enc_screen_sharing_subclass);

    ADD_STRING(enable_iptos);

    ADD_STRING(key_frame_interval_intra_request);
    ADD_STRING(video_switch_soft_decoder_threshold);
    ADD_STRING(min_encode_keyframe_interval);
    ADD_STRING(bFrames);
    ADD_STRING(video_skip_enable);
    ADD_STRING(av_enc_new_complexity);
    ADD_STRING(av_enc_default_complexity);
    ADD_STRING(av_enc_intra_key_interval);
    ADD_STRING(key_force_device_score);
    ADD_STRING(av_enc_bitrate_adjustment_type);
    ADD_STRING(use_single_slice_parser);
    ADD_STRING(enable_parser_reject);    
    
    ADD_STRING(direct_cdn_streaming_h264_profile);
#undef ADD_STRING
    std::string ret = ost.str();
    auto index = ret.rfind(",");
    if (index != ret.npos) {
      ret = ret.substr(0, index);
      ret += NEW_LINE;
    }

    return "{" NEW_LINE + ret + "}";
  }

  Optional<int> codec_type;
  Optional<int> frame_width;
  Optional<int> frame_height;
  Optional<int> frame_rate;
  Optional<int> start_bitrate;
  Optional<int> target_bitrate;
  Optional<int> min_bitrate;
  Optional<int> max_bitrate;
  Optional<int> orientation_mode;
  Optional<uint8_t> number_of_temporal_layers;
  Optional<uint8_t> (number_of_bframe_temporal_layers);
  Optional<std::string> sps_data;
  Optional<std::string> pps_data;
  Optional<int> h264_profile;
  Optional<bool> adaptive_op_mode;
  Optional<uint8_t> number_of_spatial_layers;
  Optional<bool> flexible_mode;
  Optional<int> interlayer_pred;
  Optional<int> num_of_encoder_cores;
  Optional<int> degradation_preference;
  Optional<int> fps_down_step;
  Optional<int> fps_up_step;
  Optional<int> vqc_version;
  Optional<int> overuse_detector_version;
  //TODO(kefan) these vqc parameters should placed in MediaEngineParameterCollection
  Optional<bool> vqc_quick_adaptNetwork;
  Optional<int> vqc_min_framerate;
  Optional<int> vqc_min_holdtime_auto_resize_zoomin;
  Optional<int> vqc_min_holdtime_auto_resize_zoomout;
  Optional<int> vqc_qp_adjust;
  Optional<int> vqc_ios_h265_adjust;
  Optional<int> (min_qp);
  Optional<int> (max_qp);
  Optional<int> (frame_max_size);   
  Optional<int> quick_response_intra_request;
  Optional<int> fec_method;
  Optional<int> fec_fix_rate;
  //av1 dec enable
  Optional<bool> av1_dec_enable;
  Optional<bool> av1_camera_enable;
  Optional<bool> av1_screen_enable;
  Optional<int> av1_encoder_thread_num;
  // vp8 enc switch
  Optional<bool> vp8_enc_switch;

  Optional<int> complexity;
  Optional<bool> denoising_on;
  Optional<bool> automatic_resize_on;
  Optional<bool> frame_dropping_on;
  Optional<bool> has_intra_request;
  Optional<int> key_frame_interval;
  Optional<int> entropy_coding_mode_flag;
  Optional<int> loop_filter_disable_idc;
  Optional<bool> background_detection_on;
  Optional<int> posted_frames_waiting_for_encode;
  Optional<std::string> bitrate_adjust_ratio;
  Optional<std::string> minbitrate_ratio;
  // followings are hw setting

  // h264 quality scaler settings
  Optional<bool> quality_scale_only_on_average_qp;
  Optional<int> h264_qp_thresholds_low;
  Optional<int> h264_qp_thresholds_high;

  // Specifies whether or not to enable hw decode.
  Optional<bool> enable_hw_decoder;
  // Specifies whether or not to enable low stream hw encode.
  Optional<bool> low_stream_enable_hw_encoder;
  // Specifies hw encode provider.
  Optional<std::string> hw_decoder_provider;
  // Specifies the current input format for the decoder.
  Optional<std::string> av_dec_common_input_format;
  // Specifies the output format for the decoder.
  Optional<std::string> av_dec_common_output_format;
  // Specifies the Multimedia Class Scheduler Service (MMCSS) class for the decoding thread.
  Optional<std::string> av_dec_mmcss_class;

  // Specifies whether or not to enable hw encode.
  Optional<bool> enable_hw_encoder;
  // Specifies hw encode provider.
  Optional<uint32_t> hw_encoder_provider;
  // Specifies the encoding scheme.
  Optional<uint32_t> av_enc_codec_type;
  // Specifies the initial level of the encoding buffer.
  Optional<uint32_t> av_enc_common_buffer_in_level;
  // Specifies the final level of the encoding buffer at the end of the encoding process.
  Optional<uint32_t> av_enc_common_buffer_out_level;
  // Specifies the size of the buffer used during encoding.
  Optional<uint32_t> av_enc_common_buffer_size;
  // Specifies whether the output stream should be structured so that the encoded stream has a
  // low decoding latency.
  Optional<bool> av_enc_common_low_latency;
  // Specifies the maximum bit rate.
  Optional<int> av_enc_common_max_bit_rate;
  // Specifies the average bit rate.
  Optional<int> av_enc_common_mean_bit_rate;
  // Specifies the time interval over which the average bit rate applies.
  Optional<int> av_enc_common_mean_bit_rate_interval;
  // Specifies the minimum bit rate.
  Optional<int> av_enc_common_min_bit_rate;
  // Specifies the quality level for encoding.
  //    0	  Minimum quality, smaller output size.
  //    100	Maximum quality, larger output size.
  Optional<uint32_t> av_enc_common_quality;
  // Specifies the tradeoff between encoding quality and speed.
  //    0	  Lower quality, faster encoding.
  //    100	Higher quality, slower encoding.
  Optional<uint32_t> av_enc_common_quality_vs_speed;
  // Specifies the rate control mode.
  //    eAVEncCommonRateControlMode_CBR,
  //    eAVEncCommonRateControlMode_PeakConstrainedVBR,
  //    eAVEncCommonRateControlMode_UnconstrainedVBR,
  //    eAVEncCommonRateControlMode_Quality,
  //    eAVEncCommonRateControlMode_LowDelayVBR,
  //    eAVEncCommonRateControlMode_GlobalVBR,
  //    eAVEncCommonRateControlMode_GlobalLowDelayVBR
  Optional<uint32_t> av_enc_common_rate_control_mode;
  // Specifies whether the application requires real-time encoding performance.
  Optional<bool> av_enc_common_real_time;
  // Specifies whether the encoder discards partial groups of pictures (GOPs)
  // at the end of the stream.
  Optional<bool> av_enc_common_stream_end_handling;
  // Specifies the type of output stream produced by a multiplexer.
  //    eAVEncMuxOutputAuto,
  //    eAVEncMuxOutputPS,
  //    eAVEncMuxOutputTS
  Optional<uint32_t> av_enc_mux_output_stream_type;

  // Enables or disables hardware acceleration for H.264 video decoding.
  // set this property before the decoder's output pin is connected.
  Optional<uint32_t> av_dec_video_acceleration_h264;
  // Enables or disables hardware acceleration for MPEG-2 video decoding.
  // set this property before the decoder's output pin is connected.
  Optional<uint32_t> av_dec_video_acceleration_mpeg2;
  // Enables or disables hardware acceleration for VC-1 video decoding.
  // set this property before the decoder's output pin is connected.
  Optional<uint32_t> av_dec_video_acceleration_vc1;
  // Specifies whether the decoder drops intra frames with missing reference frames.
  Optional<bool> av_dec_video_drop_pic_with_missing_ref;
  // Sets the video decoding speed.
  // 0 indicates normal decoding and 32 is the fastest decoding mode.
  Optional<uint32_t> av_dec_video_fast_decode_mode;
  // Specifies how the decoded video stream is interlaced.
  //    eAVDecVideoInputScan_Unknown,
  //    eAVDecVideoInputScan_Progressive,
  //    eAVDecVideoInputScan_Interlaced_UpperFieldFirst,
  //    eAVDecVideoInputScan_Interlaced_LowerFieldFirst
  Optional<uint32_t> av_dec_video_input_scan_type;
  // Specifies the pixel aspect ratio of the decoded video stream.
  // The upper 16 bits of the value contain the width, and the lower 16 bits contain the height.
  Optional<uint32_t> av_dec_video_pixel_aspect_ratio;
  // Specifies the decoders software deinterlace mode.
  //    eAVDecVideoSoftwareDeinterlaceMode_NoDeinterlacing,
  //    eAVDecVideoSoftwareDeinterlaceMode_ProgressiveDeinterlacing,
  //    eAVDecVideoSoftwareDeinterlaceMode_BOBDeinterlacing,
  //    eAVDecVideoSoftwareDeinterlaceMode_SmartBOBDeinterlacing
  Optional<uint32_t> av_dec_video_software_deinterlace_mode;
  // Specifies the power-saving level.
  //   0	Optimize for battery life.
  // 100	Optimize for video quality.
  Optional<uint32_t> av_dec_video_sw_power_level;
  // Enables or disables thumbnail generation mode.
  Optional<bool> av_dec_video_thumbnail_generation_mode;
  // Specifies the video system of the source content.
  //    eAVEncInputVideoSystem_Unspecified,
  //    eAVEncInputVideoSystem_PAL,
  //    eAVEncInputVideoSystem_NTSC,
  //    eAVEncInputVideoSystem_SECAM,
  //    eAVEncInputVideoSystem_MAC,
  //    eAVEncInputVideoSystem_HDV,
  //    eAVEncInputVideoSystem_Component
  Optional<uint32_t> av_enc_input_video_system;
  // Specifies the tradeoff between motion and still images.
  // 0	Optimize for still images
  // 100	Optimize for motion.
  Optional<uint32_t> av_enc_video_cbr_motion_tradeoff;
  // Specifies the size of the video access units.
  Optional<uint32_t> av_enc_video_coded_video_access_unit_size;
  // Specifies which field is displayed first.
  Optional<bool> av_enc_video_default_upper_field_dominant;
  // Specifies the size of the video stream when it is decoded.
  // The upper 16 bits of the value contain the width, in pixels. The lower 16 bits contain the
  // height, in pixels.
  Optional<uint32_t> av_enc_video_display_dimension;
  // Specifies the width and height of the encoded video, if the video is cropped.
  // The upper 16 bits of the value contain the width, in pixels. The lower 16 bits contain the
  // height, in pixels.
  Optional<uint32_t> av_enc_video_encode_dimension;
  // Specifies the left and top corners of the clipping rectangle, if the video is cropped.
  // The upper 16 bits of the value contain the offset from the left edge of the input frame, in
  // pixels. The lower 16 bits contain the offset from the top edge of the input frame, in pixels.
  Optional<uint32_t> av_enc_video_encode_offset_origin;
  // Reverses the order of the interlaced fields in the source video.
  Optional<bool> av_enc_video_field_swap;
  // Specifies whether the input frames are progressive or interlaced.
  //    eAVEncVideoSourceScan_Automatic,
  //    eAVEncVideoSourceScan_Interlaced,
  //    eAVEncVideoSourceScan_Progressive
  Optional<uint32_t> av_enc_video_force_source_scan_type;
  // Specifies the value of drop-frame flag in the GOP header.
  // The value of this property can be 0 or 1.
  Optional<uint32_t> av_enc_video_header_drop_frame;
  // Specifies the starting frame number in the GOP header.
  Optional<uint32_t> av_enc_video_header_frames;
  // Specifies the starting hour number in the GOP header.
  Optional<uint32_t> av_enc_video_header_hours;
  // Specifies the starting minute number in the GOP header.
  Optional<uint32_t> av_enc_video_header_minutes;
  // Specifies the starting second number in the GOP header.
  Optional<uint32_t> av_enc_video_header_seconds;
  // Specifies the chroma resolution of the input video.
  //    eAVEncVideoChromaResolution_SameAsSource,
  //    eAVEncVideoChromaResolution_444,
  //    eAVEncVideoChromaResolution_422,
  //    eAVEncVideoChromaResolution_420,
  //    eAVEncVideoChromaResolution_411
  Optional<uint32_t> av_enc_video_input_chroma_resolution;
  // Specifies the chroma siting for the input video.
  Optional<uint32_t> av_enc_video_input_chroma_subsampling;
  // Specifies the intended lighting conditions for viewing the input video.
  //    eAVEncVideoColorLighting_SameAsSource,
  //    eAVEncVideoColorLighting_Unknown,
  //    eAVEncVideoColorLighting_Bright,
  //    eAVEncVideoColorLighting_Office,
  //    eAVEncVideoColorLighting_Dim,
  //    eAVEncVideoColorLighting_Dark
  Optional<uint32_t> av_enc_video_input_color_lighting;
  // Specifies the nominal range for the input video.
  //    eAVEncVideoColorNominalRange_SameAsSource,
  //    eAVEncVideoColorNominalRange_0_255,
  //    eAVEncVideoColorNominalRange_16_235,
  //    eAVEncVideoColorNominalRange_48_208
  Optional<uint32_t> av_enc_video_input_color_nominal_range;
  // Specifies the color primaries for the input video.
  //    eAVEncVideoColorPrimaries_SameAsSource,
  //    eAVEncVideoColorPrimaries_Reserved,
  //    eAVEncVideoColorPrimaries_BT709,
  //    eAVEncVideoColorPrimaries_BT470_2_SysM,
  //    eAVEncVideoColorPrimaries_BT470_2_SysBG,
  //    eAVEncVideoColorPrimaries_SMPTE170M,
  //    eAVEncVideoColorPrimaries_SMPTE240M,
  //    eAVEncVideoColorPrimaries_EBU3231,
  //    eAVEncVideoColorPrimaries_SMPTE_C
  Optional<uint32_t> av_enc_video_input_color_primaries;
  // Specifies the conversion function from RGB to RGB for input video
  //    eAVEncVideoColorTransferFunction_SameAsSource,
  //    eAVEncVideoColorTransferFunction_10,
  //    eAVEncVideoColorTransferFunction_18,
  //    eAVEncVideoColorTransferFunction_20,
  //    eAVEncVideoColorTransferFunction_22,
  //    eAVEncVideoColorTransferFunction_22_709,
  //    eAVEncVideoColorTransferFunction_22_240M,
  //    eAVEncVideoColorTransferFunction_22_8bit_sRGB,
  //    eAVEncVideoColorTransferFunction_28
  Optional<uint32_t> av_enc_video_input_color_transfer_function;
  // Specifies the conversion matrix from the YCbCr color space to the RGB color space, for the
  // input video.
  //    eAVEncVideoColorTransferMatrix_SameAsSource,
  //    eAVEncVideoColorTransferMatrix_BT709,
  //    eAVEncVideoColorTransferMatrix_BT601,
  //    eAVEncVideoColorTransferMatrix_SMPTE240M
  Optional<uint32_t> av_enc_video_input_color_transfer_matrix;
  // Specifies whether the encoder performs inverse telecine.
  Optional<bool> av_enc_video_inverse_telecine_enable;
  // Sets the threshold at which the encoder considers a video field redundant.
  Optional<uint32_t> av_enc_video_inverse_telecine_threshold;
  // Specifies the maximum number of frames between key frames.
  Optional<uint32_t> av_enc_video_max_keyframe_distance;
  // Specifies the number of fields to encode.
  // For progressive video, set this property to twice the number of frames to encode.
  Optional<uint32_t> av_enc_video_no_of_fields_to_encode;
  // Specifies the number of fields to skip during encoding.
  // For progressive video, set this property to twice the number of frames to skip.
  Optional<uint64_t> av_enc_video_no_of_fields_to_skip;
  // Specifies the chroma resolution of the encoded video.
  //    eAVEncVideoChromaResolution_SameAsSource,
  //    eAVEncVideoChromaResolution_444,
  //    eAVEncVideoChromaResolution_422,
  //    eAVEncVideoChromaResolution_420,
  //    eAVEncVideoChromaResolution_411
  Optional<uint32_t> av_enc_video_output_chroma_resolution;
  // Specifies the chroma siting for the encoded video.
  //    eAVEncVideoChromaSubsamplingFormat_SameAsSource,
  //    eAVEncVideoChromaSubsamplingFormat_ProgressiveChroma,
  //    eAVEncVideoChromaSubsamplingFormat_Horizontally_Cosited,
  //    eAVEncVideoChromaSubsamplingFormat_Vertically_Cosited,
  //    eAVEncVideoChromaSubsamplingFormat_Vertically_AlignedChromaPlanes
  Optional<uint32_t> av_enc_video_output_chroma_subsampling;
  // Specifies the intended lighting conditions for viewing the encoded video.
  //    eAVEncVideoColorLighting_SameAsSource,
  //    eAVEncVideoColorLighting_Unknown,
  //    eAVEncVideoColorLighting_Bright,
  //    eAVEncVideoColorLighting_Office,
  //    eAVEncVideoColorLighting_Dim,
  //    eAVEncVideoColorLighting_Dark
  Optional<uint32_t> av_enc_video_output_color_lighting;
  // Specifies the nominal range for the encoded video.
  //    eAVEncVideoColorNominalRange_SameAsSource,
  //    eAVEncVideoColorNominalRange_0_255,
  //    eAVEncVideoColorNominalRange_16_235,
  //    eAVEncVideoColorNominalRange_48_208
  Optional<uint32_t> av_enc_video_output_color_nominal_range;
  // Specifies the color primaries for the encoded video.
  //    eAVEncVideoColorPrimaries_SameAsSource,
  //    eAVEncVideoColorPrimaries_Reserved,
  //    eAVEncVideoColorPrimaries_BT709,
  //    eAVEncVideoColorPrimaries_BT470_2_SysM,
  //    eAVEncVideoColorPrimaries_BT470_2_SysBG,
  //    eAVEncVideoColorPrimaries_SMPTE170M,
  //    eAVEncVideoColorPrimaries_SMPTE240M,
  //    eAVEncVideoColorPrimaries_EBU3231,
  //    eAVEncVideoColorPrimaries_SMPTE_C
  Optional<uint32_t> av_enc_video_output_color_primaries;
  // Specifies the conversion function from RGB to RGB' for encoded video.
  //    eAVEncVideoColorTransferFunction_SameAsSource,
  //    eAVEncVideoColorTransferFunction_10,
  //    eAVEncVideoColorTransferFunction_18,
  //    eAVEncVideoColorTransferFunction_20,
  //    eAVEncVideoColorTransferFunction_22,
  //    eAVEncVideoColorTransferFunction_22_709,
  //    eAVEncVideoColorTransferFunction_22_240M,
  //    eAVEncVideoColorTransferFunction_22_8bit_sRGB,
  //    eAVEncVideoColorTransferFunction_28
  Optional<uint32_t> av_enc_video_output_color_transfer_function;
  // Specifies the conversion matrix from the YCbCr color space to the RGB color space, for the
  // encoded video.
  //    eAVEncVideoColorTransferMatrix_SameAsSource,
  //    eAVEncVideoColorTransferMatrix_BT709,
  //    eAVEncVideoColorTransferMatrix_BT601,
  //    eAVEncVideoColorTransferMatrix_SMPTE240M
  Optional<uint32_t> av_enc_video_output_color_transfer_matrix;
  // Specifies the frame rate on the encoders output stream, in frames per second.
  // Frame rate	    Ratio
  // 23.97	        24000/1001
  // 24	            24/1
  // 25	            25/1
  // 29.97	        30000/1001
  // 30	            30/1
  // 50	            50/1
  // 59.94	        60000/1001
  // 60	            60/1
  Optional<uint64_t> av_enc_video_output_frame_rate;
  // Specifies whether the encoder converts the frame rate when the output frame rate does not match
  // the input frame rate.
  //    eAVEncVideoOutputFrameRateConversion_Disable,
  //    eAVEncVideoOutputFrameRateConversion_Enable,
  //    eAVEncVideoOutputFrameRateConversion_Alias
  Optional<uint32_t> av_enc_video_output_frame_rate_conversion;
  // Specifies how the encoder interlaces the output video.
  //    eAVEncVideoOutputScan_Progressive,
  //    eAVEncVideoOutputScan_Interlaced,
  //    eAVEncVideoOutputScan_SameAsInput,
  //    eAVEncVideoOutputScan_Automatic
  Optional<uint32_t> av_enc_video_output_scan_type;
  // Specifies the pixel aspect ratio.
  // The upper 16 bits of the value contain the width, and the lower 16 bits contain the height.
  Optional<uint32_t> av_enc_video_pixel_aspect_ratio;
  // Specifies whether the original source of the input video was film or video.
  //    eAVEncVideoFilmContent_VideoOnly,
  //    eAVEncVideoFilmContent_FilmOnly,
  //    eAVEncVideoFilmContent_Mixed
  Optional<uint32_t> av_enc_video_source_film_content;
  // Specifies whether the video is monochrome (black and white) or contains color.
  Optional<bool> av_enc_video_source_is_bw;
  // Specifies whether the encoder adds a sequence end code at the end of the stream.
  Optional<bool> av_enc_mpv_add_seq_end_code;
  // Specifies the default number of consecutive B frames between I and P frames.
  Optional<uint32_t> av_enc_mpv_default_b_picture_count;
  // Specifies whether the encoder produces encoded fields or encoded frames.
  //    eAVEncMPVFrameFieldMode_FieldMode,
  //    eAVEncMPVFrameFieldMode_FrameMode
  Optional<uint32_t> av_enc_mpv_frame_field_mode;
  // Specifies whether the encoder generates picture display extension headers.
  Optional<bool> av_enc_mpv_generate_header_pic_disp_ext;
  // Specifies whether the encoder generates picture extension headers.
  Optional<bool> av_enc_mpv_generate_header_pic_ext;
  // Specifies whether the encoder generates sequence display extension headers.
  Optional<bool> av_enc_mpv_generate_header_seq_disp_ext;
  // Specifies whether the encoder generates sequence extension headers.
  Optional<bool> av_enc_mpv_generate_header_seq_ext;
  // Specifies whether the encoder generates sequence scalable extension headers.
  Optional<bool> av_enc_mpv_generate_header_seq_scale_ext;
  // Specifies whether the encoder produces open GOPs or closed GOPs.
  Optional<bool> av_enc_mpvgop_open;
  // Specifies the number of GOPs between sequence headers.
  Optional<uint32_t> av_enc_mpvgops_in_seq;
  // Specifies the maximum number of pictures from one GOP header to the next GOP header.
  Optional<uint32_t> av_enc_mpvgop_size;
  // Specifies the precision of the DC coefficients.
  Optional<uint32_t> av_enc_mpv_intra_dc_precision;
  // Specifies which variable-length coding (VLC) table to use for entropy coding.
  //    eAVEncMPVIntraVLCTable_Auto,
  //    eAVEncMPVIntraVLCTable_MPEG1,
  //    eAVEncMPVIntraVLCTable_Alternate
  Optional<uint32_t> av_enc_mpv_intra_vlc_table;
  // Specifies the MPEG-2 level.
  //    eAVEncMPVLevel_Low,
  //    eAVEncMPVLevel_Main,
  //    eAVEncMPVLevel_High1440,
  //    eAVEncMPVLevel_High
  Optional<uint32_t> av_enc_mpv_level;
  // Specifies the MPEG-2 profile.
  //    eAVEncMPVProfile_unknown,
  //    eAVEncMPVProfile_Simple,
  //    eAVEncMPVProfile_Main,
  //    eAVEncMPVProfile_High,
  //    eAVEncMPVProfile_422
  Optional<uint32_t> av_enc_mpv_profile;
  // Specifies whether the quantizer scale is linear or non-linear.
  //    eAVEncMPVQScaleType_Auto,
  //    eAVEncMPVQScaleType_Linear,
  //    eAVEncMPVQScaleType_NonLinear
  Optional<uint32_t> av_enc_mpvq_scale_type;
  // Specifies the macroblock scan pattern.
  //    eAVEncMPVScanPattern_Auto,
  //    eAVEncMPVScanPattern_ZigZagScan,
  //    eAVEncMPVScanPattern_AlternateScan
  Optional<uint32_t> av_enc_mpv_scan_pattern;
  // Specifies how the encoder behaves when it detects a new scene.
  //    eAVEncMPVSceneDetection_None,
  //    eAVEncMPVSceneDetection_InsertIPicture,
  //    eAVEncMPVSceneDetection_StartNewGOP,
  //    eAVEncMPVSceneDetection_StartNewLocatableGOP
  Optional<uint32_t> av_enc_mpv_scene_detection;
  // Specifies whether the encoder uses concealment motion vectors.
  Optional<bool> enable_video_sender_frame_dropper;
  Optional<bool> av_enc_mpv_use_concealment_motion_vectors;

  Optional<bool> enable_nvdia_first;
  Optional<int32_t> nvdia_cpu_threshold_mhz;
  Optional<int32_t> intel_cpu_threshold_mhz;
  Optional<bool> vdm_not_override_lua_smallvideo_not_use_hwenc_policy;
  Optional<bool> enable_video_freeze_diagnose;
  Optional<bool> enable_video_qoe_assess;
  // Specifies the min resolution level to use h264 hardware encoder
  Optional<int> h264_hw_min_res_level;
  // mac slice num for a264, valid only when > 0
  Optional<int> av_enc_video_max_slices;
  Optional<bool> enable_pvc;
  Optional<int> pvc_one_model;
  Optional<bool> PvcSupport;
  Optional<int> PvcConfig;
  Optional<bool> enable_sr;
  Optional<int> sr_type;

  Optional<bool> isScreenSharingJbEnabled;
  Optional<bool> enable_video_vpr;
  Optional<int32_t> video_vpr_init_size;
  Optional<int32_t> video_vpr_max_size;
  Optional<int32_t> video_vpr_frozen_ms_thres;
  Optional<int32_t> video_vpr_frozen_rate_thres;
  Optional<int32_t> video_vpr_method;
  Optional<bool> retrans_detect_enable;
  Optional<bool> use_sent_ts_enable;
  // for intra request
  Optional<int32_t> av_enc_intra_key_interval;
  Optional<int32_t> key_force_device_score;
  Optional<int32_t> av_enc_bitrate_adjustment_type;
  Optional<int> video_rotation;
  Optional<int> scale_type;
  Optional<bool> scc_auto_framerate;
  Optional<bool> scc_quality_opt;
  Optional<bool> video_render_d3d9_texture;
  // whether default use a264;
  Optional<bool> av_enc_video_use_a264;
  // whether open vmaf calc;
  Optional<bool> av_enc_vmaf_calc;
  // screen sharing content type
  Optional<int32_t> av_enc_screen_sharing_subclass;
  Optional<int32_t> av_enc_video_width_alignment;
  Optional<int32_t> av_enc_video_height_alignment;
  Optional<std::string> av_enc_video_hwenc_config;
  Optional<std::string> av_dec_video_hwdec_config;
  Optional<bool> av_enc_video_force_alignment;
  Optional<bool> av_dec_output_byte_frame;
  // whether use single slice parser.
  Optional<bool> use_single_slice_parser;
  Optional<bool> color_space_enable;
  Optional<int> videoFullrange;
  Optional<int> matrixCoefficients;
  Optional<bool> enable_iptos;

  Optional<int> key_frame_interval_intra_request;
  Optional<int> video_switch_soft_decoder_threshold;
  Optional<int> min_encode_keyframe_interval;
  Optional<bool> video_skip_enable;
  Optional<bool> av_enc_new_complexity;
  Optional<int> av_enc_default_complexity;
  Optional<bool> enable_parser_reject;
  Optional<int> direct_cdn_streaming_h264_profile;

  Optional<int> bFrames;
 private:
  template <class T>
  std::string ToStringIfSet(const char* key, const Optional<T>& val) const {
    std::string str;
    if (val) {
      str = key;
      str = "\t\"" + str + "\"";
      str += ": ";
      str += std::to_string(*val);
      str += ",";
      str += NEW_LINE;
    }
    return str;
  }

  std::string ToStringIfSet(const char* key, const Optional<std::string>& val) const {
    std::string str;
    if (val) {
      str = key;
      str = "\t\"" + str + "\"";
      str += ": \"";
      str += val.value();
      str += "\",";
      str += NEW_LINE;
    }
    return str;
  }

  std::string ToStringIfSet(const char* key, const Optional<bool>& val) const {
    std::string str;
    if (val) {
      str = key;
      str = "\t\"" + str + "\"";
      str += ": ";
      str += *val ? "true" : "false";
      str += ",";
      str += NEW_LINE;
    }
    return str;
  }

  template <typename T>
  static void SetFrom(Optional<T>* s, const Optional<T>& o) {
    if (o) {
      *s = o;
    }
  }
};

}  // namespace rtc
}  // namespace agora
