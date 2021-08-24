## 概述

Agora 在 npm 上提供完整的 [Agora Classroom SDK](https://www.npmjs.com/package/agora-classroom-sdk) 供你集成。但是，如果 Agora Classroom SDK 中默认的 UI 无法满足你的需求，你也可以获取 Agora Classroom SDK 的源码，自行开发、调试和编译。Agora Classroom SDK for Desktop 的源码位于 GitHub 上 [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/master) 仓库（release/apaas/1.1.0 分支）。在 Agora Classroom SDK 中，灵动课堂的 UI 代码和核心业务逻辑相隔离，独立成 UIKit 和 EduCore 两个库，两者通过 [Agora Edu Context](https://docs.agora.io/cn/agora-class/edu_context_api_ref_web_overview?platform=Web) 产生关联。举例来说，对于灵动课堂中的文字聊天功能，需要通过一个按钮发送消息，同时需要接收其他用户发送的消息。这种情况下，我们在 UIKit 中可以调用 Chat Context 中的发送消息方法，并监听 Chat Context 中消息接收相关事件。

![](https://web-cdn.agora.io/docs-files/1619696813295)

UIKit 中提供灵动课堂的 UI 组件代码，并引入开源工具 [Storybook](https://storybook.js.org/docs/react/get-started/introduction) 来开发和管理 UI 组件。UIKit 的源码位于 GitHub 上 CloudClass-Desktop 仓库（release/apaas/1.1.0 分支）中 `packages/agora-classroom-sdk/src/ui-kit` 目录下，项目结构介绍如下：

| 文件夹         | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| `components`   | 灵动课堂使用的基础 UI 组件的源码。一个 UI 组件一般包含以下文件：<li>`.css`: 定义组件的样式。</li><li>`.stories.tsx`: 定义组件在 Storybook 中的展示。</li><li>`.tsx`: 定义组件的具体设计。</li> |
| `capabilities` | <li>`containers`: 灵动课堂使用的高阶 UI 组件的源码。</li><li>`scenarios`: 灵动课堂使用的场景 UI 组件的源码。</li> |
| `scaffold`     | 场景 UI 组件，可作为脚手架查看基础 UI 组件在各教学场景中的组装效果。 |
| `styles`       | 定义全局样式。                                               |
| `utilities`    | 工具函数，如国际化、自定义 hooks 等。                        |

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

### 操作步骤

参考以下步骤修改灵动课堂的 UI：

1. 进入 CloudClass-Desktop 项目根目录，检出 release/apaas/1.1.0 分支，然后运行以下命令安装依赖。

   ```shell
   # Install global dev dependencies
   yarn
   # Install all dependencies via lerna and yarn
   yarn bootstrap
   ```

2. 运行以下命令打开 Storybook 进行快速调整 UI。

   ```shell
   # Open storybook
   yarn dev:ui-kit
   ```

   你可以在 Storybook 中看到灵动课堂使用的所有基础 UI 组件。

   ![storybook-example](https://web-cdn.agora.io/docs-files/1617714921810)

   你可以通过直接修改 `packages/agora-classroom-sdk/src/ui-kit/components` 目录下基础 UI 组件的源码文件来修改样式，保存代码后即可在 Storybook 中实时看到效果。如果灵动课堂的基础 UI 组件无法满足你的需求，你可以自行在 `packages/agora-classroom-sdk/src/ui-kit/components` 目录下新增基础 UI 组件，然后在 `packages/agora-classroom-sdk/src/ui-kit/capabilities` 目录下修改基础 UI 组件的组合规则调整灵动课堂布局。详见[修改示例](#example)。

3. Storybook 中的 UI 调整均基于 Mock 数据，能够帮助你根据组件属性快速查看 UI 展示。如果需要针对真实场景调整 UI，建议参考以下步骤通过 Agora Classroom SDK 开发模式调整 UI。

   1. 把项目根目录和 `packages/agora-classroom-sdk` 目录下的 `env.example` 重命名为 `.env`，然后在 `.env` 文件中填写你的 Agora App ID，并将 `REACT_APP_AGORA_APP_SDK_DOMAIN` 设为 `https://api-test.agora.io/preview`。

   2. 在项目主目录下通过以下命令以开发模式运行灵动课堂。

      ```shell
      yarn dev
      ```


<a name="example"></a>

## 修改示例

以下提供几个修改灵动课堂 UI 的示例。

### 修改导航栏颜色

以下示例演示了如何通过修改 `packages/agora-classroom-sdk/src/ui-kit/components/biz-header/index.css` 文件将导航栏组件 BizHeader 的背景颜色从白色修改为红色。

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

### 修改布局

以下示例演示了如何将灵动课堂右侧的视频区域和聊天区域移动到左侧。这是一个跨组件的调整，因此需要修改这两个组件的父容器，也就是一对一互动教学场景容器 `packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/1v1/index.tsx` 文件。

#### 修改前

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

#### 修改后

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
        /** 调整 Layout 中 Content 与 Aside 的顺序。*/
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

### 新增基础 UI 组件

以下示例演示了如何自定义一个基础 UI 组件并在灵动课堂的 1 对 1 互动教学场景中使用：

1. 在 `packages/agora-classroom-sdk/src/ui-kit/components` 目录下创建 `custom` 文件夹并新建以下文件：

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

   `index.stories.tsx` 文件

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

   Custom 组件是一个带有两层边框的 div，同时内部渲染出 Children 元素。你可以在 Storybook 中看到 Custom 组件的具体效果。

   ![](https://web-cdn.agora.io/docs-files/1617715392109)

2. 在 `packages/agora-classroom-sdk/src/ui-kit/components/index.ts` 文件中添加以下代码，导出 Custom 组件。

   ```ts
   export * from './custom'
   ```

3. 参考以下步骤，在 1 对 1 互动场景的白板区域中使用 Custom 组件：

   1. 在 `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx` 文件中引入 Custom 组件：

      ```ts
      import { Custom } from '~ui-kit'
      ```

   2. 在 `WhiteboardContainer` 中使用 Custom 组件：

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
              <div>使用Custom组件</div>
            </Custom>
            </div>
        )
      })
      ```

   3. 在 `packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/1v1/style.css` 文件中定义 `custom-position` 的样式：

      ```ts
      .custom-position{
        position: absolute;
        left: 100px;
        bottom: 200px;
      }
      ```

   4. 运行灵动课堂，查看 Custom 组件的具体效果。

      ![custom-ui-compnent-fx](https://web-cdn.agora.io/docs-files/1617715517511)

### 将 UI 组件与业务状态关联起来

在实际场景中，你可能需要修改与业务状态相关的 UI 组件，或者想要自己为某个业务功能定制一个 UI 组件。

以下示例展示了如何将课堂时间显示在上文新增的 Custom 组件中。

1. 修改 Custom 组件的 `index.tsx` 文件，使 Custom 组件支持显示时间的属性。

   ```tsx
   import React, { FC } from 'react';
   import classnames from 'classnames';
   import { BaseProps } from '~components/interface/base-props';
   import './index.css';
   
   /** 新增 time 属性。*/
   export interface CustomProps extends BaseProps {
       width?: number;
       height?: number;
       children?: React.ReactNode;
       time: number;
   }
   
   /** 添加 time 的渲染。*/
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

2. 在 `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx` 文件中

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
         /** 新增 time 属性。*/
         <Custom time={5000} className='custom-position' width={200} height={200}>
           <div>使用Custom组件</div>
         </Custom>
       </div>
     )
   })
   ```

   修改完后运行灵动课堂，可以看到时间属性被显示在了 Custom 组件上。
	
	 ![](https://web-cdn.agora.io/docs-files/1620289134349)

3. 接下来，我们要引入真实的课堂时间数据。你可以在 UI 高阶组件中通过 hooks 方法通过 Agora Edu Context 获取你需要的 Context。在这个示例中，我们通过 Agora Edu Context 中的 RoomContext 的 [liveClassStatus](https://docs.agora.io/cn/agora-class/edu_context_api_ref_wev_room?platform=Web#liveclassstatus) 来获取课堂时间。你可以修改 `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.tsx`，获取课堂时间并作为属性设入Custom 组件。

   <div class="alter note">Agora 不建议直接在基础 UI 组件中引用 Context，因为基础 UI 组件可能在不同场景下被复用。</div>

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
           <div>使用Custom组件</div>
         </Custom>
       </div>
     )
   })
   ```

   修改完后运行灵动课堂，可以看到课堂时间会以毫秒的形式自动在 UI 界面上更新。我们可以再修改 Custom 组件的 `index.tsx` 文件，微调 Custom 组件的样式再对时间进行格式化。

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
               已开始上课{Math.floor(time/1000)}秒
               {children}
           </div>
       )
   }
   ```

   最终效果如下：

   ![](https://web-cdn.agora.io/docs-files/1620289155801)

### 修改基础 UI 组件的全局样式

以下示例演示了如何通过修改基础 UI 组件的全局样式。

1. 在 `packages/agora-classroom-sdk/src/ui-kit/styles/global.css` 文件中定义全局样式：

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