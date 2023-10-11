//TODO
- 同时还需要开通以下服务
    - RTM, [联系客服人员开通](https://www.shengwang.cn)
    - NCS, RTC频道事件回调通知, 处理人员进出/房间销毁逻辑
        - [开通消息通知服务
          ](https://docs.agora.io/cn/video-call-4.x/enable_webhook_ncs?platform=All%20Platforms)
            - 选择以下事件类型
                - channel create, 101
                - channel destroy, 102
                - broadcaster join channel, 103
                - broadcaster leave channel, 104
            - 回调地址
                - https://你的域名/v1/ncs/callback
            - 修改Secret
                - 根据配置界面提供的Secret值, 修改项目配置文件application.yml的ncs.secret
        - [频道事件回调
          ](https://docs.agora.io/cn/video-call-4.x/rtc_channel_event?platform=All%20Platforms)
    - 环信 IM，在环信 Console 控制台进行配置 [开通配置环信即时通讯 IM 服务](https://docs-im-beta.easemob.com/document/server-side/enable_and_configure_IM.html)