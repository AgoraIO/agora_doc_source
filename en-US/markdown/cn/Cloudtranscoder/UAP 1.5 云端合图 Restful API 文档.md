## Introduction

Agora provides cloud transcoding services for one or multi-hosted interactive streaming scenarios, and supports transcoding and stream mixing on the Agora server to push the streams of multiple hosts to the Agora RTC channel. Audience in the RTC channel only need to subscribe to the transcoded and mixed streams to watch the live broadcast.

After using the cloud transcoding service, audiences do not need to subscribe to the streams of multiple hosts, which can greatly save pressure of downstream bandwidth and consumption of client device performance.

### Working principles

The process of transcoding and mixing multiple streams on the Agora server is equivalent to creating a cloud transcoder. The multiple streams before transcoding is the input of the cloud transcoder, and the stream after transcoding is the output of the cloud transcoder.

You can control the cloud transcoder through the cloud transcoding RESTful API:

- `Create`: Create a cloud transcoder. The Agora server will start transcoding and mixing the multiple streams you specified into one and push them to the Agora RTC channel.
- `Delete`: Destroy the cloud transcoder. The Agora server will stop transcoding and mixing streams.
- `Query`: Query the information of the cloud transcoder. The Agora server will query the cloud transcoder you specified.
- `Update`: Update the cloud transcoder。 The Agora server will update the cloud transcoder  according to the configuration you set.

After using the cloud transcoding RESTful API, Agora notification server will send the callback notification to your server through the HTTP request.

## Generate a builderToken

 which can guarantee the security of your request to control a cloud transcoder. Please call this method to generate a builderToken before creating a cloud transcoder.

### HTTP request

```http
POST https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/builderTokens
```
`appId`: (Required) String The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.

#### Request header

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Request body

The request body requires the following query string parameters:

| Field | Type | Description |
|---|----|---|
| `instanceId` | (Required)String  | The instance ID setted by the developer. The length must be within 64 characters. The supported character set range is:<li>All lowercase English letters (a-z)</li><li>All uppercase English letters (A-Z)</li><li>Numbers 0-9</li><li>"-", "_"</li><div class="alert note"><li>One `instanceId` can generate multiple builderTokens, but only one builderToken can be used to send a request in a task.</li></div> |

Request body example:

```json
{"instanceId": "myInstance11620701216"}
```

### HTTP response

#### Request header

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Response body

The Body contains the following fields:

| Field | Type | Description |
|---|----|---|
| `tokenName` | String | The value of builderToken, which needs to be passed in when calling other methods later. |
| `createTs` | Number | The Unix timestamp (seconds) when the builderToken was generated. |
| `instanceId` | Number | The `instanceId` set at the time of the request. |

<div class="alert note">After calling this method successfully, you can get a builderToken from the <code>tokenName</code> field in the HTTP response body. Please use this builderToken to send a request within 5 minutes. After the time has expired, you need to regenerate the builderToken, otherwise other methods cannot be called.

Response body example:

```json
{
"createTs": 1620701216577,
"instanceId": "myInstance11620701216",
"tokenName": "IqCWKgW2CD0KqnZm0lcCzZvPp_zOKb1og0k8tVYqrYB8c"
}
```

## Create: Create a cloud transcoder

### HTTP request

```http
POST https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks?builderToken=<tokenName>
```
### Path parameter

`appId`: (Required) String. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.

### Query Parameters

`builderToken`: (Required) String Get the parameter value **tokenName** of `builderToken` by `generating builderToken method`.


#### Request header

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Request body

The request Body is a `services` field of JSON Object type. The field structure is shown in the figure:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- `The services` field contains the following fields:

   | Field | Type | Description |
   |---|----|---|
   | `<service>` |  (Required)JSON Object | The service name, set by the developer. It is necessary to ensure that the service name used in a cloud transcoder is unique. |
   | `<service>.serviceType` | (Required)String  | Service type. Cloud transcoding:`cloudTranscoder`. |
   | `<service>.config` |  (Required)JSON Object | Parameter settings of cloud transcoder,   which used to set the business parameters of the cloud transcoder. |
   | `<service>.config.transcoder` | (Required)String  | Cloud transcoder object. |

