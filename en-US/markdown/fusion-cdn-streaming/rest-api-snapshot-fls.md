## Set the snapshot capturing configuration

Set the snapshot capturing options of the stream under the specified entry point.

### HTTP request

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/settings/snapshot/regions/{region}
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |
| `region` | String | Required. 添加推流域名时设置的区域。 |

#### Request body

The request body is in the JSON Object type, and contains the following fields:

| Field | Type | Description |
|:------|:------|:------|
| `enabled` | Bool | Required. Whether to enable the snapshot capturing function:<li>`true`: Enable snapshot capturing.</li><li>`false`: Disable snapshot capturing.</li> |
| `snapshotInterval` | Integer | Optional. The interval between snapshot capturings, in seconds. The default value is 10, and the value range is [5,300]. |
| `storageConfig` | JSON Object | Optional. For the storage configuration of the snapshot files, see [StorageConfig](#storageconfig). |
| `enableModeration` | Bool | Optional. Whether to enable content moderation:<li>`true`: Enable content moderation.</li><li>`false`: (default) Disable content moderation.</li> |

### HTTP response

If the returned HTTP status code is 200, the request is successful.

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code]( #http-code) for possible reasons.

### Example

**Request line**

```http
PATCH https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/settings/snapshot/regions/cn HTTP/1.1
```

**Request body**

```json
{
    "enabled": true,
    "enableModeration": true,
    "snapshotInterval": 30,
    "storageConfig": {
        "accessKey": "{your access key}",
        "bucket": "{your bucket}",
        "region": 3,
        "secretKey": "{your secret key}",
        "vendor": 2
    }
}
```

**Response line**

```http
HTTP/1.1 200 OK
```

## Get the snapshot capturing configuration

Get the snapshot capturing configuration of the specified entry point.

### HTTP request

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/settings/snapshot/regions/{region}
```

#### Path parameter

| Parameter | Type | Description |
|:------|:------|:------|
| `appid` | String | Required. The App ID corresponding to the entry point. |
| `entry_point` | String | Required. The entry point name. |
| `region` | String | Required. 添加推流域名时设置的区域。 |

### HTTP response

If the returned HTTP status code is 200, the request is successful, and the response body contains the following fields:

| Field | Type | Description |
|:------|:------|:------|
| `enabled` | Bool | Whether the snapshot capturing function is enabled:<li>`true`: Snapshot capturing is enabled.</li><li>`false`: Snapshot capturing is disabled.</li> |
| `snapshotInterval` | Integer | The interval between snapshot capturings, in seconds. The default value is 10, and the value range is [5,300]. |
| `storageConfig` | JSON Object | For the storage configuration of the snapshot files, see [StorageConfig](#storageconfig). |
| `enableModeration` | Bool | Whether content moderation is enabled:<li>`true`: Content moderation is enabled.</li><li>`false`: Content moderation is not enabled.</li> |

If the returned HTTP status code is not 200, the request fails. You can refer to the [HTTP status code]( #http-code) for possible reasons.

### Example

**Request line**

```http
GET https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/settings/snapshot/regions/cn HTTP/1.1
```

**Response line**

```http
HTTP/1.1 200 OK
```

**Request body**

```json
{
  "enabled": true,
  "enableModeration": true,
    "snapshotInterval": 30,
    "storageConfig": {
        "accessKey": "test acces key",
        "region": 3,
        "secretKey": "test secret key",
        "vendor": 2
    }
}
```

## Parameter type

### StorageConfig

The configuration of the snapshot files contains the following fields:

- `vendor`: Integer type, the third-party cloud storage platform.
   - `0`: [Qiniu Cloud]( https://www.qiniu.com/products/kodo)
   - `1`: [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1)
   - `2`: [Aliyun]( https://www.aliyun.com/product/oss)
   - `3`: [Tencent Cloud]( https://cloud.tencent.com/product/cos)
   - `4`: [Kingsoft Cloud]( https://www.ksyun.com/post/product/KS3.html)
   - `5`: [Microsoft Azure](https://azure.microsoft.com/zh-cn/)
- `region`: Integer type, the region information specified by the third-party cloud storage. In order to ensure the success rate and the real-time performance of the recording file upload, if you set the `region` of the stream-pushing domain name, you need to ensure that the `region` of the third-party cloud storage and the `region` of the stream-pushing domain name are in the same region. For example: the `region` of the stream-pushing domain name is set as `CN` (China), and the region of the third-party cloud storage needs to be set as a region within `CN`.
   - When `vendor` = 0, the third-party cloud storage is Qiniu Cloud, and:
      - `0`: East China
      - `1`: North China
      - `2`: South China
      - `3`: North America
      - `4`: Southeast Asia
   - When `vendor` = 1, the third-party cloud storage is Amazon S3, and:
      - `0`：US_EAST_1
      - `1`：US_EAST_2
      - `2`：US_WEST_1
      - `3`：US_WEST_2
      - `4`：EU_WEST_1
      - `5`：EU_WEST_2
      - `6`：EU_WEST_3
      - `7`：EU_CENTRAL_1
      - `8`：AP_SOUTHEAST_1
      - `9`：AP_SOUTHEAST_2
      - `10`：AP_NORTHEAST_1
      - `11`：AP_NORTHEAST_2
      - `12`：SA_EAST_1
      - `13`：CA_CENTRAL_1
      - `14`：AP_SOUTH_1
      - `15`：CN_NORTH_1
      - `16`：CN_NORTHWEST_1
      - `17`：US_GOV_WEST_1
      - `20`：AP_NORTHEAST_3
      - `21`：EU_NORTH_1
      - `22`：ME_SOUTH_1
      - `23`：US_GOV_EAST_1
   - When `vendor` = 2, the third-party cloud storage is Aliyun, and:
      - `0`：CN_Hangzhou
      - `1`：CN_Shanghai
      - `2`：CN_Qingdao
      - `3`：CN_Beijing
      - `4`：CN_Zhangjiakou
      - `5`：CN_Huhehaote
      - `6`：CN_Shenzhen
      - `7`：CN_Hongkong
      - ``8：US_West_1
      - `9`：US_East_1
      - `10`：AP_Southeast_1
      - `11`：AP_Southeast_2
      - `12`：AP_Southeast_3
      - `13`：AP_Southeast_5
      - `14`：AP_Northeast_1
      - `15`：AP_South_1
      - `16`：EU_Central_1
      - `17`：EU_West_1
      - `18`：EU_East_1
   - When `vendor` = 3, the third-party cloud storage is Tencent Cloud, and:
      - `0`：AP_Beijing_1
      - `1`：AP_Beijing
      - `2`：AP_Shanghai
      - `3`：AP_Guangzhou
      - `4`：AP_Chengdu
      - `5`：AP_Chongqing
      - `6`：AP_Shenzhen_FSI
      - `7`：AP_Shanghai_FSI
      - `8`：AP_Beijing_FSI
      - `9`：AP_Hongkong
      - `10`：AP_Singapore
      - `11`：AP_Mumbai
      - `12`：AP_Seoul
      - `13`：AP_Bangkok
      - `14`：AP_Tokyo
      - `15`：NA_Siliconvalley
      - `16`：NA_Ashburn
      - `17`：NA_Toronto
      - `18`：EU_Frankfurt
      - `19`：EU_Moscow
   - When `vendor` = 4, the third-party cloud storage is Kingsoft Cloud, and:
      - `0`：CN_Hangzhou
      - `1`：CN_Shanghai
      - `2`：CN_Qingdao
      - `3`：CN_Beijing
      - `4`：CN_Guangzhou
      - `5`：CN_Hongkong
      - `6`：JR_Beijing
      - `7`：JR_Shanghai
      - `8`：NA_Russia_1
      - `9`：NA_Singapore_1
   - When `vendor` = 5, the third-party cloud storage is Microsoft Azure: There is no need to set the `region` parameter, and even if the region is set, it does not take effect.
- `bucket`: String type, the bucket of the third-party cloud storage. The bucket name must conform to the naming rules of the corresponding third-party cloud storage service.
- `accessKey`: String type, the access key of the third-party cloud storage. In general, Agora recommends that you offer an access key with write-only permissions. If latency transcoding is required, the access key must have both read and write permissions.
- `accessKey`: String type, the secret key of the third-party cloud storage.

<a name="http-code"></a>
## HTTP status code

| Status code | Description |
| :----- | :----------------------------------------------------------- |
| 200 | The request succeeds. |
| 400 | The parameter is illegal, for example the `appid` or the `entry_point` is empty, or the `region` parameter value is illegal. |
| 401 | Unauthorized (the customer ID and the customer secret do not match). |
| 404 | The server cannot find the resource according to the request, which means the requested entry point does not exist or the requested URI path is illegal. |
| 500 | There is an internal error in the server, so the server is not able to complete the request. |
| 504 | There is an internal error in the server. The gateway or the proxy server did not receive a timely request from the remote server. |
