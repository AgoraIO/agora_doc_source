## 概览

扩展应用 ExtApp 能够帮助开发者实现一个自定义插件并嵌入灵动课堂内，例如倒计时、骰子等。你可以将通过 ExtApp 实现的插件理解为一个相对独立的 App，有自己的生命周期和数据管理，但是又依赖于 Agora Classroom SDK。开发者可以自定义插件的 UI，传递自定义数据和监听数据变化。

下文介绍通过扩展应用 ExtApp 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

## 操作步骤

### 1. 实现插件

你可参考 Agora 提供的 [PluginGallery](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas/1.1.0/packages/agora-plugin-gallery)，创建一个独立的 JavaScript 工程项目。

以 PluginGallery 的 countdown 倒计时插件为例，你需要引入相关 Agora Edu Context。

```javascript
import type {IAgoraExtApp, AgoraExtAppContext, AgoraExtAppHandle} from 'agora-edu-core'
```

你需要创建一个实现 IAgoraExtApp 的类，参考以下代码实现一个插件。

```javascript
export class AgoraExtAppCountDown implements IAgoraExtApp {
  // 插件 ID，不同平台的相同插件必须使用同一 ID。
  appIdentifier = "io.agora.countdown"
  // 插件名称
  appName = "Count Down"
  // 插件默认窗口大小
  width = 640
  height= 480

  // 用于 AgoraExtAppCountDown 本身的状态管理，非必须
  store?:PluginStore

  constructor(){
  }

  // 初始化插件。你需要在 dom 中绘制你自己插件的内容，ctx 和 handle 是 Agora 提供的 Edu Context，提供插件相关能力
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
  // 每个插件具有独立的共享 kv 空间，可以通过这个属性完成和其他插件的通信。当有插件更新属性时，其他注册了该插件的客户端会收到这个回调。
  extAppRoomPropertiesDidUpdate(properties:any, cause:any): void {
    this.store?.onReceivedProps(properties, cause)
  }
  // 移除插件
  extAppWillUnload(): void {
    this.store?.cleanup()
  }
}
```

### 2. 注册插件

在调用 `AgoraEduSDK.launch` 方法时，通过 `extApps` 参数将该插件注册到 Agora Classroom SDK 中。

以下示例代码演示了如何注册倒计时插件 CountDownExtApp。

```javascript
import { AgoraExtAppCountDown } from 'agora-plugin-gallery'

const countDownApp = new AgoraExtAppCountDown()
AgoraSDK.launch(dom, {
	extApps: [countDownApp],
	...
})
```

### 3. 启动插件

默认情况下，成功注册的插件会显示在灵动课堂白板工具栏的工具箱弹窗里显示。点击插件的图标即可启动该插件。

![](https://web-cdn.agora.io/docs-files/1619755145025)

若你不想通过默认的方式启动插件，你也可以通过修改 UIKit 模块的相应文件，在灵动课堂中为该插件添加一个入口，然后通过 Agora Edu Context 的 `useAppPluginContext` 获取启动事件，在合适的时机通过 `onLaunchAppPlugin` 启动插件。

## 相关文档

- [Ext App Context]()