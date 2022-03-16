This page provides the release notes for Agora Flexible Classroom.

## v1.1.5

v1.1.5 was released on September 15, 2021.

### Compatibility changes

**新版 IM**

v1.1.5 采用新版 IM，改进了课堂内实时聊天体验，支持文字和表情聊天、全体和单个禁言、公告栏和用户列表等功能。 为使用新版 IM 功能，升级至 v1.1.5 前，请注册[环信即时通讯云](https://console.easemob.com/user/register)并在环信开发者管理后台[创建应用](https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用)，然后参考[配置 aPaaS 服务文档](https://docs-preprod.agora.io/cn/agora-class/agora_class_prep?platform=Web&versionId=54263cd0-11ce-11ec-8e65-856920855d60)在 Agora 控制台配置 IM 相关字段。

**部分代码闭源**

自 v1.1.5 起，灵动课堂中的 `agora-edu-core` 和 `agora-rte-sdk` 闭源。 `AgoraEduCore.launch` 实现逻辑移入 `agora-edu-core` 内部，开发者无法再进行改动。 `launchOption` 当前支持的字段详见 [API 文档](/cn/agora-class/agora_class_api_ref_web?platform=Web#launchoption)。

### New features

**Channel Encryption**

v1.1.5 新增媒体流加密功能以确保实时音视频传输过程的安全性。 灵动课堂默认不对媒体流进行加密。 如需启用媒体流加密，你可在调用 `launch` 接口时，通过 `mediaOptions` 里的 `encryptionConfig` 选择加密模式并设置密钥。 All users in the same channel must use the same encryption mode and encryption key.

**Set the Video Profile**

v1.1.5 支持开发者自行设置视频编码参数，包含视频宽高、帧率和码率。 如需修改视频编码参数，可调用 `launch` 接口，通过 `mediaOptions` 里的 `cameraEncoderConfiguration` 和 `screenShareEncoderConfiguration` 分别设置摄像头采集视频流和屏幕共享视频流的编码参数。

**学生轮播**

v1.1.5 在小班课场景中新增学生视频轮播功能。 老师或助教开启此功能后，学生按照指定的时间间隔轮流上台。

**限定区域访问**

v1.1.5 支持限定访问区域，将音视频和消息数据的传输限定在某一区域范围内。 你可在调用 `launch` 接口时设置 `region` 参数来指定区域，可设为 `CN`（中国大陆）、`AP`（亚太地区）、`EU`（欧洲）、`NA`（北美）。

**美颜（仅 Electron）**

v1.1.5 新增基础美颜能力，支持设置美白、磨皮和红润效果。

## v1.1.2.3
v1.1.0 was released on April 30, 2021. 该版本进行了一些内部改进。

## v1.1.2
v1.1.0 was released on April 30, 2021.

### Compatibility changes

灵动课堂桌面端 v1.1.2 对于 Agora Edu Context 进行了以下改动：

- 对 v1.1.0 的 Edu Context 进行重构，废弃了一些重复的 Context API，详见 [Edu Context API 参考](/cn/agora-class/edu_context_api_ref_web_overview)。 对于废弃的 API，Agora 支持向下兼容，但建议尽快使用最新的 API。
- 去除了 v1.1.0 中的 UI Context。 从 v1.1.0 升级至 v1.1.2 时，你需要参考 `packages/agora-classroom-sdk/src/infra/api/index.ts` 和 `packages/agora-classroom-sdk/src/infra/stores/app/ui.ts` 文件，在 `agora-classroom-sdk` 中添加 UI Store 进行 UI 状态管理。

### New features

**倒计时**

v1.1.2 新增倒计时工具。 老师可在工具箱中打开倒计时工具并设置倒计时数值。 老师点击开始倒计时后学生端会出现倒计时面板。

**屏幕共享标注**

v1.1.2 支持老师开始屏幕共享后在共享内容上使用白板基础绘画工具进行标注。

**自定义用户属性和课堂属性**

v1.1.2 支持开发者自定义用户属性和课堂属性，同时支持更新属性和监听属性更新。 例如，开发者可通过自定义用户属性设置用户头像。 具体改动如下：

- 课堂属性：在 `RoomContext` 中新增以下 API：
   - `updateFlexRoomProperties` 方法，用于新增或更新自定义课堂属性。
   - `flexRoomProperties` 字段，用于监听课堂属性的变更。
- 用户属性：`LaunchOption` 中新增 `userFlexProperties` 字段，用于在启动课堂时传入自定义用户属性。

**HTML5 课件**

v1.1.2 支持老师在课堂白板上展示 HTML5 课件。

## v1.1.0

v1.1.0 was released on April 30, 2021.

### Compatibility changes

**SDK integration changes**

自 v1.1.0 起，灵动课堂桌面端新增通过 npm 集成 Agora Classroom SDK。 详见[快速启动灵动课堂](./agora_class_quickstart_web?platform=Web)中集成 SDK 一节。

### New features

**Customizing the UI of classrooms**

As of v1.1.0, Agora isolates the user interface logic from business logic and provides two libraries (UIKit and EduCore), in the Agora Classroom SDK. As the following figure shows, these two libraries connect with each other through Agora Edu Context. 不同 Context 代表灵动课堂中各个功能模块，详见 [Agora Edu Context API 参考](./edu_context_api_ref_web_overview?platform=Web)。

![](https://web-cdn.agora.io/docs-files/1624525178299)

With UIKit, developers customize the user interfaces of classrooms with no need to learn the complex business logic of Flexible Classroom. They can call the methods and callbacks provided by Agora Edu Context in UIKit to customize the user interfaces of each feature. 详见[自定义课堂 UI](./agora_class_custom_ui_web?platform=Web)。

**Embedding custom plugins in classrooms**

自 v1.1.0 起，灵动课堂支持扩展应用 ExtApp，能够帮助开发者根据实际需求在灵动课堂内嵌入自己实现的应用，例如倒计时、骰子等，详见[通过 ExtApp 自定义插件](./agora_class_ext_app_web?platform=Web)。

**Courseware management**

To increase the effectiveness of online learning, v1.1.0 supports uploading and displaying courseware in classrooms. Teachers can upload files in formats such as PPT, DOC, and PDF when using the Flexible Classroom desktop clients. Flexible Classroom clients automatically convert files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in classrooms. 开发者还可通过灵动课堂云服务 RESTful API 配置并上传文件至云盘，并获取课堂内云盘文件变更事件，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Web)。

To use the courseware feature, you must configure the third-party storage in Agora Console for storing the courseware. For details, see Configure the aPaaS [service]() in Agora Console.

v1.1.0 also supports courseware pre-downloading. 在 Agora Classroom SDK 的 `launch` 方法中新增 `courseWareList` 和 `personalCourseWareList` 字段，用于预加载教育机构指派的和老师端上传的课件。 After the successful method call, the Flexible Classroom clients download courseware to the local device before the classroom starts. 详见 [Agora Classroom SDK API 参考](./agora_class_api_ref_web?platform=Web)。

**Page recording**

灵动课堂 v1.1.0 支持[页面录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)，能够将指定 URL 的页面内容和音频混合录制为一个 MP4 音视频文件，实现音视频内容、白板内容、课件内容同步录制。 开发者可通过灵动课堂云服务 RESTful API 配置并发起页面录制，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Web)。

**Inviting students to speak "on stage"**

In the Small Classroom scenario, v1.1.0 adds the feature of inviting students to speak "on stage". Students have two states, "on stage" and "off stage". The teacher can invite a student to speak "on stage" in real-time audio and video interaction with the class and turn on the microphone and camera of the student. The default maximum number of students on stage is 6.

**User list**

To improve classroom management,  v1.1.0 adds the user list in classrooms. The user list displays the status of all users in the classroom, such as whether a user is "on stage", whether their camera and microphone are on or off, and any rewards a user might have. Teachers and teaching assistants can use the user list to invite students to and from the stage, authorize the whiteboard, switch students' cameras and microphones, grant rewards, and kick people.

**Classroom status management**

v1.1.0 adds the following parameters in to `launch` method of the Agora Classroom SDK:

- `startTime`: The starting time of the class in Unix format (ms), subject to the parameter passed in by the first user who joins the classroom.
- `duration`: The` duration` (s) of the class, subject to the parameter passed in by the first user who joins the classroom.

**Classroom rewards**

To promote student motivation, v1.1.0 enables teachers to reward students for good performance during the class with virtual credits. 开发者可通过灵动课堂云服务 RESTful API 获取奖励变更事件，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Web)。

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