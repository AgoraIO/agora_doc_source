
本文介绍如何将 Unreal C++ SDK 从 v3.x (即 3.5.0.4 版本) 升级至 v4.x。

## 迁移步骤

### 1. 集成 SDK
参考[创建项目](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/start_live_blueprint_ng?platform=Unreal-Blueprint#project)，将 v4.x SDK 集成到你的项目中。

### 2.（可选）导入基础类
在项目文件夹中增加 `#include "AgoraPluginInterface.h"`，以直接导入 v4.x SDK 中的所有基础类。

## 变更介绍

本节介绍 v4.2.1 相对于 v3.x 的主要变更，你需要结合实际业务场景更新 app 代码：

**基础变更**

由于 Unreal C++ SDK 基于 Native Windows (C++) SDK 封装，所以它包括了所有 Native SDK 从 v3.x 到 4.x 的变更。如果想要了解具体变更，可参见 [Native 迁移指南](https://docportal.shengwang.cn/cn/voice-call-4.x/migration_guide_windows_ng?platform=Windows)。

**其他变更**
- 接口类 `agora::rtc::ue4::AgoraRtcEngine*` 变更为 `agora::rtc::ue::RtcEngineProxy*`，你需要手动修改项目文件中的代码。
- SDK 优化了视频渲染的逻辑，无需再调用 `OnTick` 函数。你需要手动删除项目文件中跟 `OnTick` 相关的代码。
