灵动课堂中的白板模块是基于 AgoraWidget 实现的。如果你想在房间内开启或关闭白板功能，可通过设置 Widget 的状态（活跃或非活跃）实现。

## Desktop

调用 `WidgetUIStore` 中的 `setWidgetActive` 和 `setWidgetInactive`，并传入 `widgetId`，设置指定 Widget 的状态为活跃或非活跃。Widget 状态会被同步至远端。

通过 `WidgetUIStore` 中的 `activeWidgets` 获取所有处于活跃状态的 Widget。判断白板 Widget 是否处于活跃状态，然后添加渲染逻辑。示例代码如下：

```typescript
import { useStore } from '@/infra/hooks/use-edu-stores';
import { observer } from 'mobx-react';
import React from 'react';
import { WhiteboardContainer } from '../board';
import { ScreenShareContainer } from '../screen-share';

const BoardWidget = observer(() => {
  const { widgetUIStore } = useStore();
  // Get all active widgets
  // Check whether the whiteboard widget is active or not
  const isActive = widgetUIStore.activeWidgets.includes('netlessBoard');
  return (
    <React.Fragment>
      // If the whiteboard widget is active, render the whiteboard area
      {isActive ? (
        <WhiteboardContainer>
          <ScreenShareContainer />
        </WhiteboardContainer>
      ) : (
        // If the whiteboard widget is inactive, leave the whiteboard area empty
        <div className="w-full h-full"></div>
      )}
    </React.Fragment>
  );
});

export default BoardWidget;
```

## Android/iOS

通过 `AgoraWidgetContext` 的 `setWidgetActive` 和 `setWidgetInactive` 方法设置 Widget 的状态为活跃或非活跃。Widget 状态会被同步至远端。

通过 `AgoraWidgetContext.addWidgetActiveObserver` 监听指定 Widget 的状态。当该 Widget 状态变化后，SDK 会触发 `onWidgetActive` 或 `onWidgetInactive` 回调提示 Widget 状态变更。