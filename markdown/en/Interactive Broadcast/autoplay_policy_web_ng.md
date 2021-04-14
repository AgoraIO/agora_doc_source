---
title: Deal with Autoplay Blocking
platform: Web
updatedAt: 2021-02-07 11:05:10
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./autoplay_policy_web?platform=Web">Deal with Autoplay Blocking</a>.</li></div>

## Overview

To prevent the webpage from playing sound without permission, most web browsers restrict the autoplay function: Autoplay with sound is blocked unless the user has interacted with the webpage.

This restriction policy is intended to improve the user experience, because autoplay with sound may be against the users' deliberate intention.

When it comes to the Agora Web SDK, this policy may cause audio playback failure so long as you call the `play` method to play an audio track before any user interaction.

This document describes how to get around this restriction in the following methods:

- Bypass the autoplay block when the audio playback fails.
- Create a user interaction before the audio playback.

<div class="alert info">Regardless of which method you choose, autoplay with sound is impossible before user interaction. As the number of visits on a webpage increases, the browser adds it to the autoplay whitelist, but this information is not accessible by JavaScript.</div>

## Bypass the autoplay block when the audio playback fails

You can listen for the [AgoraRTC.onAudioAutoplayFailed](./API Reference/web_ng/interfaces/iagorartc.html#onaudioautoplayfailed) callback. When detecting an audio autoplay failure, prompt the user to interact with the webpage to resume the playback.

The following code demonstrates how to display a button for the user to click when autoplay fails.

<div class="alert info">If you call play for multiple audio tracks, the <code>onAudioAutoplayFailed</code> callback is triggered multiple times. The example uses the <code>isAudioAutoplayFailed</code> object to avoid repeatedly creating buttons.</div>

```javascript
let isAudioAutoplayFailed = false;
 AgoraRTC.onAudioAutoplayFailed = () => {
  if (isAudioAutoplayFailed) return;
  
  isAudioAutoplayFailed = true;
  const btn = document.createElement("button");
  btn.innerText = "Click me to resume the audio playback";
  btn.onClick = () => {
    isAudioAutoplayFailed = false;
    btn.remove();
  };
  document.body.append(btn);
};
```

## Create a user interaction before the audio playback

In your UI design, ensure that the user has interacted with the webpage before you call the `remoteAudioTrack.play` or `localAudioTrack.play` method. You can instruct the user to click on or touch the webpage. This method can work around almost all the autoplay block for the browsers on your PC, but does not apply to iOS Safari or WebView. See the following section for our suggested workaround for iOS Safari and WebView.

### Handle autoplay policy on iOS Safari or WebView

iOS Safari or WebView has a stricter autoplay policy. It only allows playback with sound that is triggered by user interaction, and does not remove the autoplay block after a user interaction.

If your app works on iOS Safari or WebView, we recommend handling autoplay in the following way:

- Display a mute icon for each remote user on the playback interface showing that the user is muted, and instruct the local user to click on (or touch) the icon.
- When the local user clicks on (or touches) the icon of a remote user, play the audio track of the remote user in the event callback and toggle the mute icon.

```
// HTML
<div id="user1-audio">Muted</div>
```

```javascript
// JavaScript
document.getElementById("user1-audio").onClick = (e) => {
    if (user1.audioTrack.isPlaying) {
        user1.audioTrack.stop();
        e.target.innerHTML = "Muted";
        return;
    }
    user1.audioTrack.play();
    e.target.innerHTML = "Playing";
}
```