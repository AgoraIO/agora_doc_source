
This page introduces the main steps to upgrade the [Unreal C++ SDK](https://github.com/AgoraIO-Community/Agora-Unreal-SDK) from v3.x (v3.5.0.4) to v4.x, as well as the related changes.

### 1. Integrate the SDK

See [Project setup]() for more information about integrating the v4.0.0 SDK into your project.


### 2. Update the Agora code in your app

This section introduces the main changes between v3.x and v4.2.1. In order to retain Agora functionality in your app, update the code in your app according to your scenarios.

**Basic changes**

The Unreal C++ SDK is built on top of the Native C++ SDK, it includes all the changes from Native SDK v3.x to v4.x. For specific details about these changes, see [Migrate from Video SDK 3.x]().

**Other changes**
- The `agora::rtc::ue4::AgoraRtcEngine*` interface class is changed to `agora::rtc::ue::RtcEngineProxy*`, you need to update the code in the  project files.
- The v4.x SDK simplifies the implementation steps for video rendering, eliminating the need to actively call the `OnTick` function in `AgoraRtcEngine`. Instead, it is automatically handled by the `VideoRenderManager` function. Therefore, you need to manually remove any code related to `OnTick` from your project files.
- Modify the project folder and add a reference to the header file `#include "AgoraPluginInterface.h"` to directly import all the basic classes from the v4.x SDK. Depending on your specific needs, you can also supplement the required classes in `AgoraPlugin\Private\AgoraCppPlugin\include\AgoraHeaderBase.h`, or directly include the necessary files.
