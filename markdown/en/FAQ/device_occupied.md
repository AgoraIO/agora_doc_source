---
title: Why does the SDK stops sending audio or video after the user uses a third-party app?
platform: ["Android","Web"]
updatedAt: 2020-07-09 22:07:10
Products: ["Voice","Video","Interactive Broadcast"]
---
### When a third-party recording app is being used on the Android device, the local user cannot send the local audio stream. Why is there no warning or error message from the SDK?

We recommed referring to the following logic when implementing your code:

Before the user joins the channel, use the Android native methods to get the status of the audio recorder. When the audio recorder is available, if, within 6 seconds after the user joins the channel, the app receives the following codes, the SDK  decides that the recording device is occupied:

- The warning code WARN_ADM_RECORD_AUDIO_LOWLEVEL(1031), triggered multiple times.
-  The error code ERR_ADM_RECORD_AUDIO_IS_ACTIVE(1033).

You can remind your user to quit the third-party recording app before using yours.

### I cannot send audio/video after switching to other apps and back during a call using the Agora Web SDK.

**Issue**: If you switch to another app (for example answering a FaceTime call) during a web call, you cannot send any audio/video after switching back to the call.

**Reason**: A third-party application, such as FaceTime, takes over the audio/video device and your device may fail to send audio/video after resuming your web call.

**Solution**: Refresh the web page.

