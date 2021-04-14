---
title: 术语库
platform: All Platforms
updatedAt: 2021-01-28 10:42:55
---
## A
#### <a name="agora-rtc-sdk"></a>[**<u>Agora RTC SDK</u>**](./term_agora_rtc_sdk)

Agora RTC (Real-Time Communication) SDK 是声网提供的用于实现音视频实时通信的 SDK。

#### <a name="agora-rtm-sdk"></a>[**<u>Agora RTM SDK</u>**](./term_agora_rtm_sdk)

Agora RTM (Real-time Messaging) SDK 是声网提供的用于实现消息通道、呼叫、聊天、状态同步等功能的 SDK。
	
#### <a name="rtm-native-sdk"></a>**Agora RTM Native SDK**

Android、iOS、macOS、Linux Java、Linux C++ 和 Windows C++ 平台的 Agora RTM SDK 通常被统称为 Agora RTM Native SDK。

#### <a name="appid"></a>[**<u>App ID</u>**](./term_appid)

App ID 是控制台生成的随机字符串，是 Agora 用于识别开发项目（App）的唯一标识符。

#### <a name="appcertificate"></a>[**<u>App 证书 (App Certificate)</u>**](./term_app_certificate)

App 证书是 Agora 控制台为注册项目生成的字符串，用于开启 Token 鉴权，并作为生成 Token 的参数之一。

如果有人窃取了你的 App ID 和 App 证书，就可以在其自己的 app 中实现实时音视频功能，且由此产生的费用和相关数据都会进入你的账号。为避免因泄漏 App 证书造成的损失，请妥善保管好你的 App 证书。Agora 建议你将 App 证书存储在业务服务器上，而非客户端上。

<div class="alert info">相关链接：<a href="https://docs.agora.io/cn/Agora%20Platform/token#appcertificate">启用 App 证书</a></div>

## B

#### <a name="on-premise-recording"></a>**本地服务端录制 (On-premise Recording)**

本地服务端录制是声网针对音视频通话或直播研发的录制组件，用于部署在本地服务端实现录制功能。

使用本地服务端录制，开发者可以在内网完成音视频数据的录制、传输、存储。因此，本地服务端录制较适用于金融监管、政企通信等对音视频数据的传输及存储形式有严格要求的场景。

