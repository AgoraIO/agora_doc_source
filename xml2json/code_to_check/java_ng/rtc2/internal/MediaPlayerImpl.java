package io.agora.rtc2.internal;

import android.view.View;
import io.agora.mediaplayer.Constants;
import io.agora.mediaplayer.IMediaPlayer;
import io.agora.mediaplayer.IMediaPlayerAudioFrameObserver;
import io.agora.mediaplayer.IMediaPlayerCustomDataProvider;
import io.agora.mediaplayer.IMediaPlayerObserver;
import io.agora.mediaplayer.IMediaPlayerVideoFrameObserver;
import io.agora.mediaplayer.data.MediaStreamInfo;

public class MediaPlayerImpl implements IMediaPlayer {
  private static final String TAG = MediaPlayerImpl.class.getSimpleName();

  private final RtcEngineImpl mRtcEngineImpl;
  private final int mNativeMediaPlayerSourceId;

  MediaPlayerImpl(RtcEngineImpl rtcEngineImpl, int sourceId) {
    mRtcEngineImpl = rtcEngineImpl;
    mNativeMediaPlayerSourceId = sourceId;
  }

  @Override
  public int getMediaPlayerId() {
    return mNativeMediaPlayerSourceId;
  }

  @Override
  public int open(String url, long startPos) {
    return mRtcEngineImpl.mediaPlayerOpen(mNativeMediaPlayerSourceId, url, startPos);
  }

  @Override
  public int openWithCustomSource(long startPos, IMediaPlayerCustomDataProvider provider) {
    return mRtcEngineImpl.mediaPlayerOpenWithCustomSource(
        mNativeMediaPlayerSourceId, startPos, provider);
  }

  @Override
  public int play() {
    return mRtcEngineImpl.mediaPlayerPlay(mNativeMediaPlayerSourceId);
  }

  @Override
  public int pause() {
    return mRtcEngineImpl.mediaPlayerPause(mNativeMediaPlayerSourceId);
  }

  @Override
  public int stop() {
    return mRtcEngineImpl.mediaPlayerStop(mNativeMediaPlayerSourceId);
  }

  @Override
  public int resume() {
    return mRtcEngineImpl.mediaPlayerResume(mNativeMediaPlayerSourceId);
  }

  @Override
  public int seek(long newPos) {
    return mRtcEngineImpl.mediaPlayerSeek(mNativeMediaPlayerSourceId, newPos);
  }

  @Override
  public int setAudioPitch(int pitch) {
    return mRtcEngineImpl.mediaPlayerSetAudioPitch(mNativeMediaPlayerSourceId, pitch);
  }

  @Override
  public int mute(boolean mute) {
    return mRtcEngineImpl.mediaPlayerMute(mNativeMediaPlayerSourceId, mute);
  }

  @Override
  public boolean isMuted() {
    return mRtcEngineImpl.mediaPlayerIsMuted(mNativeMediaPlayerSourceId);
  }

  @Override
  public long getPlayPosition() {
    return mRtcEngineImpl.mediaPlayerGetPlayPosition(mNativeMediaPlayerSourceId);
  }

  @Override
  public long getDuration() {
    return mRtcEngineImpl.mediaPlayerGetDuration(mNativeMediaPlayerSourceId);
  }

  @Override
  public Constants.MediaPlayerState getState() {
    return Constants.MediaPlayerState.getStateByValue(
        mRtcEngineImpl.mediaPlayerGetState(mNativeMediaPlayerSourceId));
  }

  @Override
  public int getStreamCount() {
    return mRtcEngineImpl.mediaPlayerGetStreamCount(mNativeMediaPlayerSourceId);
  }

  @Override
  public int setView(View videoView) {
    return mRtcEngineImpl.mediaPlayerSetView(mNativeMediaPlayerSourceId, videoView);
  }

  @Override
  public int setRenderMode(int mode) {
    return mRtcEngineImpl.mediaPlayerSetRenderMode(mNativeMediaPlayerSourceId, mode);
  }

  @Override
  public MediaStreamInfo getStreamInfo(int index) {
    return mRtcEngineImpl.mediaPlayerGetStreamInfo(mNativeMediaPlayerSourceId, index);
  }

  @Override
  public int setLoopCount(int loopCount) {
    return mRtcEngineImpl.mediaPlayerSetLoopCount(mNativeMediaPlayerSourceId, loopCount);
  }

  @Override
  public int setPlaybackSpeed(int speed) {
    return mRtcEngineImpl.mediaPlayerChangePlaybackSpeed(mNativeMediaPlayerSourceId, speed);
  }

  @Override
  public int selectAudioTrack(int index) {
    return mRtcEngineImpl.mediaPlayerSelectAudioTrack(mNativeMediaPlayerSourceId, index);
  }

  @Override
  public int setPlayerOption(String key, int value) {
    return mRtcEngineImpl.mediaPlayerSetPlayerOption(mNativeMediaPlayerSourceId, key, value);
  }

  @Override
  public int takeScreenshot(String filename) {
    return mRtcEngineImpl.mediaPlayerTakeScreenshot(mNativeMediaPlayerSourceId, filename);
  }

