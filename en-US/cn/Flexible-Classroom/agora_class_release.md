## v1.1.0

v2.12.8 was released on March 30, 2021.

### Compatibility changes

**SDK integration method changes**

Android: Starting from v1.1.0, to integrate the Agora Classroom SDK through JitPack, you need to** add the following libraries to the project's build.gradle** file:

```
allprojects {
    repositories {
        ...
        maven { url 'https://maven.aliyun.com/nexus/content/repositories/releases/'}
        maven { url 'https://jitpack.io' }
    }
}
```

iOS: Starting from v1.1.0, the iOS terminal   Flexible Classroom is developed based on Swift language. If the developer develops based on the Object-C language, you need to refer to the following steps to create a Swift file in the project to generate the Swift environment.

1. Open the `ios/ProjectName.xcworkspace` folder in Xcode.
2. Click** File> New> File**, select **iOS**>** Swift File**, and click **Next**> **Create** to` create an empty File.swift file`.

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