---
title: Start a Voice Call
platform: Unity
updatedAt: 2021-01-06 09:05:59
---
Use this guide to quickly start a basic one-to-one voice call with the Agora SDK for Unity.

## Try the sample project

We provide an open-source [Hello-Unity3D-Agora](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/audio/Hello-Unity3D-Agora) sample project on GitHub that implements the basic one-to-one voice call. You can also see how to run the sample project in [Add voice chat to your Unity app on Android and iOS](https://medium.com/agora-io/add-voice-chat-to-your-unity-game-2194dbcf6eff).

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

## Implement a basic voice call

This section provides instructions on using the Agora Voice SDK for Unity to implement a basic one-to-one voice call, as well as an API call sequence diagram.

![](https://web-cdn.agora.io/docs-files/1576224830638)

### 1. Create the UI

Create the user interface (UI) for a voice call in your project. If you already have one UI in your project, skip to [Get the device permission (Android only)](#permission) or [Initialize IRtcEngine](#initialize).

We recommend adding the following elements to the UI:

- An enter button
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

Create and initialize the `IRtcEngine` object before calling any other Agora APIs.

Call the `GetEngine` method and pass in the App ID to initialize the `IRtcEngine` object.

<div class="alert note">If you want to exit the app or release the memory of <tt>IRtcEngine</tt>, call <tt>Destroy</tt> to destroy the <tt>IRtcEngine</tt> object. See details in <a href="#destroy">Destroy the IRtcEngine object</a >.</div>

Listen for callback events, such as when the local user joins the channel, and when the first audio frame of a remote user is decoded.

```C#
// Pass an App ID to create and initialize an IRtcEngine object.
mRtcEngine = IRtcEngine.GetEngine (appId); 
// Listen for the OnJoinChannelSuccessHandler callback.
// This callback occurs when the local user successfully joins the channel.
mRtcEngine.OnJoinChannelSuccessHandler = OnJoinChannelSuccessHandler; 
// Listen for the OnUserJoinedHandler callback.
// This callback occurs when the first audio frame of a remote user is received and decoded after the remote user successfully joins the channel.
mRtcEngine.OnUserJoinedHandler = OnUserJoinedHandler; 
// Listen for the OnUserOfflineHandler callback.
// This callback occurs when the remote user leaves the channel or drops offline.
mRtcEngine.OnUserOfflineHandler = OnUserOfflineHandler;
```

### 4. Join a channel

After initializing the `IRtcEngine` object, you can call `JoinChannelByKey` to join a channel. Set the following parameters when calling this method::

- `channelKey`: The token for identifying the role and privileges of a user. Set it as one of the following values:

  - `NULL`.
  - A temporary token generated in Agora Console. A temporary token is valid for 24 hours. For details, see [Get a temporary token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token).
  - A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](https://docs.agora.io/en/Video/token_server).

  <div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>

- `channelName`: The unique name of the channel to join. Users that input the same channel name join the same channel.

- `uid`: Integer. The unique ID of the local user. If you set `uid` as 0, the SDK automatically assigns one user ID and returns it in the `OnJoinChannelSuccessHandler` callback.

```C#
// Join a channel. 
mRtcEngine.JoinChannelByKey(null, channel, null, 0);
```

### 5. Leave the channel

According to your scenario, such as when the call ends and when you need to close the app, call `LeaveChannel` to leave the current call.

```C#
public void leave()
	{
		Debug.Log ("calling leave");
		if (mRtcEngine == null)
			return;
		// Leave the channel.
		mRtcEngine.LeaveChannel();
	}
```

<a name="destroy"></a>
### 6. Destroy the IRtcEngine object

After leaving the channel, if you want to exit the app or release the memory of `IRtcEngine`, call `Destroy` to destroy the `IRtcEngine` object.

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

### Sample code

You can find the complete code in the [HelloUnity3D.cs](https://github.com/AgoraIO/Agora-Unity-Quickstart/blob/master/audio/Hello-Unity3D-Agora/Assets/HelloUnity3D.cs) file in the [Hello-Unity3D-Agora](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/audio/Hello-Unity3D-Agora) sample project.

## Run the project

Run the project in Unity. You can hear the voice of both the local and remote users when you successfully start a one-to-one voice call in the app.