本文介绍灵动课堂插件机制的原理、灵动课堂内置插件、以及如何新增一个插件。

<div class="alert note">本文仅针对 2.7.0 或之后版本。如需了解如何在 2.4.x、2.5.x、2.6.x 版本上自定义插件，请参考<a href="/cn/agora-class/agora_class_widget_web_previous?platform=Web">自定义插件 (旧版)</a>。</div>

## 技术原理

灵动课堂提供插件机制，帮助开发者集成源代码时为业务需求扩展课堂能力。同时，通过插件机制，可以降低自定义业务与课堂的代码耦合程度，从而降低集成源代码的后期升级难度。

插件的技术原理分为：

- 插件的生命周期
- 插件的实例化
- 插件的挂载点
- 插件的通信机制
- 插件用于扩展教室能力
- 插件用于调用教室能力
- 插件的轨迹同步和多语言能力

详见[插件的技术原理介绍](/cn/agora-class/agora_class_widget_understand_tech?platform=Web)。


## 内置插件

本节介绍灵动课堂内置的插件。它们扩展了教室能力，主要分为以下两类：

- 通用类插件
    - 互动白板
    - IM 模块
    - 内嵌浏览器
    - 视频同步播放器（目前仅支持 Youtube 视频）
    - 水印插件
- 教具类插件
    - 答题器
    - 投票器
    - 计时器

