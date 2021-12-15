---
title: 快速跑通示例项目
platform: Linux
updatedAt: 2021-03-29 04:05:01
---

## 前提条件

- 操作系统：Ubuntu 14.04 LTS 或以上
- CMake 2.8 或以上
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)

## 操作步骤

### 1. 创建 Agora 项目

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 Agora [控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入[项目管理](https://dashboard.agora.io/projects)页面。

2. 在**项目管理**页面，点击**创建**按钮。

   [![img](https://web-cdn.agora.io/docs-files/1594287028966)](https://dashboard.agora.io/projects)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **调试模式：APP ID。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

### 2. 获取 App ID

在控制台的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![](https://web-cdn.agora.io/docs-files/1612338943161)

### 3. 集成 Agora SDK

按照以下步骤将 Agora SDK 集成到示例项目中。

1. 下载 [RTM](https://github.com/AgoraIO/RTM) 仓库，找到 Agora-RTM-Tutorial-Linux-Server 示例项目文件夹。
2. 下载最新版[实时消息 Linux C++ SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads?platform=Linux) 并解压。
3. 将 SDK 包中的 `*.so` 文件复制到项目的 `lib` 目录下，将 `*.h` 文件复制到项目的 `include` 目录下。

### 4. 运行示例项目

按照以下步骤运行示例项目。

1. 在项目的根目录下，运行以下命令构建示例项目。

   ```shell
   ./build.sh build
   ```

2. 通过以下命令运行构建完成的示例项目。

   ```shell
   ./build/rtmServerDemo <Your App ID>
   ```
