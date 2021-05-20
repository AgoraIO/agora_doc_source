---
title: 如何设置日志文件？
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2021-03-22 09:18:54
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
Agora SDK 提供设置 SDK 的输出日志文件的功能，SDK 运行时产生的所有 log 将写入该文件。

## Native 平台

Native 平台包括 Android、iOS、macOS 和 Windows 平台。

### 设置日志文件

#### v3.3.0 之前

**设置日志文件路径**

为保证输出的日志完整，我们建议在创建并初始化 `RtcEngine` 后，就调用 `setLogFile` 方法设置日志文件。

默认情况下，SDK 会生成 `agorasdk.log`、`agorasdk_1.log`、`agorasdk_2.log`、`agorasdk_3.log`、`agorasdk_4.log` 这 5 个日志文件。 每个文件的默认大小为 1024 KB。日志文件为 UTF-8 编码。最新的日志永远写在 `agorasdk.log` 中。`agorasdk.log` 写满后，SDK 会从 1 - 4 中删除修改时间最早的一个文件，然后将 `agorasdk.log` 重命名为该文件，并建立新的 `agorasdk.log` 写入最新的日志。

各平台默认的日志文件输出地址如下：

- Android：`/storage/emulated/0/Android/data/<package name>/files/agorasdk.log`

- iOS：`App Sandbox/Library/Caches/agorasdk.log`

- macOS：` ～/Library/Logs/agorasdk.log`

  - 开启沙盒：`App Sandbox/Library/Logs/agorasdk.log`，如 `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`
  - 关闭沙盒：`～/Library/Logs/agorasdk.log`

- Windows：`C:\Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log`

你也可以通过 `setLogFile` 的 `filePath` 参数修改日志文件输出地址。

**设置日志输出等级**

调用 `setLogFilter` 方法设置日志的输出等级。选择一个级别，你就可以看到在该级别及之前所有级别的日志信息。

按照输出日志最全到最少排列：

- DEBUG 级别：输出所有的 API 日志。如果你想获取最完整的日志，可将日志级别设为该等级。
- INFO 级别：输出 CRITICAL、ERROR、WARNING、INFO 级别的日志。我们推荐你将日志级别设为该等级。
- WARNING 级别：仅输出 CRITICAL、ERROR、WARNING 级别的日志。
- ERROR 级别：仅输出 CRITICAL、ERROR 级别的日志。
- CRITICAL 级别：仅输出 CRITICAL 级别的日志。
- OFF：不输出任何日志。

**设置日志文件大小**

默认情况下，Agora SDK 会生成 5 个日志文件，每个文件默认大小为 1024 KB。如果希望增加日志文件大小，还可以调用 `setLogFileSize` 方法设置单个日志文件的大小。

**示例代码**

```java
// Java
// 将日志过滤器等级设置为 LOG_FILTER_DEBUG
engine.setLogFilter(LOG_FILTER_DEBUG);

// 获取在 SD 卡中的文件路径
// 获取时间戳
String ts = new SimpleDateFormat("yyyyMMdd").format(new Date());
String filepath = "/sdcard/" + ts + ".log";
File file = new File(filepath);
engine.setLogFile(filepath);
```

```oc
// Objective-C
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

```c++
// C++
TCHAR szAppFolder[MAX_PATH] = { 0 };
SHGetFolderPath(NULL, CSIDL_APPDATA, NULL, 0, szAppFolder);
_tcscat(szAppFolder, _T("\\AppName\\"));

if (!PathFileExists(szAppFolder)){
    // 如果没有目录，创建一个新目录
    CreateDirectory(szAppFolder, NULL);
}

if (PathFileExists(szAppFolder)){
    // 创建日志文件
    TCHAR szFile[MAX_PATH] = { 0 };
    SYSTEMTIME st = { 0 };
    GetLocalTime(&st);
    // 获取时间戳
    _stprintf_s(szFile, _T("%s%d%02d%02d_%02d%02d%02d.log"), szAppFolder, st.wYear, st.wMonth, st.wDay, st.wHour, st.wMinute, st.wSecond);
    HANDLE hFile = CreateFile(szFile, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, 0, NULL);
    if (INVALID_HANDLE_VALUE != hFile){
        CloseHandle(hFile);
        char logFullPath[MAX_PATH] = { 0 };
        ::WideCharToMultiByte(CP_UTF8, 0, szFile, -1, logFullPath, MAX_PATH, NULL, NULL);
        RtcEngineParameters rep(*engine);
        rep.setLogFile(logFullPath);
    }
}
```

#### v3.3.0 及以后

在创建并初始化 `RtcEngine` 时，使用 `mLogConfig` 参数设置日志文件。

**设置日志文件路径**

默认情况下，SDK 会生成 `agorasdk.log`、`agorasdk_1.log`、`agorasdk_2.log`、`agorasdk_3.log`、`agorasdk_4.log` 这 5 个日志文件。 每个文件的默认大小为 1024 KB。日志文件为 UTF-8 编码。最新的日志永远写在 `agorasdk.log` 中。`agorasdk.log` 写满后，SDK 会从 1-4 中删除修改时间最早的一个文件，然后将 `agorasdk.log` 重命名为该文件，并建立新的 `agorasdk.log` 写入最新的日志。

各平台默认的日志文件输出地址如下：

- Android：`/storage/emulated/0/Android/data/<package name>/files/agorasdk.log`
- iOS：`App Sandbox/Library/Caches/agorasdk.log`
- macOS：`～/Library/Logs/agorasdk.log`
  - 开启沙盒：`App Sandbox/Library/Logs/agorasdk.log`，如 `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`
  - 关闭沙盒：`～/Library/Logs/agorasdk.log`
- Windows：`C:\Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log`

**设置日志输出等级**

使用 `mLogConfig` 参数中的 `level` 字段设置日志输出等级。选择一个级别，你就可以看到在该级别及之前所有级别的日志信息。

- INFO 级别: （默认）输出 FATAL、ERROR、WARN、INFO 级别的日志。我们推荐你将日志级别设为该等级。
- WARN 级别: 仅输出 FATAL、ERROR、WARN 级别的日志。
- ERROR 级别: 仅输出 FATAL、ERROR 级别的日志。
- FATAL 级别: 仅输出 FATAL 级别的日志。
- NONE 级别: 不输出任何日志。

**设置日志文件大小**

默认情况下，Agora SDK 会生成 5 个日志文件，每个文件默认大小为 1024 KB。如果希望增加日志文件大小，可以使用 `mLogConfig` 参数中的 `fileSize `字段设置单个日志文件的大小。

**示例代码**

```java
// Java

