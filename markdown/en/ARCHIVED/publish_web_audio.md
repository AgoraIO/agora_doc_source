---
title: Publish and Subscribe to Streams
platform: Web
updatedAt: 2018-12-14 07:02:58
---
Before publishing or subscribing to any streams, ensure that you have finished preparing the development environment and joined the channel. See [Integrate the SDK](/en/Voice/web_prepare) for more information.

## Implementation
### Create a stream
Use the `client.createStream`  method to create a stream.

The sample app passes in an object with the following properties:

- **streamID**: The stream ID (set as the user ID) which can be retrieved from the `client.join`  callback.
- **audio**: Enables/Disables audio.
- **video**: Enables/Disables video.
- **screen**: Enables/Disables screen sharing. Do not set `video` and `screen` as `true` at the same time.

```javascript
localStream = AgoraRTC.createStream({
  streamID: uid,
  audio: true,
  video: false,
  screen: false}
);
```

### Initialize the stream
Next, call the `stream.init`  method to initialize the stream.

```javascript
localStream.init(function() {
  console.log("getUserMedia successfully");
  localStream.play('agora_local');

}, function (err) {
  console.log("getUserMedia failed", err);
});
```

### Publish the local stream
Once initialized, use the `client.publish` method in the `onSuccess` callback to publish the stream.

```javascript
client.publish(localStream, function (err) {
  console.log("Publish local stream error: " + err);
});

client.on('stream-published', function (evt) {
  console.log("Publish local stream successfully");
});
```

### Subscribe to the remote stream
To subscribe to a remote stream:

1. Use the `client.on('stream-added')` event listener to detect when a new stream is added to the channel.
2. When the event is detected, use the `client.subscribe`  method in the callback to subscribe to the stream.

```javascript
client.on('stream-added', function (evt) {
  var stream = evt.stream;
  console.log("New stream added: " + stream.getId());

  client.subscribe(stream, function (err) {
    console.log("Subscribe stream failed", err);
  });
});
client.on('stream-subscribed', function (evt) {
  var remoteStream = evt.stream;
  console.log("Subscribe remote stream successfully: " + remoteStream.getId());
  remoteStream.play('agora_remote' + remoteStream.getId());
})
```

### Play the stream
After initializing the local stream or subscribing to the remote stream, use the `stream.play`  method to play the stream on the web page. The `stream.play`  method takes the ID of a dom element as a parameter, and the SDK creates a `<video>` tag and plays the audio.

- Play the stream after initializing the local stream.

	```javascript
localStream.init(function() {
		console.log("getUserMedia successfully");
		// Use agora_local as the ID of the dom element
		localStream.play('agora_local');

	}, function (err) {
		console.log("getUserMedia failed", err);
});
	```

- Play the stream after subscribing to the remote stream.

	```javascript
client.on('stream-subscribed', function (evt) {
	var remoteStream = evt.stream;
	console.log("Subscribe remote stream successfully: " + remoteStream.getId());
	// Use agora_remote + remoteStream.getId() as the ID of the dom element
	remoteStream.play('agora_remote' + remoteStream.getId());
})
	```


## Next Steps
You are now in a voice call. When the call ends, use the Agora SDK to exit the current call:

- [Leave the Channel](/en/Voice/leave_web)

For added requirements on the audio volume, audio effect or voice pitch, you can alse take the following steps:

- [Adjust the volume](/en/Voice/volume_web)
- [Play the Audio Effects/Audio Mixing](/en/Voice/effect_mixing_web)