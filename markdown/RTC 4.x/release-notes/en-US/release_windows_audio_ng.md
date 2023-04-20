## v4.1.1

 v4.1.1 was released on January xx, 2023.

 #### New features

 **Instant frame rendering**

 This release adds the `enableInstantMediaRendering` method to enable instant rendering mode for audio  frames, which can speed up the first audio frame rendering after the user joins the channel.

 #### Issues fixed

- This release fixed the issue that playing audio files with a sample rate of 48 kHz failed.
- At the moment when a user left a channel, a request for leaving was not sent to the server and the leaving behavior was incorrectly determined by the server as timed out.

 #### API changes

 **Added**

`enableInstantMediaRendering`

