---
title: 开启和配置互动白板服务
platform: Android
updatedAt: 2021-03-31 09:00:54
---

使用 Agora 互动白板服务前，你需要先在 [Agora 控制台](https://console.agora.io/#onboarding)开启并配置互动白板服务。

## 前提条件

使用 Agora 控制台前，请确保你已拥有有效的 Agora 开发者账号。

你可根据自身情况，参考下表完成 Agora 账号注册。

| 账号拥有情况                                                         | 操作                                                                                                                      |
| :------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| 无 Netless 账号，也无 Agora 开发者账号                               | 参考[注册与登录](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up?platform=AllPlatforms)注册 Agora 开发者账号。 |
| 已有 Netless 账号，无 Agora 开发者账号                               | 你可以使用 Netless 账号登录 Agora 控制台，点击**发送邮件**，然后通过邮件重置密码。                                        |
| 已有 Netless 账号和 Agora 开发者账号，且与两个账号绑定的验证邮箱一致 | 你可以登录 Agora 控制台，根据弹窗提示，点击**迁移**，Agora 会自动完成 Netless 账号和项目的迁移。                          |

## 开启互动白板服务

按照以下步骤，在 Agora 控制台开启互动白板服务：

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏的**项目管理**。

2. 在**项目管理**页面，选择需要开通互动白板服务的项目，点击**编辑**。
   > 如果尚未创建项目，你可以参考[创建和管理项目](https://docs.agora.io/cn/AgoraPlatform/manage_projects?platform=AllPlatforms)创建新项目。
3. 在**编辑项目**页面，找到**白板**，点击**开启**。
4. 仔细阅读弹窗提示，点击**确认**。
   成功开启互动白板后，**开启**按钮会切换为**配置**按钮，你可以点击配置白板服务。

## 获取互动白板项目的基本信息

### 获取 App Identifier

Agora 会给每个开启了互动白板服务的项目分配一个 `App Identifier` 作为白板项目唯一标识。在初始化白板 SDK 时，需要传入 `App Identifier`。

参照以下步骤获取互动白板项目的 `App Identifier`：

1. 在 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，选择已开启互动白板服务的项目，点击**编辑**。

2. 在**编辑项目**页面，找到**白板**，点击**配置**。

3. 在**白板配置**页面，找到 **AppIdentifier**，点击其右侧的眼睛图标，复制并自行保存白板项目的 `App Identifier`。
   ![img](https://confluence.agoralab.co/download/attachments/724799345/%E8%8E%B7%E5%8F%96%20App%20Identifier.png?version=1&modificationDate=1616479142269&api=v2)

### 获取 AK 和 SK

Agora 会给每个互动白板项目分配一组访问密钥对 `AK （Access Key）`和 `SK (Secrect Key）`，用于生成 `SDK Token`。

参照以下步骤获取互动白板项目的 AK 和 SK：

1. 在 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，选择已开启互动白板服务的项目，点击**编辑**。
2. 在**编辑项目**页面，找到**白板**，点击**配置**。
3. 在**白板配置**页面，找到 **AK** 和 **SK**，点击其右侧的眼睛图标，复制并自行保存白板项目的 **AK** 和 **SK**。
   ![img](https://confluence.agoralab.co/download/attachments/724799345/%E5%A4%8D%E5%88%B6%20AK%20%E5%92%8C%20SK.png?version=1&modificationDate=1616479635301&api=v2)

<div class="alert note">访问密钥对一旦泄露，会造成严重的安全问题。为提高项目的安全性，Agora 建议：

- 绝对不要将访问密钥对发送给客户端，也不要将它们写死在代码里。确保只有业务服务器能从配置文件中读取访问密钥对。
- 如果访问密钥对有泄露的风险，请及时联系互动白板技术支持重新生成访问密钥对。</div>

### 获取 SDK Token

为提高项目的安全性，Agora 使用 `AK` 和 `SK` 生成的 [SDK Token（动态密钥）](https://confluence.agoralab.co/pages/viewpage.action?pageId=719455830#id-5.1互动白板Token-SDKToken)对用户进行鉴权。// TODO 加链接

为方便测试，你可以在 Agora 控制台生成 `SDK Token`，步骤如下：

1. 进入 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，选择已开通互动白板服务的项目，点击**编辑**。

2. 在**编辑项目**页面，找到**白板**，点击**配置**。

3. 在**白板配置**页面，点击**生成 sdkToken**，Agora 控制台会生成一个 `admin` 角色且永久有效的 `SDK Token`。
   ![img](https://confluence.agoralab.co/download/attachments/724799345/%E7%94%9F%E6%88%90%20SDKToken.png?version=1&modificationDate=1616479816458&api=v2)

4. 仔细阅读弹窗提示，点击**复制 sdkToken** 并妥善保管。

<div class="alert note">该方法生成的 SDK Token 权限级别很高，请勿将该 Token 下发给客户端，否则会有泄露的风险。</div>

在生产环境中，你需要在 app 服务端通过以下方式生成 `SDK Token`：

- 在 app 服务端用代码生成 SDK Token，详见[服务端生成 Token](https://confluence.agoralab.co/pages/viewpage.action?pageId=713688237)。（推荐）// TODO 加链接
- 调用互动白板服务端 RESTful API 生成 SDK Token，详见[生成 SDK Token （POST）](https://confluence.agoralab.co/pages/viewpage.action?pageId=711052694#id-4.1互动白板服务端RESTfulAPI-生成SDKToken（POST）postsdktoken)。// TODO 加链接

## 开启互动白板配套服务

Agora 互动白板服务端提供以下配套服务：

- [文档转换](https://confluence.agoralab.co/pages/viewpage.action?pageId=719455841)（包括文档转图片和文档转网页）// TODO 加链接

当你使用 Agora 文档转换服务时，Agora 会收取相应费用。详见[计费说明](https://confluence.agoralab.co/pages/viewpage.action?pageId=721397156)。// TODO 加链接

- [截图](https://confluence.agoralab.co/pages/viewpage.action?pageId=711052694#id-4.1互动白板服务端RESTfulAPI-截图管理)// TODO 加链接

参考以下步骤开启相应服务并配置存储空间：

1. 进入 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，选择已开通互动白板服务的项目，点击**编辑**。

2. 在**编辑项目**页面，找到**白板**，点击**配置**，进入**白板配置**页面。

3. 在**配套服务**下旋转**文档转图片**、**文档转网页**或**截图**，勾选**开启**。
   ![img](https://confluence.agoralab.co/download/attachments/724799345/%E5%BC%80%E5%90%AF%E6%96%87%E6%A1%A3%E8%BD%AC%E5%9B%BE%E7%89%87.png?version=1&modificationDate=1616480799922&api=v2)

4. 点击**存储**方框右侧的箭头，在下拉列表中选择存储空间：

   - **default - white-cn-doc-convert**：Agora 互动白板提供的默认存储空间。
   - **已添加的存储空间**：如果你已经添加存储空间，可以直接在列表中选择。
   - **新增存储配置**：如果你不想使用默认的存储空间，且尚未添加自己的存储空间，可以参考步骤 5 新增存储空间。

   ![img](https://confluence.agoralab.co/download/attachments/724799345/%E5%AD%98%E5%82%A8%E4%B8%8B%E6%8B%89%E5%88%97%E8%A1%A8.png?version=2&modificationDate=1616481459752&api=v2)

5. 点击新增存储配置，根据界面提示填写存储空间的信息：
   - **供应商**：（必填）目前 Agora 支持[阿里云](https://www.aliyun.com/product/oss)（推荐）、[七牛云](https://www.qiniu.com/products/kodo)和 [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1) 对象存储服务（OSS）。
   - **区域**：（必填）创建 Bucket 时指定的数据中心所在区域。
   - **accessKey**：（必填）OSS 供应商提供的访问密钥中的 `Access Key`，用于 OSS 供应商识别访问者的身份。
   - **secretKey**：（必填）OSS 供应商提供的访问密钥中的 `Secret Key`，用于验证签的密钥。
   - **bucket**：（必填）存储空间名称。
   - **存储路径**：资源在存储空间中的存放路径，默认为根目录。
   - **外链域名**：OSS 对外服务的访问域名。如果使用七牛云 OSS，该字段为必填，否则 Agora 将无法访问该存储服务内的资源。

  <div class="alert note">
	 <li>关于如何获取存储空间的配置信息，详见你所使用的 OSS 供应商的官方文档。</li>
   <li>你添加的存储空间应开启**公共读**或以上权限，以确保你的 app 客户端可以访问其中的文件。</li>
</div>

6. 点击**保存**，仔细阅读弹窗提示后点击**确定**。
