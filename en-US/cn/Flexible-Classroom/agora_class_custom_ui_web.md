## Overview

Agora provides the complete Agora Classroom SDK on [npm](https://www.npmjs.com/package/agora-classroom-sdk). However, if you want to customize the user interfaces of classrooms, Agora provides the source code of the Agora Classroom SDK for you to further develop, debug, and compile. The source code of the Agora Classroom SDK for Desktop is in the [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/master) repository on GitHub (branch release/apaas/1.1.0). The Agora Classroom SDK separates the code of the user interfaces from the code of core business logic and provides two libraries, UIKit and EduCore. These two libraries connect with each other through [Agora Edu Context](https://docs.agora.io/cn/agora-class/edu_context_api_ref_web_overview?platform=Web). For example, for the chat module in the  Flexible Classroom, a user needs to click on a button to send a message, and they also receive messages sent by other users. In this case, in UIKit, we can call a method in the Chat Context to send a message and listen for the events in the Chat Context to receive messages.

![](https://web-cdn.agora.io/docs-files/1619696813295)

UIKit provides all the code for the user interfaces in Flexible Classroom and uses the open-source tool [Storybook](https://storybook.js.org/docs/react/get-started/introduction) to develop and manage all UI components. You can find the source code of the UIKit in the `packages/agora-classroom-sdk/src/ui-kit` folder in the CloudClass-Desktop repository on GitHub (Branch release/apaas/1.1.0). The project structure of UIKit is as follows:

| Folder | Description |
| :------------- | :----------------------------------------------------------- |
| `components` | The source code of the basic UI components used by Flexible Classroom. A UI component generally contains the following files:<li>`.css`: Define the style of the component.</li><li>`.stories.tsx`: Define the display of components in Storybook.</li><li>`.tsx`: Define the detailed design of the component.</li> |
| `capabilities` | <li>`containers`: The source code of function-level UI components used by Flexible Classroom.</li><li>`scenarios`: The source code of the classroom-level UI components used by Flexible Classroom.</li> |
| `scaffold` | Scaffolds and show how the basic UI components are combined in a classroom. |
| `styles` | Define the global style. |
| `utilities` | For functions such as internationalization, and custom hooks. |

## Implementation

### Set up development environment

- Install [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

   ```shell
   # Install Node.js and npm globally
   npm install -g npm
   ```
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

### Procedure

Modify the UI of Flexible Classroom, as follows:

1. Navigate to the root directory of the CloudClass-Desktop project, check out the release/apaas/1.1.0 branch, and then run the following command to install the dependencies.

   ```shell
   # Install global dev dependencies
   yarn
   ```
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

   You can directly edit the source code of a component in the `packages/agora-classroom-sdk/src/ui-kit/components` folder and see the changed UI in Storybook. If the existing basic UI components of Flexible Classroom cannot meet your needs, you can add a new UI component in the `packages/agora-classroom-sdk/src/ui-kit/components` directory, and then edit the code of classroom-level UI components in the `packages/agora-classroom-sdk/src/ui-kit/capabilities` to apply the UI component that you add to Flexible Classroom. For details, see the [UI customization examples](#example).

3. The user interfaces in Storybook are all based on Mock data, which can help you quickly view the UI display based on component properties. If you need to adjust the UI for the real scene, it is recommended to adjust the UI through the Agora Classroom SDK development mode by referring to the following steps.

   1. Rename the env.example file in the home directory of the project and `in the `packages/Agora-classroom-sdk` folder` to `.env`, then` pass in your Agora App ID in `the .env` file, and set REACT_APP_AGORA_APP_SDK_DOMAIN` as `https://api-test. Agora/preview`.

   2. Run the following command in the root directory to launch a flexible classroom.

      ```shell
      yarn -v
      ```


<a name="example"></a>

## UI customization example

This section provides examples of customizing the user interfaces of Flexible Classroom.

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

### Change the classroom layout

The following example demonstrates how to switch the video and chat area in the Flexible Classroom. This adjustment involves multiple components. Therefore, you need to modify the parent container of these two components, which is the `packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/1v1/index.tsx` file.

#### Before

```tsx
export const OneToOneScenario = observer(() => {
  ...
  return (
    <Layout
      className={cls}
      direction="col"
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
export const OneToOneScenario = observer(() => {
  ...
  return (
    <Layout
      className={cls}
      direction="col"
      style={{
        height: '100vh'
      }}
    >
      <NavigationBar />
      <Layout className="bg-white" style={{ height: '100%' }}>
        /** Change the order of Content and Aside in Layout. */
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

The following example shows how to add a custom basic UI component and use it in the Flexible Classroom:

1. Create a `custom` folder under the `packages/agora-classroom-sdk/src/ui-kit/components` directory and create the following files:

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
   ```

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
                <h3>我是自定义组件</h3>
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

   The Custom component is a div element with a two-layer border and renders a Children element. You can see the custom component in Storybook.

   ![](https://web-cdn.agora.io/docs-files/1617715392109)

2. Add the following code to `packages/agora-scenario-ui-kit/src/components/index.ts` to export the Custom component.

   ```ts
   export * from './custom'
   ```

3. Apply the custom component on the whiteboard of a one-to-one classroom, as follows:

   1. Import the custom component in `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx`:

      ```ts
      import { Custom } from '~ui-kit'
      ```

   2. Use the custom component in `WhiteboardContainer`:

      ```tsx
      export const WhiteboardContainer = observer(() => {
      return (
     ```
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
        <div>Use the custom component</div>
      </Custom>
     </div>
  )
   })
   ```
   
3. Define the `custom-position` style in `packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/1v1/style.css`:
   
      ```ts
     .custom-position{
    position: absolute;
    left: 100px;
  bottom: 200px;
   }
   ```
   
4. Check the custom component in the flexible classroom.
   
      ![custom-ui-compnent-fx](https://web-cdn.agora.io/docs-files/1617715517511)

### Connect UI components with the business logic

Sometimes you need to modify the UI components related to the business state, or you may want to customize a UI component for a specific function.

The following example shows how to display class time in the custom component we added in the previous section.

1. Modify the `index.tsx` file of the custom component to ensure the custom component supports displaying time.

   ```tsx
   import React, { FC } from 'react';
   import classnames from 'classnames';
   import { BaseProps } from '~components/interface/base-props';
   import './index.css';
   /** Add an attribute named time. */
   export interface CustomProps extends BaseProps {
       width?: number;
       height?: number;
       children?: React.ReactNode;
       time: number;
   }
   
   /** Render time. */
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


   ```

2. In `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx`

   ```tsx
   ...
  return (
    <div className="whiteboard">
      {
        ready ?
        <div id="netless" style={{position: 'absolute', top: 0, left: 0, height: '100%', width: '100%'}} ref={mountToDOM} ></div> : null
      }
      {showTab ?
      <TabsContainer /> : null}
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
      /** Add an attribute named time. */
      <Custom time={5000} className='custom-position' width={200} height={200}>
        <div>Use the custom component</div>
      </Custom>
    </div>
  )
})
   ```

   After the modification, run the project, and you can see that the time attribute is displayed on the custom component.

   ![](https://web-cdn.agora.io/docs-files/1620289134349)

3. Next, we have to import real class time data. Get the Context you need through Agora Edu Context in the function-level UI component through hooks. In this example, we use the [liveClassStatus](https://docs.agora.io/cn/agora-class/edu_context_api_ref_wev_room?platform=Web#liveclassstatus) property of the RoomContext in the Agora Edu Context to get the class time. Edit `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx` to get the class time and set it as a property in the custom component .

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
        <div id="netless" style={{position: 'absolute', top: 0, left: 0, height: '100%', width: '100%'}} ref={mountToDOM} ></div> : null
      }
      {showTab ?
      <TabsContainer /> : null}
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
        <div>Use the custom component</div>
      </Custom>
    </div>
    )
})
   ```

   Run the project after the modification, and you can see that the class time is automatically updated on the user interface in milliseconds. We can then modify the `index.tsx` file of the custom component, fine-tune the style of the custom component, and then format the time.

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
            The class has lasted for {Math.floor(time/1000)} seconds
            {children}
        </div>
    )
}
   ```

   The final user interface is as follows:

   ![](https://web-cdn.agora.io/docs-files/1620289155801)

### Change the global style of basic UI components

The following example shows how to modify the global style of basic UI components.

1. Define global styles in `packages/agora-classroom-sdk/src/ui-kit/styles/global.css`:

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
