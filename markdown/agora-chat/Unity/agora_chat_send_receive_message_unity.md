登录即时通讯 IM app 后，用户可以在单聊、群聊、聊天室中发送如下类型的消息：

- 文字消息，包含超链接和表情消息。
- 附件消息，包含图片、语音、视频及文件消息。
- 位置消息。
- 透传消息。
- 自定义消息。

针对聊天室消息并发量较大的场景，即时通讯服务提供消息分级功能。你可以通过设置消息优先级，将消息划分为高、普通和低三种级别。你可以在创建消息时，将指定消息类型，或指定成员的所有消息设置为高优先级，确保此类消息优先送达。这种方式可以确保在聊天室内消息并发量较大或消息发送频率过高的情况下，服务器首先丢弃低优先级消息，将资源留给高优先级消息，确保重要消息（如打赏、公告等）优先送达，以此提升重要消息的可靠性 。请注意，该功能并不保证高优先级消息必达。在聊天室内消息并发量过大的情况下，为保证用户实时互动的流畅性，即使是高优先级消息仍然会被丢弃。


本文介绍如何使用即时通讯 IM SDK 实现发送和接收这些类型的消息。

## 技术原理

环信即时通讯 IM Unity SDK 通过 `IChatManager` 和 `Message` 类实现消息的发送、接收与撤回。

其中，发送和接收消息的逻辑如下：

1. 发送方调用相应 `Create` 方法创建文本、文件、附件等类型的消息；
2. 发送方调用 `SendMessage` 发送消息；
3. 接收方通过 `AddChatManagerDelegate` 方法监听消息回调事件。在收到 `OnMessageReceived` 后，即表示成功接收到消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

### 发送文本消息

你可以利用 `Message` 类构造一个消息，然后通过 `IChatManager` 将该消息发出。

示例代码：

```C#
//创建一条文本消息，`content` 为消息文字内容，`toChatUsername` 为对方用户或者群聊的 ID，后文皆是如此。
Message msg = Message.CreateTextSendMessage(toChatUsername, content);

//设置消息类型，即设置 `Message` 类的 `MessageType` 属性。
//该属性的值为 `Chat`、`Group` 和 `Room`，表明该消息是单聊，群聊或聊天室消息，默认为单聊。
//若为群聊，设置 `MessageType` 为 `Group`。
msg.MessageType = MessageType.Group;

//对于聊天室消息，可设置消息优先级。
msg.MessageType = MessageType.Room;
//聊天室消息的优先级。如果不设置，默认值为 `RoomMessagePriority.Normal`，即`普通`优先级。
msg.SetRoomMessagePriority(RoomMessagePriority.High);

//发送消息。
//发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    Debug.Log($"{msg.MsgId}发送成功");
  },
  onError:(code, desc) => {
    Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
  }
));
```

### 接收消息

你可以用注册监听 `IChatManagerDelegate` 接收消息。

该 `IChatManagerDelegate` 可以多次添加，请记得在不需要的时候移除该监听。如在析构 `IChatManagerDelegate` 的继承实例之前。

在新消息到来时，你会收到 `OnMessagesReceived` 的回调，消息接收时可能是一条，也可能是多条。你可以在该回调里遍历消息队列，解析并显示收到的消息。

```C#
//继承并实现 IChatManagerDelegate。
public class ChatManagerDelegate : IChatManagerDelegate {
    //实现 OnMessagesReceived 回调。
    public void OnMessagesReceived(List<Message> messages)
    {
      //收到消息，遍历消息列表，解析和显示。
    }
}

//申请并注册监听。
ChatManagerDelegate adelegate = new ChatManagerDelegate();
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);

//移除监听。
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

### 撤回消息

消息发送后 2 分钟之内，消息的发送方可以撤回该消息。如果需要调整可撤回时限，可以联系商务 [support@agora.io](mailto:support@agora.io)。

```C#
SDKClient.Instance.ChatManager.RecallMessage("Message ID", new CallBack(
  onSuccess: () => {
    Debug.Log("回撤成功");
  },
  onProgress: (progress) => {
    Debug.Log($"回撤进度 {progress}");
  },
  onError: (code, desc) => {
    Debug.Log($"回撤失败，errCode={code}, errDesc={desc}");
  }
 ));
