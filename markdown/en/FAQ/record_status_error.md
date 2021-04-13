---
title: How can I solve issues relating to recording status?
platform: ["Linux"]
updatedAt: 2020-07-09 22:00:49
Products: ["Recording"]
---
### Recording quit error

If Error: 3, with stat_code:16 is reported, the recording quits normally. You can determine why the recording quit by the leave_path code.

![](https://web-cdn.agora.io/docs-files/1542879822196)

* LEAVE_CODE_INIT(0)：Initialization failure.
* LEAVE_CODE_SIG(0b10)：Signal triggered an exit.
* LEAVE_CODE_NO_USERS(0b100)：The recording times out and exits.
* LEAVE_CODE_TIMER_CATCH(0b1000)：Ignore it.
* LEAVE_CODE_CLIENT_LEAVE(0b10000)：The client leaves the channel.
 
You can perform a bitwise AND operation on the code and each enum value, and those with non-zero results are the reason for the exit. For example, if you perform a bit-by-bit AND operation on code 6 (0b110) and each enum value, only `LEAVE_CODE_SIG` (0b10) and `LEAVE_CODE_NO_USERS` (0b100) get a non-zero result. The reasons for exiting, in this case, include a timeout and a signal triggering the exit.

Typically, a recording session exits because a timeout occurs. Search for "No users in channel" in `recording_sys.log` to confirm.

### How do I know whether the recording crashes?

The recording crashes if the following scenarios occur:

* Video files cannot play.
* The `uid_xxx.txt` file has no close information about the MPEG-4 file.
* The recording_sys.log file contains the **MediaFile** keyword but not the **~MediaFile** keyword.
* The recorded event information in Argus has no quit flag.

### What should I do when the recording crashes?

Users of the Recording SDK v2.2.3 or later can check the crash.log file generated in the same directory as AgoraCoreService.

Users of the Recording SDK versions earlier than v2.2.3 can check if there is a core file generated in the same directory as AgoraCoreService.

1. If you get the core file:
   a. Put the bin/AgoraCoreService and core file together, then execute the command line: gdb -c core_xxxx AgoraCoreService.
   b. Provide the core file, the result from step a, and the recording_sys.log file to Agora technical support.
2. If you cannot find the core file:
    a. If no directory is set for the core file, then the core file is usually found in the directory where the recorded AgoraCoreService file is located.
    b. If not, execute ulimit -c on Linux. If the output is 0, coredump is not open. Open coredump by executing: ulimit -c unlimited.
    c. After opening coredump, users can generate the core file after a crash.
    d. Provide the recording_sys.log file and the core file to Agora technical support.
		
### The recorded video files of the native client are in webm format when the Native SDK interoperates with the Web SDK.
To fix this issue, set the `codec` property as "h264" when calling the `createClient` method on the web client. If the `codec` property is "vp8", the recorded video files of the native client are in webm format.