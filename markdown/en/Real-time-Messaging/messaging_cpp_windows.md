---
title: Peer-to-peer or Channel Messaging
platform: Android
updatedAt: 2020-08-27 17:54:41
---

You can use this guide to quickly start messaging with the [Agora RTM Windows C++ SDK](https://docs.agora.io/en/Real-time-Messaging/downloads). 


## Try the demo

We provide an open-source demo project on GitHub, [Agora-RTM-Tutorial-Windows](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-Windows), which implements an elementary messaging system. You can try this demo out and view our source code.

## Prerequisites


 
- Microsoft Visual Studio 2017 or later.
- A Windows device running on Windows 7 or later.

- A valid Agora account. ([Sign up](https://sso.agora.io/en/signup) for free)

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a > if your intranet has a firewall.</div> 





<a name="setup"></a>

## Set up the development environment

We will walk you through the following steps in this section:

- [Get an App ID](#appid)
- [Create a project](#create)
- [Integrate the SDK into your project](#sdk)


### <a name="appid"></a>Get an App ID

You can skip to [Create a project](#create) if you already have an App ID. 

<details>
	<summary><font color="#3ab7f8">Get an App ID</font></summary>
	
1. Sign up for a developer account at [Agora Console](https://dashboard.agora.io/). See [Sign in and Sign up](sign_in_and_sign_up).

2. Click ![](https://web-cdn.agora.io/docs-files/1551254998344) in the left navigation menu to enter the [**Project Management**](https://dashboard.agora.io/projects) page.

3. Click **Create**. 

![](https://web-cdn.agora.io/docs-files/1574924327108)

4.  Enter your project name and select your authentication mechanism ("App ID") in the dialog box.

![](https://web-cdn.agora.io/docs-files/1574924446798)
	
5. Click **Submit** and you can find the **App ID** of your newly created project.

![](https://web-cdn.agora.io/docs-files/1574924570426)
</details>

### <a name="create"></a> Create a project

Now, let's build a project from scratch. Skip to [Integrate the SDK](#sdk) if a project already exists.

<details>
	<summary><font color="#3ab7f8">Create a Windows project</font></summary>
	
1. Open <b>Microsoft Visual Studio</b> and click <b>Create new project</b>.
2. On the <b>New Project</b> panel, choose <b>MFC Application</b> as the project type, input the project name, choose the project location, and click <b>OK</b>.
3. On the <b>MFC Application</b> panel, choose <b>Application type > Dialog based</b>, and click <b>Finish</b>.
	
</details>


### <a name="sdk"></a> Integrate the SDK

Follow these steps to integrate the Agora RTM C++ SDK for Windows into your project.

**1. Configure the project files**

- Go to [SDK Downloads](https://docs.agora.io/en/Agora%20Platform/downloads), download the latest version of the Agora SDK for Windows, and unzip the downloaded SDK package.

- Copy the **sdk** folder of the downloaded SDK package to your project files.

**2. Configure the project properties**

Right-click the project name in the **Solution Explorer** window, click **Properties** to configure the following project properties, and click **OK**.

- Go to the **C/C++ > General > Additional Include Directories** menu, click **Edit**, and input **$(SolutionDir)include** in the pop-up window.

- Go to the **Linker > General > Additional Library Directories** menu, click **Edit**, and input **$(SolutionDir)** in the pop-up window.

- Go to the **Linker > Input > Additional Dependencies** menu, click **Edit**, and input **agora_rtc_sdk.lib** in the pop-up window.


## Implement peer-to-peer and channel messaging

This section provides API call sequence diagrams and sample codes related to peer-to-peer messaging and channel messaging. 

### API Call sequence diagrams

#### Login and logout of the Agora RTM system

![](https://web-cdn.agora.io/docs-files/1576727197212)

#### Send or receive peer-to-peer messages

![](https://web-cdn.agora.io/docs-files/1561973161681)

#### Join and leave an Agora RTM channel 

![](https://web-cdn.agora.io/docs-files/1561985095839)

#### Send or receive channel messages

![](https://web-cdn.agora.io/docs-files/1561985687950)



### Create and Initialize an Agora RTM Client


```cpp
#include "IAgoraRtmService.h"

std::unique_ptr<agora::rtm::IRtmServiceEventHandler> RtmEventCallback_;
std::unique_ptr<agora::rtm::IChannelEventHandler> channelEventCallback_;
std::shared_ptr<agora::rtm::IRtmService> rtmInstance_;
std::shared_ptr<agora::rtm::IChannel> channelHandler_;

void Init() {
  RtmEventCallback_.reset(new RtmEventHandler());
  agora::rtm::IRtmService* p_rs = agora::rtm::createRtmService();
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
```

### Log in and log out of the Agora RTM system

Only when you successfully log in the Agora RTM system, can you use most of the core features provided by the Agora RTM SDK. 

> You need to generate an RTM Token from your business server. For more information, see [Token Security](/en/Real-time-Messaging/rtm_token?platform=All%20Platforms).

```cpp
bool login(const std::string& token, const std::string& uid) {
  if (rtmInstance_->login(token.c_str(), uid.c_str())) {
    cout << "login failed!" << endl;
    return false;
  }
  return true;
}
```

To log out of the system:

```cpp
void logout() {
  rtmInstance_->logout();
}
```

### Peer-to-peer messaging

#### Send a peer-to-peer message

To send a peer-to-peer message to a specified user

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



### Channel messaging

Ensure that you have logged in the Agora RTM system before being able to use the channel messaging function. 

#### Create and join a channel

When creating a channel, you need to pass a channel ID, a string that must not be empty, null, "null", or exceed 64 Bytes in length. You also need to specify a channel listener: 

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


#### Channel messaging

```cpp
void sendGroupMessage (const std::string& msg) {
  agora::rtm::IMessage* rtmMessage = rtmInstance_->createMessage();
  rtmMessage->setText(msg.c_str());
  channelHandler_->sendMessage(rtmMessage);
  rtmMessage->release();
}
```

#### Leave a channel

You can call the `leave()` method to leave a channel. 


## Considerations


- The Agora RTM SDK supports creating multiple [IRtmService](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html) instances that are independent of each other. 

-  To send and receive peer-to-peer or channel messages, ensure that you have successfully logged in the Agora RTM system (i.e., ensure that you have received [onLoginSuccess](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a8cf1b2be30172004f595484e0a194d76)). 

- To use any of the channel features, you must first call the [createChannel](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0196e60ee165f6c97f561cf71499d377) method to create a channel instance. 
- You can create multiple channel instances for each [IRtmService](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html) instance, but you can only join a maximum of 20 channels at the same time. The `channelId` parameter needs to be channel-specific.

- When you leave a channel and do not want to join it again, you can call the [release](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#af1c6a2e044136c3a25fb8a663cf5e90b) method to release all resources used by the channel instance.

- You cannot reuse a received [IMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) instance.

