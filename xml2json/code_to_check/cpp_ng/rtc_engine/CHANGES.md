Note: Please update this file for every Agora API change you do. Simply fill in
your updates in the Working section below.

# Agora High Level APIs (Working)

# API (yyyy-mm-dd)

Purpose of this change

## API file name #1

**Add:**
Short description

-   Foo()
-   Bar()

**Modified:**
Short description

-   Changes Foo() to Foo1()
-   Changes Bar() to Bar1()

**Deleted:**
Short description

-   Deleted Foo()

API file name #2

# API (2022-06-10)

IAgoraRtcEngine.h

**Modified:**
Add loadExtensionProvider for Android

# API (2022-05-27)

## IAgoraRtcEngine.h

**Modified:**

-   # modify annotation in ScreenCapture api

# API(2022-05-27)

## IAgoraRtcEngine.h

**Modified: remove channel param**

-   remove channel from onSnapshotTaken

## IAgoraRtcEngineEx.h

**Modified:**

-   # remoteUid -> uid from takeSnapshot

# API (2022-05-13)

## IAgoraRtcEngine.h

**Add:**

-   int startScreenCaptureByDisplayId(uint32_t displayId, const Rectangle& regionRect,
    const ScreenCaptureParameters& captureParams);

-   # int setScreenCaptureScenario(SCREEN_SCENARIO_TYPE screenScenario);

# API(2022-04-24)

## IAgoraRtcEngine.h

**Add:**

-   ChannelMediaOptions::isInteractiveAudience

# API(2022-04-21)

## IAgoraRtcEngine.h

Update CameraCapturerConfiguration
**Add:**

-   `bool followEncodeDimensionRatio`

# API (2022-04-19)

## IAgoraRtcEngine.h

**Delete:**

-   AudioOptionsExternal

# API(2022-03-31)

## IAgoraRtcEngine.h

**Add:**

-   int64_t getCurrentMonotonicTimeInMs()

# API(2022-04-11)

## IAgoraRtcEngine.h

**Add:**

-   int enableVideoImageSource(bool enable, const ImageTrackOptions& options)

# API (2022-03-28)

## IAgoraRtcEngine.h

**Deleted:**

-   virtual int takeSnapshot(media::SnapShotConfig &config, media::ISnapshotCallback\* callback) = 0;

---

**Add:**

-   virtual int takeSnapshot(uid_t remoteUid, const char\* filePath) = 0;

## IAgoraRtcEngineEx.h

**Modified: add remoteUid param**

-   irtual void onSnapshotTaken(const RtcConnection& connection, uid_t remoteUid, const char\* filePath, int width, int height, int errCode)

# API (2022-03-24)

## IAgoraRtcEngine.h

**Modified:**

-   AudioOptionsAdvanced renamed to AudioOptionsExternal

# API(2021-11-27)

modify setExternalVideoSource

## IAgoraMediaEngine.h

**Modifed:**

-   add one more parameter opt for setExternalVideoSource.

# API (2022-03-07)

## IAgoraRtcEngine.h

**Add:**

-   QUALITY_ADAPT_INDICATION quality_adapt_indication

# API (2022-03-04)

## IAgoraRtcEngine.h

**Modified: add deviceName param**
virtual int enableLoopbackRecording(bool enabled, const char\* deviceName = NULL)

## IAgoraRtcEngineEx.h

**Modified: add deviceName param**
virtual int enableLoopbackRecordingEx(const RtcConnection& connection, bool enabled, const char\* deviceName = NULL)

# API (2022-03-04)

## IAgoraRtcEngine.h

**Add:**
Add fields in RemoteVideoStats

-   superResolutionType

# API (2022-02-27)

## IAgoraRtcEngine.h

**Modified:**
Modify arguments name

## IAgoraRtcEngineEx.h

**Modified:**
Modify arguments name

# API (2022-02-24)

## multiple head files

**Modified:**

-   fix param warnings on xcode

# API (2022-02-11)

## IAgoraRtcEngineEx.h

**Add:**

-   virtual int getUserInfoByUserAccountEx(const char*, rtc::UserInfo*, const RtcConnection&) = 0;
-   virtual int getUserInfoByUidEx(uid_t, rtc::UserInfo\*, const RtcConnection&) = 0;

# API (2022-02-10)

## IAgoraRtcEngine.h

**Modified:**

-   Delete the last two parameters of IRtcEngine::getUserInfoByUserAccount
-   Delete the last two parameters of IRtcEngine::getUserInfoByUid

# API (2022-02-25)

## IAgoraRtcEngine.h

**add: IVideoDeviceManager **

-   virtual int numberOfCapabilities(const char\* deviceIdUTF8) = 0;
-   virtual int getCapability(const char\* deviceIdUTF8, const uint32_t deviceCapabilityNumber, VideoFormat& capability) = 0;

# API (2022-02-09)

## IAgoraRtcEngine.h

**add: setRemoteVideoSubscriptionOptions **

-   virtual int setRemoteVideoSubscriptionOptions(uid_t uid, const VideoSubscriptionOptions &options) = 0;

## IAgoraRtcEngineEx.h

**add: setRemoteVideoSubscriptionOptionsEx **

-   virtual int setRemoteVideoSubscriptionOptionsEx(uid_t uid, const VideoSubscriptionOptions& options, const RtcConnection& connection) = 0;

# API (2022-01-27)

## IAgoraRtcEngine.h

**Modified:**

-   change DirectCdnStreamStats to DirectCdnStreamingStats
-   onDirectCdnStreamingStateChanged
-   onDirectCdnStreamingStats

# API (2022-01-26)

## IAgoraRtcEngine.h

**Deleted:**

-   delete bool stopPreview from LeaveChannelOptions

# API (2022-01-25)

## IAgoraRtcEngine.h

**Add:**

-   struct AudioOptionsAdvanced

# API (2022-01-20)

## IAgoraRtcEngine.h

**Deleted:**

-   virtual int setExternalAudioSource(bool enabled, int sampleRate, int channels, int sourceNumber = 1, bool localPlayback = false, bool publish = true) = 0;
-   virtual int setExternalAudioSink(int sampleRate, int channels) = 0;
-   virtual int pullAudioFrame(media::IAudioFrameObserver::AudioFrame\* frame) = 0;

## IAgoraMediaEngine.h

**Add:**
virtual int setExternalAudioSink(int sampleRate, int channels) = 0;

# API (2022-01-20)

## IAgoraRtcEngine.h

**Add:**

-   int setAVSyncSource(const char\* channelId, uid_t uid)

# API (2022-01-12)

## IAgoraRtcEngine.h

**Add:**

-   add Optional<bool> startPreview to ChannelMediaOptions
-   add bool stopPreview to LeaveChannelOptions

# API (2022-01-29)

## IAgoraRtcEngineEx.h

**add: enableAudioVolumeIndicationEx **

-   virtual int enableAudioVolumeIndicationEx(int interval, int smooth, bool reportVad, const RtcConnection& connection) = 0;

# API (2022-01-10)

## IAgoraRtcEngine.h

**Modify: volume range **

-   virtual int adjustUserPlaybackSignalVolume(unsigned int uid, int volume) = 0;

# API (2022-01-09)

## IAgoraRtcEngine.h

**Add:**

-   struct SIZE for MAC
-   struct ThumbImageBuffer
-   enum ScreenCaptureSourceType
-   struct ScreenCaptureSourceInfo
-   class IScreenCaptureSourceList
-   virtual IScreenCaptureSourceList\* getScreenCaptureSources(const SIZE& thumbSize, const SIZE& iconSize, const bool includeScreen)

# API (2022-01-05)

## IAgoraRtcEngine.h

**Modified:**

-   change default RtcEngineContext#audioScenario from 'AUDIO_SCENARIO_HIGH_DEFINITION' to 'AUDIO_SCENARIO_DEFAULT'

# API (2022-01-05)

change api comment

## IAgoraRtcEngine.h

**Modified:**

-   int enableVirtualBackground(bool enabled, VirtualBackgroundSource backgroundSource)

# API(2021-12-28)

## IAgoraRtcEngine.h

**Add:**

-   virtual int setAdvancedAudioOptions(media::base::AdvancedAudioOptions &options) = 0;
-   # API(2021-12-27)
    IAgoraRtcEngine.h

---

**Deleted:**

-   virtual int setLocalVoiceReverbPreset(AUDIO_REVERB_PRESET reverbPreset)
-   virtual int setLocalVoiceChanger(VOICE_CHANGER_PRESET voiceChanger)

# API(2021-12-20)

## IAgoraRtcEngine.h

**Add:**
Add bool useExternalEglContext for RtcEngineContext

# API(2021-11-17)

## IAgoraRtcEngine.h

**Add:**

-   int getAudioDeviceInfo(DeviceInfo& deviceInfo)

# API (2021-12-23)

## IAgoraRtcEngine.h

**Add:**

-   int int enableSpatialAudio(bool enabled)
-   int setRemoteUserSpatialAudioParams(uid_t uid, const agora::SpatialAudioParams& params)

## IAgoraRtcEngineEx.h

**Add:**

-   int setRemoteUserSpatialAudioParamsEx(uid_t uid, const agora::SpatialAudioParams& param, const RtcConnection& connection)

# API(2021-12-10)

IAgoraRtcEngine.h
IAgoraRtcEngineEx.h

---

**Add:**

-   virtual void onClientRoleChangeFailed(CLIENT_ROLE_CHANGE_FAILED_REASON reason, CLIENT_ROLE_TYPE currentRole)

# API (2021-12-03)

## IAgoraRtcEngine.h

**Modified:**

-   Add callback function onUserStateChanged() and enum REMOTE_USER_STATE.

# API(2021-12-1)

## IAgoraRtcEngine.h

**Add:**

