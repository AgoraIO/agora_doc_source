---
title: How can I set the logs?
platform: ["Web"]
updatedAt: 2021-03-22 09:35:58
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Enable or disable log upload

You can call `enableLogUpload` to upload the logs of the Agora Web SDK to the Agora servers, and call `disaleLogUpload` to stop the upload.

To ensure that the output log is complete, we recommend calling `enableLogUpload` to upload logs before creating the Client object.

If you fail to join the channel, the logs are unavailable on the Agora servers.

## Set the log output level

Call `setLogLevel` to set the log output level. Select a level, and you can see the logs in the preceding levels.

- DEBUG: Outputs all logs.
- INFO: Outputs logs in the INFO, WARNING and ERROR levels.
- WARNING: Outputs logs in the WARNING and ERROR levels.
- ERROR: Outputs logs in the ERROR level.
- NONE: Outputs no log.

## Sample code

See the sample code based on your SDK version.

### Web SDK 3.x

```js
// Javascript
// Enable log upload
AgoraRTC.Logger.enableLogUpload();
// Set the log output level as INFO
AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.INFO);
```

### Web SDK 4.x

```js
// Javascript
// Enable log upload
AgoraRTC.enableLogUpload();
// Set the log output level as INFO
AgoraRTC.setLogLevel(1);
```

## API reference

### Web SDK 3.x

- [`enableLogUpload`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/modules/agorartc.logger.html#enablelogupload)
- [`disableLogUpload`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/modules/agorartc.logger.html#disablelogupload)
- [`setLogLevel`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/modules/agorartc.logger.html#setloglevel)

### Web SDK 4.x

- [`enableLogUpload`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartc.html#enablelogupload)
- [`disableLogUpload`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartc.html#disablelogupload)
- [`setLogLevel`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartc.html#setloglevel)