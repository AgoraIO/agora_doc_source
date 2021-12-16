本页提供灵动课堂的发版说明。

## v1.1.5

该版本于 2021 年 9 月 15 日发布。

### 升级必看

**新版 IM**

v1.1.5 采用新版 IM，改进了课堂内实时聊天体验，支持文字和表情聊天、全体和单个禁言、公告栏和用户列表等功能。为使用新版 IM 功能，升级至 v1.1.5 前，请注册[环信即时通讯云](https://console.easemob.com/user/register)并在环信开发者管理后台[创建应用](https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用)，然后参考[配置 aPaaS 服务文档](https://docs-preprod.agora.io/cn/agora-class/agora_class_prep?platform=Web&versionId=54263cd0-11ce-11ec-8e65-856920855d60)在 Agora 控制台配置 IM 相关字段。

### 新增特性

**媒体流加密**

v1.1.5 新增媒体流加密功能以确保实时音视频传输过程的安全性。灵动课堂默认不对媒体流进行加密。如需启用媒体流加密，你可在调用 `launch` 接口时，通过 `mediaOptions` 里的 `encryptionConfig` 选择加密模式并设置密钥。同一教室内所有老师和学生必须使用相同的加密模式和密钥。

**设置视频编码参数**

v1.1.5 支持开发者自行设置视频编码参数，包含视频宽高、帧率和码率。如需修改视频编码参数，你可在调用 `launch` 接口时通过 `videoEncoderConfig` 参数进行设置。

**学生轮播**

v1.1.5 在小班课场景中新增学生视频轮播功能。老师或助教开启此功能后，学生按照指定的时间间隔轮流上台。

**限定区域访问**

v1.1.5 支持限定访问区域，将音视频和消息数据的传输限定在某一区域范围内。你可在调用 `launch` 接口时设置 `region` 参数来指定区域，可设为 `CN`（中国大陆）、`AP`（亚太地区）、`EU`（欧洲）、`NA`（北美）。

**设置观众端延时级别**

v1.1.5 支持开发者自行设置观众端延时级别。默认情况，观众端延时级别为超低延时。你可在调用 `launch` 接口时通过 `latencyLevel` 参数切换观众端延时级别：

- 超低延时：发流端与观众端的延时为 400 ms - 800 ms。
- 低延时：发流端与观众端的延时为 1500 ms - 2000 ms。

声网针对不同级别的延时收取不同的音视频费用。

**控制学生上台后是否自动发流**

v1.1.5 支持开发者自行控制学生上台后是否自动发送发送音频或视频流。默认情况下，学生上台后不发送音视频流。你可在调用 `launch` 接口时通过 `streamState` 参数更改默认行为。

**课前设备检测和视频预览**

v1.1.5 新增课件设备检测和视频预览能力，开发者可通过新增的 [Media Context API](/cn/agora-class/edu_context_api_ref_android_media?platform=Android)，自行开发课前检测模块，方便学生在上课前确认本地摄像头、麦克风设备是否工作以及预览本地视频画面。

### 改进

**PPT 展示优化**

为优化学生端的 PPT 展示，v1.1.5 在 `AgoraEduLaunchConfig` 中新增 `boardFitMode` 用于设置 PPT 显示模式。默认情况下，白板内容显示模式为 fit，等比缩放 PPT 以保证内容的完整显示。你可在调用 `launch` 接口时将 `boardFitMode` 更换为 `Retain`，PPT 尺寸会以本地记录的上一次学生手动调整的大小为准。

## v1.1.2.3
灵动课堂 v1.1.2.3 于 2021 年 7 月 27 日发布。该版本进行了一些内部改进。

## v1.1.2

灵动课堂 v1.1.2 于 2021 年 6 月 17 日发布。

### 新增特性

**倒计时**

v1.1.2 新增倒计时工具。老师可在工具箱中打开倒计时工具并设置倒计时数值。老师点击开始倒计时后学生端会出现倒计时面板。

**媒体设备管理**

v1.1.2 支持学生在课堂内开启和关闭本地摄像头、麦克风和扬声器以及切换前置和后置摄像头。Agora Edu Context 中新增 `DeviceContext` 和 `IDeviceHandler` 类，提供本地设备相关方法和回调。

**屏幕共享标注**

v1.1.2 支持老师开始屏幕共享后在共享内容上使用白板基础绘画工具进行标注。

**自定义用户属性和课堂属性**

v1.1.2 支持开发者自定义用户属性和课堂属性，同时支持更新属性和监听属性更新。例如，开发者可通过自定义用户属性设置用户头像。具体改动如下：

- 课堂属性：
  - `RoomContext` 中新增 `updateFlexRoomProps` 方法，用于新增或更新自定义课堂属性。
  - `IRoomHandler` 中新增 `onFlexRoomPropsInitialized` 和 `onFlexRoomPropertiesChanged` 回调，用于监听初始课堂自定义属性和课堂属性的变更。
- 用户属性：
  - `AgoraEduLaunchConfig` 中新增 `userProperties` 字段，用于在启动课堂时传入自定义用户属性。
  - `UserContext` 中新增 `updateFlexUserProperties` 方法，用于新增或更新自定义用户属性。
  - `IEduUserHandler` 中新增 `onFlexUserPropertiesChanged` 回调，用于监听课堂属性的变更。

**HTML5 课件**

v1.1.2 支持老师在课堂白板上展示 HTML5 课件。

## v1.1.0

灵动课堂 v1.1.0 于 2021 年 4 月 30 日发布。

### 升级必看

**SDK 集成方式变更**

自 v1.1.0 起，通过 JitPack 集成 Agora Classroom SDK，需要在项目的 **build.gradle** 文件中添加以下库：

```
allprojects {
    repositories {
        ...
        maven { url'http://maven.aliyun.com/nexus/content/groups/public' }
        maven { url 'https://jitpack.io' }
    }
}
```

### 新增特性

**自定义课堂 UI**

自 v1.1.0 起，Agora Classroom SDK 将灵动课堂的 UI 代码和核心业务逻辑隔离开来，独立成 UI Kit 和 Edu Core，并通过 Edu Context 为开发者提供实现灵动课堂业务功能的能力。不同 Context 代表灵动课堂中各个功能模块，详见 [Agora Edu Context API 参考](./edu_context_api_ref_android_overview?platform=Android)。

![](https://web-cdn.agora.io/docs-files/1619696813295)

开发者无需深入学习灵动课堂的核心业务逻辑，只需基于 UI Kit 修改 UI 组件，调用相应 Context 提供的方法和回调，即可自定义灵动课堂各个功能模块的 UI，使在线互动课堂更为个性化。详见[自定义课堂 UI](./agora_class_custom_ui_android?platform=Android)。

**扩展应用 ExtApp**

自 v1.1.0 起，灵动课堂支持扩展应用 ExtApp，能够帮助开发者根据实际需求在灵动课堂内嵌入自己实现的应用，例如倒计时、骰子等，详见[通过 ExtApp 自定义插件](./agora_class_ext_app_android?platform=Android)。

**课件管理**

为提升课堂学习效果，灵动课堂 v1.1.0 新增课件模块。老师可通过灵动课堂客户端上传 PPT、DOC、PDF 等格式的文件。灵动课堂客户端会对后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以用于课堂内白板展示。开发者还可通过灵动课堂云服务 RESTful API 配置并上传文件至云盘，并获取课堂内云盘文件变更事件，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Android)。

v1.1.0 中，上传至云盘的文件默认储存在 Agora 的阿里云 OSS 账号中。如开发者想要将文件存储至自己的 OSS 账号中，需要更新 Agora 控制台 aPaaS 配置中的白板 JSON 配置对象，详见[灵动课堂前提条件](./agora_class_prep?platform=Android)中在 Agora 控制台配置灵动课堂一节。

此外，v1.1.0 还支持课件预加载。Agora Classroom SDK 新增 `configCoursewares` 和 `downloadCoursewares` 方法，用于配置并预加载课件。成功调用后，客户端会将云盘中的课件缓存至本地。详见 [Agora Classroom SDK API 参考](./agora_class_api_ref_android?platform=Android)。

**页面录制**

灵动课堂 v1.1.0 支持[页面录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)，能够将指定 URL 的页面内容和音频混合录制为一个 MP4 音视频文件，实现音视频内容、白板内容、课件内容同步录制。开发者可通过灵动课堂云服务 RESTful API 配置并发起页面录制，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Android)。

