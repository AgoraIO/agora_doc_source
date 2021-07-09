本文介绍 Agora 互动白板服务端 RESTful API 的基本信息。

## 域名

所有请求都发送给域名：`api.netless.link`。

## 数据格式

所有 HTTP 请求头部的 Content-Type 类型为 `application/json`。所有请求和响应内容的格式均为 JSON。所有的请求 URL 和请求包体内容都是区分大小写的。

<div class="alert note">互动白板服务器会对部分请求格式做兼容，但是无法保证完全兼容。当请求参数填写正确，但请求仍然失败时，请确认请求格式是否正确。</div>

## 主要功能

Agora 互动白板服务端 RESTful API 提供以下功能：

- [生成 Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful)
- [房间管理](/cn/whiteboard/whiteboard_room_management)
- [截图管理](/cn/whiteboard/whiteboard_screenshot)
- [场景管理](/cn/whiteboard/whiteboard_scene_management)
- [文档转换](/cn/whiteboard/whiteboard_file_conversion)

## 响应状态码

下表列出了所有可能的响应状态码。

- 如果状态码为 `200` 或 `201`，表示请求成功。

- 如果状态码不为 `200` 或 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

| HTTP 响应状态码 | 状态                  | 描述                                                       |
| :-------------- | :-------------------- | :--------------------------------------------------------- |
| `200`           | OK                    | 请求成功，服务器成功返回请求的数据。                       |
| `201`           | Created               | 请求成功，服务器成功新建或修改数据。                       |
| `400`           | Invalid request       | 用户发出的请求有错误，服务器没有进行新建或修改数据的操作。 |
| `401`           | Unauthorized          | 用户没有权限（Token 错误）。                               |
| `403`           | Forbidden             | 用户得到授权（与 401 错误相对），但是访问是被禁止的。      |
| `404`           | Not found             | 服务器无法找到请求的资源。                                 |
| `500`           | Internal server error | 服务器内部错误，无法完成请求。                             |