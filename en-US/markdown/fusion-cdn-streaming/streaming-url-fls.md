You need to follow the Agora rules to construct the live streaming and the URL of the stream playing. This page introduces the constructing rules of the live streaming.

## Understand the tech

As the URL might contain the authentication information, Agora recommends constructing the URL in your business server. The following diagram shows the process:

![process of constructing urls](https://web-cdn.agora.io/docs-files/1635838191301)



## Construct the URL of the stream pushing

The URL of the stream pushing includes four parts as shown in the following URL example:

![example url of stream pushing](https://web-cdn.agora.io/docs-files/1635229049639)

Description of each part:

| URL segment | Necessary or not | Description |
| :--------- | :------- | :----------------------------------------------------------- |
| Domain name | Yes | The domain name of the stream pushing. The domain name must be recorded at China's Ministry of Industry and Information Technology, and have successful CNAME configuration.   |
| The entry point | Yes | The default entry point is live, and each entry point has its own live streaming configuration. |
| Stream name | Yes | The name of the live streaming. It identifies one live streaming, so please ensure each live streaming has its unique name. |
| Authentication string | No | If the live streaming authentication is not set, the "?" and the content behind it are not required in the URL address. <br/>The authentication string consists the following parameters: <ul><li>`ts`: The Unix timestamp (s) when the URL expires. This value shows the time that the authentication string expires. For example, `ts=1635004800` means the authentication string is valid before October, 24th, 2021.</li><li>`sign`: The hotlink protection signature.</li></ul>For more details, see<a href="#key">Calculate the Authentication String.</a> |

## Construct the URL of the stream pushing

The constructing rules of the stream-playing URL are similar to those of the stream-pushing URL, but the URL paths of different stream-playing protocols vary slightly.

> The domain name in the URL must be the stream-playing domain name.

| Playback protocol | URL path | URL sample |
| :------- | :------------------------------------ | :----------------------------------------------------------- |
| RTMP | /{entry-point}/{stream} | rtmp(s)://domain/live/stream?ts=1635004800&sign=95b0a9970c593819 |
| HTTP-FLV | /{entry-point}/{stream}.flv | http(s)://domain/live/stream**.flv**?ts=1635004800&sign=337f185b6571cd42 |
| HLS | /{entry-point}/{stream}/playlist.m3u8 | http(s)://domain/live/stream/**playlist.m3u8**?ts=1635004800&sign=a1d2d3bcce31c9fe |


<a name="key"></a>

## Calculate the Authentication String

This section introduces how to generate URL authentication strings.

### Step 1: Provide the authentication secret

鉴权密钥用于在业务服务器生成签名，以及在使用 Agora 融合 CDN 直播服务时进行验证。

鉴权密钥为不超过 128 字节的字符串，你需要自行设置。 每个推流域名和播流域名都可以分别设置鉴权密钥，详见[直播流鉴权配置](https://docs.agora.io/cn/fusion-cdn-streaming/rest-api-%20authentication-fls?platform=RESTful)。

<div class="alert warning">不要在客户端使用鉴权密钥或者将其泄露给第三方，否则有被盗链风险。</div>

### 第二步：计算失效时间戳

推流/播流 URL 中的 `ts` 参数决定了该 URL 的有效时间。

假设当前时间 2021-10-23 10:00:00，转换为 Unix 时间戳为 1634954400。 如果我们期望 URL 的有效期为 10 分钟，即在 2021-10-23 10:10:00 前有效，转换为 Unix 时间戳为 1634955000，即 ts=1634955000。

URL 的有效期不宜设置太短或者太长，Agora 推荐设置在 5 到 10 分钟之内。

- 有效期太短，客户端断线重连后可能会推流/播流失败，需要重新生成防盗链鉴权字符串。
- 有效期设置太长会增加被盗链的风险。

### 第三步：计算防盗链签名

签名（sign）为鉴权密钥、推流/播流 URL 的路径、失效时间戳 ts 这三部分拼接后的字符串计算得到的 MD5 值。

例如，假设 URL 为 `http://domain/live/stream.flv`，鉴权密钥为 `z2tn3uiny0aasebz`，`ts` 为 `1634955000`，则 sign=MD5(z2tn3uiny0aasebz/live/stream.flv1634955000)=f7c1bd88e911b72c。

### Sample code

以下为用 Python3 代码计算鉴权字符串的示例：

```python
#!/usr/bin/env python3
import datetime
from urllib.parse import urlparse
 import (
key = 'test_key'
play_url_str = 'http://push.test.com/live/test.flv'
key_expire_time = 60*15
url = urlparse(play_url_str)
now = int(time.time()) + key_expire_time
sign = key + url.path + str(now)
md5 = hashlib.md5()
md5.update(sign.encode('utf-8'))
play_url_str += "?ts={}&sign={}".format(now, md5.hexdigest())
print(play_url_str)
```
