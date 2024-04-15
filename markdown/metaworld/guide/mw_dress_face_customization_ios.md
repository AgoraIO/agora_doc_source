在虚拟场景中，塑造一个独一无二的虚拟形象是进入场景的第一步。MetaWorld 支持导入自定义人物素材模型，并支持换装和捏脸功能。本文介绍如何在 MetaWorld 中实现对虚拟形象的换装和捏脸。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 示例项目供你参考。

如果你还需了解 Unity 部分的工程文件和功能指南，请联系 [sales@agora.io](mailto:sales@agora.io) 获取。


## 前提条件

实现换装和捏脸前，请确保你已实现基础的元语聊或元直播功能，如创建 Meta 服务、获取并下载场景资源、创建场景、设置虚拟形象的信息并进入场景。详见[基础功能](https://docs.agora.io/cn/metaworld/mw_integration_metachat_ios?platform=All%20Platforms)。

## 实现步骤

下图展示 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1688114645529)

### 1. 解压资源并设置 UI

解压用于换装和捏脸的资源压缩包，并根据下载的资源文件显示特定的 UI。

### 2. 发送换装和捏脸消息

通过 [`sendSceneMessage`](./mw_api_ref_ios?platform=All%20Platforms#sendscenemessage) 方法向虚拟场景中发送用户虚拟角色的换装和捏脸消息。

```swift
private let UPDATE_DRESS = "updateDress"

let dic = ["id": [10002]]
let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
let str = String(data: data!, encoding: String.Encoding.utf8)

let sendDic = [
    "key": UPDATE_DRESS,
    "value": str as Any
] as [String : Any]

// 注意：message 协议格式需要由你们的 Unity 开发人员和 Native 开发人员协商后规定
if let message = try? JSONSerialization.data(withJSONObject:sendDic, options: .fragmentsAllowed) {
    // 发送换装消息到虚拟场景中
    metaScene?.sendMessage(message)
}


private let UPDATE_FACE = "updateFace"

let dic = ["value": [["key": "EB_updown_1", "value": value]]]
let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
let str = String(data: data!, encoding: String.Encoding.utf8)
let sendDic = [
    "key": UPDATE_FACE,
    "value": str as Any
] as [String : Any]

// 注意：message 协议格式需要由你们的 Unity 开发人员和 Native 开发人员协商后规定
if let message = try? JSONSerialization.data(withJSONObject:sendDic, options: .fragmentsAllowed) {
    // 发送捏脸消息到虚拟场景中
    metaScene?.sendMessage(message)
}
```