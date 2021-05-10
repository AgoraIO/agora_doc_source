## Introduction

Agora provides cloud transcoding services for multi-hosted interactive streaming scenarios, and supports transcoding and stream mixing on the Agora server to push the streams of multiple hosts to the Agora RTC channel. Audience in the RTC channel only need to subscribe to the transcoded and mixed streams to watch the live broadcast.

After using the cloud transcoding service, audiences do not need to subscribe to the streams of multiple hosts, which can greatly save pressure of downstream bandwidth and consumption of client device performance.

### Working principles

The process of transcoding and mixing multiple streams on the Agora server is equivalent to creating a cloud transcoder. The multiple streams before transcoding is the input of the cloud transcoder, and the stream after transcoding is the output of the cloud transcoder.

You can control the cloud transcoder through the cloud transcoding RESTful API:

- Create: Create a cloud transcoder. The Agora server will start transcoding and mixing the multiple streams you specified into one and push them to the Agora RTC channel.
- Delete: Destroy the cloud transcoder. The Agora server will stop transcoding and mixing streams.
- Query: Get cloud transcoder status information. The Agora server will query the cloud transcoder you specified.
- Update: 更新 cloud transcoder。 The Agora server will update the transcoding merge according to the configuration you specify.

After using these RESTful APIs, Agora's notification server sends the callback notification to your server through HTTP or HTTPS request.For details, see Message Notification Service.

## Generate a Token

builderToken is also called a dynamic key. The builderToken can guarantee the security of your request to control the cloud transcoder. Please call this method to generate a builderToken before creating the cloud transcoder.

### HTTP request

```http
POST https://api.agora.io/v1/projects/<appId>/rtmp-converters
```
`appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.

#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

The URL requires the following query string parameters:

| Field Name | Category | Description |
|---|----|---|
| `instanceId` | (Required)String  | The instance ID specified by the user. The length must be within 64 characters. The supported character set range is:<li>All lowercase English letters (a-z)</li><li>All uppercase English letters (A-Z)</li><li>Numbers 0-9</li><li>"-", "_"</li><div class="alert note"><li>One `instanceId` can generate multiple builderTokens, but only one builderToken can be used to initiate a request in a task.</li></div> |

### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

The response body contains the following fields:

| Field Name | Category | Description |
|---|----|---|
| `tokenName` | String | The value of builderToken, which needs to be passed in when calling other methods later. |
| `createTs` | Number | The Unix timestamp (s) when the Converter is created. |
| `instanceId` | Number | The instanceId set at the time of the request``. |

<div class="alert note">If this method call succeeds, you get a <code>resource</code> ID (<code>resourceId</code>) from the HTTP response body. Please use this builderToken to initiate a cloud confluence request within 5 minutes. After the time has expired, you need to regenerate the builderToken, otherwise other methods of cloud confluence cannot be called.

## Start the task Create: Create a cloud transcoder

### HTTP request

```http
POST https://api.agora.io/v1/projects/<appId>/rtmp-converters?regionHintIp={regionHintIp}
```
### Path parameter

`appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.

### Query Parameters

`builderToken`: String type required field, that is, dynamic key. Get** the parameter value tokenName** of builderToken by generating `builderToken` method``.


#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message
```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            config
                "transcoder": {
                    "idleTimeout": 300,
                    "inputs": {
                        "audioInputs": {
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "ccft",
                                        "rtcUid": 123456
                                    }
                                },
                                {
                                    "in": {
                                        "rtcChannel": "mcu_test1",
                                        "rtcUid": 8989
                                    }
                                }
                            ]
                        },
                        "videoInputs": {
                            "canvas": {
                                "height": 1080,
                                "width": 1920,
                                "fps": 30
                            },
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "ccft",
                                        "rtcUid": 123456
                                    },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 400,
                                        "height": 400
                                    },
                                    "zOrder": 1
                                },
                                {
                                    "in": {
                                        "rtcChannel": "mcu_test1",
                                        "rtcUid": 8989
                                    },
                                    "region": {
                                        "x": 0,
                                        "y": 400,
                                        "width": 400,
                                        "height": 400
                                    },
                                    "zOrder": 1
                                }
                            ]
                        }
                    },
                    "outputs": [
                        {
                            "out": {
                                "rtcChannel": "mcu_test1",
                                "rtcUid": 9393,
                                rtcToken: aab8b8f5a8cd4469a63042fcfafe7063
                            },
                            "videoOption": {
                                "fps": 30,
                                "codec": "H264",
                                "height": 1080,
                                "width": 1920
                            }
                        }
                    ]
                }
            }
        }
    }
}
```

