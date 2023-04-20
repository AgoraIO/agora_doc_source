在虚拟场景中，塑造一个独一无二的虚拟形象是进入场景的第一步。元语聊支持导入自定义人物素材模型，并支持换装和捏脸功能。本文介绍如何在元语聊中实现对虚拟形象的换装和捏脸。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaChat](https://github.com/AgoraIO-Community/Agora-MetaChat/tree/dev_sdk2) 示例项目供你参考使用。如果你还需了解 Unity 部分的工程文件和功能指南，请联系 sales@agora.io 获取。


## 前提条件

实现换装和捏脸前，请确保你已实现基础的元语聊功能，如创建、进入 3D 场景、创建虚拟形象。详见[客户端实现](https://docs.agora.io/cn/metachat/metachat_client_ios?platform=All%20Platforms)。


## 实现步骤

本节展示如何实现换装，内容以 Native 部分的开发为主，Unity 部分的开发请参考 Unity 工程文件和功能指南。捏脸的功能实现也请参考 Unity 工程文件。

下图展示 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1680172665142)

### 1. 更换装扮

建议在业务逻辑中包含多个场景的情况下，调用 [`enterScene`](https://docs.agora.io/cn/metachat/metachat_api_ios?platform=All%20Platforms#enterscene) 时使用 `AgoraMetachatEnterSceneConfig` 中的 `extraCustomInfo` 来设置 `sceneIndex`，以便区分不同的场景。Unity 场景脚本可以根据 `sceneIndex` 来确定进入哪个场景，并执行相应的逻辑。

在这种情况下，我们将 `sceneIndex` 设置为“换装”或场景，这些场景只包含待更换装扮的用户，没有其他用户。因此，在这些场景中，只需要更换装扮。你可以通过 `AgoraMetachatScene` 的 [`sendMessageToScene`](https://docs.agora.io/cn/metachat/metachat_api_ios?platform=All%20Platforms#sendmessagetoscene) 方法向 Unity 场景发送自定义的换装消息。Unity 场景脚本可以处理对应的自定义消息，实现人物装扮的更换。

```swift
// 本节代码展示换装的逻辑
// 创建 dressDic 字典，包含用户的着装信息，并将其转换成 JSON 格式的数据
// 信息格式需要与 Unity 场景使用的格式协商一致
let dressDic = ["gender": userDressInfo.gender,
                "hair": userDressInfo.hair,
                "tops": userDressInfo.tops,
                "lower": userDressInfo.lower,
                "shoes": userDressInfo.shoes]
let value = try? JSONSerialization.data(withJSONObject: dressDic, options: [])
let str = String(data: value!, encoding: String.Encoding.utf8)

// 创建 msgDic 字段，包含 key 和 value
// 设置 key 为 dressSetting
// 设置 value 为 dressDic 的 JSON 字符串
let msgDic = [
    "key": "dressSetting",
    "value": str as Any
] as [String : Any]
data = try? JSONSerialization.data(withJSONObject:msgDic, options: .fragmentsAllowed)
// 将 msgDic 的 JSON 格式的数据（换装消息）发送到场景中
metachatScene?.sendMessage(toScene: data)
```


### 2. 同步装扮

更换人物装扮后，如果用户需进入其他场景并让其他用户看到新形象，则需要同步更换的装扮信息。你可以通过 `AgoraMetachatLocalUserAvatar` 的 [`setDressInfo`](https://docs.agora.io/cn/metachat/metachat_api_ios?platform=All%20Platforms#setdressinfo) 方法让 SDK 将更新后的形象同步给场景中的其他用户：


```swift
// 本节代码展示同步装扮的逻辑
// 创建 dict 字段，存储用户的着装信息，并将其转换成 JSON 格式的数据
let dict = ["gender": userDressInfo.gender,
            "hair": userDressInfo.hair,
            "tops": userDressInfo.tops,
            "lower": userDressInfo.lower,
            "shoes": userDressInfo.shoes]
let value = try? JSONSerialization.data(withJSONObject: dict, options: [])
let str = String(data: value!, encoding: String.Encoding.utf8)

let dressInfo = AgoraMetachatDressInfo()
// extraCustomInfo 是额外的自定义信息
// 将 extraCustomInfo 设置为换装消息的 JSON 字符串
dressInfo.extraCustomInfo = str!.data(using: String.Encoding.utf8)

// 设置本地用户的模型信息
let avatarInfo = AgoraMetachatAvatarModelInfo.init()
for info in sceneInfo.bundles {
    if info.bundleType == .avatar {
        avatarInfo.bundleCode = info.bundleCode;
        break
    }
}

localUserAvatar = metachatScene?.getLocalUserAvatar()
// 设置用户信息
localUserAvatar?.setUserInfo(currentUserInfo)
// 设置本地用户的模型信息
localUserAvatar?.setModelInfo(avatarInfo)
// 设置本地用户的服装信息
localUserAvatar?.setDressInfo(currentDressInfo)
```

