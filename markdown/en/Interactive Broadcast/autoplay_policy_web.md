---
title: Deal with Autoplay Blocking
platform: Web
updatedAt: 2021-02-07 11:03:58
---
## Overview

To prevent the webpage from playing sound without permission, most web browsers restrict the autoplay function: Autoplay with sound is blocked unless the user has interacted with the webpage.

This restriction policy is intended to improve the user experience, because autoplay with sound may be against the users' deliberate intention.

The policy may cause playback issues. This document describes how to get around this restriction for the following scenarios:

- Bypass the autoplay block when the playback fails.
- Bypass the autoplay block in advance.

<div class="alert note">This document applies to the Agora <a href="https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#rtc-sdk">RTC SDK</a> for Web.</div>

## Bypass the autoplay block when the playback fails

The `Stream.play("ID")` method reports an error in the callback function when the playback fails due to the autoplay block. We can resume the playback in the failure callback. As the visit number increases, the browser will add the webpage to its autoplay whitelist.

When detecting an autoplay block, instruct the user to click on the webpage to resume the playback:

```javascript
 stream.play("agora_remote"+ stream.getId(), function(err){
         if (err && err.status !== "aborted"){
                // The playback fails. Guide the user to resume the playback by clicking.            
                document.querySelector("#agora_remote"+ stream.getId()).onclick=function(){
                         stream.resume().then(
                         function (result) {
                               console.log('Resume succeeds: ' + result);
                        }).catch(
                         function (reason) {
                               console.log('Resume fails: ' + reason);
                        });
                }      
        }
 });
```

Usually the autoplay policy does not affect the local streams (because we do not play the sound of the local streams), so you only need to deal with the remote streams.

## Bypass the autoplay block in advance

If you prefer dealing with the autoplay block in advance, choose one of the following methods:

- Method one: Play the stream without sound first by `Stream.play("ID", { muted: true })`, because autoplay without sound is allowed.
- Method two: In your UI design, instruct the user to interact with the webpage, either by clicking or touching, to play the stream.

If your app requires autoplay without any user interaction, we recommend the first method.

If your app allows user interaction before playing the stream, for example a user needs to click a button to view the broadcaster, we recommend the second method.

<div class="alert note">Regardless of which method you choose, autoplay with sound is impossible before user interaction. Although the browser maintains a whitelist to allow autoplay for some websites, this information is not accessible by JavaScript.</div>

### Method one: Mute the stream first

Play the stream without sound first, and unmute it when the user interacts with the webpage.

1. Register a global event listener at the beginning of your code:

   ```javascript
   document.body.addEventListener("touchstart") // Listen for the touch action
   ```

   Or

   ```javascript
   document.body.addEventListener("mousedown") // Listen for the click action.
   ```

2. Get the `Stream` objects for playback by `createStream` or by subscribing to the remote users, and play these objects without sound immediately. Save these objects in an internal list object `playingStreamList` in the meantime.

   ```javascript
   Stream.stop()
   Stream.play("ID", { muted: true })
   ```

3. In the event listener registered in step 1, play the `Stream` objects in `playingStreamList` with sound. 

   ```javascript
   Stream.play("ID", { muted: false })
   ```

### Method two: Create a user interaction before the playback

If the user has interacted with the webpage before playing the stream, autoplay with sound is allowed.This method can work around almost all the autoplay block for the browsers on your PC, but does not apply to iOS Safari or WebView. See the following section for our suggested workaround for iOS Safari and WebView.

### Handle autoplay policy on iOS Safari or WebView

iOS Safari or WebView has a stricter autoplay policy. It only allows playback with sound that is triggered by user intervention, and does not remove the autoplay block after a user intervention.

If your app works on iOS Safari or WebView, we recommend handling autoplay in the following way:

- Play the streams without sound first: `Stream.play("ID", { muted: true })`.
- Bind the user interaction event (click or touch) to the `HTMLElement` container, which is specified by each `Stream.play` method call.
- Display a mute icon on the playback interface showing that the stream is muted, and instruct the user to click on (or touch) the interface.
- When the user clicks on (or touches) the interface, play the stream with sound again in the event callback and toggle the mute icon.

  ```javascript
  Stream.stop()
  Stream.play("ID", { muted: true })
  ```

Given the stricter autoplay policy on iOS Safari, Agora RTC SDK for Web sets `<video controls>` to display the `<video>` element of the Safari browser by default. Even if you do nothing to the autoplay block, users can play a stream with sound by clicking the default playback button that the `<video>` element provides.