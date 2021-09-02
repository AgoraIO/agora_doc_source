Flexible Classroom is an aPaaS solution provided by Agora for online interactive tutoring. It encapsulates the Agora RTC SDK, Agora RTM SDK, Interactive Whiteboard SDK, and the Agora Cloud Recording service in modules. Flexible Classroom empowers developers to quickly build apps for online interactive classrooms in a low-code way, with no need to learn the complex logic of real-time audio and video.

Flexible Classroom covers a range of teaching scenarios, including individual instruction, small- or medium-sized classes, and large lectures. Users join online classes in one of three roles, each of which has different permissions: teacher, student, or teaching assistant.

The modular features of Flexible Classroom include real-time audio and video interaction, real-time messaging, interactive whiteboard, cloud recording, and screen sharing, as well as classroom and user management functions. Agora provides developers with tools to customize the UI of the classrooms, embed their own plugins, and control business functions and callbacks. Developers can also connect Flexible Classroom with their own management system and class scheduling system if they prefer.

![](https://web-cdn.agora.io/docs-files/1620992401221)

## Education solution comparison

Flexible Classroom provides an aPaaS solution to complement the existing Agora PaaS solutions for online interactive classrooms. The following table compares the two solutions:

| <span style="white-space:nowrap;">&emsp;&emsp;&emsp;&emsp;</span> | Flexible Classroom (aPaaS) | PaaS solution |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Solution structure | Flexible Classroom modules. | Integrated implementation of the Agora RTC SDK, RTM SDK, Interactive Whiteboard SDK, and Cloud Recording service. |
| Target customers | Suitable for those with limited development resources, tight schedules, and moderate customization needs. | Suitable for those with experienced development resources, sufficient development time, and substantial customization needs. |
| Implementation cost | Low | High |
| Development time | As short as 15 minutes | One to three months |
| Feature implementation | Modular implementation of real-time audio and video communication, real-time messaging, interactive whiteboard, cloud recording, screen sharing, and cloud-based classroom and user management. Integration with developers' own management systems is possible.| Developers must implement real-time audio and video, real-time messaging, interactive whiteboard, and other functions on their own using Agora SDKs and APIs. |
| Extensibility and customization | Medium | High |
| Data security | Agora does not store customer business data. | Agora does not store customer business data. |
| User interfaces | Flexible Classroom provides default classroom user interfaces. A customization tool (Agora UIKit) makes a moderate level of UI customization easy to implement. | Developers implement all user interfaces on their own. |
| Platforms supported  |<ul><li>macOS<li>Windows<li>Web<li>Android (students only)<li>iOS (students only)</ul> | More than 20 platforms and frameworks. |
| Scenarios supported |<ul><li>One-to-one Classroom<li>Small Classroom<li>Lecture Hall</ul> | Developers define and implement any online interactive teaching scenarios on their own. |

## Scenarios

Flexible Classroom supports the following teaching scenarios:

- One-to-one Classroom: An online teacher gives an exclusive lesson to only one student.
- Small Classroom: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak "on stage" in real-time audio and video interaction with the class.
- Lecture Hall: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" for permission to speak. If the teacher approves, a student can send their audio and video to interact with the class.

## Classroom UI examples

The classroom UI in Flexible Classroom typically consists of four areas: a navigation bar, a whiteboard space, real-time audio/video windows, and real-time text chat window.

### Desktop

![](https://web-cdn.agora.io/docs-files/1622430316012)

### Mobile

![](https://web-cdn.agora.io/docs-files/1622431132516)

## Features

Flexible Classroom supports the following features:

### Real-time audio and video interaction

- In a one-to-one classroom, both the teacher and student can send and receive audio and video streams by default.
- In a small classroom, students cannot send audio and video by default. During the class, the teacher can invite students to speak "on stage" and to have real-time audio and video interactions with the class.
- In a lecture hall, students cannot send audio and video by default. During the class, students can "raise their hands" for permission to speak. If the teacher approves, the student can send their audio and video to interact with the class.

### Real-time messaging

The teacher and students can send global text messages in classrooms.

### Interactive whiteboard

The teacher can draw and make notes on the whiteboard. Flexible Classroom supports rich drawing tools, including brushes, text boxes, shapes, mosaics, erasers, paging, laser pointer, and digital pens.

- In a one-to-one classroom, both the teacher and student can draw on the whiteboard by default.
- In a small classroom, by default students do not have permission to draw on the whiteboard, but the teacher can give them permission.
- In a lecture hall, students can only watch the whiteboard.

### Teaching tools

Flexible Classroom supports the following teaching tools to enhance interactivity:

- Cloud storage: Teaching institutions and teachers can upload files to classrooms to help students better understand the class. Supported formats include PDF, PPT, and DOC/DOCX. Flexible Classroom also supports downloading courseware to the local device before the classroom starts and displaying it on the whiteboard to support student preparation.
- Rewards: Teachers can reward students for good performance during the class with virtual credits, such as stars and trophies.
- User list: Display the status of all users in the classroom, such as whether a user is "on stage," whether their camera and microphone are on or off, and any rewards a user might have. Through the user list, the teacher and teaching assistant can ask a student to address the class, grant them permission to draw on the whiteboard, turn off their camera or microphone, give them a virtual reward, and even kick them out of the classroom.

### Screen sharing

Teachers can share their screens, windows, or browser tabs with students in the classroom.

### Recording and replay

Teachers can record the classroom for later review. Flexible Classroom uses [Web Page Recording](./cloud-recording/cloud_recording_webpage_mode?platform=RESTful) to record the audio, video, and whiteboard content in a single file and provides a link for students after the recording finishes.

### Customizing the classroom user interfaces

With UIKit, developers have the freedom to customize the user interfaces in many ways, including changing colors, changing buttons, adjusting layouts, and adding logos. This can be done without needing to understand the business logic of Flexible Classroom.

### Embedding custom plugins in classrooms

With ExtApp, developers can embed their own applications, such as a countdown plugin or a randomizer, into Flexible Classroom. 

### Flexible Classroom cloud service

Agora provides the Flexible Classroom cloud service for classroom and user management of the following:

- Classroom status
- Recording status
- Public resources
- Classroom events
- User role and permissions

### Traceability

Flexible Classroom provides traceability as follows:
- Supports testing the audio and video input and output devices before the class and monitoring network quality during the class to ensure a smooth classroom experience.
- Provides [Agora Analytics](./Agora%20Analytics/aa_guide?platform=All%20Platforms) to monitor quality, user behavior, device state, and Quality of Experience (QoE)/Quality of Service (QoS) statistics.

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

The cloud service of Flexible Classroom is free of charge until December 31, 2021. Agora charges fees for real-time audio and video communication, real-time messaging, cloud recording, and interactive whiteboard use. See the following documents for the pricing of each product:

- [Pricing for Real-time Audio and Video Communication](./Interactive%20Broadcast/billing_rtc)
- [Pricing for Real-time Messaging](./Real-time-Messaging/billing_rtm)
- [Pricing for Cloud Recording](./cloud-recording/billing_cloud_recording?platform=RESTful)
- [Pricing for Interactive Whiteboard](./whiteboard/billing_whiteboard)
