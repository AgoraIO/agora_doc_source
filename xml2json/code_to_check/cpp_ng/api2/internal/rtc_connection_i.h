//
//  Agora Media SDK
//
//  Created by Sting Feng in 2015-05.
//  Copyright (c) 2015 Agora IO. All rights reserved.
//
#pragma once

#include <functional>
#include <list>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "IAgoraService.h"
#include "NGIAgoraRtcConnection.h"

namespace agora {
namespace base {
class BaseWorker;
struct ExtraReportData;
}  // namespace base

namespace commons {
namespace network {
struct network_info_t;
}  // namespace network
}  // namespace commons

namespace config {
class IConfigEngineListener;
}  // namespace config

namespace rtc {

namespace protocol {
struct CmdRecordingEventReportArgus;
}  // namespace protocol

class CallContext;
class IRtcEngineEventHandler;
class InternalConnectionEventHandler;
class IAudioEngineWrapper;
class IVideoEngine;
class AudioPacketFilter;
class VideoPacketFilter;
struct audio_packet_t;
struct SAudioFrame;
struct video_packet_t;
struct peer_message_t;
struct control_broadcast_packet_t;
struct video_custom_ctrl_broadcast_packet_t;
struct WebAgentVideoStats;

static const uint8_t AUDIO_MEDIA_PACKET_PAYLOAD_TYPE = 127;

struct PacketOptions : media::base::PacketOptions {
  // Agora will ignore unknown payload type
  uint8_t payload_type;
  // if enabled audio rs-fec
  bool rsfec;
  // RTP ssrc
  uint32_t ssrc;
  // bool is_key_frame;
  // uint8_t frame_packet_count;
  // uint8_t frame_packet_sequence;
  // if packet is encrypted
  bool encrypted;
  // payload with agora header
  bool with_agora_header;
  PacketOptions()
      : media::base::PacketOptions(),
        payload_type(0),
        rsfec(false),
        ssrc(0),
        encrypted(false),
        with_agora_header(false) {}
};

enum CongestionControlType {
  CONGESTION_CONTROLLER_TYPE_AGORA_CC = 0,

  CONGESTION_CONTROLLER_TYPE_REMB,

  CONGESTION_CONTROLLER_TYPE_TRANSPORT_CC,

  CONGESTION_CONTROLLER_TYPE_AUT_CC
};

enum ConnectionMode {
  // In active mode, broadcast messages will be sent through the connection.
  // This is used as a publisher is bound with the connection.
  CONNECTION_MODE_ACTIVE,
  // In passive mode, broadcast messages will not be sent through the
  // connection.
  // This is used as default mode and no publisher is bound with the connection,
  CONNECTION_MODE_PASSIVE
};

struct RtcConnectionConfigurationEx : RtcConnectionConfiguration {
  RtcConnectionConfigurationEx()
      : RtcConnectionConfiguration::RtcConnectionConfiguration(),
        clientType(0),
#ifdef P2P_SWITCH_DEFAULT_VALUE
        is_p2p_switch_enabled(P2P_SWITCH_DEFAULT_VALUE)
#else
        is_p2p_switch_enabled(false)
#endif
      {}

  RtcConnectionConfigurationEx(const RtcConnectionConfiguration& rhs) {
    autoSubscribeAudio = rhs.autoSubscribeAudio;
    autoSubscribeVideo = rhs.autoSubscribeVideo;
    enableAudioRecordingOrPlayout = rhs.enableAudioRecordingOrPlayout;
    maxSendBitrate = rhs.maxSendBitrate;
    audioSubscriptionOptions = rhs.audioSubscriptionOptions;
    minPort = rhs.minPort;
    maxPort = rhs.maxPort;
    channelProfile = rhs.channelProfile;
    audioRecvEncodedFrame = rhs.audioRecvEncodedFrame;
    audioRecvMediaPacket = rhs.audioRecvMediaPacket;
    videoRecvMediaPacket = rhs.videoRecvMediaPacket;
    clientType = 0;
#ifdef P2P_SWITCH_DEFAULT_VALUE
    is_p2p_switch_enabled = P2P_SWITCH_DEFAULT_VALUE;
#else
    is_p2p_switch_enabled = false;
#endif
  }
  int clientType;
  bool is_p2p_switch_enabled;
  std::list<std::string> vosList;
};

struct ReceivePacketHandler {
  using onAudioPacketType = std::function<int(audio_packet_t&)>;
  using onVideoPacketType = std::function<int(video_packet_t&)>;
  using onControlBroadcastPacketType = std::function<int(control_broadcast_packet_t&)>;
  using onPeerMessageType = std::function<int(const peer_message_t&)>;
  using onVideoCustomCtrlPacketType = std::function<int(video_custom_ctrl_broadcast_packet_t&)>;
  using onAudioFrameType = std::function<int(SAudioFrame&)>;

