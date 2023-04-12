灵活课堂-教育场景中的白板模块是基于 [AgoraWidget](agora_class_widget_ios.md) 实现的，你可以通过将 widget 状态设置为活跃（active）或非活跃（inactive）来开启或关闭白板模块。

注：关闭白板模块后，白板上原有的内容将不再展示，画笔、文本和橡皮擦等绘图工具也不可使用。

### 代码实现
在灵动课堂-教育场景中，白板开启与关闭的实现如下所示：

注：以下的示例代码路径: `CloudClass-iOS/SDKs/AgoraEduUI/Classes/Components/Flat/FcrBoardUIComponent.swift`

1. 监听 Widget Activity

    ```swift
       // addWidgetActivityObserver
    	widgetController.add(self)
    
    ```

2. 当白板 Widget Activity 状态发生变化时，会触发 `onWidgetActive` 或 `onWidgetInactive` 回调。当监听到的状态为`active`时，通过创建白板 Widget 对象来实现开启白板；当监听到的状态为`inactive`时，通过销毁白板 Widget 对象来实现关闭白板

    ```swift
 	extension FcrBoardUIComponent: AgoraWidgetActivityObserver {
    	func onWidgetActive(_ widgetId: String) {
        	guard widgetId == BoardWidgetId else {
            	return
        	}
        	
        	initWidget()
    	}
    
    	func onWidgetInactive(_ widgetId: String) {
        	guard widgetId == BoardWidgetId else {
            	return
        	}
        	        
        	deinitWidget()
    	}
	}
    ```

