## Overview

The Agora message notification service can notify your server of** some events that occur in the cloud player (input online media stream)** business through HTTP or HTTPS requests.

**Working principles**

![](https://web-cdn.agora.io/docs-files/1584434372450)

**Enable cloud recording**

Contact us to configure and enable the callback service. See Message Notification Service for details[](https://docs-preprod.agora.io/cn/Agora%20Platform/ncs).

## HTTP request

The message notifies the server to send an HTTP or HTTPS request to your server using the POST method. The data format is JSON, the character encoding is UTF-8, and the signature algorithm is HMAC/SHA1.

**Header field of the request message**

`Content-Type`: `application/json`

`Agora-Signature: Signature `value

In order to ensure the security of the communication between the message notification server and your server, the use of this service requires verification of the signature. On the one hand, Agora uses the secret generated when configuring the service****, and finally generates the signature value through the HMAC/SHA1 algorithm. On the other hand, you need to use this **secret** to verify the signature value.

Please refer to the following sample code:

- Python

   ```python
   # !-*- coding: utf-8 -*-
import hashlib
import hmac

# Get the raw request body of the message notification and calculate the signature, which means that the request_body in the code below is the binary byte array before deserialization, not the dictionary after deserialization
request_body = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'

secret = 'secret'

signature = hmac.new(secret, request_body, hashlib.sha1).hexdigest()

print(signature) # 033c62f40f687675f17f0f41f91a40c71c0f134c
   ```

- Node.js

   ```javascript
   const path = require('path');

// Get the raw request body of the message notification and calculate its signature, which means that the requestBody in the code below is the binary byte array before deserialization, not the object after deserialization
const requestBody = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'

const secret = 'secret'

const signature = crypto.createHmac('sha1', secret).update(requestBody, 'utf8').digest('hex')

console.log(signature) // 033c62f40f687675f17f0f41f91a40c71c0f134c
   ```

- 1: Java.

   ```java
   import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class HmacSha {
    // Convert the encrypted byte array into a string
    public static String bytesToHex(byte[] bytes) {
        StringBuffer sb = new StringBuffer();

                for (int i = 0; i < userCount; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);

            if (hex.length() < 2) {
                sb.append(0);
            }

            sb.append(hex);
        }

        return sb.toString();
    }

    //HMAC/SHA1 encryption, return the encrypted string
    public static String hmacSha1(String message, String secret) {
           try {
            SecretKeySpec signingKey = new SecretKeySpec(secret.getBytes(
                        "utf-8"), "HmacSHA1");
            Mac mac = Mac.getInstance("HmacSHA1");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("utf-8"));

            return bytesToHex(rawHmac);
           } catch (...) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        //Get the raw request body of the message notification and calculate the signature, which means that the request_body in the code below is the binary byte array before deserialization, not the object after deserialization
        String request_body = "{\"eventMs\":1560408533119,\"eventType\":10,\"noticeId\":\"4eb720f0-8da7-11e9-a43e-53f411c2761f\",\"notifyMs\":1560408533119,\"payload\":{\"a\":\"1\",\"b\":2},\"productId\":1}";
        String secret = "secret";
        System.out.println(hmacSha1(request_body, secret)); //033c62f40f687675f17f0f41f91a40c71c0f134c
    }
}
   ```

**Body of the request message**

| Field Name | Category | Description |
| ----------- | ----------- | ------------------------------------------------------------ |
| `noticeId` | String | The ID of the workflow. Identifies an event notification from the business server. |
| `productId` | Number | The ID of the workflow. `4`:** Cloud Player, cloud player **(input online media stream). |
| `eventType` | Number | The type of notification. |
| `notifyMs` | Number | The Unix timestamp (ms) of the request made to your service. The value will be updated when the notification **is retried**. |
| Fields in `payload` | JSON Object | The specific content of the notification event. |
| `appId` | String | The App ID provided by Agora for each developer. You can get an App ID after creating a **project in** the Agora console****. An App ID is the unique identification of a project. |


**Cloud player events**

The message notification server can notify three types of events under the service:

****Cloud player created successfully****

When you call `Create` to successfully create a cloud player, the message notification server will notify your server of the event.

The `eventType` is` 1 (Player Created)`, and the `payload` example is as follows:

```json
{
  "player": {
    "channelName": "class32",
    "playTs": 1575508644,
    "createTs": 1575508644,
    id: 2a784467d647bb87b60b719f6fa56317,
    idleTimeOut
    "name": "web",
    "streamUrl": "rtmp://example.agora.io/live/class32/teacher101",
    "token": "2a784467d6",
    "uid": 101,
    "status": "connecting"
  },
  "lts": 1575508644149,
  "xRequestId": "7bbcc8a4acce48c78b53c5a261a8a564"
}
```

- The fields included in the` player`:
   - - ``channelName``: String, the channel name.
   - `playTs`: Number field, the Unix timestamp (seconds) when the cloud player starts to play the online media stream.
   - `ts`: Number type. Unix time (in seconds since 1 January 1970) in UTC.
   - `id`: String type field. It is a UUID (Universal Unique Identifier) generated by the Agora server to identify a created Converter.
   - `idleTimeout`: Number field, the maximum time (s) that the cloud player is in the "idle" state (that is, the media stream is not in the playing state). After the idle state exceeds the set `idleTimeOut`, the Converter will be destroyed automatically.
   - `name`: String type field.
   - `streamUrl`: String type field, URL address of online media stream.
   - `token`: String field, the dynamic key used by the cloud player in the Agora channel.
   - `uid`: Number type field, the UID of the cloud player in the Agora channel.
   - `rtcStreamAccount`: String type field. Return the user Account of the set cloud player in the channel.
   - `status`: String field, the status of the cloud player. "Connecting"` will be reported in this event`, indicating that the service server is connecting to the media stream address or detecting audio and video data.
- `lts`: Number type field, the Unix timestamp (ms) when the event occurred on the business server.
- `xRequestId`: String type field, which identifies the UUID (Universal Unique Identifier) of this request. This value is the `X-Request-ID` in the header of this request.

****Cloud player destroyed successfully****

When a cloud player is destroyed, the message notification server will notify your server of the event.

> Please refer to the `destroyReason` field for the reason of destruction.

The `eventType` is` 3 (Player Destroyed)`, and the `payload` example is as follows:

```json
{
  "player": {
    "channelName": "class32",
    id: 2a784467d647bb87b60b719f6fa56317,
    "name": "web",
    "playTs": 1575508644
  },
  "lts": 1575508666666,
  "destroyReason": "Delete Request",
  "fields": "player.name,player.channelName,player.id"
}
```

- The fields included in the` player`:
   - - ``channelName``: String, the channel name.
   - `id`: String type field. It is a UUID (Universal Unique Identifier) generated by the Agora server to identify a created Converter.
   - `name`: String type field.
   - `playTs`: Number field, the Unix timestamp (seconds) when the cloud player starts to play the online media stream.
- `lts`: Number type field, the Unix timestamp (ms) when the event occurred on the business server.
- `destroyReason`: String type field, describing the reason for the destruction of the cloud player:
   - `Delete Request`: The business server receives your `Delete request`.
   - `Internal Error`: Errors related to Agora channels. Common errors are invalid Token or Token timeout.
   - `Idle Timeout`: During the `idleTimeout time` you set, the business server cannot connect to the media stream address you specify or the media stream cannot be played.
- `For` the field[ mask of JSON encoding, please refer to the Google protobuf FieldMask document for details](https://googleapis.dev/nodejs/pubsub/latest/google.protobuf.html#.FieldMask). Used to specify a` subset of the player` field to be returned. In this example, it means that the Agora server returns`` a subset of the `name`, `channelName`, and `id` fields in the player field.

****Reports the playback state change.****

After successfully creating a cloud player, when the running state of the cloud player changes, the message notification server will notify your server of the event.

The ``eventType` is 4 (Player Status Changed)`, and the `payload` example is as follows:

```json
{
  "player": {
    "channelName": "class32",
    id: 2a784467d647bb87b60b719f6fa56317,
    "name": "web",
    "status": 200,
  },
  "lts": 1575508645000,
  "fields": "player.name,player.channelName,player.id,player.status"
}
```

- The fields included in the` player`:
   - - ``channelName``: String, the channel name.
   - `id`: String type field. It is a UUID (Universal Unique Identifier) generated by the Agora server to identify a created Converter.
   - `name`: String type field.
   - `status`: String field, the status of the cloud player:
      - `"connecting"`: The service server is connecting to the media stream address or detecting audio and video data. The status reports that the running cloud player has a problem and restarts the connection with the business server.
      - `"running"`: The cloud player is running normally, and the media stream is playing in the Agora channel.
      - `"failed"`: The service server cannot connect to the media stream address or the media stream cannot be played. This status reports that there is a problem with the running cloud player.
- `lts`: Number type field, the Unix timestamp (ms) when the event occurred on the business server.
- `For` the field[ mask of JSON encoding, please refer to the Google protobuf FieldMask document for details](https://googleapis.dev/nodejs/pubsub/latest/google.protobuf.html#.FieldMask). Used to specify a` subset of the player` field to be returned. In this example, it means that the Agora server returns`` a subset of the `name`, `channelName`, `id`, and `status` fields in the player field.