---
title: Why do errors occur when calling the Stream.init method?
platform: ["Web"]
updatedAt: 2020-12-23 08:07:53
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
The following are common errors when initializing the stream:

- `NotAllowedError`: The user refuses to grant access to the video or audio resource.
- `NotReadableError`: Although the user has granted permission to use the matching devices, a hardware error occurrs at the operating system, browser, or web page level, which prevents access to the device. Try refreshing the page or updating the device driver. On some Windows 10 laptops, you need to run Chrome in compatibility mode with Windows 7 to use the camera.
- `NotFoundError`: Cannot find the specified media track. Ensure that your media device is working.
- `MEDIA_NOT_SUPPORT`: Use HTTPS for your web app.
- `OverConstrainedError`: A specified constraint cannot be satisfied by any available device, mostly because the requested capture device is occupied or the specified resolution is not supported.

See [`Stream.init`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/v3.3.1/interfaces/agorartc.client.html#init) for more errors.