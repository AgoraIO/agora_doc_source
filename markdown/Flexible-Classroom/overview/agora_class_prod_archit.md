
下图展示了灵动课堂的整体产品架构：

![](https://web-cdn.agora.io/docs-files/1681286316250)

## 基础功能

| <span style="white-space:nowrap;">功能&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span> | 说明                                                         |
| :-------------------- | :-------------------------------- |
| 实时音视频互动           | <ul><li>多人音视频实时互动：支持多人同时开启摄像头，支持标清、高清、全高清画质</li><li>课堂录制：录制教学过程，录制样式可自定义</li><li>屏幕共享：支持将本地电脑桌面、网页窗口、某个应用分享给他人</li><li>上下台：支持连麦互动，学生可自由、平滑上下麦，切换过程无需等待</li><li>截图：截取课堂内画面</li><li>视频墙：老师和助教可以一键开启视频墙，用于课堂老师和学生合影、视频签到、多个学生演讲提问发言场景</li></ul> |
| 实时消息| <ul><li>文字消息：在聊天区域发布聊天内容</li><li>表情包：在聊天区域发布表情</li><li>图片：在聊天区域发布本地图片</li><li>全局禁言：对全体学生进行禁言，学生被禁言后不能在聊天区域，发文本、图片、表情</li><li>公告：在聊天区域中发布公告提醒</li></ul> |
| 互动白板 | <ul><li>支持画笔、文本框、图形、橡皮擦、分页、激光笔、撤销、重做等功能。</li><li>支持将板书以 JPG 格式保存到本地。</li><li>PC 端支持将本地图片拖动到白板区域后插入。</li></ul> |
| 课件管理| 老师可以在课堂中上传本地或在线课件供教学使用。支持的文件格式包含：PPT、PPTX、DOC、DOCX、PDF、MP3、MP4、PNG、JPG、GIF。 |
| 互动教学道具 | <ul><li>课堂奖励：老师可在上课过程中授予学生星星、奖杯等形式的奖励。</li><li>答题器：适用于课堂中老师提问、全班学生一起答题的场景。老师端可在答题器中添加或减少选项数量并设置正确选项，然后发起答题。答题结束后，可统计并展示提交人数和正确率。</li><li>投票器：适用于课堂中老师向全班学生征集意见的场景。老师端可在投票器中设置投票主题、选项以及投票的起始和截止时间，然后发起投票。投票结束后，可统计并展示投票结果。</li><li>倒计时：老师可在工具箱中打开倒计时工具并设置倒计时数值。老师点击开始倒计时后学生端会出现倒计时面板。</li><li>分组讨论：小班课中支持手动分组（老师手动将每个学生分配至各个小组）和自动分组（老师设置小组数量后，系统随机将全班学生平均分配给各个小组）。一个课堂支持最多 20 个小组，每组最多 17 人。小组内支持实时音视频、实时消息、白板、屏幕共享等功能。分组讨论过程中，老师和助教可以随意进出各个小组。老师可发送全员消息。</li><li>远程控制：支持 Electron 端老师在一对一和小班课场景中授权学生远程控制老师的电脑。</li></ul> |
| 设备状态 |<ul><li>网络状态</li><li>网络延迟</li><li>丢包率</li></ul> |
| 美颜|配置美颜特效，提供特效滤镜、虚拟背景等能力。 |
| 降噪 | 开启杂音消除能力|

## 进阶功能

<table>
<thead>
  <tr>
    <th>模块</th>
    <th>功能</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="9">房间</td>
    <td>配置房间自定义属性，用于实现房间层级的个性化业务需求，例如可在课程中添加课间休息状态。详见<a href="faq/agora_class_custom_properties">如何设置自定义用户属性和课堂属性？</a>。</td>
  </tr>
  <tr>
    <td>配置课堂开始时间，适用于提前排课、课堂到点自动开始的场景。详见 <a href="agora_class_api_ref_web#launchoption">LaunchOption</a> 中的 <code>startTime</code> 字段说明。</td>
  </tr>
  <tr>
    <td>配置课堂持续时间，适用于提前排课、课堂到点自动结束的场景。详见 <a href="agora_class_api_ref_web#launchoption">LaunchOption</a> 中的 <code>duration</code> 字段说明。</td>
  </tr>
  <tr>
    <td>配置拖堂时间。拖堂时长后，房间关闭，房间里的用户会立即被踢出房间，其它用户无法也再加入该房间。详见 <a href="agora_class_restful_api#%E5%88%9B%E5%BB%BA%E6%88%BF%E9%97%B4">创建课堂</a> 中的 <code>roomProperties.schedule.closeDelay</code> 字段说明。</td>
  </tr>
  <tr>
    <td>配置上讲台学生人数上限。默认情况下，同时上讲台人数最多 6 人。</td>
  </tr>
  <tr>
    <td>配置学生举手人数上限。默认情况下，同时举手人数默认最多 10 人。详见 <a href="agora_class_restful_api#%E5%88%9B%E5%BB%BA%E6%88%BF%E9%97%B4">创建课堂</a> 中的 <code>roomProperties.processes.handsUp.maxAccept</code> 字段说明。</td>
  </tr>
  <tr>
    <td>配置学生进入教室后是否默认直接上讲台。</td>
  </tr>
  <tr>
    <td>配置区域，用于确保教室所在区域和用于存储课件及录制文件的 OSS 所在区域保持一致。详见 <a href="agora_class_api_ref_web#configparams">ConfigParams</a> 参数说明。</td>
  </tr>
  <tr>
    <td>支持课中事件监听，实时同步课堂内发生的事件。详见<a href="agora_class_restful_api#%E4%BA%8B%E4%BB%B6%E5%90%8C%E6%AD%A5">事件同步</a>。</td>
  </tr>
  <tr>
    <td rowspan="5">用户</td>
    <td>配置用户自定义属性，用于设置头像、年龄等属性。详见<a href="faq/agora_class_custom_properties">如何设置自定义用户属性和课堂属性？</a>。</td>
  </tr>
  <tr>
    <td>用户列表。展示课堂中所有用户的上下台状态、摄像头状态、麦克风状态、奖励个数等信息。</td>
  </tr>
  <tr>
    <td>自定义奖励。</td>
  </tr>
  <tr>
    <td>指定学生上讲台发言。</td>
  </tr>
  <tr>
    <td><a href="agora_class_restful_api#%E8%B8%A2%E4%BA%BA">踢人</a>。</td>
  </tr>
  <tr>
    <td rowspan="3">流</td>
    <td>配置视频编码属性（码率、分辨率和镜像模式）。详见 <a href="agora_class_api_ref_web#eduvideoencoderconfiguration">EduVideoEncoderConfiguration</a>。</td>
  </tr>
  <tr>
    <td>加密音视频流。详见 <a href="agora_class_api_ref_web#mediaencryptionconfig">MediaEncryptionConfig</a>。</td>
  </tr>
  <tr>
    <td>配置发流权限。</td>
  </tr>
  <tr>
    <td rowspan="3">设备和媒体</td>
    <td>开关和检测音视频设备（耳机、麦克风）。</td>
  </tr>
  <tr>
    <td>控制视频渲染。</td>
  </tr>
  <tr>
    <td>控制音频播放。</td>
  </tr>
  <tr>
    <td rowspan="3">UIKit/UIStore</td>
    <td>配置多语言。详见<a href="faq/language">灵动课堂如何支持多语言？</a>。 </td>
  </tr>
  <tr>
    <td>调整教室布局。详见<a href="agora_class_custom_ui_web#修改白板布局比例">自定义课堂 UI</a>。</td>
  </tr>
  <tr>
    <td>修改课堂颜色。详见<a href="agora_class_custom_ui_web#修改教室背景色">自定义课堂 UI</a>。</td>
  </tr>
  <tr>
    <td>Widget</td>
    <td>用于实现可插拔的自定义插件，如互动白板、答题器、倒计时。详见<a href="agora_class_widget_web">自定义插件</a>。</td>
  </tr>
  <tr>
    <td rowspan="3">录制</td>
    <td>配置录制视频分辨率。详见<a href="agora_class_restful_api#%E8%AE%BE%E7%BD%AE%E5%BD%95%E5%88%B6%E7%8A%B6%E6%80%81">设置录制状态</a> 中的 <code>webRecordConfig</code> 字段说明。</td>
  </tr>
  <tr>
    <td>配置录制文件存储地址。详见<a href="agora_class_restful_api#%E8%AE%BE%E7%BD%AE%E5%BD%95%E5%88%B6%E7%8A%B6%E6%80%81">设置录制状态</a> 中的 <code>webRecordConfig</code> 字段说明。</td>
  </tr>
  <tr>
    <td>配置录制启动时间和结束时间。详见<a href="agora_class_restful_api#%E8%AE%BE%E7%BD%AE%E5%BD%95%E5%88%B6%E7%8A%B6%E6%80%81">设置录制状态</a> 中的 <code>webRecordConfig</code> 字段说明。</td>
  </tr>
</tbody>
</table>