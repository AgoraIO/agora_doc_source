1. 请参考[配置录制功能](agora_class_configure#%E9%85%8D%E7%BD%AE%E5%BD%95%E5%88%B6%E5%8A%9F%E8%83%BD)检查录制相关的配置是否正确，其中：
    - 录制配置 `recordingConfig` 如果没有设置，则自动采用默认配置。
    - 存储配置 `storageConfig` 必须配置正确，尤其是 `vendor`、`region` 和 `endpoint` 字段正确且匹配。例如，你使用的第三方云存储服务区域为上海，则你发起请求的应用服务器也必须位于上海，参考以下示例：
    ```
    "vendor": 2,
    "region": 1, //CN_Shanghai
    endpoint:https://agora-recording.oss-cn-shanghai.aliyuncs.com
    ```

2. 如果以上配置均正确依旧录制失败，请检查你使用的第三方云存储账号的公共读权限是否开启，详见[注意事项](agora_class_configure?platform=Web#%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9).

3. 如果录制配置正确，且已开启公共读权限，依旧录制失败录制，声网建议你通过拼接页面录制的 URL，在本地浏览器中调试出具体报错原因。

    1. 获取 Web 端调用 [`LaunchOption`](agora_class_api_ref_web#launchoption) 参数传入的录制页面的 URL `recordUrl` 的值 URL1。
    ![](https://web-cdn.agora.io/docs-files/1680084574886)
    
    2. 调用[查询录制列表](agora_class_restful_api#%E8%8E%B7%E5%8F%96%E5%BD%95%E5%88%B6%E5%88%97%E8%A1%A8) RESTful API，从响应参数 `webRecordUrlQuery` 中得到 URL2。

    3. 拼接 URL1 和 URL2，你就得到了页面录制的完整 URL，可以在本地通过浏览器访问该地址进行调试，如下图所示：
    ![](https://web-cdn.agora.io/docs-files/1680084623416)

    如果能正常打开，则录制开启成功；如无法打开，可根据报错查找原因。










