## Web 端如何关闭 3A（降噪、回声消除、增益）的配置?

如果你的课堂集成或使用了混音或其他工具，想要关闭降噪、回声消除、增益功能，可在 `packages/agora-classroom-sdk/src/infra/api/index.tsx` 中添加以下代码实现：

 ```tsx
 if (AgoraRteRuntimePlatform.Electron === AgoraRteEngineConfig.platform) {
      rtcSDKParameters = [
        { 'rtc.audio.aec.enable': false },
        { 'rtc.audio.agc.enable': false },
        { 'rtc.audio.ans.enable': false },
      ];
    } else {
      rtcSDKParameters = [
        {
          MEDIA_DEVICE_CONSTRAINTS: {
            audio: {
              autoGainControl: false,
              echoCancellation: false,
              noiseSuppression: false,
            },
          },
        },
      ];
    }
```

![](https://web-cdn.agora.io/docs-files/1680084350900)

