## Overall product architecture

The following figure shows the overall product architecture of Flexible Classroom:

![](https://web-cdn.agora.io/docs-files/1652707409645)

## Basic features

| <span style="white-space:nowrap;">Feature&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span> | Description |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| Real-time audio and video interaction | <li>In a one-to-one classroom, both the teacher and student can send and receive audio and video streams by default.</li><li>In a small classroom or a lecture hall, students do not send audio and video streams by default. During the class, students can "go onto the stage" and address the class.</li> |
| Real-time messaging | The teacher and students can send text messages, emojis, and pictures. |
| Interactive whiteboard | The teacher and students can draw and make notes on the whiteboard. Flexible Classroom supports rich drawing tools, including brushes, text boxes, shapes, erasers, paging, and laser pointer. |
| Courseware management | Teachers can upload files in classrooms to help students better understand the class. Supported formats include PPT, PPTX, DOC, DOCX, PDF, MP3, MP4, PNG, JPG, and GIF. |
| Cloud recording | Teachers can start recording in the classroom. Flexible Classroom uses [Web Page Recording](/en/cloud-recording/cloud_recording_webpage_mode?platform=RESTful) to record the audio, video, and whiteboard content in a single file and provides a link for students after the recording finishes. |
| Enabling screen sharing | Teachers can share their screens, windows, or browser tabs with students in class. |
| Teaching tools | <li>Rewards: Teachers can reward students with virtual credits, such as stars and trophies, for good performance during the class.</li><li>The answer selector: This tool is applicable to scenarios where the teacher asks a single-choice or multiple-choice question and requests the whole class to answer the question together. The teacher can set up the choices and the correct answer, and then trigger answering. The teacher can see the number of students who have submitted an answer and the percentage that are correct in real time.</li><li>The polling tool: This tool is applicable to scenarios where the teacher wants to get feedback from the whole class. The teacher can set up the subject, choices, and start and end time of the poll. Flexible Classroom also provides live visualization of polling results.</li><li>The countdown timer: The teacher can find the countdown timer in the toolbox and set an initial value. After the teacher clicks the start button, students see a countdown window.</li><li>Breakout rooms: The teacher can create breakout rooms and manually assign students to each breakout room. A class supports up to 20 breakout rooms with a maximum of 17 members in each room. The features that are available in breakout rooms include real-time audio and video interaction, messaging, whiteboarding, and screen sharing. After the breakout session begins, the teacher and teaching assistants have the ability to dynamically join or leave any of the breakout rooms. They can also send announcements to all the breakout rooms. Students are notified in their chat to check for the announcements.</li> |

## Advanced features

<table>
<thead>
  <tr>
    <th>Module</th>
    <th>Feature</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="9">Room</td>
    <td>Customizes room properties for suiting personalized needs at the room level, such as letting students take a break during the class.</td>
  </tr>
  <tr>
    <td>Sets the start time of a class.</td>
  </tr>
  <tr>
    <td>Sets the class duration.</td>
  </tr>
  <tr>
    <td>Sets the run-late time of a class. After the run-late time, the room is closed. Users are kicked out of the room immediately, and other users can no longer join the room.</td>
  </tr>
  <tr>
    <td>Configures the upper limit on the number of students on the stage. By default, a maximum of six students can be on stage at the same time.</td>
  </tr>
  <tr>
    <td>Configures the upper limit on the number of students raising their hands. By default, a maximum of ten students can raise their hands at the same time.</td>
  </tr>
  <tr>
    <td>Configures whether students "go onto the stage" by default after entering the classroom.</td>
  </tr>
  <tr>
    <td>Configures the storage region. The region where the classroom is located must be consistent with the region of the OSS used to store class files and recording files.</td>
  </tr>
  <tr>
    <td>Supports in-class event monitoring, which synchronizes the events in real time.</td>
  </tr>
  <tr>
    <td rowspan="5">User</td>
    <td>Customizes user properties, such as setting the avatar, age or gender.</td>
  </tr>
  <tr>
    <td>The user list Display the information of all users in the classroom, such as whether the user is "on stage", whether the camera and microphone are on or off, and the number of rewards.</td>
  </tr>
  <tr>
    <td>Customize rewards.</td>
  </tr>
  <tr>
    <td>Requests a student to "go onto the stage".</td>
  </tr>
  <tr>
    <td>Kick students out of the room.</td>
  </tr>
  <tr>
    <td rowspan="3">Stream</td>
    <td>Configures video encoding parameters, including the bitrate, resolution, and mirror mode.</td>
  </tr>
  <tr>
    <td>Encrypts audio and video streams.</td>
  </tr>
  <tr>
    <td>Manages permission to send the audio and video streams.</td>
  </tr>
  <tr>
    <td rowspan="3">Device and media</td>
    <td>Turns on or off the media devices and conducts device tests.</td>
  </tr>
  <tr>
    <td>Controls the video rendering.</td>
  </tr>
  <tr>
    <td>Controls the audio playback.</td>
  </tr>
  <tr>
    <td rowspan="3">UIKit/UIStore</td>
    <td>Configures multiple languages.</td>
  </tr>
  <tr>
    <td>Adjusts the classroom layout.</td>
  </tr>
  <tr>
    <td>Change the classroom colors.</td>
  </tr>
  <tr>
    <td rowspan="4">Widget</td>
    <td>Implements pluggable widgets, such as the interactive whiteboard, pop-up quiz, and countdown timer.</td>
  </tr>
  <tr>
    <td>Configures the resolution of recording files.</td>
  </tr>
  <tr>
    <td>Configures the storage address of recording files.</td>
  </tr>
  <tr>
    <td>Configures the start time and end time of a recording session.</td>
  </tr>
</tbody>
</table>