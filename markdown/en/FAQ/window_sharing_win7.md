---
title: How can I handle the window-sharing issue on Windows 7?
platform: ["Windows"]
updatedAt: 2021-04-07 07:27:53
Products: ["Video","Interactive Broadcast","live-streaming"]
---
## Problem

When sharing a File Explorer window on Windows 7, the color of the search box of the shared window may appear abnormal (black) to remote users.


When sharing a File Explorer window on Windows 7, if the local user stretches or shrinks the height of the window, the search box of the shared window may appear abnormal.


## Reason

When you enable the Aero theme effect on Windows 7, the window has the [WS_EX_LAYERED](https://docs.microsoft.com/en-us/windows/win32/winmsg/extended-window-styles) attribute. As a result, the window image that the Agora SDK gets by GDI (Graphics Device Interface) DC (Device Context) is black.

## Solution

To solve this problem caused by the Aero theme effect of the Windows operating system, Agora recommends the following steps.

1. Determine the version of the Windows operating system before you start window sharing. If it is Windows 7, load the DWM (Desktop Window Manager) API, as follows:

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

2. Determine whether the Aero theme effect is enabled on Windows 7. If so, disable the Aero theme effect, as follows:

    ```cpp
    BOOL result = FALSE;
    if (is_composition_enabled_func_)
        is_composition_enabled_func_(&result);
    if(result) {
        if (composition_func_）
            (*composition_func_)(DWM_EC_DISABLECOMPOSITION);
    }
    ```

3. Start window sharing.

4. Once you have stopped window sharing, you can restore the Aero theme effect, as follows:

    ```cpp
    if (composition_func_）
        (*composition_func_)(DWM_EC_ENABLECOMPOSITION);
    ```
