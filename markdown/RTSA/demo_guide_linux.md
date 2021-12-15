---
title: 快速跑通示例项目
platform: Linux
updatedAt: 2021-03-31 06:39:39
---

声网提供了一个简单的示例项目 `hello_rtsa.c` 用于演示推流和拉流的基本功能。该示例项目位于 RTSA Lite SDK 包 example 目录中。

你可以先编译并运行 `hello_rtsa.c` 体验推拉流，初步了解 RTSA Lite 的 API 调用，以便后续能够更高效地将 RTSA Lite 集成到你自己的应用程序中。

## 环境准备

- 一台装有 Ubuntu 16.04 或 18.04 的 PC，可以是虚拟机。用于编译和运行示例代码进行推流。
- 一台真实 Android 设备。用于实时接收和播放音视频流。

## 操作步骤

### 1. 创建 Agora 账号并获取 App ID

在编译和运行示例项目前，你首先需要通过以下步骤获取 Agora App ID:

1. 创建一个有效的 [Agora 账号](https://console.agora.io/)。
2. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏项目管理按钮进入项目管理页面。
3. 在项目管理页面，点击创建按钮。在弹出的对话框内输入项目名称，选择鉴权机制为 App ID。点击提交，新建的项目就会显示在项目管理页中。Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。复制并保存此项目的 **App ID** ，稍后激活 License 和启动应用时会用到 App ID。

### 2. 获取 Agora 的客户 ID 和客户密钥

由于该示例项目需要使用 Agora RESTful API，因此你需要进行 HTTP 基本认证。你需要获取 Agora 提供的客户 ID 和客户密钥。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击页面右上角的用户名，在下拉列表中打开 RESTful API 页面。
2. 点击**添加密钥**按钮。在下方的页面中会生成新的客户 ID 和客户密钥，在右边的操作栏点击**提交**按钮。
3. 页面显示**创建成功**提示信息后，在相应的客户密钥栏点击 **下载** 按钮。
4. 保存下载下来的 **key_and_secret.txt** ，里面包含客户 ID 和客户密钥，稍后激活 License 时会用到。

### 3. 申请免费的体验 License

RTSA 通过 License 进行鉴权，License 与设备绑定，一个 License 在同一时间只能绑定一个设备。

在体验阶段，你可以[申请免费的 License](https://www.wjx.cn/m/96954268.aspx)。申请成功后，你可以得到 **10** 个免费的体验 License，时效为 **6** 个月。

### 4. 编译 license_activator 和 hello_rtsa

参考以下命令编译 `license_activator` 和 `hello_rtsa`。

```
cd example
./build.sh
```

> 如果你需要在设备端（通常是 ARM Linux 系统）运行 `hello_rtsa`，请先参考 SDK 包中的交叉编译指南（`cross_compile.zh.md` 文件）。

编译完成后，会在当前目录下生成 `hello_rtsa` 和 `license_activator` 可执行文件。

### 5. 激活 License

在运行 `hello_rtsa` 之前，你需要通过以下步骤激活 License，生成对应的证书。

1. 修改当前目录下的 License 配置文件 `license.cfg`。

```
$ vim license.cfg
{
   "appId":                "YOUR_OWN_APPID",           // 修改成你创建的 App ID 或从 Agora 销售渠道申请的商用 App ID
   "customerKey":          "YOUR_CUSTOMER_KEY",        // 修改成 `key_and_secret.txt` 里的 key
   "customerSecret":       "YOUR_CUSTOMER_SECRET",     // 修改成 `key_and_secret.txt` 里的 secret
   "licenseKey":           "YOUR_LICENSE_KEY"          // 修改成你的 License 序列号
}
```

2. 根据修改后的 `license.cfg` 配置来激活 License，并生成对应的证书。

```
$ ./license_activator --configFile ./license.cfg
```

激活成功后，默认在当前目录生成 `deviceID.bin` 和 `certificate.bin` 两个文件，稍后运行示例项目时会用到。

### 6. 运行 hello_rtsa

你可通过以下命令行，把 `YOUR_APP_ID` 替换称你在第一步中获取到的 App ID，加入名为 `hello_channel` 的频道，并且用默认参数发送 H.264 视频和 AAC 音频。音视频源默认为 SDK 包自带的 `send_audio.aac` 和 `send_video.h264` 文件。

```
$ ./hello_rtsa -i YOUR_APP_ID -c hello_channel
```

如你想进行更多体验，可参考下列参数介绍自行调试。

| 参数                  | 示例                                                                           |
| :-------------------- | :----------------------------------------------------------------------------- |
| -h, --help            | 打印帮助信息。                                                                 |
| -i, --appId           | 你的 App ID。无默认值，必填。                                                  |
| -t, --token           | 你的 token。默认值为空字符串。                                                 |
| -c, --channelId       | 频道名。无默认值，必填。                                                       |
| -u, --userId          | 用户 ID。默认值为 0，代表 SDK 随机指定。                                       |
| -r, --credentialFile  | 设备标识文件。默认值为 ./deviceID.bin。                                        |
| -C, --certificateFile | 证书文件路径。默认值为 ./certificate.bin。                                     |
| -a, --audioFile       | 待推流的音频文件路径。默认值为 ./send_audio.aac。                              |
| -v, --videoFile       | 待推流的视频文件路径。默认值为 ./send_video.h264。                             |
| -A, --audioCodec      | 推流的音频编码格式，默认值为 8。<li>1: OPUS<li>5: G722<li>8: AACLC<li>9: HEAAC |
| -V, --videoCodec      | 推流的视频编码格式, 默认值为 2。<li>2: H.264<li>6: GENERIC                     |
| -f --fps              | 推流的视频帧率，默认值为 30。                                                  |
| -l, --sdkLogDir       | 存放 SDK 日志的目录，默认值为当前目录。                                        |

### 7. 运行 OpenLive 拉流播放

如需体验完整的推拉流效果，你可以在 Android 真机上安装一个 Agora 提供的 OpenLive 应用，作为收流端来实时观看效果。

1. 选择以下方法之一来安装 OpenLive：
   - 方法一：直接下载预编译版的 [OpenLive-Android](https://download.agora.io/demo/release/open_live_20201110.apk)。
   - 方法二：参考以下文档手动编译 OpenLive。这样可以在体验的同时，为下一步在移动端集成 SDK 做准备。
     - [OpenLive-Android 编译方法](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android)
     - [OpenLive-iOS 编译方法](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS)
2. 运行 OpenLive，输入频道名 `hello_channel`，并以 `AUDIENCE` 身份加入该频道。

> 如果是预编译版，你还需要输入 App ID。

成功加入频道后，你就可以在 Android 上播放来自 Linux 推流端的音频和视频流了。
