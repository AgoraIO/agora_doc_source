import { RtcConnection } from './IAgoraRtcEngineEx';
import {
  IMediaRecorderObserver,
  MediaRecorderConfiguration,
} from './AgoraMediaBase';

/**
 * @ignore
 */
export abstract class IMediaRecorder {
  /**
   * @ignore
   */
  abstract setMediaRecorderObserver(
    connection: RtcConnection,
    callback: IMediaRecorderObserver
  ): number;

  /**
   * @ignore
   */
  abstract startRecording(
    connection: RtcConnection,
    config: MediaRecorderConfiguration
  ): number;

  /**
   * @ignore
   */
  abstract stopRecording(connection: RtcConnection): number;

  /**
   * @ignore
   */
  abstract release(): void;
}