```

还可以使用 `IChatManagerDelegate` 设置消息撤回监听：

```C#
// 接收到消息被撤回时触发此回调（此回调位于 IChatManagerDelegate 中）。
void OnMessagesRecalled(List<Message> messages);
```

### 发送和接收附件消息

语音、图像、视频和文件消息本质上是附件消息。本节介绍如何发送这些类型的消息。

#### 发送和接收语音消息

发送语音消息时，应用层需完成语音文件录制的功能，提供语音文件的 URI 和语音时长。

参考如下示例代码创建并发送语音消息：

```C#
// localPath 为语音文件的本地资源路径，`displayName` 为消息显示名称，语音消息可以设置为空 ""。
// fileSize 为语音文件大小，duration 为语音时长（秒）。
Message msg = Message.CreateVoiceSendMessage(toChatUsername, localPath, displayName, fileSize, duration);

// 设置消息类型，即设置 `Message` 类的 `MessageType` 属性。
// 该属性的值为 `Chat`、`Group` 和 `Room`，表明该消息是单聊，群聊或聊天室消息，默认为单聊。
// 若为群聊，设置 `MessageType` 为 `Group`。
msg.MessageType = MessageType.Group;

// 发送消息。
// 发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    Debug.Log($"{msg.MsgId}发送成功");
  },
  onProgress: (progress) => {
    Debug.Log($"当前发送进度{progress}");
  },
  onError:(code, desc) => {
    Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
  }
));
```

接收方收到语音消息后，参考如下示例代码获取语音消息的附件：

```C#
// 注意：这里的 "Message ID" 是消息发送成功以后（CallBack 中的 onSuccess 被触发以后），被发送消息的 ID。
Message msg = SDKClient.Instance.ChatManager.LoadMessage("Message ID");
if (msg != null)
{
  ChatSDK.MessageBody.VoiceBody vb = (ChatSDK.MessageBody.VoiceBody)msg.Body;

  //语音文件在服务器的路径。
  string voiceRemoteUrl = vb.RemotePath;

  //语音文件的本地路径。
  string voiceLocalUri = vb.LocalPath;
}
else {
  Debug.Log($"未找到消息");
}
```

#### 发送和接收图片消息

默认情况下，SDK 在发送之前会压缩图像文件。可通过设置 `original` 参数为 `true` 发送原图。

参考如下示例代码，创建并发送图片消息：

```C#
//`localPath` 为图片本地资源路径。
//`displayName` 为图片显示名称。
//`fileSize` 为用户上传的图片文件大小，单位为字节。
//`original` 默认为 `false` 即发送压缩后的图片（默认超过 100 KB 的图片会被压缩），如需发送原图则该参数传 `true`。
//`width` 为缩略图的宽度，`height` 为缩略图高度，单位为像素。
Message msg = Message.CreateImageSendMessage(toChatUsername,localPath, displayName, fileSize, original, width , height);

//设置消息类型，即设置 `Message` 类的 `MessageType` 属性。
//设置该属性的值为 `Chat`、`Group` 和 `Room`，分别代表该消息是单聊、群聊或聊天室消息，默认为单聊。
msg.MessageType = MessageType.Group;

//发送消息。
//发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    Debug.Log($"{msg.MsgId}发送成功");
  },
  onProgress: (progress) => {
    Debug.Log($"当前发送进度{progress}");
  },
  onError:(code, desc) => {
    Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
  }
));
```

接收方收到图片消息后，参考如下示例代码获取图片消息的缩略图和附件：

```C#
//注意：这里的 "Message ID" 是消息发送成功以后（`CallBack` 中的 `onSuccess` 被触发以后），被发送消息的 ID。
Message msg = SDKClient.Instance.ChatManager.LoadMessage("Message ID");
if (msg != null)
{
  ChatSDK.MessageBody.ImageBody ib = (ChatSDK.MessageBody.ImageBody)msg.Body;

  //服务器端图片文件路径。
  string imgRemoteUrl = ib.RemotePath;

  //服务器端图片缩略图路径。
  string thumbnailUrl = ib.ThumbnaiRemotePath;

  //本地图片文件路径。
  string imgLocalUri = ib.LocalPath;

  //本地图片缩略图路径。
  Uri thumbnailLocalUri = ib.ThumbnailLocalPath;

}
else {
  Debug.Log($"未找到消息");
}
```

接收方如果设置了自动下载，即 `Options.IsAutoDownload` 为 `true`，SDK 接收到消息后会下载缩略图；如果未设置自动下载，需主动调用 `SDKClient.Instance.ChatManager.DownloadThumbnail` 下载。

下载完成后，调用相应消息 `msg.Body` 的 `ThumbnailLocalPath` 去获取缩略图路径。

#### 发送和接收短视频消息

发送短视频消息时，应用层需要完成视频文件的选取或者录制。视频消息支持给出视频的时长作为参数，发送给接收方。

参考如下示例代码，创建并发送短视频消息：

```C#
Message msg = Message.CreateVideoSendMessage(toChatUsername, localPath, displayName, thumbnailLocalPath, fileSize, duration, width, height);

