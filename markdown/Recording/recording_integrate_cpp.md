---
title: 集成录制 SDK
platform: Linux
updatedAt: 2021-03-31 07:51:45
---

本页介绍如何设置环境以及集成 Agora 录制 SDK。

你需要将 Agora 录制 SDK 集成在你的 Linux 服务器上而不是你的 App 上。

> 如果你不想自行部署 Linux 服务器，可尝试 [Agora 云端录制](/cn/cloud-recording/product_cloud_recording)。

<img alt="../_images/recording_linux_cn.png" src="https://web-cdn.agora.io/docs-files/cn/recording_linux_cn.png" style="width: 640.0px;"/>

录制某频道内的音视频信息相当于将一个特殊的观众加入该频道。该观众获取频道内的音视频信息，将获取到的信息转码并储存在 Linux 服务器上。 因此，你必须：

- 将录制 SDK 集成在你的 Linux 服务器上；
- 在录制 SDK 中和进行音视频通话的 Agora SDK 使用同一个 App ID 。

## 前提条件

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
<li>Ubuntu 14.04+ x64</li>
<li>CentOS 6.5+（推荐 7.0）x64</li>
</ul>
</td>
</tr>
<tr><td>网络</td>
<td>这台 Linux 服务器要接入公网，有公网 IP</td>
</tr>
<tr><td>带宽</td>
<td>根据需要同时录制的频道数量和频道内情况确定所需带宽。以下数据可供参考：录制一个分辨率为 640*480 的画面需要的带宽约为 500kbps；录制一个有两个人的频道则需 1Mbps；同时录制 100 个这样的频道，需要带宽为 100Mbps。关于分辨率和带宽的关系，详见 <a href="/cn/Recording/API%20Reference/recording_cpp/index.html"><span>录制 API</span></a>。</td>
</tr>
<tr><td>域名解析</td>
<td>服务器允许访问 qos.agoralab.co，否则 SDK 无法上报必要的统计数据。</td>
</tr>
</tbody>
</table>

### 参考配置

我们测试了以下云主机配置下的录制并发性能：

- AWS：Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00 GHz
- 16 虚拟核 CPU，32 GB 内存
- 磁盘 I/O: 412 MB/s

测试条件：

- 每个频道内有两个人，视频分辨率设为 320 × 240 ，帧率设为 15 fps 。
- 对于合流录制文件，视频分辨率设为 640 × 480，视频帧率设为 15 fps，视频码率设为 500 Kbps ；音频码率设为 48 Kbps。

不同频道模式和录制模式下，录制并发性能如下：

<table>
  <tr>
    <th>频道模式</th>
    <th>录制模式</th>
    <th>测试结果</th>
  </tr>
  <tr>
    <td rowspan="3">直播模式</td>
    <td>视频单流录制</td>
    <td>215 个频道并发时，CPU 占用为 75% 左右<br>建议并发 200 个频道</td>
  </tr>
  <tr>
    <td>视频合流录制</td>
    <td>70 个频道并发时，CPU 占用 75% 左右<br>建议并发 60 个频道</td>
  </tr>
  <tr>
    <td>纯音频合流录制</td>
    <td>300 个频道并发时，CPU 占用为 75% 左右</td>
  </tr>
  <tr>
    <td rowspan="2">通信模式</td>
    <td>视频单流录制</td>
    <td>210 个频道并发时，CPU 占用为 75% 左右<br>建议并发 200 个频道</td>
  </tr>
  <tr>
    <td>视频合流录制</td>
    <td>60 个频道并发时，CPU 占用为 75% 左右</td>
  </tr>
</table>

你可参考上述云主机配置和对应的录制性能，根据自己的录制需要选择和配置云主机，详见[使用云容器部署录制 SDK](./recording_docker)。

## 准备环境

在你的 Linux 服务器上进行以下操作：

1. [下载](/cn/Recording/downloads?platform=Linux)最新的 Agora 录制 SDK 软件包。软件包内容如下:

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
   - 将包含 lib 库的目录链接到 **libs** 文件夹下的 `librecorder.a` 库文件。

3. 安装编译器: gcc 4.4+ 。
4. 如果你的网络环境设置了防火墙限制外网访问，请使用[云代理服务](https://docs.agora.io/cn/Recording/cloudproxy_recording?platform=Linux)。

5. 打开所有的录制进程所使用的 UDP 端口，端口为在 `RecordingConfig` 中指定的 `lowUdpPort` 和 `highUdpPort` 范围之间的端口。

   > - 录制一个频道的内容需要开启一个对应的录制进程；单个录制进程需要使用 4 个 UDP 端口。进程（包括各个录制进程和系统进程）之间不得有端口冲突。
   > - Agora 建议指定录制进程使用端口的范围。你可以为多个录制进程统一配置较大的端口范围（Agora 建议 40000 ~ 41000 或更大）。此时，录制 SDK 会在指定范围内为每个录制进程分配端口，并避免端口的冲突。要设置端口范围，你需要配置参数 `lowUdpPort` 和`highUdpPort`。
   > - 如果不指定参数 `lowUdpPort` 和 `highUdpPort` ，录制进程所使用的端口为随机端口，会有端口冲突的风险。
   > - 使用`iptables -L`命令查看 UDP 端口。

6. 为调试方便，Agora 建议你打开系统的 core dump 功能以记录可能产生的程序崩溃信息。

你已经集成了录制 SDK，可以选择以下任意一种方式开始录制：

- [命令行录制](./recording_cmd_cpp)，使用我们提供的演示程序在命令行中开始录制。
- [调用 API 录制](./recording_api_cpp)。

这两种方式可以实现相同的功能，根据你的需要选择一种即可。
