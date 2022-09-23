# RESTful API 参考

本页面介绍控制台 License RESTful API 的详细信息。



## 基本信息

本节介绍所有 Agora 控制台 License RESTful API 的基本信息。

### 域名

所有请求都发送给域名：`api.agora.io`。

### 认证方式

Agora 控制台 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要使用 Agora 提供的客户 ID 和客户密钥生成一个 Base64 算法编码的凭证，并填入 HTTP 请求头部的 `Authorization` 字段中。详见 [如何在 RESTful API 中进行 HTTP 基本认证和 Token 认证](https://docs.agora.io/cn/Video/faq/restful_authentication)。

### 调用频率限制

对于每个 Agora 账号（非每个 App ID），本页每个 API 的调用频率上限为每秒 10 次。如果调用频率超出限制，参考 [如何处理服务端 RESTful API 调用超出频率限制](https://docs.agora.io/cn/Video/faq/restful_api_call_frequency) 优化调用频率。



## 激活

激活 License。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v2/active`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`pid`| String | 由 SKU、有效期、品类定义的 License 标识。 |
|`licenseKey`| String | 账号 ID 或设备 ID。 |
|`appid`| String | 声网分配给每个项目的唯一标识。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v2/active?pid=02F5xxxxxxxxxxxxxxxxxxxxxxxxEC30&licenseKey=111&appid=a6d6xxxxxxxxxxxxxxxxxxxxxxxxf75e
```

### 响应参数

如果状态码为 `200`，则请求成功，响应包体中包含如下参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`pid`| String | 由 SKU、有效期、品类定义的 License 标识。 |
|`license`| String | 激活的 License 的值。 |
|`licenseKey`| String | 账号 ID 或设备 ID。 |
|`activationTime`| Number | License 激活的 Unix 时间戳，单位为秒。 |
|`expireTime`| Number | License 到期的 Unix 时间戳，单位为秒。 |
|`skuView`| Array | SKU 能力集：<ul><li>`product` (Integer): <ul><li>`1`: RTC</li><li>`2`: RTSA</li><li>`3`: FPA</li></ul></li></ul><ul><li>`name` (String): SKU 的名称</li></ul><ul><li>`mediaType` (Integer):<ul><li>`1`: 音频</li><li>`2`: 视频</li><li>`3`: 音视频</li></ul></li></ul><ul><li>`minutes` (Integer): License 分钟数上限</li></ul><ul><li>`period` (String): License 使用时间段</li></ul> |

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "data": {
        "pid": "02F51997A07B46C5810020A0F163EC30",
        "license": "1D65xxxxxxxxxxxxxxxxxxxxxxxx6016",
        "licenseKey": "111",
        "activationTime": 1663743436, // 时间戳，单位s
        "expireTime": 1695279436, // 到期时间戳，单位s
        "skuView": {
            "product": 1,
            "name": "演示申请01",
            "mediaType": 1,
            "minutes": 100,
            "period": "00:00~23:59"
            }
    }
}
```


## 查询

查询指定 License 的信息，或指定账号或设备绑定的 License 信息。

### 接口原型

- 方法：`GET`
- 接入点：`https://api.agora.io/dabiz/license/v2/detail`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`appid`| String | 声网分配给每个项目的唯一标识。 |
|`key`| String | 传入需要查询的 `license` 或 `licenseKey`。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v2/detail?appid=02F5xxxxxxxxxxxxxxxxxxxxxxxxEC30&key=111
```

### 响应参数

如果状态码为 `200`，则请求成功。

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`pid`| String | 由 SKU、有效期、品类定义的 License 标识。 |
|`license`| String | 查询的 License 的值。 |
|`licenseKey`| String | 账号 ID 或设备 ID。 |
|`expireTime`| Number | License 到期的 Unix 时间戳，单位为秒。 |
|`activationTime`| Number | License 激活的 Unix 时间戳，单位为秒。 |
|`skuView`| Array | SKU 能力集：<ul><li>`product` (Integer): <ul><li>`1`: RTC</li><li>`2`: RTSA</li><li>`3`: FPA</li></ul></li></ul><ul><li>`name` (String): SKU 的名称</li></ul><ul><li>`mediaType` (Integer):<ul><li>`1`: 音频</li><li>`2`: 视频</li><li>`3`: 音视频</li></ul></li></ul><ul><li>`minutes` (Integer): License 分钟数上限</li></ul><ul><li>`period` (String): License 使用时间段</li></ul> |

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "data": {
        "pid": "02F51997A07B46C5810020A0F163EC30",
        "license": "1D65xxxxxxxxxxxxxxxxxxxxxxxx6016",
        "licenseKey": "testc3",
        "expireTime": 1668154090,
        "activationTime": 1660205290,
        "skuView": {
            "product": 1,
            "name": "test2",
            "mediaType": 3,
            "minutes": 100,
            "period": "00:00~07:59"
        }
    }
}
```



## 配额

将指定数量的 License 分配给指定项目。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v2/allocate`

### 请求参数

#### 请求头部

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`Content-Type`| String | 设为 `application/json`。 |

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`appid`| String | 声网分配给每个项目的唯一标识。 |

#### 请求包体参数

在请求包体中传入以下参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`pid`| String | 由 SKU、有效期、品类定义的 License 标识。 |
|`count`| Integer | License 的数量。 |
|`creator`| String | 执行配额操作的用户名。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v2/allocate?appid=a6d6xxxxxxxxxxxxxxxxxxxxxxxxf75e
```

#### 请求包体

```json
{
    "pid": "02F5xxxxxxxxxxxxxxxxxxxxxxxxEC30",
    "count": 5,
    "creator": "xxxxxxx"
}
```

### 响应参数

如果状态码为 `200`，则请求成功。

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "message": "license配额成功"
}
```



## 查询配额

查询指定 License 分配给指定项目的详情。

### 接口原型
- 方法：`GET`
- 接入点：`https://api.agora.io/dabiz/license/v2/product/allocations`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`page`| Integer | 查询页码。 |
|`size`| Integer | 分页大小。 |
|`pid`| String | 由 SKU、有效期、品类定义的 License 标识。 |
|`appid`| String | 声网分配给每个项目的唯一标识。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v2/product/allocations?page=1&size=2&pid=02F5xxxxxxxxxxxxxxxxxxxxxxxxEC30&appid=a6d6xxxxxxxxxxxxxxxxxxxxxxxxf75e
```

### 响应参数

如果状态码为 `200`，则请求成功，响应包体中包含如下参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`count`| Integer | 配额次数。 |
|`list`| Array | 配额详情列表：<ul><li>`pid` (String): 	由 SKU、有效期、品类定义的 License 标识。</li></ul><ul><li>`type` (Integer): <ul><li>`1`: 正式<li>`2`: 测试</li></li></ul><li>`creator` (String): 执行配额操作的用户名。</li><li>`count` (Integer): License 的数量。</li><li>`createTime` (String): 执行配额操作的时间。</li> |

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "data": {
        "count": 2,
        "list": [
            {
                "pid": "02F5xxxxxxxxxxxxxxxxxxxxxxxxEC30",
                "type": 1,
                "creator": "xxxxxxx",
                "count": 5,
                "createTime": "2022-07-22 09:10:12"
            },
            {
                "pid": "02F5xxxxxxxxxxxxxxxxxxxxxxxxEC30",
                "type": 1,
                "creator": "xxxxxxx",
                "count": 5,
                "createTime": "2022-07-21 09:02:26"
            }
        ]
    }
}
```



