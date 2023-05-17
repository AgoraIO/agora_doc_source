屏幕共享带声音如何开启?
web端
1、该功能仅支持 Windows 和 macOS 平台下的 Chrome 浏览器 74 及以上版本。
Windows 平台支持在共享整个屏幕和共享 Chrome 标签页时分享音频，不支持在共享应用窗口时分享音频。macOS 平台仅支持在共享 Chrome 选中的标签页时分享音频。
2、在灵动课堂中设置了 withAudio 为 true 后，还需要在屏幕共享的弹出框上，勾选分享音频才能真正生效。

electron 端
1、windows electron 可以分享系统声音.

2.mac electorn需要通过虚拟声卡采集系统声音来分享系统声音。 如果用户使用虚拟声卡，如 Soundflower，可以将虚拟声卡名称 "soundflower" 作为参数传入，SDK 会找到对应的虚拟声卡设备，并开始采集。Note: macOS 系统默认声卡 不支持采集功能，如需开启此功能需要 App 自己启用一个虚拟声卡，并将该虚拟声卡的名字 作为 deviceName 传入 SDK。声网测试并推荐 soundflower 作为虚拟声卡。

2.1 mac electron 在灵动课堂的源码中默认关闭屏幕共享带声音的功能。如需开启该功能需要修改源码实现。（2.8.21以上实现）

修改代码如下：
1）在UI层显示屏幕共享带声音的选项
代码路径：
packages/agora-classroom-sdk/src/infra/capabilities/containers/dialog/screen-picker/index.tsx
代码如下：
<image src='./images/screensharewithaudio001.png'>

2） 在mac平台下传入虚拟声卡的名称
代码路径
packages/agora-classroom-sdk/src/infra/stores/common/toolbar/index.ts
代码如下：
<image src='./images/screensharewithaudio002.png'>



