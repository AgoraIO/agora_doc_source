---
title: Why can't I answer calls through a Bluetooth device after connecting it to an iOS or Android device?
platform: ["iOS","Android"]
updatedAt: 2020-09-02 15:34:33
Products: ["Voice","Video","Interactive Broadcast"]
---
## Issue description

After connecting a Bluetooth device to an iOS or Android device, you may encounter the following issues:

- Failure to answer calls through a Bluetooth headset.
- Cannot record and play audio through a Bluetooth speaker.

## iOS devices

### Reason

The possible reasons include:

1. The iOS system selects audio routes for phone and VoIP calls, and the default audio routes are different from what you expect. Phone calls also include FaceTime calls and other calls implemented with CallKit.

   **The default audio route for a phone call after connecting an iOS device to a Bluetooth device:**
   - After tapping the answer button on iPhone, the default audio route is the iPhone speaker.
   - After tapping the answer button on a Bluetooth device, the default audio route is the Bluetooth device.

   **The default audio route for a VoIP call after connecting an iOS device to a Bluetooth device:**

   - If a user has answered phone calls, the default audio route is the one used by the last phone or VoIP call.
   - If a user has not answered any phone call, the default audio route is the Bluetooth device.

   If the default settings mentioned above conflict with the audio routes you want, you need to change them when connecting your iOS device to a Bluetooth device. For details, see [Solutions](#solution).

2. On an iOS device, the audio route for audio inputs and outputs must be the same. If you set the Bluetooth device as the audio route for recording, the system switches the audio route for playback to the Bluetooth device accordingly.

3. A Bluetooth speaker can only record audio during a system phone call. If the app does not use the CallKit, the following happens:
     - Users who send audio streams cannot record or play audio through the Bluetooth speaker.
     - Users who only receive audio streams can only play audio through the Bluetooth speaker.

### <a name="solution"></a>Solutions

Depending on which type of call you have an issue with, choose one of the following solutions to set the audio routes:

**Phone call**

- Before answering a phone call, change the audio route setting in **Settings**: swipe down to reveal the search field, search **Call Audio Routing**, and change the audio route to **Bluetooth Headset**. All incoming calls will be answered through the Bluetooth device even if you press the answer button on the iPhone.

 ![](https://web-cdn.agora.io/docs-files/1599030765099) ![](https://web-cdn.agora.io/docs-files/1599030771759)

- During a phone call, you can switch between the **Bluetooth Headset**, **Handset**, or **Speaker** options in the call interface.
- If you connect an iOS device to a Bluetooth speaker and answer calls in an app, ensure that the app uses the CallKit, otherwise, the above settings do not work.

**VoIP call**

- Before making a VoIP call, you need to switch to the **Bluetooth Headset** mode in the **Control Center**. Apps can call the iOS native API `setPreferredInput` method to change the audio route.
- When a VoIP call through the Bluetooth device is interrupted by a phone call, tap the answer button on the Bluetooth device to answer the phone call, after which you can continue the VoIP call through the Bluetooth device once the phone call ends.

## Android devices 

### Reasons

1. Permissions to access the Bluetooth device are not added in the `AndroidManifest.xml` file.

2. Only the Bluetooth device that supports SCO can record and play audio. If the Bluetooth device supports only A2DP, then it cannot record audio, which means it cannot be used to answer a phone call.

3. You can route audio to a Bluetooth device only if the Android device supports the use of SCO for off-call use cases.

### Solutions

1. Add the following lines in the `AndroidManifest.xml` file to request permissions to access the Bluetooth device:

    ```
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
   ```

2. Check if the Bluetooth device supports SCO. If not, switch to a SCO-capable Bluetooth device.

3. Call the Android native API `AudioManmager.isBlluetoothScoAvailableOffCall` method to check if the device supports the use of SCO for off-call use cases. If the device does not support the feature, the user can only answer the call using the system default audio route.