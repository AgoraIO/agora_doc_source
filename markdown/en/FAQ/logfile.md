---
title: How can I set the log file?
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2021-03-22 09:37:43
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
The Agora SDK provides API methods for you to generate an output log file that records all the log data of the SDK operation.

## Native 

The native platform includes Android, iOS, macOS, and Windows.

### Set the log file

#### Before v3.3.0

**Set the log file path**

To ensure that the output log is complete, we recommend calling the `setLogFile` method to set the log file immediately after you create and initialize `RtcEngine`.

By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with a default size of 1024 KB. These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes the log file with the earliest modification time among the other four, renames `agorasdk.log` to the name of the deleted log file, and creates a new `agorasdk.log` to record latest logs.

The default output log file path for each platform is as follows:

- Android: `/storage/emulated/0/Android/data/<package name>/files/agorasdk.log`
- iOS：`App Sandbox/Library/Caches/agorasdk.log`
- macOS: `～/Library/Logs/agorasdk.log`
  - Sandbox enabled: `App Sandbox/Library/Logs/agorasdk.log`, such as `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`
  - Sandbox disabled: `～/Library/Logs/agorasdk.log`
- Windows：`C:\Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log`

You can change the directory for the log files by setting the `filePath` parameter when calling `setLogFile`.

**Set the log output level**

You can call the `setLogFilter` method to set the output log level. Select a level, and all the logs in the levels preceding this level are generated.

- DEBUG: Outputs all API logs. Set your log filter as DEBUG if you want to get the most complete log file.
- INFO: Outputs logs of the CRITICAL, ERROR, WARNING, and INFO level. We recommend setting your log filter as this level.
- WARNING: Outputs logs of the CRITICAL, ERROR, and WARNING level.
- ERROR: Outputs logs of the CRITICAL and ERROR level.
- CRITICAL: Outputs logs of the CRITICAL level.
- OFF: Outputs no log.

**Set the log file size**

The Agora SDK has five log files, each with a default size of 1024 KB. Call the `setLogFileSize` method if you want to increase the size of each log file.

**Sample code**

```java
// Java
// Set the log filter to debug
engine.setLogFilter(LOG_FILTER_DEBUG);

// Get the document path and save to sdcard
// Get the current timestamp to separate log files
String ts = new SimpleDateFormat("yyyyMMdd").format(new Date());
String filepath = "/sdcard/" + ts + ".log";
File file = new File(filepath);
engine.setLogFile(filepath);
```

```oc
// Objective-C
// Set the log filter to debug
[engine setLogFilter: AgoraLogFilterDebug];

// Get the document path
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
// Get the file path
// Get the current timestamp to separate log files
NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
[formatter setDateFormat:@"ddMMyyyyHHmm"];
NSDate *currentDate = [NSDate date];
NSString *dateString = [formatter stringFromDate:currentDate];
NSString *logFilePath = [NSString stringWithFormat:@"%@/%@.log", [paths objectAtIndex:0], dateString];
// Set the log file path
[engine setLogFile:logFilePath]
```

