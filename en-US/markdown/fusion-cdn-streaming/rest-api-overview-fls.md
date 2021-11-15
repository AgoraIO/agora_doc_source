Agora FLS contains the RESTful API, which enables you to send your HTTP requests from your server to the Agora server and configure and manage the live streaming at your server.

This page is a basic introduction to the FLS RESTful API.

## Functions

The FLS RESTful API can perform the following functions:

### Domain name and entry-point management

- There are two types of domain names: stream-pushing domain names and stream-playing domain names (which mainly affect regional access and the deployment of the streams). The same live stream can be pushed or played through multiple different domain names.
- Entry points are used to categorize the streams. You can configure functions such as recording, transcoding, and snapshot capturing for one entry point, and these configurations apply to all the streams under this entry point.

### Stream recording

You can record the streams of the specified entry points, and set the recorded file types and the third-party cloud storage service providers.

### Stream processing

- snapshot and content moderation: You can turn the snapshot and content moderation functions on or off for the streams at the specified entry point. You can set the snapshot interval and upload the snapshots to a third-party cloud storage service provider.
- Transcoding: You can transcode the streams of the specified entry point and modify the audio and video encoder configuration. You can use the default settings or customize the transcoding configuration.

### Stream management

You can ban or unban the stream and query the stream-pushing information.

### Stream pushing/playing authentication

You can set the authentication secret key for the stream pushing and playing at the specified domain name.

## Implementation

Call the FLS RESTful API, and perform the following steps:

1. Add the stream-pushing domain name and the stream-playing domain name.
2. (Optional) Add the entry point.
   This step is optional. Agora provides a default entry point that you can use directly.
3. Configure the functions of the stream, query the stream information, and manage the stream
    for the entry point.

## Request structure

### Authentication

The FLS RESTful API uses HTTP HMAC (Hash-based Message Authentication Code) authentication.

When you send an HTTP request, you need to generate a signature using the HMAC-SHA256 algorithm and pass this signature and its related information to the `authorization` field.

You need the following Agora account information for generating the authentication field:

- For the App ID of the Agora project, please refer to [Get the App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).
- For the customer ID and secret provided in the RESTful API of the Agora Console, please refer to [Generate a set of Customer ID and Secret]( https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).

The following Python code (Python 3.7+) takes the API that obtains the list of domain names as an example to demonstrate how to generate the value of the `authorization` field:

```python
import hmac
import base64
import datetime
from hashlib import sha256

# The App ID of your Agora project
appid = ''
# Get customer ID in the RESTful API of the Agora Console
customer_username = ''
# Get customer secret in the RESTful API of the Agora Console
customer_secret = ''

# request host
host = "api.agora.io"
# requests and endpoint
req_metd = 'GET'
path = f'/v1/projects/{appid}/fls/domains'

body_sha256 = sha256(data.encode('utf-8')).digest()
body_sha256_base64 = base64.b64encode(body_sha256)
date = datetime.datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')
request_line = "{} {} {}".format(req_metd, path, "HTTP/1.1")
digest = "SHA-256={}".format(body_sha256_base64.decode("utf-8"))
signing_string = "host: {}\ndate: {}\n{}\ndigest: {}".format(host, date, request_line, digest)
signature = base64.b64encode(
    hmac.new(customer_secret.encode("utf-8"), signing_string.encode("utf-8"), sha256).digest())
authorization = 'hmac username="{}", algorithm="hmac-sha256", headers="host date request-line digest", signature="{}"'.format(
    customer_username, signature.decode("utf-8"))
```

### Server address

All requests are sent to the following host: `api.agora.io`.

### Protocol

To ensure communication security, the FLS RESTful API only supports the HTTPS protocol.

### Data format

- Request: Refer to the example in the specific API for the request format.
- Response: The format of the response content is JSON.

> All request URLs and request body content are case sensitive.

## API limit

The call frequency limit of the FLS RESTful API is 50 times per second. If the call frequency exceeds the limit, refer to [How can I avoid being frequency limited when calling Agora Server RESTful APIs?](https://docs.agora.io/en/Agora%20Platform/faq/restful_api_call_frequency).