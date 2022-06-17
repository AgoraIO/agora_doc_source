import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

const int kTextureNotInit = -1;

extension VideoViewControllerBaseExt on VideoViewControllerBase {
  bool isSame(VideoViewControllerBase other) {
    // debugPrint(
    //     'canvas: ${canvas.toJson()}, other.canvas: ${other.canvas.toJson()}, connection: ${connection?.toJson()}, other.connection: ${other.connection?.toJson()}, _useFlutterTexture: $_useFlutterTexture, other._useFlutterTexture: ${other._useFlutterTexture}');
    bool isSame = canvas.view == other.canvas.view &&
        canvas.renderMode == other.canvas.renderMode &&
        canvas.mirrorMode == other.canvas.mirrorMode &&
        canvas.uid == other.canvas.uid &&
        canvas.isScreenView == other.canvas.isScreenView &&
        canvas.priv == other.canvas.priv &&
        canvas.privSize == other.canvas.privSize &&
        canvas.sourceType == other.canvas.sourceType &&
        canvas.cropArea == other.canvas.cropArea &&
        canvas.setupMode == other.canvas.setupMode;
    isSame = isSame &&
        connection?.channelId == other.connection?.channelId &&
        connection?.localUid == other.connection?.localUid;
    isSame = isSame && _useFlutterTexture == other._useFlutterTexture;
    isSame = isSame && useAndroidSurfaceView == other.useAndroidSurfaceView;
    return isSame;
  }

  bool get _useFlutterTexture =>
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows) ||
      useFlutterTexture;
}

abstract class VideoViewControllerBase {
  // VideoViewControllerBase(
  //   this.rtcEngine,
  //   this.canvas,
  //   this.connection,
  //   this.useFlutterTexture,
  //   this.useAndroidSurfaceView,
  // );
  RtcEngine get rtcEngine;

  VideoCanvas get canvas;

  RtcConnection? get connection;

  bool get useFlutterTexture;

  bool get useAndroidSurfaceView;

  void setTextureId(int textureId);

  int getTextureId();

  int getVideoSourceType();

  void setupView(int nativeViewPtr);

  @protected
  Future<int> createTextureRender(
    int uid,
    String channelId,
    int videoSourceType,
  );

  Future<void> initialize();

  @internal
  Future<void> disposeRender();

  Future<void> dispose();
}

mixin VideoViewControllerBaseMixin implements VideoViewControllerBase {
  int _textureId = kTextureNotInit;

  @override
  int getTextureId() => _textureId;

  @override
  void setTextureId(int textureId) {
    _textureId = textureId;
  }

  @override
  Future<void> dispose() async {}

  @internal
  @override
  Future<void> disposeRender() async {
    if (_useFlutterTexture) {
      await rtcEngine.globalVideoViewController
          .destroyTextureRender(getTextureId());
      _textureId = kTextureNotInit;
      return;
    }

    VideoCanvas videoCanvas = VideoCanvas(
      view: 0, // null
      renderMode: canvas.renderMode,
      mirrorMode: canvas.mirrorMode,
      uid: canvas.uid,
      isScreenView: canvas.isScreenView,
      priv: canvas.priv,
      privSize: canvas.privSize,
      sourceType: canvas.sourceType,
      cropArea: canvas.cropArea,
      setupMode: canvas.setupMode,
    );
    if (canvas.uid != 0) {
      rtcEngine.setupRemoteVideo(videoCanvas);
    } else {
      rtcEngine.setupLocalVideo(videoCanvas);
    }
  }

  @protected
  @override
  Future<int> createTextureRender(
    int uid,
    String channelId,
    int videoSourceType,
  ) {
    return rtcEngine.globalVideoViewController.createTextureRender(
      uid,
      channelId,
      videoSourceType,
    );
  }

  @override
  Future<void> initialize() async {
    if (_useFlutterTexture) {
      if (_textureId == kTextureNotInit) {
        _textureId = await createTextureRender(
          canvas.uid!,
          connection?.channelId ?? '',
          canvas.sourceType?.value() ?? getVideoSourceType(),
        );
        debugPrint('initialize _textureId: $_textureId');
      }

      // await rtcEngine.globalVideoViewController.updateTextureRenderData(
      //   _textureId,
      //   canvas.uid!,
      //   connection?.channelId ?? '',
      //   getVideoSourceType(),
      // );
    } else {}
  }

  @override
  void setupView(int nativeViewPtr) {
    VideoCanvas videoCanvas = VideoCanvas(
      view: nativeViewPtr,
      renderMode: canvas.renderMode,
      mirrorMode: canvas.mirrorMode,
      uid: canvas.uid,
      isScreenView: canvas.isScreenView,
      priv: canvas.priv,
      privSize: canvas.privSize,
      sourceType: canvas.sourceType,
      cropArea: canvas.cropArea,
      setupMode: canvas.setupMode,
    );
    if (canvas.uid != 0) {
      if (connection != null) {
        (rtcEngine as RtcEngineEx).setupRemoteVideoEx(
            canvas: videoCanvas, connection: connection!);
      } else {
        rtcEngine.setupRemoteVideo(videoCanvas);
      }
    } else {
      rtcEngine.setupLocalVideo(videoCanvas);
    }
  }
}
