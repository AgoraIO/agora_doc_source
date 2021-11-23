Agora recommends using any of the following stream-pushing softwares to push streams to FLS:
- [OBS](https://obsproject.com) (Open Broadcaster Software), which supports macOS, Windows and Linux.
- [XSplit Broadcaster](https://www.xsplit.com/broadcaster), which supports Windows.

This page takes OBS as an example to show the configurations of the stream-pushing softwares.

## Prerequisites

- OBS has been installed.
- The stream-pushing domain name and the stream-playing domain name have been configured.
   The domain name configuration function is in the beta stage. Contact sales@agora.io before using it.

## Set the streaming service

To set the streaming service, refer to the following steps:

1. Get the URL for pushing a live stream, see [Construct the URL for the Live Streaming](https://docs.agora.io/cn/fusion-cdn-streaming/streaming-url-fls?platform=RESTful).
2. Open OBS, and click the **Settings** button in the widget list in the right bottom corner. ![
   open obs setting](https://web-cdn.agora.io/docs-files/1637227546202)
3. Click **Stream** in the left navigation menu in the Settings window, and choose **Custom...** in Service.
3. Fill in Server and Stream Key in accordance with the URL for pushing a live stream, as shown in the following figure:
   ![obs url rule](https://web-cdn.agora.io/docs-files/1637227436146)
   For example, if the URL is rtmp://push.agora.io/live/test?ts=1635004800&sign=95b0a9970c593819, then the settings are as follows:
   - Server: rtmp://push.agora.io/live
   - Stream Key: test?ts=1635004800&sign=95b0a9970c593819
      ![obs example setting](https://web-cdn.agora.io/docs-files/1637227399558)
5. Click **OK** to save the settings.

## The stream encoding parameters

Agora recommends the following stream encoding parameters:

| Encoding parameters | Recommended configuration |
| :------------- | :----------------------------------------------------------- |
| Video codec types | H.264, encoder x264 |
| Audio codec types | AAC |
| Bitrate (kbps)  | For setting the parameters in accordance with the resolution and the frame rate of the video, see  [Live Bitrate<p>(Kbps, for Live Broadcasting)](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8 in the Video Bitrate Table.) |
| Keyframe interval | 2 seconds |

Agora recommends setting the default values of the other encoding parameters, or consulting Agora technical support.
