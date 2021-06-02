---
title: 创建和管理项目
platform: All Platforms
updatedAt: 2021-03-15 04:18:41
---
本页介绍如何在 Agora 控制台创建和管理项目。

> 角色为管理员/工程师的账户拥有查看项目管理页面的权限。

## 创建新项目

> 一个账户最多可创建 10 个项目，包括已删除的项目。如果需要创建更多项目，请通过工单系统申请。

创建新项目的步骤如下：

1. 登录控制台，点击左侧导航栏 ![](https://web-cdn.agora.io/docs-files/1551254998344) **项目管理**按钮进入[**项目管理**](https://dashboard.agora.io/projects)页面。


2. 在**项目管理**页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择一种**鉴权机制**（仅 App ID 或 App ID + App 证书 + Token）。

![](https://web-cdn.agora.io/docs-files/1574156194307)

> Agora 提供两种鉴权机制：仅 App ID 和 App ID + App 证书 + Token。鉴权机制的介绍详见[校验用户权限](/cn/Agora%20Platform/token)。我们推荐使用安全性更高的 Token 机制：
>
> - 在项目测试阶段，启用 App 证书后可以直接在控制台生成一个临时 token 进行测试。
> - 项目准备正式上线时，你需要在 Server 端部署一个 Token Generator 来生成正式 token。

4. 点击**提交**后，新建的项目就会显示在**项目管理**页中。Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

## 管理已创建的项目

对于已创建的项目，你还可以在**项目管理页**进行以下操作：

![](https://web-cdn.agora.io/docs-files/1574156398673)

- 查看项目基本信息，包括：

  - 项目阶段：测试中、已上线、未表明
  - 项目名称
  - 创建日期
  - App ID

- 点击 ![](https://web-cdn.agora.io/docs-files/1564048991389)，可生成**临时 Token**，用于项目测试阶段。 

- 点击 ![](https://web-cdn.agora.io/docs-files/1574156449172)，可在网页端即刻体验实时音视频通信。

- 查看项目用量。

- 编辑项目信息，包括：

![](https://web-cdn.agora.io/docs-files/1574156503105)

### 启用 App 证书

如果你在创建项目时，选择 App ID 为鉴权机制，之后又想要升级为 App ID + App 证书 + Token，这时候你需要先启用 App 证书，然后才能获取 token。

启用 App 证书的步骤如下：

1. 在**项目管理**页面，点击目标项目的**编辑**按钮，进入**编辑项目**页面。
2. 找到 App 证书一栏，点击**启用**按钮。

![](https://web-cdn.agora.io/docs-files/1574156526581)

3. 仔细阅读关于 App 证书的提示后，点击“启用 App 证书”。

![](https://web-cdn.agora.io/docs-files/1574156538273)

4. 声网会给你发一封邮件，按照邮件中的提示进行确认，即可启用 App 证书。
5. 成功启用后， App 证书会显示在**编辑项目**页面。