  onAudioPacketType onAudioPacket_;
  onVideoPacketType onVideoPacket_;
  onControlBroadcastPacketType onControlBroadcastPacket_;
  onPeerMessageType onPeerMessagePacket_;
  onVideoCustomCtrlPacketType onVideoCustomCtrlPacket_;
  onAudioFrameType onAudioFrame_;
  ReceivePacketHandler(onAudioPacketType&& onAudioPacket = nullptr,
                       onVideoPacketType&& onVideoPacket = nullptr,
                       onControlBroadcastPacketType&& onControlBroadcastPacket = nullptr,
                       onPeerMessageType&& onPeerMessagePacket = nullptr,
                       onVideoCustomCtrlPacketType&& onVideoCustomCtrlPacket = nullptr,
                       onAudioFrameType&& onAudioFrame = nullptr)
      : onAudioPacket_(std::move(onAudioPacket)),
        onVideoPacket_(std::move(onVideoPacket)),
        onControlBroadcastPacket_(std::move(onControlBroadcastPacket)),
        onPeerMessagePacket_(std::move(onPeerMessagePacket)),
        onVideoCustomCtrlPacket_(std::move(onVideoCustomCtrlPacket)),
        onAudioFrame_(std::move(onAudioFrame)) {}
  ReceivePacketHandler(ReceivePacketHandler&& rhs)
      : onAudioPacket_(std::move(rhs.onAudioPacket_)),
        onVideoPacket_(std::move(rhs.onVideoPacket_)),
        onControlBroadcastPacket_(std::move(rhs.onControlBroadcastPacket_)),
        onPeerMessagePacket_(std::move(rhs.onPeerMessagePacket_)),
        onVideoCustomCtrlPacket_(std::move(rhs.onVideoCustomCtrlPacket_)),
        onAudioFrame_(std::move(rhs.onAudioFrame_)) {}
};

struct RtcConnStats {
  RtcStats stats;
  uint64_t banned_elapse = 0;
  uint64_t space_id = UINT64_MAX;
};

class IRtcConnectionEx : public IRtcConnection, public INetworkObserver {
 public:
  virtual int initialize(const base::AgoraServiceConfiguration& serviceCfg,
                         const RtcConnectionConfiguration& cfg) = 0;
  virtual int initializeEx(const base::AgoraServiceConfiguration& serviceCfg,
                           const RtcConnectionConfigurationEx& cfg) = 0;
  virtual int deinitialize() = 0;
  virtual void setUserRole(CLIENT_ROLE_TYPE role) = 0;
  virtual CLIENT_ROLE_TYPE getUserRole() = 0;
  virtual bool isEncryptionEnabled() const = 0;
  virtual int sendAudioPacket(audio_packet_t& packet, int delay_ms = 0) = 0;
  virtual int sendAudioFrame(SAudioFrame& frame) = 0;
  virtual int sendVideoPacket(video_packet_t& packet) = 0;
  virtual int batchSendVideoPacket(std::vector<video_packet_t>& packets) = 0;
  virtual int sendControlBroadcastPacket(std::string&& data) = 0;
  virtual int sendPeerMessage(peer_message_t& message) = 0;
  virtual int sendVideoCustomCtrlBroadcastPacket(video_custom_ctrl_broadcast_packet_t& packet) = 0;
  virtual void subscribeReceivePacketHandler(ReceivePacketHandler&& handler) = 0;
  virtual void unsubscribeReceivePacketHandler() = 0;
  virtual void setChannelId(const char* channel) = 0;
  virtual void setConnectionState(CONNECTION_STATE_TYPE state) = 0;
  virtual void setLocalUserId(user_id_t userId) = 0;
  // FIXME: remove this after we rework internal logic. Only modules of the call
  // engine relies on CallContext
  virtual CallContext* getCallContext() = 0;
  virtual std::shared_ptr<base::BaseWorker> getIOWorker() = 0;
  virtual bool getUid(user_id_t userId, rtc::uid_t* uid) = 0;
  virtual bool getUserId(rtc::uid_t uid, std::string& userId) = 0;
  virtual rtc::uid_t getLocalUid() = 0;
  virtual void muteLocalAudio(bool mute) = 0;
  virtual void muteRemoteAudio(user_id_t userId, bool mute) = 0;
  virtual void muteAllRemoteAudio(bool mute) = 0;
  virtual void setDefaultMuteAllRemoteAudioStreams(bool mute) = 0;
  virtual void muteLocalVideo(bool mute) = 0;
  virtual void muteRemoteVideo(user_id_t userId, bool mute) = 0;
  virtual void muteAllRemoteVideo(bool mute) = 0;
  virtual void setDefaultMuteAllRemoteVideoStreams(bool mute) = 0;
  virtual void setRemoteVideoStreamType(user_id_t userId, VIDEO_STREAM_TYPE type) = 0;
  virtual void setRemoteDefaultVideoStreamType(VIDEO_STREAM_TYPE type) = 0;

