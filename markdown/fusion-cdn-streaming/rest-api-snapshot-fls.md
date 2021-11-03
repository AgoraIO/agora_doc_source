## 设置截图配置

设置指定发布点下的直播流的截图选项。

### HTTP 请求

```http
PATCH https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/settings/snapshot/regions/{region}
```

#### 路径参数

|参数|类型|描述|
|:------|:------|:------|
|`appid`|String|必填。发布点对应的 App ID。|
|`entry_point`|String|必填。发布点名称。 |
|`region`|String|必填。添加推流域名时设置的区域。|

#### 请求包体

请求包体为 JSON Object 类型，包含以下字段：

|字段|类型|描述|
|:------|:------|:------|
|`enabled`|Bool|必填。是否启用截图功能：<li>`true`：启用截图。</li><li>`false`：关闭截图。</li>|
|`snapshotInterval`|Integer|选填。截图的间隔，单位为秒，默认值为 10，取值范围为 [5,300]。|
|`storageConfig`|JSON Object|选填。截图文件的存储配置，详见 [StorageConfig](#storageconfig)。|
|`enableModeration`|Bool|选填。是否开启内容审核：<li>`true`: 开启内容审核。</li><li>`false`: （默认）不开启内容审核。</li>|

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
PATCH https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/settings/snapshot/regions/cn HTTP/1.1
```

**请求 body**

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

**响应行**

```http
HTTP/1.1 200 OK
```

## 获取截图配置

获取指定发布点的截图配置。

### HTTP 请求

```http
GET https://api.agora.io/v1/projects/{appid}/fls/entry_points/{entry_point}/settings/snapshot/regions/{region}
```

#### 路径参数

|参数|类型|描述|
|:------|:------|:------|
|`appid`|String|必填。发布点对应的 App ID。|
|`entry_point`|String|必填。发布点名称。 |
|`region`|String|必填。添加推流域名时设置的区域。|

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

|字段|类型|描述|
|:------|:------|:------|
|`enabled`|Bool|是否启用了截图功能：<li>`true`：已启用截图。</li><li>`false`：未启用截图。</li>|
|`snapshotInterval`|Integer|截图的间隔，单位为秒，取值范围为 [5,300]。|
|`storageConfig`|JSON Object|截图文件的存储配置，详见 [StorageConfig](#storageconfig)。|
|`enableModeration`|Bool|是否已开启内容审核：<li>`true`: 已开启内容审核。</li><li>`false`: 未开启内容审核。</li>|

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [HTTP 状态码](#http-code)了解可能的原因。

### 示例

**请求行**

```http
GET https://api.agora.io/v1/projects/{your_appid}/fls/entry_points/live/settings/snapshot/regions/cn HTTP/1.1
```

**响应行**

```http
HTTP/1.1 200 OK
```

**响应 body**

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

## 参数类型

### StorageConfig

截图文件的存储设置，包含以下字段：

- `vendor`：Integer 类型，第三方云存储平台。
  - `0`：[七牛云](https://www.qiniu.com/products/kodo)
  - `1`：[Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1)
  - `2`：[阿里云](https://www.aliyun.com/product/oss)
  - `3`：[腾讯云](https://cloud.tencent.com/product/cos)
  - `4`：[金山云](https://www.ksyun.com/post/product/KS3.html)
  - `5`：[Microsoft Azure](https://azure.microsoft.com/zh-cn/)
- `region`：Integer 类型，第三方云存储指定的地区信息。为了确保录制文件上传的成功率和实时性，如果你设置了推流域名的 `region`，则需要保证第三方云存储的 `region` 与推流域名的 `region` 在同一个地域中。例如：推流域名的 `region` 设置为 `CN`（中国区），第三方云存储需要设置为 `CN` 内的区域。
  - 当  `vendor` = 0，即第三方云存储为七牛云时：
    - `0`：华东
    - `1`：华北
    - `2`：华南
    - `3`：北美
    - `4`：东南亚
  - 当 `vendor` = 1，即第三方云存储为 Amazon S3 时：
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
  - 当  `vendor`  = 2，即第三方云存储为阿里云时：
    - `0`：CN_Hangzhou
    - `1`：CN_Shanghai
    - `2`：CN_Qingdao
    - `3`：CN_Beijing
    - `4`：CN_Zhangjiakou
    - `5`：CN_Huhehaote
    - `6`：CN_Shenzhen
    - `7`：CN_Hongkong
    - `8`：US_West_1
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
  - 当 `vendor` = 3，即第三方云存储为腾讯云时：
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
  - 当 `vendor` = 4，即第三方云存储为金山云时：
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
  - 当 `vendor` = 5，即第三方云存储为 Microsoft Azure 时：无需设置 `region` 参数，即使设置也不生效。
- `bucket`：String 类型，第三方云存储的 bucket，bucket 名称需要符合对应第三方云存储服务的命名规则。
- `accessKey`：String 类型，第三方云存储的 access key。在一般情况下，建议提供只写权限的访问密钥。如需延时转码，则访问密钥必须同时具备读写权限。
- `secretKey`：String 类型，第三方云存储的 secret key。

<a name="http-code"></a>
## HTTP 状态码

| 状态码 | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| 200    | 请求成功。                                                   |
| 400    | 参数非法，如 `appid` 或者 `entry_point` 为空，或者 `region` 参数值非法。 |
| 401    | 未经授权的（客户 ID/客户密钥匹配错误）。                     |
| 404    | 服务器无法根据请求找到资源，即请求的发布点不存在，或者请求的 URI 路径非法。 |
| 500    | 服务器内部错误，无法完成请求。                               |
| 504    | 服务器内部错误。充当网关或代理的服务器未从远端服务器获取请求。 |