## 续期

激活 License 的续期额度。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v2/renew`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`appid`| String | 声网分配给每个项目的唯一标识。 |
|`renewId`| String | 对某个 PID 进行续期操作后生成的 renewId，renewId 继承 PID 除有效期以外的全部属性。续期申请通过后，由销售提供。 |
|`license`| String | 续期的 License。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v2/renew?renewId=4750xxxxxxxxxxxxxxxxxxxxxxxx6270&license=85B3xxxxxxxxxxxxxxxxxxxxxxxx656F&appid=a6d6xxxxxxxxxxxxxxxxxxxxxxxxf75e
```

### 响应参数

如果状态码为 `200`，则请求成功。

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "message": "license续期成功"
}
```


## 响应状态码

License 服务采用统一报文返回，对超时、网络等导致的请求失败的状态码不做额外包装。

下表列出了可能出现的响应状态码。

- 如果状态码为 `200`，表示请求成功，服务正常处理。
- 如果状态码不为 `200`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

| 响应状态码 | 描述 |
|:----|:----|
| 200 | 请求成功，对应处理 `data` 字段的内容。 |
| 400 | 用户输入异常，可根据 `message` 字段的错误信息进行排查。 |
| 500 | 服务内部处理异常，可读取 `message` 字段获取错误信息。 |