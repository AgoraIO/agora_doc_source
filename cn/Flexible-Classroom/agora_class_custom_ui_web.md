本页介绍如何自定义修改灵动课堂的 UI，如颜色、按钮、布局等。

## 工作原理

灵动课堂桌面端引入了开源工具 [Storybook](https://storybook.js.org/docs/react/get-started/introduction) 来开发和管理 UI 组件，将灵动课堂的 UI 代码和业务逻辑隔离开来，独立成 UIKit 以便于开发者自定义修改课堂 UI。

![custom-ui-web](https://web-cdn.agora.io/docs-files/1617714946419)

UIKit 的源码位于 GitHub 上 [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/dev/apaas%2F1.1.0) 仓库（dev/apaas/1.1.0 分支）中 `packages/agora-scenario-ui-kit/src` 目录下，结构介绍如下：

| 文件夹       | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| `components` | 灵动课堂使用的基础 UI 组件的源码。一个 UI 组件一般包含以下文件：<li>`.css`: 定义组件的样式。</li><li>`.stories.tsx`: 定义组件在 Storybook 中的展示。</li><li>`.tsx`: 定义组件的具体设计。</li> |
| `scaffold`   | 场景 UI 组件，可作为脚手架查看基础 UI 组件在各教学场景中的组装效果。 |
| `styles`     | 定义全局样式。                                               |
| `utilities`  | 工具函数，如国际化、自定义 hooks 等。                        |

## 实现方法

### 环境准备

- 安装 [Node.js 和 npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

  ```shell
  # Install Node.js and npm globally
  npm install -g npm
  # Check Node.js version
  node -v
  # Check npm version
  npm -v
  ```

- 安装 yarn

  ```shell
  # Install yarn
  npm install yarn -g
  # Check yarn version
  yarn -v
  ```

### 基本步骤

参考以下步骤修改灵动课堂的 UI：

1. 进入 CloudClass-Desktop 项目根目录，运行以下命令安装依赖。

   ```shell
   # Install global dev dependencies
   yarn
   # Install all dependencies via lerna and yarn
   yarn bootstrap
   ```

2. 进入 `packages/agora-scenario-ui-kit` 目录，运行以下命令打开 Storybook。

   ```shell
   # Open storybook
   yarn s
   ```

   你可以在 Storybook 中看到灵动课堂使用的所有基础 UI 组件。

   ![storybook-example](https://web-cdn.agora.io/docs-files/1617714921810)

3. 你可以通过直接修改 `packages/agora-scenario-ui-kit/src/components` 目录下组件的源码文件来修改样式，保存代码后即可在 Storybook 中实时看到效果。如果灵动课堂的基础 UI 组件无法满足你的需求，你可以自行在 `packages/agora-scenario-ui-kit/src/components` 目录下新增 UI 组件，然后在 `packages/agora-classroom-sdk/src/ui-components` 目录下修改基础 UI 组件的组合规则调整灵动课堂布局。详见[修改示例](#example)。

4. 参考以下步骤在灵动课堂中查看修改后的 UI：

   1. 把项目主目录和 `packages/agora-classroom-sdk` 目录下的 `env.example` 重命名为 `.env`，然后在 `.env` 文件中填写你的 Agora App ID，并将 `REACT_APP_AGORA_APP_SDK_DOMAIN` 设为 `https://api-test.agora.io/preview`。

   2. 在项目主目录下通过以下命令运行灵动课堂。

      ```shell
      npm run dev
      ```

      或者通过以下命令：

      ```shell
      yarn run dev
      ```

<a name="example"></a>
## 修改示例

### 修改导航栏颜色

以下示例演示了如何通过修改 `agora-scenario-ui-kit/src/components/biz-header/index.css` 文件将导航栏组件 BizHeader 的背景颜色从白色修改为红色。

#### 修改前

```css
.biz-header {
  @apply bg-white;
  padding: 0 15px 0 8px;
}
```

![biz-header-before](https://web-cdn.agora.io/docs-files/1617714984066)

#### 修改后

```css
.biz-header {
  padding: 0 15px 0 8px;
  background: red;
}
```

![biz-header-after](https://web-cdn.agora.io/docs-files/1617715004882)

修改后，灵动课堂中所有使用 BizHeader 组件的地方的背景色均会变成红色。

![biz-header-after-fx](https://web-cdn.agora.io/docs-files/1617715029659)

### 修改缩放控制器样式

以下示例演示了如何通过修改 `agora-scenario-ui-kit/src/components/zoom-controller/index.tsx` 文件在缩放控制器组件 ZoomController 的中增加 "Add" 文字。

#### 修改前

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

#### 修改后

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

修改后，灵动课堂中左下角的 ZoomController 组件会增加 "Add" 文字。

![zoom-controller-after-fx](https://web-cdn.agora.io/docs-files/1617715077329)

### 修改基础 UI 组件的全局样式

以下示例演示了如何通过修改基础 UI 组件的全局样式。

1. 在 `agora-scenario-ui-kit/src/styles/global.css` 文件中定义全局样式：

   ```css
   .fixed-container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex: 1;
    height: 100%;
    position: fixed;
    width: 100%;
    z-index: 99;
   }
   ```

2. 在基础 UI 组件的 `.stories.tsx` 和 `.tsx` 文件中添加以下代码来使用该全局样式：

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

### 新增基础 UI 组件

以下示例演示了如何自定义一个基础 UI 组件并在灵动课堂的 1 对 1 互动教学场景中使用：

1. 在 `agora-scenario-ui-kit/src/components` 目录下创建 `custom` 文件夹并新建以下文件：

   `index.css` 文件

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

   `index.tsx` 文件

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

   `index.stories.tsx` 文件

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

   Custom 组件是一个带有两层边框的 div，同时内部渲染出 Children 元素。你可以在 Storybook 中看到 Custom 组件的具体效果。

   ![](https://web-cdn.agora.io/docs-files/1617715392109)

2. 在 `packages/agora-scenario-ui-kit/src/components/index.ts` 文件中添加以下代码，导出 Custom 组件。

   ```ts
   export * from './custom'
   ```

3. 参考以下步骤，在 1 对 1 互动场景的白板区域中使用 Custom 组件：

   1. 在 `agora-classroom-sdk/src/ui-components/common-containers/board.tsx` 文件中引入 Custom 组件：

      ```ts
      import { Custom } from 'agora-scenario-ui-kit'
      ```

   2. 在 `WhiteboardContainer` 中使用 Custom 组件：

      ```ts
      export const WhiteboardContainer = observer(() => {

        return (
          <div className="whiteboard">
      ```


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

   3. 在 `agora-classroom-sdk/src/ui-components/one-to-one/1v1.style.css` 文件中定义 `custom-position` 的样式：

      ```ts
      .custom-position{
        position: absolute;
        left: 100px;
        bottom: 200px;
      }
      ```

   4. 运行灵动课堂，查看 Custom 组件的具体效果。

      ![custom-ui-compnent-fx](https://web-cdn.agora.io/docs-files/1617715517511)