- `<service>.config.transcoder` contains the following fields:

   | Field | Type | Description |
   |---|----|---|
   | `idleTimeOut` | (Optional)Number  | The maximum time (second) that the Converter is idle. Idle means that all users corresponding to the streams processed by the cloud transcoder have left the channel. After the idle state exceeds the set `idleTimeOut`, the cloud transcoder will be destroyed automatically. The value range is [1,86400], and the default value is `300`. |
   | `inputRtcTokens` | (Optional)JSON Array  | Information required to join the RTC channel. The cloud transcoder needs this information to push the transcoded stream into the RTC channel.<li>If you have not enabled the  App Certificate in the  Agora Console, you do not need to pass the value.</li><li>If you have not enabled the  App Certificate in the  Agora Console, you must pass the value.</li> |
   | `inputRtcTokens.rtcChannel` | (Required)String  | RTC channel name. |
   | `inputRtcTokens.rtcToken` | (Required)String  | The token required to enter the RTC channel is used to ensure channel security. |
   | `inputRtcTokens.rtcUid` | (Required)Number  | UID。 The same UID is not allowed in the RTC channel, so please make sure that the value is different from`inputs.videoInputs.inputSources.in.rtcUid`. |
   | `inputs` |  (Required)JSON Object | The input configuration of cloud transcoder. |
   | `inputs.audioInputs` | (Optional)JSON Object | Audio input configuration of cloud transcoder.<li>If you do not pass a value, Agora will use the `input source corresponding to inputs.videoInputs.inputSources.in.rtcUid` as the audio input source of the cloud transcoder. This value method is suitable for scenes where both the host's audio and video are transcoded.</li><li>If you pass the value, Agora will transcode and mix the audio input source you specify. This value method is suitable for scenes where` inputs.audioInputs.inputSources.in.rtcUid` and `inputs.videoInputs.inputSources.in.rtcUid` are not exactly the same, that is, part of the host’s video is transcoded but the audio is not transcoded.</li> |
   | `inputs.audioInputs.inputSources` | (Required)JSON Array  | The audio input source of the cloud transcoder. Supports multiple input sources. |
   | `inputs.audioInputs.inputSources.in` |  (Required)JSON Object | The audio input source of the cloud transcoder. |
   | `inputs.audioInputs.inputSources.in.rtcChannel` | (Required)String  | The name of the RTC channel to which the input source belongs. |
   | `inputs.audioInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. The same UID is not allowed in the RTC channel. |
   | `inputs.videoInputs` |  (Required)JSON Object | Video input configuration of cloud transcoder. |
   | `inputs.videoInputs.canvas` |  (Required)JSON Object | The canvas that hosts the cloud transcoder  video mixing. |
   | `inputs.videoInputs.canvas.height` | (Required)Number  | The height of the canvas (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.canvas.width` | (Required)Number  | The width of the canvas (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.inputSources` | (Required)JSON Array  | The video input source of cloud transcoder. Supports multiple input sources. |
   | `inputs.videoInputs.inputSources.in` |  (Required)JSON Object | The video input source of cloud transcoder. |
   | `inputs.videoInputs.inputSources.in.rtcChannel` | (Required)String  | The name of the RTC channel to which the input source belongs. |
   | `inputs.videoInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. The value is the same as `inputs.audioInputs.inputSources.in.rtcUid`. |
   | `inputs.videoInputs.inputSources.in.OfflineImage` | (Optional)JSON Object | The background image of the host after offline. If you don't pass the value, the screen after the host is offline will have no background image. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageType` | (Required)String  | Image type. Support JPG and PNG format pictures. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageUrl` | (Required)String  | Image URL. Must be legal URL, and include `jpg` or `png` suffix. |
   | `inputs.videoInputs.inputSources.region` |  (Required)JSON Object | The position on the canvas of the video input source image of the cloud transcoder. |
   | `inputs.videoInputs.inputSources.region.x` | (Required)Number  | The x coordinate (pixel) of the screen on the canvas. The lateral displacement relative to the origin. (Take the upper left corner of the canvas as the origin, and the x coordinate as the upper left corner of the screen.) The value range is [0,3840]. |
   | `inputs.videoInputs.inputSources.region.y` | (Required)Number  | The y coordinate (pixel) of the screen on the canvas. The longitudinal displacement to the origin.（Take the upper left corner of the canvas as the origin and the y coordinate as the upper left corner of the screen.） The value range is [0,3840]. |
   | `inputs.videoInputs.inputSources.region.width` | (Required)Number  | The width of the image (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.inputSources.region.height` | (Required)Number  | The height of the canvas (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.inputSources.zOrder` | (Required)Number  | The layer number of the video input screen of the cloud transcoder. The value range is [0,100]. 0 represents the lowest layer. 100 represents the top layer. |
   | `outputs` | (Required)JSON Array  | The output configuration of the cloud transcoder. Supports output of multiple streams processed by different transcoding configurations. |
   | `outputs.out` |  (Required)JSON Object | The output configuration of the cloud transcoder. |
   | `outputs.out.rtcChannel` | (Required)String  | RTC channel name. The value isthe same as `inputRtcTokens.rtcChannel`. |
   | `outputs.out.rtcToken` | (Required)String  | The token required to enter the RTC channel is used to ensure channel security. The value is the same as `inputRtcTokens.rtcToken`. |
   | `outputs.out.rtcUid` | (Required)Number  | UID。 The value is the same as `inputRtcTokens.rtcUid`. |
   | `outputs.audioOption` | (Optional)JSON Object | Cloud transcoder transcoding and mixing configuration for audio streams. If you don't pass the value, the audio attribute of Agora transcoding output is `AUDIO_PROFILE_MUSIC_STANDARD`, which means 48 KHz sampling rate, music encoding, mono, and the maximum encoding rate is 64 Kbps. |
   | `outputs.audioOption.profileType` |  (Optional)String | Audio profile. Support values:<li>`"AUDIO_PROFILE_MUSIC_STANDARD"`: (Default) A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps. </li><li>`"AUDIO_PROFILE_MUSIC_STANDARD_STEREO"`: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 56 Kbps.</li><li>`"AUDIO_PROFILE_MUSIC_HIGH_QUALITY"`: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.</li><li>`"AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO"`: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.</li> |
   | `outputs.videoOption` |  (Required)JSON Object | Cloud transcoder is the configuration of transcoding and 	video mixing. |
   | `outputs.videoOption.fps` | (Optional)Number  | The frame rate (fps) of the transcoded output video. The value range is [1,30]. The default value is 15. |
   | `outputs.videoOption.codec` | (Required)String  | The codec of the transcoded output video. The supported value is `"H265"`. |
   | `outputs.videoOption.bitrate` | (Optional)Number  | The bitrate of the transcoded output video. The value range is [1,10000]. If you do not pass the value, Agora will automatically set the video bitrate according to the network situation and other video attributes. |
   | `outputs.videoOption.width` | (Required)Number  | The width(px) of the transcoded output video. The value range is ]120,3840[. |
   | `outputs.videoOption.height` | (Required)Number  | The height (px) of the transcoded output video. The value range is ]120,3840[. |


Request body example:

```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            config
                "transcoder": {
                    "name": "teacher101",
                    "idleTimeout": 300,
                    "inputs": {
                        "videoInputs": {
                            "canvas": {
                                "height": 720,
                                "width": 1280
                        },
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000001
                        },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 680,
                                        "height": 400
                        },
                                    "zOrder": 1
                        },
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000002
                        },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 640,
                                        "height": 360
                        },
                                    "zOrder": 2
                                    }
                            ]
                                    }
                        },
                    "outputs": [
{
                            "out": {
                                "rtcChannel": "transcoder_output_channel1620701216989",
                                "rtcUid": 1000003,
                                rtcToken: aab8b8f5a8cd4469a63042fcfafe7063
                        },
                            "videoOption": {
                                "fps": 30,
                                "codec": "H264",
                                "bitrate": 3000,
                                "height": 1280,
                                "width": 720
                                    }
                                    }
                            ]
                                    }
                                    }
                                    }
                                    }
}
```


### HTTP response

#### Request header

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Response body

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

The meanings of the fields are shown in the following table:

| Field | Type | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | Number | The Unix timestamp (s) when the cloud transcoder is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: The task initialization is completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>`"STOPPED"`: The task has been stopped</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | Information about all services included in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud transcoding:`cloudTranscoder`. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.config.transcoder` | (Required)String  | Cloud transcoder object. For the included fields and meanings, please refer to the request Body fields and meanings. |
| `services.<service>.status` | String | The running status of services:<li>`"IDLE"`: The service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: The service has started</li><li>`"IN_PROGRESS"`: The service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the task is completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: The service parameter verification failed</li><li>`"ABNORMAL"`: The service exited abnormally</li><li>`"UNKNOWN"`: The service exited abnormally</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |

Response body example:

```json
{
    "createTs": 1575508644,
    "services": {
        "cloudTranscoder": {
            config
                "transcoder": {
                    "idleTimeout": 300,
                    "inputs": {
                        "videoInputs": {
                            "canvas": {
                                "height": 720,
                                "width": 1280
                        },
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000001
                        },
                                    "region": {
                                        "height": 400,
                                        "width": 680,
                                        "x": 0,
                                        "y": 0
                        },
                                    "zOrder": 1
                        },
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000002
                        },
                                    "region": {
                                        "height": 360,
                                        "width": 640,
                                        "x": 0,
                                        "y": 0
                        },
                                    "zOrder": 2
                                    }
                            ]
                                    }
                        },
                    "name": "teacher101",
                    "outputs": [
                                {
                            "out": {
                                "rtcChannel": "transcoder_output_channel1620701216989",
                                rtcToken: aab8b8f5a8cd4469a63042fcfafe7063,
                                "rtcUid": 1000003
                        },
                            "videoOption": {
                                "bitrate": 3000,
                                "codec": "H264",
                                "fps": 30,
                                "height": 1280,
                                "width": 720
                                    }
                                    }
                            ]
                                    }
                        },
            "createTs": 1575508644,
            "details": {
                
            },
              "msg": "Success",
            "serviceType": "cloudTranscoder",
            "status": "serviceReady"
                                    }
                        },
    "status": "STARTED",
    "taskId": "bc2d7b3ab6411e3fd4be96b92d312c56"
}
```

## Delete: Destroy the cloud transcoder

### HTTP request

```http
DELETE https://api.agora.io/v1/projects/<appId>/rtmp-converters/<converterId>
```

### Path parameter

- `appId`: (Required) String. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: The task ID of the cloud transcoder, UUID, which used to identify the cloud transcoder created in this request.

### Query Parameters

`builderToken`: (Required) String Get the parameter value **tokenName** of `builderToken` by `generating builderToken method`.


#### Request header

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Request body

None

### HTTP response

#### Request header

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Response body

The Body contains the following fields:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

The meanings of the fields are shown in the following table:

| Field | Type | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | Number | The Unix timestamp (s) when the cloud transcoder is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: The task initialization is completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>`"STOPPED"`: The task has been stopped</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | All service information contained in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud transcoding:`cloudTranscoder`. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.config.transcoder` | (Required)String  | Cloud transcoder object. For the included fields and meanings, please refer to the request Body fields and meanings. |
| `services.<service>.status` | String | The running status of services:<li>`"IDLE"`: The service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: The service has started</li><li>`"IN_PROGRESS"`: The service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the task is completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: The service parameter verification failed</li><li>`"ABNORMAL"`: The service exited abnormally</li><li>`"UNKNOWN"`: The service exited abnormally</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |

