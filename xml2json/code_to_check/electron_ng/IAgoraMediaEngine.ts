import {
  IAudioFrameObserver,
  IVideoFrameObserver,
  IVideoEncodedFrameObserver,
  MediaSourceType,
  AudioFrame,
  ExternalVideoSourceType,
  ExternalVideoFrame,
} from './AgoraMediaBase';
import { SenderOptions, EncodedVideoFrameInfo } from './AgoraBase';

/**
 * @ignore
 */
export enum AudioMixingDualMonoMode {
  /**
   * @ignore
   */
  AudioMixingDualMonoAuto = 0,
  /**
   * @ignore
   */
  AudioMixingDualMonoL = 1,
  /**
   * @ignore
   */
  AudioMixingDualMonoR = 2,
  /**
   * @ignore
   */
  AudioMixingDualMonoMix = 3,
}

/**
 * @ignore
 */
export abstract class IMediaEngine {
  /**
   * @ignore
   */
  abstract registerAudioFrameObserver(observer: IAudioFrameObserver): number;

  /**
   * @ignore
   */
  abstract registerVideoFrameObserver(observer: IVideoFrameObserver): number;

  /**
   * @ignore
   */
  abstract registerVideoEncodedFrameObserver(
    observer: IVideoEncodedFrameObserver
  ): number;

  /**
   * @ignore
   */
  abstract pushAudioFrame(
    type: MediaSourceType,
    frame: AudioFrame,
    wrap?: boolean,
    sourceId?: number
  ): number;

  /**
   * @ignore
   */
  abstract pushCaptureAudioFrame(frame: AudioFrame): number;

  /**
   * @ignore
   */
  abstract pushReverseAudioFrame(frame: AudioFrame): number;

  /**
   * @ignore
   */
  abstract pushDirectAudioFrame(frame: AudioFrame): number;

  /**
   * @ignore
   */
  abstract pullAudioFrame(): AudioFrame;

  /**
   * @ignore
   */
  abstract setExternalVideoSource(
    enabled: boolean,
    useTexture: boolean,
    sourceType?: ExternalVideoSourceType,
    encodedVideoOption?: SenderOptions
  ): number;

  /**
   * @ignore
   */
  abstract setExternalAudioSource(
    enabled: boolean,
    sampleRate: number,
    channels: number,
    sourceNumber?: number,
    localPlayback?: boolean,
    publish?: boolean
  ): number;

  /**
   * @ignore
   */
  abstract setExternalAudioSink(
    enabled: boolean,
    sampleRate: number,
    channels: number
  ): number;

  /**
   * @ignore
   */
  abstract enableCustomAudioLocalPlayback(
    sourceId: number,
    enabled: boolean
  ): number;

  /**
   * @ignore
   */
  abstract setDirectExternalAudioSource(
    enable: boolean,
    localPlayback?: boolean
  ): number;

  /**
   * @ignore
   */
  abstract pushVideoFrame(
    frame: ExternalVideoFrame,
    videoTrackId?: number
  ): number;

  /**
   * @ignore
   */
  abstract pushEncodedVideoImage(
    imageBuffer: Uint8Array,
    length: number,
    videoEncodedFrameInfo: EncodedVideoFrameInfo,
    videoTrackId?: number
  ): number;

  /**
   * @ignore
   */
  abstract release(): void;

  /**
   * @ignore
   */
  abstract unregisterAudioFrameObserver(observer: IAudioFrameObserver): number;

  /**
   * @ignore
   */
  abstract unregisterVideoFrameObserver(observer: IVideoFrameObserver): number;

  /**
   * @ignore
   */
  abstract unregisterVideoEncodedFrameObserver(
    observer: IVideoEncodedFrameObserver
  ): number;
}
