## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.


#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `SetAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- When the sending end mixed and published two streams of video captured by two cameras locally, the video from the second camera was occasionally missing on the receiving end.


## v4.2.0 

v4.2.0 was released on May 23, 2022. This is the first release of the RTC C# SDK.

#### Features

Developed upon RTC Windows SDK v4.2.0, this release covers the major features of the Windows SDK. For details, see [Release Notes for Windows](./release_windows_ng?platform=Windows).

#### Reference

Refer to the following documentations to integrate the SDK into your project, and add real-time engagement functionalities to the app.

- [Get Started with Voice Calling]()
- [Get Started with Video Calling]()
- [Get Started with Interactive Live Streaming Premium]()
- [Get Started with Interactive Live Streaming Standard]()
- [API Reference]()



Agora provides an open-source [Agora CSharp API Example](https://github.com/AgoraIO-Extensions/Agora-C_Sharp-SDK/tree/master/APIExample) on GitHub. You can try it out or refer to the source code.