-   int startRtmpStreamWithoutTranscoding(const char\* url)
-   int startRtmpStreamWithTranscoding(const char\* url, const LiveTranscoding& transcoding)
-   int updateRtmpTranscoding(const LiveTranscoding& transcoding)
-   int stopRtmpStream(const char\* url)
-   void onRtmpStreamingEvent(const char\* url, RTMP_STREAMING_EVENT eventCode)

# API(2021-11-24)

## IAgoraRtcEngine.h

**Modifed:**

-   Replace tab with spaces

# API(2021-11-23)

## IAgoraMediaEngine.h

**Add:**

-   int setDirectExternalAudioSource(bool enable, bool localPlayback = false)
-   int pushDirectAudioFrame(media::IAudioFrameObserver::AudioFrame\* frame)

# API (2021-12-01)

Add publishMediaPlayerAudioTrack and publishMediaPlayerId field in DirectCdnStreamingMediaOptions.

## IAgoraRtcEngine.h

**Add:**
Add `publishMediaPlayerId` and `publishMediaPlayerAudioTrack` field for struct `DirectCdnStreamingMediaOptions`

-   struct DirectCdnStreamingMediaOptions::publishMediaPlayerAudioTrack
-   struct DirectCdnStreamingMediaOptions::publishMediaPlayerId

# API(2021-12-09)

## IAgoraRtcEngineEx.h

**Add:**

-   addPublishStreamUrlEx

# API(2021-11-18)

## IAgoraRtcEngine.h

**Modify:**

-   provider_name -> provider
-   ext_name -> extension
-   json_value -> value

## IAgoraRtcEngineEx.h

**Modify:**

-   remoteUid -> uid

# API (2021-11-23)

## IAgoraRtcEngine.h

**Add:**
Add filed in LocalVideoStats

-   `int captureFrameRate`
-   `int regulatedCaptureFrameRate`
-   `int captureFrameWidth`
-   `int captureFrameHeight`
-   `int regulatedCaptureFrameWidth`
-   `int regulatedCaptureFrameHeight`

# API(2021-11-17)

## IAgoraRtcEngine.h

**Modifed:**
add macro to switch parameters on different platform

-   limit CAMERA_DIRECTION cameraDirection only on Android and IOS

## IAgoraRtcEngine.h

**Add:**

-   int setAudioSessionOperationRestriction(AUDIO_SESSION_OPERATION_RESTRICTION restriction)

# API (2021-11-15)

Add enableRemoteSuperResolution for Super Resolution

## IAgoraRtcEngine.h

**Add:**

-   int enableRemoteSuperResolution(uid_t userId, bool enable) = 0;

# API(2021-11-03)

## rtc_engine_i.h

**Deleted:**

-   virtual const char\* getSourceVersion() const = 0;

# API(2022-03-08)

## IAgoraRtcEngine.h

**Add:**

-   LocalVideoStats.txPacketLossRate

# API(2022-04-20)

## IAgoraRtcEngine.h

**Add:**

-   IRtcEngine::setEarMonitoringAudioFrameParameters()

# API(2021-11-08)

## IAgoraRtcEngine.h

**Add:**

-   int setAudioSessionOperationRestriction(AUDIO_SESSION_OPERATION_RESTRICTION restriction)

# API(2021-08-30)

## IAgoraRtcEngine.h

**Add:**

-   int takeSnapshot(media::SnapShotConfig &config, media::ISnapshotCallback\* callback)

# API(2021-08-30)

## IAgoraRtcEngine.h

**Add:**

-   int SetContentInspect(media::ContentInspectConfig &config)
    API(2021-08-30)
    ==================================================
    IAgoraRtcEngine.h

---

**Add:**

-   int SetContentInspect(media::ContentInspectConfig &config)

# API(2021-10-27)

## IAgoraRtcEngine.h

**Add:**

-   int adjustCustomAudioPublishVolume(int32_t sourceId, int volume)
-   int adjustCustomAudioPlayoutVolume(int32_t sourceId, int volume)

# API(2021-10-20)

## IAgoraRtcEngine.h

\*Add:\*\*

-   Add enableEchoCancellationExternal() for IRtcEngine
-   Add publishCustomAudioTrackAec for ChannelMediaOptions

## IAgoraMediaEngine.h

\*Add:\*\*

-   Add pushCaptureAudioFrame()
-   Add pushReverseAudioFrame()

# API(2021-10-19)

## IAgoraRtcEngine.h

\*Modified:\*\*

-   virtual int startAudioRecording(const AudioRecordingConfiguration& config) = 0;

# API (2021-10-18)

## IAgoraRtcEngine.h

**Add:**
void onUserMuteAudio(uid_t uid, bool muted)

# API(2021-10-15)

## IAgoraRtcEngine.h

**Add:**

-   add int enableDualStreamModeEx(VIDEO_SOURCE_TYPE sourceType, bool enabled,
    const SimulcastStreamConfig& streamConfig,
    const RtcConnection& connection)

# API(2021-10-12)

## IAgoraRtcEngine.h

\*Modified:\*\*

-   format int setLocalVoiceChanger(VOICE_CHANGER_PRESET voiceChanger) docs

# API(2021-10-11)

## IAgoraRtcEngineEx.h

**Modified:**

-   Update for C++ 98 standard

# API (2021-10-09)

**Modified:**

-   enum DIRECT_CDN_STREAMING_STATE_RUNNING

# API(2021-08-30)

## IAgoraRtcEngine.h

**Add:**

-   int SetContentInspect(media::ContentInspectConfig &config)
    API(2021-08-30)
    ==================================================
    IAgoraRtcEngine.h

---

**Add:**

-   # int SetContentInspect(media::ContentInspectConfig &config)
    NGIAgoraRtmpConnection.h

---

**Add:**

-   enum RTMP_CONNECTION_ERROR::RTMP_CONNECTION_ERR_BAD_NAME

---

\*Modified:\*\*

-   Add enableBuiltInMediaEncryption for ChannelMediaOptions

# API(2021-09-23)

## IAgoraRtcEngineEx.h

**Add:**

-   int enableEncryptionEx(const RtcConnection& connection, bool enabled, const EncryptionConfig& config)

# API(2021-09-03)

## IAgoraMediaEngine.h

\*Modified:\*\*

-   change a parameter for setExternalVideoSource

# API (2021-09-24)

Add enableVirtualBackground for Virtual Background Setting

## IAgoraRtcEngine.h

**Add:**

-   int enableVirtualBackground(bool enabled, VirtualBackgroundSource backgroundSource)

# API(2021-09-17)

## IAgoraRtcEngine.h

**Add:**

-   Add enum MEDIA_DEVICE_STATE_IDLE for MEDIA_DEVICE_STATE_TYPE

# API(2021-09-03)

## IAgoraRtcEngine.h

\*Modified:\*\*

-   add pauseAllChannelMediaRelay
-   add resumeAllChannelMediaRelay
-   add switchChannel

# API(2021-09-08)

## IAgoraRtcEngine.h

**Add:**

-   int startRhythmPlayer(const char* sound1, const char* sound2, const AgoraRhythmPlayerConfig& config)
-   int stopRhythmPalyer()
-   int configRhythmPlayer(AgoraRhythmPlayerConfig& config)
-   publishRhythmPlayerTrack for ChannelMediaOptions
-   RHYTHM_PLAYER_STATE_TYPE
-   RHYTHM_PLAYER_ERROR_TYPE
-   onRhythmPlayerStateChanged for IRtcEngineEventHandler

# API (2021-09-02)

## IAgoraRtcEngine.h

**Add:**

-   Add thread priority option

# API(2021-09-01)

## IAgoraRtcEngine.h

\*Modified:\*\*

-   change the bad micro WEBRTC to **ANDROID**
    API (2021-08-12)
    ==================================================
    Gets the NTP time.

## rtc_engine_i.h

**Add:**
base::NtpTime getNtpTime()

# API (2021-08-18)

Add setAppType

## rtc_engine_i.h

**Add:**
Add int32_t setAppType(APP_TYPE appType)

# API (2021-08-18)

Add enum APP_TYPE

## rtc_engine_i.h

**Add:**

-   APP_TYPE_INVALID_VALUE = -1
-   APP_TYPE_NATIVE = 0
-   APP_TYPE_COCOS = 1
-   APP_TYPE_UNITY = 2
-   APP_TYPE_ELECTRON = 3
-   APP_TYPE_FLUTTER = 4
-   APP_TYPE_UNREAL = 5
-   APP_TYPE_XAMARIN = 6

# API (2021-08-18)

## IAgoraRtcEngine.h

**Modified:**

-   onActiveSpeaker modify comment info

# API (2022-01-19)

## NGIAgoraAudioTrack.h

**Add:**

-   IAudioTrack::AudioFilterPosition::PcmSource
-   IAudioTrack::AudioFilterPosition::PcmSourceSending
-   IAudioTrack::AudioFilterPosition::PcmSourcePlayback

# API (2021-09-03)

## IAgoraRtcEngineEx.h

**Delete:**

-   struct RtcEngineContextEx
-   IRtcEngineEx::initialize()

# API(2021-08-13)

## IAgoraRtcEngine.h

**Add:**

-   int setScreenCaptureOrientation(MEDIA_SOURCE_TYPE type, VIDEO_ORIENTATION orientation)

# API(2021-11-14)

## IAgoraRtcEngine.h

**Add:**

-   IRtcEngine::enableCustomAudioLocalPlayback

## IAgoraMediaEngine.h.h

**Add:**

-   IMediaEngine::enableCustomAudioLocalPlayback

# API (2021-08-11)

## IAgoraRtcEngine.h

**Modified:**
Deprecate setEncryptionMode and setEncryptionSecret, correct description of enableEncryption

-   setEncryptionMode
-   setEncryptionSecret
-   enableEncryption

# API (2021-08-11)

## IAgoraRtcEngine.h

**Add:**

