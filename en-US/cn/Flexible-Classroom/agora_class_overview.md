Flexible Classroom is an aPaaS solution provided by Agora for online interactive tutoring. It encapsulates the complex APIs of the Agora RTC SDK, Agora RTM SDK, Interactive Whiteboard SDK, and the Agora Cloud Recording service into modules. Flexible Classroom empowers developers can quickly build apps for online interactive classrooms in a low-code way, with no need to learn the complex logic of real-time audio and video.

Flexible Classroom covers a variety of teaching scenarios, including one-to-one classrooms, small classrooms, and lecture halls. Users can join a flexible classroom in the role of a teacher, student, or teaching assistant. Flexible Classroom has an abundance of features, including real-time audio and video interaction, real-time messaging, interactive whiteboard, recording, screen sharing, and also classroom and user management. More importantly, Flexible Classroom enables developers to customize their classrooms with tools such as the Agora Edu Context, UI Kit, and Ext App. Developers can also connect Flexible Classroom with their own systems, such as their user management system and class management systems.

![](https://web-cdn.agora.io/docs-files/1619757465085)

## Education solution comparison

Agora provides aPaaS and PaaS solutions for online interactive classrooms. See the following table for their differences.

| <span style="white-space:nowrap;">&emsp;&emsp;&emsp;&emsp;</span> | aPaaS 教育解决方案 | PaaS 教育解决方案 |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 方案介绍 | 使用 Agora 灵动课堂来实现在线互动教学场景。 | 分别集成 Agora RTC SDK、Agora RTM SDK、Agora 互动白板 SDK 和 Agora 云端录制服务来搭建在线互动教学场景。 |
| 适用客户 | 适用于开发资源有限、排期紧、需要快速上线在线互动教学场景、有定制化需求的客户。 | 适用于开发资源充足、对定制化需求较高的客户。 |
| 开发成本 | 低 | 高 |
| 上线时间 | 最短 15 分钟 | 1 个月至 3 个月 |
| 实现功能 | 提供课堂内的实时互动体验，支持实时音视频、实时消息、互动白板、实时录制、屏幕共享等核心功能。 提供灵动课堂云服务用于课堂和用户管理。 支持业务功能的灵活扩展，能够与教学机构的用户系统和排课系统无缝对接。 | 客户自行实现实时音视频、实时消息、互动白板等功能。 |
| 可拓展性 | 较强 | 强 |
| 业务数据安全 | Agora 不保存客户的业务数据。 | Agora 不保存客户的业务数据。 |
| 前端 UI | Agora 提供默认的课堂 UI 且支持定制化修改。 | 客户自行实现所有 UI。 |
| 平台 | <li>Android<li>iOS<li>macOS<li>Windows<li>Web | 支持超过 20 个平台和框架。 |
| 支持场景 | 1 对 1 互动教学在线互动小班课互动直播大班课 | 客户自行定义和实现任意在线互动教学场景。 |

## Scenarios

Flexible Classroom supports the following teaching scenarios:

- 1 对 1 互动教学：1 位老师对 1 名学生进行专属在线辅导教学。
- 在线互动小班课：1 位老师进行在线教学，多名学生实时观看和收听。 The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher.
- 互动直播大班课：1 位老师进行在线教学，多名学生实时观看和收听。 There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher.

## Classroom demonstation

灵动课堂主要包含导航栏、白板、音视频、实时消息四大区域。

### Desktop

![](https://web-cdn.agora.io/docs-files/1619757500907)

### Mobile

![](https://web-cdn.agora.io/docs-files/1619757513895)


## Features

Flexible Classroom supports the following features:

### Real-time audio and video interactive

- In a one-to-one classroom, both the teacher and student can send and receive audio and video streams by default.
- In a small classroom, students do not send audio and video by default. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher.
- In a lecture hall, students do not send audio and video by default. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher.

### Real-time messaging

The teacher and students can send text messages to each other.

### Interactive whiteboard

The teacher can draw and make notes on the whiteboard. Flexible Classroom supports rich drawing tools, including brushes, text boxes, shapes, mosaics, erasers, paging, laser pointer, and digital pens.

- In a one-to-one classroom, both the teacher and student can draw on the whiteboard.
- In a small classroom, students do not have permission to draw on the whiteboard, and the teacher can give students permission.
- In a lecture hall, students can only watch the whiteboard.

### Teaching tools

Flexible Classroom supports the following teaching tools to enhance interactivity:

- Cloud storage: Teaching institutions and teachers can upload teaching files in various formats such as PDF, PPT, DOC, etc., to help students master the content of the class. Flexible Classroom also supports pre-loading of courseware, which enables the courseware to be loaded locally and displayed in the classroom when the classroom starts, enhancing the teaching experience.
- Rewards: Teachers can reward students with virtual credits, such as stars and trophies, for good performance during the class.
- 用户列表：展示课堂中所有用户的上下台状态、摄像头状态、麦克风状态、奖励个数等信息，老师和助教可通过用户列表进行邀请学生上下台、白板授权、开关音视频、授予奖励、踢人等操作。

### Screen sharing

Teachers can share their screens, windows or browser tabs with students in class.

### Recording and replay

Teachers can start recording in the classroom.  Flexible Classroom will[](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful) mix and record the page content and audio of the specified URL into an MP4 audio and video file through page recording, so as to achieve simultaneous recording of audio and video content, whiteboard content, and courseware content. After the recording is over, a playback link can be provided for students to review after class.

### Custom class UI

灵动课堂提供 UIKit。 开发者无需深入学习灵动课堂的核心业务逻辑，只需通过 UI Kit 修改 UI 组件，即可自定义修改灵动课堂的 UI， 如修改颜色、更换按钮、调整布局、添加 logo 等，使在线互动课堂更为个性化。

### Extension App

灵动课堂提供扩展应用模块 ExtApp，能够帮助开发者根据实际需求在灵动课堂内嵌入自己实现的应用，例如倒计时、骰子等。

### Flexible Classroom cloud service

Agora provides  Flexible Classroom cloud services to support the management of classrooms and users, including the following functions:

- Classroom status management.
- Recording status management.
- Public resource management.
- Classroom events.
- User role and authority management.

### Transparent teaching quality

- 灵动课堂支持课前麦克风、摄像头、扬声器等音视频设备检测以及课中网络状况监测，确保高质量的互动教学体验。
- Provide full-cycle call quality monitoring and analysis tool [crystal ball](https://docs.agora.io/cn/Agora%20Analytics/aa_guide?platform=All%20Platforms).

## Supported platforms

| Classroom roles | Android<sup>1</sup> | iOS<sup>2</sup> | Web<sup>3</sup> | macOS<sup>4</sup> | Windows<sup>5</sup> |
| :------- | :------- | :--- | :--- | :----- | :------- |
| Teachers | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Students | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Teaching assistants | <font color="red">✔</font> | <font color="red">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |

Note:

1. Android 4.4 or later.
2. iOS 10 or later.
3. For a Web client, use the latest stable version of Google Chrome on the desktop.
4. macOS 10.10 or later.
5. Windows 7 or later.

## Pricing

The cloud service of Flexible Classroom is free of charge until December 31, 2021. According to your actual usage, Agora will charge fees for Real-time Audio and Video Communication, Real-time Messaging, Cloud Recording, and Interactive Whiteboard. See the following documents for the pricing of each product:

- [Pricing for Real-time Audio and Video Communication](https://docs.agora.io/cn/Interactive%20Broadcast/billing_rtc?platform=Android)
- [Pricing for Real-time Messaging](https://docs.agora.io/cn/Real-time-Messaging/billing_rtm?platform=All%20Platforms)
- [Pricing for Cloud Recording](https://docs.agora.io/cn/cloud-recording/billing_cloud_recording?platform=RESTful)
- [Pricing for Interactive Whiteboard](https://www.herewhite.com/zh-CN/price)