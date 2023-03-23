
##加入课堂相关的报错
###1、web端加入房间的时候接口报600001-1错误怎么办?登录教室的时候报401错误怎么办？
<img src="./images/launch_600001_1_error.png" style="zoom: 33%;" />

接口报401错误，一般是launch接口传入的rtmToken错误，或者appId和rtmToken不匹配

https://docs.agora.io/cn/agora-class/agora_class_api_ref_web?platform=Web#launch


<img src="./images/launch_rtm_token.png" style="zoom: 33%;" />

rtmToken一般推荐客户的后端生成，客户的前端调用后台生成的rtmToken使用。
生成器代码用例https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms#token-%E7%94%9F%E6%88%90%E5%99%A8%E4%BB%A3%E7%A0%81

临时生成测试的话可以使用这个工具https://webdemo.agora.io/token-builder/

###2.有客户遇到了这个错误"代码30409104详细信息：roomType conflict"。
<img src="./images/launch_error_002.png" style="zoom: 33%;" />

报错原因是：30409104：roomType conflict
此房间号已经创建了1v1。您不能再使用相同的房间编号创建一个小班。
同一个房间UUID被配置为不同的房间类型，从而导致房间类型冲突。建议不要重复使用每个房间的UUID，并且每个房间都应配置一个单独的房间类型。

其他相关错误码请参照：https://docs.agora.io/cn/agora-class/agora_class_restful_api?platform=All%20Platforms#%E5%93%8D%E5%BA%94%E7%8A%B6%E6%80%81%E7%A0%81