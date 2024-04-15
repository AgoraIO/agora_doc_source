# 跑通示例项目 (Linux)

声网平行操控 SDK 支持主流的 Linux、Android 设备端平台，Windows、Web、Linux、Android、iOS、macOS 操控端平台。

本文以 Linux 设备端和 Linux 操控端为例，介绍如何快速跑通平行操控示例项目，体验实时互通效果。

<div class="alert note">如需体验其他设备端和操控端的示例项目，请<a href="https://www.shengwang.cn/contact-sales/">联系销售</a>获取，并参照 <code>README.md</code> 的步骤跑通。</div>


## 准备开发环境

参考如下要求分别准备硬件环境和软件环境。

### 硬件环境

请确保你的 Linux 设备上有可用的摄像头。可通过 `ls /dev/video*` 命令查看全部可用摄像头。

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


## 编译示例项目

1. 解压 SDK 包，其中包含的示例项目如下：

```bash
├── agora_sdk   # 声网的 SDK 库文件和头文件
└── example     # 示例代码
    └── out
        ├── capture_time_test          # 测试摄像头采集延时
        ├── sample_audio               # 单独发送音频流
        ├── sample_receive_h264_pcm    # 接收 H.264 数据
        ├── sample_receive_rtm_message # 接收实时控制信令
        ├── sample_receive_yuv_pcm     # 接收 YUV 数据
        ├── sample_send_capture_yuv    # 采集并发送 YUV 数据
        ├── sample_send_h264_pcm       # 发送 H.264 数据
        ├── sample_send_rtm_message    # 发送实时控制信令
        └── sample_send_yuv_pcm        # 发送 YUV 数据
```

2. 通过终端进入示例项目目录。

```bash
cd agora_rtc_sdk/example/
```

3. (可选) 如果你对源码进行了更改，则需运行 `build.sh` 脚本将更新后的源码编译成可执行文件。

```bash
./build.sh
```

4. 将 SDK 中的库导出到 `LD_LIBRARY_PATH`。

```bash
export LD_LIBRARY_PATH=./../agora_sdk/
```

## 体验音视频流互通

本章节演示 Linux 设备端和 Linux 操控端之间的音视频流互通。

<div class="alert info">本章节仅演示 YUV 原始视频数据的采集和收发。如需体验收发编码后的 H.264 格式的视频数据，请先运行 <code>./sync-data.sh</code> 命令获取相应的音频和视频文件。</div>

### 设备端采集并发送音视频流

以 `sample_send_capture_yuv` 为例，演示设备端采集并发送音视频流。命令行示例如下：

```bash
# 在 example 目录下运行 sample_send_capture_yuv，采集并发送 YUV 数据
./out/sample_send_capture_yuv --channelId hellortc --token 00xxxxxxxxxxwY= --device /dev/video1
```

该可执行文件使用 Linux 设备上的摄像头进行视频的采集传输，有如下参数可供设置：

