# 概览

License 为用户提供贴合 IoT、体制内教育、私有化部署等场景需求的计费解决方案。License 绑定音视频能力，让计费更精准透明，避免用户为不需要的功能付费。



## 使用流程

License 提供 OpenAPI 和 Console 两种使用途径，具体流程如下：

![](https://web-cdn.agora.io/docs-files/1659020375844)


### 前提条件

在开通并使用 License 前，确保你已完成以下操作：
- [注册账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms#%E6%B3%A8%E5%86%8C%E8%B4%A6%E5%8F%B7) 并在 [控制台的账号设置页面](https://console.agora.io/settings/company) 获取了 [CID](#cid)；
- [创建项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E9%A1%B9%E7%9B%AE) 并在 [控制台的项目管理页面](https://console.agora.io/projects) 获取了 [App ID](#app-id)。


### 申请

如需申请使用 License，联系 [声网销售](mailto:sales@agora.io) 并提供以下信息：
- [CID](#cid)
- [品类](#品类)
- [SKU](#sku)
- [有效期](#有效期)
- 申请数量
- 需要开启 License 的 App ID 列表
- 是否需要开启预分配功能

### (可选) 预分配

#### 配额

申请通过后，License 额度关联到 CID 下，用户可以使用 [配额接口](./agora_console_license_restapi#配额) 将 License 额度预分配给 CID 下的某个 App ID。如果不配额，则 CID 下的所有 App ID 共享 [PID](#pid) 的 License 额度，先到先得。

#### 查看配额

用户可以前往 [控制台的 License 页面](https://console.agora.io/license/usage) 或使用 [查询配额接口](./agora_console_license_restapi#查询配额) 查看 License 的分配情况。

### (可选) 预授权

#### 开启预授权

申请通过后，用户可以 [开启预授权功能](./agora_console_license_restapi#开启预授权)。该功能开启后，仅在白名单内的 LicenseKey 可以进行激活操作。
<div class="alert note">再次调用该接口即可关闭预授权功能。</div>

#### 添加预授权

用户可以使用 [上传预授权文件接口](./agora_console_license_restapi#上传预授权文件) 将 [LicenseKey](#licensekey) 批量添加至白名单，或使用 [增加单个预授权接口](./agora_console_license_restapi#增加单个预授权) 将单个 LicenseKey 添加至白名单。

#### 移除预授权

用户可以使用 [删除预授权接口](./agora_console_license_restapi#删除预授权) 移除部分白名单中的 LicenseKey。如需清空全部预授权设置，可使用 [清空预授权接口](./agora_console_license_restapi#清空预授权)。

#### 查询预授权

用户既可以 [查询单个 LicenseKey 的预授权设置](./agora_console_license_restapi#查询单个预授权)，也可以 [查询](./agora_console_license_restapi#查询预授权) 和 [导出](./agora_console_license_restapi#导出预授权) 全部预授权设置。

### 激活

完成预授权和预分配后，用户可以使用 [激活接口](./agora_console_license_restapi#激活) 传入 LicenseKey 将 License 关联设备或账号。用户可以前往 [控制台的 License 页面](https://console.agora.io/license/usage) 查看 License 的激活情况。
<div class="alert note">License 的有效期从激活开始计算。</div>

### 续期

#### 申请续期

如需续期 License，联系 [声网销售](mailto:sales@agora.io) 并提供以下信息：
- CID
- PID
- 数量

#### 激活续期

续期申请通过后，使用 [续期接口](./agora_console_license_restapi#续期) 为即将过期的 License 激活续期额度。

### 查询

开通 License 功能后，用户可以在控制台查看 License 的使用情况。具体步骤如下：

1. 登录 [控制台](https://console.agora.io/)。

2. 点击右上角的账号名，选择下拉菜单中的 **License**。

![](https://web-cdn.agora.io/docs-files/1658917397547)

3. 进入 **License** 页面后，你可以在 **用量查看** 和 **购买记录** 页签查看 License 的使用情况。

![](https://web-cdn.agora.io/docs-files/1659089165706)

![](https://web-cdn.agora.io/docs-files/1658918100541)




## 主要概念

### CID  
声网分配给每个企业 (组织) 的唯一标识。[注册账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms#%E6%B3%A8%E5%86%8C%E8%B4%A6%E5%8F%B7) 后，你可以在 [控制台](https://console.agora.io/settings/company) 的设置页面获取该字段。

### App ID  
声网分配给每个项目的唯一标识。[创建项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E9%A1%B9%E7%9B%AE) 后，你可以在 [控制台](https://console.agora.io/projects) 的项目管理页面获取该字段。

### SKU  
合同约定的 License 能力集，其中包含 License 能力 (音频、视频、音视频)、License 分钟数上限、 License 使用时间段。SKU 全局唯一。

### 品类
账号 License 或设备 License。

### 有效期
测试 License 有效期以月为单位，正式 License 有效期以年为单位。有效期从激活 License 开始计算。

### PID  
由 SKU、有效期、品类 (账号 License 或设备 License) 定义的 License 标识。License 申请通过后，你可以在 [控制台](https://console.agora.io/license/usage) 的 License 页面查看关联的 PID。无论 License 的申请数量，只要 SKU、有效期、品类不变，申请到的 License 额度均归属于同一个 PID。CID 是 License 额度关联的顶级维度，用户也可以将 PID 下的 License 额度分配给某个 App ID。

### LicenseKey
账号 ID 或设备 ID。用户为某个账号或设备激活 License 时，传入 LicenseKey 消耗一个 License。此外，用户可以执行预授权操作，仅在白名单中的 LicenseKey 可以通过校验激活 License。