为了保障 RTMP 网关功能的可靠性，声网建议你参考本文档集成 RTMP 网关功能。阅读本文档前，建议你参考 [RTMP 网关功能使用说明](restapi)了解 RTMP 网关功能使用的基础流程。

## 前提条件

开始使用前，你需要[联系技术支持](/cn/Agora%20Platform/ticket)开通 RTMP 网关功能。

## 限制条件

### API 调用限制

声网服务器限制 RTMP 网关 API 调用速率，超出限制速率时会返回状态码 `429(Too Many Requests)`。如果你有更高调用速率需求，请[联系技术支持](/cn/Agora%20Platform/ticket)。

| API      | 限流说明                                                     |
| :------- | :----------------------------------------------------------- |
| `Create` | 一个项目中，创建推流码的速率上限为 50 次/秒。 |
| `Delete` | 一个项目中，销毁推流码的速率上限为 50 次/秒。           |
| `Query`   | 一个项目中，单次查询的速率上限为 100 次/秒。 |
| `Update`   | 一个项目中，设置服务配置的速率上限为 50 次/秒。 |

### 最大并发任务数

最大并发任务数默认为 50，表示允许在一个项目下最多同时推送 50 条 RTMP 流或者 SRT 流。如需更高配额，请[联系技术支持](/cn/Agora%20Platform/ticket)。

## 保障推流服务高可用

为保障推流服务的高可用，避免因区域网络故障造成的服务不可用，声网提供切换域名的方案。

1. 根据你的源流所在地，设置主域名和备份域名：

    | 主域名                       | 备用域名                            | 地理区域    |
    | :--------------------------- | :---------------------------------- | :---------- |
    | `rtls-ingress-cn.agoramdn.com` | `rtls-ingress-backup-cn.agoramdn.com` | 中国大陆    |
    | `rtls-ingress-ap.agoramdn.com` | `rtls-ingress-backup-ap.agoramdn.com` | 除中国大陆以外的亚洲区域 |
    | `rtls-ingress-eu.agoramdn.com` | `rtls-ingress-backup-eu.agoramdn.com` | 欧洲   |
    | `rtls-ingress-na.agoramdn.com` | `rtls-ingress-backup-na.agoramdn.com` | 北美   |

2. 当使用主域名请求失败时，使用该域名重试一次。
3. 如果步骤 2 的重试依然失败，使用备用域名重试。

## 保障 REST 服务高可用

为保障 REST 服务的高可用，避免因区域网络故障造成的服务不可用，声网提供切换域名的方案。

1. 根据你的业务服务器所在地设置主域名：

   - 业务服务器 DNS 地址位于中国大陆时，设置主域名为 `api.sd-rtn.com`。
   - 业务服务器 DNS 地址位于中国大陆以外的国家或地区时，设置主域名为 `api.agora.io`。

2. 当使用主域名发起 RESTful API 请求失败时，使用该域名重试一次。

3. 如果步骤 2 的重试依然失败，使用备用的主域名重试：

   - 如果当前设置的主域名为 `api.sd-rtn.com`，备用的主域名指 `api.agora.io`。
   - 如果当前设置的主域名为 `api.agora.io`，备用的主域名指 `api.sd-rtn.com`。

4. 如果步骤 3 的重试依然失败，使用与当前解析区域相邻的区域域名重试。
   例如，假设你的业务服务器位于欧洲，你设置主域名为 `api.agora.io`，而且业务服务器解析主域名解析到德国。德国位于欧洲中部 `api-eu-central-1.agora.io`，查域名信息表可知，相邻区域为欧洲西部 `api-eu-west-1.agora.io` 或 `api-eu-west-1.sd-rtn.com`。因此，出现网络故障且步骤 2、3 的重试失败时，请使用 `api-eu-west-1.agora.io` 或 `api-eu-west-1.sd-rtn.com` 域名重试。

#### 注意事项

- 为避免重试请求过于频繁，超过声网服务所规定的每秒请求数(QPS)，声网建议你使用退避策略。例如，第一次等待 1 秒后重试，第二次等待 3 秒后重试，第三次等待 6 秒后重试。
- 如果是网络问题而非 DNS 解析域名问题导致的请求失败，声网建议你跳过步骤 3，直接进行步骤 4。
- 切换至区域域名前，请确保 RTMP 网关在该区域有部署服务。目前，中国大陆，除中国大陆以外的亚洲区域，欧洲与北美都已部署。

