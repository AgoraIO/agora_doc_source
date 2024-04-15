# 如何在 灵动课堂 RESTful API中进行 HTTP Token 认证?

## 功能描述
在使用灵动课堂 RESTful API前，你需要通过HTTP Token认证。

灵动课堂 RESTful API同时支持AccessToken2（推荐）和AccessToken（兼容）两种模式。你可以选择任意一种模式，即可通过接口鉴权。

### AccessToken2（推荐）
你需要在 HTTP 请求中 header 的 `Authorization: agora token=` 字段填入服务端生成的[EducationToken](/跳转到下方AccessToken2 生成器代码)。

#### 请求示例

```json
curl -X POST 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Authorization: agora token={educationToken}' \
--data-raw '{
    "roomName": "test_class",
    "roomType": 4
}'
```




### AccessToken（兼容）
你需要在 HTTP 请求中 header 的 `x-agora-token` 字段和 `x-agora-uid` 字段分别填入：

- 服务端生成的 [RTM Token](/跳转到下方AccessToken2 生成器代码)。
- 生成 RTM Token 时使用的 RTM 用户 ID。

#### 请求示例

```json
curl -X POST 'https://api.agora.io/{region}/edu/apps/{yourAppId}/v2/rooms/test_class' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'x-agora-uid: {uid}' \
-H 'x-agora-token: {rtmToken}' \
--data-raw '{
    "roomName": "test_class",
    "roomType": 4
}'
```

<div class="alert note">一般情况下，Agora 建议你在服务端进行 HTTP 基本认证和 Token 认证，否则会有数据泄露的风险。</div>



## 参考

本节介绍 AccessToken2(推荐)和AccessToken(兼容) 生成器代码库、使用 Token 的版本要求等相关文档。

Agora 在 GitHub 上提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Go 等语言在你自己的服务器上生成 Token。


### AccessToken2 生成器代码

目前，灵动课堂的Token007提供3种级别作用域：App全局，个人用户，指定房间指定用户（客户端使用）。
<br/>

#### App全局
作用域为App全局操作，如创建教室，设置/查询房间模版等。

| 语言 | 算法 | 核心方法                                                                                                                                                       | 示例代码 |
| -------- | ----------- |------------------------------------------------------------------------------------------------------------------------------------------------------------| ---------------- |
| C++ | HMAC-SHA256 | [BuildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/EducationTokenBuilder2.h)                                  |  |
| Go | HMAC-SHA256 | [BuildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/educationtokenbuilder/educationtokenbuilder.go)             | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/educationtokenbuilder/sample.go) |
| Java | HMAC-SHA256 | [buildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/education/EducationTokenBuilder2.java) | [EducationTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/EducationTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/EducationTokenBuilder.js)                                    | [EducationTokenSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/EducationTokenSample.js) |
| PHP | HMAC-SHA256 | [buildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/EducationTokenBuilder.php)                                      | [EducationTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/EducationTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [build_app_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/education_token_builder.pypy)                                    | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/education_token_builder_sample.py) |
| Python 3 | HMAC-SHA256 | [build_app_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/education_token_builder.py)                                   | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/education_token_builder_sample.py) |

<br/>

#### 个人用户
作用域为指定App下的个人操作，可跨多个房间，如个人云盘。

| 语言 | 算法 | 核心方法                                                                                                                                                        | 示例代码 |
| -------- | ----------- |-------------------------------------------------------------------------------------------------------------------------------------------------------------| ---------------- |
| C++ | HMAC-SHA256 | [BuildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/EducationTokenBuilder2.h)                                  |  |
| Go | HMAC-SHA256 | [BuildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/educationtokenbuilder/educationtokenbuilder.go)             | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/educationtokenbuilder/sample.go) |
| Java | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/education/EducationTokenBuilder2.java) | [EducationTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/EducationTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/EducationTokenBuilder.js)                               | [EducationTokenSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/EducationTokenSample.js) |
| PHP | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/EducationTokenBuilder.php)                                 | [EducationTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/EducationTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/education_token_builder.pypy)                         | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/education_token_builder_sample.py) |
| Python 3 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/education_token_builder.py)                          | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/education_token_builder_sample.py) |

<br/>

#### 指定房间指定用户（客户端使用）
作用域为具体房间具体用户，该token打包了ServiceEducation和ServiceRtm两个服务，在客户端SDK启动时传入，可以帮助用户打通灵动课堂及RTM用户登录的token。

| 语言 | 算法 | 核心方法                                                                                                                                                            | 示例代码 |
| -------- | ----------- |-----------------------------------------------------------------------------------------------------------------------------------------------------------------| ---------------- |
| C++ | HMAC-SHA256 | [BuildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/EducationTokenBuilder2.h)                                  |  |
| Go | HMAC-SHA256 | [BuildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/educationtokenbuilder/educationtokenbuilder.go)             | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/educationtokenbuilder/sample.go) |
| Java | HMAC-SHA256 | [buildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/education/EducationTokenBuilder2.java) | [EducationTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/EducationTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/EducationTokenBuilder.js)                               | [EducationTokenSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/EducationTokenSample.js) |
| PHP | HMAC-SHA256 | [buildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/EducationTokenBuilder.php)                                 | [EducationTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/EducationTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [build_room_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/education_token_builder.pypy)                        | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/education_token_builder_sample.py) |
| Python 3 | HMAC-SHA256 | [build_room_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/education_token_builder.py)                               | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/education_token_builder_sample.py) |


<br/>

### AccessToken 生成器代码


| 语言 | 算法 | 核心方法 | 示例代码 |
| -------- | ----------- | ---------- | ---------------- |
| C++ | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/RtmTokenBuilder.h) | [RtmTokenBuilderSample.cpp](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/sample/RtmTokenBuilderSample.cpp) |
| Go | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/RtmTokenBuilder/RtmTokenBuilder.go) | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/RtmTokenBuilder/sample.go) |
| Java | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/rtm/RtmTokenBuilder.java) | [RtmTokenBuilderSample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtmTokenBuilderSample.java) |
| Node.js | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/RtcTokenBuilder.js) | [RtmTokenBuilderSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/RtcTokenBuilderSample.js) |
| PHP | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/RtmTokenBuilder.php) | [RtmTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/RtmTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/RtmTokenBuilder.py) | [RtmTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/RtmTokenBuilderSample.py) |
| Python 3 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/RtmTokenBuilder.py) | [RtmTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/RtmTokenBuilderSample.py) |

