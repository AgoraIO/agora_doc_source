---
title: Offline-视频镜像
platform: ["All Platforms"]
updatedAt: 2020-07-09 21:32:26
Products: ["Video","Interactive Broadcast"]
---
## 步骤 1：自检

如果远端看到镜像的视频：检查 App 是否调用了 `setParameters`(audioEngine.remoteVideoMirroring)。

如果是本地预览发生镜像：

* 手机的前置摄像头就是镜像的，属于正常现象；
* 其他情况发生镜像，检查 App 是否调用了 `setParameters`(che.video.localViewMirrorSetting)。

## 步骤 2：联系技术支持

如果镜像问题不属于上述情况，请联系技术支持并提供下列信息：

* 使用了哪个摄像头，是本地预览镜像了还是远端镜像了；
* 希望是镜像效果还是非镜像效果。