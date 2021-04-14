---
title: 超级小班课
platform: All Platforms
updatedAt: 2021-01-08 07:52:53
---
## 场景描述

声网超级小班课解决方案将直播大班课的规模优势和互动小班课的教学体验相结合，支持将一个千人直播大班课里的学生拆分成若干个小班，每个小班人数不定，推荐为 4 人。大班中主讲老师进行直播授课，小班中学生进行实时音视频分组讨论。此外，还可为小班配备助教老师。

超级小班课解决方案适用于低幼语培以及 K12 教学，有助于高效复用名校以及名师资源，利用学生之间分组学习的激励，提高学习投入度。

## 平台说明

声网超级小班课场景方案的平台支持如下：

| 课堂角色 | Web<sup>1</sup> | iOS<sup>2</sup> | Android<sup>3</sup> |
| :------- | :--- | :--- | :------- |
| 教师端   | <font color="green">Y    | <font color="red">X    | <font color="red">X        |
| 助教端   | <font color="green">Y    | <font color="red">X    | <font color="red">X        |
| 学生端   | <font color="green">Y    | <font color="green">Y    | <font color="green">Y        |
	
说明：
1. Web Chrome 72 及以上，Web 其他浏览器未经验证。
2. iOS 10 及以上，iOS 9 系列版本未经验证。
3. Android 4.4 及以上。

## 功能列表

| 功能           | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| 实时音视频     | 大班中教师对学生授课，学生能实时接收教师的音视频。<br>小班中学生之间可进行实时音视频互动，助教能够实时接收老师和学生的音视频。 |
| 实时消息       | 学生、教师和助教在课堂中发送实时文字消息进行互动。           |
| 互动白板       | 教师在白板上涂鸦、上传文件（PPT、Word 和 PDF）或播放视频，有助于提炼教学重点，帮助学生理解或记忆。<br>助教和学生只能观看白板，无法操作白板。 |
| 录制回放       | 教师将课堂内容录制下来，并即时生成回放链接，方便学生课后复习和学校评估教学质量。 |
| 课堂管理       | 教师控制课堂的开始或结束，并管理学生的文字聊天权限。助教管理老师和学生在上课过程中发送音视频的权限。 |
| 设备及网络检测 | 正式上课前，教师可以检测麦克风、摄像头等音视频设备能否正常工作，同时整个上课过程中，学生、教师和助教都可以实时检测网络质量，确保课堂顺利进行。 |
| 屏幕共享       | 教师将自己屏幕的内容分享给学生观看，提高教学效果。           |

## App 体验

Agora 为超级小班课提供如下平台的演示 app，点击下方链接进入应用。

