# boardUIStore

`boardUIStore` 可结合 `agora-classroom-sdk` 库中的 `WhiteboardContainer` 组件用于实现白板相关功能，包含白板的挂载、卸载、连接、断开、重连、高度设置等。

## 属性和方法

本节介绍 `boardUIStore` 提供的属性和方法。



    ```ts
    ...
    const {
      readyToMount,//是否准备好挂载
      mount,  //挂载
      unmount,//卸载
      rejoinWhiteboard,//重连
      connectionLost,//是否白板连接中断
      boardHeight,//白板高度
      joinWhiteboardWhenConfigReady,//等待白板配置就绪后连接白板
      leaveWhiteboard,//离开白板
    } = boardUIStore;

    useEffect(() => {
      //当白板配置就绪自动连接
      joinWhiteboardWhenConfigReady();
      return () => {
        leaveWhiteboard();
      };
    }, [leaveWhiteboard, joinWhiteboardWhenConfigReady]);
    ...
    return (
      ...
      {readyToMount ? <div ref={(dom) => {
        if (dom) {
          mount(dom);
        } else {
          unmount();
        }
      }}></div> : null}
      ...
      {connectionLost ? <button onClick={rejoinWhiteboard}>RejoinWhiteboard</button> : null}
      ...
      )
    ```

## 属性和方法

本节介绍 `EduShareUIStore` 提供的属性和方法。

### dialogQueue

```typescript
dialogQueue: DialogType[] = [];
```

模态对话框列表，为 [DialogType](#dialogtype) 对象组成的数组。

### classroomViewportSize

```typescript
classroomViewportSize = {
    width: 0,
    height: 0,
};
```

视口尺寸信息。

### toastQueue

```typescript
toastQueue: ToastType[] = [];
```

提示框列表，为 [ToastType](#toasttype) 对象组成的数组。

### addToast

```typescript
addToast(desc: string, type?: ToastTypeEnum)
```

添加一个提示框。

| 参数     | 描述                                                         |
| :------- | :-------------------------------- |
| `desc` | 提示框描述。 |
| `type` | 提示框类型，详见 [ToastTypeEnum](#toasttypeenum)。 |

### removeToast

```typescript
removeToast(id: string)
```

移除一个提示框。

| 参数     | 描述                                                         |
| :------- | :-------------------------------- |
| `id` | 提示框 ID。 |

### addDialog

```typescript
addDialog(category: DialogCategory, props?: any)
```

添加一个模态框。

| 参数     | 描述                                                         |
| :------- | :-------------------------------- |
| `category` | 模态框类型，详见 [DialogCategory](#dialogcategory)。 |

### removeDialog

```typescript
removeDialog(id: string)
```

移除一个模态框。

| 参数     | 描述                                                         |
| :------- | :-------------------------------- |
| `id` | 模态框 ID。 |

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

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `id` | 模态对话框 ID。 |
| `category` | 模态对话框类型，详见 [DialogCategory](#dialogcategory)。 |

### ToastType

```typescript
export interface ToastType {
  id: string;
  desc: string;
  type?: ToastTypeEnum;
}
```

| 参数     | 描述                                                         |
| :------- | :-------------------------------- |
| `id` | 提示框 ID。 |
| `desc` | 提示信息。 |
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

| 参数     | 描述                                                         |
| :------- | :------------------ |
| `CloudDriver` | 云盘模态框。 |
| `Roster` | 花名册模态框。 |
| `KickOut` | 踢人模态框。 |
| `ErrorGeneric` | 错误提示模态框。 |
| `Confirm` | 确认模态框。 |
| `DeviceSetting` | 设备设置模态框。 |
| `ScreenPicker` | 用于屏幕选择的模态框。 |

### ToastTypeEnum

```typescript
export type ToastTypeEnum = 'success' | 'error' | 'warning';
```

提示框类型。
| 参数     | 描述                                                         |
| :------- | :------------------ |
| `'success'` | 成功提示框。 |
| `'error'` | 错误提示框。 |
| `'warning'` | 警告提示框。 |

## 示例

### 修改课堂内通知上限

当前所有班型都是默认最多同时出现三条通知。如果你想将大班课修改为可以最多出现五条通知，其余班型不变，则可在 `agora-classroom-sdk/src/infra/stores/lecture` 目录下新增 `share-ui.ts` 文件，在文件内定义一个`LectureShareUIStore` 类，继承于 `agora-edu-core` 中的 `EduShareUIStore`，然后重写 `addToast` 方法。示例代码如下：

```typescript
import { EduShareUIStore, ToastTypeEnum } from 'agora-edu-core';
  import { action } from 'mobx'
  import { v4 as uuidv4 } from 'uuid';

  export class LectureShareUIStore extends EduShareUIStore {
  @action.bound
    addToast(desc: string, type?: ToastTypeEnum) {
      const id = uuidv4();
      this.toastQueue.push({ id, desc, type });
      // 提示框大于 5 个时移除多余的提示框
      if (this.toastQueue.length > 5) {
        this.toastQueue = this.toastQueue.splice(1, this.toastQueue.length);
      }
      return id;
    }
  }
```

### 自定义提示框 UI

如果你想将提示框 toast 宽度的最小值改为 300px，则可以找到`agora-classroom-sdk` 库中的`ToastContainer` 组件。该组件调用了`agora-scenario-ui-kit` 下的 `Toast` 组件。找到该组件的目录`agora-scenario-ui-kit/src/components/toast`，在 `index.css` 中修改 `toast { min-width: 300px; }` 即可。