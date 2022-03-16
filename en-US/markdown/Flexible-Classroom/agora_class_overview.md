Flexible Classroom is an aPaaS solution provided by Agora for online interactive tutoring. It encapsulates the complex APIs of the Agora RTC SDK, Agora RTM SDK, Interactive Whiteboard SDK, and the Agora Cloud Recording service into modules. Flexible Classroom empowers developers can quickly build apps for online interactive classrooms in a low-code way, with no need to learn the complex logic of real-time audio and video.

Flexible Classroom covers a variety of teaching scenarios, including one-to-one classrooms, small classrooms, and lecture halls. Users can join a flexible classroom in the role of a teacher, student, or teaching assistant. Flexible Classroom has an abundance of features, including real-time audio and video interaction, real-time messaging, interactive whiteboard, recording, screen sharing, and also classroom and user management. More importantly, Flexible Classroom enables developers to customize their classrooms with tools such as the Agora Edu Context, UIKit, and ExtApp. Developers can also connect Flexible Classroom with their own systems, such as their user management system and class management systems.

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
| Platforms supported  |<ul><li>macOS</li><li>Windows</li><li>Web</li><li>Android (students only)</li><li>iOS (students only)</li></ul> | More than 20 platforms and frameworks. |
| Scenarios supported |<ul><li>One-to-one Classroom</li><li>Small Classroom</li><li>Lecture Hall</li></ul> | Developers define and implement any online interactive teaching scenarios on their own. |

## Scenarios

Flexible Classroom supports the following teaching scenarios:

- One-to-one Classroom: An online teacher gives an exclusive lesson to only one student.
- Small Classroom: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. The size of a Small Classroom is limited to 200.
- Lecture Hall: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. The size of a Lecture Hall is limited to 5000.

## Classroom demonstration

A flexible classroom mainly includes four areas: navigation bar, whiteboard area, video area, and chat area.

### Desktop

![](https://web-cdn.agora.io/docs-files/1643099628902)

### Mobile

![](https://web-cdn.agora.io/docs-files/1643100338165)

## Features

Flexible Classroom supports the following features:

### Real-time audio and video interaction

- In a one-to-one classroom, both the teacher and student can send and receive audio and video streams by default.
- In a small classroom, students do not send audio and video by default. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher.
- In a lecture hall, students do not send audio and video by default. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher.

### Real-time messaging

The teacher and students can send text messages to each other.

### Interactive whiteboard

The teacher can draw and make notes on the whiteboard. Flexible Classroom supports rich drawing tools, including brushes, text boxes, shapes, erasers, paging, and laser pointer.

### Teaching tools

Flexible Classroom supports the following teaching tools to enhance interactivity:

- Cloud storage: Teaching institutions and teachers can upload files to classrooms to help students better understand the class. Supported formats include PPT, PPTX, DOC, DOCX, PDF, MP3, MP4, PNG, JPG, and GIF. Flexible Classroom also supports pre-downloading a file to the local before the classroom starts and displaying it on the whiteboard, which enhances the teaching experience.
- Rewards: Teachers can reward students with virtual credits, such as stars and trophies, for good performance during the class.
- User list: Display the status of all users in the classroom, such as whether the user is "on stage", whether the camera and microphone are on or off, the number of rewards. With the user list, the teacher and teaching assistant can ask students to speak up "on stage, grant the permission of drawing on the whiteboard to students, switch on and off the camera and microphone of students, give rewards, and kick a user out of the classroom.
- Answer selector: This tool is applicable to scenarios where the teacher asks a single-choice or multiple-choice question and requests the whole class to answer the question together. The teacher can set up the choices and the correct answer, and then trigger answering. The teacher can see the number of students who have submitted an answer and the percentage that are correct in real time.
- Polling: This tool is applicable to scenarios where the teacher wants to get feedback from the whole class. The teacher can set up the subject, choices, and start and end time of the poll. Flexible Classroom also provides live visualization of polling results.

### Screen sharing

Teachers can share their screens, windows, or browser tabs with students in class.

### Recording and replay

Teachers can start recording in the classroom. Flexible Classroom uses [Web Page Recording](/en/cloud-recording/cloud_recording_webpage_mode?platform=RESTful) to record the audio, video, and whiteboard content in a single file and provides a link for students after the recording finishes.

### Customizing the classroom UI

With UIKit, developers have the freedom to customize the user interfaces, such as changing colors, changing buttons, adjusting layouts, adding logos, even if they do not understand the business logic of the flexible classroom.

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
- Provides [Agora Analytics](/en/Agora%20Analytics/aa_guide?platform=All%20Platforms) to monitor quality, user behavior, device state, and Quality of Experience (QoE)/Quality of Service (QoS) statistics.

## Supported roles

| Classroom roles | Android<sup>1</sup> | iOS<sup>2</sup> | Web<sup>3</sup> | macOS<sup>4</sup> | Windows<sup>5</sup> |
| :------- | :------- | :--- | :--- | :----- | :------- |
| Teachers | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Students | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Teaching assistants | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |

<div class="alert info">The Windows and macOS apps of Flexible Classroom are built with Electron.</div>

## Compatibility

### Supported operation system versions

- Android 6.0 or later
- iOS 10 or later
- macOS 10.13 or later
- Windows 7 or later

### Supported browsers

To ensure best end-user experience, Agora highly recommends using Flexible Classroom on the latest version of Desktop Chrome. For detailed browser support, see the following list:

- Windows: Chrome 89 or later
- macOS:
  - Safari 13 or later
  - Chrome 89 or later
- Apple iPad: Safari and Chrome on Apple iPad 10.0 or later

## Pricing

According to your actual usage, Agora will charge fees for Real-time Audio and Video Communication, Real-time Messaging, Cloud Recording, and Interactive Whiteboard. See the following documents for the pricing of each product:

- [Pricing for Real-time Audio and Video Communication](/en/Interactive%20Broadcast/billing_rtc?platform=Android)
- [Pricing for Real-time Messaging](/en/Real-time-Messaging/billing_rtm?platform=All%20Platforms)
- [Pricing for Web Page Recording](/en/cloud-recording/billing_cloud_recording_web?platform=RESTful)
- [Pricing for Interactive Whiteboard](/en/whiteboard/billing_whiteboard?platform=Web)