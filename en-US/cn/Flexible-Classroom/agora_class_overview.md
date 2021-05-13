Flexible Classroom is an aPaaS solution provided by Agora for online interactive tutoring. It encapsulates the complex APIs of the Agora RTC SDK, Agora RTM SDK, Interactive Whiteboard SDK, and the Agora Cloud Recording service into modules. Flexible Classroom empowers developers can quickly build apps for online interactive classrooms in a low-code way, with no need to learn the complex logic of real-time audio and video.

Flexible Classroom covers a variety of teaching scenarios, including one-to-one classrooms, small classrooms, and lecture halls. Users can join a flexible classroom in the role of a teacher, student, or teaching assistant. Flexible Classroom has an abundance of features, including real-time audio and video interaction, real-time messaging, interactive whiteboard, recording, screen sharing, and also classroom and user management. More importantly, Flexible Classroom enables developers to customize their classrooms with tools such as the Agora Edu Context, UIKit, and ExtApp. Developers can also connect Flexible Classroom with their own systems, such as their user management system and class management systems.

![](https://web-cdn.agora.io/docs-files/1619757465085)

## Education solution comparison

Agora provides aPaaS and PaaS solutions for online interactive classrooms. See the following table for their differences.

| <span style="white-space:nowrap;">&emsp;&emsp;&emsp;&emsp;</span> | aPaaS solution | PaaS solution |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Solution introduction | Use Flexible Classroom to implement online interactive classrooms. | Integrate the Agora RTC SDK, RTM SDK, Interactive Whiteboard SDK, and Cloud Recording service respectively to implement online interactive classrooms. |
| Target customers | Suitable for customers with limited development resources, tight schedules, and medium demand for customization. | Suitable for customers with sufficient development resources and high demand for customization. |
| Cost | Low | High |
| Development time | As short as 15 minutes | One to three months |
| Features | Supports features including real-time audio and video communication, real-time messaging, interactive whiteboard, recording, screen sharing and so on. Provides the cloud service for classroom and user management. Flexible Classroom can be seamlessly connected with developers' other systems, such as their user management system and class management systems. | Developers implement real-time audio and video, real-time messaging, interactive whiteboard, and other functions all by themselves. |
| Scalability | Medium | High |
| Data security | Agora does not store any business data of customers. | Agora does not store any business data of customers. |
| User interface | Agora provides default classroom user interfaces. Developers also have the freedom to customize user interfaces. | Developers implement user interfaces all by themselves. |
| Platform | <li>Android<li>iOS<li>macOS<li>Windows<li>Web | Supports more than 20 platforms and frameworks. |
| Supported scenarios | One-to-one Classroom Small Classroom     Lecture Hall | Developers define and implement any online interactive teaching scenarios by themselves. |

## Scenarios

Flexible Classroom supports the following teaching scenarios:

- One-to-one Classroom: An online teacher gives an exclusive lesson to only one student.
- Small Classroom: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher.
- Lecture Hall: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher.

## Classroom demonstation

A flexible classroom mainly includes four areas: navigation bar, whiteboard area, video area, and chat area.

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

- Cloud storage: Teaching institutions and teachers can upload files to classrooms to help students better understand the class. Supported formats include PDF, PPT, and DOC. Flexible Classroom also supports pre-downloading courseware to the local before the classroom starts and displaying it on the whiteboard, which enhances the teaching experience.
- Rewards: Teachers can reward students with virtual credits, such as stars and trophies, for good performance during the class.
- User list: Display the status of all users in the classroom, such as whether the user is "on stage", whether the camera and microphone are on or off, the number of rewards. With the user list, the teacher and teaching assistant can ask students to speak up "on stage, grand the permission of drawing on the whiteboard to students, switch on and off the camera and microphone of students, give rewards, and kick a user out of the classroom.

### Screen sharing

Teachers can share their screens, windows, or browser tabs with students in class.

### Recording and replay

Teachers can start recording in the classroom. Flexible Classroom uses [Web Page Recording](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful) to record the audio, video, and whiteboard content in a single file and provides a link to students after the recording finishes.

### Custom the classroom user interface

With UIKit, developers have the freedom to customize the user interfaces, such as changing colors, changing buttons, adjusting layouts, adding logos, even if they do not understand the business logic of the flexible classroom.

### Extension app

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
- Provides [Agora Analytics](https://docs.agora.io/cn/Agora%20Analytics/aa_guide?platform=All%20Platforms) for monitor the quality, user behavior, device state, and Quality of Experience (QoE)/Quality of Service (QoS) statistics.

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
