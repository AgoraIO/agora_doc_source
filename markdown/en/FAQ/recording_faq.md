---
title: How can I solve Recording integration issues?
platform: ["Linux"]
updatedAt: 2020-07-09 11:06:41
Products: ["Recording"]
---
### When I integrate the Java SDK, the error java.land.UnsatisfiedLinkError: no recording in java.library.path occurs. How do I fix it?

Reason: The system environment cannot find the `librecording.so ` file.
Solution: Check if the java demo is compiled and the library file is generated, and then, check and configure the path of the library file.
For example, on Linux, if the path of the library file is `/home/user/Desktop/tool/Agora_Recording/samples/java/bin/io/agora/recording/librecording.so`, configure `LD_LIBRARY_PATH` in `/etc/profile`, `~/.bash_profile` or `~/.bashrc` as follows:

```bash
LD_LIBRARY_PATH=/home/user/Desktop/tool/Agora_Recording/samples/java/bin/io/agora/recording/librecording.so
```

### How can I tell whether or not the recording application left the channel?

The recording application left the channel if the SDK triggers the `onLeaveChannel` callback and returns the error code ERR_OK = 1.

The recording application failed to leave the channel If the SDK triggers the `onError` callback instead of the `onLeaveChannel` callback and returns the error code ERR_INTERNAL_FAILED = 3.