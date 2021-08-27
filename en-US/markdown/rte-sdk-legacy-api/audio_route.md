# Audio Route Principles and Best Practices

The audio route is the pathway audio data takes through different audio hardware components during playback. For example, earpieces, headphones, speakerphone, and Bluetooth devices that output sound all work as an audio route.

This page explains what audio routes are and shows you how to change the audio route from one device to another.

## The default audio route

The default audio route is the route audio data takes within a device, such as the speakerphone on a mobile device.

Depending on the use cases, Agora uses different default audio routes:
- Voice call: Earpiece
- Video call: Speakerphone
- Interactive live audio streaming: Speakerphone
- Interactive live video streaming: Speakerphone

## Change the audio route

The audio route can be changed in any of the following approaches:
- Device user: Add or remove an external device, such as headphones or a Bluetooth audio device.
- App developer:
    - Call `setDefaultAudioRoutetoSpeakerphone` to change the default audio route.
    - Call `setEnableSpeakerphone` to set the audio route temporarily.

Any change to the audio route, regardless of the approach, triggers the `onAudioRouteChanged` (Android) or `didAudioRouteChanged` (iOS) callback. You can use this callback to get the current audio route.

The following sections explain how these approaches affect the audio route.

### Audio route changes when the user plugs or unplugs a device

When a user plugs in an audio device such as headphones, the audio route automatically changes to the headphones. When multiple devices are connected, the last device connected gets the audio route. 

See the following steps and how the audio route changes accordingly:

1. A user joins an interactive live streaming channel.
The audio route is the speakerphone.
2. The user plugs in headphones.
The audio route changes to the headphones.
3. The user connects the mobile device to a Bluetooth audio device without unplugging the headphones.
The audio route changes to the Bluetooth audio device.
4. The user disconnects the Bluetooth audio device from the mobile device.
The audio route changes back to the headphones

### The default audio route can be changed 

Call the `setDefaultAudioRoutetoSpeakerphone` method before, during, or after a call to change the defaut audio route between the earpiece and the speakerphone. 

See the following steps and how the audio route changes accordingly:

1. A user plugs in headphones.
The audio route is the headphones.
2. The user unplugs the headphones.
The audio route changes to the default audio route of the mobile deivce, depending on your use case.
3. The app calls `setDefaultAudioRoutetoSpeakerphone(true)`.
The audio route changes to the speakerphone.
4. The user plugs in headphones.
The audio route changes to the headphones.
5. The app calls `setDefaultAudioRoutetoSpeakerphone(true)`.
The audio route remains the headphones, because `setDefaultAudioRoutetoSpeakerphone` works on the audio route of the device only.
6. The user unplugs the headphones.
The audio route changes to the speakerphone.

### The setEnableSpeakerphone method changes the audio route temporarily

You can call the `setEnableSpeakerphone` method to temporarily change the audio route to the speakerphone, if the operating system permits.

Any subsequent change to the audio route, such as plugging in or unplugging headphones, or calling `setEnableSpeakerphone(false)`, overrides this method call. The system audio route resumes to the one following the two previously-listed principles. 

See the following steps and how the audio route changes accordingly:

- Example 1

  1. A user joins an interactive live streaming channel.
  The audio route is the speakerphone.
  2. The user plugs in headphones.
  The audio route changes to the headphones.
  3. The app calls `setEnableSpeakerphone(true)`.
  On Android, the audio route changes to the speakerphone. On iOS, the audio route remains the headphones because on iOS, once the mobile deivce is connected to headphones or a Bluetooth audio device, you cannot change to audio route to the speakerphone.
   
- Example 2

  1. A user joins a voice call channel.
  The audio route is the earpiece.
  2. The app calls `setEnableSpeakerphone(true)`.
  The audio route changes to the speakerphone.
  3. The user plugs in headphones.
  The audio route changes to the headphones.
  4. The app calls `setEnableSpeakerphone(false)`.
  The audio route changes to the earpiece.


### Audio route and system volume

In use cases relating to audio, Agora uses the media volume as the system volume. Whether the system uses the media volume or in-call volume does not impact the principles above.