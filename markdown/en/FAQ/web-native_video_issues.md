---
title: How can I fix black, green, or pixelated video when a Web client and a Native client communicate with each other?
platform: ["Web"]
updatedAt: 2021-03-30 03:26:54
Products: ["Video","Interactive Broadcast","live-streaming"]
---
## Problem

When a Web client and a Native client communicate with each other the receiving end sees a black, green, or pixelated screen.

## Reason

The Native SDK encodes video streams in the H.264 format, and the issue is mainly caused by errors decoding the H.264 video streams.

## Solution

Troubleshoot the problem by following the steps below:

1. Call `getSupportedCodec` to get the codecs supported by both the Web SDK and the browser. If H.264 is not supported, the Web client cannot communicate with the Native client.

2. Ask the user to use the latest official version of the Chrome browser, and disable the hardware‑accelerated video decoding and encoding:

   1. Enter `chrome://flags` in the browser address bar.
   2. Set both **Hardware-accelerated video decode and Hardware-accelerated video encode** as **Disabled**.
   3. Click **Relaunch** to restart the browser, as shown in the figure below:
       ![](https://web-cdn.agora.io/docs-files/1616748192326)
      
3. Upgrade the Native SDK to the latest version.

4. If the client sending the video stream is a Web client on desktop, ask the user to launch Chrome with the following command:

   **Windows**

   ```shell
   chrome.exe --forcefieldtrials="WebRTCSpsPpsIdrIsH264Keyframe/Enabled/"
   ```

   **macOS**

   ```shell
   /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --force-fieldtrials="WebRTC-SpsPpsIdrIsH264Keyframe/Enabled/"
   ```

## See also

- [How can I fix black screen issues?](https://docs.agora.io/en/faq/video_blank)
- [Why is my video pixelated or jagged and green?](https://docs.agora.io/en/faq/pixelated_green_video)