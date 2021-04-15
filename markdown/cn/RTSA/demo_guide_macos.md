---
title: 快速跑通示例项目
platform: macOS
updatedAt: 2020-11-24 07:39:12
---
本文指导开发者在正式将 RTSA SDK 集成到项目中之前，编译并运行模拟数据 Demo 对进行初步了解。

## 前提条件
请确保开发环境满足以下要求:

* Xcode 9.0 及以上。
* OS X 10.0 及以上真机（MacBook）。

请下载以下文件：

* 最新版本的 Agora RTSA SDK for macOS。
* 模拟数据 Demo。

## 创建 Agora 账号并获取 App ID
1. 进入[控制台](https://console.agora.io/)，并按照屏幕提示注册账号并登录控制台。详见[创建新账号](sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择 App ID 作为**鉴权机制**，再点击“提交”。

![](https://web-cdn.agora.io/docs-files/1574921599254)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目，并找到对应的 App ID。

![](https://web-cdn.agora.io/docs-files/1574921811175)




## 编译运行模拟数据 Demo
步骤如下：

1. 打开终端 Terminal，进入 RTD_DATA_DEMO/bin 目录，将 bin/PLACEHOLDER 重命名为 bin/app_id_and_cert.h。

 ~~~shell
cd RTD_DATA_DEMO/bin
mv PLACEHOLDER app_id_and_cert.h
~~~

2. 在 bin/app_id_and_cert.h 文件中填写你的 App ID。  

	>如果启用了 Agora License 机制，还需要填写 Certificate，用于绑定设备。详见  [Agora License 机制文档](https://docs-preview.agoralab.co/cn/Agora%20Platform/license_mechanism_v3?platform=All%20Platforms)。

3. 将 SDK 包中的 AgoraRtcSDK.framework 复制至 lib 文件夹下。

4. 进行编译：

 ~~~shell
mkdir build && cd build
cmake ..
make -j8
~~~

5. 编译成功后，在 bin 文件夹中会生成一个可执行程序 demo。你可以输入以下命令获取帮助：

 ~~~shell
./bin/demo --help
~~~

 可设置的运行参数列表如下：

 | 参数                        | 描述                                                       |
|-----------------------------|------------------------------------------------------------|
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

6. 设置参数并运行：

 ~~~shell
./bin/demo --channel hello_world_opps
~~~

