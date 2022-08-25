import { EncodedVideoFrameInfo } from './AgoraBase';

/**
 * The type of the audio route.
 */
export enum AudioRoute {
  /**
   * -1: Default audio route.
   */
  RouteDefault = -1,
  /**
   * Audio output routing is a headset with microphone.
   */
  RouteHeadset = 0,
  /**
   * 1: The audio route is an earpiece.
   */
  RouteEarpiece = 1,
  /**
   * 2: The audio route is a headset without a microphone.
   */
  RouteHeadsetnomic = 2,
  /**
   * 3: The audio route is the speaker that comes with the device.
   */
  RouteSpeakerphone = 3,
  /**
   * 4: The audio route is an external speaker. (iOS only)
   */
  RouteLoudspeaker = 4,
  /**
   * @ignore
   */
  RouteHeadsetbluetooth = 5,
  /**
   * @ignore
   */
  RouteUsb = 6,
  /**
   * @ignore
   */
  RouteHdmi = 7,
  /**
   * @ignore
   */
  RouteDisplayport = 8,
  /**
   * @ignore
   */
  RouteAirplay = 9,
}

/**
 * @ignore
 */
export enum BytesPerSample {
  /**
   * @ignore
   */
  TwoBytesPerSample = 2,
}

/**
 * @ignore
 */
export class AudioParameters {
  /**
   * @ignore
   */
  sample_rate?: number;
  /**
   * @ignore
   */
  channels?: number;
  /**
   * @ignore
   */
  frames_per_buffer?: number;
}

/**
 * The use mode of the audio data.
 */
export enum RawAudioFrameOpModeType {
  /**
   * 0: Read-only mode:
   */
  RawAudioFrameOpModeReadOnly = 0,
  /**
   * 2: Read and write mode:
   */
  RawAudioFrameOpModeReadWrite = 2,
}

/**
 * Media source type.
 */
export enum MediaSourceType {
  /**
   * 0: Audio playback device.
   */
  AudioPlayoutSource = 0,
  /**
   * 1: Audio capturing device.
   */
  AudioRecordingSource = 1,
  /**
   * @ignore
   */
  PrimaryCameraSource = 2,
  /**
   * @ignore
   */
  SecondaryCameraSource = 3,
  /**
   * @ignore
   */
  PrimaryScreenSource = 4,
  /**
   * @ignore
   */
  SecondaryScreenSource = 5,
  /**
   * @ignore
   */
  CustomVideoSource = 6,
  /**
   * @ignore
   */
  MediaPlayerSource = 7,
  /**
   * @ignore
   */
  RtcImagePngSource = 8,
  /**
   * @ignore
   */
  RtcImageJpegSource = 9,
  /**
   * @ignore
   */
  RtcImageGifSource = 10,
  /**
   * @ignore
   */
  RemoteVideoSource = 11,
  /**
   * @ignore
   */
  TranscodedVideoSource = 12,
  /**
   * @ignore
   */
  UnknownMediaSource = 100,
}

/**
 * @ignore
 */
export enum ContentInspectResult {
  /**
   * @ignore
   */
  ContentInspectNeutral = 1,
  /**
   * @ignore
   */
  ContentInspectSexy = 2,
  /**
   * @ignore
   */
  ContentInspectPorn = 3,
}

/**
 * @ignore
 */
export enum ContentInspectType {
  /**
   * @ignore
   */
  ContentInspectInvalid = 0,
  /**
   * @ignore
   */
  ContentInspectModeration = 1,
  /**
   * @ignore
   */
  ContentInspectSupervision = 2,
}

/**
 * @ignore
 */
export class ContentInspectModule {
  /**
   * @ignore
   */
  type?: ContentInspectType;
  /**
   * @ignore
   */
  interval?: number;
}

/**
 * @ignore
 */
export class ContentInspectConfig {
  /**
   * @ignore
   */
  extraInfo?: string;
  /**
   * @ignore
   */
  modules?: ContentInspectModule[];
  /**
   * @ignore
   */
  moduleCount?: number;
}

/**
 * @ignore
 */
export class PacketOptions {
  /**
   * @ignore
   */
  timestamp?: number;
  /**
   * @ignore
   */
  audioLevelIndication?: number;
}

/**
 * @ignore
 */
export class AudioEncodedFrameInfo {
  /**
   * @ignore
   */
  sendTs?: number;
  /**
   * @ignore
   */
  codec?: number;
}

