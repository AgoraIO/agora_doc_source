---
title: Integrate the SDK
platform: CPP
updatedAt: 2021-03-22 08:20:19
---
This page shows how to set up the environment to integrate the Agora Recording SDK.

The Agora Recording SDK for Linux is integrated on your Linux server instead of in your app.

![](https://web-cdn.agora.io/docs-files/1545296935254)

Recording audio and video within a channel is like a special audience joining the channel. The audience gets the audio and video from the channel, transcodes it, and stores it on a Linux server. Therefore, you must integrate the Recording SDK on your Linux server. The same App ID is used in the Recording SDK and the Agora SDK for audio and video calls.

## Prerequisites

### Hardware and network requirements

The following table lists the basic requirements for installing the Recording SDK:

<table>
<thead>
<tr><th>Hardware and Network</th>
<th>Requirements</th>
</tr>
</thead>
<tbody>
<tr><td>Server</td>
<td>Physical or virtual.</td>
</tr>
<tr><td>System</td>
<td>Ubuntu Linux 14.04+ LTS 64-bit or CentOS 6.5+ x64.</td>
</tr>
<tr><td>Network</td>
<td>The Linux server needs Internet access.</td>
</tr>
<tr><td>Internet Bandwidth</td>
<td><p>Use an Internet bandwidth based on the number of channels being recorded simultaneously. Refer to the following data:</p>
<div><ul>
<li>When the resolution of the recorded scene is 640 x 360, the bandwidth is 500 Kbps.</li>
<li>To record a channel with two users, you need a bandwidth of 1 Mbps.</li>
<li>To record 100 channels, you need a bandwidth of 100 Mbps.</li>
</ul>
</div>
<p>For detailed bandwidth data, see <a href="/en/Recording/API%20Reference/recording_cpp/index.html"><span>Recording API</span></a>.</p>
</td>
</tr>
</tbody>
</table>

Agora recommends the following hardware requirements:

<table>
<thead>
<tr><th>Product</th>
<th>Description</th>
<th>Number</th>
</tr>
</thead>
<tbody>
<tr><td>SUPERMICRO SYS-6017R-TDF</td>
<td>1U rack-mounted SYS-6017R-TDF
Intel® Xeon® E5-2600 Series Processor</td>
<td>1</td>
</tr>
<tr><td>Case</td>
<td>1U Rackmountable
(440-W high-efficiency redundant power supply w/ PMBus)</td>
<td>1</td>
</tr>
<tr><td>Processor</td>
<td>Intel Xeon E5-2620V2 2.1 G, L3:15M, 6C (P4X-DPE52620V2-SR1AN)</td>
<td>2</td>
</tr>
<tr><td>Memory</td>
<td>MEM-DR380L-HL06-ER16 (8-GB DDR3-1600 2Rx8 1.35-V ECC REG RoHS)</td>
<td>1</td>
</tr>
<tr><td>Hard Disk</td>
<td>250-G 3.5 SATA Enterprise (HDD-T0250-WD2503ABYZ)</td>
<td>2</td>
</tr>
</tbody>
</table>



Assuming two users are in a channel in a video call \(communication mode\), with a resolution of 640 x 360, frame rate of 15 fps, and bitrate of one video stream of 500 Kbps, using single-stream recording:

The CPU with 12 cores and 24 threads is fully loaded and 100 channels are recorded simultaneously:

- Each channel writes to the disk at a speed of 60 kB/s. The total write-in speed is 6.0 MB/s, which is much lower than the maximum write-in speed of the disk.
- Each channel uses 25 MB of memory. Thus, 2.5 GB of memory, which is 31% of the total memory, is used.
- The downlink Internet bandwidth for each channel is 500 kbps x 2 = 1 Mbps. The total downlink stream is 100 Mbps. The uplink stream is neglected.

### Compatibility with the Agora SDKs

The recording SDK supports:

- Recording communication that uses the Native SDK.
- Recording communication that uses the Web SDK.
- Recording communication that uses both the Native SDK and the Web SDK.

The Recording SDK is compatible with the following Agora SDK versions:

<table>
<thead>
<tr><th>Agora SDK</th>
<th>Compatible versions</th>
</tr>
</thead>
<tbody>
<tr><td>Agora Native SDK</td>
<td>v1.7.0+</td>
</tr>
<tr><td>Agora Web SDK</td>
<td>v1.12.0+</td>
</tr>
</tbody>
</table>

> If any user in the channel uses an Agora SDK which is not compatible with the Agora Recording SDK, recording fails for the whole channel.

## Set up the Environment

Set up the environment on your Linux server:

1. [Download](https://docs.agora.io/en/Agora%20Platform/downloads) the Agora Recording SDK for Linux package. The package structure is listed as follows:

   <table>
   <thead>
   <tr><th>Folder</th>
   <th>Description</th>
   </tr>
   </thead>
   <tbody>
   <tr><td>bin</td>
   <td>The directory where AgoraCoreService is located.</td>
   </tr>
   <tr><td>include</td>
   <td><ul>
   <li>base: Required header files for developing the recording application.</li>
   <li>IAgoraLinuxSdkCommon.h: Public structure and enumeration.</li>
   <li>IAgoraRecordingEngine.h: Interface of the recording engine and its configuration.</li>
   </ul>
   </td>
   </tr>
   <tr><td>libs</td>
   <td>Required libraries for developing the recording application.</td>
   </tr>
   <tr><td>samples</td>
   <td><p>Sample code</p>
   <ul>
   <li>agorasdk: Demo that implements the C++ interface and callbacks.</li>
   <li>base: Public sample code.</li>
   <li>cpp: C++ sample code.<ul>
   <li>release/bin/recorder: Parent process that can be run.</li>
   </ul>
   </li>
   <li>java: Java sample code<ul>
   <li>native: Native code</li>
   <li>native/jni: JNI delegate</li>
   <li>src: java code</li>
   <li>src/io/agora/recording/RecordingEventHandler.java: Callback interface class.</li>
   <li>src/io/agora/recording/RecordingSDK.java: Recording interface class.</li>
   </ul>
   </li>
   </ul>
   </td>
   </tr>
   <tr><td>Tools</td>
   <td>Transcoding tools</td>
   </tr>
   </tbody>
   </table>

6. Prepare the required libraries:
      - Add the include folder to your project.
      - Add the lib folder to your project and make sure the libRecordingEngine.a file is connected to the project.
5. Ensure that your compiler is gcc 4.4+.
2. Open the following TCP ports: 1080 and 8000.
3. Open the following UDP ports:
   - Duplex ports: 1080, 4000 to 4030, 8000, 9700, and 25000.
   - Simplex downlink ports used by the recording processes.

   > - Use the `iptables -L` command line to check the UDP port.
   > - To record the content in channels, you need one recording process for each of the channels. One recording process requires four simplex downlink ports. There must be no port conflict among the processes, including the system processes and all recording processes.
   > - Agora recommends that you specify the range of ports used by the recording processes. Configure a large range for all recording processes \(Agora recommends 40000 to 41000 or larger\). If so, the Recording SDK assigns ports to each recording process within the specified range and avoids port conflicts automatically. To set the port range, you need to configure the `lowUdpPort` and `highUdpPort` parameters.
   > - If the `lowUdpPort` and `highUdpPort` parameters are not specified, the ports used by the recording processes are at random, which may cause port conflicts.

4. Set whitelist domains:

   - .agora.io
   - .agoralab.co

7. For debug purposes, Agora recommends you enable core dump on your Linux system.


## Compile the Sample Code

Open a command-line tool and run the following command to compile the sample code under the **samples/cpp** directory.

```
make
```

After the compilation, a **record_local** executable file is generated in this directory, as shown in the figure.

![](https://web-cdn.agora.io/docs-files/1544522109941)

The Agora Recording SDK is integrated.

## Next Steps

Learn how to record by using the command line: [Record a Call](./recording_cmd_cpp?platform=CPP).
