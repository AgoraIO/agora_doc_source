Note: Please update this file for every Agora API change you do. Simply fill in
your updates in the Working section below.

# Agora Low Level APIs (Working)

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

# API (2021-11-01)

add new api in IAgoraMediaPlayer.h

## IAgoraMediaPlayer.h

**Add:**

-   virtual int unloadSrc(const char\* src) = 0;

---

**Modify:**

-   reanme changePlaybackSpeed to setPlaybackSpeed

# API (2021-09-08)

## IAgoraRhythmPlayer.h

Add IRhythmPlayer interface class

# API (2021-10-09)

add new api in IAgoraMediaPlayer.h

## IAgoraMediaPlayer.h

**Add:**

-   int openWithAgoraCDNSrc(const char\* src, int64_t startPos)
-   int getAgoraCDNLineCount()
-   int switchAgoraCDNLineByIndex(int index)
-   int getCurrentAgoraCDNIndex()
-   int enableAutoSwitchAgoraCDN(bool enable)
-   int renewAgoraCDNSrcToken(const char\* token, int64_t ts)
-   int switchAgoraCDNSrc(const char\* src, bool syncPts = false)
-   int switchSrc(const char\* src, bool syncPts)
-   int preloadSrc(const char\* src, int64_t startPos)
-   int playPreloadedSrc(const char\* src)

# API (2021-07-15)

## IAgoraMediaPlayer.h

**Add:**

-   setAudioDualMonoMode

# API (2021-07-02)

Add methods for Agora media player

## IAgoraMediaPlayer.h

**Add:**

-   setAudioPitch(int pitch)

# API (2021-07-15)

# API (2021-06-18)

Add methods for Agora media player

## IAgoraMediaPlayer.h

**Add:**

-   registerAudioFrameObserver(media::base::IAudioFrameObserver\* observer, RAW_AUDIO_FRAME_OP_MODE_TYPE mode)
-   add method muteAudio()
-   add method isAudioMuted()
-   add method muteVideo()
-   add method isVideoMuted()

# API (2021-06-15)

Add new api file IAudioDeviceManager.h.

# API (2021-05-31)

Add new api file IAgoraMediaComponentFactory.h.

# API (2021-06-18)

add api in IAgoraMediaPlayer.h

## IAgoraMediaPlayer.h

**Add:**

-   getPlaySrc

# API (2020-04-01)

add api in IAgoraMediaPlayer.h

## IAgoraMediaPlayer.h

**Add:**

-   setPlayerOption
-   getPlayerSdkVersion

# API (2020-03-19)

modify to adapt c++ 11

# Update struct name (2021-01-21)

## IAgoraMediaPlayer.h

Change name of MediaStreamInfo to PlayerStreamInfo.

# API (2020-11-13)

Add IAgoraMediaPlayer.h

# API (2021-0603-13)

# Add IAudioDeviceManager.h
