//
//  Agora Media SDK
//
//  Created by Rao Qi in 2019.
//  Copyright (c) 2019 Agora IO. All rights reserved.
//
#pragma once

#include <atomic>
#include <memory>
#include <mutex>
#include <unordered_map>
#include <vector>

#include "AgoraBase.h"
#include "NGIAgoraVideoTrack.h"
#include "api/ISmoothRender.h"
#include "api/IAutoAdjustHarq.h"
#include "api/transport/network_types.h"
#include "call/rtp_config.h"

#include "rtc_connection_i.h"
#include "track_stat_i.h"
#include "video_config_i.h"
#include "common_defines.h"
#include "video_node_i.h"
#include "utils/thread/base_worker.h"
#include "utils/thread/thread_control_block.h"
#include "absl/types/optional.h"
#include "main/core/video/multi_stream_subscribe_interface.h"
#include "facilities/media_config/policy_chain/media_config_policy_chain.h"

namespace webrtc {
  class IFecMethodFactoryInterface;
  class ISmoothRenderFactory;
  class IRsfecCodecFactoryInterface;
  class IAutoAdjustHarq;
}

namespace agora {
namespace utils {

template <typename Observer>
class WeakObservers {
 public:
  WeakObservers() = default;
  ~WeakObservers() = default;

  bool add(std::shared_ptr<Observer> obs) {
    if (!obs) {
      return false;
    }

    std::lock_guard<std::mutex> _(obs_mutex_);
    observer_map_[obs.get()] = obs;
    return true;
  }

  int size() {
    std::lock_guard<std::mutex> _(obs_mutex_);
    return observer_map_.size();
  }

  // better to remove by raw pointer since we may unregister() -> remove() in DTOR
  bool remove(Observer* obs) {
    if (!obs) {
      return false;
    }

    std::lock_guard<std::mutex> _(obs_mutex_);
    if (observer_map_.find(obs) == observer_map_.end()) {
      return false;
    }

    observer_map_.erase(obs);
    return true;
  }

  void notify(std::function<void (std::shared_ptr<Observer>)>&& notify, worker_type worker = nullptr) {
    std::vector<std::shared_ptr<Observer>> obs_copy;

    {
      std::lock_guard<std::mutex> _(obs_mutex_);

      for (auto it = observer_map_.begin(); it != observer_map_.end();) {
        auto obs_shared = it->second.lock();
        if (!obs_shared) {
          it = observer_map_.erase(it);
          continue;
        }

        obs_copy.push_back(obs_shared);
        ++it;
      }
    }

    if(worker == nullptr) {
      for (auto obs : obs_copy) {
        notify(obs);
      }
    } else {
      std::vector<std::weak_ptr<Observer>> weak_obs_copy;
      for (auto obs : obs_copy)  {
        weak_obs_copy.push_back(obs);
      }

      worker->async_call(LOCATION_HERE, [weak_obs_copy, notify] {
        for (auto obs : weak_obs_copy) {
          auto obs_shared = obs.lock();
          if (obs_shared) {
            notify(obs_shared);
          }
        }
      });
    }
  }

 private:
  std::mutex obs_mutex_;
  std::unordered_map<Observer*, std::weak_ptr<Observer>> observer_map_;
};

}  // namespace utils

namespace rtc {

class VideoNodeRtpSink;
class VideoNodeRtpSource;
class VideoTrackConfigurator;

enum class InternalVideoSourceType : unsigned {
  None = 0,
  Camera = 1,
  // Not used in NG SDK
  Custom = 2,
  Screen = 3,
  CustomYuvSource = 4,
  CustomEncodedImageSource = 5,
  CustomPacketSource = 6,
  MixedSource = 7,
  TranscodedSource = 8,
};

enum VideoModuleId {
  VideoModuleCapture = 1,
  VideoModulePreprocess,
  VideoModuleEncode,
  VideoModuleNetwork,
  VideoModuleDecode,
  VideoModulePostprocess,
  VideoModuleRender,
  VideoModulePipeline,
};

enum VideoAvailabilityLevel {
  VideoAvailabilityLevel1 = 1,  // Completely unusable.
  VideoAvailabilityLevel2,      // Usable but with very poor experience.
  VideoAvailabilityLevel3,      // Usable but with poor experience.
};

// Events report. New enum can be added but do not change the existing value!
enum VideoPipelineEvent {
  kVideoUplinkEventStaticFrames = 1,  // Continous static frames, maybe green/black picktures.
};

// Events report. New enum can be added but do not change the existing value!
enum VideoProcessEvent {
  kVideoProcessEventNone = 0,

