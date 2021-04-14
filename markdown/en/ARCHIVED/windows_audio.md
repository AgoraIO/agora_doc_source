---
title: Integrate the SDK
platform: Windows
updatedAt: 2020-10-20 14:42:33
---
## Prerequisites

-   OS: Microsoft Windows 7+
-   Compiler: Microsoft Visual C++ 2013+
-   Development environment: Microsoft Visual Studio 2013 (Recommended)

> If you use Microsoft Visual Studio 2013+, you may encounter compatibility issues.

## Add the Agora SDK to Your Project

1.  Download the [Windows Voice SDK](https://docs.agora.io/en/Agora%20Platform/downloads), and unzip it.
2.  Add the `sdk/include` folder to the INCLUDE directory of your project.
3.  Add the `sdk/lib` folder to the LIB directory of your project, and ensure that agora_rtc_sdk.lib is linked to your project.
4.  Copy all *dll* files under `sdk/dll`  to the directory of your executable file.

## Next Steps
You have set up the Windows development environment and can start a call/live broadcast following the steps under **Quickstart Guide**:
- Initialize the SDK
- Join a Channel
- Publish and Subscribe to Streams


