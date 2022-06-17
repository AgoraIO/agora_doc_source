import 'dart:io';

import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_ng/src/impl/agora_rtc_renderer.dart';
import 'package:agora_rtc_ng/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../impl/agora_video_view_impl.dart';
import 'media_player_controller.dart';
import 'package:meta/meta.dart';

class AgoraVideoView extends StatefulWidget {
  // const AgoraVideoView({Key? key}) : super(key: key);

  const AgoraVideoView({
    Key? key,
    required VideoViewController controller,
  })  : videoViewController = controller,
        super(key: key);

  const AgoraVideoView.mediaPlayer({
    Key? key,
    required MediaPlayerController controller,
  })  : videoViewController = controller,
        super(key: key);

  @internal
  final VideoViewControllerBase videoViewController;

  @override
  State<AgoraVideoView> createState() => AgoraVideoViewState();
}
