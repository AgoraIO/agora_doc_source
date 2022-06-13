//  Agora RTC/MEDIA SDK
//
//  Created by Pengfei Han in 2019-06.
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
#pragma once

#include <cstdint>
#include <list>
#include <memory>
#include <string>
#include <vector>

#include "AgoraBase.h"

namespace agora {
namespace rtc {


static const uint8_t kVideoEngineFlagHasIntraRequest = 0x10;
static const uint8_t kVideoEngineFlagStdCodec = 0x8;
static const uint8_t kVideoEngineFlagNasa = 0x40;
static const uint8_t kVideoEngineFlagScalableDelta = 0x80;
static const uint8_t kVideoEngineFlagMajorStreamOnly = 0x01;

static const uint8_t kAgoraHeaderLength = 3;
static const uint8_t kAgoraAudioExtendLength = 5;

enum MEDIA_STREAM_TYPE {
  MEDIA_STREAM_TYPE_AUDIO = (1 << 0),
  MEDIA_STREAM_TYPE_VIDEO_LOW = (1 << 1),
  MEDIA_STREAM_TYPE_VIDEO_HIGH = (1 << 2),
  MEDIA_STREAM_TYPE_VIDEO = (MEDIA_STREAM_TYPE_VIDEO_LOW | MEDIA_STREAM_TYPE_VIDEO_HIGH),
};

struct SMediaFrame {
  uid_t uid_;
  uint8_t flags_;
  uint16_t seq_;
  uint16_t ssrc_;
  uint64_t packetSentTs_;
  uint64_t sentTs_;
  uint64_t receiveTs_;
  std::string payload_;
  SMediaFrame() : uid_(0), flags_(0), seq_(0), ssrc_(0), sentTs_(0), receiveTs_(0) {}
};

struct SAudioFrame : public SMediaFrame {
  uint8_t codec_;
  uint32_t ts_;
  int8_t vad_;
  uint8_t internalFlags_;
  uint8_t audio_fec_level_;
  uint16_t cc_type_;
  SAudioFrame() : SMediaFrame(), codec_(0), ts_(0), vad_(0), internalFlags_(0), cc_type_(0) {}
};

using SharedSAudioFrame = std::shared_ptr<SAudioFrame>;

struct SAudioPacket {
  enum AUDIO_PACKET_TYPE {
    AUDIO_PACKET_REXFERRED = 0x1,
    AUDIO_PACKET_FROM_VOS = 0x2,
    AUDIO_PACKET_FROM_P2P = 0x4,
  };
  int8_t vad_;
  uint8_t codec_;
  uint8_t internalFlags_;
  uint16_t seq_;
  uint16_t ssrc_;
  uint16_t payloadLength_;
  uint16_t latestFrameSeq_;
  std::list<SharedSAudioFrame> frames_;
  SAudioPacket()
      : vad_(0),
        codec_(0),
        internalFlags_(0),
        seq_(0),
        ssrc_(0),
        payloadLength_(0),
        latestFrameSeq_(0) {}
};

struct rtc_packet_t {
  enum INTERNAL_FLAG_TYPE {
    RTC_FLAG_REXFERRED = 0x1,
    RTC_FLAG_FROM_VOS = 0x2,
    RTC_FLAG_FROM_P2P = 0x4,
    RTC_FLAG_FROM_BROADCAST = 0x8,
    VIDEO_FLAG_TIMESTAMP_SET = 0x10,
    VIDEO_FLAG_CACHED = 0x20,
    VIDEO_FLAG_VIDEO3 = 0x40,
  };
  uid_t uid;
  uint32_t seq;
  uint16_t payload_length;  // should be the same as payload.length()
  uint64_t sent_ts;
  uint64_t recv_ts;
  int link_id;
  uint8_t internal_flags;
  std::string payload;
  rtc_packet_t()
      : uid(0), seq(0), payload_length(0), sent_ts(0), recv_ts(0), link_id(-1), internal_flags(0) {}
  virtual ~rtc_packet_t() {}
};

struct broadcast_packet_t : public rtc_packet_t {
  bool quit;
  bool rtcp;
  bool need_reliable;
  bool real_quit;
  bool audience_send;
  broadcast_packet_t()
    : quit(false), rtcp(false), need_reliable(false), real_quit(false), audience_send(false) {}
};

struct audio_packet_t : public rtc_packet_t {
  uint32_t ts;
  int8_t vad;
  uint8_t codec;
  int last_error;  // error code set by last filter
  uint32_t reqMs;  // for calculating RTT only
  uint8_t flags;   // flags from SAudioFrame
  audio_packet_t() : ts(0), vad(0), codec(0), last_error(0), reqMs(0), flags(0) {}
};

struct video_packet_t : public rtc_packet_t {
  enum VIDEO_STREAM_TYPE {
    VIDEO_STREAM_UNKNOWN = -1,
    VIDEO_STREAM_HIGH = 0,
    VIDEO_STREAM_LOW = 1,
    VIDEO_STREAM_MEDIUM = 2,
    VIDEO_STREAM_LIVE = 3,
    VIDEO_STREAM_MIN = VIDEO_STREAM_HIGH,
    VIDEO_STREAM_MAX = VIDEO_STREAM_LIVE,
  };

