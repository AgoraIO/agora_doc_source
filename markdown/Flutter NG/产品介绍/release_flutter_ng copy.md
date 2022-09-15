## v6.0.0-rc.1 ( Native v4.0.0)

v6.0.0 was released on xx xx, 2022.

#### Compatibility changes

This release changed SDK package name from `agora_rtc_ng` to `agora_rtc_engine`, and optimized the implementation of some features, resulting in incompatibility with v5.x. The following are the main features with compatibility changes:

- Multiple channel
- Media stream publishing control
- Custom video capture and renderer (Media IO)
- Error codes and warning codes
- After upgrading the SDK, you need to update the code in your app according to the business scenarios. See [Migration guides](./migration_guide_flutter_ng) for details.

#### New features

1. Multiple media tracks
This release supports creating one RtcEngine instance through ChannelMediaOptions to collect multiple audio and video sources  at the same time and publish these sources in a channel. It allows you to adapt to various business scenarios, including the following:

Call the joinChannelEx method to join a channel and set publishSecondaryCameraTrack in ChannelMediaOptions as true to publish video tracks captured by cameras or screens.
Simultaneously publish a video stream from a media player, a screen sharing stream, a video stream captured by a camera, and a self-captured video stream.
Simultaneously publish the audio stream captured by a single-channel microphone, self-captured, and the audio stream of the media player.
This release also supports custom video capturing through createCustomVideoTrack. You can refer to the following steps to publish custom video sources in multiple channels:

Create a custom video track: Call the createCustomVideoTrack method to create a custom video track and get the track ID.
Choose a video track to publish: Set customVideoTrackId in ChannelMediaOptions as the ID of the video track that you want to publish in your channel and set publishCustomVideoTrack as true.
Publish external video sources: Call the pushVideoFrame method, set videoTrackId as the video track ID you set in step 2.
You can also use the multi-channel capability when publish media streams:

Publish multiple sets of audio and video streams to the remote users through different user IDs (uid).
Mix multiple audio streams and publish to the remote users through a user ID (uid).
Combine multiple video streams and publish them to the remote users through a user ID (uid).
2. Ultra HD resolution (Beta)
In order to improve the interactive video experience, the SDK optimizes the whole process of video capture, encoding, decoding and rendering, and supports 4K resolution. The improved FEC (Forward Error Correction) algorithm enables adaptive switches according to the frame rate and number of video frame packets, which further reduces the video stuttering rate in 4K scenes.

Besides, you can set the encoding resolution to 4K (3840 × 2160) and frame rate to 60 fps when calling SetVideoEncoderConfiguration. The SDK supports automatic fallback to the appropriate resolution and frame rate if your device does not support 4K.

This feature has certain requirements on device performance and network bandwidth, and the supported upstream and downstream frame rates vary on different platforms. To enable this feature, submit a ticket.

3. Agora media player
To make it easier for users to integrate the Agora SDK and reduce the SDK's package size, this release introduces the Agora media player.  You can then call the methods in the MediaPlayer class to experience a series of functions:

Plays local and online media files.
Preloads media files.
Changes the CDN route for playing media files according your network conditions.
Shares the audio and video streams being played with remote users.
Caches data when playing media files.
4. Brand-new AI noise reduction
The SDK supports a new version of AI noise reduction (versus the basic AI noise reduction in v3.7.0). Compared to the previous AI noise reduction, the new AI noise reduction has better vocal fidelity, cleaner noise suppression, and add the Dereverberation capability. To enable this feature, contact sales@agora.io.

5. Ultra-high audio quality
To make audios sound clearer and stay true to the original sound of audio files, this release adds the ultraHighQualityVoice enumeration. In scenarios that involve human voices, such as chatting or singing, you can call setVoiceBeautifierPreset and use this enumeration to experience ultra-high audio quality.

6. Spatial audio
This feature is in experimental status. To enable this feature, contact sales@agora.io. Contact Technical Support if needed.

This version provides the following solutions:

Local Cartesian Coordinate System Calculation Solution between local users and remote users: This solution uses the LocalSpatialAudioEngine class to implement spatial audio by calculating the spatial coordinates of the remote user. You need to call updateSelfPosition and updateRemotePosition to update the spatial coordinates of the local and remote users respectively, so that the local user can hear the spatial audio of the remote user.

Local Cartesian Coordinate System Calculation Solution between users and media players: This solution uses the LocalSpatialAudioEngine class to implement spatial audio. You need to call updateSelfPosition and updatePlayerPositionInfo to update the spatial coordinates of the local user and media player respectively, so that the local user can hear the spatial audio of media player.

7. Real-time chorus
This release gives real-time chorus the following abilities:

Two or more choruses are supported.
Each singer is independent of each other. If one singer fails or quits the chorus, the other singers can continue to sing.
Very low latency experience. Each singer can hear each other in real time, and the audience can also hear each singer in real time.
This release adds the audioScenarioChorus enumeration in AudioScenarioType. With this enumeration, users can experience ultra-low latency in real-time chorus when the network conditions are good.

8. Extensions from the Agora extensions marketplace
In order to enhance the real-time audio and video interactive activities based on the Agora SDK, this release supports the one-stop solution for the extensions from the Agora extensions marketplace:

