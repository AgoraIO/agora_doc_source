---
title: Share the screen
platform: macOS
updatedAt: 2020-12-20 15:54:07
---
## Introduction

During a video call or live broadcast, **sharing the screen** enhances communication by displaying the speaker's screen on the display of other speakers or audience members in the channel.

Screen sharing is applied in the following scenarios:

- In a video conference, the speaker can share an image of a local file, web page, or presentation with other users in the channel.
- In an online class, the teacher can share the slides or notes with students.

## Implementation

Ensure that you implement a video call or an interactive broadcast in your project. For details, see [Start a Call](start_call_mac) or [Start an Interactive Broadcast](start_live_mac).

From v2.4.0, Agora supports the following screen sharing functions on macOS:

- Shares the whole or part of a screen by specifying `displayId`.
- Shares the whole or part of a window by specifying `windowId`.

### Share the whole or part of a screen by specifying displayId

macOS assigns a unique display identifier (displayId) for each screen or display. `displayId` is a 32-bit unsigned integer in the type of CGDirectDisplayID. With this display ID, we can implement screen sharing on macOS with the following steps:

1. Get the display ID for screen sharing.

	```swift
	// Gets the screen list
	let screens = [NSScreen screens];
	for (index, screen) in screens.enumerated() {
		// Gets the displayId.
		guard let displayId = screen.deviceDescription[NSDeviceDescriptionKey(rawValue: "NSScreenNumber")] as? CGDirectDisplayID else {
			continue
		}
	}
	```

   > For more information on displayId, see [App NSScreen](https://developer.apple.com/documentation/appkit/nsscreen).

2. Share the screen by specifying the display ID.

   ```swift
    // swift
    // Starts screen sharing.
    // displayId = 0 means to share the whole screen.
    let displayId = 0
    let rectangle = CGRect.zero
    let parameters = AgoraScreenCaptureParameters()
    parameters.dimensions = CGSize.zero
    parameters.frameRate = 15
    parameters.bitrate = 1000
    agoraKit.startScreenCapture(bydisplayId: displayId, rectangle: rectangle, parameters: parameters)
   
    // Updates the screen sharing parameters.
    let parameters = AgoraScreenCaptureParameters()
    parameters.dimensions = CGSize.zero
    parameters.frameRate = 15
    parameters.bitrate = 1000
    agoraKit.update(parameters)
   
    // Updates the screen sharing region.
    let region = CGRect.zero
    agoraKit.updateScreenCaptureRegion(region)
   
    // Sets the screen sharing content hint.
    agoraKit.setScreenCapture(.none)
   
    // Stops screen sharing.
    agoraKit.stopScreenCapture()
   
   ```

   ```objective-c
    // objective-c
    // Starts screen sharing.
    // displayId = 0 means to share the whole screen.
    NSUInteger displayId = 0;
    CGRect rectangle = CGRectZero;
    AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
    parameters.dimensions = CGSizeZero;
    parameters.frameRate = 15;
    parameters.bitrate = 1000;
    [self.agoraKit startScreenCaptureByDisplayId:displayId rectangle:rectangle parameters:parameters];
   
    // Updates the screen sharing parameters.
    AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
    parameters.dimensions = CGSizeZero;
    parameters.frameRate = 15;
    parameters.bitrate = 1000;
    [self.agoraKit updateScreenCaptureParameters:parameters];
   
    // Updates the screen sharing region.
    CGRect region = CGRectZero;
    [self.agoraKit updateScreenCaptureRegion:region];
   
    // Sets the screen sharing content hint.
    [self.agoraKit setScreenCaptureContentHint:AgoraVideoContentHintNone];
   
    // Stops screen sharing.
    [self.agoraKit stopScreenCapture];
   ```

### Share the whole or part of a window by specifying windowId

macOS assigns a unique window identifier (windowId) for each window. `windowId` is a 32-bit unsigned integer in the type of CGWindowID. With this window ID, we can implement window sharing on macOS with the following steps:

1. Get the window ID for window sharing.

   ```objective-c
   // Gets the window ID.
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

   > For more information on windowId, see [Apple CGWindowListCopyWindowInfo(::)](https://developer.apple.com/documentation/coregraphics/1455137-cgwindowlistcopywindowinfo).

2. Share the window by specifying the window ID.

   ```swift
    // swift
    // Starts sharing the window.
    // windows Id = 0 means to share the whole window.
    let windowId = 0
    let rectangle = CGRect.zero
    let parameters = AgoraScreenCaptureParameters()
    parameters.dimensions = CGSize.zero
    parameters.frameRate = 15
    parameters.bitrate = 1000
    agoraKit.startScreenCapture(byWindowId: windowId, rectangle: rectangle, parameters: parameters)
   
    // Updates the screen sharing parameters.
    let parameters = AgoraScreenCaptureParameters()
    parameters.dimensions = CGSize.zero
    parameters.frameRate = 15
    parameters.bitrate = 1000
    agoraKit.update(parameters)
   
    // Updates the screen sharing region.
    let region = CGRect.zero
    agoraKit.updateScreenCaptureRegion(region)
   
    // Sets the screen capture content hint.
    agoraKit.setScreenCapture(.none)
   
    // Stops sceen sharing.
    agoraKit.stopScreenCapture()
   ```

   ```objective-c
    // objective-c
    // Starts sharing the window.
    // windows Id = 0 means to share the whole window.
    NSUInteger windowId = 0;
    CGRect rectangle = CGRectZero;
    AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
    parameters.dimensions = CGSizeZero;
    parameters.frameRate = 15;
    parameters.bitrate = 1000;
    [self.agoraKit startScreenCaptureByWindowId:windowId rectangle:rectangle parameters:parameters];
   
    // Updates the screen sharing parameters.
    AgoraScreenCaptureParameters *parameters = [[AgoraScreenCaptureParameters alloc] init];
    parameters.dimensions = CGSizeZero;
    parameters.frameRate = 15;
    parameters.bitrate = 1000;
    [self.agoraKit updateScreenCaptureParameters:parameters];
   
    // Updates the screen sharing region.
    CGRect region = CGRectZero;
    [self.agoraKit updateScreenCaptureRegion:region];
   
    // Sets the screen sharing content hint.
    [self.agoraKit setScreenCaptureContentHint:AgoraVideoContentHintNone];
   
    // Stops screen sharing.
    [self.agoraKit stopScreenCapture];
   ```

  
### API Reference
* [`startScreenCaptureByDisplayId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByDisplayId:rectangle:parameters:)
* [`startScreenCaptureByWindowId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByWindowId:rectangle:parameters:)
* [`updateScreenCaptureParameters`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateScreenCaptureParameters:)
* [`setScreenCaptureContentHint`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setScreenCaptureContentHint:)
* [`updateScreenCaptureRegion:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateScreenCaptureRegion:)
* [`stopScreenCapture`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopScreenCapture)

## Considerations

- v2.4.0 deprecates the `startScreenCapture` method. You can still use it, but we no longer recommend it.
- Changing `AgoraScreenCaptureParameters` may affect your communication chargers. As of v2.4.1, if you set the `dimendions` parameter as default, Agora uses 1920 x 1080 to calculate the charges.