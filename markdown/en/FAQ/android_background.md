---
title: Why is no audio or video captured on Android 9 devices?
platform: ["Android"]
updatedAt: 2020-04-28 18:03:44
Products: ["Voice","Video","Interactive Broadcast"]
---
When an Android 9 device locks its screen or the app on the device runs in the background, the SDK may fail to capture the audio or video.

According to the Android Developer website, this is a system restriction:

> **Limited access to sensors in background**
> Android 9 limits the ability for background apps to access user input and sensor data. If your app is running in the background on a device running on Android 9, the system applies the following restrictions to your app:
> * Your app cannot access the microphone or camera.
> * Sensors that use the continuous reporting mode, such as accelerometers and gyroscopes, don't receive events.
> * Sensors that use the on-change or one-shot reporting modes don't receive events.
> If your app needs to detect sensor events on devices running on Android 9, use a foreground service.

See [Behavior changes: all apps](https://developer.android.com/about/versions/pie/android-9.0-changes-all).

Developers can use **Foreground Service** to work around this restriction.
If you need to use an Android 9 device to capture audio or video after the device locks its screen, you can start a foreground service before the screen locks, and stop the service before exiting the screen lock. On how to start a service, see https://developer.android.com/reference/android/app/Service.