-   Add getExtensionProperty

# API (2021-08-05)

Add setAudioMixingPitch

## IAgoraRtcEngine.h

**Add:**
Add int setAudioMixingPitch(int pitch)

# API (2021-11-09)

## IAgoraRtcEngine.h

**Add:**

-   RemoteVideoStats.totalActiveTime
-   RemoteVideoStats.publishDuration

# API (2021-08-04)

## IAgoraRtcEngine.h

**Modified:**

-   Add `MEDIA_SOURCE_TYPE type` parameter in setBeautyEffectOptions
-   Add `MEDIA_SOURCE_TYPE type` parameter in setExtensionProperty
-   Add `MEDIA_SOURCE_TYPE type` parameter in getExtensionProperty
-   Add `MEDIA_SOURCE_TYPE type` parameter in enableExtension

**Add:**

-   Add `int setExtensionProviderProperty(const char* provider_name, const char* key, const char* json_value)`

## IAgoraMediaEngine.h

**Delete:**

-   Remove MEDIA_SOURCE_TYPE

# API (2021-07-29)

## IAgoraRtcEngine.h

**Add:**

-   ChannelMediaOptions::audienceLatencyLevel
-   int setClientRole(CLIENT_ROLE_TYPE role, const ClientRoleOptions& options)

# API (2021-07-22)

## IAgoraRtcEngine.h

**Add:**

-   Add token to ChannelMediaOptions

# API (2021-07-20)

Add setBeautyEffectOptions for Beauty Parameter Setting

## IAgoraRtcEngine.h

**Add:**

-   int setBeautyEffectOptions(bool enabled, const BeautyOptions& options)

# API (2021-05-14)

## IAgoraRtcEngine.h

**Modified:**

-   Move int setCameraCapturerConfiguration(const CameraCapturerConfiguration& config) out of MICRO ANDROID

# API (2021-07-05)

## IAgoraRtcEngine.h

**Add:**

-   Add publishCustomAudioTrackEnableAec for ChannelMediaOptions

# API (2021-09-23)

## IAgoraRtcEngineEx.h

**Add:**

-   IRtcEngineEx::setRemoteVideoStreamTypeEx()

# API (2021-06-28)

Change extension loading mechanism

## IAgoraRtcEngineEx.h

**Deleted:**

-   extension provider list from the RtcEngineContext

## IAgoraRtcEngine.h

**Add:**

-   loadExtensionProvider for loading extension binary explicitly (for Windows&Linux)

# API (2021-06-03)

## IAgoraRtcEngine.h

**Modified:**

-   remove IAudioDeviceManager
-   remove IAudioDeviceCollection

# API (2021-09-22)

## IAgoraMediaEngine.h

**Add:**

-   int startAudioMixing(const char\* filePath, bool loopback, bool replace, int cycle, int startPos)

# API (2021-09-10)

## IAgoraRtcEngineEx.h

**Add:**

-   IRtcEngineEventHandlerEx::onJoinChannelSuccess
-   IRtcEngineEventHandlerEx::onRejoinChannelSuccess

# API (2021-05-22)

Modify note of setClientRole

## IAgoraRtcEngine.h

**Modified:**

-   note of setClientRole

# API (2021-05-17)

## IAgoraRtcEngine.h

**Modified:**

-   int enableExtension(const char* provider_name, const char* extension_name, bool enable)
-   int setExtensionProperty(const char* provider_name, const char* extension_name, const char* key, const char* json_value)

# API (2021-08-16)

## IAgoraMediaEngine.h

**Delete:**

-   IMediaEngine::pushPrimaryAudioFrame()
-   IMediaEngine::pushSecondaryAudioFrame()
-   IMediaEngine::setExternalVideoConfigEx()

**Modified:**

-   IMediaEngine::pushVideoFrame(base::ExternalVideoFrame* frame, rtc::conn_id_t connectionId = rtc::DEFAULT_CONNECTION_ID) to pushVideoFrame(base::ExternalVideoFrame* frame) and pushVideoFrame(base::ExternalVideoFrame\* frame, const rtc::RtcConnection& connection)
-   IMediaEngine::pushEncodedVideoImage(const uint8_t* imageBuffer, size_t length, const agora::rtc::EncodedVideoFrameInfo& videoEncodedFrameInfo, rtc::conn_id_t connectionId = rtc::DEFAULT_CONNECTION_ID) to pushEncodedVideoImage(const uint8_t* imageBuffer, size_t length, const agora::rtc::EncodedVideoFrameInfo& videoEncodedFrameInfo) and pushEncodedVideoImage(const uint8_t\* imageBuffer, size_t length, const agora::rtc::EncodedVideoFrameInfo& videoEncodedFrameInfo, const rtc::RtcConnection& connection)

## IAgoraRtcEngine.h

**Add:**

-   IRtcEngineEventHandler::eventHandlerType()
-   IRtcEngineEventHandler::onExtensionEvent()
-   IRtcEngineEventHandler::onExtensionStarted()
-   IRtcEngineEventHandler::onExtensionStopped()
-   IRtcEngineEventHandler::onExtensionErrored()
-   IRtcEngineEventHandler::onUserAccountUpdated()

**Modified:**

