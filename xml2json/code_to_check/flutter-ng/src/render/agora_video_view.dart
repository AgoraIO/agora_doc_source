import 'dart:io';

import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_ng/src/impl/agora_rtc_renderer.dart';
import 'package:agora_rtc_ng/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../impl/agora_video_view_impl.dart';
import 'media_player_controller.dart';
import 'package:meta/meta.dart';

/// Class for rendering local and remote video.
///
/// * Use [VideoViewController] to control the rendering of [RtcEngine].
/// * Use [MediaPlayerController] to control the rendering of media player.
///
class AgoraVideoView extends StatefulWidget {
  const AgoraVideoView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  /// Control the rendering of [AgoraVideoView]
  /// 
  /// see also:
  /// * [VideoViewController]
  /// * [MediaPlayerController]
  @internal
  final VideoViewControllerBase controller;

  @override
  State<AgoraVideoView> createState() => AgoraVideoViewState();
}
