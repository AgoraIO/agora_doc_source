---
title: 音视频设备测试
platform: Web
updatedAt: 2020-12-30 09:01:59
---
## 功能描述

为保证通话或直播质量，我们推荐在进入频道前进行音视频设备测试，检测麦克风、摄像头等音视频设备能否正常工作。该功能对于有高质量要求的场景，如在线教育等，尤为适用。

## 实现方法

开始前请确保你已经了解如何[实现音视频通话](start_call_web)或[互动直播](start_live_web)。

### 麦克风／摄像头测试

参考以下步骤测试麦克风/摄像头：
1. 调用 `AgoraRTC.getDevices` 获取可用设备及设备 ID。
2. 调用 `AgoraRTC.createStream` 创建本地音频流或视频流。在创建流时填入 `microphoneId` 或 `cameraId` 指定想测试的设备。
3. 调用 `Stream.init` 初始化流，在该方法的 `onSuccess` 回调中播放本地流。
   - 如果是测试麦克风，调用 `Stream.getAudioLevel` 获取音量，音量大于 0 说明麦克风正常。
   - 如果是测试摄像头，播放流后可以看到画面说明摄像头正常。

```javascript
// Find all audio and video devices
AgoraRTC.getDevices(function(devices){
    var audioDevices = devices.filter(function(device){
        return device.kind === "audioinput";
    });
    var videoDevices = devices.filter(function(device){
        return device.kind === "videoinput";
    });

    var uid = Math.floor(Math.random()*10000);
    var selectedMicrophoneId = ...;
    var selectedCameraId = ...;
    var stream = AgoraRTC.createStream({
        streamID: uid,
        // Set audio to true if testing microphone
        audio: true,
        microphoneId: selectedMicrophoneId,
        // Set video to true if testing camera
        video: true,
        cameraId: selectedCameraId,
        screen: false
    });

    // Initialize the stream
    stream.init(function(){
        stream.play("mic-test");
        // Print the audio level every 1000 ms
        setInterval(function(){
            console.log(`Local Stream Audio Level ${stream.getAudioLevel()}`);
        }, 1000);
    })
});
```

### 音频播放设备测试

由于浏览器的安全限制，Agora Web SDK 不支持直接播放本地音频文件。你可以通过以下方法测试音频播放设备：

使用 HTML5 的 `<audio>` 元素在页面上创建一个音频播放器，让用户播放在线音频文件并确认是否有声音。

### API 参考

- [`AgoraRTC.getDevices`](./API%20Reference/web/globals.html#getdevices)
- [`AgoraRTC.createStream`](./API%20Reference/web/globals.html#createstream)
- [`Stream.init`](./API%20Reference/web/interfaces/agorartc.stream.html#init)
- [`Stream.play`](./API%20Reference/web/interfaces/agorartc.stream.html#play)
- [`Stream.getAudioLevel`](./API%20Reference/web/interfaces/agorartc.stream.html#getaudiolevel)


## 开发注意事项

- 在调用 `Stream.init` 时可能会报错，常见错误请参考 [API 文档](./API%20Reference/web/interfaces/agorartc.stream.html#init)。
- 设备 ID 是随机生成的，部分情况下同一个设备的 ID 可能会改变，因此我们建议每次测试设备时都先调用 `getDevices` 获取设备 ID。