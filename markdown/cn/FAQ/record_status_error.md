---
title: 为什么录制状态出现异常？
platform: ["Linux"]
updatedAt: 2020-07-09 21:37:21
Products: ["Recording"]
---
### 录制退出报错

如出现 Error: 3, with stat_code:16 报错时，录制属于正常退出。通过 leave_path code 判断录制退出的原因。

![](https://web-cdn.agora.io/docs-files/1540452150871)

* LEAVE_CODE_INIT(0)：初始化失败
* LEAVE_CODE_SIG(0b10)：AgoraCoreService 收到 SIGINT 信号而触发的退出。
* LEAVE_CODE_NO_USERS(0b100)：录制超时退出。
* LEAVE_CODE_TIMER_CATCH(0b1000)：可忽略。
* LEAVE_CODE_CLIENT_LEAVE(0b10000)：录制端调用 `leaveChannel` 方法退出频道。

你可以将日志中的 code 与各枚举值逐一进行按位与运算，计算结果非零的，即为退出原因。例如，code 为 `6`（0b110）时，将其与各枚举值逐一进行按位与计算，`LEAVE_CODE_SIG` (0b10）与 `LEAVE_CODE_NO_USERS` (0b100）的结果非零，则退出原因包括收到 SIGINT 信号以及录制超时。

大多数情况为录制超时退出，详见[`idleLimitSec`](https://docs.agora.io/cn/Recording/API%20Reference/recording_cpp/structagora_1_1recording_1_1_recording_config.html#aca9710dfdb0596c88f26e3c1c3daf48b)。检查 `recording_sys.log`，是否有 "No users in channel" 的关键字即可确认。

### 如何判断录制是否崩溃

录制崩溃可能导致以下情况：

* 视频文件无法播放。
* `uid_xxx.txt` 文件最后没有 mp4 文件的 close 信息。


### 录制崩溃之后怎么办

请升级至官网最新版本，如果无法解决：

2.2.3 及之后的版本请检查在 AgoraCoreService 同一目录下有没有生成 `crash.log`。

2.2.3 之前的版本请检查在 AgoraCoreService 同一目录下有没有生成 core 文件。
 
1. 如果有生成 core 文件，那么按照下面流程：
   a. 把 bin/AgoraCoreService 放在和 core 文件一起，然后命令行执行 gdb -c core_xxxx   AgoraCoreService。
   b. 将 core 文件、a 中的结果、`recording_sys.log` 提供给技术支持。
2. 如果没有找到 core 文件：
   a. 如果没有专门设置 core 文件的目录，那么 core 文件一般是在录制的 AgoraCoreService 文件所在的目录。
   b. 如果还是没有找到，Linux 上执行 ulimit -c， 输出如果为0，则说明 coredump 没有打开，需要通过执行 ulimit -c unlimited 打开。
   c. 打开后，之后再出现 crash 就可以生成 core 文件了。
   d. 针对这次没有 core 文件生成的场景，提供 `recording_sys.log` 给技术支持。
	 
### Native SDK 与 Web SDK 互通时，在 Native 端录制视频生成的文件是 webm 格式，如何解决？

Native SDK 与 Web SDK 互通时，在 Web 端调用 `createClient` 方法需要将 `codec` 属性设置为 h264，如果设为 vp8 则会导致 Native 端的视频录制文件为 webm 格式。