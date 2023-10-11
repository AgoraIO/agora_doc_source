
本文介绍如何将 [Unreal C++ SDK](https://github.com/AgoraIO-Community/Agora-Unreal-SDK) 从 v3.x (即 3.5.0.4 版本) 升级至 v4.x。


### 集成 SDK
参考[创建项目](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/start_live_blueprint_ng?platform=Unreal-Blueprint#project)，将 v4.x SDK 集成到你的项目中。

### 修改代码

本节介绍 v4.2.1 相对于 v3.x 的主要变更，你需要结合实际业务场景更新 app 代码：

**基础变更**

由于 Unreal C++ SDK 基于 Native Windows (C++) SDK 封装，所以它包括了所有 Native SDK 从 v3.x 到 4.x 的变更。如果想要了解具体变更，可参见 [Native 迁移指南](https://docportal.shengwang.cn/cn/voice-call-4.x/migration_guide_windows_ng?platform=Windows)。

**其他变更**
- 接口类 `agora::rtc::ue4::AgoraRtcEngine*` 变更为 `agora::rtc::ue::RtcEngineProxy*`，你需要手动修改项目文件中的代码。
- 4.x SDK 简化了视频渲染的实现步骤，无需主动调用 `AgoraRtcEngine` 中的 `OnTick` 函数，由 `VideoRenderManager` 自动处理。所以你需要手动删除项目文件中跟 `OnTick` 相关的代码。
- 修改项目文件夹，增加对头文件 `#include "AgoraPluginInterface.h"` 的引用，以直接导入 v4.x SDK 中的所有基础类。你也可以根据实际需求，在 `AgoraPlugin\Private\AgoraCppPlugin\include\AgoraHeaderBase.h` 中补充所需的类，或者直接 include 所需的文件。
