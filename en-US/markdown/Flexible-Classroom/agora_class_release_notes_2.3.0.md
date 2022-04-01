## v2.3.0

v2.3.0 was released on March 31, 2022.

### New features

**Breakout rooms (Web only)**

v2.3.0 adds the "Breakout rooms" feature in the toolbox of small classrooms and lecture halls. With breakout rooms, students gather in small groups for lively conversation and brainstorming sessions. Teachers can create breakout rooms in either of the following ways:

- Automatic grouping: The teacher sets up the number of breakout rooms. Then the system randomly assigns the whole class to breakout rooms.
- Manual grouping: The teacher manually assigns students to each breakout room.

No matter which way the teacher chooses, a class supports up to 20 breakout rooms with a maximum of 17 members in each room. The features that are available in breakout rooms include real-time audio and video interaction, messaging, whiteboard, and screen sharing.

After the breakout session begins, the teacher and teaching assistant can join and leave any of the breakout rooms at will. They can also send announcements to all the breakout rooms. Students are notified in their chat to check for the announcements.

**Support for the teacher role on Android and iOS clients**

v2.3.0 duplicates the features of the teacher role on desktop clients (Web, macOS, and Windows) to mobile clients (Android and iOS).

Note that the following features are temporarily not available for the teacher role on mobile clients:

- Enabling screen sharing
- Starting pop-up quizzes
- Starting polls
- Starting the countdown timer

**Ability to turn on or off the whiteboard in the classroom**

v2.3.0 embeds the ability to turn on or off the whiteboard in one-on-one classrooms, small classrooms, and lecture halls. After turning off the whiteboard, the teacher's video is displayed on the whiteboard area.

### Improvements

- Optimizes widgets: v2.3.0 optimizes the internal technical architecture of the three widgets: Pop-up Quiz, Poll, and Countdown Timer. In addition, v2.3.0 enables developers to get the data of pop-up quizzes and polls through RESTful APIs. For details, see the [RESTful API reference ](https://confluence.agoralab.co/pages/viewpage.action?pageId=952997862).
- Improves the compatibility of the Web client: The Web client is now supported on the desktop Firefox.
- Optimizes the cloud storage: v2.3.0 optimizes the business logic and UI of the cloud storage feature in Flexible Classroom.
- Optimizes the whiteboard: v2.3.0 adds laser pointer, undo, redo, and one-click screen-clearing features on the whiteboard in Flexible Classroom.
- Optimizes the chat:
   - v2.3.0 supports uploading and sending local pictures on Android, iOS, Web, and Electron clients.
   - v2.3.0 supports taking screenshots on Electron.

### Issues fixed

- Fixed the issue that when the teacher moved a file or a tool on the whiteboard, the movement might not be synchronized to the students' side.
- Fixed the occasional failure to log into the IM module after joining a room.
- Fixed the failure to load a file when the format of the file is not supported.