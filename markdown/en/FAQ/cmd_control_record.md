---
title: How do I control recording sessions in the command-line interface?
platform: ["Linux"]
updatedAt: 2019-06-28 10:37:50
Products: ["Recording"]
---
### Start and pause recording

If you use the automatic mode (default), the recording starts automatically when a user joins the channel. In this mode, you cannot pause the recording.

If you use the manual mode (`triggerMode` set as 1), use the following methods to start and pause the recording:

- To control all the recording sessions:

  - Start recording: `killall -s 10 recorder_local`
  - Pause recording：`killall -s 12 recorder_local`
  
- To control an individual recording session:

   1. Get the PID：`ps aux | grep 'channelName'`
   2. Control the recording session by the PID

      - Start recording：`kill -s 10 PID`
      - Pause recording：`kill -s 12 PID`

### Stop recording

The recording stops automatically when there is no user in the channel after a time period set by the idle parameter. The default value is 300 seconds. 

To manually stop recording, press **Ctrl** + **C** to end the command-line session.