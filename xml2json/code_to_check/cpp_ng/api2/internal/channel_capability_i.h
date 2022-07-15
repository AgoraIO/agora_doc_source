//
//  Agora Media SDK
//
//  Copyright (c) 2015 Agora IO. All rights reserved.
//
#pragma once

#include <cstdint>
#include <map>
#include <string>
#include <vector>

namespace agora {
namespace capability {

enum class ChannelProfile : uint8_t {
  kCommunication = 0,
  kBroadcasting,
  kUnifiedCommunication,
  kNASA,

  kNum
};

enum class AudioCodec : uint8_t {
  kL16 = 0,
  kG722,
  kOPUS,
  kOPUS2ch,
  kSILK,
  kNOVA,
  kAACLC,
  kAACLC2ch,
  kHEAAC,
  kHEAAC2ch,
  kJC1,

  kNum
};

enum class VideoCodec : uint8_t {
  kEVP = 0,
  kVP8,
  kE264,
  kH264,
  kH265,
  kAV1,
  kNum
};

enum class H264Feature : uint8_t {
  kINTRAREQUEST = 0,
  kPISE,
  kHIGHPROFILE,

  kNum
};

enum class VideoFEC : uint8_t {
  kNone = 0,
  kULP,
  kRS,
  kDM = 4,
  kRQ,

  kNum
};

enum class VideoFECIndex : uint8_t {
  kNoneIndex = 0,
  kULPIndex,
  kRSIndex,
  kDMIndex,
  kRQIndex,
};

enum class DmecVersions : uint8_t {
  kNone = 0,
  kDmv1,
  kDmv2,
  kDmv3,

  kNum
};

enum class Webrtc : uint8_t {
  kWebInterop = 0,

  kNum
};

enum class RtpExtension : uint8_t {
  kTwoBytes = 0,

  kNum
};

enum class AudioRsfec : uint8_t {
  kSupport = 0,

  kNum
};

enum class CapabilityType : uint8_t {
  kChannelProfile = 0,
  kAudioCodec,     //1
  kVideoCodec,     //2
  kH264Feature,    //3
  kVideoFec,       //4
  kWebrtc,         //5
  kP2P,            //6
  kAudioRsfec,     //7
  kRtpExtension,   //8
  kAudio2InAut,   // 9
  kVp8Feature,    // 10
  kSvc,           // 11
  kDmecVersion,   // 12
  kMultipleRedundancy,  //13
  kBframe,   // 14
};

enum class Vp8Feature : uint8_t {
  kSupportNasa,
  kSupportFec,
  kNum
};

enum class Svc : uint8_t {
  kVp8Support,
  kNum
};

enum class Bframe : uint8_t {
  kH264Support,
  kNum
};

struct CapabilityItem {
  uint8_t id;
  std::string name;
  CapabilityItem() {}
  CapabilityItem(uint8_t i, const std::string& n) : id(i), name(n) {}
};

using CapabilityItems = std::vector<CapabilityItem>;
using Capabilities = std::map<CapabilityType, CapabilityItems>;

}  // namespace capability
}  // namespace agora
