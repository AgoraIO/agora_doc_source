This page provides the release notes for Agora Flexible Classroom.

## v1.1.0

v1.1.0 was released on April 30, 2021.

### Compatibility changes

**SDK integration changes**

As of v1.1.0, Flexible Classroom is developed based on Swift. If your project uses Object-C, see the following steps to create a Swift file in the project to generate the Swift environment.

1. Open `ios/ProjectName.xcworkspace` in Xcode.
2. Click **File > New > File**, select **iOS > Swift File**, and click **Next > Create** to create an empty `File.swift` file.

### New features

**Customizing the UI of classrooms**

As of v1.1.0, Agora isolates the user interface logic from business logic and provides two libraries (UIKit and EduCore), in the Agora Classroom SDK. As the following figure shows, these two libraries connect with each other through Agora Edu Context. Different contexts represent different modular features in Flexible Classroom. For details, see [Agora Edu Context API Reference](./edu_context_api_ref_ios_overview?platform=iOS).

![](https://web-cdn.agora.io/docs-files/1619696813295)

With UIKit, developers customize the user interfaces of classrooms with no need to learn the complex business logic of Flexible Classroom. They can call the methods and callbacks provided by Agora Edu Context in UIKit to customize the user interfaces of each feature. For details, see [Customize the UI of Flexible Classroom with UIKit](./agora_class_custom_ui_ios?platform=iOS).

**Embedding custom plugins in classrooms**

As of v1.1.0, Flexible Classroom provides the ExtApp tool for developers to embed their own applications, such as a countdown plugin or a randomizer, into Flexible Classroom. For details, see [Embed a custom plugin in Flexible Classroom with ExtApp](./agora_class_ext_app_ios?platform=iOS).

**Courseware management**

To increase the effectiveness of online learning, v1.1.0 supports uploading and displaying courseware in classrooms. Teachers can upload files in formats such as PPT, DOC, and PDF when using the Flexible Classroom desktop clients. Flexible Classroom clients automatically convert files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in classrooms. Developers can upload and configure courseware and get the courseware-related events by calling the Flexible Classroom Cloud Service RESTful APIs. For details, see the [RESTful API Reference](./agora_class_restful_api?platform=iOS).

To use the courseware feature, you must configure the third-party storage in Agora Console for storing the courseware. For details, see [Configure the aPaaS service](./agora_class_prep?platform=iOS) in Agora Console.

v1.1.0 also supports courseware pre-downloading. v1.1.0 adds the `configCoursewares` and `downloadCoursewares` methods in the Agora Classroom SDK for configuring courseware downloading. After the successful method call, the Flexible Classroom clients download courseware to the local device before the classroom starts. For details, see [Agora Classroom SDK API Reference](./agora_class_api_ref_ios?platform=iOS).

**Web page recording**

v1.1.0 supports [web page recording](./cloud-recording/cloud_recording_webpage_mode?platform=RESTful), which can record the content and audio of the specified URL in a single MP4 file. With web page recording, you can record the content of the slides and the whiteboard together with the audio and video of the teacher and the students in an online class. Developers can configure and start web page recording by calling the Flexible Classroom Cloud Service RESTful API. For details, see the [RESTful API reference](./agora_class_restful_api?platform=iOS).

**Inviting students to speak "on stage"**

In the Small Classroom scenario, v1.1.0 adds the feature of inviting students to speak "on stage". Students have two states, "on stage" and "off stage". The teacher can invite a student to speak "on stage" in real-time audio and video interaction with the class and turn on the microphone and camera of the student. The default maximum number of students on stage is 6.

**User list**

To improve classroom management,  v1.1.0 adds the user list in classrooms. The user list displays the status of all users in the classroom, such as whether a user is "on stage", whether their camera and microphone are on or off, and any rewards a user might have. Teachers and teaching assistants can use the user list to invite students to and from the stage, authorize the whiteboard, switch students' cameras and microphones, grant rewards, and kick people.

**Classroom status management**

v1.1.0 adds the following parameters in to `launch` method of the Agora Classroom SDK:

- `startTime`: The start time (ms) of the class, determined by the first user joining the classroom.
- `duration`: The duration (second) of the class, determined by the first user joining the classroom.

**Classroom rewards**

To promote student motivation, v1.1.0 enables teachers to reward students for good performance during the class with virtual credits. Developers can get the reward-related event by calling the Flexible Classroom Cloud Service RESTful API. For details, see the [RESTful API reference](./agora_class_restful_api?platform=iOS).

### Improvements

**UI upgrades**

To better meet the requirements of online tutoring, v1.1.0 optimizes the user interfaces and user experiences of the three teaching scenarios and divides the classroom UI in Flexible Classroom into four areas: a navigation bar, a whiteboard space, the real-time audio/video window, and the real-time text chat window.

**Whiteboard optimization**

v1.1.0 optimizes the writing experience on the whiteboard in classrooms.

## v1.0.0

v1.1.0 was released on January 20, 2021. This is the first release of Agora Flexible Classroom, which supports the following teaching scenarios:

- One-to-one Classroom: An online teacher gives an exclusive lesson to only one student.
- Small Classroom: A teacher gives an online lesson to multiple students. The maximum number of users in a classroom is 16.
- Lecture Hall: A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" for permission to speak. If the teacher approves, a student can send their audio and video to interact with the class.

This release includes the following features:

- Real-time audio and video interaction
- Real-time messaging
- Interactive whiteboard
- Uploading and displaying courseware
- Classroom management
- Screen sharing
- Recording and replay