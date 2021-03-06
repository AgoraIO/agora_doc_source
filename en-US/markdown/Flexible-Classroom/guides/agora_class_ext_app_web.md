## Overview

ExtApp enables developers to develop a custom plugin, such as a countdown plugin or a dice, and embed the plugin in the flexible classroom. Plugins implemented by ExtApp can be regarded as an independent application with its own life cycle and data management, but they also connect with the Agora Classroom SDK. Developers can customize the user interfaces of the plugins, pass custom data to the Agora Classroom SDK, and also listen for data change from the Agora Classroom SDK. 

This page introduces the procedure of using ExtApp to develop and embed a custom plugin in the flexible classroom.

## Procedure

### 1. Implement a plugin

Refer to the [PluginGallery](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas/1.1.0/packages/agora-plugin-gallery) provided by Agora to create an independent JavaScript project.

Take the countdown plugin in PluginGallery as an example. You need to import the following contexts.

```javascript
import type {IAgoraExtApp, AgoraExtAppContext, AgoraExtAppHandle} from 'agora-edu-core'
```

Refer to the following code to inherit the IAgoraExtApp class to implement a plugin.

```javascript
export class AgoraExtAppCountDown implements IAgoraExtApp {
  // The plugin ID. 
    appIdentifier = "io.agora.countdown"
  // The plugin name
  appName = "Count Down"
  // The default size of the window for the plugin
  width = 640
  height= 480

  // (Optional) The state management of AgoraExtAppCountDown
  store?:PluginStore

    constructor(){
  }

  // Initialize the plugin. Draw the content of the plug-in in dom. The ctx and handle parameter refers to the edu context provided by Agora
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
  // Each plugin has its own shared kv space. Plugins can communicate with each other through this property. When the property of the plugin is updated, other clients that have also registered the plugin will receive this callback. 
    extAppRoomPropertiesDidUpdate(properties:any, cause:any): void {
    this.store?.onReceivedProps(properties, cause)
  }
  // Remove the plugin
  extAppWillUnload(): void {
    this.store?.cleanup()
  }
}
```

### 2. Register the plugin to the Agora Classroom SDK

To register the plugin in the Agora Classroom SDK, set the `extApps` parameter when calling `AgoraEduSDK.launch`.

The following sample code shows how to register the countdown plugin CountDownExtApp to the Agora Classroom SDK.

```javascript
import { AgoraExtAppCountDown } from 'agora-plugin-gallery'

const countDownApp = new AgoraExtAppCountDown()
AgoraSDK.launch(dom, {
	extApps: [countDownApp],
	...
})
```

### 3. Use the plugin in the flexible classroom

By default, the icon of the registered plugin is displayed in the whiteboard toolbar in the flexible classroom. Click the icon to use the plugin.

![](https://web-cdn.agora.io/docs-files/1619755145025)

If you want to customize an entry for the plugin in the flexible classroom, you can edit the source code of the UI components. Listen for the events of the Agora Classroom SDK through `useAppPluginContext` and call the `onLaunchAppPlugin` method to launch the plugin when the user clicks on the plugin icon.

## See also

- [Ext App Context]()