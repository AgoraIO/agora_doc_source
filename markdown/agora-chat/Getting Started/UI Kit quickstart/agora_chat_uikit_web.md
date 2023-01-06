# 即时通讯 IM UIKit 快速开始

即时的消息传递将人连接到任何地方，并允许他们实时与他人交流。使用内置的用户界面（UI）用于对话列表和联系人列表，[即时通讯 IM Uikit](https://github.com/AgoraIO-Usecase/AgoraChat-UIKit-web) 可以将实时消息快速嵌入到你的应用中，让你只需关注自身业务或个性化扩展。

本页展示如何使用即时通讯 IM UIKit 将单聊消息发送和接收的逻辑添加到应用程序中。

## 技术原理

下图显示了客户如何发送和接收单聊消息的工作流程：

![img](https://web-cdn.agora.io/docs-files/1643335864426)

1. 客户端从你的应用服务器获取 token。
2. 客户 A 和客户 B 登录即时通讯 IM。
3. 客户端 A 向客户端 B 发送消息，消息被发送到即时通讯 IM 服务器，服务器将消息传递给客户端 B。客户端 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

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

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA-agora-%E8%B4%A6%E5%8F%B7)。
- [开启了即时通讯 IM 服务](./enable_agora_chat)。
- 有效的 [App Key](./enable_agora_chat#获取即时通讯项目信息) 和 [用户 token](./agora_chat_token)。

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

- 使用 yarn 安装，运行以下命令：

   ```shell
   yarn add agora-chat-uikit
   ```

## 具体步骤

Web 即时通讯 IM UIKit 有两部分：

- `EaseApp`，其中包含会话列表，并适用于大多数聊天用例，可快速搭建聊天应用。
- `EaseChat`，其中包含一个对话框，并适用于大多数聊天用例，例如发送和接收消息，在 UI 上显示消息以及管理未读消息。

以下内容为介绍如何使用 `EaseApp` 搭建聊天界面。

1. 导入 `EaseApp`。

   打开 `my-app/src/App.js`，并用以下内容替换代码：

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

2. 设置会话布局。

   打开 `my-app/src/App.js`，将文件中的内容替换为以下代码：

   ```javascript
    /** App.css */
    .container {
        height: 100%;
        width: 100%
    }
   ```

## 测试你的应用

在你的终端中，运行以下命令启动该应用程序：

```shell
npm run start
```

你可以在浏览器中查看应用程序启动。发送消息前，请参考 [添加好友](./agora_chat_contact_web#添加好友) 或 [加入群组](./agora_chat_group_web#加入群组) 添加联系人或加入群组。

## 后续步骤

本节包括你可以在项目中实现的更高级功能。

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

`EaseChat` 提供以下自定义属性。你可以通过设置这些属性实现自定义功能和布局。为确保 `EaseChat` 的功能实现，必须设置所有必选参数。

| 属性                   | 类型                  | 是否必填 | 描述                                                         |
| :--------------------- | :-------------------- | :----- | :----------------------------------------------------------- |
| `appkey`               | String                 | 是  | 即时通讯 IM 分配给每个 app 的唯一标识，生成规则为 `$(OrgName)#{AppName}`。                               |
| `username`             | String                 | 是  | 用户标识。                                                   |
| `agoraToken`           | String                  | 是  | Agora token.                                             |
| `to`                   | String                  | 是  | 消息接收方。单聊时为对方用户 ID，群聊时为群组 ID。 |
| `showByselfAvatar`     | Bool                  | 否    | 是否显示当前用户的头像。<li>`true`： 是。<li>（默认）`false`：否。     |
| `easeInputMenu`        | String                 | 否    | 输入菜单模式。<li>(Default) `all`: 完整模式。<li>`noAudio`：无音频。<li>`noEmoji`：无表情符号。<li>`noAudioAndEmoji`: 没有视频和表情符号。<li>`onlyText`: 仅文本。 |
| `menuList`             | Array                 | 否    | 输入框右侧栏菜单扩展。 (默认) `menuList`: `[ {name:'发送图片', value:'img'},{name:'发送文件', value:'file'}]` |
| `handleMenuItem`       | function({item, key}) | 否     | 在输入框中点击菜单栏。 |
| `successLoginCallback` | function(res）          | 否    | 成功登录的回调事件。                                         |
| `failCallback`         | function(err)         | 否    | 方法调用失败的回调。                 |

### 添加业务逻辑

在你自己的业务逻辑使用即时通讯 IM UIKit 提供的各种回调事件，如下所示：

1. 获取 SDK 实例

   ```javascript
    const WebIM = EaseChat.getSdk({ appkey: 'xxxx' })
   ```

2. 添加回调事件

   调用 `addEventHandler` 添加回调事件。

   ```javascript
    // 用 `nameSpace` 定义不同的业务逻辑，可以根据自己的需求添加多个。
    WebIM.conn.addEventHandler('nameSpace'),{
        onOpend:()=>{},
        onTextMessage:()=>{},
        .... })
   ```

参考 [EventHandlerType](https://docs.agora.io/cn/agora-chat/API Reference/im_ts/v1.0.5/modules/EventHandler.html?transId=4977acf0-08eb-11ed-a46a-e58831549a58) 了解所有回调事件。

## 参考

即时通讯 IM 在 GitHub 上提供了一个已集成 Uikit 的开源样本项目 [Agorachat](https://github.com/AgoraIO-Usecase/AgoraChat-web) 。