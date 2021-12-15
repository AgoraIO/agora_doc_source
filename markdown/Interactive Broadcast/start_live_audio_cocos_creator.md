---
title: 实现音频直播
platform: Cocos Creator
updatedAt: 2020-12-15 09:58:39
---

本文详细介绍如何快速集成 Agora Cocos Creator SDK，并在你自己的 app 里实现基础的音频互动直播。

## 前提条件

- Cocos Creator 2.3.4 或以上（本文界面描述基于 Cocos Creator 2.4.3）
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- 操作系统与集成开发环境要求：

  | 目标平台 | 操作系统版本       | 集成开发环境版本                                                                                            |
  | :------- | :----------------- | :---------------------------------------------------------------------------------------------------------- |
  | Android  | Android 4.1 或以上 | <ul><li>Android Studio 3.0 或以上</li><li>Android SDK API 16 或以上</li><li>Android NDK 17 或以上</li></ul> |
  | iOS      | iOS 8.0 或以上     | Xcode 9.0 或以上                                                                                            |

- 有效的 [Cocos 账户](https://account.cocos.com/)和 [Cocos App ID](https://docs.cocos.com/creator/manual/zh/cocos-service/user-guide.html)。

 <div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=Cocos%20Creator">应用企业防火墙限制</a >以正常使用 Agora 服务。</div>

## 创建 Cocos Creator 项目

参考以下步骤创建一个 Cocos Creator 项目。

1. 打开 Cocos Creator，进入**新建项目**面板。
2. 选择你需要的示例模板（本文以 **Hello World** 模板为例）、选择项目存储路径并在存储路径中输入项目名称。
3. 点击**新建项目**。

## 获取 SDK

1. 打开 Cocos Creator 项目，点击界面右侧的**服务**打开服务面板。
2. 点击 **AppID** 后的 ![](https://web-cdn.agora.io/docs-files/1603983326448) 按钮并点击**设定 Cocos AppID**。
   ![](https://web-cdn.agora.io/docs-files/1603984502139)
3. 点击下拉框，选择一个游戏，并点击**关联**，将该游戏与你的项目关联。
4. 向下滚动**服务**面板，找到并点击 **Agora RTC**。
5. 点击 **Agora RTC** 后的开通服务按钮 ![](https://web-cdn.agora.io/docs-files/1603983397604)，仔细阅读弹窗内容，并点击**确认开通**。
   <% if (product == "audio") { %>
6. 在 **Agora RTC** 面板底部，选择 SDK 类型为 **Audio**，并点击**保存**，即可获取 Agora Cocos Creator SDK。
   <% } if (product == "video") { %>
7. 在 **Agora RTC** 面板底部，选择 SDK 类型为 **Video**，并点击**保存**，即可获取 Agora Cocos Creator SDK。你可以在 Cocos Creator 的**控件库** > **云组件**中看到 **AgoraVideoRender**。
   <% } %>

成功获取 SDK 后，Cocos Creator 会在你的 Cocos Creator 项目中自动添加获取设备权限的代码，你无需另行配置。
Cocos Creator 也会使用你的 Cocos Creator 账户为你自动注册 Agora 账户并创建 Agora 项目。你可以点击 **Agora RTC** 面板上的**前往控制台**，打开 Agora 控制台。

## <a name="configure"></a>配置 Agora 项目

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在 Agora 控制台的**项目管理**页面，找到你的项目，点击右侧的**编辑**按钮进入**编辑项目**页面。
   ![](https://web-cdn.agora.io/docs-files/1606295923430)
2. 在**安全**模块，点击**启用**开启主要证书，并点击**删除**移除无证书。
3. 在**功能**模块，点击**音视频临时 token** 后的**生成临时 token**。
4. 在 **Token** 页面，输入一个频道名，例如 test，然后点击**生成临时 Token**。你可以在该页面复制 Agora App ID，用于[初始化 Agora 引擎](#initialize)；复制临时 Token，用于在[加入频道](#join)时鉴权。

<div class="alert note"><li>临时 Token 的有效期为 24 小时。<li>在生产环境，我们推荐你在自己的服务端生成 Token，详见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server?platform=Cocos%20Creator">在服务端生成 Token</a >。</div>

## 基本流程

现在，我们已经将 Agora Cocos Creator SDK 集成到项目中了。你可以根据需要创建组件脚本及场景，并将组件脚本添加到场景节点中。详见[创建和使用组件脚本](https://docs.cocos.com/creator/manual/zh/scripting/use-component.html)。

接下来我们要在组件脚本中调用 Agora Cocos Creator SDK 提供的核心 API 实现基础的音频互动直播功能，API 调用时序见下图。

![](https://web-cdn.agora.io/docs-files/1603984592578)

### 1. 创建用户界面

根据场景需要，为你的项目创建音频互动直播的用户界面。如果已有界面，可以直接查看[初始化 Agora 引擎](#initialize)。

Agora 推荐你添加如下 UI 元素：

- 选择角色按钮
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
        agora.on('clientRoleChanged', this.onClientRoleChanged, this);
    }
}
```

### 3. 设置频道场景

初始化结束后，调用 `setChannelProfile`，将频道场景设为互动直播。

如果想切换为其他场景，需要先调用 `release` 释放 Agora 引擎，然后调用 `init` 重新初始化 Agora 引擎，再调用 `setChannelProfile` 设置新的频道场景。

```typescript
agora.setChannelProfile(CHANNEL_PROFILE_TYPE.CHANNEL_PROFILE_LIVE_BROADCASTING);
```

### 4. 设置用户角色

互动直播频道有两种用户角色：主播和观众，其中默认的角色为观众。设置频道场景为互动直播后，你可以在 app 中参考如下步骤设置用户角色：

- 让用户选择自己的角色是主播还是观众
- 调用 `setClientRole`，然后使用用户选择的角色进行传参

注意，互动直播频道内的用户只能听到主播的声音。加入频道后，如果你想切换用户角色，也可以调用 `setClientRole`。

```typescript
agora.setClientRole(CLIENT_ROLE_TYPE.CLIENT_ROLE_BROADCASTER);
```

### 5. 加入频道

完成设置角色后，你就可以调用 `joinChannel` 加入频道。

在 `joinChannel` 中你需要将 `YOUR_TOKEN` 替换成你自己生成的 Token。

- 在测试阶段，你可以直接在控制台[生成临时 Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token)。
- 在生产环境，我们推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](./token_server)。

```typescript
// 对于 v3.1.2 之前的 SDK，如果频道中有 Agora Web SDK，需调用该方法开启 Agora Cocos Creator SDK 和 Agora Web SDK 互通。
// v3.1.2 及之后的 SDK 在通信和互动直播场景下均自动开启了与 Agora Web SDK 的互通，无需调用该方法。
agora.enableWebSdkInteroperability(true);
// 使用 Token 加入频道。
agora.joinChannel("YOUR_TOKEN", “channel5”, "Extra Optional Data", 0);
```

### 6. 离开频道

根据场景需要，如结束直播、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前直播频道。

```typescript
agora.leaveChannel();
```

### 7. 销毁 Agora 引擎

离开频道后，如果你想退出应用或者释放 Agora 引擎的内存，需调用 `release` 方法销毁 Agora 引擎。

```typescript
agora.release();
```

## 运行项目

我们建议你在连接 Android 或 iOS 真机后，编译并运行项目。详见[通过编辑器编译和运行](https://docs.cocos.com/creator/manual/zh/publish/publish-native.html#通过编辑器编译和运行)。

当成功开始音频互动直播时，观众可以听到主播的声音。

## 相关链接

我们在 GitHub 上提供一个开源的语音通话示例项目 [Voice-Call-for-Mobile-Gaming](https://github.com/AgoraIO/Voice-Call-for-Mobile-Gaming/tree/master/Basic-Voice-Call-for-Gaming/Hello-CocosCreator-Voice-Agora)，你可以结合该示例项目与本文示例代码实现音频互动直播。
