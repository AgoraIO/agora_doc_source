This page introduces how to customize the UI of Flexible Classroom, such as colors, buttons, and layout.

## Working principles

The desktop client of Flexible Classroom uses the open-source tool [Storybook](https://storybook.js.org/docs/react/get-started/introduction) to develop and manage UI components. It derives the UI code from the business logic and provides the UIKit. With the UIKit, developers can customize the classroom UI without changing the business logic of Flexible Classroom.

![custom-ui-web](https://web-cdn.agora.io/docs-files/1617714946419)

You can find the source code of the UIKit in the `packages/agora-scenario-ui-kit/src` folder in the [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas%2F1.1.0) repository on GitHub (Branch dev/apaas/1.1.0). The project structure of the UIKit is as follows:

| Folder | Description |
| :----------- | :----------------------------------------------------------- |
| `components` | The source code of the basic UI components used by Flexible Classroom. A UI component generally contains the following files:<li>`.css`: Define the style of the component.</li><li>`.stories.tsx`: Define the display of components in Storybook.</li><li>`.tsx`: Define the detailed design of the component.</li> |
| `scaffold` | The classroom-level UI components, which play as scaffolds and show how the basic UI components are combined in a classroom. |
| `styles` | Define the global style. |
| `utilities` | For functions such as internationalization, and custom hooks. |

## Implementation

### Development environment

- Install [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

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

### Procedure

Modify the UI of Flexible Classroom, as follows:

1. Enter the root directory of the CloudClass-Desktop project and run the following command to install dependencies.

   ```shell
   # Install global dev dependencies
yarn
# Install all dependencies via lerna and yarn
yarn bootstrap
   ```

2. Enter the `packages/agora-scenario-ui-kit` directory and run the following command to open Storybook.

   ```shell
   # Open storybook
yarn s
   ```

   You can see all the basic UI components used by Flexible Classroom in Storybook.

   ![storybook-example](https://web-cdn.agora.io/docs-files/1617714921810)

3. You can directly edit the source code of a component in the `packages/agora-scenario-ui-kit/src/components` folder to modify the UI of this component. After saving the code, you can see the changed UI in Storybook. If the existing basic UI components of Flexible Classroom cannot meet your needs, you can add a new UI component in the `packages/agora-scenario-ui-kit/src/components` directory, and change the code of classroom-level UI components in the `packages/agora-classroom-sdk/src/ui` to apply the UI component that you add to Flexible Classroom. For details, see the [UI customization examples](#example).

4. View the modified UI in Flexible Classroom, as follows:

   1. Rename the `env.example` file in the root directory of the project and in the `packages/Agora-classroom-sdk` folder to `.env`, then pass in your Agora App ID in the `.env` file, and set `REACT_APP_AGORA_APP_SDK_DOMAIN` as `https://api-test. Agora/preview`.

   2. Run the following command in the root directory to launch a flexible classroom.

      ```shell
      npm run dev
      ```

      Or run the following command:

      ```shell
      yarn run dev
      ```

<a name="example"></a>
## UI customization example

### Change the color of the navigation bar

The following example shows how to change the background color of the navigation bar component BizHeader from white to red by editing the `agora-scenario-ui-kit/src/components/biz-header/index.css` file.

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

### Change the style of the zoom controller

The following example shows how toadd the text "Add" to the ZoomController component by editing the `agora-scenario-ui-kit/src/components/zoom-controller/index.tsx` file.

#### Before

```ts
export const ZoomController: FC<ZoomControllerProps> = ({

    return (
    <div className={cls} {...restProps}>

            ......

            <span className="line"></span>
      <Tooltip title={t('tool.prev')} placement="top">
        <Icon
          type="backward"
          size={fontSize}
          color={fontColor}
          onClick={() => clickHandler('backward')}
        />
      </Tooltip>
      <span className="page-info">
        {currentPage}/{totalPage}
      </span>
      <Tooltip title={t('tool.next')} placement="top">
        <Icon
          type="forward"
          size={fontSize}
          color={fontColor}
          onClick={() => clickHandler('forward')}
        />
      </Tooltip>
    </div>
};
```

#### After

```ts
export const ZoomController: FC<ZoomControllerProps> = ({

    return (
    <div className={cls} {...restProps}>

            ......

            <span className="line"></span>
      <Tooltip title={t('tool.prev')} placement="top">
        <Icon
          type="backward"
          size={fontSize}
          color={fontColor}
          onClick={() => clickHandler('backward')}
        />
      </Tooltip>
      <span className="page-info">
        {currentPage}/{totalPage}
      </span>
      <Tooltip title={t('tool.next')} placement="top">
        <Icon
          type="forward"
          size={fontSize}
          color={fontColor}
          onClick={() => clickHandler('forward')}
        />
      </Tooltip>
      <div>Add</div>
    </div>
};
```

![zoom-controller-after](https://web-cdn.agora.io/docs-files/1617715061445)

After the change, the "Add" text will be added to the ZoomController component in the lower left corner of Flexible Classroom.

![zoom-controller-after-fx](https://web-cdn.agora.io/docs-files/1617715077329)

### Change the global style of basic UI components

The following example shows how to modify the global style of basic UI components.

1. Define the global style in the `agora-scenario-ui-kit/src/styles/global.css` file:

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

### Add a basic UI component

The following example shows how to add a customized basic UI component and use it in  Flexible Classroom:

1. Create a `custom` folder under the `agora-scenario-ui-kit/src/components` directory and create the following files:

   `The index.css` file

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

   `The index.tsx` file

   ```ts
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

   `The index.stories.tsx` file

   ```ts
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
                <h3>I am a custom component!</h3>
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

   1. Import the Custom component in the `agora-classroom-sdk/src/ui-components/common-containers/board.tsx` file:

      ```ts
      import { Custom } from 'agora-scenario-ui-kit'
      ```

   2. Use the Custom component in `WhiteboardContainer`:

      ```ts
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
        <div>Use the custom component!</div>
      </Custom>
    </div>
  )
})
      ```

   3. Define the style of `custom-position` in the `agora-classroom-sdk/src/ui-components/one-to-one/1v1.style.css` file:

      ```ts
      .custom-position{
  position: absolute;
  left: 100px;
  bottom: 200px;
}
      ```

   4. Run the  Flexible Classroom to view the specific effects of the Custom component.

      ![custom-ui-compnent-fx](https://web-cdn.agora.io/docs-files/1617715517511)