```c++
// C++
TCHAR szAppFolder[MAX_PATH] = { 0 };
SHGetFolderPath(NULL, CSIDL_APPDATA, NULL, 0, szAppFolder);
_tcscat(szAppFolder, _T("\\AppName\\"));

if (!PathFileExists(szAppFolder)){
    // Create a directory if it does not exist
    CreateDirectory(szAppFolder, NULL);
}

if (PathFileExists(szAppFolder)){
    // Create a file
    TCHAR szFile[MAX_PATH] = { 0 };
    SYSTEMTIME st = { 0 };
    GetLocalTime(&st);
    // Use the timestamp to separate log files
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

#### v3.3.0 and later

Use the `mLogConfig` parameter to set the log file immediately after you create and initialize `RtcEngine`.

**Set the log file path**

By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with a default size of 1024 KB. These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes the log file with the earliest modification time among the other four, renames `agorasdk.log` to the name of the deleted log file, and creates a new `agorasdk.log` to record latest logs.

The default output log file path for each platform is as follows:

- Android：`/storage/emulated/0/Android/data/<package name>/files/agorasdk.log`
- iOS：`App Sandbox/Library/Caches/agorasdk.log`
- macOS：`～/Library/Logs/agorasdk.log`
  - Sandbox enabled: `App Sandbox/Library/Logs/agorasdk.log`, such as `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`
  - Sandbox disabled: `～/Library/Logs/agorasdk.log`
- Windows：`C:\Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log`

**Set the log output level**

You can use the `level` parameter in `mLogConfig` to set the output log level. Select a level, and all the logs in the levels preceding this level are generated.

- INFO: (Default) Outputs logs of the FATAL, ERROR, WARN, and INFO level. We recommend setting your log filter as this level.
- WARN: Outputs logs of the FATAL, ERROR, and WARN level.
- ERROR: Outputs logs of the FATAL and ERROR level.
- FATAL: Outputs logs of the FATAL level.
- NONE: Do not output any log.



**Set the log file size**

The Agora SDK has five log files, each with a default size of 1024 KB. Use the `fileSize` parameter in `mLogConfig` to set the size of each log file.

**Sample code**

```java
// Java
RtcEngineConfig.LogConfig logConfig = new RtcEngineConfig.LogConfig();
// Set the log filter to ERROR
logConfig.level = Constants.LogLevel.getValue(Constants.LogLevel.LOG_LEVEL_ERROR);
// Set the log file path
String ts = new SimpleDateFormat("yyyyMMdd").format(new Date());
logConfig.filePath = "/sdcard/" + ts + ".log";
// Set the log file size to 2 MB
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
// Set the log filter to ERROR
logConfig.level = AgoraLogLevel.error
// Set the log file path
let formatter = DateFormatter()
formatter.dateFormat = "ddMMyyyyHHmm"
let folder = NSSearchPathForDirectoriesInDomains(.documentDirectoryuserDomainMask, true)
logConfig.filePath = "\(folder[0])/logs/\(formatter.string(from: Date())).log"
// Set the log file size to 2 MB
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
// Set the log filter to ERROR
logConfig.level = LOG_LEVEL::LOG_LEVEL_ERROR;
// Set the log file path
time_t rawtime;
struct tm * timeinfo;
char buffer[128];
time(&rawtime);
timeinfo = localtime(&rawtime);
strftime(buffer, sizeof(buffer), "c:\\log\\%Y%m%d.log", timeinfo);
logConfig.filePath = buffer;
// Set the log file size to 2 MB
logConfig.fileSize = 2048;

RtcEngineContext context;
context.logConfig = logConfig;
std::string strAppID = GET_APP_ID;
context.appId = strAppID.c_str();
context.eventHandler = &m_eventHandler;
// Initialize the Agora RTC engine context.
int ret = m_rtcEngine->initialize(context);
```


**API reference**

- Android
  - [create](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a45832a91b1051bc7641ccd8958288dba)[2/2]
- iOS/macOS
  - [sharedEngineWithConfig](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithConfig:delegate:)
- Windows
  - [initialize](https://docs.agora.io/cn/Video/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac71db65e66942e4e0a0550e95c16890f)


### Get the stack information

You can also get the stack information when crashes occur:

- Android: Run the `adb bugreport` command
- iOS：**Xcode** → **window** → **Devices→** Select the corresponding device → Select the corresponding app → Click the Settings button below the app list → **Download Container** → Right click the downloaded file and select **Show Package Contents** → **AppData** → **Library** → **Caches** → **agorasdk.log**
- macOS: `~/Library/Logs/DiagnosticReports/`
- Windows: Need to capture dump files

On Android and iOS, if you have integrated Bugly in your app, you cal also use Bugly to get the stack information.
## Web

See [How can I set the logs?](https://docs.agora.io/en/Interactive%20Broadcast/faq/logfile_web)


