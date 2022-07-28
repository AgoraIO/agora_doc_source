# RESTful API 参考

本页面介绍 Agora 控制台 License RESTful API 的详细信息。



## 基本信息

本节介绍所有 Agora 控制台 License RESTful API 的基本信息。

### 域名

所有请求都发送给域名：`api.agora.io`。

### 数据格式

所有 HTTP 请求头部的 `Content-Type` 类型为 `application/json`。所有请求和响应内容的格式均为 JSON。所有的请求 URL 和请求包体内容都区分大小写。

### 认证方式

Agora 控制台 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要使用 Agora 提供的客户 ID 和客户密钥生成一个 Base64 算法编码的凭证，并填入 HTTP 请求头部的 `Authorization` 字段中。详见 [如何在 RESTful API 中进行 HTTP 基本认证和 Token 认证](https://docs.agora.io/cn/Video/faq/restful_authentication)。

### 调用频率限制

对于每个 Agora 账号（非每个 App ID），本页每个 API 的调用频率上限为每秒 10 次。如果调用频率超出限制，参考 [如何处理服务端 RESTful API 调用超出频率限制](https://docs.agora.io/cn/Video/faq/restful_api_call_frequency) 优化调用频率。



## 激活

激活控制台 License。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v2/active`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`pid`| String | 由 SKU、有效期、品类定义的 License 标识。 |
|`licenseKey`| String | 激活并关联 License 的账号 ID 或设备 ID。 |
|`appid`| String | 声网分配给每个项目的唯一标识。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v2/active?pid=02F51997A07B46C5810020A0F163EC30&licenseKey=123456&appid=a6d6dba434be4b6683fad1aba6a7f75e
```

### 响应参数

如果状态码为 `200`，则请求成功，响应包体中包含如下参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`license`| String | 被激活的 License 的值。 |
|`skuView`| Array | SKU 能力集：<li><code>product</code> (Integer): <ul><li><code>1</code>: RTC</li><li><code>2</code>: RTSA</li><li><code>3</code>: FPA</li></ul></li><li><code>name</code> (String): SKU 的名称</li><li><code>mediaType</code> (Integer):<ul><li><code>1</code>: 音频</li><li><code>2</code>: 视频</li><li><code>3</code>: 音视频</li></ul></li><li><code>minutes</code> (integer): License 分钟数上限</li><li><code>period</code> (String): License 使用时间段</li> |

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "data": {
        "license": "A9423D665DF145D990628CFDB491FD43",
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


## 续期

激活控制台 License 的续期额度。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v1/renew`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`appid`| String | 声网分配给每个项目的唯一标识。 |
|`renewId`| String | 对某个 PID 进行续期操作后生成的 renewId，renewId 继承 PID 除有效期以外的全部属性。续期申请通过后，由销售提供。 |
|`license`| String | 被激活的 License 的值。续期申请通过后，由销售提供。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v1/renew?renewId=47503548C5E947F288A24B1EB5576270&license=85B38F2B02A5418792FC78B17466656F&appid=a6d6dba434be4b6683fad1aba6a7f75e
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


## 配额

将指定数量的控制台 License 分配给指定项目。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v1/allocate`

### 请求参数

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
https://api.agora.io/dabiz/license/v1/allocate?appid=a6d6dba434be4b6683fad1aba6a7f75e
```

#### 请求包体

```json
{
    "pid": "02F51997A07B46C5810020A0F163EC30",
    "count": 5,
    "creator": "wangwei"
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
- 接入点：`https://api.agora.io/dabiz/license/v1/product/allocations`

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
https://api.agora.io/dabiz/license/v1/product/allocations?page=1&size=2&pid=02F51997A07B46C5810020A0F163EC30&appid=a6d6dba434be4b6683fad1aba6a7f75e
```

### 响应参数

如果状态码为 `200`，则请求成功，响应包体中包含如下参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`count`| Integer | 配额次数。 |
|`list`| Array | 配额详情列表：<li>`pid` (String): 分配额度的 License。</li><li>`type` (Integer): <ul><li>`1`: 正式<li>`2`: 测试</li></ul></li><li>`vid` (String): 被分配 License 额度的项目。VID 为声网分配给每个项目的内部唯一标识，与 App ID 为映射关系。// TODO: 控制台上展现 VID，用户如何得知对应的是哪个 App ID？</li><li>`creator` (String): 执行配额操作的用户名。</li><li>`count` (Integer): 分配的 License 数量。</li><li>`createTime` (String): 执行配额操作的时间。</li> |

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
                "pid": "02F51997A07B46C5810020A0F163EC30",
                "type": 1,
                "vid": 975823,
                "creator": "wangwei",
                "count": 5,
                "createTime": "2022-07-22 09:10:12"
            },
            {
                "pid": "02F51997A07B46C5810020A0F163EC30",
                "type": 1,
                "vid": 975823,
                "creator": "wangwei",
                "count": 5,
                "createTime": "2022-07-21 09:02:26"
            }
        ]
    }
}
```



## 开启预授权

开启预授权功能。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v1/vendor/pad/switch`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`appid`| String | 声网分配给每个项目的唯一标识。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v1/vendor/pad/switch?appid=a6d6dba434be4b6683fad1aba6a7f75e
```

### 响应参数

如果状态码为 `200`，则请求成功。

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "message": "配置成功！"
}
```


## 增加单个预授权

```http
POST https://api.agora.io/dabiz/license/v1/pad/add?licenseKey={licensekey}&appid={appid}
```

```json
{
    "code": 200,
    "message": "增加单个预授权成功"
}
```

## 批量上传预授权


```http
POST https://api.agora.io/dabiz/license/v1/pad/upload?appid={appId}
```

body 选 form-data
key 选 file，value 上传文件

```json
{
    "code": 200,
    "message": "预授权文件上传成功"
}
```


## 删除预授权

```http
POST https://api.agora.io/dabiz/license/v1/pad/delete?appid={appid}
```

body

```json
{
    "code": 200,
    "message": "删除预授权成功"
}
```


## 清空预授权

清空预授权设置。

### 接口原型
- 方法：`POST`
- 接入点：`https://api.agora.io/dabiz/license/v1/pad/clear`

### 请求参数

#### 查询参数

在请求路径中传入以下查询参数：

| 参数 | 类型 | 描述 |
|:---|:---|:---|
|`appid`| String | 声网分配给每个项目的唯一标识。 |

### 请求示例

#### 请求路径

```http
https://api.agora.io/dabiz/license/v1/pad/clear?appid=a6d6dba434be4b6683fad1aba6a7f75e
```

### 响应参数

如果状态码为 `200`，则请求成功。

如果状态码不为 `200`，则请求失败。你可以根据返回的 [状态码](https://docs.agora.io/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81) 和响应包体中 `message` 字段的描述进行错误排查。

### 响应示例

请求成功的响应示例：

```json
{
    "code": 200,
    "message": "清空预授权成功"
}
```


## 查询指定预授权

```http
POST https://api.agora.io/dabiz/license/v1/pad/add?licenseKey={licensekey}&appid={appid}
```

```json
{
    "code": 200,
    "data": [
        {
            "id": 16,
            "cid": 717241,
            "vid": 975823,
            "licenseKey": "12345",
            "createTime": "2022-07-26 04:01:41"
        }
    ]
}
```


## 查询预授权

```http
GET https://api.agora.io/dabiz/license/v1/pads?page={page}&size={size}&appid={appid}
```

```json
{
    "code": 200,
    "data": {
        "count": 2,
        "list": [
            {
                "id": 20,
                "cid": 717241,
                "vid": 975823,
                "licenseKey": "12345",
                "createTime": "2022-07-26 05:18:03"
            },
            {
                "id": 19,
                "cid": 717241,
                "vid": 975823,
                "licenseKey": "54321",
                "createTime": "2022-07-26 05:17:18"
            }
        ]
    }
}
```


## 导出预授权

```http
GET https://api.agora.io/dabiz/license/v1/pads/export?appid={appid}
```

```json
12345
54321
```