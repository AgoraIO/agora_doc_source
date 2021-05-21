声网 Agora 为开发者提供实时音视频 API，只需集成 Agora SDK，即可快速在应用内构建多种实时互动场景。

## SDK 产品

开发者集成 Agora SDK 后，即可以调用不同 API，实现不同场景的实时互动。

| Agora SDK      | 实现功能             | 描述                                                         |
| -------- | -------------------- | ------------------------------------------------------------ |
| 音频 SDK  | [语音通话](/cn/Voice/product_voice)<br>[音频互动直播](/cn/Interactive%20Broadcast/product_live) | SDK 包体积较小，只针对纯音频场景。            |
| 视频 SDK  | [视频通话](/cn/Video/product_video)<br>[视频互动直播](/cn/Interactive%20Broadcast/product_live) | 同时包含语音和视频功能。                                     |
| RTM SDK  | [云信令（原实时消息）](/cn/Real-time-Messaging/product_rtm)            | 提供稳定可靠、低延时、高并发的全球消息云服务，快速构建实时场景。                |
| 录制插件 | [本地服务端录制](/cn/Recording/product_recording)<br>[云端录制](/cn/cloud-recording/product_cloud_recording)             | 可以将语音聊天、视频聊天或直播的内容储存下来，提供给更多人在方便的时间观看。 |

## 自建基础设施

SD-RTN™（Software Defined Real-time Network）软件定义实时网，这是声网自建的底层实时传输网络，实际上，所有通过声网 SDK 接入的实时音视频数据都是通过 SD-RTN™ 传输和调度。这也是全球唯一一个专门针对实时传输设计的基础设施。声网通过智能动态路由算法，确保全球范围内的毫秒级超低延迟传输，端到端优质传输率大于 99%。

| 特性                | 描述                                                         |
| ------------------- | ------------------------------------------------------------ |
| 全球网络覆盖        | <li>覆盖全球 200+ 国家和地区<li>国内数十家中小运营商全覆盖           |
| 接入能力            | <li>多智能终端接入<li>单频道可支持百万人同时在线             |
| QoS 能力增强        | <li>提前预防网络拥塞<li>弱网抗丢包保证                       |
| 基于 QoS 的动态路由 | <li>网络资源综合评估<li>QoS 最优路径保证                     |
| 技术服务 SLA 保障   | <li>7 &times; 24 服务支持保障，包含工单/IM/论坛<li>一对一 VIP 客户服务支撑 |
| 全球网络可靠性   | <li>99.999% 高可用<li>隐藏核心业务，如防 DDOS |
| 全平台互通          | <li>支持 6000+ 终端设备适配<li>支持 Chrome、Safari、Firefox 等主流浏览器<li>支持 iOS、Android、Web、Windows、macOS、Electron、Linux、CoCos、Unity、小程序等平台 |
| 底层协议            | 基于 UDP 协议优化多个私有协议                                |
| 抗丢包优化          | 独创弱网优化抗丢包机制算法，音频 80% 丢包可用                |

## 自研音视频编解码

声网是全球业内唯一使用自研音视频编解码的 RTC 技术服务商。因此，在音视频质量上有一些独特的优势和特点。

### 音频

- 高保真、3D 环绕立体声体验
- 48 kHz 全频带采集：高度还原原声
- 基于机器学习的 3A 算法：回声消除、自动增益、噪声抑制
- 听觉增强：双声道、全景声、听声辨位、混音、混响特效、耳返、变声

### 视频

- 沉浸式视觉体验
- 持续性网络探测：编码前中后对网络进行探测，对网络友好
- 动态网络流控：保持网络带宽资源动态平衡
- 高效抗丢包编码产品：编码算法优化，平滑视频传输，防止网络冲击
- 丢包补偿：自动修复内容缺失，确保视觉体验
- 视觉增强：基于机器学习的美颜功能

## Agora 关键概念

使用 Agora SDK 之前需要了解的重要概念。

#### **控制台**