  @Override
  public int selectInternalSubtitle(int index) {
    return mRtcEngineImpl.mediaPlayerSelectInternalSubtitle(mNativeMediaPlayerSourceId, index);
  }

  @Override
  public int setExternalSubtitle(String url) {
    return mRtcEngineImpl.mediaPlayerSetExternalSubtitle(mNativeMediaPlayerSourceId, url);
  }

  @Override
  public int adjustPlayoutVolume(int volume) {
    return mRtcEngineImpl.mediaPlayerAdjustPlayoutVolume(mNativeMediaPlayerSourceId, volume);
  }

  @Override
  public int getPlayoutVolume() {
    return mRtcEngineImpl.mediaPlayerGetPlayoutVolume(mNativeMediaPlayerSourceId);
  }

  @Override
  public int adjustPublishSignalVolume(int volume) {
    return mRtcEngineImpl.mediaPlayerAdjustPublishSignalVolume(mNativeMediaPlayerSourceId, volume);
  }

  @Override
  public int getPublishSignalVolume() {
    return mRtcEngineImpl.mediaPlayerGetPublishSignalVolume(mNativeMediaPlayerSourceId);
  }

  @Override
  public String getPlaySrc() {
    return mRtcEngineImpl.mediaPlayerGetPlaySrc(mNativeMediaPlayerSourceId);
  }

  @Override
  public int switchSrc(String src, boolean syncPts) {
    return mRtcEngineImpl.mediaPlayerSwitchSrc(mNativeMediaPlayerSourceId, src, syncPts);
  }

  @Override
  public int preloadSrc(String src, long startPos) {
    return mRtcEngineImpl.mediaPlayerPreloadSrc(mNativeMediaPlayerSourceId, src, startPos);
  }

  @Override
  public int unloadSrc(String src) {
    return mRtcEngineImpl.mediaPlayerUnloadSrc(mNativeMediaPlayerSourceId, src);
  }

  @Override
  public int playPreloadedSrc(String src) {
    return mRtcEngineImpl.mediaPlayerPlayPreloadedSrc(mNativeMediaPlayerSourceId, src);
  }

  @Override
  public int destroy() {
    return mRtcEngineImpl.mediaPlayerDestroy(mNativeMediaPlayerSourceId);
  }

  @Override
  public int registerPlayerObserver(IMediaPlayerObserver playerObserver) {
    return mRtcEngineImpl.mediaPlayerRegisterPlayerObserver(
        mNativeMediaPlayerSourceId, playerObserver);
  }

  @Override
  public int unRegisterPlayerObserver(IMediaPlayerObserver playerObserver) {
    return mRtcEngineImpl.mediaPlayerUnRegisterPlayerObserver(
        mNativeMediaPlayerSourceId, playerObserver);
  }

  @Override
  public int registerAudioFrameObserver(
      IMediaPlayerAudioFrameObserver audioFrameObserver, int mode) {
    return mRtcEngineImpl.mediaPlayerRegisterAudioFrameObserver(
        mNativeMediaPlayerSourceId, audioFrameObserver, mode);
  }

  @Override
  public int setAudioDualMonoMode(int mode) {
    return mRtcEngineImpl.mediaPlayerSetAudioDualMonoMode(mNativeMediaPlayerSourceId, mode);
  }

  @Override
  public int registerVideoFrameObserver(IMediaPlayerVideoFrameObserver videoFrameObserver) {
    return mRtcEngineImpl.mediaPlayerRegisterVideoFrameObserver(
        mNativeMediaPlayerSourceId, videoFrameObserver);
  }

  @Override
  public int openWithAgoraCDNSrc(String src, long startPos) {
    return mRtcEngineImpl.mediaPlayerOpenWithAgoraCDNSrc(mNativeMediaPlayerSourceId, src, startPos);
  }

  @Override
  public int getAgoraCDNLineCount() {
    return mRtcEngineImpl.mediaPlayerGetAgoraCDNLineCount(mNativeMediaPlayerSourceId);
  }

  @Override
  public int switchAgoraCDNLineByIndex(int index) {
    return mRtcEngineImpl.mediaPlayerSwitchAgoraCDNLineByIndex(mNativeMediaPlayerSourceId, index);
  }

  @Override
  public int getCurrentAgoraCDNIndex() {
    return mRtcEngineImpl.mediaPlayerGetCurrentAgoraCDNIndex(mNativeMediaPlayerSourceId);
  }

  @Override
  public int enableAutoSwitchAgoraCDN(boolean enable) {
    return mRtcEngineImpl.mediaPlayerEnableAutoSwitchAgoraCDN(mNativeMediaPlayerSourceId, enable);
  }

  @Override
  public int renewAgoraCDNSrcToken(String token, long ts) {
    return mRtcEngineImpl.mediaPlayerRenewAgoraCDNSrcToken(mNativeMediaPlayerSourceId, token, ts);
  }

  @Override
  public int switchAgoraCDNSrc(String src, boolean syncPts) {
    return mRtcEngineImpl.mediaPlayerSwitchAgoraCDNSrc(mNativeMediaPlayerSourceId, src, syncPts);
  }
}
