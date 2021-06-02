---
title: 云信令（原实时消息）SDK 集成最佳实践
platform: All Platforms
updatedAt: 2021-03-05 10:30:17
---
本文包括集成云信令 SDK 时的最佳实践。

## 定时更新 Token

**(所有 SDK)** Token 的最长有效期是 24 小时。如果 Token 失效，且此时用户与 RTM 服务器的连接由于用户端网络或服务端故障断开，SDK 将无法自动恢复连接，因为自动重连会触发 `Token expired` 错误。此时你必须登出之后再登录才能恢复连接。

Agora 建议你定时（例如每小时）从服务端生成 Token 并调用 `renewToken` 方法更新 SDK 的 Token，保证 SDK 的 Token 一直处于有效状态。关于如何在服务端生成 Token，参考[生成 RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms)。

下面的示例代码展示了如何定时更新 Token。

```cpp
// C++
// 监听 Token 过期回调
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
 
// 获取服务端生成的 Token 并通过 renewToken 方法更新 SDK 的 Token
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
  // 等待登录成功
  sleep(10);
   
  // 在单线程中更新 Token
  while(!stopped) {
    // 每小时更新一次
    sleep(60 * 60);
    // 错误处理
    if (handler.getNewToken().empty()) {
      break;
    }
    client->renewToken(handler.getNewToken().c_str());
  }
  client->logout();
  client->release();
}
```

## 合理进行资源管理

### 及时释放不需要的资源

**(C++ SDK, Java SDK)** 不及时释放创建的资源可能导致内存泄漏。虽然 Java 的 GC (Garbage Collection) 机制可以回收上层 Java 对象，但是 Java SDK 的底层 C++ API 仍然使用 Java 对象进行回调，因此会造成崩溃。

Agora 建议你主动调用 `release` 方法释放客户端对象和频道对象。

### 不要再访问已释放的资源

**(所有 SDK)** 如果你已经释放了 RTM 客户端对象，Agora 建议你不要再请求相关的资源。另外，你也无法在 RTM 客户端对象释放后使用 `RtmCallManager` 的相关资源。

### 不要在频道对象的回调中释放回调

**(C++ SDK, Java SDK, Objective-C SDK)** 如果你在频道对象的回调方法中，调用 `release` 方法释放频道对象，由于回调方法会对对象加锁，`release` 方法会请求同一把锁，造成应用卡住。

### 注意管理资源的生命周期

**(C++ SDK)** 如果你为 `IRtmService` 对象和 `IChannel` 对象设置了相应的监听器，即 `IRtmServiceEventHandler` 和 `IChannelEventHandler`，你需要保证监听器的生命周期长于对象的生命周期。否则对象可能会调用已经释放的监听器，造成崩溃。

**(1.4.1 版之前的 Objective-C SDK)** `AgoraRtmChannel` 的生命周期需要长于 `AgoraRtmKit`。否则 `AgoraRtmKit` 会使用已经释放的 `AgoraRtmChannel`，造成崩溃。

## 避免回调阻塞

**(所有 SDK)** Agora 建议你及时执行回调，并尽量减少回调的运行时间。否则可能会阻塞后面的回调，或造成回调丢失。

每一个 RTM 客户端实例的回调都是运行在同一个线程上的。后一个回调会等待前一个回调执行完成后再开始执行。 如果前一个回调的运行时间比较长，会使之后的回调不能及时触发，同时等待处理的回调队列越来越长。

- 对于 RTM Native SDK，达到队列长度限制之后，额外的回调事件会被丢弃。
- 对于 RTM Web SDK 和微信小程序 SDK，虽然队列长度没有限制，但是过长的回调队列会造成性能问题。

## 注意处理 SIGPIPE 信号

**(Linux C++ /Linux Java SDK)** RTM 的 Linux 服务端 SDK 没有屏蔽 SIGPIPE 信号。你需要根据实际情况，选择是否屏蔽 SIGPIPE 信号。一般情况下，你需要屏蔽此信号，否则，客户端进程在收到此信号后会默认退出。

## 处理与 RTC SDK 共同使用时 `AgoraRtmAreaCode` 枚举产生的命名冲突

- **(1.4.2 及之后版本的 C++ SDK)** 使用 `AGORA_SDK_BOTH_RTM_AND_RTC` 宏。