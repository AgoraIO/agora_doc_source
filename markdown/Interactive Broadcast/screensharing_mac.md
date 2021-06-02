---
title: 屏幕共享
platform: macOS
updatedAt: 2020-12-20 15:42:01
---
## 功能简介
在视频通话或互动直播中进行屏幕共享，可以将说话人或主播的屏幕内容，以视频的方式分享给其他说话人或观众观看，以提高沟通效率。

屏幕共享在如下场景中应用广泛：

- 视频会议场景中，屏幕共享可以将讲话者本地的文件、数据、网页、PPT 等画面分享给其他与会人；
- 在线课堂场景中，屏幕共享可以将老师的课件、笔记、讲课内容等画面展示给学生观看。

## 实现方法

在开始屏幕共享前，请确保你已完成环境准备、安装包获取等步骤，详见 [集成客户端](./mac_video)。

Agora 在 v2.4.0 对屏幕共享相关接口进行梳理，目前在 macOS 平台上支持：
- 通过 displayId 共享指定屏幕，或指定屏幕的部分区域
- 通过 windowId 共享指定窗口，或指定窗口的部分区域

### 共享指定屏幕
macOS 系统为每个屏幕分配一个 displayId，数据类型为 CGDirectDisplayID，32 位无符号整型。该 ID 对应唯一的 macOS 屏幕。通过获取该 displayId，我们可以按如下步骤在 macOS 平台上实现屏幕共享：

