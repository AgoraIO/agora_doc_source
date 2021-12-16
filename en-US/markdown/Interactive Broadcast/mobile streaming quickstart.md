This page shows how to start mobile streaming with the Agora SDK. In a live streaming channel, a user joins a live streaming channel as either the host or an audience member. 

Agora also provides an open-source [sample project](https://github.com/AgoraIO/API-Examples/tree/dev/rsk/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/CDNStreaming) for your reference.

<div class="alert note">
The domain name used in the sample project is for demonstration purposes only. In a production context, ensure you use domain names appropriate for production.
</div>


## Prerequisites

- Android Studio 3.0 or higher.
- Android SDK API Level 16 or higher.
- A mobile device that runs Android 4.1 or later.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms) and [App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> to avoid difficulties when using Agora products and services.</div>

## Project setup

### Create an Android project

To create a new Android project, follow these steps.

 <div class="alert note"> If you have already created a project, see [Integrate the Agora SDK into your project](#integrate_sdk) for the next step.</div>

<details>
	<summary><font color="#3ab7f8">Create an Android project</font></summary>

1. In **Android Studio**, click **Start a new Android Studio project**.
2. In the **Select a Project Template** page, select **Phone and Tablet** > **Empty Activity** and click **Next**.
3. In the <b>Configure Your Project</b> page, you need to fill in the following information：
  *  <b>Name</b>: Set the name of your project. For example, *HelloAgora*.
  * <b>Package name</b>: Set the package name of your project. For example, *io.agora.helloagora*.
  * <b>Save location</b>：Select the directory where your project is saved.
  * <b>Language</b>：Select the programming language. For example,  Java.
  * <b>Minimum API level</b>: The minimum API level for your project.

4. Click <b>Finish</b>. 

<div class="alert info">This quickstart uses <b>Android Studio 3.6.2.</b> for demonstration. You can also refer to the Android Studio documentation<a href="https://developer.android.com/training/basics/firstapp"> to build your first app</a>.</div>

</details>

<a name="integrate_sdk"></a>

### Integrate the Agora SDK into your project

To Integrate the SDK into your project, take the following steps:

1. Download the latest version of the Agora Chat SDK for Android, and extract the files from the downloaded SDK package.

2. Copy the following files or subfolders from the **libs** folder of the downloaded SDK to the corresponding directory of your project:

   | File or subfolder        | Directory of your project |
   | :----------------------- | :------------------------ |
   | `agora-rtc-sdk.jar` file | `/app/libs/`              |
   | `arm-v8a` folder         | `/app/src/main/jniLibs/`  |
   | `armeabi-v7a` folder     | `/app/src/main/jniLibs/`  |
   | `x86` folder             | `/app/src/main/jniLibs/`  |
   | `x86_64` folder          | `/app/src/main/jniLibs/`  |

   > If you use the armeabi architecture, copy files from the `armeabi-v7a` folder to the `armeabi` file of your project. Contact [support@agora.io](mailto: support@agora.io) if you encounter any compatibility issues.

### Add permissions

In `/app/src/main/AndroidManifest.xml`, add the following permissions according to your scenarios:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
   package="io.agora.tutorials1v1acall">

   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   <uses-permission android:name="android.permission.BLUETOOTH" />
...
</manifest>
```

## Implement the host's client for mobile streaming

This section shows how to implement the following functions on the host's client:

- In the single host scenario, the host pushes streams to the CDN directly.

- The host switches between pushing streams to the CDN to co-hosting across channels. 

### Create the UI

To create the UI for the host's client, Agora recommends adding the following UI elements:

- The video view of the host.
- A button to start and end the streaming.
- A button to switch to cohosting across channels.

You can also refer to the `fragment_cdn_host.xml` file in the sample project.

### Import classes

To import Agora classes, add the following lines in the `Activity` file of your project:   

```java
import io.agora.rtc2.ChannelMediaOptions;
import io.agora.rtc2.Constants;
import io.agora.rtc2.DirectCdnStreamingError;
import io.agora.rtc2.DirectCdnStreamingMediaOptions;
import io.agora.rtc2.DirectCdnStreamingState;
import io.agora.rtc2.IDirectCdnStreamingEventHandler;
import io.agora.rtc2.IRtcEngineEventHandler;
import io.agora.rtc2.LeaveChannelOptions;
import io.agora.rtc2.RtcEngine;
import io.agora.rtc2.RtcEngineConfig;
import io.agora.rtc2.live.LiveTranscoding;
import io.agora.rtc2.video.VideoCanvas;
import io.agora.rtc2.video.VideoEncoderConfiguration;

import static io.agora.rtc2.Constants.CLIENT_ROLE_BROADCASTER;
import static io.agora.rtc2.Constants.RENDER_MODE_HIDDEN;
import static io.agora.rtc2.video.VideoEncoderConfiguration.STANDARD_BITRATE;
```

### Handle the Android permissions

To check whether the permissions necessary to add mobile streaming functionality into the app are granted, call the `checkSelfPermission` method to access the microphone and camera of the Android device when launching the Activity.

```java
private static final int PERMISSION_REQ_ID = 22;

// Check the microphone and camera access when running the app.
private static final String[] REQUESTED_PERMISSIONS = {
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.CAMERA
};

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_video_chat_view);

    // Initialize RtcEngine and join a channel after getting the permission.
    if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
            checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID)) {
        initEngineAndJoinChannel();
    }
}

