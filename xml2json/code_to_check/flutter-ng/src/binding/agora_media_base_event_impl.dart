import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

extension SnapshotCallbackExt on SnapshotCallback {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'SnapshotCallback_onSnapshotTaken':
        if (onSnapshotTaken == null) break;
        SnapshotCallbackOnSnapshotTakenJson paramJson =
            SnapshotCallbackOnSnapshotTakenJson.fromJson(jsonMap);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        String? filePath = paramJson.filePath;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? errCode = paramJson.errCode;
        if (channel == null ||
            uid == null ||
            filePath == null ||
            width == null ||
            height == null ||
            errCode == null) {
          break;
        }
        onSnapshotTaken!(channel, uid, filePath, width, height, errCode);
        break;
      default:
        break;
    }
  }
}
