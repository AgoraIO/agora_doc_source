---
title: How can I solve issues relating to recording files?
platform: ["Linux"]
updatedAt: 2020-07-09 21:59:26
Products: ["Recording"]
---
### Why aren't there any files generated under the recording folder?

* Check whether you enter the same `appID` and `channelProfile` (Communication or Live Broadcast) as the Agora Native SDK integrated into your app. Communication and Live Broadcast cannot interoperate.
* Check if the recording process successfully joined the channel. Check if the App ID and channel name are valid. If the App Certificate is enabled, ensure that a valid Channel Key or Token is used when joining the channel. You can check the `appID`, channel, and `channelKey` parameters in the recording log, `recording_sys.log`.
* Check if there is any Native/Web user in the channel. At least one Native/Web SDK user is required in the channel for the recording client to generate a recording file. If there is a Native/Web user, ensure that the user sent a stream. If not, the recording file cannot be generated.

### Why is the recording duration of the recorded file incorrect?

If the Native/Web SDK and Recording SDK are in the same channel during the same time, contact Agora customer support.

### Why is there no audio when playing the recorded video?

The recorded audio and video files are independent; the audio is in AAC format, while the video is in MPEG-4 format. The video file does not contain any voice, you need to manually merge the audio and video files into one file. If the recorded files are already transcoded, contact Agora customer support.

### Why can’t I play the MPEG-4 file after the recording is complete?

This is usually because the player is not supported. Refer to the [Supported Players List](https://docs.agora.io/en/faqs/recording_player).

### Why can’t I play the recorded video files after enabling encryption mode?

In encryption mode, if the encryption password is not entered or incorrect, the recorded file does not play. The audio output is corrupted because it is encrypted.

### Why are there only audio files and no video files after recording?

This usually occurs when the Native/Web SDK and Recording SDK use different communication modes. Check the Argus SDK Client Role.

If the same communication mode is used, check the following parameters for the client sending the video and the receiver receiving the video: Video Receive Bitrate, Video Decoder In/Out Frame Rate, and ARS Received H264 Frame Num. If the parameters are fine, check the `recording_sys.log` file.

### Why is there a blank period at the beginning of the recorded and transcoded video during playback?

Possible reasons:

* Poor network conditions.
* The video recording is only created when the I frame of the video packet is received; which means that the previously received B and P frames are ignored.
* The size of each video frame is significantly larger than each voice frame. This means that the voice packet is transmitted quicker and received before the video packet. Once the video packet is received, the recording starts.

### Why is there a black screen when playing the recorded video, but the sound is normal?

This is usually because the player is not supported. Refer to the [Supported Players List](https://docs.agora.io/en/faqs/recording_player).

### Why is the recorded video inverted?

Please upgrade to the latest official version. Contact Agora customer support for any issues.

### What should I do if the audio and video are out of sync when I play the recording file? 

Please upgrade to the latest official version. Contact Agora customer support for any issues.

