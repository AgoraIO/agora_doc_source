---
title: 设置日志文件
platform: iOS
updatedAt: 2019-07-05 15:03:16
---

## 功能描述

Agora Native SDK 提供设置 SDK 的输出日志文件的功能，SDK 运行时产生的所有 log 将写入该文件。

在调试你的应用时，你也可以设置日志的输出等级，顺序依次为 OFF、CRITICAL、ERROR、WARNING、INFO 和 DEBUG。选择一个级别后，会输出该级别及之前所有级别的日志信息。例如，选择 OFF 级别表示不输出任何日志；选择 WARNING 级别，表示输出 CRITICAL、ERROR 和 WARNING 级别上的所有日志信息。

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./ios_video)。

```Objective-C
// 将日志输出等级设置为 AgoraLogFilterDebug
[engine setLogFilter: AgoraLogFilterDebug];

// 获取当前目录
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
// 获取文件路径
// 获取时间戳
NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
[formatter setDateFormat:@"ddMMyyyyHHmm"];
NSDate *currentDate = [NSDate date];
NSString *dateString = [formatter stringFromDate:currentDate];
NSString *logFilePath = [NSString stringWithFormat:@"%@/%@.log", [paths objectAtIndex:0], dateString];
// 设置日志文件的默认地址
[engine setLogFile:logFilePath]
```

### API 参考

- [`setLogFile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=9fa366f0-01e7-11e9-a659-33e4b5b761ac#//api/name/setLogFile:)
- [`setLogFilter`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=9fa366f0-01e7-11e9-a659-33e4b5b761ac#//api/name/setLogFilter:)

## 开发注意事项

- iOS 平台日志文件的默认地址为 App Sandbox/Library/caches/agorasdk.log。
- 如需调用本方法，请在调用 [sharedEngineWithAppId](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:) 方法初始化 AgoraRtcEngineKit 对象后立即调用，否则可能造成输出日志不完整。
