Note: Please update this file for every Agora RTE Agolet API change you do. Simply fill in
your updates in the Working section below.

# Agora RTE Agolet APIs (Working)

# API (yyyy-mm-dd)

Purpose of this change

## API file name #1

**Add:**
Short description

-   Foo()
-   Bar()

**Modified:**
Short description

-   Change Foo() to Foo1()
-   Change Bar() to Bar1()

**Deleted:**
Short description

-   Delete Foo()

## API file name #2

# API (2022-03-04)

## AgoraRteBase.h

**Add:**

-   superResolutionType
    API (2021-11-01)
    ==================================================
    IAgoraRteMediaPlayer.h

---

**Modify:**

-   reanme changePlaybackSpeed to setPlaybackSpeed

# API (2021-10-19)

## IAgoraRteDeviceManager.h

**Modify:**

-   Correct the comment of functions

# API (2021-08-02)

## AgoraRteBase.h

**Add:**

-   kExtensionPropertyEnabledKey
-   kExtensionPropertyEnabledValue
-   kExtensionPropertyDisabledValue

## IAgoraRteMediaTrack.h

**Modified:**

-   EnableExtension(const std::string& provider_name, const std::string& extension_name, bool enable) to EnableExtension(const std::string& provider_name, const std::string& extension_name)

## IAgoraRteScene.h

**Modified:**

-   SetVideoExtensionProperty to SetExtensionProperty
-   GetVideoExtensionProperty to GetExtensionProperty

**Deleted:**

-   EnableVideoExtension

# API (2021-08-05)

## IAgoraRteScene.h

**Add:**

-   OnLocalStreamEvent()
-   OnRemoteStreamEvent()

## AgoraRteBase.h

**Add:**

-   enum class LocalStreamEventType
-   enum class RemoteStreamEventType

# API (2021-08-10)

## AgoraRteBase.h

**Deleted:**

-   LocalStreamStats
-   RemoteStreamStats

## IAgoraRteScene.h

**Add:**

-   OnLocalStreamAudioStats
-   OnLocalStreamVideoStats
-   OnRemoteStreamAudioStats
-   OnRemoteStreamVideoStats

**Deleted:**

-   OnLocalStreamStats
-   OnRemoteStreamStats

# API (2021-08-24)

## IAgoraRteMediaTrack.h

**Deleted:**

-   IAgoraRteVideoTrack::EnableVideoFilter()

# API (2021-08-31)

## AgoraRteSdk.h

**Add:**

-   enum class LocalStreamEventType
-   enum class RemoteStreamEventType

**Modified:**

-   AgoraRteSDK::IsCompatibleModeEnabled() to AgoraRteSDK::IsCompatibleModeEnabled() const;

## IAgoraRteMediaObserver.h

**Modified:**

-   IAgoraRteVideoFrameObserver::OnFrame(const std::string, const media::base::VideoFrame&) to AgoraRteVideoFrameObserver::OnFrame(const std::string&, const media::base::VideoFrame&)

## IAgoraRteMediaTrack.h

**Modified:**

-   IAgoraRteMixedVideoTrack::SetLayout(const LayoutConfigs) to IAgoraRteMixedVideoTrack::SetLayout(const LayoutConfigs&)

## IAgoraRtePlayList.ha

**Modified:**

-   RteFileInfo::IsValid() to RteFileInfo::IsValid() const
-   RteFileInfo::CloneTo() to RteFileInfo::CloneTo() const
