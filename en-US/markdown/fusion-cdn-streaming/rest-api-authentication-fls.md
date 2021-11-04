The authentication function is in the beta stage. Contact sales@agora.io before using it.

## Set authentication secrets

Set the authentication secret of the specified domain name.

### HTTP request

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/domains/{domain}
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. App ID corresponding to the domain name being set. |
| `domain` | String | Required. The domain name. |

#### Request body

The request body is in the JSON Object type, and contains the following fields:

`authKey`: String type, required, no more than 128 characters. The authentication secret.

### HTTP response

If the returned HTTP status code is 200, the request is successful.

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code](#http-code) for possible reasons.

### Example

**Request line**

```http
PATCH https://api.agora.io/v1/projects/{your_appid}/fls/domains/{your_domain} HTTP/1.1
```

**Request body**

```json
{
    "authKey": "{your auth key}"
}
```

**Response line**

```http
HTTP/1.1 200 OK
```

<a name="http-code"></a>
## HTTP status code

| Status code | Description |
| :----- | :----------------------------------------------------------- |
| 200 | The request succeeds. |
| 400 | The parameter is invalid, for example the `appid` or the `domain` is empty. |
| 401 | Unauthorized (the customer ID and the customer secret do not match). |
| 404 | The server cannot find the resource according to the request, which means the requested domain name does not exist or the requested URI path is invalid. |
| 500 | An internal error occurs in the server, so the server is not able to complete the request. |
| 504 | An internal error occurs in the server. The gateway or the proxy server did not receive a timely request from the remote server. |
