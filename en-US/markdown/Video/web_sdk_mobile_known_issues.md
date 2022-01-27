# Known Issues and Workarounds for Using the Web SDK on Mobile Devices

This page lists the known issues and limitations of using the Web SDK on mobile devices:
- Known issues: Caused by bugs on specific versions of iOS or specific browsers on Android. For some known issues, Agora provides workarounds.
- Known limitations: Unsupported APIs or features due to issues on iOS or Android.

<div class="alert info">Note that this page is continuously updated as Android and iOS evolve.</div>

## Known issues

### iOS

<details>
<summary>iOS 15.1.x: The browser crashes when sending the H.264 video stream</summary>
<p>

**Impact**: All browsers and apps that use WkWebView on iOS 15.1.x, such as Safari and Chrome.
</p>
<p>

**Details**: If you set `codec` as `'h264'` when calling `createClient`, the browsers on iOS 15.1.x crash after you send the video stream.
</p>
<p>

**Reason**: This issue happens due to the regression of the WebKit video encoder on iOS 15.1.x. For details, see [WebKit Bug 231505](https://bugs.webkit.org/show_bug.cgi?id=231505).
</p>
<p>

**Workaround**: Use the VP8 codec for video encoding.

```javascript
createClient({codec:'vp8', mode})
```
</p>
</details>

<details>
<summary>iOS 15.x: Low audio volume</summary>
<p>

**Impact**: All browsers and apps that use WkWebView on iOS 15.x, such as Safari and Chrome.</p>
<p>

**Details**: On iOS 15.x, after the local user subscribes to the `RemoteAudioTrack` and plays it, sometimes the audio is routed to the earpiece instead of the speaker, and the volume that the local user may be very low.</p>
<p>

**Reason**: This issue happens due to the regression of the WebKit audio module on iOS 15.x. For details, see [ WebKit Bug 230902](https://bugs.webkit.org/show_bug.cgi?id=230902).
</p>
<p>

**Workaround**: On iOS 15.x, use `WebAudio` to play the audio and use `GainNode` to increase the audio volume level. Use the following workaround:
1. Upgrade to the Web SDK 4.9.0 or later versions.
2. Set the SDK private parameter `REMOTE_AUDIO_TRACK_USES_WEB_AUDIO` as `true`. The SDK uses `WebAudio` to play the remote audio stream. Sample code:
   ```javascript
   function isIOS15(ua){
       // Use UA to judge whether the iOS version is 15
   }

   if(isIOS15(navigator.userAgent)){
       AgoraRTC.setParameter("REMOTE_AUDIO_TRACK_USES_WEB_AUDIO", true);
   }
   ```
   </p>
   </details>

<details>
<summary>iOS 15.x: The video played goes black</summary>
<p>

**Impact**: All browsers and apps that use WkWebView on iOS 15.x, such as Safari and Chrome.
</p>
<p>

**Details**: On iOS 15.x, if you play the video in the DOM node and add some CSS properties (such as `transform` and `animation`) to the` video` element or its parent element, or if you change the CSS properties to redraw the video rendering area, sometimes the video goes black.
</p>
<p>

**Reason**: This issue happens due to the regression of the WebKit video renderer on iOS 15.x. For details, see [WebKit Bug 230902](https://bugs.webkit.org/show_bug.cgi?id=230902).
</p>
<p>

**Workaround**: Upgrade to the Web SDK v4.7.3 or later and minimize changes to the CSS properties of the `video` element and its parent elements.
</p>
</details>


<details>
<summary>iOS 15.x: After the user wears a Bluetooth headset, the audio may be significantly distorted</summary>
<p>

**Impact**: All browsers and apps that use WkWebView on iOS 15.x, such as Safari and Chrome.
</p>
<p>

**Reason**: This issue happens due to the regression of the WebKit audio playback module on iOS 15.x. For details, see [WebKit Bug 231422](https://bugs.webkit.org/show_bug.cgi?id=231422).
</p>
<p>

**Workaround**: Agora recommends that you add a prompt to remind users of possible audio distortion issues when they try to use a Bluetooth headset.
</p>
</details>

<details>
<summary>iOS 15.x: Backgrounding the browser or app causes the audio streaming to be cut off.</summary>
<p>

**Impact**: All browsers and apps that use WkWebView on iOS 15.x, such as Safari and Chrome.
</p>
<p>

**Reason**: This happens primarily due to this WebKit [bug](https://bugs.webkit.org/show_bug.cgi?id=231105). After the browser switches to the background, the `AudioContext` of `WebAudio` stops processing audio.
</p>
<p>

**Workaround**: Follow these steps to avoid this issue:
1. Upgrade to the Web SDK v4.7.3 or later versions.
2. When calling `createMicrophoneAudioTrack`, set `bypassWebAudio` as `true`. The Web SDK directly publishes the local audio stream without processing it through `WebAudio`.

   ```javascript
   const localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack({bypassWebAudio: true});
   ```

   > Note that this workaround has a side effect. After applying this workaround, the audio mixing fuction (`MixingAudioTrack`) in the SDK will fail.
   > </p>
   > </details>

<details>
<summary>iOS 15.x: Audio and video playback may be not resumed automatically after an interruption with a system phone call, another real-time interaction app, Siri, or alarm.</summary>
<p>

**Impact**: All browsers and apps that use WkWebView on iOS 15.x, such as Safari and Chrome.
</p>
<p>

**Reason**: Such interruptions can cause the state of the `video` and `audio` elements to be `paused`. After the interruption finishes, the state cannot be automatically switched back to `playing`, and even calling `HTMLMediaElement.play` cannot resume the media playback. See the WebKit bug [232599](https://bugs.webkit.org/show_bug.cgi?id=232599) and [226698](https://bugs.webkit.org/show_bug.cgi?id=226698) for more details.
</p>
<p>

**Workaround**: Upgrade to the Web SDK v4.7.3 or later versions. The SDK attempts to resume media playback after the interruption. Agora recommends that you add a prompt that instructs users to refresh the page.
</p>
</details>

<details>
<summary>Other known issues</summary>
<p>

- The volume of a remote user may change randomly on iOS 13 and 14.
- Switching between the front and rear cameras may momentarily rotate the video.
- The audio routing can change randomly: Sometimes, the audio is routed to the speakerphone when a headset is connected, or to the earpiece when no headset is connected.
- If you call `getUserMedia` twice to get two tracks of the same media type, the first track goes muted or black.
- After a user switches to other apps that use the microphone or camera (such as Siri or Skype) and then switches back, the audio sampling or video capture fails.
   </p>
   </details>

### Android

<details>
<summary>Android 12: Video distortion on Chrome when hardware acceleration is enabled</summary>

<p>

**Impact**: The Chrome browser or Chromium kernel browser 97 or below on certain devices with Android 12, such as Pixel 3 and Pixel 4.
</p>
<p>

**Details**: If the Chrome browser on Android 12 enables the WebRTC `H264` or `VP8` hardware acceleration by default, video distortion may occur.
</p>
<p>

**Reason**: This issue happens due to the regression of the Chromium WebRTC video encoder. For details, see [Chromium issue 1237677](https://bugs.chromium.org/p/chromium/issues/detail?id=1237677).
</p>
<p>

**Workaround**: Chrome 97 fixed this issue. You can instruct users to upgrade to Chrome 97 or later versions.
</p>
</details>

<details>
<summary>The video sending bitrate on Android Chrome fails to reach the preset value.</summary>
<p>

**Scope**: Certain Android devices, such as Xiaomi and OnePlus.
</p>
<p>

**Reason**: This is a hardware encoder issue. The bitrate fails to reach the preset value at a specific video encoding frame rate.
</p>
<p>

**Workaround**: In most cases, the bitrate is relatively lower when the frame rate is set as 15 fps. If you set the frame rate as 30 fps, the bitrate increases. So Agora recommends trying to set the frame rate as 30 fps when encountering a bitrate issue. However, setting the frame rate as fps may cause performance issues.
</p>
</details>

<details>
<summary>The autoplay of inaudible media is blocked on WeChat</summary>
<p>

**Impact**: The WeChat browser using Chromium 89 kernel
</p>
<p>

**Details**: The autoplay of inaudible media is blocked. Even after the user interacts with the webpage to resume the video playback, the autoplay block is still not removed.
</p>
<p>

**Reason**: This issue happens because the WeChat browser implements a custom autoplay policy.
</p>
<p>

**Workaround**: Follow these steps to avoid this issue:
1. Upgrade to the Web SDK v4.6.0 or later versions.
2. Listen to the `AgoraRTC.onAutoplayFailed` event. Instruct the user to click on the page to resume playback:

   ```javascript
   AgoraRTC.onAutoplayFailed = ()=>{
       document.alert('Please click the page to resume playback');
   }
   ```
   </p>
   </details>

<details>
<summary>If the local user wears a Bluetooth headset, after the local user starts to send the audio, the remote audio is lost</summary>
<p>

**Scope**: Certain Xiaomi and OnePlus devices
</p>
<p>

**Details**: If the local user wears a Bluetooth headset, when the Bluetooth headset starts capturing the audio, there is a possibility that the remote audio is lost.
</p>
<p>

**Reason**: It may be due to the audio issue on Chromium regarding the profile switch of the Bluetooth.
</p>
<p>

**Workaround**: Agora recommends that you add a prompt to remind users of possible no audio issues when they try to use a Bluetooth headset.
</p>
</details>

<details>
<summary>Issues specific to certain Android devices</summary>
<p>

- On devices equipped with **MediaTek chips**, the Web SDK cannot encode and send video streams in H.264.
- On devices equipped with Huawei **HiSilicon Kirin** chips, if you use Chrome versions earlier than 88, the Web SDK cannot encode and send video streams in H.264.
- When receiving video streams on Chrome on **OnePlus 6**, if the screen turns off, the video may freeze.
- **Harmony OS** does not support sending the video stream of 180p.
   </p>
   </details>

<details>
<summary>Other known issues</summary>
<p>

- On some Android devices, the device labels might not be available.
- On some Android devices, the interruption of a phone call or an audio or video call from another application may end tracks. To resume the call, the Web SDK needs to re-capture the audio and video.
- On Android Chrome, the Web SDK cannot send high-quality and low-quality streams in H.264.
- On Android Chrome earlier than 90, the volume obtained by `getVolumeLevel` is 0, but the user can hear the audio.
- On Android system WebView 55 - 75, the `decodeFrameRate` property stays 0.
   </p>
   </details>

## Known limitations

### iOS

<details>
<summary>The <code>createScreenVideoTrack</code> method is not supported</summary>
<p>

Reason: iOS Safari and WkWebView do not support the `mediaDevices.getDisplayMedia` method.
</p>
</details>

<details>
<summary>The <code>setBeautyEffect</code> method is not supported</summary>
<p>

Reason: WebGL is not well supported on iOS Safari and WkWebView, and the image enhancement algorithm can reduce the system performance below acceptable levels.
</p>
</details>

<details>
<summary><code>The IBufferSourceAudioTrack.seekAudioBuffer</code> method is not supported</summary>
<p>

Reason: `WebAudio` on iOS does not support this method.
</p>
</details>

<details>
<summary>Cannot send H.264 video streams with a resolution of 1080p or higher</summary>
<p>

Reason: The Web SDK uses the H.264 Baseline Profile for negotiation, so encoding and sending a video stream with a resolution of 1080p or higher is not supported on iOS.
</p>
</details>

<details>
<summary>When sending a low-quality stream on iOS Safari, you cannot set <code>LowStreamParameter.bitrate</code>, and the resolution of the low-quality stream must be proportional to the resolution of the high-quality stream.</summary>
<p>

Reason: iOS Safari and WkWebView do not support setting the frame rate with the `RTCRTPSender.setParameters` method. After compressing the resolution with the `scaleResolutionDownBy` property, the resolution of the low-quality stream keeps proportional to the resolution of the high-quality stream.
</p>
</details>

<details>
<summary>The <code>encodeDelay</code> property is not supported</summary>
<p>

Reason: The `encodeDelay` property cannot be calculated through the `getStats` method of WebRTC on iOS.
</p>
</details>

### Android

<details>
<summary>The <code>createScreenVideoTrack</code> method is not supported</summary>
<p>

Reason: The `mediaDevices.getDisplayMedia` method is not implemented on mobile browsers and WkWebView.
</p>
</details>

<details>
<summary>The <code>setBeautyEffect</code> method is not supported</summary>
<p>

Reason: The image enhancement algorithm can reduce the system performance of mobile devices below acceptable levels.
</p>
</details>