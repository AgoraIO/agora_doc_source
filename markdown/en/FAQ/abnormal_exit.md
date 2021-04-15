---
title: How does an app crash affect cloud recording?
platform: ["RESTful"]
updatedAt: 2020-06-04 09:26:51
Products: ["cloud-recording"]
---
If an app integrated with cloud recording crashes, the recording session is not affected. You can continue to use the original resource ID and recording ID to control the recording instance, such as to query recording status or stop recording.


<div class="alert note">Do not call <code>acquire</code> or <code>start</code> again with the same App ID, channel name and UID, which may cause an error or create a new recording instance.</div>