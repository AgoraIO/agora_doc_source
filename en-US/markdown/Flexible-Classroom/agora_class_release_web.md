This page provides the release notes for Agora Flexible Classroom.

## Known Issues

Flexible Classroom does not support displaying GIF images in the whiteboard of a classroom.

## v1.1.0.2

v1.1.0.2 was released on July 7, 2021.

#### New features

**Media encryption**

To ensure the security during real-time audio and video transmission, v1.1.0.2 adds the `mediaOptions` parameter in `LaunchOption` for supporting media stream encryption. By default, Flexible Classroom does not encrypt the media stream. To enable media encryption, use the `mediaOptions` parameter to choose an encryption mode and set the encryption key. Flexible Classroom supports the following encryption modes:

- `AES_128_XTS`: 128-bit AES encryption, XTS mode.
- `AES_128_ECB`: 128-bit AES encryption, ECB mode.
- `AES_256_XTS`: 256-bit AES encryption, XTS mode.
- `AES_128_GCM`: 128-bit AES encryption, GCM mode.
- `AES_256_GCM`: 256-bit AES encryption, GCM mode.

> The teacher and students in a classroom must use the same encryption mode and key. If not, unexpected issues, such as a white or black screen and noise, may occur.

#### Issues fixed

v1.1.x fixes the following issues:

- The default region was not NA (North America).
- When the user set the UI language as English, users saw some Chinese characters on the screen sharing window.
- When the teacher started screen sharing, students saw a black screen.

## v1.1.0

v1.1.0 was released on June 15, 2021. This is the first release of Agora Flexible Classroom with the following features:

- Real-time audio and video interaction
- Real-time messaging
- Interactive whiteboard
- Screen sharing
- Recording and replay
- Teaching tools, including cloud storage, classroom rewards, and the user list
- Customizing the classroom user interfaces and embedding custom plugins in classrooms
- Flexible Classroom cloud service for classroom and user management