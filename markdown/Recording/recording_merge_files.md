---
title: 合并音视频文件
platform: All Platforms
updatedAt: 2020-11-12 14:05:36
---

本文中转码指将多个录制文件合成一个文件的过程， Agora 在[录制 SDK](https://docs.agora.io/cn/Recording/downloads) 的 tools 文件夹下提供转码工具 `ffmpeg` 和 `video_convert.py`，通过命令行 `tar -xvf` 解压 `ffmpeg`，并确保和 `video_convert.py` 在同一目录下。

执行 `python video_convert.py`，即可看到相关用法：

```
Usage: video_convert.py [options]

Options:
  -h, --help
  -f FOLDER, --folder=FOLDER
                        Convert folder
  -m MODE, --mode=MODE  Convert merge mode, [0: txt merge A/V(Default); 1: uid
                        merge A/V; 2: uid merge audio; 3: uid merge video]
  -p PFS,  --fps=FPS    Convert fps, default 15
  -s --saving           Convert Do not time sync
  -r RESOLUTION, --resolution=RESOLUTION
                        Specific resolution to convert '-r width height'
                        Eg: '-r 640 360'
```

| **参数** | **描述**                                                                                                                                                                                                                                                                                                                                                                                     |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-f`     | 待转码文件所在的文件夹路径                                                                                                                                                                                                                                                                                                                                                                   |
| `-m`     | 转码模式，其中：<li>0：按 session 转码，即把同一个 session 的音频和视频合成一个文件。<li>1：把同一个用户的音频和视频按时间顺序合成一个文件。<li>2：把同一个用户的音频按时间顺序合成一个文件。<li>3：把同一个用户的视频按时间顺序合成一个文件。                                                                                                                                               |
| `-p`     | 帧率设置参数，支持合图模式和单流模式，默认为 15 fps，支持 5 fps ~ 120 fps。如果设置低于 5 fps，则按 5 fps 执行。                                                                                                                                                                                                                                                                             |
| `-s`     | 保存模式，表示转码是否需要严格时间同步，即用户离开频道的时间是否占用录制文件时长，需与 `-m` = 1，2 或 3 一起使用，否则无效。默认为 `all time recording`。`all time recording` 模式下，如果用户录制中途退出频道后重新加入，用户退出的时间会以黑色的画面呈现在录制文件里。例如，用户在频道里 2 分钟后，退出频道 30 分钟，后再加入频道 2 分钟，录制文件长度最终为 34 分钟，其中 30 分钟为黑屏。 |
| `-r`     | 设置转码的分辨率，格式为“宽 高”。                                                                                                                                                                                                                                                                                                                                                            |

- 如果录制生成的是多个纯音频文件，转码后将合并生成 m4a 文件，文件名为 `UID_HHMMSSMS.m4a`
- 如果录制生成的是多个音视频文件，转码后将合并生成 mp4 文件，文件名为`UID_HHMMSSMS_av.mp4`，如果希望合并每个 session 的音频文件和视频文件，则:
  - 当同一个 UID 退出后再进入频道的时间间隔少于 15 秒，则认为是同一个 session，不会产生新的音频文件，但会产生新的视频文件，并且会和之前同一个 session 内的音视频文件合并入同一个 `UID_HHMMSSMS_av.mp4` 文件。
  - 当同一个 UID 退出后再进入频道的时间间隔大于 15 秒，则认为是一个新的 session，会产生新的音频文件和视频文件，并且这段音视频会被计入新 session 的 `UID_HHMMSSMS_av.mp4` 文件里。
- 如果录制生成的是多个音视频文件，并且希望把多个不同 session 的 mp4 文件以 merge 方式合并，转码后将合并生成 mp4 文件，文件名为 `UID_0_merge_av.mp4、UID_1_merge_av.mp4`……
  - `triggerMode = 0` 即 `automatically mode`下使用 `-m` 参数，会把同一个 uid 的所有音视频文件合并，并生成唯一的一个 `UID_0_merge_av.mp4` 文件。
  - `triggerMode = 1` 即 `manually mode` 下，由于是根据手动输入 `start` 和 `stop` 来划分文件管理的，每一个 `start`/`stop` 为一次 session。因此如果有多次 `start` 和 `stop`，就会产生多个 session，因此使用 `-m` 参数就会生成多个 `UID_XX_merge_av.mp4` 文件。

你也可以参考下面的图示，来理解转码脚本的选择：

![](https://web-cdn.agora.io/docs-files/1552297124002)

转码完成后的 mp4 文件几乎支持所有主流播放器，例如：

| **操作系统** | **播放器**                                              |
| ------------ | ------------------------------------------------------- |
| Windows      | Windows Media Player, KM Player, VLC Player             |
| Mac          | Mac Quick Time Player, Movist, MPlayerX, KMPlayer       |
| iOS          | iOS 默认播放器， VLC， KMPlayer                         |
| Android      | Android 默认播放器，MXPlayer，VLC for Android, KMPlayer |

只有当录制文件夹内有 `recording2-done.txt` 文件时，才可以进行转码。转码完成后，会生成一个`convert-done.txt`，标志转码成功。使用转码脚本完成转码后会生成一个 `convert.log`日志文件，和音视频文件在同一个路径下。
