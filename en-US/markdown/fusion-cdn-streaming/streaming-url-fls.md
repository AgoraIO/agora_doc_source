You need to follow the Agora rules to construct the the URLs of streaming pushing and playing. This page introduces the constructing rules of the live streaming.

## Understand the tech

As the URL might contain the authentication information, Agora recommends constructing the URL in your business server. The following diagram shows the process:

![process of constructing urls](https://web-cdn.agora.io/docs-files/1636618037332)



## Construct the URL of stream pushing

The URL of stream pushing includes four parts as shown in the following example:

![example url of stream pushing](https://web-cdn.agora.io/docs-files/1636618075549)

Description of each part:

| URL segment | Necessary or not | Description |
| :--------- | :------- | :----------------------------------------------------------- |
| Domain name | Yes | The domain name of the stream pushing. It must be recorded at China's Ministry of Industry and Information Technology, and have successful CNAME configuration.   |
| The entry point | Yes | The default entry point is live, and each entry point has its own live streaming configuration. |
| Stream name | Yes | The name of the live streaming. One stream name identifies one live streaming, so please ensure each live streaming has its unique stream name. |
| Authentication string | No | If the live streaming authentication is not set, the "?" and the content behind it are not required in the URL address. <br/>The authentication string consists the following parameters: <ul><li>`ts`: The Unix timestamp (s) when the URL expires. This value shows the time that the authentication string expires. For example, `ts=1635004800` means the authentication string is valid before October 24th, 2021.</li><li>`sign`: The hotlink protection signature.</li></ul>For more details, see<a href="#key">Calculate the Authentication String</a>. |

## Construct the URL of the stream playing

The constructing rules of the stream-playing URL are similar to those of the stream-pushing URL, but the URL paths of different stream-playing protocols vary slightly.

> The domain name in the URL must be the stream-playing domain name.

| Playback protocol | URL path | URL sample |
| :------- | :------------------------------------ | :----------------------------------------------------------- |
| RTMP | /{entry-point}/{stream} | rtmp(s)://domain/live/stream?ts=1635004800&sign=95b0a9970c593819 |
| HTTP-FLV | /{entry-point}/{stream}.flv | http(s)://domain/live/stream**.flv**?ts=1635004800&sign=337f185b6571cd42 |
| HLS | /{entry-point}/{stream}/playlist.m3u8 | http(s)://domain/live/stream/**playlist.m3u8**?ts=1635004800&sign=a1d2d3bcce31c9fe |


<a name="key"></a>

## Calculate the authentication string

This section introduces how to generate the URL authentication strings.

### Step 1: Provide the authentication key for hotlink protection.

The authentication key is used to generate the signature in the business server, and to verify the signature during the Agora Fusion CDN Live Streaming.

The authentication key is a string of no more than 128 bytes, and you need to set it yourself. For setting the authentication key respectively for each stream-pushing and -playing domain name, see [Stream Authentication Configuration](/en/fusion-cdn-streaming/rest-api-authentication-fls?platform=RESTful).

<div class="alert warning">Do not use the authentication key on the client side or leak it to any third party, or your URLs might be hotlinked.</div>

### Step 2: Calculate the expiry timestamp

The `ts` parameter in the stream-pushing/playing URL decided the valid time of the URL.

If the current time is 2021-10-23 10:00:00, its Unix timestamp is 1634954400. If you expect the valid time to be 10 minutes, that is, being valid before 2021-10-23 10:10:00 , the Unix timestamp is 1634955000 (ts=1634955000).

The valid time of a URL must not be set too short or too long. Agora recommends setting it between 5 to 10 minutes.

- If the valid time is too short, the client side might fail in stream pushing/playing when it tries to reconnect to the server.
- If the valid time is too long, your hotlink might be in greater risk.

### Step 3: Calculate the hotlink protection signature

The signature (sign) is the MD5 value calculated by the constructed strings of the authentication key, the path of the stream pushing/playing URL and the expiry timestamp (ts).

For example, if the URL is `http://domain/live/stream.flv`, the authentication key is `z2tn3uiny0aasebz` and `ts` is `1634955000`, the sign = MD5(z2tn3uiny0aasebz/live/stream.flv1634955000)=f7c1bd88e911b72c.

### Sample code

The following sample shows how to calculate the authentication string by using Python 3:

```python
#!/usr/bin/python3
import time
from urllib.parse import urlparse
import hashlib
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
