使用即时通讯 IM 前，你需要在[声网控制台](https://console.agora.io/) 开启并配置即时通讯服务。

## 前提条件

开启即时通讯服务前，请确保已经具备以下条件：

- 有效的[声网开发者账号](./AgoraPlatform/get_appid_token?platform=AllPlatforms#创建声网账号)。
- 已启用的鉴权方式为 **APP ID + Token (推荐)** 的[声网项目](./AgoraPlatform/get_appid_token?platform=AllPlatforms#创建声网项目)。
- 已订阅即时通讯套餐包。关于如何订阅即时通讯套餐包，详见[订阅即时通讯套餐包](./agora_chat_pricing?platform=All%20Platforms#订阅套餐包)。

## 开启即时通讯 IM 服务

参考以下步骤，在声网控制台开启即时通讯服务：

1. 登录[声网控制台](https://console.agora.io/)，点击左侧导航栏 **项目管理**。

2. 选择需要开通即时通讯服务的项目，点击 **配置**。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

3. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

   如果你未订阅套餐包，你会看到弹窗提示订阅套餐包，点击 **订阅** 进入套餐包订阅页面。关于如何订阅套餐包，详见[订阅即时通讯套餐包](./agora_chat_pricing?platform=All%20Platforms#订阅套餐包)。

4. 仔细阅读弹窗提示，根据你的应用服务器所在区域选择即时通讯服务的数据中心，点击 **启用**。成功开启即时通讯服务后，**启用** 按钮会切换为**配置** 按钮，用于配置即时通讯。

## 获取即时通讯项目信息

声网控制台会给每个开启即时通讯服务的项目分配以下项目信息：

- **OrgName**：即时通讯服务分配给每个企业（组织）的唯一标识。

- **AppName**：即时通讯服务分配给每个应用的名称。每个企业（组织）的应用名称唯一。

- **AppKey**：即时通讯服务分配给每个应用的唯一标识。App Key 的生成规则为 `${OrgName}#{AppName}`。

- **数据中心**：针对不同的业务覆盖区域，即时通讯 IM 提供多个数据中心选择。

  | 类型         | 名称                                        |
  | ------------ | ------------------------------------------- |
  | 国内数据中心 | 国内 1 区、国内 VIP 区。 |
  | 海外数据中心 | 新加坡 1 区、美东 1 区和德国 1 区。           |

  <div class="alert note"> 国内的账号可以开通国内数据中心服务，若需开通海外数据中心服务请联系 [sales@agora.io](mailto:sales@agora.io)。<br/>升级套餐包后，数据中心不变。 </div>

- **访问域名**：即时通讯服务分配的 WebSocket 和 RESTful API 请求地址域名。

参考以下步骤获取上述项目信息：

1. 在声网控制台的[项目管理](https://console.agora.io/projects) 页面找到已开启了即时通讯服务的项目，点击 **配置**。
2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。
3. 在**基本信息** > **应用信息**页面，获取 **OrgName**、**AppName**、**AppKey**、**数据中心**和**访问域名**。

## 添加消息推送证书
 
发送消息推送前，需要配置各平台的推送证书。当前支持平台：苹果、谷歌 FCM、华为、小米、OPPO、魅族和 VIVO。详见[设置消息推送](./agora_chat_push_android?platform=Android)。 

开通即时通讯服务后，按照以下步骤添加消息推送证书：

1. 在声网控制台的[项目管理](https://console.agora.io/projects) 页面，找到已开启即时通讯服务的项目，点击 **配置**。
2. 在**服务配置**页面，点击**即时通讯**中的**配置**链接。
3. 选择**功能配置** > **推送证书**，点击 **添加推送证书**。

![](./images/push/push_cert_add.png)

4. 在弹出的**添加推送证书**对话框内填写各平台消息推送所需的证书名称、推送密钥等信息，然后点击 **保存**。

## 添加消息回调地址

即时通讯提供消息回调服务，配置回调后，你的应用服务器会收到所选类型的消息和事件。详见[设置 HTTP 回调](./agora_chat_set_up_webhooks)。

1. 登录[声网控制台](https://console.agora.io/)，在项目管理页面找到你的项目，然后点击**配置**按钮。

2. 在**服务配置**页面找到 **即时通讯 IM**，点击 **配置**。

3. 在**功能配置** > **总览** 页面的 **消息功能** 区域开启 **消息回调**。

4. 在**功能配置** > **消息回调** 页面，单击 **添加回调规则**。

![](https://web-cdn.agora.io/docs-files/1681712126525)

   ![](./images/callback/callback_add_rule.png)

5. 在回调配置对话框中，填写回调相关配置信息，点击**保存**，完成回调配置。关于回调配置，详见[配置回调规则](./agora_chat_set_up_webhooks#配置回调规则)。

![](./images/callback/callback_add_predeliveryrule.png)