  // These events report will be throttled, refer to VideoEngine::doReportVideoEvent().
  kVideoProcessEventPreprocessEnqueueFailure = 1000,
  kVideoProcessEventPreprocessFrameFailure = 1001,
  kVideoProcessEventPreprocessNoIncomingFrame = 1002,  // No incoming frame for builtin VPM module
  kVideoProcessEventPreprocessCongested = 1003,
};

struct VideoAvailabilityIndicator {
  VideoAvailabilityLevel level;
  VideoModuleId module;
  int code;
  uid_t uid;
  int extra;
};

class IVideoTrackObserver : public std::enable_shared_from_this<IVideoTrackObserver> {
 public:
  virtual ~IVideoTrackObserver() = default;
  virtual void onLocalVideoStateChanged(int id,
                                        LOCAL_VIDEO_STREAM_STATE state,
                                        LOCAL_VIDEO_STREAM_ERROR errorCode,
                                        int timestamp_ms) {}

  virtual void onRemoteVideoStateChanged(uid_t uid,
                                         REMOTE_VIDEO_STATE state,
                                         REMOTE_VIDEO_STATE_REASON reason,
                                         int timestamp_ms) {}

  virtual void onFirstVideoFrameRendered(uid_t uid, int width, int height, int timestamp_ms) {}

  virtual void onFirstVideoFrameDecoded(uid_t uid, int width, int height, int timestamp_ms) {}

  virtual void onFirstVideoKeyFrameReceived(uid_t uid, int width, int height, int timestamp_ms) {}

  virtual void onSourceVideoSizeChanged(uid_t uid,
                                        int width, int height,
                                        int rotation, int timestamp_ms) {}
  virtual void onSendSideDelay(int id, int send_delay) {}
  virtual void onRecvSideDelay(uid_t uid, int recv_delay) {}
  virtual void onRecvSideFps(uid_t uid, int fps) {}
  virtual void onEncoderConfigurationChanged(int width, int height, int fps, int framerate) {}
  virtual void onCameraFacingChanged(int facing) {}
  virtual void OnSetRexferParams(bool fec_rexfer, float rexfer_alpha) {}
  virtual void OnRexferStatusUpdated(bool status, int32_t target_bitrate) {}
  virtual void onCameraInfoListChanged(CameraInfoList cameraInfoList) {}
  virtual void onVideoAvailabilityIndicatorEvent(VideoAvailabilityIndicator indicator) {};
  virtual void onVideoSizeChanged(uid_t uid, int width, int height, int rotation) {};
};

struct LocalVideoTrackStatsEx {
  LocalVideoTrackStats local_video_stats;
  int sent_loss_ratio;
};

class ILocalVideoTrackEx : public ILocalVideoTrack {
 public:
  enum DetachReason { MANUAL, TRACK_DESTROY, NETWORK_DESTROY };

  // keep the same as webrtc::RsfecConfig
  struct RsfecConfig {
    std::vector<int> fec_protection_factor;
    std::vector<std::vector<int>> fec_ratioLevel;
    std::vector<int> fec_rttThreshold;
    bool pec_enabled;
  };

