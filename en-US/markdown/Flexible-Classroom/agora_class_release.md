

## v2.1.0

v2.1.0 was released on February XX, 2022.

#### Release highlights

In v2.1.0, Agora fully optimizes the internal architecture of Flexible Classroom. Compared to earlier versions, v2.1.0 has the following advantages:

- New features:

  - Answer Selector (Pop-up Quiz), Polling Feature, Countdown Timer, Mobile HTML5 Support, and ability to turn the whiteboard on or off in the classroom.
  - Video Gallery Rotation: Ability for teachers to configure the classroom setting to automatically rotate the on-stage student gallery view without attempting to scroll or page through the class participants.

- Lecture Hall: Expands audience capacity up to 5,000 students, from 1,000 in the last version.

- Web client:

  - Adds support for Safari on desktop and iPad, as well as for Chrome on the iPad.
  - Introduces [EDUClassroomUIStore](/en/agora-class/edu_classroom_ui_store_web_overview?platform=Web) for customizing the classroom UI, which replaces the UIKit in previous versions.

- Android and iOS clients:

  - Redesigns contexts for better abstraction of modular features in Flexible Classroom, where each context can be controlled separately.

  - Refactors context APIs with the following improvements:

    - Renamed APIs and parameters for intuitiveness, understandability, and consistency.
    - Improved flexibility of API calling.
    - More APIs for developers to customize their own features.

    <div class="alert info">For details, see the following docs:<ul><li>Android: <a href="/en/agora-class/agora_class_migration_android?platform=Android">Edu Context API Change List</a> and <a href="/en/agora-class/API%20Reference/edu_context_swift/v2.0.0/API/edu_context_api_overview.html">v2.1.0 Kotlin API reference</a></li><li>iOS: <a href="/en/agora-class/agora_class_migration_ios?platform=iOS&versionId=bc777360-7daa-11ec-bcb4-b56a01c83d2e">Edu Context API Change List</a> and <a href="/en/agora-class/API%20Reference/edu_context_swift/v2.0.0/API/edu_context_api_overview.html">v2.1.0 Swift API reference</a></li></ul></div>
		
#### Flexible Classroom v2.1.0 migration guidance

If you have made changes to your Flexible Classroom UI in earlier versions, in order to migrate to v2.1.0, Agora recommends you create a new project based on v2.1.0 and re-implement the UI changes. Please refer to the following Flexible Classroom v2.1.0 migration guides:

- [Android migration guide](/en/agora-class/agora_class_migration_android?platform=Android)
- [iOS migration guide](/en/agora-class/agora_class_migration_ios?platform=iOS&versionId=bc777360-7daa-11ec-bcb4-b56a01c83d2e)

If you encounter any problem during the migration process, or need to migrate from Flexible Classroom earlier than v1.1.5, please contact [support@agora.io](mailto:support@agora.io) so that Agora technical support team can help.

#### New Features

**Answer selector and polling feature**

To increase engagement and enhance interactivity, v2.1.0 adds the following teaching tools:

- Answer selector: This tool is applicable to scenarios where the teacher asks a single-choice or multiple-choice question and requests the whole class to answer the question together. The teacher can set up the choices and the correct answer, and then trigger answering. The teacher can see the number of students who have submitted an answer and the percentage that are correct in real time.
- Polling: This tool is applicable to scenarios where the teacher wants to get feedback from the whole class. The teacher can set up the subject, choices, and start and end time of the poll. Flexible Classroom also provides live visualization of polling results.

**Ability to turn the whiteboard on or off in the classroom**

