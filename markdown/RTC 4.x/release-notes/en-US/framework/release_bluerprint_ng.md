## Known issues

**Audio module incompatibility (iOS)**

The audio module of the Agora Unreal SDK is incompatible with the AudioMixer module in Unreal Engine 5.3 and 5.4. If you use Unreal Engine 5.3 or 5.4, you need to add the following code to the `/Config/IOS/IOSEngine.ini` file in your project to disable Unreal Engine’s AudioMixer module and avoid conflicts.

```ini
[Audio]
AudioMixerModuleName=
```

## v4.4.0

This version releases on August xx, 2024.

#### Compatibility changes

This version simplifies the way methods are called and callbacks are implemented in Blueprints.

**1. Method calls**

In this version, there is no need to manually maintain instance variables. You can directly retrieve the desired class at any point in your Blueprint using the `Get` node, and connect the appropriate function nodes to complete the call. This improvement makes calling methods in Blueprints more convenient and streamlines the development process.

![](img/rtc/ue-bp-release440-01.png)

The image below demonstrates how to obtain the [`IRtcEngine`](/api-ref/rtc/unreal-blueprint/API/rtc_interface_class#class_irtcengine) instance through the [`GetAgoraRtcEngine`](/api-ref/rtc/unreal-blueprint/API/toc_initialize#api_createagorartcengine) node and connect it to the [`Initialize`](/api-ref/rtc/unreal-blueprint/API/toc_initialize#api_irtcengine_initialize) node to perform the initialization.

![](img/rtc/ue-bp-release440-02.png)


**2. Callback implementation**

This version introduces the concept of `CallbackExecutor`. You can bind the corresponding `CallbackExecutor` in Blueprints using the `EventHandler`, allowing for the execution of callbacks. This improvement offers the following advantages:

- Callback implementation is more convenient.
- Enhanced security, with bound callbacks executing without causing crashes when destroyed.
- Easier reuse and code management.

![](img/rtc/ue-bp-release440-03.png)

The image below demonstrates how to obtain the `EventHandler` through the [`GetEventHandler`](/api-ref/rtc/unreal-blueprint/API/toc_initialize#api_irtcengine_geteventhandler) node and connect it to the [`AddBlueprintCallbackExecutor`](/api-ref/rtc/${frontMatter.ag_platform}/API/toc_initialize#api_irtcengine_addblueprintcallbackexecutor) node to bind the specified `CallbackExecutor`, thereby executing the related callbacks under the [`IRtcEngineEventHandler`](/api-ref/rtc/unreal-blueprint/API/rtc_interface_class#class_irtcengineeventhandler) interface class.

![](img/rtc/ue-bp-release440-04.png)


#### New features

1. **Voice AI tuner**

   This version introduces the voice AI tuner feature, which can enhance the sound quality and tone, similar to a physical sound card. You can enable the voice AI tuner feature by calling the `EnableVoiceAITuner` method and passing in the sound effect types supported in the `EVOICE_AI_TUNER_TYPE` enum to achieve effects like deep voice, cute voice, husky singing voice, etc.

2. **Privacy manifest file (iOS)**

   To meet Apple's safety compliance requirements for app publication, the SDK now includes a privacy manifest file, `PrivacyInfo.xcprivacy`, detailing the SDK's API calls that access or use user data, along with a description of the types of data collected.

   **Note:** If you need to publish an app with SDK versions prior to v4.4.0 to the Apple App Store, you must manually add the `PrivacyInfo.xcprivacy` file to your Xcode project.

3. **Multi-camera capture (Android)**

   This release introduces additional functionalities for Android camera capture:

   1. Support for capturing and publishing video streams from the third and fourth cameras:

      - `VIDEO_SOURCE_CAMERA_THIRD` (11) and `VIDEO_SOURCE_CAMERA_FOURTH` (12) in `EVIDEO_SOURCE_TYPE` add support for Android, specifically for the third and fourth camera sources. This change allows you to specify up to four camera streams when initiating camera capture by calling `StartCameraCapture`.
      - `publishThirdCameraTrack` and `publishFourthCameraTrack` in `FChannelMediaOptions` add support for Android. Set these parameters to `true` when joining a channel with `JoinChannelWithOptions` to publish video streams captured from the third and fourth cameras.

   2. Support for specifying cameras by camera ID:

      A new parameter `cameraId` is added to `FCameraCapturerConfiguration`. For devices with multiple cameras, where `cameraDirection` cannot identify or access all available cameras, you can obtain the camera ID through Android's native system APIs and specify the desired camera by calling `StartCameraCapture` with the specific `cameraId`.

4. **Select different audio tracks for local playback and streaming**

   This release introduces the `SelectMultiAudioTrack` method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the `OpenWithMediaSource` method and enable this function by setting the `EnableMultiAudioTrack` parameter in `FAgoraMediaSource`.

5. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - The `CONTENT_INSPECT_IMAGE_MODERATION` enumeration is added in `ECONTENT_INSPECT_TYPE` which means using video moderation extensions from Agora Extensions Marketplace to take video screenshots and upload them.
   - An optional parameter `serverConfig` is added in `FContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).
   
   Additionally, this version introduces the `EnableContentInspectEx` method, which supports simultaneous screenshot and upload of multiple video streams.

6. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert note">All 4.x SDKs support using wildcard tokens.</div>

7. **Preloading channels**

   This release adds `PreloadChannel` and `PreloadChannelWithUserAccount` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

8. **Publishing video streams from different sources** (Windows, macOS)

   This release adds the following members in `FChannelMediaOptions` to allow you publish video streams captured from the third and fourth camera or screen:

   - `publishThirdCameraTrack`: Publishing the video stream captured from the third camera.
   - `publishFourthCameraTrack`: Publishing the video stream captured from the fourth camera.
   - `publishThirdScreenTrack`: Publishing the video stream captured from the third screen.
   - `publishFourthScreenTrack`: Publishing the video stream captured from the fourth screen.

   <div class="alert note">For one <code>RtcConnection</code>, Agora supports publishing multiple audio streams and one video stream at the same time.</div>

#### Improvements

1. **Improved rendering usability**

    When using the UImage widget, you can control the size of the displayed image by setting the properties of the Brush. Starting from this version, the **Size To Content** option is supported, allowing UImage to automatically adjust to the size of the incoming video frames from the remote end. This improvement enhances the usability of image rendering.

    ![](img/rtc/ue-bp-release440-05.png)

2. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

#### Issues fixed

In Unreal Engine 5.3 and 5.4, adding the following code to the `/Source/xxx.Target.cs` file in your project to solve iOS memory allocation issues may lead to missing iOS compilation symbols. To address this issue, this version adds three function definitions (`StdMalloc`, `StdRealloc`, and `StdFree`) related to the standard library in the `UnrealMemory.cpp` file, ensuring proper handling of memory management needs when using the standard memory allocator. (iOS)

```csharp
if (Target.Platform == UnrealTargetPlatform.IOS)
{
    bOverrideBuildEnvironment = true;
    GlobalDefinitions.Add("FORCE_ANSI_ALLOCATOR=1");
}
```


## v4.2.1 

This version was released on October xx, 2023. 

This is the first release of Video SDK for Unreal Blueprint.

**Features**


Video SDK for Unreal Blueprint provides a simple and user-friendly real-time interactive solution for Unreal Engine users.

Video SDK for Unreal Blueprint offers a visual interface and a set of intuitive and easy-to-use nodes. This enables developers to effortlessly implement real-time interactive features in games or apps within the Unreal project. You don't need to know C++, just drag, connect and configure nodes.

**Reference**

To integrate real-time engagement functionality into your app using Video SDK for Unreal Engine, see:

- [Get Started with Voice Calling]()
- [Get Started with Video Calling]()
- [Get Started with Interactive Live Streaming Premium]()
- [Get Started with Interactive Live Streaming Standard]()
- [API Reference]()

Agora provides the open source [example project](https://github.com/AgoraIO-Extensions/Agora-Unreal-RTC-SDK/tree/main/Agora-Unreal-SDK-Blueprint-Example) on GitHub for your reference.
