---
title: How can I solve the quality issues of screen sharing on Web clients?
platform: ["Web"]
updatedAt: 2021-03-26 08:58:19
Products: ["Video","Interactive Broadcast","live-streaming"]
---
## Problem

When a Web client shares the screen, the screen freezes or blurs.

## Solution

Find the solution that corresponds to the version of the Web SDK you are using.

### Web 3.x

Troubleshoot the problem by following the steps below:

1. Ask the user to use the latest official version of the Chrome browser on desktop.
2. Set codec as `vp8` when calling `createClient`.
3. Check whether the user is sharing an application window.
   - If so, ask the user to share the browser tab or the entire screen instead.
   - If not, check the encoding configurations you set in `setScreenProfile`.
4. Upgrade the SDK to 3.2.0 or later versions, and set [optimizationMode](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.streamspec.html#optimizationmode) when creating the stream for screen-sharing. Choose the appropriate transmission optimization mode according to the shared content: 
   - If the shared content is mainly slides, texts, or static images, set `optimizationMode` as `"details"`.
   - If the shared content is mainly videos or games, set `optimizationMode` as `"motion"`.

### Web 4.x

Troubleshoot the problem by following the steps below:

1. Ask the user to use the latest official version of the Chrome browser on desktop.
2. Set codec as `vp8` when calling `createClient`.
3. Check whether the user is sharing an application window.
   - If so, ask the user to share a browser tab or the entire screen.
   - If not, check the encoding configurations you set in `createScreenVideoTrack`.
4. Set [optimizationMode](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/screenvideotrackinitconfig.html#optimizationmode) when creating the video track for screen sharing, and choose the appropriate transmission optimization mode according to the shared content:
   - If the shared content is mainly slides, texts, or static images, set `optimizationMode` as "details".
   - If the shared content is mainly videos or games, set `optimizationMode` as `"motion"`.

     <div class="alert info">As of v4.2.0, you can change the transmission optimization mode during a screen sharing session by calling <a href="https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/ilocalvideotrack.html#setoptimizationmode">setOptimizationMode</a>.</div>

## See also

-  [Share Screen (Web 3.x)](https://docs.agora.io/en/Interactive%20Broadcast/screensharing_web?platform=Web)
- [Share Screen (Web 4.x)](https://docs.agora.io/en/Interactive%20Broadcast/screensharing_web_ng?platform=Web)
-  [How can I switch between the screen-sharing stream and the camera stream?](https://docs.agora.io/en/faq/switch_screen_camera_web)