灵动课堂中的白板模块是基于 [AgoraWidget](agora_class_widget_ios) 实现的，你可以通过将 widget 状态设置为活跃（active）或非活跃（inactive）来开启或关闭白板模块。

关闭白板模块后，铅笔、文本框、形状和橡皮擦等绘图工具将不再可用，用户也不能在白板上显示课件，上传或删除课程文件。弹出式测验、倒计时和屏幕共享等其他不依赖白板的功能不会受到影响。


在教育场景下灵动课堂中，白板开启与关闭的实现逻辑位于 `CloudClass-iOS/SDKs/AgoraEduUI/Classes/Components/Flat/FcrBoardUIComponent.swift` 文件中，内容如下：

1. 监听 Widget Activity

    ```swift
       // addWidgetActivityObserver
    	widgetController.add(self)
    
    ```

2. 当白板 Widget Activity 状态发生变化时，会触发 `onWidgetActive` 或 `onWidgetInactive` 回调。当监听到的状态为 `active` 时，通过创建白板 Widget 对象来实现开启白板；当监听到的状态为 `inactive` 时，通过销毁白板 Widget 对象来实现关闭白板

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

