## DeviceSettingUIStore

`deviceSettingUIStore` 用于实现设备相关功能，包含获取摄像头设备信息、麦克风设备信息、扬声器设备等。

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

  /**
   * student tools
   * @returns
   */
  @computed
  get studentTools(): ToolbarItem[] {
    return [
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

## RosterUIStore

`RosterUIStore` 用于实现花名册相关功能，包括轮播、花名册学生列表、花名册功能按钮点击。

通过重写 `userList` 修改用户列表的排序

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

## EduUIStoreBase

所有UI Store都继承自 `EduUIStoreBase`，都拥有以下属性和方法：
#### uiOverrides
用于重写UI相关属性值
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