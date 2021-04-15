---
title: 如何处理 Windows 7 窗口共享异常？
platform: ["Windows"]
updatedAt: 2021-04-07 07:25:34
Products: ["Video","Interactive Broadcast","live-streaming"]
---
## 问题描述

在 Windows 7 版本上共享文件资源管理器窗口时，远端用户看到的共享窗口的搜索框颜色可能异常（黑色）。
在 Windows 7 版本上共享文件资源管理器窗口时，当本地用户拉长或缩小窗口高度，远端用户看到的共享窗口的搜索框可能显示异常。


## 问题原因

Windows 7 系统中开启 Aero 主题特效时，窗口具有 [WS_EX_LAYERED](https://docs.microsoft.com/en-us/windows/win32/winmsg/extended-window-styles) 属性，Agora SDK 通过 GDI（Graphics Device Interface）DC（Device Context）拷贝方式拿到的窗口图像为黑色。

## 解决方案

该问题由 Windows 系统的 Aero 主题引起。Agora 推荐你按照如下步骤关闭该主题以解决问题。

1. 开启窗口共享前，判断系统版本。如果系统版本为 Windows 7，加载 DWM（Desktop Window Manager）API：

    ```cpp
    typedef HRESULT(WINAPI* DwmEnableCompositionFunc)(UINT);
    typedef HRESULT(WINAPI* DwmIsCompositionEnabledFunc)(BOOL* pfEnabled);

    DwmIsCompositionEnabledFunc is_composition_enabled_func_;
    DwmEnableCompositionFunc composition_func_;

    HMODULE dwmapi_library_ = LoadLibrary(L"dwmapi.dll");
    if (dwmapi_library_) {
        is_composition_enabled_func_ = reinterpret_cast<DwmIsCompositionEnabledFunc>(
              GetProcAddress(dwmapi_library_, "DwmIsCompositionEnabled"));
        composition_func_ = reinterpret_cast<DwmEnableCompositionFunc>(
              GetProcAddress(dwmapi_library_, "DwmEnableComposition"));
    }
    ```

2. 判断 Window 7 系统上是否开启 Aero 主题特效。如果开启，则关闭 Aero 主题特效：

    ```cpp
    BOOL result = FALSE;
    if (is_composition_enabled_func_)
        is_composition_enabled_func_(&result);
    if(result) {
        if (composition_func_）
            (*composition_func_)(DWM_EC_DISABLECOMPOSITION);
    }
    ```

3. 开启窗口共享。

4. 结束窗口共享。复原 Window 7 系统上的 Aero 主题特效：

    ```cpp
    if (composition_func_）
        (*composition_func_)(DWM_EC_ENABLECOMPOSITION);
    ```