#### 域名信息

<table>
 <thead>
 <tr>
  <td>主域名</td>
  <td>区域域名</td>
  <td>地理区域</td>
 </tr>
 </thead>
 <tbody>
 <tr>
  <td rowspan=8><code>api.sd-rtn.com</code></td>
  <td><code>api-us-west-1.sd-rtn.com</code></td>
  <td>美国西部</td>
 </tr>
 <tr>
  <td><code>api-us-east-1.sd-rtn.com</code></td>
  <td>美国东部</td>
 </tr>
 <tr>
  <td><code>api-ap-southeast-1.sd-rtn.com</code></td>
  <td>亚太东南</td>
 </tr>
 <tr>
  <td><code>api-ap-northeast-1.sd-rtn.com</code></td>
  <td>亚太东北</td>
 </tr>
 <tr>
  <td><code>api-eu-west-1.sd-rtn.com</code></td>
  <td>欧洲西部</td>
 </tr>
 <tr>
  <td><code>api-eu-central-1.sd-rtn.com</code></td>
  <td>欧洲中部</td>
 </tr>
 <tr>
  <td><code>api-cn-east-1.sd-rtn.com</code></td>
  <td>中国华东</td>
 </tr>
 <tr>
  <td><code>api-cn-north-1.sd-rtn.com</code></td>
  <td>中国华北</td>
 </tr>
 <tr>
  <td rowspan=8><code>api.agora.io</code></td>
  <td><code>api-us-west-1.agora.io</code></td>
  <td>美国西部</td>
 </tr>
 <tr>
  <td><code>api-us-east-1.agora.io</code></td>
  <td>美国东部</td>
 </tr>
 <tr>
  <td><code>api-ap-southeast-1.agora.io</code></td>
  <td>亚太东南</td>
 </tr>
 <tr>
  <td><code>api-ap-northeast-1.agora.io</code></td>
  <td>亚太东北</td>
 </tr>
 <tr>
  <td><code>api-eu-west-1.agora.io</code></td>
  <td>欧洲西部</td>
 </tr>
 <tr>
  <td><code>api-eu-central-1.agora.io</code></td>
  <td>欧洲中部</td>
 </tr>
 <tr>
  <td><code>api-cn-east-1.agora.io</code></td>
  <td>中国华东</td>
 </tr>
 <tr>
  <td><code>api-cn-north-1.agora.io</code></td>
  <td>中国华北</td>
 </tr>
 </tbody>
</table>


## 检查清单

参考以下表格，快速确认每条检查项是否符合集成要求，以保证 RTMP 网关功能的可靠性。

| 序号   | 是否必需 | 检查内容                                                     | 
| :--- | :------- | :----------------------------------------------------------- | 
| 1    | 必需     | 开通 RTMP 网关服务。                                              | 
| 2    | 必需     | 确保一个项目中，API 的调用速率低于最大限制。详见 [API 调用限制](#api-调用限制)。 | 
| 3    | 必需     | 确保一个项目中，并发任务数低于 50。详见[最大并发任务数](#最大并发任务数)。 | 
| 4    | 必需     | <ul><li>设置的 `region` 与你的媒体流源站在同一个区域。</li><li>传入 `region` 值为小写。</li></ul> |
| 5    | 可选     | 如果调用 RESTful API 失败，请按照如下方案进行问题排查：<ul><li>使用退避策略。</li><li>根据[错误码](restapi#状态码汇总表)排查。</li></ul>如果以上排查方法并未解决问题，请打印出响应 Header 中的 `X-Request-ID` 字段值，并联系[声网技术支持](/cn/Agora%20Platform/ticket)。 |
| 6    | 可选     | 如果使用 RTMP/SRT 协议推流失败，请按照如下方案进行问题排查：<ul><li>请检查使用的推流码，是否超过有效期。</li><li>如果使用 OBS 推流软件，请检查丢帧率是否正常。</li></ul>如果以上排查方法并未解决问题，请确认推流域名和推流码，并联系[声网技术支持](/cn/Agora%20Platform/ticket)。 | 

