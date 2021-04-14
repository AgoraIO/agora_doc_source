---
title: 录制回放
platform: Electron
updatedAt: 2021-03-05 03:44:55
---
## 功能描述

声网灵动课堂支持录制功能。老师可在课堂中开启录制。老师的音视频流、白板内容、课件内容同步录制，需要录制至少 15 秒。录制结束后可以提供回放链接供学生课后复习。

你可参考本文调用 API 直接进入声网灵动课堂的录制回放页面。

## 实现方式

参考以下步骤调用 API 直接进入声网灵动课堂的录制回放页面：

<div class="alert note">开始前请确保你完成<a href="./agora_class_prep">接入前准备工作</a>并根据<a href="./agora_class_quickstart_electron">快速接入文档</a>集成了 Agora Edu SDK。</div>

1. 通过[获取录制列表 RESTful](./agora_class_restful_api#获取录制列表) 获取指定课堂内的录制信息。

2. 在客户端调用 Agora Edu SDK 的 `replay` 方法即可进入声网灵动课堂的录制回放页面。在该方法中，你需要设置以下参数：

   | 参数              | 类型   | 描述                                |
   | :---------------- | :----- | :---------------------------------- |
   | `videoUrl`        | string | 录制文件的访问地址。                |
   | `whiteBoardAppId` | string | Netless 白板服务的 AppIdentifier。  |
   | `whiteBoardId`    | string | 白板的唯一标识符。                  |
   | `whiteBoardToken` | string | Netless 白板服务的 sdkToken。       |
   | `beginTime`       | number | 录制开始的 UTC 时间戳，单位为毫秒。 |
   | `endTime`         | number | 录制结束的 UTC 时间戳，单位为毫秒。 |

   示例代码：
	 ```
// 进入录制回放页面
AgoraEduSDK.replay(
  // 放置教育应用的 DOM 节点
  document.querySelector("#root1"),
    {
      videoUrl: 'xxxxx',
      whiteBoardAppId: '<your_whiteboard_appid>',
      whiteBoardId: '<your_whiteboard_id>',
      whiteBoardToken: '<your_whiteboard_token>',
      beginTime: 1610175714670,
      endTime: 1610175740465,
      listener: (state) => {
        document.title = state
        console.log("state ", state)
      }
    }
)
```