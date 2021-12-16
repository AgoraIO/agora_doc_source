---
title: 本地服务端录制的并发性能如何？
platform: ["Linux"]
updatedAt: 2020-07-09 21:44:58
Products: ["Recording"]
---
对于本地服务端录制，我们测试了以下云主机配置下的录制并发性能：

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