**点名上台**

对于在线互动小班课，v1.1.0 新增“讲台上”和“讲台下”两种状态，支持老师点名学生上讲台功能。老师可在课堂内点名学生“上讲台”发言，打开学生的音视频采集设备。默认上台人数上限为 6 人。

**用户列表**

为加强课堂管理，灵动课堂 v1.1.0 新增人员列表功能，展示课堂中所有学生的名称、上下台状态、摄像头和麦克风开关状态、奖励个数等信息。老师和助教可通过用户列表进行邀请学生上下台、白板授权、开关学生的摄像头和麦克风、授予奖励、踢人等操作。

**课堂状态管理**

灵动课堂 v1.1.0 在客户端 Agora Classroom SDK 的 `launch` 方法中新增以下参数：

- `startTime`: 设置课堂开始时间（毫秒），以第一个进入课堂的用户传入的参数为准。
- `duration`: 设置课堂持续时间（秒），以第一个进入课堂的用户传入的参数为准。

**课堂奖励**

为增强课堂互动，灵动课堂 v1.1.0 新增课堂奖励功能，老师可在学生答题后给予学生奖励。开发者可通过灵动课堂云服务 RESTful API 获取奖励变更事件，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Android)。

### 改进

**三大场景 UI 升级**

为满足更多在线教育需求，v1.1.0 中 1 对 1 互动教学、在线互动小班课、互动直播大班课三大场景的 UI 和页面交互进行了整体优化，将视频区域、白板区域、实时聊天区域窗口化。

**白板优化**

v1.1.0 优化了课堂内白板的书写体验。

## v1.0.0

v1.0.0 于 2021 年 1 月 20 日发布。这是灵动课堂的首个版本，支持以下三种教学场景：

- 1 对 1 互动教学：1 位老师对 1 名学生进行专属在线辅导教学，老师和学生进行实时音视频互动。
- 1 对 N 在线小班课：1 位教师对 N 名学生（2 ≤ N ≤ 16）进行在线辅导教学，老师和学生进行实时音视频互动。
- 互动直播大班课：1 位老师进行在线教学，多名学生实时观看和收听，学生人数无上限。上课过程中，学生可以“举手”请求发言，与老师进行实时音视频互动。

该版本主要包含以下功能：

- 实时音视频互动
- 实时消息互动
- 互动白板
- 课件上传
- 教室管理
- 屏幕共享
- 录制回放