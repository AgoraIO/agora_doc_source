---
title: Create and Initialize an Agora Instance
platform: Android
updatedAt: 2019-10-22 14:19:07
---
Before creating an RtcEngine instance, ensure that you have finished preparing the development environment. See [Integrate the SDK](/en/Video/android_video) for more information.

## Implementation
The following imports define the interface of the Agora API that provides  communication functionality:

-   `io.agora.rtc.Constants`
-   `io.agora.rtc.IRtcEngineEventHandler`
-   `io.agora.rtc.RtcEngine`
-   `io.agora.rtc.video.VideoCanvas`

Create a singleton instance by invoking the `create` method during initialization. In the `create` method:

-  Pass the Agora App ID. Only apps with the same App ID can join the same channel.
-  Specify a reference to the activity’s event handler. The Agora API uses callbacks to inform the app about Agora engine runtime events, such as joining or leaving a channel and adding users.

```
import io.agora.rtc.Constants;
import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;

...

private void initializeAgoraEngine() {
    try {
        mRtcEngine = RtcEngine.create(getBaseContext(), getString(R.string.agora_app_id), mRtcEventHandler);
    } catch (Exception e) {
        Log.e(LOG_TAG, Log.getStackTraceString(e));

        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
}
```

> Ensure that you call the `create` method to intiialize the AgoraRtcEngine before calling any other API. 

## Next Steps
You have now finished creating the RtcEngine instance and can start a voice call with the following steps:
* [Join a Channel](/en/Video/join_video_android)
* [Publish and Subscribe to Streams](/en/Video/publish_android)

For added requirements on network connection or audio quality, you can also take the following steps before joining a channel:
* [Conduct a Last mile Test](/en/Video/lastmile_android)
* [Set the Stereo/High-fidelity Audio Profile](/en/Video/audio_profile_android)