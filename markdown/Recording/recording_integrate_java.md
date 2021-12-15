---
title: 集成录制 SDK
platform: Linux
updatedAt: 2021-03-31 07:50:54
---

本页介绍如何设置环境以及集成 Agora 录制 SDK。

你需要将 Agora 录制 SDK 集成在你的 Linux 服务器上而不是你的 App 上。

<img alt="../_images/recording_linux_cn.png" src="https://web-cdn.agora.io/docs-files/cn/recording_linux_cn.png" style="width: 640.0px;"/>

录制某频道内的音视频信息相当于将一个特殊的观众加入该频道。该观众获取频道内的音视频信息，将获取到的信息转码并储存在 Linux 服务器上。 因此，你必须：

- 将录制 SDK 集成在你的 Linux 服务器上；
- 在录制 SDK 中和进行音视频通话的 Agora SDK 使用同一个 App ID 。

## 前提条件

### 硬件和网络要求

下表列出了安装 Agora 录制 SDK 的基本要求：

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td width="100"><strong>硬件和网络</strong></td>
<td><strong>要求</strong></td>
</tr>
<tr><td>服务器</td>
<td><p>物理或虚拟</p>
<ul>
<li>Ubuntu Linux 14.04+ LTS x64</li>
<li>CentOS 7+ x64</li>
</ul>
</td>
</tr>
<tr><td>网络</td>
<td>这台 Linux 服务器要接入公网，有公网 IP</td>
</tr>
<tr><td>带宽</td>
<td>根据需要同时录制的频道数量和频道内情况确定所需带宽。以下数据可供参考：录制一个分辨率为 640*480 的画面需要的带宽约为 500kbps；录制一个有两个人的频道则需 1Mbps；同时录制 100 个这样的频道，需要带宽为 100Mbps。关于分辨率和带宽的关系，详见 <a href="/cn/Recording/API%20Reference/recording_java/index.html"><span>录制 API</span></a>。</td>
</tr>
<tr><td>域名解析</td>
<td>服务器允许访问 qos.agoralab.co，否则 SDK 无法上报必要的统计数据。</td>
</tr>
</tbody>
</table>

参考硬件配置：

