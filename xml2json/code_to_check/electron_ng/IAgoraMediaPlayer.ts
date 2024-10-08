import {
  MediaSource,
  PlayerStreamInfo,
  MediaPlayerState,
} from './AgoraMediaPlayerTypes';
import {
  RenderModeType,
  IAudioSpectrumObserver,
  AudioDualMonoMode,
  AudioPcmFrame,
  VideoFrame,
} from './AgoraMediaBase';
import { IMediaPlayerSourceObserver } from './IAgoraMediaPlayerSource';
import { SpatialAudioParams } from './AgoraBase';

/**
 * This class provides media player functions and supports multiple instances.
 */
export abstract class IMediaPlayer {
  /**
   * Gets the ID of the media player.
   *
   * @returns
   * ≥ 0: Success. The ID of the media player.
   * < 0: Failure.
   */
  abstract getMediaPlayerId(): number;

  /**
   * Opens the media resource.
   *
   * @param url The path of the media file. Both local path and online path are supported.
   *
   * @param startPos The starting position (ms) for playback. Default value is 0.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract open(url: string, startPos: number): number;

  /**
   * @ignore
   */
  abstract openWithMediaSource(source: MediaSource): number;

  /**
   * Plays the media file.
   * After calling open or seek, you can call this method to play the media file.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract play(): number;

  /**
   * Pauses the playback.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract pause(): number;

  /**
   * Stops playing the media track.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract stop(): number;

  /**
   * Resumes playing the media file.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract resume(): number;

  /**
   * Seeks to a new playback position.
   * After successfully calling this method, you will receive the onPlayerEvent callback, reporting the result of the seek operation to the new playback position.
   * To play the media file from a specific position, do the following:
   * Call this method to seek to the position you want to begin playback.
   * Call the play method to play the media file.
   *
   * @param newPos The new playback position (ms).
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract seek(newPos: number): number;

  /**
   * Sets the pitch of the current media resource.
   * Call this method after calling open .
   *
   * @param pitch Sets the pitch of the local music file by the chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract setAudioPitch(pitch: number): number;

  /**
   * Gets the duration of the media resource.
   *
   * @returns
   * The total duration (ms) of the media file.
   */
  abstract getDuration(): number;

  /**
   * Gets current local playback progress.
   *
   * @returns
   * Returns the current playback progress (ms) if the call succeeds.
   * < 0: Failure. See MediaPlayerError .
   */
  abstract getPlayPosition(): number;

  /**
   * Gets the number of the media streams in the media resource.
   * Call this method after calling open .
   *
   * @returns
   * The number of the media streams in the media resource if the method call succeeds.
   * < 0: Failure. See MediaPlayerError .
   */
  abstract getStreamCount(): number;

  /**
   * Gets the detailed information of the media stream.
   * Call this method after calling getStreamCount .
   *
   * @param index The index of the media stream.
   *
   * @returns
   * If the call succeeds, returns the detailed information of the media stream. See PlayerStreamInfo .
   * If the call fails, returns NULL.
   */
  abstract getStreamInfo(index: number): PlayerStreamInfo;

  /**
   * Sets the loop playback.
   * If you want to loop, call this method and set the number of the loops.
   * When the loop finishes, the SDK triggers onPlayerSourceStateChanged and reports the playback state as PlayerStatePlaybackAllLoopsCompleted.
   *
   * @param loopCount The number of times the audio effect loops:
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract setLoopCount(loopCount: number): number;

  /**
   * @ignore
   */
  abstract setPlaybackSpeed(speed: number): number;

  /**
   * @ignore
   */
  abstract selectAudioTrack(index: number): number;

  /**
   * @ignore
   */
  abstract takeScreenshot(filename: string): number;

  /**
   * @ignore
   */
  abstract selectInternalSubtitle(index: number): number;

  /**
   * @ignore
   */
  abstract setExternalSubtitle(url: string): number;

  /**
   * Gets current playback state.
   *
   * @returns
   * The current playback state. See MediaPlayerState .
   */
  abstract getState(): MediaPlayerState;

  /**
   * Sets whether to mute the media file.
   *
   * @param mute Whether to mute the media file:
   *  true: Mute the media file.
   *  false: (Default) Unmute the media file.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract mute(muted: boolean): number;

  /**
   * Reports whether the media resource is muted.
   *
   * @returns
   * true: Reports whether the media resource is muted.
   * false: Reports whether the media resource is muted.
   */
  abstract getMute(): boolean;

  /**
   * Adjusts the local playback volume.
   *
   * @param volume The local playback volume, which ranges from 0 to 100:
   *  0: Mute.
   *  100: (Default) The original volume.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract adjustPlayoutVolume(volume: number): number;

  /**
   * Gets the local playback volume.
   *
   * @returns
   * The local playback volume, which ranges from 0 to 100.
   * 0: Mute.
   * 100: (Default) The original volume.
   */
  abstract getPlayoutVolume(): number;

  /**
   * Adjusts the volume of the media file for publishing.
   * After connected to the Agora server, you can call this method to adjust the volume of the media file heard by the remote user.
   *
   * @param volume The volume, which ranges from 0 to 400:
   *  0: Mute.
   *  100: (Default) The original volume.
   *  400: Four times the original volume (amplifying the audio signals by four times).
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract adjustPublishSignalVolume(volume: number): number;

  /**
   * Gets the volume of the media file for publishing.
   *
   * @returns
   * ≥ 0: The remote playback volume.
   * < 0: Failure.
   */
  abstract getPublishSignalVolume(): number;

