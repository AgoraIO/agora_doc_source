---
title: 设置日志文件
platform: Windows
updatedAt: 2019-07-05 12:14:57
---

## 功能简介

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./windows_video)。

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

## API 参考
