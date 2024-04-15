import { RtcConnection } from './IAgoraRtcEngineEx';

/**
 * @ignore
 */
export class RemoteVoicePositionInfo {
  /**
   * @ignore
   */
  position?: number[];
  /**
   * @ignore
   */
  forward?: number[];
}

/**
 * @ignore
 */
export abstract class IBaseSpatialAudioEngine {
  /**
   * @ignore
   */
  abstract release(): void;

  /**
   * @ignore
   */
  abstract setMaxAudioRecvCount(maxCount: number): number;

  /**
   * @ignore
   */
  abstract setAudioRecvRange(range: number): number;

  /**
   * @ignore
   */
  abstract setDistanceUnit(unit: number): number;

  /**
   * @ignore
   */
  abstract updateSelfPosition(
    position: number[],
    axisForward: number[],
    axisRight: number[],
    axisUp: number[]
  ): number;

  /**
   * @ignore
   */
  abstract updateSelfPositionEx(
    position: number[],
    axisForward: number[],
    axisRight: number[],
    axisUp: number[],
    connection: RtcConnection
  ): number;

  /**
   * @ignore
   */
  abstract updatePlayerPositionInfo(
    playerId: number,
    positionInfo: RemoteVoicePositionInfo
  ): number;

  /**
   * @ignore
   */
  abstract setParameters(params: string): number;

  /**
   * @ignore
   */
  abstract muteLocalAudioStream(mute: boolean): number;

  /**
   * @ignore
   */
  abstract muteAllRemoteAudioStreams(mute: boolean): number;
}

/**
 * @ignore
 */
export abstract class ILocalSpatialAudioEngine extends IBaseSpatialAudioEngine {
  /**
   * @ignore
   */
  abstract initialize(): number;

  /**
   * @ignore
   */
  abstract updateRemotePosition(
    uid: number,
    posInfo: RemoteVoicePositionInfo
  ): number;

  /**
   * @ignore
   */
  abstract updateRemotePositionEx(
    uid: number,
    posInfo: RemoteVoicePositionInfo,
    connection: RtcConnection
  ): number;

  /**
   * @ignore
   */
  abstract removeRemotePosition(uid: number): number;

  /**
   * @ignore
   */
  abstract removeRemotePositionEx(
    uid: number,
    connection: RtcConnection
  ): number;

  /**
   * @ignore
   */
  abstract clearRemotePositions(): number;

  /**
   * @ignore
   */
  abstract clearRemotePositionsEx(connection: RtcConnection): number;
}
