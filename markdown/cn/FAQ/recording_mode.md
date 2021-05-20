---
title: 单流录制模式和合流录制模式有什么区别？
platform: ["Linux","RESTful"]
updatedAt: 2020-07-09 21:23:57
Products: ["Recording","cloud-recording"]
---
如果你想要更灵活的处理录制文件，可以选择单流录制模式。例如，在在线课堂这一场景中，如果父母只想观看老师和自己孩子的视频，你可以选择单流模式，分别录制老师和每位学生的视频，然后将老师的视频分别与每位学生的视频合并。又比如，在内容审核场景中，如果需要识别出发布违规内容的 UID，你可以选择单流模式，分开录制并审核每位用户的音频和视频。

在其他情况下，你可以选择合流录制模式。例如，当你要录制一个连麦直播时，可以选择合流模式，将所有主播的音视频存储在一个文件中，而无需在录制后通过脚本进行合并。

两种录制模式的实现方法和功能描述详见：
* 本地服务端录制：[单流录制](/cn/Recording/recording_individual_mode)和[合流录制](/cn/Recording/recording_composite_mode)。
* 云端录制：[单流录制](/cn/cloud-recording/cloud_recording_individual_mode)和[合流录制](/cn/cloud-recording/cloud_recording_composite_mode)。