//发送消息。
//发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    Debug.Log($"{msg.MsgId}发送成功");
  },
  onProgress: (progress) => {
    Debug.Log($"当前发送进度{progress}");
  },
  onError:(code, desc) => {
    Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
  }
));
```

默认情况下，当收件人收到短视频消息时，SDK 会下载视频消息的缩略图。

如果不希望 SDK 自动下载视频缩略图，可以将 `Options.IsAutoDownload` 设置为 `false`。

如果未设置自动下载，需主动调用 `SDKClient.Instance.ChatManager.DownloadThumbnail` 下载。下载完成后，使用相应消息 `Body` 的 `ThumbnailLocalPath` 成员获取缩略图路径。

短视频文件本身需要通过 `SDKClient.Instance.ChatManager.DownloadAttachment` 下载，下载完成后，使用相应消息 `Body` 的 `LocalPath` 成员获取短视频文件路径。

```C#
// 接收到视频消息需先下载附件才能打开。
SDKClient.Instance.ChatManager.DownloadAttachment("Message ID", new CallBack(
  onSuccess: () => {
    Debug.Log($"下载附件成功");

    Message msg = SDKClient.Instance.ChatManager.LoadMessage("Message ID");
    if (msg != null)
    {
      if (msg.Body.Type == ChatSDK.MessageBodyType.VIDEO) {
        ChatSDK.MessageBody.VideoBody vb = (ChatSDK.MessageBody.VideoBody)msg.Body;
        //从本地获取短视频文件路径。
        string videoLocalUri = vb.LocalPath;
        //这里可以根据本地路径打开文件。
      }
    }
    else {
      Debug.Log($"未找到消息");
    }

  },
  onProgress: (progress) => {
    Debug.Log($"下载附件进度 {progress}");
  },
  onError: (code, desc) => {
    Debug.Log($"附件下载失败，errCode={code}, errDesc={desc}");
  }
));
```

#### 发送和接收文件消息

参考如下示例代码创建并发送文件消息：

```C#
// localPath 为文件本地路径，displayName 为消息显示名称，fileSize 为文件大小。
Message msg = Message.CreateFileSendMessage(toChatUsername,localPath, displayName, fileSize);

// 设置消息类型，即设置 `Message` 类的 `MessageType` 属性。
// 设置该属性的值为 `Chat`、`Group` 和 `Room`，分别代表该消息是单聊、群聊或聊天室消息，默认为单聊。
msg.MessageType = MessageType.Group;

// 发送消息。
// 发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    Debug.Log($"{msg.MsgId}发送成功");
  },
  onProgress: (progress) => {
    Debug.Log($"当前发送进度{progress}");
  },
  onError:(code, desc) => {
    Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
  }
));

// 发送成功后，获取文件消息附件。
// 注意：这里的 "Message ID" 是消息发送成功以后（CallBack 中的 onSuccess 被触发以后），被发送消息的 ID。
Message msg = SDKClient.Instance.ChatManager.LoadMessage("Message ID");
if (msg != null)
{
  ChatSDK.MessageBody.FileBody fb = (ChatSDK.MessageBody.FileBody)msg.Body;

  //服务器文件路径。
  string fileRemoteUrl = fb.RemotePath;

  //本地文件路径。
  string fileLocalUri = fb.LocalPath;

}
else {
  Debug.Log($"未找到消息");
}