private boolean checkSelfPermission(String permission, int requestCode) {
    if (ContextCompat.checkSelfPermission(this, permission) !=
            PackageManager.PERMISSION_GRANTED) {
        ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
        return false;
    }

    return true;
}
```

### The host pushes streams to the CDN

The following figure shows the API call sequence of the host pushing streams to the CDN directly.

![](https://web-cdn.agora.io/docs-files/1638428760225)

#### Initialize RtcEngine

```java
@Override
public void onActivityCreated(@Nullable Bundle savedInstanceState) {
    super.onActivityCreated(savedInstanceState);
    Context context = getContext();
    if (context == null) {
        return;
    }
    try {

        RtcEngineConfig config = new RtcEngineConfig();
        config.mContext = context.getApplicationContext();
        // Pass in App ID.
        config.mAppId = getString(R.string.agora_app_id);
        // Set channel profile as live streaming.
        config.mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
        // Register callback events for which you want to listen.
        config.mEventHandler = iRtcEngineEventHandler;
        // Initialize RtcEngine.
        engine = RtcEngine.create(config);
        setupEngineConfig(context);
    } catch (Exception e) {
        e.printStackTrace();
        getActivity().onBackPressed();
    }
}
```

#### Configurations

```java
private void setupEngineConfig(Context context) {
    SurfaceView surfaceView = RtcEngine.CreateRendererView(context);
    if (fl_local.getChildCount() > 0) {
        fl_local.removeAllViews();
    }
    fl_local.addView(surfaceView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
    // Enable the vide module and start local video preview.
    // Start the local video preview.
    engine.setupLocalVideo(new VideoCanvas(surfaceView, RENDER_MODE_HIDDEN, 0));
    engine.startPreview();
    engine.enableVideo();
    // Set the audio output to the speaker.
    engine.setDefaultAudioRoutetoSpeakerphone(true);
    // Set the user role as host.
    engine.setClientRole(IRtcEngineEventHandler.ClientRole.CLIENT_ROLE_BROADCASTER);
    // Set the video profile of the host.
    engine.setDirectCdnStreamingVideoConfiguration(videoEncoderConfiguration);
}
```

#### Start pushing streams to the CDN

```java
private int startCdnStreaming() {
    DirectCdnStreamingMediaOptions directCdnStreamingMediaOptions = new DirectCdnStreamingMediaOptions();
    // Publish video streams captured by the camera when the host in the channel starts live streaming.
    directCdnStreamingMediaOptions.publishCameraTrack = true;
    // Publish audio streams captured by the microphone when the host in the channel starts live streaming.
    directCdnStreamingMediaOptions.publishMicrophoneTrack = true;
    return engine.startDirectCdnStreaming(iDirectCdnStreamingEventHandler, getUrl(), directCdnStreamingMediaOptions);
}
```

#### Stop pushing streams to the CDN

```java
@Override
public void onDestroy() {
    super.onDestroy();
    if (engine != null) {
        if (rtcStreaming) {
            engine.leaveChannel();
        } else if (cdnStreaming) {
            engine.stopDirectCdnStreaming();
        }
        engine.stopPreview();
        handler.post(RtcEngine::destroy);
        engine = null;
    }
}
```

### Switch between scenarios

The following figure shows the API call sequence of the host switching from pushing streams to the CDN directly to cohosting across channels.

![](https://web-cdn.agora.io/docs-files/1638435980075)

The following figure shows the API call sequence of the host switching from cohosting across channels to pushing streams to the CDN directly.

![](https://web-cdn.agora.io/docs-files/1638437800143)

#### Logic for switching between single host and cohosting scenarios

```java
private void stopStreaming(){
    rtcStreaming = false;
    cdnStreaming = false;
    rtcSwitcher.setChecked(false);
    rtcSwitcher.setEnabled(false);
    streamingButton.setText(getString(R.string.start_live_streaming));
}

private final View.OnClickListener streamingOnCLickListener = new View.OnClickListener() {
    @Override
    public void onClick(View view) {
        // In this sample code, rtcStreaming is defined as cohosting across channels.
        if (rtcStreaming){
            engine.removePublishStreamUrl(getUrl());
            engine.leaveChannel();
            stopStreaming();
        }
        // In this sample code, cdnStreaming is defined as the host pushing streams to the CDN directly.
        else if (cdnStreaming) {
            engine.stopDirectCdnStreaming();
            engine.startPreview();
            rtcSwitcher.setChecked(false);
            rtcSwitcher.setEnabled(false);
        } else {
            engine.setDirectCdnStreamingVideoConfiguration(videoEncoderConfiguration);
            int ret = startCdnStreaming();
            if (ret == 0) {
                streamingButton.setText(R.string.text_streaming);
            }
            else{
                showLongToast(String.format("startCdnStreaming failed! error code: %d", ret));
            }
        }
    }
};
```

#### Start live streaming in the channel

```java
@Override
public void onDirectCdnStreamingStateChanged(DirectCdnStreamingState directCdnStreamingState, DirectCdnStreamingError directCdnStreamingError, String s) {
    handler.post(new Runnable() {
        @Override
        public void run() {
            switch (directCdnStreamingState) {
                case STARTED:
                    streamingButton.setText(R.string.stop_streaming);
                    cdnStreaming = true;
                    break;
                case STOPPED:
                    if(rtcStreaming){
                        // Set the video profile of the host in the channel.
                        // This step is optional in a single host scenario, but it is necessary if you need to swtich from a single host scenario to cohosting across channels.
                        VideoEncoderConfiguration.VideoDimensions videoDimensions = ((MainApplication) getActivity().getApplication()).getGlobalSettings().getVideoEncodingDimensionObject();
                        canvas_height = Math.min(videoDimensions.height, videoDimensions.width);
                        canvas_width = Math.max(videoDimensions.height, videoDimensions.width);
                        videoEncoderConfiguration = new VideoEncoderConfiguration(
                                videoDimensions, VideoEncoderConfiguration.FRAME_RATE.FRAME_RATE_FPS_15, STANDARD_BITRATE, VideoEncoderConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_FIXED_PORTRAIT
                        );
                        liveTranscoding.width = canvas_width;
                        liveTranscoding.height = canvas_height;
                        liveTranscoding.videoFramerate = 15;
                        engine.setVideoEncoderConfiguration(videoEncoderConfiguration);
                        ChannelMediaOptions channelMediaOptions = new ChannelMediaOptions();
                        // Publish audio streams.
                        channelMediaOptions.publishAudioTrack = true;
                        // Publish video streams captured by the camera.
                        channelMediaOptions.publishCameraTrack = true;
                        channelMediaOptions.clientRoleType = CLIENT_ROLE_BROADCASTER;
                        // Join another RTC channel after the host stops pushing streams to the CDN directly.
                        int ret = engine.joinChannel(null, channel, localUid, channelMediaOptions);
                        if (ret != 0) {
                            showLongToast(String.format("Join Channel call failed! reason:%d", ret));
                        }
                        // Set the transcoding configurations of live streaming in the channel.
                        engine.setLiveTranscoding(liveTranscoding);
                        // Publishes streams to a live streaming URL.
                        engine.addPublishStreamUrl(getUrl(), true);
                    }
                    else{
                        streamingButton.setText(getString(R.string.start_live_streaming));
                        cdnStreaming = false;
                    }
                    break;
                case FAILED:
                    showLongToast(String.format("Start Streaming failed, please go back to previous page and check the settings."));
                default:
                    Log.i(TAG, String.format("onDirectCdnStreamingStateChanged, state: %s error: %s message: %s", directCdnStreamingState.name(), directCdnStreamingError.name(), s));
            }
            rtcSwitcher.setEnabled(true);
        }
    });
}
```

#### Start cohosting across channels

```java
@Override
public void onUserJoined(int uid, int elapsed) {
    super.onUserJoined(uid, elapsed);
    Log.i(TAG, "onUserJoined->" + uid);
    showLongToast(String.format("user %d joined!", uid));
    Context context = getContext();
    if (context == null) {
        return;
    }

    if (remoteViews.containsKey(uid)) {
        return;
    } else {
        handler.post(new Runnable() {
            @Override
            public void run() {
                SurfaceView surfaceView = null;
                // Create Surface View.
                surfaceView = RtcEngine.CreateRendererView(context);
                surfaceView.setZOrderMediaOverlay(true);
                ViewGroup view = getAvailableView();
                remoteViews.put(uid, view);
                view.addView(surfaceView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
                // Set the video view of the remote host.
                engine.setupRemoteVideo(new VideoCanvas(surfaceView, RENDER_MODE_HIDDEN, uid));
                // Update the transcoding configurations of live streaming in the channel.
                updateTranscodeLayout();
            }
        });
    }
}

private void updateTranscodeLayout() {
    // In this sample code, the layout of video for transcoding is defined as 2x2.
    LiveTranscoding.TranscodingUser user = new LiveTranscoding.TranscodingUser();
    user.x = 0;
    user.y = 0;
    user.width = canvas_width / 2;
    user.height = canvas_height / 2;
    user.uid = localUid;
    liveTranscoding.addUser(user);
    int index = 0;
    for (int uid : remoteViews.keySet()) {
        index++;
        switch (index) {
            case 1:
                LiveTranscoding.TranscodingUser user1 = new LiveTranscoding.TranscodingUser();
                user1.x = canvas_width / 2;
                user1.y = 0;
                user1.width = canvas_width / 2;
                user1.height = canvas_height / 2;
                user1.uid = uid;
                liveTranscoding.addUser(user1);
                break;
            case 2:
                LiveTranscoding.TranscodingUser user2 = new LiveTranscoding.TranscodingUser();
                user2.x = 0;
                user2.y = canvas_height / 2;
                user2.width = canvas_width / 2;
                user2.height = canvas_height / 2;
                user2.uid = uid;
                liveTranscoding.addUser(user2);
                break;
            case 3:
                LiveTranscoding.TranscodingUser user3 = new LiveTranscoding.TranscodingUser();
                user3.x = canvas_width / 2;
                user3.y = canvas_height / 2;
                user3.width = canvas_width / 2;
                user3.height = canvas_height / 2;
                user3.uid = uid;
                liveTranscoding.addUser(user3);
                break;
            default:
                Log.i(TAG, "ignored user as only 2x2 video layout supported in this demo. uid:" + uid);
        }
    }
    // Update the transcoding configurations of live streaming in the channel.
    engine.setLiveTranscoding(liveTranscoding);
}
```

## Implement the audience's client for mobile streaming

This section shows how to implement the following functions on an audience member's client:

- Users join a channel as an audience member and watch the live stream.

- Users join a channel as an audience member and become a cohost during the live streaming.

### Create the UI

To create the UI for an audience member's client, Agora recommends adding the following UI elements：

- The video view.
- A button to switch the CDN route to watch live streaming.
- A button to start cohosting.

You can also see the `fragment_cdn_audience.xml` file in the sample project for reference. 

### Import classes

To import Agora classes, add the following lines in the  `Activity` file of your project: 

```java
import io.agora.mediaplayer.IMediaPlayer;
import io.agora.mediaplayer.IMediaPlayerObserver;
import io.agora.rtc2.ChannelMediaOptions;
import io.agora.rtc2.Constants;
import io.agora.rtc2.IRtcEngineEventHandler;
import io.agora.rtc2.RtcEngine;
import io.agora.rtc2.RtcEngineConfig;
import io.agora.rtc2.video.VideoCanvas;
import io.agora.rtc2.video.VideoEncoderConfiguration;

import static io.agora.rtc2.Constants.CLIENT_ROLE_BROADCASTER;
import static io.agora.rtc2.Constants.RENDER_MODE_HIDDEN;
import static io.agora.rtc2.video.VideoEncoderConfiguration.STANDARD_BITRATE;
```

### Handle the Android permissions

To check whether the permissions necessary to add mobile streaming functionality into the app are granted, call the `checkSelfPermission` method to access the microphone and camera of the Android device when launching the Activity.

```java
private static final int PERMISSION_REQ_ID = 22;

// Check the microphone and camera access when running the app.
private static final String[] REQUESTED_PERMISSIONS = {
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.CAMERA
};

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_video_chat_view);

    // Initialize RtcEngine and join a channel.
    if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
            checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID)) {
        initEngineAndJoinChannel();
    }
}

