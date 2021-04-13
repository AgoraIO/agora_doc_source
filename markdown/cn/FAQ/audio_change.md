---
title: 为什么在 Android 设备上切换到其他 app 会改变音频路由？
platform: ["Android"]
updatedAt: 2021-02-05 05:16:33
Products: ["Voice","Video","Interactive Broadcast","live-streaming","Audio Broadcast"]
---
## 问题描述

在 Android 设备上使用集成了 Agora RTC SDK 的 app （以下简称 SDK app）进行实时音视频互动，切换到其他有音频输入或输出的 app，再切换回 SDK app 之后 SDK 的音频路由发生改变。

例如，用户在 SDK app 中通话并启用扬声器，通话过程中用听筒模式接听了 QQ 语音电话，结束 QQ 语音电话后返回 SDK app 通话，音频仍然通过听筒播放。

## 问题原因

在 Android 设备上从 SDK app 切换到其他 app 时，其他 app 可能会修改 SDK 的音频路由。由于 SDK 没有权限检测其他 app 对音频路由的修改，也无法判断是否已从其他 app 切换回来，因此切换回 SDK app 后仍然使用其他 app 的音频路由设置。

## 解决方案

在安卓原生方法 `onResume` 中检测当前的音频路由，然后调用 `setEnableSpeakerphone` 方法重新设置音频路由。可参考以下示例代码。

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
            // 在此处调用 setEnableSpeakerphone 方法，设置音频路由为听筒或扬声器
        } else {
            Log.d("LOG:", "AUDIO_ROUTE_EARPIECE");
            // 在此处调用 setEnableSpeakerphone 方法，设置音频路由为听筒或扬声器
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

## 相关链接
[为什么 iOS 或 Android 设备连接蓝牙设备后不能通过蓝牙设备接电话？](https://docs.agora.io/cn/Interactive%20Broadcast/faq/ios_bluetooth)