```

### 发送位置消息

当你需要发送位置时，需要集成第三方的地图服务，获取到位置点的经纬度信息。接收方接收到位置消息时，需要将该位置的经纬度，借由第三方的地图服务，将位置在地图上显示出来。

```C#
//`latitude` 为纬度，`longitude` 为经度，`locationAddress` 为具体位置内容，`buildingName` 为建筑名称。
Message msg = Message.CreateLocationSendMessage(toChatUsername, latitude, longitude, locationAddress, buildingName);

SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    Debug.Log($"{msg.MsgId}发送成功");
  },
  onError:(code, desc) => {
    Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
  }
));
```

### 发送和接收透传消息

透传消息可视为命令消息，通过发送这条命令给对方，通知对方要进行的操作，收到消息可以自定义处理。（透传消息不会存入本地数据库中，所以在 UI 上不会显示）。具体功能可以根据自身业务需求自定义，例如实现头像、昵称的更新等。另外，以 “em_” 和 “easemob::” 开头的 action 为内部保留字段，注意不要使用。

```C#
//`action` 可以自定义。
string action = "actionXXX";
Message msg = Message.CreateCmdSendMessage(toChatUsername, action);
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
   onSuccess: () => {
      Debug.Log($"{msg.MsgId}发送成功");
   },
   onError: (code, desc) => {
      Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
   }
));
```

请注意透传消息的接收方，也是由单独的回调进行通知，方便用户进行不同的处理。

```C#
// 继承并实现 `IChatManagerDelegate`。
public class ChatManagerDelegate : IChatManagerDelegate {

    // 收到消息。
    public void OnMessagesReceived(List<Message> messages)
    {
      // 收到消息，遍历消息列表，解析和显示。
    }
    // 收到透传消息。
    void OnCmdMessagesReceived(List<Message> messages)
    {
      // 收到消息，遍历消息列表，解析和处理。
    }
}

// 申请并注册监听。
ChatManagerDelegate adelegate = new ChatManagerDelegate()
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);

```

### 发送自定义类型消息

除了几种消息之外，你可以自己定义消息类型，方便业务处理，即首先设置一个消息类型名称，然后可添加多种自定义消息。自定义消息内容为键值对（key-value）格式，你需要自己添加并解析该内容。

```C#
//`event` 为字符串类型的自定义事件，比如礼物消息，可以设置：
string event = "gift";

//`adict` 类型为 `Dictionary<string, string>`。
Dictionary<string, string> adict = new Dictionary<string, string>();
adict.Add("key", "value");

Message msg = Message.CreateCustomSendMessage(toChatUsername, event, adict);
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
   onSuccess: () => {
      Debug.Log($"{msg.MsgId}发送成功");
   },
   onError: (code, desc) => {
      Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
   }
));
```

### 使用消息的扩展字段

当 SDK 提供的消息类型不满足需求时，你可以通过消息扩展字段传递自定义的内容，从而生成自己需要的消息类型。

当目前消息类型不满足用户需求时，可以在扩展部分保存更多信息，例如消息中需要携带被回复的消息内容或者是图文消息等场景。

```C#
Message msg = Message.CreateTextSendMessage(toChatUsername, content);

// 增加自定义属性。
AttributeValue attr1 = AttributeValue.Of("value", AttributeValueType.STRING);
AttributeValue attr2 = AttributeValue.Of(true, AttributeValueType.BOOL);
msg.Attributes.Add("attribute1", attr1);
msg.Attributes.Add("attribute2", attr2);

// 发送消息。
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
  onSuccess: () => {
    Debug.Log($"{msg.MsgId}发送成功");
  },
  onError:(code, desc) => {
    Debug.Log($"{msg.MsgId}发送失败，errCode={code}, errDesc={desc}");
  }
));

// 接收消息的时候获取扩展属性。
bool found = false;
string str = msg.GetAttributeValue<string>(msg.Attributes, "attribute1", found);
if (found) {
  // 使用 str 变量。
}
found = false；
bool b = msg.GetAttributeValue<bool>(msg.Attributes, "attribute2", found);
if (found) {
  // 使用 b 变量。
}
```