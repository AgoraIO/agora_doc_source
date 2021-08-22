This article describes how to use the Agora Native SDK to customize the video source. 

## Understand the tech

The Agora SDK uses default audio and video modules for capturing in real-time communications.

However, these default modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own video module.
- You want to use a non-camera source, such as recorded screen data.
- You need to process the captured video with a pre-processing library for functions such as image enhancement.
- You need flexible device resource allocation to avoid conflicts with other services.

Agora provides a solution to enable a custom video source in the above scenarios.

### Video data transfer

The following diagram shows how the video data is transferred when you customize the video source or video renderer:

![](https://web-cdn.agora.io/docs-files/1606791683644)

Video frames captured by the SDK or a custom video source, or received from a remote user, can be rendered by either the SDK or a custom video renderer. You must implement the custom video source yourself using methods from outside the SDK.

## Implementation

### Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

### Implement the workflow

The Agora SDK provides the  [`setExternalVideoSource`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setExternalVideoSource:useTexture:pushMode:) and [`pushExternalVideoFrame`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalVideoFrame:) methods to customize the video source. The API call sequence is as follows:

![](https://web-cdn.agora.io/docs-files/1569400609106)


1. Before joining a channel, call `setExternalVideoSource` to enable the custom video source. Once you enable it, you cannot use the methods of the SDK to capture video frames.

    ```swift
    // Swift
    // Calls setExternalVideoSource to notify the SDK that the app uses the custom video source
    agoraKit.setExternalVideoSource(true, useTexture: true, encodedFrame: true)
    ```

2. Implement the custom video source. Once the custom video source is enabled, you need to implement video capturing using APIs from outside the SDK. In the sample project, we define a class called `AgoraCameraSourcePush` class that captures video frames using the native methods of the system.

    ```swift
    // Swift
    class AgoraCameraSourcePush: NSObject {
        
        fileprivate var delegate: AgoraCameraSourcePushDelegate?
        private var videoView: CustomVideoSourcePreview
        
        private var currentCamera = Camera.defaultCamera()
        private let captureSession: AVCaptureSession
        private let captureQueue: DispatchQueue
        private var currentOutput: AVCaptureVideoDataOutput? {
            if let outputs = self.captureSession.outputs as? [AVCaptureVideoDataOutput] {
                return outputs.first
            } else {
                return nil
            }
        }
        
        // Initializes the custom video source
        init(delegate: AgoraCameraSourcePushDelegate?, videoView: CustomVideoSourcePreview) {
            self.delegate = delegate
            self.videoView = videoView
            
            captureSession = AVCaptureSession()
            captureSession.usesApplicationAudioSession = false
            
            let captureOutput = AVCaptureVideoDataOutput()
            captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
            if captureSession.canAddOutput(captureOutput) {
                captureSession.addOutput(captureOutput)
            }
            
            captureQueue = DispatchQueue(label: "MyCaptureQueue")
            
            // Displays the captured video frames on the view
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoView.insertCaptureVideoPreviewLayer(previewLayer: previewLayer)
        }
        
        deinit {
            captureSession.stopRunning()
        }
        
        // Starts capturing video frames
        func startCapture(ofCamera camera: Camera) {
            guard let currentOutput = currentOutput else {
                return
            }
            
            // Sets the camera as the capturing device
            currentCamera = camera
            currentOutput.setSampleBufferDelegate(self, queue: captureQueue)
            
            captureQueue.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.changeCaptureDevice(toIndex: camera.rawValue, ofSession: strongSelf.captureSession)
                strongSelf.captureSession.beginConfiguration()
                if strongSelf.captureSession.canSetSessionPreset(AVCaptureSession.Preset.vga640x480) {
                    strongSelf.captureSession.sessionPreset = AVCaptureSession.Preset.vga640x480
                }
                strongSelf.captureSession.commitConfiguration()
                strongSelf.captureSession.startRunning()
            }
        }
        
        // Stops capturing video frames
        func stopCapture() {
            currentOutput?.setSampleBufferDelegate(nil, queue: nil)
            captureQueue.async { [weak self] in
                self?.captureSession.stopRunning()
            }
        }
        
        // Switches the camera
        func switchCamera() {
            stopCapture()
            currentCamera = currentCamera.next()
            startCapture(ofCamera: currentCamera)
        }
    }
    ```

    The `AgoraCameraSourcePushDelegate` class is used to receive the captured video frames.

    ```swift
    // Swift
    protocol AgoraCameraSourcePushDelegate {
        func myVideoCapture(_ capture: AgoraCameraSourcePush, didOutputSampleBuffer pixelBuffer: CVPixelBuffer, rotation: Int, timeStamp: CMTime)
    }
    ```

3. Implement the custom video renderer. The Agora SDK does not support rendering video frames captured in the push mode. Therefore, you need to implement a custom video renderer using methods from outside the SDK. In the sample project, we define a class called `CustomVideoSourcePreview` using the native `AVCaptureVideoPreviewLayer` class.

    ```swift
    // Swift
    // Initializes localVideo
    var localVideo = CustomVideoSourcePreview(frame: CGRect.zero)
    
    // Defines the CustomVideoSourcePreview class
    class CustomVideoSourcePreview : UIView {
    
        private var previewLayer: AVCaptureVideoPreviewLayer?
        func insertCaptureVideoPreviewLayer(previewLayer: AVCaptureVideoPreviewLayer) {
            self.previewLayer?.removeFromSuperlayer()
    
            previewLayer.frame = bounds
            layer.insertSublayer(previewLayer, below: layer.sublayers?.first)
            self.previewLayer = previewLayer
        }
    
        override func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)
            previewLayer?.frame = bounds
        }
    }
    ```

4. Start capturing and rendering video frames. In the sample project, we create a `customCamera` instance using the `AgoraCameraSourcePush` class, and then we call `startCapture` to start the capturing and rendering process.

    ```swift
    // Swift
    // Initializes the AgoraCameraSourcePush class and sets the camera as the capturing device
    customCamera = AgoraCameraSourcePush(delegate: self, videoView:localVideo)
    
    // Calls startCapture of the AgoraCameraSourcePush class to start capturing video frames
    customCamera?.startCapture(ofCamera: .defaultCamera())
    ```

5. Push the captured video frames to the SDK. Call the `pushExternalVideoFrame` method to push the captured video frames to the SDK.

    ```swift
    // Swift
    extension CustomVideoSourcePushMain:AgoraCameraSourcePushDelegate
    {
        func myVideoCapture(_ capture: AgoraCameraSourcePush, didOutputSampleBuffer pixelBuffer: CVPixelBuffer, rotation: Int, timeStamp: CMTime) {
            let videoFrame = AgoraVideoFrame()
            videoFrame.format = 12
            videoFrame.textureBuf = pixelBuffer
            videoFrame.time = timeStamp
            videoFrame.rotation = Int32(rotation)
            
            // Pushes the captured video frames to the SDK
            agoraKit?.pushExternalVideoFrame(videoFrame)
        }
        
    }
    ```

## Reference

### Sample project

Agora provides open-source demo projects on GitHub that implement the custom video source and renderer function. You can download the projects to try them out or view the source code:

  - Customize the video source (Push mode): [CustomVideoSourcePush](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Advanced/CustomVideoSourcePush)

### Considerations

- Customizing the video source and renderer requires you to manage video capturing and rendering on your own.
	- When customizing the video source, you need to capture and process the video frames on your own.
- In scenarios involving the custom video renderer, the rotation parameter of the video frames in `renderPixelBuffer` or `renderRawData` may not be 0. This is probably due to the settings of video capturing, and you need to process the rotation information yourself.