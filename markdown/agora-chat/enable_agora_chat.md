使用 Agora 即时通讯前，你需要先在 [Agora 控制台](https://console.agora.io/#onboarding)开启并配置即时通讯服务。

## 前提条件

开启即时通讯服务前，请确保已经具备以下要素：

- 有效的 [Agora 开发者账号](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms#创建-agora-账号)。
- 已启用的鉴权方式为 **APP ID + Token (推荐)** 的 [Agora 项目](https://docs.agora.io/cn/Agora]Platform/get_appid_token?platform=AllPlatforms#创建-agora-项目)。
- 已订阅即时通讯套餐包，订阅方式参考[订阅即时通讯套餐包](./agora_chat_pricing?platform=All%20Platforms#订阅套餐包)。

## 开启即时通讯服务

按照以下步骤，在 Agora 控制台开启即时通讯服务：

1. 登录[控制台](https://sso2.agora.io/cn/)，点击左侧导航栏**项目管理**。

2. 选择需要开通即时通讯服务的项目，点击**配置**。
![](https://web-cdn.agora.io/docs-files/1642509377813)

3. 找到**实时互动拓展能力**模块的**即时通讯IM**，点击**启用**。
![](https://web-cdn.agora.io/docs-files/1642509441928)

   如果你未订阅套餐包，你会看到弹窗提示订阅套餐包，点击**订阅**进入套餐包订阅页面，订阅方式详见[订阅即时通讯套餐包](./agora_chat_pricing?platform=All%20Platforms#订阅套餐包)。

4. 仔细阅读弹窗提示，根据你的应用服务器所在区域选择即时通讯服务的数据中心，点击**启用**。成功开启即时通讯服务后，**启用**按钮会切换为**配置**按钮，用于配置即时通讯。

## 获取即时通讯项目信息

Agora 控制台会给每个开启即时通讯服务的项目分配以下项目信息：

- **OrgName**：Agora 即时通讯服务分配给每个企业（组织）的唯一标识。

- **AppName**：Agora 即时通讯服务分配给每个 app 的名称。同一企业（组织）下，AppName 唯一。

- **AppKey**：Agora 即时通讯服务分配给每个 app 的唯一标识。规则为 ${OrgName}#{AppName}。

- **数据中心**：针对不同的业务覆盖区域，Agora 提供多个数据中心选择。 目前包括以下区域：

  | 类型         | 名称                                        |
  | ------------ | ------------------------------------------- |
  | 国内数据中心 | 国内 1 区、国内 VIP 区。 |
  | 海外数据中心 | 新加坡 1 区、美东 1 区、德国 1 区。           |

  <div class="alert note"> 升级套餐包后，数据中心不变。 </div>

- **访问域名**：Agora 即时通讯服务分配的 WebSocket 和 RESTful API 请求地址域名。

按照以下步骤获取以上项目信息：

1. 在 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，找到已开启即时通讯服务的项目，点击**配置**。
2. 找到**实时互动拓展能力**模块的**即时通讯IM**，点击**配置**。
3. 在编辑项目页面，获取 OrgName、AppName、AppKey、数据中心、访问域名。

## 添加消息推送证书

发送消息推送前，需要配置各平台的推送证书。当前支持平台：华为、小米、OPPO、魅族、VIVO、苹果、谷歌 FCM。详见[设置消息推送](./agora_chat_push_android?platform=Android)。

开通即时通讯服务后，按照以下步骤添加消息推送证书：

1. 在 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，找到已开启即时通讯服务的项目，点击**配置**。
2. 找到**实时互动拓展能力**模块的**即时通讯IM**，点击**配置**。
3. 找到**消息推送**模块，点击**添加推送证书**。
![](https://web-cdn.agora.io/docs-files/1642509604977)
4. 在弹框内填写各平台消息推送所需的证书名称、密钥等信息。完成后点击**保存**。

## 添加消息回调地址

即时通讯提供消息回调服务，配置回调后，你的应用服务器会收到所选类型的消息和事件。详见[设置 HTTP 回调](./agora_chat_set_up_webhooks?platform=Android)。

开通即时通讯服务后，按照以下步骤添加消息回调地址：

1. 在 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，找到已开启即时通讯服务的项目，点击**配置**。
2. 在**编辑项目**页面的**实时互动拓展能力**模块找到**即时通讯IM**，点击**配置**。
3. 找到**实时消息回调**模块，点击**添加回调地址**。
![](https://web-cdn.agora.io/docs-files/1642509714974)
4. 在弹框内填写发送前回调或发送后回调所需信息，同一个项目下，规则名称唯一。完成后点击**保存**。