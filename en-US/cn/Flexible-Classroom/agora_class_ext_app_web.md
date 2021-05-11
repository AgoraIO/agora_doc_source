## Overview

Extended application ExtApp is a supplementary plug-in for  Flexible Classroom. You can understand ExtApp as a relatively independent App with its own life cycle and data management, but it also depends on the Agora Classroom SDK. You can customize the UI of the plug-in through ExtApp, pass custom data and monitor data changes, and embed custom plug-ins, such as countdown, dice, etc., in the  Flexible Classroom.

The following describes the basic steps of embedding custom plug-ins in Smart Classroom by extending ExtApp.

## Implement real-time messaging

### 1. Implement the plug-in

First, you can refer to the PluginGallery provided by Agora[](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas/1.1.0/packages/agora-plugin-gallery) to create an independent JavaScript project.

Take PluginGallery's countdown countdown plugin as an example, you need to introduce related Context.

```
import type {IAgoraExtApp, AgoraExtAppContext, AgoraExtAppHandle} from 'agora-edu-core'
```

You need to create a class that implements IAgoraExtApp, refer to the following code to implement a plug-in.

```javascript
export class AgoraExtAppCountDown implements IAgoraExtApp {
  // Plug-in ID, the same plug-in on different platforms must use the same ID. 
  appIdentifier = "io.agora.countdown"
  // plugin name
  appName = "Count Down"
  // Plug-in default window size
  width = 640
  "height": 480

  // Used for state management of AgoraExtAppCountDown itself, not required
  store?:PluginStore

  constructor(){
  }

  // The initialization method of ExtApp, you need to draw the content of your own plug-in application in dom, ctx and handle are the plug-in context and capabilities provided to you
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
  // Each plug-in has an independent shared kv space, and communication with other plug-ins can be completed through this attribute. When a plug-in updates its properties, other clients that have registered the plug-in will receive this callback. 
  extAppRoomPropertiesDidUpdate(properties:any, cause:any): void {
    this.store?.onReceivedProps(properties, cause)
  }
  // Remove plugin
  extAppWillUnload(): void {
    this.store?.cleanup()
  }
}
```

### 2. Register the plugin

When calling the `Agora method, `register the plug-in` to the Agora Classroom SDK through the extApps` parameter.

The following sample code demonstrates how to register the countdown plug-in CountDownExtApp.

```javascript
import { AgoraExtAppCountDown } from 'agora-plugin-gallery'

const countDownApp = new AgoraExtAppCountDown()
AgoraSDK.launch (dom, {
	extApps: [countDownApp],
	...
})
```

### 3. Start the plugin

By default, successfully registered plug-ins will be displayed in the toolbox pop-up window of the  Flexible Classroom whiteboard toolbar. Click to start the plug-in.

![](https://web-cdn.agora.io/docs-files/1619755145025)





If you don’t want to start the plug-in by default, you can also modify the corresponding file of the UI Kit module, add an entry for the plug-in in the three major scenarios of Smart Class, and then get the startup event through the useAppPluginContext of Agora Edu Context, at the right time Start the plug-in through onLaunchAppPlugin.