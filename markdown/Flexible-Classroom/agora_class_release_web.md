本页提供灵动课堂的发版说明。

## 2.0.x 版

灵动课堂 2.0.x 版于 2021 年 12 月 29 日发布。

### 升级必看

为提高稳定性和扩展性、降低开发成本，灵动课堂 2.0.x 版进行了大重构。自 2.0.x 版起，灵动课堂桌面端使用 UI Store 和 Container 组件来实现业务功能。具体请查看 [EduClassroomUIStore 介绍](/cn/agora-class/edu_classroom_ui_store_web_overview?platform=Web)。

### 新增特性

**答题器和投票器**

为加强课堂互动性，2.0.x 版在课堂工具栏中新增以下工具：

-   答题器：适用于课堂中老师提问、全班学生一起答题的场景。老师端可在答题器中添加或减少选项数量并设置正确选项，然后发起答题。学生端收到题目选项后可进行选择。答题结束后，可统计并展示提交人数和正确率。
-   投票器：适用于课堂中老师向全班学生征集意见的场景。老师端可在投票器中设置投票主题、选项以及投票的起始和截止时间，然后发起投票。投票结束后，可统计并展示投票结果。

**H5 实时课堂**

针对互动直播大班课场景，自 2.0.x 起，灵动课堂支持学生在移动端的一些社交 app 内（如微信）通过分享的课程网页链接直接进入教室听课。H5 端支持以下功能：

-   观看和收听老师的授课以及上讲台学生的音视频。
-   观看屏幕共享和白板内容。
-   发送实时消息参与课堂讨论。
-   参与投票、答题、倒计时等互动行为。

### 改进

2.0.x 版进行了以下改进：

-   优化了学生举手申请上讲台、花名册、课堂提示信息等各个功能模块的业务流程和 UI 样式。
-   互动直播大班课场景中的课堂人数上限提升至 3000 人。
-   Web 端兼容性改进：新增对桌面端和 iPad 端 Safari 浏览器、iPad 端 Chrome 浏览器的支持。

## 1.1.5 版

该版本于 2021 年 9 月 15 日发布。

### 升级必看

**新版 IM**

