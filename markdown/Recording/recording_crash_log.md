---
title: 收集崩溃日志
platform: Linux
updatedAt: 2019-12-24 14:04:06
---

## 概述

Agora 建议你在集成本地服务端录制前，使用我们提供的 `create_core.sh` 脚本开启系统 core dump 功能，以便在后续录制出现问题时，能够快速调查和定位问题，提高问题解决效率。

## 实现方法

首先，你可在 Linux 系统中执行 `ulimit -c` 命令查看是否已开启 core dump。输出结果如果为 0，则说明 core dump 没有打开。

参考以下步骤在 Linux 系统中开启 core dump 功能。

### 1.获取脚本

点击此处获取 `create_core.sh` 脚本。

### 2.执行脚本

打开终端，运行以下命令执行 `create_core.sh` 脚本打开 core dump：

```
sudo ./create_core.sh
```

生成的 core 文件将位于 `/var/corefile` 目录下，文件名格式为 “core-程序文件名-生成 core 文件时收到的信号-进程用户 ID-进程用户组 ID-进程号-生成 core 文件的时间戳”

如果你是在 docker 中跑录制进程，则运行以下命令：

```
docker run --ulimit core=-1 --security-opt seccomp=unconfined --privileged=true
```

| 参数                                | 描述                         |
| ----------------------------------- | ---------------------------- |
| `--ulimit core=-1`                  | 不限制 coredump 大小         |
| `--security-opt seccomp=unconfined` | 允许容器执行全部系统调用     |
| `--privileged=true`                 | 允许 createdump 访问其他进程 |

## 注意事项

- 运行一次该脚本后，Linux 重启脚本依然生效。
- 如果你集成的是本地服务端录制 SDK 2.2.3 及之后版本，会在 `AgoraCoreService` 所在目录下生成 `recording_crash.log`，作为崩溃问题分析的辅助文件。
