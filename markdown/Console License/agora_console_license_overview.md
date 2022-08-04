# License 使用指南


本文档介绍如何使用声网的账号 License 和设备 License。


## 前提条件

在开通并使用 License 前，确保你已完成以下操作：
- [注册账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms#%E6%B3%A8%E5%86%8C%E8%B4%A6%E5%8F%B7) 并在 [控制台](https://console.agora.io/settings/company) 的账号设置页面获取 CID；
- [创建项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E9%A1%B9%E7%9B%AE) 并在 [控制台](https://console.agora.io/projects) 的项目管理页面获取了 App ID。


## 使用流程

License 提供 OpenAPI 和 Console 两种使用途径，具体流程如下：

![](https://web-cdn.agora.io/docs-files/1659432797810)


### 1. 申请

如需申请使用 License，联系 [声网销售](mailto:sales@agora.io) 并提供以下信息：

<table>
    <tr>
        <th>名称</th>
        <th>说明</th>
    </tr>
    <tr>
        <td>品类</td>
        <td>
            选择 License 的品类：
            <li>账号 License：绑定账号</li>
            <li>设备 License：绑定设备</li>
        </td>
    </tr>
    <tr>
        <td>企业 ID (CID)</td>
        <td>声网分配给每个企业 (组织) 的唯一标识。</td>
    </tr>
    <tr>
        <td>License 类型</td>
        <td>
            选择 License 的类型：
            <li>测试 License</li>
            <li>正式 License</li>
            <div class="alert note">Agora 建议你在初次使用时选用测试 License。</div>
        </td>
    </tr>
    <tr>
        <td>库存量单位 (SKU)</td>
        <td>设置 License 的能力集，包含以下参数：
            <ul>
            <li>产品：
                <ul>
                <li>实时音视频 (RTC)</li>
                <li>全链路加速 (FPA)</li>
                <li>媒体流加速 (RTSA)</li>
                </ul>
            <li>License 能力：
                <ul>
                <li>音频</li>
                <li>视频</li>
                <li>音视频</li>
                </ul>
            <li>License 分钟数上限：是否限制使用时长，精确到分钟</li>
            <li>License 使用时间段：是否限制使用时段，精确到分钟</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>有效期</td>
        <td>测试 License 的有效期以月为单位，最少 3 个月；正式 License 的有效期以年为单位，最少 1 年。
<div class="alert note">License 的有效期从激活开始计算。</div></td>
    </tr>
    <tr>
        <td>申请数量</td>
        <td>申请的 License 数量。</td>
    </tr>
    <tr>
        <td>启用 License 的项目 ID (App ID) 列表</td>
        <td>App ID 为声网分配给每个项目的唯一标识，从属于 CID。你可以为指定 App ID 启用 License 功能。</td>
    </tr>
    <tr>
        <td>是否开启预分配功能</td>
        <td>启用预分配后，你可以将 License 预分配给指定 App ID。如不启用预分配，则全部 App ID 共享 License 额度。</td>
    </tr>
    <tr>
        <td>是否设置最高同时在线人数 (PCU) 限制</td>
        <td>启用 PCU 限制后，你可以限制 CID 或 App ID 维度上同时接入 SDK 的最大人数。</td>
    </tr>
</table>

License 申请通过后，License PID 会关联到你的 CID 下，你可以在 [控制台](https://console.agora.io/license/usage) 的 License 用量页面查看一批 License 的 [PID](#pid) 和其下每个 License 的 [LicenseValue](#licensevalue)。

![](placeholder - PID 和 LicenseValue 的截图)


### 2. (可选) 预分配

#### 配额

在激活并使用 License 前，声网支持你调用 [配额接口](./agora_console_license_restapi#配额) 将 License 额度预分配给不同的 App ID。如果不配额，则所有 App ID 共享 License 额度，先到先得。

**例**：  
CID 下关联两批 License (PID 1、PID 2) 并创建三个启用 License 功能的项目 (AppID 1、AppID 2、AppID 3)，现将 PID 1 下的两个 License 预分配给 AppID 1。如下图所示：

![](https://web-cdn.agora.io/docs-files/1659519261486)

此时，未配额的 License，即：PID 1 下的一个 License 和 PID 2 下的三个 License，被 AppID 1、AppID 2、AppID 3 共享；而已配额的 License，即：PID 1 下的两个 License 额度仅供 AppID 1 使用。

#### 查询配额

你可以调用 [查询配额接口](./agora_console_license_restapi#查询配额) 查看 License 的分配情况。


### 3. (可选) 预授权

#### 开启预授权

在激活并使用 License 前，声网支持你调用 [开启预授权接口](./agora_console_license_restapi#开启预授权) 为 App ID 启用预授权功能。该功能开启后，仅在白名单内的 [LicenseKey](#licensekey) 可以进行激活操作。如不启用预授权功能，则全部 LicenseKey 均可以激活 License。

<div class="alert note">再次调用该接口即可关闭预授权功能。</div>

#### 添加预授权

启用预授权后，你可以调用 [上传预授权文件接口](./agora_console_license_restapi#上传预授权文件) 将 LicenseKey 批量添加至白名单，或调用 [增加单个预授权接口](./agora_console_license_restapi#增加单个预授权) 将单个 LicenseKey 添加至白名单。

#### 移除预授权

你可以调用 [删除预授权接口](./agora_console_license_restapi#删除预授权) 移除部分白名单中的 LicenseKey。如需清空全部预授权设置，可调用 [清空预授权接口](./agora_console_license_restapi#清空预授权)。

#### 查询预授权

你既可以 [查询单个预授权设置](./agora_console_license_restapi#查询单个预授权)，也可以 [查询](./agora_console_license_restapi#查询预授权) 和 [导出](./agora_console_license_restapi#导出预授权) 全部预授权设置。


### 4. 激活

完成预授权和预分配后，你可以调用 [激活接口](./agora_console_license_restapi#激活) 将 License 关联到设备或账号。
<div class="alert note">License 的有效期从激活开始计算。</div>


### 5. 申请续期

当 License 过期或即将过期时，你可以联系 [声网销售](mailto:sales@agora.io) 申请续期并提供以下信息：
| 名称 | 说明 |
|:---|:---|
| CID | 声网分配给每个企业 (组织) 的唯一标识。 |
| PID | 为 CID 下的指定 PID 续期。 |
| App ID | (可选) 仅指定的 App ID 享有续期额度。如不指定 App ID，则 CID 下的全部 App ID 共享续期额度。 |
| 申请数量 | 续期的 License 数量。 |

License 续期申请通过后，续期额度会关联到 PID 下，你可以在 [控制台](https://console.agora.io/license/usage) 的 License 购买记录页面查看 [renew PID](#renew-pid)。

![](https://web-cdn.agora.io/docs-files/1659586752602)


### 6. 续期

续期申请通过后，你可以调用 [续期接口](./agora_console_license_restapi#续期) 对即将过期或已过期的 License 进行续期操作。


### 7. 查询

开通 License 功能后，你可以在控制台查看 License 的使用情况。具体步骤如下：

1. 登录 [控制台](https://console.agora.io/)。

2. 点击右上角的账号名，选择下拉菜单中的 **License**。

![](https://web-cdn.agora.io/docs-files/1658917397547)

3. 进入 **License** 页面后，你可以在 **用量查看** 和 **购买记录** 页签查看 License 的使用情况。

![](https://web-cdn.agora.io/docs-files/1659089165706)

![](https://web-cdn.agora.io/docs-files/1658918100541)




## 主要概念

### PID 和 Renew PID

#### PID

PID 是由 SKU、有效期、品类 (账号 License 或设备 License) 定义的 License 标识。

无论 License 的申请数量和申请批次，只要 SKU、有效期、品类不变，申请的 License 均归属于同一个 PID。License [申请](#1-申请) 通过后，你可以在 [控制台](https://console.agora.io/license/usage) 的 License 用量页面查看一批 License 的 PID 和其下每个 License 的 LicenseValue。

接下来，你可以调用 [激活接口]() 将 PID 下的 License 额度关联给指定账号或设备。

#### 续期 PID (renewPID)

renewPID 是基于 PID 的 License 续期额度标识。

当 PID 下的 License 过期或即将过期时，你可以为该 PID 申请续期额度。License [续期申请](#5-申请续期) 通过后，以 renewPID 为标识的续期额度会被关联至 PID。你可以在 [控制台](https://console.agora.io/license/purchase) 的 License 购买记录页面看到 PID 和其下关联的 renewPID。

接下来，你可以调用 [续期接口]() 将 renewPID 的 License 额度续给过期或即将过期的 License。


### LicenseKey 和 License Value

#### LicenseValue

LicenseValue 是每个 License 的标识。

你可以在控制台 的 License 用量页面查看每个 License 的 LicenseValue 及其分配、激活、过期情况。

#### LicenseKey

LicenseKey 是账号 ID 或设备 ID。用户为某个账号或设备激活 License 时，传入 LicenseKey 消耗一个 License。此外，用户可以执行预授权操作，仅在白名单中的 LicenseKey 可以通过校验激活 License。