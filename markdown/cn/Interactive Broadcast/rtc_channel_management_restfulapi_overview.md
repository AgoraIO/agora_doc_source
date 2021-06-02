---
title: API 概览
platform: RESTful
updatedAt: 2021-03-31 08:25:51
---
Agora 频道管理 RESTful API 提供以下功能：

## 封禁用户权限

| 请求 URL                                 | 方法   | 功能                           |
| :--------------------------------------- | :----- | :----------------------------- |
| https://api.agora.io/dev/v1/kicking-rule | POST   | 创建封禁用户权限规则           |
| https://api.agora.io/dev/v1/kicking-rule | GET    | 获取封禁用户权限规则列表       |
| https://api.agora.io/dev/v1/kicking-rule | PUT    | 更新封禁用户权限规则的生效时间 |
| https://api.agora.io/dev/v1/kicking-rule | DELETE | 删除封禁用户权限规则           |

## 查询在线频道信息

| 请求 URL                                                     | 方法 | 功能                   |
| :----------------------------------------------------------- | :--- | :--------------------- |
| https://api.agora.io/dev/v1/channel/user/property/{appid}/{uid}/{channelName} | GET  | 查询用户状态           |
| https://api.agora.io/dev/v1/channel/user/{appid}/{channelName} | GET  | 获取用户列表           |
| https://api.agora.io/dev/v1/channel/{appid}                  | GET  | 分页查询项目的频道列表 |

点击查看我们的[频道管理 RESTful API](https://docs.agora.io/cn/rtc/restfulapi) ![img](https://web-cdn.agora.io/docs-files/1583736328279) 参考文档。该文档包含方法和参数的详细解释，并提供 Try it out 功能，使你在文档页内就能进行 RESTful API 的调用。