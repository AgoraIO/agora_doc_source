
本文介绍如何将 SDK 从 v3.x (即 3.5.0.4 版本) 升级至 v4.x。

**基础变更**

由于 Unreal SDK 基于 Native Windows (C++) SDK 封装，所以它包括了所有 Native SDK 从 v3.x 到 4.x 的变更。如果想要了解具体变更，可参见 [Native 迁移指南](https://docportal.shengwang.cn/cn/voice-call-4.x/migration_guide_windows_ng?platform=Windows)。

**特有变更**
- （可选）你可以在项目文件夹中增加 `#include "AgoraPluginInterface.h"`，以导入 v4.x SDK 中的基础类。
- 在 v3.x SDK 中，接口类 `agora::rtc::ue4::AgoraRtcEngine*` 变更为 `agora::rtc::ue::RtcEngineProxy*`。