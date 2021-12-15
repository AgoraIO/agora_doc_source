---
title: 实现视频直播
platform: Unity
updatedAt: 2021-01-06 08:57:56
---

本文介绍如何使用 Agora Unity SDK 快速实现视频互动直播。

## 前提条件

- Unity 2017 或以上版本

- 操作系统与编译器要求：

  | 开发平台 | 操作系统版本       | 编译器版本                          |
  | :------- | :----------------- | :---------------------------------- |
  | Android  | Android 4.1 或以上 | Android Studio 3.0 或以上           |
  | iOS      | iOS 8.0 或以上     | Xcode 9.0 或以上                    |
  | macOS    | macOS 10.0 或以上  | Xcode 9.0 或以上                    |
  | Windows  | Windows 7 或以上   | Microsoft Visual Studio 2017 或以上 |

- 有效的 [Agora 账户](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up) 和 [App ID](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#getappid)

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms#agora-rtc-sdk">应用企业防火墙限制</a >打开相关端口。</div>

## 准备开发环境

本节介绍如何创建项目，将 Agora Unity SDK 集成进你的项目中。

### 创建 Unity 项目

参考以下步骤或 [Unity 官方操作指南](https://docs.unity3d.com/2018.2/Documentation/Manual/GettingStarted.html)创建一个 **Unity** 项目。若已有 **Unity** 项目，可以直接查看[集成 SDK](#Integrate)。

<details>
	<summary><font color="#3ab7f8">创建 Unity 项目</font></summary>
	
1. 开始前确保你已安装 **Unity**。若未安装，点击<a href="https://store.unity.com/?_ga=2.210473373.969150697.1571977051-1808388573.1570601452#plans-individual">此处</a >下载。
	
2. 打开 **Unity**，点击 **New**。
	
3. 依次填入以下内容后，点击 **Create project**。
	 - **Project name**：项目名称
	 - **Location**：项目存储路径
	 - **Organization**：组织名称
	 - **Template**：项目类型。选择 **3D**。
</details>

<a name="Integrate"></a>

### 集成 SDK

选择如下任意一种方式将 Agora Unity SDK 集成到你的项目中。

**方法一：使用 Unity Asset Store 自动集成**

1. 在 **Unity** 中点击 **Asset Store** 栏，输入 **Agora** 搜索并选择 **Agora Video SDK for Unity**。
   ![](https://web-cdn.agora.io/docs-files/1576206914656)
2. 在 SDK 详情页中，点击页面右侧的 **Download** 按钮下载 SDK。
   ![](https://web-cdn.agora.io/docs-files/1576206963608)
3. 下载成功后，会出现 **Import** 按钮，点击查看可导入的内容。
   ![](https://web-cdn.agora.io/docs-files/1576207004091)
4. 取消勾选不需要的插件（默认勾选 SDK 包含的所有插件）。然后点击 **Import**。
   ![](https://web-cdn.agora.io/docs-files/1576207151013)

**方法二：手动复制 SDK 文件**

1. 前往 [SDK 下载页面](https://docs.agora.io/cn/Agora%20Platform/downloads)，在**视频通话/视频互动直播 SDK** 中下载最新版的 **Agora Unity SDK**，然后解压。

2. 将 SDK 包内 `samples/Hello-Video-Unity-Agora/Assets/AgoraEngine` 路径下的 `Plugins` 文件夹拷贝到项目的 `Assets` 文件夹下。

 <div class="alert note"><ul><li>对于开发 Android 或 iOS 应用的用户，如需在 macOS 或 Windows 设备中使用 Unity Editor 调试，请确保拷贝 macOS 或 X86/X86_64 文件夹。<li>iOS 平台集成时，还需要拷贝 <code>samples/Hello-Video-Unity-Agora/Assets/AgoraEngine/Editor</code> 路径下的 <code>BL_BuildPostProcess.cs</code> 脚本。</div>

## 实现视频互动直播

本节介绍如何实现视频互动直播。视频互动直播的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1576220748956)

### 1. 创建用户界面

根据场景需要，为你的项目创建视频互动直播的用户界面。若已有界面，可以直接查看[获取设备权限（仅 Android 平台）](#permission)或[初始化 IRtcEngine](#initialize)。

在视频互动直播中，Agora 推荐你添加如下 UI 元素：

- 主播视频窗口
- 退出频道按钮

当你使用 **Unity Editor** 创建 UI 时，请确保你将 **VideoSurface.cs** 与显示本地或远端视频的物体绑定。

<a name="permission"></a>

### 2. 获取设备权限（仅 Android 平台）

仅 Android 平台需要设置此步骤，其他平台可以直接查看[初始化 IRtcEngine](#initialize)。

在 **UNITY_2018_3_OR_NEWER** 或以上版本中，Unity 不会主动向用户获取麦克风和相机权限，需要用户调用 `CheckPermission` 方法获取权限。

```C#
#if(UNITY_2018_3_OR_NEWER)
using UnityEngine.Android;
#endif
void Start ()
{
#if(UNITY_2018_3_OR_NEWER)
permissionList.Add(Permission.Microphone);
permissionList.Add(Permission.Camera);
#endif
}
private void CheckPermission()
{
#if(UNITY_2018_3_OR_NEWER)
foreach(string permission in permissionList)
{
if (Permission.HasUserAuthorizedPermission(permission))
{
}
else
{
Permission.RequestUserPermission(permission);
}
}
#endif
}
void Update ()
{
#if(UNITY_2018_3_OR_NEWER)
// 获取设备权限。
CheckPermission();
#endif
}
```

<a name="initialize"></a>

### 3. 初始化 IRtcEngine

你需要在该步骤中填入项目的 App ID。请参考如下步骤在控制台[创建 Agora 项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms)并获取 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id)。

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏的**[项目管理](https://console.agora.io/projects)**图标 ![](https://web-cdn.agora.io/docs-files/1551254998344)。
2. 点击**创建**，按照屏幕提示设置项目名，选择一种鉴权机制，然后点击**提交**。
3. 在**项目管理**页面，你可以获取该项目的 **App ID**。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如本地用户加入频道，及解码远端用户视频首帧等。

```C#
// 填入 App ID 并初始化 IRtcEngine。
mRtcEngine = IRtcEngine.GetEngine (appId);
// 注册 OnJoinChannelSuccessHandler 回调。
// 本地用户成功加入频道时，会触发该回调。
mRtcEngine.OnJoinChannelSuccessHandler = OnJoinChannelSuccessHandler;
// 注册 OnUserJoinedHandler 回调。
// SDK 接收到第一帧远端视频并成功解码时，会触发该回调。
// 可以在该回调中调用 SetForUser 方法设置远端视图。
mRtcEngine.OnUserJoinedHandler = OnUserJoinedHandler;
// 注册 OnUserOfflineHandler 回调。
// 远端用户离开频道或掉线时，会触发该回调。
mRtcEngine.OnUserOfflineHandler = OnUserOfflineHandler;
```

### 4. 设置频道场景

初始化结束后，调用 `SetChannelProfile` 方法，将频道场景设为 `CHANNEL_PROFILE_LIVE_BROADCASTING`。

一个 `IRtcEngine` 只能使用一种频道场景。如果想切换为其他模式，需要先调用 `Destroy` 方法销毁当前的 `IRtcEngine` 实例，然后使用 `GetEngine` 方法创建一个新实例，再调用 `SetChannelProfile` 设置新的频道场景。

```C#
// 设置频道场景为直播场景。
mRtcEngine.SetChannelProfile(CHANNEL_PROFILE.CHANNEL_PROFILE_LIVE_BROADCASTING);
```

### 5. 设置用户角色

直播频道有两种用户角色：主播和观众，其中默认的角色为观众。设置频道场景为直播后，你可以在 App 中参考如下步骤设置用户角色：

1. 让用户选择自己的角色是主播还是观众。
2. 调用 `SetClientRole` 方法，然后使用用户选择的角色进行传参。

注意，直播频道内的用户，只能看到主播的画面、听到主播的声音。加入频道后，如果你想切换用户角色，也可以调用 `SetClientRole` 方法。

```C#
// 设置用户角色为主播
mRtcEngine.SetClientRole(CLIENT_ROLE.BROADCASTER);
```

### 6. 设置本地视频显示

成功初始化 `IRtcEngine` 对象后，需要在加入频道前设置本地视频显示，以便主播在直播中看到本地图像。参考以下步骤设置本地视频显示：

- 调用 `EnableVideo` 方法启用视频模块。

- 调用 `EnableVideoObserver` 方法启用本地视频显示。

  ```C#
  // 启用视频模块。
  mRtcEngine.EnableVideo();
  // 获取本地视频显示，并传递到 Unity 层。
  mRtcEngine.EnableVideoObserver();`
  ```

- 选择显示本地视频的物体，将视频渲染脚本 **VideoSurface.cs** 拖动至该物体的 **Script** 进行绑定，即可看到本地图像。Unity 中默认渲染器可以渲染 3D 物体，例如：Cube，Cylinder，Plane 等。若需渲染其他类型的物体，需修改 **VideoSurface.cs** 文件中的渲染器。

  ![](https://web-cdn.agora.io/docs-files/1576208681884)

  ```C#
    // 默认渲染器为 Renderer。
  Renderer rend = GetComponent();
  rend.material.mainTexture = nativeTexture;
  // 将渲染器修改为 RawImage。
  RawImage rend = GetComponent();
  rend.texture = nativeTexture;`
  ```

### 7. 加入频道

完成设置角色和本地视图后（视频互动直播场景），你就可以调用 `JoinChannelByKey` 方法加入频道。你需要在该方法中传入如下参数：

- `channelKey`：传入能标识用户角色和权限的 Token。可设为如下一个值：

  - `NULL`
  - 临时 Token。在安全要求一般的测试场景下，可使用临时 Token。你可以在控制台里生成一个临时 Token（服务有效期为 24 小时），详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#%E8%8E%B7%E5%8F%96%E4%B8%B4%E6%97%B6-token)。
  - 在你的服务器端生成的 Token。在安全要求高的场景下，Agora 推荐你使用此种方式生成的 Token，详见[生成 Token](https://docs.agora.io/cn/Video/token_server)。

  <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

- `channelName`: 传入能标识频道的频道 ID。输入频道 ID 相同的用户会进入同一个频道。

- `uid`: 本地用户的 ID。数据类型为整型，且频道内每个用户的 `uid` 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `OnJoinChannelSuccessHandler` 回调中报告。

如果直播频道中既有 Native SDK，也有 Web SDK，那么你还需要在加入频道前调用 `EnableWebSdkInteroperability` 方法开启互通。

```C#
// 如果频道中有 Web SDK，调用该方法开启 Native SDK 和 Web SDK 互通。
mRtcEngine.EnableWebSdkInteroperability(true);
// 加入频道。
mRtcEngine.JoinChannelByKey(null, channel, null, 0);
```

### 8. 设置远端视频显示

视频互动直播中，不论你是主播还是观众，都应该看到频道中的所有主播。在加入频道后，可通过调用 **VideoSurface.cs** 文件中的 `SetForUser` 方法设置远端主播的视图。

远端主播成功加入频道后，SDK 会触发 `OnUserJoinedHandler` 回调，该回调中会包含这个主播的 `uid` 信息。

- 在 **VideoSurface.cs** 文件，通过 `OnUserJoinedHandler` 回调来调用 `SetForUser` 方法，传入获取到的 `uid`，设置远端视频显示。
- 选择显示远端视频的物体，将视频渲染脚本 **VideoSurface.cs** 拖动至该物体的 **Script** 进行绑定，即可看到远端图像。
- Agora Unity SDK 默认的视频采集和渲染帧率是 15 fps，根据场景，调用 **VideoSurface.cs** 文件中的 `SetGameFps` 方法调节视频刷新帧率。

  <div class="alert note">默认 VideoSurface.cs 文件中 SetForUser 方法的 uid 是 0，表示渲染本地视频。</div>

```C#
// SDK 接收到第一帧远端视频并成功解码时，会触发 OnUserJoinedHandler 回调。
// 在该回调中调用 SetForUser 方法设置远端视频显示。
private void OnUserJoinedHandler(uint uid, int elapsed)
	{
		Debug.Log ("OnUserJoinedHandler: uid = " + uid)
		GameObject go = GameObject.Find (uid.ToString ());
		if (!ReferenceEquals (go, null)) {
			return;
		}
		go = GameObject.CreatePrimitive (PrimitiveType.Plane);
		if (!ReferenceEquals (go, null)) {
			go.name = uid.ToString ();
			VideoSurface remoteVideoSurface = go.AddComponent<VideoSurface> ();
		  // 设置远端视频显示。
		  remoteVideoSurface.SetForUser (uid);
		  // 调节视频刷新帧率。Agora Unity SDK 默认的视频采集和渲染帧率是 15 fps。
		  // 例如，游戏场景中，游戏刷新帧率为 60 fps。我们此时视频渲染帧率相对于视频刷新帧率会产生 3 倍的冗余，需通过 SetGameFps 方法，将游戏刷新帧率调节为 15 fps。
		  remoteVideoSurface.SetGameFps (60);
		  remoteVideoSurface.SetEnable (true);
		}
		mRemotePeer = uid;
	}
```

若需移除 **VideoSurface.cs** 文件，参考以下示例代码：

```C#
private void OnUserOfflineHandler(uint uid, USER_OFFLINE_REASON reason)
    {
        // 移除视频流。
        // 请在主线程中调用此方法。
        GameObject go = GameObject.Find (uid.ToString());
        if (!ReferenceEquals (go, null)) {
            Destroy (go);
        }
    }
```

### 9. 离开频道

根据场景需要，如结束直播或关闭 App 时，调用 `LeaveChannel` 离开当前直播频道，并调用 `DisableVideoObserver` 关闭视频显示。

```C#
public void leave()
	{
		Debug.Log ("calling leave");
		if (mRtcEngine == null)
			return;
		// 离开频道。
		mRtcEngine.LeaveChannel();
		// 关闭视频显示。
		mRtcEngine.DisableVideoObserver();
	}
```

### 10. 销毁 IRtcEngine

离开频道后，如果你想退出应用或者释放内存，需调用 `Destroy` 方法销毁 `IRtcEngine`。

```C#
void OnApplicationQuit()
{
	if (mRtcEngine != null)
	{
	// 销毁 IRtcEngine。
	IRtcEngine.Destroy();
    mRtcEngine = null;
	}
}
```

## 运行项目

你可以在 Unity 中运行此项目。当成功开始视频互动直播时，主播可以看到自己的画面；观众可以看到主播的画面。
