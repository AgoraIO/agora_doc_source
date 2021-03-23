灵动课堂是声网提供的在线互动课堂 aPaaS 解决方案，对 Agora RTC SDK、Agora RTM SDK、互动白板 SDK 和云端录制的复杂 API 进行模块化封装，简化客户端 API 并提供云服务。 灵动课堂覆盖多种班型的教学场景，在实现课堂内实时互动功能的基础上，支持业务功能的灵活拓展，可以与客户业务系统（用户系统和排课系统）对接，极大地降低了开发门槛，能够帮助开发者快速集成上线个性化在线教学平台。

## 教育解决方案区别

声网针对在线互动课堂提供 aPaaS 和 PaaS 两种解决方案。 下表列出这两种解决方案的详细区别：


| <span style="white-space:nowrap;">&emsp;&emsp;&emsp;&emsp;</span> | aPaaS 教育解决方案 | PaaS 教育解决方案 |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :------------------------------------------- |
| 适用客户 | 适用于开发排期紧、需要快速上线在线教学平台、有一定定制化需求的客户 | 适用于开发周期较长、对定制化需求较高的客户 |
| 开发成本 | 低 | 高 |
| 上线时间 | 最短 15 分钟 | 1 个月至 3 个月 |
| 实现功能 | <li>主要提供课堂内的实时互动体验，涵盖实时音视频、实时消息、互动白板、录制、屏幕共享等核心功能<li>提供云服务<li>支持业务功能的灵活扩展，与客户的用户系统和排课系统对接 | 客户自行实现实时音视频、实时消息、白板等功能 |
| 可拓展性 | 较强 | 强 |
| 业务数据安全 | 声网不保存客户业务数据 | 声网不保存客户业务数据 |
| 前端 UI | 提供默认的课堂 UI 且支持定制化修改 | 客户自行实现所有 UI |
| 平台 | <li>Android<li>iOS<li>macOS<li>Windows<li>Web | 支持超过 20 个平台和框架 |
| 支持场景 | <li>0: One-to-one Classroom.<li>1: Small Classroom.<li>互动直播大班课 | 客户自行定义和实现任意在线教学场景 |

## 实现场景

声网灵动课堂支持以下教学场景：

| <span style="white-space:nowrap;">场景&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span> | Description |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| 0: One-to-one Classroom. | 1 位老师对 1 名学生进行专属在线辅导教学，老师和学生进行实时音视频互动。 |
| 1: Small Classroom. | 1 位老师对 N 名学生（2 ≤ N ≤ 16）进行在线辅导教学，老师和学生进行实时音视频互动。 |
| 互动直播大班课 | Thousands of students watch an online lecture. Students can "raise their hands" to interact with the teacher. |

## Product features

声网灵动课堂支持以下功能：

| Function | Description |
| :------------- | :----------------------------------------------------------- |
| 实时音视频互动 | <li>1 对 1 互动教学和 1 对 N 在线小班课，学生和老师默认都可以发送和接收音视频流。<li>互动直播大班课中，默认情况下，学生不发流。 上课过程中，学生可以"举手"请求发言，老师同意后可发流与老师进行互动。 |
| 实时消息互动 | 老师和学生可以在课堂中发送文字消息进行互动。 |
| 互动白板 | 老师可在白板上进行绘画涂鸦，支持画笔、文本框、图形、马赛克、橡皮擦、分页、课件上传（图片、PPT、Word、PDF、音视频）等功能。<li>1 对 1 互动教学中，学生和老师默认都可以操作白板。<li>1 对 N 在线小班课中，学生默认没有权限操作白板，老师可以授权学生操作白板。<li>互动直播大班课中，学生不能操作白板，只能观看。 |
| 云服务 | 声网提供灵动课堂云服务，支持以下功能：<li>房间状态管理。<li>录制状态管理。<li>获取频道事件。 |
| 教学质量透明 | <li>支持课前麦克风、摄像头、扬声器等音视频设备检测、课中网络监测。<li>提供全周期通话质量监测和分析工具[水晶球](/cn/Agora%20Analytics/aa_guide?platform=All%20Platforms)。 |
| 屏幕共享 | 老师可在课堂中将自己的屏幕、窗口或浏览器标签页分享给学生观看。 |
| 录制回放 | 老师可在课堂中开启录制。 老师的音视频流、白板内容、课件内容同步录制。 录制结束后提供回放链接供学生课后复习。 |

## 平台支持

| 课堂角色 | Android<sup>1</sup> | iOS<sup>2</sup> | Web<sup>3</sup> | macOS<sup>4</sup> | Windows<sup>5</sup> |
| :------- | :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- |
| 老师端 | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| 学生端 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |

说明：

1. Android 4.4 or later.
2. iOS 10 or later.
3. Web 端请使用桌面端 Google Chrome 最新稳定版。
4. macOS 10.10 或以上版本。
5. Windows 7 或以上版本。

## 计费说明

声网灵动课堂云服务在 2021 年 12 月 31 日前免费。 根据你的实际用量，声网会分别收取实时音视频、云信令（原实时消息）、云端录制和互动白板的费用。 具体收费规则请参考以下文档：

- [实时音视频计费说明](https://docs.agora.io/cn/Interactive%20Broadcast/billing_rtc?platform=Android)
- [云信令计费说明](https://docs.agora.io/cn/Real-time-Messaging/billing_rtm?platform=All%20Platforms)
- [云端录制计费说明](https://docs.agora.io/cn/cloud-recording/billing_cloud_recording?platform=RESTful)
- [互动白板计费说明](https://www.herewhite.com/zh-CN/price)