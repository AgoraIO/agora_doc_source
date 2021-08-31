## Join Multiple Channels

The Agora Video SDK enables users to join an unlimited number of channels at the same time and  receive the audio and video streams of all the channels.

## Understand the tech

The SDK uses the `RtcConnection` and  `RtcEngineEx` classes to support the multi-channel functionality. `RtcEngineEx`  provides methods that apply to a specific `RtcConnection` object.

An `RtcConnection` object contains the following information to identify a connection:

- The channel name
- The ID of the local user

You can create multiple `RtcConnection` objects, each with a different channel name and user ID.

To join multiple channels, call `joinChannelEx` in the `RtcEngineEx` class multiple times with different `RtcConnection` objects.

- Ensure that each `RtcConnection` object has a unique user ID that is not `0`.
- You can configure the publishing and subscribing options for the `RtcConnection` object in `joinChannelEx`.
- Each `RtcConnection` can publish mutiple audio streams and a unique video stream independently.


## Prerequisites

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_android) or [Start Interactive Live Streaming](start_live_android).

## Implementation

To implement the multi-channel functionality, do the following for each channel:

1. In your Agora project, define an `RtcConnection` object in the main file.

   ```java
   private RtcConnection rtcConnection2 = new RtcConnection();
   ```

2. Join a channel with a random user ID.

   ```java
   private boolean joinSecondChannel() {
       ChannelMediaOptions mediaOptions = new ChannelMediaOptions();
       mediaOptions.autoSubscribeAudio = true;
       mediaOptions.autoSubscribeVideo = true;
       rtcConnection2.channelId = channel2;
       rtcConnection2.localUid = new Random().nextInt(512)+512;
       int ret = engine.joinChannelEx("your token",rtcConnection2,mediaOptions,iRtcEngineEventHandler2);
       return (ret == 0);
   }
   ```

3. Listen for events of `rtcConnection2` and set up the remote video in the `onUserJoined` callback.

   ```java
   private final IRtcEngineEventHandler iRtcEngineEventHandler2 = new IRtcEngineEventHandler() {
       @Override
       public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
           Log.i(TAG, String.format("channel2 onJoinChannelSuccess channel %s uid %d", channel2, uid));
           showLongToast(String.format("onJoinChannelSuccess channel %s uid %d", channel2, uid));
       }
       @Override
       public void onUserJoined(int uid, int elapsed) {
           Log.i(TAG, "channel2 onUserJoined->" + uid);
           showLongToast(String.format("user %d joined!", uid));
           /**Check if the context is correct*/
           Context context = getContext();
           if (context == null) {
               return;
           }
           handler.post(() ->
           {
               // Display remote video stream
               SurfaceView surfaceView = null;
               if (fl_remote2.getChildCount() > 0) {
                   fl_remote2.removeAllViews();
               }
               // Create render view by RtcEngine
               surfaceView = new SurfaceView(context);
               surfaceView.setZOrderMediaOverlay(true);
               // Add to the remote container
               fl_remote2.addView(surfaceView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
   
               // Setup remote video to render
               engine.setupRemoteVideoEx(new VideoCanvas(surfaceView, RENDER_MODE_FIT, uid), rtcConnection2);
           });
       }
   
   };
   ```

## Reference

This section provides the reference information you might need when implementing the multi-channel functionality.


### API reference
- [RtcEngineEx](./API%20Reference/java_ng/API/class_irtcengineex.html)
- [joinChannelEx](./API%20Reference/java_ng/API/class_irtcengineex.html#api_joinchannelex)
- [setupRemoteVideoEx](./API%20Reference/java_ng/API/class_irtcengineex.html#api_setupremotevideoex)

### Sample project

Agora provides an open-source sample project [JoinMultipleChannel](https://github.com/AgoraIO/API-Examples/blob/4.0.0-preview/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/JoinMultipleChannel.java) on GitHub. You can download it and refer to the source code.
