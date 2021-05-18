## Overview

扩展应用 ExtApp 能够帮助开发者实现一个自定义插件并嵌入灵动课堂内，例如倒计时、骰子等。 你可以将通过 ExtApp 实现的插件理解为一个相对独立的 App，有自己的生命周期和数据管理，但是又依赖于 Agora Classroom SDK。 开发者可以自定义插件的 UI，传递自定义数据和监听数据变化。

下文介绍通过扩展应用 ExtApp 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

## Procedure

### 1. Implement a plug-in

你可参考 Agora 提供的 [PluginGallery](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas/1.1.0/packages/agora-plugin-gallery)，创建一个独立的 JavaScript 工程项目。

以 PluginGallery 的 countdown 倒计时插件为例，你需要引入相关 Agora Edu Context。

```javascript
import type {IAgoraExtApp, AgoraExtAppContext, AgoraExtAppHandle} from 'agora-edu-core'
```

Refer to the following code to inherit the IAgoraExtApp class to implement a plug-in.

```javascript
export class AgoraExtAppCountDown implements IAgoraExtApp {
  // The plug-in ID. 
    appIdentifier = "io.agora.countdown"
  // The plug-in name
  appName = "Count Down"
  // The default size of the plug-in
  width = 640
  height= 480

  // (Optional) The state management of AgoraExtAppCountDown
  store?:PluginStore

    constructor(){
  }

    // 初始化插件。 你需要在 dom 中绘制你自己插件的内容，ctx 和 handle 是 Agora 提供的 Edu Context，提供插件相关能力
  extAppDidLoad(dom: Element, ctx: AgoraExtAppContext, handle: AgoraExtAppHandle): void {
    this.store = new PluginStore(ctx, handle)
    ReactDOM.render((
      <Provider store={this.store}>
        <App/>
      </Provider>
    ),
      dom
    );
  }
  // 每个插件具有独立的共享 kv 空间，可以通过这个属性完成和其他插件的通信。 When a plug-in updates its properties, other clients that have registered the plug-in will receive this callback. 
    extAppRoomPropertiesDidUpdate(properties:any, cause:any): void {
    this.store?.onReceivedProps(properties, cause)
  }
  // Remove the plug-in
  extAppWillUnload(): void {
    this.store?.cleanup()
  }
}
```

### 2. Register the plug-in

在调用 `AgoraEduSDK.launch` 方法时，通过 `extApps` 参数将该插件注册到 Agora Classroom SDK 中。

The following sample code demonstrates how to register the countdown plug-in CountDownExtApp.

```javascript
import { AgoraExtAppCountDown } from 'agora-plugin-gallery'

const countDownApp = new AgoraExtAppCountDown()
AgoraSDK.launch(dom, {
	extApps: [countDownApp],
	...
})
```

### 3. Use the plug-in

By default, the registered plug-in is displayed in the whiteboard toolbar in the Flexible Classroom. 点击插件的图标即可启动该插件。

![](https://web-cdn.agora.io/docs-files/1619755145025)

若你不想通过默认的方式启动插件，你也可以通过修改 UIKit 模块的相应文件，在灵动课堂中为该插件添加一个入口，然后通过 Agora Edu Context 的 `useAppPluginContext` 获取启动事件，在合适的时机通过 `onLaunchAppPlugin` 启动插件。

## 相关文档

- [Ext App Context]()