As of v2.1.0, Agora supports turning the whiteboard on or off in the classroom. For details, see [Turn the Whiteboard on or off in the Classroom](https://docs-preprod.agora.io/en/null/agora_class_turn_off_whiteboard?platform=Web). When using the APIs for this feature, after the whiteboard is closed, developers can use Flexible Classroom UIKit or UIStore to customize their unique classroom with their desired video gallery to fill the classroom window.

**Video gallery rotation**

Flexible Classroom gives teachers the ability to configure the classroom settings for improved student engagement and video. The Video Gallery Rotation feature lets the teacher automatically rotate the on-stage student gallery view at a desired frequency and sequence, thus eliminating the need for the teacher to scroll or page through the class participants.

**Mobile HTML5 support**

As of v2.1.0, students can join a lecture hall in Flexible Classroom simply by clicking on a shared webpage link within some mobile social applications that use a web view. After joining the classroom on mobile devices, students can do the following things:

- Watch and hear the teacher's lecture, as well as presentations by students "on the stage".
- View the whiteboard and the screen shared by the teacher.
- Send messages to chat with other participants in the classroom.
- Engage in class activities such as polling, answering, and viewing the teacher's count down clock.

<div class="alert info">Please note that the following features are not supported on HTML5:<li>Students raising their hands to apply for speaking on the "stage".</li><li>Students drawing on the whiteboard.</li><li>Students testing or switching their local media devices.</li></div>

#### Improvements

v2.1.0 makes the following improvements:

- Optimizes the business logic and UI of various features in Flexible Classroom, such as students "raising their hands" for permission to speak, the class roster, and in-class reminders.
- Increases the upper limit on the number of users in a lecture hall to 5,000.
- Improves the compatibility of the Web client. The Web client is now supported on Safari for the desktop and iPad, as well as on Chrome for the iPad.
- Supports displaying thumbnails and animations for the PPT files opened in the classroom.
- When a classroom is being recorded, the recording button changes to red.

#### Issues fixed

v2.1.0 fixed the following issues:

- (All platforms) The RTC and whiteboard usage occurred in Flexible Classroom was not showed in Agora Console.
- (Web) Occasional failure to record the whiteboard contents in a small classroom.
- (Web) Occasional failure to send a massage in a small classroom.
- (Web) After the teacher joined a lecture hall, there was a possibility that the whiteboard was not loaded successfully.
- (Web/Windows/macOS) Sometimes in a lecture hall, a student "raised a hand" to apply for making a presentation, an error occurred. And the teacher did not receive the application.
- (Web/Windows/macOS) In a small classroom, a student went onto the "stage" and turned on the video. After the student left the room, the student's video did not disappear immediately.
- (Windows) When a student left and rejoined the room, the student could not see the room announcement published by the teacher.
- (Windows) In a one-to-one classroom, the student's video occasionally went black.
- (iOS) When the teacher displayed a PPT that contained audio and video, the student on iOS sometimes neither heard the audio nor saw the video.
- (Android) In a small classroom, sometimes if a student on Android left and rejoined the room, the student could not see the teacher's video.

## v1.1.0

Flexible Classroom v1.1.0 was released on April 30, 2021.

### Compatibility changes

**SDK integration method changes**

Android: Starting from v1.1.0, to integrate the Agora Classroom SDK through JitPack, you need to** add the following libraries to the project's build.gradle** file:

```
allprojects {
    repositories {
        ...
        maven { url'http://maven.aliyun.com/nexus/content/groups/public' }
        maven { url 'https://jitpack.io' }
    }
}
```

iOS: Starting from v1.1.0, the iOS terminal   Flexible Classroom is developed based on Swift language. If your project uses Object-C, see the following steps to create a Swift file in the project to generate the Swift environment.

1. Open the `ios/ProjectName.xcworkspace` folder in Xcode.
2. Click **File> New> File**, select **iOS**>** Swift File**, and click **Next**> **Create** to create an empty `File.swift` file.

Web/Electron: Starting from v1.1.0, Flexible Classroom Classroom desktop supports the integration of Agora Classroom SDK through npm. See the[ integrated SDK ]()for details.

### New features

**Custom class UI**

Since v1.1.0, the Agora Classroom SDK separates the UI code of the Flexible Classroom classroom from the core business logic, independent of the UI Kit and Edu Core, and provides developers with the ability to implement smart classroom business functions through Edu Context. Different Contexts represent various functional modules in the  Flexible Classroom. For details, please refer to the[ Agora Edu Context API Reference]().

![](https://web-cdn.agora.io/docs-files/1619696813295)

Developers do not need to deeply study the core business logic of Smart Class, just modify UI components based on UI Kit, call the methods and callbacks provided by the corresponding Context, and then customize the UI of each functional module of Smart Class, making the online interactive classroom more personalized . See the[ custom classroom UI ]()for details.

**ExtApp**

Starting from v1.1.0,  Flexible Classroom supports the extended application ExtApp, which can help developers embed their own applications in  Flexible Classroom according to actual needs, such as countdown, dice, etc. For details, see [Custom Extended Applications]().

**Courseware management**

In order to improve the effect of classroom learning, a new courseware module was added to Smart Classroom v1.1.0. Teachers can upload files in PPT, DOC, PDF and other formats through the Smart Class Client. Flexible Classroom clients automatically convert files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in the classroom. Developers can also configure and upload files to the cloud disk through the smart Flexible Classroom cloud service RESTful API, and obtain the cloud disk file change events in the classroom. For details, see the[ server API reference]().

In v1.1.0, files uploaded to cloud disks are stored in Agora Alibaba Cloud OSS account by default. If developers want to store files in their OSS accounts, they need to update the whiteboard JSON configuration object in the aPaaS configuration of the  Agora Console. For details, see the section Configuring  Flexible Classroom in the  Agora Console in the Prerequisites for  Flexible Classroom.

In addition, v1.1.0 also supports pre-loading of courseware.

- Android/iOS: Agora Classroom SDK adds `configCoursewares` and `downloadCoursewares` methods to configure and preload courseware. After the successful call, the client will cache the courseware in the cloud disk to the local. For details, see Agora Classroom SDK API Reference.
- Web/Electron: Added the `courseWareList` and `personalCourseWareList `fields to `the launch` method of the Agora Classroom SDK to preload the courseware assigned by the educational institution and uploaded by the teacher. After the successful call, the client will cache the courseware in the cloud disk to the local. For details, see Agora Classroom SDK API Reference.

**Page recording**

 Flexible Classroom v1.1.0 supports [page recording](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful), which can mix and record the page content and audio of the specified URL as an MP4 audio and video file, and realize the simultaneous recording of audio and video content, whiteboard content, and courseware content. Developers can configure and initiate page recording through the Smart Flexible Classroom Cloud Service RESTful API. For details, see the[ server-side API reference]().

**Roll call**

For online interactive small classes, v1.1.0 adds two new states, "On the stage" and "Under the stage", which supports the function of teachers calling students to the stage. Teachers can call students on the stage to speak in the classroom, and turn on the students' audio and video capture equipment. The default maximum number of people on stage is 6.

**User list**

In order to strengthen classroom management,  Flexible Classroom v1.1.0 added a new staff list function, displaying the names of all students in the classroom, the status of the on-off stage, the status of the camera and microphone switches, and the number of rewards. Teachers and teaching assistants can use the user list to invite students to and from the stage, authorize the whiteboard, switch students' cameras and microphones, grant rewards, and kick people.

**Classroom status management**

Flexible Classroom Classroom v1.1.0 adds` the following parameters to the launch `method of the Agora Classroom SDK on the client side:

- `startTime`: Set the class start time (in milliseconds), subject to the parameters passed in by the first user to enter the class.
- `Duration`: Set the duration of the class (in seconds), subject to the parameters passed in by the first user to enter the class.

**Class rewards**

In order to enhance classroom interaction,  Flexible Classroom v1.1.0 adds a new classroom reward function, where teachers can reward students after they answer the questions. Developers can obtain reward change events through the  Flexible Classroom Cloud Service RESTful API. For details, please refer to the[ server-side API reference]().

### Improvements

**UI upgrades in three major scenarios**

In order to meet the needs of more online education, v1.1.0 has optimized the UI and page interactions in the three scenarios of   One-to-one Classroom, online interactive small class, and      Lecture Hall. The video area, whiteboard area, and real-time chat area have been optimized. Windowed.

**whiteboard optimization**

v1.1.0 optimizes the writing experience of the whiteboard in the classroom.