/**
 * @ignore
 */
export class AudioPcmFrame {
  /**
   * @ignore
   */
  capture_timestamp?: number;
  /**
   * @ignore
   */
  samples_per_channel_?: number;
  /**
   * @ignore
   */
  sample_rate_hz_?: number;
  /**
   * @ignore
   */
  num_channels_?: number;
  /**
   * @ignore
   */
  bytes_per_sample?: BytesPerSample;
  /**
   * @ignore
   */
  data_?: number[];
}

/**
 * The channel mode.
 */
export enum AudioDualMonoMode {
  /**
   * 0: Original mode.
   */
  AudioDualMonoStereo = 0,
  /**
   * 1: Left channel mode. This mode replaces the audio of the right channel with the audio of the left channel, which means the user can only hear the audio of the left channel.
   */
  AudioDualMonoL = 1,
  /**
   * 2: Right channel mode. This mode replaces the audio of the left channel with the audio of the right channel, which means the user can only hear the audio of the right channel.
   */
  AudioDualMonoR = 2,
  /**
   * 3: Mixed channel mode. This mode mixes the audio of the left channel and the right channel, which means the user can hear the audio of the left channel and the right channel at the same time.
   */
  AudioDualMonoMix = 3,
}

/**
 * @ignore
 */
export enum VideoPixelFormat {
  /**
   * @ignore
   */
  VideoPixelDefault = 0,
  /**
   * @ignore
   */
  VideoPixelI420 = 1,
  /**
   * @ignore
   */
  VideoPixelBgra = 2,
  /**
   * @ignore
   */
  VideoPixelNv21 = 3,
  /**
   * @ignore
   */
  VideoPixelRgba = 4,
  /**
   * @ignore
   */
  VideoPixelNv12 = 8,
  /**
   * @ignore
   */
  VideoTexture2d = 10,
  /**
   * @ignore
   */
  VideoTextureOes = 11,
  /**
   * @ignore
   */
  VideoCvpixelNv12 = 12,
  /**
   * @ignore
   */
  VideoCvpixelI420 = 13,
  /**
   * @ignore
   */
  VideoCvpixelBgra = 14,
  /**
   * @ignore
   */
  VideoPixelI422 = 16,
}

/**
 * Video display modes.
 */
export enum RenderModeType {
  /**
   * 1: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). The window is filled. One dimension of the video might have clipped contents.
   */
  RenderModeHidden = 1,
  /**
   * 2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Priority is to ensuring that all video content is displayed. Areas that are not filled due to disparity in the aspect ratio are filled with black.
   */
  RenderModeFit = 2,
  /**
   * @ignore
   */
  RenderModeAdaptive = 3,
}

/**
 * @ignore
 */
export enum EglContextType {
  /**
   * @ignore
   */
  EglContext10 = 0,
  /**
   * @ignore
   */
  EglContext14 = 1,
}

/**
 * The video buffer type.
 */
export enum VideoBufferType {
  /**
   * 1: The video buffer in the format of raw data.
   */
  VideoBufferRawData = 1,
  /**
   * @ignore
   */
  VideoBufferArray = 2,
  /**
   * @ignore
   */
  VideoBufferTexture = 3,
}

/**
 * @ignore
 */
export class ExternalVideoFrame {
  /**
   * @ignore
   */
  type?: VideoBufferType;
  /**
   * @ignore
   */
  format?: VideoPixelFormat;
  /**
   * @ignore
   */
  buffer?: Uint8Array;
  /**
   * @ignore
   */
  stride?: number;
  /**
   * @ignore
   */
  height?: number;
  /**
   * @ignore
   */
  cropLeft?: number;
  /**
   * @ignore
   */
  cropTop?: number;
  /**
   * @ignore
   */
  cropRight?: number;
  /**
   * @ignore
   */
  cropBottom?: number;
  /**
   * @ignore
   */
  rotation?: number;
  /**
   * @ignore
   */
  timestamp?: number;
  /**
   * @ignore
   */
  eglType?: EglContextType;
  /**
   * @ignore
   */
  textureId?: number;
  /**
   * @ignore
   */
  matrix?: number[];
  /**
   * @ignore
   */
  metadata_buffer?: Uint8Array;
  /**
   * @ignore
   */
  metadata_size?: number;
}

/**
 * @ignore
 */
