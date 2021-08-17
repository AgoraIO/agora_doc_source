This page shows you how to integrate and use an extension from the Agora Extensions Marketplace.

## Understand the tech

Extensions are add-ons that are designed to extend the functionality of the Agora SDK. The [Extensions Gallery](https://agora/) presents dozens of extensions that make your app more fun. These extensions provide features such as:

- Audio effects and voice changing.
- Image enhancement and face filters.

To use an extension in your Agora project, implement the following steps in your app:

1. Call `addExtension` to add the extension when initializing `RtcEngine`.
2. Call `enableExtension` before joining a channel to enable the extension.
3. Call `setExtensionProperty` to use a specific feature of the extension.

When calling the above-mentioned APIs, you need the following information from the extension provider:

- `EXTENSION_NAME`: The name of the extension.
- `EXTENSION_VENDOR_NAME`: The name of the extension provider.
- `EXTENSION_VIDEO_FILTER_NAME` or `EXTENSION_AUDIO_FILTER_NAME`: The name of the video or audio filter plugin of the extension.
- Key-value pairs for `setExtensionProperty`: Each feature has a unique key-value pair.

## Prerequisites

To follow the procedure on this page, you must have:

- An Agora project that has implemented [a client for Video Call (Android)](TBD) or [a client for Interactive Live Streaming Premium (Android)](TBD).
- A valid extension package. For details, see [Get an extension](TBD).

## Project setup

Follow the steps to create the environment necessary to integrate the extension into your app.

If the extension package is a `.aar` file:

1. Save the `.aar` file to  `/app/libs` in your project folder.

2. In `/Gradle Scripts/build.gradle(Module: <ProjectName> app)`, add the following line under `dependencies`:

   ```java
   implementation fileTree(include: ['*.jar', '*.aar'], dir: 'libs')
   ```

If the extension package is a `.so` file, save the `.so` file to the following paths in your project folder:

- `/app/src/main/jniLibs/arm64-v8a`
-  `/app/src/main/jniLibs/armeabi-v7a`

## Implement the extension in your project

This section shows how to implement the features of an extension in your Agora project.

For demonstration purposes, a simple watermark extension is used to explain the procedure. The watermark extension adds a watermark for local video.

You can get the watermark extension from [API-Example](http://xxx/), and follow the procedure to experience its feature. 

### Import necessary classes

In `/app/java/com.example.<projectname>/MainActivity`:

1. Add the following lines to import the Android classes used by the extension:

   ```java
   import org.json.JSONException;
   import org.json.JSONObject;
   ```

2. Before `import io.agora.rtc2.video.VideoCanvas`,  add the following lines to import the Agora classes used by the extension:

   ```java
   import io.agora.extension.ExtensionManager;
   import io.agora.rtc2.Constants;
   import io.agora.rtc2.IMediaExtensionObserver;
   ```

### Pass in basic extension information

Basic information about the watermark extension is defined in  `/agora-simple-filter/src/main/java/io/agora/extension/ExtensionManager.java`, as follows:

```java
public static final String EXTENSION_NAME = "agora-simple-filter";
public static final String EXTENSION_VENDOR_NAME = "Agora";
public static final String EXTENSION_VIDEO_FILTER_NAME = "Watermark";
```

You do not need to change anything.

### Enable and use the extension

In `/app/java/com.example.<projectname>/MainActivity`, replace the current `initializeAndJoinChannel` function with the following code:

```java
private void initializeAndJoinChannel() {
    try {
        RtcEngineConfig config = new RtcEngineConfig();
        config.mContext = this;
        config.mAppId = appId;
        // Call addExtension to add the extension
        config.addExtension(ExtensionManager.EXTENSION_NAME);
        // Register IMediaExtensionObserver to receive events from the extension
        config.mExtensionObserver = new IMediaExtensionObserver() {
            @Override
            public void onEvent(String vendor, String extension, String key, String value) {
                // Add callback handling logics for extension events
            }
        };
        config.mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
        config.mEventHandler = mRtcEventHandler;
        mRtcEngine = RtcEngine.create(config);
    }
    catch (Exception e) {
        throw new RuntimeException("Check the error. " + e.toString());
    }
 
    mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER);
    // Call enableExtension to enable the extension.
    // To enable multiple extensions, call enableExtension as many times. The sequence of enabling multiple extensions determines the order of extensions in the transmission pipeline.
    // For example, if you enable extension A before extension B, the data processed by extension B is already processed by extension A.
    mRtcEngine.enableExtension(ExtensionManager.EXTENSION_VENDOR_NAME, ExtensionManager.EXTENSION_VIDEO_FILTER_NAME, true);
 
    mRtcEngine.enableVideo();
 
    FrameLayout container = findViewById(R.id.local_video_view_container);
    SurfaceView surfaceView = new SurfaceView(getBaseContext());
    container.addView(surfaceView);
    mRtcEngine.setupLocalVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, 0));
    mRtcEngine.startPreview();
 
    mRtcEngine.joinChannel(token, channelName, "", 0);
 
    JSONObject o = new JSONObject();
    try {
        // Pass in the key-value pairs defined by the extension provider to configure the feature you want to use.
        o.put("plugin.watermask.wmStr", "123456");
        o.put("plugin.watermark.wmEffectEnabled", true);
 
        // Call setExtensionProperty to use the feature.
mRtcEngine.setExtensionProperty(ExtensionManager.EXTENSION_VENDOR_NAME, ExtensionManager.EXTENSION_VIDEO_FILTER_NAME, "key", o.toString());
    } catch (JSONException e) {
        e.printStackTrace();
    }
}
```

## Test the extension

1. Connect the Android device to the computer.

2. Click `Run 'app'` on your Android Studio. A moment later you will see the project installed on your device.

3. Grant microphone and camera access to your app.

4. When the app launches, you should be able to see yourself and the watermark "123456" on the local view.


## Sample project

Agora provides an open source sample project (TBD) on GitHub for your reference.

