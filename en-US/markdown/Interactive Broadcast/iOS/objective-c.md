## Project setup

In Xcode, follow the steps to create the environment necessary to add live streaming into your app.

1. [Create a new project](https://help.apple.com/xcode/mac/current/#/dev07db0e578) for iOS using the **Single View App** template. Make sure you select **Swift** as the language and **Storyboard** as the user interface.

   <div class="alert note">If you have not added any team information, you can see an **Add account...** button. Click it, input your Apple ID, and click **Next** to add your team.</div>

2. Integrate the Video SDK into your project.

   Go to **File** > **Swift Packages** > **Add Package Dependencies...**, and paste the following link:

   `https://github.com/AgoraIO/AgoraRtcEngine_iOS`

<div class="alert note"><li>This method applies to v3.4.3 or later. For more integration methods, see <a href="#othermethods">Other approaches to integrating the SDK</a></li><li>If you have issues installing this Swift Package, try going to <b>File</b> > <b>Swift Packages</b> > <b>Reset Package Caches</b>.</li></div>

3. [Enable automatic signing](https://help.apple.com/xcode/mac/current/#/dev23aab79b4) for your project.
4. [Set the target devices](https://help.apple.com/xcode/mac/current/#/deve69552ee5) to deploy your iOS app.
5. Add permissions for microphone and camera usage.
   Open the `info.plist` file in the left navigation panel, and [edit the property list](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6) to add the following properties:
   - Privacy - Microphone Usage Description
   - Privacy - Camera Usage Description

## Implement a client for Interactive Live Streaming Premium

This section shows how to use the Agora Video SDK to implement live streaming in your app step by step.

### Create the UI

In the interface, you should have one frame for local video and another for remote video. In `ViewController.swift`, replace any existing content with the following:

```objective-c
// In ViewController.m, replace any existing content with the following
#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (nonatomic, strong) UIView *localView;
@property (nonatomic, strong) UIView *remoteView;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.remoteView.frame = self.view.bounds;
    self.localView.frame = CGRectMake(self.view.bounds.size.width - 90, 0, 90, 160);
}

- (void)initViews {
    self.remoteView = [[UIView alloc] init];
    [self.view addSubview:self.remoteView];
    self.localView = [[UIView alloc] init];
    [self.view addSubview:self.localView];
}
@end
```

### Implement the Interactive Live Streaming Premium logic

When your app opens, you create an `RtcEngine` instance, enable the video, join a channel, and if the local user is a host, publish the local video to the lower frame layout in the UI. When another host joins the channel, your app catches the join event and adds the remote video to the top frame layout in the UI.

The following figure shows the API call sequence of implementing Interactive Live Streaming Premium.

![api_sequence](./api_sequence.png)

To implement this logic, take the following steps:

1. Import the Agora kit.

   In `ViewController.swift`, add the following line after `import UIKit`:

   ```objective-c
   // In ViewController.h, replace lines after #import <UIKit/UIKit.h> with the following
   #import <AgoraRtcKit/AgoraRtcEngineKit.h>

   @interface ViewController : UIViewController <AgoraRtcEngineDelegate>
   @property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

   @end
   ```

2. Initialize the app and join the channel.

   Call the core methods for initializing the app and joining a channel. In the following sample code, we use an `initializeAndJoinChannel` function to encapsulate these core methods.

   In `ViewController.swift`, add the following lines after the `initView` function:

   ```objective-c
   // In ViewController.m, add the following after - (void)initViews
    - (void)initializeAndJoinChannel {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"9619ab7b94764269a5298717f8e0c3f8" delegate:self];
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit enableVideo];
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.localView;
    [self.agoraKit setupLocalVideo:videoCanvas];
    [self.agoraKit joinChannelByToken:@"0069619ab7b94764269a5298717f8e0c3f8IAByqp0pNrD56KvYvWYzLEew8T3kh7YMJgWaQYqywBOpIr8eNicAAAAAEAAFSFUjOg4FYQEAAQA6DgVh" channelId:@"demochannel" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
}];
    }
   ```

3. Add the remote interface when a remote host joins the channel.

   In `ViewController.swift`, add the following lines after the `ViewController` class:

    ```objective-c
    // In ViewController.m, add after initializeAndJoinChannel
    - (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.remoteView;
    [self.agoraKit setupRemoteVideo:videoCanvas];
   }
    ```

### Start and stop your app

Now you have created the Interactive Live Streaming Premium functionality, start and stop the app. In this implementation, a live stream starts when the user opens your app. The live stream ends when the user closes your app.

1. When the view is loaded, call `initializeAndJoinChannel` to join a live streaming channel.

   In `ViewController.swift`, add the `initializeAndJoinChannel` function inside the `viewDidLoad` function:.

    ```objective-c
    - (void)viewDidLoad {
     [super viewDidLoad];
         [self initViews];
         // Add this line
         [self initializeAndJoinChannel];
    }
    ```
   
2. When the user closes this app, clean up all the resources used by your app.

   In `ViewController.swift`, add `applicationWillTerminate` after the `initializeAndJoinChannel` function.

    ```objective-c
    // In ViewController.m, add this at the end
    - (void)applicationWillTerminate:(NSNotification *)notification{
        [self.agoraKit leaveChannel:nil];
        [AgoraRtcEngineKit destroy];
    }
    ```
