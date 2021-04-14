---
title: What are the common error messages to expect in Web browsers' console logs?
platform: ["Web"]
updatedAt: 2020-06-09 11:17:30
Products: ["Voice","Video","Interactive Broadcast"]
---
After integrating the Agora Web SDK into your web app, you can debug your code using the console log. This document lists the common errors in the console log.

## Cannot read property "appendChild" of null

### Reason

The played DOM does not exist, or the element ID cannot be found.

### Solution

Ensure that the parent DOM exists when you call  `Stream.play`.

## Cannot read property 'stringuid' of undefined

### Reason

You have called `Stream.publish`  before the `Client.join`  method call succeeds.

### Solution

Check your code logic and ensure that you call `Stream.publish` after the `Client.join`  method call succeeds.

## Connect choose server timeout

Same reason and solution as [Failed to load resource](#resource).

## DTLS failed<a name="DTLS"></a> 

The following table lists the possible reasons and corresponding solutions:

| Reason                                                       | Solution                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| The web browser does not fully support WebRTC.               | Use a [Web browser](https://docs.agora.io/en/faq/browser_support) supporting WebRTC. |
| The web browser has plugins that prevent WebRTC from getting an ICE candidate on the local device. | Disable the problematic browser plugins.                     |
| The user's gateway firewall disables the UDP protocol or the UDP ports greater than 10000. | Disable the firewall or use the [Agora Cloud Proxy](https://docs.agora.io/en/Interactive%20Broadcast/cloud_proxy_web?platform=Web&_ga=2.48236646.1902132163.1591578206-1606769437.1589868329) service. |
| You set the web browser to use the VP8 codec, but the user uses the Safari browser that does not support VP8. | The user can either upgrade the Safari browser to versions later than 12.1, or use the Chrome browser. |
| You set the web browser to use the H.264 codec, but the user's device hardware does not support H.264. | Set the web browser to use VP8.                              |
| Connection issues of a network provider.                     | The user can try switching to a different network, for example, using a cellular data connection. |

If the error persists after troubleshooting, contact support@agora.io.

## Failed to execute 'addStream' on 'RTCPeerConnection': parameter 1 is not of type 'MediaStream'

### Reason

You have called `Stream.publish`  before the `Stream.init`  method call succeeds.

### Solution

Call  `publish`  in the `onSuccess` callback of  `Stream.init`.

## Failed to load resource<a name="resource"></a> 

### Reason

The local DNS resolution fails.

### Solution

The user can change the DNS server address and try joining the channel again.
- For a user in Mainland China, change the DNS server address to `114.114.114.114`.
- For a user outside Mainland China, change the DNS server address to `8.8.8.8`.

## Failed to set remote answer sdp: Called in wrong state: kStable

This error is caused by calling `switchDevice`  and can be ignored.

## Media access MEDIA_NOT_SUPPORT: video/audio streams not supported yet /enumerateDevices() not supported

### Reason

Possible reasons:

- The web browser is incompatible with the Agora Web SDK.
- HTTPS protocol is not used.
- Localhost is not used.

### Solution

- Use a supported [Web browser](https://docs.agora.io/en/faq/browser_support).
- Deploy your web app through HTTPS or localhost.

## Invalid elementID

### Reason

 The `HTMLElementID`  specified in `Stream.play`  is invalid.

### Solution

Ensure that the string in `HTMLElementID` contains only "_", "-", ".", or any digits and letters in the ASCII character set. The string must be non-empty and less than 256 bytes in length.

## INVALID_VENDOR_KEY

### Reason

Possible reasons:

- The App ID is invalid. For example, the Agora project is disabled, or the App ID is not yet active within a newly created project.
- The token is invalid.

### Solution

Check your settings for `appId` in  `Client.init` and `tokenOrKey`  in  `Client.join`. Ensure that the App ID and token are correct and valid.

## NO_CANDIDATES_IN_OFFER

Same reason and solution as [None Ice Candidate not allowed](#candidate).

## None Ice Candidate not allowed<a name="candidate"></a> 

### Reason

When establishing a WebRTC connection, the SDK fails to find any [ICE](https://developer.mozilla.org/en-US/docs/Glossary/ICE) (Interactive Connectivity Establishment) candidate.

<div class="alert info">A candidate contains the IP address and port information for connecting to a remote device.</div>

### Solution

The type of candidates used for connection depends on whether you have enabled [cloud proxy](https://docs.agora.io/en/Interactive%20Broadcast/cloud_proxy_web?platform=Web) or not. Choose one of the following solutions accordingly.

- If you have enabled cloud proxy, the SDK gets relay candidates from a TURN server. Check whether you have whitelisted the IP addresses and ports that Agora provides for cloud proxy, and ensure that the local client can connect to the TURN server.
- If you have not enabled cloud proxy, the SDK gets host candidates from the local device. In this case, the error is usually caused by the security settings of the local device.
  - Check whether the browser has any plugins that disable WebRTC.
  - Ensure that you have enabled UDP in the system firewall, and added the [specified domains and ports](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms#web-sdk) to the whitelist.

## P2P lost

Same reason and solution as [DTLS failed](#DTLS).

## UID_CONFLICT

### Reason

Multiple users joins the channel with the same `uid`.

### Solution

Ensure that all users in a channel have a unique `uid`.

## Uncaught DOMException: Failed to execute 'addTransceiver' on 'RTCPeerConnection': This operation is only supported in 'unified-plan'.

### Reason

A mobile device emulator is running in the web browser.

### Solution

Agora Web SDK does not support emulated mobile devices. Do not use an emulator to debug your app.

## Uncaught TypeError: Failed to execute 'createObjectURL' on 'URL': No function was found that matched the signature provided

### Reason

A mobile device emulator is running in the web browser.

### Solution

Agora Web SDK does not support mobile device emulators. Do not use an emulator to debug your app.

## User is not in the session

### Reason

The connection has not been established. This is usually the result of an incorrect API call sequence, for example, calling  `Client.publish` after `Client.leave`.

### Solution

Check your API call sequence.