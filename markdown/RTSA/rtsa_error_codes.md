---
title: 错误代码
platform: All Platforms
updatedAt: 2021-03-29 10:33:33
---

本页列出了 Agora RTSA SDK 运行过程中或 API 调用时可能返回的错误代码，帮助你判断引起错误的原因，然后进行排查。

## 返回值

如果 API 调用失败，SDK 会返回一个小于零的值。有以下两种情况：

### 返回值为 -1

返回值为 -1 时，表示为 Linux 系统相关错误，详见 [Linux Errno 对照表](http://www-numi.fnal.gov/offline_software/srt_public_context/WebDocs/Errors/unix_system_errors.html)。

### 返回值小于 -1

#### 公共错误

| 错误码               | 返回值 | 描述             |
| :------------------- | :----- | :--------------- |
| ERRNO_NOT_IMPLEMENTD | -1001  | 该功能尚未实现。 |

#### license 相关错误

| 错误码                 | 返回值 | 错误描述                  |
| :--------------------- | :----- | :------------------------ |
| LICENSE_JSON_ERR_NOMEM | -2     | 内存不够                  |
| LICENSE_JSON_ERR_INVAL | -3     | JSON 字符串内包含非法字符 |
| LICENSE_JSON_ERR_PART  | -4     | JSON 字符串不完整         |
| LICENSE_JSON_ERR       | -5     | 其他 JSON 相关错误        |
| LICENSE_ERR_CERT_RAW   | -6     | `cert` 值或大小无效       |
| LICENSE_ERR_CUSTOM     | -7     | `custom` 部分缺失         |
| LICENSE_ERR_CREDENTIAL | -8     | `credential` 无效         |
| LICENSE_ERR_DUEDATE    | -9     | license 过期              |
| LICENSE_ERR_SIGN       | -10    | 签名无效                  |
| LICENSE_ERR_BUF        | -11    | 缓冲区溢出                |
| LICENSE_ERR_NULL       | -12    | Certificate 为空          |
| LICENSE_ERR            | -13    | 未知错误                  |

## on_warning 回调返回的警告代码

on_warning 回调中可能返回的警告代码和描述详见 [Agora Native SDK 警告代码表](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/namespaceagora.html#a32d042123993336be6646469da251b21)。

## on_error 回调返回的错误代码

on_error 回调中可能返回的错误代码和描述详见 [Agora Native SDK 错误代码表](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/namespaceagora.html#a8affb9bb02864d82c4333529dc3d75a1)。
