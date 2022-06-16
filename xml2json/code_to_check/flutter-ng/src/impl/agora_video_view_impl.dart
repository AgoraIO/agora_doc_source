import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_ng/src/render/agora_video_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'agora_rtc_renderer.dart';

class AgoraVideoViewState extends State<AgoraVideoView> with RtcRenderMixin {
  // int _mediaPlayerViewId = kMediaPlayerNotInit;
  // int _nativeViewIntPtr = 0;

  @override
  void initState() {
    super.initState();

    // _mediaPlayerViewId = widget.mediaPlayerController.getMediaPlayerId();
  }

  @override
  void didUpdateWidget(covariant AgoraVideoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _mediaPlayerViewId = widget.mediaPlayerController.getMediaPlayerId();
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      return AgoraRtcRenderTexture(
        key: widget.key,
        controller: widget.videoViewController,
      );
    }

    if (widget.videoViewController.useFlutterTexture) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return const Text(
            'Flutter texture render is not supported on Android.');
      }

      return AgoraRtcRenderTexture(
        key: widget.key,
        controller: widget.videoViewController,
      );
    }

    return AgoraRtcRenderPlatformView(
      key: widget.key,
      controller: widget.videoViewController,
    );
  }

  // Future<void> _setView() async {
  //   _nativeViewIntPtr =
  //       (await getMethodChannel()!.invokeMethod<int>('getNativeViewPtr'))!;
  //   widget.mediaPlayerController.setView(_nativeViewIntPtr);
  // }
}

class AgoraRtcRenderPlatformView extends StatefulWidget {
  const AgoraRtcRenderPlatformView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoViewControllerBase controller;

  @override
  State<AgoraRtcRenderPlatformView> createState() =>
      _AgoraRtcRenderPlatformViewState();
}

class _AgoraRtcRenderPlatformViewState extends State<AgoraRtcRenderPlatformView>
    with RtcRenderMixin {
  static const String _viewTypeAgoraTextureView = 'AgoraTextureView';
  static const String _viewTypeAgoraSurfaceView = 'AgoraSurfaceView';

  int _nativeViewIntPtr = 0;
  late String _viewType;

  @override
  void initState() {
    super.initState();

    if (defaultTargetPlatform == TargetPlatform.android) {
      if (widget.controller.useAndroidSurfaceView) {
        _viewType = _viewTypeAgoraSurfaceView;
      } else {
        _viewType = _viewTypeAgoraTextureView;
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _viewType = _viewTypeAgoraSurfaceView;
    } else {
      throw ArgumentError('PlatformView render is not supported on desktop');
    }

    widget.controller.initialize();
  }

  @override
  void didUpdateWidget(covariant AgoraRtcRenderPlatformView oldWidget) {
    super.didUpdateWidget(oldWidget);

    debugPrint(
        'didUpdateWidget oldWidget.controller.isSame(widget.controller): ${oldWidget.controller.isSame(widget.controller)}');
    if (!oldWidget.controller.isSame(widget.controller)) {
      oldWidget.controller.dispose();
      _setupVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildPlatformView(
      viewType: _viewType,
      onPlatformViewCreated: (int id) {
        _setupVideo();
      },
    );
  }

  Future<void> _setupVideo() async {
    _nativeViewIntPtr =
        (await getMethodChannel()!.invokeMethod<int>('getNativeViewPtr'))!;
    widget.controller.setupView(_nativeViewIntPtr);
    // widget.controller._rtcEngine?.startPreview();
  }
}

class AgoraRtcRenderTexture extends StatefulWidget {
  const AgoraRtcRenderTexture({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoViewControllerBase controller;

  @override
  State<AgoraRtcRenderTexture> createState() => _AgoraRtcRenderTextureState();
}

class _AgoraRtcRenderTextureState extends State<AgoraRtcRenderTexture>
    with RtcRenderMixin {
  // int textureId = kTextureNotInit;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await widget.controller.initialize();
    // textureId = widget.controller.getTextureId();
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant AgoraRtcRenderTexture oldWidget) {
    super.didUpdateWidget(oldWidget);

    debugPrint(
        'didUpdateWidget oldWidget.controller.isSame(widget.controller): ${oldWidget.controller.isSame(widget.controller)}');
    if (!oldWidget.controller.isSame(widget.controller)) {
      oldWidget.controller.dispose();
      // textureId = kTextureNotInit;
      _initialize();
    } else {
      widget.controller.setTextureId(oldWidget.controller.getTextureId());
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('_AgoraRtcRenderTextureState dispose');
    widget.controller.disposeRender();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'build widget.controller.getTextureId(): ${widget.controller.getTextureId()}');
    if (widget.controller.getTextureId() != kTextureNotInit) {
      return buildTexure(widget.controller.getTextureId());
    }

    return Container();
  }
}
