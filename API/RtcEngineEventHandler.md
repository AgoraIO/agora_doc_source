# [rtcEvent]


[rtcEvent] 接口类用于SDK向 App 发送回调事件通知，App 通过继承该接口类的方法获取 SDK 的事件通知。 

接口类的所有方法都有缺省（空）实现， app 可以根据需要只继承关心的事件。在回调方法中，app 不应该做耗时或者调用可能会引起阻塞的 API（如 SendMessage），否则可能影响 SDK 的运行。