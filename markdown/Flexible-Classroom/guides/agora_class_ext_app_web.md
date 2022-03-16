## 概览

扩展应用 ExtApp 能够帮助开发者实现一个自定义插件并嵌入灵动课堂内，例如倒计时、骰子等。你可以将通过 ExtApp 实现的插件理解为一个相对独立的 App，有自己的生命周期和数据管理，但是又依赖于 Agora Classroom SDK。开发者可以自定义插件的 UI，传递自定义数据和监听数据变化。

下文介绍通过扩展应用 ExtApp 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

## 操作步骤

### 1. 实现插件

引入 `agora-edu-core` 的 `IAgoraExtApp`，`AgoraExtAppContext`，`AgoraExtAppHandle`，然后基于 `IAgoraExtApp` 类实现一个自定义插件。

`IAgoraExtApp` 提供以下属性和方法：

```javascript
export interface IAgoraExtApp {
  // 界面语言
  language: string;
  // ExtApp ID。不同平台的相同插件必须使用同一 ID。
  appIdentifier: string;
  // ExtApp 的名称。
  appName: string;
  // ExtApp 的默认宽度和高度。
  width: number;
  height: number;
  // （非必需）ExtApp 的最小宽度和高度。
  minWidth?: number;
  minHeight?: number;
  // （非必需）ExtApp 的 icon。
  icon?: any;
  // （非必需）ExtApp 的自定义头部。
  customHeader?: JSX.Element;
  // （非必需）监听 AgoraExtAppEventHandler 事件
  eventHandler?: AgoraExtAppEventHandler;
  // 初始化 ExtApp。你需要在 dom 中绘制你自己插件的内容，ctx 和 handle 是 Agora 提供的 Edu Context，提供插件相关能力
  extAppDidLoad(dom: Element, ctx: AgoraExtAppContext, handle: AgoraExtAppHandle): void;
  // 每个 ExtApp 具有独立的共享 kv 空间，可以通过这个属性完成和其他 ExtApp的通信。当有 ExtApp 更新属性时，其他注册了该 ExtApp 的客户端会收到这个回调。
  extAppRoomPropertiesDidUpdate(properties: any, cause: any): void;
  // 移除 ExtApp。
  extAppWillUnload(): Promise<boolean>;
}
```

Agora 已基于 `IAgoraExtApp` 实现了屏幕共享、答题器、计时器、投票器等 ExtApp。你可点击链接前往 GitHub 查看源码：[agora-plugin-gallery](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/release/apaas%2F2.1.1/packages/agora-plugin-gallery)。

### 2. 注册插件

在调用 `AgoraEduSDK.launch` 方法时，通过 `extApps` 参数将该插件注册到 Agora Classroom SDK 中。

以下示例代码演示了如何注册倒计时 CountDownExtApp。

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