  enum VIDEO_FLAG_TYPE {
    // below is for video2 only, not used in video3
    VIDEO_FLAG_KEY_FRAME = 0x80,
    VIDEO_FLAG_FEC = 0x40,
    VIDEO_FLAG_LIVE = 0x20,
    VIDEO_FLAG_STD_CODEC = 0x8,  // also for video3 to differentiate std stream and private stream
    VIDEO_FLAG_B_FRAME = 0x10,
    // below is for video3
    VIDEO_FLAG_HARDWARE_ENCODE = 0x4,
  };

  enum VIDEO_FRAME_TYPE {
    KEY_FRAME = 0,
    DELTA_FRAME = 1,
    B_FRAME = 2,
  };

  // TODO(Bob): This should be removed and use public API definitions.
  enum VIDEO_CODEC_TYPE {
    VIDEO_CODEC_VP8 = 1,   // std VP8
    VIDEO_CODEC_H264 = 2,  // std H264
    VIDEO_CODEC_EVP = 3,   // VP8 with BCM
    VIDEO_CODEC_E264 = 4,  // H264 with BCM
  };

  enum VIDEO_EXTRA_FLAG_TYPE {
    // marks if the |req_ms| field of PVideoRexferRes_v4 is set
    VIDEO_EXTRA_FLAG_TIMESTAMP_SET = 0x1,
  };

  enum EXTENSION_VERSION {
    EXTENSION_VERSION_0 = 0,
    EXTENSION_VERSION_1 = 1,
    EXTENSION_VERSION_2 = 2,
  };

  struct Extension {
    bool has_extension_ = false;
    uint16_t tag_ = EXTENSION_VERSION_0;
    std::vector<uint32_t> content_;
  };

  uint32_t frameSeq;
  uint8_t frameType;
  uint8_t streamType;
  uint16_t packets;
  uint16_t subseq;
  uint8_t fecPkgNum;
  uint8_t codec;
  uint8_t flags;
  uint8_t protocolVersion;
  uint32_t reqMs;  // for calculating RTT only
  uint32_t reserve1;
  Extension extension;
  int64_t transport_seq;  // for transport-cc
  int8_t cc_type;
  uint8_t max_temporal_layers;
  uint8_t curr_temporal_layer;
  
  video_packet_t()
      : frameSeq(0),
        frameType(0),
        streamType(0),
        packets(0),
        subseq(0),
        fecPkgNum(0),
        codec(0),
        flags(0),
        protocolVersion(0),
        reqMs(0),
        reserve1(0),
        transport_seq(-1),
        cc_type(0) {}

