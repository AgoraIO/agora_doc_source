---
title: 云端录制常见错误
platform: All Platforms
updatedAt: 2020-10-23 17:03:03
---
本文仅列出使用云端录制 RESTful API 过程中常见的错误码或错误信息，如果遇到其他错误，请联系 Agora 技术支持。

- `2`：参数不合法，请确保参数类型、大小写和取值范围正确，且必填的参数均已填写。
- `7`：录制已经在进行中 ，请勿用同一个 resource ID 重复 `start` 请求。
- `8`：HTTP 请求头部字段错误，有以下几种情况：
	- `Content-type` 错误，请确保 `Content-type` 为 `application/json;charset=utf-8`。
	- 请求 URL 中缺少 `cloud_recording` 字段。
	- 使用了错误的 HTTP 方法。
	- 请求包体不是合法的 JSON 格式。
- `53`：录制已经在进行中。当采用相同参数再次调用 `acquire` 获得新的 resource ID，并用于 `start` 请求时，会发生该错误。如需发起多路录制，需要在 `acquire` 方法中填入不同的 UID。
- `62`：调用 `Acquire` 请求时，如果出现该错误，表示你填入的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) 没有开通云端录制权限。
- `65`：多为网络抖动引起。使用相同 resource ID 重试即可。
- `432`：请求参数错误。请求参数不合法，或请求中的 App ID，频道名或用户 ID 与 resource ID 不匹配。
- `433`：resource ID 过期。获得 resource ID 后必须在 5 分钟内开始云端录制。请重新调用 `acquire` 获取新的 resource ID。
- `435`：没有录制文件产生。频道内没有用户加入，无录制对象。
- `501`：录制服务正在退出。该错误可能在调用了 `stop` 方法后再调用 `query` 时发生。
- `1001`：resource ID 解密失败。请重新调用 `acquire` 获取新的 resource ID。
- `1003`：App ID 或者录制 ID（sid）与 resource ID 不匹配。请确保在一个录制周期内 resource ID、App ID 和录制 ID 一一对应。
- `1013`：频道名不合法。频道名必须为长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）：
  - 26 个小写英文字母 a-z
  - 26 个大写英文字母 A-Z
  - 10 个数字 0-9
  - 空格
  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","

- `1028`：`updateLayout`方法的请求包体中参数错误。
-	`"invalid appid"`：无效的 App ID。请确保 App ID 填写正确。如果你已经确认 App ID 填写正确，但仍出现该错误，请[提交工单](https://agora-ticket.agora.io/)。
- `"no Route matched with those values`": 该错误可能由 HTTP 方法填写错误导致，例如将 GET 方法填写为 POST。
- `"Invalid authentication credentials"`: 该错误可能由 Customer ID 或 Customer Certificate 填写错误导致。如果你已经确认 Customer ID 和 Customer Certificate 填写正确，但仍出现该错误，请联系 support@agora.io。