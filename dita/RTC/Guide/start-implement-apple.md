# Implement a client for [product-name]

This section shows how to use the [sdk-name] to implement [feature] in your app step by step.

## Create the UI

In the interface, you should have one frame for local video and another for remote video. In `ViewController.swift`, replace any existing content with the following:

<pre props="ios" outputclass="language-swift">import UIKit
class ViewController: UIViewController {
    var localView: UIView!
    var remoteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
     }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
    }
    func initView() {
        remoteView = UIView()
        self.view.addSubview(remoteView)
        localView = UIView()
        self.view.addSubview(localView)
    }
}</pre>

<pre props="mac" outputclass="language-swift">import AppKit
class ViewController: NSViewController {
     var localView: NSView!
     var remoteView: NSView!
     override func viewDidLoad() {
         super.viewDidLoad()
         initView()
     }
    override func viewDidLayout() {
        super.viewDidLayout()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
    }
    func initView() {
        remoteView = NSView()
        self.view.addSubview(remoteView)
        localView = NSView()
        self.view.addSubview(localView)
    }
}</pre>

## Implement the [product-name] logic

When your app opens, you create an `AgoraRtcEngineKit` instance, <ph props="video live">enable the video, </ph>
join a channel, and <ph props="live">if the local user is a host, </ph>publish the local video to the lower
frame layout in the UI. When another [host] joins the channel,
your app catches the join event and adds the remote video to the top frame layout in the UI.

The following figure shows the API call sequence of implementing [product-name].

![start-api-sequence-apple]

To implement this logic, take the following steps:

1. Import the Agora kit and add the `agoraKit` variable. Modify your `ViewController.swift` as follows:

<pre outputclass="language-swift">import <ph keyref="ui-lib"></ph>
// Add this line to import the Agora kit 
import AgoraRtcKit
class ViewController: <ph keyref="ui-view"></ph>Controller {
   var localView: <ph keyref="ui-view"></ph>!
   var remoteView: <ph keyref="ui-view"></ph>!
   // Add this linke to add the agoraKit variable
   var agoraKit: AgoraRtcEngineKit?
}
override func viewDidLoad() {
   super.viewDidLoad()
   initView()
}</pre>

2. Initialize the app and join the channel.

    Call the core methods to initialize the app and join a channel. In this example app, this functionality is encapsulated in the `initializeAndJoinChannel` function.

    In `ViewController.swift`, add the following lines after the `initView` function, and fill in your App ID, temporary token, and channel name:

    <p props="video" conref="conref/get-started-sample-code-apple.dita#get-started-sample-code/init-video"/>
    <p props="live" conref="conref/get-started-sample-code-apple.dita#get-started-sample-code/init-live"/>

3. Add the remote interface when a remote [host] joins the channel.

    In `ViewController.swift`, add the following lines after the `ViewController` class:

    <pre outputclass="language-swift">extension ViewController: AgoraRtcEngineDelegate {
         // This callback is triggered when a remote <ph keyref="host"></ph> joins the channel
         func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
             let videoCanvas = AgoraRtcVideoCanvas()
             videoCanvas.uid = uid
             videoCanvas.renderMode = .hidden
             videoCanvas.view = remoteView
             agoraKit?.setupRemoteVideo(videoCanvas)
         }
    }</pre>

## Start and stop your app

Now you have created the [feature] functionality, add the functionality of starting and stopping the app.
In this implementation, the [feature] starts when the user opens your app and ends when the user
closes your app.

To implement the functionality of starting and stopping the app:

1. When the view is loaded, call `initializeAndJoinChannel` to join a [feature] channel.

    In `ViewController.swift`, add the `initializeAndJoinChannel` function inside the `viewDidLoad` function:

    ```swift
    override func viewDidLoad() {
           super.viewDidLoad()
           initView()
           // Add this line
           initializeAndJoinChannel()
        }
    ```

2. When the user closes this app, clean up all the resources used by your app.

    In `ViewController.swift`, add `viewDidDisappear` after the `initializeAndJoinChannel` function.

    ```swift
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        agoraKit?.leaveChannel(nil)
        AgoraRtcEngineKit.destroy()
    }
    ```
