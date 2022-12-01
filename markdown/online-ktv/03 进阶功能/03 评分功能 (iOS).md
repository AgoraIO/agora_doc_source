Agora 在线 K 歌房支持歌唱评分功能，即把演唱者和歌曲原唱的音调进行对比，并实时将匹配度以动画和分数的方式呈现在界面上。

<img src="https://web-cdn.agora.io/docs-files/1652180655314" style="zoom:80%;" />

## 前提条件

在实现评分功能前，请确保你已在项目中集成 Agora 音频 SDK v4.0.0 Beta，并实现在线 K 歌功能，详见如下教程：

- [客户端实现（合唱功能 Android)](https://docs.agora.io/cn/online-ktv/chorus_client_android?platform=Android)
- [客户端实现（合唱功能 iOS)](https://docs.agora.io/cn/online-ktv/chorus_client_ios?platform=iOS)

## 实现方法

1. 调用 `enableAudioVolumeIndication` 方法开启歌唱评分功能。示例代码如下：

```java
// Java
getRtcEngine().enableAudioVolumeIndication(30, 10, true);
```

```swift
// Swift
rtc.enableAudioVolumeIndication(20, smooth: 3, reportVad: true)
```

2. 成功开启歌唱评分功能后，只要频道内有发流用户，SDK 会在加入频道后按设置的时间间隔触发音量信息提示回调。你需要设置该回调监听，以获取本地用户的人声音调（`voicePitch`）。

```java
// Java
@Override
public void onAudioVolumeIndication(AudioVolumeInfo[] speakers, int totalVolume) {
    for(AudioVolumeInfo info : speakers){
        if(info.uid == 0 && info.voicePitch > 0){
            mMainThreadDispatch.onLocalPitch(info.voicePitch);
 }
    }
}
```

```swift
// Swift
func rtcEngine(_: AgoraRtcEngineKit, reportAudioVolumeIndicationOfSpeakers speakers: [AgoraRtcAudioVolumeInfo], totalVolume _: Int) {
    voicePitchRelay.accept(speakers.map { $0.voicePitch })
}
```

3. 将获取到的 `voicePitch` 传递到歌词组件，示例代码如下：

   如何使用歌词组件实现评分效果，请参考[歌词组件使用教程 Android 端](https://docs.agora.io/cn/online-ktv/ktv_lrcview_android?platform=Android) 或 [歌词组件使用教程 iOS 端](https://docs.agora.io/cn/online-ktv/ktv_lrcview_android?platform=Android)。

```java

// Java
@Override
public void onLocalPitch(double pitch) {
    super.onLocalPitch(pitch);
 mBinding.lrcControlView.getPitchView().updateLocalPitch(pitch);
}
```

```swift
// Swift
RoomManager.shared().subscribeVoicePitch().subscribe { result in
    guard let value = result.element else { return }
    self.lrcScoreView.setVoicePitch(value)
}.disposed(by: disposeBag)
```

## API 参考

### Android

- [`enableAudioVolumeIndication`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_enableaudiovolumeindication)
- [`onAudioVolumeIndication`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/class_irtcengineeventhandler.html#callback_onaudiovolumeindication) 

### iOS

- [`enableAudioVolumeIndication`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/class_irtcengine.html#api_enableaudiovolumeindication)
- [`reportAudioVolumeIndicationOfSpeakers`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/class_irtcengineeventhandler.html#callback_onaudiovolumeindication)