1.1.5 采用新版 IM，改进了课堂内实时聊天体验，支持文字和表情聊天、全体和单个禁言、公告栏和用户列表等功能。为使用新版 IM 功能，升级至 1.1.5 前，请注册[环信即时通讯云](https://console.easemob.com/user/register)并在环信开发者管理后台[创建应用](https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用)，然后参考[配置 aPaaS 服务文档](/cn/agora-class/agora_class_prep?platform=Web)在 Agora 控制台配置 IM 相关字段。

**部分代码闭源**

自 1.1.5 起，灵动课堂中的 `agora-edu-core` 和 `agora-rte-sdk` 闭源。`AgoraEduCore.launch` 实现逻辑移入 `agora-edu-core` 内部，开发者无法再进行改动。`launchOption` 当前支持的字段详见 [API 文档](/cn/agora-class/agora_class_api_ref_web?platform=Web#launchoption)。

### 新增特性

**媒体流加密**

1.1.5 新增媒体流加密功能以确保实时音视频传输过程的安全性。灵动课堂默认不对媒体流进行加密。如需启用媒体流加密，你可在调用 `launch` 接口时，通过 `mediaOptions` 里的 `encryptionConfig` 选择加密模式并设置密钥。同一教室内所有老师和学生必须使用相同的加密模式和密钥。

**设置视频编码参数**

1.1.5 支持开发者自行设置视频编码参数，包含视频宽高、帧率和码率。如需修改视频编码参数，可调用 `launch` 接口，通过 `mediaOptions` 里的 `cameraEncoderConfiguration` 和 `screenShareEncoderConfiguration` 分别设置摄像头采集视频流和屏幕共享视频流的编码参数。

**学生轮播**

1.1.5 在小班课场景中新增学生视频轮播功能。老师或助教开启此功能后，学生按照指定的时间间隔轮流上台。

**限定区域访问**

1.1.5 支持限定访问区域，将音视频和消息数据的传输限定在某一区域范围内。你可在调用 `launch` 接口时设置 `region` 参数来指定区域，可设为 `CN`（中国大陆）、`AP`（亚太地区）、`EU`（欧洲）、`NA`（北美）。

**美颜（仅 Electron）**

1.1.5 新增基础美颜能力，支持设置美白、磨皮和红润效果。

## 1.1.2.3 版

该版本于 2021 年 7 月 27 日发布。该版本进行了一些内部改进。

## 1.1.2 版

该版本于 2021 年 6 月 17 日发布。

### 升级必看

灵动课堂桌面端 1.1.2 对于 Agora Edu Context 进行了以下改动：

-   对 1.1.0 的 Edu Context 进行重构，废弃了一些重复的 Context API，详见 [Edu Context API 参考](/cn/agora-class/edu_context_api_ref_web_overview)。对于废弃的 API，Agora 支持向下兼容，但建议尽快使用最新的 API。
-   去除了 1.1.0 中的 UI Context。从 1.1.0 升级至 1.1.2 时，你需要参考 `packages/agora-classroom-sdk/src/infra/api/index.ts` 和 `packages/agora-classroom-sdk/src/infra/stores/app/ui.ts` 文件，在 `agora-classroom-sdk` 中添加 UI Store 进行 UI 状态管理。

### 新增特性

**倒计时**

1.1.2 新增倒计时工具。老师可在工具箱中打开倒计时工具并设置倒计时数值。老师点击开始倒计时后学生端会出现倒计时面板。

**屏幕共享标注**

1.1.2 支持老师开始屏幕共享后在共享内容上使用白板基础绘画工具进行标注。

**自定义用户属性和课堂属性**

1.1.2 支持开发者自定义用户属性和课堂属性，同时支持更新属性和监听属性更新。例如，开发者可通过自定义用户属性设置用户头像。具体改动如下：

-   课堂属性：在 `RoomContext` 中新增以下 API：
    -   `updateFlexRoomProperties` 方法，用于新增或更新自定义课堂属性。
    -   `flexRoomProperties` 字段，用于监听课堂属性的变更。
-   用户属性：`LaunchOption` 中新增 `userFlexProperties` 字段，用于在启动课堂时传入自定义用户属性。

**HTML5 课件**

1.1.2 支持老师在课堂白板上展示 HTML5 课件。

## 1.1.0 版

该版本于 2021 年 4 月 30 日发布。

### 升级必看

**SDK 集成方式变更**

自 1.1.0 起，灵动课堂桌面端新增通过 npm 集成 Agora Classroom SDK。详见[快速启动灵动课堂](./agora_class_quickstart_web?platform=Web)中集成 SDK 一节。

### 新增特性

**自定义课堂 UI**

自 1.1.0 起，Agora Classroom SDK 将灵动课堂的 UI 代码和核心业务逻辑隔离开来，独立成 UI Kit 和 Edu Core，并通过 Edu Context 为开发者提供实现灵动课堂业务功能的能力。不同 Context 代表灵动课堂中各个功能模块，详见 [Agora Edu Context API 参考](./edu_context_api_ref_web_overview?platform=Web)。

![](https://web-cdn.agora.io/docs-files/1619696813295)

开发者无需深入学习灵动课堂的核心业务逻辑，只需基于 UI Kit 修改 UI 组件，调用相应 Context 提供的方法和回调，即可自定义灵动课堂各个功能模块的 UI，使在线互动课堂更为个性化。详见[自定义课堂 UI](./agora_class_custom_ui_web?platform=Web)。

**扩展应用 ExtApp**

自 1.1.0 起，灵动课堂支持扩展应用 ExtApp，能够帮助开发者根据实际需求在灵动课堂内嵌入自己实现的应用，例如倒计时、骰子等，详见[通过 ExtApp 自定义插件](./agora_class_ext_app_web?platform=Web)。

**课件管理**

为提升课堂学习效果，灵动课堂 1.1.0 新增课件模块。老师可通过灵动课堂客户端上传 PPT、DOC、PDF 等格式的文件。灵动课堂客户端会对后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以用于课堂内白板展示。开发者还可通过灵动课堂云服务 RESTful API 配置并上传文件至云盘，并获取课堂内云盘文件变更事件，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Web)。

1.1.0 中，上传至云盘的文件默认储存在 Agora 的阿里云 OSS 账号中。如开发者想要将文件存储至自己的 OSS 账号中，需要更新 Agora 控制台 aPaaS 配置中的白板 JSON 配置对象，详见[灵动课堂前提条件](./agora_class_prep?platform=Web)中在 Agora 控制台配置灵动课堂一节。

此外，1.1.0 还支持课件预加载。在 Agora Classroom SDK 的 `launch` 方法中新增 `courseWareList` 和 `personalCourseWareList` 字段，用于预加载教育机构指派的和老师端上传的课件。成功调用后，客户端会将云盘中的课件缓存至本地。详见 [Agora Classroom SDK API 参考](./agora_class_api_ref_web?platform=Web)。

**页面录制**

灵动课堂 1.1.0 支持[页面录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)，能够将指定 URL 的页面内容和音频混合录制为一个 MP4 音视频文件，实现音视频内容、白板内容、课件内容同步录制。开发者可通过灵动课堂云服务 RESTful API 配置并发起页面录制，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Web)。

**点名上台**

对于在线互动小班课，1.1.0 新增“讲台上”和“讲台下”两种状态，支持老师点名学生上讲台功能。老师可在课堂内点名学生“上讲台”发言，打开学生的音视频采集设备。默认上台人数上限为 6 人。

**用户列表**

为加强课堂管理，灵动课堂 1.1.0 新增人员列表功能，展示课堂中所有学生的名称、上下台状态、摄像头和麦克风开关状态、奖励个数等信息。老师和助教可通过用户列表进行邀请学生上下台、白板授权、开关学生的摄像头和麦克风、授予奖励、踢人等操作。

**课堂状态管理**

灵动课堂 1.1.0 在客户端 Agora Classroom SDK 的 `launch` 方法中新增以下参数：

-   `startTime`: 设置课堂开始时间（毫秒），以第一个进入课堂的用户传入的参数为准。
-   `duration`: 设置课堂持续时间（秒），以第一个进入课堂的用户传入的参数为准。

**课堂奖励**

为增强课堂互动，灵动课堂 1.1.0 新增课堂奖励功能，老师可在学生答题后给予学生奖励。开发者可通过灵动课堂云服务 RESTful API 获取奖励变更事件，详见[灵动课堂云服务 RESTful API](./agora_class_restful_api?platform=Web)。

### 改进

**三大场景 UI 升级**

为满足更多在线教育需求，1.1.0 中 1 对 1 互动教学、在线互动小班课、互动直播大班课三大场景的 UI 和页面交互进行了整体优化，将视频区域、白板区域、实时聊天区域窗口化。

**白板优化**

1.1.0 优化了课堂内白板的书写体验。

## 1.0.0 版

该版本于 2021 年 1 月 20 日发布。这是灵动课堂的首个版本，支持以下三种教学场景：

-   1 对 1 互动教学：1 位老师对 1 名学生进行专属在线辅导教学，老师和学生进行实时音视频互动。
-   1 对 N 在线小班课：1 位教师对 N 名学生（2 ≤ N ≤ 16）进行在线辅导教学，老师和学生进行实时音视频互动。
-   互动直播大班课：1 位老师进行在线教学，多名学生实时观看和收听，学生人数无上限。上课过程中，学生可以“举手”请求发言，与老师进行实时音视频互动。

该版本主要包含以下功能：

-   实时音视频互动
-   实时消息互动
-   互动白板
-   课件上传
-   教室管理
-   屏幕共享
-   录制回放