-   IRtcEngineEventHandler::onStreamMessage(uid_t userId, int streamId, const char* data, size_t length) to onStreamMessage(uid_t userId, int streamId, const char* data, size_t length, uint64_t sentTs)
-   IRtcEngine::updateChannelMediaOptions(const ChannelMediaOptions& options, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to updateChannelMediaOptions(const ChannelMediaOptions& options)
-   IRtcEngine::setVideoEncoderConfiguration(const VideoEncoderConfiguration& config, conn_id_t connectionId = DEFAULT_CONNECTION_ID) to setVideoEncoderConfiguration(const VideoEncoderConfiguration& config)
-   IRtcEngine::setupRemoteVideo(const VideoCanvas& canvas, conn_id_t connectionId = DEFAULT_CONNECTION_ID) to setupRemoteVideo(const VideoCanvas& canvas)
-   IRtcEngine::muteRemoteAudioStream(uid_t uid, bool mute, conn_id_t connectionId = DEFAULT_CONNECTION_ID) to muteRemoteAudioStream(uid_t uid, bool mute)
-   IRtcEngine::muteRemoteVideoStream(uid_t uid, bool mute, conn_id_t connectionId = DEFAULT_CONNECTION_ID) to muteRemoteVideoStream(uid_t uid, bool mute)
-   IRtcEngine::setRemoteVoicePosition(uid_t uid, double pan, double gain, conn_id_t connectionId = DEFAULT_CONNECTION_ID) to setRemoteVoicePosition(uid_t uid, double pan, double gain)
-   IRtcEngine::setRemoteRenderMode(uid_t uid, media::base::RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode, conn_id_t connectionId = DEFAULT_CONNECTION_ID) to setRemoteRenderMode(uid_t uid, media::base::RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode, VIDEO_MIRROR_MODE_TYPE mirrorMode)
-   IRtcEngine::getConnectionState(conn_id_t connectionId = 0) to getConnectionState()
-   IRtcEngine::createDataStream(int* streamId, bool reliable, bool ordered, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to createDataStream(int* streamId, bool reliable, bool ordered)
-   IRtcEngine::createDataStream(int* streamId, DataStreamConfig& config, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to createDataStream(int* streamId, DataStreamConfig& config)
-   IRtcEngine::sendStreamMessage(int streamId, const char* data, size_t length, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to sendStreamMessage(int streamId, const char* data, size_t length)
-   IRtcEngine::addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options)
-   IRtcEngine::clearVideoWatermark(conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to clearVideoWatermark()
-   IRtcEngine::sendCustomReportMessage(const char* id, const char* category, const char* event, const char* label, int value, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to sendCustomReportMessage(const char* id, const char* category, const char* event, const char* label, int value)
-   IRtcEngine::joinChannelWithUserAccountEx(const char* token, const char* channelId, const char* userAccount, const ChannelMediaOptions& options, IRtcEngineEventHandler* eventHandler, conn_id_t* connectionId = 0) to joinChannelWithUserAccountEx(const char* token, const char* channelId, const char* userAccount, const ChannelMediaOptions& options, IRtcEngineEventHandler\* eventHandler)
-   IRtcEngine::getUserInfoByUserAccount(const char* userAccount, rtc::UserInfo* userInfo, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to getUserInfoByUserAccount(const char* userAccount, rtc::UserInfo* userInfo, const char* channelId = NULL, const char* localUserAccount = NULL)
-   IRtcEngine::getUserInfoByUid(uid_t uid, rtc::UserInfo* userInfo, conn_id_t connectionId = agora::rtc::DEFAULT_CONNECTION_ID) to getUserInfoByUid(uid_t uid, rtc::UserInfo* userInfo, const char* channelId = NULL, const char* localUserAccount = NULL)

**Delete:**

-   IRtcEngineEventHandler::onRemoteAudioMixingBegin()
-   IRtcEngineEventHandler::onRemoteAudioMixingEnd()
-   IRtcEngineEventHandler::onRefreshRecordingServiceStatus()
-   IRtcEngineEventHandler::onMediaEngineLoadSuccess()
-   IRtcEngineEventHandler::onMediaEngineStartCallSuccess()
-   IRtcEngineEventHandler::onStreamInjectedStatus()
-   IRtcEngineEventHandler::setRemoteRenderMode()
-   RtcEngineContext.eventHandlerEx
-   IRtcEngine::joinChannelEx()
-   IRtcEngine::leaveChannelEx()
-   IRtcEngine::setRemoteRenderMode(uid_t uid, media::base::RENDER_MODE_TYPE renderMode, conn_id_t connectionId = DEFAULT_CONNECTION_ID)
-   IRtcEngine::enableLoopbackRecording(conn_id_t connectionId, bool enabled)

## IAgoraRtcEngineEx.h

**Add:**

-   struct RtcConnection
-   struct RtcEngineContextEx
-   IRtcEngineEx::joinChannelEx()
-   IRtcEngineEx::leaveChannelEx()
-   IRtcEngineEx::updateChannelMediaOptionsEx()
-   IRtcEngineEx::setVideoEncoderConfigurationEx()
-   IRtcEngineEx::setupRemoteVideoEx()
-   IRtcEngineEx::muteRemoteAudioStreamEx()
-   IRtcEngineEx::muteRemoteVideoStreamEx()
-   IRtcEngineEx::setRemoteVoicePositionEx()
-   IRtcEngineEx::setRemoteRenderModeEx()
-   IRtcEngineEx::enableLoopbackRecordingEx()
-   IRtcEngineEx::getConnectionStateEx()
-   IRtcEngineEx::createDataStreamEx()
-   IRtcEngineEx::createDataStreamEx()
-   IRtcEngineEx::sendStreamMessageEx()
-   IRtcEngineEx::addVideoWatermarkEx()
-   IRtcEngineEx::clearVideoWatermarkEx()
-   IRtcEngineEx::sendCustomReportMessageEx()

**Modified:**

-   IRtcEngineEventHandlerEx::onAudioQuality(conn_id_t connId, uid_t uid, int quality, unsigned short delay, unsigned short lost) to onAudioQuality(const RtcConnection& connection, uid_t remoteUid, int quality, unsigned short delay, unsigned short lost)
-   IRtcEngineEventHandlerEx::onAudioVolumeIndication(conn_id_t connId, const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume) to onAudioVolumeIndication(const RtcConnection& connection, const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume)
-   IRtcEngineEventHandlerEx::onLeaveChannel(conn_id_t connId, const RtcStats& stats) to onLeaveChannel(const RtcConnection& connection, const RtcStats& stats)
-   IRtcEngineEventHandlerEx::onRtcStats(conn_id_t connId, const RtcStats& stats) to onRtcStats(const RtcConnection& connection, const RtcStats& stats)
-   IRtcEngineEventHandlerEx::onNetworkQuality(conn_id_t connId, uid_t uid, int txQuality, int rxQuality) to onNetworkQuality(const RtcConnection& connection, uid_t remoteUid, int txQuality, int rxQuality)
-   IRtcEngineEventHandlerEx::onIntraRequestReceived(conn_id_t connId) to onIntraRequestReceived(const RtcConnection& connection)
-   IRtcEngineEventHandlerEx::onFirstLocalVideoFrame(conn_id_t connId, int width, int height, int elapsed) to onFirstLocalVideoFrame(const RtcConnection& connection, int width, int height, int elapsed)
-   IRtcEngineEventHandlerEx::onFirstLocalVideoFramePublished(conn_id_t connId, int elapsed) to onFirstLocalVideoFramePublished(const RtcConnection& connection, int elapsed)
-   IRtcEngineEventHandlerEx::onVideoSourceFrameSizeChanged(conn_id_t connId, VIDEO_SOURCE_TYPE sourceType, int width, int height) to onVideoSourceFrameSizeChanged(const RtcConnection& connection, VIDEO_SOURCE_TYPE sourceType, int width, int height)
-   IRtcEngineEventHandlerEx::onFirstRemoteVideoDecoded(conn_id_t connId, uid_t uid, int width, int height, int elapsed) to onFirstRemoteVideoDecoded(const RtcConnection& connection, uid_t remoteUid, int width, int height, int elapsed)
-   IRtcEngineEventHandlerEx::onVideoSizeChanged(conn_id_t connId, uid_t uid, int width, int height, int rotation) to onVideoSizeChanged(const RtcConnection& connection, uid_t uid, int width, int height, int rotation)
-   IRtcEngineEventHandlerEx::onLocalVideoStateChanged(conn_id_t connId, LOCAL_VIDEO_STREAM_STATE state, LOCAL_VIDEO_STREAM_ERROR errorCode) to onLocalVideoStateChanged(const RtcConnection& connection, LOCAL_VIDEO_STREAM_STATE state, LOCAL_VIDEO_STREAM_ERROR errorCode)
-   IRtcEngineEventHandlerEx::onRemoteVideoStateChanged(conn_id_t connId, uid_t uid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed) to onRemoteVideoStateChanged(const RtcConnection& connection, uid_t remoteUid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed)
-   IRtcEngineEventHandlerEx::onFirstRemoteVideoFrame(conn_id_t connId, uid_t uid, int width, int height, int elapsed) to onFirstRemoteVideoFrame(const RtcConnection& connection, uid_t remoteUid, int width, int height, int elapsed)
-   IRtcEngineEventHandlerEx::onUserJoined(conn_id_t connId, uid_t uid, int elapsed) to onUserJoined(const RtcConnection& connection, uid_t remoteUid, int elapsed)
-   IRtcEngineEventHandlerEx::onUserOffline(conn_id_t connId, uid_t uid, USER_OFFLINE_REASON_TYPE reason) to onUserOffline(const RtcConnection& connection, uid_t remoteUid, USER_OFFLINE_REASON_TYPE reason)
-   IRtcEngineEventHandlerEx::onUserMuteVideo(conn_id_t connId, uid_t uid, bool muted) to onUserMuteVideo(const RtcConnection& connection, uid_t remoteUid, bool muted)
-   IRtcEngineEventHandlerEx::onUserEnableVideo(conn_id_t connId, uid_t uid, bool enabled) to onUserEnableVideo(const RtcConnection& connection, uid_t remoteUid, bool enabled)
-   IRtcEngineEventHandlerEx::onUserEnableLocalVideo(conn_id_t connId, uid_t uid, bool enabled) to onUserEnableLocalVideo(const RtcConnection& connection, uid_t remoteUid, bool enabled)
-   IRtcEngineEventHandlerEx::onLocalAudioStats(conn_id_t connId, const LocalAudioStats& stats) to onLocalAudioStats(const RtcConnection& connection, const LocalAudioStats& stats)
-   IRtcEngineEventHandlerEx::onRemoteAudioStats(conn_id_t connId, const RemoteAudioStats& stats) to onRemoteAudioStats(const RtcConnection& connection, const RemoteAudioStats& stats)
-   IRtcEngineEventHandlerEx::onLocalVideoStats(conn_id_t connId, const LocalVideoStats& stats) to onLocalVideoStats(const RtcConnection& connection, const LocalVideoStats& stats)
-   IRtcEngineEventHandlerEx::onRemoteVideoStats(conn_id_t connId, const RemoteVideoStats& stats) to onRemoteVideoStats(const RtcConnection& connection, const RemoteVideoStats& stats)
-   IRtcEngineEventHandlerEx::onConnectionLost(conn_id_t connId) to onConnectionLost(const RtcConnection& connection)
-   IRtcEngineEventHandlerEx::onConnectionInterrupted(conn_id_t connId) to onConnectionInterrupted(const RtcConnection& connection)
-   IRtcEngineEventHandlerEx::onConnectionBanned(conn_id_t connId) to onConnectionBanned(const RtcConnection& connection)
-   IRtcEngineEventHandlerEx::onStreamMessage(uid_t uid, int streamId, const char* data, size_t length, uint64_t sentTs) to onStreamMessage(const RtcConnection& connection, uid_t remoteUid, int streamId, const char* data, size_t length, uint64_t sentTs)
-   IRtcEngineEventHandlerEx::onStreamMessageError(conn_id_t connId, uid_t uid, int streamId, int code, int missed, int cached) to onStreamMessageError(const RtcConnection& connection, uid_t remoteUid, int streamId, int code, int missed, int cached)
-   IRtcEngineEventHandlerEx::onRequestToken(conn_id_t connId) to onRequestToken(const RtcConnection& connection)
-   IRtcEngineEventHandlerEx::onTokenPrivilegeWillExpire(conn_id_t connId, const char* token) to onTokenPrivilegeWillExpire(const RtcConnection& connection, const char* token)
-   IRtcEngineEventHandlerEx::onFirstLocalAudioFramePublished(conn_id_t connId, int elapsed) to onFirstLocalAudioFramePublished(const RtcConnection& connection, int elapsed)
-   IRtcEngineEventHandlerEx::onLocalAudioStateChanged(conn_id_t connId, LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_ERROR error) to onLocalAudioStateChanged(const RtcConnection& connection, LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_ERROR error)
-   IRtcEngineEventHandlerEx::onRemoteAudioStateChanged(conn_id_t connId, uid_t uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed) to onRemoteAudioStateChanged(const RtcConnection& connection, uid_t remoteUid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed)
-   IRtcEngineEventHandlerEx::onActiveSpeaker(conn_id_t connId, uid_t uid) to onActiveSpeaker(const RtcConnection& connection, uid_t uid)
-   IRtcEngineEventHandlerEx::onClientRoleChanged(conn_id_t connId, CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole) to onClientRoleChanged(const RtcConnection& connection, CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole)
-   IRtcEngineEventHandlerEx::onRemoteAudioTransportStats(conn_id_t connId, uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate) to onRemoteAudioTransportStats(const RtcConnection& connection, uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate)
-   IRtcEngineEventHandlerEx::onRemoteVideoTransportStats(conn_id_t connId, uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate) to onRemoteVideoTransportStats(const RtcConnection& connection, uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate)
-   IRtcEngineEventHandlerEx::onConnectionStateChanged(conn_id_t connId, CONNECTION_STATE_TYPE state, CONNECTION_CHANGED_REASON_TYPE reason) to onConnectionStateChanged(const RtcConnection& connection, CONNECTION_STATE_TYPE state, CONNECTION_CHANGED_REASON_TYPE reason)
-   IRtcEngineEventHandlerEx::onNetworkTypeChanged(conn_id_t connId, NETWORK_TYPE type) to onNetworkTypeChanged(const RtcConnection& connection, NETWORK_TYPE type)
-   IRtcEngineEventHandlerEx::onEncryptionError(conn_id_t connId, ENCRYPTION_ERROR_TYPE errorType) to onEncryptionError(const RtcConnection& connection, ENCRYPTION_ERROR_TYPE errorType)
-   IRtcEngineEventHandlerEx::onUserAccountUpdated(uid_t uid, const char* userAccount) to onUserAccountUpdated(const RtcConnection& connection, uid_t remoteUid, const char* userAccount)

**Delete:**

-   onJoinChannelSuccess()
-   onRejoinChannelSuccess()
-   onWarning()
-   onError()
-   onAudioQuality()
-   onAudioDeviceStateChanged()
-   onAudioMixingFinished()
-   onRemoteAudioMixingEnd()
-   onAudioEffectFinished()
-   onVideoDeviceStateChanged()
-   onMediaDeviceChanged()
-   onBandwidthEstimationUpdated()
-   onLastmileQuality()
-   onApiCallExecuted()
-   onCameraReady()
-   onCameraFocusAreaChanged()
-   onCameraExposureAreaChanged()
-   onVideoStopped()
-   onAudioMixingStateChanged()
-   onRefreshRecordingServiceStatus()
-   onStreamMessage(conn_id_t connId, uid_t uid, int streamId, const char\* data, size_t length)
-   onMediaEngineLoadSuccess()
-   onMediaEngineStartCallSuccess()
-   onAudioDeviceVolumeChanged()
-   onRtmpStreamingStateChanged()
-   onStreamPublished()
-   onStreamUnpublished()
-   onTranscodingUpdated()
-   onStreamInjectedStatus()
-   onAudioRoutingChanged()
-   onChannelMediaRelayStateChanged()
-   onChannelMediaRelayEvent()
-   onLocalPublishFallbackToAudioOnly()
-   onRemoteSubscribeFallbackToAudioOnly()
-   onAudioTransportQuality()
-   onVideoTransportQuality()
-   onRecap()
-   onCustomizedSei()
-   onExtensionEvent()
-   onExtensionStarted()
-   onExtensionStopped()
-   onExtensionErrored()
-   onInternalEngineStatus()

# API (2021-05-10)

## IAgoraRtcEngine.h

**Add:**

-   int pushDirectCdnStreamingCustomVideoFrame(media::base::ExternalVideoFrame\* frame)

**Modified:**

-   int startDirectCdnStreaming(IDirectCdnStreamingEventHandler* eventHandler, const char* publishUrl, const DirectCdnStreamingMediaOptions& options)

---

# API (2021-05-06)

1. Add switches for c++11 features.
2. Change displayId from view_t to uint32_t.

## IAgoraRtcEngine.h

**Modified:**

-   struct ScreenCaptureConfiguration -> uint32_t displayId

---

# API (2020-05-05)

Support R/W recording audio frame observer.

## IAgoraRtcEngine.h

**Modified:**
Move out definition of RAW_AUDIO_FRAME_OP_MODE_TYPE

---

# API (2021-05-06)

delete onRemoteVideoStreamInfoUpdated.

## IAgoraRtcEngine

**Deleted:**

-   onRemoteVideoStreamInfoUpdated()

---

# API (2020-04-30)

## IAgoraRtcEngine.h

**Add:**
only for ios

-   bool isCameraAutoExposureFaceModeSupported()
-   int setCameraAutoExposureFaceModeEnabled(bool enabled)

# API (2020-11-09)

## IAgoraRtcEngine.h

**Add:**

-   onFirstRemoteAudioFrame(uid_t userId, int elapsed)
-   onFirstRemoteAudioDecoded(uid_t userId, int elapsed)

## IAgoraRtcEngineEx.h

**Add:**

-   onFirstRemoteAudioFrame(const RtcConnection& connection, uid_t userId, int elapsed)
-   onFirstRemoteAudioDecoded(const RtcConnection& connection, uid_t userId, int elapsed)

# API (2021-04-25)

## IAgoraRtcEngineEx.h

Adding Code Comments
**Modified:**

-   REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE is not 100% guaranteed. When the remote user leaves, use onUserOffline to make a business decision
-   REMOTE_AUDIO_STATE_REASON_REMOTE_OFFLINE is not 100% guaranteed. When the remote user leaves, use onUserOffline to make a business decision

# API (2021-05-31)

Add face detect for android.

## IAgoraRtcEngine.h

**Add:**

-   enableFaceDetection(boolean enable)
-   bool isFaceDetectSupported

# API (2020-04-22)

Add enableSoundPositionIndication and setRemoteVoicePosition

## IAgoraRtcEngine.h

**Add:**
Add int enableSoundPositionIndication(bool enabled)
Add int setRemoteVoicePosition(uid_t uid, double pan, double gain, conn_id_t connectionId)

# API (2021-04-21)

Support rtmp.

## IAgoraRtcEngine.h

**Add:**

-   setDirectCdnStreamingAudioConfiguration()
-   setDirectCdnStreamingVideoConfiguration()
-   startDirectCdnStreaming()
-   stopDirectCdnStreaming()
-   updateDirectCdnStreamingMediaOptions()

# API (2021-04-20)

Add high level api for audio spectrum.

## IAgoraRtcEngine.h

**Add:**

-   enableAudioSpectrumMonitor(int intervalInMS = 100)
-   disableAudioSpectrumMonitor()
-   registerAudioSpectrumObserver(agora::media::IAudioSpectrumObserver \* observer)
-   unregisterAudioSpectrumObserver(agora::media::IAudioSpectrumObserver \* observer)

# API (2021-04-07)

## IAgoraRtcEngine.h

**add:**

-   registerEncodedAudioFrame(AudioEncodedFrameObserverConfig, IAudioEncodedFrameObserver)

# API (2020-04-19)

Add audio effect interfaces
IAgoraRtcEngine.h

---

**Add:**
Add setVoiceBeautifierPreset, setAudioEffectPreset, setVoiceConversionPreset, setAudioEffectParameters, setVoiceBeautifierParameter and setVoiceConversionParameters in IRtcEngine for audio effect.

# API (2020-04-16)

## IAgoraRtcEngine.h

**Add:**

-   Add bool isCameraZoomSupported()
-   Add bool isCameraTorchSupported()
-   Add bool isCameraFocusSupported()
-   Add bool isCameraAutoFocusFaceModeSupported()
-   Add int setCameraZoomFactor(float factor)
-   Add float getCameraMaxZoomFactor()
-   Add int setCameraFocusPositionInPreview(float positionX, float positionY)
-   Add int setCameraTorchOn(bool isOn)
-   Add int setCameraAutoFocusFaceModeEnabled(bool enabled)
-   Add bool isCameraExposurePositionSupported()
-   Add int setCameraExposurePosition(float positionXinView, float positionYinView)

# API (2020-04-01)

Add setExternalAudioSink and pullAudioFrame

## IAgoraRtcEngine.h

**Add:**
Add bool enableAudioDevice for RtcEngineContext
Add setExternalAudioSink(int sampleRate, int channels)
Add pullAudioFrame(media::IAudioFrameObserver::AudioFrame\* frame)

# API (2020-04-01)

## IAgoraRtcEngine.h

**Modified:**
change annotation for onRejoinChannelSuccess elapsed

-   "@param elapsed The time elapsed (ms) from the local user calling `joinChannel` until this event occurs." to "@paramelapsed Time elapsed (ms) from starting to reconnect until this callback is triggered."

# API (2020-03-26)

## IAgoraRtcEngine.h

**Modified:**
change annotation for enableAudioVolumeIndication

# API (2020-03-25)

Add setExternalAudioSink and pullAudioFrame

## IAgoraRtcEngine.h

**Add:**
Add bool enableAudioDevice for RtcEngineContext
Add setExternalAudioSink(int sampleRate, int channels)
Add pullAudioFrame(media::IAudioFrameObserver::AudioFrame\* frame)

# API (2020-03-25)

Add createDataStream with config

## IAgoraRtcEngine.h

**Add:**
Add createDataStream()

## IAgoraRtcEngineEx.h

**Add:**
Add onStreamMessage with sentTs

# API (2021-04-29)

IAgoraRtcEngine.h
IAgoraRtcEngineEx.h

---

**Modified:**

-   Add callback onFacePositionChanged(int imageWidth, int imageHeight,
    const Rectangle* vecRectangle, const int* vecDistance,
    int numFaces)

# API (2021-03-23)

rtc_engine_i.h
IAgoraRtcEngine.h
IAgoraRtcEngineEx.h

---

# API (2020-03-19)

modify to adapt c++ 11

# API (2020-03-10)

Add remote video A/V sync offset

## IAgoraRtcEngine.h

**Modified:**
Add `avSyncTimeMs` field for struct `RemoteVideoStats`

# API (2020-03-22)

Add api StartEchoTest(int)

## IAgoraRtcEngine.h

**Add:**
Add api StartEchoTest(int)
-`StartEchoTest(int)

# API (2021-02-22)

## IAgoraRtcEngine.h

**Modified:**

-   Add stopAllEffect in LeaveChannelOptions

# API (2021-02-08)

## IAgoraMediaEngine.h

Fix "warning: unused parameter"

# API (2021-02-02)

Modify INetworkObserver.

## IAgoraRtcEngine.h

**Modified:**
Add more callback to INetworkObserver

-   Changes add onDownlinkNetworkInfoUpdated

# API (2021-01-30)

## IAgoraRtcEngine.h

**Modified:**

-   fix a bug in ChannelMediaOptions

# API (2021-01-07)

## IAgoraRtcEngine.h

**Remove:**

-   enum AUDIO_RECORDING_QUALITY_TYPE

**Add:**

-   add startAudioRecording() for IRtcEngine

API (2021-01-03)

# API (2020-12-28)

## IAgoraRtcEngine.h

**Add:**

-   onAudioSubscribeStateChanged()
-   onVideoSubscribeStateChanged()
-   onAudioPublishStateChanged()
-   onVideoPublishStateChanged()

**Remove:**
Remove useless callbacks.

# API (2020-11-26)

## IAgoraRtcEngine.h

**Deleted:**
Remove function in IMetadataObserver.

-   getMetadataSourceType()
    **Modified:**
    Modify onReadyToSendMetadata signature.
-   bool onReadyToSendMetadata(Metadata &metadata) -> bool onReadyToSendMetadata(Metadata &metadata, VIDEO_SOURCE_TYPE source_type)

# API (2020-11-27)

## IAgoraRtcEngine.h

**Modified:**
change agora::base::Optional to agora::Optional

# API (2020-12-24)

## IAgoraRtcEngine.h

**Add:**
Add functions for IRtcEngine:

-   adjustUserPlaybackSignalVolume(uid_t uid, int volume)

# API (2020-12-23)

## IAgoraRtcEngine.h

**Deleted:**
Remove function in IRtcEngine.

-   enableExternalAudioSourceLocalPlayback()

**Add:**
Add functions for IRtcEngine:

-   startPrimaryCustomAudioTrack()
-   stopPrimaryCustomAudioTrack()
-   startSecondaryCustomAudioTrack()
-   stopSecondaryCustomAudioTrack()

## IAgoraMediaEngine.h

**Add:**
Add functions for IMediaEngine:

-   pushPrimaryAudioFrame()
-   pushSecondaryAudioFrame()

# API (2020-12-8)

## IAgoraRtcEngine.h

**Modified:**
add audioDelayMs in ChannelMediaOptions

# API (2020-11-27)

## IAgoraRtcEngine.h

**Modified:**
change agora::base::Optional to agora::Optional

# API (2020-11-23)

## IAgoraRtcEngine.h

**Modified:**
IMediaPlayerSource -> IMediaPlayer

# API (2020-11-22)

Rename REMOTE_VIDEO_STREAM_TYPE.

## IAgoraRtcEngine.h

**Modified:**

-   Changes Rename all REMOTE_VIDEO_STREAM_TYPE/REMOTE_VIDEO_STREAM_HIGH/REMOTE_VIDEO_STREAM_LOW to VIDEO_STREAM_TYPE/VIDEO_STREAM_HIGH/VIDEO_STREAM_LOW.

# API (2020-10-12)

Add function to set camera capture config

## IAgoraRtcEngine.h

**Add:**

-   function setCameraCapturerConfiguration(const CameraCapturerConfiguration& config)

# API (2020-09-27)

Add Mirror Mode in setLocalRenderMode / setRemoteRenderMode

## IAgoraRtcEngine.h

**Modified:**
Add mirror mode parameter in the following function call

-   setLocalRenderMode
-   setRemoteRenderMode
    Deprecate setLocalVideoMirrorMode
    Deprecate old setLocalRenderMode
    Deprecate old setRemoteRenderMode

# API (2020-09-23)

Add Frame Process Mode for Video Frame Observer

# API (2020-11-26)

Support Media Relay service

## IAgoraRtcEngine.h

**Add:**

-   startChannelMediaRelay
-   updateChannelMediaRelay
-   stopChannelMediaRelay

# API (2020-11-09)

Add event callback

## IAgoraRtcEngine.h

**Add:**

-   `void onFirstLocalVideoFramePublished(int elapsed)`

# API (2020-10-20)

## IAgoraRtcEngine.h

**Add:**
Add function in IVideoFrameObserver

-   getVideoFrameProcessMode

# API (2020-09-22)

Support audio frame dump

## IAgoraRtcEngine.h

**Add:**

-   startAudioFrameDump()
-   stopAudioFrameDump()

# API (2020-09-16)

Update enableDualStreamMode API

## IAgoraRtcEngine.h

**Add:**

-   `int enableDualStreamMode(VIDEO_SOURCE_TYPE sourceType, bool enabled)`

**Modified:**

-   `int enableDualStreamMode(bool enabled, const SimulcastStreamConfig& streamConfig)` to `int enableDualStreamMode(VIDEO_SOURCE_TYPE sourceType, bool enabled, const SimulcastStreamConfig& streamConfig)`

# API (2020-09-11)

Delete enum NETWORK_TYPE and add callback onNetworkTypeChanged

## IAgoraRtcEngine.h

**Deleted:**

-   Deleted enum NETWORK_TYPE

# API (2020-08-30)

add remote video frame loss rate

## IAgoraRtcEngine.h

**Modified:**
Add `frameLossRate` field for struct `RemoteVideoStats`

# API (2020-08-14)

Support get video source type

## IAgoraRtcEngine.h

**Add:**

-   IRtcEngine::enableEncryption

API (2020-09-10)

# API (2020-08-11)

Support leave channel with options, options determines whether to do something when leave the channel.

## IAgoraRtcEngine.h

**Add:**
When LeaveChannelOptions::stopAudioMixing = false, after leave the channel is still playing and mixing the music file.

-   struct LeaveChannelOptions.
-   leaveChannel(const LeaveChannelOptions& options)

# API (2020-08-11)

Support adjust loopback recording volume.

## IAgoraRtcEngine.h

**Add:**

-   adjustLoopbackRecordingVolume()
-   getLoopbackRecordingVolume()

API (2020-08-02)

# API (2020-08-03)

Modify data stream.

## IAgoraRtcEngine.h

**Modified:**
Modify data stream apis

-   Changes: add input args connectionId for createDataStream.
-   Changes: add input args connectionId for sendStreamMessage.

# API (2020-07-31)

Make release() pure virtual in IMediaEngine.

## IAgoraMediaEngine.h

**Modified:**
Make release() pure virtual in IMediaEngine.

# API (2020-07-07)

Modify ChannelMediaOptions.

## IAgoraRtcEngine.h

**Modified:**
Rename pcmDataOnly of ChannelMediaOptions.

-   Changes: Rename pcmDataOnly of ChannelMediaOptions to enableAudioRecordingOrPlayout.

# API (2020-07-06)

## IAgoraRtcEngine.h

**Modify:**
Change include dir.

# API (2020-07-01)

## IAgoraRtcEngine.h

**Modify:**
Remove string UID.

# API (2020-06-27)

Make include path correct

# API (2020-07-03)

Refine audio effect API

## IAgoraRtcEngine.h

**Modified:**

-   int playAllEffects(double pitch, double pan, int gain)
    to int playAllEffects(int loopCount, double pitch, double pan, int gain, bool publish = false)

# API (2020-06-22)

Modify ChannelMediaOptions.

## IAgoraRtcEngine.h

**Modified:**
Add pcmDataOnly to ChannelMediaOptions.

-   Changes: Add member pcmDataOnly for ChannelMediaOptions.

# API (2020-06-22)

Add API

## IAgoraRtcEngine.h

**Add:**
Extend enableDualStreamMode

-   `int enableDualStreamMode(bool enabled, const SimulcastStreamConfig& streamConfig)`

# API (2020-06-21)

Refine audio effect interface

## IAgoraRtcEngine.h

**Add:**

-   getEffectsVolume()
-   setEffectsVolume()

**Modified:**

-   preloadEffect(int soundId, const char\* filePath)
-   playEffect(int soundId, int loopCount, double pitch, double pan, int gain, bool publish = false)
-   playEffect(int soundId, const char\* filePath, int loopCount, double pitch, double pan, int gain, bool publish = false)

# API (2020-06-17)

Refine ChannelMediaOptions

## IAgoraRtcEngine.h

**Modified:**
Refine ChannelMediaOptions

-   `bool publishCameraTrack` to `base::Optional<bool> publishCameraTrack`
-   `bool publishAudioTrack` to `base::Optional<bool> publishAudioTrack`
-   `bool publishScreenTrack` to `base::Optional<bool> publishScreenTrack`
-   `bool publishCustomAudioTrack` to `base::Optional<bool> publishCustomAudioTrack`
-   `bool publishCustomVideoTrack` to `base::Optional<bool> publishCustomVideoTrack`
-   `bool publishEncodedVideoTrack` to `base::Optional<bool> publishEncodedVideoTrack`
-   `bool publishMediaPlayerAudioTrack` to `base::Optional<bool> publishMediaPlayerAudioTrack`
-   `bool publishMediaPlayerVideoTrack` to `base::Optional<bool> publishMediaPlayerVideoTrack`
-   `bool autoSubscribeAudio` to `base::Optional<bool> autoSubscribeAudio`
-   `bool autoSubscribeVideo` to `base::Optional<bool> autoSubscribeVideo`
-   `bool publishMediaPlayerId` to `base::Optional<bool> publishMediaPlayerId`
-   `bool clientRoleType` to `base::Optional<CLIENT_ROLE_TYPE> clientRoleType`
-   `bool defaultVideoStreamType` to `base::Optional<REMOTE_VIDEO_STREAM_TYPE> defaultVideoStreamType`
-   `bool channelProfile` to `base::Optional<CHANNEL_PROFILE_TYPE> channelProfile`

# API (2020-06-16)

Modify ChannelMediaOptions.

## IAgoraRtcEngine.h

**Modified:**
Add pcmDataOnly to ChannelMediaOptions.

-   Changes: Add member pcmDataOnly for ChannelMediaOptions.

# API (2020-06-16)

Add interface to audio mixing volume

## IAgoraRtcEngine.h

**Add:**

-   adjustAudioMixingPublishVolume()
-   getAudioMixingPublishVolume()
-   adjustAudioMixingPlayoutVolume()
-   getAudioMixingPlayoutVolume()

# API (2020-06-16)

## IAgoraRtcEngine.h

**Add:**

-   Add enableLoopbackRecording(conn_id_t connectionId, bool enabled), for supporting
    to send audio pcm data got from loopback device by a specific connection.

# API (2020-06-09)

Modify the callback onBandwidthEstimationUpdated

## IAgoraRtcEngine.h

**Modified:**
Modify the declaration of onBandwidthEstimationUpdated

-   Changes "virtual void onBandwidthEstimationUpdated(int targetBitrateBps)" to "virtual void onBandwidthEstimationUpdated(const NetworkInfo& info)"

# API (2020-06-03)

## IAgoraRtcEngine.h

**Add:**

-   createMediaPlayer()
-   destroyMediaPlayer(agora_refptr<IMediaPlayerSource> media_player)

**Modified:**
Audio effect interface

preloadEffect(int soundId, const char* filePath) -> preloadEffect(int& soundId, const char* filePath, int loopCount)
playEffect(int& soundId, const char* filePath, int loopCount, double pitch, double pan,
int gain, bool publish) -> playEffect(int soundId, const char* filePath, int loopCount, double pitch, double pan,
int gain, bool publish = false)
getEffectsVolume() -> getVolumeOfEffect(int soundId)

Add a new function playEffect(int soundId, double pitch, double pan, int gain, bool publish). It should be used with preloadEffect().
Add playAllEffects(double pitch, double pan, int gain).
Add unloadAllEffects().

Remove setEffectsVolume(int volume)

# API (2020-06-01)

## IAgoraRtcEngine.h

**Add:**

-   enableLocalVideoFilter(const char*, const char*, agora_refptr<IVideoFilter>, int)
-   enableRemoteVideoFilter(const char*, const char*, agora_refptr<IVideoFilter>, int)

# API (2020-05-29)

## IAgoraRtcEngine.h

**Modified:**

-   Move definition of type AREA_CODE from IAgoraRtcEngine.h to AgoraBase.h

# API (2020-05-25)

## IAgoraRtcEngine.h

**Add:**

-   Add AREA_CODE type define

# API (2020-05-20)

## IAgoraMediaPlayer.h

**Modified:**

-   Refine the APIs' order of IMediaPlayer.
-   Remove 'const' from the parameter of onPositionChanged() in IMediaPlayerObserver since unnecessary.

# API (2020-05-14)

Deprecated setAudioProfile(AUDIO_PROFILE_TYPE, AUDIO_SCENARIO_TYPE), add setAudioProfile(AUDIO_PROFILE_TYPE)

## IAgoraRtcEngine.h

**Add:**

-   setAudioProfile(AUDIO_PROFILE_TYPE)

**Deprecate:**

-   setAudioProfile(AUDIO_PROFILE_TYPE, AUDIO_SCENARIO_TYPE)

# API (2020-05-13)

## AgoraBase.h

**Modified:**

-   API annotations for EncodedVideoFrameInfo::framesPerSecond

IAgoraRtcEngine.h

# API (2020-05-12)

**Add:**
IAgoraMediaPlayer.h

---

Add relative log and unregister API in player.
setLogFile()
setLogFilter()
unregisterVideoFrameObserver()
unregisterAudioFrameObserver()

# API (2020-05-12)

Move lastmile and connection state enum to AgoraBase.h

## IAgoraRtcEngine.h

**Deleted:**
Delete lastmile and connection state enum

-   Deleted enum LASTMILE_PROBE_RESULT_STATE
-   Deleted struct LastmileProbeOneWayResult
-   Deleted struct LastmileProbeResult
-   Deleted struct LastmileProbeConfig
-   Deleted enum CONNECTION_CHANGED_REASON_TYPE
-   Deleted enum AUDIO_REVERB_PRESET
-   Deleted enum VOICE_CHANGER_PRESET
-   Deleted struct ScreenCaptureParameters
-   Deleted struct VideoCanvas

# API (2020-05-09)

## IAgoraRtcEngine.h

**Add:**

Add AUDIO_SCENARIO_TYPE audioScenario for RtcEngineContext

# API (2020-05-08)

Some structures are consistent with the definition in the old SDK,
resulting in conflicts when the new and old SDK are used at the same time.
Therefore, change the above the structures to agora::media::base namespace

## AgoraBase.h

**Deleted:**

-   AudioPcmFrame
-   RENDER_MODE_TYPE
-   IVideoFrameObserver
-   IAudioFrameObserver

## AgoraMediaBase.h

**Add:**
Move defines to agora::media::base namespace

-   AudioPcmFrame
-   RENDER_MODE_TYPE
-   IVideoFrameObserver
-   IAudioFrameObserver
-   typedef void\* view_t;
-   typedef const char\* user_id_t;

## IAgoraMediaEngine.h

**Modified:**
Needed changes to namespace agora::media::base

## IAgoraMediaPlayer.h

**Modified:**
Needed changes to namespace agora::media::base

## IAgoraRtcEngine.h

**Modified:**
Needed changes to namespace agora::media::base

# API (2020-05-08)

## AgoraBase.h

**Modified:**

-   Move LOG_LEVEL from AgoraBase.h to IAgoraLog.h

# API(2021-11-14)

Remove some dead code

## IAgoraRtcEngine.h

**Deleted:**

-   pushPrimaryAudioFrame()
-   pushSecondaryAudioFrame()

# API (2020-05-06)

IAgoraRtcEngine.h
**Added:**

-   Add interface setLogLevel(LOG_LEVEL)

# API (2020-04-29)

**Modified:**

API annotations in the IAgoraRtcEngine.h file.

# API (2020-04-29)

Refine LocalVideoStats and RemoteVideoStats

## IAgoraRtcEngine.h

**Add:**
Add fields in LocalVideoStats

-   encoderOutputFrameRate
-   rendererOutputFrameRate
-   targetFrameRate

Add fields in RemoteVideoStats

-   decoderOutputFrameRate
-   rendererOutputFrameRate
-   packetLossRate
-   totalFrozenTime
-   frozenRate

**Deleted:**
Remove fields in RemoteVideoStats

-   userId
-   receivedFrameRate

# API (2020-04-30)

Modify comments of CHANNEL_PROFILE_TYPE default setting.

## AgoraBase.h

**Modified:**
Short description

-   Changes the comment of CHANNEL_PROFILE_TYPE default setting from CHANNEL_PROFILE_COMMUNICATION to CHANNEL_PROFILE_LIVE_BROADCASTING.

# API (2020-04-28)

## AgoraBase.h

**Add:**

-   Add enum CHANNEL_PROFILE_COMMUNICATION_1v1 for CHANNEL_PROFILE_TYPE

## IAgoraRtcEngine.h

**Add:**

-   Add field channelProfile for RtcEngineContext

# API (2020-04-27)

AgoraRefPtr.h
**Add:**
Add interface HasOneRef

# API (2020-04-22)

## AgoraBase.h

**Modified:**
Initialize member variable for RtcStats and RemoteAudioStats.

# API (2020-04-20)

## AgoraBase.h

**Modified:**
Change default value of agora::rtc::VideoFormat from 0, 0, 0 to 640(width), 480(height), 15(fps)

# API (2020-04-16)

Fix a typo

## AgoraMediaBase.h

**Modified:**
Change PLAY_ERROR_SRC_BUFFER_UNDERFLOW to PLAYER_ERROR_SRC_BUFFER_UNDERFLOW.

# API (2020-04-17)

Add Log Levels

## AgoraBase.h

**Add:**
Add enum LOG_LEVEL for logging severities.

# API (2020-04-13)

Add internal states

## AgoraMediaBase.h

**Modified:**
Add internal states for Media Player Source.

# API (2020-04-10)

Add field in struct LocalAudioStats

## IAgoraRtcEngine.h

**Modified:**
Move LocalAudioStats to AgoraBase.h
add internalCodec in struct LocalAudioStats

-   struct LocalAudioStats
-   internalCodec

# API (2020-04-10)

Refine code comments

## IAgoraRtcEngine.h

**Modified:**
Refine code comment for onRemoteAudioStats

# API (2020-04-10)

## IAgoraRtcEngine.h

**Add:**

-   IAgoraRtcEngine.h

*   class IMetadataObserver
*   class IRtcEngine
    -   API registerMediaMetadataObserver()

# API (2020-04-10)

## AgoraMediaBase.h

**Modified:**

-   Refine the enum names of MEDIA_PLAYER_STATE and add some internal ones.

## IAgoraMediaPlayer.h

**Modified:**

-   Change one parameter's type of getStreamCount() and getStreamInfo() from int to int64_t to get aligned with the other APIs.

# API (2020-04-10)

## AgoraBase.h

**Modified:**

-   Modified AUDIO_PROFILE_TYPE
-   Modified AUDIO_SCENARIO_TYPE

**Deleted:**

-   Deleted AUDIO_PROFILE_IOT
-   Deleted AUDIO_SCENARIO_IOT

# API (2020-04-10)

## IAgoraRtcEngine.h

**Added:**
Support sending custom event to argus

-   IRtcEngine::sendCustomReportMessage()

# API (2020-03-27)

## IAgoraRtcEngine.h

**Modified:**

-   Modified the comment of onLastmileQuality
-   Modified the comment of startLastmileProbeTest

**Deleted:**

-   Deleted enableLastmileTest()
-   Deleted disableLastmileTest()

# API (2020-03-18)

## AgoraBase.h

**Modified:**

-   Replace FEATURE_ENABLE_UT with FEATURE_ENABLE_UT_SUPPORT

# API (2020-03-16)

add field in struct MediaStreamInfo

## AgoraMediaBase.h

**Add:**
add audioBitsPerSample in struct MediaStreamInfo

-   struct MediaStreamInfo
-   audioBitsPerSample

# API (2020-03-12)

## AgoraMediaBase.h

**Deleted:**

-   Some comments in struct PacketOptions

# API (2020-03-09)

## IAgoraRtcEngine.h

**Modified:**

-   updateChannelMediaOptions provider default connectionId param is agora::rtc::DEFAULT_CONNECTION_ID

# API (2020-03-09)

## IAgoraRtcEngine.h

**Modified:**

-   Modified the comment of member availableBandwidth for struct LastmileProbeOneWayResult
-   Modified the comment of member expectedUplinkBitrate for struct LastmileProbeConfig

# API (2020-03-05)

## AgoraMediaBase.h

**Deleted:**

-   payload_type and ssrc fields in struct PacketOptions

API (2020-03-03)

## AgoraBase.h

**Modified:**

-   Change field name of sampleCount in EncodedAudioFrameInfo to samplesPerChannel

API (2020-02-26)

# API (2020-02-27)

Changes for warning

## AgoraBase.h

**Modified:**

-   Add warning WARN_CHANNEL_CONNECTION_UNRECOVERABLE;

# API (2020-02-21)

## AgoraBase.h

**Add:**

-   struct RemoteAudioStats
-   LOCAL_AUDIO_STREAM_ERROR::LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY
-   LOCAL_AUDIO_STREAM_ERROR::LOCAL_AUDIO_STREAM_ERROR_RECORD_FAILURE
-   RtcStats::txAudioBytes
-   RtcStats::txVideoBytes
-   RtcStats::rxAudioBytes
-   RtcStats::rxVideoBytes

**Modified:**

-   Changes LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE = 3 to LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE = 5
-   Changes REMOTE_AUDIO_STREAM_STATE to REMOTE_AUDIO_STATE
-   Changes REMOTE_AUDIO_STREAM_REASON to REMOTE_AUDIO_STATE_REASON

## IAgoraRtcEngine.h

**Add:**

-   onLocalAudioStats()
-   onRemoteAudioStats()

**Modified:**

-   Changes onFirstLocalAudioFrame to onFirstLocalAudioFramePublished
-   Changes onLocalAudioStateChanged(LOCAL_AUDIO_STREAM_STATE) to onLocalAudioStateChanged(LOCAL_AUDIO_STREAM_STATE, LOCAL_AUDIO_STREAM_ERROR)
-   Changes onRemoteAudioStateChanged(uid_t, REMOTE_AUDIO_STREAM_STATE) to onRemoteAudioStateChanged(uid_t, REMOTE_AUDIO_STATE, REMOTE_AUDIO_STATE_REASON, int)

**Deleted:**

-   Deleted onRemoteAudioStats()
-   Deleted onUserMuteAudio()
-   Deleted onMicrophoneEnabled

# API (2020-02-20)

Support lastmile probe test

## Add:

-   IAgoraRtcEngine.h
    -   class IRtcEngine
        -   add API startLastmileProbeTest
    -   add API stopLastmileProbeTest

# API (2020-02-19)

## Modified:

Modified API annotations in the following files:

-   AgoraBase.h
-   AgoraMediaBase.h
-   IAgoraRtcEngine.h

# API (2020-02-18)

## Modified:

-   AgoraBase.h
    -   struct `RtcStats`, rename field `cid` into `connectionId`

# API (2020-02-15)

API changes for unifying the definition of connection state and adding the API for getting connection state.

## IAgoraRtcEngine.h

**Add:**
Add the API for getting the connection state.

-   CONNECTION_STATE_TYPE IRtcEngine::getConnectionState(conn_id_t connectionId)

**Deleted:**
Delete the definition of enum CONNECTION_STATE_TYPE.

-   Deleted enum CONNECTION_STATE_TYPE

## AgoraBase.h

**Add:**
Add the definition for connection state.

-   enum CONNECTION_STATE_TYPE

# API (2020-02-15)

## Modified:

-   IAgoraRtcEngine.h
    -   Modified the comment of member publishMediaPlayerAudioTrack for struct ChannelMediaOptions

# API (2020-02-12)

## Modified:

-   AgoraBase.h
    -   remove isScreenCapture and syncWithAudio in track info

# API (2020-02-12)

## Modified:

-   AgoraMediaBase.h
    -   Add PLAY_ERROR_SRC_BUFFER_UNDERFLOW

# API (2020-02-12)

## Add:

-   IAgoraRtcEngine.h
    -   AUDIO_REVERB_PRESET definition
    -   VOICE_CHANGER_PRESET definition
    -   class IRtcEngine
        -   API setLocalVoiceReverbPreset()
    -   API setLocalVoiceChanger()

# API (2020-02-11)

## Add:

-   IAgoraParameter.h
    -   Add KEY_RTC_VIDEO_RESEND and KEY_RTC_AUDIO_RESEND

# API (2020-02-13)

## Modified:

-   AgoraRefPtr.h
    -   Refine Agora shared pointer, re-struct code

# API (2020-02-17)

## Add:

-   AgoraBase.h
    -   Add HEAAC2

# API (2020-02-10)

## Add:

-   IAgoraRtcEngine.h

*   class IRtcEngine
    -   API setLogFileSize()

# API (2020-02-06)

## Add:

-   IAgoraRtcEngine.h
    -   Add member publishMediaPlayerAudioTrack for struct ChannelMediaOptions

API (2020-02-05)

## Add:

-   AgoraRefPtr.h
    -   Add member function reset() for class agora_refptr

# API (2020-01-19)

## Modified:

-   IAgoraRtcEngine.h AgoraBase.h
    -   Move enum CHANNEL_PROFILE_TYPE to AgoraBase.h

# API (2020-01-15)

## Add:

-   IAgoraRtcEngine.h
    -   class IRtcEngine
        -   API startScreenCapture()

# API (2020-01-13)

## Modified:

-   AgoraMediaBase.h
    -   Rename PLAYER_STATE_OPEN_COMPLETE of MEDIA_PLAYER_STATE to PLAYER_STATE_OPEN_COMPLETED

# API (2020-01-09)

## Add:

-   IAgoraMediaPlayer.h
    -   class IMediaPlayer
        -   API initialize()

# API (2020-01-08)

## Add:

-   IAgoraMediaPlayer.h

    -   Add the following class
        -   class IMediaPlayer
        -   class IMediaPlayerObserver

-   AgoraBase.h
    -   Add the following class
        -   class IVideoFrameObserver
        -   class IAudioFrameObserver

# API (2019-12-25)

## Modified:

-   IAgoraRtcEngine.h
    -   change API enableInEarMonitoring()

# API (2019-12-15)

## Add:

-   IAgoraRtcEngine.h
    -   add API enableInEarMonitoring()

## Modified:

-   AgoraMediaBase.h
    -   Delete unused class AudioFrame
    -   Move ExternalVideoFrame from IAgoraMediaEngine.h
    -   Move VIDEO_PIXEL_FORMAT definition out from class ExternalVideoFrame.
    -   Move VideoFrame out from class IVideoFrameObserver.
-   IAgoraMediaEngine.h
    -   Move ExternalVideoFrame from this file to AgoraMediaBase.h
    -   Delete the following class
        -   class IVideoFrame
        -   class IExternalVideoRenderCallback
        -   class IExternalVideoRender
        -   class IExternalVideoRenderFactory
    -   Delete method registerVideoRenderFactory() in class IMediaEngine
-   IAgoraRtcEngine.h
    -   all platform supports setInEarMonitoringVolume()

## Deleted:

-   Delete class MEDIA_ENGINE_EVENT_CODE_TYPE in IAgoraRtcEngine.h
-   Delete API setPlaybackDeviceVolume in interface IRtcEngine
-   Delete API setVideoProfile in interface IRtcEngine
-   Delete class RtcEngineParameters in IAgoraRtcEngine.h

# API (2019-11-25)

## Add:

## Modified:

-   AgoraMediaBase.h
    -   Delete unused class AudioFrame
    -   Move ExternalVideoFrame from IAgoraMediaEngine.h
    -   Move VIDEO_PIXEL_FORMAT definition out from class ExternalVideoFrame.
    -   Move VideoFrame out from class IVideoFrameObserver.
-   IAgoraMediaEngine
    -   Move ExternalVideoFrame from this file to AgoraMediaBase.h
    -   Delete the following class
        -   class IVideoFrame
        -   class IExternalVideoRenderCallback
        -   class IExternalVideoRender
        -   class IExternalVideoRenderFactory
    -   Delete method registerVideoRenderFactory() in class IMediaEngine

## Deleted:

-   IAgoraLiveEngine.h
-   IAgoraLivePublisher.h
-   IAgoraLiveSubscriber.h
-   IAgoraSignalingEngine.h

# API (2021-03-22)

## IAgoraRtcEngine.h

**Add:**

-   # enableInEarMonitoring(bool enabled, bool includeAudioFilter) to enableInEarMonitoring(bool enabled, int includeAudioFilters)
    IAgoraRtcEngine.h

---

**Modify:**
moidfy enableAudioVolumeIndication support vad

# API(2021-09-30)

## IAgoraRtcEngine.h

\*Modified:\*\*

-   add API setLocalPublishFallbackOption(STREAM_FALLBACK_OPTIONS option)
-   add API setRemoteSubscribeFallbackOption(STREAM_FALLBACK_OPTIONS option)
    API (2021-11-18)
    ==================================================
    IAgoraRtcEngine.h

---

**Add:**
virtual int setCloudProxy(CLOUD_PROXY_TYPE proxyType) = 0;
API (2021-09-29)
==================================================
IAgoraRtcEngine.h

---

**Add:**
virtual int setLocalAccessPoint(const LocalAccessPointConfiguration& config) = 0;

# API (2021-09-15)

## **Add:**

-   IAgoraRtcEngineEx.h
    -add API enableFishCorrection(bool enabled, const FishCorrectionParams& params)

# API (2022-05-23)

## **Add:**

-   IAgoraRtcEngine.h
    **Modified:** ScreenCaptureSourceInfo pointer to NSNumber to Number
