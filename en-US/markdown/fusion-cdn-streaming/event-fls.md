The Agora message notification server sends the message notification callbacks of Fusion-CDN Live Streaming as HTTPS POST requests to your server. The data format is JSON, the character encoding is UTF-8, and the signature algorithm is HMAC/SHA1 or HMAC/SHA256.

## Request Header

The `header` of the message notification callbacks contains the following fields:

| Field name | Value |
| :------------------- | :----------------------------------------------------------- |
| `Content-Type` | `application/json;charset=utf-8` |
| `Agora-Signature` | Agora generates the signature value by using the **secret** and the HMAC/SHA1 algorithm.  You need to use the **secret** and HMAC/SHA1 algorithm to verify the signature value. For more details, see [Signature Verification]( signature_verify?platform=RESTful). |
| `Agora-Signature-V2` | Agora generates the signature value by using the **secret** and the HMAC/SHA256 algorithm.  You need to use the **secret** and the HMAC/SHA256 algorithm to verify the signature value. For more details, see [Signature Verification]( signature_verify?platform=RESTful). |

## Request Body

The request body of the message notification callbacks contains the following fields:

| Field | Type | Description |
| :---------- | :---------- | :----------------------------------------------------------- |
| `noticeId` | String | Notification ID, identifying the notification for each event that occurs in the Agora server. |
| `productId` | Number | Service ID. Value 7 indicates the Fusion-CDN Live Streaming service. |
| `eventType` | Number | The event type of the notification. For more details, see [the Event Types of Fusion-CDN Live Streaming](#event-type). |
| `notifyMs` | Number | The Agora notification server sends the Unix timestamp (ms) of the notification to your server. This value is updated when **Retry** is notified. |
| `payload` | JSON Object | The content of the event notification. The `payload` varies with the`eventType`. For more details, see [the Event Types of Fusion-CDN Live Streaming](#event-type). |

Example of the request body of message notification callbacks:

```json
{
    "noticeId": "2000001428:4330:107",
    "productId": 7,
    "eventType": 0,
    "notifyMs": 1611566412672,
    "payload": {...}
}
```

<a name="event-type"></a>

## The Event Types of Fusion-CDN Live Streaming

The Agora message notification service can notify the following event types in the Fusion-CDN Live Streaming service:

| eventType | event_name | Description |
| :-------- | :---------------------- | :----------------- |
| [1](#1) | `publish_start` | The stream pushing starts. |
| [2](#2) | `publish_end` | The stream pushing ends. |
| [3](#3) | `new_record_file` | The new record file is generated. |
| [4](#4) | `new_snapshot_file` | The new snapshot file is generated. |
| [5](#5) | `new_moderation_result` | The new moderation result notification is sent. |

<a name="1"></a>

### 1 publish_start

`eventType` 1 indicates that the stream pushing starts, and the `payload` contains the following fields:

| Field | Data type | Meaning |
| :----------- | :------- | :------------------------ |
| `eventName` | String | Event name, publish_start. |
| `domain` | String | The stream-pushing domain name. |
| `entryPoint` | String | The entry point name. |
| `streamName` | String | The stream name. |
| `clientIp` | String | The client IP. |
| `nodeIp` | String | The node IP. |

Example of the `payload`:

```json
{
   "eventName": "publish_start",
   "domain": "test.agora.io",
   "entryPoint": "live",
   "streamName": "test_stream",
   "clientIp": "253.199.199.199",
   "nodeIp": "253.199.199.199"
}
```

<a name="2"></a>

### 2 publish_end

`eventType` 2 indicates that the stream pushing ends, and the `payload` contains the following fields:

| Field | Data type | Meaning |
| :----------- | :------- | :---------------------- |
| `eventName` | String | The event name, publish_end. |
| `domain` | String | The stream-pushing domain name. |
| `entryPoint` | String | The entry point name. |
| `streamName` | String | The stream name. |
| `clientIp` | String | The client IP. |
| `nodeIp` | String | The node IP. |

Example of the `payload`:

```json
{
   "eventName": "publish_end",
   "domain": "test.agora.io",
   "entryPoint": "live",
   "streamName": "test_stream",
   "clientIp": "253.199.199.199",
   "nodeIp": "253.199.199.199"
}
```

<a name="3"></a>

### 3 new_record_file

`eventType` 3 indicates that the new record file is generated, and the `payload` contains the following fields:

| Field | Data type | Meaning |
| :----------- | :------- | :-------------------------------------------- |
| `eventName` | String | The event name, new_record_file. |
| `entryPoint` | String | The entry point name. |
| `streamName` | String | The stream name. |
| `startTime` | Int64 | The start time of the new file recording, the Unix timestamp, in seconds. |
| `endTime` | Int64 | The end time of the new file recording, the Unix timestamp, in seconds. |
| `duration` | Integer | The recording duration, in seconds. |
| `fileSize` | Integer | The file size, in bytes. |
| `fileName` | String | The file name. |

Example of the `payload`:

```json
{
   "eventName": "new_record_file",
   "entryPoint": "live",
   "streamName": "test_stream",
    "startTime": 1627886487,
   "endTime": 1627888487,
   "duration": 100,
   "fileSize": 1024,
   "fileName": ""
}
```

<a name="4"></a>

### 4 new_snapshot_file

`eventType` 4 indicates that the new snapshot file is generated, and the `payload` contains the following fields:

| Field | Data type | Meaning |
| :----------- | :------- | :---------------------------- |
| `eventName` | String | The event name, new_snapshot_file. |
| `entryPoint` | String | The entry point name. |
| `streamName` | String | The stream name. |
| `fileName` | String | The file name of the new snapshot. |

Example of the `payload`:

```json
{
   "eventName": "new_snapshot_file",
   "entryPoint": "live",
   "streamName": "test_stream",
   "fileName": "test_filename",
}
```

<a name="5"></a>

### 5 new_moderation_result

`eventType` 5 indicates the new moderation result notification is sent, and the `payload` contains the following fields:

| Field | Data type | Meaning |
| :----------- | :------- | :----------------------------------------------------------- |
| `eventName` | String | The event name: new_moderation_result. |
| `entryPoint` | String | The entry point name. |
| `streamName` | String | The stream name. |
| `fileName` | String | The file name of the new snapshot. |
| `results` | JSON | The new moderation result contains the following fields:<br/> `porn`: JSON type. The new moderation result contains the following fields:<ul><li>`outputs`: JSON type. The possibility that the image is neutral, pornographic, or sexually suggestive.<ul><li>`Neutral`: Float type. The possibility that the image does not contain inappropriate content. This result means that there is no inappropriate content contained in the image, but there may be proper or moderate body nudity and body curves.</li><li> `porn`: Float type. The possibility that the image is pornographic. This result means the image contains nudity that includes genitals, sexual behaviors, and cues, or puts excessive emphasis on sexual characteristics.</li><li> `sexy`: Float type. The possibility that the image is sexually suggestive. This result means the image contains substantial nudity or the outline of the male or female sexual features, but no genital exposure.</li></ul></li><li>`scene`: String type, the content moderation result. This result is the RTC video intelligent moderation based on the three floating-point values in the `outputs`. `scene` returns the following values:<ul><li>`"neutral"`: The image does not contain inappropriate elements.</li><li>`"porn"`: The image is pornographic.</li><li>`"sexy"`: The image is sexually suggestive.</li></ul></li></ul> |
| `suggestion` | String | Suggestions for image processing.<li>`"Pass"`: No action is taken; the image does not contain inappropriate elements.</li><li>`"block"`: Rejected; the image is pornographic.</li><li>`"review"`: Either approved or in need of human moderation; the image is sexually suggestive. According to your own scenario, you could consider such images to be neutral, requiring no action to be taken, or in need of human moderation.  For example, for social applications with a higher tolerance for sexual suggestiveness, the images might be considered to be neutral; for education applications where this is not appropriate, the images likely need human moderation.</li> |

Example of the `payload`:

```json
{
    "eventName": "new_moderation_result",
    "entryPoint": "live",
    "streamName": "test_stream",
    "results": {
        "porn": {
            "outputs": {
                "sexy": 0.00188077823,
                "neutral": 0.915607393,
                "porn": 0.082511887,
            },
            "scene": "neutral"
        }
    },
    "fileName": "test_file_name",
    "suggestion": "pass"
}
```
