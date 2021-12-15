---
title: 如何处理录制 SDK 集成问题？
platform: ["Linux"]
updatedAt: 2020-08-19 18:00:46
Products: ["Recording"]
---

### Java SDK 集成时报错 java.land.UnsatisfiedLinkError: no recording in java.library.path

报错原因：系统环境找不到 `librecording.so` 库文件。

解决方法：确认 Java demo 是否成功编译并生成了库文件，查看并配置库文件的位置。

例如，若库文件位置为 `/home/user/Desktop/tool/Agora_Recording/samples/java/bin/io/agora/recording/librecording.so`，则在 Linux 系统下，在 `/etc/profile` 或者 `~/.bash_profile`、`~/.bashrc` 下配置 `LD_LIBRARY_PATH` ：

```
LD_LIBRARY_PATH=/home/user/Desktop/tool/Agora_Recording/samples/java/bin/io/agora/recording/librecording.so
```

### 如何知道录制程序是正常退出频道，还是异常退出频道?

如果是正常退出频道，首先 SDK 会触发 `onLeaveChannel`，并会返回错误码 `ERR_OK = 1`。
如果是异常退出频道，SDK 不会触发 `onLeaveChannel`，而是触发 `onError` 并返回错误码 `ERR_INTERNAL_FAILED = 3`。