export class VideoFrame {
  /**
   * @ignore
   */
  type?: VideoPixelFormat;
  /**
   * @ignore
   */
  width?: number;
  /**
   * @ignore
   */
  height?: number;
  /**
   * @ignore
   */
  yStride?: number;
  /**
   * @ignore
   */
  uStride?: number;
  /**
   * @ignore
   */
  vStride?: number;
  /**
   * @ignore
   */
  yBuffer?: Uint8Array;
  /**
   * @ignore
   */
  uBuffer?: Uint8Array;
  /**
   * @ignore
   */
  vBuffer?: Uint8Array;
  /**
   * @ignore
   */
  rotation?: number;
  /**
   * @ignore
   */
  renderTimeMs?: number;
  /**
   * @ignore
   */
  avsync_type?: number;
  /**
   * @ignore
   */
  metadata_buffer?: Uint8Array;
  /**
   * @ignore
   */
  metadata_size?: number;
  /**
   * @ignore
   */
  textureId?: number;
  /**
   * @ignore
   */
  matrix?: number[];
  /**
   * @ignore
   */
  alphaBuffer?: Uint8Array;
}

/**
 * @ignore
 */
export enum MediaPlayerSourceType {
  /**
   * @ignore
   */
  MediaPlayerSourceDefault = 0,
  /**
   * @ignore
   */
  MediaPlayerSourceFullFeatured = 1,
  /**
   * @ignore
   */
  MediaPlayerSourceSimple = 2,
}

/**
 * @ignore
 */
export enum VideoModulePosition {
  /**
   * @ignore
   */
  PositionPostCapturer = 1 << 0,
  /**
   * @ignore
   */
  PositionPreRenderer = 1 << 1,
  /**
   * @ignore
   */
  PositionPreEncoder = 1 << 2,
  /**
   * @ignore
   */
  PositionPostFilters = 1 << 3,
}

/**
 * Audio frame type.
 */
export enum AudioFrameType {
  /**
   * 0: PCM 16
   */
  FrameTypePcm16 = 0,
}

/**
 * @ignore
 */
export class AudioFrame {
  /**
   * @ignore
   */
  type?: AudioFrameType;
  /**
   * @ignore
   */
  samplesPerChannel?: number;
  /**
   * @ignore
   */
  bytesPerSample?: BytesPerSample;
  /**
   * @ignore
   */
  channels?: number;
  /**
   * @ignore
   */
  samplesPerSec?: number;
  /**
   * @ignore
   */
  buffer?: Uint8Array;
  /**
   * @ignore
   */
  renderTimeMs?: number;
  /**
   * @ignore
   */
  avsync_type?: number;
}

/**
 * @ignore
 */
export enum AudioFramePosition {
  /**
   * @ignore
   */
  AudioFramePositionNone = 0x0000,
  /**
   * @ignore
   */
  AudioFramePositionPlayback = 0x0001,
  /**
   * @ignore
   */
  AudioFramePositionRecord = 0x0002,
  /**
   * @ignore
   */
  AudioFramePositionMixed = 0x0004,
  /**
   * @ignore
   */
  AudioFramePositionBeforeMixing = 0x0008,
}

/**
 * @ignore
 */
export class AudioParams {
  /**
   * @ignore
   */
  sample_rate?: number;
  /**
   * @ignore
   */
  channels?: number;
  /**
   * @ignore
   */
  mode?: RawAudioFrameOpModeType;
  /**
   * @ignore
   */
  samples_per_call?: number;
}

/**
 * @ignore
 */
export abstract class IAudioFrameObserverBase {
  /**
   * @ignore
   */
  onRecordAudioFrame?(channelId: string, audioFrame: AudioFrame): boolean;

  /**
   * @ignore
   */
  onPlaybackAudioFrame?(channelId: string, audioFrame: AudioFrame): boolean;

  /**
   * @ignore
   */
  onMixedAudioFrame?(channelId: string, audioFrame: AudioFrame): boolean;
}

/**
 * @ignore
 */
export abstract class IAudioFrameObserver extends IAudioFrameObserverBase {
  /**
   * @ignore
   */
  onPlaybackAudioFrameBeforeMixing?(
    channelId: string,
    uid: number,
    audioFrame: AudioFrame
  ): boolean;
}

/**
 * @ignore
 */
export class AudioSpectrumData {
  /**
   * @ignore
   */
  audioSpectrumData?: number[];
  /**
   * @ignore
   */
  dataLength?: number;
}

/**
 * Audio spectrum information of the remote user.
 */
