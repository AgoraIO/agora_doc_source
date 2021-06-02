---
title: Use the Transcoding Script 
platform: All Platforms
updatedAt: 2019-12-19 19:49:19
---
The transcoding tool includes `video_convert.py` and `ffmpeg`. The Python script can merge the separated voice and video recording files into one MPEG-4 file and the script relies on `ffmpeg`. 
You can get the transcoding tool `ffmpeg` and `video_convert.py` in the tools folder in [Recording SDK](https://docs.agora.io/en/Recording/downloads). Decompress `ffmpeg`, and make sure it is in the same directory as `video_convert.py`. 

Execute python `video_convert.py` with the following usage:

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



| **Option** | **Description**                                                     |
| -------- | ------------------------------------------------------------ |
| `-f`     | The directory of the file to be transcoded.                  |
| `-m`     | The transcoding mode: <li>0: Transcode by the session. Merge the voice and video file of one session into one file.</li><li>1: Merge the voice and video file of the same uid into a file chronologically.</li><li>2: Merge the voice file of the same uid into a file chronologically.</li><li>3: Merge the video file of the same uid into a file chronologically.</li> |
| `-p`     | The parameter for setting the frame rate in both composite and individual recording. 15 fps is the default value. |
| `-s`     | The saving mode that indicates if the transcoding should be strictly synchronized with time; in other words, if the time interval when the user is not in the channel remains in the recorded file. Make sure that you use this parameter together with -m = 1/2/3. The default value indicates “always recording”.  |
| `-r`     | The arameter for setting the resolution of transcoding in the “width height” format. For the supported resolution, see `joinChannel` to allows an application to join a channel.                            |

- If multiple voice files are generated after the recording, transcoding merges them into one M4A file in the format of `UIDHHMMSSMS.m4a`.
- If multiple voice and video files are generated after the recording, transcoding merges them into one MPEG-4 file in the format of `UID_HHMMSSMS_av.mp4`. To merge the voice and video files by the session:
   - If a uid leaves a channel and rejoins it within 15 seconds, the Agora Recording SDK considers this session as one. A new voice file is not generated but a new video file is generated and merged into the voice and video file, and a `UIDHHMMSSMSav.mp4` file is generated.
   - If a uid leaves a channel and rejoins it after 15 seconds, the Agora Recording SDK considers this as two separate sessions. A new voice and video file is generated creating a new `UIDHHMMSSMSav.mp4` file for the new session.
-   If multiple voice and video files are generated after the recording, and you wish to merge the MPEG-4 files of different sessions by the uid, transcoding merges them into different MPEG-4 files such as `UID_0_merge_av.mp4`, `UID_1_merge_av.mp4`, and `UID_2_merge_av.mp4`.
  - When `triggerMode = 0`, that is, in the automatically record mode, the `-m` parameter merges all voice and video files of one uid and generates a single `UID_0_merge_av.mp4` file.
  - When `triggerMode = 1`, that is, in the manually record mode, the `start` and `stop` parameters manage and divide the recorded files. Each start/stop makes one service, and the `-m` parameter generates multiple `UID_XX_merge_av.mp4` files.

See the following figure for the different transcoding script options:

<img alt="../_images/recording_demo.png" src="https://web-cdn.agora.io/docs-files/en/recording_demo.png" />

The transcoded MPEG-4 file supports the following players:

| **Operation System** | **Players**                                              |
| ------------ | ------------------------------------------------------- |
| Windows      | Windows Media Player, KMPlayer, VLC Media Player           |
| Mac          | Mac Quick Time Player, Movist, MPlayerX, KMPlayer       |
| iOS          | iOS default player, VLC Media Player, KMPlayer                      |
| Android      | Android default player, MX Player, VLC Media Player, KMPlayer|

You can start transcoding only if a `recording2-done.txt` file exists in the recording folder. A `convert-done.txt` file is generated after the transcoding is complete. Once the transcoding script is used, a `convert.log` file is generated in the same directory as the voice and video files upon completion of the transcoding.