  union video3_flags {
    struct {
      uint8_t stream_type : 4;
      uint8_t frame_type : 4;
    };
    uint8_t video_type;
  };

  void fromVideType(uint8_t f) {
    video3_flags t;
    t.video_type = f;
    streamType = t.stream_type;
    frameType = t.frame_type;
  }

  uint8_t toVideoType() const {
    video3_flags t;
    t.stream_type = streamType;
    t.frame_type = frameType;
    return t.video_type;
  }

  bool hasReserveBit(uint16_t bit) { return (reserve1 & (1 << bit)) == (1 << bit); }
};

struct control_broadcast_packet_t {
  rtc::uid_t uid = 0;
  bool from_vos = false;
  std::string payload;
};

struct video_custom_ctrl_broadcast_packet_t {
  rtc::uid_t uid;
  std::string payload;
};

struct peer_message_t {
  rtc::uid_t uid;
  int type;
  std::string user_id;
  std::string payload;
};

enum VideoStreamType {
  MASTER_VIDEO_STREAM = 0,
  LOW_BITRATE_VIDEO_STREAM = 1,
  MEDIUM_BITRATE_VIDEO_STREAM = 2,
  LIVE_VIDEO_STREAM = 3,
};


class IVideoListener
{
public:
    virtual ~IVideoListener() {}
    struct LocalVideoStreamStat
    {
      int width;
      int height;
      unsigned int prevFrameNumber;
      int sentBytes;
      int sentFrames;
      int sentQP;
      int sentPkgNumber;

      void reset() {
        sentBytes = 0;
        sentFrames = 0;
        sentQP = 0;
        sentPkgNumber = 0;
      }

      LocalVideoStreamStat() {
        prevFrameNumber = 0;
        width = 640;
        height = 360;
        reset();
      }

    };
    struct LocalVideoStat
    {

      // local stat
      LocalVideoStreamStat highStream;
      LocalVideoStreamStat lowStream;
      int sentRtt;
      int sentLoss;
      int sentTargetBitRate;
      int sentTargetFrameRate;
      int sentBitrateExcludeFec;
      unsigned int encodeTimeMs;
      unsigned int minEncodeTimeMs;
      unsigned int maxEncodeTimeMs;
      int captureWidth;
      int captureHeight;
      int captureFrames;
      int encoderRecvFrames;
      int encodedFrames;
      int encodedKeyFrames;
      unsigned int totalEncodedFrames;
      int encodeFailFrames;
      int encoderSkipFrames;
      int renderedFrames;
      int duration;
      int fecLevel;
      int estimateBandwidth;
      unsigned int maxFrameOutInterval;
      int uplinkFreezeCount;
      int uplinkFreezeTime;
      int cameraOpenStatus;
      int captureType;
      int renderType;
      uint64_t render_buffer_size;
      int beautyCostTime;
      // compressed states
      /*
        bit 31~28: version of this structure. value 1
        bit 27:    video engine exists.       0: not exist; 1: exit
        bit 26:    texture encode.            0: yuv encode; 1: texture encode (android only)
        bit 25:    app rendering.             0: sdk rendering; 1: app rendering
        // bit 25: sender disabled. 0: sender enabled; 1: sender disabled (duplicate with SDK Mute Status)
        bit 24~21: encoder codec index.
        // bit 24: hardware encode.           0: software encode; 1: hardware encode (duplicate with Video Hardware Encode)
        bit 20~19: fec type.
        bit 18:    has_intra_request (no periodic key frame) parameter setting.
        bit 17~13: reserved.
        bit 12~0:  camera id.
       */
      unsigned int bitFieldStates;

