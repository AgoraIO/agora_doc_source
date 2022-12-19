Agora 内容中心提供在线 K 歌房场景所需歌曲内容，如歌曲、歌词、MV、热歌榜等。内容由音乐合作方提供，如需进一步了解 Agora 内容中心，请联系 [sales@agora.io](mailto:support@agora.io)。

点歌流程即调用 RESTful API 从内容中心获取曲库所有歌曲及相关信息，再获取指定歌曲及相关信息。你还可以通过调用 RESTful API 使用 Agora 内容中心的进阶功能。

<div class="alert note"> 目前仅支持中国大陆地区的 K 歌场景。</div>

## 前提条件

### 开通服务

请联系 [sales@agora.io](mailto:sales@agora.io) 开通 Agora 内容中心服务。

### HTTP 认证

点歌 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要通过 Basic HTTP 认证，并将生成的凭证填入 HTTP 请求头部的 `Authorization` 字段。具体生成 `Authorization` 字段的方法请参考[ HTTP 基本认证](https://docs.agora.io/cn/cloud-recording/faq/restful_authentication)。

## 实现点歌功能

通过获取曲库所有歌曲列表和获取指定歌曲两个步骤来实现点歌。

### 数据格式

所有的请求都发送给域名：`api.agora.io`。

- 请求：请求的格式详见下面各个 API 中的示例
- 响应：响应内容的格式为 JSON

> 所有的请求 URL 和请求包体内容都是区分大小写的。

### <a name="param"></a>公共参数
内容中心 RESTful API 的公共参数及描述如下：

#### 请求参数
| 参数 | 类型   | 描述                                                         |
| :------- | :----- | :----------------------------------------------------------- |
| `appid`  | （必填）String | 你的项目使用的 [App ID](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms#获取-app-id)，该 App ID 需要已开通内容中心权限。 |
| `requestId` | （必填）String | 本次请求的唯一标识。<li>必须设置为 32 位字符串，支持大写字母、小写字母、数字、"_"（下划线）、"-"（中划线），不区分大小写。<li>一个项目下 `requestId` 唯一。 | 

#### 响应参数
| 参数 | 类型   | 描述                                                         |
| :------- | :----- | :----------------------------------------------------------- |
| `code`                  | Int64        | 响应状态码，`0` 表示请求成功。                  |
| `msg`                   | String     | 返回消息名称，`ok` 表示请求成功。               |
| `requestId`             | String     | 请求唯一标识，与请求包体中的 `requestId` 一致。 |
| `ext`                   | String     | 预留字段                                  |


### <a name="get"></a>获取曲库所有歌曲列表

首先，你需要调用该方法获取曲库中所有歌曲的列表。

#### HTTP 请求
- 方法：GET
- 接入点：cn/v1.0/projects/{appid}/ktv-service/api/serv/songs

**路径参数**

`appid` ：详见[公共参数](#param)。

**查询参数**

| 参数  | 类型   | 描述                                                         | 
| :-------- | :----- | :----------------------------------------------------------- |
| `requestId` | （必填）String | 本次请求的唯一标识。详见[公共参数](#param)。 | 
| `pageType`  | （可选）Int64    | 翻页方式：<li>`0`：（默认）下一页<li>`1`：上一页                           | 
| `pageCode`  |（可选） Int64    | 作为翻页锚点的歌曲编号。 <li>第一次获取曲库无需设置该参数。<li>默认为当前页歌曲列表第一首歌曲的编号。 | 
| `size`      | （可选）Int64    | 每页歌曲显示的最大数量。默认为 `10`，取值范围为 [1, 1000]。            | 
| `status`      |（可选） Int64    | 歌曲状态：<li>`1`：（默认）已上架<li>`0`：已下架<li>`-1`：已删除<li>`9`：全部状态            | 
| `songType`      |（可选） Int64    |歌曲资源类型：<li>`1`：左声道伴奏，右声道原唱的单音轨纯音频歌曲。<li>`2`：只有伴唱的单音轨纯音频歌曲。<li>`3`：只有原唱的单音轨纯音频歌曲。<li>`4`：既有多音轨纯音频又有多音轨 MV 资源的歌曲。<li>`5`：只有多音轨 MV 资源的歌曲。<li>`6`：既有多音轨纯音频又有多音轨 MV 资源的歌曲 （该音源受数字版权保护）。 <br>默认获取所有类型。          | 
| `vendorId`      |（可选） Int64    |歌曲版权方编号：<li> `1`：咪咕<li>`2`：敖拜 <li>`3`：其他<br>默认获取所有版权方。          | 
	

#### HTTP 响应
如果响应状态码为 `0`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型       | 描述                                        |
| :-------------------- | :--------- | :------------------------------------------ |
| `data`                  | JSON       | 信息详情。                              |
|`msg` | String | 本次请求返回的消息。`ok` 表示请求成功。|
	|`requestId`|String | 请求 ID。本次请求的唯一标识。|
	| `ext`                   | String     | 预留字段                                  |
| `data.pageType`         | Int64        | 翻页方式：<li>`0`：下一页<li>`1`：上一页                  |
| `data.pageCode`         | Int64        | 翻页锚点的歌曲编号。                          |
| `data.size`             | Int        | 每页歌曲显示的最大数量。                              |
| `data.count`            | Int        | 本次请求返回的歌曲数量。                     |
| `data.list`             | JSON Array | 当前曲库中所有的歌曲列表。                    |
| `data.list.songCode`    | Int64        | 歌曲编号。                                    |
| `data.list.name`        | String     | 歌曲名称。                                    |
| `data.list.singer`      | String     | 歌手名称。                                    |
| `data.list.poster`      | String     | 歌手封面图片 URL。                            |
| `data.list.lyricType`      | Number Array     | 歌词格式类型：<li>`0`：xml 格式<li>`1`：lrc 格式。<br>如果为空则表示没有歌词。                       |
| `data.list.type`      | Int64     | 歌曲资源类型：<li>`1`：左声道伴奏，右声道原唱的单音轨纯音频歌曲。<li>`2`：只有伴唱的单音轨纯音频歌曲。<li>`3`：只有原唱的单音轨纯音频歌曲。<li>`4`：既有多音轨纯音频又有多音轨MV资源的歌曲。<li>`5`：只有多音轨 MV 资源的歌曲。<li>`6`：既有多音轨纯音频又有多音轨MV资源的歌曲（受数字版权保护）。                              |
| `data.list.duration`      | Int64     | 歌曲时长（秒）。       |
| `data.list.status` | Int64  | 歌曲状态：<li>`1`：已上架<li>`0`：已下架<li>`-1`：已删除     |
| `data.list.updateTime`      | Int64     | 歌曲更新的 Unix 时间戳（秒）。    |
| `data.list.releaseTime` | String     | 歌曲发布时间。                                |
| `data.list.vendorId` | Int64     | 歌曲版权方编号：<li> `1`：咪咕<li>`2`：敖拜 <li>`3`：其他                          |
| `data.list.pitchType` | Int64     | 歌曲是否支持演唱评分功能：<li> `1`：歌曲支持演唱评分功能<li>`2`：歌曲不支持演唱评分功能                           |
| `data.list.mv` | JSON Array     | 当前曲库中所有的 MV（Music Video）信息列表。                          |
| `data.list.mv.resolution` | String     |  MV 的分辨率，目前支持分辨率包括 480P、720P 和 1080P。                   |
| `data.list.mv.bw` | String     |  MV 的带宽，单位为 Kbps。                    |
|`data.list.highPart`     | Array  | 音乐高潮片段 |
|`data.list.highPart.highStartTime`| Int64 | 音乐高潮片段的开始时间点，单位毫秒。|
|`data.list.highPart.highEndTime`| Int64 | 音乐高潮片段的结束时间点，单位毫秒。|

其他响应字段及说明详见[公共参数](#param)。
如果返回的 HTTP 状态码非 `0`，表示请求失败。你可以参考[响应状态码汇总表](#code)了解可能的原因。

#### 请求示例

```shell
curl 'https://api.agora.io/cn/v1.0/projects/{appid}/ktv-service/api/serv/songs?requestId=lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V&pageType=0&pageCode=6246262727281830&size=2' \
-H 'Authorization: {AuthorizationHeader}'
```

#### 响应示例

```json
{
    "code": 0,
    "msg": "ok",
    "requestId": "lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V",
    "ext": "",
    "data": {
        "pageType": 0,
        "size": 2,
        "pageCode": 6246262727281830,
        "count": 2,
        "list": [
            {
                "songCode": 6246262727281850,
                "name": "龙拳",
                "singer": "周杰伦",
                "poster": "https://accpic.sd-rtn.com/pic/release/jpg/1/7a8941/ChmFZ1S0immAVtSDAAODVRzMNHg454.jpg",
                "duration": 274,
                "lyricType": [
                    0,
                    1
                ],
                "type": 1,
                "releaseTime": "2014/11/27 9:32",
                "status": 1,
                "updateTime": 1638141088,
                "vendorId": 1,
                "pitchType": 1,
                "mv": [{
                    "resolution": "720P",
                    "bw": "0"
                }, {
                    "resolution": "480P",
                    "bw": "0"
                }],
                "highPart": [{
                    "highStartTime": 121122,
                    "highEndTime": "134213"
                }, {
                    "highStartTime": 154534,
                    "highEndTime": "162134"
                }],
            },
            {
                "songCode": 6246262727281860,
                "name": "最长的电影",
                "singer": "周杰伦",
                "poster": "https://accpic.sd-rtn.com/pic/release/jpg/1/7a8941/ChmFZ1S0immAVtSDAAODVRzMNHg454.jpg",
                "duration": 230,
                "lyricType": null,
                "type": 1,
                "releaseTime": "2014/11/27 9:32",
                "status": 1,
                "vendorId": 1,
                "pitchType": 1,
                "updateTime": 1635229782,
                "mv": null,
                "highPart": [{
                    "highStartTime": 121221,
                    "highEndTime": "132132"
                }, {
                    "highStartTime": 154534,
                    "highEndTime": "162134"
                }],
            }
        ]
    }
}
```
	
## 进阶功能 
### 获取增量歌曲列表
你可以调用该方法定期查询曲库中增量的歌曲。建议每隔 24 小时查询一次。
	
#### HTTP 请求
	
- 方法：GET
- 接入点：cn/v1.0/projects/{appid}/ktv-service/api/serv/songs-incr

**路径参数**

`appid` ：详见[公共参数](#param)。

**查询参数**
	
| 参数  | 类型   | 描述                                                         | 
| :-------- | :----- | :----------------------------------------------------------- |
| `requestId` | （必填）String | 本次请求的唯一标识。详见[公共参数](#param)。 | 
| `lastUpdateTime`  |（必填） Int64    | 最近一次更新曲库的 Unix 时间戳（秒）。       |
| `page` |（可选） Int64    | 目标页编号。默认为 `1`。取值范围为 [1, (2<sup>32</sup>-1)]。  | 
| `size`      |（可选） Int64    | 目标页歌曲显示的最大数量。默认为 10，取值范围为 [1, 1000]。            | 
| `status`      | （可选）Int    | 歌曲状态：<li>`1`：（默认）已上架<li>`0`：已下架<li>`-1`：已删除<li>`9`：全部状态      |
| `songType`      |（可选） Int64    |歌曲资源类型：<li>`1`：左声道伴奏，右声道原唱的单音轨纯音频歌曲。<li>`2`：只有伴唱的单音轨纯音频歌曲。<li>`3`：只有原唱的单音轨纯音频歌曲。<li>`4`：既有多音轨纯音频又有多音轨MV资源的歌曲。<li>`5`：只有多音轨 MV 资源的歌曲。<li>`6`：既有多音轨纯音频又有多音轨MV资源的歌曲（受数字版权保护）。<br>默认为所有类型。          | 
| `vendorId`      |（可选） Int64    |歌曲版权方编号：<li> `1`：咪咕<li>`2`：敖拜 <li>`3`：其他<br>默认获取所有版权方。         | 


**注意**
- 调用该方法，你会得到指定页更新时间大于 `lastUpdateTime` 的歌曲列表。
- 如果你是第一次调用该方法，Agora 建议你将 `lastUpdateTime` 设置为 `0`，即获取曲库全部歌曲列表；如果不是第一次调用该方法，Agora 建议你将 `lastUpdateTime` 设置为前一次调用该方法获得的响应字段中 `updateTime` 的最大值。
- 你需要将每个 `page` 的 `lastUpdateTime` 设置为一致，否则会遗漏增量歌曲。

#### HTTP 响应
如果响应状态码为 `0`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 字段说明                                                     |
| :-------------- | :----- | :----------------------------------------------------------- |
| `data`                  | JSON       | 信息详情。                             |
|`msg` |String |本次请求返回的消息，`ok` 表示请求成功。|
|`requestId`|String | 请求 ID。本次请求的唯一标识。|
		| `ext`                   | String     | 预留字段。                                  |
| `data.page`         | Int64        | 当前页编号。             |
| `data.size`             | Int64        | 当前页歌曲显示的最大数量。                  |
| `data.count`            | Int64        | 本次请求返回的歌曲数量。                      |
| `data.list`             | JSON Array | 本次请求的歌曲列表。                    |
| `data.list.songCode`    | Int64        | 歌曲编号。                                    |
| `data.list.name`        | String     | 歌曲名称。                                    |
| `data.list.singer`      | String     | 歌手名称。                                    |
| `data.list.poster`      | String     | 歌手封面图片 URL。                            |
| `data.list.lyricType`      | Number Array     | 歌词格式类型：<li>`0`：xml 格式<li>`1`：lrc 格式。<br>如果为空则表示没有歌词。       |
| `data.list.type`      | Int     | 歌曲资源类型：<li>`1`：左声道伴奏，右声道原唱的单音轨纯音频歌曲。<li>`2`：只有伴唱的单音轨纯音频歌曲。<li>`3`：只有原唱的单音轨纯音频歌曲。<li>`4`：既有多音轨纯音频又有多音轨MV资源的歌曲。<li>`5`：只有多音轨 MV 资源的歌曲。<li>`6`：既有多音轨纯音频又有多音轨MV资源的歌曲（受数字版权保护）。                        |
	| `data.list.duration`      | Int64     | 歌曲时长（秒）。       |
		| `data.list.status`      | Int    | 歌曲状态：<li>`1`：已上架<li>`0`：已下架<li>`-1`：已删除     |	
		| `data.list.updateTime`      | Int64     | 歌曲更新的 Unix 时间戳（秒）。    |
| `data.list.releaseTime` | String     | 歌曲发布时间。                                |
		| `data.list.vendorId` | Int64     | 歌曲版权方编号：<li> `1`：咪咕<li>`2`：敖拜 <li>`3`：其他                          |
| `data.list.pitchType` | Int64     | 歌曲是否支持演唱评分功能：<li> `1`：歌曲支持演唱评分功能<li>`2`：歌曲不支持演唱评分功能                           |
		| `data.list.mv` | JSON Array     | 当前曲库中所有的 MV（Music Video）信息列表。                          |
		| `data.list.mv.resolution` | String     |  MV 的分辨率，目前支持分辨率包括 480P、720P 和 1080P。                       |
			| `data.list.mv.bw` | String     |  MV 的带宽，单位为 Kbps。                    |
|`data.list.highPart`     | Array  | 音乐高潮片段 |
|`data.list.highPart.highStartTime`| Int64 | 音乐高潮片段的开始时间点，单位毫秒。|
|`data.list.highPart.highEndTime`| Int64 | 音乐高潮片段的结束时间点，单位毫秒。|

其他响应字段及说明详见[公共参数](#param)。
如果返回的 HTTP 状态码非 `0`，表示请求失败。你可以参考[响应状态码汇总表](#code)了解可能的原因。
	
#### 请求示例

```shell
curl 'https://api.agora.io/cn/v1.0/projects/{appid}/ktv-service/api/serv/songs-incr?requestId=lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V&pageType=0&lastUpdateTime=1635229837&page=1&size=2' \
-H 'Authorization: {AuthorizationHeader}'
```

#### 响应示例

```json			
{
    "code": 0,
    "msg": "ok",
    "requestId": "lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V",
    "ext": "",
    "data": {
        "size": 2,
        "page": 1,
        "count": 2,
        "list": [{
            "songCode": 6246262727295570,
            "name": "没有目的地爱了",
            "singer": "杨千嬅",
            "poster": "https://accpic.sd-rtn.com/pic/release/jpg/1/a35420/ChmFaVS9H2uARX7BAAFV0nstAAM724.jpg",
            "duration": 267,
            "lyricType": null,
            "type": 2,
            "releaseTime": "2014/12/15 22:13",
            "vendorId": 1,
            "pitchType": 1,
            "status": 1,
            "updateTime": 1635229838,
            "mv": null,
            "highPart": [{
                    "highStartTime": 121221,
                    "highEndTime": "132132"
                }, {
                    "highStartTime": 154534,
                    "highEndTime": "162134"
                }],
        }, {
            "songCode": 6246262727295610,
            "name": "热血青年",
            "singer": "杨千嬅",
            "poster": "https://accpic.sd-rtn.com/pic/release/jpg/1/a35420/ChmFaVS9H2uARX7BAAFV0nstAAM724.jpg",
            "duration": 411,
            "lyricType": [
                    0
             ],
            "type": 1,
            "releaseTime": "2015/1/12 11:00",
            "vendorId": 1,
            "pitchType": 1,
            "status": 1,
            "updateTime": 1635229838,
            "mv": null,
            "highPart": [{
                    "highStartTime": 121221,
                    "highEndTime": "132132"
                }, {
                    "highStartTime": 154534,
                    "highEndTime": "162134"
                }],
        }]
    }
}
```

### 获取热歌榜单类型
	
你可以调用该方法获取热歌榜单名称和类型。
	
#### HTTP 请求

- 方法：GET
- 接入点：/cn/v1.0/projects/{appid}/ktv-service/api/serv/hot-type

**路径参数**

`appid` ：详见[公共参数](#param)。

**查询参数**

| 参数        | 类型           | 描述                                                         |
| :---------- | :------------- | :----------------------------------------------------------- |
| `requestId` | （必填）String | 本次请求的唯一标识。详见[公共参数](#param)。 |

	
#### HTTP 响应

如果响应状态码为 `0`，表示请求成功，响应包体中包含以下字段：

| 字段                 | 类型       | 字段说明                                        |
| :------------------- | :--------- | :---------------------------------------------- |
| `code`                  | Int64        | 响应状态码，`0` 表示请求成功。                  |
| `msg`                   | String     | 返回消息名称，`ok` 表示请求成功。               |
| `requestId`             | String     | 请求唯一标识，与请求包体中的 `requestId` 一致。 |
| `ext`                   | String     | 预留字段。                                  |
| `data`               | JSON       | 信息详情。                                        |
| `data.list`          | JSON Array | 热歌榜单信息列表。                                    |
| `data.list.hotName` | String        | 热歌榜单名称。                                        |
| `data.list.hotType`      | Int64        | 热歌榜单类型。                                        |
	
其他响应字段及说明详见[公共参数](#param)。
如果返回的 HTTP 状态码非 `0`，表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

#### 请求示例
	
```shell
curl 'https://api.agora.io/cn/v1.0/projects/{appid}/ktv-service/api/serv/hot-type?requestId=lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V' \
-H 'Authorization: {AuthorizationHeader}'
```
#### 响应示例

```json
{
    "code": 0,
    "msg": "ok",
    "requestId": "lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V",
    "ext": "",
    "data": {
        list:[{
                "hotName": "声网榜单",
                "hotType": 1
             }, {
                "hotName": "新歌榜",
                "hotType": 2
            }]
    }
}
```

### 获取热歌榜单详情

你可以调用该方法获取热歌榜单详情。

> - 热歌为日点播次数大于或等于 10 次的歌曲。
> - 调用该方法获取的热歌榜单仅显示日点播次数前 100 的热歌，如果热歌数量少于 100 首则按实际数量显示。
> - 每日 05:00 统计 0:00 之前的数据。

#### HTTP 请求

- 方法：GET
- 接入点：/cn/v1.0/projects/{appid}/ktv-service/api/serv/song-hot

**路径参数**

`appid` ：详见[公共参数](#param)。

**查询参数**

| 参数        | 类型           | 描述                                                         |
| :---------- | :------------- | :----------------------------------------------------------- |
| `requestId` | （必填）String | 本次请求的唯一标识。详见[公共参数](#param)。 |
| `hotType`   | （可选）Int64    | 榜单类型：<li>`0`：（默认）整体榜单<li>`2`：新歌榜<li>`3`：嗨唱推荐<li>`4`：抖音热歌 <li>`5`：古风热歌 <li>`6`：KTV 必唱 |
	
#### HTTP 响应

如果响应状态码为 `0`，表示请求成功，响应包体中包含以下字段：

| 字段                 | 类型       | 字段说明                                        |
| :------------------- | :--------- | :---------------------------------------------- |
| `data`               | JSON       | 信息详情。                                        |
| `msg`                   | String     | 返回消息名称，`ok` 表示请求成功。               |
| `requestId`             | String     | 请求唯一标识，与请求包体中的 `requestId` 一致。 |
| `data.list`             | JSON Array | 当前曲库中所有的歌曲列表。                    |
| `data.list.songCode`    | Int64        | 歌曲编号。                                    |
| `data.list.num`        | Int64    | 点播次数。                                    |
	| `ext`                   | String     | 预留字段。                                  |

其他响应字段及说明详见[公共参数](#param)。
如果返回的 HTTP 状态码非 `0`，表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

#### 请求示例
	
```shell
curl 'https://api.agora.io/cn/v1.0/projects/{appid}/ktv-service/api/serv/song-hot?requestId=lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V&hotType=1' \
-H 'Authorization: {AuthorizationHeader}'
```
#### 响应示例

```json
{
    "code": 0,
    "msg": "ok",
    "requestId": "lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V",
    "ext": "",
    "data": {
        "list": [{
            "songCode": 6246262727281920,
            "num": 157
        }, {
            "songCode": 6246262727281870,
            "num": 149
        }, {
            "songCode": 6246262727282110,
            "num": 145
        }, {
            "songCode": 6246262727282151,
            "num": 133
        }, {
            "songCode": 6246262727282060,
            "num": 132
        }, {
            "songCode": 6246262727282040,
            "num": 123
        }, {
            "songCode": 6246262727281930,
            "num": 99
        }, {
            "songCode": 6246262727282010,
            "num": 95
        }, {
            "songCode": 6246262727282061,
            "num": 84
        }, {
            "songCode": 6246262727282180,
            "num": 73
        }]
    }
}
```

## 保障 REST 服务高可用
	
~78021d80-6bc4-11ed-8dae-bf25bf08a626~	
	
## 参考信息
### <a name="code"></a>响应状态码汇总表

| code | 说明                   |
| :--- | :--------------------- |
| `0 ` | 正常                   |
| `1000` | 查询数据结果为空。       |
| `1001` | 操作异常。         |
| `1002` | [App ID](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id) 异常，如过期、关闭，该 App ID  未开通内容中心等，或白名单中的 IP 地址不合法。 |
| `1003` | 系统异常，请联系技术支持。              |
| `1004` | 系统繁忙，请稍后再试。   |
| `1005` | 参数错误。               |
| `1008` | 没有该歌曲资源权限。               |
| `1009` | 该歌曲资源已下架。               |