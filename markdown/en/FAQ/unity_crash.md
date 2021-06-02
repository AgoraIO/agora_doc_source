---
title: Why do crashes occur on Unity SDK v3.0.1 or earlier?
platform: ["Unity"]
updatedAt: 2021-01-06 09:06:20
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Problem

When using the Unity SDK v3.0.1 or earlier, blank screen or even crashes occur if access to the microphone or camera is not granted. This issue occur on various platfroms including macOS and Android.

## Reason

The reason for this issue is that permission to the system microphone or camera is not granted. 

Since macOS 10.14, Apple enforces stricter provicy guards. If the permission for microphone or camera usage is not properly set, apps crash. 

## Solution

The SDK does not detect whether such permissions are set. To avoid this issue, ensure that you set camera and microphone permissions in your **Unity Edtior**. Go to **File** -> **Build Settings** -> **Player Settings**. On the **Player** interface, click **Other Settings**, and add descriptions to **Camera Usage Description** and **Microphone Usage Description**.

