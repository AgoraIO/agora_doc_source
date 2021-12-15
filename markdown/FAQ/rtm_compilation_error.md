---
title: 为什么我在编译 Agora RTM Linux Java SDK 时出现错误？
platform: ["Linux"]
updatedAt: 2020-05-06 16:33:08
Products: ["Real-time-Messaging"]
---

## 问题描述

在 Linux 平台上编译 Agora RTM Linux Java SDK 时出现以下错误：

```java
Exception in thread “main” java.lang.UnsatisfiedLinkError:no agora_rtm_sdk in java.library.path
```

## 问题原因

`agora_rtm_sdk` 库没有加入环境变量。

## 解决方案

你可以使用下面任意一种方案解决这个问题。对于每种方案，你都必须将 `<path>` 修改为 RTM Linux Java SDK 所在的路径。

### 修改环境变量

在设置 Linux 环境变量的文件（例如 `~/.bashrc`、`~/bash_profile`、或者 `/etc/profile`）中，添加如下代码：

```shell
export LD_LIBRARY_PATH=<path>/agora/rtm/sdk:$LD_LIBRARY_PATH
```

### 修改 Java 运行参数

你可以在运行 Java 时使用 `Djava.library.path` 参数，把 RTM Linux Java SDK 所在的路径添加到库文件路径：

```shell
java -Djava.library.path=<path>/agora/rtm/sdk
```