      void reset() {
        highStream.reset();
        lowStream.reset();
        sentRtt = 0;
        sentLoss = 0;
        sentTargetBitRate = 0;
        sentTargetFrameRate = 0;
        sentBitrateExcludeFec = 0;
        encodeTimeMs = 0;
        minEncodeTimeMs = 0;
        maxEncodeTimeMs = 0;
        captureWidth = 0;
        captureHeight = 0;
        captureFrames = 0;
        encoderRecvFrames = 0;
        encodedFrames = 0;
        encodeFailFrames = 0;
        encoderSkipFrames = 0;
        renderedFrames = 0;
        duration = 0;
        fecLevel = 0;
        estimateBandwidth = 0;
        maxFrameOutInterval = 0;
        cameraOpenStatus = -1;
        captureType = 0;
        renderType = -1;
        render_buffer_size = 0;
        beautyCostTime = 0;
      }
    };

    struct RemoteVideoStat
    {
      // remote stat
      int uid;
      int delay;
      int renderedFrames;
      int receivedBytes;
      int recvPkgNumber;
      int width;
      int height;
      int lossAfterFec;
      int decodeFailedFrames;
      int decodeRejectedFrames;
      int streamType;
      int decodedFrames;
      int rendererRecvFrames;
      int decodeTimeMs;
      int duration;
      int decodedQP;     // Add the QP reportor of decoder
      unsigned int maxRenderInterval;
      unsigned int lastRenderMs;
      unsigned int minFrameNumber;
      unsigned int maxFrameNumber;
      unsigned int freezeCnt;
      unsigned int freezeCnt300;
      unsigned int freezeCnt500;
      int freezeTimeMs;
      int freezeTimeMs300;
      int freezeTimeMs500;
      bool isHardwareDecoding;
      int decoderInFrames;
      int renderType;
      bool muted;
      uint64_t render_buffer_size;
      int decodeBgDroppedFrames;
      bool isSuperResolutionEnabled;

      void reset() {
        uid = 0;
        delay = 0;
        width = 0;
        height = 0;
        renderedFrames = 0;
        receivedBytes = 0;
        lossAfterFec = 0;
        decodeFailedFrames = 0;
        //streamType = 0;
        decodedFrames = 0;
        rendererRecvFrames = 0;
        decodeRejectedFrames = 0;
        decodeTimeMs = 0;
        recvPkgNumber = 0;
        duration = 0;
        maxRenderInterval = 0;
        decodedQP = 0;
        minFrameNumber = 0xFFFFFFFF;
        maxFrameNumber = 0;
        freezeCnt300 = 0;
        freezeTimeMs300 = 0;
        freezeCnt500 = 0;
        freezeTimeMs500 = 0;
        freezeCnt = 0;
        freezeTimeMs = 0;
        isHardwareDecoding = false;
        decoderInFrames = 0;
        renderType = -1;
        render_buffer_size = 0;
        decodeBgDroppedFrames = 0;
        isSuperResolutionEnabled = false;
      }
    };

    //    #define VIDEO_ENGINE_FLAG_KEY_FRAME 0x00000080
    //    #define VIDEO_ENGINE_FLAG_FEC 0x00000040
    //    #define VIDEO_ENGINE_FLAG_LIVE 0x00000020
    //    #define VIDEO_ENGINE_FLAG_B_FRAME 0x00000010
    #define VIDEO_ENGINE_FLAG_SCALABLE_DELTA 0x00000080
    #define VIDEO_ENGINE_FLAG_NASA 0x00000040
    #define VIDEO_ENGINE_FLAG_HAS_PISE 0x00000020
    #define VIDEO_ENGINE_FLAG_HAS_INTRA_REQUEST 0x00000010
    #define VIDEO_ENGINE_FLAG_STD_CODEC 0x00000008
    #define VIDEO_ENGINE_FLAG_HARDWARE_ENCODE 0x00000004
    #define VIDEO_ENGINE_FLAG_NEW_AVSYNC_TIMESTAMP 0x00000002
    #define VIDEO_ENGINE_FLAG_MULTI_STREAM 0x00000001

