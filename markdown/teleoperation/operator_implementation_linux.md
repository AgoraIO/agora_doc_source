# 操控端实现 (Linux)

声网平行操控 SDK 支持主流的 Linux、Android 设备端平台，Windows、Web、Linux、Android、iOS、macOS 操控端平台。

本文介绍如何通过声网平行操控 SDK 在 Linux 操控端实现主要功能。

<div class="alert note">如需体验其他操控端，请<a href="https://www.shengwang.cn/contact-sales/">联系销售</a>。</div>


## 技术原理

基于如下技术框架图，你可以结合你的实际业务进行开发。

![](https://web-cdn.agora.io/docs-files/1680235728939)


## 前提条件

参考如下要求分别准备硬件环境和软件环境。

### 硬件环境

#### 操作系统

- Ubuntu（14.04 版本及以上）
- CentOS（6.6 版本及以上）

#### CPU 架构

- x86-64

如需支持其他架构，请[联系销售](https://www.shengwang.cn/contact-sales/)。

#### 性能要求

- CPU：8 核，1.8 GHz 主频
- 内存：4 GB 或更高

#### 网络要求

- 服务器接入公网，有公网 IP
- 服务器允许访问 [.agora.io](http://agora.io/) 以及 [.agoralab.co](http://agoralab.co/)

### 软件环境

- glibc 2.18 或更高版本
- gcc 4.8 或更高版本

如果你的操作系统为 Ubuntu，安装以下依赖：

```bash
# 安装 aptitude
sudo apt install aptitude
# 安装 build-essential libx11-dev libxcomposite-dev libxext-dev libxfixes-dev libxdamage-dev cmake
sudo aptitude install libx11-dev libxcomposite-dev libxext-dev libxfixes-dev libxdamage-dev cmake
```

如果你的操作系统为 CentOS，安装以下依赖：

```bash
sudo yum groupinstall "Development Tools"
sudo yum install wget
sudo yum groupinstall X11
```


## 获取 SDK

你需要[联系销售](https://www.shengwang.cn/contact-sales/)获取平行操控 Linux SDK。


## 项目配置

初始化 SDK 并与声网 RTC 频道建立连接。详见[准备工作](https://docs.agora.io/cn/server_gateway/server_gateway_tx_rx_stream?platform=Linux#%E5%87%86%E5%A4%87%E5%B7%A5%E4%BD%9C)。


## 实现流程

### 接收音视频流

接收 YUV 格式的原始视频数据或编码后的 H.264 格式视频数据，详细步骤请参考[从设备端接收媒体流](https://docs.agora.io/cn/server_gateway/server_gateway_tx_rx_stream?platform=Linux#%E4%BB%8E%E5%AE%A2%E6%88%B7%E7%AB%AF%E6%8E%A5%E6%94%B6%E5%AA%92%E4%BD%93%E6%B5%81)。

### 收发控制信令

1. 创建并初始化 `RtmClient` 对象，并设置事件监听。

```cpp
auto service = createAndInitAgoraService(false, true, true, true, false, options.appId.c_str());
auto con = service->createRtcConnection(agora::rtc::RtcConnectionConfiguration());
// 使用新的流订阅模式
auto p = con->getAgoraParameter(); p->setBool("rtc.vos_aut_use_old_sync",false);
// 创建 RtmClient
auto rtm_client = agora::rtm::createAgoraRtmClient();
rtmHandler handle;
// 配置 RtmClient
agora::rtm::RtmConfig config;
// 设置事件监听程序
config.eventHandler = &handle;
config.appId = options.appId.c_str();
// userId 中仅支持传入内容为数值的字符串，例如 "1234567"
config.userId = options.userId.c_str();
// 初始化 RtmClient
rtm_client->initialize(config);
```

2. 创建 Stream Channel 并加入频道。在使用 `StreamChannel` 类中的任何 API 之前，你需要先调用 `createStreamChannel` 创建 Stream Channel。

```cpp
// 创建 Stream Channel
auto stream_channel = rtm_client->createStreamChannel(options.channelId.c_str());
agora::rtm::JoinChannelOptions opt;
opt.token = options.appId.c_str();
// 加入频道
stream_channel->join(opt);
```

3. 加入频道中的 Topic 并发布消息。成功加入 Topic 后，SDK 会自动将你注册为该 Topic 的消息发布者，你可以在该 Topic 中发送消息。成功发送后，SDK 会把该消息分发给该 Topic 的所有订阅者。

```cpp
agora::rtm::JoinTopicOptions topic_join_opt;
stream_channel->joinTopic(options.topic.c_str(), topic_join_opt); // 加入 Topic
// 在 Topic 中发布消息
stream_channel->publishTopicMessage(options.topic.c_str(), "hellortm", 9);
```

4. 订阅 Topic 及 Topic 中的消息发送者。

```cpp
agora::rtm::TopicOptions topic_opt;
const char *users[] = { options.remoteUserId.c_str() };
topic_opt.users = users;
topic_opt.userCount = 1;
stream_channel->subscribeTopic(options.topic.c_str(), topic_opt);
```

5. 通过 `onMessageEvent` 事件通知接收远端用户的消息。

```cpp
// 继承 IRtmEventHandler 类
class rtmHandler : public agora::rtm::IRtmEventHandler {
public:
    // 监听消息事件通知
    void onMessageEvent(MessageEvent &event) override
    {
        if(_stream_channel){
         
          int r = _stream_channel->publishTopicMessage(_topic.c_str(), event.message, 12);
          printf("send %d rrr \n",r);
        }
        get_stime();
        printf("send ts: %s, receive ts: %s \n", event.message, timestr);
    }
    agora::rtm::IStreamChannel* _stream_channel = nullptr;
    std::string _topic;
};
```

6. 退出并释放资源。

```cpp
stream_channel->leaveTopic(options.topic.c_str()); // 退出 Topic
stream_channel->leave(); // 退出频道
stream_channel->release(); // 销毁 Stream Channel
rtm_client->release(); // 销毁 RtmClient
```


## 参考信息

### 示例项目
声网在 SDK 包中提供了以下示例项目供你参考：

```bash
├── agora_sdk  # 声网的 SDK 库文件和头文件
└── example    # 示例代码
    ├── yuv_pcm
    │   └── sample_receive_yuv_pcm.cpp # 接收音视频流
    └── rtm
        ├── receive_rtm_message.cpp     # 接收控制信令
        └── send_rtm_message.cpp        # 发送控制信令
```

### API 参考

你可以参考以下 API 文档：

- [实时音视频 API](https://docs.agora.io/cn/server_gateway/API%20Reference/linux_server_cpp/index.html)
- [实时控制信令 API](https://docs-preprod.agora.io/cn/rtm-2.x/api-overview-linux?platform=Linux)