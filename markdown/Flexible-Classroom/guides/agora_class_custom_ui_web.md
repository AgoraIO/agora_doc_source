## UI 组件介绍

灵动课堂的 UI 组件可分为功能组件、业务组件和场景组件三种。

### 功能组件

功能组件是灵动课堂中最基础的 UI 组件，不和业务逻辑绑定。一个功能组件维护一个功能的内部状态和逻辑，例如 `Button`、`Modal`、`Select`、 `Tree` 等。

功能组件在 `agora-scenario-ui-kit` 目录下，采用 `react`+`ts`+`storybook` 架构。每个功能组件文件夹均包含以下三个文件：

-   `.tsx`: 实现 UI 组件的功能。
-   `.css`: 实现 UI 组件的样式。
-   `.stories.tsx`: 用于 UI 组件在 Storybook 中的预览和调试。开发者可通过 `yarn dev:ui-kit ` 或 `npm run dev:ui-kit` 命令启动项目，在 Storybook 中查看各功能组件。

下表详细介绍灵动课堂中使用的功能组件：

| 文件夹          | 功能组件                                                                   |
| :-------------- | :------------------------------------------------------------------------- |
| `/affix`        | 固钉，用于将页面元素钉在可视范围。                                         |
| `/biz-header`   | 教室内头部导航栏。                                                         |
| `/button`       | 按钮组件。                                                                 |
| `/calendar`     | 日历组件。                                                                 |
| `/card`         | 通用卡片容器。                                                             |
| `/chat-new`     | 聊天组件。                                                                 |
| `/checkbox`     | 复选框。                                                                   |
| `/countdown`    | 倒计时组件。                                                               |
| `/date-picker`  | 用于选择日期的组件。                                                       |
| `/home-about`   | 首页关于的弹窗组件。                                                       |
| `/icon`         | `iconfont` 图标组件。                                                      |
| `/input`        | 输入框。                                                                   |
| `/layout`       | 布局组件，协助进行页面级整体布局。                                         |
| `/loading`      | 加载组件，用于加入教室的加载、文件上传中的加载等。                         |
| `/modal`        | 模态对话框，用于不打断当前工作流程的用户操作。                             |
| `/pagination`   | 分页组件，采用分页的形式分隔长列表，每次只加载一个页面。                   |
| `/placeholder`  | 占位图，用于视频占位图、云盘空文件占位图等。                               |
| `/popover`      | 气泡卡片，用于点击/鼠标移入元素、弹出气泡式的卡片浮层等。                  |
| `/progress`     | 进度条，展示操作的当前进度。                                               |
| `/radio`        | 单选框。                                                                   |
| `/root-box`     | 根容器，最外层包裹页面元素的组件。                                         |
| `/roster`       | 花名册，用于展示学生列表，可进行邀请学生上讲台、发放奖励、踢出教室等操作。 |
| `/select`       | 下拉框组件。                                                               |
| `/slider`       | 滑动输入条，用于展示当前值和可选范围。                                     |
| `/sound-player` | 播放音频文件的组件。                                                       |
| `/svg-img`      | svg 图标。                                                                 |
| `/table`        | 表格组件。                                                                 |
| `/tabs`         | 选项卡切换组件。                                                           |
| `/toast`        | 全局提示组件。                                                             |
| `/toolbar`      | 工具栏，用于展示老师学生教具。                                             |
| `/tooltip`      | 简单的文字提示气泡框。                                                     |
| `/tree`         | 树型选择组件。                                                             |
| `/video-player` | 视频渲染组件。                                                             |
| `/volume`       | 显示说话声音的组件。                                                       |

### 业务组件

业务组件指灵动课堂中和业务逻辑绑定的 UI 组件。业务组件大部分是由多个功能组件组合并注入相关的业务逻辑。业务组件依赖于 UI Store 中注入的 Observable 对象和行为函数来自动更新 UI 和调用 API。以举手上讲台功能为例，此功能对应的业务组件可以根据当前举手数据展示举手的用户列表，并提供按钮供用户点击，业务组件内部会调用 API 发送举手请求。