private boolean checkSelfPermission(String permission, int requestCode) {
    if (ContextCompat.checkSelfPermission(this, permission) !=
            PackageManager.PERMISSION_GRANTED) {
        ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
        return false;
    }

    return true;
}
```

### Watch the live stream

![](https://web-cdn.agora.io/docs-files/1638439348597)

#### Open the media streams

Refer to the following sample codes to open the media streams of CDN live streaming:

```java
@Override
public void onActivityCreated(@Nullable Bundle savedInstanceState) {
    super.onActivityCreated(savedInstanceState);
    // Check if the context is valid.
    Context context = getContext();
    if (context == null) {
        return;
    }
    try {
        RtcEngineConfig config = new RtcEngineConfig();
        config.mContext = context.getApplicationContext();
        // Pass in App ID.
        config.mAppId = getString(R.string.agora_app_id);
        // Set the channel profile as live streaming.
        config.mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
        config.mEventHandler = iRtcEngineEventHandler;
        // Initialize RtcEngine.
        engine = RtcEngine.create(config);
        // Initialize the media player.
        mediaPlayer = engine.createMediaPlayer();
        // Register the media player observer.
        mediaPlayer.registerPlayerObserver(this);
        // Call the openWithAgoraCDNSrc or open method to open the media resource of live streaming according to your scenarios. 
        if(isAgoraChannel){
            mediaPlayer.openWithAgoraCDNSrc(getUrl(), 0);
        }
        else {
            mediaPlayer.open(getUrl(), 0);
        }
    } catch (Exception e) {
        e.printStackTrace();
        getActivity().onBackPressed();
    }
}
```

#### Play the media streams

Refer to the following sample codes to play the media streams of CDN live streaming:

```java
@Override
public void onPlayerStateChanged(io.agora.mediaplayer.Constants.MediaPlayerState mediaPlayerState, io.agora.mediaplayer.Constants.MediaPlayerError mediaPlayerError) {
    Log.i(TAG, "player state change to " + mediaPlayerState.name());
    handler.post(new Runnable() {
        @Override
        public void run() {
            switch (mediaPlayerState) {
                case PLAYER_STATE_FAILED:
                    showLongToast(String.format("media player error: %s", mediaPlayerError.name()));
                    break;
                // You need to open the audio and video streams published by the host before you play them.
                case PLAYER_STATE_OPEN_COMPLETED:
                    mediaPlayer.play();
                    if (isAgoraChannel)
                        loadAgoraChannels();
                    rtcSwitcher.setEnabled(true);
                    break;
                case PLAYER_STATE_STOPPED:
                default:
                    break;
            }
        }
    });
}
```

#### Switch the CDN routes

Refer to the following sample codes to switch CDN routes to watch the live stream according to your scenarios:

```java
private void loadAgoraChannels() {
    // Get the number of routes for the live streaming.
    int count = mediaPlayer.getAgoraCDNLineCount();
    ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(getContext(), android.R.layout.simple_spinner_dropdown_item, getChannelArray(count));
    channelSpinner.setAdapter(arrayAdapter);
}

