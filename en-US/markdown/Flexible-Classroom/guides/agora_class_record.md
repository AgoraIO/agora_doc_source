Agora recommends referring to this page to record classes in Flexible Classroom to ensure the reliability of the recording and improve the quality of the recorded files.

## Implement whiteboard features

The figure below introduces the Flexible Classroom of web recording in Smart Classroom. The steps marked in purple in the figure are the operations you need to perform.

![](https://web-cdn.agora.io/docs-files/1624525158077)

## Start class recording

Regardless of whether you start classroom recording on the client or server, the essence is to call the Flexible Classroom cloud service to set the [recording status interface ](/cn/agora-class/agora_class_restful_api?platform=RESTful# to set the recording status). When starting recording, you need to pay attention to the following parameters:

- Set this parameter as `web `to enable `web `[page ](recording )`mode`/en/Agora%20Platform/webpage_recording.
- `rootUrl`: The` root` address of the page to be recorded. Flexible Classroom Cloud Service will automatically splice `roomUuid`, `roomType` and other parameters after the URL, and the page to be recorded needs to extract this information when calling the [launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) method.
- `retryTimeout: Retry timeout` time, in seconds. Retry at most twice.

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

After setting `retryTimeout`, you need to call the [launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) method on the recording page to set the `listener` parameter to` listen` to events with enumeration value `1`, and `1` means the page is loaded. After listening to the event, you need to call the following interface to inform Smart Flexible Classroom Cloud Service that the recording page has been loaded. If the smart Flexible Classroom cloud service does not receive this request within `retryTimeout`, it will` retry` the recording.

- Prototype

   - Method: PUT
   - Path: https://api.agora.io/edu/apps/{appId}/v2/rooms/{roomUUid}/records/ready

- After success, you will receive the following response:

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

If you use a version Flexible Classroom 1.1.5, you need to monitor `params` to monitor the loading status of whiteboard. The sample code is as follows:

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

## Get recording status

After starting the recording, the Smart Flexible Classroom cloud service will generate the [recording status change ](event /cn/agora-class/agora_class_restful_api_event?platform=RESTful#Recording status change event). You can get [the recording status by querying the specified event](/cn/agora-class/agora_class_restful_api?platform=Web#Querying the specified event )or [getting the class event](/cn/agora-class/agora_class_restful_api?platform=Web#Getting the class event). You need to pay attention to the `reason` field in the recording state change event:

- `1`: Start recording normally.
- `2`: Stop recording normally.
- `3`: Start recording normally after retrying.
- `4`: Timed out to be retried.
- `5`: After the number of retries reaches the upper limit, it is still unsuccessful, and the recording is exited.

At the same time, the [recording status ](in the client's room properties /cn/agora-class/edu_context_api_ref_web_room?platform=Web#roomproperties )will also change. You can do follow-up business development based on the two methods of server and client.

## Remove the white screen at the beginning of the recording file

Since it takes a while for the web recording server to load the web to be recorded, the slicing will start before that, so there will be a period of white screen at the beginning of the generated recording file. If you want to remove the white screen, you need to do the following:

1. Before the class starts, call the smart Flexible Classroom cloud service [to set the recording status interface ](/cn/agora-class/agora_class_restful_api?platform=RESTful#Set the recording status) and set the `onHold` parameter to `true`. Flexible Classroom Cloud Service will pause the recording immediately after starting the page recording task. The web recording server opens and renders the page to be recorded, but does not generate a slice file, but loads the page to be recorded and stands by. The sample package body is as follows:

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

## Improve screen sharing clarity

In fact, in the class, the teacher may share courseware and other content through screen sharing. If you have high requirements for the clarity of recordings such as screen sharing, whiteboards, etc., you can set [the following parameters ](when calling [the setting recording status interface ](/cn/agora-class/agora_class_restful_api?platform=RESTful# to set the recording status):

- Set `videoWidth` to 1920.
- Set `videoHeight` to 1080.
- Set `videoBitrate` to 2000.

The sample package body is as follows:

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