![](https://web-cdn.agora.io/docs-files/1649917547117)

业务组件位于 `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers` 目录下。

下表详细介绍灵动课堂中使用的业务组件：

| 文件夹                     | 对应的业务                                                                       |
| :------------------------- | :------------------------------------------------------------------------------- |
| `/award`                   | 奖励组件，实现老师发放奖励给学生的业务。                                         |
| `/big-widget-window`       | Widget 大窗口，实现大窗口、可获取是否激活大窗口等业务。                          |
| `/board`                   | 白板组件，实现白板相关业务，包括设置白板高度、比例等。                           |
| `/cloud-driver`            | 云盘组件，实现文件上传、文件删除等业务。                                         |
| `/device-setting`          | 设备设置，实现获取摄像头、麦克风、扬声器列表以及切换设备等业务。                 |
| `/dialog`                  | Dialog 窗口，实现课中弹窗的功能。                                                |
| `/extension-app-container` | extApp 容器，实现插件业务。                                                      |
| `/hand-up`                 | 举手组件，实现学生举手上讲台、老师接受或拒绝的业务。                             |
| `/loading`                 | 加载组件，处理加载逻辑。                                                         |
| `/nav`                     | 导航组件，处理网络状态、上课状态等。                                             |
| `/pretest`                 | 设备预检组件，实现进入课堂前设备预检业务，包含获取设备列表信息、切换设备等功能。 |
| `/root-box`                | 根容器，整个课堂的根组件。                                                       |
| `/roster`                  | 花名册组件，实现查看学生信息、处理上讲台请求、发奖励等业务。                     |
| `/scene-switch`            | 场景切换组件，处理分组相关业务。                                                 |
| `/scenes-controller`       | 白板场景控制组件，实现新增或删除白板页。                                         |
| `/screen-share`            | 屏幕共享组件，处理屏幕共享逻辑。                                                 |
| `/stream`                  | 音视频流组件，处理各班型音视频渲染。                                             |
| `/toast`                   | Toast 提示组件。                                                                 |
| `/toolbar`                 | 工具栏，实现白板老师学生教具相关业务。                                           |
| `/widget`                  | Widget 组件，处理 Widget 渲染加载等逻辑。                                        |

### 场景组件

场景组件是由多个业务组件组合而成。灵动课堂支持一对一互动教学、在线互动小班课、互动直播大班课三个预设场景。场景组件位于 `packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios` 目录。如果你想改动某一个场景的布局，找到对应的场景组件修改即可。

| 文件夹          | 场景组件                     |
| :-------------- | :--------------------------- |
| `/1v1`          | 1 对 1 互动教学场景          |
| `/big-class`    | 互动直播大班课场景           |
| `/big-class-h5` | 针对 H5 的互动直播大班课场景 |
| `/mid-class`    | 在线互动小班课场景           |

### UI 组件关系示意图

![](https://web-cdn.agora.io/docs-files/1649917558727)

## 自定义功能组件

### 新增功能组件

你可参考以下步骤在灵动课堂中新增功能组件：

1. 在 `packages/agora-scenario-ui-kit/src/components` 目录下新建文件夹，用于存放你所需要新增的功能组件。请注意，文件夹中需包含以下三个文件：

    - `index.tsx`: 实现 UI 组件的功能。
    - `index.css`: 实现 UI 组件的样式。
    - `index.stories.tsx`: 用于 UI 组件在 Storybook 中的预览和调试。

2. 实现功能组件后，在 `packages/agora-scenario-ui-kit/src/components/index.ts` 下导出该组件。这样你就可以后续在你自己的项目中导入新写的组件。

以下示例展示了如何新增一个名为 `agora-demo` 的功能组件：

![](https://web-cdn.agora.io/docs-files/1649913888493)

```tsx
// index.css
.agora-demo {
    color: red
}


// index.tsx
import React from 'react'
import './index.css'

export const AgoraDemo = () => {
  return (
    <div className="agora-demo">AgoraDemo</div>
  )
}


// index.stories.tsx
import React from 'react';
import { Meta } from '@storybook/react';
import { AgoraDemo } from './index';

const meta: Meta = {
    title: 'Components/AgoraDemo',
    component: AgoraDemo,
};

export default meta;

export const Docs = () => (
    <AgoraDemo />
)
```

该功能组件在 Storybook 中的效果如下：

![](https://web-cdn.agora.io/docs-files/1649914019254)

### 修改功能组件

如果你想修改某个功能组件的功能和样式，找到该组件所在的文件夹，修改代码即可。以下提供几个修改示例。

#### 修改导航栏颜色

你可修改 `packages/agora-scenario-ui-kit/src/components/biz-header/index.css` 文件，将导航栏组件 BizHeader 的背景颜色从白色修改为红色。

**修改前**

```css
.biz-header {
    @apply bg-white;
    padding: 0 15px 0 8px;
    border-top: 0px;
    border: 1px solid #ececf1;
}
```

![](https://web-cdn.agora.io/docs-files/1649914581018)

**修改后**

```css
.biz-header {
    background: red !important;
    padding: 0 15px 0 8px;
    border-top: 0px;
    border: 1px solid #ececf1;
}
```

![](https://web-cdn.agora.io/docs-files/1649914602349)

#### 修改 input 组件占位文字的颜色

你可修改 `packages/agora-scenario-ui-kit/src/components/input/index.css` 文件来修改 input 组件中占位文字的颜色。

**修改前**

```css
.input-wrapper input::-webkit-input-placeholder {
    /* WebKit browsers */
    color: #7b88a0;
    font-size: 14px;
}
```

![](https://web-cdn.agora.io/docs-files/1649914809363)

**修改后**

```css
.input-wrapper input::-webkit-input-placeholder {
    /* WebKit browsers */
    color: skyblue;
    font-size: 14px;
}
```

![](https://web-cdn.agora.io/docs-files/1649914885119)

## 自定义业务组件

### 新增业务组件

如需新增业务组件，你可在 `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers` 下新建文件夹，包含以下文件：

-   `index.tsx`: 组合你的功能组件，注入业务逻辑，实现业务功能。
-   `index.css`: 实现业务组件的样式。

实现业务组件后，你可直接导入该业务组件，启动项目查看效果。

以下示例展示了如何新增一个实现在课堂中间显示上课状态及网络状态的业务组件：

```tsx
// index.css
.agora-demo {
    width: 50%;
    height: 50%;
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    margin: auto;
    border: 1px solid black;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    z-index: 99999999;
}
.agora-demo-title {
    color: red;
}

// index.tsx
import { useStore } from '@/infra/hooks/use-edu-stores';
import React from 'react'
import './index.css'

export default function AgoraDemo() {
    const { navigationBarUIStore } = useStore();
    const { classStatusText, networkQualityLabel, delay, packetLoss } = navigationBarUIStore;
    return (
        <div className="agora-demo">
            <h1 className="agora-demo-title">这是我们新写的业务组件</h1>
            <h2>用于展示网络状态和课堂状态</h2>
            <div>网络状态: {networkQualityLabel} 网络延迟: {delay} 丢包率：{packetLoss}</div>
            <div>课堂状态: {classStatusText}</div>
        </div>
    )
}

// packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/mid-class/index.tsx
// 在小班课场景引入该组件
import { Aside, Layout } from '~components/layout';
import { observer } from 'mobx-react';
import classnames from 'classnames';
import { NavigationBarContainer } from '~containers/nav';
import { DialogContainer } from '~containers/dialog';
import { LoadingContainer } from '~containers/loading';
import Room from '../room';
import { RoomMidStreamsContainer } from '~containers/stream/room-mid-player';
import { CollectorContainer } from '~containers/board';
import { WhiteboardContainer } from '~containers/board';
import { FixedAspectRatioRootBox } from '~containers/root-box';
import { ChatWidgetPC } from '~containers/widget/chat-widget';
import { ExtensionAppContainer } from '~containers/extension-app-container';
import { ToastContainer } from '~containers/toast';
import { HandsUpContainer } from '~containers/hand-up';
import { SceneSwitch } from '~containers/scene-switch';
import { Award } from '../../containers/award';
import { BigWidgetWindowContainer } from '../../containers/big-widget-window';
import AgoraDemo from '../../containers/agora-demo';


export const MidClassScenario = observer(() => {
  // 场景布局
  const layoutCls = classnames('edu-room', 'mid-class-room');

  return (
    <Room>
      {/* 这里是新增的业务组件 */}
      <AgoraDemo/>
      <FixedAspectRatioRootBox trackMargin={{ top: 27 }}>
        <SceneSwitch>
          <Layout className={layoutCls} direction="col">
            <NavigationBarContainer />
            <RoomMidStreamsContainer />
            <BigWidgetWindowContainer>
              <WhiteboardContainer></WhiteboardContainer>
            </BigWidgetWindowContainer>
            <Aside className="aisde-fixed">
              <CollectorContainer />
              <HandsUpContainer />
              <ChatWidgetPC />
            </Aside>
            <DialogContainer />
            <LoadingContainer />
          </Layout>
          <ExtensionAppContainer />
          <ToastContainer />
          <Award />
        </SceneSwitch>
      </FixedAspectRatioRootBox>
    </Room>
  );
});
```

该业务组件在灵动课堂中的效果如下：

![](https://web-cdn.agora.io/docs-files/1649915609848)

### 修改业务组件

如果你想修改某个业务组件的功能和样式，找到该组件所在的文件夹，修改代码即可。以下提供几个修改示例。

#### 在设备设置弹窗上显示摄像头设备个数

```tsx
const Setting: React.FC<SettingProps> = observer(({className, ...restProps}) => {
    const cls = classnames({
        [`setting`]: 1,
        [`${className}`]: !!className,
    });

    const {
        deviceSettingUIStore: {cameraDevicesList},
    } = useStore();

    return (
        <div className={cls} {...restProps} style={{width: 318}}>
            <div className="device-choose">
                <div
                    className="device-title"
                    style={{
                        display: "flex",
                        justifyContent: "space-between",
                    }}>
                    {/* 展示设备个数。这里 -1 是因为要减去默认的禁用选项 */}
                    <div>
                        {transI18n("device.camera")} 设备个数: {cameraDevicesList.length - 1}
                    </div>
                    <div style={{display: "flex"}}>
                        <div
                            style={{
                                display: "flex",
                                alignItems: "center",
                            }}>
                            <CameraMirrorCheckBox />
                            <span className="beauty-desc" style={{marginLeft: 5}}>
                                {transI18n("media.mirror")}
                            </span>
                        </div>
                    </div>
                </div>
                <CameraSelect />
            </div>
            <div className="device-choose">
                <div className="device-title">{transI18n("device.microphone")}</div>
                <MicrophoneSelect />
            </div>
            <div className="device-choose">
                <div className="device-title">{transI18n("device.speaker")}</div>
                <PlaybackSelect />
            </div>
        </div>
    );
});
```

**修改前**

![](https://web-cdn.agora.io/docs-files/1650366786587)

**修改后**

![](https://web-cdn.agora.io/docs-files/1650366838206)

## 自定义场景布局

如果你想修改场景布局，找到该场景所在的文件夹，修改代码即可。

#### 移动视频区域和聊天区域的位置

以下示例演示了如何将灵动课堂右侧的视频区域和聊天区域移动到左侧。这是一个跨组件的调整，因此需要修改这两个组件的父容器，也就是一对一互动教学场景容器 `packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/1v1/index.tsx` 文件。

**修改前**

```tsx
import classnames from "classnames";
import {observer} from "mobx-react";
import {FC} from "react";
import {WhiteboardContainer} from "~containers/board";
import {DialogContainer} from "~containers/dialog";
import {LoadingContainer} from "~containers/loading";
import {NavigationBarContainer} from "~containers/nav";
import {Aside, Layout} from "~components/layout";
import {ScreenShareContainer} from "~containers/screen-share";
import {Room1v1StreamsContainer} from "~containers/stream/room-1v1-player";
import {ChatWidgetPC} from "~containers/widget/chat-widget";
import Room from "../room";
import {FixedAspectRatioRootBox} from "~containers/root-box/fixed-aspect-ratio";
import {ExtensionAppContainer} from "~containers/extension-app-container";

import {ToastContainer} from "~containers/toast";
import {CollectorContainer} from "~containers/board";
import {BigWidgetWindowContainer} from "../../containers/big-widget-window";

const Content: FC = ({children}) => {
    return <div className="flex-grow">{children}</div>;
};

export const OneToOneScenario = observer(() => {
    const layoutCls = classnames("edu-room");

    return (
        <Room>
            <FixedAspectRatioRootBox trackMargin={{top: 27}}>
                <Layout className={layoutCls} direction="col">
                    <NavigationBarContainer />
                    <Layout className="horizontal">
                        <Content>
                            <BigWidgetWindowContainer>
                                <WhiteboardContainer></WhiteboardContainer>
                            </BigWidgetWindowContainer>

                            <Aside className="aisde-fixed">
                                <CollectorContainer />
                            </Aside>
                        </Content>
                        <Aside>
                            <Room1v1StreamsContainer />
                            <ChatWidgetPC />
                        </Aside>
                    </Layout>
                    <DialogContainer />
                    <LoadingContainer />
                </Layout>
                {/* <ExtAppContainer /> */}
                <ExtensionAppContainer />
                <ToastContainer />
            </FixedAspectRatioRootBox>
        </Room>
    );
});
```

![](https://web-cdn.agora.io/docs-files/1649915965800)

**修改后**

```tsx
import classnames from "classnames";
import {observer} from "mobx-react";
import {FC} from "react";
import {WhiteboardContainer} from "~containers/board";
import {DialogContainer} from "~containers/dialog";
import {LoadingContainer} from "~containers/loading";
import {NavigationBarContainer} from "~containers/nav";
import {Aside, Layout} from "~components/layout";
import {ScreenShareContainer} from "~containers/screen-share";
import {Room1v1StreamsContainer} from "~containers/stream/room-1v1-player";
import {ChatWidgetPC} from "~containers/widget/chat-widget";
import Room from "../room";
import {FixedAspectRatioRootBox} from "~containers/root-box/fixed-aspect-ratio";
import {ExtensionAppContainer} from "~containers/extension-app-container";

import {ToastContainer} from "~containers/toast";
import {CollectorContainer} from "~containers/board";
import {BigWidgetWindowContainer} from "../../containers/big-widget-window";

const Content: FC = ({children}) => {
    return <div className="flex-grow">{children}</div>;
};

export const OneToOneScenario = observer(() => {
    const layoutCls = classnames("edu-room");

    return (
        <Room>
            <FixedAspectRatioRootBox trackMargin={{top: 27}}>
                <Layout className={layoutCls} direction="col">
                    <NavigationBarContainer />
                    <Layout className="horizontal">
                        /** 调整 Layout 中 Content 与 Aside 的顺序。*/
                        <Aside>
                            <Room1v1StreamsContainer />
                            <ChatWidgetPC />
                        </Aside>
                        <Content>
                            <BigWidgetWindowContainer>
                                <WhiteboardContainer></WhiteboardContainer>
                            </BigWidgetWindowContainer>
                            <Aside className="aisde-fixed">
                                <CollectorContainer />
                            </Aside>
                        </Content>
                    </Layout>
                    <DialogContainer />
                    <LoadingContainer />
                </Layout>
                {/* <ExtAppContainer /> */}
                <ExtensionAppContainer />
                <ToastContainer />
            </FixedAspectRatioRootBox>
        </Room>
    );
});
```

![](https://web-cdn.agora.io/docs-files/1649916010668)

#### 添加 logo

如果你想在右侧 `<Aside>` 添加一个 logo，你需要先实现 `Logo`组件，然后这样布局：

```tsx
...
<Aside>
    <Logo/> {/* 新增的logo */}
    <Room1v1StreamsContainer />
    <ChatWidgetPC />
</Aside>
...
```

## 修改 UI Store

业务组件由多个功能组件组合，且依赖 UI Store。本节介绍如何修改业务组件所依赖的 UI Store。

UI Store 位于 `packages/agora-classroom-sdk/src/infra/stores` 目录下，具体介绍如下：

| 文件夹         | 说明                        |
| :------------- | :-------------------------- |
| `/common`      | 各场景通用的 UI Store       |
| `/interactive` | 为小班课定制的 UI Store     |
| `/lecture`     | 为大班课定制的 UI Store     |
| `/lecture-h5`  | 为 H5 大班课定制的 UI Store |
| `/one-on-one`  | 为一对一场景定制的 UI Store |

`/common` 中的 `EduClassroomUIStore` 为基类。如果你需要定制某个场景的某个功能，则需要继承该类，重写对应的 UI Store。

以下示例代码展示了如何定制大班课的 UI Store。

```typescript
import {EduClassroomStore} from "agora-edu-core";
import {EduClassroomUIStore} from "../common";
import {LectureBoardUIStore} from "./board-ui";
import {LectureRosterUIStore} from "./roster";
import {LectureRoomStreamUIStore} from "./stream-ui";
import {LectrueToolbarUIStore} from "./toolbar-ui";
import {LectureWidgetUIStore} from "./widget-ui";

export class EduLectureUIStore extends EduClassroomUIStore {
    constructor(store: EduClassroomStore) {
        super(store);
        this._streamUIStore = new LectureRoomStreamUIStore(store, this.shareUIStore); // 重写 Stream UI Store
        this._rosterUIStore = new LectureRosterUIStore(store, this.shareUIStore); // 重写 Roster UI Store
        this._boardUIStore = new LectureBoardUIStore(store, this.shareUIStore); // 重写 Board UI Store
        this._toolbarUIStore = new LectrueToolbarUIStore(store, this.shareUIStore); // 重写 Toolbar UI Store
        this._widgetUIStore = new LectureWidgetUIStore(store, this.shareUIStore); // 重写 Widget UI Store
    }

    get streamUIStore() {
        return this._streamUIStore as LectureRoomStreamUIStore;
    }

    get rosterUIStore() {
        return this._rosterUIStore as LectureRosterUIStore;
    }
    get widgetUIStore() {
        return this._widgetUIStore as LectureWidgetUIStore;
    }
}
```

### 修改老师授权后学生的教具

如果你想在所有场景中修改老师授权后学生的教具，则直接修改 `/common` 下的 `toolbar-ui.ts`。如果你只想修改某个场景中老师授权后学生的教具，可以在对应的场景目录下，新建 `toolbar-ui.ts` 并重写方法。

举例来说，如果你想修改一对一场景的教具，则可修改 `packages/agora-classroom-sdk/src/infra/stores/one-on-one/toolbar-ui.ts` 文件。

```typescript
// packages/agora-classroom-sdk/src/infra/stores/one-on-one/toolbar-ui.ts
...
// 继承基类 Toolbar UI Store
export class OneToOneToolbarUIStore extends ToolbarUIStore {
  ...
  get teacherTools(): ToolbarItem[] {
    // 筛选老师的教具
    return [
      ToolbarItem.fromData({
        value: 'clicker',
        label: 'scaffold.clicker',
        icon: 'select',
      }),
      ToolbarItem.fromData({
        value: 'selection',
        label: 'scaffold.selector',
        icon: 'clicker',
      }),
      ToolbarItem.fromData({
        value: 'pen',
        label: 'scaffold.pencil',
        icon: 'pen',
        category: ToolbarItemCategory.PenPicker,
      }),
      ToolbarItem.fromData({
        value: 'text',
        label: 'scaffold.text',
        icon: 'text',
      }),
      ToolbarItem.fromData({
        value: 'eraser',
        label: 'scaffold.eraser',
        icon: 'eraser',
      }),
      ToolbarItem.fromData({
        value: 'hand',
        label: 'scaffold.move',
        icon: 'hand',
      }),
      {
        value: 'cloud',
        label: 'scaffold.cloud_storage',
        icon: 'cloud',
      },
      {
        value: 'tools',
        label: 'scaffold.tools',
        icon: 'tools',
        category: ToolbarItemCategory.Cabinet,
      },
    ];
  }


  @computed
  get studentTools(): ToolbarItem[] {
    // 筛选学生的教具
    const { sessionInfo } = EduClassroomConfig.shared;
    const whiteboardAuthorized = this.classroomStore.boardStore.grantUsers.has(
      sessionInfo.userUuid,
    );

    if (!whiteboardAuthorized) {
      return [];
    }

    return [
      ToolbarItem.fromData({
        value: 'clicker',
        label: 'scaffold.clicker',
        icon: 'select',
      }),
      ToolbarItem.fromData({
        value: 'selection',
        label: 'scaffold.selector',
        icon: 'clicker',
      }),
      ToolbarItem.fromData({
        value: 'pen',
        label: 'scaffold.pencil',
        icon: 'pen',
        category: ToolbarItemCategory.PenPicker,
      }),
      ToolbarItem.fromData({
        value: 'text',
        label: 'scaffold.text',
        icon: 'text',
      }),
      ToolbarItem.fromData({
        value: 'eraser',
        label: 'scaffold.eraser',
        icon: 'eraser',
      }),
    ];
  }
}
```

上述设置能覆盖 `/common` 中的教具，效果如下：

![](https://web-cdn.agora.io/docs-files/1649916757576)

![](https://web-cdn.agora.io/docs-files/1649916722388)

### 修改视频窗口工具栏的位置

当前灵动课堂中视频窗口的工具栏会悬浮出现在视频窗口下方。如果你想将一对一场景中的工具栏位置改为视频窗口的左侧，可在 `/one-on-one` 目录下创建 `stream-ui.ts`，重写 `toolbarPlacement` 方法。

```typescript
// packages/agora-classroom-sdk/src/infra/stores/one-on-one/stream-ui.ts
import { computed } from 'mobx';
import { StreamUIStore } from '../common/stream';


export class OneToOneStreamUIStore extends StreamUIStore {
  ...
  // override
  @computed get toolbarPlacement(): 'bottom' | 'left' {
    return 'left';
  }

  ...
}


// 对应的业务组件
const LocalStreamPlayerTools = observer(({ isFullScreen = true }: { isFullScreen?: boolean }) => {
  const { streamUIStore } = useStore();
  const { localStreamTools, toolbarPlacement, fullScreenToolTipPlacement } = streamUIStore;


  return localStreamTools.length > 0 ? (
    <div className={`video-player-tools`}>
      {localStreamTools.map((tool, key) => (
        <Tooltip
          key={key}
          title={tool.toolTip}
          // Tooltip 组件，placement 属性控制工具栏位置
          placement={isFullScreen ? fullScreenToolTipPlacement : toolbarPlacement}>
          <span>
            <SvgIcon
              canHover={tool.interactable}
              style={tool.style}
              // hoverType={tool.hoverIconType}
              type={tool.iconType}
              size={22}
              onClick={tool.interactable ? tool.onClick : () => {}}
            />
          </span>
        </Tooltip>
      ))}
    </div>
  ) : (
    <></>
  );
});
```

效果如下：

**修改前**

![](https://web-cdn.agora.io/docs-files/1649917042806)

**修改后**

![](https://web-cdn.agora.io/docs-files/1649917031341)

## 更多示例

### 修改教室背景色

如需修改教室背景色，可修改 `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/root-box/fixed-aspect-ratio.tsx` 文件中的代码。

```tsx
const FixedAspectRatioContainer: React.FC<FixedAspectRatioProps> = observer(
    ({children, minimumWidth = 0, minimumHeight = 0}) => {
        const style = useClassroomStyle({minimumHeight, minimumWidth});

        const {shareUIStore} = useStore();

        return (
            <div
                // 可以使用 tailwind 类名
                className="flex bg-black justify-center items-center h-screen w-screen"
                // 也可以设置 CSS 属性
                style={{backgroundColor: "red"}}>
                <div style={style} className={`w-full h-full relative ${shareUIStore.classroomViewportClassName}`}>
                    {children}
                </div>
            </div>
        );
    },
);
```

### 修改白板背景色

如需修改白板背景色，可修改 `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/board/index.css` 文件中的代码。

```css
.whiteboard {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;
    border: 1px solid #ececf1;
    border-radius: 4px;
    background: #000; /* 这行设置白板颜色背景色为黑色 */
}
```

### 修改白板布局比例

如需调整白板布局，可修改 `packages/agora-classroom-sdk/src/infra/stores/common/board-ui.ts` 文件中的代码。灵动课堂根据 `heightRatio` 和 `viewportHeight` 计算出白板的高度，然后根据白板的比例动态设置白板的大小。

```typescript
// packages/agora-classroom-sdk/src/infra/stores/common/board-ui.ts
...
  protected get uiOverrides() {
    return {
      ...super.uiOverrides,
      heightRatio: 1,
      aspectRatio: 9 / 16,
    };
  }

  /**
   * 白板高度
   * @returns
   */
  get boardHeight() {
    const { roomType } = EduClassroomConfig.shared.sessionInfo;
    const viewportHeight = this.shareUIStore.classroomViewportSize.height;
    const height = this.uiOverrides.heightRatio * viewportHeight; // 计算白板高度
    if (roomType === EduRoomTypeEnum.Room1v1Class) {
      return height - this.shareUIStore.navBarHeight;
    }
    return height;
  }
...
```

上述改动会应用于所有场景。如果你只想修改一对一场景中的白板高度，则可在 `packages/agora-classroom-sdk/src/infra/stores/one-on-one` 目录下新建 `board-ui.ts` 文件，代码如下：

```typescript
// packages/agora-classroom-sdk/src/infra/stores/one-on-one/board-ui.ts
import {BoardUIStore} from "../common/board-ui";

export class OneToOneBoardUIStore extends BoardUIStore {
    protected get uiOverrides() {
        return {
            ...super.uiOverrides,
            heightRatio: 1,
            aspectRatio: 0.706,
        };
    }
}
```
