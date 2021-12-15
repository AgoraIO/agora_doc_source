---
title: 发送和接收点对点消息及频道消息
platform: Android
updatedAt: 2021-03-02 02:30:48
---

本文介绍在正式使用 Agora RTM C++ SDK for Windows 进行实时消息通讯前，需要准备的开发环境要求及 SDK 集成方法等内容。

## Demo 体验

你可以到 GitHub 下载最新版的 [Agora-RTM-Tutorial-Windows](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-Windows) 查看完整的源码和代码逻辑：

## 开发环境要求

- Microsoft Visual Studio 2017 或以上版本
- 支持 Windows 7 或以上版本的 Windows 设备
- 一个有效的 [Agora 开发者账号](https://sso.agora.io/login/)。

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 准备开发环境

开发环境的准备包含以下内容：

- [获取 App ID](#appid)
- [快速集成 SDK](#sdk)
- [添加权限](#permission)
- [防止混淆代码](#obfuscated)

### <a name="appid"></a> 获取 App ID

参考以下步骤获取一个 App ID。若已有 App ID，可以直接查看[快速集成 SDK](#sdk)。

<details>
	<summary><font color="#3ab7f8">获取 App ID</font></summary>

1. 进入[控制台](https://console.agora.io/)，并按照屏幕提示注册账号并登录控制台。详见[创建新账号](sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择 App ID 作为**鉴权机制**，再点击“提交”。

![](https://web-cdn.agora.io/docs-files/1574921599254)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目，并找到对应的 App ID。

![](https://web-cdn.agora.io/docs-files/1574921811175)

</details>

### 创建项目

参考以下步骤创建一个 Windows 项目。若已有 Windows 项目，直接查看[集成 SDK](#inte)。

<details>
	<summary><font color="#3ab7f8">创建 Windows 项目</font></summary>

1. 打开 <b>Microsoft Visual Studio</b> 并点击新建项目。
2. 进入<b>新建项目</b>窗口，选择项目类型为 <b>MFC 应用程序</b>，输入项目名称，选择项目存储路径，并点击<b>确认</b>。
3. 进入<b>MFC 应用程序</b>窗口，选择应用程序类型为<b>基于对话框</b>，并点击完成。

</details>

### <a name="sdk"></a>快速集成 SDK

参考以下步骤将 Agora RTM SDK 集成到你的项目中。

**1. 配置项目文件**

- 根据应用场景，从 [SDK 下载](https://docs.agora.io/cn/Agora%20Platform/downloads)获取最新 SDK，解压并打开。

- 打开已下载的 SDK 文件，并将其中的 **sdk** 文件夹复制到你的项目文件夹下。

**2. 配置项目属性**

在**解决方案资源管理器**窗口中，右击项目名称并点击属性进行以下配置，配置完成后点击**确定**。

- 进入 **C/C++ > 常规 > 附加包含目录**菜单，点击**编辑**，并在弹出窗口中输入 **$(SolutionDir)include**。

- 进入**链接器 > 常规 > 附加库目录**菜单，点击**编辑**，并在弹出窗口中输入 **$(SolutionDir)**。

- 进入**链接器 > 输入 > 附加依赖项**菜单，点击**编辑**，并在弹出窗口中输入 **agora_rtc_sdk.lib**。

## 初始化

1. 根据需求继承实现 `agora::rtm::IRtmServiceEventHandler` `agora::rtm::IChannelEventHandler`

2. 创建 `agora::base::IAgoraService` `agora::base::AgoraServiceContext` 实例 `agoraInstance_` ， `context_` 并初始化 `agoraInstance_` ；

3. 创建 `agora::rtm::IRtmService` `agora::rtm::IRtmServiceEventHandler` `agora::rtm::IChannelEventHandler` 实例 `rtmInstance_` 初始化；

```cpp
#include "IAgoraService.h"
#include "IAgoraRtmService.h"

std::unique_ptr<agora::base::IAgoraService> agoraInstance_;
agora::base::AgoraServiceContext context_;
std::unique_ptr<agora::rtm::IRtmServiceEventHandler> RtmEventCallback_;
std::unique_ptr<agora::rtm::IChannelEventHandler> channelEventCallback_;
std::shared_ptr<agora::rtm::IRtmService> rtmInstance_;
std::shared_ptr<agora::rtm::IChannel> channelHandler_;

void Init() {
  agoraInstance_.reset(createAgoraService());
  if (!agoraInstance_) {
    cout << "core service created failure!" << endl;
    exit(0);
  }

  if (agoraInstance_->initialize(context_)) {
    cout << "core service initialize failure!" << endl;
    exit(0);
  }

  RtmEventCallback_.reset(new RtmEventHandler());
  agora::rtm::IRtmService* p_rs = agoraInstance_->createRtmService();
  rtmInstance_.reset(p_rs, [](agora::rtm::IRtmService* p) {
  p->release();
  });

  if (!rtmInstance_) {
    cout << "rtm service created failure!" << endl;
    exit(0);
  }

  if (rtmInstance_->initialize(APP_ID.c_str(), RtmEventCallback_.get())) {
    cout << "rtm service initialize failure! appid invalid?" << endl;
    exit(0);
  }
}
```

## 登录

APP 必须在登录 RTM 服务器之后，才可以使用 RTM 的点对点消息和群聊功能。在此之前，请确保 `rtmInstance_` 初始化完成。

- 传入能标识用户角色和权限的 Token。如果安全要求不高，也可以将值设为 `APPID`。Token 需要在应用程序的服务器端生成，具体生成办法，详见 [校验用户权限](https://docs-preview.agoralab.co/cn/Real-time-Messaging/RTM_key)。
- 传入能标识每个用户的 ID。用户 ID 为字符串，必须是可见字符（可以带空格），不能为空或者多于 64 个字符，也不能是字符串 `"null"`。
- 传入结果回调，用于接收登录 RTM 服务器成功或者失败的结果回调

```cpp
bool login(const std::string& token, const std::string& uid) {
  if (rtmInstance_->login(token.c_str(), uid.c_str())) {
    cout << "login failed!" << endl;
    return false;
  }
  return true;
}
```

如果需要退出登录，可以调用 `logout()` 方法，退出登录之后可以调用 `login()` 重新登录或者切换账号。

```cpp
void logout() {
  rtmInstance_->logout();
}
```

## 点对点消息

在成功登录 RTM 服务器之后，可以开始使用 RTM 的点对点消息功能。

### 发送点对点消息

调用 `sendMessageToPeer` 方法发送点对点消息。在该方法中：

- 传入目标消息接收方的用户 ID。
- 传入 `RtmMessage` 对象实例。该消息对象由 `rtmInstance_` 类的的 `createMessage()` 实例方法创建，并使用消息实例的 `setText()` 方法设置消息内容。
- 传入消息发送结果监听器，用于接收消息发送结果回调，如：服务器已接收，发送超时，对方不可达等。

```cpp
void sendMessageToPeer(std::string peerID, std::string msg) {
  agora::rtm::IMessage* rtmMessage = rtmInstance_->createMessage();
  rtmMessage->setText(msg.c_str());
  int ret = rtmInstance_->sendMessageToPeer(peerID.c_str(),
                                  rtmMessage);
  rtmMessage->release();
  if (ret) {
    cout << "send message to peer failed! return code: " << ret
         << endl;
  }
}
```

### 接收点对点消息

点对点消息的接收通过创建 `rtmInstance_` 实例的时候传入的 `RtmEventCallback_` 实例进行监听。在该实例的 `void onMessageReceivedFromPeer(const char *peerId, const agora::rtm::IMessage *message)` 回调方法中：

- 通过 `message->getText()` 方法可以获取到消息文本内容。
- `peerId` 是消息发送方的用户 ID。

## 频道消息

App 在成功登录 RTM 服务器 之后，可以开始使用 RTM 的频道消息功能。

### 创建加入频道实例

- 传入能标识每个频道的 ID。ID 为字符串，必须是可见字符（可以带空格），不能为空或者多于 64 个字符，也不能是字符串 `"null"`。
- 指定实例 `channelEventCallback_` SDK 通过回调通知应用程序频道的状态变化和运行事件等，如: 接收到频道消息、用户加入和退出频道等。

```cpp
void joinChannel(const std::string& channel) {
  string msg;
  channelEventCallback_.reset(new ChannelEventHandler(channel));
  channelHandler_.reset(rtmInstance_->createChannel(channel.c_str(), channelEventCallback_.get()))
  if (!channelHandler_) {
    cout << "create channel failed!" << endl;
  }
  channelHandler_->join();
}
```

### 发送频道消息

在成功加入频道之后，用户可以开始向该频道发送消息。

调用频道实例的 `sendMessage()` 方法向该频道发送消息。在该方法中：

- 传入 `RtmMessage` 对象实例。该消息对象由 `rtmInstance_` 类的 `createMessage()` 实例方法创建，并使用消息实例的 `setText()` 方法设置消息内容。
- 传入消息发送结果监听器，用于接收消息发送结果回调，如：服务器已接收，发送超时等。

```cpp
void sendGroupMessage (const std::string& msg) {
  agora::rtm::IMessage* rtmMessage = rtmInstance_->createMessage();
  rtmMessage->setText(msg.c_str());
  channelHandler_->sendMessage(rtmMessage);
  rtmMessage->release();
}
```

### 接收频道消息

频道消息的接收通过回调实例函数`onMessageReceived(const char* userId,const agora::rtm::IMessage *msg)`。

### 获取频道成员列表

调用实例的 `getMembers()` 方法可以获取到当前在该频道内的用户列表。

实例 `channelEventCallback_` 回调 `void onGetMembers(agora::rtm::IChannelMember **members, int userCount, agora::rtm::GET_MEMBERS_ERR errorCode)` 得到结果

```cpp
void getMembers() {
  channelHandler_->getMembers();
}
```

### 退出频道

调用实例的 `leave()` 方法可以退出该频道。退出频道之后可以调用 `join()` 方法再重新加入频道。

## 注意事项

- RTM 支持多实例，事件回调须是不同的实例。
- 当实例不再使用的时，可以调用实例的 `release()`方法释放资源。
- 接收到的 `IMessage` 消息对象不能重复利用再用于发送。
- 每个客户端都需要首先调用 `createChannel` 方法创建频道实例才能使用频道消息功能，该实例只是本地的一个类对象实例。
- RTM 支持同时创建最多 20 个不同的频道实例并加入到多个频道中，但是每个频道实例必须使用不同的频道 ID 以及不同的回调。
- 如果频道 ID 非法，或者具有相同 ID 的频道实例已经在本地创建，`createChannel` 时将返回 `null`。
- 接收到的 `RtmMessage` 消息对象不能重复利用再用于发送。
- 当离开了频道且不再加入该频道时，可以调用 `RtmChannel` 实例的 `release()` 方法及时释放频道实例所占用的资源。
- 所有回调如无特别说明，除了基本的参数合法性检查失败触发的回调，均为异步调用。