[控制台](https://console.agora.io/)是声网提供给开发者管理声网各项服务的工具。

控制台提供直观的界面，方便开发者在使用声网各项服务时进行充值、查询、管理等操作。[注册账号](https://console.agora.io/cn/signup)之后，开发者可以通过控制台实现以下主要功能：

- 管理账号信息
- 查看和管理声网项目和服务
- 获取 [App ID](#appid)
- 查看通话质量和用量
- 查看和支付账单
- 管理成员和权限

此外，声网还提供控制台相关 RESTful API，开发者可以实现从服务端踢人、查询用量、查询在线信息等功能。

<a name="appid"></a>
#### **App ID**

App ID 是[控制台](https://console.agora.io/)生成的随机字符串，是 Agora 用于识别开发项目（应用）的唯一标识符。

Agora 以 App ID 识别开发项目，并根据 App ID 提供计费、数据统计等服务。在控制台注册后，你可以创建多个项目，每个项目都有一个唯一的 App ID。详见[获取 App ID](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)。

<div class="alert warning">在安全性较高的场景下（比如生产环境下）你需要使用 Token 鉴权<a href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server?platform=All%20Platforms">校验用户权限</a>，否则任何人可以通过 App ID 直接入侵你的系统。</div>

#### **App 证书**

App 证书也称为 App Certificate，是一串 Agora 提供的随机字符串，用于开启 Agora RTC 和 RTM SDK 的 Token 鉴权，并作为生成 Token 的参数之一。

你可以在[控制台](https://console.agora.io)获取  App 证书，详见[管理 App 证书](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms#管理-app-证书)。

#### <a name="key"></a>**Token**

Token 也称为动态密钥，供 Agora 后台对 app 用户进行权限检查，更多信息请查看[校验用户权限](https://docs.agora.io/cn/Interactive%20Broadcast/token_server?platform=All%20Platforms)。

#### **频道**

频道是由开发者调用 Agora 提供的 API 创建的用于传输实时数据的通道。

根据实时传输数据的类型，Agora 的频道又分为 RTC 频道和 RTM 频道。其中，RTC 频道传输音视频数据，RTM 频道传输消息及信令数据。RTC 频道与 RTM 频道互相独立。

声网组件（本地录制、云端录制等）也可以加入 RTC 频道，实现录制、传输加速、媒体播放、内容安全等功能。

Agora 使用频道名来标识频道。使用相同频道名的用户，可以进入同一个频道进行互动。最后一个用户离开频道时，频道自动消失。

#### **频道场景**

Agora SDK 将根据频道场景应用不同的优化方法。

目前我们有两种频道场景：

| 频道场景 | 描述|
| ---------------- | ---------------- |
| 通信     | 用于一对一通话或群组通话，频道中的所有用户都可以自由通话。 |
| 直播     | 在直播频道中，用户有两种角色：主播和观众。主播能够发送和接收音视频，观众不能发送，只能接收音视频。|

<a name="username"></a>
#### **用户 ID** 

在加入频道时需要传入用户 ID（UID）用于标识频道中的用户。同一频道中的每个用户都应具有唯一的用户 ID。

#### **流**

通常我们提到流或者 Stream 的时候指的是一个包含音视频数据的对象。加入频道的用户可以[发布](#pub)本地的音视频流，[订阅](#sub)其他用户的音视频流。

<a name="pub"></a>
####  **发布**

发布是指频道中的用户将音视频数据发送到频道的操作。通常发布的对象是由用户的麦克风和摄像头采集的音视频数据创建的流，开发者也可以发布由其他来源（如在线音乐文件和用户的屏幕画面）创建的音视频流等。

发布成功后，SDK 会持续向频道中的其他用户发送音视频数据，频道中的其他用户可以订阅发布的音视频流。通过发布自己的音视频流，订阅其他用户的音视频流，用户之间就可以进行实时音视频通信了。

<a name="sub"></a>
#### **订阅** 

订阅是指频道中的用户接收频道内已发布的音视频流的操作。如果频道中其他用户发布了音视频流，用户就可以通过订阅流来接收音视频数据。一个用户可以同时订阅多个用户的音视频流。订阅成功的流可以直接播放或进行其他处理，例如录制或截图等。

## 开发者工具和支持

- [开发者中心](https://docs.agora.io/cn)提供集成和使用 Agora 产品所需的文档、SDK 和 Sample Code 下载。
- [控制台](https://console.agora.io/stat)提供用量统计、项目管理、权限管理、质量追踪、付费等功能，详情见[控制台操作指南](console_overview)。
- Agora [GitHub 官方](https://github.com/AgoraIO) 和 [GitHub 社区](https://github.com/AgoraIO-Community) 提供丰富的开源示例程序和场景化解决方案，也可以通过[开发者中心](https://docs.agora.io/cn/Agora%20Platform/sampleapps)直接获得。
- 开发者支持与服务保证 5 &times; 8，集成问题可提交[开发者社区](https://rtcdeveloper.com)提问，售后质量问题可[提交工单](https://console.agora.io/show-ticket-submission)。
- [水晶球](https://console.agora.io/analytics/call/search) Agora Analytics，为开发者提供的全周期通话质量监测、回溯和分析的解决方案，致力于帮助你及时发现问题、定位原因，并最终解决问题以提升用户体验。详见[水晶球概览](/cn/Agora%20Analytics/aa_guide?platform=All%20Platforms)。