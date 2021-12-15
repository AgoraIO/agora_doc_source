---
title: 实现视频直播
platform: Cocos Creator
updatedAt: 2020-12-15 10:06:39
---

## 前提条件

- Cocos Creator 2.3.4 或以上（本文界面描述基于 Cocos Creator 2.4.3）
- [Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started)

- 操作系统与集成开发环境要求：

  | 开发平台 | 操作系统版本       | 集成开发环境版本                                                                                   |
  | :------- | :----------------- | :------------------------------------------------------------------------------------------------- |
  | Android  | Android 4.1 或以上 | <li>Android Studio 3.0 或以上</li><li>Android SDK API 16 或以上</li><li>Android NDK 17 或以上</li> |
  | iOS      | iOS 8.0 或以上     | Xcode 9.0 或以上                                                                                   |

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
6. 在 **Agora RTC** 面板底部，选择 SDK 类型为 **Video**，并点击**保存**，即可获取 Agora Cocos Creator SDK。

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

接下来我们要在 `Script/HelloWorld.js` 中调用 Agora Cocos Creator SDK 提供的核心 API 实现基础的视频互动直播功能，API 调用时序见下图。

![](https://web-cdn.agora.io/docs-files/1606296160054)

### <a name="initialize"></a>1. 初始化 Agora 引擎

在调用其他 Agora API 前，你需要初始化 Agora 引擎。你需要在该步骤中填入你在[配置 Agora 项目](#configure)时获取到的 Agora App ID。

调用 `init`，传入获取到的 App ID，即可初始化 Agora 引擎。

你也可以根据需求，在初始化时注册想要监听的回调事件。如注册用户加入频道和离开频道的回调。

```typescript
cc.Class({

    ...

    onLoad: function () {
        // 初始化 Agora 引擎。将 YOUR_APPID 替换为你 Agora 项目的 App ID。
        agora.init('YOUR_APPID');
        agora.on('joinChannelSuccess', this.onJoinChannelSuccess, this);
        agora.on('leaveChannel', this.onLeaveChannel, this);
        agora.on('userJoined', this.onUserJoined, this);
        agora.on('userOffline', this.onUserOffline, this);
    },

    ...
});
```

### 2. 设置频道场景

初始化结束后，调用 `setChannelProfile`，将频道场景设为互动直播。

如果想切换为其他场景，需要先调用 `release` 释放 Agora 引擎，然后调用 `init` 重新初始化 Agora 引擎，再调用 `setChannelProfile` 设置新的频道场景。

```typescript
cc.Class({

    ...

    onLoad: function () {

        ...

        // 设置频道场景为直播场景。
        agora.setChannelProfile(agora.CHANNEL_PROFILE_TYPE.CHANNEL_PROFILE_LIVE_BROADCASTING);
    },

    ...
});
```

### 3. 设置用户角色

互动直播频道有两种用户角色：主播和观众，其中默认的角色为观众。

设置频道场景为互动直播后，你可以参考如下步骤设置用户角色：

1. 在 Cocos Creator 中，进入**控件库** > **内置控件**，将 **Toggle Group** 组件添加到**场景编辑器**。你可以自行调整 Toggle 组件的显示位置。

2. 在**层级管理器**中，你可以看到 **toggleContainer** 内包含三个 Toggle 组件，你需要删除多余的 Toggle 组件（例如 **toggle3**）。

<div class="alert info">本节将 <b>toggle1</b> 作为观众选项，<b>toggle2</b> 作为主播选项。</div>

3. 在 `HelloWorld.js` 中，调用 `setClientRole`，使用用户选择的角色进行传参。

   ```typescript
   cc.Class({

       ...

       setClientRole: function (toggle, customEventData) {
           // 设置用户角色。用户选择的角色会通过 customEventData 传入。
           // customEventData 为 1 表示观众，对应的枚举值为 agora.CLIENT_ROLE_TYPE.CLIENT_ROLE_AUDIENCE。
           // customEventData 为 2 表示主播，对应的枚举值为 agora.CLIENT_ROLE_TYPE.CLIENT_ROLE_BROADCASTER。
           agora.setClientRole(customEventData);
       },

       ...
   });
   ```

4. 回到 Cocos Creator，选中 **toggle1** 组件，在右侧**属性检查器**中找到 **Toggle** > **Check Events**，添加一个点击事件。

5. 将**层级管理器**面板上的 **Canvas** 添加到该点击事件的 **cc.Node** 属性框。在 **cc.Node** 属性框后的两个下拉框中依次选择场景（**HelloWorld**）和触发事件（**setClientRole**），并在 **CustomEventData** 中输入 **1**。
   ![](https://web-cdn.agora.io/docs-files/1606296440419)
6. 点击下方**添加组件** > **渲染组件** > **Label**，在 **toggle1** 中添加一个 Label，并在 **Label** > **String** 中输入**观众**。``

7. 按步骤 3、4、5 依次配置 **toggle2**。注意需在 **toggle2** 的 **CustomEventData** 中输入 2，并在 **Label** > **String** 中输入**主播**。

<div class="alert note">互动直播频道内的用户只能听到主播的声音。加入频道后，如果你想切换用户角色，也可以调用 <tt>setClientRole</tt>。</div>

### 4. 设置本地视图

为使主播在互动直播前看到本地图像，你需要在加入频道前设置本地视图。参考以下步骤设置本地视图：

1. 在 `HelloWorld.js` 中，调用 `enableVideo` 方法启用视频模块，并调用 `startPreview` 方法开启本地视频预览。

   ```typescript
   cc.Class({

       ...

       onLoad: function () {

           ...

           // 启用视频模块。
           agora.enableVideo();
           // 开启本地视频预览。
           agora.startPreview();
       },

       ...
   });
   ```

2. 在 Cocos Creator 中，进入**控件库** > **云组件**，将 **AgoraVideoRender** 添加到**场景编辑器**中。

### <a name="join"></a>5. 加入频道

完成设置角色和本地视图后，你可以参考如下步骤加入频道：

1. 在 Cocos Creator 中，添加一个加入或离开频道按钮。进入**控件库** > **内置控件**，将 **Button** 组件添加到**场景编辑器**。

2. 在**层级管理器**中点击 **button** > **Background** > **Label**，在**属性检查器**中找到 **Label** > **String**，将按钮显示内容修改为**加入频道。**

3. 在 `HelloWorld.js` 中，定义一个 `clickButton` 方法，设置点击按钮的事件。

   ```typescript

   cc.Class({
    ...

    // 设置点击按钮的行为。
    // joined 为 true 表示已经加入频道，点击按钮后会调用 leaveChannel 离开频道。
    // joined 为 false 表示已经离开频道，点击按钮后会调用 joinChannel 加入频道。
    clickButton: function () {
        if (this.joined) {
            this.leaveChannel();
        } else {
            this.joinChannel();
            }
    },

    ...
   });
   ```

4. 调用 `joinChannel` 并填入 Token、频道名称和用户 ID。

   ```typescript
   cc.Class({

       ...

       joinChannel: function () {
           // 加入频道。
           // 将 YOUR_TOKEN 替换为你生成的 Token。
           // 将 CHANNEL_NAME 替换为你生成 Token 时使用的频道名称。
           // 在 uid 中输入你的用户 ID。
           agora.joinChannel('YOUR_TOKEN', 'CHANNEL_NAME', '', uid);
       },

       ...
   });
   ```

5. 在 `onJoinChannelSuccess` 回调中添加是否加入频道的判断逻辑，用于动态更改 **button** 组件的显示内容。注意你需要删除 `HelloWorld.js` 中对 Label 的原始定义：

   - 删除 `properties` 中的 `text: 'Hello, World!'` 代码。
   - 删除 `onLoad` 方法中的 `this.label.string = this.text;` 代码。

   ```typescript
   cc.Class({

       ...

       // 本地用户加入频道回调。
       onJoinChannelSuccess: function (channel, uid, elapsed) {
           // 加入频道后，按钮的显示内容变为离开频道。
           this.joined = true;
           this.label.string = '离开频道';
       },

       ...
   });
   ```

6. 回到 Cocos Creator 的**层级管理器**中，点击 **Canvas**。在右侧**属性检查器**中找到 **HelloWorld** 组件脚本，将 **button** 组件的 **Label** 添加至该组件脚本中，便于动态修改按钮显示内容。
   ![](https://web-cdn.agora.io/docs-files/1606296796905)

7. 在**层级管理器**中点击 **button**，在右侧**属性检查器**中找到 **Button** > **Check Events**，添加一个点击事件。

8. 将 **Canvas** 添加到该点击事件的 **cc.Node** 属性框，并在 **cc.Node** 属性框后的两个下拉框中依次选择场景（**HelloWorld**）和触发事件（**clickButton**）。

### 6. 设置远端视图

视频直播中，不论你是主播还是观众，都应该看到频道中的所有主播。

远端主播成功加入频道后，SDK 会触发 `onUserJoined` 回调，该回调中会包含这个主播的 `uid` 信息。你可以参考如下步骤设置远端视图：

1. 在 `HelloWorld.js` 中，导入 `AgoraVideoRender` 云组件，用于渲染远端主播的视频。在 `onUserJoined` 和 `onUserOffline` 回调中，添加是否显示远端视频的判断逻辑。

   ```typescript
   // 导入 AgoraVideoRender 云组件。
   const AgoraVideoRender = require('AgoraVideoRender');

   cc.Class({

       ...

       properties: {

           ...

           // 添加远端视图。
           target: {
               default: null,
               type: cc.Prefab
           }
       },

       ...

       // 远端主播加入频道回调。该回调可获取远端主播的 uid。
       onUserJoined: function (uid, elapsed) {
           if (this.remoteUid === undefined) {
               this.remoteUid = uid;
               // 添加一个 Prefab。
               const render = cc.instantiate(this.target);
               // 将 AgoraVideoRender 组件的 uid 设为远端主播的 uid。
               render.getComponent(AgoraVideoRender).uid = this.remoteUid;
               // 将 AgoraVideoRender 组件添加到场景中。
               cc.director.getScene().addChild(render, 0, `uid:${this.remoteUid}`);
               // 设置远端视图大小。
               render.setContentSize(160, 120);
               // 设置远端视图位置。
               render.setPosition(300, 120);
           }
       },

       // 远端主播离开频道回调。
       onUserOffline: function (uid, reason) {
           if (this.remoteUid === uid) {
               // 远端主播离开频道时，将 uid 设置为 undefined。
               cc.director.getScene().getChildByName(`uid:${this.remoteUid}`).destroy();
               this.remoteUid = undefined;
           }
       },

       ...
   });
   ```

2. 在 Cocos Creator 中，点击**层级管理器**中的 **Canvas**，在**资源管理器**中找到 **assets** > **cloud-component** > **AgoraVideoRender** > **AgoraVideoRender.prefab**，并将其添加至 Canvas **属性检查器**的 **HelloWorld** > **Target** 中。
   ![](https://web-cdn.agora.io/docs-files/1606296862080)

### 7. 离开频道

根据场景需要，如结束通话、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

离开频道后，如果你想退出应用或者释放 Agora 引擎的内存，需调用 `release` 方法销毁 Agora 引擎。

```typescript
cc.Class({

    ...

    leaveChannel: function () {
        // 离开频道。
        agora.leaveChannel();
        if (this.remoteUid !== undefined) {
            // 移除远端视图。
            cc.director.getScene().getChildByName(`uid:${this.remoteUid}`).destroy();
            this.remoteUid = undefined;
        }
        // 离开频道后，按钮的显示内容为加入频道。
        this.joined = false;
        this.label.string = '加入频道';
        // 销毁 Agora 引擎。
        agora.release();
    },

    // 本地用户离开频道回调。
    onLeaveChannel: function (stats) {},

    ...
});
```

## 运行项目

我们建议你在连接 Android 或 iOS 真机后，构建并运行项目。详见[打包发布原生平台](https://docs.cocos.com/creator/manual/zh/publish/publish-native.html)。

以构建并运行 iOS 项目为例，你可以参考如下步骤：

1. 在 Cocos Creator 菜单栏点击**项目** > **构建发布**。
2. 输入游戏名称（默认为 **hello_world**），选择 iOS 作为发布平台，设置发布路径，并点击**构建**。
3. 完成构建后，点击**发布路径**右侧的**打开**按钮，打开 `build` 文件夹。
4. 在 `./jsb-link/frameworks/runtime-src/proj.ios_mac` 路径下，找到你的 iOS 项目（例如 `hello_world.xcworkspace`）并用 Xcode 打开。
5. 在 Xcode 中，选择你的 iOS 设备，点击构建和运行按钮运行该项目。运行成功后，你可以看到你的视频画面。
6. 如果想体验视频互动直播效果，你可以通过声网的 [Web 端示例应用](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/)，输入相同的 App ID、频道名和临时 Token，加入同一频道与 iOS 端互通。

当成功开始视频互动直播时，主播可以看到自己的画面；观众可以看到主播的画面。

## 相关链接

我们在 GitHub 上提供一个开源的视频通话示例项目 [Agora-Cocos-Quickstart/CocosCreator](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/CocosCreator)，你可以结合该示例项目与本文示例代码实现视频互动直播。
