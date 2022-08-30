# Agora 即时通讯 IM UIKit 快速开始

即时的消息传递将人连接到任何地方，并允许他们实时与他人交流。使用内置的用户界面（UI）用于对话列表和联系人列表，[Agora 即时通讯 IM Uikit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-web) 可以将实时消息快速嵌入到你的应用中，让你只需关注自身业务或个性化扩展。

本页展示如何使用 Agora 即时通讯 IM UIKit 将点对点消息添加到应用程序中。

## 技术原理

下图显示了客户如何发送和接收点对点消息的工作流程：

![img](https://web-cdn.agora.io/docs-files/1643335864426)

1. 客户端从你的应用服务器获取 token。
2. 客户 A 和客户 B 登录 Agora Chat。
3. 客户端 A 向客户端 B 发送消息，消息被发送到 Agora 即时通讯 IM 服务器，服务器将消息传递给客户端 B。客户端 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

## 前提条件

开始前，请确保你的开发环境满足以下要求：

- React 16.8.0 或以上版本；
- React DOM 16.8.0 或以上版本；
- 支持的浏览器和版本如下：
  - IE：11 或以上
  - Edge：43 或以上
  - Firefox：10 或以上
  - Chrome：54 或以上
  - Safari：11 或以上

- 有效的 [Agora 账户](https://docs.agora.io/en/AgoraPlatform/get_appid_token?platform=AllPlatforms#create-an-agora-account)。
- 启用 [聊天服务](https://docs.agora.io/en/agora-chat/enable_agora_chat?platform=Web#enable-the-agora-chat-service)。
- 有效的 [App Key](https://docs.agora.io/en/agora-chat/enable_agora_chat?platform=Web#get-the-information-of-the-agora-chat-project) 和 [用户 token](https://docs.agora.io/en/agora-chat/generate_user_tokens?platform=Web)。

## 项目设置

本节介绍了如何创建应用程序并将聊天 UIKIT 添加到项目中。

1. 在终端中，运行以下命令来创建一个应用程序：

   ```shell
   # 安装 cli 工具
   npm install create-react-app
   # 构建一个 my-app 的项目
   npx create-react-app my-app
   cd my-app
   ```

   成功创建应用程序后，项目结构如下：

   ```shell
   my-app
   ├── package.json
   ├── public                  # webpack 的配置的静态目录。
   │   ├── favicon.ico
   │   ├── index.html          # 默认的单页面应用，是最终的 html 的基础模板。
   │   └── manifest.json
   ├── src
   │   ├── App.css             # App 根组件的 css。
   │   ├── App.js              # App 组件代码。
   │   ├── App.test.js
   │   ├── index.css           # 启动文件样式。
   │   ├── index.js            # 启动文件。
   │   ├── logo.svg
   │   └── serviceWorker.js
   └── yarn.lock
   ```

2. 运行以下命令之一，将 CHAT UIKIT 添加到您的项目中。

- 若利用 npm 安装，运行以下命令：
   ```shell
   npm install agora-chat-uikit --save
   ```

   使用 yarn 添加 UIKit

   ```shell
   yarn add agora-chat-uikit
   ```

## 具体步骤

Web 即时通讯 IM UIKit 有两部分：

- `EaseApp`, which contains the conversation list and applies to use cases where you want to quickly launch a real-time chat app.
- `EaseChat`，其中包含一个对话框，并适用于大多数聊天用例，例如发送和接收消息，在UI上显示消息以及管理未读消息。

This section introduces the steps you need to take to quickly implement one-to-one messaging with `EaseApp`.

1. 导入`EaseApp`.

   打开`my-app/src/App.js`，并用以下内容替换代码：

   ```javascript
    // App.js
    import React, {Component} from 'react';
    import { EaseApp } from "agora-chat-uikit"
    import './App.scss';

    class App extends Component {
    render() {
        return (
        <div className="container">
            <EaseApp
                // 你注册的 App Key。
                appkey= "xxx"
                // 当前登录的用户 ID。
                username= "xxx"
                // 声网 token，关于如何获取声网 token 下文有介绍。
                agoraToken= "xxx"
                />
        </div>
        );
      }
    }

    export default App;
   ```

2. 为对话设置布局。

   打开 `my-app/src/App.js`，并用以下内容替换内容：

   ```javascript
    /** App.css */
    .container {
        height: 100%;
        width: 100%
    }
   ```

## 测试你的应用

在您的终端中，运行以下命令启动该应用程序：

```shell
npm run start
```

你可以在浏览器中查看应用程序启动。在发送消息之前，请参考 [添加联系人](https://docs.agora.io/en/agora-chat/manage_user_friend_web?platform=Web#manage-contacts)或[加入聊天组](https://docs.agora.io/en/agora-chat/agora_chat_group_web?platform=Web#join-and-leave-a-chat-group)以添加联系人或加入聊天组。

## 下一步

本节包括您可以在项目中实现的更高级功能。

### 适用的用例

作为对话组件，`EaseChat` 可以在广泛的用例中应用，例如，通过弹出对话框以进行点击事件，或在用户登录后添加回调事件。

```javascript
import React, { useState } from "react";
import { EaseChat } from "agora-chat-uikit";
    const addListen = (res) => {
    if(res.isLogin){
           const WebIM = EaseChat.getSdk()
        WebIM.conn.addEventHandler('testListen',{
          onTextMessage:()=>{},
          onError:()=>{},
          ...
        })
     }
  }
    const chat = () => {
        return (
        <div>
      <EaseChat
        appkey={'xxx'}
        username={'xxx'}
        agoraToken={'xxx'}
        to={'xxx'}
                successLoginCallback={addListener}
      />
     <div/>
        )
    }
    const app = () =>{
    const [showSession, setShowSession] = useState(false);
    return(
    <div>
        { showSession && chat()}
        <button onClick={()=>setShowSession(true)}>Launch the session</button>
        <button onClick={()=>setShowSession(false)}>Close the session</button>
    <div/>
    )
    }
```

### 自定义属性

`EaseChat` 提供以下自定义属性。你可以通过设置这些属性来自定义功能和布局。

| 属性                   | 类型                  | 必需的 | 描述                                                         |
| :--------------------- | :-------------------- | :----- | :----------------------------------------------------------- |
| `appkey`               | 细绳                  | 是的   | 规则是`$(OrgName)#{AppName}`。                               |
| `username`             | 细绳                  | 是的   | 用户标识。                                                   |
| `agoraToken`           | 细绳                  | 是的   | The Agora token.                                             |
| `to`                   | 细绳                  | 是的   | In one-to-one messaging, it is the user ID of the recipient; in group chat, it is the group ID. |
| `showByselfAvatar`     | 布尔                  | 不     | 是否显示当前用户的化身。`true`： 是的（默认）`false`：否     |
| `easeInputMenu`        | 细绳                  | 不     | The mode of the input menu.(Default) `all`: The complete mode.`noAudio`：没有音频。`noEmoji`：没有表情符号。`noAudioAndEmoji`: No audio or emoji.`onlyText`: Only text. |
| `menuList`             | 大批                  | 不     | The extensions of the input box on the right panel. (Default) `menuList`: `[ {name:'Send a pic', value:'img'},{name:'Send a file', value:'file'}]` |
| `handleMenuItem`       | function({item, key}) | 不     | The callback event triggered by clicking on the right panel of the input box. |
| `successLoginCallback` | 功能（资源）          | 不     | 成功登录的回调事件。                                         |
| `failCallback`         | function(err)         | 不     | The callback event for a failed method call.                 |

### 加入业务逻辑

在你自己的业务逻辑中可以使用 CHAT UIKIT 提供的各种回调事件，如下所示：

1. 获取 SDK 实例

   ```javascript
    const WebIM = EaseChat.getSdk({ appkey: 'xxxx' })
   ```

2. 添加回调事件

   调用 `addEventHandler` 添加回调事件。

   ```javascript
    // Use nameSpace to differentiate the different business logics. You can add multiple callback events according to your needs.。
    WebIM.conn.addEventHandler('nameSpace'),{
        onOpend:()=>{},
        onTextMessage:()=>{},
        .... })
   ```

Refer to [EventHandlerType](https://docs.agora.io/en/agora-chat/API Reference/im_ts/v1.0.5/modules/EventHandler.html?transId=4977acf0-08eb-11ed-a46a-e58831549a58) for the complete list of callback events you can add.

## 参考

Agora Chat在GitHub上提供了一个已集成Uikit的开源[Agorachat](https://github.com/AgoraIO-Usecase/AgoraChat-web)样本项目。