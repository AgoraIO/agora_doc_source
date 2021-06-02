---
title: Share the Screen
platform: Web
updatedAt: 2021-01-05 06:11:56
---
## Introduction

During a video call or live broadcast, **sharing the screen** enhances communication by displaying the speaker's screen on the display of other speakers or audience members in the channel.

Screen sharing is applied in the following scenarios:

- In a video conference, the speaker can share an image of a local file, web page, or presentation with other users in the channel.
- In an online class, the teacher can share the slides or notes with students.

## Implementation

Ensure that you prepared the development environment. See [Integrate the SDK](./web_prepare).

To enable screen sharing, you need to set relevant attributes when creating the video stream. The web browser will ask you to select which screens to share. The attribute settings are different on Google Chrome and Firefox.

### <a name = "chrome"></a>Screen Sharing on Google Chrome

Ensure that you added the [Google Chrome Extension for Screen Sharing](/en/Quickstart%20Guide/chrome_screensharing_plugin) provided by Agora.

Fill in the `extensionId` when you create the stream.

```javascript
screenStream = AgoraRTC.createStream({
  streamID: uid,
  audio: false,
  video: false,
  screen: true,
  //chrome extension ID
  extensionId: 'minllpmhdgpndnkomcoccfekfegnlikg'
});
```

> - Do not set the `video` and `screen` attributes as `true` at the same time.
> - Agora recommends that you set the `audio` attribute as `false` to avoid any echo during the call.

### Screen Sharing on Electron

Screen sharing on Electron does not require plugins, but you need to draw the UI for screen source selection by yourself. Electron only provides interfaces for sharing the screen. 

Follow the steps below to implement screen sharing on Electron:

