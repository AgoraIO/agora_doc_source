---
title: Which browsers does the Agora Web SDK support?
platform: ["Web"]
updatedAt: 2021-03-04 07:10:12
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Supported browsers

The section lists the browsers that the Agora RTC Web SDK supports on different platforms.

<div class="alert note">To ensure better end user experience, Agora highly recommends using the <a href="https://www.google.com/chrome/">latest version</a> of Google Chrome on desktop.</div>

<div class="alert note">Upgrade to the latest version of the Web SDK in the following scenarios:<li>Safari on iOS 12.1.4 or later.</li><li>Safari 12.1 or later on macOS.</li></div>

### Desktop

See the following table for the supported browsers on desktop:

| Platform   | Google Chrome 58 or later | Firefox 56 or later | Safari 11 or later | Opera 45 or later | QQ Browser 10.5 or later | 360 Secure Browser | Edge Browser 80 or later |
| :--------- | :------------------------ | :------------------ | :----------------- | :---------------- | :----------------------- | :----------------- | :----------------------- |
| macOS 10+  | <font color="green">✔</font>                         | <font color="green">✔</font>                   | <font color="green">✔</font>                  | <font color="green">✔</font>                 | <font color="green">✔</font>                        | <font color="red">✘</font>                  | <font color="red">✘</font>                        |
| Windows 7+ | <font color="green">✔</font>                         | <font color="green">✔</font>                   | N/A                | <font color="green">✔</font>                 | <font color="green">✔</font>                        | <font color="green">✔</font>                  | <font color="green">✔</font>                        |

Other browser support on desktop:

- The Web SDK v2.5 or later supports Google Chrome 49 on Windows XP. However, in this case, it supports VP8 only, and cannot interoperate with the Native SDK.
- The Web SDK theoretically supports 360 Extreme Browser, but we do not guarantee full support.

### Mobile

The browser support on mobile devices heavily depends on the capabilities of devices and the codec implementation of browsers.

- On Android 4.1 or later, the Web SDK supports Chrome 58 or later. Agora recommends using VP8 on Android Chrome, because whether Google Chrome for Android supports H.264 is hardware dependent and some Android devices do not support H.264.
- On iOS 11 or later, the Web SDK supports Safari or later. However, Agora does not recommend using the Web SDK on iOS Safari due to the large amount of known issues and limitations of [iOS Safari](#ios). For better user experience on iOS, try the [Agora RTC iOS SDK](https://docs.agora.io/en/Interactive%20Broadcast/downloads).

The support for in-app browsers on mobile devices is complicated. For details, see [How can I use Agora RTC Web SDK on mobile devices?](https://docs.agora.io/en/faq/web_on_mobile)

## Limitation
Due to the various browser engine implementations, support for some features may vary by browser and platform. The following are known issues and limitations.

On Chrome 81 or later, Safari, and Firefox, device IDs are only available after the user has granted permissions to use the media device. See [Why can't I get device ID on Chrome 81?](https://docs.agora.io/en/faq/empty_deviceId)
	
### Chrome

The Agora Web SDK is based on WebRTC and works best on Chrome.
- The Agora Web SDK supports Chrome 58 or later.
- On some Android devices, Chrome does not support the H.264 codec.
- Some APIs require later versions of Chrome, see the API Reference for details.
- On all AMD-based and some Intel-based devices with the Windows operating system, if Chrome uses the H.264 codec, the video transmission bitrate may be lower than the set value. To resolve it, you can set the browser to use the VP8 codec or try to disable hardware acceleration.

### Safari

<a name="ios"></a>**iOS Safari**

Known issues and limitations of Safari on iOS:

- The audio routing may change randomly: Sometimes, the audio is routed to the speakerphone when a headset is connected, or to the earpiece when no headset is connected.
- The volume of a remote user may change randomly on iOS 13.
- Safari does not support the `getAudioLevel` method on iOS.
- If you call `getUserMedia` twice to get two tracks of the same media type, the first track goes muted or black.
- On iOS Safari, after an audience member switches the role to `"host"` and gets the microphone permission, the remote user's volume lowers significantly.
- Occasional: On iOS 13, after a user switches to other apps that use the microphone or camera (such as Siri or Skype) and then switches back, the audio sampling or video capture fails.
- Occasional: After the audio session is interrupted, for example, the local user mutes or unmutes the audio, uses Siri, or answers an incoming call, the user can no longer hear any remote users.

**Other issues**

The following lists other known issues and limitations of Safari on iOS and macOS:

- Safari 11 only supports the video resolution of 480P and higher.
- Safari 12.1 or earlier only supports the H.264 codec.
- On Safari 13, users may not be able to hear other users.
- On iOS Safari 14.2 and macOS Safari 14.0.1, the audio may be stuttering.
- Device permission limitations:
  - Safari does not support getting the output device information, so it does not support the `getPlayoutDevices` and `setAudioOutput` methods.
  - If **Auto-Play** is not enabled on Safari (as the following figure shows), the stream playback has no audio. You have to call the `navigator.mediaDevices.getUserMedia` method to get the device permissions before playing a stream.
    ![](https://web-cdn.agora.io/docs-files/1591079062644)
- Safari does not support the `addTrack` and `removeTrack` methods.
- Safari does not support enabling [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#dual-stream).
- On Safari, when calling APIs to get quality statistics, the values of some properties are 0. For example, when calling `getLocalAudioStats` to get the audio statistics of the local stream, the values of `RecordingLevel` and `SendLevel` are 0.

### Firefox

- When the Web SDK on Firefox communicates with the SDK on some devices, the video on Firefox is rotated.
- Firefox does not support changing the frame rate (30 fps by default).
- Setting the video profile on Firefox does not take effect on the following devices:
  - MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)
  - Windows 10 (MI)
- On Firefox, when calling APIs to get quality statistics, the values of some properties are 0. For example, when calling `getLocalAudioStats` to get the audio statistics of the local stream, the values of `RecordingLevel` and `SendLevel` are 0.
- On Macs with the Apple M1 chip, Firefox does not support H.264. For details, see the [Firefox documentation](https://bugzilla.mozilla.org/show_bug.cgi?id=1686470).

## Reference
[How to use Agora Web SDK on mobile devices?](https://docs.agora.io/en/faq/web_on_mobile)