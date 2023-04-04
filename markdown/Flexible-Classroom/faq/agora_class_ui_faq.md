## Web 端如何更新房间背景颜色？

如果想修改教室背景，例如去掉黑色背景色，可修改 `packages/agora-classroom-sdk/src/infra/capabilities/containers/root-box/fixed-aspect-ratio.tsx` 文件中的代码。

背景色是通过以下代码设置的：

```tsx
<div className="flex bg-black justify-center items-center h-screen w-screen">
```

删除 `bg-black` 即可。更多自定义 UI 信息参考[自定义课堂 UI](agora_class_custom_ui_web#修改教室背景色)。

## Web 端如何更改白板背景颜色？

如需修改白板背景色，可修改 `packages/agora-plugin-gallery/src/gallery/whiteboard/style.css` 文件中的代码。

```tsx
.netless-whiteboard-wrapper {
height: 100%;
width: 100%;
border: 1px solid;
border-radius: 4px;
@apply bg-foreground border-divider;
background: #000; /* 这行设置白板颜色背景色为黑色 */
}
```

更多自定义 UI 信息参考[自定义课堂 UI](agora_class_custom_ui_web#修改白板背景色)。

## Web 端如何更改屏幕共享背景颜色？

在 `packages/agora-classroom-sdk/src/infra/capabilities/containers/screen-share/index.css` 中 `remote-screen-share-container` 下面一行增加以下代码即可：

```typescript
/* 覆盖屏幕共享背景样式 */
div {
  background-color: unset!important;
}
```

更多自定义 UI 信息参考[自定义课堂 UI](agora_class_custom_ui_web#修改屏幕共享背景颜色)。

## 如何修改白板宽高比例？

调整每个班型里白板的宽高比，可修改 `packages/agora-classroom-sdk/src/infra/stores/common/board/index.ts` 文件中的代码。灵动课堂会先按照 `packages/agora-classroom-sdk/src/infra/stores/common/share/index.ts` 中的 `viewportAspectRatio` 计算出整体教室区域的宽高, 再计算出白板容器的高度，最后根据白板占白板容器的比例 `heightRatio` 动态设置白板的大小。

如果你只想修改一对一场景中的白板高度，则可在 `packages/agora-classroom-sdk/src/infra/stores/one-on-one` 目录下新建 `board.ts` 文件。

更多自定义 UI 信息参考[自定义课堂 UI](agora_class_custom_ui_web#修改白板布局比例)。

## 如何在 UI 层获取角色信息

如果你想要获取用户角色（学生或老师），用于给不同角色显示不同的信息，可通过在 `packages/agora-classroom-sdk/src/infra/capabilities/containers/nav/index.tsx` 添加以下代码实现：

```typescript
export const NavigationBar = visibilityControl(observer(() => {
  const userRole = EduClassroomConfig.shared.sessionInfo.role;
 
 
  const { streamUIStore } = useStore();
  const { studentCameraStream, teacherCameraStream } = streamUIStore;
 
  return (
    <Header className="fcr-biz-header">
      <div className="header-signal">
        <SignalQuality />
 
      </div>
 
      <div>
        {userRole === EduRoleTypeEnum.teacher ?
        <div>{studentCameraStream?.stream.fromUser.userName}</div> :
         <div>{teacherCameraStream?.stream.fromUser.userName}</div>}
      </div>
 
      <div className="fcr-biz-header-title-wrap">
        <RoomState />
      </div>
      <div className="header-actions">
        <Actions />
        <ShareCard />
      </div>
    </Header>
  );
}), headerEnabled);
```

![](https://web-cdn.agora.io/docs-files/1680084369237)


如有更多需求，可[下载源码](agora_class_integrate_web)并参照[自定义课堂 UI](agora_class_custom_ui_web)进行修改定制。