<style> table th:first-of-type {     width: 120px; } th:second-of-type {     width: 100px; }</style>
| Android | iOS | PC Web | Windows | macOS |
| ---------------- | ---------------- | ---------------- | ---------------- | ---------------- |
| [点击体验](https://download.agora.io/demo/release/app-AgoraCloudClass-release.apk)  | ![](https://web-cdn.agora.io/docs-files/1581407452682) |  [点击体验](https://solutions.agora.io/education/web_v2)      | [点击体验](https://webdemo.agora.io/AgoraEducation-6.0.0-new.exe) | [点击体验](https://webdemo.agora.io/AgoraEducation-6.0.0-new.dmg) |

打开应用后，按屏幕提示依次填入房间号、用户名，并选择教室类型。根据你的平台选择角色，点击**加入房间**即可体验。
	
## 效果展示
### 教师端

![breakout-teacher](https://web-cdn.agora.io/docs-files/1603982256684)

老师加入房间后，进入大班发送本地音视频流进行授课。在授课过程中，老师可发全局消息，也可进入小班发班级消息。

### 学生端

**学生 1**

![breakout-student1](https://web-cdn.agora.io/docs-files/1603982391733)

**学生 2**

![breakout-student2](https://web-cdn.agora.io/docs-files/1603982403221)

学生加入房间后，先进入大班，订阅老师的音视频流；再按照先后顺序进入小班，发送本地音视频流并订阅小班内其他学生的音视频流。小班人数最多为 4 人，小班个数不限，大班人数不限。学生可发文字消息，老师和小班内的学生能接收到，其他小班的学生不可见。

### 助教端

![breakout-ta](https://web-cdn.agora.io/docs-files/1603982470124)

助教加入房间后，首先看到房间内所有小班的列表。助教可进入任一小班，在小班内可以开启和关闭老师和学生的音视频，还可在小班内发送文字消息与学生进行互动，老师也能看到消息。

## 技术方案

Agora 使用 [Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtc-sdk)、[Agora RTM SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtm-sdk)、[Agora 云端录制服务](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#cloud-recording)、[Agora 房间管理服务](https://agoradoc.github.io/cn/edu-cloud-service/restfulapi/)和第三方白板 SDK 共同搭建超级小班课场景。

![](https://web-cdn.agora.io/docs-files/1603982569611)

各 SDK 或服务实现的功能如下：

| SDK 或服务 | 实现功能 | 
| ---------------- | ---------------- | 
| Agora RTC SDK      | 加入 RTC 频道，进行实时音视频互动。      | 
| Agora RTM SDK      | 登录 RTM 系统并加入 RTM 频道，实现收发实时文字消息。      | 
| Agora 云端录制服务 | 录制实时音视频、录制完成后即时回放。 |
| Agora 房间管理服务      | 为教师端和学生端提供教室后台服务，实现教室信息管理、权限控制等功能。      | 
| 第三方白板 SDK | 实现互动白板相关功能。|

## 方案优势

该方案有如下优势：

**超低延时**

Agora SD-RTN™ 网络节点覆盖全球 200 多个国家和地区，通过就近接入、智能路由等控制策略，保证全球平均端到端延时 < 400 ms。

**稳定可靠**

提供 SLA 质量保证，登录成功率 > 99%，全年可用时间高达 99.99%。

**极致弱网对抗能力**

业界领先的弱网对抗算法，保证在 60% 丢包情况下，音视频通话流畅；70% 丢包情况下，音频通话流畅，真正做到低卡顿、不掉线。


**高音质**

支持 48 kHz 全频带采样，业界领先的 3A 算法（回声消除、噪声抑制、自动增益）和 AI 音频降噪算法，在嘈杂环境下也能保持语音清澈，提供高品质的教学体验。

**高清画质**

支持 48p - 1080p 动态适配，最高支持 4K 极致高清。支持 H.265、超分辨率和感知视频编码，在同等分辨率、帧率情况下，视频占有带宽更低，画质体验更好。



**丰富的功能组件**

- 支持教学白板，包括多种可扩展教具、动态 PPT、H5 课件等；
- 支持屏幕共享、课件共享、笔记共享等；
- 支持课程录制，包括本地录制、云录制、精彩集锦录制等。

**方便易用的后台服务**

为后端开发能力稍弱的开发者提供 Agora Edu 云服务。接入后，开发者无需自研教室后台业务，通过调用 RESTful API 就能轻松快速实现教室信息管理、权限控制等功能。

**课堂质量透明可溯**

Agora 通过如下接口及产品，保障实时音视频的质量：

- 丰富的课前网络和设备检测接口以及完整的课中通话质量回调，排除潜在问题，扫清上课障碍；
- [水晶球](https://console.agora.io/analytics/call/search)工具，显示端到端全链路的质量监控数据，上课过程可追溯，提供用户行为、运行状态、QoE/QoS 的质量数据，帮助排查定位问题。

**全平台适配**

- 支持 Windows、macOS、Web、iOS、Android、Electron 等多达 18 种平台和开发架构适配；
- 支持 6000+ 款机形适配，保证全球师生体验的一致性。