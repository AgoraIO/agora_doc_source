---
title: How to deal with the failure to send video streams on Chrome 88?
platform: ["Web"]
updatedAt: 2021-02-02 11:18:50
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Problem
When using the Agora Web SDK on macOS Chrome 88, you may fail to send video streams.

## Reason
Chrome 88 on macOS has a known issue: WebRTC cannot successfully send video streams when hardware acceleration is disabled or unavailable. This issue affects all versions of the Agora Web SDK, and the affected macOS versions include Sierra and Mojave. For details, see the [Chromium documentation](https://bugs.chromium.org/p/chromium/issues/detail?id=1168948).

## Solution
Agora recommends not using Chrome 88 before Google fixes this issue. Use other versions of Chrome or other browsers supported by the Agora Web SDK.