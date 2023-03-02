1、web端加入房间的时候接口报600001-1错误怎么办?登录教室的时候报401错误怎么办？
<img src="./images/launch_600001_1_error.png" style="zoom: 33%;" />

接口报401错误，一般是launch接口传入的rtmToken错误，或者appId和rtmToken不匹配

https://docs.agora.io/cn/agora-class/agora_class_api_ref_web?platform=Web#launch


<img src="./images/launch_rtm_token.png" style="zoom: 33%;" />

rtmToken一般推荐客户的后端生成，客户的前端调用后台生成的rtmToken使用。
生成器代码用例https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms#token-%E7%94%9F%E6%88%90%E5%99%A8%E4%BB%A3%E7%A0%81

临时生成测试的话可以使用这个工具https://webdemo.agora.io/token-builder/