private final AdapterView.OnItemSelectedListener itemSelectedListener = new AdapterView.OnItemSelectedListener() {
    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
        Log.i(TAG,"Start to switch cdn, current index is "+mediaPlayer.getCurrentAgoraCDNIndex()+". target index is "+i);
        // Switch the CDN routes to watch the live stream accroding to your scenarios.
        mediaPlayer.switchAgoraCDNLineByIndex(i);
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {
    }
};
```

#### Stop watching the live stream

Refer to the following sample codes to stops watching the live stream:

```java
@Override
public void onDestroy() {
    super.onDestroy();
    if (rtcStreaming){
        engine.leaveChannel();
    }
    mediaPlayer.stop();
    engine.stopPreview();
    handler.post(RtcEngine::destroy);
    engine = null;
}
```

### Switch from an audience member to a host

![](https://web-cdn.agora.io/docs-files/1638439907023)

#### Set the local video view

Refer to the following sample codes to set the local video view:

```java
// Enable the video module and start local video preview.
// Start the local video preview.
SurfaceView surfaceView = new SurfaceView(this.getActivity());
surfaceView.setZOrderMediaOverlay(false);
if (fl_local.getChildCount() > 0) {
    fl_local.removeAllViews();
}
fl_local.addView(surfaceView);
VideoCanvas videoCanvas = new VideoCanvas(surfaceView, Constants.RENDER_MODE_HIDDEN, Constants.VIDEO_MIRROR_MODE_AUTO,
        Constants.VIDEO_SOURCE_MEDIA_PLAYER, mediaPlayer.getMediaPlayerId(), 0);
