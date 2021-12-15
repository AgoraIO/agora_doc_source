---
title: 屏幕共享
platform: Windows
updatedAt: 2021-01-12 08:49:33
---

## 功能简介

在视频通话或互动直播中进行屏幕共享，可以将说话人或主播的屏幕内容，以视频的方式分享给其他说话人或观众观看，以提高沟通效率。

屏幕共享在如下场景中应用广泛：

- 视频会议场景中，屏幕共享可以将讲话者本地的文件、数据、网页、PPT 等画面分享给其他与会人；
- 在线课堂场景中，屏幕共享可以将老师的课件、笔记、讲课内容等画面展示给学生观看。

## 实现方法

在开始屏幕共享前，请确保你已完成环境准备、安装包获取等步骤，详见 [集成客户端](./windows_video)。

```cpp
//cpp
// 1. start screensharing

if (lpRect != NULL) { // share some area on window
	rect.left = lpRect->left;
	rect.right = lpRect->right;
	rect.top = lpRect->top;
	rect.bottom = lpRect->bottom;

	lpAgoraEngine->startScreenCapture(hWnd, nFPS, &rect, nBitrate);
} else { // share the window by window id(hWnd), 0 means the full screen
	lpAgoraEngine->startScreenCapture(hWnd, nCapFPS, NULL, nBitrate);
}

// 2. stop screensharing

lpAgoraEngine->stopScreenCapture();
```