内置插件的源代码均位于 [apaas-widgets-web 仓库](https://github.com/AgoraIO-Community/apaas-widgets-web)的 `src/gallery` 目录下，具体为如下：

| 插件名称       | 源代码文件夹   |
| :------------- | :----------- |
| 互动白板       | `whiteboard`   |
| IM 模块        | `im`  |
| 内嵌浏览器     | `webview`      |
| 视频同步播放器 | `stream-media` |
| 答题器         | `answer`       |
| 投票器         | `vote`         |
| 计时器         | `counter`      |
| 水印插件         | `watermark`      |

## 新增一个插件

如果你需要新增一个自定义的 Widget，可继承灵动课堂提供的 `AgoraWidgetBase` 类，并实现抽象方法。

如下是 `AgoraWidgetBase` 类的定义：

```ts
/**
 * AgoraWidgetBase 提供 Widget 相关操作 API
 */
export declare abstract class AgoraWidgetBase implements AgoraWidgetRenderable, AgoraMultiInstanceWidget {
    private _widgetController;
    private _classroomStore;
    private _shareUIStore;
    private _uiConfig;
    private _theme;
    private _trackController?;
    private _instanceId;
    constructor(_widgetController: AgoraWidgetController, _classroomStore: EduClassroomStore, _shareUIStore: EduShareUIStore, _uiConfig: FcrUIConfig, _theme: FcrTheme);
    setInstanceId(instId: string): void;
    get instanceId(): string;
    /**
     * Widget 的名称
     */
    abstract get widgetName(): string;
    /**
     * 是否有 Widget 权限
     */
    abstract get hasPrivilege(): boolean;
    /**
     * Widget 唯一 ID
     */
    get widgetId(): string;
    /**
     * 容器层级
     */
    get zContainer(): 0 | 10;
    /**
     * 轨迹同步控制器
     */
    get trackController(): AgoraWidgetTrackController | undefined;
    /**
     * Widget 控制器
     */
    get widgetController(): AgoraWidgetController;
    /**
     * 教室 Store
     */
    get classroomStore(): EduClassroomStore;
    /**
     * 共享 UIStore
     */
    get shareUIStore(): EduShareUIStore;
    /**
     * 教室配置
     */
    get classroomConfig(): import("agora-edu-core").EduClassroomConfig;
    /**
     * UI 配置
     */
    get uiConfig(): FcrUIConfig;
    /**
     * 主题
     */
    get theme(): FcrTheme;
    /**
     * 发送消息
     */
    sendMessage(toWidgetId: string, messageType: string, message: unknown): void;
    /**
     * 增加一个消息监听器
     */
    addMessageListener(listener: Pick<AgoraWidgetMessageListener, 'messageType' | 'onMessage'>): void;
    /**
     * 移除一个消息监听器
     */
    removeMessageListener(listener: Pick<AgoraWidgetMessageListener, 'messageType' | 'onMessage'>): void;
    /**
     * 广播消息
     */
    broadcast(messageType: string, message: unknown): void;
    /**
     * 增加广播监听
     */
    addBroadcastListener(listener: Omit<AgoraWidgetMessageListener, 'widgetId'>): void;
    /**
     * 移除广播监听
     */
    removeBroadcastListener(listener: Omit<AgoraWidgetMessageListener, 'widgetId'>): void;
    /**
     * 更新 Widget 属性
     */
    updateWidgetProperties(properties: any): Promise<{
        data: any;
    }>;
    /**
     * 更新 Widget 用户属性
     */
    updateWidgetUserProperties(userProperties: any): void;
    /**
     * 删除 Widget
     * @returns
     */
    deleteWidget(): Promise<{
        data: any;
    }>;
    /**
     * 删除 Widget 用户属性
     * @param keys
     * @returns
     */
    removeWidgetUserProperties(keys: string[]): Promise<{
        data: any;
    }>;
    /**
     * 删除 Widget 扩展属性
     * @param keys
     * @returns
     */
    removeWidgetExtraProperties(keys: string[]): Promise<{
        data: any;
    }>;
    /**
     * 设置 Widget 为活跃状态
     * @param props
     */
    setActive(props?: any): void;
    /**
     * 设置 Widget 为不活跃状态
     */
    setInactive(props?: any): void;
    locate(): HTMLElement | undefined | null;
    render(dom: HTMLElement): void;
    unload(): void;
    /**
     * 获取最新组件层级
     */
    get latestZIndex(): number;
    setTrackController(controller: AgoraWidgetTrackController): void;
}
```

下面展示新增一个 `ExampleWidget` 来实现一个最基本的 Widget。

### 使用 AgoraWidgetBase

创建一个继承 `AgoraWidgetBase` 类的 `ExampleWidget` 类：

```ts
import {
    AgoraWidgetBase,
} from 'agora-classroom-sdk';


export class ExampleWidget extends AgoraWidgetBase {
    private _dom?: HTMLElement;
    /**
     * 全局唯一的 Widget 名称
     */
    get widgetName(): string {
        return 'example'
    }

    /**
     * 控制 Widget 是否可控
     */
    get hasPrivilege(): boolean {
        return false;
    }

    /**
     * 挂载点
     * 重写 locate 方法返回一个节点，则此 Widget 将渲染在此节点内部
     *
     * 这里将 ExampleWidget 挂载至白板区域
     */
    locate(): HTMLElement | null | undefined {
        return document.querySelector(".widget-slot-board") as HTMLElement;
    }

    /**
     * Widget 节点已挂载
     * 此时可以在 DOM 节点进行自定义渲染
     */
    render(dom: HTMLElement): void {
        dom.innerHTML = 'This is a custom widget';
        dom.style.height = '100%';
        dom.style.display = "flex";
        dom.style.alignItems = "center";
        dom.style.justifyContent = "center";
        this._dom = dom;
    }

    /**
     * 卸载组件
     * 此时可以把相关资源释放掉
     */
    unload(): void {
        this._dom = undefined;
    }
}
```

### launch 中传入自定义的 Widget

通过 `launch` 中的 `widgets` 参数传入自定义 Widget：

```ts
const widgets = {
    // 需要引入上面定义的 ExampleWidget 类
    'example': ExampleWidget
};
AgoraEduSDK.launch(dom, {
...
widgets: widgets
...
});
```

### 创建自定义的 Widget

因为这里的 `ExampleWidget` 为自定义的 Widget，因此需要手动调用 `WidgetUIStore` 中的 `createWidget` 方法来创建 Widget：

```ts
// 修改 WidgetUIStore 代码
// 文件路径 packages/agora-classroom-sdk/src/infra/stores/common/widget/index.ts 文件中加入代码

onInstall() {
    ...
    // 加入此代码，在房间加入成功后打开指定 Widget
    this._disposers.push(
      reaction(
        () => this.classroomStore.widgetStore.widgetController,
        () => {
          // 打开我们新增的 widget ，此处传入 widgetName
          this.createWidget('example');
        },
      ),
    );
}
```

### 插件效果展示

启动教室，插件挂载后的效果如图：

![](https://web-cdn.agora.io/docs-files/1664451212904)


## 基于现有能力快速创建一个教具插件

灵动课堂为开发者提供了一个名为 `AgoraEduToolWidget` 抽象类，此类实现了教具类插件通用能力的封装。继承此类可以获得插件的轨迹同步、层级控制能力，以及对 UI 窗口的显示和显示的控制逻辑。

配合 `ControlledModal` 组件，你还可快速实现内置教具插件的外层窗口，减少大量的通用逻辑代码开发，具体实现请参考仓库 `src/gallery` 目录下 `answer`、`vote`、`counter` 文件夹，其中提供灵动课堂内置的教具类插件源代码。

如下是 `AgoraEduToolWidget` 类的定义：

```ts
/**
 * AgoraEduToolWidget 是教学道具 Widget 基类
 * 使用 AgoraEduToolWidget 抽象类作为基类，实现可拖拽且轨迹同步的 Widget
 */
export abstract class AgoraEduToolWidget
  extends AgoraWidgetBase
  implements AgoraWidgetLifecycle, AgoraTrackSyncedWidget
{
  private _controlStateCallbacks: CallableFunction[] = [];
  onUninstall(controller: AgoraWidgetController) {}
  onInstall(controller: AgoraWidgetController) {}
  onCreate(properties: any, userProperties: any): void {}
  onPropertiesUpdate(properties: any): void {}
  onUserPropertiesUpdate(userProperties: any): void {}
  onDestroy(): void {}
  get track(): Track {
    return this.trackController?.track!;
  }
  get zIndex(): number {
    return this.trackController?.zIndex || 0;
  }
  @bound
  updateZIndexToRemote(zIndex: number) {
    this.trackController?.updateRemoteZIndex(zIndex);
    this.widgetController.zIndexController.setZIndex(zIndex);
  }
  @bound
  updateZIndexToLocal(zIndex: number) {
    this.trackController?.updateLocalZIndex(zIndex);
    this.widgetController.zIndexController.setZIndex(zIndex);
  }
  get draggable(): boolean {
    return true;
  }
  get resizable(): boolean {
    return false;
  }
  get dragHandleClassName(): string {
    return 'modal-title';
  }
  get dragCancelClassName(): string {
    return 'modal-title-close';
  }
  get boundaryClassName(): string {
    return 'widget-slot-board';
  }
  get minWidth(): number {
    return 0;
  }
  get minHeight(): number {
    return 0;
  }
  get trackMode(): AgoraWidgetTrackMode {
    return AgoraWidgetTrackMode.TrackPositionOnly;
  }

  @bound
  updateToRemote(
    end: boolean,
    pos: Point,
    dimensions?: Dimensions | undefined,
    options?: TrackOptions | undefined,
  ): void {
    this.trackController?.updateRemoteTrack(end, pos, dimensions, options);
  }

  @bound
  updateToLocal(trackProps: AgoraWidgetTrack): void {
    this.trackController?.updateLocalTrack(trackProps);
  }

  @bound
  handleResize({ width, height }: { width: number; height: number }) {
    this.track.setRealDimensions({ width, height });
    this.track.reposition(false);
  }

  @bound
  handleClose() {
    this.widgetController.broadcast(AgoraExtensionWidgetEvent.WidgetBecomeInactive, this.widgetId);

    this.deleteWidget();
  }

  @bound
  setVisibility(visible: boolean) {
    this.track.setVisibility(visible);
  }

  get controlled() {
    return this.hasPrivilege;
  }

  addControlStateListener(cb: (controlled: boolean) => void) {
    this._controlStateCallbacks.push(cb);
  }

  removeControlStateListener(cb: (controlled: boolean) => void) {
    this._controlStateCallbacks = this._controlStateCallbacks.filter((c) => c !== cb);
  }

  fireControlStateChanged() {
    const controled = this.controlled;
    this._controlStateCallbacks.forEach((cb) => {
      cb(controled);
    });
  }
}
```


<a name ="rollbook"></a>
下面展示如何基于灵动课堂现有 Widget 能力创建一个课前点名的教具插件。完整源代码见 [rollbook-widget](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/feature/rollbook-widget)。

### 使用 AgoraEduToolWidget

创建一个继承 `AgoraEduToolWidget` 类的 `RollbookWidget` 类：

```ts
// src/gallery/rollbook/index.tsx
import { render, unmountComponentAtNode } from 'react-dom';
import { App } from './app';
import { AgoraEduToolWidget } from '../../common/edu-tool-widget';
import { observable, action, computed } from 'mobx';
import { AgoraWidgetController, EduRoleTypeEnum } from 'agora-edu-core';
import { AgoraExtensionWidgetEvent } from '@/infra/api';
import { SvgIconEnum } from '~ui-kit';
import { bound } from 'agora-rte-sdk';
/**
 * 点名册：
 * 老师可通过此插件知晓教室内学生参与情况
 */
export class RollbookWidget extends AgoraEduToolWidget {
    private _dom?: HTMLElement;
    @observable
    started: boolean = false;
    @observable
    checkInList: string[] = [];
    /**
     * 是否已签到
     */
    @computed
    get isCheckedIn() {
        const { userUuid } = this.classroomConfig.sessionInfo;
        return this.checkInList.includes(userUuid);
    }
    /**
     * 签到用户名列表
     */
    @computed
    get checkInUserNames() {
        return this.checkInList.map((userUuid) => {
            // 从UserStore中取出对应用户ID的用户名(此方法不适用于大班课班型)
            const user = this.classroomStore.userStore.studentList.get(userUuid);
            return user?.userName || 'Unknown';
        });
    }
    /**
     * 窗口初始宽度
     */
    get minWidth(): number {
        return 400;
    }
    /**
     * 窗口初始高度
     */
    get minHeight(): number {
        return 200;
    }

    /**
     * 全局唯一的 Widget 名称
     */
    get widgetName(): string {
        return 'rollbook'
    }

    /**
     * 控制 Widget 是否可控
     */
    get hasPrivilege(): boolean {
        return [EduRoleTypeEnum.teacher, EduRoleTypeEnum.assistant].includes(this.classroomConfig.sessionInfo.role);
    }

    get checkInPropKey() {
        const { userUuid } = this.classroomConfig.sessionInfo;
        const key = `checkIn-${userUuid}`;
        return key;
    }

    /**
     * Widget 节点已挂载
     * 此时可以在 DOM 节点进行自定义渲染
     */
    render(dom: HTMLElement): void {
        this._dom = dom;
        dom.style.width = '100%';
        dom.style.height = '100%';
        // 使用 React 渲染 UI 组件
        render(<App widget={this} />, dom);
    }

    /**
     * 卸载组件
     * 此时可以把相关资源释放掉
     */
    unload(): void {
        if (this._dom) {
            // 卸载 React 组件
            unmountComponentAtNode(this._dom);
        }
        this._dom = undefined;
    }

    onCreate(properties: any, userProperties: any): void {
        this._handlePropertiesChange(properties);
    }

    onPropertiesUpdate(properties: any): void {
        this._handlePropertiesChange(properties);
    }

    onInstall(controller: AgoraWidgetController) {
        // 将插件入口注册到工具箱
        controller.broadcast(AgoraExtensionWidgetEvent.RegisterCabinetTool, {
            id: this.widgetName,
            name: "Rollbook",
            iconType: SvgIconEnum.ANSWER,
        });
    }

    onUninstall(controller: AgoraWidgetController) {
        // 将插件入口从工具箱移除
        controller.broadcast(AgoraExtensionWidgetEvent.UnregisterCabinetTool, this.widgetName);
    }


    @action
    private _handlePropertiesChange(properties: any) {
        const list: string[] = [];
        Object.keys(properties.extra || {}).forEach((k) => {
            if (k.startsWith('checkIn-')) {
                const userUuid = k.replace('checkIn-', '');
                list.push(userUuid);
            }
        });
        this.checkInList = list;
        this.started = !!properties.extra?.started
    }

    /**
     * 学生点击签到，更新签到列表
     */
    @bound
    checkIn() {
        this.updateWidgetProperties({
            extra: {
                // 使用Key-Value方式可以以增量方式更新Widget
                [this.checkInPropKey]: true
            }
        });
    }

    /**
     * 老师点击开始签到，更新 Widget 状态
     */
    @bound
    startCheckIn() {
        this.setActive({ extra: { started: 1 } });
    }
}
```

### 增加渲染组件

增加一个 App 组件用于在插件窗口中渲染：

```ts
// src/gallery/rollbook/app.tsx
import React, { FC } from "react";
import { observer } from 'mobx-react';
import { ControlledModal } from "../../common/edu-tool-modal";
import { EduRoleTypeEnum } from "agora-edu-core";
import { RollbookWidget } from ".";
import { Button } from "~ui-kit";

/**
 * 点名册组件
 * @param param0
 * @returns
 */
export const App: FC<{ widget: RollbookWidget }> = ({ widget }) => {
    const view = () => [EduRoleTypeEnum.teacher, EduRoleTypeEnum.assistant].includes(widget.classroomConfig.sessionInfo.role) ? <TeacherView widget={widget} /> : <StudentView widget={widget} />
    return (
        <ControlledModal
            widget={widget}
            title="Rollbook"
            onCancel={widget.handleClose}
        >
            {view()}
        </ControlledModal>
    );
}

/**
 * 老师界面显示实际签到列表
 */
export const TeacherView: FC<{ widget: RollbookWidget }> = observer(({ widget }) => {
    const started = widget.started;
    return (
        <div>
            {started
                ?
                <React.Fragment>
                    <div>Check-In List:</div>
                    <ul>
                        {
                            widget.checkInUserNames.map((item, i) =>
                            (
                                <li key={i.toString()}>{item}</li>
                            ))
                        }
                    </ul>
                </React.Fragment>
                :
                <Button className="px-1" onClick={widget.startCheckIn}>Start Check-In</Button>
            }
        </div>
    );
});

/**
 * 学生显示签到按钮
 */
export const StudentView: FC<{ widget: RollbookWidget }> = observer(({ widget }) => {
    const isCheckedIn = widget.isCheckedIn;
    return (
        <div>
            <Button onClick={widget.checkIn} disabled={isCheckedIn}>{isCheckedIn ? 'Checked-In' : 'Check-In'}</Button>
        </div>
    );
});
```

### launch 中传入自定义的 Widget

通过 `launch` 中的 `widgets` 参数传入自定义 Widget：

```ts
const widgets = {
    // 需要引入上面定义的 RollbookWidget 类
    'rollbook': RollbookWidget
};
AgoraEduSDK.launch(dom, {
...
widgets: widgets
...
});
```

### 插件效果展示

启动教室，可以在工具箱中找到此插件，如图：

![](https://web-cdn.agora.io/docs-files/1664451141797)

老师点击并打开插件的界面效果：

![](https://web-cdn.agora.io/docs-files/1664451162107)

老师点击 **Start Check-In** 后，学生端显示插件的效果：

![](https://web-cdn.agora.io/docs-files/1664451174839)

学生点击 **Check-In** 后，老师端签到列表中显示此学生的效果：

![](https://web-cdn.agora.io/docs-files/1664451187164)
