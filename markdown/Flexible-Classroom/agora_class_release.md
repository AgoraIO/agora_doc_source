## v1.1.0

灵动课堂 v1.1.0 于 2021 年 4 月 30 日发布。

### 升级必看

**SDK 集成方式变更**

Android: 自 v1.1.0 起，通过 JitPack 集成 Agora Classroom SDK，需要在项目的 **build.gradle** 文件中添加以下库：

```
allprojects {
    repositories {
        ...
        maven { url'http://maven.aliyun.com/nexus/content/groups/public' }
        maven { url 'https://jitpack.io' }
    }
}
```

iOS：自 v1.1.0 起，灵动课堂 iOS 端基于 Swift 语言进行开发。如果开发者基于 Object-C 语言开发，需要参考以下步骤在项目中创建一个 Swift 文件，生成 Swift 环境。

1. 在 Xcode 中打开 `ios/ProjectName.xcworkspace` 文件夹。
2. 点击 **File > New > File**， 选择 **iOS** > **Swift File**，点击 **Next** > **Create**，新建一个空的 `File.swift` 文件。

Web/Electron：自 v1.1.0 起，灵动课堂桌面端支持通过 npm 集成 Agora Classroom SDK。详见[集成 SDK]()。

### 新增特性

**自定义课堂 UI**

自 v1.1.0 起，Agora Classroom SDK 将灵动课堂的 UI 代码和核心业务逻辑隔离开来，独立成 UI Kit 和 Edu Core，并通过 Edu Context 为开发者提供实现灵动课堂业务功能的能力。不同 Context 代表灵动课堂中各个功能模块，详见 [Agora Edu Context API 参考]()。

![](https://web-cdn.agora.io/docs-files/1619696813295)

开发者无需深入学习灵动课堂的核心业务逻辑，只需基于 UI Kit 修改 UI 组件，调用相应 Context 提供的方法和回调，即可自定义灵动课堂各个功能模块的 UI，使在线互动课堂更为个性化。详见[自定义课堂 UI]()。

**扩展应用 ExtApp**

自 v1.1.0 起，灵动课堂支持扩展应用 ExtApp，能够帮助开发者根据实际需求在灵动课堂内嵌入自己实现的应用，例如倒计时、骰子等，详见[自定义扩展应用]()。

**课件管理**

为提升课堂学习效果，灵动课堂 v1.1.0 新增课件模块。老师可通过灵动课堂客户端上传 PPT、DOC、PDF 等格式的文件。灵动课堂客户端会对后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以用于课堂内白板展示。开发者还可通过灵动课堂云服务 RESTful API 配置并上传文件至云盘，并获取课堂内云盘文件变更事件，详见[服务端 API 参考]()。

v1.1.0 中，上传至云盘的文件默认储存在 Agora 的阿里云 OSS 账号中。如开发者想要将文件存储至自己的 OSS 账号中，需要更新 Agora 控制台 aPaaS 配置中的白板 JSON 配置对象，详见灵动课堂前提条件中在 Agora 控制台配置灵动课堂一节。

此外，v1.1.0 还支持课件预加载。

- Android/iOS: Agora Classroom SDK 新增 `configCoursewares` 和 `downloadCoursewares` 方法，用于配置并预加载课件。成功调用后，客户端会将云盘中的课件缓存至本地。详见 Agora Classroom SDK API 参考。
- Web/Electron: 在 Agora Classroom SDK 的 `launch` 方法中新增 `courseWareList` 和 `personalCourseWareList` 字段，用于预加载教育机构指派的和老师端上传的课件。成功调用后，客户端会将云盘中的课件缓存至本地。详见 Agora Classroom SDK API 参考。

**页面录制**

灵动课堂 v1.1.0 支持[页面录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)，能够将指定 URL 的页面内容和音频混合录制为一个 MP4 音视频文件，实现音视频内容、白板内容、课件内容同步录制。开发者可通过灵动课堂云服务 RESTful API 配置并发起页面录制，详见[服务端 API 参考]()。

**点名上台**

对于在线互动小班课，v1.1.0 新增“讲台上”和“讲台下”两种状态，支持老师点名学生上讲台功能。老师可在课堂内点名学生“上讲台”发言，打开学生的音视频采集设备。默认上台人数上限为 6 人。

**用户列表**

为加强课堂管理，灵动课堂 v1.1.0 新增人员列表功能，展示课堂中所有学生的名称、上下台状态、摄像头和麦克风开关状态、奖励个数等信息。老师和助教可通过用户列表进行邀请学生上下台、白板授权、开关学生的摄像头和麦克风、授予奖励、踢人等操作。

**课堂状态管理**

灵动课堂 v1.1.0 在客户端 Agora Classroom SDK 的 `launch` 方法中新增以下参数：

- `startTime`: 设置课堂开始时间（毫秒），以第一个进入课堂的用户传入的参数为准。
- `duration`: 设置课堂持续时间（秒），以第一个进入课堂的用户传入的参数为准。

**课堂奖励**

为增强课堂互动，灵动课堂 v1.1.0 新增课堂奖励功能，老师可在学生答题后给予学生奖励。开发者可通过灵动课堂云服务 RESTful API 获取奖励变更事件，详见[服务端 API 参考]()。

### 改进

**三大场景 UI 升级**

为满足更多在线教育需求，v1.1.0 中 1 对 1 互动教学、在线互动小班课、互动直播大班课三大场景的 UI 和页面交互进行了整体优化，将视频区域、白板区域、实时聊天区域窗口化。

**白板优化**

v1.1.0 优化了课堂内白板的书写体验。