    enum VideoFrameType {
      KEY_FRAME = 0,
      DELTA_FRAME = 1,
      B_FRAME = 2,
      PISE_FRAME = 3,
      SCALABLE_DELTA_FRAME = 4,
    };
    enum VideoCodecType {
      VIDEO_CODEC_VP8 = 1,
      VIDEO_CODEC_H264 = 2,
      VIDEO_CODEC_EVP = 3,
      VIDEO_CODEC_E264 = 4,
    };
    
    struct PacketInfo
    {
      const void* packet;
      unsigned short packetLen;
      unsigned int frame_num;
      uint16_t frame_pkg_num;
      uint16_t pkg_seq_in_frame;
      unsigned char fec_num;
      unsigned char fec_method;
      int codec_type;
      VideoFrameType frame_type;
      VideoStreamType stream_type;
      unsigned int flag;
      int version;
      unsigned short reserve1;
    };
    struct AutStreamData {
      uint16_t bandwidth;
      uint8_t recv_stream_type;
      uint8_t expected_stream_type;
    };
    struct AutFeedbackData {
      uint16_t rtt;
      uint16_t lost_ratio;
      uint16_t bwe;
      uint16_t padding;
      uint16_t total_sent;
      uint16_t queueing_time;
      uint16_t active_uid_counts;
      uint16_t allocated;
      uint16_t mtu;
      uint16_t jitter95;
      std::list<AutStreamData> stream_info;
    };

    virtual int sendVideoPacket(const PacketInfo& info) = 0;

    virtual void onRemoteFirstFrameDrawed(int viewIndex, unsigned int uid, int width, int height) = 0;
    virtual void onLocalFirstFrameDrawed(int width, int height) = 0;
    virtual void onRemoteFirstFrameDecoded(unsigned int uid, int width, int height) = 0;
    virtual void onRemoteVideoInterrupted(unsigned int uid, unsigned int elapse_time) = 0;
    virtual void onVideoStat(const LocalVideoStat& localStat, RemoteVideoStat* remoteStat, int remoteCount) = 0;
    virtual void onVideoProfile(unsigned int width, unsigned int height, unsigned int fps, unsigned int bitrate) = 0;
    virtual void switchVideoStream(unsigned int uid, VideoStreamType stream) = 0;
    virtual void onBandWidthLevelChanged(int level) = 0;
    virtual void onCameraFocusAreaChanged(int x, int y, int width, int height) = 0;
    virtual void onCameraExposureAreaChanged(int x, int y, int width, int height) = 0;
    virtual void onVideoViewSizeChanged(int userID, int newWidth, int newHeight) {
      (void)userID;
      (void)newWidth;
      (void)newHeight;
    }

    virtual void onVideoFrameFrozen(unsigned int uid, bool frozen) = 0;

    virtual void onAppSetVideoStartBitRate(int value) = 0;

    virtual int onEncodeVideoSEI(char** info, int *len) = 0;
    virtual void onVideoSizeChanged(unsigned int uid, int newWidth, int newHeight, int newRotation) {
        (void)uid;
        (void)newWidth;
        (void)newHeight;
        (void)newRotation;
    }

    virtual void onSendVideoPaced(bool status) = 0;
    virtual void onBWELevel(int level) = 0;
    virtual void onVideoRexferStatus(bool status, int target_bitrate) = 0;
    virtual void onStartCaptureSuccess() = 0;
    // add for sei
    virtual int onSendSEI(char **info, int *len, long long timeStampMs, int streamType, bool isDualStream) = 0;
    virtual int onReceiveSEI(char *info, int len, unsigned int uid, long long timeStampMs) = 0;
    virtual void OnVideoStreamBitrateRangeChanged(VideoStreamType type,
        uint32_t max_kbps, uint32_t min_kbps) = 0;
};

}  // namespace rtc
}  // namespace agora