<table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>产品</strong></td>
<td><strong>描述</strong></td>
<td><strong>数量</strong></td>
</tr>
<tr><td>SUPERMICRO SYS-6017R-TDF</td>
<td>1U rack-mounted SYS-6017R-TDF, 双路 Intel® Xeon® E5-2600 系列处理器</td>
<td>1</td>
</tr>
<tr><td>机箱</td>
<td>1U Rackmountable(440W high-efficiency redundant power supply w/ PMBus)</td>
<td>1</td>
</tr>
<tr><td>处理器</td>
<td>Intel Xeon E5-2620V2 2.1G, L3:15M, 6C((P4X-DPE52620V2-SR1AN)</td>
<td>2</td>
</tr>
<tr><td>内存</td>
<td>MEM-DR380L-HL06-ER16(8GB DDR3-1600 2Rx8 1.35v ECC REG RoHS)</td>
<td>1</td>
</tr>
<tr><td>硬盘</td>
<td>250G 3.5 SATA Enterprise (HDD-T0250-WD2503ABYZ)</td>
<td>2</td>
</tr>
</tbody>
</table>

假设每个频道内有两个人进行视频通话（通信模式），单流模式录制，分辨率是 640 &times; 480 ，帧率为 15 fps ，单流码率为 500 Kbps ：

实测在参考硬件配置下， 12 核 24 线程的 CPU 满载并发 100 个频道，此时：

- 每个频道占用约 25 M 内存；总共占用约 2.5 G 内存。内存占用率约为 31%；
- 每个频道写入磁盘的速度约为 60 KB/s ；总写入速度约为 6.0 MB/s ，远低于磁盘的最大写入速度；
- 每个频道下行网络流量约为 500 Kbps &times; 2 = 1 Mbps ，总下行流量约为 100 Mbps ，上行流量可以忽略不计。

### SDK 兼容性

录制 SDK 支持：

- 纯 Native 端录制；
- 纯 Web 端录制
- Web 与 Native 互通时录制。

录制 SDK 与以下 Agora SDK 兼容:

| Agora SDK        | 兼容版本 |
| ---------------- | -------- |
| Agora Native SDK | 1.7.0+   |
| Agora Web SDK    | 1.12.0+  |

> 如果频道内有任何用户使用了不兼容版本的 SDK，则整个频道无法录制。

## 准备环境

在你的 Linux 服务器上进行以下操作：

1. [下载](https://docs.agora.io/cn/Agora%20Platform/downloads)最新的 Agora 录制 SDK 软件包。软件包内容如下:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>文件夹</strong></td>
<td><strong>描述</strong></td>
</tr>
<tr><td>bin</td>
<td>AgoraCoreService 所在的目录</td>
</tr>
<tr><td>include</td>
<td><ul>
<li>base：libs 所依赖的一些基础的头文件</li>
<li>IAgoraLinuxSdkCommon.h：公共的基础结构体和枚举值</li>
<li>IAgoraRecordingEngine.h：录制引擎的接口类和配置信息</li>
</ul>
</td>
</tr>
<tr><td>libs</td>
<td>录制的依赖库</td>
</tr>
<tr><td>samples</td>
<td><p>代码示例</p>
<ul>
<li>agorasdk：对录制 C++ 接口的实现以及回调的处理示例</li>
<li>base：公共的示例代码</li>
<li>cpp：C++ 示例代码<ul>
<li>release/bin/recorder：可运行的父程序</li>
</ul>
</li>
<li>java：java 示例代码<ul>
<li>native：native code</li>
<li>native/jni：jni 代理</li>
<li>src: java 层源代码</li>
<li>src/io/agora/recording/RecordingEventHandler.java: 回调接口类</li>
<li>src/io/agora/recording/RecordingSDK.java: 录制接口类</li>
</ul>
</li>
</ul>
</td>
</tr>
<tr><td>tools</td>
<td>转码工具</td>
</tr>
</tbody>
</table>

2. 为你的项目准备所需库：

   - 将 **include** 文件夹添加到你的项目里。
   - 将 **lib** 文件夹添加到你的项目里，并确保 `libRecordingEngine.a` 与项目有连接。

3. 安装编译器: gcc 4.4+ 。
4. 配置好 jdk 环境，并确保包含 jni.h。
5. 配置好 Java 的 `CLASSPATH` 和 Linux 的 `LD_LIBRARY_PATH` 环境变量。
6. 打开 TCP 端口：1080、8000。

7. 打开 UDP 端口：双向 1080、4000-4030、8000、9700、25000 和 所有的录制进程所使用的单向下行端口。

   > - 录制一个频道的内容需要开启一个对应的录制进程；单个录制进程需要使用 4 个单向下行端口。进程（包括各个录制进程和系统进程）之间不得有端口冲突。
   > - Agora 建议指定录制进程使用端口的范围。你可以为多个录制进程统一配置较大的端口范围（Agora 建议 40000 ~ 41000 或更大）。此时，录制 SDK 会在指定范围内为每个录制进程分配端口，并避免端口的冲突。要设置端口范围，你需要配置参数 `lowUdpPort` 和`highUdpPort`。
   > - 如果不指定参数 `lowUdpPort` 和 `highUdpPort` ，录制进程所使用的端口为随机端口，会有端口冲突的风险。
   > - 使用`iptables -L`命令查看 UDP 端口。

8. 将域名 .agora.io 和 .agoralab.co 设为白名单。

9. 为调试方便，Agora 建议你打开系统的 core dump 功能以记录可能产生的程序崩溃信息。

## 编译代码示例

1. 打开命令行工具，在 **samples/java** 路径下执行如下命令进行环境预设置。其中 `jni_path` 请填入 `jni.h` 文件绝对路径，例如 `/usr/java8u161/jdk1.8.0_161/include/`：

   ```
   source build.sh pre_set jni_path
   ```

2. 在 **samples/java** 下执行编译脚本：

   ```
   ./build.sh build
   ```

编译完成，在本目录下生成一个 **bin** 文件夹，其中的子目录 **io/agora/recording** 下会包含一个 `librecording.so` 文件，如图所示。

![](https://web-cdn.agora.io/docs-files/1544522310646)

你已经集成了录制 SDK。

## 相关文档

了解如何使用 Java 命令行进行录制：[开始录制](./recording_cmd_java)。
