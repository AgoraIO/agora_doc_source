---
title: 快速跑通示例项目
platform: Windows
updatedAt: 2020-11-24 07:43:13
---

本文指导用户在正式将 RTD 集成到项目中之前，编译并运行模拟数据 Demo 对进行初步了解。

## 前提条件

请确保开发环境满足以下要求:

- 操作系统： Microsoft Windows 7 及以上。
- 编译器：Microsoft Visual C++ 2017（推荐）。
- CMake 3.2 及以上。

请下载以下文件：

- RTD 包（TODO 插链接）。
- 模拟数据 Demo （TODO 插链接）。

## 创建 Agora 账号并获取 App ID

1. 进入 [Agora Dashboard](https://dashboard.agora.io/) ，并按照屏幕提示注册账号并登录 Dashboard。详见[创建新账号](sign_in_and_sign_up)。
2. 点击**项目列表**处的**新手指引**。

   ![](https://web-cdn.agora.io/docs-files/1563521764570)

3. 在弹出的窗口中输入你的第一个项目名称，然后点击**创建项目**。你可以参考屏幕提示，了解实现一个视频通话的基本步骤。

   ![](https://web-cdn.agora.io/docs-files/1563521821078)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目。点击项目名后的**编辑**按钮，进入项目页。你也可以直接点击左边栏的**项目管理**图标，进入项目页面。

   ![](https://web-cdn.agora.io/docs-files/1563522909895)

5. 在**项目管理**页，你可以查看你的 **App ID**。

   ![](https://web-cdn.agora.io/docs-files/1563522556558)

## 编译运行模拟数据 Demo

步骤如下：

1. 进入 RTD_DATA_DEMO\bin 目录，将 bin\PLACEHOLDER 重命名为 bin\app_id_and_cert.h。
2. 在 bin\app_id_and_cert.h 文件中填写你的 App ID。

> 如果启用了 Agora License 机制，还需要填写 Certificate，用于绑定 IoT 设备。详见 [Agora License 机制文档](/cn/Agora%20Platform/agora_license_mechanism)。

3. 将 SDK 包中的 include 文件夹和 libagora-rtc-sdk.lib 复制到 lib 文件夹下，libagora-rtc-sdk.dll 复制到目标运行目录下（如 build/bin/Debug）。
4. 创建 build 目录, 从 CMake 生成 VS 工程：
   1). 填写 demo 目录和 build 文件夹目录如下：
   ![](https://web-cdn.agora.io/docs-files/1556520849021)
   2). 点击 Generate，在弹出的界面选择系统类型和 Visual Studio 版本。举例来说，如果你使用 Win10 64 位和 Visual Studio 17，可以选择 Visual Studio 15 2017 Win64。
   ![](https://web-cdn.agora.io/docs-files/1556520902662)
   3). 点击 Finish，CMake 将会在 build 目录下生成对应的 Visual Studio 工程，然后用 Visual Studio 打开编译即可。

5. 编译成功后，会生成一个可执行程序 demo.exe，根据制定的编译类型，可能在 build\bin\Debug 或 buid\bin\Release 目录下。复制 libagora-rtc-sdk.dll 到该目录，即可运行 demo.exe。

6. 打印帮助信息：
   打开命令行 (cmd) 并进入 buid\bin\Release 或 buid\bin\Debug 目录中，运行如下命令打印帮助信息：

```bash
demo.exe --help
```

    可以看到可配置的运行参数如下：

| 参数                        | 描述                                                       |
| --------------------------- | ---------------------------------------------------------- |
| app_id                      | App ID，项目的唯一标识。                                   |
| cert [Optional]             | Certificate for License，用于绑定 IoT 设备。               |
| audio_bps [Optional]        | 音频码率，int32 类型。                                     |
| audio_fps [Optional]        | 音频帧率，int32 类型。                                     |
| channel [Optional]          | 频道名，string 类型。                                      |
| duration [Optional]         | 频道时长（秒），int32 类型。                               |
| key_interval [Optional]     | 关键帧间隔（毫秒），uint32 类型。                          |
| round [Optional]            | Demo 运行的次数，uint32 类型。从加入频道到退出频道为一轮。 |
| video_fps [Optional]        | 视频帧率，int32 类型。                                     |
| video_target_bps [Optional] | 视频目标码率，int32 类型。                                 |
| verbose [Optional]          | 啰嗦模式。启用该模式后会打印更多信息。                     |

7. 设置参数并运行：

```shell
demo.exe --channel hello_world_opps
```