export class UserAudioSpectrumInfo {
  /**
   *
   */
  uid?: number;
  /**
   * @ignore
   */
  spectrumData?: AudioSpectrumData;
}

/**
 * @ignore
 */
export abstract class IAudioSpectrumObserver {
  /**
   * @ignore
   */
  onLocalAudioSpectrum?(data: AudioSpectrumData): boolean;

  /**
   * @ignore
   */
  onRemoteAudioSpectrum?(
    spectrums: UserAudioSpectrumInfo[],
    spectrumNumber: number
  ): boolean;
}

/**
 * @ignore
 */
export abstract class IVideoEncodedFrameObserver {
  /**
   * @ignore
   */
  onEncodedVideoFrameReceived?(
    uid: number,
    imageBuffer: Uint8Array,
    length: number,
    videoEncodedFrameInfo: EncodedVideoFrameInfo
  ): boolean;
}

/**
 * @ignore
 */
export enum VideoFrameProcessMode {
  /**
   * @ignore
   */
  ProcessModeReadOnly = 0,
  /**
   * @ignore
   */
  ProcessModeReadWrite = 1,
}

/**
 * @ignore
 */
export abstract class IVideoFrameObserver {
  /**
   * @ignore
   */
  onCaptureVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onPreEncodeVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onSecondaryCameraCaptureVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onSecondaryPreEncodeCameraVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onScreenCaptureVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onPreEncodeScreenVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onMediaPlayerVideoFrame?(
    videoFrame: VideoFrame,
    mediaPlayerId: number
  ): boolean;

  /**
   * @ignore
   */
  onSecondaryScreenCaptureVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onSecondaryPreEncodeScreenVideoFrame?(videoFrame: VideoFrame): boolean;

  /**
   * @ignore
   */
  onRenderVideoFrame?(
    channelId: string,
    remoteUid: number,
    videoFrame: VideoFrame
  ): boolean;

  /**
   * @ignore
   */
  onTranscodedVideoFrame?(videoFrame: VideoFrame): boolean;
}

/**
 * @ignore
 */
export enum ExternalVideoSourceType {
  /**
   * @ignore
   */
  VideoFrame = 0,
  /**
   * @ignore
   */
  EncodedVideoFrame = 1,
}

/**
 * @ignore
 */
export enum MediaRecorderContainerFormat {
  /**
   * @ignore
   */
  FormatMp4 = 1,
}

/**
 * @ignore
 */
export enum MediaRecorderStreamType {
  /**
   * @ignore
   */
  StreamTypeAudio = 0x01,
  /**
   * @ignore
   */
  StreamTypeVideo = 0x02,
  /**
   * @ignore
   */
  StreamTypeBoth = 0x01 | 0x02,
}

/**
 * @ignore
 */
export enum RecorderState {
  /**
   * @ignore
   */
  RecorderStateError = -1,
  /**
   * @ignore
   */
  RecorderStateStart = 2,
  /**
   * @ignore
   */
  RecorderStateStop = 3,
}

/**
 * @ignore
 */
export enum RecorderErrorCode {
  /**
   * @ignore
   */
  RecorderErrorNone = 0,
  /**
   * @ignore
   */
  RecorderErrorWriteFailed = 1,
  /**
   * @ignore
   */
  RecorderErrorNoStream = 2,
  /**
   * @ignore
   */
  RecorderErrorOverMaxDuration = 3,
  /**
   * @ignore
   */
  RecorderErrorConfigChanged = 4,
}

/**
 * @ignore
 */
export class MediaRecorderConfiguration {
  /**
   * @ignore
   */
  storagePath?: string;
  /**
   * @ignore
   */
  containerFormat?: MediaRecorderContainerFormat;
  /**
   * @ignore
   */
  streamType?: MediaRecorderStreamType;
  /**
   * @ignore
   */
  maxDurationMs?: number;
  /**
   * @ignore
   */
  recorderInfoUpdateInterval?: number;
}

/**
 * @ignore
 */
export class RecorderInfo {
  /**
   * @ignore
   */
  fileName?: string;
  /**
   * @ignore
   */
  durationMs?: number;
  /**
   * @ignore
   */
  fileSize?: number;
}

/**
 * @ignore
 */
export abstract class IMediaRecorderObserver {
  /**
   * @ignore
   */
  onRecorderStateChanged?(state: RecorderState, error: RecorderErrorCode): void;

  /**
   * @ignore
   */
  onRecorderInfoUpdated?(info: RecorderInfo): void;
}