1. 获取想要共享屏幕的 Display ID
```
// 获取屏幕列表
NSArray *screens = [NSScreen screens];
for (NSUInteger i = 0; i < [screens count]; ++i) {
// 获取屏幕详情
NSDictionary* device_description = [[screen objectAtIndex: i] deviceDescription];
// 获取 displayId
CGDirectDisplayID displayId = ([[device_description  objectForKey:@"NSScreenNumber"] intValue]);
}
```
> 更多关于 displayId 的详情，请参考 [Apple NSScreen](https://developer.apple.com/documentation/appkit/nsscreen) 说明。

2. 通过 Display ID 共享屏幕
```
// swift
// 开始共享指定的屏幕
let displayId = 0
let rectangle = CGRect.zero
let parameters = AgoraScreenCaptureParameters()
parameters.dimensions = CGSize.zero
parameters.frameRate = 15
parameters.bitrate = 1000
agoraKit.startScreenCapture(byDisplayId: displayId, rectangle: rectangle, parameters: parameters)
// 更新屏幕共享的编码参数配置
let parameters = AgoraScreenCaptureParameters()
parameters.dimensions = CGSize.zero
parameters.frameRate = 15
parameters.bitrate = 1000
agoraKit.update(parameters)
// 更新屏幕共享区域
let region = CGRect.zero
agoraKit.updateScreenCaptureRegion(region)
// 设置屏幕共享内容类型
agoraKit.setScreenCapture(.none)
// 停止共享屏幕
agoraKit.stopScreenCapture()
```
```
// objective-c 
// 开始共享指定的屏幕
NSUInteger displayId = 0;
CGRect rectangle = CGRectZero;
AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
parameters.dimensions = CGSizeZero;
parameters.frameRate = 15;
parameters.bitrate = 1000;
[self.agoraKit startScreenCaptureByDisplayId:displayId rectangle:rectangle parameters:parameters];
// 更新屏幕共享的编码参数配置
AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
parameters.dimensions = CGSizeZero;
parameters.frameRate = 15;
parameters.bitrate = 1000;
[self.agoraKit updateScreenCaptureParameters:parameters];
// 更新屏幕共享区域
CGRect region = CGRectZero;
[self.agoraKit updateScreenCaptureRegion:region];
// 设置屏幕共享内容类型
[self.agoraKit setScreenCaptureContentHint:AgoraVideoContentHintNone];
// 停止共享屏幕
[self.agoraKit stopScreenCapture];		
```

### 共享指定窗口

macOS 为每个窗口分配一个 windowId，数据类型为 CGWindowID，32 位无符号整型。该 ID 对应唯一的 macOS 窗口。通过获取该 windowId，我们可以按如下步骤在 macOS 平台上实现窗口共享：

1. 获取想要共享窗口的 Window ID
```
// 获取窗口 ID
CFArrayRef window_list = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly | kCGWindowListExcludeDesktopElements, kCGNullWindowID);
if (window_list) {
    CFIndex count = CFArrayGetCount(window_array);
    for (CFIndex  i = 0; i < count; ++i) {
        CFDictionaryRef window = reinterpret_cast<CFDictionaryRef>(CFArrayAtIndex(window_array, i));
        CFStringRef window_title = reinterpret_cast<CFStringRef>(CFDictionaryGetValue(window, kCGWindowName));
        CFNumberRef window_id = reinterpret_cast<CFNumberRef>(CFDictionaryGetValue(window, kCGWindowNumber));
   }
}
```

更多关于 windowId 的详情，请参考 [Apple CGWindowListCopyWindowInfo(::) 说明](https://developer.apple.com/documentation/coregraphics/1455137-cgwindowlistcopywindowinfo)。

2. 通过 Window ID 共享窗口
```
// swift
// 开始共享指定的窗口
let windowId = 0
let rectangle = CGRect.zero
let parameters = AgoraScreenCaptureParameters()
parameters.dimensions = CGSize.zero
parameters.frameRate = 15
parameters.bitrate = 1000
agoraKit.startScreenCapture(byWindowId: windowId, rectangle: rectangle, parameters: parameters)
// 更新屏幕共享的编码参数配置
let parameters = AgoraScreenCaptureParameters()
parameters.dimensions = CGSize.zero
parameters.frameRate = 15
parameters.bitrate = 1000
agoraKit.update(parameters)
// 更新屏幕共享区域
let region = CGRect.zero
agoraKit.updateScreenCaptureRegion(region)
// 设置屏幕共享内容类型
agoraKit.setScreenCapture(.none)
// 停止共享屏幕
agoraKit.stopScreenCapture()
```
```
// objective-c 
// 开始共享指定的窗口
NSUInteger windowId = 0;
CGRect rectangle = CGRectZero;
AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
parameters.dimensions = CGSizeZero;
parameters.frameRate = 15;
parameters.bitrate = 1000;
[self.agoraKit startScreenCaptureByWindowId:windowId rectangle:rectangle parameters:parameters];
// 更新屏幕共享的编码参数配置
AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
parameters.dimensions = CGSizeZero;
parameters.frameRate = 15;
parameters.bitrate = 1000;
[self.agoraKit updateScreenCaptureParameters:parameters];
// 更新屏幕共享区域
CGRect region = CGRectZero;
[self.agoraKit updateScreenCaptureRegion:region];
// 设置屏幕共享内容类型
[self.agoraKit setScreenCaptureContentHint:AgoraVideoContentHintNone];
// 停止共享屏幕
[self.agoraKit stopScreenCapture];
```

### API 参考
* [`startScreenCaptureByDisplayId`](https://docs-preview.agoralab.co/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=2.4#//api/name/startScreenCaptureByDisplayId:rectangle:parameters:)
* [`startScreenCaptureByWindowId`](https://docs-preview.agoralab.co/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=2.4#//api/name/startScreenCaptureByWindowId:rectangle:parameters:)
* [`updateScreenCaptureParameters`](https://docs-preview.agoralab.co/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=2.4#//api/name/updateScreenCaptureParameters:)
* [`updateScreenCaptureRegion:`](https://docs-preview.agoralab.co/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=2.4#//api/name/updateScreenCaptureRegion:)
* [`setScreenCaptureContentHint`](https://docs-preview.agoralab.co/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=2.4#//api/name/setScreenCaptureContentHint:)
* [`stopScreenCapture`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopScreenCapture)