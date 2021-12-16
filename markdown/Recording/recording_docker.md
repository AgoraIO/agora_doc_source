---
title: 使用云容器部署录制 SDK
platform: Linux
updatedAt: 2020-11-27 08:09:13
---
我们推荐使用云容器（云主机 + Docker）的方式部署录制 SDK。使用这种方式，你无需管理底层服务器，只要提供打包好的镜像，即可运行容器，并仅为容器实际运行消耗的资源付费，可以节约成本。本文以阿里云[弹性容器实例](https://help.aliyun.com/product/87486.html)（Elastic Container Instance）为例介绍具体的部署方法，你也可以选择其他的云容器实例服务。

## 前提条件

- 安装 [Docker](https://docs.docker.com/install/) 环境
- 下载[录制 SDK](http://download.agora.io/sdk/release/Agora_Recording_SDK_for_Linux_v2_3_3_FULL.tar.gz)

## 制作容器

1. 新建一个 Dockerfile，内容如下：

   ```
   FROM ubuntu:18.04
   MAINTAINER your name
   
   # Create app directory
   WORKDIR /usr/src/recording
   
   # Install your dependencies
   
   # Copy your exec file
   COPY AgoraCoreService ./
   COPY recorder ./
   ```

2. 将下载的 SDK 包中 AgoraCoreService（在 **bin** 文件夹下） 和 recorder （在 **samples/cpp/release/bin** 目录下）文件复制到和 Dockerfile 文件相同的目录。

3. 使用该 Dockerfile 制作镜像文件，并推送到阿里云 ECI 可以拉取的仓库。

具体操作请参考 [Docker 官方文档](https://docs.docker.com/get-started/)。

## 创建和部署容器实例

操作步骤请参考[从 Docker Hub 拉取 Nginx 镜像](https://help.aliyun.com/document_detail/119093.html)，下面给出本例使用的配置。你需要根据实际情况自行调整配置。

> 本文使用的配置仅作为示例用途，请根据你使用的阿里云账号自行设置地域、网络、安全组和数据卷的具体配置。

### 地域

华东 2 可用区 G

### 网络

- 所选专有网络：record1 / vpc-uf6ex2oqj0oxfdg0oh44z
- 所选交换机：record-switch-1 / vsw-uf6pzudts0vuhkmd6rdk9
- 交换机所在可用区：华东 2 可用区 G
- 交换机网段：192.168.1.0/24

关于如何创建专有网络 VPC 和交换机，详见[管理专有网络](https://help.aliyun.com/document_detail/65398.html)和[管理交换机](https://help.aliyun.com/document_detail/65387.html)。

### 安全组

所选安全组：recorder1 / sg-uf6aqr8dpzr7z340p96n

详见[创建安全组](https://help.aliyun.com/document_detail/25468.html)。

### 数据卷

NFS Volume

- 名称：recorder-nas
- server：3bd16484a9-scl52.cn-shanghai.nas.aliyuncs.com
- path：/

你需要购买并设置 NAS 用于保存录制文件，详见[配置数据卷](https://help.aliyun.com/document_detail/90672.html)。

### 容器组配置

- 重启策略： Never

- 容器组名称：recording-eci

- 容器名称：recorder-docker1

- 镜像名：hub.xxx.cn:6066/uap/recorder

- 镜像版本：2.3.3.150v2

- 工作目录：/usr/src/recording

- 启动命令：/usr/src/recording/recorder

- 启动参数：录制的具体设置，可以参考[设置录制选项](https://docs.agora.io/cn/Recording/recording_cmd_cpp?platform=Linux%20CPP#设置录制选项)。

  ```bash
  --appId <yourAppId> --channelKey <token> --channelProfile 1 --recordFileRootDir /data/recorder --channel demo --uid 666 --appliteDir /usr/src/recording --idle 30 --lowUdpPort 40000 --highUdpPort 41004 --isMixingEnabled 1 --mixedVideoAudio 2
  ```

- 容器数据卷：recorder-nas，挂载路径（Mount Path） 为 /data/recorder

确认配置并创建实例后，即可运行弹性容器组。在 [ECI 控制台](https://eci.console.aliyun.com/)的弹性容器实例列表中，可以看到正在运行的录制实例。

## 确认录制效果

我们需要在配置的 NAS 存储中，检查录制文件。由于阿里云未提供直接访问 NAS 存储的功能，我们可以创建一个空的容器，挂载 NAS 并将启动命令设置为 `sleep 9999`，然后使用阿里云提供的[连接](https://help.aliyun.com/document_detail/119176.html)功能，在弹性容器实例列表中使用 ffmpeg 工具查看文件内容。

## 命令行创建容器实例

阿里云 [CloudShell](https://help.aliyun.com/document_detail/101356.html) 支持使用命令行的方式来创建和管理弹性容器实例，下面给出创建实例的命令行示例供你参考。

### 录制 360P 视频

命令行示例（CPU 0.25，Memory 0.5G）：

```bash
aliyun eci CreateContainerGroup --RegionId=cn-shanghai  --SecurityGroupId=sg-uf6aqr8dpzr7z340p96n --VSwitchId=vsw-uf6pzudts0vuhkmd6rdk9 --Volume.1.Name=recorder-nas --Volume.1.Type=NFSVolume --Volume.1.NFSVolume.Path=/ --Volume.1.NFSVolume.Server=3bd16484a9-scl52.cn-shanghai.nas.aliyuncs.com --Volume.1.NFSVolume.ReadOnly=False --ContainerGroupName=recording-eci1 --RestartPolicy=Never --Container.1.Image=hub.xxx.cn:6066/uap/recorder --Container.1.Name=recorder-docker1 --Container.1.Cpu=0.25 --Container.1.Memory=0.5 --Container.1.ImagePullPolicy=Always --Container.1.WorkingDir=/usr/src/recording --Container.1.Command.1=/usr/src/recording/recorder --Container.1.VolumeMount.1.Name=recorder-nas --Container.1.VolumeMount.1.MountPath=/data/recorder --Container.1.VolumeMount.1.ReadOnly=False --Container.1.Arg.1=—appId=<yourAppId> --Container.1.Arg.2=—channelKey=<token> --Container.1.Arg.3=--channelProfile=1 --Container.1.Arg.4=--recordFileRootDir=/data/recorder --Container.1.Arg.5=—channel=demo --Container.1.Arg.6=--uid=3600205 --Container.1.Arg.7=--appliteDir=/usr/src/recording --Container.1.Arg.8=--lowUdpPort=40000 --Container.1.Arg.9=--highUdpPort=41004 --Container.1.Arg.10=--isMixingEnabled=1 --Container.1.Arg.11=--mixedVideoAudio=2 --Container.1.Arg.12=--idle=15
```

### 创建用于查看录制文件的容器

命令行示例：

```bash
aliyun eci CreateContainerGroup --RegionId=cn-shanghai  --SecurityGroupId=sg-uf6aqr8dpzr7z340p96n --VSwitchId=vsw-uf6pzudts0vuhkmd6rdk9 --Volume.1.Name=recorder-nas --Volume.1.Type=NFSVolume --Volume.1.NFSVolume.Path=/ --Volume.1.NFSVolume.Server=3bd16484a9-scl52.cn-shanghai.nas.aliyuncs.com --Volume.1.NFSVolume.ReadOnly=False --ContainerGroupName=recording-eci --RestartPolicy=Never --Container.1.Image=hub.xxx.cn:6066/uap/recorder --Container.1.Name=recorder-docker1 --Container.1.Cpu=0.5 --Container.1.Memory=1 --Container.1.ImagePullPolicy=Always --Container.1.VolumeMount.1.Name=recorder-nas --Container.1.VolumeMount.1.MountPath=/data/recorder --Container.1.VolumeMount.1.ReadOnly=False --Container.1.WorkingDir=/usr/src/recording --Container.1.Command.1=sleep  --Container.1.Arg.1=9999
```