| 参数 | 描述 | 数据类型 | 是否必须 |
|:----|:-----|:-------|:--------|
| `token` | 传入 App ID 或 Token。如果项目已开启 App 证书，则必须传 Token。详见[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。 | String| **必填** |
| `channelId` | 频道名。 | String| **必填** |
| `userId` | 设备端的 user ID，默认值为 0，表示声网随机分配一个用户 ID。如需自行指定，需满足以下条件：<ul><li>仅支持传入内容为数值的字符串</li><li>用户 ID 在频道内唯一</li></ul> | String| 选填 |
| `fps` | 摄像头采集的视频帧率 (fps)，默认值为 30。该值需要根据实际的摄像头规格进行调整。 | Integer| 选填 |
| `width` | 视频宽 (px)，默认值为 640。该值需要根据实际的摄像头规格进行调整。 | Integer| 选填 |
| `height` | 视频高 (px)，默认值为 480。该值需要根据实际的摄像头规格进行调整。 | Integer| 选填 |
| `bitrate` | 视频码率 (Mbps)，默认值为 1。该值可根据实际的视频属性和网络状况进行调整。  | Integer| 选填 |
| `device` | 摄像头名称，默认采集 `/dev/video0`。你可以通过 `ls /dev/video*` 命令查看当前设备上所有摄像头的名称。  | String| 选填 |


运行成功后，你的终端会打印如下信息表明设备端正在采集并发送视频数据：

```bash
[ APP_LOG_INFO ] Start sending video data ...
```

### 操控端接收音视频流

以 `sample_receive_yuv_pcm` 为例，演示操控端接收视频流。命令行示例如下：

```bash
# 在 example 目录下运行 sample_receive_yuv_pcm，接收 YUV 数据
./out/sample_receive_yuv_pcm --channelId hellortc --token 00xxxxxxxxxxY=
```

该可执行文件在 Linux 操控端接收音视频流，有如下参数可供设置：

| 参数 | 描述 | 数据类型 | 是否必须 |
|:----|:-----|:-------|:--------|
| `token` | 传入与发送端相同的 App ID 或 Token。| String | **必填** |
| `channelId` | 传入与发送端相同的频道名。 | String | **必填** |
| `userId` | 操控端的 user ID，默认值为 0，表示声网随机分配一个用户 ID。如需自行指定，需满足以下条件：<ul><li>仅支持传入内容为数值的字符串</li><li>用户 ID 在频道内唯一</li></ul> | String | 选填 |
| `remoteUserId` | 默认为空，表示接收频道内全部设备端的音视频流。如果你只想接收指定设备端的音视频流，则需将该字段设置为对应设备端的用户 ID。 | String | 选填 |
| `audioFile` | 接收音频流的存储文件，默认为 `received_audio.pcm`。 | String | 选填 |
| `videoFile` | 接收视频流的存储文件，默认为 `received_video.yuv`。 | String | 选填 |
| `sampleRate` | 音频帧的采样率 (Hz)，默认值为 16000。 | Integer | 选填 |
| `numOfChannels` | 音频的声道数，默认值为 1。 | Integer | 选填 |
| `streamType` | 视频流类型。默认值为 `STREAM_TYPE_HIGH`，使用大流，分辨率和码率较高。如需使用分辨率和码率较低的小流，可以指定 `VIDEO_STREAM_LOW`。	 | String | 选填 |

运行成功后，你的终端会打印如下信息表明操控端正在接收设备端发送的音视频流：

```bash
[ APP_LOG_INFO ] Subscribe streams from all remote users
[ APP_LOG_INFO ] Start receiving audio & video data ...
```


## 体验控制信令互通

在实际场景中，设备端和操控端会互相收发控制信令。本章节演示 Linux 设备端和 Linux 操控端之间的控制信令互通。

### 发送控制信令

以 `sample_send_rtm_message` 为例，演示发送控制信令。命令行示例如下：

```bash
# 在 example 目录下运行 sample_send_rtm_message 发送控制信令
./out/sample_send_rtm_message --token cdxxxxxxxxxxb1 --channelId hellortm --topic rtm --userId 123 --remoteUserId 321
```

运行该可执行文件发送控制指令，有如下参数可供设置：

| 参数 | 描述 | 数据类型 | 是否必须 |
|:----|:-----|:-------|:--------|
| `token` | 传入 App ID 或 Token。如果项目已开启 App 证书，则必须传 Token。详见[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。 | String| **必填** |
| `channelId` | 频道名。 | String| **必填** |
| `topic` | 频道内的 Topic 名称。 | String| **必填** |
| `userId` | 当前用户的 user ID，仅支持传入内容为数值的字符串。 | String| **必填** |
| `remoteUserId` | 远端用户的 user ID，仅支持传入内容为数值的字符串。 | String| **必填** |
| `receive` | 是否订阅远端消息。 | Boolean| 选填 |

运行成功后，你的终端会打印如下信息表明正在发送控制信令：

```bash
[ APP_LOG_INFO ] join channel 0
[ APP_LOG_INFO ] it is join topic 0
```


### 接收控制信令

以 `sample_receive_rtm_message` 为例，演示接收对端发送的控制信令。命令行示例如下：

```bash
# 在 example 目录下运行 sample_receive_rtm_message 接收控制信令
./out/sample_receive_rtm_message --token cdxxxxxxxxxxb1 --channelId hellortm --topic rtm --userId 321 --remoteUserId 123
```

运行该可执行文件接收控制信令，有如下参数可供设置：

| 参数 | 描述 | 数据类型 | 是否必须 |
|:----|:-----|:-------|:--------|
| `token` | 传入与发送端相同的 App ID 或 Token。 | String| **必填** |
| `channelId` | 传入与发送端相同的频道名。 | String| **必填** |
| `topic` | 传入与发送端相同的 Topic。 | String| **必填** |
| `userId` | 当前用户的 user ID，即发送端的 `remoteUserId`。 | String| **必填** |
| `remoteUserId` | 远端用户的 user ID，即发送端的 `userId`。 | String| **必填** |
| `answer` | 是否订阅远端消息。 | Boolean| 选填 |

运行成功后，你的终端会打印如下信息表明正在接收对端发送的控制信令：

```bash
[ APP_LOG_INFO ] join channel is 0
[ APP_LOG_INFO ] join topic is 0
sub is 0
send ts: 11:35:28.053, receive ts: 11:35:28.080
send ts: 11:35:28.073, receive ts: 11:35:28.096
send ts: 11:35:28.094, receive ts: 11:35:28.113
send ts: 11:35:28.115, receive ts: 11:35:28.134
send ts: 11:35:28.135, receive ts: 11:35:28.154
```