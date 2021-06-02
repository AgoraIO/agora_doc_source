## 概述

Agora 消息通知服务可以将**云端播放器（输入在线媒体流）** 业务中的发生的一些事件以 HTTP 或 HTTPS 请求的方式通知到你的服务器。

**工作原理图**

![](https://web-cdn.agora.io/docs-files/1584434372450)

**开通服务**

使用 Agora 消息通知服务前需要申请开通并进行配置，关于如何开通服务以及消息通知回调的数据格式详见[消息通知服务](https://docs-preprod.agora.io/cn/Agora%20Platform/ncs)。

## HTTP/HTTPS 请求

消息通知服务器以 POST 方法向你服务器发送 HTTP 或 HTTPS 请求。数据格式为 JSON，字符编码为 UTF-8，签名算法为 HMAC/SHA1.

**请求的 Header**

`Content-Type`：`application/json`

`Agora-Signature`：签名值

为保证消息通知服务器与你的服务器之间的通信安全，使用该服务需要验证签名。一方面，Agora 使用配置该服务时生成的 **secret**，并通过 HMAC/SHA1 算法最终生成签名值。另一方面，你需要使用这个 **secret** 来验证该签名值。

你可以参考如下示例代码验证签名：

- Python

  ```python
  # !-*- coding: utf-8 -*-
  import hashlib
  import hmac
    
  # 拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 request_body 是反序列化之前的 binary byte array，不是反序列化之后的 dictionary
  request_body = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'
    
  secret = 'secret'
    
  signature = hmac.new(secret, request_body, hashlib.sha1).hexdigest()
    
  print(signature) # 033c62f40f687675f17f0f41f91a40c71c0f134c
  ```

- Node.js

  ```javascript
  const crypto = require('crypto')
    
  // 拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 requestBody 是反序列化之前的 binary byte array，不是反序列化之后的 object
  const requestBody = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'
    
  const secret = 'secret'
    
  const signature = crypto.createHmac('sha1', secret).update(requestBody, 'utf8').digest('hex')
    
  console.log(signature) // 033c62f40f687675f17f0f41f91a40c71c0f134c
  ```

- Java

  ```java
  import javax.crypto.Mac;
  import javax.crypto.SecretKey;
  import javax.crypto.spec.SecretKeySpec;
   
  public class HmacSha {
      // 将加密后的字节数组转换成字符串
      public static String bytesToHex(byte[] bytes) {
          StringBuffer sb = new StringBuffer();
   
          for (int i = 0; i < bytes.length; i++) {
              String hex = Integer.toHexString(bytes[i] & 0xFF);
   
              if (hex.length() < 2) {
                  sb.append(0);
              }
   
              sb.append(hex);
          }
   
          return sb.toString();
      }
   
      //HMAC/SHA1 加密，返回加密后的字符串
      public static String hmacSha1(String message, String secret) {
          try {
              SecretKeySpec signingKey = new SecretKeySpec(secret.getBytes(
                          "utf-8"), "HmacSHA1");
              Mac mac = Mac.getInstance("HmacSHA1");
              mac.init(signingKey);
   
              byte[] rawHmac = mac.doFinal(message.getBytes("utf-8"));
   
              return bytesToHex(rawHmac);
          } catch (Exception e) {
              throw new RuntimeException(e);
          }
      }
   
      public static void main(String[] args) {
          //拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 request_body 是反序列化之前的 binary byte array，不是反序列化之后的 object
          String request_body = "{\"eventMs\":1560408533119,\"eventType\":10,\"noticeId\":\"4eb720f0-8da7-11e9-a43e-53f411c2761f\",\"notifyMs\":1560408533119,\"payload\":{\"a\":\"1\",\"b\":2},\"productId\":1}";
          String secret = "secret";
          System.out.println(hmacSha1(request_body, secret)); //033c62f40f687675f17f0f41f91a40c71c0f134c
      }
  }
  ```

**请求的 Body**

| 字段        | 类型        | 描述                                                         |
| ----------- | ----------- | ------------------------------------------------------------ |
| `noticeId`  | String      | 通知 ID。标识来自业务服务器的一次事件通知。                  |
| `productId` | Number      | 业务 ID。`4`: **Cloud Player**，云端播放器（输入在线媒体流）。 |
| `eventType` | Number      | 通知的事件类型。                                             |
| `notifyMs`  | Number      | 向你的服务发出请求的 Unix 时间戳 (ms)。通知**重试**时该值会更新。 |
| `payload`   | JSON Object | 通知事件的具体内容。                                         |
| `appId`     | String      | Agora 为每个开发者提供的 App ID。在 Agora 控制台创建一个**项目**后即可得到一个 **App ID**。一个 App ID 是一个项目的唯一标识。 |


**云端播放器事件**

消息通知服务器可以通知该业务下的三种事件：

****云端播放器创建成功****

当你调用 `Create` 成功创建一个云端播放器时，消息通知服务器会向你的服务器通知该事件。

`eventType` 为 `1(Player Created)`，`payload` 示例如下：

```json
{
  "player": {
    "channelName": "class32",
    "playTs": 1575508644,
    "createTs": 1575508644,
    "id": "2a784467d647bb87b60b719f6fa56317",
    "idleTimeout": 300,
    "name": "teacher101",
    "streamUrl": "rtmp://example.agora.io/live/class32/teacher101",
    "token": "2a784467d6",
    "uid": 101,
    "status": "connecting"
  },
  "lts": 1575508644149,
  "xRequestId": "7bbcc8a4acce48c78b53c5a261a8a564"
}
```

- `player` 包含的字段：
  - `channelName`：String 型字段，Agora 频道名称。
  - `playTs`：Number 型字段，云端播放器开始播放在线媒体流时的 Unix 时间戳（秒）。
  - `createTs`：Number 型字段，云端播放器创建的 Unix 时间戳 (s)。
  - `id`：String 型字段，云端播放器的 ID。它是 Agora 服务器生成的一个 UUID（通用唯一识别码），标识已创建的一个云端播放器。
  - `idleTimeout`：Number 型字段，云端播放器处于“空闲”状态（即媒体流为非播放状态）的最大时长 (s)。空闲状态超过设置的 `idleTimeout` 后，该 player 会自动销毁。
  - `name`：String 型字段，云端播放器的名字。
  - `streamUrl`：String 型字段，在线媒体流 URL 地址。
  - `token`：String 型字段，云端播放器在 Agora 频道内使用的动态密钥。
  - `uid`：Number 型字段，云端播放器在 Agora 频道内的 UID。
  - `account`：String 型字段。返回设置的云端播放器在频道内的用户 Account。
  - `status`：String 字段，云端播放器的状态。该事件中会报告 `"connecting"`，表示业务服务器正在连接媒体流地址或正在探测音视频数据。
- `lts`：Number 型字段，该事件在业务服务器上发生的的 Unix 时间戳 (ms)。
- `xRequestId`：String 型字段，标识本次请求的 UUID（通用唯一识别码）。该值为本次请求 header 中 `X-Request-ID`。

****云端播放器销毁成功****

当一个云端播放器被销毁时，消息通知服务器会向你的服务器通知该事件。

> 销毁的原因请参考 `destroyReason` 字段。

`eventType` 为 `3(Player Destroyed)`，`payload` 示例如下：

```json
{
  "player": {
    "channelName": "class32",
    "id": "2a784467d647bb87b60b719f6fa56317",
    "name": "teacher101",
    "playTs": 1575508644
  },
  "lts": 1575508666666,
  "destroyReason": "Delete Request",
  "fields": "player.name,player.channelName,player.id"
}
```

- `player` 包含的字段：
  - `channelName`：String 型字段，Agora 频道名称。
  - `id`：String 型字段，云端播放器的 ID。它是 Agora 服务器生成的一个 UUID（通用唯一识别码），标识已创建的一个云端播放器。
  - `name`：String 型字段，云端播放器的名字。
  - `playTs`：Number 型字段，云端播放器开始播放在线媒体流时的 Unix 时间戳（秒）。
- `lts`：Number 型字段，该事件在业务服务器上发生的的 Unix 时间戳 (ms)。
- `destroyReason`：String 型字段，描述该云端播放器销毁的原因：
  - `Delete Request`：业务服务器收到你的 `Delete` 请求。
  - `Internal Error`：Agora 频道相关的错误。常见错误为 Token 无效或 Token 超时。
  - `Idle Timeout`：在你设置的 `idleTimeout` 时间内，业务服务器无法连接你指定的媒体流地址或该媒体流无法播放。
- `fields`： JSON 编码方式的字段掩码，详见[谷歌 protobuf FieldMask 文档](https://googleapis.dev/nodejs/pubsub/latest/google.protobuf.html#.FieldMask)。用于指定返回 `player` 字段的子集。在此示例中表示 Agora 服务器返回 `player` 字段中的 `name`、`channelName` 和 `id` 字段子集。

****云端播放器运行状态改变****

成功创建一个云端播放器后，当云端播放器运行状态改变时，消息通知服务器会向你的服务器通知该事件。

`eventType` 为 `4(Player Status Changed)`，`payload` 示例如下：

```json
{
  "player": {
    "channelName": "class32",
    "id": "2a784467d647bb87b60b719f6fa56317",
    "name": "teacher101",
    "status": "running"
  },
  "lts": 1575508645000,
  "fields": "player.name,player.channelName,player.id,player.status"
}
```

- `player` 包含的字段：
  - `channelName`：String 型字段，Agora 频道名称。
  - `id`：String 型字段，云端播放器的 ID。它是 Agora 服务器生成的一个 UUID（通用唯一识别码），标识已创建的一个云端播放器。
  - `name`：String 型字段，云端播放器的名字。
  - `status`：String 字段，云端播放器的状态：
    - `"connecting"`：业务服务器正在连接媒体流地址或正在探测音视频数据。该状态报告运行中的云端播放器出现问题后与业务服务器重新开始连接。
    - `"running"`：云端播放器正常运行，正在 Agora 频道内播放媒体流。
    - `"failed"`：业务服务器无法连接媒体流地址或该媒体流无法播放，该状态报告运行中的云端播放器出现问题。
- `lts`：Number 型字段，该事件在业务服务器上发生的的 Unix 时间戳 (ms)。
- `fields`：JSON 编码方式的字段掩码，详见[谷歌 protobuf FieldMask 文档](https://googleapis.dev/nodejs/pubsub/latest/google.protobuf.html#.FieldMask)。用于指定返回 `player` 字段的子集。在此示例中表示 Agora 服务器返回 `player` 字段中的 `name`、`channelName` 、 `id` 和 `status` 字段子集。