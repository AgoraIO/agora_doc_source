---
title: Set the Log File
platform: iOS
updatedAt: 2019-02-20 15:51:53
---
## Introduction
The Agora Native SDK provides API methods for you to generate an output log file that records all the log data of the SDK operation. You can use the log filters in the order of OFF, CRITICAL, ERROR, WARNING, INFO and DEBUG to get the logs that you need. Select a level, and all the logs in the levels preceding this level are generated. For example, if you set the log filter as OFF, no log is generated, and if you set the log filter as WARNING, you see the logs in the CRITICAL, ERROR and WARNING levels.

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./ios_audio).

```Objective-C
// set log filter to debug
[engine setLogFilter: AgoraLogFilterDebug];

// get document path
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
// get file path
// get current timestamp to separate log files
NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
[formatter setDateFormat:@"ddMMyyyyHHmm"];
NSDate *currentDate = [NSDate date];
NSString *dateString = [formatter stringFromDate:currentDate];
NSString *logFilePath = [NSString stringWithFormat:@"%@/%@.log", [paths objectAtIndex:0], dateString];
// set log file path
[engine setLogFile:logFilePath]
```

### API Reference

- [`setLogFile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=8d992290-01c1-11e9-a659-33e4b5b761ac#//api/name/setLogFile:)
- [`setLogFilter`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html?transId=8d992290-01c1-11e9-a659-33e4b5b761ac#//api/name/setLogFilter:)