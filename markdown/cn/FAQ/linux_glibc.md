---
title: Linux C++ 平台和 Linux Java 平台的 glibc 版本要求是什么样的？
platform: ["Linux"]
updatedAt: 2019-10-15 14:59:16
Products: ["Real-time-Messaging"]
---
glibc 版本必须至少为 2.14，否则会出现 so 库加载错误（报错"version 'GLIBC_2.14' not found" 或 “NoClassDefFoundError")，可尝试通过升级 glibc 版本解决