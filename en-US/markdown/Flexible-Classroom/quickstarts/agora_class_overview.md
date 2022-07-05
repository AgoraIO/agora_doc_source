Flexible Classroom is an aPaaS solution provided by Agora for online interactive tutoring. It encapsulates the complex APIs of the Agora RTC SDK, Agora RTM SDK, Interactive Whiteboard SDK, and the Agora Cloud Recording service into modules. Flexible Classroom empowers developers can quickly build apps for online interactive classrooms in a low-code way, with no need to learn the complex logic of real-time audio and video.

Flexible Classroom covers a variety of teaching scenarios, including one-to-one classrooms, small classrooms, and lecture halls. Users can join a flexible classroom in the role of a teacher, student, or teaching assistant. Flexible Classroom has an abundance of features, including real-time audio and video interaction, real-time messaging, interactive whiteboard, recording, screen sharing, and also classroom and user management. More importantly, Flexible Classroom enables developers to customize their classrooms with tools such as the Agora Edu Context, UIKit, and ExtApp. Developers can also connect Flexible Classroom with their own systems, such as their user management system and class management systems.

![](https://web-cdn.agora.io/docs-files/1624525158077)

## Education solution comparison

~a27d6b70-a96d-11eb-b31a-57565fd331e4~

## Scenarios

Flexible Classroom supports the following teaching scenarios:

- One-to-one Classroom: An online teacher gives an exclusive lesson to only one student.
- Small Classroom: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. 小班课中课堂人数上限为 50，如需更多，请联系 sales@agora.io。
- Lecture Hall: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. 大班课中课堂人数上限为 150，如需更多，请联系 sales@agora.io。

## Classroom demonstation

A flexible classroom mainly includes four areas: navigation bar, whiteboard area, video area, and chat area.

### Desktop

![](https://web-cdn.agora.io/docs-files/1624525158077)

### Mobile

![](https://web-cdn.agora.io/docs-files/1620822526000)

## Features

Flexible Classroom supports the following features:

### Real-time audio and video interaction

- In a one-to-one classroom, both the teacher and student can send and receive audio and video streams by default.
- In a small classroom, students do not send audio and video by default. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher.
- In a lecture hall, students do not send audio and video by default. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher.

### Real-time messaging

The teacher and students can send text messages to each other.

### Interactive whiteboard

The teacher can draw and make notes on the whiteboard. Flexible Classroom supports rich drawing tools, including brushes, text boxes, shapes, mosaics, erasers, paging, laser pointer, and digital pens.

### Teaching tools

Flexible Classroom supports the following teaching tools to enhance interactivity:

- Cloud storage: Teaching institutions and teachers can upload files to classrooms to help students better understand the class. Supported formats include PDF, PPT, and DOC. Flexible Classroom also supports pre-downloading courseware to the local before the classroom starts and displaying it on the whiteboard, which enhances the teaching experience.
- Rewards: Teachers can reward students with virtual credits, such as stars and trophies, for good performance during the class.
- User list: Display the status of all users in the classroom, such as whether the user is "on stage", whether the camera and microphone are on or off, the number of rewards. With the user list, the teacher and teaching assistant can ask students to speak up "on stage, grand the permission of drawing on the whiteboard to students, switch on and off the camera and microphone of students, give rewards, and kick a user out of the classroom.
- 答题器：适用于课堂中老师提问、全班学生一起答题的场景。 老师端可在答题器中添加或减少选项数量并设置正确选项，然后发起答题。 学生端收到题目选项后可进行选择。 答题结束后，可统计并展示提交人数和正确率。
- 投票器：适用于课堂中老师向全班学生征集意见的场景。 老师端可在投票器中设置投票主题、选项以及投票的起始和截止时间，然后发起投票。 投票结束后，可统计并展示投票结果。

### Screen sharing

Teachers can share their screens, windows, or browser tabs with students in class.

### Recording and replay

Teachers can start recording in the classroom. 灵动课堂会通过[页面录制](/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)将指定 URL 的页面内容和音频混合录制为一个 MP4 音视频文件，实现音视频内容、白板内容、课件内容同步录制。 录制结束后可提供回放链接供学生课后复习。

### Customizing the UI of classrooms

灵动课堂提供 UIKit。 With UIKit, developers have the freedom to customize the user interfaces, such as changing colors, changing buttons, adjusting layouts, adding logos, even if they do not understand the business logic of the flexible classroom.

### Embedding custom plugins in classrooms

With ExtApp, developers can embed their own applications, such as a countdown plug-in, or a dice, into Flexible Classroom.

### Flexible Classroom cloud service

Agora provides the Flexible Classroom cloud service for classroom and user management:

- Classroom status management.
- Recording status management.
- Public resource management.
- Classroom events.
- User role and permission management.

### Traceability

- Supports testing the audio and video input and output devices before the class and monitoring the network quality during the class to ensure smooth classroom experience.
- 提供全周期通话质量监测和分析工具[水晶球](https://docs.agora.io/cn/Agora%20Analytics/aa_guide?platform=All%20Platforms)。

## Supported platforms

| Classroom roles | Android1<sup></sup> | iOS2<sup></sup> | Web3<sup></sup> | macOS4<sup></sup> | Windows5<sup></sup> |
| :------- | :------- | :--- | :--- | :----- | :------- |
| Teachers | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Students | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Teaching assistants | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |

<div class="alert info">兼容性要求：<ol><li>Android 5.0 or later.</li><li>iOS 10 or later.</li><li>To ensure better end user experience, Agora highly recommends using the latest version of Google Chrome on desktop. 支持学生在移动端的一些社交 app 内（如微信）通过分享的课程网页链接直接进入教室听课。</li><li>macOS 10.10 or later.</li><li>Windows 7 or later.</li></ol></div>

<div class="alert info">灵动课堂 macOS 和 Windows 客户端基于 Electron 框架开发。</div>

## Pricing

According to your actual usage, Agora will charge fees for Real-time Audio and Video Communication, Real-time Messaging, Cloud Recording, and Interactive Whiteboard. See the following documents for the pricing of each product:

- [实时音视频计费说明](/cn/Interactive%20Broadcast/billing_rtc?platform=Android)
- [云信令计费说明](/cn/Real-time-Messaging/billing_rtm?platform=All%20Platforms)
- [页面录制计费说明](/cn/cloud-recording/billing_cloud_recording_web?platform=RESTful)
- [互动白板计费说明](/cn/whiteboard/billing_whiteboard?platform=Web)
- [IM 计费说明](https://www.easemob.com/pricing/im)