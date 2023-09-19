实时音视频互动中，美颜功能可以让用户展现更好的精神面貌，并提供有趣的贴纸特效。声网与第三方厂商合作，开发了声网美颜场景化 API，使开发者能够方便地集成美颜功能。声网美颜场景化 API，也称为 Beauty API，封装了声网 RTC SDK 和第三方美颜 SDK 的 API 调用逻辑，开发者只需几行代码就能在声网的实时音视频互动中使用第三方提供的丰富美颜功能。

## 获取资源

声网目前已与商汤美颜、字节火山美颜、相芯美颜合作，提供美颜场景化 API，开发者可以根据自己的需求选择不同厂商进行集成。集成过程中，你可以参考如下资源：

|美颜厂商 | 美颜场景化 API 版本号 |GitHub 示例项目 | 参考文档 |
|-----|-----------|---------------|------------|
| 商汤     | 1.0.1.1| <li>[Android 项目](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1/Android)</li><li>[iOS 项目](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1/iOS)</li>            | <li>[跑通项目 (Android)](./beauty_run_github_project_sensetime_android)</li><li>[跑通项目 (iOS)](./beauty_run_github_project_sensetime_ios)</li><li>[实现美颜 (Android)](./beauty_integration_sensetime_android)</li><li>[实现美颜 (iOS)](./beauty_integration_sensetime_android)</li>         |
| 字节火山     |1.0.2 或之后| <li>[Android 项目](https://github.com/AgoraIO-Community/BeautyAPI/tree/main/Android)</li><li>[iOS 项目](https://github.com/AgoraIO-Community/BeautyAPI/tree/main/iOS)</li>               |  <li>[跑通项目 (Android)](./beauty_run_github_project_bytedance_android)</li><li>[跑通项目 (iOS)](./beauty_run_github_project_bytedance_ios)</li><li>[实现美颜 (Android)](./beauty_integration_bytedance_android)</li><li>[实现美颜 (iOS)](./beauty_integration_bytedance_android)</li>          |
| 相芯     |1.0.2 或之后|  <li>[Android 项目](https://github.com/AgoraIO-Community/BeautyAPI/tree/main/Android)</li><li>[iOS 项目](https://github.com/AgoraIO-Community/BeautyAPI/tree/main/iOS)</li>               |  <li>[跑通项目 (Android)](./beauty_run_github_project_faceunity_android)</li><li>[跑通项目 (iOS)](./beauty_run_github_project_faceunity_ios)</li><li>[实现美颜 (Android)](./beauty_integration_faceunity_android)</li><li>[实现美颜 (iOS)](./beauty_integration_faceunity_android)</li>          |


## 版本说明

本节说明秀场直播示例项目、场景化美颜示例项目、美颜 SDK 的版本信息。

### 秀场直播

|秀场直播版本号| GitHub 示例项目 |
|-----|--------|
| 3.0.0.1    |  <li>[Android 项目](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0.1-all-Android/Android/scenes/show)</li><li>[iOS 项目](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/Show)</li>     |
| 3.0.1    | <li>[Android 项目](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/feat/scene/all_android_3.0.1/Android/scenes/show)</li><li>[iOS 项目](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/feat/scene/all_ios_3.0.1/iOS/AgoraEntScenarios/Scenes/Show)</li>       |

<div class="alert note">声网已在 3.0.1 版（最新版）的秀场直播示例项目中集成 1.0.1.1 版场景化美颜（商汤）供你参考。</div>

### 场景化美颜

各版本的场景化美颜示例项目代码可以在 `BeautyAPI` 仓库的 [Tags](https://github.com/AgoraIO-Community/BeautyAPI/tags) 中查看。

![](https://web-cdn.agora.io/docs-files/1694426614022)

### 美颜 SDK

Beauty API 中封装的声网 RTC SDK 和第三方厂商美颜 SDK 版本请参考 [README](https://github.com/AgoraIO-Community/BeautyAPI/blob/main/README.zh)。

![](https://web-cdn.agora.io/docs-files/1694425497610)