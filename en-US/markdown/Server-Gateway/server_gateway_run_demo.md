This page guides you to run the sample project.

## Set up the development environment

Make sure your server meets the following requirements.

### Hardware environment

**Operating system**

- Ubuntu (14.04 or higher)
- CentOS (6.6 or higher)

**CPU architecture**

- arm64
- x86-64

If you need to run the SDK on other architectures, [submit a ticket]((https://agora-ticket.agora.io/)) to contact technical support.

**Performance**

- CPU：8-core, 1.8 GHz or higher.
- 2 GB or higher. 4 GB or higher is recommended.

**Network**

- The server is connected to the internet and has an internet IP.
- The server can access `*.agora.io` and `*.agoralab.co`.

### Software environment

Taking Ubuntu 20.04.3 LTS as an example, you install the following dependencies in your server:

```shell
# Install aptitude
sudo apt install aptitude
# Install build-essential libx11-dev libxcomposite-dev libxext-dev libxfixes-dev libxdamage-dev cmake
sudo aptitude install libx11-dev libxcomposite-dev libxext-dev libxfixes-dev libxdamage-dev cmake
```

Taking CentOS 7.9.2009 as an example, you install the following dependencies in your server:

```shell
sudo yum groupinstall "Development Tools"
sudo yum install wget
sudo yum groupinstall X11
```

## Get Agora App ID and RTC Temporary Token

See [Get Started with Agora](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms) to learn how to get an **Agora App ID** and an **RTC temporary Token**.

## Get the SDK

Run the following command to get the latest SDK package and decompress the file.

```shell
# Get SDK
wget https://download.agora.io/sdk/release/Agora-RTC-x86_64-linux-gnu-v3.7.200.20.tgz
# Decompress the tgz file
tar xvf Agora-RTC-x86_64-linux-gnu-v3.7.200.20.tgz
```

## Compile the sample project

Run the following commands to run the sample project:

```shell
# Switch to the sample project folder
cd agora_rtc_sdk/example
# Build the sample project
./build-x86_64.sh
# Sync and video/audio data needed by the project
cd out/x86_64
../../sync-data.sh
# Export the libraries from the SDK to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=../../../agora_sdk:$LD_LIBRARY_PATH
```

## Run the project that sends media streams from the server

In this section, we use the **sample_send_h264_pcm** project to demonstrate sending media streams from the server.

### Steps to run

Run the **sample_send_h264_pcm** sample project. Replace `YOUR_RTC_TOKEN`, the parameter value of `--token`, with your RTC temporary token. Replace the parameter value of `--channelId` with the value of your RTC channel ID. In this page, we set the value of `--channelId` to `demo_channel`.

<div class="alert note">You must specify the RTC channel ID that is used to generate the RTC temporary token.</div>

```shell
# Run sample_send_h264_pcm to send video in H.264 format and audio in PCM format
./sample_send_h264_pcm --token YOUR_RTC_TOKEN --channelId demo_channel --videoFile test_data/send_video.h264 --audioFile test_data/send_audio_16k_1ch.pcm
```

### Use the client to receive streams sent from the server

Use a PC or mobile device to open the [Agora RTC Web SDK sample project](https://webdemo.agora.io/basicVideoCall/index.html) and specify the following fields:

- **APP ID**：Specify your Agora app ID, which must be the same as the app ID used in the server. Otherwise, the server cannot communicate with the client.
- **Channel Name**：Specify your channel name, which must be the same as the channel ID used in the server. Otherwise, the server cannot communicate with the client. In this page, we set the value to `demo_channel`.
- **Token**: Specify your RTC temporary token, which is the same as the temporary token used in the server.

Click **Join** to receive media streams from the server.

![](https://web-cdn.agora.io/docs-files/1650527522676)

## Run the project that receives media streams from the client

In this section, we use the **sample_send_h264_pcm** project to demonstrate receiving media streams from the client.

### Steps to run

Run the **sample_receive_h264_pcm** project. Replace `YOUR_RTC_TOKEN`, the parameter value of `--token`, with your RTC temporary token. Replace the parameter value of `--channelId` with the value of your RTC channel ID. In this page, we set the value of `--channelId` to `demo_channel`.

```shell
# Run sample_receive_h264_pcm to receive video in H.264 format and audio in PCM format
./sample_receive_h264_pcm --token YOUR_RTC_TOKEN --channelId demo_channel
```

When the sample project is running, the console prints the following information:

```text
[ APP_LOG_INFO ] Subscribe streams from all remote users
[ APP_LOG_INFO ] Start receiving audio & video data ...
[ APP_LOG_INFO ] Created file received_audio.pcm to save received PCM samples
[ APP_LOG_INFO ] onUserAudioTrackStateChanged: userId 4088243221, state 1, reason 0
[ APP_LOG_INFO ] onUserAudioTrackStateChanged: userId 4088243221, state 2, reason 6
[ APP_LOG_INFO ] onUserInfoUpdated: userId 4088243221, msg 0, val 0
[ APP_LOG_INFO ] onUserInfoUpdated: userId 4088243221, msg 4, val 1
[ APP_LOG_INFO ] onUserInfoUpdated: userId 4088243221, msg 8, val 1
[ APP_LOG_INFO ] onUserInfoUpdated: userId 4088243221, msg 1, val 1
```

### Use the client to send media streams to the server

Use a PC or mobile device to open the [Agora RTC Web SDK sample project](https://webdemo.agora.io/basicVideoCall/index.html) and specify the following fields:

- **APP ID**：Specify your Agora app ID, which must be the same as the app ID used in the server. Otherwise, the server cannot communicate with the client.
- **Channel Name**：Specify your channel name, which must be the same as the channel ID used in the server. Otherwise, the server cannot communicate with the client. In this page, we set the value to `demo_channel`.
- **Token**: Specify your RTC temporary token, which is the same as the temporary token used in the server.

Click **Join** to receive media streams to the server.

When the sample project is running, the console prints the following information:

```text
[ APP_LOG_INFO ] onUserInfoUpdated: userId 436868190, msg 0, val 1
[ APP_LOG_INFO ] onUserInfoUpdated: userId 436868190, msg 4, val 1
[ APP_LOG_INFO ] onUserInfoUpdated: userId 436868190, msg 8, val 1
[ APP_LOG_INFO ] onUserInfoUpdated: userId 436868190, msg 1, val 1
[ APP_LOG_INFO ] onUserInfoUpdated: userId 436868190, msg 0, val 0
[ APP_LOG_INFO ] onUserInfoUpdated: userId 436868190, msg 1, val 0
[ APP_LOG_INFO ] onUserVideoTrackSubscribed: userId 436868190, codecType 1, encodedFrameOnly 1
[ APP_LOG_INFO ] onUserAudioTrackStateChanged: userId 436868190, state 1, reason 0
[ APP_LOG_INFO ] onUserAudioTrackStateChanged: userId 436868190, state 2, reason 6
[ APP_LOG_INFO ] Created file received_video.h264 to save received H264 frames
[ APP_LOG_INFO ] onUserAudioTrackStateChanged: userId 436868190, state 0, reason 7
```

The received video and audio are saved in the `received_video.h264` file and the `received_audio.pcm` file.
