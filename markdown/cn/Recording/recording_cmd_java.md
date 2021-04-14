---
title: 命令行录制
platform: Java
updatedAt: 2020-04-29 16:42:21
---
本文介绍如何通过命令行进行录制。 你也可以通过调用 API 实现录制，详见 [Java](./API%20Reference/recording_java/index.html) API 参考。

无论是使用命令行，还是调用 API，实现的都是相同的功能，你可以根据个人习惯选择其中一种方式。当录制 SDK 加入频道时，相当于一个哑客户端加入频道，因此需要跟 Agora Native/Web SDK 加入相同的频道，并使用相同的 App ID 和频道模式。

开始前请确保你已经完成录制 SDK 的环境准备和集成工作，详见[集成客户端](/cn/Recording/recording_integrate)。

## 编译代码示例

打开命令行工具，在 **samples/java** 路径下执行以下命令进行编译：

1. 运行 `find jdk_path jni.h` 以获取 `jni.h` 文件的本地绝对路径，其中 `jdk_path` 请填入你的 Java SDK 安装路径，比如：`/usr/java8u161/jdk1.8.0_161`

2. 执行如下命令进行环境预设置。其中 `jni_path` 请填入获取到的 `jni.h` 文件绝对路径，例如 `/usr/java8u161/jdk1.8.0_161/include/`：

   ```
   source build.sh pre_set jni_path
   ```

3. 配置好 Java 的 CLASSPATH 和 Linux 的 LD_LIBRARY_PATH 环境变量

4. 在 **samples/java** 下执行编译脚本：

   ```
   ./build.sh build
   ```

编译完成，在本目录下生成一个 **bin** 文件夹，其中的子目录 **io/agora/recording** 下会包含一个 `librecording.so` 文件，如图所示。

