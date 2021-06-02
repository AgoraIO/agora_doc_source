---
title: What does Cloud Recording do when a recording server drops offline or a process gets killed?
platform: ["RESTful"]
updatedAt: 2020-07-09 12:04:37
Products: ["cloud-recording"]
---
When this happens, the cloud recording service enables the high availability mechanism, where the fault processing center automatically switches to a new server within 90 seconds to resume the service.

###  Why has the file name of a recording file changed?

Each time the service enables the high availability mechanism, it creates a new M3U8 file, which contains the index information of the recorded slice files from when the service resumes. The file name is prepended with `bak<n>`, where `n` stands for the number of times the mechanism is enabled in a recording, and starts off with `0`. 

For example, in composite recording mode, the file name of M3U8 is `<sid>_<cname>.m3u8`. After enabling the high availability mechanism for the first time, the service creates a new M3U8 file with the name of `bak0_<sid>_<cname>.m3u8`.

After the cloud recording service enables the high availability mechanism, the names of the recorded TS/WebM files are also prepended with `bak<n>`.

> The service enables the high availability mechanism for a maximum of three times in a recording. It gives up the attempt the fourth time the recording server is disconnected or the process killed.

### Why do I get a 404 error when I call `query`?

After the cloud recording enables the high availability mechanism, the fault processing center needs a certain period of time to find the cause of the failure and act accordingly. 

When the service detects that the server process is killed, the fault processing center switches the service to another server within 30 seconds; when the service detects that the server is disconnected, the fault processing center tries to reconnect to that server or switch to a different server if it fails to reconnect within one minute. Before the service resumes, you get a 404 for the method call of `query`, `updateLayout`, or `stop`.

### Why isn't the UID in the callback notification the same as the recording UID I set?

After the high availability mechanism is enabled and the service is switched to a new server, the service rejoins the channel with a randomly-generated recording UID, abandoning the old one.