# 云信令 SDK 合规使用说明

根据中国法律法规和监管部门规章要求，App 开发运营者（以下简称“开发者”或“您”）在提供网络产品服务时应尊重和保护最终用户个人信息，不得违法违规收集使用个人信息，保证和承诺个人信息处理行为获得最终用户的授权同意，遵循最小必要原则，并且应当采取有效的技术措施和组织措施，确保个人信息安全。

为帮助开发者在使用SDK的过程中更好地落实用户个人信息保护相关要求，避免出现侵害用户个人信息权益情形，上海兆言网络科技有限公司（以下简称“我们”）特制定本**云信令 SDK** 合规使用说明文档（以下简称“文档”）。



## 一、App 个人信息保护的合规要求

为保护 App 最终用户的个人信息，App 及 App 的开发者需要满足如下合规要求：

- App 开发者应该制定隐私政策，并在 App 界面中显著展示。

- App 隐私政策应该单独成文，而不是作为用户协议等文件中的一部分进行展示。

- App 隐私政策应该明示收集和使用个人信息的目的、方式和范围，并且确保隐私政策链接正常有效，易于访问和阅读。

- App 隐私政策应逐项说明 App 各项业务功能以及对应收集的个人信息类型，不应使用“等、例如” 等方式概括说明。

- App 隐私政策应显著标识个人敏感信息类型（如：字体加粗等）。

- App 隐私政策应逐项说明调用的第三方 SDK，包括明示 SDK 名称、SDK 开发者名称；SDK 收集和处理的个人信息类型、目的、方式、范围；SDK 隐私政策链接。



## 二、App 使用云信令 SDK 时的合规指引

### 1. SDK 所需的系统权限的说明

云信令 SDK 功能和服务无需获取 App 权限。SDK 只会检查 App 是否接入网络，并不会主动向最终用户申请权限。

### 2. SDK 初始化及业务功能调用时机说明

您应确保在登录注册页面及 App 首次运行时，通过简洁、明显且易于访问方式向最终用户告知涵盖个人信息处理主体、处理目的、处理方式、处理类型、保存期限等内容的 App 个人信息处理规则（App 隐私政策）。

您应确保在最终用户同意 App 隐私政策后，再进行云信令SDK的初始化。并且，在用户同意隐私政策前，您应避免动态申请涉及用户个人信息的敏感设备权限；也应避免私自采集和上报个人信息。如果最终用户不同意 App 隐私政策，则不能初始化 SDK，无法使用 SDK 功能。

**SDK 初始化和相关功能配置，请查阅配置文档：**

