# 概览

为客户提供贴合场景需求的声网解决方案，避免客户为不需要的功能付费，计费更精准透明，提供license绑定音视频能力的方案。



## 适用场景

- IoT 
- 体制内教育
- RTC / 音视频
- 私有化



## 使用限制

### SKU 能力
仅告警

### License 并发限制 / PCU 限制
告警 & 踢出

### License 合法性校验
是否为空、是否为该appId申请、是否已激活、是否已过期
告警 & 踢出

### 单一 License 分钟数限制
告警 & 踢出

### License 绑定关系校验
一个License只能被一个serviceId使用，多个serviceId登录，FIFO踢出较早serviceId用户
告警 & 踢出

### 使用时间段限制
告警&踢出频道



## 主要概念

### CID  
Agora 分配给每个企业 (组织) 的唯一标识。[注册账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms#%E6%B3%A8%E5%86%8C%E8%B4%A6%E5%8F%B7) 后，你可以在 [Agora 控制台](https://console.agora.io/settings/company) 的设置页面获取该字段。

![](https://web-cdn.agora.io/docs-files/1658829233966)

### App ID  
Agora 分配给每个项目的唯一内部标识。[创建项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E9%A1%B9%E7%9B%AE) 后，你可以在 [Agora 控制台](https://console.agora.io/projects) 的项目管理页面获取该字段。

### SKU  
合同约定的 License 能力集，其中包含 License 能力 (音频、视频、音视频)、License 分钟数上限、 License 使用时间段。SKU 全局唯一。

### PID  
由 SKU、有效期、品类 (账号 License 或设备 License) 定义的 License 标识。License 申请通过后，你可以在 [Agora 控制台] 的 License 页面获取 PID。

无论 License 的申请数量，只要 SKU、有效期、品类不变，[申请]() 的 License 额度均归属于同一个 PID。CID 是 License 额度关联的顶级维度，用户也可以将 PID 下的 License 额度 [分配] 给某个 App ID。

### LicenseKey
账号 ID 或设备 ID。

用户 [激活]() 某个账号或设备时，传入 LicenseKey 消耗一个 License。此外，用户可以进行 [预授权]()，仅在白名单中的 LicenseKey 可以通过校验完成 License 激活。