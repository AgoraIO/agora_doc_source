---
title: Why does the audio routing change after I switch to another app on an Android device?
platform: ["Android"]
updatedAt: 2021-02-05 05:19:04
Products: ["Voice","Video","Interactive Broadcast","live-streaming","Audio Broadcast"]
---
## Issue description

When using an app integrated with an Agora SDK (an "SDK app") for real-time communication on an Android device, if you switch to another app that has audio input and/or output and return to the SDK app, the audio routing of the SDK changes.

For example, during a video call in the SDK app through the speaker, you answer a voice call with the earpiece in another app. When you end the voice call and return to the SDK app, the video call's audio is now routed to the earpiece.

## Reason

When switching from the SDK app to another app on Android devices, the latter may change the original audio routing of the SDK. The SDK does not have permission to detect such changes and cannot determine whether you have switched back to using the SDK app. Therefore, when the you return to the SDK app, the audio routing set by the other app remains in use.

## Solution

Perform the following steps in `onResume` (an Android API):

1. Retrieve the current audio routing of the SDK.
2. Call `setEnableSpeakerphone` to reset the audio routing of the SDK.

See the following code sample:

```
@Override
  
    protected void onResume() {
        super.onResume();
        AudioManager am = getAudioManager();
        if (am.isSpeakerphoneOn()) {
            Log.d("LOG:", "AUDIO_ROUTE_SPEAKERPHONE");
        } else if (am.isBluetoothScoOn() || am.isBluetoothA2dpOn()) {
            Log.d("LOG:", "AUDIO_ROUTE_HEADSETBLUETOOTH");
        } else if (am.isWiredHeadsetOn()) {
            Log.d("LOG:", "AUDIO_ROUTE_HEADSET");
            // Call setEnableSpeakerphone here to route the audio output to the speaker or earpiece
        } else {
            Log.d("LOG:", "AUDIO_ROUTE_EARPIECE");
            // Call setEnableSpeakerphone here to route the audio output to the speaker or earpiece
        }
    }
  
    public AudioManager getAudioManager() {
        Context context = this.getApplicationContext();
        if (context == null) {
            return null;
        }
  
        return (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
    }
```

## Relevant links
[Why can't I answer calls through a Bluetooth device after connecting it to an iOS or Android device](https://docs.agora.io/en/Interactive%20Broadcast/faq/ios_bluetooth)
