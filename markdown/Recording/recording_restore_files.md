---
title: 录制崩溃后修复录制文件
platform: Linux
updatedAt: 2020-09-17 15:54:25
---
## 概述

在过去的版本中，由于录制崩溃，录制生成的 MP4 文件可能无法播放。针对该问题，自 3.0.3 版本起， Agora 录制 SDK 提供如下解决方案：

- 录制 SDK 在录制过程中生成 TS 格式的视频文件，并在录制正常结束后自动转封装为 MP4 文件。即使录制过程中偶现崩溃，最终生成的 MP4 文件依然可以播放。
- 录制 SDK 新增 `crash_restore.sh` 脚本。当录制服务因多次崩溃而异常退出时，你可以运行该脚本将 TS 文件转封装为 MP4 文件，并修复内容缺失的 `uid_UID_timestamp.txt` 文件。

## 适用场景

Agora 录制 SDK 会在以下场景的录制过程中生成 TS 文件：

| 录制模式                                                     | 录制内容       | 参数设置                                    | 录制过程中生成的文件</br> (无录制崩溃）                           | 录制完成后生成的文件</br>（无录制崩溃）                           |
| ------------------------------------------------------------ | -------------- | ------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [单流录制](https://docs.agora.io/cn/Recording/recording_individual_mode?platform=Linux) | 同时录制音视频 | 默认设置                                    | <li>Native 端每个 UID 生成一个 AAC 音频文件和一个 TS 视频文件</li> <li>Web 端每个 UID 生成一个 AAC 音频文件和一个 WebM 或 TS 视频文件</li> | <li>Native 端每个 UID 生成一个 AAC 音频文件和一个 MP4 视频文件</li> <li>Web 端每个 UID 生成一个 AAC 音频文件和一个 WebM 或 MP4 视频文件</li> |
| [合流录制](https://docs.agora.io/cn/Recording/recording_composite_mode?platform=Linux) | 仅录制视频     | `--isVideoOnly 1`</br> `--isMixingEnabled 1`</br>   | 一个 TS 视频文件                                             | 一个 MP4 视频文件                                            |
| [合流录制](https://docs.agora.io/cn/Recording/recording_composite_mode?platform=Linux) | 同时录制音视频 | `--isMixingEnabled 1`</br> `--mixedVideoAudio 2`</br> | 一个 TS 音视频文件                                           | 一个 MP4 音视频文件                                          |
                                 

<div class="alert note"><ul><li>AAC 音频文件和 WebM 视频文件为流媒体格式的文件，即使录制崩溃也不会影响其可用性。</li><li>表格中列出的是在录制过程中无崩溃情况下，录制过程中和录制完成后生成的文件。如果录制过程中发生崩溃，TS 视频文件会根据崩溃的次数而被切分成多个，转封装后的 MP4 文件也将是多个。</li></ul></div>

## 实现方法

在不同录制模式下，根据单次录制进程中录制崩溃发生的次数，你需要对录制文件进行不同的修复操作，具体如下表所示：

| 崩溃次数    | 单流录制                                                     | <span style="white-space:nowrap;">合流录制&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>                                                    |
| :---------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 崩溃小于 4 次 </br>| <li>录制服务会被重复拉起，继续录制。由于录制崩溃，TS 文件会被切片，`uid_UID_timestamp.txt` 文件会出现内容缺失。</li><li>录制结束后，录制 SDK 会将所有 TS 文件逐一转封装为 MP4 文件，无需手动处理。</li><li>但是，录制 SDK 不会修复 `uid_UID_timestamp.txt` 文件。如果你需要用转码脚本将每个 UID 的音频文件和视频文件合并成一个 MP4 文件，则需要先运行 `crash_restore.sh` 脚本修复 `uid_UID_timestamp.txt` 文件。</li> | <li>录制服务会被重复拉起，继续录制。由于录制崩溃，TS 文件会被切片。</li><li>录制结束后，录制 SDK 会将所有 TS 文件逐一转封装 为 MP4 文件，无需手动处理。</li> |
| 崩溃等于 4 次 </br>| <li>录制服务异常退出，因录制崩溃而被切片的 TS 文件无法被自动转封装，`uid_UID_timestamp.txt` 文件会出现内容缺失。</li><li>你需要运行 `crash_restore.sh` 脚本所有 TS 文件转封装为 MP4 文件。该脚本同时会修复 `uid_UID_timestamp.txt` 文件。</li> | <li>录制服务异常退出，因录制崩溃而被切片的 TS 文件无法被自动转封装。</li><li>你需要运行 `crash_restore.sh` 脚本将所有 TS 文件转封装为 MP4 文件。</li> |

## 使用恢复脚本

### 前提条件

- Linux 运行环境
- Python 3.0 或以上版本
- FFmpeg 4.0 或以上版本 （你也可以使用 Agora 录制 SDK 在 **tools** 文件夹下提供的 FFmpeg 包。）

**文件准备：**

确保录制文件的存储路径可访问。

### 恢复步骤

输入以下命令行：

```
 $ ./crash_restore.sh <recorderDir>/
```

其中，`recorderDir` 为录制文件存放的目录。

输入命令行后，脚本会将指定目录下所有 TS 文件逐一转封装为 MP4 文件，并对 `uid_UID_timestamp.txt` 文件做修复处理。

转封装后的 MP4 文件的数量和主名与源 TS 文件一致，后缀名为 `mp4`。使用脚本完成转封装后，TS 文件不会被删除，以免因修复异常而需要再次使用。

## 示例

如要将录制文件夹 `20200915` 下的 TS 文件转封装为 MP4 文件并修复 `uid_UID_timestamp.txt` 文件，命令如下：

```
$ ./crash_restore.sh 20200915/
```

修复前：
![](https://web-cdn.agora.io/docs-files/1600314197717)

修复后：
![](https://web-cdn.agora.io/docs-files/1600314313477)

## 注意事项

- 自 3.0.3 版本起，录制结束后，需要等待转封装完成，才能得到 MP4 文件。转封装实际耗时取决于服务器的 IOPS 以及待转封装的所有 TS 文件大小。例如，转封装大小总和为 4GB 的 TS 文件大约需要 85 到 150 秒（该数据仅供参考）。
- 转封装操作会增加服务器磁盘 IO 资源消耗。如果服务器磁盘性能较差，在转封装完成前，建议不要进行其他操作。