Request` Body is the `converter field of JSON Object type, including the following fields: The field structure is shown in the figure:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- The details about `the recording status`.

   | Field Name | Category | Description |
   |---|----|---|
   | `<service>` |  (Required)JSON Object | The service name is set by the developer. It is necessary to ensure that the service name used in a cloud transcoder is unique. |
   | `<service>.serviceType` | (Required)String  | Service type. Cloud `Confluence: `cloudTranscoder. |
   | `<service>.config` |  (Required)JSON Object | 4: Invalid parameters of the video profile of the mixed video. Used to set the business parameters of the cloud transcoder. |
   | `<service>.config.transcoder` | (Required)String  | Object of cloud transcoder. |

- `<service>.config.transcoder` contains the following fields:

   | Field Name | Category | Description |
   |---|----|---|
   | `idleTimeOut` | (Optional)Number  | The maximum time (s) that the Converter is idle. Idle means that all users corresponding to the media stream processed by the Converter have left the channel. After the idle state exceeds the set `idleTimeOut`, the Converter will be destroyed automatically. Integer only. The value range is [[0,10000]], and the default value is `360`. |
   | `inputRtcTokens` | (Optional)JSON Array  | Leaves the RTC channel. The cloud transcoder needs this information to input the transcoded stream into the RTC channel.<li>Your Agora project has enabled the App Certificate on Console.</li><li>Your Agora project has enabled the App Certificate on Console.</li> |
   | `inputRtcTokens.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputRtcTokens.rtcToken` | (Required)String  | The token required to enter the RTC channel is used to ensure channel security. |
   | `inputRtcTokens.rtcUid` | (Required)Number  | UID。 The same UID is not allowed in the RTC channel, so please make sure that the value is different from `inputs.videoInputs.inputSources.in.rtcUid`. |
   | `inputs` |  (Required)JSON Object | The input configuration of cloud transcoder. |
   | `inputs.audioInputs` | (Optional)JSON Object | Audio input configuration of cloud transcoder.<li>If you do not pass a value, Agora will use the `input source corresponding to inputs.videoInputs.inputSources.in.rtcUid` as the audio input source of the cloud transcoder. This value method is suitable for scenes where both the host's audio and video are transcoded.</li><li>If you pass the value, Agora will transcode and mix the audio input source you specify. This value method is suitable for scenes where` inputs.audioInputs.inputSources.in.rtcUid` and `inputs.videoInputs.inputSources.in.rtcUid` are not exactly the same, that is, part of the host’s video is transcoded but the audio is not transcoded.</li> |
   | `inputs.audioInputs.inputSources` | (Required)JSON Array  | The audio input source of the cloud transcoder. Supports multiple input sources. |
   | `inputs.audioInputs.inputSources.in` |  (Required)JSON Object | The audio input source of the cloud transcoder. |
   | `inputs.audioInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.audioInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. Multiple users joins the channel with the same uid. |
   | `inputs.videoInputs` |  (Required)JSON Object | Video input configuration of cloud transcoder. |
   | `inputs.videoInputs.canvas` |  (Required)JSON Object | The canvas that hosts the cloud transcoder  video mixing. |
   | `inputs.videoInputs.canvas.height` | (Required)Number  | The height of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.canvas.width` | (Required)Number  | The width of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.inputSources` | (Required)JSON Array  | The video input source of cloud transcoder. Supports multiple input sources. |
   | `inputs.videoInputs.inputSources.in` |  (Required)JSON Object | The video input source of cloud transcoder. |
   | `inputs.videoInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.videoInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. The value is the same as `inputs.audioInputs.inputSources.in.rtcUid`. |
   | `inputs.videoInputs.inputSources.in.OfflineImage` | (Optional)JSON Object | The background image of the anchor after offline. If you don't pass the value, the screen after the anchor is offline will have no background image. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageType` | (Required)String  | The image watermark. Support JPG and PNG format pictures. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageUrl` | (Required)String  | Picture URL. Must be legal and URL, and include `jpg` or `png` suffix. |
   | `inputs.videoInputs.inputSources.region` |  (Required)JSON Object | The position on the canvas of the video input source picture of the cloud transcoder. |
   | `inputs.videoInputs.inputSources.region.x` | (Required)Number  | The x coordinate (pixel) of the screen on the canvas. The lateral displacement relative to the origin. (Take the upper left corner of the canvas as the origin, and the x coordinate as the upper left corner of the screen.) The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.y` | (Required)Number  | The y coordinate (pixel) of the screen on the canvas. The longitudinal displacement to the origin.（Take the upper left corner of the canvas as the origin and the y coordinate as the upper left corner of the screen.） The value range is [0,100]. |
   | `inputs.videoInputs.inputSources.region.width` | (Required)Number  | The width (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.height` | (Required)Number  | The height (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.zOrder` | (Required)Number  | The layer number of the video input screen of the cloud transcoder. The value range is [0,100]. 0 represents the lowest layer. 100 represents the top layer. |
   | `outputs` | (Required)JSON Array  | The output configuration of the cloud transcoder. Supports output of multiple streams processed by different transcoding configurations. |
   | `outputs.out` |  (Required)JSON Object | The output configuration of the cloud transcoder. |
   | `outputs.out.rtcChannel` | (Required)String  | Leaves the RTC channel. The value is` the same as inputRtcTokens.rtcChannel`. |
   | `outputs.out.rtcToken` | (Required)String  | The token required to enter the RTC channel is used to ensure channel security. The value is the same as `inputRtcTokens.rtcToken`. |
   | `outputs.out.rtcUid` | (Required)Number  | UID。 The value is` the same as inputRtcTokens.rtcUid`. |
   | `outputs.audioOption` | (Optional)JSON Object | Cloud transcoder transcoding and mixing configuration for audio streams. AUDIO_PROFILE_MUSIC_STANDARD`(2): A sample rate of` 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps. |
   | `outputs.audioOption.profileType` |  (Optional)String | Audio profiles. Support value:<li>`AUDIO_PROFILE_MUSIC_STANDARD(2`): A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.</li><li>`AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)`: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 56 Kbps.</li><li>`AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)`: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.</li><li>`AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.</li> |
   | `outputs.videoOption` |  (Required)JSON Object | Cloud transcoder is the configuration of transcoding and combining the video stream. |
   | `outputs.videoOption.fps` | Int, optional | The decoder output frame rate (fps) of the remote video. The value range is [1,30]. The default value is 15. |
   | `outputs.videoOption.codec` | (Required)String  | The codec of the transcoded output video. The supported value is `"H265"`. |
   | `outputs.videoOption.bitrate` | Int, optional | Bitrate of the CDN live output video stream. The value range is [1,10000]. If you do not pass the value, Agora will automatically set the video bitrate according to the network situation and other video attributes. |
   | `outputs.videoOption.width` | Int, required | The width (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `outputs.videoOption.height` | Int, required | The height (px) of the video image captured by the local camera. The value range is [1,30]. |


### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: Task initialization completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | Information about all services included in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud `Confluence: `cloudTranscoder. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: Service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: Service has started</li><li>`"IN_PROGRESS"`: Service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the tasks are all completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: Service parameter verification failed</li><li>`"ABNORMAL"`: Service exited abnormally</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |

## Stop task Delete: Destroy the cloud transcoder

### HTTP request

```http
DELETE https://api.agora.io/v1/projects/<appId>/rtmp-converters/<converterId>
```

### Path parameter

- `appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: The task ID of the cloud transcoder, UUID, used to identify the cloud transcoder created in this request.

### Query Parameters

`builderToken`: String type required field, that is, dynamic key. Get** the parameter value tokenName** of builderToken by generating `builderToken` method``.


#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

None

### HTTP response

#### Header field of the response message.

- `X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
   <div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

The response body contains the following fields:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: Task initialization completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | All service information contained in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud `Confluence: `cloudTranscoder. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: Service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: Service has started</li><li>`"IN_PROGRESS"`: Service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the tasks are all completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: Service parameter verification failed</li><li>`"ABNORMAL"`: Service exited abnormally</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |

## Query task Query: query cloud transcoder status information
### HTTP request

```http
PATCH https://api.agora.io/v1/projects/<appId>/rtmp-converters/<converterId>?sequence={sequence}
```
### Path parameter

- `appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: The task ID of the cloud transcoder, UUID, used to identify the cloud transcoder created in this request.

### Query Parameters

`builderToken`: String type required field, that is, dynamic key. Get** the parameter value tokenName** of builderToken by generating `builderToken` method``.

#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

None

### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

The response body contains the following fields:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: Task initialization completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | All service information contained in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud `Confluence: `cloudTranscoder. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: Service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: Service has started</li><li>`"IN_PROGRESS"`: Service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the tasks are all completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: Service parameter verification failed</li><li>`"ABNORMAL"`: Service exited abnormally</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |


## Update task Update: update cloud transcoder

### HTTP request

```http
PATCH https://api.agora.io/v1/projects/<appid>/rtsc/cloud-service-builder/tasks/<taskId>?builderToken=<tokenName>&sequenceId=<sequenceId>&updateMask=<updateMask>
```

### Path parameter

- `appId`: (Required) String type parameter. The App ID provided by Agora for each developer. You can get an App ID after creating a project in the Agora console. An App ID is the unique identification of a project.
- `taskId`: The task ID of the cloud transcoder, UUID, used to identify the cloud transcoder created in this request.

### Query Parameters

- `builderToken`: String type required field, that is, dynamic key. Get** the parameter value tokenName** of builderToken by generating `builderToken` method``.
- `zIndex`: Number type required field. The request sequence number is specified by the user. It starts counting from 0 and needs to be incremented to prevent the request from being out of order.
- `imageUrl`: String type field. For the field mask of JSON encoding, please refer to the[ Google protobuf FieldMask document for details](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#fieldmask).

#### Header field of the request message

- `Content-Type`: `application/json`
- `Authorization`: The value of this field needs to refer to the [authentication instructions.](https://docs.agora.io/cn/faq/restful_authentication)

#### Body of the request message

```json
{
    "services": {
        "cloudTranscoder": {
            "serviceType": "cloudTranscoder",
            config
                "transcoder": {
                    "name": "web",
                    "idleTimeout": 300,
                    "inputs": {
                        "audioInputs": {
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "test_transcoder_input_1",
                                        "rtcUid": 1000002
                                    }
                                }
                            ]
                        },
                        "videoInputs": {
                            "canvas": {
                                "height": 1080,
                                "width": 1920,
                                "fps": 30
                            },
                            "inputSources": [
                                {
                                    "in": {
                                        "rtcChannel": "test_transcoder_input_1",
                                        "rtcUid": 1000002
                                    },
                                    "region": {
                                        "x": 0,
                                        "y": 0,
                                        "width": 1280,
                                        "height": 720
                                    },
                                    "zOrder": 1
                                }
                            ]
                        }
                    },
                    "outputs": [
                        {
                            "out": {
                                "rtcChannel": "test_failover_12",
                                "rtcUid": 9222,
                                rtcToken: aab8b8f5a8cd4469a63042fcfafe7063
                            },
                            "videoOption": {
                                "fps": 30,
                                "codec": "H264",
                                "height": 1080,
                                "width": 1920
                            }
                        }
                    ]
                }
            }
        }
    }
}
```

Request` Body is the `converter field of JSON Object type, including the following fields: The field structure is shown in the figure:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1gnzxcugrdzj30u017otda.jpg" alt="create_request" style="zoom: 50%;" />

- The details about `the recording status`.

   | Field Name | Category | Description |
   |---|----|---|
   | region: JSON Object `type field`. | Service name, set when creating cloud transcoder. |
   | `<service>.serviceType` | (Required)String  | Service type. Cloud `Confluence: `cloudTranscoder. |
   | `<service>.config` |  (Required)JSON Object | Cloud convergence parameters. Used to set the business parameters of the cloud transcoder. |
   | `<service>.config.transcoder` | (Required)String  | Object of cloud transcoder. |

- `services.config.transcoder` contains the following fields:

   | Field Name | Category | Description |
   |---|----|---|
   | `inputRtcTokens` | (Optional)JSON Array  | Leaves the RTC channel. The cloud transcoder needs this information to input the transcoded stream into the RTC channel.<li>Your Agora project has enabled the App Certificate on Console.</li><li>Your Agora project has enabled the App Certificate on Console.</li> |
   | `inputRtcTokens.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputRtcTokens.rtcToken` | (Required)String  | The token required to enter the RTC channel is used to ensure channel security. |
   | `inputRtcTokens.rtcUid` | (Required)Number  | UID。 The same UID is not allowed in the RTC channel, so please make sure that the value is different from `inputs.videoInputs.inputSources.in.rtcUid`. |
   | `inputs` |  (Required)JSON Object | The input configuration of cloud transcoder. |
   | `inputs.audioInputs` | (Optional)JSON Object | Audio input configuration of cloud transcoder.<li>If you do not pass a value, Agora will use the `input source corresponding to inputs.videoInputs.inputSources.in.rtcUid` as the audio input source of the cloud transcoder. This value method is suitable for scenes where both the host's audio and video are transcoded.</li><li>If you pass the value, Agora will transcode and mix the audio input source you specify. This value method is suitable for scenes where` inputs.audioInputs.inputSources.in.rtcUid` and `inputs.videoInputs.inputSources.in.rtcUid` are not exactly the same, that is, part of the host’s video is transcoded but the audio is not transcoded.</li> |
   | `inputs.audioInputs.inputSources` | (Required)JSON Array  | The audio input source of the cloud transcoder. Supports multiple input sources. |
   | `inputs.audioInputs.inputSources.in` |  (Required)JSON Object | The audio input source of the cloud transcoder. |
   | `inputs.audioInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.audioInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. Multiple users joins the channel with the same uid. |
   | `inputs.videoInputs` |  (Required)JSON Object | Video input configuration of cloud transcoder. |
   | `inputs.videoInputs.canvas` |  (Required)JSON Object | The canvas that hosts the cloud transcoder  video mixing. |
   | `inputs.videoInputs.canvas.height` | (Required)Number  | The height of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.canvas.width` | (Required)Number  | The width of the canvas (pixel). The value range is [1,30]. |
   | `inputs.videoInputs.inputSources` | (Required)JSON Array  | The video input source of cloud transcoder. Supports multiple input sources. |
   | `inputs.videoInputs.inputSources.in` |  (Required)JSON Object | The video input source of cloud transcoder. |
   | `inputs.videoInputs.inputSources.in.rtcChannel` | (Required)String  | Leaves the RTC channel. |
   | `inputs.videoInputs.inputSources.in.rtcUid` | (Required)Number  | The UID corresponding to the input source. The value is the same as `inputs.audioInputs.inputSources.in.rtcUid`. |
   | `inputs.videoInputs.inputSources.in.OfflineImage` | (Optional)JSON Object | The background image of the anchor after offline. If you don't pass the value, the screen after the anchor is offline will have no background image. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageType` | (Required)String  | The image watermark. Support JPG and PNG format pictures. |
   | `inputs.videoInputs.inputSources.in.OfflineImage.imageUrl` | (Required)String  | Picture URL. Must be legal and URL, and include `jpg` or `png` suffix. |
   | `inputs.videoInputs.inputSources.region` |  (Required)JSON Object | The position on the canvas of the video input source picture of the cloud transcoder. |
   | `inputs.videoInputs.inputSources.region.x` | (Required)Number  | The x coordinate (pixel) of the screen on the canvas. The lateral displacement relative to the origin. (Take the upper left corner of the canvas as the origin, and the x coordinate as the upper left corner of the screen.) The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.y` | (Required)Number  | The y coordinate (pixel) of the screen on the canvas. The longitudinal displacement to the origin.（Take the upper left corner of the canvas as the origin and the y coordinate as the upper left corner of the screen.） The value range is [0,100]. |
   | `inputs.videoInputs.inputSources.region.width` | (Required)Number  | The width (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.region.height` | (Required)Number  | The height (px) of the video image captured by the local camera. The value range is [1,30]. |
   | `inputs.videoInputs.inputSources.zOrder` | (Required)Number  | The layer number of the video input screen of the cloud transcoder. The value range is [0,100]. 0 represents the lowest layer. 100 represents the top layer. |


