---
title: 设置日志文件
platform: Android
updatedAt: 2019-07-05 12:07:53
---

## 功能简介

Agora Native SDK 提供设置 SDK 的输出日志文件的功能，SDK 运行时产生的所有 log 将写入该文件。

在调试你的应用时，你也可以设置日志的输出等级，顺序依次为 OFF、CRITICAL、ERROR、WARNING、INFO 和 DEBUG。选择一个级别后，会输出该级别及之前所有级别的日志信息。例如，选择 OFF 级别表示不输出任何日志；选择 WARNING 级别，表示输出 CRITICAL、ERROR 和 WARNING 级别上的所有日志信息。

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端 ](./android_video)。

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

## API 参考

- [`setLogFile`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html?transId=ea42f050-0759-11e9-aad5-0347068be2f5#ab25d55c7f95903ff09280e308a977c08)
- [`setLogFilter`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html?transId=ea42f050-0759-11e9-aad5-0347068be2f5#abb16ab61cebb6c676e1aab61030c3181)
