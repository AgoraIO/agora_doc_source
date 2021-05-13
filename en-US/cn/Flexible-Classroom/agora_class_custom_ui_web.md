## Overview

Agora provides a complete[ Agora Classroom SDK on npm](https://www.npmjs.com/package/agora-classroom-sdk) for you to integrate. However, if the default UI in the Agora Classroom SDK cannot meet your needs, you can also obtain the source code of the Agora Classroom SDK to develop, debug, and compile by yourself. The source code of the Agora Classroom SDK for Desktop is located in the [CloudClass-Desktop ](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/master)repository on GitHub (release/apaas/1.1.0 branch). In the Agora Classroom SDK, the UI code of the Flexible Classroom Classroom is separated from the core business logic, and separated into two libraries, UIKit and EduCore, which are related through[ Agora Edu Context](https://docs.agora.io/cn/agora-class/edu_context_api_ref_web_overview?platform=Web). For example, for the text chat function in the  Flexible Classroom, you need to send a message through a button, and at the same time you need to receive messages sent by other users. In this case, we can call the sending message method in the Chat Context in UIKit and monitor the message reception related events in the Chat Context.

![](https://web-cdn.agora.io/docs-files/1619696813295)

UIKit provides  Flexible Classroom UI component code, and introduces the open source tool [Storybook](https://storybook.js.org/docs/react/get-started/introduction) to develop and manage UI components. You can find the source code of the UIKit in the packages/`agora-scenario-ui-`kit/src folder in the CloudClass-Desktop repository on GitHub (Branch dev/apaas/1.1.0). The project structure of the UIKit is as follows:

| Folder | Description |
| :------------- | :----------------------------------------------------------- |
| `components` | The source code of the basic UI components used by Flexible Classroom. A UI component generally contains the following files:<li>`.css`: Define the style of the component.</li><li>`.stories.tsx`: Define the display of components in Storybook.</li><li>`.tsx`: Define the detailed design of the component.</li> |
| `capabilities` | <li>`containers`: The source code of high-level UI components used by Smart Class.</li><li>`scenarios`: The source code of the scenario UI components used by Smart Class.</li> |
| `scaffold` | The classroom-level UI components, which play as scaffolds and show how the basic UI components are combined in a classroom. |
| `styles` | Define the global style. |
| `utilities` | For functions such as internationalization, and custom hooks. |

## Implementation

### Development environment

- Install[ Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

   ```shell
   # Install Node.js and npm globally
npm install -g npm
# Check Node.js version
node -v
# Check npm version
npm -v
   ```

- Install yarn

   ```shell
   # Install yarn
npm install yarn -g
# Check yarn version
yarn -v
   ```

### Implement real-time messaging

Modify the UI of Flexible Classroom, as follows:

1. Go to the root directory of the CloudClass-Desktop project, check out the release/apaas/1.1.0 branch, and then run the following command to install the dependencies.

   ```shell
   # Install global dev dependencies
yarn
# Install all dependencies via lerna and yarn
yarn bootstrap
   ```

2. Run the following command to open Storybook to quickly adjust the UI.

   ```shell
   # Open storybook
yarn dev:ui-kit
   ```

   You can see all the basic UI components used by Flexible Classroom in Storybook.

   ![storybook-example](https://web-cdn.agora.io/docs-files/1617714921810)

   You can directly edit the source code of a component in the `packages/agora-scenario-ui-kit/src/components` folder to modify the UI of this component. After saving the code, you can see the changed UI in Storybook. If the existing basic UI components of Flexible Classroom cannot meet your needs, you can` add a new` UI component in the packages/agora-scenario-ui-kit/src/components` directory, and change the code of classroom-`level UI components in the packages/agora-classroom-sdk/src/ui to apply the UI component that you add to Flexible Classroom. For details, see the [UI customization examples](#example).

3. The UI adjustments in Storybook are all based on mock data, which can help you quickly view the UI display based on component properties. If you need to adjust the UI for the real scene, it is recommended to adjust the UI through the Agora Classroom SDK development mode by referring to the following steps.

   1. Rename the env.example file in the home directory of the project and `in the `packages/Agora-classroom-sdk` folder` to `.env`, then` pass in your Agora App ID in `the .env` file, and set REACT_APP_AGORA_APP_SDK_DOMAIN` as `https://api-test. Agora/preview`.

   2. Run the following command in the root directory to launch a flexible classroom.

      ```shell
      yarn -v
      ```


<a name="example"></a>

## UI customization example

Here are a few examples of modifying     Flexible Classroom.

### Change the color of the navigation bar

The following example shows how to change the background color `of the navigation bar component BizHeader` from white to red by editing the agora-scenario-ui-kit/src/components/biz-header/index.css file.

#### Before

```css
.biz-header {
  @apply bg-white;
  padding: 0 15px 0 8px;
}
```

![biz-header-before](https://web-cdn.agora.io/docs-files/1617714984066)

#### After

```css
.biz-header {
  padding: 0 15px 0 8px;
  background: red;
}
```

![biz-header-after](https://web-cdn.agora.io/docs-files/1617715004882)

After the change, the background color of all the BizHeader components used in the Flexible Classroom becomes red.

![biz-header-after-fx](https://web-cdn.agora.io/docs-files/1617715029659)

### Modify the layout

The following example demonstrates how to move the video area and chat area on the right side of Smart Classroom to the left. This is a cross-component adjustment, so you need to modify the parent container of these two components, which is the one-to-one interactive teaching scene container `packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/1v1/index. tsx` file.

#### Before

```tsx
export const WhiteboardContainer = observer(() => {
  ...
  return (
    <Layout
      className={cls}
      direction = "col"
      style={{
        height: '100vh'
      }}
    >
      <NavigationBar />
      <Layout className="bg-white" style={{ height: '100%' }}>
        <Content>
          <ScreenSharePlayerContainer />
          <WhiteboardContainer />
        </Content>
        <Aside className={fullscreenCls}>
          <VideoList />
          <RoomChat />
        </Aside>
      </Layout>
      <DialogContainer />
      <LoadingContainer />
    </Layout>
  )
})
```

![](https://web-cdn.agora.io/docs-files/1620289086480)

#### After

```tsx
export const WhiteboardContainer = observer(() => {
  ...
  return (
    <Layout
      className={cls}
      direction = "col"
      style={{
        height: '100vh'
      }}
    >
      <NavigationBar />
      <Layout className="bg-white" style={{ height: '100%' }}>
        /** Adjust the order of Content and Aside in Layout. */
        <Aside className={fullscreenCls}>
          <VideoList />
          <RoomChat />
        </Aside>
        <Content>
          <ScreenSharePlayerContainer />
          <WhiteboardContainer />
        </Content>
      </Layout>
      <DialogContainer />
      <LoadingContainer />
    </Layout>
  )
})
```

![](https://web-cdn.agora.io/docs-files/1620289100529)

### Add a basic UI component

The following example shows how to add a custom basic UI component and use it in  Flexible Classroom:

1. Create a custom folder under the `packages/agora-classroom-sdk/src/ui-kit/components``` directory and create the following files:

   `index.css`

   ```css
   .custom {
  display: inline-block;
  padding: 10px;
  background: #efebe9;
  border: 5px solid #B4A078;
  outline: #B4A078 dashed 1px;
  outline-offset: -10px;
}
   ```

   `index.tsx`

   ```tsx
   import React, { FC } from 'react';
import classnames from 'classnames';
import { BaseProps } from '~components/interface/base-props';
import './index.css';

export interface CustomProps extends BaseProps {
    width?: number;
    height?: number;
    children?: React.ReactNode;
}

export const Custom: FC<CustomProps> = ({
    width = 90,
    height = 90,
    children,
    className,
    ...restProps
}) => {
    const cls = classnames({
        [`custom`]: 1,
        [`${className}`]: !!className,
    });
    return (
        <div
            className={cls}
            style={{
                width,
                height,
            }}
            {...restProps}
        >
            {children}
        </div>
    )
}
   ```

   `index.stories.tsx`

   ```tsx
   import React from 'react'
import { Meta } from '@storybook/react';
import { Custom } from '~components/custom'

const meta: Meta = {
    title: 'Components/Custom',
    component: Custom,
}

type DocsProps = {
    width: number;
    height: number;
}

export const Docs = ({width, height}: DocsProps) => (
    <>
        <div className="mt-4">
            <Custom
                width={width}
                height={height}
            >
                <h3>I am a custom component</h3>
            </Custom>
        </div>
    </>
)

Docs.args = {
    width: 250,
    height: 200,
}

export default meta;
   ```

   The Custom component is a div element with a two-layer border and renders a Children element. You can see the Custom component in Storybook.

   ![](https://web-cdn.agora.io/docs-files/1617715392109)

2. Add the following code to the `packages/agora-scenario-ui-kit/src/components/index.ts` file to export the Custom component.

   ```ts
   export * from './custom'
   ```

3. Apply the Custom component on the whiteboard of a one-to-one classroom, as follows:

   1. Introduce the Custom component in the `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx` file:

      ```ts
      import { Custom } from '~ui-kit'
      ```

   2. Use the Custom component in `WhiteboardContainer`:

      ```tsx
      export const WhiteboardContainer = observer(() => {
  return (
    <div className="whiteboard">
      ......
      {showZoomControl ? <ZoomController
      className='zoom-position'
      zoomValue={zoomValue}
      currentPage={currentPage}
      totalPage={totalPage}
      maximum={!isFullScreen}
      clickHandler={handleZoomControllerChange}
      /> : null}
      <Custom className='custom-position' width={200} height={200}>
        <div>Use Custom components</div>
      </Custom>
      </div>
  )
})
      ```

   3. Define the `custom-position style` in the packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/1v1/style.css file``:

      ```ts
      .custom-position{
  position: absolute;
  left: 100px;
  bottom: 200px;
}
      ```

   4. Run the  Flexible Classroom to view the specific effects of the Custom component.

      ![custom-ui-compnent-fx](https://web-cdn.agora.io/docs-files/1617715517511)

### Associate UI components with business state

In actual scenarios, you may need to modify the UI components related to the business state, or you may want to customize a UI component for a certain business function yourself.

The following example shows how to display class time in the custom component added above.

1. Modify the `index.tsx `file of the Custom component to enable the Custom component to support the display time attribute.

   ```tsx
   import React, { FC } from 'react';
import classnames from 'classnames';
import { BaseProps } from '~components/interface/base-props';
import './index.css';

/** Added time attribute. */
export interface CustomProps extends BaseProps {
    width?: number;
    height?: number;
    children?: React.ReactNode;
    width: number;
}

/** Add time rendering. */
export const Custom: FC<CustomProps> = ({
    width = 90,
    height = 90,
    children,
    className,
    time,
    ...restProps
}) => {
    const cls = classnames({
        [`custom`]: 1,
        [`${className}`]: !!className,
    })
    return (
        <div
            className={cls}
            style={{
                width,
                height,
            }}
            {...restProps}
        >
            {time}
            {children}
        </div>
    )
}
   ```

2. In `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx` file

   ```tsx
   ...
  return (
    <div className="whiteboard">
      {
        ready ?
        <div id="Netless" style={{position: 'absolute', top: 0, left: 0, height: '100%', width: '100%'}} ref={mountToDOM} ></div> : null
      }
      {showTab?
      <TabsContainer />: null}
      {showToolBar ?
        <Toolbar active={currentSelector} activeMap={activeMap} tools={tools} onClick={handleToolClick} className="toolbar-biz" />
      : null}
      {showZoomControl ? <ZoomController
        className='zoom-position'
        zoomValue={zoomValue}
        currentPage={currentPage}
        totalPage={totalPage}
        maximum={!isFullScreen}
        clickHandler={handleZoomControllerChange}
      /> : null}
      /** Added time attribute. */
      <Custom className='custom-position' width={200} height={200}>
        <div>Use Custom components</div>
      </Custom>
    </div>
  )
})
   ```

   After the modification, run  Flexible Classroom, and you can see that the time attribute is displayed on the Custom component.

   ![](https://web-cdn.agora.io/docs-files/1620289134349)

3. Next, we have to introduce real class time data. You can get the Context you need through Agora Edu Context in the high-level UI component through the hooks method. In this example, we use the liveClassStatus of the RoomContext in the Agora Edu Context[](https://docs.agora.io/cn/agora-class/edu_context_api_ref_wev_room?platform=Web#liveclassstatus) to get the class time. You can modify `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx` to get the class time and set it into the Custom component as a property.

   <div class="alter note">Agora does not recommend directly referencing Context in basic UI components, because basic UI components may be reused in different scenarios.</div>

   ```tsx
   ...
export const WhiteboardContainer = observer(() => {
  ...
  const {
    liveClassStatus
  } = useRoomContext()

    return (
    <div className="whiteboard">
      {
        ready ?
        <div id="Netless" style={{position: 'absolute', top: 0, left: 0, height: '100%', width: '100%'}} ref={mountToDOM} ></div> : null
      }
      {showTab?
      <TabsContainer />: null}
      {showToolBar ?
        <Toolbar active={currentSelector} activeMap={activeMap} tools={tools} onClick={handleToolClick} className="toolbar-biz" />
      : null}
      {showZoomControl ? <ZoomController
        className='zoom-position'
        zoomValue={zoomValue}
        currentPage={currentPage}
        totalPage={totalPage}
        maximum={!isFullScreen}
        clickHandler={handleZoomControllerChange}
      /> : null}
      <Custom time={liveClassStatus.duration} className='custom-position' width={200} height={200}>
        <div>Use Custom components</div>
      </Custom>
    </div>
  )
})
   ```

   Run  Flexible Classroom after the modification, and you can see that the class time will be automatically updated on the UI interface in milliseconds. We can then modify the `index.tsx `file of the Custom component, fine-tune the style of the Custom component, and then format the time.

   ```tsx
   ...
export const Custom: FC<CustomProps> = ({
    width = 90,
    height = 90,
    children,
    className,
    time,
    ...restProps
}) => {
    const cls = classnames({
        [`custom`]: 1,
        [`${className}`]: !!className,
    })
    return (
        <div
            className={cls}
            style={{
                width,
                height,
            }}
            {...restProps}
        >
            Class has started for {Math.floor(time/1000)} seconds
            {children}
        </div>
    )
}
   ```

   The final effect is as follows:

   ![](https://web-cdn.agora.io/docs-files/1620289155801)

### Change the global style of basic UI components

The following example shows how to modify the global style of basic UI components.

1. Define global styles` in the `packages/agora-classroom-sdk/src/ui-kit/styles/global.css file:

   ```css
   .fixed-container {
 display: flex;
 justify-content: center;
 align-items: center;
 flex: 1;
 "height": 360
 position: fixed;
 width: 480,
 z-index: 99;
}
   ```

2. Add the following code to the `.stories.tsx` and `.tsx` files of the basic UI components to apply this global style:

   ```ts
   export const DialogContainer: React.FC<any> = observer(() => {
  const { dialogQueue } = useDialogContext()
  return (
    <div>
     {
        dialogQueue.map(({ id, component: Component, props }: DialogType) => (
          <div key={id} className="fixed-container">
            <Component {...props} id={id} />
          </div>
       ))
     }
    </div>
 )
})
   ```