engine.setupLocalVideo(videoCanvas);
engine.startPreview();
engine.enableVideo();
// Set the video profile of the cohost.
engine.setVideoEncoderConfiguration(new VideoEncoderConfiguration(
        ((MainApplication) getActivity().getApplication()).getGlobalSettings().getVideoEncodingDimensionObject(),
        VideoEncoderConfiguration.FRAME_RATE.valueOf(((MainApplication) getActivity().getApplication()).getGlobalSettings().getVideoEncodingFrameRate()),
        STANDARD_BITRATE,
        VideoEncoderConfiguration.ORIENTATION_MODE.valueOf(((MainApplication) getActivity().getApplication()).getGlobalSettings().getVideoEncodingOrientation())
));
// Set the audio output to the speaker.
engine.setDefaultAudioRoutetoSpeakerphone(true);
```

#### Join a channel

Refer to the following sample codes to join a channel:

```java
private final CompoundButton.OnCheckedChangeListener checkedChangeListener = new CompoundButton.OnCheckedChangeListener() {
    @Override
    public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
        rtcStreaming = b;
        if (rtcStreaming) {
            ChannelMediaOptions channelMediaOptions = new ChannelMediaOptions();
            // Publish audio streams.
            channelMediaOptions.publishAudioTrack = true;
            // Publish video streams captured by the camera.
            channelMediaOptions.publishCameraTrack = true;
            channelMediaOptions.clientRoleType = CLIENT_ROLE_BROADCASTER;
            // Join an RTC channel.
            int ret = engine.joinChannel(null, channel, 0, channelMediaOptions);
            if (ret != 0) {
                showLongToast(String.format("Join Channel call failed! reason:%d", ret));
            }
        } else {
            remoteViews.clear();
            engine.leaveChannel();
            vol_control.setVisibility(View.INVISIBLE);
        }
        handler.post(new Runnable() {
            @Override
            public void run() {
                toggleVideoLayout(rtcStreaming);
            }
        });
    }
};
```

#### Set the remote video view

Refer to the following sample codes to set the remote video view:

```java
@Override
public void onUserJoined(int uid, int elapsed) {
    super.onUserJoined(uid, elapsed);
    Log.i(TAG, "onUserJoined->" + uid);
    showLongToast(String.format("user %d joined!", uid));
    Context context = getContext();
    if (context == null) {
        return;
    }
    if (remoteViews.containsKey(uid)) {
        return;
    } else {
        handler.post(new Runnable() {
            @Override
            public void run() {
                SurfaceView surfaceView = null;
                // Create a Surface View
                surfaceView = RtcEngine.CreateRendererView(context);
                surfaceView.setZOrderMediaOverlay(true);
                surfaceView.setZOrderOnTop(true);
                ViewGroup view = getAvailableView();
                remoteViews.put(uid, view);
                view.addView(surfaceView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
                // Set the video view of the remote host.
                engine.setupRemoteVideo(new VideoCanvas(surfaceView, RENDER_MODE_HIDDEN, uid));
            }
        });
    }
}
```