  struct OPSParametersCollection {
    bool QuickAdaptNetwork;
    int MinFramerate;
    int MinHoldtimeAutoResizeZoomin;
    int MinHoldtimeAutoResizeZoomout;
    int QpAdjust;
    int IosH265Adjust;
    int min_qp;
    int max_qp;
    int frame_max_size;
    int lowBitrateCoeffForAutoResize;
    int highBitrateCoeffForAutoResize;
    int vqcAdjustStep;
    bool lowFrameRateMode;
    int start_framerate;
    int vqcLowbitrateThreshold;
    int vqcChangeResoType;
    std::string vqcResAdjustNumList;
    int vqcSwH264Qpadjust;
    std::string vqcVpxQpadjust;
    std::string vqcAv1Qpadjust;
    int lowLoadEstimateThres;
    int highLoadEstimateThres;
    int lowFpsThres;
    int highFpsThres;
  };

  struct AttachInfo {
    uint32_t uid;
    uint32_t cid;
    VideoNodeRtpSink* network;
    WeakPipelineBuilder builder;
    uint64_t stats_space;
    CongestionControlType cc_type;
    webrtc::CongestionControllerConfig cc_config;
    bool enable_two_bytes_extension;
    webrtc::RsfecConfig rsfec_config;

    //hardware encoder related
    std::string enable_hw_encoder;
    std::string hw_encoder_provider;
    absl::optional<bool> low_stream_enable_hw_encoder;

    //video config
    OPSParametersCollection ops_parameters;
    std::shared_ptr<webrtc::IFecMethodFactoryInterface> fec_method_factory;
    std::shared_ptr<webrtc::IAutoAdjustHarq> auto_adjust_harq;
    bool apas_aa_harq_enable = false;

    int fec_method;
    int dm_wsize;
    int dm_maxgc;
    bool dm_lowred;

    int32_t minimum_fec_level;
    int fec_fix_rate;
    int largest_ref_distance;
    bool enable_check_for_disable_fec;

    // for intra request
    absl::optional<uint32_t> av_enc_intra_key_interval;

    absl::optional<uint32_t> av_enc_bitrate_adjustment_type;

    //enable video diagnose
    bool enable_video_send_diagnose;
    int max_packet_size;
    //video codec alignment
    absl::optional<uint32_t> hw_encoder_width_alignment;
    absl::optional<uint32_t> hw_encoder_height_alignment;
    absl::optional<bool> hw_encoder_force_alignment;
    unsigned int negotiated_video_decode_caps;//video decode capablitys
    //hw video encode configure
    std::string hw_encoder_fotmat_config;

    int hw_capture_delay;
    uint32_t sync_peer_uid;
    CHANNEL_PROFILE_TYPE channel_profile;
  };

  struct DetachInfo {
    VideoNodeRtpSink* network;
    DetachReason reason;
  };

  ILocalVideoTrackEx() : id_(id_generator_++) {}
  virtual ~ILocalVideoTrackEx() {}

  virtual bool hasPublished() = 0;

  virtual int SetVideoConfigEx(const VideoConfigurationEx& configEx, utils::ConfigPriority priority = utils::CONFIG_PRIORITY_USER) = 0;

  virtual int GetConfigExs(std::vector<VideoConfigurationEx>& configs) = 0;

  virtual void AddVideoAvailabilityIndicatorEvents(VideoAvailabilityIndicator event) {}

  virtual void GetVideoAvailabilityIndicatorEvents(std::vector<VideoAvailabilityIndicator>& events) {}

  virtual void ReconfigureFecMethod(int fec_method, int dmec_version) = 0;

  virtual int setUserId(uid_t uid) { user_id_ = uid; return 0; }

  virtual uid_t getUserId() { return user_id_; }

  virtual int getObserverSize() { return track_observers_.size(); }

  virtual int GetActiveStreamsCount() = 0;

  virtual int prepareNodes(const char* id = nullptr) = 0;

