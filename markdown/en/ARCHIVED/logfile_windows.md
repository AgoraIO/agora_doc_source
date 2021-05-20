---
title: Set the Log File
platform: Windows
updatedAt: 2020-03-03 16:20:49
---
## Introduction
The Agora Native SDK provides API methods for you to generate an output log file that records all the log data of the SDK operation. You can use the log filters in the order of OFF, CRITICAL, ERROR, WARNING, INFO and DEBUG to get the logs that you need. Select a level, and all the logs in the levels preceding this level are generated. For example, if you set the log filter as OFF, no log is generated, and if you set the log filter as WARNING, you see the logs in the CRITICAL, ERROR and WARNING levels.

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./android_video).

```C++

TCHAR szAppFolder[MAX_PATH] = { 0 };
SHGetFolderPath(NULL, CSIDL_APPDATA, NULL, 0, szAppFolder);
_tcscat(szAppFolder, _T("\\AppName\\"));

if (!PathFileExists(szAppFolder)){
	// create directory if not exists
	CreateDirectory(szAppFolder, NULL);
}

if (PathFileExists(szAppFolder)){
	// create file
	TCHAR szFile[MAX_PATH] = { 0 };
	SYSTEMTIME st = { 0 };
	GetLocalTime(&st);
	// Use timestamp to separate log files
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

## API Reference

- [`setLogFile`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html?transId=534dd520-0344-11e9-bbd0-251679929d6b#a0e11f89f5b900279ed82a9d4fa9eb18a)
- [`setLogFilter`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html?transId=534dd520-0344-11e9-bbd0-251679929d6b#a169cd86502290529b02eaf6748a63f2a)

## Considerations

Ensure that you call this method immediately after calling the [create](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac71db65e66942e4e0a0550e95c16890f) method, otherwise the output log may not be complete.