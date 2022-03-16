This page shows how to call Agora Chat RESTful APIs to send different types of messages, upload and download files, and retrieve historical messages.
Before calling the following methods, make sure you understand the call frequency limit of the Agora Chat RESTful APIs as described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

## <a name="param"></a>Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)<li>26 uppercase English letters (A-Z)<li>10 numbers (0-9)<li>"\_", "-", "."<div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username.<li>Ensure that each `username` under the same app is unique.</ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URL. |
| `path` | String | The request path, which is part of the request URL. You can safely ignore this parameter. |
| `entities ` | JSON | The response entity. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |

## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

`Authorization`: Bearer ${YourAppToken}

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. Agora Chat RESTful APIs only support authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).

## Sending a message<a name="sendmessage"></a>

This group of methods enable you to send and receive peer-to-peer and group messages. Message types include text, image, voice, video, command, extension, file, and custom messages.

Follow the instructions below to implement sending messages:

- For text, command, and custom messages: Call the send-message method, and pass in the message content in the request body.
- For image, voice, video, and file messages:
   1. Call the [upload-file](#upload) method to upload images, voice messages, videos, or other types of files, and get the file `uuid` from the response body.
   2. Call the send-message method, and pass the `uuid` in the request body.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/messages
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type` | String | `application/json` | Yes |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |

#### Request body

The request body is a JSON object, which contains the following fields:

| Field | Type | Description | Required |
| :------------ | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `target_type` | String | The type of the message recipient:<li>`users`: Users<li>`chatgroups`: Chat groups<li>`chatrooms`: Chat rooms | Yes |
| `target` | List | Array of message recipients. The length of the array must be less than 600. For different `target_types`, the value of `target` is described as follows:<li>`If target_type is users`: `target` is the username.<li>`If target_type is chatgroups`: `target` is the group ID.<li>`If target_type is chatrooms`: `target` is the chat room ID. | Yes |
| `msg` | JSON | The message content. For different message types, `msg` contains different fields, see [msg description](#msg) for details.<div class="alert note"> The size of the sent message must be no greater than 5 KB, or the SDK reposts an error with the error code `413 `. You can split the message before sending it.</div> | Yes |
| `from` | String | The username of the message sender, which cannot be empty.<br>If this field is not passed in the request body, the default message sender is `admin`. | Yes |
| `sync_device` | Bool | Whether to synchronize the message state to the sender after the message is sent successfully.<li>`true`: Yes<li>(default) `false`: No | No |

#### <a name="msg"></a>Descriptions of msg

**Sending a text or command message**

| Field | Type | Description | Required |
| :----- | :----- | :----------------------------------------------- | :------- |
| `type` | String | The message type:<li>`txt`: Text messages<li>`cmd`: Command messages | Yes |
| `msg` | JSON | The message content. | Yes |

**Sending an image message**

| Field | Type | Description | Required |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| `filename` | String | The name of the image file. | Yes |
| `secret` | String | The image access key, the `share-secret` you obtained from the response body of the [file-upload](#upload) method after the image file is successfully uploaded.  | This field is mandatory if you set the file access restrictions (`restrict-access`) when uploading the file. |
| `size` | JSON | The image dimensions (in pixels), which contain the following fields:<li>`height`: The image height<li>`width`: The image width | Yes |
| `url` | String | The image URL address: `https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`<br>, in which `uuid` is the file ID. After the image file is successfully uploaded, you can obtain it from the response body of the [file-upload](#upload) method.. | Yes |
| `type` | String | The message type. For image messages, set it as `img`. | Yes |

**Sending a voice message**

| Field | Type | Description | Required |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------- |
| `filename` | String | The name of the image file. | Yes |
| `secret` | String | The audio file access key, the `share-secret` you obtained from the response body of the [file-upload](#upload) method after the audio file is uploaded successfully. | This field is mandatory if you set the file access restrictions (`restrict-access`) when uploading the file. |
| `Length` | Int | The duration of the audio file, in seconds. | Yes |
| `url` | String | The URL address of the audio file: `https://{host}/{org_name}/{app_name}/chatfiles/{uuid} `<br>, in which `uuid` is the file ID. After the audio file is uploaded successfully, you can obtain it from the response body of [file-upload](#upload) method. | Yes |
| `type` | String | The message type. For voice messages, set it as `audio`. | Yes |

**Sending a video message**

| Field | Type | Description | Required |
| :------------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------- |
| `thumb` | String | The URL address of the video thumbnail: `https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`<br>, in which `uuid` is the unique identifier of the video thumbnail. After uploading the thumbnail file successfully, you can obtain it from the the response body of the [file-upload](#upload) method. | Yes |
| `length` | Number | The video duration, in seconds. | Yes |
| `secret` | String | The video file access key, the `share-secret` you obtained from the response body of the [file-upload](#upload) method after the video file is uploaded successfully. | This field is mandatory if you set the file access restriction (`restrict-access`) when the video file is uploaded. |
| `file_length` | Long | The size of the video file, in bytes. | Yes |
| `thumb_secret` | String | The video thumbnail access key, the `share-secret` you obtained from the response body of the [file-upload](#upload) method after the thumbnail file is uploaded successfully. | This field is mandatory if you set the file access restrictions (`restrict-access`) when the thumbnail file is uploaded. |
| `url` | String | The URL address of the video file: `https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`<br>, in which uuid is the file ID. After the video file is uploaded successfully, you can obtain it from the response body of the [file-upload](#upload) method. | Yes |
| `type` | String | The message type. For video messages, set it as `video`. | Yes |

**Sending a location message**

| Field | Type | Description | Required |
| :----- | :----- | :------------------------- | :------- |
| `lat` | String | The latitude of the location, in degrees. | Yes |
| `lng` | String | The longitude of the location, in degrees. | Yes |
| `addr` | String | The detailed description of the location. | Yes |

**Sending a custom message**

| Parameter | Type | Description | Required |
| :------------ | :----------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `customEvent` | String | The user-defined event type. The data length must be 32 characters or less. Supported character sets are as follows:<li>26 lowercase English letters (a-z)<li>26 uppercase English letters (A-Z)<li>10 numbers (0-9)<li>"-", "\_", "/", "." | No |
| `customExts` | Map<String,String> | The custom event properties. It can contain up to 16 elements. | No |
| `from` | String | The username of the message sender. Ensure that you set this field. <br>If this field is not passed in the request body, the default message sender username is `admin`. | Yes |
| `ext` | JSON | The custom extension properties. Ensure that you set this field. | No |
| `type` | String | The message type. For custom messages, set it as `custom`. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds. The response body contains the following fields:

| Field | Type | Description |
| :----- | :--- | :-------------------------------------------------------------------------------------------------- |
| `data` | JSON | The details of the response. which contains an array of the usernames of the message recipients. <br>For example, `"user2" : "success"` means that the message is successfully sent to user2. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

**Sending a text message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type": "users",
    "target": ["user2","user3"],
    "msg":
        {
            "type": "txt",
            "msg": "testmessage"
        },
    "from": "user1"
}'
'http://XXXX/XXXX/XXXX/messages'
```

**Sending an image message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -i 'https://XXXX/XXXX/XXXX/messages' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type":"users",
    "target":["user2"],
    "from":"user1",
    "msg":
        {
            "type":"img",
            "filename":"testimg.jpg",
            "secret":"VfEpSmSvEeS7yUXXXXXXXXXXXXpujTNfSTsrDt6eNb_",
            "url":"https://XXXX/XXXX/XXXX/chatfiles/55f12940-XXXX-XXXX-8a5b-ff2336f03252",
            "size":
                {
                    "width":480,
                    "height":720
                }
        }
}'
```

**Sending a voice message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -H "Authorization: Bearer <YourAppToken>" "https://XXXX/XXXX/XXXX/messages" -d '
{
    "target_type" : "users",
    "target" : [
        "user2",
        "user3"
    ],
    "msg" : {
        "type": "audio",
        "url": "https://XXXX/XXXX/XXXX/chatfiles/1dfc7f50-XXXX-XXXX-8a07-7d75b8fb3d42",
        "filename": "testaudio.amr",
        "length": 10,
        "secret": "Hfx_XXXXEeSdDW-SuX2EaZcXXXXEig3OgKZye9IzKOwoCjM"
    },
    "from" : "user1"
}'
```

**Sending a video message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -i 'https://XXXX/XXXX/XXXX/messages' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type":"users",
    "target":[
        "user2",
        "user3"
    ],
    "from":"user1",
    "msg":{
        "type":"video",
        "filename" : "testvideo.mp4",
        "thumb" : "https://a1.easemob.com/easemob-demo/testapp/chatfiles/67279b20-7f69-11e4-8eee-21d3334b3a97",
        "length" : 0,
        "secret":"VfEpSmSvEeS7yU8dwa9rAQc-DIL2HhmpujTNfSTsrDt6eNb_",
        "file_length" : 58103,
        "thumb_secret" : "ZyebKn9pEeSSfY03XXXXND24zXXXXs7HpPN1oMV-1JxN2O2I",
        "url" : "https://XXXX/XXXX/XXXX/chatfiles/671dfe30-XXXX-XXXX-ba67-8fef0d502f46"
    }
}'
```

**Sending a location message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type": "users",
    "target":[
        "user2"
    ],
    "msg": {
        "type": "loc",
        "lat": "39.966",
        "lng":"116.322",
        "addr":"test"
    },
    "from": "user1"
}' 'http://XXXX/XXXX/XXXX/messages'
```

**Sending a command message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -H "Authorization:Bearer <YourAppToken>" -i "https://XXXX/XXXX/XXXX/messages" -d '
    {
        "target_type":"users",
        "target":
            [
                "user2",
                "user3"
            ],
        "msg":
            {
                "type":"cmd",
                "action":"action1"
            },
        "from":"user1"
}'
```

**Sending a custom message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -L -X POST 'https://XXXX/XXXX/XXXX/messages' -H 'Accept: application/json' -H 'Content-Type: application/json' -H 'Authorization: Bearer ${<YourAppToken> }' -d '
{
    "target_type":"users",
    "target":[
        "user2"
    ],
    "msg":{
            "type":"custom",
            "customEvent":"gift_1",
            "customExts":{
                "name":"flower",
                "size":"16",
                "price":"100"
                }
        },
    "from":"user1",
    "ext":{
        "attr1":"test"
    }
}'
```

**Sending an extension message**

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -H "Authorization:Bearer <YourAppToken>" -i "https://a1.easemob.com/easemob-demo/testapp/messages" -d '
{
    "target_type":"users",
    "target":[
        "user2",
        "user3"],
    "msg":{
        "type":"txt",
        "msg":"testmessage"
    },
    "from":"user1",
    "ext":{
        "attr1":"test"
    }
}'
```

#### Response example

**Sending a text message**

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/messages",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1543922150902,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**Sending an image message**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success"
    },
    "timestamp": 1415166497129,
    "duration": 12,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**Sending a voice message**

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/messages",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1543922150902,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**Sending a video message**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1415166234863,
    "duration": 5,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**Sending a location message**

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/messages",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "data": {
        "user2": "success"
    },
    "timestamp": 1543922150902,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**Sending a command message**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1415167842297,
    "duration": 4,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**Sending a custom message**

```json
{
    "path": "/messages",
    "uri": "https://XXXX/XXXX/testapp/messages",
    "timestamp": 1597292981767,
    "organization": "XXXX",
    "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
    "action": "post",
    "data": {
        "user2": "success"
    },
    "duration": 0,
    "applicationName": "XXXX"
}
```

**Sending an extension message**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1415167842297,
    "duration": 4,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="upload"></a>Uploading files

This method enables you to upload images, audio, video, or other types of files. Ensure that you read the following instructions before calling this method:

- The Agora Chat service supports restricted access to uploaded files. Once you enable this feature, users need provide a key to download restricted access files.
- When uploading an image or video file, the Agora Chat service creates a thumbnail of the image or video on the server so that users can preview the files when downloading them.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatfiles
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :---------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `Content-Type` | String | The content type. Pass `multipart/form-data` | Yes |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |
| `restrict-access` | Bool | Whether to restrict access to this file.<li>If you set this parameter, whether to `true` or `false`, the access is restricted. The user needs to provide a file access key (`share-secret)` to download the file. You can obtain the access key from the response body.<li>If you do not set this parameter, the access is not restricted. Users can download the file directly. | No |

#### Request body

The request body is in the form-data format and contains the following fields:

| Field | Type | Description | Required |
| :---- | :----- | :--------------------------------------------------------------------------------------------- | :------- |
| Key | String | `file` | Yes |
| Value | String | The local path of the file to be uploaded. <br>You can choose to upload local files directly in Postman. The file size must be less than 10 MB. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request is successful, and the response body contains the following fields:

| Field | Type | Description |
| :---------------------- | :----- | :------------------------------------------------------------------------------------------------------------------- |
| `entities.uuid` | String | The file ID, a unique ID assigned to the file by the Agora Chat service. <br>You need to save this `uuid` yourself, and provide it when calling the [Send-file-messages](#sendmessage) method. |
| `entities.type` | String | File type: `chatfile`. |
| `entities.share-secret` | String | The file access key. <br>You need to save the `share-secret` yourself for use when [downloading the file ](#download). |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```shell
# Replace <YourAppToken> with the app token you generated on the server, and replace the path of file with the local full path where the file to be uploaded is located
curl -X POST https://XXXX/XXXX/XXXX/chatfiles -H 'Authorization: Bearer <YourAppToken>' -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' -H 'restrict -access: true' -F file=@/Users/test/9.2/Agora/image/IMG_2953.JPG
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/chatfiles",
    "uri": "https://XXXX/XXXX/XXXX/chatfiles",
    "entities": [
        {
            "uuid": "5fd74830-XXXX-XXXX-822a-81ea50bb049d",
            "type": "chatfile",
            "share-secret": "X9dIOla-EemnXXXXtUZLGyqG9Y-XXXX_ysw27NqTV1_g7Yc"
        }
    ],
    "timestamp": 1554371126338,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="download"></a>File download

Download images, audio, video, or other types of files.

### HTTP request

```http
GET https://{HOST}/{org_name}/{app_name}/chatfiles/{uuid}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------------------------------------------------------------------------------------------------------- | :------- |
| `uuid` | String | File ID, the unique identifier assigned to the file by the Agora Chat system. After a file is uploaded successfully, you can obtain its `uuid` from the response body. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| `Accept` | String | `application/octet-stream`, which means to download files in binary data stream format. | Yes |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |
| `share-secret` | String | The file access key. After the file is uploaded successfully, it is obtained from the response body of [file ](upload #upload). | This field is mandatory if you set the file access restrictions (`restrict-access`) when uploading the file. |
| `thumbnail` | Bool | If the type of the file to be downloaded is image or video, you can download the thumbnail of the image or video:<li>Pass in this parameter: whether the field value is `true` or `false`, it means to download the thumbnail.<li>If this parameter is not passed in, it means to download the image or video file. | No |

### HTTP response

If the returned HTTP status code is `200`, it indicates that the request is successful, and the file binary data stream is returned.

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```shell
# Replace <YourAppToken> with the app token generated in your server.
curl -X GET -H 'Accept: application/octet-stream' -H 'Authorization: Bearer <YourAppToken>' -H 'share-secret: f0Vr-uyyEeiHpHmsu53XXXXXXXXZYgyLkdfsZ4xo2Z0cSBnB' 'http://XXXX/XXXX/XXXX/chatfiles/7f456bf0 -XXXX-XXXX-b630-777db304f26c'
```

## Retrieving historical messages

Retrieves historical messages sent and received by the user. You can get all historical messages within one hour from the specified start time in one request.

The default storage time of historical messages differs by plan version. See [package details](./agora_chat_plan?platform=RESTful) for details.

### HTTP request

```http
GET https://{HOST}/{org_name}/{app_name}/chatmessages/${time}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `time` | String | The start time of the historical message. UTC time, using the ISO8601 standard, in the format `yyyyMMddHH`. <br>For example, if `time` is` 2018112717`, it means to query historical messages from 17:00 on November 27, 2018 to 18:00 on November 27, 2018. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Description | Required |
| :-------------- | :--------------------- | :------- |
| `Content-Type` | `application/json` | Yes |
| `Authorization` | Bearer ${YourAppToken} | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request is successful, and the response body contains the following fields:

| Parameter | Type | Description |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `data.url` | String | The download address of the historical message file.<li>The `url` consists of the historical message file storage address, expiration Unix timestamp (`Expires`), third-party cloud storage access key (`OSSAccessKeyId`), and third-party cloud storage verification signature (`Signature`).<li>The URL is only valid before `Expires`. Once it expires, you need to call this method to get the URL again. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```shell
# Replace <YourAppToken> with the app token generated in your server.
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatmessages/2018112717'
```

#### Response example

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatmessages/2018112717",
    "data": [
        {
            "url": "http://XXXX?Expires=1543316122&OSSAccessKeyId=XXXX&Signature=XXXX"
        }
    ],
    "timestamp": 1543314322601,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

### content of historical messages

After successfully querying historical messages, you can visit the URL to download the historical message file and view the specific content of the historical message.

Historical messages are of type JSON. Examples are as follows:

```json
{
    "msg_id": "5I02W-XX-8278a",
    "timestamp": 1403099033211,
    "direction": "outgoing",
    "to": "XXXX",
    "from": "XXXX",
    "chat_type": "chat",
    "payload": {
        "bodies": [
            {...}
        ],
        "ext": {
            "key1": "value1",
            ...
        },
        "from": "zw123",
        "to": "XXXX"
    }
}
```

Historical messages contain the following fields:

| Field | Type | Description |
| :--------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `msg_id` | String | The message ID. The unique identifier for sending the message. |
| `timestamp` | Number | The Unix timestamp in milliseconds when the message is sent, in UTC. |
| `direction` | String | The message sending direction:<li>`incoming`: Upstream messages, which means that the message is sent by the user to the Agora Chat server.<li>`outgoing`: Downlink messages, which means that the message sent by the Agora Chat server to the user. |
| `from` | String | The username of the message sender. |
| `to` | String | The username or group ID of the message recipient. |
| `chat_type` | String | Chat mode:<li>`chat`: One-to-one chat<li>`groupchat`: Group chat<li>`chatroom`: Chat room |
| `payload` | JSON | The detailed content of the message. For example, message extension information or custom extension attributes. |
| `payload.bodies` | JSON | For the detailed message content, see the `bodies` of each message type below. |

#### Sending a text message

The `bodies` of a text message contains the following fields:

| Field | Type | Description |
| :----- | :----- | :------------------------------- |
| `msg` | String | The message content. |
| `type` | String | The message type. For text messages, set it as `txt`. |

Example

```json
{
    "bodies": [
        {
            "msg": "welcome to Agora!",
            "type": "txt"
        }
    ]
}
```

#### Sending an image message

The `bodies` of an image message contains the following fields:

| Field | Type | Description |
| :------------ | :----- | :-------------------------------------------------------------------------------- |
| `file_length` | Number | The size of the image attachment, in bytes. |
| `filename` | String | The image name, including a suffix that indicates the image format. |
| `secret` | String | The image file access key. <br>This field exists if you set the access restriction when calling the [upload-file](#upload) method. |
| `size` | Number | The size of the image, in pixels.<li>`height`: The image height<li>`width`: The image width |
| `type` | String | The message type. For image messages, set it as `img`. |
| `url` | String | The URL address of the image. |

Example

```json
{
    "bodies": [
        {
            "file_length": 128827,
            "filename": "test1.jpg",
            "secret": "DRGM8OZrEeO1vaXXXXXXXXHBeKlIhDp0GCnFu54xOF3M6KLr",
            "size": {
                "height": 1325,
                "width": 746
            },
            "type": "img",
            "url": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/65e54a4a-XXXX-XXXX-b821-ebde7b50cc4b"
        }
    ]
}
```

#### Sending a location message

The `bodies` of a location message contains the following fields:

| Field | Type | Description |
| :----- | :----- | :--------------------------- |
| `addr` | String | The descriptions of the location. |
| `lat` | Number | The latitude of the location. |
| `lng` | Number | The longitude of the location. |
| `type` | String | The message type. For location messages, set it as `loc`. |

Example

```json
{
    "bodies": [
        {
            "addr": "test",
            "lat": 39.9053,
            "lng": 116.36302,
            "type": "loc"
        }
    ]
}
```

#### Sending a voice message

The `bodies` of a voice message contains the following fields:

| Field | Type | Description |
| :------------ | :----- | :-------------------------------------------------------------------------------- |
| `file_length` | Number | The size of the audio file, in bytes. |
| `filename` | String | The audio file name, including a suffix that indicates the the audio file format. |
| `secret` | String | The audio file access key. <br>This field exists if you set the access restriction when calling the [upload-file](#upload) method. |
| `length` | Number | The duration of the audio file, in seconds. |
| `type` | String | The message type. For voice messages, set it as `audio`. |
| `url` | String | The URL address of the audio file. |

Example

```json
{
    "bodies": [
        {
            "file_length": 6630,
            "filename": "test1.amr",
            "length": 10,
            "secret": "DRGM8OZrEeO1vafuJSo2IjHBeKlIhDp0GCnFu54xOF3M6KLr",
            "type": "audio",
            "url": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/0637e55a-XXXX-XXXX-ba23-51f25fd1215b"
        }
    ]
}
```

#### Sending a video message

The `bodies` of a video message contains the following fields:

| Field | Type | Description |
| :------------- | :----- | :---------------------------------------------------------------------------------- |
| `file_length` | Number | The size of the video file, in bytes. |
| `filename` | String | The video file name, including a suffix that indicates the video file format. |
| `secret` | String | The video file access key. <br>This field exists if you set the access restriction when calling the [upload-file](#upload) method. |
| `length` | Number | The video duration, in seconds. |
| `size` | Number | The video thumbnail size, in pixels.<li>`width`: The width of the video thumbnail<li>`height`: The height of the video thumbnail |
| `thumb` | String | The URL address of the video thumbnail. |
| `thumb_secret` | String | The thumbnail file access key. <br>This field exists if you set the access restriction when calling the [upload-file](#upload) method. |
| `type` | String | The message type. For video messages, set it as `video`. |
| `url` | String | The URL address of the video file. You can visit this URL to download video files. |

Example

```json
{
    "bodies": [
        {
            "file_length": 58103,
            "filename": "1418105136313.mp4",
            "length": 10,
            "secret": "VfEpSmSvEeS7yU8dwa9rAQc-DIL2HhmpujTNfSTsrDt6eNb_",
            "size": {
                "height": 480,
                "width": 360
            },
            "thumb": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/67279b20-XXXX-XXXX-8eee-21d3334b3a97",
            "thumb_secret": "ZyebKn9pEeSSfY03ROk7ND24zUf74s7HpPN1oMV-1JxN2O2I",
            "type": "video",
            "url": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/671dfe30-XXXX-XXXX-ba67-8fef0d502f46"
        }
    ]
}
```

#### File messages

The `bodies` of a file message contains the following fields:

| Field | Type | Descriptions |
| :------------ | :----- | :---------------------------------------------------------------------------- |
| `file_length` | Number | The file size, in bytes. |
| `filename` | String | The file name, including a suffix that indicates the file format. |
| `secret` | String | The file access key. <br>This field exists if you set the access restriction when calling the [upload-file](#upload) method. |
| `type` | String | The message type. For file messages, set it as `file`. |
| `url` | String | The URL address of the file. You can visit this URL to download video files. |

Example

```json
{
    "bodies": [
        {
            "file_length": 3279,
            "filename": "record.md",
            "secret": "2RNXCgeeEeeXXXX-XXXXbtZXJH4cgr2admVXn560He2PD3RX",
            "type": "file",
            "url": "https://XXXX/XXXX/XXXX/chatfiles/d9135700-XXXX-XXXX-b000-a7039876610f"
        }
    ]
}
```

#### Command messages

The `bodies` of a command message contains the following fields:

| Field | Type | Description |
| :------- | :----- | :--------------------------- |
| `action` | String | The request method. |
| `type` | String | The message type. For command messages, set it as `cmd`. |

Example

```json
{
    "bodies": [
        {
            "action": "run",
            "type": "cmd"
        }
    ]
}
```

#### Custom messages

The `bodies` of a custom message contains the following fields:

| Field | Type | Description |
| :------------ | :----- | :----------------------------------------------- |
| `customExts` | JSON | The custom extension properties. You can set the fields in the extension properties yourself. |
| `customEvent` | String | The custom event type. |
| `type` | String | The message type. For custom messages, set it as `custom`. |

Example of custom type message format

```json
{
    "bodies": [
        {
            "customExts": {
                "name": "flower",
                "size": "16",
                "price": "100"
            },
            "customEvent": "gift_1",
            "type": "custom"
        }
    ]
}
```
	
	<a name="code"></a>
## Status codes

| Status code | Description |
| :------------------ | :----------------------------------------------------------- |
| 200 | The request succeeds. |
| 401 | Authentication fails. Possible reasons are missing token, invalid token, or expired token. You need to retrieve a new token and call the method again. |
| 404 | The user adding contacts or is added as a contact does not exist. |
| 429, 503 or 5xx | Call frequency exceeds the limit. Pause and try again later. If you need a higher call frequency, contact technical support. |
| 500 | An internal server error occurs, and the server is unable to complete the request. Contact our technical support. |
