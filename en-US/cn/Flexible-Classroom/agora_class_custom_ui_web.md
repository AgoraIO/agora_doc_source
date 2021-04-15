This page introduces how to customize the UI of Flexible Classroom, such as colors, buttons, and layout.

## Working principles

The desktop client of Flexible Classroom uses the open-source tool [Storybook](https://storybook.js.org/docs/react/get-started/introduction) to develop and manage UI components. It derives the UI code from the business logic and provides the UIKit. With the UIKit, developers can customize the classroom UI without changing the business logic of Flexible Classroom.

![custom-ui-web](https://web-cdn.agora.io/docs-files/1617714946419)

You can find the source code of the UIKit in the `packages/agora-scenario-ui-kit/src` folder in the [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas%2F1.1.0) repository on GitHub (Branch dev/apaas/1.1.0). The project structure of the UIKit is as follows:

| Folder | Description |
| :----------- | :----------------------------------------------------------- |
| `components` | The source code of the basic UI components used by Flexible Classroom. A UI component generally contains the following files:<li>`.css`: Define the style of the component.</li><li>`.stories.tsx`: Define the display of components in Storybook.</li><li>`.tsx`: Define the detailed design of the component.</li> |
| `scaffold` | The use-case-level UI components, which play as scaffolds and show how the basic UI components are combined in a use case. |
| `styles` | Define the global style. |
| `utilities` | Utility functions, such as internationalization, custom hooks, etc. |

## Implementation

### Environmental preparation

- Install[ Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

   ```shell
   # Install global dev dependencies
yarn
# Install all dependencies via lerna and yarn
yarn bootstrap
   ```

- Install yarn

   ```shell
   # Open storybook
yarn s
   ```

### The basic steps

Refer to the following steps to modify the UI of  Flexible Classroom:

1. Go to the root directory of the CloudClass-Desktop project and run the following command to install dependencies.

   ```shell
   # Install global dev dependencies
yarn
# Install all dependencies via lerna and yarn
yarn bootstrap
   ```

2. Go to the `packages/agora-scenario-ui-kit` directory and run the following command to open Storybook.

   ```shell
   # Open storybook
yarn s
   ```

   You can see all the basic UI components used   Flexible Classroom in Storybook.

   ![storybook-example](https://web-cdn.agora.io/docs-files/1617714921810)

3. You can modify the style by directly modifying the` component source files in the packages/agora-scenario-ui-kit/src/components` directory, and you can see the effect in real-time in Storybook after saving the code. If the basic UI components of Flexible Classroom Class cannot meet your needs, you can add UI components to the `packages/agora-scenario-ui-kit/src/components` directory by yourself, and then add them to `packages/agora-classroom-sdk/src/ui` Modify the combination rules of the basic UI components under the -components directory to adjust the smart classroom layout. See the modified example for details[](#example).

4. Refer to the following steps to view the revised UI in  Flexible Classroom:

   1. Rename the project home directory and env.example in` the `packages/Agora-classroom-sdk` directory` to `.env`, then` fill in your Agora App ID` in the .env` file, and set REACT_APP_AGORA_APP_SDK_DOMAIN` to `https://api-test. Agora/preview`.

   2. Go to the project directory, and run the following command to build the project:

      ```shell
      npm run dev
      ```

      Or through the following command:

      ```shell
      yarn run dev
      ```

<a name="example"></a>
## Example

### Modify the color of the navigation bar

The following example demonstrates how to modify the background color of the` navigation bar component BizHeader from white to red by modifying the agora-scenario-ui-kit/src/components/biz-header/index.css` file.

#### before fixing

```css
.biz-header {
  @apply bg-white;
  padding: 0 15px 0 8px;
}
```

![biz-header-before](https://web-cdn.agora.io/docs-files/1617714984066)

#### After modification

```css
.biz-header {
  padding: 0 15px 0 8px;
  background: red;
}
```

![biz-header-after](https://web-cdn.agora.io/docs-files/1617715004882)

After the modification, the background color of all the places where the BizHeader component is used in the Smart Classroom will become red.

![biz-header-after-fx](https://web-cdn.agora.io/docs-files/1617715029659)

### Modify the zoom controller style

The following example demonstrates how to `add "Add"` text to the zoom controller component ZoomController by modifying the agora-scenario-ui-kit/src/components/zoom-controller/index.tsx file.

#### before fixing

```ts
export const ZoomController: FC<ZoomControllerProps> = ({

                            return;
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
        {currentPage} / {totalPage}
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

#### After modification

```ts
export const ZoomController: FC<ZoomControllerProps> = ({

                            return;
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
        {currentPage} / {totalPage}
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

After modification, the "Add" text will be added to the ZoomController component in the lower left corner of the Smart Classroom.

![zoom-controller-after-fx](https://web-cdn.agora.io/docs-files/1617715077329)

### Modify the global style of basic UI components

The following example demonstrates how to modify the global style of basic UI components.

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

2. Add the following code to the `.stories.tsx` and `.tsx` files of the basic UI components to use this global style:

   ```ts
   export const DialogContainer: React.FC<any> = observer(() => {
  const { dialogQueue } = useDialogContext()
                          return;
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

### Add basic UI components

The following example demonstrates how to customize a basic UI component and use it in  Flexible Classroom:

1. Create a custom folder under the `agora-scenario-ui-kit/src/components``` directory and create the following files:

   `index.css` file

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

   `index.tsx` file

   ```ts
   import React, { FC } from 'react';
import classnames from 'classnames';
import { BaseProps } from '~components/interface/base-props';
import './index.css';

export interface CustomProps extends BaseProps {
    width: Number type field.
    height: Number type field.
    children?: React.ReactNode;
}

export const Custom: FC<CustomProps> = ({
    width: 480,
    "height": 750,
    children,
    className,
    ... restProps
}) => {
    const cls = classnames({
        [`custom`]: 1,
        [`${className}`]: !!className,
    });
                          return;
        <div
            className={cls}
            style={{
                width
                height
            }}
            {... restProps}
        >
            {children}
        </div>
    )
}
   ```

   `index.stories.tsx` file

   ```ts
   import React from 'react'
import { Meta } from '@storybook/react';
import { Custom } from '~components/custom'

const meta: Meta = {
    title: 'Components/Custom',
    component: Custom,
}

type DocsProps = {
    width: Number type field.
    height: Number type field.
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
    width: 480,
    "height": 360
}

export default meta;
   ```

   The Custom component is a div with a two-layer border and the Children element is rendered internally. You can see the specific effects of the Custom component in Storybook.

   ![](https://web-cdn.agora.io/docs-files/1617715392109)

2. Add the following code to the `packages/agora-scenario-ui-kit/src/components/index.ts` file to export the Custom component.

   ```ts
   export * from './custom'
   ```

3. Refer to the following steps to use the Custom component in the whiteboard area of the 1:1 interactive scene:

   1. Introduce the Custom component in the `agora-classroom-sdk/src/ui-components/common-containers/board.tsx` file:

      ```ts
      import { Custom } from 'agora-scenario-ui-kit'
      ```

   2. Use the Custom component in `WhiteboardContainer`:

      ```ts
      export const WhiteboardContainer = observer(() => {

                            return;
    <div className="whiteboard">


    ......

      {showZoomControl ? <ZoomController
        className='zoom-position'
        zoomValue={zoomValue}
        currentPage={currentPage}
        totalPage = {totalPage}
        maximum={!isFullScreen}
        clickHandler={handleZoomControllerChange}
      The default value is NULL.

      <Custom className='custom-position' width={200} height={200}>
        <div>Use the custom component!</div>
      </Custom>
    </div>
  )
})
      ```

   3. Define the `custom-position style` in the agora-classroom-sdk/src/ui-components/one-to-one/1v1.style.css file``:

      ```ts
      .custom-position{
  position: absolute;
  left: 100px;
  bottom: 200px;
}
      ```

   4. Run the  Flexible Classroom to view the specific effects of the Custom component.

      ![custom-ui-compnent-fx](https://web-cdn.agora.io/docs-files/1617715517511)