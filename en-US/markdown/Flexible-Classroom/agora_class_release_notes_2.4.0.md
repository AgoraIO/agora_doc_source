## v2.4.x

v2.4.x was released on June 2, 2022.

### New features

**Breakout rooms (Web only)**

v2.4.0 adds the "Breakout rooms" feature in the toolbox of small classrooms. With breakout rooms, students can get together in small groups for discussion and brainstorming sessions. Teachers can create breakout rooms and manually assign students to each breakout room. A class supports up to 20 breakout rooms with a maximum of 17 members in each room. The features that are available in breakout rooms include real-time audio and video interaction, messaging, whiteboarding, and screen sharing. After the breakout session begins, the teacher and teaching assistants have the ability to dynamically join or leave any of the breakout rooms. They can also send announcements to all the breakout rooms. Students are notified in their chat to check for the announcements.

After the breakout session begins, the teacher and teaching assistants have the ability to dynamically join or leave any of the breakout rooms. They can also send announcements to all the breakout rooms. Students are notified in their chat to check for the announcements.

**Support for the teacher role on Android and iOS clients**

v2.4.x duplicates the features of the teacher role on desktop experience for Web, macOS, and Windows on mobile clients (Android and iOS).

<div class="alert info">Note that the following features are temporarily not available for the teacher role on mobile clients:<ul><li>Enabling screen sharing</li><li>Starting pop-up quizzes</li><li>Starting polls</li><li>Starting the countdown timer</li></ul></div>

**Ability to turn the whiteboard on and off in the classroom**

v2.4.x adds the ability to turn the whiteboard on or off in one-on-one classrooms, small classrooms, and lecture halls. By default, after the whiteboard is turned off, the teacher's video is displayed in the whiteboard area. Developers are also able to use UIStore or UIKit to customize the classroom layout when the whiteboard is off.

### Improvements

This release includes the following improvements:

- Optimizes widgets: v2.4.x optimizes the internal technical architecture of the three widgets: Pop-up Quiz, Poll, and Countdown Timer for the higher stability and better end-user experience. In addition, v2.4.x enables developers to get the data of pop-up quizzes and polls through RESTful APIs. For details, see the [RESTful API reference](/en/agora-class/agora_class_restful_api?platform=RESTful#get-data-for-pop-up-quizzes).
- Improves the compatibility of the Web client: The Web client is now supported on the desktop version of Firefox.
- Optimizes the cloud storage: v2.4.x optimizes the business logic and UI of the cloud storage feature in Flexible Classroom.
- Optimizes the whiteboard: v2.4.x adds laser pointer, undo, redo, and one-click screen-clearing features on the whiteboard in Flexible Classroom.
- Reward enhancements: The teacher can now extend and remove student rewards dynamically during a class session.

### Issues fixed

This release fixed the following issues:

- When the teacher moved a file or a tool on the whiteboard, the movement might not be synchronized on the students' side.
- Logging in to the IM module occasionally failed.
- Loading a file failed when the format of the file was not supported.