  virtual bool attach(const AttachInfo& info) = 0;
  virtual bool detach(const DetachInfo& info) = 0;

  virtual bool registerTrackObserver(std::shared_ptr<IVideoTrackObserver> observer) {
    return false;
  }
  virtual bool unregisterTrackObserver(IVideoTrackObserver* observer) {
    return false;
  }

  virtual bool getStatisticsEx(LocalVideoTrackStatsEx& statsEx) { return false; }

  virtual int32_t Width() const = 0;
  virtual int32_t Height() const = 0;
  virtual bool Enabled() const = 0;
  // TODO(Qingyou Pan): Need refine code to remove this interface.
  virtual int addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options) { return -ERR_NOT_SUPPORTED; };
  virtual int clearVideoWatermarks() { return -ERR_NOT_SUPPORTED; }

  virtual VideoTrackConfigurator* GetVideoTrackConfigurator() {
    return nullptr;
  }

  virtual InternalVideoSourceType getInternalVideoSourceType() { return InternalVideoSourceType::None; }

  int TrackId() const { return id_; }

  void setUniqueId(const std::string& unique_id) { unique_id_ = unique_id; }

 public:
  static void resetIdGenerator();

 protected:
  int id_;
  utils::WeakObservers<IVideoTrackObserver> track_observers_;
  uid_t user_id_;
  std::string unique_id_;

 private:
  static std::atomic<int> id_generator_;
};

struct RemoteVideoTrackStatsEx : RemoteVideoTrackStats {
  uint64_t firstDecodingTimeTickMs = 0;
  uint64_t firstVideoFrameRendered = 0;
  bool isHardwareCodec = false;
  int64_t totalFrozen200ms = 0;
  uint32_t last_frame_max = 0;
  uint32_t dec_in_num = 0;
  uint32_t render_in_num = 0;
  uint32_t render_out_num = 0;
  uint32_t fec_pkts_num = 0;
  uint32_t loss_af_fec = 0;
  std::vector<VideoAvailabilityIndicator> video_availability;
};

class IRemoteVideoTrackEx : public IRemoteVideoTrack {
 public:
  enum DetachReason { MANUAL, TRACK_DESTROY, NETWORK_DESTROY };
  using RemoteVideoEvents = StateEvents<REMOTE_VIDEO_STATE, REMOTE_VIDEO_STATE_REASON>;

  struct AttachInfo {
    VideoNodeRtpSource* source;
    VideoNodeRtpSink* rtcp_sender;
    WeakPipelineBuilder builder;
    bool recv_media_packet = false;
    uint64_t stats_space = 0;
    std::shared_ptr<webrtc::ISmoothRenderFactory> smooth_render_factory;
    bool disable_rewrite_num_reorder_frame = false;
    std::shared_ptr<webrtc::IRsfecCodecFactoryInterface> rsfec_codec_factory;
  };

  struct DetachInfo {
    VideoNodeRtpSource* source;
    VideoNodeRtpSink* rtcp_sender;
    DetachReason reason;
  };

  IRemoteVideoTrackEx() = default;

  virtual ~IRemoteVideoTrackEx() {}

  virtual uint32_t getRemoteSsrc() = 0;

  virtual bool attach(const AttachInfo& info, REMOTE_VIDEO_STATE_REASON reason) = 0;
  virtual bool detach(const DetachInfo& info, REMOTE_VIDEO_STATE_REASON reason) = 0;

  virtual bool getStatisticsEx(RemoteVideoTrackStatsEx& statsex) { return false; }

  virtual bool registerTrackObserver(std::shared_ptr<IVideoTrackObserver> observer) {
    return false;
  }
  virtual bool unregisterTrackObserver(IVideoTrackObserver* observer) {
    return false;
  }

 protected:
  utils::WeakObservers<IVideoTrackObserver> track_observers_;
};

}  // namespace rtc
}  // namespace agora
