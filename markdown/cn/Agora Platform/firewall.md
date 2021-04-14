---
title: 应用企业防火墙限制
platform: All_Platforms
updatedAt: 2021-03-04 02:39:15
---
在使用 Agora.io 提供的相关服务之前，您需要接入到某些特定的端口。本页提供使用 Agora 各 SDK 前必须要打开的端口及设置的域名白名单。

## Agora Native SDK

-   打开 TCP 端口：1080、8000、9700、25000，30000。

-   打开 UDP 端口：1080、4000-4030、7000、8000、8913、9700、25000。

-   将域名 `.agora.io` 、 `vocs1.agora.io` 、 `vocs2.agora.io` 、 `vocs3.agora.io` 、 `vocs4.agora.io` 、 `vocs5.agora.io` 、 `qoslbs.agoralab.co` 、 `qos.agoralab.co` 、 `ap1.agora.io` 、 `ap2.agora.io` 、 `ap3.agora.io` 、 `ap4.agora.io` 、 `ap5.agora.io` 设为白名单


## Agora Web SDK

-   打开 TCP 端口 80、443、3433、5668、5669、5866-5890、6080、6443、8667、9667

-   打开 UDP 端口 3478、10000-65535

-   将域名 `*.agora.io` 和 `*.agoraio.cn` 设为白名单

> 如果你使用了代理服务器，则需打开端口 3433；如果未使用代理服务器，则无需打开端口 3433。

## Agora Signaling SDK

-   打开 TCP 端口 1080、8001-8199

-   打开 UDP 端口 8180-8199

-   将域名 `.agora.io`、`vocs.agora.io`、`qoslbs.agora.io` 以及 `qos.agora.io` 设为白名单


## Agora Recording SDK

-   打开 TCP 端口：1080、8000

-   打开 UDP 端口：双向 1080、4000-4030、8000、9700、25000 和 所有的录制进程所使用的单向下行端口

-   将域名 .agora.io、vocs.agora.io、qoslbs.agoralab.io、qos.agoralab.io 设为白名单



> 录制一个频道的内容需要开启一个对应的录制进程；单个录制进程需要使用 4 个单向下行端口。进程（包括各个录制进程和系统进程）之间不得有端口冲突。

> -   Agora 建议您指定录制进程使用端口的范围。您可以为多个录制进程统一配置较大的端口范围（Agora 建议 40000 ~ 41000 或更大）。此时，录制 SDK 会在指定范围内为每个录制进程分配端口，并避免端口的冲突。要设置端口范围，您需要配置参数 `lowUdpPort` 和 `highUdpPort`；
> -   如果不指定参数`lowUdpPort` 和 `highUdpPort` ，录制进程所使用的端口为随机端口，会有端口冲突的风险。


## Agora Gaming SDK

-   打开 TCP 端口：1080、8000
-   打开 UDP 端口：1080、4000-4030、8000、9700、25000
-   将域名 `.agora.io`、`vocs.agora.io`、`qoslbs.agora.io` 和 `qos.agora.io` 设为白名单


为获得优质的音视频通话体验，Agora 建议你使用 UDP 端口。与 TCP 相比，UDP 更注重通话的时效性，因此能在填补丢包的同时同时将通话延迟降到最低。

