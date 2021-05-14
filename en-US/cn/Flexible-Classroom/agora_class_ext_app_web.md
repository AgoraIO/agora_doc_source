## Overview

ExtApp is a tool for embedding plug-ins in Flexible Classroom. Plug-ins implemented by ExtApp can be regarded as an independent application with its own life cycle and data management, but they also depend on the Agora Classroom SDK. You can customize the user interfaces of the plug-in, pass custom data to the Agora Classroom SDK, and monitor data changes through ExtApp. ExtApp enables you to embed custom plug-ins, such as a countdown tool or a dice in the  Flexible Classroom.

This page describes the procedure of using ExtApp to embed a custom plug-in in the Flexible Classroom.

## Procedure

### 1. Implement a plug-in

First, you can refer to the [PluginGallery](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas/1.1.0/packages/agora-plugin-gallery) provided by Agora to create an independent JavaScript project.

Take the countdown plugin in PluginGallery as an example. You need to import the following contexts.

```
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

  // Initialize the plug-in
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
  // Each plug-in has its own shared kv space. Plug-ins can communicate with each other through this attribute. When a plug-in updates its properties, other clients that have registered the plug-in will receive this callback. 
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

To register the plug-in in the Agora Classroom SDK, set the `extApps` parameter when calling `AgoraEduSDK.launch`.

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

By default, the registered plug-in is displayed in the whiteboard toolbar in the Flexible Classroom. Click the icon of the plug-in to use the plug-in.

![](https://web-cdn.agora.io/docs-files/1619755145025)





If you want to customize an entry for the plug-in in the flexible classroom, you can edit the source code of the UI components and call the onLaunchAppPlugin method when the user clicks on the plug-in icon.