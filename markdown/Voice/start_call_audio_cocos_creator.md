---
title: 实现语音通话
platform: Cocos Creator
updatedAt: 2020-12-15 09:58:53
---

本文详细介绍如何快速集成 Agora Cocos Creator SDK，并在你自己的 app 里实现基础的语音通话。

## 前提条件

- [Cocos Creator](https://docs.cocos.com/creator/manual/zh/getting-started/install.html) 2.0.9 或以上（本文界面描述基于 Cocos Creator 2.4.3）
- [Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- 操作系统与集成开发环境（IDE）要求：

  | 开发平台 | 操作系统版本       | 集成开发环境版本          |
  | :------- | :----------------- | :------------------------ |
  | Android  | Android 4.1 或以上 | Android Studio 3.0 或以上 |
  | iOS      | iOS 8.0 或以上     | Xcode 9.0 或以上          |

- 有效的 [Cocos 账户](https://account.cocos.com/)和 [Cocos App ID](https://docs.cocos.com/creator/manual/zh/cocos-service/user-guide.html)。
<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a >以正常使用 Agora 服务。</div>

## 创建 Cocos Creator 项目

参考以下步骤创建一个 Cocos Creator 项目。如果已有 Cocos Creator 项目，直接查看[获取 SDK](#integrate)。

1. 打开 Cocos Creator，进入**新建项目**面板。
2. 选择你需要的示例模板（推荐 **Hello TypeScript**）、选择项目存储路径并输入项目名称。
3. 点击**新建项目**。

## <a name="integrate"></a>获取 SDK

1. 打开 Cocos Creator 项目，点击界面右侧的**服务**栏打开服务面板。

2. 点击 **AppID** 后的 ![](https://web-cdn.agora.io/docs-files/1603983326448) 按钮并点击**设定 Cocos AppID**，以关联你的项目与你的游戏。
   ![](https://web-cdn.agora.io/docs-files/1603984502139)

3. 向下滚动**服务**面板，选择 **Agora Voice**。

4. 点击 **Agora Voice** 后的开通服务按钮 ![](https://web-cdn.agora.io/docs-files/1603983397604)，仔细阅读弹窗内容，并点击**确认开通**即可获取 Agora Cocos Creator SDK。

5. 开通后，Cocos Creator 会在你的 Cocos Creator 项目中自动添加获取设备权限的代码，你无需另行添加。
   Cocos Creator 也会为你自动注册 Agora 账户并创建 Agora 项目。你可以点击**前往控制台**，在**项目管理**界面查看你的 Agora 项目和 [Agora App ID](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#getappid)。

## 基本流程

现在，我们已经将 Agora Cocos Creator SDK 集成到项目中了。你可以根据需要创建组件脚本及场景，并将组件脚本添加到场景节点中。详见[创建和使用组件脚本](https://docs.cocos.com/creator/manual/zh/scripting/use-component.html)。

接下来我们要在组件脚本中调用 Agora Cocos Creator SDK 提供的核心 API 实现基础的音频互动直播功能，API 调用时序见下图。

![](https://web-cdn.agora.io/docs-files/1603985058010)

### 1. 创建用户界面

根据场景需要，为你的项目创建音频互动直播的用户界面。如果已有界面，可以直接查看[初始化 Agora 引擎](#initialize)。

Agora 推荐你添加如下 UI 元素：

- 语音通话窗口
- 退出频道按钮

### <a name="initialize"></a>2. 初始化 Agora 引擎

在调用其他 Agora API 前，你需要初始化 Agora 引擎。你需要在该步骤中填入 Agora 项目的 App ID。详见[获取 Agora App ID](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#getappid)。

调用 `init`，传入获取到的 App ID，即可初始化 Agora 引擎。

你也可以根据需求，在初始化时注册想要监听的回调事件。如注册用户加入频道和离开频道的回调。

```typescript
// 初始化 Agora 引擎。需将 YOUR_APPID 替换为你的 Agora App ID。
agora.init("YOUR_APPID");
// 注册回调。
initAgoraEvents: function () {
    if (agora) {
        agora.on('joinChannelSuccess', this.onJoinChannelSuccess, this);
        agora.on('leaveChannel', this.onLeaveChannel, this);
        agora.on('warning', this.onWarning, this);
        agora.on('error', this.onError, this);
        agora.on('userJoined', this.onUserJoined, this);
        agora.on('userOffline', this.onUserOffline, this);
    }
}
```

### 3. 加入频道

完成设置角色后，你就可以调用 `joinChannel` 加入频道。

在 `joinChannel` 中你需要将 `YOUR_TOKEN` 替换成你自己生成的 Token。

- 在测试阶段，你可以直接在控制台[生成临时 Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token)。
- 在生产环境，我们推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](./token_server)。

<div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <tt>mute</tt> 方法实现。</div>

```typescript
// 对于 v3.1.2 之前的 SDK，如果频道中有 Agora Web SDK，需调用该方法开启 Agora Cocos Creator SDK 和 Agora Web SDK 互通。
// v3.1.2 及之后的 SDK 在通信和互动直播场景下均自动开启了与 Agora Web SDK 的互通，无需调用该方法。
agora.enableWebSdkInteroperability(true);
// 使用 Token 加入频道。
agora.joinChannel("YOUR_TOKEN", “channel5”, "Extra Optional Data", 0);
```

### 4. 离开频道

根据场景需要，如结束通话、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```typescript
agora.leaveChannel();
```

### 5. 销毁 Agora 引擎

离开频道后，如果你想退出应用或者释放 Agora 引擎的内存，需调用 `release` 方法销毁 Agora 引擎。

```typescript
agora.release();
```

## 运行项目

我们建议你在连接 Android 或 iOS 真机后，编译并运行项目。详见[通过编辑器编译和运行](https://docs.cocos.com/creator/manual/zh/publish/publish-native.html#通过编辑器编译和运行)。

当成功开始语音通话时，你可以听到远端用户的声音。

## 常见问题

当你在 Windows 设备上使用 Cocos Creator 编译 Android Native Development Kit（NDK）时，你可能会遇到 `xxx.o:No such file or directory` 报错。导致该错误的原因可能是发布路径太长，你需要缩短发布路径，例如将发布路径修改为磁盘根目录下。

## 相关链接

我们在 GitHub 上提供一个开源的语音通话示例项目 [Voice-Call-for-Mobile-Gaming](https://github.com/AgoraIO/Voice-Call-for-Mobile-Gaming/tree/master/Basic-Voice-Call-for-Gaming/Hello-CocosCreator-Voice-Agora)，你可以前往下载或查看源代码。