Response body example:

```json
{
    "createTs": 1575508644,
    "services": {
        "cloudTranscoder": {
            config
                "transcoder": {
                    "idleTimeout": 300,
                    "inputRtcTokens": [
                                
                            ],
                    "inputs": {
                        "audioInputs": {
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000001
                                    }
                        },
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000002
                                    }
                                    }
                            ]
                        },
                        "videoInputs": {
                            "canvas": {
                                "fps": 32668,
                                "height": 720,
                                "width": 1280
                        },
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000001
                        },
                                    "region": {
                                        "height": 360,
                                        "width": 640,
                                        "x": 0,
                                        "y": 0
                        },
                                    "zOrder": 2
                        },
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000002
                        },
                                    "region": {
                                        "height": 400,
                                        "width": 680,
                                        "x": 0,
                                        "y": 0
                        },
                                    "zOrder": 1
                                    }
                            ]
                                    }
                        },
                    "outputs": [
{
                            "audioOption":
                                "profileType": "AUDIO_PROFILE_MUSIC_STANDARD"
                        },
                            "out": {
                                "rtcChannel": "transcoder_output_channel1620701216989",
                                rtcToken: aab8b8f5a8cd4469a63042fcfafe7063,
                                "rtcUid": 1000003
                        },
                            "videoOption": {
                                "bitrate": 3000,
                                "codec": "H264",
                                "fps": 30,
                                "height": 1280,
                                "width": 720
                                    }
                                    }
                            ]
                                    }
                        },
    "createTs": 1575508644,
            "details": {
                        "msg": "user call delete"
                        },
                    "message": "quit",
            "serviceType": "cloudTranscoder",
                    "status": "serviceCompleted"
                                    }
                        },
            "status": "STOPPED",
    "taskId": "bc2d7b3ab6411e3fd4be96b92d312c56"
}
```


