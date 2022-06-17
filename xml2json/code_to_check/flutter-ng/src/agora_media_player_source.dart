import 'package:agora_rtc_ng/src/binding_forward_export.dart';

class MediaPlayerSourceObserver {
  const MediaPlayerSourceObserver({
    this.onPlayerSourceStateChanged,
    this.onPositionChanged,
    this.onPlayerEvent,
    this.onMetaData,
    this.onPlayBufferUpdated,
    this.onPreloadEvent,
    this.onCompleted,
    this.onAgoraCDNTokenWillExpire,
    this.onPlayerSrcInfoChanged,
    this.onPlayerInfoUpdated,
    this.onAudioVolumeIndication,
  });

  final void Function(MediaPlayerState state, MediaPlayerError ec)?
      onPlayerSourceStateChanged;

  final void Function(int position)? onPositionChanged;

  final void Function(
          MediaPlayerEvent eventCode, int elapsedTime, String message)?
      onPlayerEvent;

  final void Function(int data, int length)? onMetaData;

  final void Function(int playCachedBuffer)? onPlayBufferUpdated;

  final void Function(String src, PlayerPreloadEvent event)? onPreloadEvent;

  final void Function()? onCompleted;

  final void Function()? onAgoraCDNTokenWillExpire;

  final void Function(SrcInfo from, SrcInfo to)? onPlayerSrcInfoChanged;

  final void Function(PlayerUpdatedInfo info)? onPlayerInfoUpdated;

  final void Function(int volume)? onAudioVolumeIndication;
}
