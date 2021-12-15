---
title: 快速跑通示例项目 (Linux C++)
platform: Linux
updatedAt: 2021-03-23 07:39:36
---

## 概览

声网提供以下示例项目，演示了发送和接收 PCM 格式的音频流和 H.264 格式的音频流。

- `sample_send_h264_pcm`
- `sample_receive_h264_pcm`

你可以先按照本文所列步骤编译和运行示例项目，体验发送和接收媒体流，然后通过[实现媒体流传输](./rtsa_quickstart)了解集成基本流程和阅读示例代码，理解 Agora RTSA Pro SDK 的 API，在此基础上将相应的功能集成到你自己的项目中。

## 准备开发环境

请确保你的开发环境满足以下要求：

- Ubuntu 14.04 及以上版本，建议 18.04。

- CMake 3.5 及以上版本。可通过以下命令安装：

```
$ sudo apt install cmake
```

- 下载最新版[实时码流加速 Pro SDK](https://docs.agora.io/cn/RTSA/downloads?platform=Linux)。

## 操作步骤

### 1. 创建 Agora 账号并获取 Agora App ID

在编译和运行示例项目前，你首先需要通过以下步骤获取 Agora App ID:

1. 创建一个有效的 [Agora 账号](https://console.agora.io/)。
2. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏项目管理按钮进入项目管理页面。
3. 在项目管理页面，点击创建按钮。在弹出的对话框内输入项目名称，选择鉴权机制为 App ID。点击提交，新建的项目就会显示在项目管理页中。Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。复制并保存此项目的 **App ID** ，稍后激活 License 和启动应用时会用到 App ID。

### 2. 获取 Agora 客户 ID 和客户密钥

由于该示例项目需要使用 Agora RESTful API，因此你需要进行 HTTP 基本认证。你需要获取 Agora 提供的客户 ID 和客户密钥。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击页面右上角的用户名，在下拉列表中打开 RESTful API 页面。
2. 点击**添加密钥**按钮。在下方的页面中会生成新的客户 ID 和客户密钥，在右边的操作栏点击**提交**按钮。
3. 页面显示**创建成功**提示信息后，在相应的客户密钥栏点击**下载**按钮。
4. 保存下载下来的 **key_and_secret.txt** ，里面包含客户 ID 和客户密钥。

### 3. <a name="apply-license"></a>申请免费的体验 License

RTSA 通过 License 进行鉴权，License 与设备绑定，一个 License 在同一时间只能绑定一个设备。

在体验阶段，你可以在线[申请免费的 License](https://www.wjx.cn/m/96954268.aspx)。申请成功后，你可以得到 **10** 个免费的体验 License，时效为 **6** 个月。

### 4. 获取音视频测试文件

在 SDK 包中 `example` 目录下通过以下命令下载声网提供的用于测试的音视频文件：

```
$ ./sync-data.sh
```

运行完成后，会在 `example` 目录下生成 `test_data` 文件夹，内含各种格式的音视频文件。

### 5. 编译示例项目

在 SDK 包中 `example` 目录下通过以下命令编译示例项目：

```
$ ./build.sh
```

参数说明：

- `-b`: 编译方式，可设为 `build`、`rebuild` 和 `clean`，默认为 `build`。

编译完成后，会在 `example` 目录下生成 `build/bin` 文件夹，内含一些可执行文件。

### <a name="activate-license"></a>6. 激活 License

在运行示例项目之前，你需要通过以下步骤激活你申请的 License，生成对应的证书。

1. 运行以下命令查询你的 App ID 下所有的 License Key。

```
$ build/bin/license_query --appId YOUR_APPID --customerKey YOUR_KEY --customerSecret YOUR_SECRET
```

参数说明：

- `appId`: 你获取到的 Agora App ID。
- `customerKey`: 你获取到的 Agora 客户 ID。
- `customerSecret`: 你获取到的 Agora 客户密钥。

2. 运行以下命令激活 License，生成对应的证书。

```
$ build/bin/license_activator --appId YOUR_APPID --customerKey YOUR_KEY --customerSecret YOUR_SECRET --licenseKey YOUR_LICENSE --certOutputDir
```

参数说明：

- `appId`: 你获取到的 Agora App ID。
- `customerKey`: 你获取到的 Agora 客户 ID。
- `customerSecret`: 你获取到的 Agora 客户密钥。
- `licenseKey`: 你在上一步中查询到的 License Key。
- `certOutputDir`: 证书输出目录。如不设，则为当前目录。

激活成功后，会在当前目录或你所指定的目录下生成 `deviceID.bin` 和 `certificate.bin` 两个文件，稍后运行示例项目时会用到。

### 7. 发送媒体流

`sample_send_h264_pcm` 示例项目演示了发送 PCM 格式的音频流和 H.264 格式的视频流，支持以下参数：

- `--token`: 必填，你在声网控制台获取的 App ID 或临时 Token。
- `--channelId`: 必填，待加入频道的名称。
- `--userId`: 用户 ID。默认值为 0，SDK 随机分配一个用户 ID。
- `--audioFile`: 待发送的 PCM 音频文件路径，默认值为 `test_data/test.pcm`。
- `--videoFile`: 待发送的 H264 视频文件路径，默认值为 `test_data/test_multi_slice.h264`。
- `--sampleRate`: 待发送音频的采样率，默认值为 48000。
- `--numOfChannels`: 待发送音频的声道数，默认值为 1，单声道。
- `--fps`: 待发送视频的帧率，默认值为 30。

在 SDK 包中 `example` 目录下通过以下命令运行示例项目，将媒体流发送至一个频道：

```
$ build/bin/sample_send_h264_pcm --token <your_temp_token> --channelId rtsatest
```

运行成功后，你可以通过声网的[在线示例应用](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/)加入同一频道，在频道中能够实时看到音视频流。

### 8. 接收媒体流

`sample_receive_h264_pcm` 示例项目演示了接收 PCM 格式的音频流和 H.264 格式的视频流，支持以下参数：

- `--token`: 必填，你在声网控制台获取的 App ID 或临时 Token。
- `--channelId`: 必填，待加入频道的名称。
- `--userId`: 用户 ID。默认值为 0，SDK 随机分配一个用户 ID。
- `--remoteUserId`: 远端用户 ID，表示仅订阅该远端用户发送的媒体流。无默认值，如不指定，表示订阅所有远端用户发送的媒体流。
- `--audioFile`: 待接收的 PCM 音频流的存储路径和文件名，默认值为 `received_audio.pcm`。
- `--videoFile`: 待接收的 YUV 视频流的存储路径和文件名，默认值为 `received_video.h264`。
- `--sampleRate`: 待接收音频的采样率，默认值为 48000。
- `--numOfChannels`: 待接收音频的声道数，默认值为 1，单声道。

你可以先通过声网的[在线示例应用](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/)加入一个频道，然后在 SDK 包中 `example` 目录下通过以下命令运行示例项目，接收同一频道的音视频流：

```
$ build/bin/sample_receive_h264_pcm --token <your_temp_token> --channelId rtsatest
```

运行成功后，SDK 会在 `example` 目录下生成 `received_audio.pcm` 和 `received_video.h264` 文件用于存储接收到的音频流和视频流。
