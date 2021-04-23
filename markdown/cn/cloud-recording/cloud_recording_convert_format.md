<div class="alert note">自 4 月 30 日起，合流录制模式下，你可以通过设置 <code>avFileType</code> 参数直接获得 MP4 文件，无需通过转码脚本进行格式转换。</div>

## 功能描述

合流录制模式下，你会得到一个 M3U8 文件和多个 TS 文件，包含所有用户的音视频数据。你可以使用 FFmpeg 将 M3U8 文件转换为 MP4 文件，或使用声网提供的音视频格式转换脚本，将多个 TS 文件批量转换为多个 MP4 文件或纯音频文件。

## 使用 FFmpeg 转换

你可以使用 FFmpeg 将 M3U8 文件转换为 MP4 文件。安装 [FFmpeg](http://ffmpeg.org/download.html)，并执行以下命令：

```
ffmpeg -i input.m3u8 -vcodec copy -acodec copy -absf aac_adtstoasc output.mp4
```

其中，`input.m3u8` 是待转换的 M3U8 文件名，`output.mp4` 为转换后的 MP4 文件名。

## 使用脚本转换

你可以使用声网提供的音视频格式转换脚本，将多个 TS 文件转换为多个 MP4 文件或纯音频文件，音频文件的格式包括 MP3、WAV 和 AAC。

### 前提条件

#### 环境准备

转码服务器推荐使用以下系统：

- Ubuntu 14.04+ x64
- CentOS 6.5+（推荐 7.0）x64

运行该脚本需要安装 [FFmpeg](http://ffmpeg.org/download.html) 3.3 及以上，以及 Python 2，2.7 或以上版本。

#### 文件准备

确保待转码文件的存储路径可访问。

### 转码步骤

#### 1.获取音视频格式转换脚本

下载 [Agora 音视频格式转换脚本](https://download.agora.io/acrsdk/release/format_convert_1.0.tar.gz) 压缩包并解压。

#### 2.输入命令行

输入以下命令行：

```
python format_convert.py <directory> <source_format> <destination_format>
```

其中：

- `directory`：源文件所在目录。
- `source_format`：源文件的格式，即文件后缀名。`source_format` 中的英文字母必须为小写，即：
  - 音频：`mp3`，`wav`，或 `aac`
  - 视频：`mp4` 或 `ts`
- `destination_format`：要转换成的目的格式。`destination_format` 中的英文字母必须为小写，即：
  - 音频：`mp3`，`wav`，或 `aac`
  - 视频：`mp4` 或 `ts`

输入命令行后，脚本会在指定目录下寻找所有符合源文件格式的文件进行转码，转码后的文件主名与源文件主名一致，后缀名为目的格式的后缀。

### 转码示例

如要将 `/home/testname/testfolder` 目录下的所有 MP4 文件转换成 TS 格式，命令如下：

```
python format_convert.py /home/testname/testfolder/ mp4 ts
```