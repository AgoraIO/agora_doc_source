---
title: 如何使用连麦鉴权功能？
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2021-04-07 08:00:20
Products: ["Voice","Video","Interactive Broadcast"]
---
<div class="alert warning">开通连麦鉴权功能涉及 app 逻辑修改。请确保在开通前阅读本文。</div>

## 功能介绍

连麦鉴权，主要用于控制当前用户是否有发布流的权限，需要开发者通过自己的业务服务端部署并生成 Token、Agora 服务器再对生成的 Token 校验实现。

该功能可以确保频道内的发流用户都经过授权，从而防止黑客通过利用业务漏洞或盗取 Token 进行直播间炸房等行为。


## 前提条件

开始前请确保你的 app 满足如下条件：

- 使用 v2.1.0 及之后的 RTC SDK。
- 所有客户端都只能使用 Token 鉴权。如果你想升级到使用 Token 鉴权，可以参考[升级鉴权方案](https://docs.agora.io/cn/Interactive%20Broadcast/token?platform=All%20Platforms#appid_to_token)。

## 实现方法

### 1. 开启连麦鉴权

请参考以下步骤在 Agora 控制台开启连麦鉴权服务：

1. 登录 Agora 控制台，在**项目列表**区域选择你想要开启的项目，点击编辑按钮，进入编辑项目页面。
2. 在项目详情页，下滑到功能区域，点击激活**连麦鉴权**。
3. 按照屏幕提示，了解开通该功能的主要事项，勾选后点击 **Enable**。

在控制台启用连麦鉴权后，该服务会在约 5 分钟后生效。

项目一旦开启了连麦鉴权服务，则用户在频道中发流需要同时满足两个条件：

- 在 `setClientRole` 中设置的 `role` 参数为 `BROADCASTER`。
- 在生成 Token 的代码中设置的 `role` 参数为 `Publisher`。

因此你需要参考下文的步骤 2 和 3 对生成 Token 的代码参数和 app 层实现逻辑进行修改。

### 2. 修改 Token 参数设置

本文以 C++ 的 API 为例，介绍生成 Token 的 `role` 参数变更方式。具体的参数解释也适用于其他语言。

```C++
// API
static std::string buildTokenWithUid(
    const std::string& appId,
    const std::string& appCertificate,
    const std::string& channelName,
    uint32_t uid,
    UserRole role,
    uint32_t privilegeExpiredTs = 0);
 
 
// 示例代码
int main(int argc, char const *argv[]) {
 
  // 请填入你的项目 App ID
  std::string appID  = "970Cxxxxxxxxxxxxxxxxxxxxxxx1b33";
  // 请填入你的项目 App 证书
  std::string  appCertificate = "5CFdxxxxxxxxxxxxxxxxxxxxxxx5d3b";
  // 请填入频道名
  std::string channelName= "7d72xxxxxxxxxxxxxxxxxxxxxxbdda";
  // 请填入 uid。如果填 0，则表示不对 uid 鉴权
  uint32_t uid = 2882341273;
  // Token 服务过期时间
  uint32_t expirationTimeInSeconds = 3600;
  uint32_t currentTimeStamp = time(NULL);
  uint32_t privilegeExpiredTs = currentTimeStamp + expirationTimeInSeconds;
  std::string result;
 
  result = RtcTokenBuilder::buildTokenWithUid(
      appID, appCertificate, channelName, uid, UserRole::Role_Publisher,
      privilegeExpiredTs);
  std::cout << "Token With Int Uid:" << result << std::endl;
```

| 参数 | 概述 | 
| ---------------- | ---------------- |
| role      | 用户发流权限：<ul><li>Role_Publisher(1):（默认）该用户有发流权限。</li><li>Role_Subriber(2)： 该用户没有发流权限。</li></ul>     |


### 3. 修改 app 层实现逻辑

你可以参考如下步骤在业务层对连麦用户的发流权限进行校验（适用于连麦观众需要上麦的场景）：

1. 加入频道前，客户端向业务服务器申请角色为 `Subscriber` 的 Token。业务服务器将生成的角色为 `Subscriber` 的 Token 回传给客户端。
2. 客户端在调用 `joinChannel` 方法时，传入以 `Subscriber` 角色生成的 Token。
3. 客户端由观众切换为主播前，向业务服务器申请角色为 `Publisher` 的 Token。业务服务器将生成的角色为 `Publisher` 的 Token 回传给客户端。
4. 客户端调用 `renewToken` 方法将新的 Token 同步给 Agora 服务器。
5. 客户端调用 `setClientRole` 将用户角色切换为主播。

Agora 服务器会在调用 `setClientRole` 方法的同时校验用户权限，如果 Token 角色为 `Publisher`，则客户端成功获得发布流的权限。

<div class="alert note"><ul><li>如果客户端想要由主播切换回观众，同理，可以参考上述步骤 3-5，先申请角色为 <code>Audience</code> 的 Token，然后调用 <code>renewToken</code>，再调用 <code>setClientRole</code> 即可。</li><li>如果 Token 超过服务有效期，则需要生成新的 Token，并调用 <code>renewToken</code> 将新的 Token 传给 SDK。新生成的 Token 同样有服务有效期。</li></ul></div>
	
## 升级注意事项

**1. 假设用户的 Client Role 为主播。升级到连麦鉴权后，会发生不能说话的情况吗？**

回答：不会。但是当用户当前 Token 过期后，需要重新在服务端申请权限为 `Publisher` 的 Token，然后调用 `renewToken` 将新的 Token 同步给 SDK。

**2. 假设用户的 Client Role 为观众。升级到连麦鉴权后，如果该用户想要上麦变成主播说话，有哪些注意事项？**

回答：app 开通连麦鉴权后，用户是否能上麦发言取决于两个因素：

- 申请 Token 时填入的 role 为 `Publisher`
- `setClientRole` 方法中设置的 role 为 `BROADCASTER`

因此如果观众用户想要上麦说话，需要参考上述修改 App 层实现逻辑的步骤，获取权限为 `Publisher` 的 Token，并调用 `renewToken` 更新 Token，再调用 `setClientRole` 变用户角色为主播。
	