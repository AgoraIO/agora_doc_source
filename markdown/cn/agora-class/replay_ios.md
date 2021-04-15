---
title: 录制回放
platform: iOS
updatedAt: 2021-01-20 09:56:36
---
## 功能描述

声网灵动课堂支持录制功能。老师可在课堂中开启录制。老师的音视频流、白板内容、课件内容同步录制，需要录制至少 15 秒。录制结束后可以提供回放链接供学生课后复习。

你可参考本文调用 API 直接进入声网灵动课堂的录制回放页面。

## 实现方式

参考以下步骤调用 API 直接进入声网灵动课堂的录制回放页面：

<div class="alert note">开始前请确保你完成<a href="./agora_class_prep">接入前准备工作</a>并根据<a href="./agora_class_quickstart_ios">快速接入文档</a>集成了 Agora Edu SDK。</div>

1. 通过[获取录制列表 RESTful](./agora_class_restful_api#获取录制列表) 获取指定课堂内的录制信息。

2. 创建 `AgoraEduReplayConfig` 实例进行录制回放配置，然后调用 `replay` 方法传入该实例。`AgoraEduReplayConfig` 实例包含以下参数：

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
/**录制回放配置*/
@interface AgoraEduReplayConfig : NSObject
// 白板的 App ID
@property (nonatomic, copy) NSString *whiteBoardAppId;
// 白板 ID
@property (nonatomic, copy) NSString *whiteBoardId;
// 白板的 token
@property (nonatomic, copy) NSString *whiteBoardToken;
// 视频 URL 地址
@property (nonatomic, copy) NSString *videoUrl;
// 录制的开始时间戳，单位毫秒
@property (nonatomic, assign) NSInteger beginTime;
// 录制的结束时间戳，单位毫秒
@property (nonatomic, assign) NSInteger endTime;
- (instancetype)initWithBoardAppId:(NSString *)whiteBoardAppId boardId:(NSString *)whiteBoardId boardToken:(NSString *)whiteBoardToken videoUrl:(NSString *)videoUrl beginTime:(NSInteger)beginTime endTime:(NSInteger)endTime;
@end
  
/**进入录制回放页面*/
AgoraEduReplayConfig *config = [[AgoraEduReplayConfig alloc] initWithBoardAppId:whiteBoardAppId boardId:whiteBoardId boardToken:whiteBoardToken videoUrl:videoUrl beginTime:beginTime endTime:endTime];
 
[AgoraEduSDK replay:config delegate:self];
```