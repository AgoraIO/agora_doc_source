# Audio Route Principles and Best Practices

The audio route is the pathway audio data rakes through different audio hardware components during playback. Earpieces, headphones, speakerphones, and Bluetooth devices that output sound (such as Bluetooth speakers), can all work as an audio route.

This article provides an overview of the principles and methods for changing the audio route through one device to another.

## The default audio route

The default audio route is the route audio data takes within a device, such as the speakerphone or earpiece of the mobile phone.

Depending on the use cases, Agora uses different default audio routes:
- Voice call: Earpiece
- Video call: Speakerphone
- Interactive live audio streaming: Speakerphone
- Interactive live video streaming: Speakerphone

## Three ways to change the audio route

The audio route can be changed in any of the following ways:
- Plug in or unplug an external device, such as a headphone or a Bluetooth audio device.
- Call `setDefaultAudioRoutetoSpeakerphone` to change the default audio route.
- Call `setEnableSpeakerphone` to set the audio route temporarily.

## Principles for changing the audio route

This sections covers the principles that the previously-metioned methods follow to affect the audio route.

### 1. Audio route changes when the user plugs or unplugs a device

When a user plugs in an audio device such as a headphone, the audio route automatically changes to the headphone. When multiple devices are connected, the final device connected gets the audio route. See the following example:

|  | Behavior | Audio route |
| -- | -- | -- |
| 1 | Join an interactive live streaming channel. | Speakerphone |
| 2 | Plug in the headphone. | Headphone |
| 3 | Connect to the Bluetooth audio device without unplugging the headphone. | Bluetooth audio device. |
| 4 | Disconnect from the Bluetooth audio device. | Headphone. |

### 2. The default audio route can be changed 

The `setDefaultAudioRoutetoSpeakerphone` method changes the defaut audio route between the earpiece and the speakerphone. You can call this method before, during, or after a call. See the following example:

|  | Behavior | Audio route | Note |
| -- | -- | -- | -- |
| 1 | Plug in the headphone. | Headphone |  |
| 2 | Unplugi  the headphone. | The default audio route according to your use case. |  |
| 3 | Call `setDefaultAudioRoutetoSpeakerphone(true)` | Speakerphone |  |
| 4 | Plug in the headphone | Headphone |  |
| 5 | Call `setDefaultAudioRoutetoSpeakerphone(true)` | Headphone | The `setDefaultAudioRoutetoSpeakerphone` method works for the audio route of the device only. |
| 6 | Unplug the headphone | Speakerphone |  |

### 3. The setEnableSpeakerphone method changes the audio route temporarily

Agora provides the `setEnableSpeakerphone` method to change the audio route temporarily. A successful call of `setEnableSpeakerphone(true)` temporarily changes the audio route to the speakerphone, if the operating system permits.

Any subsequent change to the audio route, such as plugging in or unplugging a headphone, or by calling `setEnableSpeakerphone(false)`, overrides this method call. The system audio route changes according to the two previously-listed principles. See the following examples:

**Example 1**

|  | Behavior | Audio route | Note |
| -- | -- | -- | -- |
| 1 | Join an interactive live streaming channel. | Speakerphone |  |
| 2 | Plug in the headphone | Headphone. |
| 3 | Call `setEnableSpeakerphone(true)`. | <ul><li>Android: Speakerphone</li><li>iOS: Headphone</li></ul> | Due to OS limitations, you cannot change the audio route to the speakerphone once a headphone or a Bluetooth audio device is connected on iOS. |

**Example 2**

|  | Behavior | Audio route |
| -- | -- | -- |
| 1 | Join a voice call channel. | Earpiece |
| 2 | Call `setEnableSpeakerphone(true)`. | Speakerphone |
| 3 | Plug in the headphone. | Headphone |
| 4 | Call `setEnableSpeakerphone(false)`. | Earpiece. |

### 4. Audio route and system volume

In use cases relating to audio, Agora uses the media volume as the system volume. Whether the system uses the media volume or in-call volume does not impact the principles above.

## Considerations

This section includes considerations you need to know before implementing changing audio route in your project:
- Whether the audio route change principles work is subject to the limitations of the operating system. On iOS, calling `setEnableSpeakerphone(true)` does not change the audio route to the speakerphone of a headphone or a Bluetooth audio device is connected.
- Any change to the audio route, regardless of the approach, triggers the `onAudioRouteChanged` (Android) or `didAudioRouteChanged` (iOS) callback. You can use this callback to get the current audio route.