在 Agora 控制台通过 `fileNamePrefix` 字段配置录制文件存储路径时，你可以使用内置变量来指定动态路径用于存储录制文件。当录制发起时，会用真实的值替换变量。目前支持以下两类变量：

<table>
<thead>
  <tr>
    <th>类型</th>
    <th>变量</th>
    <th>说明</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="2">固定变量</td>
    <td>${appId}</td>
    <td>Agora App ID</td>
  </tr>
  <tr>
    <td>${roomUuid}</td>
    <td>待录制课堂的 Uuid</td>
  </tr>
  <tr>
    <td rowspan="4">日期变量</td>
    <td>${yyyy}</td>
    <td>年</td>
  </tr>
  <tr>
    <td>${MM}</td>
    <td>月</td>
  </tr>
  <tr>
    <td>${dd}</td>
    <td>日</td>
  </tr>
  <tr>
    <td>${yyyyMMdd}、${yyyyMM}、${yyyy-dd}、${MM_dd}</td>
    <td>日期变量可组合，如年月日、年月、年-日、月_日等。</td>
  </tr>
</tbody>
</table>

例如，你将 `fileNamePrefix` 字段设为以下：

```json
"fileNamePrefix": [
  "scenario", 
  "recording",
  "${appId}",
  "${yyyyMM}",
  "${roomUuid}"
]
```

录制存储路径为 `/scenario/recording/xxxxxxxxx/202107/demo/xxxxxxx_demo_0.mp4`。