## Query task Query: query cloud transcoder status information
### HTTP request

```http
PATCH https://api.agora.io/v1/projects/<appId>/rtmp-converters/<converterId>?sequence={sequence}
```
### Path parameter

- `appId`: (Required) String. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: The task ID of the cloud transcoder, UUID, which used to identify the cloud transcoder created in this request.

### Query Parameters

`builderToken`: (Required) String Get the parameter value **tokenName** of `builderToken` by `generating builderToken method`.

#### Request header

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Request body

None

### HTTP response

#### Request header

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Response body

The Body contains the following fields:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

The meanings of the fields are shown in the following table:

| Field | Type | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | Number | The Unix timestamp (s) when the cloud transcoder is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: The task initialization is completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>`"STOPPED"`: The task has been stopped</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | All service information contained in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud transcoding:`cloudTranscoder`. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.status` | String | The running status of services:<li>`"IDLE"`: The service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: The service has started</li><li>`"IN_PROGRESS"`: The service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the task is completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: The service parameter verification failed</li><li>`"ABNORMAL"`: The service exited abnormally</li><li>`"UNKNOWN"`: The service exited abnormally</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |

Response body example:
```JSON
{
    "createTs": 1575508644,
    "services": {
        "cloudTranscoder": {
            config
                "transcoder": {
                    "idleTimeout": 300,
                    "inputs": {
                        "audioInputs": {
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_delete_and_query1620703973593",
                                        "rtcUid": 1000001
                                    }
                                    }
                            ]
                        },
                        "videoInputs": {
                            "canvas": {
                                        "height": 360,
                                "width": 640
                        },
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_delete_and_query1620703973593",
                                        "rtcUid": 1000001
                        },
                                    "region": {
                                        "height": 360,
                                        "width": 640,
                                        "x": 0,
                                        "y": 0
                        },
                                    "zOrder": 1
                                    }
                            ]
                                    }
                        },
                    "name": "teacher101",
                    "outputs": [
{
                            "out": {
                                "rtcChannel": "test_delete_and_query1620703973593",
                                rtcToken: aab8b8f5a8cd4469a63042fcfafe7063,
                                "rtcUid": 1000003
                        },
                            "videoOption": {
                                "codec": "H264",
                                "fps": 30,
                                        "height": 360,
                                "width": 640
                                    }
                                    }
                            ]
                                    }
                        },
            "createTs": 1575508644,
            "details": {},
            message
            "serviceType": "cloudTranscoder",
            "status": "connecting"
                                    }
                        },
    "status": "connecting"
    "taskId": "3859fd4c53413165a7f6bdba48b67839"
}
```

## Update: update cloud transcoder

### HTTP request

```http
PATCH https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>&sequenceId=<sequenceId>&updateMask=<updateMask>
```

### Path parameter

- `appId`: (Required) String. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: The task ID of the cloud transcoder, UUID, which used to identify the cloud transcoder created in this request.

### Query Parameters

- `builderToken`: (Required) String Get the parameter value **tokenName** of `builderToken` by `generating builderToken method`.
- `sequenceId`: (Required)Number The request sequence number is set by the developer. It starts counting from `0` and needs to be incremented to prevent the request from being out of order.
- `updateMask`: (Required) String For the field mask of JSON encoding, please refer to the[ Google protobuf FieldMask document for details](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#fieldmask).

#### Request header

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Request body

The request Body is a `services` field of JSON Object type. The field structure is shown in the figure:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- `The services` field contains the following fields:

   | Field | Type | Description |
   |---|----|---|
   | `<service>`:  (Required)JSON Object | Service name, set when creating a cloud transcoder. |
   | `<service>.serviceType` | (Required)String  | Service type. Cloud transcoding:`cloudTranscoder`. |
   | `<service>.config` |  (Required)JSON Object | Parameter settings of cloud transcoder,   which used to set the business parameters of the cloud transcoder. |
   | `<service>.config.transcoder` | (Required)String  | Cloud transcoder object. |

- `services.config.transcoder` contains the following fields:

   | Field | Type | Description |
   |---|----|---|
   | `inputRtcTokens` | (Optional)JSON Array  | Information required to join the RTC channel. The cloud transcoder needs this information to push the transcoded stream into the RTC channel.<li>If you have not enabled the  App Certificate in the  Agora Console, you do not need to pass the value.</li><li>If you have not enabled the  App Certificate in the  Agora Console, you must pass the value.</li> |
   | `inputRtcTokens.rtcChannel` | (Required)String  | RTC channel name. |
   | `inputRtcTokens.rtcToken` | (Required)String  | The token required to enter the RTC channel is used to ensure channel security. |
   | `inputRtcTokens.rtcUid` | (Required)Number  | UID。 The same UID is not allowed in the RTC channel, so please make sure that the value is different from`inputs.videoInputs.inputSources.in.rtcUid`. |
   | `inputs` |  (Required)JSON Object | The input configuration of cloud transcoder. |
   | `inputs.audioInputs` | (Optional)JSON Object | Audio input configuration of cloud transcoder.<li>If you do not pass a value, Agora will use the `input source corresponding to inputs.videoInputs.inputSources.in.rtcUid` as the audio input source of the cloud transcoder. This value method is suitable for scenes where both the host's audio and video are transcoded.</li><li>If you pass the value, Agora will transcode and mix the audio input source you specify. This value method is suitable for scenes where` inputs.audioInputs.inputSources.in.rtcUid` and `inputs.videoInputs.inputSources.in.rtcUid` are not exactly the same, that is, part of the host’s video is transcoded but the audio is not transcoded.</li> |
   | `inputs.audioInputs.inputSources` | (Required)JSON Array  | The audio input source of the cloud transcoder. Supports multiple input sources. |
   | `inputs.audioInputs.inputSources.in` |  (Required)JSON Object | The audio input source of the cloud transcoder. |
   | `inputs.audioInputs.inputSources.in.rtcChannel` | (Required)String  | The name of the RTC channel to which the input source belongs. |
   | `inputs.audioInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. The same UID is not allowed in the RTC channel. |
   | `inputs.videoInputs` |  (Required)JSON Object | Video input configuration of cloud transcoder. |
   | `inputs.videoInputs.canvas` |  (Required)JSON Object | The canvas that hosts the cloud transcoder  video mixing. |
   | `inputs.videoInputs.canvas.height` | (Required)Number  | The height of the canvas (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.canvas.width` | (Required)Number  | The width of the canvas (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.inputSources` | (Required)JSON Array  | The video input source of cloud transcoder. Supports multiple input sources. |
   | `inputs.videoInputs.inputSources.in` |  (Required)JSON Object | The video input source of cloud transcoder. |
   | `inputs.videoInputs.inputSources.in.rtcChannel` | (Required)String  | The name of the RTC channel to which the input source belongs. |
   | `inputs.videoInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. The value is the same as `inputs.audioInputs.inputSources.in.rtcUid`. |
   | `inputs.videoInputs.inputSources.in.OfflineImage` | (Optional)JSON Object | The background image of the host after offline. If you don't pass the value, the screen after the host is offline will have no background image. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageType` | (Required)String  | Image type. Support JPG and PNG format pictures. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageUrl` | (Required)String  | Image URL. Must be legal URL, and include `jpg` or `png` suffix. |
   | `inputs.videoInputs.inputSources.region` |  (Required)JSON Object | The position on the canvas of the video input source image of the cloud transcoder. |
   | `inputs.videoInputs.inputSources.region.x` | (Required)Number  | The x coordinate (pixel) of the screen on the canvas. The lateral displacement relative to the origin. (Take the upper left corner of the canvas as the origin, and the x coordinate as the upper left corner of the screen.) The value range is [0,3840]. |
   | `inputs.videoInputs.inputSources.region.y` | (Required)Number  | The y coordinate (pixel) of the screen on the canvas. The longitudinal displacement to the origin.（Take the upper left corner of the canvas as the origin and the y coordinate as the upper left corner of the screen.） The value range is [0,3840]. |
   | `inputs.videoInputs.inputSources.region.width` | (Required)Number  | The width of the image (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.inputSources.region.height` | (Required)Number  | The height of the canvas (pixel). The value range is ]120,3840[. |
   | `inputs.videoInputs.inputSources.zOrder` | (Required)Number  | The layer number of the video input screen of the cloud transcoder. The value range is [0,100]. 0 represents the lowest layer. 100 represents the top layer. |

Request body example:
```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            config
                "transcoder": {
                    "idleTimeout": 300,
                    "inputs": {
                        "videoInputs": {
                            "canvas": {
                                "height": 720,
                                "width": 1280
                        },
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000001
                        },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 640,
                                        "height": 360
                        },
                                    "zOrder": 2
                        },
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000002
                        },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 680,
                                        "height": 400
                        },
                                    "zOrder": 1
                                    }
                            ]
                                    }
                                    }
                                    }
                                    }
                                    }
                                    }
}
```


Agora supports you to call the `Update` method to update the following fields:

- `inputs`
- `inputs.audioInputs`
- `inputs.videoInputs`
- `inputRtcTokens`

### HTTP response

#### Request header

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Response body

The Body contains the following fields:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

The meanings of the fields are shown in the following table:

| Field | Type | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | Number | The Unix timestamp (s) when the cloud transcoder is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: The task initialization is completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>`"STOPPED"`: The task has been stopped</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | Information about all services included in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud transcoding:`cloudTranscoder`. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.config.transcoder` | (Required)String  | Cloud transcoder object. For the included fields and meanings, please refer to the request Body fields and meanings. |
| `services.<service>.status` | String | The running status of services:<li>`"IDLE"`: The service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: The service has started</li><li>`"IN_PROGRESS"`: The service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the task is completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: The service parameter verification failed</li><li>`"ABNORMAL"`: The service exited abnormally</li><li>`"UNKNOWN"`: The service exited abnormally</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |

Response body example:
```json
{
    "createTs": 1575508644,
    "services": {
        "cloudTranscoder": {
            config
                "transcoder": {
                    "idleTimeout": 300,
                    "inputRtcTokens": [
                        
                    ],
                    "inputs": {
                        "audioInputs": {
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000001
                                    }
                        },
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000002
                                    }
                                    }
                            ]
                        },
                        "videoInputs": {
                            "canvas": {
                                "fps": 32668,
                                "height": 720,
                                "width": 1280
                        },
                            "inputSources": [
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000001
                        },
                                    "region": {
                                        "height": 360,
                                        "width": 640,
                                        "x": 0,
                                        "y": 0
                        },
                                    "zOrder": 2
                        },
{
                                    "in": {
                                        "rtcChannel": "test_update_inputSource_zOrder_input_1620701216989",
                                        "rtcUid": 1000002
                        },
                                    "region": {
                                        "height": 400,
                                        "width": 680,
                                        "x": 0,
                                        "y": 0
                        },
                                    "zOrder": 1
                                    }
                            ]
                                    }
                        },
                    "outputs": [
{
                            "audioOption":
                                "profileType": "AUDIO_PROFILE_MUSIC_STANDARD"
                        },
                            "out": {
                                "rtcChannel": "transcoder_output_channel1620701216989",
                                rtcToken: aab8b8f5a8cd4469a63042fcfafe7063,
                                "rtcUid": 1000003
                        },
                            "videoOption": {
                                "bitrate": 3000,
                                "codec": "H264",
                                "fps": 30,
                                "height": 1280,
                                "width": 720
                                    }
                                    }
                            ]
                                    }
                        },
    "createTs": 1575508644,
            "details": {
                
            },
            message
            "serviceType": "cloudTranscoder",
            "status": "connecting"
                                    }
                        },
    "status": "connecting"
    "taskId": "bc2d7b3ab6411e3fd4be96b92d312c56"
}
```

## Status codes

- If the status code is `2XX`, the request is successful.
- If the status code is not `2XX`, the request fails. Please troubleshoot the problem based on the content of the `message field in the corresponding response message Body`.

| Status code | Description |
| ----------------------- | -------------- |
| 200 OK | The request succeeds. |
| 201 Created | The task is already in progress, please do not use the same builderToken to open the task repeatedly. |
| 202 Accepted | The server has received the task request, but the execution has not been completed. Please use the <code>GET</code> method to check the execution status. |
| 400 Bad Request | The request parameter is incorrect. If the appid you fill in<code></code> does not have  Cloud Recording permission, 400 will be returned<code>. Please<code> handle it</code> in conjunction with the message field of the response message message</code>. |
| 401 Unauthorized | Authorization: The value of this field needs to refer to the authentication instructions. |
| 403 Forbidden | Your App ID has not yet activated cloud transcoder, please contact us. |
| 404 Not Found | Could not find cloud transcoder. |
| 409 Conflict | There is already a cloud transcoder with the same name. If you want to create a new cloud transcoder, please delete the old cloud transcoder with the same name first. |
| 429 Too Many Requests | The method call frequency exceeds the limit. |
| 500 Unknown | An error occurs in the Agora server. Try uploading the log files later. |
| 501 Not Implemented | This method is not implemented. |
| 503 Service Unavailable | The Agora server is temporarily overloaded or is under temporary maintenance. Please use the retry mechanism or contact us. |
| 504 Gateway Timeout | The server was acting as a gateway or proxy and did not receive a timely response from the upstream server. Please contact us. |

## Item

This section summarizes the important considerations for using Push Streaming RESTful API.

- Please do not do` any logic on the content of the message` field in the response message packet body. If the request fails, please troubleshoot the problem with the status code.
- The<code>` 202` status code only indicates that the server has received the task request, but it does not mean that the execution is complete. You need to continue to query the execution status through the GET</code> method to determine whether the task has been executed.
- After receiving the `404` status code, if` the` CREATE` request has returned successfully and the DELETE `method is not actively called, or the idle state of the cloud transcoder exceeds the `idleTimeout `field in the request parameters, it is recommended to adopt a backoff algorithm (for example, 5 seconds, 10 seconds, 15 seconds) ) Call the `Query` method to confirm.
- After` receiving` the 5xx` response status code, it is generally because the server has a problem in the response process. It is recommended to use the backoff algorithm (for example, 5 seconds, 10 seconds, 15 seconds) to call the Query` request for confirmation.