Easy to integrate: The integration of modular functions can be achieved simply by calling an API, and the integration efficiency is improved by nearly 95%.
Extensibility design: The modular and extensible SDK design style endows the Agora SDK with good extensibility, which enables developers to quickly build real-time interactive apps based on the Agora extensions marketplace ecosystem.
Build an ecosystem: A community of real-time audio and video apps has developed that can accommodate a wide range of developers, offering a variety of extension combinations. After integrating the extensions, developers can build richer real-time interactive functions. 
Become a vendor: Vendors can integrate their products with Agora SDK in the form of extensions, display and publish them in the Agora extensions marketplace, and build a real-time interactive ecosystem for developers together with Agora. 
9. Enhanced channel management
To meet the channel management requirements of various business scenarios, this release adds the following functions to the ChannelMediaOptions structure:

Sets or switches the publishing of multiple audio and video sources.
Sets or switches channel profile and user role.
Sets or switches the stream type of the subscribed video.
Controls audio publishing delay.
Set ChannelMediaOptions when calling joinChannel or joinChannelEx to specify the publishing and subscription behavior of a media stream, for example, whether to publish video streams captured by cameras or screen sharing, and whether to subscribe to the audio and video streams of remote users. After joining the channel, call updateChannelMediaOptions to update the settings in ChannelMediaOptions at any time, for example, to switch the published audio and video sources.

10. Screen sharing
This release optimizes the screen sharing function. You can enable this function through the following ways.

On Windows and macOS:

Call the startScreenCaptureByDisplayId method before joining a channel, and then call joinChannel [2/2] to join a channel and set publishScreenTrack or publishSecondaryScreenTrack as true.
Call the startScreenCaptureByDisplayId method after joining a channel, and then call updateChannelMediaOptions to set publishScreenTrack or publishSecondaryScreenTrack as true.
On Android and iOS:

Call the startScreenCapture method before joining a channel, and then call joinChannel [2/2] to join a channel and set publishScreenCaptureVideo as true.
Call the startScreenCapture method after joining a channel, and then call updateChannelMediaOptions to set publishScreenCaptureVideo as true.
11. Subscription whitelists and blacklists
This release introduces subscription whitelists and blacklists for remote audio and video streams. You can add the user ID that you want to subscribe to in your whitelist, or in your blacklist if you do not want to subscribe to. You can experience this feature through the following APIs, and in scenarios that involve multiple channels, you can call the following methods in the RtcEngineEx interface.

setSubscribeAudioBlacklist：Set the audio subscription blacklist.
setSubscribeAudioWhitelist：Set the audio subscription whitelist.
setSubscribeVideoBlacklist：Set the video subscription blacklist.
setSubscribeVideoWhitelist：Set the video subscription whitelist.
If a user is added in a blacklist and whitelist at the same time, only the blacklist takes effect.

12. Set audio scenarios
To make it easier to change audio scenarios, this release adds the setAudioScenario method. For example, if you want to change the audio scenario from AudioScenarioDefault to AudioScenarioGameStreaming when you are in a channel, you can call this method.

13. Replace video feeds with images
This release supports replacing video feeds with images when publishing video streams. You can call the enableVideoImageSource method to enable this function and choose your own images through the options parameter.  If you disable this function, the remote users see the video feeds that you publish.

14. Local video transcoder
This release introduces local video transcoder with which you can locally merge multiple video streams into one. Common scenarios are as follows:

When streaming or using media push, you can merge the frames of multiple anchors into one locally. 

To do this, you should merge multi-channel video streams collected locally (such as video captured by camera, screen sharing stream, video files and pictures) into one video stream. Then, release the merged stream in the channel.  

You can call the startLocalVideoTranscoder method to enable the local video transcoder and call the stopLocalVideoTranscoder method to stop the local video transcoder; After the local video transcoder is enabled, you can call updateLocalTranscoderConfiguration to update the configuration of the local video transcoder. 

15. Video device management
A video capture device may support a variety of video formats, each of which supports a different combination of video frame width, video frame height, and frame rate.

This release introduces the numberOfCapabilities and getCapability method to obtain the number of video formats supported by video capture devices and the details of video frames under specified video formats. When you call the startPrimaryCameraCapture or startSecondaryCameraCapture method to capture video using camera, you can obtain the video with the specified video format. 
The SDK will automatically select the video format for video capture equipment according to your settings in VideoEncoderConfiguration. In general, you don't need to use this set of new methods. 



#### Improvements

1. Fast channel switching
This release can achieve the same switching speed as switchChannel in v3.7.0 through the leaveChannel and joinChannel methods so that you don't need to take the time to call the switchChannel method.

2. Push external video frames
This releases supports pushing video frames in I422 format. You can call the  pushVideoFrame[1/2] method to push such video frames to the SDK.

3. Voice pitch of the local user
This release adds voicePitch in AudioVolumeInfo of onAudioVolumeIndication. You can use voicePitch to get the local user's voice pitch and perform business functions such as rating for singing.

4. Video preview
This release improves the implementation logic of startPreview. You can call the startPreview method to enable video preview at any time.

5. Video types of subscription
You can call the setRemoteDefaultVideoStreamType method to choose the video stream type when subscribing streams.

