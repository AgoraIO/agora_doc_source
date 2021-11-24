This page introduces some best practices that you need to keep in mind when you implement the recording feature in Flexible Classroom. These best practices can help to ensure the reliability of the recording and improve the quality of the recorded files.

## The basic process of implementing the recording feature

The following figure shows the basic process of implementing the web page recording feature in Flexible Classroom. The steps marked in purple in the figure are the operations you need to perform.

![](https://web-cdn.agora.io/docs-files/1637660754292)

## Start the recording

Regardless of whether you start classroom recording on the client or server, you actually call [Set the recording state](/en/agora-class/agora_class_restful_api?platform=RESTful#set-the-recording-state) of the Flexible Classroom cloud service. When starting the recording, pay attention to the following parameters:

- `mode`: Set this parameter as `web` to enable `web` to enable [web page recording](/en/Agora%20Platform/webpage_recording).
- `rootUrl`: The root address of the web page to be recorded. The Flexible Classroom cloud service automatically gets the full address of the web page to be recorded by putting `roomUuid`, `roomType` and other parameters after the root address. Then, you need to extract these info from the URL and pass them in when calling the [launch](/en/agora-class/agora_class_api_ref_web?platform=Web#launch) method.
- `retryTimeout`: The amount of time (seconds) that the Flexible Classroom cloud service waits between tries. The Flexible Classroom cloud service reties twice at most.

Sample code:

```json
{
    "mode": "web",
    "webRecordConfig": {
        "rootUrl":"https://xxx.yyy.zzz",
    },
    ...
    "retryTimeout": 60
}
```

After setting `retryTimeout`, when calling the [launch](/en/agora-class/agora_class_api_ref_web?platform=Web#launch) method,  you need to set the `listener` parameter to listen for the `1` event. `1` represents that the page has been loaded. When this event is triggered, you need to call the following method to inform the Flexible Classroom cloud service. If the Flexible Classroom cloud service does not receive this notification within `retryTimeout`, it retries the recording.

- Prototype

   - Method: PUT
   - Path: https://api.agora.io/edu/apps/{appId}/v2/rooms/{roomUUid}/records/ready

- A successful method call returns the following response:

   ```json
   status: 200,
   body:{
       "msg": "Success",
       "code": 0,
       "ts": 1610167740309
   }

```

上述逻辑的示例代码如下：

```typescript
AgoraEduSDK.launch(document.querySelector(`#${this.elem.id}`), {
    ...
    listener: (evt) => {
        if ( evt === 1 ) {
        // Send a web request to notify the server side that the recording page was fully loaded.
        }
    }
})
```

If you use a version earlier than v1.1.5, you also need to set `params` to monitor the whiteboard loading state. Sample code:

```typescript
AgoraEduSDK.launch(document.querySelector(`#${this.elem.id}`), {
    ...
    listener: (evt) => {
        if ( evt === 1 && params.type === "whiteboard") {
        // Send a web request to notify the server side that the recording page was fully loaded.
        }
    }
})
```

## Get the recording state

After starting the recording, the Flexible Classroom cloud service generates an event to indicate the [recording state change](/en/agora-class/agora_class_restful_api_event?platform=RESTful#the-recording-state-changes). You can get the recording state by calling the [Query a specified event](/en/agora-class/agora_class_restful_api?platform=Web#query-a-specified-event) or [Get classroom events method](/en/agora-class/agora_class_restful_api?platform=Web#get-classroom-events). Pay attention to the `reason` field in the recording state change event:

- `1`: Start the recording normally.
- `2`: Stop the recording normally.
- `3`: Start the recording after retry.
- `4`: Time out. Wait for retry.
- `5`: Exit the recording when the number of retries reaches the upper limit.

The clients also receive callbacks which indicate the recording state change in [room properties](/en/agora-class/edu_context_api_ref_web_room?platform=Web#roomproperties). You can further implement your own logic  based on the recording state change.

## Remove the white screen at the beginning of the recorded file

It takes a while for the recording server to load the web page, but the file slicing begins before the loading finishes. As a result, there will be a period of white screen at the beginning of the recorded file. To remove the white screen, do the following:

1. Before the class starts, call [Set the recording state](/en/agora-class/agora_class_restful_api?platform=RESTful#set-the-recording-state) and set `onHold` as `true`. The Flexible Classroom cloud service will pause the recording immediately after the recording task is initiated. The recording server opens and renders the web page, but does not generate a slice file. Request body:

   ```json
   {
       "mode": "web",
       "webRecordConfig": {
           "url": "https://xxx.yyy.zzz",
           "onHold": true
       }
   }

```

2. 调用设置录制状态接口至少 60 秒后，再调用[更新录制设置接口](/cn/agora-class/agora_class_restful_api?platform=RESTful#更新录制设置)，将 `onHold` 参数设置为 `false` 来正式开始录制，进行录制切片。示例包体如下：

   ```json
   {
       "webRecordConfig": {
           "onHold": false
       }
   }
```

## Improve the video clarity when the recorded content is a shared screen

In class, teachers might share slides or notes with students by screen sharing. If you have high requirements for the clarity of recordings such as screen sharing, whiteboard, you can set the following parameters when calling [Set the recording state](/en/agora-class/agora_class_restful_api?platform=RESTful#set-the-recording-state):

- Set `videoWidth` as 1920.
- Set `videoHeight` as 1080.
- Set `videoBitrate` as 2000.

Request body:

```json
{
    "mode": "web",
    "webRecordConfig": {
        "url": "https://xxx.yyy.zzz",
        "videoWidth": 1920,
        "videoHeight": 1080,
        "videoBitrate": 2000
    }
}
```
