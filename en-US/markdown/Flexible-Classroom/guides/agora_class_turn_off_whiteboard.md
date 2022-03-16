The whiteboard module in Flexible Classroom is implemented based on AgoraWidget. You can turn the whiteboard module on or off in the classroom by setting the widget state as active or inactive.

<div class="alert info">After disabling the whiteboard module, the drawing tools, including pencils, text boxes, shapes, and erasers will no longer be available. Users can neither display class files on the whiteboard. Other features, such as uploading or deleting class files, pop-up quiz, count-down timer, and screen sharing will not be affected.</div>

## Web/Electron

For the Web and Electron clients, implement the logic of turning on and off the whiteboard module as follows:

1. Create a new branch based on the [latest release branch](https://github.com/AgoraIO-Community/CloudClass-Desktop/tree/release/apaas/2.1.2/packages) in the CloudClass-Desktop repository.

2. To implement the logic of turning on and off the whiteboard module, add a `board-widget.tsx` file in the `packages/agora-classroom-sdk/src/ui-kit/capabilities/containers/widget` folder with the following code:

   ```tsx
   import { useStore } from '@/infra/hooks/use-edu-stores';
   import { observer } from 'mobx-react';
   import React from 'react';
   import { WhiteboardContainer } from '../board';
   import { ScreenShareContainer } from '../screen-share';
    
   const BoardWidget = observer(() => {
     const { widgetUIStore, boardUIStore } = useStore();
     const { widgetStore } = widgetUIStore.classroomStore;
     const { boardHeight } = boardUIStore;
     // Get all active widgets through the widgetStateMap property in widgetUIStore. Check whether the whiteboard widget is active or not and add rendering logic accordingly.
     const isActive = widgetStore.widgetStateMap['netlessBoard'];
     const [active, setActive] = React.useState(false);
    
     return (
       <React.Fragment>
         // Add a button for users to manually turn on or off the whiteboard in the classroom
         // Call setActive and setInactive and pass in the widgetId to set the widget state. The widget state will be synchronized to the remote clients.
         <button
           onClick={() => {
             if (active) {
               // Set the state of the whiteboard widget as inactive
               widgetStore.setInactive('netlessBoard');
             } else {
               // Set the state of the whiteboard widget as active
               widgetStore.setActive('netlessBoard', {});
             }
             setActive(!active);
           }}>
           Switch {active ? 'off' : 'on'}
         </button>
         // If the whiteboard widget is active, render the whiteboard area
         {isActive ? (
           <WhiteboardContainer>
             <ScreenShareContainer />
           </WhiteboardContainer>
         ) : (
           // If the whiteboard widget is inactive, customize your rendering logic
           <div className="relative w-full bg-white" style={{ height: boardHeight }}>
             <ScreenShareContainer />
             {/* Write your rendering logic here */}
           </div>
         )}
       </React.Fragment>
     );
   });
    
   export default BoardWidget;
   ```

3. To apply the logic of turning on and off the whiteboard module in a specific classroom type, edit the `index.tsx` file of a classroom type in the `/packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios` folder. For example, if you want to apply the logic of turning on and off the whiteboard module in a mid-size classroom, replace the `/packages/agora-classroom-sdk/src/ui-kit/capabilities/scenarios/mid-class/index.tsx` file with the following code:

   ```tsx
   import { Aside, Layout } from '~components/layout';
   import { observer } from 'mobx-react';
   import classnames from 'classnames';
   import { NavigationBarContainer } from '~containers/nav';
   import { DialogContainer } from '~containers/dialog';
   import { LoadingContainer } from '~containers/loading';
   import { ScreenShareContainer } from '~containers/screen-share';
   import Room from '../room';
   import { RoomMidStreamsContainer } from '~containers/stream/room-mid-player';
   import { CollectorContainer } from '~containers/board';
   import { WhiteboardContainer } from '~containers/board';
   import { FixedAspectRatioRootBox } from '~containers/root-box';
   import { ChatWidgetPC } from '~containers/widget/chat-widget';
   import { ExtAppContainer } from '~containers/ext-app';
   import { ToastContainer } from '~containers/toast';
   import { HandsUpContainer } from '~containers/hand-up';
   import { MidRosterBtn } from '../../containers/roster';
   // 1. Import the board widget you implement in the previous step
   import BoardWidget from '../../containers/widget/board-widget';
    
   export const MidClassScenario = observer(() => {
    
     const layoutCls = classnames('edu-room', 'mid-class-room');
    
     return (
       <Room>
         <FixedAspectRatioRootBox trackMargin={{ top: 27 }}>
           <Layout className={layoutCls} direction="col">
             <NavigationBarContainer />
             <RoomMidStreamsContainer />
             // 2. Comment out the old whiteboard container
             {/* <WhiteboardContainer>
               <ScreenShareContainer />
             </WhiteboardContainer> */}
             // 3. Use the board widget you implement in the previous step
             <BoardWidget />
             <Aside className="aisde-fixed">
               <CollectorContainer />
               <HandsUpContainer />
               <MidRosterBtn />
               <ChatWidgetPC />
             </Aside>
             <DialogContainer />
             <LoadingContainer />
           </Layout>
           <ExtAppContainer />
           <ToastContainer />
         </FixedAspectRatioRootBox>
       </Room>
     );
   });
   ```

## Android/iOS

For the Android and iOS clients of students, basically you need to monitor the whiteboard widget state change caused by the teacher's client and adjust the UI accordingly. Below takes an iOS project as an example. Generally speaking, you need to edit the `/SDKs/AgoraEduUI/AgoraEduUI/Classes/Components/FlatComponents/AgoraBoardUIController.swift` file.

1. Create a new branch based on the [latest release branch](https://github.com/AgoraIO-Community/CloudClass-iOS) in the CloudClass-iOS repository.

2. Add a function in the `AgoraBoardUIController.swift` file for destroying the board widget in `AgoraBoardUIController`, as follows:

   ```swift
   // MARK: - private
   private extension AgoraBoardUIController {
       ...
       func deinitBoardWidget() {
       self.boardWidget?.view.removeFromSuperview()
       self.boardWidget = nil
       contextPool.widget.remove(self,
                                 widgetId: netlessKey)
       }
       ...
   }
   ```

3. Add `contextPool.widget.add(self)` in the `init` function in `AgoraBoardUIController.swift` to register an observer for observing the whiteboard state change.

   ```swift
   init(context: AgoraEduContextPool) {
       super.init(nibName: nil, bundle: nil)
       contextPool = context
       view.backgroundColor = .clear
         
       contextPool.room.registerRoomEventHandler(self)
       contextPool.media.registerMediaEventHandler(self)
       // Monitor the state change of the whiteboard widget.
       contextPool.widget.add(self)
   }
   ```

4. When the state of the whiteboard widget changes, the SDK triggers the `onWidgetActive` or `onWidgetInactive` callback. Add logic in the `onWidgetActive` and `onWidgetInactive` callbacks. When the whiteboard state changes to active, render the whiteboard are; when the whiteboard state changes to inactive, call `deinitBoardWidget` to destroy the board widget.

   ```swift
   extension AgoraBoardUIController: AgoraWidgetActivityObserver {
       func onWidgetActive(_ widgetId: String) {
           guard widgetId == netlessKey else {
               return
           }
    
           initBoardWidget()
           joinBoard()
       }
    
       func onWidgetInactive(_ widgetId: String) {
           guard widgetId == netlessKey else {
               return
           }
    
           deinitBoardWidget()
       }
   }
   ```

## Reference

### AgoraWidgetContext

#### create

```swift
AgoraBaseWidget create(AgoraWidgetConfig config)
```

Creates a widget object.

Parameter:

- config: The initialization configurations of the widget object.

Return: An AgoraBaseWidget object.

#### setWidgetActive

```swift
void setWidgetActive(String widgetId,
                     String ownerUuid,
                     Map<String: Any> roomProperties,
                     AgoraWidgetFrame syncFrame,
                     Callback<Void> success,
                     Callback<Error> failure)
```

Sets the widget state as active.

Parameter:

- widgetId: The widget ID.
- ownerUuid: (Nullable) The ID of the user to whom the widget belongs. When the user goes offline, the `onWidgetInactive` callback will be triggered for the widgets owned by this user.
- roomProperties: (Nullable) The room properties related to the widget.
- syncFrame: (Nullable) The size and position of the widget.
- success: The method call succeeds.
- failure: The method call fails, the SDK returns an error.

#### setWidgetInactive

```swift
void setWidgetInactive(String widgetId,
                       Callback<Void> success,
                       Callback<Error> failure)
```

Sets the widget state as inactive.

Parameter:

- widgetId: The widget ID.
- roomProperties: (Nullable) The room properties related to the widget.
- success: The method call succeeds.
- failure: The method call fails, the SDK returns an error.

#### getWidgetActivity

```swift
Bool getWidgetActivity(String widgetId)
```

Gets the state of a specified widget.

Parameter:

- widgetId: The widget ID.

Return: Whether the widget is active or not.

#### getWidgetConfigs

```swift
Array<AgoraWidgetConfig> getWidgetConfigs()
```

Gets the configurations of all widgets.

Return: An array of the AgoraWidgetConfig objects.

#### getWidgetConfig

```swift
AgoraWidgetConfig getWidgetConfig(String widgetId)
```

Gets the configurations of a specified widget.

Parameter:

- widgetId: The widget ID.

Return: An AgoraWidgetConfig object.

#### addWidgetActiveObserver

```swift
AgoraWidgetError addWidgetActiveObserver(AgoraWidgetActiveObserver observer,
                                         String widgetId)
```

Registers an observer to observe the state of a specified widget. When the state of the widget changes, the SDK triggers a callback.

Parameter:

- observer: See AgoraWidgetActiveObserver.
- widgetId: The widget ID.

Return: When the widget ID is not valid, the SDK returns an error.

#### removeWidgetActiveObserver

```swift
AgoraWidgetError removeWidgetActiveObserver(AgoraWidgetActiveObserver observer,
                                            String widgetId)
```

Registers the observer of a specified widget.

Parameter:

- observer: See AgoraWidgetActiveObserver.
- widgetId: The widget ID.

Return: When the widget ID is not valid, the SDK returns an error.

### AgoraWidgetActiveObserver

#### onWidgetActive

```swift
void onWidgetActive(String widgetId)
```

Occurs when the widget state changes to active.

Parameter:

- widgetId: The widget ID.

#### onWidgetInactive

```swift
void onWidgetInactive(String widgetId)
```

Occurs when the widget state changes to inactive.

Parameter:

- widgetId: The widget ID.