## 概述

自 2.0.0 版起，灵动课堂桌面端使用 UI Store 和 Container 组件来实现业务功能。每种课堂类型对应一个 UI Store。`agora-classroom-sdk/src/infra/stores/` 目录下包含以下 UI Store：

-   1 对 1 互动教学：`agora-classroom-sdk/src/infra/stores/one-on-one/index.ts` 中的 `Edu1v1ClassUIStore`。
-   在线互动小班课：`agora-classroom-sdk/src/infra/stores/interactive/index.ts` 中的 `EduInteractiveUIClassStore`
-   互动直播大班课：`agora-classroom-sdk/src/infra/stores/lecture/index.ts` 中的 `EduLectureUIStore`

以上 UI Store 均继承自 `agora-edu-core` 提供的`EduClassroomUIStore`。`EduClassroomUIStore` 提供了所有的基础能力，包含灵动课堂各个 UI 组件模块对应的 Store。

`EduClassroomUIStore` 包含以下子 UI Store:

## EduShareUIStore

`EduShareUIStore` 提供通用且全局共享的 UI 相关属性和方法。你可以通过此对象实现显示 Toast 提示信息、弹出消息模态框、弹出错误提示框等功能。`EduShareUIStore` 可结合 `agora-classroom-sdk` 库中的 `ToastContainer` 组件用于实现通知提示功能；结合 `agora-classroom-sdk` 库中的 `DialogContainer` 组件用于实现显示模态框。

### 属性和方法

本节介绍 `EduShareUIStore` 提供的属性和方法。

#### dialogQueue

```typescript
dialogQueue: DialogType[] = [];
```

