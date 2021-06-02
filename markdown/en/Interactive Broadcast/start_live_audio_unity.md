---
title: Start Interactive Live Audio Streaming
platform: Unity
updatedAt: 2021-01-06 09:05:09
---
Use this guide to quickly start a basic voice broadcast with the Agora SDK for Unity.

## Prerequisites

- Unity 2017 or later

- Operating system and IDE requirements:

  | Target Platform | Operating system version | IDE version                 |
  | :-------------- | :----------------------- | :-------------------------- |
  | Android         | Android 4.1 or later     | Android Studio 3.0 or later |
  | iOS             | iOS 8.0 or later         | Xcode 9.0 or later          |
  | macOS           | macOS 10.0 or later      | Xcode 9.0 or later          |
  | Windows         | Windows 7 or later  | Microsoft Visual Studio 2017 or later |

- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an [App ID](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#getappid)

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms#agora-rtc-sdk">Firewall Requirements</a > if your network has a firewall.</div>

## Set up the development environment

In this section, we create a Unity project and integrate the SDK into the project.

### Create a Unity project

Use the following steps or follow the[ Unity official manual](https://docs.unity3d.com/Manual/GettingStarted.html) to build a project from scratch. Skip to [Integrate the SDK](#Integrate) if you have already created a Unity project.

<details>
	<summary><font color="#3ab7f8">Create a Unity Project</font></summary>
	
1. Ensure that you have downloaded and installed **Unity** before the following steps. If not, click <a href="https://store.unity.com/?_ga=2.210473373.969150697.1571977051-1808388573.1570601452#plans-individual">here</a > to download.
	
2. Open **Unity** and click **New**.
	
3. Fill in and select the options in the following fields, and click **Create project**.
	 - Project name
	 - Location
	 - Organization
	 - Template: Choose **3D**
</details>

<a name="Integrate"></a>
### Integrate the SDK

Choose either of the following approaches to integrate the Agora Unity SDK into your project.

**Approach 1: Automatically integrate the SDK with Unity Asset Store**

1. Open **Asset Store** in **Unity**, search for **Agora Voice SDK for Unity** and click it.
   ![](https://web-cdn.agora.io/docs-files/1576206914656)
2. Click **Download** to download the SDK.
   ![](https://web-cdn.agora.io/docs-files/1576223710590)
3. When the download completes, the button becomes **Import**. Click **Import** to show the packages of the downloaded SDK.
   ![](https://web-cdn.agora.io/docs-files/1576223720730)
4. All packages of the SDK are chosen by default. Uncheck the packages you do not need and click **Import**.
   ![](https://web-cdn.agora.io/docs-files/1576223735922)

**Approach 2: Manually add the SDK files**

1. Go to [SDK Downloads](https://docs.agora.io/en/Agora%20Platform/downloads), download the Agora SDK for Unity under **Voice SDK**, and extract the files from the downloaded SDK package.
2. Copy the `Plugins` subfolder from the `samples/Hello-Unity3D-Agora/Assets/AgoraEngine` directory of the downloaded SDK to the `Assets` subfolder of your project.

   <div class="alert note"><ul><li>Android or iOS developers using Unity Editor for macOS or Windows must also copy the macOS or the x86/X86_64 subfolder to the specified directory.<li>iOS developers also need to copy the <code>BL_BuildPostProcess.cs</code> file from the <code>samples/Hello-Unity3D-Agora/Assets/AgoraEngine/Editor</code> directory.</div>

## Implement a basic voice broadcast

This section provides instructions on using the Agora Voice SDK for Unity to implement a basic voice broadcast, as well as an API call sequence diagram.

![](https://web-cdn.agora.io/docs-files/1576224606319)

### 1. Create the UI

Create the user interface (UI) for a voice broadcast in your project. If you already have one UI in your project, skip to [Get the device permission (Android only)](#permission) or [Initialize IRtcEngine](#initialize).

We recommend adding the following elements to the UI:

- A switch role button
- An exit button

<a name="permission"></a>
### 2. Get the device permission (Android only)

If you build for Android, you should add in APIs to check and request the device permission. For all other platforms, this is handled by the engine, and you can skip to [Initialize IRtcEngine](#initialize).

Unity versions later than **UNITY_2018_3_OR_NEWER** do not automatically request microphone permissions from your Android device. If you are using one of these versions, call the `CheckPermission` method to request access to the microphone of your Android device.

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
// Ask for your Android device's permissions.
CheckPermission(); 
#endif  
}
```

<a name="initialize"></a>
### 3. Initialize IRtcEngine

In this step, you need to use the App ID of your project. Follow these steps to [create an Agora project](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms) in Console and get an [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id ).

1. Go to [Console](https://dashboard.agora.io/) and click the **[Project Management](https://dashboard.agora.io/projects)** icon ![](https://web-cdn.agora.io/docs-files/1551254998344) on the left navigation panel. 
2. Click **Create** and follow the on-screen instructions to set the project name, choose an authentication mechanism, and Click **Submit**. 
3. On the **Project Management** page, find the **App ID** of your project. 

Call the `GetEngine` method and pass in the App ID to initialize the IRtcEngine object.

Listen for callback events, such as when the local user joins the channel, and when the first audio frame of a remote user is decoded.

```C#
// Pass an App ID to create and initialize an IRtcEngine object.
mRtcEngine = IRtcEngine.GetEngine (appId); 
// Listen for the OnJoinChannelSuccessHandler callback.
// This callback occurs when the local user successfully joins the channel.
mRtcEngine.OnJoinChannelSuccessHandler = OnJoinChannelSuccessHandler; 
// Listen for the OnUserJoinedHandler callback.
// This callback occurs when the first audio frame of a remote user is received and decoded after the remote user successfully joins the channel.
// You can call the SetForUser method in this callback to set the remote video.
mRtcEngine.OnUserJoinedHandler = OnUserJoinedHandler; 
// Listen for the OnUserOfflineHandler callback.
// This callback occurs when the remote user leaves the channel or drops offline.
mRtcEngine.OnUserOfflineHandler = OnUserOfflineHandler;
```


### 4. Set the channnel profile

After initializing the `IRtcEngine` object, call the `SetChannelProfile` method to set the channel profile as `CHANNEL_PROFILE_LIVE_BROADCASTING`.

One `IRtcEngine` object uses one profile only. If you want to switch to another profile, destroy the current `IRtcEngine` object with the `Destroy` method and create a new one before calling the `SetChannelProfile` method.

```C#
// Set the channel profile as the live broadcast.
mRtcEngine.SetChannelProfile(CHANNEL_PROFILE.CHANNEL_PROFILE_LIVE_BROADCASTING);
```

### 5. Set the client role

A Live Broadcast channel has two client roles: `BROADCASTER` and `AUDIENCE`, and the default role is `AUDIENCE`. After setting the channel profile to live broadcast, your app may use the following steps to set the client role:

1. Allow the user to set the role as BROADCASTER or AUDIENCE.
2. Call the `SetClientRole` method and pass in the client role set by the user.

Note that in a live broadcast, only the broadcaster can be heard. If you want to switch the client role after joining the channel, call the `SetClientRole` method.

```C#
// Set the client role as the broadcaster.
mRtcEngine.SetClientRole(CLIENT_ROLE.BROADCASTER);
```

### 6. Join a channel

After setting the client role, you can call `JoinChannelByKey` to join a channel. Set the following parameters when calling this method::

- `channelKey`: The token for identifying the role and privileges of a user. Set it as one of the following values:

  - `NULL`.
  - A temporary token generated in Agora Console. A temporary token is valid for 24 hours. For details, see [Get a temporary token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token).
  - A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](https://docs.agora.io/en/Video/token_server).

  <div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>

- ·`channelName`: The unique name of the channel to join. Users that input the same channel name join the same channel.

- `uid`: Integer. The unique ID of the local user. If you set `uid` as 0, the SDK automatically assigns one user ID and returns it in the `OnJoinChannelSuccessHandler` callback.

If a live broadcast channel uses both the Native SDK and the Web SDK, ensure that you call the `EnableWebSdkInteroperability` method before joining the channel.

```C#
// Call this method to enable interoperability between the Native SDK and the Web SDK if the Web SDK is in the channel.
mRtcEngine.EnableWebSdkInteroperability(true);
// Join a channel. 
mRtcEngine.JoinChannelByKey(null, channel, null, 0);
```

### 7. Leave the channel

According to your scenario, such as when the broadcast ends and when you need to close the app, call `LeaveChannel` to leave the current broadcast, and call `DisableVideoObserver` to disable the video.

```C#
public void leave()
	{
		Debug.Log ("calling leave");
		if (mRtcEngine == null)
			return;
		// Leave the channel.
		mRtcEngine.LeaveChannel();
    // Disable the video.
		mRtcEngine.DisableVideoObserver();
	}
```

### 8. Destroy the IRtcEngine object

After leaving the channel, if you want to exit the app or release the memory, call `Destroy` to destroy the `IRtcEngine` object.

```C#
void OnApplicationQuit()
{
	if (mRtcEngine != null)
	{
	// Destroy the IRtcEngine object.
	IRtcEngine.Destroy();
    mRtcEngine = null;
	}
}
```

## Run the project

Run the project in Unity. When you set the role as the broadcaster and successfully join a voice broadcast, you can hear the voice of yourself in the app. When you set the role as the audience and successfully join a voice broadcast, you can hear the voice of the broadcaster in the app.