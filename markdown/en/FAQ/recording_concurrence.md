---
title: What is recording concurrency?
platform: ["Linux"]
updatedAt: 2020-07-09 22:09:01
Products: ["Recording"]
---
For the Agora On-premise Recording SDK, we conduct tests on the recording concurrency based on the following cloud hosting configuration:

* AWS: Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00 GHz
* 16 Virtual Core CPU, 32 GB RAM
* Disk I/O: 412 MB/s

Test conditions:

* Each channel has two users/hosts. The resolution and frame rate of each channel are set as 320 × 240 and 15 fps respectively.
* The resolution, frame rate, and bitrate of the recorded files in composite recording mode are set as 640 × 480, 15 fps, and 500 Kbps respectively; and the audio bitrate of the recorded files in composite recording mode is set as 48 Kbps.

Test results:

<table>
  <tr>
    <th>Channel Profile</th>
    <th>Recording Mode</th>
    <th>Performance</th>
  </tr>
  <tr>
    <td rowspan="3">Live Broadcast</td>
    <td>Audio + Video<br>Individual recording</td>
    <td>When recording 215 channels simultaneously, the CPU usage is about 75%.<br>We recommend recording 200 channels simultaneously.</td>
  </tr>
  <tr>
    <td>Audio + Video<br>Composite recording</td>
    <td>When recording 70 channels simultaneously, the CPU usage is about 75%.<br>We recommend recording 60 channels simultaneously.</td>
  </tr>
  <tr>
    <td>Audio only<br>Composite recording</td>
    <td>When recording 300 channels simultaneously, the CPU usage is about 75%.</td>
  </tr>
  <tr>
    <td rowspan="2">Communication</td>
    <td>Audio + Video<br>Individual recording</td>
    <td>When recording 210 channels simultaneously, the CPU usage is about 75%.<br>We recommend recording 200 channels simultaneously.</td>
  </tr>
  <tr>
    <td>Audio + Video<br>Composite recording</td>
    <td>When recording 60 channels simultaneously, the CPU usage is about 75%.</td>
  </tr>
</table>

The test results are for reference purposes only. 