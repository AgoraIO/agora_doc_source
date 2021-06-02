---
title: How can I fix unsynchronized audio and video?
platform: ["Android","iOS","macOS","Windows","Web","Unity","Electron","React Native","Flutter"]
updatedAt: 2020-07-07 20:39:34
Products: ["Video","Interactive Broadcast"]
---
Unsynchronized audio and video may be caused by the following:

- Slow network connection.
- Sub-optimal device performance.
- Problems with a custom video source or renderer.
- A third-party image enhancement SDK.

Complete the following steps to troubleshoot the unsynchronized audio and video.

## Step 1: Self-check

Check the following:

- Check whether the unsynchronized audio and video is intermittent or consistent. Occasional, intermittent unsynchronized audio and video is normal due to the nature of the network and device.

- If you use a custom video source, check whether the `timeStamp` parameter of each video frame is correct. Ensure that you are using millisecond units. 

  <div class="alert note">If you use a camera to capture video, the system reports the timestamp of each video frame. That is the value you need to pass in <code>timeStamp</code>.</div>

- Check whether the network connection is stable. You can switch to another network connection and check if the audio and video are synchronized. 

- If you use a third-party image enhancement SDK, disable it and re-check. If the audio and video become synchronized, then the third-party image enhancement SDK is the likely cause. Contact that SDK provider for technical support.

- Switch to another device with better performance, and then check if the issue persists.

- If you use a custom video renderer, check the source code of the video renderer. See the [Customer renderer](https://github.com/AgoraIO/Advanced-Video/tree/master/Android/sample-custom-render) sample project provided by Agora for reference.

## Step 2: Contact Agora customer support

If the issue persists, contact [support@agora.io](mailto:support@agora.io). Please provide the following information to help with the troubleshooting:

- The channel name with the unsynchronized audio and video.

- The time frame when the unsynchronized audio and video appears.

- The application scenario in which the issue occurs: communication, live interactive streaming, single-hosted interactive streaming, or co-hosted interactive streaming scenario.

- The UIDs of the users sending and receiving the unsynchronized audio and video.

- Whether you use a custom video source or a custom video renderer.

- Whether the problem can be reproduced and the steps to reproduce.

- Screen recording files.

- SDK log files. See [How can I set the log file?](https://docs.agora.io/en/faq/logfile)

  