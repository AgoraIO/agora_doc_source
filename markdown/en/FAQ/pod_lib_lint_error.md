---
title: Why do I receive error messages after integrating the iOS SDK through CocoaPods and run the pod lib lint command?
platform: ["iOS"]
updatedAt: 2021-03-17 07:00:24
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Problem

On Xcode 12 or later, if you integrate the iOS SDK 3.3.0 or later through CocoaPods and run the `pod lib lint` command, you may receive the following error message:

```shell
[iOS] xcodebuild: warning: [CP] Unable to find matching .xcframework slice in ' true ios-armv7_arm64/AgoraRtcKit.framework ios-x86_64-simulator/AgoraRtcKit.framework' for the current build architectures (arm64 x86_64).
```

## Reason

CocoaPods is not compatible with Xcode 12 or later versions, so the `.xcframework` frameworks cannot be linked in your project.

## Solution

To solve the problem, do the following:

1. Install a version earlier than Xcode 12 (for example, Xcode 11).

2. In Terminal, run the following command to switch the Xcode version.

   ```shell
   // Replaces <xcode_path> with the path of Xcode 11. 
   sudo xcode-select -s <xcode_path>
   ```

3. Run the `pod lib lint` command to check whether the `.xcframework` framework is successfully linked.