![](https://web-cdn.agora.io/docs-files/1544521556397)


## 查看录制选项

打开命令行工具，在 **/samples/java/src/io/agora/recording/test** 目录下执行 `java RecordingSample` 命令, 即可看到录制相关的参数和选项，如下所示:

```
Usage:java RecordingSDK --appId STRING --uid UINTEGER32 --channel STRING --appliteDir STRING --channelKey STRING --channelProfile UINTEGER32 --isAudioOnly --isVideoOnly --isMixingEnabled --mixResolution STRING --mixedVideoAudio --decryptionMode STRING --secret STRING --idle INTEGER32 --recordFileRootDir STRING --lowUdpPort INTEGER32 --highUdpPort INTEGER32 --getAudioFrame UINTEGER32 --getVideoFrame UINTEGER32 --captureInterval INTEGER32 --cfgFilePath STRING --streamType UINTEGER32 --triggerMode INTEGER32 
 --appId     (App Id/must) 
 --uid     (User Id default is 0/must)  
 --channel     (Channel Id/must) 
 --appliteDir     (directory of app lite 'AgoraCoreService', Must pointer to 'Agora_Server_SDK_for_Linux_FULL/bin/' folder/must) 
 --channelKey     (channelKey/option)
 --channelProfile     (channel_profile:(0:COMMUNICATION),(1:broadcast) default is 0/option)  
 --isAudioOnly     (Default 0:A/V, 1:AudioOnly (0:1)/option) 
 --isVideoOnly     (Default 0:A/V, 1:VideoOnly (0:1)/option)
 --isMixingEnabled     (Mixing Enable? (0:1)/option)
 --mixResolution     (change default resolution for vdieo mix mode/option)                 
 --mixedVideoAudio     (mixVideoAudio:(0:seperated Audio,Video) (1:mixed Audio & Video with legacy codec) (2:mixed Audio & Video with new codec) default is 0 /option)                 
 --decryptionMode     (decryption Mode, default is NULL/option)                 
 --secret     (input secret when enable decryptionMode/option)                 
 --idle     (Default 300s, should be above 3s/option)                 
 --recordFileRootDir     (recording file root dir/option)                 
 --lowUdpPort     (default is random value/option)                 
 --highUdpPort     (default is random value/option)                 
 --getAudioFrame     (default 0 (0:save as file, 1:aac frame, 2:pcm frame, 3:mixed pcm frame) (Can't combine with isMixingEnabled) /option)                 
 --getVideoFrame     (default 0 (0:save as file, 1:h.264, 2:yuv, 3:jpg buffer, 4:jpg file, 5:jpg file and video file) (Can't combine with isMixingEnabled) /option)              
 --captureInterval     (default 5 (Video snapshot interval (second)))                 
 --cfgFilePath     (config file path / option)                 
 --streamType     (remote video stream type(0:STREAM_HIGH,1:STREAM_LOW), default is 0/option)  
 --triggerMode     (triggerMode:(0: automatically mode, 1: manually mode) default is 0/option) 
 --proxyServer     proxyServer:format ip:port, eg,"127.0.0.1:1080"/option 
 --defaultVideoBg    (default user background image path/option) 
 --defaultUserBg (default user background image path/option))  
 --audioProfile (audio profile(0: standard single channel, 1: high quality single channel, 2: high quality two channels) defualt is 0/option)   
 --logLevel (log level default INFO/option) 
 --audioIndicationInterval(0: no indication, audio indication interval(ms) default is 0/option) 
 --layoutMode    (mix video layout mode:(0: default layout, 1:bestFit Layout mode, 2:vertical presentation Layout mode, default is 0/option)(combine with isMixingEnabled)) 
 --maxResolutionUid    (max resolution uid (uid with maxest resolution under vertical presentation Layout mode  ( default is -1 /option))
```



## 设置录制选项

按照你的需要在命令行中输入以下参数的设置并执行，即可开始使用录制服务。

> `appID`，`uid`，`channel` 和 `appliteDir` 这几个参数必须设置，如不设置则无法录制，其他参数可根据需要自行选择是否设置。

| **参数**                    | 描述                                                         |
| --------------------------- | ------------------------------------------------------------ |
| appID                       | App ID，必须和 Agora Native/Web SDK 的 App ID 一致，详见[获取 App ID](./token?platform=All%20Platforms#app-id)。 |
| uid                         | 用户 ID，32 位无符号整数。建议设置范围：1 到（2<sup>32</sup>-1），并保证唯一性。<br/>有两种设置方式：<li>设置为 0，系统将自动分配一个用户 ID <li>设置一个唯一的用户 ID（不能与频道内的任何 uid 重复） |
| channel                     | 希望录制的通话或直播的频道名                                 |
| appliteDir                  | 必须设置为 `AgoraCoreServices` 存放的目录，SDK 包内该文件默认路径为：**Agora_Recording_SDK_for_Linux_FULL/bin/** |
| channelKey                  | 安全要求较高的用户可以使用 Token 或 Channel Key，详见[校验用户权限](./token)。 |
| channelProfile              | 用于设置频道模式。<li>0：通信模式 (默认)，即常见的 1 对 1 单聊或群聊，频道内任何用户可以自由说话 <li>1：直播模式，有两种用户角色，主播和观众，只有主播可以自由发言。<br/>**频道模式必须与 Agora Native/Web SDK 一致，否则可能导致问题。** |
| isAudioOnly                 | <li>0（默认）：音视频同时录制<li>1：仅启用音频录制功能，关闭视频录制<br />**`isAudioOnly` 和 `isVideoOnly` 不能同时设置为 1。** |
| isVideoOnly                 | <li>0（默认）：音视频同时录制<li>1：仅启用视频录制功能，关闭音频录制<br />**`isAudioOnly` 和 `isVideoOnly` 不能同时设置为 1。** |
| isMixingEnabled             | 是否启用合流（混音或合图）模式，合流是指将频道内所有用户的音频流和视频流分别混合录制到一个文件内。<li>0（默认）：启用单流模式录制。录制文件的声道数和码率与原始音频流的声道数和码率保持一致。<li> 1：启用合流模式录制。录制文件的采样率，码率和声道数与录制前各音视频流的最高值保持一致。 |
| mixResolution | 如果 `isMixingEnabled` 设为 1，可以通过该参数设置合图视频的分辨率，格式为：width，high，fps，Kbps，从左至右分别对应合图的宽、高、帧率和码率。关于合图推荐设置的分辨率，详见 [mixResolution](./API%20Reference/recording_cpp/structagora_1_1recording_1_1_recording_config.html#a522a74ca1a09cecf04c5e127cd70eddf)。 |
| mixedVideoAudio             | 如果 `isMixingEnabled` 设为 1 ，该参数可以设置是否实时混合语音和视频:<li>0（默认）：不混合音频和视频。<li>1：音频和视频混合成一个文件，录制文件格式为 MP4，但播放器支持有限。<li>2：音频和视频混合成一个文件，录制文件格式为 MP4，支持更多播放器。<br>具体的播放器支持，详见 [MIXED_AV_CODEC_TYPE](./API%20Reference/recording_cpp/namespaceagora_1_1linuxsdk.html#af8f3a6529f57ccfa3621014808d1283a)。 |
| decryptionMode              | 频道加密时，录制 SDK 可以启用内置的解密功能。解密方式必须与频道设置的加密方式一致。目前支持以下几种解密方式：<li>“aes-128-xts”：128 位 AES 加密，XTS 模式<li>“aes-128-ecb”：128 位 AES 加密，ECB 模式<li>“aes-256-xts”：256 位 AES 加密，XTS 模式 |
| secret                      | 启用解密模式后，设置的解密密码。                             |
| idle                        | 设置空闲频道超时退出时间，单位为秒，最小值为 3 秒，默认值为 300 秒。如果频道内无用户的状态持续超过该时间，录制程序会自动退出。<br />**idle 的时间也会纳入计费。** |
| recordFileRootDir           | 设置录制文件存放的根目录。设置该参数后，会按照录制日期自动生成子目录保存录制文件。 |
| lowUdpPort                  | 最低 UDP 端口。所设置的端口必须为正整数，且最高 UDP 端口与最低 UDP 端口差值不能小于 4。 |
| highUdpPort                 | 最高 UDP 端口。所设置的端口必须为正整数，且最高 UDP 端口与最低 UDP 端口差值不能小于 4。 |
| getAudioFrame               | 录制音频格式<li> 0：默认音频文件格式<li>1：原始音频数据 AAC 帧格式 <li> 2：原始音频数据 PCM 帧格式<li> 3：原始音频数据 PCM 帧混音格式 |
| getVideoFrame               | 录制视频格式<li> 0：默认视频文件格式 <li>1：原始视频数据 H.264 帧格式<li>2：原始视频数据 YUV 帧格式<li>3：原始视频数据 JPG 帧格式<li> 4：JPG 文件格式<li> 5：原始视频数据 JPG 帧 + MP4 视频文件格式<br>该参数设为 1，2，3 或 5 （即录制原始视频数据）时，有以下限制：<li>不支持合流模式，即不可将 `isMixingEnabled` 设为 1。<li>Web 端录制不支持 H.264 格式的原始视频数据，支持 YUV 的原始视频数据。 |
| captureInterval             | 截屏的时间间隔，最小值为 1 秒，默认值为 5 秒，只有在 `getVideoFrame` 设为 3，4 或 5时生效。 |
| cfgFilePath                 | 指定配置文件的路径。在该配置文件里，你可以设置保存录制文件的绝对路径，但不会自动生成子目录。配置文件的内容必须为 JSON 格式，例如：`{“Recording_Dir” : “recording path”}`，其中 `Recording_Dir` 是固定的，不能改动。 |
| streamType                  | 设置录制的视频流类型，只有在 Agora Native/Web SDK 开启了双流模式时该设置才会生效。<li>0（默认）：录制视频大流<li>1：录制视频小流 |
| triggerMode                 | 选择录制启动模式。<ul><li>0：自动模式，加入频道自动开始录制，离开频道自动停止录制。<li>1：手动模式，手动输入命令开始和结束录制。<ul><li>开始： `killall -s 10 recorder_local` <li>结束：`killall -s 12 recorder_local`</ul></li></ul> |
| proxyServer                 | 代理服务器的 IP 地址和端口号，如 “127.0.0.1:1080”。          |
| audioProfile                | 设置音频编码配置，包括采样率、码率和声道数。<li>0：音频默认设置，采样率 48k，单声道，编码码率为 48 Kbps。<li>1：高音质，采样率 48k，单声道，编码码率 128 Kbps。<li>2：高音质立体声，采样率 48k，双声道，编码码率 192 Kbps。<br> **高音质设置仅在 `isMixingEnabled` 设为 1 时生效。<br>双声道不支持原始音频数据。** |
| audioIndicationInterval     | 说话者监测的时间间隔。默认禁用。<br /><li>0（默认）：禁用说话者监测的功能。<li> \> 0：说话者监测的时间间隔，单位为 ms 。建议设置时间间隔大于 200 ms。一旦检测到频道内有人说话，命令行中会打印出说话者的 uid。 |
| defaultVideoBg              | 默认画布背景图片的路径。                                     |
| defaultUserBg               | 默认用户背景图片的路径。                                     |
| logLevel                    | 设置日志过滤等级，只有等级不高于所设等级的日志才会被生成。默认为 6，即生成所有等级的日志。<li>1：日志等级为 Fatal。<li>2：日志等级为 Error。<li>3：日志等级为 Warn。<li>4：日志等级为 Notice。<li>5：日志等级为 Info。<li>6：日志等级为 Debug。 |
| layoutMode                  | 设置合图布局。<li>0：默认布局<li>1：自适应布局。根据录制画面的数量自动调整每个画面的大小，每个画面大小一致，最多支持 17 个录制画面。<li>2：垂直布局。指定一个 uid 在屏幕左侧显示大流画面，其他用户的小流画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个录制画面。 |
| maxResolutionUid            | 如果 `layoutMode` 设为 2（垂直布局），用该参数设置显示大流画面的用户 uid。 |



## 相关文档

录制完成后，你可能需要使用转码脚本将录制的文件进行合成，详见[使用转码脚本](./recording_voice_video?platform=All%20Platforms#使用转码脚本)。 

录制过程中，如果出现错误码或警告码，请参考[警告代码](./API%20Reference/recording_cpp/namespaceagora_1_1linuxsdk.html#a11cab69078db26c1f166c68e469dcfcf)和[错误代码](./API%20Reference/recording_cpp/namespaceagora_1_1linuxsdk.html#a5f37e3fa14fad2982f248d247d76996b)。