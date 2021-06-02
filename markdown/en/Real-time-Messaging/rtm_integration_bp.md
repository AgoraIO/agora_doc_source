---
title: RTM SDK Integration Best Practices
platform: All Platforms
updatedAt: 2021-03-05 02:28:36
---
This article describes the best practices of RTM SDK integration.

## Renew your token

**(All SDKs)** A token stays valid for a maximum of 24 hours. If the token is invalid, and the client gets disconnected from the RTM server due to network or server failure, the SDK cannot get reconnected. A reconnection attempt causes the  `Token expired` error. You must logout and login again to successfully reconnect to the RTM server.

Agora recommends that you generate the token from your server and call `renewToken` to update the token for the SDK at a fixed interval, such as one hour. See [Generate an RTM Token](https://docs.agora.io/en/Real-time-Messaging/token_server_rtm?platform=All%20Platforms) to learn more about generating a token from your server.

The following code example shows how to update the token at a fixed interval:

```cpp
// C++
// Monitor the callback for token expiration
class MyHandler : public IRtmServiceEventHandler {
public:
  void onRenewTokenResult(const char* token, RENEW_TOKEN_ERR_CODE errorCode)
  {
    if (errorCode == RENEW_TOKEN_ERR_OK) {
      token_ = errorCode;
    }
    else {
      token_ = "";
    }
  }
    
  void setToken(const std::string& token) {
    token_ = token;
  }
    
  std::string getNewToken()
  {
    return token_;
  }
private:
  std::string token_;
};
  
// Get the token generated from the server and update the token for the SDK
void renewTokenDemoCode() {
  auto client = createRtmService();
  std::string appId = "";
  std::string token = "";
  std::string userId = "";
  bool stopped = false;
  MyHandler handler;
  handler.setToken(token);
  client->initialize("appId", &handler);
  client->login(token.c_str(), userId.c_str());
  // Wait for login success
  sleep(10);
    
  // Token Update token in a single thread
  while(!stopped) {
    // Update token every hour
    sleep(60 * 60);
    // Error handling
    if (handler.getNewToken().empty()) {
      break;
    }
    client->renewToken(handler.getNewToken().c_str());
  }
  client->logout();
  client->release();
}
```

## Manage your resources

### Release unneeded resources in time

**(C++ SDK, Java SDK)** Memory leaks may occur if you do not release resources in time. Although the GC (Garbage Collection) mechanism of Java can recycle Java objects, the low-level C++ API still uses Java objects for callbacks and may cause the app to crash.

Agora recommends that you call `release` to release RTM client objects and channel objects. 

### Avoid accessing released resources

**(All SDKs)** If you have released the RTM client object, Agora recommends that you do not access the related resources. Also, you cannot access the `RtmCallManager` object after releasing the RTM client object.

### Avoid releasing a channel object when it is in a callback of the channel object

**(C++ SDK, Java SDK, Objective-C SDK)** If you call `release` to release a channel object in a callback of the channel object, the app will hang. The reason is that the callback adds a lock to the object and the `release` method requires the same lock.

### Manage the lifecycle of resources

**(C++ SDK)** The objects `IRtmService` and `IChannel` have corresponding listeners, namely `IRtmServiceEventHandler` and `IChannelEventHandler`, respectively. You must ensure that lifecycles of these listeners are longer than their objects.

**(Objective-C SDK before v1.4.1)** The lifecycle of the `AgoraRtmChannel` object must be longer than that of the `AgoraRtmKit` object; otherwise, the `AgoraRtmKit` object may use the released `AgoraRtmChannel` object, causing your app to crash.

## Avoid blocked callbacks

Each callback of an RTM client instance runs in the same thread. A callback starts to execute when the previous callback finishes executing. If the previous callback takes too much time to execute, the callback cannot execute in time, and the queue of callbacks keeps growing.

- For the RTM Native SDK, if the queue size reaches a certain limit, additional callbacks are discarded.
- For the RTM Web SDK, the queue size does not have a limit, but a long callback queue may cause performance issues.

**(All SDKs)** Agora recommends that you execute callbacks in time and try to reduce the execution time of callbacks. Otherwise, the callbacks that follow may be blocked or lost.

## Handle the SIGPIPE signal

**(Linux C++ /Linux Java SDK)** The RTM Linux C++ / Linux Java server SDK does not block the SIGPIPE signal. You need to choose whether to block the SIGPIPE signal based on your use case. Generally, you need to block this signal. Otherwise, the client process exits by default after receiving the signal.