RtcEngineConfig.LogConfig logConfig = new RtcEngineConfig.LogConfig();
// 将日志过滤器等级设置为 ERROR
logConfig.level = Constants.LogLevel.getValue(Constants.LogLevel.LOG_LEVEL_ERROR);
// 设置 log 的文件路径
String ts = new SimpleDateFormat("yyyyMMdd").format(new Date());
logConfig.filePath = "/sdcard/" + ts + ".log";
// 设置 log 的文件大小为 2MB
logConfig.fileSize = 2048;

RtcEngineConfig config = new RtcEngineConfig();
config.mAppId = getString(R.string.agora_app_id);
config.mEventHandler = iRtcEngineEventHandler;
config.mContext = context.getApplicationContext();
config.mAreaCode = getAreaCode();
config.mLogConfig = logConfig;

mRtcEngine = RtcEngine.create(config);
```

```oc
// Swift
let logConfig = AgoraLogConfig()
// 将日志过滤器等级设置为 ERROR
logConfig.level = AgoraLogLevel.error
// 设置 log 的文件路径
let formatter = DateFormatter()
formatter.dateFormat = "ddMMyyyyHHmm"
let folder = NSSearchPathForDirectoriesInDomains(.documentDirectoryuserDomainMask, true)
logConfig.filePath = "\(folder[0])/logs/\(formatter.string(from: Date())).log"
// 设置 log 的文件大小为 2MB
logConfig.fileSize = 2 * 1024

let config = AgoraRtcEngineConfig()
config.appId = KeyCenter.AppId
config.areaCode = GlobalSettings.shared.area.rawValue
config.logConfig = logConfig
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)    
```

```c++
// C++
LogConfig logConfig;
// 将日志过滤器等级设置为 ERROR
logConfig.level = LOG_LEVEL::LOG_LEVEL_ERROR;
// 设置 log 的文件路径
time_t rawtime;
struct tm * timeinfo;
char buffer[128];
time(&rawtime);
timeinfo = localtime(&rawtime);
strftime(buffer, sizeof(buffer), "c:\\log\\%Y%m%d.log", timeinfo);
logConfig.filePath = buffer;
// 设置 log 文件的大小为 2MB
logConfig.fileSize = 2048;

RtcEngineContext context;
context.logConfig = logConfig;
std::string strAppID = GET_APP_ID;
context.appId = strAppID.c_str();
context.eventHandler = &m_eventHandler;
//initialize the Agora RTC engine context.
int ret = m_rtcEngine->initialize(context);
```



**API 参考**

- Android
  - [create](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a45832a91b1051bc7641ccd8958288dba)[2/2]
- iOS/macOS
  - [sharedEngineWithConfig](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithConfig:delegate:)
- Windows
  - [initialize](https://docs.agora.io/cn/Video/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac71db65e66942e4e0a0550e95c16890f)



### 获取堆栈信息

发生 crash 时会告知产生 crash 的堆栈信息。各平台获取堆栈信息的方法如下：

- Android 平台：运行 `adb bugreport` 命令
iOS：**XCode** → **window** → **Devices→** 选中相关设备 → 选中相应应用 → 应用列表下方设置按键 → **Download Container** → 已下载文件右键选择显示包内容 → **AppData** → **Library** → **Caches** → **agorasdk.log**
- macOS：`~/Library/Logs/DiagnosticReports/`
- Windows: 需要抓取 dump 文件。可参考：
  - [WinDbg 抓取程序报错 dump 文件的方法](https://www.cnblogs.com/jinjiangongzuoshi/p/4268467.html)
  - [WinDbg 如何抓取 dump 文件](https://blog.csdn.net/wojiuguowei/article/details/78860699)

在 Android 和 iOS 平台，如果你在 app 中集成了 Bugly，可以直接通过 Bugly 获取。

## Web 平台

详见[如何设置日志？](https://docs.agora.io/cn/agora-class/faq/logfile_web)