  virtual void setRtcStats(const RtcStats& stats) = 0;
  virtual void setBannedTime(const uint64_t banned_time) = 0;
  virtual void setMediaSendDelay(uint32_t timeInMs) = 0;
  virtual uint32_t getMediaSendDelay() = 0;

  virtual RtcConnStats GetStats() = 0;
  virtual bool isConnected() = 0;
  virtual uint32_t getCid() = 0;
  virtual void setVos(const char* name, int port) = 0;
  virtual int reportArgusCounters(int* counterId, int* value, int count, user_id_t userId) = 0;
  virtual void setChannelProfile(CHANNEL_PROFILE_TYPE channel_profile) = 0;

  // The following functions should only be used in UT.
  virtual AudioPacketFilter* getAudioPacketFilter() = 0;
  virtual VideoPacketFilter* getVideoPacketFilter() = 0;
  virtual bool hasAudioRemoteTrack(user_id_t id) = 0;
  virtual bool hasVideoRemoteTrack(user_id_t id, uint32_t ssrc) = 0;
  // The upper functions should only be used by UT.

  virtual CongestionControlType ccType() = 0;

  // TODO(hanpengfei): maybe need to implement at other place.
  virtual bool isRtcContextValid() = 0;
  virtual void onClientRoleChanged(CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole) = 0;
  virtual void onApiCallExecuted(int err, const char* api, const char* result) = 0;
  virtual void networkChanged(commons::network::network_info_t&& networkInfo) = 0;
  virtual int sendReport(const void* data, size_t length, int level, int type, int retry,
                                    const base::ExtraReportData* extra) = 0;
  virtual int setParameters(const std::string& parameters, bool cache,
                                       bool suppressNotification) = 0;
  virtual int getParameters(const std::string& parameters, any_document_t& results) = 0;
  virtual void stopAsyncHandler(bool waitForExit) = 0;
  virtual bool registerEventHandler(IRtcEngineEventHandler* eventHandler,
                                               bool isExHandler) = 0;
  virtual bool unregisterEventHandler(IRtcEngineEventHandler* eventHandler) = 0;
  virtual void setPacketObserver(IPacketObserver* observer) = 0;
  virtual int sendWebAgentVideoStats(const std::string& uidstr,
                                     const WebAgentVideoStats& stats) = 0;
  virtual void sendRecordingArgusEvents(const protocol::CmdRecordingEventReportArgus& events) = 0;

  virtual int sendCallRating(const std::string& callId, int rating,
                                        const std::string& description) = 0;
  virtual bool isWebrtcPacerEnabled() = 0;
  virtual void didStreamMessageSync(uid_t userId, int streamId, const char* data, size_t length,
                            uint64_t sentTs) = 0;
  virtual int32_t setEncryptionSecret(const char* secret) = 0;
  virtual int32_t setEncryptionMode(const char* mode) = 0;
  virtual int32_t enableVosUserInfoHidden(bool enabled) = 0;
  virtual int32_t enableBuiltInMediaEncryption(bool enabled) = 0;
  virtual int32_t setAudioScenarioType(AUDIO_SCENARIO_TYPE type) = 0;
  virtual std::string getAppIdFromToken(const std::string& token) = 0;
};

}  // namespace rtc
}  // namespace agora
