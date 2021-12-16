---
title: 云端录制 RESTful API
platform: All Platforms
updatedAt: 2020-06-12 13:00:28
---
本文列出了云端录制 RESTful API 的方法名和参数名。详细介绍见互动式文档：[云端录制 RESTful API](https://agoradoc.github.io/cloud-recording-cn)![](https://web-cdn.agora.io/docs-files/1582509015530)。该文档包含各方法和参数的详细介绍，以及认证方式、数据格式和 API 调用步骤。你可以通过 **Example Value** 和 **Schema** 标签页查看示例请求、示例响应，以及各参数的详细介绍。

## acquire

`POST /v1/apps/{appid}/cloud_recording/acquire`

*获取云端录制资源*

<h3 id="acquire-parameters">Parameters</h3>

| Name                  | In   | Type    | Required |
| --------------------- | ---- | ------- | -------- |
| appid                 | path | string  | true     |
| cname                 | body | string  | true     |
| uid                   | body | string  | true     |
| clientRequest         | body | object  | true     |
| » resourceExpiredHour | body | integer | false    |

<h3 id="acquire-responses">Responses</h3>

| Name       | Type   | Required | Restrictions |
| ---------- | ------ | -------- | ------------ |
| resourceId | string | false    | none         |

## start

`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start`

*开始云端录制*

<h3 id="start-parameters">Parameters</h3>

| Name                   | In   | Type          | Required |
| ---------------------- | ---- | ------------- | -------- |
| appid                  | path | string        | true     |
| resourceid             | path | string        | true     |
| mode                   | path | string        | true     |
| cname                  | body | string        | true     |
| uid                    | body | string        | true     |
| clientRequest          | body | object        | false    |
| » token                | body | string        | false    |
| » recordingConfig      | body | object        | false    |
| »» streamTypes         | body | integer       | false    |
| »» decryptionMode      | body | integer       | false    |
| »» secret              | body | string        | false    |
| »» channelType         | body | integer       | false    |
| »» audioProfile        | body | integer       | false    |
| »» videoStreamType     | body | integer       | false    |
| »» maxIdleTime         | body | integer       | false    |
| »» transcodingConfig   | body | object        | false    |
| »»» width              | body | integer       | false    |
| »»» height             | body | integer       | false    |
| »»» fps                | body | integer       | false    |
| »»» bitrate            | body | integer       | false    |
| »»» maxResolutionUid   | body | string        | false    |
| »»» mixedVideoLayout   | body | number        | false    |
| »»» backgroundColor    | body | string        | false    |
| »»» layoutConfig       | body | [object]      | false    |
| »»»» uid               | body | string        | false    |
| »»»» x_axis            | body | number(float) | false    |
| »»»» width             | body | number(float) | false    |
| »»»» height            | body | number(float) | false    |
| »»»» alpha             | body | number(float) | false    |
| »»»» render_mode       | body | number        | false    |
| »»» subscribeVideoUids | body | [string]      | false    |
| »»» subscribeAudioUids | body | [string]      | false    |
| »»» subscribeUidGroup  | body | integer       | false    |
| » storageConfig        | body | object        | false    |
| »» vendor              | body | integer       | false    |
| »» region              | body | integer       | false    |
| »» bucket              | body | string        | false    |
| »» accessKey           | body | string        | false    |
| »» secretKey           | body | string        | false    |
| »» fileNamePrefix      | body | [string]      | false    |

<h3 id="start-responses">Responses</h3>

| Name       | Type   | Required | Restrictions |
| ---------- | ------ | -------- | ------------ |
| resourceId | string | false    | none         |
| sid        | string | false    | none         |

## updateLayout

`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/updateLayout`

*更新合流布局*

<h3 id="updatelayout-parameters">Parameters</h3>

| Name               | In   | Type          | Required |
| ------------------ | ---- | ------------- | -------- |
| appid              | path | string        | true     |
| resourceid         | path | string        | true     |
| sid                | path | string        | true     |
| mode               | path | string        | true     |
| cname              | body | string        | false    |
| uid                | body | string        | false    |
| clientRequest      | body | object        | false    |
| » maxResolutionUid | body | string        | false    |
| » mixedVideoLayout | body | integer       | false    |
| » backgroundColor  | body | string        | false    |
| » layoutConfig     | body | [any]         | false    |
| »» uid             | body | string        | false    |
| »» x_axis          | body | number(float) | false    |
| »» y_axis          | body | number(float) | false    |
| »» width           | body | number(float) | false    |
| »» height          | body | number(float) | false    |
| »» alpha           | body | number(float) | false    |
| »» render_mode     | body | integer       | false    |

<h3 id="updatelayout-responses">Responses</h3>

| Name       | Type   | Required | Restrictions |
| ---------- | ------ | -------- | ------------ |
| resourceId | string | false    | none         |
| sid        | string | false    | none         |

## query

`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/query`

*查询云端录制状态*

<h3 id="query-parameters">Parameters</h3>

| Name       | In   | Type   | Required |
| ---------- | ---- | ------ | -------- |
| appid      | path | string | true     |
| resourceid | path | string | true     |
| sid        | path | string | true     |
| mode       | path | string | true     |

<h3 id="query-responses">Responses</h3>

| Name              | Type    | Required | Restrictions |
| ----------------- | ------- | -------- | ------------ |
| resourceId        | string  | false    | none         |
| sid               | string  | false    | none         |
| serverResponse    | object  | false    | none         |
| » fileListMode    | string  | false    | none         |
| » fileList        | [any]   | false    | none         |
| »» filename       | string  | false    | none         |
| »» trackType      | string  | false    | none         |
| »» uid            | string  | false    | none         |
| »» mixedAllUser   | string  | false    | none         |
| »» isPlayable     | string  | false    | none         |
| »» sliceStartTime | string  | false    | none         |
| » status          | integer | false    | none         |
| » sliceStartTime  | string  | false    | none         |

## stop

`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/stop`

*停止云端录制*

<h3 id="stop-parameters">Parameters</h3>

| Name          | In   | Type   | Required |
| ------------- | ---- | ------ | -------- |
| appid         | path | string | true     |
| resourceid    | path | string | true     |
| sid           | path | string | true     |
| mode          | path | string | true     |
| cname         | body | string | false    |
| uid           | body | string | false    |
| clientRequest | body | object | false    |

<h3 id="stop-responses">Responses</h3>

| Name              | Type   | Required | Restrictions |
| ----------------- | ------ | -------- | ------------ |
| resourceId        | string | false    | none         |
| sid               | string | false    | none         |
| serverResponse    | object | false    | none         |
| » fileListMode    | string | false    | none         |
| » fileList        | [any]  | false    | none         |
| »» filename       | string | false    | none         |
| »» trackType      | string | false    | none         |
| »» uid            | string | false    | none         |
| »» mixedAllUser   | string | false    | none         |
| »» isPlayable     | string | false    | none         |
| »» sliceStartTime | string | false    | none         |
| » uploadingStatus | string | false    | none         |