本地服务端录制 SDK 与 Agora RTC SDK 兼容，支持[单流录制](https://docs.agora.io/cn/Recording/recording_individual_mode?platform=Linux)和[合流录制](https://docs.agora.io/cn/Recording/recording_composite_mode?platform=Linux)两种录制模式，以及[命令行录制](https://docs.agora.io/cn/Recording/recording_cmd_cpp?platform=Linux%20CPP)和[调用 API 录制](https://docs.agora.io/cn/Recording/recording_api_cpp?platform=Linux%20CPP)两种录制方式。另外，本地服务端录制还支持[水印](https://docs.agora.io/cn/Recording/recording_watermark_cpp?platform=Linux%20CPP)、[视频截图](https://docs.agora.io/cn/Recording/recording_screen_capture?platform=Linux)等高阶功能。

<div class="alert info">相关链接：<a href="https://docs.agora.io/cn/Recording/product_recording?platform=Linux">本地服务端录制产品概述</a></div>

## C
#### <a name="cdn-streaming"></a>**CDN 直播推流 (CDN live streaming)**
将直播流发布到 CDN（Content Delivery Network）的过程称为 CDN 直播推流，用户可以通过 Web 浏览器观看直播。

## D

#### <a name="high-stream"></a>**大流 (high-quality video stream)**

开启双流模式后，发送端发送的视频双流中，分辨率更大、码率更高的那路视频流就是视频大流。详见[双流模式](#dual-stream)。

#### <a name="individual-recording"></a>**单流录制模式 (individual recording mode)**

单流录制模式指录制服务（包括本地服务端录制和云端录制）分开录制频道内每个 UID 的音频流和视频流。在该模式下，每个 UID 均有其对应的音频文件和视频文件。例如，某频道内共有 3 个 UID，每个 UID 都发送音频和视频，在单流录制模式下会生成 3 个音频文件和 3 个视频文件。

开发者可以使用我们的音视频合并转码脚本，合并每个 UID 的音频文件和视频文件。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/cloud-recording/cloud_recording_individual_mode">单流录制</a>（云端录制）</li><li><a href="https://docs.agora.io/cn/Recording/recording_individual_mode">单流录制</a>（本地服务端录制）</li><li><a href="https://docs.agora.io/cn/cloud-recording/cloud_recording_merge_files">合并音视频文件</a>（云端录制）</li><li><a href="https://docs.agora.io/cn/Recording/recording_merge_files">合并音视频文件</a>（本地服务端录制）</li></div>

#### <a name="sub"></a>**订阅 (subscribe)**

订阅是指频道中的用户接收频道内已[发布](#pub)的音视频流的操作。如果频道中其他用户发布了音视频流，用户就可以通过订阅流来接收音视频数据。一个用户可以同时订阅多个用户的音视频流。订阅成功的流可以直接播放或进行其他处理，例如录制或截图等。

<div class="alert info">相关链接：
 <li><a href="#channel">频道</a></li>
 <li><a href="#pub">发布</a></li></div>

## F
#### <a name="pub"></a>**发布 (publish)**

发布是指频道中的用户将音视频数据发送到频道的操作。通常发布的对象是由用户的麦克风和摄像头采集的音视频数据创建的流，开发者也可以发布由其他来源（如在线音乐文件和用户的屏幕画面）创建的音视频流等。

发布成功后，SDK 会持续向频道中的其他用户发送音视频数据，频道中的其他用户可以订阅发布的音视频流。通过发布自己的音视频流，[订阅](#sub)其他用户的音视频流，用户之间就可以进行实时音视频通信了。

<div class="alert info">相关链接：
	<li><a href="#channel">频道</a></li>
	<li><a href="#sub">订阅</a></li></div>

## G
#### <a name="audience"></a>**观众 (audience)**

直播场景中，只能接收流、不能发送流的用户为观众。

## H
#### <a name="layout"></a>**合流布局 (video layout)**

合流布局，指将多个用户的音视频流混合为一路音视频流时，频道内各用户画面的大小及其在视频画布上的位置。有时也称作**合图布局**。推流到 CDN 中的合流转码，以及云端录制和本地服务端录制的合流录制，都涉及到多个视频流混合为一路视频流的过程。

我们将视频的背景称为**画布**，每个用户的视频占据一个**画面**。下图展示了视频画布和用户画面之间的关系。

![img](https://web-cdn.agora.io/docs-files/1562906845265)

在使用云端录制、本地服务端录制，以及 Agora RTC SDK 的推流到 CDN 功能时，都有可能需要设置合流布局。

- 录制：使用本地服务端录制或云端录制进行合流录制时，开发者可以选择三种预设的合流布局：悬浮布局、自适应布局和垂直布局。开发者也可以选择自定义合流布局，灵活设置用户画面的大小和在视频画布上的相对位置。

- 推流到 CDN：推流到 CDN 的过程中，当频道中有多个主播，通常需要通过转码将多个主播的音视频流组合成单个流。开发者需要通过设置每个主播的视频参数来设置合流布局。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/cloud-recording/cloud_recording_layout">合流布局</a>（云端录制）</li><li><a href="https://docs.agora.io/cn/Recording/recording_layout">合流布局</a>（本地服务端录制）</li><li><a href="https://docs.agora.io/cn/Audio%20Broadcast/cdn_streaming_apple">推流到 CDN</a></li></div>

#### <a name="composite--recording"></a>**合流录制模式 (composite recording mode)**

合流录制模式指录制服务（包括本地服务端录制和云端录制）将频道内所有 UID 的音视频混合录制为一个音视频文件。

例如，某频道内共有 3 个 UID，每个 UID 都发送音频和视频，在合流录制模式下会生成 1 个录制文件，包含所有 UID 的音频和视频。

> 在使用本地服务端录制时，开发者也可以将所有 UID 的音频混合录制为一个纯音频文件，所有 UID 的视频混合录制为一个纯视频文件。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/cloud-recording/cloud_recording_composite_mode">合流录制</a>（云端录制）</li><li><a href="https://docs.agora.io/cn/Recording/recording_composite_mode">合流录制</a>（本地服务端录制）</li></div>

#### <a name="audio-mixing"></a>**混音 (audio mixing)**
混音是指将两路以上的音频流混合成一路音频流的过程。常见的混音场景如下：

- 音视频通话时，用户在频道内同时播放自己说话的声音和音乐文件的声音，则频道内所有用户都能听到该用户混音后的声音。
- 多人音视频通话时，本地用户听到的声音为所有远端用户混音后的声音。
- 使用合流录制模式录制音频时，得到的录制文件中的声音为频道内所有（或指定）用户混音后的声音。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/audio_effect_mixing_android?platform=Android">播放音效/音乐混音</a></li><li><a href="https://docs.agora.io/cn/cloud-recording/cloud_recording_composite_mode?platform=All%20Platforms">合流录制</a></li></div>

## K
#### <a name="console"></a>**控制台 (Agora Console)**
控制台是声网提供给开发者管理声网各项服务的工具。

控制台提供直观的界面，方便开发者在使用声网各项服务时进行充值、查询、管理等操作。注册账号之后，开发者可以通过控制台实现以下主要功能：

- 管理账号信息
- 查看和管理声网项目和服务
- 获取 App ID
- 查看通话质量和用量
- 查看和支付账单
- 管理成员和权限

此外，声网还提供控制台相关 RESTful API，开发者可以实现从服务端踢人、查询用量、查询在线信息等功能。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Agora%20Platform/console_overview?platform=All%20Platforms">控制台概览</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/dashboard_restful_communication?platform=All%20Platforms">控制台 RESTful API</a></li></div>

## L
#### <a name="co-hosting"></a>**连麦 (co-hosting)**

连麦指在直播场景中，两个及以上主播进行互动的过程。频道内的观众可以看到这些主播并听到他们的声音。

有以下两种情况：

- 一个频道内，两个及以上主播进行连麦互动。既可以是多个主播加入同一频道；也可以是频道内的观众申请上麦，切换用户角色成为连麦主播，与原有的主播进行互动。
- 两个及以上频道内的主播进行连麦互动。Agora RTC SDK 支持将某一频道中主播的媒体流转发至多个其他频道中，实现跨频道连麦。具体实现方式参见跨直播间连麦。

一个频道同一时间连麦主播的数量限制，详见 [Agora RTC SDK 最多支持多少人同时在线](https://docs.agora.io/cn/faqs/capacity)。如果连麦主播数量过多时，可能会出现音画不同步和信息丢失的问题，建议参考[七人以上视频场景](https://docs.agora.io/cn/Interactive%20Broadcast/multi_user_video_android)来保证通信质量。

<div class="alert info">相关链接：
<li><a href="#become-host">上麦</a></li>
<li><a href="#become-audience">下麦</a></li>
<li><a href="#channel_prpofile">频道场景</a></li>
<li><a href="#host">主播</a></li>
<li><a href="#audience">观众</a></li>
</div>

#### <a name="stream"></a>**流 (stream)**

通常我们提到流的时候指的是一个包含音视频数据的对象。在通话和直播中，用户可以发布本地的音视频流，订阅其他用户的音视频流。

#### <a name="fallback"></a>**流回退 (stream fallback)**

在多人实时音视频场景中，如果网络环境不理想，无法同时保证音频和视频的质量，实时音视频的质量就会下降。为保证通信或直播不受影响，发送端和接收端可以启用流回退的功能，设置弱网下音视频流回退为音频流，或视频由大流回退为小流，以保证或提高音频质量。

当网络环境改善时，回退的音频流或视频小流又可以恢复为原来的音视频流或视频大流。

<div class="alert info">相关链接：<li><a href="#dual-stream">双流模式</a></li><li><a href="#high-stream">大流</a></li><li><a href="#low-stream">小流</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/fallback_android?platform=Android">视频流回退</a></li></div>

	
## M
#### <a name="media-player"></a>**媒体播放器组件 (MediaPlayer Kit)**

媒体播放器组件是 Agora RTC SDK 的一个组件，适用于直播场景下播放本地或在线媒体资源，并将主播播放的媒体流发送给其他用户。此外，该组件支持解析媒体附属信息，提供媒体资源的原始音视频数据接口，开发者可以自行实现更多功能。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/mediaplayer_release_android?platform=Android">媒体播放器组件发版说明</a></li>
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/mediaplayer_android?platform=Android">媒体播放器组件集成和 API 文档</a></li>
</div>

## P
#### <a name="channel"></a>**频道 (channel)**

频道是由开发者调用 Agora 提供的 API 创建的用于传输实时数据的通道。

根据实时传输数据的类型，Agora 的频道又分为 RTC 频道和 RTM 频道。其中，RTC 频道传输音视频数据，RTM 频道传输消息及信令数据。RTC 频道与 RTM 频道互相独立。

声网组件（本地录制、云端录制等）也可以加入 RTC 频道，实现录制、传输加速、媒体播放、内容安全等功能。

App ID 一致的前提下，Agora 使用频道名来标识频道。使用相同频道名的用户，可以进入同一个频道进行互动。最后一个用户离开频道时，频道自动消失。

为保证通信安全，用户在加入频道时，通常还需要提供一个动态密钥进行鉴权。动态密钥如果失效，用户会无法使用 Agora 的服务，可能的表现为：正在进行的通话被强制终止，或者被踢出频道。

<div class="alert info">相关链接：
<li><a href="https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms">校验用户权限</a></li>
<li><a href="#agora-rtc-sdk">Agora RTC SDK</a></li>
<li><a href="#agora-rtm-sdk">Agora RTM SDK</a></li>	
</div>

#### <a name="channel-profile"></a>**频道场景 (channel profile)**

Agora 目前支持以下三种频道场景，并根据频道场景进行不同的优化。

| 频道场景 | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| 通信     | 用于一对一通话或群组通话，频道中的所有用户都可以自由通话。   |
| 直播     | 在直播场景中，用户有两种角色：主播和观众。主播能够发送和接收音视频，观众不能发送，只能接收音视频。 |
| 游戏     | 频道中的任何用户都可以自由通话。 此场景默认使用具有低功耗和低码率的编解码器。 |

<div class="alert note">游戏场景仅可用于 Agora Gaming SDK 。</div>

## S
#### <a name="sd-rtn"></a>**SD-RTN™**

SD-RTN™ 是 Software Defined Real-time Network 的缩写，即软件定义实时网，这是声网自建的底层实时传输网络。

所有通过声网 SDK 接入的实时音视频数据都通过 SD-RTN™ 传输和调度，这也是全球唯一一个专门针对实时传输设计的基础设施。目前，声网在全球部署 250 多个数据中心，通过智能动态路由算法，确保全球范围内的毫秒级超低延迟传输，保证技术服务高可用。

#### <a name="become-host"></a>**上麦 (becoming a host)**

上麦指直播场景中的观众切换用户角色成为主播这一行为。

如果频道内已经有主播，成功上麦的用户也称为连麦主播。连麦主播会发布音视频流，频道内其他用户均能听到并看到该连麦主播。

<div class="alert info">相关链接：
<li><a href="#become-audience">下麦</a></li>
<li><a href="#co-hosting">连麦</a></li>
<li><a href="#channel_prpofile">频道场景</a></li>
<li><a href="#host">主播</a></li>
<li><a href="#audience">观众</a></li>
</div>

#### <a name="rtsa"></a>**实时码流加速 (RTSA, Real-Time Streaming Acceleration)**

实时码流加速是声网提供的用于实现自定义音视频码流在互联网上的实时传输的产品。

实时码流加速提供 API，充分利用声网自建的底层实时传输网络 SD-RTN™，实现高连通性、高实时性、高稳定性的码流传输云服务。

实时码流加速支持 Linux、iOS、Android、macOS、Windows 平台，SDK 具有极小的包体积和内存占用，适用于 IoT、社交、教育、客服等多个行业中自研音视频采集和编解码的场景，例如使用特殊编码格式、自定义加密编码、非主流编码格式。

<div class="alert info">相关链接：
<li><a href="https://docs.agora.io/cn/RTSA/product_rtsa?platform=All%20Platforms">实时码流加速产品概述</a></li>
<li><a href="#sd-rtn">SD-RTN™</a></li>
</div>

	
#### <a name="video-profile"></a>**视频属性 (video profile)**

视频属性指本地编码视频的分辨率、码率、帧率等属性，又称为 “视频编码属性”。声网提供接口供开发者设置理想网络状态下本地视频编码时的分辨率、码率、帧率、视频方向模式等属性。本地视频流在编码后即会发送给频道内远端用户，故开发者对本地视频属性的设置会影响远端用户所见。

<div class="alert info">相关链接：<a href="https://docs.agora.io/cn/Interactive%20Broadcast/video_profile_android?platform=Android">设置视频属性</a>
</div>
	
	
#### <a name="render-first-video"></a>**首帧出图 (render the first video frame)**

首帧出图指视频的第一帧在本地设备上渲染显示。有以下两种情况：

- 本地视频首帧出图：本地摄像头采集视频的第一帧显示在本地设备的本地视图上。
- 远端视频首帧出图：接收的远端用户视频的第一帧显示在本地设备的远端视图上。

首帧出图时间指本地或远端视频首帧出图距本地或远端用户加入频道的时间推移。首帧出图时间与开发者的硬件和软件都有关系，声网的工程师致力于不断降低首帧出图时间，使开发者的 app 达到视频秒开的水平。
	
#### <a name="dual-stream"></a>**双流模式 (dual-stream mode)**

实时音视频互动过程中，Agora 需要将发布的视频流传输给订阅了这路视频流的用户。发布一路视频流，就会传输一路视频流。

双流模式下，SDK 在发送一路视频流的同时，会自动额外发送一路低分辨率、低码率的视频流。其中，原视频流分辨率更大、码率更高，称为视频大流；更模糊、尺寸更小的视频流称为小流。

订阅视频小流可以降低带宽占用、提升流畅，因此在网络环境不稳定，或频道内发流用户较多的场景下，你可以设置接收小流。

大流与小流的关系如下：

- SDK 根据大流的视频属性自动设置小流的默认视频属性
- 小流的宽高比例默认与大流的宽高比例一致

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/multi_user_video_android?platform=Android">7 人以上视频场景</a></li>
<li><a href="#fallback">流回退</a></li>
<li><a href="#high-stream">大流</a></li>
<li><a href="#low-stream">小流</a></li>
</div>

	
#### <a name="inject-stream"></a>**输入在线媒体流 (Inject Online Media Stream)**

输入在线媒体流指直播场景下，输入在线音视频流至 Agora 频道内供所有用户欣赏。Agora RTC SDK 为开发者提供接口允许主播输入一路在线音视频流或纯音频流至 Agora 频道。

<div class="alert info">相关链接：<a href="https://docs.agora.io/cn/Interactive%20Broadcast/inject_stream_android?platform=Android">输入在线媒体流</a>
</div>
	
	
#### <a name="agora-analytics"></a>**水晶球 (Agora Analytics)**
水晶球是声网提供给开发者对全周期通话质量进行监测、回溯和分析的工具。

水晶球提供直观的界面，帮助开发者从通话质量、通话用量、影响因素等维度发现问题、定位原因，并最终解决问题。

声网还提供水晶球相关 RESTful API，可以让开发者直接通过网络请求获取水晶球里的数据，在自己的网页或应用中灵活使用。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Agora%20Platform/aa_guide?platform=All%20Platforms">水晶球概览</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/aa_api?platform=All%20Platforms">水晶球 RESTful API</a></li></div>

## T
#### <a name="token"></a>**Token**

Token 也称为动态密钥，用于在生产环境等安全要求更高的环境下对 app 用户在加入 RTC 频道或登录 RTM 系统时进行动态鉴权。



- 对于 RTC 产品、本地录制和云录制产品，Token 用于在用户加入频道时检查 App ID、用户加入频道权限、用户发流权限，和用户权限有效期；
- 对于 RTM 产品， Token 用于在用户登录 RTM 系统时检查 App ID、用户角色，和用户权限有效期。

正式生产环境下， Token 需要由客户自行在业务服务端生成并在加入RTC 频道或登录 RTM 系统时回传给客户端。处于测试阶段的 RTC 产品客户如果不想自己的业务服务端搭建 Token 生成器，也可以在[控制台](https://console.agora.io/)创建项目后选择由控制台生成临时 Token。临时 Token 的功能与正式 Token 完全一致。

所有 Token 都有授权有效期和服务有效期两种有效期。授权有效期是在用户生成 Token 时设置的权限的有效时间；Token 的服务有效期指的是每个 Token 在生成后的过期时间，默认设为 24 小时。

RTC 产品、本地录制和云录制产品的用户的 Token 有效期（无论是授权有效期还是服务有效期）到期时用户会被立刻踢出所在频道；RTM 产品的用户 Token 有效期到期时，用户不会被立即踢出 RTM 系统，但是在下次连接服务器时无法成功登录。所有用户在 Token 即将到期或到期时应尽快重新生成 Token 用于下次加入 RTC 频道或登录 RTM 系统。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Agora%20Platform/token#appcertificate">启用 App 证书</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/token#temptoken">获取临时 Token</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server_cpp">生成 RTC 产品的 Token</a></li><li><a href="https://docs.agora.io/cn/Real-time-Messaging/rtm_token">生成 RTM 产品的 Token</a></li>
</div>

## X
#### <a name="become-audience"></a>**下麦 (becoming an audience)**

下麦指直播场景中的主播切换用户角色成为观众这一行为。主播成功下麦后，停止发布音视频流，频道内其他用户不再听到并看到该主播。

<div class="alert info">相关链接：
<li><a href="#become-host">上麦</a></li>
<li><a href="#co-hosting">连麦</a></li>
<li><a href="#channel_prpofile">频道场景</a></li>
<li><a href="#host">主播</a></li>
<li><a href="#audience">观众</a></li>
</div>

#### <a name="low-stream"></a>**小流 (low-quality video stream)**

开启双流模式后，发送端发送的视频双流中，分辨率跟小、码率更低的那路视频流就是视频小流。详见[双流模式](#dual-stream)。

## Y
#### <a name="username"></a>**用户 ID (user ID)**

在加入 RTC [频道](#channel)或者登录 [RTM](#agora-rtm-sdk) 系统时需要传入用户 ID 用于标识频道中的用户。同一频道中的每个用户都应具有唯一的用户 ID。

#### <a name="raw-data"></a>**原始音视频数据 (raw data)**
原始音视频数据，又称音视频裸数据，是指音视频传输过程中获取到的纯音视频数据。

- 从发送端获取的原始音视频数据，是指直接从数据源（麦克风、摄像头等）采集且未经过处理的数据。
- 从接收端获取的原始音视频数据，是指远端用户发送到本地解码器解码后的数据。

常见的原始音频数据格式为 PCM（脉冲编码调制），常见的原始视频数据格式为 RGB 和 YUV420。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/raw_data_audio_android?platform=Android">原始音频数据</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/raw_data_video_android?platform=Android">原始视频数据</a></li><li><a href="https://docs.agora.io/cn/Recording/recording_raw_data?platform=Linux">获取原始音视频数据</a></li></div>

#### <a name="cloud-recording"></a>**云端录制 (Cloud Recording)**

云端录制是声网针对音视频通话和直播研发的录制组件，提供云端录制 RESTful API 供开发者实现录制功能，并将录制文件存至第三方云存储。

同本地服务端录制相比，云端录制无需部署 Linux 服务器，减轻了研发和运维的压力，更轻量便捷，适用于在线教育、社交直播、客户服务等多数场景。

云端录制 RESTful API 与 Agora RTC SDK 兼容，提供[单流录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_individual_mode?platform=All%20Platforms)和[合流录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_composite_mode?platform=All%20Platforms)两种录制模式。

<div class="alert info">相关链接：<a href="https://docs.agora.io/cn/cloud-recording/product_cloud_recording">云端录制产品概述</a></div>

## Z
#### <a name="host"></a>**主播 (host/broadcaster)**
直播场景中，可以发送和接收流的用户为主播。

#### <a name="transcoding"></a>**转码 (transcoding)**
在推流到 CDN 过程中，当频道中有多个主播时，通常会涉及到转码。

在推流到 CDN 过程中，发送到 SD-RTN™ 的音视频流从 UDP 协议被转换成 RTMP（Real-Time Messaging Protocol）协议。如果有多个主播，就需要通过转码在协议转换之前将多个直播流组合成单个流，并设置这个流的音视频属性和合图布局。

<div class="alert note">声网建议不要在单主播的情况下使用转码。</div>

#### <a name="custom-rendering "></a>**自渲染 (custom rendering)**
自渲染，又称自定义渲染，是指开发者从 SDK 获取原始音视频数据后自行渲染的过程。

当默认的音视频模块无法满足开发需求时，开发者可以使用外部渲染器对音视频数据进行渲染。例如：

- 将获取到的原始音视频数据传入其他的音视频渲染引擎。
- 需自定义音视频渲染方式，比如自定义渲染动画等。
- 当默认的渲染器被其他业务占用时，为避免音视频服务与其它业务产生冲突，需使用外部渲染器对原始音视频数据进行渲染。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/custom_audio_android?platform=Android">自定义音频采集和渲染</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/custom_video_android?platform=Android">自定义视频采集和渲染</a></li></div>