1. Call the `AgoraRTC.getScreenSources` method to get sources of the screens to share. 

   ```javascript
   AgoraRTC.getScreenSources(function(err, sources) {
   	console.log(sources)
   }
   ```

   The  `sources`  parameter is an array of the `source` objects. The  `source` object contains the following properties of the screen source:

   ![img](https://web-cdn.agora.io/docs-files/1547455349613)

   - `id`:  `sourceId`
   - `name`: Name of the screen source
   - `thumbnail`: Thumbnail of the screen source

2. Based on the properties of `source`, draw the UI (by html and css) for selecting the screen source to be shared. For quick integration, Agora provides a default UI.

   The following figure shows the properties' corresponding elements on the UI for screen source selection of Chrome:

   ![img](https://web-cdn.agora.io/docs-files/1547456888707)

3. Get the `sourceId` of the source selected by the user.

4. Fill in the `sourceId` when creating the screen-sharing stream.

   ```javascript
   localStream = AgoraRTC.createStream({
       streamID: UID,
       audio: false,
       video: false,
       screen: true,
       sourceId: sourceId
   });
   localStream.init(function(stream) {})
   ```

   If you leave `sourceId`  empty, the Agora SDK uses the default UI for screen source selection when calling the `localStream.init` method. The following figure shows the default UI:

   ![img](https://web-cdn.agora.io/docs-files/1547455511311)

> - The `getScreenSources` method is a wrapper of the `desktopCapturer.getSources` method provided by Electron. See [desktopCapturer](https://electronjs.org/docs/api/desktop-capturer) for details.
> - The `sourceId` parameter only takes effect on Electron.

### <a name = "ff"></a>Screen Sharing on Firefox

Set the `mediaSource` attribute to specify the sharing mode:

- `screen`：Shares the whole screen.
- `application`：Shares all windows of an application.
- `window`：Shares a specific window of an application.

```javascript
screenStream = AgoraRTC.createStream({
  streamID: uid,
  audio: false,
  video: false,
  screen: true,
  mediaSource: 'screen' // 'screen', 'application', 'window'
});
```

> - Do not set the `video` and `screen` attributes as `true` at the same time.
> - Agora recommends that you set the `audio` attribute as `false` to avoid echo during the call.
> - Firefox on Windows does not support the application mode.

### <a name = "both"></a>Enabling Both Screen Sharing and Video

One client only sends one stream. If you want to enable both screen sharing and video on one host, you need to create two clients: 

- A client to send the screen-sharing stream.
- A client to send the video stream.

```javascript
// Create the client to send the screen-sharing stream.
var screenClient = AgoraRTC.createClient({mode: 'rtc', codec: 'vp8'});
screenClient.init(key, function() {
 screenClient.join(channelKey, channel, null, function(uid) {
  // Create the screen-sharing stream, screenStream.
  ...
  screenClient.publish(screenStream);
 }
  }

// Create the client to send the video stream.
var videoClient = AgoraRTC.createClient({mode: 'rtc', codec: 'vp8'});
videoClient.init(key, function() {
videoClient.join(channelKey, channel, null, function(uid) {
  // Create the video stream, videoStream.
  ...
  videoClient.publish(videoStream);
 }
}
```

If two clients of a host subscribe to each other, extra charges will occur.

<img alt="../_images/screensharing_streams.png" src="https://web-cdn.agora.io/docs-files/en/screensharing_streams.png" style="width: 500px; "/>

Agora recommends that you save the returned `uid` when each client joins the channel. When the `stream-added` event occurs, first check if the joined client is a local stream, if `yes`, do not subscribe to the client.

```javascript
var localStreams = [];
...

screenClient.join(channelKey, channel, null, function(uid) {
 // Save the uid of the local stream.
 localStreams.push(uid);
}
...

screenClient.on('stream-added', function(evt) {
 var stream = evt.stream;
 var uid = stream.getId()
 // When the 'stream-added' event occurs, check if the stream is a local uid.
 if(!localStreams.includes(uid)) {
  console.log('subscribe stream: ' + uid);
  // Subscribe to the stream.
  screenClient.subscribe(stream);
 }
})
```

### Sample Code

```javascript
var key = “********************************”;
var channel = “screen_video”;
var channelKey = null;

AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.INFO);

var localStreams = [];

var screenClient = AgoraRTC.createClient({mode: 'rtc', codec: 'vp8'});
screenClient.init(key, function() {
screenClient.join(channelKey, channel, null, function(uid) {
// Save the uid of the local stream.
localStreams.push(uid);
// Create the stream for screen sharing.
screenStream = AgoraRTC.createStream({
streamID: uid,
audio: false, // Set the audio attribute as false to avoid any echo during the call.
video: false,
screen: true,
// Google Chrome:
extensionId: 'minllpmhdgpndnkomcoccfekfegnlikg',
// Firefox:
mediaSource: 'window' // 'screen', 'application', 'window'
});
// Initialize the stream.
screenStream.init(function() {
// Play the stream.
screenStream.play('Screen');
// Publish the stream.
screenClient.publish(screenStream);

// Listen to the 'stream-added' event.
screenClient.on('stream-added', function(evt) {
var stream = evt.stream;
var uid = stream.getId()

// Check if the stream is a local uid.
if(!localStreams.includes(uid)) {
  console.log('subscribe stream:' + uid);
  // Subscribe to the stream.
  screenClient.subscribe(stream);
  }
  })

}, function (err) {
  console.log(err);
});

}, function (err) {
  console.log(err);
})
});

var videoClient = AgoraRTC.createClient({mode: 'rtc', codec: 'vp8'});
videoClient.init(key, function() {
videoClient.join(channelKey, channel, null, function(uid) {
// Save the uid of the local stream.
localStreams.push(uid);

// Create the video stream.
videoStream = AgoraRTC.createStream({
streamID: uid,
audio: true,
video: true,
screen: false
});
return;

// Initialize the stream.
videoStream.init(function() {
// Play the stream.
videoStream.play('Video');
// Publish the stream.
videoClient.publish(videoStream);
// Listen to the 'stream-added' event.
videoClient.on('stream-added', function(evt){
var stream = evt.stream;
var uid = stream.getId();
// Check if the stream is a local uid.
if(!localStreams.includes(uid)) {
console.log('subscribe stream:' + uid);
// Subscribe to the stream.
screenClient.subscribe(stream);
}
})
}, function (err) {
  console.log(err);
  });

  }, function (err) {
  console.log(err);
  })
});
```

## Considerations

- Do not set the uid of the screen-sharing stream to a fixed value. Streams with the same uid can interfere with each other.
- **Do not subscribe to a locally published screen-sharing stream**, else additional charges will incur.
- Ensure that `video`/`audio` is set to `false` when creating the screen-sharing stream.

## Working Principles

Screen sharing on the Web client is enabled by creating a screen-sharing stream.

- If you publish the screen-sharing stream only, set the `video` as `false`, and the `screen` as `true` when creating a stream.
- If you publish both the local video stream and your screen-sharing stream, you need to create two client objects:
  - A client object for sending the local stream. Set `video` as true and `screen` as false.
  - A client object for sending the screen-sharing stream. Set `video` as false and `screen` as true.