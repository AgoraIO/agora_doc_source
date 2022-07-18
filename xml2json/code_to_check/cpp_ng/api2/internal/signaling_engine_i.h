//
//  Agora Media SDK
//
//  Created by Sting Feng in 2015-05.
//  Copyright (c) 2015 Agora IO. All rights reserved.
//
#pragma once

#include <string>

#include "IAgoraSignalingEngine.h"

namespace agora {
namespace commons {
namespace cjson {
class JsonWrapper;
}  // namespace cjson
}  // namespace commons

typedef agora::commons::cjson::JsonWrapper any_document_t;

namespace signaling {

enum class SIGNALING_EVENT
{
    NATIVE_LOG = 100,
    ERROR_EVENT = 101,
    WARNING_EVENT = 102,

    API_CALL_EXECUTED = 1000,
    PEER_JOIN_CHANNEL = 1001,
    PEER_LEAVE_CHANNEL = 1002,
    CHANNEL_PEER_LIST_UPDATED = 1003,
    CHANNEL_ATTRIBUTES_UPDATED = 1004,
    CONNECTION_LOST = 1005,
    CONNECTION_INTERRUPTED = 1006,
    CONNECTION_RESTORED = 1007,
};

class ISignalingEngineEventHandlerEx : public ISignalingEngineEventHandler
{
public:
    virtual bool onEvent(SIGNALING_EVENT evt, std::string* payload) {
        (void)evt;
        (void)payload;

        /* return false to indicate this event is not handled */
        return false;
    }
};

class ISignalingEngineEx : public ISignalingEngine
{
public:
    virtual int setParameters(const char* parameters) = 0;
    virtual int getParameters(const char* key, any_document_t& result) = 0;
};

}  // namespace signaling
}  // namespace agora