Agora supports you to call the `Update` method to update the following fields:

- `inputs`
- `inputs.audioInputs`
- `inputs.videoInputs`
- `inputRtcTokens`

### HTTP response

#### Header field of the response message.

`X-Request-ID`: UUID (Universal Unique Identifier), which identifies this request.
<div class="alert note"><ul><li>If there is an error in the request, please print out the value in the log to troubleshoot the problem.</li><li>If the response status code of this request is not 2XX, there may not be this field in the response header.</li></ul></div>

#### Body of the response message

The response body contains the following fields:

<img src="https://tva1.sinaimg.cn/large/008eGmZEly1go15n67ctej30b8088wep.jpg" alt="create_response" style="zoom:80%;" />

Recoveries

| Field Name | Category | Description |
|---|----|---|
| `taskId` | JSON Object | The task ID of the cloud transcoder, UUID, is used to identify the cloud transcoder created in this request. |
| `createTs` | integer | The Unix timestamp (s) when the Converter is created. |
| `status` | String | The running status of the task to create a cloud transcoder:<li>`"IDLE"`: The task has not started</li><li>`"PREPARED"`: The task has received a start request</li><li>`"STARTING"`: The task is starting</li><li>`"CREATED"`: Task initialization completed</li><li>`"STARTED"`: The task has been started</li><li>`"IN_PROGRESS"`: The task is in progress</li><li>`"STOPPING"`: The task is stopping</li><li>``"stopped"``: The SDK stops processing the audio buffer.</li><li>`"EXIT"`: The task exits normally</li><li>`"FAILURE_STOP"`: The task exited abnormally</li> |
| `services` | JSON Object | Information about all services included in the task. |
| `services.<service>` | JSON Object | service name. |
| `services.<service>.serviceType` | String | Service type. Cloud `Confluence: `cloudTranscoder. |
| `services.<service>.config` | JSON Object | Service parameters. |
| `services.<service>.status` | String | Service status<li>`"IDLE"`: Service has not started</li><li>`"READY"`: The service is ready</li><li>`"STARTED"`: Service has started</li><li>`"IN_PROGRESS"`: Service is in progress</li><li>`"COMPLETED"`: The service has been stopped and the tasks are all completed</li><li>`"PARTIAL_COMPLETED"`: The service has stopped and the task is partially completed</li><li>`"VALIDATION_FAILED"`: Service parameter verification failed</li><li>`"ABNORMAL"`: Service exited abnormally</li><li>`"unknown": Unknown` status.</li> |
| `services.<service>.message` | String | The execution information of the service, which describes the specific reason for the abnormality of the service. |
| `services.<service>.details` | JSON Object | The execution details of the service. |


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