模态对话框列表，为 [DialogType](#dialogtype) 对象组成的数组。

#### classroomViewportSize

```typescript
classroomViewportSize = {
    width: 0,
    height: 0,
};
```

视口尺寸信息。

#### toastQueue

```typescript
toastQueue: ToastType[] = [];
```

提示框列表，为 [ToastType](#toasttype) 对象组成的数组。

#### addToast

```typescript
addToast(desc: string, type?: ToastTypeEnum)
```

添加一个提示框。

| 参数   | 描述                                               |
| :----- | :------------------------------------------------- |
| `desc` | 提示框描述。                                       |
| `type` | 提示框类型，详见 [ToastTypeEnum](#toasttypeenum)。 |

#### removeToast

```typescript
removeToast(id: string)
```

移除一个提示框。

| 参数 | 描述        |
| :--- | :---------- |
| `id` | 提示框 ID。 |

#### addDialog

```typescript
addDialog(category: DialogCategory, props?: any)
```

添加一个模态框。

| 参数       | 描述                                                 |
| :--------- | :--------------------------------------------------- |
| `category` | 模态框类型，详见 [DialogCategory](#dialogcategory)。 |

#### removeDialog

```typescript
removeDialog(id: string)
```

移除一个模态框。

| 参数 | 描述        |
| :--- | :---------- |
| `id` | 模态框 ID。 |

### EduShareUIStore 修改示例

#### 修改课堂内通知上限

当前所有班型都是默认最多同时出现三条通知。如果你想将大班课修改为可以最多出现五条通知，其余班型不变，则可在 `agora-classroom-sdk/src/infra/stores/lecture` 目录下新增 `share-ui.ts` 文件，在文件内定义一个`LectureShareUIStore` 类，继承于 `agora-edu-core` 中的 `EduShareUIStore`，然后重写 `addToast` 方法。示例代码如下：

```typescript
import {EduShareUIStore, ToastTypeEnum} from "agora-edu-core";
import {action} from "mobx";
import {v4 as uuidv4} from "uuid";

export class LectureShareUIStore extends EduShareUIStore {
    @action.bound
    addToast(desc: string, type?: ToastTypeEnum) {
        const id = uuidv4();
        this.toastQueue.push({id, desc, type});
        // do not show more than five toast messages
        if (this.toastQueue.length > 5) {
            this.toastQueue = this.toastQueue.splice(1, this.toastQueue.length);
        }
        return id;
    }
}
```

#### 自定义提示框 UI

如果你想将提示框 toast 宽度的最小值改为 300px，则可以找到`agora-classroom-sdk` 库中的`ToastContainer` 组件。该组件调用了`agora-scenario-ui-kit` 下的 `Toast` 组件。找到该组件的目录`agora-scenario-ui-kit/src/components/toast`，在 `index.css` 中修改 `toast { min-width: 300px; }` 即可。

## BoardUIStore

`BoardUIStore` 可结合 `agora-classroom-sdk` 库中的 `WhiteboardContainer` 组件用于实现白板相关功能，包含白板的挂载、卸载、连接、断开、重连、高度设置等。

### 属性和方法

本节介绍 `BoardUIStore` 提供的属性和方法。

#### classroomViewportSize

```typescript
get connectionLost(): boolean
```

白板连接中断。

#### readyToMount

```typescript
get readyToMount(): boolean
```

白板准备好挂载到 DOM。

#### setCollectorContainer

```typescript
set setCollectorContainer(collectorContainer: HTMLElement): void
```

设置白板课件最小化 DOM。
| 参数 | 描述 |
| :------- | :-------------------------------- |
| `collectorContainer` | 白板最小化后显示的 DOM 节点，用户可以点击此按钮后课件最大化。 |

```typescript
joinWhiteboard(): Promise<void>
```

连接白板。

#### joinWhiteboardWhenConfigReady

```typescript
joinWhiteboardWhenConfigReady(): void
```

等待白板配置就绪后连接白板。

#### leaveWhiteboard

```typescript
leaveWhiteboard(): Promise<void>
```

断开白板。

#### mount

```typescript
mount(dom: HTMLDivElement): Promise<void>
```

白板挂载到 DOM。
| 参数 | 描述 |
| :------- | :-------------------------------- |
| `dom` | 白板挂载的 DOM 节点。 |

#### rejoinWhiteboard

```typescript
rejoinWhiteboard(): Promise<void>
```

重连白板。

#### unmount

```typescript
unmount(): Promise<void>
```

白板卸载，销毁白板实例。

## boardUIStore 修改示例

#### 通过重写 `uiOverrides` 修改白板的比例

```typescript
import {BoardUIStore} from "agora-edu-core";

export class InteractiveBoardUIStore extends BoardUIStore {
    protected get uiOverrides() {
        return {
            ...super.uiOverrides,
            heightRatio: 0.819,
            aspectRatio: 0.461,
        };
    }
}
```

## CloudUIStore

`cloudUIStore` 可结合 `agora-classroom-sdk` 库中的 `PersonalResourcesContainer` 和 `PublicResourcesContainer` 组件用于实现课件管理相关功能，包含获取公共课件列表、上传课件、上传进度、获取个人课件列表、选中课件、删除个人课件、打开课件等。

### 修改云盘资源列表

```typescript
export class CloudUIStore extends EduUIStoreBase {
    /**
     * public resources list
     * @returns
     */
    get publicResources() {
        return this.classroomStore.cloudDriveStore.publicResources;
    }
    /**
     * personal resources list
     */
    @computed
    get personalResources() {
        return this.classroomStore.cloudDriveStore.personalResources;
    }

    /**
     * total number of personal resources
     */
    @computed
    get personalResourcesTotalNum() {
        return this.classroomStore.cloudDriveStore.personalResourcesTotalNum;
    }
}
```

## HandUpUIStore

`handUpUIStore` 可结合 `agora-classroom-sdk` 库中的 `HandsUpContainer` 组件用于实现举手上讲台相关功能，包含获取挥手用户列表、是否有用户在挥手、挥手用户数、学生上讲台、学生下讲台、学生挥手等功能。

## DeviceSettingUIStore

`deviceSettingUIStore` 用于实现设备相关功能，包含获取摄像头设备信息、麦克风设备信息、扬声器设备等。

## NavigationBarUIStore

`navigationBarUIStore` 用于实现导航栏相关功能，包含获取教室时间信息、教室状态、网络质量状态、顶部导航栏按钮列表等。

### 修改教室状态文字和颜色

```typescript
export class NavigationBarUIStore extends EduUIStoreBase {
    /**
     * text that shows on top center of navigation bar
     * @returns
     */
    @computed
    get classStatusText() {
        const duration = this.classTimeDuration || 0;

        if (duration < 0) {
            return `-- : --`;
        }
        switch (this.classState) {
            case ClassState.beforeClass:
                return `${transI18n("nav.to_start_in")}${this.formatCountDown(duration, TimeFormatType.Timeboard)}`;
            case ClassState.ongoing:
                return `${transI18n("nav.started_elapse")}${this.formatCountDown(duration, TimeFormatType.Timeboard)}`;
            case ClassState.afterClass:
                return `${transI18n("nav.ended_elapse")}${this.formatCountDown(duration, TimeFormatType.Timeboard)}`;
            default:
                return `-- : --`;
        }
    }

    /**
     * color of status text
     * @returns
     */
    @computed
    get classStatusTextColor() {
        switch (this.classState) {
            case ClassState.beforeClass:
                return "#677386";
            case ClassState.ongoing:
                return "#677386";
            case ClassState.afterClass:
                return "#F04C36";
            default:
                return undefined;
        }
    }
}
```

## ToolbarUIStore

`toolbarUIStore` 用于实现工具栏相关功能，包含选中工具、设置画笔粗细、获取老师工具栏列表等。

### 通过重写 teacherTools 和 studentTools，修改白板工具栏工具

```typescript
export class ToolbarUIStore extends EduUIStoreBase {
    /**
     * teacher tools
     * @returns
     */
    get teacherTools(): ToolbarItem[] {
        return [
            {
                value: "cloud",
                label: "scaffold.cloud_storage",
                icon: "cloud",
            },
            {
                value: "tools",
                label: "scaffold.tools",
                icon: "tools",
                category: ToolbarItemCategory.Cabinet,
            },
        ];
    }

    /**
     * student tools
     * @returns
     */
    @computed
    get studentTools(): ToolbarItem[] {
        return [
            ToolbarItem.fromData({
                value: "text",
                label: "scaffold.text",
                icon: "text",
            }),
            ToolbarItem.fromData({
                value: "eraser",
                label: "scaffold.eraser",
                icon: "eraser",
            }),
        ];
    }
}
```

## RosterUIStore

`rosterUIStore` 用于实现花名册相关功能，包括轮播、花名册学生列表、花名册功能按钮点击。

### 通过重写 `userList` 修改用户列表的排序

```typescript

  /**
   * students list
   * @returns
   */
  @computed
  get userList() {
    return super.userList.sort((a,b) => {
      return a.uid > b.uid ? 1 : 0;
    });
  }
```

### 所有 UI Store 都继承自 `EduUIStoreBase`，都拥有以下属性和方法：

#### uiOverrides

用于重写 UI 相关属性值

```typescript
get uiOverrides(): Record<string, any>
```

#### onInstall

用于在教室创建后执行的钩子函数

```typescript
onInstall(): void
```

#### onDestroy

用于在教室销毁后执行的钩子函数

```typescript
onDestroy(): void
```

## 类型定义

### DialogType

```typescript
export interface DialogType {
    id: string;
    category: DialogCategory;
    props?: any;
}
```

模态对话框信息。

| 参数       | 描述                                                     |
| :--------- | :------------------------------------------------------- |
| `id`       | 模态对话框 ID。                                          |
| `category` | 模态对话框类型，详见 [DialogCategory](#dialogcategory)。 |

### ToastType

```typescript
export interface ToastType {
    id: string;
    desc: string;
    type?: ToastTypeEnum;
}
```

| 参数   | 描述                                               |
| :----- | :------------------------------------------------- |
| `id`   | 提示框 ID。                                        |
| `desc` | 提示信息。                                         |
| `type` | 提示框类型，详见 [ToastTypeEnum](#toasttypeenum)。 |

### ToastTypeEnum

```typescript
export enum DialogCategory {
    CloudDriver,
    Roster,
    KickOut,
    ErrorGeneric,
    Confirm,
    DeviceSetting,
    ScreenPicker,
}
```

模态对话框类型。

| 参数            | 描述                   |
| :-------------- | :--------------------- |
| `CloudDriver`   | 云盘模态框。           |
| `Roster`        | 花名册模态框。         |
| `KickOut`       | 踢人模态框。           |
| `ErrorGeneric`  | 错误提示模态框。       |
| `Confirm`       | 确认模态框。           |
| `DeviceSetting` | 设备设置模态框。       |
| `ScreenPicker`  | 用于屏幕选择的模态框。 |

### ToastTypeEnum

```typescript
export type ToastTypeEnum = "success" | "error" | "warning";
```

提示框类型。

| 参数        | 描述         |
| :---------- | :----------- |
| `'success'` | 成功提示框。 |
| `'error'`   | 错误提示框。 |
| `'warning'` | 警告提示框。 |
