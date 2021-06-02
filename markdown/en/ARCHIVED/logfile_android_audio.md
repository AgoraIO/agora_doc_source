---
title: Set the Log File
platform: Android
updatedAt: 2019-02-20 15:51:46
---
## Introduction
The Agora Native SDK provides API methods for you to generate an output log file that records all the log data of the SDK operation. You can use the log filters in the order of OFF, CRITICAL, ERROR, WARNING, INFO and DEBUG to get the logs that you need. Select a level, and all the logs in the levels preceding this level are generated. For example, if you set the log filter as OFF, no log is generated, and if you set the log filter as WARNING, you see the logs in the CRITICAL, ERROR and WARNING levels.

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./android_audio).

```java
// set log filter to debug
engine.setLogFilter(LOG_FILTER_DEBUG);

// get document path and save to sdcard
// get current timestamp to separate log files
String ts = new SimpleDateFormat("yyyyMMdd").format(new Date());
String filepath = "/sdcard/" + ts + ".log";
File file = new File(filepath);
engine.setLogFile(filepath);
```

### API Reference

- [`setLogFile`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab25d55c7f95903ff09280e308a977c08)
- [`setLogFilter`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#abb16ab61cebb6c676e1aab61030c3181)