  /**
   * Sets the view.
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract setView(view: any): number;

  /**
   * Sets the render mode of the media player.
   *
   * @param renderMode Sets the render mode of the view. See RenderModeType .
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract setRenderMode(renderMode: RenderModeType): number;

  /**
   * Registers a media player observer.
   *
   * @param observer The player observer, listening for events during the playback. See IMediaPlayerSourceObserver .
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract registerPlayerSourceObserver(
    observer: IMediaPlayerSourceObserver
  ): number;

  /**
   * Releases a media player observer.
   *
   * @param observer The player observer, listening for events during the playback. See IMediaPlayerSourceObserver .
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract unregisterPlayerSourceObserver(
    observer: IMediaPlayerSourceObserver
  ): number;

  /**
   * @ignore
   */
  abstract registerMediaPlayerAudioSpectrumObserver(
    observer: IAudioSpectrumObserver,
    intervalInMS: number
  ): number;

  /**
   * @ignore
   */
  abstract unregisterMediaPlayerAudioSpectrumObserver(
    observer: IAudioSpectrumObserver
  ): number;

  /**
   * Sets the channel mode of the current audio file.
   * In a stereo music file, the left and right channels can store different audio data. According to your needs, you can set the channel mode to original mode, left channel mode, right channel mode, or mixed channel mode. For example, in the KTV scenario, the left channel of the music file stores the musical accompaniment, and the right channel stores the singing voice. If you only need to listen to the accompaniment, call this method to set the channel mode of the music file to left channel mode; if you need to listen to the accompaniment and the singing voice at the same time, call this method to set the channel mode to mixed channel mode. Call this method after calling open .
   * This method only applies to stereo audio files.
   *
   * @param mode The channel mode. See AudioDualMonoMode .
   *
   * @returns
   * 0: Success.
   * < 0: Failure.
   */
  abstract setAudioDualMonoMode(mode: AudioDualMonoMode): number;

  /**
   * @ignore
   */
  abstract getPlayerSdkVersion(): string;

  /**
   * @ignore
   */
  abstract getPlaySrc(): string;

  /**
   * @ignore
   */
  abstract openWithAgoraCDNSrc(src: string, startPos: number): number;

  /**
   * @ignore
   */
  abstract getAgoraCDNLineCount(): number;

  /**
   * @ignore
   */
  abstract switchAgoraCDNLineByIndex(index: number): number;

  /**
   * @ignore
   */
  abstract getCurrentAgoraCDNIndex(): number;

  /**
   * @ignore
   */
  abstract enableAutoSwitchAgoraCDN(enable: boolean): number;

  /**
   * @ignore
   */
  abstract renewAgoraCDNSrcToken(token: string, ts: number): number;

  /**
   * @ignore
   */
  abstract switchAgoraCDNSrc(src: string, syncPts?: boolean): number;

  /**
   * @ignore
   */
  abstract switchSrc(src: string, syncPts?: boolean): number;

  /**
   * @ignore
   */
  abstract preloadSrc(src: string, startPos: number): number;

  /**
   * @ignore
   */
  abstract playPreloadedSrc(src: string): number;

  /**
   * @ignore
   */
  abstract unloadSrc(src: string): number;

  /**
   * @ignore
   */
  abstract setSpatialAudioParams(params: SpatialAudioParams): number;

  /**
   * @ignore
   */
  abstract setSoundPositionParams(pan: number, gain: number): number;

  /**
   * @ignore
   */
  abstract registerAudioFrameObserver(
    observer: IMediaPlayerAudioFrameObserver
  ): number;

  /**
   * @ignore
   */
  abstract unregisterAudioFrameObserver(
    observer: IMediaPlayerAudioFrameObserver
  ): number;

  /**
   * @ignore
   */
  abstract registerVideoFrameObserver(
    observer: IMediaPlayerVideoFrameObserver
  ): number;

  /**
   * @ignore
   */
  abstract unregisterVideoFrameObserver(
    observer: IMediaPlayerVideoFrameObserver
  ): number;

  /**
   * @ignore
   */
  abstract setPlayerOptionInInt(key: string, value: number): number;

  /**
   * @ignore
   */
  abstract setPlayerOptionInString(key: string, value: string): number;
}

/**
 * @ignore
 */
export abstract class IMediaPlayerCacheManager {
  /**
   * @ignore
   */
  abstract removeAllCaches(): number;

  /**
   * @ignore
   */
  abstract removeOldCache(): number;

  /**
   * @ignore
   */
  abstract removeCacheByUri(uri: string): number;

  /**
   * @ignore
   */
  abstract setCacheDir(path: string): number;

  /**
   * @ignore
   */
  abstract setMaxCacheFileCount(count: number): number;

  /**
   * @ignore
   */
  abstract setMaxCacheFileSize(cacheSize: number): number;

  /**
   * @ignore
   */
  abstract enableAutoRemoveCache(enable: boolean): number;

  /**
   * @ignore
   */
  abstract getCacheDir(length: number): string;

  /**
   * @ignore
   */
  abstract getMaxCacheFileCount(): number;

  /**
   * @ignore
   */
  abstract getMaxCacheFileSize(): number;

  /**
   * @ignore
   */
  abstract getCacheFileCount(): number;
}

/**
 * @ignore
 */
export abstract class IMediaPlayerAudioFrameObserver {
  /**
   * @ignore
   */
  onFrame?(frame: AudioPcmFrame): void;
}

/**
 * @ignore
 */
export abstract class IMediaPlayerVideoFrameObserver {
  /**
   * @ignore
   */
  onFrame?(frame: VideoFrame): void;
}
