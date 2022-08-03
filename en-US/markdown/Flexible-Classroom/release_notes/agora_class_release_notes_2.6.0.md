## v2.6.x

v2.6.x was released on July 29, 2022.

#### New features

**Support for Agora Chat (Private Beta)**

As of v2.6.x, Agora uses the Public Beta version of [Agora Chat](/en/agora-chat/agora_chat_overview?platform=Android) to implement the IM features in Flexible Classroom, including the following:

- Text and image messages
- Emoji
- Announcement
- Mute all

**Taking screenshots (Electron only)**

v2.6.x adds a snipping tool for Teacher to "take screenshots" of content inside and outside of the classroom, and dynamically add it to the classroom whiteboard. The feature is available in one-to-one classrooms, small classrooms, and lecture halls. This feature is available in the toolbar on Windows and macOS clients. Teachers and teaching assistants can choose to take a screenshot directly or with the current window hidden. The screenshot is displayed in the center of the whiteboard. And Agora provides APIs to expand usage of this feature to include Students and other roles:

- Web: [getSnapshotRgba](/en/agora-class/API Reference/edu_context_web/v2.6.x/classes/_stores_domain_common_media_index_.MediaStore.html#getSnapshotRgba)
- Electron: [getSnapshot](/en/agora-class/API Reference/edu_context_web/v2.6.x/classes/_stores_domain_common_media_index_.MediaStore.html#getSnapshot)
- iOS: [getSnapshot](/en/agora-class/API Reference/edu_context_swift/v2.6.x/API/class_mediacontext.html#api_getsnapshot)
- Android: [getSnapshot](/en/agora-class/API Reference/edu_context_kotlin/v2.6.x/API/class_mediacontext.html#api_getsnapshot)

**Automatic grouping**

For the "breakout rooms" feature, v2.6.x supports automatic grouping. Teachers can set up the number of breakout rooms. Then the system randomly assigns the whole class to breakout rooms.

**Drag and Drop images from desktop into the classroom whiteboard (Web/Electron)**

v2.6.x allows teachers or teaching assistants on the PC to drop local images to the whiteboard area and insert the images into the whiteboard.

**Dynamic Size, Resize and Place Teacher Video inside the Classroom**

v2.6.x allows teachers to freely drag and drop their own video and the video of students within the classroom window. Teachers can also resize a video window by double-clicking it. Whatever actions the teacher takes with their video window, students will see.

**Hiding the stage area**

v2.6.x adds a button in the settings of small classrooms, which enables teachers to hide the stage area. After the stage is hidden, the following things occur:

- All videos are disabled.
- All students automatically steps down from the stage.
- The whiteboard is scaled up to fit the classroom.

**Saving whiteboard contents as images**

v2.6.x allows teachers and teaching assistants to save contents on the whiteboard to their local device as JPG images.

**Adding web links as courseware**

v2.6.x allows teachers to add web links, such as YouTube links and Google Drive links, in **My Resources**. The suffix of such kind of courseware is `.alf`, which is the abbreviation of agora link file. After the upload succeeds, the teacher can open the courseware in the classroom.

#### Issues fixed

This release fixed the following issues:

- (iOS) Crashes occurred when receiving a global announcement.
- (iOS) In small classrooms, the teacher did not select the brush, but red lines appeared on the whiteboard.
- (iOS) In small classrooms, the teacher double-clicked the settings, chat, or roster buttons, the color of these buttons did not change.
- (Android) In small classrooms, after a student joined a sub-room and invited the teacher to join the same sub-room, the teacher entered the wrong sub-room.
- (All) In small classrooms, before any student joined the classroom, the teacher started and ended the breakout room session. Then after a student joined the classroom, when the teacher re-started the breakout room session, the 500 error occurred.