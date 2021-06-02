---
title: Upgrade to v3.0.1 on iOS/macOS
platform: iOS
updatedAt: 2020-06-01 15:26:41
---
This article describes the library changes of the Agora RTC SDK for iOS and macOS, and how to upgrade to v3.0.1 from versions with the static library.

<div class="alert note">If you have integrated the v3.0.0 SDK with the dynamic library, you do not need to reintegrate the SDK.</div>

## Library changes 

As of v3.0.1, the SDK includes only the dynamic library `AgoraRtcKit.framework`. You can go to [SDK Downloads](https://docs.agora.io/en/Agora%20Platform/downloads) to download the v3.0.1 SDK. The following table lists the libraries among different versions:

| SDK version         | Library name      | Library type                  |
| :------------------ | :---------------- | :---------------------------- |
| v3.0.1 or later     | `AgoraRtcKit`       | Dynamic library               |
| v3.0.0              | `AgoraRtcKit`       | <li>Dynamic library<li>Static library</li> |
| Earlier than v3.0.0 | `AgoraRtcEngineKit` | Static library                |

## Upgrade from v3.0.0 with static library

1. Copy `AgoraRtcKit.framework` from the v3.0.1 SDK to the path of your project and replace the original one.

2. Open Xcode (take Xcode 11.0 as an example), go to the **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** menu, and click **-** to remove the following libraries:

| Operating system | Library name                                                 |
| :--------------- | :----------------------------------------------------------- |
| iOS              | <li>`Accelerate.framework`<li>`AudioToolbox.framework`<li>`AVFoundation.framework`<li>`CoreMedia.framework`<li>`libc++.tbd`<li>`libresolv.tbd`<li>`SystemConfiguration.framework`<li>`CoreTelephony.framework`<li>`CoreML.framework`<li>`VideoToolbox.framework`</li> |
| macOS            | <li>`Accelerate.framework`<li>`CoreWLAN.framework`<li>`libc++.tbd`<li>`libresolv.9.tbd`<li>`SystemConfiguration.framework`<li>`VideoToolbox.framework`</li> |
 
 <div class="alert note"><li>On iOS, <tt>CoreTelephony.framework</tt> only applies to the Agora Voice SDK, <tt>CoreML.framework</tt> and <tt>VideoToolbox.framework</tt> only apply to the Agora Video SDK.<li>On macOS, <tt>VideoToolbox.framework</tt> only applies to the Agora Video SDK.</li></div>

3. Change the status of `AgoraRtcKit.framework` to **Embed & Sign**.

## Upgrade from versions earlier than v3.0.0

1. Open Xcode (take Xcode 11.0 as an example), remove `AgoraRtcEngineKit.framework` from the **Navigator**.

2. Go to the **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** menu, and click **-** to remove the following libraries:

| Operating system | Library name                                                 |
| :--------------- | :----------------------------------------------------------- |
| iOS              | <li>`Accelerate.framework`<li>`AudioToolbox.framework`<li>`AVFoundation.framework`<li>`CoreMedia.framework`<li>`libc++.tbd`<li>`libresolv.tbd`<li>`SystemConfiguration.framework`<li>`CoreTelephony.framework`<li>`CoreML.framework`<li>`VideoToolbox.framework`</li> |
| macOS            | <li>`Accelerate.framework`<li>`CoreWLAN.framework`<li>`libc++.tbd`<li>`libresolv.9.tbd`<li>`SystemConfiguration.framework`<li>`VideoToolbox.framework`</li> |
 
 <div class="alert note"><li>On iOS, <tt>CoreTelephony.framework</tt> only applies to the Agora Voice SDK, <tt>CoreML.framework</tt> and <tt>VideoToolbox.framework</tt> only apply to the Agora Video SDK.<li>On macOS, <tt>VideoToolbox.framework</tt> only applies to the Agora Video SDK.</li></div>

3. Click **+**, and then click **Add Other...** to add `AgoraRtcKit.framework` of the v3.0.1 SDK.

4. Change the status of `AgoraRtcKit.framework` to **Embed & Sign**.