- Android: [快速跑通示例项目](https://docportal.shengwang.cn/cn/Real-time-Messaging/rtm_android_run?platform=Android)
- iOS: [快速跑通示例项目](https://docportal.shengwang.cn/cn/Real-time-Messaging/run_rtm_ios?platform=iOS)

**云信令 SDK 功能及接口配置方式及示例说明：**

#### 业务功能：启用云信令服务

**(1) Android 系统**

- **相关个人信息**：设备品牌、设备型号、操作系统版本、CPU 信息、内存使用情况、IP 地址、网络接入方式和类型、频道内用户 ID
- **配置方式及示例**：
    - **配置开始示例**：
        ```java
        abstract void io.agora.rtm.RtmClient.login(
            // token：在服务端生成的用于鉴权的动态密钥
            @Nullable String token,
            // userId：用户名
            @NonNull String userId,
            // resultCallback：执行结果的回调通知
            @Nullable ResultCallback< Void > resultCallback
        )
        ```
    - **配置关闭示例**：
    ```java
    // resultCallback：执行结果的回调通知
    abstract void io.agora.rtm.RtmClient.logout(
        @Nullable ResultCallback< Void > resultCallback
    )
    ```    
- **时机**：加入或退出服务时

**(2) iOS 系统**

- **相关个人信息**：设备品牌、设备型号、操作系统版本、CPU 信息、内存使用情况、IP 地址、网络接入方式和类型、频道内用户 ID
- **配置方式及示例**：
    - **配置开始示例**：
        ```objc
        // token：在服务端生成的用于鉴权的动态密钥
        // userId：用户名
        // completion：执行结果的回调通知
        - (void)loginByToken:(NSString *_Nullable)token user:(NSString *_Nonnull)userId completion:(AgoraRtmLoginBlock _Nullable)completionBlock
        ```
    - **配置关闭示例**：
        ```objc
        // completion：执行结果回调通知
        -(void)logoutWithCompletion:(AgoraRtmLogoutBlock _Nullable)completionBlock
        ```
- **时机**：加入或退出服务时


#### 业务功能：发送消息

**(1) Android 系统**

- **相关个人信息**：设备品牌、设备型号、操作系统版本、CPU 信息、内存使用情况、IP 地址、网络接入方式和类型、频道内用户 ID
- **配置方式及示例**：
    - **配置开始、关闭示例**：
        ```java
        abstract void io.agora.rtm.RtmChannel.sendMessage(
            // message：消息载体
            RtmMessage message,
            SendMessageOptions options,
            // resultCallback：执行结果的回调通知
            ResultCallback< Void > resultCallback
        )
        ```
- **时机**：发送消息时

**(2) iOS 系统**

- **相关个人信息**：设备品牌、设备型号、操作系统版本、CPU 信息、内存使用情况、IP 地址、网络接入方式和类型、频道内用户 ID
- **配置方式及示例**：
    - **配置开始、关闭示例**：
        ```objc
        // message：消息载体
        // completion：执行结果的回调通知
        -(void)sendMessage:(AgoraRtmMessage *_Nonnull)message completion:(AgoraRtmSendChannelMessageBlock _Nullable)completionBlock
        ```
- **时机**：发送消息时


### 3. SDK 隐私政策披露要求与示例说明

请您根据集成云信令 SDK 的实际情况，在您的 App 隐私政策中披露：第三方 SDK 名称、SDK 公司名称、SDK 使用目的和功能场景、SDK 涉及个人信息类型、实现 SDK 功能所需的权限、SDK 隐私政策链接。

请在您的 App 隐私政策中，以文字或列表的方式向公众披露第三方 SDK 的相关信息。

第三方 SDK 披露示例（仅供参考）：

**(1) Android 示例**

- **SDK 名称**：云信令 SDK
- **SDK 公司名称**：上海兆言网络科技有限公司
- **SDK 使用目的和功能场景**：提供云信令实时互动功能和服务
- **SDK 涉及的个人信息类型**：设备品牌、设备型号、操作系统版本、CPU 信息、内存使用情况、IP 地址、网络接入方式和类型、频道内用户 ID
- **实现 SDK 功能所需权限**：无
- **SDK 隐私政策链接**：https://www.shengwang.cn/SDK-privacy-policy/

**(2) iOS 示例**

- **SDK 名称**：云信令SDK
- **SDK 公司名称**：上海兆言网络科技有限公司
- **SDK 使用目的和功能场景**：提供云信令实时互动功能和服务 
- **SDK 涉及的个人信息类型**：设备品牌、设备型号、操作系统版本、CPU 信息、内存使用情况、IP 地址、网络接入方式和类型、频道内用户 ID
- **实现 SDK 功能所需权限**：无
- **SDK 隐私政策链接**：https://www.shengwang.cn/SDK-privacy-policy/


### 4. 最终用户同意方式的建议方式说明

App 首次运行时应当有隐私弹窗，隐私弹窗中应公示隐私政策内容并附完整隐私政策链接，并明确提示最终用户阅读并选择是否同意隐私政策；隐私弹窗应提供同意按钮和拒绝同意的按钮，并由最终用户主动选择。


### 5. 最终用户行使权利的配置说明

开发者在其 App 中集成云信令 SDK 后，SDK 的正常运行会收集和处理必要的最终用户的个人信息用于提供云信令实时互动功能和服务的目的。

SDK 提供以下接口配置，以便您帮助最终用户实现其个人信息权利的请求。在最终用户撤销同意处理其个人信息的授权时，您可以通过调用接口，停止和关闭 SDK 功能，并停止收集相应的用户数据。

App 开发者应根据相关法律法规为最终用户提供行使个人信息主体权利的路径功能， 需要云信令 SDK 配合的，请与 SDK 及时进行联系。

相关配置操作，请查阅相关配置文档：

- Android: 
    - [集成云信令 SDK](https://docportal.shengwang.cn/cn/Real-time-Messaging/rtm_android_run?platform=Android#3-%E9%9B%86%E6%88%90%E5%A3%B0%E7%BD%91-sdk)
    - [释放云信令 SDK 资源](https://docportal.shengwang.cn/cn/Real-time-Messaging/rtm_integration_bp?platform=Android#%E5%8F%8A%E6%97%B6%E9%87%8A%E6%94%BE%E4%B8%8D%E9%9C%80%E8%A6%81%E7%9A%84%E8%B5%84%E6%BA%90)
- iOS: 
    - [集成云信令 SDK](https://docportal.shengwang.cn/cn/Real-time-Messaging/run_rtm_ios?platform=iOS#3-%E9%9B%86%E6%88%90%E5%A3%B0%E7%BD%91-sdk)
    - [释放云信令 SDK 资源](https://docportal.shengwang.cn/cn/Real-time-Messaging/rtm_integration_bp?platform=iOS#%E5%8F%8A%E6%97%B6%E9%87%8A%E6%94%BE%E4%B8%8D%E9%9C%80%E8%A6%81%E7%9A%84%E8%B5%84%E6%BA%90)



## 三、合规文件指引

1. [《个人信息保护法》](http://www.npc.gov.cn/npc/c30834/202108/a8c4e3672c74491a80b53a172bb753fe.shtml)

2. [《工业和信息化部关于开展信息通信服务感知提升行动的通知》](http://www.gov.cn/zhengce/zhengceku/2021-11/06/content_5649420.htm)

3. [《工业和信息化部关于开展纵深推进 App 侵害用户权益专项整治行动的通知》](http://www.gov.cn/zhengce/zhengceku/2020-08/02/content_5531975.htm)

4. [《工业和信息化部关于开展 App 侵害用户权益专项整治工作的通知》](http://www.gov.cn/xinwen/2019-11/07/content_5449660.htm)

5. [《App 违法违规收集使用个人信息行为认定方法》](http://www.cac.gov.cn/2019-12/27/c_1578986455686625.htm)

6. [《App 违法违规收集使用个人信息自评估指南》](https://www.tc260.org.cn/upload/2020-07-22/1595396892533085831.pdf)

7. [《常见类型移动互联网应用程序必要个人信息范围规定》](http://www.gov.cn/zhengce/zhengceku/2021-03/23/content_5595088.htm)

8. [《GB/T 35273-2020信息安全技术 个人信息安全规范》](http://c.gb688.cn/bzgk/gb/showGb?type=online&hcno=4568F276E0F8346EB0FBA097AA0CE05E)

9. [《网络安全标准实践指南—移动互联网应用程序（App）使用软件开发工具包（SDK）安全指引》](https://www.tc260.org.cn/front/postDetail.html?id=20201126161240)



## 四、联系方式

我们设立了专门的个人信息保护团队和负责人, 如果您和/或最终用户对本规则或个人信息保护相关事宜有疑问或投诉、建议时, 可以通过以下方式与我们联系：[privacy@shengwang.cn](mailto:privacy@shengwang.cn)。

我们将尽快审核所涉问题, 并在15个工作日或法律法规规定的期限内予以反馈。