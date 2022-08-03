Flexible Classroom is an application platform-as-a-service (aPaaS) solution provided by Agora for online learning use cases: higher education, tutoring, language learning, enterprise training, and many other virtual learning scenarios where a digital-first experience is required.

It encapsulates the complex APIs of the Agora RTC SDK, Agora Chat, Interactive Whiteboard SDK, and the Agora Cloud Recording service into modules. Flexible Classroom empowers developers can quickly build apps for online interactive classrooms in a low-code way, with no need to learn the complex logic of real-time audio and video.

Flexible Classroom covers a variety of teaching scenarios, including one-to-one classrooms, small classrooms, and lecture halls. Users can join a flexible classroom in the role of a teacher, student, or teaching assistant. Flexible Classroom has an abundance of features, including real-time audio and video interaction, real-time messaging, interactive whiteboard, recording, screen sharing, and also classroom and user management. More importantly, Flexible Classroom enables developers to customize their classrooms with tools such as the Agora Edu Context, UIKit, and ExtApp. Developers can also connect Flexible Classroom with their own systems, such as their user management system and class management systems.

![](https://web-cdn.agora.io/docs-files/1658391778659)

## Education solution comparison

Flexible Classroom provides an aPaaS solution to complement the existing Agora PaaS solutions for online interactive classrooms. The following table compares the two solutions:

| <span style="white-space:nowrap;">&emsp;&emsp;&emsp;&emsp;</span> | Flexible Classroom (aPaaS)                                   | PaaS solution                                                |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Solution structure                                           | Flexible Classroom modules.                                  | Integrated implementation of the Agora RTC SDK, Chat SDK, Interactive Whiteboard SDK, and Cloud Recording service. |
| Target customers                                             | Suitable for those with limited development resources, tight schedules, and moderate customization needs. | Suitable for those with experienced development resources, sufficient development time, and substantial customization needs. |
| Implementation cost                                          | Low                                                          | High                                                         |
| Development time                                             | As short as 15 minutes                                       | One to three months                                          |
| Feature implementation                                       | Modular implementation of real-time audio and video communication, real-time messaging, interactive whiteboard, cloud recording, screen sharing, and cloud-based classroom and user management. Integration with developers' own management systems is possible. | Developers must implement real-time audio and video, real-time messaging, interactive whiteboard, and other functions on their own using Agora SDKs and APIs. |
| Extensibility and customization                              | Medium                                                       | High                                                         |
| Data security                                                | Agora does not store customer business data.                 | Agora does not store customer business data.                 |
| User interfaces                                              | Flexible Classroom provides default classroom user interfaces. A customization tool (Agora UIKit) makes a moderate level of UI customization easy to implement. | Developers implement all user interfaces on their own.       |
| Platforms supported                                          | <ul><li>macOS</li><li>Windows</li><li>Web</li><li>Android (students only)</li><li>iOS (students only)</li></ul> | More than 20 platforms and frameworks.                       |
| Scenarios supported                                          | <ul><li>One-to-one Classroom</li><li>Small Classroom</li><li>Lecture Hall</li></ul> | Developers define and implement any online interactive teaching scenarios on their own. |
| Breakout rooms                                               | Included as a core feature to allow a teacher to divide their Flexible Classroom student participants into a number of separate, smaller interactive class sessions. | Sample code available for DIY.                               |

## Classroom types

Flexible Classroom supports the following classroom types:

- One-to-one Classroom: An online teacher gives an exclusive lesson to only one student.
- Small Classroom: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. The size of a Small Classroom is limited to 200.
- Lecture Hall: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. The size of a Lecture Hall is limited to 5,000.

## Classroom demonstration

A flexible classroom mainly includes four areas: navigation bar, whiteboard area, video area, and chat area.

### Desktop

![](https://web-cdn.agora.io/docs-files/1643099628902)

### Mobile

![](https://web-cdn.agora.io/docs-files/1643100338165)

## Classroom roles

Flexible Classroom supports the following roles:

| Role                    | Android                      | iOS                          | Web                          | macOS                        | Windows                      | H5                           |
| :---------------------- | :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- | ---------------------------- |
| Teacher                 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| Student                 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Teaching assistant (TA) | <font color="red">✘</font>   | <font color="red">✘</font>   | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| Audience                | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |

<div class="alert info">The Windows and macOS apps of Flexible Classroom are built with Electron.</div>

## Pricing

According to your actual usage, Agora will charge fees for Real-time Audio and Video Communication, Real-time Messaging, Cloud Recording, and Interactive Whiteboard. See the following documents for the pricing of each product:

- [Pricing for Real-time Audio and Video Communication](/en/Interactive%20Broadcast/billing_rtc?platform=Web)
- [Pricing for Agora Chat](/en/agora-chat/agora_chat_pricing?platform=Web)
- [Pricing for Web Page Recording](/en/cloud-recording/billing_cloud_recording_web?platform=RESTful)
- [Pricing for Interactive Whiteboard](/en/whiteboard/billing_whiteboard?platform=Web)