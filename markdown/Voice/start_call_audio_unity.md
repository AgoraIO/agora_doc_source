---
title: 实现语音通话
platform: Unity
updatedAt: 2021-01-06 08:59:01
---

本文介绍如何使用 Agora Unity SDK 快速实现语音通话。

如果你是第一次使用声网的服务，我们推荐观看下面的视频，了解关于声网服务的基本信息以及如何快速跑通示例项目。

<video src="<%= src %>" poster="<%= poster %>"   controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## 示例项目

Agora 在 Github 上提供开源的实时语音通话示例项目 [Hello-Unity3D-Agora](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/audio/Hello-Unity3D-Agora)。在实现相关功能前，你可以下载并查看源代码。

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

1. 在 **Unity** 中点击 **Asset Store** 栏，输入 **Agora** 搜索并选择 **Agora Voice SDK for Unity**。
   ![](https://web-cdn.agora.io/docs-files/1576206914656)
2. 在 SDK 详情页中，点击页面右侧的 **Download** 按钮下载 SDK。
   ![](https://web-cdn.agora.io/docs-files/1576223167334)
3. 下载成功后，会出现 **Import** 按钮，点击查看可导入的内容。
   ![](https://web-cdn.agora.io/docs-files/1576223214801)
4. 取消勾选不需要的插件（默认勾选 SDK 包含的所有插件）。然后点击 **Import**。
   ![](https://web-cdn.agora.io/docs-files/1576223374636)

**方法二：手动复制 SDK 文件**

1. 前往 [SDK 下载页面](https://docs.agora.io/cn/Agora%20Platform/downloads)，在**语音通话/音频互动直播 SDK** 中下载最新版的 **Agora Unity SDK**，然后解压。

2. 将 SDK 包内 `samples/Hello-Unity3D-Agora/Assets/AgoraEngine` 路径下的 `Plugins` 文件夹拷贝到项目的 `Assets` 文件夹下。

 <div class="alert note"><ul><li>对于开发 Android 或 iOS 应用的用户，如需在 macOS 或 Windows 设备中使用 Unity Editor 调试，请确保拷贝 macOS 或 X86/X86_64 文件夹。<li>iOS 平台集成时，还需要拷贝 <code>samples/Hello-Unity3D-Agora/Assets/AgoraEngine/Editor</code> 路径下的 <code>BL_BuildPostProcess.cs</code> 脚本。</div>

## 实现语音通话

本节介绍如何实现语音通话。语音通话的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1576225609728)

### 1. 创建用户界面

根据场景需要，为你的项目创建语音通话的用户界面。若已有界面，可以直接查看[获取设备权限（仅 Android 平台）](#permission)或[初始化 IRtcEngine](#initialize)。

在语音通话播中，Agora 推荐你添加如下 UI 元素：

- 加入频道按钮
- 退出频道按钮

<a name="permission"></a>

### 2. 获取设备权限（仅 Android 平台）

仅 Android 平台需要设置此步骤，其他平台可以直接查看[初始化 IRtcEngine](#initialize)。

在 **UNITY_2018_3_OR_NEWER** 或以上版本中，Unity 不会主动向用户获取麦克风权限，需要用户调用 `CheckPermission` 方法获取权限。

```C#
#if(UNITY_2018_3_OR_NEWER)
using UnityEngine.Android;
#endif
void Start ()
{
#if(UNITY_2018_3_OR_NEWER)
permissionList.Add(Permission.Microphone);
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

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如本地用户加入频道，及解码远端用户音频首帧等。

```C#
// 填入 App ID 并初始化 IRtcEngine。
mRtcEngine = IRtcEngine.GetEngine (appId);
// 注册 OnJoinChannelSuccessHandler 回调。
// 本地用户成功加入频道时，会触发该回调。
mRtcEngine.OnJoinChannelSuccessHandler = OnJoinChannelSuccessHandler;
// 注册 OnUserJoinedHandler 回调。
// SDK 接收到第一帧远端音频并成功解码时，会触发该回调。
mRtcEngine.OnUserJoinedHandler = OnUserJoinedHandler;
// 注册 OnUserOfflineHandler 回调。
// 远端用户离开频道或掉线时，会触发该回调。
mRtcEngine.OnUserOfflineHandler = OnUserOfflineHandler;
```

### 4. 加入频道

初始化 `IRtcEngine` 后，你就可以调用 `JoinChannelByKey` 方法加入频道。你需要在该方法中传入如下参数：

- `channelKey`：传入能标识用户角色和权限的 Token。可设为如下一个值：

  - `NULL`
  - 临时 Token。在安全要求一般的测试场景下，可使用临时 Token。你可以在控制台里生成一个临时 Token（服务有效期为 24 小时），详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#获取临时-token)。
  - 在你的服务器端生成的 Token。在安全要求高的场景下，Agora 推荐你使用此种方式生成的 Token，详见[生成 Token](https://docs.agora.io/cn/Video/token_server)。

  <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

- `channelName`: 传入能标识频道的频道 ID。输入频道 ID 相同的用户会进入同一个频道。

- `uid`: 本地用户的 ID。数据类型为整型，且频道内每个用户的 `uid` 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `OnJoinChannelSuccessHandler` 回调中报告。

```C#
// 加入频道。
mRtcEngine.JoinChannelByKey(null, channel, null, 0);
```

### 5. 离开频道

根据场景需要，如结束通话或关闭 App 时，调用 `LeaveChannel` 离开当前通话频道。

```C#
public void leave()
	{
		Debug.Log ("calling leave");
		if (mRtcEngine == null)
			return;
		// 离开频道。
		mRtcEngine.LeaveChannel();
	}
```

### 6. 销毁 IRtcEngine

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

### 示例代码

你可以在 [Hello-Unity3D-Agora](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/audio/Hello-Unity3D-Agora) 示例项目的 [HelloUnity3D.cs](https://github.com/AgoraIO/Agora-Unity-Quickstart/blob/master/audio/Hello-Unity3D-Agora/Assets/HelloUnity3D.cs) 文件中查看完整的源码和代码逻辑。

## 运行项目

你可以在 Unity 中运行此项目。当成功开始语音通话时，你可以听到自己和远端用户的声音。
